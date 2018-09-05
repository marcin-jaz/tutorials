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


<% // All JSPs requires these packages for getResource.jsp which is used for multi language support %> 
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.ibm.commerce.server.ECConstants" %>
<%@ page import="com.ibm.commerce.server.JSPHelper" %>
<%@ page import="com.ibm.commerce.server.JSPResourceBundle" %>
<%@ page import="com.ibm.commerce.command.CommandContext" %>

<% // Page specific imports%> 
<%@ page import="com.ibm.commerce.beans.DataBeanManager" %>
<%@ page import="com.ibm.commerce.beans.ErrorDataBean" %>
<%@ page import="com.ibm.commerce.datatype.TypedProperty" %>
<%@ page import="com.ibm.commerce.security.commands.ECSecurityConstants" %>    
<%@ page import="com.ibm.commerce.usermanagement.commands.ECUserConstants" %>

<%@ include file="../../../include/EnvironmentSetup.jspf"%>

<jsp:useBean id="bnError" class="com.ibm.commerce.beans.ErrorDataBean" scope="page">
<% com.ibm.commerce.beans.DataBeanManager.activate(bnError, request); %>
</jsp:useBean>

<%
//Parameters may be encrypted. Use JSPHelper to get URL parameter instead of request.getParameter().
JSPHelper jhelper = new JSPHelper(request);

String catalogId = jhelper.getParameter("catalogId");
String storeId = jhelper.getParameter("storeId");
String languageId = jhelper.getParameter("langId");
String email = jhelper.getParameter(ECUserConstants.EC_UREG_LOGONID);
String strAnswer = "";
String strLogonId = "";

String strErrorMessage = null;
TypedProperty hshErrorProperties = bnError.getExceptionData();

if (hshErrorProperties != null)
{
   String strErrorCode = hshErrorProperties.getString(ECConstants.EC_ERROR_CODE, "");

	if ( strErrorCode.equals(ECSecurityConstants.ERR_MISSING_LOGONID) )
		strErrorMessage=tooltechtext.getString("Forpass_ERROR1");
	else if ( strErrorCode.equals(ECSecurityConstants.ERR_INVALID_LOGONID) ) 
		strErrorMessage=tooltechtext.getString("Forpass_ERROR2");
	else if ( strErrorCode.equals(ECSecurityConstants.ERR_MISSING_EMAIL) )
		strErrorMessage=tooltechtext.getString("Forpass_ERROR3");
	else if ( strErrorCode.equals(ECSecurityConstants.ERR_DISABLED_ACCOUNT) )
		strErrorMessage=tooltechtext.getString("Forpass_ERROR_RejectedLogonID");
	else if ( strErrorCode.equals(ECSecurityConstants.ERR_INVALID_CHALLENGEANSWER))
		strErrorMessage=tooltechtext.getString("Forpass_ERROR_UnknownError");
	else
		strErrorMessage=tooltechtext.getString("Forpass_ERROR_UnknownError");			
	strAnswer = jhelper.htmlTextEncoder(jhelper.getParameter(ECUserConstants.EC_UREG_CHALLENGEANSWER));
	strLogonId = jhelper.htmlTextEncoder(jhelper.getParameter(ECUserConstants.EC_UREG_LOGONID));
}

String state = request.getParameter("state");

if (state == null)
{
	String [] arrstate = (String []) request.getAttribute("state");
	if (arrstate != null) 
		state = arrstate[0];
}

%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "DTD/xhtml1-transitional.dtd">
<html>
<HEAD>
	<TITLE><%=tooltechtext.getString("Forpass_Title")%></TITLE>
	<LINK REL=stylesheet HREF="<%=fileDir%>ToolTech.css" TYPE="text/css">
</HEAD>

<%
String _param1 = tooltechtext.getString("Forpass_UserID");
String _param2 = tooltechtext.getString("Reg_ChallengeAnswer");
String _msg1 = tooltechtext.getString("OrderSum_Err_RequiredField" , _param1);
String _msg2 = tooltechtext.getString("OrderSum_Err_RequiredField" , _param2);
%>
<script language="javascript">
	function submitForm(form) {
		if(form.<%=ECUserConstants.EC_UREG_LOGONID%>.value == null || form.<%=ECUserConstants.EC_UREG_LOGONID%>.value == ""){
			alert('<%=_msg1%>');
			return;
		}else if(form.<%=ECUserConstants.EC_UREG_CHALLENGEANSWER%>.value == null || form.<%=ECUserConstants.EC_UREG_CHALLENGEANSWER%>.value == "") {
			alert('<%=_msg2%>');
			return;
		}
		form.submit();
	}
</script>
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

<!--MAIN CONTENT STARTS HERE-->

