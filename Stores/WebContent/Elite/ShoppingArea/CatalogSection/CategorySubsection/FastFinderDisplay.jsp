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
  * This JSP file renders the Fast Finder page. This page creates filters of brands, features, and price for the shopper
  * to easily narrow down products that they will be interested in purchasing. Any category can be configured to be 
  * displayed using the FastFinderDisplay.jsp by creating an entry in the DISPCGPREL table with the PAGENAME column
  * pointing to this JSP file.
  *****
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf"%>
<%@ include file="../../../include/nocache.jspf"%>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ taglib uri="http://commerce.ibm.com/coremetrics"  prefix="cm" %>

<wcbase:useBean id="category" classname="com.ibm.commerce.catalog.beans.CategoryDataBean" scope="page"/>

<c:choose>
<c:when test="${!empty WCParam.categoryId}">
	<c:set var="categoryId" value="${WCParam.categoryId}"/>
</c:when>
<c:otherwise>
	<c:set var="categoryId" value="${category.categoryId}"/>
</c:otherwise>
</c:choose>

<c:choose>
<c:when test="${!empty WCParam.beginIndex}">
	<c:set var="pageBeginIndex" value="${WCParam.beginIndex}"/>
</c:when>
<c:otherwise>
	<c:set var="pageBeginIndex" value="0"/>
</c:otherwise>
</c:choose>

<c:set var="categoryPage" value="true" scope="request"/>
<c:set var="fastFinder" value="true" scope="request"/>
<c:set var="hasBreadCrumbTrail" value="true" scope="request"/>
<c:set var="useHomeRightSidebar" value="false" scope="request"/>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="${shortLocale}" xml:lang="${shortLocale}">
<head>
	<!-- Mimic Internet Explorer 7 -->
	<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" >
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><fmt:message key="FF_FASTFINDER" bundle="${storeText}"/></title>
<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${vfileStylesheet}"/>" type="text/css"/>
<!--[if lte IE 6]>
<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${vfileStylesheetie}"/>" type="text/css"/>
<![endif]-->
<script type="text/javascript" src="<c:out value="${dojoFile}"/>" djConfig="${dojoConfigParams}"></script>
<%@ include file="../../../include/CommonJSToInclude.jspf"%>
<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/CatalogArea/CategoryDisplay.js"/>"></script>
<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/CatalogArea/CatalogEntryThumbnailDisplay.js"/>"></script>
<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/Vector.js"/>"></script>
<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/MessageHelper.js"/>"></script>
<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/CatalogArea/FastFinderDisplay.js"/>"></script>
<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/ServicesDeclaration.js"/>"></script>
<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/Analytics.js"/>"></script>
<script type="text/javascript">
	dojo.addOnLoad(function() {
		ServicesDeclarationJS.setCommonParameters('${WCParam.langId}','${WCParam.storeId}','${WCParam.catalogId}');
		categoryDisplayJS.setCommonParameters('${WCParam.langId}','${WCParam.storeId}','${WCParam.catalogId}','${userType}');
		fastFinderJS.setBeginIndex('${pageBeginIndex}');
		
		<fmt:message key="WISHLIST_ADDED" bundle="${storeText}" var="WISHLIST_ADDED" />
		<fmt:message key="SHOPCART_ADDED" bundle="${storeText}" var="SHOPCART_ADDED" />
		<fmt:message key="ERROR_MESSAGE_TYPE" bundle="${storeText}" var="ERROR_MESSAGE_TYPE" />
		<fmt:message key="QUANTITY_INPUT_ERROR" bundle="${storeText}" var="QUANTITY_INPUT_ERROR" />
		<fmt:message key="ERR_RESOLVING_SKU" bundle="${storeText}" var="ERR_RESOLVING_SKU" />
		<fmt:message key="ERROR_CONTRACT_EXPIRED_GOTO_ORDER" bundle="${storeText}" var="ERROR_CONTRACT_EXPIRED_GOTO_ORDER" />
		<fmt:message key="GENERICERR_MAINTEXT" bundle="${storeText}" var="ERROR_RETRIEVE_PRICE">                                     
			<fmt:param><fmt:message key="GENERICERR_CONTACT_US" bundle="${storeText}" /></fmt:param>
		</fmt:message>
		
		MessageHelper.setMessage("ERROR_RETRIEVE_PRICE", <wcf:json object="${ERROR_RETRIEVE_PRICE}"/>);
		MessageHelper.setMessage("WISHLIST_ADDED", <wcf:json object="${WISHLIST_ADDED}"/>);
		MessageHelper.setMessage("SHOPCART_ADDED", <wcf:json object="${SHOPCART_ADDED}"/>);
		MessageHelper.setMessage("ERROR_MESSAGE_TYPE", <wcf:json object="${ERROR_MESSAGE_TYPE}"/>);
		MessageHelper.setMessage("QUANTITY_INPUT_ERROR", <wcf:json object="${QUANTITY_INPUT_ERROR}"/>);
		MessageHelper.setMessage("ERR_RESOLVING_SKU", <wcf:json object="${ERR_RESOLVING_SKU}"/>);
		MessageHelper.setMessage("ERROR_CONTRACT_EXPIRED_GOTO_ORDER", <wcf:json object="${ERROR_CONTRACT_EXPIRED_GOTO_ORDER}"/>);
	});
