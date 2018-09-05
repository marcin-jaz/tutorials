<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2009 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>
<%--
  *****
  * This JSP store the selected pickup store ID to the cookie.
  *****
--%>

<!-- BEGIN SaveStoreSelection.jsp -->

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>

<%@ include file="../include/JSTLEnvironmentSetup.jspf" %>

<c:set var="pickUpAtStoreId" value="" />
<c:if test="${!empty WCParam.pickUpAtStoreId}">
	<c:set var="pickUpAtStoreId" value="${WCParam.pickUpAtStoreId}" scope="page" />
</c:if>

<c:if test="${!empty pickUpAtStoreId}">
	<%
		String selectedStore = (String)pageContext.getAttribute("pickUpAtStoreId");
		Cookie cookie = new Cookie ("WC_pickUpStore", selectedStore);
		cookie.setMaxAge(-1);
		response.addCookie(cookie);
	%>
</c:if>

<wcf:url var="refUrl" value="${WCParam.refUrl}">
	<wcf:param name="storeId" value="${WCParam.storeId}" />
	<wcf:param name="langId" value="${WCParam.langId}" />
	<wcf:param name="catalogId" value="${WCParam.catalogId}" />
	<wcf:param name="productId" value="${WCParam.productId}" />
</wcf:url>


<%-- Get the BOPIS shipping mode uniqueId to update all order items with the in-store pickup shipping mode id. --%>

<wcf:getData type="com.ibm.commerce.order.facade.datatypes.OrderType" scope="request" var="order" expressionBuilder="findCurrentShoppingCartWithPagingOnItem" varShowVerb="ShowVerbCart" maxItems="${pageSize}" recordSetStartNumber="0" recordSetReferenceId="ostatus">
	<wcf:param name="accessProfile" value="IBM_Details" />
	<wcf:param name="sortOrderItemBy" value="orderItemID" />
	<wcf:param name="isSummary" value="false" />
</wcf:getData>

<wcf:getData type="com.ibm.commerce.order.facade.datatypes.OrderType" var="usableShippingInfo" expressionBuilder="findUsableShippingInfoWithPagingOnItem" varShowVerb="ShowVerbUsableShippingInfo" maxItems="1" recordSetStartNumber="0" recordSetReferenceId="ostatus">
	<wcf:param name="accessProfile" value="IBM_UsableShippingInfo" /> 
	<wcf:param name="orderId" value="${order.orderIdentifier.uniqueID}" />
	<wcf:param name="sortOrderItemBy" value="orderItemID" />
</wcf:getData>

<c:set var="doneLoop" value="false"/>
<c:forEach items="${usableShippingInfo.orderItem}" var="curOrderItem">
	<c:if test="${not doneLoop}">
		<c:forEach items="${curOrderItem.usableShippingMode}" var="curShipmode">
			<c:if test="${not doneLoop}">
				<c:if test="${curShipmode.shippingModeIdentifier.externalIdentifier.shipModeCode == 'PickupInStore'}">
					<c:set var="doneLoop" value="true"/>
					<c:set var="bopisShipmodeId" value="${curShipmode.shippingModeIdentifier.uniqueID}"/>
				</c:if>
			</c:if>
		</c:forEach>
	</c:if>
</c:forEach>

<wcf:url var="updateItemPhysicalStore" value="OrderChangeServiceItemUpdate">
	<wcf:param name="langId" value="${langId}" />
	<wcf:param name="storeId" value="${WCParam.storeId}" />
	<wcf:param name="catalogId" value="${WCParam.catalogId}" />
	<wcf:param name="orderId" value="." />
	<wcf:param name="URL" value="${WCParam.refUrl}" />

	<c:forEach var="curOrderItem" items="${order.orderItem}" varStatus="counter">
		<wcf:param name="orderItemId_${counter.count}" value="${curOrderItem.orderItemIdentifier.uniqueID}"/>
		<wcf:param name="shipModeId_${counter.count}" value="${bopisShipmodeId}"/>
		<wcf:param name="physicalStoreId_${counter.count}" value="${pickUpAtStoreId}"/>
	</c:forEach>
				
</wcf:url>

<% 
	String refUrl = pageContext.getAttribute("updateItemPhysicalStore").toString();
	response.sendRedirect(refUrl); 
%>

<!-- END SaveStoreSelection.jsp -->
