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
  * This JSP displays error message when trying to execute some URL that is found to be
  * harmful to the server.
  *****
--%>

<%@ include file="include/EnvironmentSetup.jsp"%>
<% response.setContentType(storeText.getString("ENCODESTATEMENT")); %> 

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
	<head>
		<title><%=storeText.getString("PROHIBITEDCHAR_ERROR_TITLE")%></title>
		<link rel="stylesheet" href="<%=fileDir%>PCDMarket.css" type="text/css" />
	</head>

<body marginheight="0" marginwidth="0" leftmargin="0" topmargin="0">

<%@ include file="include/HeaderDisplay.jspf"%>

<!-- Start Main Table - Consists of TD for Left Bar, TD for Content and TD for Quicklinks -->
<table border="0" cellpadding="0" cellspacing="0" width="750">
  <tbody><tr>
    <td valign="top" class="dbg" width="150">
      <%
      String incfile = includeDir + "SidebarDisplay.jsp";
      %>
      <jsp:include page="<%=incfile%>" flush="true"/></td>
    <!-- End  Left Nav Bar TD -->

    <!-- Begin Main Content TD -->
    <td width="10"><a name="mainContent"></a><spacer type="horizontal" size="10"></spacer><br /></td>
    <td valign="top" width="590">

    <!--MAIN CONTENT STARTS HERE-->

		<!-- Start Main JSP Content -->
						<table cellspacing="0" cellpadding="0" width="100%" border="0">
							<tbody>
								<tr>
									<td height="12" colspan="2"><spacer type="block" width="12" height="12" /></td>
								</tr>
								<tr>
									<td width="100%"><span class="title1"><%=storeText.getString("PROHIBITEDCHAR_ERROR_TITLE")%></span></td>
									<td></td>
								</tr>
								<tr>
									<td width="100%"><br />
										<%=storeText.getString("PROHIBITEDCHAR_ERROR_DESC")%><br />
										<br />
									</td>
								</tr>
							</tbody>
							<tbody></tbody>
						</table>
						<table cellspacing="0" cellpadding="0" width="95%" border="0">
							<tbody>
								<tr>
									<td height="12"><spacer type="block" width="12" height="12" /></td>
								</tr>
								<tr>
									<td><a href="javascript:history.back(1)"><img alt='<%=storeText.getString("PROHIBITEDCHAR_ERROR_BACK")%>' src="<%=fileDir%><%=locale.toString()%>/images/continue.gif"  border="0" name="GoBack" /></a></td>
								</tr>
							</tbody>
						</table>
	<!-- End of Main Content TD -->

</td>
</tr></tbody></table>

<!-- End Main Table -->

<%@ include file="include/FooterDisplay.jspf"%>

</body>
</html>