<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2007, 2009 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>


<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.ibm.commerce.server.ECConstants" %>
<%@ page import="com.ibm.commerce.datatype.WcParam" %>


<%
// check to see if the wcparam is available; initialise it if it is not available
if( null == request.getAttribute(com.ibm.commerce.server.ECConstants.EC_INPUT_PARAM)){
	request.setAttribute(com.ibm.commerce.server.ECConstants.EC_INPUT_PARAM, new WcParam(request));
}
%>

<c:set var="singleQuote" value="'"/>
<c:set var="escapedSingleQuote" value="\\\\'"/>
<c:set var="doubleQuote" value="\""/>
<c:set var="escapedDoubleQuote" value="\\\\\""/>

<c:remove var="elementId"/>
<c:set var="elementId" value="${fn:replace(WCParam.elementId, singleQuote, escapedSingleQuote)}"/>
<c:set var="elementId" value="${fn:replace(elementId, doubleQuote, escapedDoubleQuote)}"/>

<c:remove var="pageId"/>
<c:set var="pageId" value="${fn:replace(WCParam.pageId, singleQuote, escapedSingleQuote)}"/>
<c:set var="pageId" value="${fn:replace(pageId, doubleQuote, escapedDoubleQuote)}"/>

[{
	elementId: '<c:out value="${elementId}" escapeXml="false"/>', 
	category: '<c:out value="${WCParam.category}" escapeXml="false" />', 
	pageId: '<c:out value="${pageId}" escapeXml="false"/>', 
	pageCategory: '<c:out value="${WCParam.pageCategory}" escapeXml="false"/>', 
	location: '<c:out value="${WCParam.location}" escapeXml="false"/>', 
	state: '<c:out value="${WCParam.state}" escapeXml="false"/>'
}]
