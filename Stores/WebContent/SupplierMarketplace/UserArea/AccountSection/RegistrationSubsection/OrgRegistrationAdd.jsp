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
  * This page displays the organization registration form. It allows an
  * organization to register by entering the following information:
  *  - organization name
  *  - description
  *  - business category
  *  - address
  *  - city
  *  - state/province
  *  - country/region
  *  - zip/postal code
  *  - phone number
  *  - e-mail address
  *  - registration information of the organization administrator
  *****
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>

<%@ include file="../../../include/JSTLEnvironmentSetup.jspf" %>
<%@ include file="../../../include/ErrorMessageSetup.jspf" %>



<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">



<head>
<title><fmt:message key="OrgReg_Title" bundle="${storeText}"/></title>
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

function submitForm(form, reloadtype) {
    if (reloadtype == undefined) {
	if     (!isValidUTF8length(form.org_address1.value     , 50 )) { alert("<fmt:message key="Reg_ERROR_AddressTooLong"       bundle="${storeText}"/>"); }
	else if(!isValidUTF8length(form.org_address2.value     , 50 )) { alert("<fmt:message key="Reg_ERROR_AddressTooLong"       bundle="${storeText}"/>"); }
	else if(!isValidUTF8length(form.org_city.value         , 128)) { alert("<fmt:message key="Reg_ERROR_CityTooLong"          bundle="${storeText}"/>"); }
	else if(!isValidUTF8length(form.org_state.value        , 128)) { alert("<fmt:message key="Reg_ERROR_StateTooLong"         bundle="${storeText}"/>"); }
	else if(!isValidUTF8length(form.org_country.value      , 128)) { alert("<fmt:message key="Reg_ERROR_CountryTooLong"       bundle="${storeText}"/>"); }
	else if(!isValidUTF8length(form.org_zipCode.value      , 40 )) { alert("<fmt:message key="Reg_ERROR_ZipCodeTooLong"       bundle="${storeText}"/>"); }
	
	else if(!isValidUTF8length(form.org_email1.value       , 256)) { alert("<fmt:message key="Reg_ERROR_EmailTooLong"         bundle="${storeText}"/>"); }
	else if(!isValidUTF8length(form.org_email2.value       , 256)) { alert("<fmt:message key="Reg_ERROR_EmailTooLong"         bundle="${storeText}"/>"); }
	else if(!isValidUTF8length(form.org_phone1.value       , 32 )) { alert("<fmt:message key="Reg_ERROR_PhoneTooLong"         bundle="${storeText}"/>"); }
	else if(!isValidUTF8length(form.org_phone2.value       , 32 )) { alert("<fmt:message key="Reg_ERROR_PhoneTooLong"         bundle="${storeText}"/>"); }
	else if(!isValidUTF8length(form.org_fax1.value         , 32 )) { alert("<fmt:message key="Reg_ERROR_FaxTooLong"           bundle="${storeText}"/>"); }
	else if(!isValidUTF8length(form.org_fax2.value         , 32 )) { alert("<fmt:message key="Reg_ERROR_FaxTooLong"           bundle="${storeText}"/>"); }
	
	else if(!isValidUTF8length(form.usr_firstName.value    , 50 )) { alert("<fmt:message key="Reg_ERROR_FirstNameTooLong"     bundle="${storeText}"/>"); }
	else if(!isValidUTF8length(form.usr_lastName.value     , 50 )) { alert("<fmt:message key="Reg_ERROR_LastNameTooLong"      bundle="${storeText}"/>"); }
	
	else if(!isValidUTF8length(form.usr_address1.value     , 50 )) { alert("<fmt:message key="Reg_ERROR_AddressTooLong"       bundle="${storeText}"/>"); }
	else if(!isValidUTF8length(form.usr_address2.value     , 50 )) { alert("<fmt:message key="Reg_ERROR_AddressTooLong"       bundle="${storeText}"/>"); }
	else if(!isValidUTF8length(form.usr_city.value         , 128)) { alert("<fmt:message key="Reg_ERROR_CityTooLong"          bundle="${storeText}"/>"); }
	else if(!isValidUTF8length(form.usr_state.value        , 128)) { alert("<fmt:message key="Reg_ERROR_StateTooLong"         bundle="${storeText}"/>"); }
	else if(!isValidUTF8length(form.usr_country.value      , 128)) { alert("<fmt:message key="Reg_ERROR_CountryTooLong"       bundle="${storeText}"/>"); }
	else if(!isValidUTF8length(form.usr_zipCode.value      , 40 )) { alert("<fmt:message key="Reg_ERROR_ZipCodeTooLong"       bundle="${storeText}"/>"); }
	
	else if(!isValidUTF8length(form.usr_email1.value       , 256)) { alert("<fmt:message key="Reg_ERROR_EmailTooLong"         bundle="${storeText}"/>"); }
	else if(!isValidUTF8length(form.usr_email2.value       , 256)) { alert("<fmt:message key="Reg_ERROR_EmailTooLong"         bundle="${storeText}"/>"); }
	else if(!isValidUTF8length(form.usr_phone1.value       , 32 )) { alert("<fmt:message key="Reg_ERROR_PhoneTooLong"         bundle="${storeText}"/>"); }
	else if(!isValidUTF8length(form.usr_phone2.value       , 32 )) { alert("<fmt:message key="Reg_ERROR_PhoneTooLong"         bundle="${storeText}"/>"); }
	else if(!isValidUTF8length(form.usr_fax1.value         , 32 )) { alert("<fmt:message key="Reg_ERROR_FaxTooLong"           bundle="${storeText}"/>"); }
	else if(!isValidUTF8length(form.usr_fax2.value         , 32 )) { alert("<fmt:message key="Reg_ERROR_FaxTooLong"           bundle="${storeText}"/>"); }
	
	else {
		
		//verify address fields #1-#2, if #2 is filled and not #1 then move the data for the user
		if (form.org_address1.value == "") {
			if (form.org_address2.value != "") {
				form.org_address1.value = form.org_address2.value;
				form.org_address2.value = "";
			}
		}
		
		if (form.usr_address1.value == "") {
			if (form.usr_address2.value != "") {
				form.usr_address1.value = form.usr_address2.value;
				form.usr_address2.value = "";
			}
		}
		
		var orgRole = form.orgRole.options[form.orgRole.selectedIndex].value;
		form.action = (orgRole == "seller" ? "ResellerRegistrationAdd" : "BuyerRegistrationAdd");
		
	if(form.usr_challengeQuestion.value==""){
			alert("<fmt:message key="OrderSum_Err_RequiredField" bundle="${storeText}"><fmt:param><fmt:message key="Reg_ChallengeQuestion" bundle="${storeText}" /></fmt:param></fmt:message>");
			return;
	}else if(form.usr_challengeAnswer.value==""){
			alert("<fmt:message key="OrderSum_Err_RequiredField" bundle="${storeText}"><fmt:param><fmt:message key="Reg_ChallengeAnswer" bundle="${storeText}" /></fmt:param></fmt:message>");
			return;
	}
		form.submit();
		
	}
    }
    else
    {	form.reloadStates.value=reloadtype;
    	form.action='OrgRegistrationAddForm';
	form.submit();
    }	
}


