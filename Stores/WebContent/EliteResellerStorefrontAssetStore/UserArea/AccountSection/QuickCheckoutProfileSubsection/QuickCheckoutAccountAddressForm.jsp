<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2008 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf" %>
<%@ include file="../../../include/nocache.jspf" %>
<%-- ErrorMessageSetup.jspf is used to retrieve an appropriate error message when there is an error --%>
<%@ include file="../../../include/ErrorMessageSetup.jspf" %>
<%@ include file="../../../Snippets/ReusableObjects/AddressHelperCountrySelection.jspf" %>


<%-- Start: fix for the opera form identify problem. If the document identifies a script tag, it will pick up the DHTML from that point --%>
<script type="text/javaScript"></script>
<%-- End: fix for the opera form identify problem --%>
<%--
  ***
  * If there is no error and there is no addressId (i.e. add address, instead of update address),
  * the entry fields will be pre-filled with the address information in the database.
  * The entry fields below use e.g. paramSource.nickName to get the previously entered value.
  * In this case, the paramSource is set to the AddressDataBean.
  * If there is an error, the page will refresh and the entry fields will be pre-filled with the previously entered value.
  * In the case of error, the paramSource is set to WCParam.  
  ***
--%>
<wcbase:useBean id="countryBean" classname="com.ibm.commerce.user.beans.CountryStateListDataBean">
		<c:set target="${countryBean}" property="countryCode" value="${contact.address.country}"/>
	</wcbase:useBean>
<c:set var="contact" value="${WCParam.contact}"/>

	<c:set var="prefix" value="${WCParam.prefix}"/>
	<c:set var="addressId" value="${WCParam.addressId}"/>
	<c:if test="${!empty addressId}" >
		
		<wcf:getData type="com.ibm.commerce.member.facade.datatypes.PersonType" 
					var="person" expressionBuilder="findCurrentPerson">
			<wcf:param name="accessProfile" value="IBM_All" />
		</wcf:getData>
		<c:set var="personAddresses" value="${person.addressBook}"/>
		
		<c:set var="shownAddress" value="false"/>
		<c:set var="contact" value="${person.contactInfo}"/>
		<c:if test="${contact.contactInfoIdentifier.uniqueID eq addressId}" >	
			<c:set var="final" value="${contact}"/>
			<jsp:include page="../QuickCheckoutProfileSubsection/QuickCheckoutAddressForm.jsp" flush="true">
				<jsp:param name="addressId" value="${final.contactInfoIdentifier.uniqueID}" />
				<jsp:param name="nickName" value="${final.contactInfoIdentifier.externalIdentifier.contactInfoNickName}" />
				<jsp:param name="firstName" value="${final.contactName.firstName}"/>
				<jsp:param name="lastName" value="${final.contactName.lastName}"/>
				<jsp:param name="street" value="${final.address.addressLine[0]}"/>
				<jsp:param name="street2" value="${final.address.addressLine[1]}"/>
				<jsp:param name="city" value="${final.address.city}"/>
				<jsp:param name="statePro" value="${final.address.stateOrProvinceName}"/>
				<jsp:param name="countryReg" value="${final.address.country}"/>
				<jsp:param name="zipCode" value="${final.address.postalCode}"/>
				<jsp:param name="phone" value="${final.telephone1.value}"/>
				<jsp:param name="email1" value="${final.emailAddress1.value}"/>
				<jsp:param name="prefix" value="${prefix}"/>
			</jsp:include>
			<c:set var="shownAddress" value="true"/>
		</c:if>
		<c:if test="${!shownAddress}" >
			<c:forEach items="${personAddresses.contact}" var="contact">
				<c:if test="${contact.contactInfoIdentifier.uniqueID eq addressId}" >
					<c:set var="final" value="${contact}"/>
					<jsp:include page="../QuickCheckoutProfileSubsection/QuickCheckoutAddressForm.jsp" flush="true">
						<jsp:param name="addressId" value="${final.contactInfoIdentifier.uniqueID}" />
						<jsp:param name="nickName" value="${final.contactInfoIdentifier.externalIdentifier.contactInfoNickName}" />
						<jsp:param name="firstName" value="${final.contactName.firstName}"/>
						<jsp:param name="lastName" value="${final.contactName.lastName}"/>
						<jsp:param name="street" value="${final.address.addressLine[0]}"/>
						<jsp:param name="street2" value="${final.address.addressLine[1]}"/>
						<jsp:param name="city" value="${final.address.city}"/>
						<jsp:param name="statePro" value="${final.address.stateOrProvinceName}"/>
						<jsp:param name="countryReg" value="${final.address.country}"/>
						<jsp:param name="zipCode" value="${final.address.postalCode}"/>
						<jsp:param name="phone" value="${final.telephone1.value}"/>
						<jsp:param name="email1" value="${final.emailAddress1.value}"/>
						<jsp:param name="prefix" value="${prefix}"/>
					</jsp:include>
					<c:set var="shownAddress" value="true"/>
				</c:if>
			</c:forEach>
		</c:if>
	</c:if>