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
  * This JSP displays the users account page. 
  *****
--%>

<!-- BEGIN MyAccountDisplay.jsp -->

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>

<%@ include file="../../../include/parameters.jspf" %>
<%@ include file="../../include/JSTLEnvironmentSetup.jspf" %>


<c:choose>
	<%--	Test to see if user is logged in. If not, redirect to the login page. 
			After logging in, we will be redirected back to this page.
	 --%>
	<c:when test="${userType == 'G'}">
		<wcf:url var="LoginURL" value="MobileLogonForm">
			<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
			<wcf:param name="storeId" value="${WCParam.storeId}"/>
			<wcf:param name="langId" value="${WCParam.langId}"/>
			<wcf:param name="URL" value="mMyAccountDisplay"/>
		</wcf:url>

		<%out.flush();%>
		<c:import url="${LoginURL}"/>
		<%out.flush();%>
	</c:when>
	<c:otherwise>

		<%-- Required variables for breadcrumb support --%>
		<c:set var="accountPageGroup" value="true" scope="request" />
		<c:set var="accountDisplayPage" value="true" scope="request" />
		
		<wcf:url var="OrderHistoryURL" value="mOrderHistory">
		  <wcf:param name="langId" value="${langId}" />
		  <wcf:param name="storeId" value="${WCParam.storeId}" />
		  <wcf:param name="catalogId" value="${WCParam.catalogId}" />
		</wcf:url>
		
		<wcf:url var="PerInfoDispURL" value="MobileUserRegistrationUpdate">
			<wcf:param name="langId" value="${langId}" />
			<wcf:param name="storeId" value="${WCParam.storeId}" />
			<wcf:param name="catalogId" value="${WCParam.catalogId}" />
		</wcf:url>
		
		<wcf:url var="AddressBookURL" value="mOrderBillingAddressSelection">
			<wcf:param name="langId" value="${langId}" />
			<wcf:param name="storeId" value="${WCParam.storeId}" />
			<wcf:param name="catalogId" value="${WCParam.catalogId}" />
			<wcf:param name="fromPage" value="MyAccount" />
		</wcf:url>
		
		<wcf:url var="WishListDispURL" value="InterestItemDisplay">
			<wcf:param name="langId" value="${langId}" />
			<wcf:param name="storeId" value="${WCParam.storeId}" />
			<wcf:param name="catalogId" value="${WCParam.catalogId}" />
			<wcf:param name="listId" value="." />  			
			<wcf:param name="URL" value="mInterestListDisplay" />  			
		</wcf:url>
		
		<wcf:url var="SubscriptionDispURL" value="mMySubscriptionDisplay">
			<wcf:param name="langId" value="${langId}" />
			<wcf:param name="storeId" value="${WCParam.storeId}" />
			<wcf:param name="catalogId" value="${WCParam.catalogId}" />
		</wcf:url>
		
		<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.2//EN" "http://www.openmobilealliance.org/tech/DTD/xhtml-mobile12.dtd">

		<html xmlns="http://www.w3.org/1999/xhtml" lang="${shortLocale}" xml:lang="${shortLocale}">
			<head>
				<title><fmt:message key="MYACCOUNT_TITLE" bundle="${storeText}"/> - <c:out value="${storeName}"/></title>
				<meta name="description" content="<c:out value="${category.description.longDescription}"/>"/>
				<meta name="keyword" content="<c:out value="${category.description.keyWord}"/>"/>
				<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no" />
				<link rel="stylesheet" href="${cssPath}" type="text/css"/>
			</head>	
			<body>
				<div id="wrapper">	
		
					<%@ include file="../../include/HeaderDisplay.jspf" %>
					<%@ include file="../../include/BreadCrumbTrailDisplay.jspf"%>
					<div id="my_account" class="content_box"> 
						<div class="heading_container_with_underline"> 
							<h2><fmt:message key="MYACCOUNT_TITLE" bundle="${storeText}"/></h2> 
							<div class="clear_float"></div> 
						</div> 
						<ul> 
							<li><span class="bullet">&#187; </span><a href="${fn:escapeXml(OrderHistoryURL)}" 
									title="<fmt:message key="MA_MYORDERS" bundle="${storeText}"/>"><fmt:message key="MA_MYORDERS" bundle="${storeText}"/></a></li> 
							<li><span class="bullet">&#187; </span><a href="${fn:escapeXml(PerInfoDispURL)}" title="<fmt:message key="MA_MYPERSONAL_INFORMATION" bundle="${storeText}"/>">
									  <fmt:message key="MA_MYPERSONAL_INFORMATION" bundle="${storeText}"/></a></li> 
							<li><span class="bullet">&#187; </span><a href="${fn:escapeXml(AddressBookURL)}" title="<fmt:message key="MA_MYADDRESS_BOOK" bundle="${storeText}"/>">
									  <fmt:message key="MA_MYADDRESS_BOOK" bundle="${storeText}"/></a></li> 
							<li><span class="bullet">&#187; </span><a href="${fn:escapeXml(WishListDispURL)}" 
									  title="<fmt:message key="MA_MYWISHLIST" bundle="${storeText}"/>"><fmt:message key="MA_MYWISHLIST" bundle="${storeText}"/></a></li> 
							<li><span class="bullet">&#187; </span><a href="${fn:escapeXml(SubscriptionDispURL)}" title="<fmt:message key="MA_MYSUBSCRIPTIONS" bundle="${storeText}"/>">
									  <fmt:message key="MA_MYSUBSCRIPTIONS" bundle="${storeText}"/></a></li> 
						</ul> 
					</div> 
		
		
					<%@ include file="../../include/FooterDisplay.jspf" %>						
				</div>
			</body>
		</html>
	</c:otherwise>
</c:choose>

<!-- END MyAccountDisplay.jsp -->
