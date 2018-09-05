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
  * This JSP is called from HeaderDisplay.jsp and is cached based on the parameters passed in and defined in the cachespec.xml file.
  * The header includes the following information:
  *  - Common links, such as 'Shopping Cart', 'Contact Us', 'Help', etc  
  *  - Category selection list that displays all categories and subcategories in the store. 
  *  - Top Categories list
  *****
--%>
  
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../JSTLEnvironmentSetup.jspf"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<flow:fileRef id="vfileLogo" fileId="vfile.logo"/>


<wcf:url var="AjaxQuickCartDropDownDisplayURL" value="AjaxQuickCartDropDownDisplay" type="Ajax">
  <wcf:param name="langId" value="${param.langId}" />						
  <wcf:param name="storeId" value="${param.storeId}" />
  <wcf:param name="catalogId" value="${param.catalogId}" />
</wcf:url>
									
<script type="text/javascript">
	dojo.addOnLoad(function() {
		if('<c:out value='${headerLinksInTwoLines}'/>' == "true"){
			showHeaderLinksInTwoLines();
		}else{
			showLinksInOneLine();
		}
		parseWidget("outerCartContainer");	
	});
	
	var storeId = '<c:out value='${param.storeId}'/>';
	var langId = '<c:out value='${param.langId}'/>';
	var catalogId = '<c:out value='${param.catalogId}'/>';

	if('<c:out value='${topCategoryPage}'/>' == "true")
		var showProductCompare = false;
	else
		var showProductCompare = true;

	dojo.addOnLoad(initShopcartTarget);
	dojo.addOnLoad(showDropDownMenu);
	
</script>

<flow:ifEnabled feature="Analytics">
	<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/Analytics.js"/>"></script>
	<script type="text/javascript">
	dojo.addOnLoad(function() {
		analyticsJS.storeId=<c:out value="${storeId}"/>;
		analyticsJS.catalogId=<c:out value="${catalogId}"/>
		analyticsJS.loadMiniShopCartHandler();
		analyticsJS.loadPagingHandler();
		analyticsJS.loadProductQuickInfoHandler('productIdQuickInfo');
		dojo.require("wc.analytics.CoremetricsEventListener");
			(new wc.analytics.CoremetricsEventListener()).load();
			});
	</script>
</flow:ifEnabled>
<wcf:url var="CatalogSearchViewURL" value="AjaxCatalogSearchView">
  <wcf:param name="langId" value="${param.langId}"/>
  <wcf:param name="storeId" value="${param.storeId}"/>
  <wcf:param name="catalogId" value="${param.catalogId}"/>
  <wcf:param name="advanced" value="true"/>				
  <wcf:param name="pageView" value="${defaultPageView}"/>
  <wcf:param name="beginIndex" value="0"/>
</wcf:url>

<flow:ifDisabled feature="AjaxMyAccountPage">
	<wcf:url var="TrackOrderStatusURL" value="NonAjaxTrackOrderStatus">
		<wcf:param name="storeId"   value="${param.storeId}"  />
		<wcf:param name="catalogId" value="${param.catalogId}"/>
		<wcf:param name="langId" value="${param.langId}" />
	</wcf:url>
	<flow:ifEnabled feature="EnableQuotes">
		<wcf:url var="TrackQuoteStatusURL" value="NonAjaxTrackOrderStatus">
			<wcf:param name="storeId"   value="${param.storeId}"  />
			<wcf:param name="catalogId" value="${param.catalogId}"/>
			<wcf:param name="langId" value="${param.langId}" />
			<wcf:param name="isQuote" value="true" />
		</wcf:url>
	</flow:ifEnabled>
</flow:ifDisabled>

<flow:ifEnabled feature="AjaxMyAccountPage">
	<wcf:url var="OrderStatusURL" value="AjaxLogonForm">
	  <wcf:param name="langId" value="${param.langId}" />
	  <wcf:param name="storeId" value="${param.storeId}" />
	  <wcf:param name="catalogId" value="${param.catalogId}" />
	  <wcf:param name="page" value="orderstatus" />
	</wcf:url>							
	<flow:ifEnabled feature="EnableQuotes">
		<wcf:url var="QuoteStatusURL" value="AjaxLogonForm">
			<wcf:param name="langId" value="${param.langId}" />
			<wcf:param name="storeId" value="${param.storeId}" />
			<wcf:param name="catalogId" value="${param.catalogId}" />
			<wcf:param name="page" value="orderstatus" />
			<wcf:param name="isQuote" value="true" />
		</wcf:url>							
	</flow:ifEnabled>
