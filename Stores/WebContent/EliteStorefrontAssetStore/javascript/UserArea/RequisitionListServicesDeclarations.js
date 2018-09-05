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
 * @fileOverview This javascript is used by the Requisition List pages to handle the services for 
 * creating/deleting/updating requisition lists and adding/removing/updating items from a requisition list.
 * @version 1.10
 */

dojo.require("wc.service.common");
dojo.require("wc.render.common");

/**
 * This service allows customer to create a new requisition list
 * @constructor
 */
wc.service.declare({
	id:"requisitionListAdd",
	actionId:"requisitionListAdd",
	url:"AjaxRequisitionListCreate",
	formId:""

	 /**
     * Hides all the messages and the progress bar.
     * @param (object) serviceResponse The service response object, which is the
     * JSON object returned by the service invocation.
     */
	,successHandler: function(serviceResponse) {
		MessageHelper.hideAndClearMessage();
		cursor_clear();
		
		//Update the detail form's requisition list id input when a requisition list is created
		var form = document.getElementById("RequisitionListDetailForm");
		if(form != null && form.requisitionListId != null && form.requisitionListId.value == ''){
			form.requisitionListId.value = serviceResponse.requisitionListId;
		}	
	}
		
	/**
     * display an error message.
     * @param (object) serviceResponse The service response object, which is the
     * JSON object returned by the service invocation.
     */
	,failureHandler: function(serviceResponse) {

		if (serviceResponse.errorMessage) {
			MessageHelper.displayErrorMessage(serviceResponse.errorMessage);
		} 
		else {
			 if (serviceResponse.errorMessageKey) {
				MessageHelper.displayErrorMessage(serviceResponse.errorMessageKey);
			 }
		}
		cursor_clear();
	}			
}),

/**
 * This service allows customer to create add/update an item to an existing requisition list
 * @constructor
 */
wc.service.declare({
	id:"requisitionListAddItem",
	actionId:"requisitionListAddItem",
	url:"AjaxRequisitionListItemUpdate",
	formId:""

	 /**
     * Hides all the messages and the progress bar.
     * @param (object) serviceResponse The service response object, which is the
     * JSON object returned by the service invocation.
     */
	,successHandler: function(serviceResponse) {
		MessageHelper.hideAndClearMessage();
		cursor_clear();
		if(serviceResponse.operation == "addItem"){
			MessageHelper.displayStatusMessage(MessageHelper.messages["REQUISITIONLIST_ADD_SUCCESS"]);
		} else if (serviceResponse.operation == "deleteItem"){
			MessageHelper.displayStatusMessage(MessageHelper.messages["REQUISITIONLIST_ITEM_DELETE_SUCCESS"]);
		} else if (serviceResponse.operation == "createAndAdd"){
			MessageHelper.displayStatusMessage(MessageHelper.messages["REQUISITIONLIST_CREATE_ADD_SUCCESS"]);
		}else {
			MessageHelper.displayStatusMessage(MessageHelper.messages["REQUISITIONLIST_UPDATE_SUCCESS"]);
		}
		
		//Update the detail form's requisition list id input when a requisition list is created
		var form = document.getElementById("RequisitionListDetailForm");
		if(form != null && form.requisitionListId != null && form.requisitionListId.value == ''){
			form.requisitionListId.value = serviceResponse.requisitionListId;
		}		

	}
		
	/**
     * display an error message.
     * @param (object) serviceResponse The service response object, which is the
     * JSON object returned by the service invocation.
     */
	,failureHandler: function(serviceResponse) {

		if (serviceResponse.errorMessage) {
			var errorMsg = serviceResponse.errorMessage;
			//If the errorMessage param is the generic error message
			//Display the systemMessage instead
			if (errorMsg.search("CMN1009E") !=-1 ) {
				MessageHelper.displayErrorMessage(MessageHelper.messages["ERROR_REQUISITION_LIST_INVALID_SKU"]);
			}else if(errorMsg.search("CMN3101E") != -1){
				//If systemMessage is not empty, display systemMessage
				if(serviceResponse.systemMessage){
					if (serviceResponse.errorMessageKey!=null) {
						var msgKey = serviceResponse.errorMessageKey;
						if (msgKey == '_ERR_GETTING_SKU' || msgKey =='_ERR_PROD_NOT_EXISTING') {
							MessageHelper.displayErrorMessage(MessageHelper.messages["ERROR_REQUISITION_LIST_INVALID_SKU"]);
						}else {
							MessageHelper.displayErrorMessage(serviceResponse.systemMessage);
						}
					}else{					
						MessageHelper.displayErrorMessage(serviceResponse.systemMessage);
					}
				} else {
					//If systemMessage is empty, then just display the generic error message
					MessageHelper.displayErrorMessage(serviceResponse.errorMessage);
				}
			} else {
				//If errorMessage is not generic, display errorMessage
				MessageHelper.displayErrorMessage(serviceResponse.errorMessage);
			}
		} 
		else {
			 if (serviceResponse.errorMessageKey) {
				MessageHelper.displayErrorMessage(serviceResponse.errorMessageKey);
			 }
		}
		cursor_clear();
	}			
}),

