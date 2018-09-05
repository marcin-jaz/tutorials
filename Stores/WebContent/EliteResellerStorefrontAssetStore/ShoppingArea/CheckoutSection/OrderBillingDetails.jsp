<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2009 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>
<%-- 
  *****
  * This JSP file is used to render the billing page of the online checkout flow.
  * It allows the shoppers to enter the billing and payment information for their order.
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
<%@ include file="../../include/nocache.jspf"%>

<c:set var="isAjaxCheckOut" value="true"/>
<%-- Check if its a non-ajax checkout..--%>
<flow:ifDisabled feature="AjaxCheckout"> 
       <c:set var="isAjaxCheckOut" value="false"/>
</flow:ifDisabled>

<c:set var="isSinglePageCheckout" value="true"/>
<%-- Check if its a traditional checkout..--%>
<flow:ifDisabled feature="SharedShippingBillingPage"> 
       <c:set var="isSinglePageCheckout" value="false"/>
</flow:ifDisabled>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"
xmlns:wairole="http://www.w3.org/2005/01/wai-rdf/GUIRoleTaxonomy#"
xmlns:waistate="http://www.w3.org/2005/07/aaa" lang="${shortLocale}" xml:lang="${shortLocale}">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><c:out value="${storeName}"/> - <fmt:message key="TITLE_SHIPMENT_DISPLAY_BILLING_ONLY" bundle="${storeText}"/></title>

<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${vfileStylesheet}"/>" type="text/css"/>
<!--[if lte IE 6]>
<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${vfileStylesheetie}"/>" type="text/css"/>
<![endif]-->


<%-- This following section is only loaded and executed if the current page flow is non-AJAX --%>
<c:if test="${!isAjaxCheckOut}">
       <script type="text/javascript">
              // summary              : Sets a dirty flag
              // description       : Sets a dirty flag in CheckoutPayments.js when the user modifies the shipping information in a non-AJAX checkout flow
              //
              // event              : DOM/Dojo/Dijit event, e.g. onclick, onchange, etc.
              // assumptions       : Should be used in non-AJAX
              // dojo API              : 
              // returns              : void
              function setDirtyFlag(){
                     CheckoutHelperJS.setFieldDirtyFlag(true);
                     console.debug("Shipping information on the Shipping and Billing Method page was modified.");
              }
              
              ///////////////////////////////////////////////////////////////////////
              // On page load, we add the editable fields in the shipping information
              // section to dojo event listener so that when they are changed by the
              // user, we ask the user to update the shipping information before
              // proceeding to checkout.
              ///////////////////////////////////////////////////////////////////////
       </script>
</c:if>
<script type="text/javascript" src="<c:out value="${dojoFile}"/>" djConfig="${dojoConfigParams}"></script>
<%@ include file="../../include/CommonJSToInclude.jspf"%>
<script type="text/javascript" src="<c:out value='${jsAssetsDir}javascript/UserArea/AddressHelper.js'/>"></script>
<script type="text/javascript" src="<c:out value='${jsAssetsDir}javascript/CatalogArea/CategoryDisplay.js'/>"></script>
<script type="text/javascript" src="<c:out value='${jsAssetsDir}javascript/CheckoutArea/CheckoutHelper.js'/>"></script>
<script type="text/javascript" src="<c:out value='${jsAssetsDir}javascript/MessageHelper.js'/>"></script>
<script type="text/javascript" src="<c:out value='${jsAssetsDir}javascript/CheckoutArea/CheckoutPayments.js'/>"></script>
<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/ServicesDeclaration.js"/>"></script>
<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/CheckoutArea/ShippingAndBillingServicesDeclaration.js"/>"></script>
<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/CommonContextsDeclarations.js"/>"></script>
<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/CheckoutArea/ShippingAndBillingControllersDeclaration.js"/>"></script>

<c:set var="pageSize" value="${WCParam.pageSize}" />
<c:if test="${empty pageSize}">
	<c:set var="pageSize" value="${maxOrderItemsPerPage}"/>
