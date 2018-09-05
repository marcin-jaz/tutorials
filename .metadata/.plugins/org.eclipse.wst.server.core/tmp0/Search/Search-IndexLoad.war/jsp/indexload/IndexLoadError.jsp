<%@ page isErrorPage="true" import="java.io.*" %>

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

<fmt:setBundle basename="com.ibm.commerce.foundation.internal.server.services.indexload.logging.properties.WcIndexloadMessages" var="resourceBundle" />

<HEAD><TITLE><fmt:message bundle="${resourceBundle}" key="_MSG_INDEX_STATUS" /></TITLE></HEAD>
<BODY>

<H1><fmt:message bundle="${resourceBundle}" key="_MSG_INDEX_STATUS" /></H1>
<H4><fmt:message bundle="${resourceBundle}" key="_ERR_GENERIC"><fmt:param value="<%=exception.getMessage()%>"/></fmt:message></H4>
<pre>
<%
	StringWriter stringWriter = new StringWriter();
	PrintWriter printWriter = new PrintWriter(stringWriter);
	exception.printStackTrace(printWriter);
	out.println(stringWriter);
	printWriter.close();
	stringWriter.close();
%>
</pre>
</BODY>
</HTML>
