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
  * This JSP displays a form to create or edit an existing billing address
  *****
--%>

<!-- BEGIN OrderBillingDetails.jsp -->

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>

<%@ include file="../../../include/parameters.jspf" %>
<%@ include file="../../include/JSTLEnvironmentSetup.jspf" %>
<%@ include file="../../include/ErrorMessageSetup.jspf" %>
<%@ include file="../../UserArea/AccountSection/RegistrationSubsection/MandatoryUserRegistrationFields.jspf" %>

<%-- Required variables for breadcrumb support --%>
<c:choose>
	<c:when test="${!empty WCParam.fromPage && WCParam.fromPage == 'MyAccount'}">
		<c:set var="accountPageGroup" value="true" scope="request"/>
	</c:when>
	<c:otherwise>
		<c:set var="shoppingcartPageGroup" value="true" scope="request"/>
	</c:otherwise>
</c:choose>
<c:set var="billingDetailsPage" value="true" scope="request"/>

<c:set var="storeId" value="${WCParam.storeId}" />
<c:set var="catalogId" value="${WCParam.catalogId}" />

<c:set var="fromPage" value="" />
<c:if test="${!empty WCParam.fromPage}">
	<c:set var="fromPage" value="${WCParam.fromPage}" />
</c:if>

<wcf:getData type="com.ibm.commerce.member.facade.datatypes.PersonType" var="person" expressionBuilder="findCurrentPerson">
	<wcf:param name="accessProfile" value="IBM_All" />
</wcf:getData>

