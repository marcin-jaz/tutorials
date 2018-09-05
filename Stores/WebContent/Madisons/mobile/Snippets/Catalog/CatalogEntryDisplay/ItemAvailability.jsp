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
  * This JSP displays Item Availability.
  *****
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>

<%@ taglib uri="flow.tld" prefix="flow" %>

<!-- BEGIN ItemAvailability.jsp -->

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

	<h3><fmt:message key="CHECK_STORE_AVAIL" bundle="${storeText}" /></h3>

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

	<p class="bold"><fmt:message key="PRODUCT_INV_STORE" bundle="${storeText}" /></p>

	<c:choose>
		<c:when test="${empty physicalStores}">
			<wcf:url var="mStoreLocatorView" value="mStoreLocatorView">
				<c:set var="fromPageSet" value="false" />
				<c:forEach var="thisParameter" items="${WCParamValues}">
					<c:forEach var="value" items="${thisParameter.value}">
						<c:choose>
							<c:when test="${thisParameter.key eq 'fromPage'}">
								<wcf:param name="${thisParameter.key}" value="ProductDetails" />
								<c:set var="fromPageSet" value="true" />
							</c:when>
							<c:otherwise>
								<c:if test="${thisParameter.key ne 'productId'}">							
									<wcf:param name="${thisParameter.key}" value="${value}" />
								</c:if>
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</c:forEach>
				
				<c:if test="${fromPageSet eq 'false'}">
					<wcf:param name="fromPage" value="ProductDetails" />
				</c:if>
				<wcf:param name="productId" value="${productId}" />					
			</wcf:url>
			<fmt:message var="selectStore" key="INV_Link_Check_Store" bundle="${storeText}" />
			<p><span class="bullet">&#187; </span> <a href="${fn:escapeXml(mStoreLocatorView)}" title="${fn:escapeXml(selectStore)}"><c:out value="${selectStore}" /></a></p>
		</c:when>
		<c:otherwise>
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
						<wcf:param name="productId" value="${productId}" />
						<wcf:param name="itemId" value="${itemId}" />
						<wcf:param name="physicalStoreId" value="${thisPhysicalStoreId}" />
						<wcf:param name="physicalStoreIndex" value="${status.index}" />
					</wcf:url>
					<p class="<c:out value="${availLiClassId}" />"><img src="${jspStoreImgDir}mobile/images/${inventoryStatus}.gif" width="12" height="12" alt="${inventoryStatusMessage}" />
						<c:set var="physicalStoreName" value="${physicalStore.description[0].name}" />
						<a href="${fn:escapeXml(mInStoreAvailabilityDetailsView)}" title="${fn:escapeXml(physicalStoreName)}"><c:out value="${physicalStoreName}" /></a>: <c:out value="${inventoryStatusMessage}" /></p>
				</c:if>
			</c:forEach>
			<wcf:url var="mSelectedStoreListView" value="mSelectedStoreListView">
				<c:set var="fromPageSet" value="false" />
				<wcf:param name="storeList" value="true" />
				<c:forEach var="thisParameter" items="${WCParamValues}">
					<c:forEach var="value" items="${thisParameter.value}">
						<c:choose>
							<c:when test="${thisParameter.key eq 'fromPage'}">
								<wcf:param name="${thisParameter.key}" value="ProductDetails" />
								<c:set var="fromPageSet" value="true" />
							</c:when>
							<c:otherwise>
								<c:if test="${thisParameter.key ne 'productId'}">
									<wcf:param name="${thisParameter.key}" value="${value}" />
								</c:if>
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</c:forEach>
				
				<c:if test="${fromPageSet eq 'false'}">
					<wcf:param name="fromPage" value="ProductDetails" />
				</c:if>
				<wcf:param name="productId" value="${productId}" />					
			</wcf:url>
			<fmt:message var="changeStore" key="INV_Link_Change_Store" bundle="${storeText}" />
			<p><span class="bullet">&#187; </span> <a href="${fn:escapeXml(mSelectedStoreListView)}" title="${fn:escapeXml(changeStore)}"><c:out value="${changeStore}" /></a></p>
		</c:otherwise>
	</c:choose>

</div>

<!-- END ItemAvailability.jsp -->
