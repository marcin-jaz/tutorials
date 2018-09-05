<%
//********************************************************************
//*-------------------------------------------------------------------
//* Licensed Materials - Property of IBM
//*
//* WebSphere Commerce
//*
//* (c) Copyright IBM Corp. 2000, 2004
//*
//* US Government Users Restricted Rights - Use, duplication or
//* disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
//*
//*-------------------------------------------------------------------
//*
%>
<%-- 
  *****
  * This Setup JSP includes 1 of 4 following pages depending on what parameter value is being passed in the URL
  *  - UserRegistrationAddForm
  *  - UserRegistrationUpdateForm
  *  - LogonSetup
  *  - PasswordUpdateForm) 
  * Whenever the user is directed to this page, they are with registering, editing their registration, logging on or changing their password.  
  *****
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>

<%@ include file="../../../include/JSTLEnvironmentSetup.jspf" %>

<c:choose>
	<c:when test="${!empty WCParam.new}">
		<c:set var="incfile" value="${jspStoreDir}UserArea/AccountSection/RegistrationSubsection/UserRegistrationAddForm.jsp"/>
	</c:when>
	<c:when test="${userType == 'G'}">
		<c:set var="incfile" value="${jspStoreDir}UserArea/AccountSection/LogonSubsection/LogonSetup.jsp"/>
	</c:when>
	<c:when test="${!empty WCParam.editRegistration}">
		<c:set var="incfile" value="${jspStoreDir}UserArea/AccountSection/RegistrationSubsection/UserRegistrationUpdateForm.jsp"/>
	</c:when>
	<c:otherwise>
		<c:set var="incfile" value="${jspStoreDir}UserArea/AccountSection/PasswordSubsection/PasswordUpdateForm.jsp"/>
	</c:otherwise>
</c:choose>

<c:import url="${incfile}"/>
