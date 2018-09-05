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
  * This JSP displays all existing billing addresses, and allows the user to 
  * select the address for checkout
  *****
--%>

<!-- BEGIN OrderBillingAddressSelection.jsp -->

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>

<%@ include file="../../../include/parameters.jspf" %>
<%@ include file="../../include/JSTLEnvironmentSetup.jspf" %>

<%-- Required variables for breadcrumb support --%>
<c:choose>
	<c:when test="${!empty WCParam.fromPage && WCParam.fromPage == 'MyAccount'}">
		<c:set var="accountPageGroup" value="true" scope="request"/>
	</c:when>
	<c:otherwise>
		<c:set var="shoppingcartPageGroup" value="true" scope="request"/>
	</c:otherwise>
</c:choose>
<c:set var="billingSelectionPage" value="true" scope="request"/>

<c:set var="storeId" value="${WCParam.storeId}" />
<c:set var="catalogId" value="${WCParam.catalogId}" />

<c:set var="fromPage" value="" />
<c:if test="${!empty WCParam.fromPage}">
	<c:set var="fromPage" value="${WCParam.fromPage}" />
</c:if>

<wcf:getData type="com.ibm.commerce.order.facade.datatypes.OrderType"
	var="usablePayments" expressionBuilder="findCurrentShoppingCart" scope="request">
	<wcf:param name="accessProfile" value="IBM_UsablePaymentInfo" />	 
</wcf:getData>

<wcf:getData type="com.ibm.commerce.member.facade.datatypes.PersonType" 
	var="person" expressionBuilder="findCurrentPerson">
	<wcf:param name="accessProfile" value="IBM_All" />
</wcf:getData>

