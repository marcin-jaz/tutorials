<% 
/*
 *-------------------------------------------------------------------
 * Licensed Materials - Property of IBM
 *
 * WebSphere Commerce
 *
 * (c) Copyright International Business Machines Corporation. 2000, 2004
 *     All rights reserved.
 *
 * US Government Users Restricted Rights - Use, duplication or
 * disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
 *
 *-------------------------------------------------------------------
 */
%>
<%--
  *****
  * This JSP page displays links used by the RFQ response page.
  *
  * Required parameters:
  * - rfqId
  * - resId
  * - catalogId
  * - langId
  * - storeId
  *
  *****
--%>

<%@ page language="java" %>

<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../include/JSTLEnvironmentSetup.jspf" %>

<%@ include file="RFQResponseConstants.jspf" %>

<c:set var="rfqId" value="${param.rfqId}" />
<c:set var="resId" value="${param.resId}" />
<c:set var="langId" value="${param.langId}" />
<c:set var="storeId" value="${param.storeId}" />
<c:set var="catalogId" value="${param.catalogId}" />
 
<c:url var="RFQResponseProductDisplayHref" value="RFQResponseProductDisplay" scope="request">
	<c:param name="${EC_OFFERING_ID}" value="${rfqId}" />
	<c:param name="${EC_RFQ_RESPONSE_ID}" value="${resId}" />
	<c:param name="langId" value="${langId}" />
	<c:param name="storeId" value="${storeId}" />
	<c:param name="catalogId" value="${catalogId}" />
</c:url>

<c:url var="RFQDisplayHref" value="RFQDisplay" scope="request">
	<c:param name="${EC_OFFERING_ID}" value="${rfqId}" />
	<c:param name="langId" value="${langId}" />
	<c:param name="storeId" value="${storeId}" />
	<c:param name="catalogId" value="${catalogId}" />
</c:url>     

