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
 * @fileOverview This file contains declarations of refresh controllers used by WebSphere Commerce AJAX services for the shipping and billing pages.
 */

dojo.require("wc.render.common");

/**
 * @class This class stores the common parameters and functions for the controllers.
 */
SBControllersDeclarationJS = {
	/** 
	 * This variable stores the true/false value that indicates if the 'AjaxCheckout' feature is enabled.
	 * It is set to true by default.
	 */
	ajaxCheckOut: true,

	/** 
	 * This variable stores the true/false value that indicates if the 'SinglePageCheckout' feature is enabled/disabled.
	 * When it is true, both shipping and billing information are captured in a single page. If it is false, checkout will
	 * be a two step process where shipping is captured in first step and billing in second step.
	 * It is set to true by default.
	 * 
	 * @private
	 */
	singlePageCheckout: true,
	
	/**
		* This variable is used to indicate if ShippingChargeType flexflow option is enabled or not.
		*/
	shipChargeEnabled: false,
	
	
	/**
	 * This function sets the URL parameter for a given refresh controller. 
	 * For a more detailed description of the URL parameter, please refer to {@link wc.render.declareRefreshController}.
	 *
	 * @param {String} controllerId The ID of the controller of which the URL parameter will be set.
	 * @param {String} url The new URL parameter for the controller.
	 */
	setControllerURL:function(controllerId,url){
		wc.render.getRefreshControllerById(controllerId).url = url;
	},
	
	
	/**
	 * Sets the ajaxCheckOut variable to indicate if the 'AjaxCheckout' feature is enabled.
	 * 
	 * @param {Boolean} ajaxCheckOut A true/false value that indicates if the 'AjaxCheckout' feature is enabled.
	 */
	setAjaxCheckOut:function(checkOutType){
		this.ajaxCheckOut = checkOutType;
	},
	
	/**
	 * Returns the ajaxCheckOut variable that indicates if the 'AjaxCheckout' feature is enabled.
	 * 
	 * @returns {Boolean} ajaxCheckOut A true/false value that indicates if the 'AjaxCheckout' feature is enabled.
	 */
	isAjaxCheckOut:function(){
		return this.ajaxCheckOut;
	},

	/**
	 * Sets the SinglePageCheckout variable to indicate if the 'SinglePageCheckout' feature is enabled or disabled.
	 * 
	 * @param {Boolean} singlePageCheckout. A true/false value that indicates if the 'SinglePageCheckout' feature is enabled.
	 *
	 * @see CheckoutHelperJS.isSinglePageCheckout
	 */
	setSinglePageCheckout:function(singlePageCheckout){
		this.singlePageCheckout = singlePageCheckout;
	},
	
	
	/**
	 * Returns the singlePageCheckout variable that indicates if the 'SinglePageCheckout' feature is enabled/disabled.
	 * 
	 * @returns {Boolean} singlePageCheckout A true/false value that indicates if the 'SinglePageCheckout' feature is
	 * enabled/disabled.
	 *
	 * @see CheckoutHelperJS.setSinglePageCheckout
	 */
	isSinglePageCheckout:function(){
		return this.singlePageCheckout;
	},
	
	/**
	 * Sets the shipChargeEnabled variable to indicate if the 'ShippingChargeType' feature is enabled.
	 * 
	 * @param {Boolean} enabled A true/false value that indicates if the 'ShippingChargeType' feature is enabled.
	 */
	setShipChargeEnabled:function(enabled){
		this.shipChargeEnabled = enabled;
	}
}


/**
 * Refresh controller declaration for the main page area on the 'Shipping & Billing' page.
 * @constructor
 */
wc.render.declareRefreshController({
	/* this a local context..no need to define URL for this */
	id: "controllerForMainAndAddressDiv",
	renderContext: wc.render.getContextById("contextForMainAndAddressDiv"),
	url: "",
	formId: ""
	
	/**
	 * Calls {@link CheckoutHelperJS.showHideDivs} to display and hide the areas defined in renderContext.
	 * 
	 * @param {Object} message The render context changed event message.
	 * @param {Object} widget The refresh area widget.
	 */
	,renderContextChangedHandler: function(message, widget) {
		var controller = this;
		var renderContext = this.renderContext;
		CheckoutHelperJS.showHideDivs(renderContext.properties["showArea"],renderContext.properties["hideArea"]);
	}

}),


/**
 * Refresh controller declaration for the order items area on the single shipment 'Shipping & Billing' page.
 * @constructor
 */
