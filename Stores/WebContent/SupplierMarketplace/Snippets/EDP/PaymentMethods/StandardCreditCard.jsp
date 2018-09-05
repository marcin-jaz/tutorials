<!-- BEGIN StandardCreditCard.jsp -->
<!-- This is StandardCreditCard.jsp, a JSP fragment, and should not have <html> or <body> tags -->
<!-- The DOCTYPE tag is commented out because this is a JSP fragment -->
<!-- <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"> -->
<%
/*
 *-------------------------------------------------------------------
 * Licensed Materials - Property of IBM
 *
 * WebSphere Commerce
 *
 * (c) Copyright International Business Machines Corporation. 2001, 2004
 *     All rights reserved.
 *
 * US Government Users Restricted Rights - Use, duplication or
 * disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
 *
 *-------------------------------------------------------------------
 */
%>
<%-- 
  *****
  * This JSP page lets a customer input the following payment information:
  *  - Credit card number
  *  - Month of expiry
  *  - Year of expiry
  *****
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>

<%-- Include the EDP environment setup snippet --%>
<%@ include file="../EDPEnvironmentSetup.jspf"%>

<c:set var="paramNumStatus" value="${param.paramNumStatus}" />

<%-- Get the parameter for the payment TC Id, if the payment TC is not empty, the protocol data will be retrieved from the payment TC --%>

<input type="hidden" name="payment_reset" value="false" id="<c:out value='${edp_PI_Form}' />_payment_reset" />
<script type="text/javascript" language="javascript">
	var <c:out value='${edp_PI_Form}' />_elementArray = new Array()
</script>

<c:set var="paymentTCId" value="${param.paymentTCId}" />

<%-- If the paymentTCId parameter is not passed in, the protocol data will be retrieved from the edp_ProtocolData databean --%>
<c:if test="${empty paymentTCId}" >
	<c:set var="paymentTCId" value="${edp_ProtocolData.paymentTCId}" />
    <c:set var="account" value="${edp_ProtocolData.cardNumber}" />
    <c:set var="expire_month" value="${edp_ProtocolData.cardExpiryMonth + 0}" />
    <c:set var="expire_year" value="${edp_ProtocolData.cardExpiryYear + 0}" />
</c:if>

<c:if test="${!empty param.currentBillingAddress}">
	<c:set var="currentBillingAddress" value="${param.currentBillingAddress}"/>
</c:if>

<%-- Set the default value(current month + 1) of expire_month for this payment method --%>
<jsp:useBean id="now" class="java.util.Date"/>

<c:if test="${expire_month == 0}">
	<c:set var="expire_month" value="${now.month + 1}"/>
</c:if>

<c:if test="${expire_year == 0}">
	<c:set var="expire_year" value="${now.year + 1900}"/>
</c:if>


<table cellpadding="3" cellspacing="0" border="0" id="StandardCreditCard_Table_1_<c:out value='${paramNumStatus}' />">

<input type="hidden" name="cardBrand" value="<c:out value="${paymentTCInfo.brand}"/>" id="WC_StandardCreditCard_FormInput_cardBrand_1_<c:out value='${paramNumStatus}' />"/>
<input type="hidden" name="piAmount" value="<c:out value="${edp_OrderTotalAmount}" />"	id="WC_StandardCreditCard_FormInput_piAmount_1_<c:out value='${paramNumStatus}' />" />
<tr>
  <td  valign="middle" id="WC_StandardCreditCard_TableCell_4_<c:out value='${paramNumStatus}' />"><span class="reqd">*</span><fmt:message key="EDPPaymentMethods_AMEX_CARD_NUMBER" bundle="${edpText}"/></td>
  <td  valign="middle" id="WC_StandardCreditCard_TableCell_5_<c:out value='${paramNumStatus}' />">&nbsp;</td>
  <td  valign="middle" id="WC_StandardCreditCard_TableCell_6_<c:out value='${paramNumStatus}' />"> 
