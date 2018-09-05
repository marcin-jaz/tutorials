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
  * This JSP snippet will display the header section of the mobile store front which contains the
  * store logo and the 'Sign In'/'Sign Out' hyper links
  *****
--%>

<!-- BEGIN CachedHeaderDisplay.jsp -->

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ taglib uri="flow.tld" prefix="flow" %>

<%@ include file="../../../../include/parameters.jspf" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf" %>

<wcf:url var="MobileIndexURL" value="mIndex">
  <wcf:param name="langId" value="${langId}" />
  <wcf:param name="storeId" value="${WCParam.storeId}" />
  <wcf:param name="catalogId" value="${WCParam.catalogId}" />
</wcf:url>

<div id="header">
	<a href="${fn:escapeXml(MobileIndexURL)}">
		<c:choose>
			<c:when test="${CommandContext.locale eq 'iw_IL'}">
				<img src="<c:out value="${jspStoreImgDir}${ColorDir}/bidi/logo.gif" />" alt="<fmt:message key="STORENAME" bundle="${storeText}" />" width="184" height="32" />
			</c:when>
			<c:otherwise>
				<img src="<c:out value="${jspStoreImgDir}${ColorDir}/logo.gif" />" alt="<fmt:message key="STORENAME" bundle="${storeText}" />" width="184" height="32" />
			</c:otherwise>
		</c:choose>
	</a>
	<p>
		<c:choose>
			<c:when test="${userType eq 'G'}">	
				<wcf:url var="logOnURL" value="MobileLogonForm">
					<wcf:param name="catalogId" value="${WCParam.catalogId}" />
					<wcf:param name="storeId" value="${WCParam.storeId}" />
					<wcf:param name="langId" value="${WCParam.langId}" />
				</wcf:url>			
				<a href="${fn:escapeXml(logOnURL)}" title="<fmt:message key="SIGN_IN" bundle="${storeText}" />"><fmt:message key="SIGN_IN" bundle="${storeText}" /></a>
			</c:when>
			<c:otherwise>
				<wcf:url var="logOffURL" value="Logoff">
					<wcf:param name="catalogId" value="${WCParam.catalogId}" />
					<wcf:param name="storeId" value="${WCParam.storeId}" />
					<wcf:param name="langId" value="${WCParam.langId}" />
					<wcf:param name="URL" value="mIndex" />
				</wcf:url>			
				<a href="${fn:escapeXml(logOffURL)}" title="<fmt:message key="SIGN_OUT" bundle="${storeText}" />"><fmt:message key="SIGN_OUT" bundle="${storeText}" /></a>
			</c:otherwise>
		</c:choose>
	</p> 
	<div class="clear_float"></div> 	
</div>

<!-- END CachedHeaderDisplay.jsp -->
