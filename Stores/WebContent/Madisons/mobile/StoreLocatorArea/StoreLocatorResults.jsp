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
  * This JSP displays the store locator search result page.
  *****
--%>

<!-- BEGIN StoreLocatorResults.jsp -->

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>

<%@ include file="../../include/parameters.jspf" %>
<%@ include file="../include/JSTLEnvironmentSetup.jspf" %>

<c:set var="storeLocatorPageGroup" value="true" />
<c:set var="storeLocatorResultPage" value="true" />

<c:if test="${!empty WCParam.fromPage}">
	<c:set var="fromPage" value="${WCParam.fromPage}" />
</c:if>

<c:set var="zipOrCity" value="${zipOrCitySavedInput}" />
<c:if test="${!empty WCParam.whichSearch}">
	<c:set var="whichSearch" value="${WCParam.whichSearch}" scope="session" />
</c:if>

<c:set var="geoNodeId" value="" />
<c:if test="${!empty WCParam.geoNodeId}">
	<c:set var="geoNodeId" value="${WCParam.geoNodeId}" />
</c:if>
<c:set var="geoNodeIdSaved" value="${geoNodeId}" scope="session" />

<c:set var="geoNodeShortDesc" value="" />
<c:if test="${!empty WCParam.geoNodeShortDesc}">
	<c:set var="geoNodeShortDesc" value="${WCParam.geoNodeShortDesc}" />
</c:if>
<c:set var="geoNodeShortDescSaved" value="${geoNodeShortDesc}" scope="session" />

<c:set var="multipleCity" value="" />
<c:if test="${!empty WCParam.multipleCity}">
	<c:set var="multipleCity" value="${WCParam.multipleCity}" />
</c:if>
<c:if test="${multipleCity}">
	<wcf:getData type="com.ibm.commerce.store.facade.datatypes.GeoNodeType[]"
	             var="geoNodes" varException="geoNodeException" expressionBuilder="findGeoNodesByGeoNodeTypeAndName">
		<wcf:param name="accessProfile" value="IBM_Store_All" />
		<wcf:param name="type" value="CITY" />
		<wcf:param name="name" value="${zipOrCity}" />
	</wcf:getData>

	<c:set var="resultNum" value="${fn:length(geoNodes)}" />
</c:if>

<c:set var="geoCodeLatitude" value="" />
<c:if test="${!empty WCParam.geoCodeLatitude}">
	<c:set var="geoCodeLatitude" value="${WCParam.geoCodeLatitude}" />
</c:if>
<c:if test="${!empty geoCodeLatitude}">
	<c:set var="geoCodeLatitudeSaved" value="${geoCodeLatitude}" scope="session" />
</c:if>

<c:set var="geoCodeLongitude" value="" />
<c:if test="${!empty WCParam.geoCodeLongitude}">
	<c:set var="geoCodeLongitude" value="${WCParam.geoCodeLongitude}" />
</c:if>
<c:if test="${!empty geoCodeLongitude}">
	<c:set var="geoCodeLongitudeSaved" value="${geoCodeLongitude}" scope="session" />
</c:if>

<c:set var="radius" value="" />
<c:if test="${!empty WCParam.radius}">
	<c:set var="radius" value="${WCParam.radius}" />
</c:if>
<c:set var="radiusSaved" value="${radius}" scope="session" />

<c:set var="uom" value="" />
<c:if test="${!empty WCParam.uom}">
	<c:set var="uom" value="${WCParam.uom}" />
</c:if>
<c:set var="uomSaved" value="${uom}" scope="session" />

