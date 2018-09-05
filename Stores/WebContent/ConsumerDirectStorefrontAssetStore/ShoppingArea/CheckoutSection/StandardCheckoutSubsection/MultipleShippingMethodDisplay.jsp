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
  * This page allows the user to choose a shipping method for each item in the order.
  * It is present during check out if the Accelerator "Change Flow" option "Multiple Shipping Methods" is enabled.
  * The main content includes:
  * - For each order item:  quantity, clickable item description, and 'Shipping method' dropdown selection.
  *****
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>

<%@ include file="../../../include/JSTLEnvironmentSetup.jspf"%>
<%@ include file="../../../include/nocache.jspf" %>
		
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
	<title><fmt:message bundle="${storeText}" key="SHIPPING_TITLE" /></title>
	<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}"/><c:out value="${vfileStylesheet}"/>" type="text/css"/>

</head>

	<body>
	<!-- JSP File Name:  MultipleShippingMethodDisplay.jsp -->

	<%@ include file="../../../include/LayoutContainerTop.jspf"%>
	
		<!--MAIN CONTENT STARTS HERE-->
		<table cellpadding="0" cellspacing="0" border="0" width="100%" id="WC_MultipleShippingMethodDisplay_Table_1">
		<tbody>
		<tr>
			<td colspan="3" id="WC_MultipleShippingMethodDisplay_TableCell_1">
				<c:set var="bctCurrentPage" value="ShippingMethod" />
	            		<%@ include file="../../../Snippets/Order/Cart/BreadCrumbTrailDisplay.jspf" %>
			</td>
		</tr>
		<tr>
			<td valign="top" colspan="3" class="categoryspace" id="WC_MultipleShippingMethodDisplay_TableCell_2">
				<table cellpadding="0" cellspacing="0" border="0" width="100%" id="WC_MultipleShippingMethodDisplay_Table_4">
				<tbody><tr>
					<td valign="top" id="WC_MultipleShippingMethodDisplay_TableCell_3" class="heading">
						<fmt:message bundle="${storeText}" key="CHOOSE_SHIP_METHOD" />
					</td>
				</tr>
				</tbody></table>
			</td>
		</tr>
		<tr>
			<td id="WC_MultipleShippingMethodDisplay_TableCell_4" >

				<c:set var="allowOnlySingleShippingMethod" value="false"/>
				<flow:ifEnabled feature="SingleShippingMethodPage.i1.impl.f">
					<c:set var="allowOnlySingleShippingMethod" value="true"/>
				</flow:ifEnabled>
				<flow:ifEnabled feature="ShippingInstructions">
					<c:set var="showInstructions" value="true"/>
				</flow:ifEnabled>
				<flow:ifEnabled feature="FutureOrders">
					<c:set var="showRequestedShipdate" value="true"/>
				</flow:ifEnabled>

				<% out.flush(); %>
				<c:import url="../../../Snippets/Order/Cart/AdvancedOrderForm.jsp">
					<c:param name="orderId" value="${WCParam.orderId}"/>
					<c:param name="showInstructions" value="${showInstructions}"/>
					<c:param name="showRequestedShipdate" value="${showRequestedShipdate}"/>
					<c:param name="shippingInstructionsView" value="ShippingInstructionsView"/>
					<c:param name="allowOnlySingleShippingMethod" value="${allowOnlySingleShippingMethod}"/>
					<c:param name="errorView" value="MultipleShippingMethodView"/>
				</c:import>
				<% out.flush(); %>
			</td>
		</tr>
		</tbody>	
		</table>

<c:set var="ShippingAddressFlowURL" value="${WCParam.ShippingURL}" />  
<c:url var="ShippingAddressURL" value="${ShippingAddressFlowURL}">
	<c:param name="storeId" value="${WCParam.storeId}" />
	<c:param name="catalogId" value="${WCParam.catalogId}" />
	<c:param name="orderId" value="${WCParam.orderId}" />
</c:url>


<p>
<a href="<c:out value="${ShippingAddressURL}"/>" class="button" id="WC_CurrentOrderDisplay_Link_7_1"><fmt:message key="Shipping_PREVIOUS" bundle="${storeText}"/></a>
<a href="javascript:order_SubmitCart(document.AdvancedCartForm)" class="button" id="WC_CurrentOrderDisplay_Link_7_2"><fmt:message key="Shipping_NEXT" bundle="${storeText}"/></a>
</p>

		<!--MAIN CONTENT ENDS HERE-->
		
	<%-- Hide CIP --%>
	<c:set var="HideCIP" value="true"/>

	<%@ include file="../../../include/LayoutContainerBottom.jspf"%>

	</body>
</html>
