<%
//********************************************************************
//*-------------------------------------------------------------------
//* Licensed Materials - Property of IBM
//*
//* WebSphere Commerce
//*
//* (c) Copyright IBM Corp. 2000, 2002, 2004, 2009
//*
//* US Government Users Restricted Rights - Use, duplication or
//* disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
//*
//*-------------------------------------------------------------------
//*
%>
<%-- 
  *****
  * This JSP will display the change personal information page with the following fields:
  *  - E-mail, Password, Verify password
  *  - First name, Last name
  *  - Preferred language and Preferred currency
  *  - Age and Gender
  *  - Send me e-mail checkbox
  *****
--%>

<!-- Start - JSP File Name:  UserRegistrationUpdateForm.jsp -->

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf" %>
<%@ include file="../../../include/nocache.jspf" %>
<%-- ErrorMessageSetup.jspf is used to retrieve an appropriate error message when there is an error --%>
<%@ include file="../../../include/ErrorMessageSetup.jspf" %>

<%--
  ***
  *	In this edit registration page, the entry fields are pre-filled with the user registration information in the database.
  * To retrieve the user information, the following databeans are activated.
  ***
--%>
<wcbase:useBean id="bnEmailUserReceive" classname="com.ibm.commerce.emarketing.beans.EmailUserReceiveDataBean">
<c:set property="usersId" value="${CommandContext.userId}" target="${bnEmailUserReceive}" />
</wcbase:useBean>

<wcbase:useBean id="bnRegister" classname="com.ibm.commerce.user.beans.UserRegistrationDataBean" />

<%--
  ***
  * If an error occurs, the page will refresh and the entry fields will be pre-filled with the previously entered value.
  * The entry fields below use e.g. paramSource.logonId to get the previously entered value.
  * In the case of error, the paramSource is set to WCParam.  
  * If there is no error, the entry fields are pre-filled with the user registration information in the database.
  * In this case, the paramSource is set to the UserRegistrationDataBean.
  ***
--%>
<c:choose>
	<c:when test="${empty storeError.key}">
		<c:set var="logonPassword" value="${bnRegister.logonPassword}"/>
		<c:set var="logonPasswordVerify" value="${bnRegister.logonPassword}"/>
		<c:set var="paramSource" value="${bnRegister}"/>
	</c:when>
	<c:otherwise>
		<c:set var="logonPassword" value="${WCParam.logonPassword}"/>
		<c:set var="logonPasswordVerify" value="${WCParam.logonPasswordVerify}"/>
		<c:set var="paramSource" value="${WCParam}"/>
	</c:otherwise>
</c:choose>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
	<title><fmt:message key="REGISTER_TITLE" bundle="${storeText}" /></title>
	<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${vfileStylesheet}"/>" type="text/css"/>
</head>
<body>

