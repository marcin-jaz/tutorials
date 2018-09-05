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

<!-- Start - JSP File Name: StandardBankServACH.jsp -->

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

<c:set var="CheckAccount_number" value="${param.CheckAccount_number}"/>
<c:set var="check_routing_number" value="${param.check_routing_number}"/>
<c:set var="piAmount" value="${param.piAmount}"/>

<div class="card_info" id="WC_StandardBankServACH_div_1">
	<input type="hidden" name="paymentTCId" value="<c:out value="${paymentTCId}"/>" id="WC_StandardBankServACH_inputs_1"/>
	<input type="hidden" id="mandatoryFields_${paymentAreaNumber}" name="mandatoryFields"  value="billing_address_id"/>

	<span class="col1">
		<span>
			<span class="required-field">*</span><label for="BankServACH_FormInput_checkingAccountNumber_1_<c:out value='${paymentAreaNumber}' />"><span><fmt:message key="EDPPaymentMethods_BANK_ACCOUNT_NO" bundle="${storeText}"/></span></label>
		</span>
		<span>
			<c:set var="strCheckAccountNumber" value="${paymentTCInfo.checkingAccountNumber}"/>
			<c:choose>
				<c:when test="${empty strCheckAccountNumber || strCheckAccountNumber==''}">
					<input type="text" style="width:142px" name="checkingAccountNumber"  value="<c:out value="${CheckAccount_number}" />" id="checkingAccountNumber_1_${paymentAreaNumber}" title="<fmt:message key="Checkout_ACCE_required" bundle="${storeText}"/> <fmt:message key="EDPPaymentMethods_BANK_ACCOUNT_NO" bundle="${storeText}"/>" onchange="JavaScript:CheckoutPayments.updatePaymentObject(<c:out value='${paymentAreaNumber}'/>, 'checkingAccountNumber');" />  
				</c:when>
				<c:otherwise>
					<c:out value="${strCheckAccountNumber}"/> <input type="hidden" style="width:142px" name="checkingAccountNumber" value="<c:out value="${strCheckAccountNumber}"/>" id="checkingAccountNumber_2_${paymentAreaNumber}"/>
				</c:otherwise>
			</c:choose>
		</span>

		<span>
			<span class="required-field">*</span><label for="BankServACH_FormInput_checkRoutingNumber_1_<c:out value='${paymentAreaNumber}' />"><span><fmt:message key="EDPPaymentMethods_BANK_ROUTING_NO" bundle="${storeText}"/></span></label>
		</span>
		<span>
			<c:set var="strCheckRoutingNumber" value="${paymentTCInfo.checkRoutingNumber}"/>
			<c:choose>
				<c:when test="${empty strCheckRoutingNumber || strCheckRoutingNumber==''}">
					<input type="text" style="width:142px" name="checkRoutingNumber" value="<c:out value="${check_routing_number}" />" id="checkRoutingNumber_1_${paymentAreaNumber}" title="<fmt:message key="Checkout_ACCE_required" bundle="${storeText}"/> <fmt:message key="EDPPaymentMethods_BANK_ROUTING_NO" bundle="${storeText}"/>" onchange="JavaScript:CheckoutPayments.updatePaymentObject(<c:out value='${paymentAreaNumber}'/>, 'checkRoutingNumber');" /> 
				</c:when>
				<c:otherwise>
					<c:out value="${strCheckRoutingNumber}"/> <input type="hidden" style="width:142px" name="checkRoutingNumber" value="<c:out value="${strCheckRoutingNumber}"/>" id="checkRoutingNumber_2_${paymentAreaNumber}/>
				</c:otherwise>
			</c:choose>
		</span>
	</span>
</div>
<!-- End - JSP File Name: StandardBankServACH.jsp -->
