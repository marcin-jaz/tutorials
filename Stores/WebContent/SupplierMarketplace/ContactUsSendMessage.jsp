<%--
/*
 *-------------------------------------------------------------------
 * Licensed Materials - Property of IBM 
 *
 * WebSphere Commerce
 *
 * (c) Copyright International Business Machines Corporation. 2003
 *     All rights reserved.
 *
 * US Government Users Restricted Rights - Use, duplication or
 * disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
 *-------------------------------------------------------------------
*/
////////////////////////////////////////////////////////////////////////////////
//
// Change History
//
// YYMMDD    F/D#   WHO       Description
//------------------------------------------------------------------------------
// 021210	    CON	      Initial Copied form SPE
////////////////////////////////////////////////////////////////////////////////
--%>

<%@ page import="java.util.*" %>
<%@ page import="com.ibm.commerce.server.JSPResourceBundle" %>
<%@ page import="com.ibm.commerce.server.ECConstants" %>
<%@ page import="com.ibm.commerce.command.CommandContext" %>
<%@ page import="com.ibm.commerce.command.CommandFactory" %>
<%@ page import="com.ibm.commerce.exception.ECSystemException" %>
<%@ page import="com.ibm.commerce.messaging.commands.SendMsgCmd" %>
<%@ page import="com.ibm.commerce.registry.CommandRegistryEntry" %>
<%@ page import="com.ibm.commerce.server.JSPHelper" %>
<%@ include file="include/EnvironmentSetup.jspf" %>

<%!
final static String CUSTOMER_MSG = "250";
%>

<%
JSPHelper jhelper = new JSPHelper(request);

String storeId = jhelper.getParameter(ECConstants.EC_STORE_ID);
String subject = jhelper.getParameter("subject");
String messageContent = jhelper.getParameter("messageContent");

// Create an instance of the SendMsg task command
CommandRegistryEntry cmdEntry = CommandFactory.locateCommandEntry("com.ibm.commerce.messaging.commands.SendMsgCmd", new Integer(storeId));
SendMsgCmd sendMsgCmd = (SendMsgCmd) CommandFactory.createCommand(cmdEntry);
sendMsgCmd.setCommandContext(cmdcontext);
sendMsgCmd.setMsgType(new Integer(CUSTOMER_MSG));
sendMsgCmd.setStoreID(new Integer(storeId));
sendMsgCmd.setConfigData("subject",subject);

boolean exceptionOccurred = false;

try
{
	sendMsgCmd.setContent(null,cmdcontext.getLanguageId().toString(),messageContent);
	sendMsgCmd.sendTransacted();
	sendMsgCmd.execute();
}
catch (ECSystemException e)
{
	exceptionOccurred = true;
}

%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title><%= tooltechtext.getString("contactusTitle") %></title>
	<link rel="stylesheet" HREF="<%=fileDir%>ToolTech.css" type="text/css">
</head>

<body marginheight="0" marginwidth="0" leftmargin="0" topmargin="0">

<%
String incfile;
incfile = includeDir + "HeaderDisplay.jsp";
%>
<jsp:include page="<%=incfile%>" flush="true"/>  


<table cellpadding="0" cellspacing="0" border="0" height="99%" width="790">
<tr>
	<td valign="top" bgcolor="#4c6178" width="160"> 
		<%
		incfile = includeDir + "SidebarDisplay.jsp";
		%>
		<jsp:include page="<%=incfile%>" flush="true"/>  

	</td>

	<td valign="top" width="630">
  

<!--DIV ALIGN="center"-->

	<table border="0" width="630">
	
	<tr>
	<td valign="top" align="left">
		<table>
		<tr>
			<td width="10"></td>
			<td>

				<h1><%= tooltechtext.getString("contactusTitle") %></h1>
				<table cellpadding="0" cellspacing="0" border="0" width="616">
					<tr bgcolor="#4c6178">
						<td width="100%">
							<b>
							<font face="Verdana" color="#b7d9ff" size="+1">
							<%= tooltechtext.getString("contactusSubHeading") %>
							</font>
							</b>
						</td>
					</tr>
				</table>
				<br />
				<table cellpadding="0" cellspacing="0" border="0" width="616">
					<tr>
						<td>
						<% if (exceptionOccurred) { %>
							<p><font color="red"><%= tooltechtext.getString("contactusError") %></font><br><br></p>
						<% } else { %>
							<%= tooltechtext.getString("contactusSuccess") %>
						<% } %>
						</td>
					</tr>
				</table>
				<br />

			</td>
		</tr>
		</table>
	</td>
	</tr>
	</table>
	</td>
</tr>
</table>

</body>
</html>
