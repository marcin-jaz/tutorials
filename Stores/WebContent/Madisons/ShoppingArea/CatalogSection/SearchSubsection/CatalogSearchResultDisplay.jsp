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
  * This JSP file renders the search results depending on the shopper's search criteria.
  *****
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf"%>


<c:set var ="recordStart" value="0"/>
<c:set var="recordEnd" value="0"/>
<c:set var="totalCount" value="0"/>
<c:set var="completeIndicator" value=false/>
<c:set var="currentPage" value="0"/>
<c:set var="totalPages" value="0"/>
<c:set var="SearchDisplayViewPrevURL" value=""/>
<c:set var="SearchDisplayViewNextURL" value=""/>
<c:set var="numberProductsPerRow" value="4"/>

<wcf:url value="AjaxCatalogSearchResultView" var="SearchDisplayImageViewURL" type="Ajax">
	<wcf:param name="pageView" value="image"/>
	<wcf:param name="storeId" value="${WCParam.storeId}"/>
	<wcf:param name="langId" value="${langId}"/>
	<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
	<wcf:param name="searchTerm" value="${WCParam.searchTerm}"/>
	<wcf:param name="resultCatEntryType" value="${WCParam.resultCatEntryType}"/>
	<wcf:param name="searchType" value="${WCParam.searchType}"/>
	<wcf:param name="searchTermCaseSensitive" value="${WCParam.searchTermCaseSensitive}"/>
	<wcf:param name="searchTermOperator" value="${WCParam.searchTermOperator}"/>
	<wcf:param name="filterTerm" value="${WCParam.filterTerm}"/>
	<wcf:param name="filterType" value="${WCParam.filterType}"/>
	<wcf:param name="filterTermCaseSensitive" value="${WCParam.filterTermCaseSensitive}"/>
	<wcf:param name="filterTermOperator" value="${WCParam.filterTermOperator}"/>
	<wcf:param name="searchTermScope" value="${WCParam.searchTermScope}"/>
	<wcf:param name="catGroupId" value="${WCParam.catGroupId}"/>
	<wcf:param name="categoryType" value="${WCParam.categoryType}"/>
	<wcf:param name="qtyAvailable" value="${WCParam.qtyAvailable}"/>
	<wcf:param name="qtyAvailableOperator" value="${WCParam.qtyAvailableOperator}"/>
	<wcf:param name="qtyMeasure" value="${WCParam.qtyMeasure}"/>
	<wcf:param name="qtyMeasureCaseSensitive" value="${WCParam.qtyMeasureCaseSensitive}"/>
	<wcf:param name="qtyMeasureOperator" value="${WCParam.qtyMeasureOperator}"/>
	<wcf:param name="pageSize" value="${WCParam.pageSize}"/>
	<wcf:param name="beginIndex" value="${WCParam.beginIndex}"/>
	<wcf:param name="sType" value="${WCParam.sType}"/>
	<wcf:param name="minPrice" value="${WCParam.minPrice}"/>
	<wcf:param name="maxPrice" value="${WCParam.maxPrice}"/>
	<wcf:param name="catgrpSchemaType" value="1"/>
	<wcf:param name="RASchemaType" value="1"/>
			
</wcf:url>