</flow:ifEnabled>

<wcf:url var="LogonFormURL" value="LogonForm">
  <wcf:param name="langId" value="${param.langId}" />
  <wcf:param name="storeId" value="${param.storeId}" />
  <wcf:param name="catalogId" value="${param.catalogId}" />
  <wcf:param name="myAcctMain" value="1" />
</wcf:url>
<wcf:url var="SavedOrderListDisplayURL" value="ListOrdersDisplayView">
	<wcf:param name="storeId"   value="${param.storeId}"  />
	<wcf:param name="catalogId" value="${param.catalogId}"/>
	<wcf:param name="langId" value="${param.langId}" />  
</wcf:url>		
<wcf:url var="MyAccountURL" value="AjaxLogonForm">
  <wcf:param name="langId" value="${param.langId}" />
  <wcf:param name="storeId" value="${param.storeId}" />
  <wcf:param name="catalogId" value="${param.catalogId}" />
  <wcf:param name="myAcctMain" value="1" />
</wcf:url>
<wcf:url var="LogoffURL" value="Logoff">
  <wcf:param name="langId" value="${param.langId}" />
  <wcf:param name="storeId" value="${param.storeId}" />
  <wcf:param name="catalogId" value="${param.catalogId}" />
  <wcf:param name="myAcctMain" value="1" />
  <wcf:param name="URL" value="LogonForm" />
</wcf:url>                                          
<wcf:url var="TopCategoriesDisplayURL" value="TopCategories1">
  <wcf:param name="langId" value="${param.langId}" />
  <wcf:param name="storeId" value="${param.storeId}" />
  <wcf:param name="catalogId" value="${param.catalogId}" />
</wcf:url>

<wcf:url var="ShoppingCartURL" value="OrderCalculate" type="Ajax">
   <wcf:param name="langId" value="${param.langId}" />
  <wcf:param name="storeId" value="${param.storeId}" />
  <wcf:param name="catalogId" value="${param.catalogId}" />
  <wcf:param name="URL" value="AjaxOrderItemDisplayView" />
  <wcf:param name="errorViewName" value="AjaxOrderItemDisplayView" />
  <wcf:param name="updatePrices" value="1" />
  <wcf:param name="calculationUsageId" value="-1" />
  <wcf:param name="orderId" value="." />
</wcf:url>

<wcf:url var="QuickOrderURL" value="QuickOrderView">
  <wcf:param name="langId" value="${param.langId}" />
  <wcf:param name="storeId" value="${param.storeId}" />
  <wcf:param name="catalogId" value="${param.catalogId}" />
</wcf:url>

<wcf:url var="SiteMapURL" value="SiteMap">
	<wcf:param name="langId" value="${param.langId}" />
	<wcf:param name="storeId" value="${param.storeId}" />
	<wcf:param name="catalogId" value="${param.catalogId}" />
</wcf:url>

