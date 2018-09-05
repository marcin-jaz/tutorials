<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2008, 2009 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>

<%@ page import="com.ibm.commerce.member.facade.client.MemberFacadeClient" %>
<%@ page import="com.ibm.commerce.member.facade.datatypes.PersonType" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf" %>
<%@ include file="../../../include/nocache.jspf" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>             
<%@ include file="../../../include/ErrorMessageSetup.jspf" %>

<c:set var="myAccountPage" value="true" scope="request"/>

<wcf:getData type="com.ibm.commerce.member.facade.datatypes.PersonType" var="person" expressionBuilder="findCurrentPerson">
       <wcf:param name="accessProfile" value="IBM_All" />
</wcf:getData>

<c:set var="firstName" value="${person.contactInfo.contactName.firstName}"/>
<c:set var="lastName" value="${person.contactInfo.contactName.lastName}"/>
<c:set var="middleName" value="${person.contactInfo.contactName.middleName}"/>
<c:set var="street" value="${person.contactInfo.address.addressLine[0]}"/>
<c:set var="street2" value="${person.contactInfo.address.addressLine[1]}"/>
<c:set var="city" value="${person.contactInfo.address.city}"/>
<c:set var="state" value="${person.contactInfo.address.stateOrProvinceName}" scope="request"/>
<c:set var="country1" value="${person.contactInfo.address.country}"/>
<c:set var="zipCode" value="${person.contactInfo.address.postalCode}"/>
<c:set var="phone1" value="${person.contactInfo.telephone1.value}"/>
<c:set var="email1" value="${person.contactInfo.emailAddress1.value}"/>
<c:set var="preferredLanguage" value="${person.personalProfile.preferredLanguage}"/>
<c:set var="preferredCurrency" value="${person.personalProfile.preferredCurrency}"/>
<c:set var="age" value="${person.personalProfile.attributes.age}"/>
<c:set var="gender" value="${person.personalProfile.gender}"/>
<c:set var="dateOfBirth" value="${person.personalProfile.dateOfBirth}"/>
<c:set var="mobilePhoneNumber1" value="${person.contactInfo.mobilePhone1.value}"/>
<c:set var="mobilePhoneNumber1Country" value="${person.contactInfo.mobilePhone1.country}"/>
<c:set var="mobilePhoneNumber1CountryCode" value=""/>
<c:set var="receiveSMSNotification" value="${person.personalProfile.receiveSMSNotification}"/>

	
<wcf:url var="AjaxMyAccountCenterLinkDisplayURL" value="AjaxLogonFormCenterLinksDisplayView" type="Ajax">    
	<wcf:param name="storeId"   value="${WCParam.storeId}"  />
	<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
	<wcf:param name="langId" value="${langId}" />
</wcf:url>

<c:choose>
	<c:when test="${empty storeError.key}">
		<c:set var="logonPassword" value="${person.credential.password}"/>
		<c:set var="logonPasswordVerify" value="${person.credential.password}"/>
	</c:when>
	<c:otherwise>
		<c:set var="logonPassword" value="${WCParam.logonPassword}"/>
		<c:set var="logonPasswordVerify" value="${WCParam.logonPasswordVerify}"/>
		<c:set var="paramSource" value="${WCParam}"/>
	</c:otherwise>
</c:choose>

<wcbase:useBean id="bnEmailUserReceive" classname="com.ibm.commerce.emarketing.beans.EmailUserReceiveDataBean">
<c:set property="usersId" value="${CommandContext.userId}" target="${bnEmailUserReceive}" />
</wcbase:useBean>
<flow:ifEnabled feature="AjaxMyAccountPage">
	<wcf:url var="LogonForm" value="AjaxLogonForm" type="Ajax">
	  <wcf:param name="langId" value="${langId}" />
	  <wcf:param name="storeId" value="${WCParam.storeId}" />
	  <wcf:param name="catalogId" value="${WCParam.catalogId}" />
	  <wcf:param name="myAcctMain" value="1" />
	</wcf:url>
</flow:ifEnabled>
<flow:ifDisabled feature="AjaxMyAccountPage">
	<wcf:url var="LogonForm" value="LogonForm" type="Ajax">
		<flow:ifDisabled feature="preferredLanguage">
		  <wcf:param name="langId" value="${langId}" />
		</flow:ifDisabled>  
	  <wcf:param name="storeId" value="${WCParam.storeId}" />
	  <wcf:param name="catalogId" value="${WCParam.catalogId}" />
	  <wcf:param name="myAcctMain" value="1" />
	</wcf:url>
