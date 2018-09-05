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
  * This JSP displays the Reset password page
  *****
--%>

<!-- BEGIN PasswordResetDisplay.jsp -->

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
			<fmt:message key="RESET_PASSWORD_TITLE" bundle="${storeText}"/> - <c:out value="${storeName}"/>
		</title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no" />
		<link rel="stylesheet" href="${cssPath}" type="text/css"/>
	</head>	
	<body>
		<div id="wrapper">	
			<%@ include file="../../../include/HeaderDisplay.jspf" %>
			
			
			<div id="forgot_your_password" class="content_box"> 
				<div class="heading_container_with_underline"> 
					<h2><fmt:message key="RESET_PASSWORD_TITLE" bundle="${storeText}"/></h2> 
					<div class="clear_float"></div> 
				</div> 

				<p class="paragraph_blurb">
					<fmt:message key="RP_PASSWORD_SENT" bundle="${storeText}" />
				</p> 
				
				<form id="forgot_your_password_form" method="post" action="MobileLogonForm">
					<input type="hidden" name="storeId" value="${WCParam.storeId}" />
					<input type="hidden" name="langId" value="${langId}" />
					<input type="hidden" name="catalogId" value="${WCParam.catalogId}" />
					
					<fieldset> 
						<input type="submit" id="send_password" name="send_password" class="input_button" 
							value="<fmt:message key="RP_CONTINUE_TO_LOGIN" bundle="${storeText}"/>" /> 
					</fieldset> 
				</form> 
			</div> 
			
			<%@ include file="../../../include/FooterDisplay.jspf" %>						
		</div>
	</body>
</html>

<!-- END PasswordResetDisplay.jsp -->
