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
  * This JSP displays the user registration add page for the mobile store front. 
  *****
--%>

<!-- BEGIN UserRegistrationAddForm.jsp -->

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>

<%@ include file="../../../../include/parameters.jspf" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf" %>
<%@ include file="../../../include/ErrorMessageSetup.jspf" %>

<%@ include file="./MandatoryUserRegistrationFields.jspf" %>

<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.2//EN" "http://www.openmobilealliance.org/tech/DTD/xhtml-mobile12.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" lang="${shortLocale}" xml:lang="${shortLocale}">

	<head>

		<title>
			<fmt:message key="MUSREG_TITLE" bundle="${storeText}">
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
			
			<div id="register" class="content_box">
				<div class="heading_container_with_underline">
					<h2><fmt:message key="MUSER_REG" bundle="${storeText}" /></h2>
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
				
				<p class="paragraph_blurb"><fmt:message key="MUSREG_CREATE_MSG1" bundle="${storeText}" /><span class="field_required_symbol">*</span><fmt:message key="MUSREG_CREATE_MSG2" bundle="${storeText}" /></p>
				
				<form id="register_form" method="post" action="PersonProcessServicePersonRegister">
					<input type="hidden" name="new" value="Y" id="WC_MUserRegistrationAddForm_FormInput_new" />
					<input type="hidden" name="storeId" value="<c:out value="${WCParam.storeId}" />" id="WC_MUserRegistrationAddForm_FormInput_storeId" />
					<input type="hidden" name="catalogId" value="<c:out value="${WCParam.catalogId}" />" id="WC_MUserRegistrationAddForm_FormInput_catalogId" />
					<input type="hidden" name="langId" value="<c:out value="${langId}" />" id="WC_MUserRegistrationAddForm__FormInput_langId" />
					<input type="hidden" name="URL" value="mMyAccountDisplay" id="WC_MUserRegistrationAddForm_FormInput_URL" />
					<input type="hidden" name="errorViewName" value="MobileUserRegistrationAddForm" id="WC_MUserRegistrationAddForm_FormInput_errorViewName" />              

					<input type="hidden" name="registerType" value="Guest" id="WC_MUserRegistrationAddForm_FormInput_registerType" />
					<input type="hidden" name="profileType" value="Consumer" id="WC_MUserRegistrationAddForm_FormInput_profileType" />
					<%-- The challenge answer and question are necessary for the forget password feature. Therefore, they are set to "-" here.	--%>
					<input type="hidden" name="challengeQuestion" value="-" id="WC_MUserRegistrationAddForm_FormInput_challengeQuestion" />
					<input type="hidden" name="challengeAnswer" value="-" id="WC_MUserRegistrationAddForm_FormInput_challengeAnswer" />
				
					<input type="hidden" name="addressType" value="SB" id="WC_MUserRegistrationAddForm_FormInput_addressType" />
					<input type="hidden" name="primary" value="true" id="WC_MUserRegistrationAddForm_FormInput_primary" />

					<%@ include file="UserRegistrationAddDefaults.jspf"%>
					
					<%--
					  ***
					  * If an error occurs, the page will refresh and the entry fields will be pre-filled with the previously entered value.
					  * The entry fields below use e.g. paramSource.logonId to get the previously entered value.
					  * In this case, the paramSource is set to WCParam.  
					  ***
					--%>
					<c:set var="paramSource" value="${WCParam}"/>

					<fieldset>
						<div class="input_container">
							<div><label for="WC_MUserRegistrationAddForm_FormInput_logonId"><c:if test="${fn:contains(mandatoryFields, 'logonId')}"><span class="field_required_symbol">*</span></c:if><fmt:message key="MUSREG_LOGONID" bundle="${storeText}" /></label></div>
							<input type="text" id="WC_MUserRegistrationAddForm_FormInput_logonId" name="logonId" value="<c:out value="${paramSource.logonId}" />" class="coloured_input" />	
						</div>
						
						<div class="input_container">
							<div><label for="WC_MUserRegistrationAddForm_FormInput_logonPassword"><c:if test="${fn:contains(mandatoryFields, 'logonPassword')}"><span class="field_required_symbol">*</span></c:if><fmt:message key="MUSREG_PASSWORD" bundle="${storeText}" /></label></div>
							<input type="password" id="WC_MUserRegistrationAddForm_FormInput_logonPassword" name="logonPassword" value="<c:out value="${paramSource.logonPassword}" />" class="coloured_input" />		
						</div>
						
						<div class="input_container">
							<div><label for="WC_MUserRegistrationAddForm_FormInput_logonPasswordVerify"><c:if test="${fn:contains(mandatoryFields, 'logonPasswordVerify')}"><span class="field_required_symbol">*</span></c:if><fmt:message key="MUSREG_VPASSWORD" bundle="${storeText}" /></label></div>
							<input type="password" id="WC_MUserRegistrationAddForm_FormInput_logonPasswordVerify" name="logonPasswordVerify" value="<c:out value="${paramSource.logonPasswordVerify}" />" class="coloured_input" />	
						</div>
						
						<div class="input_container">
							<div><label for="WC_MUserRegistrationAddForm_FormInput_firstName"><c:if test="${fn:contains(mandatoryFields, 'firstName')}"><span class="field_required_symbol">*</span></c:if><fmt:message key="MUSREG_FNAME" bundle="${storeText}" /></label></div>
							<input type="text" id="WC_MUserRegistrationAddForm_FormInput_firstName" name="firstName" value="<c:out value="${paramSource.firstName}" />" class="coloured_input" />	
						</div>
						
						<div class="input_container">
							<div><label for="WC_MUserRegistrationAddForm_FormInput_lastName"><c:if test="${fn:contains(mandatoryFields, 'lastName')}"><span class="field_required_symbol">*</span></c:if><fmt:message key="MUSREG_LNAME" bundle="${storeText}" /></label></div>
							<input type="text" id="WC_MUserRegistrationAddForm_FormInput_lastName" name="lastName" value="<c:out value="${paramSource.lastName}" />" class="coloured_input" />	
						</div>						
												
						<div class="input_container">
							<div><label for="WC_MUserRegistrationAddForm_FormInput_email1"><c:if test="${fn:contains(mandatoryFields, 'email1')}"><span class="field_required_symbol">*</span></c:if><fmt:message key="MUSREG_EMAIL" bundle="${storeText}" /></label></div>
							<input type="text" id="WC_MUserRegistrationAddForm_FormInput_email1" name="email1" value="<c:out value="${paramSource.email1}" />" class="coloured_input" />
						</div>

						<input type="submit" id="submit_registration" name="submit_registration" value="<fmt:message key="MUSREG_SUBMIT" bundle="${storeText}" />" class="submit" />
					</fieldset>
				</form>
			</div>

			<%@ include file="../../../include/FooterDisplay.jspf" %>						
			
		</div>
		
	</body>
	
</html>

<!-- END UserRegistrationAddForm.jsp -->
