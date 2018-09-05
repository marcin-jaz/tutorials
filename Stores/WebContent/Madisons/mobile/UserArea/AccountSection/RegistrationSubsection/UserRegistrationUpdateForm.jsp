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
  * This JSP displays the user registration update page for the mobile store front. 
  *****
--%>

<!-- BEGIN UserRegistrationUpdateForm.jsp -->

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>

<%@ include file="../../../../include/parameters.jspf" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf" %>
<%@ include file="../../../include/ErrorMessageSetup.jspf" %>

<%@ include file="./MandatoryUserRegistrationFields.jspf" %>

<%-- Required variables for breadcrumb support --%>
<c:set var="accountPageGroup" value="true" scope="request" />
<c:set var="personalInfoDisplayPage" value="true" scope="request" />

<wcf:getData type="com.ibm.commerce.member.facade.datatypes.PersonType" 
	     var="person" expressionBuilder="findCurrentPerson">
       <wcf:param name="accessProfile" value="IBM_All" />
</wcf:getData>

<c:set var="logonId" value="${person.credential.logonID}" />

<c:choose>
	<c:when test="${empty storeError.key}">
		<c:set var="logonPassword" value="${person.credential.password}" />
		<c:set var="logonPasswordVerify" value="${person.credential.password}" />
		<c:set var="firstName" value="${person.contactInfo.contactName.firstName}" />
		<c:set var="lastName" value="${person.contactInfo.contactName.lastName}" />
		<c:set var="email1" value="${person.contactInfo.emailAddress1.value}" />
		<c:set var="preferredLanguage" value="${person.personalProfile.preferredLanguage}" />
		<c:set var="preferredCurrency" value="${person.personalProfile.preferredCurrency}" />
	</c:when>
	<c:otherwise>
		<c:set var="logonPassword" value="${WCParam.logonPassword}"/>
		<c:set var="logonPasswordVerify" value="${WCParam.logonPasswordVerify}"/>
		<c:set var="firstName" value="${WCParam.firstName}" />
		<c:set var="lastName" value="${WCParam.lastName}" />
		<c:set var="email1" value="${WCParam.email1}" />
		<c:set var="preferredLanguage" value="${WCParam.preferredLanguage}" />
		<c:set var="preferredCurrency" value="${WCParam.preferredCurrency}" />
	</c:otherwise>
</c:choose>

<wcf:getData type="com.ibm.commerce.infrastructure.facade.datatypes.ConfigurationType[]"
	     var="currentStoreConfigs" expressionBuilder="findAll">
	<wcf:contextData name="storeId" data="${storeId}"/>
</wcf:getData>

<c:forEach var="config" items="${currentStoreConfigs}">
	<c:if test="${config.configurationIdentifier.uniqueID == 'com.ibm.commerce.foundation.supportedLanguages'}">
		<c:set var="supportedLanguages" value="${config.configurationAttribute}"/>
	</c:if>
</c:forEach>

<c:forEach var="config" items="${currentStoreConfigs}">
	<c:if test="${config.configurationIdentifier.uniqueID == 'com.ibm.commerce.foundation.supportedCurrencies'}">
		<c:set var="supportedCurrencies" value="${config.configurationAttribute}"/>
	</c:if>
</c:forEach>


