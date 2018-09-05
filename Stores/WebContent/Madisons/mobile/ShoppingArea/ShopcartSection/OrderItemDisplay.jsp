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
  * This JSP displays the users Shopcart. 
  *****
--%>

<!-- BEGIN OrderItemDisplay.jsp -->

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>

<%@ include file="../../../include/parameters.jspf" %>
<%@ include file="../../include/JSTLEnvironmentSetup.jspf" %>
<%@ include file="../../include/ErrorMessageSetup.jspf" %>

<%-- Required variables for breadcrumb support --%>
<c:choose>
	<c:when test="${!empty WCParam.pgGrp and WCParam.pgGrp == 'catNav'}">
		<c:set var="categoryNavPageGroup" value="true" scope="request"/>
	</c:when>
	<c:when test="${!empty WCParam.pgGrp and WCParam.pgGrp == 'search'}">
		<c:set var="searchPageGroup" value="true" scope="request"/>
	</c:when>	
	<c:otherwise>
		<c:set var="shoppingcartPageGroup" value="true" scope="request"/>
	</c:otherwise>
</c:choose>
<c:set var="pgGrp" value="shoppingcart" />
<c:set var="shoppingcartDisplayPage" value="true" scope="request"/>
	

<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.2//EN" "http://www.openmobilealliance.org/tech/DTD/xhtml-mobile12.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
	<head>

		<title>
			<fmt:message key="SHOPPING_CART_TITLE" bundle="${storeText}" /> - <c:out value="${storeName}"/>
		</title>
		<meta http-equiv="content-type" content="application/xhtml+xml" />
		<meta http-equiv="cache-control" content="max-age=300" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no" />		
		<link rel="stylesheet" href="${cssPath}" type="text/css"/>
	</head>	
	
	<body>
		<div id="wrapper">	

			<%@ include file="../../include/HeaderDisplay.jspf" %>
			<%@ include file="../../include/BreadCrumbTrailDisplay.jspf" %>

			<div id="shopping_cart" class="content_box">

				<div class="heading_container">
					<h2><fmt:message key="SHOPPING_CART_TITLE" bundle="${storeText}" /></h2>
					<div class="clear_float"></div>
				</div>

				<c:choose>
					<c:when test="${!empty WCParam.quantityError && WCParam.quantityError}">
						<p class="error"><fmt:message key="QUANTITY_INPUT_ERROR" bundle="${storeText}" /></p>
					</c:when>		
					<c:when test="${!empty errorMessage && WCParam.errorView}">
						<p class="error"><c:out value="${errorMessage}"/></p>
					</c:when>
				</c:choose>

				<c:if test="${WCParam.merged}">
					<p class="error"><fmt:message key="MERGED_SHOPPING_CART" bundle="${storeText}" /></p>
				</c:if>

				<!-- Get order Details using the ORDER SOI -->
				<c:set var="pageSize" value="${maxOrderItemsPerPage}"/>	

				<c:set var="beginIndex" value="${WCParam.beginIndex}" />
				<c:if test="${empty beginIndex}">
					<c:set var="beginIndex" value="0" />
				</c:if>
				<wcf:getData type="com.ibm.commerce.order.facade.datatypes.OrderType" scope="request" var="order" expressionBuilder="findCurrentShoppingCartWithPagingOnItem" varShowVerb="ShowVerbCart" maxItems="${pageSize}" recordSetStartNumber="${beginIndex}" recordSetReferenceId="ostatus">
					<wcf:param name="accessProfile" value="IBM_Details" />	 
					<wcf:param name="sortOrderItemBy" value="orderItemID" />
					<wcf:param name="isSummary" value="false" />
				</wcf:getData>

				<c:set var="bHasShopCart" value="false" />

				<%-- 
					***
					* Check to see if shopcart is empty.  If empty, display shopcart is empty error message. If order items exist, display shopcart contents.
					***
				--%>

				<c:choose>
					<%-- Check to see if there is an order id, if no, then shopping cart is empty--%>

					<c:when test="${ empty order.orderItem }" >
						<c:set var="bHasShopCart" value="false"/>
					</c:when>
					<c:otherwise>
						<c:set var="pageSize" value="${maxOrderItemsPerPage}"/>
						<c:if test="${empty pageSize}">
							<c:set var="pageSize" value="20"/>
						</c:if>
						<c:set var="currentPage" value="${WCParam.currentPage}"/>
						<c:if test="${empty currentPage}">
							<c:set var="currentPage" value="1"/>
						</c:if>

						<%-- If there is an order id, then check to see if there are items associated with the order id obtained from the command--%>
						<c:set var="orderItems" value="${order.orderItem}" />

						<c:choose>
							<%-- if there are items, then there are items in the shopping cart --%>
							<c:when test="${ !empty orderItems }" >
								<c:set var="bHasShopCart" value="true"/>
							</c:when>
							<%--if there are no items,then the shopping cart is empty --%>
							<c:otherwise>
								<c:set var="bHasShopCart" value="false"/>
							</c:otherwise>
						</c:choose>
					</c:otherwise>
				</c:choose>

				<%-- 
					***
					* End of check to see if shopcart is empty.  
					***
				--%>

				<c:choose> 
					<c:when test="${ !bHasShopCart }">
						<p class="paragraph_blurb"><fmt:message key="EMPTY_SHOPPING_CART" bundle="${storeText}" /></p>
					</c:when>
					<%-- 
						*** 
						* Shopcart is not empty.  display shopcart conents
						***
					--%>
					<c:otherwise>
					
						<%-- Setup the Quick Navigation list of items in the shopping cart --%>
						<c:set var="shoppingcartProductIds" value="" />
						<c:forEach var="orderItem" items="${orderItems}" varStatus="status">
							<c:set var="shoppingcartProductIds" value="${shoppingcartProductIds},${orderItem.catalogEntryIdentifier.uniqueID}"/>
						</c:forEach>
						
						<%
						String shoppingcartProdIds = (String) pageContext.getAttribute("shoppingcartProductIds");
						shoppingcartProdIds = shoppingcartProdIds.replaceFirst(",","");
						session.setAttribute(SHOPPINGCART_PRODUCTID_KEY, shoppingcartProdIds);
						%>
								
						<%-- Pagination Logic --%>
						<c:set var="numEntries" value="${fn:length(orderItems)}"/>						
						<c:set var="pageSize" value="${WCParam.pageSize}"/>
						<c:if test="${empty pageSize}">
							<c:set var="pageSize" value="${shopcartMaxPageSize}" />
						</c:if>

						<%-- Counts the page number we are drawing in.  --%>
						<c:set var="currentPage" value="1" />
						<c:if test="${!empty WCParam.currentPage}">
							<c:set var="currentPage" value="${WCParam.currentPage}" />
						</c:if>

						<fmt:formatNumber var="totalPages" value="${(numEntries/pageSize)+1}"/>
						<c:if test="${numEntries%pageSize == 0}">
							<fmt:parseNumber var="totalPages" value="${numEntries/pageSize}"/>
						</c:if>
						<fmt:parseNumber var="totalPages" value="${totalPages}" integerOnly="true" />

						<fmt:formatNumber var="beginIndex" value="${(currentPage-1) * pageSize}"/>
						<fmt:formatNumber var="endIndex" value="${beginIndex + pageSize}"/>
						<c:if test="${endIndex > numEntries}">
							<fmt:parseNumber var="endIndex" value="${numEntries}"/>
						</c:if>
						<fmt:parseNumber var="beginIndex" value="${beginIndex}" integerOnly="true" />
						<fmt:parseNumber var="endIndex" value="${endIndex}" integerOnly="true" />	
						<fmt:parseNumber var="numRecordsToShow" value="${endIndex-beginIndex}" integerOnly="true" />

						<form name="ShopCartForm" method="post" action="OrderChangeServiceItemUpdate" id="ShopCartForm">

							<ol id="shopping_cart_items">
								<c:forEach var="orderItem" items="${orderItems}" begin="${beginIndex}" end="${endIndex}" varStatus="status">
									<c:if test="${status.count <= numRecordsToShow}">									
										<wcbase:useBean id="catalogEntry" classname="com.ibm.commerce.catalog.beans.CatalogEntryDataBean" scope="request">
											<c:set property="catalogEntryID" value="${orderItem.catalogEntryIdentifier.uniqueID}" target="${catalogEntry}" />
										</wcbase:useBean>

										<wcf:url var="ProductDisplayURL" value="mProduct4">
											<wcf:param name="productId" value="${orderItem.catalogEntryIdentifier.uniqueID}" />
											<wcf:param name="langId" value="${langId}" />
											<wcf:param name="storeId" value="${WCParam.storeId}" />
											<wcf:param name="catalogId" value="${WCParam.catalogId}" />
											<wcf:param name="pgGrp" value="${pgGrp}" />
										</wcf:url>

										<li class="item_container">

											<h4><a href="${ProductDisplayURL}"><c:out value="${catalogEntry.description.name}"/></a></h4>

											<ul>										
												<li>
													<c:out value="SKU: ${catalogEntry.partNumber}"/>
												</li>

												<c:set var="totalNumberOfItems" value="${status.count}"/>
												<fmt:formatNumber var="quickCartOrderItemQuantity" value="${orderItem.quantity.value}" type="number" maxFractionDigits="0"/>

												<%-- 
													*** 
													* Check to see if the item is a free gift
													***
												--%>

												<c:choose>
													<c:when test="${orderItem.orderItemAmount.freeGift}">
														<%-- Free gift --%>
														<li>
															<span>
																<fmt:message key="PRICE" bundle="${storeText}" /> <fmt:message key="SHOPCART_FREE" bundle="${storeText}" />
															</span>
														</li>
														<li>
															<span>
																<fmt:message key="ITEM_QTY" bundle="${storeText}" /> <c:out value="${quickCartOrderItemQuantity}"/>
															</span>
														</li>
													</c:when>													
													<c:otherwise>
														<%-- Not a free gift --%>
														<li>
															<span>
																<fmt:message key="PRICE" bundle="${storeText}" />
																<fmt:formatNumber type="currency" maxFractionDigits="${currencyDecimal}" currencySymbol="${currencyFormatterDB.currencySymbol}" value="${orderItem.orderItemAmount.unitPrice.price.value}" />
															</span>
														</li>
														<li>
															<span>
																<label for='quantity_<c:out value="${status.count}"/>'><fmt:message key="ITEM_QTY" bundle="${storeText}" /></label>
																<input type="hidden" value='<c:out value="${orderItem.orderItemIdentifier.uniqueID}"/>' name='orderItemId_<c:out value="${status.count}"/>' id='orderItemId_<c:out value="${status.count}"/>'/>
																<input type="text" class="coloured_input" size="4" value='<c:out value="${quickCartOrderItemQuantity}"/>' id='quantity_<c:out value="${status.count}"/>' name='quantity_<c:out value="${status.count}"/>'/>
															</span>
														</li>

														<wcf:url var="refURL" value="mOrderItemDisplay">
															<wcf:param name="langId" value="${WCParam.langId}" />
															<wcf:param name="storeId" value="${WCParam.storeId}" />
															<wcf:param name="catalogId" value="${WCParam.catalogId}" />
														</wcf:url>

														<wcf:url var="OrderItemDelete" value="OrderChangeServiceItemDelete">
															<wcf:param name="orderItemId" value="${orderItem.orderItemIdentifier.uniqueID}"/>
															<wcf:param name="orderId" value="${order.orderIdentifier.uniqueID}"/>
															<wcf:param name="langId" value="${WCParam.langId}" />
															<wcf:param name="storeId" value="${WCParam.storeId}" />
															<wcf:param name="catalogId" value="${WCParam.catalogId}" />
															<wcf:param name="URL" value="${refURL}" />
														</wcf:url>
														
														<wcf:url var="OrderItemDeleteToWishlist" value="OrderChangeServiceItemDelete">
															<wcf:param name="orderItemId" value="${orderItem.orderItemIdentifier.uniqueID}"/>
															<wcf:param name="orderId" value="${order.orderIdentifier.uniqueID}"/>
															<wcf:param name="langId" value="${WCParam.langId}" />
															<wcf:param name="storeId" value="${WCParam.storeId}" />
															<wcf:param name="catalogId" value="${WCParam.catalogId}" />
															<wcf:param name="URL" value="InterestItemDisplay?URL=mInterestListDisplay&listId=." />
														</wcf:url>
														
														<wcf:url var="WishlistAdd" value="InterestItemAdd">
															<wcf:param name="catEntryId" value="${orderItem.catalogEntryIdentifier.uniqueID}"/>
															<wcf:param name="langId" value="${WCParam.langId}" />
															<wcf:param name="storeId" value="${WCParam.storeId}" />
															<wcf:param name="catalogId" value="${WCParam.catalogId}" />
															<wcf:param name="URL" value="${OrderItemDeleteToWishlist}" />
														</wcf:url>														

														<li>
															<span class="bullet">&#187; </span><a href="${fn:escapeXml(OrderItemDelete)}" title="<fmt:message key="WISHLIST_REMOVE" bundle="${storeText}" />">
															<fmt:message key="WISHLIST_REMOVE" bundle="${storeText}" /></a>
														</li>

														<li>
															<span class="bullet">&#187; </span><a href="${fn:escapeXml(WishlistAdd)}" title="<fmt:message key="MOVE_TO_WISHLIST" bundle="${storeText}" />">
															<fmt:message key="MOVE_TO_WISHLIST" bundle="${storeText}" /></a>
														</li>													
													</c:otherwise>
												</c:choose>
											</ul>
											<div class="clear_float"></div>
										</li>

										<c:remove var="catalogEntry"/>
									</c:if>
								</c:forEach>
							</ol>


							<input type="hidden" id="totalNumberOfItems" name="totalNumberOfItems" value="<c:out value="${totalNumberOfItems}"/>"/>
							<input type="hidden" name="URL" value="mOrderItemDisplay" id="URL"/>
							<input type="hidden" name="errorViewName" value="mOrderItemDisplay" />
						</form>


						<%-- TODO: Implement the paging functionality --%>	
						<%-- 
						<div class="paging_control_with_underline">
							<div class="page_number">Page 1/20</div> <span class="bullet">&#171; </span><a href="#" title="Previous Page">Prev</a>&#160;&#160;<a href="#" title="Next Page">Next</a><span class="bullet"> &#187;</span>
						</div>
						--%>

						<c:if test="${totalPages > 1}">
							<div class="paging_control">
								<div class="page_number">
									<fmt:message key="PAGING" bundle="${storeText}">
										<fmt:param value="${currentPage}"/>
										<fmt:param value="${totalPages}"/>				
									</fmt:message>		
								</div>

								<c:if test="${currentPage > 1}">
									<span class="bullet">&#171;</span>
									<wcf:url var="CartDisplayURL" value="mOrderItemDisplay">
										<wcf:param name="langId" value="${langId}" />
										<wcf:param name="storeId" value="${WCParam.storeId}" />
										<wcf:param name="catalogId" value="${WCParam.catalogId}" />
										<wcf:param name="currentPage" value="${currentPage-1}" />						
									</wcf:url>
									<a href="${fn:escapeXml(CartDisplayURL)}" title="<fmt:message key="PAGING_PREV_PAGE_TITLE" 
										bundle="${storeText}"/>"><fmt:message key="PAGING_PREV_PAGE" bundle="${storeText}"/></a>
								</c:if>
								&#160;&#160;
								<c:if test="${currentPage < totalPages}">
									<wcf:url var="CartDisplayURL" value="mOrderItemDisplay">
										<wcf:param name="langId" value="${langId}" />
										<wcf:param name="storeId" value="${WCParam.storeId}" />
										<wcf:param name="catalogId" value="${WCParam.catalogId}" />
										<wcf:param name="currentPage" value="${currentPage+1}" />						
									</wcf:url>			
									<a href="${fn:escapeXml(CartDisplayURL)}" title="<fmt:message key="PAGING_NEXT_PAGE_TITLE" 
										bundle="${storeText}"/>"><fmt:message key="PAGING_NEXT_PAGE" bundle="${storeText}"/></a>
									<span class="bullet"> &#187;</span>
								</c:if>
							</div>
						</c:if>

						<wcf:url var="PromotionCodeManageURL" value="PromotionCodeManage">
							<wcf:param name="orderId" value="${order.orderIdentifier.uniqueID}" />
							<wcf:param name="taskType" value="A" />
							<wcf:param name="URL" value="OrderCalculate?calculationUsageId=-1&URL=mOrderItemDisplay" />
							<wcf:param name="errorView" value="true" />
						</wcf:url>

						<div id="promotion_codes"> 
							<label for="promotion_code"><fmt:message key="PROMOTION_CODE" bundle="${storeText}" /></label>
							<input type="text" name="promotion_code" id="promotion_code" size="8" class="coloured_input" />

							<wcbase:useBean id="promoCodeListBean" classname="com.ibm.commerce.marketing.databeans.PromoCodeListDataBean" scope="page">
								<c:set property="orderId" value="${order.orderIdentifier.uniqueID}" target="${promoCodeListBean}" />
							</wcbase:useBean>

							<ul>							
								<c:forEach var="promotionCode" items="${promoCodeListBean.codes}" varStatus="status">
									<wcf:url var="RemovePromotionCode" value="PromotionCodeManage">
										<wcf:param name="orderId" value="${order.orderIdentifier.uniqueID}" />
										<wcf:param name="taskType" value="R" />
										<wcf:param name="URL" value="OrderCalculate?calculationUsageId=-1&URL=mOrderItemDisplay" />
										<wcf:param name="promoCode" value="${promotionCode.code}" />
										<wcf:param name="errorViewName" value="mOrderItemDisplay" />
										<wcf:param name="errorView" value="true" />
									</wcf:url>
									<li>
										<span class="bullet">&#187; </span><a href="${fn:escapeXml(RemovePromotionCode)}" title="<fmt:message key="WISHLIST_REMOVE" bundle="${storeText}" />">
										<fmt:message key="WISHLIST_REMOVE" bundle="${storeText}" />&nbsp;<c:out value="${promotionCode.code}" /></a>
									</li>
								</c:forEach>
							</ul>
						</div>

						<div id="shopping_cart_costs">
							<dl>							
								<dt><fmt:message key="ORDER_SUBTOTAL" bundle="${storeText}" /></dt>
								<dd><fmt:formatNumber type="currency" maxFractionDigits="${currencyDecimal}" currencySymbol="${currencyFormatterDB.currencySymbol}" value="${order.orderAmount.totalProductPrice.value}" /></dd>
								
								<dt><fmt:message key="DISCOUNT" bundle="${storeText}" /></dt>
								<dd><fmt:formatNumber type="currency" maxFractionDigits="${currencyDecimal}" currencySymbol="${currencyFormatterDB.currencySymbol}" value="${order.orderAmount.totalAdjustment.value}" /></dd>
								
								<dt class="bold"><fmt:message key="ORDER_TOTAL" bundle="${storeText}" /></dt>
								<dd class="bold"><fmt:formatNumber type="currency" maxFractionDigits="${currencyDecimal}" currencySymbol="${currencyFormatterDB.currencySymbol}" value="${order.orderAmount.grandTotal.value}" /></dd>
							</dl>							

							<a href="#" onclick="javascript:updateShoppingCart(document.ShopCartForm); return false;" title="<fmt:message 	key="UPDATE_ORDER_TOTAL" bundle="${storeText}" />"><button type="button"><fmt:message key="UPDATE_ORDER_TOTAL" bundle="${storeText}" /></button></a>
						</div>
												
						<%-- Bypass checkout logon when already signed in --%>
						<c:choose>
							<c:when test="${userType == 'G'}">
								<wcf:url var="CheckoutLogon" value="mCheckoutLogon">
									<wcf:param name="langId" value="${langId}" />
									<wcf:param name="storeId" value="${WCParam.storeId}" />
									<wcf:param name="catalogId" value="${WCParam.catalogId}" />
								</wcf:url>								
							</c:when>
							<c:otherwise>
								<wcf:url var="CheckoutLogon" value="mSelectedStoreListView">
									<wcf:param name="langId" value="${langId}" />
									<wcf:param name="storeId" value="${WCParam.storeId}" />
									<wcf:param name="catalogId" value="${WCParam.catalogId}" />
									<wcf:param name="fromPage" value="ShoppingCart" />
								</wcf:url>
							</c:otherwise>
						</c:choose>

						<div id="shipping_options">
							<div class="radio_container"><input type="radio" name="shipping_option" id="pick_up_at_store" checked /> <label for="pick_up_at_store"><fmt:message key="PICK_UP_AT_STORE" bundle="${storeText}" /></label></div>
							<button type="button" onclick="window.location.href='${CheckoutLogon}'"><fmt:message key="PROCEED_TO_CHECKOUT" bundle="${storeText}" /></button>
						</div>

					</c:otherwise>
				</c:choose>
			</div>									

			<%@ include file="../../include/FooterDisplay.jspf" %>						
		</div>

		<script type="text/javascript">
			//<![CDATA[
			/**
			 * Validates the quantity of all items on the 'Shopping Cart' page.
			 * This function is used when the 'AjaxCheckout' feature is disabled.
			 *
			 * @param {DOM Element} form The form object that contains the table of order items.
			 */
			function updateShoppingCart(form) {
				var promotionCode = document.getElementById("promotion_code").value;
				if(!(promotionCode == null || promotionCode == "")) {
					document.getElementById("URL").value = '<c:out value="${PromotionCodeManageURL}" escapeXml="false" />' + '&promoCode=' + promotionCode;
				}
				var totalItems = document.getElementById("totalNumberOfItems").value;
				if(totalItems != null){
					for(var i = 0; i < totalItems; i++){
						//Update qty for all items
						if (form["quantity_"+(i+1)]) {
							var v = form["quantity_"+(i+1)].value;                            
							
							if(v=="" || isNaN(v) || v < 0) {
								<wcf:url var="QuantityErrorURL" value="mOrderItemDisplay">
									<wcf:param name="langId" value="${WCParam.langId}" />
									<wcf:param name="storeId" value="${WCParam.storeId}" />
									<wcf:param name="catalogId" value="${WCParam.catalogId}" />
									<wcf:param name="quantityError" value="true" />							
								</wcf:url>
								
								window.location.href="${QuantityErrorURL}";
								return;
							}
						}
					}
					form.submit();
				}
			}
			//]]> 
		</script>
	</body>
</html>

<!-- END OrderItemDisplay.jsp -->
