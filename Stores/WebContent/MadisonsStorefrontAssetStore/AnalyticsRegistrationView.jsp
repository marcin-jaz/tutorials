<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2007, 2009 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.ibm.commerce.command.CommandContext" %>
<%@ page import="com.ibm.commerce.server.ECConstants" %>
<%@ page import="com.ibm.commerce.datatype.WcParam" %>

<%
// check to see if the wcparam is available; initialise it if it is not available
if( null == request.getAttribute(com.ibm.commerce.server.ECConstants.EC_INPUT_PARAM)){
	request.setAttribute(com.ibm.commerce.server.ECConstants.EC_INPUT_PARAM, new WcParam(request));
}
%>

<wcf:getData type="com.ibm.commerce.member.facade.datatypes.PersonType" var="personType" expressionBuilder="findCurrentPerson">
       <wcf:param name="accessProfile" value="IBM_All" />
</wcf:getData>

<c:set var="singleQuote" value="'"/>
<c:set var="escapedSingleQuote" value="\\\\'"/>
<c:set var="doubleQuote" value="\"" />
<c:set var="escapedDoubleQuote" value="\\\\\""/>

<c:set var="userEmail" value="" />
<c:set var="userCity" value="" />
<c:set var="userState" value="" />
<c:set var="userZip" value="" />
<c:set var="userCountry" value="" />
<c:set var="age" value="" />
<c:set var="gender" value="" />
<c:set var="maritalStatus" value="" />
<c:set var="numChildren" value="" />
<c:set var="numInHousehold" value="" />
<c:set var="companyName" value="" />
<c:set var="hobbies" value="" />
<c:set var="income" value="" />

<c:if test="${personType.contactInfo != null}">
	<c:if test="${personType.contactInfo.emailAddress1 != null}">
		<c:set var="userEmail" value="${personType.contactInfo.emailAddress1.value}" />		
	</c:if>
	<c:if test="${personType.contactInfo.address != null}">
		<c:set var="userCity" value="${fn:replace(personType.contactInfo.address.city, singleQuote, escapedSingleQuote)}"/>
		<c:set var="userCity" value="${fn:replace(userCity, doubleQuote, escapedDoubleQuote)}"/>

		<c:set var="userState" value="${fn:replace(personType.contactInfo.address.stateOrProvinceName, singleQuote, escapedSingleQuote)}"/>
		<c:set var="userState" value="${fn:replace(userState, doubleQuote, escapedDoubleQuote)}"/>

		<c:set var="userCountry" value="${fn:replace(personType.contactInfo.address.country, singleQuote, escapedSingleQuote)}"/>
		<c:set var="userCountry" value="${fn:replace(userCountry, doubleQuote, escapedDoubleQuote)}"/>

		<c:set var="userZip" value="${personType.contactInfo.address.postalCode}" />
	</c:if>
</c:if>
<c:if test="${personType.personalProfile != null}">
	<c:set var="age" value="${personType.personalProfile.attributes.age}" />
	
	<c:choose>
		<c:when test="${personType.personalProfile.gender.value eq 'Unspecified'}">
			<c:set var="gender" value="N" />
		</c:when>
		<c:when test="${personType.personalProfile.gender.value eq 'Male'}">
			<c:set var="gender" value="M" />
		</c:when>
		<c:when test="${personType.personalProfile.gender.value eq 'Female'}">
			<c:set var="gender" value="F" />
		</c:when>
	</c:choose>

	<c:set var="maritalStatus" value="${personType.personalProfile.maritalStatus}" />
	<c:set var="numChildren" value="${personType.personalProfile.numberOfChildren}" />
	<c:set var="numInHousehold" value="${personType.personalProfile.householdSize}" />
	
	<c:set var="companyName" value="${fn:replace(personType.personalProfile.companyName, singleQuote, escapedSingleQuote)}"/>
	<c:set var="companyName" value="${fn:replace(companyName, doubleQuote, escapedDoubleQuote)}"/>

	<c:set var="hobbies" value="${fn:replace(personType.personalProfile.hobbies, singleQuote, escapedSingleQuote)}"/>
	<c:set var="hobbies" value="${fn:replace(hobbies, doubleQuote, escapedDoubleQuote)}"/>

	<c:set var="income" value="${personType.personalProfile.income}" />
</c:if>


[{
	userId : '<c:out value="${personType.personIdentifier.uniqueID}" escapeXml="false"/>', 
	userEmail: '<c:out value="${userEmail}" escapeXml="false" />',
	userCity: '<c:out value="${userCity}" escapeXml="false"/>',
	userState: '<c:out value="${userState}" escapeXml="false"/>',
	userZip: '<c:out value="${userZip}"/>',
	newsletterName: 'null',
	subscribedFlag: 'null',
	storeId: '<c:out value="${CommandContext.storeId}"/>',
	userCountry: '<c:out value="${userCountry}" escapeXml="false"/>',
	age: '<c:out value="${age}"/>',
	gender: '<c:out value="${gender}"/>',
	maritalStatus: '<c:out value="${maritalStatus}" />',
	numChildren: '<c:out value="${numChildren}"/>',
	numInHousehold: '<c:out value="${numInHousehold}" />',
	companyName: '<c:out value="${companyName}" escapeXml="false"/>',
	hobbies: '<c:out value="${hobbies}" escapeXml="false"/>',
	income: '<c:out value="${income}"/>'	
}]

