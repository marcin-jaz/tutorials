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
<%@ page import="java.util.*" %>
<%@ page import="com.ibm.commerce.ras.*" %>
<%@ page import="com.ibm.commerce.beans.*" %>
<%@ page import="com.ibm.commerce.datatype.*" %>
<%@ page import="com.ibm.commerce.server.*" %>
<%@ page import="com.ibm.commerce.command.*" %>
<%@ page import="com.ibm.commerce.tools.util.UIUtil" %>
<%@ page import="com.ibm.commerce.collaboration.livehelp.beans.*" %>
<%@ include file="../../include/EnvironmentSetup.jspf"%>
<%
	CommandContext commandContext = (CommandContext)request.getAttribute(ECConstants.EC_COMMANDCONTEXT);
	String storeId = commandContext.getStoreId().toString();
	String langId = commandContext.getLanguageId().toString();
	String placeName = storeId + "_store" + "@" + LiveHelpShopperConfiguration.getInstanceName();
	String queueName = storeId + "_store" + "_queue" + "@" + LiveHelpShopperConfiguration.getInstanceName();
	String codeBase = LiveHelpShopperConfiguration.getAppletCodeBaseURL();
	String sametimeHostName = LiveHelpShopperConfiguration.getHostName();
	String monitorType = LiveHelpShopperConfiguration.getMonitorType();
	String sWebPath=UIUtil.getWebPrefix(request);
	String sWebAppPath=UIUtil.getWebappPath(request);
	String urlpath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+ sWebAppPath;
	String blankURL = urlpath+"CCShopperBlankPageView?storeId=" + storeId;
	String readyURL = urlpath+"CCShopperReadyPageView?storeId=" + storeId;
	String sCSRName="";
	try {
		sCSRName=(String) ccResBundle.getString("customerCareCSRName");
		if (sCSRName==null) { 
			sCSRName="";
			} 
		else {
			sCSRName=sCSRName.trim();
			}
	} catch (Exception ex) {
		sCSRName="";
		}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<!-- BEGIN CustomerCareFrameSetup.jsp -->
<head>
<title><%=ccResBundle.getString("customerCarePageTitleShopperApplet")%></title>
<script language="javascript">
			top.BlankURL="<%=blankURL%>";
			top.ReadyURL="<%=readyURL%>";
			top.WcsStoreID="<%=storeId%>";
			top.WcsLangID="<%=langId%>";

			function isLoad()
			{ return;}
		
</script>
</head>
<body class="noMargin">
<% if (LiveHelpShopperConfiguration.isEnabled()) 
   {
%>
<applet width="360" height="400" align="middle" code="com.ibm.commerce.collaboration.livehelp.st.wcscustomer.InteractivePresenceApplet.class" name="InteractivePresenceApplet" alt='<%=ccResBundle.getString("customerCareShopperAppletTitle")%>' viewastext="viewastext" mayscript="true" scriptable="true" codebase="<%=codeBase%>">
  <param name="MAYSCRIPT" value="true"/>
  <param name="scriptable" value="true"/>
  <param name="cabbase" value="WCSAware.cab"/>
  <param name="archive" value="WCSAware.jar"/>
  <param name="SAMETIME_SERVER" value="<%=sametimeHostName%>"/>
  <param name="PLACE_NAME" value="<%=placeName%>"/>
  <param name="PLACE_DISPLAY_NAME" value="<%=placeName%>"/>
  <param name="QUEUE_NAME" value="<%=queueName%>"/>
  <param name="JSFrame" value="JSFrame"/>
  <param name="contentFrame" value="main"/>
  <param name="blankUrl" value="<%=blankURL%>"/>
  <param name="readyJS" value="<%=readyURL%>"/>
  <param name="MONITOR_TYPE" value="<%=monitorType%>"/>
  <param name="CHAT_FONT_SIZE" value="12"/>
  <param name="CHAT_NAME_LENGTH" value="15"/>
  <param name="CHAT_FONT_COLOR" value="#0000FF"/>
  <param name="WAIT_RANGE_1" value="10"/>
  <param name="WAIT_RANGE_2" value="20"/>
  <param name="WAIT_RANGE_3" value="50"/>
  <param name="LOCALE" value="<%=locale.toString()%>"/>
  <param name="MSG_TEXT_CSR" value="<%=sCSRName%>"/>
</applet>
<%
   }
%>
</body>
<!-- END CustomerCareFrameSetup.jsp -->
</html>
