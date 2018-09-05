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
  * This JSP will display  more details about the items that compose the prebuilt kit (Packages are also called prebuilt kits).
  * It shows the following information:
  *  - Package full-sized image, name, long description and descriptive attributes
  *  - Package contract price and list price
  *  - All the items in this package. For each item, it shows the following:
  *    - Full-sized image, name, and long description
  *    - Defining and Descriptive attributes, which are displayed as name:value
  *  - Quantity box to enter the quantity (default is 1)
  *  - 'Add to shopping cart' button, 'Add to wish list' button for B2C
  * This is an example of how this file could be included into a page: 
  *<c:import url="../../../Snippets/Catalog/CatalogEntryDisplay/CachedPackageDisplay.jsp">
  *          <c:param name="storeId" value="${storeId}"/>
  *          <c:param name="catalogId" value="${catalogId}"/>
  *          <c:param name="langId" value="${langId}"/>
  *          <c:param name="productId" value="${productId}"/>
  *          <c:param name="shouldCachePage" value="true"/>
  *</c:import>
  * Note: Since all items in a prebuilt kit cannot be sold separately, a prebuilt kit counts as one item in the shopping cart.
  *****
--%>

<!-- Start - JSP File Name: CachedPackageDisplay.jsp -->

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf"%>

<%-- ErrorMessageSetup.jspf is used to retrieve an appropriate error message when there is an error --%>
<%@ include file="../../../include/ErrorMessageSetup.jspf" %>

<script type="text/javascript" language="javascript" src="<c:out value="${jspStoreImgDir}javascript/PackageBundleDisplaySetup.js"/>"></script>

<c:if test="${empty imgHeight}">
	<c:set var="imgHeight" value="150"/>
</c:if>
<c:if test="${empty imgWidth}">
	<c:set var="imgWidth" value="150"/>
</c:if>


<wcbase:useBean id="packageDataBean" classname="com.ibm.commerce.catalog.beans.PackageDataBean"  scope="request" />

<%-- Pass the Package ID to the discount JavaScript --%>
<%-- Flush the buffer so this fragment JSP is not cached twice --%>
<%out.flush();%>
<c:import url="${jspStoreDir}include/DiscountJavaScriptSetup.jsp">
	<c:param name="jsPrototypeName" value="Discount" />
	<c:param name="someItemIDs" value="${productId}"/>
	<c:param name="itemIncludeChildItems" value="false"/>
	<c:param name="itemIsProdPromoOnly" value="false"/>
	<c:param name="itemIncludeParentProduct" value="true"/>
</c:import>
<%out.flush();%>

<c:if test="${ !empty WCParam.parent_category_rn }" >
	<%-- CategoryDataBean is used to show the name of the parent category --%>
	<wcbase:useBean id="parentCategory" classname="com.ibm.commerce.catalog.beans.CategoryDataBean" >
		<c:set property="categoryId" value="${WCParam.parent_category_rn}" target="${parentCategory}" />		
	</wcbase:useBean>

	<%-- Dummy category data bean is used for categories sidebar --%>
	<c:set var="category" value="${parentCategory}" />

