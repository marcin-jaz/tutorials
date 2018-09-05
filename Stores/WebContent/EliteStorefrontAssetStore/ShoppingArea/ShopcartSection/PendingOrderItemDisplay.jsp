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
  * This JSP file displays the pending order details. It shows an empty shopping cart page accordingly.
  *****
--%>                    
<!-- Start - JSP File Name:  PendingOrderItemDisplay.jsp -->

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../include/JSTLEnvironmentSetup.jspf"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!-- Get order Details using the ORDER SOI -->
<c:set var="pageSize" value="${maxOrderItemsPerPage}"/>	

<c:set var="beginIndex" value="${WCParam.beginIndex}" />
<c:if test="${empty beginIndex}">
	<c:set var="beginIndex" value="0" />
</c:if>

<c:set var="orderId" value="${param.orderId}"/>
<c:if test="${empty orderId}">
	<c:set var="orderId" value="${WCParam.orderId}"/>
</c:if>
<c:choose>
<c:when test="${!empty orderId}">
	<wcf:getData type="com.ibm.commerce.order.facade.datatypes.OrderType" scope="request" 
		var="order" expressionBuilder="findByOrderIdWithPagingOnItem" varShowVerb="ShowVerbCart" maxItems="${pageSize}" recordSetStartNumber="${beginIndex}" recordSetReferenceId="ostatus">
		<wcf:param name="orderId" value="${orderId}" />	 
		<wcf:param name="sortOrderItemBy" value="orderItemID" />
		<wcf:param name="isSummary" value="false" />
	</wcf:getData>
	
	<c:if test="${empty order.orderItem && beginIndex >= pageSize}">
		<c:set var="beginIndex" value="${beginIndex - pageSize}" />
		<wcf:getData type="com.ibm.commerce.order.facade.datatypes.OrderType" scope="request" 
			var="order" expressionBuilder="findByOrderIdWithPagingOnItem" varShowVerb="ShowVerbCart" maxItems="${pageSize}" recordSetStartNumber="${beginIndex}" recordSetReferenceId="ostatus">
			<wcf:param name="orderId" value="${orderId}" />	  
			<wcf:param name="sortOrderItemBy" value="orderItemID" />
			<wcf:param name="isSummary" value="false" />
		</wcf:getData>
	</c:if>
</c:when>
<c:otherwise>
	<wcf:getData type="com.ibm.commerce.order.facade.datatypes.OrderType" scope="request" 
		var="order" expressionBuilder="findCurrentShoppingCartWithPagingOnItem" varShowVerb="ShowVerbCart" maxItems="${pageSize}" recordSetStartNumber="${beginIndex}" recordSetReferenceId="ostatus">
		<wcf:param name="accessProfile" value="IBM_Details" />	 
		<wcf:param name="sortOrderItemBy" value="orderItemID" />
		<wcf:param name="isSummary" value="false" />
	</wcf:getData>
	
	<c:if test="${empty order.orderItem && beginIndex >= pageSize}">
		<c:set var="beginIndex" value="${beginIndex - pageSize}" />
		<wcf:getData type="com.ibm.commerce.order.facade.datatypes.OrderType" scope="request" 
			var="order" expressionBuilder="findCurrentShoppingCartWithPagingOnItem" varShowVerb="ShowVerbCart" maxItems="${pageSize}" recordSetStartNumber="${beginIndex}" recordSetReferenceId="ostatus">
			<wcf:param name="accessProfile" value="IBM_Details" />	 
			<wcf:param name="sortOrderItemBy" value="orderItemID" />
			<wcf:param name="isSummary" value="false" />
		</wcf:getData>
	</c:if>
	</c:otherwise>
</c:choose>

 <wcf:url var="PendingOrderDisplayViewURL" value="PendingOrderDisplayView" type="Ajax">
     <wcf:param name="langId" value="${langId}" />                                          
     <wcf:param name="storeId" value="${WCParam.storeId}" />
     <wcf:param name="catalogId" value="${WCParam.catalogId}" />
     <wcf:param name="orderId" value="${order.orderIdentifier.uniqueID}" />
 </wcf:url>  

<wcf:url var="currentShoppingCartLink" value="ShopCartPageView" type="Ajax">
	<wcf:param name="storeId"   value="${WCParam.storeId}"  />
	<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
	<wcf:param name="langId" value="${WCParam.langId}" />