/**
 * This service deletes an existing requisition list.
 * @constructor
 */
wc.service.declare({
	id:"AjaxRequisitionListDelete",
	actionId:"AjaxRequisitionListDelete",
	url:"AjaxRequisitionListDelete",
	formId:""

	 /**
     * Hides all the messages and the progress bar.
     * @param (object) serviceResponse The service response object, which is the
     * JSON object returned by the service invocation.
     */
	,successHandler: function(serviceResponse) {
		MessageHelper.hideAndClearMessage();
		cursor_clear();
		MessageHelper.displayStatusMessage(MessageHelper.messages["REQUISITIONLIST_DELETE_SUCCESS"]);
	}
		
	/**
     * display an error message.
     * @param (object) serviceResponse The service response object, which is the
     * JSON object returned by the service invocation.
     */
	,failureHandler: function(serviceResponse) {

		if (serviceResponse.errorMessage) {
			MessageHelper.displayErrorMessage(serviceResponse.errorMessage);
		} 
		else {
			 if (serviceResponse.errorMessageKey) {
				MessageHelper.displayErrorMessage(serviceResponse.errorMessageKey);
			 }
		}
		cursor_clear();
	}			
}),

/**
 * This service allows customer to update an existing requisition list
 * @constructor
 */
wc.service.declare({
	id:"requisitionListUpdate",
	actionId:"requisitionListUpdate",
	url:"AjaxRequisitionListUpdate",
	formId:""

	 /**
     * Hides all the messages and the progress bar.
     * @param (object) serviceResponse The service response object, which is the
     * JSON object returned by the service invocation.
     */
	,successHandler: function(serviceResponse) {
		MessageHelper.hideAndClearMessage();
		requestSubmitted = false;
		RequisitionList.updateReqListQuantity(serviceResponse.requisitionListId);
		if (RequisitionList.getAjaxMyAccountEnabled()){
			/*this message is displayed when requisition list name/type is updated */
			MessageHelper.displayStatusMessage(MessageHelper.messages["REQUISITIONLIST_UPDATE_SUCCESS"]);
			RequisitionList.resetOrderItemIdsArray();
			RequisitionList.setUnsavedChanges(false);
			cursor_clear();
		}else {
			document.location.href="RequisitionListDetailView?storeId="+RequisitionList.storeId+"&langId="+RequisitionList.langId+"&catalogId="+RequisitionList.catalogId+"&requisitionListId="+serviceResponse.requisitionListId+"&editable=true";				
		}
	}
	
	/**
     * display an error message.
     * @param (object) serviceResponse The service response object, which is the
     * JSON object returned by the service invocation.
     */
	,failureHandler: function(serviceResponse) {

		if (serviceResponse.errorMessage) {
			MessageHelper.displayErrorMessage(serviceResponse.errorMessage);
		} 
		else {
			 if (serviceResponse.errorMessageKey) {
				MessageHelper.displayErrorMessage(serviceResponse.errorMessageKey);
			 }
		}
		cursor_clear();
	}	
}),

/**
* This service allows customer to create add an item to an existing requisition list through 
* the requisition list pop-up.
* @constructor
*/
wc.service.declare({
	id:"requisitionListAddItem_popup",
	actionId:"requisitionListAddItem_popup",
	url:"AjaxRequisitionListItemUpdate",
	formId:""

	 /**
     * Hides all the messages and the progress bar.
     * @param (object) serviceResponse The service response object, which is the
     * JSON object returned by the service invocation.
     */
	,successHandler: function(serviceResponse) {
		MessageHelper.hideAndClearMessage();
		cursor_clear();
		RequisitionList.hideReqListPopup();
		MessageHelper.displayStatusMessage(MessageHelper.messages["REQUISITIONLIST_ADD_SUCCESS"]);

	}
		
	/**
     * display an error message.
     * @param (object) serviceResponse The service response object, which is the
     * JSON object returned by the service invocation.
     */
	,failureHandler: function(serviceResponse) {

		if(serviceResponse.errorMessage) {
			var errorMsg = serviceResponse.errorMessage;
			//If the errorMessage param is the generic error message
			//Display the systemMessage instead
			if(errorMsg.search("CMN3101E") != -1){
				//If systemMessage is not empty, display systemMessage
				if(serviceResponse.systemMessage){
					MessageHelper.displayErrorMessage(serviceResponse.systemMessage);
				} else {
					//If systemMessage is empty, then just display the generic error message
					MessageHelper.displayErrorMessage(serviceResponse.errorMessage);
				}
			} else {
				//If errorMessage is not generic, display errorMessage
				MessageHelper.displayErrorMessage(serviceResponse.errorMessage);
			}
		} else {
			 if (serviceResponse.errorMessageKey) {
				MessageHelper.displayErrorMessage(serviceResponse.errorMessageKey);
			 }
		}
		cursor_clear();
	}			
}),

