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
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf"%>
 
<!-- Start - JSP File Name:  CheckoutLogon.jsp -->
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

<c:if test="${userType != 'G'}">
	<%-- See if this user has quick checkout profile created or not, if quick checkout enabled --%>
	<flow:ifEnabled feature="quickCheckout"> 
		<wcf:getData type="com.ibm.commerce.order.facade.datatypes.OrderType" var="quickOrder" expressionBuilder="findByOrderStatus">
		   <wcf:param name="status" value="Q"/>
		   <wcf:param name="accessProfile" value="IBM_Summary" />
		</wcf:getData>
		<c:if test="${!empty quickOrder.orderIdentifier.uniqueID}">
			<c:set var="quickCheckoutProfile" value="true"/>
		</c:if>
	</flow:ifEnabled>
</c:if>


<c:if test="${userType == 'G'}">	
		<wcf:url var="orderMove" value="OrderItemMove" type="Ajax">
			<wcf:param name="toOrderId" value="."/>
			<c:choose>
				<c:when test="${b2bStore}">
					<wcf:param name="deleteIfEmpty" value="."/>
					<wcf:param name="fromOrderId" value="."/>
				</c:when>
				<c:otherwise>
					<wcf:param name="deleteIfEmpty" value="*"/>
					<wcf:param name="fromOrderId" value="*"/>
				</c:otherwise>
			</c:choose>
			<wcf:param name="continue" value="1"/>
			<wcf:param name="createIfEmpty" value="1"/>
			<wcf:param name="calculationUsageId" value="-1"/>
			<wcf:param name="updatePrices" value="0"/>
		</wcf:url>
		
	<wcf:url var="ForgetPasswordURL" value="ResetPasswordGuestErrorView">
		<wcf:param name="langId" value="${langId}" />
		<wcf:param name="storeId" value="${WCParam.storeId}" />
		<wcf:param name="catalogId" value="${WCParam.catalogId}" />
		<wcf:param name="state" value="forgetpassword" />
	</wcf:url>	

	<form method="post" name="AjaxLogon" id="AjaxLogon" action="Logon">
	<input type="hidden" name="storeId" value="<c:out value="${WCParam.storeId}"/>" id="WC_RememberMeLogonForm_FormInput_storeId_In_AjaxLogon_1"/>
	<input type="hidden" name="catalogId" value="<c:out value="${WCParam.catalogId}"/>" id="WC_RememberMeLogonForm_FormInput_catalogId_In_AjaxLogon_1"/>
	<input type="hidden" name="URL" value="" id="WC_AccountDisplay_FormInput_URL_In_Logon_1" />
	<input type="hidden" name="reLogonURL" value="AjaxOrderItemDisplayView" id="WC_RememberMeLogonForm_FormInput_reLogonURL_In_AjaxLogon_1"/>
	<input type="hidden" name="errorViewName" value="AjaxOrderItemDisplayView" id="WC_RememberMeLogonForm_FormInput_errorViewName_In_AjaxLogon_1"/>	
	
	<div class="top_border" id="WC_CheckoutLogonf_div_0">
		<div id="customers_new_or_returning">
	      <div class="returning" id="WC_CheckoutLogonf_div_1">
		   <h2><fmt:message key="SHOPCART_TEXT3" bundle="${storeText}"/></h2>
		   <p class="myaccount_title"><fmt:message key="SHOPCART_TEXT4" bundle="${storeText}"/></p>
		   <br />
		   <p><label for="WC_CheckoutLogon_FormInput_logonId"><fmt:message key="SHOPCART_USERNAME" bundle="${storeText}"/></label></p>
		   <p>
			<input id="WC_CheckoutLogon_FormInput_logonId" name="logonId" type="text" size="30" onkeypress="if(event.keyCode==13){javascript:if(CheckoutHelperJS.updateShoppingCart(document.ShopCartForm,true)){ShipmodeSelectionExtJS.guestShopperLogon('javascript:LogonForm.SubmitAjaxLogin(document.AjaxLogon)', '<c:out value='${orderMove}'/>', '<c:out value='${OrderCalculateURL}'/>', '<c:out value='${PhysicalStoreSelectionURL}'/>');}}" />
		   </p>
		   <br />
		   <p><label for="WC_CheckoutLogon_FormInput_logonPassword"><fmt:message key="SHOPCART_PASSWORD" bundle="${storeText}"/></label></p>
		   <p>
			<input id="WC_CheckoutLogon_FormInput_logonPassword" name="logonPassword" type="password" size="30" onkeypress="if(event.keyCode==13){javascript:if(CheckoutHelperJS.updateShoppingCart(document.ShopCartForm,true)){ShipmodeSelectionExtJS.guestShopperLogon('javascript:LogonForm.SubmitAjaxLogin(document.AjaxLogon)', '<c:out value='${orderMove}'/>', '<c:out value='${OrderCalculateURL}'/>', '<c:out value='${PhysicalStoreSelectionURL}'/>');}}" />
		   </p>
		   <p><a href="<c:out value="${ForgetPasswordURL}"/>" class="myaccount_link" id="WC_CheckoutLogonf_links_1"><fmt:message key="SHOPCART_FORGOT" bundle="${storeText}"/></a></p>
	      </div>
	      <div class="new" id="WC_CheckoutLogonf_div_2">
		   <h2><fmt:message key="SHOPCART_NEW_CUSTOMER" bundle="${storeText}"/></h2>
		   <p class="myaccount_title"><fmt:message key="SHOPCART_CHECKOUT_WITHOUT_SIGNING" bundle="${storeText}"/></p>
		   <br />
		   <p><fmt:message key="SHOPCART_TEXT1" bundle="${storeText}"/></p>
		   <br />
		   <p><fmt:message key="SHOPCART_TEXT2" bundle="${storeText}"/></p>
	      </div>
	      <br clear="all" />
	      <div class="returning_button" id="WC_CheckoutLogonf_div_3">
			 <span class="primary_button button_fit" id="WC_CheckoutLogonf_div_4" >
				<span class="button_container">
					<span class="button_bg">
						<span class="button_top">
							<span class="button_bottom">   
								<a href="#" onclick="javascript:if(CheckoutHelperJS.updateShoppingCart(document.ShopCartForm,true)){ShipmodeSelectionExtJS.guestShopperLogon('javascript:LogonForm.SubmitAjaxLogin(document.AjaxLogon)', '<c:out value='${orderMove}'/>', '<c:out value='${OrderCalculateURL}'/>', '<c:out value='${PhysicalStoreSelectionURL}'/>');}return false;" id="guestShopperLogon" >
								  <fmt:message key="SHOPCART_SIGNIN" bundle="${storeText}"/>
							  	</a>
					  		</span>
						</span>
					</span>	
				</span>
			</span>	
		  </div>
	      <div class="new_button" id="WC_CheckoutLogonf_div_6">
			<span class="primary_button button_fit" id="WC_CheckoutLogonf_div_8" >
				<span class="button_container">
					<span class="button_bg">
						<span class="button_top">
							<span class="button_bottom">   
								<a href="#" onclick="javascript:if(CheckoutHelperJS.updateShoppingCart(document.ShopCartForm,true)){ShipmodeSelectionExtJS.guestShopperContinue('<c:out value='${OrderCalculateURL}'/>', '<c:out value='${PhysicalStoreSelectionURL}'/>');}return false;" id="guestShopperContinue">
								  <fmt:message key="SHOPCART_CONTINUE" bundle="${storeText}"/>
							 	 </a>
							  </span>
						</span>	
					</span>
				</span>
			</span>	
		  </div>
	 	</div>
	 </div>
	 <br clear="all" />
	 <br />
	</form>
