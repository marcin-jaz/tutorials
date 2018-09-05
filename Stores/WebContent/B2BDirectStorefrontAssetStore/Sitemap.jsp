<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
	xsi:schemaLocation="http://www.sitemaps.org/schemas/sitemap/0.9 
	http://www.sitemaps.org/schemas/sitemap/0.9/sitemap.xsd" 
	xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
<%--==========================================================================
Licensed Materials - Property of IBM

WebSphere Commerce

(c) Copyright IBM Corp.  2006
All Rights Reserved

US Government Users Restricted Rights - Use, duplication or
disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
===========================================================================--%>

<%-- 
  *****
  * Sitemap.jsp is used to generate all the URLs a store admin want to be indexed by Google search engine.
  * This JSP can be called by site admin directly from a URL such as
  * http://<hostname>/<webpath>/<storedir>/Sitemap.jsp?storeId=10001&catalogIds=10001
  * parameters:
  * 	storeId: the storeId of the store to which the sitemap file is generated.
  *	catalogIds: list of catalog Ids that belong to this store.
  *     hostName: hostName of the production server which will host the sitemap xml file to be generated.
  *		  This parameter is required when the jsp is invoked on a staging server
  *****
--%>
<%@ page import="com.ibm.commerce.beans.DataBeanManager" %>
<%@ page import="com.ibm.commerce.seo.beans.CatalogNodeListDataBean" %>
<%@ page import="com.ibm.commerce.seo.beans.CatalogNodeDataBean" %>
<%@ page import="java.util.*" %>
<%@ page contentType="text/xml"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%--
***
* Retrieve parameters for deciding how many URLs to create and the beginning index for the current iteration.
***
--%>
<c:set var="numberUrlsToGenerate" value="${param.numberUrlsToGenerate}" />
<c:if test="${empty numberUrlsToGenerate}">
	<c:set var="numberUrlsToGenerate" value="50000"/>
</c:if>

<c:set var="beginIndex" value="${param.beginIndex}" />
<c:if test="${empty beginIndex}">
	<c:set var="beginIndex" value="0"/>
</c:if>

<c:set var="maxUrlsToGenerate" value="${beginIndex+numberUrlsToGenerate}" />
<c:set var="urlCounter" value="0" />

<%--
***
* Get storeId and create storeDB
***
--%>
<c:set var="storeId" value="${param.storeId}" /> 
<wcbase:useBean	id="storeDB" classname="com.ibm.commerce.common.beans.StoreDataBean">
	<c:set value="${storeId}" target="${storeDB}" property="storeId" />
</wcbase:useBean>

<%--
***
* If the sitemapGenerate command is executed on a staging server, then the command need pass hostName to the jsp, where
* hostName is the serverName which will be hosting the sitemap xml file to be generated.
***
--%>
<c:choose>
	<c:when test="${not empty param.hostName}">
		<c:set var="hostName" value="${param.hostName}"/>
	</c:when>
	<c:otherwise>
		<c:set var="hostName" value="${pageContext.request.serverName}"/>
	</c:otherwise>
</c:choose>

<c:set var="path" value="http://${hostName}${pageContext.request.contextPath}/servlet/" />

<%--
***
* The master catalog will be used if no catalogId is provided in the request
***
--%>
<c:choose>
	<c:when test="${empty param.catalogIds}">
	    	<c:set var="catalogIdsStr" value="${storeDB.masterCatalogDataBean.catalogId}" />
   	</c:when>
   	<c:otherwise>
		<c:set var="catalogIdsStr" value="${param.catalogIds}" />
    </c:otherwise>
</c:choose>

<%--
***
* Begin  generate URLs for views TopCategoriesDisplay, categoryDisplay and productDisplay for each catalogId.
***
--%>
<c:set var="delim" value="," />
<c:set var="catalogIdsArray" value="${fn:split(catalogIdsStr, delim)}" />

