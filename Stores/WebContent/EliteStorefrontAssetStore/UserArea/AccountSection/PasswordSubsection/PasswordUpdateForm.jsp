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
  * This JSP will display the ResetPassword form with the following fields:
  *  - Current password
  *  - New password
  *  - New Verify password
  * If the user password expired, this page will be displayed after the user logs on.
  *****
--%>

<%-- Start - JSP File Name:  PasswordUpdateForm.jsp --%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf" %>
<%@ include file="../../../include/nocache.jspf" %>
<%-- ErrorMessageSetup.jspf is used to retrieve an appropriate error message when there is an error --%>
<%@ include file="../../../include/ErrorMessageSetup.jspf" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ taglib uri="http://commerce.ibm.com/coremetrics"  prefix="cm" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="${shortLocale}" xml:lang="${shortLocale}">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><fmt:message key="CHANGE_PWORD_TITLE" bundle="${storeText}"/></title>
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
     <div id="content_wrapper_border">
          <!-- Content Start -->
          <div id="box">

			<div class="sign_in_registration" id="WC_PasswordUpdateForm_div_1">
				<div class="title" id="WC_PasswordUpdateForm_div_2">
                	<h1><fmt:message key="CHANGE_PWORD" bundle="${storeText}"/></h1>
                </div>

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
			  *	Start: Reset Password Form
			  ***
			--%>
			<wcf:url value="OrderItemMove" var="OrderItemMoveURL">
			<wcf:param name="page" value="account"/>
			<wcf:param name="URL" value="OrderCalculate?URL=LogonForm"/>
			</wcf:url>
            <div class="forgot_password_container" id="WC_PasswordUpdateForm_div_3">
				<div class="forgot_password_header_return" id="WC_PasswordUpdateForm_div_4">
					<div class="heading" id="WC_PasswordUpdateForm_div_5">
						<h2 class="registration_header"><fmt:message key="PWORD_EXPIRED" bundle="${storeText}"/></h2>
					</div>
				</div>
				
				<div class="forgot_password_content" id="WC_PasswordUpdateForm_div_6">
				 	<div class="update_password_align" id="WC_PasswordUpdateForm_div_7">				
			<form name="Logon" method="post" action="PersonChangeServicePasswordReset" id="Logon">
			<input type="hidden" name="storeId" value='<c:out value="${WCParam.storeId}" />' id="WC_PasswordUpdateForm_FormInput_storeId_In_Logon_1"/>
			<input type="hidden" name="catalogId" value='<c:out value="${WCParam.catalogId}" />' id="WC_PasswordUpdateForm_FormInput_catalogId_In_Logon_1"/>
			<input type="hidden" name="langId" value='<c:out value="${langId}" />' id="WC_PasswordUpdateForm_FormInput_langId_In_Logon_1"/>
			<input type="hidden" name="logonId" value='<c:out value="${WCParam.logonId}" />' id="WC_PasswordUpdateForm_FormInput_logonId_In_Logon_1"/>
			<input type="hidden" name="reLogonURL" value="ChangePassword" id="WC_PasswordUpdateForm_FormInput_reLogonURL_In_Logon_1"/>
			<input type="hidden" name="Relogon" value="Update" id="WC_PasswordUpdateForm_FormInput_Relogon_In_Logon_1"/>
			
			<input type="hidden" name="fromOrderId" value="*" id="WC_PasswordResetForm_FormInput_fromOrderId_In_Logon_1"/>
			<input type="hidden" name="toOrderId" value="." id="WC_PasswordResetForm_FormInput_toOrderId_In_Logon_1"/>
			<input type="hidden" name="deleteIfEmpty" value="*" id="WC_PasswordResetForm_FormInput_deleteIfEmpty_In_Logon_1" />
			<input type="hidden" name="continue" value="1" id="WC_PasswordResetForm_FormInput_continue_In_Logon_1" />
			<input type="hidden" name="createIfEmpty" value="1" id="WC_PasswordResetForm_FormInput_createIfEmpty_In_Logon_1" />
			<%-- the parameter 'calculationUsageId' and 'updatePrices' are used by the OrderCalculate command --%>
			<input type="hidden" name="calculationUsageId" value="-1" id="WC_PasswordResetForm_FormInput_calculationUsageId_In_Logon_1" />
			<input type="hidden" name="updatePrices" value="0" id="WC_PasswordResetForm_FormInput_updatePrices_In_Logon_1"/>
			<input type="hidden" name="URL" value="<c:out value="${OrderItemMoveURL}"/>" id="WC_PasswordResetForm_FormInput_URL_In_ResetPasswordForm_1"/>
			<input type="hidden" name="myAcctMain" value="1" id="WC_PasswordUpdateForm_FormInput_myAcctMain_In_Logon_1"/>
			
			<div id="WC_PasswordUpdateForm_div_8">
					<label for="WC_PasswordUpdateForm_FormInput_logonPasswordOld_In_Logon_1">
						<fmt:message key="CURRENT_PWORD" bundle="${storeText}"/>
					</label>
			</div>
			<div id="WC_PasswordUpdateForm_div_9">
					<input size="25" maxlength="50" name="logonPasswordOld" type="password" value="" id="WC_PasswordUpdateForm_FormInput_logonPasswordOld_In_Logon_1"/>
			</div>
			<div id="WC_PasswordUpdateForm_div_10">
					<label for="WC_PasswordUpdateForm_FormInput_logonPassword_In_Logon_1">
						<fmt:message key="PASSWORD" bundle="${storeText}"/>
					</label>
			</div>
			<div id="WC_PasswordUpdateForm_div_11">
					<input size="25" maxlength="50" name="logonPassword" type="password" value="" id="WC_PasswordUpdateForm_FormInput_logonPassword_In_Logon_1"/>
			</div>
			<div id="WC_PasswordUpdateForm_div_12">
					<label for="WC_PasswordUpdateForm_FormInput_logonPasswordVerify_In_Logon_1">
						<fmt:message key="VERIFY_PASS" bundle="${storeText}"/>
					</label>
			</div>
			<div id="WC_PasswordUpdateForm_div_13">
					<input size="25" maxlength="50" name="logonPasswordVerify" type="password" value="" id="WC_PasswordUpdateForm_FormInput_logonPasswordVerify_In_Logon_1"/>
			</div>
						<br/>

			<span class="primary_button button_fit" >
				<span class="button_container">
					<span class="button_bg">
						<span class="button_top">
							<span class="button_bottom">   
								<a href="#" onclick="javascript:submitSpecifiedForm(document.Logon);return false;" id="WC_PasswordUpdateForm_Link_1">
									<fmt:message key="SUBMIT" bundle="${storeText}"/>
								</a>
							</span>
						</span>	
					</span>
				</span>
			</span>	

			</form>
			<%-- 
			  ***
			  *	End: Reset Password Form
			  ***
			--%>				
					</div>
					<div class="footer" id="WC_PasswordUpdateForm_div_16">
						<div class="left_corner" id="WC_PasswordUpdateForm_div_17"></div>
						<div class="left" id="WC_PasswordUpdateForm_div_18"></div>
		                <div class="right_corner" id="WC_PasswordUpdateForm_div_19"></div>
		            </div>				
				</div>					
			</div>			

		</div></div>
	</div>
	<%@ include file="../../../include/LayoutContainerBottom.jspf"%>
     <!-- Footer Start End -->
</div>
<div id="page_shadow" class="shadow"></div>
<flow:ifEnabled feature="Analytics"><cm:pageview/></flow:ifEnabled>
</body>
</html>
