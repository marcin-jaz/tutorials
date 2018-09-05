<%--
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
--%>



<%@ page import="com.ibm.commerce.tools.util.UIUtil" %>
<%@ page import="java.util.*" %>
<%@ page import="com.ibm.commerce.command.CommandContext" %>
<%@ page import="com.ibm.commerce.server.ECConstants" %>


<%@ include file="../../../include/EnvironmentSetup.jspf"%>
<%

String accountNumber = (String) request.getAttribute("accountNumber");
if (accountNumber==null) accountNumber="";

%>

<tr>
<td align="left" valign="middle">
	<p><%= tooltechtext.getString("OrderSum_AccountNumber")%><br>
	</p>
</td>
<td align="left" valign="middle"></td>
<td align="left" valign="middle"><%=accountNumber%></td>
</tr>

