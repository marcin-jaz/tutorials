//-----------------------------------------------------------------
// Licensed Materials - Property of IBM
//
// WebSphere Commerce
//
// (C) Copyright IBM Corp. 2009 All Rights Reserved.
//
// US Government Users Restricted Rights - Use, duplication or
// disclosure restricted by GSA ADP Schedule Contract with
// IBM Corp.
//-----------------------------------------------------------------


/** 
 * @fileOverview This file provides the common functions which are specific to the Madisons store.
 * This JavaScript file is used by StoreCommonUtilities.jspf.
 */

//Import the required Dojo libraries
dojo.registerModulePath("wc", "../wc");
	
dojo.require("wc.service.common");
dojo.require("dojo.io.iframe");
dojo.require("dojo.io.script");

//Reloads widgets when parts of the page has been re-loaded from server
dojo.require("dojo.parser");

//Category menu support
dojo.require("dijit.form.Button");
dojo.require("wc.widget.WCMenu");
dojo.require("wc.widget.WCDialog");
dojo.require("wc.widget.ScrollablePane");
dojo.require("dijit.layout.TabContainer");
dojo.require("dijit.layout.ContentPane");	
dojo.require("dijit.Tooltip");
dojo.require("wc.widget.WCDropDownButton");
dojo.require("dijit.Dialog");
dojo.require("dojo.dnd.Source");
dojo.require("dojo.currency");
dojo.require("dijit.Tree");
dojo.require("dojo.back");
dojo.require("dijit.form.DateTextBox");
dojo.require("wc.widget.RefreshArea");
dojo.require("wc.render.RefreshController");
dojo.require("wc.render.Context");
dojo.require("dojo.cookie");


/** This variable indicates whether the dropdown is shown or not. */
var showDropdown = false;

/** This variable stores the current dropdown dialog element. */
var dropDownDlg = null;

/** This variable indicates whether the browser used is Internet Explorer or not. */
var isIE = (document.all) ? true : false;

/** Initializes the variable to false. **/
	var correctBrowser = false;

/** 
 * This variable indicates whether a request has been submitted or not.
 * The value is initialized to true and resets to false on full page load.
 */
var requestSubmitted = true;

/** 
 * This variable stores the id of the element (ex: button/link) which the user clicked.
 * This id is set when the user clicks an element which triggers an Ajax request.
 */
var currentId = "";

/** 
 * Sends back focus to the first focusable element on tabbing from the last focusable element.
 */
function focusSetter(){  
	if(dojo.byId("MiniCartFocusReceiver1"))
		dojo.byId("MiniCartFocusReceiver1").focus();
	else
		dojo.byId("MiniCartFocusReceiver2").focus();
}

/** 
 * Sends back focus to the last focusable element on reverse tabbing from the first focusable element.
 * 
 * @param {object} event The event triggered from user actions
 */
function determineFocus(event) {
		if(event.shiftKey && event.keyCode == dojo.keys.TAB)
		{
			if(event.srcElement)
			{
				if(event.srcElement.id=="MiniCartFocusReceiver1")
				{
					if(dojo.byId("WC_MiniShopCartDisplay_link_5"))
					{
						dojo.byId("WC_MiniShopCartDisplay_link_5").focus();
					}
					dojo.stopEvent(event);
				}
				else if(event.srcElement.id=="MiniCartFocusReceiver2")
				{
					dojo.byId("MiniCartFocusReceiver2").focus();
					dojo.stopEvent(event);
				}
			}
			else
			{
				if(event.target.id=="MiniCartFocusReceiver1")
				{
					if(dojo.byId("WC_MiniShopCartDisplay_link_5"))
					{
						dojo.byId("WC_MiniShopCartDisplay_link_5").focus();
					}
					dojo.stopEvent(event);
				}
				else if(event.target.id=="MiniCartFocusReceiver2")
				{
					dojo.byId("MiniCartFocusReceiver2").focus();
					dojo.stopEvent(event);
				}
			}
		}
}

