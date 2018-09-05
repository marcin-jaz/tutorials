<%--
/*
 *-------------------------------------------------------------------
 * Licensed Materials - Property of IBM
 *
 * WebSphere Commerce
 *
 * (c) Copyright International Business Machines Corporation. 2001, 2004
 *     All rights reserved.
 *
 * US Government Users Restricted Rights - Use, duplication or
 * disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
 *
 *-------------------------------------------------------------------
 */
--%>
<%--
  *****
  ** This JSP page displays the search results based on the search criteria input by a customer. The following features are supported: 
  **   -- If there are more than a certain number of searching results, the results will be split into pages. The number of items per page can be specified by a customer.
  **   -- The thumbnail, if any, for each search result will be displayed 
  **   -- Clicking on the thumbnail will link to ProductDisplay page  
  *****
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf"%>
<wcbase:useBean id="catalog" classname="com.ibm.commerce.catalog.beans.CatalogDataBean">
	<c:set target="${catalog}" property="catalogId" value="${catalogId}"/>
</wcbase:useBean>
<c:set var="topCategories" value="${catalog.topCategories}"/>
<wcbase:useBean id="catEntSearchListBean" classname="com.ibm.commerce.search.beans.CatEntrySearchListDataBean">
	<jsp:setProperty property="*" name="catEntSearchListBean" />
	<c:set property="isItem" value="true" target="${catEntSearchListBean}" />
	<c:set property="isProduct" value="true" target="${catEntSearchListBean}" />
	<c:set property="isBundle" value="true" target="${catEntSearchListBean}" />
	<c:set property="isPackage" value="true" target="${catEntSearchListBean}" />
	
	<%-- Set the sort order to sort by CatEntryPartnumber --%>
  <c:set property="orderBy1" value="CatEntryPartnumber" target="${catEntSearchListBean}" />
</wcbase:useBean>
<c:set var="totalCount" value="${catEntSearchListBean.resultCount}" scope="request"/>
<% out.flush(); %> 
<c:import url="CatalogSearchResultDisplayInit.jsp">
</c:import>
<% out.flush(); %>        	
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<!-- BEGIN CatalogSearchResultDisplay.jsp -->
<head>
<c:choose>
	<c:when test="${totalCount==1 && ((!empty manufPartNum && manufPartNum!='') || (!empty sku && sku!=''))}">
		<%--
		// If a SKU or PartNumber was searched on, and only 1 result
		//  is available, go to the item display page.
		--%>
		<c:url var="sWebAppPath" value="${requestScope.requestServletPath}/ProductDisplay">
		        <c:param name="catalogId" value="${catalogId}"/>
		        <c:param name="storeId" value="${storeId}"/>
		        <c:param name="productId" value="${catEntSearchListBean.resultList[0].catalogEntryID}"/>
		        <c:param name="langId" value="${langId}"/>
		</c:url>
		<meta http-equiv="Refresh" content="0;URL=
		<c:out value="${sWebAppPath}"/>"/>
	</c:when>
</c:choose>
<title><fmt:message key="SerRes_Title" bundle="${storeText}"/></title>
<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${vfileStylesheet}"/>" type="text/css"/>
</head>
<body class="noMargin">
<flow:ifEnabled feature="customerCare"> 
<%
// Set header type needed for this JSP for LiveHelp.  This must
// be set before HeaderDisplay.jsp
request.setAttribute("liveHelpPageType", "personal");
%>
</flow:ifEnabled> 
<%@ include file="../../../include/LayoutContainerTop.jspf"%>

<c:url value="AdvancedSearchView" var="AdvancedSearchViewURL">
	<c:param name="storeId" value="${storeId}"/>
	<c:param name="langId" value="${langId}"/>
	<c:param name="catalogId" value="${catalogId}"/>

	<c:param name="searchTerm" value="${WCParam.searchTerm}"/>
	<c:param name="searchType" value="${WCParam.searchType}"/>
	<c:param name="filterTerm" value="${WCParam.filterTerm}"/>
	<c:param name="filterType" value="${WCParam.filterType}"/>
	<c:param name="searchTermScope" value="${WCParam.searchTermScope}"/>
	<c:param name="catGroupId" value="${WCParam.catGroupId}"/>
	<c:param name="pageSize" value="${pageSize}"/>
	<c:param name="sType" value="${WCParam.sType}"/>
	<c:param name="manufacturer" value="${WCParam.manufacturer}"/>
	<c:param name="manufacturerPartNum" value="${WCParam.manufacturerPartNum}"/>
	<c:param name="sku" value="${WCParam.sku}"/>

</c:url>

<h1><fmt:message key="SerRes_Title" bundle="${storeText}"/></h1>

