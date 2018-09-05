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
<%@ taglib uri="http://commerce.ibm.com/coremetrics"  prefix="cm" %>
<%@ include file="../../../include/ErrorMessageSetup.jspf" %>
<c:set var="myAccountPage" value="true" scope="request"/>
<c:set var="hasBreadCrumbTrail" value="false" scope="request"/>

<c:set var="div1" value="display:block"/>
<c:set var="div2" value="display:none"/>
<wcbase:useBean id="countryBean" classname="com.ibm.commerce.user.beans.CountryStateListDataBean">
	<c:set target="${countryBean}" property="countryCode" value="${contact.address.country}"/>
</wcbase:useBean>

<wcf:getData var="person" type="com.ibm.commerce.member.facade.datatypes.PersonType" expressionBuilder="findCurrentPerson">
	<wcf:param name="accessProfile" value="IBM_All" />
</wcf:getData>
<c:set var="addressBookBean" value="${person.addressBook}"/>
<c:choose>
		<c:when test="${empty WCParam.selectedAddress}">
			<c:set var="selectedAddress" value="${person.contactInfo.contactInfoIdentifier.uniqueID}"/>
		</c:when>
		<c:otherwise>
			<c:set var="selectedAddress" value="${WCParam.selectedAddress}"/>
		</c:otherwise>
</c:choose>

<%-- validate the selected address...it may be the scenario that the address has been deleted 
     in this case just default to the primary address --%>
<c:set var="foundSelectedAddress" value="false"/>
<c:set var="defaultAddress" value="${person.contactInfo.contactInfoIdentifier.uniqueID}"/>
<c:choose>
	<c:when test="${selectedAddress == person.contactInfo.contactInfoIdentifier.uniqueID}">
		<c:set var="foundSelectedAddress" value="true"/>
	</c:when>
</c:choose>								
<c:if test="${!foundSelectedAddress}" >
	<c:forEach items="${addressBookBean.contact}" var="contact" varStatus="status">
		<%-- Do not show the special addresses used for quick checkout profile --%>
		<c:if test="${ contact.contactInfoIdentifier.externalIdentifier.contactInfoNickName != profileShippingNickname && contact.contactInfoIdentifier.externalIdentifier.contactInfoNickName != profileBillingNickname }" >
			<c:if test="${selectedAddress == contact.contactInfoIdentifier.uniqueID}">
				<c:set var="foundSelectedAddress" value="true"/>
			</c:if>
		</c:if>
	</c:forEach>
</c:if>
<c:if test="${!foundSelectedAddress}">
	<c:set var="selectedAddress" value="${defaultAddress}"/>
</c:if>
<wcf:url var="userRegistrationFormURL" value="NonAjaxUserRegistrationForm">
	<wcf:param name="storeId"   value="${WCParam.storeId}"  />
	<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
	<wcf:param name="langId" value="${WCParam.langId}" />
	<wcf:param name="editRegistration" value="Y" />
</wcf:url>
<wcf:url var="addressBookFormURL" value="NonAjaxAddressBookForm">
	<wcf:param name="storeId"   value="${WCParam.storeId}"  />
	<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
	<wcf:param name="langId" value="${WCParam.langId}" />
</wcf:url>
<wcf:url var="QuickCheckoutURL" value="NonAjaxProfileFormView">
	<wcf:param name="storeId"   value="${WCParam.storeId}"  />
	<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
	<wcf:param name="langId" value="${WCParam.langId}" />
</wcf:url>
<wcf:url var="trackOrderStatusURL" value="NonAjaxTrackOrderStatus">
	<wcf:param name="storeId"   value="${WCParam.storeId}"  />
	<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
	<wcf:param name="langId" value="${langId}" />
</wcf:url>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="${shortLocale}" xml:lang="${shortLocale}">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><fmt:message key="ADDRESSBOOK_TITLE" bundle="${storeText}"/></title>
<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${vfileStylesheet}"/>" type="text/css"/>
<!--[if lte IE 6]>
<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${vfileStylesheetie}"/>" type="text/css"/>
<![endif]-->

