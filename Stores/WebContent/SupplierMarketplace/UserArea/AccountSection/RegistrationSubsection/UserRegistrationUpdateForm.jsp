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
  *  - preferred currency
  *  - preferred language
  *  - title
  *  - first name
  *  - last name
  *  - address
  *  - city
  *  - state/province
  *  - country/region
  *  - zip/postal code
  *  - e-mail address
  *  - phone number
  *  - fax number
  *****
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
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

function submitForm(form, reloadtype) {
    if (reloadtype == undefined) {
	if(form.challengeQuestion.value==""){
			alert("<fmt:message key="OrderSum_Err_RequiredField" bundle="${storeText}"><fmt:param><fmt:message key="Reg_ChallengeQuestion" bundle="${storeText}" /></fmt:param></fmt:message>");
			return;
	}else if(form.challengeAnswer.value==""){
			alert("<fmt:message key="OrderSum_Err_RequiredField" bundle="${storeText}"><fmt:param><fmt:message key="Reg_ChallengeAnswer" bundle="${storeText}" /></fmt:param></fmt:message>");
			return;
		  }
	if     (!isValidUTF8length(form.firstName.value    , 50 )) { alert("<fmt:message key="Reg_ERROR_FirstNameTooLong"     bundle="${storeText}"/>"); }
	else if(!isValidUTF8length(form.lastName.value     , 50 )) { alert("<fmt:message key="Reg_ERROR_LastNameTooLong"      bundle="${storeText}"/>"); }
	
	else if(!isValidUTF8length(form.address1.value     , 50 )) { alert("<fmt:message key="Reg_ERROR_AddressTooLong"       bundle="${storeText}"/>"); }
	else if(!isValidUTF8length(form.address2.value     , 50 )) { alert("<fmt:message key="Reg_ERROR_AddressTooLong"       bundle="${storeText}"/>"); }
	else if(!isValidUTF8length(form.city.value         , 128)) { alert("<fmt:message key="Reg_ERROR_CityTooLong"          bundle="${storeText}"/>"); }
	else if(!isValidUTF8length(form.state.value        , 128)) { alert("<fmt:message key="Reg_ERROR_StateTooLong"         bundle="${storeText}"/>"); }
	else if(!isValidUTF8length(form.country.value      , 128)) { alert("<fmt:message key="Reg_ERROR_CountryTooLong"       bundle="${storeText}"/>"); }
	else if(!isValidUTF8length(form.zipCode.value      , 40 )) { alert("<fmt:message key="Reg_ERROR_ZipCodeTooLong"       bundle="${storeText}"/>"); }
	
	else if(!isValidUTF8length(form.email1.value       , 256)) { alert("<fmt:message key="Reg_ERROR_EmailTooLong"         bundle="${storeText}"/>"); }
	else if(!isValidUTF8length(form.email2.value       , 256)) { alert("<fmt:message key="Reg_ERROR_EmailTooLong"         bundle="${storeText}"/>"); }
	else if(!isValidUTF8length(form.phone1.value       , 32 )) { alert("<fmt:message key="Reg_ERROR_PhoneTooLong"         bundle="${storeText}"/>"); }
	else if(!isValidUTF8length(form.phone2.value       , 32 )) { alert("<fmt:message key="Reg_ERROR_PhoneTooLong"         bundle="${storeText}"/>"); }
	else if(!isValidUTF8length(form.fax1.value         , 32 )) { alert("<fmt:message key="Reg_ERROR_FaxTooLong"           bundle="${storeText}"/>"); }
	else if(!isValidUTF8length(form.fax2.value         , 32 )) { alert("<fmt:message key="Reg_ERROR_FaxTooLong"           bundle="${storeText}"/>"); }
	
	else {
		//verify address fields #1-#2, if #2 is filled and not #1 then move the data for the user
		if(form.address1.value == "" && form.address2.value != "") {
			form.address1.value = form.address2.value;
			form.address2.value = "";
		}
		form.submit();
	}
    }
    else
    {
    	form.reloadStates.value='true';
    	form.action='UserRegistrationForm';
	form.submit();
    }	
}


