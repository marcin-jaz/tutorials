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
  * This JSP page displays the billing and shipping information.  One can choose from
  * a list of billing addresses to use with an order.  One can also select from a list of 
  * shipping addresses and shipping methods to use.
  *  - an Address Book button is available if one wants to add/edit an address.
  *****
--%>
<% // All JSPs requires the first 4 packages for getResource.jsp which is used for multi language support %>
<% // All JSPs requires these packages for EnvironmentSetup.jsp which is used for multi language support %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ taglib uri="flow.tld" prefix="flow" %>

<%@ include file="../../../include/JSTLEnvironmentSetup.jspf" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<!-- BEGIN SingleShippingAddressDisplay.jsp -->
<head>
<title><fmt:message key="Ship_Title" bundle="${storeText}"/></title>
<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${vfileStylesheet}"/>" type="text/css"/>
</head>
<script language="javascript" src="<c:out value="${jspStoreImgDir}javascript/Util.js"/>"></script>

<body class="noMargin">

<%@ include file="../../../include/LayoutContainerTop.jspf"%>

<table cellpadding="0" cellspacing="0" border="0" class="p_width" id="WC_SingleShippingAddressDisplay_Table_1">
<tr>
<td id="WC_SingleShippingAddressDisplay_TableCell_1">

	<%-- bread crumb trail snippet --%>
	<c:set var="bctCurrentPage" value="ShippingAddress" />
	<%@ include file="../../../Snippets/Order/Cart/BreadCrumbTrailDisplay.jspf"%>
	
	<wcbase:useBean id="orderBean" classname="com.ibm.commerce.order.beans.OrderDataBean">
		<c:set value="${WCParam.orderId}" target="${orderBean}" property="orderId"/>
	</wcbase:useBean>
	<c:set var="ShippingMethodURL" value="MultipleShippingMethodView?orderItemId*=&quantity*="/>
	<c:set var="displayNamesSection" value="true"/>
	<%@ include file="../../../Snippets/Order/Ship/SingleShippingAddress.jspf"%>

</td>
</tr>
</table>

<%-- Hide CIP --%>
<c:set var="HideCIP" value="true"/>

<%@ include file="../../../include/LayoutContainerBottom.jspf"%>

<script language="javascript">
   function submitForm(form) 
   {     
       
	  <fmt:message key="Reg_ERROR_NickNameTooLong" bundle="${storeText}" var="Reg_ERROR_NickNameTooLong" />
	  <fmt:message key="Reg_ERROR_AddressTooLong" bundle="${storeText}" var="Reg_ERROR_AddressTooLong" />
	  <fmt:message key="Reg_ERROR_CityTooLong" bundle="${storeText}" var="Reg_ERROR_CityTooLong" />
	  <fmt:message key="Reg_ERROR_StateTooLong" bundle="${storeText}" var="Reg_ERROR_StateTooLong" />
	  <fmt:message key="Reg_ERROR_CountryTooLong" bundle="${storeText}" var="Reg_ERROR_CountryTooLong" />
	  <fmt:message key="Reg_ERROR_ZipCodeTooLong" bundle="${storeText}" var="Reg_ERROR_ZipCodeTooLong" />
	  <fmt:message key="Reg_ERROR_PhoneTooLong" bundle="${storeText}" var="Reg_ERROR_PhoneTooLong" />
		if(!isValidUTF8length(form.nickName.value     , 50 )) { alert(<wcf:json object="${Reg_ERROR_NickNameTooLong}"/>); }
	
		else if(!isValidUTF8length(form.address1.value     , 50 )) { alert(<wcf:json object="${Reg_ERROR_AddressTooLong}"/>); }
		else if(!isValidUTF8length(form.address2.value     , 50 )) { alert(<wcf:json object="${Reg_ERROR_AddressTooLong}"/>); }
		else if(!isValidUTF8length(form.city.value         , 128)) { alert(<wcf:json object="${Reg_ERROR_CityTooLong}"/>); }
		else if(!isValidUTF8length(form.state.value        , 128)) { alert(<wcf:json object="${Reg_ERROR_StateTooLong}"/>); }
		else if(!isValidUTF8length(form.country.value      , 128)) { alert(<wcf:json object="${Reg_ERROR_CountryTooLong}"/>); }
		else if(!isValidUTF8length(form.zipCode.value      , 40 )) { alert(<wcf:json object="${Reg_ERROR_ZipCodeTooLong}"/>); }
		else if(!isValidUTF8length(form.phone1.value       , 32 )) { alert(<wcf:json object="${Reg_ERROR_PhoneTooLong}"/>); }
	
		else {  
		//verify address fields #1-#2, if #2 is filled and not #1 then move the data for the user
			if (form.address1.value == "") {
				if (form.address2.value != "") {
					form.address1.value = form.address2.value;
					form.address2.value = "";
				}
			}

	 	 	form.primary.value = '0';       		  
			form.addressType.value = 'SB';
			form.URL.value = 'MultipleShippingAddressView';
			form.submit();
	  }
   }
 
</script>

</body>
<!-- END SingleShippingAddressDisplay.jsp -->
</html>