</c:if>

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
							<h1><c:out value="${packageDataBean.description.name}" escapeXml="false"/></h1>
							<table cellpadding="0" cellspacing="0" border="0" class="t_table" id="table">
								<tr>
									<%-- Show product image and short description if available --%>
									<td class="c_large_img">
									<c:choose>
										<c:when test="${!empty packageDataBean.description.fullImage}">
											<br/><span class="t_img_border"><img
												src="<c:out value="${packageDataBean.objectPath}${packageDataBean.description.fullImage}" />"
												alt="<c:out value="${packageDataBean.description.shortDescription}" />"
												border="0" width="${imgWidth}" height="${imgHeight}" /></span><br/>
										</c:when>
										<c:otherwise>
											<img 
												src="<c:out value="${jspStoreImgDir}"/>images/NoImageIcon.jpg" 
												alt="<fmt:message key="No_Image" bundle="${storeText}"/>" 
												border="0"/><br/>					
										</c:otherwise>
									</c:choose> 
									</td>
									<td valign="top">
										<span class="productName"><c:out value="${packageDataBean.description.shortDescription}" escapeXml="false"/></span>
										<br/><br/>
										<span class="text"><fmt:message key="SKU" bundle="${storeText}" />:</span><span class="text"><c:out value="${packageDataBean.partNumber}" /></span>
										<br/><br/>
 										<span class="text"><c:out value="${packageDataBean.description.longDescription}" escapeXml="false" /></span><br/><br/>
										
										<form name="OrderItemAddForm" action="" method="post" id="OrderItemAddForm">
										<input type="hidden" name="orderId" value="." id="WC_CachedPackageDisplay_FormInput_orderId_In_OrderItemAddForm_1"/>
										<input type="hidden" name="storeId" value="<c:out value="${WCParam.storeId}" />" id="WC_CachedPackageDisplay_FormInput_storeId_In_OrderItemAddForm_1"/>
										<input type="hidden" name="catalogId" value="<c:out value="${WCParam.catalogId}" />" id="WC_CachedPackageDisplay_FormInput_catalogId_In_OrderItemAddForm_1"/>
										<input type="hidden" name="catEntryId" value="<c:out value="${packageDataBean.packageID}" />" id="WC_CachedPackageDisplay_FormInput_catEntryId_In_OrderItemAddForm_1"/>
										<input type="hidden" name="productId" value="<c:out value="${packageDataBean.packageID}" />" id="WC_CachedPackageDisplay_FormInput_productId_In_OrderItemAddForm_1"/>
										<input type="hidden" name="URL" value="OrderItemDisplay?orderId=." id="WC_CachedPackageDisplay_FormInput_URL_In_OrderItemAddForm_1"/>
										<input type="hidden" name="errorViewName" value="ProductDisplayErrorView" id="WC_CachedPackageDisplay_FormInput_errorViewName_In_OrderItemAddForm_1"/>
										<input type="hidden" name="calculationUsageId" value="-1" id="WC_CachedPackageDisplay_FormInput_calculationUsageId_In_OrderItemAddForm_1"/>
										<%-- shouldCachePage is used to tell the server not to cache this page.  So if an error happens, this page is redrawn with an error message --%>
										<input type="hidden" name="shouldCachePage" value="false" id="WC_CachedPackageDisplay_FormInput_shouldCachePage_In_OrderItemAddForm_1"/>
										<%-- DO NOT REMOVE: requisitionListId is used in B2BDirect store --%>
										<input type="hidden" name="requisitionListId" value="false" id="WC_CachedPackageDisplay_FormInput_requisitionListId_In_OrderItemAddForm_1"/>
										
										<%-- 
										  ***
										  *	Start: Show Catalog Attachments
										  * The attachments for each usage will be displayed
										  ***
										--%>
										<c:forEach var="attachUsage" items="${packageDataBean.attachmentUsages}" >	
											<c:set property="attachmentUsage" value="${attachUsage.identifier}" target="${packageDataBean}" />
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
														<c:set var="AttachmentDataBeans" value="${packageDataBean.attachmentsByUsage}" />
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
										
										<%-- 
										  ***
										  *	Start: Descriptive Attributes
										  * Descriptive attributes are simply displayed as 'name:value'. They are not used for SKU resolution.
										  ***
										--%>
										<wcf:getData type="com.ibm.commerce.catalog.facade.datatypes.CatalogEntryType" var="catalogEntryAttributes" expressionBuilder="getStoreCatalogEntryAttributesByID">
											<wcf:contextData name="storeId" data="${param.storeId}"/>
											<wcf:param name="catEntryId" value="${packageDataBean.packageID}"/>
											<wcf:param name="dataLanguageIds" value="${WCParam.langId}"/>
										</wcf:getData>
										
										<c:forEach var="attribute" items="${catalogEntryAttributes.catalogEntryAttributes.attributes}">
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
								
										<%-- 
										  ***
										  *	Start: Package Price
										  * Show the list price only if it is larger than the package price
										  ***
										--%>	
										<c:if test="${empty param.displayContractPrices }" >
										<table valign="top" cellpadding="0" cellspacing="0" border="0" class="t_table">
											<tr>
												<td valign="top" align="left">
													<span class="productName"><fmt:message key="ITEM_PRICE" bundle="${storeText}" />: </span>
												</td>
												<td valign="top" align="right" class="price">
													<c:set var="type" value="package"/>
													<c:set var="catalogEntry" value="${packageDataBean}"/>
													<%@ include file="../../../Snippets/ReusableObjects/CatalogEntryPriceDisplay.jspf"%>
												</td>
												<td width="70%"></td>
											</tr>
										</table>
										</c:if>
										<%-- 
										  ***
										  *	End: Package Price
										  ***
										--%>						
										
										<br/>
										<c:if test="${ empty WCParam.summaryOnly }" >
											<flow:ifEnabled feature="ProductQuantity">	
												<span class="productName"><label for="WC_CachedItemDisplay_FormInput_quantity_In_OrderItemAddForm_1"><fmt:message key="QUANTITY2" bundle="${storeText}" /></label>&nbsp;&nbsp;</span>
												<input class="input" type="text" value="1" name="quantity" size="5" id="WC_CachedItemDisplay_FormInput_quantity_In_OrderItemAddForm_1"/>
												<br/>
											</flow:ifEnabled>
										</c:if>
										<flow:ifDisabled feature="ProductQuantity">
											<input type="hidden" name="quantity" value="1" id="WC_CachedItemDisplay_FormInput_quantity_In_OrderItemAddForm_2"/>
										</flow:ifDisabled>			

	<c:if test="${!empty param.displayContractPrices }" >
			  <br/>
                          <table width="100%" border="0" cellpadding="2" cellspacing="1" class="bgColor" id="WC_CachedPackageDisplay_Table_4">
                              <tr>
                                <th class="colHeader" id="WC_CachedPackageDisplay_TableCell_5"></th>
                                <th class="colHeader" id="WC_CachedPackageDisplay_TableCell_7"><fmt:message key="PackageDisplay_Contract" bundle="${storeText}"/></th>
                                <th class="colHeader_price" id="WC_CachedPackageDisplay_TableCell_9" style="border-right:solid 1px #929499;"><fmt:message key="PackageDisplay_Price" bundle="${storeText}"/></th>
                              </tr>
                              <c:set var="actualCount" value="0"/>
                              <%--check if numberOfApplicableContractIds is available first before accessing it--%>
                              <c:choose> 
                                     <c:when test="${packageDataBean.checkNumberOfApplicableContractIds}" >
                                     <c:forEach var="i" begin="0" end="${packageDataBean.numberOfApplicableContractIds}" varStatus="appContractIdCounter">
                                                 <c:set var="rowColor" value="cellBG_${actualCount%2 + 1}"/> 
                                                 <c:if test="${!empty packageDataBean.applicableContractPrices[i]}">
                                                          <tr>
                                                            <td headers="WC_CachedPackageDisplay_TableCell_5" class="<c:out value="${rowColor}"/> t_td" id="WC_CachedPackageDisplay_TableCell_10_<c:out value="${i}"/>"><input id="WC_CachedPackageDisplay_FormInput_contractId_In_OrderItemAddForm_1_<c:out value="${i}"/>" class="radio" type="radio" name="contractId" value="<c:out value="${packageDataBean.applicableContractIds[i]}"/>"<c:if test="${actualCount == 0}"> checked="checked"</c:if> ></td>
                                                            <td headers="WC_CachedPackageDisplay_TableCell_7" class="<c:out value="${rowColor}"/> t_td" id="WC_CachedPackageDisplay_TableCell_11_<c:out value="${i}"/>"><label for="WC_CachedPackageDisplay_FormInput_contractId_In_OrderItemAddForm_1_<c:out value="${i}"/>"><c:out value="${packageDataBean.applicableContracts[i].name}"/></label>&nbsp;[<c:out value="${packageDataBean.applicableContractIds[i]}"/>]</td>
                                                            <td headers="WC_CachedPackageDisplay_TableCell_9" class="<c:out value="${rowColor}"/> price t_td" id="WC_CachedPackageDisplay_TableCell_12_<c:out value="${i}"/>">
                                        <c:forEach var="contractPriceRange" items="${packageDataBean.applicableContractPriceRanges}" varStatus="priceRangeContractCounter">
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
                                <p/><fmt:message key="PackageDisplay_ContractPriceNotAvailable" bundle="${storeText}"/>
                                   </c:otherwise>
                           </c:choose>
		</table>
	</c:if>
										

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
										<br/>
										<c:if test="${ !empty WCParam.summaryOnly }" >
											<a href="javascript:history.back();" id="WC_CachedItemDisplay_Link_OrderSummary" class="button"><fmt:message key="RETURN_TO_ORDER_SUMMARY" bundle="${storeText}" /></a>&nbsp;
											<br/>
										</c:if>
										
										<c:if test="${ empty WCParam.summaryOnly }" >
										<table cellpadding="1" cellspacing="0" border="0" width="100%" id="WC_CachedItemDisplay_Table_5">
											<tbody>
												<tr>
													<td valign="top" id="WC_CachedItemDisplay_TableCell_8">
													<%-- 
													  ***
													  *	Start: 'Add to ShopCart', 'Add to Wish List' buttons ('Home page' button if the SKU is not buyable)
													  *     If item.isCalculatedContractPrice() is false or if the buyable flag is set to 0, this means that the SKU is not buyable and the add to cart button will not be displayed
													  *
													  ***
													--%>

													<c:choose>
														<c:when test="${packageDataBean.calculatedContractPriced && packageDataBean.buyable ne '0'}" >
															
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
														<%-- this is not a gift consultant session --%>    	                    
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
														  *
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
															<br/><br/>
															<span class="text"><fmt:message key="KIT_NOT_BUYABLE" bundle="${storeText}" /></span><br/><br/>															
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
									<td valign="top" colspan="2">
										<%-- 
										  ***
										  *	Start: List the information of the products that compose the bundle
										  ***
										--%>
										
										<table width="100%" border="0" cellpadding="2" cellspacing="0" id="WC_CachedProductItemDisplay_Table_3">
										<tbody><tr>
											<th colspan="2" id="Table_Name" class="colHeader">
												<fmt:message key="TABLE_NAME" bundle="${storeText}" />
											</th>
											<th id="Table_Item_Quantity" class="colHeader">
												<span class="t_hd_cntr"><fmt:message key="PRODUCT_ITEM_QUANTITY" bundle="${storeText}"/></span>
											</th>
											<th id="Table_Price" class="colHeader_last" colspan="2">
												<span class="t_hd_rght"><fmt:message key="TABLE_PRICE" bundle="${storeText}"/></span>
											</th>											
										</tr>
										
										<c:forEach var="compositeProduct" items="${packageDataBean.packagedProducts}" varStatus="status">
											<c:url var="ProductDisplayURL" value="ProductDisplay">
											  <c:param name="productId" value="${compositeProduct.product.productID}" />
											  <c:param name="langId" value="${langId}" />
											  <c:param name="storeId" value="${WCParam.storeId}" />
											  <c:param name="catalogId" value="${WCParam.catalogId}" />
											  <c:if test="${ !empty WCParam.parent_category_rn }" >
											    <c:param name="parent_category_rn" value="${WCParam.parent_category_rn}" />
											  </c:if>
											</c:url>
																						
											<%-- Show the thumbnail image of the composite product --%>
											<td headers="Table_Small_Image" class="t_td" id="WC_CachedProductItemDisplay_TableCell_8_<c:out value="${status.count}"/>" valign="top">
												<a href="<c:out value="${ProductDisplayURL}" />" id="WC_CachedProductItemDisplay_Link_3_<c:out value="${status.count}"/>">
													<c:choose>
														<c:when test="${!empty compositeProduct.product.description.thumbNail}">
															<span class="t_img_border"><img src="<c:out value="${compositeProduct.product.objectPath}${compositeProduct.product.description.thumbNail}" />" alt="<c:out value="${compositeProduct.product.description.name}" />" hspace="5" border="0"/></span>
														</c:when>
														<c:otherwise>
															<img src="<c:out value="${jspStoreImgDir}"/>images/NoImageIcon_sm.jpg" alt="<fmt:message key="No_Image" bundle="${storeText}"/>" hspace="5" border="0"/>						
														</c:otherwise>
													</c:choose>
												</a>
											</td>
											
											<%-- Show the name of the composite product --%>
											<td headers="Table_Name" width="304" class="t_td" id="WC_CachedProductItemDisplay_TableCell_9_<c:out value="${status.count}"/>" valign="top">
												<span class="text">
												<a class="catalog" href="<c:out value="${ProductDisplayURL}" />" id="WC_CachedProductItemDisplay_Link_2_<c:out value="${status.count}"/>">
													<c:out value="${compositeProduct.product.description.name}" escapeXml="false" /></a>
												<br/>
												<c:out value="${compositeProduct.product.description.longDescription}" escapeXml="false" />
												<br/>
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
																	<option selected="selected"><c:out value="${attributeValue.value}" /></option>
																</c:when>
																<c:otherwise>
																	<option value="<c:out value="${attributeValue.identifier}" />"><c:out value="${attributeValue.value}" /></option>
																</c:otherwise>
															</c:choose>
										
														</c:forEach>
													</select>
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
											
											<td headers="Table_Item_Quantity" class="t_td" align="middle"><c:out value="${compositeProduct.formattedQuantity}" /></td>
						
											<td headers="Table_Price" class="t_td" id="WC_CachedProductItemDisplay_TableCell_10_<c:out value="${status.count}"/>" valign="top" align="right">
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
										<c:set var="numberOfProduct" value="${status.count}" />

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
										
										<c:forEach var="compositeItem" items="${packageDataBean.packagedItems}" varStatus="iStatus">
											<c:url var="ItemDisplayURL" value="ProductDisplay">
											  <c:param name="productId" value="${compositeItem.item.itemID}" />
											  <c:param name="langId" value="${langId}" />
											  <c:param name="storeId" value="${WCParam.storeId}" />
											  <c:param name="catalogId" value="${WCParam.catalogId}" />
											  <c:if test="${ !empty WCParam.parent_category_rn }" >
											    <c:param name="parent_category_rn" value="${WCParam.parent_category_rn}" />
											  </c:if>
											</c:url>
																						
											<%-- Show the thumbnail image of the composite item --%>
											<td headers="Table_Small_Image" class="t_td" id="WC_CachedProductItemDisplay_TableCell_8_<c:out value="${iStatus.count}"/>" valign="top">
												<a href="<c:out value="${ItemDisplayURL}" />" id="WC_CachedProductItemDisplay_Link_3_<c:out value="${iStatus.count}"/>">
													<c:choose>
														<c:when test="${!empty compositeItem.item.description.thumbNail}">
															<span class="t_img_border"><img src="<c:out value="${compositeItem.item.objectPath}${compositeItem.item.description.thumbNail}" />" alt="<c:out value="${compositeItem.item.description.name}" />" hspace="5" border="0"/></span>
														</c:when>
														<c:otherwise>
															<img src="<c:out value="${jspStoreImgDir}"/>images/NoImageIcon_sm.jpg" alt="<fmt:message key="No_Image" bundle="${storeText}"/>" hspace="5" border="0"/>						
														</c:otherwise>
													</c:choose>
												</a>

											</td>
											
											<%-- Show the name of the composite product --%>
											<td headers="Table_Name" width="304" class="t_td" id="WC_CachedProductItemDisplay_TableCell_9_<c:out value="${iStatus.count}"/>" valign="top">
												<span class="text">
												<a class="catalog" href="<c:out value="${ItemDisplayURL}" />" id="WC_CachedProductItemDisplay_Link_2_<c:out value="${iStatus.count}"/>">
													<c:out value="${compositeItem.item.description.name}" escapeXml="false" /></a>
												<br/>
												<c:out value="${compositeItem.item.description.longDescription}" escapeXml="false" />
												<br />
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
						
											<td headers="Table_Item_Quantity" class="t_td" align="middle"><c:out value="${compositeItem.formattedQuantity}" /></td>
						
											<td headers="Table_Price" class="t_td" id="WC_CachedProductItemDisplay_TableCell_10_<c:out value="${iStatus.count}"/>" valign="top" align="right">
											<%-- 
											  ***
											  *	Start: Item Price
											  * Show the list price only if it is larger than the item price
											  ***
											--%>
											<c:set var="type" value="item"/>
											<c:set var="catalogEntry" value="${compositeItem.item}"/>
											<%@ include file="../../../Snippets/ReusableObjects/CatalogEntryPriceDisplay.jspf"%>
											<%-- 
											  ***
											  *	End: Item Price
											  ***
											--%>
											</td>								
										</tr>

											<%-- get the numberOfProduct from the iStatus.count --%>
											<c:set var="numberOfProduct" value="${numberOfProduct + iStatus.count}" />

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
										
										<c:forEach var="compositePackage" items="${packageDataBean.packagedPackages}" varStatus="pStatus">
											<c:url var="PackageDisplayURL" value="ProductDisplay">
											  <c:param name="productId" value="${compositePackage.package.packageID}" />
											  <c:param name="langId" value="${langId}" />
											  <c:param name="storeId" value="${WCParam.storeId}" />
											  <c:param name="catalogId" value="${WCParam.catalogId}" />
											  <c:if test="${ !empty WCParam.parent_category_rn }" >
											    <c:param name="parent_category_rn" value="${WCParam.parent_category_rn}" />
											  </c:if>
											</c:url>
																						
											<%-- Show the thumbnail image of the composite item --%>
											<td headers="Table_Small_Image" class="t_td" id="WC_CachedProductItemDisplay_TableCell_8_<c:out value="${pStatus.count}"/>" valign="top">											
												<a href="<c:out value="${PackageDisplayURL}" />" id="WC_CachedProductItemDisplay_Link_3_<c:out value="${pStatus.count}"/>">
													<!--
													<img src="<c:out value="${compositePackage.package.objectPath}${compositePackage.package.description.thumbNail}" />" alt="<c:out value="${compositePackage.package.description.name}" />" hspace="5" border="0"/>
													-->
													<c:choose>
														<c:when test="${!empty compositePackage.package.description.thumbNail}">
															<span class="t_img_border"><img src="<c:out value="${compositePackage.package.objectPath}${compositePackage.package.description.thumbNail}" />" alt="<c:out value="${compositePackage.package.description.name}" />" hspace="5" border="0"/></span>
														</c:when>
														<c:otherwise>
															<img src="<c:out value="${jspStoreImgDir}"/>images/NoImageIcon_sm.jpg" alt="<fmt:message key="No_Image" bundle="${storeText}"/>" hspace="5" border="0"/>						
														</c:otherwise>
													</c:choose>
												</a>
											</td>
											
											<%-- Show the name of the composite product --%>
											<td headers="Table_Name" width="304" class="t_td" id="WC_CachedProductItemDisplay_TableCell_9_<c:out value="${pStatus.count}"/>" valign="top">
												<span class="text">
												<a class="catalog" href="<c:out value="${ItemDisplayURL}" />" id="WC_CachedProductItemDisplay_Link_2_<c:out value="${pStatus.count}"/>">
													<c:out value="${compositePackage.package.description.name}" escapeXml="false" /></a>
												<br/><br/>
												<c:out value="${compositePackage.package.description.longDescription}" escapeXml="false" />
												<br />
												</span>
											
											<%--
											  ***
											  * Start: Display Defining and Descriptive attributes
											  * First, loop through the attribute values and display the defining attributes
											  * Then, display the descriptive attributes and show the corresponding images if available
											  ***
											--%>
											<c:forEach var="definingAttrValue" items="${compositePackage.package.definingAttributeValueDataBeans}">
												<span class="productName"><c:out value="${definingAttrValue.attributeDataBean.name}" escapeXml="false"/> : </span><c:out value="${definingAttrValue.value}" escapeXml="false"/><br/>
											</c:forEach>
											<c:forEach var="descriptiveAttrValue" items="${compositePackage.package.descriptiveAttributeValueDataBeans}">
												<span class="productName" title="<c:out value="${descriptiveAttrValue.attributeDataBean.description}" escapeXml="false"/>" ><c:out value="${descriptiveAttrValue.attributeDataBean.name}" escapeXml="false"/>:</span>
												<c:choose>
													<c:when test="${ !empty descriptiveAttrValue.image1  }" >
														<c:out value="${descriptiveAttrValue.value}" escapeXml="false" />&nbsp;<img src="<c:out value="${compositePackage.package.objectPath}${descriptiveAttrValue.image1}" />" alt="<c:out value="${descriptiveAttrValue.value}" />" border="0"/><br/>
													</c:when>
													<c:otherwise >
														<c:out value="${descriptiveAttrValue.value}" escapeXml="false"/><br/>
													</c:otherwise>
												</c:choose>
											</c:forEach>
											<%--
											  ***
											  * End: Display Defining and Descriptive attributes
											  ***
											--%>					
											<br/>

											
											<%-- We output the discounts using simple JavaScript to support older browsers such as Netscape 4  --%>
											<script type="text/javascript">
												document.write(Discount.getPackageDiscountText(<c:out value="${compositePackage.package.packageID}"/>));
											</script>											
						
											</td>

											<td headers="Table_Item_Quantity" class="t_td" align="middle"><c:out value="${compositePackage.formattedQuantity}" /></td>
						
											<td headers="Table_Price" class="t_td" id="WC_CachedProductItemDisplay_TableCell_10_<c:out value="${pStatus.count}"/>" valign="top" align="right">
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

											<%-- get the numberOfProduct from the iStatus.count --%>
											<c:set var="numberOfProduct" value="${numberOfProduct + pStatus.count}" />

										</c:forEach>
										
										<%-- 
										  ***
										  *	End: List the information of the packages that compose the bundle
										  ***
										--%>			
																				
										</table>
										
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

<!-- End - JSP File Name: CachedPackageDisplay.jsp -->
