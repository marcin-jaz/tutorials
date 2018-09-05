<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2008, 2009 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf" %>
<%@ include file="../../../include/nocache.jspf" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ taglib uri="http://commerce.ibm.com/coremetrics"  prefix="cm" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="${shortLocale}" xml:lang="${shortLocale}">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><fmt:message key="PASSWORD_TITLE" bundle="${storeText}" /></title>
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
<!-- Page Start -->
<div id="page">
     <!-- Header Nav Start -->
	<%@ include file="../../../include/LayoutContainerTop.jspf"%>
     <!-- Header Nav End -->
	 <div id="MessageArea" >
		<br />
		<span id="ErrorMessageText" class="error_msg">
			
		</span>
		<br /><br />  
	</div>
     <!-- Main Content Start -->
     <div id="content_wrapper_border">
          <!-- Content Start -->
          <div id="box">

			<div class="content" id="WC_PasswordResetDisplay_div_1">

			<br clear="all"/>
			<br/>

			<%-- A message is displayed confirming that the forget password email is sent --%>
			<span class="strong"><fmt:message key="PASSWORD_SENT" bundle="${storeText}" /></span>
			<br /><br />

			<wcf:url var="LogonFormURL" value="LogonForm">
				<wcf:param name="storeId"   value="${WCParam.storeId}"  />
				<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
				<wcf:param name="langId" value="${langId}" />
				<wcf:param name="myAcctMain" value="1"/>
			</wcf:url>

			<span class="primary_button button_fit" >
				<span class="button_container">
					<span class="button_bg">
						<span class="button_top">
							<span class="button_bottom">   
								<a href="<c:out value='${LogonFormURL}'/>" id="WC_PasswordResetDisplay_Link_1">
									<fmt:message key="CONTINUE_LOGIN" bundle="${storeText}" />
								</a>
							</span>
						</span>
					</span>	
				</span>
			</span>	

		</div></div>
	</div>
	<%@ include file="../../../include/LayoutContainerBottom.jspf"%>
     <!-- Footer Start End -->
</div>
<div id="page_shadow" class="shadow"></div>
<flow:ifEnabled feature="Analytics"><cm:pageview/></flow:ifEnabled>
</body>
</html>
