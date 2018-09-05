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

<%@ page import="java.text.MessageFormat" %>
<%@ page import="com.ibm.commerce.ras.ECMessageHelper" %>

<%@ include file="../../../include/EnvironmentSetup.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">

	<head>
		<title><%=storeText.getString("OrgApproval_Title1")%></title>
		<link rel="stylesheet" href="<%=fileDir%>PCDMarket.css" type="text/css" />
		<meta name="GENERATOR" content="IBM WebSphere Studio" />
		<script>
		<!--
		var feedbackURL = "FeedbackFormView?storeId=<%=storeId%>";

		function FeedbackWindow(url) 
		{
		  var windowObject;
		  var name = "popup";
		  var width = 650;
		  var height = 475;
  
		  o = "width="+width+",height="+height+",resizable=1,status=0,left=0,top=0,menubar=0,scrollbars=1,toolbar=0,location=0,directories=0";
		  windowObject = window.open(url, name, "height=" + height + ",innerHeight=" + height + ",width=" + width + ",innerWidth=" + width + ",screenX=0,screenY=0,scrollbars=yes,resizable=yes");
		  windowObject.focus();
		}
		-->
		</script>
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
													<span class="title"><%=storeText.getString("OrgApproval_Title1")%></span></div>
											</td>
											<td>
												<div align="right">
												<img src="<%=fileDir%>images/hdr_account.gif" alt='<%=storeText.getString("OrgApproval_Title1")%>' /></div>
											</td>
									</tr>
								</tbody></table>
								<table width="100%" border="0">
									<tbody><tr>
										<td class="bodytxt1" colspan="2" align="left" valign="bottom">
											<%
											// Prepare an object for inserting a link into another string
											String linkString = "<a href='javascript:FeedbackWindow(feedbackURL)'>" + storeText.getString("Approval_Remark2") + "</a>";
											Object[] arguments = { linkString };
											%><%=MessageFormat.format(ECMessageHelper.doubleTheApostrophy(storeText.getString("Approval_Remark1")),arguments)%></td>
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
		<%@ include file="../../../include/FooterDisplay.jspf"%>
	</body>

</html>