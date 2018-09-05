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
  * This JSP snippet will display the catalog entries present in a particular category
  *****
--%>

<!-- BEGIN Categories.jsp -->

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>

<%@ include file="../../../../include/parameters.jspf" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf" %>

<wcbase:useBean id="category" classname="com.ibm.commerce.catalog.beans.CategoryDataBean" scope="page"/>
	
<c:set var="pageSize" value="${param.pageSize}"/>
<c:if test="${empty pageSize}">
<c:set var="pageSize" value="${productsMaxPageSize}" />
</c:if>

<c:set var="topCategoryId" value="${category.categoryId}" />

<%-- Counts the page number we are drawing in.  --%>
<c:set var="currentPage" value="${WCParam.currentPage}" />
<c:if test="${empty currentPage}">
	<c:set var="currentPage" value="1" />
</c:if>

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
<fmt:parseNumber var="totalPages" value="${totalPages}" integerOnly="true" />

<fmt:formatNumber var="beginIndex" value="${(currentPage-1) * pageSize}"/>
<fmt:formatNumber var="endIndex" value="${beginIndex + pageSize}"/>
<c:if test="${endIndex > numEntries}">
	<fmt:parseNumber var="endIndex" value="${numEntries}"/>
</c:if>
<fmt:parseNumber var="beginIndex" value="${beginIndex}" integerOnly="true" />
<fmt:parseNumber var="endIndex" value="${endIndex}" integerOnly="true" />	
<fmt:parseNumber var="numRecordsToShow" value="${endIndex-beginIndex}" integerOnly="true" />
<c:set var="currIndex" value="-1" />
<c:set var="numRecordsShowed" value="0" />
			
