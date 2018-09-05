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
  * This page allows the user to choose and define shipping addresses for the order.
  * It is present during check out if the Accelerator "Change Flow" option "Single Shipping Address" is chosen.
  * The main content includes:
  * - Buttons to 'Create new address' and 'Edit address book'
  * - For each address:  a radio button for the address (with the address printed beside it).
  *****
--%>

<% // All JSPs requires the first 4 packages for getResource.jsp which is used for multi language support %> 

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf" %>
<%@ include file="../../../include/nocache.jspf" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>

<head>
	<title>
		<fmt:message key="SHIPADDRESS_TITLE" bundle="${storeText}"/>
	</title>
	<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${vfileStylesheet}"/>" type="text/css"/>
	
	<script type="text/javascript" language="javascript" src="<c:out value="${jspStoreImgDir}"/>javascript/Util.js">

	</script>
	<script type="text/javascript" language="javascript">
	<%-- 
	  	***
		* This javascript function is used by the address 'Submit' button.
  		* It is used to ensure that the entered value does not exceed the maximum number of bytes allowed.
  		* This function makes use of isValidUTF8length function.  Details about that function can be found in Util.js.
  		***
 	--%>

	function submitForm(form)
	{
		// submit the shipping address entered by the user
		if (!isValidUTF8length(form.address1.value, 50) 
		|| !isValidUTF8length(form.address2.value, 50))
		{
			<fmt:message key="ERROR_AddressTooLong" bundle="${storeText}" var="ERROR_AddressTooLong" />
			alert(<wcf:json object="${ERROR_AddressTooLong}"/>);
		}
		else
		{
			form.submit();
		}
	}

	</script>
	
</head>

	<body>
	<!-- JSP File Name:  SingleShippingAddressDisplay.jsp -->

	<%@ include file="../../../include/LayoutContainerTop.jspf"%>
	
		<!--MAIN CONTENT STARTS HERE-->
			<table cellpadding="0" cellspacing="0" border="0" width="100%" id="WC_SingleShippingAddressDisplay_Table_1">
				<tr>
					<td id="WC_SingleShippingAddressDisplay_TableCell_1">
						<c:set var="bctCurrentPage" value="ShippingAddress" />
	               				<%@ include file="../../../Snippets/Order/Cart/BreadCrumbTrailDisplay.jspf" %>
					</td>
				</tr>

				<%-- Instantiate the order data bean required by the snippet --%>
				<wcbase:useBean id="orderBean" classname="com.ibm.commerce.order.beans.OrderDataBean" scope="page">
					<c:set value="${WCParam.orderId}" target="${orderBean}" property="orderId"/>
				</wcbase:useBean>	
				<c:url var="ShippingMethodURL" value="MultipleShippingMethodView"/>
				<c:set var="displayNamesSection" value="false"/>
				<tr>
					<td id="WC_SingleShippingAddressDisplay_TableCell_2">
						<%@ include file="../../../Snippets/Order/Ship/SingleShippingAddress.jspf" %>
					</td>
				</tr>

			</table>
	
	
		<!--MAIN CONTENT ENDS HERE-->
		
	<%-- Hide CIP --%>
	<c:set var="HideCIP" value="true"/>

	<%@ include file="../../../include/LayoutContainerBottom.jspf"%>

	</body>
</html>
