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
  * This JSP fetches and displays the order details.
  *****
--%>

<!-- BEGIN OrderDetailDisplay.jsp -->

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>    

<%@ include file="../../../include/parameters.jspf" %>
<%@ include file="../../include/JSTLEnvironmentSetup.jspf" %>

<wcf:getData type="com.ibm.commerce.order.facade.datatypes.OrderType" var="order" expressionBuilder="findByOrderId">
       <wcf:param name="accessProfile" value="IBM_Details" />
       <wcf:param name="orderId" value="${WCParam.orderId}" />
</wcf:getData>

<%-- Need to reset currencyFormatterDB as initialized in JSTLEnvironmentSetup.jspf, as the currency code used there is from commandContext. For order history we want to display with currency used when the order was placed. --%>
<c:remove var="currencyFormatterDB"/>
<wcbase:useBean id="currencyFormatterDB" classname="com.ibm.commerce.common.beans.CurrencyFormatDescriptionDataBean" scope="request" >
	<c:set property="dataBeanKeyNumberUsgId" value="-1" target="${currencyFormatterDB}" />
	<c:set property="dataBeanKeyCurrencyCode" value="${order.orderAmount.grandTotal.currency}" target="${currencyFormatterDB}" />
	<c:set property="dataBeanKeyStoreEntityId" value="-1" target="${currencyFormatterDB}" />
	<c:set property="dataBeanKeyLanguageId" value="${langId}" target="${currencyFormatterDB}" />
</wcbase:useBean>	
<c:choose>
	<c:when test="${order.orderAmount.grandTotal.currency == 'JPY' || order.orderAmount.grandTotal.currency == 'KRW'}">
		<c:set var="currencyDecimal" value="0"/>
	</c:when>
	<c:otherwise>
		<c:set var="currencyDecimal" value="2"/>
	</c:otherwise>
</c:choose>

<wcf:getData type="com.ibm.commerce.member.facade.datatypes.PersonType" 
		var="person" expressionBuilder="findCurrentPerson">
	<wcf:param name="accessProfile" value="IBM_All" />
</wcf:getData>

<c:set var="personAddresses" value="${person.addressBook}"/>

<c:catch>
	<fmt:parseDate var="expectedDate" value="${order.placedDate}" pattern="yyyy-MM-dd'T'HH:mm:ss.SSS'Z'" timeZone="GMT"/>
</c:catch>
<c:if test="${empty expectedDate}">
	<c:catch>
		<fmt:parseDate var="expectedDate" value="${order.placedDate}" pattern="yyyy-MM-dd'T'HH:mm:ss'Z'" timeZone="GMT"/>
	</c:catch>
</c:if>

<div id="order_details" class="content_box"> 
	<div class="heading_container_with_underline"> 
		<h2><fmt:message key="MO_ORDERDETAILS" bundle="${storeText}"/></h2> 
		<div class="clear_float"></div> 
	</div> 			
	<ul>
		<li><span class="bold">Order Number:</span> ${order.orderIdentifier.uniqueID}</li>
		<li><span class="bold">Order Date:</span> <fmt:formatDate value="${expectedDate}"/></li>
	</ul>			
</div>

<div id="order_details_sub_container">
	<div id="items_container" class="child_content_box">
		<div class="child_heading_container">
			<h3>Items</h3>
			<div class="clear_float"></div>
		</div>
					
		<div id="items_content" class="content_box">
			<%@ include file="OrderItemDetailsWithOrderTotal.jspf" %>
		</div>
	</div>
				
	<div id="shipping_information_container" class="child_content_box">
		<div class="child_heading_container">
			<h3>Shipping Information</h3>
			<div class="clear_float"></div>
		</div>
					
		<div id="shipping_information_content" class="content_box">
			<%@ include file="OrderShippmentDetails.jspf" %>
		</div>
	</div>
				
	
	<div id="billing_information_container" class="child_content_box">
		<div class="child_heading_container">
			<h3>Billing Information</h3>
			<div class="clear_float"></div>
		</div>
					
		<div id="billing_information_content" class="content_box">
			<%@ include file="OrderBillingDetails.jspf" %>			
	
			<%@ include file="OrderQuickNavigation.jspf" %>
		
			<wcf:url var="OrderHistoryURL" value="mOrderHistory">
				<wcf:param name="storeId" value="${WCParam.storeId}" />
			  	<wcf:param name="catalogId" value="${WCParam.catalogId}" />
			  	<wcf:param name="langId" value="${langId}" />
			</wcf:url>
			<span class="bullet">&#187; </span><a href="${fn:escapeXml(OrderHistoryURL)}" title="Return to Orders List">Return to Orders List</a>
		</div>
	</div>
</div>


<!-- END OrderDetailDisplay.jsp -->
