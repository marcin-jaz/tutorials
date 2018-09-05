<%
//********************************************************************
//*-------------------------------------------------------------------
//* Licensed Materials - Property of IBM
//*
//* WebSphere Commerce
//*
//* (c) Copyright IBM Corp. 2002, 2004, 2009
//*
//* US Government Users Restricted Rights - Use, duplication or
//* disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
//*
//*-------------------------------------------------------------------
//*
%>

<%-- 
  *****
  * This JSP will display  more details about the products and the items that compose the bundle.
  * It shows the following information:
  *  - Bundle full-sized image, name and long description
  *  - All the products in this bundle. For each product, it shows the following:
  *    - Full-sized image, name, and long description
  *    - Contract price and list price
  *    - Quantity box to enter the quantity  
  *    - A list of defining attributes (size and color) if the product has variations, and a list of values for each attribute (red and blue for color and Large and X-Large for size)
  *    - Descriptive attributes, which are simply displayed as 'name:value'
  *    - Applicable discount to the product
  *  - All the items in this bundle. For each item, it shows the following:
  *    - Full-sized image, name, and long description
  *    - Contract price and list price
  *    - Quantity box to enter the quantity  
  *    - Defining and Descriptive attributes, which are displayed as 'name:value'
  *    - Applicable discount to the bundle
  *  - 'Add to shopping cart' button, 'Add to wish list' button for B2C
  * This is an example of how this file could be included into a page: 
  *<c:import url="../../../Snippets/Catalog/CatalogEntryDisplay/CachedBundleDisplay.jsp">
  *          <c:param name="storeId" value="${storeId}"/>
  *          <c:param name="catalogId" value="${catalogId}"/>
  *          <c:param name="langId" value="${langId}"/>
  *          <c:param name="productId" value="${productId}"/>
  *          <c:param name="shouldCachePage" value="${shouldCachePage}"/>
  *</c:import>
  * Note: All items in a bundle are sold separately.  After the bundle has been added to the shopping cart, the items in the shopping cart are separate order items.
  *****
--%>

<!-- Start - JSP File Name: CachedBundleDisplay.jsp -->

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf"%>

<%-- ErrorMessageSetup.jspf is used to retrieve an appropriate error message when there is an error --%>
<%@ include file="../../../include/ErrorMessageSetup.jspf" %>

<c:if test="${empty imgHeight}">
	<c:set var="imgHeight" value="150"/>
</c:if>
<c:if test="${empty imgWidth}">
	<c:set var="imgWidth" value="150"/>
</c:if>


<wcbase:useBean id="bundle" classname="com.ibm.commerce.catalog.beans.BundleDataBean"  scope="request" />

<c:set var="numberOfProduct" value="0" />
<c:set var="runningCountInLoop" value="0" />

<%-- 
***
* Start:  Get all product and item IDs displayed on this page and pass them to the discount code
***
--%>
	<%-- Create a comma delimited string containing all IDs to pass to the discount code.
		For an in depth explanation of why this is done, see DiscountJavaScriptSetup.jsp --%>
	<c:forEach var="productInBundle" items="${bundle.bundledProducts}" varStatus="status">
		<c:set var="someProductIDs" value="${someItemIDs},${productInBundle.product.productID}" />
	</c:forEach>
	
	<c:forEach var="itemInBundle" items="${bundle.bundledItems}" varStatus="iStatus">
		<c:set var="someItemIDs" value="${someItemIDs},${itemInBundle.item.itemID}" />
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

<script type="text/javascript" language="javascript" src="<c:out value="${jspStoreImgDir}javascript/PackageBundleDisplaySetup.js"/>"></script>

<c:if test="${ !empty WCParam.parent_category_rn }" >
	<%-- CategoryDataBean is used to show the name of the parent category --%>
	<wcbase:useBean id="parentCategory" classname="com.ibm.commerce.catalog.beans.CategoryDataBean" >
		<c:set property="categoryId" value="${WCParam.parent_category_rn}" target="${parentCategory}" />
	</wcbase:useBean>

	<%-- Dummy category data bean is used for categories sidebar --%>
	<c:set var="category" value="${parentCategory}" />
</c:if>

