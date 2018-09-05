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
  * This JSP displays the item availability on the product compare page.
  *****
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>

<%@ taglib uri="flow.tld" prefix="flow" %>

<!-- BEGIN ItemAvailForProdCompare.jsp -->

<%@ include file="../../../include/JSTLEnvironmentSetup.jspf" %>

<c:set var="itemId" value="${param.itemId}" />
<c:set var="productId" value="${param.productId}" />

<c:if test="${!empty cookie.WC_physicalStores.value}">
	<c:set var="physicalStoreIds" value="${fn:split(fn:replace(cookie.WC_physicalStores.value, '%2C', ','), ',')}" />
</c:if>

<c:if test="${!empty physicalStoreIds}">
	<wcf:getData var="physicalStores"
			type="com.ibm.commerce.store.facade.datatypes.PhysicalStoreType[]"
			expressionBuilder="findPhysicalStoresByUniqueIDs">
		<wcf:param name="accessProfile" value="IBM_Store_Details" />
		<c:forEach var="thisPhysicalStoreId" items="${physicalStoreIds}">
			<wcf:param name="uniqueId" value="${thisPhysicalStoreId}" />
		</c:forEach>
	</wcf:getData>
</c:if>

<wcf:getData var="inventoryAvailabilities"
		type="com.ibm.commerce.inventory.facade.datatypes.InventoryAvailabilityType[]"
		expressionBuilder="findInventoryAvailabilityByCatalogEntryIdsAndOnlineStoreIdsAndPhysicalStoreIds">
	<wcf:param name="accessProfile" value="IBM_Store_Details" />
	<wcf:param name="catalogEntryId" value="${itemId}" />
	<wcf:param name="onlineStoreId" value="${storeId}" />
	<c:forEach var="thisPhysicalStore" items="${physicalStores}">
		<wcf:param name="physicalStoreId" value="${thisPhysicalStore.physicalStoreIdentifier.uniqueID}" />
	</c:forEach>
</wcf:getData>

<div id="check_availability" class="text_container">

	<p class="bold"><fmt:message key="PRODUCT_INV_ONLINE" bundle="${storeText}" /></p>

	<c:remove var="inventoryAvailability" />
	<c:forEach var="thisInventoryAvailability" items="${inventoryAvailabilities}">
		<c:if test="${thisInventoryAvailability.inventoryAvailabilityIdentifier.externalIdentifier.onlineStoreIdentifier.uniqueID == storeId}">
			<c:set var="inventoryAvailability" value="${thisInventoryAvailability}" />
		</c:if>
	</c:forEach>
	<c:set var="inventoryStatus" value="${empty inventoryAvailability ? 'Unavailable' : inventoryAvailability.inventoryStatus}" />
	<fmt:message var="inventoryStatusMessage" key="INV_STATUS_${inventoryStatus}" bundle="${storeText}" />
	<p class="status"><img src="${fn:escapeXml(jspStoreImgDir)}mobile/images/${inventoryStatus}.gif" width="12" height="12" alt="${inventoryStatusMessage}" /> ${inventoryStatusMessage}</p>

	<c:if test="${!empty physicalStores}">
	
		<p class="bold"><fmt:message key="PRODUCT_INV_STORE" bundle="${storeText}" /></p>
	
		<c:forEach var="thisPhysicalStoreId" items="${physicalStoreIds}" varStatus="status">
			<c:remove var="physicalStore" />
			<c:remove var="inventoryAvailability" />
			<c:forEach var="thisPhysicalStore" items="${physicalStores}">
				<c:if test="${thisPhysicalStore.physicalStoreIdentifier.uniqueID == thisPhysicalStoreId}">
					<c:set var="physicalStore" value="${thisPhysicalStore}" />
				</c:if>
			</c:forEach>
			<c:forEach var="thisInventoryAvailability" items="${inventoryAvailabilities}">
				<c:if test="${thisInventoryAvailability.inventoryAvailabilityIdentifier.externalIdentifier.physicalStoreIdentifier.uniqueID == thisPhysicalStoreId}">
					<c:set var="inventoryAvailability" value="${thisInventoryAvailability}" />
				</c:if>
			</c:forEach>
			<c:if test="${!empty physicalStore}">
				<c:set var="inventoryStatus" value="${(empty inventoryAvailability ? 'Unavailable' : inventoryAvailability.inventoryStatus)}" />
				<fmt:message var="inventoryStatusMessage" key="INV_STATUS_${inventoryStatus}" bundle="${storeText}" />
				<fmt:message var="availLiClassId" key="status_${inventoryStatus}" bundle="${storeText}" />
				<wcf:url var="mInStoreAvailabilityDetailsView" value="mInStoreAvailabilityDetailsView">
					<c:forEach var="parameter" items="${WCParamValues}">
						<c:forEach var="value" items="${parameter.value}">
							<c:if test="${parameter.key ne 'productId'}">
								<wcf:param name="${parameter.key}" value="${value}" />
							</c:if>
						</c:forEach>
					</c:forEach>
					<wcf:param name="productId" value="${param.productId}" />
					<wcf:param name="itemId" value="${itemId}" />
					<wcf:param name="physicalStoreId" value="${thisPhysicalStoreId}" />
					<wcf:param name="physicalStoreIndex" value="${status.index}" />
					<wcf:param name="pgGrp" value="prodComp" />
				</wcf:url>
				<p class="<c:out value="${availLiClassId}" />"><img src="${jspStoreImgDir}mobile/images/${inventoryStatus}.gif" width="12" height="12" alt="${inventoryStatusMessage}" />
					<c:set var="physicalStoreName" value="${physicalStore.description[0].name}" />
					<a href="${fn:escapeXml(mInStoreAvailabilityDetailsView)}" title="${fn:escapeXml(physicalStoreName)}"><c:out value="${physicalStoreName}" /></a><%--: <c:out value="${inventoryStatusMessage}" />--%></p>
			</c:if>
		</c:forEach>
	</c:if>


</div>

<!-- END ItemAvailForProdCompare.jsp -->