</script>
 
<flow:ifDisabled feature='AjaxAddToCart'>
	<script type="text/javascript">
		fastFinderJS.setAjaxVar("false");
	</script>
</flow:ifDisabled>

<flow:ifEnabled feature='AjaxAddToCart'>
	<script type="text/javascript">
		fastFinderJS.setAjaxVar("true");
	</script>
</flow:ifEnabled>
<flow:ifEnabled feature='ProductDnD'>
<script type="text/javascript">
			fastFinderJS.setDragVar("true");
	</script>
</flow:ifEnabled>
<flow:ifDisabled feature='ProductDnD'>
<script type="text/javascript">
		fastFinderJS.setDragVar("false");
	</script>
</flow:ifDisabled>
<flow:ifEnabled feature='ProductQuickView'>
<script type="text/javascript">
fastFinderJS.setQinfoVar("true");
</script>
</flow:ifEnabled>
<flow:ifDisabled feature='ProductQuickView'>
<script type="text/javascript">
fastFinderJS.setQinfoVar("false");	
</script>
</flow:ifDisabled>
</head>


<body>
<script type="text/javascript">
	<!-- Do not try putting this under a dojo.addonload, since dojo.back: Not initialised, You should call dojo.back.init() from a <script> block that lives inside the <body> tag to prevent bugs on IE. -->
	dojo.require("dojo.back");
	dojo.back.init();
