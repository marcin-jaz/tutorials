﻿﻿﻿﻿﻿﻿﻿﻿﻿﻿﻿﻿﻿﻿﻿/* Copyright IBM Corp. 2010-2014 All Rights Reserved.        */

CKEDITOR.plugins.add('ibmbinaryimagehandler', {
	lang: 'ar,ca,cs,da,de,el,en,es,fi,fr,he,hr,hu,it,iw,ja,kk,ko,nb,nl,no,pl,pt,pt-br,ro,ru,sk,sl,sv,th,tr,uk,zh,zh-cn,zh-tw',
	init : function(editor)	{
	
		var imgRexExp = /<img[^>]*>/i;

		// test that config.ibmBinaryImageUploadUrl is not empty and not whitespace or config.ibmPublishBinaryData defined
		if((/\S/.test(editor.config.ibmBinaryImageUploadUrl) || editor.config.ibmPublishBinaryData) && !editor.config.ibmFilterPastedDataUriImage) {
		
			//add a hidden iframe to the document which will be used to post the image data uri
			var iframe = document.createElement('iframe');
			iframe.style.display = 'none';
			document.body.appendChild(iframe);
			
			//from filebroswer plugin
			function addQueryString( url, params ) {
				var queryString = [];

				if ( !params )
					return url;
				else {
					for ( var i in params )
						queryString.push( i + "=" + encodeURIComponent( params[ i ] ) );
				}
				return url + ( ( url.indexOf( "?" ) != -1 ) ? "&" : "?" ) + queryString.join( "&" );
			}
			
			//read multiple files on drop event
			function setup_reader(file) {
				if (file.type.match('image.*')) {
					var reader = new FileReader();
					reader.onload = function(){
						_html = reader.result;
						if(_html != null) {
							editor.fire( 'paste', { size: file.size, type: file.type, name: file.name, dataValue: "<img src=\""+_html +"\">"});
						}
					};
					reader.readAsDataURL(file);
				}
			}
				
			/**
			 * Callback function which will be invoked when the server responds with an array containing urls to each of the pasted images.
			 * 
			 * Response format: <script type="text/javascript">window.parent.CKEDITOR.tools.callFunction(Callback function, ['http://serverip/image.png', 'http://serverip/image2.png'], '');</script>
			 */
			var insertImageURLForm = CKEDITOR.tools.addFunction( function(url, errorMsg) {
					if (url){			
						//for each url get an element by id and replace the binary content with a new url.
						for (var i=0; i< url.length; i++){
							var slash = url[i].lastIndexOf("/");
							var dot = url[i].lastIndexOf(".");
							var id = url[i].substring(slash+1, dot);
							
							//get image by id
							var image = editor.document.getById(id);
							if(image) {
								image.setAttribute('src', url[i]);
								image.setAttribute('data-cke-saved-src', url[i]);
							}
						}

						editor.fire( 'updateSnapshot' );
					}
				}, this );
				
			/**
			 * Callback function which will be invoked when the server responds with an array containing urls to each of the pasted images.
			 * 
			 * Response format: <script type="text/javascript">window.parent.CKEDITOR.tools.callFunction(Callback function, [urlObj1, urlObj1], '');</script>
			 * where 
			 * urlObj1: [id,'http://serverip/image.png']
			 * urlObj2: [id,'http://serverip/image2.png']
			 * 
			 */
			var insertImageURL = CKEDITOR.tools.addFunction( function(arrayOfUrlObjects, errorMsg) {
					if (arrayOfUrlObjects){			
						//for each url get an element by id and replace the binary content with a new url.
						for (var i=0; i< arrayOfUrlObjects.length; i++){
							var urlObject = arrayOfUrlObjects[i];
							var id = urlObject.id;
							var url = urlObject.url;
							
							//get image by id
							var image = editor.document.getById(id);
							if(image) {
								image.setAttribute('src', url);
								image.setAttribute('data-cke-saved-src', url);
							}
						}

						editor.fire( 'updateSnapshot' );
					}
				}, this );
			
			/**
			 * Callback function which will be invoked when the server responds with an array containing ids of images to be deleted
			 * 
			 * Response format: <script type="text/javascript">window.parent.CKEDITOR.tools.callFunction(Callback function, ['id1', 'id2'], '');</script>
			 */
			var deleteImages = CKEDITOR.tools.addFunction( function(ids, errorMsg) {
					if (ids){			
						//for each id get an element by id and delete it
						for (var i=0; i< ids.length; i++){
							var id = ids[i];
							
							//get image by id
							var image = editor.document.getById(id);
							if(image) {
								//delete image from the page
								image.remove();
							}
						}

						editor.fire( 'updateSnapshot' );
					}
				}, this );
			
				
			//Remove the iframe and the callback funtion when the editor is destroyed
			editor.on('destroy', function(){
				document.body.removeChild(iframe);
			});
		
			// Add a paste event listener to get data uri images from pasted content
			editor.on('paste', function(evt) {
				
				var isDataURIImageRegex = /<img[^>]+src=["']{1}(data:image\/(?:(?!["'])[\w\W])*)["']{1}[^>]*[\/]?>/gi;
				
				var srcRegex = /src=["']data:image\/[^('|")]*["']/i,
					_html = evt.data.dataValue,	
					cd = CKEDITOR.env.ie ? iframe.contentWindow.document : iframe.contentDocument;

				if (isDataURIImageRegex.test(_html)){
				
					var timestamp = new Date().getTime();

					if(editor.config.ibmBinaryImageUploadUrl) {
						//Create a form that will be used to post the binary image data
						var form = document.createElement('form');
						form.enctype ="multipart/form-data";
						form.method = "POST";
						
						//setup params that need to be passed with the POST request
						var params = {};
						params.CKEditor = editor.name;
						params.CKEditorFuncNum = insertImageURLForm;		//callback function that need to be invoked by the response
						params.CKEditorDeleteFuncNum = deleteImages;
						params.Timestamp = timestamp;
						form.action = addQueryString( editor.config.ibmBinaryImageUploadUrl, params );
					}	
															
					var dataUriImages = _html.match(isDataURIImageRegex);
					
					var binaryDataArray = [];
					
					for (var i=0; i<dataUriImages.length; i++){
						//generate an id
						var id = timestamp+'_'+i;
						//get the src attribute and value
						var binarySrc = dataUriImages[i].match(srcRegex);	
						_html = _html.replace(dataUriImages[i], dataUriImages[i].replace('<img','<img id="'+ id + '"'));
						
						if(editor.config.ibmPublishBinaryData){
							//setup params that need to be passed to the backend
							var imageObj=new Object();
							imageObj.data=binarySrc;
							if(evt.data.name){//get image name, type and size only for drag&drop event
								imageObj.name=evt.data.name;
								if(evt.data.size)
									imageObj.size=evt.data.size;
								if(evt.data.type)
									imageObj.type=evt.data.type;
							}
							imageObj.id=id;
						}
						else{
							form.innerHTML += '<input type="text" name="imageUri'+i+'" value='+binarySrc+'>';
						}	

						//create an array of binary data
						binaryDataArray.push(imageObj);
					}

					if(editor.config.ibmPublishBinaryData){
						editor.config.ibmPublishBinaryData(insertImageURL, deleteImages, editor.name, binaryDataArray);//post the binary image data
					}	
					else{
						cd.body.appendChild(form);
						form.submit();	//post the binary image data
					}	
					
					evt.data.dataValue = _html;			//let the paste event continue		
				}
			});
		
			// Add a contentDom event listener to register a drop event each time the document is recreated
			editor.on('contentDom', function(evt) {
				if(CKEDITOR.env.webkit) {
					editor.document.on('paste', function(evt) {
						// Get the items from the clipboard
			      		var items = evt.data.$.clipboardData.items;
			      		if (items) {
			         		// Loop through all items, looking for images
			         		for (var i = 0; i < items.length; i++) {
			            		if (items[i].type.indexOf("image") !== -1) {
			               			var file = items[i].getAsFile();// Get image as a file
			               			evt.data.$.preventDefault();
			               			setup_reader(file);
			            		}
			         		}
		         		}
					});
				}
				// Add a drop event listener to cancel the drop event if the content contains data uri images
				evt.editor.document.on('drop', function (evt) {
					var type = CKEDITOR.env.ie ? 'url' : 'text/html';
					var _html = CKEDITOR.env.ie ? "<img src=\""+evt.data.$.dataTransfer.getData(type) +"\">" : evt.data.$.dataTransfer.getData(type);
					if(CKEDITOR.env.mac){
						//image dragged from the web page
						if(/\S/.test(evt.data.$.dataTransfer.getData('url')))
							_html = "<img src=\""+evt.data.$.dataTransfer.getData('url') +"\">";
						else
							_html = evt.data.$.dataTransfer.getData('text/html');//image from the file system
					}
					var isDataURIImageRegex = /<img[^>]+src=["']{1}(data:image\/(?:(?!["'])[\w\W])*)["']{1}[^>]*[\/]?>/gi;
					if(imgRexExp.test(_html) && isDataURIImageRegex.test(_html)) {//check if image has href://
						// Cannot modify the dataTransfer data on drop, so will call paste event instead to create the url for the binary image.
						evt.data.$.preventDefault();
						editor.fire( 'paste', { dataValue: _html});
					}
					else if (evt.data.$.dataTransfer.files.length > 0) {
						// Cannot modify the dataTransfer data on drop, so will call paste event instead to create the url for the binary image.
						evt.data.$.preventDefault();

						var files = evt.data.$.dataTransfer.files;
						for (var i = 0; i < files.length; i++) {
							var file = files[i];
							if (file.type.match('image.*')) {
								setup_reader(files[i]);
							}
						}
					}
				});
			}); 
		}
	}
});