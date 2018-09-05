<%--
/*
 *-------------------------------------------------------------------
 * Licensed Materials - Property of IBM
 *
 * WebSphere Commerce
 *
 * (c) Copyright International Business Machines Corporation. 2001, 2004, 2005
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
  * This page shows the order confirmation for the users order.  The following information is shown:
  *  - Order number, subtotal, total tax, shipping, and total
  *  - Estimated shipping date
  *****
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>

<%@ include file="../../../include/JSTLEnvironmentSetup.jspf" %>
<c:set var="arrorderRn" value="${WCParamValues.orderId}"/>
<c:set var="scheduled" value="${WCParam.scheduled}"/>
<c:set var="bScheduledOrder" value="false"/>
<c:choose>
       <c:when test="${!empty scheduled && scheduled=='Y'}">
              <c:set var="bScheduledOrder" value="true"/>
       </c:when>
</c:choose>
<c:set var="orderRn" value="${arrorderRn[0]}"/>              

<c:set var="fail" value="${WCParam.fail}"/>
<c:set var="isFailureUrl" value="false"/>
<c:choose>
       <c:when test="${!empty fail && fail=='1'}">
              <c:set var="isFailureUrl" value="true"/>
       </c:when>
</c:choose>

<c:set var="cancel" value="${WCParam.cancel}"/>
<c:set var="isCancelUrl" value="false"/>
<c:choose>
       <c:when test="${!empty cancel && cancel=='1'}">
              <c:set var="isCancelUrl" value="true"/>
       </c:when>
</c:choose>

<c:set var="jLocale" value="${CommandContext.locale}"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<!-- BEGIN OrderConfirmationDisplay.jsp -->
<head>
<title><fmt:message key="OrderCon_Title" bundle="${storeText}"/></title>
<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}"/><c:out value="${vfileStylesheet}"/>" type="text/css"/>
</head>
<body class="noMargin">



<%@ include file="../../../include/LayoutContainerTop.jspf"%>
<img alt="<fmt:message key="Checkout_AccessibilityDescription" bundle="${storeText}" />" src="<c:out value="${jspStoreImgDir}" />images/trans.gif" width="1" height="1" border="0"/>
       
<flow:ifEnabled feature="customerCare"> 
<%
// Set header type needed for this JSP for LiveHelp.  This must
// be set before HeaderDisplay.jsp
request.setAttribute("liveHelpPageType", "personal");
%>
<script language="javascript">
       if (typeof parent.setShoppingCartItems == 'function')
              parent.setShoppingCartItems(0);

</script>
</flow:ifEnabled> 

<!--content start-->
<c:choose>
	<c:when test="${bScheduledOrder}">
		<flow:ifEnabled feature="trackOrderStatus">
			<fmt:message key="OrderCon_Text4" bundle="${storeText}" var="statusMessage"/>
		</flow:ifEnabled>
		<flow:ifDisabled feature="trackOrderStatus">
			<fmt:message key="OrderCon_Text5" bundle="${storeText}" var="statusMessage"/>
		</flow:ifDisabled>
	</c:when>
	<c:otherwise>
		<wcbase:useBean id="edp_PaymentStatusBean" classname="com.ibm.commerce.edp.beans.EDPPaymentStatusDataBean"  scope="request" >
			<c:set property="needGlobalized" value="false" target="${edp_PaymentStatusBean}"  />
			<c:set property="orderId" value="${WCParam.orderId}" target="${edp_PaymentStatusBean}"  />
		</wcbase:useBean>

		<wcbase:useBean id="ConfirmPageOrderDataBean" classname="com.ibm.commerce.order.beans.OrderDataBean">
			<c:set target="${ConfirmPageOrderDataBean}" property="orderId" value="${WCParam.orderId}" />
		</wcbase:useBean>

		<c:choose>
			<c:when test="${ConfirmPageOrderDataBean.status == 'L'}">
				<c:set var="statusMessage">
					<fmt:message key="STATUS_MESSAGE13" bundle="${storeText}"/>
				</c:set>
			</c:when>
			<c:when test="${empty edp_PaymentStatusBean.paymentStatus}">
				<c:set var="statusMessage">
					<fmt:message key="STATUS_MESSAGE1" bundle="${storeText}"/>
				</c:set>
			</c:when>
			<c:when test="${edp_PaymentStatusBean.paymentStatus == 'Success'}">
				<c:set var="statusMessage">
					<fmt:message key="STATUS_MESSAGE4" bundle="${storeText}"/>
				</c:set>
			</c:when>
			<c:when test="${edp_PaymentStatusBean.paymentStatus == 'Pending'}">
				<c:set var="statusMessage">
					<fmt:message key="STATUS_MESSAGE4" bundle="${storeText}"/>
				</c:set>
			</c:when>
			<c:when test="${edp_PaymentStatusBean.paymentStatus == 'Warning'}">
				<c:set var="statusMessage">
					<fmt:message key="STATUS_MESSAGE12" bundle="${storeText}"/>
				</c:set>
			</c:when>
			<c:when test="${edp_PaymentStatusBean.paymentStatus == 'Failed'}">
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
	</c:otherwise>
</c:choose>        
<table cellpadding="8" border="0" cellspacing="0" id="WC_OrderConfirmationDisplay_Table_2">
	<tbody>
		<tr>
			<td id="WC_OrderConfirmationDisplay_TableCell_3">
				<h1><fmt:message key="OrderCon_Title" bundle="${storeText}"/></h1>
				<strong><c:out value="${statusMessage}"/></strong><br/><br/> 
				<table cellspacing="2" cellpadding="2" border="0" id="WC_OrderConfirmationDisplay_Table_6">
					<tbody>
						<tr>
							<td valign="middle"  id="WC_OrderConfirmationDisplay_TableCell_18"> 
								<fmt:message key="OrderCon_Number" bundle="${storeText}"/> <strong><c:out value="${orderRn}"/></strong><br/>	
								<fmt:message key="OrderCon_Text2" bundle="${storeDynamicText}"/>
								<br/>
							</td>
						</tr>
					</tbody>
				</table>
				<br/>
			</td>
		</tr>
	</tbody>
</table>
<% out.flush(); %>
<c:import url="../../../Snippets/Order/Inventory/CurrentAndTotalCharges.jsp" >
	<c:param name="orderId" value="${orderRn}"/>
	<c:param name= "showCurrentCharges" value= "true"/>
	<c:param name= "showFutureCharges"  value= "true"/>
</c:import>
<% out.flush();%>
<br/><br/>
<fmt:message key="OrderCon_Text3" bundle="${storeDynamicText}"/> 

<%@ include file="../../../include/LayoutContainerBottom.jspf"%>

</body>
<!-- END OrderConfirmationDisplay.jsp -->
</html>