/**
 * Destroys the existing dialogs with outdated data.
 */
function destroyDialog(){
	//If data has changed, then we should destroy the quick_cart_container dialog and recreate it with latest data
	dojo.query('.dijitDialog', document).forEach(function(tag) {
		if (dijit.byNode(tag).id == 'quick_cart_container') 
			dijit.byNode(tag).destroyRecursive();// or dijit.getEnclosingWidget(tag).destroyRecursive();
	 });
	 dropDownDlg = null;
}

/**
 * Displays the dropdown content of the mini shopping cart when keyboard keys are used to expand/collapse the dropdown.
 *
 * @param {object} event The event to retrieve the input keyboard key
 * @param {string} relativeId The id of a placeholder element to position the dropdown relatively
 * @param {string} contentId The id of the content pane containing the mini shopping cart dropdown contents
 * @param {string} contentType The content that will be shown in the expanded mini shopping cart dropdown.
 */
function showMiniShopCartDropDown1(event,relativeId,contentId,contentType){
	console.debug(event.keyCode);
	if(event.keyCode == dojo.keys.DOWN_ARROW){
		showMiniShopCartDropDown(relativeId,contentId,contentType);
	}
	else if(event.shiftKey && event.keyCode == dojo.keys.ENTER){
		showMiniShopCartDropDown(relativeId,contentId,contentType);
		dojo.stopEvent(event);
	}
}

/**
 * Displays the dropdown content of the mini shopping cart when the user hovers over the 
 * mini shopping cart or uses keyboard keys to expand the dropdown.
 *
 * @param {object} event The event triggered from user actions
 * @param {string} relativeId The id of a placeholder element to position the dropdown relatively
 * @param {string} contentId The id of the content pane containing the mini shopping cart dropdown contents
 * @param {string} contentType The content that will be shown in the expanded mini shopping cart dropdown.
 */
function showMiniShopCartDropDown(relativeId,contentId,contentType){

	//Calculate the X and Y co-ordinates for the dialog. We don't want it to be at the center of the screen.
	var t = dojo.byId(relativeId);
	var c = dojo.coords(t,true);
	var x1 = c.x; 
	var y1 = c.y;
	
    /*By default, the content of the mini shop cart will be displayed immediately after the mini shop cart title.
     *But we want the content to display under the mini shop cart title. So we'll need to get the width
     *of the shop cart and then shift it*/
	if (dojo.locale == 'iw-il') {
		var cartWidth =dojo.coords(dojo.byId('miniShopCartBody'),true).w+
            dojo.coords(dojo.byId('miniShopCartLeftCorner'),true).w+
            dojo.coords(dojo.byId('miniShopCartRightCorner'),true).w;
	}else {
	var cartWidth =dojo.coords(dojo.byId('miniShopCartBody'),true).w;
	}
	dojo.style(dojo.byId("quick_cart"), "width", cartWidth+'px');
	
	
	/* If the Dialog is already created, then just set the X and Y co-ordinates for this dialog. Sometimes,
	if the browser is resized, the (x,y) co-ordinates will change from the initial values. So every time before calling Dialog.show() method reset the (x,y) co-ordinates. 
	The Dialog.show() method will internally call _rePosition() method which repositions the dialog.
	*/

    var dlgX;
    if (dojo.locale == 'iw-il' && dojo.isIE<7) {
        dlgX  = dojo.coords(dojo.byId('miniShopCartLeftCorner')).x;
    }else {
        dlgX =x1 +dojo.contentBox(dojo.byId(relativeId)).w-cartWidth;
    }
	if(dropDownDlg){
			dropDownDlg.y = y1;
			dropDownDlg.x = dlgX;
	}

	/* Dialog is not yet created..Create one */
	if(!dropDownDlg){
		var pane = document.getElementById(contentId);
		dropDownDlg = new wc.widget.WCDialog({relatedSource: relativeId, x:x1,y:y1},pane);
		dropDownDlg.x=dlgX;
	}

	if(dojo.isOpera!=0 && dojo.isOpera!=null)
	{
		dropDownDlg.x = dropDownDlg.x + window.pageXOffset;
		dropDownDlg.y = dropDownDlg.y + window.pageYOffset;
	}

	if(contentType == 'orderItemsList'){
		dojo.byId("MiniShopCartProductsList").style.display = "block";
		dojo.byId("MiniShopCartProductAdded").style.display = "none";
	}
	else if(contentType == 'orderItemAdded'){
		dojo.byId("MiniShopCartProductsList").style.display = "none";
		dojo.byId("MiniShopCartProductAdded").style.display = "block";
	}
	
	setTimeout(dojo.hitch(dropDownDlg,"show",null),5);
	setTimeout(dojo.hitch(this,"hideUnderlayWrapper",""),5);
}

