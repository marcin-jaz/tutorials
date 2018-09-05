<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2009 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>

<%-- 
  *****
  * This page is a JSP fragment that will display the Bread Crumb Trail during the catalog borwsing
  *****
--%>

<!-- JSP File Name:  BreadCrumbTrailDisplay.jsp -->

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ taglib uri="flow.tld" prefix="flow" %>

<%@ include file="JSTLEnvironmentSetup.jspf"%>

			<c:set var="categoryPage" value=""/>
			<c:set var="productPage" value=""/>
			<c:set var="topCategoryPage" value=""/>
			<c:set var="compareProductPage" value=""/>
			<c:set var="extensionPageWithBCF" value=""/>
			<c:set var="finalBreadcrumb" value=""/>
			<c:set var="top_category" value=""/>
			<c:set var="categoryId" value=""/>
			<c:set var="parent_category_rn" value=""/>
			<c:set var="identifier" value=""/>
			<c:set var="top" value=""/>
			<c:set var="productId" value=""/>
			<c:set var="shoppingCartPage" value=""/>
			<c:set var="pendingOrderDetailsPage" value=""/>
			<c:set var="requestURIPath" value=""/>
			<c:set var="SavedOrderListPage" value="false"/>

			<c:if test="${!empty param.categoryPage}">
				<c:set var="categoryPage" value="${param.categoryPage}"/>
			</c:if>
			
			<c:if test="${!empty param.productPage}">
				<c:set var="productPage" value="${param.productPage}"/>
			</c:if>
			
			<c:if test="${!empty param.topCategoryPage}">
				<c:set var="topCategoryPage" value="${param.topCategoryPage}"/>
			</c:if>
			
			<c:if test="${!empty param.compareProductPage}">
				<c:set var="compareProductPage" value="${param.compareProductPage}"/>
			</c:if>
			
			<c:if test="${!empty param.extensionPageWithBCF}">
				<c:set var="extensionPageWithBCF" value="${param.extensionPageWithBCF}"/>
			</c:if>
			
			<c:if test="${!empty param.finalBreadcrumb}">
				<c:set var="finalBreadcrumb" value="${param.finalBreadcrumb}"/>
			</c:if>
			
			<c:if test="${!empty param.top_category}">
				<c:set var="top_category" value="${param.top_category}"/>
			</c:if>
			<c:if test="${!empty WCParam.top_category}">
				<c:set var="top_category" value="${WCParam.top_category}"/>
			</c:if>
			<c:if test="${!empty param.categoryId}">
				<c:set var="categoryId" value="${param.categoryId}"/>
			</c:if>
			<c:if test="${!empty WCParam.categoryId}">
				<c:set var="categoryId" value="${WCParam.categoryId}"/>
			</c:if>
			<c:if test="${!empty param.parent_category_rn}">
				<c:set var="parent_category_rn" value="${param.parent_category_rn}"/>
			</c:if>
			<c:if test="${!empty WCParam.parent_category_rn}">
				<c:set var="parent_category_rn" value="${WCParam.parent_category_rn}"/>
			</c:if>
			<c:if test="${!empty param.identifier}">
				<c:set var="identifier" value="${param.identifier}"/>
			</c:if>
			<c:if test="${!empty WCParam.identifier}">
				<c:set var="identifier" value="${WCParam.identifier}"/>
			</c:if>
			<c:if test="${!empty param.top}">
				<c:set var="top" value="${param.top}"/>
			</c:if>
			<c:if test="${!empty WCParam.top}">
				<c:set var="top" value="${WCParam.top}"/>
			</c:if>
			<c:if test="${!empty param.productId}">
				<c:set var="productId" value="${param.productId}"/>
			</c:if>
			<c:if test="${!empty WCParam.productId}">
				<c:set var="productId" value="${WCParam.productId}"/>
			</c:if>
			
			<c:if test="${!empty param.shoppingCartPage}">
				<c:set var="shoppingCartPage" value="${param.shoppingCartPage}"/>
			</c:if>
			
			<c:if test="${!empty param.pendingOrderDetailsPage}">
				<c:set var="pendingOrderDetailsPage" value="${param.pendingOrderDetailsPage}"/>
			</c:if>
			
			<c:if test="${!empty param.pendingOrderDetailsPage}">
				<c:set var="pendingOrderDetailsPage" value="${param.pendingOrderDetailsPage}"/>
			</c:if>
			<c:if test="${!empty param.requestURIPath}">
				<c:set var="requestURIPath" value="${param.requestURIPath}"/>
			</c:if>
			
			<c:if test="${!empty param.SavedOrderListPage}">
				<c:set var="SavedOrderListPage" value="${param.SavedOrderListPage}"/>
			</c:if>			
