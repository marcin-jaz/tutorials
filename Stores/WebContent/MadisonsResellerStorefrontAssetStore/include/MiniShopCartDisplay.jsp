<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2007, 2009 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>

<%-- 
  *****
  * This file is used to display the Mini shopping cart in the header of each page. 
  * The Mini shopping cart will display  
  *	- current number of items that are currently in the shopping cart 
  * - current subtotal of the items in the shopping cart
  *****
--%>

<!-- Start - JSP File Name: MiniShopCartDisplay.jsp -->

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="JSTLEnvironmentSetup.jspf" %>

<!-- If we get here from a generic error this service will fail so we need to catch the exception -->
<c:catch >
<wcf:getData type="com.ibm.commerce.order.facade.datatypes.OrderType"
       var="orderInCart" expressionBuilder="findCurrentShoppingCartWithPagingOnItem" varShowVerb="ShowVerbCart" maxItems="${maxOrderItemsToInspect}" recordSetStartNumber="0" recordSetReferenceId="headerorder" scope="request">
	<wcf:param name="accessProfile" value="IBM_Details" />	 
	<wcf:param name="sortOrderItemBy" value="orderItemID" />
	<wcf:param name="isSummary" value="true" />
</wcf:getData>
</c:catch>
<c:set var="orderQuantity" value="0"/>
<c:set var="tooManyItems" value="false"/>
<c:choose>	
	<c:when test="${ShowVerbCart.recordSetTotal > ShowVerbCart.recordSetCount}">
			<c:set var="orderQuantity" value="${ShowVerbCart.recordSetCount}+"/>
			<c:set var="tooManyItems" value="true"/>
		</c:when>
	<c:otherwise>
		<c:forEach var="orderItem" items="${orderInCart.orderItem}" varStatus="status">
			<c:set var="orderQuantity" value="${orderQuantity + orderItem.quantity.value}"/>
		</c:forEach>
	</c:otherwise>
</c:choose>

<c:set var="orderAmountValue" value="${orderInCart.orderAmount.totalProductPrice.value}" />
<c:if test="${empty orderAmountValue}">
	<c:set var="orderAmountValue" value="0.00" />
</c:if>
<c:set var="orderAmountCurrency" value="${orderInCart.orderAmount.totalProductPrice.currency}" />
<c:if test="${empty orderAmountCurrency}">
	<c:set var="orderAmountCurrency" value="${CommandContext.currency}" />
</c:if>
<c:set var="orderAmountValue" value="${orderInCart.orderAmount.totalProductPrice.value}" />
<c:if test="${empty orderAmountValue}">
	<c:set var="orderAmountValue" value="0.00" />
</c:if>
<c:set var="orderAmountCurrency" value="${orderInCart.orderAmount.totalProductPrice.currency}" />
<c:if test="${empty orderAmountCurrency}">
	<c:set var="orderAmountCurrency" value="${CommandContext.currency}" />
</c:if>

<wcf:url var="ShoppingCartURL" value="OrderCalculate" type="Ajax">
  <wcf:param name="langId" value="${langId}" />
  <wcf:param name="storeId" value="${WCParam.storeId}" />
  <wcf:param name="catalogId" value="${WCParam.catalogId}" />
  <wcf:param name="URL" value="AjaxOrderItemDisplayView" />
  	<wcf:param name="errorViewName" value="AjaxOrderItemDisplayView" />
  <wcf:param name="updatePrices" value="1" />
  <wcf:param name="calculationUsageId" value="-1" />
  <wcf:param name="orderId" value="." />
</wcf:url>

<c:set var="addedOrderItemId" value="${param.addedOrderItemId}" />

<c:set var="showMoreLink" value="false"/>
<c:set var="countMax" value="5"/>

<a href="<c:out value='${ShoppingCartURL}' />" tabindex="0" id="shoppingCartBar" waistate:controls="ShopCartDisplay"   onKeyPress="showMiniShopCartDropDown1(event,'placeHolder','quick_cart_container','orderItemsList');" onclick="showMiniShopCartDropDown1(event,'placeHolder','quick_cart_container','orderItemsList');">
		<span id="miniShopCartLeftCorner" class="left_corner"><img src="${jspStoreImgDir}${vfileColorBIDI}/shopping-cart-icon.gif" width="29" height="25" border="0" alt="<fmt:message key="MINI_CART" bundle="${storeText}"/>"/></span>
		<span id="miniShopCartBody" class="body">
			<span class="text">
				<b>
					 <c:if test="${!tooManyItems}">
							<fmt:formatNumber value="${orderQuantity}" var="orderQuantity"/>
					 </c:if>
					 <fmt:message key="NumItemsInCart" bundle="${storeText}"> 
						<fmt:param><c:out value="${orderQuantity}"/></fmt:param>
						<fmt:param><fmt:formatNumber value="${orderAmountValue}" type="currency" currencySymbol="${currencyFormatterDB.currencySymbol}" maxFractionDigits="${currencyDecimal}"/></fmt:param>
					 </fmt:message>
				</b> 
			</span> 
		</span>
		<span id="miniShopCartRightCorner" class="right_corner"></span>	
