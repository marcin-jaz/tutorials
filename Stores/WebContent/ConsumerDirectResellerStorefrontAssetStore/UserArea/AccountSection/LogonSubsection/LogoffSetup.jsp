<%
//********************************************************************
//*-------------------------------------------------------------------
//* Licensed Materials - Property of IBM
//*
//* WebSphere Commerce
//*
//* (c) Copyright IBM Corp. 2000, 2002, 2004
//*
//* US Government Users Restricted Rights - Use, duplication or
//* disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
//*
//*-------------------------------------------------------------------
//*
%>

<%-- 
  *****
  * This page is called when a Logged in user tries to register again or 
  * clicks on the 'forgot you password' link.  The user is logged off and
  * redirected to another page.
  *****
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf" %>

<c:choose>
	<c:when test="${WCParam.state eq 'forgetpassword'}">
		<c:set var="incfile" value="${jspStoreDir}UserArea/AccountSection/PasswordSubsection/PasswordResetForm.jsp"/>
	</c:when>
	<c:otherwise>
		<c:set var="incfile" value="${jspStoreDir}UserArea/AccountSection/RegistrationSubsection/UserRegistrationSetup.jsp"/>
	</c:otherwise>
</c:choose>

<c:import url="${incfile}"/>
