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
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../include/JSTLEnvironmentSetup.jspf"%>
<%@ include file="../../include/nocache.jspf"%>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ taglib uri="http://commerce.ibm.com/coremetrics"  prefix="cm" %>
<c:set var="isAjax" value="false"/>
<flow:ifEnabled feature="AjaxMyAccountPage">
	<c:set var="isAjax" value="true"/>
</flow:ifEnabled>

<wcf:url var="AjaxMyAccountCenterLinkDisplayURL" value="AjaxLogonFormCenterLinksDisplayView" type="Ajax">    
	<wcf:param name="storeId"   value="${WCParam.storeId}"  />
	<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
	<flow:ifDisabled feature="preferredLanguage">
		<wcf:param name="langId" value="${langId}" />
	</flow:ifDisabled>
	<wcf:param name="myAcctUpdate" value="1" />
</wcf:url>
<wcf:url var="AjaxCheckoutDisplayViewURL" value="AjaxCheckoutDisplayView">
	<wcf:param name="storeId"   value="${WCParam.storeId}"  />
	<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
	<wcf:param name="langId" value="${langId}" />
</wcf:url>
<wcf:url var="OrderCalculateURL" value="OrderCalculate">
	<wcf:param name="storeId"   value="${WCParam.storeId}"  />
	<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
	<wcf:param name="langId" value="${langId}" />
	<wcf:param name="calculationUsageId" value="-1" />
	<wcf:param name="calculationUsageId" value="-2" />
	<wcf:param name="calculationUsageId" value="-7" />
</wcf:url>
<wcf:url var="AddressFormURL" value="AjaxQuickCheckoutAddressForm" type="Ajax">
	<wcf:param name="storeId"   value="${WCParam.storeId}"  />
	<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
	<wcf:param name="langId" value="${langId}" />
</wcf:url>
<wcf:url var="EditAddAddressURL" value="AjaxAccountAddressForm" type="Ajax">
	<wcf:param name="storeId"   value="${WCParam.storeId}"  />
	<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
	<wcf:param name="langId" value="${langId}" />
</wcf:url>
<wcf:url var="PrepareOrderURL" value="OrderProcessServiceOrderPrepare">
	<wcf:param name="storeId"   value="${WCParam.storeId}"  />
	<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
	<wcf:param name="langId" value="${langId}" />
	<wcf:param name="URL" value="${AjaxCheckoutDisplayViewURL}" />
</wcf:url>
<wcf:url var="profileFormViewURL" value="AjaxProfileFormView" type="Ajax">
	<wcf:param name="storeId"   value="${WCParam.storeId}"  />
	<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
	<wcf:param name="langId" value="${langId}" />
</wcf:url>
<wcf:url var="trackOrderStatusURL" value="AjaxTrackOrderStatus" type="Ajax">
	<wcf:param name="storeId"   value="${WCParam.storeId}"  />
	<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
	<wcf:param name="langId" value="${langId}" />
</wcf:url>

<flow:ifEnabled feature="EnableQuotes">
	<wcf:url var="trackQuoteStatusURL" value="AjaxTrackOrderStatus" type="Ajax">
		<wcf:param name="storeId"   value="${WCParam.storeId}"  />
		<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
		<wcf:param name="langId" value="${langId}" />
		<wcf:param name="isQuote" value="true" />
	</wcf:url>
</flow:ifEnabled>

<wcf:url var="interestItemDisplayURL" value="AjaxAccountWishListDisplayView" type="Ajax">
	<wcf:param name="storeId"   value="${WCParam.storeId}"  />
	<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
	<wcf:param name="langId" value="${langId}" />
	<wcf:param name="listId" value="." />
</wcf:url>
<wcf:url var="couponWalletURL" value="CouponWallet" type="Ajax">
	<wcf:param name="storeId"   value="${WCParam.storeId}"  />
	<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
	<wcf:param name="langId" value="${langId}" />
</wcf:url>
<flow:ifEnabled feature="RequisitionList">
	<wcf:url var="requisitionListURL" value="AjaxRequisitionListDisplayView" type="Ajax">
		<wcf:param name="storeId"   value="${WCParam.storeId}"  />
		<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
		<wcf:param name="langId" value="${langId}" />
	</wcf:url>
	<wcf:url var="requisitionListTableView" value="RequisitionListTableView" type="Ajax">
		<wcf:param name="storeId"   value="${WCParam.storeId}"  />
		<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
		<wcf:param name="langId" value="${langId}" />
	</wcf:url>
	<wcf:url var="requisitionListDetailView" value="AjaxRequisitionListDetailView" type="Ajax">
		<wcf:param name="storeId"   value="${WCParam.storeId}"  />
		<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
		<wcf:param name="langId" value="${langId}" />
	</wcf:url>
	<wcf:url var="requisitionListCreateView" value="AjaxRequisitionListCreateView" type="Ajax">
		<wcf:param name="storeId"   value="${WCParam.storeId}"  />
		<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
		<wcf:param name="langId" value="${langId}" />
		<wcf:param name="newList" value="true"/>
		<wcf:param name="editable" value="true"/>
	</wcf:url>
</flow:ifEnabled>
<wcf:url var="MyAccountURL" value="AjaxLogonForm">
  <wcf:param name="langId" value="${langId}" />
  <wcf:param name="storeId" value="${WCParam.storeId}" />
  <wcf:param name="catalogId" value="${WCParam.catalogId}" />
  <wcf:param name="myAcctMain" value="1" />
