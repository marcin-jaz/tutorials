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
  * This JSP file renders the category pages. There are 2 displays for a category page:
  * 1) Department display page is used to render any top category page
  * 2) Other category display page is used to render all other categories
  *****
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ taglib uri="http://commerce.ibm.com/coremetrics"  prefix="cm" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf"%>
<%@ include file="../../../include/nocache.jspf"%>

<c:set var="categoryPage" value="true" scope="request"/>
<c:set var="hasBreadCrumbTrail" value="true" scope="request"/>
<c:set var="useHomeRightSidebar" value="false" scope="request"/>
<c:set var="parentCategoryId" value=""/>

<wcbase:useBean id="category" classname="com.ibm.commerce.catalog.beans.CategoryDataBean" scope="page" />

<%-- retrieve the information that's related to the parent category if this category is a sub category --%>
<c:if test="${empty WCParam.top}">
	<%--
	 * If the parent category id is not supplied in the URL (parent_category_rn),
 	* then get any parent category id from the category databean
	--%>
	<c:choose>
		<c:when test="${empty WCParam.parent_category_rn}">
			<%-- Take the first product we find in the category and get its parent --%>
			<c:if test="${!empty category.parentCategories}">
				<c:set var="parentCategoryId" value="${category.parentCategories[0].categoryId}"/>
			</c:if>
		</c:when>
		<c:otherwise>
			 <c:set var="parentCategoryId" value="${WCParam.parent_category_rn}"/>
		</c:otherwise>
	</c:choose>
</c:if>

<wcf:url var="CategoryDisplayViewURL" value="CategoryOnlyResultsDisplayView">
  <wcf:param name="langId" value="${langId}" />						
  <wcf:param name="storeId" value="${WCParam.storeId}" />
  <wcf:param name="catalogId" value="${WCParam.catalogId}" />
  <wcf:param name="categoryId" value="${WCParam.categoryId}" />
</wcf:url>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns:wairole="http://www.w3.org/2005/01/wai-rdf/GUIRoleTaxonomy#"
xmlns:waistate="http://www.w3.org/2005/07/aaa" lang="${shortLocale}" xml:lang="${shortLocale}">
<head>
<!-- Mimic Internet Explorer 7 -->
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" >
<title><c:out value="${storeName}"/> - <c:out value="${category.description.name}" escapeXml="false"/> - <fmt:message key="CATEGORY_TITLE" bundle="${storeText}"/></title>
<meta name="description" content="<c:out value="${category.description.longDescription}"/>"/>
<meta name="keyword" content="<c:out value="${category.description.keyWord}"/>"/>
<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${vfileStylesheet}"/>" type="text/css"/>
<!--[if lte IE 6]>
<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${vfileStylesheetie}"/>" type="text/css"/>
<![endif]-->
<script type="text/javascript" src="<c:out value="${dojoFile}"/>" djConfig="${dojoConfigParams}"></script>
<%@ include file="../../../include/CommonJSToInclude.jspf"%>
<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/CatalogArea/CategoryDisplay.js"/>"></script>
<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/MessageHelper.js"/>"></script>
<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/ServicesDeclaration.js"/>"></script>
<script type="text/javascript">
	
	dojo.addOnLoad(categoryDisplayJS.processBookmarkURL);
	dojo.addOnLoad(function() { 
		<fmt:message key="ERR_RESOLVING_SKU" bundle="${storeText}" var="ERR_RESOLVING_SKU" />
		<fmt:message key="QUANTITY_INPUT_ERROR" bundle="${storeText}" var="QUANTITY_INPUT_ERROR" />
		<fmt:message key="WISHLIST_ADDED" bundle="${storeText}" var="WISHLIST_ADDED" />
		<fmt:message key="SHOPCART_ADDED" bundle="${storeText}" var="SHOPCART_ADDED" />
		<fmt:message key="ERROR_MESSAGE_TYPE" bundle="${storeText}" var="ERROR_MESSAGE_TYPE" />
		<fmt:message key="PAGE_EMPTY" bundle="${storeText}" var="PAGE_EMPTY" />
		<fmt:message key="PAGE_INVALID" bundle="${storeText}" var="PAGE_INVALID" />
		<fmt:message key="ERROR_CONTRACT_EXPIRED_GOTO_ORDER" bundle="${storeText}" var="ERROR_CONTRACT_EXPIRED_GOTO_ORDER" />
		<fmt:message key="GENERICERR_MAINTEXT" bundle="${storeText}" var="ERROR_RETRIEVE_PRICE">                                     
			<fmt:param><fmt:message key="GENERICERR_CONTACT_US" bundle="${storeText}" /></fmt:param>
		</fmt:message>
		
		MessageHelper.setMessage("ERROR_RETRIEVE_PRICE", <wcf:json object="${ERROR_RETRIEVE_PRICE}"/>);
		MessageHelper.setMessage("ERR_RESOLVING_SKU", <wcf:json object="${ERR_RESOLVING_SKU}"/>);
		MessageHelper.setMessage("QUANTITY_INPUT_ERROR", <wcf:json object="${QUANTITY_INPUT_ERROR}"/>);
		MessageHelper.setMessage("WISHLIST_ADDED", <wcf:json object="${WISHLIST_ADDED}"/>);
		MessageHelper.setMessage("SHOPCART_ADDED", <wcf:json object="${SHOPCART_ADDED}"/>);
		MessageHelper.setMessage("ERROR_MESSAGE_TYPE", <wcf:json object="${ERROR_MESSAGE_TYPE}"/>);
		MessageHelper.setMessage("ERROR_EMPTY_NUM", <wcf:json object="${PAGE_EMPTY}"/>);
		MessageHelper.setMessage("ERROR_PAGE_NUM", <wcf:json object="${PAGE_INVALID}"/>);
		MessageHelper.setMessage("ERROR_CONTRACT_EXPIRED_GOTO_ORDER", <wcf:json object="${ERROR_CONTRACT_EXPIRED_GOTO_ORDER}"/>);
		categoryDisplayJS.setCommonParameters('${WCParam.langId}','${WCParam.storeId}','${WCParam.catalogId}','${userType}');
		categoryDisplayJS.initHistory("CategoryDisplay_Widget", '${CategoryDisplayViewURL}');
		ServicesDeclarationJS.setCommonParameters('${WCParam.langId}','${WCParam.storeId}','${WCParam.catalogId}');
	});
