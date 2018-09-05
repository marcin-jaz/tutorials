<%
//********************************************************************
//*-------------------------------------------------------------------
//* Licensed Materials - Property of IBM
//*
//* WebSphere Commerce
//*
//* (c) Copyright IBM Corp. 2001, 2002
//*
//* US Government Users Restricted Rights - Use, duplication or
//* disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
//*
//*-------------------------------------------------------------------
//*
%>


<% // All JSPs requires these packages for EnvironmentSetup.jsp which is used for multi language support %> 
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.ibm.commerce.server.ECConstants" %>
<%@ page import="com.ibm.commerce.server.JSPHelper" %>
<%@ page import="com.ibm.commerce.server.JSPResourceBundle" %>
<%@ page import="com.ibm.commerce.command.CommandContext" %>

<% // Page specific imports%> 
<%@ page import="com.ibm.commerce.beans.DataBeanManager" %>
<%@ page import="com.ibm.commerce.usermanagement.commands.ECUserConstants" %>
<%@ page import="com.ibm.commerce.security.commands.ECSecurityConstants"%>

<%@ include file="../../../include/EnvironmentSetup.jspf"%>

<%

// JSPHelper provides you with a easy way to retrieve URL parameters when they are encrypted
JSPHelper jhelper = new JSPHelper(request);
String storeId = jhelper.getParameter("storeId");
String catalogId = jhelper.getParameter("catalogId");
String languageId = jhelper.getParameter("langId");


String strLogonID= null;
String strErrorCode = null;
String strErrorMessage = null;

strLogonID=jhelper.getParameter(ECUserConstants.EC_UREG_LOGONID).trim();

// If there is an error, it is passed in through the URL.  Look for error code.
strErrorCode = jhelper.getParameter(ECConstants.EC_ERROR_CODE);


if (strErrorCode != null)
{
	//There is an error in the form submission.
		
	if (strErrorCode.equals(ECSecurityConstants.ERR_MISSING_NEWPASSWORD))
		strErrorMessage = tooltechtext.getString("CHANGEPWD_ERROR_MissingNewPassword");
	else if (strErrorCode.equals(ECSecurityConstants.ERR_MISSING_NEWPASSWORDVERIFY))
		strErrorMessage = tooltechtext.getString("CHANGEPWD_ERROR_MissingVerifyPassword");
	else if (strErrorCode.equals(ECSecurityConstants.ERR_MISSING_PASSWORD))
		strErrorMessage = tooltechtext.getString("CHANGEPWD_ERROR_MissingPassword");
	else if (strErrorCode.equals(ECSecurityConstants.ERR_MISSING_OLDPASSWORD))
		strErrorMessage = tooltechtext.getString("CHANGEPWD_ERROR_MissingOldPassword");
		
	else if (strErrorCode.equals(ECSecurityConstants.ERR_INVALID_OLDPASSWORD))
		strErrorMessage = tooltechtext.getString("CHANGEPWD_ERROR_InvalidOldPassword");
	else if (strErrorCode.equals(ECSecurityConstants.ERR_MISMATCH_PASSWORDS))
		strErrorMessage = tooltechtext.getString("CHANGEPWD_ERROR_MismatchPasswords");

	else if (strErrorCode.equals(ECSecurityConstants.ERR_MINIMUMLENGTH_PASSWORD))
		strErrorMessage = tooltechtext.getString("Reg_ERROR_PasswordMinLength");		
	else if (strErrorCode.equals(ECSecurityConstants.ERR_MINIMUMDIGITS_PASSWORD))
		strErrorMessage = tooltechtext.getString("Reg_ERROR_PasswordMinDigits");	
	else if (strErrorCode.equals(ECSecurityConstants.ERR_MINIMUMLETTERS_PASSWORD))
		strErrorMessage = tooltechtext.getString("Reg_ERROR_PasswordMinLetters");	
	else if (strErrorCode.equals(ECSecurityConstants.ERR_USERIDMATCH_PASSWORD))
		strErrorMessage = tooltechtext.getString("Reg_ERROR_PasswordUserIdPasswordMatch");	
	else if (strErrorCode.equals(ECSecurityConstants.ERR_REUSEOLD_PASSWORD))
		strErrorMessage = tooltechtext.getString("Reg_ERROR_PasswordReUsed");	
	else if (strErrorCode.equals(ECSecurityConstants.ERR_MAXCONSECUTIVECHAR_PASSWORD))
		strErrorMessage = tooltechtext.getString("Reg_ERROR_PasswordMaxConsecutiveLength");	
	else if (strErrorCode.equals(ECSecurityConstants.ERR_MAXINTANCECHAR_PASSWORD))
		strErrorMessage = tooltechtext.getString("Reg_ERROR_PasswordMaxInstanceChar");
	else
		strErrorMessage = tooltechtext.getString("GenericError_Text1");

}
%>

<?xml version="1.0"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "DTD/xhtml1-transitional.dtd">
<html>
<HEAD>
	<TITLE><%=tooltechtext.getString("CHANGEPWD_TITLE")%></TITLE>
	<LINK REL=stylesheet HREF="<%=fileDir%>ToolTech.css" TYPE="text/css">
</HEAD>


<body marginheight="0" marginwidth="0" leftmargin="0" topmargin="0">

<flow:ifEnabled feature="customerCare">
<%
// Set header type needed for this JSP for LiveHelp.  This must
// be set before HeaderDisplay.jsp
request.setAttribute("liveHelpPageType", "personal");
%>
</flow:ifEnabled>

<%
String incfile;
incfile = includeDir + "HeaderDisplay.jsp";
%>
<jsp:include page="<%=incfile%>" flush="true"/>


