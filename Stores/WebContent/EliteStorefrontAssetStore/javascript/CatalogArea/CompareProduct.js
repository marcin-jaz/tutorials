//-----------------------------------------------------------------
// Licensed Materials - Property of IBM
//
// WebSphere Commerce
//
// (C) Copyright IBM Corp. 2008, 2009 All Rights Reserved.
//
// US Government Users Restricted Rights - Use, duplication or
// disclosure restricted by GSA ADP Schedule Contract with
// IBM Corp.
//-----------------------------------------------------------------

	/** 
	 * @fileOverview This file contains all the global variables and JavaScript functions needed by the compare product page and compare zone. 
	 * This JavaScript is used by CompareProductDisplay.jsp and CompareZoneDisplay.jspf files.
	 * @version 1.0
	 */

	/**
	 * @class The functions defined in the class are used for comparing the product's attributes. 
	 *
	 * This compareProductJS class defines all the variables and functions for the page that uses the compare functionality in the store.
	 * The compare zone in the right side bar is a place holder that accepts a maximum of 4 products to compare.
	 * The compare product display page compares the various product's attribute and displays the results side by side.
	 *
	 */
	compareProductJS={
		/* Global variables used in the CompareProductDisplay page */
		
		/** The compareCounter is an integer to store the number of items allowed in the compare page or the compare zone. */
		compareCounter:0,

		/** The compareCounter is an integer to store the number of items that needs to be displayed in a row in the compare zone. */
		compareRowCounter:0,

		/** The compareItemCatEntry is an object to store the catentry items. */
		compareItemCatEntry:new Object(),
		
		/** The langId is a string to store the current language identifier of the store. */
		langId: "-1",

		/** The storeId is a string to store the current store identifier of the store. */
		storeId: "",

		/** The catalogId is a string to store the current catalog identifier of the store. */
		catalogId: "",

		/** The properties is an object to store the properties in the form of name/value pair. */
		properties: new Object(),

		/** The errorMessages is an object to store the error messages.*/
		errorMessages: new Object(),
		
			
		/**
		* This function sets the common parameters used in all service calls like langId, storeId and catalogId.
		* @param {string} langId the langugae identifier to use.
		* @param {string} storeId the store identifier to use.
		* @param {string} catalogId the catalog identifier to use.
		*/
		setCommonParameters:function(langId,storeId,catalogId){
			this.langId = langId;
			this.storeId = storeId;
			this.catalogId = catalogId;
		},

		/**
		* This function sets the error message value to the specified key.
		* @param {string} key the key to error message.
		* @param {string} value the error message.
		*/
		setErrorMessage : function(key, value){
			this.errorMessages[key] = value;
		},
		
		/**
		* This function gets the error message for the key provided.
		* @param {string} key the key to error message.
		* @return {string} value the error message.
		*/
		getErrorMessage : function(key){
			var value = this.errorMessages[key];
			if(value == null)
				value = "Could not get the message value for specified key " + key;
			
			return value;
		},

		/**
		* This function sets property value for given name in compareProductJS, this property can be used in other functions.
		* @param {string} name the name of the property.
		* @param {string} value value of the property.
		*/
		setProperty:function(name,value){
			this.properties[name]=value;
		},
		
		/**
		* This function returns property value for given property name.
		* @param {string} name the name of the property.
		* @return {string} value value of the property.
		*/
		getProperty:function(name){
			return this.properties[name];
		},
		
		/**
		* This function returns the storageKey. It is a combination of storageKey identifier and the sessionCode.
		* @return {string} storageKey value of storage key.
		*/		
		getStorageKey:function(){
			var storageKey = "CompareItems"+this.storeId;
			var sessionId = this.getProperty("sessionId");
			var sessionCode = 0;
			storageKey = storageKey + sessionCode;
			return storageKey;
		},
				
  	/**
		* This function loads the storage key.
		* @param {string} key the storage key.
		*/
		load: function(key){
			if(key == null || typeof key == "undefined" || key == ""){
				alert("Please provide a key");
				return;
			}
			return this._load(key);
		},
	
		/**
		* This function loads the storage key and it's value.
		* @param {string} key the storage key.
		* @param {string} value value of the storage key.
		*/
		save: function(key, value){
			if(key == null || typeof key == "undefined" || key == ""){
				alert("Please provide a key");
				return;
			}
			
			if(value == null || typeof value == "undefined" || value == ""){
				alert("Please provide a key value");
				return;
			}
			this._save(key, value)
			
		},
	
		/**
		* This function clears the items in the compare zone.
		*/
		clear: function(){
			if(this.compareCounter!=0){
				MessageHelper.hideAndClearMessage();
			}
			if(this.currentProvider == "flash"){
				dojo.storage.clear();
			}else{
				if(this.compareCounter > 0) {
					/* We'll be using cookies inplace of dojo.storage. */
					var storageKey=this.getStorageKey();
					dojo.cookie(storageKey,null);
					this.initializeCompare();
					var form=document.getElementById("CompareForm");
					var compare = document.getElementById("compareZone");
					
					var childNodes = compare.childNodes;
					for (i=0; i<childNodes.length; i++) {
							compare.removeChild(childNodes[i]);
					}
				
	
					var div1=document.createElement("div");
					div1.setAttribute("id", "compareDropZoneImg");
					div1.setAttribute("class", "items");						
					div1.innerHTML=form.clearMsg.value;
	
					var div2 = document.createElement("div");
					div2.innerHTML = "&nbsp;";
					div1.appendChild(div2);
					compare.appendChild(div1);
	
					document.getElementById("compareDropZoneImg").style.padding='5px';
	
					if(document.getElementById("compareProductPage") != null && document.getElementById("compareProductPage") != 'undefined'){
						if(document.getElementById("compareProductPage").value){
							var url = document.CompareForm.action + "?storeId=" + document.CompareForm.storeId.value + "&catalogId=" + document.CompareForm.catalogId.value +
							"&langId=" + document.CompareForm.langId.value + "&categoryId= ";
							document.location.href=url;
						}
					}
					MessageHelper.displayStatusMessage(MessageHelper.messages["COMPARE_ITEMS_CLEAR"]);
				}
				
			}
		},
	
		/**
		* This function removes the entry specified by the storage key from the cache.
		* @param {string} key the storage key.
		*/
		remove: function(key){
			if(this.currentProvider == "flash"){
				dojo.storage.remove(key);
			}
			else{
				var storageKey= this.getStorageKey();
				var result = this.load(storageKey);
				if(result != null){
				this.compareItemCatEntry=result;
				}
				delete this.compareItemCatEntry[key];
				this.save(storageKey,this.compareItemCatEntry);
				this.compareProducts();
				
			}
		},

		/**
		* This function saves the storage key and it's value.
		* @param {string} key the storage key.
		* @param {string} value value of the storage key.
		* @param {string} days atributes to cookie.
		* @param {string} path atributes to cookie.
		* @param {string} domain atributes to cookie. 
		* @param {string} secure atributes to cookie.
		* @param {string} clearCurrent atributes to cookie.
		*/
		_save: function(key, value, days, path, domain, secure, clearCurrent){
			if(this.currentProvider == "flash"){
				var self = this;
				var saveHandler = function(status, keyName){
					if(status == dojo.storage.FAILED){
						alert("You do not have permission to store data for this web site. "
							+ "Press the Configure button to grant permission.");
					}else if(status == dojo.storage.SUCCESS){
	
					}
				};
				try{
					dojo.storage.put(key, value, saveHandler);
				}catch(exp){
					alert(exp);
				}
			}
			else{
				/* We'll be using cookies inplace of dojo.storage. */
				value=dojo.toJson(value);
				dojo.cookie(key, value, days, path, domain, secure, clearCurrent);
						
			}
		},
	
		/**
		* This function loads the storage key.
		* @param {string} key the storage key.
		*/
		_load: function(key){
		if(this.currentProvider == "flash"){
				var results = dojo.storage.get(key);
				return results;
			}
			else{
				/* We'll be using cookies inplace of dojo.storage. */
				var value = dojo.cookie(key);
				value = dojo.fromJson(value);
				return value;
			}
		},
		
		/**
		* This function initializes the compare zone and helps to displays the items in the compare zone.
		*/
		initializeCompare:function(){
			var storageKey = this.getStorageKey();
				this.compareCounter=0;
				this.compareRowCounter=0;
				this.compareItemCatEntry=new Object();

				/* Load the compare items from dojo.storage using 'CompareItems' key. */
				var result = this.load(storageKey);
				if(result != null){
					this.compareItemCatEntry = result;
				}
				var compare = document.getElementById("compareZone");
				/* Remove the existing items from the compare zone. */
				var childNodes = compare.childNodes;
				for (i=0; i<childNodes.length; i++) {
					if (childNodes[i].id != "compareDropZoneImg") {
						compare.removeChild(childNodes[i]);
					}
				}
				var firstItem = true;
				/* Add the new items to the compare zone. */
				for(catEntryIdentifier in this.compareItemCatEntry){

					this.compareCounter++;
					if (this.compareCounter <= 4) {
						var catentryAddedToCompare = document.CompareForm.catentryId[this.compareCounter-1].value = catEntryIdentifier;
				
						for (i=0; i<childNodes.length; i++) {
							if (childNodes[i].id == "compareDropZoneImg") {
								compare.removeChild(childNodes[i]);
							}
						}
					/* Build the inner HTML to display the items in the compare zone. */
						var td1 = document.createElement("td");
						td1.setAttribute("id", "compareCatentry"+catentryAddedToCompare);

						var div2 = document.createElement("div");
						div2.setAttribute("id", "compareCatentryContainer"+catentryAddedToCompare);
						
						td1.appendChild(div2);
						
						/* Get the content of the TD from this.compareItemCatEntry variabale which was populated with
						values stored into dojo.storage under 'CompareItems' key. */
						div2.innerHTML = this.compareItemCatEntry[catEntryIdentifier];
						var node = dojo.query(':first-child',div2);
					
						if (((this.compareCounter-1) % 4) == 0 ) {
							this.compareRowCounter++;
							
							var tr1 = document.createElement("tr");
							tr1.setAttribute("id", "compareRow"+this.compareRowCounter);
						} else {
							var tr1 = document.getElementById("compareRow"+this.compareRowCounter);
						}
						tr1.appendChild(td1);
						
						if (firstItem) {
							var div1=document.createElement("div");
							div1.setAttribute("id","compareDropZoneImgDiv");
							div1.style.width ="100%";
							var table1 = document.createElement("table");
							
							var tbody1 = document.createElement("tbody");
							tbody1.setAttribute("id", "compareItemsTable");
							table1.appendChild(tbody1);
							
							tbody1.appendChild(tr1);
							div1.appendChild(table1);
							compare.appendChild(div1);
						} else {
							var tbody1 = document.getElementById("compareItemsTable");
							tbody1.appendChild(tr1);
						}

						firstItem = false;
						
					}

				}
					
		},
		
		/**
		* This function adds an item to the compare zone.
		* @param {string} catEntryIdentifier the CatEntryIdentifier of the item.
		* @param {string} dragImagePath the image path to display the image in the compare zone.
		* @param {string} url Item URL to display it's details.
		* @param {string} dragImageDescription dragImageDescription to display the description of the image in the compare zone.
		*/
		Add2CompareAjax:function(catEntryIdentifier, dragImagePath , url,dragImageDescription){
			MessageHelper.hideAndClearMessage();
			var storageKey = this.getStorageKey();
			if(catEntryIdentifier in this.compareItemCatEntry || catEntryIdentifier == null){
				MessageHelper.displayErrorMessage(MessageHelper.messages["COMPARE_ITEM_EXISTS"]);
			}else{
				this.compareCounter++;
				if (this.compareCounter <= 4) {
					document.CompareForm.catentryId[this.compareCounter-1].value = catEntryIdentifier;
					var _id = "Compare_Item_"+catEntryIdentifier;
					var itemHTML = ""	
							+"	<a id='imgcatBrowse"+ _id + "' href='"+ url +"' >\n"
							+"		<img width='40' height='40' src='"+ dragImagePath +"' alt='"+ dragImageDescription +"' border='0' />\n"
							+"	</a>\n"

					/* Save the compare items into dojo.storage under 'CompareItems' key, so that we can later retrive it. */
					itemHTML = itemHTML.replace(/\"/g,"'").replace(/\r|\n|\r\n|\n\r/g, "");
					this.compareItemCatEntry[catEntryIdentifier] = itemHTML;
					this.save(storageKey, this.compareItemCatEntry, -1);
					/* initialize the compare pane with all the items. */
					this.initializeCompare();

				if(document.getElementById("compareProductPage") != null && document.getElementById("compareProductPage") != 'undefined'){
					if(document.getElementById("compareProductPage").value){
						this.compareProducts();
					}
				}
					MessageHelper.displayStatusMessage(MessageHelper.messages["COMPAREZONE_ADDED"]);
				} else {
					MessageHelper.displayErrorMessage(MessageHelper.messages["COMPATE_MAX_ITEMS"]);
				}
			}
		},

		/**
		* This function calls the compare page that compares the products side-by-side.
		*/
		compareProducts:function(){
			var storageKey = this.getStorageKey();
			/* Load the compare items from dojo.storage using 'CompareItems' key. */
			var result = this.load(storageKey);
			if(result != null){
				this.compareItemCatEntry = result;
			}
			/* If the "CompareZone" is included in the current page then reflects back the updation to the compare product page to the compare zone. */
			if(document.CompareForm!=null && document.CompareForm!='undefined'){
				var url = "CompareProductsDisplay?storeId=" + document.CompareForm.storeId.value + "&catalogId=" + document.CompareForm.catalogId.value +
				"&langId=" + document.CompareForm.langId.value + "&categoryId=" + document.CompareForm.categoryId.value + "&top=" + document.CompareForm.top.value;
			}
			else{
				/* Else update only the compare product page. */
				var url = "CompareProductsDisplay?storeId=" + this.storeId + "&catalogId=" + this.catalogId + "&langId=" + this.langId;
			}
			

			for(catEntryIdentifier in this.compareItemCatEntry){
				url = url + "&catentryId=" + catEntryIdentifier;
			}
			/* Update the location to the compare product after deletion of the product from the compare products page. */
			document.location.href = getAbsoluteURL() + url;
		},
		
		/**
		* This function initializes the compare zone as a dojo drop target and loads the product images for all the products in the compare zone during page load.
		*/
		init:function(){
			dojo.subscribe("/dnd/drop", function(source, nodes, copy, target){
				target.deleteSelectedNodes();
				var productDisplayPath="";
				var imgPath="";
				var imgDescription="";
				if(target.parent.id=='compareZone'){
	  			    var indexOfIdentifier = source.parent.id.indexOf("_",0);
	                if ( indexOfIdentifier >= 0) {
				        /* remove the prefix including the "underscore". */
					    source.parent.id = source.parent.id.substring(indexOfIdentifier+1);					
	                }
					if(document.getElementById("compareImgPath_"+source.parent.id)!=null && document.getElementById("compareImgPath_"+source.parent.id)!=undefined){
						imgPath = document.getElementById("compareImgPath_"+source.parent.id).value;
					}
					if(document.getElementById("compareProductDetailsPath_"+source.parent.id)!=null && document.getElementById("compareProductDetailsPath_"+source.parent.id)!=undefined){
						productDisplayPath=document.getElementById("compareProductDetailsPath_"+source.parent.id).value;
					}
					if(document.getElementById("compareImgDescription_"+source.parent.id)!=null && document.getElementById("compareImgDescription_"+source.parent.id)!=undefined){
						imgDescription = document.getElementById("compareImgDescription_"+source.parent.id).value;	
					}
					compareProductJS.Add2CompareAjax(source.parent.id,imgPath,productDisplayPath,imgDescription);
				}
			});
		}
	}	
	
