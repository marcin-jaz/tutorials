<%--
/*
 *-------------------------------------------------------------------
 * Licensed Materials - Property of IBM
 *
 * WebSphere Commerce
 *
 * (c) Copyright International Business Machines Corporation. 2001-2004
 *     All rights reserved.
 *
 * US Government Users Restricted Rights - Use, duplication or
 * disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
 *
 *-------------------------------------------------------------------
 */
--%>
<%-- 
  *****
  * This JSP page displays the Update Password page with the following elements:
  *  - Update Password form, with 'Old password' field, 'New password' field and 'Verify new password' field
  *  - 'Return to Logon page' button
  *****
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf"%>
<%@ include file="../../../include/ErrorMessageSetup.jspf"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<!-- BEGIN PasswordUpdateForm.jsp -->
<head>
<title><fmt:message key="CHANGEPWD_TITLE" bundle="${storeText}" /></title>
<link rel="stylesheet"
	href="<c:out value="${jspStoreImgDir}${vfileStylesheet}" />"
	type="text/css" />
</head>

<body class="logon">

<!--MAIN CONTENT STARTS HERE-->

<table cellpadding="0" cellspacing="0" border="0" width="100%" id="WC_PasswordUpdateForm_Table_1">
	<tr>
		<td width="40%" id="WC_PasswordUpdateForm_TableCell_1">&nbsp;</td>
		<td valign="top" width="600" id="WC_PasswordUpdateForm_TableCell_2">
			<table cellpadding="0" cellspacing="0" border="0" width="600" id="WC_PasswordUpdateForm_Table_2">
				<tr>
					<td class="logonTop" id="WC_PasswordUpdateForm_TableCell_3"><img src="<c:out value="${jspStoreImgDir}" />images/logon_top.gif" alt="" width="600" height="19" border="0"/></td>
				</tr>
				<tr>
					<td class="logonLogo" id="WC_PasswordUpdateForm_TableCell_4">
						<flow:ifEnabled feature="CustomLogo">
							<img alt="<c:out value="${storeName}" />" src="<c:out value="${storeImgDir}${vfileLogo}" />" align="middle"/>
						</flow:ifEnabled>
						<flow:ifDisabled feature="CustomLogo">
							<img alt="<c:out value="${storeName}" />" src="<c:out value="${jspStoreImgDir}${vfileLogo}" />" align="middle"/>
						</flow:ifDisabled>
					</td>
				</tr>
				<tr>
				
					<%--
					//Use the following when custom logon banners can be chosen
					
					<flow:fileRef id="vfileSelectedLogonBanner" fileId="vfile.selectedLogonBanner"/>
					<flow:ifEnabled feature="CustomBanner">
						<c:set var="logonBannerImg" value="${storeImgDir}${vfileBanner}" />
					</flow:ifEnabled>	
					<flow:ifDisabled feature="CustomBanner">
				        <c:set var="logonBannerImg" value="${jspStoreImgDir}${vfileSelectedLogonBanner}" />
					</flow:ifDisabled>
					<td background="<c:out value="${logonBannerImg}" />" id="WC_PasswordUpdateForm_TableCell_5"><img src="<c:out value="${logonBannerImg}" />" alt="" width="600" height="99" border="0"/></td>
					--%>
					
					<td background="<c:out value="${jspStoreImgDir}${vfileColor}" />logon_image.jpg" id="WC_PasswordUpdateForm_TableCell_6"><img src="<c:out value="${jspStoreImgDir}${vfileColor}" />logon_image.jpg" alt="" width="600" height="99" border="0"/></td>
				</tr>
				<tr>
					<td class="logonwhite" width="600" id="WC_PasswordUpdateForm_TableCell_7">
						<table cellpadding="0" cellspacing="0" border="0" id="WC_PasswordUpdateForm_Table_3">
							<tr>
								<td class="logontitle" id="WC_PasswordUpdateForm_TableCell_8"><span class="logontitle">+</span><fmt:message key="CHANGEPWD_TITLE" bundle="${storeText}" /></td>
							</tr>
							<tr>
								<td class="logonspacing" id="WC_PasswordUpdateForm_TableCell_9"><form name="ResetPasswordForm" 
								method="post" action="ResetPassword"
								id="ResetPasswordForm"><input type="hidden" name="storeId" value="<c:out value="${storeId}" />"
								id="WC_PasswordResetForm_FormInput_storeId_In_ResetPasswordForm_1" 
								/><input type="hidden" name="catalogId"
								value="<c:out value="${catalogId}" />"
								id="WC_PasswordResetForm_FormInput_catalogId_In_ResetPasswordForm_1" 
								/><input type="hidden" name="langId" value="<c:out value="${langId}" />"
								id="WC_PasswordResetForm_FormInput_langId_In_ResetPasswordForm_1" 
								/><input type="hidden" name="Relogon" value="Update"
								id="WC_PasswordResetForm_FormInput_Relogon_In_ResetPasswordForm_1" 
								/><input type="hidden" name="URL" value="UserAccountView"
								id="WC_PasswordResetForm_FormInput_URL_In_ResetPasswordForm_1" 
								/><input type="hidden" name="reLogonURL" value="ChangePassword"
								id="WC_PasswordResetForm_FormInput_reLogonURL_In_ResetPasswordForm_1"
								/><table cellpadding="0" cellspacing="0" border="0" id="WC_PasswordUpdateForm_Table_4">
										<tr>
											<td class="logonheading" id="WC_PasswordUpdateForm_TableCell_10">
												<label for="WC_PasswordUpdateForm_FormInput_logonPasswordOld_In_ResetUpdateForm_1">
													<fmt:message key="CHANGEPWD_GeneratedPassword" bundle="${storeText}" />
												</label>
											</td>
										</tr>
										<tr>
											<td id="WC_PasswordUpdateForm_TableCell_11">
												<input type="password" autocomplete="off" size="13" class="logon" name="logonPasswordOld" id="WC_PasswordUpdateForm_FormInput_logonPasswordOld_In_ResetUpdateForm_1"/>
											</td>
										</tr>
										<tr>
											<td class="logonheading" id="WC_PasswordUpdateForm_TableCell_12">
												<label for="WC_PasswordUpdateForm_FormInput_logonPassword_In_ResetUpdateForm_1">
													<fmt:message key="CHANGEPWD_NewPassword" bundle="${storeText}" />
												</label>
											</td>
										</tr>
										<tr>
											<td id="WC_PasswordUpdateForm_TableCell_13">
												<input type="password" autocomplete="off" size="13" class="logon" name="logonPassword" id="WC_PasswordUpdateForm_FormInput_logonPassword_In_ResetUpdateForm_1"/>
											</td>
										</tr>
										<tr>
											<td class="logonheading" id="WC_PasswordUpdateForm_TableCell_14">
												<label for="WC_PasswordUpdateForm_FormInput_logonPasswordVerify_In_ResetUpdateForm_1">
													<fmt:message key="CHANGEPWD_VerifyPassword" bundle="${storeText}" />
												</label>
											</td>
										</tr>
										<tr>
											<td id="WC_PasswordUpdateForm_TableCell_15">
												<input type="password" autocomplete="off" size="13" class="logon" name="logonPasswordVerify" id="WC_PasswordUpdateForm_FormInput_logonPasswordVerify_In_ResetUpdateForm_1"/>
											</td>
										</tr>
									</table></form>
									<table cellpadding="0" cellspacing="0" border="0" id="WC_PasswordUpdateForm_Table_5">
										<tr>
											<td valign="bottom" class="button" id="WC_PasswordUpdateForm_TableCell_16">
												<a href="javascript:document.ResetPasswordForm.submit()" class="button" id="WC_PasswordUpdateForm_Link_1"><fmt:message key="CHANGEPWD_Submit" bundle="${storeText}" /></a>
											</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td id="WC_PasswordUpdateForm_TableCell_17">
									<%-- DISPLAY ERROR MESSAGES --%>
									<c:if test="${!empty errorMessage}">
										<table class="noBorder" id="WC_PasswordUpdateForm_Table_6">
											<tr>
												<td class="warning" id="WC_PasswordUpdateForm_TableCell_18">
													<c:out value="${errorMessage}" />
												</td>
											</tr>
										</table>
									</c:if>
									<c:if test="${(resetPasswordState[0] eq 'resetPasswordSubmitted') && (empty errorMessage)}">
										<strong><fmt:message key="Forpass1_Text1" bundle="${storeText}" /></strong>
										<br />
										<c:url var="LogonFormURL" value="LogonForm">
											<c:param name="storeId" value="${storeId}" />
											<c:param name="langId" value="${langId}" />
											<c:param name="catalogId" value="${catalogId}" />
										</c:url>
										<a href="<c:out value="${LogonFormURL}"/>" id="WC_PasswordUpdateForm_Link_2">
											<strong><fmt:message key="Forpass1_Link1" bundle="${storeText}" /></strong>
										</a>
									</c:if>
								</td>
							</tr>
							</table>
					</td>
				</tr>
				<tr>
					<td id="WC_PasswordUpdateForm_TableCell_24"><img src="<c:out value="${jspStoreImgDir}" />images/logon_bottom.gif" alt="" width="600" height="19" border="0"/></td>
				</tr>
			</table>
		</td>
		<td width="40%" id="WC_PasswordUpdateForm_TableCell_25">&nbsp;</td>
	</tr>
</table>
</body>
<!-- END PasswordUpdateForm.jsp -->
</html>
