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
  * This page allows the user to choose and define shipping addresses for each item in the order.
  * It is present during check out if the Accelerator "Change Flow" option "Multiple Shipping Addresses" is enabled.
  * The main content includes:
  * - Buttons to 'Create new address' and 'Edit address book'
  * - For each order item:  quantity, clickable item description, and 'Ship to' dropdown selection.
  *****
--%>


<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf"%>
<%@ include file="../../../include/nocache.jspf" %>

<%--
	***
	* Begin: GiftRegistryCode
	***
--%>
<flow:ifEnabled feature="GiftRegistry">
<%@ include file="..\..\..\Snippets\MultipleShippingGRAddressDisplay.jspf" %>
 </flow:ifEnabled>
<%--
	***
	* End: GiftRegistryCode
	***
--%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
	<title><fmt:message bundle="${storeText}" key="SHIPADDRESS_TITLE"/></title>
	<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${vfileStylesheet}"/>" type="text/css"/>
</head>

	<body>
	<!-- JSP File Name:  MultipleShippingAddressDisplay.jsp -->
	<%--
	***
	* Begin: GiftRegistryCode
	***
--%>
<flow:ifEnabled feature="GiftRegistry">
<script language="JavaScript">
function setShipToRegistrant(dropDown, shipToRegistrantField){		
	if (dropDown.options[dropDown.selectedIndex].value == ''){
		shipToRegistrantField.value ='1';
	} else {
		shipToRegistrantField.value = '0';
	}
	}
</script>
</flow:ifEnabled>
<%--
***
* End: GiftRegistryCode
***
--%>

	<%@ include file="../../../include/LayoutContainerTop.jspf"%>
	
		<!--MAIN CONTENT STARTS HERE-->
		<%--
		/* 
		 * By default, all input parameters to the controller command are propagated to the redirect view command.
		 *  If there is a limit on the number of characters in the redirect URL, this may cause a problem.
		 *  To handle a limited length redirect URL, the URL parameter below uses special characters to indicate 
		 *  that certain input parameters should be removed. For example, you can specify the following as the URL parameter: 
		 *  orderItemId*=&quantity*=
		 *  This specification means that all parameters whose names start with orderItemId and quantity should be removed.
		 */
		--%>
		<table cellpadding="0" cellspacing="0" border="0" width="100%" id="WC_MultipleShippingAddressDisplay_Table_1">
			<tr>
				<td id="WC_MultipleShippingAddressDisplay_TableCell_1">
					<c:set var="bctCurrentPage" value="ShippingAddress" />
					<%@ include file="../../../Snippets/Order/Cart/BreadCrumbTrailDisplay.jspf" %>
				</td>
	    </tr>
	    <flow:ifDisabled feature="GiftRegistry">
			<c:set var="pageSize" value="${maxOrderItemsPerPage}"/>
			<c:if test="${empty pageSize}">
				<c:set var="pageSize" value="20"/>
			</c:if>
			<c:set var="currentPage" value="${WCParam.currentPage}"/>
			<c:if test="${empty currentPage}">
				<c:set var="currentPage" value="1"/>
			</c:if>

			<wcbase:useBean id="orderBean" classname="com.ibm.commerce.order.beans.OrderDataBean">
				<c:set property="orderId" value="${WCParam.orderId}" target="${orderBean}"/>
				<c:set property="pageSize" value="${pageSize}" target="${orderBean}"/>
				<c:set property="currentPage" value="${currentPage}" target="${orderBean}"/>
			</wcbase:useBean>
		
			<%-- get pageSize from OrderDataBean again - if passed in page size is greater than max value, pageSize will set to max value --%>
			<c:set var="pageSize" value="${orderBean.pageSize}"/>
		</flow:ifDisabled>
			<c:url var="ShippingMethodURL" value="MultipleShippingMethodView"/>
		
			<tr>
				<td id="WC_MultipleShippingAddressDisplay_TableCell_2" >
				<%@ include file="../../../Snippets/Order/Ship/MultipleShippingAddress.jspf" %>
				</td>
			</tr>
		</table>

		<!--MAIN CONTENT ENDS HERE-->
		
	<%-- Hide CIP --%>
	<c:set var="HideCIP" value="true"/>

	<%@ include file="../../../include/LayoutContainerBottom.jspf"%>

	</body>
</html>
