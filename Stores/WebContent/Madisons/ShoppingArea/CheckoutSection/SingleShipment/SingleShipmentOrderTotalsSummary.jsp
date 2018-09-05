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
  * This JSP file renders the order totals section used throughout the entire checkout flow.
  *****
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf"%>

<script type="text/javascript">
	dojo.addOnLoad(initDiscountDetails);
	
	function initDiscountDetails(){	
		<%-- Initially discountDetailsSection div will be hidden (Otherwise all the tooltip pop-ups will be visible and disappear only after dojo parses it. So hide them initially). Display it on page load. --%>
		if(document.getElementById("discountDetailsSection")!=null )  {
			document.getElementById("discountDetailsSection").style.display = "block";
		}
	}
</script>

<c:set var="order" value="${requestScope.order}" />
<%-- the following check is to handle the AJAX case in the Shopping Cart page and Shipment Display page 
	when user modifies his/her order. In both pages, the "order" data is of the same type and has the same parameters --%>
<c:if test="${empty order || order==null}">
	<wcf:getData type="com.ibm.commerce.order.facade.datatypes.OrderType"
		var="order" expressionBuilder="findCurrentShoppingCart">
		<wcf:param name="accessProfile" value="IBM_Summary" />
	</wcf:getData>
</c:if>

<c:set var="totalProductDiscount" value="0"/>
<c:set var="hasProductDiscount" value="false"/>
<c:set var="showTotals" value="true"/>

<flow:ifDisabled feature="SharedShippingBillingPage">
	<c:if test="${param.fromPage eq 'shoppingCartDisplay' || param.fromPage eq 'shippingPage'}">
		<c:set var="showTotals" value="false"/>
	</c:if>
</flow:ifDisabled>


