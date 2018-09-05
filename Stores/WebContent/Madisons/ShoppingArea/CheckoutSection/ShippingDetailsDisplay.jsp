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
  * This JSP file renders the shipping section of the shipping and billing page of the checkout flow.
  * It decides whether to display single shipment or multiple shipment details by inspecting the
  * current order items. A shipment is made up of the combination of shipping address and shipping method
  * selected for the order items.
  *****
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ include file="../../include/JSTLEnvironmentSetup.jspf"%>
<%@ include file="../../include/nocache.jspf"%>

<c:set var="isAjaxCheckOut" value="true"/>
<%-- Check if its a non-ajax checkout..--%>
<flow:ifDisabled feature="AjaxCheckout"> 
	<c:set var="isAjaxCheckOut" value="false"/>
</flow:ifDisabled>

<c:set var="shipmentTypeId" value="1"/>
<c:if test="${!empty param.shipmentTypeId}">
	<c:set var="shipmentTypeId" value="${param.shipmentTypeId}"/>
</c:if>


<c:set var="orderShipModeInfo" value="${requestScope.orderUsableShipping}"/>
 <c:if test="${empty orderShipModeInfo || orderShipModeInfo == null}">
	<wcf:getData type="com.ibm.commerce.order.facade.datatypes.OrderType"
				   var="orderShipModeInfo" expressionBuilder="findUsableShippingInfoWithPagingOnItem" varShowVerb="ShowVerbUsableShippingInfo" maxItems="${maxOrderItemsToInspect}" scope="request">
				   <wcf:param name="accessProfile" value="IBM_UsableShippingInfo" />
				   <wcf:param name="orderId" value="${param.orderId}" />	
	</wcf:getData>
</c:if>
<fmt:parseNumber var="maxOrderItemsToInspect" value="${maxOrderItemsToInspect}"/>
<c:choose>
	<c:when test="${param.recordSetTotal<=maxOrderItemsToInspect}">
		<c:set var="numberOfOrderItemsToInspect" value="${param.recordSetTotal}"/>
	</c:when>
	<c:otherwise>
		<c:set var="numberOfOrderItemsToInspect" value="${maxOrderItemsToInspect}"/>
		<c:set var="hideSingleShipment" value="true"/>
	</c:otherwise>
</c:choose>
<c:set var="hideSingleShipment" value="false"/>
<c:if test="${empty orderShipModeInfo.usableShippingAddress}">
				<c:set var="hideSingleShipment" value="true"/>
</c:if>

<c:if test="${!hideSingleShipment}">
<c:choose>
<c:when test="${b2bStore || shipmentTypeId == 2}">
	<c:set var="endCount" value="${numberOfOrderItemsToInspect-1}"/>
</c:when>
<c:otherwise>
	<c:set var="endCount" value="${0}"/>
</c:otherwise>
</c:choose>


<jsp:useBean id="shipModeMap" class="java.util.HashMap" scope="request"/>
<c:forEach var="i" begin="0" end="${endCount}">
		<c:forEach var="shipMode" items="${orderShipModeInfo.orderItem[i].usableShippingMode}">
			<c:set var="shipModeId" value="${shipMode.shippingModeIdentifier.uniqueID}"/>
			<c:set var="shipModeCnt" value="${shipModeMap[shipModeId]}"/>
			<c:choose>
			<c:when test="${empty shipModeCnt}">
				<c:set target="${shipModeMap}" property="${shipModeId}" value="1"/>
			</c:when>
			<c:otherwise>
				<c:set target="${shipModeMap}" property="${shipModeId}" value="${shipModeCnt+1}"/>
			</c:otherwise>
			</c:choose>
		</c:forEach>
</c:forEach>

<c:set var="orderItemCount" value="${fn:length(orderShipModeInfo.orderItem)}"/>

	<c:set var="hideSingleShipment" value="true"/>
	<c:forEach var="shipMode" items="${orderShipModeInfo.orderItem[0].usableShippingMode}">
			<c:set var="shipModeId" value="${shipMode.shippingModeIdentifier.uniqueID}"/>
		
			<c:if test="${(!b2bStore && (shipModeMap[shipModeId] == orderItemCount)) || (shipModeMap[shipModeId] == numberOfOrderItemsToInspect)}">
				
				<c:set var="hideSingleShipment" value="false"/>
			</c:if>
	</c:forEach>
</c:if>

<script type="text/javascript">
	dojo.addOnLoad(function() {
		CheckoutHelperJS.initializeShipmentPage('<c:out value='${shipmentTypeId}'/>');
		CheckoutHelperJS.setAjaxCheckOut(<c:out value="${isAjaxCheckOut}"/>);
		CheckoutHelperJS.setCommonParameters('<c:out value="${langId}"/>','<c:out value="${storeId}"/>','<c:out value="${catalogId}"/>');
	});
