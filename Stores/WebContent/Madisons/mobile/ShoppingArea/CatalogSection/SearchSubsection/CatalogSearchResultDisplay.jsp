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
  * This JSP displays the search results page
  *****
--%>

<!-- BEGIN CatalogSearchResultDisplay.jsp -->

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>

<%@ include file="../../../../include/parameters.jspf" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf" %>

<%-- Required variables for breadcrumb support --%>
<c:set var="searchType" value="${WCParam.sType}" />
<c:set var="searchPageGroup" value="true" scope="request" />
<c:if test="${!empty searchType}">
	<c:set var="searchPageType" value="true" scope="request" />
</c:if>
<c:set var="searchPage" value="true" scope="request" />

<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.2//EN" "http://www.openmobilealliance.org/tech/DTD/xhtml-mobile12.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" lang="${shortLocale}" xml:lang="${shortLocale}">
	<head>
		<title>
			<fmt:message key="TITLE_SEARCH_RESULTS" bundle="${storeText}"/>
		</title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no" />
		<link rel="stylesheet" href="${cssPath}" type="text/css"/>
	</head>

	<body>
		<div id="wrapper">		
		  <%@ include file="../../../include/HeaderDisplay.jspf" %>
			<c:if test="${empty searchType}"> 
				<%@ include file="../../../include/searchHeader.jspf" %>
			</c:if>
			<%@ include file="../../../include/BreadCrumbTrailDisplay.jspf"%>
			<%@ include file="CatalogSearchResultOnlyDisplay.jsp" %>						
			<%@ include file="../../../include/FooterDisplay.jspf" %>						
		
		</div>
	</body>
</html>

<!-- END CatalogSearchResultDisplay.jsp -->
