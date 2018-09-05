<%--==========================================================================
Licensed Materials - Property of IBM

WebSphere Commerce

(c) Copyright IBM Corp.  2006
All Rights Reserved

US Government Users Restricted Rights - Use, duplication or
disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
===========================================================================--%>
<%-- 
  *****
  * The JSP is called everytime there is need for a password protected command
  * to be executed.
  * This JSP page displays fields for customer to re-enter their passwords.
  *****
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf"%>
<%@ include file="../../../include/ErrorMessageSetup.jspf"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
	<title><fmt:message key="PWDREENTER_TITLE" bundle="${storeText}"/></title>
	<link rel="stylesheet" href='<c:out value="${jspStoreImgDir}${vfileStylesheet}"/>' type="text/css"/>
</head>

<body class="noMargin">

<%@ include file="../../../include/LayoutContainerTop.jspf"%>

	<!--MAIN CONTENT STARTS HERE-->
	
	<h1><fmt:message key="PWDREENTER_TITLE" bundle="${storeText}"/></h1>

  <c:set var="messageErrorCode" value="${WCParam.MessageCode}" />
  <c:if test="${empty errorMessage}">
		<c:choose>
			<c:when test="${messageErrorCode == '1'}">
				<fmt:message key="PWDREENTER_DO_NOT_MATCH" bundle="${storeText}" var="errorMessage"/>
			</c:when>
			<c:when test="${messageErrorCode == '2'}">
				<fmt:message key="PWDREENTER_MISSING_PARAMETERS" bundle="${storeText}" var="errorMessage"/>
			</c:when>
			<c:when test="${messageErrorCode == '3'}">
				<fmt:message key="PWDREENTER_INCORRECT_PASSWORD" bundle="${storeText}" var="errorMessage"/>
			</c:when>
		</c:choose>
	</c:if>

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

	<%-- 
	  ***
	  *	Start: ReEnter Password Form
	  ***
	--%>
	<form name="PasswordReEnterForm" method="post" action="PasswordRequest" id="Logon">
	<input type="hidden" name="storeId" value="<c:out value="${WCParam.storeId}" />" id="WC_PasswordReEnterForm_FormInput_storeId_PasswordReEnterForm_1"/>
	<input type="hidden" name="catalogId" value="<c:out value="${WCParam.catalogId}" />" id="WC_PasswordReEnterForm_FormInput_catalogId_PasswordReEnterForm_1"/>
	<input type="hidden" name="langId" value="<c:out value="${langId}" />" id="WC_PasswordReEnterForm_FormInput_langId_PasswordReEnterForm_1"/>
	<input type="hidden" name="PASSWORD_REREQUEST_URL" value="<c:out value="${WCParam.PASSWORD_REREQUEST_URL}" />" id="WC_PasswordReEnterForm_FormInput_PASSWORD_REREQUEST_URL_PasswordReEnterForm_1"/>
	
	<table cellpadding="0" cellspacing="0" border="0" class="t_table" id="WC_PasswordReEnterForm_Table_1">
	<tbody><tr>
		<td class="t_td2" id="WC_PasswordReEnterForm_TableCell_1">
			<fmt:message key="PWDREENTER_DESCRIPTION" bundle="${storeText}"/>
		</td>
	</tr>
	<tr>
		<td class="t_td2" id="WC_PasswordReEnterForm_TableCell_2">
			<label for="WC_PasswordReEnterForm_FormInput_CurrentPassword1_PasswordReEnterForm_1">
				<fmt:message key="PWDREENTER_PASSWORD" bundle="${storeText}"/>
			</label>
		</td>
	</tr>
	<tr>
		<td class="t_td2" id="WC_PasswordReEnterForm_TableCell_3">
			<input size="25" maxlength="50" name="CurrentPassword1" type="password" autocomplete="off" value="" id="WC_PasswordReEnterForm_FormInput_CurrentPassword1_PasswordReEnterForm_1"/>
		</td>
	</tr>
	<tr>
		<td class="t_td2" id="WC_PasswordReEnterForm_TableCell_4">
			<label for="WC_PasswordReEnterForm_FormInput_CurrentPassword2_PasswordReEnterForm_1">
				<fmt:message key="PWDREENTER_PASSWORD_VERIFY" bundle="${storeText}"/>
			</label>
		</td>
	</tr>
	<tr>
		<td class="t_td2" id="WC_PasswordReEnterForm_TableCell_5">
			<input size="25" maxlength="50" name="CurrentPassword2" type="password" autocomplete="off" value="" id="WC_PasswordReEnterForm_FormInput_CurrentPassword2_PasswordReEnterForm_1"/>
		</td>
	</tr>
	</table>
	
	<br/><br/>

	<a href="javascript:document.PasswordReEnterForm.submit()" class="button" id="WC_PasswordReEnterForm_Link_1">
		<fmt:message key="PWDREENTER_SUBMIT" bundle="${storeText}"/>
	</a>

	</form>
	<%-- 
	  ***
	  *	End: ReEnter Password Form
	  ***
	--%>				

<%-- Hide CIP --%>
<c:set var="HideCIP" value="false"/>

<%@ include file="../../../include/LayoutContainerBottom.jspf"%>

</body>
</html>
<!-- End - JSP File Name:  PasswordReEnterForm.jsp -->
