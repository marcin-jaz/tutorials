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
  * This JSP file renders the multiple shipment order summary page of the checkout flow. It is a read only page.
  *****
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ taglib uri="http://commerce.ibm.com/coremetrics"  prefix="cm" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf"%>
<%@ include file="../../../include/nocache.jspf"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="${shortLocale}" xml:lang="${shortLocale}">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		
		<title><c:out value="${storeName}"/> - <fmt:message key="TITLE_ORDER_SUMMARY" bundle="${storeText}"/></title>
		<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${vfileStylesheet}"/>" type="text/css"/>
		<!--[if lte IE 6]>
		<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${vfileStylesheetie}"/>" type="text/css"/>
		<![endif]-->
		
		<script type="text/javascript" src="<c:out value="${dojoFile}"/>" djConfig="${dojoConfigParams}"></script>
		<%@ include file="../../../include/CommonJSToInclude.jspf"%>
		<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/ServicesEventMapping.js"/>"></script>
		<script type="text/javascript" src="<c:out value='${jsAssetsDir}javascript/CheckoutArea/CheckoutHelper.js'/>"></script>
		<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/MessageHelper.js"/>"></script>
		<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/ServicesDeclaration.js"/>"></script>
		<script type="text/javascript">
			dojo.addOnLoad(function() { 
				ServicesDeclarationJS.setCommonParameters('<c:out value='${WCParam.langId}'/>','<c:out value='${WCParam.storeId}'/>','<c:out value='${WCParam.catalogId}'/>');
				CheckoutHelperJS.initializeShipmentPage('2');
				
				<fmt:message key="PO_Number" bundle="${storeText}" var="PO_Number"/>
				<fmt:message key="ERROR_PONumberEmpty" bundle="${storeText}" var="ERROR_PONumberEmpty"/>
				<fmt:message key="ERROR_PONumberTooLong" bundle="${storeText}" var="ERROR_PONumberTooLong"/>
				
				MessageHelper.setMessage("PO_NUMBER", <wcf:json object="${PO_Number}"/>);
				MessageHelper.setMessage("ERROR_PONumberEmpty", <wcf:json object="${ERROR_PONumberEmpty}"/>);
				MessageHelper.setMessage("ERROR_PONumberTooLong", <wcf:json object="${ERROR_PONumberTooLong}"/>);
			});
		</script>

		<c:set var="pageSize" value="${WCParam.pageSize}" />
		<c:if test="${empty pageSize}">
			<c:set var="pageSize" value="${maxOrderItemsPerPage}"/>
		</c:if>
			
		<%-- Index to begin the order item paging with --%>
		<c:set var="beginIndex" value="${WCParam.beginIndex}" />
		<c:if test="${empty beginIndex}">
			<c:set var="beginIndex" value="0" />
		</c:if> 		
		
		<wcf:getData type="com.ibm.commerce.order.facade.datatypes.OrderType"
		var="order" expressionBuilder="findCurrentShoppingCartWithPagingOnItem" varShowVerb = "ShowVerbSummary" maxItems="${pageSize}" recordSetStartNumber="${beginIndex}" recordSetReferenceId="summarystatus" scope="request">
			<wcf:param name="accessProfile" value="IBM_Details" />
			<wcf:param name="sortOrderItemBy" value="orderItemID" />
			<wcf:param name="isSummary" value="false" />
		</wcf:getData>
		
		<c:if test="${beginIndex == 0}">
			<c:if test="${ShowVerbSummary.recordSetTotal > ShowVerbSummary.recordSetCount}">		
				<c:set var="pageSize" value="${ShowVerbSummary.recordSetCount}" />
			</c:if>
		</c:if>
		
		<wcf:getData type="com.ibm.commerce.member.facade.datatypes.PersonType" var="person" expressionBuilder="findCurrentPerson">
			<wcf:param name="accessProfile" value="IBM_All" />
		</wcf:getData>
		
		<c:set var="personAddresses" value="${person.addressBook}"/>
		
		<c:set var="numberOfPaymentMethods" value="${fn:length(order.orderPaymentInfo.paymentInstruction)}"/>
		
		<wcf:url var="ShoppingCartURL" value="AjaxCheckoutDisplayView" type="Ajax">
			<wcf:param name="langId" value="${langId}" />						
			<wcf:param name="storeId" value="${WCParam.storeId}" />
			<wcf:param name="catalogId" value="${WCParam.catalogId}" />
		</wcf:url>
		
		<wcf:url var="AddressURL" value="AjaxUnregisteredCheckoutAddressForm" type="Ajax">
			<wcf:param name="langId" value="${langId}" />						
			<wcf:param name="storeId" value="${WCParam.storeId}" />
			<wcf:param name="catalogId" value="${WCParam.catalogId}" />
		</wcf:url>
		
		<wcf:url var="ShippingAndBillingURL" value="OrderShippingBillingView" type="Ajax">
			<wcf:param name="langId" value="${langId}" />						
			<wcf:param name="storeId" value="${WCParam.storeId}" />
			<wcf:param name="catalogId" value="${WCParam.catalogId}" />
			<wcf:param name="forceShipmentType" value="2" />
			<wcf:param name="purchaseorder_id" value="${WCParam.purchaseorder_id}"/>
		</wcf:url>
		
		<wcf:url var="TopCategoriesDisplayURL" value="TopCategories1">
			<wcf:param name="langId" value="${langId}" />
			<wcf:param name="storeId" value="${WCParam.storeId}" />
			<wcf:param name="catalogId" value="${WCParam.catalogId}" />
		</wcf:url>
		
		<wcf:url var="TraditionalShippingURL" value="OrderShippingBillingView" type="Ajax">
			<wcf:param name="langId" value="${langId}" />						
			<wcf:param name="storeId" value="${WCParam.storeId}" />
			<wcf:param name="catalogId" value="${WCParam.catalogId}" />
			<wcf:param name="forceShipmentType" value="2" />
		</wcf:url>

		<wcf:url var="TraditionalBillingURL" value="OrderBillingView" type="Ajax">
			<wcf:param name="langId" value="${langId}" />						
			<wcf:param name="storeId" value="${WCParam.storeId}" />
			<wcf:param name="catalogId" value="${WCParam.catalogId}" />
			<wcf:param name="forceShipmentType" value="2" />
			<c:if test="${WCParam.purchaseorder_id != null}">
				<wcf:param name="purchaseorder_id" value="${WCParam.purchaseorder_id}"/>
			</c:if>
		</wcf:url>

		<c:set var="shipInstructions" value="${order.orderItem[0].orderItemShippingInfo.shippingInstruction}"/>
		<c:set var="requestedShipDate" value="${order.orderItem[0].orderItemShippingInfo.requestedShipDate}"/>
		
		<c:if test='${!empty requestedShipDate}'>
			<c:catch>
				<fmt:parseDate var="expectedShipDate" value="${requestedShipDate}" pattern="yyyy-MM-dd'T'HH:mm:ss.SSS'Z'" timeZone="GMT"/>
			</c:catch>
			<c:if test="${empty expectedShipDate}">
				<c:catch>
					<fmt:parseDate var="expectedShipDate" value="${requestedShipDate}" pattern="yyyy-MM-dd'T'HH:mm:ss'Z'" timeZone="GMT"/>
				</c:catch>
			</c:if>
			
			<%-- Format the timezone retrieved from cookie since it is in decimal representation --%>
			<%-- Convert the decimals back to the correct timezone format such as :30 and :45 --%>
			<%-- Only .75 and .5 are converted as currently these are the only timezones with decimals --%>				
			<c:set var="formattedTimeZone" value="${fn:replace(cookie.WC_timeoffset.value, '%2B', '+')}"/>
			<c:set var="formattedTimeZone" value="${fn:replace(formattedTimeZone, '.75', ':45')}"/>	
			<c:set var="formattedTimeZone" value="${fn:replace(formattedTimeZone, '.5', ':30')}"/>			
			<fmt:formatDate value="${expectedShipDate}" type="date" dateStyle="long" var="formattedDate" timeZone="${formattedTimeZone}"/>						
		</c:if>
		
		<c:set var="isOrderScheduled" value="false" scope="request"/>
		<flow:ifEnabled feature="ScheduleOrder">
			<c:set var="orderId" value="${order.orderIdentifier.uniqueID}"/>							
			<c:set var="key" value="WC_ScheduleOrder_${orderId}_interval"/>
			<c:set var="interval" value="${cookie[key].value}"/>							
			<c:set var="key" value="WC_ScheduleOrder_${orderId}_strStartDate"/>
			<c:set var="strStartDate" value="${cookie[key].value}"/>
			
			<c:if test="${interval != null && strStartDate != null}">
				<c:set var="isOrderScheduled" value="true" scope="request"/>
			</c:if>
		</flow:ifEnabled>
	</head>
	<body>
		<%@ include file="../../../include/StoreCommonUtilities.jspf"%>
		<%-- Page Start --%>
		<div id="page">
			<%@ include file="../../../include/LayoutContainerTop.jspf"%>
		
			<!-- Breadcrumb Start -->
			<div id="checkout_crumb">				
				<div class="crumb" id="WC_MultipleShipmentSummary_div_4">
					<a href="<c:out value="${ShoppingCartURL}"/>" id="WC_MultipleShipmentSummary_link_2"><span><fmt:message key="BCT_SHOPPING_CART" bundle="${storeText}"/></span></a> | 
					<flow:ifEnabled feature="SharedShippingBillingPage">
					<a href="<c:out value="${ShippingAndBillingURL}"/>" id="WC_MultipleShipmentSummary_link_3"> <span><fmt:message key="BCT_SHIPPING_AND_BILLING" bundle="${storeText}"/></span></a> | 
					</flow:ifEnabled>

					<flow:ifDisabled feature="SharedShippingBillingPage">
						<a href="<c:out value="${TraditionalShippingURL}"/>" id="WC_SingleShipmentSummary_links_3a"> <span><fmt:message key="BCT_SHIPPING" bundle="${storeText}"/></span></a> | <a href="<c:out value="${TraditionalBillingURL}"/>" id="WC_SingleShipmentSummary_links_3b"> <span><fmt:message key="BCT_BILLING" bundle="${storeText}"/></span></a> | 
					</flow:ifDisabled>
					<span class="on"><fmt:message key="BCT_ORDER_SUMMARY" bundle="${storeText}"/></span>
				</div>
			</div>
			<!-- Breadcrumb End -->
		
			<div id="MessageArea" >
				<br />
				<span id="ErrorMessageText" class="error_msg">			
				</span>
				<br /><br /> 
			</div>
		
			<!-- Main Content Start -->
			<div id="content_wrapper">
			<!--Left Nav Start -->
			<!--Left Nav End -->
			<!-- Right Nav Start -->
			<!-- Right Nav End -->
				<!-- Content Start -->
				<div id="box">
					<div class="main_header" id="WC_MultipleShipmentSummary_div_5">
						<div class="left_corner" id="WC_MultipleShipmentSummary_div_6"></div>
						<div class="left" id="WC_MultipleShipmentSummary_div_7"><span class="main_header_text"><fmt:message key="BCT_SHIPPING_INFO" bundle="${storeText}"/></span></div>
						<div class="right_corner" id="WC_MultipleShipmentSummary_div_8"></div>
					</div>
					<div class="contentline" id="WC_MultipleShipmentSummary_div_9"></div>
					<div class="body" id="WC_MultipleShipmentSummary_div_13">
						<div id="shipping">
							<div class="shipping_method" id="WC_MultipleShipmentSummary_div_14">
								<p>
									<span class="title"><fmt:message key="SHIP_SHIP_AS_COMPLETE" bundle="${storeText}"/>:</span>
									<c:if test='${order.shipAsComplete}'>
										<span class="text"><fmt:message key="YES" bundle="${storeText}"/></span>
									</c:if>
									<c:if test='${!order.shipAsComplete}'>
										<span class="text"><fmt:message key="NO" bundle="${storeText}"/></span>
									</c:if>
								</p>
							</div>
		
							<%-- Declare the refresh area for the order items table and bind it to the paging controller --%>
							<div dojoType="wc.widget.RefreshArea" widgetId="MSOrderItemPagingDisplay" id="MSOrderItemPagingDisplay" controllerId="MSOrderItemPaginationDisplayController" role="wairole:region" waistate:live="polite" waistate:atomic="false" waistate:relevant="all">
								<%out.flush();%>
									<c:import url="${jspStoreDir}ShoppingArea/CheckoutSection/MultipleShipment/MSOrderItemDetailSummary.jsp"> 
										<c:param name="catalogId" value="${WCParam.catalogId}" />
										<c:param name="langId" value="${WCParam.langId}" />
										<c:param name="storeId" value="${WCParam.storeId}" />
										<c:param name="orderPage" value="summary" />
									</c:import>
								<%out.flush();%>
							</div>
							<script type="text/javascript">dojo.addOnLoad(function() { 
							parseWidget("MSOrderItemPagingDisplay"); 
							});</script>
		
							<%out.flush();%>
								<c:import url="${jspStoreDir}ShoppingArea/CheckoutSection/SingleShipment/SingleShipmentOrderTotalsSummary.jsp"> 
									<c:param name="fromPage" value="orderSummaryPage"/>
								</c:import>
							<%out.flush();%>
						</div>
						<br clear="all" />
					</div>
					
					<flow:ifEnabled feature="ScheduleOrder">
						<%out.flush();%>
							<c:import url="${jspStoreDir}ShoppingArea/CheckoutSection/ScheduleOrderDisplayExt.jsp">
								<c:param value="false" name="isShippingBillingPage"/>
								<c:param value="${order.orderIdentifier.uniqueID}" name="orderId"/>
							</c:import>
						<%out.flush();%>
					</flow:ifEnabled>
					
					<div class="main_header" id="WC_MultipleShipmentSummary_div_20">
						<div class="left_corner_straight" id="WC_MultipleShipmentSummary_div_21"></div>
						<div class="left" id="WC_MultipleShipmentSummary_div_22"><span class="main_header_text"><fmt:message key="BILL_BILLING_INFO" bundle="${storeText}"/></span></div>
						<div class="right_corner_straight" id="WC_MultipleShipmentSummary_div_23"></div>
					</div>
			
					<div class="contentline" id="WC_MultipleShipmentSummary_div_24"></div>
			
					<c:set var="PurchaseOrderEntryField" value="true"/>
					<c:if test="${!empty order}">
						<%@ include file="../CheckoutPaymentAndBillingAddressSummary.jspf" %>
					</c:if>
			
					<div class="content_footer" id="WC_MultipleShipmentSummary_div_28">
						<div class="left_corner" id="WC_MultipleShipmentSummary_div_29"></div>
						<div class="button_footer_line" id="WC_MultipleShipmentSummary_div_30">
							<div class="left" id="WC_MultipleShipmentSummary_div_30_1">
								<span class="secondary_button button_fit" >
									<span class="button_container">
										<span class="button_bg">
											<span class="button_top">
												<span class="button_bottom">   
												<flow:ifEnabled feature="SharedShippingBillingPage">
													<a href="<c:out value='${ShippingAndBillingURL}'/>" id="WC_MultipleShipmentSummary_link_4">
														<fmt:message key="BACK" bundle="${storeText}"/><span class="spanacce"><fmt:message key="Checkout_ACCE_back_ship_bill" bundle="${storeText}"/></span>
													</a>
												</flow:ifEnabled>
												<flow:ifDisabled feature="SharedShippingBillingPage">
													<a href="<c:out value='${TraditionalBillingURL}'/>" id="WC_MultipleShipmentSummary_link_4a">
														<fmt:message key="BACK" bundle="${storeText}"/><span class="spanacce"><fmt:message key="Checkout_ACCE_back_ship_bill" bundle="${storeText}"/></span>
													</a>
												</flow:ifDisabled>
												</span>
											</span>	
										</span>
									</span>
								</span>	
							</div>
							
							<c:choose>
								<c:when test="${isOrderScheduled}">
									<div class="left" id="WC_SingleShipmentSummary_div_31_3">
										<span class="primary_button button_fit" >
											<span class="button_container">
												<span class="button_bg">
													<span class="button_top">
														<span class="button_bottom">   
															<a id = "singleOrderSummary" href="javascript:setCurrentId('singleOrderSummary'); CheckoutHelperJS.scheduleOrder(<c:out value="${order.orderIdentifier.uniqueID}"/>)">
																<fmt:message key="SCHEDULE_ORDER_HEADER" bundle="${storeText}"/>
															</a>
														</span>
													</span>	
												</span>
											</span>
										</span>	
									</div>
								</c:when>
								<c:otherwise>
									<div class="left" id="WC_MultipleShipmentSummary_div_30_2">
										<span class="primary_button button_fit">
											<span class="button_container">
												<span class="button_bg">
													<span class="button_top">
														<span class="button_bottom">   
															<a href="javascript:setCurrentId('WC_MultipleShipmentSummary_link_5'); CheckoutHelperJS.checkoutOrder(<c:out value="${order.orderIdentifier.uniqueID}"/>,'<c:out value='${userType}'/>','<c:out value='${addressListForMailNotification}'/>')" id="WC_MultipleShipmentSummary_link_5">
																<fmt:message key="ORDER" bundle="${storeText}"/>
															</a>
														</span>
													</span>	
												</span>
											</span>
										</span>	
									</div>
									<flow:ifEnabled feature="EnableQuotes">
										<div class="left" id="WC_MultipleShipmentSummary_div_30_4">
											<span class="primary_button button_fit">
												<span class="button_container">
													<span class="button_bg">
														<span class="button_top">
															<span class="button_bottom">   
																<a href="javascript:setCurrentId('WC_MultipleShipmentSummary_link_6'); CheckoutHelperJS.checkoutOrder(<c:out value="${order.orderIdentifier.uniqueID}"/>,'<c:out value='${userType}'/>','<c:out value='${addressListForMailNotification}'/>', true)" id="WC_MultipleShipmentSummary_link_6">
																	<fmt:message key="CREATE_QUOTE" bundle="${storeText}"/>
																</a>
															</span>
														</span>	
													</span>
												</span>
											</span>	
										</div>
									</flow:ifEnabled>
								</c:otherwise>
							</c:choose>
							<%@ include file="MultipleShipmentSummaryEIExt.jspf" %>
						</div>
						<div class="right_corner" id="WC_MultipleShipmentSummary_div_35"></div>
					</div>
				</div>
			<!-- Content End -->
			</div>
			
			<!-- Main Content End -->
			<%@ include file="../../../include/LayoutContainerBottom.jspf"%> 
		</div>
		<div id="page_shadow" class="shadow"></div>
<flow:ifEnabled feature="Analytics"><cm:pageview/></flow:ifEnabled>
	</body>
</html>
