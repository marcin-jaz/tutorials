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
  * This JSP displays the advanced search form for catalog searching.
  *****
--%>

<!-- BEGIN CatalogSearchForm.jsp -->

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>

<%@ include file="../../../../include/parameters.jspf" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf" %>

<%-- Required variables for breadcrumb support --%>
<c:set var="searchPageGroup" value="true" scope="request" />
<c:set var="searchForm" value="true" scope="request" />

<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.2//EN" "http://www.openmobilealliance.org/tech/DTD/xhtml-mobile12.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" lang="${shortLocale}" xml:lang="${shortLocale}">

<head>

		<title><fmt:message key="TITLE_ADVANCED_SEARCH" bundle="${storeText}"/> - <c:out value="${storeName}"/></title>
		
		<meta http-equiv="content-type" content="application/xhtml+xml" />
		<meta http-equiv="cache-control" content="max-age=300" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no" />
		<link rel="stylesheet" href="${cssPath}" type="text/css"/>

		
		<script type="text/javascript" src="<c:out value="${jspStoreImgDir}mobile/javascript/CatalogSearchDisplay.js"/>"></script>
	</head>
	
	<body>
		
		<div id="wrapper">
		
			<%@ include file="../../../include/HeaderDisplay.jspf" %>
			<%@ include file="../../../include/BreadCrumbTrailDisplay.jspf"%>
			
			<div id="advanced_search" class="content_box">
				<div class="heading_container">
					<h2><fmt:message key="TITLE_ADVANCED_SEARCH" bundle="${storeText}"/></h2>
					<div class="clear_float"></div>
				</div>
				
				<p class="paragraph_blurb"><fmt:message key="ADVANCED_SEARCH_DESCRIPTION" bundle="${storeText}"/></p>

				<form id="advanced_search_form" action="mCatalogSearchResultView" method="get">
					<fieldset>
							  
					  	<input type="hidden" name="storeId" value='<c:out value="${WCParam.storeId}" />' id="storeId"/>
						<input type="hidden" name="catalogId" value='<c:out value="${WCParam.catalogId}"/>' id="catalogId"/>
						<input type="hidden" name="langId" value='<c:out value="${langId}"/>' id="langId"/>
						<input type="hidden" name="resultCatEntryType" value="2" id="resultType"/>
						<input type="hidden" name="beginIndex" value="0" id="beginIndex"/>
						<input type="hidden" name="catgrpSchemaType" value="1" id="catgrpSchemaType"/>
						<input type="hidden" name="RASchemaType" value="1" id="RASchemaType"/>
						<input type="hidden" name="sType" value="AdvancedSearch" id="sType"/>
						<input type="hidden" name="searchTermCaseSensitive" value="no" id="searchTermCaseSensitive"/>
						<input type="hidden" name="searchTermOperator" value="LIKE" id="searchTermOperator"/>
						<input type="hidden" name="filterTermCaseSensitive" value="no" id="filterTermCaseSensitive"/>
						<input type="hidden" name="filterTermOperator" value="LIKE" id="filterTermOperator"/>
						<input type="hidden" name="qtyAvailable" value="" id="qtyAvailable"/>
						<input type="hidden" name="qtyAvailableOperator" value="EQUAL" id="qtyAvailableOperator"/>
						<input type="hidden" name="qtyMeasure" value="" id="qtyMeasure"/>
						<input type="hidden" name="qtyMeasureCaseSensitive" value="" id="qtyMeasureCaseSensitive"/>
						<input type="hidden" name="qtyMeasureOperator" value="EQUAL" id="qtyMeasureOperator"/>	
						<input type="hidden" name="categoryType" value="ANY" id="categoryType"/>
						<input type="hidden" name="manufacturerCaseSensitive" value="no" id="manufacturerCaseSensitive"/>
						<input type="hidden" name="manufacturerOperator" value="LIKE" id="manufacturerOperator"/>
						<input type="hidden" name="currency" value="<c:out value="${CommandContext.currency}" escapeXml="false"/>" id="currency"/>
			
						<div class="linked_fields">
							<div class="input_container">
								<div><label for="search_for"><fmt:message key="SEARCH_FOR" bundle="${storeText}"/></label></div>
								<input type="text" id="search_for" name="searchTerm" value="<c:out value='${WCParam.searchTerm}' />" class="coloured_input" />
							</div>	
							
							<div class="dropdown_container">
								<label for="search_type"><span style="display:none;"><fmt:message key="SEARCH_TYPE_FILTER" bundle="${storeText}"/></span></label>									  
								<select id="search_type" name="searchType" class="coloured_input">
									<c:choose>
										<c:when test="${!empty WCParam.searchType && WCParam.searchType=='ALL'}">
											<option value="ALL" selected="selected">
										</c:when>
										<c:otherwise>
											<option value="ALL">
										</c:otherwise>
									</c:choose>
									<fmt:message key="ALL_WORDS" bundle="${storeText}"/>
									</option>
								
									<c:choose>
										<c:when test="${!empty WCParam.searchType && WCParam.searchType=='ANY'}">
											<option value="ANY" selected="selected">
										</c:when>
										<c:otherwise>
											<option value="ANY">
										</c:otherwise>
									</c:choose>
									<fmt:message key="ANY_WORDS" bundle="${storeText}"/>
									</option>
							
									<c:choose>
										<c:when test="${!empty WCParam.searchType && WCParam.searchType=='EXACT'}">
											<option value="EXACT" selected="selected">
										</c:when>
										<c:otherwise>
											<option value="EXACT">
										</c:otherwise>
									</c:choose>
									<fmt:message key="EXACT_PHRASE" bundle="${storeText}"/>
									</option>
								</select>	
							</div>
						</div>
						
						<div class="linked_fields">
							<div class="input_container">
								<div><label for="exclude"><fmt:message key="EXCLUDE_WORDS" bundle="${storeText}"/></label></div>
								<input type="text" id="exclude" name="filterTerm" value="<c:out value='${WCParam.filterTerm}' />" class="coloured_input" />
							</div>	
							
							<div class="dropdown_container">
								<label for="exclude_type"><span style="display:none;"><fmt:message key="SEARCH_EXCLUDE_FILTER" bundle="${storeText}"/></span></label>
								<select id="exclude_type" name="filterType" class="coloured_input">
									<c:choose>
										<c:when test="${!empty WCParam.searchType && WCParam.searchType=='ALL'}">
											<option value="ALL" selected="selected">
										</c:when>
										<c:otherwise>
											<option value="ALL">
										</c:otherwise>
									</c:choose>
									<fmt:message key="ALL_WORDS" bundle="${storeText}"/>
									</option>
								
									<c:choose>
										<c:when test="${!empty WCParam.searchType && WCParam.searchType=='ANY'}">
											<option value="ANY" selected="selected">
										</c:when>
										<c:otherwise>
											<option value="ANY">
										</c:otherwise>
									</c:choose>
									<fmt:message key="ANY_WORDS" bundle="${storeText}"/>
									</option>
							
									<c:choose>
										<c:when test="${!empty WCParam.searchType && WCParam.searchType=='EXACT'}">
												<option value="EXACT" selected="selected">
										</c:when>
										<c:otherwise>
											<option value="EXACT">
										</c:otherwise>
									</c:choose>
									<fmt:message key="EXACT_PHRASE" bundle="${storeText}"/>
									</option>
								</select>	
							</div>
						</div>
						
						<div class="dropdown_container">
							<div><label for="located_in"><fmt:message key="SEARCH_FOR_WORD_IN" bundle="${storeText}"/></label></div>
							<select id="located_in" name="searchTermScope" class="coloured_input">
								<c:choose>
									<c:when test="${!empty WCParam.searchTermScope && WCParam.searchTermScope=='1'}">
										<option value="1" selected="selected">
									</c:when>
									<c:otherwise>
										<option value="1">
									</c:otherwise>
								</c:choose>
											<fmt:message key="PRODUCT_NAME_DESC" bundle="${storeText}"/>
										</option>
								<c:choose>
									<c:when test="${!empty WCParam.searchTermScope && WCParam.searchTermScope=='2'}">
										<option value="2" selected="selected">
									</c:when>
									<c:otherwise>
										<option value="2">
									</c:otherwise>
								</c:choose>
											<fmt:message key="PRODUCT_NAME_ONLY" bundle="${storeText}"/>
										</option>
							</select>
						</div>
						
						<div class="input_container">
							<div><label for="brands"><fmt:message key="SEARCH_BRANDS" bundle="${storeText}"/></label></div>
							<input type="text" id="brands" name="manufacturer" value="<c:out value='${WCParam.manufacturer}' />" class="coloured_input" />
						</div>	
						
						<div class="input_container">
							<div><fmt:message key="PRICE_LABEL" bundle="${storeText}"/></div>
							
							<div class="column">
								<div><label for="from_range"><fmt:message key="FROM" bundle="${storeText}"/></label></div>
								<input type="text" id="from_range" name="minPrice" value="<c:out value='${WCParam.minPrice}' />" class="coloured_input" size="8" />
							</div>
							
							<div class="column">
								<div><label for="to_range"><fmt:message key="TO" bundle="${storeText}"/></label></div>
								<input type="text" id="to_range" name="maxPrice" value="<c:out value='${WCParam.maxPrice}' />" class="coloured_input" size="8" />
							</div>
							<div class="clear_float"></div>
						</div>
						
						<div class="dropdown_container">
							<div><label for="search_in"><fmt:message key="SEARCH_IN1" bundle="${storeText}"/></label></div>
							<select id="search_in" name="search_in" class="coloured_input">
								<option value=""><fmt:message key="ALL_CATEGORIES" bundle="${storeText}"/></option>
									<wcbase:useBean id="catalogSearch" classname="com.ibm.commerce.catalog.beans.CatalogDataBean" />
										<c:forEach var="topCategory" items="${catalogSearch.topCategories}" varStatus="counter">
										<%// Get sub categories for the top category%>
											<c:forEach var="subTopCategory" items="${topCategory.subCategories}" varStatus="subCounter">
												<c:choose>
													<c:when test="${!empty WCParam.categoryId && WCParam.categoryId==subTopCategory.categoryId}">
														<option selected="selected" value="<c:out value="${subTopCategory.categoryId}"/>"><c:out value="${topCategory.description.name}:${subTopCategory.description.name}"/></option>
													</c:when>
													<c:otherwise>
														<option value="<c:out value="${subTopCategory.categoryId}"/>"><c:out value="${topCategory.description.name}:${subTopCategory.description.name}"/></option>
													</c:otherwise>
												</c:choose>
											</c:forEach>
										</c:forEach>
							</select>
						</div>
						
						<div class="dropdown_container">
							<div><label for="results_per_page"><fmt:message key="RESULTS_PER_PAGE" bundle="${storeText}"/></label></div>
							<select id="results_per_page" name="pageSize" class="coloured_input">
								<c:choose>
								<c:when test="${!empty WCParam.pageSize && WCParam.pageSize=='5'}">
									<option value="5" selected="selected">
								</c:when>
								<c:otherwise>
									<option value="5">
								</c:otherwise>
							</c:choose>
								5</option>
							<c:choose>
								<c:when test="${!empty WCParam.pageSize && WCParam.pageSize=='10'}">
									<option value="10" selected="selected">
								</c:when>
								<c:otherwise>
									<option value="10">
								</c:otherwise>
							</c:choose>
								10</option>
							</select>
						</div>						
					</fieldset>
					
					<input type="submit" id="advanced_search_form_submit" name="advanced_search_form_submit" value="Search" onclick="javascript:CatalogSearchDisplayJS.submitAdvancedSearch('advanced_search_form')"/>
				</form>
			</div>

			<%@ include file="../../../include/FooterDisplay.jspf" %>		
			
		</div>
		
	</body>
	
</html>


<!-- END CatalogSearchForm.jsp -->