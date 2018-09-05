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
  * This page displays the user registration form. It allows a user to
  * register under an existing organization by entering the following
  * information:
  *  - organization name
  *  - organization role (i.e. buyer or seller)
  *  - user ID
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

<%
Integer nStoreId = ((com.ibm.commerce.command.CommandContext)request.getAttribute(com.ibm.commerce.server.ECConstants.EC_COMMANDCONTEXT)).getStoreId();
String storeId = nStoreId.toString();
String strRootOrgDN = com.ibm.commerce.member.helpers.MemberRegistrationAttributesHelper.resolveOrgEntityDNFromOrgEntityId(
		com.ibm.commerce.member.helpers.MemberRegistrationAttributesHelper.
			getResolvedParentOrgIdForOrgRegistrationWithQualifier(
				com.ibm.commerce.user.helpers.ECUserConstants.EC_BUYER_REGISTRATION_ROLES_QUALIFIER, 
				storeId));
%>

<wcbase:useBean id="defaultOrg" classname="com.ibm.commerce.user.beans.OrganizationDataBean">
	<c:set target="${defaultOrg}" property="dataBeanKeyMemberId" value="-2000"/>
</wcbase:useBean>

<%--
  ***
  * Identify the following from the distinguished name of the default 
  * organization:
  *  - organization prefix (e.g. "o=")
  *  - name of the default organization (e.g. "default organization")
  *  - distinguished name of the root organization (e.g. ",o=root organization")
  ***
--%>
<c:set var="orgPrefix" value="o="/>
<c:set var="defaultOrgName" value="${defaultOrg.organizationName}"/>
<c:set var="rootOrgDN" value="<%= strRootOrgDN%>"/>
<c:set var="rootOrgDN" value=",${rootOrgDN}"/>


<%
Long nSupplierParentOrgId
	= com.ibm.commerce.member.helpers.MemberRegistrationAttributesHelper.getResolvedParentOrgIdForOrgRegistrationWithQualifier(
		com.ibm.commerce.user.helpers.ECUserConstants.EC_RESELLER_REGISTRATION_ROLES_QUALIFIER,
		nStoreId.toString()
	);
com.ibm.commerce.user.objects.OrganizationAccessBean abSupplierParentOrg
	= new com.ibm.commerce.user.objects.OrganizationAccessBean();
abSupplierParentOrg.setInitKey_MemberId(nSupplierParentOrgId.toString());
String strSupplierParentOrgDN = "," + abSupplierParentOrg.getDistinguishedName();
request.setAttribute("supplierParentOrgDN", strSupplierParentOrgDN);
%>



<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">



<head>
<title><fmt:message key="Reg_Title1" bundle="${storeText}"/></title>
<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${vfileStylesheet}"/>" type="text/css"/>
<style type="text/css">
	form table tr {vertical-align: bottom}
</style>
</head>



<body class="noMargin">

<c:set var="hideSidebar" value="true"/>

<%@ include file="../../../include/LayoutContainerTop.jspf" %>

<script language="javascript" src="<c:out value="${jspStoreImgDir}javascript/Util.js"/>"></script>

<script language="javascript">

var orgPrefix			= "<%= com.ibm.commerce.user.beans.OrganizationDataBean.getOrganizationRDNAttributeName() %>=";
var defaultOrgName		= "<c:out value="${defaultOrgName}"/>";
var buyerParentOrgDN	= "<c:out value="${rootOrgDN}"/>";
var supplierParentOrgDN	= "<c:out value="${supplierParentOrgDN}"/>";

<%--
  ***
  * Constructs the distinguished name of the parent organization from its
  * "slash notation" (e.g. from "Software Group/IBM" to
  * "o=Software Group,o=IBM,o=root organization")
  ***
--%>
function constructParentOrgDN(orgName, orgRole) {
	var parentOrgDN = orgName;
	while(true) {
		var n = parentOrgDN.indexOf("/");
		if(n == -1) { break; }
		parentOrgDN = parentOrgDN.substring(0, n) + "," + orgPrefix + parentOrgDN.substring(n + 1, parentOrgDN.length);
	}
	parentOrgDN = orgPrefix + parentOrgDN + (orgRole == "seller" ? supplierParentOrgDN : buyerParentOrgDN);
	return parentOrgDN;
}

