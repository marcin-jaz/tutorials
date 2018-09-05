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
  * register under an existing buyer organization by entering the following
  * information:
  *  - user ID
  *  - password
  *  - buyer organization
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

<%
String storeId = request.getParameter("storeId");
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


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">



<head>
<title><fmt:message key="Reg_Title1" bundle="${storeText}"/></title>
<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${vfileStylesheet}"/>" type="text/css"/>
<style type="text/css">
	form table tr {vertical-align: bottom}

</style>
</head>



<body class="logon">

<flow:ifEnabled feature="customerCare">
	<% out.flush(); %>
	<c:import url="${jspStoreDir}include/CustomerCareHeaderSetup.jsp"/>
	<% out.flush(); %>
</flow:ifEnabled>

<script language="javascript" src="<c:out value="${jspStoreImgDir}javascript/Util.js"/>"></script>

<script language="javascript">
var orgPrefix		= "<c:out value="${orgPrefix}" escapeXml="false"/>";
var defaultOrgName	= "<c:out value="${defaultOrgName}" escapeXml="false"/>";
var rootOrgDN		= "<c:out value="${rootOrgDN}" escapeXml="false"/>";

<%--
  ***
  * Constructs the distinguished name of the parent organization from its
  * "slash notation" (e.g. from "Software Group/IBM" to
  * "o=Software Group,o=IBM,o=root organization")
  ***
--%>
function constructParentOrgDN(ancestorOrgs) {
	var parentOrgDN = ancestorOrgs;
	while(true) {
		var n = parentOrgDN.indexOf("/");
		if(n == -1) { break; }
		parentOrgDN = parentOrgDN.substring(0, n) + "," + orgPrefix + parentOrgDN.substring(n + 1, parentOrgDN.length);
	}
	parentOrgDN = orgPrefix + parentOrgDN + rootOrgDN;
	return parentOrgDN;
}

