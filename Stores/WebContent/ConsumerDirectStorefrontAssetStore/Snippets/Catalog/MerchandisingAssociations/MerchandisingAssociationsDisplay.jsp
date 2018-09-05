<%
//********************************************************************
//*-------------------------------------------------------------------
//* Licensed Materials - Property of IBM
//*
//* WebSphere Commerce
//*
//* (c) Copyright IBM Corp. 2001, 2002, 2004
//*
//* US Government Users Restricted Rights - Use, duplication or
//* disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
//*
//*-------------------------------------------------------------------
//*
//*---------------------------------------------------------------------
//* The sample contained herein is provided to you "AS IS".
//*
//* It is furnished by IBM as a simple example and has not been  
//* thoroughly tested
//* under all conditions.  IBM, therefore, cannot guarantee its 
//* reliability, serviceability or functionality.  
//*
//* This sample may include the names of individuals, companies, brands 
//* and products in order to illustrate concepts as completely as 
//* possible.  All of these names
//* are fictitious and any similarity to the names and addresses used by 
//* actual persons 
//* or business enterprises is entirely coincidental.
//*---------------------------------------------------------------------
//*
%>

<%-- 
  *****
  * This JSP code snippet displays will show the cross-sell, up-sell, or accessory catalog entries if they are set up.
  * You can set up merchandising associations in the accelerator. This JSP is included by the catalog entry display pages
  * (e.g. CachedProductOnlyDisplay.jsp).
  * 
  *
  * Prerequisites:
  * 1. This snippet requires a parameter "catalogEntryType". 
  *	
  *    This value is used to determine what bean to instantiate on this page.  For example, if this
  *    page is imported to display a merchandising association for a product, the catalogEntryType
  *	   would be ProductBean.
  *	   Possible values are:
  *		- ProductBean
  *		- ItemBean
  *		- PackageBean
  *		- BundleBean
  *
  *    This snippet requires a file "JSTLEnvironmentSetup.jspf" to set up property bundles and other JSTL variables.
  *    Example JSTLEnvironmentSetup.jspf files are included in these starter stores:
  *     - ConsumerDirect
  *     - AdvancedB2BDirect
  *
  * How to use this snippet? 
  * 1. To use this snippet, dynamically include this JSP from pages which display products, items, packages or bundles.
  *    Ensure that you pass the parameter "catalogEntryType" to this JSP to specify which type of catalog information you
  *    are displaying.
  *
  *    If your store is based on the ConsumerDirect starter store, the JSP pages that use this snippet include:
  *     - CachedProductItemDisplay.jsp
  *     - CachedProductOnlyDisplay.jsp
  *     - CachedItemDisplay.jsp
  *     - CachedPackageDisplay.jsp
  *     - CachedBundleDisplay.jsp
  *
  *    If your store is based on the AdvancedB2BDirect starter store, the JSP pages that use this snippet include:
  *     - CachedProductDisplay.jsp
  *     - CachedItemDisplay.jsp
  *     - CachedPackageDisplay.jsp
  *     - CachedBundleDisplay.jsp
  *
  *****
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>

<%@ include file="../../../include/JSTLEnvironmentSetup.jspf"%>

<!-- Start - JSP File Name:  MerchandisingAssociationsDisplay.jsp -->


<%-- 
  ***
  * Create a bean based on the catalogEntryType passed into this JSP.  In most cases the bean will be alive in the request scope
  * so it will not have to be reactivated. 
  ***
--%>
<c:choose>
	<c:when test="${param.catalogEntryType=='ProductBean'}">
		<wcbase:useBean id="catalog_merchandisingAssociation" classname="com.ibm.commerce.catalog.beans.ProductDataBean" />
	</c:when>
	<c:when test="${param.catalogEntryType=='ItemBean'}">
		<wcbase:useBean id="catalog_merchandisingAssociation" classname="com.ibm.commerce.catalog.beans.ItemDataBean" />
	</c:when>
	<c:when test="${param.catalogEntryType=='PackageBean'}">
		<wcbase:useBean id="catalog_merchandisingAssociation" classname="com.ibm.commerce.catalog.beans.PackageDataBean" />
	</c:when>
	<c:when test="${param.catalogEntryType=='BundleBean'}">
		<wcbase:useBean id="catalog_merchandisingAssociation" classname="com.ibm.commerce.catalog.beans.BundleDataBean" />
	</c:when>