/**
 * Hides the DialogUnderlayWrapper component, the component that grays out the screen behind,
 * as we do not want the background to be greyed out.
 */
function hideUnderlayWrapper(){
	dojo.query('.dijitDialogUnderlayWrapper', document).forEach(function(tag) {		
		tag.style.display='none';
	});	
}

/**
 * Loads the specified URL.
 *
 * @param {string} url The URL of the page to be loaded.
 */
function loadLink(url){
	document.location.href=url;
}

/**
 * Clears the Search term string displayed in Simple Search field.
 */
function clearSearchField() {
	searchText = document.getElementById("SimpleSearchForm_SearchTerm").value;
	if(searchText == document.getElementById("searchTextHolder").innerHTML){
		document.getElementById("SimpleSearchForm_SearchTerm").value = "";
	}
	else{
		document.getElementById("SimpleSearchForm_SearchTerm").select();
	}
}

/**
 * Displays the Search term string in Simple Search field.
 */
function fillSearchField() {
	if (document.getElementById("SimpleSearchForm_SearchTerm").value == "") {
		document.getElementById("SimpleSearchForm_SearchTerm").value = document.getElementById("searchTextHolder").innerHTML;
	}
}

/**
 * Displays the top dropdown menu, including the category dropdowns and the mini shopping cart.
 */
function showDropDownMenu(){
	var showMenu = document.getElementById("header_menu_dropdown");
	if(document.getElementById("header_menu_dropdown")!=null && document.getElementById("header_menu_dropdown")!='undefined'){
		showMenu.style.display = "block";
	}
	if(document.getElementById("outerCartContainer")!=null && document.getElementById("outerCartContainer")!='undefined'){
		var outershopcart = document.getElementById("outerCartContainer");
		outershopcart.style.display = "block";
	}
}

/**
 * Initializes the mini shopping cart object and subscribes dojo actions on this object.
 */
function initShopcartTarget(){
			
	dojo.subscribe("/dnd/drop", function(source, nodes, copy, target){
		
		target.deleteSelectedNodes();
		
		var actionListScroll = new popupActionProperties(); 
		actionListScroll.showProductCompare = showProductCompare;

		if(target.parent.id=='miniShopCart_dndTarget'){
			var indexOfIdentifier = source.parent.id.indexOf("_",0);
			if ( indexOfIdentifier >= 0) {
				//remove the prefix including the "underscore"
				source.parent.id = source.parent.id.substring(indexOfIdentifier+1);					
			}
			if(source.node.getAttribute('dndType')=='item' || source.node.getAttribute('dndType')=='package') {
				categoryDisplayJS.AddItem2ShopCartAjax(source.parent.id ,1);
			} else if(source.node.getAttribute('dndType')=='product' || source.node.getAttribute('dndType')=='bundle') {
				showPopup(source.parent.id,storeId,langId,catalogId,function(e){return e;},'miniShopCart_dndTarget',null,actionListScroll);
			}
		}
	});
}

