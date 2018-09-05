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
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
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



<body class="logon">

<flow:ifEnabled feature="customerCare">
	<% out.flush(); %>
	<c:import url="${jspStoreDir}include/CustomerCareHeaderSetup.jsp"/>
	<% out.flush(); %>
</flow:ifEnabled>

<script language="javascript" src="<c:out value="${jspStoreImgDir}javascript/Util.js"/>"></script>

<script language="javascript">

function submitForm(form, reloadtype) {
    if (reloadtype == undefined) {

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
	if(!isValidUTF8length(form.org_address1.value     , 50 )) { alert(<wcf:json object="${Reg_ERROR_AddressTooLong}"/>); }
	else if(!isValidUTF8length(form.org_address2.value     , 50 )) { alert(<wcf:json object="${Reg_ERROR_AddressTooLong}"/>); }
	else if(!isValidUTF8length(form.org_city.value         , 128)) { alert(<wcf:json object="${Reg_ERROR_CityTooLong}"/>); }
	else if(!isValidUTF8length(form.org_state.value        , 128)) { alert(<wcf:json object="${Reg_ERROR_StateTooLong}"/>); }
	else if(!isValidUTF8length(form.org_country.value      , 128)) { alert(<wcf:json object="${Reg_ERROR_CountryTooLong}"/>); }
	else if(!isValidUTF8length(form.org_zipCode.value      , 40 )) { alert(<wcf:json object="${Reg_ERROR_ZipCodeTooLong}"/>); }
	
	else if(!isValidUTF8length(form.org_phone1.value       , 32 )) { alert(<wcf:json object="${Reg_ERROR_PhoneTooLong}"/>); }
	else if(!isValidUTF8length(form.org_email1.value       , 256)) { alert(<wcf:json object="${Reg_ERROR_EmailTooLong}"/>); }
	
	else if(!isValidUTF8length(form.usr_employeeId.value   , 20 )) { alert(<wcf:json object="${Reg_ERROR_EmployeeIdTooLong}"/>); }
	
	else if(!isValidUTF8length(form.usr_firstName.value    , 50 )) { alert(<wcf:json object="${Reg_ERROR_FirstNameTooLong}"/>); }
	else if(!isValidUTF8length(form.usr_lastName.value     , 50 )) { alert(<wcf:json object="${Reg_ERROR_LastNameTooLong}"/>); }
	
	else if(!isValidUTF8length(form.usr_address1.value     , 50 )) { alert(<wcf:json object="${Reg_ERROR_AddressTooLong}"/>); }
	else if(!isValidUTF8length(form.usr_address2.value     , 50 )) { alert(<wcf:json object="${Reg_ERROR_AddressTooLong}"/>); }
	else if(!isValidUTF8length(form.usr_city.value         , 128)) { alert(<wcf:json object="${Reg_ERROR_CityTooLong}"/>); }
	else if(!isValidUTF8length(form.usr_state.value        , 128)) { alert(<wcf:json object="${Reg_ERROR_StateTooLong}"/>); }
	else if(!isValidUTF8length(form.usr_country.value      , 128)) { alert(<wcf:json object="${Reg_ERROR_CountryTooLong}"/>); }
	else if(!isValidUTF8length(form.usr_zipCode.value      , 40 )) { alert(<wcf:json object="${Reg_ERROR_ZipCodeTooLong}"/>); }
	
	else if(!isValidUTF8length(form.usr_phone1.value       , 32 )) { alert(<wcf:json object="${Reg_ERROR_PhoneTooLong}"/>); }
	else if(!isValidUTF8length(form.usr_email1.value       , 256)) { alert(<wcf:json object="${Reg_ERROR_EmailTooLong}"/>); }
	else if(!isValidUTF8length(form.usr_officeAddress.value, 256)) { alert(<wcf:json object="${Reg_ERROR_OfficeAddressTooLong}"/>); }


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
		
		//simple email check
		<fmt:message key="Reg_ERROR_InvalidOrgEmail" bundle="${storeText}" var="Reg_ERROR_InvalidOrgEmail"/>
		if(form.org_email1.value != "" && !isValidEmail(form.org_email1.value)) {
			alert(<wcf:json object="${Reg_ERROR_InvalidOrgEmail}"/>);
			return;
		}

		<fmt:message key="Reg_ERROR_InvalidEmail" bundle="${storeText}" var="Reg_ERROR_InvalidEmail"/>
		if(form.usr_email1.value != "" && !isValidEmail(form.usr_email1.value)) {
			alert(<wcf:json object="${Reg_ERROR_InvalidEmail}"/>);
			return;
		}

		if (form.sendMeEmail.checked) form.receiveEmail.value = true
		else form.receiveEmail.value = false;
	 	
	 	form.submit();
	 }
    }
    else
    {
    	form.reloadStates.value=reloadtype;
    	form.action='OrganizationRegistrationAddForm';
	form.submit();
    }
}


