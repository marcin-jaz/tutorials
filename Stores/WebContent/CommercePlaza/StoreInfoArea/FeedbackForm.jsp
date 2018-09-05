<%
//********************************************************************
//*-------------------------------------------------------------------
//* Licensed Materials - Property of IBM
//*
//* WebSphere Commerce
//*
//* (c) Copyright International Business Machines Corporation. 2003
//*     All rights reserved.
//*
//* US Government Users Restricted Rights - Use, duplication or
//* disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
//*
//*-------------------------------------------------------------------
//*
%>

<%@ page import="java.util.Locale" %>
<%@ page import="java.util.ResourceBundle" %>
<%@ page import="com.ibm.commerce.command.CommandContext" %>
<%@ page import="com.ibm.commerce.command.CommandFactory" %>
<%@ page import="com.ibm.commerce.registry.CommandRegistryEntry" %>

<%@ page import="com.ibm.commerce.server.JSPHelper" %>
<%@ page import="com.ibm.commerce.server.ECConstants" %>
<%@ page import="com.ibm.commerce.registry.CommandRegistry" %>
<%@ page import="com.ibm.commerce.messaging.commands.SendMsgCmd" %>


<%@ include file="../include/EnvironmentSetup.jsp"%>
<% response.setContentType(storeText.getString("ENCODESTATEMENT")); %> 

<jsp:useBean id="bnError" class="com.ibm.commerce.beans.ErrorDataBean" scope="page">
<% com.ibm.commerce.beans.DataBeanManager.activate(bnError, request); %>
</jsp:useBean>

<%
String strLocale = cmdcontext.getLocale().toString();


// Create an instance of the SendMsg task command
CommandRegistryEntry cmdEntry = CommandFactory.locateCommandEntry("com.ibm.commerce.messaging.commands.SendMsgCmd", new Integer(storeId));
SendMsgCmd sendMsgCmd = (SendMsgCmd) CommandFactory.createCommand(cmdEntry);
sendMsgCmd.setCommandContext(cmdcontext);
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
	<head>
		<title><%=storeText.getString("FeedbackForm_Title")%></title>
		<link rel="stylesheet" href="<%=fileDir%>PCDMarket.css" type="text/css" />
		<script language="javascript">

		function SendMessage(form)
		{
			emailField = form.emailSender.value;
			if (emailField.length < 1)
			{
				form.emailSender.focus();
				alert("<%=storeText.getString("FeedbackForm_EnterEmailAlert")%>");		
			}
			else
			{
				form.action='FeedbackSendDisplayView';
				form.submit();
			}
		}
	</script>
	</head>

	<body leftmargin="2" topmargin="2" marginwidth="2" marginheight="2">
		<table border="0" cellpadding="0" cellspacing="0" width="625">
			<tbody><tr>
				<td colspan="2">
					<table cellspacing="0" cellpadding="0" width="100%" border="0">
						<tbody>
							<tr class="tdblue">
								<td><img width="152" height="55" alt="<%=storeText.getString("Breadcrumb_CommercePlaza")%>" src="<%=fileDir%>images/small_logo.jpg" width="75" border="0" /></td>
								<td align="right" width="100%" class="searchBar"><a class="alternatelink" href="javascript:window.close();"><%=storeText.getString("FeedbackForm_Close")%></a>&nbsp;&nbsp;</td>
							</tr>
						</tbody>
					</table>
				</td>
			</tr>
			<tr>
				<td width="10"><spacer type="block" width="10" height="10" /></td>
				<td width="615">
					<form name="FeedbackForm" action="#" method="post">
						<table cellspacing="0" cellpadding="0" width="100%" border="0">
							<tbody>
								<tr>
									<td height="12" colspan="2"><spacer type="block" width="12" height="12" /></td>
								</tr>
								<tr>
									<td width="100%"><span class="title1"><%=storeText.getString("FeedbackForm_MainTitle")%></span></td>
									<td></td>
								</tr>
								<tr>
									<td width="100%"><br />
										<%=storeText.getString("FeedbackForm_Instructions1")%><br />
										<br />
									</td>
								</tr>
							</tbody>
							<tbody></tbody>
						</table>
						<table cellspacing="0" cellpadding="0" width="95%" border="0">
							<tbody>
								<tr>
									<td class="bodytxt1"><b><label for="sendertext"><%=storeText.getString("FeedbackForm_EmailAddressLabel")%></label>&nbsp;</b></td>
								</tr>
								<tr>
									<td><input type="text" size="35" name="emailSender" maxlength="75" value="" class="iform" id="sendertext"/></td>
								</tr>
								<tr>
									<td class="bodytxt1"><b><label for="subjecttext"><%=storeText.getString("FeedbackForm_SubjectLabel")%></label></b></td>
								</tr>
								<tr>
									<td><input type="text" size="35" name="emailSubject" maxlength="75" value="" class="iform" id="subjecttext"/></td>
								</tr>
								<tr>
									<td class="bodytxt1"><b><label for="contenttext"><%=storeText.getString("FeedbackForm_ContentLabel")%></label></b></td>
								</tr>
								<tr>
									<td><textarea name="emailContent" cols="50" rows="10" wrap="physical" class="iform" id="contenttext"></textarea></td>
								</tr>
								<tr>
									<td height="12"><spacer type="block" width="12" height="12" /></td>
								</tr>
								<tr>
									<td><a href="javascript:SendMessage(document.FeedbackForm)"><img alt='<%=storeText.getString("FeedbackForm_SubmitButton")%>' src="<%=fileDir%><%=locale.toString()%>/images/btn_submit.gif"  border="0" name="Submit" /></a></td>
								</tr>
							</tbody>
						</table>
					</form>
				</td>
			</tr>
		</tbody></table>
	</body>

</html>
