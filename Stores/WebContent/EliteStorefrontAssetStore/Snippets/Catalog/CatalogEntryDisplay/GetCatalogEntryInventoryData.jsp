<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2008 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>
<%-- 
  ***
  * This jsp populates the data required by the physical store inventory section of the product display page.
  * It creates a JSON object which is returned to the client from the AJAX call.
  ***
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf"%>

<c:set var="cookieVal" value="${cookie.WC_physicalStores.value}" />
<c:set var="cookieVal" value="${fn:replace(cookieVal, '%2C', ',')}"/>

<c:if test="${!empty cookieVal}">
	<wcf:getData type="com.ibm.commerce.store.facade.datatypes.PhysicalStoreType[]"
		     var="physicalStores" varException="physicalStoreException" expressionBuilder="findPhysicalStoresByUniqueIDs">
		<wcf:param name="accessProfile" value="IBM_Store_Details" />
		<c:forTokens items="${cookieVal}" delims="," var="phyStoreId">
			<wcf:param name="uniqueId" value="${phyStoreId}" />	
		</c:forTokens>
	</wcf:getData>
</c:if>

<wcf:getData type="com.ibm.commerce.inventory.facade.datatypes.InventoryAvailabilityType[]"
		     var="itemInventory" expressionBuilder="findInventoryAvailabilityByCatalogEntryIdsAndOnlineStoreIdsAndPhysicalStoreIds">
	<wcf:param name="accessProfile" value="IBM_Store_Details" />
	<wcf:param name="catalogEntryId" value="${param.itemId}" />
	<wcf:param name="onlineStoreId" value="${WCParam.storeId}" />
	<c:forTokens items="${cookieVal}" delims="," var="phyStoreId">
		<wcf:param name="physicalStoreId" value="${phyStoreId}" />
	</c:forTokens>
</wcf:getData>

<%-- Determine the online inventory first --%>
<c:forEach var="invRec" items="${itemInventory}" varStatus="counter">
	<c:if test="${!empty invRec.inventoryAvailabilityIdentifier.externalIdentifier.onlineStoreIdentifier}">
		<c:set var="onlineInventoryStatus" value="${invRec.inventoryStatus}"/>
	</c:if>
</c:forEach>

/*
{
"physicalStores": <wcf:json object="${physicalStores}"/>,
"onlineInventory": <wcf:json object="${onlineInventoryStatus}"/>,
"storeInventory": [
	<c:forEach var="invRec" items="${itemInventory}" varStatus="counter">
		<c:if test="${!empty invRec.inventoryAvailabilityIdentifier.externalIdentifier.physicalStoreIdentifier}">
			<c:choose>
				<c:when test="${! empty(invRec.availabilityDateTime)}">
					<c:catch>
						<fmt:parseDate var="date" value="${invRec.availabilityDateTime}" pattern="yyyy-MM-dd'T'HH:mm:ss.SSS'Z'" timeZone="GMT" dateStyle="long"/>
					</c:catch>
					<c:if test="${empty date}">
						<c:catch>
							<fmt:parseDate var="date" value="${invRec.availabilityDateTime}" pattern="yyyy-MM-dd'T'HH:mm:ss'Z'" timeZone="GMT" dateStyle="long"/>
						</c:catch>
					</c:if>
					<fmt:formatDate var="availDate" value="${date}"/>
				</c:when>
				<c:otherwise>
					<c:set var="availDate" value="null"/>
				</c:otherwise>
			</c:choose>
			{
				"store": "<c:out value="${invRec.inventoryAvailabilityIdentifier.externalIdentifier.physicalStoreIdentifier.uniqueID}"/>",
				"inventoryStatus": <wcf:json object="${invRec.inventoryStatus}"/>,
				"availableQuantity": <wcf:json object="${invRec.availableQuantity}"/>,
				"availabilityDateTime": "<c:out value="${availDate}"/>"
			}
			<c:choose>
				<c:when test="${counter.last}"></c:when>
				<c:otherwise>,</c:otherwise>
			</c:choose>
		</c:if>
	</c:forEach>
]
}
*/