wc.render.declareRefreshController({
	id: "traditionalShipmentDetailsController",
	renderContext: wc.render.getContextById("traditionalShipmentDetailsContext"),
	url: "",
	formId: ""
	
	/**
	 * Refreshes the item details area with the properties defined in renderContext if the actionId of the input message parameter is from an order update service or if it is 'OrderShippingInfoUpdate'.
	 *
	 * @param {Object} message The render context changed event message.
	 * @param {Object} widget The refresh area widget.
	 */
	,modelChangedHandler: function(message, widget) {
		var controller = this;
		var renderContext = this.renderContext;
		if(message.actionId in order_updated || message.actionId == 'OrderShippingInfoUpdate' || message.actionId == 'AjaxDeleteOrderItemForShippingBillingPage' 
			|| message.actionId == 'AjaxDeleteOrderItemForShippingBillingPage' || message.actionId == 'OrderItemAddressShipMethodUpdate' || message.actionId == 'AjaxPrepareOrderForShipChargeUpdate'
			|| message.actionId == 'OrderItemAddressShipInstructionsUpdate' || message.actionId == 'OrderItemAddressShipInstructionsUpdate1'){
			widget.refresh(renderContext.properties);
		}
	}
	
	/**
	 * Refreshes the order item details area with the properties defined in renderContext.
	 *
	 * @param {Object} message The render context changed event message.
	 * @param {Object} widget The refresh area widget.
	 */
	,renderContextChangedHandler: function(message, widget) {
		var controller = this;
		var renderContext = this.renderContext;
		if(controller.testForChangedRC(["beginIndex"])){
			widget.refresh(renderContext.properties);
		}
	}
	
	/**
	 * Clears the progress bar after a successful refresh.
	 *
	 * @param {Object} widget The refresh area widget.
	 */
	,postRefreshHandler: function(widget) {
		var controller = this;
		var renderContext = this.renderContext;
		cursor_clear();
		if(!CheckoutHelperJS.isAjaxCheckOut()){
			CheckoutHelperJS.setFieldDirtyFlag(false);
			CheckoutHelperJS.initDojoEventListenerSingleShipmentPage();
		}
	}

}),


/**
 * Refresh controller declaration for the shipping address area on the single shipment 'Shipping & Billing' page.
 * @constructor
 */
wc.render.declareRefreshController({
	id: "shippingAddressSelectBoxAreaController",
	renderContext: wc.render.getContextById("shippingAddressDropDownBoxContext"),
	url: "",
	formId: ""
	
	/**
	 * Refreshes the shipping address area with the properties defined in renderContext.
	 *
	 * @param {Object} message The render context changed event message.
	 * @param {Object} widget The refresh area widget.
	 */
	,modelChangedHandler: function(message, widget) {
		var controller = this;
		var renderContext = this.renderContext;
			if (message.actionId in address_updated){
				//This means, invokeService for Address Add/Edit has been called..so upadate our select box area
				wc.render.updateContext('contextForMainAndAddressDiv', {'showArea':'mainContents','hideArea':'editAddressContents'});
				selectedAddressId = message.addressId;
				CheckoutHelperJS.updateAddressIdOFItemsOnCreateEditAddress(selectedAddressId);
				cursor_clear();  
			} else if (message.actionId == "AjaxUpdateOrderItemsAddressId"){
				//This means, new shipping address is created / edited and all the items are updated with this new address id
				// and ajax prepare order is called.. we need to update our shipping address drop down...
				widget.refresh(renderContext.properties);
				cursor_clear();
			} else if (message.actionId == "AddBillingAddressInCheckOut"){
				//No Work..can use later..
			}
	}

}),


/**
 * Refresh controller declaration for the order totals summary area.
 * @constructor
 */
wc.render.declareRefreshController({
	id: "currentOrderTotalsAreaController",
	renderContext: wc.render.getContextById("currentOrder_Context"),
	url: "",
	formId: ""
	
	
	/**
	 * Refreshes the area with the properties defined in renderContext if the actionId of the input message is from an order update service.
	 *
	 * @param {Object} message The render context changed event message.
	 * @param {Object} widget The refresh area widget.
	 */
	,modelChangedHandler: function(message, widget) {
		var controller = this;
		var renderContext = this.renderContext;
		if (message.actionId in order_updated || message.actionId == 'AjaxDeleteOrderItemForShippingBillingPage' 
			|| message.actionId == 'OrderItemAddressShipMethodUpdate' || message.actionId == 'AjaxPrepareOrderForShipChargeUpdate'
			|| message.actionId == 'OrderItemAddressShipInstructionsUpdate' || message.actionId == 'OrderItemAddressShipInstructionsUpdate1'
			|| message.actionId == 'AjaxUpdateOrderAfterAddressUpdate' || message.actionId == 'AjaxPrepareOrderBeforeSubmit') {
			widget.refresh(renderContext.properties);
		}
	}
	
	/**
	 * Updates the display style of relevant sections on the page after a successful refresh.
	 *
	 * @param {Object} widget The refresh area widget.
	 */
	,postRefreshHandler: function(widget) {
		// Order level discount tooltip section - if the tooltip is defined, show the section after area is refreshed
		if(document.getElementById("discountDetailsSection")!=null )  {
			document.getElementById("discountDetailsSection").style.display = "block";
		}
		
		// Promotion code tooltip section - if the tooltip is defined, show the section after area is refreshed
		if(document.getElementById("appliedPromotionCodes")!=null ) {
			document.getElementById("appliedPromotionCodes").style.display = "block";
		}		
	}
}),


