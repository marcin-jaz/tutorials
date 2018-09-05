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
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.ibm.commerce.command.CommandContext" %>
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

<c:remove var="pageName"/>
<c:set var="pageName" value="${fn:replace(WCParam.pagename, singleQuote, escapedSingleQuote)}"/>
<c:set var="pageName" value="${fn:replace(pageName, doubleQuote, escapedDoubleQuote)}"/>

[{
	pagename : '<c:out value="${pageName}" escapeXml="false"/>', 
	category: '<c:out value="${WCParam.category}" escapeXml="false" />',
	searchTerms: '<c:out value="${WCParam.searchTerms}" escapeXml="false"/>',
	searchCount: '<c:out value="${WCParam.searchCount}" escapeXml="false"/>',
	storeId: '<c:out value="${CommandContext.storeId}"/>'
}]
