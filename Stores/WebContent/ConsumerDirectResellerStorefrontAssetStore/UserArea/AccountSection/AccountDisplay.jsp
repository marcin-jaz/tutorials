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
  * This JSP will display the Account page with the following information:
  *  - 'Register' button
  *  - Logon form, with Logon ID and Password field
  *  - 'Forgot your password?' link
  *****
--%>


<!-- Start - JSP File Name:  AccountDisplay.jsp -->

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../include/JSTLEnvironmentSetup.jspf" %>
<%@ include file="../../include/nocache.jspf" %>
<%-- ErrorMessageSetup.jspf is used to retrieve an appropriate error message when there is an error --%>
<%@ include file="../../include/ErrorMessageSetup.jspf" %>

<%-- Check to see if the request is coming with URL which means that we are executing the
     Commerce "authenticate" feature. The runtime does not put the catalogId in the request
     when forwarding to LogonForm. So, we need to get the catalogId from the URL. --%>
<c:set var="catalogId" value="${WCParam.catalogId}"/>
<c:if test="${!empty WCParam.URL && empty catalogId}">
	<c:forTokens items="${WCParam.URL}" delims="&" var="URLToken">
		<c:forTokens items="${URLToken}" delims="=" var="URLToken2">
			<c:if test="${URLToken2 eq 'catalogId'}">
				<c:set var="catalogToken" value="${URLToken}"/>
			</c:if>
		</c:forTokens>
	</c:forTokens>
	<c:forTokens items="${catalogToken}" delims="=" var="temp" varStatus="counter">
		<c:if test="${counter.last}">
			<c:set var="catalogId" value="${temp}"/>
		</c:if>
	</c:forTokens>
</c:if>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
	<title><fmt:message key="REGISTER_LOGIN_TITLE" bundle="${storeText}" /></title>
	<link rel="stylesheet" href='<c:out value="${jspStoreImgDir}${vfileStylesheet}"/>' type="text/css"/>
</head>

<body>

<%@ include file="../../include/LayoutContainerTop.jspf"%>

	<!--MAIN CONTENT STARTS HERE-->
	
	<h1><fmt:message key="REGISTER_LOGIN" bundle="${storeText}" /></h1>

	<%-- 
	  ***
	  *	Start: Error handling
	  * Show an appropriate error message when there is an error.
	  ***
	--%>
	<c:if test="${!empty errorMessage}">
		<span class="error"><br/><c:out value="${errorMessage}"/><br/><br/></span>
	</c:if>
	<%-- 
	  ***
	  *	End: Error handling
	  ***
	--%>				
					
	
	<table cellpadding="0" cellspacing="0" border="0" width="768" id="WC_AccountDisplay_Table_1">
	<tbody><tr>
		<td id="WC_AccountDisplay_TableCell_1" valign="top" align="left" width="27%">
			<h2><fmt:message key="RETURNING_CUSTOMER" bundle="${storeText}" /></h2>
			<c:import url="${jspStoreDir}Snippets/Member/Registration/RememberMeLogonForm.jsp">
				<c:param name="storeId" value="${WCParam.storeId}"/>
				<c:param name="catalogId" value="${catalogId}"/>
				<c:param name="langId" value="${langId}"/>
			</c:import>			
		</td>
		<td id="WC_AccountDisplay_TableCell_2" valign="top">
			<img src="<c:out value="${jspStoreImgDir}"/>images/lang_line.gif" alt="" width="16" height="220" border="0"/>
		</td>
		<td id="WC_AccountDisplay_TableCell_3" valign="top" align="left" width="27%">
			<h2><fmt:message key="NEW_CUSTOMER" bundle="${storeText}" /></h2>
			<span class="text">
				<fmt:message key="LIKE_REGISTER" bundle="${storeText}" /><br/><br/>
			</span>

			<c:choose>                                                                                                                                           
				<c:when test="${userType eq 'G'}">
					<%-- display the registration form, if the user is a guest --%>
					<c:set var="registerURL" value="UserRegistrationForm"/>
				</c:when>
				<c:otherwise>
					<%-- Logoff first, if the user has registered or logged on. LogoffView will then display the registration page --%>
					<c:set var="registerURL" value="Logoff"/>
				</c:otherwise>                                                                                                                               
			</c:choose>
			<c:url var="RegisterURL" value="${registerURL}">
				<c:param name="langId" value="${langId}" />
				<c:param name="storeId" value="${WCParam.storeId}" />
				<c:param name="catalogId" value="${catalogId}" />
				<c:param name="new" value="Y" />
			</c:url>                                                                                                                                             
			<a href='<c:out value="${RegisterURL}" />' class="button" id="WC_AccountDisplay_Link_1">
				<fmt:message key="REGISTER" bundle="${storeText}" />
			</a>			
		</td>
		<td id="WC_AccountDisplay_TableCell_4" valign="top" width="44%">
			&nbsp;
		</td>
	</tr></tbody>
	</table>

	<!-- MAIN CONTENT ENDS HERE -->

<%-- Hide CIP --%>
<c:set var="HideCIP" value="true"/>

<%@ include file="../../include/LayoutContainerBottom.jspf"%>

</body>
</html>
<!-- End - JSP File Name:  AccountDisplay.jsp -->
