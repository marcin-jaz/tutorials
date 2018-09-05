<%--
/*
 *-------------------------------------------------------------------
 * Licensed Materials - Property of IBM
 *
 * WebSphere Commerce
 *
 * (c) Copyright International Business Machines Corporation. 2001-2004
 *     All rights reserved.
 *
 * US Government Users Restricted Rights - Use, duplication or
 * disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
 *
 *-------------------------------------------------------------------
 */
--%>
<%-- 
  *****
  * This JSP page displays the Order Status page with the following elements:
  *  - List of Orders waiting for approval.  For each order on the list, the following is displayed
  *			- Order Number, Last Updated, Purchase Order, Total Price
  *  - List of Orders already processed.  For each order on the list, the following is displayed
  *			- Order Number, Order Date, Purchase Order, Status, Total Price and a Re-Order link
  *  - List of Orders Scheduled.  For each scheduled order, the following is displayed
  * 		- Order Number, Purchase Order, Total Price, Frequency, Start Date and Order Cancel link
  *  - In each list, 'Order Number' is a link to the Order Details page for that order
  *****
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>	
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf"%>
<%@ include file="../../../include/ErrorMessageSetup.jspf"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml"><head>
	<title><fmt:message key="Status_Title" bundle="${storeText}" /></title>
	<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${vfileStylesheet}"/>" type="text/css"/>
</head>

<body class="noMargin">
<flow:ifEnabled feature="customerCare">
<%--
Set header type needed for this JSP for LiveHelp.  This must be set before HeaderDisplay.jsp
--%>
<c:set var="liveHelpPageType" value="personal" scope="request" />
</flow:ifEnabled>

<%@ include file="../../../include/LayoutContainerTop.jspf"%>  
	<!--content start-->
	<%-- Page specific error messages --%>	
	<c:choose>
	<c:when test="${'_ERR_INVALID_TRADING' eq storeError.key}">
		<fmt:message key="_ERR_INVALID_TRADING_REORDER" var="pageErrorMessage" bundle="${storeErrorMessageBundle}"/>			
	</c:when>
	<c:otherwise>
		<c:set var="pageErrorMessage" value="${errorMessage}"/>
	</c:otherwise>
	</c:choose>
	<c:if test="${!empty errorMessage}">
		<span class="warning"><c:out value="${pageErrorMessage}"/></span>
	</c:if>
 
  <h1><fmt:message key="Status_Title" bundle="${storeText}" /></h1>
    		
<flow:ifEnabled feature="ScheduleOrder">
	<c:set var="showScheduledOrders" value="true"/>
</flow:ifEnabled>

	<% out.flush(); %>
	<c:import url="../../../Snippets/Order/Cart/OrderStatusTableDisplay.jsp" >
		<c:param name= "showScheduledOrders" value="${showScheduledOrders}"/>
		<c:param name= "showOrdersAwaitingApproval" value="true"/>
		<c:param name= "showPONumber" value="true"/>
	</c:import>
	<% out.flush();%>

	<!--content end-->

<%@ include file="../../../include/LayoutContainerBottom.jspf"%>
</body>

</html>

