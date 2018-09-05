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
  * This page displays the organization administrator section of the
  * organization registration form.
  *****
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>

<%@ include file="../../../include/JSTLEnvironmentSetup.jspf" %>
<%@ include file="../../../include/ErrorMessageSetup.jspf" %>



<tr><td class="logontxt" colspan="2" id="WC_OrgRegAddFormUserSection_TableCell_1"><fmt:message key="OrgReg_Text2" bundle="${storeText}"/></td></tr>



<%--
  ***
  *	Start: User ID/password/employee ID section
  ***
--%>
<tr>
	<td class="logonheading t_td2" colspan="2" id="WC_OrgRegAddFormUserSection_TableCell_2"><span class="reqd">*</span><label for="WC_OrgRegAddFormUserSection_FormInput_usr_logonId_1"><fmt:message key="Reg_UserID" bundle="${storeText}"/></label></td>
</tr>
<tr>
	<td colspan="2" id="WC_OrgRegAddFormUserSection_TableCell_3">
		<input class="logon input" type="text" maxlength="80" size="35" name="usr_logonId" value="<c:out value="${WCParam.usr_logonId}"/>" id="WC_OrgRegAddFormUserSection_FormInput_usr_logonId_1"/>
	</td>
</tr>

<tr>
	<td class="logonheading t_td2" id="WC_OrgRegAddFormUserSection_TableCell_4"><span class="reqd">*</span><label for="WC_OrgRegAddFormUserSection_FormInput_password_1"><fmt:message key="Reg_Password" bundle="${storeText}"/></label></td>
</tr>
<tr>
	<td id="WC_OrgRegAddFormUserSection_TableCell_6"><input id="WC_OrgRegAddFormUserSection_FormInput_password_1" class="logon input" type="password" maxlength="40" size="35" name="logonPassword" value="<c:out value="${WCParam.logonPassword}"/>"/></td>
</tr>
<tr>
	<td class="logonheading t_td2" id="WC_OrgRegAddFormUserSection_TableCell_5"><span class="reqd">*</span><label for="WC_OrgRegAddFormUserSection_FormInput_password_verify_1"><fmt:message key="Reg_Verify" bundle="${storeText}"/></label></td>
</tr>
<tr>
	<td id="WC_OrgRegAddFormUserSection_TableCell_7"><input id="WC_OrgRegAddFormUserSection_FormInput_password_verify_1" class="logon input" type="password" maxlength="40" size="35" name="logonPasswordVerify" value="<c:out value="${WCParam.logonPasswordVerify}"/>"/></td>
</tr>
<tr>
	<td class="logonheading t_td2" id="WC_OrgRegAddFormUserSection_TableCell_6b"><span class="reqd">*</span><label for="WC_OrgRegAddFormUserSection_FormInput_usr_challengeQuestion_1"><fmt:message key="Reg_ChallengeQuestion" bundle="${storeText}"/></label></td>
</tr>
<tr>
	<td id="WC_OrgRegAddFormUserSection_TableCell_8b">	
		<fmt:message key="Reg_ChallengeQuestion1" bundle="${storeText}" var="Reg_ChallengeQuestion1"/>
		<fmt:message key="Reg_ChallengeQuestion2" bundle="${storeText}" var="Reg_ChallengeQuestion2"/>
		<fmt:message key="Reg_ChallengeQuestion3" bundle="${storeText}" var="Reg_ChallengeQuestion3"/>
		<select class="logon select" name="usr_challengeQuestion" id="WC_OrgRegAddFormUserSection_FormInput_usr_challengeQuestion_1">
			<option value="Reg_ChallengeQuestion1" <c:if test="${WCParam.usr_challengeQuestion == 'Reg_ChallengeQuestion1'}"> selected="selected"</c:if>><c:out value="${Reg_ChallengeQuestion1}"/></option>
			<option value="Reg_ChallengeQuestion2" <c:if test="${WCParam.usr_challengeQuestion == 'Reg_ChallengeQuestion2'}"> selected="selected"</c:if>><c:out value="${Reg_ChallengeQuestion2}"/></option>
			<option value="Reg_ChallengeQuestion3" <c:if test="${WCParam.usr_challengeQuestion == 'Reg_ChallengeQuestion3'}"> selected="selected"</c:if>><c:out value="${Reg_ChallengeQuestion3}"/></option>
		</select>	
	</td>
</tr>
<tr>
	<td class="logonheading t_td2" id="WC_OrgRegAddFormUserSection_TableCell_7b"><span class="reqd">*</span><label for="WC_OrgRegAddFormUserSection_FormInput_usr_challengeAnswer_1"><fmt:message key="Reg_ChallengeAnswer" bundle="${storeText}"/></label></td>
</tr>
<tr>
	<td id="WC_OrgRegAddFormUserSection_TableCell_9b">
		<input type="text" class="logon input" name="usr_challengeAnswer" value="<c:out value="${WCParam.usr_challengeAnswer}"/>" maxlength="40" size="35" id="WC_OrgRegAddFormUserSection_FormInput_usr_challengeAnswer_1"/>
	</td>
</tr>

<tr>
	<td class="logonheading t_td2" colspan="2" id="WC_OrgRegAddFormUserSection_TableCell_8"><span class="reqd">*</span><label for="WC_OrgRegAddFormUserSection_FormInput_usr_employeeId_1"><fmt:message key="Reg_EmpID" bundle="${storeText}"/></label></td>
</tr>
<tr>
	<td colspan="2" id="WC_OrgRegAddFormUserSection_TableCell_9">
		<input class="logon input" type="text" maxlength="20" size="35" name="usr_employeeId" value="<c:out value="${WCParam.usr_employeeId}"/>" id="WC_OrgRegAddFormUserSection_FormInput_usr_employeeId_1"/>
	</td>
</tr>
<%--
  ***
  *	End: User ID/password/employee ID section
  ***
--%>



<jsp:useBean id="userParamSource" class="java.util.HashMap">

	<c:set target="${userParamSource}" property="personTitle"		value="${WCParam.usr_personTitle}"		/>
	<c:set target="${userParamSource}" property="firstName"			value="${WCParam.usr_firstName}"		/>
	<c:set target="${userParamSource}" property="lastName"			value="${WCParam.usr_lastName}"			/>

	<c:set target="${userParamSource}" property="address1"			value="${WCParam.usr_address1}"			/>
	<c:set target="${userParamSource}" property="address2"			value="${WCParam.usr_address2}"			/>
	<c:set target="${userParamSource}" property="city"			value="${WCParam.usr_city}"			/>
	<c:set target="${userParamSource}" property="state"			value="${WCParam.usr_state}"			/>
	<c:set target="${userParamSource}" property="country"			value="${WCParam.usr_country}"			/>
	<c:set target="${userParamSource}" property="zipCode"			value="${WCParam.usr_zipCode}"			/>

	<c:set target="${userParamSource}" property="phone1"			value="${WCParam.usr_phone1}"			/>
	<c:set target="${userParamSource}" property="email1"			value="${WCParam.usr_email1}"			/>
	<c:set target="${userParamSource}" property="preferredCurrency"	value="${WCParam.usr_preferredCurrency}"/>
	<c:set target="${userParamSource}" property="preferredLanguage"	value="${WCParam.usr_preferredLanguage}"/>

</jsp:useBean>

<c:set var="paramPrefix" value="usr_" scope="request"/>
<c:set var="paramSource" value="${userParamSource}" scope="request"/>
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
