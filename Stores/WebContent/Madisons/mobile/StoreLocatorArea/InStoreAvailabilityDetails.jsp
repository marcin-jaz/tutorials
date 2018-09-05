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
  * This JSP displays the In-Store Availability details of an item.
  *****
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>

<%@ taglib uri="flow.tld" prefix="flow" %>

<!-- BEGIN InStoreAvailabilityDetails.jsp -->

<%@ include file="../include/JSTLEnvironmentSetup.jspf" %>

<c:set var="storeAvailPage" value="true" scope="request"/>
<c:choose>
	<c:when test="${WCParam.pgGrp == 'catNav'}">
		<c:set var="categoryNavPageGroup" value="true" scope="request"/>
	</c:when>
	<c:when test="${WCParam.pgGrp == 'search'}">
		<c:set var="searchPageGroup" value="true" scope="request"/>
	</c:when>
	<c:when test="${WCParam.pgGrp == 'wishlist'}">
		<c:set var="wishlistPageGroup" value="true" scope="request"/>
	</c:when>
	<c:when test="${WCParam.pgGrp == 'shoppingcart'}">
		<c:set var="shoppingcartPageGroup" value="true" scope="request"/>
	</c:when>
	<c:when test="${WCParam.pgGrp == 'prodComp'}">
		<c:set var="prodComparePageGroup" value="true" scope="request"/>
	</c:when>	
</c:choose>

<c:set var="itemId" value="${WCParam.itemId}" />
<c:set var="physicalStoreId" value="${WCParam.physicalStoreId}" />
<c:set var="physicalStoreIndex" value="${WCParam.physicalStoreIndex}" />

<c:if test="${!empty cookie.WC_physicalStores.value}">
	<c:set var="physicalStoreIds" value="${fn:split(fn:replace(cookie.WC_physicalStores.value, '%2C', ','), ',')}" />
</c:if>

<wcf:getData var="physicalStore"
		type="com.ibm.commerce.store.facade.datatypes.PhysicalStoreType"
		expressionBuilder="findPhysicalStoresByUniqueIDs">
	<wcf:param name="accessProfile" value="IBM_Store_Details" />
	<wcf:param name="uniqueId" value="${physicalStoreId}" />
</wcf:getData>

<wcf:getData var="inventoryAvailability"
		type="com.ibm.commerce.inventory.facade.datatypes.InventoryAvailabilityType"
		expressionBuilder="findInventoryAvailabilityByCatalogEntryIdsAndOnlineStoreIdsAndPhysicalStoreIds">
	<wcf:param name="accessProfile" value="IBM_Store_Details" />
	<wcf:param name="catalogEntryId" value="${itemId}" />
	<wcf:param name="physicalStoreId" value="${physicalStoreId}" />
</wcf:getData>

<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.2//EN" "http://www.openmobilealliance.org/tech/DTD/xhtml-mobile12.dtd">


