<%--
/*
 *-------------------------------------------------------------------
 * Licensed Materials - Property of IBM
 *
 * WebSphere Commerce
 *
 * (c) Copyright International Business Machines Corporation. 2001, 2004
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
  * This JSP page displays the Configurable Store Display if it is enabled. 
  *****
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../JSTLEnvironmentSetup.jspf"%>

<!-- BEGIN CachedHeadsUpDisplay.jsp -->
<flow:ifEnabled feature="headsUpDisplay">

<table height="99%" width="300" class="portlet" id="WC_CachedHeadsUpDisplay_Table_1"><tr><td class="portlet" height="100%"  valign="top" id="WC_CachedHeadsUpDisplay_TableCell_1">

<flow:ifEnabled feature="HUDminiCurrentOrderDisplay">

	<c:set var="currentPendingOrderId" value="."/>
	<%-- get the current pending order --%>                   			
	<wcbase:useBean id="orderListCurrentPendingOrderBean" classname="com.ibm.commerce.order.beans.OrderListDataBean">
		<c:set target="${orderListCurrentPendingOrderBean}" property="storeId" value="${CommandContext.storeId}"/>
		<c:set target="${orderListCurrentPendingOrderBean}" property="userId" value="${userId}"/>
		<c:set target="${orderListCurrentPendingOrderBean}" property="fetchCurrentPendingOrder" value="true"/>
	</wcbase:useBean>
	<c:forEach items="${orderListCurrentPendingOrderBean.orderDataBeans}" var="currentPendingOrder">
		<c:set var="currentPendingOrderStatus" value="${currentPendingOrder.status}"/>
		<c:if test="${currentPendingOrderStatus != 'X'}" >
			<c:set var="currentPendingOrderId" value="${currentPendingOrder.orderId}"/>
		</c:if>                                                                                                            	   	 	                 				
	</c:forEach>
	
	<wcbase:useBean id="orderListBean" classname="com.ibm.commerce.order.beans.OrderListDataBean" scope="request">
		<c:set target="${orderListBean}" property="storeId" value="${CommandContext.storeId}"/>
		<c:set target="${orderListBean}" property="retrievalOrderStatus" value="P"/>	
		<c:set target="${orderListBean}" property="userId" value="${userId}"/>
	</wcbase:useBean>
	<c:set var="orders" value="${orderListBean.orderDataBeans}" />
	<c:forEach items="${orders}" var="order">    					
			<c:set var="orderRn" value="${order.orderId}"/>       					 					
			<c:if test="${orderRn eq currentPendingOrderId or currentPendingOrderId eq '.'}" >
				<c:set var="currentPendingOrderId" value="${orderRn}"/>
			</c:if>
	</c:forEach>

	<fmt:message key="HUD_MiniCurrentOrderDisplay" var="HUDFrameTitle" bundle="${storeText}" />
	<c:url var="maximizeURL" value="OrderItemDisplayView">
		<c:param name="langId" value="${langId}" />
		<c:param name="storeId" value="${storeId}" />
		<c:param name="catalogId" value="${catalogId}" />
		<c:param name="orderId" value="${currentPendingOrderId}" />
	</c:url>
    <%@ include file="HUDContainerTop.jspf"%>
    <% out.flush(); %>
	<c:import url="${jspStoreDir}ShoppingArea/CurrentOrderSection/MiniCurrentOrderDisplay.jsp" > 
		<c:param name="storeId" value="${storeId }" />
		<c:param name="catalogId" value="${catalogId }" />
		<c:param name="langId" value="${languageId }" />
		<c:param name="orderId" value="${currentPendingOrderId}" />
		<c:param name="userType" value="${userType }" />
		<c:param name="userState" value="${userState }" />
		<c:param name="liveHelp" value="${liveHelp }" />
		<c:param name="rfqLinkDisplayed" value="${rfqLinkDisplayed }" />
		<c:param name="rowsToDisplay" value="5"/>
		<c:param name="pageToDisplay" value="${WCParam.CIPCurrentOrderPage}"/>
	</c:import>
	<% out.flush(); %>
	<%@ include file="HUDContainerBottom.jspf"%>
</flow:ifEnabled>

<flow:ifEnabled feature="HUDminiUserAccountDisplay">
	<c:choose>
		<c:when test="${userType == 'G'}">
			<fmt:message key="Logon_Title" var="HUDFrameTitle" bundle="${storeText}"/>
			<c:set var="portletJSP" value="UserArea/AccountSection/LogonSubsection/MiniUserLogonForm.jsp"/>
			<c:url var="maximizeURL" value="LogonForm">
				<c:param name="langId" value="${langId}" />
				<c:param name="storeId" value="${storeId}" />
				<c:param name="catalogId" value="${catalogId}" />
			</c:url>
		</c:when>
		<c:otherwise>
			<fmt:message key="Account_Heading1" var="HUDFrameTitle" bundle="${storeText}"/>
			<c:set var="portletJSP" value="UserArea/AccountSection/MiniUserAccountDisplay.jsp"/>
			<c:url var="maximizeURL" value="UserAccountView">
				<c:param name="langId" value="${langId}" />
				<c:param name="storeId" value="${storeId}" />
				<c:param name="catalogId" value="${catalogId}" />
			</c:url>
		</c:otherwise>
	</c:choose>
	<%@ include file="HUDContainerTop.jspf"%>
	<% out.flush(); %>
	<c:import url="${jspStoreDir}${portletJSP}" > 
		<c:param name="storeId" value="${storeId}"/>
		<c:param name="catalogId" value="${catalogId}"/>
		<c:param name="langId" value="${langId}"/>
		<c:param name="userType" value="${userType}"/>
		<c:param name="userState" value="${userState}"/>
		<c:param name="liveHelp" value="${liveHelp}"/>
	</c:import>
	<% out.flush(); %>
	<%@ include file="HUDContainerBottom.jspf"%>
</flow:ifEnabled>

<flow:ifEnabled feature="HUDminiTopCategoriesDisplay">
	<fmt:message key="HUD_MiniTopCategoriesDisplay" var="HUDFrameTitle" bundle="${storeText}" />
	<c:url var="maximizeURL" value="TopCategoriesDisplay">
		<c:param name="langId" value="${langId}" />
		<c:param name="storeId" value="${storeId}" />
		<c:param name="catalogId" value="${catalogId}" />
	</c:url>
    <%@ include file="HUDContainerTop.jspf"%>
    <% out.flush(); %>
	<c:import url="${jspStoreDir}ShoppingArea/CatalogSection/CategorySubsection/MiniTopCategoriesDisplay.jsp" > 
		<c:param name="storeId" value="${storeId }" />
		<c:param name="catalogId" value="${catalogId }" />
		<c:param name="langId" value="${languageId }" />
		<c:param name="userType" value="${userType }" />
		<c:param name="userState" value="${userState }" />
		<c:param name="liveHelp" value="${liveHelp }" />
	</c:import>
	<% out.flush(); %>
	<%@ include file="HUDContainerBottom.jspf"%>
</flow:ifEnabled>

<flow:ifEnabled feature="HUDminiRequisitionListDisplay">
	<flow:ifEnabled feature="RequisitionList">
		<fmt:message key="HUD_MiniRequisitionListDisplay" var="HUDFrameTitle" bundle="${storeText}" />
		<c:url var="maximizeURL" value="RequisitionListDisplayView">
			<c:param name="langId" value="${langId}" />
			<c:param name="storeId" value="${storeId}" />
			<c:param name="catalogId" value="${catalogId}" />
		</c:url>
		<%@ include file="HUDContainerTop.jspf"%>
		<% out.flush(); %>
		<c:import url="${jspStoreDir}ShoppingArea/OrderCreationSection/RequisitionListSubsection/MiniRequisitionListDisplay.jsp" > 
			<c:param name="storeId" value="${storeId }" />
			<c:param name="catalogId" value="${catalogId }" />
			<c:param name="langId" value="${languageId }" />
			<c:param name="userType" value="${userType }" />
			<c:param name="userState" value="${userState }" />
			<c:param name="liveHelp" value="${liveHelp }" />
			<c:param name="rfqLinkDisplayed" value="${rfqLinkDisplayed }" />
			<c:param name="requisitionListsType" value="All"/>
			<c:param name="rowsToDisplay" value="5"/>
			<c:param name="pageToDisplay" value="${WCParam.CIPReqListPage }"/>
		</c:import>
		<% out.flush(); %>
		<%@ include file="HUDContainerBottom.jspf"%>
	</flow:ifEnabled>
</flow:ifEnabled>

<flow:ifEnabled feature="trackOrderStatus">
	<flow:ifEnabled feature="HUDminiOrdersWaitingApprovalDisplay">
		<fmt:message key="HUD_MiniOrdersWaitingApprovalDisplay" var="HUDFrameTitle" bundle="${storeText}" />
		<c:url var="maximizeURL" value="TrackOrderStatus">
			<c:param name="langId" value="${langId}" />
			<c:param name="storeId" value="${storeId}" />
			<c:param name="catalogId" value="${catalogId}" />
		</c:url>
		<%@ include file="HUDContainerTop.jspf"%>
		<% out.flush(); %>
		<c:import url="${jspStoreDir}UserArea/ServiceSection/TrackOrderStatusSubsection/MiniOrderStatusDisplay1.jsp" > 
			<c:param name="storeId" value="${storeId }" />
			<c:param name="catalogId" value="${catalogId }" />
			<c:param name="langId" value="${languageId }" />
			<c:param name="userType" value="${userType }" />
			<c:param name="userState" value="${userState }" />
			<c:param name="liveHelp" value="${liveHelp }" />
			<c:param name="rfqLinkDisplayed" value="${rfqLinkDisplayed }" />
			<c:param name="rowsToDisplay" value="5"/>
			<c:param name="pageToDisplay" value="${WCParam.CIPOrderStatus1Page }"/>
		</c:import>
		<% out.flush(); %>
		<%@ include file="HUDContainerBottom.jspf"%>
	</flow:ifEnabled>
	
	<flow:ifEnabled feature="HUDminiOrdersPreviouslyProcessedDisplay">
		<fmt:message key="HUD_MiniOrdersPreviouslyProcessedDisplay" var="HUDFrameTitle" bundle="${storeText}" />
		<c:url var="maximizeURL" value="TrackOrderStatus">
			<c:param name="langId" value="${langId}" />
			<c:param name="storeId" value="${storeId}" />
			<c:param name="catalogId" value="${catalogId}" />
		</c:url>
		<%@ include file="HUDContainerTop.jspf"%>
		<% out.flush(); %>
		<c:import url="${jspStoreDir}UserArea/ServiceSection/TrackOrderStatusSubsection/MiniOrderStatusDisplay2.jsp" > 
			<c:param name="storeId" value="${storeId }" />
			<c:param name="catalogId" value="${catalogId }" />
			<c:param name="langId" value="${languageId }" />
			<c:param name="userType" value="${userType }" />
			<c:param name="userState" value="${userState }" />
			<c:param name="liveHelp" value="${liveHelp }" />
			<c:param name="rfqLinkDisplayed" value="${rfqLinkDisplayed }" />
			<c:param name="rowsToDisplay" value="5"/>
			<c:param name="pageToDisplay" value="${WCParam.CIPOrderStatus2Page }"/>
		</c:import>
		<% out.flush(); %>
		<%@ include file="HUDContainerBottom.jspf"%>
	</flow:ifEnabled>
	
	<flow:ifEnabled feature="HUDminiOrdersScheduledDisplay">
		<flow:ifEnabled feature="ScheduleOrder">
			<fmt:message key="HUD_MiniOrdersScheduledDisplay" var="HUDFrameTitle" bundle="${storeText}" />
			<c:url var="maximizeURL" value="TrackOrderStatus">
				<c:param name="langId" value="${langId}" />
				<c:param name="storeId" value="${storeId}" />
				<c:param name="catalogId" value="${catalogId}" />
			</c:url>
			<%@ include file="HUDContainerTop.jspf"%>
			<% out.flush(); %>
			<c:import url="${jspStoreDir}UserArea/ServiceSection/TrackOrderStatusSubsection/MiniOrderStatusDisplay3.jsp" > 
				<c:param name="storeId" value="${storeId }" />
				<c:param name="catalogId" value="${catalogId }" />
				<c:param name="langId" value="${languageId }" />
				<c:param name="userType" value="${userType }" />
				<c:param name="userState" value="${userState }" />
				<c:param name="liveHelp" value="${liveHelp }" />
				<c:param name="rfqLinkDisplayed" value="${rfqLinkDisplayed }" />
				<c:param name="rowsToDisplay" value="5"/>
				<c:param name="pageToDisplay" value="${WCParam.CIPOrderStatus3Page }"/>
			</c:import>
			<% out.flush(); %>
			<%@ include file="HUDContainerBottom.jspf"%>
		</flow:ifEnabled>
	</flow:ifEnabled>
</flow:ifEnabled>
<flow:ifEnabled feature="HUDminiEMarketingSpotDisplay">
	<fmt:message key="HUD_MiniEMarketingSpotDisplay" var="HUDFrameTitle" bundle="${storeText}" />
	<c:set var="maximizeURL" value=""/>
	<%@ include file="HUDContainerTop.jspf"%>
	<% out.flush(); %>
	<c:import url="${jspStoreDir}include/MiniProductESpot.jsp" > 
		<c:param name="storeId" value="${storeId }" />
		<c:param name="catalogId" value="${catalogId }" />
		<c:param name="langId" value="${languageId }" />
		<c:param name="userType" value="${userType }" />
		<c:param name="userState" value="${userState }" />
		<c:param name="liveHelp" value="${liveHelp }" />
		<c:param name="rfqLinkDisplayed" value="${rfqLinkDisplayed }" />
		<c:param name="emsName" value="ConfigurableStoreDisplay"/>
	</c:import>
	<% out.flush(); %>
	<%@ include file="HUDContainerBottom.jspf"%>
</flow:ifEnabled>
</td></tr></table>

</flow:ifEnabled>
<!-- END CachedHeadsUpDisplay.jsp -->