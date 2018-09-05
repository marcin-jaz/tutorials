<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2008, 2009 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf" %>
<%@ include file="../../../include/nocache.jspf" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>             
<%@ taglib uri="http://commerce.ibm.com/coremetrics"  prefix="cm" %>
<%@ include file="../../../include/ErrorMessageSetup.jspf" %>
<c:set var="myAccountPage" value="true" scope="request"/>
<c:set var="hasBreadCrumbTrail" value="false" scope="request"/>

<wcf:getData type="com.ibm.commerce.order.facade.datatypes.OrderType"
       var="usablePayments" expressionBuilder="findCurrentShoppingCart">
       <wcf:param name="accessProfile" value="IBM_UsablePaymentInfo" />
</wcf:getData>
<wcf:url var="profileFormViewURL" value="NonAjaxProfileFormView" type="Ajax">
	<wcf:param name="storeId"   value="${WCParam.storeId}"  />
	<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
	<wcf:param name="langId" value="${langId}" />
</wcf:url>	

<wcf:getData type="com.ibm.commerce.order.facade.datatypes.OrderType"
       var="order" expressionBuilder="findCurrentShoppingCart">
       <wcf:param name="accessProfile" value="IBM_Details" />
</wcf:getData>

<wcbase:useBean id="paymentPolicyListDataBean" classname="com.ibm.commerce.payment.beans.PaymentPolicyListDataBean" scope="page">
	<c:set value="${WCParam.storeId}" target="${paymentPolicyListDataBean}" property="storeId"/>
</wcbase:useBean>

<wcbase:useBean id="orderListBean" classname="com.ibm.commerce.order.beans.OrderListDataBean" scope="request"> 
	<c:set target="${orderListBean}" property="storeId" value="${WCParam.storeId}"/>
	<c:set target="${orderListBean}" property="userId" value="${WCParam.userId}"/>   
	<c:set target="${orderListBean}" property="retrievalOrderStatus" value="Q"/>      	
</wcbase:useBean>  

<c:choose>
<c:when test="${empty errorMessage}">
	<c:forEach items="${orderListBean.orderDataBeans}" var="orderBean" varStatus="status">
		<c:if test="${!empty orderBean.paymentInfo}">
			<c:set var="payment_method" value="${orderBean.paymentInfo.payment_method}"/>
			<c:set var="account" value="${orderBean.paymentInfo.account}"/>
			<c:set var="cc_brand" value="${orderBean.paymentInfo.cc_brand}"/>
			<c:set var="card_brand" value="${orderBean.paymentInfo.card_brand}"/>
			<c:set var="expire_year" value="${orderBean.paymentInfo.expire_year}"/>
			<c:set var="expire_month" value="${orderBean.paymentInfo.expire_month}"/>
			<c:set var="cc_cvc" value="${orderBean.paymentInfo.cc_cvc}"/>
		</c:if>

		
		<c:if test="${!empty orderBean.currentAddressDataBean}">
			<c:set var="billingTemp_addressId" value="${orderBean.currentAddressDataBean.addressId}"/>
			<c:set var="billingTemp_nickName" value="${orderBean.currentAddressDataBean.nickName}"/>
			<c:set var="billingTemp_addressType" value="${orderBean.currentAddressDataBean.addressType}"/>
			<c:set var="billingTemp_primary" value="${orderBean.currentAddressDataBean.primary}"/>
			<c:set var="billingTemp_lastName" value="${orderBean.currentAddressDataBean.lastName}"/>
			<c:set var="billingTemp_middleName" value="${orderBean.currentAddressDataBean.middleName}"/>
			<c:set var="billingTemp_firstName" value="${orderBean.currentAddressDataBean.firstName}"/>
			<c:set var="billingTemp_address1" value="${orderBean.currentAddressDataBean.address1}"/>
			<c:set var="billingTemp_address2" value="${orderBean.currentAddressDataBean.address2}"/>
			<c:set var="billingTemp_city" value="${orderBean.currentAddressDataBean.city}"/>
			<c:set var="billingTemp_state" value="${orderBean.currentAddressDataBean.state}"/>
			<c:set var="billingTemp_zipCode" value="${orderBean.currentAddressDataBean.zipCode}"/>
			<c:set var="billingTemp_country" value="${orderBean.currentAddressDataBean.country}"/>
			<c:set var="billingTemp_phone1" value="${orderBean.currentAddressDataBean.phone1}"/>
			<c:set var="billingTemp_email1" value="${orderBean.currentAddressDataBean.email1}"/>
		</c:if>
		
		<c:forEach items="${orderBean.orderItemDataBeans}" var="orderItemBean" varStatus="status">
			<c:set var="profileOrderItemBean" value="${orderItemBean}"  scope="request"/>
			<c:set var="shippingAddressBean" value="${orderItemBean.currentAddressDataBean}"  scope="request"/>
			<c:if test="${!empty orderItemBean.currentAddressDataBean}">
				<c:set var="shippingTemp_addressId" value="${orderItemBean.currentAddressDataBean.addressId}"/>
				<c:set var="shippingTemp_nickName" value="${orderItemBean.currentAddressDataBean.nickName}"/>
				<c:set var="shippingTemp_addressType" value="${orderItemBean.currentAddressDataBean.addressType}"/>
				<c:set var="shippingTemp_primary" value="${orderItemBean.currentAddressDataBean.primary}"/>
				<c:set var="shippingTemp_lastName" value="${orderItemBean.currentAddressDataBean.lastName}"/>
				<c:set var="shippingTemp_middleName" value="${orderItemBean.currentAddressDataBean.middleName}"/>
				<c:set var="shippingTemp_firstName" value="${orderItemBean.currentAddressDataBean.firstName}"/>
				<c:set var="shippingTemp_address1" value="${orderItemBean.currentAddressDataBean.address1}"/>
				<c:set var="shippingTemp_address2" value="${orderItemBean.currentAddressDataBean.address2}"/>
				<c:set var="shippingTemp_city" value="${orderItemBean.currentAddressDataBean.city}"/>
				<c:set var="shippingTemp_state" value="${orderItemBean.currentAddressDataBean.state}"/>
				<c:set var="shippingTemp_zipCode" value="${orderItemBean.currentAddressDataBean.zipCode}"/>
				<c:set var="shippingTemp_country" value="${orderItemBean.currentAddressDataBean.country}"/>
				<c:set var="shippingTemp_phone1" value="${orderItemBean.currentAddressDataBean.phone1}"/>
				<c:set var="shippingTemp_email1" value="${orderBean.currentAddressDataBean.email1}"/>
			</c:if>
		</c:forEach>
	</c:forEach>
