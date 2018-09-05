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
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf" %>
<%@ include file="../../../include/nocache.jspf" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>             
<%@ taglib uri="http://commerce.ibm.com/coremetrics"  prefix="cm" %>
<%@ include file="../../../include/ErrorMessageSetup.jspf" %>
<c:set var="myAccountPage" value="true" scope="request"/>
<c:set var="hasBreadCrumbTrail" value="false" scope="request"/>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="${shortLocale}" xml:lang="${shortLocale}">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><fmt:message key="MA_PERSONAL_INFO" bundle="${storeText}"/></title>
<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${vfileStylesheet}"/>" type="text/css"/>
<!--[if lte IE 6]>
<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${vfileStylesheetie}"/>" type="text/css"/>
<![endif]-->
<script type="text/javascript" src="<c:out value="${dojoFile}"/>" djConfig="${dojoConfigParams}"></script>
<%@ include file="../../../include/CommonJSToInclude.jspf"%>
<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/UserArea/AddressHelper.js"/>"></script>
<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/UserArea/MyAccountDisplay.js"/>"></script>
<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/MessageHelper.js"/>"></script>

<script type="text/javascript">  
	dojo.addOnLoad(function() { 
	//messages used by AddressBookForm.js
	<fmt:message key="ERROR_FirstNameTooLong" bundle="${storeText}"  var="ERROR_FirstNameTooLong"/>
	<fmt:message key="ERROR_LastNameTooLong" bundle="${storeText}" var="ERROR_LastNameTooLong"/>
	<fmt:message key="ERROR_MiddleNameTooLong" bundle="${storeText}" var="ERROR_MiddleNameTooLong"/>
	<fmt:message key="ERROR_AddressTooLong" bundle="${storeText}" var="ERROR_AddressTooLong"/>
	<fmt:message key="ERROR_CityTooLong" bundle="${storeText}" var="ERROR_CityTooLong"/>
	<fmt:message key="ERROR_StateTooLong" bundle="${storeText}" var="ERROR_StateTooLong"/>
	<fmt:message key="ERROR_CountryTooLong" bundle="${storeText}" var="ERROR_CountryTooLong"/>
	<fmt:message key="ERROR_ZipCodeTooLong" bundle="${storeText}" var="ERROR_ZipCodeTooLong"/>
	<fmt:message key="ERROR_PhoneTooLong" bundle="${storeText}" var="ERROR_PhoneTooLong"/>
	<fmt:message key="ERROR_FirstNameEmpty" bundle="${storeText}" var="ERROR_FirstNameEmpty"/>
	<fmt:message key="ERROR_LastNameEmpty" bundle="${storeText}" var="ERROR_LastNameEmpty"/>
	<fmt:message key="ERROR_MiddleNameEmpty" bundle="${storeText}" var="ERROR_MiddleNameEmpty"/>
	<fmt:message key="ERROR_AddressEmpty" bundle="${storeText}" var="ERROR_AddressEmpty"/>
	<fmt:message key="ERROR_CityEmpty" bundle="${storeText}" var="ERROR_CityEmpty"/>
	<fmt:message key="ERROR_StateEmpty" bundle="${storeText}" var="ERROR_StateEmpty"/>
	<fmt:message key="ERROR_CountryEmpty" bundle="${storeText}" var="ERROR_CountryEmpty"/>
	<fmt:message key="ERROR_ZipCodeEmpty" bundle="${storeText}" var="ERROR_ZipCodeEmpty"/>
	<fmt:message key="ERROR_PhonenumberEmpty" bundle="${storeText}" var="ERROR_PhonenumberEmpty"/>
	<fmt:message key="ERROR_EmailEmpty" bundle="${storeText}" var="ERROR_EmailEmpty"/>
	<fmt:message key="ERROR_INVALIDPHONE" bundle="${storeText}" var="ERROR_INVALIDPHONE"/>
	<fmt:message key="ERROR_INVALIDEMAILFORMAT" bundle="${storeText}" var="ERROR_INVALIDEMAILFORMAT"/>
	<fmt:message key="PWDREENTER_DO_NOT_MATCH" bundle="${storeText}" var="PWDREENTER_DO_NOT_MATCH"/>
	<fmt:message key="REQUIRED_FIELD_ENTER" bundle="${storeText}" var="REQUIRED_FIELD_ENTER"/>
	<fmt:message key="ERROR_SpecifyYear" bundle="${storeText}" var="ERROR_SpecifyYear"/>
	<fmt:message key="ERROR_SpecifyMonth" bundle="${storeText}" var="ERROR_SpecifyMonth"/>
	<fmt:message key="ERROR_SpecifyDate" bundle="${storeText}" var="ERROR_SpecifyDate"/>
	<fmt:message key="ERROR_InvalidDate1" bundle="${storeText}" var="ERROR_InvalidDate1"/>
	<fmt:message key="ERROR_InvalidDate2" bundle="${storeText}" var="ERROR_InvalidDate2"/>
	<fmt:message key="WISHLIST_MISSINGNAME" bundle="${storeText}"  var="WISHLIST_MISSINGNAME"/>
	<fmt:message key="WISHLIST_MISSINGEMAIL" bundle="${storeText}"  var="WISHLIST_MISSINGEMAIL"/>
	<fmt:message key="WISHLIST_INVALIDEMAILFORMAT" bundle="${storeText}" var="WISHLIST_INVALIDEMAILFORMAT"/>
	<fmt:message key="EDPPaymentMethods_INVALID_EXPIRY_DATE" bundle="${storeText}" var="EDPPaymentMethods_INVALID_EXPIRY_DATE"/>

	MessageHelper.setMessage("ERROR_FirstNameTooLong", <wcf:json object="${ERROR_FirstNameTooLong}"/>);
	MessageHelper.setMessage("ERROR_LastNameTooLong", <wcf:json object="${ERROR_LastNameTooLong}"/>);
	MessageHelper.setMessage("ERROR_MiddleNameTooLong", <wcf:json object="${ERROR_MiddleNameTooLong}"/>);
	MessageHelper.setMessage("ERROR_AddressTooLong", <wcf:json object="${ERROR_AddressTooLong}"/>);
	MessageHelper.setMessage("ERROR_CityTooLong", <wcf:json object="${ERROR_CityTooLong}"/>);
	MessageHelper.setMessage("ERROR_StateTooLong", <wcf:json object="${ERROR_StateTooLong}"/>);
	MessageHelper.setMessage("ERROR_CountryTooLong", <wcf:json object="${ERROR_CountryTooLong}"/>);
	MessageHelper.setMessage("ERROR_ZipCodeTooLong", <wcf:json object="${ERROR_ZipCodeTooLong}"/>);
	MessageHelper.setMessage("ERROR_PhoneTooLong", <wcf:json object="${ERROR_PhoneTooLong}"/>);
	/*Although for English, firstname is not mandatory. But it is mandatory for other languages.*/
	MessageHelper.setMessage("ERROR_FirstNameEmpty", <wcf:json object="${ERROR_FirstNameEmpty}"/>);		
	MessageHelper.setMessage("ERROR_LastNameEmpty", <wcf:json object="${ERROR_LastNameEmpty}"/>);
	MessageHelper.setMessage("ERROR_MiddleNameEmpty", <wcf:json object="${ERROR_MiddleNameEmpty}"/>);
	MessageHelper.setMessage("ERROR_AddressEmpty", <wcf:json object="${ERROR_AddressEmpty}"/>);
	MessageHelper.setMessage("ERROR_CityEmpty", <wcf:json object="${ERROR_CityEmpty}"/>);
	MessageHelper.setMessage("ERROR_StateEmpty", <wcf:json object="${ERROR_StateEmpty}"/>);
	MessageHelper.setMessage("ERROR_CountryEmpty", <wcf:json object="${ERROR_CountryEmpty}"/>);
	MessageHelper.setMessage("ERROR_ZipCodeEmpty", <wcf:json object="${ERROR_ZipCodeEmpty}"/>);
	MessageHelper.setMessage("ERROR_PhonenumberEmpty", <wcf:json object="${ERROR_PhonenumberEmpty}"/>);
	MessageHelper.setMessage("ERROR_EmailEmpty", <wcf:json object="${ERROR_EmailEmpty}"/>);
	MessageHelper.setMessage("ERROR_INVALIDPHONE", <wcf:json object="${ERROR_INVALIDPHONE}"/>);
	MessageHelper.setMessage("ERROR_INVALIDEMAILFORMAT", <wcf:json object="${ERROR_INVALIDEMAILFORMAT}"/>);

	MessageHelper.setMessage("PWDREENTER_DO_NOT_MATCH", <wcf:json object="${PWDREENTER_DO_NOT_MATCH}"/>);
	MessageHelper.setMessage("REQUIRED_FIELD_ENTER", <wcf:json object="${REQUIRED_FIELD_ENTER}"/>);
	
	MessageHelper.setMessage("ERROR_SpecifyYear", <wcf:json object="${ERROR_SpecifyYear}"/>);
	MessageHelper.setMessage("ERROR_SpecifyMonth", <wcf:json object="${ERROR_SpecifyMonth}"/>);
	MessageHelper.setMessage("ERROR_SpecifyDate", <wcf:json object="${ERROR_SpecifyDate}"/>);
	MessageHelper.setMessage("ERROR_InvalidDate1", <wcf:json object="${ERROR_InvalidDate1}"/>);
	MessageHelper.setMessage("ERROR_InvalidDate2", <wcf:json object="${ERROR_InvalidDate2}"/>);
	
	var centerLinkUrl = "${AjaxMyAccountCenterLinkDisplayURL}";
	
	//variables used by the AccountWishListDisplay page
	var centerLinkWidgetId = "MyAccountCenterLinkDisplay_Widget";
	MessageHelper.setMessage("WISHLIST_MISSINGNAME", <wcf:json object="${WISHLIST_MISSINGNAME}"/>);
	MessageHelper.setMessage("WISHLIST_MISSINGEMAIL", <wcf:json object="${WISHLIST_MISSINGEMAIL}"/>);
	MessageHelper.setMessage("WISHLIST_INVALIDEMAILFORMAT", <wcf:json object="${WISHLIST_INVALIDEMAILFORMAT}"/>);
	MessageHelper.setMessage("INVALID_EXPIRY_DATE", <wcf:json object="${EDPPaymentMethods_INVALID_EXPIRY_DATE}"/>);
	
	});
