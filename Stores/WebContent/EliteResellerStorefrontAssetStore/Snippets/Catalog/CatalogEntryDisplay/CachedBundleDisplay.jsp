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
  * This JSP page displays the product details.  It shows the following information:
  *  - Full-sized image, name, and long description of the product
  *  - Discount description for the product, if available
  *  - Contract price and list price of the product
  *  - A list of defining attributes (such as size and color) if the product has variations, along with a list of values for each attribute (for example, red and blue for color or large and x-large for size)
  *  - Descriptive attributes, displayed as name:value
  *  - 'Quantity' box to enter the quantity (default is 1)
  *  - 'Add to shopping cart' button, 'Add to wish list' button for B2C stores, 'Add to Requisition List' button for B2B stores
  * This is an example of how this file could be included into a page: 
  *<c:import url="../../../Snippets/Catalog/CatalogEntryDisplay/CachedProductOnlyDisplay.jsp">
  *	        <c:param name="storeId" value="${storeId}"/>
  *	        <c:param name="catalogId" value="${catalogId}"/>
  *	        <c:param name="langId" value="${langId}"/>
  *	        <c:param name="productId" value="${productId}"/>
  *	        <c:param name="parent_category_rn" value="${parent_category_rn}"/>
  *	        <c:param name="shouldCachePage" value="${shouldCachePage}"/>
  *	    </c:import>
  *****
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf"%>
<%-- ErrorMessageSetup.jspf is used to retrieve an appropriate error message when there is an error --%>
<%@ include file="../../../include/ErrorMessageSetup.jspf" %>

<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/CatalogArea/ProductDisplay.js"/>"></script>
<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/ServicesDeclaration.js"/>"></script>
<script type="text/javascript">
	dojo.addOnLoad(function() {
		ServicesDeclarationJS.setCommonParameters('<c:out value='${WCParam.langId}'/>','<c:out value='${WCParam.storeId}'/>','<c:out value='${WCParam.catalogId}'/>');
	});
</script>
<c:set var="search01" value="'"/>
<c:set var="replaceStr01" value="\\'"/>
<c:set var="search" value='"'/>
<c:set var="replaceCmprStr" value=""/>

<c:set var="miniShopCartEnabled" value="false"/>
<flow:ifEnabled feature="miniShopCart">
	<c:set var="miniShopCartEnabled" value="true"/>
</flow:ifEnabled>

<c:set var="compareEnabled" value="false"/>
<flow:ifEnabled feature="ProductCompare">
	<c:set var="compareEnabled" value="true"/>
</flow:ifEnabled>

<c:set var="addProductDnD" value="false"/>
<flow:ifEnabled feature="ProductDnD">
	<c:if test="${miniShopCartEnabled || compareEnabled}">
		<c:set var="addProductDnD" value="true"/>
	</c:if>
</flow:ifEnabled>
<flow:ifEnabled feature="AjaxMyAccountPage">
	<script type="text/javascript">
		dojo.addOnLoad(function() {
			categoryDisplayJS.setAjaxMyAccount(true);
		});
	</script>
</flow:ifEnabled>
<flow:ifDisabled feature="AjaxMyAccountPage">
	<script type="text/javascript">
		dojo.addOnLoad(function() {
			categoryDisplayJS.setAjaxMyAccount(false);
		});
	</script>
</flow:ifDisabled>
<wcbase:useBean id="bundle" classname="com.ibm.commerce.catalog.beans.BundleDataBean"  scope="request" />
<c:set var="dragType" value="bundle"/>

<wcf:url var="catEntryDisplayUrl" value="Product2">
	<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
	<wcf:param name="storeId" value="${WCParam.storeId}"/>
	<wcf:param name="productId" value="${bundle.bundleID}"/>
	<wcf:param name="langId" value="${WCParam.langId}"/>
	<wcf:param name="parent_category_rn" value="${WCParam.categoryId}"/>
	<wcf:param name="top_category" value="${WCParam.top_category}"/>
</wcf:url>

<wcf:url var="CatalogAttachmentURL" value="CatalogAttachmentView">
	<wcf:param name="storeId" value="${WCParam.storeId}"/>
	<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
	<wcf:param name="langId" value="${langId}"/>
	<wcf:param name="productId" value="${productId}"/>
	<wcf:param name="catType" value="bundle"/>
	<wcf:param name="excludeUsageStr" value="ANGLEIMAGES_THUMBNAIL,ANGLEIMAGES_FULLIMAGE,IMAGE_SIZE_55,IMAGE_SIZE_40"/>
	<wcf:param name="retrieveLanguageIndependentAtchAst" value="1"/>
</wcf:url>


<c:set var="displayPriceRange" value="true"/>

