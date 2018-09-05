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
  * (Advanced orders) This JSP snippet displays the following information:
  *	      - The protocol data fields for the payment method VISA
  *	      - A list of usable billing addresses for this payment method
  *
  * Parameters:
  * 
  * -inputPrefix
  * This value is the prefix of the input fields.
  * 
  * -paymentTCId
  *	This value is the identifier of the payment terms and conditions (TC) for the payment method. 
  * 
  * -showPONumber
  * This flag indicates whether the input field for the purchase order should be displayed.
  * 
  * -hideAmounts
  * This flag indicates whether the input field for the amount should be displayed.
  *
  * -hideRemainingAmount
  * This flag indicates whether the input field for the remaining amount should be displayed.
  *
  * -doNotShowCCVNumber
  * This flag indicates whether the input field for the ccv should not be displayed.
  * 
  * How to use this snippet?
  * 1. This snippet is available under the following directory: <WC_installdir>/samples/Snippets/web/EDP/PaymentMethods
  *     or  <WCDE_installdir>\samples\Snippets\web\EDP\PaymentMethods.
  * 2. You can use this snippet in your xxx.jsp in either of the following two ways:
  *		A. Copy and paste the entire code into your xxx.jsp.
  *		B. Import the snippet as follows: 
  *				<c:import url="${snippetJspStoreDir}Snippets/EDP/PaymentMethods/StandardVisa.jsp" >
  *					<c:param name="paymentTCId" value="${edp_Info.TCId}" />
  *					<c:param name="showPONumber" value="${showPONumber}" />
  *				</c:import>
  ***
--%>

<!-- Start - JSP File Name: StandardVisa.jsp -->

<!-- Set the taglib -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>

<%-- Include the EDP environment setup snippet --%>
<%@ include file="../EDPEnvironmentSetup.jspf"%>

<%-- Get the parameter for the payment TC Id, if the payment TC is not empty, the protocol data will be retrieved from the payment TC --%>

<input type="hidden" name="payment_reset" value="false" id="<c:out value='${edp_PI_Form}' />_payment_reset" />
<script type="text/javascript" language="javascript">
	var <c:out value='${edp_PI_Form}' />_elementArray = new Array()
</script>
<c:set var="paramNumStatus" value="${param.paramNumStatus}" />
<c:set var="paymentTCId" value="${param.paymentTCId}" />
<c:if test="${!empty paymentTCId}" >

	<%-- Set the account ID and credit line account number --%>
	<wcbase:useBean id="paymentTCbean" classname="com.ibm.commerce.contract.beans.PaymentTCDataBean">
       <c:set target="${paymentTCbean}" property="dataBeanKeyReferenceNumber" value="${paymentTCId}"/>
    </wcbase:useBean>

   	<c:forEach var="pAttrValue" items="${paymentTCbean.PAttrValues}">
   	   <c:remove var="attribute"/>
       <wcbase:useBean id="attribute" classname="com.ibm.commerce.utf.beans.PAttributeDataBean">
          <c:set target="${attribute}" property="initKey_referenceNumber" value="${pAttrValue.attributeId}"/>
       </wcbase:useBean>
       <c:choose>
          <c:when test="${attribute.name eq 'account'}">
          <c:if test="${!empty pAttrValue.PAttrValue}">
              <c:set var="valueFromPaymentTC" value="true" />
              <wcbase:useBean id = "edpMaskBean" classname="com.ibm.commerce.edp.beans.EDPSensitiveDataMaskHelperDataBean">
              	<c:set target="${edpMaskBean}" property="plainString" value="${pAttrValue.PAttrValue}"/>
              </wcbase:useBean>
   		      <c:set var="account" value="${edpMaskBean.maskedString}" />
   		  </c:if>
          <c:if test="${empty pAttrValue.PAttrValue}">
	          <c:set var="account" value="" />
   		  </c:if>
	      </c:when>
          <c:when test="${attribute.name eq 'cc_brand'}">
   		      <c:set var="cc_brand" value="${pAttrValue.PAttrValue}" />
	      </c:when>
          <c:when test="${attribute.name eq 'expire_month'}">
   		      <c:set var="expire_month" value="${pAttrValue.PAttrValue + 0}" />
	      </c:when>
          <c:when test="${attribute.name eq 'expire_year'}">
   		      <c:set var="expire_year" value="${pAttrValue.PAttrValue + 0}" />
	      </c:when>
       </c:choose>
    </c:forEach>				  

</c:if>
<%-- If the paymentTCId parameter is not passed in, the protocol data will be retrieved from the edp_ProtocolData databean --%>
<c:if test="${empty paymentTCId}" >
	<c:set var="paymentTCId" value="${edp_ProtocolData.paymentTCId}" />
              <wcbase:useBean id = "edpMaskBean" classname="com.ibm.commerce.edp.beans.EDPSensitiveDataMaskHelperDataBean">
              	<c:set target="${edpMaskBean}" property="plainString" value="${edp_ProtocolData.account}"/>
              </wcbase:useBean>
    <c:set var="account" value="${edpMaskBean.maskedString}" />
    <c:set var="cc_brand" value="${edp_ProtocolData.cc_brand}" />
    <c:set var="expire_month" value="${edp_ProtocolData.expire_month + 0}" />
    <c:set var="expire_year" value="${edp_ProtocolData.expire_year + 0}" />
