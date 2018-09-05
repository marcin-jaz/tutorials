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
  * This JSP will display the child categories or products within a particular category
  *****
--%>

<!-- BEGIN CategoriesDisplay.jsp -->

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>

<%@ include file="../../../../include/parameters.jspf" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf" %>

<%-- Required variables for breadcrumb support --%>
<c:set var="categoryNavPageGroup" value="true" scope="request"/>
<c:set var="categoryPage" value="true" scope="request" />

<%-- retrieve the information that's related to the parent category if this category is a sub category --%>
<wcbase:useBean id="category"	classname="com.ibm.commerce.catalog.beans.CategoryDataBean"	scope="page" />
<c:if test="${empty WCParam.top}">
	<%--
	 * If the parent category id is not supplied in the URL (parent_category_rn),
 	* then get any parent category id from the category databean
	--%>
	<c:choose>
		<c:when test="${empty WCParam.parentCategoryId}">
			<c:choose>
				<%-- If there is parent category, the parent category will be the catalog --%>
				<c:when test="${empty category.parentCategories}">
					<c:set var="parentCategoryId" value="${WCParam.catalogId}" />
				</c:when>

				<%-- Take the first product we find in the category and get its parent --%>
				<c:otherwise>
					<c:set var="parentCategoryId"
						value="${category.parentCategories[0].categoryId}" />
				</c:otherwise>
			</c:choose>
		</c:when>
		<c:otherwise>
			<c:set var="parentCategoryId" value="${WCParam.parentCategoryId}" />
		</c:otherwise>
	</c:choose>
</c:if>

<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.2//EN" "http://www.openmobilealliance.org/tech/DTD/xhtml-mobile12.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" lang="${shortLocale}" xml:lang="${shortLocale}">
	<head>
		<title>
			<c:out value="${storeName}"/> - <c:out value="${category.description.name}" escapeXml="false"/> 
				- <fmt:message key="CATEGORY_TITLE" bundle="${storeText}"/>
		</title>
		<meta name="description" content="<c:out value="${category.description.longDescription}" escapeXml="false" />"/>
		<meta name="keyword" content="<c:out value="${category.description.keyWord}"  escapeXml="false" />"/>
		<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no" />
		<link rel="stylesheet" href="${cssPath}"/>
	</head>	
	<body>
		<div id="wrapper">	

			<%@ include file="../../../include/HeaderDisplay.jspf" %>
			<%@ include file="../../../include/searchHeader.jspf" %>						
			<%@ include file="../../../include/BreadCrumbTrailDisplay.jspf"%>			
			
			
			<c:set var="numEntries" value="0"/>
			<c:forEach var="count" items="${category.subCategories}" varStatus="status">
				<c:set var="numEntries" value="${numEntries+1}"/>
			</c:forEach>		
			<c:if test="${numEntries > 0 }">
			<%out.flush();%>
				<c:import url="SubCategories.jsp">
					<c:param name="storeId" value="${WCParam.storeId}"/>
					<c:param name="catalogId" value="${WCParam.catalogId}"/>
					<c:param name="langId" value="${langId}"/>
					<c:param name="categoryId" value="${categoryId}"/>
					<c:param name="parent_category_rn" value="${parentCategoryId}"/>
					<c:param name="top_category" value="${WCParam.top_category}"/>
				</c:import>
			<%out.flush();%>
				

				<%out.flush();%>
				<c:import url="${jspStoreDir}mobile/Snippets/Marketing/ESpot/FeaturedProductsESpot.jsp">
					<c:param name="emsName" value="Mobile${category.identifier}FeaturedProducts" />
					<c:param name="catalogId" value="${WCParam.catalogId}" />
					<c:param name="numberProductsToDisplay" value="4" />
					<c:param name="align" value="V" />
				</c:import>
				<%out.flush();%>
				
			</c:if>
			<c:if test="${numEntries == 0 }">
			<%out.flush();%>
				<c:import url="Categories.jsp">
					<c:param name="storeId" value="${WCParam.storeId}"/>
					<c:param name="catalogId" value="${WCParam.catalogId}"/>
					<c:param name="langId" value="${langId}"/>
					<c:param name="categoryId" value="${categoryId}"/>
					<c:param name="parent_category_rn" value="${parentCategoryId}"/>
					<c:param name="top_category" value="${WCParam.top_category}"/>
				</c:import>	
			<%out.flush();%>
			</c:if>
			<%@ include file="../../../include/FooterDisplay.jspf" %>						
		</div>
	</body>
</html>

<!-- END CategoriesDisplay.jsp -->
