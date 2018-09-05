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
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../include/JSTLEnvironmentSetup.jspf" %>
<%@ include file="../../include/nocache.jspf" %>
<%@ include file="../../include/ErrorMessageSetup.jspf" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ taglib uri="http://commerce.ibm.com/coremetrics"  prefix="cm" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="${shortLocale}" xml:lang="${shortLocale}">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title><fmt:message key="REGISTER_LOGIN" bundle="${storeText}"/></title>
	<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${vfileStylesheet}"/>" type="text/css"/>
<!--[if lte IE 6]>
<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${vfileStylesheetie}"/>" type="text/css"/>
<![endif]-->
	<script type="text/javascript" src="<c:out value="${dojoFile}"/>" djConfig="${dojoConfigParams}"></script>
	<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/MessageHelper.js"/>"></script>
	<%@ include file="../../include/CommonJSToInclude.jspf"%>
</head>

<body>
<%@ include file="../../include/StoreCommonUtilities.jspf"%>
<div id="page">
     <!-- Header Nav Start -->
     
    <c:if test="${b2bStore eq 'true'}">
    	<c:if test="${userType =='G'}">
			<c:set var="hideHeader" value="true"/>
		</c:if>
	</c:if>
	
	
	<%@ include file="../../include/LayoutContainerTop.jspf"%>
    <div id="MessageArea" >
		<br />
		<span id="ErrorMessageText" class="error_msg">
			
		</span>
		<br /><br />  
	</div>
     <!-- Header Nav End -->
     <!-- Main Content Start -->
     <div id="content_wrapper_border">
          <!-- Content Start -->
          <div id="box">
               <div class="sign_in_registration" id="WC_AccountDisplay_div_1">
					<%@include file="AccountDisplayContent.jspf" %>
                    <br clear="all"/>
                    <div class="ad" id="WC_AccountDisplay_div_31">
						<%out.flush();%>
						<c:import url="${jspStoreDir}Snippets/Marketing/ESpot/ContentAreaESpot.jsp">
							<c:param name="emsName" value="SignInPageESpot" />
							<c:param name="numberContentPerRow" value="1" />
							<c:param name="catalogId" value="${WCParam.catalogId}" />
							<c:param name="errorViewName" value="AjaxOrderItemDisplayView" />
						</c:import>
						<%out.flush();%>
					</div>
                    <br />
               </div>
          </div>
          <!-- Content End -->
     </div>
     <!-- Main Content End -->
     <!-- Footer Start Start -->
	<%@ include file="../../include/LayoutContainerBottom.jspf"%>
     <!-- Footer Start End -->
</div>
<div id="page_shadow" class="shadow"></div>
<flow:ifEnabled feature="Analytics"><cm:pageview/></flow:ifEnabled>
</body>
</html>
