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
<% // All JSPs requires the first 4 packages for EnvironmentSetup.jsp which is used for multi language support %> 
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.util.Vector" %>
<%@ page import="com.ibm.commerce.command.CommandContext" %>
<%@ page import="com.ibm.commerce.server.ConfigProperties" %>
<%@ page import="com.ibm.commerce.server.ECConstants" %>
<%@ page import="com.ibm.commerce.server.JSPHelper" %>

<%@ include file="../include/EnvironmentSetup.jsp"%>

<%
String langId = languageId;

String host = request.getServerName();

String StoresWebPath = ConfigProperties.singleton().getValue("WebServer/StoresWebPath");

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
returnURL.append("/StoreCatalogDisplay?storeId=");
returnURL.append(storeId);
returnURL.append("%26langId=");
returnURL.append(langId);
returnURL.append("%26catalogId=");
returnURL.append(catalogId);

StringBuffer scwURL = new StringBuffer();
scwURL.append("https://");
scwURL.append(host);
scwURL.append(":");
scwURL.append(toolsPort);
scwURL.append(acceleratorContextPath);
scwURL.append(acceleratorURLMappingPath);
scwURL.append("/SCWLogonView?storetype=BRP&storetype=RPS&storeId=");
scwURL.append(storeId);
//scwURL.append("&paymentOverride=true");  // Will skip the payment method option in Wizard.
scwURL.append("&launchSeparateWindow=false");
scwURL.append("&callingURL=");
scwURL.append(returnURL);
scwURL.append("&customFrameset=common.MerchantCenterFramesetRHS&webPathToUse=");
scwURL.append(StoresWebPath);
scwURL.append("&sidebarViewName=SidebarDisplayView&headerViewName=HeaderDisplayView&footerViewName=FooterDisplayView&actionName=createstore");
scwURL.append("&storeIdToUse=");
scwURL.append(storeId);
String scwEncodedURL = response.encodeURL(scwURL.toString());

request.setAttribute("pageName", "RequestHostedStore");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "DTD/xhtml1-transitional.dtd">
<html>
<head>
	<title><%=storeText.getString("RequestHostedStoreDisplay_head")%></title>
	<link rel="stylesheet" href="<%=fileDir%>PCDMarket.css" type="text/css" />
</head>

	<frameset rows="76,*,25" border="0" framespacing="0" frameborder="no">
		<frame src="HeaderDisplayView?langId=<%=languageId%>&storeId=<%=storeId%>&catalogId=<%=catalogId%>&actionName=createstore" title="HeaderDisplay" name="HeaderDisplayView" noresize scrolling="no">
		<frameset cols="150,*" border="0" framespacing="0" frameborder="no">
			<frame src="SidebarDisplayView?langId=<%=languageId%>&storeId=<%=storeId%>&catalogId=<%=catalogId%>&actionName=createstore" title="SidebarDisplay" name="SidebarDisplayView" noresize scrolling="no">
			<frame src="<%=scwEncodedURL%>" title="ContentDisplay" name="ContentDisplayView" noresize frameborder="0" framespacing="0" marginwidth="0" marginheight="0" scrolling="auto">
		</frameset>
		<frame src="FooterDisplayView?langId=<%=languageId%>&storeId=<%=storeId%>&catalogId=<%=catalogId%>" title="FooterDisplay" name="FooterDisplayView" noresize scrolling="no">
	</frameset>

</html>