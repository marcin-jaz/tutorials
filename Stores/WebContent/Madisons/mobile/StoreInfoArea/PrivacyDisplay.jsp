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

<%-- 
  *****
  * This JSP displays the Privacy page.
  *****
--%>

<!-- BEGIN PrivacyDisplay.jsp -->

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>

<%@ include file="../../include/parameters.jspf" %>
<%@ include file="../include/JSTLEnvironmentSetup.jspf" %>

<%-- Required variable for breadcrumb support --%>
<c:set var="privacyDispPage" value="true" scope="page" />

<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.2//EN" "http://www.openmobilealliance.org/tech/DTD/xhtml-mobile12.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" lang="${shortLocale}" xml:lang="${shortLocale}">

	<head>
		<title><fmt:message key="PRIVACY_POLICY_TITLE" bundle="${storeText}"/> - <c:out value="${storeName}"/></title>
		<meta http-equiv="content-type" content="application/xhtml+xml" />
		<meta http-equiv="cache-control" content="max-age=300" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no" />
		<link rel="stylesheet" type="text/css" href="${cssPath}" />
	</head>
	
	<body>
		
		<div id="wrapper">
		
			<%@ include file="../include/HeaderDisplay.jspf" %>
			<%@ include file="../include/BreadCrumbTrailDisplay.jspf" %>		

			<div id="privacy_policy" class="content_box"> 
				<div class="heading_container"> 
					<h2><fmt:message key="PRIVACY_POLICY_TITLE" bundle="${storeText}"/></h2> 
					<div class="clear_float"></div> 
				</div> 
			</div> 
			
			<div id="privacy_policy_sub_container"> 
				<div class="child_content_box"> 
					<div class="child_heading_container"> 
						<h3><fmt:message key="PRIVACY_POLICY_PERSONAL_INFO" bundle="${storeText}"/></h3> 
						<div class="clear_float"></div> 
					</div> 
					
					<div class="content_box"> 
						<p><fmt:message key="PRIVACY_POLICY_PERSONAL_INFO_LINE1" bundle="${storeText}"/></p> 
						<p><fmt:message key="PRIVACY_POLICY_PERSONAL_INFO_LINE2" bundle="${storeText}"/></p> 
						<p><fmt:message key="PRIVACY_POLICY_PERSONAL_INFO_LINE3" bundle="${storeText}"/></p> 
					</div> 
				</div> 
				
				<div class="child_content_box"> 
					<div class="child_heading_container"> 
						<h3><fmt:message key="PRIVACY_POLICY_COOKIES" bundle="${storeText}"/></h3> 
						<div class="clear_float"></div> 
					</div> 
					
					<div class="content_box"> 
						<p><fmt:message key="PRIVACY_POLICY_COOKIES_LINE1" bundle="${storeText}"/></p> 
					</div> 
				</div> 
				
				<div class="child_content_box"> 
					<div class="child_heading_container"> 
						<h3><fmt:message key="PRIVACY_POLICY_CHILDREN_POLICY" bundle="${storeText}"/></h3> 
						<div class="clear_float"></div> 
					</div> 
					
					<div class="content_box"> 
						<p><fmt:message key="PRIVACY_POLICY_CHILDREN_POLICY_LINE1" bundle="${storeText}"/></p> 
					</div> 
				</div> 
				
				<div class="child_content_box"> 
					<div class="child_heading_container"> 
						<h3><fmt:message key="PRIVACY_POLICY_IMPORTANT" bundle="${storeText}"/></h3> 
						<div class="clear_float"></div> 
					</div> 
					
					<div class="content_box"> 
						<p><fmt:message key="PRIVACY_POLICY_IMPORTANT_LINE1" bundle="${storeText}"/></p> 
					</div> 
				</div> 
			</div> 			
			<%@ include file="../include/FooterDisplay.jspf" %>			
		</div>
	</body>
</html>

<!-- END PrivacyDisplay.jsp -->
