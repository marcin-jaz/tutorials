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
  * This JSP page displays the header for response products based on 
  * the negotiation type.
  *
  * Required parameters:
  * - negotiationType - int
  *
  *****
--%>

<%@ page language="java" %>

<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="flow.tld" prefix="flow" %>

<%@ include file="../../include/JSTLEnvironmentSetup.jspf" %>


<c:set var="EC_NEGOTIATIONTYPE_PRODFIXPRICE" value="1" scope="page" />
<c:set var="EC_NEGOTIATIONTYPE_PRODPERPRICE" value="2" scope="page" />
<c:set var="EC_NEGOTIATIONTYPE_DKFIXPRICE" value="3" scope="page" />
<c:set var="EC_NEGOTIATIONTYPE_DKPERPRICE" value="4" scope="page" />

<c:choose>
	<c:when test="${param.negotiationType eq EC_NEGOTIATIONTYPE_PRODPERPRICE}">
		<tr>
			<th id="a1" valign="top" class="colHeader" id="WC_RFQCompleteContractDisplay_TableCell_12"><fmt:message key="RFQCompleteContractDisplay_ProductName" bundle="${storeText}"/></th>
			<th id="a2" valign="top" class="colHeader" id="WC_RFQCompleteContractDisplay_TableCell_13"><fmt:message key="RFQCompleteContractDisplay_ProductType" bundle="${storeText}"/></th>
			<th id="a3" valign="top" class="colHeader" id="WC_RFQCompleteContractDisplay_TableCell_14"><fmt:message key="RFQCompleteContractDisplay_SKU" bundle="${storeText}"/></th>
			<th id="a4" valign="top" class="colHeader_last" id="WC_RFQCompleteContractDisplay_TableCell_15"><fmt:message key="RFQCompleteContractDisplay_PriceAdjust" bundle="${storeText}"/></th>											
		</tr>
	</c:when>
	<c:when test="${param.negotiationType eq EC_NEGOTIATIONTYPE_PRODFIXPRICE}">
			<tr>
				<th id="a1" valign="top" class="colHeader" id="WC_RFQCompleteContractDisplay_TableCell_12"><fmt:message key="RFQCompleteContractDisplay_ProductName" bundle="${storeText}"/></th>
				<th id="a2" valign="top" class="colHeader" id="WC_RFQCompleteContractDisplay_TableCell_13"><fmt:message key="RFQCompleteContractDisplay_ProductType" bundle="${storeText}"/></th>
				<th id="a3" valign="top" class="colHeader" id="WC_RFQCompleteContractDisplay_TableCell_14"><fmt:message key="RFQCompleteContractDisplay_SKU" bundle="${storeText}"/></th>
				<th id="a4" valign="top" class="colHeader_last" id="WC_RFQCompleteContractDisplay_TableCell_15"><fmt:message key="RFQCompleteContractDisplay_Quan" bundle="${storeText}"/></th>											
			</tr>
	</c:when>
	<c:when test="${param.negotiationType eq EC_NEGOTIATIONTYPE_DKPERPRICE}">
			<tr>
			<td id="WC_RFQCompleteContractDisplay_TableCell_11">
				<table width="100%" border="0" cellpadding="2" cellspacing="1" class="bgColor" id="WC_RFQCompleteContractDisplay_Table_5">
					<tbody>
					<tr>
						<th id="a1" valign="top" class="colHeader" id="WC_RFQCompleteContractDisplay_TableCell_12"><fmt:message key="RFQCompleteContractDisplay_ProductName" bundle="${storeText}"/></th>
						<th id="a2" valign="top" class="colHeader" id="WC_RFQCompleteContractDisplay_TableCell_14"><fmt:message key="RFQCompleteContractDisplay_SKU" bundle="${storeText}"/></th>
						<th id="a3" valign="top" class="colHeader_last" id="WC_RFQCompleteContractDisplay_TableCell_15"><fmt:message key="RFQCompleteContractDisplay_PriceAdjust" bundle="${storeText}"/></th>											
					</tr>
			
	</c:when>
	<c:when test="${param.negotiationType eq EC_NEGOTIATIONTYPE_DKFIXPRICE}">
		<tr>
		<td id="WC_RFQCompleteContractDisplay_TableCell_11">
			<table width="100%" border="0" cellpadding="2" cellspacing="1" class="bgColor" id="WC_RFQCompleteContractDisplay_Table_5">
				<tbody>
				<tr>
					<th id="a1" valign="top" class="colHeader" id="WC_RFQCompleteContractDisplay_TableCell_12"><fmt:message key="RFQCompleteContractDisplay_ProductName" bundle="${storeText}"/></th>
					<th id="a2" valign="top" class="colHeader" id="WC_RFQCompleteContractDisplay_TableCell_14"><fmt:message key="RFQCompleteContractDisplay_SKU" bundle="${storeText}"/></th>
					<th id="a3" valign="top" class="colHeader_last" id="WC_RFQCompleteContractDisplay_TableCell_15"><fmt:message key="RFQCompleteContractDisplay_Quan" bundle="${storeText}"/></th>											
				</tr>		
	</c:when>
</c:choose>