</script>



<table class="noBorder" cellpadding="0" cellspacing="12" id="WC_OrganizationRegistrationAddForm_Table_1">

<tr><td class="logontxt" id="WC_UserRegistrationAddForm_TableCell_7">
	<h1><fmt:message key="OrgReg_Title" bundle="${storeText}"/></h1>
	<span class="reqd">*</span><fmt:message key="Reg_ReqField" bundle="${storeText}"/>
	<c:if test="${!empty errorMessage}">
		<!-- storeError.key == <c:out value="${storeError.key}"/> -->
		<!-- <c:if test="${!empty invalidParamErrorKey}">invalidParamErrorKey == <c:out value="${invalidParamErrorKey}"/></c:if> -->
		<br/><span class="warning"><c:out value="${errorMessage}"/></span>
	</c:if>
</td></tr>



<tr><td class="logonspacing" id="WC_OrganizationRegistrationAddForm_TableCell_12">

<form name="OrganizationRegistrationAddForm" method="post" action="" id="OrganizationRegistrationAddForm">

<input type="hidden" name="storeId"   value="<c:out value="${WCParam.storeId}"  />" id="WC_OrganizationRegistrationAddForm_FormInput_storeId_1"  />
<input type="hidden" name="catalogId" value="<c:out value="${WCParam.catalogId}"/>" id="WC_OrganizationRegistrationAddForm_FormInput_catalogId_1"/>

