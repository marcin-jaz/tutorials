<%--
//********************************************************************
//*-------------------------------------------------------------------
//* Licensed Materials - Property of IBM
//*
//* WebSphere Commerce
//*
//* (c) Copyright IBM Corp. 2003, 2004
//*
//* US Government Users Restricted Rights - Use, duplication or
//* disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
//*
//*-------------------------------------------------------------------
//*
--%>

<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.ibm.commerce.server.*" %>

<%@ include file="EnvironmentSetup.jsp"%>

<%
String errorType = jhelper.getParameter("errorType");

String errorView = "StoreCatalogDisplayView";
if("TopCategoriesDisplay".equals(request.getAttribute("RequestPriceAvailErrorView"))) {
	errorView = "TopCategoriesDisplayView";
}

String incfile = includeDir + "CachedQuickLinksDisplay.jsp";
%>

<jsp:include page="<%= incfile %>" flush="true">
	
	<jsp:param name="storeId"	value="<%= storeId %>"		/>
	<jsp:param name="langId"	value="<%= languageId %>"	/>
	<jsp:param name="catalogId"	value="<%= catalogId %>"	/>
	
	<jsp:param name="errorType"	value="<%= errorType %>"/>
	<jsp:param name="errorView"	value="<%= errorView %>"/>
	
</jsp:include>
