<!-- BEGIN VoidPayment.jsp -->
<!-- This is VoidPayment.jsp, a JSP fragment, and should not have <html> or <body> tags -->
<!-- The DOCTYPE tag is commented out because this is a JSP fragment -->
<!-- <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"> -->
<%
/*
 *-------------------------------------------------------------------
 * Licensed Materials - Property of IBM
 *
 * WebSphere Commerce
 *
 * (c) Copyright International Business Machines Corporation. 2006
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
  * This JSP page displays the payment description
  *****
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>

<%-- Include the EDP environment setup snippet --%>
<%@ include file="../EDPEnvironmentSetup.jspf"%>

<c:set var="paymentTCId" value="${param.paymentTCId}"/>
<%-- If the paymentTCId parameter is not passed in, the protocol data will be retrieved from the edp_ProtocolData databean --%>
<c:if test="${empty paymentTCId}" >
    <c:set var="paymentTCId" value="${edp_ProtocolData.paymentTCId}" />
</c:if>

<c:if test="${!empty param.currentBillingAddress}">
	<c:set var="currentBillingAddress" value="${param.currentBillingAddress}"/>
</c:if>

<table cellpadding="3" cellspacing="0" border="0" id="VoidPayment_Table_1">

<input type="hidden" name="piAmount" value="<c:out value="${edp_OrderTotalAmount}" />"	id="WC_VoidPayment_FormInput_piAmount_1" />

	<%-- load billing address dropdown box from a seperate page --%>
	<tr>
		<td colspan="3" valign="middle" id="VoidPayment_TableCell_1">
			<c:import  url="${billingAddressSelectListPath}" >
			  <c:param name="currentBillingAddress" value="${currentBillingAddress}"/>
				<c:param name="billingParmName" value="billing_address_id" />
				<c:param name="paymentTCId" value="${paymentTCId}" />
			</c:import>
		</td>
	</tr>
</table>