</wcf:url>
<wcf:url var="OrderStatusTableDetailsDisplayURL" value="OrderStatusTableDetailsDisplay" type="Ajax">
	<wcf:param name="storeId"   value="${WCParam.storeId}"  />
	<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
	<wcf:param name="langId" value="${langId}" />
	<c:if test="${WCParam.isQuote eq true}">
		<wcf:param name="isQuote" value="true" />
	</c:if>
</wcf:url>

<c:set var="myAccountPage" value="true" scope="request"/>
<c:set var="hasBreadCrumbTrail" value="false" scope="request"/>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"
xmlns:wairole="http://www.w3.org/2005/01/wai-rdf/GUIRoleTaxonomy#"
xmlns:waistate="http://www.w3.org/2005/07/aaa" lang="${shortLocale}" xml:lang="${shortLocale}">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<!-- Mimic Internet Explorer 7 -->
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" >
<title><fmt:message key="MA_MYACCOUNT" bundle="${storeText}"/></title>
<link href="<c:out value="${jspStoreImgDir}${vfileStylesheet}"/>" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${vfileStylesheetprint}"/>" type="text/css" media="print"/>
<!--[if lte IE 6]>
<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${vfileStylesheetie}"/>" type="text/css"/>
<![endif]-->  

<script type="text/javascript" src="<c:out value="${dojoFile}"/>" djConfig="${dojoConfigParams}"></script>
<%@ include file="../../include/CommonJSToInclude.jspf"%>
<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/UserArea/AddressHelper.js"/>"></script>
<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/CheckoutArea/CheckoutPayments.js"/>"></script>
<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/UserArea/AddressBookForm.js"/>"></script>
<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/UserArea/MyAccountDisplay.js"/>"></script>
<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/MessageHelper.js"/>"></script>
<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/UserArea/QuickCheckoutProfile.js"/>"></script>
<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/UserArea/AccountWishListDisplay.js"/>"></script>
<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/CatalogArea/CategoryDisplay.js"/>"></script>
<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/CatalogArea/CompareProduct.js"/>"></script>
<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/UserArea/MyAccountServicesDeclaration.js"/>"></script>
<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/UserArea/MyAccountControllersDeclaration.js"/>"></script>

