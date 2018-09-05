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
  * This JSP page displays the Reset Password page with the following elements:
  *  - Reset Password form, with 'Logon ID' field
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
<!-- BEGIN PasswordResetForm.jsp -->
<head>
<title><fmt:message key="Forpass_Title" bundle="${storeText}" /></title>
<link rel="stylesheet"
	href="<c:out value="${jspStoreImgDir}${vfileStylesheet}" />"
	type="text/css" />
</head>

<body class="logon">

<!--MAIN CONTENT STARTS HERE-->

<table cellpadding="0" cellspacing="0" border="0" width="100%" id="WC_PasswordResetForm_Table_1">
	<tr>
		<td width="40%" id="WC_PasswordResetForm_TableCell_1">&nbsp;</td>
		<td valign="top" width="600" id="WC_PasswordResetForm_TableCell_2">
			<table cellpadding="0" cellspacing="0" border="0" width="600" id="WC_PasswordResetForm_Table_2">
				<tr>
					<td class="logonTop" id="WC_PasswordResetForm_TableCell_3"><img src="<c:out value="${jspStoreImgDir}" />images/logon_top.gif" alt="" width="600" height="19" border="0"/></td>
				</tr>
				<tr>
					<td class="logonLogo" id="WC_PasswordResetForm_TableCell_4">
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
					<td background="<c:out value="${logonBannerImg}" />" id="WC_PasswordResetForm_TableCell_5"><img src="<c:out value="${logonBannerImg}" />" alt="" width="600" height="99" border="0"/></td>
					--%>
					
					<td background="<c:out value="${jspStoreImgDir}${vfileColor}" />logon_image.jpg" id="WC_PasswordResetForm_TableCell_6"><img src="<c:out value="${jspStoreImgDir}${vfileColor}" />logon_image.jpg" alt="" width="600" height="99" border="0"/></td>
				</tr>
				<tr>
					<td class="logonwhite" width="600" id="WC_PasswordResetForm_TableCell_7">
						<table cellpadding="0" cellspacing="0" border="0" id="WC_PasswordResetForm_Table_3">
							<tr>
								<td class="logontitle" id="WC_PasswordResetForm_TableCell_8"><span class="logontitle">+</span><fmt:message key="Forpass_Title" bundle="${storeText}" /></td>
							</tr>
							<tr>
								<td class="logonspacing" id="WC_PasswordResetForm_TableCell_9">
									<table cellpadding="0" cellspacing="0" border="0" id="WC_PasswordResetForm_Table_4">
										<tr>
											<td class="logontxt" id="WC_PasswordResetForm_TableCell_10">
												<fmt:message key="Forpass_Text1" bundle="${storeText}" />
												<br/><br/>
												<fmt:message key="Forpass_Text2" bundle="${storeText}" />
											</td>
										</tr>
									</table>
									<form name="ResetPasswordForm" method="post" action="ResetPassword"	id="ResetPasswordForm"><input type="hidden" name="storeId" value="<c:out value="${storeId}" />"
									id="WC_PasswordResetForm_FormInput_storeId_In_ResetPasswordForm_1" 
									/><input type="hidden" name="catalogId"
									value="<c:out value="${catalogId}" />"
									id="WC_PasswordResetForm_FormInput_catalogId_In_ResetPasswordForm_1" 
									/><input type="hidden" name="langId" value="<c:out value="${langId}" />"
									id="WC_PasswordResetForm_FormInput_langId_In_ResetPasswordForm_1" 
									/><input type="hidden" name="resetPasswordState" value="resetPasswordSubmitted"
									id="WC_PasswordResetForm_FormInput_state_In_ResetPasswordForm_1" 
									/><input type="hidden" name="URL" value="ResetPasswordForm"
									id="WC_PasswordResetForm_FormInput_URL_In_ResetPasswordForm_1" 
									/><input type="hidden" name="reLogonURL" value="ResetPasswordForm"
									id="WC_PasswordResetForm_FormInput_reLogonURL_In_ResetPasswordForm_1"
									/><table cellpadding="0" cellspacing="0" border="0" id="WC_PasswordResetForm_Table_5">
											<tr>
												<td class="logonheading" id="WC_PasswordResetForm_TableCell_11">
													<label for="WC_PasswordResetForm_FormInput_logonId_In_ResetPasswordForm_1">
														<fmt:message key="Forpass_UserID" bundle="${storeText}" />
													</label>
												</td>
											</tr>
											<tr>
												<td id="WC_PasswordResetForm_TableCell_12">
													<input type="text" size="25" class="logon" name="logonId" id="WC_PasswordResetForm_FormInput_logonId_In_ResetPasswordForm_1"/>
												</td>
											</tr>
											<tr>
												<td class="logonheading" id="WC_PasswordResetForm_TableCell_11b">
													<label for="WC_PasswordResetForm_FormInput_challengeQuestion_In_ResetPasswordForm_1">
														<fmt:message key="Forpass_ChallengeQuestion" bundle="${storeText}" />
													</label>
												</td>
											</tr>
											<tr>
												<td id="WC_PasswordResetForm_TableCell_12b">
													<fmt:message key="Reg_ChallengeQuestion1" bundle="${storeText}" var="Reg_ChallengeQuestion1"/>
													<fmt:message key="Reg_ChallengeQuestion2" bundle="${storeText}" var="Reg_ChallengeQuestion2"/>
													<fmt:message key="Reg_ChallengeQuestion3" bundle="${storeText}" var="Reg_ChallengeQuestion3"/>
													<select class="logon" name="challengeQuestion" id="WC_PasswordResetForm_FormInput_challengeQuestion_In_ResetPasswordForm_1">
														<option value="Reg_ChallengeQuestion1" <c:if test="${WCParam.challengeQuestion == 'Reg_ChallengeQuestion1'}"> selected="selected"</c:if>><c:out value="${Reg_ChallengeQuestion1}"/></option>
														<option value="Reg_ChallengeQuestion2" <c:if test="${WCParam.challengeQuestion == 'Reg_ChallengeQuestion2'}"> selected="selected"</c:if>><c:out value="${Reg_ChallengeQuestion2}"/></option>
														<option value="Reg_ChallengeQuestion3" <c:if test="${WCParam.challengeQuestion == 'Reg_ChallengeQuestion3'}"> selected="selected"</c:if>><c:out value="${Reg_ChallengeQuestion3}"/></option>
													</select>
												</td>
											</tr>
											<tr>
												<td class="logonheading" id="WC_PasswordResetForm_TableCell_11c">
													<label for="WC_PasswordResetForm_FormInput_challengeAnswer_In_ResetPasswordForm_1">
														<fmt:message key="Forpass_ChallengeAnswer" bundle="${storeText}" />
													</label>
												</td>
											</tr>
											<tr>
												<td id="WC_PasswordResetForm_TableCell_12c">
													<input type="text" class="logon" name="challengeAnswer" value="<c:out value="${WCParam.challengeAnswer}"/>" maxlength="40" size="25" id="WC_PasswordResetForm_FormInput_challengeAnswer_In_ResetPasswordForm_1"/>
												</td>
											</tr>
										</table>
									</form>
									<table cellpadding="0" cellspacing="0" border="0" id="WC_PasswordResetForm_Table_6">
										<tr>
											<td valign="bottom" class="button" id="WC_PasswordResetForm_TableCell_13">
												<a href="javascript:document.ResetPasswordForm.submit()" class="button" id="WC_PasswordResetForm_Link_1"><fmt:message key="Forpass_link1" bundle="${storeText}" /></a>
											</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td id="WC_PasswordResetForm_TableCell_14">
									<%-- DISPLAY ERROR MESSAGES --%>
									<c:if test="${!empty errorMessage}">
										<table class="noBorder" id="WC_PasswordResetForm_Table_7">
											<tr>
												<td class="warning" id="WC_PasswordResetForm_TableCell_15">
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
										<a href="<c:out value="${LogonFormURL}"/>" id="WC_PasswordResetForm_Link_2">
											<strong><fmt:message key="Forpass1_Link1" bundle="${storeText}" /></strong> 
										</a>
									</c:if>
								</td>
							</tr>
							<tr>	
								<td id="WC_PasswordResetForm_TableCell_16"><hr width="580" class="logon" /></td>
							</tr>
							<tr>
								<td class="logontitle" id="WC_PasswordResetForm_TableCell_17"><span class="logontitle">+</span><fmt:message key="Logon_Title" bundle="${storeText}" /></td>
							</tr>
							<tr>
								<td class="logonspacing" id="WC_PasswordResetForm_TableCell_18">
									<table cellpadding="0" cellspacing="0" border="0" id="WC_PasswordResetForm_Table_8">
										<tr>
											<td class="logontxt" id="WC_PasswordResetForm_TableCell_19">
												<fmt:message key="Logoff_LogonLink" bundle="${storeText}">
													<fmt:param value="${storeName}"/>
												</fmt:message>
											</td>
										</tr>
									</table>
									<br/>
									<table cellpadding="0" cellspacing="0" border="0" id="WC_PasswordResetForm_Table_9">
										<tr>
											<td class="button" id="WC_PasswordResetForm_TableCell_20">
												<c:url var="LogonFormURL" value="LogonForm">
													<c:param name="storeId" value="${storeId}" />
													<c:param name="langId" value="${langId}" />
													<c:param name="catalogId" value="${catalogId}" />
												</c:url>
												<a href="<c:out value="${LogonFormURL}"/>" class="button" id="WC_PasswordResetForm_Link_3">
													<fmt:message key="Logon_Title" bundle="${storeText}" />
												</a>
											</td>
										</tr>
									</table>
								</td>
							</tr>				
						</table>
					</td>
				</tr>
				<tr>
					<td id="WC_PasswordResetForm_TableCell_21"><img src="<c:out value="${jspStoreImgDir}" />images/logon_bottom.gif" alt="" width="600" height="19" border="0"/></td>
				</tr>
			</table>
		</td>
		<td width="40%" id="WC_PasswordResetForm_TableCell_22">&nbsp;</td>
	</tr>
</table>
</body>
<!-- END PasswordResetForm.jsp -->
</html>