<c:set var="strCardNumber" value="${paymentTCInfo.cardNumber}"/>
<c:choose>
	<c:when test="${empty strCardNumber || strCardNumber==''}">
		<label for="WC_StandardCreditCard_FormInput_cardNumber_1_<c:out value='${paramNumStatus}' />"></label>
	<input type="text" size="20" name="cardNumber"  value="<c:out value="${account}" />" id="WC_StandardCreditCard_FormInput_cardNumber_1_<c:out value='${paramNumStatus}' />"
		onchange="javascript:<c:out value='${edp_PI_Form}' />_changed('cardNumber')" /> 
	</c:when>
	<c:otherwise>
		<c:out value="${strCardNumber}"/> <input type="hidden" size="20" name="cardNumber" value="<c:out value="${strCardNumber}"/>" id="WC_StandardCreditCard_FormInput_cardNumber_2_<c:out value='${paramNumStatus}' />"/>
	</c:otherwise>
</c:choose>
</td>
</tr>
<tr>
  <td  valign="middle" id="WC_StandardCreditCard_TableCell_7_<c:out value='${paramNumStatus}' />"><span class="reqd">*</span><label for="WC_StandardCreditCard_FormInput_cardExpiryMonth_1_<c:out value='${paramNumStatus}' />"><fmt:message key="EDPPaymentMethods_AMEX_EXPIRATION_MONTH" bundle="${edpText}"/></label></td>
  <td  valign="middle" id="WC_StandardCreditCard_TableCell_8_<c:out value='${paramNumStatus}' />"></td>
  <td  valign="middle" id="WC_StandardCreditCard_TableCell_9_<c:out value='${paramNumStatus}' />"> 
<c:set var="strCardExpiryMonth" value="${paymentTCInfo.cardExpiryMonth}"/>
<c:choose>
	<c:when test="${empty strCardExpiryMonth || strCardExpiryMonth==''}">
		<select id="WC_StandardCreditCard_FormInput_cardExpiryMonth_1_<c:out value='${paramNumStatus}' />" name="cardExpiryMonth" size="1" onchange="javascript:<c:out value='${edp_PI_Form}' />_changed('cardExpiryMonth')" >
			<option
				<c:if test="${expire_month == 1 }" > selected="selected" </c:if>
				value="01">01</option>
			<option
				<c:if test="${expire_month == 2 }" > selected="selected" </c:if>
				value="02">02</option>
			<option
				<c:if test="${expire_month == 3 }" > selected="selected" </c:if>
				value="03">03</option>
			<option
				<c:if test="${expire_month == 4 }" > selected="selected" </c:if>
				value="04">04</option>
			<option
				<c:if test="${expire_month == 5 }" > selected="selected" </c:if>
				value="05">05</option>
			<option
				<c:if test="${expire_month == 6 }" > selected="selected" </c:if>
				value="06">06</option>
			<option
				<c:if test="${expire_month == 7 }" > selected="selected" </c:if>
				value="07">07</option>
			<option
				<c:if test="${expire_month == 8 }" > selected="selected" </c:if>
				value="08">08</option>
			<option
				<c:if test="${expire_month == 9 }" > selected="selected" </c:if>
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
</c:when>
<c:otherwise>    
    <select id="WC_StandardCreditCard_FormInput_cardExpiryMonth_1_<c:out value='${paramNumStatus}' />" name="cardExpiryMonth" size="1" onchange="javascript:<c:out value='${edp_PI_Form}' />_changed('cardExpiryMonth')">
      <option selected="selected" value="<c:out value="${strCardExpiryMonth}"/>"><c:out value="${strCardExpiryMonth}"/></option>
    </select> 
    </c:otherwise>
</c:choose>
</td>
</tr>
<tr>
  <td  valign="middle" id="WC_StandardCreditCard_TableCell_10_<c:out value='${paramNumStatus}' />"><span class="reqd">*</span><label for="WC_StandardCreditCard_FormInput_cardExpiryYear_1_<c:out value='${paramNumStatus}' />"><fmt:message key="EDPPaymentMethods_AMEX_EXPIRATION_YEAR" bundle="${edpText}"/></label></td>
  <td  valign="middle" id="WC_StandardCreditCard_TableCell_11_<c:out value='${paramNumStatus}' />"></td>
  <td  valign="middle" id="WC_StandardCreditCard_TableCell_12_<c:out value='${paramNumStatus}' />"> 