<script type="text/javascript">
	dojo.addOnLoad(function() {
		categoryDisplayJS.setCommonParameters('${WCParam.langId}','${WCParam.storeId}','${WCParam.catalogId}','${userType}');
		MyAccountServicesDeclarationJS.setCommonParameters('${WCParam.langId}','${WCParam.storeId}','${WCParam.catalogId}');

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
		<fmt:message key="AB_UPDATE_SUCCESS" bundle="${storeText}" var="AB_UPDATE_SUCCESS"/>
		<fmt:message key="AB_DELETE_SUCCESS" bundle="${storeText}" var="AB_DELETE_SUCCESS"/>
		<fmt:message key="QC_UPDATE_SUCCESS" bundle="${storeText}" var="QC_UPDATE_SUCCESS"/>
		<fmt:message key="AB_ADDNEW_SUCCESS" bundle="${storeText}" var="AB_ADDNEW_SUCCESS"/>
		<fmt:message key="ERROR_EmailEmpty" bundle="${storeText}" var="ERROR_EmailEmpty"/>
		<fmt:message key="PWDREENTER_DO_NOT_MATCH" bundle="${storeText}" var="PWDREENTER_DO_NOT_MATCH"/>
		<fmt:message key="REQUIRED_FIELD_ENTER" bundle="${storeText}" var="REQUIRED_FIELD_ENTER"/>
		<fmt:message key="ERROR_INVALIDPHONE" bundle="${storeText}" var="ERROR_INVALIDPHONE"/>
		<fmt:message key="ERROR_DEFAULTADDRESS" bundle="${storeText}" var="ERROR_DEFAULTADDRESS"/>
		<fmt:message key="ERROR_SELECTADDRESS" bundle="${storeText}" var="ERROR_SELECTADDRESS"/>
		<fmt:message key="ERROR_INVALIDEMAILFORMAT" bundle="${storeText}" var="ERROR_INVALIDEMAILFORMAT"/>
		<fmt:message key="QUANTITY_INPUT_ERROR" bundle="${storeText}" var="QUANTITY_INPUT_ERROR"/>
		<fmt:message key="PRODUCT_NOT_BUYABLE" bundle="${storeText}" var="PRODUCT_NOT_BUYABLE"/>	
		<fmt:message key="INVALID_CONTRACT" bundle="${storeText}" var="INVALID_CONTRACT"/>					
		<fmt:message key="WISHLIST_MISSINGNAME" bundle="${storeText}" var="WISHLIST_MISSINGNAME"/>
		<fmt:message key="WISHLIST_MISSINGEMAIL" bundle="${storeText}" var="WISHLIST_MISSINGEMAIL"/>
		<fmt:message key="WISHLIST_INVALIDEMAILFORMAT" bundle="${storeText}" var="WISHLIST_INVALIDEMAILFORMAT"/>
		<fmt:message key="WISHLIST_EMPTY" bundle="${storeText}" var="WISHLIST_EMPTY"/>
		<fmt:message key="INVALID_EXPIRY_DATE" bundle="${storeText}" var="INVALID_EXPIRY_DATE"/>
		<fmt:message key="WISHLIST_ADDEDTOCART" bundle="${storeText}" var="WISHLIST_ADDEDTOCART"/>
		<fmt:message key="WISHLIST_REMOVEITEM" bundle="${storeText}" var="WISHLIST_REMOVEITEM"/>
		<fmt:message key="WISHLIST_ADDED" bundle="${storeText}" var="WISHLIST_ADDED"/>
		<fmt:message key="SHOPCART_ADDED" bundle="${storeText}" var="SHOPCART_ADDED"/>
		<fmt:message key="MYACCOUNT_ACTION_PERFORMED" bundle="${storeText}" var="MYACCOUNT_ACTION_PERFORMED"/>
		<fmt:message key="ERROR_MESSAGE_TYPE" bundle="${storeText}" var="ERROR_MESSAGE_TYPE"/>
		<fmt:message key="UPDATE_SUCCESS" bundle="${storeText}" var="UPDATE_SUCCESS"/>
		<fmt:message key="ERROR_SpecifyYear" bundle="${storeText}" var="ERROR_SpecifyYear"/>
		<fmt:message key="ERROR_SpecifyMonth" bundle="${storeText}" var="ERROR_SpecifyMonth"/>
		<fmt:message key="ERROR_SpecifyDate" bundle="${storeText}" var="ERROR_SpecifyDate"/>
		<fmt:message key="ERROR_InvalidDate1" bundle="${storeText}" var="ERROR_InvalidDate1"/>
		<fmt:message key="ERROR_InvalidDate2" bundle="${storeText}" var="ERROR_InvalidDate2"/>
		<fmt:message key="MO_ORDER_CANCELED_MSG" bundle="${storeText}" var="MO_ORDER_CANCELED_MSG"/>
		<fmt:message key="ERROR_CONTRACT_EXPIRED_GOTO_ORDER" bundle="${storeText}" var="ERROR_CONTRACT_EXPIRED_GOTO_ORDER"/>
		<fmt:message key="GENERICERR_MAINTEXT" bundle="${storeText}" var="ERROR_RETRIEVE_PRICE">                                     
			<fmt:param><fmt:message key="GENERICERR_CONTACT_US" bundle="${storeText}" /></fmt:param>
		</fmt:message>
		<fmt:message key="ORG_UPDATE_SUCCESS" bundle="${storeText}" var="ORG_UPDATE_SUCCESS"/>
		<fmt:message key="CONTRACT_UPDATE_SUCCESS" bundle="${storeText}" var="CONTRACT_UPDATE_SUCCESS"/>
		<fmt:message key="ERR_RESOLVING_SKU" bundle="${storeText}" var="ERR_RESOLVING_SKU"/>
		
		MessageHelper.setMessage("ERROR_RETRIEVE_PRICE", <wcf:json object="${ERROR_RETRIEVE_PRICE}"/>);
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
		/*Although for English, firstname is not mandatory. But it is mantagory for other languages.*/
		MessageHelper.setMessage("ERROR_FirstNameEmpty", <wcf:json object="${ERROR_FirstNameEmpty}"/>);
		MessageHelper.setMessage("ERROR_LastNameEmpty", <wcf:json object="${ERROR_LastNameEmpty}"/>);
		MessageHelper.setMessage("ERROR_MiddleNameEmpty", <wcf:json object="${ERROR_MiddleNameEmpty}"/>);
		MessageHelper.setMessage("ERROR_AddressEmpty", <wcf:json object="${ERROR_AddressEmpty}"/>);
		MessageHelper.setMessage("ERROR_CityEmpty", <wcf:json object="${ERROR_CityEmpty}"/>);
		MessageHelper.setMessage("ERROR_StateEmpty", <wcf:json object="${ERROR_StateEmpty}"/>);
		MessageHelper.setMessage("ERROR_CountryEmpty", <wcf:json object="${ERROR_CountryEmpty}"/>);
		MessageHelper.setMessage("ERROR_ZipCodeEmpty", <wcf:json object="${ERROR_ZipCodeEmpty}"/>);
		MessageHelper.setMessage("ERROR_PhonenumberEmpty", <wcf:json object="${ERROR_PhonenumberEmpty}"/>);
		MessageHelper.setMessage("AB_UPDATE_SUCCESS", <wcf:json object="${AB_UPDATE_SUCCESS}"/>);
		MessageHelper.setMessage("AB_DELETE_SUCCESS", <wcf:json object="${AB_DELETE_SUCCESS}"/>);
		MessageHelper.setMessage("QC_UPDATE_SUCCESS", <wcf:json object="${QC_UPDATE_SUCCESS}"/>);
		MessageHelper.setMessage("AB_ADDNEW_SUCCESS", <wcf:json object="${AB_ADDNEW_SUCCESS}"/>);
		MessageHelper.setMessage("ERROR_EmailEmpty", <wcf:json object="${ERROR_EmailEmpty}"/>);
		MessageHelper.setMessage("PWDREENTER_DO_NOT_MATCH", <wcf:json object="${PWDREENTER_DO_NOT_MATCH}"/>);
		MessageHelper.setMessage("REQUIRED_FIELD_ENTER", <wcf:json object="${REQUIRED_FIELD_ENTER}"/>);
		MessageHelper.setMessage("ERROR_INVALIDPHONE", <wcf:json object="${ERROR_INVALIDPHONE}"/>);
		MessageHelper.setMessage("ERROR_DEFAULTADDRESS", <wcf:json object="${ERROR_DEFAULTADDRESS}"/>);
		MessageHelper.setMessage("ERROR_SELECTADDRESS", <wcf:json object="${ERROR_SELECTADDRESS}"/>);
		MessageHelper.setMessage("ERROR_INVALIDEMAILFORMAT", <wcf:json object="${ERROR_INVALIDEMAILFORMAT}"/>);
		MessageHelper.setMessage("QUANTITY_INPUT_ERROR", <wcf:json object="${QUANTITY_INPUT_ERROR}"/>);
		MessageHelper.setMessage("PRODUCT_NOT_BUYABLE", <wcf:json object="${PRODUCT_NOT_BUYABLE}"/>);
		MessageHelper.setMessage("INVALID_CONTRACT", <wcf:json object="${INVALID_CONTRACT}"/>);
		MessageHelper.setMessage("ORG_UPDATE_SUCCESS", <wcf:json object="${ORG_UPDATE_SUCCESS}"/>);
		MessageHelper.setMessage("CONTRACT_UPDATE_SUCCESS", <wcf:json object="${CONTRACT_UPDATE_SUCCESS}"/>);
	
		var centerLinkUrl = "${AjaxMyAccountCenterLinkDisplayURL}";
		
		var centerLinkWidgetId = "MyAccountCenterLinkDisplay_Widget";

		
		MessageHelper.setMessage("WISHLIST_MISSINGNAME", <wcf:json object="${WISHLIST_MISSINGNAME}"/>);
		MessageHelper.setMessage("WISHLIST_MISSINGEMAIL", <wcf:json object="${WISHLIST_MISSINGEMAIL}"/>);
		MessageHelper.setMessage("WISHLIST_INVALIDEMAILFORMAT", <wcf:json object="${WISHLIST_INVALIDEMAILFORMAT}"/>);
		MessageHelper.setMessage("WISHLIST_EMPTY", <wcf:json object="${WISHLIST_EMPTY}"/>);
		MessageHelper.setMessage("INVALID_EXPIRY_DATE", <wcf:json object="${INVALID_EXPIRY_DATE}"/>);
		MessageHelper.setMessage("WISHLIST_ADDEDTOCART",<wcf:json object="${WISHLIST_ADDEDTOCART}"/>);
		MessageHelper.setMessage("WISHLIST_REMOVEITEM",<wcf:json object="${WISHLIST_REMOVEITEM}"/>);
		MessageHelper.setMessage("WISHLIST_ADDED",<wcf:json object="${WISHLIST_ADDED}"/>);	
		MessageHelper.setMessage("SHOPCART_ADDED", <wcf:json object="${SHOPCART_ADDED}"/>);
		MessageHelper.setMessage("MYACCOUNT_ACTION_PERFORMED", <wcf:json object="${MYACCOUNT_ACTION_PERFORMED}"/>);
		MessageHelper.setMessage("ERROR_MESSAGE_TYPE", <wcf:json object="${ERROR_MESSAGE_TYPE}"/>);
		MessageHelper.setMessage("UPDATE_SUCCESS", <wcf:json object="${UPDATE_SUCCESS}"/>);
		MessageHelper.setMessage("ERROR_SpecifyYear", <wcf:json object="${ERROR_SpecifyYear}"/>);
		MessageHelper.setMessage("ERROR_SpecifyMonth", <wcf:json object="${ERROR_SpecifyMonth}"/>);
		MessageHelper.setMessage("ERROR_SpecifyDate", <wcf:json object="${ERROR_SpecifyDate}"/>);
		MessageHelper.setMessage("ERROR_InvalidDate1", <wcf:json object="${ERROR_InvalidDate1}"/>);
		MessageHelper.setMessage("ERROR_InvalidDate2", <wcf:json object="${ERROR_InvalidDate2}"/>);
		MessageHelper.setMessage("MO_ORDER_CANCELED_MSG", <wcf:json object="${MO_ORDER_CANCELED_MSG}"/>);
		MessageHelper.setMessage("ERROR_CONTRACT_EXPIRED_GOTO_ORDER", <wcf:json object="${ERROR_CONTRACT_EXPIRED_GOTO_ORDER}"/>);
		MessageHelper.setMessage("ERR_RESOLVING_SKU", <wcf:json object="${ERR_RESOLVING_SKU}"/>);

		AddressBookFormJS.setCommonParameters("<c:out value='${langId}'/>", "<c:out value='${WCParam.storeId}'/>","<c:out value='${WCParam.catalogId}'/>");
		MyAccountDisplay.setAjaxVar('${isAjax}');
		QuickCheckoutProfile.setCommonParameters("<c:out value='${langId}'/>", "<c:out value='${WCParam.storeId}'/>","<c:out value='${WCParam.catalogId}'/>");
        MyAccountDisplay.initMyAccountDisplayHistory("myAccountMain", "MyAccountCenterLinkDisplay_Widget", centerLinkUrl);
		parseWidget("MyAccountCenterLinkDisplay_Widget");
		MyAccountControllersDeclarationJS.setControllerURL("ScheduledOrdersStatusDisplayController", "<c:out value='${OrderStatusTableDetailsDisplayURL}'/>");
		MyAccountControllersDeclarationJS.setControllerURL("ProcessedOrdersStatusDisplayController", "<c:out value='${OrderStatusTableDetailsDisplayURL}'/>");
		MyAccountControllersDeclarationJS.setControllerURL("WaitingForApprovalOrdersStatusDisplayController", "<c:out value='${OrderStatusTableDetailsDisplayURL}'/>");
	});
	//my account history tracking
	dojo.addOnLoad(MyAccountDisplay.processBookmarkURL); 

	
	if('<c:out value="${WCParam.page}"/>'=='orderstatus'){
		if('<c:out value="${WCParam.isQuote}"/>'=='true'){
			dojo.addOnLoad(function() { MyAccountDisplay.loadContentFromURL('trackQuoteStatus', '${trackQuoteStatusURL}') }); 
		}else{
			dojo.addOnLoad(function() { MyAccountDisplay.loadContentFromURL('trackOrderStatus', '${trackOrderStatusURL}') }); 
		}
	}
	if('<c:out value="${WCParam.loadPage}"/>'=='quickcheckout'){
		dojo.addOnLoad(function() { MyAccountDisplay.loadContentFromURL('checkoutProfile', '${profileFormViewURL}') }); 
	}
	if('<c:out value="${WCParam.page}"/>'=='customerlinkwishlist'){
		dojo.addOnLoad(function() { MyAccountDisplay.loadContentFromURL('wishList', '${interestItemDisplayURL}') }); 
	}

