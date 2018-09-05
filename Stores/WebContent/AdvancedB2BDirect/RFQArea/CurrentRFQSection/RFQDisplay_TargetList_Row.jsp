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
  * This JSP page is used to iterate through the RFQ's target store list.
  *
  * Required parameters:
  * - storeId
  * - storeDisplayName
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

	
	<c:set var="target_storeId" value="${param.storeId}" />
	<c:set var="strDisplayName" value="${param.storeDisplayName}" />
	<c:if test="${strDisplayName == null}">
		<c:set var="strDisplayName" value="Store ${target_storeId}" />
	</c:if>

	<c:url var="StoreViewHref" value="StoreView">
		<c:param name="storeId" value="${target_storeId}" />
	</c:url>
	
							<td headers="WC_RFQDisplay_TargetList_TableCell_5" class="t_td" id="WC_RFQDisplay_TableCell_65_<c:out value="${param.index + 1}" />">
								<a href="<c:out value="${StoreViewHref}" />" id="WC_RFQDisplay_TargetList_Row_Link_1_<c:out value="${param.index + 1}" />">
									<c:out value="${strDisplayName}" />
								</a>
							</td>