</c:when>

<c:otherwise>
	<c:set var="payment_method" value="${WCParam.pay_payment_method}"/>
	<c:set var="account" value="${WCParam.pay_temp_account}"/>
	<c:set var="cc_brand" value="${WCParam.pay_cc_brand}"/>
	<c:set var="card_brand" value="${WCParam.pay_card_brand}"/>
	<c:set var="expire_year" value="${WCParam.pay_expire_year}"/>
	<c:set var="expire_month" value="${WCParam.pay_expire_month}"/>
	<c:set var="cc_cvc" value="${WCParam.pay_cc_cvc}"/>
	<c:set var="billingTemp_addressId" value="${WCParam.billing_addressId1}"/>
	<c:set var="billingTemp_lastName" value="${WCParam.billing_lastName}"/>
	<c:set var="billingTemp_middleName" value="${WCParam.billing_middleName}"/>
	<c:set var="billingTemp_firstName" value="${WCParam.billing_firstName}"/>
	<c:set var="billingTemp_address1" value="${WCParam.billing_address1}"/>
	<c:set var="billingTemp_address2" value="${WCParam.billing_address2}"/>
	<c:set var="billingTemp_city" value="${WCParam.billing_city}"/>
	<c:set var="billingTemp_state" value="${WCParam.billing_state}"/>
	<c:set var="billingTemp_zipCode" value="${WCParam.billing_zipCode}"/>
	<c:set var="billingTemp_country" value="${WCParam.billing_country}"/>
	<c:set var="billingTemp_phone1" value="${WCParam.billing_phone1}"/>
	<c:set var="billingTemp_email1" value="${WCParam.billing_email1}"/>

	<c:set var="shippingTemp_addressId" value="${WCParam.shipping_addressId}"/>
	<c:set var="shippingTemp_lastName" value="${WCParam.shipping_lastName}"/>
	<c:set var="shippingTemp_middleName" value="${WCParam.shipping_middleName}"/>
	<c:set var="shippingTemp_firstName" value="${WCParam.shipping_firstName}"/>
	<c:set var="shippingTemp_address1" value="${WCParam.shipping_address1}"/>
	<c:set var="shippingTemp_address2" value="${WCParam.shipping_address2}"/>
	<c:set var="shippingTemp_city" value="${WCParam.shipping_city}"/>
	<c:set var="shippingTemp_state" value="${WCParam.shipping_state}"/>
	<c:set var="shippingTemp_zipCode" value="${WCParam.shipping_zipCode}"/>
	<c:set var="shippingTemp_country" value="${WCParam.shipping_country}"/>
	<c:set var="shippingTemp_phone1" value="${WCParam.shipping_phone1}"/>
	<c:set var="shippingTemp_email1" value="${WCParam.shipping_email1}"/>
</c:otherwise>
</c:choose>

<wcf:url var="userRegistrationFormURL" value="NonAjaxUserRegistrationForm">
	<wcf:param name="storeId"   value="${WCParam.storeId}"  />
	<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
	<wcf:param name="langId" value="${WCParam.langId}" />
	<wcf:param name="editRegistration" value="Y" />
</wcf:url>
<wcf:url var="addressBookFormURL" value="NonAjaxAddressBookForm">
	<wcf:param name="storeId"   value="${WCParam.storeId}"  />
	<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
	<wcf:param name="langId" value="${WCParam.langId}" />
</wcf:url>
<wcf:url var="QuickCheckoutURL" value="NonAjaxProfileFormView">
	<wcf:param name="storeId"   value="${WCParam.storeId}"  />
	<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
	<wcf:param name="langId" value="${WCParam.langId}" />
