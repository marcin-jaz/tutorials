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
  * This JSP displays an entry box prompting the customers to enter their Logon ID. 
  * The customers type their Logon ID and click 'Send me my password' button. 
  * The system then sends the password to the user's registered e-mail address if no error occurs.
  *****
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf" %>
<%@ include file="../../../include/nocache.jspf" %>
<%@ include file="../../../include/ErrorMessageSetup.jspf" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ taglib uri="http://commerce.ibm.com/coremetrics"  prefix="cm" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="${shortLocale}" xml:lang="${shortLocale}">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title><fmt:message key="FORGET_PASS_TITLE" bundle="${storeText}"/></title>
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
     <c:if test="${b2bStore eq 'true'}">
    	<c:if test="${userType =='G'}">
			<c:set var="hideHeader" value="true"/>
		</c:if>
	</c:if>
	<%@ include file="../../../include/LayoutContainerTop.jspf"%>
     <!-- Header Nav End -->
	 <div id="MessageArea" >
		<br />
		<span id="ErrorMessageText" class="error_msg">
			
		</span>
		<br /><br />  
	</div>
     <!-- Main Content Start -->
     <div id="content_wrapper_border">
          <!-- Content Start -->
          <div id="box">	
				<wcf:url var="RegisterURL" value="Logoff">
					<wcf:param name="langId" value="${langId}" />
					<wcf:param name="storeId" value="${WCParam.storeId}" />
					<wcf:param name="catalogId" value="${WCParam.catalogId}" />
					<wcf:param name="new" value="Y" />
					<wcf:param name="myAcctMain" value="1" />
				</wcf:url>
				<div class="sign_in_registration" id="WC_PasswordResetForm_div_1">
                    <div class="title" id="WC_PasswordResetForm_div_2">
                         <h1><fmt:message key="FORGOT_PASS" bundle="${storeText}"/></h1>
                    </div>					
					
                    <div class="forgot_password_container" id="WC_PasswordResetForm_div_3">
                         <div class="forgot_password_header_return" id="WC_PasswordResetForm_div_4">
                         	<div class="heading" id="WC_PasswordResetForm_div_5">
                              	<h2 class="registration_header"><fmt:message key="LET_US_HELP" bundle="${storeText}"/></h2>
                            </div>
                         </div>
						 <div class="forgot_password_content" id="WC_PasswordResetForm_div_6">
						 	<div class="forgot_password_align" id="WC_PasswordResetForm_div_7">
								<fmt:message key="DONOT_PASS" bundle="${storeText}"> 
									<fmt:param>
									<a href="<c:out value="${RegisterURL}"/>" class="myaccount_link" id="WC_PasswordResetForm_links_1">
										<fmt:message key="CLICK_HERE" bundle="${storeText}"/>
									</a>
									</fmt:param>
								</fmt:message>

								<span class="strongtext"><fmt:message key="FORGOT_TEXT" bundle="${storeText}"/></span><br/><br/>
								<c:if test="${!empty errorMessage}">
										<span class="myaccount_title"><c:out value="${errorMessage}"/></span>
								 </c:if>
								
			
								<form name="ResetPasswordForm" method="post" action="PersonChangeServicePasswordReset" id="ResetPasswordForm">
									<input type="hidden" name="challengeAnswer" value="-" id="WC_PasswordResetForm_FormInput_challengeAnswer_In_ResetPasswordForm_1"/>
									<input type="hidden" name="storeId" value='<c:out value="${WCParam.storeId}" />' id="WC_PasswordResetForm_FormInput_storeId_In_ResetPasswordForm_1"/>
									<input type="hidden" name="catalogId" value='<c:out value="${WCParam.catalogId}" />' id="WC_PasswordResetForm_FormInput_catalogId_In_ResetPasswordForm_1"/>
									<input type="hidden" name="langId" value='<c:out value="${langId}" />' id="WC_PasswordResetForm_FormInput_langId_In_ResetPasswordForm_1"/>
									<input type="hidden" name="state" value="passwdconfirm" id="WC_PasswordResetForm_FormInput_state_In_ResetPasswordForm_1"/>
									<input type="hidden" name="URL" value="ResetPasswordForm" id="WC_PasswordResetForm_FormInput_URL_In_ResetPasswordForm_1"/>
									<input type="hidden" name="errorViewName" value="ResetPasswordErrorView" id="WC_PasswordResetForm_FormInput_errorViewName_In_ResetPasswordForm_1"/>
									
									<br />
			
									<span class="strongtext">
										<label for="WC_PasswordResetForm_FormInput_logonId_In_ResetPasswordForm_1">
											<fmt:message key="LOGON_ID2" bundle="${storeText}"/>
										</label>
									</span>
									<br/>
									<input size="25" name="logonId" id="WC_PasswordResetForm_FormInput_logonId_In_ResetPasswordForm_1"/>
									<br/>
			
									<span class="primary_button button_fit" >
										<span class="button_container">
											<span class="button_bg">
												<span class="button_top">
													<span class="button_bottom">   
														<a href="#" onclick="javascript:submitSpecifiedForm(document.ResetPasswordForm);return false;"  id="WC_PasswordResetForm_Link_2">
															<fmt:message key="SEND_PASSWORD" bundle="${storeText}"/>
														</a>
													</span>
												</span>	
											</span>
										</span>
									</span>		
								</form>
							</div>
							<div class="footer" id="WC_PasswordResetForm_div_10">
								<div class="left_corner" id="WC_PasswordResetForm_div_11"></div>
								<div class="left" id="WC_PasswordResetForm_div_12"></div>
		                        <div class="right_corner" id="WC_PasswordResetForm_div_13"></div>
		                    </div>						
						</div>
					</div>
				</div>
			</div>
		</div>
	<%@ include file="../../../include/LayoutContainerBottom.jspf"%>
    <!-- Footer Start End -->
</div>
<div id="page_shadow" class="shadow"></div>
<flow:ifEnabled feature="Analytics"><cm:pageview/></flow:ifEnabled>
</body>
</html>
