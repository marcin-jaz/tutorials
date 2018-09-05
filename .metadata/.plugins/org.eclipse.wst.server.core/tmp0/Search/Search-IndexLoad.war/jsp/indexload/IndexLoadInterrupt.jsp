<%@page language="java" %>
<%@page import="com.ibm.commerce.foundation.internal.server.services.indexload.SolrIndexLoadConstants"%>
<%@page import="com.ibm.commerce.foundation.internal.server.services.indexload.SolrIndexLoadLauncher"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<HTML lang="en">
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2014 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>

<%
String profileName = request.getParameter(SolrIndexLoadConstants.QUERY_PARAMETER_NAME_PROFILE);
SolrIndexLoadLauncher launcher = SolrIndexLoadLauncher.getInstance(profileName);
launcher.stop();
%>

<fmt:setBundle basename="com.ibm.commerce.foundation.internal.server.services.indexload.logging.properties.WcIndexloadMessages" var="resourceBundle" />

<HEAD>
<TITLE><fmt:message bundle="${resourceBundle}" key="_MSG_INDEX_INTERRUPTED" /></TITLE>
<META http-equiv="refresh" content="5; url=/search/indexload/status?profile=${param.profile}&detail=${param.detail}" />
</HEAD>
<BODY>

<H1><fmt:message bundle="${resourceBundle}" key="_MSG_INDEX_INTERRUPTED" /></H1>
<H4><PRE><%= launcher.getExitReport() %></PRE></H4>
<PRE><%= launcher.getIndexReport() %></PRE>
<PRE><%= launcher.getSummaryReport() %></PRE>

</BODY>
</HTML>
