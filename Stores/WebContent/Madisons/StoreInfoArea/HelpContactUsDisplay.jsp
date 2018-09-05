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
  * This JSP displays help tips to the customer. It shows the following information:
  *  - How to complete an order
  *  - How to make payment for an order
  *  - Credit card security policy
  *  - How to track an order
  *
  * This JSP also displays the store's contact information. It shows the following:
  *  - Store name
  *  - Full address
  *****
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ taglib uri="http://commerce.ibm.com/coremetrics"  prefix="cm" %>
<%@ include file="../include/JSTLEnvironmentSetup.jspf" %>
<%@ include file="../include/nocache.jspf" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="${shortLocale}" xml:lang="${shortLocale}">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><fmt:message key="HELP_CONTACT_TITLE" bundle="${storeText}" /></title>
<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${vfileStylesheet}"/>" type="text/css"/>
<!--[if lte IE 6]>
<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${vfileStylesheetie}"/>" type="text/css"/>
<![endif]-->
<script type="text/javascript" src="<c:out value="${dojoFile}"/>" djConfig="${dojoConfigParams}"></script>
<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/MessageHelper.js"/>"></script>
<%@ include file="../include/CommonJSToInclude.jspf"%>
</head>
<body>
<%@ include file="../include/StoreCommonUtilities.jspf"%>
<!-- Page Start -->
<div id="page">
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
   <div id="content_wrapper_border">
      <!-- Content Start -->
      <div id="box">
         <!-- Help section -->
         <div class="help_privacy" id="WC_HelpContactUsDisplay_div_1">
            <div class="title" id="WC_HelpContactUsDisplay_div_2">
               <h1 class="static_pages_header"><fmt:message key="HELP_CONTACT_TITLE" bundle="${storeText}" /></h1>
            </div>
            <div class="contentgrad_header" id="WC_HelpContactUsDisplay_div_3">
               <div class="left_corner" id="WC_HelpContactUsDisplay_div_4"></div>
               <div class="left" id="WC_HelpContactUsDisplay_div_5"><span class="header"><fmt:message key="HELP3" bundle="${storeText}" /></span></div>
               <div class="right_corner" id="WC_HelpContactUsDisplay_div_6"></div>
            </div>
            <div class="content" id="WC_HelpContactUsDisplay_div_7">
               <div class="static_pages_line" id="WC_HelpContactUsDisplay_div_8"></div>
               <div class="info" id="WC_HelpContactUsDisplay_div_9">
                  <%out.flush();%>
                  <c:import url="${jspStoreDir}/Snippets/Marketing/Content/ContentSpotDisplay.jsp">
                     <c:param name="spotName" value="HelpSpot_part1" />
                     <c:param name="substitutionValues" value="{storeName},${storeName}" />
                  </c:import>
                  <%out.flush();%>
                  <%out.flush();%>
                  <c:import url="${jspStoreDir}/Snippets/Marketing/Content/ContentSpotDisplay.jsp">
                     <c:param name="spotName" value="HelpSpot_part2" />
                     <c:param name="substitutionValues" value="{storeName},${storeName}" />
                  </c:import>
                  <%out.flush();%>
               </div>
            </div>
            
            <div class="footer" id="WC_HelpContactUsDisplay_div_10">
               <div class="left_corner" id="WC_HelpContactUsDisplay_div_11"></div>
               <div class="left" id="WC_HelpContactUsDisplay_div_12"></div>
               <div class="right_corner" id="WC_HelpContactUsDisplay_div_13"></div>
            </div>
            <p class="space" />
            
            <!-- Contact Us section -->
            <div class="contentgrad_header" id="WC_HelpContactUsDisplay_div_14">
               <div class="left_corner" id="WC_HelpContactUsDisplay_div_15"></div>
               <div class="left" id="WC_HelpContactUsDisplay_div_16"><span class="header"><fmt:message key="CONTACT_US3" bundle="${storeText}" /></span></div>
               <div class="right_corner" id="WC_HelpContactUsDisplay_div_17"></div>
            </div>
            <div class="content" id="WC_HelpContactUsDisplay_div_18">
               <div class="static_pages_line" id="WC_HelpContactUsDisplay_div_19"></div>
               <div class="info" id="WC_HelpContactUsDisplay_div_20">
									<span  class="contact_img"><img src="<c:out value="${jspStoreImgDir}/images/advertisements/${locale}/img_help_contact_us.png"/>" alt="<fmt:message key="CONTACT_US3" bundle="${storeText}" />"/></span>
									   <p><fmt:message key="CONTACT_MSG1" bundle="${storeText}" /></p>
									   <br />
									   <p><fmt:message key="CONTACT_MSG2" bundle="${storeText}" /></p>
									   <br />
									   <div class="address" id="WC_HelpContactUsDisplay_div_21">
                        <wcf:getData type="com.ibm.commerce.infrastructure.facade.datatypes.OnlineStoreType" var="onlineStore" expressionBuilder="findByUniqueID">
                           <wcf:param name="storeId" value="${param.storeId}" />
                        </wcf:getData>
                        <c:set var="contact" value="${onlineStore.onlineStoreContactInfo[0]}" />
                        <%@ include file="../Snippets/ReusableObjects/AddressDisplay.jspf"%>
                     </div>
                     <br /><br />
               </div>
            </div>
            <div class="footer" id="WC_HelpContactUsDisplay_div_22">
               <div class="left_corner" id="WC_HelpContactUsDisplay_div_23"></div>
               <div class="left" id="WC_HelpContactUsDisplay_div_24"></div>
               <div class="right_corner" id="WC_HelpContactUsDisplay_div_25"></div>
            </div>
            <p class="space" />
            
         </div>
         <br />
      </div>
      <!-- Content End -->
   </div>
   <!-- Main Content End -->

   <!-- Footer Start -->
   <%@ include file="../include/LayoutContainerBottom.jspf"%>  
   <!-- Footer End -->
</div>
<div id="page_shadow" class="shadow"></div>
<flow:ifEnabled feature="Analytics"><cm:pageview/></flow:ifEnabled>
</body>
</html>
