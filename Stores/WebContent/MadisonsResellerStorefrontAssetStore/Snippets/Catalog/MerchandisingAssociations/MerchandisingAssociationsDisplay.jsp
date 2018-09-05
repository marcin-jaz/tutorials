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
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>  
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
      
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf"%>

<!-- Start - JSP File Name:  MerchandisingAssociationsDisplay.jsp -->


<%-- 
  ***
  * Create a bean based on the catalogEntryType passed into this JSP.  In most cases the bean will be alive in the request scope
  * so it will not have to be reactivated. 
  ***
--%>
<c:set var="search" value='"'/>
<c:set var="replaceCmprStr" value=""/>
<c:set var="search01" value="'"/>

<c:set var="showProductQuickView" value="false"/>
<flow:ifEnabled feature="ProductQuickView">   
	<c:set var="showProductQuickView" value="true"/>
</flow:ifEnabled>

<c:set var="miniShopCartEnabled" value="false"/>
<flow:ifEnabled feature="miniShopCart">
	<c:set var="miniShopCartEnabled" value="true"/>
</flow:ifEnabled>

<c:set var="compareEnabled" value="false"/>
<flow:ifEnabled feature="ProductCompare">
	<c:set var="compareEnabled" value="true"/>
</flow:ifEnabled>

<c:set var="productDragAndDrop" value="false"/>
<flow:ifEnabled feature="ProductDnD">
	<c:if test="${miniShopCartEnabled || compareEnabled}">
		<c:set var="productDragAndDrop" value="true"/>
	</c:if>
</flow:ifEnabled>
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
<jsp:useBean id="catEntryAssociationMap" class="java.util.HashMap" scope="request"/>
<jsp:useBean id="catEntryTypeAssociation" class ="java.util.HashMap" scope="request"/>
<c:set var="totalAssociationCount" value="0"/>
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

	<%--
	***
	* Start: Display Product
	* Note: Unlike other associations (e.g.x-sell), there are only methods to get replacement of the same type.  
	* For example, ProductDataBean only has get method to getProductReplacements() and there is no ProductDataBean.getItemReplacements() method.
	* As a result, every time before displaying the catentry, there is a <c:if> to check the catentry type and the association type.
	* The display logic will not be executed if the association type is 'replacement, except the catentry type is the same as the type being displayed
	* The associationType is passed by the MerchandisingAssociationsDisplay.jsp.
	***	
	--%>
	<%-- 
  ***
  * Get the entitled items for the product bean and for the associated product bean.
  ***
--%>  
<c:if test="${catentryType eq 'ProductBean' || associationType ne 'replacement'}">	
	<c:set var="productCount" value="0"/>
		<c:forEach var="associateProduct" items="${catalog_associateProducts}" varStatus="status">
					<div id="entitledItem_<c:out value='${associateProduct.product.productID}'/>" style="display:none;">
								[
								<c:forEach var='entitledItem' items='${associateProduct.product.entitledItems}' varStatus='outerStatus'>
									<wcf:getData type="com.ibm.commerce.catalog.facade.datatypes.CatalogEntryType" var="sku" expressionBuilder="getStoreCatalogEntryAttributesByID">
										<wcf:contextData name="storeId" data="${param.storeId}"/>
										<wcf:param name="catEntryId" value="${entitledItem.itemID}"/>
										<wcf:param name="dataLanguageIds" value="${WCParam.langId}"/>
									</wcf:getData>
									{
									"catentry_id" : "<c:out value='${entitledItem.itemID}' />",
									"Attributes" :	{
										<c:set var="hasAttributes" value="false"/>
										<c:forEach var="definingAttrValue2" items="${sku.catalogEntryAttributes.attributes}" varStatus="innerStatus">
											<c:if test="${definingAttrValue2.usage == 'Defining'}">
												<c:if test='${hasAttributes eq "true"}'>,</c:if>
												"<c:out value="${definingAttrValue2.name}_${definingAttrValue2.value.value}" />":"<c:out value='${innerStatus.count}' />"
												<c:set var="hasAttributes" value="true"/>
											</c:if>	
										</c:forEach>
										}
									}<c:if test='${!outerStatus.last}'>,</c:if>
								</c:forEach>
								]
			</div>        

			<c:set target="${catEntryAssociationMap}" property="${associateProduct.product.productID}" value="${associateProduct.product}"/>
			<c:set target="${catEntryTypeAssociation}" property="${associateProduct.product.productID}" value="ProductBean"/>
			<%-- 
  ***
  *If the association type is of "product bean" then store this as product bean so that we can pop-up the quick info dialog 
  *to select the attributes for the product bean.
  ***
