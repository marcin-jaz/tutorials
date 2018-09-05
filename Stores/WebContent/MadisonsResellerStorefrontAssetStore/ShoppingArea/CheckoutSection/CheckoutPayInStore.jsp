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
<%-- 
  *****
  * This JSP displays the address selection page of the "Pick up in store" checkout flow. The page has a few different displays
  * depending on the state of the user:
  *     On the left side:
  *          1a) It shows option to "Pay in store" plus option to create a billing address if the user has no address.
  *          OR 
  *          1b) It shows option to "Pay in store" option and nothing else if the user existing addresses.
  *     On the right side:
  *          2) It shows the address details of the selected physical store on the previous page of the checkout flow.
  *****
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ taglib uri="http://commerce.ibm.com/coremetrics"  prefix="cm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../include/JSTLEnvironmentSetup.jspf" %>
<%@ include file="../../include/nocache.jspf" %>
<%@ include file="../../include/ErrorMessageSetup.jspf" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="${shortLocale}" xml:lang="${shortLocale}">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><fmt:message key="PAYINSTORE_TITLE" bundle="${storeText}"/></title>
<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${vfileStylesheet}"/>" type="text/css"/>
<!--[if lte IE 6]>
<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${vfileStylesheetie}"/>" type="text/css"/>
<![endif]-->
<script type="text/javascript" src="<c:out value="${dojoFile}"/>" djConfig="${dojoConfigParams}"></script>
<%@ include file="../../include/CommonJSToInclude.jspf"%>
</head>

<c:set var="isAjaxCheckOut" value="true"/>
<%-- Check if its a non-ajax checkout..--%>
<flow:ifDisabled feature="AjaxCheckout"> 
	<c:set var="isAjaxCheckOut" value="false"/>
</flow:ifDisabled>

<wcf:url var="ShoppingCartURL" value="OrderCalculate" type="Ajax">
   <wcf:param name="langId" value="${langId}" />
  <wcf:param name="storeId" value="${WCParam.storeId}" />
  <wcf:param name="catalogId" value="${WCParam.catalogId}" />
  <wcf:param name="URL" value="AjaxOrderItemDisplayView" />
  <wcf:param name="errorViewName" value="AjaxOrderItemDisplayView" />
  <wcf:param name="updatePrices" value="1" />
  <wcf:param name="calculationUsageId" value="-1" />
  <wcf:param name="orderId" value="." />
</wcf:url>

<wcf:url var="StoreSelectionURL" value="CheckoutStoreSelectionView">
  <wcf:param name="langId" value="${langId}" />
  <wcf:param name="storeId" value="${WCParam.storeId}" />
  <wcf:param name="catalogId" value="${WCParam.catalogId}" />
  <wcf:param name="fromPage" value="ShoppingCart" />
</wcf:url>

<%-- Retrieve the current page of order & order item information from this request --%>
<c:set var="order" value="${requestScope.orderInCart}" />
<c:if test="${empty order || order==null}">
	<wcf:getData type="com.ibm.commerce.order.facade.datatypes.OrderType"
	       var="order" expressionBuilder="findCurrentShoppingCart" scope="request">
	       <wcf:param name="accessProfile" value="IBM_Summary" />
	</wcf:getData>
</c:if>
<c:set var="isPayInStore" value="false"/>
<c:forEach var="paymentInstruction" items="${order.orderPaymentInfo.paymentInstruction}">
	<c:if test="${!empty existingPaymentInstructionIds}">
		<c:set var="existingPaymentInstructionIds" value="${existingPaymentInstructionIds},"/>
	</c:if>
	<c:set var="existingPaymentInstructionIds" value="${existingPaymentInstructionIds}${paymentInstruction.uniqueID}"/>
	<c:if test="${paymentInstruction.paymentMethod.paymentMethodName == 'PayInStore'}">
		<c:set var="isPayInStore" value="true"/>
	</c:if>
