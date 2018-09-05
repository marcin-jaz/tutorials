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
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf"%>


<c:set var="pageSize" value="${param.pageSize}"/>
<c:if test="${empty pageSize}">
	<c:set var="pageSize" value="20"/>
</c:if>



<%-- Counts the page number we are drawing in.  --%>
<c:set var="currentPage" value="${WCParam.currentPage}" />
<c:if test="${empty currentPage}">
	<c:set var="currentPage" value="0" />
</c:if>

<c:set var="beginIndex" value="${WCParam.beginIndex}" />
<c:if test="${empty beginIndex}">
	<c:set var="beginIndex" value="0" />
</c:if>

<c:set var="numberSubCatPerRow">
	<c:out value="4" />
</c:set>

<wcbase:useBean id="category" classname="com.ibm.commerce.catalog.beans.CategoryDataBean" scope="page" />

<c:set var="categoryId" value="${WCParam.categoryId}"/>
<c:if test="${empty categoryId}">
       <c:set var="categoryId" value="${param.categoryId}"/>
</c:if>

<c:choose>
<c:when test="${!empty categoryId}">
	<c:set var="categoryId" value="${WCParam.categoryId}"/>
</c:when>
<c:otherwise>
	<c:set var="categoryId" value="${category.categoryId}"/>
</c:otherwise>
</c:choose>
						
<c:forEach var="count" items="${category.subCategories}" varStatus="status">
	<c:set var="numEntries" value="${numEntries+1}"/>
</c:forEach>


<fmt:formatNumber var="totalPages" value="${(numEntries/pageSize)+1}"/>
<c:if test="${numEntries%pageSize == 0}">
	<fmt:parseNumber var="totalPages" value="${numEntries/pageSize}"/>
</c:if>
<fmt:parseNumber var="totalPages" value="${totalPages}" integerOnly="true"/>


<c:choose>
	<c:when test="${beginIndex + pageSize >= numEntries}">
		<c:set var="endIndex" value="${numEntries}" />
	</c:when>
	<c:otherwise>
		<c:set var="endIndex" value="${beginIndex + pageSize}" />
	</c:otherwise>
</c:choose>

<c:choose>
	<c:when test="${beginIndex == 0}">
		<c:set var="currentPage" value="1" />
	</c:when>
	<c:otherwise>
		<fmt:formatNumber var="currentPage" value="${(beginIndex/pageSize)+1}"/>
		<fmt:parseNumber var="currentPage" value="${currentPage}" integerOnly="true"/>
	</c:otherwise>
</c:choose>
<%-- End:  Calculate amount of entries to be shown --%>

<c:choose>
	<c:when test="${beginIndex == 0}">
		<c:set var="prevIndex" value="0" />
	</c:when>
	<c:otherwise>
		<c:set var="prevIndex" value="${beginIndex - pageSize}" />
	</c:otherwise>
</c:choose>
<c:set var="nextIndex" value="${endIndex}" />

<%-- total number of search result. This number will be used to decide the image size and
	 the total number of results that should be displayed
--%>
<c:set var="totalCount" value="${numEntries}"/>


<c:if test="${numEntries > 0}">

<c:if test="${beginIndex != 0}">
	<wcf:url var="SubCategoriesListDisplayViewPrevURL" value="SubCatListDisplayView" type="Ajax">
	  <wcf:param name="langId" value="${langId}" />						
	  <wcf:param name="storeId" value="${WCParam.storeId}" />
	  <wcf:param name="catalogId" value="${WCParam.catalogId}" />
	  <wcf:param name="categoryId" value="${param.categoryId}" />
	  <wcf:param name="beginIndex" value="${beginIndex - pageSize}" />
	  <wcf:param name="pageView" value="${param.pageView}" />
	</wcf:url>
</c:if>
<c:if test="${totalCount > endIndex}">
	<wcf:url var="SubCategoriesListDisplayViewNextURL" value="SubCatListDisplayView" type="Ajax">
	  <wcf:param name="langId" value="${langId}" />						
	  <wcf:param name="storeId" value="${WCParam.storeId}" />
	  <wcf:param name="catalogId" value="${WCParam.catalogId}" />
	  <wcf:param name="categoryId" value="${param.categoryId}" />
	  <wcf:param name="beginIndex" value="${beginIndex + pageSize}" />
	  <wcf:param name="pageView" value="${param.pageView}" />
	</wcf:url>
