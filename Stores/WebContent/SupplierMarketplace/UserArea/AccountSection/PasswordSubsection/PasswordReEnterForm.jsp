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

<%@ include file="../../../include/EnvironmentSetup.jspf"%>
<%@ include file="../../../include/CacheParametersSetup.jspf"%>

<%

// JSPHelper provides you with a easy way to retrieve URL parameters when they are encrypted
JSPHelper jhelper = new JSPHelper(request);
String storeId = jhelper.getParameter("storeId");
String catalogId = jhelper.getParameter("catalogId");
String languageId = jhelper.getParameter("langId");
String navState = "";
String inFrame  = "";

String strErrorCode = jhelper.getParameter(ECConstants.EC_PASSWORD_REREQUEST_MSGCODE);
String strURL = jhelper.getParameter(ECConstants.EC_PASSWORD_REREQUEST_URL);

String strErrorMessage = null;

// If there is an error, it is passed in through the URL.  Look for message code.
if (strErrorCode != null && strErrorCode.length() > 0)
{
	//There is an error in the form submission.
		
	if (strErrorCode.equals("1")) {
		strErrorMessage = tooltechtext.getString("PWDREENTER_DO_NOT_MATCH");
	} else if (strErrorCode.equals("2")) {
		strErrorMessage = tooltechtext.getString("PWDREENTER_MISSING_PARAMETERS");
	} else if (strErrorCode.equals("3")) {
		strErrorMessage = tooltechtext.getString("PWDREENTER_INCORRECT_PASSWORD");
	}
}
%>

<?xml version="1.0"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "DTD/xhtml1-transitional.dtd">
<html>
<head>
	<title><%=tooltechtext.getString("PWDREENTER_TITLE")%></title>
	<link rel=stylesheet href="<%=fileDir%>ToolTech.css" type="text/css">
</head>

<flow:ifEnabled feature="customerCare">
<%
// Set header type needed for this JSP for LiveHelp.  This must
// be set before HeaderDisplay.jsp
request.setAttribute("liveHelpPageType", "personal");
%>
</flow:ifEnabled>

<body marginheight="0" marginwidth="0" leftmargin="0" topmargin="0">
<%
    String incfile;
    incfile = includeDir + "CachedHeaderDisplay.jsp";
%>
    <jsp:include page="<%=incfile%>" flush="true">
        <jsp:param name="storeId" value="<%= storeId %>" />
        <jsp:param name="catalogId" value="<%= catalogId %>" />
        <jsp:param name="langId" value="<%= languageId %>" />
        <jsp:param name="userType" value="<%= userType %>" />
        <jsp:param name="userState" value="<%= userState %>" />
        <jsp:param name="rfqLinkDisplayed" value="<%= rfqLinkDisplayed %>" />
    </jsp:include>

    <table cellpadding="0" cellspacing="0" border="0" height="99%" width="790">
    <tr>
    	<td valign="top" bgcolor="#4c6178" width="160">
    		<%
    		incfile = includeDir + "CachedSidebarDisplay.jsp";
    		%>
            <jsp:include page="<%=incfile%>" flush="true">
                <jsp:param name="storeId"   value="<%= storeId %>" />
                <jsp:param name="langId"    value="<%= languageId %>" />
                <jsp:param name="inFrame"   value="<%= inFrame %>" />
                <jsp:param name="navState"  value="<%= navState %>" />
                <jsp:param name="userType"  value="<%= userType %>" />
                <jsp:param name="userState" value="<%= userState %>" />
                <jsp:param name="siteAdmin" value="<%= bSiteAdmin %>" />
                <jsp:param name="sellAdmin" value="<%= bSellerAdmin %>" />
                <jsp:param name="buyAdmin"  value="<%= bBuyerAdmin %>" />
                <jsp:param name="seller"    value="<%= bSeller %>" />
            </jsp:include>
    	</td>

    	<td valign="top" width="630">

<!--MAIN CONTENT STARTS HERE-->
<form name="PasswordReEnterForm" method="POST" action="PasswordRequest">
	<input type="hidden" name="storeId" Value="<%=storeId%>">
	<input type="hidden" name="catalogId" Value="<%=catalogId%>">
	<input type="hidden" name="langId" Value="<%=languageId%>">
	<input type="hidden" name="<%=ECConstants.EC_PASSWORD_REREQUEST_URL%>" VALUE="<%= strURL %>">

<table cellpadding="8" cellspacing="0" width="580" border="0" align="left">
	<tr>
		<td colspan="2">
			<h1><%=tooltechtext.getString("PWDREENTER_TITLE")%></h1>
		</td>
	</tr>
	<tr>		
		<td colspan="2"><%=tooltechtext.getString("PWDREENTER_DESCRIPTION")%></td>		
	</tr>
	<tr>
		<td>
			<table cellpadding="0" cellspacing="0" border="0">
			<tr>		
				<td><label for="<%=ECConstants.EC_PASSWORD_REREQUEST_PASSWORD1%>"><%=tooltechtext.getString("PWDREENTER_PASSWORD")%></label></td>		
				<td><input type="password" name="<%=ECConstants.EC_PASSWORD_REREQUEST_PASSWORD1%>" id="<%=ECConstants.EC_PASSWORD_REREQUEST_PASSWORD1%>" SIZE="13"></td>
			</tr>
			
			<tr>		
				<td><label for="<%=ECConstants.EC_PASSWORD_REREQUEST_PASSWORD2%>"><%=tooltechtext.getString("PWDREENTER_PASSWORD_VERIFY")%></label></td>		
				<td><input type="password" name="<%=ECConstants.EC_PASSWORD_REREQUEST_PASSWORD2%>" id="<%=ECConstants.EC_PASSWORD_REREQUEST_PASSWORD2%>" SIZE="13"></td>		
			</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td>
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
							<a href="javascript:document.PasswordReEnterForm.submit()" style="color:#ffffff; text-decoration : none;">
							<%=tooltechtext.getString("PWDREENTER_SUBMIT")%>
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
		</td>
		<td>&nbsp;</td>
	</tr>
</table>	


<!-- DISPLAY ERROR MESSAGES -->

<table border="0" width="100%">	
	<tr>
		<td align="left">
			<%
			if (strErrorMessage != null)
			{
			%>
				<font color="red">
					<%=strErrorMessage%>
				</font>
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
