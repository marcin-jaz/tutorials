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
  * This JSP page interates through a list of components for a dynamic kit.
  *
  * Required parameters:
  * - RFQProductComponentDataBean[] productComponents
  * - index int index of RFQProductComponentDataBean
  *
  *****
--%>

<%@ page language="java" %>

<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf" %>


<c:set var="productComponents" value="${requestScope.productComponents}" />
<c:set var="prodComp" value="${productComponents[param.index]}" />
<c:set var="partNumber" value="${prodComp.orderItemId}" />
<c:set var="quantity" value="${prodComp.inventoryQuantity}" />								
<c:set var="price"  value="${prodComp.unitPrice}" />
<c:set var="catentryId"  value="${prodComp.catalogEntryId}" />

<c:choose>
	<c:when test="${catentryId != null and catid != ''}" >
		<wcbase:useBean id="catalogAB" classname="com.ibm.commerce.catalog.beans.CatalogEntryDescriptionDataBean">
			<c:set target="${catalogAB}" property="dataBeanKeyCatalogEntryReferenceNumber" value="${catentryId}" />
			<c:set target="${catalogAB}" property="dataBeanKeyLanguage_id" value="${langId}" />
			
			<c:set var="prodName" value="${catalogAB.name}" />
			<c:set var="description" value="${catalogAB.shortDescription}" />
		</wcbase:useBean>
	</c:when>
</c:choose>

<td headers="a1" class="t_td" id="WC_RFQProductComponentListDisplay_TableCell_7_<c:out value="${param.index + 1}" />"><c:out value="${prodName}" /></td>
<td headers="a2" class="t_td" id="WC_RFQProductComponentListDisplay_TableCell_8_<c:out value="${param.index + 1}" />"><c:out value="${description}" /></td>
<td headers="a3" class="t_td" id="WC_RFQProductComponentListDisplay_TableCell_9_<c:out value="${param.index + 1}" />"><c:out value="${partNumber}" /></td>
<td headers="a4" class="t_td" id="WC_RFQProductComponentListDisplay_TableCell_10_<c:out value="${param.index + 1}" />"><c:out value="${quantity}" /></td>									
<td headers="a5" class="t_td" id="WC_RFQProductComponentListDisplay_TableCell_11_<c:out value="${param.index + 1}" />"><c:out value="${price}" /></td>

