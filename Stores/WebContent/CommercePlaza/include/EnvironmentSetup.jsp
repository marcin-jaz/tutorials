<%
//********************************************************************
//*-------------------------------------------------------------------
//* Licensed Materials - Property of IBM
//*
//* WebSphere Commerce
//*
//* (c) Copyright International Business Machines Corporation. 2003
//*     All rights reserved.
//*
//* US Government Users Restricted Rights - Use, duplication or
//* disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
//*
//*-------------------------------------------------------------------
//*
%>

<%@ page import="java.util.Locale" %>
<%@ page import="java.util.ResourceBundle" %>
<%@ page import="com.ibm.commerce.command.CommandContext" %>
<%@ page import="com.ibm.commerce.server.JSPResourceBundle" %>
<%@ page import="com.ibm.commerce.catalog.beans.CatalogDataBean" %>

<%@ page import="com.ibm.commerce.server.JSPHelper" %>
<%@ page import="com.ibm.commerce.server.ECConstants" %>

<%@ page session="false"%>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="nocache.jspf" %>

<jsp:useBean id="sdb" class="com.ibm.commerce.common.beans.StoreDataBean" scope="request">
<% com.ibm.commerce.beans.DataBeanManager.activate(sdb, request); %>
</jsp:useBean>

<%
CommandContext cmdcontext = (CommandContext) request.getAttribute(ECConstants.EC_COMMANDCONTEXT);
Locale locale = cmdcontext.getLocale();

String storeDir = sdb.getJspPath();
String fileDir = sdb.getFilePath();	
String includeDir = storeDir + "include" + "/";
String bundleDir = sdb.getDirectory();
String storeName = sdb.getDescription(cmdcontext.getLanguageId()).getDisplayName();


JSPResourceBundle storeText = (JSPResourceBundle) request.getAttribute("ResourceText");
		  		   
if (storeText == null) 
{	
	storeText =  new JSPResourceBundle(sdb.getResourceBundle("pcdmarket"));
	request.setAttribute("ResourceText", storeText);
}

response.setContentType(storeText.getString("ENCODESTATEMENT")); 

// Get the users state
String userState= cmdcontext.getUser().getRegisterType().trim();

//Parameters may be encrypted. Use JSPHelper to get
//URL parameter instead of request.getParameter().
JSPHelper jhelper = new JSPHelper(request);

String storeId = jhelper.getParameter("storeId");
String catalogId = jhelper.getParameter("catalogId");
String categoryId = jhelper.getParameter("categoryId");
String languageId = cmdcontext.getLanguageId().toString();

if (catalogId == null || catalogId.equals("") || catalogId.equals("null") ) { 
	CatalogDataBean Catalogs[] = sdb.getStoreCatalogs();
	catalogId = Catalogs[0].getCatalogId();
}

%>
