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
  * This JSP page holds common URL links used by other 
  * RFQ JSP pages.
  *
  * Parameters:
  * - rfq_offering_id - required
  * - langId - required
  * - storeId - required
  * - catalogId - required
  * - URL - optional  
  *****
--%>    

<%@ page language="java" %>

<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../include/JSTLEnvironmentSetup.jspf" %>
  			

		<c:set var="rfq_offering_id" value="${param.rfq_offering_id}" />
   		<c:set var="URL" value="${param.URL }" />
   		
		<c:url var="RFQDisplayHref" value="RFQDisplay" scope="request">
			<c:param name="offering_id" value="${rfq_offering_id}" />
			<c:param name="langId" value="${langId}" />
			<c:param name="storeId" value="${storeId}" />
			<c:param name="catalogId" value="${catalogId}" />
		</c:url>
		<c:url var="RFQDuplicateDisplayHref" value="RFQDuplicateDisplay" scope="request">
			<c:param name="offering_id" value="${rfq_offering_id}" />
			<c:param name="langId" value="${langId}" />
			<c:param name="storeId" value="${storeId}" />
			<c:param name="catalogId" value="${catalogId}" />
			<c:param name="URL" value="RFQListDisplay" />
		</c:url>
		<c:url var="RFQModifyDisplayHref" value="RFQModifyDisplay" scope="request">
			<c:param name="offering_id" value="${rfq_offering_id}" />
			<c:param name="langId" value="${langId}" />
			<c:param name="storeId" value="${storeId}" />
			<c:param name="catalogId" value="${catalogId}" />
		</c:url>
		<c:url var="RFQSubmitHref" value="RFQSubmit" scope="request">
			<c:param name="offering_id" value="${rfq_offering_id}" />
			<c:param name="langId" value="${langId}" />
			<c:param name="storeId" value="${storeId}" />
			<c:param name="catalogId" value="${catalogId}" />
			<c:param name="URL" value="RFQListDisplay" />
		</c:url>
		<c:url var="RFQCancelHref" value="RFQCancel" scope="request">
			<c:param name="offering_id" value="${rfq_offering_id}" />
			<c:param name="langId" value="${langId}" />
			<c:param name="storeId" value="${storeId}" />
			<c:param name="catalogId" value="${catalogId}" />
			<c:param name="URL" value="RFQListDisplay" />
		</c:url>
		<c:url var="RFQCloseHref" value="RFQClose" scope="request">
			<c:param name="offering_id" value="${rfq_offering_id}" />
			<c:param name="langId" value="${langId}" />
			<c:param name="storeId" value="${storeId}" />
			<c:param name="catalogId" value="${catalogId}" />
			<c:param name="URL" value="RFQListDisplay" />
		</c:url>
		<c:url var="RFQResponseListDisplayHref" value="RFQResponseListDisplay" scope="request">
			<c:param name="offering_id" value="${rfq_offering_id}" />
			<c:param name="langId" value="${langId}" />
			<c:param name="storeId" value="${storeId}" />
			<c:param name="catalogId" value="${catalogId}" />
		</c:url>
		<c:url var="RFQCompleteListResponseDisplayHref" value="RFQCompleteListResponseDisplay" scope="request">
			<c:param name="offering_id" value="${rfq_offering_id}" />
			<c:param name="langId" value="${langId}" />
			<c:param name="storeId" value="${storeId}" />
			<c:param name="catalogId" value="${catalogId}" />
		</c:url>
		<c:url var="RFQCreateForNextRoundDisplayHref" value="RFQCreateForNextRoundDisplay" scope="request">
			<c:param name="offering_id" value="${rfq_offering_id}" />
			<c:param name="langId" value="${langId}" />
			<c:param name="storeId" value="${storeId}" />
			<c:param name="catalogId" value="${catalogId}" />
		</c:url>
		<c:url var="RFQCategoryDisplayHref" value="RFQCategoryDisplay" scope="request">
			<c:param name="offering_id" value="${rfq_offering_id}" />
			<c:param name="langId" value="${langId}" />
			<c:param name="storeId" value="${storeId}" />
			<c:param name="catalogId" value="${catalogId}" />
		</c:url>
<%--end declare possible links--%>