</script>


<%--
  ***
  *	Start: Logon/registration look and feel
  ***
--%>
<table cellpadding="0" cellspacing="0" border="0" width="100%" id="WC_OrganizationRegistrationAddForm_Table_1">
	<tr>
		<td width="40%" id="WC_OrganizationRegistrationAddForm_TableCell_1">&nbsp;</td>
		<td valign="top" width="600" id="WC_OrganizationRegistrationAddForm_TableCell_2">
			<table cellpadding="0" cellspacing="0" border="0" width="600" id="WC_OrganizationRegistrationAddForm_Table_2">
				<tr>
					<td class="logonTop" id="WC_OrganizationRegistrationAddForm_TableCell_3"><img src="<c:out value="${jspStoreImgDir}" />images/logon_top.gif" alt="" width="600" height="19" border="0"/></td>
				</tr>
				<tr>
					<td class="logonLogo" id="WC_OrganizationRegistrationAddForm_TableCell_4">
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
					<td background="<c:out value="${logonBannerImg}" />" id="WC_OrganizationRegistrationAddForm_TableCell_4.1"><img src="<c:out value="${logonBannerImg}" />" alt="" width="600" height="99" border="0"/></td>
					--%>

					<td style="background-image: url(<c:out value="${jspStoreImgDir}${vfileColor}" />register_image.jpg)" id="WC_OrganizationRegistrationAddForm_TableCell_4.1"><img src="<c:out value="${jspStoreImgDir}${vfileColor}" />register_image.jpg" alt="" width="600" height="99" border="0"/></td>
				</tr>
				<tr>
					<td class="logonwhite" width="600" id="WC_OrganizationRegistrationAddForm_TableCell_5">
						<table cellpadding="0" cellspacing="0" border="0" id="WC_OrganizationRegistrationAddForm_Table_3">
							<tr>
								<td class="logontitle" id="WC_OrganizationRegistrationAddForm_TableCell_6"><span class="logontitle">+</span>
									<fmt:message key="OrgReg_Title" bundle="${storeText}" />
								</td>
							</tr>
<%--
  ***
  *	End: Logon/registration look and feel
  ***
--%>



<tr><td class="logontxt" id="WC_OrganizationRegistrationAddForm_TableCell_7">
	<span class="reqd">*</span><fmt:message key="Reg_ReqField" bundle="${storeText}"/>
	<c:if test="${!empty errorMessage}">
		<!-- storeError.key == <c:out value="${storeError.key}"/> -->
		<!-- <c:if test="${!empty invalidParamErrorKey}">invalidParamErrorKey == <c:out value="${invalidParamErrorKey}"/></c:if> -->
		<br/><span class="warning"><c:out value="${errorMessage}"/></span>
	</c:if>
</td></tr>

<tr>
	<td id="WC_OrganizationRegistrationAddForm_TableCell_8"><hr class="logon" width="580"/></td>
</tr>

<flow:ifEnabled feature="customerCare">
<c:if test="${liveHelp}">

<tr><td id="WC_OrganizationRegistrationAddForm_TableCell_9">

<table class="noBorder" width="200" cellpadding="0" cellspacing="4" id="WC_OrganizationRegistrationAddForm_Table_4">
<tr>
	<td width="0%" id="WC_OrganizationRegistrationAddForm_TableCell_10">
		<a href="javascript:if(parent.sametime != null) { top.interact(); }" id="WC_OrganizationRegistrationAddForm_Link_1">
			<img src="<c:out value="${jspStoreImgDir}images/LiveHelp.gif"/>"/>
		</a>
	</td>
	<td id="WC_OrganizationRegistrationAddForm_TableCell_11">
		<a href="javascript:if(parent.sametime != null) { top.interact(); }" id="WC_OrganizationRegistrationAddForm_Link_2">
			<fmt:message key="LiveHelp" bundle="${storeText}"/>
		</a>
	</td>