function submitForm(form) {
	<fmt:message key="Reg_ERROR_MissingBuyerOrganization" bundle="${storeText}" var="Reg_ERROR_MissingBuyerOrganization"/>
	if(form.ancestorOrgs.value == "") {
		alert(<wcf:json object="${Reg_ERROR_MissingBuyerOrganization}"/>);
		return;
	}
	
	form.parentMember.value = constructParentOrgDN(form.ancestorOrgs.value);
	
	//if registering under the default org
	if(form.ancestorOrgs.value.toLowerCase() == defaultOrgName.toLowerCase()) {
		//switch profile type from "B" to "C"
		//form.profileType.value = "C";
		alert(<wcf:json object="${Reg_ERROR_MissingBuyerOrganization}"/>);
		form.ancestorOrgs.value = "";
		return;
	}
	
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



<!--MAIN CONTENT STARTS HERE-->

<%--
  ***
  *	Start: Logon/registration look and feel
  ***
--%>
<table cellpadding="0" cellspacing="0" border="0" width="100%" id="WC_UserRegistrationAddForm_Table_1">
	<tr>
		<td width="40%" id="WC_UserRegistrationAddForm_TableCell_1">&nbsp;</td>
		<td valign="top" width="600" id="WC_UserRegistrationAddForm_TableCell_2">
			<table cellpadding="0" cellspacing="0" border="0" width="600" id="WC_UserRegistrationAddForm_Table_2">
				<tr>
					<td class="logonTop" id="WC_UserRegistrationAddForm_TableCell_3"><img src="<c:out value="${jspStoreImgDir}" />images/logon_top.gif" alt="" width="600" height="19" border="0"/></td>
				</tr>
				<tr>
					<td class="logonLogo" id="WC_UserRegistrationAddForm_TableCell_4">
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
					<td background="<c:out value="${logonBannerImg}" />" id="WC_UserRegistrationAddForm_TableCell_4.1"><img src="<c:out value="${logonBannerImg}" />" alt="" width="600" height="99" border="0"/></td>
					--%>

					<td style="background-image: url(<c:out value="${jspStoreImgDir}${vfileColor}" />register_image.jpg)"  id="WC_UserRegistrationAddForm_TableCell_4.1"><img src="<c:out value="${jspStoreImgDir}${vfileColor}" />register_image.jpg" alt="" width="600" height="99" border="0"/></td>
				</tr>
				<tr>
					<td class="logonwhite" width="600" id="WC_UserRegistrationAddForm_TableCell_5">
						<table cellpadding="0" cellspacing="0" border="0" id="WC_UserRegistrationAddForm_Table_3">
							<tr>
								<td class="logontitle" id="WC_UserRegistrationAddForm_TableCell_6"><span class="logontitle">+</span>
									<fmt:message key="Reg_Title1" bundle="${storeText}" />
								</td>
							</tr>
<%--
  ***
  *	End: Logon/registration look and feel
  ***
--%>



<tr><td class="logontxt" id="WC_UserRegistrationAddForm_TableCell_7">
	<span class="reqd">*</span><fmt:message key="Reg_ReqField" bundle="${storeText}"/>
	<c:if test="${!empty errorMessage}">
		<!-- storeError.key == <c:out value="${storeError.key}"/> -->
		<!-- <c:if test="${!empty invalidParamErrorKey}">invalidParamErrorKey == <c:out value="${invalidParamErrorKey}"/></c:if> -->
		<br/><span class="warning"><c:out value="${errorMessage}"/></span>
	</c:if>
</td></tr>

<tr>
	<td id="WC_UserRegistrationAddForm_TableCell_8"><hr class="logon" width="580"/></td>
</tr>



<flow:ifEnabled feature="customerCare">
<c:if test="${liveHelp}">

<tr><td id="WC_UserRegistrationAddForm_TableCell_9">

<table class="noBorder" width="200" cellpadding="0" cellspacing="4" id="WC_UserRegistrationAddForm_Table_4">
<tr>
	<td width="0%" id="WC_UserRegistrationAddForm_TableCell_10">
		<a href="javascript:if(parent.sametime != null) { top.interact(); }" id="WC_UserRegistrationAddForm_Link_1">
			<img src="<c:out value="${jspStoreImgDir}images/LiveHelp.gif"/>"/>
		</a>
	</td>
	<td id="WC_UserRegistrationAddForm_TableCell_11">
		<a href="javascript:if(parent.sametime != null) { top.interact(); }" id="WC_UserRegistrationAddForm_Link_2">
			<fmt:message key="LiveHelp" bundle="${storeText}"/>
		</a>
	</td>
</tr>
</table>

</td></tr>

</c:if>
</flow:ifEnabled>



<tr><td class="logonspacing" id="WC_UserRegistrationAddForm_TableCell_12">

<form name="UserRegistrationAddForm" method="post" action="UserRegistrationAdd" id="UserRegistrationAddForm">

<input type="hidden" name="storeId"   value="<c:out value="${WCParam.storeId}"  />" id="WC_UserRegistrationAddForm_FormInput_storeId_1"  />
<input type="hidden" name="catalogId" value="<c:out value="${WCParam.catalogId}"/>" id="WC_UserRegistrationAddForm_FormInput_catalogId_1"/>

<c:url var="url" value="StoreView">
	<c:param name="storeId" value="${storeId}" />
	<c:param name="catalogId" value="${catalogId}" />
	<c:param name="langId" value="${langId}" />
	<c:param name="page" value="account" />
</c:url>

<input type="hidden" name="URL" value="<c:out value="${url}&logonId*=&firstName*=&lastName*=&address1*=&address2*=&city*=&country*=&state*=&zipCode*=&email1*=&phone*="/>" id="WC_UserRegistrationAddForm_FormInput_URL_1"/>
<input type="hidden" name="page" value="account" id="WC_UserRegistrationAddForm_FormInput_page_1"/>

<%--<input type="hidden" name="errorViewName" value="UserRegistrationAddForm" id="WC_UserRegistrationAddForm_FormInput_errorViewName_1"/> --%>   
<input type="hidden" name="new" value="Y" id="WC_UserRegistrationAddForm_FormInput_new_1"/>

<input type="hidden" name="parentMember" value="" id="WC_UserRegistrationAddForm_FormInput_parentMember_1"/>
<input type="hidden" name="registerType" value="G" id="WC_UserRegistrationAddForm_FormInput_registerType_1"/>
<input type="hidden" name="profileType" value="B" id="WC_UserRegistrationAddForm_FormInput_profileType_1"/>
<input type="hidden" name="authToken" value="${authToken}" id="WC_UserRegistrationAddForm_FormInput_authToken_1"/>
<input type="hidden" name="isBuyerUser" value="true" id="WC_UserRegistrationAddForm_FormInput_isBuyerUser_1"/>


<table cellpadding="0" cellspacing="0" border="0" width="100%" id="WC_UserRegistrationAddForm_Table_5">



<%--
  ***
  *	Start: User ID/password/buyer organization/employee ID section
  ***
--%>
<tr>
	<td class="logonheading t_td2" id="WC_UserRegistrationAddForm_TableCell_13"><span class="reqd">*</span><label for="WC_UserRegistrationAddForm_FormInput_logonId_1"><fmt:message key="Reg_UserID" bundle="${storeText}"/></label></td>
</tr>
<tr>
	<td id="WC_UserRegistrationAddForm_TableCell_15">
		<input type="text" class="logon input" maxlength="80" size="35" name="logonId" value="<c:out value="${WCParam.logonId}"/>" id="WC_UserRegistrationAddForm_FormInput_logonId_1"/>
	</td>
</tr>
<tr>
	<td class="logonheading t_td2" id="WC_UserRegistrationAddForm_TableCell_17"><span class="reqd">*</span><label for="WC_UserRegistrationAddForm_FormInput_logonPassword_1"><fmt:message key="Reg_Password" bundle="${storeText}"/></label></td>
</tr>
<tr>
	<td id="WC_UserRegistrationAddForm_TableCell_19">
		<input type="password" autocomplete="off" class="logon input" maxlength="40" size="35" name="logonPassword" value="<c:out value="${WCParam.logonPassword}"/>" id="WC_UserRegistrationAddForm_FormInput_logonPassword_1"/>
	</td>
</tr>
<tr>
	<td class="logonheading t_td2" id="WC_UserRegistrationAddForm_TableCell_18"><span class="reqd">*</span><label for="WC_UserRegistrationAddForm_FormInput_logonPasswordVerify_1"><fmt:message key="Reg_Verify" bundle="${storeText}"/></label></td>
</tr>
<tr>
	<td id="WC_UserRegistrationAddForm_TableCell_20">
		<input type="password" autocomplete="off" class="logon input" maxlength="40" size="35" name="logonPasswordVerify" value="<c:out value="${WCParam.logonPasswordVerify}"/>" id="WC_UserRegistrationAddForm_FormInput_logonPasswordVerify_1"/>
	</td>
</tr>
<tr>
	<td class="logonheading t_td2" id="WC_UserRegistrationAddForm_TableCell_17b"><span class="reqd">*</span><label for="WC_UserRegistrationAddForm_FormInput_challengeQuestion_1"><fmt:message key="Reg_ChallengeQuestion" bundle="${storeText}"/></label></td>
</tr>
<tr>
	<td id="WC_UserRegistrationAddForm_TableCell_19b">	
		<fmt:message key="Reg_ChallengeQuestion1" bundle="${storeText}" var="Reg_ChallengeQuestion1"/>
		<fmt:message key="Reg_ChallengeQuestion2" bundle="${storeText}" var="Reg_ChallengeQuestion2"/>
		<fmt:message key="Reg_ChallengeQuestion3" bundle="${storeText}" var="Reg_ChallengeQuestion3"/>
		<select class="logon select" name="challengeQuestion" id="WC_UserRegistrationAddForm_FormInput_challengeQuestion_1">
			<option value="Reg_ChallengeQuestion1" <c:if test="${WCParam.challengeQuestion == 'Reg_ChallengeQuestion1'}"> selected="selected"</c:if>><c:out value="${Reg_ChallengeQuestion1}"/></option>
			<option value="Reg_ChallengeQuestion2" <c:if test="${WCParam.challengeQuestion == 'Reg_ChallengeQuestion2'}"> selected="selected"</c:if>><c:out value="${Reg_ChallengeQuestion2}"/></option>
			<option value="Reg_ChallengeQuestion3" <c:if test="${WCParam.challengeQuestion == 'Reg_ChallengeQuestion3'}"> selected="selected"</c:if>><c:out value="${Reg_ChallengeQuestion3}"/></option>
		</select>	
	</td>
</tr>
<tr>
	<td class="logonheading t_td2" id="WC_UserRegistrationAddForm_TableCell_18b"><span class="reqd">*</span><label for="WC_UserRegistrationAddForm_FormInput_challengeAnswer_1"><fmt:message key="Reg_ChallengeAnswer" bundle="${storeText}"/></label></td>
</tr>
<tr>
	<td id="WC_UserRegistrationAddForm_TableCell_20b">
		<input type="text" class="logon input" name="challengeAnswer" value="<c:out value="${WCParam.challengeAnswer}"/>" maxlength="40" size="35" id="WC_UserRegistrationAddForm_FormInput_challengeAnswer_1"/>
	</td>
</tr>
<tr>
	<td class="logonheading t_td2" id="WC_UserRegistrationAddForm_TableCell_21">
		<span class="reqd">*</span><fmt:message key="Reg_Buyer" bundle="${storeText}"/><br/>
		<label for="WC_UserRegistrationAddForm_FormInput_ancestorOrgs_1"><fmt:message key="Reg_BuyOrgStructure" bundle="${storeText}"/></label>
	</td>
</tr>
<tr>
	<td id="WC_UserRegistrationAddForm_TableCell_23">
		<input type="text" class="logon input" maxlength="100" size="35" name="ancestorOrgs" value="<c:out value="${WCParam.ancestorOrgs}"/>" id="WC_UserRegistrationAddForm_FormInput_ancestorOrgs_1"/>
	</td>
</tr>
<tr>
	<td class="logonheading t_td2" id="WC_UserRegistrationAddForm_TableCell_22"><span class="reqd">*</span><label for="WC_UserRegistrationAddForm_FormInput_employeeId_1"><fmt:message key="Reg_EmpID" bundle="${storeText}"/></label></td>
</tr>
<tr>
	<td id="WC_UserRegistrationAddForm_TableCell_24">
		<input type="text" class="logon input" maxlength="20" size="35" name="employeeId" value="<c:out value="${WCParam.employeeId}"/>" id="WC_UserRegistrationAddForm_FormInput_employeeId_1"/>
	</td>
</tr>

<%--
  ***
  *	End: User ID/password/buyer organization/employee ID section
  ***
--%>



<c:set var="paramPrefix" value="" scope="request"/>
<c:set var="paramSource" value="${WCParam}" scope="request"/>
<c:set var="pageName" value="UserRegistrationAddForm" scope="request"/>
<c:set var="formName" value="document.UserRegistrationAddForm" scope="request"/>
<c:set var="memberAttributeAction" value="a" scope="request"/>


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



<tr>
	<td colspan="2" valign="bottom" id="WC_UserRegistrationAddForm_TableCell_27">
		<table cellpadding="0" cellspacing="0" border="0" id="WC_UserRegistrationAddForm_Table_6">
			<tr>
				<td valign="bottom" class="button" id="WC_UserRegistrationAddForm_TableCell_28">
					<br/>
					<a href="javascript:submitForm(document.UserRegistrationAddForm)" class="button" id="WC_UserRegistrationAddForm_Link_3"><fmt:message key="Reg_Submit" bundle="${storeText}"/></a>
				</td>
			</tr>
		</table>
	</td>
</tr>

</table>

</form>

</td></tr>

<%--
  ***
  *	Start: Link back to Logon page
  ***
--%>

<tr>	
	<td id="WC_UserRegistrationAddForm_TableCell_29"><hr width="580" class="logon" /></td>
</tr>
<tr>
	<td class="logontitle" id="WC_UserRegistrationAddForm_TableCell_30"><span class="logontitle">+</span><fmt:message key="Logon_Title" bundle="${storeText}" /></td>
</tr>
<tr>
	<td class="logonspacing" id="WC_UserRegistrationAddForm_TableCell_31">
		<table cellpadding="0" cellspacing="0" border="0" id="WC_UserRegistrationAddForm_Table_6">
			<tr>
				<td class="logontxt" id="WC_UserRegistrationAddForm_TableCell_32">
					<fmt:message key="Logoff_LogonLink" bundle="${storeText}">
						<fmt:param value="${storeName}"/>
					</fmt:message>
				</td>
			</tr>
		</table>
		<br/>
		<table cellpadding="0" cellspacing="0" border="0" id="WC_UserRegistrationAddForm_Table_7">
			<tr>
				<td class="button" id="WC_UserRegistrationAddForm_TableCell_33">
					<c:url var="LogonFormURL" value="LogonForm">
						<c:param name="storeId" value="${storeId}" />
						<c:param name="langId" value="${langId}" />
						<c:param name="catalogId" value="${catalogId}" />
					</c:url>
					<a href="<c:out value="${LogonFormURL}"/>" class="button" id="WC_UserRegistrationAddForm_Link_4">
						<fmt:message key="Logon_Title" bundle="${storeText}" />
					</a>
				</td>
			</tr>
		</table>
	</td>
</tr>

<%--
  ***
  *	End: Link back to Logon page
  ***
--%>

<%--
  ***
  *	Start: Logon/registration look and feel
  ***
--%>
						</table>
					</td>
				</tr>
				<tr>
					<td id="WC_UserRegistrationAddForm_TableCell_34"><img src="<c:out value="${jspStoreImgDir}" />images/logon_bottom.gif" alt="" width="600" height="19" border="0"/></td>
				</tr>
			</table>
		</td>
		<td width="40%" id="WC_UserRegistrationAddForm_TableCell_35">&nbsp;</td>
	</tr>
</table>
<%--
  ***
  *	End: Logon/registration look and feel
  ***
--%>



</body>

</html>
