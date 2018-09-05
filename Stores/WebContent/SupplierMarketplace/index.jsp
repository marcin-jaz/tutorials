<%--
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
--%>

<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.ibm.commerce.server.*" %>
<%@ page import="com.ibm.commerce.command.*" %>
<%@ page import="com.ibm.commerce.common.beans.*" %>
<%@ page import="com.ibm.commerce.common.objects.*" %>
<%@ page import="com.ibm.commerce.tools.util.UIUtil" %> 
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="include/parameters.jsp"%>

<%
	//need to put storeId in attribute here since index.jsp is the first page of the store and flow needs to have storeId to interpret the tags. The storeId value is from parameters.jsp included above.
	request.setAttribute("storeId", storeId); 
	String sWebPath=UIUtil.getWebPrefix(request);
	String sWebAppPath=UIUtil.getWebappPath(request);
	
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
	// get master catalog from store
	String catalogId = storeDB.getMasterCatalog().getCatalogReferenceNumber();
%>


<flow:ifEnabled  feature="customerCare">
	<HTML>
		<HEAD>
			<META HTTP-EQUIV=Refresh CONTENT="0;URL=<%=sWebAppPath%>StoreFramesetView?storeId=<%=storeId%>&catalogId=<%=catalogId%>">
		</HEAD>
		<BODY>
		</BODY>
	</HTML>
</flow:ifEnabled>
<flow:ifDisabled feature="customerCare">
	<HTML>
		<HEAD>
			<META HTTP-EQUIV=Refresh CONTENT="0;URL=<%=sWebAppPath%>Logoff?storeId=<%=storeId%>&URL=LogonForm?storeId=<%=storeId%>&catalogId=<%=catalogId%>">
		</HEAD>
		<BODY>
		</BODY>
	</HTML>
</flow:ifDisabled>