</script>

<wcf:url var="MultipleShipmentPageURL" value="OrderShippingBillingView">
  <wcf:param name="langId" value="${langId}" />						
  <wcf:param name="storeId" value="${WCParam.storeId}" />
  <wcf:param name="catalogId" value="${WCParam.catalogId}" />
   <wcf:param name="orderId" value="${WCParam.orderId}" />
  <wcf:param name="quickCheckoutProfileForPayment" value="${WCParam.quickCheckoutProfileForPayment}" />
  <wcf:param name="forceShipmentType" value="2" />
</wcf:url>

<%@ include file="../../Snippets/Marketing/Promotions/PromotionChoiceOfFreeGiftsPopup.jspf" %>

<div class="main_header" id="WC_ShipmentDisplay_div_5">
	<div class="left_corner" id="WC_ShipmentDisplay_div_6"></div>
	<div class="left" id="WC_ShipmentDisplay_div_7"><span class="main_header_text"><fmt:message key="BCT_SHIPPING_INFO" bundle="${storeText}"/></span></div>
	<div class="right_corner" id="WC_ShipmentDisplay_div_8"></div>
</div>
<c:choose>
	<c:when test = "${shipmentTypeId == 1}">
		<flow:ifEnabled  feature="MultipleShipments">	
		   <div class="content_header" id="WC_ShipmentDisplay_div_9">
				<div class="left_corner" id="WC_ShipmentDisplay_div_10"></div>
				<div class="left" id="WC_ShipmentDisplay_div_11"><span class="content_text"><fmt:message key="SHIP_MULTIPLE_SHIPMENT_MESSAGE" bundle="${storeText}"/></span></div>
				<div class="header_element_align" id="WC_ShipmentDisplay_div_12">
					<span class="primary_button button_fit" >
						<span class="button_container">
							<span class="button_bg">
								<span class="button_top">
									<span class="button_bottom">   
										<a href='<c:out value="${MultipleShipmentPageURL}"/>'  id="WC_ShipmentDisplay_links_3">
											<fmt:message key="SHIP_MULTIPLE_SHIPMENTS" bundle="${storeText}"/><span class="spanacce"><fmt:message key="Checkout_ACCE_Multi_Shipping" bundle="${storeText}"/></span>
										</a>
									</span>
								</span>	
							</span>
						</span>	
					</span>
				</div>
				<div class="right_corner" id="WC_ShipmentDisplay_div_15"></div>
		   </div>
	   </flow:ifEnabled>
	   <c:if test="${!isAjaxCheckOut}">
			<script type="text/javascript">
				///////////////////////////////////////////////////////////////////////
				// On page load, we add the editable fields in the shipping information
				// section to dojo event listener so that when they are changed by the
				// user, we ask the user to update the shipping information before
				// proceeding to checkout.
				///////////////////////////////////////////////////////////////////////
				dojo.addOnLoad(CheckoutHelperJS.initDojoEventListenerSingleShipmentPage);
			</script>
		</c:if>
	</c:when>
	<c:otherwise>
		<c:if test="${!hideSingleShipment}">
		 <div class="content_header" id="WC_MultipleShipmentDisplay_div_9">
			<div class="left_corner" id="WC_MultipleShipmentDisplay_div_10"></div>
			<c:forEach var="shipMode" items="${orderShipModeInfo.orderItem[0].usableShippingMode}">
				<c:set var="shipModeId" value="${shipMode.shippingModeIdentifier.uniqueID}"/>
					<c:if test="${((!b2bStore && (shipModeMap[shipModeId] == orderItemCount)) || shipModeMap[shipModeId] == numberOfOrderItemsToInspect) && empty commonShipModeId}">
						<c:set var="commonShipModeId" value="${shipModeId}"/>
					</c:if>
			</c:forEach>
			<input type="hidden" id="commonShipModeId" name="commonShipModeId" value="${commonShipModeId}"/>
			<div class="left" id="WC_MultipleShipmentDisplay_div_11"><span class="content_text"><fmt:message key="SHIP_SINGLE_SHIPMENT_MESSAGE" bundle="${storeText}"/></span></div>
			<div class="header_element_align" id="WC_MultipleShipmentDisplay_div_12">
				<span class="primary_button button_fit" >
					<span class="button_container">
						<span class="button_bg">
							<span class="button_top">
								<span class="button_bottom">   
									<a href="JavaScript:setCurrentId('WC_MultipleShipmentDisplay_links_3'); CheckoutHelperJS.moveAllItemsToSingleShipment()" id="WC_MultipleShipmentDisplay_links_3">
										<fmt:message key="SHIP_SINGLE_SHIPMENT" bundle="${storeText}"/><span class="spanacce"><fmt:message key="Checkout_ACCE_Single_Shipping" bundle="${storeText}"/></span>
									</a>
								</span>
							</span>	
						</span>
					</span>
				</span>	
			</div>
			<div class="right_corner" id="WC_MultipleShipmentDisplay_div_15"></div>
		 </div>
		</c:if>
	  
	   <c:if test="${!isAjaxCheckOut}">
			<script type="text/javascript">
				///////////////////////////////////////////////////////////////////////
				// On page load, we add the editable fields in the shipping information
				// section to dojo event listener so that when they are changed by the
				// user, we ask the user to update the shipping information before
				// proceeding to checkout.
				///////////////////////////////////////////////////////////////////////
				dojo.addOnLoad(CheckoutHelperJS.initDojoEventListenerMultiShipmentPage);
			</script>
		</c:if>
	</c:otherwise>
