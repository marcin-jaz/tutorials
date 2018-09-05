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
  * This JSP will display the item details.  It shows the following information:
  *  - Item full-sized image, name and long description
  *  - Discount description if available
  *  - Item contract price and list price
  *  - Defining and Descriptive attributes, which are displayed as 'name:value'
  *  - Quantity box to enter the quantity (default is 1)
  *  - 'Add to shopping cart' button and 'Add to wish list' button for B2C button for B2B
  * This is an example of how this file could be included into a page: 
  *<c:import url="../../../Snippets/Catalog/CatalogEntryDisplay/CachedItemDisplay.jsp">
  *	    <c:param name="storeId" value="${storeId}"/>
  *    <c:param name="catalogId" value="${catalogId}"/>
  *    <c:param name="langId" value="${langId}"/>
  *    <c:param name="productId" value="${productId}"/>
  *    <c:param name="parent_category_rn" value="${parent_category_rn}"/>
  *    <c:param name="shouldCachePage" value="${shouldCachePage}"/>
  *    <c:param name="summaryOnly" value="${summaryOnly}"/>
  *</c:import>
  *****
--%>

<!-- Start - JSP File Name: CachedItemDisplay.jsp -->
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

<wcbase:useBean id="item" classname="com.ibm.commerce.catalog.beans.ItemDataBean" scope="request" />

<%-- 
***
* Start:  Pass the current item ID being displayed on this page to the discount code
***
--%>
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
<%-- 
***
* End:  Pass the current item ID being displayed on this page to the discount code
***
--%>

<c:if test="${ !empty WCParam.parent_category_rn }" >
	<%-- CategoryDataBean is used to show the name of the parent category --%>
	<wcbase:useBean id="parentCategory" classname="com.ibm.commerce.catalog.beans.CategoryDataBean" >
		<c:set property="categoryId" value="${WCParam.parent_category_rn}" target="${parentCategory}" />
	</wcbase:useBean>

	<%-- Dummy category data bean is used for categories sidebar --%>
	<c:set var="category" value="${parentCategory}" />

</c:if>

<script  type="text/javascript" language="javascript" src="<c:out value="${jspStoreImgDir}javascript/ItemDisplaySetup.js"/>"></script>

