<%--
//********************************************************************
//*-------------------------------------------------------------------
//* Licensed Materials - Property of IBM
//*
//* WebSphere Commerce
//*
//* (c) Copyright IBM Corp. 2001, 2002, 2004
//*
//* US Government Users Restricted Rights - Use, duplication or
//* disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
//*
//*-------------------------------------------------------------------
//*
--%>
<%-- 
  *****
  * When there is a problem authorizing the customer's payment, this email will be sent.
  * This email JSP page informs the customer that the order cannot be completed and provide the following order information:
  *  - Information of each order item (such as item description, shipping address, shipping method)
  *  - Tax, Shipping Charge, and Grand Total of the order
  *****
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../include/JSTLEnvironmentSetup.jspf"%>
<c:set value="${pageContext.request.scheme}://${pageContext.request.serverName}" var="hostPath" />
<c:set value="${pageContext.request.contextPath}/servlet/" var="webPath" />

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
	<title>
		<fmt:message key="STATUS_MESSAGE6" bundle="${storeText}"/>
	</title>
	<link rel="stylesheet" href="<c:out value="${hostPath}"/><c:out value="${jspStoreImgDir}"/><c:out value="${vfileStylesheet}"/>" type="text/css"/>
</head>

<body>

<%@ include file="EmailHeader.jspf"%>

	<h1>
		<fmt:message key="STATUS_MESSAGE6" bundle="${storeText}">
			<fmt:param value="${storeName}"/>
		</fmt:message>
	</h1>

	<span class="text">
		<% out.flush(); %>
		<c:import url="${jspStoreDir}/Snippets/Marketing/Content/ContentSpotDisplay.jsp">
			<c:param name="spotName" value="Order_Rejected1" />
			<c:param name="substitutionValues" value="{storeName},${storeName}"/>
			<c:param name="substitutionValues" value="{orderId},${WCParam.orderId}"/>
		</c:import>
		<% out.flush(); %>
	</span>

	<br/><br/>	
	<% out.flush(); %>
	<c:import url="${jspStoreDir}/Snippets/Order/Inventory/CurrentAndTotalCharges.jsp" >
		<c:param name="orderId" value="${WCParam.orderId}"/>
		<c:param name= "showCurrentCharges" value= "true"/>
		<c:param name= "showFutureCharges"  value= "true"/>
	</c:import>
	<% out.flush();%>	

<%@ include file="EmailFooter.jspf"%>

</body>
</html>