</script>
 <script type="text/javascript">
         function popupWindow(URL) {
            window.open(URL, "mywindow", "status=1,scrollbars=1,resizable=1");
         }
 </script>

</head>
<body>
 <script type="text/javascript">
 dojo.require("dojo.back");
 dojo.back.init();
 </script>

 <flow:ifEnabled feature="AjaxMyAccountPage">
		<script type="text/javascript">
			MyAccountDisplay.setAjaxVar("true");
		</script>
</flow:ifEnabled>

<script type="text/javascript">
dojo.require("wc.render.common");
wc.render.declareContext(
	"MyAccountCenterLinkDisplay_Context",
	{workAreaMode: "myAccountMain"},
	"");
</script>

<script type="text/javascript">
dojo.require("wc.render.common");
wc.render.declareContext(
	"paymentContext",

	{payment1: "empty", payment2: "empty", payment3: "empty", currentAreaNumber: "1", 
		billingAddress1: "0", billingAddress2: "0", billingAddress3: "0",
		billingMode1: "none", billingMode2: "none", billingMode3: "none"},

	"");
</script>

<script type="text/javascript">
dojo.require("wc.render.common");
wc.render.declareContext(
	"checkoutContext",

	{addressId: "0", type: "0", prefix: ""},

	"");
</script>

