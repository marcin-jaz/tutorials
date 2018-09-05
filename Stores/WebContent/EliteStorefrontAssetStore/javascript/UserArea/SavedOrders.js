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
 * @fileOverview This javascript file contains all the methods needed to support the saved orders function.
 * It is used by ListOrdersDisplay.jsp, ListOrdersDisplayTable.jsp and SavedOrdersToolbar.jspf.
 * @version 1.0
 **/	
	
/**
* @class savedOrdersJS The savedOrdersJS class defines the functions and variables that are used by the SavedOrders.js file. 
* This class and its methods support the saved orders function. In order to use any of the functionality of the saved order behaviour you
* will have to use this class, and include the SavedOrders.js file.
* 
* To initialize the saved orders functionality you will have to do the following:
* 	<ol>  
* 		<li>Call the setCommonParameters function in order to set the language ID, store ID, and catalog ID</li>
* 		<li>Call the setImgParameters function for each icon in the saved orders toolbar to set the enabled and disabled images for each button.</li>
* 		<li>Call the updateToolbar function to set the initial enabled or disabled state of each toolbar button based on the number of currently selected orders or which page you are on.</li>
* </ol>
*
**/
savedOrdersJS = {
		
	/** The current store ID. **/
	storeId : "",
	
	/** The current language ID. **/
	langId : "",
	
	/** The current catalog ID. **/
	catalogId : "",
	
	/** The current order ID from the saved order details page or the current order page. **/
	orderId : "",
	
	/** A vector of the selected orders in the saved orders table. **/
	selectedOrders : new Vector(),

	/** A vector of order IDs that currently have new descriptions in the saved orders table. **/
	changedOrders : new Vector(),
	
	/** An array of the updated order descriptions in the saved orders table. **/
	changedOrdersDescriptions : {},
	
	/** Contains the DOM nodes for each toolbar button. **/
	toolbar_list: {},

	/** Contains the images for each button in the toolbar. **/
	toolbar_img: {},

	/** "Contains the source paths for the images displayed in the toolbar. **/
	src: {},
	
	/** Contains the alternate texts displayed for the images in the toolbar **/
	alt: {},
	
	/** The <b>Set as Current Order</b> button element. **/
	setCurrentButton : "",
	
	/** The <b>Set as Current Order</b> button label. **/
	setCurrentButtonLabel : "",
	
	/** Determines whether to reset the current order by calling the AjaxUpdatePendingOrder service. **/
	updateCurrentOrder : false,

	/** Indicates whether the saved order is being accessed from the current order page. **/
	isCurrentOrderPageValue : false,
	
	/** Indicates whether the saved order is being accessed from the saved orders details page. **/
	isOrderDetailsPageValue : false,
	
	/** The URL of the shopping cart used to forward the page when an order is converted to the current order. **/
	shoppingCartURL : "",
	
	/** The URL of the new requisition list page displayed when the customer clicks the Add to Requisition List button from the toolbar. **/
	requisitionListURL : "",
	
	/** The URL of the order calculate command used when checking out from the saved order details page. **/
	orderCalculateURL : "",
	
	/** The URL of the order's physical store selection page to be used when checking out from the pending order details page **/
	physicalStoreURL : "",

	/** Determines whether to update the cart on the pending order details page when AJAX checkout is disabled. **/
	updateCartRequired : false,
	
	/** A boolean used to indicate if the requisition list feature is enabled or not to decide whether the add to requisition list button should be enabled **/
	requisitionListEnabled : true,
	
	/**
	* Initializes the langId, storeId, and catalogId global variables.
	*
	* @param {String} langId The language ID to use. Language ID is a parameter which must be passed to service requests. It holds the language that the service request is sent in.
	* @param {String} storeId The store ID to use. The store ID is a parameter which must be passed to service requests. It holds the ID of the store that the service request is sent from.
	* @param {String} catalogId The catalog ID to use. The catalog ID is a parameter which must be passed to service requests. It holds the ID of the catalog that the service request is sent from.
	* 
	**/
	setCommonParameters:function(langId,storeId,catalogId){
		this.langId = langId;
		this.storeId = storeId;
		this.catalogId = catalogId;
		this.loadToolbar();
	},

	/**
	* Sets the image and the alternate text for a toolbar button.
	*
	* @param {String} id The ID of the toolbar button.
	* @param {String} img The path of the toolbar button image.
	* @param {String} altText The alternate text for the toolbar button.
	* 
	**/
	setImgParameters:function(id,img,altText){
		this.src[id] = img;
		this.alt[id] = altText;
	},
	
	/**
	 * Moves to the previous or next page in the saved orders list.
	 * The page displays the results of indexes between startNumber and startNumber + savedOrdersPageSize - 1, where savedOrdersPageSize is defined in 
	 * the JSTLEnvironmentSetup.jspf file as the number of results to display on each page.
	 * @param {string} startNumber The index of the first result to return on the page.
	 **/
	changePage: function(startNumber)
	{
		 if(this.noSavesPending())
		 {
			 wc.render.updateContext("ListOrdersDisplay_Context", {'startNumber' : startNumber}); 
		 }
	},
		
	/**
	* Creates a new, empty saved order in the saved orders table.
	* This method is invoked by the Create Order toolbar button.
	**/
	createSavedOrder : function()
	{
		if(this.noSavesPending())
		{
			var params = [];
			
			params.storeId		= this.storeId;
			params.catalogId	= this.catalogId;
			params.langId		= this.langId;
			params.description = "";
			
			cursor_wait();
		
			this.updateCurrentOrder = true;
			wc.service.invoke("AjaxOrderCreate", params);
		}
	},
	
	/** Updates the URL of the ListOrdersDisplay_Controller to set the starting index of results to display in the refresh area. 
	 *  For example, when a new order is created or an existing order is copied, the refresh area is set to return the first page of results.
	 *  
	 *  @param url The URL to load the new results.
	 *  @param startNumber A number to indicate which result index to start with in the new result set.
	**/
	setReturnPage : function (url, startNumber)
	{
		if (startNumber != null && startNumber != 'undefined' && startNumber != "-1")
		{
			var returnURL = url.replace(/startNumber=[0-9]*/, "startNumber=" + startNumber);
			return returnURL;
		}
		else
		{
			return url;
		}
		
	},

	/**
	* Updates the description or name of a saved order in the saved orders table.
	* This method is invoked by the Save Order toolbar button.
	*
	* @param {boolean} first If true this is the first invocation of the command.
	**/
	saveOrder : function(first)
	{
		
		if( !this.changedOrders.isEmpty() )
		{		
			if(first)
			{
				if(!submitRequest()){
					return;
				}
				cursor_wait();
				
				// Remove highlights to changed descriptions
				for( i=0; i<this.changedOrders.size(); i++)
				{
					var inputElement = document.getElementById("OrderDescription_"+this.changedOrders.elementAt(i));
		        	if (inputElement != null && inputElement != 'undefined')
		        	{
		        		dojo.removeClass(inputElement, 'savedOrderDetailsInputBorderWarning'); 
		        		dojo.addClass(inputElement, 'savedOrderDetailsInputBorder');
		        	}
				}
			}
			
			var params = [];
			var orderId = this.changedOrders.elementAt(0);
			
			params.storeId		= this.storeId;
			params.catalogId	= this.catalogId;
			params.langId		= this.langId;
			params.URL="";
			params.toOrderId = orderId;
			params.description = trim(this.changedOrdersDescriptions[orderId]);
			
			// Remove order from list of orders
			this.changedOrders.removeElementAt(0);
			
			if(this.changedOrders.isEmpty())
			{
				this.changedOrdersDescriptions.length = 0;
				wc.service.invoke("AjaxSingleOrderSave", params);
			} else
			{
				wc.service.invoke("AjaxOrderSave", params);
			}
		}
	},
	
	/**
	* Updates the description of a saved order.
	* This method is invoked from the saved orders page.
	*
	* @param {int} orderId The ID of the order to update.
	* @param {String} newDescId The element ID of the new order description.
	* @param {String} oldDescId The element ID of the original order description.
	* @param {boolean} updateCartRequired Indicates if the cart should be updated even if the order description does not require updating.
	* 
	**/
	updateDescription : function(orderId, newDescId, oldDescId, updateCartRequired)
	{	
		// Get the descriptions
		var description = document.getElementById(newDescId).value;
		var oldDesc = document.getElementById(oldDescId).value;
		
		/*If the update button is pressed on the pending order details page it will handle updating the order description as well 
		as the rest of the fields on the page, so this flag will make the service update the rest of the form, even if the order description
		does not need to be updated.*/
		
		if (updateCartRequired)
		{
			this.updateCartRequired = updateCartRequired;
		}
		
		//Check to see if the order description has really changed by comparing it to the original value.
		if( description != oldDesc )
		{
			if(!submitRequest()){
				return;
			}
			cursor_wait();
			
			var params = [];
				
			params.storeId		= this.storeId;
			params.catalogId	= this.catalogId;
			params.langId		= this.langId;
			params.URL="";
			params.toOrderId = orderId;
			params.description = trim(description);
			 
			wc.service.invoke("AjaxSingleOrderSave", params);
		}
		else
		{
			if (updateCartRequired)
			{
				CheckoutHelperJS.updateShoppingCart(document.ShopCartForm);
			}
		}
	},
	
	
	/** 
	 * Adds a saved order to a requisition list. 
	 * This method is invoked by the Add to Requisition List toolbar button and forwards to the My Account New Requisition List page.
	 */
	 addToRequisitionList : function()
	 {
		if(this.noSavesPending())
		{
			this.getOrders();
			
			if((!this.selectedOrders.isEmpty() && this.selectedOrders.size() == 1) || this.isCurrentOrderPageValue)
			{
			var orderIdToUse = (this.isCurrentOrderPageValue)?this.orderId:this.selectedOrders.elementAt(0);
			
			var previousPage = "savedOrder";
			if (this.isCurrentOrderPageValue)
			{
				previousPage = "currentOrder";
			}
			
			var url = this.requisitionListURL + "&orderId=" + orderIdToUse + "&previousPage="+previousPage;	
			document.location.href = url;
			}
		}
		
	 },
	 
	 
	/**
	* Deletes one or more saved orders from the saved orders table.
	* This method is invoked by the Cancel toolbar button.
	* @param {boolean} first If true this is the first invocation of the command.
	**/
	cancelSavedOrder : function(first)
	{
		if(this.noSavesPending())
		{
			if(first)
			{
				
				this.getOrders();
			}
			
			if(!this.selectedOrders.isEmpty())
			{
				var params = [];
				
				params.storeId		= this.storeId;
				params.catalogId	= this.catalogId;
				params.langId		= this.langId;
				params.URL="";
				params.orderId = this.selectedOrders.elementAt(0);
				
				// Remove order from list of orders
				this.selectedOrders.removeElementAt(0);
				if(first)
				{
					if(!submitRequest()){
						return;
					}
					cursor_wait();
					this.updateCurrentOrder = true;
				}
				if(this.selectedOrders.isEmpty())
				{
					wc.service.invoke("AjaxSingleOrderCancel", params);
				} else
				{
					wc.service.invoke("AjaxOrderCancel", params);
				}
			}
		}
	},

	/** 
	 * Updates the current order in the database to match the order in the shopping cart.
	**/
	initializeCurrentOrder : function()
	{
		var orderIdToUse = '';
			
		if (this.orderId != null && this.orderId != 'undefined' && this.orderId != "")
		{
			orderIdToUse = this.orderId;
		}
		else
		{
			if (savedOrdersJS.getCurrentOrderId() != null && savedOrdersJS.getCurrentOrderId() != 'undefined')
			{
				orderIdToUse = savedOrdersJS.getCurrentOrderId();
			}
		}
		
		if (orderIdToUse != null)
		{
			var params = [];
			
			params.storeId		= this.storeId;
			params.catalogId	= this.catalogId;
			params.langId		= this.langId;
			params.URL="";
			params.orderId = orderIdToUse;
			
			wc.service.invoke("AjaxUpdatePendingOrder", params);
		}
	},
	
	/**
	* Sets the selected saved order as the current order in the saved orders table.
	* This method is invoked by the <b>Set as Current Order</b> button. 
	**/
	setCurrentOrder : function()
	{		
		if(this.noSavesPending())
		{
			this.getOrders();
			var currentOrderId = savedOrdersJS.getCurrentOrderId();
			var orderIdToSet;
		
			if (this.orderId != "" && this.orderId != 'undefined' && this.orderId != null)
			{			
				orderIdToSet = this.orderId;
			}
			else
			{
				if (!this.selectedOrders.isEmpty() && this.selectedOrders.size() == 1 && (currentOrderId == null || this.selectedOrders.elementAt(0) != currentOrderId))
				{
					orderIdToSet = this.selectedOrders.elementAt(0);
				}
			}
		
			if(orderIdToSet != null && orderIdToSet != 'undefined')
			{
				if(!submitRequest()){
					return;
				}
				var params = [];
				
				params.storeId		= this.storeId;
				params.catalogId	= this.catalogId;
				params.langId		= this.langId;
				params.URL="";
				params.orderId = orderIdToSet;
				wc.service.invoke("AjaxSetPendingOrder", params);
			}
		}	
	},
	
	/** 
	 * Sets the selected pending order as the current order when the <b>Set as Current Order and Checkout</b> button is clicked. 
	 * This method also assigns values to the orderCalculate URL and the physical store URL.
	 *  
	 * @param orderCalculateURL The URL of the order shipping and billing view.
	 * @param physicalStoreURL The URL of the checkout store selection view.
	 * **/
	setCurrentOrderAndCheckout : function(orderCalculateURL, physicalStoreURL)
	{
		this.orderCalculateURL = orderCalculateURL;
		this.physicalStoreURL = physicalStoreURL;
		this.initializeCurrentOrder();
		
	},
	
	/**
	 * Determines whether to forward the page after a successful service call.
	 * This method is invoked after the AjaxUpdatePendingOrder and AjaxSetPendingOrder services complete and forward to 
	 * either the registered user continue URL or the shopping cart URL. When the customer clicks the <b>Set as Current Order</b> button 
	 * from the saved order details page, the pending order is converted into the current order. 
	 * 
	 * If the customer clicks the <b>Set as Current Order and Checkout</b> button, this method forwards to the appropriate 
	 * registered user continue URL from the checkout flow, such as the shipping and billing page.
	 * 
	 * @param startService The service that initiated the forward request.
	 */
	determinePageForward : function(startService)
	{
		if (startService == "AjaxUpdatePendingOrder" && this.isOrderDetailsPageValue && ShipmodeSelectionExtJS != null && ShipmodeSelectionExtJS != 'undefined')
		{
			ShipmodeSelectionExtJS.registeredUserContinue(this.orderCalculateURL, this.physicalStoreURL);
		}
		
		if (startService == "AjaxSetPendingOrder" && this.isOrderDetailsPageValue && this.shoppingCartURL != null && this.shoppingCartURL != 'undefined')
		{
			document.location.href = this.shoppingCartURL;
		}
		
		if (startService == "AjaxSetPendingOrder" && !this.isOrderDetailsPageValue)
		{
			var params = [];
			
			this.getOrders();
			
			if (this.selectedOrders.size() == 1)
			{
				params.storeId		= this.storeId;
				params.catalogId	= this.catalogId;
				params.langId		= this.langId;
				params.URL="";
				params.updatePrices = "1";
				
				params.orderId = this.selectedOrders.elementAt(0);
				params.calculationUsageId = "-1";
				
				wc.service.invoke("AjaxCurrentOrderCalculate", params);
			}
		}
	},
		
	/**
	 * Copies one or more saved orders in the saved orders table.
	 * This method is invoked by the Copy Order toolbar button.
	 *
	 * @param {boolean} first If true this is the first invocation of the command.
	 **/
	copyOrder : function (first)
	{
		if(this.noSavesPending())
		{
			if(first)
			{	
				this.getOrders();
			}
			
			if(!this.selectedOrders.isEmpty())
			{
				
				var params = [];
				
				params.storeId		= this.storeId;
				params.catalogId	= this.catalogId;
				params.langId		= this.langId;
				params.URL="";
				params.fromOrderId_1 = this.selectedOrders.elementAt(0);
				params.toOrderId = "**";
				params.copyOrderItemId_1 = "*";
				params.keepOrdItemValidContract="1";
			
				// Remove order from list of orders
				this.selectedOrders.removeElementAt(0);
				if(first)
				{
					if(!submitRequest()){
						return;
					}
					cursor_wait();
				}
				if(this.selectedOrders.isEmpty())
				{
					wc.service.invoke("AjaxSingleOrderCopy", params);
				} else
				{
					wc.service.invoke("AjaxOrderCopy", params);
				}
			}
		}
	},
		
	/**
	*  Selects and clears the check box for a single order in the saved orders table. Updates the <b>Select All</b> check box, as required.
	*  This method also updates the state of the toolbar icons.
	**/
	checkOrder : function()
	{
		var selectAll = document.getElementById("WC_ListOrdersDisplayTable_CurrentOrder_Checkbox");
		var checkBoxes = document.getElementsByName("checkbox");
		
		var allChecked = true;

		for( i=0; i<checkBoxes.length; i++)
		{
			if(!checkBoxes[i].checked)
			{
				allChecked = false;
			}
		}
		
		// Update the select all checkbox.
		if(allChecked)
		{
			selectAll.checked = true;
		}else
		{
			selectAll.checked = false;
		}

		this.updateToolbar();
	},	

	/**
	* Manages the <b>Select All</b> check box in the header of the saved orders table.
	* This method selects and clears the check boxes for each of the orders in the saved orders table and updates the state of the toolbar icons
	**/
	checkAll : function()
	{
		var selectAll = document.getElementById("WC_ListOrdersDisplayTable_CurrentOrder_Checkbox");
		var checkBoxes = document.getElementsByName("checkbox");
		for( i=0; i<checkBoxes.length; i++)
		{
			if(selectAll.checked)
			{
				checkBoxes[i].checked = true;
			} else
			{
				checkBoxes[i].checked = false;
			}
		}
		this.updateToolbar();
	},
	
	/**
	* Detects and captures updated order descriptions in the saved orders table.
	* This method is invoked when an order description is changed. 
	* When the description for an order changes, the order is saved so that it can be updated later.
	* 
	* @param {int} orderId The ID of the order that contains an updated description.
	* @param {String} newDescId The element ID of the updated order description.
	* @param {String} oldDescId The element ID of the original order description.
	*  
	**/
	descriptionChanged : function(orderId, newDescId, oldDescId)
	{
		// Initialize array
		if(this.changedOrders.isEmpty())
		{
			this.changedOrdersDescriptions.length = 0;
		}
		
		// Get the descriptions
		var description = document.getElementById(newDescId).value;
		var oldDesc = document.getElementById(oldDescId).value;
		
		if( description != oldDesc )
		{
			// Add order if not already in vector
			if(!this.changedOrders.contains(orderId))
			{
				this.changedOrders.addElement(orderId);
			}
			
			this.changedOrdersDescriptions[orderId] = description;
		} else
		{
			// See if it was previously saved for update and remove it from changed list
			if(this.changedOrders.contains(orderId))
			{
				this.changedOrders.removeElement(orderId);
			}
		}
	},
	
	/** 
	* Applies a border to a form input field when that field is edited. 
	* This is used on the order name field on the saved order details page. It is highlighted when the order name is changed.
	*
	* @param inputElement The form input field to which the border should be applied.
	**/
	 modifyInputBorder : function(inputElement)
	 {
	 		if (document.getElementById('OldOrderDescription').value != inputElement.value) 
	 		{
	 			dojo.removeClass(inputElement, 'savedOrderDetailsInputBorder'); 
	 			dojo.addClass(inputElement, 'savedOrderDetailsInputBorderWarning'); 
	 		} 
	 		else 
	 		{
	 			dojo.removeClass(inputElement, 'savedOrderDetailsInputBorderWarning'); 
	 			dojo.addClass(inputElement, 'savedOrderDetailsInputBorder');
	 		}
	 },
	 
	/**
	* Indicates that there is at least one unsaved order description in the saved orders table.
	* in the saved orders table.
	* 
	* @returns {String} Returns true if there are no unsaved order descriptions pending.
	*  
	**/
	noSavesPending : function()
	{

		if( this.changedOrders.isEmpty())
		{
			return true;
		} else
		{
			MessageHelper.formErrorHandleClient("OrderDescription_"+this.changedOrders.elementAt(0),MessageHelper.messages['ORDER_DESC_NOT_SAVED']);
			
			// Add highlight to changed descriptions
			for( i=0; i<this.changedOrders.size(); i++)
			{
				var inputElement = document.getElementById("OrderDescription_"+this.changedOrders.elementAt(i));
	        	if (inputElement != null && inputElement != 'undefined')
	        	{
	        		dojo.removeClass(inputElement, 'savedOrderDetailsInputBorder'); 
	        		dojo.addClass(inputElement, 'savedOrderDetailsInputBorderWarning');
	        	}
			}
			
			return false;
		}	

	},
	
	/**
	* Gets the order IDs of all selected orders in the saved orders table and loads them into the selectedOrders vector.
	**/
	getOrders : function()
	{
		this.selectedOrders.removeAllElements();
		
		var checkBoxes = document.getElementsByName("checkbox");
		for( i=0; i<checkBoxes.length; i++)
		{
			if(checkBoxes[i].checked)
			{
				this.selectedOrders.addElement(checkBoxes[i].value);
			}
		}
	},
	
	/**
	 * This method will pre-select a saved order in the list if there is only one such order in the list. 
	 */
	checkAllIfNeeded : function()
	{
		var checkBoxes = document.getElementsByName("checkbox");
		
		if (checkBoxes.length == 1)
		{
			var selectAll = document.getElementById("WC_ListOrdersDisplayTable_CurrentOrder_Checkbox");
			selectAll.checked = true;
			this.checkAll();
		}
	},
	
	/**
	 * Returns the current order ID from the currentOrderJSON div in the ListOrdersDisplayTable.jsp file.
	 * @returns {String} The order ID of the current order or null if the currentOrderJSON div cannot be found.
	 **/
	getCurrentOrderId : function()
	{
		var jsonDIV = null;
		var node = document.getElementById("currentOrderJSON");		
		
		if (node && node != null && node != 'undefined')
		{
			jsonDIV = eval('('+ dojo.byId("currentOrderJSON").innerHTML +')');
		}
		if (jsonDIV != null && jsonDIV != 'undefined' && jsonDIV.currentOrderId != null && jsonDIV.currentOrderId != 'undefined')
		{
			return jsonDIV.currentOrderId;
		}
		else
		{
			return null;
		}
	},
		
	/**
	* Enables and disables the toolbar icons, based on the number of currently selected orders.
	* It also enables and disables the <b>Set as Current Order</b> button. 
	* This method is called after each table area refresh from the postRefreshHandler in the ListOrdersDisplay_Controller common controller. 
	* It is also called after the saved orders list page is initially loaded.
	**/
	updateToolbar : function()
	{
		this.setCurrentButton = document.getElementById("WC_ListOrdersDisplayTable_CurrentOrder_Button");	
		this.setCurrentButtonLabel = document.getElementById("WC_ListOrdersDisplayTable_CurrentOrder_Hidden_Label");	
		
		var numberOfOrders = 0;
		
		var checkBoxes = document.getElementsByName("checkbox");
		for( i=0; i<checkBoxes.length; i++)
		{
			if(checkBoxes[i].checked)
			{
				numberOfOrders++;
			}
		}
		
		// Save is always enabled
		this.enableToolbarButton("SAVE", true);		

		if (!this.isCurrentOrderPageValue)
		{
			
			if(numberOfOrders == 0)
			{
				// Disable all buttons
				this.enableToolbarButton("ADD", false);
				this.enableToolbarButton("COPY", false);
				this.enableToolbarButton("CANCEL", false);
				if(this.setCurrentButton && this.setCurrentButton != null && this.setCurrentButton != "undefined")
				{
					this.setCurrentButton.disabled = true;
					this.setCurrentButton.className = "disabled_button";
					this.setCurrentButtonLabel.innerHTML = this.alt["SET_CURRENT_ORDER_DISABLED"];
				}
			} else
			{
				if(numberOfOrders == 1)
				{
					// Enable all Buttons
					this.enableToolbarButton("ADD", true);
					this.enableToolbarButton("COPY", true);
					this.enableToolbarButton("CANCEL", true);
					if(this.setCurrentButton && this.setCurrentButton != null && this.setCurrentButton != "undefined")
					{
						//Determine if the current order is selected or not.
						var currentOrderId = savedOrdersJS.getCurrentOrderId();
						var currentOrderSelected = false;
					
						if (currentOrderId != null)
						{
							var currentOrderCheckbox = document.getElementById("WC_ListOrdersDisplayTable_Checkbox_2_"+currentOrderId);
							var currentOrderSelected = (currentOrderCheckbox && currentOrderCheckbox != null && currentOrderCheckbox != 'undefined')?currentOrderCheckbox.checked:false;
						}
						//Only enable the button if the current order is not selected.
						if (!currentOrderSelected)
						{
							this.setCurrentButton.disabled = false;
							this.setCurrentButton.className = "primary_button";
							this.setCurrentButtonLabel.innerHTML = this.alt["SET_CURRENT_ORDER_ENABLED"];
						}
					}
				} else
				{
					// Enable buttons for multiple selects
					this.enableToolbarButton("CANCEL", true);
					this.enableToolbarButton("COPY", true);
					
					this.enableToolbarButton("ADD", false);
					if(this.setCurrentButton && this.setCurrentButton != null && this.setCurrentButton != "undefined")
					{
						this.setCurrentButton.disabled = true;
						this.setCurrentButton.className = "disabled_button";
						this.setCurrentButtonLabel.innerHTML = this.alt["SET_CURRENT_ORDER_DISABLED"];
					}
				}
			}
		}
		else
		{
			if (this.requisitionListEnabled == null || this.requisitionListEnabled == 'undefined' || this.requisitionListEnabled == true)
			{
				this.enableToolbarButton("ADD", true);
			}
		}
	},
		
	/**
	* Gets references to all of the toolbar elements that are required to manage the toolbar.
	* These references populate the toolbar_img and toolbar_list vectors and are are used by updateToolbar.
	**/
	loadToolbar : function()
	{
		this.toolbar_img["ADD"] = (document.getElementById("WC_SavedOrdersToolbar_img_add") != null)?document.getElementById("WC_SavedOrdersToolbar_img_add"):null;
		this.toolbar_list["ADD"] = (document.getElementById("WC_SavedOrdersToolbar_list_add") != null)?document.getElementById("WC_SavedOrdersToolbar_list_add"):null;
		this.toolbar_img["SAVE"] = (document.getElementById("WC_SavedOrdersToolbar_img_save") != null)?document.getElementById("WC_SavedOrdersToolbar_img_save"):null;
		this.toolbar_list["SAVE"] = (document.getElementById("WC_SavedOrdersToolbar_list_save") != null)?document.getElementById("WC_SavedOrdersToolbar_list_save"):null;
		this.toolbar_img["COPY"] = (document.getElementById("WC_SavedOrdersToolbar_img_copy") != null)?document.getElementById("WC_SavedOrdersToolbar_img_copy"):null;
		this.toolbar_list["COPY"] = (document.getElementById("WC_SavedOrdersToolbar_list_copy") != null)?document.getElementById("WC_SavedOrdersToolbar_list_copy"):null;
		this.toolbar_img["CANCEL"] = (document.getElementById("WC_SavedOrdersToolbar_img_cancel") != null)?document.getElementById("WC_SavedOrdersToolbar_img_cancel"):null;
		this.toolbar_list["CANCEL"] = (document.getElementById("WC_SavedOrdersToolbar_list_cancel") != null)?document.getElementById("WC_SavedOrdersToolbar_list_cancel"):null;
	},

	/**
	* Enables or disables a toolbar button.
	* 
	* @param {String} button The button identifier.
	* @param {boolean} enable Set to true to enable the toolbar button. Set to false to disable the toolbar button.
	**/
	enableToolbarButton : function(button, enable)
	{
		if (this.toolbar_img[button] != null && this.toolbar_list[button] != null)
		{
			if(enable == true)
			{
				this.toolbar_list[button].disabled = false;
				this.toolbar_img[button].alt = this.alt[button+"_ENABLED"];
				this.toolbar_img[button].src = this.src[button+"_ENABLED"];
			} else
			{
				this.toolbar_list[button].disabled = true;
				this.toolbar_img[button].alt = this.alt[button+"_DISABLED"];
				this.toolbar_img[button].src = this.src[button+"_DISABLED"];
			}
		}
	},
	
	/** 
	 * Sets the isCurrentOrderPageValue flag to true or false.
	 * 
	 * This flag determines if the current order page is displayed.
	 * 
	 * @param value Indicates if the current order page is displayed.
	 */
	isCurrentOrderPage : function(value)
	{
		this.isCurrentOrderPageValue = value;
		this.loadToolbar();
		this.updateToolbar();
	},
	
	/**
	 * Sets the isOrderDetailsPageValue flag to true or false.
	 * 
	 * This flag determines if the saved orders details page is currently displayed.
	 * 
	 * @param value Indicates if the saved orders details page is displayed.
	 */
	isOrderDetailsPage : function(value)
	{
		this.isOrderDetailsPageValue = value;
	},
	
	/**
	 * Sets the order ID. This method sets the order to display on the saved orders details page.
	 * 
	 * @param orderId The order ID of the order being displayed. 
	 */
	setOrderId : function(orderId)
	{
		this.orderId = orderId;
	},
	
	/**
	 * Sets the URL of the current shopping cart view.
	 * 
	 * @param shoppingCartURL The URL of the shopping cart view.
	 */
	setCurrentShoppingCartURL : function(shoppingCartURL)
	{
		this.shoppingCartURL = shoppingCartURL;
	},
	
	/** 
	 * Sets the URL for the requisition list view in AJAX or non-AJAX mode.
	 * 
	 * @param reqlistURL The URL of the requisition list view.
	 */
	setRequisitionListViewURL : function(reqlistURL)
	{
		this.requisitionListURL = reqlistURL;
	},
	
	/**
	 * Sets the requisition list enabled flag to true or false. This is used to determine if the requisition list
	 * 						     change flow is enabled or not. The add to requisition list button is then either enabled or disabled in the toolbar.
	 * 
	 * @param reqListEnabled A boolean (true/false) indicating if the requisition list change flow feature is enabled or not.
	 * 
	 */
	setRequisitionListEnabled : function(reqListEnabled)
	{
		this.requisitionListEnabled = reqListEnabled;
	}
}