<c:choose>
	<c:when test="${param.hasBreadCrumbTrail}">		



<wcf:url var="TopCategoriesDisplayURL" value="TopCategories1">
  <wcf:param name="langId" value="${langId}" />
  <wcf:param name="storeId" value="${WCParam.storeId}" />
  <wcf:param name="catalogId" value="${WCParam.catalogId}" />
</wcf:url>

 <div id="breadcrumb">
	<c:if test="${categoryPage || productPage || topCategoryPage || compareProductPage || extensionPageWithBCF}">
	<div class="breadcrumb_links" id="WC_BreadCrumbTrailDisplay_div_1">
		<c:choose>
			<c:when test="${topCategoryPage}">
				<c:choose>
					<c:when test="${empty finalBreadcrumb}">
						<span class="breadcrumb_current"><fmt:message key="BCT_HOME" bundle="${storeText}" /></span>
					</c:when>
					<c:otherwise>
						<a href="<c:out value='${TopCategoriesDisplayURL}'/>" id="WC_BreadCrumbTrailDisplay_link_1"><fmt:message key="BCT_HOME" bundle="${storeText}" /></a>
					</c:otherwise>
				</c:choose>
			</c:when>
			<c:otherwise>

				<a href="<c:out value='${TopCategoriesDisplayURL}'/>" id="WC_BreadCrumbTrailDisplay_link_2"><fmt:message key="BCT_HOME" bundle="${storeText}" /></a>
				
							<c:if test="${!empty top_category}">
								<wcbase:useBean id="bctTopCategory" classname="com.ibm.commerce.catalog.beans.CategoryDataBean">
									<c:set target="${bctTopCategory}" property="categoryId" value="${top_category}" />
								</wcbase:useBean>
								
								<wcf:url var="CategoryDisplayURL" value="Category3">
									<wcf:param name="langId" value="${langId}" />
									<wcf:param name="storeId" value="${WCParam.storeId}" />
									<wcf:param name="catalogId" value="${WCParam.catalogId}" />
									<wcf:param name="top" value="Y" />
									<wcf:param name="categoryId" value="${bctTopCategory.categoryId}" />
									<wcf:param name="pageView" value="${defaultPageView}" />
									<wcf:param name="beginIndex" value="0" />
								</wcf:url>
								
								<fmt:message key="DIVIDING_BAR" bundle="${storeText}" />
								<c:choose>
									<c:when test="${top_category == categoryId && categoryPage}">
										<span class="breadcrumb_current"><c:out value="${bctTopCategory.description.name}" escapeXml="false"/></span>
									</c:when>
									<c:otherwise>
										<a href="<c:out value='${CategoryDisplayURL}'/>" id="WC_BreadCrumbTrailDisplay_link_3"><c:out value="${bctTopCategory.description.name}" escapeXml="false"/></a>
									</c:otherwise>
								</c:choose>
							</c:if>
							<c:if test="${!empty parent_category_rn && parent_category_rn != top_category}">
								<wcbase:useBean id="bctParentCategory" classname="com.ibm.commerce.catalog.beans.CategoryDataBean">
									<c:set target="${bctParentCategory}" property="categoryId" value="${parent_category_rn}" />
								</wcbase:useBean>
								
								<wcf:url var="ParentCategoryDisplayURL" value="Category1">
									<wcf:param name="langId" value="${langId}" />
									<wcf:param name="storeId" value="${WCParam.storeId}" />
									<wcf:param name="catalogId" value="${WCParam.catalogId}" />
									<wcf:param name="categoryId" value="${bctParentCategory.categoryId}" />
									<wcf:param name="parent_category_rn" value="${top_category}" />
									<wcf:param name="top_category" value="${top_category}" />
									<wcf:param name="pageView" value="${defaultPageView}" />
									<wcf:param name="beginIndex" value="0" />
								</wcf:url>
								
								<fmt:message key="DIVIDING_BAR" bundle="${storeText}" />
								<c:choose>
									<c:when test="${parent_category_rn == categoryId && categoryPage}">
										<span class="breadcrumb_current"><c:out value="${bctParentCategory.description.name}" escapeXml="false"/></span>
									</c:when>
									<c:otherwise>
										<a href="<c:out value='${ParentCategoryDisplayURL}'/>" id="WC_BreadCrumbTrailDisplay_link_4"><c:out value="${bctParentCategory.description.name}" escapeXml="false"/></a>
									</c:otherwise>
								</c:choose>
							</c:if>
							<c:if test="${!empty categoryId || (categoryPage && !empty identifier)}">
								<c:if test="${categoryId != top_category && categoryId != parent_category_rn}">
									<wcbase:useBean id="bctCategory" classname="com.ibm.commerce.catalog.beans.CategoryDataBean"/>
									<fmt:message key="DIVIDING_BAR" bundle="${storeText}" />
									
									<c:choose>
										<c:when test="${(categoryPage && empty parent_category_rn) || (categoryPage && parent_category_rn == categoryId) || (categoryPage && !empty identifier)}">
											<c:choose>
												<c:when test="${!empty finalBreadcrumb}">
													<wcf:url var="SubCategoryDisplayURL" value="Category3">
														<wcf:param name="langId" value="${langId}" />
														<wcf:param name="storeId" value="${WCParam.storeId}" />
														<wcf:param name="catalogId" value="${WCParam.catalogId}" />
														<wcf:param name="top" value="Y" />
														<wcf:param name="categoryId" value="${bctCategory.categoryId}" />
														<wcf:param name="pageView" value="${defaultPageView}" />
														<wcf:param name="beginIndex" value="0" />
													</wcf:url>
													<a href="<c:out value='${SubCategoryDisplayURL}'/>" id="WC_BreadCrumbTrailDisplay_link_5a"><c:out value="${bctCategory.description.name}" escapeXml="false"/></a>
												</c:when>
												<c:otherwise>
													<span class="breadcrumb_current"><c:out value="${bctCategory.description.name}" escapeXml="false"/></span>
												</c:otherwise>
											</c:choose>
										</c:when>
										<c:when test="${categoryPage && !empty parent_category_rn && !empty top_category && parent_category_rn == top_category}">
											<span class="breadcrumb_current"><c:out value="${bctCategory.description.name}" escapeXml="false"/></span>
										</c:when>
										<c:otherwise>
											<c:choose>
												<c:when test="${top == 'Y'}">
													<wcf:url var="SubCategoryDisplayURL" value="Category3">
														<wcf:param name="langId" value="${langId}" />
														<wcf:param name="storeId" value="${WCParam.storeId}" />
														<wcf:param name="catalogId" value="${WCParam.catalogId}" />
														<wcf:param name="top" value="Y" />
														<wcf:param name="categoryId" value="${bctCategory.categoryId}" />
														<wcf:param name="pageView" value="${defaultPageView}" />
														<wcf:param name="beginIndex" value="0" />
													</wcf:url>
												</c:when>
												<c:otherwise>
													<wcf:url var="SubCategoryDisplayURL" value="Category1">
														<wcf:param name="langId" value="${langId}" />
														<wcf:param name="storeId" value="${WCParam.storeId}" />
														<wcf:param name="catalogId" value="${WCParam.catalogId}" />
														<wcf:param name="categoryId" value="${bctCategory.categoryId}" />
														<wcf:param name="parent_category_rn" value="${parent_category_rn}" />
														<wcf:param name="top_category" value="${top_category}" />
														<wcf:param name="pageView" value="${defaultPageView}" />
														<wcf:param name="beginIndex" value="0" />
													</wcf:url>
												</c:otherwise>
											</c:choose>
											<c:choose>
												<c:when test="${bctCategory.categoryId == categoryId && categoryPage}">
													<span class="breadcrumb_current"><c:out value="${bctCategory.description.name}" escapeXml="false"/></span>
												</c:when>
												<c:otherwise>
													<a href="<c:out value='${SubCategoryDisplayURL}'/>" id="WC_BreadCrumbTrailDisplay_link_5"><c:out value="${bctCategory.description.name}" escapeXml="false"/></a>
												</c:otherwise>
											</c:choose>
										</c:otherwise>
									</c:choose>
								</c:if>
							</c:if>
							
						<c:if test="${!empty productId || (productPage && !empty identifier)}">
							<wcbase:useBean id="bctCatalogEntry" classname="com.ibm.commerce.catalog.beans.CatalogEntryDataBean"/>
							
							<fmt:message key="DIVIDING_BAR" bundle="${storeText}" />
							<c:choose>
								<c:when test="${!empty productId && empty finalBreadcrumb}">
									<span class="breadcrumb_current"><c:out value="${bctCatalogEntry.description.name}" escapeXml="false"/></span>
								</c:when>
								<c:otherwise>
									<wcf:url var="catEntryDisplayUrl" value="Product2">
									    <wcf:param name="catalogId" value="${WCParam.catalogId}"/>
									    <wcf:param name="storeId" value="${WCParam.storeId}"/>
									    <wcf:param name="productId" value="${bctCatalogEntry.catalogEntryID}"/>
									    <wcf:param name="langId" value="${langId}"/>
									    <wcf:param name="categoryId" value="${categoryId}"/>
									    <wcf:param name="parent_category_rn" value="${parent_category_rn}"/>
									    <wcf:param name="top_category" value="${top_category}"/>
									</wcf:url>
									<a href="<c:out value='${catEntryDisplayUrl}'/>" id="WC_BreadCrumbTrailDisplay_link_6"><c:out value="${bctCatalogEntry.description.name}" escapeXml="false"/></a>
								</c:otherwise>
							</c:choose>
						</c:if>
												
						<c:if test="${compareProductPage}">							
							<fmt:message key="DIVIDING_BAR" bundle="${storeText}" />
							<span class="breadcrumb_current"><fmt:message key="BCT_PRODUCT_COMPARE" bundle="${storeText}" /></span>
						</c:if>
			</c:otherwise>
		</c:choose>
		<c:if test="${!empty finalBreadcrumb}">							
			<fmt:message key="DIVIDING_BAR" bundle="${storeText}" />
			<span class="breadcrumb_current"><c:out value="${finalBreadcrumb}"/></span>
		</c:if>		
	</div>
	</c:if>
	
	<c:choose>
		<c:when test="${shoppingCartPage}">
			<div id="orderItemDisplay">	
					<div class="left"><span class="on"><fmt:message key="SHOPPINGCART_TITLE" bundle="${storeText}"/></span></div>
					<wcf:url var="TopCategoriesDisplayURL" value="TopCategories1">
					  <wcf:param name="langId" value="${langId}" />
					  <wcf:param name="storeId" value="${WCParam.storeId}" />
					  <wcf:param name="catalogId" value="${WCParam.catalogId}" />
					</wcf:url>
					<div id="WC_BreadCrumbTrailDisplay_div_1a" class="breadcrumb_item">
						<span class="secondary_button button_fit" id="continueShoppingButton">
							<span class="button_container">
								<span class="button_bg">
									<span class="button_top">
										<span class="button_bottom">   
											<a id="WC_BreadCrumbTrailDisplay_links_2a" href="<c:out value='${TopCategoriesDisplayURL}'/>">
												<fmt:message key="CONTINUE_SHOPPING" bundle="${storeText}"/>
											</a>
										</span>
									</span>	
								</span>
							</span>
						</span>	
					</div>
			</div>
			<br clear="all"/>
		</c:when>
		<c:when test="${pendingOrderDetailsPage}">
			<div id="orderItemDisplay">	
					<div class="left"><span class="on"><fmt:message key="PENDING_ORDER_HEADER_TITLE" bundle="${storeText}"/></span></div>
			</div>
			<br clear="all"/>
		</c:when>
		<c:otherwise>
			
			<div id="WC_BreadCrumbTrailDisplay_div_3" class="breadcrumb_dropdowns">
				<div id="WC_BreadCrumbTrailDisplay_div_3a" class="breadcrumb_item">
					<flow:ifEnabled  feature="preferredCurrency">
						<wcf:getData type="com.ibm.commerce.infrastructure.facade.datatypes.ConfigurationType"
							var="currentStoreCurrencies"
							expressionBuilder="findByUniqueID">
							<wcf:param name="uniqueId" value="com.ibm.commerce.foundation.supportedCurrencies" />
							<wcf:contextData name="storeId" data="${storeId}"/>
						</wcf:getData>
						<c:set var="supportedCurrencies" value="${currentStoreCurrencies.configurationAttribute}"/>
							
						<wcf:getData type="com.ibm.commerce.infrastructure.facade.datatypes.ConfigurationType"
							var="currentStoreDefaultCurrency"
							expressionBuilder="findByUniqueID">
							<wcf:param name="uniqueId" value="com.ibm.commerce.foundation.defaultCurrency" />
							<wcf:contextData name="storeId" data="${storeId}"/>
						</wcf:getData>
						
						<c:forEach var="additionalValue" items="${currentStoreDefaultCurrency.configurationAttribute[0].additionalValue}">
							<c:if test="${additionalValue.name == 'currencyCode'}">
								<c:set var="storeDefaultCurrency" value="${additionalValue.value}"/>
							</c:if>
						</c:forEach>
							
						<%-- 
						  ***
						  *  Start: Currency selection box
						  *  This form allows shopper to switch currency.
						  *  Only display form if there is more than 1 currency
						  ***
						--%>
						<c:if test="${!empty supportedCurrencies[1]}">
							<form name="SetCurrencyPreferenceForm" action="SetCurrencyPreference" method="post" id="SetCurrencyPreferenceForm">
							<input type="hidden" name="storeId" value="<c:out value="${WCParam.storeId}"  />" id="WC_CachedHeader_FormInput_storeId_In_SetCurrencyPreferenceForm_1"/>
							<input type="hidden" name="catalogId" value="<c:out value="${WCParam.catalogId}"  />" id="WC_CachedHeader_FormInput_catalogId_In_SetCurrencyPreferenceForm_1"/>
							<%-- Get all request parameters and their values --%>
							<%-- Flush the buffer so this fragment JSP is not cached twice --%>
							<%out.flush();%>
								<c:import url="${jspStoreDir}include/WCParamValuesDisplay.jsp"/>
							<%out.flush();%>
							<label for="currencySelection" class="nodisplay"><fmt:message key="CHOOSE_CURRENCY" bundle="${storeText}" /></label>
							<select class="drop_down_language_select" id="currencySelection" name="currency" onchange="javascript:updateViewAndBeginIndexForCurrencyChange();form.submit();">
								<c:forEach var="supportedCurrency" items="${supportedCurrencies}">
									<c:forEach var="additionalValue" items="${supportedCurrency.additionalValue}">
										<c:if test="${additionalValue.name == 'currencyCode'}">
											<c:set var="currentCurrencyCode" value="${additionalValue.value}"/>
										</c:if>
									</c:forEach>
									<c:choose>
										<c:when test="${currentCurrencyCode == CommandContext.currency}">
											<option value='<c:out value="${currentCurrencyCode}" escapeXml="false"/>' selected="selected"><c:out value="${supportedCurrency.primaryValue.value}" escapeXml="false"/></option>
										</c:when>
										<c:otherwise>
											<option value='<c:out value="${currentCurrencyCode}" escapeXml="false"/>'><c:out value="${supportedCurrency.primaryValue.value}"  escapeXml="false"/></option>
										</c:otherwise>
									</c:choose>
								</c:forEach>
							</select>
							</form>
						</c:if>
						<%-- 
						  ***
						  *  End: Currency selection box
						  ***
						--%>
								
					</flow:ifEnabled>
			  </div>
			  
			  <div id="WC_BreadCrumbTrailDisplay_div_4" class="breadcrumb_item">
		  		<c:if test="${!SavedOrderListPage}">
					<flow:ifEnabled  feature="preferredLanguage">		
						<wcf:getData type="com.ibm.commerce.infrastructure.facade.datatypes.ConfigurationType"
							var="currentStoreLanguages"
							expressionBuilder="findByUniqueID">
							<wcf:param name="uniqueId" value="com.ibm.commerce.foundation.supportedLanguages" />
							<wcf:contextData name="storeId" data="${storeId}"/>
						</wcf:getData>
						<c:set var="supportedLanguages" value="${currentStoreLanguages.configurationAttribute}"/>
							
						<wcf:getData type="com.ibm.commerce.infrastructure.facade.datatypes.ConfigurationType"
							var="currentStoreDefaultLanguage"
							expressionBuilder="findByUniqueID">
							<wcf:param name="uniqueId" value="com.ibm.commerce.foundation.defaultLanguage" />
							<wcf:contextData name="storeId" data="${storeId}"/>
						</wcf:getData>
						
						<c:forEach var="additionalValue" items="${currentStoreDefaultLanguage.configurationAttribute[0].additionalValue}">
							<c:if test="${additionalValue.name == 'languageId'}">
								<c:set var="storeDefaultLangId" value="${additionalValue.value}"/>
							</c:if>
						</c:forEach>
							
						<c:forTokens items="${requestURIPath}" delims="/" var="URLtoken">
							<c:set var="ReloadURL" value="${URLtoken}"/>
						</c:forTokens>

					<c:set var="hasPageView" value="false"/>
					<c:set var="hasBeginIndex" value="false"/>

						<wcf:url var="LanguageChangeURL" value="${ReloadURL}">
							<wcf:param name="storeId" value="${WCParam.storeId}" />
							<wcf:param name="catalogId" value="${WCParam.catalogId}" />
							<%-- Get all request parameters and their values --%>
							<c:forEach var="aParam" items="${WCParamValues}" varStatus="paramStatus">
								<c:forEach var="aValue" items="${aParam.value}"  varStatus="paramNumStatus">
									<c:if test="${aParam.key !='langId' && aParam.key !='logonPassword' && aParam.key !='URL' && aParam.key !='currency' && aParam.key !='storeId' && aParam.key !='catalogId' && aParam.key !='pageView' && aParam.key !='beginIndex'}">
										<wcf:param name="${aParam.key}" value="${aValue}"/>
									</c:if>
								<c:if test="${aParam.key == 'pageView'}">
									<c:set var="hasPageView" value="true"/>
								</c:if>
								<c:if test="${aParam.key == 'beginIndex'}">
									<c:set var="hasBeginIndex" value="true"/>
								</c:if>
							</c:forEach>
						</c:forEach>
					</wcf:url>
						<%-- 
						  ***
						  *  Start: Language selection box
						  *  This form allows shopper to switch language.
						  *  Only display form if there is more than 1 language
						  ***
						--%>
						<c:if test="${!empty supportedLanguages[1]}">
							<form name="LanguageSelectionForm" action="<c:out value='${LanguageChangeURL}'/>" method="post" id="LanguageSelectionForm">
							<c:if test="${hasPageView == 'true'}">
								<input type="hidden" name="pageView" id="pageView" value="${WCParam.pageView}"/>
							</c:if>
							<c:if test="${hasBeginIndex == 'true'}">
								<input type="hidden" name="beginIndex" id="beginIndex" value="${WCParam.beginIndex}"/>
							</c:if>
							<label for="languageSelection" class="nodisplay"><fmt:message key="CHOOSE_COUNTRY" bundle="${storeText}" /></label>
						<select class="drop_down_language_select" id="languageSelection" name="langId" onchange="javascript:updateViewAndBeginIndexForLanguageChange();
						form.submit();">
								<c:forEach var="supportedLanguage" items="${supportedLanguages}">
									<c:forEach var="additionalValue" items="${supportedLanguage.additionalValue}">
										<c:if test="${additionalValue.name == 'languageId'}">
											<c:set var="currentLanguageId" value="${additionalValue.value}"/>
										</c:if>
									</c:forEach>
									<c:forEach var="dbLanguage" items="${sdb.languageDataBeans}">
										<c:if test="${currentLanguageId == dbLanguage.languageId}">
											<c:set var="currentLanguageString" value="${dbLanguage.nativeDescriptionString}"/>
										</c:if>
									</c:forEach>
									<c:choose>
										<c:when test="${currentLanguageId == CommandContext.languageId}">
											<option value='<c:out value="${currentLanguageId}" escapeXml="false"/>' selected="selected"><c:out value="${currentLanguageString}" escapeXml="false"/></option>
										</c:when>
										<c:otherwise>
											<option value='<c:out value="${currentLanguageId}" escapeXml="false"/>'><c:out value="${currentLanguageString}" escapeXml="false"/></option>
										</c:otherwise>
									</c:choose>
								</c:forEach>
							</select>
							</form>
						</c:if>
						<%-- 
						  ***
						  *  End: Language selection box
						  ***
						--%>
					</flow:ifEnabled>
				</c:if>
			  </div>
		</div>
  	</c:otherwise>
	</c:choose>
  
 </div>
</c:when>

<c:when test="${!param.hasBreadCrumbTrail && myAccountPage}">
<wcf:url var="MyAccountURL" value="AjaxLogonForm">
  <wcf:param name="langId" value="${langId}" />
  <wcf:param name="storeId" value="${WCParam.storeId}" />
  <wcf:param name="catalogId" value="${WCParam.catalogId}" />
  <wcf:param name="myAcctMain" value="1" />
</wcf:url>
		<div id="breadcrumb">
			<div class="title" id="WC_MyAccountDisplay_div_1">
				<h1 class="myaccount_title"> <a class="landingpage_link" href="${MyAccountURL}"> <fmt:message key="MA_MYACCOUNT" bundle="${storeText}"/></a></h1>
			</div>
		</div>
		<div id="MessageArea">
			<br />
			<span id="ErrorMessageText" class="error_msg">
				
			</span>
			<br /><br />  
		</div>
</c:when>
</c:choose>


<c:if test="${param.sharedWishList}">
	<br/>
</c:if>
<!-- END JSP File Name:  BreadCrumbTrailDisplay.jsp -->

