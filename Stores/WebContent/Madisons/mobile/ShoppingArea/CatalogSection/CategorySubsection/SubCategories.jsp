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
  * This JSP snippet will display the sub categories present in a particular category
  *****
--%>

<!-- BEGIN SubCategories.jsp -->

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>

<%@ include file="../../../../include/parameters.jspf" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf" %>

	
<wcbase:useBean id="category" classname="com.ibm.commerce.catalog.beans.CategoryDataBean" scope="page"/>

<c:set var="topLevelDescription" value="${category.description.name}" />
<c:set var="subCategories" value="${category.subCategories}" />
<c:set var="topCategoryId" value="${category.categoryId}" />

<c:set var="numEntries" value="${fn:length(subCategories)}"/>
<c:set var="pageSize" value="${param.pageSize}"/>
<c:if test="${empty pageSize}">
	<c:set var="pageSize" value="${categoryMaxPageSize}" />
</c:if>
	
<%-- Counts the page number we are drawing in.  --%>
<c:set var="currentPage" value="${WCParam.currentPage}" />
<c:if test="${empty currentPage}">
	<c:set var="currentPage" value="1" />
</c:if>

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
		
<div id="department" class="content_box">
	<div class="heading_container">
		<h2><c:out value="${category.description.name}" escapeXml="false" /></h2>
		<div class="clear_float"></div>
	</div>
			
	<ul>
		<c:forEach var="subCategory" items="${subCategories}" begin="${beginIndex}" end="${endIndex}" varStatus="counter">
			<c:if test="${counter.count <= numRecordsToShow}">
				<wcf:url var="CategoryDisplayURL" value="mCategory2">
					<wcf:param name="langId" value="${langId}" />
					<wcf:param name="storeId" value="${WCParam.storeId}" />
					<wcf:param name="catalogId" value="${WCParam.catalogId}" />
					<wcf:param name="categoryId" value="${subCategory.categoryId}" />
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
				<c:choose>
					<c:when test="${WCParam.categoryId == subCategory.categoryId}">
						<li><span class="bullet">&#187; </span><a href="${fn:escapeXml(CategoryDisplayURL)}"><c:out value="${subCategory.description.name}" escapeXml="false" /></a></li>
					</c:when>
					<c:otherwise>
						<li><span class="bullet">&#187; </span><a href="${fn:escapeXml(CategoryDisplayURL)}"><c:out value="${subCategory.description.name}" escapeXml="false" /></a></li>
					</c:otherwise>
				</c:choose>			
			</c:if>
		</c:forEach>			
	</ul>				

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
				<c:if test="${!empty WCParam.top}">
					<wcf:param name="top" value="${WCParam.top}" />	
				</c:if>					
				<c:choose>
					<c:when test="${!empty WCParam.top_category}">
						<wcf:param name="top_category" value="${WCParam.top_category}" />
					</c:when>
					<c:otherwise>
						<wcf:param name="top_category" value="${topCategoryId}" />
					</c:otherwise>
				</c:choose>					
			</wcf:url>
			<a href="${fn:escapeXml(CategoryDisplayURL)}" title="<fmt:message key="PAGING_PREV_PAGE_TITLE" bundle="${storeText}"/>"><fmt:message key="PAGING_PREV_PAGE" bundle="${storeText}"/></a>
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
				<c:if test="${!empty WCParam.top}">
					<wcf:param name="top" value="${WCParam.top}" />	
				</c:if>
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

<!-- END SubCategories.jsp -->
