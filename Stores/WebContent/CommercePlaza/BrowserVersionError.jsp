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
<%@ page import="java.text.MessageFormat" %>
<%@ page import="java.util.ResourceBundle" %>

<%@ page import="com.ibm.commerce.server.JSPHelper" %>
<%@ page import="com.ibm.commerce.server.ECConstants" %>
<%@ page import="com.ibm.commerce.ras.ECMessageHelper" %>
<%@ page import="com.ibm.commerce.command.CommandContext" %>


<%@ include file="include/EnvironmentSetup.jsp"%>

<%
String actionName = jhelper.getParameter("actionName");

//  Highlight the correct selection on the sidebar
if (actionName != null && actionName.equals("createstore"))
{
	request.setAttribute("pageName", "RequestHostedStore");
}else if (actionName != null && actionName.equals("managestore"))
{
	request.setAttribute("pageName", "adminConsole");
}else if (actionName != null && actionName.equals("organization"))
{
	request.setAttribute("pageName", "MyOrganization");
}
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">

	<head>
		<title><%=storeText.getString("OrgApproval_Title1")%></title>
		<link rel="stylesheet" href="<%=fileDir%>PCDMarket.css" type="text/css" />
		<meta name="GENERATOR" content="IBM WebSphere Studio" />
	</head>

	<body marginheight="0" marginwidth="0" leftmargin="0" topmargin="0">
		<%@ include file="include/HeaderDisplay.jspf"%>
		
		<table border="0" cellpadding="0" cellspacing="0" width="750">
			<tbody><tr>
				<td valign="top" class="dbg" width="150">
					<%
     					String incfile = includeDir + "SidebarDisplay.jsp";
     					%><jsp:include page="<%=incfile%>" flush="true"></jsp:include>
     				</td>
				<td width="10"><a name="mainContent"></a><spacer type="horizontal" size="10" /><br />
				</td>
				<td valign="top">
					<table width="590" border="0" cellspacing="0" cellpadding="0" border="0">
						<tbody><tr valign="top">
							<td><!-- ===========================  CONTENT AREA ======================== -->
								<img src="<%=fileDir%>images/c.gif" height="20" width="20" />
								<table border="0" cellpadding="0" cellspacing="0" width="100%">
									<tbody><tr valign="top">
										<td valign="top">
												<div align="left">
													<img src="<%=fileDir%>images/c.gif" height="11" width="11" /><br />
													<span class="title"><%=storeText.getString("BrowserVerError_Title")%></span></div>
											</td>
											<td>
												<div align="right">
												<img src="<%=fileDir%>images/hdr_account.gif" alt='<%=storeText.getString("BrowserVerError_Title")%>' /></div>
											</td>
									</tr>
								</tbody></table>
								<table width="100%" border="0">
									<tbody><tr>
										<td class="bodytxt1" colspan="2" align="left" valign="bottom">
											<%= storeText.getString("BrowserVerError_Text1", new Object[] {"<a href=\"http://www.microsoft.com/downloads\" target=\"_blank\">www.microsoft.com/downloads</a>"}) %><br /><br />
										</td>
									</tr>
									<tr>
										<td colspan="2">&nbsp;</td>
									</tr>
								</tbody></table>
								<br />
								<br />
								<br />
								<br />
								<br />
								<!-- ===========================  END CONTENT AREA ======================== -->
							</td>
						</tr>
					</tbody></table>
				</td>
			</tr>
		</tbody></table>
		<%@ include file="include/FooterDisplay.jspf"%>
	</body>

</html>