/**
 * Displays the progress bar dialog to indicate a request is currently running.
 * There are certain cases where displaying the progress bar causes problems in Opera,
 * the optional parameter "checkForOpera" is passed to specifically check if the browser used is Opera,
 * if so, do not display the progress bar in these cases.
 *
 * @param {boolean} checkForOpera Indicates whether to check if the browser is Opera or not.
 */
function cursor_wait(checkForOpera) {
	var showPopup = true;	

	//Since dijit does not support Opera
	//Some progress bar dialog will be blocked in Opera to avoid error
	if(checkForOpera == true){
		if(dojo.isOpera > 0){
			showPopup = false;
		}
	}
	
	//For all other browsers and pages that work with Opera
	//Display the progress bar dialog
	if(showPopup){
		//Delay the progress bar from showing up
		setTimeout('showProgressBar()',500);
	}
}

/**
 * Helper method for cursor_wait() to display the progress bar pop-up.
 * Displays progress bar, next to the element if the element id was specified in currentId,
 * or defaults to the center of the page if currentId is empty.
 * Progress bar will only be displayed if the submitted request has not been completed.
 * This method is only called implicitly by the cursor_wait() method, which is triggered before a request is submitted.
 */
function showProgressBar(){
	//After the delay, if the request is still not finished
	//Then continue and show the progress bar
	//Otherwise, do not execute the following code
	if(!requestSubmitted){
		return;
	}
	
	displayProgressBar();
	
}


/**
 * Helper method for showProgressBar() to display the progress bar pop-up.
 * It can also be forced to show the progress bar directly in special cases.
 * The function also displays the progress bar next to the element if the element id was specified in currentId,
 * or defaults to the center of the page if currentId is empty.
 * This method can be called implicitly by the cursor_wait() method or explicitly by itself.
 */
function displayProgressBar(){
	var dialog = dijit.byId('progress_bar_dialog');
	
	//Make sure the dialog is created
	if(dialog != null){
			
		//Hide the header for the close button
		dialog.closeButtonNode.style.display='none';		
		
		var progressBar = document.getElementById('progress_bar');
		progressBar.style.display = 'block';	
				
		//Check whether or not an element ID is provided
		//If yes, point the progress bar to this element
		//Otherwise, show the progress bar in a dialog
		if(this.currentId != ""){
			var element = document.getElementById(this.currentId);	
			var pos = dijit.placeOnScreenAroundElement(progressBar,element,{'TR':'TL'});	
		} else {
			dialog.containerNode.innerHTML == "";
			progressBar.style.left = '';
			progressBar.style.top = '';
			dialog.containerNode.appendChild(progressBar);
			dialog.show();		
		}
		
		//Make sure the progress bar dialog goes away after 30 minutes
		//and does not hang if server calls does not return
		//Assuming the longest server calls return before 30 minutes
		setTimeout("cursor_clear()",1800000);
	}
}

/**
 * Stores the id of the element (ex: button/link) that triggered the current submitted request.
 * Store the new element id only when no request is currently running.
 *
 * @param {string} id The id of element triggering the submitted request.
 */
function setCurrentId(id){
	//If there is no request already submitted, update the id
	if(!requestSubmitted && this.currentId == ""){
		this.currentId = id;
	}
}

/**
 * This function trims the spaces from the pased in word.
 * Delete all pre and trailing spaces around the word.
 * 
 * @param {string} inword The word to trim.
 */
function trim(inword)
{
	word = inword.toString();
	var i=0;
	var j=word.length-1;
	while(word.charAt(i) == " ") i++;
	while(word.charAt(j) == " ") j=j-1;
	if (i > j) {
		return word.substring(i,i);
	} else {
		return word.substring(i,j+1);
	}
}

/**
 * Hides the progress bar dialog when the submitted request has completed.
 * Set the visibility of the progress bar dialog to hide from the page.
 */
