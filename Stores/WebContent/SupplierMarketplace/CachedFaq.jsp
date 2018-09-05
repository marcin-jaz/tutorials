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

<%
    // JSPHelper provides you with a easy way to retrieve URL parameters when they are encrypted
    JSPHelper jhelper = new JSPHelper(request);

    String catalogId = jhelper.getParameter("catalogId");
    String languageId = jhelper.getParameter("langId");
    String storeId = jhelper.getParameter("storeId");
    String inFrame="";
    String navState="admin";
%>
<%!
    final static String TOTAL_FAQ = "14";
%>

	<table border="0" width="630">
	<tr>
	<td valign="top" align="left">
		<table>
		<tr>
			<td width="10"></td>
			<td>

				<h1><%= tooltechtext.getString("faqTitle") %></h1>
				<table cellpadding="0" cellspacing="0" border="0" width="616">
					<tr bgcolor="#4c6178">
						<td width="100%">
							<b>
							<font face="Verdana" color="#b7d9ff" size="+1">
							<%= tooltechtext.getString("faqSubHeading") %>
							</font>
							</b>
						</td>
					</tr>
				</table>
				<br />
				<table cellpadding="0" cellspacing="0" border="0" width="616">
				<%
				int totalQA = (new Integer(TOTAL_FAQ)).intValue();
				for (int i=0; i<totalQA; i++) {
				    if (i != 11)
				    {
					StringBuffer question = new StringBuffer();
					question.append("faqQuestion");
					question.append(i+1);

					StringBuffer answer = new StringBuffer();
					answer.append("faqAnswer");
					answer.append(i+1);
				%>
					<p><b><%= tooltechtext.getString(question.toString()) %></b></p>
					<p><%= tooltechtext.getString(answer.toString()) %></p>
				<%
				    }
				}
				%>
				</table>

			</td>
		</tr>
		</table>
	</td>
	</tr>
	</table>
