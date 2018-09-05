<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<fmt:setBundle basename="com.ibm.commerce.foundation.internal.server.services.indexload.logging.properties.WcIndexloadMessages" var="resourceBundle" />

<HTML lang="en">
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2010, 2014 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>

<HEAD><TITLE><fmt:message bundle="${resourceBundle}" key="_MSG_USAGE_TITLE" /></TITLE></HEAD>
<BODY>

<H1><fmt:message bundle="${resourceBundle}" key="_MSG_USAGE_TITLE" /></H1>
<H3><PRE>
/config
    <fmt:message bundle="${resourceBundle}" key="_MSG_USAGE_CONFIG" />
    
/clear
    <fmt:message bundle="${resourceBundle}" key="_MSG_USAGE_CLEAR" />

/optimize
    <fmt:message bundle="${resourceBundle}" key="_MSG_USAGE_OPTIMIZE" />

/start
    <fmt:message bundle="${resourceBundle}" key="_MSG_USAGE_START" />
       
/stop
    <fmt:message bundle="${resourceBundle}" key="_MSG_USAGE_STOP" />

/status
    <fmt:message bundle="${resourceBundle}" key="_MSG_USAGE_STATUS" />
</PRE></H3>

<H4><PRE>
<fmt:message bundle="${resourceBundle}" key="_MSG_USAGE_PARAMETERS" />

    profile - <fmt:message bundle="${resourceBundle}" key="_MSG_USAGE_PROFILE" />
    
    detail - <fmt:message bundle="${resourceBundle}" key="_MSG_USAGE_DETAIL" />

<fmt:message bundle="${resourceBundle}" key="_MSG_USAGE_EXAMPLE" />

    /start?profile=inventory&catalogId=10051&langId=-1&storeId=10201&detail=false
</PRE></H4>

</BODY>
</HTML>