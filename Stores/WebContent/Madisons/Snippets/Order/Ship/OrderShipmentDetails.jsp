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
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf"%>
<flow:fileRef id="vfileLogo" fileId="vfile.logo"/>
<c:if test='${param.email eq "true"}'>
	<c:set value="${pageContext.request.scheme}://${pageContext.request.serverName}" var="eHostPath" />
	<c:set value="${eHostPath}${jspStoreImgDir}" var="jspStoreImgDir" />
</c:if>

<c:if test='${param.email != "true"}'>
	<script type="text/javascript" src="<c:out value='${jsAssetsDir}javascript/CheckoutArea/CheckoutHelper.js'/>"></script>
	
<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/ServicesDeclaration.js"/>"></script>
	<script type="text/javascript">
		dojo.addOnLoad(function() { 
			ServicesDeclarationJS.setCommonParameters('${WCParam.langId}','${WCParam.storeId}','${WCParam.catalogId}');
		});
	</script>
</c:if>

<c:set var="pageSize" value="${WCParam.pageSize}" />
<c:if test="${empty pageSize}">
	<c:set var="pageSize" value="${maxOrderItemsPerPage}"/>
</c:if>
<fmt:parseNumber var="pageSize" value="${pageSize}"/>
<c:choose>
	<c:when test="${WCParam.orderId != null}">
		<wcf:getData type="com.ibm.commerce.order.facade.datatypes.OrderType" var="order" expressionBuilder="findByOrderIdWithPagingOnItem" maxItems="${pageSize}" recordSetStartNumber="0" varShowVerb="ShowVerbSummary" recordSetReferenceId="confirmstatus" scope="request">
			<wcf:param name="orderId" value="${WCParam.orderId}"/>
			<wcf:param name="accessProfile" value="IBM_Details" />
			<wcf:param name="sortOrderItemBy" value="orderItemID" />
			<wcf:param name="isSummary" value="false" />
		</wcf:getData>
		<c:set var="objectId" value="${order.orderIdentifier.uniqueID}"/>
	</c:when>
	
	<c:when test="${WCParam.externalOrderId != null}">
		<wcf:getData type="com.ibm.commerce.order.facade.datatypes.OrderType" var="order" expressionBuilder="findOrderByExternalOrderID" maxItems="${pageSize}" recordSetStartNumber="0" varShowVerb="ShowVerbSummary" recordSetReferenceId="confirmstatus" scope="request">
			<wcf:param name="orderId" value="${WCParam.externalOrderId}"/>
			<wcf:param name="accessProfile" value="IBM_External_Details" />
			<wcf:param name="sortOrderItemBy" value="orderItemID" />
			<wcf:param name="isSummary" value="false" />
		</wcf:getData>
		<c:set var="objectId" value="${order.orderIdentifier.externalOrderID}"/>
	</c:when>
	
	<c:when test="${WCParam.quoteId != null}">
		<%/* Currently no local implementation available*/%>
	</c:when>
	
	<c:when test="${WCParam.externalQuoteId != null}">
		<wcf:getData type="com.ibm.commerce.order.facade.datatypes.QuoteType" var="quote" expressionBuilder="findQuoteByExternalQuoteID" maxItems="${pageSize}" recordSetStartNumber="0" varShowVerb="ShowVerbSummary" recordSetReferenceId="confirmstatus" scope="request">
			<wcf:param name="quoteId" value="${WCParam.externalQuoteId}"/>
			<wcf:param name="accessProfile" value="IBM_External_Details" />
			<wcf:param name="sortOrderItemBy" value="orderItemID" />
			<wcf:param name="isSummary" value="false" />
		</wcf:getData>
		<c:set var="objectId" value="${quote.quoteIdentifier.externalQuoteID}"/>
		<c:set var="order" value="${quote.orderTemplate}" scope="request"/>
	</c:when>
	<c:otherwise>
	</c:otherwise>
</c:choose>

<c:set var="shipmentTypeId" value="1"/>

