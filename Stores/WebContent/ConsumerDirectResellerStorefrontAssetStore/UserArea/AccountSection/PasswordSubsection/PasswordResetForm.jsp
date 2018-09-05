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
  * This JSP displays an entry box prompting the customers to enter their Logon ID. 
  * The customers type their Logon ID and click 'Send me my password' button. 
  * The system then sends the password to the user's registered e-mail address if no error occurs.
  *****
--%>

<!-- Start - JSP File Name:  PasswordResetForm.jsp -->

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf" %>
<%@ include file="../../../include/nocache.jspf" %>
<%-- ErrorMessageSetup.jspf is used to retrieve an appropriate error message when there is an error --%>
<%@ include file="../../../include/ErrorMessageSetup.jspf" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
	<title><fmt:message key="FORGET_PASS_TITLE" bundle="${storeText}"/></title>
	<link rel="stylesheet" href='<c:out value="${jspStoreImgDir}${vfileStylesheet}"/>' type="text/css"/>
</head>

<body>

<%@ include file="../../../include/LayoutContainerTop.jspf"%>

	<!--MAIN CONTENT STARTS HERE-->

	<c:url var="RegisterURL" value="Logoff">
		<c:param name="langId" value="${langId}" />
		<c:param name="storeId" value="${WCParam.storeId}" />
		<c:param name="catalogId" value="${WCParam.catalogId}" />
		<c:param name="new" value="Y" />
	</c:url>

	<h1><fmt:message key="FORGOT_PASS" bundle="${storeText}"/></h1>

	<span class="text">
		<fmt:message key="DONOT_PASS" bundle="${storeText}"> 
			<fmt:param>
			<a href="<c:out value="${RegisterURL}"/>">
				<fmt:message key="CLICK_HERE" bundle="${storeText}"/>
			</a>
			</fmt:param>
		</fmt:message>
	</span>

	<%-- 
	  ***
	  *	Start: Error handling
	  * Show an appropriate error message when there is an error
	  ***
	--%>
	<c:if test="${!empty errorMessage}">
		<span class="error"><br/><c:out value="${errorMessage}"/><br/><br/></span>
	</c:if>
	<%-- 
	  ***
	  *	End: Error handling
	  ***
	--%>
	
	<span class="strongtext"><fmt:message key="FORGOT_TEXT" bundle="${storeText}"/></span>

	<%-- 
	  ***
	  *	Start: Reset Password Form
	  ***
	--%>
	<form name="ResetPasswordForm" method="post" action="ResetPassword" id="ResetPasswordForm">
	<input type="hidden" name="challengeAnswer" value="-" id="WC_PasswordResetForm_FormInput_challengeAnswer_In_ResetPasswordForm_1"/>
	<input type="hidden" name="storeId" value='<c:out value="${WCParam.storeId}" />' id="WC_PasswordResetForm_FormInput_storeId_In_ResetPasswordForm_1"/>
	<input type="hidden" name="catalogId" value='<c:out value="${WCParam.catalogId}" />' id="WC_PasswordResetForm_FormInput_catalogId_In_ResetPasswordForm_1"/>
	<input type="hidden" name="langId" value='<c:out value="${langId}" />' id="WC_PasswordResetForm_FormInput_langId_In_ResetPasswordForm_1"/>
	<input type="hidden" name="state" value="passwdconfirm" id="WC_PasswordResetForm_FormInput_state_In_ResetPasswordForm_1"/>
	<input type="hidden" name="URL" value="ResetPasswordForm" id="WC_PasswordResetForm_FormInput_URL_In_ResetPasswordForm_1"/>

	<span class="strongtext">
		<label for="WC_PasswordResetForm_FormInput_logonId_In_ResetPasswordForm_1">
			<fmt:message key="LOGON_ID" bundle="${storeText}"/>
		</label>
	</span>
	<br/>
	<input size="25" name="logonId" id="WC_PasswordResetForm_FormInput_logonId_In_ResetPasswordForm_1"/>
	<br/><br/>

	<a href="javascript:document.ResetPasswordForm.submit()" class="button" id="WC_PasswordResetForm_Link_2">
		<fmt:message key="SEND_PASSWORD" bundle="${storeText}"/>
	</a>	

	</form>
	<%-- 
	  ***
	  *	End: Reset Password Form
	  ***
	--%>				

	<!-- MAIN CONTENT ENDS HERE -->

	<%-- Hide CIP --%>
	<c:set var="HideCIP" value="true"/>

	<%@ include file="../../../include/LayoutContainerBottom.jspf"%>

</body>
</html>
<!-- End - JSP File Name:  PasswordResetForm.jsp -->
