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
 * @fileOverview This javascript contains declarations of AJAX services used within
 * WebSphere Commerce.
 */

/* Import dojo classes */
dojo.require("wc.service.common");

/**
 * @class This class stores common parameters needed to make the service call.
 */
MyAccountServicesDeclarationJS = {
	/* The common parameters used in service calls */
	langId: "-1",
	storeId: "",
	catalogId: "",
	/**
	 * This function initializes common parameters used in all service calls.
	 * @param {int} langId The language id to use.
	 * @param {int} storeId The store id to use.
	 * @param {int} catalogId The catalog id to use.
	 */

	setCommonParameters:function(langId,storeId,catalogId){
			this.langId = langId;
			this.storeId = storeId;
			this.catalogId = catalogId;
	}
}

    /**
	 *  Updates the current Personal Information of the customer.
	 *  @constructor
	 */
	wc.service.declare({
		id: "UserRegistrationUpdate",
		actionId: "UserRegistrationUpdate",
		url: "AjaxPersonChangeServicePersonUpdate",
		formId: "Register"
	
	/**
     * @param (object) serviceResponse The service response object, which is the
     * JSON object returned by the service invocation.
     */
	 
		,successHandler: function(serviceResponse) {
			cursor_clear();
		}

	/**
     * display an error message.
     * @param (object) serviceResponse The service response object, which is the
     * JSON object returned by the service invocation.
     */
		,failureHandler: function(serviceResponse) {
			var form = document.forms["Register"];
			form.logonPassword_old.value = "";
			form.logonPasswordVerify_old.value = ""
			if(serviceResponse){
				 if (serviceResponse.errorMessage) {
					MessageHelper.displayErrorMessage(serviceResponse.errorMessage);
				} else {
					if (serviceResponse.errorMessageKey) {
						MessageHelper.displayErrorMessage(serviceResponse.errorMessageKey);
					}
				}
			}
			cursor_clear();
		}

	}),
	
	/**
	 *  Adds an item to the shopping cart from the customer wishlist in Ajax mode.
	 *  @constructor
	 */
	wc.service.declare({
		id: "AjaxAddOrderItem",
		actionId: "AjaxAddOrderItem",
		url: "AjaxOrderChangeServiceItemAdd",
		formId: ""
		
	/**
     * display a success message.
     * @param (object) serviceResponse The service response object, which is the
     * JSON object returned by the service invocation.
     */
		,successHandler: function(serviceResponse) {
			MessageHelper.displayStatusMessage(MessageHelper.messages["WISHLIST_ADDEDTOCART"]);
			cursor_clear();
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
	 *  Removes an item from the customer wishlist in Ajax mode.
	 *  @constructor
	 */
	wc.service.declare({
		id: "InterestItemDelete",
		actionId: "InterestItemDelete",
		url: "AjaxInterestItemDelete",
		formId: ""

	/**
     * display a success message.
     * @param (object) serviceResponse The service response object, which is the
     * JSON object returned by the service invocation.
     */
		,successHandler: function(serviceResponse) {
			MessageHelper.displayStatusMessage(MessageHelper.messages["WISHLIST_REMOVEITEM"]);
			for (var prop in serviceResponse) {
				console.debug(prop + "=" + serviceResponse[prop]);
			}
			cursor_clear();
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
	 *  Adds an item to the customer wishlist in Ajax mode.
	 *  @constructor
	 */
	wc.service.declare({
		id: "AjaxInterestItemAdd",
		actionId: "AjaxInterestItemAdd",
		url: "AjaxInterestItemAdd",
		formId: ""
	/**
     * display a success message.
     * @param (object) serviceResponse The service response object, which is the
     * JSON object returned by the service invocation.
     */
		,successHandler: function(serviceResponse) {
			MessageHelper.hideAndClearMessage();
			cursor_clear();
			MessageHelper.displayStatusMessage(MessageHelper.messages["WISHLIST_ADDED"]);
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
	 *  This service enables the customer to email his/her wishlist. 
	 *  @constructor
	 */
	wc.service.declare({
		id: "InterestItemListMessage",
		actionId: "InterestItemListMessage",
		url: "AjaxInterestItemListMessage",
		formId: ""

	/**
     * hdes the progress bar and displays a success message.
     * @param (object) serviceResponse The service response object, which is the
     * JSON object returned by the service invocation.
     */
		,successHandler: function(serviceResponse) {
			for (var prop in serviceResponse) {
				console.debug(prop + "=" + serviceResponse[prop]);			
			}
			cursor_clear();
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
	 * This service adds a billing address to the order(s).
	 * @constructor
	 */
	wc.service.declare({
		id: "AddBillingAddress",
		actionId: "AddBillingAddress",
		url: "AjaxPersonChangeServiceAddressAdd",
		formId: ""

	 /**
	  *	 calls the saveAddress function defined in the AddressHelper class.
	  *  @param (object) serviceResponse The service response object, which is the
	  *  JSON object returned by the service invocation. 
	  */
		,successHandler: function(serviceResponse) {
			requestSubmitted = false;
			javascript:AddressHelper.saveAddress('AddShippingAddress','shippingAddressCreateEditFormDiv_1');
		}
		
	/**
     * display an error message.
     * @param (object) serviceResponse The service response object, which is the
     * JSON object returned by the service invocation.
     */
		,failureHandler: function(serviceResponse) {
			if (serviceResponse.errorMessage) {
						 MessageHelper.displayErrorMessage(serviceResponse.errorMessage);
				  } else {
						 if (serviceResponse.errorMessageKey) {
								MessageHelper.displayErrorMessage(serviceResponse.errorMessageKey);
						 }
				  }
		}

	}),
	
	/**
	 *  This service adds a shipping address to the order(s).
	 *  @constructor
	 */
	wc.service.declare({
		id: "AddShippingAddress",
		actionId: "AddShippingAddress",
		url: "AjaxPersonChangeServiceAddressAdd",
		formId: ""
	
	/**
	 *  redirects to the Shipping and Billing Method page.
	 * @param (object) serviceResponse The service response object, which is the
     * JSON object returned by the service invocation.
	 */
		,successHandler: function(serviceResponse) {
			document.location.href="OrderShippingBillingView?langId="+MyAccountServicesDeclarationJS.langId+"&storeId="+MyAccountServicesDeclarationJS.storeId+"&catalogId="+MyAccountServicesDeclarationJS.catalogId+"&shipmentType=single&orderPrepare=true";
		}

	/**
     * display an error message.
     * @param (object) serviceResponse The service response object, which is the
     * JSON object returned by the service invocation.
     */
		,failureHandler: function(serviceResponse) {
			if (serviceResponse.errorMessage) {
						 MessageHelper.displayErrorMessage(serviceResponse.errorMessage);
				  } else {
						 if (serviceResponse.errorMessageKey) {
								MessageHelper.displayErrorMessage(serviceResponse.errorMessageKey);
						 }
				  }
		}

	}),
	
  /**
   * This services adds or removes a coupon from the order(s).
   * @constructor
   */
	wc.service.declare({
		id: "AjaxCouponsAddRemove",
		actionId: "AjaxCouponsAddRemove",
		url: "AjaxCouponsAddRemove",
		formId: ""

   /**
     * Hides all the messages and the progress bar.
     * @param (object) serviceResponse The service response object, which is the
     * JSON object returned by the service invocation.
     */
		,successHandler: function(serviceResponse) {
			MessageHelper.hideAndClearMessage();
			cursor_clear();
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
	 *  This service enables customer to Reorder an already existing order.
	 *  @constructor
	 */
	wc.service.declare({
		id: "OrderCopy",
		actionId: "OrderCopy",
		url: "AjaxOrderCopy",
		formId: ""

	 /**
	  *  Copies all the items from the existing order to the shopping cart and redirects to the shopping cart page.
	  *  @param (object) serviceResponse The service response object, which is the
	  *  JSON object returned by the service invocation.
	  */
		,successHandler: function(serviceResponse) {
			for (var prop in serviceResponse) {
				console.debug(prop + "=" + serviceResponse[prop]);			
			}	
			document.location.href="OrderProcessServiceOrderPrepare?langId="+MyAccountServicesDeclarationJS.langId+"&storeId="+MyAccountServicesDeclarationJS.storeId+"&catalogId="+MyAccountServicesDeclarationJS.catalogId+"&orderId="+serviceResponse.orderId+"&URL=AjaxCheckoutDisplayView?langId="+MyAccountServicesDeclarationJS.langId+"&storeId="+MyAccountServicesDeclarationJS.storeId+"&catalogId="+MyAccountServicesDeclarationJS.catalogId;
		}
		
	/**
     * display an error message.
     * @param (object) serviceResponse The service response object, which is the
     * JSON object returned by the service invocation.
     */
		,failureHandler: function(serviceResponse) {
			if (serviceResponse.errorMessageKey == "_ERR_PROD_NOT_ORDERABLE") {
				MessageHelper.displayErrorMessage(MessageHelper.messages["PRODUCT_NOT_BUYABLE"]);
			} else if (serviceResponse.errorMessageKey == "_ERR_INVALID_ADDR") {
				MessageHelper.displayErrorMessage(MessageHelper.messages["INVALID_CONTRACT"]);
			}else {
				if (serviceResponse.errorMessage) {
					MessageHelper.displayErrorMessage(serviceResponse.errorMessage);
				} 
				else {
					 if (serviceResponse.errorMessageKey) {
						MessageHelper.displayErrorMessage(serviceResponse.errorMessageKey);
					 }
				}
			}
			cursor_clear();
		}

	}),


/**
 *  This service enables customer to cancel a scheduled order or an order waiting for approval.
 *  @constructor
 */
wc.service.declare({
	id: "AjaxScheduledOrderCancel",
	actionId: "AjaxScheduledOrderCancel",
	url: "AjaxOrderChangeServiceScheduledOrderCancel",
	formId: ""

	/**
	 * Displays a success message.
	 * @param (object) serviceResponse The service response object, which is the
	 * JSON object returned by the service invocation.
	 */
	,successHandler: function(serviceResponse) {
		MessageHelper.hideAndClearMessage();
		cursor_clear();
		MessageHelper.displayStatusMessage(MessageHelper.messages["MO_ORDER_CANCELED_MSG"]);
	}
	
	/**
	 * Displays an error message.
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
})