--%> 
			<c:if test="${empty associateProduct.product.entitledItems[1] && !empty associateProduct.product.entitledItems[0].partNumber }">			
						<wcf:getData type="com.ibm.commerce.catalog.facade.datatypes.CatalogEntryType" var="catEntryAttr" expressionBuilder="getStoreCatalogEntryAttributesByID">
							<wcf:contextData name="storeId" data="${param.storeId}"/>
							<wcf:param name="catEntryId" value="${associateProduct.product.productID}"/>
							<wcf:param name="dataLanguageIds" value="${WCParam.langId}"/>
			 			</wcf:getData>
			 			<c:set var="noAttributes" value="true" />
			 			<c:forEach var="attribute" items="${catEntryAttr.catalogEntryAttributes.attributes}">
							<c:if test="${attribute.usage == 'Defining'}">
								<c:set var="noAttributes" value="false" />
							</c:if>
						</c:forEach>
						<c:if test="${ noAttributes }">
							<c:set target="${catEntryTypeAssociation}" property="${associateProduct.product.productID}" value="ItemBean"/>
						</c:if>						
			</c:if>
			<c:set var="totalAssociationCount" value="${totalAssociationCount+1}"/>
		</c:forEach>
	</c:if>
        
	<%--
	  ***
	  * Start: Display Item
	  ***
	 --%>
	<c:if test="${catentryType eq 'ItemBean' || associationType ne 'replacement'}">	
		<c:set var="itemCount" value="0"/>
		<c:forEach var="associateItem" items="${catalog_associateItems}" varStatus="status">
			<c:set target="${catEntryAssociationMap}" property="${associateItem.item.itemID}" value="${associateItem.item}"/>
			<c:set target="${catEntryTypeAssociation}" property="${associateItem.item.itemID}" value="ItemBean"/>
			<c:set var="totalAssociationCount" value="${totalAssociationCount+1}"/>
		</c:forEach>
	</c:if>
         
	<%--
	  ***
	  * Start: Display Bundle    
	  ***		
	 --%> 
	<c:if test="${catentryType eq 'BundleBean' || associationType ne 'replacement'}">	
		<c:set var="bundleCount" value="0"/>
		<c:forEach var="associateBundle" items="${catalog_associateBundles}" varStatus="status">
			<c:set target="${catEntryAssociationMap}" property="${associateBundle.bundle.bundleID}" value="${associateBundle.bundle}"/>
			<c:set target="${catEntryTypeAssociation}" property="${associateBundle.bundle.bundleID}" value="BundleBean"/>
			<%-- 
			***
			* Start:  Get all product and item IDs displayed on this page and pass them to the discount code
			***
			--%>
			<form name="OrderAssociateItemAddForm_<c:out value='${associateBundle.bundle.bundleID}'/>" action="OrderChangeServiceItemAdd" method="post" id="OrderAssociateItemAddForm_<c:out value='${associateBundle.bundle.bundleID}'/>">
				<input type="hidden" name="langId" value="<c:out value="${WCParam.langId}" />" id="WC_AssociationDisplay_FormInput_langId_In_OrderAssociationItemAddForm_1"/>
				<input type="hidden" name="storeId" value="<c:out value="${WCParam.storeId}" />" id="WC_AssociationDisplay_FormInput_storeId_In_OrderAssociationItemAddForm_1"/>
				<input type="hidden" name="catalogId" value="<c:out value="${WCParam.catalogId}" />" id="WC_AssociationDisplay_FormInput_catalogId_In_OrderAssociationItemAddForm_1"/>
				<input type="hidden" name="URL" value="AjaxOrderItemDisplayView" id="WC_AssociationDisplay_FormInput_URL_In_OrderAssociationItemAddForm_1"/>
				<input type="hidden" name="errorViewName" value="InvalidInputErrorView" id="WC_AssociationDisplay_FormInput_errorViewName_In_OrderAssociationItemAddForm_1"/>
				<%-- shouldCachePage is used to tell the server not to cache this page.  So if an error happens, this page is redrawn with an error message --%>
				<input type="hidden" name="shouldCachePage" value="false" id="WC_AssociationDisplay_FormInput_shouldCachePage_In_OrderAssociationItemAddForm_1"/>
				<input type="hidden" name="calculationUsage" value="-1,-2,-3,-4,-5,-6,-7" id="WC_AssociationDisplay_FormInput_calcUsage_In_OrderAssociationItemAddForm_1"/>
				
				<%-- Create a comma delimited string containing all IDs to pass to the discount code.
					For an in depth explanation of why this is done, see DiscountJavaScriptSetup.jsp --%>
					<script type="text/javascript">
						if(!entitledItems)
							var entitledItems = [];
					</script>

					<c:set var="someAssociateItemIDs" value="" />
					<c:forEach var="associateProductInBundle" items="${associateBundle.bundle.bundledProducts}" varStatus="status">
						<c:choose>
							<c:when test="${empty someAssociateItemIDs}">
								<c:set var="someAssociateItemIDs" value="${associateProductInBundle.product.productID}" />
								<input type="hidden" name="quantity_<c:out value='${associateProductInBundle.product.productID}'/>" value="1" id="quantity_<c:out value='${associateProductInBundle.product.productID}'/>"/>
							</c:when>	
							<c:otherwise>
								<c:set var="someAssociateItemIDs" value="${someAssociateItemIDs},${associateProductInBundle.product.productID}" />
								<input type="hidden" name="quantity_<c:out value='${associateProductInBundle.product.productID}'/>" value="1" id="quantity_<c:out value='${associateProductInBundle.product.productID}'/>"/>
							</c:otherwise>	             
						</c:choose>
					
					<script type="text/javascript">
					<c:if test="${!empty associateProductInBundle.product.entitledItems[1]}">
							<c:forEach var="entitledItem" items="${associateProductInBundle.product.entitledItems}" varStatus="status">
								var item = new Object();
								item["catentry_id"] = "<c:out value='${entitledItem.itemID}' />";
								item["Attributes"] = new Object();
								<wcf:getData type="com.ibm.commerce.catalog.facade.datatypes.CatalogEntryType" var="sku" expressionBuilder="getStoreCatalogEntryAttributesByID">
									<wcf:contextData name="storeId" data="${param.storeId}"/>
									<wcf:param name="catEntryId" value="${entitledItem.itemID}"/>
									<wcf:param name="dataLanguageIds" value="${WCParam.langId}"/>
								</wcf:getData>
								<c:forEach var="definingAttrValue2" items="${sku.catalogEntryAttributes.attributes}" varStatus="innerStatus">
									<c:if test="${definingAttrValue2.usage == 'Defining'}">
										item["Attributes"]["<c:out value="${definingAttrValue2.name}_${definingAttrValue2.value.value}" />"] = "<c:out value='${status.count}' />";
									</c:if>	
								</c:forEach>
								entitledItems.push(item);
							</c:forEach>
							categoryDisplayJS.setDefaultItem('<c:out value='${associateProductInBundle.product.productID}'/>','${associateProductInBundle.product.entitledItems[0].itemID}');

					</c:if>
					</script>
					</c:forEach>

					<script type="text/javascript">
							categoryDisplayJS.setEntitledItems(entitledItems);
					</script>
					
					<c:forEach var="associateItemInBundle" items="${associateBundle.bundle.bundledItems}" varStatus="iStatus">
						<c:choose>
							<c:when test="${empty someAssociateItemIDs}">
								<c:set var="someAssociateItemIDs" value="${associateItemInBundle.item.itemID}" />
								<input type="hidden" name="quantity_<c:out value='${associateItemInBundle.item.itemID}'/>" value="1" id="quantity_<c:out value='${associateItemInBundle.item.itemID}'/>"/>
							</c:when>	
							<c:otherwise>
								<c:set var="someAssociateItemIDs" value="${someAssociateItemIDs},${associateItemInBundle.item.itemID}" />
								<input type="hidden" name="quantity_<c:out value='${associateItemInBundle.item.itemID}'/>" value="1" id="quantity_<c:out value='${associateItemInBundle.item.itemID}'/>"/>
							</c:otherwise>	
						</c:choose>	
					</c:forEach>
					
					<c:forEach var="associatePackageBundle" items="${associateBundle.bundle.bundledPackages}" varStatus="iStatus">
						<c:choose>
							<c:when test="${empty someAssociateItemIDs}">
								<c:set var="someAssociateItemIDs" value="${associatePackageBundle.package.packageID}" />
								<input type="hidden" name="quantity_<c:out value='${associatePackageBundle.package.packageID}'/>" value="1" id="quantity_<c:out value='${associatePackageBundle.package.packageID}'/>"/>
							</c:when>	
							<c:otherwise>
								<c:set var="someAssociateItemIDs" value="${someAssociateItemIDs},${associatePackageBundle.package.packageID}" />
								<input type="hidden" name="quantity_<c:out value='${associatePackageBundle.package.packageID}'/>" value="1" id="quantity_<c:out value='${associatePackageBundle.package.packageID}'/>"/>
							</c:otherwise>	
						</c:choose>	
					</c:forEach>
									
					<%-- 
				***
				* End:  Get all product and item IDs displayed on this page and pass them to the discount code
				***
				--%>
				<input type="hidden" name="catEntryIDS" value="<c:out value='${someAssociateItemIDs}'/>"/>
				<input type="hidden" name="productId" value="<c:out value="${associatePackageBundle.bundle.bundleID}" />" id="WC_AssociationDisplay_FormInput_productId_In_OrderItemAddForm_1"/>
			</form>
			<c:set var="totalAssociationCount" value="${totalAssociationCount+1}"/>
		</c:forEach>	
	</c:if>  
	       
