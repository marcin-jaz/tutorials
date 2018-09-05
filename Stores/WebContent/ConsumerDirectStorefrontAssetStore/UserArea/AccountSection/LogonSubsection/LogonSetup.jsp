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
  * This Setup JSP page includes 1 of the following 3 pages depending on whether the shopper is logged on and depending on what parameter values are being passed in the URL
  *  - AccountDisplay
  *  - MyAccountDisplay
  *  - OrderStatusDisplay
  * Furthermore, if the value of parameter 'personalizedCatalog' is set to true and if there is no error,
  * the catalogId will be changed based on the web activity setup for the e-Marketing Spot called "PersonalizedCatalog".
  *****
--%>


<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf" %>
<%-- ErrorMessageSetup.jspf is used to retrieve an appropriate error message when there is an error --%>
<%@ include file="../../../include/ErrorMessageSetup.jspf" %>



<c:choose>
<c:when test="${WCParam.personalizedCatalog eq 'true' && empty storeError.key}">
<%-- 
  ***
  * This section below is used to determine which catalog will be displayed.
  * The selection of the catalog is based on the web activity setup for the e-Marketing Spot called "PersonalizedCatalog".
  * We make use of the urlLink field in the Ad copy to save the catalog identifier.
  * By default, the master catalog is selected if there is no Ad copy or 
  * if the catalog identifier in the urlLink field does not match the identifiers of the sale catalogs.
  * 
  * In this case, marketing managers can use the Accelerator to specify which sale catalog to show
  * based on the condition defined in the web activity.
  * 
  * This logic is executed only if the calling action passes the parameter "personalizedCatalog" with the value set to "true".
  * Currently, the actions that pass this parameter is Logon, Logoff and UserRegistrationUpdate.
  ***
--%>
	<%-- by default, the master catalog is specified as the "selectedCatalogId"  --%>
	<c:set var="selectedCatalogId" value="${sdb.masterCatalogDataBean.catalogId}" />
	<wcbase:useBean id="personalizedCatalogSpot" classname="com.ibm.commerce.marketing.beans.EMarketingSpot">
		<%-- set the e-Marketing Spot name as "PersonalizedCatalog" --%>
		<c:set target="${personalizedCatalogSpot}" property="name" value="PersonalizedCatalog" />
		<c:set value="1" target="${personalizedCatalogSpot}" property="maximumNumberOfCollateral" />
	</wcbase:useBean>
	<%--
	  ***
	  * The urlLink field in the Ad copy is used to save the catalog identifier.
	  * If the emspot contains collateral (i.e. Ad Copy), the identifier in the urlLink field will be retrieved.
	  * If the catalog identifier in the urlLink field matches the identifiers of the sale catalogs, that catalog will be set as the "selectedCatalogId".
	  ***
	--%>
 	<c:if test="${personalizedCatalogSpot.containCollateral}">
		<c:forEach items="${sdb.salesCatalogs}" var="saleCatalogDataBean">
			<c:if test="${saleCatalogDataBean.identifier == personalizedCatalogSpot.collateral[0].urlLink}">
				<c:set var="selectedCatalogId" value="${saleCatalogDataBean.catalogId}" />
			</c:if>
		</c:forEach>
 	</c:if>
 	<%-- The page will be reloaded with the selected catalogId --%>
	<c:url var="sWebAppPath" value="LogonForm">
		<c:param name="catalogId" value="${selectedCatalogId}"/>
		<c:param name="storeId" value="${WCParam.storeId}"/>
		<c:param name="langId" value="${CommandContext.languageId}"/>
	</c:url>
	<meta http-equiv="Refresh" content="0;URL=<c:out value="${sWebAppPath}"/>"/>
</c:when>
<c:otherwise>
	<c:choose>
		<c:when test="${WCParam.page eq 'sidebar'}">
			<c:set var="incfile" value="${jspStoreDir}UserArea/AccountSection/AccountDisplay.jsp"/>
		</c:when>
		<c:when test="${(WCParam.page eq 'orderstatus' || param.page eq 'orderstatus') && userType eq 'G'}">
			<%-- force the customer to login or register if they want to view their order status --%>
			<c:set var="incfile" value="${jspStoreDir}UserArea/AccountSection/AccountDisplay.jsp?page=orderstatus"/>
		</c:when>
		<c:when test="${WCParam.page eq 'orderstatus' || param.page eq 'orderstatus'}">
			<%-- take the customer to the Order Status page if they are logged in and they requested it --%>
			<c:set var="incfile" value="${jspStoreDir}UserArea/ServiceSection/TrackOrderStatusSubsection/OrderStatusDisplay.jsp"/>
		</c:when>
		<c:when test="${userType eq 'G'}">
			<c:set var="incfile" value="${jspStoreDir}UserArea/AccountSection/AccountDisplay.jsp"/>
		</c:when>
		<c:when test="${WCParam.page eq 'quickcheckout'}">
			<c:set var="incfile" value="${jspStoreDir}UserArea/AccountSection/MyAccountDisplay.jsp"/>
		</c:when>
		<c:otherwise>
			<%--
			  ***
			  * if there is an error, this means that a registered shopper tried to 
			  * logon as another user and logon fails.  In this case, UserArea/AccountSection/AccountDisplay.jsp is displayed.
			  ***
			--%>
			<c:choose>
				<c:when test="${!empty storeError.key}">
					<c:set var="incfile" value="${jspStoreDir}UserArea/AccountSection/AccountDisplay.jsp"/>
				</c:when>
				<c:otherwise>
					<c:set var="incfile" value="${jspStoreDir}UserArea/AccountSection/MyAccountDisplay.jsp"/>
				</c:otherwise>
			</c:choose>
		</c:otherwise>
	</c:choose>

	<c:import url="${incfile}"/>

</c:otherwise>
</c:choose>
