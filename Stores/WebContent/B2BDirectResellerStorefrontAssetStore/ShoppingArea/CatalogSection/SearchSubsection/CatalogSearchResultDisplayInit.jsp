<%
/*
 *-------------------------------------------------------------------
 * Licensed Materials - Property of IBM
 *
 * WebSphere Commerce
 *
 * (c) Copyright International Business Machines Corporation. 2001, 2004
 *     All rights reserved.
 *
 * US Government Users Restricted Rights - Use, duplication or
 * disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
 *
 *-------------------------------------------------------------------
 */
%>
<%-- 
  *****
  * CatalogSearchResultDisplay.jsp imports this JSP page.
  * It initializes beingIndex and pageSize.
  *****
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>

<%@ include file="../../../include/JSTLEnvironmentSetup.jspf" %>

<c:choose>
	<c:when test="${!empty WCParam.beginIndex}">
		<c:set var="beginIndex" value="${WCParam.beginIndex}" scope="request"/>
	</c:when>
	
	<%-- the default begin index is 0 --%>
	<c:otherwise>
		<c:set var="beginIndex" value="0" scope="request"/>
	</c:otherwise>
</c:choose>

<c:choose>
	<c:when test="${!empty WCParam.pageSize}">
		<c:set var="pageSize" value="${WCParam.pageSize}" scope="request"/>
	</c:when>
	<%-- the default number of result per page is 10 --%>
	<c:otherwise>
		<c:set var="pageSize" value="10" scope="request"/>
	</c:otherwise>
</c:choose>
