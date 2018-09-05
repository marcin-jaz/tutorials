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
  * This JSP will display the product and all child items under this product.  
  * It shows the following information:
  *  - Product full-sized image, name and long description
  *  - Product discount description if available
  *  - Table listing the child items under this product.
  *  - For each child item, it shows the following:
  *    - Thumbnail image and name
  *    - Item attributes (e.g. size and color) 
  *    - contract price and list price
  *    - 'Add to shopping cart' button, 'Add to wish list' button for B2C button for B2B
  * This is an example of how this file could be included into a page: 
  *<c:import url="../../../Snippets/Catalog/CatalogEntryDisplay/CachedProductItemDisplay.jsp">
  *	        <c:param name="storeId" value="${storeId}"/>
  *	        <c:param name="catalogId" value="${catalogId}"/>
  *	        <c:param name="langId" value="${langId}"/>
  *	        <c:param name="productId" value="${productId}"/>
  *	        <c:param name="parent_category_rn" value="${parent_category_rn}"/>
  *	        <c:param name="shouldCachePage" value="${shouldCachePage}"/>
  *</c:import>
  * 
  *****
--%>


<!-- Start - JSP File Name: CachedProductItemDisplay.jsp -->

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf"%>

<%-- ErrorMessageSetup.jspf is used to retrieve an appropriate error message when there is an error --%>
<%@ include file="../../../include/ErrorMessageSetup.jspf" %>

<wcbase:useBean id="product" classname="com.ibm.commerce.catalog.beans.ProductDataBean" scope="request" />

<%-- 
***
* Start:  Get all product and item IDs displayed on this page and pass them to the discount code
***
--%>
	<%-- Create a comma delimited string containing all IDs to pass to the discount code.
		For an in depth explanation of why this is done, see DiscountJavaScriptSetup.jsp --%>
	<c:forEach var="childItems" items="${product.entitledItems}">
		<c:set var="someItemIDs" value="${someItemIDs},${childItems.itemID}" />
	</c:forEach>
	
	<%-- Pass the IDs to the discount JavaScript --%>
	<%-- Flush the buffer so this fragment JSP is not cached twice --%>
	<%out.flush();%>
	<c:import url="${jspStoreDir}include/DiscountJavaScriptSetup.jsp">
		<c:param name="jsPrototypeName" value="Discount" />
		<c:param name="someProductIDs" value="${productId}"/>
		<c:param name="productIncludeChildItems" value="false"/>
		<c:param name="productIsProdPromoOnly" value="false"/>
		<c:param name="productIncludeParentProduct" value="true"/>
		
		<c:param name="someItemIDs" value="${someItemIDs}"/>
		<c:param name="itemIncludeChildItems" value="true"/>
		<c:param name="itemIsProdPromoOnly" value="true"/>
		<c:param name="itemIncludeParentProduct" value="false"/>
	</c:import>
	<%out.flush();%>
<%-- 
***
* End:  Get all product and item IDs displayed on this page and pass them to the discount code
***
--%>	

<c:if test="${empty imgHeight}">
	<c:set var="imgHeight" value="150"/>
</c:if>
<c:if test="${empty imgWidth}">
	<c:set var="imgWidth" value="150"/>
</c:if>


<c:if test="${ !empty WCParam.parent_category_rn }" >
	<%-- CategoryDataBean is used to show the name of the parent category --%>
	<wcbase:useBean id="parentCategory" classname="com.ibm.commerce.catalog.beans.CategoryDataBean" >
		<c:set property="categoryId" value="${WCParam.parent_category_rn}" target="${parentCategory}" />		
	</wcbase:useBean>

	<%-- Dummy category data bean is used for categories sidebar --%>
	<c:set var="category" value="${parentCategory}" />

</c:if>

<script  type="text/javascript" language="javascript" src="<c:out value="${jspStoreImgDir}javascript/ProductItemDisplaySetup.js"/>"></script>

