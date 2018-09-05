/* Copyright IBM Corp. 2010-2014 All Rights Reserved. */

(function()
{

	var linkParser = function( ) {			
			var parts = null;
			var ndlCandidateRegExp = /NDL.+REPLICA.+/;		//catch links to applications. views and documents 
			
			var linkType;			
			
			var docLinkpattern = '(.+[^<])<.+&lt;NDL&gt;'
				+ '.*REPLICA\\s([0-9A-F]{8}):([0-9A-F]{8})'
				+ '.+VIEW OF([0-9A-F]{8}):([0-9A-F]{8})-ON([0-9A-F]{8}):([0-9A-F]{8})'
				+ '.+NOTE OF([0-9A-F]{8}):([0-9A-F]{8})-ON([0-9A-F]{8}):([0-9A-F]{8})'
				+ '(.+HINT&gt;CN=(\\w+)\\/)?'; // The server name.
				
			var viewLinkpattern = '(.+[^<])<.+&lt;NDL&gt;'
				+ '.*REPLICA\\s([0-9A-F]{8}):([0-9A-F]{8})'
				+ '.+VIEW OF([0-9A-F]{8}):([0-9A-F]{8})-ON([0-9A-F]{8}):([0-9A-F]{8})'
				+ '(.+HINT&gt;CN=(\\w+)\\/)?'; // The server name.
											
			var appLinkpattern = '(.+[^<])<.+&lt;NDL&gt;'
				+ '.*REPLICA\\s([0-9A-F]{8}):([0-9A-F]{8})'
				+ '(.+HINT&gt;CN=(\\w+)\\/)?'; // The server name.
			
			var docLinkRegExp = null,
				viewLinkRegExp = null,
				appLinkRegExp = null;

			return {
				parse: function(linkText) {
					
					parts = null;		//resetting parts
					
					// Perform a quick check to determine if the text should be fully parsed.
					if (!ndlCandidateRegExp.test(linkText)) {
						return false;
					}
					
					if (docLinkRegExp === null) {
						docLinkRegExp = new RegExp(docLinkpattern);
					}
					
					if (viewLinkRegExp === null) {
						viewLinkRegExp = new RegExp(viewLinkpattern);
					}
					
					if (appLinkRegExp === null) {
						appLinkRegExp = new RegExp(appLinkpattern);
					}
					
					if (!docLinkRegExp.test(linkText) && !viewLinkRegExp.test(linkText) && !appLinkRegExp.test(linkText)) {
						return false;
					}

					if (docLinkRegExp.test(linkText) ){
						linkType = 0;
						parts = docLinkRegExp.exec(linkText);
					}else if (viewLinkRegExp.test(linkText) ){
						linkType = 1;
						parts = viewLinkRegExp.exec(linkText);
					}else if (appLinkRegExp.test(linkText) ){
						linkType = 2;
						parts = appLinkRegExp.exec(linkText);
					}
					
					return parts !== null;
				},
				
				createLink: function (linkText){
					var link;
					if (linkType == 0){		//doc link
						link = '<a href="Notes://' + linkParser.getServer()
								+ '/' + linkParser.getReplica()
								+ '/' + linkParser.getView()
								+ '/' + linkParser.getNote() 
								+ '">'
								+ linkParser.getName() 
								+ '</a>';
					}else if (linkType == 1){	//view link
							link = '<a href="Notes://' + linkParser.getServer()
								+ '/' + linkParser.getReplica()
								+ '/' + linkParser.getView()
								+ '">'
								+ linkParser.getName() 
								+ '</a>';
					}else if (linkType == 2){	//app link
						link = '<a href="Notes://' + linkParser.getServer()
								+ '/' + linkParser.getReplica()
								+ '">'
								+ linkParser.getName() 
								+ '</a>';
					}
					return link;
				},
						
				getReplica: function( ) {
					return parts[2] + parts[3];
				},
				getName: function( ) {
					var name = parts[1];
					return name.replace(/&nbsp;/g, '').replace(/^\s+|\s+$/g, '');
				},
				getView: function( ) {
					return parts[4] + parts[5] + parts[6] + parts[7];
				},
				getNote: function( ) {
					return parts[8] + parts[9] + parts[10] + parts[11]
				},
				getServer: function( ) {
					if (linkType == 0){		//doc link
						return (parts[13] === undefined ? '' : parts[13]);
					}else if (linkType == 1){	//view link
						return (parts[9] === undefined ? '' : parts[9]);
					}else if (linkType == 2){	//application link
						return (parts[5] === undefined ? '' : parts[5]);
					}
				}
			};
		}();

	CKEDITOR.plugins.add('ibmpastenotesdatalink', {

		init : function(editor)	{
		
			editor.on('paste', function(evt) {			
				var data = evt.data;
				if (data.type == 'html'	){
					var linkText = data.dataValue;
					if (linkParser.parse(linkText)) {
						data.dataValue = linkParser.createLink(linkText);
					}
				}
			});
		},
		linkParser : linkParser			//exposes linkParser as an available object on the ibmpastenotesdatalink plugin
	});
})();
