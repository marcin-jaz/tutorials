<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2009 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>
<%-- 
  *****
  * This JSP is called whenever the current session has timed out.
  *****
--%>

<%@ include file="../../../include/EnvironmentSetup.jsp"%>
<% response.setContentType(storeText.getString("ENCODESTATEMENT")); %> 

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
	<head>
		<title><%=storeText.getString("USER_SESSION_TIMEOUT_TITLE")%></title>
		<link rel="stylesheet" href="<%=fileDir%>PCDMarket.css" type="text/css" />
	</head>

	<body marginheight="0" marginwidth="0" leftmargin="0" topmargin="0">
		<%@ include file="../../../include/HeaderDisplay.jspf"%>
		<!-- Start Main Table - Consists of TD for Left Bar and TD for Content -->
		<table border="0" cellpadding="0" cellspacing="0" width="750">
			<tbody>
				<tr>
					<td valign="top" class="dbg" width="150">
					</td>
					<!-- End  Left Nav Bar TD -->
					<td width="10"><spacer type="horizontal" size="10" /><br />
					</td>
					<!-- Begin Main Content TD -->
					<td valign="top" width="590">
						<table cellspacing="0" cellpadding="0" width="100%" border="0">
							<tbody>
								<tr>
									<td height="12" colspan="2"><spacer type="block" width="12" height="12" /></td>
								</tr>
								<tr>
									<td width="100%"><span class="title1"><%=storeText.getString("USER_SESSION_TIMEOUT_TITLE")%></span></td>
									<td></td>
								</tr>
								<tr>
									<td width="100%"><br />
										<%=storeText.getString("USER_SESSION_TIMEOUT_DETAILS")%><br />
									</td>
								</tr>
							</tbody>
						</table>
						<table cellspacing="0" cellpadding="0" width="95%" border="0">
							<tbody>
								<tr>
									<td height="12"><spacer type="block" width="12" height="12" /></td>
								</tr>
								<tr>
									<td><a href="LogonForm?langId=<%=languageId%>&storeId=<%=storeId%>"><b><%=storeText.getString("USER_SESSION_TIMEOUT_LOGIN")%></b></a></td>
								</tr>
								<tr>
									<td height="12"><spacer type="block" width="12" height="12" /></td>
								</tr>
							</tbody>
						</table>
					</td>
			</tr>
			</tbody>
		</table>
		<%@ include file="../../../include/FooterDisplay.jspf"%>
	</body>
</html>
