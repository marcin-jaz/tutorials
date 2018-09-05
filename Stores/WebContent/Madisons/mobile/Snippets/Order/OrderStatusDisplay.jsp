<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2008, 2009 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>

<%-- 
  *****
  * This JSP snippet retrieves and displays the order history details for a particular user. 
  *****
--%>

<!-- BEGIN OrderStatusDisplay.jsp -->

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>    

<%@ include file="../../../include/parameters.jspf" %>
<%@ include file="../../include/JSTLEnvironmentSetup.jspf" %>

<c:if test="${param.showScheduledOrders}">
	<c:set var="showScheduledOrders" value="true" />
</c:if>
<c:if test="${param.showOrdersAwaitingApproval}">
	<c:set var="showOrdersAwaitingApproval" value="true" />
</c:if>
<c:if test="${param.showPONumber}">
	<c:set var="showPONumber" value="true" />
</c:if>

<c:set var="pageSize" value="${param.pageSize}"/>
<c:if test="${empty pageSize}">
<c:set var="pageSize" value="${orderHistoryMaxPageSize}"/>
</c:if>
<c:set var="currentPage" value="${WCParam.currentPage}"/>
<c:if test="${empty currentPage}">
	<c:set var="currentPage" value="1" />
</c:if>

<%--
	***
	* Start: List of orders already processed
	***
--%>

<wcf:getData type="com.ibm.commerce.order.facade.datatypes.OrderType[]" var="orders" varShowVerb = "ShowVerb" 
		expressionBuilder="findByOrderStatus" recordSetReferenceId="orderstatus">
	<wcf:param name="status" value="N,M,A,B,C,R,S,D,F,G" />
	<wcf:param name="accessProfile" value="IBM_Summary" />
</wcf:getData>


<fmt:parseNumber var="numEntries" value="${ShowVerb.recordSetTotal}" integerOnly="true" />
<fmt:parseNumber var="pageSize" value="${pageSize}" integerOnly="true" />
<fmt:parseNumber var="totalPages" value="${(numEntries/pageSize)+1}" integerOnly="true" />
<c:if test="${numEntries%pageSize == 0}">
	<fmt:parseNumber var="totalPages" value="${numEntries/pageSize}" integerOnly="true" />
</c:if>

<fmt:formatNumber var="beginIndex" value="${(currentPage-1) * pageSize}"/>
<fmt:formatNumber var="endIndex" value="${beginIndex + pageSize}"/>
<c:if test="${endIndex > numEntries}">
	<fmt:parseNumber var="endIndex" value="${numEntries}"/>
</c:if>
<fmt:parseNumber var="beginIndex" value="${beginIndex}" integerOnly="true" />
<fmt:parseNumber var="endIndex" value="${endIndex}" integerOnly="true" />	
<fmt:parseNumber var="numRecordsToShow" value="${endIndex-beginIndex}" integerOnly="true" />


<fmt:formatNumber var="endNumber" value="${beginIndex + pageSize}"/>
<c:if test="${endNumber > numEntries}">
	<fmt:parseNumber var="endNumber" value="${numEntries}"/>
</c:if>

<fmt:parseNumber var="numRecordsToShow" value="${endNumber-beginIndex}" integerOnly="true" />

