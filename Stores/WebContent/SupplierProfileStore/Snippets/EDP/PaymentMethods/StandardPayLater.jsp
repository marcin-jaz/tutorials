<%
//********************************************************************
//*-------------------------------------------------------------------
//* Licensed Materials - Property of IBM
//*
//* WebSphere Commerce 
//*
//* (c) Copyright IBM Corp. 2005
//*
//* US Government Users Restricted Rights - Use, duplication or
//* disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
//*
//*-------------------------------------------------------------------
//*
//*---------------------------------------------------------------------
//* The sample contained herein is provided to you "AS IS".
//*
//* It is furnished by IBM as a simple example and has not been  
//* thoroughly tested
//* under all conditions.  IBM, therefore, cannot guarantee its 
//* reliability, serviceability or functionality.  
//*
//* This sample may include the names of individuals, companies, brands 
//* and products in order to illustrate concepts as completely as 
//* possible.  All of these names
//* are fictitious and any similarity to the names and addresses used by 
//* actual persons 
//* or business enterprises is entirely coincidental.
//*---------------------------------------------------------------------
//*
%>
<%-- 
  ***
  * This Jsp snippet displays
  *	- the protocol data fields for the payment method PayLater
  *	- a list of usable billing address for this payment method
  *
  * Parameters:
  * 
  * -inputPrefix
  * This value is the prefix of the input fields.
  * 
  * -paymentTCId
  *	This value is the identifier of the payment TC for the payment method. 
  * 
  * -showPONumber
  * The flag to indicate if the input field for the purchase order should be displayed.
  * 
  * -hideAmounts
  * The flag to indicate if the input field for the amount should be displayed
  *
  * -hideRemainingAmount
  * This flag indicates whether the input field for the remaining amount should be displayed.
  * 
  * How to use this snippet?
  * 1. This snippet is available under the <WC-Install Dir>\samples\Snippets\web\EDP\PaymentMethods\
  * 2. You can use this snippet in your xxx.jsp in the following 2-ways
  *		A. copy and paste the entire code in your xxx.jsp
  *		B. do import 
  *				<c:import url="${snippetJspStoreDir}Snippets/EDP/PaymentMethods/StandardPayLater.jsp" >
  *					<c:param name="paymentTCId" value="${edp_Info.TCId}" />
  *					<c:param name="showPONumber" value="${showPONumber}" />
  *				</c:import>
  ****	 		
--%>

<!-- Start - JSP File Name: StandardPayLater.jsp -->

<!-- Set the taglib -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%-- Include the EDP environment setup snippet --%>
<%@ include file="../EDPEnvironmentSetup.jspf"%>

<c:set var="paramNumStatus" value="${param.paramNumStatus}" />

<%-- Get the parameter for the payment TC Id --%>
<c:set var="paymentTCId" value="${param.paymentTCId}" />
<c:if test="${empty paymentTCId}" >
	<c:set var="paymentTCId" value="${edp_ProtocolData.paymentTCId}" />
</c:if>
<c:if test="${param.showPONumber}">
	<c:set var="showPONumber" value="true"/>
</c:if>
<c:if test="${param.hideRemainingAmount}">
	<c:set var="hideRemainingAmount" value="true"/>
</c:if>

<%-- The section to collect the protocol data for this payment method --%>
<table cellpadding="3" cellspacing="0" border="0" id="StandardPayLater_Table_1_<c:out value='${paramNumStatus}' />">
	<c:if test="${!hideRemainingAmount}">
	<tr>
		<%--
		***************************
		* Start: Show the remaining amount -- the amount not yet allocated to a payment method
		***************************
		--%>
		<td id="StandardPayLater_TableCell_1_<c:out value='${paramNumStatus}' />">
			<label for="OrderRemainingAmount_<c:out value='${paramNumStatus}' />"><fmt:message key="EDPPaymentMethods_PAYMENT_AMT_REMAINING" bundle="${edpText}"/></label>
		</td>
	</tr>
	<tr>
		<td id="StandardPayLater_TableCell_2_<c:out value='${paramNumStatus}' />">
			<input <c:if test="${remainingAmt lt 0.0}"> class="error" </c:if>
				class="input" type="text" name="remainingAmount" id="OrderRemainingAmount_<c:out value='${paramNumStatus}' />" readonly="readonly" value="<c:out value="${remainingAmt}"/>" />
		</td>
	</tr>
	</c:if>
	<tr>
		<td  valign="middle" id="StandardPayLater_TableCell_3_<c:out value='${paramNumStatus}' />">
			<label for="StandardPayLater_InputText_3_<c:out value='${paramNumStatus}' />">
				<span class="required">*</span>
				<fmt:message key="EDPPaymentMethods_PAYMENT_AMOUNT" bundle="${edpText}" />
			</label>
		</td>
	</tr>
	<tr>
		<td  valign="middle" id="StandardPayLater_TableCell_4_<c:out value='${paramNumStatus}' />">
			<input class="input" type="text" name="piAmount" value="<c:out value="${edp_PayMethodAmount}" />" id="StandardPayLater_InputText_3_<c:out value='${paramNumStatus}' />" />
			<input type="hidden" name="paymentTCId" value="<c:out value="${paymentTCId}"/>" />
			<c:if test="${showPONumber}">
				<input type="hidden" name = "purchaseorder_id" value ="<c:out value="${edp_ProtocolData.purchaseorder_id}" />" id="StandardPayLater_InputText_1_<c:out value='${paramNumStatus}' />" />
			</c:if>
		</td>
	</tr>

	<%-- load billing address dropdown box from a seperate page --%>
	<tr>
		<td  valign="middle" id="StandardPayLater_TableCell_6_<c:out value='${paramNumStatus}' />">
			<c:import  url="${billingAddressSelectListPath}" >
				<c:param name="billingParmName" value="StandardPayLater_billing_address_id_${paramNumStatus}" />
				<c:param name="paymentTCId" value="${paymentTCId}" />
			</c:import> 
		</td>
	</tr>
	
	
</table>


<!-- End - JSP File Name: StandardPayLater.jsp -->
