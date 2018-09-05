<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2000, 2009 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>

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

<%-- Start - JSP File Name:  GenericError.jsp --%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>

<%@ include file="../include/parameters.jspf" %>
<%@ include file="include/JSTLEnvironmentSetup.jspf" %>
<%@ include file="include/ErrorMessageSetup.jspf" %>


<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.2//EN" "http://www.openmobilealliance.org/tech/DTD/xhtml-mobile12.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title>
			<fmt:message key="ERROR_TITLE" bundle="${storeText}">
				<fmt:param value="${storeName}" />
			</fmt:message>
		</title>
		
		<meta http-equiv="content-type" content="application/xhtml+xml" />
		<meta http-equiv="cache-control" content="max-age=300" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no" />
	
		<link rel="stylesheet" href="${cssPath}" type="text/css" />
	</head>

	<body>
		<div id="wrapper">

			<%@ include file="include/HeaderDisplay.jspf" %>	
			
			<div id="error_message" class="content_box">
				<div class="heading_container_with_underline">
					<h2><fmt:message key="ERROR_TITLE" bundle="${storeText}" /></h2>
					<div class="clear_float"></div>
				</div>
				
				<table>
					<tbody>
						<tr>
							<td>			
								<c:choose>
									<c:when test="${errorBean.messageKey eq '_ERR_BAD_STORE_STATE'}">
										<span class="heading"><fmt:message key="GENERICERR_TEXT3" bundle="${storeText}" /></span>
										<br /><br /><br />
										<span class="text"><fmt:message key="GENERICERR_TEXT4" bundle="${storeText}" /></span>
								  	</c:when>
			  						<c:otherwise>        
			
										<!--MAIN CONTENT STARTS HERE-->					
										<wcf:url var="ContactViewURL" value="ContactView">
											<wcf:param name="langId" value="${langId}" />
											<wcf:param name="storeId" value="${WCParam.storeId}" />
											<wcf:param name="catalogId" value="${WCParam.catalogId}" />
										</wcf:url>
										<span class="text">
											<fmt:message key="GENERICERR_MAINTEXT" bundle="${storeText}">                                     
												<fmt:param>
													<a href="<c:out value="${ContactViewURL}"/>" id="WC_GenericError_Link">
													<fmt:message key="GENERICERR_CONTACT_US" bundle="${storeText}" /></a>
												</fmt:param>
											</fmt:message>
										</span>                			
										
										</td>
										</tr>
										<tr>
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
										
										//********************************************************************
										-->
										
										<!-- MAIN CONTENT ENDS HERE -->
							
									</c:otherwise>
								</c:choose>
							</td>
						</tr>
					</tbody>
				</table>
			</div>	
						
			<%@ include file="include/FooterDisplay.jspf" %>		
		</div>
	</body>
</html>

<!-- END GenericError.jsp -->