</c:if>

<form name="subCategoryPaginationForm" action="">
	<div class="contentgrad_header">
		<div class="left_corner"></div>
		<div id="top_pagination" class="left">
			<span class="text">
				<fmt:message key="SUB_CATEGORY_DISPLAYING" bundle="${storeText}"> 
					<fmt:param><fmt:formatNumber value="${beginIndex + 1}"/></fmt:param>
					<fmt:param><fmt:formatNumber value="${endIndex}"/></fmt:param>
					<fmt:param><fmt:formatNumber value="${totalCount}"/></fmt:param>
				</fmt:message> 
				
				<c:if test="${totalPages > 1}">
					<span class="pagination_controls"> 
						<c:if test="${beginIndex != 0}">
							<a id="WC_SubCategoriesListResultsDisplay_links_2" href="javaScript:setCurrentId('WC_SubCategoriesListResultsDisplay_links_2'); categoryDisplayJS.loadSubCategoryContentURL('<c:out value='${SubCategoriesListDisplayViewPrevURL}'/>');">
						</c:if>
						<img src="<c:out value="${jspStoreImgDir}${vfileColorBIDI}" />paging_back.png" alt="<fmt:message key="CATEGORY_PAGING_LEFT_IMAGE" bundle="${storeText}"/>" />
						<c:if test="${beginIndex != 0}">
							</a>
						</c:if>
	
						<fmt:message key="CATEGORY_RESULTS_PAGES_DISPLAYING" bundle="${storeText}"> 
							<fmt:param><fmt:formatNumber value="${currentPage}"/></fmt:param>
							<fmt:param><fmt:formatNumber value="${totalPages}"/></fmt:param>
						</fmt:message> 
	
						<c:if test="${totalCount > endIndex}">
							<a id="WC_SubCategoriesListResultsDisplay_links_3" href="javaScript:setCurrentId('WC_SubCategoriesListResultsDisplay_links_3'); categoryDisplayJS.loadSubCategoryContentURL('<c:out value='${SubCategoriesListDisplayViewNextURL}'/>');">
						</c:if>
						<img src="<c:out value="${jspStoreImgDir}${vfileColorBIDI}" />paging_next.png" alt="<fmt:message key="CATEGORY_PAGING_RIGHT_IMAGE" bundle="${storeText}"/>" />
						<c:if test="${totalCount > endIndex}">
							</a>
						</c:if>
						
					</span>
				</c:if>
			</span>		
		</div>
		<div class="right_corner" id="WC_SubCategoriesListResultsDisplay_div_4_9"></div>
	</div>
</form>
<div class="body588" id="WC_SubCategoriesListResultsDisplay_div_5">
	<br clear="all" />
	<table id="four-grid" cellpadding="0" cellspacing="0" border="0">
	
			<tr>
				<td class="divider_line" colspan="4" id="WC_CategoryOnlyResultsDisplay_td_1_<c:out value='${status.count}'/>"><br/></td>
			</tr>	
				<c:set var="currentItemCount" value="0" />
				<c:set var="rowItemCount" value="0"/>
				<c:set var="rowBeginIndex" value="0"/>

				<c:forEach var="subCategory" items="${category.subCategories}" varStatus="status">

					<c:set var="currentItemCount" value="${currentItemCount + 1}" />
					<c:if test="${(beginIndex+1 <= currentItemCount) && (endIndex >= currentItemCount)}">
							<c:if test="${rowItemCount == 0}">
								<tr>
								<c:set var="subCatTdClass" value="container_links_first" />	
							</c:if>
							<c:if test="${rowItemCount != 0}">
								<c:set var="subCatTdClass" value="container_links" />	
							</c:if>							
						<td id="WC_SubCategoriesListResultsDisplay_td_2_<c:out value='${status.count}'/>" class="<c:out value='${subCatTdClass}'/>">
							<div id="WC_SubCategoriesListResultsDisplay_div_6_<c:out value='${status.count}'/>">
								<c:set var="rowItemCount" value="${rowItemCount+1}"/>
								<c:set var="prefix" value="category"/>
								
								
								<wcf:url var="categoryDisplayUrl" value="Category4" type="Ajax">	  		
	  								<wcf:param name="catalogId" value="${WCParam.catalogId}" />
									<wcf:param name="storeId" value="${WCParam.storeId}" />
									<wcf:param name="categoryId" value="${subCategory.categoryId}" />
									<wcf:param name="langId" value="${langId}" />
									<wcf:param name="parent_category_rn" value="${categoryId}" />
									<wcf:param name="top_category" value="${categoryId}" />
									<wcf:param name="pageView" value="${WCParam.pageView}" />
									<wcf:param name="beginIndex" value="0" />
								</wcf:url>
		
								<a href="<c:out value="${categoryDisplayUrl}" />" id="WC_CachedCategoriesDisplay_Link_ForSubCatImg_<c:out value="${idCounter.count}"/>">
								<c:out value="${subCategory.description.name}" /></a>
							</div>
						</td>
						<c:if test="${rowItemCount%numberSubCatPerRow==0}">
							</tr>
							<c:set var="rowItemCount" value="0"/>
							<c:set var="rowBeginIndex" value="${status.index+1}"/>
						</c:if> 
					</c:if>
				</c:forEach>
				<c:if test="${rowItemCount != 0}">
					</tr>
				</c:if>
				
				<tr><td><br/></td></tr>
				<tr>
				<td class="divider_line" colspan="4" id="WC_CategoryOnlyResultsDisplay_td_2_<c:out value='${status.count}'/>"></td>
				</tr>
			
	</table>
	<br/>
	<br/>