<script type="text/javascript" src="<c:out value="${dojoFile}"/>" djConfig="${dojoConfigParams}"></script>
<%@ include file="../../../include/CommonJSToInclude.jspf"%>
<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/UserArea/AddressHelper.js"/>"></script>
<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/UserArea/AddressBookForm.js"/>"></script>
<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/UserArea/MyAccountDisplay.js"/>"></script>
<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/MessageHelper.js"/>"></script>
<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/UserArea/AccountWishListDisplay.js"/>"></script>
<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/UserArea/QuickCheckoutProfile.js"/>"></script>
<script type="text/javascript">  
	//messages used by AddressBookForm.js
	dojo.addOnLoad(function() { 
		<fmt:message key="ERROR_RecipientTooLong" bundle="${storeText}" var="ERROR_RecipientTooLong"/>
		<fmt:message key="ERROR_FirstNameTooLong" bundle="${storeText}" var="ERROR_FirstNameTooLong"/>
		<fmt:message key="ERROR_LastNameTooLong" bundle="${storeText}" var="ERROR_LastNameTooLong"/>
		<fmt:message key="ERROR_MiddleNameTooLong" bundle="${storeText}" var="ERROR_MiddleNameTooLong"/>
		<fmt:message key="ERROR_AddressTooLong" bundle="${storeText}" var="ERROR_AddressTooLong"/>
		<fmt:message key="ERROR_CityTooLong" bundle="${storeText}" var="ERROR_CityTooLong"/>
		<fmt:message key="ERROR_StateTooLong" bundle="${storeText}" var="ERROR_StateTooLong"/>
		<fmt:message key="ERROR_CountryTooLong" bundle="${storeText}" var="ERROR_CountryTooLong"/>
		<fmt:message key="ERROR_ZipCodeTooLong" bundle="${storeText}" var="ERROR_ZipCodeTooLong"/>
		<fmt:message key="ERROR_PhoneTooLong" bundle="${storeText}" var="ERROR_PhoneTooLong"/>
		<fmt:message key="ERROR_RecipientEmpty" bundle="${storeText}" var="ERROR_RecipientEmpty"/>
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
		<fmt:message key="PWDREENTER_DO_NOT_MATCH" bundle="${storeText}" var="PWDREENTER_DO_NOT_MATCH"/>
		<fmt:message key="REQUIRED_FIELD_ENTER" bundle="${storeText}" var="REQUIRED_FIELD_ENTER"/>
		<fmt:message key="AB_DELETE_SUCCESS" bundle="${storeText}" var="AB_DELETE_SUCCESS"/>
		<fmt:message key="AB_ADDNEW_SUCCESS" bundle="${storeText}" var="AB_ADDNEW_SUCCESS"/>
		<fmt:message key="WISHLIST_INVALIDEMAILFORMAT" bundle="${storeText}" var="WISHLIST_INVALIDEMAILFORMAT"/>
		<fmt:message key="ERROR_INVALIDPHONE" bundle="${storeText}" var="ERROR_INVALIDPHONE"/>
		<fmt:message key="AB_SELECT_ADDRTYPE" bundle="${storeText}" var="AB_SELECT_ADDRTYPE"/>
		<fmt:message key="ERROR_DEFAULTADDRESS" bundle="${storeText}" var="ERROR_DEFAULTADDRESS"/>
		<fmt:message key="ERROR_INVALIDEMAILFORMAT" bundle="${storeText}" var="ERROR_INVALIDEMAILFORMAT"/>

		MessageHelper.setMessage("ERROR_RecipientTooLong", <wcf:json object="${ERROR_RecipientTooLong}"/>);
		MessageHelper.setMessage("ERROR_FirstNameTooLong", <wcf:json object="${ERROR_FirstNameTooLong}"/>);
		MessageHelper.setMessage("ERROR_LastNameTooLong", <wcf:json object="${ERROR_LastNameTooLong}"/>);
		MessageHelper.setMessage("ERROR_MiddleNameTooLong", <wcf:json object="${ERROR_MiddleNameTooLong}"/>);
		MessageHelper.setMessage("ERROR_AddressTooLong", <wcf:json object="${ERROR_AddressTooLong}"/>);
		MessageHelper.setMessage("ERROR_CityTooLong", <wcf:json object="${ERROR_CityTooLong}"/>);
		MessageHelper.setMessage("ERROR_StateTooLong", <wcf:json object="${ERROR_StateTooLong}"/>);
		MessageHelper.setMessage("ERROR_CountryTooLong", <wcf:json object="${ERROR_CountryTooLong}"/>);
		MessageHelper.setMessage("ERROR_ZipCodeTooLong", <wcf:json object="${ERROR_ZipCodeTooLong}"/>);
		MessageHelper.setMessage("ERROR_PhoneTooLong", <wcf:json object="${ERROR_PhoneTooLong}"/>);
		MessageHelper.setMessage("ERROR_RecipientEmpty", <wcf:json object="${ERROR_RecipientEmpty}"/>);
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
		MessageHelper.setMessage("PWDREENTER_DO_NOT_MATCH", <wcf:json object="${PWDREENTER_DO_NOT_MATCH}"/>);
		MessageHelper.setMessage("REQUIRED_FIELD_ENTER", <wcf:json object="${REQUIRED_FIELD_ENTER}"/>);
		MessageHelper.setMessage("AB_DELETE_SUCCESS", <wcf:json object="${AB_DELETE_SUCCESS}"/>);
		MessageHelper.setMessage("AB_ADDNEW_SUCCESS", <wcf:json object="${AB_ADDNEW_SUCCESS}"/>);
		MessageHelper.setMessage("WISHLIST_INVALIDEMAILFORMAT", <wcf:json object="${WISHLIST_INVALIDEMAILFORMAT}"/>);
		MessageHelper.setMessage("ERROR_INVALIDPHONE", <wcf:json object="${ERROR_INVALIDPHONE}"/>);
		MessageHelper.setMessage("AB_SELECT_ADDRTYPE", <wcf:json object="${AB_SELECT_ADDRTYPE}"/>);
		MessageHelper.setMessage("ERROR_DEFAULTADDRESS", <wcf:json object="${ERROR_DEFAULTADDRESS}"/>);
		MessageHelper.setMessage("ERROR_INVALIDEMAILFORMAT", <wcf:json object="${ERROR_INVALIDEMAILFORMAT}"/>);
		
		AddressBookFormJS.setCommonParameters("<c:out value='${langId}'/>", "<c:out value='${WCParam.storeId}'/>","<c:out value='${WCParam.catalogId}'/>");
	});
	
