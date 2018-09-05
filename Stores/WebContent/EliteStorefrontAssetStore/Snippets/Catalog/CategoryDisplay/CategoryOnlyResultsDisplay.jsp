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

<c:set var="categoryId" value="${WCParam.categoryId}"/>
<c:if test="${empty categoryId}">
	<c:set var="categoryId" value="${param.categoryId}"/>
</c:if>

<c:set var="pageSize" value="${param.pageSize}"/>
<c:if test="${empty pageSize}">
	<c:set var="pageSize" value="12"/>
</c:if>

<c:set var="pageView" value="${param.pageView}"/>
<c:if test="${empty pageView}">
	<c:set var="pageView" value="${defaultPageView}"/>
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

<c:set var="numberProductsPerRow">
	<c:out value="${WCParam.numberProductsPerRow}" default="4" />
</c:set>

<wcbase:useBean id="category" classname="com.ibm.commerce.catalog.beans.CategoryDataBean" scope="page" />

<%-- Start:  Calculate amount of entries to be shown --%>
<c:set var="numEntries" value="0"/>
<c:forEach var="count" items="${category.catalogEntryDataBeans}" varStatus="status">
	<c:set var="skuWithNoParent" value="false" />
	<c:if test="${count.item}">
		<c:if test="${count.itemDataBean.parentProductId eq count.itemDataBean.itemID}">
			<c:set var="skuWithNoParent" value="true" />
		</c:if>
	</c:if>
												
	<c:if test="${skuWithNoParent || (!count.item && !count.dynamicKit)}">
		<c:set var="numEntries" value="${numEntries+1}"/>
	</c:if>
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
	<wcf:url var="CategoryDisplayViewPrevURL" value="CategoryOnlyResultsDisplayView" type="Ajax">
	  <wcf:param name="langId" value="${langId}" />						
	  <wcf:param name="storeId" value="${WCParam.storeId}" />
	  <wcf:param name="catalogId" value="${WCParam.catalogId}" />
	  <wcf:param name="categoryId" value="${param.categoryId}" />
	  <wcf:param name="beginIndex" value="${beginIndex - pageSize}" />
	  <wcf:param name="pageView" value="${param.pageView}" />
	  <wcf:param name="categoryId" value="${WCParam.categoryId}" />
		<c:choose>
			<%-- Use the context parameters if they are available; usually in a subcategory --%>			
			<c:when test="${!empty WCParam.parent_category_rn && !empty WCParam.top_category}">
				<wcf:param name="parent_category_rn" value="${WCParam.parent_category_rn}" />
				<wcf:param name="top_category" value="${WCParam.top_category}" />
			</c:when>
			<%-- In a top category; use top category parameters --%>
			<c:when test="${WCParam.top == 'Y'}">
				<wcf:param name="parent_category_rn" value="${WCParam.categoryId}" />
				<wcf:param name="top_category" value="${WCParam.categoryId}" />
			</c:when>
			<%-- Store front main page; usually eSpots, parents unknown --%>
			<c:otherwise>
				<wcf:param name="parent_category_rn" value="" />
				<wcf:param name="top_category" value="" />
			</c:otherwise>
		</c:choose>
	</wcf:url>
</c:if>
<c:if test="${totalCount > endIndex + 1}">
	<wcf:url var="CategoryDisplayViewNextURL" value="CategoryOnlyResultsDisplayView" type="Ajax">
	  <wcf:param name="langId" value="${langId}" />						
	  <wcf:param name="storeId" value="${WCParam.storeId}" />
	  <wcf:param name="catalogId" value="${WCParam.catalogId}" />
	  <wcf:param name="categoryId" value="${param.categoryId}" />
	  <wcf:param name="beginIndex" value="${beginIndex + pageSize}" />
	  <wcf:param name="pageView" value="${param.pageView}" />
	  <wcf:param name="categoryId" value="${WCParam.categoryId}" />
		<c:choose>
			<%-- Use the context parameters if they are available; usually in a subcategory --%>			
			<c:when test="${!empty WCParam.parent_category_rn && !empty WCParam.top_category}">
				<wcf:param name="parent_category_rn" value="${WCParam.parent_category_rn}" />
				<wcf:param name="top_category" value="${WCParam.top_category}" />
			</c:when>
			<%-- In a top category; use top category parameters --%>
			<c:when test="${WCParam.top == 'Y'}">
				<wcf:param name="parent_category_rn" value="${WCParam.categoryId}" />
				<wcf:param name="top_category" value="${WCParam.categoryId}" />
			</c:when>
			<%-- Store front main page; usually eSpots, parents unknown --%>
			<c:otherwise>
				<wcf:param name="parent_category_rn" value="" />
				<wcf:param name="top_category" value="" />
			</c:otherwise>
		</c:choose>
	</wcf:url>
