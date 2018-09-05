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
  * This JSP page is used to iterate through the RFQ's terms and conditions 
  * comments list.
  *
  * Required parameters:
  * - OrderCommentData [] commentsList
  * - index - int, index of current object
  *
  *****
--%>

<%@ page language="java" %>

<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../include/JSTLEnvironmentSetup.jspf" %>


<c:set var="commentsList" value="${commentsList}" scope="request" />
<c:set var="comment" value="${commentsList[param.index]}" />
<c:set var="tccomment" value="${comment.comment}" />
<c:set var="tcmandatory" value="${comment.mandatoryFlag}" />
<c:set var="tcchange" value="${comment.changeableFlag}" />
<c:choose>
	<c:when test="${tcmandatory == 1}">
		<fmt:message key="RFQDisplay_Yes" bundle="${storeText}" var="tcman_status"/>
	</c:when>
	<c:otherwise >
		<fmt:message key="RFQDisplay_No" bundle="${storeText}" var="tcman_status"/>
	</c:otherwise>
</c:choose>


<c:choose>
	<c:when test="${tcchange == 1}">
		<fmt:message key="RFQDisplay_Yes" bundle="${storeText}" var="tcchange_status"/>
	</c:when>
	<c:otherwise>
		<fmt:message key="RFQDisplay_No" bundle="${storeText}" var="tcchange_status"/>
	</c:otherwise>
</c:choose>
<%--
	DISPLAY:
--%>
  	<td headers="b1" class="t_td" id="WC_RFQDisplay_TableCell_17_<c:out value="${param.index + 1}" />"><c:out value="${tcman_status}" /></td>
	<td headers="b2" class="t_td" id="WC_RFQDisplay_TableCell_18_<c:out value="${param.index + 1}" />"><c:out value="${tcchange_status}" /></td>
	<td headers="b3" class="t_td" id="WC_RFQDisplay_TableCell_19_<c:out value="${param.index + 1}" />"><c:out value="${tccomment}" /></td>
