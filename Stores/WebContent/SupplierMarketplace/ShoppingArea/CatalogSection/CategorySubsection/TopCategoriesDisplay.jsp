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
<%@ page import="com.ibm.commerce.server.JSPResourceBundle" %>
<%@ page import="com.ibm.commerce.command.CommandContext" %>

<%@ include file="../../../include/EnvironmentSetup.jspf"%>
<%@ include file="../../../include/CacheParametersSetup.jspf"%>

<% response.setContentType(tooltechtext.getString("ENCODESTATEMENT")); %>

<%
    //Parameters may be encrypted. Use JSPHelper to get
    //URL parameter instead of request.getParameter().
    JSPHelper jhelper = new JSPHelper(request);

    String storeId = jhelper.getParameter("storeId");
    String catalogId = jhelper.getParameter("catalogId");
    String languageId = jhelper.getParameter("langId");
    String navState = "";
    String inFrame  = "";
 %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "DTD/xhtml1-transitional.dtd">

<head>
	<title><%=tooltechtext.getString("MainCat_TopTitle")%></title>
	<link rel="stylesheet" href="<%=fileDir%>ToolTech.css" type="text/css">
</head>


<body marginheight="0" marginwidth="0" leftmargin="0" topmargin="0" onload="if (typeof top.updateStInfo == 'function') top.updateStInfo();">

<flow:ifEnabled feature="customerCare">
<%
    // Set header type needed for this JSP for LiveHelp.  This must
    // be set before HeaderDisplay.jsp
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

    <table border="0" cellpadding="0" cellspacing="0" width="790" height="99%">
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
		<!--START MAIN CONTENT-->
        <jsp:include page="CachedTopCategoriesDisplay.jsp" flush="true">
            <jsp:param name="storeId" value="<%= storeId %>" />
            <jsp:param name="catalogId" value="<%= catalogId %>" />
            <jsp:param name="langId" value="<%= languageId %>" />
        </jsp:include>
		<!--END MAIN CONTENT-->
    	</td>
    </tr>
    </table>
</body>
</html>