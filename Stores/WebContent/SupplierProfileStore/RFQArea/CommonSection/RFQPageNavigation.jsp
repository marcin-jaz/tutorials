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
  * This JSP page contains code for page navigation (pagination).  
  * 
  * Preconditions:
  * - linkAction  - url action in requestScope
  * - URL - any number of additional name=value pairs in requestScope
  *  
  * Parameters:
  * - numRec
  * - initPos
  * - pageSize
  * - numPages  
  *****
--%> 

<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="flow.tld" prefix="flow" %>

<%@ include file="../../include/JSTLEnvironmentSetup.jspf" %>

<c:set var="numRec" value="${param.numRec}" />
<c:set var="initPos" value="${param.initPos}"  />
<c:set var="pageSize" value="${param.pageSize}"  />
<c:set var="numPages" value="${param.numPages}" />
<c:set var="offering_id" value="${param.offering_id}" />

<c:set var="linkAction" value="${requestScope.linkAction}" />
<c:set var="URL" value="${requestScope.URL}" />

<%-- set default values if incoming parameters are empty --%>
<c:choose>
       <c:when test="${!empty param.numRec}">
              <c:set var="numRec" value="${param.numRec}"/>
       </c:when>    
       <c:otherwise>
              <c:set var="numRec" value="0"/>
       </c:otherwise>
</c:choose>
<c:choose>
       <c:when test="${!empty currentPage}">
              <c:set var="currentPage" value="${currentPage}"/>
       </c:when>    
       <c:otherwise>
              <c:set var="currentPage" value="1"/>
       </c:otherwise>
</c:choose>
<c:choose>
       <c:when test="${!empty param.pageSize}">
              <c:set var="pageSize" value="${param.pageSize}"/>
       </c:when>    
       <c:otherwise>
              <c:set var="pageSize" value="10"/>
       </c:otherwise>
</c:choose>
<c:choose>
       <c:when test="${!empty param.initPos}">
              <c:set var="initPos" value="${param.initPos}"/>
       </c:when>    
       <c:otherwise>
              <c:set var="initPos" value="0"/>
       </c:otherwise>
</c:choose>
<c:choose>
       <c:when test="${!empty param.numPages}">
              <c:set var="numPages" value="${param.numPages}"/>
       </c:when>    
       <c:otherwise>
              <c:set var="numPages" value="10"/>
       </c:otherwise>
</c:choose>

<fmt:formatNumber value="${initPos/pageSize }" maxFractionDigits="0" var="currentPage" />
<c:set var="numRec" value="${numRec + (currentPage * pageSize)}" />

<fmt:formatNumber value="${numPages / 2}" maxFractionDigits="0" var="startPageCalc" />
<fmt:formatNumber value="${(numRec - 1) / pageSize}" maxFractionDigits="0" var="endPageCalc" />

<c:set var="startPage" value="0" />
<c:if test="${(currentPage - startPageCalc) > 0}">
	<c:set var="startPage" value="${currentPage - startPageCalc}" />
</c:if>

<c:set var="endPage" value="${endPageCalc + 1}" />
<c:if test="${endPage > (startPage + numPages)}">
	<c:set var="endPage" value="${startPage + numPages}" />
</c:if>
<c:if test="${(startPage > (endPage - numPages)) and ((endPage - numPages) > 0)}">
	<c:set var="startPage" value="${endPage - numPages}" />
</c:if>
		
<c:set var="index" value="0" scope="page" />
<c:if test="${(initPos - pageSize) > 0}">
	<c:set var="index" value="${initPos - pageSize}" />
</c:if>
<c:if test="${numRec > pageSize}">
	<fmt:message key="RFQ_PAGE" bundle="${storeText}"/> &nbsp;
	<c:url var="strHref"
		value="${linkAction}">
		<c:param name="initPos" value="${index}" />
		<c:param name="langId" value="${langId}" />
		<c:param name="storeId" value="${storeId}" />
		<c:param name="catalogId" value="${catalogId}" />
		<c:param name="offering_id" value="${offering_id}" />
	</c:url>
	<a href="<c:out value="${strHref}&${URL}" />" id="WC_RFQPageNavigation_Link_1"> 
		<fmt:message key="RFQListDisplay_Previous" bundle="${storeText}" /></a>&nbsp;
	<c:forEach begin="${startPage}" end="${endPage - 1}" varStatus="i">
		<c:choose>
			<c:when test="${i.index eq currentPage}">
				<c:out value="${i.count}" />&nbsp;
			</c:when>
			<c:otherwise>
				<c:url var="strHref"
					value="${linkAction}">
					<c:param name="initPos" value="${i.index * pageSize}" />
					<c:param name="langId" value="${langId}" />
					<c:param name="storeId" value="${storeId}" />
					<c:param name="catalogId" value="${catalogId}" />
					<c:param name="offering_id" value="${offering_id}" />
				</c:url>
				<a href="<c:out value="${strHref}&${URL}" />" id="WC_RFQPageNavigation_Link_2"><c:out value="${i.count}" /></a>&nbsp;
			</c:otherwise>
		</c:choose>
	</c:forEach>
	<c:if test="${initPos + pageSize < numRec}">
		<c:url var="strHref"
			value="${linkAction}">
			<c:param name="initPos" value="${initPos + pageSize}" />
			<c:param name="langId" value="${langId}" />
			<c:param name="storeId" value="${storeId}" />
			<c:param name="catalogId" value="${catalogId}" />
			<c:param name="offering_id" value="${offering_id}" />
		</c:url>
		<a href="<c:out value="${strHref}&${URL}" />"	id="WC_RFQPageNavigation_Link_3"> 
			<fmt:message
			key="RFQListDisplay_Next" bundle="${storeText}" /> </a>&nbsp;
	</c:if>
</c:if>
<%-- end display navigation to next/previous page--%>
