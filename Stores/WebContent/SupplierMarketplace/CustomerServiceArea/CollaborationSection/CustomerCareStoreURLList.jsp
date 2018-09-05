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
<%@ page import="com.ibm.commerce.exception.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.ibm.commerce.collaboration.livehelp.beans.CCQueueDataBean" %>
<%@ page import="com.ibm.commerce.collaboration.livehelp.commands.ECLivehelpConstants" %>
<%@ page import="com.ibm.commerce.ras.ECTrace" %>
<%@ page import="com.ibm.commerce.ras.ECTraceIdentifiers" %>
<%@ page import="com.ibm.commerce.ras.*" %>
<%@ page import="com.ibm.commerce.beans.*" %>
<%@ page import="com.ibm.commerce.datatype.*" %>
<%@ page import="com.ibm.commerce.server.*" %>
<%@ page import="com.ibm.commerce.command.*" %>
<%@page import="com.ibm.commerce.tools.util.*" %>
<%@ page import="com.ibm.commerce.collaboration.livehelp.beans.LiveHelpConfiguration" %>
<%@ page session="false" %>
<% response.setContentType("text/html;charset=UTF-8"); %>
<% response.setHeader("Pragma", "No-cache"); %>
<% response.setDateHeader("Expires", 0); %>
<% response.setHeader("Cache-Control", "no-cache"); %>
<%

   // Get commandcontext, locale, and processing option
   CommandContext commandContext = (CommandContext)request.getAttribute(ECConstants.EC_COMMANDCONTEXT);
   Locale aLocale = commandContext.getLocale();
   Hashtable liveHelpNLS = (Hashtable)ResourceDirectory.lookup("livehelp.liveHelpNLS", aLocale);
    String fLiveHelpHeader =
        "<META HTTP-EQUIV='Cache-Control' CONTENT='no-cache'>" +
             "<META HTTP-EQUIV=expires CONTENT='fri,31 Dec 2000 10:00:00 GMT'>";   
%>
<% // Create XML string
String strCfg=ECLivehelpConstants.EC_CC_XML_HEADER	
			+ LiveHelpConfiguration.getOpenTagString(ECLivehelpConstants.EC_CC_XML_ROOT)
			+ LiveHelpConfiguration.getOpenTagString(ECLivehelpConstants.EC_CC_XML_URL_LIST);
%>
<%-- //unmark following block to add URL group/pages
		// start of URL group block, repeat for more URL groups
		strCfg=strCfg
			+ LiveHelpConfiguration.getURLGroupElementString("StoreGroupName");
			// start of URL pages block, repeat for all pages in the same group
			strCfg=strCfg
				+ LiveHelpConfiguration.getURLPageElementString("PageName","URL address")
				+ LiveHelpConfiguration.getCloseTagString(ECLivehelpConstants.EC_CC_XML_URL_PAGE);
			// end of URL pages block
		strCfg=strCfg 
			+ LiveHelpConfiguration.getCloseTagString(ECLivehelpConstants.EC_CC_XML_URL_GROUP);
		// end of URL group block
// --%>
<%
	strCfg=	strCfg
		+ LiveHelpConfiguration.getCloseTagString(ECLivehelpConstants.EC_CC_XML_URL_LIST)
		+ LiveHelpConfiguration.getCloseTagString(ECLivehelpConstants.EC_CC_XML_ROOT);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<!-- BEGIN CustomerCareStoreURLList.jsp -->
<head>
<%= fLiveHelpHeader%> 
<title><%=(String)liveHelpNLS.get("customerCarePageTitleAgentStoreURLList")%></title>
</head>
<body onload="parent.setStoreURLConfiguration('<%=UIUtil.toHTML(strCfg)%>');">
</body>
<!-- END CustomerCareStoreURLList.jsp -->
</html>