</c:choose>


<div class="body" id="WC_ShipmentDisplay_div_16">
	<div id="shipping">
		<c:choose>
			<c:when test = "${shipmentTypeId == 1}">
				<div dojoType="wc.widget.RefreshArea" id = "shippingAddressSelectBoxArea" widgetId="shippingAddressSelectBoxArea" controllerId="shippingAddressSelectBoxAreaController" >	
					 <%out.flush();%>
						<c:import url="${jspStoreDir}ShoppingArea/CheckoutSection/SingleShipment/ShippingAddressSelect.jsp">
							<c:param value="${selectedAddressId}" name="addressId"/>
							 <c:param value="${param.orderId}" name="orderId"/>
						</c:import>
					<%out.flush();%>
				</div>
				<script type="text/javascript">
					dojo.addOnLoad(function() { 
						parseWidget("shippingAddressSelectBoxArea"); 
					});
				</script>

				<%out.flush();%>
					<c:import url="${jspStoreDir}ShoppingArea/CheckoutSection/SingleShipment/SingleShipmentShippingMethodDetails.jsp">
						 <c:param value="${param.orderId}" name="orderId"/>
					</c:import>
				<%out.flush();%>
				<div dojoType="wc.widget.RefreshArea" widgetId="singleShipmentOrderDetails"  controllerId="traditionalShipmentDetailsController" role="wairole:region" waistate:live="polite" waistate:atomic="true" waistate:relevant="text" id="WC_ShipmentDisplay_div_17">
					<%out.flush();%>
						<c:import url="${jspStoreDir}ShoppingArea/CheckoutSection/SingleShipment/OrderItemDetails.jsp">
							<%-- OrderShippingBillingView is used both in AJAX and non-AJAX checkout flow --%>
							<c:param name="returnView" value="OrderShippingBillingView"/>
						</c:import> 
					<%out.flush();%>
				</div>
				<script type="text/javascript">
					dojo.addOnLoad(function() { 
						parseWidget("WC_ShipmentDisplay_div_17");
					});
				</script>
			</c:when>
			<c:otherwise>
				<c:set var="shipAsCompleteCheckBoxStatus" value="false"/>
				<c:if test="${order.shipAsComplete}">
					<c:set var="shipAsCompleteCheckBoxStatus" value="true"/>
				</c:if>
				<div id="WC_MultipleShipmentDisplay_div_17">
					<br/>
					<span class="checkbox">
							<input type="checkbox" title="<fmt:message key="SHIP_SHIP_AS_COMPLETE" bundle="${storeText}"/>" class="checkbox" id="shipAsComplete" name = "shipAsComplete" onClick="setCurrentId('shipAsComplete'); CheckoutHelperJS.shipAsComplete(this)"
							<c:if test="${shipAsCompleteCheckBoxStatus}">
								checked="checked"
							</c:if> />
						<span class="text"><label for="shipAsComplete"><fmt:message key="SHIP_SHIP_AS_COMPLETE" bundle="${storeText}"/></label></span>
					</span>
				</div>
				<%-- Show shipping charge refresh area --%>
				<flow:ifEnabled feature="ShippingChargeType">
					<div id="WC_MultipleShipmentDisplay_ShipCharge_Area" dojoType="wc.widget.RefreshArea" widgetId="multipleShipmentShipCharge"  controllerId="multipleShipmentShipChargeController" role="wairole:region" waistate:live="polite" waistate:atomic="true" waistate:relevant="text">
						<%out.flush();%>
							<c:import url="${jspStoreDir}ShoppingArea/CheckoutSection/MultipleShipment/MultipleShipmentShipChargeExt.jsp">
								<c:param name="orderId" value="${param.orderId}"/>
							</c:import>
						<%out.flush();%>
					</div>
					<script type="text/javascript">dojo.addOnLoad(function() { 
						parseWidget("WC_MultipleShipmentDisplay_ShipCharge_Area"); 
					});</script>
				</flow:ifEnabled>
				
				<div id="WC_MultipleShipmentDisplay_div_18" dojoType="wc.widget.RefreshArea" widgetId="multipleShipmentOrderDetails"  controllerId="multipleShipmentDetailsController" role="wairole:region" waistate:live="polite" waistate:atomic="true" waistate:relevant="text">
					<%out.flush();%>
						<c:import url="${jspStoreDir}ShoppingArea/CheckoutSection/MultipleShipment/MSOrderItemDetails.jsp">
							<c:param value="${param.orderId}" name="orderId"/>
						</c:import> 
					<%out.flush();%>
				</div> 
				<script type="text/javascript">
					dojo.addOnLoad(function() { 
					parseWidget("WC_MultipleShipmentDisplay_div_18"); 
					});
				</script>				
				<c:if test="${!isAjaxCheckOut}">
					<!-- if its an non ajax checkout get the address details in short for all the valid address in invisible div..will use it later -->
					<%out.flush();%>
						<c:import url="${jspStoreDir}ShoppingArea/CheckoutSection/MultipleShipment/ShippingAddressDetailsInShort.jsp">
							 <c:param value="${param.orderId}" name="orderId"/>
						</c:import>
					<%out.flush();%>
				</c:if>
			</c:otherwise>
		</c:choose>

		<flow:ifEnabled feature="SharedShippingBillingPage">
			<c:set var="fromPage" value="shippingBillingPage"/>
		</flow:ifEnabled>
		<flow:ifDisabled feature="SharedShippingBillingPage">
			<c:set var="fromPage" value="shippingPage"/>
		</flow:ifDisabled>

		<div dojoType="wc.widget.RefreshArea" widgetId="singleShipmentOrderTotalsDetail"  controllerId="currentOrderTotalsAreaController" role="wairole:region" waistate:live="polite" waistate:atomic="true" waistate:relevant="text" id="WC_ShipmentDisplay_div_18">
			<%out.flush();%>
				<c:import url="${jspStoreDir}ShoppingArea/CheckoutSection/SingleShipment/SingleShipmentOrderTotalsSummary.jsp">
					<%-- OrderShippingBillingView is used both in AJAX and non-AJAX checkout flow --%>
					<c:param name="returnView" value="OrderShippingBillingView"/>
					<c:param name="fromPage" value="${fromPage}"/>
				</c:import>
			<%out.flush();%>
		</div>
		<script type="text/javascript">
			dojo.addOnLoad(function() { 
				parseWidget("WC_ShipmentDisplay_div_18"); 
			});
		</script>
	</div>
	<br clear="all" />