</c:if>

<div id="WC_CheckoutLogonf_div_9">
<c:if test="${userType != 'G'}">
	<div class="left" id="checkoutButton">
		<c:choose>
			<c:when test="${requestScope.allContractsValid}">		
				<span class="primary_button" id="WC_CheckoutLogonf_div_10" >
			</c:when>
			<c:otherwise>
				<span class="disabled_button" id="WC_CheckoutLogonf_div_10" >
			</c:otherwise>
		</c:choose>
			<span class="button_container">
				<span class="button_bg">
					<span class="button_top">
						<span class="button_bottom">   
							<c:choose>
								<c:when test="${requestScope.allContractsValid}">
									<a href="#" onclick="javascript:if(CheckoutHelperJS.updateShoppingCart(document.ShopCartForm,true)){ShipmodeSelectionExtJS.registeredUserContinue('<c:out value='${OrderCalculateURL}'/>', '<c:out value='${PhysicalStoreSelectionURL}'/>');}return false;" id="shopcartCheckout" >
										<fmt:message key="SHOPCART_CHECKOUT" bundle="${storeText}"/>
									</a>
								</c:when>
								<c:otherwise>
									<a href="#" id="shopcartCheckout" >
										<fmt:message key="SHOPCART_CHECKOUT" bundle="${storeText}"/>
									</a>
								</c:otherwise>
							</c:choose>
						</span>
					</span>
				</span>	
			</span>
		</span>
	</div>	
	<c:if test="${quickCheckoutProfile}">
		<c:set var="quickOrderId" value="${quickOrder.orderIdentifier.uniqueID}"/>
		<div class="left" id="quickCheckoutButton">
		<span class="primary_button" id="WC_CheckoutLogonf_div_13" >
			<span class="button_container">
				<span class="button_bg">
					<span class="button_top">
						<span class="button_bottom">   
							<a href="javascript:if(CheckoutHelperJS.updateShoppingCart(document.ShopCartForm,true)){setCurrentId('WC_CheckoutLogonf_links_2'); ShipmodeSelectionExtJS.updateCartWithQuickCheckoutProfile('<c:out value='${quickOrderId}'/>');}" id="WC_CheckoutLogonf_links_2">
								<fmt:message key="QUICKCHECKOUT" bundle="${storeText}"/>
							</a>
						</span>
					</span>
				</span>	
			</span>
		</span>	
		</div>
	</c:if>
</c:if>
<flow:ifDisabled feature="AjaxCheckout"> 
	<div class="left" id="updateShopCart"> 
		<span class="primary_button button_fit" id="WC_CheckoutLogonf_div_14" >
			<span class="button_container">
				<span class="button_bg">
					<span class="button_top">
						<span class="button_bottom">   
							<a href="#" onclick="javascript:CheckoutHelperJS.updateShoppingCart(document.ShopCartForm);return false;" id="ShoppingCart_NonAjaxUpdate">
								<fmt:message key="SHOPCART_UPDATE" bundle="${storeText}"/>
							</a>
						</span>
					</span>
				</span>		
			</span>
		</span>	
	</div>	
		<br/><br/>
</flow:ifDisabled>
</div>
<br/><br/>
<%@ include file="CheckoutLogonEIExt.jspf"%>
<!-- End - JSP File Name:  CheckoutLogon.jsp -->
