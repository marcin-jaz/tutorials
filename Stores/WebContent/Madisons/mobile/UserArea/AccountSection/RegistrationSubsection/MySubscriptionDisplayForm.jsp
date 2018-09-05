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

<%-- 
  *****
  * This JSP displays the users mysubscription page. 
  *****
--%>

<!-- BEGIN MySubscriptionDisplayForm.jsp -->

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>

<%@ include file="../../../../include/parameters.jspf" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf" %>
<%@ include file="../../../include/ErrorMessageSetup.jspf" %>


<c:choose>
	<%--	Test to see if user is logged in. If not, redirect to the login page. 
			After logging in, we will be redirected back to this page.
	 --%>
	<c:when test="${userType == 'G'}">
		<wcf:url var="LoginURL" value="MobileLogonForm">
			<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
			<wcf:param name="storeId" value="${WCParam.storeId}"/>
			<wcf:param name="langId" value="${WCParam.langId}"/>
			<wcf:param name="URL" value="mMySubscriptionDisplay"/>
		</wcf:url>

		<%out.flush();%>
		<c:import url="${LoginURL}"/>
		<%out.flush();%>
	</c:when>
	<c:otherwise>

		<c:set var="accountPageGroup" value="true" scope="request" />
		<c:set var="subscriptionDisplayPage" value="true" scope="request" />
		
		<wcf:getData type="com.ibm.commerce.member.facade.datatypes.PersonType" var="person" expressionBuilder="findCurrentPerson">
		       <wcf:param name="accessProfile" value="IBM_All" />
		</wcf:getData>
		
		<c:set var="email" value="${person.contactInfo.emailAddress1.value}"/>
		<c:set var="receiveSMSNotification" value="${person.personalProfile.receiveSMSNotification}"/>
		<c:set var="mobilePhoneNumber1" value="${person.contactInfo.mobilePhone1.value}"/>
		<c:set var="mobilePhoneNumber1Country" value="${person.contactInfo.mobilePhone1.country}"/>
		<c:set var="mobilePhoneNumber1CountryCode" value=""/>
		<c:set var="receiveSMS" value="${person.personalProfile.receiveSMSPreference[0].value}"/>
		
		
		<wcbase:useBean id="bnEmailUserReceive" classname="com.ibm.commerce.emarketing.beans.EmailUserReceiveDataBean">
			<c:set property="usersId" value="${CommandContext.userId}" target="${bnEmailUserReceive}" />
		</wcbase:useBean>
		
		<wcf:url var="AccountDispURL" value="mMyAccountDisplay">
		  	<wcf:param name="langId" value="${langId}" />
		  	<wcf:param name="storeId" value="${WCParam.storeId}" />
		  	<wcf:param name="catalogId" value="${WCParam.catalogId}" />
		</wcf:url>
		
		<wcf:url var="MySubscriptionErrorDisplay" value="mMySubscriptionDisplay">
		  	<wcf:param name="langId" value="${langId}" />
		  	<wcf:param name="storeId" value="${WCParam.storeId}" />
		  	<wcf:param name="catalogId" value="${WCParam.catalogId}" />
		  	<wcf:param name="errorView" value="true" />
		</wcf:url>
		
		
		<c:if test="${empty errorMessage && WCParam.errorView && WCParam.errorView=='true'}">
			<fmt:message var="errorMessage" key="ERR_MISSING_MOBILE_PHONE_NUMBER" bundle="${storeText}" />	
		</c:if>
		
		<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.2//EN" "http://www.openmobilealliance.org/tech/DTD/xhtml-mobile12.dtd">

		<html xmlns="http://www.w3.org/1999/xhtml" lang="${shortLocale}" xml:lang="${shortLocale}">
		
			<head>
		
				<title>
					<fmt:message key="SUB_SCR_TITLE" bundle="${storeText}"/> - <c:out value="${storeName}"/>
				</title>
				
				<meta name="description" content="${category.description.longDescription}"/>
				<meta name="keyword" content="${category.description.keyWord}"/>
				<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no" />
				<link rel="stylesheet" href="${cssPath}" type="text/css"/>
		
				<%@ include file="../../../Snippets/ReusableObjects/AddressHelperCountrySelection.jspf" %>
				<script type="text/javascript" src="${jspStoreImgDir}mobile/javascript/Subscription.js"></script>
		
			</head>
			
			<body>
				
				<div id="wrapper">
				
					<%@ include file="../../../include/HeaderDisplay.jspf" %>
					<%@ include file="../../../include/BreadCrumbTrailDisplay.jspf"%>
					
						<div id="my_subscriptions" class="content_box">
							<div class="heading_container">
								<h2><fmt:message key="SUB_SCR_TITLE" bundle="${storeText}"/></h2>
								<div class="clear_float"></div>
							</div>
		
							<p class="paragraph_blurb"><fmt:message key="SUB_SCR_DESCRIPTION" bundle="${storeText}"/></p>
						</div>
						
						<c:if test="${!empty errorMessage}">
							<span id="error" class="error"><br/><c:out value="${errorMessage}"/><br/><br/></span>
						</c:if>
						
										
						<div id="my_subscriptions_emails" class="content_box">
							<div class="heading_container">
								<h2><fmt:message key="EMAIL" bundle="${storeText}"/></h2>
								<div class="clear_float"></div>
							</div>
							
							<form id="my_subscriptions_emails_form">
								<fieldset>
									<div class="checkbox_container">
										<input type="checkbox" id="sendMeEmail" name="sendMeEmail" <c:if test="${bnEmailUserReceive.userReceive}">checked="true"</c:if> />
		                                                          <label for="sendMeEmail"><fmt:message key="REGNEW_SENDMEEMAIL" bundle="${storeText}"/></label>						
									</div>
								</fieldset>
							</form>
						</div>
		
		
					<div id="my_subscriptions_texting" class="content_box">
						<div class="heading_container">
							<h2><fmt:message key="MOBILE_TEXT" bundle="${storeText}"/></h2>
							<div class="clear_float"></div>
						</div>
													
						<p class="bold"><fmt:message key="MOBILE_PHONE_NUMBER" bundle="${storeText}"/></p>
													
						<form method="post" action="PersonChangeServicePersonUpdate" id="my_subscriptions_texting_form">
							<fieldset>
									  
								<input type="hidden" name="storeId" value="${WCParam.storeId}" id="storeId"/>
								<input type="hidden" name="catalogId" value="${WCParam.catalogId}" id="catalogId"/>
								<input type="hidden" name="langId" value="${langId}" id="langId"/>
								<input type="hidden" name="errorViewName" value="mSubscriptionDisplay" id="errorview"/>
								<input type="hidden" name="editRegistration" value="Y" id="editreg"/>
								<input type="hidden" name="registerType" value="RegisteredPerson" id="register"/>
								<input type="hidden" name="receiveEmail" value="" id="receiveEmail"/>
								<input type="hidden" name="receiveSMSNotification" value="" id="receiveSMSNotification"/>
								<input type="hidden" name="mobileDeviceEnabled" value="true" id="mobile"/>
								<input type="hidden" name="receiveSMS" value="" id="receiveSMS"/>
								<input type="hidden" name="logonId" value="${person.credential.logonID}" id="logonId"/>
								<input type="hidden" name="URL" value="${fn:escapeXml(AccountDispURL)}" id="acationUrl"/>
								<input type="hidden" name="authToken" value="${authToken}"/>
																	
								<div class="dropdown_container">
									<div><label for="country"><fmt:message key="MOBILE_COUNTRY" bundle="${storeText}"/></label></div>
									<select class="coloured_input" id="country" name="mobilePhone1Country" onchange="javascript:Subscription.loadCountryCode('country','mobileCountryCode1')">
										<c:forEach var="mobileCountry" items="${countryBean.countries}">
											<option value="${mobileCountry.code}"
												<c:if test="${mobileCountry.code eq mobilePhoneNumber1Country || mobileCountry.displayName eq mobilePhoneNumber1Country}">
													selected="selected"
													<c:set var="mobilePhoneNumber1CountryCode" value="${mobileCountry.callingCode}"/>
												</c:if>
											><c:out value="${mobileCountry.displayName}"/></option>
										</c:forEach>
									</select>
								</div>
										
								<div class="input_container">
									<div><label for="mobile_number"><fmt:message key="MOBILE_PHONE_NUMBER" bundle="${storeText}"/></label></div>
									<c:set var="countryCode" value="${mobilePhoneNumber1CountryCode}"/>
									<c:if test="${mobilePhoneNumber1CountryCode==null || mobilePhoneNumber1CountryCode==''}">
										<c:set var="countryCode" value="+93"/>
									</c:if>
									<label for="mobileCountryCode1"><span style="display:none;"><fmt:message key="MOBILE_PHONE_CNTRY_CODE" bundle="${storeText}"/></span></label>
									<input type="text" id="mobileCountryCode1" name="mobileCountryCode" class="coloured_input" size="4" value="${countryCode}" readonly="readonly" tabindex="-1"/> 
									<label for="mobilePhone1"><span style="display:none;"><fmt:message key="MOBILE_PHONE_NUMBER" bundle="${storeText}"/></span></label>
									<input type="text" id="mobilePhone1" name="mobilePhone1" class="coloured_input"  value="${mobilePhoneNumber1}"/>
								</div>
								
								<div class="checkbox_container">
									<input type="checkbox" id="sendMeSMSNotification" name="sendMeSMSNotification" <c:if test="${receiveSMSNotification}"> checked="true" </c:if>  />
									<label for="sendMeSMSNotification"><fmt:message key="SMS_NOTIFY" bundle="${storeText}"/></label>
								</div>
		
								<div class="checkbox_container">
									<input type="checkbox" id="sendMeSMSPreference" name="sendMeSMSPreference" <c:if test="${receiveSMS}"> checked="true" </c:if> />
									<label for="sendMeSMSPreference"><fmt:message key="SMS_PROMO" bundle="${storeText}"/></label>
								</div>
							</fieldset>
							
							<input type="submit" id="my_subscriptions_texting_form_submit" name="my_subscriptions_texting_form_submit" value="Submit" onclick="javascript:Subscription.prepareSubmit('my_subscriptions_emails_form','my_subscriptions_texting_form','${fn:escapeXml(MySubscriptionErrorDisplay)}');"/>
						</form>
					</div>
					<%@ include file="../../../include/FooterDisplay.jspf" %>				
				</div>				
			</body>			
		</html>
	</c:otherwise>
</c:choose>

<!-- END MySubscriptionDisplayForm.jsp -->