</script>
</head>
<body>
<%@ include file="../../../include/StoreCommonUtilities.jspf"%>
<div id="page">
	<%@ include file="../../../include/LayoutContainerTop.jspf"%>
	
	<c:if test="${!empty errorMessage}">
		<c:set var="div1" value="display:none"/>
		<c:set var="div2" value="display:block"/>
		<script type="text/javascript">MessageHelper.displayErrorMessage("<c:out value='${errorMessage}'/>");</script>
	</c:if>

	<script type="text/javascript">
		if('<c:out value="${WCParam.addressDeleted}"/>'=='true'){
			dojo.addOnLoad(function() { 
				MessageHelper.displayStatusMessage(MessageHelper.messages["AB_DELETE_SUCCESS"]);
			});
		}
		if('<c:out value="${WCParam.addressNew}"/>'=='true'){
			dojo.addOnLoad(function() { 
				MessageHelper.displayStatusMessage(MessageHelper.messages["AB_ADDNEW_SUCCESS"]);
			});
		}
	</script>
	<!-- Main Content Start -->

	<div id="box">
		<div class="my_account" id="WC_AddressBookForm_div_2">
			<div class="main_header" id="WC_AddressBookForm_div_3">
				<div class="left_corner" id="WC_AddressBookForm_div_4"></div>
				<div class="left" id="WC_AddressBookForm_div_5"><span class="main_header_text"><fmt:message key="ADDRESSBOOK_TITLE" bundle="${storeText}"/></span></div>
				<div class="right_corner" id="WC_AddressBookForm_div_6"></div>
			</div>
			<div class="content" id="WC_AddressBookForm_div_7">
				<div class="content_header" id="WC_AddressBookForm_div_8">
					<div class="left_corner" id="WC_AddressBookForm_div_9"></div>
					<div class="addrbook_header" id="WC_AddressBookForm_div_10">
						<script type="text/javascript">
							dojo.addOnLoad(function() { 
								addresses = new Array();
								addressObj = new Object();
								addressObj.nickName = "<c:out value="${person.contactInfo.contactInfoIdentifier.externalIdentifier.contactInfoNickName}"/>";
								addressObj.firstName = "<c:out value="${person.contactInfo.contactName.firstName}"/>";
								addressObj.lastName = "<c:out value="${person.contactInfo.contactName.lastName}"/>";
								addressObj.middleName = "<c:out value="${person.contactInfo.contactName.middleName}"/>";
								addressObj.address1 = "<c:out value="${person.contactInfo.address.addressLine[0]}"/>";
								addressObj.address2 = "<c:out value="${person.contactInfo.address.addressLine[1]}"/>";
								addressObj.city = "<c:out value="${person.contactInfo.address.city}"/>";
								addressObj.state = "<c:out value="${person.contactInfo.address.stateOrProvinceName}"/>";
								addressObj.country = "<c:out value="${person.contactInfo.address.country}"/>";
								addressObj.zipCode = "<c:out value="${person.contactInfo.address.postalCode}"/>";
								addressObj.email1 = "<c:out value="${person.contactInfo.emailAddress1.value}"/>";
								addressObj.phone1 = "<c:out value="${person.contactInfo.telephone1.value}"/>";
								addressObj.addressType = "<c:out value="${person.contactInfo.address.type_}"/>";
								addresses[<c:out value="${person.contactInfo.contactInfoIdentifier.uniqueID}"/>] = addressObj;
							});
						</script>
						<c:forEach items="${addressBookBean.contact}" var="contact" varStatus="status">
							<%-- Do not show the special addresses used for quick checkout profile --%>
							<c:if test="${ contact.contactInfoIdentifier.externalIdentifier.contactInfoNickName != profileShippingNickname && contact.contactInfoIdentifier.externalIdentifier.contactInfoNickName != profileBillingNickname }" >
								<script type="text/javascript">
									dojo.addOnLoad(function() { 
										addressObj = new Object();
										addressObj.nickName = "<c:out value="${contact.contactInfoIdentifier.externalIdentifier.contactInfoNickName}"/>";
										addressObj.firstName = "<c:out value="${contact.contactName.firstName}"/>";
										addressObj.lastName = "<c:out value="${contact.contactName.lastName}"/>";
										addressObj.middleName = "<c:out value="${contact.contactName.middleName}"/>";
										addressObj.address1 = "<c:out value="${contact.address.addressLine[0]}"/>";
										addressObj.address2 = "<c:out value="${contact.address.addressLine[1]}"/>";
										addressObj.city = "<c:out value="${contact.address.city}"/>";
										addressObj.state = "<c:out value="${contact.address.stateOrProvinceName}"/>";
										addressObj.country = "<c:out value="${contact.address.country}"/>";
										addressObj.zipCode = "<c:out value="${contact.address.postalCode}"/>";
										addressObj.email1 = "<c:out value="${contact.emailAddress1.value}"/>";
										addressObj.phone1 = "<c:out value="${contact.telephone1.value}"/>";
										addressObj.addressType = "<c:out value="${contact.address.type_}"/>";
										addresses[<c:out value="${contact.contactInfoIdentifier.uniqueID}"/>] = addressObj;
									});
								</script>
							</c:if>
						</c:forEach>
					
						<label for="addressId"></label>
							<select align="center" size="1" name="addressId" id="addressId" onchange="javascript:MessageHelper.hideAndClearMessage();AddressBookFormJS.populateTextFields(this,addresses,document.AddressForm);" style="width:180px" class="drop_down">
								<%-- Make sure the seleted address is displayed --%>
								<c:choose>
									<c:when test="${selectedAddress == person.contactInfo.contactInfoIdentifier.uniqueID}">
										<option selected="selected" value="<c:out value="${person.contactInfo.contactInfoIdentifier.uniqueID}"/>">
											<c:out value="${person.contactInfo.contactInfoIdentifier.externalIdentifier.contactInfoNickName}"/>
										</option>
										<c:set var="selectedContact" value="${person.contactInfo}"/>
									</c:when>
									<c:otherwise>
										<option value="<c:out value="${person.contactInfo.contactInfoIdentifier.uniqueID}"/>">
											<c:out value="${person.contactInfo.contactInfoIdentifier.externalIdentifier.contactInfoNickName}"/>
										</option>
									</c:otherwise>
								</c:choose>
								
								<c:forEach items="${addressBookBean.contact}" var="contact" varStatus="status">
									<%-- Do not show the special addresses used for quick checkout profile --%>
									<c:if test="${ contact.contactInfoIdentifier.externalIdentifier.contactInfoNickName != profileShippingNickname && contact.contactInfoIdentifier.externalIdentifier.contactInfoNickName != profileBillingNickname }" >
										<%-- Make sure the seleted address is displayed --%>
										<c:choose>
											<c:when test="${selectedAddress == contact.contactInfoIdentifier.uniqueID}">
												<option selected="selected" value="<c:out value="${contact.contactInfoIdentifier.uniqueID}"/>">
													<c:out value="${contact.contactInfoIdentifier.externalIdentifier.contactInfoNickName}"/>
												</option>
												<c:set var="selectedContact" value="${contact}"/>
											</c:when>
											<c:otherwise>
												<option value="<c:out value="${contact.contactInfoIdentifier.uniqueID}"/>">
													<c:out value="${contact.contactInfoIdentifier.externalIdentifier.contactInfoNickName}"/>
												</option>
											</c:otherwise>
										</c:choose>
									</c:if>
								</c:forEach>
							</select>
					
						<wcf:url var="AddressFormCreateURL" value="NonAjaxAccountAddressForm">
							<wcf:param name="storeId"   value="${WCParam.storeId}"  />
							<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
							<wcf:param name="langId" value="${langId}" />
							<c:if test="${! empty WCParam.returnView}">
								<wcf:param name="returnView"    value="${WCParam.returnView}"/>
								<wcf:param name="orderId"       value="${WCParam.orderId}"   />
							</c:if>
							<c:if test="${WCParam.mode == 'AddressBookReturnToCheckout'}">
								<wcf:param name="mode"          value="AddressBookReturnToCheckout"/>
								<wcf:param name="page"          value="shipaddress"            />
								<wcf:param name="orderId"       value="${WCParam.orderId}"         />
							</c:if>
						</wcf:url>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
					<div class="addrbook_header" id="WC_AjaxAddressBookForm_div_43">
										<span class="secondary_button button_fit">
											<span class="button_container">
												<span class="button_bg">
													<span class="button_top">
														<span class="button_bottom">   
															<a href="#" onclick="javascript:MessageHelper.hideAndClearMessage();AddressBookFormJS.showAdd();" id="WC_AddressBookForm_links_1"><fmt:message key="AB_ADDNEW" bundle="${storeText}"/></a>
														</span>
													</span>
												</span>	
											</span>
										</span>	
										<span class="secondary_button button_fit">
											<span class="button_container">
												<span class="button_bg">
													<span class="button_top">
														<span class="button_bottom">   
															<a href="#" onclick="javascript:AddressBookFormJS.removeAddress('removeAddressForm','addressId');return false;" id="WC_AddressBookForm_links_2"><fmt:message key="REMOVE" bundle="${storeText}"/></a>
														</span>
													</span>
												</span>	
											</span>
										</span>	
						<wcf:url var="AddressDeleteURL" value="PersonChangeServiceAddressDelete">
							<wcf:param name="storeId"   value="${WCParam.storeId}"  />
							<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
							<wcf:param name="langId" value="${WCParam.langId}" />
							<wcf:param name="URL" value="NonAjaxAddressBookForm?addressDeleted=true" />
						</wcf:url>
						<form id="removeAddressForm" name="removeAddressForm" action="<c:out value="${AddressDeleteURL}"/>" method="post">
							<input type="hidden" value="" id="addressIdForRemove" name="addressId"/>
						</form>
						<br/>
					</div>
					<div class="right_corner" id="WC_AddressBookForm_div_15"></div>
					<br/>
				</div>
			
				<div id="normal" style='<c:out value="${div1}"/>'>
					<br clear="all"/>		
					<jsp:include page="AccountForm.jsp" flush="true">
					</jsp:include>
					
					<script type="text/javascript">
						dojo.addOnLoad(function() { 
							var selection = document.getElementById("addressId");
							javascript:AddressBookFormJS.populateTextFieldsOnLoad(selection,addresses,document.AddressForm);
							});
					</script>	
				
					<div class="content_footer" id="WC_AddressBookForm_div_16">
						<div class="left_corner" id="WC_AddressBookForm_div_17"></div>
						<div class="button_footer_line" id="WC_AddressBookForm_div_18">
							<span class="primary_button button_fit">
								<span class="button_container">
									<span class="button_bg">
										<span class="button_top">
											<span class="button_bottom">   
												<a href="#" onclick="javascript:AddressBookFormJS.submitForm(document.AddressForm,'');return false;" id="WC_AddressBookForm_links_3"><fmt:message key="UPDATE" bundle="${storeText}"/></a>
											</span>
										</span>	
									</span>
								</span>
							</span>
						</div>	
						<div class="right_corner" id="WC_AddressBookForm_div_21"></div>
					</div>
				</div>
			
				<div id="adding" style='<c:out value="${div2}"/>'>
					<br/>
					<form name="AddressForm1" method="post" action="PersonChangeServiceAddressAdd" id="AddressForm1">
						<input type="hidden" name="storeId" value="<c:out value="${storeId}" />" id="WC_AddressBookForm_inputs_1"/>
						<input type="hidden" name="catalogId" value="<c:out value="${catalogId}" />" id="WC_AddressBookForm_inputs_2"/>
						<input type="hidden" name="langId" value="<c:out value="${langId}" />" id="WC_AddressBookForm_inputs_3"/>
						<input type="hidden" name="addressType" value="ShippingAndBilling" id="WC_AddressBookForm_inputs_4"/>
						<input type="hidden" name="URL" value="NonAjaxAddressBookForm?addressNew=true" id="WC_AddressForm_FormInput_URL_In_AddressForm_5"/>
						<input type="hidden" name="errorViewName" value="NonAjaxAddressBookForm" id="WC_AddressForm_FormInput_errorViewName_In_AddressForm_6"/>
						<input type="hidden" name="authToken" value="${authToken}" id="WC_AddressBookForm_inputs_authToken_1"/>

						<div class="left" id="WC_AddressBookForm_div_22">
							<div class="form_2column" id="WC_AddressBookForm_div_23">
								<div class="align" id="WC_AddressBookForm_div_24">
									<div class="label_spacer" id="WC_AddressBookForm_div_25">
										<fmt:message key="AB_CHOOSE" bundle="${storeText}"/>
									</div>
									<br/>
									<input type="hidden" var="addresstype" value="" id="WC_AddressBookForm_inputs_5"/>
									<div id="WC_AddressBookForm_div_26">
										<input name="sbAddress" id="WC_AccountForm_sbAddress_1" type="radio" class="radio" value="Shipping"/>&nbsp;<label for="WC_AccountForm_sbAddress_1"><fmt:message key="SHIPPING_ADDRESS2" bundle="${storeText}"/></label>
									</div>
									<div id="WC_AddressBookForm_div_27">
										<input name="sbAddress" id="WC_AccountForm_sbAddress_2" type="radio" class="radio" value="Billing"/>&nbsp;<label for="WC_AccountForm_sbAddress_2"><fmt:message key="BILLINGADDRESS" bundle="${storeText}"/></label>
									</div>
									<div id="WC_AddressBookForm_div_28">
										<input name="sbAddress" id="WC_AccountForm_sbAddress_3" type="radio" class="radio" value="ShippingAndBilling" checked="checked"/>&nbsp;<label for="WC_AccountForm_sbAddress_3"><fmt:message key="AB_SBADDR" bundle="${storeText}"/></label>
									</div>
								</div>
							
								
										<div class="column" id="WC_AddressBookForm_div_31">
											<div class="required-field" id="WC_AddressBookForm_div_32"> *</div><fmt:message key="REQUIRED_FIELDS" bundle="${storeText}"/>
										</div>
										<br clear="all"/>
										<br/>
										<div class="column" id="WC_AddressBookForm_div_33">
											<div class="label_spacer" id="WC_AddressBookForm_div_34">
												<label for="nickName1" class="nodisplay">
													<fmt:message key="AB_ADDRESS_LABEL_TEXT" bundle="${storeText}">
													<fmt:param><fmt:message key="AB_RECIPIENT" bundle="${storeText}"/></fmt:param>
													<fmt:param><fmt:message key="Checkout_ACCE_required" bundle="${storeText}"/></fmt:param></fmt:message>
												</label>
												<div class="required-field" id="WC_AddressBookForm_div_35"> *</div>
												<fmt:message key="AB_RECIPIENT" bundle="${storeText}"/>
											</div>
											<div id="WC_AddressBookForm_div_36">
												<input size="35" maxlength="128" type="text" name="nickName" id="nickName1" value="<c:out value='${param.nickName}'/>"/>
											</div>
										</div>
										<br clear="all"/>
										
										<c:set var="suffix" value="1"/>
										<%@ include file="../../../Snippets/ReusableObjects/AddressBookAddressEntryFormDisplay.jspf" %>
							</div>
						</div>	
					</form>
					<br clear="all"/><br/>

					<div class="content_footer" id="WC_AddressBookForm_div_37">
						<div class="left_corner" id="WC_AddressBookForm_div_38"></div>
						<div class="button_footer_line" id="WC_AddressBookForm_div_39">
							<wcf:url var="addressBookFormURL" value="NonAjaxAddressBookForm">
								<wcf:param name="storeId"   value="${WCParam.storeId}"  />
								<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
								<wcf:param name="langId" value="${langId}" />
							</wcf:url>
							<span class="primary_button button_fit" id="WC_AjaxAddressBookForm_div_19">
								<span class="button_container">
									<span class="button_bg">
										<span class="button_top">
											<span class="button_bottom">   
												<a href="#" onclick="javascript:AddressBookFormJS.submitForm(document.AddressForm1,'<c:out value='${suffix}'/>');return false;" id="WC_AddressBookForm_links_4"><fmt:message key="SUBMIT" bundle="${storeText}"/></a>
											</span>
										</span>	
									</span>
								</span>
							</span>	
							<span class="secondary_button button_fit" id="WC_AjaxAddressBookForm_div_11a">
							<span class="button_container">
								<span class="button_bg">
									<span class="button_top">
										<span class="button_bottom">   
											<a href="#" onclick="javascript:AddressBookFormJS.populateTextFields(document.getElementById('addressId'),addresses,document.AddressForm); return false;">
												<fmt:message key="CANCEL" bundle="${storeText}"/>
											</a>
										</span>
									</span>	
								</span>
							</span>
						</span>
						</div>
						<div class="right_corner" id="WC_AddressBookForm_div_42"></div>
					</div>
				</div>
			</div> <!-- end class="content" -->
		</div> <!-- end class="my_account" -->
	</div> <!-- end class="box" -->

	<!-- Main Content End -->
	
	<%@ include file="../../../include/LayoutContainerBottom.jspf"%>
</div><!-- end class="page" -->
<div id="page_shadow" class="shadow"></div>
<flow:ifEnabled feature="Analytics"><cm:pageview/></flow:ifEnabled>
</body>
</html>