function cursor_clear() {
		//Reset the flag 
		requestSubmitted = false;

		//Hide the progress bar dialog
		var dialog = dijit.byId('progress_bar_dialog');
		var progressBar = document.getElementById('progress_bar');
		if(dialog != null){
			if(progressBar != null){
				progressBar.style.display = 'none';
			}
			dialog.hide();
			this.currentId="";
		}
}	

/**
 * Checks whether a request can be submitted or not.
 * A new request may only be submitted when no request is currently running.
 * If a request is already running, then the new request will be rejected.
 *
 * @return {boolean} Indicates whether the new request was submitted (true) or rejected (false).
 */
function submitRequest() {
	if(!requestSubmitted) {
		requestSubmitted  = true;
		return true;
	}
	return false;
}
 
/**
 * Set the current page to a new URL.
 * Takes a new URL as input and set the current page to it, executing the command in the URL.
 * Used for Non-ajax calls that requires multiple clicks handling.
 * 
 * @param {string} newPageLink The URL of the new page to redirect to.
 */
function setPageLocation(newPageLink) {
	//For Handling multiple clicks
	if(!submitRequest()){
		return;
	}
			
	document.location.href = newPageLink;
}

/**
 * Submits the form parameter.
 * Requires a form element to be passed in and submits form with its inputs.
 * Used for Non-ajax calls that requires multiple clicks handling.
 *
 * @param {element} form The form to be submitted.
 */
function submitSpecifiedForm(form) {
	if(!submitRequest()){
		return;
	}
	form.submit();
}


/**
 * Parses a Dojo widget.
 * Pass in the id of a dojo widget or a HTML container element containing a dojo widget, such as a div,
 * and this method will parse that widget, or all the widgets within that HTML container element.
 * 
 * @param {string} id The id of a dojo widget or a HTML container of a dojo widget to be parsed.
 */
function parseWidget(id)
{
	var node;
	var widget = dijit.byId(id);
	
	if (widget == null || widget == undefined)
	{
		if (id == null || id == undefined)
		{	
			node = dojo.body();
		}
		else
		{
			node = dojo.byId(id);
		}
		
		if (node != null && node != undefined)
		{
			if (node.getAttribute("dojoType") != null && node.getAttribute("dojoType") != undefined)
			{
				dojo.parser.instantiate([node]);
			}
			else
			{
				dojo.parser.parse(node);
			}
		}
	}
}

/**
 * Parses the header menu.
 * The header menu is only parsed when the user hovers over it to improve the performance of the store loading.
 *
 * @param {string} id The id of the menu item which the user hovers over to initialize the progress bar next to that item.
 */
function parseHeader(id)
{
	var node = dojo.byId("progress_bar_dialog");
	var showMenu = document.getElementById("header_menu_loaded");
	var hideMenu = document.getElementById("header_menu_overlay");
	
	if(currentId.length == 0 && document.getElementById("header_menu_loaded")!=null && document.getElementById("header_menu_loaded")!='undefined' && document.getElementById("header_menu_overlay")!=null && document.getElementById("header_menu_overlay")!='undefined' && document.getElementById("header_menu_loaded").style.display == 'none')
	{
		setCurrentId((id != null && id != undefined)?id:hideMenu.id);
		submitRequest();
		cursor_wait();
		hideMenu.style.display = "none";
		parseWidget("header_menu_loaded");
		showMenu.style.display = "block";
		cursor_clear();
	}
}


 /**
  * This function is used to hide an element with the specified id.
  * @param {string} elementId The id of the element to be hidden.
  */

  function hideElementById(elementId){
		var div = dojo.byId(elementId);
		div.style.display = "none";
 }

/**
  * This function is used to display an element with the specified id.
  * @param {string} elementId The id of the element to be displayed.
  */

   function showElementById(elementId){
		var div = dojo.byId(elementId);
		div.style.display = "block";
}

