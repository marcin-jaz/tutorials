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
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>  
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ taglib uri="http://commerce.ibm.com/coremetrics"  prefix="cm" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf" %>
<%@ include file="../../../include/nocache.jspf" %>
<%@ include file="../../../include/ErrorMessageSetup.jspf" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="${shortLocale}" xml:lang="${shortLocale}">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title><fmt:message key="REGISTER_TITLE" bundle="${storeText}" /></title>
	<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${vfileStylesheet}"/>" type="text/css"/>
<!--[if lte IE 6]>
<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${vfileStylesheetie}"/>" type="text/css"/>
<![endif]-->
	
	<script type="text/javascript" src="<c:out value="${dojoFile}"/>" djConfig="${dojoConfigParams}"></script>
	<%@ include file="../../../include/CommonJSToInclude.jspf"%>
	<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/ServicesDeclaration.js"/>"></script>
	<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/MessageHelper.js"/>"></script>
	<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/UserArea/LogonForm.js"/>"></script>
	<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/UserArea/AddressHelper.js"/>"></script>
	<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/UserArea/MyAccountDisplay.js"/>"></script>
       <script type="text/javascript">
              dojo.addOnLoad(function() { 
			ServicesDeclarationJS.setCommonParameters('<c:out value='${WCParam.langId}'/>','<c:out value='${WCParam.storeId}'/>','<c:out value='${WCParam.catalogId}'/>');
			<fmt:message key="PWDREENTER_DO_NOT_MATCH" bundle="${storeText}" var="PWDREENTER_DO_NOT_MATCH" />
		     <fmt:message key="WISHLIST_INVALIDEMAILFORMAT" bundle="${storeText}" var="WISHLIST_INVALIDEMAILFORMAT" />
		     <fmt:message key="REQUIRED_FIELD_ENTER" bundle="${storeText}" var="REQUIRED_FIELD_ENTER" />
		     <fmt:message key="ERROR_INVALIDPHONE" bundle="${storeText}" var="ERROR_INVALIDPHONE" />
		     <fmt:message key="ERROR_LastNameEmpty" bundle="${storeText}" var="ERROR_LastNameEmpty" />
		     <fmt:message key="ERROR_AddressEmpty" bundle="${storeText}" var="ERROR_AddressEmpty" />      
		     <fmt:message key="ERROR_CityEmpty" bundle="${storeText}" var="ERROR_CityEmpty" />
		     <fmt:message key="ERROR_StateEmpty" bundle="${storeText}" var="ERROR_StateEmpty" />
		     <fmt:message key="ERROR_CountryEmpty" bundle="${storeText}" var="ERROR_CountryEmpty" />
		     <fmt:message key="ERROR_ZipCodeEmpty" bundle="${storeText}" var="ERROR_ZipCodeEmpty" />
		     <fmt:message key="ERROR_EmailEmpty" bundle="${storeText}" var="ERROR_EmailEmpty" />
		     <fmt:message key="ERROR_LogonIdEmpty" bundle="${storeText}" var="ERROR_LogonIdEmpty" />
		     <fmt:message key="ERROR_PasswordEmpty" bundle="${storeText}" var="ERROR_PasswordEmpty" />
		     <fmt:message key="ERROR_VerifyPasswordEmpty" bundle="${storeText}" var="ERROR_VerifyPasswordEmpty" />
		     <fmt:message key="ERROR_MESSAGE_TYPE" bundle="${storeText}" var="ERROR_MESSAGE_TYPE" />
		     <fmt:message key="ERROR_INVALIDEMAILFORMAT" bundle="${storeText}" var="ERROR_INVALIDEMAILFORMAT"/>
		     <fmt:message key="ERROR_FirstNameEmpty" bundle="${storeText}" var="ERROR_FirstNameEmpty" />
		     <fmt:message key="ERROR_FirstNameTooLong" bundle="${storeText}" var="ERROR_FirstNameTooLong" />
		     <fmt:message key="ERROR_LastNameTooLong" bundle="${storeText}" var="ERROR_LastNameTooLong" />
		     <fmt:message key="ERROR_AddressTooLong" bundle="${storeText}" var="ERROR_AddressTooLong" />
		     <fmt:message key="ERROR_CityTooLong" bundle="${storeText}" var="ERROR_CityTooLong" />
		     <fmt:message key="ERROR_StateTooLong" bundle="${storeText}" var="ERROR_StateTooLong" />
		     <fmt:message key="ERROR_CountryTooLong" bundle="${storeText}" var="ERROR_CountryTooLong" />
		     <fmt:message key="ERROR_ZipCodeTooLong" bundle="${storeText}" var="ERROR_ZipCodeTooLong" />
		     <fmt:message key="ERROR_EmailTooLong" bundle="${storeText}" var="ERROR_EmailTooLong" />
		     <fmt:message key="ERROR_PhoneTooLong" bundle="${storeText}" var="ERROR_PhoneTooLong" />
		     <fmt:message key="ERROR_SpecifyYear" bundle="${storeText}" var="ERROR_SpecifyYear" />
		     <fmt:message key="ERROR_SpecifyMonth" bundle="${storeText}" var="ERROR_SpecifyMonth" />
		     <fmt:message key="ERROR_SpecifyDate" bundle="${storeText}" var="ERROR_SpecifyDate" />
		     <fmt:message key="ERROR_InvalidDate1" bundle="${storeText}" var="ERROR_InvalidDate1" />
		     <fmt:message key="ERROR_InvalidDate2" bundle="${storeText}" var="ERROR_InvalidDate2" />
		     <fmt:message key="ERROR_MOBILE_PHONE_EMPTY" bundle="${storeText}" var="ERROR_MOBILE_PHONE_EMPTY" />

			 MessageHelper.setMessage("PWDREENTER_DO_NOT_MATCH", <wcf:json object="${PWDREENTER_DO_NOT_MATCH}"/>);
	         MessageHelper.setMessage("WISHLIST_INVALIDEMAILFORMAT", <wcf:json object="${WISHLIST_INVALIDEMAILFORMAT}"/>);
	         MessageHelper.setMessage("REQUIRED_FIELD_ENTER", <wcf:json object="${REQUIRED_FIELD_ENTER}"/>);
	         MessageHelper.setMessage("ERROR_INVALIDPHONE", <wcf:json object="${ERROR_INVALIDPHONE}"/>);
	         MessageHelper.setMessage("ERROR_LastNameEmpty", <wcf:json object="${ERROR_LastNameEmpty}"/>);
	         MessageHelper.setMessage("ERROR_AddressEmpty", <wcf:json object="${ERROR_AddressEmpty}"/>);
	         MessageHelper.setMessage("ERROR_CityEmpty", <wcf:json object="${ERROR_CityEmpty}"/>);
	         MessageHelper.setMessage("ERROR_StateEmpty", <wcf:json object="${ERROR_StateEmpty}"/>);
	         MessageHelper.setMessage("ERROR_CountryEmpty", <wcf:json object="${ERROR_CountryEmpty}"/>);
	         MessageHelper.setMessage("ERROR_ZipCodeEmpty", <wcf:json object="${ERROR_ZipCodeEmpty}"/>);
	         MessageHelper.setMessage("ERROR_EmailEmpty", <wcf:json object="${ERROR_EmailEmpty}"/>);
	         MessageHelper.setMessage("ERROR_LogonIdEmpty", <wcf:json object="${ERROR_LogonIdEmpty}"/>);
	         MessageHelper.setMessage("ERROR_PasswordEmpty", <wcf:json object="${ERROR_PasswordEmpty}"/>);
	         MessageHelper.setMessage("ERROR_VerifyPasswordEmpty", <wcf:json object="${ERROR_VerifyPasswordEmpty}"/>);
	         MessageHelper.setMessage("ERROR_MESSAGE_TYPE", <wcf:json object="${ERROR_MESSAGE_TYPE}"/>);
	         MessageHelper.setMessage("ERROR_INVALIDEMAILFORMAT", <wcf:json object="${ERROR_INVALIDEMAILFORMAT}"/>);
             MessageHelper.setMessage("ERROR_FirstNameEmpty", <wcf:json object="${ERROR_FirstNameEmpty}"/>);
             MessageHelper.setMessage("ERROR_FirstNameTooLong", <wcf:json object="${ERROR_FirstNameTooLong}"/>);
             MessageHelper.setMessage("ERROR_LastNameTooLong", <wcf:json object="${ERROR_LastNameTooLong}"/>);
             MessageHelper.setMessage("ERROR_AddressTooLong", <wcf:json object="${ERROR_AddressTooLong}"/>);
             MessageHelper.setMessage("ERROR_CityTooLong", <wcf:json object="${ERROR_CityTooLong}"/>);
             MessageHelper.setMessage("ERROR_StateTooLong", <wcf:json object="${ERROR_StateTooLong}"/>);
             MessageHelper.setMessage("ERROR_CountryTooLong", <wcf:json object="${ERROR_CountryTooLong}"/>);
             MessageHelper.setMessage("ERROR_ZipCodeTooLong", <wcf:json object="${ERROR_ZipCodeTooLong}"/>);
             MessageHelper.setMessage("ERROR_EmailTooLong", <wcf:json object="${ERROR_EmailTooLong}"/>);
	         MessageHelper.setMessage("ERROR_PhoneTooLong", <wcf:json object="${ERROR_PhoneTooLong}"/>);	         
	         MessageHelper.setMessage("ERROR_SpecifyYear", <wcf:json object="${ERROR_SpecifyYear}"/>);
	         MessageHelper.setMessage("ERROR_SpecifyMonth", <wcf:json object="${ERROR_SpecifyMonth}"/>);
	         MessageHelper.setMessage("ERROR_SpecifyDate", <wcf:json object="${ERROR_SpecifyDate}"/>);
	         MessageHelper.setMessage("ERROR_InvalidDate1", <wcf:json object="${ERROR_InvalidDate1}"/>);
	         MessageHelper.setMessage("ERROR_InvalidDate2", <wcf:json object="${ERROR_InvalidDate2}"/>);
	         MessageHelper.setMessage("ERROR_MOBILE_PHONE_EMPTY", <wcf:json object="${ERROR_MOBILE_PHONE_EMPTY}"/>);
              });
       
       </script>
       <script type="text/javascript">
              dojo.addOnLoad(temp);
              function temp(){
                     LogonForm.setAjaxVar("true");
              }
       </script>
       <script type="text/javascript">
              function popupWindow(URL) {
                     window.open(URL, "mywindow", "status=1,scrollbars=1,resizable=1");
              }
       </script>       
      
