<%--
/*
 *-------------------------------------------------------------------
 * Licensed Materials - Property of IBM
 *
 * WebSphere Commerce
 *
 * (c) Copyright International Business Machines Corporation. 2001-2004, 2009
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
  * This page displays the user registration update form. It allows a user to
  * update the following registration information:
  *  - password
  *  - employee ID
  *  - title
  *  - first name
  *  - last name
  *  - address
  *  - city
  *  - state/province
  *  - country/region
  *  - zip/postal code
  *  - phone number
  *  - e-mail address
  *  - preferred currency
  *  - preferred language
  *  - internal mailing address
  *  - job function
  *  - receive email
  *****
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ taglib uri="flow.tld" prefix="flow" %>

<%@ include file="../../../include/JSTLEnvironmentSetup.jspf" %>
<%@ include file="../../../include/ErrorMessageSetup.jspf" %>



<wcbase:useBean id="userReg" classname="com.ibm.commerce.user.beans.UserRegistrationDataBean"/>

<wcbase:useBean id="parentOrg" classname="com.ibm.commerce.user.beans.OrgEntityDataBean">
	<c:set target="${parentOrg}" property="orgEntityId" value="${userReg.parentMemberId}"/>
</wcbase:useBean>



<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">



<head>
<title><fmt:message key="Upreg_Title1" bundle="${storeText}"/></title>
<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${vfileStylesheet}"/>" type="text/css"/>
<style type="text/css">
	form table tr {vertical-align: bottom}

</style>
</head>



<body class="noMargin">

<%@ include file="../../../include/LayoutContainerTop.jspf" %>

<script language="javascript" src="<c:out value="${jspStoreImgDir}javascript/Util.js"/>"></script>

<script language="javascript">

function submitForm(form) {
	<fmt:message key="Reg_ERROR_EmployeeIdTooLong"    bundle="${storeText}" var="Reg_ERROR_EmployeeIdTooLong"/>
	<fmt:message key="Reg_ERROR_FirstNameTooLong"     bundle="${storeText}" var="Reg_ERROR_FirstNameTooLong"/>
	<fmt:message key="Reg_ERROR_LastNameTooLong"      bundle="${storeText}" var="Reg_ERROR_LastNameTooLong"/>
	<fmt:message key="Reg_ERROR_AddressTooLong"       bundle="${storeText}" var="Reg_ERROR_AddressTooLong"/>
	<fmt:message key="Reg_ERROR_CityTooLong"       		bundle="${storeText}" var="Reg_ERROR_CityTooLong"/>
	<fmt:message key="Reg_ERROR_StateTooLong"         bundle="${storeText}" var="Reg_ERROR_StateTooLong"/>
	<fmt:message key="Reg_ERROR_CountryTooLong"       bundle="${storeText}" var="Reg_ERROR_CountryTooLong"/>
	<fmt:message key="Reg_ERROR_ZipCodeTooLong"       bundle="${storeText}" var="Reg_ERROR_ZipCodeTooLong"/>
	<fmt:message key="Reg_ERROR_PhoneTooLong"         bundle="${storeText}" var="Reg_ERROR_PhoneTooLong"/>
	<fmt:message key="Reg_ERROR_EmailTooLong"         bundle="${storeText}" var="Reg_ERROR_EmailTooLong"/>
	<fmt:message key="Reg_ERROR_OfficeAddressTooLong" bundle="${storeText}" var="Reg_ERROR_OfficeAddressTooLong"/>
	if     (!isValidUTF8length(form.employeeId.value   , 20 )) { alert(<wcf:json object="${Reg_ERROR_EmployeeIdTooLong}"/>); }
	
	else if(!isValidUTF8length(form.firstName.value    , 50 )) { alert(<wcf:json object="${Reg_ERROR_FirstNameTooLong}"/>); }
	else if(!isValidUTF8length(form.lastName.value     , 50 )) { alert(<wcf:json object="${Reg_ERROR_LastNameTooLong}"/>); }
	
	else if(!isValidUTF8length(form.address1.value     , 50 )) { alert(<wcf:json object="${Reg_ERROR_AddressTooLong}"/>); }
	else if(!isValidUTF8length(form.address2.value     , 50 )) { alert(<wcf:json object="${Reg_ERROR_AddressTooLong}"/>); }
	else if(!isValidUTF8length(form.city.value         , 128)) { alert(<wcf:json object="${Reg_ERROR_CityTooLong}"/>); }
	else if(!isValidUTF8length(form.state.value        , 128)) { alert(<wcf:json object="${Reg_ERROR_StateTooLong}"/>); }
	else if(!isValidUTF8length(form.country.value      , 128)) { alert(<wcf:json object="${Reg_ERROR_CountryTooLong}"/>); }
	else if(!isValidUTF8length(form.zipCode.value      , 40 )) { alert(<wcf:json object="${Reg_ERROR_ZipCodeTooLong}"/>); }
	
	else if(!isValidUTF8length(form.phone1.value       , 32 )) { alert(<wcf:json object="${Reg_ERROR_PhoneTooLong}"/>); }
	else if(!isValidUTF8length(form.email1.value       , 256)) { alert(<wcf:json object="${Reg_ERROR_EmailTooLong}"/>); }
	else if(!isValidUTF8length(form.officeAddress.value, 256)) { alert(<wcf:json object="${Reg_ERROR_OfficeAddressTooLong}"/>); }
	
	else {
		//verify address fields #1-#2, if #2 is filled and not #1 then move the data for the user
		if(form.address1.value == "" && form.address2.value != "") {
			form.address1.value = form.address2.value;
			form.address2.value = "";
		}

		//simple email check
		<fmt:message key="Reg_ERROR_InvalidEmail" bundle="${storeText}" var="Reg_ERROR_InvalidEmail"/>
		if(form.email1.value != "" && !isValidEmail(form.email1.value)) {
			alert(<wcf:json object="${Reg_ERROR_InvalidEmail}"/>);
			return;
		}
				
		if (form.sendMeEmail.checked) form.receiveEmail.value = true
		else form.receiveEmail.value = false;
		
		form.submit();
	}
}


</script>



<table class="noBorder" cellpadding="0" cellspacing="0" id="WC_UserRegistrationUpdateForm_Table_1">

<tr><td id="WC_UserRegistrationUpdateForm_TableCell_1">
<h1><fmt:message key="Upreg_Title1" bundle="${storeText}"/></h1>
<span class="reqd">*</span><fmt:message key="Reg_ReqField" bundle="${storeText}"/>
</td></tr>



<tr><td id="WC_UserRegistrationUpdateForm_TableCell_2">
	<c:if test="${!empty errorMessage}">
		<!-- storeError.key == <c:out value="${storeError.key}"/> -->
		<!-- <c:if test="${!empty invalidParamErrorKey}">invalidParamErrorKey == <c:out value="${invalidParamErrorKey}"/></c:if> -->
		<span class="warning"><c:out value="${errorMessage}"/></span>
	</c:if>
</td></tr>



<tr><td id="WC_UserRegistrationUpdateForm_TableCell_3">

<table class="noBorder" cellpadding="0" cellspacing="0" id="WC_UserRegistrationUpdateForm_Table_2">
<tr>
	<td id="WC_UserRegistrationUpdateForm_TableCell_4"><strong><fmt:message key="Upreg_UserID" bundle="${storeText}"/></strong></td>
	<td width="12" id="WC_UserRegistrationUpdateForm_TableCell_5"></td>
	<td id="WC_UserRegistrationUpdateForm_TableCell_6"><c:out value="${userReg.logonId}"/></td>
</tr>
<tr>
	<td id="WC_UserRegistrationUpdateForm_TableCell_7"><strong><fmt:message key="Upreg_Buyer" bundle="${storeText}"/></strong></td>
	<td width="12" id="WC_UserRegistrationUpdateForm_TableCell_8"></td>
	<td id="WC_UserRegistrationUpdateForm_TableCell_9"><c:out value="${parentOrg.orgEntityName}"/></td>
</tr>
<tr>
	<td id="WC_UserRegistrationUpdateForm_TableCell_10"><strong><fmt:message key="Upreg_Buyer_ProfileType" bundle="${storeText}"/></strong></td>
	<td width="12" id="WC_UserRegistrationUpdateForm_TableCell_11"></td>
	<td id="WC_UserRegistrationUpdateForm_TableCell_12">
		<c:choose>
			<c:when test="${userReg.profileType == 'B'}">
				<fmt:message key="Upreg_Buyer_ProfileType_B" bundle="${storeText}"/>
			</c:when>
			<c:when test="${userReg.profileType == 'C'}">
				<fmt:message key="Upreg_Buyer_ProfileType_C" bundle="${storeText}"/>
			</c:when>
			<c:otherwise>
				<fmt:message key="Upreg_Buyer_ProfileType_Unknown" bundle="${storeText}"/>
			</c:otherwise>
		</c:choose>
	</td>
</tr>
<tr>
	<td id="WC_UserRegistrationUpdateForm_TableCell_4"><strong><fmt:message key="Upreg_LAST_SUCCESSFUL_LOGIN" bundle="${storeText}"/></strong></td>
	<td width="12" id="WC_UserRegistrationUpdateForm_TableCell_5"></td>
	<td id="WC_UserRegistrationUpdateForm_TableCell_6"><fmt:formatDate type="both" value="${CommandContext.user.lastSessionInEJBType}"/></td>
</tr>
</table>

</td></tr>



<tr><td id="WC_UserRegistrationUpdateForm_TableCell_13">

<form name="UserRegistrationUpdateForm" method="post" action="BuyerUserRegistrationUpdate" id="UserRegistrationUpdateForm">

<input type="hidden" name="storeId"   value="<c:out value="${WCParam.storeId}"  />" id="WC_UserRegistrationUpdateForm_FormInput_storeId_1"  />
<input type="hidden" name="catalogId" value="<c:out value="${WCParam.catalogId}"/>" id="WC_UserRegistrationUpdateForm_FormInput_catalogId_1"/>

<input type="hidden" name="URL" value="UserAccountView" id="WC_UserRegistrationUpdateForm_FormInput_URL_1"/>

<%--<input type="hidden" name="errorViewName" value="UserRegistrationUpdateForm" id="WC_UserRegistrationUpdateForm_FormInput_errorViewName_1"/> --%>

<input type="hidden" name="registerType" value="<c:out value="${userReg.registerType}"/>" id="WC_UserRegistrationUpdateForm_FormInput_registerType_1"/>
<input type="hidden" name="profileType"  value="<c:out value="${userReg.profileType}" />" id="WC_UserRegistrationUpdateForm_FormInput_profileType_1" />
<input type="hidden" name="authToken" value="${authToken}" id="WC_UserRegistrationUpdateForm_FormInput_authToken_1"/>

<c:set var="paramPrefix" value="" scope="request"/>
<c:set var="pageName" value="UserRegistrationUpdateForm" scope="request"/>
<c:set var="formName" value="document.UserRegistrationUpdateForm" scope="request"/>
<c:set var="memberAttributeAction" value="r" scope="request"/>

<c:choose>
	<c:when test="${empty storeError.key}">
		<c:set var="logonPassword" value="${userReg.logonPassword}"/>
		<c:set var="logonPasswordVerify" value="${userReg.logonPassword}"/>
		<c:set var="challengeQuestion" value="${userReg.challengeQuestion}"/>
		<c:set var="challengeAnswer" value="${userReg.challengeAnswer}"/>
		<c:set var="paramSource" value="${userReg}" scope="request"/>
	</c:when>
	<c:otherwise>
		<c:set var="logonPassword" value="${WCParam.logonPassword}"/>
		<c:set var="logonPasswordVerify" value="${WCParam.logonPasswordVerify}"/>
		<c:set var="challengeQuestion" value="${WCParam.challengeQuestion}"/>
		<c:set var="challengeAnswer" value="${WCParam.challengeAnswer}"/>
		<c:set var="paramSource" value="${WCParam}" scope="request"/>
	</c:otherwise>
</c:choose>


<table class="noBorder" cellpadding="0" cellspacing="0" id="WC_UserRegistrationUpdateForm_Table_3">

<%--
  ***
  *	Start: Password/employee ID section
  ***
--%>
<tr>
	<td class="logonheading t_td2" id="WC_UserRegistrationUpdateForm_TableCell_14"><span class="reqd">*</span><label for="WC_UserRegistrationUpdateForm_FormInput_logonPassword_1"><fmt:message key="Reg_Password" bundle="${storeText}"/></label></td>
</tr>
<tr>
	<td id="WC_UserRegistrationUpdateForm_TableCell_16">
		<input class="logon input" type="password" autocomplete="off" maxlength="40" size="35" name="logonPassword" value="<c:out value="${logonPassword}"/>" id="WC_UserRegistrationUpdateForm_FormInput_logonPassword_1"/>
	</td>
</tr>
<tr>
	<td class="logonheading t_td2" id="WC_UserRegistrationUpdateForm_TableCell_15"><span class="reqd">*</span><label for="WC_UserRegistrationUpdateForm_FormInput_logonPasswordVerify_1"><fmt:message key="Reg_Verify" bundle="${storeText}"/></label></td>
</tr>
<tr>
	<td id="WC_UserRegistrationUpdateForm_TableCell_17">
		<input class="logon input" type="password" autocomplete="off" maxlength="40" size="35" name="logonPasswordVerify" value="<c:out value="${logonPasswordVerify}"/>" id="WC_UserRegistrationUpdateForm_FormInput_logonPasswordVerify_1"/>
	</td>
</tr>
<tr>
	<td class="logonheading t_td2" id="WC_UserRegistrationUpdateForm_TableCell_17b"><span class="reqd">*</span><label for="WC_UserRegistrationUpdateForm_FormInput_challengeQuestion_1"><fmt:message key="Reg_ChallengeQuestion" bundle="${storeText}"/></label></td>
</tr>
<tr>
	<td id="WC_UserRegistrationAddForm_TableCell_19b">	
		<fmt:message key="Reg_ChallengeQuestion1" bundle="${storeText}" var="Reg_ChallengeQuestion1"/>
		<fmt:message key="Reg_ChallengeQuestion2" bundle="${storeText}" var="Reg_ChallengeQuestion2"/>
		<fmt:message key="Reg_ChallengeQuestion3" bundle="${storeText}" var="Reg_ChallengeQuestion3"/>
		<select class="logon select" name="challengeQuestion" id="WC_UserRegistrationUpdateForm_FormInput_challengeQuestion_1">
			<option value="Reg_ChallengeQuestion1" <c:if test="${challengeQuestion == 'Reg_ChallengeQuestion1'}"> selected="selected"</c:if>><c:out value="${Reg_ChallengeQuestion1}"/></option>
			<option value="Reg_ChallengeQuestion2" <c:if test="${challengeQuestion == 'Reg_ChallengeQuestion2'}"> selected="selected"</c:if>><c:out value="${Reg_ChallengeQuestion2}"/></option>
			<option value="Reg_ChallengeQuestion3" <c:if test="${challengeQuestion == 'Reg_ChallengeQuestion3'}"> selected="selected"</c:if>><c:out value="${Reg_ChallengeQuestion3}"/></option>
		</select>	
	</td>
</tr>
<tr>
	<td class="logonheading t_td2" id="WC_UserRegistrationUpdateForm_TableCell_18b"><span class="reqd">*</span><label for="WC_UserRegistrationUpdateForm_FormInput_challengeAnswer_1"><fmt:message key="Reg_ChallengeAnswer" bundle="${storeText}"/></label></td>
</tr>
<tr>
	<td id="WC_UserRegistrationAddForm_TableCell_20b">
		<input type="text" class="logon input" name="challengeAnswer" value="<c:out value="${challengeAnswer}"/>" maxlength="40" size="25" id="WC_UserRegistrationUpdateForm_FormInput_challengeAnswer_1"/>
	</td>
</tr>
<tr>
	<td class="logonheading t_td2" colspan="2" id="WC_UserRegistrationUpdateForm_TableCell_18"><span class="reqd">*</span><label for="WC_UserRegistrationUpdateForm_FormInput_employeeId_1"><fmt:message key="Reg_EmpID" bundle="${storeText}"/></label></td>
</tr>
<tr>
	<td colspan="2" id="WC_UserRegistrationUpdateForm_TableCell_19">
		<input class="logon input" type="text" maxlength="20" size="35" name="employeeId" value="<c:out value="${paramSource.employeeId}"/>" id="WC_UserRegistrationUpdateForm_FormInput_employeeId_1"/>
	</td>
</tr>
<%--
  ***
  *	End: Password/employee ID section
  ***
--%>



<%--
  ***
  *	Start: User name/address section
  ***
--%>
<jsp:include page="UserRegUpdateFormNameAddressSection.jsp" flush="true"/>
<%--
  ***
  *	End: User name/address section
  ***
--%>



<%--
  ***
  *	Start: Miscellaneous section (e.g. phone, e-mail address)
  ***
--%>
<%@ include file="MiscEntryForm.jspf" %>
<%--
  ***
  *	End: Miscellaneous section (e.g. phone, e-mail address)
  ***
--%>



</table>

</form>

</td></tr>

<tr><td class="t_td2" id="WC_UserRegistrationUpdateForm_TableCell_20">
<a href="javascript:submitForm(document.UserRegistrationUpdateForm)" class="button" id="WC_UserRegistrationUpdateForm_Link_1"><fmt:message key="Upreg_Update" bundle="${storeText}"/></a>
</td></tr>



</table>

<%@ include file="../../../include/LayoutContainerBottom.jspf" %>

</body>

</html>