<c:set var="strCardExpiryYear" value="${paymentTCInfo.cardExpiryYear}"/>
<c:choose>
	<c:when test="${empty strCardExpiryYear || strCardExpiryYear==''}">
		<select id="WC_StandardCreditCard_FormInput_cardExpiryYear_1_<c:out value='${paramNumStatus}' />" name="cardExpiryYear" size="1" onchange="javascript:<c:out value='${edp_PI_Form}' />_changed('cardExpiryYear')">
			<c:forEach begin="0" end="10" varStatus="counter">
				<option
				<c:if test="${expire_year == expire_year+counter.index }" > selected="selected" </c:if>
				value="${expire_year+counter.index}">${expire_year+counter.index}</option>
			</c:forEach>
    </select> 
</c:when>
<c:otherwise>  
<select id="WC_StandardCreditCard_FormInput_cardExpiryYear_1_<c:out value='${paramNumStatus}' />" name="cardExpiryYear" size="1" onchange="javascript:<c:out value='${edp_PI_Form}' />_changed('cardExpiryYear')">
      <option selected="selected" value="<c:out value="${strCardExpiryYear}"/>"><c:out value="${strCardExpiryYear}"/></option>
    </select> 
    </c:otherwise>
</c:choose>
</td>
</tr>
	<%-- load billing address dropdown box from a seperate page --%>
	<tr>
		<td colspan="3" valign="middle" id="StandardCreditCard_TableCell_13_<c:out value='${paramNumStatus}' />">
			<c:import  url="${billingAddressSelectListPath}" >
			  <c:param name="currentBillingAddress" value="${currentBillingAddress}"/>
				<c:param name="billingParmName" value="StandardCreditCard_billing_address_id_${paramNumStatus}" />
				<c:param name="paymentTCId" value="${paymentTCId}" />
			</c:import>
		</td>
	</tr>
</table>


<script type="text/javascript" language="javascript">
	<%-- 
	***
	* <form_name>_elementArray is an array holding the objects of form elements which need to be cleared/reseted
	* If the whole form needs to be cleared then set
	*
	*		<form_name>_elementArray = document.forms["<form_name>"].elements
	*
	*This will pass all the elements of form to <form_name>_elementArray
	***
	 --%>


	<c:out value='${edp_PI_Form}' />_elementArray[0] = document.forms["<c:out value='${edp_PI_Form}' />"].elements["cardNumber"]
	<c:out value='${edp_PI_Form}' />_elementArray[1] = document.forms["<c:out value='${edp_PI_Form}' />"].elements["cardExpiryMonth"]
	<c:out value='${edp_PI_Form}' />_elementArray[2] = document.forms["<c:out value='${edp_PI_Form}' />"].elements["cardExpiryYear"]
	
	<%-- 
	***
	* This javascript function is called when sepcific form feilds are changed
	* This function calls the paymentcahnge which is resposible for clearing the value of form elements
	***
	 --%>
	function <c:out value='${edp_PI_Form}' />_changed(payment_field_name)
	{
		if(document.forms["<c:out value='${edp_PI_Form}' />"].elements["valueFromProfileOrder"] != undefined)
		{
			document.forms["<c:out value='${edp_PI_Form}' />"].elements["valueFromProfileOrder"].value="N"
		}
		paymentChanged(document.forms["<c:out value='${edp_PI_Form}' />"], <c:out value='${edp_PI_Form}' />_elementArray, payment_field_name)
	}

	function <c:out value='${edp_PI_Form}' />_amount_changed(payment_field_name)
	{
		//This code is not working...
		//It is giving error that card no is require
		//It means we can't pass the amount alone

		//document.forms["<c:out value='${edp_PI_Form}' />"].elements["<c:out value='${inputPrefix}'/>account"].name = "tmp_account"
		//document.forms["<c:out value='${edp_PI_Form}' />"].elements["<c:out value='${inputPrefix}'/>expire_month"] = "tmp_expire_month"
		//document.forms["<c:out value='${edp_PI_Form}' />"].elements["<c:out value='${inputPrefix}'/>expire_year"] = "tmp_expire_year"
		//document.forms["<c:out value='${edp_PI_Form}' />"].elements["<c:out value='${inputPrefix}'/>cc_cvc"] = "tmp_cvc"
	}

</script>

<!-- END StandardCreditCard.jsp -->