</c:if>
<%-- Get other parameters: showPONumber, hideAmounts, hideButtons --%>
<c:if test="${param.hideAmounts}">
	<c:set var="hideAmounts" value="true"/>
	<c:set var="hideBillingAddress" value="true"/>
</c:if>
<c:if test="${param.hideButtons}">
	<c:set var="hideButtons" value="true"/>
</c:if>
<c:if test="${param.showPONumber}">
	<c:set var="showPONumber" value="true"/>
</c:if>
<c:if test="${param.hideRemainingAmount}">
	<c:set var="hideRemainingAmount" value="true"/>
</c:if>
<c:if test="${param.doNotShowCCVNumber}">
	<c:set var="doNotShowCCVNumber" value="true"/>
</c:if>
<c:if test="${!empty param.currentBillingAddress}">
	<c:set var="currentBillingAddress" value="${param.currentBillingAddress}"/>
</c:if>

<%-- Get the prefix for the input fields --%>
<c:choose>
	<c:when test="${!empty param.inputPrefix}">
		<c:set var="inputPrefix" value="${param.inputPrefix}"/>
	</c:when>
	<c:otherwise>
		<c:set var="inputPrefix" value=""/>
	</c:otherwise>
</c:choose>

<%-- Set the default value(current month + 1) of expire_month for this payment method --%>
<jsp:useBean id="now" class="java.util.Date"/>

<c:if test="${expire_month == 0}">
	<c:set var="expire_month" value="${now.month + 1}"/>
</c:if>

<c:if test="${expire_year == 0}">
	<c:set var="expire_year" value="${now.year + 1900}"/>
</c:if>

<%-- Set the default value("VISA") of cc_brand for this payment method --%>
<c:set var="cc_brand" value="VISA"/>


