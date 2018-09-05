<%
//********************************************************************
//*-------------------------------------------------------------------
//* Licensed Materials - Property of IBM
//*
//* WebSphere Commerce
//*
//* (c) Copyright IBM Corp. 2000, 2002, 2004, 2009
//*
//* US Government Users Restricted Rights - Use, duplication or
//* disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
//*
//*-------------------------------------------------------------------
//*
%>

<%--
  *****
  * This page show allows the user to create a profile to be used during the Quick Checkout process.  This page contains:
  *
  * - A Billing address section which contains:
  * 	- 'First name' field to enter the user's first name
  * 	- 'Last name' field to enter the user's last name (required field)
  * 	- 'Street address' field to enter the user's address (required field)
  * 	- 'City' field to enter the user's city (required field)
  * 	- 'State/Province' field to enter the user's state or province (required field)
  * 	- 'Zip code/Postal code' field to enter the user's zip/postalcode (required field) 
  * 	- 'Country/Region' field to enter the user's count/region (required field)
  * 	- 'Phone number' field to enter the user's phone number
  *
  * - A Shipping address section which contains:
  *		- a 'same as billing address above' check box which the user will select if their billing and shipping addresses are the same
  *  	- 'First name' field to enter the user's first name
  * 	- 'Last name' field to enter the user's last name (required field)
  * 	- 'Street address' field to enter the user's address (required field)
  * 	- 'City' field to enter the user's city (required field)
  * 	- 'State/Province' field to enter the user's state or province (required field)
  * 	- 'Zip code/Postal code' field to enter the user's zip/postalcode (required field) 
  * 	- 'Country/Region' field to enter the user's count/region (required field)
  * 	- 'Phone number' field to enter the user's phone number
  *
  * - A Available shipping methods section which contains:
  *		- 'Regular mail' radio button for the user to select if they prefer shipping via regular mail
  *		- 'Express mail' radio button for the user to select if they prefer shipping via express mail
  * 	
  * - A Payment Information section which contains:
  *		- 'Credit card type' drop down for the user to select their credit card type (American Express, MasterCard or Visa)
  * 	- 'Card number:' field for the user to enter their credit card number
  * 	- 'Expiration month' dropdown for the user to select the expiry month for their credit card
  * 	- 'Expiration year' dropdown for the user to select the expiry year for their credit card
  *
  * - A 'submit' button which is used to save the Quick Check Out profile. (links back to the 'My Account' page once done)
  * - Note that If the user already has a profile, then the existing user profile is displayed allowing the user to update it
  *****
--%>

<!-- Start - JSP File Name: QuickCheckoutProfileForm.jsp -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf" %>
<%@ include file="../../../include/nocache.jspf" %>

<%-- ErrorMessageSetup.jspf is used to retrieve an appropriate error message when there is an error --%>
<%@ include file="../../../include/ErrorMessageSetup.jspf" %>

<c:set var="returnPage" value="${WCParam.returnPage}" />

<c:set var="yearString" scope="request">
	<fmt:message key="YEAR" bundle="${storeText}"/>
</c:set>
<c:set var="monthString" scope="request">
	<fmt:message key="MONTH" bundle="${storeText}"/>
</c:set>
<c:set var="cardExpiryYearValue" value="${yearString}" scope="request"/>
<c:set var="cardExpiryMonthValue" value="${monthString}" scope="request"/>

<jsp:useBean id="billingAddressInfoMap" class="java.util.HashMap" scope="request"/>
<jsp:useBean id="shippingAddressInfoMap" class="java.util.HashMap" scope="request"/>
<jsp:useBean id="edp_ProtocolData" class="java.util.HashMap" scope="request"/>

<wcbase:useBean id="orderListBean" classname="com.ibm.commerce.order.beans.OrderListDataBean" scope="request"> 
	<c:set target="${orderListBean}" property="storeId" value="${WCParam.storeId}"/>
	<c:set target="${orderListBean}" property="userId" value="${WCParam.userId}"/>   
	<c:set target="${orderListBean}" property="retrievalOrderStatus" value="Q"/>      	