/**
 * Refresh controller declaration for the billing address area.
 * @constructor
 */
wc.render.declareRefreshController({
	id: "billingAddressSelectBoxAreaController",
	renderContext: wc.render.getContextById("billingAddressDropDownBoxContext"),
	url: "",
	formId: ""
	
	/**
	 * Refreshes the Billing Address dropdown box with addresses corresponding to the newly selected payment method.
	 *
	 * @param {Object} message The render context changed event message.
	 * @param {Object} widget The refresh area widget.
	 */

	,renderContextChangedHandler: function(message, widget) {
		var controller = this;
		var renderContext = this.renderContext;
		if(controller.testForChangedRC(["payment"+widget.objectId]) || controller.testForChangedRC(["paymentTCId"+widget.objectId])){
			this.url = renderContext.properties["billingURL"+widget.objectId]+"&paymentTCId="+renderContext.properties["paymentTCId"+widget.objectId];
			widget.refresh({"paymentAreaNumber":widget.objectId,"selectedAddressId":message.addressId,"paymentMethodSelected":renderContext.properties["payment"+widget.objectId]});
		}	
	}
	/**
	 * If the 'AjaxCheckout' feature is enabled, this function refreshes the billing address area with the properties defined in renderContext if the actionId of the input message parameter is AddBillingAddressInCheckOut or AjaxUpdateAddressForPerson.
	 *
	 * @param {Object} message The render context changed event message.
	 * @param {Object} widget The refresh area widget.
	 */
	,modelChangedHandler: function(message, widget) {
		var controller = this;
		var renderContext = this.renderContext;
		//If we are creating a new billing address or editing the existing address, then we should update our billing address drop down box area...
		if(SBControllersDeclarationJS.isAjaxCheckOut()){
			if (message.actionId == "AddBillingAddressInCheckOut" || message.actionId == "AjaxUpdateAddressForPerson" || message.actionId == "AjaxAddShippingAndBillingAddressForPersonDuringCheckout"){
				//Make sure that even after we refresh the billing address drop down box, we pre-select the previously selected address for user...
				var addressId = renderContext.properties["billingAddress"+widget.objectId];
				this.url = renderContext.properties["billingURL"+widget.objectId]+"&paymentTCId="+renderContext.properties["paymentTCId"+widget.objectId];
				if(renderContext.properties["billingAddress"+widget.objectId] == -1){
					//Create address was selected from this billing drop down..so this drop down box should have new address selected by default...
					addressId = message.addressId;
					widget.refresh({"paymentAreaNumber":widget.objectId,"selectedAddressId":addressId,"paymentMethodSelected":renderContext.properties["payment"+widget.objectId]});
				}
				else if(renderContext.properties["billingAddress"+widget.objectId] == 0){
					//Means user has not yet touched this select box..dont try to select anything...
					widget.refresh({"paymentAreaNumber":widget.objectId,"paymentMethodSelected":renderContext.properties["payment"+widget.objectId]});
				}
				else{
					widget.refresh({"paymentAreaNumber":widget.objectId,"selectedAddressId":addressId,"paymentMethodSelected":renderContext.properties["payment"+widget.objectId]});
				}
			}
		}
	}
	
	,postRefreshHandler: function(widget) {
		
			// After the section refreshes, shows or hides the edit and create links. 						
			CheckoutHelperJS.showHideEditBillingAddressLink((document.getElementsByName('billing_address_id'))[widget.objectId-1],CheckoutHelperJS.orderId, widget.objectId);
			CheckoutHelperJS.showHideCreateBillingAddressLink((document.getElementsByName('billing_address_id'))[widget.objectId-1],CheckoutHelperJS.orderId, widget.objectId);
			//Removes the Progress Bar if its still running.
			cursor_clear();
			
		}
	
}),


/**
 * Refresh controller declaration for the order item details area in a multiple shipment check-out scenario.
 * @constructor
 */
