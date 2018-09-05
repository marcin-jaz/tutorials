<%
//********************************************************************
//*-------------------------------------------------------------------
//* Licensed Materials - Property of IBM
//*
//* WebSphere Commerce
//*
//* (c) Copyright IBM Corp. 2001, 2002, 2004
//*
//* US Government Users Restricted Rights - Use, duplication or
//* disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
//*
//*-------------------------------------------------------------------
//*
%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf"%>

<%--
  *****
  ** This JSP page displays the search results based on the search criteria input by a customer. The following features are supported: 
  **   -- Any invalid searching criteria will be indicated
  **   -- If there is no result found, searching tips will be displayed
  **   -- If there are more than a certain number of searching results, the results will be split into pages. The number of items per page can be specified by a customer.
  **   -- The thumbnail, if any, for each search result will be displayed 
  *****
--%>

<c:remove var="hasDiscount"/>					

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
	<title>
		<fmt:message key="TITLE_SEARCH_RESULTS" bundle="${storeText}"/>
	</title>
	<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${vfileStylesheet}"/>" type="text/css"/>
</head>

<body>
<!-- JSP File Name:  CatalogSearchResultDisplay.jsp -->

<%@ include file="../../../include/LayoutContainerTop.jspf"%>

	<!--MAIN CONTENT STARTS HERE-->
	
	<c:url var="advancedSearchViewUrl" value="AdvancedSearchView">
		<c:param name="langId" value="${langId}"/>
		<c:param name="storeId" value="${WCParam.storeId}"/>
		<c:param name="catalogId" value="${WCParam.catalogId}"/>
	</c:url>

	<%-- 
	  ***
	  * Start - use catEntSearchListBean1 to check for minPriceError or maxPriceError
	  ***
	--%>

	<wcbase:useBean id="catEntSearchListBean1" classname="com.ibm.commerce.search.beans.CatEntrySearchListDataBean"/>
	<jsp:setProperty property="*" name="catEntSearchListBean1" />
	<%-- Pass the minimum price entered by the user to catEntSearchListBean as a search criteria --%>
	<c:set property="minPrice" value="${WCParam.minPrice}" target="${catEntSearchListBean1}"/>
	<%-- Make sure any error triggered by the minimum price is flagged --%>
	<c:if test="${catEntSearchListBean1.minPriceError}">
		<c:set var="errorMinPriceFlag" value="true"/>
	</c:if>
	<%-- Pass the maximum price entered by the user to catEntSearchListBean as a search criteria --%>
	<c:set property="maxPrice" value="${WCParam.maxPrice}" target="${catEntSearchListBean1}"/>
	<%-- Make sure any error triggered by the maximum price is flagged --%>
	<c:if test="${catEntSearchListBean1.maxPriceError}">
		<c:set var="errorMaxPriceFlag" value="true"/>
	</c:if>
	
	<%-- 
	  ***
	  * End - use catEntSearchListBean1 to check for minPriceError or maxPriceError
	  ***
	--%>
	<h1><fmt:message key="TITLE_SEARCH_RESULTS" bundle="${storeText}"/></h1>

	<%-- Examine if the maximum/minimum price input by a customer is valid --%>
	<c:choose>
		<%-- Activate bean only if there is no error in the min and max prices entered --%>
		<c:when test="${errorMinPriceFlag || errorMaxPriceFlag}">

			<%-- Show error messages since maximum/minimum price input by a customer is invalid --%>
			<span class="strong">
				<br/><fmt:message key="SEARCH_NO_RESULTS" bundle="${storeText}"/>
			</span>
			
			<span class="strong"><br/><fmt:message key="SEARCH_ERRORS" bundle="${storeText}"/></span>
			<ul>
				<c:if test="${errorMinPriceFlag == true}">
					<li><span class="error"><c:out value="${WCParam.minPrice}"/></span>&nbsp;<fmt:message key="SEARCH_INVALID_LOW_PRICE" bundle="${storeText}"/></li>
				</c:if>
		
				<c:if test="${errorMaxPriceFlag==true}">
					<li><span class="error"><c:out value="${WCParam.maxPrice}"/></span>&nbsp;<fmt:message key="SEARCH_INVALID_HIGH_PRICE" bundle="${storeText}"/></li>
				</c:if>
			</ul>
			<br/>
			<a href="<c:out value="${advancedSearchViewUrl}" escapeXml="false"/>" id="WC_CatalogSearchResultDisplay_Link_1" class="button">
				<fmt:message key="SEARCH_LINK" bundle="${storeText}"/>
			</a>
				
		</c:when>		
		<c:otherwise>
		
			<%-- 
			  ***
			  * Start - Initialize catEntSearchListBean to look for resultList while no price errors
			  ***
			--%>
			
			<wcbase:useBean id="catEntSearchListBean" scope="page" classname="com.ibm.commerce.search.beans.CatEntrySearchListDataBean" >
				<jsp:setProperty property="*" name="catEntSearchListBean" />
				<%-- Set the kind of Catalog Entries to show --%>
				<c:choose>
					<%-- resultCatEntryType 2 stands for searching product but not item --%>
					<c:when test="${WCParam.resultCatEntryType == 2}">
						<c:set property="isProduct" value="true" target="${catEntSearchListBean}" />
						<c:set property="isItem" value="false" target="${catEntSearchListBean}" />
					</c:when>
					<%-- resultCatEntryType 1 stands for searching item, but not product --%>
					<c:when test="${WCParam.resultCatEntryType == 1}">
						<c:set property="isProduct" value="false" target="${catEntSearchListBean}" />
						<c:set property="isItem" value="true" target="${catEntSearchListBean}" />
					</c:when>
					<%-- Otherwise, search for both item and product --%>
					<c:otherwise>
						<c:set property="isProduct" value="true" target="${catEntSearchListBean}" />
						<c:set property="isItem" value="true" target="${catEntSearchListBean}" />
					</c:otherwise>
				</c:choose>
				
				<%-- always search for bundles and packages --%>
				<c:set property="isBundle" value="true" target="${catEntSearchListBean}" />
				<c:set property="isPackage" value="true" target="${catEntSearchListBean}" />
				<%-- Set the sort order to sort by CatEntDescName --%>
				<c:set property="orderBy1" value="CatEntDescName" target="${catEntSearchListBean}" />
				<%-- Set the search Term --%>
				<%-- setting this property for defect 137532.. This property will be present in the request properties and there is no need to set it here...But if the search page was accessed using http protocol, then this property is available only in this page and it will not be available in the bean..So we need to explicitly set this here --%>
				<c:set property="searchTerm" value="${WCParam.searchTerm}" target="${catEntSearchListBean}" />
			</wcbase:useBean>
			
			<c:if test="${!empty WCParam.catGroupId}">
				<wcbase:useBean id="category" classname="com.ibm.commerce.catalog.beans.CategoryDataBean" scope="page">
					<c:set property="categoryId" value="${WCParam.catGroupId}" target="${category}"/>
				</wcbase:useBean>
			</c:if>

			<%-- total number of search result. This number will be used to decide how many pages
			     should be used to display all the search results
			--%>
			<c:set var="totalCount" value="${catEntSearchListBean.resultCount}"/>
			
			<c:choose>
				<%-- Check if a user specifies where the page should start displaying the result. 
				     For example, if the index is 5, then the first item displayed will be the 
				     6th element(The index starts from 0). The beginIndex will be set when a 
				     user chooses a different search result page.
				--%>				     
				<c:when test="${!empty WCParam.beginIndex}">
					<c:set var="beginIndex" value="${WCParam.beginIndex}"/>
				</c:when>

				<%-- The default begin index is 0. When the search result page is returned for
				     the first time, the page will display the items from the very beginning.
				--%>
				<c:otherwise>
					<c:set var="beginIndex" value="0"/>
				</c:otherwise>
			</c:choose>

			<%-- Now choose how many items should be displayed in a page --%>
			<c:choose>
			    <%-- Use the user-specified number of items per page, if any --%> 
				<c:when test="${!empty WCParam.pageSize}">
					<c:set var="pageSize" value="${WCParam.pageSize}"/>
				</c:when>
				
				<%-- If the user doesn't specify the number of items per page, use 
				     the default on. 
				--%>
				<c:otherwise>
					<c:set var="pageSize" value="10"/>
				</c:otherwise>
			</c:choose>

			<%-- 
			  ***
			  * End - Initialize catEntSearchListBean to look for resultList while no price errors
			  ***
			--%>

			<%-- Check to see if there are no results.  Make sure this is the first set of results --%>
			<c:choose>
				<%-- If there are no items found, only display a message that indicates no item is found --%>
				<c:when test="${empty catEntSearchListBean.resultList || totalCount == 0}">

					<span class="strong">
						<br/><fmt:message key="SEARCH_NO_RESULTS" bundle="${storeText}"/><br/>
					</span>
				
					<br/>
					<h2><fmt:message key="SEARCH_TIPS" bundle="${storeText}"/></h2>
					<ul>
						<li><fmt:message key="SEARCH_TIP1" bundle="${storeText}"/></li>
						<li><fmt:message key="SEARCH_TIP2" bundle="${storeText}"/></li>
						<li><fmt:message key="SEARCH_TIP3" bundle="${storeText}"/></li>
						<li><fmt:message key="SEARCH_TIP4" bundle="${storeText}"/></li>
					</ul>
					<a href="<c:out value="${advancedSearchViewUrl}" escapeXml="false"/>" id="WC_CatalogSearchResultDisplay_Link_2" class="button">
						<fmt:message key="SEARCH_LINK" bundle="${storeText}"/>
					</a>

				</c:when>
                            
				<%-- If there are items in the search result, then first decide how many pages should be used --%>
				<c:otherwise>	

					<br/>
				
					<%-- Output what the user searched on at the top of the search results page --%>
					<fmt:message key="SEARCH_FOR_PRODUCT" bundle="${storeText}" />
				
					<%-- Check if the user entered a search term to search on --%>
					<c:choose>
						<c:when test="${!empty WCParam.searchTerm}">
							<%-- output the search term if the user entered a search term --%>
							<b><c:out value="${WCParam.searchTerm}"/></b>
						</c:when>
						<c:otherwise>
							<%-- output the something else if no search term was searched on --%>
							<b><fmt:message key="SEARCH_ALL_PRODUCTS" bundle="${storeText}"/></b>
						</c:otherwise>
					</c:choose>
				
					<%-- Check if the user entered a excluded search term to search on --%>
					<c:if test="${!empty WCParam.filterTerm}">
						<%-- output the filter term --%>
						<fmt:message key="SEARCH_EXCLUDING" bundle="${storeText}"/>&nbsp;<b><c:out value="${WCParam.filterTerm}"/></b>
					</c:if>
				
					<%-- Check if the user entered a category to searh in--%>
					<c:if test="${!empty WCParam.catGroupId}">
						<%-- output the category --%>
						<fmt:message key="SEARCH_CATEGORY" bundle="${storeText}">
							<fmt:param><b><c:out value="${category.description.name}" escapeXml="false"/></b></fmt:param>
						</fmt:message>
					</c:if>
				
					<%-- Check if the user entered a maximum and/or minimum price to search on --%>
					<%-- Get the currency description for the selected currency --%>
					<c:forEach var="dbCurrency" items="${sdb.storeCurrencies}">
						<c:if test="${dbCurrency.currencyCode == CommandContext.currency}">
							<c:set var="currDesc" value="${dbCurrency.currencyDescription}" />
						</c:if>
					</c:forEach>
				
					<c:choose>
						<%-- If a user enters the valid minimum price range and the maximum price range, 
						     then print out the price range
						--%>
						<c:when test="${!empty WCParam.minPrice && !empty WCParam.maxPrice}">
							<fmt:message key="SEARCH_PRICE_RANGE" bundle="${storeText}">
								<fmt:param><b><c:out value="${WCParam.minPrice}" escapeXml="false"/></b></fmt:param>
								<fmt:param><b><c:out value="${WCParam.maxPrice}" escapeXml="false"/></b></fmt:param>
								<fmt:param><c:out value="${currDesc}" escapeXml="false"/></fmt:param>
							</fmt:message>
						</c:when>
				
						<%-- Only print out the minimum price if the user doesn't enter the maximum price --%>	
						<c:when test="${!empty WCParam.minPrice && empty WCParam.maxPrice}">
							<fmt:message key="SEARCH_PRICE_RANGE_FROM" bundle="${storeText}">
								<fmt:param><b><c:out value="${WCParam.minPrice}" escapeXml="false"/></b></fmt:param>
								<fmt:param><c:out value="${currDesc}" escapeXml="false"/></fmt:param>
							</fmt:message>
						</c:when>
						
						<%-- Only print out the maximum price if the user doesn't enter the minim price --%>	
						<c:when test="${empty WCParam.minPrice && !empty WCParam.maxPrice}">
							<fmt:message key="SEARCH_PRICE_RANGE_UP_TO" bundle="${storeText}">
								<fmt:param><b><c:out value="${WCParam.maxPrice}" escapeXml="false"/></b></fmt:param>
								<fmt:param><c:out value="${currDesc}" escapeXml="false"/></fmt:param>
							</fmt:message>
						</c:when>
					</c:choose>
					
					<%-- Display the total number of found items --%>
					<fmt:message key="SEARCH_PRODUCED" bundle="${storeText}">
						<fmt:param><b><c:out value="${totalCount}" escapeXml="false"/></b></fmt:param>
					</fmt:message>	
					<br/>
				
					<%-- Display a sentence with a link to Advanced Search --%>
					<fmt:message key="SEARCH_REFINE_SEARCH" bundle="${storeText}">
						<fmt:param><a href="<c:out value="${advancedSearchViewUrl}" escapeXml="false"/>" id="WC_CategorySearchResult_AdvancedSearchLink_1"><fmt:message key="SEARCH_ADVANCED_SEARCH" bundle="${storeText}"/></a></fmt:param>
					</fmt:message>
					<br/><br/>

					<c:set var="resultCountOnPage" value="${catEntSearchListBean.pageSize + beginIndex}"/>
					<c:choose>
						<c:when test="${resultCountOnPage > totalCount}">
							<c:set var="resultCountOnPage" value="${totalCount}"/>
						</c:when>
					</c:choose>
					<fmt:message var="resultsText" key="SEARCH_RESULT_LIST" bundle="${storeText}">
						<fmt:param value="${beginIndex+1}"/>
						<fmt:param value="${resultCountOnPage}"/>
						<fmt:param value="${totalCount}"/>
					</fmt:message>
					
					<c:set var="prevPageIndex" value="${catEntSearchListBean.beginIndex - catEntSearchListBean.pageSize}"/>
					<c:choose>
						<c:when test="${!catEntSearchListBean.previousPageExists}">
							<c:set var="prevPageIndex" value="0"/>
						</c:when>
					</c:choose>
					<c:set var="nextPageIndex" value="${catEntSearchListBean.endIndex + 1}"/>
					<c:choose>
						<c:when test="${!catEntSearchListBean.nextPageExists}">
							<c:set var="nextPageIndex" value="${catEntSearchListBean.beginIndex}"/>
						</c:when>
					</c:choose>
					
					<form name="OrderItemAddForm" action="" method="post" id="OrderItemAddForm">
						<input type="hidden" name="storeId" value="<c:out value="${WCParam.storeId}" />" id="WC_CatalogSearchResultDisplay_FormInput_storeId_In_OrderItemAddForm_1"/>
						<input type="hidden" name="langId" value="<c:out value="${langId}" />" id="WC_CatalogSearchResultDisplay_FormInput_langId_In_OrderItemAddForm_1"/>
						<input type="hidden" name="catalogId" value="<c:out value="${WCParam.catalogId}" />" id="WC_CatalogSearchResultDisplay_FormInput_catalogId_In_OrderItemAddForm_1"/>
						<input type="hidden" name="orderId" value="." id="WC_CatalogSearchResultDisplay_FormInput_orderId_In_OrderItemAddForm_1"/>
						<input type="hidden" name="URL" value="OrderCalculate?URL=OrderItemDisplay" id="WC_CatalogSearchResultDisplay_FormInput_URL_In_OrderItemAddForm_1"/>
						<input type="hidden" name="errorViewName" value="ProductDisplayErrorView" id="WC_CatalogSearchResultDisplay_FormInput_errorViewName_In_OrderItemAddForm_1"/>
						<input type="hidden" name="catEntryId" value="<c:out value="${productId}" />" id="WC_CatalogSearchResultDisplay_FormInput_catEntryId_In_OrderItemAddForm_1"/>
						<input type="hidden" name="calculationUsageId" value="-1" id="WC_CatalogSearchResultDisplay_FormInput_calculationUsageId_In_OrderItemAddForm_1"/>
						<input type="hidden" name="quantity" value="1" id="WC_CatalogSearchResultDisplay_FormInput_quantity_In_OrderItemAddForm_1"/>
						<%-- shouldCachePage is used to tell the server not to cache this page.  So if an error happens, this page is redrawn with an error message --%>
						<input type="hidden" name="shouldCachePage" value="false" id="WC_CatalogSearchResultDisplay_FormInput_shouldCachePage_In_OrderItemAddForm_1"/>
					</form>
					
					<c:choose>
						<c:when test="${WCParam.sType == 'AdvancedSearch'}"> 							

							<c:url value="CatalogSearchResultView" var="CatalogSearchResultViewFirstURL">
								<c:param name="storeId" value="${WCParam.storeId}"/>
								<c:param name="langId" value="${langId}"/>
								<c:param name="catalogId" value="${WCParam.catalogId}"/>
								<c:param name="searchTerm" value="${WCParam.searchTerm}"/>
								<c:param name="resultCatEntryType" value="${WCParam.resultCatEntryType}"/>
								<c:param name="searchType" value="${WCParam.searchType}"/>
								<c:param name="searchTermCaseSensitive" value="${WCParam.searchTermCaseSensitive}"/>
								<c:param name="searchTermOperator" value="${WCParam.searchTermOperator}"/>
								<c:param name="filterTerm" value="${WCParam.filterTerm}"/>
								<c:param name="filterType" value="${WCParam.filterType}"/>
								<c:param name="filterTermCaseSensitive" value="${WCParam.filterTermCaseSensitive}"/>
								<c:param name="filterTermOperator" value="${WCParam.filterTermOperator}"/>
								<c:param name="searchTermScope" value="${WCParam.searchTermScope}"/>
								<c:param name="catGroupId" value="${WCParam.catGroupId}"/>
								<c:param name="categoryType" value="${WCParam.categoryType}"/>
								<c:param name="qtyAvailable" value="${WCParam.qtyAvailable}"/>
								<c:param name="qtyAvailableOperator" value="${WCParam.qtyAvailableOperator}"/>
								<c:param name="qtyMeasure" value="${WCParam.qtyMeasure}"/>
								<c:param name="qtyMeasureCaseSensitive" value="${WCParam.qtyMeasureCaseSensitive}"/>
								<c:param name="qtyMeasureOperator" value="${WCParam.qtyMeasureOperator}"/>
								<c:param name="pageSize" value="${pageSize}"/>
								<c:param name="beginIndex" value="0"/>
								<c:param name="sType" value="${WCParam.sType}"/>
								<c:param name="minPrice" value="${WCParam.minPrice}"/>
								<c:param name="maxPrice" value="${WCParam.maxPrice}"/>
							</c:url>
							
							<c:url value="CatalogSearchResultView" var="CatalogSearchResultViewPrevURL">
								<c:param name="storeId" value="${WCParam.storeId}"/>
								<c:param name="langId" value="${langId}"/>
								<c:param name="catalogId" value="${WCParam.catalogId}"/>
								<c:param name="searchTerm" value="${WCParam.searchTerm}"/>
								<c:param name="resultCatEntryType" value="${WCParam.resultCatEntryType}"/>
								<c:param name="searchType" value="${WCParam.searchType}"/>
								<c:param name="searchTermCaseSensitive" value="${WCParam.searchTermCaseSensitive}"/>
								<c:param name="searchTermOperator" value="${WCParam.searchTermOperator}"/>
								<c:param name="filterTerm" value="${WCParam.filterTerm}"/>
								<c:param name="filterType" value="${WCParam.filterType}"/>
								<c:param name="filterTermCaseSensitive" value="${WCParam.filterTermCaseSensitive}"/>
								<c:param name="filterTermOperator" value="${WCParam.filterTermOperator}"/>
								<c:param name="searchTermScope" value="${WCParam.searchTermScope}"/>
								<c:param name="catGroupId" value="${WCParam.catGroupId}"/>
								<c:param name="categoryType" value="${WCParam.categoryType}"/>
								<c:param name="qtyAvailable" value="${WCParam.qtyAvailable}"/>
								<c:param name="qtyAvailableOperator" value="${WCParam.qtyAvailableOperator}"/>
								<c:param name="qtyMeasure" value="${WCParam.qtyMeasure}"/>
								<c:param name="qtyMeasureCaseSensitive" value="${WCParam.qtyMeasureCaseSensitive}"/>
								<c:param name="qtyMeasureOperator" value="${WCParam.qtyMeasureOperator}"/>
								<c:param name="pageSize" value="${pageSize}"/>
								<c:param name="beginIndex" value="${prevPageIndex}"/>
								<c:param name="sType" value="${WCParam.sType}"/>
								<c:param name="minPrice" value="${WCParam.minPrice}"/>
								<c:param name="maxPrice" value="${WCParam.maxPrice}"/>
							</c:url>
							
							<c:url value="CatalogSearchResultView" var="CatalogSearchResultViewNextURL">
								<c:param name="storeId" value="${WCParam.storeId}"/>
								<c:param name="langId" value="${langId}"/>
								<c:param name="catalogId" value="${WCParam.catalogId}"/>
								<c:param name="searchTerm" value="${WCParam.searchTerm}"/>
								<c:param name="resultCatEntryType" value="${WCParam.resultCatEntryType}"/>
								<c:param name="searchType" value="${WCParam.searchType}"/>
								<c:param name="searchTermCaseSensitive" value="${WCParam.searchTermCaseSensitive}"/>
								<c:param name="searchTermOperator" value="${WCParam.searchTermOperator}"/>
								<c:param name="filterTerm" value="${WCParam.filterTerm}"/>
								<c:param name="filterType" value="${WCParam.filterType}"/>
								<c:param name="filterTermCaseSensitive" value="${WCParam.filterTermCaseSensitive}"/>
								<c:param name="filterTermOperator" value="${WCParam.filterTermOperator}"/>
								<c:param name="searchTermScope" value="${WCParam.searchTermScope}"/>
								<c:param name="catGroupId" value="${WCParam.catGroupId}"/>
								<c:param name="categoryType" value="${WCParam.categoryType}"/>
								<c:param name="qtyAvailable" value="${WCParam.qtyAvailable}"/>
								<c:param name="qtyAvailableOperator" value="${WCParam.qtyAvailableOperator}"/>
								<c:param name="qtyMeasure" value="${WCParam.qtyMeasure}"/>
								<c:param name="qtyMeasureCaseSensitive" value="${WCParam.qtyMeasureCaseSensitive}"/>
								<c:param name="qtyMeasureOperator" value="${WCParam.qtyMeasureOperator}"/>
								<c:param name="pageSize" value="${pageSize}"/>
								<c:param name="beginIndex" value="${nextPageIndex}"/>
								<c:param name="sType" value="${WCParam.sType}"/>
								<c:param name="minPrice" value="${WCParam.minPrice}"/>
								<c:param name="maxPrice" value="${WCParam.maxPrice}"/>
							</c:url>
							<c:url value="CatalogSearchResultView" var="CatalogSearchResultViewLastURL">
								<c:param name="storeId" value="${WCParam.storeId}"/>
								<c:param name="langId" value="${langId}"/>
								<c:param name="catalogId" value="${WCParam.catalogId}"/>
								<c:param name="searchTerm" value="${WCParam.searchTerm}"/>
								<c:param name="resultCatEntryType" value="${WCParam.resultCatEntryType}"/>
								<c:param name="searchType" value="${WCParam.searchType}"/>
								<c:param name="searchTermCaseSensitive" value="${WCParam.searchTermCaseSensitive}"/>
								<c:param name="searchTermOperator" value="${WCParam.searchTermOperator}"/>
								<c:param name="filterTerm" value="${WCParam.filterTerm}"/>
								<c:param name="filterType" value="${WCParam.filterType}"/>
								<c:param name="filterTermCaseSensitive" value="${WCParam.filterTermCaseSensitive}"/>
								<c:param name="filterTermOperator" value="${WCParam.filterTermOperator}"/>
								<c:param name="searchTermScope" value="${WCParam.searchTermScope}"/>
								<c:param name="catGroupId" value="${WCParam.catGroupId}"/>
								<c:param name="categoryType" value="${WCParam.categoryType}"/>
								<c:param name="qtyAvailable" value="${WCParam.qtyAvailable}"/>
								<c:param name="qtyAvailableOperator" value="${WCParam.qtyAvailableOperator}"/>
								<c:param name="qtyMeasure" value="${WCParam.qtyMeasure}"/>
								<c:param name="qtyMeasureCaseSensitive" value="${WCParam.qtyMeasureCaseSensitive}"/>
								<c:param name="qtyMeasureOperator" value="${WCParam.qtyMeasureOperator}"/>
								<c:param name="pageSize" value="${pageSize}"/>
								<c:param name="beginIndex" value="${(catEntSearchListBean.totalNumberOfResultSetPages-1) * catEntSearchListBean.pageSize}"/>
								<c:param name="sType" value="${WCParam.sType}"/>
								<c:param name="minPrice" value="${WCParam.minPrice}"/>
								<c:param name="maxPrice" value="${WCParam.maxPrice}"/>
							</c:url>
			
			                      	</c:when>
						<c:otherwise>
						
							<c:url value="CatalogSearchResultView" var="CatalogSearchResultViewFirstURL">
								<c:param name="storeId" value="${WCParam.storeId}"/>
								<c:param name="langId" value="${langId}"/>
								<c:param name="catalogId" value="${WCParam.catalogId}"/>
								<c:param name="searchTerm" value="${WCParam.searchTerm}"/>
								<c:param name="resultCatEntryType" value="${WCParam.resultCatEntryType}"/>
								<c:param name="pageSize" value="${pageSize}"/>
								<c:param name="beginIndex" value="0"/>
								<c:param name="sType" value="${WCParam.sType}"/>
								<c:param name="searchTermScope" value="${WCParam.searchTermScope}"/>
							</c:url>
							<c:url value="CatalogSearchResultView" var="CatalogSearchResultViewPrevURL">
								<c:param name="storeId" value="${WCParam.storeId}"/>
								<c:param name="langId" value="${langId}"/>
								<c:param name="catalogId" value="${WCParam.catalogId}"/>
								<c:param name="searchTerm" value="${WCParam.searchTerm}"/>
								<c:param name="resultCatEntryType" value="${WCParam.resultCatEntryType}"/>
								<c:param name="pageSize" value="${pageSize}"/>
								<c:param name="beginIndex" value="${prevPageIndex}"/>
								<c:param name="sType" value="${WCParam.sType}"/>
								<c:param name="searchTermScope" value="${WCParam.searchTermScope}"/>
							</c:url>
							<c:url value="CatalogSearchResultView" var="CatalogSearchResultViewNextURL">
								<c:param name="storeId" value="${WCParam.storeId}"/>
								<c:param name="langId" value="${langId}"/>
								<c:param name="catalogId" value="${WCParam.catalogId}"/>
								<c:param name="searchTerm" value="${WCParam.searchTerm}"/>
								<c:param name="resultCatEntryType" value="${WCParam.resultCatEntryType}"/>
								<c:param name="pageSize" value="${pageSize}"/>
								<c:param name="beginIndex" value="${nextPageIndex}"/>
								<c:param name="sType" value="${WCParam.sType}"/>
								<c:param name="searchTermScope" value="${WCParam.searchTermScope}"/>
							</c:url>
							<c:url value="CatalogSearchResultView" var="CatalogSearchResultViewLastURL">
								<c:param name="storeId" value="${WCParam.storeId}"/>
								<c:param name="langId" value="${langId}"/>
								<c:param name="catalogId" value="${WCParam.catalogId}"/>
								<c:param name="searchTerm" value="${WCParam.searchTerm}"/>
								<c:param name="resultCatEntryType" value="${WCParam.resultCatEntryType}"/>
								<c:param name="pageSize" value="${pageSize}"/>
								<c:param name="beginIndex" value="${(catEntSearchListBean.totalNumberOfResultSetPages-1) * catEntSearchListBean.pageSize}"/>
								<c:param name="sType" value="${WCParam.sType}"/>
								<c:param name="searchTermScope" value="${WCParam.searchTermScope}"/>
							</c:url>
						</c:otherwise>
					</c:choose>
	
					<form name="JumpToPageForm" action="CatalogSearchResultView" method="post" id="JumpToPageForm">

						<input type="hidden" name="storeId" value="<c:out value="${WCParam.storeId}" />" id="WC_CatalogSearchResultDisplay_FormInput_storeId_In_JumpToPageForm_1"/>
						<input type="hidden" name="langId" value="<c:out value="${langId}" />" id="WC_CatalogSearchResultDisplay_FormInput_langId_In_JumpToPageForm_1"/>
						<input type="hidden" name="catalogId" value="<c:out value="${WCParam.catalogId}" />" id="WC_CatalogSearchResultDisplay_FormInput_catalogId_In_JumpToPageForm_1"/>
						<input type="hidden" name="searchTerm" value="<c:out value="${WCParam.searchTerm}" />" id="WC_CatalogSearchResultDisplay_FormInput_searchTermScope_In_JumpToPageForm_1"/>
						<input type="hidden" name="resultCatEntryType" value="<c:out value="${WCParam.resultCatEntryType}" />" id="WC_CatalogSearchResultDisplay_FormInput_resultCatEntryType_In_JumpToPageForm_1"/>
						<input type="hidden" name="pageSize" value="<c:out value="${pageSize}" />" id="WC_CatalogSearchResultDisplay_FormInput_pageSize_In_JumpToPageForm_1"/>
						<input type="hidden" name="beginIndex" value="0" id="WC_CatalogSearchResultDisplay_FormInput_beginIndex_In_JumpToPageForm_1"/>
						<input type="hidden" name="sType" value="<c:out value="${WCParam.sType}" />" id="WC_CatalogSearchResultDisplay_FormInput_sType_In_JumpToPageForm_1"/>
						<input type="hidden" name="searchTermScope" value="<c:out value="${WCParam.searchTermScope}" />" id="WC_CatalogSearchResultDisplay_FormInput_searchTermScope_In_JumpToPageForm_1"/>

						<c:if test="${WCParam.sType == 'AdvancedSearch'}"> 							
							<input type="hidden" name="searchType" value="<c:out value="${WCParam.searchType}" />" id="WC_CatalogSearchResultDisplay_FormInput_searchType_In_JumpToPageForm_1"/>
							<input type="hidden" name="searchTermCaseSensitive" value="<c:out value="${WCParam.searchTermCaseSensitive}" />" id="WC_CatalogSearchResultDisplay_FormInput_searchTermCaseSensitive_In_JumpToPageForm_1"/>
							<input type="hidden" name="searchTermOperator" value="<c:out value="${WCParam.searchTermOperator}" />" id="WC_CatalogSearchResultDisplay_FormInput_searchTermOperator_In_JumpToPageForm_1"/>
							<input type="hidden" name="filterTerm" value="<c:out value="${WCParam.filterTerm}" />" id="WC_CatalogSearchResultDisplay_FormInput_filterTerm_In_JumpToPageForm_1"/>
							<input type="hidden" name="filterType" value="<c:out value="${WCParam.filterType}" />" id="WC_CatalogSearchResultDisplay_FormInput_filterType_In_JumpToPageForm_1"/>
							<input type="hidden" name="filterTermCaseSensitive" value="<c:out value="${WCParam.filterTermCaseSensitive}" />" id="WC_CatalogSearchResultDisplay_FormInput_filterTermCaseSensitive_In_JumpToPageForm_1"/>
							<input type="hidden" name="filterTermOperator" value="<c:out value="${WCParam.filterTermOperator}" />" id="WC_CatalogSearchResultDisplay_FormInput_filterTermOperator_In_JumpToPageForm_1"/>
							<input type="hidden" name="catGroupId" value="<c:out value="${WCParam.catGroupId}" />" id="WC_CatalogSearchResultDisplay_FormInput_catGroupId_In_JumpToPageForm_1"/>
							<input type="hidden" name="categoryType" value="<c:out value="${WCParam.categoryType}" />" id="WC_CatalogSearchResultDisplay_FormInput_categoryType_In_JumpToPageForm_1"/>
							<input type="hidden" name="qtyAvailable" value="<c:out value="${WCParam.qtyAvailable}" />" id="WC_CatalogSearchResultDisplay_FormInput_qtyAvailable_In_JumpToPageForm_1"/>
							<input type="hidden" name="qtyAvailableOperator" value="<c:out value="${WCParam.qtyAvailableOperator}" />" id="WC_CatalogSearchResultDisplay_FormInput_qtyAvailableOperator_In_JumpToPageForm_1"/>
							<input type="hidden" name="qtyMeasure" value="<c:out value="${WCParam.qtyMeasure}" />" id="WC_CatalogSearchResultDisplay_FormInput_qtyMeasure_In_JumpToPageForm_1"/>
							<input type="hidden" name="qtyMeasureCaseSensitive" value="<c:out value="${WCParam.qtyMeasureCaseSensitive}" />" id="WC_CatalogSearchResultDisplay_FormInput_qtyMeasureCaseSensitive_In_JumpToPageForm_1"/>
							<input type="hidden" name="qtyMeasureOperator" value="<c:out value="${WCParam.qtyMeasureOperator}" />" id="WC_CatalogSearchResultDisplay_FormInput_qtyMeasureOperator_In_JumpToPageForm_1"/>
							<input type="hidden" name="minPrice" value="<c:out value="${WCParam.minPrice}" />" id="WC_CatalogSearchResultDisplay_FormInput_minPrice_In_JumpToPageForm_1"/>
							<input type="hidden" name="maxPrice" value="<c:out value="${WCParam.maxPrice}" />" id="WC_CatalogSearchResultDisplay_FormInput_maxPrice_In_JumpToPageForm_1"/>
                     	</c:if>

					<table cellpadding="0" cellspacing="0" border="0" width="100%" class="t_table" id="WC_CatalogSearchResultDisplay_Table_1">
						<tr>
							<td id="WC_CatalogSearchResultDisplay_TableCell_11">
								<table cellpadding="2" cellspacing="0" border="0" id="WC_CatalogSearchResultDisplay_Table_2">
									<tr>
										<td id="WC_CatalogSearchResultDisplay_TableCell_201"><a href="<c:out value="${CatalogSearchResultViewFirstURL}" />" id="WC_CatalogSearchResultDisplay_Link_1"><img src="<c:out value="${jspStoreImgDir}${vfileColor}"/>ps_first.gif" alt="" width="14" height="14" border="0"></a></td>
										<td class="ps_pad" id="WC_CatalogSearchResultDisplay_TableCell_202"><a href="<c:out value="${CatalogSearchResultViewPrevURL}" />" id="WC_CatalogSearchResultDisplay_Link_2"><img src="<c:out value="${jspStoreImgDir}${vfileColor}"/>ps_previous.gif" alt="" width="14" height="14" border="0"></a></td>
										<fmt:message var="pageNumberText" key="PAGE_NUMBER" bundle="${storeText}">
											<fmt:param><c:out value="${catEntSearchListBean.currentPageNumber}" /></fmt:param>
											<fmt:param><c:out value="${catEntSearchListBean.totalNumberOfResultSetPages}" /></fmt:param>
										</fmt:message>
										<td class="ps_text" id="WC_CatalogSearchResultDisplay_TableCell_203"><c:out value="${pageNumberText}" /></td>
										<td class="ps_pad" id="WC_CatalogSearchResultDisplay_TableCell_204"><a href="<c:out value="${CatalogSearchResultViewNextURL}" />" id="WC_CatalogSearchResultDisplay_Link_3"><img src="<c:out value="${jspStoreImgDir}${vfileColor}"/>ps_next.gif" alt="" width="14" height="14" border="0"></a></td>
										<td class="ps_pad" id="WC_CatalogSearchResultDisplay_TableCell_205"><a href="<c:out value="${CatalogSearchResultViewLastURL}" />" id="WC_CatalogSearchResultDisplay_Link_4"><img src="<c:out value="${jspStoreImgDir}${vfileColor}"/>ps_last.gif" alt="" width="14" height="14" border="0"></a></td>
										<td class="ps_text" id="WC_CatalogSearchResultDisplay_TableCell_206"><label for="WC_CatalogSearchResult_JumpToPage"><fmt:message key="JUMP_TO_PAGE" bundle="${storeText}"/></label></td>
										<td class="ps_pad" id="WC_CatalogSearchResultDisplay_TableCell_207"><input type="text" maxlength="4" size="3" class="ps_input" name="jumpToPage" id="WC_CatalogSearchResult_JumpToPage"></td>
										<td class="ps_pad" id="WC_CatalogSearchResultDisplay_TableCell_208"><a href="javascript:submitSearch(document.JumpToPageForm);" id="WC_CatalogSearchResultDisplay_Link_5"><img src="<c:out value="${jspStoreImgDir}${vfileColor}"/>ps_page_jump.gif" alt="" width="16" height="16" border="0"></a></td>
									</tr>
								</table>
							</td>
							<td align="right" id="WC_CatalogSearchResultDisplay_TableCell_12">
								<table cellpadding="2" cellspacing="0" border="0" id="WC_CatalogSearchResultDisplay_Table_3">
									<tr>
										<td class="ps_text" id="WC_CatalogSearchResultDisplay_TableCell_301"><c:out value="${resultsText}" /></td>
									</tr>
								</table>
							</td>
						</tr>						
					</table>
					</form>
					
				        <!-- Start search result table -->
					<table cellpadding="2" cellspacing="1" border="0" class="bgColor" id="WC_CatalogSearchResultDisplay_Table_4">
						<tr>
							<th class="colHeader" id="WC_CatalogSearchResultDisplay_DescHeader"><fmt:message key="SEARCH_DESCRIPTION" bundle="${storeText}" /></th>
							<th class="colHeader_price" width="15%" id="WC_CatalogSearchResultDisplay_PriceHeader"><fmt:message key="SEARCH_PRICE" bundle="${storeText}"/></th>
							<th class="colHeader_last" width="15%" id="WC_CatalogSearchResultDisplay_OrderHeader"></th>
						</tr>
						<c:forEach var="catEntry" items="${catEntSearchListBean.resultList}" varStatus="counter">
							<c:set property="commandContext" value="${catEntSearchListBean.commandContext}" target="${catEntry}"/>
							<c:choose>
								<c:when test="${catEntry.product}">
									<%-- convert the catEntry to the product bean --%>
									<c:set var="product" value="${catEntry.productDataBean}"/>
									<tr>
										<td headers="WC_CatalogSearchResultDisplay_DescHeader" valign="top" width="70%" class="t_td" id="WC_CatalogSearchResultDisplay_TableCell_13_<c:out value="${counter.count}"/>">
										<%-- The URL that links to the product display page --%>
							                        <c:url var="productDisplayUrl" value="ProductDisplay">
							                                <c:param name="catalogId" value="${WCParam.catalogId}"/>
							                                <c:param name="storeId" value="${WCParam.storeId}"/>
							                                <c:param name="productId" value="${product.productID}"/>
							                                <c:param name="langId" value="${langId}"/>
							                        </c:url>
							                        <table id="WC_CatalogSearchResultDisplay_Table_5_<c:out value="${counter.count}"/>">
							                        	<tr>
												<td valign="top" id="WC_CachedStoreCatalogDisplay_TableCell_14_<c:out value="${counter.count}"/>">
													<a href="<c:out value="${productDisplayUrl}"/>" id="WC_CatalogSearchResultDisplay_Link_ForProductImg_<c:out value="${counter.count}"/>">
														<c:choose>
															<c:when test="${!empty product.description.thumbNail}">
																<span class="t_img_border"><img src="<c:out value="${product.objectPath}"/><c:out value="${product.description.thumbNail}"/>" alt="<c:out value="${product.description.shortDescription}"/>" border="0"/></span>
															</c:when>
															<c:otherwise>
																<img src="<c:out value="${jspStoreImgDir}" />images/NoImageIcon_sm.jpg" alt="<fmt:message key="No_Image" bundle="${storeText}"/>" border="0"/>
															</c:otherwise>
														</c:choose>
													</a>
												</td>
												<td valign="top" id="WC_CachedStoreCatalogDisplay_TableCell_15_<c:out value="${counter.count}"/>">
													<a href="<c:out value="${productDisplayUrl}"/>" id="WC_CatalogSearchResultDisplay_Link_6_<c:out value="${counter.count}"/>">
														<c:out value="${product.description.name}" escapeXml="false"/>
													</a>
													<br />
													<c:out value="${product.description.longDescription}" escapeXml="false"/>
												</td>
											</tr>
										</table>
										</td>
										<td headers="WC_CatalogSearchResultDisplay_PriceHeader" valign="top" align="right" class="t_td" id="WC_CachedStoreCatalogDisplay_TableCell_16_<c:out value="${counter.count}"/>">
											<%-- Determine what price is to be displayed --%>
								    			<c:choose>
												<%-- If there is no price for any of the product items, the product is not
												     buyable. Therefore, there will be no available price
												--%>
												<c:when test="${empty product.minimumItemPrice}">
													<c:set var="productPriceString"><fmt:message key="NO_PRICE_AVAILABLE" bundle="${storeText}" /></c:set>
												</c:when>
												
												<%-- If there is no price range but there is item price for the product, then
												     the item price will be displayed. 
												--%>			
												<c:when test="${ product.maximumItemPrice.amount == product.minimumItemPrice.amount}" >
													<c:set var="productPriceString" value="${product.minimumItemPrice}" />
												</c:when>
											
											    	<%-- If there is price range for the product items, the price range will be displayed --%>
												<c:otherwise>
													<c:set var="productPriceString" value="${product.minimumItemPrice} - ${product.maximumItemPrice}" />
												</c:otherwise>
											</c:choose>							
											
											<%-- Determine if the list price will be displayed along with the product's offer price --%>
											<c:choose>
												<%-- show the list price only if it is larger than the product price and the product does not have price range (i.e. min price == max price) --%>
												<c:when test="${ product.listPriced && (!empty product.maximumItemPrice) && (product.maximumItemPrice.amount < product.listPrice.amount) && (product.maximumItemPrice.amount == product.minimumItemPrice.amount)}" >
													<%-- 
													The empty gif are put in front of the prices so that the alt text can be read by the IBM Homepage Reader to describe the two prices displayed. 
													These descriptions are necessary for meeting Accessibility requirements 
													--%>
													<a href="#" id="WC_CatalogSearchResultDisplay_Link_7_<c:out value="${counter.count}"/>"><img src="<c:out value="${jspStoreImgDir}" />images/empty.gif" alt='<fmt:message key="RegularPriceIs" bundle="${storeText}" />' width="1" height="1" border="0"/></a>
													<span class="listPrice"><c:out value="${product.listPrice}" escapeXml="false"/></span>
													<br />
													<%-- 
													The empty gif are put in front of the prices so that the alt text can be read by the IBM Homepage Reader to describe the two prices displayed. 
													These descriptions are necessary for meeting Accessibility requirements 
													--%>
													<a href="#" id="WC_CatalogSearchResultDisplay_Link_8_<c:out value="${counter.count}"/>"><img src="<c:out value="${jspStoreImgDir}" />images/empty.gif" alt='<fmt:message key="SalePriceIs" bundle="${storeText}" />' width="1" height="1" border="0"/></a>
													<span class="redPrice"><c:out value="${productPriceString}" escapeXml="false"/></span>
												</c:when>
												
												<c:otherwise>
													<%-- 
													The empty gif are put in front of the prices so that the alt text can be read by the IBM Homepage Reader to describe the two prices displayed. 
													These descriptions are necessary for meeting Accessibility requirements 
													--%>
													<a href="#" id="WC_CatalogSearchResultDisplay_Link_9_<c:out value="${counter.count}"/>"><img src="<c:out value="${jspStoreImgDir}" />images/empty.gif" alt='<fmt:message key="PriceIs" bundle="${storeText}" />' width="1" height="1" border="0"/></a>
													<span class="price"><c:out value="${productPriceString}" escapeXml="false"/></span>
												</c:otherwise>
											</c:choose>
										</td>
										<td headers="WC_CatalogSearchResultDisplay_OrderHeader" class="t_td" id="WC_CachedStoreCatalogDisplay_TableCell_17_<c:out value="${counter.count}"/>">
										
										</td>
									</tr>
								</c:when>	
								<c:when test="${catEntry.item}">
									<c:set var="item" value="${catEntry.itemDataBean}"/>
									<tr>
										<td headers="WC_CatalogSearchResultDisplay_DescHeader" valign="top" class="t_td" width="70%" id="WC_CatalogSearchResultDisplay_TableCell_18_<c:out value="${counter.count}"/>">
											<%-- The URL that links to the product display page for the item --%>
								                        <c:url var="itemDisplayUrl" value="ProductDisplay">
								                                <c:param name="catalogId" value="${WCParam.catalogId}"/>
								                                <c:param name="storeId" value="${WCParam.storeId}"/>
								                                <c:param name="productId" value="${item.itemID}"/>
								                                <c:param name="langId" value="${langId}"/>
								                        </c:url>
											<table id="WC_CatalogSearchResultDisplay_Table_6_<c:out value="${counter.count}"/>">
							                        		<tr>
												<td valign="top" id="WC_CachedStoreCatalogDisplay_TableCell_19_<c:out value="${counter.count}"/>">
													<a href="<c:out value="${itemDisplayUrl}"/>" id="WC_CatalogSearchResultDisplay_Link_ForItemImg_<c:out value="${counter.count}"/>">
														<c:choose>
															<c:when test="${!empty item.description.thumbNail}">
																<span class="t_img_border"><img src="<c:out value="${item.objectPath}"/><c:out value="${item.description.thumbNail}"/>" alt="<c:out value="${item.description.shortDescription}"/>" border="0"/></span>
															</c:when>
															<c:otherwise>
																<img src="<c:out value="${jspStoreImgDir}" />images/NoImageIcon_sm.jpg" alt="<fmt:message key="No_Image" bundle="${storeText}"/>" border="0"/>
															</c:otherwise>
														</c:choose>
													</a>
												</td>
												<td valign="top" id="WC_CachedStoreCatalogDisplay_TableCell_20_<c:out value="${counter.count}"/>">
													<a href="<c:out value="${itemDisplayUrl}"/>" id="WC_CatalogSearchResultDisplay_Link_10_<c:out value="${counter.count}"/>">
														<c:out value="${item.description.name}" escapeXml="false"/>
													</a>
													<br />
													<span class="text"><fmt:message key="SKU" bundle="${storeText}" />:</span> <span class="text"><c:out value="${item.partNumber}" /></span>
													<br /><br />
													<c:out value="${item.description.longDescription}" escapeXml="false"/>
												</td>
												</tr>
											</table>
										</td>
										<td headers="WC_CatalogSearchResultDisplay_PriceHeader" valign="top" class="t_td" id="WC_CachedStoreCatalogDisplay_TableCell_21_<c:out value="${counter.count}"/>">
											<c:choose>
												<%-- show the list price only if it is larger than the item price --%>
												<c:when test="${ item.listPriced && item.calculatedContractPriced && (item.calculatedContractPrice.amount < item.listPrice.amount)}" >
													<!-- 
													The empty gif are put in front of the prices so that the alt text can be read by the IBM Homepage Reader to describe the two prices displayed. 
													These descriptions are necessary for meeting Accessibility requirements 
													-->
													<a href="#" id="WC_CatalogSearchResultDisplay_Link_11_<c:out value="${counter.count}"/>"><img src="<c:out value="${jspStoreImgDir}" />images/empty.gif" alt='<fmt:message key="RegularPriceIs" bundle="${storeText}" />' width="1" height="1" border="0"/></a>
													<span class="listPrice"><c:out value="${item.listPrice}" escapeXml="false"/></span>
													<br />
													<!-- 
													The empty gif are put in front of the prices so that the alt text can be read by the IBM Homepage Reader to describe the two prices displayed. 
													These descriptions are necessary for meeting Accessibility requirements 
													-->
													<a href="#" id="WC_CatalogSearchResultDisplay_Link_12_<c:out value="${counter.count}"/>"><img src="<c:out value="${jspStoreImgDir}" />images/empty.gif" alt='<fmt:message key="SalePriceIs" bundle="${storeText}" />' width="1" height="1" border="0"/></a>
													<span class="redPrice"><c:out value="${item.calculatedContractPrice}" escapeXml="false"/></span>
												</c:when>
												
												<c:otherwise>
													<!-- 
													The empty gif are put in front of the prices so that the alt text can be read by the IBM Homepage Reader to describe the two prices displayed. 
													These descriptions are necessary for meeting Accessibility requirements 
													-->
													<a href="#" id="WC_CatalogSearchResultDisplay_Link_13_<c:out value="${counter.count}"/>"><img src="<c:out value="${jspStoreImgDir}" />images/empty.gif" alt='<fmt:message key="PriceIs" bundle="${storeText}" />' width="1" height="1" border="0"/></a>
													<span class="price"><c:out value="${item.calculatedContractPrice}" escapeXml="false"/></span>
												</c:otherwise>
											</c:choose>
										</td>
										<td headers="WC_CatalogSearchResultDisplay_OrderHeader" class="t_td" id="WC_CachedStoreCatalogDisplay_TableCell_22_<c:out value="${counter.count}"/>">
											<a href='javascript:Add2ShopCart(document.OrderItemAddForm, <c:out value="${item.itemID}" />)' class="t_button" id="WC_CatalogSearchResultDisplay_Link_14_<c:out value="${counter.count}"/>">
												<fmt:message key="SEARCH_ADD_TO_CART" bundle="${storeText}"/>
											</a>
										</td>
									</tr>
								</c:when>
								<c:when test="${catEntry.bundle}">
									<c:set var="bundle" value="${catEntry.bundleDataBean}"/>
									<tr>
										<td headers="WC_CatalogSearchResultDisplay_DescHeader" valign="top" class="t_td" width="70%" id="WC_CatalogSearchResultDisplay_TableCell_23_<c:out value="${counter.count}"/>">
											<%-- The URL that links to the product display page for the item --%>
								                        <c:url var="bundleDisplayUrl" value="ProductDisplay">
								                                <c:param name="catalogId" value="${WCParam.catalogId}"/>
								                                <c:param name="storeId" value="${WCParam.storeId}"/>
								                                <c:param name="productId" value="${bundle.bundleID}"/>
								                                <c:param name="langId" value="${langId}"/>
								                        </c:url>
											<table id="WC_CatalogSearchResultDisplay_Table_7_<c:out value="${counter.count}"/>">
							                        		<tr>
												<td valign="top" id="WC_CachedStoreCatalogDisplay_TableCell_24_<c:out value="${counter.count}"/>">
													<a href="<c:out value="${bundleDisplayUrl}"/>" id="WC_CatalogSearchResultDisplay_Link_ForBundleImg_<c:out value="${counter.count}"/>">
														<c:choose>
															<c:when test="${!empty bundle.description.thumbNail}">
																<span class="t_img_border"><img src="<c:out value="${bundle.objectPath}"/><c:out value="${bundle.description.thumbNail}"/>" alt="<c:out value="${bundle.description.shortDescription}"/>" border="0"/></span>
															</c:when>
															<c:otherwise>
																<img src="<c:out value="${jspStoreImgDir}" />images/NoImageIcon_sm.jpg" alt="<fmt:message key="No_Image" bundle="${storeText}"/>" border="0"/>
															</c:otherwise>
														</c:choose>
													</a>
												</td>
												<td valign="top" id="WC_CachedStoreCatalogDisplay_TableCell_25_<c:out value="${counter.count}"/>">
													<a href="<c:out value="${bundleDisplayUrl}"/>" id="WC_CatalogSearchResultDisplay_Link_13_<c:out value="${counter.count}"/>">
														<c:out value="${bundle.description.name}" escapeXml="false"/>
													</a>
													<br />
													<span class="text"><fmt:message key="SKU" bundle="${storeText}" />:</span> <span class="text"><c:out value="${bundle.partNumber}" /></span>
													<br /><br />
													<c:out value="${bundle.description.longDescription}" escapeXml="false"/>
												</td>
												</tr>
											</table>
										</td>
										<td headers="WC_CatalogSearchResultDisplay_PriceHeader" valign="top" class="t_td" id="WC_CachedStoreCatalogDisplay_TableCell_25_<c:out value="${counter.count}"/>">
											<c:choose>
												<%-- show the list price only if it is larger than the item price --%>
												<c:when test="${ bundle.listPriced && bundle.calculatedContractPriced && (bundle.calculatedContractPrice.amount < bundle.listPrice.amount)}" >
													<!-- 
													The empty gif are put in front of the prices so that the alt text can be read by the IBM Homepage Reader to describe the two prices displayed. 
													These descriptions are necessary for meeting Accessibility requirements 
													-->
													<a href="#" id="WC_CatalogSearchResultDisplay_Link_11_<c:out value="${counter.count}"/>"><img src="<c:out value="${jspStoreImgDir}" />images/empty.gif" alt='<fmt:message key="RegularPriceIs" bundle="${storeText}" />' width="1" height="1" border="0"/></a>
													<span class="listPrice"><c:out value="${bundle.listPrice}" escapeXml="false"/></span>
													<br />
													<!-- 
													The empty gif are put in front of the prices so that the alt text can be read by the IBM Homepage Reader to describe the two prices displayed. 
													These descriptions are necessary for meeting Accessibility requirements 
													-->
													<a href="#" id="WC_CatalogSearchResultDisplay_Link_12_<c:out value="${counter.count}"/>"><img src="<c:out value="${jspStoreImgDir}" />images/empty.gif" alt='<fmt:message key="SalePriceIs" bundle="${storeText}" />' width="1" height="1" border="0"/></a>
													<span class="redPrice"><c:out value="${bundle.calculatedContractPrice}" escapeXml="false"/></span>
												</c:when>
												
												<c:otherwise>
													<!-- 
													The empty gif are put in front of the prices so that the alt text can be read by the IBM Homepage Reader to describe the two prices displayed. 
													These descriptions are necessary for meeting Accessibility requirements 
													-->
													<a href="#" id="WC_CatalogSearchResultDisplay_Link_13_<c:out value="${counter.count}"/>"><img src="<c:out value="${jspStoreImgDir}" />images/empty.gif" alt='<fmt:message key="PriceIs" bundle="${storeText}" />' width="1" height="1" border="0"/></a>
													<span class="price"><c:out value="${bundle.calculatedContractPrice}" escapeXml="false"/></span>
												</c:otherwise>
											</c:choose>
										</td>
										<td headers="WC_CatalogSearchResultDisplay_OrderHeader" class="t_td" id="WC_CachedStoreCatalogDisplay_TableCell_22_<c:out value="${counter.count}"/>">
											<a href='javascript:Add2ShopCart(document.OrderItemAddForm, <c:out value="${bundle.bundleID}" />)' class="t_button" id="WC_CatalogSearchResultDisplay_Link_14_<c:out value="${counter.count}"/>">
												<fmt:message key="SEARCH_ADD_TO_CART" bundle="${storeText}"/>
											</a>
										</td>
									</tr>
								</c:when>

								<c:when test="${catEntry.package}">
									<c:set var="package" value="${catEntry.packageDataBean}"/>
									<tr>
										<td headers="WC_CatalogSearchResultDisplay_DescHeader" valign="top" class="t_td" width="70%" id="WC_CatalogSearchResultDisplay_TableCell_23_<c:out value="${counter.count}"/>">
											<%-- The URL that links to the product display page for the item --%>
								                        <c:url var="packageDisplayUrl" value="ProductDisplay">
								                                <c:param name="catalogId" value="${WCParam.catalogId}"/>
								                                <c:param name="storeId" value="${WCParam.storeId}"/>
								                                <c:param name="productId" value="${package.packageID}"/>
								                                <c:param name="langId" value="${langId}"/>
								                        </c:url>
											<table id="WC_CatalogSearchResultDisplay_Table_7_<c:out value="${counter.count}"/>">
							                        		<tr>
												<td valign="top" id="WC_CachedStoreCatalogDisplay_TableCell_24_<c:out value="${counter.count}"/>">
													<a href="<c:out value="${packageDisplayUrl}"/>" id="WC_CatalogSearchResultDisplay_Link_ForPackageImg_<c:out value="${counter.count}"/>">
														<c:choose>
															<c:when test="${!empty package.description.thumbNail}">
																<span class="t_img_border"><img src="<c:out value="${package.objectPath}"/><c:out value="${package.description.thumbNail}"/>" alt="<c:out value="${package.description.shortDescription}"/>" border="0"/></span>
															</c:when>
															<c:otherwise>
																<img src="<c:out value="${jspStoreImgDir}" />images/NoImageIcon_sm.jpg" alt="<fmt:message key="No_Image" bundle="${storeText}"/>" border="0"/>
															</c:otherwise>
														</c:choose>
													</a>
												</td>
												<td valign="top" id="WC_CachedStoreCatalogDisplay_TableCell_25_<c:out value="${counter.count}"/>">
													<a href="<c:out value="${packageDisplayUrl}"/>" id="WC_CatalogSearchResultDisplay_Link_13_<c:out value="${counter.count}"/>">
														<c:out value="${package.description.name}" escapeXml="false"/>
													</a>
													<br />
													<span class="text"><fmt:message key="SKU" bundle="${storeText}" />:</span> <span class="text"><c:out value="${package.partNumber}" /></span>
													<br /><br />
													<c:out value="${package.description.longDescription}" escapeXml="false"/>
												</td>
												</tr>
											</table>
										</td>
										<td headers="WC_CatalogSearchResultDisplay_PriceHeader" valign="top" class="t_td" id="WC_CachedStoreCatalogDisplay_TableCell_25_<c:out value="${counter.count}"/>">
											<c:choose>
												<%-- show the list price only if it is larger than the item price --%>
												<c:when test="${ package.listPriced && package.calculatedContractPriced && (package.calculatedContractPrice.amount < package.listPrice.amount)}" >
													<!-- 
													The empty gif are put in front of the prices so that the alt text can be read by the IBM Homepage Reader to describe the two prices displayed. 
													These descriptions are necessary for meeting Accessibility requirements 
													-->
													<a href="#" id="WC_CatalogSearchResultDisplay_Link_11_<c:out value="${counter.count}"/>"><img src="<c:out value="${jspStoreImgDir}" />images/empty.gif" alt='<fmt:message key="RegularPriceIs" bundle="${storeText}" />' width="1" height="1" border="0"/></a>
													<span class="listPrice"><c:out value="${package.listPrice}" escapeXml="false"/></span>
													<br />
													<!-- 
													The empty gif are put in front of the prices so that the alt text can be read by the IBM Homepage Reader to describe the two prices displayed. 
													These descriptions are necessary for meeting Accessibility requirements 
													-->
													<a href="#" id="WC_CatalogSearchResultDisplay_Link_12_<c:out value="${counter.count}"/>"><img src="<c:out value="${jspStoreImgDir}" />images/empty.gif" alt='<fmt:message key="SalePriceIs" bundle="${storeText}" />' width="1" height="1" border="0"/></a>
													<span class="redPrice"><c:out value="${package.calculatedContractPrice}" escapeXml="false"/></span>
												</c:when>
												
												<c:otherwise>
													<!-- 
													The empty gif are put in front of the prices so that the alt text can be read by the IBM Homepage Reader to describe the two prices displayed. 
													These descriptions are necessary for meeting Accessibility requirements 
													-->
													<a href="#" id="WC_CatalogSearchResultDisplay_Link_13_<c:out value="${counter.count}"/>"><img src="<c:out value="${jspStoreImgDir}" />images/empty.gif" alt='<fmt:message key="PriceIs" bundle="${storeText}" />' width="1" height="1" border="0"/></a>
													<span class="price"><c:out value="${package.calculatedContractPrice}" escapeXml="false"/></span>
												</c:otherwise>
											</c:choose>
										</td>
										<td headers="WC_CatalogSearchResultDisplay_OrderHeader" class="t_td" id="WC_CachedStoreCatalogDisplay_TableCell_22_<c:out value="${counter.count}"/>">
											<a href='javascript:Add2ShopCart(document.OrderItemAddForm, <c:out value="${package.packageID}" />)' class="t_button" id="WC_CatalogSearchResultDisplay_Link_14_<c:out value="${counter.count}"/>">
												<fmt:message key="SEARCH_ADD_TO_CART" bundle="${storeText}"/>
											</a>
										</td>
									</tr>
								</c:when>

							</c:choose>
						</c:forEach>
					</table>

					<form name="JumpToPageForm2" action="CatalogSearchResultView" method="post" id="JumpToPageForm2">

						<input type="hidden" name="storeId" value="<c:out value="${WCParam.storeId}" />" id="WC_CatalogSearchResultDisplay_FormInput_storeId_In_JumpToPageForm2_1"/>
						<input type="hidden" name="langId" value="<c:out value="${langId}" />" id="WC_CatalogSearchResultDisplay_FormInput_langId_In_JumpToPageForm2_1"/>
						<input type="hidden" name="catalogId" value="<c:out value="${WCParam.catalogId}" />" id="WC_CatalogSearchResultDisplay_FormInput_catalogId_In_JumpToPageForm2_1"/>
						<input type="hidden" name="searchTerm" value="<c:out value="${WCParam.searchTerm}" />" id="WC_CatalogSearchResultDisplay_FormInput_searchTermScope_In_JumpToPageForm2_1"/>
						<input type="hidden" name="resultCatEntryType" value="<c:out value="${WCParam.resultCatEntryType}" />" id="WC_CatalogSearchResultDisplay_FormInput_resultCatEntryType_In_JumpToPageForm2_1"/>
						<input type="hidden" name="pageSize" value="<c:out value="${pageSize}" />" id="WC_CatalogSearchResultDisplay_FormInput_pageSize_In_JumpToPageForm2_1"/>
						<input type="hidden" name="beginIndex" value="0" id="WC_CatalogSearchResultDisplay_FormInput_beginIndex_In_JumpToPageForm2_1"/>
						<input type="hidden" name="sType" value="<c:out value="${WCParam.sType}" />" id="WC_CatalogSearchResultDisplay_FormInput_sType_In_JumpToPageForm2_1"/>
						<input type="hidden" name="searchTermScope" value="<c:out value="${WCParam.searchTermScope}" />" id="WC_CatalogSearchResultDisplay_FormInput_searchTermScope_In_JumpToPageForm2_1"/>

						<c:if test="${WCParam.sType == 'AdvancedSearch'}"> 							
							<input type="hidden" name="searchType" value="<c:out value="${WCParam.searchType}" />" id="WC_CatalogSearchResultDisplay_FormInput_searchType_In_JumpToPageForm2_1"/>
							<input type="hidden" name="searchTermCaseSensitive" value="<c:out value="${WCParam.searchTermCaseSensitive}" />" id="WC_CatalogSearchResultDisplay_FormInput_searchTermCaseSensitive_In_JumpToPageForm2_1"/>
							<input type="hidden" name="searchTermOperator" value="<c:out value="${WCParam.searchTermOperator}" />" id="WC_CatalogSearchResultDisplay_FormInput_searchTermOperator_In_JumpToPageForm2_1"/>
							<input type="hidden" name="filterTerm" value="<c:out value="${WCParam.filterTerm}" />" id="WC_CatalogSearchResultDisplay_FormInput_filterTerm_In_JumpToPageForm2_1"/>
							<input type="hidden" name="filterType" value="<c:out value="${WCParam.filterType}" />" id="WC_CatalogSearchResultDisplay_FormInput_filterType_In_JumpToPageForm2_1"/>
							<input type="hidden" name="filterTermCaseSensitive" value="<c:out value="${WCParam.filterTermCaseSensitive}" />" id="WC_CatalogSearchResultDisplay_FormInput_filterTermCaseSensitive_In_JumpToPageForm2_1"/>
							<input type="hidden" name="filterTermOperator" value="<c:out value="${WCParam.filterTermOperator}" />" id="WC_CatalogSearchResultDisplay_FormInput_filterTermOperator_In_JumpToPageForm2_1"/>
							<input type="hidden" name="catGroupId" value="<c:out value="${WCParam.catGroupId}" />" id="WC_CatalogSearchResultDisplay_FormInput_catGroupId_In_JumpToPageForm2_1"/>
							<input type="hidden" name="categoryType" value="<c:out value="${WCParam.categoryType}" />" id="WC_CatalogSearchResultDisplay_FormInput_categoryType_In_JumpToPageForm2_1"/>
							<input type="hidden" name="qtyAvailable" value="<c:out value="${WCParam.qtyAvailable}" />" id="WC_CatalogSearchResultDisplay_FormInput_qtyAvailable_In_JumpToPageForm2_1"/>
							<input type="hidden" name="qtyAvailableOperator" value="<c:out value="${WCParam.qtyAvailableOperator}" />" id="WC_CatalogSearchResultDisplay_FormInput_qtyAvailableOperator_In_JumpToPageForm2_1"/>
							<input type="hidden" name="qtyMeasure" value="<c:out value="${WCParam.qtyMeasure}" />" id="WC_CatalogSearchResultDisplay_FormInput_qtyMeasure_In_JumpToPageForm2_1"/>
							<input type="hidden" name="qtyMeasureCaseSensitive" value="<c:out value="${WCParam.qtyMeasureCaseSensitive}" />" id="WC_CatalogSearchResultDisplay_FormInput_qtyMeasureCaseSensitive_In_JumpToPageForm2_1"/>
							<input type="hidden" name="qtyMeasureOperator" value="<c:out value="${WCParam.qtyMeasureOperator}" />" id="WC_CatalogSearchResultDisplay_FormInput_qtyMeasureOperator_In_JumpToPageForm2_1"/>
							<input type="hidden" name="minPrice" value="<c:out value="${WCParam.minPrice}" />" id="WC_CatalogSearchResultDisplay_FormInput_minPrice_In_JumpToPageForm2_1"/>
							<input type="hidden" name="maxPrice" value="<c:out value="${WCParam.maxPrice}" />" id="WC_CatalogSearchResultDisplay_FormInput_maxPrice_In_JumpToPageForm2_1"/>
                      	</c:if>

					<table cellpadding="0" cellspacing="0" border="0" width="100%" class="t_table" id="WC_CatalogSearchResultDisplay_Table_7">
						<tr>
							<td id="WC_CatalogSearchResultDisplay_TableCell_71">
								<table cellpadding="2" cellspacing="0" border="0" id="WC_CatalogSearchResultDisplay_Table_8">
									<tr>
										<td id="WC_CatalogSearchResultDisplay_TableCell_801"><a href="<c:out value="${CatalogSearchResultViewFirstURL}" />" id="WC_CatalogSearchResultDisplay_Link_1"><img src="<c:out value="${jspStoreImgDir}${vfileColor}"/>ps_first.gif" alt="" width="14" height="14" border="0"></a></td>
										<td class="ps_pad" id="WC_CatalogSearchResultDisplay_TableCell_802"><a href="<c:out value="${CatalogSearchResultViewPrevURL}" />" id="WC_CatalogSearchResultDisplay_Link_2"><img src="<c:out value="${jspStoreImgDir}${vfileColor}"/>ps_previous.gif" alt="" width="14" height="14" border="0"></a></td>
										<fmt:message var="pageNumberText" key="PAGE_NUMBER" bundle="${storeText}">
											<fmt:param><c:out value="${catEntSearchListBean.currentPageNumber}" /></fmt:param>
											<fmt:param><c:out value="${catEntSearchListBean.totalNumberOfResultSetPages}" /></fmt:param>
										</fmt:message>
										<td class="ps_text" id="WC_CatalogSearchResultDisplay_TableCell_803"><c:out value="${pageNumberText}" /></td>
										<td class="ps_pad" id="WC_CatalogSearchResultDisplay_TableCell_804"><a href="<c:out value="${CatalogSearchResultViewNextURL}" />" id="WC_CatalogSearchResultDisplay_Link_3"><img src="<c:out value="${jspStoreImgDir}${vfileColor}"/>ps_next.gif" alt="" width="14" height="14" border="0"></a></td>
										<td class="ps_pad" id="WC_CatalogSearchResultDisplay_TableCell_805"><a href="<c:out value="${CatalogSearchResultViewLastURL}" />" id="WC_CatalogSearchResultDisplay_Link_4"><img src="<c:out value="${jspStoreImgDir}${vfileColor}"/>ps_last.gif" alt="" width="14" height="14" border="0"></a></td>
										<td class="ps_text" id="WC_CatalogSearchResultDisplay_TableCell_806"><label for="WC_CatalogSearchResult_JumpToPage"><fmt:message key="JUMP_TO_PAGE" bundle="${storeText}"/></label></td>
										<td class="ps_pad" id="WC_CatalogSearchResultDisplay_TableCell_807"><input type="text" maxlength="4" size="3" class="ps_input" name="jumpToPage" id="WC_CatalogSearchResult_JumpToPage"></td>
										<td class="ps_pad" id="WC_CatalogSearchResultDisplay_TableCell_808"><a href="javascript:submitSearch(document.JumpToPageForm2);" id="WC_CatalogSearchResultDisplay_Link_5"><img src="<c:out value="${jspStoreImgDir}${vfileColor}"/>ps_page_jump.gif" alt="" width="16" height="16" border="0"></a></td>
									</tr>
								</table>
							</td>
							<td align="right" id="WC_CatalogSearchResultDisplay_TableCell_12">
								<table cellpadding="2" cellspacing="0" border="0" id="WC_CatalogSearchResultDisplay_Table_9">
									<tr>
										<td class="ps_text" id="WC_CatalogSearchResultDisplay_TableCell_901"><c:out value="${resultsText}" /></td>
									</tr>
								</table>
							</td>
						</tr>						
					</table>
					</form>

				</c:otherwise>
			</c:choose>

		</c:otherwise>
	</c:choose>

