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
 * @fileOverview This javascript is used by jsp's related to 'Personal Information','My Orders' and 'My Coupons'.
 * @version 1.0
 */

 /* Import dojo classes */
dojo.require("wc.service.common");
	
dojo.require("wc.widget.RefreshArea");
dojo.require("wc.render.RefreshController");
dojo.require("wc.render.Context");
dojo.require("wc.render.common");

/**
 * The functions defined in this class are used for enabling 'My Account' related customer operations.
 * 
 * @class This MyAccountDisplay class defines all the variables and functions for 'My Account' page history tracking when the 
 * 'AjaxMyAccount' is enabled in the change flow option for the store. Another function enables customers to update their current personal information.
 *	Another function enables the customer to create a new order by duplicating a previous order.Another function is 
 *  used to remove a coupon from the coupon wallet.
 */
MyAccountDisplay={
	
	/*Flag which indicates if a context change happened. */
	contextChanged:false,

	/*Flag which indicates whether refresh is caused by browser back or forward event. */ 
	isHistory:false,

	/** Flag which indicates whether 'AjaxMyAccount' is enabled or not. The value of this variable is automatically populated
	 *  based on the change flow option in the store by the setAjaxVar function.
	 */
	ajaxMyAccountEnabled: false,

	/* This indicates the current link highlighted in the leftSideBar. */
	currentSelection:"",
	
	/** 
	 * This variable stores the identifier of the tab currently being displayed. 
	 * The default value is "PreviouslyProcessed".
	 */
	currentTabId: "PreviouslyProcessed",			
	
	/**
	 * This variable keeps track of whether the preferred language is updated
	 */
	isPreferredLanguageUpdated: false,
	
	/**
	 * set the isPreferredLanguageUpdated variable
	 * @param {boolean} value either true or false. True if preferred language is updated. False otherwise.
	 */
	setPreferredLanguageUpdated: function (value) {
		this.isPreferredLanguageUpdated = value;
	},
	
	/**
	 * return a boolean value which indicates whether preferred lanaguage is changed.
	 */
	getPreferredLanguageUpdated: function () {
		return this.isPreferredLanguageUpdated
	},
	
	/** 
	 * Hides the tab with the specified identifier.
	 * This function unhides the 'off' tab, 
	 * and hides the 'on' tab by setting the style.display attribute respectively.
	 *
	 * @param {string} id The identifier of the HTML element representing the tab to hide.
	 */
	setOff:function(id){
		document.getElementById(id+"_On").style.display = "none";
		document.getElementById(id+"_Off").style.display = "inline";
		document.getElementById(id).style.display = "none";
	},
	
	/** 
	 * Displays the tab with the specified identifier.
	 * This function unhides the 'on' tab,
	 * and hides the 'off' tab by setting the style.display attribute respectively.
	 *
	 * @param {string} id The identifier of the HTML element representing the tab to display.
	 */			
	setOn:function(id){
		document.getElementById(id+"_On").style.display = "inline";
		document.getElementById(id+"_Off").style.display = "none";
		document.getElementById(id).style.display = "block";
	},

	/** 
	 * Switches a tab selection to the tab specified by 'tabId' parameter.
	 * Turns off the currently selected tab and hides it's content. 
	 * Also, this function turns on the tab indicated by the 'tabId' and displays it's contents.
	 *
	 * @param {string} tabId The HTML element identifier to turn 'on'.
	 */				
	selectTab:function(tabId){
		this.currentSelection='trackOrderStatus';
		this.setOff(this.currentTabId);
		this.setOn(tabId);
		this.currentTabId = tabId;
		dijit.byId('mainTabContainer').selectChild(dijit.byId(tabId));
	},	
	
	
	/**
	 * This function sets the url for ordercopy service and then it invokes the service to copy the old order.
	 * @param {string} OrderCopyURL The url for the order copy service.
	 */
	prepareOrderCopy:function(OrderCopyURL){

		/*For Handling multiple clicks. */
		if(!submitRequest()){
			return;
		}   		
		cursor_wait();
		wc.service.getServiceById("OrderCopy").url=OrderCopyURL;
		wc.service.invoke("OrderCopy");
	},
	
	
	/**
	 * This function sets the parameters for the AjaxScheduledOrderCancel service and invokes the service to cancel the order.
	 * @param {Integer} orderId The Id of the order to cancel.
	 */
	cancelScheduledOrder:function(orderId){

		/*For Handling multiple clicks. */
		if(!submitRequest()){
			return;
		}
		cursor_wait();
		var params = [];
		params["orderId"] = orderId;
		params["URL"] = "";
		params["storeId"] = MyAccountServicesDeclarationJS.storeId;
		params["catalogId"] = MyAccountServicesDeclarationJS.catalogId;
		params["langId"] = MyAccountServicesDeclarationJS.langId;
		wc.service.invoke("AjaxScheduledOrderCancel", params);
	},
	
	
	/**
	 * This function will take a url as input attribute and will update the context of the refresh area with the corresponding view.
	 * @param {string} workAreaModeValue A value to uniquely identify a context, which is among the following: 
	 * myAccountMain, personalInformation, addressBook, checkoutProfile, wishList,trackOrderStatus, mycoupons ,bookmarkedPage
	 * @param {string} resultPageURL The url to update the context of refresh area.
	 */
	loadContentFromURL:function(workAreaModeValue, resultPageURL){		
		if(this.getAjaxVar()=='true'){
			wc.render.getRefreshControllerById("MyAccountCenterLinkDisplay_Controller").url = resultPageURL;
			var currentWorkAreaMode = wc.render.getContextById("MyAccountCenterLinkDisplay_Context").properties["workAreaMode"];
			wc.render.updateContext("MyAccountCenterLinkDisplay_Context", {workAreaMode:workAreaModeValue});
			if(workAreaModeValue == 'trackOrderStatus' && currentWorkAreaMode != 'trackOrderStatus'){
				this.currentTabId = 'PreviouslyProcessed';
				wc.render.updateContext("ProcessedOrdersStatusDisplay_Context", {beginIndex:'0'});
				wc.render.updateContext("WaitingForApprovalOrdersStatusDisplay_Context", {beginIndex:'0'});
				wc.render.updateContext("ScheduledOrdersStatusDisplay_Context", {beginIndex:'0'});
			}
		}
		else{
			document.location.href=resultPageURL;
		}
	},

	/**
	 *  This function will highlight the selection in MyAccount left sidebar. When the user clicks on any of the links in left sidebar,
	 *  the link is made bold indicating that it is selected.
	 *  @param {string} url This is the url of the link that is selected in the left sidebar.
	 */
	changeSelection: function(url){	
		var start = url.indexOf("currentSelection",0);
		if(start != '-1'){
			var end = url.indexOf("Slct",start);
			var id= url.substring(start+17,end);
		}
		/*The previously highlighted link is deselected. */
		if(this.currentSelection){
		document.getElementById(this.currentSelection).setAttribute("class","");
		document.getElementById(this.currentSelection).setAttribute("className","");/*For IE */
		}
		/* The newly selected link is highlighted. */
		if(id){
		document.getElementById(id).setAttribute("class","strong");
		document.getElementById(id).setAttribute("className","strong");/* For IE */
		}
		this.currentSelection=id;
	},
	setAjaxVar: function(temp)
	{
		this.ajaxMyAccountEnabled = temp;
	},

	getAjaxVar: function()
	{
		return this.ajaxMyAccountEnabled;
	},
	
	/**
	 * This function enables customers to update their current personal information. The user can also 
	 * update their password through this function.
	 * @param {string} form The name of the form containing personal information of the customer.
	 * @param {string} logonPassword The value of the 'password' field.
	 * @param {string} logonPasswordVerify The value of the 'verify password' field.
	 */
	prepareSubmit:function(form,logonPassword,logonPasswordVerify){
	
		if(form.logonPassword_old.name == "logonPassword")
		{
			
			form.logonPassword_old.name = "logonPassword_old";
			form.logonPasswordVerify_old.name = "logonPasswordVerify_old";
		}
		/*check whether the values in password and verify password fields match, if so, update the password. */ 
		if (form.logonPassword_old.value.length != 0)
		{
			if(form.logonPassword_old.value!= form.logonPasswordVerify_old.value)
			{
				MessageHelper.formErrorHandleClient(form.logonPasswordVerify_old.id,MessageHelper.messages["PWDREENTER_DO_NOT_MATCH"]);
				return ; 
			}
			form.logonPassword_old.name = "logonPassword";
			form.logonPasswordVerify_old.name = "logonPasswordVerify";
		}
		
		/** Uses the common validation function defined in AddressHelper class for validating first name, 
		 *  last name, street address, city, country/region, state/province, ZIP/postal code, e-mail address and phone number. 
		 */

		if(!AddressHelper.validateAddressForm(form)){
			return;
		}
		
		/* Checks whether the customer has registered for promotional e-mails. */
		if(form.sendMeEmail && form.sendMeEmail.checked){
		    form.receiveEmail.value = true;
		}
		else {
			form.receiveEmail.value = false;
		}
		
		if(form.sendMeSMSNotification && form.sendMeSMSNotification.checked){
		    form.receiveSMSNotification.value = true;
		}
		else {
			form.receiveSMSNotification.value = false;
		}

		if(form.sendMeSMSPreference && form.sendMeSMSPreference.checked){
		    form.receiveSMS.value = true;
		}
		else {
			form.receiveSMS.value = false;
		}

		if(form.mobileDeviceEnabled != null && form.mobileDeviceEnabled.value == "true"){
			if(!this.validateMobileDevice(form)){
				return;
			}
		}
		if(form.birthdayEnabled != null && form.birthdayEnabled.value == "true"){
			if(!this.validateBirthday(form)){
				return;
			}
		}

		/* For Handling multiple clicks. */
		if(!submitRequest()){
			return;
		}		
		
		/** Checks whether 'AjaxMyAccount' change flow option is enabled, if so, invokes 'UserRegistrationUpdate' service.
		 *  If 'AjaxMyAccount' change flow option is disabled the form is submitted. 
		 */
		if(this.getAjaxVar()=="true"){
			cursor_wait();
			wc.service.invoke("UserRegistrationUpdate");
		}else{
			form.submit();
		}		
	},

	/**
	 *  This function is used for handling bookmarked urls. If there is bookmark information in the url, the url after # is 
	 *  extracted and the context of the refresh area is updated with the bookmarked url.
	 */
	processBookmarkURL:function(){

	/* Check if it is a bookmarked url,if so, extract the part of the url after # */
		var bookmarkId = location.hash;			
		if(bookmarkId){					        
			bookmarkId = bookmarkId.substring(1, bookmarkId.length);
			
		}   
	/* Update the refresh area context with the bookmarked value. */
		if(bookmarkId){
				var indexOfIdentifier = bookmarkId.indexOf("identifier", 0);
	            if ( indexOfIdentifier >= 0) {
					if(document.all || dojo.isSafari)/* For IE and Safari */
					{
						var realUrl = bookmarkId.substring(0, indexOfIdentifier - 3);					
						realUrl = realUrl.replace(/%3A/g,":");
						realUrl = realUrl.replace(/%2F/g,"/");
						realUrl = realUrl.replace(/%3F/g,"?");
						realUrl = realUrl.replace(/%3D/g,"=");
						realUrl = realUrl.replace(/%26/g,"&");
						MyAccountDisplay.changeSelection(realUrl);
						MyAccountDisplay.loadContentFromURL("bookmarkedPage", realUrl);
					}
					else
					{
			    		var realUrl = bookmarkId.substring(0, indexOfIdentifier - 1);
						MyAccountDisplay.changeSelection(realUrl);
					    MyAccountDisplay.loadContentFromURL("bookmarkedPage", realUrl);
					}
				}
		}
	},
	
	/** 
	 * This function sets the initial state of dojo browser history for MyAccount display page. 
	 * @param {string} workAreaModeValue A value to uniquely identify a context, which is among the following: 
	 * myAccountMain, personalInformation, addressBook, checkoutProfile, wishList,trackOrderStatus, mycoupons ,bookmarkedPage
	 * @param {string} elementId The id of the widget.
	 * @param {string} changeUrl url to update the context of the refresh area.
	 */	
	initMyAccountDisplayHistory:function(workAreaModeValue, elementId, changeUrl){

				
		var historyObject = new MyAccountDisplay.HistoryTracker(workAreaModeValue, elementId, changeUrl);

		dojo.back.setInitialState(historyObject);	
	},
	
	/** 
	 *	This function opens up the passed in url in a new browser window.
	 *  @param {string} URL The url to be invoked from the new window. 
	 */
	popupWindow:function(URL) {
		
		window.open(URL, "mywindow", "status=1,scrollbars=1,resizable=1");
	},
	
	/**
	 *  This function belongs to HistoryTracking for receiving Back notifications i.e when the user clicks on the 'Back'
	 *  button in the browser,this function is invoked.
	 */
	goBack:function(){

		MyAccountDisplay.changeSelection(this.changeUrl);
		MyAccountDisplay.loadContentFromURL(this.workAreaModeValue, this.changeUrl);
		MyAccountDisplay.isHistory=true;
		
        },
        
	/**
	 *  This function belongs to HistoryTracking for receiving forward notifications i.e when the user clicks on the 'Forward'
	 *  button in the browser,this function is invoked.
	 */

     goForward:function(){	

	 	MyAccountDisplay.changeSelection(this.changeUrl);
		MyAccountDisplay.loadContentFromURL(this.workAreaModeValue, this.changeUrl);
		isHistory=true;
      },
        
   /**
    * This function removes a coupon. If a customer has a that has not been applied to an order
	* then this function can be used to remove that coupon from the customer's coupon wallet.
	* @param {string} formName The name of the form that contains the table which holds the coupon to be deleted.
	* @param {string} returnView The view to return to after the request has been processed.
	* @param {string} couponId The unique ID of the coupon. This is set in the form to be sent to the service.
    */
	  
	deleteCoupon:function(formName,returnView,couponId)
	{	
       
		var form = document.forms[formName];
		
		form.couponId.value = couponId;
		form.taskType.value= "D";
		
		 /* For Handling multiple clicks. */
		 if(!submitRequest()){
			 	return;
		 }   		
		if(this.getAjaxVar()=='true')
		{		
			service = wc.service.getServiceById('AjaxCouponsAddRemove');
			service.formId = formName;
			CommonControllersDeclarationJS.setControllerURL("CouponDisplay_Controller",returnView);
			CommonContextsJS.setContextProperty("CouponDisplay_Context","returnView",returnView);
			cursor_wait();			
			wc.service.invoke('AjaxCouponsAddRemove');
		}
		else
		{
			form.URL.value = returnView;
			form.submit();
		}
	
	},  
	
	/**
	 * Updates the list of contracts that are available to the current user.
	 * @param {string} formName  The name of the form that contains the table of selected contracts.
	  * @param {string} currentContracts  The IDs of the active contracts that are in the current trading agreement.
	  * @param {string} errorMessage  An error message ID which displays the error message thrown by the server 
	  * and is to be displayed if the optional parameter is passed in.
	 */
	updateContract:function(formName, currentContracts, errorMessage){	
		var form = document.forms[formName];
		var selected = false;
		
		/* For Handling multiple clicks. */
		if(!submitRequest()){ return; }

		if(form.contractId.length != undefined){
			for(var i = 0; i < form.contractId.length; i++){
				if(form.contractId[i].checked){
					selected = true;
					break;
				}
			}
			if(!selected){
				var current = currentContracts.split(";");
				for(var t = 0; t < current.length; t++){
					document.getElementById("WC_B2BMyAccountParticipantRole_checkbox_"+current[t]).checked = true;
				}
				MessageHelper.displayErrorMessage(errorMessage);
				requestSubmitted = false;
			}
		}else if(form.contractId.checked){
			selected = true;
		}else{
			document.getElementById("WC_B2BMyAccountParticipantRole_checkbox_"+form.contractId.value).checked = true;
			MessageHelper.displayErrorMessage(errorMessage);
			requestSubmitted = false;
		}
		
		if(selected){
			form.submit();
		}
	},  
	
	/**
	 * Changes the organization that is used by the current user.
	 * @param {string} formName  The name of the form that contains the table with the selected organization.
	 */
	updateOrganization:function(formName){	
		var form = document.forms[formName];
		/* For Handling multiple clicks. */
		if(!submitRequest()){ return; }
		form.submit();
	},  
	
	/**
	 * This function forms history state object for history tracking. 
	 * @param {string} workAreaModeValue A value to uniquely identify a context, which is among the following: 
	 * myAccountMain, personalInformation, addressBook, checkoutProfile, wishList,trackOrderStatus, mycoupons ,bookmarkedPage
	 * @param {string} elementId The id of the widget.
	 * @param {string} changeUrl url to update the context of the refresh area.
	 */
	HistoryTracker:function(workAreaModeValue, elementId, changeUrl){
		
		this.workAreaModeValue = workAreaModeValue;
		this.elementId = elementId; 
		this.changeUrl =  changeUrl;

	},
	
	/**
	 * This function validates the customer's input for birthday, i.e. whether the year/month/date combination is correct.
	 * @param {string} form The name of the form containing personal information of the customer.
	 * 
	 * @return {boolean} This indicates whether the birthday entered is valid or not.
	 */

	validateBirthday: function(form){
		if(form.birth_year != null && form.birth_month != null && form.birth_date != null){
			if(form.birth_year.value != 0 || form.birth_month.value != 0 || form.birth_date.value != 0){
				/* if any of the year/month/date fields contains non-empty inforamtion, validate. */
				if(form.birth_month.value == 0){
					MessageHelper.formErrorHandleClient(form.birth_month.id, MessageHelper.messages["ERROR_SpecifyMonth"]);
					return false;
				}
				if(form.birth_date.value == 0){
					MessageHelper.formErrorHandleClient(form.birth_date.id, MessageHelper.messages["ERROR_SpecifyDate"]);
					return false;
				}
				
				/* set the number of days in Feburary for validation. */
				var febDays = 29;
				if(form.birth_year.value != 0 && ((form.birth_year.value % 4) != 0)){
					febDays = 28;
				}
				
				var months = ["4","6","9","11"]; /* these months only have 30 days in total. */
				var monthFound = false;
				for(var i=0; i<months.length; i++){
					if(months[i] == form.birth_month.value){
						monthFound = true;
						break;
					}
				}
				if(monthFound && (form.birth_date.value > 30)){
					/* if month entered is April/June/Sept/Nov, check if the date is larger than 30 */
					MessageHelper.formErrorHandleClient(form.birth_date.id, MessageHelper.messages["ERROR_InvalidDate1"]);
					return false;
				}
				
				if((form.birth_month.value == 2) && (form.birth_date.value > febDays)){
					/* in the case if the month entered is Feburary, validate the date against febDays. */
					MessageHelper.formErrorHandleClient(form.birth_date.id, MessageHelper.messages["ERROR_InvalidDate1"]);
					return false;
				}
				if(form.curr_year != null && form.curr_month != null && form.curr_date != null){
					var birth_year = parseInt(form.birth_year.value);
					var birth_month = parseInt(form.birth_month.value);
					var birth_date = parseInt(form.birth_date.value);
					
					var curr_year = parseInt(form.curr_year.value);
					var curr_month = parseInt(form.curr_month.value);
					var curr_date = parseInt(form.curr_date.value);
					
					if(birth_year > curr_year){
						/* if birth year entered is in the future. */
						MessageHelper.formErrorHandleClient(form.birth_year.id, MessageHelper.messages["ERROR_InvalidDate2"]);
						return false;
					}else if((birth_year == curr_year) && (birth_month > curr_month)){
						/* if birth year entered is the same as the current year, then check the month entered. */
						MessageHelper.formErrorHandleClient(form.birth_month.id, MessageHelper.messages["ERROR_InvalidDate2"]);
						return false;
					}else if((birth_year == curr_year) && (birth_month == curr_month) && (birth_date > curr_date)){
						/* if birth year and month entered are the same as the current year and month, then check the date entered. */
						MessageHelper.formErrorHandleClient(form.birth_date.id, MessageHelper.messages["ERROR_InvalidDate2"]);
						return false;
					}else{
						/* the date of birth provided is valid, now verify if the user is under age. */
						this.validateAge(form);
						if(form.dateOfBirthTemp != null){
							if(form.birth_month.value != 0 && form.birth_date.value != 0){
								var final_birth_year = birth_year;
								var final_birth_month = birth_month;
								var final_birth_date = birth_date;
								if(birth_year == 0){
									/* If the user does not specify the year in his/her date of birth, set the year to 1896. */
									final_birth_year = 1896;
								}
								if(birth_month < 10){
									final_birth_month = '0' + birth_month;
								}
								if(birth_date < 10){
									final_birth_date = '0' + birth_date;
								}
								form.dateOfBirthTemp.value = final_birth_year + '-' + final_birth_month + '-' + final_birth_date;
								document.getElementById('WC_PersonalInfoExtension_HiddenField_5').name = 'dateOfBirth';
							}else{
								form.dateOfBirthTemp.value = null;
							}
						}
					}
				}
				return true;
			}else{
				if(form.dateOfBirthTemp != null){
					form.dateOfBirthTemp.value = "";
					if(document.getElementById('WC_PersonalInfoExtension_HiddenField_5') != null){
						document.getElementById('WC_PersonalInfoExtension_HiddenField_5').name = 'dateOfBirth';
					}
				}
				return true;
			}
		}
		return true;
	},
	
	/**
	 *  This function validates the customer's input for age. If the user is under age, pop up a message to ask the user to review the store policy.
	 *  @param {string} The name of the form containing personal information of the customer.
	 */
	
	validateAge: function(form){
		var birth_year = parseInt(form.birth_year.value);
		var birth_month = parseInt(form.birth_month.value);
		var birth_date = parseInt(form.birth_date.value);
					
		var curr_year = parseInt(form.curr_year.value);
		var curr_month = parseInt(form.curr_month.value);
		var curr_date = parseInt(form.curr_date.value);
		
		/*Check whether age is less than 13, if so, pop up a message to ask the user to review the store policy. */
		if((curr_year - birth_year) < 13){
			alert(form.ageWarning.value);
		}else if((curr_year - birth_year) == 13){
			if(curr_month < birth_month){
				alert(form.ageWarning.value);
			}else if((curr_month == birth_month) && (curr_date < birth_date)){
				alert(form.ageWarning.value);
			}
		}
	},
	
	/**
	 *  This function validates the Mobile phone number provided by the customer.
	 *  The Mobile Phone number option is not a required input by default, but if the customer has entered something, 
	 *	this method will be called to validate the mobile phone information entered by the customer.
	 *  @param {string} form The name of the registration form containing the customer's mobile phone number.
	 *  @return {boolean} returns true if the mobile number entered is valid, else returns false.
	 */
					
	validateMobileDevice: function(form){
		if(form.mobilePhone1 != null && form.mobilePhone1!="" ){
			if(!MessageHelper.isValidUTF8length(form.mobilePhone1.value, 32)){ 
				MessageHelper.formErrorHandleClient(form.mobilePhone1.id, MessageHelper.messages["ERROR_PhoneTooLong"]);
				return false;
			}

			if(!MessageHelper.IsValidPhone(form.mobilePhone1.value)){
				MessageHelper.formErrorHandleClient(form.mobilePhone1.id, MessageHelper.messages["ERROR_INVALIDPHONE"]);
				return false;
			}
		}
		return true;
	}
} 
	MyAccountDisplay.HistoryTracker.prototype.back = MyAccountDisplay.goBack;
	MyAccountDisplay.HistoryTracker.prototype.forward=MyAccountDisplay.goForward;
