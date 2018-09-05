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
<%@ taglib uri="flow.tld" prefix="flow" %>

<%@ include file="../../../include/JSTLEnvironmentSetup.jspf" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<!-- BEGIN MultipleShippingAddressDisplay.jsp -->
<head>
<title><fmt:message key="Ship_Title" bundle="${storeText}"/></title>
<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${vfileStylesheet}"/>" type="text/css"/>
</head>
<body class="noMargin">

<%@ include file="../../../include/LayoutContainerTop.jspf"%>

<table cellpadding="0" cellspacing="0" border="0" class="p_width" id="WC_MultipleShippingAddressDisplay_Table_1">
<tr>
<td id="WC_MultipleShippingAddressDisplay_TableCell_1">

	<%-- bread crumb trail snippet --%>
	<c:set var="bctCurrentPage" value="ShippingAddress" />
	<%@ include file="../../../Snippets/Order/Cart/BreadCrumbTrailDisplay.jspf"%>

	<c:set var="pageSize" value="${maxOrderItemsPerPage}"/>
	<c:if test="${empty pageSize}">
		<c:set var="pageSize" value="20"/>
	</c:if>
	<c:set var="currentPage" value="${WCParam.currentPage}"/>
	<c:if test="${empty currentPage}">
		<c:set var="currentPage" value="1"/>
	</c:if>
	
	<wcbase:useBean id="orderBean" classname="com.ibm.commerce.order.beans.OrderDataBean">
		<c:set value="${WCParam.orderId}" target="${orderBean}" property="orderId"/>
		<c:set value="${pageSize}" target="${orderBean}" property="pageSize"/>
		<c:set value="${currentPage}" target="${orderBean}" property="currentPage"/>
	</wcbase:useBean>
	
	<%-- get pageSize from OrderDataBean again - if passed in page size is greater than max value, pageSize will set to max value --%>
	<c:set var="pageSize" value="${orderBean.pageSize}"/>
		
	<c:set var="ShippingMethodURL" value="MultipleShippingMethodView" />
	
	<%@ include file="../../../Snippets/Order/Ship/MultipleShippingAddress.jspf"%>

</td>
</tr>
</table>

<%-- Hide CIP --%>
<c:set var="HideCIP" value="true"/>

<%@ include file="../../../include/LayoutContainerBottom.jspf"%>

</body>
<!-- END MultipleShippingAddressDisplay.jsp -->
</html>