</script>



<table class="noBorder" cellpadding="0" cellspacing="12" id="WC_UserRegistrationUpdateForm_Table_1">

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
	<td id="WC_UserRegistrationUpdateForm_TableCell_7"><strong><fmt:message key="UsrReg_OrgName" bundle="${storeText}"/></strong></td>
	<td width="12" id="WC_UserRegistrationUpdateForm_TableCell_8"></td>
	<td id="WC_UserRegistrationUpdateForm_TableCell_9"><c:out value="${parentOrg.orgEntityName}"/></td>
</tr>
<tr>
	<td id="WC_UserRegistrationUpdateForm_TableCell_4"><strong><fmt:message key="Upreg_LAST_SUCCESSFUL_LOGIN" bundle="${storeText}"/></strong></td>
	<td width="12" id="WC_UserRegistrationUpdateForm_TableCell_5"></td>
	<td id="WC_UserRegistrationUpdateForm_TableCell_6"><fmt:formatDate type="both" value="${CommandContext.user.lastSessionInEJBType}"/></td>
</tr>
<tr>
	<td id="WC_UserRegistrationUpdateForm_TableCell_10"><strong><fmt:message key="UsrUpt_Roles" bundle="${storeText}"/></strong></td>
	<td width="12" id="WC_UserRegistrationUpdateForm_TableCell_11"></td>
	<td id="WC_UserRegistrationUpdateForm_TableCell_12">
		<c:forEach items="${userReg.roles}" var="roleId" varStatus="status">
			<wcbase:useBean id="role" classname="com.ibm.commerce.user.beans.RoleDataBean">
				<c:set target="${role}" property="dataBeanKeyRoleId" value="${roleId}"/>
			</wcbase:useBean>
			<c:out value="${role.displayName}"/><c:if test="${!status.last}">,</c:if>
			<c:remove var="role"/>
		</c:forEach>
	</td>
</tr>
</table>

</td></tr>



<tr><td id="WC_UserRegistrationUpdateForm_TableCell_13">

<form name="UserRegistrationUpdateForm" method="post" action="BuyerUserRegistrationUpdate" id="UserRegistrationUpdateForm">

<input type="hidden" name="storeId"   value="<c:out value="${WCParam.storeId}"  />" id="WC_UserRegistrationUpdateForm_FormInput_storeId_1"  />
<input type="hidden" name="catalogId" value="<c:out value="${WCParam.catalogId}"/>" id="WC_UserRegistrationUpdateForm_FormInput_catalogId_1"/>

<input type="hidden" name="URL" value="LogonForm" id="WC_UserRegistrationUpdateForm_FormInput_URL_1"/>

<%--<input type="hidden" name="errorViewName" value="UserRegistrationUpdateForm" id="WC_UserRegistrationUpdateForm_FormInput_errorViewName_1"/> --%>

<input type="hidden" name="registerType" value="<c:out value="${userReg.registerType}"/>" id="WC_UserRegistrationUpdateForm_FormInput_registerType_1"/>
<input type="hidden" name="profileType"  value="<c:out value="${userReg.profileType}" />" id="WC_UserRegistrationUpdateForm_FormInput_profileType_1" />
<input type="hidden" name="reloadStates" value="" id="WC_UserRegistrationUpdateForm_FormInput_reloadStates_1"/>
<input type="hidden" name="authToken" value="${authToken}" id="WC_UserRegistrationUpdateForm_FormInput_authToken_1"/>

<c:set var="paramPrefix" value="" scope="request"/>
<c:set var="pageName" value="UserRegistrationUpdateForm" scope="request"/>
<c:set var="formName" value="document.UserRegistrationUpdateForm" scope="request"/>
<c:set var="memberAttributeAction" value="r" scope="request"/>

<c:choose>
	<c:when test="${empty storeError.key && empty WCParam.reloadStates}">
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



