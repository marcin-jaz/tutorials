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
  * This JSP page assembles information used by the RFQDisplay.jsp including
  * attachements, price adjustments on categories, previous and next offering
  * ids, rule type, categories and comments.
  *
  *****
--%>

<%@ page language="java" %>

<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../include/JSTLEnvironmentSetup.jspf" %>



<c:set var="attachments" value="requestScope.rfqBean.attachments" />
<c:if test="${requestScope.isContract}" >
	<wcbase:useBean id="catalog" classname="com.ibm.commerce.catalog.beans.CatalogDataBean" scope="page">
			
	</wcbase:useBean>
<c:set var="ppArray" value="${rfqBean.allPriceAdjustmentOnCategory}" scope="request" />
</c:if>
<c:choose>
		<c:when test="${rfqBean.prevOffIdInEJBType != null}" >
			<wcbase:useBean id="tmpRFQAB" classname="com.ibm.commerce.utf.beans.RFQDataBean">
				<c:set value="${rfqBean.prevOffIdInEJBType}" target="${tmpRFQAB}" property="rfqId" />
				
			</wcbase:useBean>
			<c:set var="previous_off_name" value="${tmpRFQAB.name}" scope="request"/>
			<c:set var="previous_off_id" value="${rfqBean.prevOffIdInEJBType}" scope="request"/>
			<c:set var="has_previous_off" value="true" scope="request"/>
		</c:when>
		<c:otherwise>
			<c:set var="has_previous_off" value="false" scope="request"/>
		</c:otherwise>
</c:choose>


<c:choose>
		<c:when test="${rfqBean.nextOffIdInEJBType != null}" >
			<wcbase:useBean id="tmpRFQDB" classname="com.ibm.commerce.utf.beans.RFQDataBean">
				<c:set value="${rfqBean.nextOffIdInEJBType}" target="${tmpRFQDB}" property="rfqId" />
				
			</wcbase:useBean>
			<c:set var="next_off_name" value="${tmpRFQDB.name}" scope="request"/>
			<c:set var="next_off_id" value="${rfqBean.nextOffIdInEJBType}" scope="request"/>
			<c:set var="has_next_off" value="true" scope="request"/>
		</c:when>
		<c:otherwise>
			<c:set var="has_next_off" value="false" scope="request"/>
		</c:otherwise>
</c:choose>

<c:set var="rfqCloseRule" value="${rfqBean.ruleTypeInEJBType}" />
<c:set var="closeRule" value="" scope="request" />
<c:choose>
	<c:when test="${rfqCloseRule eq '1'}">
		<fmt:message key="RFQDisplay_Rule1" bundle="${storeText}" var="closeRule"/>
	</c:when>
	<c:when test="${rfqCloseRule eq '2'}">
		<fmt:message key="RFQDisplay_Rule2" bundle="${storeText}" var="closeRule"/>
	</c:when>
	<c:when test="${rfqCloseRule eq '3'}">
		<fmt:message key="RFQDisplay_Rule3" bundle="${storeText}" var="closeRule"/>
	</c:when>
	<c:when test="${rfqCloseRule eq '4'}">
		<fmt:message key="RFQDisplay_Rule4" bundle="${storeText}" var="closeRule"/>
	</c:when>
</c:choose>

<wcbase:useBean id="rfqCategoryAB" classname="com.ibm.commerce.rfq.beans.RFQCategryListBean">
	<c:set property="rfqId" value="${rfqBean.rfqId}" target="${rfqCategoryAB}" />
	
</wcbase:useBean>
<c:set var="categoryList" value="${rfqCategoryAB.rfqCategories}" scope="request" />


<c:set var="commentsList" value="${rfqBean.orderCommentList}" scope="request" />