<wcf:url value="AjaxCatalogSearchResultView" var="SearchDisplayFullViewURL" type="Ajax">
	<wcf:param name="pageView" value="detailed"/>
	<wcf:param name="storeId" value="${WCParam.storeId}"/>
	<wcf:param name="langId" value="${langId}"/>
	<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
	<wcf:param name="searchTerm" value="${WCParam.searchTerm}"/>
	<wcf:param name="resultCatEntryType" value="${WCParam.resultCatEntryType}"/>
	<wcf:param name="searchType" value="${WCParam.searchType}"/>
	<wcf:param name="searchTermCaseSensitive" value="${WCParam.searchTermCaseSensitive}"/>
	<wcf:param name="searchTermOperator" value="${WCParam.searchTermOperator}"/>
	<wcf:param name="filterTerm" value="${WCParam.filterTerm}"/>
	<wcf:param name="filterType" value="${WCParam.filterType}"/>
	<wcf:param name="filterTermCaseSensitive" value="${WCParam.filterTermCaseSensitive}"/>
	<wcf:param name="filterTermOperator" value="${WCParam.filterTermOperator}"/>
	<wcf:param name="searchTermScope" value="${WCParam.searchTermScope}"/>
	<wcf:param name="catGroupId" value="${WCParam.catGroupId}"/>
	<wcf:param name="categoryType" value="${WCParam.categoryType}"/>
	<wcf:param name="qtyAvailable" value="${WCParam.qtyAvailable}"/>
	<wcf:param name="qtyAvailableOperator" value="${WCParam.qtyAvailableOperator}"/>
	<wcf:param name="qtyMeasure" value="${WCParam.qtyMeasure}"/>
	<wcf:param name="qtyMeasureCaseSensitive" value="${WCParam.qtyMeasureCaseSensitive}"/>
	<wcf:param name="qtyMeasureOperator" value="${WCParam.qtyMeasureOperator}"/>
	<wcf:param name="pageSize" value="${WCParam.pageSize}"/>
	<wcf:param name="beginIndex" value="${WCParam.beginIndex}"/>
	<wcf:param name="sType" value="${WCParam.sType}"/>
	<wcf:param name="minPrice" value="${WCParam.minPrice}"/>
	<wcf:param name="maxPrice" value="${WCParam.maxPrice}"/>
	<wcf:param name="catgrpSchemaType" value="1"/>
	<wcf:param name="RASchemaType" value="1"/>
</wcf:url>
<c:set var="foundResults" value="false"/>
<c:set var="pageView" value="${WCParam.pageView}"/>
<c:if test="${empty pageView}" >
	<c:set var="pageView" value="${defaultPageView}"/>
</c:if>
<c:set var="pageSize" value="${WCParam.pageSize}"/>
<c:if test="${empty pageSize}" >
	<c:set var="pageSize" value="12" />
