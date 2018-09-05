<%--
//********************************************************************
//*-------------------------------------------------------------------
//* Licensed Materials - Property of IBM
//*
//* WebSphere Commerce
//*
//* (c) Copyright IBM Corp. 2007
//* All Rights Reserved
//*
//* US Government Users Restricted Rights - Use, duplication or
//* disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
//*
//*-------------------------------------------------------------------
//*
--%>
<%-- 
  ***
  * This JSP shows all the required parameters for a payment using pay in store.
  * It is meant to be used in the single page checkout.
  *
  * It is basically just asking for the payment amount and the billing address.
  ***
--%>

<!-- Start - JSP File Name: Offline.jsp -->

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

<div class="card_info" id="WC_PayInStore_div_1">

	<%-- The section to collect the protocol data for this payment method --%>
	<input type="hidden" name="paymentTCId" value="<c:out value="${paymentTCId}"/>" id="WC_PayInStore_inputs_1"/>
	<input type="hidden" id="mandatoryFields_${paymentAreaNumber}" name="mandatoryFields"  value=""/>

	<span class="col1">

		<%--
		***************************
		* Start: Show the remaining amount -- the amount not yet allocated to a payment method
		***************************
		--%>
		<%@ include file="PaymentAmount.jspf"%>
	</span>
</div>

<!-- End - JSP File Name: Offline.jsp -->