<c:url var="url" value="OrgRegistrationAddPendingForApprovalView">
	<c:param name="storeId" value="${storeId}" />
	<c:param name="catalogId" value="${catalogId}" />
	<c:param name="langId" value="${langId}" />
</c:url>

<input type="hidden" name="URL" value="<c:out value="${url}&usr_logonId*=&usr_firstName*=&usr_lastName*=&usr_address1*=&usr_address2*=&usr_city*=&usr_country*=&usr_state*=&usr_zipCode*=&usr_email1*=&usr_phone1*=&org_orgEntityName*=&org_description*=&org_address1*=&org_address2*=&org_city*=&org_country*=&org_state*=&org_zipCode*=&org_email1*=&org_phone1*="/>" id="WC_OrganizationRegistrationAddForm_FormInput_URL_1"/>
<input type="hidden" name="page" value="account" id="WC_OrganizationRegistrationAddForm_FormInput_page_1"/>

<input type="hidden" name="errorViewName" value="OrgRegistrationAddForm" id="WC_OrganizationRegistrationAddForm_FormInput_errorViewName_1"/>
<input type="hidden" name="new" value="Y" id="WC_OrganizationRegistrationAddForm_FormInput_new_1"/>
<input type="hidden" name="reloadStates" value="" id="WC_OrganizationRegistrationAddForm_FormInput_reloadStates_1"/>

<input type="hidden" name="usr_profileType" value="B" id="WC_OrganizationRegistrationAddForm_FormInput_usr_profileType_1"/>


<table cellpadding="0" cellspacing="0" border="0" width="100%" id="WC_OrganizationRegistrationAddForm_Table_5">



<%--
  ***
  *	Start: Organization section
  ***
--%>
<tr>
	<td colspan="2" id="WC_OrganizationRegistrationAddForm_TableCell_13_1"><hr class="logon" width="570"/></td>
</tr>

<tr>
	<td class="logontxt" colspan="2" id="WC_OrganizationRegistrationAddForm_TableCell_13_2">
		<fmt:message key="OrgReg_Text1" bundle="${storeText}"/>
	</td>
</tr>

<tr>
	<td class="logonheading" id="WC_OrganizationRegistrationAddForm_TableCell_14"><span class="reqd">*</span><label for="WC_OrganizationRegistrationAddForm_FormInput_org_orgEntityName_1"><fmt:message key="UsrReg_OrgName" bundle="${storeText}"/></label></td>
	<td class="logonheading" id="WC_OrganizationRegistrationAddForm_TableCell_14_1"><span class="reqd">*</span><label for="WC_OrganizationRegistrationAddForm_FormInput_org_orgEntityName_1"><fmt:message key="UsrReg_OrgRole" bundle="${storeText}"/></label></td>
</tr>
<tr>
	<td id="WC_OrganizationRegistrationAddForm_TableCell_15"><input class="logon" type="text" maxlength="128" size="25" name="org_orgEntityName" value="<c:out value="${WCParam.org_orgEntityName}"/>" id="WC_OrganizationRegistrationAddForm_FormInput_org_orgEntityName_1"/></td>
	<td id="WC_OrganizationRegistrationAddForm_TableCell_15_1">
		<label for="WC_UserRegistrationAddForm_FormInput_orgRole_1"/>
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

<tr><td class="logonheading" colspan="2" id="WC_OrganizationRegistrationAddForm_TableCell_16"><label for="WC_OrganizationRegistrationAddForm_FormInput_org_description_1"><fmt:message key="OrgReg_Description" bundle="${storeText}"/></label></td></tr>
<tr><td colspan="2" id="WC_OrganizationRegistrationAddForm_TableCell_17"><input class="logon" type="text" maxlength="256" size="60" name="org_description" value="<c:out value="${WCParam.org_description}"/>" id="WC_OrganizationRegistrationAddForm_FormInput_org_description_1"/></td></tr>

<tr><td class="logonheading" colspan="2" id="WC_OrganizationRegistrationAddForm_TableCell_18"><label for="WC_OrganizationRegistrationAddForm_FormInput_org_businessCategory_1"><fmt:message key="OrgReg_BusCategory" bundle="${storeText}"/></label></td></tr>
<tr><td colspan="2" id="WC_OrganizationRegistrationAddForm_TableCell_19"><input class="logon" type="text" maxlength="128" size="60" name="org_businessCategory" value="<c:out value="${WCParam.org_businessCategory}"/>" id="WC_OrganizationRegistrationAddForm_FormInput_org_businessCategory_1"/></td></tr>



