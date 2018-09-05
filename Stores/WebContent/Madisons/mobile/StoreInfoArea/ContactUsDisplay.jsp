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
  * This JSP displays the Contact Us page.
  *****
--%>

<!-- BEGIN ContactUsDisplay.jsp -->

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>

<%@ include file="../../include/parameters.jspf" %>
<%@ include file="../include/JSTLEnvironmentSetup.jspf" %>

<%-- Required variable for breadcrumb support --%>
<c:set var="contactUsDispPage" value="true" scope="page" />

<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.2//EN" "http://www.openmobilealliance.org/tech/DTD/xhtml-mobile12.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" lang="${shortLocale}" xml:lang="${shortLocale}">

	<head>
		<title><fmt:message key="CONTACT_US_TITLE" bundle="${storeText}"/> - <c:out value="${storeName}"/></title>
		<meta http-equiv="content-type" content="application/xhtml+xml" />
		<meta http-equiv="cache-control" content="max-age=300" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no" />
		<link rel="stylesheet" type="text/css" href="${cssPath}" />
	</head>
	
	<body>
		
		<div id="wrapper">
		
			<%@ include file="../include/HeaderDisplay.jspf" %>
			<%@ include file="../include/BreadCrumbTrailDisplay.jspf" %>

			<div id="contact_us" class="content_box"> 
				<div class="heading_container_with_underline"> 
					<h2><fmt:message key="CONTACT_US_TITLE" bundle="${storeText}"/></h2>			
					<div class="clear_float"></div> 
				</div> 
				
				<p><fmt:message key="CONTACT_US_LINE1" bundle="${storeText}"/></p> 
				
				<p><fmt:message key="CONTACT_US_LINE2" bundle="${storeText}"/></p> 
				
				<ul> 
					<li class="office_info"><span class="bold"><fmt:message key="CONTACT_US_ADDR_LINE1" bundle="${storeText}"/></span></li> 
					<li class="office_info"><fmt:message key="CONTACT_US_ADDR_LINE2" bundle="${storeText}"/></li> 
					<li class="office_info"><fmt:message key="CONTACT_US_ADDR_LINE3" bundle="${storeText}"/></li> 
					<li class="phone_number"><span class="bullet">&#187; </span><a href="tel:<fmt:message key='CONTACT_US_ADDR_LINE4_TEL' bundle='${storeText}'/>"><fmt:message key="CONTACT_US_ADDR_LINE4" bundle="${storeText}"/></a></li> 
				</ul>				
			</div> 			
			
			<%@ include file="../include/FooterDisplay.jspf" %>			
		</div>
	</body>
</html>

<!-- END ContactUsDisplay.jsp -->