</div>

<!-- This button is required only for Non-Ajax Checkout.. -->
 <c:choose>
	<c:when test = "${shipmentTypeId == 1}">
		<c:if test="${!isAjaxCheckOut}">
			<div class="body" id="WC_ShipmentDisplay_div_19">
				<div id="total_breakdown" >
					<span class="right" >
						<span class="primary_button button_fit" >
							<span class="button_container">
								<span class="button_bg">
									<span class="button_top">
										<span class="button_bottom">   
											<a href="#" onclick="JavaScript:CheckoutHelperJS.updateSingleShipmentShoppingCart(document.ShopCartForm);return false;" id="SingleShipment_NonAjaxShipInfoUpdate"><fmt:message key="UPDATE" bundle="${storeText}"/></a>
										</span>
									</span>	
								</span>
							</span>
						</span>
					</span>	
				</div>
				<br clear="all" />
			</div>
		</c:if>
	</c:when>
	<c:otherwise>
		<c:if test="${!isAjaxCheckOut}">
			<div class="body" id="WC_MultipleShipmentDisplay_div_20">
				<div id="total_breakdown">
					<span class="right" >
						<span class="primary_button button_fit" >
							<span class="button_container">
								<span class="button_bg">
									<span class="button_top">
										<span class="button_bottom">   
											<a href="#" onclick="Javascript:CheckoutHelperJS.updateMultiShipmentShoppingCart(document.ShopCartForm);return false;" id="MultipleShipment_NonAjaxShipInfoUpdate"><fmt:message key="UPDATE" bundle="${storeText}"/></a>
										</span>
									</span>	
								</span>
							</span>
						</span>
					</span>
				</div>
			<br clear="all" />
			</div>
		</c:if>
	</c:otherwise>
</c:choose>
