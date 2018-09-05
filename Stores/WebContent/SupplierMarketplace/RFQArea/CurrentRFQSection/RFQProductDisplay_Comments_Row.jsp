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
  * This JSP page iterates through the comments of an RFQ product.
  *
  * Required parameters:
  * - pcomment
  * - index int
  *
  *****
--%>

<%@ page language="java" %>

<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../include/JSTLEnvironmentSetup.jspf" %>



<c:set var="pcomment" value="${requestScope.pcomment}" />
<c:set var="aComment" value="${pcomment[param.index]}" />
<c:set var="com_desc" value="${aComment.description}" />
<c:set var="com_value" value="${aComment.value}" />

<c:set var="com_mandatory" value="${aComment.mandatory}" />
<c:choose>
	<c:when test="${com_mandatory eq '1'}">
		<fmt:message key="RFQProductDisplay_Yes" bundle="${storeText}" var="mandatory" />
	</c:when>
	<c:when test="${com_mandatory eq '0'}">
		<fmt:message key="RFQProductDisplay_No" bundle="${storeText}" var="mandatory" />
	</c:when>
</c:choose>

<c:set var="com_changeable" value="${aComment.changeable}" />
<c:choose>
	<c:when test="${com_changeable eq '0'}">
		<fmt:message key="RFQProductDisplay_No" bundle="${storeText}" var="changeable" />
	</c:when>
	<c:when test="${com_changeable eq '1'}">
		<fmt:message key="RFQProductDisplay_Yes" bundle="${storeText}" var="changeable" />
	</c:when>
</c:choose>


<td headers="b1" class="t_td" id="WC_RFQproductDisplay_CR_TableCell_1"><c:out value="${com_desc}" /></td>
<td headers="b2" class="t_td" id="WC_RFQproductDisplay_CR_TableCell_2"><c:out value="${com_value}" /></td>
<td headers="b3" class="t_td" id="WC_RFQproductDisplay_CR_TableCell_3"><c:out value="${mandatory}" /></td>
<td headers="b4" class="t_td" id="WC_RFQproductDisplay_CR_TableCell_4"><c:out value="${changeable}" /></td>