<jsp:useBean id="orgParamSource" class="java.util.HashMap">
	<c:set target="${orgParamSource}" property="address1"	value="${WCParam.org_address1}"	/>
	<c:set target="${orgParamSource}" property="address2"	value="${WCParam.org_address2}"	/>
	<c:set target="${orgParamSource}" property="city"		value="${WCParam.org_city}"		/>
	<c:set target="${orgParamSource}" property="state"		value="${WCParam.org_state}"	/>
	<c:set target="${orgParamSource}" property="country"	value="${WCParam.org_country}"	/>
	<c:set target="${orgParamSource}" property="zipCode"	value="${WCParam.org_zipCode}"	/>
	<c:set target="${orgParamSource}" property="email1"		value="${WCParam.org_email1}"	/>
	<c:set target="${orgParamSource}" property="email2"		value="${WCParam.org_email2}"	/>
	<c:set target="${orgParamSource}" property="phone1"		value="${WCParam.org_phone1}"	/>
	<c:set target="${orgParamSource}" property="phone2"		value="${WCParam.org_phone2}"	/>
	<c:set target="${orgParamSource}" property="fax1"		value="${WCParam.org_fax1}"		/>
	<c:set target="${orgParamSource}" property="fax2"		value="${WCParam.org_fax2}"		/>
</jsp:useBean>

<c:set var="paramPrefix" value="org_" scope="request"/>
<c:set var="paramSource" value="${orgParamSource}" scope="request"/>
<c:set var="pageName" value="OrganizationRegistrationAddForm" scope="request"/>
<c:set var="formName" value="document.OrganizationRegistrationAddForm" scope="request"/>


<%--
  ***
  *	Start: Organization address section
  ***
--%>
<c:choose>
	<c:when test="${locale == 'ja_JP' || locale == 'ko_KR'}">
		<%@ include file="AddressEntryForm_JP_KR.jspf" %>
	</c:when>
	<c:when test="${locale == 'zh_CN'}">
		<%@ include file="AddressEntryForm_CN.jspf" %>
	</c:when>
	<c:when test="${locale == 'zh_TW'}">
		<%@ include file="AddressEntryForm_TW.jspf" %>
	</c:when>
	<c:when test="${locale == 'de_DE' || locale == 'es_ES' || locale == 'fr_FR' || locale == 'it_IT'}">
		<%@ include file="AddressEntryForm_DE_ES_FR_IT.jspf" %>
	</c:when>
	<c:otherwise>
		<%@ include file="AddressEntryForm.jspf" %>
	</c:otherwise>
</c:choose>
<%--
  ***
  *	End: Organization address section
  ***
--%>



<tr>
	<td colspan="2" id="WC_OrganizationRegistrationAddForm_TableCell_23_1"><hr class="logon" width="570"/></td>
</tr>

<tr>
	<td class="logontxt" colspan="2" id="WC_OrganizationRegistrationAddForm_TableCell_23_2">
		<fmt:message key="OrgReg_Text3" bundle="${storeText}"/>
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



<%--
  ***
  *	End: Organization section
  ***
--%>



<%--
  ***
  *	Start: Organization administrator section
  ***
--%>
<tr>
	<td colspan="2" id="WC_OrganizationRegistrationAddForm_TableCell_24"><hr class="logon" width="570"/></td>
</tr>

<jsp:include page="OrgRegAddFormUserSection.jsp" flush="true"/>
<%--
  ***
  *	End: Organization administrator section
  ***
--%>



<tr>
	<td colspan="2" id="WC_OrganizationRegistrationAddForm_TableCell_25_1"><hr class="logon" width="570"/></td>
</tr>

<tr>
	<td class="logontxt" style="padding-bottom: 5px" colspan="2" id="WC_OrganizationRegistrationAddForm_TableCell_25">
		<a href="javascript:submitForm(document.OrganizationRegistrationAddForm)" class="button" id="WC_OrganizationRegistrationAddForm_Link_3"><fmt:message key="Reg_Submit" bundle="${storeText}"/></a>
	</td>
</tr>

</table>

</form>

</td></tr>

</table>

<%@ include file="../../../include/LayoutContainerBottom.jspf" %>

</body>

</html>
