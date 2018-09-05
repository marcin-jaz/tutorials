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

<!-- Start - JSP File Name:  OrderSubmitForm.jsp -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf" %>
<%@ include file="../../../include/nocache.jspf" %>

<%-- ErrorMessageSetup.jspf is used to retrieve an appropriate error message when there is an error --%>
<%@ include file="../../../include/ErrorMessageSetup.jspf" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
	<title><fmt:message key="ORDER_TITLE" bundle="${storeText}"/></title>
       <link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${vfileStylesheet}"/>" type="text/css"/>
</head>
	<body>
	<!-- JSP File Name:  OrderSubmitForm.jsp -->

	<%@ include file="../../../include/LayoutContainerTop.jspf"%>
	
		<!--MAIN CONTENT STARTS HERE-->

		<table cellpadding="0" cellspacing="0" width="100%" border="0" id="WC_OrderSubmitForm_Table_1">
		<tbody>
		<tr>
			<td colspan="4" id="WC_OrderSubmitForm_TableCell_1">
				<c:set var="bctCurrentPage" value="OrderSubmit" />
	            		<%@ include file="../../../Snippets/Order/Cart/BreadCrumbTrailDisplay.jspf" %>
			</td>
		</tr>
		<tr>
			<td colspan="4" valign="top" class="heading" id="WC_OrderSubmitForm_TableCell_2">
				<fmt:message key="ORDER_SUMMARY" bundle="${storeText}"/>
			</td>

				<%-- 
				  ***
				  *	Start: Error handling
				  * Show an appropriate error message when there is an error processing the payment information.
				  ***
				--%>
				<c:if test="${!empty errorMessage}">
					<c:choose>
							<c:when test="${!empty errorMessage && error.exceptionData.ErrorCode==240}">
								<span class="error"><br/><fmt:message key="STATUS_MESSAGE7" bundle="${storeText}"/><br/><br/></span>		
								<a class="button" href="javascript:Reprepare_order(document.AdvCardInfo)" id="EDP_OrderSubmitForm_Link_11c">
					    		<fmt:message key="CurrentOrder_UPDATE_TOTALS" bundle="${storeText}"/> 
								</a>
								<br/><br/>
							</c:when>
							<c:otherwise>
								<span class="error"><br/><c:out value="${errorMessage}"/><br/><br/></span>			
								<p></p>
							</c:otherwise>
						</c:choose>
					
				</c:if>					
				<%-- 
				  ***
				  *	End: Error handling
				  ***
				--%>
		</tr>
		<tr>
		<td id="WC_OrderSubmitForm_TableCell_3" >
		<% out.flush(); %>
		<c:import url="../../../Snippets/Order/Inventory/CurrentAndTotalCharges.jsp" >
			<c:param name="orderId" value="${WCParam.orderId}"/>
			<c:param name= "showCurrentCharges" value= "true"/>
			<c:param name= "showFutureCharges"  value= "true"/>
		</c:import>
		<% out.flush();%>

		<% out.flush(); %>
		<c:import url="../../../Snippets/EDP/PaymentMethods/PaymentMethodsDisplay.jsp" >
			<c:param name="orderId" value="${WCParam.orderId}"/>
		</c:import>
		<% out.flush(); %>
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
