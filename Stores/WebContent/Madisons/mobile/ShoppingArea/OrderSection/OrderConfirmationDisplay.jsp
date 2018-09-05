<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2009 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>

<%-- 
  *****
  * This JSP snippet displays the Order confirmation page.
  *****
--%>

<!-- BEGIN OrderConfirmationDisplay.jsp -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>

<%@ include file="../../../include/parameters.jspf" %>
<%@ include file="../../include/JSTLEnvironmentSetup.jspf" %>

<c:set var="pageSize" value="${maxOrderItemsPerPage}"/>	

<%-- Index to begin the order item paging with --%>
<c:set var="beginIndex" value="${WCParam.beginIndex}" />
<c:if test="${empty beginIndex}">
	<c:set var="beginIndex" value="0" />
</c:if>

<wcf:getData type="com.ibm.commerce.order.facade.datatypes.OrderType" var="order" expressionBuilder="findByOrderIdWithPagingOnItem" varShowVerb = "ShowVerbSummary" maxItems="${pageSize}" recordSetStartNumber="${beginIndex}" recordSetReferenceId="confirmstatus" scope="request">
	<wcf:param name="orderId" value="${WCParam.orderId}"/>
	<wcf:param name="accessProfile" value="IBM_Details" />
	<wcf:param name="sortOrderItemBy" value="orderItemID" />
	<wcf:param name="isSummary" value="false" />
</wcf:getData>

<c:set var="numEntries" value="${fn:length(order.orderItem)}"/>

<wcf:getData type="com.ibm.commerce.member.facade.datatypes.PersonType" var="person" expressionBuilder="findCurrentPerson">
	<wcf:param name="accessProfile" value="IBM_All" />
</wcf:getData>

<c:set var="personAddresses" value="${person.addressBook}"/>

<%-- Need to reset currencyFormatterDB as initialized in JSTLEnvironmentSetup.jspf, as the currency code used there is from commandContext. For order history we want to display with currency used when the order was placed. --%>
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

