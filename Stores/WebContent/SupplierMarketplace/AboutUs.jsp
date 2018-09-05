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
// 021210	    CON	      Initial Copied form SPE
////////////////////////////////////////////////////////////////////////////////
--%>

<%@ page import="java.util.*" %>
<%@ page import="com.ibm.commerce.server.JSPHelper" %>
<%@ page import="com.ibm.commerce.server.JSPResourceBundle" %>
<%@ page import="com.ibm.commerce.server.ECConstants" %>
<%@ page import="com.ibm.commerce.command.CommandContext" %>

<%@ include file="include/EnvironmentSetup.jspf" %>
<%@ include file="include/CacheParametersSetup.jspf" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title><%= tooltechtext.getString("aboutusTitle") %></title>
	<link rel="stylesheet" HREF="<%=fileDir%>ToolTech.css" type="text/css">
</head>

<body marginheight="0" marginwidth="0" leftmargin="0" topmargin="0">
<%
    // JSPHelper provides you with a easy way to retrieve URL parameters when they are encrypted
    JSPHelper jhelper = new JSPHelper(request);

    String catalogId = jhelper.getParameter("catalogId");
    String languageId = jhelper.getParameter("langId");
    String storeId = jhelper.getParameter("storeId");
    String inFrame="";
    String navState="admin";
%>

<%
String incfile;
incfile = includeDir + "CachedHeaderDisplay.jsp";
%>
<jsp:include page="<%=incfile%>" flush="true">
    <jsp:param name="storeId" value="<%= storeId %>" />
    <jsp:param name="catalogId" value="<%= catalogId %>" />
    <jsp:param name="langId" value="<%= languageId %>" />
    <jsp:param name="userType" value="<%= userType %>" />
    <jsp:param name="userState" value="<%= userState %>" />
    <jsp:param name="rfqLinkDisplayed" value="<%= rfqLinkDisplayed %>" />
</jsp:include>

    <table cellpadding="0" cellspacing="0" border="0" height="99%" width="790">
    <tr>
    	<td valign="top" bgcolor="#4c6178" width="160">
    		<%
    		incfile = includeDir + "CachedSidebarDisplay.jsp";
    		%>
            <jsp:include page="<%=incfile%>" flush="true">
                <jsp:param name="storeId"   value="<%= storeId %>" />
                <jsp:param name="langId"    value="<%= languageId %>" />
                <jsp:param name="inFrame"   value="<%= inFrame %>" />
                <jsp:param name="navState"  value="<%= navState %>" />
                <jsp:param name="userType"  value="<%= userType %>" />
                <jsp:param name="userState" value="<%= userState %>" />
                <jsp:param name="siteAdmin" value="<%= bSiteAdmin %>" />
                <jsp:param name="sellAdmin" value="<%= bSellerAdmin %>" />
                <jsp:param name="buyAdmin"  value="<%= bBuyerAdmin %>" />
                <jsp:param name="seller"    value="<%= bSeller %>" />
            </jsp:include>
    	</td>

    	<td valign="top" width="630">
            <jsp:include page="CachedAboutUs.jsp" flush="true">
                <jsp:param name="storeId"   value="<%= storeId %>" />
                <jsp:param name="catalogId" value="<%= catalogId %>" />
                <jsp:param name="langId"    value="<%= languageId %>" />
                <jsp:param name="navState"  value="<%= navState %>" />
            </jsp:include>
    	</td>
    </tr>
    </table>

</body>
</html>