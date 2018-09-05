<%
//********************************************************************
//*-------------------------------------------------------------------
//* Licensed Materials - Property of IBM
//*
//* WebSphere Commerce
//*
//* (c) Copyright IBM Corp. 2000, 2002, 2004
//*
//* US Government Users Restricted Rights - Use, duplication or
//* disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
//*
//*-------------------------------------------------------------------
//*
%>

<%--
  *****
  * This JSP will display a list of the orders that the shopper has completed to date. The content is a table with 3-4 columns.
  *  - Order number with clickable link to take you to OrderDetailsDisplay.jsp
  *  - Order date
  *  - If the 'Track Order Status' feature in Commerce Accelerator is enabled for the store (Change Flow option in 'Store' menu), Order Status is shown
  *  - Order total amount
  *****
--%>
<% // All JSPs requires these packages for EnvironmentSetup.jspf which is used for multi language support %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf"%>
<%@ include file="../../../include/nocache.jspf" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
	<title><fmt:message key="ORDERSTATUS_TITLE" bundle="${storeText}" /></title>
	<link rel="stylesheet" href="<c:out value='${jspStoreImgDir}${vfileStylesheet}'/>" type="text/css"/>
</head>

<body>
<!-- JSP File Name:  OrderStatusDisplay.jsp -->

<%@ include file="../../../include/LayoutContainerTop.jspf"%>

	<!--MAIN CONTENT STARTS HERE-->

	<h1><fmt:message key="ORDERSTATUS_TITLE" bundle="${storeText}"/></h1>

	<% out.flush(); %>
	<c:import url="../../../Snippets/Order/Cart/OrderStatusTableDisplay.jsp" >
		<c:param name= "showScheduledOrders" value="false"/>
		<c:param name= "showOrdersAwaitingApproval" value="false"/>
		<c:param name= "showPONumber" value="false"/>
	</c:import>
	<% out.flush();%>

	<%-- Hide CIP --%>
	<c:set var="HideCIP" value="true"/>
	<table><tr><td>
	<%@ include file="../../../include/LayoutContainerBottom.jspf"%>

</body>
</html>
