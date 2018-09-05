<%--==========================================================================
Licensed Materials - Property of IBM

WebSphere Commerce

(c) Copyright IBM Corp.  2006
All Rights Reserved

US Government Users Restricted Rights - Use, duplication or
disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
===========================================================================--%>
<%-- 
  *****
  * The JSP is called everytime there is need for a password protected command
  * to be executed.
  * This JSP page displays fields for customer to re-enter their passwords.
  *****
--%>

<%@ page import="java.util.Locale" %>
<%@ page import="java.util.ResourceBundle" %>
<%@ page import="com.ibm.commerce.server.ECConstants" %>
<%@ page import="com.ibm.commerce.command.CommandContext" %>

<%@ include file="../../../include/EnvironmentSetup.jsp"%>

<%
request.setAttribute("pageName", "PasswordReEnterForm");

String strErrorCode = jhelper.getParameter(ECConstants.EC_PASSWORD_REREQUEST_MSGCODE);
String strURL = jhelper.getParameter(ECConstants.EC_PASSWORD_REREQUEST_URL);

String strErrorMessage = null;

// If there is an error, it is passed in through the URL.  Look for message code.
if (strErrorCode != null && strErrorCode.length() > 0)
{
	//There is an error in the form submission.
		
	if (strErrorCode.equals("1")) {
		strErrorMessage = storeText.getString("PWDREENTER_DO_NOT_MATCH");
	} else if (strErrorCode.equals("2")) {
		strErrorMessage = storeText.getString("PWDREENTER_MISSING_PARAMETERS");
	} else if (strErrorCode.equals("3")) {
		strErrorMessage = storeText.getString("PWDREENTER_INCORRECT_PASSWORD");
	}
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">

	<head>
		<title><%=storeText.getString("PWDREENTER_TITLE")%></title>
		<link rel="stylesheet" href="<%=fileDir%>PCDMarket.css" type="text/css" />
		<meta name="GENERATOR" content="IBM WebSphere Studio" />
	</head>

	<body marginheight="0" marginwidth="0" leftmargin="0" topmargin="0">
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
								<form name="PasswordReEnterForm" method="post" action="PasswordRequest">
									<input type="hidden" name="storeId" value="<%=storeId%>" /> 
									<input type="hidden" name="catalogId" value="<%=catalogId%>" /> 
									<input type="hidden" name="langId" value="<%=languageId%>" /> 
									<input type="hidden" name="<%=ECConstants.EC_PASSWORD_REREQUEST_URL%>" value="<%= strURL %>" /> 
									
									<img src="<%=fileDir%>images/c.gif" height="16" width="16" />
									<table border="0" cellpadding="0" cellspacing="0" width="100%">
										<tbody><tr>
											<td valign="top"><img src="<%=fileDir%>images/c.gif" height="11" width="11" /><br />
												<span class="title"><%=storeText.getString("PWDREENTER_TITLE")%></span>
											</td>
											<td valign="top"><div align="right">
													<img src="<%=fileDir%>images/hdr_account.gif" alt='<%=storeText.getString("PWDREENTER_TITLE")%>' /></div>
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
										<tbody>
										<tr>
											<td><%=storeText.getString("PWDREENTER_DESCRIPTION")%></td>
											<td></td>
										</tr>
										<tr>
											<td><b><label for="newpasswordtext"><%=storeText.getString("PWDREENTER_PASSWORD")%></label></b></td>
											<td></td>
										</tr>
										<tr>
											<td><input type="password" name="<%=ECConstants.EC_PASSWORD_REREQUEST_PASSWORD1%>" id="newpasswordtext" size="15" class="iform" maxlength="25" /></td>
											<td></td>
										</tr>
										<tr>
											<td><b><label for="pwdverifytext"><%=storeText.getString("PWDREENTER_PASSWORD_VERIFY")%></label></b></td>
											<td></td>
										</tr>
										<tr>
											<td><input type="password" name="<%=ECConstants.EC_PASSWORD_REREQUEST_PASSWORD2%>" id="pwdverifytext" size="15" class="iform" maxlength="25" /></td>
											<td></td>
										</tr>
										<tr>
											<td align="left" valign="top" height="24"><spacer type="block" width="24" height="24" /></td>
											<td align="left" valign="top" height="24"></td>
										</tr>
										<tr>
											<td colspan="2" align="left" valign="top">
												<a href="#" onclick="javascript:document.PasswordReEnterForm.submit()"><img src="<%=fileDir%><%=locale.toString()%>/images/submit.gif" alt="Submit" border="0" /></a></td>
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