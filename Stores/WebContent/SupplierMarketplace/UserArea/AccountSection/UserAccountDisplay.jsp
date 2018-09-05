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
<%@ page import="com.ibm.commerce.user.beans.UserRegistrationDataBean" %>  

<%@ include file="../../include/EnvironmentSetup.jspf"%>

<%
CommandContext commandContext = (CommandContext) request.getAttribute(ECConstants.EC_COMMANDCONTEXT);

//Parameters may be encrypted. Use JSPHelper to get
//URL parameter instead of request.getParameter().
JSPHelper jhelper = new JSPHelper(request);

String storeId = jhelper.getParameter("storeId");
String catalogId = jhelper.getParameter("catalogId");
String languageId = jhelper.getParameter("langId");
String errorState = jhelper.getParameter("errorState");

String userState = cmdcontext.getUser().getState();

%>
<jsp:useBean id="bnRegister" class="com.ibm.commerce.user.beans.UserRegistrationDataBean" scope="page">
	<% com.ibm.commerce.beans.DataBeanManager.activate(bnRegister, request); %>
</jsp:useBean>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "DTD/xhtml1-transitional.dtd">
<html>
<HEAD>
	<TITLE><%=tooltechtext.getString("Account_Title")%></TITLE>
	<LINK REL=stylesheet HREF="<%=fileDir%>ToolTech.css" TYPE="text/css">
	<META NAME="FileName" CONTENT="UserArea/AccountSection/UserAccountDisplay.jsp">
</HEAD>


<BODY MARGINHEIGHT="0" MARGINWIDTH="0" LEFTMARGIN="0" TOPMARGIN="0" onLoad="if (typeof top.updateStInfo == 'function') top.updateStInfo();">
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


<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0" WIDTH="790" HEIGHT="99%">
<TR>
	<TD VALIGN="top" BGCOLOR="#4c6178" WIDTH="160"> 

		<%
		incfile = includeDir + "SidebarDisplay.jsp";
		%>
		<jsp:include page="<%=incfile%>" flush="true"/>

	</TD>

	<TD valign="top" width="630">


		<!--START MAIN CONTENT-->
		<TABLE CELLPADDING="8">
		<TR>
			<TD>
				<H1><%=tooltechtext.getString("Account_Title")%></H1>	
			</TD>
		</TR>
		
		<%
		if (userState.equals("0"))
			{
			
			if (!(errorState == null)){
				if (errorState.equals("approvalError"))
				{
				%>
				<TR>
					<TD>
						<b><%=tooltechtext.getString("OrderApproval_no_approver")%></B><P>
					</TD>
				</TR>
				<%
				}
			}
			%>		
			<TR>
				<TD>
					<B><%=tooltechtext.getString("AddBook_PendingState")%></B><P>
				</TD>
			</TR>
			
			<%
			}
			%>
			
		<%
		if (bnRegister.getProfileType().equals("C"))
			{
			%>
		
			<TR>
				<TD>
				<%=tooltechtext.getString("Account_Message_ProfileType")%><P>
				</TD>
			</TR>
			
			<%
			}
			%>			
			
		<TR>
			<TD>
				<b><%=tooltechtext.getString("Account_Heading1")%></b><P>
				<%=tooltechtext.getString("Account_Text1")%>
			</TD>
		</TR>			
		
		<TR>
			<TD>
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
								<a href="UserRegistrationForm?storeId=<%=storeId%>&langId=<%=languageId%>&catalogId=<%=catalogId%>" style="color:#ffffff; text-decoration : none;">
								&nbsp;<%=tooltechtext.getString("Account_Button1")%>&nbsp;
								</a>
								</b></font>
							</td>
						</tr>
						</table>
					</td>
					<td bgcolor="#7a1616"><img alt="" src="<%=jspStoreImgDir%>images/db.gif" border="0"/></td>
				</tr>	
				<tr>
					<td class="pixel"><img src="<%=jspStoreImgDir%>images/l_bot.gif"/></td>
					<td bgcolor="#7a1616" class="pixel" valign="top"><img src="<%=jspStoreImgDir%>images/db.gif" border="0"/></td>
					<td bgcolor="#7a1616" class="pixel" valign="top"><img src="<%=jspStoreImgDir%>images/db.gif" border="0"/></td>
				</tr>
				</table>
			</TD>
		</TR>
		<TR>
			<TD>
				<b><%=tooltechtext.getString("Account_Heading2")%></b>
				<P>
				<%=tooltechtext.getString("Account_Text2")%>
				</P>
			</TD>
		</TR>
		<TR>
			<TD>
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
								<a href="AddressBookForm?storeId=<%=storeId%>&langId=<%=languageId%>&catalogId=<%=catalogId%>" style="color:#ffffff; text-decoration : none;">
								&nbsp;<%=tooltechtext.getString("Account_Button2")%>&nbsp;
								</a>
								</b></font>
							</td>
						</tr>
						</table>
					</td>
					<td bgcolor="#7a1616"><img alt="" src="<%=jspStoreImgDir%>images/db.gif" border="0"/></td>
				</tr>	
				<tr>
					<td class="pixel"><img src="<%=jspStoreImgDir%>images/l_bot.gif"/></td>
					<td bgcolor="#7a1616" class="pixel" valign="top"><img src="<%=jspStoreImgDir%>images/db.gif" border="0"/></td>
					<td bgcolor="#7a1616" class="pixel" valign="top"><img src="<%=jspStoreImgDir%>images/db.gif" border="0"/></td>
				</tr>
				</table>
			</td>
		</TR>
		</TABLE>

	<!-- END CONTENT -->	
						

	</TD>
</TR>
</TABLE>

</BODY>

</HTML>