<c:choose>
	<c:when test="${ShowVerbSummary.recordSetTotal > maxOrderItemsToInspect}">
		<c:set var="shipmentTypeId" value="2"/>
	</c:when>
	<c:otherwise>
		<jsp:useBean id="blockMap" class="java.util.HashMap" scope="request"/>
		<c:forEach var="orderItem" items="${order.orderItem}" varStatus="status">
			<c:set var = "itemId" value="${orderItem.orderItemIdentifier.uniqueID}"/>
			<c:set var ="addressId" value = "${orderItem.orderItemShippingInfo.shippingAddress.contactInfoIdentifier.uniqueID}"/>
			<c:set var ="shipModeId" value= "${orderItem.orderItemShippingInfo.shippingMode.shippingModeIdentifier.uniqueID}"/>
			<c:set var = "keyVar" value="${addressId}_${shipModeId}"/>
			<c:set var = "itemIds" value="${blockMap[keyVar]}"/>
			<c:choose>
				<c:when test="${empty itemIds}">
					<c:set target="${blockMap}" property="${keyVar}" value="${itemId}"/>
				</c:when>	
				<c:otherwise>
					<c:set target="${blockMap}" property="${keyVar}" value="${itemIds},${itemId}"/>
				</c:otherwise>	
			</c:choose>	
		</c:forEach>
		<c:choose>
			<c:when test = "${fn:length(blockMap) == 1}">
				<c:set var="shipmentTypeId" value="1"/>
			</c:when>
			<c:otherwise>
				<c:set var="shipmentTypeId" value="2"/>
			</c:otherwise>
		</c:choose>
	</c:otherwise>
</c:choose>

				

<%-- Need to reset currencyFormatterDB as initialized in JSTLEnvironmentSetup.jspf, as the currency code used there is from commandContext. For order history we want to display with currency used when the order was placed. --%>
<c:remove var="currencyFormatterDB"/>
<c:choose>
	<c:when test ="${order.orderAmount.grandTotal != null}">
	
<wcbase:useBean id="currencyFormatterDB" classname="com.ibm.commerce.common.beans.StoreCurrencyFormatDescriptionDataBean" scope="request" >
	<c:set property="storeId" value="${storeId}" target="${currencyFormatterDB}" />
	<c:set property="langId" value="${langId}" target="${currencyFormatterDB}" />
	<c:set property="currencyCode" value="${order.orderAmount.grandTotal.currency}" target="${currencyFormatterDB}" />
	<c:set property="numberUsage" value="-1" target="${currencyFormatterDB}" />
</wcbase:useBean>
	
		<c:set var="currencyDecimal" value="${currencyFormatterDB.decimalPlaces}"/>
		<c:if test="${order.orderAmount.grandTotal.currency == 'KRW'}">
			<c:set property="currencySymbol" value="&#8361;" target="${currencyFormatterDB}"/>
		</c:if>
	</c:when>
</c:choose>


<wcf:getData type="com.ibm.commerce.member.facade.datatypes.PersonType" 
		var="person" expressionBuilder="findCurrentPerson">
	<wcf:param name="accessProfile" value="IBM_All" />
</wcf:getData>

<c:set var="personAddresses" value="${person.addressBook}"/>

<c:set var="numberOfPaymentMethods" value="${fn:length(order.orderPaymentInfo.paymentInstruction)}"/>
<div id="orderConfirmationHeader">
	<div id="orderConfirmImage">
		<img src="<c:out value="${storeImgDir}${vfileLogo}" />" alt="<c:out value="${storeName}" />" border="0"/>
	</div>
	<div id="orderConfirmText">
		<fmt:message key="HEADER_ORDER_CONFIRM" bundle="${storeText}" />
	</div>
