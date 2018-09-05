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
  * This JSP file is used to render the order confirmation page to the shopper right after successfully processing
  * an order. It renders a page that can be printed off by the shopper as a reference.
  *****
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://commerce.ibm.com/coremetrics"  prefix="cm" %>
<%@ include file="../../include/JSTLEnvironmentSetup.jspf"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="${shortLocale}" xml:lang="${shortLocale}">
       <head>
              <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
              <c:choose>
              	<c:when test="${WCParam.isQuote eq true}">
	              <title><c:out value="${storeName}"/> - <fmt:message key="TITLE_QUOTE_CONFIRMATION" bundle="${storeText}"/></title>
              	</c:when>
              	<c:otherwise>
	              <title><c:out value="${storeName}"/> - <fmt:message key="TITLE_ORDER_CONFIRMATION" bundle="${storeText}"/></title>
              	</c:otherwise>
              </c:choose>
              <link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${vfileStylesheet}"/>" type="text/css"/>
		<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${vfileStylesheetprint}"/>" type="text/css" media="print"/>
              <!--[if lte IE 6]>
              <link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${vfileStylesheetie}"/>" type="text/css"/>
              <![endif]-->              
              <script type="text/javascript" src="<c:out value="${dojoFile}"/>" djConfig="${dojoConfigParams}"></script>
              <script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/MessageHelper.js"/>"></script>
              <%@ include file="../../include/CommonJSToInclude.jspf"%>
              <script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/CheckoutArea/CheckoutHelper.js"/>"></script>
       </head>
       <body>
              <%@ include file="../../include/StoreCommonUtilities.jspf"%>
              <!-- Page Start -->
              <div id="page">
                     <%@ include file="../../include/LayoutContainerTop.jspf"%>
                     <!-- Breadcrumb Start -->
                     <div id="checkout_crumb">

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
			var="order" expressionBuilder="findByOrderIdWithPagingOnItem" varShowVerb = "ShowVerbSummary" maxItems="${pageSize}" recordSetStartNumber="${beginIndex}" recordSetReferenceId="confirmstatus" scope="request">
				<wcf:param name="orderId" value="${WCParam.orderId}"/>
				<wcf:param name="accessProfile" value="IBM_Details" />
				<wcf:param name="sortOrderItemBy" value="orderItemID" />
				<wcf:param name="isSummary" value="false" />
			</wcf:getData>
			
			<c:if test="${beginIndex == 0}">
				<c:if test="${ShowVerbSummary.recordSetTotal > ShowVerbSummary.recordSetCount}">		
					<c:set var="pageSize" value="${ShowVerbSummary.recordSetCount}" />
				</c:if>
			</c:if>	
			
			<c:set var="shipmentTypeId" value="${WCParam.shipmentTypeId}"/>
			
			<wcf:getData type="com.ibm.commerce.member.facade.datatypes.PersonType" var="person" expressionBuilder="findCurrentPerson">
                                   <wcf:param name="accessProfile" value="IBM_All" />
                            </wcf:getData>
                            
                            <c:set var="personAddresses" value="${person.addressBook}"/>
                            <c:set var="numberOfPaymentMethods" value="${fn:length(order.orderPaymentInfo.paymentInstruction)}"/>
                            
                            <wcf:url var="TopCategoriesDisplayURL" value="TopCategories1">
                                   <wcf:param name="langId" value="${langId}" />
                                   <wcf:param name="storeId" value="${WCParam.storeId}" />
                                   <wcf:param name="catalogId" value="${WCParam.catalogId}" />
                            </wcf:url>
                            <div class="continue_shopping" id=" WC_OrderShippingBillingConfirmationPage_div_1">
                            	<span class="secondary_button button_fit">
									<span class="button_container">
										<span class="button_bg">
											<span class="button_top">
												<span class="button_bottom">   
													<a href="<c:out value="${TopCategoriesDisplayURL}"/>" id=" WC_OrderShippingBillingConfirmationPage_links_1"><fmt:message key="CONTINUE_SHOPPING" bundle="${storeText}"/></a>
	                    						</span>
											</span>	
										</span>
									</span>
								</span>	
                            </div>
                            <div class="crumb" id=" WC_OrderShippingBillingConfirmationPage_div_4">
                            <c:set var="ordStatus" value="${order.orderStatus.status}"/>                            
                                   <c:choose>
                                   		<c:when test="${ordStatus eq 'L'}">
																				<h1 class="breadcrumb_current"><fmt:message key="ORD_THANKS_MESSAGE_LESS_INV" bundle="${storeText}"/></h1>				
                                   		</c:when>                                   
                                   		<c:when test="${ordStatus eq 'W'}">
                                   			<h1 class="breadcrumb_current"><fmt:message key="ORD_ORDER_PENDING_APPROVAL_MESSAGE" bundle="${storeText}"/></h1>				
                                   		</c:when>
                                   		<c:when test="${ordStatus eq 'I'}">
                                   			<h1 class="breadcrumb_current"><fmt:message key="ORD_ORDER_SCHEDULED_MESSAGE" bundle="${storeText}"/></h1>
                                   		</c:when>
                                   		<c:otherwise>
							              <c:choose>
							              	<c:when test="${WCParam.isQuote eq true}">
	      										<h1 class="breadcrumb_current"><fmt:message key="ORD_THANKS_MESSAGE_QUOTE" bundle="${storeText}"/></h1>
	      										<p><fmt:message key="ORD_CONFIRMATION_MESSAGE_QUOTE" bundle="${storeText}"/></p>
							              	</c:when>
							              	<c:otherwise>
	      										<h1 class="breadcrumb_current"><fmt:message key="ORD_THANKS_MESSAGE" bundle="${storeText}"/></h1>
	      										<p><fmt:message key="ORD_CONFIRMATION_MESSAGE" bundle="${storeText}"/></p>
							              	</c:otherwise>
							              </c:choose>
                                   		</c:otherwise>                     
                               		</c:choose>
					              <c:choose>
					              	<c:when test="${WCParam.isQuote eq true}">
					              		<c:choose>
							              	<c:when test="${WCParam.externalQuoteId != null}">
							              		<c:choose>
							              			<c:when test="${WCParam.externalQuoteId eq \"\" }"><fmt:message var="objectId" key="ORD_MESSAGE_QUOTENUMBER_UNAVAILABLE" bundle="${storeText}"/></c:when>
							              			<c:otherwise><c:set var="objectId" value="${WCParam.externalQuoteId}"/></c:otherwise>
							              		</c:choose>
							              	</c:when>
							              	<c:otherwise>
							              		<c:set var="objectId" value="${WCParam.quoteId}"/>
							              	</c:otherwise>
					              		</c:choose>
	                                   <p><strong><fmt:message key="ORD_QUOTE_NUMBER" bundle="${storeText}"/></strong>: <span id="WC_OrderShippingBillingConfirmationPage_span_1"><c:out value="${objectId}"/></span></p>
					              	</c:when>
					              	<c:otherwise>
					              		<c:choose>
							              	<c:when test="${order.orderIdentifier.externalOrderID != null}">
							              		<c:choose>
							              			<c:when test="${order.orderIdentifier.externalOrderID eq \"\" }"><fmt:message var="objectId" key="ORD_MESSAGE_ORDERNUMBER_UNAVAILABLE" bundle="${storeText}"/></c:when>
							              			<c:otherwise><c:set var="objectId" value="${order.orderIdentifier.externalOrderID}"/></c:otherwise>
							              		</c:choose>
							              	</c:when>
							              	<c:otherwise>
							              		<c:set var="objectId" value="${order.orderIdentifier.uniqueID}"/>
							              	</c:otherwise>
					              		</c:choose>
					              		<c:choose>
					              			<c:when test="${ordStatus eq 'I'}">
					              				<p><strong><fmt:message key="ORD_SCHEDULED_ORDER_NUMBER" bundle="${storeText}"/></strong> <span id="WC_OrderShippingBillingConfirmationPage_ScheduledOrderNumber"><c:out value="${objectId}"/></span></p>
					              			</c:when>
					              			<c:otherwise>
					              				<p><strong><fmt:message key="ORD_ORDER_NUMBER" bundle="${storeText}"/></strong>: <span id="WC_OrderShippingBillingConfirmationPage_span_1"><c:out value="${objectId}"/></span></p>
					              			</c:otherwise>
					              		</c:choose>
					              	</c:otherwise>
					              </c:choose>
                                   <c:if test="${!(ordStatus eq 'I' || ordStatus eq 'W')}">
	                                   <c:choose>
							              	<c:when test="${WCParam.isQuote eq true}">
							              						 <jsp:useBean id="nowDateForQuotes" class="java.util.Date" />
			                                   <fmt:formatDate value="${nowDateForQuotes}" type="date" dateStyle="long" var="formattedOrderDate" timeZone="${fn:replace(cookie.WC_timeoffset.value, '%2B', '+')}"/>
			                                   <p><strong><fmt:message key="ORD_QUOTE_DATE" bundle="${storeText}"/></strong>: <c:out value="${formattedOrderDate}"/></p>
							              	</c:when>
							              	<c:otherwise>
			                                   <c:catch>
		                                          <fmt:parseDate var="orderDate" value="${order.placedDate}" pattern="yyyy-MM-dd'T'HH:mm:ss.SSS'Z'" timeZone="GMT"/>
			                                   </c:catch>
			                                   <c:if test="${empty orderDate}">
			                                          <c:catch>
			                                                 <fmt:parseDate var="orderDate" value="${order.placedDate}" pattern="yyyy-MM-dd'T'HH:mm:ss'Z'" timeZone="GMT"/>
			                                          </c:catch>
			                                   </c:if>
			                                   <fmt:formatDate value="${orderDate}" type="date" dateStyle="long" var="formattedOrderDate" timeZone="${fn:replace(cookie.WC_timeoffset.value, '%2B', '+')}"/>
			                                   <p><strong><fmt:message key="ORD_ORDER_DATE" bundle="${storeText}"/></strong>: <c:out value="${formattedOrderDate}"/></p>
							              	</c:otherwise>
	                                   </c:choose>
                                   </c:if>
                                   <c:if test="${ordStatus eq 'I'}">
                                   	<p><fmt:message key="ORD_SCHEDULED_ORDER_DESC" bundle="${storeText}"/></p>
                                   </c:if>
							       <%@ include file="OrderShippingBillingConfirmationEIExt.jspf"%> 
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
                            <div id="box">
					<div class="main_header" id=" WC_OrderShippingBillingConfirmationPage_div_5">
                                          <div class="left_corner" id=" WC_OrderShippingBillingConfirmationPage_div_6"></div>
						<div class="left" id=" WC_OrderShippingBillingConfirmationPage_div_7"><span class="main_header_text"><fmt:message key="BCT_SHIPPING_INFO" bundle="${storeText}"/></span></div>
                                          <div class="right_corner" id=" WC_OrderShippingBillingConfirmationPage_div_8"></div>
                                   </div>
					<div class="contentline" id=" WC_OrderShippingBillingConfirmationPage_div_9"></div>
                                   <div class="body" id=" WC_OrderShippingBillingConfirmationPage_div_13">
                                          <div id="shipping">
                                                 <c:choose>
                                                        <c:when test = "${shipmentTypeId == 1}">
                                                               <div class="shipping_address" id=" WC_OrderShippingBillingConfirmationPage_div_14">
                                                                      <p class="title"><fmt:message key="SHIP_SHIPPING_ADDRESS" bundle="${storeText}"/>:</p>
                                                                      <!-- since this is just single shipment page, all the orderItems will have same address -->
                                                                      <c:set var="contact" value="${order.orderItem[0].orderItemShippingInfo.shippingAddress}"/>

																	  <c:choose><c:when test="${contact.contactInfoIdentifier.externalIdentifier.contactInfoNickName eq  profileShippingNickname}"><fmt:message key="QC_DEFAULT_SHIPPING" bundle="${storeText}"/></c:when>
																	  <c:when test="${contact.contactInfoIdentifier.externalIdentifier.contactInfoNickName eq  profileBillingNickname}"><fmt:message key="QC_DEFAULT_BILLING" bundle="${storeText}"/></c:when>
																	  <c:otherwise>${contact.contactInfoIdentifier.externalIdentifier.contactInfoNickName}</c:otherwise>
																	  </c:choose>
                                                                
                                                                      <!-- Display shiping address of the order -->
                                                                      <%@ include file="../../Snippets/ReusableObjects/AddressDisplay.jspf"%>
                                                               </div>
                                                               <div class="shipping_method" id=" WC_OrderShippingBillingConfirmationPage_div_15">
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
                                                                      <p>
                                                                             <span class="title"><fmt:message key="SHIP_SHIPPING_METHOD" bundle="${storeText}"/>:</span>
                                                                             <span class="text"><c:out value="${order.orderItem[0].orderItemShippingInfo.shippingMode.description.value}"/></span>
                                                                      </p>
                                                                      <br />
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
                                                                    
                                                                      <flow:ifEnabled feature="ShippingInstructions">
                                                                          <c:set var="shipInstructions" value="${order.orderItem[0].orderItemShippingInfo.shippingInstruction}"/>
                                                                             <c:if test="${!empty shipInstructions}">
                                                                                    <p>
                                                                                           <span class="title"><fmt:message key="SHIP_SHIPPING_INSTRUCTIONS" bundle="${storeText}" />: </span>
                                                                                           <span class="text"><c:out value = "${shipInstructions}"/></span>
                                                                                    </p>
                                                                                    <br />
                                                                             </c:if>
                                                                      </flow:ifEnabled>                                                        

                                                                      <flow:ifEnabled feature="FutureOrders">
                                                                      	    <%-- get requested shipping date --%>
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
                                                                             <c:if test="${!empty formattedDate}">
                                                                                    <p>
                                                                                           <span class="title"><fmt:message key="SHIP_REQUESTED_DATE" bundle="${storeText}" />:</span>
                                                                                           <span class="text"><c:out value="${formattedDate}"/></span>
                                                                                    </p>
                                                                                    <br />
                                                                             </c:if>
                                                                      </flow:ifEnabled>
                                                               </div>
                                                               <%-- Display Single shipment confirmation page --%>
							       <%-- Declare the refresh area for the order items table and bind it to the paging controller --%>                                                               
                                                               <div dojoType="wc.widget.RefreshArea" widgetId="OrderConfirmPagingDisplay" id="OrderConfirmPagingDisplay" 
                                                               controllerId="OrderItemPaginationDisplayController" role="wairole:region" waistate:live="polite" waistate:atomic="false" waistate:relevant="all">
                                                               <%out.flush();%>
                                                                      <c:import url="${jspStoreDir}ShoppingArea/CheckoutSection/SingleShipment/OrderItemDetailSummary.jsp">  
                                                                             <c:param name="catalogId" value="${WCParam.catalogId}" />
                                                                             <c:param name="langId" value="${WCParam.langId}" />
                                                                             <c:param name="storeId" value="${WCParam.storeId}" />
                                                                             <c:param name="orderPage" value="confirmation" />
                                                                      </c:import>
                                                               <%out.flush();%>
                                                       			</div>
                                                       			<script type="text/javascript">
                                                       			dojo.addOnLoad(function() { 
                                                       				parseWidget("OrderConfirmPagingDisplay");
                                                       			});</script>
                                                        </c:when>
                                                        <c:otherwise>
                                                               <div class="shipping_method" id="WC_OrderShippingBillingConfirmationPage_div_15a">
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
                                                               <%-- Declare the refresh area for the order items table and bind it to the paging controller --%>                                                               
                                                               <div dojoType="wc.widget.RefreshArea" widgetId="MSOrderConfirmPagingDisplay" id="MSOrderConfirmPagingDisplay" 
                                                               controllerId="MSOrderItemPaginationDisplayController" role="wairole:region" waistate:live="polite" waistate:atomic="false" waistate:relevant="all">
                                                               <%out.flush();%>
                                                               <c:import url="${jspStoreDir}ShoppingArea/CheckoutSection/MultipleShipment/MSOrderItemDetailSummary.jsp">  
                                                                      <c:param name="catalogId" value="${WCParam.catalogId}" />
                                                                      <c:param name="langId" value="${WCParam.langId}" />
                                                                      <c:param name="storeId" value="${WCParam.storeId}" />
                                                                      <c:param name="orderPage" value="confirmation" />
                                                               </c:import>
                                                               <%out.flush();%>
                                                               </div>
                                                               <script type="text/javascript">
	                                                               dojo.addOnLoad(function() { 
	                                                               	parseWidget("MSOrderConfirmPagingDisplay");
	                                                               });
                                                               </script>
                                                        </c:otherwise>
                                                 </c:choose>
                                                                                           

                                                 <%out.flush();%>
                                                        <c:import url="${jspStoreDir}ShoppingArea/CheckoutSection/SingleShipment/SingleShipmentOrderTotalsSummary.jsp"> 
                                                               <c:param name="fromPage" value="orderConfirmationPage"/>
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
					
				<div class="main_header" id=" WC_OrderShippingBillingConfirmationPage_div_21">
                                   <div class="left_corner_straight" id=" WC_OrderShippingBillingConfirmationPage_div_22"></div>
					<div class="left" id=" WC_OrderShippingBillingConfirmationPage_div_23"><span class="main_header_text"><fmt:message key="BILL_BILLING_INFO" bundle="${storeText}"/></span></div>
                                   <div class="right_corner_straight" id=" WC_OrderShippingBillingConfirmationPage_div_24"></div>
                            </div>
              
				<div class="contentline" id=" WC_OrderShippingBillingConfirmationPage_div_25"></div>
                            
                            <%-- Hide the PayInStoreEmailAddress field --%>
                            <c:set var="hidePayInStoreEmailAddress" value="true"/>
                            <%@ include file="CheckoutPaymentAndBillingAddressSummary.jspf" %>
              
                            <wcf:url var="RegisterURL" value="UserRegistrationForm">
                                   <wcf:param name="langId" value="${langId}" />
                                   <wcf:param name="storeId" value="${WCParam.storeId}" />
                                   <wcf:param name="catalogId" value="${WCParam.catalogId}" />
                                   <wcf:param name="new" value="Y" />
                                   <wcf:param name="myAcctMain" value="1"/>
                            </wcf:url>
				<div class="content_footer" id=" WC_OrderShippingBillingConfirmationPage_div_29">
                                   <div class="left_corner" id=" WC_OrderShippingBillingConfirmationPage_div_30"></div>
									 <c:choose>
										<c:when test="${userType eq 'G'}">
										   <div class="left order_print_signup" id=" WC_OrderShippingBillingConfirmationPage_div_31">
										</c:when>
										<c:otherwise>
											<div class="button_footer_line" id="WC_OrderShipmentDetails_div_31">
										</c:otherwise>
									</c:choose>
												<div class="left" id="WC_OrderShippingBillingConfirmationPage_div_32">
														<span class="primary_button button_fit" >
															<span class="button_container">
																<span class="button_bg">
																	<span class="button_top">
																		<span class="button_bottom">   
																			<a href="JavaScript: print();" id="WC_OrderShippingBillingConfirmationPage_Print_Link" >
																				<fmt:message key="PRINT" bundle="${storeText}"/>
																			</a>
																		</span>
																	</span>	
																</span>
															</span>
														</span>	
													</div>
													<div class="button_side_message" id="WC_OrderShippingBillingConfirmationPage_div_35">
														<fmt:message key="PRINT_RECOMMEND" bundle="${storeText}"/>
													</div>
													<c:if test="${userType eq 'G'}">
														<br/><br/>
														<div class="left" id="WC_OrderShippingBillingConfirmationPage_div_36">
															<fmt:message key="ORD_SIGN_UP_1" bundle="${storeText}"/>&nbsp;<a href="<c:out value='${RegisterURL}'/>" class="order_link" id=" WC_OrderShippingBillingConfirmationPage_links_2"><fmt:message key="ORD_SIGN_UP_2" bundle="${storeText}"/></a>?
														</div>
													</c:if>
											</div>
                                   <div class="right_corner" id=" WC_OrderShippingBillingConfirmationPage_div_37"></div>
                            </div>
              
                     </div>
                     <!-- Content End -->
              </div>
              <!-- Main Content End -->
              <%@ include file="../../include/LayoutContainerBottom.jspf"%> 
              </div>
				  <div id="page_shadow" class="shadow"></div>

				  <flow:ifEnabled feature="Analytics">
						<cm:order orderId="${WCParam.orderId}"/>	
						<cm:pageview/>
						<script type="text/javascript">
							dojo.addOnLoad(function() {
								analyticsJS.storeId=<c:out value="${WCParam.storeId}" />;
								analyticsJS.catalogId=<c:out value="${WCParam.catalogId}" />;
								analyticsJS.loadShopCartPaginationHandler();
							});
						</script>					
					</flow:ifEnabled>
       </body>
</html>
