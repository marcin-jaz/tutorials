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
  * This JSP is used if an error occurs when adding an item to the shopping cart
  *****
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ taglib uri="http://commerce.ibm.com/coremetrics"  prefix="cm" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf"%>
<%@ include file="../../../include/nocache.jspf"%>
<%@ include file="../../../include/ErrorMessageSetup.jspf" %>

<c:set var="productId" value="${WCParam.productId}" />
<c:set var="productPage" value="true" scope="request"/>
<c:set var="hasBreadCrumbTrail" value="true" scope="request"/>
<c:set var="useHomeRightSidebar" value="false" scope="request"/>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns:wairole="http://www.w3.org/2005/01/wai-rdf/GUIRoleTaxonomy#"
xmlns:waistate="http://www.w3.org/2005/07/aaa" lang="${shortLocale}" xml:lang="${shortLocale}">
<head>
	<title><fmt:message key="PRODUCT_TITLE" bundle="${storeText}"/></title>
	<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${vfileStylesheet}"/>"  type="text/css"/>
	<script type="text/javascript" src="<c:out value="${dojoFile}"/>" djConfig="${dojoConfigParams}"></script>
	<%@ include file="../../../include/CommonJSToInclude.jspf"%>
	<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/MessageHelper.js"/>"></script>
	<script type="text/javascript">
		dojo.addOnLoad(function() { 
			<fmt:message key="_ERR_CATENTRY_NOT_EXISTING_IN_STORE" bundle="${storeText}" var="_ERR_CATENTRY_NOT_EXISTING_IN_STORE"/>
			MessageHelper.setMessage("_ERR_CATENTRY_NOT_EXISTING_IN_STORE", <wcf:json object="${_ERR_CATENTRY_NOT_EXISTING_IN_STORE}"/>);
		});
	</script>
</head>

<body>

	<c:set var="nocart" value="true" scope="request"/>
	<%@ include file="../../../include/StoreCommonUtilities.jspf"%>
	
		<div id="page">
		<%@ include file="../../../include/LayoutContainerTop.jspf"%>
		
			<div id="content_wrapper_box">
		
				<c:choose>
					<c:when test="${error.messageKey eq '_ERR_CATENTRY_NOT_EXISTING_IN_STORE'}">                     
					
						<div id="ItemAddError_div_1">
							<br />
							<span tabindex="-1">
								<c:if test="${!empty errorMessage}">
									<span class="error_msg"><fmt:message key="_ERR_CATENTRY_NOT_EXISTING_IN_STORE" bundle="${storeText}"/></span>
								</c:if>	
							</span>
							<br /><br />
																				
							<span class="secondary_button">
								<span class="button_container">
									<span class="button_bg">
										<span class="button_top">
											<span class="button_bottom">   
												<a href="JavaScript:window.history.back();" id="ItemAddError_link_1"><fmt:message key="GOBACK" bundle="${storeText}"/></a>
											</span>
										</span>	
									</span>
								</span>
							</span>	
						</div>
					</c:when>
					
					<c:when test="${error.messageKey eq '_ERR_PROD_NOT_PUBLISHED'}">                     
					
						<div id="ItemAddError_div_4">
							<br />
							<span  tabindex="-1">
								<c:if test="${!empty errorMessage}">
									<span class="error_msg"><fmt:message key="STATUS_MESSAGE1" bundle="${storeText}"/></span>
								</c:if>	
							</span>
							<br /><br />
																				
							<span class="secondary_button">
								<span class="button_container">
									<span class="button_bg">
										<span class="button_top">
											<span class="button_bottom">   
												<a href="JavaScript:window.history.back();" id="ItemAddError_link_2"><fmt:message key="GOBACK" bundle="${storeText}"/></a>
											</span>
										</span>	
									</span>
								</span>	
							</span>	
						</div>
					</c:when>
					
					<c:when test="${storeError.key eq '_ERR_RETRIEVE_PRICE.1002'}">
						<wcbase:useBean id="catEntryDB" classname="com.ibm.commerce.catalog.beans.CatalogEntryDataBean" scope="request">
								<c:set property="catalogEntryID" value="${RequestProperties.catEntryId[0]}" target="${catEntryDB}" />
						</wcbase:useBean>
						<div id="ItemAddError_div_8">
							<br />
							<span  tabindex="-1">
								<c:if test="${!empty errorMessage}">
									<span class="error_msg">
										<fmt:message key="${storeError.key}" bundle="${storeErrorMessageBundle}" var="priceRetrieveErrorMessage">
											<fmt:param value="${catEntryDB.partNumber}"/>
											<fmt:param value="${RequestProperties.quantity[0]}"/>
										</fmt:message>
										<c:out value="${priceRetrieveErrorMessage}"/>
									</span>
								</c:if>	
							</span>
							<br /><br />
																				
							<span class="secondary_button">
								<span class="button_container">
									<span class="button_bg">
										<span class="button_top">
											<span class="button_bottom">   
												<a href="JavaScript:window.history.back();" id="ItemAddError_link_3"><fmt:message key="GOBACK" bundle="${storeText}"/></a>
											</span>
										</span>	
									</span>
								</span>	
							</span>	
						</div>
					</c:when>
					<c:otherwise>
				
						<div id="ItemAddError_div_7">
							<br />
							<span  class="error_msg" tabindex="-1">
								<c:if test="${!empty errorMessage}">
									<span class="error"><c:out value="${errorMessage}"/></span>
								</c:if>	
							</span>
							<br /><br />
						</div>
					
					</c:otherwise>	
				</c:choose>				
			</div>
			
			<%@ include file="../../../include/LayoutContainerBottom.jspf"%>
		</div>
	<div id="page_shadow" class="shadow"></div>	
<flow:ifEnabled feature="Analytics"><cm:pageview/></flow:ifEnabled>
</body>
</html>
