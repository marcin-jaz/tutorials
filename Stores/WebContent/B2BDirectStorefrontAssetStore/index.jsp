<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%--
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
--%>
<%-- 
  *****
  * This JSP page redirects the user to a customer care enabled frameset if customer care is enabled.
  * This JSP page also redirects the user into the store if the user is already logged in.
  *****
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>

<%@ page import="com.ibm.commerce.server.JSPHelper" %>
<%@ page import="com.ibm.commerce.tools.util.UIUtil" %>

<%@ include file="include/parameters.jsp"%>

<c:if test="${empty requestScope.requestServletPath}">
	<c:redirect url="${requestScope.contextPath}/servlet${pageContext.request.servletPath}"/>
</c:if>

<%
JSPHelper jhelper = new JSPHelper(request);
String storeentID = jhelper.getParameter("storeId");
if (storeentID!= null && !storeentID.equals("")) {
	storeId = storeentID;
}
request.setAttribute("storeId", storeId);
%>

<wcbase:useBean id="storeDB" classname="com.ibm.commerce.common.beans.StoreDataBean">
	<% storeDB.setStoreId(storeId); %>
</wcbase:useBean>
<c:set var="storeId" value="${storeDB.storeId}"/>

<%
String sWebAppPath=UIUtil.getWebappPath(request);
%>

<%--
***
* By default, the catalogId in the initial URL is set to the master catalog ID.
* This implies that the master catalog will be displayed in the store pages.
***
--%>
<c:set var="catalogId" value="${storeDB.masterCatalogDataBean.catalogId}"/>

<c:set var="pageParameter" value="${WCParam.page}"/>
<c:set var="userType" value="${CommandContext.user.registerType}"/>
<c:set var="guest" value="G"/>
<c:choose>
	<c:when test="${userType eq guest}">
		<flow:ifEnabled  feature="customerCare">
			<html>
				<head>
					<meta http-equiv="Refresh" content="0;URL=<%=sWebAppPath%>StoreFramesetView?storeId=<c:out value="${storeId}"/>&catalogId=<c:out value="${catalogId}"/>&page=<c:out value="${pageParameter}"/>"/>
				</head>
				<body>
				</body>
			</html>
		</flow:ifEnabled>
		<flow:ifDisabled feature="customerCare">
			<html>
				<head>
					<meta http-equiv="Refresh" content="0;URL=<%=sWebAppPath%>LogonForm?storeId=<c:out value="${storeId}"/>&catalogId=<c:out value="${catalogId}"/>&page=<c:out value="${pageParameter}"/>"/>
				</head>
				<body>
				</body>
			</html>
		</flow:ifDisabled>
	</c:when>
	<c:otherwise>
		<flow:ifEnabled  feature="customerCare">
			<html>
				<head>
					<meta http-equiv="Refresh" content="0;URL=<%=sWebAppPath%>StoreFramesetView?storeId=<c:out value="${storeId}"/>&catalogId=<c:out value="${catalogId}"/>"/>
				</head>
				<body>
				</body>
			</html>
		</flow:ifEnabled>
		<flow:ifDisabled feature="customerCare">
			<html>
				<head>
					<meta http-equiv="Refresh" content="0;URL=<%=sWebAppPath%>UserAccountView?storeId=<c:out value="${storeId}"/>&catalogId=<c:out value="${catalogId}"/>"/>
				</head>
				<body>
				</body>
			</html>
		</flow:ifDisabled>
	</c:otherwise>
</c:choose>