</c:if>
<c:set var="advancedSearchResult" value="false"/>
	<%-- 
	  ***
	  * Start - use catEntSearchListBean1 to check for minPriceError or maxPriceError
	  ***
	--%>
	<c:if test="${!empty WCParam.sType}">	
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

	<%-- Examine if the maximum/minimum price input by a customer is valid --%>
	
		<%-- Activate bean only if there is no error in the min and max prices entered --%>
		<c:if test="${errorMinPriceFlag || errorMaxPriceFlag}">
			<div class="text" id="Search_Result_Summary_div" style="display:none">

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
				<fmt:message key="SEARCH_REFINE_SEARCH" bundle="${storeText}">
					<fmt:param><b><a href="javascript:CatalogSearchDisplayJS.showHideSearchMode(true)" id="WC_CatalogSearchResultDisplay_link_2"><fmt:message key="SEARCH_LINK" bundle="${storeText}"/></a></b></fmt:param>
				</fmt:message>
			</div>
		</c:if>		
		
	
			<%-- 
			  ***
			  * Start - Initialize catEntSearchListBean to look for resultList while no price errors
			  ***
			--%>
			<c:if test="${!errorMinPriceFlag && !errorMaxPriceFlag}">
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
			
			<c:if test="${totalCount!=0}">
					<c:set var="advancedSearchResult" value="true"/>
			</c:if>
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
					<c:set var="pageSize" value="12"/>
				</c:otherwise>
			</c:choose>

			<%-- 
			  ***
			  * End - Initialize catEntSearchListBean to look for resultList while no price errors
			  ***
			--%>
	</c:if>
	</c:if>

			<%-- Check to see if there are no results.  Make sure this is the first set of results --%>
				<%-- If there are no items found, only display a message that indicates no item is found --%>
				<div class="text" id="Search_Result_Summary_div_2" style="display:none">
				<h1><fmt:message key="TITLE_SEARCH_RESULTS" bundle="${storeText}"/></h1>
				<c:if test="${advancedSearchResult==false}">

					<span class="strong">
						<fmt:message key="SEARCH_NO_RESULTS" bundle="${storeText}"/>
					</span>
				
					<br/>
					<font size="2"><b><fmt:message key="SEARCH_TIPS" bundle="${storeText}"/></b></font>
										
						<span class="Search_Result_Summary_Text"><fmt:message key="SEARCH_TIP1" bundle="${storeText}"/></span><br/>
						<span class="Search_Result_Summary_Text"><fmt:message key="SEARCH_TIP2" bundle="${storeText}"/></span><br/>
						<span class="Search_Result_Summary_Text"><fmt:message key="SEARCH_TIP3" bundle="${storeText}"/></span><br/>
						<span class="Search_Result_Summary_Text"><fmt:message key="SEARCH_TIP4" bundle="${storeText}"/></span><br/>
					
					<br/>
					<span class="Search_Result_Summary_Text">
					<fmt:message key="SEARCH_REFINE_SEARCH" bundle="${storeText}">
						<fmt:param><a class="Search_Result_Summary_Text catalog_link" href="javascript:CatalogSearchDisplayJS.showHideSearchMode(true)" id="WC_CatalogSearchResultDisplay_link_1"><fmt:message key="SEARCH_LINK" bundle="${storeText}"/></a></fmt:param>
					</fmt:message>
					</span>
				</c:if>
                            
				<%-- If there are items in the search result, then first decide how many pages should be used --%>
				<c:if test="${advancedSearchResult==true}">	
					
				</br></br>
							<span class="Search_Result_Summary_Text">
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
							
								<%-- Check if the user entered a brand to searh in--%>
								<c:if test="${!empty WCParam.manufacturer}">
									<%-- output the brand --%>
									<fmt:message key="SEARCH_MANUFACTURER" bundle="${storeText}">
										<fmt:param><b><c:out value="${WCParam.manufacturer}" escapeXml="false"/></b></fmt:param>
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
								</fmt:message>&nbsp;
								<br />
								<fmt:message key="SEARCH_REFINE_SEARCH" bundle="${storeText}">
										<fmt:param><a class="catalog_link" href="javascript:CatalogSearchDisplayJS.showHideSearchMode(true)" id="WC_CatalogSearchResultDisplay_link_2a"><fmt:message key="SEARCH_LINK" bundle="${storeText}"/></a></fmt:param>
								</fmt:message>
							</span>
							<br clear="all" /><br/>
							</c:if>
						</div>

<c:if test="${!empty WCParam.sType && advancedSearchResult==true}">

<c:set var="totalPages" value="${catEntSearchListBean.totalNumberOfResultSetPages}" />
<c:set var="currentPage" value="${catEntSearchListBean.currentPageNumber}" />
<c:set var="resultCountOnPage" value="${catEntSearchListBean.pageSize + beginIndex}"/>
	<c:choose>
		<c:when test="${resultCountOnPage > totalCount}">
			<c:set var="resultCountOnPage" value="${totalCount}"/>
		</c:when>
	</c:choose>
		<c:set var="recordEnd" value="${resultCountOnPage}"/>
