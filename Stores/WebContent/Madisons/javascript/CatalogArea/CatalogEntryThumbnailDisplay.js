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
 * @fileOverview This file is to be included in all full pages that use the CatalogEntryThumbnailDisplay.jspf.
 * It prepares all the code required for the Product Quick Info pop-up reveal.
 */

	//Make the Product Quick Info pop-up window movable.
	dojo.require("dojo.dnd.move");
	dojo.require("dijit.Dialog");
	dojo.require("dojo._base.event");
	
	/** The variable stores the Product Quick Info pop-up window. */
	var m1;
	
	/** The variable stores the identifier of the order item to be replaced */
	var replaceOrderItemId;
	
	/** 
	 * Initializes the Product Quick Info pop-up window to a movable dialog.
	 */	
	var initPopup = function(){
		m1 = new dojo.dnd.Moveable("second_level_category_popup", {handle: "popupHeader"});
	};
	
	dojo.addOnLoad(initPopup);

	/** 
	 * Displays the Product Quick Info button.
	 * 
	 * @param {string} id The id of the div area to show.
	 */
	function showPopupButton(id){
		if(document.getElementById("popupButton_"+id)!=null && document.getElementById("popupButton_"+id)!='undefined'){
			var popupButton = document.getElementById("popupButton_"+id);
			popupButton.style.visibility="visible";
		}
	}

	/** 
	 * Hides the Product Quick Info button.
	 * 
	 * @param {string} id The id of the div area to hide. 
	 */	
	function hidePopupButton(id){
		if(document.getElementById("popupButton_"+id)!=null && document.getElementById("popupButton_"+id)!='undefined') {
			var popupButton = document.getElementById("popupButton_"+id);
			popupButton.style.visibility="hidden";
		}
	}
	 
	 /** 
		 * Overrides the hidePopupButton function above by also checking to see if the user clicks shift+tab.
		 * 
		 * @param {string} id The id of the div area to hide. 
		 * @param {event} event The keystroke event entered by the user. 
		 */	
	 function shiftTabHidePopupButton(id, e){
		 if ((e.shiftKey) && (dojo.keys.TAB)){
				 
				 hidePopupButton(id);
			 } 
			 
		}
		 
	 

	/** 
	 * Displays the Product Quick Info pop-up containing product information.
	 * Retrieves product information in JSON format via an Ajax call.
	 * 
	 * @param {string} productId The id of the product to display.
	 * @param {string} storeId The id of the current store.
	 * @param {string} langId The id of the language used in the store.
	 * @param {string} catalogId The id of the current store catalog.
	 * @param {string} event The event triggered from user actions.
	 * @param {string} targetId The id of the dojo element to display the pop-up next to.
	 * @param {string} nodeId The id of element to display the pop-up around on <Enter> key click.
	 * @param {object} productActionList The object containing Product Quick Info pop-up action list settings.
	 * @param {string} popUpQty The quantity to be displayed for this product.
	 */		
	function showPopup(productId,storeId,langId, catalogId, event,targetId,nodeId,productActionList,popUpQty){
		if(event == null || (event != null && event.type!="keypress") || (event != null && event.type=="keypress" && event.keyCode==13)){
			resetPopUp();
			
			//Default action list is used if it is not passed into this method
			if(productActionList == null){
				productActionList = new popupActionProperties();
			}
			
			//From the productActionList object properties
			//hide/show the action links from the Quick Info 		
			if(productActionList.showAddToCart){
				if(document.getElementById('addToCartAjaxButton')){
					document.getElementById('addToCartAjaxButton').style.visibility='visible';
				} else if(document.getElementById('addToCartButton')){
					document.getElementById('addToCartButton').style.visibility='visible';
				}			
			} else {
				if(document.getElementById('addToCartAjaxButton')){
					document.getElementById('addToCartAjaxButton').style.visibility='hidden';
				} else if(document.getElementById('addToCartButton')){
					document.getElementById('addToCartButton').style.visibility='hidden';
				}			
			}
	
			if(productActionList.showWishList){
				if(document.getElementById('addToWishListLinkAjax')){
					document.getElementById('addToWishListLinkAjax').style.display='block';
				} else if(document.getElementById('addToWishListLink')){
					document.getElementById('addToWishListLink').style.display='block';
				}
			} else {
				if(document.getElementById('addToWishListLinkAjax')){
					document.getElementById('addToWishListLinkAjax').style.display='none';
				} else if(document.getElementById('addToWishListLink')){
					document.getElementById('addToWishListLink').style.display='none';
				}
			}
					
			if(productActionList.showProductCompare && document.getElementById('compare')){
				if(document.getElementById('addToCompareLink')){
					document.getElementById('addToCompareLink').style.display='block';
				}
			} else {
				if(document.getElementById('addToCompareLink')){
					document.getElementById('addToCompareLink').style.display='none';
				}
			}		
			
			
			if(productActionList.showReplaceCartItem){
				if(document.getElementById('replaceCartItemAjax')){
					document.getElementById('replaceCartItemAjax').style.display = 'block';
				} else if(document.getElementById('replaceCartItemNonAjax')){
					document.getElementById('replaceCartItemNonAjax').style.display = 'block';
				}		

				//When showing the quick info pop-up for replace item flow
				//Don't show the requisition list links
				if(document.getElementById('addToNewRequisitionList')){
					document.getElementById('addToNewRequisitionList').style.display = 'none';
				}
				if(document.getElementById('addToExistingRequisitionList')){
					document.getElementById('addToExistingRequisitionList').style.display = 'none';
				}				
			} else {
				if(document.getElementById('replaceCartItemAjax')){
					document.getElementById('replaceCartItemAjax').style.display = 'none';
				} else if(document.getElementById('replaceCartItemNonAjax')){
					document.getElementById('replaceCartItemNonAjax').style.display = 'none';
				}		
			}		
			
			//Do not display the Quantity field if the product is not buyable
			if(!productActionList.showAddToCart && !productActionList.showWishList){
				if(document.getElementById('productPopUpQty')){
					document.getElementById('productPopUpQty').disabled = true;
				}
			} else {
				if(document.getElementById('productPopUpQty')){
					document.getElementById('productPopUpQty').disabled = false;
				}
			}
			//Set the quantity to Quantity field
			if(popUpQty == null)
			{
				document.getElementById('productPopUpQty').value = 1;
			}else {
				document.getElementById('productPopUpQty').value = popUpQty;
			}
		
			dijit.byId('second_level_category_popup').closeButtonNode.style.display='none';
			dijit.byId('second_level_category_popup').show();
			
			// hides the DialogUnderlayWrapper component, the component that grays out the screen behind,
			// as we do not want the background to be greyed out
			dojo.query('.dijitDialogUnderlayWrapper', document).forEach(function(tag) {		
				tag.style.display='none';
			});		
			
			var parameters = {};
			parameters.storeId = storeId;
			parameters.langId=langId;
			parameters.catalogId=catalogId;
			parameters.productId=productId;	
	
			dojo.xhrPost({
					url: getAbsoluteURL() + "GetCatalogEntryDetailsByID",				
					handleAs: "json-comment-filtered",
					content: parameters,
					service: this,
					load: populatePopUp,
					error: function(errObj,ioArgs) {
						console.debug("CatalogEntryThumbnailDisplay.showPopup: Unexpected error occurred during an xhrPost request.");
					}
				});
		}
	}

	/** 
	 * Populates all the contents of the Product Quick Info pop-up with the JSON returned from the server.
	 * 
	 * @param {object} serviceRepsonse The JSON response from the service.
	 * @param {object} ioArgs The arguments from the service call.
	 */		
	function populatePopUp(serviceResponse, ioArgs) {
		 //populate the entitledItemJsonObject
		 categoryDisplayJS.setEntitledItemJsonObject(serviceResponse.productAttributes);
		 
		var catEntryID = serviceResponse.catalogEntry.catalogEntryIdentifier.uniqueID;
		var isProductBean = false;
		if(serviceResponse.catalogEntry.catalogEntryTypeCode=='ProductBean') {
			isProductBean = true;
		}
		var isBundleBean = false;
		if(serviceResponse.catalogEntry.catalogEntryTypeCode=='BundleBean') {
			isBundleBean = true;
		}
		var isItemBean = false;
		if(serviceResponse.catalogEntry.catalogEntryTypeCode=='ItemBean') {
			isItemBean = true;
		}
		
		var isPackageBean = false;
		if(serviceResponse.catalogEntry.catalogEntryTypeCode=='PackageBean') {
			isPackageBean = true;
		}
		document.getElementById('productIdQuickInfo').innerHTML = catEntryID;
		document.getElementById('productName').innerHTML = serviceResponse.catalogEntry.description[0].name;
		var baseImageUrl = dojo.byId('baseUrlImageDir').innerHTML;
		if ( serviceResponse.catalogEntry.description[0].fullImage != serviceResponse.catalogEntry.objectPath){
			document.getElementById('productFullImage').src = serviceResponse.catalogEntry.description[0].fullImage;
		}
		else{
			document.getElementById('productFullImage').src = baseImageUrl + "images/NoImageIcon.jpg";
		}
		
		if (serviceResponse.catalogEntry.offerPrice) {
			document.getElementById('productPrice').innerHTML = serviceResponse.catalogEntry.offerPrice;
		}
		
		document.getElementById('productLongDescription').innerHTML = serviceResponse.catalogEntry.description[0].longDescription + '<br />';
		
		var descAttributesHTML = "";
		for (var i in serviceResponse.catalogEntryAttributes.attributes) {
			if (serviceResponse.catalogEntryAttributes.attributes[i].usage == "Descriptive" ) 
			{				
				descAttributesHTML = descAttributesHTML + serviceResponse.catalogEntryAttributes.attributes[i].name + ' : ';
				if (serviceResponse.catalogEntryAttributes.attributes[i].value != null )
				{
					descAttributesHTML = descAttributesHTML + serviceResponse.catalogEntryAttributes.attributes[i].value.value + '<br />';
				}
				else
				{
					descAttributesHTML = descAttributesHTML + '<br />';
				}			
			}
		}
		document.getElementById('productDescriptiveAttributes').innerHTML = descAttributesHTML;
		
		document.getElementById('productSKUValue').innerHTML = serviceResponse.catalogEntry.catalogEntryIdentifier.externalIdentifier.partNumber;
		document.getElementById('productMoreInfoLink').href = serviceResponse.catalogEntryURL;
		
		for (var i in serviceResponse.catalogEntryPromotions) {
			document.getElementById('productPromotions').innerHTML = serviceResponse.catalogEntryPromotions[i] + '<br />';
		}
		if(document.getElementById("selectedAttr_"+replaceOrderItemId) !=null)
		var selectedAttributeArray = document.getElementById("selectedAttr_"+replaceOrderItemId).value.toString().split("|");
		categoryDisplayJS.moreInfoUrl='ProductDisplay?storeId='+storeId+'&catalogId='+catalogId+'&langId='+langId+'&productId='+catEntryID;

		var attributesHTML = "";
		for (var i in serviceResponse.catalogEntryAttributes.attributes) {
			if (serviceResponse.catalogEntryAttributes.attributes[i].usage == "Defining") {
				if (isProductBean) {
					attributesHTML = attributesHTML + '<label for="attrValue_'+ i + '" class="nodisplay">'+serviceResponse.catalogEntryAttributes.attributes[i].name+document.getElementById('requiredFieldText').innerHTML+'</label><span class="required-field">* </span><span>' + serviceResponse.catalogEntryAttributes.attributes[i].name + ' : </span>';
					attributesHTML = attributesHTML + '<select name="attrValue" class="drop_down" id="attrValue_' + i + '" onChange="JavaScript:categoryDisplayJS.setSelectedAttribute(\'' + (serviceResponse.catalogEntryAttributes.attributes[i].name).replace("'","\\'") + '\',this.options[this.selectedIndex].value);updateMoreInfoUrl();">';
					attributesHTML = attributesHTML + '<option value="">'+document.getElementById("selectText").innerHTML+'</option>';
					for (var j in serviceResponse.catalogEntryAttributes.attributes[i].allowedValue) {
						if(document.getElementById("selectedAttr_"+replaceOrderItemId) !=null && serviceResponse.catalogEntryAttributes.attributes[i].allowedValue[j].value == selectedAttributeArray[i]){
							var selected = 'selected';
							categoryDisplayJS.setSelectedAttribute(serviceResponse.catalogEntryAttributes.attributes[i].name,selectedAttributeArray[i]);
							updateMoreInfoUrl();
							attributesHTML = attributesHTML + '<option value="' + serviceResponse.catalogEntryAttributes.attributes[i].allowedValue[j].value +'"selected='+selected+'>' + serviceResponse.catalogEntryAttributes.attributes[i].allowedValue[j].value + '</option>';
						}
						else{
						attributesHTML = attributesHTML + '<option value="' + serviceResponse.catalogEntryAttributes.attributes[i].allowedValue[j].value +'">' + serviceResponse.catalogEntryAttributes.attributes[i].allowedValue[j].value + '</option>';	
					}
				}
					attributesHTML = attributesHTML + '</select><br />';
				} else {
					attributesHTML = attributesHTML + serviceResponse.catalogEntryAttributes.attributes[i].name + ' : ' + serviceResponse.catalogEntryAttributes.attributes[i].value.value + '<br />';
				}
			}
		}
		if (attributesHTML != '') {
			attributesHTML = attributesHTML + '<br />';
		}
		document.getElementById('productAttributes').innerHTML = attributesHTML;
		
		
		if(isBundleBean){
			if(document.getElementById('productPopUpQty')){
				document.getElementById('productPopUpQty').disabled = true;
			}
			document.getElementById('productActions').style.display = 'none';
			document.getElementById('moreinfo').style.display = 'block';
		}
		else{
			document.getElementById('productActions').style.display = 'block';
			document.getElementById('moreinfo').style.display = 'none';
			
			categoryDisplayJS.setCurrentCatalogEntryId(catEntryID);
			
			//Populate the links for adding items/products/packages to requisition list
			if(isProductBean){
				if(document.getElementById('addToNewRequisitionList')){
					categoryDisplayJS.setCurrentPageType("product");	
					document.getElementById('addToNewRequisitionList').href = "javascript:categoryDisplayJS.addToNewListFromProductDetail('entitledItem_"+catEntryID+"', 'productPopUpQty', document.location.href);";
					document.getElementById('addToExistingRequisitionList').href = "javascript:RequisitionList.showReqListPopupForItem('entitledItem_"+catEntryID+"', 'productPopUpQty');";
				}				
			} else if(isItemBean || isPackageBean){
				if(document.getElementById('addToNewRequisitionList')){
					if(isItemBean){
						categoryDisplayJS.setCurrentPageType("item");
					} else {
						categoryDisplayJS.setCurrentPageType("package");
					}
					document.getElementById('addToNewRequisitionList').href = "javascript:categoryDisplayJS.addItemToNewListFromProductDetail('" + catEntryID + "', 'productPopUpQty', document.location.href);";
					document.getElementById('addToExistingRequisitionList').href = "javascript:RequisitionList.showReqListPopup('productPopUpQty');";
				}		
			}
		}
		
		// Setup addToCart button
		if(isBundleBean){
			// Disable add to cart for Bundles in all cases
			if(document.getElementById('addToCartAjaxButton')){
				document.getElementById('addToCartAjaxButton').style.visibility='hidden';
			} else if(document.getElementById('addToCartButton')){
				document.getElementById('addToCartButton').style.visibility='hidden';
			}
		} else {
			var addtoCart;
			if(document.getElementById('addToCartLinkAjax')){
				if(isProductBean) {
					addtoCart = document.getElementById('addToCartLinkAjax');
					addtoCart.href = "JavaScript:categoryDisplayJS.Add2ShopCartAjax('entitledItem_"+catEntryID+"',document.getElementById('productPopUpQty').value, true);";
				} else {
					addtoCart = document.getElementById('addToCartLinkAjax');
					addtoCart.href = "JavaScript:categoryDisplayJS.AddItem2ShopCartAjax('"+catEntryID+"',document.getElementById('productPopUpQty').value); hidePopup('second_level_category_popup');";
				}
			}
			if(document.getElementById('addToCartLink')){
				if(isProductBean) {
					addtoCart = document.getElementById('addToCartLink');
					addtoCart.href = "#";
					//Must dynamically set the onclick event as follows for IE6
					addtoCart.onclick = new Function("categoryDisplayJS.Add2ShopCart('entitledItem_"+catEntryID+"',document.getElementById('OrderItemAddForm_"+catEntryID+"'),document.getElementById('productPopUpQty').value, true); return false;");
				} else {
					addtoCart = document.getElementById('addToCartLink');
					addtoCart.href = "#";
					//Must dynamically set the onclick event as follows for IE6
					addtoCart.onclick = new Function("categoryDisplayJS.AddItem2ShopCart(document.getElementById('OrderItemAddForm_"+catEntryID+"'),document.getElementById('productPopUpQty').value); hidePopup('second_level_category_popup');return false;");
				}
			}
		}

		
		if (document.getElementById('addToWishListLinkAjax')) {
			if(isItemBean || isPackageBean){
			document.getElementById('addToWishListLinkAjax').href = "JavaScript:categoryDisplayJS.AddItem2WishListAjax("+catEntryID+"); hidePopup('second_level_category_popup');";
			}
			else{
			document.getElementById('addToWishListLinkAjax').href = "JavaScript:categoryDisplayJS.Add2WishListAjax('entitledItem_"+catEntryID+"'); hidePopup('second_level_category_popup');";
			}
		} else if(document.getElementById('addToWishListLink')) {
			document.getElementById('addToWishListLink').href = "#";
			//Must dynamically set the onclick event as follows for IE6
			if(isItemBean || isPackageBean){
			document.getElementById('addToWishListLink').onclick = new Function("categoryDisplayJS.AddItem2WishList(document.getElementById('OrderItemAddForm_"+catEntryID+"'));hidePopup('second_level_category_popup');return false;");
			}
			else{
			document.getElementById('addToWishListLink').onclick = new Function("categoryDisplayJS.Add2WishList('entitledItem_"+catEntryID+"',document.getElementById('OrderItemAddForm_"+catEntryID+"')); hidePopup('second_level_category_popup');return false;");
			}
		}
		if (document.getElementById('addToCompareLink')) {
			document.getElementById('addToCompareLink').href = "JavaScript:categoryDisplayJS.Add2CompareAjax('"+catEntryID+"', '" + serviceResponse.productCompareImagePath +"', '" + serviceResponse.catalogEntryURL+ "','"+serviceResponse.compareImageDescription+"'); delayHidePopup();";
		}
		if (document.getElementById('replaceCartItemAjax')) {
			document.getElementById('replaceCartItemAjax').href = "JavaScript:categoryDisplayJS.ReplaceItemAjax('entitledItem_"+catEntryID+"',document.getElementById('productPopUpQty').value); hidePopup('second_level_category_popup');";
		}
		if (document.getElementById('replaceCartItemNonAjax')) {
			document.getElementById('replaceCartItemNonAjax').href = "#";
			//Must dynamically set the onclick event as follows for IE6			
			document.getElementById('replaceCartItemNonAjax').onclick = new Function("categoryDisplayJS.ReplaceItemNonAjax('entitledItem_"+catEntryID+"',document.getElementById('productPopUpQty').value,document.getElementById('ReplaceItemForm')); hidePopup('second_level_category_popup');return false;");
		}
		gobackFocus();//set the default focus to the Close button
	}
	
	/**
	 *  This function is used to dynamically update the more info link url based on the selection of attributes in the 
	 *  Quickinfo popup.
	 */

	function updateMoreInfoUrl() {
			document.getElementById('productMoreInfoLink').href = categoryDisplayJS.moreInfoUrl;
	}
	/** 
	 * Reset all contents of the Product Quick Info pop-up.
	 * This dialog will be re-used across all products on the page.
	 */			
	function resetPopUp() {
		document.getElementById('productName').innerHTML = "";
		document.getElementById('productPrice').innerHTML = "";
		document.getElementById('productLongDescription').innerHTML = "";
		document.getElementById('productDescriptiveAttributes').innerHTML = "";
		document.getElementById('productSKUValue').innerHTML = "";
		document.getElementById('productMoreInfoLink').href = "";
		document.getElementById('productPromotions').innerHTML = "";
		if(document.getElementById('productPopUpQty')){
			document.getElementById('productPopUpQty').disabled = false;
			document.getElementById('productPopUpQty').value = "1";
		}
		
		document.getElementById('productAttributes').innerHTML = "";
		if (document.getElementById('addToCartLinkAjax')) {
			document.getElementById('addToCartLinkAjax').href = "";
		} else if (document.getElementById('addToCartLink')) {
			document.getElementById('addToCartLink').href = "";
		}
		
		if (document.getElementById('addToWishListLinkAjax')) {
			document.getElementById('addToWishListLinkAjax').href = "";
		} else if (document.getElementById('addToWishListLink')) {
			document.getElementById('addToWishListLink').href = "";
		}
		
		if (document.getElementById('addToCompareLink')) {
			document.getElementById('addToCompareLink').href = "";
		}
		if(document.getElementById('replaceCartItemAjax')){
			document.getElementById('replaceCartItemAjax').href= "";
		} else if(document.getElementById('replaceCartItemNonAjax')){
			document.getElementById('replaceCartItemNonAjax').href = "";
		}
		//set the default product image - NoImageIcon.jpg
		if (dojo.byId('baseUrlImageDir')){
		    var baseImageUrl = dojo.byId('baseUrlImageDir').innerHTML;
		    dojo.byId('productFullImage').src = baseImageUrl + "images/NoImageIcon.jpg";
		}		
		categoryDisplayJS.selectedAttributes = new Object();
		categoryDisplayJS.selectedProducts = new Object();
	}
	
	/** 
	 * Hides the Product Quick Info pop-up.
	 * 
	 * @param {string} id The id of the Product Quick Info pop-up to hide.
	 * @param {object} event The event triggered from user actions.
	 */		
	function hidePopup(id,event){
	if(event!=null && event.type=="keypress" && event.keyCode!="27"){
			return;
		}else{		
			var quickInfo = dijit.byId(id);
			if(quickInfo != null){
				quickInfo.hide();
			}
		}
	}

	/** 
	 * Stores the identifier of the order item which is the candidate for replacement.
	 * 
	 * @param {string} changeOrderItemId The id of the order item to be replaced.
	 */	
	function saveChangeOrderItemId(changeOrderItemId){
		replaceOrderItemId = changeOrderItemId;
	}

	/** 
	 * Defines the list of actions that show up in the Product Quick Info pop-up.
	 * Each property corresponds to an action.
	 * Default settings show the first 3 links.
	 */	
	function popupActionProperties() {
		this.showAddToCart = true;
		this.showWishList = true;
		this.showProductCompare = true;
		this.showReplaceCartItem = false;
	}

	/** 
	 * Transfers the focus to the "Close" button,
	 * when pressing the <Tab> key on the last focusable element in the Product Quick Info pop-up.
	 */	
	function gobackFocus() {
		document.getElementById('closeLink').focus();
	}

	/** 
	 * Transfers the focus to the last focusable element present in the Product Quick Info pop-up,
	 * when pressing the <Shift+Tab> keys on the "Close" button.
	 */		
	function setbackFocus(event) {
		if(event.shiftKey && event.keyCode == dojo.keys.TAB)
		{
			if(document.getElementById('replaceCartItemNonAjax') && document.getElementById('replaceCartItemNonAjax').style.display!="none") {
				document.getElementById('replaceCartItemNonAjax').focus();
			} else if(document.getElementById('replaceCartItemAjax') && document.getElementById('replaceCartItemAjax').style.display!="none") {
				document.getElementById('replaceCartItemAjax').focus();
			} else if(document.getElementById('addToCompareLink') && document.getElementById('addToCompareLink').style.display!="none") {
				document.getElementById('addToCompareLink').focus();
			} else if(document.getElementById('addToWishListLink') && document.getElementById('addToWishListLink').style.display!="none") {
				document.getElementById('addToWishListLink').focus();
			} else if(document.getElementById('addToWishListLinkAjax') && document.getElementById('addToWishListLinkAjax').style.display!="none") {
				document.getElementById('addToWishListLinkAjax').focus();
			} else {
				document.getElementById('productMoreInfoLink').focus();
			}
			
			dojo.stopEvent(event);
		}
	}
	
	/** 
	 * Triggers a call to the hidePopup() function after a delay of a certain amount of time.
	 */			
	function delayHidePopup() {
		setTimeout(dojo.hitch(this,"hidePopup",'second_level_category_popup'),200);
	}
