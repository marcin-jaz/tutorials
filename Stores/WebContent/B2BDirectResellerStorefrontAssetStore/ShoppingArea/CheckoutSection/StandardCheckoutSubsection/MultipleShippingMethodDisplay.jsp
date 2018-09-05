<%
/*
 *-------------------------------------------------------------------
 * Licensed Materials - Property of IBM
 *
 * WebSphere Commerce
 *
 * (c) Copyright International Business Machines Corporation. 2001, 2004
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
  * This JSP page displays the shipping information. One can select from a list of 
  * shipping methods to use. One can also select shipping options for each order item
  * including the option to select a requested ship date and the option to expedite.
  *  - an checkbox is available if one wants to add/edit shipping instructions.
  *****
--%>
<% // All JSPs requires the first 4 packages for getResource.jsp which is used for multi language support %>
<% // All JSPs requires these packages for EnvironmentSetup.jsp which is used for multi language support %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
 
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<!-- BEGIN MultipleShippingMethodDisplay.jsp -->
<head>
<title><fmt:message key="ShippingMethod_Title" bundle="${storeText}"/></title>
<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${vfileStylesheet}"/>" type="text/css"/>
</head>
<body class="noMargin">

<%@ include file="../../../include/LayoutContainerTop.jspf"%>
 
<table cellpadding="0" cellspacing="0" border="0" class="p_width" id="WC_MultipleShippingMethodDisplay_Table_1">
<tr>
<td id="WC_MultipleShippingMethodDisplay_TableCell_1">

<%-- bread crumb trail snippet --%>
<c:set var="bctCurrentPage" value="ShippingMethod" />
<c:set var="storeText" value="${storeText}" />

<%@ include file="../../../Snippets/Order/Cart/BreadCrumbTrailDisplay.jspf"%>

<h1><fmt:message key="ShippingMethod_Title" bundle="${storeText}"/></h1>

<flow:ifEnabled feature="ShippingInstructions">
	<c:set var="showInstructions" value="true"/>
</flow:ifEnabled>
<flow:ifEnabled feature="ExpeditedOrders">
	<c:set var="showExpedite" value="true"/>
</flow:ifEnabled>
<flow:ifEnabled feature="FutureOrders">
	<c:set var="showRequestedShipdate" value="true"/>
</flow:ifEnabled>
  
<% out.flush(); %>
<c:import url="../../../Snippets/Order/Cart/AdvancedOrderForm.jsp">
	<c:param name="orderId" value="${WCParam.orderId}"/>
	<c:param name="shippingInstructionsView" value="ShippingInstructionsView"/>
	<c:param name="billingDetailsView" value="BillingDetailsView"/>
	<c:param name="shippingURL" value="${WCParam.ShippingURL}"/>
	<c:param name="showInstructions" value="${showInstructions}"/>
	<c:param name="showExpedite" value="${showExpedite}"/>
	<c:param name="showRequestedShipdate" value="${showRequestedShipdate}"/>
	<c:param name="errorView" value="MultipleShippingMethodView"/>	
</c:import> 
<% out.flush(); %>

<c:url var="ShippingURL" value="${WCParam.ShippingURL}">
	<c:param name="orderId" value="${WCParam.orderId}"/>
	<c:param name="langId" value="${langId}" />
	<c:param name="storeId" value="${storeId}" />
	<c:param name="catalogId" value="${catalogId}" />
</c:url>

<p>
<a href="<c:out value="${ShippingURL}"/>" class="button" id="WC_MultipleShippingMethodDisplay_Link_1"><fmt:message key="Ship_Previous" bundle="${storeText}"/></a>
<a href="javascript:order_SubmitCart(document.AdvancedCartForm)" class="button" id="WC_MultipleShippingMethodDisplay_Link_2"><fmt:message key="Ship_Next" bundle="${storeText}"/></a></p>
</p>

</td>
</tr>
</table>

<%-- Hide CIP --%>
<c:set var="HideCIP" value="true"/>

<%@ include file="../../../include/LayoutContainerBottom.jspf"%>

</body>
<!-- END MultipleShippingMethodDisplay.jsp -->
</html>
