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

<%@ page import="com.ibm.commerce.usermanagement.commands.ECUserConstants" %>
<%@ page import="com.ibm.commerce.security.commands.ECSecurityConstants"%>

<%@ include file="../../../include/EnvironmentSetup.jsp"%>

<%
request.setAttribute("pageName", "ChangePasswordForm");

String strLogonID= null;
String strErrorCode = null;
String strErrorMessage = null;

// Get users logon ID
strLogonID=jhelper.getParameter(ECUserConstants.EC_UREG_LOGONID);

// If there is an error, it is passed in through the URL.  Look for error code.
strErrorCode = jhelper.getParameter(ECConstants.EC_ERROR_CODE);

if (strErrorCode != null)
{
	//There is an error in the form submission.
		
	if (strErrorCode.equals(ECSecurityConstants.ERR_MISSING_NEWPASSWORD))
		strErrorMessage = storeText.getString("CHANGEPWD_ERROR_MissingNewPassword");
	else if (strErrorCode.equals(ECSecurityConstants.ERR_MISSING_NEWPASSWORDVERIFY))
		strErrorMessage = storeText.getString("CHANGEPWD_ERROR_MissingVerifyPassword");
	else if (strErrorCode.equals(ECSecurityConstants.ERR_MISSING_PASSWORD))
		strErrorMessage = storeText.getString("CHANGEPWD_ERROR_MissingPassword");
	else if (strErrorCode.equals(ECSecurityConstants.ERR_MISSING_OLDPASSWORD))
		strErrorMessage = storeText.getString("CHANGEPWD_ERROR_MissingOldPassword");
		
	else if (strErrorCode.equals(ECSecurityConstants.ERR_INVALID_OLDPASSWORD))
		strErrorMessage = storeText.getString("CHANGEPWD_ERROR_InvalidOldPassword");
	else if (strErrorCode.equals(ECSecurityConstants.ERR_MISMATCH_PASSWORDS))
		strErrorMessage = storeText.getString("CHANGEPWD_ERROR_MismatchPasswords");

	else if (strErrorCode.equals(ECSecurityConstants.ERR_MINIMUMLENGTH_PASSWORD))
		strErrorMessage = storeText.getString("Reg_ERROR_PasswordMinLength");		
	else if (strErrorCode.equals(ECSecurityConstants.ERR_MINIMUMDIGITS_PASSWORD))
		strErrorMessage = storeText.getString("Reg_ERROR_PasswordMinDigits");	
	else if (strErrorCode.equals(ECSecurityConstants.ERR_MINIMUMLETTERS_PASSWORD))
		strErrorMessage = storeText.getString("Reg_ERROR_PasswordMinLetters");	
	else if (strErrorCode.equals(ECSecurityConstants.ERR_USERIDMATCH_PASSWORD))
		strErrorMessage = storeText.getString("Reg_ERROR_PasswordUserIdPasswordMatch");	
	else if (strErrorCode.equals(ECSecurityConstants.ERR_REUSEOLD_PASSWORD))
		strErrorMessage = storeText.getString("Reg_ERROR_PasswordReUsed");	
	else if (strErrorCode.equals(ECSecurityConstants.ERR_MAXCONSECUTIVECHAR_PASSWORD))
		strErrorMessage = storeText.getString("Reg_ERROR_PasswordMaxConsecutiveLength");	
	else if (strErrorCode.equals(ECSecurityConstants.ERR_MAXINTANCECHAR_PASSWORD))
		strErrorMessage = storeText.getString("Reg_ERROR_PasswordMaxInstanceChar");
	else
		strErrorMessage = storeText.getString("GenericError_Text1");

}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">

	<head>
		<title><%=storeText.getString("CHANGEPWD_TITLE")%></title>
		<link rel="stylesheet" href="<%=fileDir%>PCDMarket.css" type="text/css" />
		<meta name="GENERATOR" content="IBM WebSphere Studio" />
	</head>

	<body marginheight="0" marginwidth="0" leftmargin="0" topmargin="0">
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
		
		<%@ include file="../../../include/HeaderDisplay.jspf"%>
		
		<table border="0" cellpadding="0" cellspacing="0" width="750">
			<tbody><tr>
				<td valign="top" class="dbg" width="150">
					<%
     					String incfile = includeDir + "SidebarDisplay.jsp";
     					%><jsp:include page="<%=incfile%>" flush="true"></jsp:include>
     				</td>
				<td width="10"><spacer type="horizontal" size="10" /><br />
				</td>
				<td valign="top"><a name="mainContent"></a>
					<table width="590" border="0" cellspacing="0" cellpadding="0" border="0">
						<tbody><tr valign="top">
							<td><!-- ===========================  CONTENT AREA ======================== -->
								<form name="ChangeResetPassword" method="post" action="ResetPassword">
									<input type="hidden" name="storeId" value="<%=storeId%>" /> <input type="hidden" name="catalogId" value="<%=catalogId%>" /> <input type="hidden" name="langId" value="<%=languageId%>" /> <input type="hidden" name="<%=ECConstants.EC_URL%>" value="LogonForm?page=account" /> <input type="hidden" name="<%=ECUserConstants.EC_UREG_LOGONID%>" value="<%= strLogonID%>" /> <input type="hidden" name="<%=ECUserConstants.EC_RELOGIN_URL %>" value="ChangePassword" />
									<img src="<%=fileDir%>images/c.gif" height="16" width="16" />
									<table border="0" cellpadding="0" cellspacing="0" width="100%">
										<tbody><tr>
											<td valign="top"><img src="<%=fileDir%>images/c.gif" height="11" width="11" /><br />
												<span class="title"><%=storeText.getString("CHANGEPWD_TITLE")%></span>
											</td>
											<td valign="top"><div align="right">
													<img src="<%=fileDir%>images/hdr_account.gif" alt='<%=storeText.getString("CHANGEPWD_TITLE")%>' /></div>
											</td>
										</tr>
									</tbody></table>
									<%
							     		if (strErrorMessage != null) {
							     			//Display error messages. 
							     			%><span class="error"><%=strErrorMessage%></span><br />
										<br />
									<%			
									}			
									%>
									<table border="0" cellpadding="2" cellspacing="0">
										<tbody><tr>
											<td><b><label for="changepasswordtext"><%=storeText.getString("CHANGEPWD_GeneratedPassword")%></label></b></td>
											<td></td>
										</tr>
										<tr>
											<td><input type="password" name="<%=ECUserConstants.EC_UREG_LOGONPASSWORDOLD%>" id="changepasswordtext" size="15" class="iform" maxlength="25" /></td>
											<td></td>
										</tr>
										<tr>
											<td><b><label for="newpasswordtext"><%=storeText.getString("CHANGEPWD_NewPassword")%></label></b></td>
											<td></td>
										</tr>
										<tr>
											<td><input type="password" name="<%=ECUserConstants.EC_UREG_LOGONPASSWORD%>" id="newpasswordtext" size="15" class="iform" maxlength="25" /></td>
											<td></td>
										</tr>
										<tr>
											<td><b><label for="pwdverifytext"><%=storeText.getString("CHANGEPWD_VerifyPassword")%></label></b></td>
											<td></td>
										</tr>
										<tr>
											<td><input type="password" name="<%=ECUserConstants.EC_UREG_LOGONPASSWORDVERIFY%>" id="pwdverifytext" size="15" class="iform" maxlength="25" /></td>
											<td></td>
										</tr>
										<tr>
											<td align="left" valign="top" height="24"><spacer type="block" width="24" height="24" /></td>
											<td align="left" valign="top" height="24"></td>
										</tr>
										<tr>
											<td colspan="2" align="left" valign="top">
												<a href="#" onclick="javascript:prepareSubmit(document.ChangeResetPassword);return false;"><img src="<%=fileDir%><%=locale.toString()%>/images/submit.gif" alt="Submit" border="0" /></a></td>
										</tr>
									</tbody></table>
								</form>
							</td>
						</tr>
					</tbody></table>
				</td>
			</tr>
		</tbody></table>
		<%@ include file="../../../include/FooterDisplay.jspf"%>
	</body>

</html>