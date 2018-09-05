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
  * This JSP page is used to iterate through the list of RFQs.
  *
  * Imports:
  * - CommonSection/RFQSetup.jsp
  * - CommonSection/RFQ_LinksInclude.jsp
  *
  * Required parameters:
  * - rfqId
  *
  *****
--%>

 
<%@ page language="java" %>

<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="flow.tld" prefix="flow" %>

<%@ include file="../../include/JSTLEnvironmentSetup.jspf" %>
    <% out.flush(); %>
    <c:import url="../CommonSection/RFQSetup.jsp" />
    <% out.flush(); %>

    <c:choose>
	<c:when test="${pageScope.lang <= -7 and pageScope.lang >= -10}">
		<c:set var="wrap" value="nowrap=\"nowrap\"" scope="request" />
	</c:when>
	<c:otherwise>
		<c:set var="wrap" value="" scope="request" />
	</c:otherwise>
    </c:choose> 

    <c:set var="rfq_name" value="${rfqBean.name}" />
    <% out.flush(); %>
    <c:import url="../CommonSection/RFQ_LinksInclude.jsp">
	<c:param name="rfq_offering_id" value="${rfqBean.rfqId}" />
	<c:param name="URL" value="RFQListDisplay" />
    </c:import> 
    <% out.flush(); %>
				<td headers="a1" <c:out value="${wrap}" /> class="t_td" id="WC_RFQListDisplay_TableCell_22_<c:out value="${param.index+1}" />"><c:out value="${rfq_name}" /></td>
            			<td headers="a2" <c:out value="${wrap}" /> class="t_td" id="WC_RFQListDisplay_TableCell_23_<c:out value="${param.index+1}" />"><c:out value="${rfqBean.description.shortDescription}" />&nbsp;</td>
            			<td headers="a3" <c:out value="${wrap}" /> class="t_td" id="WC_RFQListDisplay_TableCell_24_<c:out value="${param.index+1}" />"><c:out value="${rfq_state}" /></td>
            			<td headers="a4" <c:out value="${wrap}" /> class="t_td" id="WC_RFQListDisplay_TableCell_25_<c:out value="${param.index+1}" />"><c:out value="${rfq_round}" /></td>
            			<td headers="a5" <c:out value="${wrap}" /> class="t_td" id="WC_RFQListDisplay_TableCell_26_<c:out value="${param.index+1}" />"><c:out value="${rfq_create_date}" /><br /><c:out value="${rfq_create_time}" />&nbsp;</td>
            			<td headers="a6" <c:out value="${wrap}" /> class="t_td" id="WC_RFQListDisplay_TableCell_27_<c:out value="${param.index+1}" />"><c:out value="${rfq_activate_date}" /></br><c:out value="${rfq_activate_time}" />&nbsp;</td>
            			<td headers="a7" <c:out value="${wrap}" /> class="t_td" id="WC_RFQListDisplay_TableCell_28_<c:out value="${param.index+1}" />"><c:out value="${rfq_close_date}" /><br /><c:out value="${rfq_close_time}" />&nbsp;</td>
				<td headers="a8" nowrap="nowrap" class="t_td" id="WC_RFQListDisplay_TableCell_29_<c:out value="${param.index+1}" />">
				<table width="100%">
				<tr>
				<td id="WC_RFQListDisplay_TableCell_30_<c:out value="${param.index+1}" />">
                			<a href="<c:out value="${RFQDisplayHref}" />" class="t_button" id="WC_RFQListDisplay_Link_5_<c:out value="${param.index+1}" />"><fmt:message key="RFQDisplay_Summary" bundle="${storeText}"/></a>
                		</td>
                		</tr>
                		<tr>
                		<td id="WC_RFQListDisplay_TableCell_31_<c:out value="${param.index+1}" />">
					<a href="<c:out value="${RFQDuplicateDisplayHref}" />" class="t_button" id="WC_RFQListDisplay_Link_6_<c:out value="${param.index+1}" />"><fmt:message key="RFQDisplay_Button_Duplicate" bundle="${storeText}"/></a>
				</td>
                		</tr>
			    <c:choose>
				<c:when test="${systemRFQState eq '5'}">
				<tr>
                		<td id="WC_RFQListDisplay_TableCell_32_<c:out value="${param.index+1}" />">
					<a href="<c:out value="${RFQModifyDisplayHref}" />" class="t_button" id="WC_RFQListDisplay_Link_7_<c:out value="${param.index+1}" />"><fmt:message key="RFQDisplay_Button_Modify" bundle="${storeText}"/></a>
				</td>
				</tr>
                		<tr>
                		<td id="WC_RFQListDisplay_TableCell_33_<c:out value="${param.index+1}" />">
					<a href="<c:out value="${RFQSubmitHref}" />" class="t_button" id="WC_RFQListDisplay_Link_8_<c:out value="${param.index+1}" />"><fmt:message key="RFQDisplay_Button_Submit" bundle="${storeText}"/></a>
				</td>
				</tr>
                		<tr>
                		<td id="WC_RFQListDisplay_TableCell_34_<c:out value="${param.index+1}" />">
					<a href="<c:out value="${RFQCancelHref}" />" class="t_button" id="WC_RFQListDisplay_Link_9_<c:out value="${param.index+1}" />"><fmt:message key="RFQDisplay_Button_Cancel" bundle="${storeText}"/></a>
				</td>
				</tr>
				</c:when>
				<c:when test="${systemRFQState eq '1'}">
				<tr>
                		<td id="WC_RFQListDisplay_TableCell_35_<c:out value="${param.index+1}" />">
				    <a href="<c:out value="${RFQCloseHref}" />" class="t_button" id="WC_RFQListDisplay_Link_10_<c:out value="${param.index+1}" />"><fmt:message key="RFQDisplay_Button_Close" bundle="${storeText}"/></a>
				</td>
				</tr>
                		<tr>
                		<td id="WC_RFQListDisplay_TableCell_36_<c:out value="${param.index+1}" />">
				    <a href="<c:out value="${RFQResponseListDisplayHref}" />" class="t_button" id="WC_RFQListDisplay_Link_11_<c:out value="${param.index+1}" />"><fmt:message key="RFQDisplay_Button_Responses" bundle="${storeText}"/></a>
				</td>
				</tr>
                		<tr>
                		<td id="WC_RFQListDisplay_TableCell_37_<c:out value="${param.index+1}" />">
				    <a href="<c:out value="${RFQCancelHref}" />" class="t_button" id="WC_RFQListDisplay_Link_12_<c:out value="${param.index+1}" />"><fmt:message key="RFQDisplay_Button_Cancel" bundle="${storeText}"/></a>
				</td>
				</tr>
				</c:when>
				<c:when test="${systemRFQState eq '6'}">
				<tr>
                		<td id="WC_RFQListDisplay_TableCell_38_<c:out value="${param.index+1}" />">
				    <a href="<c:out value="${RFQCancelHref}" />" class="t_button" id="WC_RFQListDisplay_Link_13_<c:out value="${param.index+1}" />"><fmt:message key="RFQDisplay_Button_Cancel" bundle="${storeText}"/></a>
				</td>
				</tr>
				</c:when>
				<c:when test="${systemRFQState eq '3'}">
				<tr>
                		<td id="WC_RFQListDisplay_TableCell_39_<c:out value="${param.index+1}" />">
				    <a href="<c:out value="${RFQResponseListDisplayHref}" />" class="t_button" id="WC_RFQListDisplay_Link_14"><fmt:message key="RFQDisplay_Button_Responses" bundle="${storeText}"/></a>
				</td>
				</tr>
                		<tr>
                		<td id="WC_RFQListDisplay_TableCell_40_<c:out value="${param.index+1}" />"> 
				    <a href="<c:out value="${RFQCompleteListResponseDisplayHref}" />" class="t_button" id="WC_RFQListDisplay_Link_15_<c:out value="${param.index+1}" />"><fmt:message key="RFQDisplay_Button_Complete" bundle="${storeText}"/></a>
				</td>
				</tr>
                		<tr>
                		<td id="WC_RFQListDisplay_TableCell_41_<c:out value="${param.index+1}" />">
				    <a href="<c:out value="${RFQCreateForNextRoundDisplayHref}" />" class="t_button" id="WC_RFQListDisplay_Link_16_<c:out value="${param.index+1}" />"><fmt:message key="RFQDisplay_Button_NextRound" bundle="${storeText}"/></a>
				</td>
				</tr>
                		<tr>
                		<td id="WC_RFQListDisplay_TableCell_42_<c:out value="${param.index+1}" />">
				    <a href="<c:out value="${RFQCancelHref}" />" class="t_button" id="WC_RFQListDisplay_Link_17_<c:out value="${param.index+1}" />"><fmt:message key="RFQDisplay_Button_Cancel" bundle="${storeText}"/></a>
				</td>
				</tr>
				</c:when>
				<c:when test="${systemRFQState eq '2'}">
				<tr>
                		<td id="WC_RFQListDisplay_TableCell_43_<c:out value="${param.index+1}" />">
				    <a href="<c:out value="${RFQResponseListDisplayHref}" />" class="t_button" id="WC_RFQListDisplay_Link_18_<c:out value="${param.index+1}" />"><fmt:message key="RFQDisplay_Button_Responses" bundle="${storeText}"/></a>
				</td>
				</tr>
				</c:when>
				<c:when test="${systemRFQState eq '4'}">
				<tr>
                		<td id="WC_RFQListDisplay_TableCell_44_<c:out value="${param.index+1}" />">
				    <a href="<c:out value="${RFQResponseListDisplayHref}" />" class="t_button" id="WC_RFQListDisplay_Link_19_<c:out value="${param.index+1}" />"><fmt:message key="RFQDisplay_Button_Responses" bundle="${storeText}"/></a>
				</td>
				</tr>
				</c:when>
				<c:when test="${systemRFQState eq '16'}">
				<tr>
                		<td id="WC_RFQListDisplay_TableCell_45_<c:out value="${param.index+1}" />">
				    <a href="<c:out value="${RFQResponseListDisplayHref}" />" class="t_button" id="WC_RFQListDisplay_Link_20_<c:out value="${param.index+1}" />"><fmt:message key="RFQDisplay_Button_Responses" bundle="${storeText}"/></a>
				</td>
				</tr>
				</c:when>
			    </c:choose>
				<c:if test="${rfqBean.prevOffIdInEJBType != null}">
				    <c:set var="rfq_offering_id" value="${rfqBean.prevOffIdInEJBType}" />
				<tr>
                		<td id="WC_RFQListDisplay_TableCell_46_<c:out value="${param.index+1}" />">
				    <a href="<c:out value="${RFQDisplayHref}" />" class="t_button" id="WC_RFQListDisplay_Link_21_<c:out value="${param.index+1}" />"><fmt:message key="RFQListDisplay_ViewPrevRound" bundle="${storeText}"/></a>	
				</td>
				</tr>
				</c:if>
				<c:if test="${rfqBean.nextOffIdInEJBType != null}">
				    <c:set var="rfq_offering_id" value="${rfqBean.nextOffIdInEJBType}" />
				<tr>
                		<td id="WC_RFQListDisplay_TableCell_47_<c:out value="${param.index+1}" />">
				    <a href="<c:out value="${RFQDisplayHref}" />" class="t_button" id="WC_RFQListDisplay_Link_21_<c:out value="${param.index+1}" />"><fmt:message key="RFQListDisplay_ViewNextRound" bundle="${storeText}"/></a>
				</td>
				</tr>
				</c:if>
				</table>
				</td>
  
