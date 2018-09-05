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
  *	      - The protocol data fields for the payment method LineOfCredit
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
  *				<c:import url="${snippetJspStoreDir}Snippets/EDP/PaymentMethods/StandardLOC.jsp" >
  *					<c:param name="paymentTCId" value="${edp_Info.TCId}" />
  *					<c:param name="showPONumber" value="${showPONumber}" />
  *				</c:import>
  *****
--%>

<!-- Start - JSP File Name: StandardLOC.jsp -->

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
<c:set var="paymentTCId" value="${param.paymentTCId}" />
<c:if test="${!empty paymentTCId}" >

	<%-- Set the account ID and credit line account number --%>
	<wcbase:useBean id="paymentTCbean" classname="com.ibm.commerce.contract.beans.PaymentTCDataBean">
       <c:set target="${paymentTCbean}" property="dataBeanKeyReferenceNumber" value="${paymentTCId}"/>
    </wcbase:useBean>
    <c:set var="WCAccountId" value="${paymentTCbean.tradingId}" />
    
   	<c:forEach var="pAttrValue" items="${paymentTCbean.PAttrValues}">
       <c:remove var="attribute"/>
       <wcbase:useBean id="attribute" classname="com.ibm.commerce.utf.beans.PAttributeDataBean">
          <c:set target="${attribute}" property="initKey_referenceNumber" value="${pAttrValue.attributeId}"/>
       </wcbase:useBean>
   	   <c:if test="${attribute.name eq 'account'}">
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
       </c:if>
    </c:forEach>				  

	<%-- Set the parent organization name and organization distinguished name --%>
	<c:set var="parentOrgId" value="${CommandContext.parentOrg}" />
	<wcbase:useBean id="orgDataBean" classname="com.ibm.commerce.user.beans.OrganizationDataBean">
		<c:set target="${orgDataBean}" property="dataBeanKeyMemberId" value="${parentOrgId}"/>
	</wcbase:useBean>
	<c:set var="BuyerOrgName" value="${orgDataBean.organizationName}" />
	<c:set var="BuyerOrgDN" value="${orgDataBean.distinguishedName}" />
</c:if>
<%-- If the paymentTCId parameter is not passed in, the protocol data will be retrieved from the edp_ProtocolData databean --%>
<c:if test="${empty paymentTCId}" >
	<c:set var="paymentTCId" value="${edp_ProtocolData.paymentTCId}" />
              <wcbase:useBean id = "edpMaskBean" classname="com.ibm.commerce.edp.beans.EDPSensitiveDataMaskHelperDataBean">
              	<c:set target="${edpMaskBean}" property="plainString" value="${edp_ProtocolData.account}"/>
              </wcbase:useBean>
    <c:set var="account" value="${edpMaskBean.maskedString}" />
    <c:set var="WCAccountId" value="${edp_ProtocolData.WCAccountId}" />
    <c:set var="BuyerOrgName" value="${edp_ProtocolData.BuyerOrgName}" />
    <c:set var="BuyerOrgDN" value="${edp_ProtocolData.BuyerOrgDN}" />
</c:if>
<c:if test="${param.showPONumber}">
	<c:set var="showPONumber" value="true"/>
</c:if>

<%-- The section to collect the protocol data for this payment method --%>
<table cellpadding="3" cellspacing="0" border="0" id="StandardLOC_Table_1_<c:out value='${paramNumStatus}' />">
	<c:if test="${!hideRemainingAmount}">
	<tr>
		<%--
		***************************
		* Start: Show the remaining amount -- the amount not yet allocated to a payment method
		***************************
		--%>
		<td id="StandardLOC_TableCell_1_<c:out value='${paramNumStatus}' />">
			<label for="StandardLOC_OrderRemainingAmount_<c:out value='${paramNumStatus}' />"><fmt:message key="EDPPaymentMethods_PAYMENT_AMT_REMAINING" bundle="${edpText}"/></label>
		</td>
	</tr>
	<tr>
		<td id="StandardLOC_TableCell_2_<c:out value='${paramNumStatus}' />">
			<input <c:if test="${remainingAmt lt 0.0}"> class="error" </c:if>
				class="input" type="text" name="remainingAmount" id="StandardLOC_OrderRemainingAmount_<c:out value='${paramNumStatus}' />" readonly="readonly" value="<c:out value="${remainingAmt}"/>" />
		</td>
	</tr>
	</c:if>
	<tr>
		<td  valign="middle" id="StandardLOC_TableCell_3_<c:out value='${paramNumStatus}' />">
			<label for="StandardLOC_InputText_3_<c:out value='${paramNumStatus}' />">
				<span class="required">*</span>
				<fmt:message key="EDPPaymentMethods_PAYMENT_AMOUNT" bundle="${edpText}" />
			</label>
		</td>
	</tr>
	<tr>
		<td valign="middle" id="StandardLOC_TableCell_4_<c:out value='${paramNumStatus}' />">
			<input class="input" type="text" name="piAmount" value="<c:out value="${edp_PayMethodAmount}" />" id="StandardLOC_InputText_3_<c:out value='${paramNumStatus}' />" />
			<input type="hidden" name="account" value ="<c:out value="${account}" />" />
			<c:if test="${valueFromPaymentTC == 'true'}" >
				<input type="hidden" name="valueFromPaymentTC" value="true" />
            		</c:if>
			<input type="hidden" name="paymentTCId" value="<c:out value="${paymentTCId}"/>" />
			<input type="hidden" name="BuyerOrgName" value="<c:out value="${BuyerOrgName}"/>" />
			<input type="hidden" name="BuyerOrgDN" value="<c:out value="${BuyerOrgDN}"/>" />
			<input type="hidden" name="WCAccountId" value="<c:out value="${WCAccountId}"/>" />
			<c:if test="${showPONumber}">
				<input type="hidden" name = "purchaseorder_id" value ="<c:out value="${edp_ProtocolData.purchaseorder_id}" />" id="StandardPayLater_InputText_1_<c:out value='${paramNumStatus}' />" />
			</c:if>
		</td>
	</tr>
	<%-- load billing address dropdown box from a seperate page --%>
	<tr>
		<td  valign="middle" id="StandardLOC_TableCell_6_<c:out value='${paramNumStatus}' />">
			<c:import  url="${billingAddressSelectListPath}" >
				<c:param name="billingParmName" value="StandardLOC_billing_address_id_${paramNumStatus}" />
				<c:param name="paymentTCId" value="${paymentTCId}" />
			</c:import>
		</td>
	</tr>	
	
</table>


<!-- End - JSP File Name: StandardLOC.jsp -->
