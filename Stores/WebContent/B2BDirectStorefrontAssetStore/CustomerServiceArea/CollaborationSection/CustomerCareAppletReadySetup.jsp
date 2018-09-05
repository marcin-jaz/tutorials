<%--
/*
 *-------------------------------------------------------------------
 * Licensed Materials - Property of IBM 
 *
 * WebSphere Commerce
 *
 * (c) Copyright International Business Machines Corporation. 2003
 *     All rights reserved.
 *
 * US Government Users Restricted Rights - Use, duplication or
 * disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
 *-------------------------------------------------------------------
*/
////////////////////////////////////////////////////////////////////////////////
//
// Change History
//
// YYMMDD    F/D#   WHO       Description
//------------------------------------------------------------------------------
// 030819    677    wrehman   xhtml conversion
//
////////////////////////////////////////////////////////////////////////////////
--%>
<% // All JSPs requires these packages for getResource.jsp which is used for multi language support %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.ibm.commerce.server.ECConstants" %>
<%@ page import="com.ibm.commerce.server.JSPHelper" %>
<%@ page import="com.ibm.commerce.server.JSPResourceBundle" %>
<%@ page import="com.ibm.commerce.command.CommandContext" %>
<% // Page specific imports%>
<%@page import="com.ibm.commerce.tools.util.*" %>
<%@ include file="../../include/EnvironmentSetup.jspf"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<!-- BEGIN CustomerCareAppletReadySetup.jsp -->
<head>
<title><%=ccResBundle.getString("customerCarePageTitleShopperReady")%></title>
<script language="javascript">
function initApplet() {
	if (top.sametime !=null)
	{
		if (typeof top.sametime.isLoad == 'function')
			top.InteractivePresenceAppletIsUp();
		else // NS reload
		{
			if (top.browserType.ns) {
				top.updatePage();
				}
			}

	 }
 }

</script>
</head>
<body onload="initApplet();">
<!--
	This page notifies Javascript that the Sametime applet is up and
    ready for customer interactions. The result of this Javascript
    command updates the Sametime applet with information about the
    customer session, and allows the other Javascript commands to execute.

  -->
</body>
<!-- END CustomerCareAppletReadySetup.jsp -->
</html>