<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.2//EN" "http://www.openmobilealliance.org/tech/DTD/xhtml-mobile12.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" lang="${shortLocale}" xml:lang="${shortLocale}">

	<head>
		<title><fmt:message key="BILLING_ADDRESS_TITLE" bundle="${storeText}"/> - <c:out value="${storeName}"/></title>
		<meta http-equiv="content-type" content="application/xhtml+xml" />
		<meta http-equiv="cache-control" content="max-age=300" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no" />
		<link rel="stylesheet" type="text/css" href="${cssPath}" />
	</head>

	<body onLoad="loadCountryStates();">

		<div id="wrapper">
			<%@ include file="../../include/HeaderDisplay.jspf" %>
			<%@ include file="../../include/BreadCrumbTrailDisplay.jspf" %>

			<div id="billing_address" class="content_box">
				<div class="heading_container_with_underline">
					<h2><fmt:message key="BILLING_ADDRESS_TITLE" bundle="${storeText}" /></h2>
					<div class="clear_float"></div>
				</div>

				<p class="paragraph_blurb"><fmt:message key="MUSREGU_UPDATE_MSG1" bundle="${storeText}" /><span class="field_required_symbol">*</span><fmt:message key="MUSREGU_UPDATE_MSG2" bundle="${storeText}" /></p>

				<c:if test="${!empty errorMessage}">
					<span id="error" class="error"><br/><c:out value="${errorMessage}"/><br/><br/></span>

					<c:set var="nickName" 	value="${WCParam.nickName}"/>
					<c:set var="firstName" value="${WCParam.firstName}"/>
					<c:set var="lastName" value="${WCParam.lastName}"/>
					<c:set var="addressLine0" value="${WCParam.address1}"/>
					<c:set var="addressLine1" value="${WCParam.address2}"/>
					<c:set var="city" value="${WCParam.city}"/>
					<c:set var="postalCode" value="${WCParam.zipCode}"/>
					<c:set var="telephone1" value="${WCParam.phone1}"/>
					<c:set var="emailAddress1" value="${WCParam.email1}"/>
					<c:set var="countryDisplayName" value="${WCParam.country}"/>
					<c:set var="stateDisplayName" value="${WCParam.state}"/>
				</c:if>

				<c:choose>
					<c:when test="${person.contactInfo.contactInfoIdentifier.uniqueID eq WCParam.addressId}">
						<c:set var="contact" value="${person.contactInfo}"/>
					</c:when>
					<c:otherwise>
						<c:set var="personAddresses" value="${person.addressBook}"/>
						<c:forEach var="addressBookContact" items="${personAddresses.contact}">
							<c:if test="${addressBookContact.contactInfoIdentifier.uniqueID eq WCParam.addressId}">
								<c:set var="contact" value="${addressBookContact}"/>
							</c:if>
						</c:forEach>
					</c:otherwise>
				</c:choose>

				<c:if test="${!empty contact}">
					<c:set var="resolvedAddressId" value="${contact.contactInfoIdentifier.uniqueID}"/>
					<c:set var="nickName" 	value="${contact.contactInfoIdentifier.externalIdentifier.contactInfoNickName}"/>
					<c:set var="firstName" value="${contact.contactName.firstName}"/>
					<c:set var="lastName" value="${contact.contactName.lastName}"/>
					<c:set var="addressLine0" value="${contact.address.addressLine[0]}"/>
					<c:set var="addressLine1" value="${contact.address.addressLine[1]}"/>
					<c:set var="city" value="${contact.address.city}"/>
					<c:set var="postalCode" value="${contact.address.postalCode}"/>
					<c:set var="telephone1" value="${contact.telephone1.value}"/>
					<c:set var="emailAddress1" value="${contact.emailAddress1.value}"/>
					<c:set var="countryDisplayName" value="${contact.address.country}"/>
					<c:set var="stateDisplayName" value="${contact.address.stateOrProvinceName}"/>
				</c:if>

				<wcbase:useBean id="countryBean" classname="com.ibm.commerce.user.beans.CountryStateListDataBean">
					<c:set target="${countryBean}" property="countryCode" value="${contact.address.country}"/>
				</wcbase:useBean>

				<c:if test="${!empty countryDisplayName}">
					<c:forEach var="country" items="${countryBean.countries}">
						<c:if test="${!empty country.code && country.code == countryDisplayName}">
							<c:set var="countryDisplayName" value="${country.displayName}"/>
						</c:if>

						<c:if test="${!empty country.states}">
							<c:forEach var="state" items="${country.states}" varStatus="counter">
								<c:if test="${!empty state.code && state.code == stateDisplayName}">
									<c:set var="stateDisplayName" value="${state.displayName}"/>
								</c:if>
							</c:forEach>
						</c:if>
					</c:forEach>
				</c:if>

				<c:set var="personChangeServiceAction" value="PersonChangeServiceAddressAdd" />
				<c:if test="${!empty contact}">
					<c:set var="personChangeServiceAction" value="PersonChangeServiceAddressUpdate" />
				</c:if>

				<form id="billing_address_form" action="${personChangeServiceAction}">
					<fieldset>

						<div class="input_container">
							<c:choose>
								<c:when test="${!empty contact}">
									<div class="bold">${nickName}</div>
									<input type="hidden" id="addressId" name="addressId" value="${resolvedAddressId}" />
								</c:when>
								<c:otherwise>
									<div><label for="nickName"><span class="field_required_symbol">*</span><fmt:message key="NICK_NAME" bundle="${storeText}" /></label></div>
									<input type="text" id="nickName" name="nickName" value="${nickName}" class="coloured_input" />
								</c:otherwise>
							</c:choose>
						</div>

						<div class="input_container">
							<div><label for="firstName"><c:if test="${fn:contains(mandatoryFields, 'firstName')}"><span class="field_required_symbol">*</span></c:if><fmt:message key="MUSREG_FNAME" bundle="${storeText}" /></label></div>
							<input type="text" id="firstName" name="firstName" value="${firstName}" class="coloured_input" />
						</div>

						<div class="input_container">
							<div><label for="lastName"><c:if test="${fn:contains(mandatoryFields, 'lastName')}"><span class="field_required_symbol">*</span></c:if><fmt:message key="MUSREG_LNAME" bundle="${storeText}" /></label></div>
							<input type="text" id="lastName" name="lastName" value="${lastName}" class="coloured_input" />
						</div>
						<div class="linked_fields">
							<div class="input_container">
								<div><label for="address1"><c:if test="${fn:contains(mandatoryFields, 'address1')}"><span class="field_required_symbol">*</span></c:if><fmt:message key="STREET_ADDRESS" bundle="${storeText}" /></label></div>
								<input type="text" id="address1" name="address1" value="${addressLine0}" class="coloured_input" />
							</div>

							<div class="input_container">
								<label for="address2" class="nodisplay"><fmt:message key="STREET_ADDRESS" bundle="${storeText}" /></label>
								<input type="text" id="address2" name="address2" value="${addressLine1}" class="coloured_input" />
							</div>
						</div>
 
						<div class="input_container">
							<div><label for="city"><c:if test="${fn:contains(mandatoryFields, 'city')}"><span class="field_required_symbol">*</span></c:if><fmt:message key="CITY" bundle="${storeText}" /></label></div>
							<input type="text" id="city" name="city" value="${city}" class="coloured_input" />
						</div>

						<wcbase:useBean id="countryBean" classname="com.ibm.commerce.user.beans.CountryStateListDataBean">
							<c:set target="${countryBean}" property="countryCode" value="${paramSource.country}"/>
						</wcbase:useBean>

 						<div class="dropdown_container">
							<div><label for="country"><c:if test="${fn:contains(mandatoryFields, 'country')}"><span class="field_required_symbol">*</span></c:if><fmt:message key="COUNTRY_REGION" bundle="${storeText}" /></label></div>
							<select onchange="loadCountryStates();" id="country" name="country" class="coloured_input">
								<c:forEach var="country" items="${countryBean.countries}">
									<option value="${country.code}"
										<c:if test="${country.displayName == countryDisplayName}">
											selected="selected"
										</c:if>
									><c:out value="${country.displayName}" />
									</option>
								</c:forEach>
							</select>
						</div>

						<div class="input_container">
							<div><label for="state"><c:if test="${fn:contains(mandatoryFields, 'state')}"><span class="field_required_symbol">*</span></c:if><fmt:message key="STATE_PROVINCE" bundle="${storeText}" /></label></div>

							<%--	Create seperate select boxes for countries with state
									lists.  Hide the list unless the country is selected.
							--%>

							<c:forEach var="country" items="${countryBean.countries}">
								<c:if test="${!empty country.states}">
									<div id=${country.code}_states_div style="display:none">
										<label for="${country.code}_states" class="nodisplay"><fmt:message key="STATE_PROVINCE" bundle="${storeText}" /></label>
										<select id="${country.code}_states" class="coloured_input">
											<c:forEach var="state" items="${country.states}" varStatus="counter">
												<option value="${state.code}"
													<c:if test="${state.displayName == stateDisplayName}">
														selected="selected"
													</c:if>
												><c:out value="${state.displayName}" /></option>
											</c:forEach>
										</select>
									</div>
								</c:if>
							</c:forEach>

							<div id="states_div"><input type="text" id="state" name="state" value="${stateDisplayName}" class="coloured_input" /></div>
						</div>

						<div class="input_container">
							<div><label for="zipCode"><c:if test="${fn:contains(mandatoryFields, 'zipCode')}"><span class="field_required_symbol">*</span></c:if><fmt:message key="ZIPCODE_POSTALCODE" bundle="${storeText}" /></label></div>
							<input type="text" id="zipCode" name="zipCode" value="${postalCode}" class="coloured_input" />
						</div>

						<div class="input_container">
							<div><label for="phone1"><c:if test="${fn:contains(mandatoryFields, 'phone1')}"><span class="field_required_symbol">*</span></c:if><fmt:message key="PHONE_NUMBER" bundle="${storeText}" /></label></div>
							<input type="text" id="phone1" name="phone1" value="${telephone1}" class="coloured_input" />
						</div>

						<div class="input_container">
							<div><label for="email1"><c:if test="${fn:contains(mandatoryFields, 'email1')}"><span class="field_required_symbol">*</span></c:if><fmt:message key="MUSREG_EMAIL" bundle="${storeText}" /></label></div>
							<input type="text" id="email1" name="email1" value="${emailAddress1}" class="coloured_input" />
						</div>
					</fieldset>

					<input type="hidden" name="storeId" value="${storeId}" />
					<input type="hidden" name="catalogId" value="${catalogId}" />
					<input type="hidden" name="URL" value="mOrderBillingAddressSelection" />
					<input type="hidden" name="fromPage" value="${WCParam.fromPage}" />
					<input type="hidden" name="errorViewName" value="mOrderBillingDetails" />
					<input type="hidden" name="authToken" value="${authToken}"/>

					<div class="input_container">
						<c:choose>				
							<c:when test="${fromPage == 'MyAccount'}">
								<input type="button" onclick="submitAddressUpdate();" id="update" name="update" value="<fmt:message key= "MADDR_UPDATE" bundle="${storeText}" />" />
							</c:when>
							<c:otherwise>
								<input type="button" onclick="submitAddressUpdate();" id="continue_checkout" name="continue_checkout" value="<fmt:message key= "CONTINUE_CHECKOUT" bundle="${storeText}" />" />
							</c:otherwise>
						</c:choose>
						
					</div>

				</form>
			</div>

			<%@ include file="../../include/FooterDisplay.jspf" %>
		</div>

	<script type="text/Javascript">
	//<![CDATA[

		function submitAddressUpdate() {
			var country = document.getElementById('country').value;
			var stateBox = document.getElementById(country + "_states");
			if(stateBox != null) {
				document.getElementById("billing_address_form").state.value = document.getElementById(country + "_states").value;
			}

			document.getElementById("billing_address_form").submit();
		}

		function hideCountryStates() {
			<c:forEach var="country" items="${countryBean.countries}">
				<c:if test="${!empty country.states}">
					document.getElementById("${country.code}_states_div").style.display = "none";
				</c:if>
			</c:forEach>
			document.getElementById("states_div").style.display = "none";
		}

		function loadCountryStates() {
			var country = document.getElementById('country').value;
			var stateBox = document.getElementById(country + "_states_div");
			hideCountryStates();
			if(stateBox != null) {
				document.getElementById(country + "_states_div").style.display = "block";
			}
			else {
				document.getElementById("states_div").style.display = "block";
			}
		}

	//]]> 
	</script>
 
	</body>
</html>

<!-- END OrderBillingDetails.jsp -->
