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
<c:set var="search" value='"'/>
<c:set var="replaceCmprStr" value=""/>
<c:set var="search01" value="'"/>

<c:set var="buyable" value="true"/>
<c:set var="fromPage" value="packageDisplay"/>

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
<wcbase:useBean id="packageDataBean" classname="com.ibm.commerce.catalog.beans.PackageDataBean"  scope="request" />
<c:set var="dragType" value="package"/>

<wcf:url var="catEntryDisplayUrl" value="Product2">
	<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
	<wcf:param name="storeId" value="${WCParam.storeId}"/>
	<wcf:param name="productId" value="${packageDataBean.packageID}"/>
	<wcf:param name="langId" value="${WCParam.langId}"/>
	<wcf:param name="parent_category_rn" value="${WCParam.categoryId}"/>
	<wcf:param name="top_category" value="${WCParam.top_category}"/>
</wcf:url>

<wcf:url var="CatalogAttachmentURL" value="CatalogAttachmentView">
	<wcf:param name="storeId" value="${WCParam.storeId}"/>
	<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
	<wcf:param name="langId" value="${langId}"/>
	<wcf:param name="productId" value="${productId}"/>
	<wcf:param name="catType" value="package"/>
	<wcf:param name="excludeUsageStr" value="ANGLEIMAGES_THUMBNAIL,ANGLEIMAGES_FULLIMAGE,IMAGE_SIZE_55,IMAGE_SIZE_40"/>
	<wcf:param name="retrieveLanguageIndependentAtchAst" value="1"/>
</wcf:url>

<%-- 
***
* Determine if package is buyable.
***
--%>
<c:if test="${!packageDataBean.calculatedContractPriced || packageDataBean.buyable eq '0'}" >
	<c:set var="buyable" value="false"/>
</c:if>

