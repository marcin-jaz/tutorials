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
<%@ page import="java.util.*" %>  <% // Needed for: ResourceBundle, Locale %>
<%@ page import="com.ibm.commerce.server.ECConstants" %>
<%@ page import="com.ibm.commerce.server.JSPHelper" %>
<%@ page import="com.ibm.commerce.server.JSPResourceBundle" %>
<%@ page import="com.ibm.commerce.command.CommandContext" %>

<% // Page specific beans%>
<%@ page import="com.ibm.commerce.beans.DataBeanManager" %>
<%@ page import="com.ibm.commerce.catalog.beans.ProductDataBean" %>

<%@ include file="../../../include/EnvironmentSetup.jspf"%>
<%@ include file="../../../include/CacheParametersSetup.jspf"%>

<%
try {
    // JSPHelper provides you with a easy way to retrieve URL parameters when they are encrypted
    JSPHelper jhelper = new JSPHelper(request);

    String catalogId = jhelper.getParameter("catalogId");
    String languageId = jhelper.getParameter("langId");
    String storeId = jhelper.getParameter("storeId");
    String parentCategoryId = jhelper.getParameter("parent_category_rn");
    String productId = jhelper.getParameter("productId");

    if (parentCategoryId == null) {
        parentCategoryId="";
    }
    String navState = "";
    String inFrame  = "";
%>

<jsp:useBean id="product" class="com.ibm.commerce.catalog.beans.ProductDataBean" scope="page">
<%
product.setProductID(productId);
com.ibm.commerce.beans.DataBeanManager.activate(product, request);
%>
</jsp:useBean>

<%
    String strProdDesc = product.getDescription().getShortDescription();
    if(strProdDesc == null || strProdDesc.trim().length() == 0) {
        strProdDesc = product.getDescription().getName();
    }
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "DTD/xhtml1-transitional.dtd">

<head>
	<title><%=tooltechtext.getString("ProdDisp_Title")%> <%=strProdDesc%></title>
	<link rel="stylesheet" href="<%=fileDir%>ToolTech.css" type="text/css">
</head>


<body marginheight="0" marginwidth="0" leftmargin="0" topmargin="0" >
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
    	<td Valign="top" bgcolor="#4C6178" width="160">
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
        <jsp:include page="CachedProductDisplay.jsp" flush="true">
            <jsp:param name="storeId" value="<%= storeId %>" />
            <jsp:param name="catalogId" value="<%= catalogId %>" />
            <jsp:param name="parent_category_rn" value="<%= parentCategoryId %>" />
            <jsp:param name="productId" value="<%= productId %>" />
            <jsp:param name="langId" value="<%= languageId %>" />
        </jsp:include>
    	<!--END MAIN CONTENT-->
    	</td>
    </tr>
    </table>
</body>
</html>
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

