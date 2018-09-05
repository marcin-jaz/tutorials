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
  * This JSP displays the store's privacy policy. It shows the following information:
  *  - How personal information is maintained
  *  - How cookies are used by the store
  *  - Important notices
  *****
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ taglib uri="http://commerce.ibm.com/coremetrics"  prefix="cm" %>
<%@ include file="../include/JSTLEnvironmentSetup.jspf" %>
<%@ include file="../include/nocache.jspf" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="${shortLocale}" xml:lang="${shortLocale}">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><fmt:message key="PRIVACY_TITLE" bundle="${storeText}" /></title>
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
	<c:choose>
		<c:when test="${param.fromPage == 'registration'}">
			<br />
		</c:when>
		<c:otherwise>
			<%@ include file="../include/LayoutContainerTop.jspf"%>
		</c:otherwise>
	</c:choose>
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
			<div class="help_privacy" id="WC_PrivacyDisplay_div_1">
				<div class="title" id="WC_PrivacyDisplay_div_2">
					<h1 class="static_pages_header"><fmt:message key="PRIVACY_POLICY" bundle="${storeText}" /></h1>
				</div>
				<div class="contentgrad_header" id="WC_PrivacyDisplay_div_3">
					<div class="left_corner" id="WC_PrivacyDisplay_div_4"></div>
					<div class="left" id="WC_PrivacyDisplay_div_5"><span class="header"><fmt:message key="PRIVACY_AREA1" bundle="${storeText}" /></span></div>
					<div class="right_corner" id="WC_PrivacyDisplay_div_6"></div>
				</div>
				<div class="content" id="WC_PrivacyDisplay_div_7">
					<div class="static_pages_line" id="WC_PrivacyDisplay_div_8"></div>
					<div class="info" id="WC_PrivacyDisplay_div_9">

						<%out.flush();%>
						<c:import url="${jspStoreDir}Snippets/Marketing/Content/ContentSpotDisplay.jsp">
							<c:param name="spotName" value="PrivacyPolicy_part1" />
							<c:param name="substitutionValues" value="{storeName},${storeName}" />
						</c:import>
						<%out.flush();%>
						
						<%out.flush();%>
						<c:import url="${jspStoreDir}Snippets/Marketing/Content/ContentSpotDisplay.jsp">
							<c:param name="spotName" value="PrivacyPolicy_part2" />
							<c:param name="substitutionValues" value="{storeName},${storeName}" />
						</c:import>
						<%out.flush();%>
					</div>
				</div>
				<div class="footer" id="WC_PrivacyDisplay_div_10">
					<div class="left_corner" id="WC_PrivacyDisplay_div_11"></div>
					<div class="left" id="WC_PrivacyDisplay_div_12"></div>
					<div class="right_corner" id="WC_PrivacyDisplay_div_13"></div>
				</div>
				<p class="space">
				<div class="contentgrad_header" id="WC_PrivacyDisplay_div_14">
					<div class="left_corner" id="WC_PrivacyDisplay_div_15"></div>
					<div class="left" id="WC_PrivacyDisplay_div_16"><span class="header"><fmt:message key="PRIVACY_AREA2" bundle="${storeText}" /></span></div>
					<div class="right_corner" id="WC_PrivacyDisplay_div_17"></div>
				</div>
				<div class="content" id="WC_PrivacyDisplay_div_18">
					<div class="static_pages_line" id="WC_PrivacyDisplay_div_19"></div>
					<div class="info" id="WC_PrivacyDisplay_div_20">
						<%out.flush();%>
						<c:import url="${jspStoreDir}Snippets/Marketing/Content/ContentSpotDisplay.jsp">
							<c:param name="spotName" value="PrivacyPolicy_part3" />
							<c:param name="substitutionValues" value="{storeName},${storeName}" />
						</c:import>
						<%out.flush();%>
					</div>
				</div>
				<div class="footer" id="WC_PrivacyDisplay_div_21">
					<div class="left_corner" id="WC_PrivacyDisplay_div_22"></div>
					<div class="left" id="WC_PrivacyDisplay_div_23"></div>
					<div class="right_corner" id="WC_PrivacyDisplay_div_24"></div>
				</div>
				<p class="space">
				<c:if test="${showChildrenPrivacyPolicy}">
					<div class="contentgrad_header" id="WC_PrivacyDisplay_div_25">
						<div class="left_corner" id="WC_PrivacyDisplay_div_26"></div>
						<div class="left" id="WC_PrivacyDisplay_div_27"><span class="header"><fmt:message key="PRIVACY_AREA3" bundle="${storeText}" /></span></div>
						<div class="right_corner" id="WC_PrivacyDisplay_div_28"></div>
					</div>
					<div class="content" id="WC_PrivacyDisplay_div_29">
						<div class="static_pages_line" id="WC_PrivacyDisplay_div_30"></div>
						<div class="info" id="WC_PrivacyDisplay_div_31">
							<%out.flush();%>
							<c:import url="${jspStoreDir}Snippets/Marketing/Content/ContentSpotDisplay.jsp">
								<c:param name="spotName" value="PrivacyPolicy_part4" />
								<c:param name="substitutionValues" value="{storeName},${storeName}" />
							</c:import>		
							<%out.flush();%>			
						</div>
					</div>
					<div class="footer" id="WC_PrivacyDisplay_div_32">
						<div class="left_corner" id="WC_PrivacyDisplay_div_33"></div>
						<div class="left" id="WC_PrivacyDisplay_div_34"></div>
						<div class="right_corner" id="WC_PrivacyDisplay_div_35"></div>
					</div>
				</c:if>
				<div class="title" id="WC_PrivacyDisplay_div_37">
				<%out.flush();%>
				<c:import url="${jspStoreDir}Snippets/Marketing/Content/ContentSpotDisplay.jsp">
					<c:param name="spotName" value="PrivacyPolicy_part5" />
					<c:param name="substitutionValues" value="{storeName},${storeName}" />
				</c:import>	
				<%out.flush();%>		 
			</div>
			</div><br />
		</div>
		<!-- Content End -->

	</div>
	<!-- Main Content End -->
	
	<!-- Footer Start -->
	<c:choose>
		<c:when test="${param.fromPage == 'registration'}">
			<br />			
		</c:when>
		<c:otherwise>
			<%@ include file="../include/LayoutContainerBottom.jspf"%>  
		</c:otherwise>
	</c:choose>
	<!-- Footer End -->
	
</div>
<div id="page_shadow" class="shadow"></div>
<flow:ifEnabled feature="Analytics"><cm:pageview/></flow:ifEnabled>
</body>
</html>

