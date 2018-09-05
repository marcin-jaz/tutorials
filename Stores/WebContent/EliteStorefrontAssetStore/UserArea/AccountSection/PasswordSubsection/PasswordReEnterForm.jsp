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

<%-- 
  *****
  * The JSP is called everytime there is need for a password protected command
  * to be executed.
  * This JSP page displays fields for customer to re-enter their passwords.
  *****
--%>


<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ taglib uri="http://commerce.ibm.com/coremetrics"  prefix="cm" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf" %>
<%@ include file="../../../include/nocache.jspf" %>
<%-- ErrorMessageSetup.jspf is used to retrieve an appropriate error message when there is an error --%>
<%@ include file="../../../include/ErrorMessageSetup.jspf" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="${shortLocale}" xml:lang="${shortLocale}">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title><fmt:message key="PWDREENTER_TITLE" bundle="${storeText}"/></title>
		<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${vfileStylesheet}"/>" type="text/css"/>
		<!--[if lte IE 6]>
		<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${vfileStylesheetie}"/>" type="text/css"/>
		<![endif]-->
		<script type="text/javascript" src="<c:out value="${dojoFile}"/>" djConfig="${dojoConfigParams}"></script>
		<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/MessageHelper.js"/>"></script>
		<%@ include file="../../../include/CommonJSToInclude.jspf"%>
	</head>
	<body>
		
		<%@ include file="../../../include/StoreCommonUtilities.jspf"%>
		<!-- Page Start -->
		<div id="page">
			<!-- Header Nav Start -->
			<%@ include file="../../../include/LayoutContainerTop.jspf"%>
			<!-- Header Nav End -->
			
			<div id="MessageArea" >
				<br />
				<span id="ErrorMessageText" class="error_msg">
					
				</span>
				<br /><br />  
			</div>
	
	    <!-- Main Content Start -->
			<div id="content_wrapper">
				<!-- Content Start -->
				<div id="box">
					<div class="my_account" id="WC_PasswordReEnterForm_div_1">
	
						<br clear="all"/>
						<br/>
	
						<h1 class="myaccount_title"><fmt:message key="PWDREENTER_TITLE" bundle="${storeText}"/></h1>
						<br/>
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
							<%-- PASSWORD_REREQUEST_URL controls the next URL to display after password is re-entered. This value is set by server, if it is not set, go to my account page --%>
							<c:if test="${!empty WCParam.PASSWORD_REREQUEST_URL}">
								<input type="hidden" name="PASSWORD_REREQUEST_URL" value="<c:out value="${WCParam.PASSWORD_REREQUEST_URL}" />" id="WC_PasswordReEnterForm_FormInput_PASSWORD_REREQUEST_URL_PasswordReEnterForm_1"/>
							</c:if>
							<c:if test="${empty WCParam.PASSWORD_REREQUEST_URL}">
								<input type="hidden" name="PASSWORD_REREQUEST_URL" value="LogonForm" id="WC_PasswordReEnterForm_FormInput_PASSWORD_REREQUEST_URL_PasswordReEnterForm_2"/>
							</c:if>					
							<c:if test="${!empty WCParam.nextUrl}">
								<input type="hidden" name="nextUrl" value="<c:out value="${WCParam.nextUrl}"/>"/>
							</c:if>
			         	
							<div id="WC_PasswordReEnterForm_div_2">
									<fmt:message key="PWDREENTER_DESCRIPTION" bundle="${storeText}"/>
							</div>
							<div id="WC_PasswordReEnterForm_div_3">
								<label for="WC_PasswordReEnterForm_FormInput_CurrentPassword1_PasswordReEnterForm_1">
									<fmt:message key="PWDREENTER_PASSWORD" bundle="${storeText}"/>
								</label>
							</div>
							<div id="WC_PasswordReEnterForm_div_4">
									<input size="25" maxlength="50" name="CurrentPassword1" type="password" value="" id="WC_PasswordReEnterForm_FormInput_CurrentPassword1_PasswordReEnterForm_1"/>
							</div>
							<div id="WC_PasswordReEnterForm_div_5">
								<label for="WC_PasswordReEnterForm_FormInput_CurrentPassword2_PasswordReEnterForm_1">
									<fmt:message key="PWDREENTER_PASSWORD_VERIFY" bundle="${storeText}"/>
								</label>
							</div>
							<div id="WC_PasswordReEnterForm_div_6">
								<input size="25" maxlength="50" name="CurrentPassword2" type="password" value="" id="WC_PasswordReEnterForm_FormInput_CurrentPassword2_PasswordReEnterForm_1"/>
							</div>
		
							<br/><br/>
		
							<span class="primary_button button_fit" >
								<span class="button_container">
									<span class="button_bg">
										<span class="button_top">
											<span class="button_bottom">   
												<a href="#" onclick="javascript:submitSpecifiedForm(document.PasswordReEnterForm);return false;"id="WC_PasswordReEnterForm_Link_1">
													<fmt:message key="PWDREENTER_SUBMIT" bundle="${storeText}"/>
												</a>
											</span>
										</span>
									</span>	
								</span>
							</span>	
		
						</form>
						<%-- 
						  ***
						  *	End: ReEnter Password Form
						  ***
						--%>		
					</div>
				</div>
			</div>
			<!-- Footer Start Start -->
			<%@ include file="../../../include/LayoutContainerBottom.jspf"%>
			<!-- Footer Start End -->
		</div>
		<div id="page_shadow" class="shadow"></div>
<flow:ifEnabled feature="Analytics"><cm:pageview/></flow:ifEnabled>
	</body>
</html>
