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
  * This JSP displays store locator content and allows shopper to select a store to add to the WC_physicalStores
  * cookie. This JSP will then update the shipping mode and address id associated with the order itmes of the 
  * current order once the shopper clicks the next button in the shopping flow.
  *****
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ taglib uri="http://commerce.ibm.com/coremetrics"  prefix="cm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../include/JSTLEnvironmentSetup.jspf" %>
<%@ include file="../../include/nocache.jspf" %>
<%@ include file="../../include/ErrorMessageSetup.jspf" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="${shortLocale}" xml:lang="${shortLocale}">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><fmt:message key="CO_STORE_SELECTION_TITLE" bundle="${storeText}" /></title>
<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${vfileStylesheet}"/>" type="text/css"/>
<!--[if lte IE 6]>
<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${vfileStylesheetie}"/>" type="text/css"/>
<![endif]-->
<script type="text/javascript" src="<c:out value="${dojoFile}"/>" djConfig="${dojoConfigParams}"></script>
<%@ include file="../../include/CommonJSToInclude.jspf"%>
</head>

<c:set var="isAjaxCheckOut" value="true"/>
<%-- Check if its a non-ajax checkout..--%>
<flow:ifDisabled feature="AjaxCheckout"> 
	<c:set var="isAjaxCheckOut" value="false"/>
</flow:ifDisabled>

<wcf:url var="ShoppingCartURL" value="OrderCalculate" type="Ajax">
   <wcf:param name="langId" value="${langId}" />
  <wcf:param name="storeId" value="${WCParam.storeId}" />
  <wcf:param name="catalogId" value="${WCParam.catalogId}" />
  <wcf:param name="URL" value="AjaxOrderItemDisplayView" />
  <wcf:param name="updatePrices" value="1" />
  <wcf:param name="calculationUsageId" value="-1" />
  <wcf:param name="orderId" value="." />
</wcf:url>

<%-- constructs form used by ShipmodeSelectionExtJS --%>
<wcf:getData type="com.ibm.commerce.order.facade.datatypes.OrderType" var="order" expressionBuilder="findCurrentShoppingCart">
	<wcf:param name="accessProfile" value="IBM_Details" />
</wcf:getData>

<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/MessageHelper.js"/>"></script>
<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/StoreLocatorArea/PhysicalStoreCookie.js"/>"></script>
<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/CheckoutArea/ShipmodeSelectionExt.js"/>"></script>

<script type="text/javascript">
	dojo.addOnLoad(function() {
		ShipmodeSelectionExtJS.setCommonParameters('${WCParam.langId}','${WCParam.storeId}','${WCParam.catalogId}');
		ShipmodeSelectionExtJS.setOrderItemId('${order.orderItem[0].orderItemIdentifier.uniqueID}');
		<fmt:message key="ERR_NO_PHY_STORE" bundle="${storeText}" var="ERR_NO_PHY_STORE"/>
		MessageHelper.setMessage("message_NO_STORE", <wcf:json object="${ERR_NO_PHY_STORE}"/>);
	});
</script>