</c:if>

<c:set var="beginIndex" value="${WCParam.beginIndex}" />
<c:if test="${empty beginIndex}">
	<c:set var="beginIndex" value="0" />
</c:if>

<c:set var="order" value="${requestScope.orderInCart}" />



<c:if test="${empty order || order==null}">
	<wcf:getData type="com.ibm.commerce.order.facade.datatypes.OrderType"
		var="order" expressionBuilder="findCurrentShoppingCartWithPagingOnItem" varShowVerb="ShowVerbShipment" maxItems="${pageSize}" recordSetStartNumber="${beginIndex}" recordSetReferenceId="ostatus" scope="request">
		<wcf:param name="accessProfile" value="IBM_Details" />	 
		<wcf:param name="sortOrderItemBy" value="orderItemID" />
		<wcf:param name="isSummary" value="false" />
	</wcf:getData>
</c:if>


<c:if test="${empty order.orderItem && beginIndex >= pageSize}">
	<c:set var="beginIndex" value="${beginIndex - pageSize}" />
	<wcf:getData type="com.ibm.commerce.order.facade.datatypes.OrderType"
		var="order" expressionBuilder="findCurrentShoppingCartWithPagingOnItem" varShowVerb="ShowVerbShipment" maxItems="${pageSize}" recordSetStartNumber="${beginIndex}" recordSetReferenceId="ostatus" scope="request">
		<wcf:param name="accessProfile" value="IBM_Details" />	 
		<wcf:param name="sortOrderItemBy" value="orderItemID" />
		<wcf:param name="isSummary" value="true" />
	</wcf:getData>
</c:if>

<c:if test="${beginIndex == 0}">
	<c:if test="${ShowVerbShipment.recordSetTotal > ShowVerbShipment.recordSetCount}">		
		<c:set var="pageSize" value="${ShowVerbShipment.recordSetCount}" />
	</c:if>
</c:if>	

<wcf:getData type="com.ibm.commerce.order.facade.datatypes.OrderType"
       var="usablePayments" expressionBuilder="findCurrentShoppingCart" scope="request">
       <wcf:param name="accessProfile" value="IBM_UsablePaymentInfo" />
</wcf:getData>


<c:set var="totalExistingPaymentMethods" value="1"/>
<c:forEach var="paymentInstance" items="${order.orderPaymentInfo.paymentInstruction}" varStatus="paymentCount">
       <c:set var="totalExistingPaymentMethods" value="${paymentCount.count}"/>
</c:forEach>

<c:set var="quickCheckoutProfileForPayment" value="${param.quickCheckoutProfileForPayment}"/>
<c:if test="${empty quickCheckoutProfileForPayment}">
       <c:set var="quickCheckoutProfileForPayment" value="${WCParam.quickCheckoutProfileForPayment}"/>
</c:if>

<c:if test="${quickCheckoutProfileForPayment}">
       <%-- we should use quick checkout profile for payment options..with quick checkout there will be only one payment method --%>
       <c:set var="totalExistingPaymentMethods" value="1"/>
</c:if>

<wcf:url var="ShippingAddressDisplayURL" value="ShippingAddressDisplayView" type="Ajax">
  <wcf:param name="langId" value="${langId}" />                                          
  <wcf:param name="storeId" value="${WCParam.storeId}" />
  <wcf:param name="catalogId" value="${WCParam.catalogId}" />
  <wcf:param name="forceShipmentType" value="1" />
</wcf:url>

<wcf:url var="ShoppingCartURL" value="OrderCalculate" type="Ajax">
   <wcf:param name="langId" value="${langId}" />
  <wcf:param name="storeId" value="${WCParam.storeId}" />
  <wcf:param name="catalogId" value="${WCParam.catalogId}" />
  <wcf:param name="URL" value="AjaxCheckoutDisplayView" />
  <wcf:param name="errorViewName" value="AjaxCheckoutDisplayView" />
  <wcf:param name="updatePrices" value="1" />
  <wcf:param name="calculationUsageId" value="-1" />
  <wcf:param name="orderId" value="." />
