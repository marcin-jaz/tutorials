<%
//********************************************************************
//*-------------------------------------------------------------------
//* Licensed Materials - Property of IBM
//*
//* WebSphere Commerce
//*
//* (c) Copyright IBM Corp. 2001, 2002
//*
//* US Government Users Restricted Rights - Use, duplication or
//* disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
//*
//*-------------------------------------------------------------------
//*
%>

<% // All JSPs requires these packages for getResource.jsp which is used for multi language support %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.ibm.commerce.server.ECConstants" %>
<%@ page import="com.ibm.commerce.server.JSPHelper" %>
<%@ page import="com.ibm.commerce.command.CommandContext" %>
<%@ page import="com.ibm.commerce.server.JSPResourceBundle" %>

<%@ include file="EnvironmentSetup.jspf"%>
<%@ include file="CacheParametersSetup.jspf"%>

<%
	//JSPHelper provides you with a easy way to retrieve URL parameters when they are encrypted
	JSPHelper jhelper = new JSPHelper(request);

	String storeId    = jhelper.getParameter("storeId");
	String languageId = jhelper.getParameter("langId");

	String catalogId  = jhelper.getParameter("catalogId");

	if(storeId   == null) { storeId   = sessionStoreId; }
	if(catalogId == null) { catalogId = ""; }

	String incfile = includeDir + "CachedHeaderDisplay.jsp";
%>

<jsp:include page="<%= incfile %>" flush="true">

	<jsp:param name="storeId"          value="<%= storeId %>"         />
	<jsp:param name="langId"           value="<%= languageId %>"      />

	<jsp:param name="userState"        value="<%= userState %>"       />
	<jsp:param name="userType"         value="<%= userType %>"        />

	<jsp:param name="catalogId"        value="<%= catalogId %>"       />
	<jsp:param name="rfqLinkDisplayed" value="<%= rfqLinkDisplayed %>"/>

</jsp:include>
