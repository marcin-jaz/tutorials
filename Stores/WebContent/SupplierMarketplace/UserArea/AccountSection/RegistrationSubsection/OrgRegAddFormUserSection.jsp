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
  *	Start: User ID/password/challenge question/answer section
  ***
--%>
<tr>
	<td class="logonheading" colspan="2" id="WC_OrgRegAddFormUserSection_TableCell_2"><span class="reqd">*</span><label for="WC_OrgRegAddFormUserSection_FormInput_usr_logonId_1"><fmt:message key="Reg_UserID" bundle="${storeText}"/></label></td>
</tr>
<tr>
	<td colspan="2" id="WC_OrgRegAddFormUserSection_TableCell_3">
		<label for="WC_OrgRegAddFormUserSection_FormInput_usr_logonId_1">
		<input class="logon" type="text" maxlength="80" size="25" name="usr_logonId" value="<c:out value="${WCParam.usr_logonId}"/>" id="WC_OrgRegAddFormUserSection_FormInput_usr_logonId_1"/>
		</label>
	</td>
</tr>

<tr>
	<td class="logonheading" id="WC_OrgRegAddFormUserSection_TableCell_4"><span class="reqd">*</span><label for="WC_OrgRegAddFormUserSection_FormInput_password_1"><fmt:message key="Reg_Password" bundle="${storeText}"/></label></td>
	<td class="logonheading" id="WC_OrgRegAddFormUserSection_TableCell_5"><span class="reqd">*</span><label for="WC_OrgRegAddFormUserSection_FormInput_password_verify_1"><fmt:message key="Reg_Verify" bundle="${storeText}"/></label></td>
</tr>
<tr>
	<td id="WC_OrgRegAddFormUserSection_TableCell_6"><input id="WC_OrgRegAddFormUserSection_FormInput_password_1" class="logon" type="password" maxlength="40" size="25" name="logonPassword" value="<c:out value="${WCParam.logonPassword}"/>"/></td>
	<td id="WC_OrgRegAddFormUserSection_TableCell_7"><input id="WC_OrgRegAddFormUserSection_FormInput_password_verify_1" class="logon" type="password" maxlength="40" size="25" name="logonPasswordVerify" value="<c:out value="${WCParam.logonPasswordVerify}"/>"/></td>
</tr>

<tr>
	<td class="logonheading" id="WC_OrgRegAddFormUserSection_TableCell_6b"><span class="reqd">*</span><label for="WC_OrgRegAddFormUserSection_FormInput_usr_challengeQuestion_1"><fmt:message key="Reg_ChallengeQuestion" bundle="${storeText}"/></label></td>
	<td class="logonheading" id="WC_OrgRegAddFormUserSection_TableCell_7b"><span class="reqd">*</span><label for="WC_OrgRegAddFormUserSection_FormInput_usr_challengeAnswer_1"><fmt:message key="Reg_ChallengeAnswer" bundle="${storeText}"/></label></td>
</tr>
<tr>
	<td id="WC_OrgRegAddFormUserSection_TableCell_8b">	
		<fmt:message key="Reg_ChallengeQuestion1" bundle="${storeText}" var="Reg_ChallengeQuestion1"/>
		<fmt:message key="Reg_ChallengeQuestion2" bundle="${storeText}" var="Reg_ChallengeQuestion2"/>
		<fmt:message key="Reg_ChallengeQuestion3" bundle="${storeText}" var="Reg_ChallengeQuestion3"/>
		<select class="logon" name="usr_challengeQuestion" id="WC_OrgRegAddFormUserSection_FormInput_usr_challengeQuestion_1">
			<option value=""<c:if test="${empty WCParam.usr_challengeQuestion}"> selected="selected"</c:if>/>
			<option value="Reg_ChallengeQuestion1"<c:if test="${WCParam.usr_challengeQuestion == 'Reg_ChallengeQuestion1'}"> selected="selected"</c:if>><c:out value="${Reg_ChallengeQuestion1}"/></option>
			<option value="Reg_ChallengeQuestion2"<c:if test="${WCParam.usr_challengeQuestion == 'Reg_ChallengeQuestion2'}"> selected="selected"</c:if>><c:out value="${Reg_ChallengeQuestion2}"/></option>
			<option value="Reg_ChallengeQuestion3"<c:if test="${WCParam.usr_challengeQuestion == 'Reg_ChallengeQuestion3'}"> selected="selected"</c:if>><c:out value="${Reg_ChallengeQuestion3}"/></option>
		</select>	
	</td>
	<td id="WC_OrgRegAddFormUserSection_TableCell_9b">
		<label for="WC_OrgRegAddFormUserSection_FormInput_usr_challengeAnswer_1">
		<input type="text" class="logon" name="usr_challengeAnswer" value="<c:out value="${WCParam.usr_challengeAnswer}"/>" maxlength="40" size="25" id="WC_OrgRegAddFormUserSection_FormInput_usr_challengeAnswer_1"/>
		</label>
	</td>
