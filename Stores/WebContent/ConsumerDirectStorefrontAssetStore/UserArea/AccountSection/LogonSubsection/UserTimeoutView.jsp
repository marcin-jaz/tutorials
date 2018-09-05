<%
//********************************************************************
//*-------------------------------------------------------------------
//* Licensed Materials - Property of IBM
//*
//* WebSphere Commerce
//*
//* (c) Copyright IBM Corp. 2005
//*
//* US Government Users Restricted Rights - Use, duplication or
//* disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
//*
//*-------------------------------------------------------------------
//*
%>

<%-- 
  *****
  * This JSP is called whenever the current session has timed out.
  *****
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>

<%@ include file="../../../include/JSTLEnvironmentSetup.jspf"%>

<c:choose>
	<c:when test="${empty WCParam.catalogId}">
	 	<%-- The page will be reloaded with the selected catalogId --%>
		<c:url var="sWebAppPath" value="ReLogonFormView">
			<c:param name="catalogId" value="${sdb.masterCatalogDataBean.catalogId}"/>
			<c:param name="storeId" value="${WCParam.storeId}"/>
			<c:param name="langId" value="${CommandContext.languageId}"/>
		</c:url>
		<meta http-equiv="Refresh" content="0;URL=<c:out value="${sWebAppPath}"/>"/>
	</c:when>
	<c:otherwise>

	<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
	<html>
	<head>
		<title><fmt:message bundle="${storeText}" key="USER_SESSION_TIMEOUT_TITLE" /></title>
		<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}"/><c:out value="${vfileStylesheet}"/>" type="text/css"/>
	
	</head>
	
		<body>
		<!-- JSP File Name:  UserTimeoutView.jsp -->
	
		<%@ include file="../../../include/LayoutContainerTop.jspf"%>
		
		<!--MAIN CONTENT STARTS HERE-->
		
		<h1><fmt:message key="USER_SESSION_TIMEOUT_TITLE" bundle="${storeText}" /></h1>
		<table cellpadding="2" cellspacing="0" width="786" border="0" id="WC_UserTimeoutView_Table_1">
		<tr>
			<td id="WC_UserTimeoutView_TableCell_1">
				<fmt:message key="USER_SESSION_TIMEOUT_DETAILS" bundle="${storeText}"/>
			</td>
                </tr>
                <tr>
                	<td id="WC_UserTimeoutView_TableCell_2">
                		<c:url var="LogonFormURL" value="LogonForm">
					<c:param name="langId" value="${langId}" />
					<c:param name="storeId" value="${WCParam.storeId}" />
					<c:param name="catalogId" value="${WCParam.catalogId}" />
                                </c:url>
				<a href="<c:out value="${LogonFormURL}"/>" id="WC_UserTimeoutView_Link_1"><fmt:message key="USER_SESSION_TIMEOUT_LOGIN" bundle="${storeText}"/></a>
			</td>
                </tr>
		</table>
		
		<!-- MAIN CONTENT ENDS HERE -->

	<%-- Hide CIP --%>
	<c:set var="HideCIP" value="true"/>

	<%@ include file="../../../include/LayoutContainerBottom.jspf"%>
	</body>
	</html>
	</c:otherwise>
</c:choose>
