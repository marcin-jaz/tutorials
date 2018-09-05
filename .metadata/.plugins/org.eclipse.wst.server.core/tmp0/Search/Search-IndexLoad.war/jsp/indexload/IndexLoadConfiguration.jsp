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
String configTemplate = (String) request.getAttribute(SolrIndexLoadConstants.INIT_PARAM_NAME_CONFIG_TEMPLATE);
String configEnvironment = (String) request.getAttribute(SolrIndexLoadConstants.INIT_PARAM_NAME_CONFIG_ENVIRONMENT);
String logPath = (String) request.getAttribute(SolrIndexLoadConstants.INIT_PARAM_NAME_LOG_PATH);

String profileName = request.getParameter(SolrIndexLoadConstants.QUERY_PARAMETER_NAME_PROFILE);
SolrIndexLoadLauncher launcher = SolrIndexLoadLauncher.getInstance(profileName);
launcher.status(configTemplate, configEnvironment, logPath, request.getParameterMap());
%>

<fmt:setBundle basename="com.ibm.commerce.foundation.internal.server.services.indexload.logging.properties.WcIndexloadMessages" var="resourceBundle" />

<HEAD><TITLE><fmt:message bundle="${resourceBundle}" key="_MSG_INDEX_CONFIGURATION" /></TITLE></HEAD>
<BODY>

<H1><fmt:message bundle="${resourceBundle}" key="_MSG_INDEX_CONFIGURATION" /></H1>
<PRE><%= launcher.getConfigurationReport() %></PRE>

</BODY>
</HTML>