<body>
<%@ include file="../../include/StoreCommonUtilities.jspf"%> 
<!-- Page Start -->
<div id="page">
	<!-- Header Nav Start -->
	<%@ include file="../../include/LayoutContainerTop.jspf"%>
	<!-- Breadcrumb Start -->
	<div id="checkout_crumb">
		<div class="crumb" id="WC_CheckoutStoreSelection_div_1">
			<a href="<c:out value="${ShoppingCartURL}"/>" id="WC_CheckoutStoreSelection_links_1"><span><fmt:message key="BCT_SHOPPING_CART" bundle="${storeText}"/></span></a> | 
			<span class="on"><fmt:message key="BCT_STORE_SELECTION" bundle="${storeText}"/></span> | 
			<span><fmt:message key="BCT_ADDRESS" bundle="${storeText}"/></span> | 
			<span><fmt:message key="BCT_SHIPPING_AND_BILLING" bundle="${storeText}"/></span> | 
			<span><fmt:message key="BCT_ORDER_SUMMARY" bundle="${storeText}"/></span>
		</div>
	</div>
	<!-- Breadcrumb End -->   
  
	<!-- Header Nav End -->
	<div id="MessageArea" >
		<br />
			<span id="ErrorMessageText" class="error_msg">
				<c:if test="${!empty errorMessage}">
					<c:out value="${errorMessage}"/>
				</c:if>
			</span>
		<br /><br />
	</div>
	
	<!-- Main Content Start -->
	<div id="content_wrapper">
		<div id="box">	

			<wcf:getData type="com.ibm.commerce.order.facade.datatypes.OrderType"
					var="usableShippingInfo" expressionBuilder="findUsableShippingInfoWithPagingOnItem" varShowVerb="ShowVerbUsableShippingInfo" maxItems="1" recordSetStartNumber="0" recordSetReferenceId="ostatus">
				<wcf:param name="accessProfile" value="IBM_UsableShippingInfo" /> 
				<wcf:param name="orderId" value="${order.orderIdentifier.uniqueID}" />
				<wcf:param name="sortOrderItemBy" value="orderItemID" />
			</wcf:getData>

			<%out.flush();%>
			<c:import url="${jspStoreDir}Snippets/StoreLocator/StoreLocator.jsp">
				<c:param name="fromPage" value="ShoppingCart" />
				<c:param name="orderId" value="${order.orderIdentifier.uniqueID}" />
			</c:import>
			<%out.flush();%>
	
			<c:set var="orderItemArray" value="${order.orderItem}"/>
			<form id="orderItemStoreSelectionForm" name="orderItemStoreSelectionForm" method="post" action="OrderChangeServiceShipInfoUpdate">
				<input type="hidden" id="storeId" name="storeId" value="${WCParam.storeId}"/>
				<input type="hidden" id="catalogId" name="catalogId" value="${WCParam.catalogId}"/>
				<input type="hidden" id="langId" name="langId" value="${WCParam.langId}"/>
				<input type="hidden" id="fromPage" name="fromPage" value="ShoppingCart"/>
				<input type="hidden" id="orderId" name="orderId" value="${order.orderIdentifier.uniqueID}"/>
				<input type="hidden" id="errorViewName" name="errorViewName" value="CheckoutStoreSelectionView"/>
				<input type="hidden" id="URL" name="URL" value="CheckoutPayInStoreView?orderItemId*=&shipModeId*=&physicalStoreId*="/>
				<input type="hidden" name="calculationUsage" value="-1,-2,-3,-4,-5,-6,-7" id="calcUsage"/>
				
				<c:set var="doneLoop" value="false"/>
				<c:forEach items="${usableShippingInfo.orderItem}" var="curOrderItem">
					<c:if test="${not doneLoop}">
						<c:forEach items="${curOrderItem.usableShippingMode}" var="curShipmode">
							<c:if test="${not doneLoop}">
								<c:if test="${curShipmode.shippingModeIdentifier.externalIdentifier.shipModeCode == 'PickupInStore'}">
									<c:set var="doneLoop" value="true"/>
									<c:set var="bopisShipmodeId" value="${curShipmode.shippingModeIdentifier.uniqueID}"/>
								</c:if>
							</c:if>
						</c:forEach>
					</c:if>
				</c:forEach>
				
				
				<input type="hidden" id="shipModeId" name="shipModeId" value="${bopisShipmodeId}"/>
				<input type="hidden" id="physicalStoreId" name="physicalStoreId" value=""/>
				
			<!-- Store selection footer -->
			<div class="content_footer" id="WC_CheckoutStoreSelection_div_2">
				<div class="left_corner" id="WC_CheckoutStoreSelection_div_3"></div>
				<div class="button_footer_line" id="WC_CheckoutStoreSelection_div_4">
					<div class="left" id="WC_CheckoutStoreSelection_div_5">
						<span class="secondary_button button_fit" >
							<span class="button_container">
								<span class="button_bg">
									<span class="button_top">
										<span class="button_bottom">   
											<a href="<c:out value="${ShoppingCartURL}"/>" id="WC_CheckoutStoreSelection_links_2">
												<fmt:message key="CO_STORE_SELECTION_BACK" bundle="${storeText}"/><span class="spanacce"><fmt:message key="Checkout_ACCE_back_shopping_cart" bundle="${storeText}"/></span>
											</a>
										</span>
									</span>	
								</span>
							</span>
						</span>
					</div>
					<div class="left" id="WC_CheckoutStoreSelection_div_8">
						<span class="primary_button button_fit" >
							<span class="button_container">
								<span class="button_bg">
									<span class="button_top">
										<span class="button_bottom">   
											<a href="javascript:ShipmodeSelectionExtJS.submitStoreSelectionForm(document.orderItemStoreSelectionForm);" id="storeSelection_NextButton" onmouseout="JavaScript: this.blur();" onblur="JavaScript: this.blur();">
												<fmt:message key="CO_STORE_SELECTION_NEXT" bundle="${storeText}"/><span class="spanacce"><fmt:message key="Checkout_ACCE_next_summary" bundle="${storeText}"/></span>
											</a>
										</span>
									</span>	
								</span>
							</span>
						</span>
					</div>
					<div class="button_side_message" id="WC_CheckoutStoreSelection_div_11">
						<fmt:message key="CO_STORE_SELECTION_NEXTSTEP" bundle="${storeText}"/>
					</div>
				</div>
				<div class="right_corner" id="WC_CheckoutStoreSelection_div_12"></div>
			</div>
			</form>
		</div>
  </div>
	<!-- Main Content End -->
   
	<!-- Footer Start -->
	<%@ include file="../../include/LayoutContainerBottom.jspf"%>  
	<!-- Footer End -->
   
</div>
<div id="page_shadow" class="shadow"></div>
	<flow:ifEnabled feature="Analytics">
		<cm:pageview/>
	</flow:ifEnabled>
</body>
</html>