<table cellpadding="0" cellspacing="0" border="0" width="100%" id="WC_CatalogSearchResultDisplay_Table_1">
  <tbody>
    <tr>
      <td valign="top" id="WC_CatalogSearchResultDisplay_TableCell_1">
        <!-- Start Main JSP Content -->
        
	<c:choose>
		<c:when test="${totalCount==0 && beginIndex==0}">
			<span class="warning">
				<fmt:message key="SerRes_Text3" bundle="${storeText}"/>
			</span>
		</c:when>
		<c:otherwise>
			<c:set var="resultCountOnPage" value="${catEntSearchListBean.pageSize + beginIndex}"/>
			<c:choose>
				<c:when test="${resultCountOnPage > totalCount}">
					<c:set var="resultCountOnPage" value="${totalCount}"/>
				</c:when>
			</c:choose>
			<fmt:message var="resultsText" key="SerRes_Text9" bundle="${storeText}">
				<fmt:param value="${beginIndex+1}"/>
				<fmt:param value="${resultCountOnPage}"/>
				<fmt:param value="${totalCount}"/>
			</fmt:message>
		</c:otherwise>
	</c:choose>

       	<c:if test="${catEntSearchListBean.resultCount > 0 || beginIndex > 0}">
		<form name="OrderItemAddForm" action="" method="post" id="OrderItemAddForm">
		<input type="hidden" name="storeId" value="<c:out value="${WCParam.storeId}" />" id="WC_CatalogSearchResultDisplay_FormInput_storeId_In_OrderItemAddForm_1"/>
		<input type="hidden" name="catalogId" value="<c:out value="${WCParam.catalogId}" />" id="WC_CatalogSearchResultDisplay_FormInput_catalogId_In_OrderItemAddForm_1"/>
		<input type="hidden" name="orderId" value="." id="WC_CatalogSearchResultDisplay_FormInput_orderId_In_OrderItemAddForm_1"/>
		<input type="hidden" name="URL" value="SetPendingOrder?URL=OrderCalculate?URL=OrderItemDisplay" id="WC_CatalogSearchResultDisplay_FormInput_URL_In_OrderItemAddForm_1"/>
		<input type="hidden" name="errorViewName" value="ProductDisplayErrorView" id="WC_CatalogSearchResultDisplay_FormInput_errorViewName_In_OrderItemAddForm_1"/>
		<input type="hidden" name="catEntryId" value="<c:out value="${productId}" />" id="WC_CatalogSearchResultDisplay_FormInput_catEntryId_In_OrderItemAddForm_1"/>
		<input type="hidden" name="calculationUsageId" value="-1" id="WC_CatalogSearchResultDisplay_FormInput_calculationUsageId_In_OrderItemAddForm_1"/>
		<input type="hidden" name="quantity" value="1" id="WC_CatalogSearchResultDisplay_FormInput_quantity_In_OrderItemAddForm_1"/>
		<%-- shouldCachePage is used to tell the server not to cache this page.  So if an error happens, this page is redrawn with an error message --%>
		<input type="hidden" name="shouldCachePage" value="false" id="WC_CatalogSearchResultDisplay_FormInput_shouldCachePage_In_OrderItemAddForm_1"/>
		</form>

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
		<c:choose>
			<c:when test="${WCParam.sType == 'AdvancedSearch'}"> 
				<form name="JumpToPageForm" action="CatalogSearchResultView" method="post" id="JumpToPageForm">
				<input type="hidden" name="storeId" value="<c:out value="${WCParam.storeId}" />" id="WC_CatalogSearchResultDisplay_FormInput_storeId_In_JumpToPageForm_1"/>
				<input type="hidden" name="langId" value="<c:out value="${langId}" />" id="WC_CatalogSearchResultDisplay_FormInput_langId_In_JumpToPageForm_1"/>
				<input type="hidden" name="catalogId" value="<c:out value="${WCParam.catalogId}" />" id="WC_CatalogSearchResultDisplay_FormInput_catalogId_In_JumpToPageForm_1"/>
				<input type="hidden" name="searchTerm" value="<c:out value="${WCParam.searchTerm}" />" id="WC_CatalogSearchResultDisplay_FormInput_searchTermScope_In_JumpToPageForm_1"/>
				<input type="hidden" name="searchType" value="<c:out value="${WCParam.searchType}" />" id="WC_CatalogSearchResultDisplay_FormInput_searchType_In_JumpToPageForm_1"/>
				<input type="hidden" name="searchTermCaseSensitive" value="<c:out value="${WCParam.searchTermCaseSensitive}" />" id="WC_CatalogSearchResultDisplay_FormInput_searchTermCaseSensitive_In_JumpToPageForm_1"/>
				<input type="hidden" name="searchTermOperator" value="<c:out value="${WCParam.searchTermOperator}" />" id="WC_CatalogSearchResultDisplay_FormInput_searchTermOperator_In_JumpToPageForm_1"/>
				<input type="hidden" name="filterTerm" value="<c:out value="${WCParam.filterTerm}" />" id="WC_CatalogSearchResultDisplay_FormInput_filterTerm_In_JumpToPageForm_1"/>
				<input type="hidden" name="filterType" value="<c:out value="${WCParam.filterType}" />" id="WC_CatalogSearchResultDisplay_FormInput_filterType_In_JumpToPageForm_1"/>
				<input type="hidden" name="filterTermCaseSensitive" value="<c:out value="${WCParam.filterTermCaseSensitive}" />" id="WC_CatalogSearchResultDisplay_FormInput_filterTermCaseSensitive_In_JumpToPageForm_1"/>
				<input type="hidden" name="filterTermOperator" value="<c:out value="${WCParam.filterTermOperator}" />" id="WC_CatalogSearchResultDisplay_FormInput_filterTermOperator_In_JumpToPageForm_1"/>
				<input type="hidden" name="searchTermScope" value="<c:out value="${WCParam.searchTermScope}" />" id="WC_CatalogSearchResultDisplay_FormInput_searchTermScope_In_JumpToPageForm_1"/>
				<input type="hidden" name="catGroupId" value="<c:out value="${WCParam.catGroupId}" />" id="WC_CatalogSearchResultDisplay_FormInput_catGroupId_In_JumpToPageForm_1"/>
				<input type="hidden" name="categoryType" value="<c:out value="${WCParam.categoryType}" />" id="WC_CatalogSearchResultDisplay_FormInput_categoryType_In_JumpToPageForm_1"/>
				<input type="hidden" name="qtyAvailable" value="<c:out value="${WCParam.qtyAvailable}" />" id="WC_CatalogSearchResultDisplay_FormInput_qtyAvailable_In_JumpToPageForm_1"/>
				<input type="hidden" name="qtyAvailableOperator" value="<c:out value="${WCParam.qtyAvailableOperator}" />" id="WC_CatalogSearchResultDisplay_FormInput_qtyAvailableOperator_In_JumpToPageForm_1"/>
				<input type="hidden" name="qtyMeasure" value="<c:out value="${WCParam.qtyMeasure}" />" id="WC_CatalogSearchResultDisplay_FormInput_qtyMeasure_In_JumpToPageForm_1"/>
				<input type="hidden" name="qtyMeasureCaseSensitive" value="<c:out value="${WCParam.qtyMeasureCaseSensitive}" />" id="WC_CatalogSearchResultDisplay_FormInput_qtyMeasureCaseSensitive_In_JumpToPageForm_1"/>
				<input type="hidden" name="qtyMeasureOperator" value="<c:out value="${WCParam.qtyMeasureOperator}" />" id="WC_CatalogSearchResultDisplay_FormInput_qtyMeasureOperator_In_JumpToPageForm_1"/>
				<input type="hidden" name="pageSize" value="<c:out value="${pageSize}" />" id="WC_CatalogSearchResultDisplay_FormInput_pageSize_In_JumpToPageForm_1"/>
				<input type="hidden" name="beginIndex" value="0" id="WC_CatalogSearchResultDisplay_FormInput_beginIndex_In_JumpToPageForm_1"/>
				<input type="hidden" name="sType" value="<c:out value="${WCParam.sType}" />" id="WC_CatalogSearchResultDisplay_FormInput_sType_In_JumpToPageForm_1"/>
				<input type="hidden" name="manufacturer" value="<c:out value="${WCParam.manufacturer}" />" id="WC_CatalogSearchResultDisplay_FormInput_manufacturer_In_JumpToPageForm_1"/>
				<input type="hidden" name="manufacturerCaseSensitive" value="<c:out value="${WCParam.manufacturerCaseSensitive}" />" id="WC_CatalogSearchResultDisplay_FormInput_manufacturerCaseSensitive_In_JumpToPageForm_1"/>
				<input type="hidden" name="manufacturerOperator" value="<c:out value="${WCParam.manufacturerOperator}" />" id="WC_CatalogSearchResultDisplay_FormInput_manufacturerOperator_In_JumpToPageForm_1"/>
				<input type="hidden" name="manufacturerPartNum" value="<c:out value="${WCParam.manufacturerPartNum}" />" id="WC_CatalogSearchResultDisplay_FormInput_manufacturerPartNum_In_JumpToPageForm_1"/>
				<input type="hidden" name="manufacturerPartNumOperator" value="<c:out value="${WCParam.manufacturerPartNumOperator}" />" id="WC_CatalogSearchResultDisplay_FormInput_manufacturerPartNumOperator_In_JumpToPageForm_1"/>
				<input type="hidden" name="manufacturerPartNumCaseSensitive" value="<c:out value="${WCParam.manufacturerPartNumCaseSensitive}" />" id="WC_CatalogSearchResultDisplay_FormInput_manufacturerPartNumCaseSensitive_In_JumpToPageForm_1"/>
				<input type="hidden" name="skuCaseSensitive" value="<c:out value="${WCParam.skuCaseSensitive}" />" id="WC_CatalogSearchResultDisplay_FormInput_skuCaseSensitive_In_JumpToPageForm_1"/>
				<input type="hidden" name="skuOperator" value="<c:out value="${WCParam.skuOperator}" />" id="WC_CatalogSearchResultDisplay_FormInput_skuOperator_In_JumpToPageForm_1"/>
				<input type="hidden" name="sku" value="<c:out value="${WCParam.sku}" />" id="WC_CatalogSearchResultDisplay_FormInput_sku_In_JumpToPageForm_1"/>
				
				<c:url value="CatalogSearchResultView" var="CatalogSearchResultViewFirstURL">
					<c:param name="storeId" value="${storeId}"/>
					<c:param name="langId" value="${langId}"/>
					<c:param name="catalogId" value="${catalogId}"/>
					<c:param name="searchTerm" value="${WCParam.searchTerm}"/>
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
					<c:param name="manufacturer" value="${WCParam.manufacturer}"/>
					<c:param name="manufacturerCaseSensitive" value="${WCParam.manufacturerCaseSensitive}"/>
					<c:param name="manufacturerOperator" value="${WCParam.manufacturerOperator}"/>
					<c:param name="manufacturerPartNum" value="${WCParam.manufacturerPartNum}"/>
					<c:param name="manufacturerPartNumOperator" value="${WCParam.manufacturerPartNumOperator}"/>
					<c:param name="manufacturerPartNumCaseSensitive" value="${WCParam.manufacturerPartNumCaseSensitive}"/>
					<c:param name="skuCaseSensitive" value="${WCParam.skuCaseSensitive}"/>
					<c:param name="skuOperator" value="${WCParam.skuOperator}"/>
					<c:param name="sku" value="${WCParam.sku}"/>
				</c:url>
				
				<c:url value="CatalogSearchResultView" var="CatalogSearchResultViewPrevURL">
					<c:param name="storeId" value="${storeId}"/>
					<c:param name="langId" value="${langId}"/>
					<c:param name="catalogId" value="${catalogId}"/>
					<c:param name="searchTerm" value="${WCParam.searchTerm}"/>
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
					<c:param name="manufacturer" value="${WCParam.manufacturer}"/>
					<c:param name="manufacturerCaseSensitive" value="${WCParam.manufacturerCaseSensitive}"/>
					<c:param name="manufacturerOperator" value="${WCParam.manufacturerOperator}"/>
					<c:param name="manufacturerPartNum" value="${WCParam.manufacturerPartNum}"/>
					<c:param name="manufacturerPartNumOperator" value="${WCParam.manufacturerPartNumOperator}"/>
					<c:param name="manufacturerPartNumCaseSensitive" value="${WCParam.manufacturerPartNumCaseSensitive}"/>
					<c:param name="skuCaseSensitive" value="${WCParam.skuCaseSensitive}"/>
					<c:param name="skuOperator" value="${WCParam.skuOperator}"/>
					<c:param name="sku" value="${WCParam.sku}"/>
				</c:url>
				
				<c:url value="CatalogSearchResultView" var="CatalogSearchResultViewNextURL">
					<c:param name="storeId" value="${storeId}"/>
					<c:param name="langId" value="${langId}"/>
					<c:param name="catalogId" value="${catalogId}"/>
					<c:param name="searchTerm" value="${WCParam.searchTerm}"/>
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
					<c:param name="manufacturer" value="${WCParam.manufacturer}"/>
					<c:param name="manufacturerCaseSensitive" value="${WCParam.manufacturerCaseSensitive}"/>
					<c:param name="manufacturerOperator" value="${WCParam.manufacturerOperator}"/>
					<c:param name="manufacturerPartNum" value="${WCParam.manufacturerPartNum}"/>
					<c:param name="manufacturerPartNumOperator" value="${WCParam.manufacturerPartNumOperator}"/>
					<c:param name="manufacturerPartNumCaseSensitive" value="${WCParam.manufacturerPartNumCaseSensitive}"/>
					<c:param name="skuCaseSensitive" value="${WCParam.skuCaseSensitive}"/>
					<c:param name="skuOperator" value="${WCParam.skuOperator}"/>
					<c:param name="sku" value="${WCParam.sku}"/>
				</c:url>
				<c:url value="CatalogSearchResultView" var="CatalogSearchResultViewLastURL">
					<c:param name="storeId" value="${storeId}"/>
					<c:param name="langId" value="${langId}"/>
					<c:param name="catalogId" value="${catalogId}"/>
					<c:param name="searchTerm" value="${WCParam.searchTerm}"/>
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
					<c:param name="manufacturer" value="${WCParam.manufacturer}"/>
					<c:param name="manufacturerCaseSensitive" value="${WCParam.manufacturerCaseSensitive}"/>
					<c:param name="manufacturerOperator" value="${WCParam.manufacturerOperator}"/>
					<c:param name="manufacturerPartNum" value="${WCParam.manufacturerPartNum}"/>
					<c:param name="manufacturerPartNumOperator" value="${WCParam.manufacturerPartNumOperator}"/>
					<c:param name="manufacturerPartNumCaseSensitive" value="${WCParam.manufacturerPartNumCaseSensitive}"/>
					<c:param name="skuCaseSensitive" value="${WCParam.skuCaseSensitive}"/>
					<c:param name="skuOperator" value="${WCParam.skuOperator}"/>
					<c:param name="sku" value="${WCParam.sku}"/>
				</c:url>

                      	</c:when>
			<c:otherwise>
			
				<c:url value="CatalogSearchResultView" var="CatalogSearchResultViewFirstURL">
					<c:param name="storeId" value="${storeId}"/>
					<c:param name="langId" value="${langId}"/>
					<c:param name="catalogId" value="${catalogId}"/>
					<c:param name="searchTerm" value="${WCParam.searchTerm}"/>
					<c:param name="pageSize" value="${pageSize}"/>
					<c:param name="beginIndex" value="0"/>
					<c:param name="sType" value="${WCParam.sType}"/>
					<c:param name="searchTermScope" value="${WCParam.searchTermScope}"/>
				</c:url>
				<c:url value="CatalogSearchResultView" var="CatalogSearchResultViewPrevURL">
					<c:param name="storeId" value="${storeId}"/>
					<c:param name="langId" value="${langId}"/>
					<c:param name="catalogId" value="${catalogId}"/>
					<c:param name="searchTerm" value="${WCParam.searchTerm}"/>
					<c:param name="pageSize" value="${pageSize}"/>
					<c:param name="beginIndex" value="${prevPageIndex}"/>
					<c:param name="sType" value="${WCParam.sType}"/>
					<c:param name="searchTermScope" value="${WCParam.searchTermScope}"/>
				</c:url>
				<c:url value="CatalogSearchResultView" var="CatalogSearchResultViewNextURL">
					<c:param name="storeId" value="${storeId}"/>
					<c:param name="langId" value="${langId}"/>
					<c:param name="catalogId" value="${catalogId}"/>
					<c:param name="searchTerm" value="${WCParam.searchTerm}"/>
					<c:param name="pageSize" value="${pageSize}"/>
					<c:param name="beginIndex" value="${nextPageIndex}"/>
					<c:param name="sType" value="${WCParam.sType}"/>
					<c:param name="searchTermScope" value="${WCParam.searchTermScope}"/>
				</c:url>
				<c:url value="CatalogSearchResultView" var="CatalogSearchResultViewLastURL">
					<c:param name="storeId" value="${storeId}"/>
					<c:param name="langId" value="${langId}"/>
					<c:param name="catalogId" value="${catalogId}"/>
					<c:param name="searchTerm" value="${WCParam.searchTerm}"/>
					<c:param name="pageSize" value="${pageSize}"/>
					<c:param name="beginIndex" value="${(catEntSearchListBean.totalNumberOfResultSetPages-1) * catEntSearchListBean.pageSize}"/>
					<c:param name="sType" value="${WCParam.sType}"/>
					<c:param name="searchTermScope" value="${WCParam.searchTermScope}"/>
				</c:url>
			</c:otherwise>
		</c:choose>
		
