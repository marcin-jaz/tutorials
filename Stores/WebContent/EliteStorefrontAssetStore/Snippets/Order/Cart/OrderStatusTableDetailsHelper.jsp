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
  *
  * This JSP page is mapped to OrderStatusTableDetailsHelper in the struts, which is used to construct a URL for the href parameter for the tabs in OrderStatusTableDisplay.jsp 
  *
  * How to use this snippet?
  * <wcf:url var="ScheduledOrderStatusTableDetailsURL" value="OrderStatusTableDetailsHelper" type="Ajax">
  * 	<wcf:param name="storeId" value="${WCParam.storeId}"/>
  * 	<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
  * 	<wcf:param name="langId" value="${WCParam.langId}"/>
  * 	<wcf:param name="selectedTab" value="Scheduled"/>
  * </wcf:url>
  *
  *****
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf"%>


<c:set var="selectedTab" value="${WCParam.selectedTab}"/>
<c:set var="isQuote" value="false"/>

<c:if test="${WCParam.isQuote eq true}">
	<c:set var="isQuote" value="true"/>
</c:if>

<c:choose>
	<c:when test="${selectedTab == 'WaitingForApproval'}">
		<div id="WaitingForApprovalSummary" class="hidden_summary">
		<c:choose>
			<c:when test="${WCParam.isQuote eq true}">
				<fmt:message key="MO_PENDING_APPROVAL_QUOTES_TABLE_DESCRIPTION" bundle="${storeText}"/>
			</c:when>
			<c:otherwise>
				<fmt:message key="MO_PENDING_APPROVAL_ORDERS_TABLE_DESCRIPTION" bundle="${storeText}"/>
			</c:otherwise>
		</c:choose>
		</div>
		<div dojoType="wc.widget.RefreshArea" widgetId="WaitingForApprovalOrdersStatusDisplay" id="WaitingForApprovalOrdersStatusDisplay" controllerId="WaitingForApprovalOrdersStatusDisplayController" role="wairole:region" waistate:live="polite" waistate:atomic="false" waistate:relevant="all">
			<%out.flush();%>
				<c:import url="${jspStoreDir}Snippets/Order/Cart/OrderStatusTableDetailsDisplay.jsp"> 
					<c:param name="catalogId" value="${WCParam.catalogId}" />
					<c:param name="langId" value="${WCParam.langId}" />
					<c:param name="storeId" value="${WCParam.storeId}" />
					<c:param name="selectedTab" value="WaitingForApproval"/>
					<c:param name="isQuote" value="${isQuote}"/>
				</c:import>
			<%out.flush();%>
		</div>
	</c:when>
	<c:when test="${selectedTab == 'Scheduled'}">
		<div id="ScheduledSummary" class="hidden_summary">
			<fmt:message key="MO_SCHEDULED_ORDERS_TABLE_DESCRIPTION" bundle="${storeText}"/>
		</div>
		<div dojoType="wc.widget.RefreshArea" widgetId="ScheduledOrdersStatusDisplay" id="ScheduledOrdersStatusDisplay" controllerId="ScheduledOrdersStatusDisplayController" role="wairole:region" waistate:live="polite" waistate:atomic="false" waistate:relevant="all">
			<%out.flush();%>
				<c:import url="${jspStoreDir}Snippets/Order/Cart/OrderStatusTableDetailsDisplay.jsp"> 
					<c:param name="catalogId" value="${WCParam.catalogId}" />
					<c:param name="langId" value="${WCParam.langId}" />
					<c:param name="storeId" value="${WCParam.storeId}" />
					<c:param name="selectedTab" value="Scheduled"/>
				</c:import>
			<%out.flush();%>
		</div>
	</c:when>
</c:choose>