<div id="header">
		<div id="header_logo">
		<%-- 
		***
		*  Start: Custom Banner and Logo
		***
		--%>                      
			<%-- Height and store name removal is to adapt new style --%>
			
			<flow:ifEnabled feature="CustomLogo">
				<a href="<c:out value="${TopCategoriesDisplayURL}"/>" id="WC_CachedHeaderDisplay_Link_1"><img src="<c:out value="${storeImgDir}${vfileLogo}" />" alt="<c:out value="${storeName}" />" border="0"/></a>
			</flow:ifEnabled>
			<flow:ifDisabled feature="CustomLogo">
			  <a href="<c:out value="${TopCategoriesDisplayURL}"/>" id="WC_CachedHeaderDisplay_Link_2"><img src="<c:out value="${jspStoreImgDir}${vfileLogo}" />" alt="<c:out value="${storeName}" />" border="0"/></a>
			</flow:ifDisabled>
			
			<c:if test="${!empty showOrgLogoName && showOrgLogoName==true}">
				<wcbase:useBean id="currentOrg" classname="com.ibm.commerce.user.beans.OrganizationDataBean">
					<c:set property="dataBeanKeyMemberId" value="${CommandContext.activeOrganizationId}" target="${currentOrg}" />
				</wcbase:useBean>
				<c:if test="${!empty currentOrg.organizationName}">
					<span class="header_organization_name" id="WC_CachedHeaderDisplay_OrganizationName">
						<c:out value="${currentOrg.organizationName}"/>
					</span>
				</c:if>
			</c:if>
		<%-- 
		***
		*  End: Custom Banner and Logo
		***
		--%>
		</div>
		<c:if test="${headerLinksInTwoLines==true}">
			<div id='header_links1'>
				<a href="<c:out value="${TopCategoriesDisplayURL}"/>" id="headerHome1" ><fmt:message key="HEADER_HOME" bundle="${storeText}" /></a>
				<fmt:message key="DIVIDING_BAR" bundle="${storeText}" />
				<a href="<c:out value="${ShoppingCartURL}"/>" class="h_tnav_but" id="headerShopCart1"><fmt:message key="HEADER_SHOPPING_CART" bundle="${storeText}" /></a>
			</div>
		</c:if>
		<flow:ifEnabled feature="search">
		  <form name="CatalogSearchForm" action="AjaxCatalogSearchView" method="get" id="CatalogSearchForm">
			  <input type="hidden" name="storeId" value='<c:out value="${param.storeId}" />' id="WC_CachedHeaderDisplay_FormInput_storeId_In_CatalogSearchForm_1"/>
				<input type="hidden" name="catalogId" value='<c:out value="${param.catalogId}"/>' id="WC_CachedHeaderDisplay_FormInput_catalogId_In_CatalogSearchForm_1"/>
				<input type="hidden" name="langId" value='<c:out value="${param.langId}"/>' id="WC_CachedHeaderDisplay_FormInput_langId_In_CatalogSearchForm_1"/>
				<input type="hidden" name="pageSize" value="12" id="WC_CachedHeaderDisplay_FormInput_pageSize_In_CatalogSearchForm_1"/>
				<input type="hidden" name="beginIndex" value="0" id="WC_CachedHeaderDisplay_FormInput_beginIndex_In_CatalogSearchForm_1"/>
				<input type="hidden" name="sType" value="SimpleSearch" id="WC_CachedHeaderDisplay_FormInput_sType_In_CatalogSearchForm_1"/>
				<input type="hidden" name="resultCatEntryType" value="2" id="WC_CachedHeaderDisplay_FormInput_resultType_In_CatalogSearchForm_1"/>
				<input type="hidden" name="showResultsPage" value="true" id="WC_CachedHeaderDisplay_input_1"/>
				<input type="hidden" name="pageView" value="<c:out value="${defaultPageView}"/>" id="WC_CachedHeaderDisplay_input_2"/>
				
				<label for="SimpleSearchForm_SearchTerm" class="nodisplay"><fmt:message key="SEARCH_CATALOG" bundle="${storeText}" /></label>
				<c:choose>
					<c:when test="${empty WCParam.searchTerm}">
						<fmt:message key="SEARCH_CATALOG" bundle="${storeText}" var="searchText"/>
					</c:when>
					<c:otherwise>
						<c:set var="searchText" value="${WCParam.searchTerm}" />
					</c:otherwise>
				</c:choose>
				<div id="header-search">
					<span id="searchTextHolder" class="nodisplay"><fmt:message key="SEARCH_CATALOG" bundle="${storeText}" /></span>
					<input type="text" size="18" class="search-txt" name="searchTerm" id="SimpleSearchForm_SearchTerm" value="<c:out value='${searchText}' />" onfocus="JavaScript:clearSearchField();" onblur="JavaScript:fillSearchField();" onkeypress='if(event.keyCode==13) javascript:this.value=trim(this.value);'/>
					<button name="searchBtn" id="WC_CachedHeaderDisplay_button_1" type="button" value="<fmt:message key="SEARCH_CATALOG" bundle="${storeText}" />" class="search-btn" onclick="JavaScript:document.CatalogSearchForm.searchTerm.value=trim(document.CatalogSearchForm.searchTerm.value);document.CatalogSearchForm.action=getAbsoluteURL()+'AjaxCatalogSearchView'; submitSpecifiedForm(document.CatalogSearchForm);" onmouseover="this.style.background = 'url(\'<c:out value="${hostPath}"/><c:out value="${jspStoreImgDir}${vfileColor}" />search-btn-h.png\')'" onmouseout="this.style.background = 'url(\'<c:out value="${hostPath}"/><c:out value="${jspStoreImgDir}${vfileColor}" />search-btn.png\')'" onmousedown="this.style.background = 'url(\'<c:out value="${hostPath}"/><c:out value="${jspStoreImgDir}${vfileColor}" />search-btn-d.png\')'" onmouseup="this.style.background = 'url(\'<c:out value="${hostPath}"/><c:out value="${jspStoreImgDir}${vfileColor}" />search-btn.png\')'"></button>
				</div>

			</form>
		</flow:ifEnabled>
	
	 <div id="header_links">
	   <span id="headerHomeLink">
		<a href="<c:out value="${TopCategoriesDisplayURL}"/>" id="headerHome" ><fmt:message key="HEADER_HOME" bundle="${storeText}" /></a>
		<fmt:message key="DIVIDING_BAR" bundle="${storeText}" />
	   </span>
	   <span id="headerShopCartLink">
		<a href="<c:out value="${ShoppingCartURL}"/>" class="h_tnav_but" id="headerShopCart"><fmt:message key="HEADER_SHOPPING_CART" bundle="${storeText}" /></a>
	    <fmt:message key="DIVIDING_BAR" bundle="${storeText}" />
	   </span>	
	  <flow:ifEnabled feature="QuickOrder">
		<a href="<c:out value="${QuickOrderURL}"/>" class="h_tnav_but" id="headerQuickOrder"><fmt:message key="HEADER_QUICK_ORDER" bundle="${storeText}" /></a>
	  <fmt:message key="DIVIDING_BAR" bundle="${storeText}" />
	  </flow:ifEnabled>
	  
	  <c:if test="${userType != 'G'}">
	  <flow:ifEnabled feature="MultipleActiveOrders">
			<a href="<c:out value="${SavedOrderListDisplayURL}"/>" class="h_tnav_but" id="WC_CachedHeaderDisplay_Link_Saved_Orders"><fmt:message key="FOOTER_SAVED_ORDERS" bundle="${storeText}" /></a>
	  		<fmt:message key="DIVIDING_BAR" bundle="${storeText}" />
	  </flow:ifEnabled>
	  <a href="<c:out value="${MyAccountURL}"/>" class="h_tnav_but" id="headerMyAccount"><fmt:message key="HEADER_MY_ACCOUNT" bundle="${storeText}" /></a>
		<fmt:message key="DIVIDING_BAR" bundle="${storeText}" />
		<flow:ifEnabled feature="TrackingStatus">
			<flow:ifEnabled feature="AjaxMyAccountPage">
				<a href="<c:out value="${OrderStatusURL}"/>" class="h_tnav_but" id="WC_CachedHeaderDisplay_Link_3"><fmt:message key="HEADER_ORDER_STATUS" bundle="${storeText}" /></a>
			</flow:ifEnabled>
			<flow:ifDisabled feature="AjaxMyAccountPage">
				<a href="<c:out value="${TrackOrderStatusURL}"/>" class="h_tnav_but" id="WC_CachedHeaderDisplay_Link_4"><fmt:message key="HEADER_ORDER_STATUS" bundle="${storeText}" /></a>
			</flow:ifDisabled>
			<fmt:message key="DIVIDING_BAR" bundle="${storeText}" />

			<flow:ifEnabled feature="EnableQuotes">
				<flow:ifEnabled feature="AjaxMyAccountPage">
					<a href="<c:out value="${QuoteStatusURL}"/>" class="h_tnav_but" id="WC_CachedHeaderDisplay_Link_5"><fmt:message key="HEADER_QUOTE_STATUS" bundle="${storeText}" /></a>
				</flow:ifEnabled>
				<flow:ifDisabled feature="AjaxMyAccountPage">
					<a href="<c:out value="${TrackQuoteStatusURL}"/>" class="h_tnav_but" id="WC_CachedHeaderDisplay_Link_6"><fmt:message key="HEADER_QUOTE_STATUS" bundle="${storeText}" /></a>
				</flow:ifDisabled>
				<fmt:message key="DIVIDING_BAR" bundle="${storeText}" />
			</flow:ifEnabled>			
		</flow:ifEnabled>
	  </c:if>
	  <flow:ifEnabled feature="search">
	   <a href="<c:out value="${CatalogSearchViewURL}"/>" class="h_tnav_but" id="headerAdvancedSearch" ><fmt:message key="HEADER_ADVANCED_SEARCH" bundle="${storeText}" /></a>
	  <fmt:message key="DIVIDING_BAR" bundle="${storeText}" />
	  </flow:ifEnabled>
	  <flow:ifEnabled feature="StoreLocator">
			<wcf:url var="StoreLocatorView" value="AjaxStoreLocatorDisplayView">
			  <wcf:param name="langId" value="${param.langId}" />
			  <wcf:param name="storeId" value="${param.storeId}" />
			  <wcf:param name="catalogId" value="${param.catalogId}" />
			</wcf:url>
	
			<a href="<c:out value="${StoreLocatorView}"/>" class="h_tnav_but" id="WC_CachedHeaderDisplay_Link_4a"><fmt:message key="HEADER_STORE_LOCATOR" bundle="${storeText}" /></a>
			<fmt:message key="DIVIDING_BAR" bundle="${storeText}" />
		</flow:ifEnabled>
		
	  <c:choose>
		<c:when test="${userType != 'G'}">
			<a href="<c:out value="${LogoffURL}"/>" class="h_tnav_but" id="headerLogout"><fmt:message key="HEADER_LOGOUT" bundle="${storeText}" /></a>
		</c:when>
		<c:otherwise>
		<a href="<c:out value="${LogonFormURL}"/>" class="h_tnav_but" id="headerLogin"><fmt:message key="HEADER_LOGIN" bundle="${storeText}" /></a>
		</c:otherwise>
	  </c:choose>
	</div>
