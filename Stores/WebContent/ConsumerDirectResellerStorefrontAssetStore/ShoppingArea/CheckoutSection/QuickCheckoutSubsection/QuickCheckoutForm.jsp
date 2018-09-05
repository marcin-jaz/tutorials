<%
//********************************************************************
//*-------------------------------------------------------------------
//* Licensed Materials - Property of IBM
//* 
//* WebSphere Commerce
//*
//* (c) Copyright IBM Corp. 2000, 2002, 2004
//*
//* US Government Users Restricted Rights - Use, duplication or
//* disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
//*
//*-------------------------------------------------------------------
//*
%>
 
<%-- 
  *****
  * This page shows the order summary for the user's order(s)
  * The page has two major "Change Flow" (Accelerator, store menu) options that affect the code:
  * - Commerce Payments
  * - Multiple Shipping Address
  * The main content panel shows:
  *		- includes MultiAddressCheckout.jsp if multiple shipping address flexflow option is turned on
  *		- includes SingleAddressCheckout.jsp if single shipping address flexflow option is turned on
  * - Clickable billing address (links to billing address page)
  * - Payment information choices (includes, if appropriate, StandardCreditCard.jspf)
  *****
--%>

<!-- Start - JSP File Name: QuickCheckoutForm.jsp -->


<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf" %>
<%-- ErrorMessageSetup.jspf is used to retrieve an appropriate error message when there is an error --%>
<%@ include file="../../../include/ErrorMessageSetup.jspf" %>

<flow:ifDisabled feature="GiftRegistry">
<wcbase:useBean id="orderBean" classname="com.ibm.commerce.order.beans.OrderDataBean" scope="page">
	<c:set property="orderId" value="${WCParam.orderId}" target="${orderBean}" />
</wcbase:useBean> 
</flow:ifDisabled>
<%-- 
  ***
  *	Start: GiftRegistryCode
  *
  ***
--%>
<flow:ifEnabled feature="GiftRegistry">
<c:remove var="orderBean"/>
<%@ include file="..\..\..\Snippets\QuickCheckoutGRForm.jspf" %>
</flow:ifEnabled>
<%-- 
  ***
  *	End: GiftRegistryCode
  ***
--%>	 
<wcbase:useBean id="promoCodeListBean" classname="com.ibm.commerce.marketing.databeans.PromoCodeListDataBean" scope="page">
	<c:set property="orderId" value="${WCParam.orderId}" target="${promoCodeListBean}" />
</wcbase:useBean> 

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
	<title><fmt:message key="QUICKCHECKOUT_TITLE" bundle="${storeText}"/></title>
       	<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${vfileStylesheet}"/>" type="text/css"/>
</head>
<body>
<!-- JSP File Name:  QuickCheckoutForm.jsp -->

	<%@ include file="../../../include/LayoutContainerTop.jspf"%>

	<!--MAIN CONTENT STARTS HERE-->
	
	<h1><fmt:message key="QUICKCHECKOUT" bundle="${storeText}"/> - <fmt:message key="ORDER_SUMMARY1" bundle="${storeText}"/></h1>

	<%-- 
	  ***
	  *	Start: Error handling
	  * Show an appropriate error message when there is an error processing the payment information.
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

	<table cellpadding="0" cellspacing="0" width="786" border="0" id="WC_QuickCheckoutForm_Table_1">
	<tbody>
		<tr>
			<td id="WC_QuickCheckoutForm_TableCell_1">
			<% out.flush(); %>
			<c:import url="../../../Snippets/Order/Inventory/CurrentAndTotalCharges.jsp" >
				<c:param name="orderId" value="${WCParam.orderId}"/>
				<c:param name= "showCurrentCharges" value="true"/>
				<c:param name= "showFutureCharges"  value="true"/>
			</c:import>
			<% out.flush();%>
			
			<c:url var="ShippingMethodURL" value="MultipleShippingMethodView">
				<c:param name="storeId" value="${WCParam.storeId}" />
				<c:param name="catalogId" value="${WCParam.catalogId}" />
				<c:param name="orderId" value="${WCParam.orderId}" />
			</c:url>
			
			<% out.flush(); %>
			<c:import url="../../../Snippets/EDP/PaymentMethods/PaymentMethodsDisplay.jsp" >
				<c:param name="orderId" value="${WCParam.orderId}"/>
				<c:param name="previousURL" value="${ShippingMethodURL}"/>
				<c:param name="doNotCollectPaymentForZeroAmount" value="true"/>	
				<c:param name="quickCheckout" value="true" />
			</c:import>
			<% out.flush(); %>
			</td>		
		</tr>
	</tbody>
	</table>

	<script language="javascript">
	var busy = false;
	
	function Handle_Submit(form)
	{
		if (!busy)
		{
			busy = true;			
			// for simple payments, copy the selected policyId to the policyId form element
			<flow:ifDisabled feature="PurchaseOrderOnlyDisplay">
			<flow:ifDisabled feature="CommercePaymentsSupport">
			
			if (form.policyId[form.policyId.length-1].checked && form.cardBrand!="Undefined" && form.cardBrand != null)
			{
				var selectedIndex = form.cardBrand.selectedIndex;
				if (form.cardBrand.options[selectedIndex].value != "Undefined" && form.cardBrand.options[selectedIndex].value !=null)
				{
					form.creditCardPolicyNumber.value = form.cardBrand.options[selectedIndex].value;
					form.policyId[form.policyId.length-1].value=form.cardBrand.options[selectedIndex].value;
					form.cardBrand.options[selectedIndex].value = form.cardBrand.options[selectedIndex].text;
				}
			}
			else
			{
				if (form.cardBrand!="Undefined" && form.cardBrand != null)
				{
					var selectedIndex = form.cardBrand.selectedIndex;
					form.cardBrand.options[selectedIndex].value = "";
				}
			}
			</flow:ifDisabled>
			</flow:ifDisabled>
			form.submit();
		}	
		return false;
	}
	</script>

	<!-- MAIN CONTENT ENDS HERE -->

	<%-- Hide CIP --%>
	<c:set var="HideCIP" value="true"/>

	<%@ include file="../../../include/LayoutContainerBottom.jspf"%>

</body>
</html>
<!-- End - JSP File Name: QuickCheckoutForm.jsp -->
