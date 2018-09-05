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
  *****	 		
  * (Advanced orders) This JSP snippet displays the following information:
  *	      - The protocol data fields for the payment method Check
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
  * How to use this snippet?
  * 1. This snippet is available under the following directory: <WC_installdir>/samples/Snippets/web/EDP/PaymentMethods
  *     or  <WCDE_installdir>\samples\Snippets\web\EDP\PaymentMethods.
  * 2. You can use this snippet in your xxx.jsp in either of the following two ways:
  *		A. Copy and paste the entire code into your xxx.jsp.
  *		B. Import the snippet as follows: 
  *				<c:import url="${snippetJspStoreDir}Snippets/EDP/PaymentMethods/StandardCheck.jsp" >
  *					<c:param name="paymentTCId" value="${edp_Info.TCId}" />
  *					<c:param name="showPONumber" value="${showPONumber}" />
  *				</c:import>
  *****	 		
--%>

<!-- Start - JSP File Name: StandardCheck.jsp -->

<!-- Set the taglib -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>

<%-- Include the EDP environment setup snippet --%>
<%@ include file="../EDPEnvironmentSetup.jspf"%>

<c:set var="paramNumStatus" value="${param.paramNumStatus}" />
<c:if test="${param.hideRemainingAmount}">
	<c:set var="hideRemainingAmount" value="true"/>
</c:if>

<%-- Get the parameter for the payment TC Id, if the payment TC is not empty, the protocol data will be retrieved from the payment TC --%>

<input type="hidden" name="payment_reset" value="false" id="<c:out value='${edp_PI_Form}' />_payment_reset" />
<script type="text/javascript" language="javascript">
	var <c:out value='${edp_PI_Form}' />_elementArray = new Array()
</script>

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
          <c:when test="${attribute.name eq 'check_routing_number'}">
   		      <c:set var="check_routing_number" value="${pAttrValue.PAttrValue}" />
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
    <c:set var="check_routing_number" value="${edp_ProtocolData.check_routing_number}" />
</c:if>
<c:if test="${param.showPONumber}">
	<c:set var="showPONumber" value="true"/>
</c:if>

<%-- The section to collect the protocol data for this payment method --%>
<table cellpadding="3" cellspacing="0" border="0" id="StandardACH_Table_1_<c:out value='${paramNumStatus}' />">
    
	<tr>
		<td colspan="4" valign="middle"  id="StandardACH_TableCell_1_<c:out value='${paramNumStatus}' />">
			<label for ="StandardACH_InputText_1_<c:out value='${paramNumStatus}' />"><span class="required">*</span><fmt:message key="EDPPaymentMethods_BANK_ROUTING_NO" bundle="${edpText}"  /></label>
		</td>
	</tr>
	<tr>
		<td colspan="4" valign="middle" id="StandardACH_TableCell_2_<c:out value='${paramNumStatus}' />">
			<input class="input" type="text" name = "check_routing_number" value ="<c:out value="${check_routing_number}" />" id="StandardACH_InputText_1_<c:out value='${paramNumStatus}' />" onchange="javascript:<c:out value='${edp_PI_Form}' />_changed('check_routing_number')"/>
			<input type="hidden" name="paymentTCId" value="<c:out value="${paymentTCId}"/>" />
			<c:if test="${showPONumber}">
				<input type="hidden" name="purchaseorder_id" value="<c:out value="${edp_ProtocolData.purchaseorder_id}" />" id="StandardACH_InputText_0_<c:out value='${paramNumStatus}' />" />
			</c:if>
		</td>

	</tr>
	<tr>
		<td colspan="4" valign="middle" id="StandardACH_TableCell_3_<c:out value='${paramNumStatus}' />">
			<label for="StandardACH_InputText_2_<c:out value='${paramNumStatus}' />"><span class="required">*</span><fmt:message key="EDPPaymentMethods_BANK_ACCOUNT_NO" bundle="${edpText}"  /></label>
		</td>
	</tr>
	<tr>
		<td colspan="4" valign="middle" id="StandardACH_TableCell_4_<c:out value='${paramNumStatus}' />">
			<input class="input" type="text" name = "account" value ="<c:out value="${account}" />" id="StandardACH_InputText_2_<c:out value='${paramNumStatus}' />" 
							onchange="javascript:<c:out value='${edp_PI_Form}' />_changed('account')"
			/>
			<c:if test="${valueFromPaymentTC == 'true'}" >
				<input type="hidden" name="valueFromPaymentTC" value="true" />
            		</c:if>
		</td>
	</tr>
	<c:if test="${!hideRemainingAmount}">
	<tr>
		<%--
		***************************
		* Start: Show the remaining amount -- the amount not yet allocated to a payment method
		***************************
		--%>
		<td id="StandardACH_TableCell_5_<c:out value='${paramNumStatus}' />">
			<label for="StandardACH_OrderRemainingAmount_<c:out value='${paramNumStatus}' />"><fmt:message key="EDPPaymentMethods_PAYMENT_AMT_REMAINING" bundle="${edpText}"/></label>
		</td>
	</tr>
	<tr>
		<td id="StandardACH_TableCell_6_<c:out value='${paramNumStatus}' />">
			<input <c:if test="${remainingAmt lt 0.0}"> class="error" </c:if>
				class="input" type="text" name="remainingAmount" id="StandardACH_OrderRemainingAmount_<c:out value='${paramNumStatus}' />" readonly="readonly" value="<c:out value="${remainingAmt}"/>" />
		</td>
	</tr>
	</c:if>
	<tr>
		<td colspan="4" valign="middle" id="StandardACH_TableCell_7_<c:out value='${paramNumStatus}' />">
			<label for="StandardACH_InputText_3_<c:out value='${paramNumStatus}' />"><span class="required">*</span><fmt:message key="EDPPaymentMethods_PAYMENT_AMOUNT" bundle="${edpText}"/></label>
		</td>
	</tr>
	<tr>
		<td colspan="4" valign="middle" id="StandardACH_TableCell_8_<c:out value='${paramNumStatus}' />">
			<input class="input" type="text" name = "piAmount" value="<c:out value="${edp_PayMethodAmount}" />" id="StandardACH_InputText_3_<c:out value='${paramNumStatus}' />" onchange="javascript:<c:out value='${edp_PI_Form}'/>_amount_changed('piAmount') "/>
		</td>
	</tr>
	<%-- load billing address dropdown box from a seperate page --%>
	<%-- Note, check is customer editable payment method, should disable piAmout and billing address when display existing check --%>
	<tr>
		<td colspan="4" valign="middle" id="StandardACH_TableCell_10_<c:out value='${paramNumStatus}' />">
			<c:import  url="${billingAddressSelectListPath}" >
				<c:param name="billingParmName" value="StandardACH_billing_address_id_${paramNumStatus}" />
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

	<c:out value='${edp_PI_Form}' />_elementArray[0] = document.forms["<c:out value='${edp_PI_Form}' />"].elements["check_routing_number"]
	<c:out value='${edp_PI_Form}' />_elementArray[1] = document.forms["<c:out value='${edp_PI_Form}' />"].elements["account"]
	
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

<!-- End - JSP File Name: StandardCheck.jsp -->