function submitForm(form, reloadtype) {
   if (reloadtype == undefined) {
	if(form.orgName.value == "" || form.orgName.value.toLowerCase() == defaultOrgName.toLowerCase()) {
		alert("<fmt:message key="Reg_ERROR_MissingOrganizationName" bundle="${storeText}"/>");
		return;
	}else if(form.challengeQuestion.value==""){
			alert("<fmt:message key="OrderSum_Err_RequiredField" bundle="${storeText}"><fmt:param><fmt:message key="Reg_ChallengeQuestion" bundle="${storeText}" /></fmt:param></fmt:message>");
			return;
	}else if(form.challengeAnswer.value==""){
			alert("<fmt:message key="OrderSum_Err_RequiredField" bundle="${storeText}"><fmt:param><fmt:message key="Reg_ChallengeAnswer" bundle="${storeText}" /></fmt:param></fmt:message>");
			return;
		  }
	var orgRole = form.orgRole.options[form.orgRole.selectedIndex].value;
	form.parentMember.value = constructParentOrgDN(form.orgName.value, orgRole);
	
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



<!--MAIN CONTENT STARTS HERE-->

<table class="noBorder" cellpadding="0" cellspacing="12" id="WC_UserRegistrationAddForm_Table_1">

<tr><td class="logontxt" id="WC_UserRegistrationAddForm_TableCell_7">
	<h1><fmt:message key="UsrReg_Title" bundle="${storeText}"/></h1>
	<span class="reqd">*</span><fmt:message key="Reg_ReqField" bundle="${storeText}"/>
	<c:if test="${!empty errorMessage}">
		<!-- storeError.key == <c:out value="${storeError.key}"/> -->
		<!-- <c:if test="${!empty invalidParamErrorKey}">invalidParamErrorKey == <c:out value="${invalidParamErrorKey}"/></c:if> -->
		<br/><span class="warning"><c:out value="${errorMessage}"/></span>
	</c:if>
</td></tr>



<tr><td class="logonspacing" id="WC_UserRegistrationAddForm_TableCell_12">

<form name="UserRegistrationAddForm" method="post" action="BuyerUserRegistrationUpdate" id="UserRegistrationAddForm">

<input type="hidden" name="storeId"   value="<c:out value="${WCParam.storeId}"  />" id="WC_UserRegistrationAddForm_FormInput_storeId_1"  />
<input type="hidden" name="catalogId" value="<c:out value="${WCParam.catalogId}"/>" id="WC_UserRegistrationAddForm_FormInput_catalogId_1"/>

<c:url var="url" value="StoreView">
	<c:param name="storeId" value="${storeId}" />
	<c:param name="catalogId" value="${catalogId}" />
	<c:param name="langId" value="${langId}" />
	<c:param name="page" value="account" />
</c:url>

<input type="hidden" name="URL" value="<c:out value="${url}&orgName*=&logonId*=&firstName*=&lastName*=&address1*=&address2*=&city*=&country*=&state*=&zipCode*=&email1*=&phone1*="/>" id="WC_UserRegistrationAddForm_FormInput_URL_1"/>
<input type="hidden" name="page" value="account" id="WC_UserRegistrationAddForm_FormInput_page_1"/>

<%--<input type="hidden" name="errorViewName" value="UserRegistrationAddForm" id="WC_UserRegistrationAddForm_FormInput_errorViewName_1"/> --%>   
<input type="hidden" name="new" value="Y" id="WC_UserRegistrationAddForm_FormInput_new_1"/>

<input type="hidden" name="parentMember" value="" id="WC_UserRegistrationAddForm_FormInput_parentMember_1"/>
<input type="hidden" name="registerType" value="G" id="WC_UserRegistrationAddForm_FormInput_registerType_1"/>
<input type="hidden" name="profileType" value="B" id="WC_UserRegistrationAddForm_FormInput_profileType_1"/>
<input type="hidden" name="reloadStates" value="" id="WC_UserRegistrationAddForm_FormInput_reloadStates_1"/>
<input type="hidden" name="authToken" value="${authToken}" id="WC_UserRegistrationAddForm_FormInput_authToken_1"/>


<table cellpadding="0" cellspacing="0" border="0" width="100%" id="WC_UserRegistrationAddForm_Table_5">



<tr>
	<td colspan="2" id="WC_UserRegistrationAddForm_TableCell_12_1"><hr class="logon" width="570"/></td>
</tr>

<tr>
	<td class="logontxt" colspan="2" id="WC_UserRegistrationAddForm_TableCell_12_2">
		<fmt:message key="UsrReg_Text1" bundle="${storeText}"/>
	</td>
</tr>
<tr>
	<td class="logonheading" width="50%" id="WC_UserRegistrationAddForm_TableCell_12_3"><span class="reqd">*</span><label for="WC_UserRegistrationAddForm_FormInput_orgName_1"><fmt:message key="UsrReg_OrgName" bundle="${storeText}"/></label></td>
	<td class="logonheading" width="50%" id="WC_UserRegistrationAddForm_TableCell_12_4"><span class="reqd">*</span><label for="WC_UserRegistrationAddForm_FormInput_orgRole_1"><fmt:message key="UsrReg_OrgRole" bundle="${storeText}"/></label></td>
</tr>
<tr>
	<td id="WC_UserRegistrationAddForm_TableCell_12_5">
		<input type="text" class="logon" maxlength="128" size="25" name="orgName" value="<c:out value="${WCParam.orgName}"/>" id="WC_UserRegistrationAddForm_FormInput_orgName_1"/>
	</td>
	<td id="WC_UserRegistrationAddForm_TableCell_12_6">
		<select class="logon" name="orgRole" id="WC_UserRegistrationAddForm_FormInput_orgRole_1">
			<option value="buyer"<c:if test="${WCParam.orgRole != 'seller'}"> selected="selected"</c:if>>
				<fmt:message key="OrgReg_Buyer" bundle="${storeText}"/>
			</option>
			<option value="seller"<c:if test="${WCParam.orgRole == 'seller'}"> selected="selected"</c:if>>
				<fmt:message key="OrgReg_Seller" bundle="${storeText}"/>
			</option>
		</select>
	</td>
</tr>
<tr>
	<td class="logontxt" colspan="2" id="WC_UserRegistrationAddForm_TableCell_12_7">
		<br/><fmt:message key="UsrReg_Text2" bundle="${storeText}"/>
	</td>
</tr>
<tr>
	<td class="logontxt" style="padding-top: 8px; padding-bottom: 5px" colspan="2" id="WC_UserRegistrationAddForm_TableCell_12_8">
		<c:url var="orgRegAddFormURL" value="OrgRegistrationAddForm">
			<c:param name="storeId"   value="${WCParam.storeId}"	/>
			<c:param name="catalogId" value="${WCParam.catalogId}"	/>
			<c:param name="langId"    value="${langId}"				/>
		</c:url>
		<a class="button" href="<c:out value="${orgRegAddFormURL}"/>" id="WC_UserRegistrationAddForm_Link_3_1">
			<fmt:message key="UsrReg_Text5" bundle="${storeText}"/>
		</a>
	</td>
</tr>

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
  *	Start: User ID/password/challenge question/answer section
  ***
--%>
<tr>
	<td class="logonheading" width="50%" id="WC_UserRegistrationAddForm_TableCell_13"><span class="reqd">*</span><label for="WC_UserRegistrationAddForm_FormInput_logonId_1"><fmt:message key="Reg_UserID" bundle="${storeText}"/></label></td>
	<td class="logonheading" width="50%" id="WC_UserRegistrationAddForm_TableCell_14">&nbsp;</td>
</tr>
<tr>
	<td id="WC_UserRegistrationAddForm_TableCell_15">
		<input type="text" class="logon" maxlength="80" size="25" name="logonId" value="<c:out value="${WCParam.logonId}"/>" id="WC_UserRegistrationAddForm_FormInput_logonId_1"/>
	</td>
	<td id="WC_UserRegistrationAddForm_TableCell_16">&nbsp;</td>
</tr>

<tr>
	<td class="logonheading" id="WC_UserRegistrationAddForm_TableCell_17"><span class="reqd">*</span><label for="WC_UserRegistrationAddForm_FormInput_logonPassword_1"><fmt:message key="Reg_Password" bundle="${storeText}"/></label></td>
	<td class="logonheading" id="WC_UserRegistrationAddForm_TableCell_18"><span class="reqd">*</span><label for="WC_UserRegistrationAddForm_FormInput_logonPasswordVerify_1"><fmt:message key="Reg_Verify" bundle="${storeText}"/></label></td>
</tr>
<tr>
	<td id="WC_UserRegistrationAddForm_TableCell_19">
		<input type="password" class="logon" maxlength="40" size="25" name="logonPassword" value="<c:out value="${WCParam.logonPassword}"/>" id="WC_UserRegistrationAddForm_FormInput_logonPassword_1"/>
	</td>
	<td id="WC_UserRegistrationAddForm_TableCell_20">
		<input type="password" class="logon" maxlength="40" size="25" name="logonPasswordVerify" value="<c:out value="${WCParam.logonPasswordVerify}"/>" id="WC_UserRegistrationAddForm_FormInput_logonPasswordVerify_1"/>
	</td>
</tr>

<tr>
	<td class="logonheading" id="WC_UserRegistrationAddForm_TableCell_17b"><span class="reqd">*</span><label for="WC_UserRegistrationAddForm_FormInput_challengeQuestion_1"><fmt:message key="Reg_ChallengeQuestion" bundle="${storeText}"/></label></td>
	<td class="logonheading" id="WC_UserRegistrationAddForm_TableCell_18b"><span class="reqd">*</span><label for="WC_UserRegistrationAddForm_FormInput_challengeAnswer_1"><fmt:message key="Reg_ChallengeAnswer" bundle="${storeText}"/></label></td>
</tr>
<tr>
	<td id="WC_UserRegistrationAddForm_TableCell_19b">
		<fmt:message key="Reg_ChallengeQuestion1" bundle="${storeText}" var="Reg_ChallengeQuestion1"/>
		<fmt:message key="Reg_ChallengeQuestion2" bundle="${storeText}" var="Reg_ChallengeQuestion2"/>
		<fmt:message key="Reg_ChallengeQuestion3" bundle="${storeText}" var="Reg_ChallengeQuestion3"/>
		<select class="logon" name="challengeQuestion" id="WC_UserRegistrationAddForm_FormInput_challengeQuestion_1">
			<option value=""<c:if test="${empty WCParam.challengeQuestion}"> selected="selected"</c:if>/>
			<option value="Reg_ChallengeQuestion1"<c:if test="${WCParam.challengeQuestion == 'Reg_ChallengeQuestion1'}"> selected="selected"</c:if>><c:out value="${Reg_ChallengeQuestion1}"/></option>
			<option value="Reg_ChallengeQuestion2"<c:if test="${WCParam.challengeQuestion == 'Reg_ChallengeQuestion2'}"> selected="selected"</c:if>><c:out value="${Reg_ChallengeQuestion2}"/></option>
			<option value="Reg_ChallengeQuestion3"<c:if test="${WCParam.challengeQuestion == 'Reg_ChallengeQuestion3'}"> selected="selected"</c:if>><c:out value="${Reg_ChallengeQuestion3}"/></option>
		</select>
	</td>
	<td id="WC_UserRegistrationAddForm_TableCell_20b">
		<input type="text" class="logon" name="challengeAnswer" value="<c:out value="${WCParam.challengeAnswer}"/>" maxlength="40" size="25" id="WC_UserRegistrationAddForm_FormInput_challengeAnswer_1"/>
	</td>
</tr>



<%--
  ***
  *	End: User ID/password/challenge question/answer section
  ***
--%>



<c:set var="paramPrefix" value="" scope="request"/>
<c:set var="paramSource" value="${WCParam}" scope="request"/>
<c:set var="pageName" value="UserRegistrationAddForm" scope="request"/>
<c:set var="formName" value="document.UserRegistrationAddForm" scope="request"/>
<c:set var="memberAttributeAction" value="a" scope="request"/>



<tr>
	<td class="logonheading" id="<c:out value="WC_${pageName}_MiscEntryForm_TableCell_5"/>">
		<span class="reqd">*</span><label for ="<c:out value="WC_${pageName}_MiscEntryForm_FormInput_${paramPrefix}preferredCurrency_1"/>"><fmt:message key="Reg_Curr" bundle="${storeText}"/></label>
	</td>
	<td class="logonheading" id="<c:out value="WC_${pageName}_MiscEntryForm_TableCell_6"/>">
		<span class="reqd">*</span><label for ="<c:out value="WC_${pageName}_MiscEntryForm_FormInput_${paramPrefix}preferredLanguage_1"/>"><fmt:message key="Reg_Lang" bundle="${storeText}"/></label>
	</td>
</tr>
<tr>
	<td id="<c:out value="WC_${pageName}_MiscEntryForm_TableCell_7"/>">
		<c:set var="preferredCurrency" value="${paramSource.preferredCurrency}"/>
		<c:if test="${empty preferredCurrency}">
			<c:set var="preferredCurrency" value="${CommandContext.currency}"/>
		</c:if>
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
	<td class="logontxt" style="padding-bottom: 5px" colspan="2" id="WC_UserRegistrationAddForm_TableCell_27">
		<a href="javascript:submitForm(document.UserRegistrationAddForm)" class="button" id="WC_UserRegistrationAddForm_Link_3"><fmt:message key="Reg_Submit" bundle="${storeText}"/></a>
	</td>
</tr>

</table>

</form>

</td></tr>

</table>

<%@ include file="../../../include/LayoutContainerBottom.jspf" %>

</body>

</html>
