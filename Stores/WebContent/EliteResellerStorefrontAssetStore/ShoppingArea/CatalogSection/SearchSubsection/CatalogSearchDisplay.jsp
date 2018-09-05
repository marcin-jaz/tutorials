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
  * This JSP file renders the catalog search page.
  *****
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf" %>
<%@ include file="../../../include/nocache.jspf" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ taglib uri="http://commerce.ibm.com/coremetrics"  prefix="cm" %>

<wcf:url value="AjaxCatalogSearchResultView" var="SimpleSearchResultDisplayViewURL" type="Ajax">
	<wcf:param name="pageView" value="${WCParam.pageView}"/>
	<wcf:param name="storeId" value="${WCParam.storeId}"/>
	<wcf:param name="langId" value="${langId}"/>
	<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
	<wcf:param name="searchTerm" value="${WCParam.searchTerm}"/>
	<wcf:param name="resultCatEntryType" value="${WCParam.resultCatEntryType}"/>
	<wcf:param name="pageSize" value="${WCParam.pageSize}"/>
	<wcf:param name="beginIndex" value="${WCParam.beginIndex}"/>
	<wcf:param name="sType" value="${WCParam.sType}"/>	
	<wcf:param name="searchType" value="${WCParam.searchType}"/>
	<wcf:param name="searchTermCaseSensitive" value="${WCParam.searchTermCaseSensitive}"/>
	<wcf:param name="searchTermOperator" value="${WCParam.searchTermOperator}"/>
	<wcf:param name="filterTerm" value="${WCParam.filterTerm}"/>
	<wcf:param name="filterType" value="${WCParam.filterType}"/>
	<wcf:param name="filterTermCaseSensitive" value="${WCParam.filterTermCaseSensitive}"/>
	<wcf:param name="filterTermOperator" value="${WCParam.filterTermOperator}"/>
	<wcf:param name="searchTermScope" value="${WCParam.searchTermScope}"/>
	<wcf:param name="catGroupId" value="${WCParam.catGroupId}"/>
	<wcf:param name="categoryType" value="${WCParam.categoryType}"/>
	<wcf:param name="qtyAvailable" value="${WCParam.qtyAvailable}"/>
	<wcf:param name="qtyAvailableOperator" value="${WCParam.qtyAvailableOperator}"/>
	<wcf:param name="qtyMeasure" value="${WCParam.qtyMeasure}"/>
	<wcf:param name="qtyMeasureCaseSensitive" value="${WCParam.qtyMeasureCaseSensitive}"/>
	<wcf:param name="qtyMeasureOperator" value="${WCParam.qtyMeasureOperator}"/>
	<wcf:param name="minPrice" value="${WCParam.minPrice}"/>
	<wcf:param name="maxPrice" value="${WCParam.maxPrice}"/>
	<wcf:param name="catgrpSchemaType" value="1"/>
	<wcf:param name="RASchemaType" value="1"/>
