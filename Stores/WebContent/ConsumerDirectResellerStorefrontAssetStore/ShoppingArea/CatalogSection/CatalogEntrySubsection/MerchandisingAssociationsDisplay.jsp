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
%> 

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>

<%@ include file="../../../include/JSTLEnvironmentSetup.jspf"%>


<%-- 
  *****
  * The page will show the cross-sell, up-sell, or accessory catalog entries if they are set up.
  * This JSP is included by the catalog entries pages (e.g. CachedProductOnlyDisplay.jsp).
  *
  * Parameters
  * 	-catalogEntryType
  *	This value is used to determine what bean to instantiate on this page.  For example, if this
  *	page is imported to display a merchandising association for a product, the catalogEntryType
  *	would be ProductBean.
  *	Possible values are:
  *		- ProductBean
  *		- ItemBean
  *		- PackageBean
  *		- BundleBean
  * This is an example of how this file could be included into a page:
  *		<c:import url="${jspStoreDir}ShoppingArea/CatalogSection/CatalogEntrySubsection/MerchandisingAssociationsDisplay.jsp">
  *			<c:param name="catalogEntryType" value="ProductBean" />
  *		</c:import>
  *
  *****
--%>
<!-- Start - JSP File Name:  MerchandisingAssociationsDisplay.jsp -->


<%-- 
  ***
  * Create a bean based on the catalogEntryType passed into this JSP.  In most cases the bean will be alive in the request scope
  * so it will not have to be reactivated. 
  ***
--%>
<c:choose>
	<c:when test="${param.catalogEntryType=='ProductBean'}">
		<wcbase:useBean id="merchandisingAssociation" classname="com.ibm.commerce.catalog.beans.ProductDataBean" />
	</c:when>
	<c:when test="${param.catalogEntryType=='ItemBean'}">
		<wcbase:useBean id="merchandisingAssociation" classname="com.ibm.commerce.catalog.beans.ItemDataBean" />
	</c:when>
	<c:when test="${param.catalogEntryType=='PackageBean'}">
		<wcbase:useBean id="merchandisingAssociation" classname="com.ibm.commerce.catalog.beans.PackageDataBean" />
	</c:when>
	<c:when test="${param.catalogEntryType=='BundleBean'}">
		<wcbase:useBean id="merchandisingAssociation" classname="com.ibm.commerce.catalog.beans.BundleDataBean" />
	</c:when>
</c:choose>
<hr width="100%"/>

