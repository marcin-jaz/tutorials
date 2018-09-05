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
<title><fmt:message key="AdvSer_Title" bundle="${storeText}"/></title>
<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}" /><c:out value="${vfileStylesheet}" />" type="text/css"/>
<script language="javascript">
              function submitSearch(form)
              {
                     form.submit()
              }
       
</script>
</head>
<body class="noMargin">
<flow:ifEnabled feature="customerCare"> 
<%
// Set header type needed for this JSP for LiveHelp.  This must
// be set before HeaderDisplay.jsp
//request.setAttribute("liveHelpPageType", "personal");
%>
<c:set var="requestScope.liveHelpPageType" value="personal" scope="request" />
</flow:ifEnabled> 
<%@ include file="../../../include/LayoutContainerTop.jspf"%>
<!-- Start Main JSP Content -->

<h1><fmt:message key="AdvSer_Title" bundle="${storeText}"/></h1>
<table cellpadding="0" cellspacing="0" border="0" class="t_table" id="WC_AdvancedCatalogSearchForm_Table_1">
	<form method="post" action="CatalogSearchResultView" name="AdvancedSearchForm" id="AdvancedSearchForm">
	<input type="hidden" name="storeId" value="<c:out value="${WCParam.storeId}" />" id="WC_AdvancedCatalogSearchForm_FormInput_storeId_In_AdvancedSearchForm_1"/>
	<input type="hidden" name="langId" value="<c:out value="${WCParam.langId}" />" id="WC_AdvancedCatalogSearchForm_FormInput_langId_In_AdvancedSearchForm_1"/>
	<input type="hidden" name="catalogId" value="<c:out value="${WCParam.catalogId}" />" id="WC_AdvancedCatalogSearchForm_FormInput_catalogId_In_AdvancedSearchForm_1"/>

        <input type="hidden" name="qtyAvailable" value="" id="WC_AdvancedCatalogSearchForm_FormInput_qtyAvailable_In_AdvancedSearchForm_1"/>
        <input type="hidden" name="qtyAvailableOperator" value="EQUAL" id="WC_AdvancedCatalogSearchForm_FormInput_qtyAvailableOperator_In_AdvancedSearchForm_1"/>
        <input type="hidden" name="qtyMeasure" value="" id="WC_AdvancedCatalogSearchForm_FormInput_qtyMeasure_In_AdvancedSearchForm_1"/>
        <input type="hidden" name="qtyMeasureCaseSensitive" value="" id="WC_AdvancedCatalogSearchForm_FormInput_qtyMeasureCaseSensitive_In_AdvancedSearchForm_1"/>
        <input type="hidden" name="qtyMeasureOperator" value="EQUAL" id="WC_AdvancedCatalogSearchForm_FormInput_qtyMeasureOperator_In_AdvancedSearchForm_1"/>	
	<tr>
		<td class="t_td2" id="WC_AdvancedCatalogSearchForm_TableCell_1"><label for="WC_AdvancedCatalogSearchForm_FormInput_searchTerm_In_AdvancedSearchForm_1"><fmt:message key="AdvSer_Text1" bundle="${storeText}"/></label></td>
	</tr>
	<tr>
		<td id="WC_AdvancedCatalogSearchForm_TableCell_2">
			<input id="WC_AdvancedCatalogSearchForm_FormInput_searchTerm_In_AdvancedSearchForm_1" size="30" maxlength="254" type="text" class="input" name="searchTerm" 
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
                            <fmt:message key="AdvSer_Drop1" bundle="${storeText}"/></option>
                            <c:choose>
                                   <c:when test="${!empty WCParam.searchType && WCParam.searchType=='ANY'}">
                                          <option value="ANY" selected>
                                   </c:when>
                                   <c:otherwise>
                                          <option value="ANY">
                                   </c:otherwise>
                            </c:choose>
                            <fmt:message key="AdvSer_Drop2" bundle="${storeText}"/></option>
                            <c:choose>
                                   <c:when test="${!empty WCParam.searchType && WCParam.searchType=='EXACT'}">
                                          <option value="EXACT" selected>
                                   </c:when>
                                   <c:otherwise>
                                          <option value="EXACT">
                                   </c:otherwise>
                            </c:choose>
                            <fmt:message key="AdvSer_Drop3" bundle="${storeText}"/></option>
                          </select>
                          <input type="hidden" name="searchTermCaseSensitive" value="no" id="WC_AdvancedCatalogSearchForm_FormInput_searchTermCaseSensitive_In_AdvancedSearchForm_1"/>
                          <input type="hidden" name="searchTermOperator" value="LIKE" id="WC_AdvancedCatalogSearchForm_FormInput_searchTermOperator_In_AdvancedSearchForm_1"/>
		</td>
	</tr>
	<tr>
		<td class="t_td2" id="WC_AdvancedCatalogSearchForm_TableCell_3"><label for="WC_AdvancedCatalogSearchForm_FormInput_filterTerm_In_AdvancedSearchForm_1"><fmt:message key="AdvSer_Text2" bundle="${storeText}"/></label></td>
	</tr>
	<tr>
		<td id="WC_AdvancedCatalogSearchForm_TableCell_4">
			<input id="WC_AdvancedCatalogSearchForm_FormInput_filterTerm_In_AdvancedSearchForm_1" size="30" maxlength="254" type="text" class="input" name="filterTerm" value="<c:choose><c:when test="${!empty WCParam.filterTerm}"><c:out value="${WCParam.filterTerm}"/></c:when><c:otherwise></c:otherwise></c:choose>" />
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
                            <fmt:message key="AdvSer_Drop1" bundle="${storeText}"/></option>
                            <c:choose>
                                   <c:when test="${!empty WCParam.filterType && WCParam.filterType=='ANY'}">
                                          <option value="ANY" selected>
                                   </c:when>
                                   <c:otherwise>
                                          <option value="ANY">
                                   </c:otherwise>
                            </c:choose>
                            <fmt:message key="AdvSer_Drop2" bundle="${storeText}"/></option>
                            <c:choose>
                                   <c:when test="${!empty WCParam.filterType && WCParam.filterType=='EXACT'}">
                                          <option value="EXACT" selected>
                                   </c:when>
                                   <c:otherwise>
                                          <option value="EXACT">
                                   </c:otherwise>
                            </c:choose>
                            <fmt:message key="AdvSer_Drop3" bundle="${storeText}"/></option>
                          </select>
                          <input type="hidden" name="filterTermCaseSensitive" value="no" id="WC_AdvancedCatalogSearchForm_FormInput_filterTermCaseSensitive_In_AdvancedSearchForm_1"/>
                          <input type="hidden" name="filterTermOperator" value="LIKE" id="WC_AdvancedCatalogSearchForm_FormInput_filterTermOperator_In_AdvancedSearchForm_1"/>
		</td>
	</tr>
	<tr>
		<td class="t_td2" id="WC_AdvancedCatalogSearchForm_TableCell_5"><label for="WC_AdvancedCatalogSearchForm_FormInput_searchTermScope_In_AdvancedSearchForm_1"><fmt:message key="AdvSer_Text3" bundle="${storeText}"/></label></td>
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
                            <fmt:message key="AdvSer_Drop4" bundle="${storeText}"/> </option>
                            <c:choose>
                                   <c:when test="${!empty WCParam.searchTermScope && WCParam.searchTermScope=='2'}">
                                          <option value="2" selected>
                                   </c:when>
                                   <c:otherwise>
                                          <option value="2">
                                   </c:otherwise>
                            </c:choose>
                            <fmt:message key="AdvSer_Drop5" bundle="${storeText}"/> </option>
                          </select>
		</td>
	</tr>
	<tr>
		<td class="t_td2" id="WC_AdvancedCatalogSearchForm_TableCell_7"><label for="WC_AdvancedCatalogSearchForm_FormInput_catGroupId_In_AdvancedSearchForm_1"><fmt:message key="AdvSer_Text4" bundle="${storeText}"/></label></td>
	</tr>
	</tr>
		<td id="WC_AdvancedCatalogSearchForm_TableCell_8">
			<select id="WC_AdvancedCatalogSearchForm_FormInput_catGroupId_In_AdvancedSearchForm_1" class="select" name="catGroupId">
				<option value=""><fmt:message key="AdvSer_Drop6" bundle="${storeText}"/></option>
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
		<td class="t_td2" id="WC_AdvancedCatalogSearchForm_TableCell_9"><label for="WC_AdvancedCatalogSearchForm_FormInput_manufacturer_In_AdvancedSearchForm_1"><fmt:message key="AdvSer_Text5" bundle="${storeText}"/></label></td>
	</tr>
	<tr>
		<td id="WC_AdvancedCatalogSearchForm_TableCell_10">
			<input id="WC_AdvancedCatalogSearchForm_FormInput_manufacturer_In_AdvancedSearchForm_1" size="30" maxlength="254" type="text" class="input" name="manufacturer" value="<c:choose><c:when test="${!empty WCParam.manufacturer}"><c:out value="${WCParam.manufacturer}"/></c:when><c:otherwise></c:otherwise></c:choose>" />
			<input type="hidden" name="manufacturerCaseSensitive" value="no" id="WC_AdvancedCatalogSearchForm_FormInput_manufacturerCaseSensitive_In_AdvancedSearchForm_1"/>
                        <input type="hidden" name="manufacturerOperator" value="LIKE" id="WC_AdvancedCatalogSearchForm_FormInput_manufacturerOperator_In_AdvancedSearchForm_1"/>
		</td>
	</tr>
	<tr>
		<td class="t_td2" id="WC_AdvancedCatalogSearchForm_TableCell_11"><label for="WC_AdvancedCatalogSearchForm_FormInput_manufacturerPartNum_In_AdvancedSearchForm_1"><fmt:message key="AdvSer_Text6" bundle="${storeText}"/></label></td>
	</tr>
	<tr>
		<td id="WC_AdvancedCatalogSearchForm_TableCell_12">
			<input id="WC_AdvancedCatalogSearchForm_FormInput_manufacturerPartNum_In_AdvancedSearchForm_1" size="30" maxlength="254" type="text" class="input" name="manufacturerPartNum" value="<c:choose><c:when test="${!empty WCParam.manufacturerPartNum}"><c:out value="${WCParam.manufacturerPartNum}"/></c:when><c:otherwise></c:otherwise></c:choose>" />
			<input type="hidden" name="manufacturerPartNumCaseSensitive" value="no" id="WC_AdvancedCatalogSearchForm_FormInput_manufacturerPartNumCaseSensitive_In_AdvancedSearchForm_1"/>
                        <input type="hidden" name="manufacturerPartNumOperator" value="LIKE" id="WC_AdvancedCatalogSearchForm_FormInput_manufacturerPartNumOperator_In_AdvancedSearchForm_1"/>
		</td>
	</tr>
	<tr>
		<td class="t_td2" id="WC_AdvancedCatalogSearchForm_TableCell_13"><label for="WC_AdvancedCatalogSearchForm_sku_In_AdvancedSearchForm_1_2"><fmt:message key="AdvSer_Text7" bundle="${storeText}"/></label></td>
	</tr>
	<tr>
		<td id="WC_AdvancedCatalogSearchForm_TableCell_14">
			<input id="WC_AdvancedCatalogSearchForm_sku_In_AdvancedSearchForm_1_2" size="30" maxlength="254" type="text" class="input" name="sku" value="<c:choose><c:when test="${!empty WCParam.sku}"><c:out value="${WCParam.sku}"/></c:when><c:otherwise></c:otherwise></c:choose>" />
                        <input type="hidden" name="skuCaseSensitive" value="no" id="WC_AdvancedCatalogSearchForm_FormInput_skuCaseSensitive_In_AdvancedSearchForm_1"/>
                        <input type="hidden" name="skuOperator" value="LIKE" id="WC_AdvancedCatalogSearchForm_FormInput_skuOperator_In_AdvancedSearchForm_1"/>
		</td>
	</tr>


	<tr>
		<td class="t_td2" id="WC_AdvancedCatalogSearchForm_TableCell_15"><label for="WC_AdvancedCatalogSearchForm_pageSize_In_AdvancedSearchForm_1"><fmt:message key="AdvSer_Text8" bundle="${storeText}"/></label></td>
	</tr>
	</tr>
		<td id="WC_AdvancedCatalogSearchForm_TableCell_15">
			<select id="WC_AdvancedCatalogSearchForm_pageSize_In_AdvancedSearchForm_1" class="select" name="pageSize">
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

</br>
<a href="javascript:submitSearch(document.AdvancedSearchForm)" class="button" id="WC_AdvancedCatalogSearchForm_Link_1">
	<fmt:message key="AdvSer_Button" bundle="${storeText}"/>
</a>
	                
        <!-- End Main JSP Content -->
<%@ include file="../../../include/LayoutContainerBottom.jspf"%>
</body>
<!-- END AdvancedCatalogSearchForm.jsp -->
</html>
