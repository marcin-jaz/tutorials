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
  ***
  * 
  ***
--%>

<!-- Start - JSP File Name: StandardAmex.jsp -->

<!-- Set the taglib -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf"%>

<c:set var="paymentAreaNumber" value="${WCParam.currentPaymentArea}"/>
<c:if test="${empty paymentAreaNumber}">
	<c:set var="paymentAreaNumber" value="${param.paymentAreaNumber}" />
</c:if>

<%-- Set the default value(current month + 1) of expire_month for this payment method --%>
<jsp:useBean id="now" class="java.util.Date"/>


<c:set var="expire_year" value="${param.expire_year}"/>
<c:set var="expire_month" value="${param.expire_month}"/>
<c:set var="account" value="${param.account}"/>
<c:set var="unmaskedAccount" value="${param.account}"/>
<c:set var="cc_cvc" value="${param.cc_cvc}"/>
<c:set var="piAmount" value="${param.piAmount}"/>
<c:set var="quickCheckoutProfileForPayment" value="${param.quickCheckoutProfileForPayment}"/>

<c:if test="${empty quickCheckoutProfileForPayment}" >
<c:set var="quickCheckoutProfileForPayment" value="${WCParam.quickCheckoutProfileForPayment}"/>
</c:if>


<c:set var="paymentTCId" value="${param.paymentTCId}"/>
<c:if test="${!empty paymentTCId}" >
<wcbase:useBean id="paymentTCbean" classname="com.ibm.commerce.contract.beans.PaymentTCDataBean">
       <c:set target="${paymentTCbean}" property="dataBeanKeyReferenceNumber" value="${paymentTCId}"/>
</wcbase:useBean>

   	<c:forEach var="pAttrValue" items="${paymentTCbean.PAttrValues}">
       <c:remove var="attribute"/>
       <wcbase:useBean id="attribute" classname="com.ibm.commerce.utf.beans.PAttributeDataBean">
          <c:set target="${attribute}" property="initKey_referenceNumber" value="${pAttrValue.attributeId}"/>
       </wcbase:useBean>
   	   <c:if test="${attribute.name eq 'account'}">
            <c:if test="${!empty pAttrValue.PAttrValue}">
              <c:set var="valueFromPaymentTC" value="true" />
			  <c:set var="unmaskedAccount" value="${pAttrValue.PAttrValue}"/>
              <wcbase:useBean id = "edpMaskBean" classname="com.ibm.commerce.edp.beans.EDPSensitiveDataMaskHelperDataBean">
              	<c:set target="${edpMaskBean}" property="plainString" value="${pAttrValue.PAttrValue}"/>
              </wcbase:useBean>
   		      <c:set var="account" value="${edpMaskBean.maskedString}" />
            </c:if>
            <c:if test="${empty pAttrValue.PAttrValue}">
	          <c:set var="account" value="" />
            </c:if>
       </c:if>
	   <c:if test="${attribute.name eq 'expire_year'}">
		<c:set var="expire_year" value="${pAttrValue.PAttrValue}"/>
	   </c:if>
	   <c:if test="${attribute.name eq 'expire_month'}">
		<c:set var="expire_month" value="${pAttrValue.PAttrValue}"/>
	   </c:if>
    </c:forEach>
</c:if>
<c:if test="${empty expire_month}">
	<c:set var="expire_month" value="${now.month + 1}"/>
</c:if>
<c:if test="${empty expire_year}">
	<c:set var="expire_year" value="${now.year + 1900}"/>
</c:if>

<%-- Set the default value("Amex") of cc_brand for this payment method --%>
<c:if test="${empty cc_brand}">
	<c:set var="cc_brand" value="Amex"/>
</c:if>

