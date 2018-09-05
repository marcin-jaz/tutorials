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
  *
  * This JSP page displays the Order Status page with the following elements:
  *  - List of orders waiting for approval.
  *  - List of orders already processed.
  *  - List of orders scheduled.
  * For each order, the following is displayed
  * 	- Order Number, Order Date, Status, Total
  * In each list, 'Details' is a link to the Order Details page for that order
  *
  *
  * How to use this snippet?
  *	<c:import url="../../../Snippets/Order/Cart/OrderStatusTableDisplay.jsp" >
  *		<c:param name="isMyAccountMainPage" value="true"/>
  *	</c:import>
  *
  *****
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>    
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf"%>

<c:if test="${param.isQuote eq true}">
	<c:set var="showScheduledOrders" value="false"/>
</c:if>

<c:set var="pageSize" value="${WCParam.pageSize}" />
<c:if test="${empty pageSize}">
	<c:set var="pageSize" value="${maxOrderItemsPerPage}"/>
</c:if>

<c:set var="beginIndex" value="${WCParam.beginIndex}" />
<c:if test="${empty beginIndex}">
	<c:set var="beginIndex" value="0" />
</c:if>
<c:choose>
	<c:when test="${(showProcessedOrders == true && showWaitingForApprovalOrders == false && showScheduledOrders == false) || (param.isMyAccountMainPage != null && param.isMyAccountMainPage == true)}">
		<div role="grid" id="OrderStatusTableDisplay_div_1" class="order_status_table" aria-describedby="PreviouslyProcessedSummaryMyAccountMainPage">
			<div id="PreviouslyProcessedSummaryMyAccountMainPage" class="hidden_summary">
			<c:choose>
				<c:when test="${param.isQuote eq true}">
					<fmt:message key="MO_PROCESSED_QUOTES_TABLE_DESCRIPTION" bundle="${storeText}"/>
				</c:when>
				<c:otherwise>
					<flow:ifEnabled feature="AllowReOrder">
						<fmt:message key="MO_PROCESSED_ORDERS_TABLE_DESCRIPTION" bundle="${storeText}"/>
					</flow:ifEnabled>
					<flow:ifDisabled feature="AllowReOrder">
						<fmt:message key="MO_PROCESSED_ORDERS_TABLE_DESCRIPTION_WO_REORDER" bundle="${storeText}"/>
					</flow:ifDisabled>
				</c:otherwise>
			</c:choose>
			</div>
			<c:if test="${!param.isMyAccountMainPage}">
			<div dojoType="wc.widget.RefreshArea" widgetId="ProcessedOrdersStatusDisplay" id="ProcessedOrdersStatusDisplay" controllerId="ProcessedOrdersStatusDisplayController" role="wairole:region" waistate:live="polite" waistate:atomic="false" waistate:relevant="all">
			</c:if>
			<%out.flush();%>
				<c:import url="${jspStoreDir}Snippets/Order/Cart/OrderStatusTableDetailsDisplay.jsp"> 
					<c:param name="catalogId" value="${WCParam.catalogId}" />
					<c:param name="langId" value="${WCParam.langId}" />
					<c:param name="storeId" value="${WCParam.storeId}" />
					<c:param name="selectedTab" value="PreviouslyProcessed"/>
					<c:param name="isMyAccountMainPage" value="${param.isMyAccountMainPage}"/>
				</c:import>
			<%out.flush();%>
			<c:if test="${!param.isMyAccountMainPage}">
			</div>
			</c:if>
		</div>
	</c:when>
	<c:otherwise>
		<script type="text/javascript">dojo.addOnLoad(function() { parseWidget("OrderStatusTableDisplay_div_2"); });</script>
		<div id="OrderStatusTableDisplay_div_2" class="order_status">
			<div id="OrderStatusTableDisplay_div_3" class="tabs tabs_order_status">
				<c:if test="${showProcessedOrders}">
					<span class="on" id="PreviouslyProcessed_On" style="display:inline">
						<span class="left_corner">&nbsp;</span>
						<span class="text"><fmt:message key="MO_PREVIOUSLY_PROCESSED" bundle="${storeText}"/></span>
						<span class="right_corner">&nbsp;</span>
					</span>
					<span class="off" id="PreviouslyProcessed_Off" style="display:none">
						<span class="left_corner">&nbsp;</span>
						<a href="javascript:MyAccountDisplay.selectTab('PreviouslyProcessed');" id="OrderStatusTableDisplay_links_11">
							<span class="text"><fmt:message key="MO_PREVIOUSLY_PROCESSED" bundle="${storeText}"/></span>
						</a>
						<span class="right_corner">&nbsp;</span>
					</span>
				</c:if>
				&nbsp;
				<c:if test="${showWaitingForApprovalOrders}">
					<span class="on" id="WaitingForApproval_On" style="display:none">
						<span class="left_corner">&nbsp;</span>
						<span class="text"><fmt:message key="MO_WAITING_FOR_APPROVAL" bundle="${storeText}"/></span>
						<span class="right_corner">&nbsp;</span>
					</span> 
					<span class="off" id="WaitingForApproval_Off" style="display:inline">
						<span class="left_corner">&nbsp;</span>
						<a href="javascript:MyAccountDisplay.selectTab('WaitingForApproval');" id="OrderStatusTableDisplay_links_10">
							<span class="text"><fmt:message key="MO_WAITING_FOR_APPROVAL" bundle="${storeText}"/></span>
						</a>
						<span class="right_corner">&nbsp;</span>
					</span>
				</c:if>
				&nbsp;
				<flow:ifEnabled feature="ScheduleOrder">
					<c:if test="${showScheduledOrders}">
						<span class="on" id="Scheduled_On" style="display:none">
							<span class="left_corner">&nbsp;</span>
							<span class="text"><fmt:message key="MO_SCHEDULED" bundle="${storeText}"/></span>
							<span class="right_corner">&nbsp;</span>
						</span> 
						<span class="off" id="Scheduled_Off" style="display:inline">
							<span class="left_corner">&nbsp;</span>
							<a href="javascript:MyAccountDisplay.selectTab('Scheduled');" id="OrderStatusTableDisplay_links_12">
								<span class="text"><fmt:message key="MO_SCHEDULED" bundle="${storeText}"/></span>
							</a>
							<span class="right_corner">&nbsp;</span>
						</span>
					</c:if>
				</flow:ifEnabled>
			</div>
			<div id="mainTabContainer" class="info" dojoType="dijit.layout.TabContainer" doLayout="false">
				<div id="OrderStatusTableDisplay_div_4" class="clear_float"></div>
				<c:if test="${showProcessedOrders}">
					<div role="grid" id="PreviouslyProcessed" class="order_status_table" dojoType="dijit.layout.ContentPane" aria-describedby="PreviouslyProcessedSummary" style="display:block" selected="true">
						<div id="PreviouslyProcessedSummary" class="hidden_summary">
						<c:choose>
							<c:when test="${param.isQuote eq true}">
								<fmt:message key="MO_PROCESSED_QUOTES_TABLE_DESCRIPTION" bundle="${storeText}"/>
							</c:when>
							<c:otherwise>
								<flow:ifEnabled feature="AllowReOrder">
									<fmt:message key="MO_PROCESSED_ORDERS_TABLE_DESCRIPTION" bundle="${storeText}"/>
								</flow:ifEnabled>
								<flow:ifDisabled feature="AllowReOrder">
									<fmt:message key="MO_PROCESSED_ORDERS_TABLE_DESCRIPTION_WO_REORDER" bundle="${storeText}"/>
								</flow:ifDisabled>
							</c:otherwise>
						</c:choose>
						</div>
						<div dojoType="wc.widget.RefreshArea" widgetId="ProcessedOrdersStatusDisplay" id="ProcessedOrdersStatusDisplay" controllerId="ProcessedOrdersStatusDisplayController" role="wairole:region" waistate:live="polite" waistate:atomic="false" waistate:relevant="all">
							<%out.flush();%>
								<c:import url="${jspStoreDir}Snippets/Order/Cart/OrderStatusTableDetailsDisplay.jsp"> 
									<c:param name="catalogId" value="${WCParam.catalogId}" />
									<c:param name="langId" value="${WCParam.langId}" />
									<c:param name="storeId" value="${WCParam.storeId}" />
									<c:param name="selectedTab" value="PreviouslyProcessed"/>
									<c:param name="beginIndex" value="${beginIndex}"/>
									<c:param name="isQuote" value="${param.isQuote}"/>
								</c:import>
							<%out.flush();%>
						</div>
					</div>
				</c:if>
				<c:if test="${showWaitingForApprovalOrders}">
					<wcf:url var="WaitingForApprovalOrderStatusTableDetailsURL" value="/OrderStatusTableDetailsHelper" type="Ajax">
						<wcf:param name="storeId" value="${WCParam.storeId}"/>
						<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
						<wcf:param name="langId" value="${WCParam.langId}"/>
						<wcf:param name="selectedTab" value="WaitingForApproval"/>
						<c:if test="${param.isQuote eq true}">
							<wcf:param name="isQuote" value="true"/>
						</c:if>
					</wcf:url>
					<div role="grid" id="WaitingForApproval" class="order_status_table" dojoType="dijit.layout.ContentPane" aria-describedby="WaitingForApprovalSummary" style="display:none" href="${WaitingForApprovalOrderStatusTableDetailsURL}">
					</div>
				</c:if>
				<flow:ifEnabled feature="ScheduleOrder">
					<c:if test="${showScheduledOrders}">
						<wcf:url var="ScheduledOrderStatusTableDetailsURL" value="/OrderStatusTableDetailsHelper" type="Ajax">
							<wcf:param name="storeId" value="${WCParam.storeId}"/>
							<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
							<wcf:param name="langId" value="${WCParam.langId}"/>
							<wcf:param name="selectedTab" value="Scheduled"/>
						</wcf:url>
						<div role="grid" id="Scheduled" class="order_status_table" dojoType="dijit.layout.ContentPane" aria-describedby="ScheduledSummary" style="display:none" href="${ScheduledOrderStatusTableDetailsURL}">
						</div>
					</c:if>
				</flow:ifEnabled>
			</div>
			<div class="tabfooter"></div>
		</div>
	</c:otherwise>
</c:choose>

