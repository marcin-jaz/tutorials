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
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf"%>
<%@ include file="../../../include/nocache.jspf" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>    
<%@ taglib uri="http://commerce.ibm.com/coremetrics"  prefix="cm" %>
<%-- ErrorMessageSetup.jspf is used to retrieve an appropriate error message when there is an error --%>
<%@ include file="../../../include/ErrorMessageSetup.jspf" %>

<c:set var="myAccountPage" value="true" scope="request"/>
<c:set var="hasBreadCrumbTrail" value="false" scope="request"/>

<wcf:url var="addressBookFormURL" value="NonAjaxAddressBookForm">
	<wcf:param name="storeId"   value="${WCParam.storeId}"  />
	<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
	<wcf:param name="langId" value="${langId}" />
</wcf:url>
<wcf:url var="profileFormViewURL" value="NonAjaxProfileFormView">
	<wcf:param name="storeId"   value="${WCParam.storeId}"  />
	<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
	<wcf:param name="langId" value="${langId}" />
</wcf:url>	
<wcf:url var="trackOrderStatusURL" value="NonAjaxTrackOrderStatus">
	<wcf:param name="storeId"   value="${WCParam.storeId}"  />
	<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
	<wcf:param name="langId" value="${langId}" />
</wcf:url>
<wcf:url var="userRegistrationFormURL" value="NonAjaxUserRegistrationForm">
	<wcf:param name="storeId"   value="${WCParam.storeId}"  />
	<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
	<wcf:param name="langId" value="${langId}" />
	<wcf:param name="editRegistration" value="Y" />
</wcf:url>
<wcf:url var="AjaxCheckoutDisplayViewURL" value="AjaxCheckoutDisplayView">
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
<wcf:url var="couponWalletURL" value="NonAjaxCouponWallet" type="Ajax">
	<wcf:param name="storeId"   value="${WCParam.storeId}"  />
	<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
	<wcf:param name="langId" value="${langId}" />
</wcf:url>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="${shortLocale}" xml:lang="${shortLocale}">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><fmt:message key="MYACCOUNT_MY_COUPONS" bundle="${storeText}"/></title>
<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${vfileStylesheet}"/>" type="text/css"/>
<!--[if lte IE 6]>
<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${vfileStylesheetie}"/>" type="text/css"/>
<![endif]-->
<script type="text/javascript" src="<c:out value="${dojoFile}"/>" djConfig="${dojoConfigParams}"></script>
<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/MessageHelper.js"/>"></script>
<%@ include file="../../../include/CommonJSToInclude.jspf"%>
<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/UserArea/AddressHelper.js"/>"></script>
<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/UserArea/MyAccountDisplay.js"/>"></script>
<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/UserArea/MyAccountServicesDeclaration.js"/>"></script>
<script type="text/javascript">
	MyAccountServicesDeclarationJS.setCommonParameters('<c:out value='${WCParam.langId}'/>','<c:out value='${WCParam.storeId}'/>','<c:out value='${WCParam.catalogId}'/>');
</script>
<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/ServicesDeclaration.js"/>"></script>
<script type="text/javascript" src="<c:out value='${jsAssetsDir}javascript/CheckoutArea/CheckoutHelper.js'/>"></script>
</head>
<body>

<%@ include file="../../../include/StoreCommonUtilities.jspf"%>
<!-- Page Start -->
<div id="page">
	<%@ include file="../../../include/LayoutContainerTop.jspf"%>

    <!-- Main Content Start -->
		<c:set var="myAccountPage" value="true" scope="request"/>

		<wcf:url var="AjaxMyAccountCenterLinkDisplayURL" value="AjaxLogonFormCenterLinksDisplayView">    
			<wcf:param name="storeId"   value="${WCParam.storeId}"  />
			<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
			<wcf:param name="langId" value="${langId}" />
		</wcf:url>

		<div id="box">	
				<div class="left" id="WC_AccountForm_div_1">
						<%-- 
						***
						*	Start: Error handling
						* Show an appropriate error message when a user enters invalid information into the form.
						***
						--%>
					
						<c:if test="${!empty errorMessage}">
							<c:out value="${errorMessage}"/><br /><br />
						</c:if>
						<%-- 
						***
						*	End: Error handling
						***
						--%>	
					</div>
			<div class="my_account" id="WC_NonAjaxCouponWalletDisplay_div_1">		

					<div class="main_header" id="WC_NonAjaxCouponWalletDisplay_div_2">
						<div class="left_corner" id="WC_NonAjaxCouponWalletDisplay_div_3"></div>
						<div class="left" id="WC_NonAjaxCouponWalletDisplay_div_4"><span class="main_header_text"><fmt:message key='MYACCOUNT_MY_COUPONS' bundle='${storeText}'/></span></div>
						<div class="right_corner" id="WC_NonAjaxCouponWalletDisplay_div_5"></div>
					</div>
					
					<div class="body" id="WC_NonAjaxCouponWalletDisplay_div_6">
						<div class="couponWalletContainer">						
						<%out.flush();%>
						<c:import url="${jspStoreDir}Snippets/Marketing/Promotions/CouponWalletTable.jsp">
								<c:param name="returnView" value="${couponWalletURL}" />
						</c:import>
						<%out.flush();%>
						</div>
						<br/>								
						<br clear="all" />					
					</div>
					<div class="footer" id="WC_NonAjaxCouponWalletDisplay_div_7">
					  <div class="left_corner" id="WC_NonAjaxCouponWalletDisplay_div_8"></div>
					  <div class="tile" id="WC_NonAjaxCouponWalletDisplay_div_9"></div>
					  <div class="right_corner" id="WC_NonAjaxCouponWalletDisplay_div_10"></div>
					</div>
				
			</div>
		  </div>
	<!-- Main Content Start -->

	<%@ include file="../../../include/LayoutContainerBottom.jspf"%>
</div>
<div id="page_shadow" class="shadow"></div>
<flow:ifEnabled feature="Analytics"><cm:pageview/></flow:ifEnabled>
</body>
</html>
