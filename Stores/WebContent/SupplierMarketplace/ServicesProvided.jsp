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

<%@ include file="include/EnvironmentSetup.jspf" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title><%= tooltechtext.getString("servicesprovidedTitle") %></title>
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
				<h1><%= tooltechtext.getString("servicesprovidedTitle") %></h1>
				<table cellpadding="0" cellspacing="0" border="0" width="616">
					<tr bgcolor="#4c6178">
						<td width="100%">
							<b>
							<font face="Verdana" color="#b7d9ff" size="+1">
							<%= tooltechtext.getString("servicesprovidedSubHeading") %>
							</font>
							</b>
						</td>
					</tr>
				</table>
				<br />
				<table cellpadding="0" cellspacing="0" border="0" width="616">
				<tr>
					<td><%= tooltechtext.getString("servicesprovidedDescription") %>
				
					<h2><%= tooltechtext.getString("servicesprovidedService1") %></h2>
					<%= tooltechtext.getString("servicesprovidedServiceDescription1") %>
					
					<h2><%= tooltechtext.getString("servicesprovidedService2") %></h2>
					<%= tooltechtext.getString("servicesprovidedServiceDescription2") %>
					
					<h2><%= tooltechtext.getString("servicesprovidedService3") %></h2>  
					<%= tooltechtext.getString("servicesprovidedServiceDescription3") %>
				
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
