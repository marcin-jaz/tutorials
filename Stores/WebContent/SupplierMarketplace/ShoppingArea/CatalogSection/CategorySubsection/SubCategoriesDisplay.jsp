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

<% // Page specific beans%>
<%@ page import="com.ibm.commerce.beans.DataBeanManager" %>
<%@ page import="com.ibm.commerce.catalog.beans.CategoryDataBean" %>

<%@ include file="../../../include/EnvironmentSetup.jspf"%>
<%@ include file="../../../include/CacheParametersSetup.jspf" %>

<%
try {
	//Parameters may be encrypted. Use JSPHelper to get
	//URL parameter instead of request.getParameter().
	JSPHelper jhelper = new JSPHelper(request);

	String catalogId = jhelper.getParameter("catalogId");
	String storeId = jhelper.getParameter("storeId");
	String languageId = jhelper.getParameter("langId");
	String categoryId = jhelper.getParameter("categoryId");
	String parentCategoryId = jhelper.getParameter("parent_category_rn");

    if (parentCategoryId==null) {
        parentCategoryId="";
    }
    String navState = "";
    String inFrame  = "";
%>

<jsp:useBean id="category" class="com.ibm.commerce.catalog.beans.CategoryDataBean" scope="page">
<%
com.ibm.commerce.beans.DataBeanManager.activate(category, request);
%>
</jsp:useBean>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "DTD/xhtml1-transitional.dtd">
<HTML>
<HEAD>
	<TITLE><%=tooltechtext.getString("SubCategoriesDisp_Title")%> <%=category.getDescription().getName()%></TITLE>
	<LINK REL=stylesheet HREF="<%=fileDir%>ToolTech.css" TYPE="text/css">
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
		<!--STARTS MAIN CONTENT-->
        <jsp:include page="CachedSubCategoriesDisplay.jsp" flush="true">
            <jsp:param name="storeId" value="<%= storeId %>" />
            <jsp:param name="catalogId" value="<%= catalogId %>" />
            <jsp:param name="categoryId" value="<%= categoryId %>" />
            <jsp:param name="parent_category_rn" value="<%= parentCategoryId %>" />
            <jsp:param name="langId" value="<%= languageId %>" />
        </jsp:include>
		<!--ENDS MAIN CONTENT-->
    	</td>
    </tr>
    </table>
</body>
</html>


<%
}
catch (Exception e) {
	e.printStackTrace(new PrintWriter(out));

	Throwable t = e;
	while (t != null && t instanceof javax.servlet.ServletException) {
		t = (Exception) ((javax.servlet.ServletException)t).getRootCause();
		t.printStackTrace();
	}
}
%>
