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
<%@ page import="java.util.*" %>
<%@ page import="com.ibm.commerce.server.ECConstants" %>
<%@ page import="com.ibm.commerce.server.JSPHelper" %>
<%@ page import="com.ibm.commerce.server.JSPResourceBundle" %>
<%@ page import="com.ibm.commerce.command.CommandContext" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "DTD/xhtml1-transitional.dtd">

<%@ include file="EnvironmentSetup.jspf"%>
<head>
	<link rel="stylesheet" href="<%=fileDir%>ToolTech.css" type="text/css">
</head>

<body marginheight="0" marginwidth="0" leftmargin="0" topmargin="0" bgcolor="#4c6178" >

<table border="0" cellpadding="0" cellspacing="0" width="160" bgcolor="#4c6178">
<tr>
<td>

<%
String forStoreId = request.getParameter("forStoreId");
%>
<jsp:include page="SidebarDisplay.jsp" flush="true">
	<jsp:param name="storeId"     value="<%= forStoreId %>" />
</jsp:include> 

</td>
</tr>
</table>

</body>