<%--              
	  ***
	  * Start: Display Package
	  ***
	 --%>
	<c:if test="${catentryType eq 'PackageBean' || associationType ne 'replacement'}">	
		<c:set var="packageCount" value="0"/>
		<c:forEach var="associatePackage" items="${catalog_associatePackages}" varStatus="status">
			<c:set target="${catEntryAssociationMap}" property="${associatePackage.package.packageID}" value="${associatePackage.package}"/>
			<c:set target="${catEntryTypeAssociation}" property="${associatePackage.package.packageID}" value="PackageBean"/>
			<c:set var="totalAssociationCount" value="${totalAssociationCount+1}"/>   
		</c:forEach>
	</c:if>
</c:if>

			<%-- Clear these variables from memory and move on to the next association --%>
			<c:remove var="catalog_associateProducts"/>
			<c:remove var="catalog_associateItems"/>
			<c:remove var="catalog_associateBundles"/>
			<c:remove var="catalog_associatePackages"/>
		</c:forEach>                   
	<%-- 
  ***
  *If there are prodcts/items/bundles/package associated with the parent item then display the association. 
  ***
--%> 
<c:if test="${totalAssociationCount > 0}">
	<c:forEach var="marchandisingAssociation" items="${catEntryAssociationMap}" varStatus="status">
	<c:set var="marchandisingAssociationEntry" value="${marchandisingAssociation.value}"/>
	<wcf:url var="associatedProductDisplayURL" value="Product2">
	  <wcf:param name="langId" value="${WCParam.langId}" />
	  <wcf:param name="storeId" value="${WCParam.storeId}" />
	  <wcf:param name="catalogId" value="${WCParam.catalogId}" />
	  <wcf:param name="productId" value="${marchandisingAssociation.key}" />
	</wcf:url>
	
	
	<%-- 
	***
	* Handle the case where a catalog entry may not have a price.
	* If there is no price, mark it as not buyable and set price to 0 so total can be calculated.
	***
	--%>
	<c:set var="buyable" value="${marchandisingAssociationEntry.buyable}" />
	<c:catch var ="noPriceException">
		<c:set var="price" value="${marchandisingAssociationEntry.calculatedContractPrice.amount}" />
	</c:catch>
	<c:if test = "${noPriceException!=null}">
		<c:set var="price" value="0"/>
		<c:set var="buyable" value="0" />
	</c:if>
	<c:set var="compareImageDescription" value="${fn:replace(marchandisingAssociationEntry.description.shortDescription, search, replaceCmprStr)}"/>
	<c:set var="compareImageDescription" value="${fn:replace(compareImageDescription, search01, replaceCmprStr)}"/>
		<%-- 
  ***
  *Create a JSON object with all the details like catentryidentifier, name etc of the associated product to be used in the javascript.
  ***