<c:if test="${numEntries > 0 }">
	<div id="product_listings" class="content_box">
		<div class="heading_container">
			<h2><c:out value="${category.description.name}" escapeXml="false"/></h2>
			<div class="clear_float"></div>
		</div>		
		<ol start="<c:out value="${beginIndex + 1}"/>">
			<c:forEach var="catEntry" items="${category.catalogEntryDataBeans}" varStatus="idCounter">
				<c:set var="skuWithNoParent" value="false" />
				<c:if test="${catEntry.item}">
					<c:if test="${catEntry.itemDataBean.parentProductId eq catEntry.itemDataBean.itemID}">
						<c:set var="skuWithNoParent" value="true" />
					</c:if>
				</c:if>						
				<c:if test="${skuWithNoParent || (!catEntry.item && !catEntry.dynamicKit)}">
					<c:set var="currIndex" value="${currIndex+1}"/>
					<c:if test="${(currIndex >= beginIndex) && (numRecordsShowed < numRecordsToShow)}">
						<c:set var="numRecordsShowed" value="${numRecordsShowed+1}"/>
						<li>
							<div class="container">
							<c:set var="catEntryIdentifier" value="${catEntry.catalogEntryID}"/>
							<c:choose>
								<c:when test="${catEntry.product}">
									<%-- set the catalogEntry var to the product bean --%>
									<c:set var="catalogEntry" value="${catEntry.productDataBean}"/>
									<c:set var="catalogEntryDB" value="${catEntry.productDataBean}"/>
									<c:set var="type" value="product" />
						
									<wcf:url var="catEntryDisplayUrl" value="mProduct1">
										<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
										<wcf:param name="storeId" value="${WCParam.storeId}"/>
										<wcf:param name="productId" value="${catEntry.catalogEntryID}"/>
										<wcf:param name="langId" value="${langId}"/>
										<wcf:param name="top_category" value="${WCParam.top_category}"/>
										<wcf:param name="parent_category_rn" value="${WCParam.parent_category_rn}"/>
										<wcf:param name="categoryId" value="${WCParam.categoryId}"/>
										<wcf:param name="pgGrp" value="catNav"/>
									</wcf:url>
									<c:if test="${empty catalogEntryDB.entitledItems[0] || catalogEntryDB.buyable eq '0'}" >
										<c:set var="buyable" value="false"/>
									</c:if>
							
									<c:set var="minimumPrice" value="${catalogEntryDB.minimumItemPrice}"/>
									<c:set var="maximumPrice" value="${catalogEntryDB.maximumItemPrice}"/>
									<c:set var="displayPriceRange" value="true"/>
								</c:when>
				          
								<c:when test="${catEntry.item}">
				            		<c:out value="ITEM"></c:out>
									<%-- set the catalogEntry var to the item bean --%>
									<c:set var="catalogEntry" value="${catEntry.itemDataBean}"/>
									<c:set var="catalogEntryDB" value="${catEntry.itemDataBean}"/>	
									<c:set var="type" value="item" />
									<wcf:url var="catEntryDisplayUrl" value="mProduct1">
										<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
										<wcf:param name="storeId" value="${WCParam.storeId}"/>
										<wcf:param name="productId" value="${catEntry.catalogEntryID}"/>
										<wcf:param name="langId" value="${langId}"/>
										<wcf:param name="top_category" value="${WCParam.top_category}"/>
										<wcf:param name="parent_category_rn" value="${WCParam.parent_category_rn}"/>										
										<wcf:param name="categoryId" value="${WCParam.categoryId}"/>
										<wcf:param name="pgGrp" value="catNav"/>										
									</wcf:url>
									<c:set var="dragType" value="item" />
									<c:if test="${catalogEntryDB.buyable eq '0'}" >
										<c:set var="buyable" value="false"/>
									</c:if>
									
									<c:set var="displayPriceRange" value="true"/>
								</c:when>
								<c:when test="${catEntry.package}">
								<%-- set the catalogEntry var to the package bean --%>
									<c:set var="catalogEntry" value="${catEntry.packageDataBean}"/>
									<c:set var="catalogEntryDB" value="${catEntry.packageDataBean}"/>
									<c:set var="type" value="package" />
									<wcf:url var="catEntryDisplayUrl" value="mProduct1">
										<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
										<wcf:param name="storeId" value="${WCParam.storeId}"/>
										<wcf:param name="productId" value="${catEntry.catalogEntryID}"/>
										<wcf:param name="langId" value="${langId}"/>
										<wcf:param name="top_category" value="${WCParam.top_category}"/>
										<wcf:param name="parent_category_rn" value="${WCParam.parent_category_rn}"/>										
										<wcf:param name="categoryId" value="${WCParam.categoryId}"/>
										<wcf:param name="pgGrp" value="catNav"/>										
									</wcf:url>
									<c:set var="dragType" value="package" />
									<c:if test="${catalogEntryDB.buyable eq '0'}" >
										<c:set var="buyable" value="false"/>
									</c:if>

									<c:set var="displayPriceRange" value="true"/>
								</c:when>
								<c:when test="${catEntry.bundle}">
								<%-- set the catalogEntry var to the bundle bean --%>
									<c:set var="catalogEntry" value="${catEntry.bundleDataBean}"/>
									<c:set var="catalogEntryDB" value="${catEntry.bundleDataBean}"/>
									<c:set var="type" value="bundle" />
									<wcf:url var="catEntryDisplayUrl" value="mProduct1">
										<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
										<wcf:param name="storeId" value="${WCParam.storeId}"/>
										<wcf:param name="productId" value="${catEntry.catalogEntryID}"/>
										<wcf:param name="langId" value="${langId}"/>
										<wcf:param name="top_category" value="${WCParam.top_category}"/>
										<wcf:param name="parent_category_rn" value="${WCParam.parent_category_rn}"/>										
										<wcf:param name="categoryId" value="${WCParam.categoryId}"/>
										<wcf:param name="pgGrp" value="catNav"/>
									</wcf:url>
									<c:set var="dragType" value="bundle" />
									<c:if test="${catalogEntryDB.buyable eq '0'}" >
										<c:set var="buyable" value="false"/>
									</c:if>
									<c:set var="minimumPrice" value="${catalogEntryDB.minimumBundlePrice}"/>
									<c:set var="maximumPrice" value="${catalogEntryDB.maximumBundlePrice}"/>
								</c:when>
							</c:choose>     		              
											
							<%--<%@ include file="../../../Snippets/ReusableObjects/CatalogEntryDBThumbnailDisplay.jspf" %>	
							<%--<img src="${jspStoreImgDir}images/product_3.gif" width="45" height="45" border="0" alt="Product 3" />--%>
							<c:choose>
								<c:when test="${!empty catalogEntry.description.thumbNail}">
									<a href="${fn:escapeXml(catEntryDisplayUrl)}" ><img alt="${catEntry.description.name}" src="<c:out value="${hostPath}${catalogEntry.objectPath}${catalogEntry.description.thumbNail}"/>" width="45" height="45" border="0"/></a>
								</c:when>
								<c:otherwise>
									<a href="${fn:escapeXml(catEntryDisplayUrl)}" ><img src="<c:out value="${jspStoreImgDir}"/>images/NoImageIcon_sm.jpg" alt="<fmt:message key="No_Image" bundle="${storeText}"/>" width="45" height="45" border="0"/></a>						
								</c:otherwise>
							</c:choose>
							<ul>
							  	<li><span class="bullet">&#187; </span><a href="${fn:escapeXml(catEntryDisplayUrl)}" title="Product Name">${catEntry.description.name}</a></li>
								<li><span><fmt:message key="SKU" bundle="${storeText}" />: ${catEntry.partNumber}</span> </li>
								<c:set var="catalogEntryDB" value="${catalogEntry}" />
								<li><%@ include file="../../../Snippets/ReusableObjects/CatalogEntryPriceDisplay.jspf"%></li>
							</ul>
							<div class="clear_float"></div>			
							</div>							
						</li>
					</c:if>
				</c:if>
			</c:forEach>	
		</ol>

		<c:if test="${totalPages > 1}">
		<div class="paging_control">
			<div class="page_number">
				<fmt:message key="PAGING" bundle="${storeText}">
					<fmt:param value="${currentPage}"/>
					<fmt:param value="${totalPages}"/>				
				</fmt:message>
				<%-- 
				Page <c:out value="${currentPage}" />/<c:out value="${totalPages}" />
				--%>
			</div>
			<c:if test="${currentPage > 1}"> 
				<span class="bullet">&#171; </span>
				<wcf:url var="CategoryDisplayURL" value="mCategory3">
					<wcf:param name="langId" value="${langId}" />
					<wcf:param name="storeId" value="${WCParam.storeId}" />
					<wcf:param name="catalogId" value="${WCParam.catalogId}" />
					<wcf:param name="categoryId" value="${WCParam.categoryId}" />
					<wcf:param name="currentPage" value="${currentPage-1}" />			
					<wcf:param name="parent_category_rn" value="${topCategoryId}" />
					<c:choose>
						<c:when test="${!empty WCParam.top_category}">
							<wcf:param name="top_category" value="${WCParam.top_category}" />
						</c:when>
						<c:otherwise>
							<wcf:param name="top_category" value="${topCategoryId}" />
						</c:otherwise>
					</c:choose>							
				</wcf:url>
				<a href="${fn:escapeXml(CategoryDisplayURL)}" title="<fmt:message key="PAGING_PREV_PAGE_TITLE" bundle="${storeText}"/>">
				<fmt:message key="PAGING_PREV_PAGE" bundle="${storeText}"/></a>
			</c:if>
			&#160;&#160;
			<c:if test="${currentPage < totalPages}">
				<wcf:url var="CategoryDisplayURL" value="mCategory3">
					<wcf:param name="langId" value="${langId}" />
					<wcf:param name="storeId" value="${WCParam.storeId}" />
					<wcf:param name="catalogId" value="${WCParam.catalogId}" />
					<wcf:param name="categoryId" value="${WCParam.categoryId}" />
					<wcf:param name="currentPage" value="${currentPage+1}" />			
					<wcf:param name="parent_category_rn" value="${topCategoryId}" />
					<c:choose>
						<c:when test="${!empty WCParam.top_category}">
							<wcf:param name="top_category" value="${WCParam.top_category}" />
						</c:when>
						<c:otherwise>
							<wcf:param name="top_category" value="${topCategoryId}" />
						</c:otherwise>
					</c:choose>							
				</wcf:url>			
				<a href="${fn:escapeXml(CategoryDisplayURL)}" title="<fmt:message key="PAGING_NEXT_PAGE_TITLE" bundle="${storeText}"/>"><fmt:message key="PAGING_NEXT_PAGE" bundle="${storeText}"/></a>			
				<span class="bullet">&#187; </span>
			</c:if>
		</div>		
		</c:if>
	</div>
</c:if>   

<!-- END Categories.jsp -->  	
