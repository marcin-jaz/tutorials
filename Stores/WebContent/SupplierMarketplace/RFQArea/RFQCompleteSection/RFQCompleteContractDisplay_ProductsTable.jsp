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
  * This JSP page displays the response products tables.
  *
  * Imports:
  * - RFQCompleteContract_ProductHeader.jsp
  * - RFQCompleteContractDisplay_EvalProducts.jsp
  *
  * Required parameters:
  * - rfqResponseEvals
  * - resId - int
  * - negotiationType int
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

<c:set var="negotiationType" value="${param.negotiationType}" scope="page" />
<c:set var="resId" value="${param.resId}" />

<c:set var="tblTitle" />
<c:choose>
	<c:when test="${negotiationType eq EC_NEGOTIATIONTYPE_PRODPERPRICE}">
		<fmt:message key="RFQCompleteContractDisplay_PPPricingOnProducts" bundle="${storeText}" var="tblTitle" />
	</c:when>
	<c:when test="${negotiationType eq EC_NEGOTIATIONTYPE_PRODFIXPRICE}">
		<fmt:message key="RFQCompleteContractDisplay_FixedPricingOnProducts" bundle="${storeText}" var="tblTitle" />
	</c:when>
	<c:when test="${negotiationType eq EC_NEGOTIATIONTYPE_DKPERPRICE}">
		<fmt:message key="RFQCompleteContractDisplay_PPPricingOnDynamicKits" bundle="${storeText}" var="tblTitle" />
	</c:when>
	<c:when test="${negotiationType eq EC_NEGOTIATIONTYPE_DKFIXPRICE}">
		<fmt:message key="RFQCompleteContractDisplay_FixedPricingOnDynamicKits" bundle="${storeText}" var="tblTitle" />
	</c:when>
</c:choose>

<%--store RFQResPrdListBean in request to use in RFQCompleteContractDisplay_EvalProducts.jsp--%>
<wcbase:useBean id="rfqResPrdList" classname="com.ibm.commerce.rfq.beans.RFQResPrdListBean" scope="request" >
	<jsp:setProperty property="*" name="rfqResPrdList"/>
	<c:set target="${rfqResPrdList}" property="rfqResponseId" value="${resId}" />
	<c:set target="${rfqResPrdList}" property="negotiationType" value="${negotiationType}"  />		
</wcbase:useBean>
<c:set var="respondProdList" value="${rfqResPrdList.resProducts}" scope="request"/>

<c:set var="displayHead" value="${false}"/>
<c:forEach items="${respondProdList}" var="resProduct">
	<%--
		display table only if ResponseProductId matches
	--%>	
	<c:forEach items="${rfqResponseEvals}" var="eval">		
		<c:if test="${eval.rfqResponseProductId eq resProduct.rfqResponseProdId }" >
			<c:set var="displayHead" value="true" />
		</c:if>
	</c:forEach>

	<c:remove var="rfqResPrdList" />
</c:forEach>

<c:if test="${displayHead eq 'true'}" >
	
	<%--display header and products--%>
	<tr>                                
		<td  valign="top" width="100%" class="topspace" id="WC_RFQCompleteContractDisplay_TableCell_10<c:out value="_${negotiationType}" />">
			<h2><c:out value="${tblTitle}" /></h2>
			<table cellpadding="0" cellspacing="0" border="0" width="100%" class="bgColor" id="WC_RFQCompleteContractDisplay_Table_4<c:out value="_${negotiationType}" />">
				<tbody>
				<tr>
					<td id="WC_RFQCompleteContractDisplay_TableCell_11<c:out value="_${negotiationType}" />">
						<table width="100%" border="0" cellpadding="2" cellspacing="1" class="bgColor" id="WC_RFQCompleteContractDisplay_Table_5<c:out value="_${negotiationType}" />">
							<tbody>
							<%--display header--%> 
							<% out.flush(); %>
							<c:import url="RFQCompleteContract_ProductHeader.jsp" >
								<c:param name="negotiationType" value="${negotiationType}" />
							</c:import>
							<% out.flush(); %>	
							
							<% out.flush(); %>
							<c:import url="RFQCompleteContractDisplay_EvalProducts.jsp" >
								<c:param name="index" value="${iter.index}" />
								<c:param name="negotiationType" value="${negotiationType}"  />
							</c:import>	
							<% out.flush(); %>
							<c:remove var="rfqResPrdList" />
							</tbody>
						</table>										
					</td>
				</tr>		
				</tbody>
			</table>
		</td>
	</tr>
</c:if>