<c:forEach var="token" items="${catalogIdsArray}" varStatus="count">
	<c:set var="catalogId" value="${token}" />
	
	<%--
	***
	* For Each language supported by the store, generate URLs for view:
	* TopCategoriesDisplay
	***
	--%>
	<c:forEach var="dbLanguage" items="${storeDB.languageDataBeans}">
		<c:set var="langId" value="${dbLanguage.languageId}" />

		<c:url var="TopCategoriesDisplayURL" value="TopCategoriesDisplay">
			<c:param name="langId" value="${langId}" />
			<c:param name="storeId" value="${storeId}" />
			<c:param name="catalogId" value="${catalogId}" />
		</c:url>

		<c:if test="${urlCounter >= beginIndex && urlCounter < maxUrlsToGenerate}">
			<url>
				<loc> <c:out value="${path}${TopCategoriesDisplayURL}" /> </loc>
			</url>
		</c:if>
		<c:set var="urlCounter" value="${urlCounter + 1}" />
 	</c:forEach>
 	<%--
  	***
 	* End of topCategoriesDisplay
  	***
 	--%>	
 	
	<%
	String startedCount = "false";
	
	CatalogNodeListDataBean catalogTreeDB = new CatalogNodeListDataBean();
	catalogTreeDB.setCatalogId((String)pageContext.getAttribute("catalogId"));
	catalogTreeDB.setIncludeProducts(true);
	DataBeanManager.activate(catalogTreeDB, request);
	
	Iterator catalogIterator = catalogTreeDB.getIterator();
	while (catalogIterator.hasNext()) {
		CatalogNodeDataBean catalogTreeNode = (CatalogNodeDataBean)catalogIterator.next();
		pageContext.setAttribute("catalogTreeNode", catalogTreeNode);
	%>

		<c:set var="topCategoryId" value="${catalogTreeNode.topCategoryId}" />

		<%--
		***
		* Begin of generating URLs for all the languages for this catalog tree node
		***
   		--%>
		<c:forEach var="dbLanguage" items="${storeDB.languageDataBeans}">
			<c:set var="langId" value="${dbLanguage.languageId}" />
			<c:choose>
				<c:when test="${catalogTreeNode.type eq 'CategoryBean'}">
					<c:set var="categoryId"	value="${catalogTreeNode.category.categoryId}" />
					<c:set var="lastMod" value="${catalogTreeNode.category.lastUpdate}" />

					<c:choose>
						<c:when
							test="${catalogTreeNode.topCategoryId eq catalogTreeNode.category.categoryId}">
							<c:url var="loc" value="CategoryDisplay">
								<c:param name="langId" value="${langId}" />
								<c:param name="storeId" value="${storeId}" />
								<c:param name="catalogId" value="${catalogId}" />
								<c:param name="top" value="Y" />
								<c:param name="categoryId" value="${categoryId}" />								
							</c:url>
						</c:when>
						<c:otherwise>
							<c:url var="loc" value="CategoryDisplay">
								<c:param name="langId" value="${langId}" />
								<c:param name="storeId" value="${storeId}" />
								<c:param name="catalogId" value="${catalogId}" />
								<c:param name="categoryId" value="${categoryId}" />
								<c:param name="top_category" value="${topCategoryId}" />
								<c:param name="parent_category_rn" value="${catalogTreeNode.parentId}" />
							</c:url>
						</c:otherwise>
					</c:choose>
				</c:when>
				<c:otherwise>
					<c:set var="lastMod" value="${catalogTreeNode.lastModifiedDate}" />
					<c:url var="loc" value="ProductDisplay">
						<c:param name="langId" value="${langId}" />
						<c:param name="storeId" value="${storeId}" />
						<c:param name="catalogId" value="${catalogId}" />
						<c:param name="productId" value="${catalogTreeNode.catalogEntryId}" />
						<c:param name="top_category" value="${topCategoryId}" />
						<c:param name="parent_category_rn" value="${catalogTreeNode.parentId}" />
					</c:url>
				</c:otherwise>
			</c:choose>

			<c:choose>
				<c:when test="${urlCounter >= beginIndex && urlCounter < maxUrlsToGenerate}">
					<%
						startedCount = "true";
					%>
					<url>
						<loc> <c:out value="${path}${loc}" /> </loc>
						<c:if test="${not empty lastMod}">
							<c:set var="dateLength" value="10" />
							<lastmod> <c:out value="${fn:substring(lastMod, 0, dateLength)}" /> </lastmod>
						</c:if>
					 </url>
				</c:when>
				<c:otherwise>
					<%
						if (startedCount == "true") {
							break;
						}
					%>
				</c:otherwise>
			</c:choose>
			<c:set var="urlCounter" value="${urlCounter + 1}" />
		</c:forEach>
		<%--
		***
		* End of generating views categoryDisplay and productDisplay for all the languages for this catalog tree node
		***
   		--%>

	<%
	} //end while
	%>	
	<%--
	***
	* End of generating views categoryDisplay and productDisplay for this catalogID
	***
   	--%>
    <c:remove var="catalogTreeDB" scope="page" />
</c:forEach> 
<%--
***
* End of generating views categoryDisplay and productDisplay for all catalogIDs
***
--%>

<%--
***
* For Each language supported by the store, generate URLs for view:
* HelpView. Only need generate URLs for one catalogId.
***
--%>

<c:forEach var="dbLanguage" items="${storeDB.languageDataBeans}">
	<c:set var="langId" value="${dbLanguage.languageId}" />

	<%--
  	***
  	* begin of HelpView 
    ***
    --%>
  <c:if test="${urlCounter >= beginIndex && urlCounter < maxUrlsToGenerate}">
		<c:url var="HelpViewURL" value="HelpView">
			<c:param name="langId" value="${langId}" />
			<c:param name="storeId" value="${storeId}" />
			<c:param name="catalogId" value="${catalogId}" />
		</c:url>
		<url> 
			<loc> <c:out value="${path}${HelpViewURL}" /> </loc> 
		</url>
	</c:if>
	<c:set var="urlCounter" value="${urlCounter + 1}" />
	<%--
  	***
 	* End of HelpView
  	***
 	--%>	

</c:forEach>
<%--
***
* End of for Each language supported by the store, generate URLs for view:
* HelpView.
***
--%>
</urlset>	
<%-- End - JSP File Name:  Sitemap.jsp --%>

