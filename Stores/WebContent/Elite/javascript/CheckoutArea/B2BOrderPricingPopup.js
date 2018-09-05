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
 * @fileOverview This file provides javascript functions for the contract selection popup
 */
 
/**
 * This class defines the functions in the Contract Price pop-up that customers can use to specify the contract 
 * price to apply to their order item. The contract price chosen by the customer is added to their order during 
 * checkout.
 *
 * @class This class defines the functions in the Contract Price pop-up that customers can use to specify the 
 * contract price to apply to their order item. The contract price chosen by the customer is added to their 
 * order during checkout.
 * 
 */
B2BOrderPricingPopup = {
	/**
	 * This variable stores the text of the link used to get contract price ranges
	 */
	linkText: "",
	
	/**
	 * This variable stores the absolute path of the iamges used for price ranges
	 */
	imgPath: "",

	/**
	 * The variable stores the 'quantity' string.
	 */
	quantityText: "",
	
	/**
	 * The variable stores the 'price' string.
	 */
	priceText:"",
	
	/**
	 * This variable stores the text that is displayed on the update button.
	 */
	SHOPCART_UPDATE: "",
	
	/** 
	 * This variable stores the true/false value that indicates if the 'AjaxCheckout' feature is enabled.
	 * When it is true, virtually all information on the order check-out pages is updated using services.
	 * It is set to true by default.
	 * 
	 * @private
	 */
	ajaxCheckOut:true,

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
	 * This variable stores the ID of the current order, in case the current shopping cart is not being displayed. Its default value is empty.
	 * @private
	 */
	orderId: "",
	
	/**
	 * This variable stores the page that is being displayed when this javascript file was called. 
	 * Current allowable values are pendingOrderDisplay which means this javascript is being called from the pending order details page.
	 * If no value is set in this variable it is assumed that the current order / shopping cart page is being displayed.
	 * Its default value is empty.
	 * @private
	 */
	fromPage: "",
	
	/**
	 * sets the absolute path of the image used for contract price range.
	 * @param (string) imgPath the path of the image. 
	 */
	setImgPath:function (imgPath) {
		this.imgPath = imgPath;
	},
	
	/**
	 * sets the text of the link to display contract price range. 
	 * @param (string) txt text of the link for contract price range. 
	 */
	setLinkText: function (txt) {
		this.linkText = txt;
	},
	
	/**
	 * sets the the 'price' string. This value of the string is taken from the properties file.
	 */
	setPriceText:function (str) {
		this.priceText = str;
	},
	
	/**
	 * sets the 'quantity' string. The value of the string is taken from the properties file. 
	 */
	setQuantityText:function(str) {
		this.quantityText = str;
	},
	
	/**
	 * This variable stores the text to display for price-not-found error message.
	 * @private
	 */
	 NO_PRICE_ERR_MSG: "",
	
	/**
	 * This function sets the NO_PRICE_ERR_MSG variable of this class. The variable is used to store the text to display for 
	 * the price-not-found error message.
	 * @param {String} errMsgText The text to display for the price-not-found error message
	 */
	setNotPriceErrorMsg: function(errMsgText){
		this.NO_PRICE_ERR_MSG = errMsgText;
	},
	
	/**
	 * Sets the SHOPCART_UPDATE variable to the text to display for the update button.
	 * @param {String} updateText The text to display on the Update button
	 */
	setShopcartUpdate: function(updateText){
		this.SHOPCART_UPDATE = updateText;
	},
	
	/**
	 * Sets the common parameters for the current store page, such as language ID, store ID and catalog ID.
	 * @param {Integer} langId The ID of the language used in the current store.
	 * @param {Integer} storeId The ID of the current store.
	 * @param {Integer} catalogId The ID of the catalog used in the current store.
	 */
	setCommonParameters:function(langId,storeId,catalogId){
		this.langId = langId;
		this.storeId = storeId;
		this.catalogId = catalogId;
	},
	
	/**
	 * Sets the ajaxCheckOut variable. This variable indicates if the AjaxCheckout feature is enabled.
 	 * @param {Boolean} ajaxCheckOut This variable is set to true if the AjaxCheckout feature is enabled.
	 * @see CheckoutHelperJS.isAjaxCheckOut
	 */
	setAjaxCheckOut:function(ajaxCheckOut){
		this.ajaxCheckOut = ajaxCheckOut;
	},
	
	
	/**
	 * Returns the ajaxCheckOut variable. This variable indicates if the AjaxCheckout feature is enabled.
	 * @returns {Boolean} ajaxCheckOut This variable is set to true if the AjaxCheckout feature is enabled.
	 * @see CheckoutHelperJS.setAjaxCheckOut
	 */
	isAjaxCheckOut:function(){
		return this.ajaxCheckOut;
	},
	
	/**
	 * Opens the Contract Price pop-up to display the list of contracts that customers can apply to an order item.
	 * This method sends an AJAX call to the JSON object to retrieve data to display in the Contract Price pop-up.
	 * @param {Integer} catentryId The ID of the catalog catentry you want to display.
	 * @param {Integer} storeId The ID of the current store.
	 * @param {Integer} langId The ID of the language to use in the current store.
	 * @param {Integer} catalogId The ID of the catalog to use in the current store.
	 * @param {Integer} orderItemId The ID of the order item to apply the selected contract price to.
	 * @param {Integer} curContractId The ID of the contract currently used by the selected order item.
	 * @param {string} event The event triggered from user actions.
	 * @param {string} targetId The ID of the Dojo widget to display the Contract Price pop-up beside.
	 * @param {string} nodeId The id of element to display the pop-up beside when that element is selected. For example, the id of the button to display the pop-up beside when a shopper clicks the button.
	 */
	showPopup: function(catentryId, storeId, langId, catalogId, orderItemId, curContractId, event, targetId, nodeId){
		if(event == null || (event != null && event.type!="keypress") || (event != null && event.type=="keypress" && event.keyCode==13)){
			this.resetPopUp();
		
			dijit.byId('pricing_popup').closeButtonNode.style.display='none';
			dijit.byId('pricing_popup').show();
			
			var parameters = {};
			parameters.storeId = storeId;
			parameters.langId=langId;
			parameters.catalogId=catalogId;
			parameters.catentryId=catentryId;	
			parameters.orderItemId=orderItemId;
			parameters.curContractId=curContractId;
	
			dojo.xhrPost({
					url: "GetContractPriceData",				
					handleAs: "json-comment-filtered",
					content: parameters,
					service: this,
					load: this.populatePopUp,
					error: function(errObj,ioArgs) {
						console.debug("error - inside showPopup");
					}
				});
		}
	},

	/** 
	 * Hides the contract Price pop-up.
	 * @param {string} id The ID of the Contract Price pop-up that you want to hide.
	 * @param {object} event The event triggered from user actions. For example, key pressed or mouse click
	 */
	hidePopup: function(id,event){
	if(event!=null && event.type=="keypress" && event.keyCode!="27"){
			return;
		}else{		
			var pricingPopup = dijit.byId(id);
			if(pricingPopup != null){
				pricingPopup.hide();
			}
		}
	},
	
	/** 
	 * Populates the Contract Price pop-up with the JSON that is returned from the WebSphere Commerce Server.
	 * @param {object} serviceRepsonse The JSON response from the dojo.xhrPost service.
	 * @param {object} ioArgs The arguments from the dojo.xhrPost call.
	 */		
	populatePopUp: function(serviceResponse, ioArgs) {
		var numContracts = serviceResponse.numContracts;
		var orderItemId = serviceResponse.orderItemId
		var curContractId = serviceResponse.currentContractId;
		var tableData = '<form name="contractPriceUpdateForm" method="post" action="OrderChangeServiceItemUpdate" id="contractPriceUpdateForm">';

		if(!B2BOrderPricingPopup.isAjaxCheckOut()) {
			
			var urlToUse = "";
			var errorViewNameToUse = "";
			var orderIdToUse = "";

			if (B2BOrderPricingPopup.fromPage == 'pendingOrderDisplay' && B2BOrderPricingPopup.orderId != null && B2BOrderPricingPopup.orderId != "")
			{
				urlToUse = "PendingOrderDisplayView?orderId="+B2BOrderPricingPopup.orderId+"&storeId="+B2BOrderPricingPopup.storeId+"&catalogId="+B2BOrderPricingPopup.catalogId+"&langId="+B2BOrderPricingPopup.langId;
				errorViewNameToUse = "PendingOrderDisplayView";
				orderIdToUse = B2BOrderPricingPopup.orderId;
			}
			else
			{
				urlToUse = "AjaxOrderItemDisplayView?orderItemId*=&quantity*=&requestedShipDate*=&addressId*=&shipModeId*=";
				errorViewNameToUse = "AjaxOrderItemDisplayView";
				orderIdToUse = ".";
			}
			
		
			tableData = tableData + 
				'<input type="hidden" name="storeId" value="' + B2BOrderPricingPopup.storeId + '" id="WC_B2BOrderPricingPopup_inputs_1"/> ' +
				'<input type="hidden" name="langId" value="' + B2BOrderPricingPopup.langId + '" id="WC_B2BOrderPricingPopup_inputs_2"/> ' +
				'<input type="hidden" name="orderId" value="'+ orderIdToUse + '" id="WC_B2BOrderPricingPopup_inputs_3"/> ' +
				'<input type="hidden" name="catalogId" value="' + B2BOrderPricingPopup.catalogId + '" id="WC_B2BOrderPricingPopup_inputs_4"/> ' +
				'<input type="hidden" name="errorViewName" value="'+ errorViewNameToUse + '" id="WC_B2BOrderPricingPopup_inputs_5"/> ' +
				'<input type="hidden" name="URL" value="' + urlToUse + '" id=WC_B2BOrderPricingPopup_inputs_6"/> ' +
				'<input type="hidden" name="orderItemId_0" value="' + serviceResponse.orderItemId + '" id="WC_B2BOrderPricingPopup_inputs_7"/> ' +
				'<input type="hidden" name="contractId_0" value="" id="WC_B2BOrderPricingPopup_inputs_8"/> ' +
				'<input type="hidden" name="calculationUsage" value="-1,-2,-3,-4,-5,-6,-7" id="WC_B2BOrderPricingPopup_inputs_10"/> ';
		} 
		
		for (i=0; i<numContracts; i++) {
			var hasPriceRange = serviceResponse.contracts[i].hasPriceRange;
			var curContractPrice = serviceResponse.contracts[i].contractDisplayPrice; 
			var tieredPrice = serviceResponse.contracts[i].contractPrice;
			var contractId = serviceResponse.contracts[i].contractId;
			if (curContractPrice == null || curContractPrice == "undefined") {
				curContractPrice = serviceResponse.contracts[i].contractPrice; //no tiered price information. display the contractPrice 
			}
			
			tableData = tableData +
				'<div class="contractPriceRange contractPriceRangeBorder" role="row" id="contractPriceTable_row_' + i + '">	' +
					'<div class="li quantity_column" role="gridcell" id="contractPriceTable_row_' + i + '_price"> ';
			
			if (serviceResponse.contracts[i].contractId == curContractId) {
				tableData = tableData + 
						'<input type="radio" name="contractPriceUpdateFormContractId" id="WC_B2BOrderPricingPopup_inputs_9_' + i + '" value="' + serviceResponse.contracts[i].contractId + '"' + 'checked="checked"/> ';
			} else {
				tableData = tableData + 
						'<input type="radio" name="contractPriceUpdateFormContractId" id="WC_B2BOrderPricingPopup_inputs_9_' + i + '" value="' + serviceResponse.contracts[i].contractId + '"/> ';
			}
			
			tableData = tableData + 
						'<label for="WC_B2BOrderPricingPopup_inputs_9_' + i + '"> ' + curContractPrice + '</label> ' +
					'</div> ' +
					'<div class="li price_column" role="gridcell" id="contractPriceTable_row_' + i + '_contract"> ' +
						serviceResponse.contracts[i].contractName + 
					'</div> ';
					
			if (hasPriceRange) { 
				var link = "<div class='clear_float'></div><a class='contractPriceRangeTab' onclick=\"B2BOrderPricingPopup.priceRangeDisplayer(this,'"+contractId+"');\"><img class='closed' alt='>' src='"+B2BOrderPricingPopup.imgPath+"arrow_right.gif'>" + B2BOrderPricingPopup.linkText + "</a>"
				var pricingInfo = "<div class='contractPriceRangeTab' style='display:none' id='pricingInfo"+ contractId + "'>";
				pricingInfo +='<div class="ul column_heading">'+
							'<div class="li quantity_column">'+B2BOrderPricingPopup.quantityText+'</div>'+
							'<div class="li price_column">'+B2BOrderPricingPopup.priceText+'</div>'+							
							'<div class="clear_float"></div>'+
							'</div>';
				
				for ( var j in tieredPrice )
				{
					var contract = tieredPrice[j];
					for (var k in contract){
						var tmp = tieredPrice[j][k].split(":");
						
						pricingInfo += '<div class="contractPriceRange ul row2"><div class="li quantity_column">' +tmp[0]+ '</div>';
						pricingInfo += '<div class="li price_column">' +tmp[1]+ '</div><div class="clear_float"></div></div>';
					}
				} 
				
				pricingInfo +="</div>";
				tableData += link+pricingInfo;
			}
					
			tableData +='<div class="gridcell clear_float"></div> ' +
				'</div> ';
		}
		tableData = tableData + '</form>';
		document.getElementById('contractPriceTable').innerHTML = tableData;
		if(serviceResponse.isOrderItemADynamicKit == "true"){
			document.getElementById('contractPriceTable_header1_span').style.display = "none";
		}else{
			document.getElementById('contractPriceTable_header1_span').style.display = "block";
		}
		
		if (numContracts == 0) {
		document.getElementById('contractPriceUpdateButton').innerHTML =
			'<br clear="all" /> ' +
			'<div id="contract_error_popup" class="error_msg"> ' +
				B2BOrderPricingPopup.NO_PRICE_ERR_MSG +
			'</div> ';
		} else {
			document.getElementById('contractPriceUpdateButton').innerHTML =
				'<br clear="all" /> ' +
			'<span class="primary_button"> ' +
				'<span class="button_container"> ' +
					'<span class="button_bg"> ' +
						'<span class="button_top"> ' +
							'<span class="button_bottom"> ' +
								'<a id="pricingPopupUpdate" href="javascript:B2BOrderPricingPopup.updateContractForItem(' + orderItemId + ', ' + numContracts + ')">' + B2BOrderPricingPopup.SHOPCART_UPDATE + '</a>';
							'</span> ' +
						'</span> ' +
					'</span> ' +
				'</span> ' +
			'</span>';
		}
		
		document.getElementById('pricingPopupCloseLink').focus();
	},
	
	/** 
	 * Resets all contents of the contract Price pop-up.
	 */
	resetPopUp: function() {
		document.getElementById('contractPriceTable').innerHTML = '';
		document.getElementById('contractPriceUpdateButton').innerHTML = '';
	},
	
	/**
	 * Updates the contract price for a selected order item.
	 * @param {Integer} orderItemId The ID of the order item to update with the selected contract price.
	 * @param {Integer} numContracts The number of available contracts for the selected order item.
	 */
	updateContractForItem:function(orderItemId, numContracts){
		if(!this.isAjaxCheckOut()) {
			this.updateContractForItemNonAjax(orderItemId, numContracts);
		} else {
			this.updateContractForItemAjax(orderItemId, numContracts);
		}
	},

	/**
	 * Updates the contract price for a selected order item when the AJAX add to cart option is disabled.
	 * @param {Integer} orderItemId The ID of the order item to update with the selected contract price.
	 * @param {Integer} numContracts The number of available contracts for the selected order item.
	 */
	updateContractForItemNonAjax:function(orderItemId, numContracts){
		var i = 0;
		var found = false;

		if (numContracts == 1) {
			document.contractPriceUpdateForm.contractId_0.value = document.contractPriceUpdateForm.contractPriceUpdateFormContractId.value;
		} else {
			while (!found && i<numContracts) {
				if (document.contractPriceUpdateForm.contractPriceUpdateFormContractId[i].checked) {
					document.contractPriceUpdateForm.contractId_0.value = document.contractPriceUpdateForm.contractPriceUpdateFormContractId[i].value;
					found = true;
				}
				i++;
			}
		}		
		
		document.contractPriceUpdateForm.submit();
	},
	
	/**
	 * Updates the contract price for a selected order item when the AJAX add to cart option is enabled.
	 * @param {Integer} orderItemId The ID of the order item to update with the selected contract price.
	 * @param {Integer} numContracts The number of available contracts for the selected order item.
	 */
	updateContractForItemAjax:function(orderItemId, numContracts){
		var params = [];
		var i = 0;
		var found = false;

		if (numContracts == 1) {
			params["contractId_0"] = document.contractPriceUpdateForm.contractPriceUpdateFormContractId.value;
		} else {
			while (!found && i<numContracts) {
				if (document.contractPriceUpdateForm.contractPriceUpdateFormContractId[i].checked) {
					params["contractId_0"] = document.contractPriceUpdateForm.contractPriceUpdateFormContractId[i].value;
					found = true;
				}
				i++;
			}
		}
		params["orderItemId_0"] = orderItemId;
		params["storeId"] = this.storeId;
		params["catalogId"] = this.catalogId;
		params["langId"] = this.langId;
		params.orderId = ".";
		params.calculationUsage = "-1,-2,-7";

		//For handling multiple clicks
		if(!submitRequest()){
			return;
		}                 
		cursor_wait();
		wc.service.invoke("AjaxUpdateOrderItem", params);
		this.hidePopup('pricing_popup');
	},
	
	/**
	 *  Sets the order ID when it is not called from the current order.
	 * 	This is the case when it is being called from the pending order details page.
	 * 
	 * @param {String} orderId The order ID to use.
	 */
	setOrderId: function(orderId)
	{
		this.orderId = orderId;
	},
	
	/** 
	 * Sets the source page that called or included the B2BOrderPricingPopup.js file.
	 * Details page is currently set as the source page.
	 * 
	 * @param {String} fromPage The source page that called the B2BOrderPricingPopup.js file.
	 */
	setFromPage: function(fromPage)
	{ 
		this.fromPage = fromPage;
	},
	
	
	/**
	 * this function takes in the dom of the price range link that was clicked and expands or collapses the details
	 * @param (object) e the DOM object 
	 * @param (String) contractId unique identifier of the table to show or hide
	 */ 
	priceRangeDisplayer:function (e,contractId) {
		// set some initial variables
		var arrow = e.getElementsByTagName('img')[0];
		var table = document.getElementById("pricingInfo"+contractId)

		// check whether we want to open or close the price range box
		if (arrow.className == "closed") {
			arrow.src = this.imgPath+"/arrow_down.gif";
			arrow.className = "opened";
			table.style.display = 'block';
		}
		else {
			arrow.src = this.imgPath+"/arrow_right.gif";
			arrow.className = "closed";
			table.style.display = 'none';
		}
	},

	/**
	 * On pressing Shift+Tab keys, the focus is tranferred from Close button to the last focusable element present in 
	 * the "Order Pricing" pop-up.
	 * @param (object) event Event object 
	 */ 
	setbackFocus:function (event){
		if(event.shiftKey && event.keyCode == dojo.keys.TAB)
		{
			document.getElementById('pricingPopupUpdate').focus();
			dojo.stopEvent(event);
		}
	}

}