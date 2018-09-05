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
  * This JSP snippet displays the Order history page for a particular user
  *****
--%>

<!-- BEGIN OrderHistory.jsp -->

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
			<wcf:param name="URL" value="mOrderHistory"/>
		</wcf:url>

		<%out.flush();%>
		<c:import url="${LoginURL}"/>
		<%out.flush();%>
	</c:when>
	<c:otherwise>
		<%-- Required variables for breadcrumb support --%>
		<c:set var="accountPageGroup" value="true" scope="request" />
		<c:set var="orderHistoryPage" value="true" scope="request" />
		
		<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.2//EN" "http://www.openmobilealliance.org/tech/DTD/xhtml-mobile12.dtd">

		<html xmlns="http://www.w3.org/1999/xhtml" lang="${shortLocale}" xml:lang="${shortLocale}">
			<head>
				<title>
					<fmt:message key="MO_ORDERS" bundle="${storeText}"/> - <c:out value="${storeName}"/>
				</title>
				<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no" />
				<link rel="stylesheet" href="${cssPath}" type="text/css"/>
			</head>	
			<body>
				<div id="wrapper">	
		
					<%@ include file="../../include/HeaderDisplay.jspf" %>
					<%@ include file="../../include/BreadCrumbTrailDisplay.jspf"%>			
					
					<div id="orders" class="content_box"> 
						<div class="heading_container_with_underline"> 
							<h2><fmt:message key="MO_ORDERS" bundle="${storeText}"/></h2> 
							<div class="clear_float"></div> 
						</div> 			
					
						<% out.flush(); %>
						<c:import url="${jspStoreDir}mobile/Snippets/Order/OrderStatusDisplay.jsp" >
								<c:param name= "showScheduledOrders" value="false"/>
								<c:param name= "showOrdersAwaitingApproval" value="false"/>
								<c:param name= "showPONumber" value="false"/>
								<c:param name="maLandingPage" value="false"/>
								<c:param name="allOrders" value="true"/>
						</c:import>
						<% out.flush();%>			
		
					</div>
					<%@ include file="../../include/FooterDisplay.jspf" %>						
				</div>
			</body>
		</html>
		
	</c:otherwise>
</c:choose>

<!--  END OrderHistory.jsp -->
