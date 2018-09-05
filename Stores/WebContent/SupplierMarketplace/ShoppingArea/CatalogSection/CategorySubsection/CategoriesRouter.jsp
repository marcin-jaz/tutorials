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
<% response.setContentType(tooltechtext.getString("ENCODESTATEMENT")); %>
<%
String incfile = null;

String top = request.getParameter("top");
if (top != null)
{
incfile = storeDir + "ShoppingArea/CatalogSection/CategorySubsection/TopCategoriesDisplay.jsp";
%>

<jsp:include page="<%=incfile%>" flush="true"/>

<%
}
else
{
incfile = storeDir + "ShoppingArea/CatalogSection/CategorySubsection/SubCategoriesDisplay.jsp";
%>

<jsp:include page="<%=incfile%>" flush="true"/>

<%
}
%>
