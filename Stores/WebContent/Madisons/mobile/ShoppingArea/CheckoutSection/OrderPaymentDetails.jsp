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
  * This JSP displays allows the user to select the payment type, and provide
  * payment details for order checkout.
  *****
--%>

<!-- BEGIN OrderPaymentDetails.jsp -->

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>

<%@ include file="../../../include/parameters.jspf" %>
<%@ include file="../../include/JSTLEnvironmentSetup.jspf" %>
<%@ include file="../../include/nocache.jspf" %>
<%@ include file="../../include/ErrorMessageSetup.jspf" %>

<%-- Required variables for breadcrumb support --%>
<c:set var="shoppingcartPageGroup" value="true" scope="request"/>
<c:set var="paymentSelectionPage" value="true" scope="request"/>

<c:set var="storeId" value="${WCParam.storeId}" />
<c:set var="catalogId" value="${WCParam.catalogId}" />

<wcf:getData type="com.ibm.commerce.order.facade.datatypes.OrderType" var="usablePayments" expressionBuilder="findCurrentShoppingCart" scope="request">
	<wcf:param name="accessProfile" value="IBM_UsablePaymentInfo" />
</wcf:getData>

<wcf:getData type="com.ibm.commerce.member.facade.datatypes.PersonType" var="person" expressionBuilder="findCurrentPerson">
	<wcf:param name="accessProfile" value="IBM_All" />
</wcf:getData>

<wcf:getData type="com.ibm.commerce.order.facade.datatypes.OrderType" scope="request" var="order" expressionBuilder="findCurrentShoppingCartWithPagingOnItem" varShowVerb="ShowVerbCart" maxItems="${pageSize}" recordSetStartNumber="0" recordSetReferenceId="ostatus">
	<wcf:param name="accessProfile" value="IBM_Details" />
	<wcf:param name="sortOrderItemBy" value="orderItemID" />
	<wcf:param name="isSummary" value="false" />
</wcf:getData>

