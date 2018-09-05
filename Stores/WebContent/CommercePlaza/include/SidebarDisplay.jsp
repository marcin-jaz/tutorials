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
String pageName	= (String)request.getAttribute("pageName");

boolean showStoreCreationLink	= false;
boolean showStoreAdminLink		= false;
boolean showOrgAdminLink		= false;

Integer[] userRoles = cmdcontext.getUser().getRoles();
for(int i = 0; userRoles != null && i < userRoles.length; i++) {
	
	if(!userRoles[i].equals(new Integer(-29))) { showStoreAdminLink = true; }
	
	if(userRoles[i].equals(new Integer(-1)) || userRoles[i].equals(new Integer(-4)) || userRoles[i].equals(new Integer(-27))) {
		showStoreCreationLink = true;
		showOrgAdminLink = true;
	}
	else if(userRoles[i].equals(new Integer(-21)) || userRoles[i].equals(new Integer(-22))) {
		showOrgAdminLink = true;
	}
	
}

String incfile = includeDir + "CachedSidebarDisplay.jsp";
%>

<jsp:include page="<%= incfile %>" flush="true">
	
	<jsp:param name="storeId"	value="<%= storeId %>"		/>
	<jsp:param name="langId"	value="<%= languageId %>"	/>
	<jsp:param name="catalogId"	value="<%= catalogId %>"	/>
	
	<jsp:param name="userState" value="<%= userState %>"/>
	
	<jsp:param name="pageName" value="<%= pageName %>"/>
	
	<jsp:param name="showStoreCreationLink"	value="<%= showStoreCreationLink %>"/>
	<jsp:param name="showStoreAdminLink"	value="<%= showStoreAdminLink %>"	/>
	<jsp:param name="showOrgAdminLink"		value="<%= showOrgAdminLink %>"		/>
	
</jsp:include>