</c:if>

<wcf:url var="CategoryDisplayViewFullURL" value="CategoryOnlyResultsDisplayView" type="Ajax">
  <wcf:param name="langId" value="${langId}" />						
  <wcf:param name="storeId" value="${WCParam.storeId}" />
  <wcf:param name="catalogId" value="${WCParam.catalogId}" />
  <wcf:param name="categoryId" value="${param.categoryId}" />
  <wcf:param name="beginIndex" value="${beginIndex}" />
  <wcf:param name="pageView" value="detailed" />
  <wcf:param name="categoryId" value="${WCParam.categoryId}" />
		<c:choose>
			<%-- Use the context parameters if they are available; usually in a subcategory --%>			
			<c:when test="${!empty WCParam.parent_category_rn && !empty WCParam.top_category}">
				<wcf:param name="parent_category_rn" value="${WCParam.parent_category_rn}" />
				<wcf:param name="top_category" value="${WCParam.top_category}" />
			</c:when>
			<%-- In a top category; use top category parameters --%>
			<c:when test="${WCParam.top == 'Y'}">
				<wcf:param name="parent_category_rn" value="${WCParam.categoryId}" />
				<wcf:param name="top_category" value="${WCParam.categoryId}" />
			</c:when>
			<%-- Store front main page; usually eSpots, parents unknown --%>
			<c:otherwise>
				<wcf:param name="parent_category_rn" value="" />
				<wcf:param name="top_category" value="" />
			</c:otherwise>
		</c:choose>
</wcf:url>

<wcf:url var="CategoryDisplayViewURL" value="CategoryOnlyResultsDisplayView" type="Ajax">
  <wcf:param name="langId" value="${langId}" />						
  <wcf:param name="storeId" value="${WCParam.storeId}" />
  <wcf:param name="catalogId" value="${WCParam.catalogId}" />
  <wcf:param name="categoryId" value="${param.categoryId}" />
  <wcf:param name="beginIndex" value="${beginIndex}" />
  <wcf:param name="pageView" value="image" />
  <wcf:param name="categoryId" value="${WCParam.categoryId}" />
		<c:choose>
			<%-- Use the context parameters if they are available; usually in a subcategory --%>			
			<c:when test="${!empty WCParam.parent_category_rn && !empty WCParam.top_category}">
				<wcf:param name="parent_category_rn" value="${WCParam.parent_category_rn}" />
				<wcf:param name="top_category" value="${WCParam.top_category}" />
			</c:when>
			<%-- In a top category; use top category parameters --%>
			<c:when test="${WCParam.top == 'Y'}">
				<wcf:param name="parent_category_rn" value="${WCParam.categoryId}" />
				<wcf:param name="top_category" value="${WCParam.categoryId}" />
			</c:when>
			<%-- Store front main page; usually eSpots, parents unknown --%>
			<c:otherwise>
				<wcf:param name="parent_category_rn" value="" />
				<wcf:param name="top_category" value="" />
			</c:otherwise>
		</c:choose>
</wcf:url>

