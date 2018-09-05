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

<!-- Start - JSP File Name: CachedProductOnlyDisplay.jsp -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
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
<wcbase:useBean id="product" classname="com.ibm.commerce.catalog.beans.ProductDataBean" scope="request" />

<jsp:useBean id="attributeMap" class="java.util.HashMap" scope="request"/>
<jsp:useBean id="attributeIdMap" class="java.util.HashMap" scope="request"/>
<c:forEach var="item" items="${product.publishedItems}" varStatus="itemStatus">
	<c:forEach var="attributeValues" items="${item.attributeValueDataBeans}" >
		<c:set var = "keyVar" value="${attributeValues.attributeDataBean.name}"/>
		<c:set var = "value" value="${attributeValues.value}"/>
		<c:set var = "values" value="${attributeMap[keyVar]}"/>
		<c:choose>
			<c:when test="${empty values}">
				<c:set target="${attributeMap}" property="${keyVar}" value="${value}"/>
				<c:set target="${attributeIdMap}" property="${keyVar}" value="${attributeValues.attributeDataBean.attributeId}"/>
			</c:when>	
			<c:otherwise>
				<c:set var = "valueExist" value="false"/>
				<c:set var="attributeList" value="${fn:split(values, ',')}"/>
				<c:forEach var="attributeValue" items="${attributeList}">
					<c:if test="${value==attributeValue}">
						<c:set var = "valueExist" value="true"/>
					</c:if>
				</c:forEach>
				<c:if test="${valueExist!=true}">
					<c:set target="${attributeMap}" property="${keyVar}" value="${values},${value}"/>
				</c:if>
			</c:otherwise>	
		</c:choose>
	</c:forEach>
</c:forEach>

<%-- 
***
* Start:  Pass the current product ID being displayed on this page to the discount code
***
--%>
	<%-- Flush the buffer so this fragment JSP is not cached twice --%>
	<%out.flush();%>
	<c:import url="${jspStoreDir}include/DiscountJavaScriptSetup.jsp">
		<c:param name="jsPrototypeName" value="Discount" />
		<c:param name="someProductIDs" value="${productId}"/>
		<c:param name="productIncludeChildItems" value="true"/>
		<c:param name="productIsProdPromoOnly" value="false"/>
		<c:param name="productIncludeParentProduct" value="false"/>
	</c:import>
	<%out.flush();%>
<%-- 
***
* End:  Pass the current product ID being displayed on this page to the discount code
***
--%>


<c:if test="${ !empty WCParam.parent_category_rn }" >
	<%-- CategoryDataBean is used to show the name of the parent category --%>
	<wcbase:useBean id="parentCategory" classname="com.ibm.commerce.catalog.beans.CategoryDataBean" >
		<c:set property="categoryId" value="${WCParam.parent_category_rn}" target="${parentCategory}" />
	</wcbase:useBean>
</c:if>

<%-- Dummy category data bean is used for categories sidebar --%>
<c:set var="category" value="${parentCategory}" />

