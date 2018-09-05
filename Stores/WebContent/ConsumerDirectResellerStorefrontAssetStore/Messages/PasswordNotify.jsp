<%
//********************************************************************
//*-------------------------------------------------------------------
//* Licensed Materials - Property of IBM
//*
//* WebSphere Commerce
//*
//* (c) Copyright IBM Corp. 2000, 2002, 2004
//*
//* US Government Users Restricted Rights - Use, duplication or
//* disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
//*
//*-------------------------------------------------------------------
//*
%>
<%-- 
  *****
  * After the customer has provided the necessary information on the Forget Password page, this email will be sent.
  * This email JSP page informs the customer about the newly reset password. 
  * This JSP page is associated with PasswordResetNotification view in the viewreg table.  
  *****
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../include/JSTLEnvironmentSetup.jspf"%>
<c:set value="${pageContext.request.scheme}://${pageContext.request.serverName}" var="hostPath" />
<c:set value="${pageContext.request.contextPath}/servlet/" var="webPath" />

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
	<title>
		<fmt:message key="PASSWORD_TITLE" bundle="${storeText}"/>
	</title>
	<link rel="stylesheet" href="<c:out value="${hostPath}"/><c:out value="${jspStoreImgDir}"/><c:out value="${vfileStylesheet}"/>" type="text/css"/>
</head>

<body>

<%@ include file="EmailHeader.jspf"%>

	<h1><fmt:message key="PASSWORD_TITLE" bundle="${storeText}"/></h1>

	<span class="text">

<c:choose>
	<c:when test="${empty WCParam.logonId || empty WCParam.logonPassword}">
		<fmt:message key="PASSWORDNOTIFY_ERROR" bundle="${storeText}"/>
	</c:when>
	
	<c:otherwise>
	  	<% out.flush(); %>
		<c:import url="${jspStoreDir}/Snippets/Marketing/Content/ContentSpotDisplay.jsp">
			<c:param name="spotName" value="Passwd_Success" />
			<c:param name="substitutionValues" value="{password},${WCParam.logonPassword}"/>
		</c:import>
		<% out.flush(); %>
	</c:otherwise>
</c:choose>

<%@ include file="EmailFooter.jspf"%>

</body>
</html>