</wcf:url>
<wcf:url var="trackOrderStatusURL" value="NonAjaxTrackOrderStatus">
	<wcf:param name="storeId"   value="${WCParam.storeId}"  />
	<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
	<wcf:param name="langId" value="${langId}" />
</wcf:url>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="${shortLocale}" xml:lang="${shortLocale}">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><fmt:message key="MA_QUICK_CHECKOUT" bundle="${storeText}"/></title>
<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${vfileStylesheet}"/>" type="text/css"/>
<!--[if lte IE 6]>
<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${vfileStylesheetie}"/>" type="text/css"/>
<![endif]-->
<%@ include file="../../../Snippets/ReusableObjects/AddressHelperCountrySelection.jspf" %>
<script type="text/javascript" src="<c:out value="${dojoFile}"/>" djConfig="${dojoConfigParams}"></script>
<%@ include file="../../../include/CommonJSToInclude.jspf"%>
<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/UserArea/AddressHelper.js"/>"></script>
<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/UserArea/MyAccountDisplay.js"/>"></script>
<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/MessageHelper.js"/>"></script>
<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/UserArea/AddressBookForm.js"/>"></script>
<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/UserArea/QuickCheckoutProfile.js"/>"></script>

<script type="text/javascript">
	dojo.addOnLoad(function() { 
		<fmt:message key="ERROR_RecipientTooLong" bundle="${storeText}" var="ERROR_RecipientTooLong"/>
		<fmt:message key="ERROR_FirstNameTooLong" bundle="${storeText}" var="ERROR_FirstNameTooLong"/>
		<fmt:message key="ERROR_LastNameTooLong" bundle="${storeText}" var="ERROR_LastNameTooLong"/>
		<fmt:message key="ERROR_MiddleNameTooLong" bundle="${storeText}" var="ERROR_MiddleNameTooLong"/>
		<fmt:message key="ERROR_AddressTooLong" bundle="${storeText}" var="ERROR_AddressTooLong"/>
		<fmt:message key="ERROR_CityTooLong" bundle="${storeText}" var="ERROR_CityTooLong"/>
		<fmt:message key="ERROR_StateTooLong" bundle="${storeText}" var="ERROR_StateTooLong"/>
		<fmt:message key="ERROR_CountryTooLong" bundle="${storeText}" var="ERROR_CountryTooLong"/>
		<fmt:message key="ERROR_ZipCodeTooLong" bundle="${storeText}" var="ERROR_ZipCodeTooLong"/>
		<fmt:message key="ERROR_PhoneTooLong" bundle="${storeText}" var="ERROR_PhoneTooLong"/>
		<fmt:message key="ERROR_RecipientEmpty" bundle="${storeText}" var="ERROR_RecipientEmpty"/>
		<fmt:message key="ERROR_FirstNameEmpty" bundle="${storeText}" var="ERROR_FirstNameEmpty"/>
		<fmt:message key="ERROR_LastNameEmpty" bundle="${storeText}" var="ERROR_LastNameEmpty"/>
		<fmt:message key="ERROR_MiddleNameEmpty" bundle="${storeText}" var="ERROR_MiddleNameEmpty"/>
		<fmt:message key="ERROR_AddressEmpty" bundle="${storeText}" var="ERROR_AddressEmpty"/>
		<fmt:message key="ERROR_CityEmpty" bundle="${storeText}" var="ERROR_CityEmpty"/>
		<fmt:message key="ERROR_StateEmpty" bundle="${storeText}" var="ERROR_StateEmpty"/>
		<fmt:message key="ERROR_CountryEmpty" bundle="${storeText}" var="ERROR_CountryEmpty"/>
		<fmt:message key="ERROR_ZipCodeEmpty" bundle="${storeText}" var="ERROR_ZipCodeEmpty"/>
		<fmt:message key="ERROR_PhonenumberEmpty" bundle="${storeText}" var="ERROR_PhonenumberEmpty"/>
		<fmt:message key="ERROR_EmailEmpty" bundle="${storeText}" var="ERROR_EmailEmpty"/>
		<fmt:message key="PWDREENTER_DO_NOT_MATCH" bundle="${storeText}" var="PWDREENTER_DO_NOT_MATCH"/>
		<fmt:message key="REQUIRED_FIELD_ENTER" bundle="${storeText}" var="REQUIRED_FIELD_ENTER"/>
		<fmt:message key="WISHLIST_INVALIDEMAILFORMAT" bundle="${storeText}" var="WISHLIST_INVALIDEMAILFORMAT"/>
		<fmt:message key="ERROR_INVALIDPHONE" bundle="${storeText}" var="ERROR_INVALIDPHONE"/>
		<fmt:message key="INVALID_EXPIRY_DATE" bundle="${storeText}" var="INVALID_EXPIRY_DATE"/>
		<fmt:message key="AB_SELECT_ADDRTYPE" bundle="${storeText}" var="AB_SELECT_ADDRTYPE"/>
		<fmt:message key="ERROR_DEFAULTADDRESS" bundle="${storeText}" var="ERROR_DEFAULTADDRESS"/>
		<fmt:message key="ERROR_INVALIDEMAILFORMAT" bundle="${storeText}" var="ERROR_INVALIDEMAILFORMAT"/>
		<fmt:message key="ERROR_MESSAGE_TYPE" bundle="${storeText}" var="ERROR_MESSAGE_TYPE"/>
		
	
		MessageHelper.setMessage("REQUIRED_FIELD_ENTER", <wcf:json object="${REQUIRED_FIELD_ENTER}"/>);						
		MessageHelper.setMessage("INVALID_EXPIRY_DATE", <wcf:json object="${INVALID_EXPIRY_DATE}"/>);
		MessageHelper.setMessage("ERROR_RecipientTooLong", <wcf:json object="${ERROR_RecipientTooLong}"/>);
		MessageHelper.setMessage("ERROR_FirstNameTooLong", <wcf:json object="${ERROR_FirstNameTooLong}"/>);
		MessageHelper.setMessage("ERROR_LastNameTooLong", <wcf:json object="${ERROR_LastNameTooLong}"/>);
		MessageHelper.setMessage("ERROR_MiddleNameTooLong", <wcf:json object="${ERROR_MiddleNameTooLong}"/>);
		MessageHelper.setMessage("ERROR_AddressTooLong", <wcf:json object="${ERROR_AddressTooLong}"/>);
		MessageHelper.setMessage("ERROR_CityTooLong", <wcf:json object="${ERROR_CityTooLong}"/>);
		MessageHelper.setMessage("ERROR_StateTooLong", <wcf:json object="${ERROR_StateTooLong}"/>);
		MessageHelper.setMessage("ERROR_CountryTooLong", <wcf:json object="${ERROR_CountryTooLong}"/>);
		MessageHelper.setMessage("ERROR_ZipCodeTooLong", <wcf:json object="${ERROR_ZipCodeTooLong}"/>);
		MessageHelper.setMessage("ERROR_PhoneTooLong", <wcf:json object="${ERROR_PhoneTooLong}"/>);
		MessageHelper.setMessage("ERROR_RecipientEmpty", <wcf:json object="${ERROR_RecipientEmpty}"/>);
		/*Although for English, firstname is not mandatory. But it is mandatory for other languages.*/
		MessageHelper.setMessage("ERROR_FirstNameEmpty", <wcf:json object="${ERROR_FirstNameEmpty}"/>);
		MessageHelper.setMessage("ERROR_LastNameEmpty", <wcf:json object="${ERROR_LastNameEmpty}"/>);
		MessageHelper.setMessage("ERROR_MiddleNameEmpty", <wcf:json object="${ERROR_MiddleNameEmpty}"/>);
		MessageHelper.setMessage("ERROR_AddressEmpty", <wcf:json object="${ERROR_AddressEmpty}"/>);
		MessageHelper.setMessage("ERROR_CityEmpty", <wcf:json object="${ERROR_CityEmpty}"/>);
		MessageHelper.setMessage("ERROR_StateEmpty", <wcf:json object="${ERROR_StateEmpty}"/>);
		MessageHelper.setMessage("ERROR_CountryEmpty", <wcf:json object="${ERROR_CountryEmpty}"/>);
		MessageHelper.setMessage("ERROR_ZipCodeEmpty", <wcf:json object="${ERROR_ZipCodeEmpty}"/>);
		MessageHelper.setMessage("ERROR_PhonenumberEmpty", <wcf:json object="${ERROR_PhonenumberEmpty}"/>);
		MessageHelper.setMessage("ERROR_EmailEmpty", <wcf:json object="${ERROR_EmailEmpty}"/>);
		MessageHelper.setMessage("WISHLIST_INVALIDEMAILFORMAT", <wcf:json object="${WISHLIST_INVALIDEMAILFORMAT}"/>);
		MessageHelper.setMessage("ERROR_INVALIDPHONE", <wcf:json object="${ERROR_INVALIDPHONE}"/>);
		MessageHelper.setMessage("ERROR_DEFAULTADDRESS", <wcf:json object="${ERROR_DEFAULTADDRESS}"/>);
		MessageHelper.setMessage("ERROR_SELECTADDRESS", <wcf:json object="${ERROR_SELECTADDRESS}"/>);
		MessageHelper.setMessage("ERROR_INVALIDEMAILFORMAT", <wcf:json object="${ERROR_INVALIDEMAILFORMAT}"/>);
		MessageHelper.setMessage("ERROR_MESSAGE_TYPE", <wcf:json object="${ERROR_MESSAGE_TYPE}"/>);				
		});