</c:forEach>

<wcf:getData type="com.ibm.commerce.order.facade.datatypes.OrderType"
       var="usablePayments" expressionBuilder="findCurrentShoppingCart">
       <wcf:param name="accessProfile" value="IBM_UsablePaymentInfo" />
</wcf:getData>
<c:set var="hasValidAddresses" value="false"/>
<c:forEach var="payment" items="${usablePayments.usablePaymentInformation}">
	<c:if test = "${fn:length(payment.usableBillingAddress) > 0 && !hasValidAddresses}">
		<c:set var="hasValidAddresses" value="true"/>
	</c:if>
</c:forEach>

<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/MessageHelper.js"/>"></script>
<script type="text/javascript" src="<c:out value='${jsAssetsDir}javascript/UserArea/AddressHelper.js'/>"></script>
<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/CheckoutArea/ShipmodeSelectionExt.js"/>"></script>

<script type="text/javascript">
	dojo.addOnLoad(function() {
		ShipmodeSelectionExtJS.setCommonParameters('${WCParam.langId}','${WCParam.storeId}','${WCParam.catalogId}');
		<fmt:message key="ERROR_RecipientTooLong" bundle="${storeText}" var="ERROR_RecipientTooLong"/>
		<fmt:message key="ERROR_FirstNameTooLong" bundle="${storeText}" var="ERROR_FirstNameTooLong"/>
		<fmt:message key="ERROR_LastNameTooLong" bundle="${storeText}" var="ERROR_LastNameTooLong"/>
		<fmt:message key="ERROR_AddressTooLong" bundle="${storeText}" var="ERROR_AddressTooLong"/>
		<fmt:message key="ERROR_CityTooLong" bundle="${storeText}" var="ERROR_CityTooLong"/>
		<fmt:message key="ERROR_StateTooLong" bundle="${storeText}" var="ERROR_StateTooLong"/>
		<fmt:message key="ERROR_CountryTooLong" bundle="${storeText}" var="ERROR_CountryTooLong"/>
		<fmt:message key="ERROR_ZipCodeTooLong" bundle="${storeText}" var="ERROR_ZipCodeTooLong"/>
		<fmt:message key="ERROR_EmailTooLong" bundle="${storeText}" var="ERROR_EmailTooLong"/>
		<fmt:message key="ERROR_PhoneTooLong" bundle="${storeText}" var="ERROR_PhoneTooLong"/>
		<fmt:message key="ERROR_RecipientEmpty" bundle="${storeText}" var="ERROR_RecipientEmpty"/>
		<fmt:message key="ERROR_LastNameEmpty" bundle="${storeText}" var="ERROR_LastNameEmpty"/>
		<fmt:message key="ERROR_AddressEmpty" bundle="${storeText}" var="ERROR_AddressEmpty"/>
		<fmt:message key="ERROR_CityEmpty" bundle="${storeText}" var="ERROR_CityEmpty"/>
		<fmt:message key="ERROR_StateEmpty" bundle="${storeText}" var="ERROR_StateEmpty"/>
		<fmt:message key="ERROR_CountryEmpty" bundle="${storeText}" var="ERROR_CountryEmpty"/>
		<fmt:message key="ERROR_ZipCodeEmpty" bundle="${storeText}" var="ERROR_ZipCodeEmpty"/>
		<fmt:message key="ERROR_EmailEmpty" bundle="${storeText}" var="ERROR_EmailEmpty"/>
		<fmt:message key="ERROR_FirstNameEmpty" bundle="${storeText}" var="ERROR_FirstNameEmpty"/>
		<fmt:message key="ERROR_INVALIDEMAILFORMAT" bundle="${storeText}" var="ERROR_INVALIDEMAILFORMAT"/>
		<fmt:message key="ERROR_INVALIDPHONE" bundle="${storeText}" var="ERROR_INVALIDPHONE"/>
		MessageHelper.setMessage("ERROR_RecipientTooLong", <wcf:json object="${ERROR_RecipientTooLong}"/>);
		MessageHelper.setMessage("ERROR_FirstNameTooLong", <wcf:json object="${ERROR_FirstNameTooLong}"/>);
		MessageHelper.setMessage("ERROR_LastNameTooLong", <wcf:json object="${ERROR_LastNameTooLong}"/>);
		MessageHelper.setMessage("ERROR_AddressTooLong", <wcf:json object="${ERROR_AddressTooLong}"/>);
		MessageHelper.setMessage("ERROR_CityTooLong", <wcf:json object="${ERROR_CityTooLong}"/>);
		MessageHelper.setMessage("ERROR_StateTooLong", <wcf:json object="${ERROR_StateTooLong}"/>);
		MessageHelper.setMessage("ERROR_CountryTooLong", <wcf:json object="${ERROR_CountryTooLong}"/>);
		MessageHelper.setMessage("ERROR_ZipCodeTooLong", <wcf:json object="${ERROR_ZipCodeTooLong}"/>);
		MessageHelper.setMessage("ERROR_EmailTooLong", <wcf:json object="${ERROR_EmailTooLong}"/>);
		MessageHelper.setMessage("ERROR_PhoneTooLong", <wcf:json object="${ERROR_PhoneTooLong}"/>);
		MessageHelper.setMessage("ERROR_RecipientEmpty", <wcf:json object="${ERROR_RecipientEmpty}"/>);
		MessageHelper.setMessage("ERROR_LastNameEmpty", <wcf:json object="${ERROR_LastNameEmpty}"/>);
		MessageHelper.setMessage("ERROR_AddressEmpty", <wcf:json object="${ERROR_AddressEmpty}"/>);
		MessageHelper.setMessage("ERROR_CityEmpty", <wcf:json object="${ERROR_CityEmpty}"/>);
		MessageHelper.setMessage("ERROR_StateEmpty", <wcf:json object="${ERROR_StateEmpty}"/>);
		MessageHelper.setMessage("ERROR_CountryEmpty", <wcf:json object="${ERROR_CountryEmpty}"/>);
		MessageHelper.setMessage("ERROR_ZipCodeEmpty", <wcf:json object="${ERROR_ZipCodeEmpty}"/>);
		MessageHelper.setMessage("ERROR_EmailEmpty", <wcf:json object="${ERROR_EmailEmpty}"/>);
		MessageHelper.setMessage("ERROR_FirstNameEmpty", <wcf:json object="${ERROR_FirstNameEmpty}"/>);
		MessageHelper.setMessage("ERROR_INVALIDEMAILFORMAT", <wcf:json object="${ERROR_INVALIDEMAILFORMAT}"/>);
		MessageHelper.setMessage("ERROR_INVALIDPHONE", <wcf:json object="${ERROR_INVALIDPHONE}"/>);
	});
