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
 * @fileOverview This file provides all the functions and variables to manage requisition lists and the items within.
 * This file is included in all pages with requisition list actions.
 */

dojo.require("wc.service.common");
dojo.require("wc.render.common");

/**
 * This class defines the functions and variables that customers can use to create, update, and view their requisition lists.
 * @class The RequisitionList class defines the functions and variables that customers can use to manage their requisition lists, 
 * particularly on the My Account pages, and to add products to new or existing requisition lists on the catalog pages via the 
 * requisition list pop-up. All store pages supporting requisition list functions include this class.
 */
RequisitionList ={
	
	/**
	 * This variable stores the ids of the order items that have been modified on the requisition list
	 * edit page, but the modifications have not been saved yet.
	 * @private
	 */ 
	modifiedOrderItemIds : new Array(),	
		
	/** 
	 * This variable stores the ID of the language that the store currently uses. Its default value is set to -1, which corresponds to United States English.
	 * @private
	 */
	langId: "-1",
	
	/** 
	 * This variable stores the ID of the current store. Its default value is empty.
	 * @private
	 */
	storeId: "",
	
	/** 
	 * This variable stores the ID of the catalog. Its default value is empty.
	 * @private
	 */
	catalogId: "",		
		
	/** 
	 * Flag which indicates whether 'AjaxMyAccount' is enabled or not. The value of this variable is automatically populated
	 * based on the change flow option in the store.
	 * @private
	 */
	ajaxMyAccountEnabled: false,	
	
	/** 
	 * Flag which indicates whether there are unsaved changes on the requisition list detail page.
	 * @private
	 */
	unsavedChanges: false,	
	
	/**
	 * Flag which indicates whether 'AjaxShopcart' is enabled or not. The value of this variable is automatically populated
	 * based on the change flow option in the store.
	 * @private
	 */
	ajaxShopcart: true,		
	
	/**
	 * This variable stores the creator of the requisition list 
	 */
	createdBy:null,
	
	/**
	 * sets the creator of the requisition list
	 * @param (String) name name of the requisition list creator
	 */
	setCreatedBy: function (name) {
		 this.createdBy = name;
	},
	 
	 /**
	  * returns the creator of the requisition list
	  */
	 getCreatedBy: function() {
		return this.createdBy;
	 },
	
	/**
	 * Sets the common parameters for the current page. 
	 * For example, the language ID, store ID, and catalog ID.
	 *
	 * @param {Integer} langId The ID of the language that the store currently uses.
	 * @param {Integer} storeId The ID of the current store.
	 * @param {Integer} catalogId The ID of the catalog.
	 */
	setCommonParameters:function(langId,storeId,catalogId){
		this.langId = langId;
		this.storeId = storeId;
		this.catalogId = catalogId;
	},	
	
	/**
	 * Sets the variable that indicates whether AjaxMyAccount is enabled.
	 * @param (boolean) temp The new value that indicates whether AjaxMyAccount is enabled.
	 */	
	setAjaxMyAccountEnabled: function(temp){
		this.ajaxMyAccountEnabled = temp;
	},

	/**
	 * Retrieves the variable that indicates whether AjaxMyAccount is enabled.
	 * @return (boolean) The stored value indicating whether AjaxMyAccount is enabled.
	 */		
	getAjaxMyAccountEnabled: function(){
		return this.ajaxMyAccountEnabled;
	},	
	
	/**
	 * Sets the variable that indicates whether AjaxShopCart is enabled.
	 * @param (boolean) temp The new value that indicates whether AjaxShopCart is enabled.
	 */	
	setAjaxShopCart: function(temp){
		this.ajaxShopCart = temp;
	},

	/**
	 * Retrieves the variable that indicates whether AjaxShopCart is enabled.
	 * @return (boolean) The stored value indicating whether AjaxShopCart is enabled.
	 */		
	 getAjaxShopCart: function(){
		return this.ajaxShopCart;
	},		
		
	/**
	 * Creates an empty requisition list.
	 * @param (object) formName The form which contains the name and type of the requisition list.
	 */
	createNewReqList:function(formName) {
		var form = document.forms[formName];
		if (form.requisitionListName!=null && this.isEmpty(form.requisitionListName.value)) {
			MessageHelper.formErrorHandleClient(form.requisitionListName.id,MessageHelper.messages["REQUISITION_LIST_NAME_EMPTY"]); return;
		}
		
		form.requisitionListName.value = trim(form.requisitionListName.value);
		if (this.getAjaxMyAccountEnabled()) {

			service = wc.service.getServiceById('requisitionListAdd');
			service.formId = formName;
			var params = {};
			params["editable"] = "true";
			params.storeId = this.storeId;
			params.catalogId = this.catalogId;
			params.langId = this.langId;
			
			/*For Handling multiple clicks. */
			if(!submitRequest()){
				return;
			}			
			cursor_wait();
			wc.service.invoke('requisitionListAdd',params);
		}else { // non ajax mode
			/*For Handling multiple clicks. */
			if(!submitRequest()){
				return;
			}
			form.editable.value = "true";
			form.submit();	
		}
	},

	/**
	 * Updates the name or type or both of a requisition list.
	 * @param (object) formName The form that contains the new requisition list data.
	 * @param (string) requisitionListId The requisition list to be updated.
	 */
	updateReqList:function (formName,requisitionListId) {
		MessageHelper.hideAndClearMessage();
		var form = document.forms[formName];
		if (form.requisitionListName!=null && this.isEmpty(form.requisitionListName.value)) {
			MessageHelper.formErrorHandleClient(form.requisitionListName.id,MessageHelper.messages["REQUISITION_LIST_NAME_EMPTY"]); return;
		}
		//This is just to check if there are any invalid quantity values
		//Actual quantity update is done in success handler after name/type update
		if(this.modifiedOrderItemIds.length > 0){
			//sorting the modifiedOrderItemIds so that error tool tips are displayed in order.
			this.modifiedOrderItemIds.sort(this.sortNumber);
			for (x in this.modifiedOrderItemIds) {
				var valx = this.modifiedOrderItemIds[x];
				var quantity = document.getElementById("quantity_"+valx).value;
				if(this.isEmpty(quantity) || !this.isNumber(quantity) || quantity < 0){
					MessageHelper.clearCurrentIdentifier();
					if(document.getElementById("tooltip_"+valx) != null){
						MessageHelper.formErrorHandleClient("tooltip_"+valx,MessageHelper.messages["ERROR_REQUISITION_LIST_QUANTITY_ZERO_OR_MORE"]);
					} else {
						MessageHelper.formErrorHandleClient('RequisitionList_UpdateList',MessageHelper.messages["ERROR_REQUISITION_LIST_QUANTITY_ZERO_OR_MORE"]);
					}
					return;
				}
			}
		}
		form.requisitionListName.value = trim(form.requisitionListName.value);
		
		var params = {};
		params["editable"] = "true";
		//Need to give the service declaration the form with all info about all req list info
		service = wc.service.getServiceById("requisitionListUpdate");
		service.formId=formName;
		params["requisitionListId"] = requisitionListId;
		params.storeId = this.storeId;
		params.catalogId = this.catalogId;
		params.langId = this.langId;		
		
		
		if(!submitRequest()){
			return;
		}
		cursor_wait();
		
		//This only updates the name and type for req list since another command updates items separately
		//After successful name/type update, success handler will trigger quantity update service call		
		wc.service.invoke('requisitionListUpdate',params);
	},	
	
	/**
	 * Creates a new requisition list from a saved order or a current order.
	 * @param (object) formName The form which contains the new requisition data.
	 * @param (string) orderId The order to create the requisition list from.
	 */
	createReqListFromOrder:function (formName,orderId) {
		MessageHelper.hideAndClearMessage();
		var form = document.forms[formName];
		if (form.requisitionListName!=null && this.isEmpty(form.requisitionListName.value)) {
			MessageHelper.formErrorHandleClient(form.requisitionListName.id,MessageHelper.messages["REQUISITION_LIST_NAME_EMPTY"]); return;
		}

		form.requisitionListName.value = trim(form.requisitionListName.value);
		
		if (this.getAjaxMyAccountEnabled()) {
			var params = {};
			params["editable"] = "true";
			params.storeId = this.storeId;
			params.catalogId = this.catalogId;
			params.langId = this.langId;
			params["orderId"] = orderId;	
			params["name"] = form.requisitionListName.value;
			params["status"] = form.requisitionListType.value;
			
			if(!submitRequest()){
				return;
			}
			cursor_wait();
			
			wc.service.invoke('requisitionListCopy',params);
		} else {
			var formObj = document.createElement("form");
			formObj.setAttribute("method","post");
			
			var input = document.createElement("input");
			input.setAttribute("type", "hidden");
			input.setAttribute("name", "URL");
			input.setAttribute("value", "RequisitionListDetailView");
			formObj.appendChild(input);	
			
			var input2 = document.createElement("input");
			input2.setAttribute("type", "hidden");
			input2.setAttribute("name", "errorViewName");
			input2.setAttribute("value", "RequisitionListDetailView");
			formObj.appendChild(input2);	
			
			formObj.action = "RequisitionListCopy?editable=true&status="+form.requisitionListType.value+"&storeId=" + this.storeId +"&catalogId=" + this.catalogId + "&langId=" + this.langId + "&orderId="+orderId +"&name="+ form.requisitionListName.value;
			
			document.body.appendChild(formObj); // have to add this form to the body node before submitting.
			
			if(!submitRequest()){
				return;
			}
			cursor_wait();
			
			formObj.submit();			
		}
	},		
	
	/**
	 * Updates the quantities of each item in the requisition list, if the quantities are changed.
	 * This function is automatically called by the sucessHandler of requisitionListUpdate.
	 * @see RequisitionList.updateReqList()
	 * @see MyAccountServiceDeclaration.js requisitionListUpdate declaration
	 * @param (string) requisitionListId The ID of the requisition list to update.
	 */
	updateReqListQuantity:function (requisitionListId) {
		if (!this.modifiedOrderItemIds.length>0) { return; }
		
		var params={};
		params["requisitionListId"] = requisitionListId;
		params["editable"] = "true"; // true because the user will not get to this point if editable was false
		params.storeId = this.storeId;
		params.catalogId = this.catalogId;
		params.langId = this.langId;
		
		//now get the items that are updated
		var x;
		for (x in this.modifiedOrderItemIds) {
				var valx = this.modifiedOrderItemIds[x];		
				params["quantity_"+valx] = document.getElementById("quantity_"+valx).value;
				params["orderItemId_"+valx] = document.getElementById("orderItemId_"+valx).value;
			
		}
		if(!submitRequest()){
			return;
		}
		cursor_wait();
		wc.service.invoke('requisitionListAddItem',params);

	},
	
	/**
	 * Clears the array of quantities after the requisition list update is successful.
	 */	
	resetOrderItemIdsArray:function(){
		//need to reset the this.modifiedOrderItemIds so that modifiedOrderItemIds does not contain items from other lists. 
		this.modifiedOrderItemIds.length=0;
	},

	/**
	 * Adds an item to the requisition list.
	 * @param (object) formName The form that contains the items to add to the requisition list.
	 * @param (string) requisitionListId The requisition list to add the selected items to.
	 * @param (string) editable Indicates whether the requisition list can be edited by the current customer.
	 */
	AddToReqList:function(formName,requisitionListId,editable){
		MessageHelper.hideAndClearMessage();
		var form = document.forms[formName];
		if (form.newSku!=null && this.isEmpty(form.newSku.value)) {
			MessageHelper.formErrorHandleClient(form.newSku.id,MessageHelper.messages["REQUISITION_LIST_SKU_EMPTY"]); return;
		}else if (form.newQuantity!=null && this.isEmpty(form.newQuantity.value)) {
			form.newQuantity.value = "1";
		}else if (!this.isNumber(form.newQuantity.value) || form.newQuantity.value <= 0) {
			MessageHelper.formErrorHandleClient(form.newQuantity.id,MessageHelper.messages["ERROR_REQUISITION_LIST_QUANTITY_ONE_OR_MORE"]); return;
		}
		
		if (this.getAjaxMyAccountEnabled()) {
			var params = {};
			params["requisitionListId"] = requisitionListId;
			params["editable"] = editable;			
			params["partNumber"] = form.newSku.value;
			params["quantity"] = form.newQuantity.value;
			params["operation"] = "addItem";
			params.storeId = this.storeId;
			params.catalogId = this.catalogId;
			params.langId = this.langId;			
			
			/*For Handling multiple clicks. */
			if(!submitRequest()){
				return;
			}			
			cursor_wait();
			wc.service.invoke('requisitionListAddItem',params);
		}else {
			/*For Handling multiple clicks. */
			if(!submitRequest()){
				return;
			}	
			form.editable.value = editable;
			
			//change the form action to RequisitionListItemUpdate
			form.action="RequisitionListItemUpdate?partNumber_1="+form.newSku.value+"&quantity_1="+form.newQuantity.value+"&langId="+this.langId+"&storeId="+this.storeId+"&catalogId="+this.catalogId;
			form.submit();
		}
	},

	/**
	 * Checks if a string is null or empty.
	 * @param (string) str The string to check.
	 * @return (boolean) Indicates whether the string is empty.
	 */
	isEmpty:function (str) {
		var reWhiteSpace = new RegExp(/^\s+$/);
		if (str == null || str =='' || reWhiteSpace.test(str) ) {
			return true;
		}
		return false;
	},
	
	/**
	 * Filters the list of available requisition lists based on the selected option.
	 * @param (object) filterSelectBox The filter select box object, used to access the selection box value to determine the selected filter view.
	 * @param (object) form The form which contains the new requisition data.
	 */	
	filterRequisitionList:function (filterSelectBox, form){
		if(filterSelectBox != null) {
			//For Ajax My Account
			if(this.getAjaxMyAccountEnabled()){
				var option = filterSelectBox.value;
				
				var params = {};
				params["filterOption"] = option;
				params["beginIndex"]=0; // resetting the beginIndex so that if the type of requisition list is changed, the first page is displayed

				/*For Handling multiple clicks. */
				if(!submitRequest()){
					return;
				}
				cursor_wait();
				
				wc.render.updateContext("RequisitionListDisplay_Context", params);
			} else {
				/*For Handling multiple clicks. */
				if(!submitRequest()){
					return;
				}
				cursor_wait();
				form.submit();					
			}
		}
	},
	
	/**
	 * Sets the index used to start the pagination of all requisition lists. 
	 * Requisition lists that occur before the beginning index are not shown.
	 * @param (string) index The index used to start the pagination of requisition lists.
	 */
	setBeginIndex: function (index) {
		var params = {};
		params["beginIndex"] = index;
		params["catalogId"] = this.catalogId;
		params["storeId"] = this.storeId;
		params["langId"] = this.langId;
		
		if (!this.getAjaxMyAccountEnabled()) {
			//in nonajax mode, controller URL is not set in the JSP. Have to set it in here			
			CommonControllersDeclarationJS.setControllerURL('RequisitionListDisplay_Controller','RequisitionListTableView');
		}
		if (submitRequest()) {
			cursor_wait();
			wc.render.updateContext("RequisitionListDisplay_Context", params);
		}		
	},
	
	/**
	 * Deletes a requisition list for the Ajax flow.
	 * @param (string) requisitionListId The identifier of the selected requisition list.
	 * @param (string) filterOption The selected option for filtering the requisition lists.
	 */
	deleteRequisitionList:function (requisitionListId, filterOption) {
		var params = {};
		params["requisitionListId"] = requisitionListId;
		params["filterOption"] = filterOption;
		params.storeId = this.storeId;
		params.catalogId = this.catalogId;
		params.langId = this.langId;		
		
		/*For Handling multiple clicks. */
		if(!submitRequest()){
			return;
		}			
		cursor_wait();
		wc.service.invoke('AjaxRequisitionListDelete',params);
	},	
	
	/**
	 * Deletes an item from the requisition list for the Ajax flow.
	 * @param (string) requisitionListId The identifier of the selected requisition list.
	 * @param (string) orderItemId The item to delete from the requisition list.
	 * @param (string) editable Indicates whether the current customer can edit the requisition list.
	 */
	deleteRequisitionListItem:function (requisitionListId, orderItemId, editable) {
		var params = {};
		params["requisitionListId"] = requisitionListId;
		params["orderItemId"] = orderItemId;
		params["quantity"] = "0";
		params["editable"] = editable;
		params.storeId = this.storeId;
		params.catalogId = this.catalogId;
		params.langId = this.langId;	
		params["operation"] = "deleteItem";
		
		/*For Handling multiple clicks. */
		if(!submitRequest()){
			return;
		}			
		cursor_wait();
		wc.service.invoke('requisitionListAddItem',params);
	},
	
	/**
	 * Tracks which order item is updated.
	 * For each order item that is updated, the order ID is saved to the quantitiyId array. 
	 * If the quantity is invalid, an error is displayed for AJAX calls.
	 * @param (string) id The ID of the updated order item.
	 */
	addToOrderItemsIdsArray:function (id) {
		MessageHelper.hideAndClearMessage();
		document.getElementById("quantity_"+id).value = trim(document.getElementById("quantity_"+id).value);
		var inputField = document.getElementById("quantity_"+id);
		this.modifiedOrderItemIds.push(id);
		this.setUnsavedChanges(true);
		if(this.getAjaxMyAccountEnabled() == false){
			return;
		}
		if (this.isEmpty(inputField.value) || !this.isNumber(inputField.value) || inputField.value < 0) {
			MessageHelper.clearCurrentIdentifier();
			//quantity entered is not valid. Show error msg. 
			MessageHelper.formErrorHandleClient("tooltip_"+id,MessageHelper.messages["ERROR_REQUISITION_LIST_QUANTITY_ZERO_OR_MORE"]);
			return;
		}
	},
	
	/**
	 * Checks if the string is an integer.
	 * @param (string) str The string to check.
	 * @return (boolean) Indicates whether the string is a number.
	 */
	isNumber:function (str) {
		if ((str*0)==0) return true;
		else return false;
	},
	
	/**
	 * Adds all of the order items from the current requisition list to the current order.
	 * Checks whether the current requisition list contains items.
	 * @param (object) form The form which contains the new requisition data.
	 */
	placeOrder:function (form) {
		MessageHelper.hideAndClearMessage();
		//If there is no order items added to the requisition list
		//Do not allow user to place order
		if(document.getElementById("partNumber_2") == null) {
			MessageHelper.formErrorHandleClient('RequisitionList_UpdateList',MessageHelper.messages["ERROR_REQUISITION_LIST_PLACE_ORDER"]);
			return;
		} else if (this.hasUnsavedChanges()) {
			MessageHelper.formErrorHandleClient('RequisitionList_UpdateList',MessageHelper.messages["ERROR_REQUISITION_LIST_SAVE_CHANGES"]);
			return;			
		}

		//For Handling multiple clicks
		if(!submitRequest()){
			return;
		} 
		
		cursor_wait();
		
		if (this.getAjaxMyAccountEnabled()) {
			service = wc.service.getServiceById('requisitionListAjaxPlaceOrder');
			service.formId = "RequisitionListDetailForm";
			wc.service.invoke('requisitionListAjaxPlaceOrder');
		}else {
			form.action = "RequisitionListSubmit";
			form.URL.value = "AjaxCheckoutDisplayView?langId="+this.langId+"&storeId="+this.storeId+"&catalogId="+this.catalogId+"&allocate=***&backorder=***&remerge=***&check=*n";
			form.URL.value +="&quantity*=&partNumber*=&orderItemId*=";			//to fix the URL too long problem in IE
			form.submit();
		}
	},
	
	/**
	 * This function compares the numbers passed in as parameters, and returns which one is greater.
	 * @param (string) num1 The first number to compare.
	 * @param (string) num2 The second number to compare. 
	 * @return (string) Indicates which number is greater.
	 */	
	sortNumber:function (num1, num2){
		return num1 - num2;
	},
	
	/**
	 * Creates a new requisition list when a customer clicks the Add to New Requisition List button on the product details page.
	 * When the new requisition list is created, the selected items are also added to the list.
	 * @param (string) formName The form that contains the data for the new requisition list.
	 */
	createNewListFromProductDetail:function (formName) {
		MessageHelper.hideAndClearMessage();
		var form = document.forms[formName];
		if (form.requisitionListName!=null && this.isEmpty(form.requisitionListName.value)) {
			MessageHelper.formErrorHandleClient(form.requisitionListName.id,MessageHelper.messages["REQUISITION_LIST_NAME_EMPTY"]); return;
		}
		form.requisitionListName.value = trim(form.requisitionListName.value);
		if (this.getAjaxMyAccountEnabled()) {
			
			//bundles may contain more than 1 products. But for a regular item, there is no other products associated to it. So the numberOfProduct is always 0
			var numberOfProduct = form.numberOfProduct.value -1;			
			if (numberOfProduct == -1) numberOfProduct=0; 

			var params = {};
			params["status"] = document.getElementById('requisitionListType').value;
			params["name"] = document.getElementById('requisitionListName').value;
			
			for(var i = 0; i <= numberOfProduct; i++){
				params["partNumber_"+i] = document.getElementById("partNumber_"+i).value;
				params["quantity_"+i] = document.getElementById("quantity_"+i).value;     
			}

			params["editable"]="true";
			params["operation"] = "createAndAdd";
			params.storeId = this.storeId;
			params.catalogId = this.catalogId;
			params.langId = this.langId;	
			
			if(!submitRequest()){
				return;
			}
			cursor_wait();
			wc.service.invoke('requisitionListAddItem',params);
		}else {
			/*For Handling multiple clicks. */
			if(!submitRequest()){
				return;
			}				
			//change the form action to RequisitionListItemUpdate
			form.action="RequisitionListItemUpdate?langId="+this.langId+"&storeId="+this.storeId+"&catalogId="+this.catalogId;
			form.submit();
		}
	},
	
	/**
	* Retrieves and loads the previous URL in Ajax flows.
	* This function belong to HistoryTracking for receiving Back notifications.	
	*/
	goBack:function(){
	
		AccountWishListDisplay.loadContentURL(this.historyUrl);
		AccountWishListDisplay.isHistory=true;

	},

	/**
	* Retrieves and loads the forward URL in Ajax flows.
	* This function belong to HistoryTracking for receiving forward notifications.	
	*/
	goForward:function(){

		AccountWishListDisplay.loadContentURL(this.historyUrl);
		isHistory=true;
	},

	/**
	* Sets the History state object for browsing history tracking.
	* @param {string} elementId  The ID of the widget.
	* @param {string} changeUrl   The URL used to load new context.
	* @param {string} historyUrl The value of the history URL.
	*/
	HistoryTracker:function(elementId, changeUrl, historyUrl){
	
		this.elementId = elementId; 
		this.changeUrl =  changeUrl;
		this.historyUrl = historyUrl; 

	},
	
	/**
	 * Parses bookmarked URLS and processes the bookmarks.
	 * If the URL contains query information, the query string is extracted and an AJAX call is made 
	 * to request the requisition list and update the requisition list display division with the results.
	 */
	processBookmarkURL : function(){
		var bookmarkId = location.hash;	
		if(bookmarkId){					        
			bookmarkId = bookmarkId.substring(1, bookmarkId.length);
		}   
		if(bookmarkId){
			var indexOfIdentifier = bookmarkId.indexOf("identifier", 0);
			if ( indexOfIdentifier >= 0) {
				var realUrl = bookmarkId.substring(0, indexOfIdentifier - 1);
			}
		}
	},
	
	/**
	 * Resolves the SKU of the item to add to the requisition list.
	 * Displays the requisition list pop-up that contains the requisition list information. 
	 * Customers can use this pop-up to select the existing requisition list that they want to add items to.
	 *
	 * @param {string} entitledItemId The catalog entry ID of the item to add to the current order.
	 * @param {string} quantityElemId The ID of the Quantity field.
	 * 
	 */		
	showReqListPopupForItem:function(entitledItemId,quantityElemId){
		MessageHelper.hideAndClearMessage();
		
		//Check whether or not the attributes are selected; and whether an SKU is resolved
		var entitledItemJSON;

		if (dojo.byId(entitledItemId)!=null) {
			//the json object for entitled items are already in the HTML. 
			 entitledItemJSON = eval('('+ dojo.byId(entitledItemId).innerHTML +')');
		}else{
			//if dojo.byId(entitledItemId) is null, that means there's no <div> in the HTML that contains the JSON object. 
			//in this case, it must have been set in catalogentryThumbnailDisplay.js when the quick info
			entitledItemJSON = categoryDisplayJS.getEntitledItemJsonObject(); 
		}
		categoryDisplayJS.setEntitledItems(entitledItemJSON);
		var catalogEntryId = categoryDisplayJS.getCatalogEntryId();
		if(catalogEntryId != null){
			this.showReqListPopup(quantityElemId);
		} else {
			MessageHelper.displayErrorMessage(MessageHelper.messages['ERR_RESOLVING_SKU_REQ_LIST']);
			//Close the quick info pop-up if it exists
			if(dijit.byId('second_level_category_popup') != null){
				hidePopup('second_level_category_popup');
			}			
		}
	},
	
	/**
	 * Displays a requisition list pop-up that contains information about the available requisition lists.
	 * Customers can use the requisition list pop-up to select the existing requisition list that they want to add items to.
	 *
	 * @param {string} quantityElemId The ID of the Quantity field.
	 * @param {form} form The form that contains all of the inputs for the bundle.
	 * 
	 */		
	showReqListPopup:function(quantityElemId,form){
		MessageHelper.hideAndClearMessage();
		
		//Validate the quantity value
		var quantityElement = document.getElementById(quantityElemId);

		//For the Package detail page
		//If a valid quantity field id is specified, validate the given quantity field
		if(quantityElement != null){
			var quantity = quantityElement.value;
			if (quantity == null || quantity == "" || quantity<=0 || !RequisitionList.isNumber(quantity)) {
				MessageHelper.displayErrorMessage(MessageHelper.messages['QUANTITY_INPUT_ERROR']);
				//Close the quick info pop-up if it exists
				if(dijit.byId('second_level_category_popup') != null){
					hidePopup('second_level_category_popup');
				}
				return;
			}
		} else {
			//For the Bundle detail page
			//If no valid quantity field id is specified, validate all the quantity fields in the specified form				
			var productCountElement = form["numberOfProduct"];
			if(productCountElement != null){
				var productCount = productCountElement.value;
				for(var i = 1; i <= productCount; i++){
					var qty = form["quantity_" + i].value;
					if(qty == null || qty == "" || qty<=0 || !RequisitionList.isNumber(qty)){ 
						var quantityFields = document.getElementsByName("quantity_"+i);
						MessageHelper.displayErrorMessage(MessageHelper.messages['QUANTITY_INPUT_ERROR']);
						return;
					}
				}
			}
		}
		
		//Close the quick info pop-up if it exists
		if(dijit.byId('second_level_category_popup') != null){
			hidePopup('second_level_category_popup');
		}		
		
		//Get the requisition list pop-up object
		var popup = dijit.byId('requisition_list_popup');
		if(popup != null){
			popup.closeButtonNode.style.display='none';
			popup.show();
			
			// hides the DialogUnderlayWrapper component, the component that grays out the screen behind,
			// as we do not want the background to be greyed out
			dojo.query('.dijitDialogUnderlayWrapper', document).forEach(function(tag) {		
				tag.style.display='none';
			});		
			
			//Obtain the first radio button for each requisition list type
			var privateReqList = document.getElementById("WC_RequisitionListTableDisplay_Selection_1_1");
			var sharedReqList = document.getElementById("WC_RequisitionListTableDisplay_Selection_2_1");
					
			//If there are private requisition lists, check the first radio button of the private lists
			if(privateReqList != null){
				privateReqList.checked = true;
			} else {
				//If there are no private requisition lists, but there are shared requisition lists
				//Check the first radio button of the shared lists
				if(sharedReqList != null){
					sharedReqList.checked = true;
				}
			}
			
			//Populate the links for the requisition list pop-up
			var existingReqListLink = dojo.byId("addToExistingReqList_popup");
			var newReqListLink = document.getElementById("addToNewReqList_popup");
			
			var pageType = categoryDisplayJS.currentPageType;
			var catalogEntryId = categoryDisplayJS.currentCatalogEntryId;
			
			if(existingReqListLink != null){
				if(pageType == 'product'){
					existingReqListLink.href = "javaScript:setCurrentId('addToExistingReqList_popup');categoryDisplayJS.addToExistingRequisitionList('entitledItem_" + catalogEntryId + "', '" + quantityElemId + "'," + this.getAjaxShopCart() + ");";
				} else if(pageType == 'item' || pageType == 'package'){
					existingReqListLink.href = "javaScript:setCurrentId('addToExistingReqList_popup');categoryDisplayJS.addItemToExistingRequisitionList('" + catalogEntryId + "', '" + quantityElemId + "'," + this.getAjaxShopCart() + ");";
				} else if(pageType == 'bundle'){
					existingReqListLink.href = "javaScript:setCurrentId('addToExistingReqList_popup');categoryDisplayJS.addBundleToExistingRequisitionList(document.getElementById('OrderItemAddForm_" + catalogEntryId + "')," + this.getAjaxShopCart() + ");";
				}	
			}
			if(newReqListLink != null){
				if(pageType == 'product'){
					newReqListLink.href = "javascript:categoryDisplayJS.addToNewListFromProductDetail('entitledItem_" + catalogEntryId + "', '" + quantityElemId + "', document.location.href);";
				} else if(pageType == 'item' || pageType == 'package'){
					newReqListLink.href = "javascript:categoryDisplayJS.addItemToNewListFromProductDetail('" + catalogEntryId + "', '" + quantityElemId + "', document.location.href);";
				} else if(pageType == 'bundle'){
					newReqListLink.href = "javascript:categoryDisplayJS.addBundleToNewListFromProductDetail(document.getElementById('OrderItemAddForm_" + catalogEntryId + "'), document.location.href);";
				}					
			}
		}
	},
	
	/**
	 * Hides the requisition list pop-up.
	 */		
	hideReqListPopup:function(){
		var popup = dijit.byId('requisition_list_popup');
		
		if(popup != null){
			popup.hide();
		}
	},
	
	/**
	 * Shows the previous or next page of items in the requisition list.
	 * Checks if there are unsaved changes before showing the new page of items.
	 * @param {string} controllerURL The URL for the controller to refresh.
	 * @param {string} newBeginIndex The begin index of the page to be shown.
	 */		
	pageItemTable:function(controllerURL, newBeginIndex){
		//Check if there are unsaved changes
		//Notify user before displaying next/prev page
		if(this.hasUnsavedChanges()) {
			MessageHelper.formErrorHandleClient('RequisitionList_UpdateList',MessageHelper.messages["ERROR_REQUISITION_LIST_SAVE_CHANGES"]);
			return;			
		}
		
		/*For Handling multiple clicks. */
		if(!submitRequest()){
			return;
		}
		
		cursor_wait();
		CommonControllersDeclarationJS.setControllerURL('RequisitionListDetailTableDisplay_Controller',controllerURL);
		wc.render.updateContext('RequisitionListDetailTableDisplay_Context',{'beginIndex':newBeginIndex});
	},
	
	/**
	 * Returns a boolean value to indicate whether there are unsaved changes on the requisition list detail page.
	 * @return (boolean) A boolean value to indicate whether unsaved changes have been made.
	 */			
	hasUnsavedChanges:function(){
		return this.unsavedChanges;
	},
	
	/**
	 * Set the variable that indicates whether there are unsaved changes in the requisition list.
	 * @param (boolean) temp The new value that indicates whether there are unsaved changes in the requisition list.
	 */			
	setUnsavedChanges:function(temp){ 
		 if(document.getElementById("RequisitionList_UpdateList") != null){
			 this.unsavedChanges = temp;
		 }
	},

	/**
	* On pressing Tab key on the last focusable element in the "Add to Requisition list" pop-up, the focus is 
	* transferred to the Close button.
	*/
	reqGobackFocus:function(){
		document.getElementById('WC_RequisitionListPopupDisplay_closeLink').focus();
	},
	
	/**
	* On pressing Shift+Tab keys, the focus is tranferred from Close button to the last focusable element present in 
	* the "Add to Requisition list" pop-up.
	* @param {Object} event Event object
	*/
	reqSetbackFocus:function(event){
		if(event.shiftKey && event.keyCode == dojo.keys.TAB)
		{
			document.getElementById('addToNewReqList_popup').focus();
			dojo.stopEvent(event);
		}
	}

}

/** Sets the  HistoryTracking for receiving Back notifications. */
RequisitionList.HistoryTracker.prototype.back = RequisitionList.goBack;
/** Sets the  HistoryTracking for receiving forward notifications. */
RequisitionList.HistoryTracker.prototype.forward = RequisitionList.goForward;
