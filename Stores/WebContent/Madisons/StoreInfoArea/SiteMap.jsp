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
  * This JSP displays the store's site map. It shows all the top level categories of the store catalog and their subcategories
  *****
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ taglib uri="http://commerce.ibm.com/coremetrics"  prefix="cm" %>
<%@ include file="../include/JSTLEnvironmentSetup.jspf" %>
<%@ include file="../include/nocache.jspf" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="${shortLocale}" xml:lang="${shortLocale}">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><fmt:message key="SITEMAP_TITLE" bundle="${storeText}" /></title>
<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${vfileStylesheet}"/>" type="text/css"/>
<!--[if lte IE 6]>
<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${vfileStylesheetie}"/>" type="text/css"/>
<![endif]-->
<script type="text/javascript" src="<c:out value="${dojoFile}"/>" djConfig="${dojoConfigParams}"></script>
<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/MessageHelper.js"/>"></script>
<%@ include file="../include/CommonJSToInclude.jspf"%>
</head>
<body>
<%@ include file="../include/StoreCommonUtilities.jspf"%>
<!-- Page Start -->
<div id="page">
	<!-- Header Nav Start -->
	<%@ include file="../include/LayoutContainerTop.jspf"%>
	<!-- Header Nav End -->
	<div id="MessageArea" >
		<br />
		<span id="ErrorMessageText" class="error_msg">
			
		</span>
		<br /><br />  
	</div>
	<!-- Main Content Start -->
	<div id="content_wrapper_border">

		<!-- Content Start -->
		<div id="box">
			<div class="sitemap" id="WC_SiteMap_div_1">
				<div class="title" id="WC_SiteMap_div_2"><h1 class="static_pages_header"><fmt:message key="SITEMAP_TITLE" bundle="${storeText}" /></h1></div>
	 
	 			<wcbase:useBean id="catalog" classname="com.ibm.commerce.catalog.beans.CatalogDataBean" scope="page" />
	 			
				<c:forEach var="topCategory" items="${catalog.topCategories}" varStatus="status">
					<c:set var="topCategoryDescription" value="${topCategory.description}"/>
					
					<div class="container" id="WC_SiteMap_div_3_<c:out value='${status.count}'/>">

							<c:set property="attachmentUsage" value="THUMBNAIL" target="${topCategory}" />
							<c:set var="allAttachemntsByUsage" value="${topCategory.attachmentsByUsage}"/>
							<c:set var="topCategoryHasAttachments" value="false" /> 
							<c:if test="${!empty allAttachemntsByUsage}">
						    	<c:set var="topCategoryHasAttachments" value="true" /> 
						    </c:if> 
							<c:choose>
								<c:when test="${topCategoryHasAttachments}">
									<%out.flush();%>
								  	<c:import url="${jspStoreDir}Snippets/Catalog/Attachments/CatalogAttachmentAssetsDisplay.jsp">
										<c:param name="storeId" value="${WCParam.storeId}"/>
										<c:param name="catalogId" value="${WCParam.catalogId}"/>
										<c:param name="langId" value="${langId}"/>
										<c:param name="categoryId" value="${topCategory.categoryId}"/>
										<c:param name="catType" value="category"/>
										<c:param name="usage" value="THUMBNAIL"/>
										<c:param name="retrieveLanguageIndependentAtchAst" value="1"/>
									</c:import>	
									<%out.flush();%>
								</c:when>
								<c:otherwise>									
									<div class="bluegrad_header">
										<wcf:url var="topCategoryDisplayUrl" value="Category3">
											<wcf:param name="catalogId" value="${WCParam.catalogId}" />
											<wcf:param name="storeId" value="${WCParam.storeId}" />
											<wcf:param name="categoryId" value="${topCategory.categoryId}" />
											<wcf:param name="langId" value="${langId}" />
											<wcf:param name="top" value="Y" />
											<wcf:param name="pageView" value="${defaultPageView}" />
											<wcf:param name="beginIndex" value="0" />
										</wcf:url>

										 <div class="sitemap_left"></div>
										 <div class="left">
											 <span class="header">
											 	<a href='<c:out value="${topCategoryDisplayUrl}"/>' id="WC_TopCategoryDisplay_links_1_<c:out value='${status.count}'/>"><h2><c:out value="${topCategoryDescription.name}" escapeXml="false"/></h2></a>
											 </span>
										 </div>
										 <div class="sitemap_right"></div>

									</div>

								</c:otherwise>
							</c:choose>
					
						<div class="content">
							<div class="blueline_compare"></div>
								<div class="links" id="WC_SiteMap_div_5_<c:out value='${status.count}'/>">
									<c:forEach var="subTopCategory" items="${topCategory.subCategories}" varStatus="status2">
										<c:set var="subTopCategoryDescription" value="${subTopCategory.description}"/>
										<wcf:url var="subTopCategoryDisplayUrl" value="Category4">
											<wcf:param name="catalogId" value="${WCParam.catalogId}" />
											<wcf:param name="storeId" value="${WCParam.storeId}" />
											<wcf:param name="categoryId" value="${subTopCategory.categoryId}" />
											<wcf:param name="langId" value="${langId}" />
											<wcf:param name="parent_category_rn" value="${topCategory.categoryId}" />
											<wcf:param name="top_category" value="${topCategory.categoryId}" />
											<wcf:param name="pageView" value="${defaultPageView}" />
											<wcf:param name="beginIndex" value="0" />
										</wcf:url>
										<p><a href='<c:out value="${subTopCategoryDisplayUrl}"/>' id="WC_SiteMap_link_1_<c:out value='${status.count}'/>_<c:out value='${status2.count}'/>"><c:out value="${subTopCategoryDescription.name}" escapeXml="false"/></a></p>
									</c:forEach>
								</div>
							</div>
						
						
						<div id="WC_SiteMap_div_6_<c:out value='${status.count}'/>"><img src="<c:out value="${jspStoreImgDir}${vfileColor}" />sitemap_container_bottom.png" alt="<fmt:message key="SITEMAP_TITLE" bundle="${storeText}" />"/></div>
					</div>
				</c:forEach>
	 
			</div><br clear="all" /><br /><br />
		</div>
		<!-- Content End -->

	</div>
	<!-- Main Content End -->

	<!-- Footer Start -->
	<%@ include file="../include/LayoutContainerBottom.jspf"%>
	<!-- Footer End -->

</div>
<div id="page_shadow" class="shadow"></div>
<flow:ifEnabled feature="Analytics"><cm:pageview/></flow:ifEnabled>
</body>
</html>
