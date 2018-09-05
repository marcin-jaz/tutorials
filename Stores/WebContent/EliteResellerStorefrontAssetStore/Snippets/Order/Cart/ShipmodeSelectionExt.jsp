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
	* If StoreLocator feature is enabled, this file presents 2 shipping options in the shopping cart page - 
	* Shop online or Pick up in store.
	****
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<wcf:url var="StoreLocatorURL" value="CheckoutStoreSelectionView" type="Ajax">
  <wcf:param name="langId" value="${langId}" />						
  <wcf:param name="storeId" value="${WCParam.storeId}" />
  <wcf:param name="catalogId" value="${WCParam.catalogId}" />
  <wcf:param name="fromPage" value="ShoppingCart" />
</wcf:url>

<flow:ifEnabled feature="StoreLocator">		
	<c:set var="order" value="${requestScope.orderInCart}"/>
	<c:if test="${empty order || order == null}">
		<!-- Get order Details using the ORDER SOI -->
		<wcf:getData type="com.ibm.commerce.order.facade.datatypes.OrderType"
			var="order" expressionBuilder="findCurrentShoppingCartWithPagingOnItem" varShowVerb="ShowVerbCart" maxItems="${maxOrderItemsToInspect}" recordSetStartNumber="0" recordSetReferenceId="ostatus">
			<wcf:param name="accessProfile" value="IBM_Details" />	 
			<wcf:param name="sortOrderItemBy" value="orderItemID" />
			<wcf:param name="isSummary" value="false" />
		</wcf:getData>
	</c:if>
	
	<wcf:getData type="com.ibm.commerce.order.facade.datatypes.OrderType"
		var="currentOrder" expressionBuilder="findUsableShippingInfoWithPagingOnItem" varShowVerb="ShowVerbUsableShippingInfo" maxItems="1" recordSetStartNumber="0" recordSetReferenceId="ostatus">
		<wcf:param name="accessProfile" value="IBM_UsableShippingInfo" /> 
		<wcf:param name="orderId" value="${order.orderIdentifier.uniqueID}" />
		<wcf:param name="sortOrderItemBy" value="orderItemID" />
	</wcf:getData>
	
	<%-- only present selection when there is at least one order item --%>
	<c:if test="${fn:length(order.orderItem) > 0}">
		<form id="shipmodeForm">
			<c:set var="doneLoop" value="false"/>
			<c:forEach items="${currentOrder.orderItem[0].usableShippingMode}" var="curShipmode">
				<c:if test="${not doneLoop}">
					<c:if test="${curShipmode.shippingModeIdentifier.externalIdentifier.shipModeCode == 'PickupInStore'}">
						<input type="hidden" id="BOPIS_shipmode_id" name="BOPIS_shipmode_id" value="${curShipmode.shippingModeIdentifier.uniqueID}"/>
						<c:set var="pickUpInStoreShipModeId" value="${curShipmode.shippingModeIdentifier.uniqueID}"/>
						<c:set var="doneLoop" value="true"/>
					</c:if>
				</c:if>
			</c:forEach>
			<c:set var="doneLoop" value="false"/>
			<c:set var="pickUpInStoreChecked" value="false"/>
			<c:forEach items="${order.orderItem}" var="curOrderItem">
				<c:if test="${not doneLoop}">
					<c:if test="${curOrderItem.orderItemShippingInfo.shippingMode.shippingModeIdentifier.uniqueID eq pickUpInStoreShipModeId}">
						<c:set var="pickUpInStoreChecked" value="true"/>
						<c:set var="doneLoop" value="true"/>
					</c:if>
				</c:if>
			</c:forEach>
		</form>
		
		<wcf:getData type="com.ibm.commerce.catalog.facade.datatypes.CatalogEntryType[]" var="catalogEntriesAttributes" expressionBuilder="getStoreCatalogEntryAttributesByIDs">
			<wcf:contextData name="storeId" data="${WCParam.storeId}"/>
				<c:forEach var="orderItem" items="${order.orderItem}">
					<wcf:param name="UniqueID" value="${orderItem.catalogEntryIdentifier.uniqueID}"/>
				</c:forEach>
			<wcf:param name="dataLanguageIds" value="${WCParam.langId}"/>
		</wcf:getData>

		<%-- need to disable pick up in store option if there are products in the shopping cart that do not support 'PickupInStore' --%>
		<c:set var="doneLoop" value="false"/>
		<c:set var="pickUpInStoreDisabled" value="false"/>
		<c:forEach items="${order.orderItem}" var="curOrderItem">
			<c:if test="${not doneLoop}">
				<c:forEach var="catalogEntry1" items="${catalogEntriesAttributes}">
					<c:if test="${catalogEntry1.catalogEntryIdentifier.uniqueID == curOrderItem.catalogEntryIdentifier.uniqueID}">
						<c:forEach var="attribute" items="${catalogEntry1.catalogEntryAttributes.attributes}">
							<c:if test="${ attribute.usage=='Descriptive' && attribute.name == 'PickupInStore' && attribute.value.value == 'false' }" >	
								<c:set var="pickUpInStoreDisabled" value="true"/>
								<c:set var="doneLoop" value="true"/>
							</c:if>
						</c:forEach>
					</c:if>
				</c:forEach>
				<c:remove var="catalogEntryAttributes"/>
			</c:if>
		</c:forEach>
		
		<%-- section to display 2 radio buttons for shipping option selection (shop online and pick up at store) --%>
		<div id="purchase_options">
			<form name="BOPIS_FORM" id="BOPIS_FORM">
			<c:choose>
				<c:when test="${pickUpInStoreChecked}">
					<input name="shipType" id="shipTypeOnline" class="radio" type="radio" value="shopOnline"/>
				</c:when>
				<c:otherwise>
					<input name="shipType" id="shipTypeOnline" class="radio" type="radio" value="shopOnline" checked="checked"/>
				</c:otherwise>
			</c:choose>
			<label for="shipTypeOnline"><img src="${jspStoreImgDir}images/shopping-cart-shop-online.png" alt="" border="0"/><fmt:message key="BOPIS_SHIPMODE_ONLINE" bundle="${storeText}"/></label>	
			
			<c:choose>
				<c:when test="${pickUpInStoreDisabled}">
					<input name="shipType" id="shipTypePickUp" class="radio" type="radio" value="pickUp" disabled="disabled"/>
				</c:when>
				<c:when test="${pickUpInStoreChecked}">
					<input name="shipType" id="shipTypePickUp" class="radio" type="radio" value="pickUp" checked="checked"/>
				</c:when>
				<c:otherwise>
					<input name="shipType" id="shipTypePickUp" class="radio" type="radio" value="pickUp"/>
				</c:otherwise>
			</c:choose>
			<label for="shipTypePickUp"><img src="${jspStoreImgDir}images/shopping-cart-pickup-at-store.png" alt="" border="0"/><fmt:message key="BOPIS_SHIPMODE_STORE" bundle="${storeText}"/></label>
			</form>
		</div>
	</c:if>
</flow:ifEnabled>	