</script>
</head>
<body>
<%@ include file="../../../include/StoreCommonUtilities.jspf"%>
<%@ include file="../../../Snippets/ReusableObjects/AddressHelperCountrySelection.jspf" %>
<!-- Page Start -->
<div id="page">
     <!-- Header Nav Start -->
	<%@ include file="../../../include/LayoutContainerTop.jspf"%>

     <!-- Main Content Start -->
          <!-- Content Start -->
          <div id="box">
               <div class="my_account" id="WC_MyAccountQuickCheckoutProfileForm_div_2">
                    <div class="main_header" id="WC_MyAccountQuickCheckoutProfileForm_div_3">
                         <div class="left_corner" id="WC_MyAccountQuickCheckoutProfileForm_div_4"></div>
                         <div class="left" id="WC_MyAccountQuickCheckoutProfileForm_div_5"><span class="main_header_text"><fmt:message key="MA_QUICK_CHECKOUT" bundle="${storeText}"/></span></div>
                         <div class="right_corner" id="WC_MyAccountQuickCheckoutProfileForm_div_6"></div>
                    </div>
                    <div class="contentline" id="WC_MyAccountQuickCheckoutProfileForm_div_7">
                         <div class="left_corner" id="WC_MyAccountQuickCheckoutProfileForm_div_8"></div>
                         <div class="left" id="WC_MyAccountQuickCheckoutProfileForm_div_9"></div>
                         <div class="right_corner" id="WC_MyAccountQuickCheckoutProfileForm_div_10"></div>
                    </div>
                    <div class="body" id="WC_MyAccountQuickCheckoutProfileForm_div_11">
						
						<form name="QuickCheckout" method="post" action="PersonChangeServiceCheckoutProfileUpdate" id="QuickCheckout">
							
							<input type="hidden" name="storeId" value="<c:out value="${WCParam.storeId}"/>" id="WC_QuickCheckoutProfileForm_FormInput_storeId_In_QuickCheckout_1"/>
							<input type="hidden" name="langId" value="<c:out value="${WCParam.langId}"/>" id="WC_QuickCheckoutProfileForm_FormInput_langId_In_QuickCheckout_1"/>
							<input type="hidden" name="catalogId" value="<c:out value="${WCParam.catalogId}"/>" id="WC_QuickCheckoutProfileForm_FormInput_catalogId_In_QuickCheckout_1"/>
							<input type="hidden" name="page" value="quickcheckout" id="WC_QuickCheckoutProfileForm_FormInput_page_In_QuickCheckout_1"/>
							<input type="hidden" name="returnPage" value="<c:out value="${returnPage}"/>" id="WC_QuickCheckoutProfileForm_FormInput_returnPage_In_QuickCheckout_1"/>
							<input type="hidden" name="orderId" value="<c:out value="${WCParam.orderId}"/>" id="WC_QuickCheckoutProfileForm_FormInput_orderId_In_QuickCheckout_1"/>
							<input type="hidden" name="valueFromProfileOrder" value="Y" id="WC_MyAccountQuickCheckoutProfileForm_inputs_1"/>
							<input type="hidden" name="URL" value="LogonForm?page=quickcheckout" id="WC_MyAccountQuickCheckoutProfileForm_inputs_2"/>
							<input type="hidden" name="errorViewName" value="NonAjaxProfileFormView" id="WC_MyAccountQuickCheckoutProfileForm_inputs_8"/>
							<input type="hidden" name="myAcctMain" value="1" id="WC_MyAccountQuickCheckoutProfileForm_inputs_9"/>
							<input type="hidden" name="shipping_addressType" value="Shipping" id="WC_MyAccountQuickCheckoutProfileForm_inputs_3"/>
							<input type="hidden" name="billing_addressType" value="Billing" id="WC_MyAccountQuickCheckoutProfileForm_inputs_4"/>
							<input type="hidden" name="shipping_nickName" value="<c:out value="${'Default_Shipping_'}${WCParam.storeId}"/>" id="WC_QuickCheckoutProfileForm_FormInput_shipping_nickName_In_QuickCheckout_2"/>
							<input type="hidden" name="billing_nickName" value="<c:out value="${'Default_Billing_'}${WCParam.storeId}"/>" id="WC_QuickCheckoutProfileForm_FormInput_billing_nickName_In_QuickCheckout_2"/>
							<input type=hidden name="pay_payment_method" value="" id="WC_MyAccountQuickCheckoutProfileForm_inputs_5"/>
							<input type=hidden name="pay_payMethodId" value="" id="WC_MyAccountQuickCheckoutProfileForm_inputs_6"/>
							<input type=hidden name="pay_cc_brand" value="" id="WC_MyAccountQuickCheckoutProfileForm_inputs_7"/>
							<input type="hidden" name="authToken" value="${authToken}" id="WC_MyAccountQuickCheckoutProfileForm_inputs_authToken_1"/>

							<div class="left" id="WC_MyAccountQuickCheckoutProfileForm_div_12">
								<c:if test="${!empty errorMessage}">
									<script type="text/javascript">dojo.addOnLoad(function() { MessageHelper.displayErrorMessage("<c:out value='${errorMessage}'/>"); });</script>
								</c:if>
							</div>
							
							<div class="shipping_billing_content" id="normal">
								<div id="my_account_billing">
                                   <legend class="myaccount_link_legend"><fmt:message key="QC_BILLINGADDR" bundle="${storeText}"/></legend>
                                   					<div id="WC_MyAccountQuickCheckoutProfileForm_div_13">
										<div class="required-field" id="WC_MyAccountQuickCheckoutProfileForm_div_14"> *</div><fmt:message key="REQUIRED_FIELDS" bundle="${storeText}"/>
									</div>
									<br/>

                                   
                                   <div id="WC_MyAccountQuickCheckoutProfileForm_div_22">
										<script type="text/javascript">
											dojo.addOnLoad(function() { 
												billingProfile = new Object();
												billingProfile.firstName = "<c:out value="${billingTemp_firstName}"/>";
												billingProfile.lastName = "<c:out value="${billingTemp_lastName}"/>";
												billingProfile.middleName = "<c:out value="${billingTemp_middleName}"/>";
												billingProfile.address1 = "<c:out value="${billingTemp_address1}"/>";
												billingProfile.address2 = "<c:out value="${billingTemp_address2}"/>";
												billingProfile.city = "<c:out value="${billingTemp_city}"/>";
												billingProfile.state = "<c:out value="${billingTemp_state}"/>";
												billingProfile.country = "<c:out value="${billingTemp_country}"/>";
												billingProfile.zipCode = "<c:out value="${billingTemp_zipCode}"/>";
												billingProfile.email1 = "<c:out value="${billingTemp_email1}"/>";
												billingProfile.phone1 = "<c:out value="${billingTemp_phone1}"/>";
												
												shippingProfile = new Object();
												shippingProfile.firstName = "<c:out value="${shippingTemp_firstName}"/>";
												shippingProfile.lastName = "<c:out value="${shippingTemp_lastName}"/>";
												shippingProfile.middleName = "<c:out value="${shippingTemp_middleName}"/>";
												shippingProfile.address1 = "<c:out value="${shippingTemp_address1}"/>";
												shippingProfile.address2 = "<c:out value="${shippingTemp_address2}"/>";
												shippingProfile.city = "<c:out value="${shippingTemp_city}"/>";
												shippingProfile.state = "<c:out value="${shippingTemp_state}"/>";
												shippingProfile.country = "<c:out value="${shippingTemp_country}"/>";
												shippingProfile.zipCode = "<c:out value="${shippingTemp_zipCode}"/>";
												shippingProfile.email1 = "<c:out value="${shippingTemp_email1}"/>";
												shippingProfile.phone1 = "<c:out value="${shippingTemp_phone1}"/>";
												
												
											});
										</script>
												
										
											
										
                                   </div>
                                   <br/>
								
								   
                                   <jsp:include page="QuickCheckoutAddressForm.jsp" flush="true">
										<jsp:param name="prefix" value="billing" />
								   </jsp:include>
								    <script type="text/javascript">
										dojo.addOnLoad(function() { 											
												javascript:QuickCheckoutProfile.getCurrentProfile(billingProfile, 'billing');
										});
									</script>
								   <br clear="all"/>
										
									
									
                                   <h1 class="myaccount_link"><fmt:message key="PAYMENT_NUMBER_OF_METHODS" bundle="${storeText}"/></h1>
                                   <div class="label_spacer" id="WC_MyAccountQuickCheckoutProfileForm_div_23">
                                        <label for="payMethodId"><div class="required-field" id="WC_MyAccountQuickCheckoutProfileForm_div_24"> *</div>
                                        <fmt:message key="QC_TYPE" bundle="${storeText}"/></label></div>
                                   <c:set var="displayMethod" value="display:block" />

									<div id="paymentSection1" style="<c:out value="${displayMethod}"/>">
										<input type="hidden" name="langId" value="<c:out value="${WCParam.langId}"/>" id="WC_MyAccountQuickCheckoutProfileForm_inputs_8a"/>
										<jsp:useBean id="now1" class="java.util.Date"/>
										<input type="hidden" name="curr_year" value="<c:out value='${now1.year + 1900}'/>" id="WC_MyAccountQuickCheckoutProfileForm_inputs_9a"/>
										<input type="hidden" name="curr_month" value="<c:out value='${now1.month + 1}'/>" id="WC_MyAccountQuickCheckoutProfileForm_inputs_10"/>
										<input type="hidden" name="curr_date" value="<c:out value='${now1.date}'/>" id="WC_MyAccountQuickCheckoutProfileForm_inputs_11"/>
										<div id="WC_MyAccountQuickCheckoutProfileForm_div_25">
										<select class="drop_down" name="payMethodId" id="payMethodId" onchange="javascript:QuickCheckoutProfile.setCCBrand(this);" >
											<c:forEach items="${paymentPolicyListDataBean.paymentPolicyInfoUsableWithoutTA}" var="paymentPolicyInfo" varStatus="status">
												<c:set var="edp_SelectedValue" value="${payMethodId[0]}" scope="request" /> 
												<c:if test="${ !empty paymentPolicyInfo.attrPageName }" >
													<c:if test="${paymentPolicyInfo.attrPageName == 'StandardVisa' || paymentPolicyInfo.attrPageName == 'StandardMasterCard' || paymentPolicyInfo.attrPageName == 'StandardAmex'}">
														<option <c:if test="${payment_method == paymentPolicyInfo.policyName}" > selected="selected" </c:if> value="<c:out value="${paymentPolicyInfo.policyName}" />"> <c:out value="${paymentPolicyInfo.shortDescription}" /></option>
														
														<c:if test="${paymentPolicyInfo.policyName == edp_SelectedValue }" >
															<c:set var ="edp_AttrPageName" value="${paymentPolicyInfo.attrPageName}" />
														</c:if>
																	
													</c:if>
												</c:if>
											</c:forEach>
											</select>
										</div>
									</div>

									<c:if test="${empty expire_month}">
										<c:set var="expire_month" value="${now1.month + 1}"/>
									</c:if>
									<c:if test="${empty expire_year}">
										<c:set var="expire_year" value="${now1.year + 1900}"/>
									</c:if>
									
									<div class="label_spacer" id="WC_MyAccountQuickCheckoutProfileForm_div_26"><label for="pay_temp_account"><div class="required-field" id="WC_MyAccountQuickCheckoutProfileForm_div_27"> *</div><fmt:message key="CARD_NUMBER" bundle="${storeText}"/></label></div>
                                   <div id="WC_MyAccountQuickCheckoutProfileForm_div_28">
									<wcbase:useBean id = "edpMaskBean" classname="com.ibm.commerce.edp.beans.EDPSensitiveDataMaskHelperDataBean">
										<c:set target="${edpMaskBean}" property="plainString" value="${account}"/>
		 						    </wcbase:useBean>
									
								    
									<c:choose>
									<c:when test="${!empty errorMessage}">
										<input name="pay_temp_account" type="text" class="form_input" size="35" value="" id="pay_temp_account" onChange="javascript:QuickCheckoutProfile.valueChanged('true');"/>
									</c:when>
									<c:otherwise>
									<input name="pay_temp_account" type="text" class="form_input" size="35" value="<c:out value='${edpMaskBean.maskedString}'/>" id="pay_temp_account" onChange="javascript:QuickCheckoutProfile.valueChanged('true');"/>
									</c:otherwise>
									</c:choose>
								</div>
                                   <div class="left" id="WC_MyAccountQuickCheckoutProfileForm_div_29">
                                        <div class="label_spacer" id="WC_MyAccountQuickCheckoutProfileForm_div_30">
                                             <label for="pay_expire_month"><div class="required-field" id="WC_MyAccountQuickCheckoutProfileForm_div_31"> *</div>
                                             <fmt:message key="expire_month" bundle="${storeText}"/></label>:</div>
                                        <div id="WC_MyAccountQuickCheckoutProfileForm_div_32">
                                             <select name="pay_expire_month" id="pay_expire_month" class="drop_down" size="1">
                                                  <option
													<c:if test="${expire_month == 1 || expire_month == '01'}" > selected="selected" </c:if>
													value="01">01</option>
												<option
													<c:if test="${expire_month == 2 || expire_month == '02'}" > selected="selected" </c:if>
													value="02">02</option>
												<option
													<c:if test="${expire_month == 3 || expire_month == '03'}" > selected="selected" </c:if>
													value="03">03</option>
												<option
													<c:if test="${expire_month == 4 || expire_month == '04'}" > selected="selected" </c:if>
													value="04">04</option>
												<option
													<c:if test="${expire_month == 5 || expire_month == '05'}" > selected="selected" </c:if>
													value="05">05</option>
												<option
													<c:if test="${expire_month == 6 || expire_month == '06'}" > selected="selected" </c:if>
													value="06">06</option>
												<option
													<c:if test="${expire_month == 7 || expire_month == '07'}" > selected="selected" </c:if>
													value="07">07</option>
												<option
													<c:if test="${expire_month == 8 || expire_month == '08'}" > selected="selected" </c:if>
													value="08">08</option>
												<option
													<c:if test="${expire_month == 9 || expire_month == '09'}" > selected="selected" </c:if>
													value="09">09</option>
												<option
													<c:if test="${expire_month == 10 }" > selected="selected" </c:if>
													value="10">10</option>
												<option
													<c:if test="${expire_month == 11 }" > selected="selected" </c:if>
													value="11">11</option>
												<option
													<c:if test="${expire_month == 12 }" > selected="selected" </c:if>
													value="12">12</option>
                                             </select>
                                        </div>
                                   </div>
                                   <div class="left" id="WC_MyAccountQuickCheckoutProfileForm_div_33">
								   <img src="<c:out value="${jspStoreImgDir}${vfileColor}transparent.gif"/>" width="20" alt="<fmt:message key="No_Image" bundle="${storeText}"/>"/>
								   </div>
                                   <div class="left" id="WC_MyAccountQuickCheckoutProfileForm_div_34">
                                        <div class="label_spacer" id="WC_MyAccountQuickCheckoutProfileForm_div_35">
                                             <label for="pay_expire_year"><div class="required-field" id="WC_MyAccountQuickCheckoutProfileForm_div_36"> *</div>
                                             <fmt:message key="expire_year" bundle="${storeText}"/></label></div>
                                             <c:set var="current_year" value="${now1.year + 1900}"/>
                                        <div id="WC_MyAccountQuickCheckoutProfileForm_div_37">
                                             <select name="pay_expire_year" id="pay_expire_year" class="drop_down" size="1">
											 	<c:forEach begin="0" end="10" varStatus="counter">
													<option
														<c:if test="${expire_year == current_year+counter.index }" > selected="selected" </c:if>
														value="${current_year+counter.index}">${current_year+counter.index}</option>
												</c:forEach>
                                             </select>
                                        </div>
                                   </div>
                                   <br />
								</div>
								<div id="my_account_shipping">
                                   <h1 class="myaccount_link"><fmt:message key="QC_SHIPPINGADDR" bundle="${storeText}"/></h1>
				                   <div class="label_spacer" id="WC_MyAccountQuickCheckoutProfileForm_div_38">
										<label for="SameShippingAndBillingAddress"><img src="<c:out value='${jspStoreImgDir}'/>images/empty.gif" alt="<fmt:message key="QC_SHIPPINGADDR" bundle="${storeText}"/>"/></label>
										<input class="checkbox" type="checkbox" name="SameShippingAndBillingAddress" onclick="JavaScript:QuickCheckoutProfile.showHide(document.QuickCheckout);" id="SameShippingAndBillingAddress"/>
										<span class="unregisteredCheckbox">
										<fmt:message key="UC_SAME" bundle="${storeText}"/>
										</span>
										
									</div>
									<br/>
									<div id="shipAddr">
										<jsp:include page="QuickCheckoutAddressForm.jsp" flush="true">
											<jsp:param name="prefix" value="shipping" />
										</jsp:include>
									</div>
									<script type="text/javascript">
										dojo.addOnLoad(function() { 
												javascript:QuickCheckoutProfile.getCurrentProfile(shippingProfile, 'shipping');
											});
									</script>

									<br clear="all"/>
										
									
									<fieldset>
									<h1 class="myaccount_link"><fmt:message key="WITHIN_US" bundle="${storeText}"/></h1>
									<c:if test="${!empty profileOrderItemBean}">
										<c:set var="shippingModeId" value="${profileOrderItemBean.shippingModeId}" />
									</c:if>
									<c:if test="${!empty errorMessage}">
										<c:set var="shippingModeId" value="${WCParam.shipModeId}" />
									</c:if>
									<wcbase:useBean id="shipModeListBean" classname="com.ibm.commerce.tools.shipping.ShippingModeListDataBean" scope="page" > 
									</wcbase:useBean>
									<c:set var="shipModeApplied" value="" />

									<c:forEach items="${shipModeListBean.shippingModeList}" var="shippingModeBean" varStatus="status">
										<c:if test="${!empty shippingModeId}">
											<c:choose>
												<c:when test="${shippingModeBean.description.shipModeId eq shippingModeId}">
													<c:set var="selection" value="checked=true" />
													<c:set var="shipModeApplied" value="true" />
												</c:when>
												<c:otherwise>
													<c:set var="selection" value="" />
												</c:otherwise>
											</c:choose>
											<input type="radio" name="shipModeId" id="WC_QuickCheckoutProfileForm_FormInput_<c:out value='${shippingModeBean.description.shipModeId}'/>_In_QuickCheckout_1" value="<c:out value="${shippingModeBean.description.shipModeId}"/>" <c:out value="${selection}"/> class="radio"/>
											<label for="WC_QuickCheckoutProfileForm_FormInput_<c:out value='${shippingModeBean.description.shipModeId}'/>_In_QuickCheckout_1"><c:out value="${shippingModeBean.description.description}"/>
											<c:out value="${shippingModeBean.description.field1}"/>
											<c:out value="${shippingModeBean.description.field2}"/></label>
											<br/>
										</c:if>
										<c:if test="${empty shippingModeId}">
											<input type="radio" name="shipModeId" id="WC_QuickCheckoutProfileForm_FormInput_<c:out value='${shippingModeBean.description.shipModeId}'/>_In_QuickCheckout_1" value="<c:out value="${shippingModeBean.description.shipModeId}"/>" <c:if test="${status.count == 1}">checked="true"</c:if> class="radio"/>
											<label for="WC_QuickCheckoutProfileForm_FormInput_<c:out value='${shippingModeBean.description.shipModeId}'/>_In_QuickCheckout_1"><c:out value="${shippingModeBean.description.description}"/>
											<c:out value="${shippingModeBean.description.field1}"/>
											<c:out value="${shippingModeBean.description.field2}"/></label>
											<br/>
										</c:if>
									</c:forEach>
								   </fieldset>
								</div>
							</div>
					</form>
				
							
									
						<br clear="all" />
							
						
					
                    </div>

                    <div class="content_footer" id="WC_MyAccountQuickCheckoutProfileForm_div_91">
                         <div class="left_corner" id="WC_MyAccountQuickCheckoutProfileForm_div_86"></div>
                         <div class="button_footer_line" id="WC_MyAccountQuickCheckoutProfileForm_div_87">
                         	<span class="primary_button button_fit" >
								<span class="button_container">
									<span class="button_bg">
										<span class="button_top">
											<span class="button_bottom">   
												<a href="#" onclick="javascript:QuickCheckoutProfile.UpdateProfile(document.QuickCheckout);return false;" id="WC_MyAccountQuickCheckoutProfileForm_links_7"><fmt:message key="UPDATE" bundle="${storeText}"/></a>
	                         				</span>
										</span>	
									</span>
								</span>
							</span>	
                         </div>                         
						 <div class="right_corner" id="WC_MyAccountQuickCheckoutProfileForm_div_90"></div>
                    </div>
               </div>
          </div>
          <!-- Content End -->
     <!-- Main Content End -->

	<%@ include file="../../../include/LayoutContainerBottom.jspf"%>
</div>
<div id="page_shadow" class="shadow"></div>
<flow:ifEnabled feature="Analytics"><cm:pageview/></flow:ifEnabled>
</body>
</html>