</wcbase:useBean>  
        	
<c:forEach items="${orderListBean.orderDataBeans}" var="orderBean">
	<c:set var="payInfo" value="${orderBean.paymentInfo}" />
						
	<c:if test="${!empty payInfo.account}">
		<c:set var="payInfoAccountFlag" value="true" />
	</c:if>
</c:forEach>


<c:choose>
	<c:when test="${!empty storeError.key || WCParam.selection_changed =='true'}" >
		<%-- if there is an error, prepopulate the entry fields with the submitted data --%>

		<c:set target="${shippingAddressInfoMap}" property="addressId" value="${WCParam.shipping_addressId}"/>
		<c:set target="${shippingAddressInfoMap}" property="nickName" value="${WCParam.shipping_nickName}"/>
		<c:set target="${shippingAddressInfoMap}" property="addressType" value="${WCParam.shipping_addressType}"/>
		<c:set target="${shippingAddressInfoMap}" property="primary" value="${WCParam.shipping_primary}"/>
		<c:set target="${shippingAddressInfoMap}" property="lastName" value="${WCParam.shipping_lastName}"/>
		<c:set target="${shippingAddressInfoMap}" property="firstName" value="${WCParam.shipping_firstName}"/>
		<c:set target="${shippingAddressInfoMap}" property="address1" value="${WCParam.shipping_address1}"/>
		<c:set target="${shippingAddressInfoMap}" property="address2" value="${WCParam.shipping_address2}"/>
		<c:set target="${shippingAddressInfoMap}" property="city" value="${WCParam.shipping_city}"/>
		<c:set target="${shippingAddressInfoMap}" property="state" value="${WCParam.shipping_state}"/>
		<c:set target="${shippingAddressInfoMap}" property="zipCode" value="${WCParam.shipping_zipCode}"/>
		<c:set target="${shippingAddressInfoMap}" property="country" value="${WCParam.shipping_country}"/>
		<c:set target="${shippingAddressInfoMap}" property="phone1" value="${WCParam.shipping_phone1}"/>
	
		<c:set target="${billingAddressInfoMap}" property="addressId" value="${WCParam.billing_addressId}"/>
		<c:set target="${billingAddressInfoMap}" property="nickName" value="${WCParam.billing_nickName}"/>
		<c:set target="${billingAddressInfoMap}" property="addressType" value="${WCParam.billing_addressType}"/>
		<c:set target="${billingAddressInfoMap}" property="primary" value="${WCParam.billing_primary}"/>
		<c:set target="${billingAddressInfoMap}" property="lastName" value="${WCParam.billing_lastName}"/>
		<c:set target="${billingAddressInfoMap}" property="firstName" value="${WCParam.billing_firstName}"/>
		<c:set target="${billingAddressInfoMap}" property="address1" value="${WCParam.billing_address1}"/>
		<c:set target="${billingAddressInfoMap}" property="address2" value="${WCParam.billing_address2}"/>
		<c:set target="${billingAddressInfoMap}" property="city" value="${WCParam.billing_city}"/>
		<c:set target="${billingAddressInfoMap}" property="state" value="${WCParam.billing_state}"/>
		<c:set target="${billingAddressInfoMap}" property="zipCode" value="${WCParam.billing_zipCode}"/>
		<c:set target="${billingAddressInfoMap}" property="country" value="${WCParam.billing_country}"/>
		<c:set target="${billingAddressInfoMap}" property="phone1" value="${WCParam.billing_phone1}"/>
	
		<c:set target="${edp_ProtocolData}" property="payment_method" value="${WCParam.pay_payment_method}"/>
		<c:if test="${payInfoAccountFlag == 'true'}">
			<c:set target="${edp_ProtocolData}" property="account" value="${WCParam.pay_account_temp}"/>
		</c:if>
		<c:set target="${edp_ProtocolData}" property="cc_brand" value="${WCParam.pay_cc_brand}"/>
		<c:set target="${edp_ProtocolData}" property="card_brand" value="${WCParam.pay_card_brand}"/>
		<c:set target="${edp_ProtocolData}" property="expire_year" value="${WCParam.pay_expire_year}"/>
		<c:set target="${edp_ProtocolData}" property="expire_month" value="${WCParam.pay_expire_month}"/>
		<c:set target="${edp_ProtocolData}" property="cc_cvc" value="${WCParam.pay_cc_cvc}"/>

	</c:when>
	<c:otherwise>
		<%-- We are executing under regular circumstances. Try to query for all quick checkout info. --%>
		
		<c:forEach items="${orderListBean.orderDataBeans}" var="orderBean" varStatus="status">
			<c:set var="payInfo" value="${orderBean.paymentInfo}" />
			<c:if test="${!empty payInfo && (empty WCParam.paymentMethod || payInfo.payment_method == WCParam.paymentMethod)}">
				<c:set target="${edp_ProtocolData}" property="payment_method" value="${payInfo.payment_method}"/>
				<c:set target="${edp_ProtocolData}" property="account" value="${payInfo.account}"/>
				<c:set target="${edp_ProtocolData}" property="cc_brand" value="${payInfo.cc_brand}"/>
				<c:set target="${edp_ProtocolData}" property="card_brand" value="${payInfo.card_brand}"/>
				<c:set target="${edp_ProtocolData}" property="expire_year" value="${payInfo.expire_year}"/>
				<c:set target="${edp_ProtocolData}" property="expire_month" value="${payInfo.expire_month}"/>
				<c:set target="${edp_ProtocolData}" property="cc_cvc" value="${payInfo.cc_cvc}"/>
			</c:if>
	
			<c:set var="billingAddressBean" value="${orderBean.currentAddressDataBean}"  scope="request"/>
			<c:if test="${!empty billingAddressBean}">
				<c:set target="${billingAddressInfoMap}" property="addressId" value="${billingAddressBean.addressId}"/>
				<c:set target="${billingAddressInfoMap}" property="nickName" value="${billingAddressBean.nickName}"/>
				<c:set target="${billingAddressInfoMap}" property="addressType" value="${billingAddressBean.addressType}"/>
				<c:set target="${billingAddressInfoMap}" property="primary" value="${billingAddressBean.primary}"/>
				<c:set target="${billingAddressInfoMap}" property="lastName" value="${billingAddressBean.lastName}"/>
				<c:set target="${billingAddressInfoMap}" property="firstName" value="${billingAddressBean.firstName}"/>
				<c:set target="${billingAddressInfoMap}" property="address1" value="${billingAddressBean.address1}"/>
				<c:set target="${billingAddressInfoMap}" property="address2" value="${billingAddressBean.address2}"/>
				<c:set target="${billingAddressInfoMap}" property="city" value="${billingAddressBean.city}"/>
				<c:set target="${billingAddressInfoMap}" property="state" value="${billingAddressBean.state}"/>
				<c:set target="${billingAddressInfoMap}" property="zipCode" value="${billingAddressBean.zipCode}"/>
				<c:set target="${billingAddressInfoMap}" property="country" value="${billingAddressBean.country}"/>
				<c:set target="${billingAddressInfoMap}" property="phone1" value="${billingAddressBean.phone1}"/>
			</c:if>
	
			<c:forEach items="${orderBean.orderItemDataBeans}" var="orderItemBean" varStatus="status">
				<c:set var="profileOrderItemBean" value="${orderItemBean}"  scope="request"/>
				<c:set var="shippingAddressBean" value="${orderItemBean.currentAddressDataBean}"  scope="request"/>
				<c:if test="${!empty shippingAddressBean}">
					<c:set target="${shippingAddressInfoMap}" property="addressId" value="${shippingAddressBean.addressId}"/>
					<c:set target="${shippingAddressInfoMap}" property="nickName" value="${shippingAddressBean.nickName}"/>
					<c:set target="${shippingAddressInfoMap}" property="addressType" value="${shippingAddressBean.addressType}"/>
					<c:set target="${shippingAddressInfoMap}" property="primary" value="${shippingAddressBean.primary}"/>
					<c:set target="${shippingAddressInfoMap}" property="lastName" value="${shippingAddressBean.lastName}"/>
					<c:set target="${shippingAddressInfoMap}" property="firstName" value="${shippingAddressBean.firstName}"/>
					<c:set target="${shippingAddressInfoMap}" property="address1" value="${shippingAddressBean.address1}"/>
					<c:set target="${shippingAddressInfoMap}" property="address2" value="${shippingAddressBean.address2}"/>
					<c:set target="${shippingAddressInfoMap}" property="city" value="${shippingAddressBean.city}"/>
					<c:set target="${shippingAddressInfoMap}" property="state" value="${shippingAddressBean.state}"/>
					<c:set target="${shippingAddressInfoMap}" property="zipCode" value="${shippingAddressBean.zipCode}"/>
					<c:set target="${shippingAddressInfoMap}" property="country" value="${shippingAddressBean.country}"/>
					<c:set target="${shippingAddressInfoMap}" property="phone1" value="${shippingAddressBean.phone1}"/>
				</c:if>
			</c:forEach>
		</c:forEach>
	</c:otherwise>
