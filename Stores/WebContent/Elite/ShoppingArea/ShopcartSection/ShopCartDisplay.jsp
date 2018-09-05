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
  * This JSP file displays the shopping cart details. It shows an empty shopping cart page accordingly.
  *****
--%>                    
<!-- Start - JSP File Name:  OrderItemDisplay.jsp -->

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../include/JSTLEnvironmentSetup.jspf"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!-- Get order Details using the ORDER SOI -->
<c:set var="pageSize" value="${WCParam.pageSize}" />
<c:if test="${empty pageSize}">
	<c:set var="pageSize" value="${maxOrderItemsPerPage}"/>
</c:if>

<c:set var="beginIndex" value="${WCParam.beginIndex}" />
<c:if test="${empty beginIndex}">
	<c:set var="beginIndex" value="0" />
</c:if>  
<wcf:getData type="com.ibm.commerce.order.facade.datatypes.OrderType" scope="request" 
	var="order" expressionBuilder="findCurrentShoppingCartWithPagingOnItem" varShowVerb="ShowVerbCart" maxItems="${pageSize}" recordSetStartNumber="${beginIndex}" recordSetReferenceId="ostatus">
	<wcf:param name="accessProfile" value="IBM_Details" />	 
	<wcf:param name="sortOrderItemBy" value="orderItemID" />
	<wcf:param name="isSummary" value="false" />
</wcf:getData>

<c:if test="${empty order.orderItem && beginIndex >= pageSize}">
	<fmt:formatNumber var="totalPages" value="${(ShowVerbCart.recordSetTotal/pageSize)}"/>		
	<c:if test="${ShowVerbCart.recordSetTotal%pageSize < (pageSize/2)}">
			<fmt:parseNumber var="totalPages" value="${(ShowVerbCart.recordSetTotal+(pageSize/2)-1)/pageSize}"/>
	</c:if>
	<fmt:parseNumber var="totalPages" value="${totalPages}" integerOnly="true"/>
	<c:set var="beginIndex" value="${(totalPages-1)*pageSize}" />
	<wcf:getData type="com.ibm.commerce.order.facade.datatypes.OrderType" scope="request" 
		var="order" expressionBuilder="findCurrentShoppingCartWithPagingOnItem" varShowVerb="ShowVerbCart" maxItems="${pageSize}" recordSetStartNumber="${beginIndex}" recordSetReferenceId="ostatus">
		<wcf:param name="accessProfile" value="IBM_Details" />	 
		<wcf:param name="sortOrderItemBy" value="orderItemID" />
		<wcf:param name="isSummary" value="false" />
	</wcf:getData>
</c:if>

<wcf:url var="currentShoppingCartLink" value="ShopCartPageView" type="Ajax">
	<wcf:param name="storeId"   value="${WCParam.storeId}"  />
	<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
	<wcf:param name="langId" value="${WCParam.langId}" />
</wcf:url>
<script type="text/javascript">
dojo.addOnLoad(
	function(){
		CommonControllersDeclarationJS.setControllerURL('ShopCartPaginationDisplayController','<c:out value="${currentShoppingCartLink}"/>');
		ShipmodeSelectionExtJS.setOrderItemId('${order.orderItem[0].orderItemIdentifier.uniqueID}');
	}
);
</script>
<c:set var="showTax" value="false"/>
<c:set var="showShipping" value="false"/>
<c:choose>
	<c:when test="${empty param.orderId}">        
		<c:choose>
			<c:when test="${!empty WCParam.orderId}">
				<c:set var="orderId" value="${WCParam.noElementToDisplay}" />
			</c:when>
		</c:choose>
	</c:when>
	<c:otherwise>
		<c:set var="orderId" value="${param.orderId}" />
	</c:otherwise>
</c:choose>
    
