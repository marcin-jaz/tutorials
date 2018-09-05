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
<%@ page import="com.ibm.commerce.tools.util.*" %>
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
<%
// Create XML string
String strCfg=ECLivehelpConstants.EC_CC_XML_HEADER	
			+ LiveHelpConfiguration.getOpenTagString(ECLivehelpConstants.EC_CC_XML_ROOT)
			+ LiveHelpConfiguration.getOpenTagString(ECLivehelpConstants.EC_CC_XML_MONITORING_LIST);
%>
<%	// modify this block to customize monitoring list 
		strCfg=strCfg
			+ LiveHelpConfiguration.getMonitorAttributeElementString(ECLivehelpConstants.EC_CC_ST_ATTR_PAGE_URL,
															  "MonitoringVisitorsTableCurrentPage")
			+ LiveHelpConfiguration.getCloseTagString(ECLivehelpConstants.EC_CC_XML_MONITORING_ATTR);

		strCfg=strCfg
			+ LiveHelpConfiguration.getMonitorCounterAttributeElementString(ECLivehelpConstants.EC_CC_ST_ATTR_SITE_COUNTER,
															  "MonitoringVisitorsTableInSite","30")
			+ LiveHelpConfiguration.getCloseTagString(ECLivehelpConstants.EC_CC_XML_MONITORING_ATTR);

		strCfg=strCfg
			+ LiveHelpConfiguration.getMonitorCounterAttributeElementString(ECLivehelpConstants.EC_CC_ST_ATTR_PAGE_COUNTER,
															  "MonitoringVisitorsTableInPage", "30")
			+ LiveHelpConfiguration.getCloseTagString(ECLivehelpConstants.EC_CC_XML_MONITORING_ATTR);

		strCfg=strCfg
			+ LiveHelpConfiguration.getMonitorAttributeElementString(ECLivehelpConstants.EC_CC_ST_ATTR_CART_ITEMS,
															  "MonitoringVisitorsTableCart")
			+ LiveHelpConfiguration.getCloseTagString(ECLivehelpConstants.EC_CC_XML_MONITORING_ATTR);
%>
<%
	strCfg=	strCfg
		+ LiveHelpConfiguration.getCloseTagString(ECLivehelpConstants.EC_CC_XML_MONITORING_LIST)
		+ LiveHelpConfiguration.getCloseTagString(ECLivehelpConstants.EC_CC_XML_ROOT);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<!-- BEGIN CustomerCareMonitorList.jsp -->
<head>
<%= fLiveHelpHeader%> 
<title><%=(String) liveHelpNLS.get("customerCarePageTitleAgentStoreMonitorList")%></title>
</head>
<body onload="parent.setMonitoringConfiguration('<%=UIUtil.toHTML(strCfg)%>');">
</body>
<!-- END CustomerCareMonitorList.jsp -->
</html>
