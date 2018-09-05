<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2009 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>
<%-- 
  *****
  * This JSP page displays the Logon page with the following elements:
  *  - Switch Language form, with 'Language' field
  *  - Logon form, with 'Logon ID' field and 'Password' field
  *  - 'Forgot your password?' link
  *  - 'Register' button
  *  - 'Register Organization' button
  *****
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf"%>
<%@ include file="../../../include/ErrorMessageSetup.jspf"%>



<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<!-- BEGIN UserLogonForm.jsp -->
<head>
<title><fmt:message key="Logon_Title" bundle="${storeText}" /></title>
<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${vfileStylesheet}" />" type="text/css"/>
<script language="JavaScript" type="text/javascript">
function pressEnter(keyStroke){
	isNetscape=(document.layers);
	keyCode = (isNetscape) ? keyStroke.which : event.keyCode;
	
	if (keyCode == 13){
		document.Logon.submit()
	}
}
</script>
</head>

<body class="logon">

<flow:ifEnabled feature="customerCare">
	<% out.flush(); %>
  	<c:import url="${jspStoreDir}include/CustomerCareHeaderSetup.jsp"/>
	<% out.flush(); %>
</flow:ifEnabled>

<!--MAIN CONTENT STARTS HERE-->
<table cellpadding="0" cellspacing="0" border="0" width="100%" id="WC_UserLogonForm_Table_1">
	<tr>
		<td width="40%" id="WC_UserLogonForm_TableCell_1">&nbsp;</td>
		<td valign="top" id="WC_UserLogonForm_TableCell_2">
			<table cellpadding="0" cellspacing="0" border="0" id="WC_UserLogonForm_Table_2">
				<tr>
					<td class="logonLogo" id="WC_UserLogonForm_TableCell_4">
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
					<td background="<c:out value="${logonBannerImg}" />" id="WC_UserLogonForm_TableCell_5"><img src="<c:out value="${logonBannerImg}" />" alt="" width="600" height="99" border="0"/></td>
					--%>
					
					<td id="WC_UserLogonForm_TableCell_6" class="logonbackgrnd"><img src="<c:out value="${jspStoreImgDir}${vfileColor}" />logon_image.jpg" alt="" width="600" height="100" border="0"/></td>
				</tr>
				<tr>
					<td class="logonwhite" id="WC_UserLogonForm_TableCell_7">
						<table cellpadding="0" cellspacing="0" border="0" id="WC_UserLogonForm_Table_3">
							<tr>
								<td width="50%" valign="top" id="WC_UserLogonForm_TableCell_8">
									<table cellpadding="0" cellspacing="0" border="0" id="WC_UserLogonForm_Table_4a">
										<tr>
											<td class="logontitle" id="WC_UserLogonForm_TableCell_9"><span class="logontitle">+</span><fmt:message key="Logon_Title" bundle="${storeText}" /></td>
										</tr>
										<tr>
											<td class="logonspacing" id="WC_UserLogonForm_TableCell_10">
												<%-- 
												  ***
												  * This form is used to switch preferred language. By switching language, shopper switches language and currency.
												  ***
												--%>
												<form name="SwitchLanguage" action="LogonForm" method="get" id="SwitchLanguage">
												<input type="hidden" name="storeId" value="<c:out value="${storeId}" />" id="WC_UserLogonForm_FormInput_storeId_In_SwitchLanguage_1"/>
												<input type="hidden" name="catalogId" value="<c:out value="${catalogId}" />" id="WC_UserLogonForm_FormInput_catalogId_In_SwitchLanguage_1"/>
												<table class="noBorder" cellspacing="0" cellpadding="0" id="WC_UserLogonForm_Table_4">
													<tr>
														<td id="WC_UserLogonForm_TableCell_11" class="logonheading">
															<label for="WC_UserLogonForm_FormInput_landId_In_SwitchLanguageForm_1">
																<fmt:message key="Logon_Lang" bundle="${storeText}" />
															</label>
														</td>
													</tr>
													<tr>
														<td id="WC_UserLogonForm_TableCell_12">
														  <select style="width: 250px" name="langId" onchange="javascript:document.SwitchLanguage.submit()" class="logon" id="WC_UserLogonForm_FormInput_landId_In_SwitchLanguageForm_1">
															<c:forEach items="${sdb.languageDataBeans}" var="supportedLanguage">
																<%--
																Use the following to show language descriptions in the page's locale
																--%>
																
																<option value="<c:out value="${supportedLanguage.languageId}"/>"
																	<c:if test="${supportedLanguage.languageId eq langId}">
																		selected="selected"
																	</c:if>
																>
																	<c:out value="${supportedLanguage.nativeDescriptionString}"/>
																</option>
																
																<%--
																Use the following to show language descriptions in the language's locale
																--%>
																<%--
																<option value="<c:out value="${supportedLanguage.languageId}"/>" <c:out value="${languageSelected}"/> >
																	<c:out value="${supportedLanguage.nativeDescriptionString}"/>
																</option>
																--%>
															</c:forEach>
														  </select>
														</td>
													</tr>
												</table>
												</form>
												<%-- 
												  ***
												  * During registration, user is required to specify the preferred language.
												  * After logon, the language of the next page will change based on the previously specified preferred language.
												  * Note: For example, even if french is selected in this page, the page after logon will be english if the user's preferred language is english.
												  ***
												--%>
												<c:choose>
													<c:when test="${!empty WCParam.URL}">
														<c:set var="continueAfterLogonURL" value="${WCParam.URL}"/>
													</c:when>
													<c:otherwise>
														<c:set var="continueAfterLogonURL" value="StoreCatalogDisplay"/>
													</c:otherwise>
												</c:choose>
												<form method="post" name="Logon" action="Logon" id="Logon">
												<input type="hidden" name="storeId" value="<c:out value="${storeId}" />" id="WC_UserLogonForm_FormInput_storeId_In_Logon_1"/>
												<input type="hidden" name="catalogId" value="<c:out value="${catalogId}" />" id="WC_UserLogonForm_FormInput_catalogId_In_Logon_1"/>
												<input type="hidden" name="reLogonURL" value="LogonForm" id="WC_UserLogonForm_FormInput_reLogonURL_In_Logon_1"/>
												<input type="hidden" name="URL" value="<c:out value="${continueAfterLogonURL}"/>" id="WC_UserLogonForm_FormInput_URL_In_Logon_1"/>
											
												<table cellpadding="0" cellspacing="0" border="0" id="WC_UserLogonForm_Table_5">
													<tr>
														<td class="logonheading" id="WC_UserLogonForm_TableCell_13">
															<label for="WC_UserLogonForm_FormInput_logonId_In_LogonForm_1">
																<fmt:message key="Logon_UserID" bundle="${storeText}" />
															</label>
														</td>
													</tr>
													<tr>
														<td id="WC_UserLogonForm_TableCell_14">
															<input type="text" size="25" class="logon" name="logonId" id="WC_UserLogonForm_FormInput_logonId_In_LogonForm_1" onfocus="this.onkeypress = pressEnter;"/>
														</td>
													</tr>
													<tr>
														<td class="logonheading" id="WC_UserLogonForm_TableCell_15">
															<label for="WC_UserLogonForm_FormInput_logonPassword_In_LogonForm_1">
																<fmt:message key="Logon_Password" bundle="${storeText}" />
															</label>
														</td>
													</tr>
													<tr>
														<td id="WC_UserLogonForm_TableCell_16">
															<input type="password" size="25" class="logon" name="logonPassword" id="WC_UserLogonForm_FormInput_logonPassword_In_LogonForm_1" onfocus="this.onkeypress = pressEnter;"/>
														</td>
													</tr>
													<tr>
														<td id="WC_UserLogonForm_TableCell_17">
															<c:url var="ResetPasswordFormURL" value="ResetPasswordForm">
																<c:param name="langId" value="${langId}" />
																<c:param name="storeId" value="${storeId}" />
																<c:param name="catalogId" value="${catalogId}" />
															</c:url>
															<a href="<c:out value="${ResetPasswordFormURL}" />" id="WC_UserLogonForm_Link_1" class="logon">
																<fmt:message key="Logon_Forgot" bundle="${storeText}" />
															</a>
														</td>
													</tr>
												</table>
												</form>
												<table cellpadding="0" cellspacing="0" border="0" id="WC_UserLogonForm_Table_6">
													<tr>
														<td valign="bottom" class="button" id="WC_UserLogonForm_TableCell_18">
															<a href="javascript:document.Logon.submit()" class="button" id="WC_UserLogonForm_Link_2"><fmt:message key="Logon_Submit" bundle="${storeText}" /></a>
														</td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<td id="WC_UserLogonForm_TableCell_19">
												<%-- DISPLAY AWAITING APPROVAL MESSAGE --%>
												<c:if test="${(!empty WCParam.page) && (WCParam.page == 'account') }">
													<table class="noBorder" width="285" id="WC_UserLogonForm_Table_8a">
														<tr>
															<td class="warning" id="WC_UserLogonForm_TableCell_19a">
																<fmt:message key="Logon_WaitingForApproval" bundle="${storeText}" />
															</td>
														</tr>
													</table>
												</c:if>
												<%-- DISPLAY ERROR MESSAGES --%>
												<c:if test="${!empty errorMessage}">
													<table class="noBorder" width="285" id="WC_UserLogonForm_Table_8b">
														<tr>
															<td class="warning" id="WC_UserLogonForm_TableCell_19b">
																<c:out value="${errorMessage}" />
															</td>
														</tr>
													</table>
												</c:if>
												<%-- DISPLAY GUEST USER LIMITED. REGISTRATION REQUIRED MESSAGE --%>
												<c:if test="${!empty WCParam.URL}">
													<table class="noBorder" width="285" id="WC_UserLogonForm_Table_8c">
														<tr>
															<td class="warning" id="WC_UserLogonForm_TableCell_19c">
																<fmt:message key="Logon_RegistrationRequired" bundle="${storeText}" />
															</td>
														</tr>
													</table>
												</c:if>
											</td>
										</tr>
									</table>
								</td>
								<td width="10" valign="middle" id="WC_UserLogonForm_TableCell_20">
									<img src="<c:out value="${jspStoreImgDir}" />images/logon_v_line.gif" alt="" width="1" height="190" border="0"/>
								</td>
								<td width="50%" valign="top" id="WC_UserLogonForm_TableCell_21">
									<table cellpadding="0" cellspacing="0" border="0" id="WC_UserLogonForm_Table_9">
										<tr>
											<td class="logontitle" id="WC_UserLogonForm_TableCell_22"><span class="logontitle">+</span><fmt:message key="Logon_Register" bundle="${storeText}" /></td>
										</tr>
										<%-- 
										  ***
										  * Start: User Registration
										  * Show descriptive text and button for user registration.
										  ***
										--%>
										<tr>
											<td class="logonspacing" id="WC_UserLogonForm_TableCell_23">
												<table cellpadding="0" cellspacing="0" border="0" id="WC_UserLogonForm_Table_10">
													<tr>
														<td class="logontxt" id="WC_UserLogonForm_TableCell_24">
															<fmt:message key="Logon_RegisterUserText" bundle="${storeText}" />
														</td>
														<td id="WC_UserLogonForm_TableCell_24a" width="20">
															&nbsp;
														</td>
													</tr>
													<tr>
														<td class="logontxt" id="WC_UserLogonForm_TableCell_25">
															&nbsp;
														</td>
														<td id="WC_UserLogonForm_TableCell_25a">
															&nbsp;
														</td>
													</tr>
												</table>
												<table cellpadding="0" cellspacing="0" border="0" id="WC_UserLogonForm_Table_11">
													<tr>
														<td valign="bottom" class="button" id="WC_UserLogonForm_TableCell_26">
															<c:url var="UserRegistrationFormURL" value="UserRegistrationForm">
																<c:param name="langId" value="${langId}" />
																<c:param name="storeId" value="${storeId}" />
																<c:param name="catalogId" value="${catalogId}" />
																<c:param name="new" value="Y" />
															</c:url>
															<a href="<c:out value="${UserRegistrationFormURL}" />" class="button" id="WC_UserLogonForm_Link_3">
																<fmt:message key="Logon_RegisterUser" bundle="${storeText}" />
															</a>
														</td>
													</tr>
												</table>
											</td>
										</tr>
										<%-- 
										  ***
										  * End: User Registration
										  ***
										--%>
										<%-- 
										  ***
										  * Start: Organization Registration
										  * Show descriptive text and button for organization registration.
										  ***
										--%>
										<tr>
											<td class="logonspacing" id="WC_UserLogonForm_TableCell_27">
												<table cellpadding="2" cellspacing="0" border="0" id="WC_UserLogonForm_Table_12">
													<tr>
														<td class="logontxt" id="WC_UserLogonForm_TableCell_28">
															<fmt:message key="Logon_RegisterOrganizationText" bundle="${storeText}" />
														</td>
														<td id="WC_UserLogonForm_TableCell_28a" width="20">
															&nbsp;
														</td>
													</tr>
													<tr>
														<td class="logontxt" id="WC_UserLogonForm_TableCell_29">
															&nbsp;
														</td>
														<td id="WC_UserLogonForm_TableCell_29a" width="20">
															&nbsp;
														</td>
													</tr>
												</table>
												<table cellpadding="0" cellspacing="0" border="0" id="WC_UserLogonForm_Table_13">
													<tr>
														<td valign="bottom" class="button" id="WC_UserLogonForm_TableCell_30">
															<c:url var="OrganizationRegistrationAddFormURL" value="OrganizationRegistrationAddForm">
																<c:param name="langId" value="${langId}" />
																<c:param name="storeId"   value="${WCParam.storeId}"  />
																<c:param name="catalogId" value="${WCParam.catalogId}"/>
															</c:url>
															<a class="button" href="<c:out value="${OrganizationRegistrationAddFormURL}"/>" id="WC_UserLogonForm_Link_4">
																<fmt:message key="Logon_RegisterOrganization" bundle="${storeText}"/>
															</a>	
														</td>
													</tr>
												</table>
											</td>
										</tr>
										<%-- 
										  ***
										  * End: Organization Registration
										  ***
										--%>
									</table>
								</td>
							</tr>
							<tr>
								<td colspan="3" align="center" class="logontxt" id="WC_UserLogonForm_TableCell_30_1">
									<fmt:message key="Logon_Disclaimer" bundle="${storeText}"/>
								</td>
							</tr>
							<tr>
								<td id="WC_UserLogonForm_TableCell_31_1">&nbsp;</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</td>
		<td width="40%" id="WC_UserLogonForm_TableCell_32">&nbsp;</td>
	</tr>
</table>

<script language="javascript" src="<c:out value="${jspStoreImgDir}javascript/CheckBrowserVersion.js"/>"></script>

<script language="javascript">

if(browser=="Netscape Navigator" && version <= 7) {
	alert("<fmt:message key="Logon_UnsupportedBrowser" bundle="${storeText}"/>");
}

</script>

</body>
<!-- END UserLogonForm.jsp -->
</html>
	