/**
  * This function is used to hide the background image of an element.
  * @param {DomNode} element The node whose background image is to be hidden.
  */
    function hideBackgroundImage(element){
		element.style.backgroundImage='none';
}

/**
  * This function is used to display the background image of a product onhover.
  * @param {DomNode} element The node for which the product hover background image is to be displayed.
  */

	 function showBackgroundImage(element){
		element.style.backgroundImage='url('+getImageDirectoryPath()+getStyleDirectoryPath()+'product_hover_background.png)';
}
	/**
	* checkIE8Browser checks to see if the browser is IE 8 or less. It then sets correctBrowser to true if it is.
	*
	**/
	
	function checkIE8Browser() { 
       if( dojo.isIE && dojo.isIE <= 8 ){
    	    correctBrowser = true
       }
   } 
 
	/**
	* ApprovalToolLink provides the appropriate URL if the browser is correct, otherwise displays a message.
	*
	* @param {String} idTag Used to identify the id tag in the jsp that is calling it.
	* @param {String} approvalToolLinkURL This is a URL which is passed from the calling jsp.
	*
	**/
   
	function ApprovalToolLink(idTag, approvalToolLinkURL) { 
		
		//checks if the browser is IE 8 or less.
		checkIE8Browser();
		
		if (correctBrowser) {
    	  RFQwindow=window.open(approvalToolLinkURL);
		}
		else {      
    	  MessageHelper.formErrorHandleClient(idTag,MessageHelper.messages["ERROR_INCORRECT_BROWSER"]); return;
    	}
	}  


/**
 * Updates view (image/detailed) and starting index of pagination of product display in SetCurrencyPreferenceForm when currency is changed from the drop-down menu. 
 * These are later passed as url parameters.
 */

function updateViewAndBeginIndexForCurrencyChange(){
	if(document.getElementById('fastFinderResultControls')!=null && document.getElementById('fastFinderResultControls')!='')
	{	
		if(document.SetCurrencyPreferenceForm.pageView!=null){
			document.SetCurrencyPreferenceForm.pageView.value = document.FastFinderForm.pageView.value;
		}
		if(document.SetCurrencyPreferenceForm.beginIndex!=null){
			document.SetCurrencyPreferenceForm.beginIndex.value = document.FastFinderForm.beginIndex.value;
		}
	}
	else if(document.getElementById('CategoryDisplay_Widget')!=null && document.getElementById('CategoryDisplay_Widget')!='')
	{
		if(wc.render.getContextById('CategoryDisplay_Context').properties['pageView']!='' && document.SetCurrencyPreferenceForm.pageView!=null){
			document.SetCurrencyPreferenceForm.pageView.value = wc.render.getContextById('CategoryDisplay_Context').properties['pageView'];
		}
		if(wc.render.getContextById('CategoryDisplay_Context').properties['beginIndex']!='' && document.SetCurrencyPreferenceForm.beginIndex!=null){
			document.SetCurrencyPreferenceForm.beginIndex.value = wc.render.getContextById('CategoryDisplay_Context').properties['beginIndex'];
		}
	}
	else if(document.getElementById('Search_Result_Summary')!=null && document.getElementById('Search_Result_Summary')!='')
	{
		if(wc.render.getContextById('catalogSearchResultDisplay_Context').properties['searchResultsView']!='' && document.SetCurrencyPreferenceForm.pageView!=null){
			document.SetCurrencyPreferenceForm.pageView.value = wc.render.getContextById('catalogSearchResultDisplay_Context').properties['searchResultsView'];
		}
		if(wc.render.getContextById('catalogSearchResultDisplay_Context').properties['searchResultsPageNum']!='' && document.SetCurrencyPreferenceForm.beginIndex!=null){
			document.SetCurrencyPreferenceForm.beginIndex.value=wc.render.getContextById('catalogSearchResultDisplay_Context').properties['searchResultsPageNum']
		}
	}

}