<script type = "text/javascript" language="javascript" src="<c:out value="${jspStoreImgDir}javascript/ItemDisplaySetup.js"/>"></script>

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
							<span class="heading"><c:out value="${product.description.name}" escapeXml="false"/></span>

							<table cellpadding="0" cellspacing="0" border="0" class="t_table" id="table">
								<tr>
									<%-- Show product image and short description if available --%>
									<td class="c_large_img">
									<c:choose>
										<c:when test="${!empty product.description.fullImage}">
											<br/><span class="t_img_border"><img
												src="<c:out value="${product.objectPath}${product.description.fullImage}" />"
												alt="<c:out value="${product.description.shortDescription}" />"
												border="0" width="${imgWidth}" height="${imgHeight}" /></span><br/>
										</c:when>
										<c:otherwise>
											<img
												src="<c:out value="${jspStoreImgDir}" />images/NoImageIcon.jpg"
												alt="<fmt:message key="No_Image" bundle="${storeText}"/>"
												border="0" /><br/>
										</c:otherwise>
									</c:choose>
									</td>
									<td valign="top">
										<span class="productName"><c:out value="${product.description.shortDescription}" escapeXml="false"/></span>
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
										
										<c:set var="hasDefiningAttribute" value="false" />
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
											<c:if test="${ attribute.usage=='Defining' }" >
												<c:set var="hasDefiningAttribute" value="true" />
											</c:if>
										</c:forEach>
										<br/>
										<%-- 
										  ***
										  *	End: Descriptive Attributes
										  ***
										--%>		
																		
										<%-- 
										  ***
										  *	Start: Product Price
										  * List price is only displayed if it is greater than the product price and if the product does not have price range (i.e. min price == max price) 
										  ***
										--%>
										<table cellpadding="0" cellspacing="0" border="0" class="t_table">
											<tr>
												<td valign="top"><span class="productName"><fmt:message key="PRICE" bundle="${storeText}" /></span>
													<c:set var="type" value="product"/>
													<c:set var="catalogEntry" value="${product}"/>
													<c:set var="displayPriceRange" value="true"/>
													<%@ include file="../../../Snippets/ReusableObjects/CatalogEntryPriceDisplay.jspf"%>
												</td>
												<td width="70%"></td>
											</tr>
										</table>
										<%--
											***
											* End: Product Price
											***
										--%>
										<br/>

										<form name="OrderItemAddForm" action="" method="post" id="OrderItemAddForm">
										<input type="hidden" name="storeId" value="<c:out value="${WCParam.storeId}" />" id="WC_CachedProductOnlyDisplay_FormInput_storeId_In_OrderItemAddForm_1"/>
										<input type="hidden" name="orderId" value="." id="WC_CachedProductOnlyDisplay_FormInput_orderId_In_OrderItemAddForm_1"/>
										<input type="hidden" name="catalogId" value="<c:out value="${WCParam.catalogId}" />" id="WC_CachedProductOnlyDisplay_FormInput_catalogId_In_OrderItemAddForm_1"/>
										<input type="hidden" name="URL" value="" id="WC_CachedProductOnlyDisplay_FormInput_URL_In_OrderItemAddForm_1"/>
										<input type="hidden" name="errorViewName" value="ProductDisplayErrorView" id="WC_CachedProductOnlyDisplay_FormInput_errorViewName_In_OrderItemAddForm_1"/>
										<input type="hidden" name="catEntryId" value="<c:out value="${productId}" />" id="WC_CachedProductOnlyDisplay_FormInput_catEntryId_In_OrderItemAddForm_1"/>
										<input type="hidden" name="productId" value="<c:out value="${productId}" />" id="WC_CachedProductOnlyDisplay_FormInput_productId_In_OrderItemAddForm_1"/>
										<input type="hidden" name="calculationUsageId" value="-1" id="WC_CachedProductOnlyDisplay_FormInput_calculationUsageId_In_OrderItemAddForm_1"/>
										<%-- shouldCachePage is used to tell the server not to cache this page.  So if an error happens, this page is redrawn with an error message --%>
										<input type="hidden" name="shouldCachePage" value="false" id="WC_CachedProductOnlyDisplay_FormInput_shouldCachePage_In_OrderItemAddForm_1"/>
										<%-- DO NOT REMOVE: requisitionListId is used in B2BDirect store --%>
										<input type="hidden" name="requisitionListId" value="false" id="WC_CachedProductOnlyDisplay_FormInput_requisitionListId_In_OrderItemAddForm_1"/>
								
										<%-- 
											***
											*	Start: Quantity display 
											*	Display the quantity if the 'ProductQuantity' flexflow option is enabled, the product is buyable, and has a price. 
											***
										--%>
											<c:if test="${ !empty param.summaryOnly }" >
											<a href="javascript:history.back();" id="WC_CachedItemDisplay_Link_OrderSummary" class="button"><fmt:message key="RETURN_TO_ORDER_SUMMARY" bundle="${storeText}" /></a>&nbsp;
											<br/>
										    </c:if>
										<c:if test="${ empty WCParam.summaryOnly }" >
											<flow:ifEnabled feature="ProductQuantity">	
											<c:if test="${product.buyable==1 && !empty product.maximumItemPrice}"> 
												<span class="productName"><label for="WC_CachedProductOnlyDisplay_FormInput_quantity_In_OrderItemAddForm_1"><fmt:message key="QUANTITY2" bundle="${storeText}" /></label>&nbsp;&nbsp;</span>
												<input type="text" value="1" name="quantity" size="5" id="WC_CachedProductOnlyDisplay_FormInput_quantity_In_OrderItemAddForm_1"/>
											<br/>
											</c:if>
											</flow:ifEnabled>
										</c:if>
										<flow:ifDisabled feature="ProductQuantity">
											<input type="hidden" name="quantity" value="1" id="WC_CachedProductOnlyDisplay_FormInput_quantity_In_OrderItemAddForm_2"/>
										</flow:ifDisabled>			
										<br/>								
										<%--
											***
											* 	End:Quantity display
											***
										--%>

										<%-- 
										  ***
										  *	Start: Defining Attributes
										  * The drop down box will only display defining attributes.
										  * Defining attributes are properties of SKUs.  They are used for SKU resolution.
										  ***
										--%>
										<!-- Display product attributes !-->
										<%-- the drop down box will only display defining attributes --%>
										<c:if test="${ empty param.summaryOnly }" >
											<c:if test="${hasDefiningAttribute}">
												<span class="required">*</span>&nbsp;<fmt:message key="REQUIRED_FIELDS" bundle="${storeText}" />
												<br/>
											</c:if>
											<c:forEach var="attribute" items="${catalogEntryAttributes.catalogEntryAttributes.attributes}" varStatus="status">
												<c:if test="${ attribute.usage=='Defining' }" >										
													<input type="hidden" name="attrName" value="<c:out value="${attribute.attributeIdentifier.uniqueID}" />" id="WC_CachedProductOnlyDisplay_FormInput_attrName_In_OrderItemAddForm_1_<c:out value="${status.count}"/>"/>
													<br/><span class="required">*</span>
													<fmt:message var="selectAttribute" key="SELECT_ATTRIBUTE" bundle="${storeText}">
														<fmt:param><c:out value="${attribute.name}"/></fmt:param>
													</fmt:message>
													<label for="attrValue"></label>
													<select class="select" id="attrValue" title="<c:out value="${selectAttribute}"/>" name="attrValue">
														<%-- Display the first option in the drop down as: Select Attribute.Name --%>
														<option value="">
																<fmt:message key="SELECT_ATTRIBUTE" bundle="${storeText}">
																	<fmt:param><c:out value="${attribute.name}" /></fmt:param>
																</fmt:message>
														</option>
														<c:forEach var="attributeValue" items="${attribute.allowedValue}">
															<c:choose>
																<c:when test="${WCParamValues.attrValue[aStatus.count-1] == attributeValue.value}">
																	<option selected="selected" value="<c:out value="${attributeValue.value}" />"><c:out value="${attributeValue.value}" /></option>
																</c:when>
																<c:otherwise>
																	<option value="<c:out value="${attributeValue.value}" />"><c:out value="${attributeValue.value}" /></option>
																</c:otherwise>
															</c:choose>
										
														</c:forEach>
													</select>
												</c:if>
											</c:forEach>
											
											<c:if test="${hasDefiningAttribute}">
												<br/><br/>
											</c:if>
										</c:if>
										<%-- 
										  ***
										  *	End: Defining Attributes
										  ***
										--%>
										<c:if test="${!empty errorMessage}">
											<%-- 
											  ***
											  *	Start: Error handling
											  * An error occurs if a customer enters an invalid quantity, or if the products the customer wish to purchase are not available.
											  ***
											--%>
											<span class="error"><c:out value="${errorMessage}" escapeXml="false" /></span>
											<%-- 
											  ***
											  *	End: Error handling
											  ***
											--%>
											<br/>
											<br/>
										</c:if>

										<%-- We output the discounts using simple JavaScript to support older browsers such as Netscape 4  --%>
										<script type="text/javascript">
											document.write(Discount.getProductDiscountText(<c:out value="${productId}"/>));
										</script>		
										<br/><br/>

										<c:if test="${ empty WCParam.summaryOnly }" >																	
										<table cellpadding="1" cellspacing="0" border="0" width="100%" id="WC_CachedProductOnlyDisplay_Table_5">
											<tbody>
												<tr>
													<td valign="top" id="WC_CachedProductOnlyDisplay_TableCell_8">
													<%-- 
													  ***
													  *	Start: 'Add to ShopCart', 'Add to Wish List' buttons ('Home page' button if the product is not buyable)
													  * If maximum item price is null, the child items have no price, and the 'add to cart' button will not be displayed 
													  * Also, if the product only has 1 child item, and the buyable flag of this item is set to 0, the 'add to cart' button will not be displayed.
													  ***
													--%>
								
													<c:choose>
														<c:when test="${!empty product.maximumItemPrice && !(empty product.entitledItems[1] && product.entitledItems[0].buyable eq '0')}" >
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
			
																	<a href="#" onclick="Add2ShopCart(document.OrderItemAddForm); return false;" id="WC_CachedProductOnlyDisplay_Link_5" class="button"><fmt:message key="ADD_SHOPPING_CART" bundle="${storeText}" /></a>
																	&nbsp;
																	<%-- 
																	  ***
																	  *	Start: GiftRegistryCode
																	  *
																	  ***
																	--%>
																	<!--
		
																	<flow:ifEnabled  feature="wishList">
																	<a href="#" onclick="Add2WishList(document.OrderItemAddForm); return false;" class="button" id="WC_CachedProductOnlyDisplay_Link_6"><fmt:message key="WISHLIST" bundle="${storeText}" /></a>
																	</flow:ifEnabled>
																	-->															
															    <%@ include file="AddToGiftRegistryDisplay.jspf" %>
													    	</c:otherwise>
													    </c:choose>
													   	</flow:ifEnabled>
															<flow:ifDisabled feature="GiftRegistry">
																<a href="#" onclick="Add2ShopCart(document.OrderItemAddForm); return false;" id="WC_CachedProductOnlyDisplay_Link_5" class="button"><fmt:message key="ADD_SHOPPING_CART" bundle="${storeText}" /></a>
																&nbsp;
																<flow:ifEnabled  feature="wishList">
																<a href="#" onclick="Add2WishList(document.OrderItemAddForm); return false;" class="button" id="WC_CachedProductOnlyDisplay_Link_6"><fmt:message key="WISHLIST" bundle="${storeText}" /></a>
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
																<c:url var="TopCategoriesDisplayURL" value="TopCategoriesDisplay">
																	<c:param name="langId" value="${langId}" />
																	<c:param name="storeId" value="${WCParam.storeId}" />
																	<c:param name="catalogId" value="${WCParam.catalogId}" />
																</c:url>
																<fmt:message var="returnShoppingMessage" key="RETURN_SHOPPING" bundle="${storeText}" />
																<c:if test="${returnShoppingMessage == '???RETURN_SHOPPING???'}" >
																	<fmt:message var="returnShoppingMessage" key="Home_Button1" bundle="${storeText}" />
															  </c:if>
															<a href="<c:out value="${TopCategoriesDisplayURL}" />" id="WC_CachedProductOnlyDisplay_Link_5" class="button"><c:out value="${returnShoppingMessage}" /></a>&nbsp;
														</c:otherwise>
													</c:choose>							
													<%-- 
													  ***
													  *	End: 'Add to ShopCart', 'Add to Wish List' buttons ('Home page' button if the product is not buyable)
													  ***
													--%>
													</td>
												</tr>
											</tbody>
										</table><br/>
										</c:if>	
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

<!-- End - JSP File Name: CachedProductOnlyDisplay.jsp -->
