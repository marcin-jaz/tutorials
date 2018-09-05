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
  * This JSP displays the checkout login page for the mobile store front.
  *****
--%>

<!-- BEGIN CheckoutLogon.jsp -->

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>

<%@ include file="../../../../include/parameters.jspf" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf" %>
<%@ include file="../../../include/ErrorMessageSetup.jspf" %>

<%-- Required variables for breadcrumb support --%>
<c:set var="shoppingcartPageGroup" value="true" scope="request"/>
<c:set var="checkoutLogonPage" value="true" scope="request"/>

<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.2//EN" "http://www.openmobilealliance.org/tech/DTD/xhtml-mobile12.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" lang="${shortLocale}" xml:lang="${shortLocale}">
	<head>
		<title>
			<fmt:message key="SIGN_IN_FOR_CHECKOUT" bundle="${storeText}"/> - <c:out value="${storeName}"/>
		</title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no" />
		<link rel="stylesheet" href="${cssPath}" type="text/css"/>
	</head>
	<body>
		<div id="wrapper">
			<%@ include file="../../../include/HeaderDisplay.jspf" %>
			<%@ include file="../../../include/BreadCrumbTrailDisplay.jspf" %>

			<c:choose>
				<c:when test="${userType eq 'G'}">				
					<wcf:url var="nextURL" value="mSelectedStoreListView">
						<wcf:param name="langId" value="${langId}" />
						<wcf:param name="storeId" value="${WCParam.storeId}" />
						<wcf:param name="catalogId" value="${WCParam.catalogId}" />
						<wcf:param name="fromPage" value="ShoppingCart" />
					</wcf:url>

					<div id="sign_in" class="content_box">
						<div class="heading_container_with_underline">
							<h2><fmt:message key="RETURNING_CUSTOMERS" bundle="${storeText}"/></h2>
							<div class="clear_float"></div>
						</div>

						<p><fmt:message key="SIGN_IN_FOR_CHECKOUT" bundle="${storeText}"/></p>

						<c:if test="${!empty errorMessage}">
							<p class="error"><c:out value="${errorMessage}"/></p>
						</c:if>

						<wcf:url var="mergedShoppingCart" value="mOrderItemDisplay">
							<wcf:param name="langId" value="${langId}" />
							<wcf:param name="storeId" value="${WCParam.storeId}" />
							<wcf:param name="catalogId" value="${WCParam.catalogId}" />
							<wcf:param name="merged" value="true" />
						</wcf:url>

						<wcf:url var="orderCalculate" value="OrderCalculate">
							<wcf:param name="calculationUsageId" value="-1"/>
							<wcf:param name="updatePrices" value="1"/>
							<wcf:param name="URL" value="${mergedShoppingCart}"/>
						</wcf:url>

						<wcf:url var="orderMove" value="OrderItemMove">
							<wcf:param name="fromOrderId" value="*"/>
							<wcf:param name="toOrderId" value="."/>
							<wcf:param name="deleteIfEmpty" value="*"/>
							<wcf:param name="continue" value="1"/>
							<wcf:param name="createIfEmpty" value="1"/>							
							<wcf:param name="URL" value="${orderCalculate}"/>
						</wcf:url>

						<form method="post" action="Logon" id="sign_in_form">
							<fieldset>
								<input type="hidden" name="storeId" value="<c:out value="${WCParam.storeId}"/>"/>
								<input type="hidden" name="catalogId" value="<c:out value="${WCParam.catalogId}"/>"/>
								<input type="hidden" name="reLogonURL" value="mCheckoutLogon"/>
								<input type="hidden" name="previousPage" value="mOrderItemDisplay"/>								
								<input type="hidden" name="URL" value="${orderMove}"/>

								<label for="login_id"><div><fmt:message key="LOGON_ID" bundle="${storeText}"/></div></label>
								<input type="text" id="login_id" name="logonId" class="coloured_input" />

								<label for="password"><div><fmt:message key="PASSWORD" bundle="${storeText}"/></div></label>
								<input type="password" id="password" name="logonPassword" class="coloured_input" />

								<div class="checkbox_container">
									<input type="checkbox" id="remember_me" name="rememberMe" value="true" />
									<label for="remember_me"><fmt:message key="SIGN_IN_REMEMBER_ME" bundle="${storeText}"/></label>
								</div>

								<wcf:url var="ForgotPasswdURL" value="mResetPassword">
									<wcf:param name="langId" value="${langId}" />
									<wcf:param name="storeId" value="${WCParam.storeId}" />
									<wcf:param name="catalogId" value="${WCParam.catalogId}" />
								</wcf:url>

								<p class="forgotten_password_link"><span class="bullet">&#187; </span>
									<a href="<c:out value="${ForgotPasswdURL}" />" title="<fmt:message key="SIGN_IN_FORGOT_YOUR_PASSWD" bundle="${storeText}"/>">
									<fmt:message key="SIGN_IN_FORGOT_YOUR_PASSWD" bundle="${storeText}"/></a>
								</p>

								<input type="submit" id="sign_in_button" name="sign_in_button" value="<fmt:message key="SIGN_IN_AND_CHECKOUT" bundle="${storeText}"/>" />
							</fieldset>
						</form>
					</div>
					
					<div class="content_box">

						<div class="heading_container_with_underline">
							<h2><fmt:message key="NEW_CUSTOMERS_AND_GUESTS" bundle="${storeText}"/></h2>
							<div class="clear_float"></div>
						</div>

						<form id="register_link" action="mStoreLocatorView">
							<fieldset>
								<p><fmt:message key="CHECKOUT_WITHOUT_SIGN_IN" bundle="${storeText}"/></p>
								<p><fmt:message key="GUEST_CHECKOUT_MESSAGE" bundle="${storeText}"/></p>
								<button type="button" onclick="window.location.href='${nextURL}'"><fmt:message key="CONTINUE_CHECKOUT" bundle="${storeText}"/></button>
							</fieldset>
						</form>
					</div>
				</c:when>
			</c:choose>

			<%@ include file="../../../include/FooterDisplay.jspf" %>
		</div>
	</body>
</html>

<!-- END CheckoutLogon.jsp -->