--%> 
<c:set var="catEntryIDToUse" value="${marchandisingAssociation.key}"/>
<c:set var="catEntryTypeToUse" value="${catEntryTypeAssociation[marchandisingAssociation.key]}"/>
<c:if test="${catEntryTypeAssociation[marchandisingAssociation.key] == 'ProductBean' && fn:length(marchandisingAssociation.value.entitledItems) == 1}">
	<c:set var="catEntryIDToUse" value="${marchandisingAssociation.value.entitledItems[0].itemID}"/>
	<c:set var="catEntryTypeToUse" value="ItemBean"/>
</c:if>

	<div id="associatedCatEntries_<c:out value='${status.count}'/>" style="display:none;">
		[
			{
				'catEntry_Identifier' : '<c:out value='${catEntryIDToUse}'/>',
				'catEntry_Type' : '<c:out value='${catEntryTypeToUse}'/>',
				'catEntry_BundleFormId' : 
								<c:choose>
									<c:when test="${catEntryTypeAssociation[marchandisingAssociation.key]=='BundleBean'}">
										'<c:out value='OrderAssociateItemAddForm_${marchandisingAssociation.key}'/>',
									</c:when>
									<c:otherwise>
										'<c:out value=" "/>',
									</c:otherwise>
								</c:choose>
								
				'catEntry_Name' : <wcf:json object="${marchandisingAssociationEntry.description.name}"/>,
				'catEntry_Thumbnail' :
									<c:choose>
										<c:when test="${!empty marchandisingAssociationEntry.description.thumbNail}">
											'<c:out value='${marchandisingAssociationEntry.objectPath}${marchandisingAssociationEntry.description.thumbNail}'/>',
										</c:when>
										<c:otherwise>
											'<c:out value='${hostPath}${jspStoreImgDir}'/>images/NoImageIcon_sm.jpg',
										</c:otherwise>
									</c:choose>
				
				'catEntry_ShortDescription' : "<c:out value='${compareImageDescription}'/>",		
				'catEntry_Price' : "<c:out value='${price}'/>", 
				'catEntry_ProductLink' : '<c:out value='${associatedProductDisplayURL}'/>',
				'showProductQuickView' : '<c:out value='${showProductQuickView}'/>',
				'showProductQuickViewLable' : "<fmt:message key='QUICKINFO' bundle='${storeText}'/>",
				'productDragAndDrop' : '<c:out value='${productDragAndDrop}'/>',
				'associationProductBuyable' : "<c:out value='${buyable}'/>",
				'catEntry_Thumbnail_compare' :
									<c:set property="attachmentUsage" value="IMAGE_SIZE_40" target="${marchandisingAssociationEntry}" />
									<c:set var="image40AttachmentDataBeans" value="${marchandisingAssociationEntry.attachmentsByUsage}" />
									<c:choose>
										<c:when test="${!empty image40AttachmentDataBeans[0]}">
											'<c:out value='${image40AttachmentDataBeans[0].objectPath}${image40AttachmentDataBeans[0].path}'/>'
										</c:when>
										<c:when test="${!empty marchandisingAssociationEntry.description.thumbNail}">
											'<c:out value='${marchandisingAssociationEntry.objectPath}${marchandisingAssociationEntry.description.thumbNail}'/>'
										</c:when>
										<c:otherwise>
											'<c:out value='${hostPath}${jspStoreImgDir}'/>images/NoImageIcon_sm45.jpg'
										</c:otherwise>
									</c:choose>
			}
		]
	</div>
</c:forEach>

		<%-- 
  ***
  *Create a JSON object with all the details of the parent product to be used in the javascript.
  ***
--%> 
<c:catch var ="noPriceException">		
		<c:set var="merprice" value="${catalog_merchandisingAssociation.calculatedContractPrice.amount}" />
	</c:catch>
	<c:if test = "${noPriceException!=null}">
		<c:set var="merprice" value="0"/>
	</c:if>

