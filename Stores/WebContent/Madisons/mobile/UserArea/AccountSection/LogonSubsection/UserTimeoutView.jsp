<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2008, 2009 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>
<%-- 
  *****
  * This JSP displays user timeout session message.  It provides a link for the user  
  * to return to the login screen. 
  *****
--%>

<!-- BEGIN UserTimeoutView.jsp -->

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>

<%@ include file="../../../../include/parameters.jspf" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf" %>
<%@ include file="../../../include/ErrorMessageSetup.jspf" %>

<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.2//EN" "http://www.openmobilealliance.org/tech/DTD/xhtml-mobile12.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" lang="${shortLocale}" xml:lang="${shortLocale}">
	<head>
		<title>
			<fmt:message key="USER_SESSION_TIMEOUT_TITLE" bundle="${storeText}"/> - <c:out value="${storeName}"/>
		</title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no" />
		<link rel="stylesheet" href="${cssPath}" type="text/css"/>
	</head>
	<body>
		<div id="wrapper">
			<%@ include file="../../../include/HeaderDisplay.jspf" %>

			<div class="content_box">
				<h2><fmt:message key="USER_SESSION_TIMEOUT_TITLE" bundle="${storeText}"/></h2>
				<div class="clear_float"></div>
				<br>

				<p><fmt:message key="USER_SESSION_TIMEOUT_DETAILS" bundle="${storeText}"/></p><br>
			
				<wcf:url var="LogonFormURL" value="MobileLogonForm">
					<wcf:param name="langId" value="${langId}" />
					<wcf:param name="storeId" value="${WCParam.storeId}" />
					<wcf:param name="catalogId" value="${WCParam.catalogId}" />
				</wcf:url>
			
				<a href="${LogonFormURL}" title="<fmt:message key="USER_SESSION_TIMEOUT_LOGIN" bundle="${storeText}"/>">
					<fmt:message key="USER_SESSION_TIMEOUT_LOGIN" bundle="${storeText}"/>
				</a>
				<br>
			</div>
			 
			<%@ include file="../../../include/FooterDisplay.jspf" %>
		</div>
	</body>
</html>

<!-- END UserTimeoutView.jsp -->
