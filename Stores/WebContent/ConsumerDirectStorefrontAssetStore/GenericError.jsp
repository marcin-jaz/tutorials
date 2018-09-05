<%
//********************************************************************
//*-------------------------------------------------------------------
//* Licensed Materials - Property of IBM
//*
//* WebSphere Commerce
//*
//* (c) Copyright IBM Corp. 2000, 2002, 2004, 2005
//*
//* US Government Users Restricted Rights - Use, duplication or
//* disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
//*
//*-------------------------------------------------------------------
//*
%>

<%-- 
  *****
  * This JSP is called whenever a generic error occurs in the store and no specific errorViewName
  *  has been provided to redirect to.  This page handles 3 situations:
  *  - The store is set to closed or locked state
  *  - The customer is not authorized to access a page they requested
  *  - All other generic errors
  * If the store is closed or locked, a message is displayed to the customer telling them the store is closed.
  * If the user does not have authority to access a specific page, then page redirects to the stores logon page.
  * For all other errors, a generic error message is displayed.
  *****
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>

<%@ include file="include/JSTLEnvironmentSetup.jspf"%>
<flow:fileRef id="vfileLogo" fileId="vfile.logo"/>

<wcbase:useBean id="errorBean" classname="com.ibm.commerce.beans.ErrorDataBean"/>

<!-- JSP File Name:  GenericError.jsp -->

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html> 
<head>
	<title>
   	<%--
	//  If the store is closed or suspended, we get the message state _ERR_BAD_STORE_STATE (CMN1072E).
	//  We should display the store is closed page.
	--%>
	<c:choose>
		<c:when test="${errorBean.messageKey eq '_ERR_BAD_STORE_STATE'}">
			<fmt:message key="GENERICERR_TEXT3" bundle="${storeText}" /> 
		</c:when>
		<c:otherwise>
			<fmt:message key="ERROR_TITLE" bundle="${storeText}" />
		</c:otherwise>
	</c:choose>
	</title>
	<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${vfileStylesheet}" />" type="text/css" />
</head>

<body>

<table align="center" cellpadding="2" cellspacing="0" border="0" width="786" id="WC_GenericError_Table_1">
	<tbody><tr>
		<td valign="top" id="WC_GenericError_TableCell_11">  

		<%-- 
		  ***
		  *  Start: Custom Logo
		  ***
		--%>                	                            
		
		<flow:ifEnabled feature="CustomLogo">
		       <img src="<c:out value="${storeImgDir}${vfileLogo}" />" alt="<fmt:message key="HEADER_STORE_LOGO" bundle="${storeText}" />" />
		</flow:ifEnabled>
		<flow:ifDisabled feature="CustomLogo">
		       <img src="<c:out value="${jspStoreImgDir}${vfileLogo}" />" alt="<fmt:message key="HEADER_STORE_LOGO" bundle="${storeText}" />" />
		</flow:ifDisabled>
		
		<%-- 
		  ***
		  *  End: Custom Logo
		  ***
		--%>

		</td>
	</tr><tr>		
		<td valign="top" id="WC_GenericError_TableCell_12">

<c:choose>
	<c:when test="${errorBean.messageKey eq '_ERR_BAD_STORE_STATE'}">
			<span class="heading"><fmt:message key="GENERICERR_TEXT3" bundle="${storeText}" /></span>
			<br /><br /><br />
			<span class="text"><fmt:message key="GENERICERR_TEXT4" bundle="${storeText}" /></span>
  	</c:when>
  	<c:otherwise>        

		<!--MAIN CONTENT STARTS HERE-->

			<span class="heading"><fmt:message key="ERROR_TITLE" bundle="${storeText}" /></span>
			<br /><br />
			<c:url var="ContactViewURL" value="ContactView">
				<c:param name="langId" value="${langId}" />
				<c:param name="storeId" value="${WCParam.storeId}" />
				<c:param name="catalogId" value="${WCParam.catalogId}" />
			</c:url>
			<span class="text">
				<fmt:message key="GENERICERR_MAINTEXT" bundle="${storeText}">                                     
					<fmt:param>
						<a href="<c:out value="${ContactViewURL}"/>" id="WC_GenericError_Link">
						<fmt:message key="GENERICERR_CONTACT_US" bundle="${storeText}" /></a>
					</fmt:param>
				</fmt:message>
			</span>                			
		</td>
		</tr><tr>
		<td id="WC_GenericError_TableCell_22">
		<%--
			/* The section below is intended to aid store developers in debugging problems in the sample store. 
		 	 * For a real online store, this may not be required.
		 	 */
		--%>
			<br /><br />
			<span class="productName"><fmt:message key="GENERICERR_DEVELOPER" bundle="${storeText}" /></span>
			<br /><br />
			<span class="text"><fmt:message key="GENERICERR_HTML" bundle="${storeText}" /></span>

		<!--
		//********************************************************************
		//*
		
		<fmt:message key="GENERICERR_TEXT1" bundle="${storeText}" />
		<fmt:message key="GENERICERR_TEXT2" bundle="${storeText}" />
		<fmt:message key="GENERICERR_TYPE" bundle="${storeText}" />	<c:out value="${errorBean.exceptionType}" escapeXml="false" />
		<fmt:message key="GENERICERR_KEY" bundle="${storeText}" /> <c:out value="${errorBean.messageKey}" escapeXml="false" />
		<fmt:message key="GENERICERR_MESSAGE" bundle="${storeText}" /> <c:out value="${errorBean.message}" escapeXml="false" />
		<fmt:message key="GENERICERR_SYSMESSAGE" bundle="${storeText}" /> <c:out value="${errorBean.systemMessage}" escapeXml="false" />
		<fmt:message key="GENERICERR_CMD" bundle="${storeText}" /> <c:out value="${errorBean.originatingCommand}" escapeXml="false" />
		<fmt:message key="GENERICERR_CORR_ACTION" bundle="${storeText}" /> <c:out value="${errorBean.correctiveActionMessage}" escapeXml="false" />
		
		<c:if test="${!empty errorBean.exceptionData}">
			<fmt:message key="GENERICERR_EXCEPTIONDATA" bundle="${storeText}" />
		</c:if>
		<c:forEach var="entry" items="${errorBean.exceptionData}">
			<fmt:message key="GENERICERR_NAME" bundle="${storeText}" /><c:out value="${entry.key}" />
			<fmt:message key="GENERICERR_VALUE" bundle="${storeText}" /><c:out value="${entry.value}" />
		</c:forEach>
		
		//*
		//********************************************************************
		-->
		
		<!-- MAIN CONTENT ENDS HERE -->

	</c:otherwise>
</c:choose>

		</td>
	</tr></tbody>
</table>

</body>
</html>
