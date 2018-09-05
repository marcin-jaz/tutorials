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

//<%--
//********************************************************************
//*-------------------------------------------------------------------
//* Licensed Materials - Property of IBM
//*
//* WebSphere Commerce
//*
//* (c) Copyright IBM Corp.  2008, 2009
//* All Rights Reserved
//*
//* US Government Users Restricted Rights - Use, duplication or
//* disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
//*
//*-------------------------------------------------------------------
//*
//--%>

/** 
 * @fileOverview This file is to be included in pages that use the B2BCatentryContractSelectExt.jspf. 
 * It prepares all the code required for the "item availability for physical store" section.
 */
	
	
	/** the current catalog entry id used to identify a section in bundle page where there are multiple inventory detail sections */
	var currentCatentryId; 	

	/** 
	* Sets the current catentryId in order to identify the sections on a bundle page
	* @param {String} catentryId A catalog entry id	
	*/
	function setCurrentCatentryId(catentryId) {
		currentCatentryId = catentryId;
	}
	
	/** 
	* Gets the item ID of the catentry which we need to find out inventory information about.
	* This function resolves the proper SKU if the product has defining attributes and the shopper
	* has properly selected some attributes.
	* @param {String} entitledItemId name of DIV element containing the product and items information
	*                                for a catalog entry. The DIV must contain the information in JSON
	*                                format. To see the expected JSON format, see the 
	*                                "entitledItem_<catalogentryId>" in the generated HTML source. 
	* @return {String} catalogEntryId item ID
	*/
	function getItemId(entitledItemId)
	{	
		var entitledItemJSON = eval('('+ dojo.byId(entitledItemId).innerHTML +')');
		categoryDisplayJS.setEntitledItems(entitledItemJSON);
		var catalogEntryId = categoryDisplayJS.getCatalogEntryId();
		return catalogEntryId;
	}
	/**
	* Gets the item ID of the catentry which is part of a bundle.
	* This function resolves the proper SKU if the product has defining attributes and the shopper
	* has properly selected some attributes.
	* @param {String} catalogEntryId The product id for which the SKU needs to be resolved
	*
	* @return {String} catEntryId item ID
	*/
	function getItemIdForBundle(catalogEntryId)
	{	
		var catEntryId = null;
		if(categoryDisplayJS.selectedProducts[catalogEntryId]){
			catEntryId = categoryDisplayJS.getCatalogEntryIdforProduct(categoryDisplayJS.selectedProducts[catalogEntryId]);
		}
		return catEntryId;
	}
		
	/** 
	* Get the available contract for a catentry. This function makes AJAX call to the Commerce server to gather
	* available contracts to use. The information is then processed by the populateContractDetails function
	* in order to display the information in the product display page.
	* @param {String} catentryId The catalog entry id of the contract selection section
	* @param {String} itemId The itemId of the product that we will fetch available contract for
	* @param {String} storeId The store id
	* @param {String} langId The language id
	* @param {String} catalogId The catalog id
	* @param {boolean} isBundle indicates if the product page is a bundle page
	*/
	function getContractsForCatentry(catentryId,itemId,storeId,langId,catalogId,isBundle) {
			if (catentryId == null) {
				catentryId = "";
			}
			setCurrentCatentryId(catentryId);
			MessageHelper.hideAndClearMessage();
			
			var parameters = {};
			parameters.storeId = storeId;
			parameters.langId=langId;
			parameters.catalogId=catalogId;
			parameters.catentryId=itemId;	
			parameters.orderItemId=".";
			parameters.isBundle=isBundle;
			
			dojo.xhrPost({
					url: "GetContractPriceData",
					handleAs: "json-comment-filtered",
					content: parameters,
					service: this,
					load: populateContractDetails,
					error: function(errObj,ioArgs) {
						console.debug("error - inside getContractsForCatentry");
					}
			});
	}
	
	/**
	* Populate the contents of the contract selection section in the product display page with the JSON returned from
	* the server. This is the callback function that is called after the AJAX call to get available contracts of a catentry 
	* @param {Object} serviceResponse response object from dojo.xhrPost
	* @param {dojo.__IoCallbackArgs} ioArgs Argument to the IO call from dojo.xhrPost
	*/
	function populateContractDetails(serviceResponse, ioArgs) {
		var numContracts = serviceResponse.numContracts;
		var curContractId = serviceResponse.currentContractId;
		var tableData = '';
		var lowestPrice = -1;
		var fromBundle = serviceResponse.fromBundlePage;
		var lowestPriceIndex = -1;
		for (i=0; i<numContracts; i++) {
			var curContractPrice = serviceResponse.contracts[i].contractDisplayPrice; //using the display price for sorting. not to be confused with the tiered pricing
			if (curContractPrice == null || curContractPrice == "undefined") {
				curContractPrice = serviceResponse.contracts[i].contractPrice; //can't sort if contractDisplayPrice is null; use contractPrice to sort.
			}
			if (lowestPrice == -1 || curContractPrice < lowestPrice) {
				lowestPrice = curContractPrice;
				lowestPriceIndex = i;
			}
		}

		for (i=0; i<numContracts; i++) {
			// by default, select the contract with lowest price 
			var curContractPrice = serviceResponse.contracts[i].contractDisplayPrice; 
			if (curContractPrice == null || curContractPrice == "undefined") {
				curContractPrice = serviceResponse.contracts[i].contractPrice; //no tiered price information. display the contractPrice 
			}
			var hasPriceRange = serviceResponse.contracts[i].hasPriceRange;
			var contractId = serviceResponse.contracts[i].contractId;
			var tieredPrice = serviceResponse.contracts[i].contractPrice;
			tableData = tableData + "<div class='font3' id='" +contractId + "'>" + '<input type="radio" ';
			if (fromBundle == 'true') {
				tableData = tableData + 'name="contractSelectForm_contractId_' + currentCatentryId + '"';
			} else {
				tableData = tableData + 'name="contractSelectForm_contractId"';
			}
			tableData = tableData + ' id="WC_B2BContractSelect_' + currentCatentryId + '_' + i + '" value="' + contractId + '"';
			if (i == lowestPriceIndex) {
				tableData = tableData + 'checked="checked"/> ';
				lowestPrice = curContractPrice;
			} else {
				tableData = tableData + '/> ';
			}
					
			tableData = tableData + '<label for="WC_B2BContractSelect_' + currentCatentryId + '_' + i + '">' + curContractPrice + ' ' + serviceResponse.contracts[i].contractName + '</label> ';
			if (hasPriceRange) {
				var link = "<br/><a class='contractPriceRange contractPriceRangeTab' onclick=\"priceRangeDisplayer(this,'"+contractId+"');\"><img class='closed' alt='>' src='"+imgPath+"arrow_right.gif'>" + linkText + "</a>"
				var pricingInfo = "<div class='contractPriceRange contractPriceRangeTab nodisplay' id='pricingInfo"+ contractId + "'>";
				pricingInfo +='<div class="ul column_heading">'+
							'<div class="li quantity_column">'+quantity+'</div>'+
							'<div class="li price_column">'+price+'</div>'+							
							'<div class="clear_float"></div>'+
							'</div>';
				for ( var j in tieredPrice )
				{
					var contract = tieredPrice[j];
					for (var k in contract){
						var tmp = tieredPrice[j][k].split(":");
						
						pricingInfo += '<div class="contractPriceRange ul row"><div class="li quantity_column">' +tmp[0]+ '</div>';
						pricingInfo += '<div class="li price_column">' +tmp[1]+ '</div><div class="clear_float"></div></div>';
					}
				} 
				
				pricingInfo +="</div>";
				tableData += link+pricingInfo;
			}
			tableData = tableData + '</div><div class="br1"></div>';
		}
		
		var selectSection = document.getElementById('avail_contract_message_' + currentCatentryId);
		if (selectSection != null && selectSection != "undefined") {
			selectSection.style.display = "block";
		}

		document.getElementById('storeShowContract_' + currentCatentryId).innerHTML = tableData;
	}
	
	
	
	/**
	 * this function takes in the dom of the price range link that was clicked and expands or collapses the details
	 * @param (object) e the DOM object
	 * @param (String) contractId unique identifier of the table to show or hide
	 */ 
	function priceRangeDisplayer(e,contractId) {
		// set some initial variables
		var arrow = e.getElementsByTagName('img')[0];
		var table = document.getElementById("pricingInfo"+contractId)

		// check whether we want to open or close the price range box
		if (arrow.className == "closed") {
			arrow.src = imgPath+"/arrow_down.gif";
			arrow.className = "opened";
			table.style.display = 'block';
		}
		else {
			arrow.src = imgPath+"/arrow_right.gif";
			arrow.className = "closed";
			table.style.display = 'none';
		}
	}

	
	