</div>

<%-- if a generic error occurs, CatalogDataBean cannot retrieve catalogId from WCParam. CatalogDataBean will throw an exception in this case.
 To get around that, we'll pass in a catalogId explicitly. --%>
 <c:set var="catalogId" value="${param.catalogId}"/>
 <c:if test="${empty catalogID}">
 	<c:set var="catalogId" value="${param.catalogId}"/> <%-- from HeaderDisplay.jspf --%>
 </c:if>
<wcbase:useBean id="catalog" classname="com.ibm.commerce.catalog.beans.CatalogDataBean" scope="request">
	<c:set value="${catalogId}" target="${catalog}" property="catalogId"/>	
</wcbase:useBean>


<div id="header_nav">

	<c:set var="numTopCat" value="${fn:length(catalog.topCategories)}"/>
			
			<div id="header_menu_dropdown" style="display:none;">
			
				<div id="header_menu_overlay">
				<c:set var="noTopCategoryDisplay" value="true"/>
				<c:forEach var="topCategory" items="${catalog.topCategories}" varStatus="status">
					<c:set var="noTopCategoryDisplay" value="false"/>
					<c:if test="${status.count <= maxTopCategoriesInHeader}">
					
					<div id="CachedHeaderDisplayMenuOverlayItem_<c:out value='${status.count}'/>" tabindex="0" onfocus="parseHeader('CachedHeaderDisplayMenuOverlayItem_<c:out value='${status.count}'/>'); if (document.getElementById('HeaderMenu_DropDown_1') != null && document.getElementById('HeaderMenu_DropDown_1') != 'undefined') { document.getElementById('HeaderMenu_DropDown_1').focus();}" onmouseover="parseHeader('CachedHeaderDisplayMenuOverlayItem_<c:out value='${status.count}'/>')" class="dijit dijitLeft dijitInline dijitDropDownButton dijitDropDownButtonFocused"
					><div class='dijitRight'>
					<div class="dijitStretch dijitButtonNode dijitButtonContents" type=""
						 waiRole="button" waiState="haspopup-true,labelledby-CachedHeaderDisplayMenuOverlay_1_<c:out value='${status.count}'/>_label"
							><div class="dijitInline"></div
						><span class="dijitButtonText" 
						id="CachedHeaderDisplayMenuOverlay_1_<c:out value='${status.count}'/>_label"><c:out value="${topCategory.description.name}" escapeXml="false"/></span
						><span class='dijitA11yDownArrow'></span>
					</div>
				</div></div>
					
					</c:if>
				</c:forEach>
				
				
				<c:if test="${numTopCat > maxTopCategoriesInHeader}">
					<div onmouseover="parseHeader()" class="dijit dijitLeft dijitInline dijitDropDownButton dijitDropDownButtonFocused"
					><div class='dijitRight'>
					<div class="dijitStretch dijitButtonNode dijitButtonContents" type=""
						 waiRole="button" waiState="haspopup-true,labelledby-CachedHeaderDisplay_1_SeeAll_label"
							><div class="dijitInline"></div
						><span class="dijitButtonText" 
						id="CachedHeaderDisplay_1_SeeAll_label"><fmt:message key="SEE_ALL" bundle="${storeText}"/></span
						><span class='dijitA11yDownArrow'></span>
					</div>
				</div></div>
				</c:if>	
			</div>
			
			
			
			<div id="header_menu_loaded" style="display:none;">
			
				
				<c:forEach var="topCategory" items="${catalog.topCategories}" varStatus="status">
				
				<c:if test="${status.count <= maxTopCategoriesInHeader}">
							<wcf:url var="CategoryDisplayURL" value="Category3">
								<wcf:param name="langId" value="${param.langId}" />
								<wcf:param name="storeId" value="${param.storeId}" />
								<wcf:param name="catalogId" value="${param.catalogId}" />
								<wcf:param name="top" value="Y" />
								<wcf:param name="categoryId" value="${topCategory.categoryId}" />
								<wcf:param name="pageView" value="${defaultPageView}" />
								<wcf:param name="beginIndex" value="0" />
							</wcf:url>
							
							<fmt:message key="DROPDOWN_ACTIVATE" bundle="${storeText}" var="categoryTitle">
							<fmt:param value="${topCategory.description.name}"/>
							</fmt:message>

							<div dojoType="wc.widget.WCDropDownButton" url="<c:out value='${CategoryDisplayURL}'/>" title="<c:out value='${categoryTitle}'/>" id="HeaderMenu_DropDown_<c:out value='${status.count}'/>">
							<span><c:out value="${topCategory.description.name}" escapeXml="false"/></span>
							
							<%-- 
							*** 
							*  Start: DropDownMenu Content
							***
							--%>		
							<div dojoType="wc.widget.WCMenu" maxItemsPerColumn="${maxItemsPerColumn}" forceDisplayShowAll="${forceDisplayShowAll}" showAllURL="<c:out value='${CategoryDisplayURL}'/>" showAllText="<fmt:message key="SHOW_ALL_TEXT" bundle="${storeText}" /> ${topCategory.description.name}" class ="dropdown" id="WC_CachedHeaderDisplay_div_3_<c:out value='${status.count}'/>">
												<c:forEach var="subTopCategory" items="${topCategory.subCategories}" varStatus="status2">
													<wcf:url var="subTopCategoryDisplayUrl" value="Category4">
														<wcf:param name="catalogId" value="${param.catalogId}" />
														<wcf:param name="storeId" value="${param.storeId}" />
														<wcf:param name="categoryId" value="${subTopCategory.categoryId}" />
														<wcf:param name="langId" value="${param.langId}" />
														<wcf:param name="parent_category_rn" value="${topCategory.categoryId}" />
														<wcf:param name="top_category" value="${topCategory.categoryId}" />
														<wcf:param name="pageView" value="${defaultPageView}" />
														<wcf:param name="beginIndex" value="0"/>
													</wcf:url>
													<div dojoType="dijit.MenuItem" onClick="loadLink('<c:out value='${subTopCategoryDisplayUrl}'/>');" id="WC_CachedHeaderDisplay_div_4_<c:out value='${status.count}'/>_<c:out value='${status2.count}'/>">
														<span><a href='<c:out value="${subTopCategoryDisplayUrl}"/>' id="WC_CachedHeaderDisplay_links_1_<c:out value='${status.count}'/>_<c:out value='${status2.count}'/>"><c:out value="${subTopCategory.description.name}" escapeXml="false"/></a></span>
													</div> 
												</c:forEach>
										</div>
									</div>	
							 <%-- 
								***
								*  End: DropDownMenu Content
								***
							  --%>
							  </c:if>
				</c:forEach>
				<%--See All --%>
				<fmt:message key="SEE_ALL_DROPDOWN" bundle="${storeText}" var="topcatTitle"/>
				<c:if test="${numTopCat > maxTopCategoriesInHeader}">
						<div dojoType="wc.widget.WCDropDownButton" title="<c:out value='${topcatTitle}'/>" url="<c:out value='${SiteMapURL}'/>" id="WC_CachedHeaderDisplay_div_5_SeeAllDropDown">
							<span><fmt:message key="SEE_ALL" bundle="${storeText}"/></span>
								
									<div dojoType="wc.widget.WCMenu" widgetsInTemplate="true" maxSize="6" showAllText="<fmt:message key="SEE_ALL_DROPDOWN" bundle="${storeText}" />" showAllURL="<c:out value='${SiteMapURL}'/>" class="dropdown" id="WC_CachedHeaderDisplay_div_6_SeeAllMenu">
												<c:forEach var="topCat" items="${catalog.topCategories}" varStatus="status2">
												<%-- variables come from HeaderDisplay.jspf --%>
												<wcf:url var="CategoryDisplayURL" value="Category3">
													<wcf:param name="langId" value="${param.langId}" />
													<wcf:param name="storeId" value="${param.storeId}" />
													<wcf:param name="catalogId" value="${param.catalogId}" />
													<wcf:param name="top" value="Y" />
													<wcf:param name="categoryId" value="${topCat.categoryId}" />
													<wcf:param name="pageView" value="${defaultPageView}" />
													<wcf:param name="beginIndex" value="0" />
												</wcf:url>												
													<div dojoType="dijit.MenuItem" onClick="loadLink('<c:out value='${CategoryDisplayURL}'/>');" id="WC_CachedHeaderDisplay_div_7_SeeAll_<c:out value='${status2.count}'/>">
														<span><a href='<c:out value="${CategoryDisplayURL}"/>' id="WC_CachedHeaderDisplay_links_2_SeeAll_<c:out value='${status2.count}'/>"><c:out value="${topCat.description.name}" escapeXml="false"/></a></span>
													</div> 
												</c:forEach>
										</div>
									</div>	
				</c:if>
			</div>
		</div>
			<flow:ifEnabled feature="miniShopCart">
			<div id="outerCartContainer" <c:if test="${noTopCategoryDisplay == 'true'}">class="top_category_no_display"</c:if>>
				<div dojoType="dojo.dnd.Target" jsId="miniShopCart_dndTarget" id="miniShopCart_dndTarget" accept="item, product, package, bundle" >
					<div id="shopping-cart">
						<div id="shopcartContainer">
						<div dojoType="wc.widget.RefreshArea" id="MiniShoppingCart" widgetId="MiniShoppingCart" controllerId="MiniShoppingCartController" onmouseover="showMiniShopCartDropDown('placeHolder','quick_cart_container','orderItemsList');" role="wairole:region" waistate:live="polite" waistate:atomic="true" waistate:relevant="all">
								<%out.flush();%>
									<c:import url="${jspStoreDir}include/MiniShopCartDisplay.jsp">
									 <%-- variables come from HeaderDisplay.jspf --%>
									  <c:param name="storeId" value="${param.storeId}"/>
										<c:param name="catalogId" value="${param.catalogId}"/>
										<c:param name="langId" value="${param.langId}"/>
									</c:import>
								<%out.flush();%>
							</div>
						 </div>
					</div> 
				</div>
			 </div>
			</flow:ifEnabled>			
</div>



	
		
	
	


			