<%-- The section to collect the protocol data for this payment method --%>
<div class="card_info" id="WC_StandardAmex_div_1">
	<c:choose>
		<c:when test="${valueFromPaymentTC == 'true'}" >
			<input type="hidden" name="valueFromPaymentTC" value="true" />
		</c:when>
		<c:when test="${quickCheckoutProfileForPayment}" >
			<input type="hidden" name="valueFromProfileOrder" value="Y" />
		</c:when>
	</c:choose>
	<c:set var="accountValue" value="${account}"/>
	<input type="hidden" name="cc_brand" value="<c:out value="${cc_brand}" />" id="WC_StandardAmex_inputs_1"/>
	<input type="hidden" name="paymentTCId" value="<c:out value="${paymentTCId}"/>" id="WC_StandardAmex_inputs_2"/>
	<input type="hidden" name="account" id="account_${paymentAreaNumber}" value="<c:out value="${accountValue}"/>" />
	<input type="hidden" id="mandatoryFields_${paymentAreaNumber}" name="mandatoryFields"  value="account_${paymentAreaNumber},expire_month_${paymentAreaNumber},expire_year_${paymentAreaNumber},billing_address_id"/>

	<span class="col1">
		<span class="card_number">
			<span>
				<label for="edp_Amex_account_<c:out value='${paymentAreaNumber}' />"><span class="required-field">*</span><fmt:message key="EDPPaymentMethods_AMEX_CARD_NUMBER" bundle="${storeText}"/></label>
			</span>
			<span>
				<input onchange="JavaScript:CheckoutPayments.removeCreditCardNumberAndCVV(<c:out value='${paymentAreaNumber}'/>, false, true);CheckoutHelperJS.paymentDataDirty(<c:out value='${paymentAreaNumber}'/>, true);CheckoutPayments.updatePaymentObject(<c:out value='${paymentAreaNumber}'/>, 'account');"" type="text" name="account1" style="width:142px" value="<c:out value="${accountValue}"/>" id="account1_${paymentAreaNumber}" title="<fmt:message key="Checkout_ACCE_required" bundle="${storeText}"/> <fmt:message key="EDPPaymentMethods_AMEX_CARD_NUMBER" bundle="${storeText}"/>" />
			</span>
		</span>	
		<span>
			<label for="cc_cvc_${paymentAreaNumber}"><fmt:message key="EDPPaymentMethods_CVV" bundle="${storeText}"/></label>
		</span><br />
		<input type="text" onchange="JavaScript:CheckoutPayments.removeCreditCardNumberAndCVV(<c:out value='${paymentAreaNumber}'/>, true, false);CheckoutHelperJS.paymentDataDirty(<c:out value='${paymentAreaNumber}'/>, true);CheckoutPayments.updatePaymentObject(<c:out value='${paymentAreaNumber}'/>, 'cc_cvc');" name="cc_cvc" size="4" value="<c:out value='${cc_cvc}' />" id="cc_cvc_${paymentAreaNumber}"/>
		<span class="visaCVV2">
			<span id="CVVDetailsSection">					
				<span id="StandardAmex_CVVDetails_${paymentAreaNumber}" class="order_link" tabindex="0"><fmt:message key="EDPPaymentMethods_CVV_WHAT_IS" bundle="${storeText}"/></span>
				<span id="StandardAmex_CVVDetails_${paymentAreaNumber}_span_2" dojoType="wc.widget.Tooltip" connectId="StandardAmex_CVVDetails_${paymentAreaNumber}" style="display: none;">
					<div id="tooltip_popup">
						<div id="WC_StandardAmex_div_2_${paymentAreaNumber}" class="header">
							<div id="WC_StandardAmex_div_3_${paymentAreaNumber}" class="close">
								<fmt:message key="EDPPaymentMethods_CVV_WHAT_IS" bundle="${storeText}"/>
							</div>
						</div>
						<div id="WC_StandardAmex_div_4_${paymentAreaNumber}" class="bodyarea">
							<div id="WC_StandardAmex_div_5_${paymentAreaNumber}" class="bodycontent">
								<fmt:message key="EDPPaymentMethods_CVV_DEFINITION" bundle="${storeText}"/>
							</div>
						</div>
						<div id="WC_StandardAmex_div_6_${paymentAreaNumber}" class="footer"></div>
						<!--[if lte IE 6.5]><iframe class="cvv2IFrame" scrolling="no" frameborder="0" src="<c:out value="${jspStoreImgDir}" />images/empty.gif"></iframe><![endif]-->
					</div>
				</span>
				<script type="text/javascript">dojo.addOnLoad(function() {parseWidget("StandardAmex_CVVDetails_${paymentAreaNumber}_span_2"); });</script>
			</span>
		</span>
		<span class="date">
			<span class="month_year"><label for="expire_month_${paymentAreaNumber}"><fmt:message key="MONTH" bundle="${storeText}"/></label>:<br />
				<select onchange="JavaScript:CheckoutPayments.removeCreditCardNumberAndCVV(<c:out value='${paymentAreaNumber}'/>, true, true);CheckoutHelperJS.paymentDataDirty(<c:out value='${paymentAreaNumber}'/>, true);CheckoutPayments.updatePaymentObject(<c:out value='${paymentAreaNumber}'/>, 'expire_month');" class="drop_down" name="expire_month" id="expire_month_${paymentAreaNumber}">
					<option
					<c:if test="${expire_month == 1 || expire_month == '01'}" > selected="selected" </c:if>
					value="01">01</option>
					<option
					<c:if test="${expire_month == 2 || expire_month == '02'}" > selected="selected" </c:if>
					value="02">02</option>
					<option
					<c:if test="${expire_month == 3 || expire_month == '03'}" > selected="selected" </c:if>
					value="03">03</option>
					<option
					<c:if test="${expire_month == 4 || expire_month == '04'}" > selected="selected" </c:if>
					value="04">04</option>
					<option
					<c:if test="${expire_month == 5 || expire_month == '05'}" > selected="selected" </c:if>
					value="05">05</option>
					<option
					<c:if test="${expire_month == 6 || expire_month == '06'}" > selected="selected" </c:if>
					value="06">06</option>
					<option
					<c:if test="${expire_month == 7 || expire_month == '07'}" > selected="selected" </c:if>
					value="07">07</option>
					<option
					<c:if test="${expire_month == 8 || expire_month == '08'}" > selected="selected" </c:if>
					value="08">08</option>
					<option
					<c:if test="${expire_month == 9 || expire_month == '09'}" > selected="selected" </c:if>
					value="09">09</option>
					<option
					<c:if test="${expire_month == 10 }" > selected="selected" </c:if>
					value="10">10</option>
					<option
					<c:if test="${expire_month == 11 }" > selected="selected" </c:if>
					value="11">11</option>
					<option
					<c:if test="${expire_month == 12 }" > selected="selected" </c:if>
					value="12">12</option>
				</select>
			</span>
			<span><label for="expire_year_${paymentAreaNumber}"><fmt:message key="YEAR" bundle="${storeText}"/></label>:<br />
				<select onchange="JavaScript:CheckoutPayments.removeCreditCardNumberAndCVV(<c:out value='${paymentAreaNumber}'/>, true, true);CheckoutHelperJS.paymentDataDirty(<c:out value='${paymentAreaNumber}'/>, true);CheckoutPayments.updatePaymentObject(<c:out value='${paymentAreaNumber}'/>, 'expire_year');" class="drop_down" name="expire_year" id="expire_year_${paymentAreaNumber}">
					<c:set var="current_year" value="${now.year + 1900}"/>
					<c:forEach begin="0" end="10" varStatus="counter">
						<option
						<c:if test="${expire_year == current_year+counter.index }" > selected="selected" </c:if>
						value="${current_year+counter.index}">${current_year+counter.index}</option>
					</c:forEach>
				</select>
			</span>
		</span>
		<%--
		***************************
		* Start: Show the remaining amount -- the amount not yet allocated to a payment method
		***************************
		--%>
		<%@ include file="PaymentAmount.jspf"%>
	</span>	
</div>
<!-- End - JSP File Name: StandardAmex.jsp -->
