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
			<td>

				<h1><%= tooltechtext.getString("pricesTitle") %></h1>
				<table cellpadding="0" cellspacing="0" border="0" width="616">
					<tr bgcolor="#4c6178">
						<td width="100%">
							<b>
							<font face="Verdana" color="#b7d9ff" size="+1">
							<%= tooltechtext.getString("pricesSubHeading1") %>
							</font>
							</b>
						</td>
					</tr>
				</table>
				<br />
				<table cellpadding="0" cellspacing="0" border="0" width="616">
					<tr>
						<td><%= tooltechtext.getString("pricesDescription1") %>

				<p><%= tooltechtext.getString("pricesDescription1a") %>

				<ol>
				  <li><%= tooltechtext.getString("pricesDescription1aBullet1") %><br>
				  </li>
				  <li><%= tooltechtext.getString("pricesDescription1aBullet2") %><br>
				  </li>
				  <li><%= tooltechtext.getString("pricesDescription1aBullet3") %>
				  </li>
				</ol>

				<p><%= tooltechtext.getString("pricesDescription1b") %></p>
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