</wcf:url>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns:wairole="http://www.w3.org/2005/01/wai-rdf/GUIRoleTaxonomy#"
xmlns:waistate="http://www.w3.org/2005/07/aaa" lang="${shortLocale}" xml:lang="${shortLocale}">
<head>
	<!-- Mimic Internet Explorer 7 -->
	<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" >
	<title><fmt:message key="TITLE_SEARCH_RESULTS" bundle="${storeText}"/></title>
	<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${vfileStylesheet}"/>" type="text/css"/>
	<!--[if lte IE 6]>
	<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${vfileStylesheetie}"/>" type="text/css"/>
	<![endif]-->
	<script type="text/javascript" src="<c:out value="${dojoFile}"/>" djConfig="${dojoConfigParams}"></script>
	<%@ include file="../../../include/CommonJSToInclude.jspf"%>
	<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/MessageHelper.js"/>"></script>
	<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/Vector.js"/>"></script>
	<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/CatalogArea/CategoryDisplay.js"/>"></script>
	<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/CatalogArea/CatalogSearchDisplay.js"/>"></script>
	<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/ServicesDeclaration.js"/>"></script>
	<script type="text/javascript">
		dojo.addOnLoad(function() {
			<fmt:message key="ERR_RESOLVING_SKU" bundle="${storeText}" var="ERR_RESOLVING_SKU" />
			<fmt:message key="QUANTITY_INPUT_ERROR" bundle="${storeText}" var="QUANTITY_INPUT_ERROR" />
			<fmt:message key="WISHLIST_ADDED" bundle="${storeText}" var="WISHLIST_ADDED" />
			<fmt:message key="SHOPCART_ADDED" bundle="${storeText}" var="SHOPCART_ADDED" />
			<fmt:message key="ERROR_MESSAGE_TYPE" bundle="${storeText}" var="ERROR_MESSAGE_TYPE" />
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
			MessageHelper.setMessage("ERROR_CONTRACT_EXPIRED_GOTO_ORDER", <wcf:json object="${ERROR_CONTRACT_EXPIRED_GOTO_ORDER}"/>);
		
			//Set the global variables
			CatalogSearchDisplayJS.invalidPageNumMsg = "<fmt:message key="SEARCH_INVALID_PAGE_NUM" bundle="${storeText}"/>";
			<c:if test="${not empty WCParam.showResultsPage}">	
				CatalogSearchDisplayJS.showResultsPage = "<c:out value='${WCParam.showResultsPage}'/>";
			</c:if>    	  
			CatalogSearchDisplayJS.searchModeVisible = true;	
			CatalogSearchDisplayJS.setAdvanceSearch(false);
			var historyUrl = "<c:out value='${SimpleSearchResultDisplayViewURL}' escapeXml='false'/>";
			<c:choose>
				<c:when test ="${WCParam.sType=='SimpleSearch'}">
					CatalogSearchDisplayJS.initSearchHistory("AjaxCatalogSearchResultView", "Search_area", historyUrl);
				</c:when>
				<c:otherwise>
					CatalogSearchDisplayJS.initSearchHistory("AjaxCatalogSearchResultView", "Search_area", "advanced");
				</c:otherwise>
			</c:choose>
		});
		dojo.addOnLoad(function() { parseWidget("Search_Result_div"); });
		dojo.addOnLoad(function() { CatalogSearchDisplayJS.processURL(); });	
		dojo.addOnLoad(
			function() { 
				<c:if test="${WCParam.sType=='SimpleSearch'}">
					CatalogSearchDisplayJS.setResultSummaryMessage();
				</c:if>
			}
		);

		categoryDisplayJS.setCommonParameters('<c:out value='${WCParam.langId}'/>','<c:out value='${WCParam.storeId}'/>','<c:out value='${WCParam.catalogId}'/>','<c:out value='${userType}'/>');
		ServicesDeclarationJS.setCommonParameters('<c:out value='${WCParam.langId}'/>','<c:out value='${WCParam.storeId}'/>','<c:out value='${WCParam.catalogId}'/>');
	</script>

	<flow:ifEnabled feature="Analytics">
	<script language="JavaScript1.1" type="text/JavaScript" src="<c:out value="${coremetricsJSDir}v40/eluminate.js"/>"></script>
	<script language="JavaScript1.1" type="text/JavaScript" src="<c:out value="${coremetricsJSDir}cmdatatagutils.js"/>"></script>	
	<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/Analytics.js"/>"></script>
	<script type="text/javascript">
	  cmSetProduction();	
	  dojo.addOnLoad(function() {
			analyticsJS.storeId=<c:out value="${storeId}"/>;
			analyticsJS.catalogId=<c:out value="${catalogId}"/>
			analyticsJS.loadMiniShopCartHandler();
			analyticsJS.loadPagingHandler();
			analyticsJS.loadSearchResultHandler("catalogSearchResultDisplay_Controller","catalog_search_result_information", true, "Advanced_Search_Form_div");
		});

	</script>
	</flow:ifEnabled>