</tr>
</table>

</td></tr>

</c:if>
</flow:ifEnabled>



<tr><td class="logonspacing" id="WC_OrganizationRegistrationAddForm_TableCell_12">

<form name="OrganizationRegistrationAddForm" method="post" action="BuyerRegistrationAdd" id="OrganizationRegistrationAddForm">

<input type="hidden" name="storeId"   value="<c:out value="${WCParam.storeId}"  />" id="WC_OrganizationRegistrationAddForm_FormInput_storeId_1"  />
<input type="hidden" name="catalogId" value="<c:out value="${WCParam.catalogId}"/>" id="WC_OrganizationRegistrationAddForm_FormInput_catalogId_1"/>

<c:url var="url" value="StoreView">
	<c:param name="storeId" value="${storeId}" />
	<c:param name="catalogId" value="${catalogId}" />
	<c:param name="langId" value="${langId}" />
	<c:param name="page" value="account" />
</c:url>

<input type="hidden" name="URL" value="<c:out value="${url}&usr_logonId*=&usr_employeeId*=&usr_firstName*=&usr_lastName*=&usr_address1*=&usr_address2*=&usr_city*=&usr_country*=&usr_state*=&usr_zipCode*=&usr_email1*=&usr_phone1*=&usr_officeAddress*=&org_orgEntityName*=&org_description*=&org_businessCategory*=&org_address1*=&org_address2*=&org_city*=&org_country*=&org_state*=&org_zipCode*=&org_email1*=&org_phone1*="/>" id="WC_OrganizationRegistrationAddForm_FormInput_URL_1"/>
<input type="hidden" name="page" value="account" id="WC_OrganizationRegistrationAddForm_FormInput_page_1"/>

<input type="hidden" name="errorViewName" value="OrganizationRegistrationAddForm" id="WC_OrganizationRegistrationAddForm_FormInput_errorViewName_1"/>
<input type="hidden" name="new" value="Y" id="WC_OrganizationRegistrationAddForm_FormInput_new_1"/>

<input type="hidden" name="usr_profileType" value="B" id="WC_OrganizationRegistrationAddForm_FormInput_usr_profileType_1"/>

<input type="hidden" name="reloadStates" value="" id="WC_OrganizationRegistrationAddForm_FormInput_reloadStates_1"/>


<table cellpadding="0" cellspacing="0" border="0" width="100%" id="WC_OrganizationRegistrationAddForm_Table_5">



<%--
  ***
  *	Start: Organization section
  ***
--%>
<tr><td class="logontxt" colspan="2" id="WC_OrganizationRegistrationAddForm_TableCell_13"><fmt:message key="OrgReg_Text1" bundle="${storeText}"/></td></tr>

<tr><td class="logonheading t_td2" colspan="2" id="WC_OrganizationRegistrationAddForm_TableCell_14"><span class="reqd">*</span><label for="WC_OrganizationRegistrationAddForm_FormInput_org_orgEntityName_1"><fmt:message key="OrgReg_OrgName" bundle="${storeText}"/></label></td></tr>
<tr><td colspan="2" id="WC_OrganizationRegistrationAddForm_TableCell_15"><input class="logon input" type="text" maxlength="128" size="35" name="org_orgEntityName" value="<c:out value="${WCParam.org_orgEntityName}"/>" id="WC_OrganizationRegistrationAddForm_FormInput_org_orgEntityName_1"/></td></tr>

<tr><td class="logonheading t_td2" colspan="2" id="WC_OrganizationRegistrationAddForm_TableCell_16"><label for="WC_OrganizationRegistrationAddForm_FormInput_org_description_1"><fmt:message key="OrgReg_Description" bundle="${storeText}"/></label></td></tr>
<tr><td colspan="2" id="WC_OrganizationRegistrationAddForm_TableCell_17"><input class="logon input" type="text" maxlength="256" size="35" name="org_description" value="<c:out value="${WCParam.org_description}"/>" id="WC_OrganizationRegistrationAddForm_FormInput_org_description_1"/></td></tr>

<tr><td class="logonheading t_td2" colspan="2" id="WC_OrganizationRegistrationAddForm_TableCell_18"><label for="WC_OrganizationRegistrationAddForm_FormInput_org_businessCategory_1"><fmt:message key="OrgReg_BusCategory" bundle="${storeText}"/></label></td></tr>
<tr><td colspan="2" id="WC_OrganizationRegistrationAddForm_TableCell_19"><input class="logon input" type="text" maxlength="128" size="35" name="org_businessCategory" value="<c:out value="${WCParam.org_businessCategory}"/>" id="WC_OrganizationRegistrationAddForm_FormInput_org_businessCategory_1"/></td></tr>