<html xmlns="http://www.w3.org/1999/xhtml" lang="${shortLocale}" xml:lang="${shortLocale}">

	<head>

		<title>
			<fmt:message key="MSTKLOCDETAILS_TITLE" bundle="${storeText}">
				<fmt:param value="${physicalStore.description[0].name}" />
			</fmt:message>
		</title>

		<meta http-equiv="content-type" content="application/xhtml+xml" />
		<meta http-equiv="cache-control" content="max-age=300" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no" />

		<link rel="stylesheet" href="${cssPath}" type="text/css" />

	</head>

	<body>

		<div id="wrapper">

			<%@ include file="../include/HeaderDisplay.jspf" %>
			<c:set var="finalBreadcrumb" value="${physicalStore.description[0].name}" />
			<%@ include file="../include/BreadCrumbTrailDisplay.jspf" %>

			<div id="store_availability_details" class="content_box">

				<div class="heading_container_with_underline">
					<h2><c:out value="${physicalStore.description[0].name}" /></h2>
					<div class="clear_float"></div>
				</div>

				<c:set var="inventoryStatus" value="${(empty inventoryAvailability ? 'Unavailable' : inventoryAvailability.inventoryStatus)}" />
				<fmt:message var="message" key="INV_STATUS_${inventoryStatus}" bundle="${storeText}" />
				<fmt:message var="availLiClassId" key="status_${inventoryStatus}" bundle="${storeText}" />

				<ul id="availability">
					<li><span class="bold"><fmt:message key="MSTKLOCDETAILS_IN_STORE_AVAILABILITY" bundle="${storeText}" /></span></li>
					<li class="<c:out value="${availLiClassId}" />">
						<img src="${jspStoreImgDir}mobile/images/${inventoryStatus}.gif" width="12" height="12" alt="${message}" />
						<c:out value="${message}" />
						<c:choose>
							<c:when test="${inventoryStatus == 'Available'}">
								<c:if test="${!empty inventoryAvailability.availableQuantity}">
									(<fmt:formatNumber value="${inventoryAvailability.availableQuantity.value}" type="number" maxFractionDigits="0" />)
								</c:if>
							</c:when>
							<c:when test="${inventoryStatus == 'Backorderable'}">
								<c:if test="${!empty inventoryAvailability.availabilityDateTime}">
									<c:catch>
										<fmt:parseDate var="availabilityDate" value="${inventoryAvailability.availabilityDateTime}" pattern="yyyy-MM-dd'T'HH:mm:ss.SSS'Z'" timeZone="UTC" />
									</c:catch>
									<c:if test="${empty availabilityDate}">
										<c:catch>
											<fmt:parseDate var="availabilityDate" value="${inventoryAvailability.availabilityDateTime}" pattern="yyyy-MM-dd'T'HH:mm:ss'Z'" timeZone="UTC" />
										</c:catch>
									</c:if>
									(<fmt:formatDate value="${availabilityDate}" dateStyle="long" />)
								</c:if>
							</c:when>
						</c:choose>
					</li>
				</ul>

				<ul id="address">
					<li><span class="bold"><fmt:message key="MSTDT_ADDRESS" bundle="${storeText}" /></span></li>
					<li>
						<c:out value="${physicalStore.locationInfo.address.addressLine[0]}" /><br />
						<c:out value="${physicalStore.locationInfo.address.city}" />, <c:out value="${physicalStore.locationInfo.address.stateOrProvinceName}" />
					</li>
					<c:set var="tel" value="${fn:replace(physicalStore.locationInfo.telephone1.value, '.', '-')}" />
					<li><span class="bullet">&#187; </span><a href="tel:+1-${fn:escapeXml(tel)}"><c:out value="${physicalStore.locationInfo.telephone1.value}" /></a></li>
					<%@ include file="../Snippets/StoreLocator/ViewMap.jspf" %>
				</ul>

				<ul id="">
					<li><span class="bold"><fmt:message key="MSTDT_SHOP_HOURS" bundle="${storeText}" /></span></li>
					<li>
						<c:forEach var="attribute" items="${physicalStore.attribute}">
							<c:if test="${attribute.name == 'StoreHours'}">
								<p>${attribute.value}</p>
							</c:if>
						</c:forEach>
					</li>
				</ul>

				<div class="paging_control_with_underline">
					<fmt:message var="previousStore" key='MSTDT_PREV_TITLE' bundle='${storeText}' />
					<fmt:message var="nextStore" key='MSTDT_NEXT_TITLE' bundle='${storeText}' />
					<c:if test="${physicalStoreIndex gt 0}">
						<wcf:url var="mInStoreAvailabilityDetailsView" value="mInStoreAvailabilityDetailsView">
							<c:forEach var="thisParameter" items="${WCParamValues}">
								<c:if test="${thisParameter.key != 'physicalStoreId' and thisParameter.key != 'physicalStoreIndex'}">
									<c:forEach var="value" items="${thisParameter.value}">
										<wcf:param name="${thisParameter.key}" value="${value}" />
									</c:forEach>
								</c:if>
							</c:forEach>
							<wcf:param name="physicalStoreId" value="${physicalStoreIds[physicalStoreIndex - 1]}" />
							<wcf:param name="physicalStoreIndex" value="${physicalStoreIndex - 1}" />
						</wcf:url>
						<span class="bullet">&#171;</span> <a href="${fn:escapeXml(mInStoreAvailabilityDetailsView)}" title="${fn:escapeXml(previousStore)}"><c:out value="${previousStore}" /></a>&#160;&#160;
					</c:if>
					<c:if test="${physicalStoreIndex lt fn:length(physicalStoreIds) - 1}">
						<wcf:url var="mInStoreAvailabilityDetailsView" value="mInStoreAvailabilityDetailsView">
							<c:forEach var="thisParameter" items="${WCParamValues}">
								<c:if test="${thisParameter.key != 'physicalStoreId' and thisParameter.key != 'physicalStoreIndex'}">
									<c:forEach var="value" items="${thisParameter.value}">
										<wcf:param name="${thisParameter.key}" value="${value}" />
									</c:forEach>
								</c:if>
							</c:forEach>
							<wcf:param name="physicalStoreId" value="${physicalStoreIds[physicalStoreIndex + 1]}" />
							<wcf:param name="physicalStoreIndex" value="${physicalStoreIndex + 1}" />
						</wcf:url>
						<a href="${fn:escapeXml(mInStoreAvailabilityDetailsView)}" title="${fn:escapeXml(nextStore)}"><c:out value="${nextStore}" /></a> <span class="bullet">&#187;</span>
					</c:if>
				</div>

				<wcf:url var="mProductDisplayView" value="mProductDisplayView">
					<c:forEach var="thisParameter" items="${WCParamValues}">
						<c:if test="${thisParameter.key != 'physicalStoreId' and thisParameter.key != 'physicalStoreIndex'}">
							<c:forEach var="value" items="${thisParameter.value}">
								<wcf:param name="${thisParameter.key}" value="${value}" />
							</c:forEach>
						</c:if>
					</c:forEach>
				</wcf:url>
				<fmt:message var="backToProductPage" key='MSTKLOCDETAILS_BACK_TO_PRODUCT_PAGE' bundle='${storeText}' />
				<span class="bullet">&#187;</span> <a href="${fn:escapeXml(mProductDisplayView)}" title="${fn:escapeXml(backToProductPage)}"><c:out value="${backToProductPage}" /></a>

			</div>

			<%@ include file="../include/FooterDisplay.jspf" %>						

		</div>

	</body>

</html>

<!-- END InStoreAvailabilityDetails.jsp -->
