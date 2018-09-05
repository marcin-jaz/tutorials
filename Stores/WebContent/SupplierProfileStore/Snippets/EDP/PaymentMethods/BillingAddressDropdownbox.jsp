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
  *  
  * (Advanced orders) This JSP snippet selects the billing address for the payment method.
  *
  * Parameters
  *
  *	-paymentTCId
  *	This value is the identifier of the payment terms and conditions (TC) for the payment method. It is used to 
  * find the usable billing address defined for this payment TC.
  *	If this parameter is not passed in, all the usable billing addresses for the order will be found.
  *
  *	-orderId
  *	This value is the order number for which the payment method is created.
  *	If this parameter is passed in, the order number in the input parameters of the HTTP request will be used.
  *
  * -billingParmName
  * This value is the name of the parameter for the billing address ID.
  * If this parameter is not passed in, the default value of "billing_address_id" will be used.
  * 
  * -currentBillingAddress
  *	This value is used to determine whether the product attachment's short description should be 
  * displayed. If this parameter is not passed in, the default value of true will be used.
  *
  * How to use this snippet?
  * 1. This snippet is available under the following directory: <WC_installdir>/samples/Snippets/web/EDP/PaymentMethods
  *     or  <WCDE_installdir>\samples\Snippets\web\EDP\PaymentMethods.
  * 2. You can use this snippet in your xxx.jsp in either of the following two ways:
  *		A. Copy and paste the entire code into your xxx.jsp.
  *		B. Import the snippet as follows: 
  * 		<c:import  url="${snippetJspStoreDir}Snippets/EDP/PaymentMethods/BillingAddressDropdownbox.jsp" >
  * 			<c:param name="paymentTCId" value="${paymentTCId}" />
  * 			<c:param name="orderId" value="${orderId}" />
  * 			<c:param name="billingParmName" value="billing_address_id" />
  * 			<c:param name="currentBillingAddress" value="${currentBillingAddress}" />
  * 		</c:import>
  *****
--%>

<%-- Start- JSP File Name: BillingAddressDropdownbox.jsp --%>

<%-- Set the taglib --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>

<%-- Include the EDP environment setup snippet --%>
<%@ include file="../EDPEnvironmentSetup.jspf"%>

	<%-- paymentTCId is for B2B store --%>
	<c:set var="paymentTCId" value="${param.paymentTCId}" />

	<%-- set the order number; if the jspf parameter orderId is not set, 
	     get it from the request properties--%>
	<c:set var="orderIdRn" value="${param.orderId}" />
	<c:if test="${empty orderIdRn}" >
		<c:set var="orderIdRn" value="${WCParam.orderId}" />
	</c:if>

	<%-- set the select field name for the billing address;  if the jspf parameter billingParmName is not set,
	     use the string "billing_address_id" as the default value  --%>
	<c:set var="billingParmName" value="billing_address_id"/>
	<c:if test="${!empty param.billingParmName}">
		<c:set var="billingParmName" value="${param.billingParmName}"/>
	</c:if>
		
	<%-- set the default selected billing address;  if the jspf parameter currentBillingAddress is not set,
	     use the billing address retrieved from the payment instruction as the default value  --%>
	<c:set var="currentBillingAddress" value="${edp_ProtocolData.billing_address_id}"/>
	<c:if test="${!empty param.currentBillingAddress}">
		<c:set var="currentBillingAddress" value="${param.currentBillingAddress}"/>
	</c:if>
    <%-- Get the usable billing address list for the order and the payment TC --%> 
	<c:choose>
		<c:when test="${!empty paymentTCId}">
			<wcbase:useBean id="usableBillingAddressListDataBean" classname="com.ibm.commerce.order.beans.UsableBillingAddressListDataBean" scope="page">
				<c:set target="${usableBillingAddressListDataBean}" property="orderId"	value="${orderIdRn}" />
				<c:set target="${usableBillingAddressListDataBean}"	property="paymentTCId" value="${paymentTCId}" />
		    </wcbase:useBean>		
		</c:when>
		<c:otherwise>
			<wcbase:useBean id="usableBillingAddressListDataBean" classname="com.ibm.commerce.order.beans.UsableBillingAddressListDataBean" scope="page">
				<c:set target="${usableBillingAddressListDataBean}" property="orderId"	value="${orderIdRn}" />
		    </wcbase:useBean>		
		</c:otherwise>
	</c:choose>
	          
	<%-- Display the usable billing address list and select the current billing address as the default --%>
	<label for="<c:out value="${billingParmName}"/>">
		<span class="required">*</span>
		<fmt:message key="EDPPaymentMethods_BILLING_ADDRESS" bundle="${edpText}" />
	</label>
	<table>
	<tr>
		<td colspan="4" valign="middle" >
			<select name="billing_address_id" class="select" id="<c:out value="${billingParmName}"/>">
				<c:forEach var="address" items="${usableBillingAddressListDataBean.billingAddresses}" varStatus="addressStatus">
					<c:if test="${ !(address.selfAddress && empty address.country)  && address.nickName != defaultShipping && address.nickName != defaultBilling}" >	
						<c:set var="hasAddress"  value="true"/> 
						<c:choose>
							<c:when test="${address.addressId eq currentBillingAddress}">
		 						<option selected="selected" value="<c:out value="${address.addressId}"/>">
		       						<c:out value="${address.nickName}"/>
		       					</option>
		 					</c:when>
							<c:otherwise>
								<option  value="<c:out value="${address.addressId}"/>">
		       						<c:out value="${address.nickName}"/>
		       					</option>		
							</c:otherwise>
						</c:choose>				
					</c:if>
				</c:forEach>
			</select>
		</td>
	</tr>
	</table>
	<%-- No address should never happen, you can display a message for completeness
	<c:if test="${!hasAddress}">
		<c:out value="You have no billing address set up in address book or quick checkout profile." />
	</c:if>
    --%>
<%-- End- JSP File Name: BillingAddressDropdownbox.jsp --%>
