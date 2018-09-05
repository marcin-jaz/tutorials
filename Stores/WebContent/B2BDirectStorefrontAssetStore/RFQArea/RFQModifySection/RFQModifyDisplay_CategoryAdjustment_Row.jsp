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
  * This JSP page iterates through a list of category percentage price 
  * adjustment entries for the RFQModifyDisplay JSP page.
  *
  * Imports:
  * - CommonSection/RFQSetup.jsp
  * - RFQModifyDisplay_Setup.jsp
  * - RFQModifyDisplay_CategoryAdjustment_Row.jsp
  *
  * Required parameters:
  * - RFQPriceAdjustmentOnCategory [] ppArray
  * - index - int, index of current object
  * - offering_id
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

	
<c:set var="rfqPP" value="${requestScope.ppArray[param.index]}" />
<c:set var="synchronize" value="${rfqPP.synchronize}" />
<c:set var="percentagePriceAttr" value="${rfqPP.percentagePrice}" />
<c:set var="categoryIDreferenceNumberAttr" value="${rfqPP.category_id}" />
<c:set var="categoryDesc" value="${rfqPP.description}" />
<c:set var="categoryName" value="${rfqPP.catName}" />
<c:set var="tcID" value="${rfqPP.tc_id}" />
<c:set var="wrap" value="${requestScope.wrap}" scope="request" />

<fmt:message key="RFQDisplay_Percentage" bundle="${storeText}" var="percent" />

<c:if test="${!empty percentagePriceAttr}">	
	<c:set var="formattedPP" value="${percentagePriceAttr * -1}" />
	<fmt:formatNumber value="${formattedPP}" var="formattedPP" />
</c:if>

<c:forEach items="${catalog.topCategories}" var="topCategory" varStatus="iter">
	<c:forEach items="${catCategory.subCategories}" var="subCategory" >
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
		<input type="hidden" name="tc_id_<c:out value="${param.index + 1}" />" value="<c:out value="${tcID}" />" />
    		<input type="hidden" name="categoryId_<c:out value="${param.index + 1}" />" value="<c:out value="${categoryIDreferenceNumberAttr}" />" /> 	
	</td>
	<td class="t_td" id="WC_RFQDisplay_TableCell_24_<c:out value="${param.index + 1}" />"><c:out value="${categoryDesc}" />
	</td> 
	<td class="t_td" id="WC_RFQDisplay_TableCell_25_<c:out value="${param.index + 1}" />" align="center"> 
		<label for="WC_RFQModifyDisplay_CategoryAdjustment_Row_1"></label>
		<input id="WC_RFQModifyDisplay_CategoryAdjustment_Row_1" size="16" maxlength="20" class="input" type="text" name="categoryPercentagePrice_<c:out value="${param.index + 1}" />" title='<fmt:message key="RFQModifyDisplay_PPPrice" bundle="${storeText}"/> - <c:out value="${categoryName}" /> ' value="<c:out value="${formattedPP}" />" />

	</td>
	<td class="t_td" id="WC_RFQDisplay_TableCell_26_<c:out value="${param.index + 1}" />" align="center">	
	    <label for="WC_RFQModifyDisplay_Select_1"></label>
	    <select id="WC_RFQModifyDisplay_Select_1" class="select" name="synchronize_<c:out value="${param.index + 1}" />">
<c:choose>
	<c:when test="${synchronize eq 'false'}">		
		<option value="false" selected="selected"><fmt:message key="RFQModifyDisplay_PPSynchronize_No" bundle="${storeText}"/></option>
		<option value="true"><fmt:message key="RFQModifyDisplay_PPSynchronize_Yes" bundle="${storeText}"/></option>				      			
	</c:when>
	<c:otherwise>		
		<option value="true" selected="selected"><fmt:message key="RFQModifyDisplay_PPSynchronize_Yes" bundle="${storeText}"/></option>
		<option value="false"><fmt:message key="RFQModifyDisplay_PPSynchronize_No" bundle="${storeText}"/></option>		
	</c:otherwise>
</c:choose>	
	    </select>		      	 		      

	</td>	 
	<td <c:out value="${wrap}" /> class="t_td" id="WC_RFQModifyDisplay_TableCell_72_<c:out value="${param.index + 1}" />">
     		<a href="RFQPriceAdjustmentOnCategoryRemove?categoryId=<c:out value="${categoryIDreferenceNumberAttr}" />&<c:out value="${EC_OFFERING_ID}" />=<c:out value="${rfqId}" />&langId=<c:out value="${langId}" />&storeId=<c:out value="${storeId}" />&catalogId=<c:out value="${catalogId}" />&URL=RFQModifyDisplay" class="t_button" id="WC_RFQModifyDisplay_HRef_1"><fmt:message key="RFQModifyDisplay_Remove" bundle="${storeText}" /></a>
	</td>
<c:set var="numPPTC" value="${param.index + 1}" scope="request" />