<table border="0" cellpadding="0" cellspacing="0" width="790" height="99%">
<tr>
	<td valign="top" bgcolor="#4c6178" width="160"> 

		<%
		incfile = includeDir + "SidebarDisplay.jsp";
		%>
		<jsp:include page="<%=incfile%>" flush="true"/> 

	</td>

	<td align="center" valign="top" width="630">
	
<FORM name="ChangeResetPassword" method="POST" action="ResetPassword">
	<INPUT TYPE="hidden" NAME="storeId" Value="<%=storeId%>">
	<INPUT TYPE="hidden" NAME="catalogId" Value="<%=catalogId%>">
	<INPUT TYPE="hidden" NAME="langId" Value="<%=languageId%>">
	<INPUT TYPE="hidden" NAME="<%=ECConstants.EC_URL%>" VALUE="LogonForm?page=account">
	<INPUT TYPE="hidden" NAME="<%=ECUserConstants.EC_UREG_LOGONID%>" VALUE="<%= strLogonID%>">
	<INPUT TYPE="hidden" NAME="<%=ECUserConstants.EC_RELOGIN_URL %>" VALUE="ChangePassword">
	<INPUT TYPE="hidden" NAME="Relogon" VALUE="Update">

<TABLE BORDER="0" WIDTH="446">
	<TR>
		<TD COLSPAN="3">
			<TABLE BORDER="0" CELLSPACING="0" CELLPADDING"5">
				<TR>
					<TD><IMG SRC="<%=jspStoreImgDir%>images/plus.gif" WIDTH="31" HEIGHT="26" BORDER="0" ALT=""></TD>
					<TD><FONT FACE="Verdana" STYLE="font-size : 17pt"><%=tooltechtext.getString("CHANGEPWD_TITLE")%></FONT>&nbsp;&nbsp;&nbsp;</TD>
				</TR>
			</TABLE>
			<BR>
		</TD>
	</TR>
	
	<TR>		
		<TD><label for="<%=ECUserConstants.EC_UREG_LOGONPASSWORDOLD%>"><%=tooltechtext.getString("CHANGEPWD_GeneratedPassword")%></label></TD>		
		<TD><INPUT TYPE="password" NAME="<%=ECUserConstants.EC_UREG_LOGONPASSWORDOLD%>" id="<%=ECUserConstants.EC_UREG_LOGONPASSWORDOLD%>" SIZE="13"></TD>		
		<TD>&nbsp;</TD>
	</TR>

	<TR>		
		<TD><label for="<%=ECUserConstants.EC_UREG_LOGONPASSWORD%>"><%=tooltechtext.getString("CHANGEPWD_NewPassword")%></label></TD>		
		<TD><INPUT TYPE="password" NAME="<%=ECUserConstants.EC_UREG_LOGONPASSWORD%>" id="<%=ECUserConstants.EC_UREG_LOGONPASSWORD%>" SIZE="13"></TD>		
		<TD>&nbsp;</TD>
	</TR>
	
	<TR>		
		<TD><label for="<%=ECUserConstants.EC_UREG_LOGONPASSWORDVERIFY%>"><%=tooltechtext.getString("CHANGEPWD_VerifyPassword")%></label></TD>		
		<TD><INPUT TYPE="password" NAME="<%=ECUserConstants.EC_UREG_LOGONPASSWORDVERIFY%>" id="<%=ECUserConstants.EC_UREG_LOGONPASSWORDVERIFY%>" SIZE="13"></TD>		

		<TD>
			<!-- DISPLAY BUTTON TO SUBMIT PASSWORD CHANGE -->
						<table cellpadding="0" cellspacing="0" border="0">
			<tr>
				<td bgcolor="#ff2d2d" class="pixel"><img src="<%=jspStoreImgDir%>images/lb.gif" border="0"/></td>
				<td bgcolor="#ff2d2d" class="pixel"><img src="<%=jspStoreImgDir%>images/lb.gif" border="0"/></td>
				<td class="pixel"><img src="<%=jspStoreImgDir%>images/r_top.gif" border="0"/></td>
			</tr>
			<tr>
				<td bgcolor="#ff2d2d"><img alt="" src="<%=jspStoreImgDir%>images/lb.gif" border="0"/></td>
				<td bgcolor="#ea2b2b">
					<table cellpadding="2" cellspacing="0" border="0">
					<tr>
						<td class="buttontext">
							<font color="#ffffff"><b>
							<a href="javascript:document.ChangeResetPassword.submit()" style="color:#ffffff; text-decoration : none;">
							<%=tooltechtext.getString("CHANGEPWD_Submit")%>
							</a>
							</b></font>
						</td>
					</tr>
					</table>
				</td>
				<td bgcolor="#7a1616"><img alt="" src="<%=jspStoreImgDir%>images/db.gif" border="0"/></td>			<tr>
				<td class="pixel"><img src="<%=jspStoreImgDir%>images/l_bot.gif"/></td>
				<td bgcolor="#7a1616" class="pixel" valign="top"><img src="<%=jspStoreImgDir%>images/db.gif" border="0"/></td>
				<td bgcolor="#7a1616" class="pixel" valign="top"><img src="<%=jspStoreImgDir%>images/db.gif" border="0"/></td>
			</tr>
			</table>
		</TD>	
	</TR>
</TABLE>	


<!-- DISPLAY ERROR MESSAGES -->

<TABLE BORDER="0" WIDTH="446">
			
	<TR>
		<TD ALIGN="left">
			<BR>

			<% 

			if (strErrorMessage != null)
				{
				%>
				<FONT COLOR="red">
					<%=strErrorMessage%>
				</FONT>
				<%
				}	
				%>
		</td>	
	</tr>
	
</table>

</form>
		
	</td>
</tr>
</table>


</body>
</html>
