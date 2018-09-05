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
String emailSender = jhelper.getParameter("emailSender");
String emailSubject = jhelper.getParameter("emailSubject");
String emailContent = jhelper.getParameter("emailContent");


// Create an instance of the SendMsg task command
CommandRegistryEntry cmdEntry = CommandFactory.locateCommandEntry("com.ibm.commerce.messaging.commands.SendMsgCmd", new Integer(storeId));
SendMsgCmd sendMsgCmd = (SendMsgCmd) CommandFactory.createCommand(cmdEntry);
sendMsgCmd.setCommandContext(cmdcontext);

/*	Set parameters of the SendMsg task command to the given values
 *	Use the new PCD message type for customer requests(250)
 */

sendMsgCmd.setMsgType(new Integer(250));
sendMsgCmd.setStoreID(new Integer(storeId));
sendMsgCmd.setConfigData("sender",emailSender);
sendMsgCmd.setConfigData("subject",emailSubject);

boolean valid_email = true;

try
{
	sendMsgCmd.setContent(null,languageId,emailContent);
	sendMsgCmd.sendTransacted();
	sendMsgCmd.setCommandContext(cmdcontext);

	// Execute the command to send the message
	sendMsgCmd.execute();
}
catch (Exception e)
{
	valid_email = false;
}
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title><%=storeText.getString("FeedbackSendDisplay_Title")%></title>
	<link rel="stylesheet" href="<%=fileDir%>PCDMarket.css" type="text/css" />
</head>

<body leftmargin="2" topmargin="2" marginwidth="2" marginheight="2">
		<table border="0" cellpadding="0" cellspacing="0" width="625">
			<tbody><tr>
				<td colspan="2">
					<table cellspacing="0" cellpadding="0" width="100%" border="0">
						<tbody>
							<tr class="tdblue">
								<td><img width="152" height="55" alt="<%=storeText.getString("Breadcrumb_CommercePlaza")%>" src="<%=fileDir%>images/small_logo.jpg" width="75" border="0" /></td>
								<td align="right" width="100%" class="searchBar"><a class="alternatelink" href="javascript:window.close();"><%=storeText.getString("FeedbackSendDisplay_Close")%></a>&nbsp;&nbsp;</td>
							</tr>
						</tbody>
					</table>
				</td>
			</tr>
			<tr>
				<td width="10"><spacer type="horizontal" size="10" /></td>
				<td width="615"><%
					if (valid_email)
					{
					%>
					<table cellpadding="0" cellspacing="0" width="100%" border="0">
						<tbody>
							<tr>
								<td colspan="2" height="12"><spacer type="block" width="12" height="12" />								</td><td>
							</td></tr>
							<tr>
								<td><span class="title1"><%=storeText.getString("FeedbackSendDisplay_MainTitle")%></span>
								</td><td>
							</td></tr>
							<tr>
								<td><br />
									<%=storeText.getString("FeedbackSendDisplay_ValidMessage")%></td>
							</tr>
						</tbody>
					</table>
					<%
					}
					else
					{
					%>
					<table cellpadding="0" cellspacing="0" width="100%" border="0">
						<tbody>
							<tr>
								<td colspan="2" height="12"><spacer type="block" width="12" height="12" />
							</td></tr>
							<tr>
								<td colspan="2"><span class="title1"><%=storeText.getString("FeedbackForm_MainTitle")%></span>
							</td></tr>
							<tr>
								<td colspan="2"><br />
									<%=storeText.getString("FeedbackSendDisplay_InvalidMessage")%><br />
									<br />
								</td>
							</tr>
							<tr>
								<td align="left" colspan="2">
										<table border="0" cellpadding="0" cellspacing="0">
											<tbody><tr>
												<td><a href="FeedbackFormView?storeId=<%=storeId%>&amp;catalogId=<%=catalogId%>&amp;languageId=<%=languageId%>"><img src="<%=fileDir%>images/arrow_ld.gif" border="0" alt='<%=storeText.getString("FeedbackForm_Back")%>' /></a></td>
												<td>&nbsp;</td>
												<td><a href="FeedbackFormView?storeId=<%=storeId%>&amp;catalogId=<%=catalogId%>&amp;languageId=<%=languageId%>"><%=storeText.getString("FeedbackForm_Back")%></a></td>
											</tr>
										</tbody></table>
									</td>
							</tr>
						</tbody>
					</table>
					<%
					}
					%></td>
			</tr>
		</tbody></table>
	</body></html>