/**
* This service allows customer to create a requisition list from an order.
* @constructor
*/
wc.service.declare({
	id:"requisitionListCopy",
	actionId:"requisitionListCopy",
	url:"AjaxRequisitionListCopy",
	formId:""

	 /**
    * Hides all the messages and the progress bar.
    * @param (object) serviceResponse The service response object, which is the
    * JSON object returned by the service invocation.
    */
	,successHandler: function(serviceResponse) {
		MessageHelper.hideAndClearMessage();
		cursor_clear();
		MessageHelper.displayStatusMessage(MessageHelper.messages["REQUISITIONLIST_CREATE_ADD_SUCCESS"]);
		
		//Update the detail form's requisition list id input when a requisition list is created
		var form = document.getElementById("RequisitionListDetailForm");
		if(form != null && form.requisitionListId != null && form.requisitionListId.value == ''){
			form.requisitionListId.value = serviceResponse.requisitionListId;
		}		
	}
		
	/**
    * display an error message.
    * @param (object) serviceResponse The service response object, which is the
    * JSON object returned by the service invocation.
    */
	,failureHandler: function(serviceResponse) {

		if (serviceResponse.errorMessage) {
			var errorMsg = serviceResponse.errorMessage;
			//If the errorMessage param is the generic error message
			//Display the systemMessage instead
			if(errorMsg.search("CMN3101E") != -1){
				//If systemMessage is not empty, display systemMessage
				if(serviceResponse.systemMessage){
					MessageHelper.displayErrorMessage(serviceResponse.systemMessage);
				} else {
					//If systemMessage is empty, then just display the generic error message
					MessageHelper.displayErrorMessage(serviceResponse.errorMessage);
				}
			} else {
				//If errorMessage is not generic, display errorMessage
				MessageHelper.displayErrorMessage(serviceResponse.errorMessage);
			}
		} 
		else {
			 if (serviceResponse.errorMessageKey) {
				MessageHelper.displayErrorMessage(serviceResponse.errorMessageKey);
			 }
		}
		cursor_clear();
	}			
}),
/**
 * this services allows users to submit a requisition list for order processing.
 */
wc.service.declare({
	id:"requisitionListAjaxPlaceOrder",
	actionId:"requisitionListAjaxPlaceOrder",
	url:"AjaxRequisitionListSubmit",
	formId:""

	 /**
    * Hides all the messages and the progress bar, and redirect to the shopping cart page 
    * @param (object) serviceResponse The service response object, which is the
    * JSON object returned by the service invocation.
    */
	,successHandler: function(serviceResponse) {
		MessageHelper.hideAndClearMessage();
		cursor_clear();
		document.location.href="OrderProcessServiceOrderPrepare?langId="+RequisitionList.langId+"&storeId="+RequisitionList.storeId+"&catalogId="+RequisitionList.catalogId+"&URL=AjaxCheckoutDisplayView";
	}	
	/**
    * display an error message.
    * @param (object) serviceResponse The service response object, which is the
    * JSON object returned by the service invocation.
    */
	,failureHandler: function(serviceResponse) {
		 if (serviceResponse.errorMessage) {
		 	if(serviceResponse.errorMessageKey == "_ERR_NO_ELIGIBLE_TRADING"){
		 		MessageHelper.displayErrorMessage(MessageHelper.messages["ERROR_CONTRACT_EXPIRED_GOTO_ORDER"]);
		 	} else if (serviceResponse.errorMessageKey == "_ERR_RETRIEVE_PRICE") {
 					MessageHelper.displayErrorMessage(MessageHelper.messages["ERROR_RETRIEVE_PRICE"]);
			} else {
				MessageHelper.displayErrorMessage(serviceResponse.errorMessage);
			}
		 } else {
			 if (serviceResponse.errorMessageKey) {
				MessageHelper.displayErrorMessage(serviceResponse.errorMessageKey);
			 }
		}
		cursor_clear();
	}			
})