<%-- 
***
* Start:  Get all product and item IDs displayed on this page and pass them to the discount code
***
--%>
	<%-- Create a comma delimited string containing all IDs to pass to the discount code.
		For an in depth explanation of why this is done, see DiscountJavaScriptSetup.jsp --%>
		<script type="text/javascript">
			var entitledItems = [];
		</script>
	<c:set var="someItemIDs" value="" />
	<c:forEach var="productInBundle" items="${bundle.bundledProducts}" varStatus="status">
		<c:choose>
			<c:when test="${empty someItemIDs}">
				<c:set var="someItemIDs" value="${productInBundle.product.productID}" />
			</c:when>	
			<c:otherwise>
				<c:set var="someItemIDs" value="${someItemIDs},${productInBundle.product.productID}" />
			</c:otherwise>	
		</c:choose>
		<script type="text/javascript">
			<c:if test="${!empty productInBundle.product.entitledItems[0]}">
		
			<c:forEach var="entitledItem" items="${productInBundle.product.entitledItems}" varStatus="status">
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
						item["Attributes"]["<c:out value="${fn:replace(definingAttrValue2.name, search01, replaceStr01)}_${fn:replace(definingAttrValue2.value.value, search01, replaceStr01)}" />"] = "<c:out value='${status.count}' />";
					</c:if>	
				</c:forEach>
				entitledItems.push(item);
			</c:forEach>
				categoryDisplayJS.setDefaultItem('<c:out value='${productInBundle.product.productID}'/>','${productInBundle.product.entitledItems[0].itemID}');

			</c:if>
		</script>
	</c:forEach>

		<script type="text/javascript">
			categoryDisplayJS.setEntitledItems(entitledItems);
		</script>
	<c:forEach var="itemInBundle" items="${bundle.bundledItems}" varStatus="iStatus">
		<c:choose>
			<c:when test="${empty someItemIDs}">
				<c:set var="someItemIDs" value="${itemInBundle.item.itemID}" />
			</c:when>	
			<c:otherwise>
				<c:set var="someItemIDs" value="${someItemIDs},${itemInBundle.item.itemID}" />
			</c:otherwise>	
		</c:choose>	
	</c:forEach>
	
	<c:forEach var="packageBundle" items="${bundle.bundledPackages}" varStatus="iStatus">
		<c:choose>
			<c:when test="${empty someItemIDs}">
				<c:set var="someItemIDs" value="${packageBundle.package.packageID}" />
			</c:when>	
			<c:otherwise>
				<c:set var="someItemIDs" value="${someItemIDs},${packageBundle.package.packageID}" />
			</c:otherwise>	
		</c:choose>	
	</c:forEach>
	
	<%-- Pass the IDs to the discount JavaScript --%>
	<%-- Flush the buffer so this fragment JSP is not cached twice --%>
	<%out.flush();%>
	<c:import url="${jspStoreDir}include/DiscountJavaScriptSetup.jsp">
		<c:param name="jsPrototypeName" value="Discount" />
		<c:param name="someProductIDs" value="${someProductIDs}"/>
		<c:param name="productIncludeChildItems" value="true"/>
		<c:param name="productIsProdPromoOnly" value="true"/>
		<c:param name="productIncludeParentProduct" value="false"/>
		
		<c:param name="someItemIDs" value="${someItemIDs}"/>
		<c:param name="itemIncludeChildItems" value="true"/>
		<c:param name="itemIsProdPromoOnly" value="false"/>
		<c:param name="itemIncludeParentProduct" value="false"/>
	</c:import>
	<%out.flush();%>
<%-- 
***
* End:  Get all product and item IDs displayed on this page and pass them to the discount code
***
--%>
<div id="body588">
	   <div id="product">