<div id="bottom_pagination">
			
				<span class="display_text">

				<fmt:message key="SUB_CATEGORY_DISPLAYING" bundle="${storeText}"> 
					<fmt:param><fmt:formatNumber value="${beginIndex + 1}"/></fmt:param>
					<fmt:param><fmt:formatNumber value="${endIndex}"/></fmt:param>
					<fmt:param><fmt:formatNumber value="${totalCount}"/></fmt:param>
				</fmt:message>
				
				<c:if test="${totalPages > 1}">
					<span class="pagination_controls"> 
						<c:if test="${beginIndex != 0}">
							<a id="WC_SubCategoriesListResultsDisplay_links_2a" href="javaScript:setCurrentId('WC_SubCategoriesListResultsDisplay_links_2a'); categoryDisplayJS.loadSubCategoryContentURL('<c:out value='${SubCategoriesListDisplayViewPrevURL}'/>');">
						</c:if>
						<img src="<c:out value="${jspStoreImgDir}${vfileColorBIDI}" />paging_back.png" alt="<fmt:message key="CATEGORY_PAGING_LEFT_IMAGE" bundle="${storeText}"/>" />
						<c:if test="${beginIndex != 0}">
							</a>
						</c:if>
	
						<fmt:message key="CATEGORY_RESULTS_PAGES_DISPLAYING" bundle="${storeText}"> 
							<fmt:param><fmt:formatNumber value="${currentPage}"/></fmt:param>
							<fmt:param><fmt:formatNumber value="${totalPages}"/></fmt:param>
						</fmt:message> 
	
						<c:if test="${totalCount > endIndex}">
							<a id="WC_SubCategoriesListResultsDisplay_links_3a" href="javaScript:setCurrentId('WC_SubCategoriesListResultsDisplay_links_3a'); categoryDisplayJS.loadSubCategoryContentURL('<c:out value='${SubCategoriesListDisplayViewNextURL}'/>');">
						</c:if>
						<img src="<c:out value="${jspStoreImgDir}${vfileColorBIDI}" />paging_next.png" alt="<fmt:message key="CATEGORY_PAGING_RIGHT_IMAGE" bundle="${storeText}"/>" />
						<c:if test="${totalCount > endIndex}">
							</a>
						</c:if>
					</span>
				</c:if>
					
				</span>
</div>
	 
</div>
<div class="footer" id="WC_SubCategoriesListResultsDisplay_div_7">
	 <div class="left_corner" id="WC_SubCategoriesListResultsDisplay_div_8"></div>
	 <div class="right" id="WC_SubCategoriesListResultsDisplay_div_9"></div>
	 <div class="right_corner" id="WC_SubCategoriesListResultsDisplay_div_10"></div>
</div>
</c:if>
