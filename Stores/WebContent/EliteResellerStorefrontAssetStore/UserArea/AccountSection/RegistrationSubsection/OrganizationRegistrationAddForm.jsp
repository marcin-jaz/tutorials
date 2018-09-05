<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2001, 2009 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
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
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf" %>
<%@ taglib uri="http://commerce.ibm.com/coremetrics"  prefix="cm" %>
<%@ include file="../../../include/nocache.jspf" %>
<%@ include file="../../../include/ErrorMessageSetup.jspf" %>
<c:set var="hideHeader" value="true"/> <%-- do not want to show the headers in this page --%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" lang="${shortLocale}" xml:lang="${shortLocale}">
   <head>
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
      <title><fmt:message key="OrgReg_Title" bundle="${storeText}" /></title>
      <link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${vfileStylesheet}"/>" type="text/css"/>
      <!--[if lte IE 6]>
      <link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${vfileStylesheetie}"/>" type="text/css"/>
      <![endif]-->
      <script type="text/javascript" src="<c:out value="${dojoFile}"/>" djConfig="${dojoConfigParams}"></script>
      <%@ include file="../../../include/CommonJSToInclude.jspf"%>
      <script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/UserArea/AddressHelper.js"/>"></script>
      <script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/MessageHelper.js"/>"></script>
      <script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/UserArea/LogonForm.js"/>"></script>
     	<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/UserArea/MyAccountDisplay.js"/>"></script>
      <script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/UserArea/B2BLogonForm.js"/>"></script>


      <script type="text/javascript">
	      <fmt:message key="PWDREENTER_DO_NOT_MATCH" bundle="${storeText}" var="PWDREENTER_DO_NOT_MATCH" />
	      <fmt:message key="WISHLIST_INVALIDEMAILFORMAT" bundle="${storeText}" var="WISHLIST_INVALIDEMAILFORMAT" />
	      <fmt:message key="REQUIRED_FIELD_ENTER" bundle="${storeText}" var="REQUIRED_FIELD_ENTER" />
	      <fmt:message key="ERROR_PhonenumberEmpty" bundle="${storeText}" var="ERROR_PhonenumberEmpty" />
	      <fmt:message key="ERROR_INVALIDPHONE" bundle="${storeText}" var="ERROR_INVALIDPHONE" />
	      <fmt:message key="ERROR_LastNameEmpty" bundle="${storeText}" var="ERROR_LastNameEmpty" />
	      <fmt:message key="ERROR_AddressEmpty" bundle="${storeText}" var="ERROR_AddressEmpty" />      
	      <fmt:message key="ERROR_CityEmpty" bundle="${storeText}" var="ERROR_CityEmpty" />
	      <fmt:message key="ERROR_StateEmpty" bundle="${storeText}" var="ERROR_StateEmpty" />
	      <fmt:message key="ERROR_CountryEmpty" bundle="${storeText}" var="ERROR_CountryEmpty" />
	      <fmt:message key="ERROR_ZipCodeEmpty" bundle="${storeText}" var="ERROR_ZipCodeEmpty" />
	      <fmt:message key="ERROR_EmailEmpty" bundle="${storeText}" var="ERROR_EmailEmpty" />
	      <fmt:message key="ERROR_LogonIdEmpty" bundle="${storeText}" var="ERROR_LogonIdEmpty" />
	      <fmt:message key="ERROR_EmployeeIdEmpty" bundle="${storeText}" var="ERROR_EmployeeIdEmpty" />
	      <fmt:message key="ERROR_PasswordEmpty" bundle="${storeText}" var="ERROR_PasswordEmpty" />
	      <fmt:message key="ERROR_VerifyPasswordEmpty" bundle="${storeText}" var="ERROR_VerifyPasswordEmpty" />
	      <fmt:message key="ERROR_MESSAGE_TYPE" bundle="${storeText}" var="ERROR_MESSAGE_TYPE" />
	      <fmt:message key="ERROR_SpecifyYear" bundle="${storeText}" var="ERROR_SpecifyYear" />
	      <fmt:message key="ERROR_SpecifyMonth" bundle="${storeText}" var="ERROR_SpecifyMonth" />
	      <fmt:message key="ERROR_SpecifyDate" bundle="${storeText}" var="ERROR_SpecifyDate" />
	      <fmt:message key="ERROR_InvalidDate1" bundle="${storeText}" var="ERROR_InvalidDate1" />
	      <fmt:message key="ERROR_InvalidDate2" bundle="${storeText}" var="ERROR_InvalidDate2" />
	      <fmt:message key="ERROR_MOBILE_PHONE_EMPTY" bundle="${storeText}" var="ERROR_MOBILE_PHONE_EMPTY" />
	      <fmt:message key="ERROR_PhoneTooLong" bundle="${storeText}" var="ERROR_PhoneTooLong" />
	      <fmt:message key="ERROR_OrgNameEmpty" bundle="${storeText}" var="ERROR_OrgNameEmpty" />
      
         MessageHelper.setMessage("PWDREENTER_DO_NOT_MATCH", <wcf:json object="${PWDREENTER_DO_NOT_MATCH}"/>);
         MessageHelper.setMessage("WISHLIST_INVALIDEMAILFORMAT", <wcf:json object="${WISHLIST_INVALIDEMAILFORMAT}"/>);
         MessageHelper.setMessage("REQUIRED_FIELD_ENTER", <wcf:json object="${REQUIRED_FIELD_ENTER}"/>);
         MessageHelper.setMessage("ERROR_PhonenumberEmpty", <wcf:json object="${ERROR_PhonenumberEmpty}"/>);
         MessageHelper.setMessage("ERROR_INVALIDPHONE", <wcf:json object="${ERROR_INVALIDPHONE}"/>);
         MessageHelper.setMessage("ERROR_LastNameEmpty", <wcf:json object="${ERROR_LastNameEmpty}"/>);
         MessageHelper.setMessage("ERROR_AddressEmpty", <wcf:json object="${ERROR_AddressEmpty}"/>);
         MessageHelper.setMessage("ERROR_CityEmpty", <wcf:json object="${ERROR_CityEmpty}"/>);
         MessageHelper.setMessage("ERROR_StateEmpty", <wcf:json object="${ERROR_StateEmpty}"/>);
         MessageHelper.setMessage("ERROR_CountryEmpty", <wcf:json object="${ERROR_CountryEmpty}"/>);
         MessageHelper.setMessage("ERROR_ZipCodeEmpty", <wcf:json object="${ERROR_ZipCodeEmpty}"/>);
         MessageHelper.setMessage("ERROR_EmailEmpty", <wcf:json object="${ERROR_EmailEmpty}"/>);
         MessageHelper.setMessage("ERROR_LogonIdEmpty", <wcf:json object="${ERROR_LogonIdEmpty}"/>);
         MessageHelper.setMessage("ERROR_EmployeeIdEmpty", <wcf:json object="${ERROR_EmployeeIdEmpty}"/>)
         MessageHelper.setMessage("ERROR_PasswordEmpty", <wcf:json object="${ERROR_PasswordEmpty}"/>);
         MessageHelper.setMessage("ERROR_VerifyPasswordEmpty", <wcf:json object="${ERROR_VerifyPasswordEmpty}"/>);
         MessageHelper.setMessage("ERROR_MESSAGE_TYPE", <wcf:json object="${ERROR_MESSAGE_TYPE}"/>);
         MessageHelper.setMessage("ERROR_SpecifyYear", <wcf:json object="${ERROR_SpecifyYear}"/>);
         MessageHelper.setMessage("ERROR_SpecifyMonth", <wcf:json object="${ERROR_SpecifyMonth}"/>);
         MessageHelper.setMessage("ERROR_SpecifyDate", <wcf:json object="${ERROR_SpecifyDate}"/>);
         MessageHelper.setMessage("ERROR_InvalidDate1", <wcf:json object="${ERROR_InvalidDate1}"/>);
         MessageHelper.setMessage("ERROR_InvalidDate2", <wcf:json object="${ERROR_InvalidDate2}"/>);
         MessageHelper.setMessage("ERROR_MOBILE_PHONE_EMPTY", <wcf:json object="${ERROR_MOBILE_PHONE_EMPTY}"/>);
         MessageHelper.setMessage("ERROR_PhoneTooLong", <wcf:json object="${ERROR_PhoneTooLong}"/>);
         MessageHelper.setMessage("ERROR_OrgNameEmpty", <wcf:json object="${ERROR_OrgNameEmpty}"/>);
      </script>

       <script type="text/javascript">
              function popupWindow(URL) {
                     window.open(URL, "mywindow", "status=1,scrollbars=1,resizable=1");
              }
       </script>     
       
      <script type="text/javascript">
         dojo.addOnLoad(temp);
         function temp(){
            LogonForm.setAjaxVar("true");
         }
      </script>
     
   </head>

   <wcf:url var="SignOnURL" value="LogonForm">
      <wcf:param name="langId" value="${langId}"/>
      <wcf:param name="storeId" value="${WCParam.storeId}" />
      <wcf:param name="catalogId" value="${WCParam.catalogId}" />
      <wcf:param name="myAcctMain" value="1" />
   </wcf:url>


   <body>
      <%@ include file="../../../include/StoreCommonUtilities.jspf"%>

      <c:set var="formName" value="document.OrganizationRegistrationAddForm.name"/>

      <!-- Page Start -->
      <div id="page">
         <!-- Header Nav Start -->
         <%@ include file="../../../include/LayoutContainerTop.jspf"%>
		<c:url var="url" value="StoreView">
			<c:param name="page" value="account" />
		</c:url>

         <form name="OrganizationRegistrationAddForm" method="post" action="BuyerRegistrationAdd" id="OrganizationRegistrationAddForm">
            <input type="hidden" name="storeId"   value="<c:out value="${WCParam.storeId}"  />" id="WC_OrganizationRegistration_1"/>
            <input type="hidden" name="catalogId" value="<c:out value="${WCParam.catalogId}"/>" id="WC_OrganizationRegistration_2"/>
            <input type="hidden" name="URL" value="<c:out value="${url}&usr_logonId*=&usr_firstName*=&usr_lastName*=&usr_address1*=&usr_address2*=&usr_city*=&usr_country*=&usr_state*=&usr_zipCode*=&usr_email1*=&usr_phone1*=&org_orgEntityName*=&org_address1*=&org_address2*=&org_city*=&org_country*=&org_state*=&org_zipCode*=&org_email1*=&org_phone1*="/>" id="WC_OrganizationRegistration_4"/>
            <input type="hidden" name="page" value="account" id="WC_OrganizationRegistration_5"/>
            <input type="hidden" name="errorViewName" value="OrganizationRegistrationAddForm" id="WC_OrganizationRegistration_6"/>
            <input type="hidden" name="new" value="Y" id="WC_OrganizationRegistration_7"/>
            <input type="hidden" name="usr_profileType" value="B" id="WC_OrganizationRegistration_8"/>
            <input type="hidden" name="reloadStates" value="" id="WC_OrganizationRegistration_9"/>
            <input type="hidden" name="receiveSMSNotification" value="" id="WC_UserRegistrationAddForm_FormInput_receiveSMSNotification_In_Register_1"/>
            <input type="hidden" name="receiveSMS" value="" id="WC_UserRegistrationAddForm_FormInput_receiveSMSPreference_In_Register_1"/>
            

            <!-- Main Content Start -->
            <div id="content_wrapper_border">
               <!-- Content Start -->
               <div id="box">
                  <div class="sign_in_registration">
                     <div class="sign_in_registration" id="WC_OrganizationRegistration_10">
                        <div class="title" id="WC_OrganizationRegistration_11">
                           <h1><span class="myaccount_title"><fmt:message key="OR_CREATE" bundle="${storeText}"/></span> <fmt:message key="OR_PROFILE" bundle="${storeText}"/></h1>
                        </div>
                        <div class="form" id="WC_OrganizationRegistration_12">

                           <div class="header_registration" id="WC_OrganizationRegistration_13">
                              <div class="heading" id="WC_OrganizationRegistration_14">
                                 <h2 class="black"><fmt:message key="OR_REG_TEXT1" bundle="${storeText}"/></h2>
                              </div>
                           </div>


                           <div class="content" id="WC_OrganizationRegistration_15">
                              <div class="align" id="WC_OrganizationRegistration_16">


                                 <c:set var="street"         value="${WCParam.org_address1}"/>
                                 <c:set var="street2"        value="${WCParam.org_address2}"/>
                                 <c:set var="city"           value="${WCParam.org_city}"/>
                                 <c:set var="state"          value="${WCParam.org_state}"/>
                                 <c:set var="country1"        value="${WCParam.org_country}"/>
                                 <c:set var="zipCode"        value="${WCParam.org_zipCode}"/>
                                 <c:set var="phone1"         value="${WCParam.org_phone1}"/>
                                 <c:set var="email1"         value="${WCParam.org_email1}"/>

                                 <c:set var="paramPrefix" value="org_" scope="request"/>
                                 <c:set var="pageName" value="OrganizationRegistrationAddForm" scope="request"/>

                                 
                                 <c:set var="defaultCountry" value="${country1}"/>
                                 <c:if test="${empty defaultCountry}">
                                    <c:set var="defaultCountry" value="AF"/>
                                 </c:if>
									
                                 <wcbase:useBean id="countryBean" classname="com.ibm.commerce.user.beans.CountryStateListDataBean">
                                    <c:set target="${countryBean}" property="countryCode" value="${country1}"/>
                                 </wcbase:useBean>

                                 <%-- organization info below--%>
                                 <div class="form_2column" id="WC_OrganizationRegistration_17">
                                    <c:if test="${!empty errorMessage}">
                                       <fmt:message var ="msgType" key="ERROR_MESSAGE_TYPE" bundle="${storeText}"/>
                                       <c:set var = "errorMessage" value ="${msgType}${errorMessage}"/>                                   
                                       <span id="UserRegistrationErrorMessage" class="error_msg" tabindex="-1"><c:out value="${errorMessage}"/></span><br/>
                                       <script type="text/javascript">
                                          setTimeout("dojo.byId('UserRegistrationErrorMessage').focus()",2000);
                                       </script>
                                       <br/>
                                    </c:if>

                                    <div class="required-field" id="WC_OrganizationRegistration_18"> *</div>
                                    <fmt:message key="REQUIRED_FIELDS" bundle="${storeText}"/><br />
                                    <br />
                                    <div class="column"  id="WC_OrganizationRegistration_19">
                                       <div id="WC_OrganizationRegistration_20">
                                          <label for="<c:out value='WC_${pageName}_AddressEntryForm_FormInput_${paramPrefix}orgname'/>" class="nodisplay">
		                                          	<fmt:message key="ACCESSIBLE_LABEL_TEXT" bundle="${storeText}">
																						    <fmt:param><fmt:message key="OR_ORGNAME" bundle="${storeText}"/></fmt:param>
																						    <fmt:param><fmt:message key="ACCESSIBLE_LABEL_REQUIRED_INFO" bundle="${storeText}"/></fmt:param></fmt:message>
																					</label>
                                             <div class="required-field"  id="WC_OrganizationRegistration_21"> *</div>
                                             <fmt:message key="OR_ORGNAME" bundle="${storeText}"/>
                                          
                                       </div>
                                       <input id="<c:out value='WC_${pageName}_AddressEntryForm_FormInput_${paramPrefix}orgname'/>" name="<c:out value="${paramPrefix}orgEntityName"/>" type="text" size="35" value="<c:out value="${WCParam.org_orgEntityName}"/>"/>

                                    </div>
                                    <br clear="all" />
									                                    
                                    <c:set var="nameField" value="hide" scope="page"/>
                                    <c:set var="B2BShowNameField" value="false" scope="page"/>
                                    <c:set var="B2BShowUseOrgAddress" value="false" scope="page"/>
                                    <c:choose>
                                       <c:when test="${locale == 'zh_CN'}">
                                          <%@ include file="../../../Snippets/ReusableObjects/AddressEntryForm_CN.jspf"%>
                                       </c:when>
                                       <c:when test="${locale == 'zh_TW'}">
                                          <%@ include file="../../../Snippets/ReusableObjects/AddressEntryForm_TW.jspf"%>
                                       </c:when>
                                       <c:when test="${locale == 'ru_RU'}">
                                          <%@ include file="../../../Snippets/ReusableObjects/AddressEntryForm_RU.jspf"%>
                                       </c:when>
                                       <c:when test="${locale == 'ja_JP' || locale == 'ko_KR'}">
                                          <%@ include file="../../../Snippets/ReusableObjects/AddressEntryForm_JP_KR.jspf"%>
                                       </c:when>
                                       <c:when test="${locale == 'de_DE' || locale == 'es_ES' || locale == 'fr_FR' || locale == 'it_IT' || locale == 'ro_RO'}">
                                          <%@ include file="../../../Snippets/ReusableObjects/AddressEntryForm_DE_ES_FR_IT_RO.jspf"%>
                                       </c:when>
                                       <c:when test="${locale == 'pl_PL'}">
                                          <%@ include file="../../../Snippets/ReusableObjects/AddressEntryForm_PL.jspf"%>
                                       </c:when>
                                       <c:otherwise>
                                          <%@ include file="../../../Snippets/ReusableObjects/AddressEntryForm.jspf"%>
                                       </c:otherwise>
                                    </c:choose>


                                    <div class="column"  id="WC_OrganizationRegistration_23">
                                       <div  id="WC_OrganizationRegistration_24">
                                          <label for="<c:out value='WC_${pageName}_AddressEntryForm_FormInput_${paramPrefix}email1_In_Register_1'/>">
                                             <div class="required-field"  id="WC_OrganizationRegistration_25"> *</div>
                                          <fmt:message key="EMAIL" bundle="${storeText}"/></label>
                                       </div>
                                       <input type="text" size="35" maxlength="50" id="<c:out value='WC_${pageName}_AddressEntryForm_FormInput_${paramPrefix}email1_In_Register_1'/>" value="<c:out value="${email1}"/>" name="<c:out value="${paramPrefix}"/>email1" />
                                    </div>
                                    <br clear="all" />
                                    <div class="column"  id="WC_OrganizationRegistration_27">
                                       <div  id="WC_OrganizationRegistration_28">
                                          <label for="<c:out value='WC_${pageName}_AddressEntryForm_FormInput_${paramPrefix}phoneNum_In_Register_1'/>">
                                             
                                             <fmt:message key="PHONE_NUMBER2" bundle="${storeText}"/>
                                          </label>
                                       </div>
                                       <input type="text" size="35" maxlength="32" id="<c:out value='WC_${pageName}_AddressEntryForm_FormInput_${paramPrefix}phoneNum_In_Register_1'/>" value="<c:out value="${phone1}"/>" name="<c:out value="${paramPrefix}"/>phone1" />
                                    </div>
                                    <br clear="all"/>
                                 </div>
                              </div>

                              <%--
                              /////////////////////////////////////////////////
                              //     organization administrative info below
                              /////////////////////////////////////////////////
                              --%>
                              <c:set var="paramPrefix" value="usr_" scope="request"/>
                              <div class="secondary_registration_box" id="WC_OrganizationRegistration_31">
                                 <div class="heading" id="WC_OrganizationRegistration_32">
                                    <h2 class="blue"><fmt:message key="OR_REG_TEXT2" bundle="${storeText}"/></h2>
                                 </div>
                              </div>
                              <div class="align" id="WC_OrganizationRegistration_33">
                                 <div class="form_2column" id="WC_OrganizationRegistration_34">

                                    <div class="required-field" id="WC_OrganizationRegistration_35"> *</div>
                                    <fmt:message key="REQUIRED_FIELDS" bundle="${storeText}"/><br />
                                    <br />
                                    <div class="column" id="WC_OrganizationRegistration_36">
                                       <div id="WC_OrganizationRegistration_37">
                                          <label for="<c:out value='WC_${pageName}_UserSection_FormInput_${paramPrefix}logonId_1'/>" class="nodisplay">
                                          	<fmt:message key="ACCESSIBLE_LABEL_TEXT" bundle="${storeText}">
																				    <fmt:param><fmt:message key="LOGON_ID" bundle="${storeText}"/></fmt:param>
																				    <fmt:param><fmt:message key="ACCESSIBLE_LABEL_REQUIRED_INFO" bundle="${storeText}"/></fmt:param></fmt:message>
																				 </label>
                                             <div class="required-field" id="WC_OrganizationRegistration_38"> *</div>
                                             <fmt:message key="LOGON_ID" bundle="${storeText }"/>
                                         
                                       </div>
                                       <input id="<c:out value='WC_${pageName}_UserSection_FormInput_${paramPrefix}logonId_1'/>" name="usr_logonId" type="text" value="<c:out value="${WCParam.usr_logonId}"/>" size="35" />
                                    </div>

                                    <br clear="all" />
                                    <div class="column" id="WC_OrganizationRegistration_44">
                                       <label for = "<c:out value='WC_{${pageName}_UserSection_FormInput_${paramPrefix}password_1'/>" class="nodisplay">
                                          	<fmt:message key="ACCESSIBLE_LABEL_TEXT" bundle="${storeText}">
																				    <fmt:param><fmt:message key="PASSWORD3" bundle="${storeText}"/></fmt:param>
																				    <fmt:param><fmt:message key="ACCESSIBLE_LABEL_REQUIRED_INFO" bundle="${storeText}"/></fmt:param></fmt:message>
                                       </label>
                                          <div id="WC_OrganizationRegistration_45">
                                             <div class="required-field" id="WC_OrganizationRegistration_46"> *</div>
                                          <fmt:message key="PASSWORD3" bundle="${storeText}"/></div>
                                          <input id="<c:out value='WC_{${pageName}_UserSection_FormInput_${paramPrefix}password_1'/>" name="logonPassword" type="password" value="<c:out value="${WCParam.logonPassword}"/>" size="35" />
                                       
                                    </div>
                                    <div class="column" id="WC_OrganizationRegistration_48">
                                       <label for="<c:out value='WC_${pageName}_UserSection_FormInput_${paramPrefix}password_verify_1'/>" class="nodisplay">
                                          	<fmt:message key="ACCESSIBLE_LABEL_TEXT" bundle="${storeText}">
																				    <fmt:param><fmt:message key="VERIFY_PASSWORD3" bundle="${storeText}"/></fmt:param>
																				    <fmt:param><fmt:message key="ACCESSIBLE_LABEL_REQUIRED_INFO" bundle="${storeText}"/></fmt:param></fmt:message>
                                       </label>
                                          <div id="WC_OrganizationRegistration_49">
                                             <div class="required-field" id="WC_OrganizationRegistration_50"> *</div>
                                          <fmt:message key="VERIFY_PASSWORD3" bundle="${storeText}"/></div>
                                          <input id="<c:out value='WC_${pageName}_UserSection_FormInput_${paramPrefix}password_verify_1'/>" name="logonPasswordVerify" type="password" value="<c:out value="${WCParam.logonPassword}"/>" size="35" />
                                       
                                    </div>

                                    <%--
                                          ***
                                          * Start: Registration Form - First Name and Last Name fields
                                          * The layouts of these entry fields are different depending on the locale.
                                          ***
                                    --%>
                                    <c:set var="firstName"                    value="${WCParam.usr_firstName}"/>
                                    <c:set var="lastName"                     value="${WCParam.usr_lastName}"/>
									<c:set var="middleName"                   value="${WCParam.usr_middleName}"/>
                                    <c:set var="street"                       value="${WCParam.usr_address1}"/>
                                    <c:set var="street2"                      value="${WCParam.usr_address2}"/>
                                    <c:set var="city"                         value="${WCParam.usr_city}"/>
                                    <c:set var="state"                        value="${WCParam.usr_state}"/>
                                    <c:set var="country1"                     value="${WCParam.usr_country}"/>
                                    <c:set var="zipCode"                      value="${WCParam.usr_zipCode}"/>
                                    <c:set var="phone1"                       value="${WCParam.usr_phone1}"/>
                                    <c:set var="email1"                       value="${WCParam.usr_email1}"/>
                                    <c:set var="preferredCurrency"            value="${WCParam.usr_preferredCurrency}"/>
                                    <c:set var="preferredLanguage"            value="${WCParam.usr_preferredLanguage}"/>
									<c:set var="receiveSMSNotification"		  value="${WCParam.receiveSMSNotification}"/>
 									<c:set var="mobilePhoneNumber1"			  value="${WCParam.mobilePhone1}"/>
                                    <%--
                                          ***
                                          * End: Registration Form - First Name and Last Name fields
                                          ***
                                    --%>
                                    
                                    <br clear="all"/>
                                    <c:set var="B2BShowNameField" value="true" scope="page"/>
                                    <c:set var="B2BShowUseOrgAddress" value="true" scope="page"/>
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
                                          <input type="hidden" id="AddressForm_FieldsOrderByLocale" value="first_name,LAST_NAME,ADDRESS,CITY,COUNTRY/REGION,STATE/PROVINCE,ZIP"/>
                                       </c:otherwise>
                                    </c:choose>
                                    <c:remove var="B2BShowNameField" scope="page" />
                                    <c:remove var="B2BShowUseOrgAddress" scope="page" />
									<c:set var="paramSource" value="${WCParam}"/>  
									<br clear="all" />
                                    <div class="column" id="WC_OrganizationRegistration_52">
                                       <label for="<c:out value='WC_${pageName}_UserSection_FormInput_${paramPrefix}email_2'/>">
                                          <div id="WC_OrganizationRegistration_53">
                                             <div class="required-field" id="WC_OrganizationRegistration_54"> *</div>
                                          <fmt:message key="EMAIL2" bundle="${storeText}"/></div>
                                       </label>
                                       <input id="<c:out value='WC_${pageName}_UserSection_FormInput_${paramPrefix}email_2'/>" name="<c:out value="${paramPrefix}email1"/>" value="<c:out value="${email1}"/>" type="text" size="35" />
                                    </div>

									<div class="column" id="WC_OrganizationRegistration_62">
                                       <label for ="<c:out value='WC_${pageName}_UserSection_FormInput_${paramPrefix}phone_2'/>">
                                          <div id="WC_OrganizationRegistration_63">
                                             
                                          <fmt:message key="PHONE_NUMBER2" bundle="${storeText}"/></div>
                                       </label>
                                       <input id="<c:out value='WC_${pageName}_UserSection_FormInput_${paramPrefix}phone_2'/>" name="<c:out value="${paramPrefix}"/>phone1" value="<c:out value="${phone1}"/>" type="text" size="35" />
                                    </div>
                                    
                                    <br clear="all" />
                                    <%@ include file="../../../Snippets/ReusableObjects/RegistrationFlexFlows.jspf"%>    
                                    <div class="clear_both"></div>                                 
                                 </div>
                              </div>
                           </div>
                           
							<div class="clear_both"></div>
                           <div class="twisty_align"  id="WC_OrganizationRegistration_71">
	           			      <span class="primary_button button_fit" id="WC_AccountDisplay_div_24">
								<span class="button_container">
									<span class="button_bg">
										<span class="button_top">
											<span class="button_bottom">   
												 <a href="JavaScript:B2BLogonForm.prepareSubmitOrgReg(document.OrganizationRegistrationAddForm);" id="WC_OrgRegistrationAddForm_links_1">	
													<fmt:message key="SUBMIT" bundle="${storeText}"/>
												</a>
											</span>
										</span>	
									</span>
								</span>
							 </span>	                        
    				         <span class="secondary_button button_fit" id="WC_AccountDisplay_div_25">
									<span class="button_container">
										<span class="button_bg">
											<span class="button_top">
												<span class="button_bottom">
													<a href="<c:out value="${SignOnURL}"/>" class="light_button" id="WC_OrgRegistrationAddForm_links_2">   
														<fmt:message key="CANCLE" bundle="${storeText}"/>
													</a>
												</span>
											</span>	
										</span>
									</span>
							  </span>
                              <br />
                           </div>
                           <div class="footer" id="WC_OrganizationRegistration_72">
                              <div class="left_corner" id="WC_OrganizationRegistration_73"></div>
                              <div class="left" id="WC_OrganizationRegistration_74"></div>
                              <div class="right_corner" id="WC_OrganizationRegistration_75"></div>
                           </div>
                           <br />
                        </div>
                     </div>
                  </div>
                  <!-- Content End -->
               </div>
               <!-- Main Content End -->

            </div>

         </form>
         <!-- Footer Start Start -->
         <%@ include file="../../../include/LayoutContainerBottom.jspf"%>
         <!-- Footer Start End -->
      </div>

      <div id="page_shadow" class="shadow"></div>
	  <flow:ifEnabled feature="Analytics"><cm:pageview/></flow:ifEnabled>
   </body>
</html>