</script>
</head>

<body>
<script type="text/javascript">
		MyAccountDisplay.setAjaxVar("false");
</script>

<%@ include file="../../../include/StoreCommonUtilities.jspf"%>
<div id="page">
	<%@ include file="../../../include/LayoutContainerTop.jspf"%>

	<div id="UserRegistrationErrorMessage">
		<c:if test="${!empty errorMessage}">
			<fmt:message var ="msgType" key="ERROR_MESSAGE_TYPE" bundle="${storeText}"/>
			<c:set var = "errorMessage" value ="${msgType}${fn:escapeXml(errorMessage)}"/>
			<script type="text/javascript">
				dojo.addOnLoad(function() { 
					dojo.byId('MessageArea').style.display = "block";
					dojo.byId('ErrorMessageText').innerHTML ="${errorMessage}";
					dojo.byId('MessageArea').focus();
					setTimeout("dojo.byId('ErrorMessageText').focus()",2000);
				});
			</script>
		</c:if>
	</div>
    <!-- Main Content Start -->
	<%out.flush();%>
	<c:import url="${jspStoreDir}UserArea/AccountSection/RegistrationSubsection/RegistrationUpdateCommonPage.jsp">
	</c:import>
	<%out.flush();%>
	<!-- Main Content End -->
	
	<%@ include file="../../../include/LayoutContainerBottom.jspf"%>
</div>
<div id="page_shadow" class="shadow"></div>
<flow:ifEnabled feature="Analytics"><cm:pageview/></flow:ifEnabled>
</body>
</html>   