<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.2//EN" "http://www.openmobilealliance.org/tech/DTD/xhtml-mobile12.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
    	<title>
			<fmt:message key="MO_CONFIRMATION" bundle="${storeText}"/> - <c:out value="${storeName}"/>
		</title>

		<meta http-equiv="content-type" content="application/xhtml+xml" />
		<meta http-equiv="cache-control" content="max-age=300" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no" />
		<link rel="stylesheet" href="${cssPath}" type="text/css"/>
	</head>

	<body>
		<div id="wrapper">
			<%@ include file="../../include/HeaderDisplay.jspf" %>
			
			<div id="order_confirmation" class="content_box">
				<c:set var="ordStatus" value="${order.orderStatus.status}"/>
				<c:choose>
					<c:when test="${ordStatus eq 'L'}">
						<h2 class="paragraph_blurb"><fmt:message key="MO_ORD_THANKS_MESSAGE_LESS_INV" bundle="${storeText}"/></h2>
					</c:when>
					<c:otherwise>
						<div class="heading_container">
							<h2><fmt:message key="MO_THANKS_MESSAGE" bundle="${storeText}"/></h2>
                        	<div class="clear_float"></div>
                        </div>
						<p class="paragraph_blurb"><fmt:message key="MO_CONFIRMATION_MESSAGE" bundle="${storeText}"/>.</p>
					</c:otherwise>
				</c:choose>

				<dl id="order_info">
					<dt><fmt:message key="MO_ORDER_NUMBER" bundle="${storeText}"/>:</dt><dd><c:out value="${order.orderIdentifier.uniqueID}"/></dd>
                    <c:catch>
		            	<fmt:parseDate var="orderDate" value="${order.placedDate}" pattern="yyyy-MM-dd'T'HH:mm:ss.SSS'Z'" timeZone="GMT"/>
					</c:catch>
					<c:if test="${empty orderDate}">
						<c:catch>
							<fmt:parseDate var="orderDate" value="${order.placedDate}" pattern="yyyy-MM-dd'T'HH:mm:ss'Z'" timeZone="GMT"/>
		                </c:catch>
					</c:if>
					<fmt:formatDate value="${orderDate}" type="date" dateStyle="long" var="formattedOrderDate" timeZone="${fn:replace(cookie.WC_timeoffset.value, '%2B', '+')}"/>
                    <dt><fmt:message key="MO_ORDER_DATE" bundle="${storeText}"/>:</dt> <dd><c:out value="${formattedOrderDate}"/></dd>
				</dl>

				<div id="store_location">
					<h3><fmt:message key="MO_STORE_LOCATION" bundle="${storeText}"/></h3>
					<p><fmt:message key="MO_STORE_PICK_UP_MSG" bundle="${storeText}"/>.</p>
					<ul>
						<c:set var="contact" value="${order.orderItem[0].orderItemShippingInfo.shippingAddress}" />
						<c:if test="${!empty contact.contactInfoIdentifier.externalIdentifier.contactInfoNickName}">
							<li>
								<p><c:out value="${contact.contactInfoIdentifier.externalIdentifier.contactInfoNickName}"/></p>
							</li>
						</c:if>
						<li>
							<%-- Display shiping address of the order --%>
							<%@ include file="../../Snippets/ReusableObjects/AddressDisplay.jspf"%>
						</li>
					</ul>
				</div>

				<div id="billing_info">
					<div id="billing_address">
						<h3><fmt:message key="MO_BILLING_ADDRESS" bundle="${storeText}"/></h3>
						<ul>
							<%@ include file="../../Snippets/ReusableObjects/OrderBillingAddressDisplay.jspf"%>
						</ul>
					</div>

					<div id="billing_method">
						<h3><fmt:message key="MO_BILLING_METHOD" bundle="${storeText}"/></h3>
						<ul>
							<%@ include file="../../Snippets/ReusableObjects/OrderBillingMethodDisplay.jspf"%>
						</ul>
					</div>
				</div>

				<div id="items">
					<h3><fmt:message key="MO_ORD_ITEMS" bundle="${storeText}"/></h3>
					<%-- Pagination Logic --%>
					<c:set var="pageSize" value="${WCParam.pageSize}"/>
					<c:if test="${empty pageSize}">
						<c:set var="pageSize" value="${orderSummaryMaxPageSize}" />
						<%--<c:set var="pageSize" value="3" /> --%>
					</c:if>

					<%-- Counts the page number we are drawing in.  --%>
					<c:set var="currentPage" value="${WCParam.currentPage}" />
					<c:if test="${empty currentPage}">
						<c:set var="currentPage" value="1" />
					</c:if>

					<fmt:formatNumber var="totalPages" value="${(numEntries/pageSize)+1}"/>
					<c:if test="${numEntries%pageSize == 0}">
						<fmt:parseNumber var="totalPages" value="${numEntries/pageSize}"/>
					</c:if>
					<fmt:parseNumber var="totalPages" value="${totalPages}" integerOnly="true" />

					<fmt:formatNumber var="beginIndex" value="${(currentPage-1) * pageSize}"/>
					<fmt:formatNumber var="endIndex" value="${beginIndex + pageSize}"/>
					<c:if test="${endIndex > numEntries}">
						<fmt:parseNumber var="endIndex" value="${numEntries}"/>
					</c:if>
					<fmt:parseNumber var="beginIndex" value="${beginIndex}" integerOnly="true" />
					<fmt:parseNumber var="endIndex" value="${endIndex}" integerOnly="true" />	
					<fmt:parseNumber var="numRecordsToShow" value="${endIndex-beginIndex}" integerOnly="true" />

					<ol id="shopping_cart_items" start="<c:out value="${beginIndex + 1}"/>">
						<%@ include file="../../Snippets/ReusableObjects/OrderItemDetailsDisplay.jspf"%>
					</ol>
					<c:if test="${totalPages > 1}">
						<!-- Pagination Logic -->
						<div class="paging_control_with_underline">
							<div class="page_number">
								<fmt:message key="PAGING" bundle="${storeText}">
									<fmt:param value="${currentPage}"/>
									<fmt:param value="${totalPages}"/>
								</fmt:message>
							</div>
							<c:if test="${currentPage > 1}">
								<span class="bullet">&#171; </span>
							 	<wcf:url var="OrderConfirmURL" value="mOrderShippingBillingConfirmationView">
									<wcf:param name="langId" value="${langId}" />
									<wcf:param name="storeId" value="${WCParam.storeId}" />
									<wcf:param name="orderId" value="${WCParam.orderId}" />
									<wcf:param name="currentPage" value="${currentPage-1}" />
								</wcf:url>
								<a href="${fn:escapeXml(OrderConfirmURL)}" title="<fmt:message key="PAGING_PREV_PAGE_TITLE"
									bundle="${storeText}"/>"><fmt:message key="PAGING_PREV_PAGE" bundle="${storeText}"/></a>
							</c:if>
							&#160;&#160;
							<c:if test="${currentPage < totalPages}">
								<wcf:url var="OrderConfirmURL" value="mOrderShippingBillingConfirmationView">
									<wcf:param name="langId" value="${langId}" />
									<wcf:param name="storeId" value="${WCParam.storeId}" />
									<wcf:param name="orderId" value="${WCParam.orderId}" />
									<wcf:param name="currentPage" value="${currentPage+1}" />
									<wcf:param name="catalogId" value="${WCParam.catalogId}" />
								</wcf:url>			
								<a href="${fn:escapeXml(OrderConfirmURL)}" title="<fmt:message key="PAGING_NEXT_PAGE_TITLE" 
									bundle="${storeText}"/>"><fmt:message key="PAGING_NEXT_PAGE" bundle="${storeText}"/></a>
								<span class="bullet">&#187; </span>
							</c:if>
				 		</div>
				 	</c:if>
				</div>
				<div id="shopping_cart_costs">
					<%@ include file="../../Snippets/ReusableObjects/OrderItemOrderTotalDisplay.jspf"%>
				</div>

				<form id="your_store_list_cont_shopping_button" method="post" action="mIndex">
					<input type="hidden" id="storeId" name="storeId" value="${WCParam.storeId}" />
					<input type="hidden" id="langId" name="langId" value="${WCParam.langId}" />
					<input type="hidden" id="catalogId" name="catalogId" value="${WCParam.catalogId}" />

					<input type="submit" id="continue_shopping" class="input_button_float" value="<fmt:message key="MO_CONTINUE_SHOPPING" bundle="${storeText}"/>" />
				</form>

			</div>

			<%@ include file="../../include/FooterDisplay.jspf" %>
		</div>
	</body>
</html>
<!-- END OrderConfirmationDisplay.jsp -->