</c:choose>

<table cellpadding="0" cellspacing="0" border="0" id="Catalog_MerchandisingAssociationsDisplay_Table_1">
	<tbody>
		<tr><td></td></tr>
	<%--
	  ***
	  * Loop through all the merchantdising association types.  We loop through each type, one at a time and display 
	  * the associations in AssociateCatentriesDisplay.jspf.  
	  ***
	--%>
		<c:forEach begin="1" end="4" var="ShowMerchantAssociation">
			<c:choose>
				<c:when test="${ShowMerchantAssociation==1}">
					<%--
					  ***
					  * Start: Cross Sells
					  * Get the cross sells if they are available
					  ***
					 --%>
					<c:if test="${!empty catalog_merchandisingAssociation.productCrossSells || !empty catalog_merchandisingAssociation.itemCrossSells  || !empty catalog_merchandisingAssociation.bundleCrossSells  || !empty catalog_merchandisingAssociation.packageCrossSells}">
						<tr>
							<td colspan="5" id="Catalog_MerchandisingAssociationsDisplay_TableCell_1">
								<strong><fmt:message key="PRODUCT_XSELL" bundle="${storeText}" /></strong><br/><br/>
							</td>
						</tr>	
						<c:set var="catalog_associateProducts" value="${catalog_merchandisingAssociation.productCrossSells}" scope="request"/>
						<c:set var="catalog_associateItems" value="${catalog_merchandisingAssociation.itemCrossSells}" scope="request"/>
						<c:set var="catalog_associateBundles" value="${catalog_merchandisingAssociation.bundleCrossSells}" scope="request" />
						<c:set var="catalog_associatePackages" value="${catalog_merchandisingAssociation.packageCrossSells}" scope="request" />
					</c:if>
					<%--
					  ***
					  * End: Cross Sells
					  ***
					 --%>
				</c:when>
				<c:when test="${ShowMerchantAssociation==2}">
					<%--
					  ***
					  * Start: Up Sells
					  * Get all up sells if they are available
					  ***
					 --%>
					<c:if test="${!empty catalog_merchandisingAssociation.productUpSells || !empty catalog_merchandisingAssociation.itemUpSells  || !empty catalog_merchandisingAssociation.bundleUpSells  || !empty catalog_merchandisingAssociation.packageUpSells}">
						<tr>
							<td colspan="5" id="Catalog_MerchandisingAssociationsDisplay_TableCell_2">
								<strong><fmt:message key="PRODUCT_UPSELL" bundle="${storeText}" /></strong> <br/><br/>
							</td>
						</tr>
						<c:set var="catalog_associateProducts" value="${catalog_merchandisingAssociation.productUpSells}" scope="page" />
						<c:set var="catalog_associateItems" value="${catalog_merchandisingAssociation.itemUpSells}" scope="page" />
						<c:set var="catalog_associateBundles" value="${catalog_merchandisingAssociation.bundleUpSells}" scope="page" />
						<c:set var="catalog_associatePackages" value="${catalog_merchandisingAssociation.packageUpSells}" scope="page" />
					</c:if>
					<%--
					  ***
					  * End: Up Sells
					  ***
					 --%>
				</c:when>
				
				<c:when test="${ShowMerchantAssociation==3}">
					<%--
					  ***	
					  * Start: Accessories
					  * Get all accessories if they are available
					  ***
					 --%> 
					<c:if test="${!empty catalog_merchandisingAssociation.productAccessories || !empty catalog_merchandisingAssociation.itemAccessories  || !empty catalog_merchandisingAssociation.bundleAccessories  || !empty catalog_merchandisingAssociation.packageAccessories}">
						<tr>
							<td colspan="5" id="Catalog_MerchandisingAssociationsDisplay_TableCell_3">
								<strong><fmt:message key="PRODUCT_ACCESSORY" bundle="${storeText}" /></strong> <br/><br/>
							</td>
						</tr>
						<c:set var="catalog_associateProducts" value="${catalog_merchandisingAssociation.productAccessories}" scope="page" />
						<c:set var="catalog_associateItems" value="${catalog_merchandisingAssociation.itemAccessories}" scope="page" />
						<c:set var="catalog_associateBundles" value="${catalog_merchandisingAssociation.bundleAccessories}" scope="page" />
						<c:set var="catalog_associatePackages" value="${catalog_merchandisingAssociation.packageAccessories}" scope="page" />
					</c:if> 
					<%--
					  ***
					  * End: Accessories
					  ***
					 --%>
				</c:when>
	
				<c:when test="${ShowMerchantAssociation==4}">
					<%--
					  ***
					  * Start: Replacements
					  * Unlike other associations (e.g.x-sell), there are only methods to get replacements of the same type.  
					  * For example, ProductDataBean only has get method to getProductReplacements() and there is no ProductDataBean.getItemReplacements() method.
					  * As a result, we need to check the catentryType before using the get getXXXReplacments() method.
					  * catentryType is retrieved using the getType() method.
					  ***
					 --%>
					<c:set var="catentryType" value="${catalog_merchandisingAssociation.type}" scope="page" />
					<c:if test="${(catentryType eq 'ProductBean' && !empty catalog_merchandisingAssociation.productReplacements) || (catentryType eq 'ItemBean' && !empty catalog_merchandisingAssociation.itemReplacements) || (catentryType eq 'BundleBean' && !empty catalog_merchandisingAssociation.bundleReplacements) || (catentryType eq 'PackageBean' && !empty catalog_merchandisingAssociation.packageReplacements)}">
						<tr>
							<td colspan="5" id="Catalog_MerchandisingAssociationsDisplay_TableCell_4">
								<strong><fmt:message key="PRODUCT_REPLACEMENT" bundle="${storeText}" /></strong> <br/><br/>
							</td>
						</tr>
						<c:choose>	
							<c:when test="${catentryType eq 'ProductBean' }" >
								<c:set var="catalog_associateProducts" value="${catalog_merchandisingAssociation.productReplacements}" scope="page" />
							</c:when>
							<c:when test="${catentryType eq 'ItemBean' }" >
								<c:set var="catalog_associateItems" value="${catalog_merchandisingAssociation.itemReplacements}" scope="page" />
							</c:when>
							<c:when test="${catentryType eq 'BundleBean' }" >
								<c:set var="catalog_associateBundles" value="${catalog_merchandisingAssociation.bundleReplacements}" scope="page" />
							</c:when>
							<c:when test="${catentryType eq 'PackageBean' }" >
								<c:set var="catalog_associatePackages" value="${catalog_merchandisingAssociation.packageReplacements}" scope="page" />
							</c:when>									
						</c:choose>
						<c:set var="associationType" value="replacement" scope="page" />
					</c:if>
					<%--
					  ***
					  * End: Replacements
					  ***
					 --%> 
				</c:when>
			</c:choose>

			<%--
	  			***
				*  If there are any associations, they are displayed in AssociateCatentriesDisplay.jspf
				***
			--%> 
			<c:if test="${!empty catalog_associateProducts || !empty catalog_associateItems || !empty  catalog_associateBundles || !empty catalog_associatePackages}">	
				<%@ include file="AssociateCatentriesDisplay.jspf"%>
			</c:if>

			<%-- Clear these variables from memory and move on to the next association --%>
			<c:remove var="catalog_associateProducts"/>
			<c:remove var="catalog_associateItems"/>
			<c:remove var="catalog_associateBundles"/>
			<c:remove var="catalog_associatePackages"/>
		</c:forEach>
	</tbody>
</table>
<!-- End - JSP File Name:  MerchandisingAssociationsDisplay.jsp -->