<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.2//EN" "http://www.openmobilealliance.org/tech/DTD/xhtml-mobile12.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="${shortLocale}" xml:lang="${shortLocale}">

	<head>
		<title><fmt:message key="YOUR_BILLING_ADDRESSES" bundle="${storeText}"/> - <c:out value="${storeName}"/></title>
		<meta http-equiv="content-type" content="application/xhtml+xml" />
		<meta http-equiv="cache-control" content="max-age=300" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no" />
		<link rel="stylesheet" type="text/css" href="${cssPath}" />
	</head>
	
	<body>
		
		<div id="wrapper">
			<%@ include file="../../include/HeaderDisplay.jspf" %>
			<%@ include file="../../include/BreadCrumbTrailDisplay.jspf" %>

			<div id="address_list" class="content_box">

				<div class="heading_container_with_underline">
					<h2><fmt:message key="YOUR_BILLING_ADDRESSES" bundle="${storeText}" /></h2>
					<div class="clear_float"></div>
				</div>

				<c:choose>
					<c:when test="${!empty WCParam.addressError && WCParam.addressError}">
						<p class="error"><fmt:message key="BILLING_ADDRESS_INCOMPLETE" bundle="${storeText}" /></p>
					</c:when>
					<c:when test="${!empty WCParam.selectionError && WCParam.selectionError}">
						<p class="error"><fmt:message key="BILLING_SELECTION_ERROR" bundle="${storeText}" /></p>
					</c:when>
				</c:choose>

				<c:if test="${fromPage != 'MyAccount'}">
					<p class="paragraph_blurb"><fmt:message key="BILLING_ADDRESS_SELECT" bundle="${storeText}" /></p>
				</c:if>

				<wcf:url var="OrderBillingDetailsURL" 	value="mOrderBillingDetails">
					<wcf:param name="langId" value="${langId}" />
					<wcf:param name="storeId" value="${WCParam.storeId}" />
					<wcf:param name="catalogId" value="${WCParam.catalogId}" />
					<wcf:param name="orderId" value="${WCParam.orderId}" />
					<wcf:param name="fromPage" value="${WCParam.fromPage}" />
				</wcf:url>
				
				<wcf:url var="AddressDeleteURL" value="PersonChangeServiceAddressDelete">
					<wcf:param name="langId" value="${langId}" />
					<wcf:param name="storeId" value="${WCParam.storeId}" />
					<wcf:param name="catalogId" value="${WCParam.catalogId}" />
					<wcf:param name="orderId" value="${WCParam.orderId}" />
					<wcf:param name="fromPage" value="${WCParam.fromPage}" />
					<wcf:param name="URL" value="mOrderBillingAddressSelection" />
				</wcf:url>

				<c:set var="hasValidAddresses" value="false"/>
				<c:forEach var="payment" items="${usablePayments.usablePaymentInformation}">
					<c:if test="${fn:length(payment.usableBillingAddress) > 0 && !hasValidAddresses}">
						<c:set var="hasValidAddresses" value="true"/>
					</c:if>
				</c:forEach>

				<c:set var="paymentMethodSelect" value="VISA"/>
				<c:choose>
					<c:when test="${hasValidAddresses || fromPage == 'MyAccount'}">
						<form name="billingAddressForm">
							<c:choose>
								<c:when test="${fromPage == 'MyAccount'}">
									<c:set var="personAddresses" value="${person.addressBook}"/>
									    <c:set var="contact" value="${person.contactInfo}"/>
									    <c:set var="addressId" value="${contact.contactInfoIdentifier.uniqueID}"/>
									    <c:if test="${!empty contact.address && (contact.address.type_ == 'Billing' || contact.address.type_ == 'ShippingAndBilling')}">
									    	<ul class="entry">
										    	<c:set var="countryDisplayName" value="${contact.address.country}"/>
												<c:set var="stateDisplayName" value="${contact.address.stateOrProvinceName}"/>
												<wcbase:useBean id="countryBean" classname="com.ibm.commerce.user.beans.CountryStateListDataBean">
													<c:set target="${countryBean}" property="countryCode" value="${contact.address.country}"/>
												</wcbase:useBean>
										
												<c:forEach var="country" items="${countryBean.countries}">
													<c:if test="${!empty country.code && country.code == contact.address.country}">
														<c:set var="countryDisplayName" value="${country.displayName}"/>
													</c:if>
																	
													<c:if test="${!empty country.states}">
														<c:forEach var="state" items="${country.states}" varStatus="counter">
															<c:if test="${!empty state.code && state.code == contact.address.stateOrProvinceName}">
																<c:set var="stateDisplayName" value="${state.displayName}"/>
															</c:if>
														</c:forEach>
													</c:if>
												</c:forEach>
												<li>
													<div class="radio_container">
														<span class="bold">${contact.contactInfoIdentifier.externalIdentifier.contactInfoNickName}</span>
													</div>
												</li>
	
												<li class="align_with_radio"><c:out value="${contact.contactName.firstName}"/> <c:out value="${contact.contactName.lastName}"/></li>
												<li class="align_with_radio"><c:out value="${contact.address.addressLine[0]}"/> <c:out value="${contact.address.addressLine[1]}"/></li>
												<li class="align_with_radio"><c:out value="${contact.address.city}"/> <c:out value="${stateDisplayName}"/></li>
												<li class="align_with_radio"><c:out value="${countryDisplayName}"/> <c:out value="${contact.address.postalCode}"/></li>
												<li class="align_with_radio"><c:out value="${contact.telephone1.value}"/></li>
												<li class="align_with_radio"><c:out value="${contact.emailAddress1.value}"/></li>
												<li class="align_with_radio"><span class="bullet">&#187; </span><a href="${OrderBillingDetailsURL}&addressId=${addressId}"><fmt:message key="MO_EDIT" bundle="${storeText}"/></a></li>
											</ul>
										</c:if>
	
										<c:forEach var="addressBookContact" items="${personAddresses.contact}">
											<c:if test="${!empty addressBookContact.address && (addressBookContact.address.type_ == 'Billing' || addressBookContact.address.type_ == 'ShippingAndBilling')}">
												<ul class="entry">
													<c:set var="contact" value="${addressBookContact}"/>
													<c:set var="addressId" value="${contact.contactInfoIdentifier.uniqueID}"/>
													<c:set var="countryDisplayName" value="${contact.address.country}"/>
													<c:set var="stateDisplayName" value="${contact.address.stateOrProvinceName}"/>
													<wcbase:useBean id="countryBean" classname="com.ibm.commerce.user.beans.CountryStateListDataBean">
														<c:set target="${countryBean}" property="countryCode" value="${contact.address.country}"/>
													</wcbase:useBean>
	
													<c:forEach var="country" items="${countryBean.countries}">
														<c:if test="${!empty country.code && country.code == contact.address.country}">
															<c:set var="countryDisplayName" value="${country.displayName}"/>
														</c:if>
																
														<c:if test="${!empty country.states}">
															<c:forEach var="state" items="${country.states}" varStatus="counter">
																<c:if test="${!empty state.code && state.code == contact.address.stateOrProvinceName}">
																	<c:set var="stateDisplayName" value="${state.displayName}"/>
																</c:if>
															</c:forEach>
														</c:if>
													</c:forEach>
	
													<li>
														<div class="radio_container">
															<span class="bold">${contact.contactInfoIdentifier.externalIdentifier.contactInfoNickName}</span>
														</div>
													</li>
													
													<li class="align_with_radio"><c:out value="${contact.contactName.firstName}"/> <c:out value="${contact.contactName.lastName}"/></li>
													<li class="align_with_radio"><c:out value="${contact.address.addressLine[0]}"/> <c:out value="${contact.address.addressLine[1]}"/></li>
													<li class="align_with_radio"><c:out value="${contact.address.city}"/> <c:out value="${stateDisplayName}"/></li>
													<li class="align_with_radio"><c:out value="${countryDisplayName}"/> <c:out value="${contact.address.postalCode}"/></li>
													<li class="align_with_radio"><c:out value="${contact.telephone1.value}"/></li>
													<li class="align_with_radio"><c:out value="${contact.emailAddress1.value}"/></li>
													<li class="align_with_radio"><span class="bullet">&#187; </span><a href="${OrderBillingDetailsURL}&addressId=${addressId}"><fmt:message key="MO_EDIT" bundle="${storeText}"/></a></li>
													<li class="align_with_radio"><span class="bullet">&#187; </span><a href="${AddressDeleteURL}&addressId=${addressId}"><fmt:message key="MSTLST_REMOVE_STORE" bundle="${storeText}"/></a></li>
												</ul>
											</c:if>
										</c:forEach>
									</ul>						
								</c:when>
								<c:otherwise>						
									<c:forEach var="payment" items="${usablePayments.usablePaymentInformation}">
										<c:if test="${payment.paymentMethod.paymentMethodName eq paymentMethodSelect}">
											<c:forEach var="addressInPayment" items="${payment.usableBillingAddress}">
												<c:set var="addressId" value="${addressInPayment.uniqueID}" />
												<ul class="entry">
													<c:set var="contact" value="${person.contactInfo}"/>
													<c:set var="optionChecked" value=""/>
													<c:set var="removableAddress" value="true"/>
													<c:choose>
														<c:when test="${contact.contactInfoIdentifier.uniqueID eq addressId}">
															<c:set var="contact" value="${person.contactInfo}"/>
															<c:set var="optionChecked" value="checked='checked'"/>
															<c:set var="removableAddress" value="false"/>
														</c:when>
														<c:otherwise>
															<c:set var="personAddresses" value="${person.addressBook}"/>
															<c:forEach var="addressBookContact" items="${personAddresses.contact}">
																<c:if test="${addressBookContact.contactInfoIdentifier.uniqueID eq addressId}">
																	<c:set var="contact" value="${addressBookContact}"/>
																</c:if>
															</c:forEach>
														</c:otherwise>
													</c:choose>
							
													<c:set var="countryDisplayName" value="${contact.address.country}"/>
													<c:set var="stateDisplayName" value="${contact.address.stateOrProvinceName}"/>
													<wcbase:useBean id="countryBean" classname="com.ibm.commerce.user.beans.CountryStateListDataBean">
														<c:set target="${countryBean}" property="countryCode" value="${contact.address.country}"/>
													</wcbase:useBean>
												
													<c:forEach var="country" items="${countryBean.countries}">
														<c:if test="${!empty country.code && country.code == contact.address.country}">
															<c:set var="countryDisplayName" value="${country.displayName}"/>
														</c:if>
																
														<c:if test="${!empty country.states}">
															<c:forEach var="state" items="${country.states}" varStatus="counter">
																<c:if test="${!empty state.code && state.code == contact.address.stateOrProvinceName}">
																	<c:set var="stateDisplayName" value="${state.displayName}"/>
																</c:if>
															</c:forEach>
														</c:if>
													</c:forEach>
	
													<li>
														<div class="radio_container">
															<input type="radio" id="${addressId}_billing_address_selection" name="billing_address_selection" value="<c:out value="${addressId}"/>" ${optionChecked} />
															<label for="${addressId}_billing_address_selection"><span class="bold">${addressInPayment.externalIdentifier.contactInfoNickName}</span></label>
														</div>
													</li>
	
													<%-- Used for address validation --%>
													<input type="hidden" name="${addressId}_address" id="${addressId}_address" value="${contact.address.addressLine[0]}" />
													<input type="hidden" name="${addressId}_city" id="${addressId}_city" value="${contact.address.city}" />
													<input type="hidden" name="${addressId}_state" id="${addressId}_state" value="${stateDisplayName}" />
													<input type="hidden" name="${addressId}_zip" id="${addressId}_zip" value="${contact.address.postalCode}" />
	
													<li class="align_with_radio"><c:out value="${contact.contactName.firstName}"/> <c:out value="${contact.contactName.lastName}"/></li>
													<li class="align_with_radio"><c:out value="${contact.address.addressLine[0]}"/> <c:out value="${contact.address.addressLine[1]}"/></li>
													<li class="align_with_radio"><c:out value="${contact.address.city}"/> <c:out value="${stateDisplayName}"/></li>
													<li class="align_with_radio"><c:out value="${countryDisplayName}"/> <c:out value="${contact.address.postalCode}"/></li>
													<li class="align_with_radio"><c:out value="${contact.telephone1.value}"/></li>
													<li class="align_with_radio"><c:out value="${contact.emailAddress1.value}"/></li>
													<li class="align_with_radio"><span class="bullet">&#187; </span><a href="${OrderBillingDetailsURL}&addressId=${addressId}"><fmt:message key="MO_EDIT" bundle="${storeText}"/></a></li>
													
													<c:if test="${removableAddress}">
														<li class="align_with_radio"><span class="bullet">&#187; </span><a href="${AddressDeleteURL}&addressId=${addressId}"><fmt:message key="MSTLST_REMOVE_STORE" bundle="${storeText}"/></a></li>
													</c:if>
												</ul>
	
											</c:forEach>
										</c:if>
									</c:forEach>
								</c:otherwise>
							</c:choose>
						</form>
					</c:when>
					<c:otherwise>
						<%-- There are no addresses found.  Redirect to the address details page to create an address. --%>
						<script type="text/javascript">window.location.href="<c:out value="${OrderBillingDetailsURL}" />"</script>
					</c:otherwise>
				</c:choose>

				<div>
					<fmt:message key="BILLING_ADDRESS_CREATE" bundle="${storeText}" />
					<p class="paragraph_blurb"><span class="bullet">&#187; </span><a href="${OrderBillingDetailsURL}" title="<fmt:message key="CREATE_NEW_ADDRESS" bundle="${storeText}" />"><fmt:message key="CREATE_NEW_ADDRESS" bundle="${storeText}" /></a></p>
				</div>

				<c:choose>
					<c:when test="${fromPage == 'MyAccount'}">
						<form name="myAccountDisplayForm" method="get" action="mMyAccountDisplay">
							<input type="hidden" name="langId" value="${langId}" />
							<input type="hidden" name="storeId" value="${WCParam.storeId}" />
							<input type="hidden" name="catalogId" value="${WCParam.catalogId}" />
							<input type="hidden" name="addressId" value="" id="selected_addressId" />
							<input type="submit" id="ok_button" name="ok_button" class="input_button_float" value="<fmt:message key="MADDR_OK" bundle="${storeText}" />" />
						</form>
					</c:when>
					<c:otherwise>
						<form name="orderPaymentDetailsForm" method="get" action="mOrderPaymentDetails">
							<input type="hidden" name="langId" value="${langId}" />
							<input type="hidden" name="storeId" value="${WCParam.storeId}" />
							<input type="hidden" name="catalogId" value="${WCParam.catalogId}" />
							<input type="hidden" name="addressId" value="" id="selected_addressId" />
							<input type="button" id="continue_checkout" name="continue_checkout" class="input_button_float" value="<fmt:message key="CONTINUE_CHECKOUT" bundle="${storeText}" />" onclick="checkAddress();" />
						</form>

						<form name="errorForm" method="get" action="mOrderBillingAddressSelection">
							<input type="hidden" name="langId" value="${langId}" />
							<input type="hidden" name="storeId" value="${WCParam.storeId}" />
							<input type="hidden" name="catalogId" value="${WCParam.catalogId}" />
							<input type="hidden" name="orderId" value="${WCParam.orderId}" />
							<input type="hidden" name="selectionError" value="true" id="selectionError" />
							<input type="hidden" name="addressError" value="false" id="addressError" />
						</form>
					</c:otherwise>
				</c:choose>
			</div>

			<%@ include file="../../include/FooterDisplay.jspf" %>			
		</div>

	<script type="text/javascript">
	//<![CDATA[

		function checkAddress() {
			var addressId = null;
			if(typeof(document.billingAddressForm) != "undefined") {
				if(typeof(document.billingAddressForm.billing_address_selection.length) != "undefined") {
					// Multiple addresses are available
					for(var i = 0; i< document.billingAddressForm.billing_address_selection.length; i++) {
						if(document.billingAddressForm.billing_address_selection[i].checked) {
							addressId = document.billingAddressForm.billing_address_selection[i].value;
							break;
						}
					}
				}
				else {
					// Only one address is available
					if(document.billingAddressForm.billing_address_selection.checked) {
						addressId = document.billingAddressForm.billing_address_selection.value;
					}
				}

				if(addressId != null) {
					// Check for a complete address
					if(document.getElementById(addressId + "_address").value == "-" ||
						document.getElementById(addressId + "_city").value == "-" ||
						document.getElementById(addressId + "_state").value == "-" ||
						document.getElementById(addressId + "_zip").value == "-") {
						//
						// Address is incomplete. Set error flag for errorForm submit.
						//
						document.getElementById("addressError").value = "true";
					}
					else {
						// Address id is selected. Set the addressId and submit the form.
						document.getElementById("selected_addressId").value = addressId;
						document.orderPaymentDetailsForm.submit();
						return;
					}
				}
			}
			document.errorForm.submit();
		}

	//]]>
	</script>

	</body>
</html>

<!-- END OrderBillingAddressSelection.jsp -->