</a>

<!-- Mark the position..will show our dialog here -->
<div id="placeHolder"></div>
	
<div id="quick_cart_container">
	<div id="quick_cart">
		<div class="container" id="WC_MiniShopCartDisplay_div_1">
			<!-- Contains 3 div..PlaceHolder div, DropDownContents div and the recently added Product div -->
			<div id ="MiniShopCartProductsList" style="display:none">
				<c:choose>
					<c:when test="${!empty orderInCart.orderItem }" >
						<div class="list" id="MiniCartFocusReceiver1" tabindex="0" onkeydown="javaScript:determineFocus(event);">
							<c:forEach var="orderItem" items="${orderInCart.orderItem}" varStatus="status">
								<c:if test="${!empty addedOrderItemId}">
												<c:set var="addedOrderItemIds" value="${fn:split(addedOrderItemId, ',')}"/>
												<c:forEach var="orderItemId" items="${addedOrderItemIds}">
													<c:if test="${orderItem.orderItemIdentifier.uniqueID == orderItemId}">
														<c:choose>
															<c:when test="${empty addedCatalogEntryIds}">
																<c:set var="addedCatalogEntryIds" value="${orderItem.catalogEntryIdentifier.uniqueID}"/>
															</c:when>
															<c:otherwise>
																<c:set var="addedCatalogEntryIds" value="${addedCatalogEntryIds},${orderItem.catalogEntryIdentifier.uniqueID}"/>
															</c:otherwise>
														</c:choose>
													</c:if>
												</c:forEach>
								</c:if>
								<c:if test="${showMoreLink != 'true'}">
									<c:choose>
										<c:when test="${status.count <= countMax}">
											<wcbase:useBean id="catEntry" classname="com.ibm.commerce.catalog.beans.CatalogEntryDataBean" scope="request">
												<c:set property="catalogEntryID" value="${orderItem.catalogEntryIdentifier.uniqueID}" target="${catEntry}" />
											</wcbase:useBean>
											
											<wcf:url var="catEntryDisplayUrl" value="Product1">
												<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
												<wcf:param name="storeId" value="${WCParam.storeId}"/>
												<wcf:param name="productId" value="${orderItem.catalogEntryIdentifier.uniqueID}"/>
												<wcf:param name="langId" value="${langId}"/>
											</wcf:url>
											
											<div class="product" id="WC_MiniShopCartDisplay_div_2_${status.count}">
											
												<c:choose>
													<c:when test="${catEntry.dynamicKit}">
															<c:out value="${catEntry.description.name}"/>
													</c:when>	
													<c:otherwise>	
														<a href="${catEntryDisplayUrl}" class="order_link" id="WC_MiniShopCartDisplay_link_1_${status.count}">
																<c:out value="${catEntry.description.name}"/>
														</a>
													</c:otherwise>
												</c:choose>
											</div>
											<div class="price" id="WC_MiniShopCartDisplay_div_3_${status.count}">
												<fmt:formatNumber var="totalFormattedProductPrice" value="${orderItem.orderItemAmount.orderItemPrice.value}" type="currency" maxFractionDigits="${currencyDecimal}" currencySymbol="${currencyFormatterDB.currencySymbol}"/>
												<c:out value="${totalFormattedProductPrice}" escapeXml="false" />
											</div>
											<br />
											<br />
											<c:remove var="catEntry"/>
										</c:when>
										<c:otherwise>
											<c:set var="showMoreLink" value="true" />
											<div class="product" id="WC_MiniShopCartDisplay_div_15">
												<a href="<c:out value='${ShoppingCartURL}'/>" class="order_link" id="moreItemsLink"><fmt:message key="More_Items" bundle="${storeText}" /></a>
											</div>
										</c:otherwise>
									</c:choose>
								</c:if>
							</c:forEach>
						</div>
						<div class="footer" id="WC_MiniShopCartDisplay_div_4">
							<span class="primary_button" id="checkoutButton">
								<span class="button_container">
									<span class="button_bg">
										<span class="button_top">
											<span class="button_bottom">   
												<a href="<c:out value='${ShoppingCartURL}'/>" id="WC_MiniShopCartDisplay_link_5">
													<fmt:message key="CHECKOUT" bundle="${storeText}"/>
												</a>
											</span>
										</span>
									</span>
								</span>
							</span>
						</div>
					</c:when>
					<c:otherwise>
						<div class="list" id="MiniCartFocusReceiver2" tabindex="0" onkeydown="javaScript:determineFocus(event);">
							<fmt:message key="CART_EMPTY1" bundle="${storeText}" />
						</div>
						<div class="footer" id="WC_MiniShopCartDisplay_div_7"></div>
					</c:otherwise>
				</c:choose>
				<span tabindex="0" onfocus="javaScript: focusSetter();"></span>
				<span tabindex="0"></span>
				<div class="cart_shadow" id="WC_MiniShopCartDisplay_div_8"></div>
			</div>

			<div id = "MiniShopCartProductAdded" style="display:none">
				<c:if test="${!empty addedCatalogEntryIds}">
					<c:set var="addedCatalogEntryIds1" value="${fn:split(addedCatalogEntryIds, ',')}"/>
					<div class="message" id="WC_MiniShopCartDisplay_div_9"><fmt:message key="Item_Added_Msg" bundle="${storeText}" /></div>
					<div class="list" id="WC_MiniShopCartDisplay_div_10">	
					<table id="WC_MiniShopCartDisplay_table_1">
					<c:forEach var="addedCatalogEntryId" items="${addedCatalogEntryIds1}" varStatus="status2">
						<wcbase:useBean id="catEntry" classname="com.ibm.commerce.catalog.beans.CatalogEntryDataBean" scope="request">
							<c:set property="catalogEntryID" value="${addedCatalogEntryId}" target="${catEntry}" />
						</wcbase:useBean>
						<tr>
							
							<td id="WC_MiniShopCartDisplay_td_1_${status2.count}">
								<c:set var="catEntryIdentifier" value="${catEntry.catalogEntryID}"/>
								<c:set var="pageView" value="imageOnlyDisplay"/>
								<c:set var="showTooltip" value="false"/>
								<%@ include file="../Snippets/ReusableObjects/CatalogEntryDBThumbnailDisplay.jspf" %>   
							</td>
							<td id="WC_MiniShopCartDisplay_td_2_${status2.count}">
								<wcf:url var="catEntryDisplayUrl" value="Product1">
									<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
									<wcf:param name="storeId" value="${WCParam.storeId}"/>
									<wcf:param name="productId" value="${addedCatalogEntryId}"/>
									<wcf:param name="langId" value="${langId}"/>
								</wcf:url>
								<a href="${catEntryDisplayUrl}" class="order_link" id="WC_MiniShopCartDisplay_link_2_${status2.count}"><c:out value="${catEntry.description.name}" escapeXml="false"/></a>
																
								<%-- shows unit price of the orderInCart item --%>
								<c:set var="gotPrice" value="false"/>
								<c:forEach var="orderItem" items="${orderInCart.orderItem}" varStatus="status">
									<%-- there can be multiple orderitem records with the same catentry_id, but unit price should be same for the same catentry --%>
									<%-- as long as we find the unit price once, no need to find it again --%>
									<c:if test="${!gotPrice && (orderItem.catalogEntryIdentifier.uniqueID == addedCatalogEntryId)}">
										<c:set var="gotPrice" value="true"/>
										<a href="#" id="WC_PriceDisplay_Link' />"><img src="<c:out value="${jspStoreImgDir}" />images/empty.gif" alt="<fmt:message key="SalePriceIs" bundle="${storeText}" />" width="0" height="0" border="0" /></a>
										<span class="price">
											<fmt:formatNumber value="${orderItem.orderItemAmount.unitPrice.price.value}" type="currency" maxFractionDigits="${currencyDecimal}" currencySymbol="${currencyFormatterDB.currencySymbol}"/>
										</span>
									</c:if>
								</c:forEach>
																
							</td>
						</tr>
						<c:remove var="catEntry"/>
					</c:forEach>
					</table>
					</div>
					<div class="footer" id="WC_MiniShopCartDisplay_div_11">
						<span class="primary_button" id="WC_MiniShopCartDisplay_div_12">
							<span class="button_container">
								<span class="button_bg">
									<span class="button_top">
										<span class="button_bottom">   
											<a href="<c:out value='${ShoppingCartURL}'/>" class="button_text" id="WC_MiniShopCartDisplay_link_3">
												<fmt:message key="CHECKOUT" bundle="${storeText}"/>
											</a>
										</span>
									</span>
								</span>
							</span>
						</span>
					</div>
					<div class="cart_shadow" id="WC_MiniShopCartDisplay_div_14"></div>
				</c:if>
			</div>
		</div>
	</div>
	<!--[if lte IE 6.5]><iframe id="dropDownIFrame" scrolling="no" frameborder="0" src="<c:out value="${jspStoreImgDir}"/>images/empty.gif"></iframe><![endif]-->
</div>
