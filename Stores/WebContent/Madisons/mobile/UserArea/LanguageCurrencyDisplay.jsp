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
  * This JSP displays the users account page. 
  *****
--%>

<!-- BEGIN LanguageCurrencyDisplay.jsp -->

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>

<%@ include file="../../include/parameters.jspf" %>
<%@ include file="../include/JSTLEnvironmentSetup.jspf" %>

<wcf:getData type="com.ibm.commerce.infrastructure.facade.datatypes.ConfigurationType[]"
	var="currentStoreConfigs"
	expressionBuilder="findAll">
	<wcf:contextData name="storeId" data="${storeId}"/>
</wcf:getData>


<c:set var="languageCurrencyDisplayPage" value="true" scope="request" />
<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.2//EN" "http://www.openmobilealliance.org/tech/DTD/xhtml-mobile12.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" lang="${shortLocale}" xml:lang="${shortLocale}">
	<head>
		<title><fmt:message key="LANG_CURR_TITLE" bundle="${storeText}"/> - <c:out value="${storeName}"/></title>
		<meta name="description" content="<c:out value="${category.description.longDescription}"/>"/>
		<meta name="keyword" content="<c:out value="${category.description.keyWord}"/>"/>
		<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no" />
		<link rel="stylesheet" href="${cssPath}" type="text/css"/>
	</head>
	<body>
		<div id="wrapper">	

			<%@ include file="../include/HeaderDisplay.jspf" %>
			<%@ include file="../include/BreadCrumbTrailDisplay.jspf"%>

			<div id="language_and_currency_selector" class="content_box">
				<div class="heading_container_with_underline">
					<h2><fmt:message key="LANG_CURR_TITLE" bundle="${storeText}"/></h2>
					<div class="clear_float"></div>
				</div>
				
				<p class="paragraph_blurb"><fmt:message key="LANG_CURR_DESCRIPTION" bundle="${storeText}"/></p>
				<br />
					<%-- 
					  ***
					  *  Start: Language selection box
					  *  This form allows shopper to switch language.
					  *  Only display form if there is more than 1 language
					  ***
					--%>
					<c:forEach var="config" items="${currentStoreConfigs}">
						<c:if test="${config.configurationIdentifier.uniqueID == 'com.ibm.commerce.foundation.supportedLanguages'}">
							<c:set var="supportedLanguages" value="${config.configurationAttribute}"/>
						</c:if>
						<c:if test="${config.configurationIdentifier.uniqueID == 'com.ibm.commerce.foundation.defaultLanguage'}">
							<c:forEach var="additionalValue" items="${config.configurationAttribute[0].additionalValue}">
								<c:if test="${additionalValue.name == 'languageId'}">
									<c:set var="storeDefaultLangId" value="${additionalValue.value}"/>
								</c:if>
							</c:forEach>
						</c:if>
					</c:forEach>
					<c:forTokens items="${requestScope.requestURIPath}" delims="/" var="URLtoken">
						<c:set var="ReloadURL" value="${URLtoken}"/>
					</c:forTokens>
					<wcf:url var="LanguageChangeURL" value="${ReloadURL}">
						<wcf:param name="storeId" value="${WCParam.storeId}" />
						<wcf:param name="catalogId" value="${WCParam.catalogId}" />
						<%-- Get all request parameters and their values --%>
						<c:forEach var="aParam" items="${WCParamValues}" varStatus="paramStatus">
							<c:forEach var="aValue" items="${aParam.value}"  varStatus="paramNumStatus">
								<c:if test="${aParam.key !='langId' && aParam.key !='logonPassword' && aParam.key !='URL' && aParam.key !='currency'}">
									<wcf:param name="${aParam.key}" value="${aValue}"/>
								</c:if>
							</c:forEach>
						</c:forEach>
					</wcf:url>
					<div><label for="languageSelection"><fmt:message key="LANG_CURR_LANGUAGE" bundle="${storeText}"/></label></div>
						<c:choose>
							<c:when test="${!empty supportedLanguages[1]}">
								<form action="<c:out value='${LanguageChangeURL}'/>" method="post" id="LanguageSelectionForm">
									<select class="drop_down_language_select" id="languageSelection" name="langId" onchange="form.submit()">
										<c:forEach var="supportedLanguage" items="${supportedLanguages}">
											<c:forEach var="additionalValue" items="${supportedLanguage.additionalValue}">
												<c:if test="${additionalValue.name == 'languageId'}">
													<c:set var="currentLanguageId" value="${additionalValue.value}"/>
												</c:if>
											</c:forEach>
											<c:forEach var="dbLanguage" items="${sdb.languageDataBeans}">
												<c:if test="${currentLanguageId == dbLanguage.languageId}">
													<c:set var="currentLanguageString" value="${dbLanguage.nativeDescriptionString}"/>
												</c:if>
											</c:forEach>
											<c:choose>
												<c:when test="${currentLanguageId == CommandContext.languageId}">
													<option value='<c:out value="${currentLanguageId}" escapeXml="false"/>' selected="selected"><c:out value="${currentLanguageString}" escapeXml="false"/></option>
												</c:when>
												<c:otherwise>
													<option value='<c:out value="${currentLanguageId}" escapeXml="false"/>'><c:out value="${currentLanguageString}" escapeXml="false"/></option>
												</c:otherwise>
											</c:choose>
										</c:forEach>
									</select>
								</form>
							</c:when>
							<c:otherwise>
								<c:set var="lang" value="${WCParam.langId}"/>
								<wcbase:useBean id="defaultLangId" classname="com.ibm.commerce.common.beans.LanguageDataBean">
									<c:set target="${defaultLangId}" property="dataBeanKeyLanguageId" value="${lang}" />
								</wcbase:useBean>
								<label for="language"><fmt:message key="LANG_CURR_DEFAULT_LANG" bundle="${storeText}"/>: <c:out value="${defaultLangId.descriptionString}" escapeXml="false"/></label>
								<br clear="all"/>
							</c:otherwise>
						</c:choose>
						<%-- 
					  ***
					  *  End: Language selection box
					  ***
					--%>
					<br clear="all"/>
					<%-- 
					  ***
					  *  Start: Currency selection box
					  *  This form allows shopper to switch currency.
					  *  Only display form if there is more than 1 currency
					  ***
					--%>
					<c:forEach var="config" items="${currentStoreConfigs}">
						<c:if test="${config.configurationIdentifier.uniqueID == 'com.ibm.commerce.foundation.supportedCurrencies'}">
							<c:set var="supportedCurrencies" value="${config.configurationAttribute}"/>
						</c:if>
						<c:if test="${config.configurationIdentifier.uniqueID == 'com.ibm.commerce.foundation.defaultCurrency'}">
							<c:forEach var="additionalValue" items="${config.configurationAttribute[0].additionalValue}">
								<c:if test="${additionalValue.name == 'currencyCode'}">
									<c:set var="storeDefaultCurrency" value="${additionalValue.value}"/>
								</c:if>
							</c:forEach>
						</c:if>
					</c:forEach>
					<div><label for="currencySelection"><fmt:message key="LANG_CURR_CURRENCY" bundle="${storeText}"/></label></div>
					<div>
						<form action="SetCurrencyPreference" method="post" id="SetCurrencyPreferenceForm">
							<input type="hidden" name="storeId" value="<c:out value="${WCParam.storeId}" />" id="storeId"/>
							<input type="hidden" name="catalogId" value="<c:out value="${WCParam.catalogId}"  />" id="catalogId"/>
						<%-- Get all request parameters and their values --%>
						<%-- Flush the buffer so this fragment JSP is not cached twice --%>
						<%out.flush();%>
							<c:import url="${jspStoreDir}mobile/include/WCParamValuesDisplay.jsp"/>
						<%out.flush();%>
						<select class="drop_down_language_select" id="currencySelection" name="currency" onchange="form.submit()">
							<c:forEach var="supportedCurrency" items="${supportedCurrencies}">
								<c:forEach var="additionalValue" items="${supportedCurrency.additionalValue}">
									<c:if test="${additionalValue.name == 'currencyCode'}">
										<c:set var="currentCurrencyCode" value="${additionalValue.value}"/>
									</c:if>
								</c:forEach>
								<c:choose>
									<c:when test="${currentCurrencyCode == CommandContext.currency}">
										<option value='<c:out value="${currentCurrencyCode}" escapeXml="false"/>' selected="selected"><c:out value="${supportedCurrency.primaryValue.value}" escapeXml="false"/></option>
									</c:when>
									<c:otherwise>
										<option value='<c:out value="${currentCurrencyCode}" escapeXml="false"/>'><c:out value="${supportedCurrency.primaryValue.value}"  escapeXml="false"/></option>
									</c:otherwise>
								</c:choose>
							</c:forEach>
						</select>
						</form>
					</div>
					<%-- 
					  ***
					  *  End: Currency selection box
					  ***
					--%>

					<form id="store_result_button" method="post" action="mIndex">
						<input type="hidden" name="storeId" value="<c:out value="${WCParam.storeId}" />" id="storeId_1"/>
						<input type="hidden" name="catalogId" value="<c:out value="${WCParam.catalogId}"  />" id="catalogId_1"/>
						<input id="continue_shopping" class="input_button_float" type="submit" name="continue_shopping" value="Continue Shopping"/>
					</form>
					
					
				
			</div>

			
			<%@ include file="../include/FooterDisplay.jspf" %>						
		</div>
	</body>
</html>