<c:set var="maxItems" value="${storeLocatorResultMaxPageSize}" />
<c:choose>
	<c:when test="${!empty geoNodeId}">
		<c:set var="page" value="${empty WCParam.page ? 1 : WCParam.page}" />
		<c:set var="recordSetStartNumber" value="${(page-1)*maxItems}" />
		<wcf:getData type="com.ibm.commerce.store.facade.datatypes.PhysicalStoreType[]"
			     var="physicalStores" varException="physicalStoreException" expressionBuilder="findPhysicalStoresByGeoNodeUniqueID"
			     recordSetReferenceId="${WCParam.recordSetReferenceId}" recordSetStartNumber="${recordSetStartNumber}" maxItems="${maxItems}" varShowVerb="showVerb">
			<wcf:param name="accessProfile" value="IBM_Store_Details" />
			<wcf:param name="uniqueId" value="${geoNodeId}" />
		</wcf:getData>
	</c:when>
	<c:otherwise>
		<c:choose>
			<c:when test="${!empty geoCodeLatitude && !empty geoCodeLongitude}">
				<wcf:getData type="com.ibm.commerce.store.facade.datatypes.PhysicalStoreType[]"
					     var="physicalStores" varException="physicalStoreException" expressionBuilder="findPhysicalStoresFromGeoCode"
					     varShowVerb="showVerb">
					<wcf:param name="accessProfile" value="IBM_Store_Details" />
					<wcf:param name="latitude" value="${geoCodeLatitude}" />
					<wcf:param name="longitude" value="${geoCodeLongitude}" />
					<c:if test="${!empty radius}">
						<wcf:param name="value" value="${radius}" />
					</c:if>					
					<c:if test="${!empty uom}">
						<wcf:param name="uom" value="${uom}" />
					</c:if>					
					<wcf:param name="maxStores" value="${maxItems}" />
				</wcf:getData>
			</c:when>
			<c:otherwise>
				<!-- temp code starts - message!! -->
				<c:set var="resultEmpty" value="true" scope="session" />
				<!-- temp code ends - message!! -->
			</c:otherwise>
		</c:choose>	
	</c:otherwise>
</c:choose>


