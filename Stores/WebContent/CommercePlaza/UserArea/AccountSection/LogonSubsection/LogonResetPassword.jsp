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
<%@ page import="com.ibm.commerce.server.JSPHelper" %>
<%@ page import="com.ibm.commerce.server.ECConstants" %>
<%@ page import="com.ibm.commerce.command.CommandContext" %>

<%@ page import="com.ibm.commerce.datatype.TypedProperty" %>
<%@ page import="com.ibm.commerce.usermanagement.commands.ECUserConstants" %>
<%@ page import="com.ibm.commerce.security.commands.ECSecurityConstants" %>


<%@ include file="../../../include/EnvironmentSetup.jsp"%>


<jsp:useBean id="bnError" class="com.ibm.commerce.beans.ErrorDataBean" scope="page">
<% com.ibm.commerce.beans.DataBeanManager.activate(bnError, request);%> 
</jsp:useBean>

<%
String email = jhelper.getParameter(ECUserConstants.EC_UREG_LOGONID);

String strErrorMessage = null;
TypedProperty hshErrorProperties = bnError.getExceptionData();

if (hshErrorProperties != null)
{
   String strErrorCode = hshErrorProperties.getString(ECConstants.EC_ERROR_CODE, "");

	if ( strErrorCode.equals(ECSecurityConstants.ERR_MISSING_LOGONID) )
		strErrorMessage=storeText.getString("Forpass_ERROR1");
	else if ( strErrorCode.equals(ECSecurityConstants.ERR_INVALID_LOGONID) ) 
		strErrorMessage=storeText.getString("Forpass_ERROR2");
	else if ( strErrorCode.equals(ECSecurityConstants.ERR_MISSING_EMAIL) )
		strErrorMessage=storeText.getString("Forpass_ERROR3");
	else if ( strErrorCode.equals(ECSecurityConstants.ERR_DISABLED_ACCOUNT) )
		strErrorMessage=storeText.getString("Forpass_ERROR_RejectedLogonID");
	else
		strErrorMessage=storeText.getString("Forpass_ERROR_UnknownError");			
	}

String state = request.getParameter("state");

if (state == null)
{
	String [] arrstate = (String []) request.getAttribute("state");
	if (arrstate != null) 
		state = arrstate[0];
}

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">

	<head>
		<title><%=storeText.getString("Forpass_Title")%></title>
		<link rel="stylesheet" href="<%=fileDir%>PCDMarket.css" type="text/css" />
		<meta name="GENERATOR" content="IBM WebSphere Studio" />

		<script language="javascript">
		var busy = false;
		function prepareSubmit(form) 
		{
			if (!busy) {
				busy = true;
				form.submit();
			}
		}
		</script>
	</head>

	<body marginheight="0" marginwidth="0" leftmargin="0" topmargin="0">
		<%@ include file="../../../include/HeaderDisplay.jspf"%>
		
		<table border="0" cellpadding="0" cellspacing="0" width="750">
			<tbody><tr>
				<td valign="top" class="dbg" width="150">
					<%
     					String incfile = includeDir + "SidebarDisplay.jsp";
     					%>
					<jsp:include page="<%=incfile%>" flush="true"></jsp:include>
     				</td>
				<td width="10"><a name="mainContent"></a><spacer type="horizontal" size="10" /><br />
				</td>
				<td valign="top">
					
					<form name="ResetPasswordForm" method="post" action="ResetPassword">
					<input type="hidden" name="<%= ECUserConstants.EC_UREG_CHALLENGEANSWER %>" value="-" />
					<input type="hidden" name="storeId" value="<%=storeId %>" />
					<input type="hidden" name="catalogId" value="<%=catalogId %>" />
					<input type="hidden" name="langId" value="<%=languageId %>" />
					<input type="hidden" name="state" value="passwdconfirm" />
					<input type="hidden" name="URL" value="ResetPasswordFormView" />
					<input type="hidden" name="errorViewName" value="ResetPasswordFormView" />
					<img src="<%=fileDir%>images/c.gif" height="20" width="20" />
					<table width="590" border="0" cellspacing="0" cellpadding="0" border="0">
					<tbody><tr valign="top">
						<td>
								<table border="0" cellpadding="0" cellspacing="0" width="100%">
								<tbody><tr>
									<td valign="top"><img src="<%=fileDir%>images/c.gif" height="11" width="11" /><br />
										<span class="title"><%=storeText.getString("Forpass_Title")%></span>
									</td>
									<td>
										<div align="right">
											<img src="<%=fileDir%>images/hdr_account.gif" alt='<%=storeText.getString("Forpass_Title")%>' /></div>
									</td>
								</tr>
								</tbody></table>
									<%
									   if (strErrorMessage != null && !strErrorMessage.equals("")) 
									   {
									      %><span class="error"><%= strErrorMessage%></span><br /><br />
										<%
									   }
									   %><%
								  	if (state != null && state.equals("passwdconfirm") && strErrorMessage == null)
									      	{
									      	%><font><%=storeText.getString("Forpass1_Text1")%></font><br /><br />
												<a href="LogonForm?langId=<%=languageId%>&storeId=<%=storeId%>&catalogId=<%=catalogId%>"><span class="strongtext"><%=storeText.getString("Alt_Continue")%></span></a><br />
												<br />
												<br />
												<br />
												<br />
												<%
									      	}
								else {
								      	%>
									<table width="296" border="0">
										<tbody><tr>
											<td class="bodytxt1" align="left" valign="bottom"><%=storeText.getString("Forpass_Text2")%>&nbsp;<br />
											</td>
										</tr>
										<tr>
											<td class="bodytxt1" align="left" valign="top">&nbsp;</td>
										</tr>
										<tr>
											<td class="bodytxt1" align="left" valign="top"><b><label for="forgotpwdtext"><%=storeText.getString("Forpass_UserID")%></label>&nbsp;&nbsp;</b></td>
										</tr>
										<tr>
											<td class="bodytxt1" align="left" valign="top"><input type="text" name="<%= ECUserConstants.EC_UREG_LOGONID %>" id="forgotpwdtext" class="iform" /></td>
										</tr>
										<tr>
											<td align="left" valign="top" height="24"><spacer type="block" width="24" height="24" /></td>
										</tr>
										<tr>
											<td align="left" valign="top"><a href="#" onclick="javascript:prepareSubmit(document.ResetPasswordForm);return false;"><img src="<%=fileDir%><%=locale.toString()%>/images/continue.gif" alt='<%=storeText.getString("Forpass_link1")%>' border="0" /></a></td>
										</tr>
										<tr>
											<td class="bodytxt1" align="left" valign="top"></td>
										</tr>
									</tbody></table>
									<br />
									<br />
							</td>
						</tr>
						<% 
						}
						%>
					</tbody></table>
					</form>
				</td>
			</tr>
		</tbody></table>
		<%@ include file="../../../include/FooterDisplay.jspf"%>
	</body>

</html>