<table align="center" cellpadding="2" cellspacing="0" width="786" border="0" id="WC_CachedItemDisplay_Table_1">
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
							<h1><c:out value="${item.description.name}" escapeXml="false"/></h1>

							<table cellpadding="0" cellspacing="0" border="0" class="t_table" id="table">
								<tr>
									<%-- Show item image and short description if available --%>
									<td class="c_large_img">&nbsp;
									<!--
									<c:if test="${!empty item.description.fullImage}">
										<img
											src="<c:out value="${item.objectPath}${item.description.fullImage}" />"
											alt="<c:out value="${item.description.shortDescription}" />"
											border="0" width="${imgWidth}" height="${imgHeight}" /><br/>
									</c:if> 
									-->
									<c:choose>
										<c:when test="${!empty item.description.fullImage}">
											<img
												src="<c:out value="${item.objectPath}${item.description.fullImage}" />"
												alt="<c:out value="${item.description.shortDescription}" />"
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
									<td valign="top">			
										<span class="productName"><c:out value="${item.description.shortDescription}" escapeXml="false"/></span>
										<br/><br/>
										<span class="text"><fmt:message key="SKU" bundle="${storeText}" />:</span> <span class="text"><c:out value="${item.partNumber}" /></span>
										<br/><br/>

										<span class="text"><c:out value="${item.description.longDescription}" escapeXml="false" /></span><br/><br/>
										
										<%-- 
										  ***
										  *	Start: Show Catalog Attachments
										  * The attachments for each usage will be displayed
										  ***
										--%>
										<c:forEach var="attachUsage" items="${item.attachmentUsages}" >	
											<c:set property="attachmentUsage" value="${attachUsage.identifier}" target="${item}" />
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
														<c:set var="AttachmentDataBeans" value="${item.attachmentsByUsage}" />
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
										<!-- Removed this part of code to fix defect 166371 -->
										<c:forEach var="descriptiveAttribute" items="${item.descriptiveAttributeDataBeans}" >
											<span class="strongtext" title="<c:out value="${descriptiveAttribute.description}" escapeXml="false" />"><c:out value="${descriptiveAttribute.name}" escapeXml="false" />:</span>
											<c:forEach var="descAttrValue" items="${descriptiveAttribute.attributeValueDataBeans}">
												<c:choose>
													<c:when test="${ !empty descAttrValue.image1  }" >
														<c:out value="${descAttrValue.value}" escapeXml="false" />&nbsp;<img src="<c:out value="${item.objectPath}${descAttrValue.image1}" />" alt="<c:out value="${descAttrValue.value}" />" border="0"/><br/>
													</c:when>
													<c:otherwise >
														<c:out value="${descAttrValue.value}" escapeXml="false" /><br/>
													</c:otherwise>
												</c:choose>
											</c:forEach>
										</c:forEach>
										<c:if test="${ !empty item.descriptiveAttributeDataBeans}" >
														<br/>
										</c:if>
										--%>
										<%-- 
										  ***
										  *	End: Descriptive Attributes
										  ***
										--%>		
																		
										<%-- 
										  ***
										  *	Start: Item Price
										  *     Show the list price only if it is larger than the contract price
										  ***
										--%>
										<c:if test="${empty param.displayContractPrices}" >	
										<table valign="top" cellpadding="0" cellspacing="0" border="0" class="t_table">
											<tr>
												<td valign="top"><span class="productName"><fmt:message key="PRICE" bundle="${storeText}" /></span>
													<c:set var="type" value="item"/>
													<c:set var="catalogEntry" value="${item}"/>
													<c:set var="displayPriceRange" value="true"/>
													<%@ include file="../../../Snippets/ReusableObjects/CatalogEntryPriceDisplay.jspf"%>	
												</td>
											</tr>
										</table>
										</c:if>
										<%--
											***
											* End: Item Price
											***
										--%>

										<form name="OrderItemAddForm" action="" method="post" id="OrderItemAddForm">
										<input type="hidden" name="storeId" value="<c:out value="${WCParam.storeId}" />" id="WC_CachedItemDisplay_FormInput_storeId_In_OrderItemAddForm_1"/>
										<input type="hidden" name="orderId" value="." id="WC_CachedItemDisplay_FormInput_orderId_In_OrderItemAddForm_1"/>
										<input type="hidden" name="catalogId" value="<c:out value="${WCParam.catalogId}" />" id="WC_CachedItemDisplay_FormInput_catalogId_In_OrderItemAddForm_1"/>
										<input type="hidden" name="URL" value="" id="WC_CachedItemDisplay_FormInput_URL_In_OrderItemAddForm_1"/>
										<input type="hidden" name="errorViewName" value="ProductDisplayErrorView" id="WC_CachedItemDisplay_FormInput_errorViewName_In_OrderItemAddForm_1"/>
										<input type="hidden" name="catEntryId" value="<c:out value="${productId}" />" id="WC_CachedItemDisplay_FormInput_catEntryId_In_OrderItemAddForm_1"/>
										<input type="hidden" name="productId" value="<c:out value="${productId}" />" id="WC_CachedItemDisplay_FormInput_productId_In_OrderItemAddForm_1"/>
										<input type="hidden" name="calculationUsageId" value="-1" id="WC_CachedItemDisplay_FormInput_calculationUsageId_In_OrderItemAddForm_1"/>
										<%-- shouldCachePage is used to tell the server not to cache this page.  So if an error happens, this page is redrawn with an error message --%>
										<input type="hidden" name="shouldCachePage" value="false" id="WC_CachedItemDisplay_FormInput_shouldCachePage_In_OrderItemAddForm_1"/>
										<%-- DO NOT REMOVE: requisitionListId is used in B2BDirect store --%>
										<input type="hidden" name="requisitionListId" value="false" id="WC_CachedItemDisplay_FormInput_requisitionListId_In_OrderItemAddForm_1"/>

										<c:if test="${!empty param.displayContractPrices }" >
											<input type="hidden" name="contractId" value="" id="WC_CachedItemDisplay_FormInput_contractId_In_OrderItemAddForm_1"/>
										</c:if>
										
										<%-- 
											***
											*	Start: Quantity display 
											***
										--%>
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
										<br/>								
										<%--
											***
											* 	End:Quantity display
											***
										--%>

			<c:if test="${!empty param.displayContractPrices }" >									
                      <table width="100%" border="0" cellpadding="2" cellspacing="1" class="bgColor" id="WC_CachedItemDisplay_Table_4">
                              <tr>
                                <th class="colHeader" id="WC_CachedItemDisplay_TableCell_5"></th>
                                <th class="colHeader" id="WC_CachedItemDisplay_TableCell_7"><fmt:message key="ItemDisp_Contract" bundle="${storeText}"/></th>
                                <th class="colHeader_price" id="WC_CachedItemDisplay_TableCell_9" style="border-right:solid 1px #929499;"><fmt:message key="ItemDisp_Price" bundle="${storeText}"/></th>
                              </tr>
                              <c:set var="actualCount" value="0"/>
                              <%--check if numberOfApplicableContractIds is available first before accessing it--%>
                              <c:choose>
                                     <c:when test="${item.checkNumberOfApplicableContractIds}">
                                     <c:forEach var="i" begin="0" end="${item.numberOfApplicableContractIds}" varStatus="appContractIdCounter">
                                                                      <c:set var="rowColor" value="cellBG_${actualCount%2 + 1}"/>
                                                 <c:if test="${!empty item.applicableContractPrices[i]}">
                                                          <tr>
                                                            <td headers="WC_CachedItemDisplay_TableCell_5" class="<c:out value="${rowColor}"/> t_td" id="WC_CachedItemDisplay_TableCell_10_<c:out value="${i}"/>"><input id="WC_CachedItemDisplay_FormInput_contractId_In_OrderItemAddForm_1_<c:out value="${i}"/>" class="radio" type="radio" name="copyof_contractId" value="<c:out value="${item.applicableContractIds[i]}"/>"<c:if test="${actualCount == 0}"> checked="checked"</c:if> ></td>
                                                            <td headers="WC_CachedItemDisplay_TableCell_7" class="<c:out value="${rowColor}"/> t_td" id="WC_CachedItemDisplay_TableCell_11_<c:out value="${i}"/>"><label for="WC_CachedItemDisplay_FormInput_contractId_In_OrderItemAddForm_1_<c:out value="${i}"/>"><c:out value="${item.applicableContracts[i].name}"/></label>&nbsp;[<c:out value="${item.applicableContractIds[i]}"/>]</td>
                                                            <td headers="WC_CachedItemDisplay_TableCell_9" class="<c:out value="${rowColor}"/> price t_td" id="WC_CachedItemDisplay_TableCell_12_<c:out value="${i}"/>">
                                        <c:forEach var="contractPriceRange" items="${item.applicableContractPriceRanges}" varStatus="priceRangeContractCounter">
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
                                                          <c:set var="actualCount" value="${actualCount + 1}"/>
                                                 </c:if>
                                     </c:forEach>
                                  </c:when>
                                  <c:otherwise>
                                <p/><fmt:message key="ItemDisp_ContractPriceNotAvailable" bundle="${storeText}"/>
                                   </c:otherwise>
                           </c:choose>
                            </td>
                        </tr>
                      </table>
			</c:if>



										<%--
										  ***
										  * Start: Display Defining and Descriptive attributes
										  * First, loop through the attribute values and display the defining attributes
										  * Then, display the item descriptive attributes and show the corresponding images if available
										  * If the item does not have descriptive attributes, get the attributes from the parent item.
										  ***
										--%>
										<wcf:getData type="com.ibm.commerce.catalog.facade.datatypes.CatalogEntryType[]" var="catalogEntryAttributes" expressionBuilder="getStoreCatalogEntryAttributesParentByID">
											<wcf:contextData name="storeId" data="${param.storeId}"/>
											<wcf:param name="catEntryId" value="${item.itemID}"/>
											<wcf:param name="dataLanguageIds" value="${WCParam.langId}"/>
										</wcf:getData>
										
										<c:forEach var='catalogEntryWithAtt' items='${catalogEntryAttributes}'>
											<c:choose>
												<c:when test="${ catalogEntryWithAtt.catalogEntryIdentifier.uniqueID == productId }">
													<c:set var="itemWithAttr" value="${catalogEntryWithAtt}"/>												
												</c:when>
												<c:otherwise>
													<c:set var="parentWithAttr" value="${catalogEntryWithAtt}"/>
												</c:otherwise>
											</c:choose>
										</c:forEach>
										<br/>
										<c:forEach var="attribute" items="${itemWithAttr.catalogEntryAttributes.attributes}">
											<c:if test="${ attribute.usage=='Defining' }" >	
												<span class="strongtext"><c:out value="${attribute.name}"  escapeXml="false" /> : </span><c:out value="${attribute.value.value}"  escapeXml="false" />																				
												<br/>
											</c:if>
										</c:forEach>
											
										<c:set var="descAttrCount" value="0"/>
										<c:forEach var="attribute" items="${itemWithAttr.catalogEntryAttributes.attributes}">
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
												<c:set var="descAttrCount" value="${descAttrCount + 1}"/>												
											</c:if>
										</c:forEach>
										
										<c:if test="${descAttrCount == 0}">
											<c:forEach var="attribute" items="${parentWithAttr.catalogEntryAttributes.attributes}">
												<c:if test="${ attribute.usage=='Descriptive' }" >	
													<span class="strongtext" title="<c:out value="${attribute.description}"  escapeXml="false" />" ><c:out value="${attribute.name}"  escapeXml="false" />:</span>
													<c:choose>
														<c:when test="${ !empty attribute.extendedValue['Image1']  }" >
															<c:out value="${attribute.value.value}" escapeXml="false" />&nbsp;<img src="<c:out value="${item.parentProductDataBean.objectPath}${attribute.extendedValue['Image1']}" />" alt="<c:out value="${attribute.value.value}" />" border="0"/><br/>												
														</c:when>
														<c:otherwise >
															<c:out value="${attribute.value.value}"  escapeXml="false"  />
														</c:otherwise>
													</c:choose>
													<br/>
												</c:if>
											</c:forEach>
										</c:if>
								
										<%--
										  ***
										  * End: Display Defining and Descriptive attributes
										  ***
										--%>
										<c:if test="${!empty errorMessage}">
											<br/>
											<%-- 
											  ***
											  *	Start: Error handling
											  * An error occurs if a customer enters an invalid quantity, or if the products the customer wish to purchase are not available.
											  ***
											--%>
											<tr>
												<td id="WC_CachedItemDisplay_TableCell_7"></td>
												<td valign="top" class="errortxt" id="WC_CachedItemDisplay_TableCell_8"><br/><c:out value="${errorMessage}"  escapeXml="false" /></td>
											</tr>
											<%-- 
											  ***
											  *	End: Error handling
											  ***
											--%>
											<br/>
											<br/>
										</c:if>
										<br/>				
										
										<%-- We output the discounts using simple JavaScript to support older browsers such as Netscape 4  --%>
										<script type="text/javascript">
											document.write(Discount.getItemDiscountText(<c:out value="${productId}"/>));
										</script>														

										<%-- 
										  ***
										  * If the page has been called with the summaryOnly parameter (from the Order Summary page) then do not show add to cart, wishlist buttons,
										  * or merchandising associations.  Instead show a button that will return the user to the order summary page.
										  ***
										--%>
										<br/><br/>
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
														<c:when test="${item.calculatedContractPriced && item.buyable ne '0'}" >				
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
															<a href="#" onclick="Add2ShopCart(document.OrderItemAddForm); return false;" id="WC_CachedItemDisplay_Link_5" class="button"><fmt:message key="ADD_SHOPPING_CART" bundle="${storeText}" /></a>
															&nbsp;

														<%-- 
														  ***
														  *	Start: GiftRegistryCode
														  *
														  ***
														--%>
														<!--
														<flow:ifEnabled  feature="wishList">
															<a href="#" onclick="Add2WishList(document.OrderItemAddForm); return false;" class="button" id="WC_CachedItemDisplay_Link_6"><fmt:message key="WISHLIST" bundle="${storeText}" /></a>
														</flow:ifEnabled>
														-->
														<%@ include file="AddToGiftRegistryDisplay.jspf" %>
														</c:otherwise>
														</c:choose>
														
														<%-- 
														  ***
														  *	End: GiftRegistryCode
														  ***
														--%>	
														</flow:ifEnabled>
														<flow:ifDisabled feature="GiftRegistry">
														<a href="#" onclick="Add2ShopCart(document.OrderItemAddForm); return false;" id="WC_CachedItemDisplay_Link_5" class="button"><fmt:message key="ADD_SHOPPING_CART" bundle="${storeText}" /></a>
															&nbsp;
														<flow:ifEnabled  feature="wishList">
															<a href="#" onclick="Add2WishList(document.OrderItemAddForm); return false;" class="button" id="WC_CachedItemDisplay_Link_6"><fmt:message key="WISHLIST" bundle="${storeText}" /></a>
														</flow:ifEnabled>														
														</flow:ifDisabled>
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
															<a href="<c:out value="${TopCategoriesDisplayURL}" />" id="WC_CachedItemDisplay_Link_5" class="button"><c:out value="${returnShoppingMessage}" /></a>&nbsp;
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

<!-- End - JSP File Name: CachedItemDisplay.jsp -->
