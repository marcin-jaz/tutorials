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
  * This JSP page displays links commonly used on RFQ response pages.
  *
  * Required parameters:
  * - rfq_offering_id
  * - resId
  *
  *****
--%>
<%@ page language="java" %>

<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="flow.tld" prefix="flow" %>

<%@ include file="../../include/JSTLEnvironmentSetup.jspf" %>


<c:set var="EC_OFFERING_ID" value="offering_id" scope="request" />
<c:set var="EC_RFQ_RESPONSE_ID" value="response_id" scope="request" />

<c:remove var="RFQResponseDisplay" scope="request" />	
<c:remove var="RFQAcceptResponse" scope="request" />
<c:remove var="RFQResponseAcceptSomeProductDisplay" scope="request" />
<c:remove var="RFQRejectResponse" scope="request" />
<c:remove var="RFQCompleteOrderDisplay" scope="request" />
<c:remove var="RFQCompleteContractDisplayHref" scope="request" />

			
<c:url var="RFQResponseDisplayHref" value="RFQResponseDisplay" scope="request">
	<c:param name="${EC_OFFERING_ID}" value="${param.rfq_offering_id}" />
	<c:param name="${EC_RFQ_RESPONSE_ID}" value="${param.resId}" />
	<c:param name="langId" value="${langId}" />
	<c:param name="storeId" value="${storeId}" />
	<c:param name="catalogId" value="${catalogId}" />
</c:url>

<c:url var="RFQAcceptResponseHref" value="RFQAcceptResponse" scope="request">
	<c:param name="${EC_OFFERING_ID}" value="${param.rfq_offering_id}" />
	<c:param name="${EC_RFQ_RESPONSE_ID}" value="${param.resId}" />
	<c:param name="URL" value="RFQResponseListDisplay" />
	<c:param name="langId" value="${langId}" />
	<c:param name="storeId" value="${storeId}" />
	<c:param name="catalogId" value="${catalogId}" />
</c:url>
<c:url var="RFQResponseAcceptSomeProductDisplayHref" value="RFQResponseAcceptSomeProductDisplay" scope="request">
	<c:param name="${EC_OFFERING_ID}" value="${param.rfq_offering_id}" />
	<c:param name="${EC_RFQ_RESPONSE_ID}" value="${param.resId}" />
	<c:param name="langId" value="${langId}" />
	<c:param name="storeId" value="${storeId}" />
	<c:param name="catalogId" value="${catalogId}" />
</c:url>
<c:url var="RFQRejectResponseHref" value="RFQRejectResponse" scope="request">
	<c:param name="${EC_OFFERING_ID}" value="${param.rfq_offering_id}" />
	<c:param name="${EC_RFQ_RESPONSE_ID}" value="${param.resId}" />
	<c:param name="URL" value="RFQResponseListDisplay" />
	<c:param name="langId" value="${langId}" />
	<c:param name="storeId" value="${storeId}" />
	<c:param name="catalogId" value="${catalogId}" />
</c:url>
<c:url var="RFQCompleteOrderDisplayHref" value="RFQCompleteOrderDisplay" scope="request">
	<c:param name="${EC_OFFERING_ID}" value="${param.rfq_offering_id}" />
	<c:param name="${EC_RFQ_RESPONSE_ID}" value="${param.resId}" />
	<c:param name="URL" value="RFQResponseListDisplay" />
	<c:param name="langId" value="${langId}" />
	<c:param name="storeId" value="${storeId}" />
	<c:param name="catalogId" value="${catalogId}" />
</c:url>
<c:url var="RFQCompleteContractDisplayHref" value="RFQCompleteContractDisplay" scope="request">
	<c:param name="${EC_OFFERING_ID}" value="${param.rfq_offering_id}" />
	<c:param name="${EC_RFQ_RESPONSE_ID}" value="${param.resId}" />
	<c:param name="URL" value="RFQResponseListDisplay" />
	<c:param name="langId" value="${langId}" />
	<c:param name="storeId" value="${storeId}" />
	<c:param name="catalogId" value="${catalogId}" />
</c:url>



