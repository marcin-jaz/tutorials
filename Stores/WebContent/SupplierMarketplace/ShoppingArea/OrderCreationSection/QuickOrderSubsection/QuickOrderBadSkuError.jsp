<%--
/*
 *-------------------------------------------------------------------
 * Licensed Materials - Property of IBM 
 *
 * WebSphere Commerce
 *
 * (c) Copyright International Business Machines Corporation. 2003
 *     All rights reserved.
 *
 * US Government Users Restricted Rights - Use, duplication or
 * disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
 *-------------------------------------------------------------------
*/
////////////////////////////////////////////////////////////////////////////////
//
// Change History
//
// YYMMDD    F/D#   WHO       Description
//------------------------------------------------------------------------------
// 
////////////////////////////////////////////////////////////////////////////////
--%>

<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.ibm.commerce.server.*" %>
<%@ page import="com.ibm.commerce.command.*" %>

<%@ page import="com.ibm.commerce.catalog.beans.*" %>
<%@ page import="com.ibm.commerce.catalog.objects.*" %>
<%@ page import="com.ibm.commerce.beans.*" %>  
<%@ page import="com.ibm.commerce.common.beans.*" %>

<%@ include file="../../../include/EnvironmentSetup.jspf"%>
<% response.setContentType(tooltechtext.getString("ENCODESTATEMENT")); %> 
<%

String incfile = null;

incfile = storeDir + "index.jsp";

//Parameters may be encrypted. Use JSPHelper to get URL parameter instead of request.getParameter().
JSPHelper jhelper = new JSPHelper(request);

String callingPage = jhelper.getParameter("callingpage");    

if(callingPage.equals("QuickOrder")) {
	incfile = storeDir + "ShoppingArea/OrderCreationSection/QuickOrderSubsection/QuickOrderForm.jsp";
	%><jsp:include page="<%=incfile%>" flush="true"/><%
	
} else {
	incfile = storeDir + "GenericError.jsp";
	%><jsp:include page="<%=incfile%>" flush="true"/><%
}
%>