<script type="text/javascript" language="javascript">
<!-- <![CDATA[
<%-- 
  ***
  * This javascript function is used by the 'Add to Shopcart' button.  Since the HTML form is shared by both 'Add to Shopcart' and 'Add to Wish List' button,
  * appropriate values are set using this javascript before the form is submitted.
  * The variable 'busy' is used to avoid submitting the same forms multiple times when users click the button more than once.
  ***
 --%>
var busy = false;
function Add2ShopCart(form, catEntryId)
{
       if (!busy) {
              busy = true;
              form.action="OrderItemAdd";
              form.catEntryId.value = catEntryId;
			  form.URL.value = 'SetPendingOrder?URL='+form.URL.value;
              form.submit();
       }
}

function submitSearch(form)
{
    if ( form.jumpToPage.value >=1 && form.jumpToPage.value <= <c:out value="${catEntSearchListBean.totalNumberOfResultSetPages}" /> ) {
       if (!busy) {
              busy = true;
              form.beginIndex.value = (form.jumpToPage.value-1) * <c:out value="${catEntSearchListBean.pageSize}" />;
              form.submit();
       }
    } else {
    	alert("<fmt:message key="SEARCH_INVALID_PAGE_NUM" bundle="${storeText}"/>");
    }
}
//[[>-->  
</script>

<%@ include file="../../../include/LayoutContainerBottom.jspf"%>

</body>
</html>