/**
 * Updates view (image/detailed) and starting index of pagination of product display in LanguageSelectionForm when language is changed from the drop-down menu.
 * These are later passed as url parameters.
 */

function updateViewAndBeginIndexForLanguageChange(){
	if(document.getElementById('fastFinderResultControls')!=null && document.getElementById('fastFinderResultControls')!='')
	{
		if(document.LanguageSelectionForm.pageView!= null){
			document.LanguageSelectionForm.pageView.value = document.FastFinderForm.pageView.value;
		}
		if(document.LanguageSelectionForm.beginIndex!= null){
			document.LanguageSelectionForm.beginIndex.value = document.FastFinderForm.beginIndex.value;
		}
	}
	else if(document.getElementById('CategoryDisplay_Widget')!=null && document.getElementById('CategoryDisplay_Widget')!='')
	{
		if(wc.render.getContextById('CategoryDisplay_Context').properties['pageView']!='' && document.LanguageSelectionForm.pageView!= null){
			document.LanguageSelectionForm.pageView.value = wc.render.getContextById('CategoryDisplay_Context').properties['pageView'];
		} 
		if(wc.render.getContextById('CategoryDisplay_Context').properties['beginIndex']!='' && document.LanguageSelectionForm.beginIndex!= null){
			document.LanguageSelectionForm.beginIndex.value = wc.render.getContextById('CategoryDisplay_Context').properties['beginIndex'];
		} 
	}
	else if(document.getElementById('Search_Result_Summary')!=null && document.getElementById('Search_Result_Summary')!='')
	{
		if(wc.render.getContextById('catalogSearchResultDisplay_Context').properties['searchResultsView']!='' && document.LanguageSelectionForm.pageView!= null){
			document.LanguageSelectionForm.pageView.value = wc.render.getContextById('catalogSearchResultDisplay_Context').properties['searchResultsView'];
		}
		if(wc.render.getContextById('catalogSearchResultDisplay_Context').properties['searchResultsPageNum']!='' && document.LanguageSelectionForm.beginIndex!= null){
			document.LanguageSelectionForm.beginIndex.value = wc.render.getContextById('catalogSearchResultDisplay_Context').properties['searchResultsPageNum'];
		}
	}
}

/**
 * Displays the header links in two lines.
 */
function showHeaderLinksInTwoLines(){
	if(document.getElementById("header_links")!=null && document.getElementById("header_links")!='undefined'){
		if(dojo.contentBox(document.getElementById("header_links")).w > 750){
			if(document.getElementById("header_links1")!=null && document.getElementById("header_links1")!='undefined'){
				document.getElementById("header_links1").style.display = "block";
			}
			if(document.getElementById("headerHomeLink")!=null && document.getElementById("headerHomeLink")!='undefined'){
				document.getElementById("headerHomeLink").style.display = "none";
			}
			if(document.getElementById("headerShopCartLink")!=null && document.getElementById("headerShopCartLink")!='undefined'){
				document.getElementById("headerShopCartLink").style.display = "none";
			}
		}
		document.getElementById("header_links").style.visibility="visible";
	}
}

/**
  * Displays the header links in one line.
  */
 function showLinksInOneLine(){
 	if(document.getElementById("header_links")!=null && document.getElementById("header_links")!='undefined'){
 		document.getElementById("header_links").style.visibility="visible";
 	}
 }

/**
 * Validates if the input value is a non-negative integer using regular expression.
 *
 * @param {String} value The value to validate.
 * 
 * @return {Boolean} Indicates if the given value is a non-negative integer. 
 */
function isNonNegativeInteger(value){
	var regExpTester = new RegExp(/^\d*$/);
	return (value != null && value != "" && regExpTester.test(value));
}

/**
* Validates if the input value is a positive integer.
*
* @param {String} value The value to validate.
* 
* @return {Boolean} Indicates if the given value is a positive integer. 
*/
function isPositiveInteger(value){
	return (isNonNegativeInteger(value) && value != 0);
}
