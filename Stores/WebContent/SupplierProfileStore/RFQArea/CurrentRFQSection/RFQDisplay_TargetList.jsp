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
  * This JSP page displays a list of target stores on the RFQ summary page.
  * It imports the RFQDisplay_TargetList_Row.jsp to iterate through
  * RFQ target stores.    
  *
  * Imports:
  * - RFQDisplay_TargetList_Row.jsp
  *
  * Required parameters:
  * - offeringId
  *
  *****
--%>

<%@ page language="java" %>

<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="flow.tld" prefix="flow" %>

<%@ include file="../../include/JSTLEnvironmentSetup.jspf" %>

       <tr>
			<td valign="top" width="400" class="topspace" id="WC_RFQDisplay_TargetList_TableCell_1"><br />
			<table  border="0" id="WC_RFQDisplay_TargetList_Table_1">
			<tbody>
				<tr>
					<td id="WC_RFQDisplay_TargetList_TableCell_2">
						<fmt:message key="RFQDisplay_IsPublic" bundle="${storeText}" />&nbsp;&nbsp; <i>
		
		 <wcbase:useBean id="targetListBean" classname="com.ibm.commerce.rfq.beans.RFQTargetListBean" scope="request">
			<jsp:setProperty property="*" name="targetListBean"/>
			<c:set property="tradingId" value="${offeringId}" target="${targetListBean}" />
		</wcbase:useBean> 
		<c:set var="targetDBs" value="${targetListBean.targets}" scope="request" />   
		
		<c:choose>
			<c:when test="${!empty targetDBs}">
						<fmt:message key="RFQDisplay_IsPublic_Targeted" bundle="${storeText}" />
			</c:when>
			<c:otherwise>
						<fmt:message key="RFQDisplay_IsPublic_Public" bundle="${storeText}" />						
			</c:otherwise>
		</c:choose> 
						</i>
					</td>
				</tr>
			</tbody>
			</table>
			</td>
		</tr>


				
		<tr>
			<td  valign="top" width="400" class="topspace" id="WC_RFQDisplay_TableCell_61">
				<h2><fmt:message key="RFQDisplay_TargetList" bundle="${storeText}" /></h2>
			<table cellpadding="0" cellspacing="0" border="0" width="620" class="bgColor" id="WC_RFQDisplay_TargetList_Table_2">
			<tbody>
				<tr>
					<td id="WC_RFQDisplay_TargetList_TableCell_3">
					<table width="100%" border="0" cellpadding="2" cellspacing="1" class="bgColor" id="WC_RFQDisplay_TargetList_Table_3">
					<tbody>
						<tr>
							<th class="colHeader" id="WC_RFQDisplay_TargetList_TableCell_5"><fmt:message key="RFQDisplay_TargetList_Stores" bundle="${storeText}" /></th>
						</tr>

		<!-- iterate through targetted stores -->		

		
		<c:set var="color" value="cellBG_2" />
		<c:forEach var="targets" items="${targetDBs}"  begin="0"  varStatus="iter">
			<c:choose>
				<c:when test="${color == 'cellBG_1'}">
					<c:set var="color" value="cellBG_2" />
				</c:when>
				<c:when test="${color == 'cellBG_2'}">
					<c:set var="color" value="cellBG_1" />
				</c:when>
			</c:choose>
						<%--
							set data for display RFQDisplay_TargetList_Row.jsp 
						--%>
						<tr class="<c:out value="${color}" />">
							<% out.flush(); %>
							<c:import url="RFQDisplay_TargetList_Row.jsp">
								<c:param name="index" value="${iter.index}" />
								<c:param name="target_storeId" value="${targetStoreId}" />
								<c:param name="storeDisplayName" value="${targets.storeDisplayName}" />
							</c:import>
							<% out.flush(); %>
						</tr>
		</c:forEach>
		<!-- end iterate through targetted stores -->
		<c:if test="${empty targetDBs}">
						<tr class="cellBG_1">
							<td  valign="top" colspan="1" class="categoryspace t_td" id="WC_RFQDisplay_TargetList_TableCell_6">
								<fmt:message key="RFQDisplay_TargetList_NoStores" bundle="${storeText}" />
							</td>
						</tr>
		</c:if>
					</tbody>
					</table>
					</td>
				</tr>
			</tbody>
			</table>
			</td>
		</tr>
		