<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.2//EN" "http://www.openmobilealliance.org/tech/DTD/xhtml-mobile12.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" lang="${shortLocale}" xml:lang="${shortLocale}">

	<head>
		<title><fmt:message key="PAYMENT_TITLE" bundle="${storeText}"/> - <c:out value="${storeName}"/></title>
		<meta http-equiv="content-type" content="application/xhtml+xml" />
		<meta http-equiv="cache-control" content="max-age=300" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no" />
		<link rel="stylesheet" type="text/css" href="${cssPath}" />
	</head>

	<body>

		<div id="wrapper">
			<%@ include file="../../include/HeaderDisplay.jspf" %>
			<%@ include file="../../include/BreadCrumbTrailDisplay.jspf" %>

			<div id="payment_method" class="content_box">
				<div class="heading_container">
					<h2><fmt:message key="PAYMENT_TITLE" bundle="${storeText}" /></h2>
					<div class="clear_float"></div>
				</div>
				
				<c:if test="${!empty errorMessage}">
					<p class="error"><c:out value="${errorMessage}"/></p>
				</c:if>

				<form name="PromotionCodeForm" method="post" action="PromotionCodeManage" id="PromotionCodeForm" >
					<div id="promotion_code_container">
						<h4><fmt:message key="PROMOTION_CODE_TITLE" bundle="${storeText}" /></h4>
						<p><fmt:message key="ENTER_PROMOTION" bundle="${storeText}" /></p>
						<div id="promotion_codes">

							<wcf:url var="mOrderPaymentDetailsUpdate" value="mOrderPaymentDetails">
								<wcf:param name="langId" value="${langId}" />
								<wcf:param name="storeId" value="${WCParam.storeId}" />
								<wcf:param name="catalogId" value="${WCParam.catalogId}" />
							</wcf:url>

							<label for="promoCode"><fmt:message key="PROMOTION_CODE" bundle="${storeText}" /></label>
							<input type="text" name="promoCode" id="promoCode" size="8" class="coloured_input" />

							<input type="hidden" name="langId" value="${langId}" />
							<input type="hidden" name="storeId" value="${WCParam.storeId}" />
							<input type="hidden" name="catalogId" value="${WCParam.catalogId}" />

							<input type="hidden" name="orderId" value="${order.orderIdentifier.uniqueID}" />
							<input type="hidden" name="taskType" value="A" />
							<input type="hidden" name="URL" value="OrderCalculate?calculationUsageId=-1&URL=${mOrderPaymentDetailsUpdate}" />
							<input type="hidden" name="errorViewName" value="mOrderPaymentDetails" />
							<input type="hidden" name="addressId" value="${WCParam.addressId}" />

							<wcbase:useBean id="promoCodeListBean" classname="com.ibm.commerce.marketing.databeans.PromoCodeListDataBean" scope="page">
								<c:set property="orderId" value="${order.orderIdentifier.uniqueID}" target="${promoCodeListBean}" />
							</wcbase:useBean>

							<ul>							
								<c:forEach var="promotionCode" items="${promoCodeListBean.codes}" varStatus="status">
									<wcf:url var="RemovePromotionCode" value="PromotionCodeManage">
										<wcf:param name="orderId" value="${order.orderIdentifier.uniqueID}" />
										<wcf:param name="taskType" value="R" />
										<wcf:param name="URL" value="OrderCalculate?calculationUsageId=-1&URL=${mOrderPaymentDetailsUpdate}" />
										<wcf:param name="promoCode" value="${promotionCode.code}" />
										<wcf:param name="errorViewName" value="mOrderPaymentDetails" />
										<wcf:param name="addressId" value="${WCParam.addressId}" />
									</wcf:url>
									<li>
										<span class="bullet">&#187; </span><a href="${fn:escapeXml(RemovePromotionCode)}" title="<fmt:message key="WISHLIST_REMOVE" bundle="${storeText}" />">
										<fmt:message key="WISHLIST_REMOVE" bundle="${storeText}" />&nbsp;<c:out value="${promotionCode.code}" /></a>
									</li>
								</c:forEach>
							</ul>
						</div>

					</div>

					<div id="shopping_cart_costs">
						<dl>							
							<dt><fmt:message key="ORDER_SUBTOTAL" bundle="${storeText}" /></dt>
							<dd><fmt:formatNumber type="currency" maxFractionDigits="${currencyDecimal}" currencySymbol="${currencyFormatterDB.currencySymbol}" value="${order.orderAmount.totalProductPrice.value}" /></dd>

							<dt><fmt:message key="DISCOUNT" bundle="${storeText}" /></dt>
							<dd><fmt:formatNumber type="currency" maxFractionDigits="${currencyDecimal}" currencySymbol="${currencyFormatterDB.currencySymbol}" value="${order.orderAmount.totalAdjustment.value}" /></dd>

							<dt class="bold"><fmt:message key="ORDER_TOTAL" bundle="${storeText}" /></dt>
							<dd class="bold"><fmt:formatNumber type="currency" maxFractionDigits="${currencyDecimal}" currencySymbol="${currencyFormatterDB.currencySymbol}" value="${order.orderAmount.grandTotal.value}" /></dd>
						</dl>
						<div class="clear_float"></div>

						<input type="submit" name="update_order_total" id="update_order_total" value="<fmt:message key="UPDATE_ORDER_TOTAL" bundle="${storeText}" />" />
					</div>
				</form>

				<div id="payment_method_selection_div">

					<wcf:url var="orderSummary" value="mOrderShippingBillingSummaryView">
						<wcf:param name="langId" value="${langId}" />
						<wcf:param name="storeId" value="${WCParam.storeId}" />
						<wcf:param name="catalogId" value="${WCParam.catalogId}" />
					</wcf:url>

					<%-- Remove existing payment methods, since we will only support 1 payment method. --%>

					<c:set var="existingPayments" value="false"/>
					<wcf:url var="deleteExistingPayments" value="OrderChangeServicePIDelete">
						<wcf:param name="URL" value="${orderSummary}" />
						<c:forEach var="paymentInstance" items="${order.orderPaymentInfo.paymentInstruction}" varStatus="paymentCount">
							<c:set var="existingPayments" value="true"/>
							<wcf:param name="piId" value="${paymentInstance.uniqueID}" />
						</c:forEach>			
						<wcf:param name="authToken" value="${authToken}" />
					</wcf:url>

					<c:set var="nextURL" value="${orderSummary}" />
					<c:if test="${existingPayments}">
						<c:set var="nextURL" value="${deleteExistingPayments}" />
					</c:if>

					<form id="payment_method_selection">
						<fieldset>
							<legend><fmt:message key="PAYMENT_METHOD" bundle="${storeText}" /></legend>

							<wcbase:useBean id="paymentPolicyListDataBean" classname="com.ibm.commerce.payment.beans.PaymentPolicyListDataBean" scope="page">
								<c:set property="storeId" value="${WCParam.storeId}" target="${paymentPolicyListDataBean}"/>
							</wcbase:useBean>

							<%-- Enable Pay in store payment type --%>							
							
							<c:forEach items="${paymentPolicyListDataBean.paymentPolicyInfoUsableWithoutTA}" var="paymentPolicyInfo" varStatus="status">
								<c:if test="${ !empty paymentPolicyInfo.attrPageName }" >
									<c:if test="${paymentPolicyInfo.attrPageName == 'StandardPayLater'}">
										<div class="radio_container"><input type="radio" checked id="${paymentPolicyInfo.policyName}" name="payMethodId_radio" value="${paymentPolicyInfo.policyName}" /> <label for="${paymentPolicyInfo.policyName}"><fmt:message key="PAY_IN_STORE" bundle="${storeText}" /></label></div>
									</c:if>
								</c:if>
							</c:forEach>

							<%-- Enable credit card payment types --%>
							
							<div class="radio_container"><input type="radio" id="credit_card" name="payMethodId_radio" value="credit_card" /> <label for="credit_card"><fmt:message key="CREDIT_CARD" bundle="${storeText}" /></label></div> 
						</fieldset>
					</form>

					<%-- Pay in store form.  Must seperate into different forms because empty credit card inputs will treated as errors --%>					
					
					<form id="payment_method_form_payinstore" action="OrderChangeServicePIAdd">
						<fieldset>
							<wcf:url var="orderSummary" value="mOrderShippingBillingSummaryView">
								<wcf:param name="langId" value="${langId}" />
								<wcf:param name="storeId" value="${WCParam.storeId}" />
								<wcf:param name="catalogId" value="${WCParam.catalogId}" />								
							</wcf:url>

							<input type="hidden" name="langId" value="${langId}" />
							<input type="hidden" name="storeId" value="${WCParam.storeId}" />
							<input type="hidden" name="catalogId" value="${WCParam.catalogId}" />

							<input type="hidden" name="payMethodId" value="" id="payMethodId_payinstore" />
							<input type="hidden" name="URL" value="${nextURL}"/>
							<input type="hidden" name="piAmount" value="${order.orderAmount.grandTotal.value}"/>
							<input type="hidden" name="billing_address_id" value="${WCParam.addressId}"/>
							<input type="hidden" name="addressId" value="${WCParam.addressId}"/>
							<input type="hidden" name="errorViewName" value="mOrderPaymentDetails"/>
							<input type="hidden" name="authToken" value="${authToken}"/>

						</fieldset>
					</form>

					<%-- Credit card form.  Must seperate into multiple forms because empty credit card inputs will be treated as errors --%>					
					
					<form id="payment_method_form_creditcard" action="OrderChangeServicePIAdd">
						<fieldset>
							<div class="dropdown_container">
								<div><label for="card_type"><fmt:message key="CARD_TYPE" bundle="${storeText}" /></label></div>
								<select id="card_type" class="coloured_input" name="cc_brand">
									<option>Please select</option>
									<c:forEach items="${paymentPolicyListDataBean.paymentPolicyInfoUsableWithoutTA}" var="paymentPolicyInfo" varStatus="status">
										<c:if test="${ !empty paymentPolicyInfo.attrPageName }" >
											<c:if test="${paymentPolicyInfo.attrPageName == 'StandardVisa' || paymentPolicyInfo.attrPageName == 'StandardMasterCard' || paymentPolicyInfo.attrPageName == 'StandardAmex'}">
												<option value="${paymentPolicyInfo.policyName}"><c:out value="${paymentPolicyInfo.shortDescription}" /></option>
											</c:if>
										</c:if>
									</c:forEach>
								</select>
							</div>

							<div class="input_container">
								<div><label for="card_number"><fmt:message key="CARD_NUMBER" bundle="${storeText}" /></label></div>
								<input type="text" id="card_number" name="account" class="coloured_input" />
							</div>

							<jsp:useBean id="now1" class="java.util.Date"/>
							<div class="dropdown_container">
								<div class="column">
									<div><label for="card_month"><fmt:message key="MONTH" bundle="${storeText}" /></label></div>
									<select id="card_month" class="coloured_input" name="expire_month">
										<option value="01">01</option>
										<option value="02">02</option>
										<option value="03">03</option>
										<option value="04">04</option>
										<option value="05">05</option>
										<option value="06">06</option>
										<option value="07">07</option>
										<option value="08">08</option>
										<option value="09">09</option>
										<option value="10">10</option>
										<option value="11">11</option>
										<option value="12">12</option>
									</select>
								</div>

								<div>
									<div><label for="card_year"><fmt:message key="YEAR" bundle="${storeText}" /></label></div>
									<select id="card_year" class="coloured_input" name="expire_year">
										<c:forEach begin="0" end="10" varStatus="counter">
											<option value="${now1.year + 1900 + counter.index}">${now1.year + 1900 + counter.index}</option>
										</c:forEach>
									</select>
								</div>

								<div class="clear_float"></div>
							</div>

							<div class="input_container">
								<div><label for="cvc_number"><fmt:message key="CCV2_NUMBER" bundle="${storeText}" /></label></div>
								<input type="text" id="cvc_number" name="cc_cvc" class="coloured_input" />
							</div>

							<input type="hidden" name="langId" value="${langId}" />
							<input type="hidden" name="storeId" value="${WCParam.storeId}" />
							<input type="hidden" name="catalogId" value="${WCParam.catalogId}" />

							<input type="hidden" name="payMethodId" value="" id="payMethodId_creditcard" />
							<input type="hidden" name="URL" value="${nextURL}"/>
							<input type="hidden" name="piAmount" value="${order.orderAmount.grandTotal.value}"/>
							<input type="hidden" name="billing_address_id" value="${WCParam.addressId}"/>
							<input type="hidden" name="addressId" value="${WCParam.addressId}"/>
							<input type="hidden" name="errorViewName" value="mOrderPaymentDetails"/>
							<input type="hidden" name="authToken" value="${authToken}"/>

							<input type="button" name="proceed_to_checkout" id="proceed_to_checkout" onclick="submitPaymentInfo();" value="<fmt:message key="CONTINUE_CHECKOUT" bundle="${storeText}" />" />
						</fieldset>
					</form>
				</div>

			</div>

			<%@ include file="../../include/FooterDisplay.jspf" %>
		</div>

	<script type="text/javascript">
		function submitPaymentInfo() {
			var paymentMethods = document.getElementsByName('payMethodId_radio');
			for(var i = 0; i < paymentMethods.length; i++) {
				if(paymentMethods[i].checked) {
					if(paymentMethods[i].value == "credit_card") {						
						document.getElementById("payMethodId_creditcard").value = document.getElementById("card_type").value;
						document.getElementById("payment_method_form_creditcard").submit();
					}
					else {
						document.getElementById("payMethodId_payinstore").value = paymentMethods[i].value;
						document.getElementById("payment_method_form_payinstore").submit();
					}
				}
			}
		}
	
	
	//<![CDATA[

 
	//]]> 
	</script>


	</body>
</html>

<!-- END OrderPaymentDetails.jsp -->