<div id="content759">
		<div id="box">
		
			<div class="contentgrad_header" id="shopping_cart_product_table_tall">
			<div class="left_corner" id="WC_ShopCartDisplay_div_2"></div>
			<div class="left" id="WC_ShopCartDisplay_div_3"></div>
			<div class="right_corner" id="WC_ShopCartDisplay_div_4"></div>	
	
				<flow:ifEnabled feature="RequisitionList">
					<c:set var="hideSavedOrderCreateButton" value="true"/>
					<c:set var="hideSavedOrderCancelButton" value="true"/>
					<c:set var="hideSavedOrderCopyButton" value="true"/>
					<c:set var="hideSavedOrderSaveButton" value="true"/>
					 <c:if test="${empty order.orderItem }" >
					 	<c:set var="hideSavedOrderAddToReqListButton" value="true"/>
					 </c:if>	
					 			  
					<%@ include file="../../Snippets/ReusableObjects/SavedOrdersToolbar.jspf" %>
				</flow:ifEnabled>
		
		</div>
		   
		<c:choose>
			<c:when test="${!empty order.orderItem }" >
				<div class="body759" id="WC_ShopCartDisplay_div_5">
					<%out.flush();%>
						<c:import url="${jspStoreDir}Snippets/Order/Cart/ShipmodeSelectionExt.jsp"/> 
					<%out.flush();%>
					
					<div dojoType="wc.widget.RefreshArea" widgetId="ShopCartPagingDisplay" id="ShopCartPagingDisplay" controllerId="ShopCartPaginationDisplayController" role="wairole:region" waistate:live="polite" waistate:atomic="false" waistate:relevant="all">
					<%out.flush();%>
					<c:import url="${jspStoreDir}Snippets/Order/Cart/OrderItemDetail.jsp"> 
							<c:param name="catalogId" value="${WCParam.catalogId}" />
							<c:param name="langId" value="${WCParam.langId}" />
							<c:param name="storeId" value="${WCParam.storeId}" />
					</c:import>
					<%out.flush();%>
					</div>
					<script type="text/javascript">
						dojo.addOnLoad(function() { 
							parseWidget("ShopCartPagingDisplay");
							
						});            
					</script>
					
					 <c:if test="${b2bStore}">
					  	<script type="text/javascript">
							dojo.addOnLoad(function() { 
								if (savedOrdersJS != null && savedOrdersJS != 'undefined')
								{
									savedOrdersJS.isCurrentOrderPage(true);
							  		savedOrdersJS.setOrderId('<c:out value="${order.orderIdentifier.uniqueID}"/>');
								}
							});            
						</script>
					</c:if>
					<%out.flush();%>
					     <c:import url="${jspStoreDir}Snippets/Marketing/Promotions/PromotionPickYourFreeGift.jsp"/>
					<%out.flush();%>
					<%out.flush();%>
						<c:import url="${jspStoreDir}ShoppingArea/CheckoutSection/SingleShipment/SingleShipmentOrderTotalsSummary.jsp"> 
							<c:param name="returnView" value="AjaxOrderItemDisplayView"/>
							<c:param name="fromPage" value="shoppingCartDisplay"/>
						</c:import>
					<%out.flush();%>
					 <br clear="all" />
					 <br />
					 <%out.flush();%>
					     <c:import url="${jspStoreDir}Snippets/Order/Cart/CheckoutLogon.jsp"/>
					 <%out.flush();%>
				</div>				
			</c:when>
			<c:otherwise>
				<div class="body759" id="WC_ShopCartDisplay_div_6">
					 <%@ include file="../../Snippets/ReusableObjects/EmptyShopCartDisplay.jspf"%>
				</div>
			</c:otherwise>
		</c:choose>
		
		<div class="footer" id="WC_ShopCartDisplay_div_7">
			<div class="left_corner" id="WC_ShopCartDisplay_div_8"></div>
			<div class="left" id="WC_ShopCartDisplay_div_9"></div>
			<div class="right_corner" id="WC_ShopCartDisplay_div_10"></div>
		</div>
		
	</div>
</div>  					