<div class="contentgrad_header" id="WC_CategoryOnlyResultsDisplay_div_1">
	 <div class="left_corner" id="WC_CategoryOnlyResultsDisplay_div_2"></div>
	 <div class="left" id="WC_CategoryOnlyResultsDisplay_div_3">
	 <span class="text">
		<fmt:message key="CATEGORY_RESULTS_DISPLAYING" bundle="${storeText}"> 
			<fmt:param><fmt:formatNumber value="${beginIndex + 1}"/></fmt:param>
			<fmt:param><fmt:formatNumber value="${endIndex}"/></fmt:param>
			<fmt:param><fmt:formatNumber value="${totalCount}"/></fmt:param>
		</fmt:message>
		 <c:if test="${totalPages > 1}">
			 <span class="paging">
				<c:if test="${beginIndex != 0}">
					<a id="WC_CategoryOnlyResultsDisplay_links_1" href="javaScript:setCurrentId('WC_CategoryOnlyResultsDisplay_links_1');
					wc.render.getContextById('CategoryDisplay_Context').properties['beginIndex'] = '<c:out value='${beginIndex - pageSize}'/>';
					categoryDisplayJS.loadContentURL('<c:out value='${CategoryDisplayViewPrevURL}'/>');">
				</c:if>
				<img src="<c:out value="${jspStoreImgDir}${vfileColorBIDI}" />paging_back.png" alt="<fmt:message key="CATEGORY_PAGING_LEFT_IMAGE" bundle="${storeText}"/>" />

				<c:if test="${beginIndex != 0}">
					</a>
				</c:if>
			
				<fmt:message key="CATEGORY_RESULTS_PAGES_DISPLAYING" bundle="${storeText}"> 
					<fmt:param><fmt:formatNumber value="${currentPage}"/></fmt:param>
					<fmt:param><fmt:formatNumber value="${totalPages}"/></fmt:param>
				</fmt:message>
			
				<c:if test="${totalCount > endIndex + 1}">
					<a id="WC_CategoryOnlyResultsDisplay_links_2" href="javaScript:setCurrentId('WC_CategoryOnlyResultsDisplay_links_2');
					wc.render.getContextById('CategoryDisplay_Context').properties['beginIndex'] = '<c:out value='${beginIndex + pageSize}'/>';
					categoryDisplayJS.loadContentURL('<c:out value='${CategoryDisplayViewNextURL}'/>');">
				</c:if>
				
				<img src="<c:out value="${jspStoreImgDir}${vfileColorBIDI}" />paging_next.png" alt="<fmt:message key="CATEGORY_PAGING_RIGHT_IMAGE" bundle="${storeText}"/>" />
			
				<c:if test="${totalCount > endIndex + 1}">
					</a>
				</c:if>	
		 	</span>
		 </c:if>
		</span>
	 </div>
	 <div class="right_corner" id="WC_CategoryOnlyResultsDisplay_div_4"> </div>
	 <div class="right" id="WC_CategoryOnlyResultsDisplay_div_4_1"> 
		 <span class="views">
			 <c:if test="${pageView !='image'}">
			 	<c:set var="gridView" value="horizontal_grid"/>
				 <a id="WC_CategoryOnlyResultsDisplay_links_3" href="javaScript:setCurrentId('WC_CategoryOnlyResultsDisplay_links_3'); wc.render.getContextById('CategoryDisplay_Context').properties['pageView'] = 'image';
				 categoryDisplayJS.loadContentURL('<c:out value='${CategoryDisplayViewURL}'/>');">
					<img src="<c:out value="${jspStoreImgDir}${vfileColor}" />grid_normal.png" alt="<fmt:message key="CATEGORY_IMAGE_VIEW" bundle="${storeText}"/>" />
				 </a>
				 <img id="detailedTypeImageSelected" src="<c:out value="${jspStoreImgDir}${vfileColor}list_selected.png"/>" alt="<fmt:message key="FF_VIEWDETAILS" bundle="${storeText}"/>"/>	
			 </c:if>
			 <c:if test="${pageView !='detailed'}">
				 <c:set var="gridView" value="four-grid"/>
				 <img id="imageTypeImageSelected" src="<c:out value="${jspStoreImgDir}${vfileColor}grid_selected.png"/>" alt="<fmt:message key="FF_VIEWICONS" bundle="${storeText}"/>"/>
				 <a id="WC_CategoryOnlyResultsDisplay_links_4" href="javaScript:setCurrentId('WC_CategoryOnlyResultsDisplay_links_4');
				 wc.render.getContextById('CategoryDisplay_Context').properties['pageView'] = 'detailed'; 
				 categoryDisplayJS.loadContentURL('<c:out value='${CategoryDisplayViewFullURL}'/>');">
					<img src="<c:out value="${jspStoreImgDir}${vfileColor}" />list_normal.png" alt="<fmt:message key="CATEGORY_DETAILED_VIEW" bundle="${storeText}"/>" />
				 </a>
			 </c:if>
		 </span>
	 </div>
	  
