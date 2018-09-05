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
--%>

<%@ page import="java.util.*" %>
<%@ page import="com.ibm.commerce.server.JSPHelper" %>
<%@ page import="com.ibm.commerce.server.JSPResourceBundle" %>
<%@ page import="com.ibm.commerce.server.ECConstants" %>
<%@ page import="com.ibm.commerce.command.CommandContext" %>

<%@ include file="include/EnvironmentSetup.jspf" %>

	<table border="0" width="630">

	<tr>
	<td valign="top" align="left">
		<table>
		<tr>
			<td width="10"></td>
			<td valign="top" align="left">
				<h1><%= tooltechtext.getString("welcomeHomePage") %></h1>
				<table cellpadding="0" cellspacing="0" border="0" width="616">
					<tr bgcolor="#4c6178">
						<td width="100%">
							<b>
							<font face="Verdana" color="#b7d9ff" size="+1">
							<%= tooltechtext.getString("welcomeTitle") %>
							</font>
							</b>
						</td>
					</tr>
				</table>
				<br />
				<table cellpadding="0" cellspacing="0" border="0" width="616">
					<tr>
						<td valign="top"><%= tooltechtext.getString("welcomeDescription1") %>
						<p><%= tooltechtext.getString("welcomeDescription2") %></p>
						</td>
					</tr>
					<tr>
						<td width"616"><br />
						<%= tooltechtext.getString("welcomeDescription3") %><br /><br />

						<%= tooltechtext.getString("welcomeDescription4") %>
						</td>
					</tr>
				</table>
			</td>
		</tr>
		</table>
	</td>
	</tr>
	</table>
	</td>