<script type="text/javascript">
dojo.require("wc.render.common");
wc.render.declareContext(
	"addressBookContext",

	{addressId: "0", type: "0"},

	"");
</script>


<script type="text/javascript">
dojo.require("wc.render.common");
wc.render.declareRefreshController({
	id: "quickCheckoutController",
	renderContext: wc.render.getContextById("checkoutContext"),
	url: "${AddressFormURL}",
	formId: ""

	,renderContextChangedHandler: function(message, widget) {
		var controller = this;
		var renderContext = this.renderContext;
		if (controller.testForChangedRC(["addressId"])||controller.testForChangedRC(["type"])) {
			if (renderContext.properties.type == widget.objectId) {
				widget.refresh(renderContext.properties);
			}
	  }
	}

});
</script>

<script type="text/javascript">
dojo.require("wc.render.common");
wc.render.declareRefreshController({
	id: "addressBookController",
	renderContext: wc.render.getContextById("addressBookContext"),
	url: "${EditAddAddressURL}",
	formId: ""

	,renderContextChangedHandler: function(message, widget) {
		var controller = this;
		var renderContext = this.renderContext;
		if (controller.testForChangedRC(["addressId"])) {
			widget.refresh(renderContext.properties);
		} else if (controller.renderContext.properties["type"] == "add") {
			widget.refresh(renderContext.properties);
		}	 
	}

	,postRefreshHandler: function(widget) {
		var controller = this;
		var renderContext = this.renderContext;
		controller.renderContext.properties["addressId"] = "0";
		controller.renderContext.properties["type"] = "0";
	}

});
</script>

