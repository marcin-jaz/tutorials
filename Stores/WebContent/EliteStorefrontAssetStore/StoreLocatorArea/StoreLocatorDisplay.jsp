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
  * This JSP displays the store locator main page.
  *****
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/coremetrics"  prefix="cm" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../include/JSTLEnvironmentSetup.jspf" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="${shortLocale}" xml:lang="${shortLocale}">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><fmt:message key="STORELOCATOR_TITLE" bundle="${storeText}" /></title>
<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${vfileStylesheet}"/>" type="text/css"/>
<!--[if lte IE 6]>
<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${vfileStylesheetie}"/>" type="text/css"/>
<![endif]-->
<script type="text/javascript" src="<c:out value="${dojoFile}"/>" djConfig="${dojoConfigParams}"></script>
<%@ include file="../include/CommonJSToInclude.jspf"%>
</head>
<body>
<%@ include file="../include/StoreCommonUtilities.jspf"%> 
<!-- Page Start -->
<div id="page">

<c:set var="fromPage" value="StoreLocator" />
<c:if test="${!empty WCParam.fromPage}">
  <c:set var="fromPage" value="${WCParam.fromPage}" />
</c:if>
<c:if test="${!empty param.fromPage}">
  <c:set var="fromPage" value="${param.fromPage}" />
</c:if>

<c:if test="${fromPage == 'StoreLocator'}">
	<c:set var="hasBreadCrumbTrail" value="true" scope="request"/>
	<c:set var="extensionPageWithBCF" value="true" scope="request"/>
  <fmt:message var="finalBreadcrumb" key="BREADCRUMB_STORE_LOCATOR" bundle="${storeText}" scope="request"/>
</c:if>  
<c:if test="${fromPage == 'ProductDetails'}">
	<c:set var="hasBreadCrumbTrail" value="true" scope="request"/>
	<c:set var="extensionPageWithBCF" value="true" scope="request"/>
  <fmt:message var="finalBreadcrumb" key="BREADCRUMB_CHECK_AVAILABILITY" bundle="${storeText}" scope="request"/>
</c:if>

  <!-- Header Nav Start -->
  <%@ include file="../include/LayoutContainerTop.jspf"%>
  <!-- Header Nav End -->
  
  <div id="MessageArea" >
    <br />
      <span id="ErrorMessageText" class="error_msg">
			
      </span>
    <br /><br />  
  </div>
  
  <!-- Main Content Start -->
  <div id="content_wrapper">
    <!--Left Nav Start -->
    <!--Left Nav End -->
    <!-- Right Nav Start -->
    <!-- Right Nav End -->
    
    <!-- Content Start -->
    <div id="box">
      <c:import url="${jspStoreDir}Snippets/StoreLocator/StoreLocator.jsp">
        <c:param name="storeId" value="${WCParam.storeId}"/>
        <c:param name="catalogId" value="${WCParam.catalogId}"/>
        <c:param name="langId" value="${langId}"/>
      </c:import>
    </div>
    <!-- Content End -->
  </div>
   
  <!-- Footer Start -->
  <%@ include file="../include/LayoutContainerBottom.jspf"%>  
  <!-- Footer End -->
   
</div>
<div id="page_shadow" class="shadow"></div>
	<flow:ifEnabled feature="Analytics">
		<cm:pageview/>
	</flow:ifEnabled>
</body>
</html>