</script>


</head>
  <body>
	<script type="text/javascript">
		<!-- Do not try putting this under a dojo.addonload, since dojo.back: Not initialised, You should call dojo.back.init() from a <script> block that lives inside the <body> tag to prevent bugs on IE. -->
		dojo.require("dojo.back");
		dojo.back.init();
	</script>  
	
	<%@ include file="../../../include/StoreCommonUtilities.jspf"%>
	
	<div id="page">
		<%@ include file="../../../include/LayoutContainerTop.jspf"%>
		
		<div id="content_wrapper_box">
			<div id="MessageArea" >
				<br />
				<span id="ErrorMessageText" class="error_msg" tabindex="-1">
		
				</span>
				<br /><br />  
			</div>
			
			<%@ include file="../../../Snippets/ReusableObjects/CatalogEntryQuickInfoDetails.jspf" %>
			
			<%out.flush();%>
			<c:choose>
				<c:when test="${empty top}">
					<%out.flush();%>
					<c:import url="${jspStoreDir}Snippets/Catalog/CategoryDisplay/CategoryOnlyDisplay.jsp">
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
					<c:import url="${jspStoreDir}Snippets/Catalog/CategoryDisplay/DepartmentDisplay.jsp">
						<c:param name="storeId" value="${WCParam.storeId}"/>
			      <c:param name="catalogId" value="${WCParam.catalogId}"/>
			      <c:param name="langId" value="${langId}"/>
			      <c:param name="categoryId" value="${categoryId}"/>
					</c:import>
					<%out.flush();%>
				</c:otherwise>
			</c:choose>                     
			<%out.flush();%>
		</div>
		
		<%@ include file="../../../include/LayoutContainerBottom.jspf"%>
	</div>
	<div id="page_shadow" class="shadow"></div> 
<flow:ifEnabled feature="Analytics"><cm:pageview/></flow:ifEnabled>
  </body>
 </html>
   


