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

<%@ include file="include/EnvironmentSetup.jspf"%>
<%@ include file="include/CacheParametersSetup.jspf"%>

<%
    //Parameters may be encrypted. Use JSPHelper to get URL parameter instead of request.getParameter().
    JSPHelper jhelper = new JSPHelper(request);
    String storeId = jhelper.getParameter("storeId");
    String catalogId = jhelper.getParameter("catalogId");
    String languageId = jhelper.getParameter("langId");
    String navState = "";
    String inFrame  = "";
%>

<flow:ifEnabled feature="customerCare">
<%
    // Set header type needed for this JSP for LiveHelp.  This must
    // be set before HeaderDisplay.jsp
    request.setAttribute("liveHelpPageType", "personal");
%>
</flow:ifEnabled>

<?xml version="1.0"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "DTD/xhtml1-transitional.dtd">

<head>
	<title><%=tooltechtext.getString ("PROHIBITEDCHAR_ERROR_TITLE")%></title>
	<link rel=stylesheet href="<%=fileDir%>ToolTech.css" type="text/css">
</head>


<body marginheight="0" marginwidth="0" leftmargin="0" topmargin="0" onLoad="if (typeof top.updateStInfo == 'function') top.updateStInfo();">
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
    	    <!--MAIN CONTENT STARTS HERE-->
          <table cellpadding="8" cellspacing="0" width="580" border="0" align="left">
					<tr>
            <td align="left" valign="top" colspan="3" class="categoryspace">
                <h1><%=tooltechtext.getString("PROHIBITEDCHAR_ERROR_TITLE")%></h1>
            </td>
          </tr>
          <tr>
    				<td><%=tooltechtext.getString ("PROHIBITEDCHAR_ERROR_DESC")%></td>
    			</tr>
    			<tr>
    				<td>
    					<table cellpadding="0" cellspacing="0" border="0">
    					<tr>
    						<td bgcolor="#ff2d2d" class="pixel"><img src="<%=jspStoreImgDir%>images/lb.gif" border="0"/></td>
    						<td bgcolor="#ff2d2d" class="pixel"><img src="<%=jspStoreImgDir%>images/lb.gif" border="0"/></td>
    						<td class="pixel"><img src="<%=jspStoreImgDir%>images/r_top.gif" border="0"/></td>
    					</tr>
    					<tr>
    						<td bgcolor="#ff2d2d"><img alt="" src="<%=jspStoreImgDir%>images/lb.gif" border="0"/></td>
    						<td bgcolor="#ea2b2b">
    							<table cellpadding="2" cellspacing="0" border="0">
    							<tr>
    								<td class="buttontext">
    									<font color="#ffffff"><b>
    									<a class="catalog" href="javascript:history.back(1)" style="color:#ffffff; text-decoration : none;">
    									<%=tooltechtext.getString ("PROHIBITEDCHAR_ERROR_BACK")%>
    									</a>
    									</b></font>
    								</td>
    							</tr>
    							</table>
    						</td>
    						<td bgcolor="#7a1616"><img alt="" src="<%=jspStoreImgDir%>images/db.gif" border="0"/></td>
    					</tr>
    					<tr>
    						<td class="pixel"><img src="<%=jspStoreImgDir%>images/l_bot.gif"/></td>
    						<td bgcolor="#7a1616" class="pixel" valign="top"><img src="<%=jspStoreImgDir%>images/db.gif" border="0"/></td>
    						<td bgcolor="#7a1616" class="pixel" valign="top"><img src="<%=jspStoreImgDir%>images/db.gif" border="0"/></td>
    					</tr>
    					</table>
    	  			</td>
    	  		</tr>
    	    <!--MAIN CONTENT ENDS HERE-->
    	</td>
    </tr>
    </table>
</body>
</html>
