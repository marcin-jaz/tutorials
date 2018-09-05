<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2007, 2009 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>
<%--
  *****
  * This JSP file displays the detailed information of the order item's shipping address.
  *****
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf"%>

<c:set var="pageSize" value="${WCParam.pageSize}" />
<c:if test="${empty pageSize}">
	<c:set var="pageSize" value="${maxOrderItemsPerPage}"/>
</c:if>

<c:set var="beginIndex" value="${WCParam.beginIndex}" />
 <c:if test="${empty beginIndex}">
	<c:set var="beginIndex" value="0" />
</c:if>

<c:set var="orderShipInfo" value="${requestScope.orderUsableShipping}"/>
<c:if test="${empty orderShipInfo || orderShipInfo==null}">
	<c:choose>
		<c:when test="${empty param.orderId || param.orderId == null}">
			<wcf:getData type="com.ibm.commerce.order.facade.datatypes.OrderType"
			  	 var="orderShipInfo" expressionBuilder="findCurrentShoppingCart">
			   <wcf:param name="accessProfile" value="IBM_UsableShippingInfo" />
			</wcf:getData>
		</c:when>
		<c:otherwise>
			<wcf:getData type="com.ibm.commerce.order.facade.datatypes.OrderType"
			   		var="orderShipInfo" expressionBuilder="findUsableShippingInfoWithPagingOnItem" varShowVerb="ShowVerbUsableShippingInfo" maxItems="${pageSize}" recordSetStartNumber="${beginIndex}" recordSetReferenceId="usistatus" scope="request">
				<wcf:param name="orderId" value="${param.orderId}" />	
				<wcf:param name="accessProfile" value="IBM_UsableShippingInfo" />
			</wcf:getData>	
		</c:otherwise>
	</c:choose>
</c:if>

<jsp:useBean id="shipAddressMap" class="java.util.HashMap" scope="request"/>
<c:set var="displayMethod" value="display:none" />
<div class="shipping_address" id="WC_ShippingAddressDetailsInShort_div_1">
	<!-- If its a non-ajax checkout page, then we should get all the address details during page load and use div show/hide logic -->
	<c:forEach var="shippingOrderItem" items="${orderShipInfo.orderItem}">
	<c:set var="orderShipInfo" value="${shippingOrderItem}"/>
	<c:forEach var="contactInfoIdentifier" items="${orderShipInfo.usableShippingAddress}">
		<c:if test="${empty shipAddressMap[contactInfoIdentifier.uniqueID]}">
		<c:set target="${shipAddressMap}" property="${contactInfoIdentifier.uniqueID}" value="true"/>
		<div id="addressDetails_<c:out value="${contactInfoIdentifier.uniqueID}"/>" style="<c:out value="${displayMethod}"/>">
			<c:import url="${jspStoreDir}Snippets/Member/Address/AddressDisplay.jsp">
				<c:param name="addressId" value= "${contactInfoIdentifier.uniqueID}"/>
			</c:import>
		</div>
		</c:if>
	</c:forEach>
	</c:forEach>
	<!-- One empty div for the option "Please Select" -->
	<div id="addressDetails_-1" style="display:block">
	</div>
</div>


