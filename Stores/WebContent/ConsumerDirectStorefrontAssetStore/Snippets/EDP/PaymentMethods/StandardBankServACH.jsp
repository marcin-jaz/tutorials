<!-- BEGIN StandardBankServACH.jsp -->
<!-- This is StandardBankServACH.jsp, a JSP fragment, and should not have <html> or <body> tags -->
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
  *  - check account number
  *  - check routing number
  *****
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>

<%-- Include the EDP environment setup snippet --%>
<%@ include file="../EDPEnvironmentSetup.jspf"%>

<%-- Get the parameter for the payment TC Id, if the payment TC is not empty, the protocol data will be retrieved from the payment TC --%>
<c:set var="paramNumStatus" value="${param.paramNumStatus}" />
<c:set var="paymentTCId" value="${param.paymentTCId}" />

<%-- If the paymentTCId parameter is not passed in, the protocol data will be retrieved from the edp_ProtocolData databean --%>
<c:if test="${empty paymentTCId}" >
    <c:set var="paymentTCId" value="${edp_ProtocolData.paymentTCId}" />
    <c:set var="check_account_number" value="${edp_ProtocolData.checkingAccountNumber}" />
    <c:set var="check_routing_number" value="${edp_ProtocolData.checkRoutingNumber}" />
</c:if>

<c:if test="${!empty param.currentBillingAddress}">
	<c:set var="currentBillingAddress" value="${param.currentBillingAddress}"/>
</c:if>

<table cellpadding="3" cellspacing="0" border="0" id="StandardBankServACH_Table_1_<c:out value='${paramNumStatus}' />">
<input type="hidden" name="piAmount" value="<c:out value="${edp_OrderTotalAmount}" />"	id="WC_StandardBankServACH_FormInput_piAmount_1_<c:out value='${paramNumStatus}' />" />
<tr>
  <td  valign="middle" id="WC_StandardBankServACH_TableCell_1_<c:out value='${paramNumStatus}' />"><span class="reqd">*</span><label for="WC_StandardBankServACH_FormInput_checkingAccountNumber_1_<c:out value='${paramNumStatus}' />"><fmt:message key="EDPPaymentMethods_BANK_ACCOUNT_NO" bundle="${edpText}"/></label></td>
  <td  valign="middle" id="WC_StandardBankServACH_TableCell_2_<c:out value='${paramNumStatus}' />"></td>
  <td  valign="middle" id="WC_StandardBankServACH_TableCell_3_<c:out value='${paramNumStatus}' />"> 
<c:set var="strCheckAccountNumber" value="${paymentTCInfo.checkingAccountNumber}"/>
<c:choose>
	<c:when test="${empty strCheckAccountNumber || strCheckAccountNumber==''}">
		<input type="text" size="20" name="checkingAccountNumber"  value="<c:out value="${check_account_number}" />" id="WC_StandardBankServACH_FormInput_checkingAccountNumber_1_<c:out value='${paramNumStatus}' />"/> 
	</c:when>
	<c:otherwise>
		<c:out value="${strCheckAccountNumber}"/> <input type="hidden" size="20" name="checkingAccountNumber" value="<c:out value="${strCheckAccountNumber}"/>" id="WC_StandardBankServACH_FormInput_checkingAccountNumber_2_<c:out value='${paramNumStatus}' />"/>
	</c:otherwise>
</c:choose>
</td>
</tr>
<tr>
  <td  valign="middle" id="WC_StandardBankServACH_TableCell_4_<c:out value='${paramNumStatus}' />"><span class="reqd">*</span><label for="WC_StandardBankServACH_FormInput_checkRoutingNumber_1_<c:out value='${paramNumStatus}' />"><fmt:message key="EDPPaymentMethods_BANK_ROUTING_NO" bundle="${edpText}"/></label></td>
  <td  valign="middle" id="WC_StandardBankServACH_TableCell_5_<c:out value='${paramNumStatus}' />"></td>
  <td  valign="middle" id="WC_StandardBankServACH_TableCell_6_<c:out value='${paramNumStatus}' />"> 
<c:set var="strCheckRoutingNumber" value="${paymentTCInfo.checkRoutingNumber}"/>
<c:choose>
	<c:when test="${empty strCheckRoutingNumber || strCheckRoutingNumber==''}">
		<input type="text" size="20" name="checkRoutingNumber"  value="<c:out value="${check_routing_number}" />" id="WC_StandardBankServACH_FormInput_checkRoutingNumber_1_<c:out value='${paramNumStatus}' />"/> 
	</c:when>
	<c:otherwise>
		<c:out value="${strCheckRoutingNumber}"/> <input type="hidden" size="20" name="checkRoutingNumber" value="<c:out value="${strCheckRoutingNumber}"/>" id="WC_StandardBankServACH_FormInput_checkRoutingNumber_2_<c:out value='${paramNumStatus}' />"/>
	</c:otherwise>
</c:choose>
</td>
</tr>
	<%-- load billing address dropdown box from a seperate page --%>
	<tr>
		<td colspan="3" valign="middle" id="StandardBankServACH_TableCell_7_<c:out value='${paramNumStatus}' />">
			<c:import  url="${billingAddressSelectListPath}" >
			  <c:param name="currentBillingAddress" value="${currentBillingAddress}"/>
				<c:param name="billingParmName" value="StandardBankServACH_billing_address_id_${paramNumStatus}" />
				<c:param name="paymentTCId" value="${paymentTCId}" />
			</c:import>
		</td>
	</tr>
</table>