</wcf:url>

<wcf:url var="TraditionalShippingURL" value="OrderShippingBillingView" type="Ajax">
  <wcf:param name="langId" value="${langId}" />
  <wcf:param name="storeId" value="${WCParam.storeId}" />
  <wcf:param name="catalogId" value="${WCParam.catalogId}" />
  <wcf:param name="forceShipmentType" value="${WCParam.forceShipmentType}" />
</wcf:url>


<%-- This declares the common error messages and <c:url tags --%>
<%@ include file="CommonUtilities.jspf"%>

<%-- get the addressId --%>
<c:set var="selectedAddressId" value="${order.orderItem[0].orderItemShippingInfo.shippingAddress.contactInfoIdentifier.uniqueID}"/>
<c:set var="currentOrderId" value="${order.orderIdentifier.uniqueID}" />

<%-- Include controllers declaraions after common contexts declaraions.. controllers will make a local copy of the render contexts.. so render contexts should be declared before controllers. Never declare two contexts with same id.. Even if two contexts with same id is defined, they should be defined before defining controller..Because if you declare context and controller in this order..
{context - controller - context} the controller will make a local copy of the first context declared and always refers to it.. But updateContext and other functions will refer to second context declared and so there wont be any sync between context used in code and context referred by controller..Controllers use context by value and not by reference.. --%>
<script type="text/javascript">
	dojo.addOnLoad(function() { 
		CheckoutHelperJS.setCommonParameters('<c:out value="${langId}"/>','<c:out value="${storeId}"/>','<c:out value="${catalogId}"/>');
		CheckoutHelperJS.setSinglePageCheckout(<c:out value='${isSinglePageCheckout}'/>);
		CheckoutHelperJS.initializeShipmentPage('<c:out value='${WCParam.forceShipmentType}'/>');
		ServicesDeclarationJS.setCommonParameters('<c:out value='${WCParam.langId}'/>','<c:out value='${WCParam.storeId}'/>','<c:out value='${WCParam.catalogId}'/>');
		SBServicesDeclarationJS.setCommonParameters('<c:out value='${WCParam.langId}'/>','<c:out value='${WCParam.storeId}'/>','<c:out value='${WCParam.catalogId}'/>');
		SBServicesDeclarationJS.setAjaxCheckOut(<c:out value='${isAjaxCheckOut}'/>);
		SBServicesDeclarationJS.setSinglePageCheckout(<c:out value='${isSinglePageCheckout}'/>);
		CommonContextsJS.setCommonParameters('<c:out value='${WCParam.langId}'/>','<c:out value='${WCParam.storeId}'/>','<c:out value='${WCParam.catalogId}'/>');
		SBControllersDeclarationJS.setAjaxCheckOut('<c:out value='${isAjaxCheckOut}'/>');
		SBControllersDeclarationJS.setSinglePageCheckout(<c:out value='${isSinglePageCheckout}'/>);
		SBControllersDeclarationJS.setControllerURL('traditionalShipmentDetailsController','<c:out value="${TraditionalAjaxShippingDetailsViewURL}"/>');
		SBControllersDeclarationJS.setControllerURL('shippingAddressSelectBoxAreaController','<c:out value="${ShippingAddressDisplayURL}"/>');
		SBControllersDeclarationJS.setControllerURL('multipleShipmentDetailsController','<c:out value="${AjaxMultipleShipmentOrderItemDetailsViewURL}"/>');
		SBControllersDeclarationJS.setControllerURL('currentOrderTotalsAreaController','<c:out value="${AjaxCurrentOrderInformationViewURL}"/>');
		SBControllersDeclarationJS.setControllerURL('billingAddressSelectBoxAreaController','<c:out value="${billingAddressDisplayURL}"/>');
		CommonContextsJS.setContextProperty('billingAddressDropDownBoxContext','billingURL1','${billingAddressDisplayURL_1}');
		CommonContextsJS.setContextProperty('billingAddressDropDownBoxContext','billingURL2','${billingAddressDisplayURL_2}');
		CommonContextsJS.setContextProperty('billingAddressDropDownBoxContext','billingURL3','${billingAddressDisplayURL_3}');
		MessageHelper.setMessage("SHIPPING_INVALID_ADDRESS", "<fmt:message key="SHIPPING_INVALID_ADDRESS" bundle="${storeText}"/>");
	}); 
        