<div id="total_breakdown">
	<table id="order_total" cellpadding="0" cellspacing="0" border="0" summary="<fmt:message key="ORDER_TOTAL_TABLE_SUMMARY" bundle="${storeText}"/>">
		
		<%-- ORDER SUMMARY LINE - order subtotal --%>
		<tr> 
			<td class="total_details" id="WC_SingleShipmentOrderTotalsSummary_td_1"><fmt:message key="ORD_ORDER_SUBTOTAL" bundle="${storeText}"/>:</td>
			<td class="total_figures" id="WC_SingleShipmentOrderTotalsSummary_td_2"><fmt:formatNumber value="${order.orderAmount.totalProductPrice.value}" type="currency" maxFractionDigits="${currencyDecimal}" currencySymbol="${currencyFormatterDB.currencySymbol}"/></td>
		</tr>
		
	<c:if test="${showTotals eq true}">
		<%-- TOTAL PRODUCT DISCOUNTS --%>
		<%-- Check and see if there is any product (i.e. order item) level adjustment to display --%>
		<tr>
			<c:forEach var="orderItemAdjustment" items="${order.orderAmount.adjustment}">
				<c:if test="${!hasProductDiscount}">
					<c:if test="${orderItemAdjustment.displayLevel.name == 'OrderItem'}">
						<c:set var="hasProductDiscount" value="true"/>
						<td class="total_details" id="WC_SingleShipmentOrderTotalsSummary_td_11"><fmt:message key="ORD_ORDER_DISCOUNTS_PRODUCTS" bundle="${storeText}"/>:</td>
					</c:if>
				</c:if>
			</c:forEach>
			<c:forEach var="orderItemAdjustment" items="${order.orderAmount.adjustment}">
				<c:if test="${hasProductDiscount}">
					<c:if test="${orderItemAdjustment.displayLevel.name == 'OrderItem'}">
						<c:set var="totalProductDiscount" value="${totalProductDiscount + orderItemAdjustment.amount.value}"/>
					</c:if>
				</c:if>
			</c:forEach>
			<c:if test="${hasProductDiscount}">
				<td class="total_figures" id="WC_SingleShipmentOrderTotalsSummary_td_12"><fmt:formatNumber value="${totalProductDiscount}" type="currency" maxFractionDigits="${currencyDecimal}" currencySymbol="${currencyFormatterDB.currencySymbol}"/></td>
			</c:if>
			<c:if test="${!hasProductDiscount}">
				<td></td>
			</c:if>
		</tr>
		
		<%-- ORDER SUMMARY LINE - total order discount --%>
		<tr>
			<td class="total_details" id="WC_SingleShipmentOrderTotalsSummary_td_3">
				<%-- Check and see if there is any order level adjustment to display --%>
				<c:set var="displayDiscountTooltip" value="false"/>
				<c:forEach var="adjustment" items="${order.orderAmount.adjustment}">
					<c:if test="${!displayDiscountTooltip}">
						<c:if test="${adjustment.displayLevel.name == 'Order'}">
							<c:set var="displayDiscountTooltip" value="true"/>
						</c:if>
					</c:if>
				</c:forEach>
				<c:choose>
					<%-- displays a link and upon focus it will show a tooltip displaying order discount details --%>
					<c:when test="${displayDiscountTooltip}">
						<div id="discountDetailsSection" style="display:none">		
							<span class="info_icon" id="discountDetails" tabindex="0"><img src="<c:out value='${jspStoreImgDir}${vfileColor}/info.png'/>"  alt="<fmt:message key="ORD_DISCOUNT_ADJUSTMENTS" bundle="${storeText}"/>"/></span>			
							<fmt:message key="ORD_DISCOUNT_ADJUSTMENTS" bundle="${storeText}"/>: 							
							<div id="WC_SingleShipmentOrderTotalsSummary_span_1" dojoType="wc.widget.Tooltip" connectId="discountDetails" style="display: none;">
								<div id="tooltip_popup">
									<div class="header" id="WC_SingleShipmentOrderTotalsSummary_div_1"> 
										<div class="close" id="WC_SingleShipmentOrderTotalsSummary_div_2"><fmt:message key="ORD_DISCOUNT_DETAILS_TITLE" bundle="${storeText}"/></div>
									</div>
									<div class="bodyarea" id="WC_SingleShipmentOrderTotalsSummary_div_3">
										<div class="bodycontent" id="WC_SingleShipmentOrderTotalsSummary_div_4">
											<c:forEach var="adjustment" items="${order.orderAmount.adjustment}">
												<c:if test="${adjustment.displayLevel.name == 'Order'}">
													<c:out value="${adjustment.description.value}" escapeXml="false"/>&nbsp;
													<span class="tooltip_popup_price"><fmt:formatNumber value="${adjustment.amount.value}" type="currency" maxFractionDigits="${currencyDecimal}" currencySymbol="${currencyFormatterDB.currencySymbol}"/></span><br />
												</c:if>
											</c:forEach>
										</div>
									</div>
									<div class="footer" id="WC_SingleShipmentOrderTotalsSummary_div_5"> </div>
								</div>
							</div>
							<script type="text/javascript">
								dojo.addOnLoad(function() { 
									parseWidget("WC_SingleShipmentOrderTotalsSummary_span_1");
								});
							</script>
						</div>
					</c:when>
					<%-- if no discount is applied to the order - do not show details text and no tooltip --%>
					<c:otherwise>
						<fmt:message key="ORD_DISCOUNT_ADJUSTMENTS" bundle="${storeText}"/>: 
					</c:otherwise>
				</c:choose>
			</td>
			<td class="total_figures" id="WC_SingleShipmentOrderTotalsSummary_td_4"><fmt:formatNumber value="${order.orderAmount.totalAdjustment.value - totalProductDiscount}" type="currency" maxFractionDigits="${currencyDecimal}" currencySymbol="${currencyFormatterDB.currencySymbol}"/></td>
		</tr>
		
		<%-- for the shopping cart page only - do not show tax and shipping charge --%>
		<c:if test="${param.fromPage != 'shoppingCartDisplay' && param.fromPage != 'pendingOrderDisplay'}">
			<%-- ORDER SUMMARY LINE - tax --%>
			<tr>
				<td class="total_details" id="WC_SingleShipmentOrderTotalsSummary_td_5"><fmt:message key="TAX" bundle="${storeText}"/>:</td>
				<td class="total_figures" id="WC_SingleShipmentOrderTotalsSummary_td_6"><fmt:formatNumber value="${order.orderAmount.totalSalesTax.value}" type="currency" maxFractionDigits="${currencyDecimal}" currencySymbol="${currencyFormatterDB.currencySymbol}"/></td>
			</tr>	
			
			<%-- ORDER SUMMARY LINE - shipping charge --%>
			<tr>
				<td class="total_details" id="WC_SingleShipmentOrderTotalsSummary_td_7"><fmt:message key="ORD_SHIPPING" bundle="${storeText}"/>:</td>
				<td class="total_figures" id="WC_SingleShipmentOrderTotalsSummary_td_8"><fmt:formatNumber value="${order.orderAmount.totalShippingCharge.value}" type="currency" maxFractionDigits="${currencyDecimal}" currencySymbol="${currencyFormatterDB.currencySymbol}"/></td>
			</tr>				
			<%-- ORDER SUMMARY LINE - shipping tax --%>
			<tr>
				<td class="total_details" id="WC_SingleShipmentOrderTotalsSummary_td_14"><fmt:message key="ORD_SHIPPING_TAX" bundle="${storeText}"/>:</td>
				<td class="total_figures" id="WC_SingleShipmentOrderTotalsSummary_td_15"><fmt:formatNumber value="${order.orderAmount.totalShippingTax.value}" type="currency" maxFractionDigits="${currencyDecimal}" currencySymbol="${currencyFormatterDB.currencySymbol}"/></td>
			</tr>
		</c:if>
		
		<%-- ORDER SUMMARY LINE - order total --%>
		<tr>
			<td class="total_details order_total" id="WC_SingleShipmentOrderTotalsSummary_td_9"><fmt:message key="ORD_ORDER_TOTAL" bundle="${storeText}"/>:</td>
			<c:choose>
				<c:when test="${param.fromPage == 'shoppingCartDisplay'}">
					<td class="total_figures breadcrumb_current" id="WC_SingleShipmentOrderTotalsSummary_td_13"><fmt:formatNumber value="${order.orderAmount.totalProductPrice.value + order.orderAmount.totalAdjustment.value}" type="currency" maxFractionDigits="${currencyDecimal}" currencySymbol="${currencyFormatterDB.currencySymbol}"/></td>
				</c:when>
				<c:otherwise>
					<td class="total_figures breadcrumb_current" id="WC_SingleShipmentOrderTotalsSummary_td_10"><fmt:formatNumber value="${order.orderAmount.grandTotal.value}" type="currency" maxFractionDigits="${currencyDecimal}" currencySymbol="${currencyFormatterDB.currencySymbol}"/></td>
				</c:otherwise>
			</c:choose>
		</tr>
	</c:if>
	</table>

	<%-- promotion code area --%>
	<flow:ifEnabled feature="promotionCode">
		<c:if test="${param.fromPage != 'orderSummaryPage' && param.fromPage != 'orderConfirmationPage' && param.fromPage != 'pendingOrderDisplay'}">
			<div id="promotions">
				<%-- Flush the buffer so this fragment JSP is not cached twice --%>
				<%out.flush();%>
				<c:import url="${jspStoreDir}Snippets/Marketing/Promotions/PromotionCodeDisplay.jsp">
					<c:param name="orderId" value="${order.orderIdentifier.uniqueID}" />
					<c:param name="returnView" value="${param.returnView}" />
				</c:import>
				<%out.flush();%>
			</div>
		</c:if>
	</flow:ifEnabled>
</div>


<c:if test="${param.fromPage != 'orderConfirmationPage' && param.fromPage != 'orderSummaryPage' && param.fromPage != 'pendingOrderDisplay'}">
<%out.flush();%>
<c:import url="${jspStoreDir}Snippets/Marketing/Promotions/CouponWalletTable.jsp">
		<c:param name="orderId" value="${order.orderIdentifier.uniqueID}" />
		<c:param name="returnView" value="${param.returnView}" />
</c:import>
<%out.flush();%>
</c:if>
