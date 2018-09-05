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
  * This JSP page displays Specification, Component List (if the product is
  * a dynamic kit), Comment and Remove links for each product displayed in
  * the Products section of the RFQModifyDisplay JSP page.
  *
  * Elements:  
  * - Specification link
  * - Comment link 
  * - Remove link
  * - Component List link (if dynamic kit)
  *
  * Required parameters:
  * - offering_id
  * - productId
  * - catalogId
  * - storeId
  * - langId
  *
  *****
--%>

<%@ page language="java" %>

<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../include/JSTLEnvironmentSetup.jspf" %>


<%@ include file="RFQModifyConstants.jspf" %>


<td headers="c13" nowrap="nowrap" class="t_td" id="WC_RFQModifyDisplay_TableCell_103_<c:out value="${param.index + 1}" />">

	<c:choose>
	<c:when test="${param.type eq param.isDynamicKit}">
		<a href="RFQDynamicKitComponentListDisplay?<c:out value="${EC_RFQ_PRODUCT_ID}" />=<c:out value="${param.rfqProdId}" />&<c:out value="${EC_OFFERING_ID}" />=<c:out value="${rfqId}" />&<c:out value="${EC_OFFERING_CATENTRYID}" />=<c:out value="${catid}" />&langId=<c:out value="${langId}" />&storeId=<c:out value="${storeId}" />&catalogId=<c:out value="${catalogId}" />" class="t_button" id="WC_RFQModifyDisplay_Link_14_<c:out value="${param.index + 1}" />"><fmt:message key="RFQModifyDisplay_ConfigReport" bundle="${storeText}" /></a><br />	
	</c:when> 
	<c:when test="${param.type eq param.isItem or param.type eq param.isPrebuiltKit}">
		<a href="RFQModifySpecificationDisplay?<c:out value="${EC_RFQ_PRODUCT_ID}" />=<c:out value="${param.rfqProdId}" />&<c:out value="${EC_OFFERING_ID}" />=<c:out value="${rfqId}" />&<c:out value="${EC_OFFERING_CATENTRYID}" />=<c:out value="${catid}" />&langId=<c:out value="${langId}" />&storeId=<c:out value="${storeId}" />&catalogId=<c:out value="${catalogId}" />" class="t_button" id="WC_RFQModifyDisplay_Link_14_<c:out value="${param.index + 1}" />"><fmt:message key="RFQModifyDisplay_ProdSpec" bundle="${storeText}" /></a><br />
	</c:when>
	<c:when test="${param.type eq param.isProduct}">
		
	</c:when>	
	<c:otherwise>
		<a href="RFQModifySpecificationDisplay?<c:out value="${EC_RFQ_PRODUCT_ID}" />=<c:out value="${param.rfqProdId}" />&<c:out value="${EC_OFFERING_ID}" />=<c:out value="${rfqId}" />&<c:out value="${EC_OFFERING_CATENTRYID}" />=<c:out value="${catid}" />&langId=<c:out value="${langId}" />&storeId=<c:out value="${storeId}" />&catalogId=<c:out value="${catalogId}" />" class="t_button" id="WC_RFQModifyDisplay_Link_14_<c:out value="${param.index + 1}" />"><fmt:message key="RFQModifyDisplay_ProdSpec" bundle="${storeText}" /></a><br />
	</c:otherwise>	
	</c:choose> 
	
	
	<c:choose>	
	<c:when test="${param.type eq param.isItem or param.type eq param.isPrebuiltKit}">
		<a href="RFQModifyCommentDisplay?<c:out value="${EC_RFQ_PRODUCT_ID}" />=<c:out value="${param.rfqProdId}" />&<c:out value="${EC_OFFERING_ID}" />=<c:out value="${rfqId}" />&<c:out value="${EC_OFFERING_CATENTRYID}" />=<c:out value="${catid}" />&langId=<c:out value="${langId}" />&storeId=<c:out value="${storeId}" />&catalogId=<c:out value="${catalogId}" />" class="t_button" id="WC_RFQModifyDisplay_Link_15_<c:out value="${param.index + 1}" />"><fmt:message key="RFQModifyDisplay_ProdComm" bundle="${storeText}" /></a><br />
	</c:when>	
	<c:when test="${param.type eq param.isDynamicKit or param.type eq param.isProduct}">
		
	</c:when>		 	
	<c:otherwise>
		<a href="RFQModifyCommentDisplay?<c:out value="${EC_RFQ_PRODUCT_ID}" />=<c:out value="${param.rfqProdId}" />&<c:out value="${EC_OFFERING_ID}" />=<c:out value="${rfqId}" />&<c:out value="${EC_OFFERING_CATENTRYID}" />=<c:out value="${catid}" />&langId=<c:out value="${langId}" />&storeId=<c:out value="${storeId}" />&catalogId=<c:out value="${catalogId}" />" class="t_button" id="WC_RFQModifyDisplay_Link_15_<c:out value="${param.index + 1}" />"><fmt:message key="RFQModifyDisplay_ProdComm" bundle="${storeText}" /></a><br />
	</c:otherwise>	
	</c:choose> 	
	
	
	
	<a href="RFQItemRemove?<c:out value="${EC_RFQ_PRODUCT_ID}" />=<c:out value="${param.rfqProdId}" />&<c:out value="${EC_OFFERING_ID}" />=<c:out value="${rfqId}" />&<c:out value="${EC_OFFERING_CATENTRYID}" />=<c:out value="${catid}" />&langId=<c:out value="${langId}" />&storeId=<c:out value="${storeId}" />&catalogId=<c:out value="${catalogId}" />&URL=RFQModifyDisplay" class="t_button" id="WC_RFQModifyDisplay_Link_16_<c:out value="${param.index + 1}" />"><fmt:message key="RFQModifyDisplay_Remove" bundle="${storeText}" /></a>
</td>

