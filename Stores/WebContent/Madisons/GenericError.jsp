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
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="include/JSTLEnvironmentSetup.jspf" %>
<%@ include file="include/nocache.jspf" %>
<%@ include file="include/ErrorMessageSetup.jspf" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ taglib uri="http://commerce.ibm.com/coremetrics"  prefix="cm" %>

<flow:fileRef id="vfileLogo" fileId="vfile.logo"/>

<c:if test="${empty storeId }">
	<c:set var="storeId" value="${WCParam.storeId}"/>
</c:if>
<c:if test="${empty catalogId }">
	<c:set var="catalogId" value="${WCParam.catalogId}"/>
</c:if>
<wcf:url var="TopCategoriesDisplayURL" value="TopCategories1">
  <wcf:param name="langId" value="${langId}" />
  <wcf:param name="storeId" value="${storeId}" />
  <wcf:param name="catalogId" value="${catalogId}" />
</wcf:url>

<wcbase:useBean id="errorBean" classname="com.ibm.commerce.beans.ErrorDataBean"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="${shortLocale}" xml:lang="${shortLocale}">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
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
				<%-- store is not closed --%>
				<wcbase:useBean id="storeDB" classname="com.ibm.commerce.common.beans.StoreDataBean"/>			
				<c:if test="${empty catalogId}">
					<c:set var="catalogId" value="${storeDB.masterCatalogDataBean.catalogId}"/>
				</c:if>
			</c:otherwise>
		</c:choose>
	</title>
	<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${vfileStylesheet}"/>" type="text/css"/>
<!--[if lte IE 6]>
<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${vfileStylesheetie}"/>" type="text/css"/>
<![endif]-->
	<script type="text/javascript" src="<c:out value="${dojoFile}"/>" djConfig="${dojoConfigParams}"></script>
	<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/MessageHelper.js"/>"></script>
	<%@ include file="include/CommonJSToInclude.jspf"%>
</head>
 
<body>
<%@ include file="include/StoreCommonUtilities.jspf"%>
<div id="page">
    <!-- Header Nav Start -->
	<c:choose>
		<c:when test="${!b2bStore}">
			<%@ include file="include/LayoutContainerTop.jspf"%>
		</c:when>
		<c:otherwise>
			<div id="header">
				<div id="header_logo">
					<flow:ifEnabled feature="CustomLogo">
						<a href="<c:out value="${TopCategoriesDisplayURL}"/>" id="WC_CachedHeaderDisplay_Link_1a"><img src="<c:out value="${storeImgDir}${vfileLogo}" />" alt="<c:out value="${storeName}" />" border="0"/></a>
					</flow:ifEnabled>
					<flow:ifDisabled feature="CustomLogo">
					  <a href="<c:out value="${TopCategoriesDisplayURL}"/>" id="WC_CachedHeaderDisplay_Link_2a"><img src="<c:out value="${jspStoreImgDir}${vfileLogo}" />" alt="<c:out value="${storeName}" />" border="0"/></a>
					</flow:ifDisabled>
				</div>
			</div>
			<div id="main_content_wrapper">
			<%@ include file="include/LeftSidebarDisplay.jspf"%>
		</c:otherwise>
	</c:choose>
	<!-- Header Nav End -->
     <!-- Main Content Start -->
     <div id="content_wrapper_border">
          <!-- Content Start -->
          <div id="box" class="my_account generic_error_container">
          	<div id="errorPage">
				<div id="WC_GenericError_1" class="contentgrad_header">
					<div id="WC_GenericError_2" class="left_corner"></div>
					<div id="WC_GenericError_3" class="left"><h1 class="myaccount_title"><fmt:message key="ERROR_TITLE" bundle="${storeText}"/></h1></div>
					<div id="WC_GenericError_4" class="right_corner"></div>
				</div>
				
				<div id="WC_GenericError_5" class="content">
					<div id="WC_GenericError_6" class="info">
						<c:choose>
	
								<c:when test="${errorBean.messageKey != null}">
									<c:choose>
										<c:when test="${errorBean.messageKey eq '_ERR_USER_AUTHORITY'}">
											<c:choose>
												<c:when test="${userType eq 'G'}">
														<span><fmt:message key="AUTHORIZATION_ERROR1" bundle="${storeText}" /></span>
														<br />
														<br />
														<c:url var="LogonFormURL" value="LogonForm">
															<c:param name="storeId" value="${storeId}" />
															<c:param name="langId" value="${langId}" />
															<c:param name="catalogId" value="${catalogId}" />
															<c:param name="myAcctMain" value="1" />
														</c:url>
														<span class="primary_button" id="WC_GenericError_7" >
															<span class="button_container">
																<span class="button_bg">
																	<span class="button_top">
																		<span class="button_bottom">   
																			<a href="<c:out value="${LogonFormURL}"/>" id="WC_GenericError_Link_1">
																				<fmt:message key="Logon_Title" bundle="${storeText}"/>
																			</a>
																		</span>
																	</span>
																</span>	
															</span>
														</span>
												</c:when>
												<c:otherwise>
													<span><fmt:message key="AUTHORIZATION_ERROR2" bundle="${storeText}" /></span>
												</c:otherwise>
											</c:choose>
										</c:when>

										<c:when test="${errorBean.messageKey eq '_ERR_BAD_STORE_STATE'}">
											<span class="warning"><fmt:message key="GENERICERR_TEXT4" bundle="${storeText}" /></span>
										</c:when>

										<c:otherwise>
												<span ><fmt:message key="GENERICERR_TEXT1" bundle="${storeText}" /></span>
												<br />
												<span><fmt:message key="GENERICERR_TEXT2" bundle="${storeText}" /></span>
										</c:otherwise>
									</c:choose>
								</c:when>

								<c:otherwise>
									<span ><fmt:message key="GENERICERR_TEXT1" bundle="${storeText}" /></span>
									<br />
									<span><fmt:message key="GENERICERR_TEXT2" bundle="${storeText}" /></span>
									
								</c:otherwise>

							</c:choose>
							
			
						<br /><br />
						<span class="generic_error_developers"><fmt:message key="GENERICERR_DEVELOPER" bundle="${storeText}" /></span>
					
						<span><fmt:message key="GENERICERR_HTML" bundle="${storeText}" /></span>
							
										<!--
					//********************************************************************
					//*-------------------------------------------------------------------
					
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
					
					//*-------------------------------------------------------------------
					//********************************************************************
					-->
					
										
					</div>
				</div>
							
				<div id="WC_GenericError_8" class="footer">
					<div id="WC_GenericError_9" class="left_corner"></div>
					<div id="WC_GenericError_10" class="left"></div>
					<div id="WC_GenericError_11" class="right_corner"></div>
				</div>
				</div>
          </div>
          <!-- Content End -->
     </div>
     <!-- Main Content End -->
     <!-- Footer Start Start -->
	<%@ include file="include/LayoutContainerBottom.jspf"%>
     <!-- Footer Start End -->
</div>
<div id="page_shadow" class="shadow"/>
<flow:ifEnabled feature="Analytics">
<cm:error/>
</flow:ifEnabled>

</body>
</html>
