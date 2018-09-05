//-----------------------------------------------------------------
// Licensed Materials - Property of IBM
//
// WebSphere Commerce
//
// (C) Copyright IBM Corp. 2007, 2009 All Rights Reserved.
//
// US Government Users Restricted Rights - Use, duplication or
// disclosure restricted by GSA ADP Schedule Contract with
// IBM Corp.
//-----------------------------------------------------------------

/**
 *@fileOverview This javascript file defines all the javascript functions used to display
 *and handle the information messages, error messages.
 */

if(typeof(MessageHelper) == "undefined" || !MessageHelper || !MessageHelper.topicNamespace){

/**
 * @class The MessageHelper class contains variables and functions that are used
 * to initialize, display and handle informational and error message.
 */
	MessageHelper = {
		/**A variable that contains all the messages to be displayed*/
		messages: {},
		
		/**
     * internal variable to keep track of the current element id that has
     * an error tooltip assigned to it */
		identifier: "",

    /**
     * returns the current year
     * @return (int) the current year
     */
		getCurrentYear: function(){
			return new Date().getFullYear();
		}, 

     /**
     * returns the current month. January is 1, and December is 12.
     * @return (int) the current month
     */
		getCurrentMonth: function(){
       return new Date().getMonth()+1;
		}, 

     /**
     * returns the current day of the current month, starting from 1.
     * @return (int) the current day
     */
		getCurrentDay: function(){
       return new Date().getDate();
		}, 

    /**
     *
     *summary: retrieves the value of the property from a render context
		 *description: This function retrieves the value of the property whose name is propertName
		 *from the given context.
     *
     * @param (wc.render.Content) content The context in which the properties
     * belong to.
     * @param (string) propertyName The property to be retrieved
		 * @return (string) null if the context is null. undefined if the property is not found.
		 * otherwise, the value of the property int he given context.
     */
		getRenderContextProperty : function(/*wc.render.Context*/context, /*String*/propertyName){
			
			console.debug("enter getRenderContextProperty with propertyName = "+propertyName);
			if(context == null){
				console.debug("context is null. Return null...");
				return null;
			}
			
			var result = context.properties[propertyName]
			console.debug("the found property value is: "+result);
			
			return result;	
		}, 
				
		/**
     * This function is used to initialize the messages object with all the 
     * required messages. It is used to setup a JS object with any key/value.
     * @param (string) key The key used to access this message.
     * @param (string) msg The message in the correct language.
     *
     */
		setMessage:function(key, msg) {
			this.messages[key] = msg;
		},

    /**
     * This function is used to display the error messages to the user. 
     * @param (string msg The error/information message to be displayed
     *
     * @return (element) a HTML element that contains the error message. 
     *
     */
		displayErrorMessage:function(msg){
       
			if(this.messages["ERROR_MESSAGE_TYPE"]!=null && this.messages["ERROR_MESSAGE_TYPE"]!='undefined'){
				var MsgType = this.messages["ERROR_MESSAGE_TYPE"]; 
				msg = MsgType + msg;
			}
			dojo.byId('ErrorMessageText').className = "error_msg";
			dojo.byId('MessageArea').style.display = "block";
			dojo.byId('ErrorMessageText').innerHTML = msg;
			dojo.byId('MessageArea').focus();
			setTimeout("dojo.byId('ErrorMessageText').focus()",2000);
		},

    /**
     * This function is used to display the informative messages to the user.
     * @param (string) msg The status message to be displayed.
     *
     * @return (element) a HTML element that contains the status message.
     */
		displayStatusMessage:function(msg){
			dojo.byId('ErrorMessageText').className = "status_msg";
			dojo.byId('MessageArea').style.display = "block";
			dojo.byId('ErrorMessageText').innerHTML = msg;
			dojo.byId('MessageArea').focus();
			setTimeout("dojo.byId('ErrorMessageText').focus()",2000);
		},

    /**
     * This function is used to hide and clear the message display area in
     * the page.
     */
		hideAndClearMessage:function(){
			dojo.byId('ErrorMessageText').innerHTML = "";
			dojo.byId('MessageArea').style.display = "none";
		},

    /**
     * This function will show the an error message tooltip
     * around the input field with the problem.
     *
     * The function assumes the "serviceResponse" is the
     * JSON object from a WebSphere Commerce exception. The error
     * field is in the serviceResponse.errorMessageParam and the
     * error message is in the serviceResponse.errorMessage.
     *
     * @see MessageHelper.formErrorHandleClient
     * @param (object) serviceResponse The JSON object with the error data.
     * @param (string) formName The name of the form where the error field is.
     * 
     */
		formErrorHandle:function(serviceResponse,formName){

			this.formErrorHandleClient(serviceResponse.errorMessageParam, serviceResponse.errorMessage);

	  	},


		/**
     * This function will show the an error message tooltip
     * around the input field with the problem.
     *
     * This function will check for the emptiness of the required
     * filed and displays the "errorMessage" related to that field as a tooltip.
     * The tooltip will be closed on focus lost.
     *
     * @param (string) id The identifier for the filed in the form.
     * @param (string) errorMessage The message that should be displayed to the user.
     */
		formErrorHandleClient:function(id,errorMessage){
			
			var element = dojo.byId(id);
			if (errorMessage == null){	
				console.debug("formErrorHandleClient: The error message is null.");
				return;
			}
			if(element){
				if (this.identifier != (id + "_tooltip")) {
					this.identifier = id + "_tooltip";
					var node = document.createElement('span');
					var imgDirPath = getImageDirectoryPath();
					if(dojo.isIE < 7)
					{
						node.innerHTML = errorMessage + "<iframe id='errorMessageIFrame' scrolling='no' frameborder='0' src='" + imgDirPath + "images/empty.gif'></iframe>";
					}
					else
					{
						node.innerHTML = errorMessage;
					}											
					var tooltip = new dijit.Tooltip({connectId: [id]}, node);
					tooltip.startup();
					console.log("created", tooltip, tooltip.id);
					element.focus();
					tooltip.open(element); // force to have this for IE if the error is on a link (i.e. <a>)
					dojo.connect(element, "onblur",  tooltip, "close"); // force to have this for IE if the error is on a link (i.e. <a>)
					dojo.connect(element, "onblur",  tooltip, "destroy");
					dojo.connect(element, "onblur",  this, "clearCurrentIdentifier");
					/* Tooltip widget connects onmouseover event of the above element to _onMouseOver function. 
					When tooltip is associated with the dropdown select box, tooltip will be displayed initially next to the 
					select box. But when user expands the dropdown box and moves the mouse over the options in the select box,
					onmouseover event will be triggered which calls _onMouserOver function.._onMouseOver function will display the tooltip
					again next to the cursor. So when user keeps moving the mouse over the options in select box
					the tooltip widget also moves along with the cursor. To avoid this override _onMouseOver function
					with empty implementation. 
					*/
					tooltip._onMouseOver = this.emptyFunc;
				}
			}
		},


		/**
     * This function clears the internal variable that has the element id
     * with the error tooltip.
     * 
     */
		clearCurrentIdentifier:function(){
		
			this.identifier = "";
	  },

     /**
      * This function is used to override any of the default functions
      * associated with the events. Ex: Tooltip widget tracks onMouseOver event
      * and display the tooltip. To remove this association,
      * tooltip widgets onMouseOver function will be overridden by this empty
      * function.
      * 
      * It is an empty implementation which does nothing.
      *
      * @param (string) event  The event which triggers this function. 
      */
	  emptyFunc:function(event){
		 
	  },



    /**
     * Checks whether a string contains a double byte character.
     *
     * @param (string) target the string to be checked
     * @return (boolean) true if target contains a double byte char;
     * false otherwise
     */
		containsDoubleByte:function (target) {
		
				var str = new String(target);
				var oneByteMax = 0x007F;

				for (var i=0; i < str.length; i++){
					chr = str.charCodeAt(i);
					if (chr > oneByteMax) {
						return true;
					}
				}
				return false;
		},

    /**
     * This function validate email address. It does not allow double byte
     * characters in the email address.
     *
     * @return (boolean) true if the email address is valid; false otherwise
     *
     * @param (string) strEmail the email address string to be validated
     */
		isValidEmail:function(strEmail){
			
			if (this.containsDoubleByte(strEmail)){
				return false;
			}
		
			if(strEmail.length == 0) {
				return true;
			} else if (strEmail.length < 5) {
					 return false;
				}else{
					if (strEmail.indexOf(" ") > 0){
								return false;
						}else{
							if (strEmail.indexOf("@") < 1) {
										return false;
								}else{
									if (strEmail.lastIndexOf(".") < (strEmail.indexOf("@") + 2)){
												return false;
										}else{
												if (strEmail.lastIndexOf(".") >= strEmail.length-2){
													return false;
												}
										}
								}
						}
				}
				return true;
		},

		/**
     * This function will check if the number of bytes of the string
     * is within the maxlength specified.
     *
     * @param (string) UTF16String the UTF-16 string
     * @param (int) maxlength the maximum number of bytes allowed in your input
     *
     * @return (boolean) false is this input string is larger than maxlength
		 */
		isValidUTF8length: function(UTF16String, maxlength) {
			if (this.utf8StringByteLength(UTF16String) > maxlength) return false;
			else return true;
		},

    /**
     * This function will count the number of bytes represented in a UTF-8
     * string.
     *
     * @param (string) UTF16String the UTF-16 string you want a byte count of
     * @return (int) the integer number of bytes represented in a UTF-8 string
     */
		utf8StringByteLength: function(UTF16String) {

			if (UTF16String === null) return 0;
			
			var str = String(UTF16String);
			var oneByteMax = 0x007F;
			var twoByteMax = 0x07FF;
			var byteSize = str.length;
			
			for (i = 0; i < str.length; i++) {
				chr = str.charCodeAt(i);
				if (chr > oneByteMax) byteSize = byteSize + 1;
				if (chr > twoByteMax) byteSize = byteSize + 1;
			}  
			return byteSize;
		},

    /**
     * this function will check whether the text is a numeric or not.
     * 
     * @param allowDot is a boolean wich specifies whether to consider
     * the '.' or not.
     *
     * @return (boolean) true if text is numeric
     */
		IsNumeric : function (text,allowDot)
		{
			if(allowDot) var ValidChars = "0123456789.";
			else var ValidChars = "0123456789";
		  
			var IsNumber=true;
			var Char;

		 
			for (i = 0; i < text.length && IsNumber == true; i++) 
			{ 
				Char = text.charAt(i); 
				if (ValidChars.indexOf(Char) == -1) 
				{
					IsNumber = false;
				}
			}
			return IsNumber;   
		},

    /**
     *
     *This function will check for a valid Phone Number
     *
     *@param (string) text The string to check
     *
     *@return (boolean) true if text is a phone number, ie if each character of
     *input is one of 0123456789() -+ 
     */
		IsValidPhone : function (text)
		{
		
			var ValidChars = "0123456789()-+ ";
		  
			var IsValid=true;
			var Char;
		 
			for (i = 0; i < text.length && IsValid == true; i++) 
			{ 
				Char = text.charAt(i); 
				if (ValidChars.indexOf(Char) == -1) 
				{
					IsValid = false;
				}
			}
			return IsValid;   
		}
	}
}