</div>
<div class="body588" id="WC_CategoryOnlyResultsDisplay_div_5">
	<br clear="all" />
	<table id="<c:out value='${gridView}'/>" cellpadding="0" cellspacing="0" border="0">
				<c:set var="currentItemCount" value="0" />
				<c:set var="rowItemCount" value="0"/>
				<c:set var="rowBeginIndex" value="0"/>
				<c:forEach var="catEntry" items="${category.catalogEntryDataBeans}" varStatus="status">
					
					<c:set var="skuWithNoParent" value="false" />
					<c:if test="${catEntry.item}">
						<c:if test="${catEntry.itemDataBean.parentProductId eq catEntry.itemDataBean.itemID}">
							<c:set var="skuWithNoParent" value="true" />
						</c:if>
					</c:if>
												
					<c:if test="${skuWithNoParent || (!catEntry.item && !catEntry.dynamicKit)}">
						<c:set var="currentItemCount" value="${currentItemCount + 1}" />
						<c:if test="${(beginIndex+1 <= currentItemCount) && (endIndex >= currentItemCount)}">
							<c:if test="${rowItemCount == 0}">
								<tr class="item_container">
									<td class="divider_line" colspan="4" id="WC_CategoryOnlyResultsDisplay_td_1"></td>
								</tr>
								<tr class="item_container">
							</c:if>
							<c:choose>
								<c:when test="${pageView == 'image'}">
							<td class="item" id="WC_CategoryOnlyResultsDisplay_td_2_<c:out value='${status.count}'/>">
										<div id="WC_CategoryOnlyResultsDisplay_div_6_<c:out value='${status.count}'/>" <c:if test="${rowItemCount!=0}"> class="container" </c:if>>
											<c:set var="rowItemCount" value="${rowItemCount+1}"/>
											<c:set var="prefix" value="category"/>
											<c:set var="catEntryIdentifier" value="${catEntry.catalogEntryID}"/>
											<%@ include file="../../ReusableObjects/CatalogEntryDBThumbnailDisplay.jspf" %>
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
									<%@ include file="../../ReusableObjects/CatalogEntryDBThumbnailDisplay.jspf" %>
								</c:otherwise>
							</c:choose>
						</c:if>
					</c:if>
				</c:forEach>
				<c:if test="${rowItemCount != 0}">
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
			<fmt:param><fmt:formatNumber value="${beginIndex + 1}"/></fmt:param>
			<fmt:param><fmt:formatNumber value="${endIndex}"/></fmt:param>
			<fmt:param><fmt:formatNumber value="${totalCount}"/></fmt:param>
		</fmt:message>
		<c:if test="${totalPages > 1}">
			<span class="paging">
				<c:if test="${beginIndex != 0}">
					<a id="WC_CategoryOnlyResultsDisplay_links_5" href="javaScript:setCurrentId('WC_CategoryOnlyResultsDisplay_links_5'); 
					wc.render.getContextById('CategoryDisplay_Context').properties['beginIndex'] = '<c:out value='${beginIndex - pageSize}'/>';
					categoryDisplayJS.loadContentURL('<c:out value='${CategoryDisplayViewPrevURL}'/>');">
				</c:if>
					<img src="<c:out value="${jspStoreImgDir}${vfileColorBIDI}" />paging_back.png" alt="<fmt:message key="CATEGORY_PAGING_LEFT_IMAGE" bundle="${storeText}"/>" />
				<c:if test="${beginIndex != 0}">
					</a>
				</c:if>
				<fmt:message key="CATEGORY_RESULTS_PAGES_DISPLAYING" bundle="${storeText}"> 
					<fmt:param><fmt:formatNumber value="${currentPage}"/></fmt:param>
					<fmt:param><fmt:formatNumber value="${totalPages}"/></fmt:param>
				</fmt:message>
				<c:if test="${totalCount > endIndex + 1}">
					<a id="WC_CategoryOnlyResultsDisplay_links_6" href="javaScript:setCurrentId('WC_CategoryOnlyResultsDisplay_links_6'); 
					wc.render.getContextById('CategoryDisplay_Context').properties['beginIndex'] = '<c:out value='${beginIndex + pageSize}'/>';
					categoryDisplayJS.loadContentURL('<c:out value='${CategoryDisplayViewNextURL}'/>');">
				</c:if>
					<img src="<c:out value="${jspStoreImgDir}${vfileColorBIDI}" />paging_next.png" alt="<fmt:message key="CATEGORY_PAGING_RIGHT_IMAGE" bundle="${storeText}"/>" />
				<c:if test="${totalCount > endIndex + 1}">
					</a>
				</c:if>
			</span>
		</c:if>
	 </span>
</div>
<div class="footer" id="WC_CategoryOnlyResultsDisplay_div_7">
	 <div class="left_corner" id="WC_CategoryOnlyResultsDisplay_div_8"></div>
	 <div class="right" id="WC_CategoryOnlyResultsDisplay_div_9"></div>
	 <div class="right_corner" id="WC_CategoryOnlyResultsDisplay_div_10"></div>
</div>
</c:if>
