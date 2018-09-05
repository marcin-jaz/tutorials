<%
//********************************************************************
//*-------------------------------------------------------------------
//* Licensed Materials - Property of IBM
//*
//* WebSphere Commerce
//*
//* (c) Copyright IBM Corp. 2001
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
<%@ page import="com.ibm.commerce.server.JSPResourceBundle" %>
<%@ page import="com.ibm.commerce.command.CommandContext" %>

<% // Page specific imports%> 
<%@ page import="com.ibm.commerce.beans.DataBeanManager" %>

<%@ include file="../../../include/EnvironmentSetup.jspf"%>
<% response.setContentType(tooltechtext.getString("ENCODESTATEMENT")); %> 
<%
try {

	//Parameters may be encrypted. Use JSPHelper to get URL parameter instead of request.getParameter().
	JSPHelper jhelper = new JSPHelper(request);
	
	String storeId = jhelper.getParameter("storeId");
	String catalogId = jhelper.getParameter("catalogId");
	String languageId = jhelper.getParameter("langId");
	
	boolean isError = false;
	String[] strArrayAuth = (String [])request.getAttribute(ECConstants.EC_ERROR_CODE);
	if (strArrayAuth != null) isError = true;
	String userType = cmdcontext.getUser().getRegisterType().trim();
	
	String incfile = null;
	
	if (!userType.equalsIgnoreCase("G")) { 
		// User is registered - show their User Account Profile
		incfile = storeDir + "UserArea/AccountSection/UserAccountDisplay.jsp";
	} else {
		// User is not registered - show Logon Page again
		incfile = storeDir + "UserArea/AccountSection/LogonSubsection/UserLogonForm.jsp";	
	}
	

%>

<jsp:include page="<%=incfile%>" flush="true"/>

<%
} catch (Exception e) {
	e.printStackTrace();
	
	Throwable t = e;
	while (t != null && t instanceof javax.servlet.ServletException) {
		t = (Exception) ((javax.servlet.ServletException)t).getRootCause();
		t.printStackTrace();
	}
}
%>