<!--	<form name="JumpToPageForm" action="CatalogSearchResultView" method="post" id="JumpToPageForm"> 
		<input type="hidden" name="storeId" value="<c:out value="${WCParam.storeId}" />" id="WC_CatalogSearchResultDisplay_FormInput_storeId_In_JumpToPageForm_1"/>
		<input type="hidden" name="langId" value="<c:out value="${langId}" />" id="WC_CatalogSearchResultDisplay_FormInput_langId_In_JumpToPageForm_1"/>
		<input type="hidden" name="catalogId" value="<c:out value="${WCParam.catalogId}" />" id="WC_CatalogSearchResultDisplay_FormInput_catalogId_In_JumpToPageForm_1"/>
		<input type="hidden" name="searchTerm" value="<c:out value="${WCParam.searchTerm}" />" id="WC_CatalogSearchResultDisplay_FormInput_searchTermScope_In_JumpToPageForm_1"/>
		<input type="hidden" name="pageSize" value="<c:out value="${pageSize}" />" id="WC_CatalogSearchResultDisplay_FormInput_pageSize_In_JumpToPageForm_1"/>
		<input type="hidden" name="beginIndex" value="0" id="WC_CatalogSearchResultDisplay_FormInput_beginIndex_In_JumpToPageForm_1"/>
		<input type="hidden" name="sType" value="<c:out value="${WCParam.sType}" />" id="WC_CatalogSearchResultDisplay_FormInput_sType_In_JumpToPageForm_1"/>
		<input type="hidden" name="searchTermScope" value="<c:out value="${WCParam.searchTermScope}" />" id="WC_CatalogSearchResultDisplay_FormInput_searchTermScope_In_JumpToPageForm_1"/>