</script>
<%@ include file="../../../include/StoreCommonUtilities.jspf"%>
 <%@ include file="../../../Snippets/ReusableObjects/CatalogEntryQuickInfoDetails.jspf"%>


	
 <div id="page">
	<%@ include file="../../../include/LayoutContainerTop.jspf"%>

	<div id="content_wrapper_box">
		<div id="content588">
			<div id="MessageArea" >
				<br />
				<span id="ErrorMessageText" class="error_msg" tabindex="-1">
					 
				</span>
				<br /><br />  
			</div>		
			<h1><c:out value="${category.description.name}" /></h1>
			<div id="box">
				<div class="contentgrad_header" id="fastFinderResultControls">
					<div class="left_corner" id="WC_FastFinderDisplay_div_1"></div>
					<div class="left" id="WC_FastFinderDisplay_div_2">
						<div class="fastFinderPagination" id="WC_FastFinderDisplay_div_12">
							<span class="text" id="pagingMessageDisplayTop"></span>
							<span class="paging">
								<a href="javascript: setCurrentId('WC_FastFinderDisplay_link_1'); filterWithPrevIndex();" id="WC_FastFinderDisplay_link_1">
									<span id="fastFinderDisplayJS_TopLeftPaginationMarker"><img src="<c:out value="${jspStoreImgDir}${vfileColor}paging_back.png"/>" alt="<fmt:message key="FF_PAGING_BACK" bundle="${storeText}"/>" /></span>
									</a>
								<span class="text" id="pagingMessage2DisplayTop"></span>
								<a href="javascript: setCurrentId('WC_FastFinderDisplay_link_2'); filterWithNextIndex();" id="WC_FastFinderDisplay_link_2">
									<span id="fastFinderDisplayJS_TopRightPaginationMarker"><img src="<c:out value="${jspStoreImgDir}${vfileColor}paging_next.png"/>" alt="<fmt:message key="FF_VIEWDETAILS" bundle="${storeText}"/>" /></span>
								</a>
							</span>
						</div>
					</div>
					<div class="right_corner" id="WC_FastFinderDisplay_div_13"></div>
				</div>
				<div class="body588" id="WC_FastFinderDisplay_div_14">
					<div class="sorting_controls" id="WC_FastFinderDisplay_div_15">
						<div class="fastFinderSortDropDown" id="WC_FastFinderDisplay_div_4">
							<label for="orderBy1"><span class="sort text"><fmt:message key="FF_SORT_BY" bundle="${storeText}"/></span></label>
							<form name="SortResultForm" id="SortResultForm" method="post" action="">
								<select class="drop_down" name="orderBy1" id="orderBy1" onchange="javascript: filterWithOrderBy(this);" style="font-size: 8pt;width:75px;">
									<option value="OfferPricePrice" 
										<c:if test="${!empty WCParam.orderBy1 && WCParam.orderBy1 eq 'OfferPricePrice'}"> selected="selected" </c:if>>
										<fmt:message key="FF_SORT_BY_PRICE" bundle="${storeText}"/>
									</option>
									<option value="CatEntryMfname" <c:if test="${!empty WCParam.orderBy1 && WCParam.orderBy1 eq 'CatEntryMfname'}">	selected="selected"			</c:if>>
										<fmt:message key="FF_SORT_BY_BRANDS" bundle="${storeText}"/>
									</option>
								</select>
							</form>
						</div>
						<div class="views1" id="WC_FastFinderDisplay_div_3">
							<span class="views" id="viewsTR">
								<span id="viewTypeTD1">
									<img id="imageTypeImageSelected" src="<c:out value="${jspStoreImgDir}${vfileColor}grid_selected.png"/>" alt="<fmt:message key="FF_VIEWICONS" bundle="${storeText}"/>"/>
									<a id="detailedTypeLink" href="javascript: filterWithView('detailed');">
										<img src="<c:out value="${jspStoreImgDir}${vfileColor}list_normal.png"/>" id="detailedTypeImage" alt="<fmt:message key="FF_VIEWDETAILS" bundle="${storeText}"/>" />
									</a>
								</span>
								<span id="viewTypeTD2">
									<a id="imageTypeLink" href="javascript: filterWithView('image');">
										<img src="<c:out value="${jspStoreImgDir}${vfileColor}grid_normal.png"/>" id="imageTypeImage" alt="<fmt:message key="FF_VIEWICONS" bundle="${storeText}"/>"/>
									</a>
									<img id="detailedTypeImageSelected" src="<c:out value="${jspStoreImgDir}${vfileColor}list_selected.png"/>" alt="<fmt:message key="FF_VIEWDETAILS" bundle="${storeText}"/>"/>	
								</span>
							</span>
						</div>
					</div>
				</div>
				<div class="body588a" id="WC_FastFinderDisplay_div_6">
				<div class="divider_line" colspan="4" id="WC_FastFinderDisplay_div_6_1"></div> 
					<div id="fastFinderResults"></div>
					<br /><br />
				</div>
				<div class="body588" id="WC_FastFinderDisplay_div_11">
					<span class="display_text">
						<span id="pagingMessageDisplayBottom"></span>
						<span class="paging">
							<a href="javascript: setCurrentId('WC_FastFinderDisplay_link_3'); filterWithPrevIndex();" id="WC_FastFinderDisplay_link_3">
								<span id="fastFinderDisplayJS_BottomLeftPaginationMarker"><img src="<c:out value="${jspStoreImgDir}${vfileColor}paging_back.png"/>" alt="<fmt:message key="FF_PAGING_BACK" bundle="${storeText}"/>" /></span>
							</a>
							<span id="pagingMessage2DisplayBottom"></span>
							<a href="javascript: setCurrentId('WC_FastFinderDisplay_link_4'); filterWithNextIndex();" id="WC_FastFinderDisplay_link_4">
								<span id="fastFinderDisplayJS_BottomRightPaginationMarker"><img src="<c:out value="${jspStoreImgDir}${vfileColor}paging_next.png"/>" alt="<fmt:message key="FF_PAGING_NEXT" bundle="${storeText}"/>" /></span>
							</a>
						</span>
					</span>
				</div>

				<div class="footer" id="WC_FastFinderDisplay_div_7">
				  <div class="left_corner" id="WC_FastFinderDisplay_div_8"></div>
				  <div class="left" id="WC_FastFinderDisplay_div_9"></div>
				  <div class="right_corner" id="WC_FastFinderDisplay_div_10"></div>
				</div>
				<%@ include file="../../../Snippets/Catalog/CategoryDisplay/CategoryDisplayExt.jspf"%>
			</div>
		</div>
	</div>
	<%@ include file="../../../include/LayoutContainerBottom.jspf"%>
</div>
<div id="page_shadow" class="shadow"></div>

<flow:ifEnabled feature="Analytics"><cm:pageview/></flow:ifEnabled>
</body>
</html>