</script>

<%-- This declares the common error messages and <c:url tags --%>
<%@ include file="CommonUtilities.jspf"%>

<%@ include file="../../Snippets/ReusableObjects/AddressHelperCountrySelection.jspf" %>

</head>
<body>

<%@ include file="../../include/StoreCommonUtilities.jspf"%>
<%@ include file="../../Snippets/ReusableObjects/CatalogEntryQuickInfoDetails.jspf" %>
<!-- Page Start -->
<div id="page">
       <%@ include file="../../include/LayoutContainerTop.jspf"%>
		
		<div id="checkout_crumb">
              <div class="crumb" id="WC_ShipmentDisplay_div_4">
		<c:if test = "${!empty order.orderItem}">
                     <a href="<c:out value="${ShoppingCartURL}"/>" id="WC_ShipmentDisplay_links_2"><span><fmt:message key="BCT_SHOPPING_CART" bundle="${storeText}"/></span></a> | 
					 <a href="<c:out value="${TraditionalShippingURL}"/>" id="WC_ShipmentDisplay_links_2a"><span><fmt:message key="BCT_SHIPPING" bundle="${storeText}"/></span></a> | <span class="on"><fmt:message key="BCT_BILLING" bundle="${storeText}"/></span> | 
					 <span><fmt:message key="BCT_ORDER_SUMMARY" bundle="${storeText}"/></span>
		</c:if>
              </div>
        </div>

       <div id="MessageArea" >
              <br />
		<span id="ErrorMessageText" class="error_msg" tabindex="-1">
                     
              </span>
              <br /><br />  
              <div id="OrderShippingBillingErrorArea" class="nodisplay">
			       		<div id="WC_OrderShippingBillingDetails_div_1">
										<div class="body" id="WC_OrderShippingBillingDetails_div_2">
												<div class="left" id="WC_OrderShippingBillingDetails_div_3">
														<fmt:message key="SHIP_PROBLEM_DESC" bundle="${storeText}"/>
												</div>
												<br clear="all" />
												<div id="WC_OrderShippingBillingDetails_div_4">	
													<span class="primary_button button_fit" >
														<span class="button_container">
															<span class="button_bg">
																<span class="button_top">
																	<span class="button_bottom">   
																		<a href="<c:out value='${ShoppingCartURL}'/>" id="WC_OrderShippingBillingDetails_links_1">
													                    	<fmt:message key="SHIP_GO_BACK" bundle="${storeText}"/><span class="spanacce"><fmt:message key="Checkout_ACCE_back_shopping_cart" bundle="${storeText}"/></span>
													                    </a>
													                </span>
																</span>	
															</span>
														</span>
													</span>
												</div>
										</div>
								</div>
						</div>
       </div>
         
                     <%-- The controllers declaration JavaScript file will declare all the controllers without setting URL. URLs are created using <c:url tag and hence cannot be used in JS file. So we have to explicitly set the URL after including controllers...--%>
                     <script type="text/javascript">
                            wc.render.declareRefreshController({
                                   id: "editShippingAdddressAreaController",
                                   renderContext: wc.render.getContextById("editShippingAddressContext"),
                                   url: "${editAddressDisplayURL}",
                                   formId: ""
                                   ,modelChangedHandler: function(message, widget) {
                                          if('${shipmentTypeId}' == 2){
                                                 var controller = this;
                                                 var renderContext = this.renderContext;
                                                 if (message.actionId in address_updated){
                                                        //This means, invokeService for Address Add/Edit has been called..so upadate our select box area
                                                        wc.render.updateContext('contextForMainAndAddressDiv', {'showArea':'mainContents','hideArea':'editAddressContents'});
                                                        selectedAddressId = message.addressId;
                                                        CheckoutHelperJS.updateAddressIdOFItemsOnCreateEditAddress(selectedAddressId);
                                                        cursor_clear();  
                                                 } 
                                          }
                                   }
                                   ,renderContextChangedHandler: function(message, widget) {
                                          var controller = this;
                                          var renderContext = this.renderContext;
                                          if (controller.testForChangedRC(["shippingAddress"])) {
                                                        var addressId = renderContext.properties["shippingAddress"];
                                                        //reset the addressID..so that when user selects create address next time it works properly..
                                                        renderContext.properties["shippingAddress"] = 0;
                                                        var addressType = renderContext.properties["addressType"];
                                                        widget.refresh({"addressId": addressId,"addressType":addressType});
                                          }
                                   }

                                   ,postRefreshHandler: function(widget) {
                                          var controller = this;
                                          var renderContext = this.renderContext;
                                          cursor_clear();
                                   }

                            });
                     </script>