-->
		<table cellpadding="0" cellspacing="0" border="0" class="t_table" id="WC_CatalogSearchResultDisplay_Table_2">
			<tr>
				<td id="WC_CatalogSearchResultDisplay_TableCell_2">	
					<table cellpadding="0" cellspacing="0" border="0" id="WC_CatalogSearchResultDisplay_Table_3">
						<tr>
							<td id="WC_CatalogSearchResultDisplay_TableCell_5"><a href="<c:out value="${CatalogSearchResultViewFirstURL}" />" id="WC_CatalogSearchResultDisplay_Link_1"><img src="<c:out value="${jspStoreImgDir}${vfileColor}"/>ps_first.gif" alt="" width="14" height="14" border="0"></a></td>																					
							<td class="ps_pad" id="WC_CatalogSearchResultDisplay_TableCell_6"><a href="<c:out value="${CatalogSearchResultViewPrevURL}" />" id="WC_CatalogSearchResultDisplay_Link_2"><img src="<c:out value="${jspStoreImgDir}${vfileColor}"/>ps_previous.gif" alt="" width="14" height="14" border="0"></a></td>
							<fmt:message var="pageNumberText" key="PAGE_NUMBER" bundle="${storeText}">
								<fmt:param><c:out value="${catEntSearchListBean.currentPageNumber}" /></fmt:param>
								<fmt:param><c:out value="${catEntSearchListBean.totalNumberOfResultSetPages}" /></fmt:param>
							</fmt:message>
							<td class="ps_text" id="WC_CatalogSearchResultDisplay_TableCell_7"><c:out value="${pageNumberText}" /></td>																		
							<td class="ps_pad" id="WC_CatalogSearchResultDisplay_TableCell_8"><a href="<c:out value="${CatalogSearchResultViewNextURL}" />" id="WC_CatalogSearchResultDisplay_Link_3"><img src="<c:out value="${jspStoreImgDir}${vfileColor}"/>ps_next.gif" alt="" width="14" height="14" border="0"></a></td>									
							<td class="ps_pad" id="WC_CatalogSearchResultDisplay_TableCell_9"><a href="<c:out value="${CatalogSearchResultViewLastURL}" />" id="WC_CatalogSearchResultDisplay_Link_4"><img src="<c:out value="${jspStoreImgDir}${vfileColor}"/>ps_last.gif" alt="" width="14" height="14" border="0"></a></td>
							<td class="ps_text" id="WC_CatalogSearchResultDisplay_TableCell_10"><label for="WC_CatalogSearchResult_JumpToPage"><fmt:message key="JUMP_TO_PAGE" bundle="${storeText}"/></label></td>
							<td class="ps_pad" id="WC_CatalogSearchResultDisplay_TableCell_11"><input type="text" maxlength="4" size="3" class="ps_input" name="jumpToPage" id="WC_CatalogSearchResult_JumpToPage"></td>
							<td class="ps_pad" id="WC_CatalogSearchResultDisplay_TableCell_12"><a href="javascript:submitSearch(document.JumpToPageForm);" id="WC_CatalogSearchResultDisplay_Link_5"><img src="<c:out value="${jspStoreImgDir}${vfileColor}"/>ps_page_jump.gif" alt="" width="16" height="16" border="0"></a></td>
						</tr>
					</table>
				</td>
				<td align="right" id="WC_CatalogSearchResultDisplay_TableCell_12a">
					<table cellpadding="0" cellspacing="0" border="0" id="WC_CatalogSearchResultDisplay_Table_3a">
						<tr>
							<td class="ps_text" id="WC_CatalogSearchResultDisplay_TableCell_301"><c:out value="${resultsText}" /></td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
		</form>
		
	  <!-- Start search result table -->
		<table  cellpadding="2" cellspacing="1" border="0" class="bgColor" id="WC_CatalogSearchResultDisplay_Table_4">
			<tr>
				<th class="colHeader" id="WC_CatalogSearchResultDisplay_DescHeader"><fmt:message key="SerRes_Description" bundle="${storeText}" /></th>
				<th class="colHeader_price" id="WC_CatalogSearchResultDisplay_PriceHeader"><fmt:message key="SerRes_Price" bundle="${storeText}"/></th>
				<th class="colHeader_last" id="WC_CatalogSearchResultDisplay_OrderHeader"></th>
			</tr>
			<c:forEach var="catEntry" items="${catEntSearchListBean.resultList}" varStatus="counter">
				<c:set property="commandContext" value="${catEntSearchListBean.commandContext}" target="${catEntry}"/>
				<c:set var="catalogEntryIdForPriceRule" value="${catEntry.catalogEntryID}"/>
				<%@ include file="../../../Snippets/ReusableObjects/GetCatalogEntryDisplayPrice.jspf"%>
				<c:choose>
					<c:when test="${catEntry.product}">
						<%-- convert the catEntry to the product bean --%>
						<c:set var="product" value="${catEntry.productDataBean}"/>
						<tr>
							<td headers="WC_CatalogSearchResultDisplay_DescHeader" valign="top" width="70%" class="cellBG_1 t_td" id="WC_CatalogSearchResultDisplay_TableCell_13_<c:out value="${counter.count}"/>">
							<%-- The URL that links to the product display page --%>
				                        <c:url var="productDisplayUrl" value="ProductDisplay">
				                                <c:param name="catalogId" value="${catalogId}"/>
				                                <c:param name="storeId" value="${storeId}"/>
				                                <c:param name="productId" value="${product.productID}"/>
				                                <c:param name="langId" value="${langId}"/>
				                        </c:url>
				                        <table id="WC_CatalogSearchResultDisplay_Table_5_<c:out value="${counter.count}"/>">
				                        	<tr>
				                        		<c:if test="${!empty product.description.thumbNail}">
				                        		<td valign="top" id="WC_CatalogSearchResultDisplay_TableCell_14_<c:out value="${counter.count}"/>">
										<a href="<c:out value="${productDisplayUrl}"/>" id="WC_CatalogSearchResultDisplay_Link_ForProductImg_<c:out value="${counter.count}"/>">
											<img src="<c:out value="${product.objectPath}"/><c:out value="${product.description.thumbNail}"/>" alt="<c:out value="${product.description.shortDescription}"/>" border="0"/>
										</a>
									</td>
									</c:if>
									<td valign="top" id="WC_CatalogSearchResultDisplay_TableCell_15_<c:out value="${counter.count}"/>">
										<a href="<c:out value="${productDisplayUrl}"/>" id="WC_CatalogSearchResultDisplay_Link_6_<c:out value="${counter.count}"/>">
											<c:out value="${product.description.name}" escapeXml="false"/>
										</a>
										<br />
										<c:out value="${product.description.longDescription}" escapeXml="false"/>
									</td>
								</tr>
							</table>
							</td>
							<td headers="WC_CatalogSearchResultDisplay_PriceHeader" valign="top" class="cellBG_1 t_td" id="WC_CatalogSearchResultDisplay_TableCell_16_<c:out value="${counter.count}"/>">
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
									<c:otherwise >
										<c:set var="productPriceString" value="${product.minimumItemPrice} - ${product.maximumItemPrice}" />
									</c:otherwise>
								</c:choose>
								<%-- Determine if the list price will be displayed along with the product's offer price --%>
								<c:choose>
									<%-- show the list price only if it is larger than the product price and the product does not have price range (i.e. min price == max price) --%>
									<c:when test="${ listPriced && (!empty product.maximumItemPrice) && (product.maximumItemPrice.amount < displayPrice.amount) && (product.maximumItemPrice.amount == product.minimumItemPrice.amount)}" >
										<!-- 
										The empty gif are put in front of the prices so that the alt text can be read by the IBM Homepage Reader to describe the two prices displayed. 
										These descriptions are necessary for meeting Accessibility requirements 
										-->
										<a href="#" id="WC_CatalogSearchResultDisplay_Link_7_<c:out value="${counter.count}"/>"><img src="<c:out value="${jspStoreImgDir}" />images/empty.gif" alt='<fmt:message key="RegularPriceIs" bundle="${storeText}" />' width="1" height="1" border="0"/></a>
										<span class="listPrice"><c:out value="${displayPrice}" escapeXml="false"/></span>
										<br />
										<!-- 
										The empty gif are put in front of the prices so that the alt text can be read by the IBM Homepage Reader to describe the two prices displayed. 
										These descriptions are necessary for meeting Accessibility requirements 
										-->
										<a href="#" id="WC_CatalogSearchResultDisplay_Link_8_<c:out value="${counter.count}"/>"><img src="<c:out value="${jspStoreImgDir}" />images/empty.gif" alt='<fmt:message key="SalePriceIs" bundle="${storeText}" />' width="1" height="1" border="0"/></a>
										<span class="redPrice"><c:out value="${productPriceString}" escapeXml="false"/></span>
									</c:when>
									
									<c:otherwise >
										<!-- 
										The empty gif are put in front of the prices so that the alt text can be read by the IBM Homepage Reader to describe the two prices displayed. 
										These descriptions are necessary for meeting Accessibility requirements 
										-->
										<a href="#" id="WC_CatalogSearchResultDisplay_Link_9_<c:out value="${counter.count}"/>"><img src="<c:out value="${jspStoreImgDir}" />images/empty.gif" alt='<fmt:message key="PriceIs" bundle="${storeText}" />' width="1" height="1" border="0"/></a>
										<span class="price"><c:out value="${productPriceString}" escapeXml="false"/></span>
									</c:otherwise>
								</c:choose>
							</td>
							<td headers="WC_CatalogSearchResultDisplay_OrderHeader" class="cellBG_1 t_td" id="WC_CatalogSearchResultDisplay_TableCell_17_<c:out value="${counter.count}"/>">
							
							</td>
						</tr>
					</c:when>	
					<c:when test="${catEntry.item}">
						<c:set var="item" value="${catEntry.itemDataBean}"/>
						<tr>
							<td headers="WC_CatalogSearchResultDisplay_DescHeader" valign="top" class="cellBG_1 t_td" width="70%" id="WC_CatalogSearchResultDisplay_TableCell_18_<c:out value="${counter.count}"/>">
								<%-- The URL that links to the product display page for the item --%>
					                        <c:url var="itemDisplayUrl" value="ProductDisplay">
					                                <c:param name="catalogId" value="${catalogId}"/>
					                                <c:param name="storeId" value="${storeId}"/>
					                                <c:param name="productId" value="${item.itemID}"/>
					                                <c:param name="langId" value="${langId}"/>
					                        </c:url>
								<table id="WC_CatalogSearchResultDisplay_Table_6_<c:out value="${counter.count}"/>">
				                        		<tr>
				                        		
			                        			<c:if test="${!empty item.description.thumbNail}">
			                        				<td valign="top" id="WC_CatalogSearchResultDisplay_TableCell_19_<c:out value="${counter.count}"/>">
						                                	<a href="<c:out value="${itemDisplayUrl}"/>" id="WC_CatalogSearchResultDisplay_Link_ForItemImg_<c:out value="${counter.count}"/>">
						                        		<img src="<c:out value="${item.objectPath}"/><c:out value="${item.description.thumbNail}"/>" alt="<c:out value="${item.description.shortDescription}"/>" border="0"/>
							                        	</a>
							                        </td>
				                			</c:if>
									<td valign="top" id="WC_CatalogSearchResultDisplay_TableCell_20_<c:out value="${counter.count}"/>">
										<a href="<c:out value="${itemDisplayUrl}"/>" id="WC_CatalogSearchResultDisplay_Link_10_<c:out value="${counter.count}"/>">
											<c:out value="${item.description.name}" escapeXml="false"/>
										</a>
										<br />
										<c:out value="${item.description.longDescription}" escapeXml="false"/>
									</td>
									</tr>
								</table>
							</td>
							<td headers="WC_CatalogSearchResultDisplay_PriceHeader" valign="top" class="cellBG_1 t_td" id="WC_CatalogSearchResultDisplay_TableCell_21_<c:out value="${counter.count}"/>">
								<c:choose>
									<%-- show the list price only if it is larger than the item price  --%>
									<c:when test="${ listPriced && item.calculatedContractPriced && (item.calculatedContractPrice.amount < displayPrice.amount)}" >
										<!-- 
										The empty gif are put in front of the prices so that the alt text can be read by the IBM Homepage Reader to describe the two prices displayed. 
										These descriptions are necessary for meeting Accessibility requirements 
										-->
										<a href="#" id="WC_CatalogSearchResultDisplay_Link_11_<c:out value="${counter.count}"/>"><img src="<c:out value="${jspStoreImgDir}" />images/empty.gif" alt='<fmt:message key="RegularPriceIs" bundle="${storeText}" />' width="1" height="1" border="0"/></a>
										<span class="listPrice"><c:out value="${displayPrice}" escapeXml="false"/></span>
										<br />
										<!-- 
										The empty gif are put in front of the prices so that the alt text can be read by the IBM Homepage Reader to describe the two prices displayed. 
										These descriptions are necessary for meeting Accessibility requirements 
										-->
										<a href="#" id="WC_CatalogSearchResultDisplay_Link_12_<c:out value="${counter.count}"/>"><img src="<c:out value="${jspStoreImgDir}" />images/empty.gif" alt='<fmt:message key="SalePriceIs" bundle="${storeText}" />' width="1" height="1" border="0"/></a>
										<span class="redPrice"><c:out value="${item.calculatedContractPrice}" escapeXml="false"/></span>
									</c:when>
									
									<c:otherwise >
										<!-- 
										The empty gif are put in front of the prices so that the alt text can be read by the IBM Homepage Reader to describe the two prices displayed. 
										These descriptions are necessary for meeting Accessibility requirements 
										-->
										<a href="#" id="WC_CatalogSearchResultDisplay_Link_13_<c:out value="${counter.count}"/>"><img src="<c:out value="${jspStoreImgDir}" />images/empty.gif" alt='<fmt:message key="PriceIs" bundle="${storeText}" />' width="1" height="1" border="0"/></a>
										<span class="price"><c:out value="${item.calculatedContractPrice}" escapeXml="false"/></span>
									</c:otherwise>
								</c:choose>
							</td>
							<td headers="WC_CatalogSearchResultDisplay_OrderHeader" class="cellBG_1 t_td" id="WC_CatalogSearchResultDisplay_TableCell_22_<c:out value="${counter.count}"/>">
								<a href='javascript:Add2ShopCart(document.OrderItemAddForm, <c:out value="${item.itemID}" />)' class="t_button" id="WC_CatalogSearchResultDisplay_Link_14_<c:out value="${counter.count}"/>">
									<fmt:message key="SerRes_Order" bundle="${storeText}"/>
								</a>
							</td>
						</tr>
					</c:when>
					<c:when test="${catEntry.bundle}">
						<c:set var="bundle" value="${catEntry.bundleDataBean}"/>
						<tr>
							<td headers="WC_CatalogSearchResultDisplay_DescHeader" valign="top" class="cellBG_1 t_td" width="70%" id="WC_CatalogSearchResultDisplay_TableCell_18_<c:out value="${counter.count}"/>">
								<%-- The URL that links to the product display page for the bundle --%>
					                        <c:url var="bundleDisplayUrl" value="ProductDisplay">
					                                <c:param name="catalogId" value="${catalogId}"/>
					                                <c:param name="storeId" value="${storeId}"/>
					                                <c:param name="productId" value="${bundle.bundleID}"/>
					                                <c:param name="langId" value="${langId}"/>
					                        </c:url>
								<table id="WC_CatalogSearchResultDisplay_Table_6_<c:out value="${counter.count}"/>">
				                        		<tr>
				                        		
			                        			<c:if test="${!empty bundle.description.thumbNail}">
			                        				<td valign="top" id="WC_CatalogSearchResultDisplay_TableCell_19_<c:out value="${counter.count}"/>">
						                                	<a href="<c:out value="${bundleDisplayUrl}"/>" id="WC_CatalogSearchResultDisplay_Link_ForBundleImg_<c:out value="${counter.count}"/>">
						                        		<img src="<c:out value="${bundle.objectPath}"/><c:out value="${bundle.description.thumbNail}"/>" alt="<c:out value="${bundle.description.shortDescription}"/>" border="0"/>
							                        	</a>
							                        </td>
				                			</c:if>
									<td valign="top" id="WC_CatalogSearchResultDisplay_TableCell_20_<c:out value="${counter.count}"/>">
										<a href="<c:out value="${bundleDisplayUrl}"/>" id="WC_CatalogSearchResultDisplay_Link_10_<c:out value="${counter.count}"/>">
											<c:out value="${bundle.description.name}" escapeXml="false"/>
										</a>
										<br />
										<c:out value="${bundle.description.longDescription}" escapeXml="false"/>
									</td>
									</tr>
								</table>
							</td>
							<td headers="WC_CatalogSearchResultDisplay_PriceHeader" valign="top" class="cellBG_1 t_td" id="WC_CatalogSearchResultDisplay_TableCell_21_<c:out value="${counter.count}"/>">
								<c:choose>
									<%-- show the list price only if it is larger than the bundle price  --%>
									<c:when test="${listPriced && bundle.calculatedContractPriced && (bundle.calculatedContractPrice.amount < displayPrice.amount)}" >
										<!-- 
										The empty gif are put in front of the prices so that the alt text can be read by the IBM Homepage Reader to describe the two prices displayed. 
										These descriptions are necessary for meeting Accessibility requirements 
										-->
										<a href="#" id="WC_CatalogSearchResultDisplay_Link_11_<c:out value="${counter.count}"/>"><img src="<c:out value="${jspStoreImgDir}" />images/empty.gif" alt='<fmt:message key="RegularPriceIs" bundle="${storeText}" />' width="1" height="1" border="0"/></a>
										<span class="listPrice"><c:out value="${displayPrice}" escapeXml="false"/></span>
										<br />
										<!-- 
										The empty gif are put in front of the prices so that the alt text can be read by the IBM Homepage Reader to describe the two prices displayed. 
										These descriptions are necessary for meeting Accessibility requirements 
										-->
										<a href="#" id="WC_CatalogSearchResultDisplay_Link_12_<c:out value="${counter.count}"/>"><img src="<c:out value="${jspStoreImgDir}" />images/empty.gif" alt='<fmt:message key="SalePriceIs" bundle="${storeText}" />' width="1" height="1" border="0"/></a>
										<span class="redPrice"><c:out value="${bundle.calculatedContractPrice}" escapeXml="false"/></span>
									</c:when>
									
									<c:otherwise >
										<!-- 
										The empty gif are put in front of the prices so that the alt text can be read by the IBM Homepage Reader to describe the two prices displayed. 
										These descriptions are necessary for meeting Accessibility requirements 
										-->
										<a href="#" id="WC_CatalogSearchResultDisplay_Link_13_<c:out value="${counter.count}"/>"><img src="<c:out value="${jspStoreImgDir}" />images/empty.gif" alt='<fmt:message key="PriceIs" bundle="${storeText}" />' width="1" height="1" border="0"/></a>
										<span class="price"><c:out value="${bundle.calculatedContractPrice}" escapeXml="false"/></span>
									</c:otherwise>
								</c:choose>
							</td>
							<td headers="WC_CatalogSearchResultDisplay_OrderHeader" class="cellBG_1 t_td" id="WC_CatalogSearchResultDisplay_TableCell_22_<c:out value="${counter.count}"/>">
								<a href='javascript:Add2ShopCart(document.OrderItemAddForm, <c:out value="${bundle.bundleID}" />)' class="t_button" id="WC_CatalogSearchResultDisplay_Link_14_<c:out value="${counter.count}"/>">
									<fmt:message key="SerRes_Order" bundle="${storeText}"/>
								</a>
							</td>
						</tr>
					</c:when>
					<c:when test="${catEntry.package}">
						<c:set var="package" value="${catEntry.packageDataBean}"/>
						<tr>
							<td headers="WC_CatalogSearchResultDisplay_DescHeader" valign="top" class="cellBG_1 t_td" width="70%" id="WC_CatalogSearchResultDisplay_TableCell_18_<c:out value="${counter.count}"/>">
								<%-- The URL that links to the product display page for the package --%>
					                        <c:url var="packageDisplayUrl" value="ProductDisplay">
					                                <c:param name="catalogId" value="${catalogId}"/>
					                                <c:param name="storeId" value="${storeId}"/>
					                                <c:param name="productId" value="${package.packageID}"/>
					                                <c:param name="langId" value="${langId}"/>
					                        </c:url>
								<table id="WC_CatalogSearchResultDisplay_Table_6_<c:out value="${counter.count}"/>">
				                        		<tr>
				                        		
			                        			<c:if test="${!empty package.description.thumbNail}">
			                        				<td valign="top" id="WC_CatalogSearchResultDisplay_TableCell_19_<c:out value="${counter.count}"/>">
						                                	<a href="<c:out value="${packageDisplayUrl}"/>" id="WC_CatalogSearchResultDisplay_Link_ForPackageImg_<c:out value="${counter.count}"/>">
						                        		<img src="<c:out value="${package.objectPath}"/><c:out value="${package.description.thumbNail}"/>" alt="<c:out value="${package.description.shortDescription}"/>" border="0"/>
							                        	</a>
							                        </td>
				                			</c:if>
									<td valign="top" id="WC_CatalogSearchResultDisplay_TableCell_20_<c:out value="${counter.count}"/>">
										<a href="<c:out value="${packageDisplayUrl}"/>" id="WC_CatalogSearchResultDisplay_Link_10_<c:out value="${counter.count}"/>">
											<c:out value="${package.description.name}" escapeXml="false"/>
										</a>
										<br />
										<c:out value="${package.description.longDescription}" escapeXml="false"/>
									</td>
									</tr>
								</table>
							</td>
							<td headers="WC_CatalogSearchResultDisplay_PriceHeader" valign="top" class="cellBG_1 t_td" id="WC_CatalogSearchResultDisplay_TableCell_21_<c:out value="${counter.count}"/>">
								<c:choose>
									<%-- show the list price only if it is larger than the package price  --%>
									<c:when test="${ listPriced && package.calculatedContractPriced && (package.calculatedContractPrice.amount < displayPrice.amount)}" >
										<!-- 
										The empty gif are put in front of the prices so that the alt text can be read by the IBM Homepage Reader to describe the two prices displayed. 
										These descriptions are necessary for meeting Accessibility requirements 
										-->
										<a href="#" id="WC_CatalogSearchResultDisplay_Link_11_<c:out value="${counter.count}"/>"><img src="<c:out value="${jspStoreImgDir}" />images/empty.gif" alt='<fmt:message key="RegularPriceIs" bundle="${storeText}" />' width="1" height="1" border="0"/></a>
										<span class="listPrice"><c:out value="${displayPrice}" escapeXml="false"/></span>
										<br />
										<!-- 
										The empty gif are put in front of the prices so that the alt text can be read by the IBM Homepage Reader to describe the two prices displayed. 
										These descriptions are necessary for meeting Accessibility requirements 
										-->
										<a href="#" id="WC_CatalogSearchResultDisplay_Link_12_<c:out value="${counter.count}"/>"><img src="<c:out value="${jspStoreImgDir}" />images/empty.gif" alt='<fmt:message key="SalePriceIs" bundle="${storeText}" />' width="1" height="1" border="0"/></a>
										<span class="redPrice"><c:out value="${package.calculatedContractPrice}" escapeXml="false"/></span>
									</c:when>
									
									<c:otherwise >
										<!-- 
										The empty gif are put in front of the prices so that the alt text can be read by the IBM Homepage Reader to describe the two prices displayed. 
										These descriptions are necessary for meeting Accessibility requirements 
										-->
										<a href="#" id="WC_CatalogSearchResultDisplay_Link_13_<c:out value="${counter.count}"/>"><img src="<c:out value="${jspStoreImgDir}" />images/empty.gif" alt='<fmt:message key="PriceIs" bundle="${storeText}" />' width="1" height="1" border="0"/></a>
										<span class="price"><c:out value="${package.calculatedContractPrice}" escapeXml="false"/></span>
									</c:otherwise>
								</c:choose>
							</td>
							<td headers="WC_CatalogSearchResultDisplay_OrderHeader" class="cellBG_1 t_td" id="WC_CatalogSearchResultDisplay_TableCell_22_<c:out value="${counter.count}"/>">
								<a href='javascript:Add2ShopCart(document.OrderItemAddForm, <c:out value="${package.packageID}" />)' class="t_button" id="WC_CatalogSearchResultDisplay_Link_14_<c:out value="${counter.count}"/>">
									<fmt:message key="SerRes_Order" bundle="${storeText}"/>
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
		<input type="hidden" name="pageSize" value="<c:out value="${pageSize}" />" id="WC_CatalogSearchResultDisplay_FormInput_pageSize_In_JumpToPageForm2_1"/>
		<input type="hidden" name="beginIndex" value="0" id="WC_CatalogSearchResultDisplay_FormInput_beginIndex_In_JumpToPageForm2_1"/>
		<input type="hidden" name="sType" value="<c:out value="${WCParam.sType}" />" id="WC_CatalogSearchResultDisplay_FormInput_sType_In_JumpToPageForm2_1"/>
		<input type="hidden" name="searchTermScope" value="<c:out value="${WCParam.searchTermScope}" />" id="WC_CatalogSearchResultDisplay_FormInput_searchTermScope_In_JumpToPageForm2_1"/>

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
		<input type="hidden" name="manufacturer" value="<c:out value="${WCParam.manufacturer}" />" id="WC_CatalogSearchResultDisplay_FormInput_manufacturer_In_JumpToPageForm2_1"/>
		<input type="hidden" name="manufacturerCaseSensitive" value="<c:out value="${WCParam.manufacturerCaseSensitive}" />" id="WC_CatalogSearchResultDisplay_FormInput_manufacturerCaseSensitive_In_JumpToPageForm2_1"/>
		<input type="hidden" name="manufacturerOperator" value="<c:out value="${WCParam.manufacturerOperator}" />" id="WC_CatalogSearchResultDisplay_FormInput_manufacturerOperator_In_JumpToPageForm2_1"/>
		<input type="hidden" name="manufacturerPartNum" value="<c:out value="${WCParam.manufacturerPartNum}" />" id="WC_CatalogSearchResultDisplay_FormInput_manufacturerPartNum_In_JumpToPageForm2_1"/>
		<input type="hidden" name="manufacturerPartNumOperator" value="<c:out value="${WCParam.manufacturerPartNumOperator}" />" id="WC_CatalogSearchResultDisplay_FormInput_manufacturerPartNumOperator_In_JumpToPageForm2_1"/>
		<input type="hidden" name="manufacturerPartNumCaseSensitive" value="<c:out value="${WCParam.manufacturerPartNumCaseSensitive}" />" id="WC_CatalogSearchResultDisplay_FormInput_manufacturerPartNumCaseSensitive_In_JumpToPageForm2_1"/>
		<input type="hidden" name="skuCaseSensitive" value="<c:out value="${WCParam.skuCaseSensitive}" />" id="WC_CatalogSearchResultDisplay_FormInput_skuCaseSensitive_In_JumpToPageForm2_1"/>
		<input type="hidden" name="skuOperator" value="<c:out value="${WCParam.skuOperator}" />" id="WC_CatalogSearchResultDisplay_FormInput_skuOperator_In_JumpToPageForm2_1"/>
		<input type="hidden" name="sku" value="<c:out value="${WCParam.sku}" />" id="WC_CatalogSearchResultDisplay_FormInput_sku_In_JumpToPageForm2_1"/>


		<table cellpadding="0" cellspacing="0" border="0" class="t_table" id="WC_CatalogSearchResultDisplay_Table_2">
			<tr>
				<td id="WC_CatalogSearchResultDisplay_TableCell_2">	
					<table cellpadding="0" cellspacing="0" border="0" id="WC_CatalogSearchResultDisplay_Table_3">
						<tr>
							<td id="WC_CatalogSearchResultDisplay_TableCell_5"><a href="<c:out value="${CatalogSearchResultViewFirstURL}" />" id="WC_CatalogSearchResultDisplay_Link_1"><img src="<c:out value="${jspStoreImgDir}${vfileColor}"/>ps_first.gif" alt="" width="14" height="14" border="0"></a></td>																					
							<td class="ps_pad" id="WC_CatalogSearchResultDisplay_TableCell_6"><a href="<c:out value="${CatalogSearchResultViewPrevURL}" />" id="WC_CatalogSearchResultDisplay_Link_2"><img src="<c:out value="${jspStoreImgDir}${vfileColor}"/>ps_previous.gif" alt="" width="14" height="14" border="0"></a></td>
							<fmt:message var="pageNumberText" key="PAGE_NUMBER" bundle="${storeText}">
								<fmt:param><c:out value="${catEntSearchListBean.currentPageNumber}" /></fmt:param>
								<fmt:param><c:out value="${catEntSearchListBean.totalNumberOfResultSetPages}" /></fmt:param>
							</fmt:message>
							<td class="ps_text" id="WC_CatalogSearchResultDisplay_TableCell_7"><c:out value="${pageNumberText}" /></td>																		
							<td class="ps_pad" id="WC_CatalogSearchResultDisplay_TableCell_8"><a href="<c:out value="${CatalogSearchResultViewNextURL}" />" id="WC_CatalogSearchResultDisplay_Link_3"><img src="<c:out value="${jspStoreImgDir}${vfileColor}"/>ps_next.gif" alt="" width="14" height="14" border="0"></a></td>									
							<td class="ps_pad" id="WC_CatalogSearchResultDisplay_TableCell_9"><a href="<c:out value="${CatalogSearchResultViewLastURL}" />" id="WC_CatalogSearchResultDisplay_Link_4"><img src="<c:out value="${jspStoreImgDir}${vfileColor}"/>ps_last.gif" alt="" width="14" height="14" border="0"></a></td>
							<td class="ps_text" id="WC_CatalogSearchResultDisplay_TableCell_10"><label for="WC_CatalogSearchResult_JumpToPage"><fmt:message key="JUMP_TO_PAGE" bundle="${storeText}"/></label></td>
							<td class="ps_pad" id="WC_CatalogSearchResultDisplay_TableCell_11"><input type="text" maxlength="4" size="3" class="ps_input" name="jumpToPage" id="WC_CatalogSearchResult_JumpToPage"></td>
							<td class="ps_pad" id="WC_CatalogSearchResultDisplay_TableCell_12"><a href="javascript:submitSearch(document.JumpToPageForm2);" id="WC_CatalogSearchResultDisplay_Link_5"><img src="<c:out value="${jspStoreImgDir}${vfileColor}"/>ps_page_jump.gif" alt="" width="16" height="16" border="0"></a></td>
						</tr>
					</table>
				</td>
				<td align="right" id="WC_CatalogSearchResultDisplay_TableCell_12a">
					<table cellpadding="0" cellspacing="0" border="0" id="WC_CatalogSearchResultDisplay_Table_3a">
						<tr>
							<td class="ps_text" id="WC_CatalogSearchResultDisplay_TableCell_301"><c:out value="${resultsText}" /></td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
		</form>

	</c:if>
	<!-- End search result table -->
	
	<!--show search tip if no results-->
	<c:if test="${catEntSearchListBean.resultCount == 0 && beginIndex == 0}">
		<table cellpadding="0" cellspacing="0" border="0" id="WC_CatalogSearchResultDisplay_Table_7">
			<tbody>
			<tr>
				<td id="WC_CatalogSearchResultDisplay_TableCell_23">
					<fmt:message key="SerRes_Text4" bundle="${storeText}"/>
					<ul>
					<li><fmt:message key="SerRes_Text5" bundle="${storeText}"/></li>
					<li><fmt:message key="SerRes_Text6" bundle="${storeText}"/></li>
					<li><fmt:message key="SerRes_Text7" bundle="${storeText}"/></li>
					<li><fmt:message key="SerRes_Text8" bundle="${storeText}"/></li>
					</ul>
				</td>
			</tr>
			<tr>
				<td  id="WC_CatalogSearchResultDisplay_TableCell_24">
					<!-- Start Back to Search Page Button -->
					<c:choose>
						<c:when test="${WCParam.sType == 'AdvancedSearch'}"> 
							<a class="button" href="<c:out value="${AdvancedSearchViewURL}"/>" id="WC_CatalogSearchResultDisplay_Link_15"><fmt:message key="Sidebar_Link1" bundle="${storeText}"/></a> 
						</c:when>
					</c:choose>
					<!-- End Back to Search Page Button -->
				</td>
			</tr>
		</table>
	</c:if>
              
       </td>
     </tr>
  <tbody>
</table>

<script language="javascript">
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
</script>

<!-- End Main JSP Content -->
<%@ include file="../../../include/LayoutContainerBottom.jspf"%>
</body>
<!-- END CatalogSearchResultDisplay.jsp -->
</html>

                                            
