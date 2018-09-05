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
  * This JSP will display the top level categories present in a particular catalog
  *****
--%>

<!-- BEGIN TopCategoriesDisplay.jsp -->

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>

<%@ include file="../../../../include/parameters.jspf" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf" %>

<%-- Required variables for breadcrumb support --%>
<c:set var="categoryNavPageGroup" value="true" scope="request"/>
<%-- 
<c:set var="departmentPage" value="true" scope="request" />
--%>
<wcbase:useBean id="catalog" classname="com.ibm.commerce.catalog.beans.CatalogDataBean" >
	<c:set target="${catalog}" property="catalogId" value="${param.catalogId}"/>
</wcbase:useBean>

<c:set var="numEntries" value="${fn:length(catalog.topCategories)}"/>
<c:set var="pageSize" value="${param.pageSize}"/>
<c:if test="${empty pageSize}">
	<c:set var="pageSize" value="${departmentMaxPageSize}" />
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

<ul>
  <c:forEach var="topCategory" items="${catalog.topCategories}" varStatus="status" begin="${beginIndex}" end="${endIndex}">
	<c:if test="${status.count <= numRecordsToShow}">
		<wcf:url var="CategoryDisplayURL" value="mCategory1">
			<wcf:param name="langId" value="${langId}" />	
			<wcf:param name="storeId" value="${WCParam.storeId}" />
			<wcf:param name="catalogId" value="${WCParam.catalogId}" />
			<wcf:param name="categoryId" value="${topCategory.categoryId}" />
			<wcf:param name="top" value="Y" />
			<wcf:param name="top_category" value="${topCategory.categoryId}" />
		</wcf:url>
		<li><span class="bullet">&#187; </span>
			<a href="${fn:escapeXml(CategoryDisplayURL)}"><c:out value="${topCategory.description.name}" escapeXml="false"/></a>
		</li>
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
			<wcf:url var="MobileIndexURL" value="mIndex">
				<wcf:param name="langId" value="${langId}" />
				<wcf:param name="storeId" value="${WCParam.storeId}" />
				<wcf:param name="catalogId" value="${WCParam.catalogId}" />
				<wcf:param name="currentPage" value="${currentPage-1}" />
			</wcf:url>
			<a href="${fn:escapeXml(MobileIndexURL)}" title="<fmt:message key="PAGING_PREV_PAGE_TITLE" bundle="${storeText}"/>"><fmt:message key="PAGING_PREV_PAGE" bundle="${storeText}"/></a>
		</c:if>
		&#160;&#160;
		<c:if test="${currentPage < totalPages}">
			<wcf:url var="MobileIndexURL" value="mIndex">
		  		<wcf:param name="langId" value="${langId}" />
		  		<wcf:param name="storeId" value="${WCParam.storeId}" />
		  		<wcf:param name="catalogId" value="${WCParam.catalogId}" />
		  		<wcf:param name="currentPage" value="${currentPage+1}" />
			</wcf:url>
			<a href="${fn:escapeXml(MobileIndexURL)}" title="<fmt:message key="PAGING_NEXT_PAGE_TITLE" bundle="${storeText}"/>"><fmt:message key="PAGING_NEXT_PAGE" bundle="${storeText}"/></a>
			<span class="bullet">&#187; </span>
		</c:if>
	</div>
</c:if>	
<!-- END TopCategoriesDisplay.jsp -->
