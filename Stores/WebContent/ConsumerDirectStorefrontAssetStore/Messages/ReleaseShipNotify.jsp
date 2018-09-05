<%
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
%>
<%-- 
  *****
  * This email JSP page informs the customer that the order is ready to ship.
  * It also provide the following order information:
  *  - Information of each order item (such as item description, shipping address, shipping method)
  *  - the shipping tracking number that the customer can use to track this package (if available)
  *****
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../include/JSTLEnvironmentSetup.jspf"%>
<c:set value="${pageContext.request.scheme}://${pageContext.request.serverName}" var="hostPath" />
<c:set value="${pageContext.request.contextPath}/servlet/" var="webPath" />

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
	<title>
		<fmt:message key="Quick_Add_To_Order" bundle="${storeText}"/>&nbsp;<fmt:message key="ORDER_STATUS_S" bundle="${storeText}"/>
	</title>
	<link rel="stylesheet" href="<c:out value="${hostPath}"/><c:out value="${jspStoreImgDir}"/><c:out value="${vfileStylesheet}"/>" type="text/css"/>
</head>

<body>

<%-- The parameter passed by ReleaseShipConfirmCmdImpl into this JSP is ordersId and not orderId --%>
<c:set var="orderId" value="${param.ordersId}"/>
<c:if test="${empty orderId}">
	<c:set var="orderId" value="${WCParam.ordersId}"/>
</c:if>

<wcbase:useBean id="order_OrderDataBean" classname="com.ibm.commerce.order.beans.OrderDataBean">
	<c:set target="${order_OrderDataBean}" property="orderId" value="${orderId}" />
</wcbase:useBean>

<%@ include file="EmailHeader.jspf"%>

	<h1><fmt:message key="Quick_Add_To_Order" bundle="${storeText}"/>&nbsp;<fmt:message key="ORDER_STATUS_S" bundle="${storeText}"/></h1>

	<%-- Get tracking Ids from all order items --%>
	<c:set var="orderTrackingId" value=""/>
	<c:forEach var="orderItem" items="${order_OrderDataBean.orderItemDataBeans}" varStatus="status">
		<c:forEach var="trackingId" items="${orderItem.trackingIds}" varStatus="status1">
			<c:if test="${!fn:contains(orderTrackingId, trackingId)}">
				<c:set var="orderTrackingId" value="${orderTrackingId} ${trackingId}"/>	
				<c:if test="${!status1.last}">
					<c:set var="orderTrackingId" value="${orderTrackingId}, "/>	
				</c:if>
			</c:if>
		</c:forEach>
	</c:forEach>
	
	<span class="text">
	<c:import url="${jspStoreDir}/Snippets/Marketing/Content/ContentSpotDisplay.jsp">
		<c:param name="spotName" value="Order_Ship1" />
		<c:param name="substitutionValues" value="{storeName},${storeName}"/>
		<c:param name="substitutionValues" value="{orderId},${orderId}"/>
		<c:param name="substitutionValues" value="{package},${orderTrackingId}"/>
	</c:import>
	</span>

	<c:set var="trackingUrl" value=""/>
	<flow:ifEnabled feature="TrackingURL">
		<c:set var="trackingUrl" value="true"/>
	</flow:ifEnabled>

	<br/><br/>
	<c:import url="${jspStoreDir}/Snippets/Order/Inventory/CurrentAndTotalCharges.jsp" >
		<c:param name="orderId" value="${orderId}"/>
		<c:param name= "showCurrentCharges" value= "true"/>
		<c:param name= "showFutureCharges"  value= "true"/>
		<c:param name= "trackingNumber"  value= "${trackingURL}"/>
	</c:import>

<%@ include file="EmailFooter.jspf"%>

</body>
</html>
