<%
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
%>
<%-- 
  *****
  * This JSP page displays the Order Details page with the following elements:
  *  - Estimated ship date for the order
  *  - List of order items in the order.  For each order item, the following is displayed:
  *			- Quantity, SKU, Description, Manufacturer, Part Number, Ship To, Shipping Provider, Unit Price, Total Price
  *  - Subtotal, Tax, Shipping, Discounts and Total amounts for the order
  *  - Shipping addresses referenced by this order
  *  - Billing Address for this order
  *  This page is display only and contains no links or buttons
  *****
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf"%>

<c:set var="orderStatusCode" value="${WCParam.orderStatusCode}" scope="request" />
<c:set var="orderId" value="${WCParam.orderId}" scope="request" />

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title><fmt:message key="Details_Title" bundle="${storeText}" /></title>
	<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${vfileStylesheet}"/>" type="text/css"/>
</head>

<body class="noMargin">
<%@ include file="../../../include/LayoutContainerTop.jspf"%>

<wcbase:useBean id="dbOrder" classname="com.ibm.commerce.order.beans.OrderDataBean" scope="page">
<c:set target="${dbOrder}" property="orderId" value="${orderId}"/>
</wcbase:useBean>

<c:if test="${empty dbOrder.organizationId || dbOrder.organizationId == CommandContext.activeOrganizationId}">
<!--content start-->

<table cellpadding="8" cellspacing="0" width="100%" class="noBorder" id="WC_OrderDetailDisplay_Table_2">
	<tr>
		<td id="WC_OrderDetailDisplay_TableCell_3">
		<h1><fmt:message key="Details_Title" bundle="${storeText}" /></h1>
		<%--
		***
		* Ship date for order
		***
		--%>
		<c:if test="${!empty orderStatusCode}">
		<span class="c_headings">
			<c:choose>
				<c:when test="${orderStatusCode eq 'S'}">
					<fmt:message key="Details_Actual_Ship_Date" bundle="${storeText}" />
					<c:out value="${dbOrder.formattedActualShipDate}"/>					
				</c:when>
				<c:otherwise>
					<fmt:message key="Details_Text1" bundle="${storeText}" />
					<c:out value="${dbOrder.formattedEstimatedShipDate}"/>
				</c:otherwise>
			</c:choose>
		</span><p></p>
		</c:if>
		
<% out.flush(); %>
<c:import url="../../../Snippets/Order/Inventory/CurrentAndTotalCharges.jsp" >
	<c:param name="orderId" value="${orderId}"/>
</c:import>
<% out.flush();%>

		</td>
	</tr>
</table>
</c:if>
<c:if test="${!empty dbOrder.organizationId && dbOrder.organizationId != CommandContext.activeOrganizationId}">
<fmt:message key="ORDER_NOT_FOR_ACTIVEORG" bundle="${storeText}" />
</c:if>
<!--content end-->
 <%@ include file="../../../include/LayoutContainerBottom.jspf"%>
</body>
</html>
