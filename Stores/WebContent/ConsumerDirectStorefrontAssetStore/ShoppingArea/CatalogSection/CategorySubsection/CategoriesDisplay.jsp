<%
//********************************************************************
//*-------------------------------------------------------------------
//* Licensed Materials - Property of IBM
//*
//* WebSphere Commerce
//*
//* (c) Copyright IBM Corp. 2000, 2002, 2004
//*
//* US Government Users Restricted Rights - Use, duplication or
//* disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
//*
//*-------------------------------------------------------------------
//*
%>

<%--
  *****
  *	This JSP displays any store categories with the store's header, footer and sidebar. When it actually displays
  *	the content of a category, it imports the page CachedCategoriesDisplay.jsp. The following three pages are imported: 
  *  - CachedHeaderDisplay.jsp, which displays the header of the page
  *  - CachedCategoriesDisplay.jsp, which displays a category at a certain level
  *  - CachedFooter.jsp, which displays the footer of the page
  *****
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf" %>


<wcbase:useBean id="category" classname="com.ibm.commerce.catalog.beans.CategoryDataBean" scope="page" />

<%-- If the current category is a sub category, then the following setup is needed --%>
<c:if test="${empty WCParam.top}">
	<%-- Set the parentCategoryId if it is not set yet --%>
	<c:choose>
		<c:when test="${empty WCParam.parent_category_rn}">
			<c:if test="${!empty category.parentCategories}">
				<c:set var="parentCategoryId" value="${category.parentCategories[0].categoryId}" />
			</c:if>
		</c:when>
		<c:otherwise>
			<c:set var="parentCategoryId" value="${WCParam.parent_category_rn}" />
		</c:otherwise>
	</c:choose>
</c:if>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title><c:out value="${storeName}"/> - <c:out value="${category.description.name}" escapeXml="false"/> - <fmt:message key="CATEGORY_TITLE" bundle="${storeText}"/></title>
<meta name="description" content="<c:out value="${category.description.longDescription}"/>"/>
<meta name="keyword" content="<c:out value="${category.description.keyWord}"/>"/>
<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${vfileStylesheet}"/>" type="text/css"/>
</head>

<body>
<!-- JSP File Name:  CategoriesDisplay.jsp -->

<%@ include file="../../../include/LayoutContainerTop.jspf"%>

		<!--MAIN CONTENT STARTS HERE-->

		<%-- The c:import is nested in the c:choose because the other way around is not alloed by the standard. Therefore, we have to
		     live with some duplications here.
		--%>
		<%-- Determine which URl command to use for the CachedCategoriesDisplay import. For sub-categories, two more parameters
		     are needed than top-level categories
		--%>
		<%-- Flush the buffer so this fragment JSP is not cached twice --%>
		<c:choose>
			<c:when test="${empty top}">
				<%out.flush();%>
				<c:import url="../../../Snippets/Catalog/CategoryDisplay/CachedCategoriesDisplay.jsp">
					<c:param name="storeId" value="${WCParam.storeId}"/>
					<c:param name="catalogId" value="${WCParam.catalogId}"/>
					<c:param name="langId" value="${langId}"/>
					<c:param name="categoryId" value="${categoryId}"/>
					<%-- The follow two parms are for the sub category only --%>
					<c:param name="parent_category_rn" value="${parentCategoryId}"/>
					<c:param name="top_category" value="${WCParam.top_category}"/>
				</c:import>
				<%out.flush();%>
		    </c:when>

		    <c:otherwise>
		    	<%out.flush();%>
		    	<c:import url="../../../Snippets/Catalog/CategoryDisplay/CachedCategoriesDisplay.jsp">
		            <c:param name="storeId" value="${WCParam.storeId}"/>
		            <c:param name="catalogId" value="${WCParam.catalogId}"/>
		            <c:param name="langId" value="${langId}"/>
		            <c:param name="categoryId" value="${categoryId}"/>
		        </c:import>
		        <%out.flush();%>
		    </c:otherwise>
		</c:choose>		
		<!-- MAIN CONTENT ENDS HERE -->

		<%-- Hide CIP --%>
		<c:set var="HideCIP" value="true"/>

		<%@ include file="../../../include/LayoutContainerBottom.jspf"%>
</body>
</html>

