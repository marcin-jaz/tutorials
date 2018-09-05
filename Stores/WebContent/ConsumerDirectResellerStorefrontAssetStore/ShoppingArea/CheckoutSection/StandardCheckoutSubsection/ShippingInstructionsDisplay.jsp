<%--
/*
 *-------------------------------------------------------------------
 * Licensed Materials - Property of IBM
 *
 * WebSphere Commerce
 *
 * (c) Copyright International Business Machines Corporation. 2004, 2005
 *     All rights reserved.
 *
 * US Government Users Restricted Rights - Use, duplication or
 * disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
 *
 *-------------------------------------------------------------------
 */
--%>
<%-- 
  *****
  * This JSP page displays shipping information.  One can enter shipping instructions
  * for each set of order items grouped by shipping mode and shipping destination.
  *****
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>

<%@ include file="../../../include/JSTLEnvironmentSetup.jspf" %>
<%@ include file="../../../include/nocache.jspf" %>
<c:set var="pageSize" value="${maxOrderItemsPerPage}"/>
<c:if test="${empty pageSize}">
	<c:set var="pageSize" value="20"/>
</c:if>
<c:set var="currentPage" value="${WCParam.currentPage}"/>
<c:if test="${empty currentPage}">
	<c:set var="currentPage" value="1"/>
</c:if>

<wcbase:useBean id="orderBean" classname="com.ibm.commerce.order.beans.OrderDataBean" scope="page">
<c:set target="${orderBean}" property="orderId" value="${WCParam.orderId}"/>
<c:set target="${orderBean}" property="pageSize" value="${pageSize}"/>
<c:set target="${orderBean}" property="currentPage" value="${currentPage}"/>
</wcbase:useBean>

<%-- get pageSize from OrderDataBean again - if passed in page size is greater than max value, pageSize will set to max value --%>
<c:set var="pageSize" value="${orderBean.pageSize}"/>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<!-- BEGIN ShippingInstructionsDisplay.jsp -->
<head>
<title><fmt:message key="ShippingInstructions_Title" bundle="${storeText}"/></title>
<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${vfileStylesheet}"/>" type="text/css"/>
</head>
	
	<body>
	<!-- JSP File Name:  ShippingInstructionsDisplay.jsp -->
<script type="text/javascript" language="javascript">
<!--<![CDATA[
function submitForm(form)
{
	if(form.currentPage!= undefined){
		var pageNumber = parseInt(form.currentPage.value);
		if ( pageNumber !="NaN" && pageNumber >=1 && pageNumber > <c:out value="${orderBean.totalPages}" /> )
			form.currentPage.value = 1;
	}
	form.submit();
}

//[[>-->
</script>

	<%@ include file="../../../include/LayoutContainerTop.jspf"%>
	<!--MAIN CONTENT STARTS HERE-->
	
	<h1><fmt:message key="ShippingInstructions_Title" bundle="${storeText}"/></h1>

		<table cellpadding="0" cellspacing="0" border="0" width="100%" id="WC_ShippingInstructionsDisplay_Table_1">
		<tbody>
		<tr>
			<td id="WC_ShippingInstructionsDisplay_TableCell_4" >

	<c:url var="UpdateURL" value="ShippingInstructionsView">
		<c:param name="langId" value="${WCParam.langId}" />
		<c:param name="storeId" value="${WCParam.storeId}" />
		<c:param name="catalogId" value="${WCParam.catalogId}" />
		<c:param name="orderId" value="${WCParam.orderId}" />
	</c:url>
	<form name="ShippingInstructionBlocksForm" action="ShipInfoUpdate" method="post" id="WC_ShippingInstructionsDisplay_Form_1">
		<input type="hidden" name="orderId" value="<c:out value="${WCParam.orderId}"/>" id="ShippingInstructionBlocksForm_FormInput_orderId_In_ShopCartForm_1"/>
		<input type="hidden" name="langId" value="<c:out value="${WCParam.langId}"/>" id="ShippingInstructionBlocksForm_FormInput_langId_In_ShopCartForm_1"/>
		<input type="hidden" name="storeId" value="<c:out value="${WCParam.storeId}"/>" id="ShippingInstructionBlocksForm_FormInput_storeId_In_ShopCartForm_1"/>
		<input type="hidden" name="catalogId" value="<c:out value="${WCParam.catalogId}"/>" id="ShippingInstructionBlocksForm_FormInput_catalogId_In_ShopCartForm_1"/>
		<input type="hidden" name="URL" value="OrderDisplay?shipInstructions*=&addressId*=&shipModeId*=" id="ShippingInstructionBlocksForm_FormInput_URL_In_ShopCartForm_1"/>
		<input type="hidden" name="ShippingURL" value="<c:out value="${WCParam.ShippingURL}"/>" id="ShippingInstructionBlocksForm_FormInput_ShippingURL_In_ShopCartForm_1"/>
		
		<% out.flush(); %>
		<c:import url="../../../Snippets/Order/Ship/ShippingInstructionBlocks.jsp">
			<c:param name="orderId" value="${WCParam.orderId}" />
		</c:import>
		<% out.flush(); %>
		
		<c:url var="ShippingMethodURL" value="MultipleShippingMethodView">
			<c:param name="orderId" value="${WCParam.orderId}"/>
			<c:param name="langId" value="${WCParam.langId}" />
			<c:param name="storeId" value="${WCParam.storeId}" />
			<c:param name="catalogId" value="${WCParam.catalogId}" />
			<c:param name="ShippingURL"  value="${WCParam.ShippingURL}"/>
		</c:url>
		
		<a href="<c:out value="${ShippingMethodURL}"/>" class="button" id="WC_ShippingInstructionsDisplay_Link_1"><fmt:message key="ShippingInstructions_Previous" bundle="${storeText}"/></a>
		<a href="javascript:submitForm(document.ShippingInstructionBlocksForm)" class="button" id="WC_ShippingInstructionsDisplay_Link_2"><fmt:message key="ShippingInstructions_Next" bundle="${storeText}"/></a>
	</form>
	
			</td>
		</tr>
		</tbody>	
		</table>
		<!--MAIN CONTENT ENDS HERE-->
		
	<%-- Hide CIP --%>
	<c:set var="HideCIP" value="true"/>

	<%@ include file="../../../include/LayoutContainerBottom.jspf"%>

	</body>
</html>
