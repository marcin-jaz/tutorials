<%
//********************************************************************
//*-------------------------------------------------------------------
//* Licensed Materials - Property of IBM
//*
//* WebSphere Commerce
//*
//* (c) Copyright IBM Corp. 2000, 2004
//*
//* US Government Users Restricted Rights - Use, duplication or
//* disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
//*
//*-------------------------------------------------------------------
//*
%>

<%-- 
  *****
  * This JSP page confirms that the password has been sent after the customer has provided the necessary information on the Forget Password page.
  *****
--%>

<!-- Start - JSP File Name:  PasswordResetDisplay.jsp -->

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf" %>
<%@ include file="../../../include/nocache.jspf" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
	<title><fmt:message key="PASSWORD_TITLE" bundle="${storeText}" /></title>
	<link rel="stylesheet" href='<c:out value="${jspStoreImgDir}${vfileStylesheet}" />' type="text/css" />
</head>

<body>

<%@ include file="../../../include/LayoutContainerTop.jspf"%>
	
	<!--MAIN CONTENT STARTS HERE-->

	<%-- A message is displayed confirming that the forget password email is sent --%>
	<span class="strong"><fmt:message key="PASSWORD_SENT" bundle="${storeText}" /></span>
	<br /><br />

	<c:url var="LogonFormURL" value="LogonForm">
		<c:param name="storeId"   value="${WCParam.storeId}"  />
		<c:param name="catalogId" value="${WCParam.catalogId}"/>
		<c:param name="langId" value="${langId}" />
	</c:url>

	<a href="<c:out value='${LogonFormURL}'/>" class="button" id="WC_PasswordResetDisplay_Link_1">
		<fmt:message key="CONTINUE_LOGIN" bundle="${storeText}" />
	</a>

<%-- Hide CIP --%>
<c:set var="HideCIP" value="true"/>

<%@ include file="../../../include/LayoutContainerBottom.jspf"%>

</body>
</html>
<!-- End - JSP File Name:  PasswordResetDisplay.jsp -->