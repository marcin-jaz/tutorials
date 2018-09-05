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

<!-- Start - JSP File Name: StandardCheck.jsp -->

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
<c:set var="paymentTCId" value="${param.paymentTCId}"/>

<c:set var="account" value="${param.account}"/>
<c:set var="check_routing_number" value="${param.check_routing_number}"/>
<c:set var="piAmount" value="${param.piAmount}"/>

<div class="card_info" id="WC_StandardCheck_div_1">

	<input type="hidden" name="paymentTCId" value="<c:out value="${paymentTCId}"/>" id="WC_StandardCheck_inputs_1"/>
	<input type="hidden" id="mandatoryFields_${paymentAreaNumber}" name="mandatoryFields"  value="check_routing_number_${paymentAreaNumber},CheckAccount_${paymentAreaNumber},billing_address_id"/>

	<span class="col1">
		<span>
			<label for="check_routing_number_<c:out value='${paymentAreaNumber}' />"><span class="required-field">*</span><fmt:message key="EDPPaymentMethods_BANK_ROUTING_NO" bundle="${storeText}"/></label>
		</span><br />
		<span>
			<input type="text" name="check_routing_number" value="<c:out value="${check_routing_number}" />" id="check_routing_number_${paymentAreaNumber}" title="<fmt:message key="Checkout_ACCE_required" bundle="${storeText}"/> <fmt:message key="EDPPaymentMethods_BANK_ROUTING_NO" bundle="${storeText}"/>" onchange="JavaScript:CheckoutPayments.updatePaymentObject(<c:out value='${paymentAreaNumber}'/>, 'check_routing_number');"/>
		</span><br />
		<span>
			<label for="CheckAccount_<c:out value='${paymentAreaNumber}' />"><span class="required-field">*</span><fmt:message key="EDPPaymentMethods_BANK_ACCOUNT_NO" bundle="${storeText}" /></label>
		</span><br />
		<span>
			<input type="text" name="account" value ="<c:out value="${account}" />" id="CheckAccount_<c:out value='${paymentAreaNumber}' />" title="<fmt:message key="Checkout_ACCE_required" bundle="${storeText}"/> <fmt:message key="EDPPaymentMethods_BANK_ACCOUNT_NO" bundle="${storeText}"/>" onchange="JavaScript:CheckoutPayments.updatePaymentObject(<c:out value='${paymentAreaNumber}'/>, 'account');"/>
		</span><br />
		<%--
		***************************
		* Start: Show the remaining amount -- the amount not yet allocated to a payment method
		***************************
		--%>
		<%@ include file="PaymentAmount.jspf"%>
	</span>
</div>
<!-- End - JSP File Name: StandardCheck.jsp -->