<form name="OrderItemAddForm_<c:out value='${bundle.bundleID}'/>" action="OrderChangeServiceItemAdd" method="post" id="OrderItemAddForm_<c:out value='${bundle.bundleID}'/>">
	<input type="hidden" name="langId" value="<c:out value="${WCParam.langId}" />" id="WC_CachedPackageDisplay_FormInput_langId_In_OrderItemAddForm_1"/>
	<input type="hidden" name="storeId" value="<c:out value="${WCParam.storeId}" />" id="WC_CachedPackageDisplay_FormInput_storeId_In_OrderItemAddForm_1"/>
	<input type="hidden" name="catalogId" value="<c:out value="${WCParam.catalogId}" />" id="WC_CachedPackageDisplay_FormInput_catalogId_In_OrderItemAddForm_1"/>
	<input type="hidden" name="URL" value="AjaxOrderItemDisplayView" id="WC_CachedPackageDisplay_FormInput_URL_In_OrderItemAddForm_1"/>
	<input type="hidden" name="errorViewName" value="InvalidInputErrorView" id="WC_CachedPackageDisplay_FormInput_errorViewName_In_OrderItemAddForm_1"/>
	<%-- shouldCachePage is used to tell the server not to cache this page.  So if an error happens, this page is redrawn with an error message --%>
	<input type="hidden" name="shouldCachePage" value="false" id="WC_CachedPackageDisplay_FormInput_shouldCachePage_In_OrderItemAddForm_1"/>
	<input type="hidden" name="catEntryIDS" value="<c:out value='${someItemIDs}'/>" id="WC_CachedBundleDisplay_inputs_1"/>
	<input type="hidden" name="productId" value="<c:out value="${bundle.bundleID}" />" id="WC_CachedBundleDisplay_FormInput_productId_In_OrderItemAddForm_1"/>
	<input type="hidden" name="page" value="" id="WC_CachedPackageDisplay_FormInput_page_In_OrderItemAddForm_1"/>
	<input type="hidden" name="calculationUsage" value="-1,-2,-3,-4,-5,-6,-7" id="WC_CachedBundleDisplay_FormInput_calcUsage_In_OrderItemAddForm_1"/>
	<input type="hidden" name="updateable" value="0" id="WC_CachedBundleDisplay_FormInput_updateable_In_OrderItemAddForm_1"/>
			<div class="product_images" id="WC_CachedBundleDisplay_div_1">
				<c:if test="${addProductDnD eq 'true'}">
					<div dojoType="dojo.dnd.Source" jsId="dndSource" id="<c:out value='${bundle.bundleID}'/>" copyOnly="true" dndType="<c:out value='${dragType}'/>">
						<div class="dojoDndItem" dndType="<c:out value='${dragType}'/>" id="WC_CachedBundleDisplay_div_2">
				</c:if>
				<span class="product">
				<c:choose>
					<c:when test="${!empty bundle.description.fullImage}">
						<c:if test="${addProductDnD eq 'true'}">
							<!--[if lte IE 6.5]><iframe class="productPageDnDIFrame" scrolling="no" frameborder="0" src="<c:out value="${jspStoreImgDir}" />images/empty.gif"></iframe><![endif]-->
						</c:if>
						<img id="productMainImage"
							src="<c:out value="${bundle.objectPath}${bundle.description.fullImage}" />"
							alt="<c:out value="${bundle.description.shortDescription}" />"
							border="0" width="160" height="160"/>
					</c:when>
					<c:otherwise>
						<c:if test="${addProductDnD eq 'true'}">
							<!--[if lte IE 6.5]><iframe class="productPageDnDIFrame" scrolling="no" frameborder="0" src="<c:out value="${jspStoreImgDir}" />images/empty.gif"></iframe><![endif]-->
						</c:if>
						<img id="productMainImage"
							src="<c:out value="${jspStoreImgDir}" />images/NoImageIcon.jpg"
							alt="<fmt:message key="No_Image" bundle="${storeText}"/>"
							border="0" width="160" height="160"/>
					</c:otherwise>
				</c:choose>
				</span>
				<c:if test="${addProductDnD eq 'true'}">
						</div>
					</div>
					<script type="text/javascript">
						dojo.addOnLoad(function() { 
						var widgetText = "<c:out value="${bundle.bundleID}"/>";
						parseWidget(widgetText);
						});
					</script>
				</c:if>
				
			<c:set property="attachmentUsage" value="IMAGE_SIZE_40" target="${bundle}" />
			<c:set var="image40AttachmentDataBeans" value="${bundle.attachmentsByUsage}" />
			<c:choose>
			 		<c:when test="${!empty image40AttachmentDataBeans[0]}">
						<c:set var="productCompareImagePath" value="${image40AttachmentDataBeans[0].objectPath}${image40AttachmentDataBeans[0].path}" />
			 		</c:when>
					<c:when test="${!empty bundle.description.thumbNail}">
						<c:set var="productCompareImagePath" value="${bundle.objectPath}${bundle.description.thumbNail}" />
					</c:when>
					<c:otherwise>
						<c:set var="productCompareImagePath" value="${jspStoreImgDir}images/NoImageIcon_sm45.jpg" />
					</c:otherwise>
			 </c:choose>
			<c:set var="compareImageDescription" value="${fn:replace(bundle.description.shortDescription, search, replaceCmprStr)}"/>
			<c:set var="compareImageDescription" value="${fn:replace(compareImageDescription, search01, replaceCmprStr)}"/>
			 <input type="hidden" id="compareImgPath_<c:out value='${bundle.bundleID}'/>" value="<c:out value='${productCompareImagePath}'/>"/>
			 <input type="hidden" id="compareImgDescription_<c:out value='${bundle.bundleID}'/>" value="<c:out value='${compareImageDescription}'/>"/>
			 <input type="hidden" id="compareProductDetailsPath_<c:out value='${bundle.bundleID}'/>" value="<c:out value='${catEntryDisplayUrl}'/>"/>
			<br />
		
			<%-- 
			  ***
				*	Start: Product angle images
				* Product angle images are loaded as attachments. Expected to have 2 sets loaded as 'ANGLEIMAGES_THUMBNAIL' and 'ANGLEIMAGES_FULLIMAGE'
				* attachment usages.
				***
			--%>
			<c:set property="attachmentUsage" value="ANGLEIMAGES_THUMBNAIL" target="${bundle}" />
			<c:set var="angleThumbAttachmentDataBeans" value="${bundle.attachmentsByUsage}" />
			<c:if test="${!empty angleThumbAttachmentDataBeans}">
				<c:set property="attachmentUsage" value="ANGLEIMAGES_FULLIMAGE" target="${bundle}" />
				<c:set var="angleFImageAttachmentDataBeans" value="${bundle.attachmentsByUsage}" />
				<span class="angles">
				<c:forEach var="attachmentDB" items="${angleThumbAttachmentDataBeans}" varStatus="aStatus">
					<c:choose>
						<c:when test="${aStatus.first}">
							<a id="WC_CachedBundleDisplay_links_1_<c:out value='${aStatus.count}'/>" href="JavaScript:changeThumbNail('productAngleImg<c:out value='${aStatus.index}'/>','<c:out value="${angleFImageAttachmentDataBeans[aStatus.index].objectPath}${angleFImageAttachmentDataBeans[aStatus.index].path}"/>');"><img id="productAngleImg<c:out value='${aStatus.index}'/>" src="<c:out value="${attachmentDB.objectPath}${attachmentDB.path}"/>" alt="<c:out value="${attachmentDB.shortDescription}"/>" class="on" /></a>
						</c:when>
						<c:otherwise>
							<a id="WC_CachedBundleDisplay_links_2_<c:out value='${aStatus.count}'/>" href="JavaScript:changeThumbNail('productAngleImg<c:out value='${aStatus.index}'/>','<c:out value="${angleFImageAttachmentDataBeans[aStatus.index].objectPath}${angleFImageAttachmentDataBeans[aStatus.index].path}"/>');"><img id="productAngleImg<c:out value='${aStatus.index}'/>" src="<c:out value="${attachmentDB.objectPath}${attachmentDB.path}"/>" alt="<c:out value="${attachmentDB.shortDescription}"/>" class="off" /></a>
						</c:otherwise>
					</c:choose>
				</c:forEach>
				</span><br />
			</c:if>
			<%-- 
			  ***
				*	End: Product angle images
				***
			--%>
				
				<%@ include file="CachedBundleImageExt.jspf"%>
			</div>
			<div class="product_options" id="WC_CachedBundleDisplay_div_3">
				 <h1 class="catalog_link"><c:out value="${bundle.description.name}" escapeXml="false"/></h1>
				 
				<%-- 
				  ***
				  *	Start: Descount details
				  ***
				--%>

				<div id="WC_CachedBundleDisplay_div_4">
					<wcbase:useBean id="discounts" classname="com.ibm.commerce.fulfillment.beans.CalculationCodeListDataBean" scope="page">
						<c:set property="catalogEntryId" value="${productId}" target="${discounts}" />
						<c:set property="includeParentProduct" value="true" target="${discounts}" />
						<c:set property="includeChildItems" value="true" target="${discounts}"/>
						
						<%-- UsageId for discount is -1 --%>
						<c:set property="calculationUsageId" value="-1" target="${discounts}" />
					</wcbase:useBean>
					<c:if test="${ !empty discounts.calculationCodeDataBeans }" >
						<c:forEach var="discountEntry" items="${discounts.calculationCodeDataBeans}" varStatus="discountCounter">
							<c:set var="hasDiscount" value="true"/>
							<c:url var="DiscountDetailsDisplayViewURL" value="DiscountDetailsDisplayView">
								<c:param name="code" value="${discountEntry.code}" />
								<c:param name="langId" value="${langId}" />
								<c:param name="storeId" value="${WCParam.storeId}" />
								<c:param name="catalogId" value="${WCParam.catalogId}" />
							</c:url>
							<a class="discount" href="<c:out value='${DiscountDetailsDisplayViewURL}' />" id="WC_CachedBundleDiscount_Link_1_<c:out value="${discountCounter.count}"/>_<c:out value="${catEntryIdentifier}"/>"><c:out value="${discountEntry.descriptionString}" escapeXml="false" /></a>									
						</c:forEach>
					</c:if>
				</div>
				<%-- 
				  ***
				  *	End: Descount details
				  ***
				--%>
				
			<%-- 
			  ***
				*	Start: Page action buttons
				***
			--%>
				 <br />
				<c:choose>
					<c:when test="${bundle.buyable != 0 || alwaysShowAddToCart}" >
						<flow:ifEnabled feature="AjaxAddToCart"> 
						 <p>
							<span class="primary_button button_fit" >
								<span class="button_container">
									<span class="button_bg">
										<span class="button_top">
											<span class="button_bottom">   
												<a href="javascript:setCurrentId('bundlePageAdd2CartAjax'); categoryDisplayJS.AddBundle2ShopCartAjax(document.getElementById('OrderItemAddForm_<c:out value='${bundle.bundleID}'/>'))" id="bundlePageAdd2CartAjax"><fmt:message key="PRODUCT_ADD_TO_CART" bundle="${storeText}" /></a>
											</span>
										</span>	
									</span>
								</span>
							</span>	
						  </p>
							<br />
							 <div class="features" id="WC_CachedBundleDisplay_div_7">
								<flow:ifEnabled feature="ProductCompare">
									<p><a id="WC_CachedBundleDisplay_links_4" href="JavaScript:categoryDisplayJS.Add2CompareAjax('<c:out value='${bundle.bundleID}'/>','<c:out value='${productCompareImagePath}'/>', '<c:out value='${catEntryDisplayUrl}'/>','<c:out value='${compareImageDescription}'/>');"><img src="<c:out value='${jspStoreImgDir}${vfileColor}/i_add_wishlist.png'/>" alt="<fmt:message key="ADDTOCOMPARE" bundle="${storeText}" />" /><fmt:message key="ADDTOCOMPARE" bundle="${storeText}" /></a></p>
								</flow:ifEnabled>
								<flow:ifEnabled  feature="wishList">
									<p><a id="WC_CachedBundleDisplay_links_5" href="javascript: setCurrentId('WC_CachedBundleDisplay_links_5'); categoryDisplayJS.AddBundle2WishListAjax(document.getElementById('OrderItemAddForm_<c:out value='${bundle.bundleID}'/>'))"><img src="<c:out value='${jspStoreImgDir}${vfileColor}/i_add_wishlist.png'/>" alt="<fmt:message key="WISHLIST" bundle="${storeText}" />" /><fmt:message key="WISHLIST" bundle="${storeText}" /> </a></p>
								</flow:ifEnabled>
								<flow:ifEnabled feature="RequisitionList">
									<c:set var="type" value="bundle" />
									<%@include file="../../../ShoppingArea/OrderCreationSection/RequisitionListSubsection/RequisitionListLinks.jspf" %>
								</flow:ifEnabled>								
							 </div>
						</flow:ifEnabled>
						
						<flow:ifDisabled feature="AjaxAddToCart">
							<p>
								<span class="primary_button button_fit" >
									<span class="button_container">
										<span class="button_bg">
											<span class="button_top">
												<span class="button_bottom">   
													<a href="#" onclick="javascript:setCurrentId('bundlePageAdd2Cart'); categoryDisplayJS.AddBundle2ShopCart(document.getElementById('OrderItemAddForm_<c:out value='${bundle.bundleID}'/>'));return false;" id="bundlePageAdd2Cart"><fmt:message key="PRODUCT_ADD_TO_CART" bundle="${storeText}" /></a>
												</span>
											</span>	
										</span>
									</span>
								</span>
							  </p>
								<br />
								<div class="features" id="WC_CachedBundleDisplay_div_10">
									<flow:ifEnabled feature="ProductCompare">
										<p><a id="WC_CachedBundleDisplay_links_7" href="JavaScript:categoryDisplayJS.Add2CompareAjax('<c:out value='${bundle.bundleID}'/>','<c:out value='${productCompareImagePath}'/>', '<c:out value='${catEntryDisplayUrl}'/>','<c:out value='${compareImageDescription}'/>');"><img src="<c:out value='${jspStoreImgDir}${vfileColor}/i_add_wishlist.png'/>" alt="<fmt:message key="ADDTOCOMPARE" bundle="${storeText}" />" /><fmt:message key="ADDTOCOMPARE" bundle="${storeText}" /></a></p>
									</flow:ifEnabled>
									<flow:ifEnabled  feature="wishList">
										<p><a id="WC_CachedBundleDisplay_links_8" href="#" onclick="javascript: setCurrentId('WC_CachedBundleDisplay_links_8'); categoryDisplayJS.AddBundle2WishList(document.getElementById('OrderItemAddForm_<c:out value='${bundle.bundleID}'/>'));return false;"><img src="<c:out value='${jspStoreImgDir}${vfileColor}/i_add_wishlist.png'/>" alt="<fmt:message key="WISHLIST" bundle="${storeText}" />" /><fmt:message key="WISHLIST" bundle="${storeText}" /> </a></p>
									</flow:ifEnabled>
									<flow:ifEnabled feature="RequisitionList">
										<c:set var="type" value="bundle" />
										<%@include file="../../../ShoppingArea/OrderCreationSection/RequisitionListSubsection/RequisitionListLinks.jspf" %>
									</flow:ifEnabled>										
								</div>
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
												<a href="<c:out value="${TopCategoriesDisplayURL}" />" id="WC_CachedBundleDisplay_links_9"><fmt:message key="RETURN_SHOPPING" bundle="${storeText}" /></a>
											</span>
										</span>	
									</span>
								</span>
							</span>
						</p>
					</c:otherwise>
				</c:choose>
				<%@ include file="CachedBundleButtonExt.jspf"%>
			<%-- 
			  ***
				*	End: Page action buttons
				***
			--%>
			</div>
			<br />
			<br clear="all" />
			
			<%-- 
			  ***
			  *	Start: List the information of the items that compose the bundle
			  ***
			--%>
			<div id="WC_CachedBundleDisplay_div_13">
			<c:forEach var="compositeItem" items="${bundle.bundledItems}" varStatus="iStatus">
				<c:url var="ItemDisplayURL" value="ProductDisplay">
					<c:param name="productId" value="${compositeItem.item.itemID}" />
					<c:param name="langId" value="${langId}" />
					<c:param name="storeId" value="${WCParam.storeId}" />
					<c:param name="catalogId" value="${WCParam.catalogId}" />
					<c:if test="${ !empty WCParam.parent_category_rn }" >
						<c:param name="parent_category_rn" value="${WCParam.parent_category_rn}" />
					</c:if>
				</c:url>
				<c:set var="catalogEntryDB" value="${compositeItem.item}"/>
				<p>
					<span style="padding-top:5px;font-size: 9pt;font-weight:bold;">
						<fmt:message key="ITEM_TITLE1" bundle="${storeText}"/> <c:out value="${catalogEntryDB.description.name}" escapeXml="false"/>
					</span>
				</p>
				<p>
					<table id="WC_CachedBundleDisplay_table_1_<c:out value='${iStatus.count}'/>">
						<tr>
							<td id="WC_CachedBundleDisplay_td_1_<c:out value='${iStatus.count}'/>">
								<c:choose>
									<c:when test="${!empty catalogEntryDB.description.thumbNail}">
									<a href="<c:out value="${ItemDisplayURL}" escapeXml="false"/>" id="WC_CachedBundleDisplay_links_10_<c:out value='${iStatus.count}'/>">
									<img src="<c:out value="${hostPath}"/><c:out value="${catalogEntryDB.objectPath}${catalogEntryDB.description.thumbNail}"/>" alt="<c:out value="${catalogEntryDB.description.shortDescription}" />" border="0" width="70" height="70"/>
									</a>
									</c:when>
									<c:otherwise>
									<a href="<c:out value="${ItemDisplayURL}" escapeXml="false"/>" id="WC_CachedBundleDisplay_links_11_<c:out value='${iStatus.count}'/>">
									<img src="<c:out value="${hostPath}"/><c:out value="${jspStoreImgDir}" />images/NoImageIcon_sm.jpg" alt="<fmt:message key="No_Image" bundle="${storeText}"/>" border="0" width="70" height="70"/>
									</a>
									</c:otherwise>
								</c:choose>
							</td>
							<td id="WC_CachedBundleDisplay_td_2_<c:out value='${iStatus.count}'/>">
								<c:out value="${catalogEntryDB.description.longDescription}" escapeXml="false" />
								<br />
								<span style="font-weight: bold;font-size: 8pt;"><fmt:message key="SKU" bundle="${storeText}" />:</span>
								<span style="font-weight: normal;font-size: 8pt;"><c:out value="${catalogEntryDB.partNumber}" /></span>
								<br />
								
								<c:set var="type" value="item"/>
								<c:set var="fromPage" value="bundleDisplayItem"/>						
								<c:if test="${displayListPriceInProductPage == 'true'}">
									<span style="padding: 5px 20px 0px 0px;">
										<%@ include file="../../../Snippets/ReusableObjects/CatalogEntryPriceDisplay.jspf"%>
									</span>
								</c:if>
								<%@ include file="B2BCatentryContractSelectExt.jspf"%>
								<%out.flush();%>
								<c:import url="${jspStoreDir}Snippets/Catalog/CatalogEntryDisplay/CatalogEntryInventoryStatus.jsp">
									<c:param name="fromPage" value="${fromPage}"/>
									<c:param name="catentryId" value="${compositeItem.item.itemID}"/>
								</c:import>
								<%out.flush();%>
								<%@ include file="CatalogEntryInventoryStatusEIExt.jspf"%>
								<br />
								<script type="text/javascript">
									document.write(Discount.getItemDiscountText(<c:out value="${catalogEntryDB.itemID}"/>));
								</script>
							</td>
							<td id="WC_CachedBundleDisplay_td_3_<c:out value='${iStatus.count}'/>">
								<span style="font-weight: bold;font-size: 8pt;white-space: nowrap;"><label for="quantity_<c:out value='${catalogEntryDB.itemID}'/>"><fmt:message key="CurrentOrder_QTY" bundle="${storeText}"/></label></span>
							</td>
							<td id="WC_CachedBundleDisplay_td_4_<c:out value='${iStatus.count}'/>">
								<input type="hidden" name="partNumber_<c:out value="${iStatus.count}"/>" value="<c:out value="${catalogEntryDB.partNumber}" />" id="WC_CachedBundleDisplay_FormInput_partNumber_<c:out value='${iStatus.count}'/>_In_OrderItemAddForm_1"/>
								<input type="text" name="quantity_<c:out value='${iStatus.count}'/>" id="quantity_<c:out value='${catalogEntryDB.itemID}'/>" size="1" value="<c:out value='${compositeItem.formattedQuantity}'/>" style="height:15px; text-align: center; border: 1px solid #908D94"/>
								<input type="hidden" name="catEntryId_<c:out value='${iStatus.count}'/>" value="<c:out value='${catalogEntryDB.itemID}'/>" id="catEntryId_<c:out value='${catalogEntryDB.itemID}'/>"/>
								<input type="hidden" name="contractId_<c:out value='${iStatus.count}'/>" value="" id="contractId_<c:out value='${catalogEntryDB.itemID}'/>"/>
							</td>
						</tr>
					</table>
				</p>
				<br />
				<c:set var="runningCountInLoop" value="${iStatus.count}" />
			</c:forEach>

			<%-- 
			  ***
			  *	End: List the information of the items that compose the bundle
			  ***
			--%>
			
			<%-- 
			  ***
			  *	Start: List the information of the products that compose the bundle
			  ***
			--%>
			<c:set var="numberOfProduct" value="${runningCountInLoop}" />
			<c:forEach var="compositeProduct" items="${bundle.bundledProducts}" varStatus="iStatus">
					<c:url var="ProductDisplayURL" value="ProductDisplay">
						<c:param name="productId" value="${compositeProduct.product.productID}" />
						<c:param name="langId" value="${langId}" />
						<c:param name="storeId" value="${WCParam.storeId}" />
						<c:param name="catalogId" value="${WCParam.catalogId}" />
						<c:if test="${ !empty WCParam.parent_category_rn }" >
							<c:param name="parent_category_rn" value="${WCParam.parent_category_rn}" />
						</c:if>
					</c:url>
					<c:set var="catalogEntryDB" value="${compositeProduct.product}"/>
					<c:set var="items1" value="${compositeProduct.product.entitledItems}"/>
					<c:set var="numberOfSKUs" value="${fn:length(items1)}"/>
					<p>
					<span style="padding-top:5px;font-size: 9pt;font-weight:bold;">
					<c:out value="${catalogEntryDB.description.name}" escapeXml="false"/>
					</span>
					</p>
					
					<p>
						<table id="WC_CachedBundleDisplay_table_2_<c:out value='${iStatus.count}'/>">
							<tr>
								<td id="WC_CachedBundleDisplay_td_5_<c:out value='${iStatus.count}'/>">
									<c:choose>
									<c:when test="${!empty catalogEntryDB.description.thumbNail}">
									<a href="<c:out value="${ProductDisplayURL}" escapeXml="false"/>" id="WC_CachedBundleDisplay_links_12_<c:out value='${iStatus.count}'/>">
										<img src="<c:out value="${hostPath}"/><c:out value="${catalogEntryDB.objectPath}${catalogEntryDB.description.thumbNail}"/>" alt="<c:out value="${catalogEntryDB.description.shortDescription}" />" border="0"/>
									</a>
									</c:when>
									<c:otherwise>
									<a href="<c:out value="${ProductDisplayURL}" escapeXml="false"/>" id="WC_CachedBundleDisplay_links_13_<c:out value='${iStatus.count}'/>">
									<img src="<c:out value="${hostPath}"/><c:out value="${jspStoreImgDir}" />images/NoImageIcon_sm.jpg" alt="<fmt:message key="No_Image" bundle="${storeText}"/>" border="0"/>
									</a>
									</c:otherwise>
									</c:choose>
								</td>
								<td id="WC_CachedBundleDisplay_td_6_<c:out value='${iStatus.count}'/>">
									<c:out value="${catalogEntryDB.description.longDescription}" escapeXml="false" />
									<br />
									<c:set var="type" value="product"/>
									<c:set var="fromPage" value="bundleDisplayProduct"/>
									<c:if test="${displayListPriceInProductPage == 'true'}">
										<span style="padding: 5px 20px 0px 0px;">
											<%@ include file="../../../Snippets/ReusableObjects/CatalogEntryPriceDisplay.jspf"%>
										</span>
									</c:if>
									<br />
									<script type="text/javascript">
										document.write(Discount.getProductDiscountText(<c:out value="${catalogEntryDB.productID}"/>));
									</script>
									<br />
									
									<fmt:message key="PRODUCT_ATTRIBUTES" bundle="${storeText}" />
									<%-- 
									  ***
									  *	Start: Defining Attributes
									  * The drop down box will only display defining attributes.
									  * Defining attributes are properties of SKUs.  They are used for SKU resolution.
									  ***
									--%>
									<c:choose>
										<c:when test="${numberOfSKUs == 1}">
											<wcf:getData type="com.ibm.commerce.catalog.facade.datatypes.CatalogEntryType" var="catentry" expressionBuilder="getStoreCatalogEntryAttributesByID">
												<wcf:contextData name="storeId" data="${param.storeId}"/>
												<wcf:param name="catEntryId" value="${compositeProduct.product.entitledItems[0].itemID}"/>
												<wcf:param name="dataLanguageIds" value="${WCParam.langId}"/>
											</wcf:getData>
											<c:forEach var="attribute" items="${catentry.catalogEntryAttributes.attributes}" varStatus="aStatus">
												<c:if test="${attribute.usage == 'Defining'}">
													<p><c:out value="${fn:replace(attribute.name, search01, replaceStr01)}"/>: <c:out value="${fn:replace(attribute.value.value, search01, replaceStr01)}" />
														<!-- Register the attribute with categoryDisplayJS !-->
														<script type="text/javascript">
															categoryDisplayJS.setSelectedAttributeOfProduct("<c:out value='${catalogEntryDB.productID}'/>","<c:out value='${fn:replace(attribute.name, search01, replaceStr01)}'/>","<c:out value='${fn:replace(attribute.value.value, search01, replaceStr01)}' />");
														</script>
													</p>
												</c:if>
											</c:forEach>
										</c:when>
										<c:otherwise>
											<wcf:getData type="com.ibm.commerce.catalog.facade.datatypes.CatalogEntryType" var="catentry" expressionBuilder="getStoreCatalogEntryAttributesByID">
												<wcf:contextData name="storeId" data="${param.storeId}"/>
												<wcf:param name="catEntryId" value="${catalogEntryDB.productID}"/>
												<wcf:param name="dataLanguageIds" value="${WCParam.langId}"/>
											</wcf:getData>
					 						<%-- the drop down box will only display defining attributes --%>
					 						<c:forEach var="attribute" items="${catentry.catalogEntryAttributes.attributes}" varStatus="aStatus">
												<c:if test="${attribute.usage == 'Defining'}">
													<div class="attribute_list">
														<span class="required">*</span><c:out value="${fn:replace(attribute.name, search01, replaceStr01)}"/>:
														<p>
														<label for="attrValue_<c:out value='${aStatus.count}'/>" class="nodisplay"><c:out value='${attribute.name}'/><fmt:message key='Checkout_ACCE_required' bundle='${storeText}'/></label>
														<select class="drop_down" id="attrValue_<c:out value='${aStatus.count}'/>" name="attrValue" 
																onChange='JavaScript:categoryDisplayJS.setSelectedAttributeOfProduct("<c:out value='${catalogEntryDB.productID}'/>","<c:out value='${fn:replace(attribute.name, search01, replaceStr01)}'/>",this.options[this.selectedIndex].value);'>
															<%-- Display the first option in the drop down as: Select Attribute.Name --%>
															<option value="">
																	<fmt:message key="QuickInfo_Select" bundle="${storeText}"/>
															</option>
															<!-- Display product attribute values !-->
															<c:forEach var="allowedValue" items="${attribute.allowedValue}">
																<%-- Reselect the attribute values the user selected, or select nothing if not selected. 
																	 We rely on HTTP to preserve the order of the attributes submitted.  --%>
																<c:choose>
																	<c:when test="${WCParamValues.attrValue[aStatus.count-1] == allowedValue.value}">
																		<option selected="selected"><c:out value="${fn:replace(allowedValue.value, search01, replaceStr01)}" /></option>
																	</c:when>
																	<c:otherwise>
																		<option value="<c:out value="${fn:replace(allowedValue.value, search01, replaceStr01)}" />"><c:out value="${fn:replace(allowedValue.value, search01, replaceStr01)}" /></option>
																	</c:otherwise>
																</c:choose>
															</c:forEach>
														</select>
														<!-- Register the attribute with categoryDisplayJS !-->
														<script type="text/javascript">
															var selectBoxNode = dojo.byId("attrValue_<c:out value='${aStatus.count}'/>");
															categoryDisplayJS.setSelectedAttributeOfProduct("<c:out value='${catalogEntryDB.productID}'/>","<c:out value='${fn:replace(attribute.name, search01, replaceStr01)}'/>",selectBoxNode.options[selectBoxNode.selectedIndex].value);
														</script>
														</p>
													</div>
												</c:if>
										 	</c:forEach>
										</c:otherwise>
									</c:choose>
									<%-- 
									  ***
									  *	End: Defining Attributes
									  ***
									--%>
									
									<c:if test="${numberOfSKUs == 1}">
										<c:set var="forInventoryCatentryId" value="${compositeProduct.product.entitledItems[0].itemID}"/>
									</c:if>
									
									<%@ include file="B2BCatentryContractSelectExt.jspf"%>	
									<%out.flush();%>
									<c:import url="${jspStoreDir}Snippets/Catalog/CatalogEntryDisplay/CatalogEntryInventoryStatus.jsp">
										<c:param name="fromPage" value="${fromPage}"/>
										<c:param name="catalogEntryID" value="${compositeProduct.product.productID}"/>
										<c:param name="catentryId" value="${forInventoryCatentryId}"/>
										<c:param name="numberOfSKUs" value="${numberOfSKUs}"/>
									</c:import>
									<%out.flush();%>

								</td>
								<td id="WC_CachedBundleDisplay_td_7_<c:out value='${iStatus.count}'/>">
									<span style="font-weight: bold;font-size: 8pt;white-space: nowrap;"><label for="quantity_<c:out value='${catalogEntryDB.productID}'/>"><fmt:message key="CurrentOrder_QTY" bundle="${storeText}"/></label></span>
								</td>
								<td id="WC_CachedBundleDisplay_td_8_<c:out value='${iStatus.count}'/>">
									<input type="text" name="quantity_<c:out value='${numberOfProduct + iStatus.count}'/>" id="quantity_<c:out value='${catalogEntryDB.productID}'/>" size="1" value="<c:out value='${compositeProduct.formattedQuantity}'/>" style="height:15px; text-align: center; border: 1px solid #908D94"/>
									<input type="hidden" name="catEntryId_<c:out value='${numberOfProduct + iStatus.count}'/>" value="<c:out value='${catalogEntryDB.productID}'/>" id="catEntryId_<c:out value='${catalogEntryDB.productID}'/>"/>
									<input type="hidden" name="contractId_<c:out value='${numberOfProduct + iStatus.count}'/>" value="" id="contractId_<c:out value='${catalogEntryDB.productID}'/>"/>
								</td>
							</tr>
						</table>
					</p>
					<c:set var="runningCountInLoop" value="${numberOfProduct + iStatus.count}" />
			</c:forEach>


			<%-- 
			  ***
			  *	End: List the information of the products that compose the bundle
			  ***
			--%>
			<%-- 
			  ***
			  *	Start: List the information of the packages that compose the bundle
			  ***
			--%>
			<c:set var="numberOfProduct" value="${runningCountInLoop}" />
			<c:forEach var="compositePackage" items="${bundle.bundledPackages}" varStatus="iStatus">
				<c:url var="PackageDisplayURL" value="ProductDisplay">
					<c:param name="productId" value="${compositePackage.package.packageID}" />
					<c:param name="langId" value="${langId}" />
					<c:param name="storeId" value="${WCParam.storeId}" />
					<c:param name="catalogId" value="${WCParam.catalogId}" />
					<c:if test="${ !empty WCParam.parent_category_rn }" >
						<c:param name="parent_category_rn" value="${WCParam.parent_category_rn}" />
					</c:if>
				</c:url>
				<c:set var="catalogEntryDB" value="${compositePackage.package}"/>
					
				<p>
					<span style="padding-top:5px;font-size: 9pt;font-weight:bold;">
					<c:out value="${catalogEntryDB.description.name}" escapeXml="false"/>
					</span>
				</p>
				<p>
					<table id="WC_CachedBundleDisplay_table_3_<c:out value='${iStatus.count}'/>">
						<tr>
							<td id="WC_CachedBundleDisplay_td_9_<c:out value='${iStatus.count}'/>">
					
								<c:choose>
								<c:when test="${!empty catalogEntryDB.description.thumbNail}">
									<a href="<c:out value="${ItemDisplayURL}" escapeXml="false"/>" id="WC_CachedBundleDisplay_links_14_<c:out value='${iStatus.count}'/>">
										<img src="<c:out value="${hostPath}"/><c:out value="${catalogEntryDB.objectPath}${catalogEntryDB.description.thumbNail}"/>" alt="<c:out value="${catalogEntryDB.description.shortDescription}" />" border="0"/>
									</a>
								</c:when>
								<c:otherwise>
									<a href="<c:out value="${ItemDisplayURL}" escapeXml="false"/>" id="WC_CachedBundleDisplay_links_15_<c:out value='${iStatus.count}'/>">
									<img src="<c:out value="${hostPath}"/><c:out value="${jspStoreImgDir}" />images/NoImageIcon_sm.jpg" alt="<fmt:message key="No_Image" bundle="${storeText}"/>" border="0"/>
									</a>
								</c:otherwise>
								</c:choose>
							</td>
							<td id="WC_CachedBundleDisplay_td_10_<c:out value='${iStatus.count}'/>">
								<c:out value="${catalogEntryDB.description.longDescription}" escapeXml="false" />
								<br />
								<c:set var="type" value="package"/>
								<c:if test="${displayListPriceInProductPage == 'true'}">
									<span style="padding: 5px 20px 0px 0px;">								
									<%@ include file="../../../Snippets/ReusableObjects/CatalogEntryPriceDisplay.jspf"%>
									</span>
								</c:if>
								<br />
								<script type="text/javascript">
									document.write(Discount.getPackageDiscountText(<c:out value="${catalogEntryDB.packageID}"/>));
								</script>
								<br />
							</td>
							<td id="WC_CachedBundleDisplay_td_11_<c:out value='${iStatus.count}'/>">
								<span style="font-weight: bold;font-size: 8pt;white-space: nowrap;"><label for="quantity_<c:out value='${catalogEntryDB.packageID}'/>"><fmt:message key="CurrentOrder_QTY" bundle="${storeText}"/></label></span>
							</td>
							<td id="WC_CachedBundleDisplay_td_12_<c:out value='${iStatus.count}'/>">
								<input type="hidden" name="partNumber_<c:out value="${numberOfProduct + iStatus.count}"/>" value="<c:out value="${catalogEntryDB.partNumber}" />" id="WC_CachedBundleDisplay_FormInput_partNumber_<c:out value='${numberOfProduct + iStatus.count}'/>_In_OrderItemAddForm_1"/>
								<input type="text" name="quantity_<c:out value='${numberOfProduct + iStatus.count}'/>" id="quantity_<c:out value='${catalogEntryDB.packageID}'/>" size="1" value="<c:out value='${compositePackage.formattedQuantity}'/>" style="height:15px; text-align: center; border: 1px solid #908D94"/>
								<input type="hidden" name="catEntryId_<c:out value='${numberOfProduct + iStatus.count}'/>" value="<c:out value='${catalogEntryDB.packageID}'/>" id="catEntryId_<c:out value='${catalogEntryDB.packageID}'/>"/>
								<input type="hidden" name="contractId_<c:out value='${numberOfProduct + iStatus.count}'/>" value="" id="contractId_<c:out value='${catalogEntryDB.packageID}'/>"/>
							</td>
						</tr>
				</table>
			</p>
			</c:forEach>
			</div>
			<br clear="all" />
			<%-- 
			  ***
			  *	End: List the information of the packages that compose the bundle
			  ***
			--%>
			<input type="hidden" name="numberOfProduct" id="numberOfProduct" value='<c:out value="${runningCountInLoop}"/>'/>
