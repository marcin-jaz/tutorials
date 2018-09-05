<%
/*
 *-------------------------------------------------------------------
 * Licensed Materials - Property of IBM
 *
 * WebSphere Commerce
 *
 * (c) Copyright International Business Machines Corporation. 2004
 *     All rights reserved.
 *
 * US Government Users Restricted Rights - Use, duplication or
 * disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
 *
 *-------------------------------------------------------------------
 */
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf" %>
<%@ include file="../../../include/TransitionEnvironmentSetup.jspf" %>

<c:choose>
	<c:when test="${WCParam.quotationType == 'initial'}">
		<c:url var="okURL" value="OrderQuotationDisplay">
			<c:param name="orderQuotationDisplayViewName" value="OrderQuotationDisplayByDistributorFormView"/>
			<c:param name="outOrderQuotationRelIdName" value="orderQuotationIDs"/>
		</c:url>
		<c:set var="timeoutURL" value="${okURL}"/>
		<c:set var="errorURL" value="${okURL}"/>
	</c:when>
	<c:when test="${WCParam.quotationType == 'final'}">
		<!-- clear the old selections and select the final quotes -->
		<c:url var="okURL" value="OrderItemSelect">
			<c:param name="orderId_1" value="*child*selection*parent${WCParam.orderId}"/>
			<c:param name="orderItemId_1" value="*"/>
			<c:param name="quantity_1" value="0"/>
			<c:param name="orderId_2" value="*child*final*parent${WCParam.orderId}"/>
			<c:param name="orderItemId_2" value="*"/>
			<c:param name="URL" value="DistributorShopCartReviewDisplayView"/>
		</c:url>
		<c:set var="timeoutURL" value="DistributorShopCartReviewDisplayView"/>
		<c:set var="errorURL" value="DistributorSelectionDisplayView"/>
	</c:when>
</c:choose>

<html>
<head>
	<title><fmt:message key="OrderQuotationWaitDisplay_Title" bundle="${storeText}"/></title>
	<link rel="stylesheet" href="<c:out value="${fileDir}PCDMarket.css"/>" type="text/css"/>
</head>

<body onload="setTimeout('document.orderQuotationCheckForm.submit()',<fmt:message key="OrderQuotationWaitDisplay_Timeout" bundle="${storeText}"/>)">

<form name="orderQuotationCheckForm" method="post" action="OrderQuotationCheck">
	<input type=hidden name="storeId" value="<c:out value="${storeId}"/>"/>
	<input type=hidden name="catalogId" value="<c:out value="${catalogId}"/>"/>
	<input type=hidden name="orderId" value="<c:out value="${WCParam.orderId}"/>"/>
	<input type=hidden name="okURL" value="<c:out value="${okURL}"/>"/>
	<input type=hidden name="waitURL" value="OrderQuotationWaitDisplayView"/>
	<input type=hidden name="timeoutURL" value="<c:out value="${timeoutURL}"/>"/>
	<input type=hidden name="errorURL" value="<c:out value="${errorURL}"/>"/>
	<input type=hidden name="outWaitOrderQuotationRelIdName" value="waitOrderQuotationRelId"/>
	<input type=hidden name="outTimeoutOrderQuotationRelIdName" value="timeoutOrderRelId"/>
	<input type=hidden name="quotationType" value="<c:out value="${WCParam.quotationType}"/>"/>
	<c:if test="${!empty WCParam.orderQuotationRelId}">
		<input type=hidden name="orderQuotationRelId" value="<c:out value="${WCParam.orderQuotationRelId}"/>"/>
	</c:if>
</form>    

<%@ include file="../../../include/HeaderDisplay.jspf" %>

<table border="0" cellpadding="0" cellspacing="0" width="750">
	<tr>
		<td class="mbg" valign="top" width="150">
			<% out.flush(); %>
			<c:import url="../../../include/SidebarDisplay.jsp"/>
			<% out.flush(); %>
		</td>
		<td><img height="1" width="10" alt="" src="<c:out value="${fileDir}images/c.gif"/>"/></td>
		<td valign="top" width="590">
			<table border="0" cellpadding="0" cellspacing="2" width="590">
				<tr><td>
					<table border="0" cellpadding="0" cellspacing="0" width="100%">
						<tr>
							<td colspan=2>
								<span class="bct">&nbsp;&nbsp;&nbsp;</span>
								<c:url var="storeCatalogDisplayURL" value="StoreCatalogDisplay">
									<c:param name="storeId" value="${storeId}"/>
									<c:param name="catalogId" value="${catalogId}"/>
								</c:url>
								<a class="bctl" href="<c:out value="${storeCatalogDisplayURL}"/>">
									<fmt:message key="Breadcrumb_CommercePlaza" bundle="${storeText}"/>
								</a>
								<span class="bct">&nbsp;&nbsp;&nbsp;&gt;&nbsp;&nbsp;&nbsp;</span>
								<span class="bct"><fmt:message key="Breadcrumb_RequestPriceAvail" bundle="${storeText}"/></span>
							</td>
						</tr>
						<tr>
							<td valign="top">
								<div align="left"><span class="title"><fmt:message key="OrderQuotationWaitDisplay_Intro" bundle="${storeText}"/></span></div>
							</td>
							<td valign="top" width="280">
								<div align="right"><img src="<c:out value="${fileDir}images/hdr_cart.gif"/>" width="280" height="72" alt="<fmt:message key="OrderQuotationWaitDisplay_Intro" bundle="${storeText}"/>"/></div>
							</td>
						</tr>
					</table>
				</td></tr>
				<tr><td>
					<span class="text"><fmt:message key="OrderQuotationWaitDisplay_Wait" bundle="${storeText}"/></span>
				</td></tr>
			</table>
		</td>
	</tr>
</table>

<%@ include file="../../../include/FooterDisplay.jspf" %>

</body>
</html>
