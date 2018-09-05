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
  * This JSP page is used to iterate through category price adjustments
  * for a response.
  *
  * Required parameters:
  * - RFQPriceAdjustmentOnCategory [] ppArray
  * - index - int
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
<c:set var="categoryName" value="${rfqPP.catName}" />

<c:choose>
	<c:when test="${percentagePriceAttr != null}">
		<fmt:message key="RFQDisplay_Percentage" bundle="${storeText}" var="percent" />
		<fmt:formatNumber value="${percentagePriceAttr}" var="percentagePriceAttr" />		
		<c:set var="percentagePriceAttr" value="${percentagePriceAttr} ${percent}" />
		<td class="t_td" id="WC_RFQCompleteContractDisplay_TableCell_6_<c:out value="${param.index + 1}" />"><c:out value="${categoryName}" />
		</td>
		<td class="t_td" id="WC_RFQCompleteContractDisplay_TableCell_7_<c:out value="${param.index + 1}" />" align="center"><c:out value="${percentagePriceAttr}" />
			</td>
		<td class="t_td" id="WC_RFQCompleteContractDisplay_TableCell_8_<c:out value="${param.index + 1}" />" align="center">				
			<c:choose>
				<c:when test="${synchronize eq 'false'}">
					<fmt:message key="RFQModifyDisplay_PPSynchronize_No" bundle="${storeText}"/>
				</c:when>
				<c:otherwise>
					<fmt:message key="RFQModifyDisplay_PPSynchronize_Yes" bundle="${storeText}"/>
				</c:otherwise>
			</c:choose>	  
		</td> 
	</c:when>
	<c:otherwise>
        <td id="WC_RFQCompleteContractDisplay_TableCell_9" class="t_td" colspan="5"><fmt:message key="RFQModifyDisplay_PPNoCatFound" bundle="${storeText}"/> 
       	</td>
	</c:otherwise> 
</c:choose>