</flow:ifDisabled>
		<div id="box">
			<div class="my_account" id="WC_RegistrationUpdateCommonPage_div_1">
				<div class="main_header" id="WC_UserRegistrationUpdateForm_div_2">
						<div class="left_corner" id="WC_UserRegistrationUpdateForm_div_3"></div>
						<div class="left" id="WC_UserRegistrationUpdateForm_div_4"><span class="main_header_text"><fmt:message key="MA_PERSONAL_INFO" bundle="${storeText}"/></span></div>
						<div class="right_corner" id="WC_UserRegistrationUpdateForm_div_5"></div>
				</div>
				<div class="content_header" id="WC_UserRegistrationUpdateForm_div_6">
					<div class="left_corner" id="WC_UserRegistrationUpdateForm_div_7"></div>
					<div class="left" id="WC_UserRegistrationUpdateForm_div_8">
						<span class="content_text">
							<fmt:message key="PI_WELCOMEBACK" bundle="${storeText}">
								<fmt:param><c:out value="${firstName}"/></fmt:param>
								<fmt:param><c:out value="${middleName}"/></fmt:param>
								<fmt:param><c:out value="${lastName}"/></fmt:param>
								<fmt:param><fmt:formatDate type="both" dateStyle="long" value="${CommandContext.user.lastSessionInEJBType}"/></fmt:param>
							</fmt:message>
						</span>
					</div>
					<div class="right_corner" id="WC_UserRegistrationUpdateForm_div_9"></div>
				</div>
				<div class="body" id="WC_UserRegistrationUpdateForm_div_10">
					<div class="form_2column" id="WC_UserRegistrationUpdateForm_div_11">
						<form name="Register" method="post" action="PersonChangeServicePersonUpdate" id="Register">
							<input type="hidden" name="storeId" value="<c:out value="${WCParam.storeId}"  />" id="WC_UserRegistrationUpdateForm_FormInput_storeId_In_Register_1"/>
							<input type="hidden" name="catalogId" value="<c:out value="${WCParam.catalogId}"  />" id="WC_UserRegistrationUpdateForm_FormInput_catalogId_In_Register_1"/>
							<input type="hidden" name="URL" value="${LogonForm}" id="WC_UserRegistrationUpdateForm_FormInput_URL_In_Register_1"/>
							<flow:ifDisabled feature="AjaxMyAccountPage">
							<input type="hidden" name="errorViewName" value="UserRegistrationForm" id="WC_UserRegistrationUpdateForm_FormInput_errorViewName_In_Register_1"/>
							</flow:ifDisabled>
							<input type="hidden" name="registerType" value="RegisteredPerson" id="WC_UserRegistrationUpdateForm_FormInput_registerType_In_Register_1"/>
							<input type="hidden" name="editRegistration" value="Y" id="WC_UserRegistrationUpdateForm_FormInput_editRegistration_In_Register_1"/>
							<input type="hidden" name="receiveEmail" value="" id="WC_UserRegistrationUpdateForm_FormInput_receiveEmail_In_Register_1"/>
							<input type="hidden" name="receiveSMSNotification" value="" id="WC_UserRegistrationUpdateForm_FormInput_receiveSMSNotification_In_Register_1"/>
							<input type="hidden" name="receiveSMS" value="" id="WC_UserRegistrationUpdateForm_FormInput_receiveSMS_In_Register_1"/>
							<input type="hidden" name="logonId" value="<c:out value="${person.credential.logonID}"/>" id="WC_UserRegistrationUpdateForm_FormInput_logonId_In_Register_1_1"/>
							<input type="hidden" name="authToken" value="${authToken}" id="WC_UserRegistrationUpdateForm_FormInput_authToken_In_Register_1"/>
							<div class="required-field" id="WC_UserRegistrationUpdateForm_div_12"> *</div>
							<fmt:message key="REQUIRED_FIELDS" bundle="${storeText}"/>
							<%-- The challenge answer and question are necessary for the forget password feature. Therefore, they are set to "-" here.       --%>
						   <input type="hidden" name="challengeQuestion" value="-" id="WC_UserRegistrationUpdateForm_FormInput_challengeQuestion_In_Register_1"/>
						   <input type="hidden" name="challengeAnswer" value="-" id="WC_UserRegistrationUpdateForm_FormInput_challengeAnswer_In_Register_1"/>
							<br />
							
							<br clear="all" />
							<div class="column" id="WC_UserRegistrationUpdateForm_div_13">
								<div id="WC_UserRegistrationUpdateForm_div_14">
									<label for="WC_UserRegistrationUpdateForm_FormInput_logonPassword_In_Register_1" class="nodisplay">
									<fmt:message key="AB_ADDRESS_LABEL_TEXT" bundle="${storeText}">
									<fmt:param><fmt:message key="PASSWORD3" bundle="${storeText}"/></fmt:param>
									<fmt:param> </fmt:param></fmt:message>
									</label>
									<fmt:message key="PASSWORD3" bundle="${storeText}"/></div>
							   <input size="35" maxlength="50" name="logonPassword_old" type="password" value="" id="WC_UserRegistrationUpdateForm_FormInput_logonPassword_In_Register_1"/>
							</div>
							
							<div class="column" id="WC_UserRegistrationUpdateForm_div_16">
								<div id="WC_UserRegistrationUpdateForm_div_17">
									<label for="WC_UserRegistrationUpdateForm_FormInput_logonPasswordVerify_In_Register_1" class="nodisplay">
									<fmt:message key="AB_ADDRESS_LABEL_TEXT" bundle="${storeText}">
									<fmt:param><fmt:message key="VERIFY_PASSWORD3" bundle="${storeText}"/></fmt:param>
									<fmt:param> </fmt:param></fmt:message>
									</label>
										<fmt:message key="VERIFY_PASSWORD3" bundle="${storeText}"/>
								</div>
								<input size="35" maxlength="50" name="logonPasswordVerify_old" type="password" value="" id="WC_UserRegistrationUpdateForm_FormInput_logonPasswordVerify_In_Register_1"/>
							</div>
							
							<br clear="all" />  
							
							<c:set var="paramPrefix" value=""/>
							<c:set var="formName" value="document.Register.name" />
							<c:set var="pageName" value="UserRegistrationUpdateForm" />
							<c:choose>   
								<c:when test="${locale == 'zh_CN'}">
									<%@ include file="../../../Snippets/ReusableObjects/AddressEntryForm_CN.jspf"%>
									<input type="hidden" id="AddressForm_FieldsOrderByLocale" value="LAST_NAME,first_name,COUNTRY/REGION,STATE/PROVINCE,CITY,ADDRESS,ZIP,phone1,EMAIL1"/>
								</c:when>
								<c:when test="${locale == 'zh_TW'}">
									<%@ include file="../../../Snippets/ReusableObjects/AddressEntryForm_TW.jspf"%>
									<input type="hidden" id="AddressForm_FieldsOrderByLocale" value="LAST_NAME,first_name,COUNTRY/REGION,STATE/PROVINCE,CITY,ZIP,ADDRESS,phone1,EMAIL1"/>
								</c:when>
								<c:when test="${locale == 'ru_RU'}">
										<%@ include file="../../../Snippets/ReusableObjects/AddressEntryForm_RU.jspf"%>
										<input type="hidden" id="AddressForm_FieldsOrderByLocale" value="first_name,middle_name,LAST_NAME,ADDRESS,ZIP,CITY,state/province,COUNTRY/REGION,phone1,EMAIL1"/>
								 </c:when>
								<c:when test="${locale == 'ja_JP' || locale == 'ko_KR'}">
									<%@ include file="../../../Snippets/ReusableObjects/AddressEntryForm_JP_KR.jspf"%>
									<input type="hidden" id="AddressForm_FieldsOrderByLocale" value="LAST_NAME,FIRST_NAME,COUNTRY/REGION,ZIP,STATE/PROVINCE,CITY,ADDRESS,phone1,EMAIL1"/>
								</c:when>
								<c:when test="${locale == 'de_DE' || locale == 'es_ES' || locale == 'fr_FR' || locale == 'it_IT' || locale == 'ro_RO'}">
									<%@ include file="../../../Snippets/ReusableObjects/AddressEntryForm_DE_ES_FR_IT_RO.jspf"%>
									<input type="hidden" id="AddressForm_FieldsOrderByLocale" value="first_name,LAST_NAME,ADDRESS,ZIP,CITY,state/province,COUNTRY/REGION,phone1,EMAIL1"/>
								</c:when>
								<c:when test="${locale == 'pl_PL'}">
										<%@ include file="../../../Snippets/ReusableObjects/AddressEntryForm_PL.jspf"%>
										<input type="hidden" id="AddressForm_FieldsOrderByLocale" value="first_name,LAST_NAME,ADDRESS,ZIP,CITY,STATE/PROVINCE,COUNTRY/REGION,phone1,EMAIL1"/>
								 </c:when>
								<c:otherwise>  
									<%@ include file="../../../Snippets/ReusableObjects/AddressEntryForm.jspf"%>
									<input type="hidden" id="AddressForm_FieldsOrderByLocale" value="first_name,LAST_NAME,ADDRESS,CITY,COUNTRY/REGION,STATE/PROVINCE,ZIP,phone1,EMAIL1"/>
								</c:otherwise>
							</c:choose>
														
							<br clear="all" />
							<div class="column" id="WC_UserRegistrationUpdateForm_div_19">
								<div id="WC_UserRegistrationUpdateForm_div_20">
									<label for="WC_UserRegistrationUpdateForm_FormInput_email_In_Register_1" class="nodisplay">
									 <fmt:message key="AB_ADDRESS_LABEL_TEXT" bundle="${storeText}">
									 <fmt:param><fmt:message key="EMAIL" bundle="${storeText}"/></fmt:param>
									 <fmt:param><fmt:message key="Checkout_ACCE_required" bundle="${storeText}"/></fmt:param></fmt:message>
									</label>
									<div class="required-field" id="WC_UserRegistrationUpdateForm_div_21"> *</div>
									<fmt:message key="EMAIL" bundle="${storeText}"/></div>
								<input type="text" size="35" maxlength="50" name="email1" id="WC_UserRegistrationUpdateForm_FormInput_email_In_Register_1" value="<c:out value='${email1}'/>" />
							</div>
							
							<div class="column" id="WC_UserRegistrationUpdateForm_div_22">
								<div id="WC_UserRegistrationUpdateForm_div_23">
									<label for="WC_UserRegistrationUpdateForm_FormInput_phoneNum_In_Register_1" class="nodisplay">
									<fmt:message key="AB_ADDRESS_LABEL_TEXT" bundle="${storeText}">
									<fmt:param><fmt:message key="PHONE_NUMBER2" bundle="${storeText}"/></fmt:param>
					    			<fmt:param> </fmt:param></fmt:message>
									</label>
										<fmt:message key="PHONE_NUMBER2" bundle="${storeText}"/></div>
								<input type="text" maxlength="32" size="35" id="WC_UserRegistrationUpdateForm_FormInput_phoneNum_In_Register_1" name="phone1" value="<c:out value='${phone1}'/>"/>
							</div>
							<br clear="all"/>
							
							<flow:ifEnabled  feature="EmailOption">
							<div class="column" id="WC_UserRegistrationUpdateForm_div_24">                                        
								<div class="input_label" id="WC_UserRegistrationUpdateForm_div_25">
									<div class="left" id="WC_UserRegistrationUpdateForm_div_26">
										<input class="checkbox" type="checkbox" name="sendMeEmail" id="WC_UserRegistrationUpdateForm_FormInput_sendMeEmail_In_Register_1" <c:if test="${bnEmailUserReceive.userReceive}"> checked </c:if> />
									</div>
									<div class="checkbox_label" id=WC_UserRegistrationUpdateForm_div_26_1">
										<label for="WC_UserRegistrationUpdateForm_FormInput_sendMeEmail_In_Register_1"><fmt:message key="REGNEW_SENDMEEMAIL" bundle="${storeText}"/></label>
									</div>
								</div>
							</div>
							<br clear="all" />
							</flow:ifEnabled>
							
							<flow:ifEnabled feature="preferredLanguage">
							<div class="column" id="WC_UserRegistrationUpdateForm_div_27">
								<div id="WC_UserRegistrationUpdateForm_div_28">
									<label for="WC_UserRegistrationUpdateForm_FormInput_preferredLanguage_In_Register_1">
										<fmt:message key="REGISTER_PREFERREDLANGUAGE" bundle="${storeText}"/></label>
								</div>
								<wcf:getData type="com.ibm.commerce.infrastructure.facade.datatypes.ConfigurationType"
									var="currentStoreLanguages"
									expressionBuilder="findByUniqueID">
									<wcf:param name="uniqueId" value="com.ibm.commerce.foundation.supportedLanguages" />
									<wcf:contextData name="storeId" data="${storeId}"/>
								</wcf:getData>
								<c:set var="supportedLanguages" value="${currentStoreLanguages.configurationAttribute}"/>
								
								<select class="drop_down" onblur="javascript:MyAccountDisplay.setPreferredLanguageUpdated(true)" name="preferredLanguage" id="WC_UserRegistrationUpdateForm_FormInput_preferredLanguage_In_Register_1">
								<c:set var="userLocale" value="${CommandContext.locale}"/>
								<c:if test='${!empty preferredLanguage}' >
									<c:set var="userLocale" value="${preferredLanguage}"/>
								</c:if>
								<c:forEach var="supportedLanguage" items="${supportedLanguages}">
									<c:forEach var="additionalValue" items="${supportedLanguage.additionalValue}">
										<c:if test="${additionalValue.name == 'localeName'}">
											<c:set var="currentLocaleName" value="${additionalValue.value}"/>
										</c:if>
									</c:forEach>
									<c:choose>
										<c:when test="${currentLocaleName == userLocale}">
											<option value="<c:out value="${currentLocaleName}" />" selected="selected"><c:out value="${supportedLanguage.primaryValue.value}" /></option>
										</c:when>
										<c:otherwise>
											<option value="<c:out value="${currentLocaleName}" />"><c:out value="${supportedLanguage.primaryValue.value}" /></option>
										</c:otherwise>
									</c:choose>
								</c:forEach>
								</select>
							</div>
							</flow:ifEnabled>
							
							<flow:ifDisabled feature="preferredLanguage">
									<input type="hidden" name="preferredLanguage" value="<c:out value="${preferredLanguage}" />" id="WC_UserRegistrationUpdateForm_FormInput_preferredLanguage_In_Register_2"/>
							</flow:ifDisabled>

							<flow:ifEnabled feature="preferredCurrency">
							<div class="column" id="WC_UserRegistrationUpdateForm_div_30">
								<div id="WC_UserRegistrationUpdateForm_div_31">
									<label for="WC_UserRegistrationUpdateForm_FormInput_preferredCurrency_In_Register_1">
									<fmt:message key="REGISTER_PREFERREDCURRENCY" bundle="${storeText}"/></label></div>
									<wcf:getData type="com.ibm.commerce.infrastructure.facade.datatypes.ConfigurationType"
										var="currentStoreCurrencies"
										expressionBuilder="findByUniqueID">
										<wcf:param name="uniqueId" value="com.ibm.commerce.foundation.supportedCurrencies" />
										<wcf:contextData name="storeId" data="${storeId}"/>
									</wcf:getData>
									<c:set var="supportedCurrencies" value="${currentStoreCurrencies.configurationAttribute}"/>
									
								<select class="drop_down" name="preferredCurrency" id="WC_UserRegistrationUpdateForm_FormInput_preferredCurrency_In_Register_1">
								<c:set var="userCurrency" value="${CommandContext.currency}"/>
								<c:if test='${!empty preferredCurrency}' >
									<c:set var="userCurrency" value="${preferredCurrency}"/>
								</c:if>
									<c:forEach var="supportedCurrency" items="${supportedCurrencies}">
										<c:forEach var="additionalValue" items="${supportedCurrency.additionalValue}">
											<c:if test="${additionalValue.name == 'currencyCode'}">
												<c:set var="currentCurrencyCode" value="${additionalValue.value}"/>
											</c:if>
										</c:forEach>
										<c:choose>
											<%-- pre-select the appropriate value in the drop down list. --%>
											<c:when test="${currentCurrencyCode == userCurrency}">
												<option value="<c:out value="${currentCurrencyCode}" />" selected="selected"><c:out value="${supportedCurrency.primaryValue.value}"/></option>
											</c:when>
											<c:otherwise>
												<option value="<c:out value="${currentCurrencyCode}" />"><c:out value="${supportedCurrency.primaryValue.value}"/></option>
											</c:otherwise>
										</c:choose>
									</c:forEach>
								</select>
							</div>
							<br clear="all" />
							</flow:ifEnabled>
								
							<flow:ifDisabled feature="preferredCurrency">
								<input type="hidden" name="preferredCurrency" value="<c:out value="${preferredCurrency}" default = "${CommandContext.currency}"/>" id="WC_UserRegistrationUpdateForm_FormInput_preferredCurrency_In_Register_2"/>
							</flow:ifDisabled>

							<flow:ifEnabled feature="Age">
							<div class="column" id="WC_UserRegistrationUpdateForm_div_33">
								<div id="WC_UserRegistrationUpdateForm_div_34">
									<label for="WC_UserRegistrationUpdateForm_FormInput_age_In_Register_1"><fmt:message key="AGE" bundle="${storeText}" /></label>
								</div>
							
								<select class="drop_down" name="age" id="WC_UserRegistrationUpdateForm_FormInput_age_In_Register_1">
								<%-- pre-select the appropriate value in the drop down list. --%>
								<option <c:if test="${age eq '0'}"> selected="selected" </c:if> value="0"><fmt:message key="SELECT_ONE" bundle="${storeText}" /></option>
								<option <c:if test="${age eq '1'}"> selected="selected" </c:if> value="1"><fmt:message key="REG_AGE_OPTION1" bundle="${storeText}" /></option>
								<option <c:if test="${age eq '2'}"> selected="selected" </c:if> value="2"><fmt:message key="REG_AGE_OPTION2" bundle="${storeText}" /></option>
								<option <c:if test="${age eq '3'}"> selected="selected" </c:if> value="3"><fmt:message key="REG_AGE_OPTION3" bundle="${storeText}" /></option>
								<option <c:if test="${age eq '4'}"> selected="selected" </c:if> value="4"><fmt:message key="REG_AGE_OPTION4" bundle="${storeText}" /></option>
								<option <c:if test="${age eq '5'}"> selected="selected" </c:if> value="5"><fmt:message key="REG_AGE_OPTION5" bundle="${storeText}" /></option>
								<option <c:if test="${age eq '6'}"> selected="selected" </c:if> value="6"><fmt:message key="REG_AGE_OPTION6" bundle="${storeText}" /></option>
								<option <c:if test="${age eq '7'}"> selected="selected" </c:if> value="7"><fmt:message key="REG_AGE_OPTION7" bundle="${storeText}" /></option>
								</select>
								<wcf:url var="PrivacyViewURL" value="PrivacyPolicy">  
									<wcf:param name="langId" value="${langId}" />
									<wcf:param name="storeId" value="${WCParam.storeId}" />
									<wcf:param name="catalogId" value="${WCParam.catalogId}" />
									<wcf:param name="fromPage" value="registration" />
								</wcf:url>
								<a href="javascript:MyAccountDisplay.popupWindow('<c:out value="${PrivacyViewURL}"/>');" class="myaccount_link" id="WC_UserRegistrationAddForm_PrivacyPolicy_Link_1"><fmt:message key="PRIVACY_TITLE" bundle="${storeText}" /></a>
							</div>
							</flow:ifEnabled>
							<flow:ifEnabled feature="Gender">				
								<div class="column" id="WC_UserRegistrationUpdateForm_div_35">
									<div id="WC_UserRegistrationUpdateForm_div_36">
										<label for="WC_UserRegistrationUpdateForm_FormInput_gender_In_Register_1"><fmt:message key="GENDER" bundle="${storeText}" /></label>
									</div>
									<select class="drop_down" name="gender" id="WC_UserRegistrationUpdateForm_FormInput_gender_In_Register_1">
											<option <c:if test="${gender eq 'Unspecified'}"> selected="selected" </c:if> value="Unspecified"><fmt:message key="SELECT_ONE" bundle="${storeText}" /></option>
											<option <c:if test="${gender eq 'Male'}"> selected="selected" </c:if> value="Male"><fmt:message key="MALE" bundle="${storeText}" /></option>
											<option <c:if test="${gender eq 'Female'}"> selected="selected" </c:if> value="Female"><fmt:message key="FEMALE" bundle="${storeText}" /></option>
									</select>
								</div>							
								<br clear="all" />
							</flow:ifEnabled>
							
							<%@ include file="../../../Snippets/ReusableObjects/PersonalInfoExtension.jspf"%>
									
							<br clear="all" />
							<br />
							<%@ include file="UserRegistrationUpdateExt.jspf"%>
						</form>
					</div>
				</div>
				<div class="content_footer" id="WC_UserRegistrationUpdateForm_div_40">
					 <div class="left_corner" id="WC_UserRegistrationUpdateForm_div_41"></div>
					 <div class="button_footer_line" id="WC_UserRegistrationUpdateForm_div_42">
						 <span class="primary_button button_fit" >
							<span class="button_container">
								<span class="button_bg">
								<span class="button_top">
									<span class="button_bottom">   
										<a href="#" onclick="javascript:MyAccountDisplay.prepareSubmit(document.Register,'<c:out value='${logonPassword}'/>','<c:out value='${logonPasswordVerify}'/>');return false;" id="WC_UserRegistrationUpdateForm_links_1"><fmt:message key="UPDATE" bundle="${storeText}"/></a>
						 			</span>
								</span>	
								</span>
							</span>
						</span>	
					 </div>
					 <div class="right_corner" id="WC_UserRegistrationUpdateForm_div_45"></div>
				</div>
			</div>
		</div>
