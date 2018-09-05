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
  * This JSP snippet will display the footer navigation for the mobile store front
  *****
--%>

<!-- BEGIN CachedFooterDisplay.jsp -->

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>

<%@ include file="../../../../include/parameters.jspf" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf" %>

<wcf:url var="MobileIndexURL" value="mIndex">
  <wcf:param name="langId" value="${langId}" />
  <wcf:param name="storeId" value="${WCParam.storeId}" />
  <wcf:param name="catalogId" value="${WCParam.catalogId}" />
</wcf:url>

<ul id="navigation">
	<c:if test="${!param.mobileIndex}">	  
		<li class="even"><a href="${fn:escapeXml(MobileIndexURL)}" title="<fmt:message key="FOOTER_NAV_HOME" bundle="${storeText}"/>" accesskey="1">&#187;
			<fmt:message key="FOOTER_NAV_HOME" bundle="${storeText}"/>
		</a></li>
	</c:if>
	<li class="odd">
		<wcf:url var="ShoppingCartURL" value="mOrderItemDisplay">
			<wcf:param name="langId" value="${langId}" />
			<wcf:param name="storeId" value="${WCParam.storeId}" />
			<wcf:param name="catalogId" value="${WCParam.catalogId}" />
		</wcf:url>
		<a href="${fn:escapeXml(ShoppingCartURL)}" title="<fmt:message key="FOOTER_NAV_SHOPPING_CART" bundle="${storeText}"/>" accesskey="2">&#187;
			<fmt:message key="FOOTER_NAV_SHOPPING_CART" bundle="${storeText}"/>
		</a>
	</li>
	<li class="even">
		<wcf:url var="AdvancedSearchDispURL" value="mAdvancedSearchDisplay">
			<wcf:param name="langId" value="${langId}" />
			<wcf:param name="storeId" value="${WCParam.storeId}" />
			<wcf:param name="catalogId" value="${WCParam.catalogId}" />
		</wcf:url>
		<a href="${fn:escapeXml(AdvancedSearchDispURL)}" title="<fmt:message key="FOOTER_NAV_SEARCH" bundle="${storeText}"/>" accesskey="3">&#187;
			<fmt:message key="FOOTER_NAV_SEARCH" bundle="${storeText}"/>
		</a>
	</li>
	<li class="odd">
		<wcf:url var="ProductCompareResultView" value="mProductCompareResultView">
			<wcf:param name="langId" value="${langId}" />
			<wcf:param name="storeId" value="${WCParam.storeId}" />
			<wcf:param name="catalogId" value="${WCParam.catalogId}" />
		</wcf:url>
		<c:set var="catEntryValues" value="" />
		<c:forEach var="catEntId" items="${sessionScope.productCompareCatentryIds}">
			<c:set var="catEntryValues" value="${catEntryValues}&catentryId=${catEntId}" />
		</c:forEach>
		<c:set var="ProductCompareResultView" value="${ProductCompareResultView}${catEntryValues}" />
		<a href="${fn:escapeXml(ProductCompareResultView)}" title="<fmt:message key="FOOTER_NAV_PROD_CMPR_LIST_TITLE" bundle="${storeText}"/>" accesskey="4">&#187; 
			<fmt:message key="FOOTER_NAV_PROD_CMPR_LIST" bundle="${storeText}">
				<fmt:param value="${numProdToCompare}"/>
				<fmt:param value="${maxProdToCompare}"/>
			</fmt:message>
		</a>
	</li>
	<li class="even">
		<wcf:url var="mStoreLocatorURL" value="mStoreLocatorView">
			<wcf:param name="langId" value="${langId}" />
			<wcf:param name="storeId" value="${storeId}" />
			<wcf:param name="catalogId" value="${catalogId}" />
			<wcf:param name="fromPage" value="${WCParam.fromPage}" />
			<c:if test="${WCParam.fromPage == 'ProductDetails'}">
				<wcf:param name="productId" value="${WCParam.productId}" />
				<c:if test="${!empty WCParam.pgGrp}">
					<wcf:param name="pgGrp" value="${WCParam.pgGrp}" />
					<c:choose>
						<c:when test="${WCParam.pgGrp == 'catNav'}">
							<wcf:param name="categoryId" value="${WCParam.categoryId}" />
							<wcf:param name="parent_category_rn" value="${WCParam.parent_category_rn}" />
							<wcf:param name="top_category" value="${WCParam.top_category}" />
							<wcf:param name="sequence" value="${WCParam.sequence}" />
						</c:when>
						<c:when test="${WCParam.pgGrp == 'search'}">
							<wcf:param name="resultCatEntryType" value="${WCParam.resultCatEntryType}" />
							<wcf:param name="pageSize" value="${WCParam.pageSize}" />
							<wcf:param name="searchTerm" value="${WCParam.searchTerm}" />
							<wcf:param name="sType" value="${WCParam.sType}" />
							<wcf:param name="beginIndex" value="${WCParam.beginIndex}" />
						</c:when>
					</c:choose>
				</c:if>
			</c:if>
		</wcf:url>
		<a href="${fn:escapeXml(mStoreLocatorURL)}" title="<fmt:message key="FOOTER_NAV_STORE_LOCATOR" bundle="${storeText}"/>" accesskey="5">&#187;
			<fmt:message key="FOOTER_NAV_STORE_LOCATOR" bundle="${storeText}"/>
		</a>
	</li>
	<li class="odd">
		<wcf:url var="LanguageCurrencyDispURL" value="mLanguageCurrencyDisplay">
  			<wcf:param name="langId" value="${langId}" />
  			<wcf:param name="storeId" value="${WCParam.storeId}" />
			<wcf:param name="catalogId" value="${WCParam.catalogId}" />
		</wcf:url>
		<a href="${fn:escapeXml(LanguageCurrencyDispURL)}" title="<fmt:message key="FOOTER_NAV_LANGUAGE_CURRENCY" bundle="${storeText}"/>" accesskey="6">&#187;
			<fmt:message key="FOOTER_NAV_LANGUAGE_CURRENCY" bundle="${storeText}"/>
		</a>
	</li>
	<li class="even">
		<wcf:url var="WishListDispURL" value="InterestItemDisplay">
  			<wcf:param name="langId" value="${langId}" />
  			<wcf:param name="storeId" value="${WCParam.storeId}" />
  			<wcf:param name="catalogId" value="${WCParam.catalogId}" />
  			<wcf:param name="listId" value="." />  			
  			<wcf:param name="URL" value="mInterestListDisplay" />  			
		</wcf:url>
		<a href="${fn:escapeXml(WishListDispURL)}" title="<fmt:message key="FOOTER_NAV_WISHLIST" bundle="${storeText}"/>" accesskey="7">&#187;
			<fmt:message key="FOOTER_NAV_WISHLIST" bundle="${storeText}"/>
		</a>
	</li>
	<li class="odd">
		<wcf:url var="AccountDispURL" value="mMyAccountDisplay">
	  		<wcf:param name="langId" value="${langId}" />
  			<wcf:param name="storeId" value="${WCParam.storeId}" />
  			<wcf:param name="catalogId" value="${WCParam.catalogId}" />
		</wcf:url>
		<a href="${fn:escapeXml(AccountDispURL)}" title="<fmt:message key="FOOTER_NAV_MY_ACCOUNT" bundle="${storeText}"/>" accesskey="8">&#187;
			<fmt:message key="FOOTER_NAV_MY_ACCOUNT" bundle="${storeText}"/>
		</a>
	</li>
	<li class="even">
		<wcf:url var="ContactUSURL" value="mContactUs">
			<wcf:param name="langId" value="${langId}" />
			<wcf:param name="storeId" value="${WCParam.storeId}" />
			<wcf:param name="catalogId" value="${WCParam.catalogId}" />
		</wcf:url>
		<a href="${fn:escapeXml(ContactUSURL)}" title="<fmt:message key="FOOTER_NAV_CONTACT_US" bundle="${storeText}"/>" accesskey="9">&#187;
			<fmt:message key="FOOTER_NAV_CONTACT_US" bundle="${storeText}"/>
		</a>
	</li>
	<%@ include file="../../../Snippets/StoreLocator/GPSSupportFooter.jspf" %>
	<c:set var="desktopSiteURL">
		TopCategories1_${WCParam.storeId}_${WCParam.catalogId}_${langId}
	</c:set>
	<li class="desktop_site"><a href="${desktopSiteURL}" title="View Desktop Site"><span class="bullet">&#187; </span><span class="text">View Desktop Site</span></a>
	</li>
	<li class="copyright">&#169;
		<fmt:message key="FOOTER_NAV_COPYRIGHT" bundle="${storeText}"/>
	</li>
</ul>

<div id="privacy_policy" class="text_container">
	<wcf:url var="PrivacyDisplayURL" value="mPrivacyPolicy">
		<wcf:param name="langId" value="${langId}" />
		<wcf:param name="storeId" value="${WCParam.storeId}" />
		<wcf:param name="catalogId" value="${WCParam.catalogId}" />
	</wcf:url>
	<p>
		<span class="bullet">&#187; </span>
		<a href="${fn:escapeXml(PrivacyDisplayURL)}" title="<fmt:message key="FOOTER_NAV_PRIVACY_POLICY" bundle="${storeText}"/>">
			<fmt:message key="FOOTER_NAV_PRIVACY_POLICY" bundle="${storeText}"/>
		</a>
	</p>
</div>

<!-- END CachedFooterDisplay.jsp -->
