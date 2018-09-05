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
// 020930	    KNG	      Initial create
// 021030	    KNG	      Restructure pages without frames
////////////////////////////////////////////////////////////////////////////////
--%>

<%@ page import="java.util.*" %>
<%@ page import="com.ibm.commerce.command.CommandContext" %>
<%@ page import="com.ibm.commerce.server.ConfigProperties" %>
<%@ page import="com.ibm.commerce.server.ECConstants" %>
<%@ page import="com.ibm.commerce.server.JSPHelper" %>
<%@ page import="com.ibm.commerce.server.JSPResourceBundle" %>
<%@ include file="include/EnvironmentSetup.jspf" %>


<%
JSPHelper jhelper = new JSPHelper(request);
String storeId = jhelper.getParameter(ECConstants.EC_STORE_ID);
String langId = jhelper.getParameter(ECConstants.EC_LANGUAGE_ID);

String host = request.getServerName();

String StoresWebPath = cmdcontext.getWebpath();

String portUsed = null;
String requestURL = request.getRequestURL().toString();
String[] parts = requestURL.split(":");
if (parts.length > 2) {
	//therefore parts[2] should have the port section
	String[] parts2 = parts[2].split("/");
	portUsed = parts2[0];
}

String acceleratorContextPath = null;
String acceleratorURLMappingPath = null;
Vector contextPath = ConfigProperties.singleton().getAllValues("Websphere/WebModule/Module/contextPath");
Vector urlMappingPath = ConfigProperties.singleton().getAllValues("Websphere/WebModule/Module/urlMappingPath");
Vector moduleNames = ConfigProperties.singleton().getAllValues("Websphere/WebModule/Module/name");
for (int i=0; i<moduleNames.size(); i++) {
	String name = (String)moduleNames.elementAt(i);
	if (name.equals("CommerceAccelerator")) {
		acceleratorContextPath = (String)contextPath.elementAt(i);
		acceleratorURLMappingPath = (String)urlMappingPath.elementAt(i);
	}
}

String toolsPort = ConfigProperties.singleton().getValue("WebServer/ToolsPort");

StringBuffer returnURL = new StringBuffer();
returnURL.append("https://");
returnURL.append(host);
returnURL.append(StoresWebPath);
returnURL.append("/StoreView?storeId=");
returnURL.append(storeId);
returnURL.append("%26langId=");
returnURL.append(langId);

StringBuffer scwURL = new StringBuffer();
scwURL.append("https://");
scwURL.append(host);
scwURL.append(":");
scwURL.append(toolsPort);
scwURL.append(acceleratorContextPath);
scwURL.append(acceleratorURLMappingPath);
scwURL.append("/SCWLogonView?storetype=SPS&storeId=");
scwURL.append(storeId);
//scwURL.append("&paymentOverride=true");
scwURL.append("&launchSeparateWindow=false");
scwURL.append("&callingURL=");
scwURL.append(returnURL);
scwURL.append("&customFrameset=common.MerchantCenterFramesetSHS&webPathToUse=");
scwURL.append(StoresWebPath);
if (portUsed != null) {
       scwURL.append("&portToUse=");
       scwURL.append(portUsed);
}
scwURL.append("&sidebarViewName=SidebarDisplayView&headerViewName=HeaderDisplayView&actionName=createstore");
scwURL.append("&storeIdToUse=");
scwURL.append(storeId);
scwURL.append("&includeEmptyCatalog=false");
String scwEncodedURL = response.encodeURL(scwURL.toString());
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>

<head>
	<TITLE><%= tooltechtext.getString("CreateStore_Title")%></TITLE>
	<LINK REL=stylesheet HREF="<%=fileDir%>ToolTech.css" TYPE="text/css">
</head>

<frameset rows="60,*" frameborder="0" framespacing="0" border="0" >
   <frame name="topnav" title="top navigation" src="HeaderDisplayView?forStoreId=<%= storeId %>&<%= ECConstants.EC_LANGUAGE_ID %>=<%= langId %>&inFrame=topnav&navState=admin" frameborder="0" marginwidth="0" marginheight="0" noresize scrolling="auto">

   <frameset cols="160,*" frameborder="0" framespacing="0" border="0">
      <frame name="leftnav" title="left navigation" src="SidebarDisplayView?forStoreId=<%= storeId %>&<%= ECConstants.EC_LANGUAGE_ID %>=<%= langId %>&inFrame=leftnav&navState=admin&actionName=createstore" frameborder="0" marginwidth="0" marginheight="0" noresize scrolling="no">
      <frame name="content" title="content" src="<%=scwEncodedURL%>" frameborder="0" marginwidth="10" marginheight="10" noresize scrolling="auto">
   </frameset>
</frameset>

</html>
