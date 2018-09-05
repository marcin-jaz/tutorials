<%
//*-------------------------------------------------------------------
//* Licensed Materials - Property of IBM
//*
//* WebSphere Commerce
//*
//* (c) Copyright IBM Corp. 2008
//*
//* US Government Users Restricted Rights - Use, duplication or
//* disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
//*
//*-------------------------------------------------------------------
//*
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
<%out.flush();%>
<c:import url="${incfile}"/>
<%out.flush();%>
