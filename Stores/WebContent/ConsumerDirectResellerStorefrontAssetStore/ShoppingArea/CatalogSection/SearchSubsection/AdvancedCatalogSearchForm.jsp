<%
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
%>
<%-- 
  *****
  ** This JSP page allows a customer to submit multiple searching criteria to find catalog entries. The following searching criteria are supported:
  **  -- Key words to include or exclude in product name and description
  **  -- Manufacturer, part number, and SKU
  **  -- Search can be scoped by category
  *****
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf"%>
<%
/* If a search results in no records found, the previous button on the 
 *  result list page redirects the user to this page and we repopulate 
 * the form with data that the user entered.  Below we get the previous
 * search criteria.
 */
%>
<wcbase:useBean id="catalog" classname="com.ibm.commerce.catalog.beans.CatalogDataBean">
       <c:set target="${catalog}" property="catalogId" value="${WCParam.catalogId}"/>
</wcbase:useBean>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<!-- BEGIN AdvancedCatalogSearchForm.jsp -->
<head>
<title><fmt:message key="TITLE_ADVANCED_SEARCH" bundle="${storeText}"/></title>
<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}" /><c:out value="${vfileStylesheet}" />" type="text/css"/>
<script type="text/javascript" language="javascript">
<!-- <![CDATA[
var busy = false;
function submitSearch(form)
{
	//set the result catEntryType, which is checked on CatalogSearchResultDisplay.jsp: 
	// 1 = list items, packages, and bundles
	// 2 = list products, packages, and bundles
    
	if (!busy)
	{
		busy = true;

		form.searchTerm.value = form.searchTerm.value.replace(/^\s+/g, '').replace(/\s+$/g, '');
		
		form.minPrice.value = form.minPrice.value.replace(/^\s+/g, '').replace(/\s+$/g, '');
		form.maxPrice.value = form.maxPrice.value.replace(/^\s+/g, '').replace(/\s+$/g, '');
		
		
		if ((form.minPrice.value == "") && (form.maxPrice.value == ""))
		{
			form.resultCatEntryType.value = "2";
			form.currency.value="";
		}
		else
		{
			form.resultCatEntryType.value = "1";
		}
		
		form.submit();
	}
}
 //[[>-->        
</script>
</head>
<body>
<%@ include file="../../../include/LayoutContainerTop.jspf"%>
<!-- Start Main JSP Content -->

<h1><fmt:message key="TITLE_ADVANCED_SEARCH" bundle="${storeText}"/></h1>
	<form method="post" action="CatalogSearchResultView" name="AdvancedSearchForm" id="AdvancedSearchForm">
	<input type="hidden" name="storeId" value="<c:out value="${WCParam.storeId}" />" id="WC_AdvancedCatalogSearchForm_FormInput_storeId_In_AdvancedSearchForm_1"/>
	<input type="hidden" name="langId" value="<c:out value="${WCParam.langId}" />" id="WC_AdvancedCatalogSearchForm_FormInput_langId_In_AdvancedSearchForm_1"/>
	<input type="hidden" name="catalogId" value="<c:out value="${WCParam.catalogId}" />" id="WC_AdvancedCatalogSearchForm_FormInput_catalogId_In_AdvancedSearchForm_1"/>
	<%-- set the result catEntryType, which is checked on CatalogSearchResultDisplay.jsp: 
	  1 = list items, packages, and bundles
	  2 = list products, packages, and bundles
	--%>
	<input type="hidden" name="resultCatEntryType" value="2" id="WC_AdvancedCatalogSearchForm_FormInput_resultCatEntryType_In_AdvancedSearchForm_1"/>
        <input type="hidden" name="qtyAvailable" value="" id="WC_AdvancedCatalogSearchForm_FormInput_qtyAvailable_In_AdvancedSearchForm_1"/>
        <input type="hidden" name="qtyAvailableOperator" value="EQUAL" id="WC_AdvancedCatalogSearchForm_FormInput_qtyAvailableOperator_In_AdvancedSearchForm_1"/>
        <input type="hidden" name="qtyMeasure" value="" id="WC_AdvancedCatalogSearchForm_FormInput_qtyMeasure_In_AdvancedSearchForm_1"/>
        <input type="hidden" name="qtyMeasureCaseSensitive" value="" id="WC_AdvancedCatalogSearchForm_FormInput_qtyMeasureCaseSensitive_In_AdvancedSearchForm_1"/>
        <input type="hidden" name="qtyMeasureOperator" value="EQUAL" id="WC_AdvancedCatalogSearchForm_FormInput_qtyMeasureOperator_In_AdvancedSearchForm_1"/>	
	<input type="hidden" name="catgrpSchemaType" value="1" id="WC_AdvancedCatalogSearchForm_FormInput_catgrpSchemaType_In_AdvancedSearchForm_1"/>
	<input type="hidden" name="RASchemaType" value="1" id="WC_AdvancedCatalogSearchForm_FormInput_RASchemaType_In_AdvancedSearchForm_1"/>

<table cellpadding="0" cellspacing="0" border="0" class="t_table" id="WC_AdvancedCatalogSearchForm_Table_1">
	<tr>
		<td class="t_td2" id="WC_AdvancedCatalogSearchForm_TableCell_1"><label for="WC_AdvancedCatalogSearchForm_FormInput_searchTerm_In_AdvancedSearchForm_1"><fmt:message key="SEARCH_FOR" bundle="${storeText}"/></label></td>
	</tr>
	<tr>
		<td id="WC_AdvancedCatalogSearchForm_TableCell_2">
			<input id="WC_AdvancedCatalogSearchForm_FormInput_searchTerm_In_AdvancedSearchForm_1" size="40" maxlength="254" type="text" class="input" name="searchTerm" 
                            value="<c:choose><c:when test="${!empty WCParam.searchTerm}"><c:out value="${WCParam.searchTerm}"/></c:when><c:otherwise></c:otherwise></c:choose>" />
                        <label for="WC_AdvancedCatalogSearchForm_FormInput_searchType_In_AdvancedSearchForm_1"></label>
                        <select id="WC_AdvancedCatalogSearchForm_FormInput_searchType_In_AdvancedSearchForm_1" name="searchType" class="select" size="1">
                            <c:choose>
                                   <c:when test="${!empty WCParam.searchType && WCParam.searchType=='ALL'}">
                                          <option value="ALL" selected>
                                   </c:when>
                                   <c:otherwise>
                                          <option value="ALL">
                                   </c:otherwise>
                            </c:choose>
                            <fmt:message key="ALL_WORDS" bundle="${storeText}"/></option>
                            <c:choose>
                                   <c:when test="${!empty WCParam.searchType && WCParam.searchType=='ANY'}">
                                          <option value="ANY" selected>
                                   </c:when>
                                   <c:otherwise>
                                          <option value="ANY">
                                   </c:otherwise>
                            </c:choose>
                            <fmt:message key="ANY_WORDS" bundle="${storeText}"/></option>
                            <c:choose>
                                   <c:when test="${!empty WCParam.searchType && WCParam.searchType=='EXACT'}">
                                          <option value="EXACT" selected>
                                   </c:when>
                                   <c:otherwise>
                                          <option value="EXACT">
                                   </c:otherwise>
                            </c:choose>
                            <fmt:message key="EXACT_PHRASE" bundle="${storeText}"/></option>
                          </select>
                          <input type="hidden" name="searchTermCaseSensitive" value="no" id="WC_AdvancedCatalogSearchForm_FormInput_searchTermCaseSensitive_In_AdvancedSearchForm_1"/>
                          <input type="hidden" name="searchTermOperator" value="LIKE" id="WC_AdvancedCatalogSearchForm_FormInput_searchTermOperator_In_AdvancedSearchForm_1"/>
		</td>
	</tr>
	<tr>
		<td class="t_td2" id="WC_AdvancedCatalogSearchForm_TableCell_3"><label for="WC_AdvancedCatalogSearchForm_FormInput_filterTerm_In_AdvancedSearchForm_1"><fmt:message key="EXCLUDE_WORDS" bundle="${storeText}"/></label></td>
	</tr>
	<tr>
		<td id="WC_AdvancedCatalogSearchForm_TableCell_4">
			<input id="WC_AdvancedCatalogSearchForm_FormInput_filterTerm_In_AdvancedSearchForm_1" size="40" maxlength="254" type="text" class="input" name="filterTerm" value="<c:choose><c:when test="${!empty WCParam.filterTerm}"><c:out value="${WCParam.filterTerm}"/></c:when><c:otherwise></c:otherwise></c:choose>" />
                        <label for="WC_AdvancedCatalogSearchForm_FormInput_filterType_In_AdvancedSearchForm_1"></label>
                        <select id="WC_AdvancedCatalogSearchForm_FormInput_filterType_In_AdvancedSearchForm_1" name="filterType" class="select" size="1">
                            <c:choose>
                                   <c:when test="${!empty WCParam.filterType && WCParam.filterType=='ALL'}">
                                          <option value="ALL" selected>
                                   </c:when>
                                   <c:otherwise>
                                          <option value="ALL">
                                   </c:otherwise>
                            </c:choose>
                            <fmt:message key="ALL_WORDS" bundle="${storeText}"/></option>
                            <c:choose>
                                   <c:when test="${!empty WCParam.filterType && WCParam.filterType=='ANY'}">
                                          <option value="ANY" selected>
                                   </c:when>
                                   <c:otherwise>
                                          <option value="ANY">
                                   </c:otherwise>
                            </c:choose>
                            <fmt:message key="ANY_WORDS" bundle="${storeText}"/></option>
                            <c:choose>
                                   <c:when test="${!empty WCParam.filterType && WCParam.filterType=='EXACT'}">
                                          <option value="EXACT" selected>
                                   </c:when>
                                   <c:otherwise>
                                          <option value="EXACT">
                                   </c:otherwise>
                            </c:choose>
                            <fmt:message key="EXACT_PHRASE" bundle="${storeText}"/></option>
                          </select>
                          <input type="hidden" name="filterTermCaseSensitive" value="no" id="WC_AdvancedCatalogSearchForm_FormInput_filterTermCaseSensitive_In_AdvancedSearchForm_1"/>
                          <input type="hidden" name="filterTermOperator" value="LIKE" id="WC_AdvancedCatalogSearchForm_FormInput_filterTermOperator_In_AdvancedSearchForm_1"/>
		</td>
	</tr>
	<tr>
		<td class="t_td2" id="WC_AdvancedCatalogSearchForm_TableCell_5">
			<label for="WC_AdvancedCatalogSearchForm_FormInput_searchTermScope_In_AdvancedSearchForm_1">
			<fmt:message key="SEARCH_FOR_WORD_IN" bundle="${storeText}"/></label>
		</td>
	</tr>
	<tr>
		<td id="WC_AdvancedCatalogSearchForm_TableCell_6">
		<select id="WC_AdvancedCatalogSearchForm_FormInput_searchTermScope_In_AdvancedSearchForm_1" class="select" name="searchTermScope">
                            <c:choose>
                                   <c:when test="${!empty WCParam.searchTermScope && WCParam.searchTermScope=='1'}">
                                          <option value="1" selected>
                                   </c:when>
                                   <c:otherwise>
                                          <option value="1">
                                   </c:otherwise>
                            </c:choose>
                            <fmt:message key="PRODUCT_NAME_DESC" bundle="${storeText}"/> </option>
                            <c:choose>
                                   <c:when test="${!empty WCParam.searchTermScope && WCParam.searchTermScope=='2'}">
                                          <option value="2" selected>
                                   </c:when>
                                   <c:otherwise>
                                          <option value="2">
                                   </c:otherwise>
                            </c:choose>
                            <fmt:message key="PRODUCT_NAME_ONLY" bundle="${storeText}"/> </option>
                          </select>
		</td>
	</tr>
	<tr>
		<td class="t_td2" id="WC_AdvancedCatalogSearchForm_TableCell_7">
			<label for="WC_AdvancedCatalogSearchForm_FormInput_catGroupId_In_AdvancedSearchForm_1">
			<fmt:message key="SEARCH_IN1" bundle="${storeText}"/></label>
		</td>
	</tr>
	<tr>
		<td id="WC_AdvancedCatalogSearchForm_TableCell_8">
			<select id="WC_AdvancedCatalogSearchForm_FormInput_catGroupId_In_AdvancedSearchForm_1" class="select" name="catGroupId">
				<option value=""><fmt:message key="ALL_CATEGORIES" bundle="${storeText}"/></option>
				<c:forEach var="topCategory" items="${catalog.topCategories}" varStatus="counter">
					<%// Get sub categories for the top category%>
					<c:forEach var="subCategory" items="${topCategory.subCategories}" varStatus="subCounter">
						<c:choose>
							<c:when test="${!empty WCParam.categoryId && WCParam.categoryId==subCategory.categoryId}">
								<option selected value="<c:out value="${subCategory.categoryId}"/>"><c:out value="${topCategory.description.name}:${subCategory.description.name}"/></option>
							</c:when>
							<c:otherwise>
								<option value="<c:out value="${subCategory.categoryId}"/>"><c:out value="${topCategory.description.name}:${subCategory.description.name}"/></option>
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</c:forEach>  
                	</select>
                	<input type="hidden" name="categoryType" value="ANY" id="WC_AdvancedCatalogSearchForm_FormInput_categoryType_In_AdvancedSearchForm_1"/>
		</td>
	</tr>
	<tr>
		<td class="t_td2" id="WC_AdvancedCatalogSearchForm_TableCell_9">
			<label >
			<fmt:message key="SEARCH_FOR_PRICE_RANGE" bundle="${storeText}"/></label>
		</td>
	</tr>
	<tr>
		<td id="WC_AdvancedCatalogSearchForm_TableCell_10">
			<input type="hidden" name="currency" value="<c:out value="${CommandContext.currency}" escapeXml="false"/>" id="WC_AdvancedCatalogSearchForm_FormInput_currency_In_AdvancedSearchForm_1"/>
			<table cellpadding="0" cellspacing="0" border="0">
				<tr>
					<td class="t_rght_space">
						<label for="WC_AdvancedCatalogSearchForm_FormInput_minPrice_In_AdvancedSearchForm_1">
						<fmt:message key="FROM" bundle="${storeText}"/></label>
					</td>
					<td>
						&nbsp;<input size="8" type="text" maxlength="20" name="minPrice" id="WC_AdvancedCatalogSearchForm_FormInput_minPrice_In_AdvancedSearchForm_1"/>&nbsp;
					</td>
					<td class="t_rght_space">
						<label for="WC_AdvancedCatalogSearchForm_FormInput_maxPrice_In_AdvancedSearchForm_1">
						<fmt:message key="TO" bundle="${storeText}"/></label>
					</td>
					<td>
						<input size="8" type="text" maxlength="20" name="maxPrice" id="WC_AdvancedCatalogSearchForm_FormInput_maxPrice_In_AdvancedSearchForm_1"/>
					</td>
					<td>
						<%-- Get the currency description for the selected currency --%>
						<c:forEach var="dbCurrency" items="${sdb.storeCurrencies}">
							<c:if test="${dbCurrency.currencyCode == CommandContext.currency}">
								<c:set var="currDesc" value="${dbCurrency.currencyDescription}" />
							</c:if>
						</c:forEach>
						&nbsp;<c:out value="${currDesc}" escapeXml="false"/>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td class="t_td2" id="WC_AdvancedCatalogSearchForm_TableCell_11">
			<label for="WC_AdvancedCatalogSearchForm_pageSize_In_AdvancedSearchForm_1">
			<fmt:message key="RESULTS_PER_PAGE" bundle="${storeText}"/></label>
		</td>
	</tr>
	<tr>
		<td id="WC_AdvancedCatalogSearchForm_TableCell_12">
			<select id="WC_AdvancedCatalogSearchForm_pageSize_In_AdvancedSearchForm_1" class="select" name="pageSize">
				<c:choose>
					<c:when test="${!empty WCParam.pageSize && WCParam.pageSize=='5'}">
						<option value="5" selected>
					</c:when>
					<c:otherwise>
						<option value="5">
					</c:otherwise>
				</c:choose>
				5</option>
				<option selected="selected" value="10">10</option>
				<c:choose>
					<c:when test="${!empty WCParam.pageSize && WCParam.pageSize=='25'}">
						<option value="25" selected>
					</c:when>
					<c:otherwise>
						<option value="25">
					</c:otherwise>
				</c:choose>
				25</option>
				<c:choose>
					<c:when test="${!empty WCParam.pageSize && WCParam.pageSize=='50'}">
						<option value="50" selected>
					</c:when>
					<c:otherwise>
						<option value="50">
					</c:otherwise>
				</c:choose>
				50</option>
				<c:choose>
					<c:when test="${!empty WCParam.pageSize && WCParam.pageSize=='75'}">
						<option value="75" selected>
					</c:when>
					<c:otherwise>
						<option value="75">
					</c:otherwise>
				</c:choose>
				75</option>
				<c:choose>
					<c:when test="${!empty WCParam.pageSize && WCParam.pageSize=='100'}">
						<option value="100" selected>
					</c:when>
					<c:otherwise>
						<option value="100">
					</c:otherwise>
				</c:choose>
				100</option>
			</select>
			<input type="hidden" name="beginIndex" value="0" id="WC_AdvancedCatalogSearchForm_FormInput_beginIndex_In_AdvancedSearchForm_1"/>
                        <input type="hidden" name="sType" value="AdvancedSearch" id="WC_AdvancedCatalogSearchForm_FormInput_sType_In_AdvancedSearchForm_1"/>
		</td>
	</tr>
</table>
</form>

<br/>
<a href="javascript:submitSearch(document.AdvancedSearchForm)" class="button" id="WC_AdvancedCatalogSearchForm_Link_1">
	<fmt:message key="SEARCH" bundle="${storeText}"/>
</a>
	                
        <!-- End Main JSP Content -->
        
<%@ include file="../../../include/LayoutContainerBottom.jspf"%>
</body>
<!-- END AdvancedCatalogSearchForm.jsp -->
</html>