</wcf:url>

<wcf:url var="ShoppingCartURL" value="OrderCalculate" type="Ajax">
   <wcf:param name="langId" value="${langId}" />
  <wcf:param name="storeId" value="${WCParam.storeId}" />
  <wcf:param name="catalogId" value="${WCParam.catalogId}" />
  <wcf:param name="URL" value="AjaxOrderItemDisplayView" />
  <wcf:param name="errorViewName" value="AjaxOrderItemDisplayView" />
  <wcf:param name="updatePrices" value="1" />
  <wcf:param name="calculationUsageId" value="-1" />
  <wcf:param name="orderId" value="${order.orderIdentifier.uniqueID}" />
</wcf:url>

<wcf:url var="OrderCalculateURL" value="OrderShippingBillingView" type="Ajax">
	<wcf:param name="langId" value="${langId}" />						
	<wcf:param name="storeId" value="${WCParam.storeId}" />
	<wcf:param name="catalogId" value="${WCParam.catalogId}" />
	<wcf:param name="shipmentType" value="single" />
</wcf:url>

<wcf:url var="PhysicalStoreSelectionURL" value="CheckoutStoreSelectionView">
	<wcf:param name="langId" value="${langId}" />
	<wcf:param name="storeId" value="${WCParam.storeId}" />
	<wcf:param name="catalogId" value="${WCParam.catalogId}" />
	<wcf:param name="fromPage" value="ShoppingCart" />
</wcf:url>