</c:choose>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html>
<head>
	<title><fmt:message key="UPDATEPROFILE_TITLE" bundle="${storeText}"/></title>
	<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${vfileStylesheet}"/>" type="text/css"/>

</head>

<body>

	<%@ include file="../../../include/LayoutContainerTop.jspf"%>

		<!--MAIN CONTENT STARTS HERE-->
		
		<form name="QuickCheckout" method="post" action="OrderProfileUpdate" id="QuickCheckout">
			<input type="hidden" name="storeId" value="<c:out value="${WCParam.storeId}"/>" id="WC_QuickCheckoutProfileForm_FormInput_storeId_In_QuickCheckout_1"/>
			<input type="hidden" name="langId" value="<c:out value="${langId}"/>" id="WC_QuickCheckoutProfileForm_FormInput_langId_In_QuickCheckout_1"/>
			<input type="hidden" name="catalogId" value="<c:out value="${WCParam.catalogId}"/>" id="WC_QuickCheckoutProfileForm_FormInput_catalogId_In_QuickCheckout_1"/>
			<input type="hidden" name="page" value="quickcheckout" id="WC_QuickCheckoutProfileForm_FormInput_page_In_QuickCheckout_1"/>
			<input type="hidden" name="returnPage" value="<c:out value="${returnPage}"/>" id="WC_QuickCheckoutProfileForm_FormInput_returnPage_In_QuickCheckout_1"/>
			<input type="hidden" name="errorViewName" value="ProfileFormView" id="WC_QuickCheckoutProfileForm_FormInput_errorViewName_In_QuickCheckout_1"/>
			
			<input type="hidden" name="shipping*" id="WC_QuickCheckoutProfileForm_FormInput_shipping_In_QuickCheckout_1"/>
			<input type="hidden" name="billing*" id="WC_QuickCheckoutProfileForm_FormInput_billing_In_QuickCheckout_1"/>
			<input type="hidden" name="nickName*" id="WC_QuickCheckoutProfileForm_FormInput_nickName_In_QuickCheckout_1"/>
			<input type="hidden" name="lastName*" id="WC_QuickCheckoutProfileForm_FormInput_lastName_In_QuickCheckout_1"/>
			<input type="hidden" name="firstName*" id="WC_QuickCheckoutProfileForm_FormInput_firstName_In_QuickCheckout_1"/>
			<input type="hidden" name="address*" id="WC_QuickCheckoutProfileForm_FormInput_address_In_QuickCheckout_1"/>
			<input type="hidden" name="zipCode*" id="WC_QuickCheckoutProfileForm_FormInput_zipCode_In_QuickCheckout_1"/>
			<input type="hidden" name="city*" id="WC_QuickCheckoutProfileForm_FormInput_city_In_QuickCheckout_1"/>
			<input type="hidden" name="state*" id="WC_QuickCheckoutProfileForm_FormInput_state_In_QuickCheckout_1"/>
			<input type="hidden" name="country*" id="WC_QuickCheckoutProfileForm_FormInput_country_In_QuickCheckout_1"/>
			<input type="hidden" name="phone1*" id="WC_QuickCheckoutProfileForm_FormInput_phone1_In_QuickCheckout_1"/>
			<input type="hidden" name="pay_cardNumber*" id="WC_QuickCheckoutProfileForm_FormInput_pay_cardNumber_In_QuickCheckout_1"/>
			<input type="hidden" name="orderId" value="<c:out value="${WCParam.orderId}"/>" id="WC_QuickCheckoutProfileForm_FormInput_orderId_In_QuickCheckout_1"/> 
			<input type="hidden" name="authToken" value="${authToken}" id="WC_QuickCheckoutProfileForm_FormInput_authToken_1"/> 
			
			<c:choose>
				<c:when test="${WCParam.returnPage eq 'quickcheckout'}">
					<c:choose>
						<c:when test="${WCParam.previousPage eq 'logon'}">
							<input type="hidden" name="URL" value="OrderItemMove?page=account&amp;URL=OrderCalculate%3FURL%3DOrderPrepare%3FURL%3DQuickCheckoutSummaryView" id="WC_QuickCheckoutProfileForm_FormInput_URL_In_QuickCheckout_2"/>				
							<input type="hidden" name="merge" value="*n" id="WC_QuickCheckoutProfileForm_FormInput_merge_In_QuickCheckout_1"/>
							<input type="hidden" name="remerge" value="*" id="WC_QuickCheckoutProfileForm_FormInput_remerge_In_QuickCheckout_1"/>
							<input type="hidden" name="check" value="*n" id="WC_QuickCheckoutProfileForm_FormInput_check_In_QuickCheckout_1"/>
							<input type="hidden" name="allocate" value="*" id="WC_QuickCheckoutProfileForm_FormInput_allocate_In_QuickCheckout_1"/>
							<input type="hidden" name="backorder" value="*" id="WC_QuickCheckoutProfileForm_FormInput_backorder_In_QuickCheckout_1"/>
							<input type="hidden" name="reverse" value="*n" id="WC_QuickCheckoutProfileForm_FormInput_reverse_In_QuickCheckout_1"/>
						</c:when>
						<c:otherwise>
							<c:url var="QuickCheckoutView" value="OrderPrepare">
								<c:param name="URL" value="QuickCheckoutSummaryView"/>
								<c:param name="orderId" value="${WCParam.orderId}"/>
								<c:param name="toOrderId" value="${WCParam.orderId}"/>
								<c:param name="shippingAddressFromOrderProfile" value="1"/>
								<c:param name="orderInfoFrom" value="q"/>
								<c:param name="payInfoFrom" value="q"/>
								<c:param name="langId" value="${langId}" />
								<c:param name="storeId" value="${WCParam.storeId}" />
								<c:param name="catalogId" value="${WCParam.catalogId}" />
								<c:param name="status" value="P" />	
								<c:param name="orderItemId*" value="" />
								<c:param name="quantity*" value="" />
								<c:param name="allocate" value="*" />
								<c:param name="reverse" value="*n" />
								<c:param name="backorder" value="*" />
								<c:param name="remerge" value="*" />
								<c:param name="merge" value="*n" />
								<c:param name="check" value="*n" />
								<c:param name="errorViewName" value="OrderCopyErrorView" /> 												
							</c:url>
							<input type="hidden" name="URL" value="<c:out value='${QuickCheckoutView}'/>" id="WC_QuickCheckoutProfileForm_FormInput_URL_In_QuickCheckout_1"/>				
						</c:otherwise>
					</c:choose>
				</c:when>
				<c:otherwise>
					<input type="hidden" name="URL" value="LogonForm?shipping*=&billing*=&nickName*=&lastName*=&firstName*=&address*=&zipCode*=&city*=&state*=&country*=&phone1*=&pay_cardNumber*=" id="WC_QuickCheckoutProfileForm_FormInput_URL_In_QuickCheckout_2"/>
				</c:otherwise>
			</c:choose>					
		
		
		
		<table cellpadding="0" cellspacing="0" width="786" border="0" id="WC_QuickCheckoutProfileForm_Table_1">
		<tbody>
		<tr>
			<td class="t_td" colspan="2" valign="top" id="WC_QuickCheckoutProfileForm_TableCell_1">
				<h1><fmt:message key="QUICKCHECKOUTPROFILE" bundle="${storeText}"/></h1>
				
				<%-- 
				  ***
				  *	Start: Error handling
				  * Show an appropriate error message when there is an error.
				  ***
				--%>
				<c:if test="${!empty errorMessage}">
					<span class="required"><br/><c:out value="${errorMessage}"/><br/><br/></span>
				</c:if>
				<%-- 
				  ***
				  *	End: Error handling
				  ***
				--%>				

				<span class="text"><fmt:message key="UPDATEPROFILE_INFO" bundle="${storeText}"/></span>
				<br/><br/>
				
				<span class="required">*</span>
				<span class="text"><fmt:message key="REQUIRED_FIELDS3" bundle="${storeText}"/></span>
				<br/><br/>

			</td>
		</tr>
		<tr>
			<c:import url="QuickCheckoutProfileAddress.jsp" />
		</tr>
		<tr><td class="t_td" colspan="2" id="WC_QuickCheckoutProfileForm_TableCell_2">
			<c:import url="QuickCheckoutProfileShipMode.jsp" />
		</td></tr>
		<tr><td class="t_td" colspan="2" id="WC_QuickCheckoutProfileForm_TableCell_3">
		
		<c:set var ="edp_PI_Form" value="QuickCheckout" scope="request"/>
			<c:import url="QuickCheckoutProfilePaymentForm.jsp" />

			<%--
			<c:import url="../../../Snippets/EDP/PaymentMethods/PaymentMethodsDisplay.jsp" >
			</c:import>
			--%>
		</td>
		</tr>
		</tbody>
		</table>

		<br/>
		<a href="javascript:UpdateProfile(document.QuickCheckout)" class="button" id="WC_QuickCheckoutProfileForm_Link_100">
			<fmt:message key="SUBMIT" bundle="${storeText}"/>
		</a>

		</form>
 