<table align="center" cellpadding="2" cellspacing="0" width="786" border="0" id="WC_CachedBundleDisplay_Table_1">
	<tbody>
		<tr align="center">
			<td id="WC_CachedBundleDisplay_TableCell_1">
				<table cellpadding="0" cellspacing="0" border="0" width="100%" id="WC_CachedBundleDisplay_Table_2">
					<tr>	
						<c:if test="${ !empty WCParam.parent_category_rn }" >
						<td id="WC_CachedBundleDisplay_TableCell_2" valign="top">
							<%@ include file="../../../Snippets/ReusableObjects/CategoriesSidebarDisplay.jspf"%>							
						</td>
						</c:if>
						<td valign="top" id="WC_CachedBundleDisplay_TableCell_3">
							<h1><c:out value="${bundle.description.name}" escapeXml="false"/></h1>
							<table cellpadding="0" cellspacing="0" border="0" class="t_table" id="WC_CachedBundleDisplay_Table_3">
								<tr>
									<%-- Show product image and short description if available --%>
									<td class="c_large_img" id="WC_CachedBundleDisplay_TableCell_4">&nbsp;
									<!--
									<c:if test="${!empty bundle.description.fullImage}">
										<img
											src="<c:out value="${bundle.objectPath}${bundle.description.fullImage}" />"
											alt="<c:out value="${bundle.description.shortDescription}" />"
											border="0" width="${imgWidth}" height="${imgHeight}" /><br/>
									</c:if> 
									-->
									<c:choose>
										<c:when test="${!empty bundle.description.fullImage}">
											<img
												src="<c:out value="${bundle.objectPath}${bundle.description.fullImage}" />"
												alt="<c:out value="${bundle.description.shortDescription}" />"
												border="0" width="${imgWidth}" height="${imgHeight}" /><br/>
										</c:when>
										<c:otherwise>
											<img 
												src="<c:out value="${jspStoreImgDir}"/>images/NoImageIcon.jpg" 
												alt="<fmt:message key="No_Image" bundle="${storeText}"/>" 
												border="0"/><br/>					
										</c:otherwise>
									</c:choose>
									</td>
									<td valign="top" id="WC_CachedBundleDisplay_TableCell_5">
										<span class="productName"><c:out value="${bundle.description.shortDescription}" escapeXml="false"/></span>
										<br/>
										<%-- if there is only one sku (item) for the product, show that sku
										<c:if test="${empty product.entitledItems[1] && !empty product.entitledItems[0].partNumber}">
											<br/>
											<span class="text"><fmt:message key="SKU" bundle="${storeText}" />:</span>
											<span class="text"><c:out value="${product.entitledItems[0].partNumber}" /></span>
											<br/>
										</c:if>
										--%>
										<br/>
 										<span class="text"><c:out value="${bundle.description.longDescription}" escapeXml="false" /></span><br/><br/>
										
										<%-- 
										  ***
										  *	Start: Show Catalog Attachments
										  * The attachments for each usage will be displayed
										  ***
										--%>
										<c:forEach var="attachUsage" items="${bundle.attachmentUsages}" >	
											<c:set property="attachmentUsage" value="${attachUsage.identifier}" target="${bundle}" />
											<table border="0" id="WC_CachedBundleDisplay_Table_4">
											<tr><td id="WC_CachedBundleDisplay_TableCell_6">
												<table border="1" cellpadding="0" cellspacing="0" width="100%" id="WC_CachedBundleDisplay_Table_5">
												<tr><td class="labelText1" height="16" nowrap id="WC_CachedBundleDisplay_TableCell_7"><span class="strongtext"><c:out value="${attachUsage.name}"  /><br /></span></td></tr>
												</table>
												<table border="1" width="100%" id="WC_CachedBundleDisplay_Table_6">
												<tr>
													<td class="mainContent" id="WC_CachedBundleDisplay_TableCell_8"> 
														<c:set var="maxNumDisp" value ="4"/>
														<c:set var="maxItemsInRow" value ="1"/>
														<c:set var="showName" value="true" /> 
														<c:set var="showShortDescription" value="false" />
														<c:set var="AttachmentDataBeans" value="${bundle.attachmentsByUsage}" />
														<%@ include file="../Attachments/CatalogAttachmentAssetsDisplay.jspf" %>
													</td>			
												</tr>
												</table>
											</td></tr>
											</table><br />
										</c:forEach>
										<%--
											***
											* End: Show Catalog Attachment
											***
										--%>
										
										<%-- The descriptive attributes of the bundle itself --%>
										<wcf:getData type="com.ibm.commerce.catalog.facade.datatypes.CatalogEntryType" var="catalogEntryAttributes" expressionBuilder="getStoreCatalogEntryAttributesByID">
											<wcf:contextData name="storeId" data="${param.storeId}"/>
											<wcf:param name="catEntryId" value="${bundle.bundleID}"/>
											<wcf:param name="dataLanguageIds" value="${WCParam.langId}"/>
										</wcf:getData>
										
										<c:forEach var="attribute" items="${catalogEntryAttributes.catalogEntryAttributes.attributes}">
										<c:out value="${attribute.usage}"/>
											<c:if test="${ attribute.usage=='Descriptive' }" >
												<span class="productName" title="<c:out value="${attribute.description}" escapeXml="false" />"><c:out value="${attribute.name}" escapeXml="false" />:</span>
												<c:choose>
												<c:when test="${ !empty attribute.extendedValue['Image1']  }" >
													<c:out value="${attribute.value.value}" escapeXml="false" />&nbsp;<img src="<c:out value="${product.objectPath}${attribute.extendedValue['Image1']}" />" alt="<c:out value="${attribute.value.value}" />" border="0"/><br/>
												</c:when>
												<c:otherwise>
													<c:out value="${attribute.value.value}" escapeXml="false" />
												</c:otherwise>
												</c:choose>
												<br/>
											</c:if>
										</c:forEach>

										<c:if test="${!empty errorMessage}">
											<%-- 
											  ***
											  *	Start: Error handling
											  * An error occurs if a customer enters an invalid quantity, or if the products the customer wish to purchase are not available.
											  ***
											--%>
											<span class="errortxt"><c:out value="${errorMessage}" escapeXml="false" /><br /><br /></span>
											<%-- 
											  ***
											  *	End: Error handling
											  ***
											--%>
										</c:if>

										<%-- 
										  ***
										  * If the page has been called with the summaryOnly parameter (from the Order Summary page) then do not show add to cart, wishlist buttons,
										  * or merchandising associations.  Instead show a button that will return the user to the order summary page.
										  ***
										--%>
										<c:if test="${ !empty WCParam.summaryOnly }" >
											<a href="javascript:history.back();" id="WC_CachedItemDisplay_Link_OrderSummary" class="button"><fmt:message key="RETURN_TO_ORDER_SUMMARY" bundle="${storeText}" /></a>&nbsp;
											<br/>
										</c:if>
										
										<c:if test="${ empty WCParam.summaryOnly }" >
										<table cellpadding="1" cellspacing="0" border="0" width="100%" id="WC_CachedBundleDisplay_Table_7">
											<tbody>
												<tr>
													<td valign="top" id="WC_CachedBundleDisplay_TableCell_9">
													<%-- 
													  ***
													  *	Start: 'Add to ShopCart', 'Add to Wish List' buttons ('Home page' button if the SKU is not buyable)
													  *     If item.isCalculatedContractPrice() is false or if the buyable flag is set to 0, this means that the SKU is not buyable and the add to cart button will not be displayed
													  *
													  ***
													--%>

													<c:choose>
														<c:when test="${!empty bundle.maximumBundlePrice && bundle.buyable ne '0' }" >																	
														<%-- 
														  ***
														  *	Start: GiftRegistryCode
														  *
														  ***
														--%>
														<flow:ifEnabled feature="GiftRegistry">
														<form name="OrderItemAddForm" action="" method="post" id="OrderItemAddForm">
														<c:choose>
									                    <c:when test='${sessionScope.layoutMode == "GiftConsultant"}'>
														    <%@ include file="AddToGiftRegistryForConsultantDisplay.jspf" %>
														</c:when>
														<c:otherwise>
														
														<%-- 
														  ***
														  *	End: GiftRegistryCode
														  ***
														--%>	
															<a href="#" onclick="Add2ShopCart(document.OrderItemAddForm); return false;" id="WC_CachedItemDisplay_Link_5" class="button"><fmt:message key="ADD_SHOPPING_CART" bundle="${storeText}" /></a>
															&nbsp;
														<%-- 
														  ***
														  *	Start: GiftRegistryCode
														  *   Commented one section and added 3 lines
														  ***
														--%>
														<flow:ifEnabled  feature="wishList">
															<a href="#" onclick="Add2WishList(document.OrderItemAddForm); return false;" class="button" id="WC_CachedItemDisplay_Link_6"><fmt:message key="WISHLIST" bundle="${storeText}" /></a>
														</flow:ifEnabled>
														<%@ include file="AddToGiftRegistryDisplay.jspf" %>
														</c:otherwise>
														</c:choose>
														</flow:ifEnabled>
														<flow:ifDisabled feature="GiftRegistry">
															<a href="#" onclick="Add2ShopCart(document.OrderItemAddForm); return false;" id="WC_CachedItemDisplay_Link_5" class="button"><fmt:message key="ADD_SHOPPING_CART" bundle="${storeText}" /></a>
															&nbsp;
															<flow:ifEnabled  feature="wishList">
															<a href="#" onclick="Add2WishList(document.OrderItemAddForm); return false;" class="button" id="WC_CachedItemDisplay_Link_6"><fmt:message key="WISHLIST" bundle="${storeText}" /></a>
															</flow:ifEnabled>															
														</flow:ifDisabled>
														<%-- 
														  ***
														  *	End: GiftRegistryCode
														  ***
														--%>	
										
														</c:when>
														<c:otherwise>
															<br/>
															<span class="text"><fmt:message key="BUNDLE_NOT_BUYABLE" bundle="${storeText}" /></span><br/><br/>
																<c:url var="TopCategoriesDisplayURL" value="TopCategoriesDisplay">
																	<c:param name="langId" value="${langId}" />
																	<c:param name="storeId" value="${WCParam.storeId}" />
																	<c:param name="catalogId" value="${WCParam.catalogId}" />
																</c:url>
															<a href="<c:out value="${TopCategoriesDisplayURL}" />" id="WC_CachedItemDisplay_Link_5" class="button"><fmt:message key="RETURN_SHOPPING" bundle="${storeText}" /></a>&nbsp;
														</c:otherwise>
													</c:choose>				
													<%-- 
													  ***
													  *	End: 'Add to ShopCart', 'Add to Wish List' buttons ('Home page' button if the SKU is not buyable)
													  ***
													--%>
													</td>
												</tr>
											</tbody>
										</table><br/>
										</c:if>										

									</td>
								</tr><tr>
									<td valign="top" colspan="2" id="WC_CachedBundleDisplay_TableCell_10">
										<flow:ifDisabled feature="GiftRegistry">
										<form name="OrderItemAddForm" action="" method="post" id="OrderItemAddForm">
										</flow:ifDisabled>
										<input type="hidden" name="orderId" value="." id="WC_CachedBundleDisplay_FormInput_orderId_In_OrderItemAddForm_1"/>
										<input type="hidden" name="storeId" value="<c:out value="${WCParam.storeId}" />" id="WC_CachedBundleDisplay_FormInput_storeId_In_OrderItemAddForm_1"/>
										<input type="hidden" name="catalogId" value="<c:out value="${WCParam.catalogId}" />" id="WC_CachedBundleDisplay_FormInput_catalogId_In_OrderItemAddForm_1"/>
										<input type="hidden" name="productId" value="<c:out value="${productId}" />" id="WC_CachedBundleDisplay_FormInput_productId_In_OrderItemAddForm_1"/>
										<input type="hidden" name="URL" value="OrderItemDisplay?orderId=." id="WC_CachedBundleDisplay_FormInput_URL_In_OrderItemAddForm_1"/>
										<input type="hidden" name="errorViewName" value="ProductDisplayErrorView" id="WC_CachedBundleDisplay_FormInput_errorViewName_In_OrderItemAddForm_1"/>
										<input type="hidden" name="calculationUsageId" value="-1" id="WC_CachedBundleDisplay_FormInput_calculationUsageId_In_OrderItemAddForm_1"/>
										<%-- shouldCachePage is used to tell the server not to cache this page.  So if an error happens, this page is redrawn with an error message --%>
										<input type="hidden" name="shouldCachePage" value="false" id="WC_CachedBundleDisplay_FormInput_shouldCachePage_In_OrderItemAddForm_1"/>
										<%-- DO NOT REMOVE: requisitionListId is used in B2BDirect store --%>
										<input type="hidden" name="requisitionListId" value="false" id="WC_CachedBundleDisplay_FormInput_requisitionListId_In_OrderItemAddForm_1"/>
										
										<%-- 
										  ***
										  *	Start: List the information of the products that compose the bundle
										  ***
										--%>
										
										<table width="100%" border="0" cellpadding="2" cellspacing="0" id="WC_CachedBundleDisplay_Table_8">
										<tbody><tr>
											<th class="colHeader" id="WC_CachedBundleDisplay_nameColumn">
												<fmt:message key="TABLE_NAME" bundle="${storeText}" />
											</th>
											<th class="colHeader" id="WC_CachedBundleDisplay_quantityColumn">
												<span class="t_hd_cntr">
													<fmt:message key="PRODUCT_ITEM_QUANTITY" bundle="${storeText}"/>
												</span>
											</th>
											<th class="colHeader_last" id="WC_CachedBundleDisplay_priceColumn">
												<span class="t_hd_rght">
													<fmt:message key="TABLE_PRICE" bundle="${storeText}"/>
												</span>
											</th>											
										</tr>
										
										<c:forEach var="compositeProduct" items="${bundle.bundledProducts}" varStatus="status">
											<c:url var="ProductDisplayURL" value="ProductDisplay">
											  <c:param name="productId" value="${compositeProduct.product.productID}" />
											  <c:param name="langId" value="${langId}" />
											  <c:param name="storeId" value="${WCParam.storeId}" />
											  <c:param name="catalogId" value="${WCParam.catalogId}" />
											  <c:if test="${ !empty WCParam.parent_category_rn }" >
											    <c:param name="parent_category_rn" value="${WCParam.parent_category_rn}" />
											  </c:if>
											</c:url>
											<tr>
											<%-- Show the thumbnail image of the composite product --%>
											<td class="t_td" headers="WC_CachedBundleDisplay_nameColumn" width="380" id="WC_CachedBundleDisplay_TableCell_11_<c:out value="${status.count}"/>" valign="top">
											<table width="100%" border="0" cellpadding="0" cellspacing="0" id="WC_CachedBundleDisplay_Table_9">
												<tr>
													<td valign="top" id="WC_CachedBundleDisplay_TableCell_12_<c:out value="${status.count}"/>">
														<a href="<c:out value="${ProductDisplayURL}" />" id="WC_CachedBundleDisplay_Link_3_<c:out value="${status.count}"/>">
															<!--
															<img src="<c:out value="${compositeProduct.product.objectPath}${compositeProduct.product.description.thumbNail}" />" alt="<c:out value="${compositeProduct.product.description.name}" />" hspace="5" border="0"/>
															-->
															<c:choose>
																<c:when test="${!empty compositeProduct.product.description.thumbNail}">
																	<img src="<c:out value="${compositeProduct.product.objectPath}${compositeProduct.product.description.thumbNail}" />" alt="<c:out value="${compositeProduct.product.description.name}" />" hspace="5" border="0"/>
																</c:when>
																<c:otherwise>
																	<img src="<c:out value="${jspStoreImgDir}"/>images/NoImageIcon_sm.jpg" alt="<fmt:message key="No_Image" bundle="${storeText}"/>" hspace="5" border="0"/>						
																</c:otherwise>
															</c:choose>
														</a>
													</td>
													<td valign="top" id="WC_CachedBundleDisplay_TableCell_13_<c:out value="${status.count}"/>">
														<%-- Show the name of the composite product --%>
														<span class="text">
														<a class="catalog" href="<c:out value="${ProductDisplayURL}" />" id="WC_CachedBundleDisplay_Link_2_<c:out value="${status.count}"/>">
															<c:out value="${compositeProduct.product.description.name}" escapeXml="false" /></a>
														<br/><br/>
														<c:out value="${compositeProduct.product.description.longDescription}" escapeXml="false" />
														<br />
														
														<input type="hidden" name="partNumber_<c:out value="${status.count}"/>" value="<c:out value="${compositeProduct.product.partNumber}" />" id="WC_CachedBundleDisplay_FormInput_partNumber_<c:out value="${status.count}"/>_In_OrderItemAddForm_1"/>
														</span>
													
														<%-- 
														  ***
														  *	Start: Defining Attributes
														  * The drop down box will only display defining attributes.
														  * Defining attributes are properties of SKUs.  They are used for SKU resolution.
														  ***
														--%>
														<wcf:getData type="com.ibm.commerce.catalog.facade.datatypes.CatalogEntryType" var="compositeProductAttributes" expressionBuilder="getStoreCatalogEntryAttributesByID">
															<wcf:contextData name="storeId" data="${param.storeId}"/>
															<wcf:param name="catEntryId" value="${compositeProduct.product.productID}"/>
															<wcf:param name="dataLanguageIds" value="${WCParam.langId}"/>
														</wcf:getData>
														<c:forEach var="attribute" items="${compositeProductAttributes.catalogEntryAttributes.attributes}" varStatus="status">
															<c:if test="${ attribute.usage=='Defining' }" >										
																<input type="hidden" name="attrName" value="<c:out value="${attribute.attributeIdentifier.uniqueID}" />" id="WC_CachedPackageDisplay_FormInput_attrName_In_OrderItemAddForm_1_<c:out value="${status.count}"/>"/>
																<br/><span class="required">*</span>
																<fmt:message var="selectAttribute" key="SELECT_ATTRIBUTE" bundle="${storeText}">
																	<fmt:param><c:out value="${attribute.name}"/></fmt:param>
																</fmt:message>
																<label for="attrValue"></label>
																<select class="select" id="attributes" title="<c:out value="${selectAttribute}"/>" name="attrValue">
																	<%-- Display the first option in the drop down as: Select Attribute.Name --%>
																	<option value="">
																			<fmt:message key="SELECT_ATTRIBUTE" bundle="${storeText}">
																				<fmt:param><c:out value="${attribute.name}" /></fmt:param>
																			</fmt:message>
																	</option>
																	<c:forEach var="attributeValue" items="${attribute.allowedValue}">
																		<c:choose>
																			<c:when test="${WCParamValues.attrValue[status.count-1] == attributeValue.value}">
																				<option selected="selected" value="<c:out value="${attributeValue.value}" />"><c:out value="${attributeValue.value}" /></option>
																			</c:when>
																			<c:otherwise>
																				<option value="<c:out value="${attributeValue.value}" />"><c:out value="${attributeValue.value}" /></option>
																			</c:otherwise>
																		</c:choose>
																	</c:forEach>
																</select>
																<br/>
															</c:if>
														</c:forEach>
														<%-- 
														  ***
														  *	End: Defining Attributes
														  ***
														--%>
														<%-- 
														  ***
														  *	Start: Descriptive Attributes
														  * The code below is used to display the descriptive attributes and show the corresponding images if available
														  * Descriptive attributes are simply displayed as 'name:value'. They are not used for SKU resolution.					  
														  ***
														--%>
														<c:forEach var="attribute" items="${compositeProductAttributes.catalogEntryAttributes.attributes}" varStatus="status">
															<c:if test="${ attribute.usage=='Descriptive' }" >										
																<span class="productName" title="<c:out value="${attribute.description}" escapeXml="false" />"><c:out value="${attribute.name}" escapeXml="false" />:</span>											
																<c:choose>
																<c:when test="${ !empty attribute.extendedValue['Image1']  }" >
																	<c:out value="${attribute.value.value}" escapeXml="false" />&nbsp;<img src="<c:out value="${product.objectPath}${attribute.extendedValue['Image1']}" />" alt="<c:out value="${attribute.value.value}" />" border="0"/><br/>												
																</c:when>
																<c:otherwise >
																	<c:out value="${attribute.value.value}" escapeXml="false" />
																</c:otherwise>
																</c:choose>
																<br/>
															</c:if>
														</c:forEach>
														<br/>
														<%-- 
														  ***
														  *	End: Descriptive Attributes
														  ***
														--%>
														<%-- We output the discounts using simple JavaScript to support older browsers such as Netscape 4  --%>
														<script type="text/javascript">
															document.write(Discount.getProductDiscountText(<c:out value="${compositeProduct.product.productID}"/>));
														</script>
													</td>
												</tr>
											</table>
											</td>
											
											<td class="t_td" headers="WC_CachedBundleDisplay_quantityColumn" id="WC_CachedBundleDisplay_TableCell_14_<c:out value="${status.count}"/>" valign="top">
												<span class="t_cntr">
													<flow:ifEnabled feature="ProductQuantity">
														<label for="WC_CachedBundleDisplay_FormInput_quantity_In_OrderItemAddForm_1_<c:out value="${status.count}"/>"></label>
														<input class="input" type="text" size="2" maxlength="3" name="quantity_<c:out value="${status.count}" />" value="<c:out value="${compositeProduct.formattedQuantity}" />" id="WC_CachedBundleDisplay_FormInput_quantity_In_OrderItemAddForm_1_<c:out value="${status.count}"/>"/>
													</flow:ifEnabled>
													<flow:ifDisabled feature="ProductQuantity">
														<input type="hidden" name="quantity_<c:out value="${status.count}" />" value="<c:out value="${compositeProduct.formattedQuantity}" />" id="WC_CachedBundleDisplay_FormInput_quantity_In_OrderItemAddForm_1_<c:out value="${status.count}"/>"/>
														<c:out value="${compositeProduct.formattedQuantity}" />
													</flow:ifDisabled>
												</span>
											</td>
											
											<td class="t_td" headers="WC_CachedBundleDisplay_priceColumn" id="WC_CachedBundleDisplay_TableCell_15_<c:out value="${status.count}"/>" valign="top" align="right">
											<%-- 
											  ***
											  *	Start: Product Price
											  * Show the list price only if it is larger than the item price
											  ***
											--%>
											<c:set var="type" value="product"/>
											<c:set var="catalogEntry" value="${compositeProduct.product}"/>
											<%@ include file="../../../Snippets/ReusableObjects/CatalogEntryPriceDisplay.jspf"%>
											<%-- 
											  ***
											  *	End: Product Price
											  ***
											--%>
											</td>											
											</tr>	
											
											<%-- get the numberOfProduct from the status.count --%>
											<c:set var="runningCountInLoop" value="${status.count}" />
										</c:forEach>
										
										<%-- 
										  ***
										  *	End: List the information of the products that compose the bundle
										  ***
										--%>			
										
										<%-- 
										  ***
										  *	Start: List the information of the items that compose the bundle
										  ***
										--%>
										<c:set var="numberOfProduct" value="${runningCountInLoop}" />
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
											<tr>
											<%-- Show the thumbnail image of the composite item --%>
											<c:choose>
												<c:when test="${empty param.displayContractPrices }" >
													<td class="t_td" headers="WC_CachedBundleDisplay_nameColumn" width="380" id="WC_CachedBundleDisplay_TableCell_16_<c:out value="${iStatus.count}"/>" valign="top">
												</c:when>
												<c:otherwise>
													<td headers="WC_CachedBundleDisplay_nameColumn" width="380" id="WC_CachedBundleDisplay_TableCell_17_<c:out value="${iStatus.count}"/>" valign="top">
												</c:otherwise>
											</c:choose>
											<table width="100%" border="0" cellpadding="0" cellspacing="0" id="WC_CachedBundleDisplay_Table_10">
												<tr>
													<td valign="top" id="WC_CachedBundleDisplay_TableCell_18_<c:out value="${iStatus.count}"/>">
														<a href="<c:out value="${ItemDisplayURL}" />" id="WC_CachedBundleDisplay_Link_3_<c:out value="${iStatus.count}"/>">
															<!--
															<img src="<c:out value="${compositeItem.item.objectPath}${compositeItem.item.description.thumbNail}" />" alt="<c:out value="${compositeItem.item.description.name}" />" hspace="5" border="0"/>
															-->
															<c:choose>
																<c:when test="${!empty compositeItem.item.description.thumbNail}">
																	<img src="<c:out value="${compositeItem.item.objectPath}${compositeItem.item.description.thumbNail}" />" alt="<c:out value="${compositeItem.item.description.name}" />" hspace="5" border="0"/>
																</c:when>
																<c:otherwise>
																	<img src="<c:out value="${jspStoreImgDir}"/>images/NoImageIcon_sm.jpg" alt="<fmt:message key="No_Image" bundle="${storeText}"/>" hspace="5" border="0"/>						
																</c:otherwise>
															</c:choose>
														</a>	
													</td>
													<td valign="top" id="WC_CachedBundleDisplay_TableCell_19_<c:out value="${iStatus.count}"/>">
														<%-- Show the name of the composite product --%>
														<span class="text">
														<a class="catalog" href="<c:out value="${ItemDisplayURL}" />" id="WC_CachedBundleDisplay_Link_2_<c:out value="${iStatus.count}"/>">
															<c:out value="${compositeItem.item.description.name}" escapeXml="false" /></a>
														<br/><br/>
														<c:out value="${compositeItem.item.description.longDescription}" escapeXml="false" />
														<br />
														
														<input type="hidden" name="partNumber_<c:out value="${numberOfProduct + iStatus.count}"/>" value="<c:out value="${compositeItem.item.partNumber}" />" id="WC_CachedBundleDisplay_FormInput_partNumber_<c:out value="${numberOfProduct + iStatus.count}"/>_In_OrderItemAddForm_1"/>
														<%-- 
														  ***
														  *	Start: GiftRegistryCode
														  *
														  ***
														--%>
														<flow:ifEnabled feature="GiftRegistry">
														<input type="hidden" name="memberId_<c:out value="${iStatus.count + numberOfProduct}"/>" value="<c:out value="${compositeItem.item.memberId}" />" id="WC_CachedBundleDisplay_FormInput_memberId_<c:out value="${iStatus.count}"/>_In_OrderItemAddForm_1"/>
														</flow:ifEnabled>
														<%-- 
														  ***
														  *	End: GiftRegistryCode
														  ***
														--%>	
														</span>
											
														<%--
														  ***
														  * Start: Display Defining and Descriptive attributes
														  * First, loop through the attribute values and display the defining attributes
														  * Then, display the descriptive attributes and show the corresponding images if available
														  ***
														--%>
														<wcf:getData type="com.ibm.commerce.catalog.facade.datatypes.CatalogEntryType" var="compositeItemAttributes" expressionBuilder="getStoreCatalogEntryAttributesByID">
															<wcf:contextData name="storeId" data="${param.storeId}"/>
															<wcf:param name="catEntryId" value="${compositeItem.item.itemID}"/>
															<wcf:param name="dataLanguageIds" value="${WCParam.langId}"/>
														</wcf:getData>
														
														<br/>
														<c:forEach var="attribute" items="${compositeItemAttributes.catalogEntryAttributes.attributes}">
															<c:if test="${ attribute.usage=='Defining' }" >	
																<span class="strongtext"><c:out value="${attribute.name}"  escapeXml="false" /> : </span><c:out value="${attribute.value.value}"  escapeXml="false" />																				
																<br/>
															</c:if>
														</c:forEach>
														<c:forEach var="attribute" items="${compositeItemAttributes.catalogEntryAttributes.attributes}">
															<c:if test="${ attribute.usage=='Descriptive' }" >	
																<span class="strongtext" title="<c:out value="${attribute.description}"  escapeXml="false" />" ><c:out value="${attribute.name}"  escapeXml="false" />:</span>
																<c:choose>
																	<c:when test="${ !empty attribute.extendedValue['Image1']  }" >
																		<c:out value="${attribute.value.value}" escapeXml="false" />&nbsp;<img src="<c:out value="${item.objectPath}${attribute.extendedValue['Image1']}" />" alt="<c:out value="${attribute.value.value}" />" border="0"/><br/>												
																	</c:when>
																	<c:otherwise >
																		<c:out value="${attribute.value.value}"  escapeXml="false"  />
																	</c:otherwise>
																</c:choose>
																<br/>
															</c:if>
														</c:forEach>
														<%--
														  ***
														  * End: Display Defining and Descriptive attributes
														  ***
														--%>					
														<br/>
			
														
														<%-- We output the discounts using simple JavaScript to support older browsers such as Netscape 4  --%>
														<script type="text/javascript">
															document.write(Discount.getItemDiscountText(<c:out value="${compositeItem.item.itemID}"/>));
														</script>											
													</td>
												</tr>
											</table>
											</td>
											
											<c:choose>
												<c:when test="${empty param.displayContractPrices }" >
													<td class="t_td" headers="WC_CachedBundleDisplay_quantityColumn" id="WC_CachedBundleDisplay_TableCell_20_<c:out value="${iStatus.count}"/>" valign="top">
												</c:when>
												<c:otherwise>
													<td headers="WC_CachedBundleDisplay_quantityColumn" id="WC_CachedBundleDisplay_TableCell_20_<c:out value="${iStatus.count}"/>" valign="top">
												</c:otherwise>
											</c:choose>
											
												<span class="t_cntr">
													<flow:ifEnabled feature="ProductQuantity">
														<label for="WC_CachedBundleDisplay_FormInput_quantity_In_OrderItemAddForm_1_<c:out value="${numberOfProduct + iStatus.count}"/>"></label>
														<input class="input" type="text" size="2" maxlength="3" name="quantity_<c:out value="${numberOfProduct + iStatus.count}" />" value="<c:out value="${compositeItem.formattedQuantity}" />" id="WC_CachedBundleDisplay_FormInput_quantity_In_OrderItemAddForm_1_<c:out value="${numberOfProduct + iStatus.count}"/>"/>
													</flow:ifEnabled>
													<flow:ifDisabled feature="ProductQuantity">
														<input type="hidden" name="quantity_<c:out value="${numberOfProduct + iStatus.count}" />" value="<c:out value="${compositeItem.formattedQuantity}" />" id="WC_CachedBundleDisplay_FormInput_quantity_In_OrderItemAddForm_1_<c:out value="${numberOfProduct + iStatus.count}"/>"/>
														<c:out value="${compositeItem.formattedQuantity}" />
													</flow:ifDisabled>
												</span>
											</td>
											
											
											<%-- 
											  ***
											  *	Start: Item Price
											  * Show the list price only if it is larger than the item price
											  ***
											--%>
											<c:choose>
												<c:when test="${empty param.displayContractPrices }" >
														<td class="t_td" headers="WC_CachedBundleDisplay_priceColumn" id="WC_CachedBundleDisplay_TableCell_22_<c:out value="${iStatus.count}"/>" valign="top" align="right">
															<c:set var="type" value="item"/>
															<c:set var="catalogEntry" value="${compositeItem.item}"/>
															<%@ include file="../../../Snippets/ReusableObjects/CatalogEntryPriceDisplay.jspf"%>
														</td>
													</tr>
												</c:when>
												<c:otherwise>
														<td headers="WC_CachedBundleDisplay_priceColumn" id="WC_CachedBundleDisplay_TableCell_22_<c:out value="${iStatus.count}"/>" valign="top" align="right">
															&nbsp;
														</td>
													</tr>
																										
													<c:set var="actualCount" value="0"/>
													<%--check if numberOfApplicableContractIds is available first before accessing it--%>
													<c:choose>
														<c:when test="${compositeItem.item.checkNumberOfApplicableContractIds}">
															<c:forEach var="i" begin="0" end="${compositeItem.item.numberOfApplicableContractIds}" varStatus="appContractIdCounter">
																<c:set var="classStyle" value="" />
																<c:if test="${appContractIdCounter.count == compositeItem.item.numberOfApplicableContractIds}">
																	<c:set var="classStyle" value="t_td" />
																</c:if>
																<c:if test="${!empty compositeItem.item.applicableContractPrices[i]}">
																<tr>
																<td class="<c:out value="${classStyle}"/>" id="WC_CachedBundleDisplay_TableCell_23_<c:out value="${i}"/>">
																	<input id="WC_CachedBundleDisplay_FormInput_contractId_In_OrderItemAddForm_1_<c:out value="${i}"/>" type="radio" name="contractId_<c:out value="${iStatus.count + numberOfProduct}"/>" value="<c:out value="${compositeItem.item.applicableContractIds[i]}"/>"<c:if test="${actualCount == 0}"> checked="checked"</c:if> >
																	<label for="WC_CachedBundleDisplay_FormInput_contractId_In_OrderItemAddForm_1_<c:out value="${i}"/>"><c:out value="${compositeItem.item.applicableContracts[i].name}"/></label>&nbsp;[<c:out value="${compositeItem.item.applicableContractIds[i]}"/>]
																</td>
																<td class="<c:out value="${classStyle}"/>" id="WC_CachedBundleDisplay_TableCell_24_<c:out value="${i}"/>">
																	&nbsp;
																</td>
																<td class="<c:out value="${classStyle}"/>" id="WC_CachedBundleDisplay_TableCell_25_<c:out value="${i}"/>" valign="top" align="right">
																	<c:forEach var="contractPriceRange" items="${compositeItem.item.applicableContractPriceRanges}" varStatus="priceRangeContractCounter">
																		<c:if test="${priceRangeContractCounter.index == appContractIdCounter.index}">
																			<c:forEach var="priceRange" items="${contractPriceRange.rangePrices}" varStatus="priceRangeCounter">
																				<c:choose>
																					<c:when test="${empty priceRange.endingNumberOfUnits && priceRangeCounter.index == '0'}">
																						<c:out value="${priceRange.contractPrice}" escapeXml="false"/>
																					</c:when>
																					<c:when test="${!empty priceRange.endingNumberOfUnits}">
																						<fmt:message key="TieredPricingDisp" bundle="${storeText}">
																							<fmt:param value="${priceRange.startingNumberOfUnits}" />
																							<fmt:param value="${priceRange.endingNumberOfUnits}" />
																							<fmt:param value="${priceRange.contractPrice}" />
																						</fmt:message><br />
																					</c:when>
																					<c:otherwise>
																						<fmt:message key="TieredPricingDispLast" bundle="${storeText}">
																							<fmt:param value="${priceRange.startingNumberOfUnits}" />
																							<fmt:param value="${priceRange.contractPrice}" />
																						</fmt:message><br />
													                                   				</c:otherwise>
													                           				</c:choose>
															    		     		</c:forEach>
																		</c:if>
																	</c:forEach>
																</td>
																</tr>
																<c:set var="actualCount" value="${actualCount + 1}"/>
																</c:if>
															</c:forEach>
														</c:when>
														<c:otherwise>
															<fmt:message key="ItemDisp_ContractPriceNotAvailable" bundle="${storeText}"/>
														</c:otherwise>
													</c:choose>
												</c:otherwise>
											</c:choose>
											<%-- 
											  ***
											  *	End: Item Price
											  ***
											--%>

											<%-- get the numberOfProduct from the iStatus.count --%>
											<c:set var="runningCountInLoop" value="${numberOfProduct + iStatus.count}" />
										</c:forEach>
										
										<%-- 
										  ***
										  *	End: List the information of the items that compose the bundle
										  ***
										--%>			
										
										<%-- 
										  ***
										  *	Start: List the information of the packages that compose the bundle
										  ***
										--%>
										<c:set var="numberOfProduct" value="${runningCountInLoop}" />
										<c:forEach var="compositePackage" items="${bundle.bundledPackages}" varStatus="pStatus">
											<c:url var="PackageDisplayURL" value="ProductDisplay">
											  <c:param name="productId" value="${compositePackage.package.packageID}" />
											  <c:param name="langId" value="${langId}" />
											  <c:param name="storeId" value="${WCParam.storeId}" />
											  <c:param name="catalogId" value="${WCParam.catalogId}" />
											  <c:if test="${ !empty WCParam.parent_category_rn }" >
											    <c:param name="parent_category_rn" value="${WCParam.parent_category_rn}" />
											  </c:if>
											</c:url>
											<tr>
											<%-- Show the thumbnail image of the composite item --%>
											<c:choose>
												<c:when test="${empty param.displayContractPrices }" >
													<td class="t_td" headers="WC_CachedBundleDisplay_nameColumn" width="380" id="WC_CachedBundleDisplay_TableCell_26_<c:out value="${pStatus.count}"/>" valign="top">
												</c:when>
												<c:otherwise>
													<td headers="WC_CachedBundleDisplay_nameColumn" width="380" id="WC_CachedBundleDisplay_TableCell_27_<c:out value="${pStatus.count}"/>" valign="top">
												</c:otherwise>
											</c:choose>
											
											<table width="100%" border="0" cellpadding="0" cellspacing="0" id="WC_CachedBundleDisplay_Table_11">
												<tr>
													<td valign="top" id="WC_CachedBundleDisplay_TableCell_28_<c:out value="${pStatus.count}"/>">
														<a href="<c:out value="${PackageDisplayURL}" />" id="WC_CachedBundleDisplay_Link_3_<c:out value="${pStatus.count}"/>">
															<!--
															<img src="<c:out value="${compositePackage.package.objectPath}${compositePackage.package.description.thumbNail}" />" alt="<c:out value="${compositePackage.package.description.name}" />" hspace="5" border="0"/>
															-->
															<c:choose>
																<c:when test="${!empty compositePackage.package.description.thumbNail}">
																	<img src="<c:out value="${compositePackage.package.objectPath}${compositePackage.package.description.thumbNail}" />" alt="<c:out value="${compositePackage.package.description.name}" />" hspace="5" border="0"/>
																</c:when>
																<c:otherwise>
																	<img src="<c:out value="${jspStoreImgDir}"/>images/NoImageIcon_sm.jpg" alt="<fmt:message key="No_Image" bundle="${storeText}"/>" hspace="5" border="0"/>						
																</c:otherwise>
															</c:choose>
														</a>
													</td>
													<td valign="top" id="WC_CachedBundleDisplay_TableCell_29_<c:out value="${pStatus.count}"/>">
													
														<%-- Show the name of the composite product --%>
														<span class="text">
														<a class="catalog" href="<c:out value="${ItemDisplayURL}" />" id="WC_CachedBundleDisplay_Link_2_<c:out value="${pStatus.count}"/>">
															<c:out value="${compositePackage.package.description.name}" escapeXml="false" /></a>
														<br/><br/>
														<c:out value="${compositePackage.package.description.longDescription}" escapeXml="false" />
														<br />
														<input type="hidden" name="partNumber_<c:out value="${numberOfProduct + pStatus.count}"/>" value="<c:out value="${compositePackage.package.partNumber}" />" id="WC_CachedBundleDisplay_FormInput_partNumber_<c:out value="${numberOfProduct + pStatus.count}"/>_In_OrderItemAddForm_1"/>
														
														</span>											
													</td>
												</tr>
											</table>
											</td>
											
											<c:choose>
												<c:when test="${empty param.displayContractPrices }" >
													<td class="t_td" headers="WC_CachedBundleDisplay_quantityColumn" id="WC_CachedBundleDisplay_TableCell_30_<c:out value="${pStatus.count}"/>" valign="top">
												</c:when>
												<c:otherwise>
													<td headers="WC_CachedBundleDisplay_quantityColumn" id="WC_CachedBundleDisplay_TableCell_31_<c:out value="${pStatus.count}"/>" valign="top">
												</c:otherwise>
											</c:choose>
											
												<span class="t_cntr">
													<flow:ifEnabled feature="ProductQuantity">
														<label for="WC_CachedBundleDisplay_FormInput_quantity_In_OrderItemAddForm_1_<c:out value="${numberOfProduct + pStatus.count}"/>"></label>
														<input class="input" type="text" size="2" maxlength="3" name="quantity_<c:out value="${numberOfProduct + pStatus.count}" />" value="<c:out value="${compositePackage.formattedQuantity}" />" id="WC_CachedBundleDisplay_FormInput_quantity_In_OrderItemAddForm_1_<c:out value="${numberOfProduct + pStatus.count}"/>"/>
													</flow:ifEnabled>											
													<flow:ifDisabled feature="ProductQuantity">
														<input type="hidden" name="quantity_<c:out value="${numberOfProduct + pStatus.count}" />" value="<c:out value="${compositePackage.formattedQuantity}" />" id="WC_CachedBundleDisplay_FormInput_quantity_In_OrderItemAddForm_1_<c:out value="${numberOfProduct + pStatus.count}"/>"/>
														<c:out value="${compositePackage.formattedQuantity}" />
													</flow:ifDisabled>
												</span>
											</td>
											
											<c:choose>
												<c:when test="${empty param.displayContractPrices }" >
													<td class="t_td" headers="WC_CachedBundleDisplay_priceColumn" id="WC_CachedBundleDisplay_TableCell_32_<c:out value="${pStatus.count}"/>" valign="top" align="right">
													<%-- 
													  ***
													  *	Start: Package Price
													  * Show the list price only if it is larger than the item price
													  ***
													--%>
													<c:set var="type" value="package"/>
													<c:set var="catalogEntry" value="${compositePackage.package}"/>
													<%@ include file="../../../Snippets/ReusableObjects/CatalogEntryPriceDisplay.jspf"%>
													<%-- 
													  ***
													  *	End: Package Price
													  ***
													--%>
													</td>								
													</tr>
												</c:when>
												<c:otherwise>
														<td headers="WC_CachedBundleDisplay_priceColumn" id="WC_CachedBundleDisplay_TableCell_33_<c:out value="${pStatus.count}"/>" valign="top" align="right">
															&nbsp;
														</td>
													</tr>
													
													<c:set var="actualCount" value="0"/>
													<%--check if numberOfApplicableContractIds is available first before accessing it--%>
													<c:choose>
														<c:when test="${compositePackage.package.checkNumberOfApplicableContractIds}">
															<c:forEach var="i" begin="0" end="${compositePackage.package.numberOfApplicableContractIds}" varStatus="appContractIdCounter">
																<c:set var="classStyle" value="" />
																<c:if test="${appContractIdCounter.count == compositePackage.package.numberOfApplicableContractIds}">
																	<c:set var="classStyle" value="t_td" />
																</c:if>
																<c:if test="${!empty compositePackage.package.applicableContractPrices[i]}">
																	<tr>
																	<td class="<c:out value="${classStyle}"/>" id="WC_CachedBundleDisplay_TableCell_34_<c:out value="${i}"/>">
																		<input id="WC_CachedBundleDisplay_FormInput_contractId_In_OrderItemAddForm_11_<c:out value="${i}"/>" type="radio" name="contractId_<c:out value="${pStatus.count + numberOfProduct}"/>" value="<c:out value="${compositePackage.package.applicableContractIds[i]}"/>"<c:if test="${actualCount == 0}"> checked="checked"</c:if> >
																		<label for="WC_CachedBundleDisplay_FormInput_contractId_In_OrderItemAddForm_11_<c:out value="${i}"/>"><c:out value="${compositePackage.package.applicableContracts[i].name}"/></label>&nbsp;[<c:out value="${compositePackage.package.applicableContractIds[i]}"/>]
																	</td>
																	<td class="<c:out value="${classStyle}"/>" id="WC_CachedBundleDisplay_TableCell_35_<c:out value="${i}"/>">
																		&nbsp;
																	</td>
																	<td class="<c:out value="${classStyle}"/>" id="WC_CachedBundleDisplay_TableCell_36_<c:out value="${i}"/>" valign="top" align="right">
																	<c:forEach var="contractPriceRange" items="${compositePackage.package.applicableContractPriceRanges}" varStatus="priceRangeContractCounter">
																		<c:if test="${priceRangeContractCounter.index == appContractIdCounter.index}">
																			<c:forEach var="priceRange" items="${contractPriceRange.rangePrices}" varStatus="priceRangeCounter">
																				<c:choose>
																					<c:when test="${empty priceRange.endingNumberOfUnits && priceRangeCounter.index == '0'}">
																						<c:out value="${priceRange.contractPrice}" escapeXml="false"/>
																					</c:when>
																					<c:when test="${!empty priceRange.endingNumberOfUnits}">
																						<fmt:message key="TieredPricingDisp" bundle="${storeText}">
																							<fmt:param value="${priceRange.startingNumberOfUnits}" />
																							<fmt:param value="${priceRange.endingNumberOfUnits}" />
																							<fmt:param value="${priceRange.contractPrice}" />
																						</fmt:message><br />
																					</c:when>
																					<c:otherwise>
																						<fmt:message key="TieredPricingDispLast" bundle="${storeText}">
																							<fmt:param value="${priceRange.startingNumberOfUnits}" />
																							<fmt:param value="${priceRange.contractPrice}" />
																						</fmt:message><br />
												                                   					</c:otherwise>
												                           					</c:choose>
																			</c:forEach>
																		</c:if>
																	</c:forEach>
																	</td>
																	</tr>
																	<c:set var="actualCount" value="${actualCount + 1}"/>
																</c:if>
															</c:forEach>
														</c:when>
														<c:otherwise>
															<fmt:message key="ItemDisp_ContractPriceNotAvailable" bundle="${storeText}"/>
														</c:otherwise>
													</c:choose>
												</c:otherwise>
											</c:choose>

											<%-- get the numberOfProduct from the iStatus.count --%>
											<c:set var="runningCountInLoop" value="${numberOfProduct + pStatus.count}" />
										</c:forEach>
										
										<%-- 
										  ***
										  *	End: List the information of the packages that compose the bundle
										  ***
										--%>			
																		
										</table>
										<input type="hidden" name="totalCatentryInBundle" value="<c:out value="${runningCountInLoop}" />" id="WC_CachedBundleDisplay_FormInput_totalCatentryInBundle_In_OrderItemAddForm_1"/>
										</form>
									</td>									
								</tr>
							</table>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</tbody>
</table>

<!-- End - JSP File Name: CachedBundleDisplay.jsp -->
