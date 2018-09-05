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
<%@ include file="../../../include/ErrorMessageSetup.jspf"%>
<%@ include file="../../../include/nocache.jspf" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>    
<%@ taglib uri="http://commerce.ibm.com/coremetrics"  prefix="cm" %>

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
<wcf:url var="OrderStatusTableDetailsDisplayURL" value="OrderStatusTableDetailsDisplay" type="Ajax">
	<wcf:param name="storeId"   value="${WCParam.storeId}"  />
	<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
	<wcf:param name="langId" value="${langId}" />
	<c:if test="${WCParam.isQuote eq true}">
		<wcf:param name="isQuote" value="true" />
	</c:if>
</wcf:url>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="${shortLocale}" xml:lang="${shortLocale}">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><fmt:message key="MO_MYORDERS" bundle="${storeText}"/></title>
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
<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/UserArea/MyAccountControllersDeclaration.js"/>"></script>
<script type="text/javascript">
	dojo.addOnLoad(function() {
		MyAccountServicesDeclarationJS.setCommonParameters('${WCParam.langId}','${WCParam.storeId}','${WCParam.catalogId}');
		<fmt:message key="MO_ORDER_CANCELED_MSG" bundle="${storeText}" var="MO_ORDER_CANCELED_MSG"/>
		MessageHelper.setMessage("MO_ORDER_CANCELED_MSG", <wcf:json object="${MO_ORDER_CANCELED_MSG}"/>);		
		MyAccountControllersDeclarationJS.setControllerURL("ScheduledOrdersStatusDisplayController", "<c:out value='${OrderStatusTableDetailsDisplayURL}'/>");
		MyAccountControllersDeclarationJS.setControllerURL("ProcessedOrdersStatusDisplayController", "<c:out value='${OrderStatusTableDetailsDisplayURL}'/>");
		MyAccountControllersDeclarationJS.setControllerURL("WaitingForApprovalOrdersStatusDisplayController", "<c:out value='${OrderStatusTableDetailsDisplayURL}'/>");
	});
</script>

</head>
<body>

<%@ include file="../../../include/StoreCommonUtilities.jspf"%>
<!-- Page Start -->
<div id="page">
     <!-- Header Nav Start -->
	<%@ include file="../../../include/LayoutContainerTop.jspf"%>

    <!-- Main Content Start -->
		<wcf:url var="AjaxMyAccountCenterLinkDisplayURL" value="AjaxLogonFormCenterLinksDisplayView">    
			<wcf:param name="storeId"   value="${WCParam.storeId}"  />
			<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
			<wcf:param name="langId" value="${langId}" />
		</wcf:url>
		
		<c:if test="${!empty errorMessage}">
			<fmt:message var ="msgType" key="ERROR_MESSAGE_TYPE" bundle="${storeText}"/>
			<c:set var = "errorMessage" value ="${msgType}${errorMessage}"/>
			<script type="text/javascript">
				dojo.addOnLoad(function() { 
					dojo.byId('MessageArea').style.display = "block";
					dojo.byId('ErrorMessageText').innerHTML =<wcf:json object="${errorMessage}"/>;
					dojo.byId('MessageArea').focus();
					setTimeout("dojo.byId('ErrorMessageText').focus()",2000);
				});
			</script>
		</c:if>
		<div id="box">
			<div class="my_account" id="WC_OrderStatusDisplay_div_1">		

					<div class="main_header" id="WC_OrderStatusCommonPage_div_2">
						<div class="left_corner" id="WC_OrderStatusCommonPage_div_3"></div>
						<div class="left" id="WC_OrderStatusCommonPage_div_4">
							<span class="main_header_text">
								<c:choose>
									<c:when test="${WCParam.isQuote eq true}">
										<fmt:message key='MO_MYQUOTES' bundle='${storeText}'/>
									</c:when>
									<c:otherwise>
										<fmt:message key='MO_MYORDERS' bundle='${storeText}'/>
									</c:otherwise>
								</c:choose>
							</span>
						</div>
						<div class="right_corner" id="WC_OrderStatusCommonPage_div_5"></div>
					</div>
					
					<div class="body" id="WC_OrderStatusCommonPage_div_6">						
						<% out.flush(); %>
							<c:choose>
								<c:when test="${WCParam.isQuote eq true}">
									<c:import url="${jspStoreDir}Snippets/Order/Cart/OrderStatusTableDisplay.jsp" >
										<c:param name="isQuote" value="true"/>
									</c:import>
								</c:when>
								<c:otherwise>
									<c:import url="${jspStoreDir}Snippets/Order/Cart/OrderStatusTableDisplay.jsp" ></c:import>
								</c:otherwise>
							</c:choose>
						<% out.flush();%>				
						<br/>								
						<br clear="all" />					
					</div>
					<div class="footer" id="WC_OrderStatusCommonPage_div_7">
					  <div class="left_corner" id="WC_OrderStatusCommonPage_div_8"></div>
					  <div class="tile" id="WC_OrderStatusCommonPage_div_9"></div>
					  <div class="right_corner" id="WC_OrderStatusCommonPage_div_10"></div>
					</div>
				
			</div>
		  </div>

	<%@ include file="../../../include/LayoutContainerBottom.jspf"%>
</div>
<div id="page_shadow" class="shadow"></div>
<flow:ifEnabled feature="Analytics"><cm:pageview/></flow:ifEnabled>
</body>
</html>