<jsp:useBean id="now" class="java.util.Date"/>
<c:set var="current_month_index" value="${now.month}"/>
<c:set var="current_year" value="${now.year + 1900}"/>
<c:set var="current_day" value="${now.day}"/>


	<script type="text/javascript" language="javascript">
	<!-- <![CDATA[
	var payment_changed = 'false';
	function copyBillingForm(form)
	{
		if (form.sameaddress.checked)
		{
			form.shipping_address1.value = form.billing_address1.value
			form.shipping_address2.value = form.billing_address2.value
			form.shipping_city.value = form.billing_city.value
			form.shipping_state.value = form.billing_state.value
			form.shipping_zipCode.value = form.billing_zipCode.value
			form.shipping_country.value = form.billing_country.value
			form.shipping_phone1.value = form.billing_phone1.value
		}
	}
	
	function UpdateProfile(form)
	{			
		if(document.getElementsByName("pay_account")[0].value == null || document.getElementsByName("pay_account")[0].value == "" || document.getElementsByName("pay_account")[0].value == undefined) {
			alert("<fmt:message key='CARD_NUMBER' bundle='${storeText}'/>");
		return;
		}
		
		if(payment_changed == 'false') {
					
			if(document.getElementsByName("pay_account")!= null || document.getElementsByName("pay_account") != undefined) {
				document.getElementsByName("pay_account")[0].name = 'pay_account_temp';
			}
		}
		form.submit()
	}

	<%-- 
	  ***
	  * This javascript function is used by the address 'Submit' button.
	  * It is used to ensure that the entered value does not exceed the maximum number of bytes allowed.
	  * This function makes use of isValidUTF8length function.  Details about that function can be found in Util.js.
	  ***
	 --%>
	function submitForm(form) {
		if     (!isValidUTF8length(form.address1.value     , 50 )) { alert("<fmt:message key="ERROR_AddressTooLong"       bundle="${storeText}"/>"); }
		else if(!isValidUTF8length(form.address2.value     , 50 )) { alert("<fmt:message key="ERROR_AddressTooLong"       bundle="${storeText}"/>"); }
		else if(!isValidUTF8length(form.city.value         , 128)) { alert("<fmt:message key="ERROR_CityTooLong"          bundle="${storeText}"/>"); }
		else if(!isValidUTF8length(form.state.value        , 128)) { alert("<fmt:message key="ERROR_StateTooLong"         bundle="${storeText}"/>"); }
		else if(!isValidUTF8length(form.country.value      , 128)) { alert("<fmt:message key="ERROR_CountryTooLong"       bundle="${storeText}"/>"); }
		else if(!isValidUTF8length(form.zipCode.value      , 40 )) { alert("<fmt:message key="ERROR_ZipCodeTooLong"       bundle="${storeText}"/>"); }
	
		else if(!isValidUTF8length(form.phone1.value       , 32 )) { alert("<fmt:message key="ERROR_PhoneTooLong"         bundle="${storeText}"/>"); }
	
		else {
			//verify address fields #1-#2, if #2 is filled and not #1 then move the data for the user
			if (form.address1.value == "") {
				if (form.address2.value != "") {
					form.address1.value = form.address2.value;
					form.address2.value = "";
				}
			}
	
		 	form.submit();
		 }
	}

<%-- 
	  ***
	  * This javascript function is called from Payment method JSP page
	  * It is used to clear the values of specific fields of FORM
	  ***
 --%>
function paymentChanged(form, elementArray, payment_field_name)
{
	if(form.elements["payment_reset"].value == 'false')
	{
		var payment_field_value = form.elements[payment_field_name].value;
		//Reset all payment feilds
		clearElements(elementArray);
		form.elements[payment_field_name].value = payment_field_value;
		form.elements["payment_reset"].value = 'true';
		payment_changed = 'true';
	}
}


<%-- 
	  ***
	  * This javascript function is called from function paymentChanged
	  * It is used to clear the values of specific fields of FORM
	  ***
 --%>
function clearElements(elementArray)
{
	var element;
	for(element in elementArray){
		if(elementArray[element] != undefined)
		{
			switch (elementArray[element].type)
			{
				case "text":
					elementArray[element].value="";
					break;
				case "select-one":
					//Need to set date-time related field to current date-time
					//We have to use indexOf() method instead of directly using field name
					//because the field names are not consistent across all payment method
					
					//if(elementArray[element].name.toLowerCase().indexOf("day")){
					//	elementArray[element].selectedIndex=<c:out value="${current_day}"/>
					//}
					//if(elementArray[element].name.toLowerCase().indexOf("month") != -1 && !isNaN('<c:out value="${current_month_index}"/>')){
					//	elementArray[element].selectedIndex = <c:out value="${current_month_index}"/>;
					//}
					//else if (elementArray[element].name.toLowerCase().indexOf("year") != -1 && !isNaN('<c:out value="${current_year}"/>')){
					//	var year_options = elementArray[element].options;
					//	elementArray[element].selectedIndex = 0;
					//	for(var option in year_options){
					//		if(!isNaN(option) 
					//				&& elementArray[element].options[option].text != undefined 
					//					&& elementArray[element].options[option].text == '<c:out value="${current_year}"/>'){
					//			elementArray[element].selectedIndex = option;
					//		}
					//	}
					//}
					//else{
					//	elementArray[element].selectedIndex="0";
					//}
					break;
				//case "hidden":
					//Do nothing
					//For future use
				//	break;
				//case "button":
					//Do nothing
					//For future use
				//	break;
				//case "radio":
					//Do nothing
					//For future use
				//	break;
				//case "checkbox":
					//Do nothing
					//For future use
				//	break;
				//case "select-multiple":
					//Do nothing
					//For future use
				//	break;
				default:
					//Do nothing
			}
		}
		element++;
	}
}
//[[>-->
</script>

	<%-- Hide CIP --%>
	<c:set var="HideCIP" value="true"/>

	<%@ include file="../../../include/LayoutContainerBottom.jspf"%>

</body>
</html>

<!-- End - JSP File Name: QuickCheckoutProfileForm.jsp -->
