<%--==========================================================================
Licensed Materials - Property of IBM

WebSphere Commerce

(c) Copyright IBM Corp.  2001, 2006
All Rights Reserved

US Government Users Restricted Rights - Use, duplication or
disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
===========================================================================--%>

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

<table height="100%" width="300" class="portlet" id="WC_CachedHeadsUpDisplay_Table_1"><tr><td class="portlet" height="100%"  valign="top" id="WC_CachedHeadsUpDisplay_TableCell_1">

<h1>&nbsp;</h1>

<flow:ifEnabled feature="HUDminiCurrentOrderDisplay">
  <% out.flush(); %>
	<c:import url="${jspStoreDir}ShoppingArea/CurrentOrderSection/MiniCurrentOrderDisplay.jsp" > 
		<c:param name="storeId" value="${storeId }" />
		<c:param name="catalogId" value="${catalogId }" />
		<c:param name="langId" value="${languageId }" />
		<c:param name="rowsToDisplay" value="5"/>
	</c:import>
	<% out.flush(); %>
</flow:ifEnabled>

<flow:ifEnabled feature="HUDminiUserAccountDisplay">
	<% out.flush(); %>
	<c:import url="${jspStoreDir}UserArea/AccountSection/LogonSubsection/MiniUserLogonForm.jsp" > 
		<c:param name="storeId" value="${storeId}"/>
		<c:param name="catalogId" value="${catalogId}"/>
		<c:param name="langId" value="${langId}"/>
	</c:import>
	<% out.flush(); %>
</flow:ifEnabled>

<flow:ifEnabled feature="HUDminiTopCategoriesDisplay">
  <% out.flush(); %>
	<c:import url="${jspStoreDir}ShoppingArea/CatalogSection/CategorySubsection/MiniTopCategoriesDisplay.jsp" > 
		<c:param name="storeId" value="${storeId }" />
		<c:param name="catalogId" value="${catalogId }" />
		<c:param name="langId" value="${languageId }" />
	</c:import>
	<% out.flush(); %>
</flow:ifEnabled>

<flow:ifEnabled feature="HUDminiRequisitionListDisplay">
	<flow:ifEnabled feature="RequisitionList">
		<% out.flush(); %>
		<c:import url="${jspStoreDir}ShoppingArea/OrderCreationSection/RequisitionListSubsection/MiniRequisitionListDisplay.jsp" > 
			<c:param name="storeId" value="${storeId }" />
			<c:param name="catalogId" value="${catalogId }" />
			<c:param name="langId" value="${languageId }" />
			<c:param name="rowsToDisplay" value="5"/>
		</c:import>
		<% out.flush(); %>
	</flow:ifEnabled>
</flow:ifEnabled>

<flow:ifEnabled feature="trackOrderStatus">
	<flow:ifEnabled feature="HUDminiOrdersWaitingApprovalDisplay">
		<% out.flush(); %>
		<c:import url="${jspStoreDir}UserArea/ServiceSection/TrackOrderStatusSubsection/MiniOrderStatusDisplay1.jsp" > 
			<c:param name="storeId" value="${storeId }" />
			<c:param name="catalogId" value="${catalogId }" />
			<c:param name="langId" value="${languageId }" />
			<c:param name="rowsToDisplay" value="5"/>
		</c:import>
		<% out.flush(); %>
	</flow:ifEnabled>
	
	<flow:ifEnabled feature="HUDminiOrdersPreviouslyProcessedDisplay">
		<% out.flush(); %>
		<c:import url="${jspStoreDir}UserArea/ServiceSection/TrackOrderStatusSubsection/MiniOrderStatusDisplay2.jsp" > 
			<c:param name="storeId" value="${storeId }" />
			<c:param name="catalogId" value="${catalogId }" />
			<c:param name="langId" value="${languageId }" />
			<c:param name="rowsToDisplay" value="5"/>			
		</c:import>
		<% out.flush(); %>
	</flow:ifEnabled>
	
	<flow:ifEnabled feature="HUDminiOrdersScheduledDisplay">
		<flow:ifEnabled feature="ScheduleOrder">
			<% out.flush(); %>
			<c:import url="${jspStoreDir}UserArea/ServiceSection/TrackOrderStatusSubsection/MiniOrderStatusDisplay3.jsp" > 
				<c:param name="storeId" value="${storeId }" />
				<c:param name="catalogId" value="${catalogId }" />
				<c:param name="langId" value="${languageId }" />
				<c:param name="rowsToDisplay" value="5"/>
			</c:import>
			<% out.flush(); %>
		</flow:ifEnabled>
	</flow:ifEnabled>
</flow:ifEnabled>

<flow:ifEnabled feature="HUDminiEMarketingSpotDisplay">
	<% out.flush(); %>
	<c:import url="${jspStoreDir}include/MiniProductESpot.jsp" > 
		<c:param name="storeId" value="${storeId }" />
		<c:param name="catalogId" value="${catalogId }" />
		<c:param name="langId" value="${languageId }" />
		<c:param name="emsName" value="ConfigurableStoreDisplay"/>
	</c:import>
	<% out.flush(); %>
</flow:ifEnabled>

<flow:ifEnabled feature="accountParticipantRole">
	<% out.flush(); %>
	<c:import url="${jspStoreDir}include/portlets/MiniActiveOrganizationDisplay.jsp">
		<c:param name="storeId" value="${storeId}"/>
		<c:param name="catalogId" value="${catalogId}"/>
	</c:import>
	<% out.flush(); %>
</flow:ifEnabled>
</td></tr></table>

</flow:ifEnabled>
<!-- END CachedHeadsUpDisplay.jsp -->
