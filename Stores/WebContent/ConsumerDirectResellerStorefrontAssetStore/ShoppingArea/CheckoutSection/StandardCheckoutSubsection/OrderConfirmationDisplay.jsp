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
  * This JSP will display the confirmation details of a single order. The content consists of:
  *  - A receipt showing the order number, subtotal, total tax, shipping cost, and grand total.
  *  - A print button
  *	 - imports CurrentAndTotalCharges.jsp to display items that were ordered along with associated order totals
  ***** 
--%>


<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf" %>
<%@ include file="../../../include/nocache.jspf" %>

<c:set var="policyId" value="${WCParam.policyId}"/>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
	<title><fmt:message key="ORDER_CONF" bundle="${storeText}"/></title>
	<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${vfileStylesheet}"/>" type="text/css"/>
</head>

	<body>
	<!-- JSP File Name:  OrderConfirmationDisplay.jsp -->

	<%@ include file="../../../include/LayoutContainerTop.jspf"%>
	
		<!--MAIN CONTENT STARTS HERE-->

		<table cellpadding="2" cellspacing="2" width="100%" border="0" id="WC_OrderConfirmationDisplay_Table_1">
		<tbody>
			<tr>
				<td valign="top" colspan="6" id="WC_OrderConfirmationDisplay_TableCell_1">
					<span class="heading"><fmt:message key="ORDER_CONF" bundle="${storeText}"/></span>
				</td>
			</tr>
			<tr>
				<td valign="top" id="WC_OrderConfirmationDisplay_TableCell_2">
					<wcbase:useBean id="edp_PaymentStatusBean" classname="com.ibm.commerce.edp.beans.EDPPaymentStatusDataBean"  scope="request" >
							<c:set property="orderId" value="${WCParam.orderId}" target="${edp_PaymentStatusBean}"  />
							<c:set property="needGlobalized" value="false" target="${edp_PaymentStatusBean}"  />
						</wcbase:useBean>

						<wcbase:useBean id="ConfirmPageOrderDataBean" classname="com.ibm.commerce.order.beans.OrderDataBean">
							<c:set target="${ConfirmPageOrderDataBean}" property="orderId" value="${WCParam.orderId}" />
						</wcbase:useBean>

						<c:choose>
							<c:when test="${ConfirmPageOrderDataBean.status == 'L'}">
								<c:set var="statusMessage">
									<fmt:message key="STATUS_MESSAGE12" bundle="${storeText}"/>
								</c:set>
							</c:when>
							<c:when test="${empty edp_PaymentStatusBean.paymentStatus}">
								<c:set var="statusMessage">
									<fmt:message key="STATUS_MESSAGE1" bundle="${storeText}"/>
								</c:set>
							</c:when>
							<c:when test="${edp_PaymentStatusBean.paymentStatus == 'Success'}">
								<c:set var="statusMessage">
									<fmt:message key="STATUS_MESSAGE3" bundle="${storeText}">
										<fmt:param value="${storeName}" />
									</fmt:message>
								</c:set>
							</c:when>
							<c:when test="${edp_PaymentStatusBean.paymentStatus == 'Failure'}">
								<c:set var="statusMessage">
									<fmt:message key="STATUS_MESSAGE6" bundle="${storeText}"/>
								</c:set>
							</c:when>
							<c:otherwise>
								<c:set var="statusMessage">
									<fmt:message key="STATUS_MESSAGE9" bundle="${storeText}">
										<fmt:param value="${storeName}" />
									</fmt:message>
								</c:set>
							</c:otherwise>
						</c:choose>
				<span class="textCustomColor"><c:out value="${statusMessage}"/></span>&nbsp;<br/>

				<br/>				
				<c:if test="${userType == 'G'}">
					<br/>
					<span class="textCustomColor"><fmt:message key="REMIND_REGISTER" bundle="${storeText}"/></span>
					<br/>
				</c:if>
				<br/>
				
				<span class="c_headings"><fmt:message key="ORDER" bundle="${storeText}"/> <c:out value="${WCParam.orderId}"/></span>

<% out.flush(); %>
<c:import url="../../../Snippets/Order/Inventory/CurrentAndTotalCharges.jsp" >
	<c:param name="orderId" value="${WCParam.orderId}"/>
	<c:param name= "showCurrentCharges" value= "true"/>
	<c:param name= "showFutureCharges"  value= "true"/>
</c:import>
<% out.flush();%>

			<br/><fmt:message key="ORDER_RECEIPT" bundle="${storeDynamicText}"/><br/>
			<br/>
			
			<a href="#" onclick="print();" class="button" id="WC_OrderConfirmationDisplay_Link_1"><fmt:message key="PRINT" bundle="${storeText}"/></a>
			
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
