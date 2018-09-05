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
  * This JSP displays the mobile store home page
  *****
--%>

<!-- BEGIN mobileHome.jsp -->

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>

<%@ include file="../include/parameters.jspf" %>
<%@ include file="include/JSTLEnvironmentSetup.jspf" %>

<c:set var="storeId" value="${WCParam.storeId}" />
<c:set var="catalogId" value="${WCParam.catalogId}" />
<c:if test="${empty catalogId}">
	<c:set var="catalogId" value="${sdb.masterCatalogDataBean.catalogId}"/>
</c:if>

<%-- Required variable for breadcrumb support --%>
<c:set var="mobileIndex" value="true" scope="page" />

<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.2//EN" "http://www.openmobilealliance.org/tech/DTD/xhtml-mobile12.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" lang="${shortLocale}" xml:lang="${shortLocale}">

	<head>
		<title><fmt:message key="HOME" bundle="${storeText}"/> - <c:out value="${storeName}"/></title>
		<meta http-equiv="content-type" content="application/xhtml+xml" />
		<meta http-equiv="cache-control" content="max-age=300" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no" />
		<link rel="stylesheet" type="text/css" href="${cssPath}" />
	</head>
	
	<body>
		
		<div id="wrapper">
		
			<%@ include file="./include/HeaderDisplay.jspf" %>
			<%@ include file="./include/searchHeader.jspf" %>

			<%-- 
			<div id="index_banner" class="banner">
				<img src="<c:out value="${jspStoreImgDir}"/>mobile/images/index_banner.jpg" width="320" height="75" border="0" alt="Comfort - Relax in luxury" />
			</div>
			<div class="text_container">
				<p>Style your home with these great chairs.</p>
				<p><span class="bullet">&#187; </span><a href="#" title="More Info">More Info</a></p>
			</div>
			--%>		
			<%out.flush();%>
			<c:import url="${jspStoreDir}mobile/Snippets/Marketing/ESpot/ContentAreaESpot.jsp">
				<c:param name="emsName" value="MobileHomePage" />
				<c:param name="catalogId" value="${catalogId}" />
			</c:import>
			<%out.flush();%>			
			
			<%@ include file="include/BrowseDepartments.jspf" %>
			<%@ include file="include/storeOptions.jspf" %>
			
			<%out.flush();%>
			<c:import url="${jspStoreDir}mobile/Snippets/Marketing/ESpot/FeaturedProductsESpot.jsp">
				<c:param name="emsName" value="MobileHomePageFeaturedProducts" />
				<c:param name="catalogId" value="${catalogId}" />
				<c:param name="align" value="H" />
			</c:import>
			<%out.flush();%>
			
			<%@ include file="include/FooterDisplay.jspf" %>			
		</div>
	</body>
</html>

<!-- END mobileHome.jsp -->