<c:set var="showTax" value="false"/>
<c:set var="showShipping" value="false"/>

         
<div id="content759">
		<div id="box">    
		<div class="contentgrad_header">
			<div class="left_corner"></div>
			<div class="left"></div>
			<div class="right_corner"></div>
		</div>      
	
		
		<script type="text/javascript">
			dojo.addOnLoad(function() { 
				parseWidget("PendingOrderPagingDisplay");
				savedOrdersJS.setOrderId('<c:out value="${orderId}"/>');
				savedOrdersJS.setCurrentShoppingCartURL('${ShoppingCartURL}');
				ShipmodeSelectionExtJS.setOrderItemId('${order.orderItem[0].orderItemIdentifier.uniqueID}');
			});
			
		</script>
		
		<flow:ifDisabled feature="AjaxCheckout"> 
			<script type="text/javascript">
				dojo.addOnLoad(function() { 
				
				var shopCartForm = document.getElementById("ShopCartForm");
				if (shopCartForm != null && shopCartForm != 'undefined')
				{
					shopCartForm.elements["URL"].value="${PendingOrderDisplayViewURL}";	
				}
				
				});
			</script>
		</flow:ifDisabled>	
		<div class="body759" id="WC_ShopCartDisplay_div_5">
		<div id="savedOrdersDetailsTableContainer">
		<div class="info_table" id="savedOrderDetailsTable"> 
							<div class="row" id="savedOrderDetailsTable_OrderNumberRow">  
								<div class="label savedOrderDetailsTableHeader" id="savedOrderDetailsTable_OrderNumberLabel">
									<fmt:message key="PENDING_ORDER_DETAILS_ORDER_NUMBER" bundle="${storeText}"/>
										
								</div>
								<div class="info_content savedOrderDetailsTableContent" id="savedOrderDetailsTable_OrderNumberContent">  
									<c:out value="${orderId}"/>
								</div>
								<div class="clear_float"></div> 
							</div>
					
						<div class="clear_float"></div> 
						
						<div class="row" id="savedOrderDetailsTable_LastUpdateRow">  
								<div class="label" id="savedOrderDetailsTable_LastUpdateLabel">
									<fmt:message key="PENDING_ORDER_DETAILS_LAST_UPDATE" bundle="${storeText}"/>
									
								
								</div>
								<div class="info_content savedOrderDetailsTableContent" id="savedOrderLastUpdate_OrderNumberContent">  
									<c:choose>
										<c:when test="${!empty order.lastUpdateDate}">
											<c:catch>
												<fmt:parseDate var="lastUpdateDate" value="${order.lastUpdateDate}" pattern="yyyy-MM-dd'T'HH:mm:ss.SSS'Z'" timeZone="GMT"/>
											</c:catch>
											<c:if test="${empty lastUpdateDate}">
												<c:catch>
													<fmt:parseDate var="lastUpdateDate" value="${order.lastUpdateDate}" pattern="yyyy-MM-dd'T'HH:mm:ss'Z'" timeZone="GMT"/>
												</c:catch>
											</c:if>
											<p><fmt:formatDate value="${lastUpdateDate}" dateStyle="long"/></p>
										</c:when>
										<c:otherwise>
											<p><br /></p>
										</c:otherwise>
									</c:choose>
								</div>
								<div class="clear_float"></div> 
							</div>
					
						<div class="clear_float"></div>
						
						  
						  
						<div class="row" id="savedOrderDetailsTable_OrderDescRow">  
								<div class="label" id="savedOrderDetailsTable_OrderDescLabel">
									<label for="OrderDescription_input"><fmt:message key="PENDING_ORDER_DETAILS_ORDER_DESCRIPTION" bundle="${storeText}"/></label>
									
								</div>
								<div class="info_content savedOrderDetailsTableContent" id="savedOrderDetailsTable_OrderDescContent">  
									<div class="left">
										<input class="left savedOrderDetailsInputBorder" type="text" value="<c:out value='${order.orderDescription}'/>" title="<fmt:message key="SAVED_ORDERS_ORDER_NAME_LABEL" bundle="${storeText}"><fmt:param value="${orderId}"/></fmt:message>" name="OrderDescription_input" id="OrderDescription_input" maxlength="254" onchange="savedOrdersJS.modifyInputBorder(this)"/>
										<input class="nodisplay" type="hidden" id="OldOrderDescription" name="OldOrderDescription" value='<c:out value="${order.orderDescription}"/>' />
									</div>
								
									
									<div class="left" id="saveDescriptionButton">
										<span class="primary_button" id="WC_SavedOrder_button_save" >
											<span class="button_container">
												<span class="button_bg">
													<span class="button_top">
														<span class="button_bottom">   
															<a href="#" onclick="javaScript:setCurrentId('savedOrderDetailsTable_OrderDescRow'); savedOrdersJS.updateDescription('${orderId}','OrderDescription_input','OldOrderDescription'); return false;" id="orderDescSaveLink" >
																<fmt:message key="SHOPCART_UPDATE" bundle="${storeText}"/>
															</a>
														</span>
													</span>
												</span>	
											</span>
										</span>
									</div>
									
									<label class="nodisplay" for="orderDescSaveLink"><fmt:message key="SAVED_ORDER_SAVE_LABEL" bundle="${storeText}"/></label>
									
								</div>
								<div class="clear_float"></div> 
							</div>
					
						<div class="clear_float"></div>
						
						
						<div class="row" id="savedOrderDetailsTable_TotalPriceRow">  
								<div class="label" id="savedOrderDetailsTable_TotalPriceLabel">
									<fmt:message key="PENDING_ORDER_DETAILS_TOTAL_PRICE" bundle="${storeText}"/>
									
								</div>
								<div class="info_content savedOrderDetailsTableContent" id="savedOrderDetailsTable_TotalPriceContent">  
									<p><fmt:formatNumber value="${order.orderAmount.totalProductPrice.value}" type="currency" maxFractionDigits="${currencyDecimal}" currencySymbol="${currencyFormatterDB.currencySymbol}"/></p>
								</div>
								<div class="clear_float"></div> 
							</div>
					
						<div class="clear_float"></div>
					</div>
				</div>	
					
					
		 	<c:choose>  
			<c:when test="${!empty order.orderItem }" >
					
					<%out.flush();%>
						<c:import url="${jspStoreDir}Snippets/Order/Cart/ShipmodeSelectionExt.jsp"/> 
					<%out.flush();%>
					
					<div dojoType="wc.widget.RefreshArea" widgetId="PendingOrderPagingDisplay" id="PendingOrderPagingDisplay" controllerId="PendingOrderPaginationDisplayController" role="wairole:region" waistate:live="polite" waistate:atomic="false" waistate:relevant="all">
					<%out.flush();%>
					<c:import url="${jspStoreDir}Snippets/Order/Cart/OrderItemDetail.jsp"> 
							<c:param name="catalogId" value="${WCParam.catalogId}" />
							<c:param name="langId" value="${WCParam.langId}" />
							<c:param name="storeId" value="${WCParam.storeId}" />
							<c:param name="fromPage" value="pendingOrderDisplay" />
							
					</c:import>
					<%out.flush();%>
					</div>
					
					<%out.flush();%>
					     <c:import url="${jspStoreDir}Snippets/Marketing/Promotions/PromotionPickYourFreeGift.jsp"/>
					<%out.flush();%>
					<%out.flush();%>
						<c:import url="${jspStoreDir}ShoppingArea/CheckoutSection/SingleShipment/SingleShipmentOrderTotalsSummary.jsp"> 
							<c:param name="returnView" value="AjaxOrderItemDisplayView"/>
							<c:param name="fromPage" value="pendingOrderDisplay"/>
						</c:import>
					<%out.flush();%>
					 <br clear="all" />
					 <br />
					 <div class="left" id="setCurrentButton">
						<span class="primary_button" id="WC_PendingOrderItemDisplay_SetCurrent" >
							<span class="button_container">
								<span class="button_bg">
									<span class="button_top">
										<span class="button_bottom">   
											<a href="#" onclick="javascript: savedOrdersJS.setCurrentOrder();" id="shopcartSetCurrent" >
												<fmt:message key="PENDING_ORDER_DETAILS_SET_CURRENT" bundle="${storeText}"/>
									
											</a>
										</span>
									</span>
								</span>	
							</span>
						</span>
					</div>	
					
					<div class="left" id="pendingOrdercheckoutButton">
						<span class="primary_button" id="WC_PendingOrderItemDisplay_SetCurrent_Checkout" >
							<span class="button_container">
								<span class="button_bg">
									<span class="button_top">
										<span class="button_bottom">   
											<a href="#" onclick="javascript:savedOrdersJS.setCurrentOrderAndCheckout('${OrderCalculateURL}', '${PhysicalStoreSelectionURL}'); return false;" id="shopcartCheckout" >
												<fmt:message key="PENDING_ORDER_DETAILS_SET_CURRENT_CHECKOUT" bundle="${storeText}"/>
												
											</a>
										</span>
									</span>
								</span>	
							</span>
						</span>
					</div>	
					<flow:ifDisabled feature="AjaxCheckout"> 
						<div class="left" id="updateShopCart"> 
							<span class="primary_button button_fit" id="WC_PendingOrderItemDisplay_ShopCart_Update" >
								<span class="button_container">
									<span class="button_bg">
										<span class="button_top">
											<span class="button_bottom">   
												<a href="#" onclick="javascript: savedOrdersJS.updateDescription('${orderId}','OrderDescription_input','OldOrderDescription', true); return false;" id="ShoppingCart_NonAjaxUpdate">
													<fmt:message key="SHOPCART_UPDATE" bundle="${storeText}"/>
												</a>
											</span>
										</span>
									</span>		
								</span>
							</span>	
						</div>	
							
					</flow:ifDisabled>
				 <br />
				 <br />
								   
			</c:when>  
			<c:otherwise>
			
				
						<c:set var="currentPage" value="pendingOrderPage" scope="request"/>
				
					 <%@ include file="../../Snippets/ReusableObjects/EmptyShopCartDisplay.jspf"%>
					 <div class="left" id="setCurrentButton">
						<span class="primary_button" id="WC_CheckoutLogonf_div_10" >
							<span class="button_container">
								<span class="button_bg">
									<span class="button_top">
										<span class="button_bottom">   
											<a href="#" onclick="javascript: savedOrdersJS.setCurrentOrder();" id="shopcartCheckout" >
												<fmt:message key="PENDING_ORDER_DETAILS_SET_CURRENT" bundle="${storeText}"/>
												
											</a>
										</span>
									</span>
								</span>	
							</span>
						</span>
					</div>	
					
					 <br />
					 <br />
				
			</c:otherwise>
		</c:choose>
		</div>
		<div class="footer" id="WC_ShopCartDisplay_div_7">
			<div class="left_corner" id="WC_ShopCartDisplay_div_8"></div>
			<div class="left" id="WC_ShopCartDisplay_div_9"></div>
			<div class="right_corner" id="WC_ShopCartDisplay_div_10"></div>
		</div>
	</div>
</div>  					

<!-- End - JSP File Name:  PendingOrderItemDisplay.jsp -->