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
  * This JSP page is used to iterate through the RFQ's category price adjustments.
  *
  * Required parameters:
  * - RFQPriceAdjustmentOnCategory [] ppArray
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


<c:set var="rfqPP" value="${requestScope.ppArray[param.index]}" />
<c:set var="synchronize" value="${rfqPP.synchronize}" />
<c:set var="percentagePriceAttr" value="${rfqPP.percentagePrice}" />
<c:set var="categoryIDreferenceNumberAttr" value="${rfqPP.category_id}" />
<c:set var="categoryDesc" value="${rfqPP.description}" />
<c:set var="categoryName" value="${rfqPP.catName}" />
<c:set var="tcID" value="${rfqPP.tc_id}" />
<fmt:message key="RFQDisplay_Percentage" bundle="${storeText}" var="percent" />

<c:if test="${!empty percentagePriceAttr}">
	<fmt:formatNumber value="${percentagePriceAttr}" var="percentagePriceAttr" />
	<c:set var="percentagePriceAttr" value="${percentagePriceAttr} ${percent}" />
</c:if>

<c:forEach items="${catalog.topCategories}" var="topCategory" varStatus="iter">
	<c:forEach items="${topCategory.subCategories}" var="subCategory" >
		<c:if test="${subCategory.categoryId eq categoryIDreferenceNumberAttr}" >
			<c:set var="parentCatId" value="${topCategory.categoryId}" />
		</c:if>
	</c:forEach>
</c:forEach>

<c:url var="CategoryDisplayHref" value="CategoryDisplay">
<c:param name="catalogId" value="${catalogId}" />
	<c:param name="storeId" value="${storeId}" />
	<c:param name="categoryId" value="${categoryIDreferenceNumberAttr}" />
	<c:param name="langId" value="${langId}" />
	<c:param name="parent_category_rn" value="${categoryName}" />
</c:url>
<td class="t_td" id="WC_RFQDisplay_TableCell_23_<c:out value="${param.index + 1}" />"><a href="<c:out value="${CategoryDisplayHref}" />"><c:out value="${categoryName}" /></a>
	</td>
<td class="t_td" id="WC_RFQDisplay_TableCell_24_<c:out value="${param.index + 1}" />"><c:out value="${categoryDesc}" />
	</td>
<td class="t_td" id="WC_RFQDisplay_TableCell_25_<c:out value="${param.index + 1}" />" align="center"><c:out value="${percentagePriceAttr}" /> 
	</td>
<td class="t_td" id="WC_RFQDisplay_TableCell_26_<c:out value="${param.index + 1}" />" align="center">	
<c:choose>
	<c:when test="${synchronize eq 'false'}">
		<fmt:message key="RFQModifyDisplay_PPSynchronize_No" bundle="${storeText}"/>
	</c:when>
	<c:otherwise>
		<fmt:message key="RFQModifyDisplay_PPSynchronize_Yes" bundle="${storeText}"/>
	</c:otherwise>
</c:choose>			      
</td>	