<table align="center" cellpadding="2" cellspacing="0" width="786" border="0" id="WC_CachedProductOnlyDisplay_Table_1">
	<tbody>
		<tr align="center">
			<td>
				<table cellpadding="0" cellspacing="0" border="0" width="100%">
					<tr>	
						<c:if test="${ !empty WCParam.parent_category_rn }" >
						<td id="subNav" valign="top">
							<%@ include file="../../../Snippets/ReusableObjects/CategoriesSidebarDisplay.jspf"%>							
						</td>
						</c:if>
						<td valign="top">
							<h1><c:out value="${product.description.name}" escapeXml="false"/></h1>

							<table cellpadding="0" cellspacing="0" border="0" class="t_table" id="table">
								<tr>
									<%-- Show product image and short description if available --%>
									<td class="c_large_img">&nbsp;
									<!--
									<c:if test="${!empty product.description.fullImage}">
										<img
											src="<c:out value="${product.objectPath}${product.description.fullImage}" />"
											alt="<c:out value="${product.description.shortDescription}" />"
											border="0" width="${imgWidth}" height="${imgHeight}" /><br/>
									</c:if> 
									-->
									<c:choose>
										<c:when test="${!empty product.description.fullImage}">
											<img
												src="<c:out value="${product.objectPath}${product.description.fullImage}" />"
												alt="<c:out value="${product.description.shortDescription}" />"
												border="0" width="${imgWidth}" height="${imgHeight}" /><br/>
										</c:when>
										<c:otherwise>
											<img 
												src="<c:out value="${jspStoreImgDir}"/>images/NoImageIcon_sm.jpg" 
												alt="<fmt:message key="No_Image" bundle="${storeText}"/>" 
												border="0"/><br/>					
										</c:otherwise>
									</c:choose>
									</td>
									<td valign="top">			
										<span class="productName"><c:out value="${product.description.shortDescription}" escapeXml="false"/></span>
										<br/>
										<%-- if there is only one sku (item) for the product, show that sku --%>
										<c:if test="${empty product.entitledItems[1] && !empty product.entitledItems[0].partNumber}">
											<br/>
											<span class="text"><fmt:message key="SKU" bundle="${storeText}" />:</span>
											<span class="text"><c:out value="${product.entitledItems[0].partNumber}" /></span>
											<br/>
										</c:if>
										<br/>

										<span class="text"><c:out value="${product.description.longDescription}" escapeXml="false" /></span><br/><br/>
										
										<%-- 
										  ***
										  *	Start: Show Catalog Attachments
										  * The attachments for each usage will be displayed
										  ***
										--%>
										<c:forEach var="attachUsage" items="${product.attachmentUsages}" >	
											<c:set property="attachmentUsage" value="${attachUsage.identifier}" target="${product}" />
											<table border="0" id="WC_CatalogAttachment_Table_1">
											<tr><td id="WC_CatalogAttachment_TableCell_1">
												<table border="1" cellpadding="0" cellspacing="0" width="100%" id="WC_CatalogAttachment_Table_2">
												<tr><td class="labelText1" height="16" nowrap id="WC_CatalogAttachment_TableCell_2"><span class="strongtext"><c:out value="${attachUsage.name}"  /><br /></span></td></tr>
												</table>
												<table border="1" width="100%" id="WC_CatalogAttachment_Table_3">
												<tr>
													<td class="mainContent" id="WC_CatalogAttachment_TableCell_3"> 
														<c:set var="maxNumDisp" value ="4"/>
														<c:set var="maxItemsInRow" value ="1"/>
														<c:set var="showName" value="true" /> 
														<c:set var="showShortDescription" value="false" />
														<c:set var="AttachmentDataBeans" value="${product.attachmentsByUsage}" />
														<%@ include file="../Attachments/CatalogAttachmentAssetsDisplay.jspf" %>
													</td>			
												</tr>
												</table>
											</td></tr>
											</table><br/>
										</c:forEach>									
										<%--
											***
											* End: Show Catalog Attachment
											***
										--%>

										<%-- 
										  ***
										  *	Start: Descriptive Attributes
										  * Descriptive attributes are simply displayed as 'name:value'. They are not used for SKU resolution.
										  ***
										--%>
										<wcf:getData type="com.ibm.commerce.catalog.facade.datatypes.CatalogEntryType" var="catalogEntryAttributes" expressionBuilder="getStoreCatalogEntryAttributesByID">
											<wcf:contextData name="storeId" data="${param.storeId}"/>
											<wcf:param name="catEntryId" value="${product.productID}"/>
											<wcf:param name="dataLanguageIds" value="${WCParam.langId}"/>
										</wcf:getData>
										
										<c:forEach var="attribute" items="${catalogEntryAttributes.catalogEntryAttributes.attributes}">
											<c:if test="${ attribute.usage=='Descriptive' }" >										
												<span class="strongtext" title="<c:out value="${attribute.description}" escapeXml="false" />"><c:out value="${attribute.name}" escapeXml="false" />:</span>											
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
											document.write(Discount.getProductDiscountText(<c:out value="${productId}"/>));
										</script>
										<br/>
									</td>
								</tr><tr>
									<td colspan="2">
										<form name="OrderItemAddForm" action="" method="post" id="OrderItemAddForm">
										<input type="hidden" name="storeId" value="<c:out value="${WCParam.storeId}" />" id="WC_CachedProductItemDisplay_FormInput_storeId_In_OrderItemAddForm_1"/>
										<input type="hidden" name="orderId" value="." id="WC_CachedProductItemDisplay_FormInput_orderId_In_OrderItemAddForm_1"/>
										<input type="hidden" name="catalogId" value="<c:out value="${WCParam.catalogId}" />" id="WC_CachedProductItemDisplay_FormInput_catalogId_In_OrderItemAddForm_1"/>
										<input type="hidden" name="URL" value="" id="WC_CachedProductItemDisplay_FormInput_URL_In_OrderItemAddForm_1"/>
										<input type="hidden" name="errorViewName" value="ProductDisplayErrorView" id="WC_CachedProductItemDisplay_FormInput_errorViewName_In_OrderItemAddForm_1"/>
										<input type="hidden" name="catEntryId" value="<c:out value="${productId}" />" id="WC_CachedProductItemDisplay_FormInput_catEntryId_In_OrderItemAddForm_1"/>
										<input type="hidden" name="productId" value="<c:out value="${productId}" />" id="WC_CachedProductItemDisplay_FormInput_productId_In_OrderItemAddForm_1"/>
										<input type="hidden" name="calculationUsageId" value="-1" id="WC_CachedProductItemDisplay_FormInput_calculationUsageId_In_OrderItemAddForm_1"/>
										<input type="hidden" name="quantity" value="1" id="WC_CachedProductItemDisplay_FormInput_quantity_In_OrderItemAddForm_1"/>
										<%-- shouldCachePage is used to tell the server not to cache this page.  So if an error happens, this page is redrawn with an error message --%>
										<input type="hidden" name="shouldCachePage" value="false" id="WC_CachedProductItemDisplay_FormInput_shouldCachePage_In_OrderItemAddForm_1"/>
										<%-- DO NOT REMOVE: requisitionListId is used in B2BDirect store --%>
										<input type="hidden" name="requisitionListId" value="false" id="WC_CachedProductItemDisplay_FormInput_requisitionListId_In_OrderItemAddForm_1"/>
						
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
										  *	Start: Table listing the child items of this product
										  ***
										--%>
										<table width="100%" border="0" cellpadding="2" cellspacing="0" id="WC_CachedProductItemDisplay_Table_3">
										<tbody><tr>
											<th colspan="2" id="Table_Name" class="colHeader">
												<fmt:message key="TABLE_NAME" bundle="${storeText}" />
											</th>
											<flow:ifEnabled feature="ProductQuantity">
											<th id="Table_Item_Quantity" class="colHeader">
												<fmt:message key="PRODUCT_ITEM_QUANTITY" bundle="${storeText}"/>
											</th>
											</flow:ifEnabled>
											<th id="Table_Price" width="240" class="colHeader_last" colspan="2">
												<fmt:message key="TABLE_PRICE" bundle="${storeText}"/>
											</th>											
										</tr>
										<c:forEach var="childItem" items="${product.entitledItems}" varStatus="status">
										<tr>
											<c:url var="ProductDisplayURL" value="ProductDisplay">
											  <c:param name="productId" value="${childItem.itemID}" />
											  <c:param name="langId" value="${langId}" />
											  <c:param name="storeId" value="${WCParam.storeId}" />
											  <c:param name="catalogId" value="${WCParam.catalogId}" />
											  <c:if test="${ !empty WCParam.parent_category_rn }" >
											    <c:param name="parent_category_rn" value="${WCParam.parent_category_rn}" />
											  </c:if>
											</c:url>
																						
											<%-- Show the thumbnail image of the child item --%>
											<td headers="Table_Small_Image" class="t_td" id="WC_CachedProductItemDisplay_TableCell_8_<c:out value="${status.count}"/>" valign="top">											
												<a href="<c:out value="${ProductDisplayURL}" />" id="WC_CachedProductItemDisplay_Link_3_<c:out value="${status.count}"/>">
													<!--
													<img src="<c:out value="${childItem.objectPath}${childItem.description.thumbNail}" />" alt="<c:out value="${childItem.description.name}" />" hspace="5" border="0"/>
													-->
													<c:choose>
														<c:when test="${!empty childItem.description.thumbNail}">
															<img src="<c:out value="${childItem.objectPath}${childItem.description.thumbNail}" />" alt="<c:out value="${childItem.description.name}" />" hspace="5" border="0"/>
														</c:when>
														<c:otherwise>
															<img src="<c:out value="${jspStoreImgDir}"/>images/NoImageIcon.jpg" alt="<fmt:message key="No_Image" bundle="${storeText}"/>" hspace="5" border="0"/>						
														</c:otherwise>
													</c:choose>
												</a>
											</td>
											
											<%-- Show the name of the child item --%>
											<td headers="Table_Name" class="t_td" id="WC_CachedProductItemDisplay_TableCell_9_<c:out value="${status.count}"/>" valign="top">
												<span class="text">
												<a class="catalog" href="<c:out value="${ProductDisplayURL}" />" id="WC_CachedProductItemDisplay_Link_2_<c:out value="${status.count}"/>">
													<c:out value="${childItem.description.name}" escapeXml="false" /></a>
												<br />
												
												<flow:ifDisabled feature="ProductQuantity">
													<input type="hidden" name="item_quantity_<c:out value="${childItem.itemID}" />" value="1" id="WC_CachedProductItemDisplay_FormInput_quantity_In_OrderItemAddForm_1_<c:out value="${status.count}"/>"/>
												</flow:ifDisabled>
												</span>
											
											<%--
											  ***
											  * Start: Display Defining Attributes and Attributes with usage 3
											  * Loop through attributes values and only show the value that is relavent to the attribute for this SKU
											  * This page will show a) defining attribute values and b) attribute values with attribute usage 3
											  * The attributes are displayed as 'name:value'.
											  * Attribute with usage 3 is a descriptive attribute.  However, by default, when descriptive attributes are created through the product management tool, the usage is set to 2.
											  * Attribute usage 3 is used in the sample data of the CatalogAssetStore.  Setting this usage code is a way to group the attributes so that they can be easily retrieved for display purpose.
											  ***
											--%>
											<wcf:getData type="com.ibm.commerce.catalog.facade.datatypes.CatalogEntryType" var="childItemAttributes" expressionBuilder="getStoreCatalogEntryAttributesByID">
												<wcf:contextData name="storeId" data="${param.storeId}"/>
												<wcf:param name="catEntryId" value="${childItem.itemID}"/>
												<wcf:param name="dataLanguageIds" value="${WCParam.langId}"/>
											</wcf:getData>
											
											<br/>
											<c:forEach var="attribute" items="${childItemAttributes.catalogEntryAttributes.attributes}">
												<c:if test="${ attribute.usage=='Defining' }" >	
													<span class="strongtext"><c:out value="${attribute.name}"  escapeXml="false" /> : </span><c:out value="${attribute.value.value}"  escapeXml="false" />																				
													<br/>
												</c:if>
											</c:forEach>
											
											<c:forEach var="attribute" items="${childItemAttributes.catalogEntryAttributes.attributes}">
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
											
											<c:remove var="childItemAttributes"/>
											<%--
											  ***
											  * End: Display Defining Attributes and Attributes with usage 3
											  ***
											--%>
											<%-- Show the partnumber of the child item --%>
											<span class="text"><fmt:message key="SKU" bundle="${storeText}" />:</span> <span class="text"><c:out value="${childItem.partNumber}" /></span>
											<br /><br />

											<%-- We output the discounts using simple JavaScript to support older browsers such as Netscape 4  --%>
											<script type="text/javascript">
												document.write(Discount.getItemDiscountText(<c:out value="${childItem.itemID}"/>));
											</script>											
						
											</td>
						
											<flow:ifEnabled feature="ProductQuantity">
											<td headers="Table_Item_Quantity" class="t_td" id="WC_CachedProductItemDisplay_TableCell_7_<c:out value="${status.count}"/>" valign="top">
						                                        	<label for="WC_CachedProductItemDisplay_FormInput_quantity_In_OrderItemAddForm_1_<c:out value="${status.count}"/>"></label>
												<input type="text" size="2" maxlength="3" name="item_quantity_<c:out value="${childItem.itemID}" />" value="1" id="WC_CachedProductItemDisplay_FormInput_quantity_In_OrderItemAddForm_1_<c:out value="${status.count}"/>"/>
											</td>
											</flow:ifEnabled>
											
											
											<td headers="Table_Price" class="t_td" id="WC_CachedProductItemDisplay_TableCell_10_<c:out value="${status.count}"/>" valign="top" align="right">
											<%-- 
											  ***
											  *	Start: Item Price
											  * Show the list price only if it is larger than the item price
											  ***
											--%>
											<c:set var="type" value="item"/>
											<c:set var="catalogEntry" value="${childItem}"/>
											<%@ include file="../../../Snippets/ReusableObjects/CatalogEntryPriceDisplay.jspf"%>
											<%-- 
											  ***
											  *	End: Item Price
											  ***
											--%>
											</td>
											<%-- The default value for the last <c:out> tag is set to "No Price Available".  We set it back to empty string in the next <c:out> tag --%>
											<td class="t_td" id="WC_CachedProductItemDisplay_TableCell_11_<c:out value="${status.count}" default=""/>" valign="top" align="right">
						
												<table id="WC_CachedProductItemDisplay_Table_4_<c:out value="${status.count}"/>" align="right">
												<tbody>
												<tr>
												<td id="WC_CachedProductItemDisplay_TableCell_13_<c:out value="${status.count}"/>" valign="center" align="right">
												<%-- 
												  ***
												  *	Start: 'Add to ShopCart', 'Add to Wish List' buttons ('Home page' button if the SKU is not buyable)
												  * If childItem.isCalculatedContractPrice() is false or if the buyable flag is set to 0, this means that the SKU is not buyable and the add to cart button will not be displayed
												  ***
												--%>						
												<c:choose>
												<c:when test="${childItem.calculatedContractPriced && childItem.buyable ne '0'}" >
													<%-- 
														  ***
														  *	Start: GiftRegistryCode
														  *
														  ***
														--%>
														<flow:ifEnabled feature="GiftRegistry">
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
	
													<a href="#" onclick="Add2ShopCart(document.OrderItemAddForm, '<c:out value="${childItem.itemID}" />',document.OrderItemAddForm.item_quantity_<c:out value="${childItem.itemID}" />.value); return false;" id="WC_CachedProductItemDisplay_Link_4_<c:out value="${status.count}"/>" class="t_button">&nbsp;<fmt:message key="ADD_SHOPPING_CART" bundle="${storeText}" />&nbsp;</a>
													<%-- 
													  ***
													  *	Start: GiftRegistryCode
													  *
													  ***
													--%>
														<%@ include file="AddToGiftRegistryDisplay.jspf" %>
													<!--												
													<flow:ifEnabled  feature="wishList">
													<a href="#" onclick="Add2WishList(document.OrderItemAddForm, '<c:out value="${childItem.itemID}" />'); return false;" id="WC_CachedProductItemDisplay_Link_5_<c:out value="${status.count}"/>" class="t_button"><fmt:message key="WISHLIST" bundle="${storeText}" /></a>
													</flow:ifEnabled>
													-->
													</c:otherwise>
													</c:choose>
													</flow:ifEnabled>
													
													<flow:ifDisabled feature="GiftRegistry">
													<a href="#" onclick="Add2ShopCart(document.OrderItemAddForm, '<c:out value="${childItem.itemID}" />',document.OrderItemAddForm.item_quantity_<c:out value="${childItem.itemID}" />.value); return false;" id="WC_CachedProductItemDisplay_Link_4_<c:out value="${status.count}"/>" class="t_button">&nbsp;<fmt:message key="ADD_SHOPPING_CART" bundle="${storeText}" />&nbsp;</a>
													<flow:ifEnabled  feature="wishList">
													<a href="#" onclick="Add2WishList(document.OrderItemAddForm, '<c:out value="${childItem.itemID}" />'); return false;" id="WC_CachedProductItemDisplay_Link_5_<c:out value="${status.count}"/>" class="t_button"><fmt:message key="WISHLIST" bundle="${storeText}" /></a>
													</flow:ifEnabled>
													</flow:ifDisabled>
													<%-- 
													  ***
													  *	End: GiftRegistryCode
													  ***
													--%>	

												</c:when>
												<c:otherwise>
													<fmt:message var="notBuyableMessage" key="SKU_NOT_BUYABLE" bundle="${storeText}" />
													<c:if test="${notBuyableMessage != '???SKU_NOT_BUYABLE???'}" >
														<span class="text"><c:out value="${notBuyableMessage}" /></span><br/><br/>
													</c:if>
												</c:otherwise>
												</c:choose>	
												<%-- 
												  ***
												  *	End: 'Add to ShopCart', 'Add to Wish List' buttons ('Home page' button if the SKU is not buyable)
												  ***
												--%>
												</td>
												</tr>
												</tbody></table>
											</td>
										</tr>
										</c:forEach>
										</tbody></table>
										<%-- 
										  ***
										  *	End: Table listing the child items of this product
										  ***
										--%>
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

<!-- End - JSP File Name: CachedProductItemDisplay.jsp -->
