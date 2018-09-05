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
    JSPHelper jhelper = new JSPHelper(request);
    String storeId = jhelper.getParameter(ECConstants.EC_STORE_ID);
    String langId = jhelper.getParameter(ECConstants.EC_LANGUAGE_ID);
    String catalogId = jhelper.getParameter("catalogId");

    String validationError = jhelper.getParameter("validationError");
    String subject = jhelper.getParameter("subject");
    String inFrame="";
    String navState="admin";
%>

<script language="javascript">
function submitComment() {
	if (document.sendMsgForm.messageContent.value == "") {
		document.sendMsgForm.action = "ContactUsView";
	} else {
		document.sendMsgForm.validationError.value = "false";
		document.sendMsgForm.action = "ContactUsSendMessageView";
	}
	document.sendMsgForm.submit();
}
</script>

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
				<form name="sendMsgForm" method="post" action="" >
					<input type="hidden" NAME="<%= ECConstants.EC_STORE_ID %>" VALUE="<%= storeId %>">
					<input type="hidden" NAME="<%= ECConstants.EC_LANGUAGE_ID %>" VALUE="<%= langId %>">
					<input type="hidden" name="validationError" value="true" >
					<input type="hidden" name="actionName" value="contactus" >
					<%
					if (validationError != null && validationError.equals("true")) {
					%>
						<tr><td><p><font color="red"><%= tooltechtext.getString("contactusNoComments") %></font><br><br></p></td></tr>
					<%
					}
					%>

					<tr>
						<td><label for="subject"><%= tooltechtext.getString("contactusDescription") %></label>
							<p>
							<select name="subject" id="subject">
							<%
							String selected = "";
							if (subject != null && subject.equals(tooltechtext.getString("contactusOption1"))) {
								selected = "selected";
							}
							%>
							<option value="<%= tooltechtext.getString("contactusOption1") %>" <%= selected %> ><%= tooltechtext.getString("contactusOption1") %></option>
							<%
							selected = "";
							if (subject != null && subject.equals(tooltechtext.getString("contactusOption2"))) {
								selected = "selected";
							}
							%>
							<option value="<%= tooltechtext.getString("contactusOption2") %>" <%= selected %> ><%= tooltechtext.getString("contactusOption2") %></option>
							<%
							selected = "";
							if (subject != null && subject.equals(tooltechtext.getString("contactusOption3"))) {
								selected = "selected";
							}
							%>
							<option value="<%= tooltechtext.getString("contactusOption3") %>" <%= selected %> ><%= tooltechtext.getString("contactusOption3") %></option>
							</select>
							</p>
							<label for="messageContent"><img src="<%=fileDir%>images/trans.gif" height="1" width="1" border="0" alt="<%=tooltechtext.getString("Forum_yourMsg")%>"/></label><textarea name="messageContent" id="messageContent" cols="40" rows="6"></textarea>
							<p>
							<table>
								<tr>
									<td><button type="button" name="submitForm" id="form" onClick="javascript:submitComment();" ><%= tooltechtext.getString("contactusSubmit") %></button></td>
									<td>&nbsp;</td>
									<td><button type="reset" name="reset" id="form"><%= tooltechtext.getString("contactusReset") %></button></td>
								</tr>
							</table>
							</p>
						</td>
					</tr>
				</form>
				</table>
				<br />

			</td>
		</tr>
		</table>
	</td>
	</tr>
	</table>