<div id="baseCatEntryDetails" style="display:none;">
		[
			{
				'baseCatEntry_Name' : <wcf:json object="${catalog_merchandisingAssociation.description.name}"/>,
				'storeImage_Path' : '<c:out value='${hostPath}${jspStoreImgDir}${vfileColor}'/>',
				'baseCatEntry_Price' : '<c:out value='${merprice}'/>',
				'totalAssociations' : '<c:out value='${totalAssociationCount}'/>',
				'associatedProductsName':"<fmt:message key='MERCHANDISING_ASSOCIATION_PRODUCT_NAME' bundle='${storeText}'><fmt:param value='%0'/><fmt:param value='%1'/></fmt:message>",
				'currency' : '<c:out value='${CommandContext.currency}'/>'
			}
		]
		
</div>

		<%-- 
  ***
  *Display the parent product together with the associated product in the product display page.
  ***
--%> 
<div class="combo_area" id="WC_MerchandisingAssociationsDisplay_div_1">
	
			<c:choose>
				<c:when test="${!empty catalog_merchandisingAssociation.description.thumbNail}">
					<div class="product_image" id="WC_MerchandisingAssociationsDisplay_div_2"><img src="<c:out value="${catalog_merchandisingAssociation.objectPath}${catalog_merchandisingAssociation.description.thumbNail}"/>" alt="<c:out value="${catalog_merchandisingAssociation.description.shortDescription}" />" class="img" width="70" height="70"/></div>
				</c:when>
				<c:otherwise>
					<div class="product_image" id="WC_MerchandisingAssociationsDisplay_div_3"><img src="<c:out value="${hostPath}${jspStoreImgDir}" />images/NoImageIcon_sm.jpg" alt="<fmt:message key="No_Image" bundle="${storeText}"/>" class="img" width="70" height="70"/></div>
				</c:otherwise>
			</c:choose>
		<div class="plus_image" id="WC_MerchandisingAssociationsDisplay_div_4"><img src="<c:out value="${hostPath}${jspStoreImgDir}${vfileColor}" />i_plus.png" alt="<fmt:message key="No_Image" bundle="${storeText}"/>"/></div>		
	
	<div id="marchandisingAssociationDisplay">
	</div>
	<fmt:message var="totalPriceMsgValue"  key='MA_TOTALPRICE' bundle='${storeText}'/>
	<input type="hidden" name="totalPriceMsg" value="<c:out value='${totalPriceMsgValue}'/>" id="totalPriceMsg"/>
	<div class="combo_button" id="WC_MerchandisingAssociationsDisplay_div_5">
		<c:if test="${param.catalogEntryType=='ProductBean'}">
			<c:choose>
				<c:when test="${!empty catalog_merchandisingAssociation.maximumItemPrice && !(empty catalog_merchandisingAssociation.entitledItems[1] && catalog_merchandisingAssociation.entitledItems[0].buyable eq '0')}" >
						<%-- 
						  ***
						  *Product: Ajax Add to cart 
						  ***
						--%> 
					<flow:ifEnabled feature="AjaxAddToCart"> 
						 <span class="primary_button button_fit" >
							<span class="button_container">
								<span class="button_bg">
									<span class="button_top">
										<span class="button_bottom">   
											<a href="javascript:setCurrentId('WC_MerchandisingAssociationsDisplay_links_1'); categoryDisplayJS.AddAssociation2ShopCartAjax('entitledItem_<c:out value='${catalog_merchandisingAssociation.productID}'/>',document.getElementById('quantity_<c:out value='${catalog_merchandisingAssociation.productID}'/>').value)" id="WC_MerchandisingAssociationsDisplay_links_1"><fmt:message key="PRODUCT_ADD_TO_CART" bundle="${storeText}" /></a><br />
										</span>
									</span>	
								</span>
							</span>
						</span>	
					</flow:ifEnabled>
					<%-- 
						  ***
						  *Product: NON-Ajax Add to cart 
						  ***
						--%> 
					<flow:ifDisabled feature="AjaxAddToCart">
						<form name="OrderAssociationItemAddForm_<c:out value='${catalog_merchandisingAssociation.productID}'/>" action="OrderChangeServiceItemAdd" method="post" id="OrderAssociationItemAddForm_<c:out value='${catalog_merchandisingAssociation.productID}'/>">
							<input type="hidden" name="storeId" value="<c:out value='${WCParam.storeId}'/>" id="OrderAssociationItemAddForm_storeId_<c:out value='${catalog_merchandisingAssociation.productID}'/>"/>
							<input type="hidden" name="langId" value="<c:out value='${WCParam.langId}'/>" id="OrderAssociationItemAddForm_langId_<c:out value='${catalog_merchandisingAssociation.productID}'/>"/>
							<input type="hidden" name="catalogId" value="<c:out value='${WCParam.catalogId}'/>" id="OrderAssociationItemAddForm_catalogId_<c:out value='${catalog_merchandisingAssociation.productID}'/>"/>
							<input type="hidden" name="URL" value="AjaxOrderItemDisplayView" id="OrderAssociationItemAddForm_url_<c:out value='${catalog_merchandisingAssociation.productID}'/>"/>
							<input type="hidden" name="errorViewName" value="InvalidInputErrorView" id="OrderAssociationItemAddForm_errorViewName_<c:out value='${catalog_merchandisingAssociation.productID}'/>"/>
							<input type="hidden" name="catEntryId_1" value="<c:out value='${catalog_merchandisingAssociation.productID}'/>" id="OrderAssociationItemAddForm_catEntryId_1_<c:out value='${catalog_merchandisingAssociation.productID}'/>"/>
							<input type="hidden" name="productId_1" value="<c:out value='${catalog_merchandisingAssociation.productID}'/>" id="OrderAssociationItemAddForm_productId_1_<c:out value='${catalog_merchandisingAssociation.productID}'/>"/>
							<input type="hidden" name="catEntryId_2" value="" id="OrderAssociationItemAddForm_catEntryId_2_<c:out value='${catalog_merchandisingAssociation.productID}'/>"/>
							<input type="hidden" name="productId_2" value="" id="OrderAssociationItemAddForm_productId_2_<c:out value='${catalog_merchandisingAssociation.productID}'/>"/>
							<input type="hidden" name="quantity_1" value="1" id="OrderAssociationItemAddForm_quantity_1_<c:out value='${catalog_merchandisingAssociation.productID}'/>"/>
							<input type="hidden" name="quantity_2" value="1" id="OrderAssociationItemAddForm_quantity_2_<c:out value='${catalog_merchandisingAssociation.productID}'/>"/>
							<input type="hidden" name="calculationUsage" value="-1,-2,-3,-4,-5,-6,-7" id="OrderAssociationItemAddForm_calcUsage_<c:out value='${catalog_merchandisingAssociation.productID}'/>"/>
						</form>
						 <span class="primary_button button_fit" >
							<span class="button_container">
								<span class="button_bg">
									<span class="button_top">
										<span class="button_bottom">   
											<a href="#" onclick="javascript:setCurrentId('WC_MerchandisingAssociationsDisplay_links_2'); categoryDisplayJS.AddMarchandisingAssociation2ShopCart('entitledItem_<c:out value='${catalog_merchandisingAssociation.productID}'/>',document.getElementById('OrderAssociationItemAddForm_<c:out value='${catalog_merchandisingAssociation.productID}'/>'),document.getElementById('quantity_<c:out value='${catalog_merchandisingAssociation.productID}'/>').value);return false;" id="WC_MerchandisingAssociationsDisplay_links_2"><fmt:message key="PRODUCT_ADD_TO_CART" bundle="${storeText}" /></a>
							 			</span>
									</span>	
								</span>
							</span>
						</span>	
						 <br />
					</flow:ifDisabled>   
				</c:when>
				<c:otherwise>
					<p><fmt:message key="SKU_NOT_BUYABLE" bundle="${storeText}" /></p>
					<wcf:url var="TopCategoriesDisplayURL" value="TopCategories1">
					  <wcf:param name="langId" value="${langId}" />
					  <wcf:param name="storeId" value="${WCParam.storeId}" />
					  <wcf:param name="catalogId" value="${WCParam.catalogId}" />
					</wcf:url>
					<p>
						<span class="primary_button button_fit" >
							<span class="button_container">
								<span class="button_bg">
									<span class="button_top">
										<span class="button_bottom">   
											<a href="<c:out value="${TopCategoriesDisplayURL}" />" id="WC_MerchandisingAssociationsDisplay_links_3"><fmt:message key="RETURN_SHOPPING" bundle="${storeText}" /></a>
										</span>
									</span>	
								</span>
							</span>
						</span>	
					</p>
				</c:otherwise>
			</c:choose>
		</c:if>
		<c:if test="${param.catalogEntryType=='ItemBean'}">
						<%-- 
						  ***
						  *Item: Ajax Add to cart 
						  ***
						--%> 
			<flow:ifEnabled feature="AjaxAddToCart"> 
				<span class="primary_button button_fit" >
					<span class="button_container">
						<span class="button_bg">
							<span class="button_top">
								<span class="button_bottom">   
									<a href="javascript:setCurrentId('WC_MerchandisingAssociationsDisplay_links_4'); categoryDisplayJS.AddAssociationItem2ShopCartAjax('<c:out value='${catalog_merchandisingAssociation.itemID}'/>',document.getElementById('quantity_<c:out value='${catalog_merchandisingAssociation.itemID}'/>').value)" id="WC_MerchandisingAssociationsDisplay_links_4"><fmt:message key="PRODUCT_ADD_TO_CART" bundle="${storeText}" /></a>
								</span>
							</span>	
						</span>
					</span>
				</span>
			</flow:ifEnabled>
			<%-- 
						  ***
						  *Item: NON-Ajax Add to cart 
						  ***
						--%> 
			<flow:ifDisabled feature="AjaxAddToCart">
				<form name="OrderAssociationItemAddForm_<c:out value='${catalog_merchandisingAssociation.itemID}'/>" action="OrderChangeServiceItemAdd" method="post" id="OrderAssociationItemAddForm_<c:out value='${catalog_merchandisingAssociation.itemID}'/>">
					<input type="hidden" name="storeId" value="<c:out value='${WCParam.storeId}'/>" id="OrderAssociationItemAddForm_storeId_<c:out value='${catalog_merchandisingAssociation.itemID}'/>"/>
					<input type="hidden" name="langId" value="<c:out value='${WCParam.langId}'/>" id="OrderAssociationItemAddForm_langId_<c:out value='${catalog_merchandisingAssociation.itemID}'/>"/>
					<input type="hidden" name="catalogId" value="<c:out value='${WCParam.catalogId}'/>" id="OrderAssociationItemAddForm_catalogId_<c:out value='${catalog_merchandisingAssociation.itemID}'/>"/>
					<input type="hidden" name="URL" value="AjaxOrderItemDisplayView" id="OrderAssociationItemAddForm_orderId_<c:out value='${catalog_merchandisingAssociation.itemID}'/>"/>
					<input type="hidden" name="errorViewName" value="InvalidInputErrorView" id="OrderAssociationItemAddForm_errorViewName_<c:out value='${catalog_merchandisingAssociation.itemID}'/>"/>
					<input type="hidden" name="catEntryId_1" value="<c:out value='${catalog_merchandisingAssociation.itemID}'/>" id="OrderAssociationItemAddForm_catEntryId_1_<c:out value='${catalog_merchandisingAssociation.itemID}'/>"/>
					<input type="hidden" name="productId_1" value="<c:out value='${catalog_merchandisingAssociation.itemID}'/>" id="OrderAssociationItemAddForm_productId_1_<c:out value='${catalog_merchandisingAssociation.itemID}'/>"/>
					<input type="hidden" name="quantity_1" value="1" id="OrderAssociationItemAddForm_quantity_1_<c:out value='${catalog_merchandisingAssociation.itemID}'/>"/>
					<input type="hidden" name="catEntryId_2" value="" id="OrderAssociationItemAddForm_catEntryId_2_<c:out value='${catalog_merchandisingAssociation.itemID}'/>"/>
					<input type="hidden" name="productId_2" value="" id="OrderAssociationItemAddForm_productId_2_<c:out value='${catalog_merchandisingAssociation.itemID}'/>"/>
					<input type="hidden" name="quantity_2" value="1" id="OrderAssociationItemAddForm_quantity_2_<c:out value='${catalog_merchandisingAssociation.itemID}'/>"/>
					<input type="hidden" name="calculationUsage" value="-1,-2,-3,-4,-5,-6,-7" id="OrderAssociationItemAddForm_calcUsage_<c:out value='${catalog_merchandisingAssociation.itemID}'/>"/>
				</form>
				<span class="primary_button button_fit" >
					<span class="button_container">
						<span class="button_bg">
							<span class="button_top">
								<span class="button_bottom">   
									<a href="javascript:categoryDisplayJS.AddAssociationItem2ShopCart(document.getElementById('OrderAssociationItemAddForm_<c:out value='${catalog_merchandisingAssociation.itemID}'/>'),document.getElementById('quantity_<c:out value='${catalog_merchandisingAssociation.itemID}'/>').value)" id="WC_MerchandisingAssociationsDisplay_links_5"><fmt:message key="PRODUCT_ADD_TO_CART" bundle="${storeText}" /></a>
								</span>
							</span>	
						</span>
					</span>
				</span>
			</flow:ifDisabled>
		</c:if>
		<c:if test="${param.catalogEntryType=='PackageBean'}">
						<%-- 
						  ***
						  *Package: Ajax Add to cart 
						  ***
						--%> 
			<flow:ifEnabled feature="AjaxAddToCart"> 
				<span class="primary_button button_fit" >
					<span class="button_container">
						<span class="button_bg">
							<span class="button_top">
								<span class="button_bottom">   
									<a href="javascript:setCurrentId('WC_MerchandisingAssociationsDisplay_links_6'); categoryDisplayJS.AddAssociationItem2ShopCartAjax('<c:out value='${catalog_merchandisingAssociation.packageID}'/>',document.getElementById('quantity_<c:out value='${catalog_merchandisingAssociation.packageID}'/>').value)" id="WC_MerchandisingAssociationsDisplay_links_6"><fmt:message key="PRODUCT_ADD_TO_CART" bundle="${storeText}" /></a>
								</span>
							</span>	
						</span>
					</span>
				</span>
			</flow:ifEnabled>
						<%-- 
						  ***
						  *Package: NON-Ajax Add to cart 
						  ***
						--%> 
			<flow:ifDisabled feature="AjaxAddToCart">
				<form name="OrderAssociationItemAddForm_<c:out value='${catalog_merchandisingAssociation.packageID}'/>" action="OrderChangeServiceItemAdd" method="post" id="OrderAssociationItemAddForm_<c:out value='${catalog_merchandisingAssociation.packageID}'/>">
					<input type="hidden" name="storeId" value="<c:out value='${WCParam.storeId}'/>" id="OrderAssociationItemAddForm_storeId_<c:out value='${catalog_merchandisingAssociation.packageID}'/>"/>
					<input type="hidden" name="langId" value="<c:out value='${WCParam.langId}'/>" id="OrderAssociationItemAddForm_langId_<c:out value='${catalog_merchandisingAssociation.packageID}'/>"/>
					<input type="hidden" name="catalogId" value="<c:out value='${WCParam.catalogId}'/>" id="OrderAssociationItemAddForm_catalogId_<c:out value='${catalog_merchandisingAssociation.packageID}'/>"/>
					<input type="hidden" name="URL" value="AjaxOrderItemDisplayView" id="OrderAssociationItemAddForm_orderId_<c:out value='${catalog_merchandisingAssociation.packageID}'/>"/>
					<input type="hidden" name="errorViewName" value="InvalidInputErrorView" id="OrderAssociationItemAddForm_errorViewName_<c:out value='${catalog_merchandisingAssociation.packageID}'/>"/>
					<input type="hidden" name="catEntryId_1" value="<c:out value='${catalog_merchandisingAssociation.packageID}'/>" id="OrderAssociationItemAddForm_catEntryId_1_<c:out value='${catalog_merchandisingAssociation.packageID}'/>"/>
					<input type="hidden" name="productId_1" value="<c:out value='${catalog_merchandisingAssociation.packageID}'/>" id="OrderAssociationItemAddForm_productId_1_<c:out value='${catalog_merchandisingAssociation.packageID}'/>"/>
					<input type="hidden" name="quantity_1" value="1" id="OrderAssociationItemAddForm_quantity_1_<c:out value='${catalog_merchandisingAssociation.packageID}'/>"/>
					<input type="hidden" name="catEntryId_2" value="" id="OrderAssociationItemAddForm_catEntryId_2_<c:out value='${catalog_merchandisingAssociation.packageID}'/>"/>
					<input type="hidden" name="productId_2" value="" id="OrderAssociationItemAddForm_productId_2_<c:out value='${catalog_merchandisingAssociation.packageID}'/>"/>
					<input type="hidden" name="quantity_2" value="1" id="OrderAssociationItemAddForm_quantity_2_<c:out value='${catalog_merchandisingAssociation.packageID}'/>"/>
					<input type="hidden" name="calculationUsage" value="-1,-2,-3,-4,-5,-6,-7" id="OrderAssociationItemAddForm_calcUsage_<c:out value='${catalog_merchandisingAssociation.packageID}'/>"/>
				</form>
				<span class="primary_button button_fit" >
					<span class="button_container">
						<span class="button_bg">
							<span class="button_top">
								<span class="button_bottom">   
									<a href="javascript:categoryDisplayJS.AddAssociationItem2ShopCart(document.getElementById('OrderAssociationItemAddForm_<c:out value='${catalog_merchandisingAssociation.packageID}'/>'),document.getElementById('quantity_<c:out value='${catalog_merchandisingAssociation.packageID}'/>').value)" id="WC_MerchandisingAssociationsDisplay_links_7"><fmt:message key="PRODUCT_ADD_TO_CART" bundle="${storeText}" /></a>
								</span>
							</span>	
						</span>
					</span>
				</span>
			</flow:ifDisabled>
		</c:if>
		<c:if test="${param.catalogEntryType=='BundleBean'}">
						<%-- 
						  ***
						  *Bundle: Ajax Add to cart 
						  ***
						--%> 
			<flow:ifEnabled feature="AjaxAddToCart"> 
				<span class="primary_button button_fit" >
					<span class="button_container">
						<span class="button_bg">
							<span class="button_top">
								<span class="button_bottom">   
									<a href="javascript:setCurrentId('WC_MerchandisingAssociationsDisplay_links_8'); categoryDisplayJS.AddAssociationBundle2ShopCartAjax(document.getElementById('OrderItemAddForm_<c:out value='${catalog_merchandisingAssociation.bundleID}'/>'))"  id="WC_MerchandisingAssociationsDisplay_links_8"><fmt:message key="PRODUCT_ADD_TO_CART" bundle="${storeText}" /></a>
								</span>
							</span>	
						</span>
					</span>
				</span>
			</flow:ifEnabled>
						<%-- 
						  ***
						  *Bundle: NON-Ajax Add to cart 
						  ***
						--%> 
			<flow:ifDisabled feature="AjaxAddToCart">
				<span class="primary_button button_fit" >
					<span class="button_container">
						<span class="button_top">
							<span class="button_bottom">   
								<a href="javascript:categoryDisplayJS.AddAssociationBundle2ShopCart(document.getElementById('OrderItemAddForm_<c:out value='${catalog_merchandisingAssociation.bundleID}'/>'))" id="WC_MerchandisingAssociationsDisplay_links_9"><fmt:message key="PRODUCT_ADD_TO_CART" bundle="${storeText}" /></a>
							</span>
						</span>	
					</span>
				</span>
			</flow:ifDisabled>
		</c:if>
	</div>
<%-- 
  ***
  *Initialize the association start index to scroll the associated products in the display. 
  ***
--%> 
<script type="text/javascript">
	dojo.addOnLoad(function() { 
		var startIndex="1";
		categoryDisplayJS.displayNextAssociation = "<fmt:message key="SHOW_NEXT_ASSOCIATION" bundle="${storeText}" />";
		categoryDisplayJS.displayPrevAssociation = "<fmt:message key="SHOW_PREV_ASSOCIATION" bundle="${storeText}" />";
		categoryDisplayJS.initializeMerchandisingAssociation(startIndex);
	});
</script>
</div>     
</c:if>    
<!-- End - JSP File Name:  MerchandisingAssociationsDisplay.jsp -->
                            
