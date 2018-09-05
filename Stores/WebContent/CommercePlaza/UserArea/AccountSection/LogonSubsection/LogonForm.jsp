<%
//********************************************************************
//*-------------------------------------------------------------------
//* Licensed Materials - Property of IBM
//*
//* WebSphere Commerce
//*
//* (c) Copyright International Business Machines Corporation. 2003
//*     All rights reserved.
//*
//* US Government Users Restricted Rights - Use, duplication or
//* disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
//*
//*-------------------------------------------------------------------
//*
%>

<%@ page import="java.util.Locale" %>
<%@ page import="java.util.ResourceBundle" %>
<%@ page import="com.ibm.commerce.command.CommandContext" %>

<%@ page import="com.ibm.commerce.server.JSPHelper" %>
<%@ page import="com.ibm.commerce.server.ECConstants" %> 
<%@ page import="com.ibm.commerce.security.commands.ECSecurityConstants" %>

<%@ include file="../../../include/EnvironmentSetup.jsp"%>
<% response.setContentType(storeText.getString("ENCODESTATEMENT")); %> 
<%
 
boolean isError = false;
String[] strArrayAuth = (String [])request.getAttribute(ECConstants.EC_ERROR_CODE);
if (strArrayAuth != null) isError = true;
String userType = cmdcontext.getUser().getRegisterType().trim();

String incfile = null;

if (!userType.equalsIgnoreCase("G"))
	{ 
	// We redirect here if the user calls this JSP and they have already logged in
	incfile = storeDir + "ShoppingArea/CatalogSection/CategorySubsection/StoreCatalogDisplay.jsp";
	} 
else 
	{
	// User is not registered - show Logon Page again
	incfile = storeDir + "UserArea/AccountSection/LogonSubsection/LogonDisplay.jsp";	
	}


%>

<jsp:include page="<%=incfile%>" flush="true"/>