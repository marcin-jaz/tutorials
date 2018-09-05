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
  * This JSP will display the registration form page with the following fields:
  *  - E-mail, Password, Verify password
  *  - First name, Last name
  *  - Preferred language and Preferred currency
  *  - Age and Gender
  *  - Send me e-mail checkbox
  *****
--%>

<!-- Start - JSP File Name:  UserRegistrationAddForm.jsp -->

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
	<title><fmt:message key="REGISTER_TITLE" bundle="${storeText}" /></title>
	<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${vfileStylesheet}"/>" type="text/css"/>
</head>

<body>

<%@ include file="../../../include/LayoutContainerTop.jspf"%>

	<!--MAIN CONTENT STARTS HERE-->
	
	<h1><fmt:message key="REGISTRATION" bundle="${storeText}" /></h1>

	<%-- 
	  ***
	  *	Start: Error handling
	  * Show an appropriate error message when a user enters invalid information into the form.
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

	<span class="required">*</span>
	<fmt:message key="REQUIRED_FIELDS3" bundle="${storeText}" />

	<form name="Register" method="post" action="UserRegistrationAdd" id="Register">
	<input type="hidden" name="new" value="Y" id="WC_UserRegistrationAddForm_FormInput_new_In_Register_1"/>
	<input type="hidden" name="storeId" value="<c:out value="${WCParam.storeId}"  />" id="WC_UserRegistrationAddForm_FormInput_storeId_In_Register_1"/>
	<input type="hidden" name="catalogId" value="<c:out value="${WCParam.catalogId}"  />" id="WC_UserRegistrationAddForm_FormInput_catalogId_In_Register_1"/>
	<%-- The parameter "personalizedCatalog" is used by LogonSetup.jsp --%>
	<input type="hidden" name="personalizedCatalog" value="true" id="WC_UserRegistrationAddForm_FormInput_personalizedCatalog_In_Register_1"/>
	<input type="hidden" name="URL" value="LogonForm?&logonId*=&firstName*=&lastName*=&address1*=&address2*=&city*=&country*=&state*=&zipCode*=&email1*=&phone1*=" id="WC_UserRegistrationAddForm_FormInput_URL_In_Register_1"/>

	<c:choose>
		<c:when test="${empty WCParam.page}">
			<input type="hidden" name="page" value="account" id="WC_UserRegistrationAddForm_FormInput_page_In_Register_1"/>
		</c:when>
		<c:otherwise>
			<input type="hidden" name="page" value="<c:out value="${WCParam.page}" />" id="WC_UserRegistrationAddForm_FormInput_page_In_Register_1"/>
		</c:otherwise>
	</c:choose>
	<input type="hidden" name="registerType" value="G" id="WC_UserRegistrationAddForm_FormInput_registerType_In_Register_1"/>
	<input type="hidden" name="profileType" value="C" id="WC_UserRegistrationAddForm_FormInput_profileType_In_Register_1"/>
	<flow:ifEnabled  feature="EmailOption">
		<input type="hidden" name="receiveEmail" value="" id="WC_UserRegistrationAddForm_FormInput_receiveEmail_In_Register_1"/>
	</flow:ifEnabled>
	<%-- The challenge answer and question are necessary for the forget password feature. Therefore, they are set to "-" here.	--%>
	<input type="hidden" name="challengeQuestion" value="-" id="WC_UserRegistrationAddForm_FormInput_challengeQuestion_In_Register_1"/>
	<input type="hidden" name="challengeAnswer" value="-" id="WC_UserRegistrationAddForm_FormInput_challengeAnswer_In_Register_1"/>

	<input type="hidden" name="addressType" value="SB" id="WC_UserRegistrationAddForm_FormInput_addressType_In_Register_1"/>
	<input type="hidden" name="primary" value="0" id="WC_UserRegistrationAddForm_FormInput_primary_In_Register_1"/>

	<%--
	  ***
	  * If an error occurs, the page will refresh and the entry fields will be pre-filled with the previously entered value.
	  * The entry fields below use e.g. paramSource.logonId to get the previously entered value.
	  * In this case, the paramSource is set to WCParam.  
	  * In the edit registration page, the entry fields are pre-filled with the user registration information in the database.
	  * In that case, the paramSource is set to the UserRegistrationDataBean.
	  ***
	--%>
	<c:set var="paramSource" value="${WCParam}"/>

	<table cellpadding="0" cellspacing="0" border="0" class="t_table" id="WC_UserRegistrationAddForm_Table_1">
	<tbody>

	<%-- 
	  ***
	  *	Start: Registration Form - Username, Password, Verify password
	  ***
	--%>								
	
	
	<tr>
		<td class="t_td2" valign="top" id="WC_UserRegistrationAddForm_TableCell_1">
			<span class="required">*</span>
			<label for="WC_UserRegistrationAddForm_FormInput_logonId_In_Register_1_1">
				<fmt:message key="LOGON_ID" bundle="${storeText}" />
			</label>
		</td>
	</tr>
	<tr>
		<td id="WC_UserRegistrationAddForm_TableCell_2">
			<input class="input" size="35" maxlength="50" name="logonId" id="WC_UserRegistrationAddForm_FormInput_logonId_In_Register_1_1" value="<c:out value="${paramSource.logonId}"/>"/>
		</td>
	</tr>

	<tr>
		<td class="t_td2" valign="top" id="WC_UserRegistrationAddForm_TableCell_3">
			<span class="required">*</span>
			<label for="WC_UserRegistrationAddForm_FormInput_logonPassword_In_Register_1">
				<fmt:message key="PASSWORD3" bundle="${storeText}" />
			</label>
		</td>
	</tr>
	<tr>
		<td id="WC_UserRegistrationAddForm_TableCell_4">
			<input class="input" size="35" maxlength="50" name="logonPassword" id="WC_UserRegistrationAddForm_FormInput_logonPassword_In_Register_1" type="password" value="<c:out value="${paramSource.logonPassword}"/>"/>
		</td>
	</tr>

	<tr>
		<td class="t_td2" valign="top" id="WC_UserRegistrationAddForm_TableCell_5">
			<span class="required">*</span>
			<label for="WC_UserRegistrationAddForm_FormInput_logonPasswordVerify_In_Register_1">
				<fmt:message key="VERIFY_PASSWORD3" bundle="${storeText}" />
			</label>
		</td>
	</tr>
	<tr>
		<td id="WC_UserRegistrationAddForm_TableCell_6">
			<input class="input" size="35" maxlength="50" name="logonPasswordVerify" id="WC_UserRegistrationAddForm_FormInput_logonPasswordVerify_In_Register_1" type="password" value="<c:out value="${paramSource.logonPasswordVerify}"/>"/>
		</td>
	</tr>

	<%-- 
	  ***
	  *	End: Registration Form - Username, Password, Verify password
	  ***
	--%>								

	<%-- 
	  ***
	  *	Start: Registration Form - First Name and Last Name fields
	  * The layouts of these entry fields are different depending on the locale.
	  ***
	--%>				
	<%@ include file="../../../Snippets/ReusableObjects/NameEntryFormDisplay.jspf"%>

	<%-- 
	  ***
	  *	End: Registration Form - First Name and Last Name fields
	  ***
	--%>												


	<%-- 
	  ***
	  *	Start: AddressEntry Form - Address, City, State/Province, Country/Region and Zip/Postal code fields
	  * The layouts of these entry fields are different depending on the locale.
	  ***
	--%>

	<c:set var="formName" value="document.Register"/>
	<c:set var="paramSource" value="${WCParam}" />
	<c:set var="pageName" value="UserRegistrationAddForm"/>
	<%@ include file="../../../Snippets/ReusableObjects/AddressEntryFormDisplay.jspf"%>

	<%-- 
	  ***
	  *	End: AddressEntry Form - Address, City, State/Province, Country/Region and Zip/Postal code fields
	  ***
	--%>


	<tr>
		<td class="t_td2" valign="top" id="WC_UserRegistrationAddForm_TableCell_7">
			<span class="required">*</span>
			<label for="WC_UserRegistrationAddForm_FormInput_email1_In_Register_1">
				<fmt:message key="EMAIL2" bundle="${storeText}" />
			</label>
		</td>
	</tr>
	<tr>
		<td id="WC_UserRegistrationAddForm_TableCell_8">
			<input class="input" size="35" maxlength="50" name="email1" id="WC_UserRegistrationAddForm_FormInput_email1_In_Register_1" value="<c:out value="${paramSource.email1}"/>"/>
		</td>
	</tr>

	<%-- 
	  ***
	  *	Start: Language and Currency drop down boxes, Age and Gender selection, Send Me Email checkbox
	  * These selection boxes can be enabled or disabled using the Accelerator.  <flow:ifEnabled> tags are used so that these features are configurable.
	  ***
	--%>
	<flow:ifEnabled feature="preferredLanguage">
	<tr>
		<td class="t_td2" id="WC_UserRegistrationAddForm_TableCell_9">
			<label for="preferredLanguageLabel"><fmt:message key="REGISTER_PREFERREDLANGUAGE" bundle="${storeText}" /></label>
		</td>
	</tr>
	<tr>
		<td id="WC_UserRegistrationAddForm_TableCell_10">
			<select class="select" name="preferredLanguage" id="preferredLanguageLabel">
			<%--  Get the languages supported by the store	 --%>
			<c:forEach var="dbLanguage" items="${sdb.languageDataBeans}">
				<c:choose>
					<%-- 
					  ***
					  * First, pre-select the value in paramSource. 
					  * If an error occurs and the page refreshes, paramSource is set to the WCParam.
					  * Otherwise, it is set to the UserRegistrationDataBean (i.e. pre-select based on the information in the database).
					  *** 
					--%>
					<c:when test="${!empty paramSource.preferredLanguage && dbLanguage.languageId == paramSource.preferredLanguage}">
						<option value="<c:out value="${dbLanguage.languageId}" />" selected="selected"><c:out value="${dbLanguage.descriptionString}" /></option>
					</c:when>
					<c:when test="${dbLanguage.languageId == CommandContext.languageId}">
						<option value="<c:out value="${dbLanguage.languageId}" />" selected="selected"><c:out value="${dbLanguage.descriptionString}" /></option>
					</c:when>
					<c:otherwise>
						<option value="<c:out value="${dbLanguage.languageId}" />"><c:out value="${dbLanguage.descriptionString}" /></option>
					</c:otherwise>
				</c:choose>
			</c:forEach>
			</select>		
		</td>
	</tr>	
	</flow:ifEnabled>

	<flow:ifDisabled feature="preferredLanguage">
		<%-- The value is set to the previously entered preferredLanguage if available.  Otherwise, the value is set to the languageId in the CommandContext. --%>
		<input type="hidden" name="preferredLanguage" value="<c:out value="${paramSource.preferredLanguage}" default="${CommandContext.languageId}" />" id="WC_UserRegistrationAddForm_FormInput_preferredLanguage_In_Register_1"/>
	</flow:ifDisabled>

	<flow:ifEnabled feature="preferredCurrency">
	<tr>
		<td class="t_td2" id="WC_UserRegistrationAddForm_TableCell_11">
			<label for="preferredCurrencyLabel"><fmt:message key="REGISTER_PREFERREDCURRENCY" bundle="${storeText}" /></label>
		</td>
	</tr>
	<tr>
		<td id="WC_UserRegistrationAddForm_TableCell_12">
			<select class="select" name="preferredCurrency" id="preferredCurrencyLabel">
			<%--  Get the currencies supported by the store	 --%>
			<c:forEach var="dbCurrency" items="${sdb.storeCurrencies}">
				<c:choose>
					<%-- pre-select the appropriate value in the drop down list. --%>
					<c:when test="${!empty paramSource.preferredCurrency && dbCurrency.currencyCode == paramSource.preferredCurrency}">
						<option value="<c:out value="${dbCurrency.currencyCode}" />" selected="selected"><c:out value="${dbCurrency.currencyDescription}" default="" /></option>
					</c:when>
					<c:when test="${dbCurrency.currencyCode == CommandContext.currency}">
						<option value="<c:out value="${dbCurrency.currencyCode}" />" selected="selected"><c:out value="${dbCurrency.currencyDescription}" default="" /></option>
					</c:when>
					<c:otherwise>
						<option value="<c:out value="${dbCurrency.currencyCode}" />"><c:out value="${dbCurrency.currencyDescription}" default="" /></option>
					</c:otherwise>
				</c:choose>
			</c:forEach>
			</select>
		</td>
	</tr>		
	</flow:ifEnabled>

	<flow:ifDisabled feature="preferredCurrency">
		<%-- The value is set to the previously entered preferredCurrency if available.  Otherwise, the value is set to the currency in the CommandContext. --%>
		<input type="hidden" name="preferredCurrency" value="<c:out value="${paramSource.preferredCurrency}" default="${CommandContext.currency}" />" id="WC_UserRegistrationAddForm_FormInput_preferredCurrency_In_Register_1"/>
	</flow:ifDisabled>

	<flow:ifEnabled feature="Age">
	<tr>
		<td class="t_td2" id="WC_UserRegistrationAddForm_TableCell_13">
			<label for="ageLabel"><fmt:message key="AGE" bundle="${storeText}" /></label>
		</td>
	</tr>
	<tr>
		<td id="WC_UserRegistrationAddForm_TableCell_14">
			<select onchange="javascript:checkAge(document.Register)" class="select" name="age" id="ageLabel">
				<option value="0"><fmt:message key="SELECT_ONE" bundle="${storeText}" /></option>
				<%-- pre-select the appropriate value in the drop down list. --%>
				<option <c:if test="${paramSource.age eq '1'}"> selected="selected" </c:if> value="1">0-13</option>
				<option <c:if test="${paramSource.age eq '2'}"> selected="selected" </c:if> value="2">14-19</option>
				<option <c:if test="${paramSource.age eq '3'}"> selected="selected" </c:if> value="3">20-29</option>
				<option <c:if test="${paramSource.age eq '4'}"> selected="selected" </c:if> value="4">30-39</option>
				<option <c:if test="${paramSource.age eq '5'}"> selected="selected" </c:if> value="5">40-49</option>
				<option <c:if test="${paramSource.age eq '6'}"> selected="selected" </c:if> value="6">50-59</option>
				<option <c:if test="${paramSource.age eq '7'}"> selected="selected" </c:if> value="7">60+</option>
			</select>
			<c:url var="PrivacyViewURL" value="PrivacyView">
				<c:param name="langId" value="${langId}" />
				<c:param name="storeId" value="${WCParam.storeId}" />
				<c:param name="catalogId" value="${WCParam.catalogId}" />
			</c:url>
			<a href="<c:out value="${PrivacyViewURL}"/>" class="f_link" id="WC_UserRegistrationAddForm_PrivacyPolicy_Link_1"><fmt:message key="PRIVACY_POLICY" bundle="${storeText}" /></a>
		</td>
	</tr>
	</flow:ifEnabled>			

	<flow:ifEnabled feature="Gender">
	<tr>
		<td class="t_td2" id="WC_UserRegistrationAddForm_TableCell_15">
			<label for="genderLabel">
			<fmt:message key="GENDER" bundle="${storeText}" />
			</label>
		</td>
	</tr>
	<tr>
		<td id="WC_UserRegistrationUpdateForm_TableCell_16">
		<%-- pre-select the appropriate value in the drop down list. --%>
                <select class="select" name="gender" title="gender" id="genderLabel">
                	<option value="N"><fmt:message key="SELECT_ONE" bundle="${storeText}" /></option>
			<option <c:if test="${paramSource.gender eq 'M'}"> selected="selected" </c:if> value="M"><fmt:message key="MALE" bundle="${storeText}" /></option>
                	<option <c:if test="${paramSource.gender eq 'F'}"> selected="selected" </c:if> value="F"><fmt:message key="FEMALE" bundle="${storeText}" /></option>
                </select>
		</td>
	</tr>
	</flow:ifEnabled>

	<flow:ifEnabled  feature="EmailOption">
	<tr>
		<td id="WC_UserRegistrationAddForm_TableCell_17">
			<br/>
			<c:choose>
				<c:when test="${paramSource.sendMeEmail =='on'}">
					<input type="checkbox" name="sendMeEmail" id="WC_UserRegistrationAddForm_FormInput_sendMeEmail_In_Register_1" checked/>
				</c:when>
				<c:otherwise>
					<input type="checkbox" name="sendMeEmail" id="WC_UserRegistrationAddForm_FormInput_sendMeEmail_In_Register_1" />
				</c:otherwise>
			</c:choose>
			<label for="WC_UserRegistrationAddForm_FormInput_sendMeEmail_In_Register_1">
				<%--
				<fmt:message key="REGNEW_SENDMEEMAIL" bundle="${storeText}" />
				--%>
			</label>
				<c:import url="${jspStoreDir}/Snippets/Marketing/Content/ContentSpotDisplay.jsp">
					<c:param name="spotName" value="RegNew_SendMeEmail" />
					<c:param name="substitutionValues" value="{storeName},${storeName}" />
				</c:import>
		</td>
	</tr>
	</flow:ifEnabled>
	<tr>
		<td id="WC_UserRegistrationAddForm_TableCell_18">
			<br/>
			<c:choose>
				<c:when test="${paramSource.rememberMe =='on'}">
					<input type="checkbox" name="rememberMe" id="WC_UserRegistrationAddForm_FormInput_rememberMe_In_Register_1" checked/>						
				</c:when>
				<c:otherwise>
					<input type="checkbox" name="rememberMe" id="WC_UserRegistrationAddForm_FormInput_rememberMe_In_Register_1" />						
				</c:otherwise>
			</c:choose>
			<label for="WC_UserRegistrationAddForm_FormInput_rememberMe_In_Register_1">
				<fmt:message key="REMEMBER_ME" bundle="${storeText}" />
			</label>
		</td>
	</tr>
	<%-- 
	  ***
	  *	End: Language and Currency drop down boxes, Age and Gender selection, Send Me Email checkbox
	  ***
	--%>

	</tbody>
	</table>
	</form>
	<br/>

	<a href="javascript:prepareSubmit(document.Register)" class="button" id="WC_UserRegistrationAddForm_Link_1">
		<fmt:message key="SUBMIT" bundle="${storeText}" />
	</a>

	<script type="text/javascript" language="javascript">
	<%-- 
	  ***
	  * This javascript function is used by the registration 'Submit' button.
	  * This store does not prompt users for the logon ID during registration. 
	  * The email address is treated as the logon ID in our case.
	  * This function will set the logon ID and the email address to the same value.
	  * Also, receiveEmail is set to true if sendMeEmail check box is checked.
	  ***
	 --%>
	function prepareSubmit(form)
	{
		<flow:ifEnabled  feature="EmailOption">
		if (form.sendMeEmail.checked) form.receiveEmail.value = true
		else form.receiveEmail.value = false;
		</flow:ifEnabled>
		form.submit()
	}
	
	<%-- 
	  ***
	  * This javascript function is used when "Age" option is changed.
	  * This will show one alert message if the user age is under 13. 
	 ***
	 --%>
	function checkAge(form)
	{
		if(form.age.value==1) alert("<fmt:message key="AGE_WARNING_ALERT" bundle="${storeText}"/>");
	}

	</script>

	<!-- End Main JSP Content -->
        
<%@ include file="../../../include/LayoutContainerBottom.jspf"%>

</body>
</html>
<!-- End - JSP File Name:  UserRegistrationAddForm.jsp -->
