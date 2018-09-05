<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2009 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>
<%--
  *****
  * This JSP displays the store locator page.
  *****
--%>

<!-- BEGIN StoreLocator.jsp -->

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>

<%@ include file="../../include/parameters.jspf" %>
<%@ include file="../include/JSTLEnvironmentSetup.jspf" %>

<c:set var="storeLocatorPageGroup" value="true" />
<c:set var="storeLocatorPage" value="true" />

<c:if test="${!empty WCParam.fromPage}">
	<c:set var="fromPage" value="${WCParam.fromPage}" />
</c:if>


<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.2//EN" "http://www.openmobilealliance.org/tech/DTD/xhtml-mobile12.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" lang="${shortLocale}" xml:lang="${shortLocale}">

	<head>

		<title>
			<fmt:message key="MSTLOC_TITLE" bundle="${storeText}">
				<fmt:param value="${storeName}" />
			</fmt:message>
		</title>
		
		<meta http-equiv="content-type" content="application/xhtml+xml" />
		<meta http-equiv="cache-control" content="max-age=300" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no" />
	
		<link rel="stylesheet" href="${cssPath}" type="text/css" />

	</head>
	
	<body>
		
		<div id="wrapper">

			<%@ include file="../include/HeaderDisplay.jspf" %>

			<fmt:message var="finalBreadcrumb" key="MSTORE_LOCATOR" bundle="${storeText}" />
			<%@ include file="../include/BreadCrumbTrailDisplay.jspf" %>	
			
			<div id="store_locator" class="content_box">
				<div class="heading_container_with_underline">
					<h2><fmt:message key="MSTORE_LOCATOR" bundle="${storeText}" /></h2>
					<div class="clear_float"></div>
				</div>

				<c:if test="${!empty WCParam.errorMsgKey}">
					<p class="error"><fmt:message key="${WCParam.errorMsgKey}" bundle="${storeText}" /></p>
				</c:if>				

				<%@ include file="../Snippets/StoreLocator/GPSSupport.jspf" %>

				<form id="store_locator_form" method="post" action="mStoreLocatorSearchView">
					<input type="hidden" id="storeId" name="storeId" value="${WCParam.storeId}" />
					<input type="hidden" id="langId" name="langId" value="${WCParam.langId}" />
					<input type="hidden" id="catalogId" name="catalogId" value="${WCParam.catalogId}" />
					<input type="hidden" id="productId" name="productId" value="${WCParam.productId}" />

					<c:if test="${!empty WCParam.pgGrp}">
						<input type="hidden" id="pgGrp" name="pgGrp" value="${WCParam.pgGrp}" />
						<c:choose>
							<c:when test="${WCParam.pgGrp == 'catNav'}">
								<input type="hidden" id="categoryId" name="categoryId" value="${WCParam.categoryId}" />
								<input type="hidden" id="parent_category_rn" name="parent_category_rn" value="${WCParam.parent_category_rn}" />
								<input type="hidden" id="top_category" name="top_category" value="${WCParam.top_category}" />
								<input type="hidden" id="sequence" name="sequence" value="${WCParam.sequence}" />
							</c:when>
							<c:when test="${WCParam.pgGrp == 'search'}">
								<input type="hidden" id="resultCatEntryType" name="resultCatEntryType" value="${WCParam.resultCatEntryType}" />
								<input type="hidden" id="pageSize" name="pageSize" value="${WCParam.pageSize}" />
								<input type="hidden" id="searchTerm" name="searchTerm" value="${WCParam.searchTerm}" />
								<input type="hidden" id="sType" name="sType" value="${WCParam.sType}" />
								<input type="hidden" id="beginIndex" name="beginIndex" value="${WCParam.beginIndex}" />
							</c:when>
						</c:choose>
					</c:if>																

					<input type="hidden" id="fromPage" name="fromPage" value="${fromPage}" />
					<input type="hidden" id="errorMsgKey" name="errorMsgKey" value="" />

					<label for="zip_or_city"><div><fmt:message key="MSTLOC_ENTER_ZIP_CITY" bundle="${storeText}" /></div></label>
					<div><input type="text" id="zip_or_city" name="zipOrCity" class="coloured_input" value="${zipOrCitySavedInput}" /></div>

					<c:choose>
						<c:when test="${fromPage == 'ShoppingCart'}">
							<input type="submit" id="locate_store" name="locate_store" class="input_button" onclick="javascript:checkField(this.form);" value="<fmt:message key='MSTLOC_CONT_CHECKOUT' bundle='${storeText}' />" />
						</c:when>
						<c:otherwise>
							<input type="submit" id="locate_store" name="locate_store" class="input_button" onclick="javascript:checkField(this.form);" value="<fmt:message key='MSTLOC_GO' bundle='${storeText}' />" />
						</c:otherwise>
					</c:choose>					
				</form>
			</div>

			<%@ include file="../include/FooterDisplay.jspf" %>						
			
		</div>
		
	<script type="text/javascript">
	//<![CDATA[

		function checkField(form) {
			if (form.zipOrCity.value == null || form.zipOrCity.value.length == 0) {
				form.errorMsgKey.value = "MSTLOC_ERR_EMPTY_ZIPCITY";
				form.action = "mStoreLocatorView";
			}
			form.submit();
		}

	//]]> 
	</script>
		
	</body>
	
</html>

<!-- END StoreLocator.jsp -->