</script>


<body>
<%@ include file="../../include/StoreCommonUtilities.jspf"%>

<!-- Page Start -->
<div id="page">
	<!-- Header Nav Start -->
	<%@ include file="../../include/LayoutContainerTop.jspf"%>
	<!-- Breadcrumb Start -->
	<div id="checkout_crumb">
		<div class="crumb" id="WC_CheckoutPayInStore_div_1">
			<a href="<c:out value="${ShoppingCartURL}"/>" id="WC_CheckoutPayInStore_links_1"><span><fmt:message key="BCT_SHOPPING_CART" bundle="${storeText}"/></span></a> | 
			<a href="<c:out value="${StoreSelectionURL}"/>" id="WC_CheckoutPayInStore_links_2"><span><fmt:message key="BCT_STORE_SELECTION" bundle="${storeText}"/></span></a> | 
			<span class="on"><fmt:message key="BCT_ADDRESS" bundle="${storeText}"/></span> | 
			<span><fmt:message key="BCT_SHIPPING_AND_BILLING" bundle="${storeText}"/></span> | 
			<span><fmt:message key="BCT_ORDER_SUMMARY" bundle="${storeText}"/></span>
		</div>
	</div>
	<!-- Breadcrumb End --> 

<script type="text/javascript">
	dojo.addOnLoad(function() {
		ShipmodeSelectionExtJS.setOrderItemId('${orderInCart.orderItem[0].orderItemIdentifier.uniqueID}');
	});