<c:choose>
	<c:when test="${numEntries == 0}">
		<fmt:message key="MO_NOORDERSFOUND" bundle="${storeText}"/>
	</c:when>
	<c:otherwise>

		<c:set var="orderIds" value="" />	
		<c:forEach var="order" items="${orders}" varStatus="status" >
			<c:set var="orderIds" value="${orderIds},${order.orderIdentifier.uniqueID}" />
			</c:forEach>	
		<%
		String ordIds = (String)pageContext.getAttribute("orderIds");
		ordIds = ordIds.replaceFirst(",","");
		session.setAttribute(ORDER_IDS_KEY,ordIds);
		%>			

		<c:forEach var="order" items="${orders}" varStatus="status" begin="${beginIndex}" end="${endIndex}">
			<c:if test="${status.count <= numRecordsToShow}">
			<wcf:url var="OrderDetailsURL" value="mOrderDetails">
				<wcf:param name="storeId" value="${WCParam.storeId}" />
  				<wcf:param name="catalogId" value="${WCParam.catalogId}" />
  				<wcf:param name="orderId" value="${order.orderIdentifier.uniqueID}" />
			</wcf:url>

			<c:choose>
				<c:when test="${status.count == numRecordsToShow}">
					<c:set var="entryStyle" value="last" />
				</c:when>
				<c:otherwise>
					<c:set var="entryStyle" value="entry" />
				</c:otherwise>
			</c:choose>		

			<c:remove var="currencyFormatterDB"/>

			<wcbase:useBean id="currencyFormatterDB" classname="com.ibm.commerce.common.beans.CurrencyFormatDescriptionDataBean" scope="request" >
				<c:set property="dataBeanKeyNumberUsgId" value="-1" target="${currencyFormatterDB}" />
				<c:set property="dataBeanKeyCurrencyCode" value="${order.orderAmount.grandTotal.currency}" target="${currencyFormatterDB}" />
				<c:set property="dataBeanKeyStoreEntityId" value="-1" target="${currencyFormatterDB}" />
				<c:set property="dataBeanKeyLanguageId" value="${langId}" target="${currencyFormatterDB}" />
			</wcbase:useBean>	
			<c:choose>
				<c:when test="${order.orderAmount.grandTotal.currency == 'JPY' || order.orderAmount.grandTotal.currency == 'KRW'}">
					<c:set var="currencyDecimal" value="0"/>
				</c:when>
				<c:otherwise>
					<c:set var="currencyDecimal" value="2"/>
				</c:otherwise>
			</c:choose>
		
		
			<ul class="${entryStyle}"> 
				<li><span class="bold"><fmt:message key="MO_ORDER_NUMBER" bundle="${storeText}"/>:</span> <c:out value="${order.orderIdentifier.uniqueID}"/></li> 
				
				<c:catch>
					<fmt:parseDate var="expectedDate" value="${order.placedDate}" pattern="yyyy-MM-dd'T'HH:mm:ss.SSS'Z'" timeZone="GMT"/>
				</c:catch>
				<c:if test="${empty expectedDate}">
					<c:catch>
						<fmt:parseDate var="expectedDate" value="${order.placedDate}" pattern="yyyy-MM-dd'T'HH:mm:ss'Z'" timeZone="GMT"/>
					</c:catch>
				</c:if>
				<li><span class="bold"><fmt:message key="MO_ORDER_DATE" bundle="${storeText}"/>:</span> <fmt:formatDate value="${expectedDate}"/></li> 
			
				<c:if test="${showPONumber}">
					<li><span class="bold"><fmt:message key="PONUMBER" bundle="${storeText}"/>:</span> <c:out value="${order.buyerPONumber}"/></li> 
				</c:if>		
				<li><span class="bold"><fmt:message key="TOTAL_PRICE" bundle="${storeText}"/>:</span> <fmt:formatNumber value="${order.orderAmount.grandTotal.value}" type="currency" maxFractionDigits="${currencyDecimal}" currencySymbol="${currencyFormatterDB.currencySymbol}"/></li> 
				<li><span class="bold"><fmt:message key="MO_STATUS" bundle="${storeText}"/>:</span> <fmt:message key="MO_OrderStatus_${order.orderStatus.status}" bundle="${storeText}"/></li> 
				<li><span class="bullet">&#187; </span><a href="${fn:escapeXml(OrderDetailsURL)}" title="<fmt:message key="MO_ORDERDETAILS" bundle="${storeText}"/>"><fmt:message key="MO_ORDERDETAILS" bundle="${storeText}"/></a></li> 
			</ul> 
			</c:if>							
		</c:forEach>

		<c:if test="${totalPages > 1}">
		<div class="paging_control"> 
			<div class="page_number">
				<fmt:message key="PAGING" bundle="${storeText}">
					<fmt:param value="${currentPage}"/>
					<fmt:param value="${totalPages}"/>				
				</fmt:message>					
			</div>
			<c:if test="${currentPage > 1}">
				<span class="bullet">&#171; </span>
				<wcf:url var="OrderHistoryURL" value="mOrderHistory">
					<wcf:param name="storeId" value="${WCParam.storeId}" />
					<wcf:param name="catalogId" value="${WCParam.catalogId}" />
					<wcf:param name="currentPage" value="${currentPage-1}" />			
				</wcf:url>
				<a href="${fn:escapeXml(OrderHistoryURL)}" title="<fmt:message key="PAGING_PREV_PAGE_TITLE" bundle="${storeText}"/>"><fmt:message key="PAGING_PREV_PAGE" bundle="${storeText}"/></a>
			</c:if>
			&#160;&#160;
			<c:if test="${currentPage < totalPages}">
				<wcf:url var="OrderHistoryURL" value="mOrderHistory">
					<wcf:param name="storeId" value="${WCParam.storeId}" />
					<wcf:param name="catalogId" value="${WCParam.catalogId}" />
					<wcf:param name="currentPage" value="${currentPage+1}" />			
				</wcf:url>			
				<a href="${fn:escapeXml(OrderHistoryURL)}" title="<fmt:message key="PAGING_NEXT_PAGE_TITLE" bundle="${storeText}"/>"><fmt:message key="PAGING_NEXT_PAGE" bundle="${storeText}"/></a>
				<span class="bullet">&#187; </span>
			</c:if> 
		</div>
		</c:if>

	</c:otherwise>
</c:choose>

<!-- END OrderStatusDisplay.jsp  -->