</head>


<wcf:url var="TopCategoriesDisplayURL" value="TopCategories1">
 <wcf:param name="langId" value="${langId}" />
 <wcf:param name="storeId" value="${WCParam.storeId}" />
 <wcf:param name="catalogId" value="${WCParam.catalogId}" />
</wcf:url>


<wcf:url var="MyAccountURL" value="AjaxLogonForm" type="Ajax">
  <wcf:param name="langId" value="${langId}" />
  <wcf:param name="storeId" value="${WCParam.storeId}" />
  <wcf:param name="catalogId" value="${WCParam.catalogId}" />
</wcf:url>

<body>
<%@ include file="../../../include/StoreCommonUtilities.jspf"%>
<!-- Page Start -->
<div id="page">
     <!-- Header Nav Start -->
       <%@ include file="../../../include/LayoutContainerTop.jspf"%>
       <form name="Register" method="post" action="PersonProcessServicePersonRegister" id="Register">

       <input type="hidden" name="myAcctMain" value="<c:out value="${WCParam.myAcctMain}"/>" />
       <input type="hidden" name="new" value="Y" id="WC_UserRegistrationAddForm_FormInput_new_In_Register_1"/>
       <input type="hidden" name="storeId" value="<c:out value="${WCParam.storeId}"  />" id="WC_UserRegistrationAddForm_FormInput_storeId_In_Register_1"/>
       <input type="hidden" name="catalogId" value="<c:out value="${WCParam.catalogId}"  />" id="WC_UserRegistrationAddForm_FormInput_catalogId_In_Register_1"/>
       <input type="hidden" name="URL" value="AjaxLogonForm?&logonId*=&firstName*=&lastName*=&address1*=&address2*=&city*=&country*=&state*=&zipCode*=&email1*=&phone1*=" id="WC_UserRegistrationAddForm_FormInput_URL_In_Register_1"/>
		<input type="hidden" name="receiveSMSNotification" value="" id="WC_UserRegistrationAddForm_FormInput_receiveSMSNotification_In_Register_1"/>
		<input type="hidden" name="receiveSMS" value="" id="WC_UserRegistrationAddForm_FormInput_receiveSMS_In_Register_1"/>
		<input type="hidden" name="addressType" value="ShippingAndBilling" id="WC_UserRegistrationAddForm_FormInput_addressType_In_Register_1"/>
       <input type="hidden" name="errorViewName" value="UserRegistrationAddFormView" id="WC_UserRegistrationAddForm_FormInput_errorViewName_In_Register_1"/>              

       <c:choose>
              <c:when test="${empty WCParam.page}">
                     <input type="hidden" name="page" value="account" id="WC_UserRegistrationAddForm_FormInput_page_In_Register_1"/>
              </c:when>
              <c:otherwise>
                     <input type="hidden" name="page" value="<c:out value="${WCParam.page}" />" id="WC_UserRegistrationAddForm_FormInput_page_In_Register_1"/>
              </c:otherwise>
       </c:choose>
       <input type="hidden" name="registerType" value="Guest" id="WC_UserRegistrationAddForm_FormInput_registerType_In_Register_1"/>
              <input type="hidden" name="primary" value="true" id="WC_UserRegistrationAddForm_FormInput_primary_In_Register_1"/>
              <input type="hidden" name="profileType" value="Consumer" id="WC_UserRegistrationAddForm_FormInput_profileType_In_Register_1"/>
       
       <input type="hidden" name="receiveEmail" value="" id="WC_UserRegistrationAddForm_FormInput_receiveEmail_In_Register_1"/>
       <%-- The challenge answer and question are necessary for the forget password feature. Therefore, they are set to "-" here.       --%>
       <input type="hidden" name="challengeQuestion" value="-" id="WC_UserRegistrationAddForm_FormInput_challengeQuestion_In_Register_1"/>
       <input type="hidden" name="challengeAnswer" value="-" id="WC_UserRegistrationAddForm_FormInput_challengeAnswer_In_Register_1"/>

       <%--
         ***
         * If an error occurs, the page will refresh and the entry fields will be pre-filled with the previously entered value.
         * The entry fields below use e.g. paramSource.logonId to get the previously entered value.
         * In this case, the paramSource is set to WCParam.  
         ***
       --%>
       <c:set var="paramSource" value="${WCParam}"/>  
       <wcf:getData type="com.ibm.commerce.member.facade.datatypes.PersonType" var="person" expressionBuilder="findCurrentPerson">
                 <wcf:param name="accessProfile" value="IBM_All" />
       </wcf:getData>
       
     <!-- Header Nav End -->
     <!-- Main Content Start -->
     <div id="content_wrapper_border">
          <!-- Content Start -->
          <div id="box">
               <div class="sign_in_registration" id="WC_UserRegistrationAddForm_div_1">
                    <div class="title" id="WC_UserRegistrationAddForm_div_2">
                         <h1>
                         	<fmt:message key="UR_PROFILE" bundle="${storeText}">
														<fmt:param><fmt:message key="UR_CREATE" bundle="${storeText}"/></fmt:param>
													</fmt:message>	
                         </h1>
                    </div>
                    <div class="form" id="WC_UserRegistrationAddForm_div_3">
                         <div class="header_registration" id="WC_UserRegistrationAddForm_div_4">
                              <div class="heading" id="WC_UserRegistrationAddForm_div_5">
                                   <h2 class="registration_header"><fmt:message key="UR_PLEASE_REG" bundle="${storeText}"/></h2>
                              </div>
                         </div>
                         <div class="content" id="WC_UserRegistrationAddForm_div_6">
                              <div class="align" id="WC_UserRegistrationAddForm_div_7">
                                   <div class="form_2column" id="WC_UserRegistrationAddForm_div_8">
                                          
                                                    <c:if test="${!empty errorMessage}">
                                                                             <fmt:message var ="msgType" key="ERROR_MESSAGE_TYPE" bundle="${storeText}"/>
                                                                             <c:set var = "errorMessage" value ="${msgType}${errorMessage}"/>
											<span id="UserRegistrationErrorMessage" class="error_msg" tabindex="-1"><c:out value="${errorMessage}"/></span><br/>
                                                                             <script type="text/javascript">
                                                                                    dojo.addOnLoad(function() { 
                                                                                           setTimeout("dojo.byId('UserRegistrationErrorMessage').focus()",2000);
                                                                                    });
                                                                             </script>
                                                                             <br/>
                                                                      </c:if>
                                          
                                        <div class="required-field" id="WC_UserRegistrationAddForm_div_9"> *</div>
                                        <fmt:message key="REQUIRED_FIELDS" bundle="${storeText}"/><br />
                                        <br />
                                        <div class="column" id="WC_UserRegistrationAddForm_div_10">
                                             <div id="WC_UserRegistrationAddForm_div_11">
                                                  <label for="WC_UserRegistrationAddForm_FormInput_logonId_In_Register_1_1" class="nodisplay">
												  <fmt:message key="AB_ADDRESS_LABEL_TEXT" bundle="${storeText}">
												  <fmt:param><fmt:message key="LOGON_ID" bundle="${storeText}"/></fmt:param>
												  <fmt:param><fmt:message key="Checkout_ACCE_required" bundle="${storeText}"/></fmt:param></fmt:message>
												  </label>
												  <div class="required-field" id="WC_UserRegistrationAddForm_div_12"> *</div>
                                                  <fmt:message key="LOGON_ID" bundle="${storeText}"/>
											 </div>
											 											<input type="text" size="35" maxlength="254" name="logonId" id="WC_UserRegistrationAddForm_FormInput_logonId_In_Register_1_1"  value="<c:out value="${paramSource.logonId}"/>"/>
                                        </div>
                                                                              
                                        <br clear="all" />
                                        <div class="column" id="WC_UserRegistrationAddForm_div_13">
                                             <div id="WC_UserRegistrationAddForm_div_14">
                                                  <label for="WC_UserRegistrationAddForm_FormInput_logonPassword_In_Register_1" class="nodisplay">
												  <fmt:message key="AB_ADDRESS_LABEL_TEXT" bundle="${storeText}">
												  <fmt:param><fmt:message key="PASSWORD3" bundle="${storeText}"/></fmt:param>
												  <fmt:param><fmt:message key="Checkout_ACCE_required" bundle="${storeText}"/></fmt:param></fmt:message>
												  </label>
												  <div class="required-field" id="WC_UserRegistrationAddForm_div_15"> *</div>
                                                  <fmt:message key="PASSWORD3" bundle="${storeText}"/>
										     </div>
                                             <input size="35" maxlength="50" name="logonPassword" id="WC_UserRegistrationAddForm_FormInput_logonPassword_In_Register_1" type="password" value="<c:out value="${paramSource.logonPassword}"/>" />
                                        </div>
                                        <div class="column" id="WC_UserRegistrationAddForm_div_16">
                                             <div id="WC_UserRegistrationAddForm_div_17">
                                                  <label for="WC_UserRegistrationAddForm_FormInput_logonPasswordVerify_In_Register_1" class="nodisplay">
												  <fmt:message key="AB_ADDRESS_LABEL_TEXT" bundle="${storeText}">
												  <fmt:param><fmt:message key="VERIFY_PASSWORD3" bundle="${storeText}"/></fmt:param>
												  <fmt:param><fmt:message key="Checkout_ACCE_required" bundle="${storeText}"/></fmt:param></fmt:message>
												  </label>
												  <div class="required-field" id="WC_UserRegistrationAddForm_div_18"> *</div>
                                                  <fmt:message key="VERIFY_PASSWORD3" bundle="${storeText}"/>
											  </div>
                                             <input size="35" maxlength="50" name="logonPasswordVerify" id="WC_UserRegistrationAddForm_FormInput_logonPasswordVerify_In_Register_1" type="password" value="<c:out value="${paramSource.logonPassword}"/>" />
                                        </div>
                                        <br clear="all" />
                                        <%-- 
                                                                        ***
                                                                        *       Start: Registration Form - First Name and Last Name fields
                                                                        * The layouts of these entry fields are different depending on the locale.
                                                                        ***
                                                                      --%>                            
                                                                      <c:set var="firstName" value="${paramSource.firstName}"/>
                                                                      <c:set var="lastName" value="${paramSource.lastName}"/>
																	  <c:set var="middleName" value="${paramSource.middleName}"/>
                                                                      <c:set var="street" value="${paramSource.address1}"/>
                                                                      <c:set var="street2" value="${paramSource.address2}"/>
                                                                      <c:set var="city" value="${paramSource.city}"/>
                                                                      <c:set var="state" value="${paramSource.state}"/>
                                                                      <c:set var="country1" value="${paramSource.country}"/>
                                                                      <c:set var="zipCode" value="${paramSource.zipCode}"/>                                                                                                                                                   
                                                                      <c:set var="formName" value="document.Register.name"/>
                                                                      <c:set var="paramSource" value="${WCParam}" />
                                                                      <c:set var="pageName" value="UserRegistrationAddForm"/>
                                                                      <c:set var="receiveSMSNotification" value="${paramSource.receiveSMSNotification}"/>
																	  <c:set var="mobilePhoneNumber1" value="${paramSource.mobilePhone1}"/>
                                                    
                                                                      <c:choose>
                                                                             <c:when test="${locale == 'zh_CN'}">
                                                                                    <%@ include file="../../../Snippets/ReusableObjects/AddressEntryForm_CN.jspf"%>
                                                                                    <input type="hidden" id="AddressForm_FieldsOrderByLocale" value="LAST_NAME,first_name,COUNTRY/REGION,STATE/PROVINCE,CITY,ADDRESS,ZIP,phone1,EMAIL1"/>
                                                                             </c:when>
																			 																			 <c:when test="${locale == 'ru_RU'}">
                                                                                    <%@ include file="../../../Snippets/ReusableObjects/AddressEntryForm_RU.jspf"%>
                                                                                    <input type="hidden" id="AddressForm_FieldsOrderByLocale" value="first_name,middle_name,LAST_NAME,ADDRESS,ZIP,CITY,state/province,COUNTRY/REGION,phone1,EMAIL1"/>
                                                                             </c:when>
                                                                             <c:when test="${locale == 'zh_TW'}">
                                                                                    <%@ include file="../../../Snippets/ReusableObjects/AddressEntryForm_TW.jspf"%>
                                                                                    <input type="hidden" id="AddressForm_FieldsOrderByLocale" value="LAST_NAME,first_name,COUNTRY/REGION,STATE/PROVINCE,CITY,ZIP,ADDRESS,phone1,EMAIL1"/>
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
                                                                      <%-- 
                                                                        ***
                                                                        *       End: AddressEntry Form - Address, City, State/Province, Country/Region and Zip/Postal code fields
                                                                        ***
                                                                      --%>
                                                                      <br clear="all" />
                                        <div class="column" id="WC_UserRegistrationAddForm_div_19">
                                             <div id="WC_UserRegistrationAddForm_div_20">
                                                  <label for="WC_UserRegistrationAddForm_FormInput_email1_In_Register_1" class="nodisplay">
												  <fmt:message key="AB_ADDRESS_LABEL_TEXT" bundle="${storeText}">
												  <fmt:param><fmt:message key="EMAIL" bundle="${storeText}"/></fmt:param>
												  <fmt:param><fmt:message key="Checkout_ACCE_required" bundle="${storeText}"/></fmt:param></fmt:message>
												  </label>
												  <div class="required-field" id="WC_UserRegistrationAddForm_div_21"> *</div>
                                                  <fmt:message key="EMAIL" bundle="${storeText}"/>
                                             </div>
                                             <input type="text" size="35" maxlength="50" name="email1" id="WC_UserRegistrationAddForm_FormInput_email1_In_Register_1" value="<c:out value="${paramSource.email1}"/>" />
                                        </div>
                                        <div class="column" id="WC_UserRegistrationAddForm_div_22">
                                             <div id="WC_UserRegistrationAddForm_div_23">
                                                  <label for="WC_UserRegistrationAddForm_FormInput_phoneNum_In_Register_1" class="nodisplay">
												  <fmt:message key="AB_ADDRESS_LABEL_TEXT" bundle="${storeText}">
												  <fmt:param><fmt:message key="PHONE_NUMBER2" bundle="${storeText}"/></fmt:param>
												  <fmt:param> </fmt:param></fmt:message>
												  </label>
                                                  <fmt:message key="PHONE_NUMBER2" bundle="${storeText}"/>
                                             </div>
                                             <input type="text" size="35" maxlength="32" id="WC_UserRegistrationAddForm_FormInput_phoneNum_In_Register_1" name="phone1" value="<c:out value="${paramSource.phone1}"/>"/>
                                        </div>
                                        <br clear="all" />
                                        
                                        <%@ include file="../../../Snippets/ReusableObjects/RegistrationFlexFlows.jspf"%>
                                           
 										<br clear="all" />
                                        <div class="column" id="WC_UserRegistrationAddForm_div_36">
                                             <div class="input_label" id="WC_UserRegistrationAddForm_div_37">
                                                  <div class="left" id="WC_UserRegistrationAddForm_div_38">
                                                  		<input class="checkbox" type="checkbox" name="rememberMe" value="true" id="WC_UserRegistrationAddForm_FormInput_rememberMe_In_Register_1"/>
                                                  </div>
                                                  <div class="checkbox_label" id="WC_UserRegistrationAddForm_div_39">
                                                       <label for="WC_UserRegistrationAddForm_FormInput_rememberMe_In_Register_1"><fmt:message key="REMEMBER_ME" bundle="${storeText}"/></label>
                                                  </div>
                                             </div>
                                        </div>
                                        <%@ include file="UserRegistrationAddExt.jspf"%>
                                   </div>
                                   <div class="clear_float"></div>
                              </div>
                         </div>
                         <div class="twisty_align" id="WC_UserRegistrationAddForm_div_40"><br />
														<span class="primary_button button_fit" >
															<span class="button_container">
																<span class="button_bg">
																<span class="button_top">
																	<span class="button_bottom">   
																		<a href="#" onclick="JavaScript:LogonForm.prepareSubmit(document.Register);return false;"  id="WC_UserRegistrationAddForm_links_1"><fmt:message key="SUBMIT" bundle="${storeText}"/></a>
						 											</span>
																</span>	
																</span>
															</span>
														</span>
						 								
						 								<span class="secondary_button button_fit" >
															<span class="button_container">
																<span class="button_bg">
																<span class="button_top">
																	<span class="button_bottom">   
																		<a href="<c:out value="${TopCategoriesDisplayURL}"/>" id="WC_UserRegistrationAddForm_links_2"><fmt:message key="CANCLE" bundle="${storeText}"/></a>
						 											</span>
																</span>	
																</span>
															</span>
														</span>	
						 								<br />
						 						 </div>
                         <div class="footer" id="WC_UserRegistrationAddForm_div_45">
                              <div class="left_corner" id="WC_UserRegistrationAddForm_div_46"></div>
                              <div class="left" id="WC_UserRegistrationAddForm_div_47"></div>
                              <div class="right_corner" id="WC_UserRegistrationAddForm_div_48"></div>
                         </div><br />
                    </div>
               </div>
          </div>
          <!-- Content End -->
     </div>
        </form>
     <!-- Main Content End -->
     <!-- Footer Start Start -->
       <%@ include file="../../../include/LayoutContainerBottom.jspf"%>
     <!-- Footer Start End -->
</div>
<div id="page_shadow" class="shadow"></div>
<flow:ifEnabled feature="Analytics"><cm:pageview/></flow:ifEnabled>
</body>
</html>
   