<c:catch>
	<c:set var="activeOrgId" value="${CommandContext.activeOrganizationId}"/>
	<wcf:getData type="com.ibm.commerce.member.facade.datatypes.OrganizationType" 
		var="organization" expressionBuilder="findByUniqueID" scope="request">
		<wcf:param name="organizationId" value="${activeOrgId}" />
		<wcf:param name="accessProfile" value="IBM_All" />
	</wcf:getData>
	<c:set var="organizationAddresses" value="${organization.addressBook}"/>
	<c:set var ="contact" value="${organization.contactInfo}"/>
	<c:if test="${selectedShippingAddressId == contact.contactInfoIdentifier.uniqueID}">
		<c:set var="showEditShippingAddressLink" value="false"/>
	</c:if>
	<c:set var ="contactOrgAddress" value="${contact.contactInfoIdentifier.uniqueID}"/>
	<c:forEach items="${organizationAddresses.contact}" var="contact">
		<c:choose>
			<c:when test="${empty contactOrgAddress || contactOrgAddress eq null}">
				<c:set var="contactOrgAddress" value="${contact.contactInfoIdentifier.uniqueID}"/>
			</c:when>
			<c:otherwise>
				<c:set var="contactOrgAddress" value="${contactOrgAddress},${contact.contactInfoIdentifier.uniqueID}"/>
			</c:otherwise>
		</c:choose>
		<c:if test="${selectedShippingAddressId == contact.contactInfoIdentifier.uniqueID}">
				<c:set var="showEditShippingAddressLink" value="false"/>
		</c:if>
	</c:forEach>
	<input type="hidden" id="shippingOrganizationAddressList" value="${contactOrgAddress}" name="shippingOrganizationAddressList"/>
