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

<% // All JSPs requires these packages for getResource.jsp which is used for multi language support %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.ibm.commerce.server.ECConstants" %>
<%@ page import="com.ibm.commerce.server.JSPHelper" %>
<%@ page import="com.ibm.commerce.command.CommandContext" %>
<%@ page import="com.ibm.commerce.server.JSPResourceBundle" %>

<%@ include file="../../../include/EnvironmentSetup.jspf"%>
<%@ include file="../../../include/CacheParametersSetup.jspf"%>

<%
try {
    // JSPHelper provides you with a easy way to retrieve URL parameters when they are encrypted

    JSPHelper jhelper = new JSPHelper(request);

    String catalogId = jhelper.getParameter("catalogId");
    String languageId = jhelper.getParameter("langId");
    String storeId = jhelper.getParameter("storeId");
    String itemId = jhelper.getParameter("productId");
    String fromIntList = jhelper.getParameter("fromIntList");
    String navState = "";
    String inFrame  = "";
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "DTD/xhtml1-transitional.dtd">

<HEAD>
	<TITLE><%=tooltechtext.getString("ItemDisp_Title2")%></TITLE>
	<LINK REL=stylesheet HREF="<%=fileDir%>ToolTech.css" TYPE="text/css">
</HEAD>

<BODY MARGINHEIGHT="0" MARGINWIDTH="0" LEFTMARGIN="0" TOPMARGIN="0" onLoad="if (typeof top.updateStInfo == 'function') top.updateStInfo();">

    <flow:ifEnabled feature="customerCare">
    	<%
    	// Set header type needed for this JSP for LiveHelp.
    	// This must be set before HeaderDisplay.jsp
    	request.setAttribute("liveHelpPageType", "personal");
    	%>
    </flow:ifEnabled>

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

    <TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0" WIDTH="790" HEIGHT="99%">
    <tr>
    	<td VALIGN="top" BGCOLOR="#4c6178" WIDTH="160">
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
		<!--START MAIN CONTENT-->
        <jsp:include page="CachedPackageDisplay.jsp" flush="true">
            <jsp:param name="storeId" value="<%= storeId %>" />
            <jsp:param name="catalogId" value="<%= catalogId %>" />
            <jsp:param name="productId" value="<%= itemId %>" />
            <jsp:param name="fromIntList" value="<%= fromIntList %>" />
            <jsp:param name="langId" value="<%= languageId %>" />
            <jsp:param name="userState" value="<%= userState %>" />
            <jsp:param name="rfqLinkDisplayed" value="<%= rfqLinkDisplayed %>" />
            <jsp:param name="registeredUser" value="<%= bRegisteredUser %>" />
        </jsp:include>
		<!-- END MAIN CONTENT -->
    	</td>
    </tr>
    </TABLE>

</BODY>

</HTML>

<%
}
catch (Exception e) {
	e.printStackTrace(new PrintWriter(out));
	if (e instanceof javax.servlet.ServletException) {
		((javax.servlet.ServletException)e).getRootCause().printStackTrace();
	}
%>
Got Exception!!
<%
}
%>