<table class="noBorder" width="350" cellpadding="2" cellspacing="4" id="WC_UserRegistrationUpdateForm_Table_3">



<tr>
	<td colspan="2" id="WC_UserRegistrationAddForm_TableCell_12_9"><hr class="logon" width="570"/></td>
</tr>
<tr>
	<td class="logontxt" colspan="2" id="WC_UserRegistrationAddForm_TableCell_12_10">
		<fmt:message key="UsrReg_Text3" bundle="${storeText}"/>
	</td>
</tr>



<%--
  ***
  *	Start: Password/challenge question/answer section
  ***
--%>
<tr>
	<td class="logonheading" id="WC_UserRegistrationUpdateForm_TableCell_14"><span class="reqd">*</span><label for="WC_UserRegistrationUpdateForm_FormInput_logonPassword_1"><fmt:message key="Reg_Password" bundle="${storeText}"/></label></td>
	<td class="logonheading" id="WC_UserRegistrationUpdateForm_TableCell_15"><span class="reqd">*</span><label for="WC_UserRegistrationUpdateForm_FormInput_logonPasswordVerify_1"><fmt:message key="Reg_Verify" bundle="${storeText}"/></label></td>
</tr>
<tr>
	<td id="WC_UserRegistrationUpdateForm_TableCell_16">
		<input class="logon" type="password" maxlength="40" size="20" name="logonPassword" value="<c:out value="${logonPassword}"/>" id="WC_UserRegistrationUpdateForm_FormInput_logonPassword_1"/>
	</td>
	<td id="WC_UserRegistrationUpdateForm_TableCell_17">
		<input class="logon" type="password" maxlength="40" size="20" name="logonPasswordVerify" value="<c:out value="${logonPasswordVerify}"/>" id="WC_UserRegistrationUpdateForm_FormInput_logonPasswordVerify_1"/>
	</td>
</tr>

<tr>
	<td class="logonheading" id="WC_UserRegistrationUpdateForm_TableCell_17b"><span class="reqd">*</span><label for="WC_UserRegistrationUpdateForm_FormInput_challengeQuestion_1"><fmt:message key="Reg_ChallengeQuestion" bundle="${storeText}"/></label></td>
	<td class="logonheading" id="WC_UserRegistrationUpdateForm_TableCell_18b"><span class="reqd">*</span><label for="WC_UserRegistrationUpdateForm_FormInput_challengeAnswer_1"><fmt:message key="Reg_ChallengeAnswer" bundle="${storeText}"/></label></td>
</tr>
<tr>
	<td id="WC_UserRegistrationAddForm_TableCell_19b">	
		<fmt:message key="Reg_ChallengeQuestion1" bundle="${storeText}" var="Reg_ChallengeQuestion1"/>
		<fmt:message key="Reg_ChallengeQuestion2" bundle="${storeText}" var="Reg_ChallengeQuestion2"/>
		<fmt:message key="Reg_ChallengeQuestion3" bundle="${storeText}" var="Reg_ChallengeQuestion3"/>
		<select class="logon" name="challengeQuestion" id="WC_UserRegistrationUpdateForm_FormInput_challengeQuestion_1">
			<option value="Reg_ChallengeQuestion1" <c:if test="${challengeQuestion == 'Reg_ChallengeQuestion1'}"> selected="selected"</c:if>><c:out value="${Reg_ChallengeQuestion1}"/></option>
			<option value="Reg_ChallengeQuestion2" <c:if test="${challengeQuestion == 'Reg_ChallengeQuestion2'}"> selected="selected"</c:if>><c:out value="${Reg_ChallengeQuestion2}"/></option>
			<option value="Reg_ChallengeQuestion3" <c:if test="${challengeQuestion == 'Reg_ChallengeQuestion3'}"> selected="selected"</c:if>><c:out value="${Reg_ChallengeQuestion3}"/></option>
		</select>	
	</td>
	<td id="WC_UserRegistrationAddForm_TableCell_20b">
		<input type="text" class="logon" name="challengeAnswer" value="<c:out value="${challengeAnswer}"/>" maxlength="40" size="25" id="WC_UserRegistrationUpdateForm_FormInput_challengeAnswer_1"/>
	</td>