</head>  
<body> 
	<script type="text/javascript">
		<!-- Initializes the undo stack. This must be called from a <script>  block that lives inside the <body> tag to prevent bugs on IE. -->
		 dojo.require("dojo.back");
		 dojo.back.init();
	</script>
	<c:set var="searchPage" value="true" scope="request"/>
	<c:set var="hasBreadCrumbTrail" value="true" scope="request"/>
	<c:set var="useHomeRightSidebar" value="false" scope="request"/>
	<script type="text/javascript">
		wc.render.declareContext(
			"catalogSearchResultDisplay_Context",
			{searchResultsPageNum: "", searchResultsView: "", searchResultsURL: "searchForm" },
			"");
	</script>
	<script type="text/javascript">
		dojo.require("wc.render.common");
		wc.render.declareRefreshController({
			id: "catalogSearchResultDisplay_Controller",
			renderContext: wc.render.getContextById("catalogSearchResultDisplay_Context"),
			url: "",
			formId: ""

		,renderContextChangedHandler: function(message, widget) {
			var controller = this;
			var renderContext = this.renderContext;
				console.debug(controller.url);
				console.debug(renderContext.properties);    			
				widget.refresh(renderContext.properties);
		}

		,postRefreshHandler: function(widget) {
			var controller = this;
			var renderContext = this.renderContext;
			console.debug("in post refreshscript searchResultCallBack url is " + controller.renderContext.properties["searchResultsURL"]);
				CatalogSearchDisplayJS.searchResultCallback(controller.renderContext.properties["searchResultsURL"]);
				CatalogSearchDisplayJS.setResultSummaryMessage();
			}
		});
	</script>
	
	<%@ include file="../../../include/StoreCommonUtilities.jspf"%>
	<div id="page">
		<%@ include file="../../../include/LayoutContainerTop.jspf"%>
		<div id="content_wrapper_box">
			<%@ include file="../../../Snippets/ReusableObjects/CatalogEntryQuickInfoDetails.jspf" %>
		   	<div id="content588">
				<div id="MessageArea" >
					<br />
					<span id="ErrorMessageText" class="error_msg" tabindex="-1">
					</span>
					<br /><br />  
				</div>
				<div id ="Search_Advanced_Header" style ="display:none">
					<h1><fmt:message key="TITLE_ADVANCED_SEARCH" bundle="${storeText}"/></h1>
				</div>

				<div id="Search_Result_Summary" style="display:none">
					<br />
				</div>
			<div id="box">
				<div id="Search_Area_div">
					<div id="Search_Forms_div">
						<%@ include file="../../../ShoppingArea/CatalogSection/SearchSubsection/CatalogSearchForm.jspf"%>	</div>
					</div>
					<div dojoType="wc.widget.RefreshArea" widgetId="catalogSearchResultDisplay_Widget" controllerId="catalogSearchResultDisplay_Controller" class="MyAccountCenterLinkDisplay_Class" id="Search_Result_div" role="wairole:region" waistate:live="polite" waistate:atomic="true" waistate:relevant="all"> 
						<%out.flush();%>
							<c:import url="${jspStoreDir}ShoppingArea/CatalogSection/SearchSubsection/CatalogSearchResultDisplay.jsp">
								<c:param name="pageView" value="${WCParam.pageView}"/>
								<c:param name="storeId" value="${WCParam.storeId}"/>
								<c:param name="langId" value="${langId}"/>
								<c:param name="catalogId" value="${WCParam.catalogId}"/>
								<c:param name="searchTerm" value="${WCParam.searchTerm}"/>
								<c:param name="resultCatEntryType" value="${WCParam.resultCatEntryType}"/>
								<c:param name="pageSize" value="${WCParam.pageSize}"/>
								<c:param name="beginIndex" value="${WCParam.beginIndex}"/>
								<c:param name="sType" value="${WCParam.sType}"/>
							</c:import>
						<%out.flush();%>  
					</div>
				</div>
			</div>
		</div>
		<%@ include file="../../../include/LayoutContainerBottom.jspf"%>
	</div>
	<div id="page_shadow" class="shadow"></div>
</body>
</html>

<!-- End - JSP File Name:  CatalogSearchDisplay.jsp -->