</div>
<div id="box">
	<div class="my_account" id="WC_OrderShipmentDetails_div_1">
		<div class="main_header" id="WC_OrderShipmentDetails_div_2">
			<div class="left_corner" id="WC_OrderShipmentDetails_div_3"></div>
			<div class="left" id="WC_OrderShipmentDetails_div_4">
				<span class="main_header_text">
					<c:choose>
						<c:when test="${WCParam.isQuote eq true}">
							<fmt:message key="MO_QUOTEDETAILS" bundle="${storeText}"/>
						</c:when>
						<c:otherwise>
							<fmt:message key="MO_ORDERDETAILS" bundle="${storeText}"/>
						</c:otherwise>
					</c:choose>
				</span>
			</div>
			<div class="right_corner" id="WC_OrderShipmentDetails_div_5"></div>
		</div>
		<div class="contentline" id="WC_OrderShipmentDetails_div_36"></div>
		<div class="body" id="WC_OrderShipmentDetails_div_6">
			<div class="order_details_my_account" id="WC_OrderShipmentDetails_div_7">
				<c:if test="${order.orderStatus.status eq 'W'}">
					<c:choose>
						<c:when test="${WCParam.isQuote eq true}">
							<p><strong><fmt:message key="MO_QUOTE_PENDING_APPROVAL_MESSAGE" bundle="${storeText}"/></strong></p>
						</c:when>
						<c:otherwise>
							<p><strong><fmt:message key="MO_ORDER_PENDING_APPROVAL_MESSAGE" bundle="${storeText}"/></strong></p>
						</c:otherwise>
					</c:choose>
				</c:if>
				
				<p>
					<c:choose>
						<c:when test="${WCParam.isQuote eq true}">
							<strong><fmt:message key="MO_QUOTE_NUMBER" bundle="${storeText}"/></strong>
						</c:when>
						<c:otherwise>
							<c:choose>
								<c:when test="${order.orderStatus.status eq 'I'}">
									<strong><fmt:message key="ORD_SCHEDULED_ORDER_NUMBER" bundle="${storeText}"/></strong>
								</c:when>
								<c:otherwise>
									<strong><fmt:message key="MO_ORDER_NUMBER" bundle="${storeText}"/></strong>
								</c:otherwise>
							</c:choose>
						</c:otherwise>
					</c:choose>
					<c:choose>
						<c:when test="${!empty objectId}">
							<c:out value="${objectId}"/>	
						</c:when>
						<c:otherwise>
							<fmt:message key="MO_NOT_AVAILABLE" bundle="${storeText}"/>
						</c:otherwise>
					</c:choose>							
				</p>
				<c:if test="${!(order.orderStatus.status eq 'I' || order.orderStatus.status eq 'W')}">
					<c:choose>
						<c:when test="${WCParam.isQuote eq true}">
							<p><strong><fmt:message key="MO_QUOTE_DATE" bundle="${storeText}"/></strong>
						</c:when>
						<c:otherwise>
							<p><strong><fmt:message key="MO_ORDER_DATE" bundle="${storeText}"/></strong>
						</c:otherwise>
					</c:choose>
					<c:catch>
						<fmt:parseDate var="expectedDate" value="${order.placedDate}" pattern="yyyy-MM-dd'T'HH:mm:ss.SSS'Z'" timeZone="GMT"/>
					</c:catch>
					<c:if test="${empty expectedDate}">
						<c:catch>
							<fmt:parseDate var="expectedDate" value="${order.placedDate}" pattern="yyyy-MM-dd'T'HH:mm:ss'Z'" timeZone="GMT"/>
						</c:catch>
					</c:if>
					<c:choose>
							<c:when test="${!empty expectedDate}">
								<fmt:formatDate value="${expectedDate}" dateStyle="long"/></p>
							</c:when>
							<c:otherwise>
								<fmt:message key="MO_NOT_AVAILABLE" bundle="${storeText}"/>
							</c:otherwise>
					</c:choose>			
					
				</c:if>
				<br/>
			</div>
		</div>

		<div class="main_header" id="WC_OrderShipmentDetails_div_8">
			<div class="left_corner_straight" id="WC_OrderShipmentDetails_div_9"></div>
			<div class="left" id="WC_OrderShipmentDetails_div_10"><span class="main_header_text"><fmt:message key="MO_SHIPPINGINFO" bundle="${storeText}"/></span></div>
			<div class="right_corner_straight" id="WC_OrderShipmentDetails_div_11"></div>
		</div>
		<div class="contentline" id="WC_OrderShipmentDetails_div_12"></div>
		<div class="body" id="WC_OrderShipmentDetails_div_16">
			<div id="shipping">
				<c:choose>
					<c:when test = "${shipmentTypeId == 1}">
						<div class="shipping_address" id="WC_OrderShipmentDetails_div_17">
							<p class="title"><fmt:message key="MO_SHIPPINGADDRESS" bundle="${storeText}"/></p>
					
							<c:set var="contact" value="${order.orderItem[0].orderItemShippingInfo.shippingAddress}" />

							<c:if test="${!empty contact.contactInfoIdentifier.externalIdentifier.contactInfoNickName}">
									<p><c:choose><c:when test="${contact.contactInfoIdentifier.externalIdentifier.contactInfoNickName eq  profileShippingNickname}"><fmt:message key="QC_DEFAULT_SHIPPING" bundle="${storeText}"/></c:when>
									<c:when test="${contact.contactInfoIdentifier.externalIdentifier.contactInfoNickName eq  profileBillingNickname}"><fmt:message key="QC_DEFAULT_BILLING" bundle="${storeText}"/></c:when>
									<c:otherwise>${contact.contactInfoIdentifier.externalIdentifier.contactInfoNickName}</c:otherwise></c:choose></p>
							</c:if>

							<!-- Display shiping address of the order -->
							<%@ include file="../../ReusableObjects/AddressDisplay.jspf"%>
						</div>

						<div class="shipping_method" id="WC_OrderShipmentDetails_div_18">
							<p>
								<span class="title"><fmt:message key="SHIP_SHIP_AS_COMPLETE" bundle="${storeText}"/>: </span>
								<c:choose>
									<c:when test='${order.shipAsComplete}'>
										<span class="text"><fmt:message key="YES" bundle="${storeText}"/></span>
									</c:when>
									<c:otherwise>
										<span class="text"><fmt:message key="NO" bundle="${storeText}"/></span>
									</c:otherwise>
								</c:choose>
							</p>
							<br />
							
							<p class="title"><fmt:message key="MO_SHIPPINGMETHOD" bundle="${storeText}"/></p>
							<p><c:out value="${order.orderItem[0].orderItemShippingInfo.shippingMode.description.value}"/></p>
							<br clear="all"/>
				
							<flow:ifEnabled feature="ShippingChargeType">
								<wcbase:useBean id="shipCharges" classname="com.ibm.commerce.order.beans.UsableShipChargesAndAccountByShipModeDataBean" scope="page">
									<c:set property="orderId" value="${order.orderIdentifier.uniqueID}" 	target="${shipCharges}"  />
								</wcbase:useBean>
								
								<c:if test="${not empty shipCharges.shipChargesByShipMode}">
									<c:forEach items="${shipCharges.shipChargesByShipMode}" var="shipCharges_shipModeData"  varStatus="counter1">
										<c:if test="${shipCharges_shipModeData.shipModeDesc == order.orderItem[0].orderItemShippingInfo.shippingMode.description.value}">
											<c:forEach items="${shipCharges_shipModeData.shippingChargeTypes}" var="shipCharges_data"  varStatus="counter2">
												<c:if test="${shipCharges_data.selected}">
													<p>
														<span class="title"><fmt:message key="ShippingChargeType" bundle="${storeText}"/>:</span>
														<span class="text"><fmt:message key="${shipCharges_data.policyName}" bundle="${storeText}"/></span>
													</p>
													<c:if test="${shipCharges_data.carrAccntNumber != null && shipCharges_data.carrAccntNumber != ''}">
														<p>
															<span class="title"><fmt:message key="ShippingChargeAcctNum" bundle="${storeText}"/>:</span>
															<span class="text"><c:out value="${shipCharges_data.carrAccntNumber}"/></span>
														</p>
													</c:if>
												</c:if>
											</c:forEach>
										</c:if>
									</c:forEach>
								</c:if>
							</flow:ifEnabled>
							
							<c:set var="shipInstructions" value="${order.orderItem[0].orderItemShippingInfo.shippingInstruction}"/>	
							<flow:ifEnabled feature="ShippingInstructions">
								<c:if test="${!empty shipInstructions}">
									<p>
										<span class="title"><fmt:message key="SHIP_SHIPPING_INSTRUCTIONS" bundle="${storeText}" />: </span>
										<span class="text"><c:out value = "${shipInstructions}"/></span>
									</p>
									<br />
								</c:if>
							</flow:ifEnabled>								
						</div>
						
						<%-- Display Single shipment confirmation page --%>
						<c:if test='${param.email != "true"}'>
						<div dojoType="wc.widget.RefreshArea" widgetId="OrderConfirmPagingDisplay" id="OrderConfirmPagingDisplay" 
							controllerId="OrderItemPaginationDisplayController" role="wairole:region" waistate:live="polite" waistate:atomic="false" waistate:relevant="all">
						</c:if>  
							<%out.flush();%>
								<c:import url="${jspStoreDir}ShoppingArea/CheckoutSection/SingleShipment/OrderItemDetailSummary.jsp">  
									<c:param name="catalogId" value="${WCParam.catalogId}" />
									<c:param name="langId" value="${WCParam.langId}" />
									<c:param name="storeId" value="${storeId}"/>
									<c:param name="orderPage" value="confirmation" />
									<c:param name="isFromOrderDetailsPage" value="true" />
								</c:import>
							<%out.flush();%>
						<c:if test='${param.email != "true"}'>
						</div>
						<script type="text/javascript">dojo.addOnLoad(function() { 
							parseWidget("OrderConfirmPagingDisplay");
							});
						</script>
						</c:if>
					</c:when>
					<c:otherwise>
						<div class="shipping_method" id="WC_OrderShipmentDetails_div_35">
							<p>
								<span class="title"><fmt:message key="SHIP_SHIP_AS_COMPLETE" bundle="${storeText}"/>: </span>
									<c:if test='${order.shipAsComplete}'>
										<span class="text"><fmt:message key="YES" bundle="${storeText}"/></span>
									</c:if>
									<c:if test='${!order.shipAsComplete}'>
										<span class="text"><fmt:message key="NO" bundle="${storeText}"/></span>
									</c:if>
							</p>
						</div>
						<%-- Display Multiple shipment confirmation page --%>
						<c:if test='${param.email != "true"}'>
						<div dojoType="wc.widget.RefreshArea" widgetId="MSOrderConfirmPagingDisplay" id="MSOrderDetailPagingDisplay" 
							controllerId="MSOrderItemPaginationDisplayController" role="wairole:region" waistate:live="polite" waistate:atomic="false" waistate:relevant="all">
						</c:if>
							<%out.flush();%>
								<c:import url="${jspStoreDir}ShoppingArea/CheckoutSection/MultipleShipment/MSOrderItemDetailSummary.jsp">  
									<c:param name="catalogId" value="${WCParam.catalogId}" />
									<c:param name="langId" value="${WCParam.langId}" />
									<c:param name="storeId" value="${storeId}"/>
									<c:param name="orderPage" value="confirmation" />
								</c:import>
							<%out.flush();%>
						<c:if test='${param.email != "true"}'>
						</div>	
						<script type="text/javascript">dojo.addOnLoad(function() { 
							parseWidget("MSOrderDetailPagingDisplay");
							});
						</script>	
					</c:if>
					</c:otherwise>
				</c:choose>
				<div id="total_breakdown">
					<div class="figures" id="WC_OrderShipmentDetails_div_19">
						<p class="price">
							
						<c:choose>
							<c:when test="${!empty order.orderAmount.totalProductPrice.value}">
								<fmt:formatNumber value="${order.orderAmount.totalProductPrice.value}" type="currency" maxFractionDigits="${currencyDecimal}" currencySymbol="${currencyFormatterDB.currencySymbol}"/>
								</c:when>
							<c:otherwise>
								<fmt:message key="MO_NOT_AVAILABLE" bundle="${storeText}"/>
							</c:otherwise>
						</c:choose>	
							
						</p>
						<p class="price">
						<c:choose>
							<c:when test="${!empty order.orderAmount.totalAdjustment.value}">
								<fmt:formatNumber value="${order.orderAmount.totalAdjustment.value}" type="currency" maxFractionDigits="${currencyDecimal}" currencySymbol="${currencyFormatterDB.currencySymbol}"/>
								</c:when>
							<c:otherwise>
								<fmt:message key="MO_NOT_AVAILABLE" bundle="${storeText}"/>
							</c:otherwise>
						</c:choose>	
						
						</p>
						<p class="price">
							<c:choose>
							<c:when test="${!empty order.orderAmount.totalSalesTax.value}">
								<fmt:formatNumber value="${order.orderAmount.totalSalesTax.value}" type="currency" maxFractionDigits="${currencyDecimal}" currencySymbol="${currencyFormatterDB.currencySymbol}"/>
								</c:when>
							<c:otherwise>
								<fmt:message key="MO_NOT_AVAILABLE" bundle="${storeText}"/>
							</c:otherwise>
						</c:choose>
						
						</p>
						<p class="price">
						<c:choose>
							<c:when test="${!empty order.orderAmount.totalShippingCharge.value}">
								<fmt:formatNumber value="${order.orderAmount.totalShippingCharge.value}" type="currency" maxFractionDigits="${currencyDecimal}" currencySymbol="${currencyFormatterDB.currencySymbol}"/>
								</c:when>
							<c:otherwise>
								<fmt:message key="MO_NOT_AVAILABLE" bundle="${storeText}"/>
							</c:otherwise>
						</c:choose>				
						</p>
						<p class="price">
						<c:choose>
							<c:when test="${!empty order.orderAmount.totalShippingTax.value}">
								<fmt:formatNumber value="${order.orderAmount.totalShippingTax.value}" type="currency" maxFractionDigits="${currencyDecimal}" currencySymbol="${currencyFormatterDB.currencySymbol}"/>
								</c:when>
							<c:otherwise>
								<fmt:message key="MO_NOT_AVAILABLE" bundle="${storeText}"/>
							</c:otherwise>
						</c:choose>						
						</p>
						<p class="order_total">
							<p class="price strong_content">
							<c:choose>
					    <c:when test="${order.orderAmount.grandTotal != null}">
								<c:choose>
								<c:when test="${!empty order.orderAmount.grandTotal.value}">
									<fmt:formatNumber value="${order.orderAmount.grandTotal.value}" type="currency" maxFractionDigits="${currencyDecimal}" currencySymbol="${currencyFormatterDB.currencySymbol}"/>
								</c:when>
								<c:otherwise>
									<fmt:message key="MO_NOT_AVAILABLE" bundle="${storeText}"/>
								</c:otherwise>
						    </c:choose>									
						</c:when>
						<c:otherwise>
							<fmt:message key="MO_NOT_AVAILABLE" bundle="${storeText}"/>					
						</c:otherwise>
						</c:choose>
							</p>
						</p>     
					</div>
					<div class="details" id="WC_OrderShipmentDetails_div_20">
						<p><fmt:message key="MO_ORDERSUBTOTAL" bundle="${storeText}"/></p>
						<p><fmt:message key="MO_DISCOUNTADJ" bundle="${storeText}"/></p>
						<p><fmt:message key="MO_TAX" bundle="${storeText}"/></p>
						<p><fmt:message key="MO_SHIPPING" bundle="${storeText}"/></p>
						<p><fmt:message key="MO_SHIPPING_TAX" bundle="${storeText}"/></p>
						<p class="order_total"><fmt:message key="MO_ORDERTOTAL" bundle="${storeText}"/></p>
					</div>
				</div>
			</div>
			<br clear="all" />
		</div>
		
		<flow:ifEnabled feature="ScheduleOrder">
			<c:if test="${WCParam.isQuote != true}">
				<%out.flush();%>
					<c:import url="${jspStoreDir}ShoppingArea/CheckoutSection/ScheduleOrderDisplayExt.jsp">
						<c:param value="false" name="isShippingBillingPage"/>
						<c:param value="${order.orderIdentifier.uniqueID}" name="orderId"/>
					</c:import>
				<%out.flush();%>
			</c:if>
		</flow:ifEnabled>
			
		<div class="main_header" id="WC_OrderShipmentDetails_div_21">
			<div class="left_corner_straight" id="WC_OrderShipmentDetails_div_22"></div>
			<div class="left" id="WC_OrderShipmentDetails_div_23"><span class="main_header_text"><fmt:message key="MO_BILLINGINFO" bundle="${storeText}"/></span></div>
			<div class="right_corner_straight" id="WC_OrderShipmentDetails_div_24"></div>
		</div>

		<div class="contentline" id="WC_OrderShipmentDetails_div_25"></div>
		<%@ include file="../../../ShoppingArea/CheckoutSection/CheckoutPaymentAndBillingAddressSummary.jspf" %>

		<div class="content_footer" id="WC_OrderShipmentDetails_div_29">
			<div class="left_corner" id="WC_OrderShipmentDetails_div_30"></div>
			<div class="button_footer_line" id="WC_OrderShipmentDetails_div_31">
				<div class="left" id="WC_OrderShipmentDetails_div_31_1">
					<span class="primary_button button_fit" >
						<span class="button_container">
							<span class="button_bg">
								<span class="button_top">
									<span class="button_bottom">   
										<a href="JavaScript: print();" id="WC_OrderDetailDisplay_Print_Link" >
											<fmt:message key="PRINT" bundle="${storeText}"/>
										</a>
									</span>
								</span>
							</span>	
						</span>
					</span>	
				</div>
				
				<div class="button_side_message" id="WC_OrderShipmentDetails_div_32_1">
					<fmt:message key="PRINT_RECOMMEND" bundle="${storeText}"/>
				</div>
			</div>
			
			<div class="right_corner" id="WC_OrderShipmentDetails_div_34"></div>
		</div>
	</div>
<!-- Content End -->
</div>