</tr>
<%--
  ***
  *	End: Password/challenge question/answer section
  ***
--%>



<tr>
	<td class="logonheading" id="<c:out value="WC_${pageName}_MiscEntryForm_TableCell_5"/>">
		<span class="reqd">*</span><fmt:message key="Reg_Curr" bundle="${storeText}"/>
	</td>
	<td class="logonheading" id="<c:out value="WC_${pageName}_MiscEntryForm_TableCell_6"/>">
		<span class="reqd">*</span><fmt:message key="Reg_Lang" bundle="${storeText}"/>
	</td>
</tr>
<tr>
	<td id="<c:out value="WC_${pageName}_MiscEntryForm_TableCell_7"/>">
		<c:set var="preferredCurrency" value="${paramSource.preferredCurrency}"/>
		<c:if test="${empty preferredCurrency}">
			<c:set var="preferredCurrency" value="${CommandContext.currency}"/>
		</c:if>
		<label for = "<c:out value="WC_${pageName}_MiscEntryForm_FormInput_${paramPrefix}preferredCurrency_1"/>"/>
		<select class="logon" name="<c:out value="${paramPrefix}preferredCurrency"/>" id="<c:out value="WC_${pageName}_MiscEntryForm_FormInput_${paramPrefix}preferredCurrency_1"/>">
		<c:forEach items="${sdb.storeCurrencies}" var="currency">
			<option value="<c:out value="${currency.currencyCode}"/>"<c:if test="${currency.currencyCode == preferredCurrency}"> selected="selected"</c:if>>
				<c:out value="${currency.currencyDescription}"/>
			</option>
		</c:forEach>
		</select>
	</td>
	<td id="<c:out value="WC_${pageName}_MiscEntryForm_TableCell_8"/>">
		<c:set var="preferredLanguage" value="${paramSource.preferredLanguage}"/>
		<c:if test="${empty preferredLanguage}">
			<c:set var="preferredLanguage" value="${CommandContext.languageId}"/>
		</c:if>
		<label for = "<c:out value="WC_${pageName}_MiscEntryForm_FormInput_${paramPrefix}preferredLanguage_1"/>"/>
		<select class="logon" name="<c:out value="${paramPrefix}preferredLanguage"/>" id="<c:out value="WC_${pageName}_MiscEntryForm_FormInput_${paramPrefix}preferredLanguage_1"/>">
		<c:forEach items="${sdb.languageDataBeans}" var="language">
			<option value="<c:out value="${language.languageId}"/>"<c:if test="${language.languageId == preferredLanguage}"> selected="selected"</c:if>>
				<c:out value="${language.descriptionString}"/>
			</option>
		</c:forEach>
		</select>
	</td>
</tr>



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



<tr>
	<td colspan="2" id="WC_UserRegistrationAddForm_TableCell_24_1"><hr class="logon" width="570"/></td>
</tr>
<tr>
	<td class="logontxt" colspan="2" id="WC_UserRegistrationAddForm_TableCell_24_2">
		<fmt:message key="UsrReg_Text4" bundle="${storeText}"/>
	</td>
</tr>



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



<tr>
	<td colspan="2" id="WC_UserRegistrationAddForm_TableCell_26"><hr class="logon" width="570"/></td>
</tr>

<tr>
	<td class="logontxt" style="padding-bottom: 5px" colspan="2" id="WC_UserRegistrationUpdateForm_TableCell_20">
		<a href="javascript:submitForm(document.UserRegistrationUpdateForm)" class="button" id="WC_UserRegistrationUpdateForm_Link_1"><fmt:message key="Upreg_Update" bundle="${storeText}"/></a>
	</td>
</tr>

</table>

</form>

</td></tr>

</table>

<%@ include file="../../../include/LayoutContainerBottom.jspf" %>

</body>

</html>