<c:set var="recordStart" value="${beginIndex}"/>
	
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
<c:set var="completeIndicator" value="${!catEntSearchListBean.nextPageExists}"/>
<c:if test="${catEntSearchListBean.previousPageExists}">
<wcf:url value="AjaxCatalogSearchResultView" var="AdvancedSearchDisplayViewPrevURL" type="Ajax">
	<wcf:param name="storeId" value="${WCParam.storeId}"/>
	<wcf:param name="langId" value="${langId}"/>
	<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
	<wcf:param name="searchTerm" value="${WCParam.searchTerm}"/>
	<wcf:param name="resultCatEntryType" value="${WCParam.resultCatEntryType}"/>
	<wcf:param name="searchType" value="${WCParam.searchType}"/>
	<wcf:param name="catgrpSchemaType" value="${WCParam.catgrpSchemaType}"/>
	<wcf:param name="RASchemaType" value="${WCParam.RASchemaType}"/>
	<wcf:param name="searchTermCaseSensitive" value="${WCParam.searchTermCaseSensitive}"/>
	<wcf:param name="searchTermOperator" value="${WCParam.searchTermOperator}"/>
	<wcf:param name="filterTerm" value="${WCParam.filterTerm}"/>
	<wcf:param name="filterType" value="${WCParam.filterType}"/>
	<wcf:param name="filterTermCaseSensitive" value="${WCParam.filterTermCaseSensitive}"/>
	<wcf:param name="filterTermOperator" value="${WCParam.filterTermOperator}"/>
	<wcf:param name="searchTermScope" value="${WCParam.searchTermScope}"/>
	<wcf:param name="catGroupId" value="${WCParam.catGroupId}"/>
	<wcf:param name="categoryType" value="${WCParam.categoryType}"/>
	<wcf:param name="qtyAvailable" value="${WCParam.qtyAvailable}"/>
	<wcf:param name="qtyAvailableOperator" value="${WCParam.qtyAvailableOperator}"/>
	<wcf:param name="qtyMeasure" value="${WCParam.qtyMeasure}"/>
	<wcf:param name="qtyMeasureCaseSensitive" value="${WCParam.qtyMeasureCaseSensitive}"/>
	<wcf:param name="qtyMeasureOperator" value="${WCParam.qtyMeasureOperator}"/>
	<wcf:param name="pageSize" value="${pageSize}"/>
	<wcf:param name="beginIndex" value="${prevPageIndex}"/>
	<wcf:param name="sType" value="${WCParam.sType}"/>
	<wcf:param name="minPrice" value="${WCParam.minPrice}"/>
	<wcf:param name="maxPrice" value="${WCParam.maxPrice}"/>
	<wcf:param name="manufacturerCaseSensitive" value="${WCParam.manufacturerCaseSensitive}"/>
	<wcf:param name="manufacturerOperator" value="${WCParam.manufacturerOperator}"/>
	<wcf:param name="pageView" value="${pageView}"/>
	<wcf:param name="manufacturer" value="${WCParam.manufacturer}"/>
</wcf:url>
</c:if>
<c:set var="SearchDisplayViewPrevURL" value="${AdvancedSearchDisplayViewPrevURL}"/>
<c:if test="${catEntSearchListBean.nextPageExists}">
<wcf:url value="AjaxCatalogSearchResultView" var="AdvancedSearchDisplayViewNextURL" type="Ajax">
	<wcf:param name="storeId" value="${WCParam.storeId}"/>
	<wcf:param name="langId" value="${langId}"/>
	<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
	<wcf:param name="searchTerm" value="${WCParam.searchTerm}"/>
	<wcf:param name="resultCatEntryType" value="${WCParam.resultCatEntryType}"/>
	<wcf:param name="catgrpSchemaType" value="${WCParam.catgrpSchemaType}"/>
	<wcf:param name="RASchemaType" value="${WCParam.RASchemaType}"/>
	<wcf:param name="searchType" value="${WCParam.searchType}"/>
	<wcf:param name="searchTermCaseSensitive" value="${WCParam.searchTermCaseSensitive}"/>
	<wcf:param name="searchTermOperator" value="${WCParam.searchTermOperator}"/>
	<wcf:param name="filterTerm" value="${WCParam.filterTerm}"/>
	<wcf:param name="filterType" value="${WCParam.filterType}"/>
	<wcf:param name="filterTermCaseSensitive" value="${WCParam.filterTermCaseSensitive}"/>
	<wcf:param name="filterTermOperator" value="${WCParam.filterTermOperator}"/>
	<wcf:param name="searchTermScope" value="${WCParam.searchTermScope}"/>
	<wcf:param name="catGroupId" value="${WCParam.catGroupId}"/>
	<wcf:param name="categoryType" value="${WCParam.categoryType}"/>
	<wcf:param name="qtyAvailable" value="${WCParam.qtyAvailable}"/>
	<wcf:param name="qtyAvailableOperator" value="${WCParam.qtyAvailableOperator}"/>
	<wcf:param name="qtyMeasure" value="${WCParam.qtyMeasure}"/>
	<wcf:param name="qtyMeasureCaseSensitive" value="${WCParam.qtyMeasureCaseSensitive}"/>
	<wcf:param name="qtyMeasureOperator" value="${WCParam.qtyMeasureOperator}"/>
	<wcf:param name="pageSize" value="${pageSize}"/>
	<wcf:param name="beginIndex" value="${nextPageIndex}"/>
	<wcf:param name="sType" value="${WCParam.sType}"/>
	<wcf:param name="minPrice" value="${WCParam.minPrice}"/>
	<wcf:param name="maxPrice" value="${WCParam.maxPrice}"/>
	<wcf:param name="pageView" value="${pageView}"/>
	<wcf:param name="manufacturerCaseSensitive" value="${WCParam.manufacturerCaseSensitive}"/>
	<wcf:param name="manufacturerOperator" value="${WCParam.manufacturerOperator}"/>
	<wcf:param name="manufacturer" value="${WCParam.manufacturer}"/>