</tr>

<%--
  ***
  *	End: User ID/password/challenge question/answer section
  ***
--%>



<jsp:useBean id="userParamSource" class="java.util.HashMap">
	
	<c:set target="${userParamSource}" property="preferredCurrency"	value="${WCParam.usr_preferredCurrency}"/>
	<c:set target="${userParamSource}" property="preferredLanguage"	value="${WCParam.usr_preferredLanguage}"/>
	
	<c:set target="${userParamSource}" property="personTitle"		value="${WCParam.usr_personTitle}"		/>
	<c:set target="${userParamSource}" property="firstName"			value="${WCParam.usr_firstName}"		/>
	<c:set target="${userParamSource}" property="lastName"			value="${WCParam.usr_lastName}"			/>
	
	<c:set target="${userParamSource}" property="address1"			value="${WCParam.usr_address1}"			/>
	<c:set target="${userParamSource}" property="address2"			value="${WCParam.usr_address2}"			/>
	<c:set target="${userParamSource}" property="city"				value="${WCParam.usr_city}"				/>
	<c:set target="${userParamSource}" property="state"				value="${WCParam.usr_state}"			/>
	<c:set target="${userParamSource}" property="country"			value="${WCParam.usr_country}"			/>
	<c:set target="${userParamSource}" property="zipCode"			value="${WCParam.usr_zipCode}"			/>
	
	<c:set target="${userParamSource}" property="email1"			value="${WCParam.usr_email1}"			/>
	<c:set target="${userParamSource}" property="email2"			value="${WCParam.usr_email2}"			/>
	<c:set target="${userParamSource}" property="phone1"			value="${WCParam.usr_phone1}"			/>
	<c:set target="${userParamSource}" property="phone2"			value="${WCParam.usr_phone2}"			/>
	<c:set target="${userParamSource}" property="fax1"				value="${WCParam.usr_fax1}"				/>
	<c:set target="${userParamSource}" property="fax2"				value="${WCParam.usr_fax2}"				/>
	
	<c:set target="${userParamSource}" property="preferredCommunication"	value="${WCParam.usr_preferredCommunication}"	/>
	<c:set target="${userParamSource}" property="bestCallingTime"			value="${WCParam.usr_bestCallingTime}"			/>
	
</jsp:useBean>

<c:set var="paramPrefix" value="usr_" scope="request"/>
<c:set var="paramSource" value="${userParamSource}" scope="request"/>
<c:set var="memberAttributeAction" value="a" scope="request"/>



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
		<label for="<c:out value="WC_${pageName}_MiscEntryForm_FormInput_${paramPrefix}preferredCurrency_1"/>">
			<select class="logon" name="<c:out value="${paramPrefix}preferredCurrency"/>" id="<c:out value="WC_${pageName}_MiscEntryForm_FormInput_${paramPrefix}preferredCurrency_1"/>">
			<c:forEach items="${sdb.storeCurrencies}" var="currency">
			<option value="<c:out value="${currency.currencyCode}"/>"<c:if test="${currency.currencyCode == preferredCurrency}"> selected="selected"</c:if>>
				<c:out value="${currency.currencyDescription}"/>
			</option>
			</c:forEach>
			</select>
		</label>
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
	<td colspan="2" id="<c:out value="WC_${pageName}_MiscEntryForm_TableCell_9"/>"><hr class="logon" width="570"/></td>
</tr>
<tr>
	<td class="logontxt" colspan="2" id="<c:out value="WC_${pageName}_MiscEntryForm_TableCell_10"/>">
		<fmt:message key="OrgReg_Text4" bundle="${storeText}"/>
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
