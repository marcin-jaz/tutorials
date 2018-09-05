<%
//********************************************************************
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

<%-- 
  *****
  * This JSP is called whenever the current session has timed out.
  *****
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf"%>
<%@ include file="../../../include/nocache.jspf"%>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ taglib uri="http://commerce.ibm.com/coremetrics"  prefix="cm" %>
<flow:fileRef id="vfileLogo" fileId="vfile.logo"/>

<wcf:url var="TopCategoriesDisplayURL" value="TopCategories1">
  <wcf:param name="langId" value="${langId}" />
  <wcf:param name="storeId" value="${WCParam.storeId}" />
  <wcf:param name="catalogId" value="${WCParam.catalogId}" />
</wcf:url>

<c:choose>
	<c:when test="${empty WCParam.catalogId}">
	 	<%-- The page will be reloaded with the selected catalogId --%>
		<wcf:url var="sWebAppPath" value="ReLogonFormView">
			<wcf:param name="catalogId" value="${sdb.masterCatalogDataBean.catalogId}"/>
			<wcf:param name="storeId" value="${WCParam.storeId}"/>
			<wcf:param name="langId" value="${CommandContext.languageId}"/>
		</wcf:url>
		<meta http-equiv="Refresh" content="0;URL=<c:out value="${sWebAppPath}"/>"/>
	</c:when>
	<c:otherwise>

	<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
	<html lang="${shortLocale}" xml:lang="${shortLocale}">
	<head>
		<title><fmt:message bundle="${storeText}" key="USER_SESSION_TIMEOUT_TITLE" /></title>
		<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${vfileStylesheet}"/>" type="text/css"/>
<!--[if lte IE 6]>
<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${vfileStylesheetie}"/>" type="text/css"/>
<![endif]-->
		<script type="text/javascript" src="<c:out value="${dojoFile}"/>" djConfig="${dojoConfigParams}"></script>
		<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/MessageHelper.js"/>"></script>
		<%@ include file="../../../include/CommonJSToInclude.jspf"%>
	</head>
	
		<body>
		<%@ include file="../../../include/StoreCommonUtilities.jspf"%>
		<!-- JSP File Name:  UserTimeoutView.jsp -->
	<div id="page">
    
	<!-- Header Nav Start -->
	<c:choose>
		<c:when test="${!b2bStore}">
			<%@ include file="../../../include/LayoutContainerTop.jspf"%>
		</c:when>
		<c:otherwise>
			<div id="header">
				<div id="header_logo">
					<flow:ifEnabled feature="CustomLogo">
						<a href="<c:out value="${TopCategoriesDisplayURL}"/>" id="WC_CachedHeaderDisplay_Link_1"><img src="<c:out value="${storeImgDir}${vfileLogo}" />" alt="<c:out value="${storeName}" />" border="0"/></a>
					</flow:ifEnabled>
					<flow:ifDisabled feature="CustomLogo">
					  <a href="<c:out value="${TopCategoriesDisplayURL}"/>" id="WC_CachedHeaderDisplay_Link_2"><img src="<c:out value="${jspStoreImgDir}${vfileLogo}" />" alt="<c:out value="${storeName}" />" border="0"/></a>
					</flow:ifDisabled>
				</div>
			</div>
			<div id="main_content_wrapper">
				<%@ include file="../../../include/LeftSidebarDisplay.jspf"%>
		</c:otherwise>
	</c:choose>
	<!-- Header Nav End -->
     
	<div id="MessageArea" >
		<br />
		<span id="ErrorMessageText" class="error_msg">
			
		</span>
		<br /><br />  
	</div>
	 <!--MAIN CONTENT STARTS HERE-->
	<div id="content_wrapper_border">
		<div id="box" class=" my_account generic_error_container">
			<div id="errorPage">
			
				<div id="WC_UserTimeoutView_1" class="contentgrad_header">
					<div id="WC_UserTimeoutView_2" class="left_corner"></div>
					<div id="WC_UserTimeoutView_3" class="left"><h1 class="myaccount_title"><fmt:message key="USER_SESSION_TIMEOUT_TITLE" bundle="${storeText}"/></h1></div>
					<div id="WC_UserTimeoutView_4" class="right_corner"></div>
				</div>
				<wcf:url var="LogonFormURL" value="LogonForm">
							<wcf:param name="langId" value="${langId}" />
							<wcf:param name="storeId" value="${WCParam.storeId}" />
							<wcf:param name="catalogId" value="${WCParam.catalogId}" />
							<wcf:param name="myAcctMain" value="1" />
				</wcf:url>
				<div id="WC_UserTimeoutView_5" class="content">
					<div id="WC_UserTimeoutView_6" class="info">
						<fmt:message key="USER_SESSION_TIMEOUT_DETAILS" bundle="${storeText}"/>
						<br/>
						<br/>
						<span id="WC_AjaxAddressBookForm_div_19" class="primary_button button_fit">
						<span class="button_container">
							<span class="button_bg">
								<span class="button_top">
									<span class="button_bottom">   
										<a href="<c:out value="${LogonFormURL}"/> "><fmt:message key="USER_SESSION_TIMEOUT_LOGIN" bundle="${storeText}"/></a>
									</span>
								</span>	
							</span>
						</span>
					</span>
					<br clear="all"/>					
					</div>
				</div>
				
				<div id="WC_UserTimeoutView_7" class="footer">
					<div id="WC_UserTimeoutView_8" class="left_corner"></div>
					<div id="WC_UserTimeoutView_9" class="left"></div>
					<div id="WC_UserTimeoutView_10" class="right_corner"></div>
				</div>
			</div>
		</div>	
	</div>
	<!-- MAIN CONTENT ENDS HERE -->

	<%@ include file="../../../include/LayoutContainerBottom.jspf"%>
     <!-- Footer Start End -->
</div>
<div id="page_shadow" class="shadow"></div>
<flow:ifEnabled feature="Analytics"><cm:pageview/></flow:ifEnabled>
	</body>
	</html>
	</c:otherwise>
</c:choose>