<FORM NAME="ResetPasswordForm" METHOD="post" action="ResetPassword">
	<INPUT TYPE="hidden" NAME="storeId" VALUE="<%=storeId %>"> 
	<INPUT TYPE="hidden" NAME="catalogId" VALUE="<%=catalogId %>"> 
	<INPUT TYPE="hidden" NAME="langId" VALUE="<%=languageId %>">
	<INPUT TYPE="hidden" NAME="state" VALUE="passwdconfirm"> 
	<INPUT TYPE="hidden" NAME="URL" VALUE="ResetPasswordForm">


<table cellpadding="8" width="450">

<tr> 
	<td>
		<FONT STYLE="font-family : Verdana; font-size : 17pt"><%=tooltechtext.getString("Forpass_Title")%></FONT>
		<BR><BR><P>
		<%=tooltechtext.getString("Forpass_Text1")%>
		<BR><BR>
		<%=tooltechtext.getString("Forpass_Text2")%>
		<p> 
	</td>
</tr>

<tr align="left"> 
	<td> 
		<table border="0" cellpadding="0" cellspacing="10">
		<tr>
			<td><span class="reqd">*</span><label for="WC_PasswordResetForm_FormInput_<%= ECUserConstants.EC_UREG_LOGONID %>_1"><%=tooltechtext.getString("Forpass_UserID")%></label>&nbsp;&nbsp;</td>
			<td>
				<input type="text" name="<%= ECUserConstants.EC_UREG_LOGONID %>" value="<%=strLogonId%>"size="25" id="WC_PasswordResetForm_FormInput_<%= ECUserConstants.EC_UREG_LOGONID %>_1">
			</td>
		</tr>
		<tr>
			
			<td ><span class="reqd">*</span><label for="WC_PasswordResetForm_FormInput_<%= ECUserConstants.EC_UREG_CHALLENGEANSWER %>_1"><%=tooltechtext.getString("Reg_ChallengeAnswer")%></label></td>
			<td>
				<input type="text" name="<%= ECUserConstants.EC_UREG_CHALLENGEANSWER %>"  value="<%=strAnswer%>" maxlength="40" size="25" id="WC_PasswordResetForm_FormInput_<%= ECUserConstants.EC_UREG_CHALLENGEANSWER %>_1"/>
			</td>
		</tr>
		<tr> 
			<td>&nbsp;&nbsp;</td>
			<td> 
				<table cellpadding="0" cellspacing="0" border="0">
				<tr>
					<td bgcolor="#ff2d2d" class="pixel"><img src="<%=jspStoreImgDir%>images/lb.gif" border="0" alt=""/></td>
					<td bgcolor="#ff2d2d" class="pixel"><img src="<%=jspStoreImgDir%>images/lb.gif" border="0" alt=""/></td>
					<td class="pixel"><img src="<%=jspStoreImgDir%>images/r_top.gif" border="0" alt=""/></td>
				</tr>
				<tr>
					<td bgcolor="#ff2d2d"><img alt="" src="<%=jspStoreImgDir%>images/lb.gif" border="0"/></td>
					<td bgcolor="#ea2b2b">
						<table cellpadding="2" cellspacing="0" border="0">
						<tr>
							<td class="buttontext">
								<font color="#ffffff"><b>
											<a href="javascript:submitForm(document.ResetPasswordForm)" STYLE="color:#ffffff; text-decoration : none;">
								<%=tooltechtext.getString("Forpass_link1")%>
								</a>
								</b></font>
							</td>
						</tr>
						</table>
					</td>
					<td bgcolor="#7a1616"><img alt="" src="<%=jspStoreImgDir%>images/db.gif" border="0"/></td>
				</tr>	
				<tr>
					<td class="pixel"><img src="<%=jspStoreImgDir%>images/l_bot.gif" alt=""/></td>
					<td bgcolor="#7a1616" class="pixel" valign="top"><img src="<%=jspStoreImgDir%>images/db.gif" border="0" alt=""/></td>
					<td bgcolor="#7a1616" class="pixel" valign="top"><img src="<%=jspStoreImgDir%>images/db.gif" border="0" alt=""/></td>
				</tr>
				</table>
			</td>
		</tr>

		<tr>
			<td colspan="4">
				<br>
				<%
				if (strErrorMessage != null) 
					{
					%><font color="red"><%= strErrorMessage%></font><%
					}
					%>
			</td>

		</tr>
			
		<tr>
			<td colspan="4" align="center">
				<br>
				<%
				if (state != null && state.equals("passwdconfirm") && strErrorMessage == null)
					{
					%>
					<font><b><%=tooltechtext.getString("Forpass1_Text1")%></b></font><br>
					<a href="LogonForm?langId=<%=languageId%>&storeId=<%=storeId%>&catalogId=<%=catalogId%>">
					<font class="strongtext"><%=tooltechtext.getString("Forpass1_Link1")%></font>
					</a>					
					<%
					}
					%>
			</td>
		
		</tr>
				
		</table>
	</td>
</tr>
</table>


</form>


	</td>
</tr>
</table>

</body>
</html>