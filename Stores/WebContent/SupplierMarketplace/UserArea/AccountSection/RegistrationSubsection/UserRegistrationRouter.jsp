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
<%@ page import="com.ibm.commerce.server.JSPResourceBundle" %>
<%@ page import="com.ibm.commerce.command.CommandContext" %>

<% // Page specific imports%> 
<%@ page import="com.ibm.commerce.beans.DataBeanManager" %>
<%@ page import="com.ibm.commerce.beans.ErrorDataBean" %>
<%@ page import="com.ibm.commerce.datatype.TypedProperty" %>

<%@ include file="../../../include/EnvironmentSetup.jspf"%>
<% response.setContentType(tooltechtext.getString("ENCODESTATEMENT")); %> 

<jsp:useBean id="bnError" class="com.ibm.commerce.beans.ErrorDataBean" scope="page">
<% com.ibm.commerce.beans.DataBeanManager.activate(bnError, request); %>
</jsp:useBean>

<%
String incfile = null;

incfile = storeDir + "index.jsp";

//Parameters may be encrypted. Use JSPHelper to get URL parameter instead of request.getParameter().
JSPHelper jhelper = new JSPHelper(request);

String newRegistration = jhelper.getParameter("new");      

String strErrorMessageKey = "";
TypedProperty hshErrorProperties = bnError.getExceptionData();
strErrorMessageKey = bnError.getMessageKey().trim();

// If there is an error that the registration requires approval but there are no approvers, then send them to the UserAccount page.
if (hshErrorProperties != null && strErrorMessageKey.equals("_ERR_NO_APPROVERS_IN_GROUP"))
	{
	incfile = storeDir + "UserArea/AccountSection/UserAccountDisplay.jsp";
	%><jsp:include page="<%=incfile%>" flush="true">
	  	<jsp:param name="errorState" value="approvalError" />	
	  </jsp:include>

	<%

	}

else if (newRegistration != null)
	{
	incfile = storeDir + "UserArea/AccountSection/RegistrationSubsection/UserRegistrationAddForm.jsp";
	
	%><jsp:include page="<%=incfile%>" flush="true"/><%
	
	}
else
	{
	incfile = storeDir + "UserArea/AccountSection/RegistrationSubsection/UserRegistrationUpdateForm.jsp";
	%><jsp:include page="<%=incfile%>" flush="true"/><%
	}
%>