</script>  
  
	<!-- Header Nav End -->
	<div id="MessageArea" >
		<br />
			<span id="ErrorMessageText" class="error_msg">
				<c:if test="${!empty errorMessage}">
					<c:out value="${errorMessage}"/>
				</c:if>
			</span>
		<br /><br />
	</div>
	
	<!-- Main Content Start -->
	<div id="content_wrapper">
		<div id="box">
			<div class="contentgrad_header" id="WC_CheckoutPayInStore_div_2">
				 <div class="left_corner" id="WC_CheckoutPayInStore_div_3"></div>
				 <div class="left" id="WC_CheckoutPayInStore_div_4"></div>
				 <div class="right_corner" id="WC_CheckoutPayInStore_div_5"></div>
			</div>
			
			<div class="body" id="WC_CheckoutPayInStore_div_6">
				<div id="unregistered_form">
					<div class="col1_bill" id="WC_CheckoutPayInStore_div_10">
						<h1><fmt:message key="UC_BILLINGADDRESS" bundle="${storeText}"/></h1>
					</div>
					
					<div class="col2_ship" id="WC_CheckoutPayInStore_div_11">
						<h1><fmt:message key="PAYINSTORE_STORE_ADDRESS" bundle="${storeText}"/></h1>
					</div>
					<div class="col1_bill" id="billingCreateEditArea1">
						<div class="label_spacer" id="WC_CheckoutPayInStore_div_11a">
							<input name="payInStorePaymentOption" id="payInStorePaymentOption" type="checkbox" class="checkbox" 
								<c:if test="${isPayInStore || WCParam.payInStore}"> checked="checked"</c:if> />
							<label for="payInStorePaymentOption"><fmt:message key="PAYINSTORE_PAYINSTORE" bundle="${storeText}"/></label>
						</div>
						<br />
						
						<div id="billingSectionDiv">
						<c:set var="formName" value="billingAddressCreateEditFormDiv_1"/>
						<form id="<c:out value="${formName}" />" name="<c:out value="${formName}" />" method="post" action="PersonChangeServiceAddressAdd">
						<input type="hidden" name="existingPaymentInstructionId" value="<c:out value="${existingPaymentInstructionIds}"/>" id="WC_CheckoutPayInStore_inputs_6"/>
						<c:choose>
							<c:when test="${hasValidAddresses}">
								<div class="label_spacer" id="WC_CheckoutPayInStore_div_11b">
									<fmt:message key="PAYINSTORE_BILLING_ADDRESS_DESC" bundle="${storeText}"/>
								</div>
								<br />
							</c:when>
							<c:otherwise>
									<input type="hidden" name="storeId" value="<c:out value="${storeId}" />" id="WC_CheckoutPayInStore_inputs_1"/>
									<input type="hidden" name="catalogId" value="<c:out value="${catalogId}" />" id="WC_CheckoutPayInStore_inputs_2"/>
									<input type="hidden" name="langId" value="<c:out value="${langId}" />" id="WC_CheckoutPayInStore_inputs_3"/>
									<input type="hidden" name="addressType" value="Billing" id="WC_CheckoutPayInStore_inputs_4"/>
									<input type="hidden" name="errorViewName" value="CheckoutPayInStoreView" id="WC_CheckoutPayInStore_inputs_5"/>
									<input type="hidden" name="URL" value="" id="WC_CheckoutPayInStore_inputs_7"/>
									<input type="hidden" name="authToken" value="${authToken}" id="WC_CheckoutPayInStore_inputs_authToken"/>
			
									<c:set var="divNum" value="1"/>
									<c:set var="stateDivName1" value="${paramPrefix}stateDiv${divNum}"/>
									<fmt:message key="BILL_BILLING_ADDRESS" bundle="${storeText}" var="address"/>
									
									<%-- 
										1. The hidden field "AddressForm_FieldsOrderByLocale" is to set all the mandatory fields AND the order of the fields
										that are going to be displayed in each locale-dependent address form, so that the JavaScript
										used for validation knows which fields to validate and in which order it should validate them.
										2. Mandatory fields use UPPER CASE, non-mandatory fields use lower case.
									--%>
									<c:choose>
										<c:when test="${locale == 'zh_CN'}">
											<%@ include file="../../Snippets/ReusableObjects/UnregisteredCheckoutAddressEntryForm_CN.jspf"%>
											<input type="hidden" id="AddressForm_FieldsOrderByLocale" value="NICK_NAME,LAST_NAME,first_name,COUNTRY/REGION,STATE/PROVINCE,CITY,ADDRESS,ZIP,phone1,EMAIL1"/>
										</c:when>
										<c:when test="${locale == 'zh_TW'}">
											<%@ include file="../../Snippets/ReusableObjects/UnregisteredCheckoutAddressEntryForm_TW.jspf"%>
											<input type="hidden" id="AddressForm_FieldsOrderByLocale" value="NICK_NAME,LAST_NAME,first_name,COUNTRY/REGION,STATE/PROVINCE,CITY,ZIP,ADDRESS,phone1,EMAIL1"/>
										</c:when>
										<c:when test="${locale == 'ru_RU'}">
											<%@ include file="../../Snippets/ReusableObjects/UnregisteredCheckoutAddressEntryForm_RU.jspf"%>
											<input type="hidden" id="AddressForm_FieldsOrderByLocale" value="NICK_NAME,first_name,middle_name,LAST_NAME,ADDRESS,ZIP,CITY,state/province,COUNTRY/REGION,phone1,EMAIL1"/>
										</c:when>
										<c:when test="${locale == 'ja_JP' || locale == 'ko_KR'}">
											<%@ include file="../../Snippets/ReusableObjects/UnregisteredCheckoutAddressEntryForm_JP_KR.jspf"%>
											<input type="hidden" id="AddressForm_FieldsOrderByLocale" value="NICK_NAME,LAST_NAME,FIRST_NAME,COUNTRY/REGION,ZIP,STATE/PROVINCE,CITY,ADDRESS,phone1,EMAIL1"/>
										</c:when>
										<c:when test="${locale == 'de_DE' || locale == 'es_ES' || locale == 'fr_FR' || locale == 'it_IT' || locale == 'ro_RO'}">
											<%@ include file="../../Snippets/ReusableObjects/UnregisteredCheckoutAddressEntryForm_DE_ES_FR_IT_RO.jspf"%>
											<input type="hidden" id="AddressForm_FieldsOrderByLocale" value="NICK_NAME,first_name,LAST_NAME,ADDRESS,ZIP,CITY,state/province,COUNTRY/REGION,phone1,EMAIL1"/>
										</c:when>
										<c:when test="${locale == 'pl_PL'}">
											<%@ include file="../../Snippets/ReusableObjects/UnregisteredCheckoutAddressEntryForm_PL.jspf"%>
											<input type="hidden" id="AddressForm_FieldsOrderByLocale" value="NICK_NAME,first_name,LAST_NAME,ADDRESS,ZIP,CITY,STATE/PROVINCE,COUNTRY/REGION,phone1,EMAIL1"/>
										</c:when>
										<c:otherwise>
											<%@ include file="../../Snippets/ReusableObjects/UnregisteredCheckoutAddressEntryForm.jspf"%>
											<input type="hidden" id="AddressForm_FieldsOrderByLocale" value="NICK_NAME,first_name,LAST_NAME,ADDRESS,CITY,COUNTRY/REGION,STATE/PROVINCE,ZIP,phone1,EMAIL1"/>
										</c:otherwise>
									</c:choose>
									<br />
									<br />
							</c:otherwise>
						</c:choose>
						</form>
						</div>
					</div>

					<div class="col2_ship" id="shippingCreateEditArea1">
						<div id="WC_CheckoutPayInStore_div_12">
							<c:set var="selectedPhysicalStoreId" value="${cookie.WC_pickUpStore.value}"/>
							<wcf:getData type="com.ibm.commerce.store.facade.datatypes.PhysicalStoreType[]"
								     var="physicalStores" varException="physicalStoreException" expressionBuilder="findPhysicalStoresByUniqueIDs">
								<wcf:param name="accessProfile" value="IBM_Store_Details" />
								<wcf:param name="uniqueId" value="${selectedPhysicalStoreId}" />
							</wcf:getData>
							
							<c:out value="${physicalStores[0].description[0].name}"/><br />
							<c:import url="${jspStoreDir}Snippets/Member/StoreAddress/DOMAddressDisplay.jsp">
								<c:param name="physicalStoreId" value= "${physicalStores[0].physicalStoreIdentifier.uniqueID}"/>
							</c:import>
						</div>
					</div>
				</div>
				<br clear="all" /> <br clear="all" />
			</div>
			<div class="content_footer" id="WC_CheckoutPayInStore_div_13">
				<div class="left_corner" id="WC_CheckoutPayInStore_div_14"></div>
				<div class="button_footer_line unregistered" id="WC_CheckoutPayInStore_div_15">
					<div class="left" id="WC_CheckoutPayInStore_div_16">
						<span class="secondary_button button_fit" >
							<span class="button_container">
								<span class="button_bg">
									<span class="button_top">
										<span class="button_bottom">   
											<a href="<c:out value="${StoreSelectionURL}"/>" id="WC_CheckoutPayInStore_links_3">
												<fmt:message key="PAYINSTORE_BACK" bundle="${storeText}"/><span class="spanacce"><fmt:message key="PAYINSTORE_BACKSTEP" bundle="${storeText}"/></span>
											</a>
										</span>
									</span>	
								</span>
							</span>
						</span>
					</div>
					<div class="left" id="WC_CheckoutPayInStore_div_19">
						<span class="primary_button button_fit" >
							<span class="button_container">
								<span class="button_bg">
									<span class="button_top">
										<span class="button_bottom">   
											<a href="JavaScript:ShipmodeSelectionExtJS.submitAddressForm('<c:out value="${formName}" />', '<c:out value="${stateDivName1}"/>',<c:out value="${hasValidAddresses}"/>);" id="WC_CheckoutPayInStore_links_4">
												<fmt:message key="PAYINSTORE_NEXT" bundle="${storeText}"/><span class="spanacce"><fmt:message key="PAYINSTORE_NEXTSTEP" bundle="${storeText}"/></span>
											</a>
										</span>
									</span>	
								</span>
							</span>
						</span>
					</div>
					<div class="button_side_message" id="WC_CheckoutPayInStore_div_22">
						<fmt:message key="UC_NEXTSTEP" bundle="${storeText}"/>
					</div>
				</div>
				<div class="right_corner" id="WC_CheckoutPayInStore_div_23"></div>
			</div>
		</div>
		<!-- Content End -->
	</div>
	<!-- Main Content End -->
   
	<!-- Footer Start -->
	<%@ include file="../../include/LayoutContainerBottom.jspf"%>  
	<!-- Footer End -->
   
</div>
<div id="page_shadow" class="shadow"></div>
	<flow:ifEnabled feature="Analytics">
		<cm:pageview/>
	</flow:ifEnabled>
</body>
</html>