<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.2//EN" "http://www.openmobilealliance.org/tech/DTD/xhtml-mobile12.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" lang="${shortLocale}" xml:lang="${shortLocale}">

	<head>

		<title>
			<fmt:message key="MUSREGU_TITLE" bundle="${storeText}">
				<fmt:param value="${storeName}" />
			</fmt:message>
		</title>
		
		<meta http-equiv="content-type" content="application/xhtml+xml" />
		<meta http-equiv="cache-control" content="max-age=300" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no" />
	
		<link rel="stylesheet" href="${cssPath}" type="text/css" />

	</head>
	
	<body>
		
		<div id="wrapper">
		
			<%@ include file="../../../include/HeaderDisplay.jspf" %>
			<%@ include file="../../../include/BreadCrumbTrailDisplay.jspf"%>			
			
			<div id="my_account_personal_information" class="content_box">
				<div class="heading_container_with_underline">
					<h2><fmt:message key="MUSER_REGU" bundle="${storeText}" /></h2>
					<div class="clear_float"></div>
				</div>

				<c:choose>
					<c:when test="${!empty errorMessage}">
						<p class="error"><c:out value="${errorMessage}" /></p>
					</c:when>	
					<c:otherwise>
						<c:if test="${!empty storeError.key}">
							<p class="error"><c:out value="${storeError.key}" /></p>
						</c:if>
					</c:otherwise>
				</c:choose>			
				
				<p class="paragraph_blurb"><fmt:message key="MUSREGU_UPDATE_MSG1" bundle="${storeText}" /><span class="field_required_symbol">*</span><fmt:message key="MUSREGU_UPDATE_MSG2" bundle="${storeText}" /></p>

				<form id="my_account_personal_information_form" method="post" action="PersonChangeServicePersonUpdate">
					<input type="hidden" name="storeId" value="${WCParam.storeId}" id="WC_MUserRegistrationUpdateForm_FormInput_storeId" />
					<input type="hidden" name="catalogId" value="${WCParam.catalogId}" id="WC_MUserRegistrationUpdateForm_FormInput_catalogId" />
					<input type="hidden" name="langId" value="${langId}" id="WC_MUserRegistrationUpdateForm_FormInput_langId" />
					<input type="hidden" name="URL" value="mMyAccountDisplay" id="WC_MUserRegistrationUpdateForm_FormInput_URL" />
					<input type="hidden" name="errorViewName" value="MobileUserRegistrationUpdate" id="WC_MUserRegistrationUpdateForm_FormInput_errorViewName" />
					<input type="hidden" name="registerType" value="R" id="WC_MUserRegistrationUpdateForm_FormInput_registerType" />
					<input type="hidden" name="editRegistration" value="Y" id="WC_MUserRegistrationUpdateForm_FormInput_editRegistration" />
					<input type="hidden" name="logonId" value="${logonId}" id="WC_MUserRegistrationUpdateForm_FormInput_logonId" />
					<input type="hidden" name="authToken" value="${authToken}" id="WC_MUserRegistrationUpdateForm_FormInput_authToken" />
					<fieldset>						
						<div class="input_container">
							<div><label for="WC_MUserRegistrationUpdateForm_FormInput_logonPassword"><fmt:message key="MUSREG_PASSWORD" bundle="${storeText}" /></label></div>
							<input type="password" id="WC_MUserRegistrationUpdateForm_FormInput_logonPassword" name="logonPasswordOld" class="coloured_input" value="${logonPassword}" />		
						</div>
						
						<div class="input_container">
							<div><label for="WC_MUserRegistrationUpdateForm_FormInput_logonPasswordVerify"><fmt:message key="MUSREG_VPASSWORD" bundle="${storeText}" /></label></div>
							<input type="password" id="WC_MUserRegistrationUpdateForm_FormInput_logonPasswordVerify" name="logonPasswordVerifyOld" class="coloured_input" value="${logonPasswordVerify}" />	
						</div>
						
						<div class="input_container">
							<div><label for="WC_MUserRegistrationUpdateForm_FormInput_firstName"><c:if test="${fn:contains(mandatoryFields, 'firstName')}"><span class="field_required_symbol">*</span></c:if><fmt:message key="MUSREG_FNAME" bundle="${storeText}" /></label></div>
							<input type="text" id="WC_MUserRegistrationUpdateForm_FormInput_firstName" name="firstName" class="coloured_input" value="${firstName}" />	
						</div>
						
						<div class="input_container">
							<div><label for="WC_MUserRegistrationUpdateForm_FormInput_lastName"><c:if test="${fn:contains(mandatoryFields, 'lastName')}"><span class="field_required_symbol">*</span></c:if><fmt:message key="MUSREG_LNAME" bundle="${storeText}" /></label></div>
							<input type="text" id="WC_MUserRegistrationUpdateForm_FormInput_lastName" name="lastName" class="coloured_input" value="${lastName}" />	
						</div>						
												
						<div class="input_container">
							<div><label for="WC_MUserRegistrationUpdateForm_FormInput_email1"><c:if test="${fn:contains(mandatoryFields, 'email1')}"><span class="field_required_symbol">*</span></c:if><fmt:message key="MUSREG_EMAIL" bundle="${storeText}" /></label></div>
							<input type="text" id="WC_MUserRegistrationUpdateForm_FormInput_email1" name="email1" class="coloured_input" value="${email1}" />
						</div>
					</fieldset>
					
					<fieldset>
						<div class="dropdown_container">
							<div><label for="WC_MUserRegistrationUpdateForm_FormInput_preferredLanguage"><fmt:message key="MUSREG_PREF_LANG" bundle="${storeText}" /></label></div>
							<select id="WC_MUserRegistrationUpdateForm_FormInput_preferredLanguage" name="preferredLanguage" class="coloured_input">
								<c:forEach var="supportedLanguage" items="${supportedLanguages}">
									<c:forEach var="additionalValue" items="${supportedLanguage.additionalValue}">
										<c:if test="${additionalValue.name == 'localeName'}">
											<c:set var="currentLocaleName" value="${additionalValue.value}"/>
										</c:if>
									</c:forEach>
									<c:choose>
										<%-- pre-select the appropriate value in the drop down list. --%>
										<c:when test="${currentLocaleName == preferredLanguage}">
											<option value="${currentLocaleName}" selected="selected"><c:out value="${supportedLanguage.primaryValue.value}" /></option>
										</c:when>
										<c:when test="${currentLocaleName == CommandContext.locale}">
											<option value="${currentLocaleName}" selected="selected"><c:out value="${supportedLanguage.primaryValue.value}" /></option>
										</c:when>
										<c:otherwise>
											<option value="${currentLocaleName}"><c:out value="${supportedLanguage.primaryValue.value}" /></option>
										</c:otherwise>
									</c:choose>
								</c:forEach>
							</select>
						</div>			
												
						<div class="dropdown_container">
							<div><label for="WC_MUserRegistrationUpdateForm_FormInput_preferredCurrency"><fmt:message key="MUSREG_PREF_CURR" bundle="${storeText}" /></label></div>
							<select id="WC_MUserRegistrationUpdateForm_FormInput_preferredCurrency" name="preferredCurrency" class="coloured_input">
								<c:forEach var="supportedCurrency" items="${supportedCurrencies}">
									<c:forEach var="additionalValue" items="${supportedCurrency.additionalValue}">
										<c:if test="${additionalValue.name == 'currencyCode'}">
											<c:set var="currentCurrencyCode" value="${additionalValue.value}"/>
										</c:if>
									</c:forEach>
									<c:choose>
										<%-- pre-select the appropriate value in the drop down list. --%>
										<c:when test="${currentCurrencyCode == preferredCurrency}">
											<option value="${currentCurrencyCode}" selected="selected"><c:out value="${supportedCurrency.primaryValue.value}"/></option>
										</c:when>
										<c:when test="${currentCurrencyCode == CommandContext.currency}">
											<option value="${currentCurrencyCode}" selected="selected"><c:out value="${supportedCurrency.primaryValue.value}"/></option>
										</c:when>
										<c:otherwise>
											<option value="${currentCurrencyCode}"><c:out value="${supportedCurrency.primaryValue.value}"/></option>
										</c:otherwise>
									</c:choose>
								</c:forEach>
							</select>
						</div>			
					</fieldset>
					
					<input type="submit" id="my_account_personal_information_form_submit" name="my_account_personal_information_form_submit" onclick="javascript:checkField(this.form);" value="<fmt:message key="MUSREGU_UPDATE" bundle="${storeText}" />" />
				</form>
			</div>

			<%@ include file="../../../include/FooterDisplay.jspf" %>						
			
		</div>
		
	<script type="text/javascript">
	//<![CDATA[

		function checkField(form) {
			if ((form.logonPasswordOld.value != null && form.logonPasswordOld.value.length > 0)  || 
			    (form.logonPasswordVerifyOld.value != null && form.logonPasswordVerifyOld.value.length > 0)) {
				form.logonPasswordOld.name = "logonPassword";
				form.logonPasswordVerifyOld.name = "logonPasswordVerify";
			}

			// Update the current page language to the selected language preference.
			var selectedLanguageLocale = document.getElementById("WC_MUserRegistrationUpdateForm_FormInput_preferredLanguage").value;
			<c:forEach var="dbLanguage" items="${sdb.languageDataBeans}">
				if("<c:out value="${dbLanguage.localeName}"/>" == selectedLanguageLocale) {
					document.getElementById("WC_MUserRegistrationUpdateForm_FormInput_langId").value = "<c:out value="${dbLanguage.languageId}"/>";
				}
			</c:forEach>

			form.submit();
		}

	//]]> 
	</script>
		
	</body>
	
</html>

<!-- END UserRegistrationUpdateForm.jsp -->
