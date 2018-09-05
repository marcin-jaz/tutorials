<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
/*
 *-------------------------------------------------------------------
 * Licensed Materials - Property of IBM
 *
 * WebSphere Commerce
 *
 * (c) Copyright International Business Machines Corporation. 2001-2004
 *     All rights reserved.
 *
 * US Government Users Restricted Rights - Use, duplication or
 * disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
 *
 *-------------------------------------------------------------------
 */
%>

<% // All JSPs requires the first 4 packages for getResource.jsp which is used for multi language support %> 
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.ibm.commerce.command.*" %>
<%@ page import="com.ibm.commerce.server.*" %>

<%@ include file="../../../include/EnvironmentSetup.jspf"%>
<%@ include file="../../../include/CacheParametersSetup.jspf" %>

<%
	//Parameters may be encrypted. Use JSPHelper to get URL parameters instead of request.getParameter()
	JSPHelper jspHelper = new JSPHelper(request);

	String storeId   = jspHelper.getParameter("storeId");
	String langId    = jspHelper.getParameter("langId");

	String catalogId = sdb.getStoreCatalogs()[0].getCatalogId();
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<%
boolean approved = !userType.equalsIgnoreCase("G");
if(approved) {
%>
	<meta http-equiv="Refresh" content="0;URL=TopCategoriesDisplay?storeId=<%= storeId %>&langId=<%= langId %>&catalogId=<%= catalogId %>"/>
<% } else { //if(approved) %>
	<meta http-equiv="Refresh" content="0;URL=LogonForm?storeId=<%=storeId%>&langId=<%= langId %>&catalogId=<%= catalogId %>&page=account"/>
<% } //if(approved) %>

</head>
</html>