<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.2//EN" "http://www.openmobilealliance.org/tech/DTD/xhtml-mobile12.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" lang="${shortLocale}" xml:lang="${shortLocale}">

	<head>

		<c:choose>
			<c:when test="${!multipleCity}">
				<c:choose>				
					<c:when test="${!empty geoCodeLatitude && !empty geoCodeLongitude}">
						<title>
							<fmt:message key="MSTLOCRES_TITLE" bundle="${storeText}">
								<fmt:param value="${storeName}" />
							</fmt:message>
						</title>
					</c:when>
					<c:otherwise>
						<c:choose>
							<c:when test="${!empty geoNodeId}">
								<title>
									<fmt:message key="MSTLOCRES_TITLE_SINGLE_CITY" bundle="${storeText}">
										<fmt:param value="${storeName}" />
									</fmt:message>
								</title>
							</c:when>
							<c:otherwise>
								<title>
									<fmt:message key="MSTLOCRES_TITLE_NO_CITY" bundle="${storeText}">
										<fmt:param value="${storeName}" />
									</fmt:message>
								</title>
							</c:otherwise>
						</c:choose>
					</c:otherwise>
				</c:choose>
			</c:when>
			<c:otherwise>
				<title>
					<fmt:message key="MSTLOCRES_TITLE" bundle="${storeText}">
						<fmt:param value="${storeName}" />
					</fmt:message>
				</title>
			</c:otherwise>
		</c:choose>
		
		<meta http-equiv="content-type" content="application/xhtml+xml" />
		<meta http-equiv="cache-control" content="max-age=300" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no" />

		<link rel="stylesheet" href="${cssPath}" type="text/css" />

	</head>
	
	<body>
		
		<div id="wrapper">
		
			<%@ include file="../include/HeaderDisplay.jspf" %>

			<fmt:message var="finalBreadcrumb" key="MSTORE_LOCATOR_RESULTS" bundle="${storeText}" />
			<%@ include file="../include/BreadCrumbTrailDisplay.jspf" %>	
			
			<div id="store_locator_results" class="content_box">
				<div class="heading_container_with_underline">
					<h2><fmt:message key="MSTORE_LOCATOR_RESULTS" bundle="${storeText}" /></h2>
					<div class="clear_float"></div>

					<c:if test="${!empty WCParam.errorMsgKey}">
						<p class="error"><fmt:message key="${WCParam.errorMsgKey}" bundle="${storeText}" /></p>
					</c:if>				

					<c:if test="${multipleCity}">
						<form id="store_locator_result_form" method="post" action="">
						<div class="notice_box">
							<label for="select_city"><p><fmt:message key="MSTLOCRES_MULTI_CITY_MESSAGE" bundle="${storeText}" /> <span class="bold">&#34;<c:out value="${zipOrCity}" />&#34;</span>.</p>
							<p><fmt:message key="MSTLOCRES_MULTI_CITY_SELECT" bundle="${storeText}" /></p></label>
							<select id="select_city" name="select_city" class="coloured_input" onchange="window.location.href=this.form.select_city.options[this.form.select_city.selectedIndex].value;">
								<c:forEach var="i" begin="0" end="${resultNum-1}">
									<c:url var="mStoreLocatorResultURL" value="mStoreLocatorResultView">
										<c:param name="storeId" value="${WCParam.storeId}" />
										<c:param name="langId" value="${WCParam.langId}" />
										<c:param name="catalogId" value="${WCParam.catalogId}" />
										<c:param name="productId" value="${WCParam.productId}" />
										
										<c:if test="${!empty WCParam.pgGrp}">
											<c:param name="pgGrp" value="${WCParam.pgGrp}" />
											<c:choose>
												<c:when test="${WCParam.pgGrp == 'catNav'}">
													<c:param name="categoryId" value="${WCParam.categoryId}" />
													<c:param name="parent_category_rn" value="${WCParam.parent_category_rn}" />
													<c:param name="top_category" value="${WCParam.top_category}" />
													<c:param name="sequence" value="${WCParam.sequence}" />
												</c:when>
												<c:when test="${WCParam.pgGrp == 'search'}">
													<c:param name="resultCatEntryType" value="${WCParam.resultCatEntryType}" />
													<c:param name="pageSize" value="${WCParam.pageSize}" />
													<c:param name="searchTerm" value="${WCParam.searchTerm}" />
													<c:param name="beginIndex" value="${WCParam.beginIndex}" />			
													<c:param name="sType" value="${WCParam.sType}" />			
												</c:when>
											</c:choose>
										</c:if>	
										
										<c:param name="geoNodeId" value="${geoNodes[i].geoNodeIdentifier.uniqueID}" />
										<c:param name="geoNodeShortDesc" value="${geoNodes[i].description[0].shortDescription}" />
										<c:param name="fromPage" value="${fromPage}" />
										<c:if test="${fromPage == 'ShoppingCart'}">
											<c:param name="orderId" value="${WCParam.orderId}" />
										</c:if>
									</c:url>
									<option value="<c:out value='${mStoreLocatorResultURL}' />"><c:out value="${geoNodes[i].description[0].shortDescription}" /></option>
								</c:forEach>
							</select>
						</div>
						</form>
					</c:if>
				</div>

				<c:if test="${(!empty geoNodeId || (!empty geoCodeLatitude && !empty geoCodeLongitude)) && empty physicalStoreException}">
					<c:set var="resultStoreNum" value="${fn:length(physicalStores)}" />
					<c:choose>
						<c:when test="${resultStoreNum > 0}">
							<c:set var="resultEmpty" value="false" scope="session" />		

							<div class="information">
								<p class="search_results_text">
								<c:choose>
									<c:when test="${!empty geoNodeId}">
										<fmt:message key="MSTLOCRES_M_STORE" bundle="${storeText}">
											<fmt:param value="${recordSetStartNumber + 1}" />
											<fmt:param value="${recordSetStartNumber + resultStoreNum}" />
											<fmt:param value="${showVerb.recordSetTotal}" />
										</fmt:message> <span class="bold">&#34;<c:out value="${zipOrCity}" />&#34;</span><c:if test="${!empty geoNodeShortDesc}">-<c:out value="${geoNodeShortDesc}" /></c:if>
									</c:when>
									<c:otherwise>
										<c:choose>
											<c:when test="${whichSearch == 'zipOrCity'}">
												<fmt:message key="MSTLOCRES_CLOSEST_STORE" bundle="${storeText}">
													<fmt:param value="${resultStoreNum}" />
												</fmt:message> <span class="bold">&#34;<c:out value="${zipOrCity}" />&#34;</span>
											</c:when>
											<c:otherwise>
												<fmt:message key="MSTLOCRES_GPS_CLOSEST_STORE" bundle="${storeText}">
													<fmt:param value="${resultStoreNum}" />
												</fmt:message>
											</c:otherwise>
										</c:choose>
									</c:otherwise>
								</c:choose>
								</p>
								<c:if test="${fromPage == 'ShoppingCart'}">
									<p class="checkout_instruction"><fmt:message key="MSTLOCRES_ADD_CHECK_PROD_AVAIL" bundle="${storeText}" /></p>
								</c:if>
							</div>							

							<c:forEach var="i" begin="0" end="${resultStoreNum-1}">
								<%@ include file="../Snippets/StoreLocator/StoreHoursIndex.jspf" %>
		
								<ul class="last">
									<c:choose>
										<c:when test="${!empty geoNodeId}">
											<c:set var="detailInfoPage" value="${((page-1)*maxItems)+i+1}" />
										</c:when>
										<c:otherwise>
											<c:set var="detailInfoPage" value="${i+1}" />
										</c:otherwise>
									</c:choose>
									<c:choose>
										<c:when test="${fromPage == 'ShoppingCart'}">
											<li  class="align_with_bullet"><span class="bold"><c:out value="${physicalStores[i].description[0].name}" /></span></li>
										</c:when>
										<c:otherwise>
										    <c:set var="prevPage" value="storeLoc" />
										    
											<c:url var="mStoreDetailURL" value="mStoreDetailView">
												<c:param name="storeId" value="${WCParam.storeId}" />
												<c:param name="langId" value="${WCParam.langId}" />
												<c:param name="catalogId" value="${WCParam.catalogId}" />
												<c:param name="productId" value="${WCParam.productId}" />
												<c:param name="prevPage" value="${prevPage}" /> <%-- For Breadcrumb support defect#187661 --%>
											    
												<c:if test="${!empty WCParam.pgGrp}">
													<c:param name="pgGrp" value="${WCParam.pgGrp}" />
													<c:choose>
														<c:when test="${WCParam.pgGrp == 'catNav'}">
															<c:param name="categoryId" value="${WCParam.categoryId}" />
															<c:param name="parent_category_rn" value="${WCParam.parent_category_rn}" />
															<c:param name="top_category" value="${WCParam.top_category}" />
															<c:param name="sequence" value="${WCParam.sequence}" />
														</c:when>
														<c:when test="${WCParam.pgGrp == 'search'}">
															<c:param name="resultCatEntryType" value="${WCParam.resultCatEntryType}" />
															<c:param name="pageSize" value="${WCParam.pageSize}" />
															<c:param name="searchTerm" value="${WCParam.searchTerm}" />
															<c:param name="beginIndex" value="${WCParam.beginIndex}" />			
															<c:param name="sType" value="${WCParam.sType}" />			
														</c:when>
													</c:choose>
												</c:if>											
												<c:param name="geoNodeId" value="${geoNodeId}" />
												<c:param name="geoCodeLatitude" value="${geoCodeLatitude}" />
												<c:param name="geoCodeLongitude" value="${geoCodeLongitude}" />
												<c:param name="page" value="${detailInfoPage}" />
											</c:url>
											<li><span class="bullet">&#187; </span><a href="${fn:escapeXml(mStoreDetailURL)}"><span class="bold"><c:out value="${physicalStores[i].description[0].name}" /></span></a></li>
										</c:otherwise>
									</c:choose>
									
									<li class="align_with_bullet"><c:out value="${physicalStores[i].locationInfo.address.addressLine[0]}" /></li>
									<li class="align_with_bullet"><c:out value="${physicalStores[i].locationInfo.address.city}" />, <c:out value="${physicalStores[i].locationInfo.address.stateOrProvinceName}" /></li>
									<c:if test="${storeHoursIndex > -1}">
										<li class="align_with_bullet"><c:out value="${physicalStores[i].attribute[storeHoursIndex].displayValue}" escapeXml="false" /></li>
									</c:if>
									<c:set var="phoneWithNoSpace" value="${fn:trim(physicalStores[i].locationInfo.telephone1.value)}" />
									<c:set var="phoneWithCallingFormat" value="${fn:replace(phoneWithNoSpace, '.', '-')}" />
									<li><span class="bullet">&#187; </span><a href="tel:+1-${phoneWithCallingFormat}"><c:out value="${phoneWithNoSpace}" /></a></li>
									<%@ include file="../Snippets/StoreLocator/ViewMap.jspf" %>
									<c:set var="physicalStoreId" value="${physicalStores[i].physicalStoreIdentifier.uniqueID}" />
									<c:choose>
										<c:when test="${fn:contains(cookie.WC_physicalStores.value, physicalStoreId)}">
											<c:url var="mRemoveFromStoreList" value="mRemoveFromStoreList">
												<c:param name="storeId" value="${WCParam.storeId}" />
												<c:param name="langId" value="${WCParam.langId}" />
												<c:param name="catalogId" value="${WCParam.catalogId}" />
												<c:param name="productId" value="${WCParam.productId}" />
												
												<c:if test="${!empty WCParam.pgGrp}">
													<c:param name="pgGrp" value="${WCParam.pgGrp}" />
													<c:choose>
														<c:when test="${WCParam.pgGrp == 'catNav'}">
															<c:param name="categoryId" value="${WCParam.categoryId}" />
															<c:param name="parent_category_rn" value="${WCParam.parent_category_rn}" />
															<c:param name="top_category" value="${WCParam.top_category}" />
															<c:param name="sequence" value="${WCParam.sequence}" />
														</c:when>
														<c:when test="${WCParam.pgGrp == 'search'}">
															<c:param name="resultCatEntryType" value="${WCParam.resultCatEntryType}" />
															<c:param name="pageSize" value="${WCParam.pageSize}" />
															<c:param name="searchTerm" value="${WCParam.searchTerm}" />
															<c:param name="beginIndex" value="${WCParam.beginIndex}" />			
															<c:param name="sType" value="${WCParam.sType}" />			
														</c:when>
													</c:choose>
												</c:if>													
												
												<c:param name="physicalStoreId" value="${physicalStoreId}" />
												<c:param name="refUrl" value="mStoreLocatorResultView" />
												<c:param name="geoNodeId" value="${geoNodeId}" />
												<c:param name="geoNodeShortDesc" value="${geoNodeShortDesc}" />
												<c:param name="geoCodeLatitude" value="${geoCodeLatitude}" />
												<c:param name="geoCodeLongitude" value="${geoCodeLongitude}" />
												<c:param name="fromPage" value="${fromPage}" />
												<c:if test="${fromPage == 'ShoppingCart'}">
													<c:param name="orderId" value="${WCParam.orderId}" />
												</c:if>
												<c:param name="recordSetReferenceId" value="${showVerb.recordSetReferenceId}" />
												<c:param name="page" value="${page}" />
											</c:url>
											<li><span class="bullet">&#187; </span><a href="${fn:escapeXml(mRemoveFromStoreList)}"><fmt:message key='MSTLOCRES_REMOVE_STORE' bundle='${storeText}' /></a></li>
										</c:when>
										<c:otherwise>
											<c:url var="mAddToStoreList" value="mAddToStoreList">
												<c:param name="storeId" value="${WCParam.storeId}" />
												<c:param name="langId" value="${WCParam.langId}" />
												<c:param name="catalogId" value="${WCParam.catalogId}" />
												<c:param name="productId" value="${WCParam.productId}" />
												
												<c:if test="${!empty WCParam.pgGrp}">
													<c:param name="pgGrp" value="${WCParam.pgGrp}" />
													<c:choose>
														<c:when test="${WCParam.pgGrp == 'catNav'}">
															<c:param name="categoryId" value="${WCParam.categoryId}" />
															<c:param name="parent_category_rn" value="${WCParam.parent_category_rn}" />
															<c:param name="top_category" value="${WCParam.top_category}" />
															<c:param name="sequence" value="${WCParam.sequence}" />
														</c:when>
														<c:when test="${WCParam.pgGrp == 'search'}">
															<c:param name="resultCatEntryType" value="${WCParam.resultCatEntryType}" />
															<c:param name="pageSize" value="${WCParam.pageSize}" />
															<c:param name="searchTerm" value="${WCParam.searchTerm}" />
															<c:param name="beginIndex" value="${WCParam.beginIndex}" />			
															<c:param name="sType" value="${WCParam.sType}" />			
														</c:when>
													</c:choose>
												</c:if>													
																							
												<c:param name="physicalStoreId" value="${physicalStoreId}" />
												<c:param name="refUrl" value="mStoreLocatorResultView" />
												<c:param name="geoNodeId" value="${geoNodeId}" />
												<c:param name="geoNodeShortDesc" value="${geoNodeShortDesc}" />
												<c:param name="geoCodeLatitude" value="${geoCodeLatitude}" />
												<c:param name="geoCodeLongitude" value="${geoCodeLongitude}" />
												<c:param name="fromPage" value="${fromPage}" />
												<c:if test="${fromPage == 'ShoppingCart'}">
													<c:param name="orderId" value="${WCParam.orderId}" />
												</c:if>
												<c:param name="recordSetReferenceId" value="${showVerb.recordSetReferenceId}" />
												<c:param name="page" value="${page}" />
											</c:url>
											<li><span class="bullet">&#187; </span><a href="${fn:escapeXml(mAddToStoreList)}"><fmt:message key='MSTLOCRES_ADD_STORE' bundle='${storeText}' /></a></li>
										</c:otherwise>
									</c:choose>								
								</ul>

							</c:forEach>

							<c:if test="${!empty geoNodeId}">
								<div class="paging_control_with_underline">
									<c:set var="remainOnLastPage" value="${(showVerb.recordSetTotal mod maxItems)>0 ? 1 : 0}" />
									<c:set var="totalPage" value="${((showVerb.recordSetTotal-(showVerb.recordSetTotal mod maxItems))/maxItems) + remainOnLastPage}" />
									<div class="page_number">
										<fmt:message key="MSTLOCRES_PAGE_NUMBER" bundle="${storeText}">
											<fmt:param value="${page}" />
											<fmt:param value="${totalPage}" />
										</fmt:message>								
									</div>
									
									<c:choose>
										<c:when test="${totalPage > 1}">
											<c:if test="${page > 1}">
												<span class="bullet">&#171; </span>
												<c:url var="mStoreLocatorResultURL" value="mStoreLocatorResultView">
													<c:param name="storeId" value="${WCParam.storeId}" />
													<c:param name="langId" value="${WCParam.langId}" />
													<c:param name="catalogId" value="${WCParam.catalogId}" />
													<c:param name="productId" value="${WCParam.productId}" />
													
													<c:if test="${!empty WCParam.pgGrp}">
														<c:param name="pgGrp" value="${WCParam.pgGrp}" />
														<c:choose>
															<c:when test="${WCParam.pgGrp == 'catNav'}">
																<c:param name="categoryId" value="${WCParam.categoryId}" />
																<c:param name="parent_category_rn" value="${WCParam.parent_category_rn}" />
																<c:param name="top_category" value="${WCParam.top_category}" />
																<c:param name="sequence" value="${WCParam.sequence}" />
															</c:when>
															<c:when test="${WCParam.pgGrp == 'search'}">
																<c:param name="resultCatEntryType" value="${WCParam.resultCatEntryType}" />
																<c:param name="pageSize" value="${WCParam.pageSize}" />
																<c:param name="searchTerm" value="${WCParam.searchTerm}" />
																<c:param name="beginIndex" value="${WCParam.beginIndex}" />			
																<c:param name="sType" value="${WCParam.sType}" />			
															</c:when>
														</c:choose>
													</c:if>														
													
													<c:param name="geoNodeId" value="${geoNodeId}" />
													<c:param name="geoNodeShortDesc" value="${geoNodeShortDesc}" />
													<c:param name="fromPage" value="${fromPage}" />
													<c:if test="${fromPage == 'ShoppingCart'}">
														<c:param name="orderId" value="${WCParam.orderId}" />
													</c:if>
													<c:param name="recordSetReferenceId" value="${showVerb.recordSetReferenceId}" />
													<c:param name="page" value="${page - 1}" />
												</c:url>
												<a href="${fn:escapeXml(mStoreLocatorResultURL)}" title="<fmt:message key='MSTLOCRES_PREV_TITLE' bundle='${storeText}' />"><fmt:message key="MSTLOCRES_PREV" bundle="${storeText}" /></a>
											</c:if>
											<c:if test="${(page > 1) && (page < totalPage)}">
												&#160;&#160;
											</c:if>
											<c:if test="${page < totalPage}">
												<c:url var="mStoreLocatorResultURL" value="mStoreLocatorResultView">
													<c:param name="storeId" value="${WCParam.storeId}" />
													<c:param name="langId" value="${WCParam.langId}" />
													<c:param name="catalogId" value="${WCParam.catalogId}" />
													<c:param name="productId" value="${WCParam.productId}" />
													
													<c:if test="${!empty WCParam.pgGrp}">
														<c:param name="pgGrp" value="${WCParam.pgGrp}" />
														<c:choose>
															<c:when test="${WCParam.pgGrp == 'catNav'}">
																<c:param name="categoryId" value="${WCParam.categoryId}" />
																<c:param name="parent_category_rn" value="${WCParam.parent_category_rn}" />
																<c:param name="top_category" value="${WCParam.top_category}" />
																<c:param name="sequence" value="${WCParam.sequence}" />
															</c:when>
															<c:when test="${WCParam.pgGrp == 'search'}">
																<c:param name="resultCatEntryType" value="${WCParam.resultCatEntryType}" />
																<c:param name="pageSize" value="${WCParam.pageSize}" />
																<c:param name="searchTerm" value="${WCParam.searchTerm}" />
																<c:param name="beginIndex" value="${WCParam.beginIndex}" />			
																<c:param name="sType" value="${WCParam.sType}" />			
															</c:when>
														</c:choose>
													</c:if>														
													
													<c:param name="geoNodeId" value="${geoNodeId}" />
													<c:param name="geoNodeShortDesc" value="${geoNodeShortDesc}" />
													<c:param name="fromPage" value="${fromPage}" />
													<c:if test="${fromPage == 'ShoppingCart'}">
														<c:param name="orderId" value="${WCParam.orderId}" />
													</c:if>
													<c:param name="recordSetReferenceId" value="${showVerb.recordSetReferenceId}" />
													<c:param name="page" value="${page + 1}" />
												</c:url>
												<a href="${fn:escapeXml(mStoreLocatorResultURL)}" title="<fmt:message key='MSTLOCRES_NEXT_TITLE' bundle='${storeText}' />"><fmt:message key="MSTLOCRES_NEXT" bundle="${storeText}" /></a>
												<span class="bullet"> &#187;</span>
											</c:if>
										</c:when>
										<c:otherwise>
											<span class="bullet">&#160;</span>
										</c:otherwise>
									</c:choose>
								</div>
							</c:if>
						</c:when>
						<c:otherwise>
							<c:set var="resultEmpty" value="true" scope="session" />
							<div class="information">
							<c:choose>
								<c:when test="${whichSearch == 'zipOrCity'}">
									<c:choose>
										<c:when test="${!empty geoNodeId}">
											<p class="search_results_text"><fmt:message key="MSTLOCRES_NO_STORE" bundle="${storeText}"/> <span class="bold">&#34;<c:out value="${zipOrCity}" />&#34;</span><c:if test="${!empty geoNodeShortDesc}">-<c:out value="${geoNodeShortDesc}" /></c:if></p>
										</c:when>
										<c:otherwise>
											<p class="search_results_text"><fmt:message key="MSTLOCRES_NO_STORE" bundle="${storeText}"/> <span class="bold">&#34;<c:out value="${zipOrCity}" />&#34;</span></p>
										</c:otherwise>
									</c:choose>
								</c:when>
								<c:otherwise>
									<p class="search_results_text">
									<fmt:message key="MSTLOCRES_GPS_CLOSEST_STORE" bundle="${storeText}">
										<fmt:param value="0" />
									</fmt:message>
									</p>
								</c:otherwise>
							</c:choose>
							</div>
						</c:otherwise>
					</c:choose>
				</c:if>

				<c:if test="${empty geoNodeId || resultEmpty}">
					<div><p class="paragraph_separator"></p></div>
				</c:if>
				
				<c:if test="${fromPage != 'ProductDetails' && fromPage != 'ShoppingCart'}">
					<c:url var="mSelectedStoreListURL" value="mSelectedStoreListView">
						<c:param name="storeId" value="${WCParam.storeId}" />
						<c:param name="langId" value="${WCParam.langId}" />
						<c:param name="catalogId" value="${WCParam.catalogId}" />
						<c:param name="productId" value="${WCParam.productId}" />
						<c:param name="fromPage" value="${fromPage}" />
					</c:url>
					<div>
						<fmt:message key="MSTLOCRES_STLST_MANAGE" bundle="${storeText}" />
						<p class="paragraph_blurb"><span class="bullet">&#187; </span><a href="${fn:escapeXml(mSelectedStoreListURL)}" title="Store Locator"><fmt:message key="MSTLOCRES_STLST" bundle="${storeText}" /></a></p>
					</div>
				</c:if>
				
				<c:choose>
					<c:when test="${fromPage == 'ProductDetails'}">
						<form id="store_result_button" method="post" action="mProductDisplayView">
							<input type="hidden" id="storeId_pd" name="storeId" value="${WCParam.storeId}" />
							<input type="hidden" id="langId_pd" name="langId" value="${WCParam.langId}" />
							<input type="hidden" id="catalogId_pd" name="catalogId" value="${WCParam.catalogId}" />
							<input type="hidden" id="productId_pd" name="productId" value="${WCParam.productId}" />
	
							<c:if test="${!empty WCParam.pgGrp}">
								<input type="hidden" id="pgGrp_pd" name="pgGrp" value="${WCParam.pgGrp}" />
								<c:choose>
									<c:when test="${WCParam.pgGrp == 'catNav'}">
										<input type="hidden" id="categoryId_pd" name="categoryId" value="${WCParam.categoryId}" />
										<input type="hidden" id="parent_category_rn_pd" name="parent_category_rn" value="${WCParam.parent_category_rn}" />
										<input type="hidden" id="top_category_pd" name="top_category" value="${WCParam.top_category}" />
										<input type="hidden" id="sequence_pd" name="sequence" value="${WCParam.sequence}" />
									</c:when>
									<c:when test="${WCParam.pgGrp == 'search'}">
										<input type="hidden" id="resultCatEntryType_pd" name="resultCatEntryType" value="${WCParam.resultCatEntryType}" />
										<input type="hidden" id="pageSize_pd" name="pageSize" value="${WCParam.pageSize}" />
										<input type="hidden" id="searchTerm_pd" name="searchTerm" value="${WCParam.searchTerm}" />
										<input type="hidden" id="sType_pd" name="sType" value="${WCParam.sType}" />
										<input type="hidden" id="beginIndex_pd" name="beginIndex" value="${WCParam.beginIndex}" />
									</c:when>
								</c:choose>
							</c:if>																
	
							<input type="submit" id="continue_shopping" name="continue_shopping" class="input_button_float" value="<fmt:message key='MSTLOCRES_CONT_SHOPPING' bundle='${storeText}' />" />
						</form>
					</c:when>
					<c:when test="${fromPage == 'ShoppingCart'}">
						<form id="store_result_button" method="post" action="mSelectedStoreListView">
							<input type="hidden" id="storeId_sc" name="storeId" value="${WCParam.storeId}" />
							<input type="hidden" id="langId_sc" name="langId" value="${WCParam.langId}" />
							<input type="hidden" id="catalogId_sc" name="catalogId" value="${WCParam.catalogId}" />
							<input type="hidden" id="fromPage_sc" name="fromPage" value="${fromPage}" />
							<input type="hidden" id="orderId_sc" name="orderId" value="${WCParam.orderId}" />

							<input type="submit" id="continue_checkout" name="continue_checkout" class="input_button_float" value="<fmt:message key='MSTLOCRES_CONT_CHECKOUT' bundle='${storeText}' />" />
						</form>
					</c:when>
					<c:otherwise>
						<form id="store_result_button" method="post" action="mIndex">
							<input type="hidden" id="storeId" name="storeId" value="${WCParam.storeId}" />
							<input type="hidden" id="langId" name="langId" value="${WCParam.langId}" />
							<input type="hidden" id="catalogId" name="catalogId" value="${WCParam.catalogId}" />
							

							<input type="submit" id="continue_shopping" name="continue_shopping" class="input_button_float" value="<fmt:message key='MSTLOCRES_CONT_SHOPPING' bundle='${storeText}' />" />
						</form>
					</c:otherwise>
				</c:choose>
			</div>
				
			<%@ include file="../include/FooterDisplay.jspf" %>						
			
		</div>
		
	</body>
	
</html>

<!-- END StoreLocatorResults.jsp -->