<table cellpadding="0" cellspacing="0" border="0" id="WC_MerchandisingAssociationsDisplay_Table_1">
	<tbody>
		
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
					<c:if test="${!empty merchandisingAssociation.productCrossSells || !empty merchandisingAssociation.itemCrossSells  || !empty merchandisingAssociation.bundleCrossSells  || !empty merchandisingAssociation.packageCrossSells}">
						<tr>
							<td colspan="7" id="WC_MerchandisingAssociationsDisplay_TableCell_1">
								<span class="strongtext">
									<%--<fmt:message key="PRODUCT_XSELL" bundle="${storeDynamicText}" />--%>
									<c:import url="${jspStoreDir}/Snippets/Marketing/Content/ContentSpotDisplay.jsp">
										<c:param name="spotName" value="Product_XSell" />
									</c:import>
								</span><br/><br/>
							</td>
						</tr>	
						<c:set var="associateProducts" value="${merchandisingAssociation.productCrossSells}" scope="request"/>
						<c:set var="associateItems" value="${merchandisingAssociation.itemCrossSells}" scope="request"/>
						<c:set var="associateBundles" value="${merchandisingAssociation.bundleCrossSells}" scope="request" />
						<c:set var="associatePackages" value="${merchandisingAssociation.packageCrossSells}" scope="request" />
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
					<c:if test="${!empty merchandisingAssociation.productUpSells || !empty merchandisingAssociation.itemUpSells  || !empty merchandisingAssociation.bundleUpSells  || !empty merchandisingAssociation.packageUpSells}">
						<tr>
							<td colspan="7" id="WC_MerchandisingAssociationsDisplay_TableCell_2">
								<span class="strongtext">
									<%--<fmt:message key="PRODUCT_UPSELL" bundle="${storeDynamicText}" />--%>
									<c:import url="${jspStoreDir}/Snippets/Marketing/Content/ContentSpotDisplay.jsp">
										<c:param name="spotName" value="Product_UpSell" />
									</c:import>
								</span> <br/><br/>
							</td>
						</tr>
						<c:set var="associateProducts" value="${merchandisingAssociation.productUpSells}" scope="page" />
						<c:set var="associateItems" value="${merchandisingAssociation.itemUpSells}" scope="page" />
						<c:set var="associateBundles" value="${merchandisingAssociation.bundleUpSells}" scope="page" />
						<c:set var="associatePackages" value="${merchandisingAssociation.packageUpSells}" scope="page" />
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
					<c:if test="${!empty merchandisingAssociation.productAccessories || !empty merchandisingAssociation.itemAccessories  || !empty merchandisingAssociation.bundleAccessories  || !empty merchandisingAssociation.packageAccessories}">
						<tr>
							<td colspan="7" id="WC_MerchandisingAssociationsDisplay_TableCell_3">
								<span class="strongtext">
									<%--<fmt:message key="PRODUCT_ACCESSORY" bundle="${storeDynamicText}" />--%>
									<c:import url="${jspStoreDir}/Snippets/Marketing/Content/ContentSpotDisplay.jsp">
										<c:param name="spotName" value="Product_Accessory" />
									</c:import>
								</span> <br/><br/>
							</td>
						</tr>
						<c:set var="associateProducts" value="${merchandisingAssociation.productAccessories}" scope="page" />
						<c:set var="associateItems" value="${merchandisingAssociation.itemAccessories}" scope="page" />
						<c:set var="associateBundles" value="${merchandisingAssociation.bundleAccessories}" scope="page" />
						<c:set var="associatePackages" value="${merchandisingAssociation.packageAccessories}" scope="page" />
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
					<c:set var="catentryType" value="${merchandisingAssociation.type}" scope="page" />
					<c:if test="${(catentryType eq 'ProductBean' && !empty merchandisingAssociation.productReplacements) || (catentryType eq 'ItemBean' && !empty merchandisingAssociation.itemReplacements) || (catentryType eq 'BundleBean' && !empty merchandisingAssociation.bundleReplacements) || (catentryType eq 'PackageBean' && !empty merchandisingAssociation.packageReplacements)}">
						<tr>
							<td colspan="7" id="WC_MerchandisingAssociationsDisplay_TableCell_4">
								<span class="strongtext">
									<%--<fmt:message key="PRODUCT_REPLACEMENT" bundle="${storeDynamicText}" />--%>
									<c:import url="${jspStoreDir}/Snippets/Marketing/Content/ContentSpotDisplay.jsp">
										<c:param name="spotName" value="Product_Replacement" />
									</c:import>
								</span> <br/><br/>
							</td>
						</tr>
						<c:choose>	
							<c:when test="${catentryType eq 'ProductBean' }" >
								<c:set var="associateProducts" value="${merchandisingAssociation.productReplacements}" scope="page" />
							</c:when>
							<c:when test="${catentryType eq 'ItemBean' }" >
								<c:set var="associateItems" value="${merchandisingAssociation.itemReplacements}" scope="page" />
							</c:when>
							<c:when test="${catentryType eq 'BundleBean' }" >
								<c:set var="associateBundles" value="${merchandisingAssociation.bundleReplacements}" scope="page" />
							</c:when>
							<c:when test="${catentryType eq 'PackageBean' }" >
								<c:set var="associatePackages" value="${merchandisingAssociation.packageReplacements}" scope="page" />
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
				*  If there are any associations, the are displayed in AssociateCatentriesDisplay.jspf
				***
			--%> 
			<c:if test="${!empty associateProducts || !empty associateItems || !empty  associateBundles || !empty associatePackages}">	
				<%@ include file="AssociateCatentriesDisplay.jspf"%>
			</c:if>

			<%-- Clear these variables from memory and move on to the next association --%>
			<c:remove var="associateProducts"/>
			<c:remove var="associateItems"/>
			<c:remove var="associateBundles"/>
			<c:remove var="associatePackages"/>
		</c:forEach>
	</tbody>
</table>
<!-- End - JSP File Name:  MerchandisingAssociationsDisplay.jsp -->
