<%--==========================================================================
Licensed Materials - Property of IBM

WebSphere Commerce

(c) Copyright IBM Corp.  2006
All Rights Reserved

US Government Users Restricted Rights - Use, duplication or
disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
===========================================================================--%>
<%-- 
  *****
  * This JSP displays error message when trying to execute some URL that is found to be
  * harmful to the server.
  *****
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ taglib uri="http://commerce.ibm.com/coremetrics"  prefix="cm" %>
<%@ include file="include/JSTLEnvironmentSetup.jspf" %>
<%@ include file="include/nocache.jspf" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="${shortLocale}" xml:lang="${shortLocale}">
	<head>
		<title><fmt:message key="PROHIBITEDCHAR_ERROR_TITLE" bundle="${storeText}" /></title>
		<link rel="stylesheet" href='<c:out value="${jspStoreImgDir}${vfileStylesheet}"/>' type="text/css"/>
		<script type="text/javascript" src="<c:out value="${dojoFile}"/>" djConfig="${dojoConfigParams}"></script>
		<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/MessageHelper.js"/>"></script>
		<%@ include file="include/CommonJSToInclude.jspf"%>
	</head>

	<body>
	<%@ include file="include/StoreCommonUtilities.jspf"%>
	
		<div id="page">
		
			<!-- Header Nav Start -->
			<%@ include file="include/LayoutContainerTop.jspf"%>
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
					<div id="WC_PCE_1" class="contentgrad_header">
						<div id="WC_PCE_2" class="left_corner"></div>
						<div id="WC_PCE_3" class="left"><h1 class="myaccount_title"><fmt:message key="PROHIBITEDCHAR_ERROR_TITLE" bundle="${storeText}" /></h1></div>
						<div id="WC_PCE_4" class="right_corner"></div>
					</div>
					<div id="WC_PCE_5" class="content">
						<div id="WC_PCE_6" class="info">						
					
							<br clear="all"/>
							<fmt:message key="PROHIBITEDCHAR_ERROR_DESC" bundle="${storeText}" />
							<br /><br />
							<fmt:message key="PROHIBITEDCHAR_ERROR_BACK_DESC" bundle="${storeText}" />
							<br /><br />
							<span class="primary_button button_fit">
								<span class="button_container">
									<span class="button_bg">
										<span class="button_top">
											<span class="button_bottom">   
												<a href="javascript:history.back(1)" id="WC_ProhibitedCharacterError_Link_1">
		      										<fmt:message key="PROHIBITEDCHAR_ERROR_BACK" bundle="${storeText}"/>
		      									</a>
											</span>
										</span>
									</span>
								</span>
							</span>
						
						<br /><br />
						</div>
					</div>
						
					<div id="WC_PCE_10" class="footer">
						<div id="WC_PCE_7" class="left_corner"></div>
						<div id="WC_PCE_8" class="left"></div>
						<div id="WC_PCE_9" class="right_corner"></div>
					</div>
					
					
					</div>
				</div>
			</div>
			<!-- MAIN CONTENT END -->
		
			<!-- Footer Start -->
			<%@ include file="include/LayoutContainerBottom.jspf"%>
			<!-- Footer End -->
		</div>
		<div id="page_shadow" class="shadow"></div>
<flow:ifEnabled feature="Analytics"><cm:pageview/></flow:ifEnabled>
	</body>
</html>
