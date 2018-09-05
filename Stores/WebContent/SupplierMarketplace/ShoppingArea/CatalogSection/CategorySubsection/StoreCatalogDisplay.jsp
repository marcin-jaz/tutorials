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

<%
    String regURL = null;
    String pageToInclude = "";
    boolean bInclude = false;

    if  (!(bBuyerBuySide && (bBuyerApprover || bBuyerAdmin)) && (userState.equals("0"))){
        // If the user is not a buyer approve, and pending state, redirect to account
            pageToInclude = "UserArea/AccountSection/UserAccountDisplay.jsp";
            bInclude = true;
    }
    else if  (bGuessUser) {
        // If the user is a guest shopper
            pageToInclude = "UserArea/AccountSection/LogonSubsection/UserLogonForm.jsp";
            bInclude = true;
    }

    if (bInclude) {
%>
        <jsp:include page="<%=pageToInclude%>" flush="true"/>
<% } %>

<?xml version="1.0"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "DTD/xhtml1-transitional.dtd">

<HEAD>
	<TITLE><%=tooltechtext.getString ("Home_Page")%></TITLE>
	<LINK REL=stylesheet HREF="<%=fileDir%>ToolTech.css" TYPE="text/css">

	<SCRIPT LANGUAGE="JavaScript">

	var bRightBrowser = false;

	//The following checkBrowser function is for checking browser version when the Buyer
	//Approval Tool link is hit.  This is transferring the user Tools page which requires
	//the correct supported browser version.  Note that the link will not be visible for
	//user without Buyer Approver role.
	//
	//The same code is used in Left Nav Bar where the link to RFQ also requires this browser
	//version checking.

	function checkBrowser() {
		oClientCaps.style.behavior = "url(#default#clientCaps)";
		if ( navigator.appName == "Microsoft Internet Explorer") {
			bInstalled = oClientCaps.isComponentInstalled("{89820200-ECBD-11CF-8B85-00AA005B4383}", "ComponentID");
			if ( bInstalled) {
				IEversion = oClientCaps.getComponentVersion("{89820200-ECBD-11CF-8B85-00AA005B4383}", "ComponentID");
				version = IEversion.substr(0,3);
				versionNumber = parseInt(IEversion.substr(0,1));
				revisionNumber = parseInt(IEversion.substr(2,1));
				if ( (version == "5,5") || (versionNumber > 5) || (versionNumber == 5 && revisionNumber > 5) ) {
					bRightBrowser = true
					return true;
				}
			}
		}
		return false;

	}
	</SCRIPT>
</HEAD>


<BODY MARGINHEIGHT="0" MARGINWIDTH="0" LEFTMARGIN="0" TOPMARGIN="0" onLoad="if (typeof top.updateStInfo == 'function') top.updateStInfo();">
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

    <TABLE CELLPADDING="0" CELLSPACING="0" BORDER="0" height="99%" width="790">
    <TR>
    	<TD VALIGN="top" BGCOLOR="#4c6178" WIDTH="160">
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
    	</TD>

    	<TD valign="top" width="630">
    	    <!--MAIN CONTENT STARTS HERE-->
            <jsp:include page="CachedStoreCatalogDisplay.jsp" flush="true">
                <jsp:param name="storeId" value="<%= storeId %>" />
                <jsp:param name="catalogId" value="<%= catalogId %>" />
                <jsp:param name="langId" value="<%= languageId %>" />
            </jsp:include>
    	    <!--MAIN CONTENT ENDS HERE-->
    	    <BR>
    	</TD>
    </TR>
    </TABLE>
</BODY>
</HTML>