</form>
			<%-- 
							  ***
							  *	Start: Cross-Sell, Up-Sell, Accessory, Replacement
							  * Include MerchandisingAssociationsDisplay.jsp if Cross-Sell, Up-Sell, Accessory, Replacement are set up
							  ***
							--%>
							<%-- Flush the buffer so this fragment JSP is not cached twice --%>
							<%out.flush();%>
						        <c:import url="${jspStoreDir}Snippets/Catalog/MerchandisingAssociations/MerchandisingAssociationsDisplay.jsp">
				            			<c:param name="catalogEntryType" value="BundleBean"/>
				            			<c:param name="pageView" value="image"/>
				        		</c:import>
							<%out.flush();%>
							<%-- 
							  ***										  
							  *	End: Cross-Sell, Up-Sell, Accessory, Replacement
							  ***
							--%>		
			<br clear="all" />
			<script type="text/javascript">dojo.addOnLoad(function() { parseWidget("WC_CachedBundleDisplay_div_14"); });</script>
			<div class="specs" id="WC_CachedBundleDisplay_div_14">
				 <div class="tabs" id="WC_CachedBundleDisplay_div_15">
					<span class="on" id="Description_On" style="display:inline">
						<span class="left_corner">&nbsp;</span>
						<span class="text"><fmt:message key="DESCRIPTION" bundle="${storeText}" /></span>
						<span class="right_corner">&nbsp;</span>
					 </span>
					 <span class="off" id="Description_Off" style="display:none">
						<span class="left_corner">&nbsp;</span>
						<a href="javascript:selectTab('Description');" class="catalog_link" id="WC_CachedProductOnlyDisplay_links_6">
							<span class="text"><fmt:message key="DESCRIPTION" bundle="${storeText}"/></span>
						</a>
						<span class="right_corner">&nbsp;</span>
					 </span>
					 <span class="on" id="Attachments_On" style="display:none">
						<span class="left_corner">&nbsp;</span>
						<span class="text"><fmt:message key="ATTACHMENTS" bundle="${storeText}" /></span>
						<span class="right_corner">&nbsp;</span>
					 </span>
					 <span class="off" id="Attachments_Off" style="display:inline">
						<span class="left_corner">&nbsp;</span>
						<a href="javascript:selectTab('Attachments');" class="catalog_link" id="WC_CachedProductOnlyDisplay_links_7">
							<span class="text"><fmt:message key="ATTACHMENTS" bundle="${storeText}"/></span>
						</a>
						<span class="right_corner">&nbsp;</span>
					 </span>
					 <span class="end"></span>
					<%@ include file="CachedBundleTabsExt.jspf"%>
				 </div>
				 <br/>
				 <div id="mainTabContainer" class="info" dojoType="dijit.layout.TabContainer" selectedTab="Description" doLayout="false">
					  <div id="Description" dojoType="dijit.layout.ContentPane" >
					  	<p><c:out value="${bundle.description.shortDescription}" escapeXml="false"/></p><br />
							<p>
								<c:out value="${bundle.description.longDescription}" escapeXml="false"/>
							</p>
							<br />
							<%-- 
							  ***
							  *	Start: Descriptive Attributes
							  * Descriptive attributes are simply displayed as 'name:value'. They are not used for SKU resolution.
							  ***
							--%>
							<%-- The descriptive attributes of the bundle itself --%>
							<wcf:getData type="com.ibm.commerce.catalog.facade.datatypes.CatalogEntryType" var="catentry2" expressionBuilder="getStoreCatalogEntryAttributesByID">
								<wcf:contextData name="storeId" data="${param.storeId}"/>
								<wcf:param name="catEntryId" value="${bundle.bundleID}"/>
								<wcf:param name="dataLanguageIds" value="${WCParam.langId}"/>
		 					</wcf:getData>
		 					<p>
							<c:forEach var="attribute2" items="${catentry2.catalogEntryAttributes.attributes}">
								<c:if test="${ attribute2.usage=='Descriptive' }" >										
									<span class="productName"><c:out value="${attribute2.name}" escapeXml="false" />:</span>											
									<c:choose>
										<c:when test="${ !empty attribute2.extendedValue['Image1']  }" >
											<c:out value="${attribute2.value.value}" escapeXml="false" />&nbsp;<img src="<c:out value="${bundle.objectPath}${attribute2.extendedValue['Image1']}" />" alt="<c:out value="${attribute2.value.value}" />" border="0"/><br/>												
										</c:when>
										<c:otherwise >
											<c:out value="${attribute2.value.value}" escapeXml="false" />
										</c:otherwise>
									</c:choose>
									<br/>
								</c:if>
							</c:forEach>
							</p>
							<%-- 
							  ***
							  *	End: Descriptive Attributes
							  ***
							--%>
					  </div>
					 <div id="Attachments" href="<c:out value='${CatalogAttachmentURL}'/>" parseOnLoad="false" dojoType="dijit.layout.ContentPane" >
				  	 </div>
					  <%@ include file="CachedBundleTabPanesExt.jspf"%>
				 </div>
				 <div class="tabfooter" id="WC_CachedBundleDisplay_div_16"></div>
			</div>
	   </div>
	</div>
