<%
//********************************************************************
//*-------------------------------------------------------------------
//* Licensed Materials - Property of IBM
//*
//* WebSphere Commerce
//*
//* (c) Copyright IBM Corp. 2002
//*
//* US Government Users Restricted Rights - Use, duplication or
//* disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
//*
//*-------------------------------------------------------------------
//*
//*
//* date=%D% %T%  release info=%W%
//*
%>
<%@ page import="com.ibm.commerce.common.beans.StoreDataBean" %>
<%@ page import="com.ibm.commerce.catalog.beans.CatalogDataBean" %>
<%@ page import="com.ibm.commerce.server.*" %>
<%@ page import="com.ibm.commerce.tools.util.UIUtil" %> 
<%@ include file="include/parameters.jsp"%>

<%
String servletPath = (String)request.getAttribute(ECConstants.EC_SERVLET_PATH);
//if the servlet path in the request attributes is null, as in the case of launching from Studio, the page will be redirected to the correct URL
if (servletPath == null) {		
	String redirectURL = (String)request.getContextPath()+ "/servlet" + (String)request.getServletPath();
	response.sendRedirect(redirectURL);
	return;
}
%>

<jsp:useBean id="storeDB" class="com.ibm.commerce.common.beans.StoreDataBean" scope="request">
<%
storeDB.setStoreId(storeId);
com.ibm.commerce.beans.DataBeanManager.activate(storeDB, request);
%>
</jsp:useBean>

<%
	//need to put storeId in attribute here since index.jsp is the first page of the store and flow needs to have storeId to interpret the tags. The storeId value is from parameters.jsp included above.
	request.setAttribute("storeId", storeId);

	// For this pcdmarketplace store, the master catalog is the display catalog
	String catalogId = storeDB.getMasterCatalog().getCatalogReferenceNumber();
	
	String sWebAppPath=UIUtil.getWebappPath(request);
%>
	<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "DTD/xhtml1-transitional.dtd">
<HTML>
<HEAD>
	<META HTTP-EQUIV=Refresh CONTENT="0;URL=<%=sWebAppPath%>LogonForm?storeId=<%=storeId%>&catalogId=<%=catalogId%>">
</HEAD>
<BODY>
</BODY>
</HTML>