</c:catch>
 
								

                     <div id="content_wrapper" dojoType="wc.widget.RefreshArea" widgetId="content_wrapper" controllerId="controllerForMainAndAddressDiv" >
                              <!-- Content Start -->
                              <!-- There are two parts in the content (editAddressContents and mainContents Div)..One Div contains the entire checkoutContents (shopping cart, shipping address, billing info and other things.. The second DIV contains only edit Address page .. On click of Edit Address button, the first div will be hidden and edit address page div will be displayed...
                              Instead of having both the div's in same page, we can make a call to server on click of edit button and get the edit Address page..But the problem in that case is, if user clicks on Cancel/Submit button after changing the address details, we update the server with the changes and again redirect the user to Shipping and Billing address page which results in resetting any changes made in shipping / billing details. User will loose all the changes made in shipping/billing page before clicking on edit address button..To avoid this situation we have both the DIV's defined in this page and use hide/show logic here..-->
                              
								<div id="mainContents" style="display:block">  
									<div id="box">
										<div dojoType="wc.widget.RefreshArea" id = "shippingAddressSelectBoxArea" widgetId="shippingAddressSelectBoxArea" controllerId="shippingAddressSelectBoxAreaController" style="display:none;">	
										</div>
									<script type="text/javascript">
										dojo.addOnLoad(function() { 
											parseWidget("shippingAddressSelectBoxArea"); 
										});
									</script>
                                        <c:forEach var="orderItem" items="${order.orderItem}" varStatus="status">
										<c:set var="totalNumberOfItems" value="${status.count}"/>
										<c:set var="itemUniqueId" value="${orderItem.orderItemIdentifier.uniqueID}"/>
										<input type="hidden" name="OrderTotalAmount" value="<c:out value='${order.orderAmount.grandTotal.value}'/>" id="OrderTotalAmount" />
										<input type="hidden" id = "totalNumberOfItems" name="totalNumberOfItems" value='<c:out value="${totalNumberOfItems}"/>'/>
										<input type="hidden" value='<c:out value="${itemUniqueId}"/>' name='orderItem_<c:out value="${status.count}"/>' id='orderItem_<c:out value="${status.count}"/>'/>
										</c:forEach>
					<c:choose>
					<c:when test="${WCParam.forceShipmentType == 1}">
					<div class="main_header" id="WC_SingleShipmentSummary_div_5">
						<div class="left_corner" id="WC_SingleShipmentSummary_div_6"></div>
						<div class="left" id="WC_SingleShipmentSummary_div_7"><span class="main_header_text"><fmt:message key="BCT_SHIPPING_INFO" bundle="${storeText}"/></span></div>
						<div class="right_corner" id="WC_SingleShipmentSummary_div_8"></div>
					</div>
					<div class="contentline" id="WC_SingleShipmentSummary_div_9"></div>
					<div class="body" id="WC_SingleShipmentSummary_div_13">
						<div id="shipping">
							<div class="shipping_address" id="WC_SingleShipmentSummary_div_14">
								<p class="title"><fmt:message key="SHIP_SHIPPING_ADDRESS" bundle="${storeText}"/>:</p>
								<%-- since this is just single shipment page, all the order items will have same address --%>
								<c:set var="contact" value="${order.orderItem[0].orderItemShippingInfo.shippingAddress}"/>

								<c:if test="${!empty contact.contactInfoIdentifier.externalIdentifier.contactInfoNickName}">
									<p><c:choose><c:when test="${contact.contactInfoIdentifier.externalIdentifier.contactInfoNickName eq  profileShippingNickname}"><fmt:message key="QC_DEFAULT_SHIPPING" bundle="${storeText}"/></c:when>
									<c:when test="${contact.contactInfoIdentifier.externalIdentifier.contactInfoNickName eq  profileBillingNickname}"><fmt:message key="QC_DEFAULT_BILLING" bundle="${storeText}"/></c:when>
									<c:otherwise>${contact.contactInfoIdentifier.externalIdentifier.contactInfoNickName}</c:otherwise></c:choose></p>
								</c:if>
								<!-- Display shiping address of the order -->
								<%@ include file="../../Snippets/ReusableObjects/AddressDisplay.jspf"%>
							</div>
		
							<div class="shipping_method" id="WC_SingleShipmentSummary_div_15">
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

								<p>
									<span class="title"><fmt:message key="SHIP_SHIP_AS_COMPLETE" bundle="${storeText}"/>: </span>
									<c:if test='${order.shipAsComplete}'>
										<span class="text"><fmt:message key="YES" bundle="${storeText}"/></span>
									</c:if>
									<c:if test='${!order.shipAsComplete}'>
										<span class="text"><fmt:message key="NO" bundle="${storeText}"/></span>
									</c:if>
								</p>
								<br />
							
								<flow:ifEnabled feature="ShippingInstructions">
									<c:if test="${!empty shipInstructions}">
										<p class="title"><fmt:message key="SHIP_SHIPPING_INSTRUCTIONS" bundle="${storeText}" />:</p>
										<p class="text"><c:out value = "${shipInstructions}"/></p>
										<br />
									</c:if>
								</flow:ifEnabled>								
								
								<flow:ifEnabled feature="FutureOrders">
									<c:if test="${!empty formattedDate}">
									<p>
										<span class="title"><fmt:message key="SHIP_REQUESTED_DATE" bundle="${storeText}" />:</span>
										<span class="text"><c:out value="${formattedDate}"/></span>
									</p>
									<br />
									 </c:if>
								</flow:ifEnabled>
							</div>
	
													
							<div dojoType="wc.widget.RefreshArea" widgetId="OrderItemPagingDisplay" id="OrderItemPagingDisplay" controllerId="OrderItemPaginationDisplayController" role="wairole:region" waistate:live="polite" waistate:atomic="false" waistate:relevant="all">
								<%out.flush();%>
									<c:import url="${jspStoreDir}ShoppingArea/CheckoutSection/SingleShipment/OrderItemDetailSummary.jsp"> 
										<c:param name="catalogId" value="${WCParam.catalogId}" />
										<c:param name="langId" value="${WCParam.langId}" />
										<c:param name="storeId" value="${WCParam.storeId}" />
										<c:param name="orderPage" value="summary" />
									</c:import>
								<%out.flush();%>
							</div>
							<script type="text/javascript">
								dojo.addOnLoad(function() { 
									parseWidget("OrderItemPagingDisplay");
								});
							</script>
							<%out.flush();%>
								<c:import url="${jspStoreDir}ShoppingArea/CheckoutSection/SingleShipment/SingleShipmentOrderTotalsSummary.jsp"> 
									<c:param name="fromPage" value="billingPage"/>
								</c:import>
							<%out.flush();%>
						</div>
						<br clear="all" />
					</div>
				</c:when>
				<c:otherwise>
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
					
				</c:otherwise>
				</c:choose>
				<flow:ifEnabled feature="ScheduleOrder">
					<%out.flush();%>
						<c:import url="${jspStoreDir}ShoppingArea/CheckoutSection/ScheduleOrderDisplayExt.jsp">
							<c:param value="true" name="isShippingBillingPage"/>
							<c:param value="${currentOrderId}" name="orderId"/>
						</c:import>
					<%out.flush();%>
				</flow:ifEnabled>
                                   
										  
						<div class="main_header" id="WC_ShipmentDisplay_div_22">
                                                 <div class="left_corner_straight" id="WC_ShipmentDisplay_div_23"></div>
							<div class="left" id="WC_ShipmentDisplay_div_24"><span class="main_header_text"><fmt:message key="BILL_BILLING_INFO" bundle="${storeText}"/></span></div>
                                                 <div class="right_corner_straight" id="WC_ShipmentDisplay_div_25"></div>
                                      </div>

                                          <!-- Display drop down box to select number of payment options.. -->
					   <div class="content_header" id="WC_ShipmentDisplay_div_26">
                                                 <div class="left_corner" id="WC_ShipmentDisplay_div_27"></div>
                                                 <div class="left_drop_down_shipment" id="WC_ShipmentDisplay_div_28">
							<span class="content_text"><label for="numberOfPaymentMethods"><fmt:message key="BILL_MULTIPLE_BILLING_MESSAGE" bundle="${storeText}"/></label>
                                                        <select class="drop_down_shipment" name="numberOfPaymentMethods" id="numberOfPaymentMethods" onchange="JavaScript:CheckoutPayments.setNumberOfPaymentMethods(<c:out value="${numberOfPaymentMethods}"/>,this,'paymentSection')">
                                                                      <c:set var="selectStr" value="" />
                                                                      <c:forEach var="i" begin="1" end="${numberOfPaymentMethods}">
                                                                             <c:if test="${i == totalExistingPaymentMethods}">
                                                                                    <c:set var="selectStr" value='selected="selected"'/>
                                                                             </c:if>
                                                                             <option value="<c:out value="${i}"/>" <c:out value="${selectStr}" escapeXml="false"/>>
                                                                                    <fmt:message key="BILL_PAYMENT_OPTIONS" bundle="${storeText}">
                                                                                           <fmt:param value="${i}"/>
                                                                                    </fmt:message>
                                                                             </option>
                                                                             <c:set var="selectStr" value="" />
                                                                      </c:forEach>
                                                               </select>
                                                        </span>
                                                 </div>
                                                 <div class="right_corner" id="WC_ShipmentDisplay_div_29"></div>
                                      </div>

                                          <c:set var="showPayInStore" value="false"/>
											<%@ include file="CheckoutPaymentsAndBillingAddress.jspf"%>
				
					   <div class="content_footer" id="WC_ShipmentDisplay_div_30">
                                                 <div class="left_corner" id="WC_ShipmentDisplay_div_31"></div>
                                                 <div class="button_footer_line" id="WC_ShipmentDisplay_div_32">
                                                        <div class="left" id="WC_ShipmentDisplay_div_32_1">
                                                               <span class="secondary_button button_fit" >
																	<span class="button_container">
																		<span class="button_bg">
																			<span class="button_top">
																				<span class="button_bottom">
																					 <a href="<c:out value='${TraditionalShippingURL}'/>" id="WC_ShipmentDisplay_links_5a">
					                                                                      <fmt:message key="BACK" bundle="${storeText}"/><span class="spanacce"><fmt:message key="Checkout_ACCE_back_shopping_cart" bundle="${storeText}"/></span>
					                                                               	</a>
					                                                              </span>
																			</span>	
																		</span>
																	</span>
																</span>	
                                                        </div>
                                                        <div class="left" id="WC_ShipmentDisplay_div_32_2">
                                                               <span class="primary_button button_fit" >
																	<span class="button_container">
																		<span class="button_bg">
																			<span class="button_top">
																				<span class="button_bottom"> 
																					<a id = "billingPageNext" href="JavaScript:setCurrentId('billingPageNext'); CheckoutPayments.processCheckout('PaymentForm',true);">
					                                                                    <fmt:message key="NEXT" bundle="${storeText}"/><span class="spanacce"><fmt:message key="Checkout_ACCE_next_summary" bundle="${storeText}"/></span>
					                                                               	</a>
					                                                            </span>
																			</span>	
																		</span>
																	</span>
																</span>	
                                                        </div>
                                                        <div class="button_side_message" id="WC_ShipmentDisplay_div_32_3">
                                                               <fmt:message key="ORD_MESSAGE" bundle="${storeText}"/>
                                                        </div>
                                                 </div>
                                                 <div class="right_corner" id="WC_ShipmentDisplay_div_37"></div>
                                      </div>
                                   </div>
                                   <!-- Content End --> 
                              </div>
                             <!-- Main Content End -->
                             
                             <!-- Edit address div -->
                             <div id="editAddressContents" style="display:none">
                                   <!-- Start of second div in this page -->
                                   <div dojoType="wc.widget.RefreshArea" id="editShippingAddressArea1" widgetId="editShippingAddressArea1" controllerId="editShippingAdddressAreaController" role="wairole:region" waistate:live="polite" waistate:atomic="true" waistate:relevant="all">
                                   </div>
                                   <script type="text/javascript">
                                          dojo.addOnLoad(function() {
                                          	parseWidget("editShippingAddressArea1");
                                          });
                                   </script>
                            </div>
                            <!-- Main Content End -->     
                      </div>
                     <script type="text/javascript">
	                     dojo.addOnLoad(function() { 
	                     	parseWidget("content_wrapper");
	                     });
                     </script>
       <%@ include file="../../include/LayoutContainerBottom.jspf"%>   
</div>
<div id="page_shadow" class="shadow"></div>
<flow:ifEnabled feature="Analytics"><cm:pageview/></flow:ifEnabled>
</body>
</html>
