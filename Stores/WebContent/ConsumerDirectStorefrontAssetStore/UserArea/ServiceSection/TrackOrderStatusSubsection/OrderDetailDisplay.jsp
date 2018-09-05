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
  * This JSP will display the details of a single order. The content consists of:
  *  - A receipt showing the order number, subtotal, total tax, shipping cost, and grand total.
  *  - A print button
  *	 - includes MultiAddressCheckout.jsp to display items that were ordered along with associated order totals
  *****
--%>

<!-- Start - JSP File Name:  OrderSubmitForm.jsp -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf" %>
<%@ include file="../../../include/nocache.jspf" %>

<%-- check to see if Tracking URL flexflow option is turned on.  If it is, display in the details page.--%>
<c:set var="trackingURL" value="false" />
<flow:ifEnabled feature="TrackingURL">
	<c:set var="trackingURL" value="true" />
</flow:ifEnabled>

<wcbase:useBean id="orderBean1" classname="com.ibm.commerce.order.beans.OrderDataBean" scope="page">
	<c:set property="orderId" value="${WCParam.orderId}" target="${orderBean1}" />
</wcbase:useBean>  
<wcbase:useBean id="promoCodeListBean" classname="com.ibm.commerce.marketing.databeans.PromoCodeListDataBean" scope="page">
	<c:set property="orderId" value="${WCParam.orderId}" target="${promoCodeListBean}" />
</wcbase:useBean> 

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
	<title><fmt:message key="TITLE_ORDER_DETAIL" bundle="${storeText}"/></title>
       <link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${vfileStylesheet}"/>" type="text/css"/>
</head>

<body>
<!-- JSP File Name:  OrderDetailDisplay.jsp -->

<%@ include file="../../../include/LayoutContainerTop.jspf"%>

	<!--MAIN CONTENT STARTS HERE-->
	
	<h1><fmt:message key="ORDER_DETAIL" bundle="${storeText}"/></h1>

	<span class="textCustomColor"><fmt:message key="ORDER" bundle="${storeText}"/></span>
	<span class="strongPrice"><c:out value="${orderBean1.orderId}"/></span>							

	<br/><br/>	
	<% out.flush(); %>
	<c:import url="../../../Snippets/Order/Inventory/CurrentAndTotalCharges.jsp" >
		<c:param name="orderId" value="${orderBean1.orderId}"/>
		<c:param name= "showCurrentCharges" value= "true"/>
		<c:param name= "showFutureCharges"  value= "true"/>
		<c:param name= "trackingNumber"  value= "${trackingURL}"/>
	</c:import>
	<% out.flush();%>	
	
	<a href="#" onclick="print();" id="WC_OrderDetailDisplay_Print_Link" class="button">
		<fmt:message key="PRINT" bundle="${storeText}"/>
	</a>

	<%-- Hide CIP --%>
	<c:set var="HideCIP" value="true"/>

	<%@ include file="../../../include/LayoutContainerBottom.jspf"%>

</body>
</html>