<script type="text/javascript">
dojo.require("wc.render.common");
wc.render.declareRefreshController({
	id: "MyAccountCenterLinkDisplay_Controller",
	renderContext: wc.render.getContextById("MyAccountCenterLinkDisplay_Context"),
	url: "",
	formId: ""

	,modelChangedHandler: function(message, widget) {
		var controller = this;
		var renderContext = this.renderContext;
		console.debug("in model change " + message.actionId);
		if (message.actionId == "updateAddress" || message.actionId == "AddressDelete") {
			widget.refresh(renderContext.properties);
		}
		if (message.actionId == "UserRegistrationUpdate" || message.actionId == "profileUpdate" || message.actionId == "updateAddressBook") {
			if (MyAccountDisplay.getPreferredLanguageUpdated()) {
				MyAccountDisplay.setPreferredLanguageUpdated(false);
				//do not want to pass in the langId because the user has just changed the preferred language. 
				document.location.href = "AjaxLogonForm?catalogId=<c:out value="${catalogId}"/>&myAcctMain=1&storeId=<c:out value="${storeId}"/>";
			}	
			
			console.debug("model changed for UserRegistrationUpdate");
			controller.url = "${AjaxMyAccountCenterLinkDisplayURL}";
			wc.render.updateContext("MyAccountCenterLinkDisplay_Context", {workAreaMode:"myAccountMain"});
			if(document.getElementById(MyAccountDisplay.currentSelection)){
				document.getElementById(MyAccountDisplay.currentSelection).setAttribute("class","");
				document.getElementById(MyAccountDisplay.currentSelection).setAttribute("className","");
			}
			QuickCheckoutProfile.changed = 'false';
		}
		if (message.actionId == "InterestItemListMessage" ) {
			console.debug("model changed for InterestItemListMessage");
                  var wishListSendToMsg = "<fmt:message key="WISHLIST_SENDTO" bundle="${storeText}"><fmt:param value="%0"/></fmt:message>";
			var newWishListSendToMsg = wishListSendToMsg.replace(/%0/, message.recipient);
			document.getElementById("WishListEmailSucMsg_Div").innerHTML = newWishListSendToMsg;	
		   	AccountWishListDisplay.clearWishListEmailForm("SendMsgForm");
		      setTimeout("dojo.byId('WishListEmailSucMsg_Div').focus()",2000);
		}
		if (message.actionId == "AjaxAddOrderItem" ) {
			console.debug("model changed for AjaxAddOrderItem");	
		}
		if (message.actionId == "AjaxInterestItemAdd" ) {
			if(document.getElementById("featureProductAdd2WishList")==null || document.getElementById("featureProductAdd2WishList").value!='true'){
				console.debug("model changed for AjaxInterestItemAdd");	
				controller.url = "${AjaxMyAccountCenterLinkDisplayURL}";
				widget.refresh(renderContext.properties);
			}
		}
	}

	,renderContextChangedHandler: function(message, widget) {
		var controller = this;
		var renderContext = this.renderContext;
		if (controller.testForChangedRC(["workAreaMode"])) {
	  		console.debug("test:render context value changed");
	  		MyAccountDisplay.contextChanged = true; //When context changed, we need create history tracking information
			displayProgressBar();
			widget.refresh(renderContext.properties);			
	 	}
		
	}

	,postRefreshHandler: function(widget) {
		var controller = this;
		var renderContext = this.renderContext;
		console.debug("postrefreshscript is invoked");
		MessageHelper.hideAndClearMessage();

		// Set MyAccountCenterLinkDisplay_Controller url
		wc.render.getContextById("WishlistDisplay_Context").properties["url"] ='${interestItemDisplayURL}';

		if(QuickCheckoutProfile.pageVar == 'quickcheckout')
		{
			MessageHelper.displayStatusMessage(MessageHelper.messages["QC_UPDATE_SUCCESS"]);
			QuickCheckoutProfile.pageVar="";
		}
		if(AddressBookFormJS.pageVar == 'addressbook')
		{
			MessageHelper.displayStatusMessage(MessageHelper.messages["AB_UPDATE_SUCCESS"]);
			AddressBookFormJS.pageVar="";
		}
		if(AddressBookFormJS.addressDeleted == 'true')
		{
			MessageHelper.displayStatusMessage(MessageHelper.messages["AB_DELETE_SUCCESS"]);
			AddressBookFormJS.addressDeleted = 'false';
		}
		if(AddressBookFormJS.addressNew == 'true')
		{
			MessageHelper.displayStatusMessage(MessageHelper.messages["AB_ADDNEW_SUCCESS"]);
			AddressBookFormJS.addressNew = 'false';
		}
		if (MyAccountDisplay.contextChanged && (!MyAccountDisplay.isHistory)){
		 	
		  	var identifier = "&identifier=" + (new Date()).getTime();
		  	console.debug("url in history tracker is " + controller.url + identifier);
		  	
		  	for (var prop in controller.renderContext.properties) {
				console.debug(prop + "=" + controller.renderContext.properties[prop]);
			}
		 	var historyObject = new MyAccountDisplay.HistoryTracker(controller.renderContext.properties["workAreaMode"], 'MyAccountCenterLinkDisplay_Widget', controller.url + identifier);
		  	dojo.back.addToHistory(historyObject);	
		  	MyAccountDisplay.contextChanged = false;
		  	MyAccountDisplay.isHistory = false;  
		}
		<flow:ifEnabled feature="RequisitionList">
		if (RequisitionList.getCreatedBy()!=null) {
			dojo.byId('createdBy').innerHTML=RequisitionList.getCreatedBy();	
			RequisitionList.setCreatedBy(null);	
		}
		</flow:ifEnabled>
		if (typeof postRefreshHandlerExt != "undefined") {
			postRefreshHandlerExt(controller.renderContext.properties["workAreaMode"]);
		}
		cursor_clear();
	}

});
</script>
 
<%-- 
     nextUrl is a parameter returned from wc dojo framework when an error has occured when excuting an AJAX action. 
     It specifies the next action to be performed after the user has logged on (so after this page is loaded)
