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
  * This JSP file is used as a helper during the online checkout flow to ensure of the following:
  * 1) All order items have an address
  * 2) All order items have shipping method which is not the "PickUpInStore" shipping mode.
  *****
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../include/JSTLEnvironmentSetup.jspf"%>
<%@ include file="../../include/nocache.jspf"%>

<c:choose>
       <c:when test="${!empty param.shipModeId}">
       		<script type="text/javascript">
						dojo.addOnLoad(function() {
							SBServicesDeclarationJS.setCommonParameters('<c:out value='${langId}'/>','<c:out value='${storeId}'/>','<c:out value='${catalogId}'/>');
							CheckoutHelperJS.setCommonParameters('<c:out value="${langId}"/>','<c:out value="${storeId}"/>','<c:out value="${catalogId}"/>');
							CheckoutHelperJS.updateShipModeIdForOrder('<c:out value="${param.shipModeId}"/>');
						});
					</script>
       </c:when>
       <c:otherwise>
					<c:set var="validAddressId" value=""/>
					
					<c:if test="${!empty order.orderItem}" >
						<!-- Get the list of orderItems which have null addressId...-->
						<c:forEach var="orderItem" items="${order.orderItem}" varStatus="status">
							<c:set var ="addressId" value = "${orderItem.orderItemShippingInfo.shippingAddress.contactInfoIdentifier.uniqueID}"/>
							<!-- if an item has a valid address, then save it in some variable.. we will assign this 
							valid addressId to all other items which have null addressId -->
							<c:if test="${empty validAddressId}">
								<c:set var="validAddressId" value="${addressId}"/>
							</c:if>
						</c:forEach>
					
						<!-- if validAddressId is still null, then it means none of the orderItems in the order have valid address.. so get one valid addressId for this user..Before coming to this page, the user should have atleast one valid addressId..otherwise this logic doesnt work -->
						<c:if test = "${empty validAddressId}">
							
							<wcf:getData type="com.ibm.commerce.order.facade.datatypes.OrderType"
							   var="orderUsableShipping" expressionBuilder="findCurrentShoppingCart">
							   <wcf:param name="accessProfile" value="IBM_UsableShippingInfo" />
							</wcf:getData>
				
							<c:forEach var="usableAddress" items="${orderUsableShipping.usableShippingAddress}">
								<c:if test="${usableAddress.externalIdentifier.contactInfoNickName != profileShippingNickname && usableAddress.externalIdentifier.contactInfoNickName != profileBillingNickname && empty validAddressId}" > 
									<c:set var="validAddressId" value="${usableAddress.uniqueID}"/>
								</c:if>
							</c:forEach>
						</c:if>
						 
						<%-- set invalid address Id == true, since some items have null addressId --%>
						<c:set var="invalidAddressId" value="true"/>
					</c:if>
					<script type="text/javascript">
						dojo.addOnLoad(function() {
							SBServicesDeclarationJS.setCommonParameters('<c:out value='${langId}'/>','<c:out value='${storeId}'/>','<c:out value='${catalogId}'/>');
							CheckoutHelperJS.setCommonParameters('<c:out value="${langId}"/>','<c:out value="${storeId}"/>','<c:out value="${catalogId}"/>');
							CheckoutHelperJS.updateAddressIdForOrderItem('<c:out value="${validAddressId}"/>');
						});
					</script>
       </c:otherwise>
</c:choose>