wc.render.declareRefreshController({
	id: "multipleShipmentDetailsController",
	renderContext: wc.render.getContextById("multipleShipmentDetailsContext"),
	url: "",
	formId: ""
	
	/**
	 * If the 'AjaxCheckout' feature is enabled, the actionId of the input message parameter is from an order update service and the requested shipping date has not been updated recently, this function refreshes the item details area with the properties defined in renderContext.
	 *
	 * @param {Object} message The render context changed event message.
	 * @param {Object} widget The refresh area widget.
	 */
	,modelChangedHandler: function(message, widget) {
		var controller = this;
		var renderContext = this.renderContext;
		if(SBControllersDeclarationJS.isAjaxCheckOut()){
			if(message.actionId in order_updated || message.actionId == 'AjaxUpdateOrderItemsAddressId' || message.actionId == 'AjaxDeleteOrderItemForShippingBillingPage' 
				|| message.actionId == 'OrderItemAddressShipMethodUpdate' || message.actionId == 'AjaxPrepareOrderForShipChargeUpdate'
				|| message.actionId == 'OrderItemAddressShipInstructionsUpdate'	|| message.actionId == 'OrderItemAddressShipInstructionsUpdate1'){
				(!CheckoutHelperJS.RequestShippingDateAction)?widget.refresh(renderContext.properties):CheckoutHelperJS.RequestShippingDateAction = false;
			}
		}
	}
		
	/**
	 * Refreshes the order item details area with the properties defined in renderContext in a multiple shipment check-out scenario.
	 *
	 * @param {Object} message The render context changed event message.
	 * @param {Object} widget The refresh area widget.
	 */
	,renderContextChangedHandler: function(message, widget) {
		var controller = this;
		var renderContext = this.renderContext;
		if(controller.testForChangedRC(["beginIndex"])){
			widget.refresh(renderContext.properties);
		}
	}
	
	/**
	 * Clears the progress bar after a successful refresh.
	 *
	 * @param {Object} widget The refresh area widget.
	 */
	,postRefreshHandler: function(widget) {
		var controller = this;
		var renderContext = this.renderContext;
		cursor_clear();
		if(!CheckoutHelperJS.isAjaxCheckOut()){
			CheckoutHelperJS.setFieldDirtyFlag(false);
			CheckoutHelperJS.initDojoEventListenerMultiShipmentPage();
		}
	}
}),

/**
 * Refresh controller declaration for the shipping charge area in a single shipment check-out scenario.
 * @constructor
 */
wc.render.declareRefreshController({
	id: "singleShipmentShipChargeController",
	renderContext: wc.render.getContextById("singleShipmentShipChargeContext"),
	url: "",
	formId: ""
	
	/**
	 * Only refresh this area when shipping method is updated
	 *
	 * @param {Object} message The render context changed event message.
	 * @param {Object} widget The refresh area widget.
	 */
	,modelChangedHandler: function(message, widget) {
		var controller = this;
		var renderContext = this.renderContext;
		if (SBControllersDeclarationJS.shipChargeEnabled) {
			if (message.actionId=="OrderItemAddressShipMethodUpdate") {
				widget.refresh(renderContext.properties);
			}
		}
	}
	
	/**
	 * Clears the progress bar after a successful refresh.
	 *
	 * @param {Object} widget The refresh area widget.
	 */
	,postRefreshHandler: function(widget) {
		var controller = this;
		var renderContext = this.renderContext;
		cursor_clear();
	}
}),

/**
 * Refresh controller declaration for the shipping charge area in a multiple shipment check-out scenario.
 * @constructor
 */
wc.render.declareRefreshController({
	id: "multipleShipmentShipChargeController",
	renderContext: wc.render.getContextById("multipleShipmentShipChargeContext"),
	url: "",
	formId: ""
	
	/**
	 * Only refresh this area when shipping method is updated
	 *
	 * @param {Object} message The render context changed event message.
	 * @param {Object} widget The refresh area widget.
	 */
	,modelChangedHandler: function(message, widget) {
		var controller = this;
		var renderContext = this.renderContext;
		if (SBControllersDeclarationJS.shipChargeEnabled) {
			if (message.actionId=="OrderItemAddressShipMethodUpdate") {
				widget.refresh(renderContext.properties);
			}
			if (message.actionId=="AjaxDeleteOrderItemForShippingBillingPage") {
				widget.refresh(renderContext.properties);
			}
		}
	}
	
	/**
	 * Clears the progress bar after a successful refresh.
	 *
	 * @param {Object} widget The refresh area widget.
	 */
	,postRefreshHandler: function(widget) {
		var controller = this;
		var renderContext = this.renderContext;
		cursor_clear();
	}
	
	
})