<%@ include file="../../../include/LayoutContainerTop.jspf"%>

	<!--MAIN CONTENT STARTS HERE-->
	
	<h1><fmt:message key="CHANGE_PERSONAL_INFO" bundle="${storeText}" /></h1>

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

	<form name="Register" method="post" action="UserRegistrationUpdate" id="Register">
	<input type="hidden" name="storeId" value="<c:out value="${WCParam.storeId}"  />" id="WC_UserRegistrationUpdateForm_FormInput_storeId_In_Register_1"/>
	<input type="hidden" name="catalogId" value="<c:out value="${WCParam.catalogId}"  />" id="WC_UserRegistrationUpdateForm_FormInput_catalogId_In_Register_1"/>
	<%-- The parameter "personalizedCatalog" is used by LogonSetup.jsp --%>
	<input type="hidden" name="personalizedCatalog" value="true" id="WC_UserRegistrationUpdateForm_FormInput_personalizedCatalog_In_Register_1"/>
	<input type="hidden" name="URL" value="LogonForm" id="WC_UserRegistrationUpdateForm_FormInput_URL_In_Register_1"/>
	<input type="hidden" name="page" value="account" id="WC_UserRegistrationUpdateForm_FormInput_page_In_Register_1"/>
	<input type="hidden" name="registerType" value="R" id="WC_UserRegistrationUpdateForm_FormInput_registerType_In_Register_1"/>
	<input type="hidden" name="editRegistration" value="Y" id="WC_UserRegistrationUpdateForm_FormInput_editRegistration_In_Register_1"/>
	<input type="hidden" name="authToken" value="${authToken}" id="WC_UserRegistrationUpdateForm_FormInput_authToken_1"/>
	<flow:ifEnabled  feature="EmailOption">
		<input type="hidden" name="receiveEmail" value="" id="WC_UserRegistrationUpdateForm_FormInput_receiveEmail_In_Register_1"/>
	</flow:ifEnabled>
	<table cellpadding="0" cellspacing="0" border="0" class="t_table" id="WC_UserRegistrationUpdateForm_Table_1">
	<tbody>
	<tr>
		<td class="t_td2" id="WC_UserRegistrationUpdateForm_TableCell_0"><fmt:message key="LAST_SUCCESSFUL_LOGIN" bundle="${storeText}" /> <fmt:formatDate type="both" value="${CommandContext.user.lastSessionInEJBType}"/></td>
	</tr>
	
	<tr>
		<td valign="top" id="WC_UserRegistrationUpdateForm_TableCell_1">
			<br/><fmt:message key="NEED_CHANGE_NAME" bundle="${storeText}" />
		</td>
	</tr>
	
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

	<tr>
		<td valign="top" id="WC_UserRegistrationUpdateForm_TableCell_Address_1">
			<br/><fmt:message key="NEED_CHANGE_ADDRESS" bundle="${storeText}" />
		</td>
	</tr>

	<%-- 
	  ***
	  *	Start: AddressEntry Form - Address, City, State/Province, Country/Region and Zip/Postal code fields
	  * The layouts of these entry fields are different depending on the locale.
	  ***
	--%>
	<c:set var="paramPrefix" value="" />
	<c:set var="formName" value="document.Register" />
	<c:set var="pageName" value="UserRegistrationUpdateForm" />
	<%@ include file="../../../Snippets/ReusableObjects/AddressEntryFormDisplay.jspf"%>

	<%-- 
	  ***
	  *	End: AddressEntry Form - Address, City, State/Province, Country/Region and Zip/Postal code fields
	  ***
	--%>

	
	<tr>
		<td id="WC_UserRegistrationUpdateForm_TableCell_2">
			<br/><fmt:message key="NEED_CHANGE_EMAIL" bundle="${storeText}" />
		</td>
	</tr>
	
	<%-- 
	  ***
	  *	Start: Registration Form - E-mail, Password, Verify password
	  ***
	--%>								

	<tr>
		<td class="t_td2" id="WC_UserRegistrationUpdateForm_TableCell_3">
			<span class="required">*</span>
			<label for="WC_UserRegistrationUpdateForm_FormInput_logonId_In_Register_1"><fmt:message key="EMAIL" bundle="${storeText}" /></label>
		</td>
	</tr>
	<tr>
		<td id="WC_UserRegistrationUpdateForm_TableCell_4">
			<input class="input" size="35" maxlength="50" name="email1" id="WC_UserRegistrationUpdateForm_FormInput_logonId_In_Register_1" value="<c:out value="${paramSource.email1}" />"/>
		</td>
	</tr>

	<tr>
		<td id="WC_UserRegistrationUpdateForm_TableCell_5">
			<br/><fmt:message key="WANT_CHANGE_PASS" bundle="${storeText}" />
		</td>
	</tr>
	<tr>
		<td class="t_td2" width="50%" id="WC_UserRegistrationUpdateForm_TableCell_6">
			<label for="WC_UserRegistrationUpdateForm_FormInput_logonPassword_In_Register_1"><fmt:message key="PASSWORD" bundle="${storeText}" /></label>
		</td>
	</tr>
	<tr>
		<td id="WC_UserRegistrationUpdateForm_TableCell_7">
			<input class="input" size="35" maxlength="50" name="logonPassword" type="password" value="" id="WC_UserRegistrationUpdateForm_FormInput_logonPassword_In_Register_1"/>
		</td>
	</tr>
	<tr>
		<td class="t_td2" width="50%" id="WC_UserRegistrationUpdateForm_TableCell_8">
			<label for="WC_UserRegistrationUpdateForm_FormInput_logonPasswordVerify_In_Register_1"><fmt:message key="VERIFY_PASS" bundle="${storeText}" /></label>
		</td>
	</tr>
	<tr>
		<td id="WC_UserRegistrationUpdateForm_TableCell_9">
			<input class="input" size="35" maxlength="50" name="logonPasswordVerify" type="password" value="" id="WC_UserRegistrationUpdateForm_FormInput_logonPasswordVerify_In_Register_1"/>
		</td>
	</tr>

	<%-- 
	  ***
	  *	End: Registration Form - E-mail, Password, Verify password
	  ***
	--%>												

	<%-- 
	  ***
	  *	Start: Language and Currency drop down boxes, Age and Gender selection, Send Me Email checkbox
	  * These selection boxes can be enabled or disabled using the Accelerator.  <flow:ifEnabled> tags are used so that these features are configurable.
	  ***
	--%>
	<flow:ifEnabled feature="preferredLanguage">

	<tr>
		<td id="WC_UserRegistrationUpdateForm_TableCell_10">
			<br/><fmt:message key="WANT_CHANGE_LANG" bundle="${storeText}" />
		</td>
	</tr>
	<tr>
		<td class="t_td2" id="WC_UserRegistrationUpdateForm_TableCell_11">
			<label for="preferredLanguageLabel"><fmt:message key="REGISTER_PREFERREDLANGUAGE" bundle="${storeText}" /></label>
		</td>
	</tr>
	<tr>
		<td id="WC_UserRegistrationUpdateForm_TableCell_12">
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
					<c:when test="${dbLanguage.languageId == paramSource.preferredLanguage}">
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
		<input type="hidden" name="preferredLanguage" value="<c:out value="${paramSource.preferredLanguage}" />" id="WC_UserRegistrationUpdateForm_FormInput_preferredLanguage_In_Register_1"/>
	</flow:ifDisabled>

	<flow:ifEnabled feature="preferredCurrency">
	<tr>
		<td id="WC_UserRegistrationUpdateForm_TableCell_13">
			<br/><fmt:message key="WANT_CHANGE_CURR" bundle="${storeText}" />
		</td>
	</tr>
	<tr>
		<td class="t_td2" id="WC_UserRegistrationUpdateForm_TableCell_14">
			<label for="preferredCurrencyLabel"><fmt:message key="REGISTER_PREFERREDCURRENCY" bundle="${storeText}" /></label>
		</td>
	</tr>
	<tr>
		<td id="WC_UserRegistrationUpdateForm_TableCell_15">
			<select class="select" name="preferredCurrency" id="preferredCurrencyLabel">
			<%--  Get the currencies supported by the store	 --%>
			<c:forEach var="dbCurrency" items="${sdb.storeCurrencies}">
				<c:choose>
				<%-- pre-select the appropriate value in the drop down list. --%>
				<c:when test="${dbCurrency.currencyCode == paramSource.preferredCurrency}">
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
		<input type="hidden" name="preferredCurrency" value="<c:out value="${paramSource.preferredCurrency}" />" id="WC_UserRegistrationUpdateForm_FormInput_preferredCurrency_In_Register_1"/>
	</flow:ifDisabled>

	<flow:ifEnabled feature="Age">
	<%-- 
		The following code will display the description for updating the 
		users demographic information if the feature Age Or Gender is selected 
	--%>
	<tr>
		<td id="WC_UserRegistrationUpdateForm_TableCell_16">
			<br/><fmt:message key="WANT_CHANGE_DEMO" bundle="${storeText}" />
		</td>
	</tr>
	</flow:ifEnabled>

	<flow:ifDisabled feature="Age">
		<flow:ifEnabled feature="Gender">
	<tr>
		<td id="WC_UserRegistrationUpdateForm_TableCell_17">
			<fmt:message key="WANT_CHANGE_DEMO" bundle="${storeText}" />
		</td>
	</tr>
		</flow:ifEnabled>
	</flow:ifDisabled>

	<flow:ifEnabled feature="Age">
	<tr>
		<td class="t_td2" id="WC_UserRegistrationUpdateForm_TableCell_18">
			<label for="ageLabel"><fmt:message key="AGE" bundle="${storeText}" /></label>
		</td>
	</tr>
	<tr>
		<td id="WC_UserRegistrationUpdateForm_TableCell_19">
			<select class="select" name="age" id="ageLabel">
			<%-- pre-select the appropriate value in the drop down list. --%>
			<option <c:if test="${paramSource.age eq '0'}"> selected="selected" </c:if> value="0"><fmt:message key="SELECT_ONE" bundle="${storeText}" /></option>
			<option <c:if test="${paramSource.age eq '1'}"> selected="selected" </c:if> value="1">0-13</option>
			<option <c:if test="${paramSource.age eq '2'}"> selected="selected" </c:if> value="2">14-19</option>
			<option <c:if test="${paramSource.age eq '3'}"> selected="selected" </c:if> value="3">20-29</option>
			<option <c:if test="${paramSource.age eq '4'}"> selected="selected" </c:if> value="4">30-39</option>
			<option <c:if test="${paramSource.age eq '5'}"> selected="selected" </c:if> value="5">40-49</option>
			<option <c:if test="${paramSource.age eq '6'}"> selected="selected" </c:if> value="6">50-59</option>
			<option <c:if test="${paramSource.age eq '7'}"> selected="selected" </c:if> value="7">60+</option>
			</select>
		</td>
	</tr>
	</flow:ifEnabled>
	<flow:ifEnabled feature="Gender">				
	<tr>
		<td class="t_td2" id="WC_UserRegistrationUpdateForm_TableCell_20">
                    <label for="genderLabel">
			<fmt:message key="GENDER" bundle="${storeText}" />
                    </label>
		</td>
	</tr>
	<tr>
		<td id="WC_UserRegistrationUpdateForm_TableCell_21">
			<%-- pre-select the appropriate value in the drop down list. --%>

			<select class="select" name="gender" title="gender" id="genderLabel">
			<option <c:if test="${empty paramSource.gender || paramSource.gender eq 'M'}"> selected="selected" </c:if> value="M"><fmt:message key="MALE" bundle="${storeText}" /></option>
			<option <c:if test="${paramSource.gender eq 'F'}"> selected="selected" </c:if> value="F"><fmt:message key="FEMALE" bundle="${storeText}" /></option>
			</select>

		</td>
	</tr>
	</flow:ifEnabled>

	<%-- 
	  ***
	  *	End: Language and Currency drop down boxes, Age and Gender selection, Send Me Email checkbox
	  ***
	--%>
	<flow:ifEnabled  feature="EmailOption">
	<tr>
		<td id="WC_UserRegistrationUpdateForm_TableCell_22">
			<br/>
			<input type="checkbox" name="sendMeEmail" id="WC_UserRegistrationUpdateForm_FormInput_sendMeEmail_In_Register_1" <c:if test="${bnEmailUserReceive.userReceive}"> checked </c:if> />
			<label for="WC_UserRegistrationUpdateForm_FormInput_sendMeEmail_In_Register_1"><fmt:message key="REGUPDATE_SENDMEEMAIL" bundle="${storeText}" /></label>
		</td>
	</tr>
	</flow:ifEnabled>
	</tbody>
	</table>
	</form>
	<br/>

	<a href="javascript:prepareSubmit(document.Register)" class="button" id="WC_UserRegistrationUpdateForm_Link_1">
		<fmt:message key="SUBMIT" bundle="${storeText}" />
	</a>

	<script type="text/javascript" language="javascript">
	<%-- 
	  ***
	  * This javascript function is used by the update registration 'Submit' button.
	  * This store does not prompt users for the logon ID during registration. 
	  * The email address is treated as the logon ID in our case.
	  * a) This function will set the logon ID and the email address to the same value.
	  * b) If the password fields are empty, this function sets the fields with the values retrieved from UserRegistrationDataBean
	  ***
	 --%>
	function prepareSubmit(form)
	{
		
		if (form.logonPassword.value.length == 0)
		{
			form.logonPassword.value = '<c:out value="${logonPassword}"/>'
		}
		if (form.logonPasswordVerify.value.length == 0)
		{
			form.logonPasswordVerify.value = '<c:out value="${logonPasswordVerify}"/>'
		}
		
		<flow:ifEnabled  feature="EmailOption">
		if (form.sendMeEmail.checked) form.receiveEmail.value = true
		else form.receiveEmail.value = false;
		</flow:ifEnabled>
		
		form.submit()
	}
	
	</script>

	<!-- End Main JSP Content -->
        
<%@ include file="../../../include/LayoutContainerBottom.jspf"%>

</body>
</html>
<!-- End - JSP File Name:  UserRegistrationUpdateForm.jsp -->
