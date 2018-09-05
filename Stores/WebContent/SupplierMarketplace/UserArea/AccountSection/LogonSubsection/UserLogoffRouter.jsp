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


<%@ include file="../../../include/EnvironmentSetup.jspf"%>
<% response.setContentType(tooltechtext.getString("ENCODESTATEMENT")); %> 
<flow:ifEnabled feature="customerCare">
<HTML>
<HEAD>
<SCRIPT language="javascript">
   if (typeof parent.setCustomerName == 'function')
     parent.setCustomerName (parent.WCSGUESTID, '')
   if (typeof parent.setShoppingCartItems == 'function')
     parent.setShoppingCartItems(0);
</SCRIPT>
</HEAD>
</HTML>
</flow:ifEnabled>
<%
try {
	String incfile = null;
	String state = request.getParameter("state");
	String file = null;
	
	if (state == null) {
		String [] arrstate = (String []) request.getAttribute("state");      
		if (arrstate != null) {
			state = arrstate[0];
		}
	}

	if (state == null || state.length() == 0) {	
		incfile = storeDir + "UserArea/AccountSection/LogonSubsection/UserLogonRouter.jsp";
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