<jsp:useBean id="orgParamSource" class="java.util.HashMap">
	<c:set target="${orgParamSource}" property="address1"	value="${WCParam.org_address1}"	/>
	<c:set target="${orgParamSource}" property="address2"	value="${WCParam.org_address2}"	/>
	<c:set target="${orgParamSource}" property="city"	value="${WCParam.org_city}"	/>
	<c:set target="${orgParamSource}" property="state"	value="${WCParam.org_state}"	/>
	<c:set target="${orgParamSource}" property="country"	value="${WCParam.org_country}"	/>
	<c:set target="${orgParamSource}" property="zipCode"	value="${WCParam.org_zipCode}"	/>
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
<%@ include file="../../../Snippets/ReusableObjects/AddressEntryForm.jspf" %>
<%--
  ***
  *	End: Organization address section
  ***
--%>


<tr>
	<td class="logonheading t_td2" id="WC_OrganizationRegistrationAddForm_TableCell_21"><span class="reqd">*</span><label for="WC_OrganizationRegistrationAddForm_FormInput_org_email1_1"><fmt:message key="Reg_Email" bundle="${storeText}"/></label></td>
</tr>
<tr>
	<td id="WC_OrganizationRegistrationAddForm_TableCell_23"><input class="logon input" type="text" maxlength="80" size="35" name="org_email1" value="<c:out value="${WCParam.org_email1}"/>" id="WC_OrganizationRegistrationAddForm_FormInput_org_email1_1"/></td>
</tr>
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
	<td colspan="2" valign="bottom" id="WC_OrganizationRegistrationAddForm_TableCell_25">
		<table cellpadding="0" cellspacing="0" border="0" id="WC_OrganizationRegistrationAddForm_Table_6">
			<tr>
				<td valign="bottom" class="button" id="WC_OrganizationRegistrationAddForm_TableCell_26">
					<br/>
					<a href="javascript:submitForm(document.OrganizationRegistrationAddForm)" class="button" id="WC_OrganizationRegistrationAddForm_Link_3"><fmt:message key="Reg_Submit" bundle="${storeText}"/></a>
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
	<td id="WC_OrganizationRegistrationAddForm_TableCell_27"><hr width="580" class="logon" /></td>
</tr>
<tr>
	<td class="logontitle" id="WC_OrganizationRegistrationAddForm_TableCell_28"><span class="logontitle">+</span><fmt:message key="Logon_Title" bundle="${storeText}" /></td>
</tr>
<tr>
	<td class="logonspacing" id="WC_OrganizationRegistrationAddForm_TableCell_29">
		<table cellpadding="0" cellspacing="0" border="0" id="WC_OrganizationRegistrationAddForm_Table_8">
			<tr>
				<td class="logontxt" id="WC_OrganizationRegistrationAddForm_TableCell_30">
					<fmt:message key="Logoff_LogonLink" bundle="${storeText}">
						<fmt:param value="${storeName}"/>
					</fmt:message>
				</td>
			</tr>
		</table>
		<br/>
		<table cellpadding="0" cellspacing="0" border="0" id="WC_OrganizationRegistrationAddForm_Table_9">
			<tr>
				<td class="button" id="WC_OrganizationRegistrationAddForm_TableCell_31">
					<c:url var="LogonFormURL" value="LogonForm">
						<c:param name="storeId" value="${storeId}" />
						<c:param name="langId" value="${langId}" />
						<c:param name="catalogId" value="${catalogId}" />
					</c:url>
					<a href="<c:out value="${LogonFormURL}"/>" class="button" id="WC_OrganizationRegistrationAddForm_Link_4">
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
					<td id="WC_OrganizationRegistrationAddForm_TableCell_32"><img src="<c:out value="${jspStoreImgDir}" />images/logon_bottom.gif" alt="" width="600" height="19" border="0"/></td>
				</tr>
			</table>
		</td>
		<td width="40%" id="WC_OrganizationRegistrationAddForm_TableCell_33">&nbsp;</td>
	</tr>
</table>
<%--
  ***
  *	End: Logon/registration look and feel
  ***
--%>



</body>

</html>