<%-- 
***
* Start:  Get all product and item IDs displayed on this page and pass them to the discount code
***
--%>
	<%-- Create a comma delimited string containing all IDs to pass to the discount code.
		For an in depth explanation of why this is done, see DiscountJavaScriptSetup.jsp --%>
	<c:set var="someItemIDs" value="" />
	<c:forEach var="productInPackage" items="${packageDataBean.packagedProducts}" varStatus="status">
		<c:choose>
			<c:when test="${empty someItemIDs}">
				<c:set var="someItemIDs" value="${productInPackage.product.productID}" />
			</c:when>	
			<c:otherwise>
				<c:set var="someItemIDs" value="${someItemIDs},${productInPackage.product.productID}" />
			</c:otherwise>	
		</c:choose>
	</c:forEach>
	
	<c:forEach var="itemInPackage" items="${packageDataBean.packagedItems}" varStatus="iStatus">
		<c:choose>
			<c:when test="${empty someItemIDs}">
				<c:set var="someItemIDs" value="${itemInPackage.item.itemID}" />
			</c:when>	
			<c:otherwise>
				<c:set var="someItemIDs" value="${someItemIDs},${itemInPackage.item.itemID}" />
			</c:otherwise>	
		</c:choose>	
	</c:forEach>
	
	<c:forEach var="packageInPackage" items="${packageDataBean.packagedPackages}" varStatus="iStatus">
		<c:choose>
			<c:when test="${empty someItemIDs}">
				<c:set var="someItemIDs" value="${packageInPackage.package.packageID}" />
			</c:when>	
			<c:otherwise>
				<c:set var="someItemIDs" value="${someItemIDs},${packageInPackage.package.packageID}" />
			</c:otherwise>	
		</c:choose>	
	</c:forEach>
	
	<%-- Pass the IDs to the discount JavaScript --%>
	<%-- Flush the buffer so this fragment JSP is not cached twice --%>
	<%out.flush();%>
	<c:import url="${jspStoreDir}include/DiscountJavaScriptSetup.jsp">
		<c:param name="jsPrototypeName" value="Discount" />
		<c:param name="someProductIDs" value="${productId}"/>
		<c:param name="productIncludeChildItems" value="true"/>
		<c:param name="productIsProdPromoOnly" value="false"/>
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
		<div class="product_images" id="WC_CachedPackageDisplay_div_1">
			<c:if test="${addProductDnD eq 'true'}">
				<div dojoType="dojo.dnd.Source" jsId="dndSource" id="<c:out value='${packageDataBean.packageID}'/>" copyOnly="true" dndType="<c:out value='${dragType}'/>">
					<div class="dojoDndItem" dndType="<c:out value='${dragType}'/>" id="WC_CachedPackageDisplay_div_2">
			</c:if>
			<span class="product">
				<c:choose>
					<c:when test="${!empty packageDataBean.description.fullImage}">
						<c:if test="${addProductDnD eq 'true'}">
							<!--[if lte IE 6.5]><iframe class="productPageDnDIFrame" scrolling="no" frameborder="0" src="<c:out value="${jspStoreImgDir}" />images/empty.gif"></iframe><![endif]-->
						</c:if>
						<img id="productMainImage"
							src="<c:out value="${packageDataBean.objectPath}${packageDataBean.description.fullImage}" />"
							alt="<c:out value="${packageDataBean.description.shortDescription}" />"
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
					var widgetText = "<c:out value="${packageDataBean.packageID}"/>";
					parseWidget(widgetText);
				});
				</script>
			</c:if>
			
			<c:set property="attachmentUsage" value="IMAGE_SIZE_40" target="${packageDataBean}" />
			<c:set var="image40AttachmentDataBeans" value="${packageDataBean.attachmentsByUsage}" />
			<c:choose>
			 		<c:when test="${!empty image40AttachmentDataBeans[0]}">
						<c:set var="productCompareImagePath" value="${image40AttachmentDataBeans[0].objectPath}${image40AttachmentDataBeans[0].path}" />
			 		</c:when>
					<c:when test="${!empty packageDataBean.description.thumbNail}">
						<c:set var="productCompareImagePath" value="${packageDataBean.objectPath}${packageDataBean.description.thumbNail}" />
					</c:when>
					<c:otherwise>
						<c:set var="productCompareImagePath" value="${jspStoreImgDir}images/NoImageIcon_sm45.jpg" />
					</c:otherwise>
			 </c:choose>
			<c:set var="compareImageDescription" value="${fn:replace(packageDataBean.description.shortDescription, search, replaceCmprStr)}"/>
			<c:set var="compareImageDescription" value="${fn:replace(compareImageDescription, search01, replaceCmprStr)}"/>
			 <input type="hidden" id="compareImgPath_<c:out value='${packageDataBean.packageID}'/>" value="<c:out value='${productCompareImagePath}'/>"/>
			 <input type="hidden" id="compareImgDescription_<c:out value='${packageDataBean.packageID}'/>" value="<c:out value='${compareImageDescription}'/>"/>
			 <input type="hidden" id="compareProductDetailsPath_<c:out value='${packageDataBean.packageID}'/>" value="<c:out value='${catEntryDisplayUrl}'/>"/>
			<br />
		
			<%-- 
			  ***
				*	Start: Product angle images
				* Product angle images are loaded as attachments. Expected to have 2 sets loaded as 'ANGLEIMAGES_THUMBNAIL' and 'ANGLEIMAGES_FULLIMAGE'
				* attachment usages.
				***
			--%>
			<c:set property="attachmentUsage" value="ANGLEIMAGES_THUMBNAIL" target="${packageDataBean}" />
			<c:set var="angleThumbAttachmentDataBeans" value="${packageDataBean.attachmentsByUsage}" />
			<c:if test="${!empty angleThumbAttachmentDataBeans}">
				<c:set property="attachmentUsage" value="ANGLEIMAGES_FULLIMAGE" target="${packageDataBean}" />
				<c:set var="angleFImageAttachmentDataBeans" value="${packageDataBean.attachmentsByUsage}" />
				<span class="angles">
				<c:forEach var="attachmentDB" items="${angleThumbAttachmentDataBeans}" varStatus="aStatus">
					<c:choose>
						<c:when test="${aStatus.first}">
							<a id="WC_CachedPackageDisplay_links_1_<c:out value='${aStatus.count}'/>" href="JavaScript:changeThumbNail('productAngleImg<c:out value='${aStatus.index}'/>','<c:out value="${angleFImageAttachmentDataBeans[aStatus.index].objectPath}${angleFImageAttachmentDataBeans[aStatus.index].path}"/>');"><img id="productAngleImg<c:out value='${aStatus.index}'/>" src="<c:out value="${attachmentDB.objectPath}${attachmentDB.path}"/>" alt="<c:out value="${attachmentDB.shortDescription}"/>" class="on" /></a>
						</c:when>
						<c:otherwise>
							<a id="WC_CachedPackageDisplay_links_2_<c:out value='${aStatus.count}'/>" href="JavaScript:changeThumbNail('productAngleImg<c:out value='${aStatus.index}'/>','<c:out value="${angleFImageAttachmentDataBeans[aStatus.index].objectPath}${angleFImageAttachmentDataBeans[aStatus.index].path}"/>');"><img id="productAngleImg<c:out value='${aStatus.index}'/>" src="<c:out value="${attachmentDB.objectPath}${attachmentDB.path}"/>" alt="<c:out value="${attachmentDB.shortDescription}"/>" class="off" /></a>
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
			<%@ include file="CachedPackageImageExt.jspf"%>
		</div>
		<div class="product_options" id="WC_CachedPackageDisplay_div_3">
			 <h1 class="catalog_link"><c:out value="${packageDataBean.description.name}" escapeXml="false"/></h1>
			 
			 <%-- in Elite, we do not want to show the price because the price may be different depending on the 
			 contract that is selected --%>
			 <c:if test="${displayListPriceInProductPage == 'true'}">			
			 <div class="font3" id="WC_CachedPackageDisplay_div_4">
				<fmt:message key="PRICE" bundle="${storeText}"/>&nbsp;
				<c:set var="type" value="package"/>
				<c:set var="catalogEntryDB" value="${packageDataBean}"/>
				<c:set var="displayPriceRange" value="true"/>
				<%@ include file="../../../Snippets/ReusableObjects/CatalogEntryPriceDisplay.jspf"%>
			 </div>
			 </c:if>
			 <br clear="all" />
			 <%-- We output the discounts using simple JavaScript to support older browsers such as Netscape 4  --%>
			<script type="text/javascript">
					document.write(Discount.getProductDiscountText(<c:out value="${productId}"/>));
			</script>
			<br/>
			<br/>
			 <p>
				  <label for="quantity_<c:out value='${packageDataBean.packageID}'/>"><fmt:message key="QuickInfo_Qty" bundle="${storeText}"/>:</label>
				  <input name="quantity_<c:out value='${packageDataBean.packageID}'/>" id="quantity_<c:out value='${packageDataBean.packageID}'/>" type="text" size="3" value="1"/>
			 </p>
			<br />
			<%@ include file="B2BCatentryContractSelectExt.jspf"%>		
			 <%-- 
			  ***
				*	Start: Page action buttons
				***
			--%>
			<c:choose>
				<c:when test="${buyable || alwaysShowAddToCart}" >
					<flow:ifEnabled feature="AjaxAddToCart">
						<p> 
							<span class="primary_button button_fit" >
								<span class="button_container">
									<span class="button_bg">
										<span class="button_top">
											<span class="button_bottom">   
												<a href="javascript:setCurrentId('WC_CachedPackageDisplay_links_3');categoryDisplayJS.AddItem2ShopCartAjax('<c:out value='${packageDataBean.packageID}'/>',document.getElementById('quantity_<c:out value='${packageDataBean.packageID}'/>').value)" id="WC_CachedPackageDisplay_links_3"><fmt:message key="PRODUCT_ADD_TO_CART" bundle="${storeText}" /></a>
											</span>
										</span>	
									</span>
								</span>
							</span>
						</p>
						 <div class="features" id="WC_CachedPackageDisplay_div_9">
							<flow:ifEnabled feature="ProductCompare">
								<p><a href="JavaScript:categoryDisplayJS.Add2CompareAjax('<c:out value='${packageDataBean.packageID}'/>','<c:out value='${productCompareImagePath}'/>', '<c:out value='${catEntryDisplayUrl}'/>','<c:out value='${compareImageDescription}'/>');" id="WC_CachedPackageDisplay_links_4"><img src="<c:out value='${jspStoreImgDir}${vfileColor}/i_add_wishlist.png'/>" alt="<fmt:message key="ADDTOCOMPARE" bundle="${storeText}" />" /><fmt:message key="ADDTOCOMPARE" bundle="${storeText}" /></a></p>
							</flow:ifEnabled>

							<flow:ifEnabled  feature="wishList">
								<p><a href="javascript: setCurrentId('WC_CachedPackageDisplay_links_5'); categoryDisplayJS.Add2WishListAjaxByID('<c:out value='${packageDataBean.packageID}'/>')" id="WC_CachedPackageDisplay_links_5"><img src="<c:out value='${jspStoreImgDir}${vfileColor}/i_add_wishlist.png'/>" alt="<fmt:message key="WISHLIST" bundle="${storeText}" />" /><fmt:message key="WISHLIST" bundle="${storeText}" /> </a></p>
							</flow:ifEnabled>
							<flow:ifEnabled feature="RequisitionList">
								<c:set var="type" value="package" />
								<%@include file="../../../ShoppingArea/OrderCreationSection/RequisitionListSubsection/RequisitionListLinks.jspf" %>
							</flow:ifEnabled>							
						 </div>
					</flow:ifEnabled>
					
					<flow:ifDisabled feature="AjaxAddToCart">				
						 <form name="OrderItemAddForm_<c:out value='${packageDataBean.packageID}'/>" action="OrderChangeServiceItemAdd" method="post" id="OrderItemAddForm_<c:out value='${packageDataBean.packageID}'/>">
							<input type="hidden" name="storeId" value="<c:out value='${WCParam.storeId}'/>" id="OrderItemAddForm_storeId_<c:out value='${packageDataBean.packageID}'/>"/>
							<input type="hidden" name="langId" value="<c:out value='${WCParam.langId}'/>" id="OrderItemAddForm_langId_<c:out value='${packageDataBean.packageID}'/>"/>
							<input type="hidden" name="catalogId" value="<c:out value='${WCParam.catalogId}'/>" id="OrderItemAddForm_catalogId_<c:out value='${packageDataBean.packageID}'/>"/>
							<input type="hidden" name="URL" value="AjaxOrderItemDisplayView" id="OrderItemAddForm_url_<c:out value='${packageDataBean.packageID}'/>"/>
							<input type="hidden" name="errorViewName" value="InvalidInputErrorView" id="OrderItemAddForm_errorViewName_<c:out value='${packageDataBean.packageID}'/>"/>
							<input type="hidden" name="catEntryId" value="<c:out value='${packageDataBean.packageID}'/>" id="OrderItemAddForm_catEntryId_<c:out value='${packageDataBean.packageID}'/>"/>
							<input type="hidden" name="productId" value="<c:out value='${packageDataBean.packageID}'/>" id="OrderItemAddForm_productId_<c:out value='${packageDataBean.packageID}'/>"/>
							<input type="hidden" name="quantity" value="" id="OrderItemAddForm_quantity_<c:out value='${packageDataBean.packageID}'/>"/>
							<input type="hidden" name="page" value="" id="OrderItemAddForm_page_${packageDataBean.packageID}"/>
							<input type="hidden" name="contractId" value="" id="OrderItemAddForm_contractId_${packageDataBean.packageID}"/>
							<input type="hidden" name="calculationUsage" value="-1,-2,-3,-4,-5,-6,-7" id="OrderItemAddForm_calcUsage_${packageDataBean.packageID}"/>
							<input type="hidden" name="updateable" value="0" id="OrderItemAddForm_updateable_${packageDataBean.packageID}"/>
						</form>
						 <p>
							<span class="primary_button button_fit" >
								<span class="button_container">
									<span class="button_bg">
										<span class="button_top">
											<span class="button_bottom">   
												<a href="#" onclick="javascript:categoryDisplayJS.AddItem2ShopCart(document.getElementById('OrderItemAddForm_<c:out value='${packageDataBean.packageID}'/>'),document.getElementById('quantity_<c:out value='${packageDataBean.packageID}'/>').value);return false;" id="WC_CachedPackageDisplay_links_6"><fmt:message key="PRODUCT_ADD_TO_CART" bundle="${storeText}" /></a>
											</span>
										</span>	
									</span>
								</span>
							</span>	
						</p>	
						 <div class="features" id="WC_CachedPackageDisplay_div_12">
							 <flow:ifEnabled feature="ProductCompare"> 
								<p><a href="JavaScript:categoryDisplayJS.Add2CompareAjax('<c:out value='${packageDataBean.packageID}'/>','<c:out value='${productCompareImagePath}'/>', '<c:out value='${catEntryDisplayUrl}'/>','<c:out value='${compareImageDescription}'/>');" id="WC_CachedPackageDisplay_links_7"><img src="<c:out value='${jspStoreImgDir}${vfileColor}/i_add_wishlist.png'/>" alt="<fmt:message key="ADDTOCOMPARE" bundle="${storeText}" />" /><fmt:message key="ADDTOCOMPARE" bundle="${storeText}" /></a></p>
							</flow:ifEnabled>
							<flow:ifEnabled  feature="wishList">
								<p><a id="WC_CachedPackageDisplay_links_8" href="#" onclick="javascript: categoryDisplayJS.Add2WishListByID('<c:out value='${packageDataBean.packageID}'/>',document.getElementById('OrderItemAddForm_<c:out value='${packageDataBean.packageID}'/>'));return false;"><img src="<c:out value='${jspStoreImgDir}${vfileColor}/i_add_wishlist.png'/>" alt="<fmt:message key="WISHLIST" bundle="${storeText}" />" /><fmt:message key="WISHLIST" bundle="${storeText}" /> </a></p>
							</flow:ifEnabled>
							<flow:ifEnabled feature="RequisitionList">
								<c:set var="type" value="package" />
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
											<a href="<c:out value="${TopCategoriesDisplayURL}" />" id="WC_CachedPackageDisplay_links_9"><fmt:message key="RETURN_SHOPPING" bundle="${storeText}" /></a>
										</span>
									</span>	
								</span>
							</span>
						</span>	
					</p>
				</c:otherwise>
			</c:choose>
			<%@ include file="CachedPackageButtonExt.jspf"%>
			
			<br />
			<%out.flush();%>
			<c:import url="${jspStoreDir}Snippets/Catalog/CatalogEntryDisplay/CatalogEntryInventoryStatus.jsp">
				<c:param name="fromPage" value="${fromPage}"/>
				<c:param name="catentryId" value="${packageDataBean.packageID}"/>
			</c:import>
			<%out.flush();%>
			<%@ include file="CatalogEntryInventoryStatusEIExt.jspf"%>
		</div>
		<br />
		<br clear="all" />
		<%-- 
			***
			*	End: Page action buttons
			***
		--%>


		<%-- 
		  ***
		  *	Start: List the information of the items that compose the package
		  ***
		--%>
		<div id="WC_CachedPackageDisplay_div_15">
			<c:forEach var="compositeItem" items="${packageDataBean.packagedItems}" varStatus="iStatus">
				<wcf:url var="ItemDisplayURL" value="Product2">
					<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
					<wcf:param name="storeId" value="${WCParam.storeId}"/>
					<wcf:param name="productId" value="${compositeItem.item.itemID}"/>
					<wcf:param name="langId" value="${WCParam.langId}"/>
					<wcf:param name="parent_category_rn" value="${WCParam.categoryId}"/>
					<wcf:param name="top_category" value="${WCParam.top_category}"/>
				</wcf:url>
				<h1><fmt:message key="ITEM_TITLE1" bundle="${storeText}"/> <c:out value="${compositeItem.item.description.name}" escapeXml="false"/></h1>
					
				<div class="left" id="WC_CachedPackageDisplay_div_16_<c:out value='${iStatus.count}'/>">
						<c:choose>
							<c:when test="${!empty compositeItem.item.description.thumbNail}">
								<a id="WC_CachedPackageDisplay_links_10_<c:out value='${iStatus.count}'/>" href="<c:out value="${ItemDisplayURL}" escapeXml="false"/>">
									<img src="<c:out value="${hostPath}"/><c:out value="${compositeItem.item.objectPath}${compositeItem.item.description.thumbNail}"/>" alt="<c:out value="${compositeItem.item.description.shortDescription}" />" border="0" width="70" height="70"/>
								</a>
							</c:when>
							<c:otherwise>
								<a id="WC_CachedPackageDisplay_links_11_<c:out value='${iStatus.count}'/>" href="<c:out value="${ItemDisplayURL}" escapeXml="false"/>" >
								<img src="<c:out value="${hostPath}"/><c:out value="${jspStoreImgDir}" />images/NoImageIcon_sm.jpg" alt="<fmt:message key="No_Image" bundle="${storeText}"/>" border="0" width="70" height="70"/>
								</a>
							</c:otherwise>
						</c:choose>
				</div>
				<div class="left" id="WC_CachedPackageDisplay_div_17_<c:out value='${iStatus.count}'/>">
							<c:out value="${compositeItem.item.description.longDescription}" escapeXml="false" />
							<br />	
							<span><fmt:message key="SKU" bundle="${storeText}" />:</span><span><c:out value="${compositeItem.item.partNumber}" /></span>
							<br />
							<script type="text/javascript">
								document.write(Discount.getItemDiscountText(<c:out value="${compositeItem.item.itemID}"/>));
							</script>
							
							<br />
							<fmt:message key="PRODUCT_ATTRIBUTES" bundle="${storeText}" />:
								<%--
								  ***
								  * Start: Display Defining and Descriptive attributes
								  * First, loop through the attribute values and display the defining attributes
								  * Then, display the item descriptive attributes and show the corresponding images if available
								  * If the item does not have descriptive attributes, get the attributes from the parent item.
								  ***
								--%>
								<c:set var="anyAttributes" value="false" />
								<wcf:getData type="com.ibm.commerce.catalog.facade.datatypes.CatalogEntryType" var="catentryItem" expressionBuilder="getStoreCatalogEntryAttributesByID">
									<wcf:contextData name="storeId" data="${param.storeId}"/>
									<wcf:param name="catEntryId" value="${compositeItem.item.itemID}"/>
									<wcf:param name="dataLanguageIds" value="${WCParam.langId}"/>
		 						</wcf:getData>
								<c:forEach var="attributeItem" items="${catentryItem.catalogEntryAttributes.attributes}">
									<c:if test="${ attributeItem.usage=='Descriptive' }" >
										<span><c:out value="${attributeItem.name}"  escapeXml="false" /> : </span>
										<span>
										<c:out value="${attributeItem.value.value}"  escapeXml="false" />
										</span>
										<br />
										<c:set var="anyAttributes" value="true" />											
									</c:if>
								</c:forEach>
								<c:forEach var="attributeItem" items="${catentryItem.catalogEntryAttributes.attributes}">
									<c:if test="${ attributeItem.usage=='Defining' }" >
										<span><c:out value="${attributeItem.name}"  escapeXml="false" />:</span>
										<span>
										<c:choose>
											<c:when test="${ !empty attributeItem.extendedValue['Image1']  }" >
												<c:out value="${attributeItem.value.value}" escapeXml="false"  />&nbsp;<img src="<c:out value="${compositeItem.item.objectPath}${attributeItem.extendedValue['Image1']}" />" alt="<c:out value="${attributeItem.value.value}" />" border="0"/>
											</c:when>
											<c:otherwise >
												<c:out value="${attributeItem.value.value}"  escapeXml="false"  />
											</c:otherwise>
										</c:choose>
										</span>
										<br />
										<c:set var="anyAttributes" value="true" />
									</c:if>
								</c:forEach>		
						
								<c:if test="${!anyAttributes}">
									<span>
										<fmt:message key="ITEM_NO_ATTRIBUTES" bundle="${storeText}" />
									</span>
								</c:if>
				</div>
				<br clear="all" />
				
				<c:if test="${displayListPriceInProductPage == 'true'}">				
				<div class="left" id="WC_CachedPackageDisplay_div_18_<c:out value='${iStatus.count}'/>">
					<fmt:message key="PRICE" bundle="${storeText}"/>
				</div>
				<div class="left" id="WC_CachedPackageDisplay_div_19_<c:out value='${iStatus.count}'/>">
					&nbsp;
				</div>
					<div class="left" id="WC_CachedPackageDisplay_div_20_<c:out value='${iStatus.count}'/>">
						<c:set var="type" value="item"/>
						<c:set var="catalogEntryDB" value="${compositeItem.item}"/>
						<%@ include file="../../../Snippets/ReusableObjects/CatalogEntryPriceDisplay.jspf"%>
					</div>
					<br clear="all" />					
				</c:if>
				<div id="WC_CachedPackageDisplay_div_21_<c:out value='${iStatus.count}'/>">
					<fmt:message key="QuickInfo_Qty" bundle="${storeText}"/>:<c:out value="${compositeItem.formattedQuantity}" />
				</div>
				<br />
				<br />
		</c:forEach>
		<%-- 
		  ***
		  *	End: List the information of the items that compose the package
		  ***
		--%>

		<%-- 
		  ***
		  *	Start: List the information of the products that compose the package
		  ***
		--%>
		<c:forEach var="compositeProduct" items="${packageDataBean.packagedProducts}" varStatus="iStatus">
				<wcf:url var="ProductDisplayURL" value="Product2">
					<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
					<wcf:param name="storeId" value="${WCParam.storeId}"/>
					<wcf:param name="productId" value="${compositeProduct.product.productID}"/>
					<wcf:param name="langId" value="${WCParam.langId}"/>
					<wcf:param name="parent_category_rn" value="${WCParam.categoryId}"/>
					<wcf:param name="top_category" value="${WCParam.top_category}"/>
				</wcf:url>
				<h1><fmt:message key="PRODUCT_TITLE1" bundle="${storeText}"/> <c:out value="${compositeProduct.product.description.name}" escapeXml="false"/></h1>
				<div class="left" id="WC_CachedPackageDisplay_div_22_<c:out value='${iStatus.count}'/>">
							<c:choose>
								<c:when test="${!empty compositeProduct.product.description.thumbNail}">
									<a id="WC_CachedPackageDisplay_links_12_<c:out value='${iStatus.count}'/>" href="<c:out value="${ProductDisplayURL}" escapeXml="false"/>">
										<img src="<c:out value="${hostPath}"/><c:out value="${compositeProduct.product.objectPath}${compositeProduct.product.description.thumbNail}"/>" alt="<c:out value="${compositeProduct.product.description.shortDescription}" />" border="0"/>
									</a>
								</c:when>
								<c:otherwise>
									<a id="WC_CachedPackageDisplay_links_13_<c:out value='${iStatus.count}'/>" href="<c:out value="${ProductDisplayURL}" escapeXml="false"/>" >
									<img src="<c:out value="${hostPath}"/><c:out value="${jspStoreImgDir}" />images/NoImageIcon_sm.jpg" alt="<fmt:message key="No_Image" bundle="${storeText}"/>" border="0"/>
									</a>
								</c:otherwise>
							</c:choose>
				</div>
				<div class="left" id="WC_CachedPackageDisplay_div_23_<c:out value='${iStatus.count}'/>">
							<c:out value="${compositeProduct.product.description.longDescription}" escapeXml="false" />
							<br />
							
							<script type="text/javascript">
									document.write(Discount.getProductDiscountText(<c:out value="${compositeProduct.product.productID}"/>));
							</script>
							<br />
							
							<fmt:message key="PRODUCT_ATTRIBUTES" bundle="${storeText}" />
							<%--
							  ***
							  * Start: Display Defining and Descriptive attributes
							  * First, loop through the attribute values and display the defining attributes
							  * Then, display the item descriptive attributes and show the corresponding images if available
							  * If the item does not have descriptive attributes, get the attributes from the parent item.
							  ***
							--%>

							<%-- 
							  ***
							  *	Start: Defining Attributes
							  * The drop down box will only display defining attributes.
							  * Defining attributes are properties of SKUs.  They are used for SKU resolution.
							  ***
							--%>
							<br />
							<wcf:getData type="com.ibm.commerce.catalog.facade.datatypes.CatalogEntryType" var="catentry" expressionBuilder="getStoreCatalogEntryAttributesByID">
								<wcf:contextData name="storeId" data="${param.storeId}"/>
								<wcf:param name="catEntryId" value="${compositeProduct.product.productID}"/>
								<wcf:param name="dataLanguageIds" value="${WCParam.langId}"/>
							</wcf:getData>
			 				<c:set var="anyAttributes" value="false" />
							<c:forEach var="attribute" items="${catentry.catalogEntryAttributes.attributes}" varStatus="aStatus">
								<c:if test="${attribute.usage == 'Defining'}">
									<span><label for="attributes"><c:out value="${attribute.name}" escapeXml="false" />:</label></span><br/>
									<select class="drop_down" id="attributes" name="attrValue">
										<!-- Display product attribute values !-->
										<c:forEach var="allowedValue" items="${attribute.allowedValue}">
											<option><c:out value="${allowedValue.value}" escapeXml="false"/></option>
										</c:forEach>
									</select>
									<br />
									<c:set var="anyAttributes" value="true" />
								</c:if>
							</c:forEach>
							<%-- 
							  ***
							  *	End: Defining Attributes
							  ***
							--%>
		
							<c:forEach var="attributeItem" items="${catentry.catalogEntryAttributes.attributes}">
								<c:if test="${ attributeItem.usage=='Descriptive' }" >
									<span><c:out value="${attributeItem.name}"  escapeXml="false" />:</span>
									<span>
									<c:choose>
										<c:when test="${ !empty attributeItem.extendedValue['Image1']  }" >
											<c:out value="${attributeItem.value.value}" escapeXml="false"  />&nbsp;<img src="<c:out value="${compositeItem.item.objectPath}${attributeItem.extendedValue['Image1']}" />" alt="<c:out value="${attributeItem.value.value}" />" border="0"/>
										</c:when>
										<c:otherwise >
											<c:out value="${attributeItem.value.value}"  escapeXml="false"  />
										</c:otherwise>
									</c:choose>
									</span>
									<br />
									<c:set var="anyAttributes" value="true" />
								</c:if>
							</c:forEach>
							<c:if test="${!anyAttributes}">
								<span>
									<fmt:message key="PRODUCT_NO_ATTRIBUTES" bundle="${storeText}" />
								</span>
							</c:if>
				</div>
				<br clear="all" />
				<div class="left" id="WC_CachedPackageDisplay_div_24_<c:out value='${iStatus.count}'/>">
					<fmt:message key="PRICE" bundle="${storeText}"/>
				</div>
				<div class="left" id="WC_CachedPackageDisplay_div_25_<c:out value='${iStatus.count}'/>">
					&nbsp;
				</div>
				<div class="left" id="WC_CachedPackageDisplay_div_26_<c:out value='${iStatus.count}'/>">
							<c:set var="type" value="product"/>
							<c:set var="catalogEntryDB" value="${compositeProduct.product}"/>
							<%@ include file="../../../Snippets/ReusableObjects/CatalogEntryPriceDisplay.jspf"%>
				</div>
				<br clear="all" />
				<div id="WC_CachedPackageDisplay_div_27_<c:out value='${iStatus.count}'/>">  
					<fmt:message key="QuickInfo_Qty" bundle="${storeText}"/>:<c:out value="${compositeProduct.formattedQuantity}" /></span>
				</div>
				<br />
				<br />
		</c:forEach>
		<%-- 
		  ***
		  *	End: List the information of the products that compose the package
		  ***
		--%>

		<%-- 
		  ***
		  *	Start: List the information of the packages that compose the packages
		  ***
		--%>
		<c:forEach var="compositePackage" items="${packageDataBean.packagedPackages}" varStatus="iStatus">
				<wcf:url var="PackageDisplayURL" value="Product2">
					<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
					<wcf:param name="storeId" value="${WCParam.storeId}"/>
					<wcf:param name="productId" value="${compositePackage.package.packageID}"/>
					<wcf:param name="langId" value="${WCParam.langId}"/>
					<wcf:param name="parent_category_rn" value="${WCParam.categoryId}"/>
					<wcf:param name="top_category" value="${WCParam.top_category}"/>
				</wcf:url>
				<h1><fmt:message key="PACKAGE_TITLE1" bundle="${storeText}"/> <c:out value="${compositePackage.package.description.name}" escapeXml="false"/></h1>
				<div class="left" id="WC_CachedPackageDisplay_div_28_<c:out value='${iStatus.count}'/>">
						<c:choose>
							<c:when test="${!empty compositePackage.package.description.thumbNail}">
								<a id="WC_CachedPackageDisplay_links_14_<c:out value='${iStatus.count}'/>" href="<c:out value="${PackageDisplayURL}" escapeXml="false"/>">
									<img src="<c:out value="${hostPath}"/><c:out value="${compositePackage.package.objectPath}${compositePackage.package.description.thumbNail}"/>" alt="<c:out value="${compositePackage.package.description.shortDescription}" />" border="0"/>
								</a>
							</c:when>
							<c:otherwise>
								<a id="WC_CachedPackageDisplay_links_15_<c:out value='${iStatus.count}'/>" href="<c:out value="${PackageDisplayURL}" escapeXml="false"/>" >
								<img src="<c:out value="${hostPath}"/><c:out value="${jspStoreImgDir}" />images/NoImageIcon_sm.jpg" alt="<fmt:message key="No_Image" bundle="${storeText}"/>" border="0"/>
								</a>
							</c:otherwise>
						</c:choose>
				</div>
				<div class="left" id="WC_CachedPackageDisplay_div_29_<c:out value='${iStatus.count}'/>">
						<c:out value="${compositePackage.package.description.longDescription}" escapeXml="false" />
						<br />
						
						<script type="text/javascript">
							document.write(Discount.getPackageDiscountText(<c:out value="${compositePackage.package.packageID}"/>));
						</script>
						<br />
						<fmt:message key="PRODUCT_ATTRIBUTES" bundle="${storeText}" />
						<br />
						<c:set var="anyAttributes" value="false" />						
						<wcf:getData type="com.ibm.commerce.catalog.facade.datatypes.CatalogEntryType" var="catentry3" expressionBuilder="getStoreCatalogEntryAttributesByID">
							<wcf:contextData name="storeId" data="${param.storeId}"/>
							<wcf:param name="catEntryId" value="${compositePackage.package.packageID}"/>
							<wcf:param name="dataLanguageIds" value="${WCParam.langId}"/>
	 					</wcf:getData>
						<c:forEach var="attribute2" items="${catentry3.catalogEntryAttributes.attributes}">
							<c:if test="${ attribute2.usage=='Descriptive' }" >										
								<span class="productName"><c:out value="${attribute2.name}" escapeXml="false" />:</span>
								<span>											
								<c:choose>
									<c:when test="${ !empty attribute2.extendedValue['Image1']  }" >
										<c:out value="${attribute2.value.value}" escapeXml="false" />&nbsp;<img src="<c:out value="${packageDataBean.objectPath}${attribute2.extendedValue['Image1']}" />" alt="<c:out value="${attribute2.value.value}" />" border="0"/><br/>												
									</c:when>
									<c:otherwise >
										<c:out value="${attribute2.value.value}" escapeXml="false" />
									</c:otherwise>
								</c:choose>
								</span>
								<br/>
								<c:set var="anyAttributes" value="true" />
							</c:if>
						</c:forEach>
						<c:if test="${!anyAttributes}">
							<span>
								<fmt:message key="PACKAGE_NO_ATTRIBUTES" bundle="${storeText}" />
							</span>
						</c:if>
				</div>
				<br clear="all" />
				<div class="left" id="WC_CachedPackageDisplay_div_30_<c:out value='${iStatus.count}'/>">
					<fmt:message key="PRICE" bundle="${storeText}"/>
				</div>
				<div class="left" id="WC_CachedPackageDisplay_div_31_<c:out value='${iStatus.count}'/>">
					&nbsp;
				</div>
				<div class="left" id="WC_CachedPackageDisplay_div_32_<c:out value='${iStatus.count}'/>">
						<c:set var="type" value="package"/>
						<c:set var="catalogEntryDB" value="${compositePackage.package}"/>
						<%@ include file="../../../Snippets/ReusableObjects/CatalogEntryPriceDisplay.jspf"%>
				</div>
				<br clear="all" />
				<div id="WC_CachedPackageDisplay_div_33_<c:out value='${iStatus.count}'/>">  
					<fmt:message key="QuickInfo_Qty" bundle="${storeText}"/>:<c:out value="${compositePackage.formattedQuantity}" /></span>
				</div>
				<br />
				<br />
		</c:forEach>
		</div>
		<br clear="all" />
		<%-- 
		  ***
		  *	End: List the information of the packages that compose the packages
		  ***
		--%>
		<%-- 
							  ***
							  *	Start: Cross-Sell, Up-Sell, Accessory, Replacement
							  * Include MerchandisingAssociationsDisplay.jsp if Cross-Sell, Up-Sell, Accessory, Replacement are set up
							  ***
							--%>
							<%-- Flush the buffer so this fragment JSP is not cached twice --%>
							<%out.flush();%>
						        <c:import url="${jspStoreDir}Snippets/Catalog/MerchandisingAssociations/MerchandisingAssociationsDisplay.jsp">
				            			<c:param name="catalogEntryType" value="PackageBean"/>
				            			<c:param name="pageView" value="image"/>
				        		</c:import>
							<%out.flush();%>
							<%-- 
							  ***										  
							  *	End: Cross-Sell, Up-Sell, Accessory, Replacement
							  ***
							--%>		
		<br clear="all" />
		<script type="text/javascript">dojo.addOnLoad(function() { parseWidget("WC_CachedPackageDisplay_div_34"); });</script>
		<div class="specs" id="WC_CachedPackageDisplay_div_34">
			 <div class="tabs" id="WC_CachedPackageDisplay_div_35">
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
			 	 <%@ include file="CachedPackageTabsExt.jspf"%>
			 </div>
			 <br/>
			 <div id="mainTabContainer" class="info" dojoType="dijit.layout.TabContainer" selectedTab="Description" doLayout="false">
				  <div id="Description" dojoType="dijit.layout.ContentPane" >
				  	<p>
						<fmt:message key="SKU" bundle="${storeText}" />: <c:out value="${packageDataBean.partNumber}" escapeXml="false"/>
			 			</p>
				  	<p>
				  	<c:out value="${packageDataBean.description.shortDescription}" escapeXml="false"/>
				  	</p>
						<br />
						<p>
							<c:out value="${packageDataBean.description.longDescription}" escapeXml="false"/>
						</p>
						<br />
						<%-- 
						  ***
						  *	Start: Descriptive Attributes
						  * Descriptive attributes are simply displayed as 'name:value'. They are not used for SKU resolution.
						  ***
						--%>
						<%-- The descriptive attributes of the package itself --%>
						<wcf:getData type="com.ibm.commerce.catalog.facade.datatypes.CatalogEntryType" var="catentry2" expressionBuilder="getStoreCatalogEntryAttributesByID">
							<wcf:contextData name="storeId" data="${param.storeId}"/>
							<wcf:param name="catEntryId" value="${packageDataBean.packageID}"/>
							<wcf:param name="dataLanguageIds" value="${WCParam.langId}"/>
	 					</wcf:getData>
	 					<p>
						<c:forEach var="attribute2" items="${catentry2.catalogEntryAttributes.attributes}">
							<c:if test="${ attribute2.usage=='Descriptive' }" >										
								<span class="productName"><c:out value="${attribute2.name}" escapeXml="false" />:</span>											
								<c:choose>
									<c:when test="${ !empty attribute2.extendedValue['Image1']  }" >
										<c:out value="${attribute2.value.value}" escapeXml="false" />&nbsp;<img src="<c:out value="${packageDataBean.objectPath}${attribute2.extendedValue['Image1']}" />" alt="<c:out value="${attribute2.value.value}" />" border="0"/><br/>												
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
				  <%@ include file="CachedPackageTabPanesExt.jspf"%>
			 </div>
			 <div class="tabfooter" id="WC_CachedPackageDisplay_div_36"></div>
		</div>
   </div>
</div>