--%>
 <script type="text/javascript">
 	
 	/**
 	* This function checks to see if the passed in URL contains a parameter named 'finalView'. If it does, it will construct a new URL
 	* using value from 'finalView' paramter as the view name
 	* @param {String} myURL The URL to check if it contains finalView param
 	*/
	function getFinalViewURL(myURL) {
		var finalViewBeginIndex = myURL.indexOf('finalView');

		// check if finalView parameter is passed in the URL
		if (finalViewBeginIndex != -1){
			
			// index after parameter 'finalView', when it is -1, that means final view is the last paramter in the URL
			var finalViewEndIndex = myURL.indexOf('&', finalViewBeginIndex);
			if (finalViewEndIndex == -1) {
				var finalViewName = myURL.substring(finalViewBeginIndex + 10);
			} else {
				var finalViewName = myURL.substring(finalViewBeginIndex + 10, finalViewEndIndex);
			}
			var originalActionEndIndex = myURL.indexOf('?');
	
			// firstPartURL is everything after the '?' sign and before finalView parameter
			var firstPartURL = myURL.substring(originalActionEndIndex + 1, finalViewBeginIndex);
			// secondPartURL is everything after finalView parameter
			if (finalViewEndIndex == -1) {
				var secondPartURL = "";
			} else {
				var secondPartURL = myURL.substring(finalViewEndIndex);
			}
			
			// to make things simple, remove all leading and trailing '&' for firstPartURL and secondPartURL
			if (firstPartURL.charAt(firstPartURL.length - 1) == '&') {
				firstPartURL = firstPartURL.substring(0, firstPartURL.length-1);
			}
			if (firstPartURL.charAt(0) == '&') {
				firstPartURL = firstPartURL.substring(1);
			}
			if (secondPartURL.charAt(secondPartURL.length - 1) == '&') {
				secondPartURL = secondPartURL.substring(0, secondPartURL.length-1);
			}
			if (secondPartURL.charAt(0) == '&') {
				secondPartURL = secondPartURL.substring(1);
			}
						
			var finalURL = "";
			if (firstPartURL != "") {
				finalURL = finalViewName + '?' + firstPartURL;
				if (secondPartURL != "") {
					finalURL = finalURL + '&' + secondPartURL;
				}
			} else {
				finalURL = finalViewName + '?' + secondPartURL;
			}			
			return finalURL;
		} else {
			return "";
		}
	}
	
	wc.service.declare({
		id: "MyAcctAjaxAddOrderItem",
		actionId: "AjaxAddOrderItem",
		url: "<c:out value="${WCParam.nextUrl}" escapeXml="false"/>",
		formId: ""
		,successHandler: function(serviceResponse) {
			MessageHelper.hideAndClearMessage();
			MessageHelper.displayStatusMessage(MessageHelper.messages["SHOPCART_ADDED"]);
			cursor_clear();
		}
		,failureHandler: function(serviceResponse) {
			if (serviceResponse.errorMessage) {
			 	if(serviceResponse.errorMessageKey == "_ERR_NO_ELIGIBLE_TRADING"){
			 		MessageHelper.displayErrorMessage(MessageHelper.messages["ERROR_CONTRACT_EXPIRED_GOTO_ORDER"]);
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

	});
 	
	wc.service.declare({
		id: "MyAcctAjaxAddInterestItem",
		actionId: "AjaxInterestItemAdd",
		url: "<c:out value="${WCParam.nextUrl}" escapeXml="false"/>",
		formId: ""
		,successHandler: function(serviceResponse) {
			MessageHelper.hideAndClearMessage();
			MessageHelper.displayStatusMessage(MessageHelper.messages["WISHLIST_ADDED"]);
			cursor_clear();
		}
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
	});
	
	wc.service.declare({
		id: "MyAcctAjaxUpdateOrderItem",
		actionId: "AjaxUpdateOrderItem",
		url: getAbsoluteURL() + "AjaxOrderChangeServiceItemUpdate",
		formId: ""

		,successHandler: function(serviceResponse) {
			MessageHelper.hideAndClearMessage();
			cursor_clear();
		}

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

	});
	
	wc.service.declare({
		id: "MyAcctAjaxPromotionCodeManage",
		actionId: "",
		url: "<c:out value="${WCParam.nextUrl}" escapeXml="false"/>",
		formId: ""
		,successHandler: function(serviceResponse) {
			wc.service.invoke("MyAcctAjaxUpdateOrderItem", this.params);

			MessageHelper.hideAndClearMessage();
			finalViewURL = getFinalViewURL(this.url);
			if (finalViewURL != "") {
				document.location.href = finalViewURL;
			} else {
				MessageHelper.displayStatusMessage(MessageHelper.messages["MYACCOUNT_ACTION_PERFORMED"]);
				dojo.byId('MyAccountCenterLinkDisplay_Widget').refresh();
				cursor_clear();
			}
		}
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

	});
		
	wc.service.declare({
		id: "MyAcctGenericService",
		actionId: "",
		url: "<c:out value="${WCParam.nextUrl}" escapeXml="false"/>",
		formId: ""
		,successHandler: function(serviceResponse) {
			MessageHelper.hideAndClearMessage();
			finalViewURL = getFinalViewURL(this.url);
			if (finalViewURL != "") {
				document.location.href = finalViewURL;
			} else {
				MessageHelper.displayStatusMessage(MessageHelper.messages["MYACCOUNT_ACTION_PERFORMED"]);
				dojo.byId('MyAccountCenterLinkDisplay_Widget').refresh();
				cursor_clear();
			}
		}
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

	});
 
	var addToCartParams = [];
	// PasswordRequestAuthenticated is required by PasswordRequestCmdImpl - to indicate password is already entered by user. As we are in the my
	// account page, password is already entered and accepted.
	addToCartParams.PasswordRequestAuthenticated = 'TRUE';
	addToCartParams.calculationUsage = "-1,-2,-3,-4,-5,-6,-7";
	var myNextURL = '<c:out value="${WCParam.nextUrl}"/>';
	if('<c:out value="${WCParam.nextUrl}"/>'.length != 0){
		if('<c:out value="${WCParam.nextUrl}"/>'.indexOf('AjaxOrderChangeServiceItemAdd') != -1){
			dojo.addOnLoad(function() { invokeItemAdd(); }); 
		} else if('<c:out value="${WCParam.nextUrl}"/>'.indexOf('AjaxInterestItemAdd') != -1){
			dojo.addOnLoad(function() { invokeInterestItemAdd(); }); 
		} else if('<c:out value="${WCParam.nextUrl}"/>'.indexOf('AjaxPromotionCodeManage') != -1){
			dojo.addOnLoad(function() { invokePromoCodeManage(); }); 
		} else {
			dojo.addOnLoad(function() { invokeOtherService(); }); 
		}
	}

	function invokeItemAdd() {
		cursor_wait();	
		wc.service.invoke("MyAcctAjaxAddOrderItem", addToCartParams);
	}
	function invokeInterestItemAdd() {
		cursor_wait();	
		wc.service.invoke("MyAcctAjaxAddInterestItem", addToCartParams);
	}
	function invokePromoCodeManage() {
		cursor_wait();	
		wc.service.invoke("MyAcctAjaxPromotionCodeManage", addToCartParams);
	}
	function invokeOtherService() {
		cursor_wait();	
		wc.service.invoke("MyAcctGenericService", addToCartParams);
	}

</script>
 
<%@ include file="../../include/StoreCommonUtilities.jspf"%>
<!-- Page Start -->
<div id="page">
     <input type="hidden" id="compareMsgDisplay" value="true"/>
	<%@ include file="../../include/LayoutContainerTop.jspf"%>
	<script type="text/javascript">
		if('<c:out value="${WCParam.page}"/>'=='quickcheckout'){
			dojo.addOnLoad(function() { 
				MessageHelper.displayStatusMessage(MessageHelper.messages["QC_UPDATE_SUCCESS"]);
			});
	}
		if('<c:out value="${WCParam.page}"/>'=='addressbook'){
			dojo.addOnLoad(function() { 
				MessageHelper.displayStatusMessage(MessageHelper.messages["AB_UPDATE_SUCCESS"]);
			});
	}
		if('<c:out value="${WCParam.myAcctParticipation}"/>'=='orgUpdate'){
			dojo.addOnLoad(function() { 
				MessageHelper.displayStatusMessage(MessageHelper.messages["ORG_UPDATE_SUCCESS"]);
			});
		}
		if('<c:out value="${WCParam.myAcctParticipation}"/>'=='contractUpdate'){
			dojo.addOnLoad(function() { 
				MessageHelper.displayStatusMessage(MessageHelper.messages["CONTRACT_UPDATE_SUCCESS"]);
			});
		}
	</script>
	<%@ include file="../../Snippets/ReusableObjects/CatalogEntryQuickInfoDetails.jspf" %>
    <!-- Main Content Start -->
   		<c:choose>         
         <c:when test="${WCParam.myAcctMain == 1}">
		  <div id="WC_MyAccountDisplay_div_3_9">
			<div id="WC_MyAccountDisplay_div_4">
				<flow:ifEnabled feature="AjaxMyAccountPage">
				<div dojoType="wc.widget.RefreshArea" id="MyAccountCenterLinkDisplay_Widget" controllerId="MyAccountCenterLinkDisplay_Controller" role="wairole:region" waistate:live="polite" waistate:atomic="false" waistate:relevant="all">
				</flow:ifEnabled>
				
				<div id= "box">
						<div class="my_account" id="WC_MyAccountDisplay_div_4_1">
							<div class="main_header" id="WC_MyAccountDisplay_div_5">
								<div class="left_corner" id="WC_MyAccountDisplay_div_6"></div>
								<div class="left" id="WC_MyAccountDisplay_div_7"><span class="main_header_text"><fmt:message key='MA_SUMMARY' bundle='${storeText}'/></span></div>
								<div class="right_corner" id="WC_MyAccountDisplay_div_8"></div>
							</div>
							<div class="contentline" id="WC_MyAccountDisplay_div_9"></div>
							<div class="body" id="WC_MyAccountDisplay_div_13">
								<%out.flush();%>
								<c:import url="${jspStoreDir}UserArea/AccountSection/MyAccountCenterLinkDisplay.jsp">  
										<c:param name="storeId" value="${WCParam.storeId}"/>
										<c:param name="catalogId" value="${WCParam.catalogId}"/>  
										<c:param name="langId" value="${langId}"/>
								</c:import>
								<%out.flush();%>  
							</div>
							<div class="footer" id="WC_MyAccountDisplay_div_14">
							  <div class="left_corner" id="WC_MyAccountDisplay_div_15"></div>
							  <div class="tile" id="WC_MyAccountDisplay_div_16"></div>
							  <div class="right_corner" id="WC_MyAccountDisplay_div_17"></div>
							</div>
						</div>
					</div>
				<flow:ifEnabled feature="AjaxMyAccountPage">
				</div>
				</flow:ifEnabled>
			</div>
		  </div>
		</c:when>
		<c:otherwise>		
			<div id="box">
			<div class="my_account" id="WC_MyAccountDisplay_div_18">
			<flow:ifEnabled feature="AjaxMyAccountPage">
				<div dojoType="wc.widget.RefreshArea" id="MyAccountCenterLinkDisplay_Widget" controllerId="MyAccountCenterLinkDisplay_Controller" role="wairole:region" waistate:live="polite" waistate:atomic="false" waistate:relevant="all"> </div>
			</flow:ifEnabled>
			</div>
			</div>
		</c:otherwise>
	  </c:choose>
     <!-- Main Content End -->
     <!-- Footer Start Start -->
	<%@ include file="../../include/LayoutContainerBottom.jspf"%>
     <!-- Footer Start End -->
</div>
<div id="page_shadow" class="shadow"></div>
<flow:ifEnabled feature="Analytics"><cm:pageview/></flow:ifEnabled>
</body>
</html>