<%-- The section to collect the protocol data for this payment method --%>
<table cellpadding="3" cellspacing="0" border="0" id="StandardVisa_Table_1_<c:out value='${paramNumStatus}' />">
	<tr>
		<td valign="middle" id="StandardVisa_TableCell_1_<c:out value='${paramNumStatus}' />">
			<label for="StandardVisa_InputText_1_<c:out value='${paramNumStatus}' />">
				<span class="required">*</span>
				<fmt:message key="EDPPaymentMethods_VISA_CARD_NUMBER" bundle="${edpText}" />
			</label>
		</td>
		<td valign="middle" id="StandardVisa_TableCell_2_<c:out value='${paramNumStatus}' />">
			<label for="edp_Visa_cardExpiryMonth_<c:out value='${paramNumStatus}' />">
				<span class="required">*</span>
				<fmt:message key="EDPPaymentMethods_VISA_EXPIRATION_MONTH" bundle="${edpText}" />
			</label>
		</td>
		<td valign="middle" id="StandardVisa_TableCell_3_<c:out value='${paramNumStatus}' />">
			<label for="edp_Visa_cardExpiryYear_<c:out value='${paramNumStatus}' />">
				<span class="required">*</span>
				<fmt:message key="EDPPaymentMethods_VISA_EXPIRATION_YEAR" bundle="${edpText}" />
			</label>
		</td>
	</tr> 
	<tr>
		<td valign="middle" id="StandardVisa_TableCell_4_<c:out value='${paramNumStatus}' />">
			<input class="input" type="text" name="<c:out value="${inputPrefix}"/>account" value="<c:out value="${account}" />"	id="StandardVisa_InputText_1_<c:out value='${paramNumStatus}' />" 
			 onchange="javascript:<c:out value='${edp_PI_Form}' />_changed('<c:out value='${inputPrefix}'/>account')"
			/>
			<c:if test="${valueFromPaymentTC == 'true'}" >
				<input type="hidden" name="valueFromPaymentTC" value="true" />
			</c:if>
			<input type="hidden" name="<c:out value="${inputPrefix}"/>cc_brand" value="<c:out value="${cc_brand}" />" />
			<input type="hidden" name="paymentTCId" value="<c:out value="${paymentTCId}"/>" />
			<c:if test="${showPONumber}">
				<input type="hidden" name = "purchaseorder_id" value ="<c:out value="${edp_ProtocolData.purchaseorder_id}" />" id="StandardVisa_InputText_3_<c:out value='${paramNumStatus}' />" />
			</c:if>
		</td>
		<td valign="middle" id="StandardVisa_TableCell_5_<c:out value='${paramNumStatus}' />">
			<select name="<c:out value="${inputPrefix}"/>expire_month" class="select c_select_yr_mnth" id="edp_Visa_cardExpiryMonth_<c:out value='${paramNumStatus}' />" onchange="javascript:<c:out value='${edp_PI_Form}' />_changed('<c:out value='${inputPrefix}'/>expire_month')" >
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
		</td>
		<td valign="middle" id="StandardVisa_TableCell_6_<c:out value='${paramNumStatus}' />">
		<select name="<c:out value="${inputPrefix}"/>expire_year" class="select c_select_yr_mnth" id="edp_Visa_cardExpiryYear_<c:out value='${paramNumStatus}' />" onchange="javascript:<c:out value='${edp_PI_Form}' />_changed('<c:out value='${inputPrefix}'/>expire_year')">
			<c:forEach begin="0" end="10" varStatus="counter">
				<option
				<c:if test="${expire_year == expire_year+counter.index }" > selected="selected" </c:if>
				value="${expire_year+counter.index}">${expire_year+counter.index}</option>
			</c:forEach>
		</select></td>
	</tr>
	
	<c:if test="${!doNotShowCCVNumber}">
		<tr>
			<td colspan="3" valign="middle" id="StandardVisa_TableCell_7_<c:out value='${paramNumStatus}' />">
				<label for="StandardVisa_InputText_2_<c:out value='${paramNumStatus}' />">
					<fmt:message key="EDPPaymentMethods_CVV" bundle="${edpText}" />
				</label>
			</td>
		</tr>
		<tr>
			<td colspan="3" valign="middle" id="StandardVisa_TableCell_8_<c:out value='${paramNumStatus}' />">
				<input class="input" type="text" name="<c:out value="${inputPrefix}"/>cc_cvc" value="<c:out value="${edp_ProtocolData.cc_cvc}" />" id="StandardVisa_InputText_2_<c:out value='${paramNumStatus}' />" onchange="javascript:<c:out value='${edp_PI_Form}' />_changed('<c:out value='${inputPrefix}'/>cc_cvc')"/>
			</td>
		</tr>
	</c:if>
	
	<c:if test="${!hideAmounts}">
	<c:if test="${!hideRemainingAmount}">
	<tr>
		<%--
		***************************
		* Start: Show the remaining amount -- the amount not yet allocated to a payment method
		***************************
		--%>
		<td id="StandardVisa_TableCell_9_<c:out value='${paramNumStatus}' />">
			<label for="StandardVisa_OrderRemainingAmount_<c:out value='${paramNumStatus}' />"><fmt:message key="EDPPaymentMethods_PAYMENT_AMT_REMAINING" bundle="${edpText}"/></label>
		</td>
	</tr>
	<tr>
		<td id="StandardVisa_TableCell_10_<c:out value='${paramNumStatus}' />">
			<input <c:if test="${remainingAmt lt 0.0}"> class="error" </c:if>
				class="input" type="text" name="remainingAmount" id="StandardVisa_OrderRemainingAmount_<c:out value='${paramNumStatus}' />" readonly="readonly" value="<c:out value="${remainingAmt}"/>" />
		</td>
	</tr>
  </c:if>
	<tr>
		<td colspan="3" valign="middle" id="StandardVisa_TableCell_11_<c:out value='${paramNumStatus}' />">
			<label for="StandardVisa_InputText_4_<c:out value='${paramNumStatus}' />">
				<span class="required">*</span>
				<fmt:message key="EDPPaymentMethods_PAYMENT_AMOUNT" bundle="${edpText}" />
			</label>
		</td>
	</tr>
	<tr>
		<td colspan="3" valign="middle" id="StandardVisa_TableCell_12_<c:out value='${paramNumStatus}' />">
			<input class="input" type="text" name="<c:out value='${inputPrefix}'/>piAmount" value="<c:out value="${edp_PayMethodAmount}" />"	id="StandardVisa_InputText_4_<c:out value='${paramNumStatus}' />"  onchange="javascript:<c:out value='${edp_PI_Form}'/>_amount_changed('<c:out value='${inputPrefix}'/>piAmount') "/>
		</td>
	</tr>
	</c:if>

	<%-- load billing address dropdown box from a seperate page --%>
	<c:if test="${!hideBillingAddress}">
	<tr>
		<td colspan="3" valign="middle" id="StandardVisa_TableCell_14_<c:out value='${paramNumStatus}' />">
			<c:import  url="${billingAddressSelectListPath}" >
			    <c:param name="currentBillingAddress" value="${currentBillingAddress}"/>
				<c:param name="billingParmName" value="StandardVisa_billing_address_id_${paramNumStatus}" />
				<c:param name="paymentTCId" value="${paymentTCId}" />
			</c:import>
		</td>
	</tr>
	</c:if>
	
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

	<c:out value='${edp_PI_Form}' />_elementArray[0] = document.forms["<c:out value='${edp_PI_Form}' />"].elements["<c:out value='${inputPrefix}'/>account"]
	<c:out value='${edp_PI_Form}' />_elementArray[1] = document.forms["<c:out value='${edp_PI_Form}' />"].elements["<c:out value='${inputPrefix}'/>expire_month"]
	<c:out value='${edp_PI_Form}' />_elementArray[2] = document.forms["<c:out value='${edp_PI_Form}' />"].elements["<c:out value='${inputPrefix}'/>expire_year"]
	<c:out value='${edp_PI_Form}' />_elementArray[3] = document.forms["<c:out value='${edp_PI_Form}' />"].elements["<c:out value='${inputPrefix}'/>cc_cvc"]



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
<!-- End - JSP File Name: StandardVisa.jsp -->