</wcf:url>
</c:if>
<c:set var="SearchDisplayViewNextURL" value="${AdvancedSearchDisplayViewNextURL}"/>
</c:if>
<br clear="all" />
<c:if test="${advancedSearchResult==true}">
<div class="contentgrad_header" id="WC_CatalogSearchResultDisplay_div_1">
	<div class="left_corner" id="WC_CatalogSearchResultDisplay_div_2"></div>
	<div class="left" id="WC_CatalogSearchResultDisplay_div_3">
		<span class="text">
			<fmt:message key="CATEGORY_RESULTS_DISPLAYING" bundle="${storeText}"> 
				<fmt:param><fmt:formatNumber value="${recordStart+ 1}"/></fmt:param>
				<fmt:param><fmt:formatNumber value="${recordEnd}"/></fmt:param>
				<fmt:param><fmt:formatNumber value="${totalCount}"/></fmt:param>
			</fmt:message>
			
			<c:if test="${totalPages > 1}">
				<span class="paging">
					<c:if test="${recordStart != 0}">
						<a href="javaScript:setCurrentId('WC_CatalogSearchResultDisplay_link_3'); 
						wc.render.getContextById('catalogSearchResultDisplay_Context').properties['searchResultsPageNum']='<c:out value='${prevPageIndex}'/>';
						CatalogSearchDisplayJS.goToResultPage('<c:out value='${SearchDisplayViewPrevURL}'/>');" id="WC_CatalogSearchResultDisplay_link_3">
					</c:if>
					<img src="<c:out value="${jspStoreImgDir}${vfileColorBIDI}" />paging_back.png" alt="<fmt:message key="CATEGORY_PAGING_LEFT_IMAGE" bundle="${storeText}"/>" />
					<c:if test="${recordStart != 0}">
						</a>
					</c:if>
				
				<fmt:message key="CATEGORY_RESULTS_PAGES_DISPLAYING" bundle="${storeText}"> 
					<fmt:param><fmt:formatNumber value="${currentPage}"/></fmt:param>
					<fmt:param><fmt:formatNumber value="${totalPages}"/></fmt:param>
				</fmt:message>
				
				<c:if test="${!completeIndicator}">
					<a href="javaScript:setCurrentId('WC_CatalogSearchResultDisplay_link_4'); 
					wc.render.getContextById('catalogSearchResultDisplay_Context').properties['searchResultsPageNum']='<c:out value='${nextPageIndex}'/>';
					CatalogSearchDisplayJS.goToResultPage('<c:out value='${SearchDisplayViewNextURL}'/>');" id="WC_CatalogSearchResultDisplay_link_4">
				</c:if>
				<img src="<c:out value="${jspStoreImgDir}${vfileColorBIDI}" />paging_next.png" alt="<fmt:message key="CATEGORY_PAGING_RIGHT_IMAGE" bundle="${storeText}"/>" />
				<c:if test="${!completeIndicator}">
					</a>
				</c:if>
			</span>
		</c:if>	
		</span>
	</div>
	<div class="right_corner" id="WC_CatalogSearchResultDisplay_div_4"></div>
	<div class="right" id="WC_CatalogSearchResultDisplay_div_4_1">
		 <span class="views">
			<c:if test="${pageView !='image'}">
			 	<c:set var="gridView" value="horizontal_grid"/>
				 <a href="javaScript:;" onclick="javaScript:setCurrentId('WC_CatalogSearchResultDisplay_link_5'); wc.render.getContextById('catalogSearchResultDisplay_Context').properties['searchResultsView']='image';
				 CatalogSearchDisplayJS.goToResultPage('<c:out value='${SearchDisplayImageViewURL}'/>');" id="WC_CatalogSearchResultDisplay_link_5">
					<img src="<c:out value="${jspStoreImgDir}${vfileColor}" />grid_normal.png" alt="<fmt:message key="CATEGORY_IMAGE_VIEW" bundle="${storeText}"/>" />
				 </a>
				 <img id="detailedTypeImageSelected" src="<c:out value="${jspStoreImgDir}${vfileColor}list_selected.png"/>" alt="<fmt:message key="FF_VIEWDETAILS" bundle="${storeText}"/>"/>	
			 </c:if>
			 <c:if test="${pageView !='detailed'}">
				 <c:set var="gridView" value="four-grid"/>
				 <img id="imageTypeImageSelected" src="<c:out value="${jspStoreImgDir}${vfileColor}grid_selected.png"/>" alt="<fmt:message key="FF_VIEWICONS" bundle="${storeText}"/>"/>
				 <a href="javaScript:;" onclick="javaScript:setCurrentId('WC_CatalogSearchResultDisplay_link_6'); 
				 wc.render.getContextById('catalogSearchResultDisplay_Context').properties['searchResultsView']='detailed';
				 CatalogSearchDisplayJS.goToResultPage('<c:out value='${SearchDisplayFullViewURL}'/>');" id="WC_CatalogSearchResultDisplay_link_6">
					<img src="<c:out value="${jspStoreImgDir}${vfileColor}" />list_normal.png" alt="<fmt:message key="CATEGORY_DETAILED_VIEW" bundle="${storeText}"/>" />
				 </a>
			 </c:if>
		</span> 
	</div>
</div>

<div class="body588" id="WC_CatalogSearchResultDisplay_div_5">
	<br clear="all" />
	<table id="${gridView}" cellpadding="0" cellspacing="0" border="0">
		<c:set var="currentItemCount" value="${recordStart}" />
		<c:set var="rowItemCount" value="0"/>
		<c:set var="rowBeginIndex" value="0"/>
		<c:forEach var="catEntry" items="${catEntSearchListBean.resultList}" varStatus="status">
			<c:set var="currentItemCount" value="${currentItemCount + 1}" />
				<c:if test="${(recordStart <= currentItemCount) && (recordEnd >= currentItemCount)}">
					<c:if test="${rowItemCount == 0}">
						<tr class="item_container">
							<td class="divider_line" colspan="4" id="WC_CatalogSearchResultDisplay_td_1_<c:out value='${status.count}'/>"></td>
						</tr>
						<tr class="item_container">
					</c:if>
					<c:choose>
						<c:when test="${pageView == 'image'}">
					<td class="item" id="WC_CatalogSearchResultDisplay_td_2_${status.count}">
						<div id="WC_CatalogSearchResultDisplay_div_6_<c:out value='${status.count}'/>" <c:if test="${rowItemCount!=0}"> class="container" </c:if>>
							<c:set var="rowItemCount" value="${rowItemCount+1}"/>
							<c:set var="prefix" value="search"/>
							<c:set var="catEntryIdentifier" value="${catEntry.catalogEntryID}"/>
							<%@ include file="../../../Snippets/ReusableObjects/CatalogEntryDBThumbnailDisplay.jspf" %>
						</div>
					</td>
							<c:if test="${rowItemCount%numberProductsPerRow==0}">
								</tr>
					
								<c:set var="rowItemCount" value="0"/>
								<c:set var="rowBeginIndex" value="${status.index+1}"/>
							</c:if> 
						</c:when>
						<c:otherwise>
							<c:set var="catEntryIdentifier" value="${catEntry.catalogEntryID}"/>
							<%@ include file="../../../Snippets/ReusableObjects/CatalogEntryDBThumbnailDisplay.jspf" %>
						</c:otherwise>
					</c:choose>
				</c:if>
			
		</c:forEach>
		<c:if test="${rowItemCount != 0 && pageView !='detailed'}">
			</tr>
		</c:if>
		<tr class="item_container">
			<td class="divider_line" colspan="4" id="WC_CategoryOnlyResultsDisplay_td_1a"></td>
		</tr>
	</table>
	<br />
	<br />

	<span class="display_text">
		<fmt:message key="CATEGORY_RESULTS_DISPLAYING" bundle="${storeText}"> 
			<fmt:param><fmt:formatNumber value="${recordStart+ 1}"/></fmt:param>
			<fmt:param><fmt:formatNumber value="${recordEnd}"/></fmt:param>
			<fmt:param><fmt:formatNumber value="${totalCount}"/></fmt:param>
		</fmt:message>
		
		<c:if test="${totalPages > 1}">
			<span class="paging">
				<c:if test="${recordStart != 0}">
					<a href="javaScript:setCurrentId('WC_CatalogSearchResultDisplay_link_7'); wc.render.getContextById('catalogSearchResultDisplay_Context').properties['searchResultsPageNum']='<c:out value='${prevPageIndex}'/>';
					CatalogSearchDisplayJS.goToResultPage('<c:out value='${SearchDisplayViewPrevURL}'/>');" id="WC_CatalogSearchResultDisplay_link_7">
				</c:if>
				<img src="<c:out value="${jspStoreImgDir}${vfileColorBIDI}" />paging_back.png" alt="<fmt:message key="CATEGORY_PAGING_LEFT_IMAGE" bundle="${storeText}"/>" />
				<c:if test="${recordStart != 0}">
					</a>
				</c:if>
			
				<fmt:message key="CATEGORY_RESULTS_PAGES_DISPLAYING" bundle="${storeText}"> 
					<fmt:param><fmt:formatNumber value="${currentPage}"/></fmt:param>
					<fmt:param><fmt:formatNumber value="${totalPages}"/></fmt:param>
				</fmt:message>
			
				<c:if test="${!completeIndicator}">
					<a href="javaScript:setCurrentId('WC_CatalogSearchResultDisplay_link_8'); 
					wc.render.getContextById('catalogSearchResultDisplay_Context').properties['searchResultsPageNum']='<c:out value='${nextPageIndex}'/>';
					CatalogSearchDisplayJS.goToResultPage('<c:out value='${SearchDisplayViewNextURL}'/>');" id="WC_CatalogSearchResultDisplay_link_8">
				</c:if>
				<img src="<c:out value="${jspStoreImgDir}${vfileColorBIDI}" />paging_next.png" alt="<fmt:message key="CATEGORY_PAGING_RIGHT_IMAGE" bundle="${storeText}"/>" />
				<c:if test="${!completeIndicator}">
					</a>
				</c:if>
			</span>
		</c:if>
	</span>
</div>
<div class="footer" id="WC_CatalogSearchResultDisplay_div_7">
	 <div class="left_corner" id="WC_CatalogSearchResultDisplay_div_8"></div>
	 <div class="right" id="WC_CatalogSearchResultDisplay_div_9"></div>
	 <div class="right_corner" id="WC_CatalogSearchResultDisplay_div_10"></div>
</div>

<flow:ifEnabled feature="Analytics">
	<div id="catalog_search_result_information" style="visibility:hidden">
		{	searchResult: {
			pageSize: <c:out value="${pageSize}"/>, 
			searchTerms: '<c:out value="${WCParam.searchTerm}"/>', 
		 	totalPageNumber: <c:out value="${catEntSearchListBean.totalNumberOfResultSetPages}"/>, 
		  	totalResultCount: <c:out value="${totalCount}" />, 
		  	currentPageNumber: <c:out value="${currentPage}" />
			}
		}
</div>
</flow:ifEnabled>

</c:if>
