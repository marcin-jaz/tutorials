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
  * This JSP page contains setup information for 
  * RFQ JSP pages. Sets create and end date/times,
  * date/time format, and RFQ state.
  *  
  *****
--%>
<%@ page language="java" %>

<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../include/JSTLEnvironmentSetup.jspf" %>

<%--
Preconditions:
	RFQDataBean rfqBean is set as a request attribute
--%>	


<c:remove var="rfq_create_date" scope="request" />	
<c:remove var="rfq_create_time" scope="request" />
<c:remove var="rfq_activate_date" scope="request" />
<c:remove var="rfq_activate_time" scope="request" />
<c:remove var="rfq_close_date" scope="request" />
<c:remove var="rfq_close_time" scope="request" />
<c:remove var="rfq_start_date" scope="request" />
<c:remove var="rfq_start_time" scope="request" />
<c:remove var="rfq_end_date" scope="request" />
<c:remove var="rfq_end_time" scope="request" />	
<c:remove var="rfq_state" scope="request" />
 

     
<fmt:parseDate pattern="yyyy-MM-dd HH:mm:ss" value="${requestScope.rfqBean.createTimeInEJBType}" var="createTimeInEJBType" />        
<fmt:formatDate value="${createTimeInEJBType}" type="date" dateStyle="short" var="rfq_create_date" scope="request" />                                                                                                                                                                                                                  
<fmt:formatDate value="${createTimeInEJBType}" type="time" timeStyle="short" var="rfq_create_time" scope="request" />
                  

<fmt:parseDate pattern="yyyy-MM-dd HH:mm:ss" value="${requestScope.rfqBean.activateTimeInEJBType}" var="activateTimeInEJBType" />        
<fmt:formatDate value="${activateTimeInEJBType}" type="date" dateStyle="short" var="rfq_activate_date" scope="request" />                 
<fmt:formatDate value="${activateTimeInEJBType}" type="time" timeStyle="short" var="rfq_activate_time" scope="request" />
  
  
<fmt:parseDate pattern="yyyy-MM-dd HH:mm:ss" value="${requestScope.rfqBean.closeTimeInEJBType}" var="closeTimeInEJBType" />        
<fmt:formatDate value="${closeTimeInEJBType}" type="date" dateStyle="short" var="rfq_close_date" scope="request" />
<fmt:formatDate value="${closeTimeInEJBType}" type="time" timeStyle="short" var="rfq_close_time" scope="request" />


<fmt:parseDate pattern="yyyy-MM-dd HH:mm:ss" value="${requestScope.rfqBean.startTimeInEJBType}" var="startTimeInEJBType" />        
<fmt:formatDate value="${startTimeInEJBType}" type="date" dateStyle="short" var="rfq_start_date" scope="request" />
<fmt:formatDate value="${startTimeInEJBType}" type="time" timeStyle="short" var="rfq_start_time" scope="request" />
 
                 
<fmt:parseDate pattern="yyyy-MM-dd HH:mm:ss" value="${requestScope.rfqBean.endTimeInEJBType}" var="endTimeInEJBType" />        
<fmt:formatDate value="${endTimeInEJBType}" type="date" dateStyle="short" var="rfq_end_date" scope="request" />
<fmt:formatDate value="${endTimeInEJBType}" type="time" timeStyle="short" var="rfq_end_time" scope="request" />

<c:set var="EC_UTF_ENDRESULT_CONTRACT" value="0" scope="request" />                                
<c:set var="isContract" value="${requestScope.rfqBean.endResultInEJBType eq EC_UTF_ENDRESULT_CONTRACT}" scope="request" />


<c:set var="rfq_short_desc" value="${requestScope.rfqBean.description.shortDescription}" scope="request" />
<c:set var="rfq_long_desc" value="${requestScope.rfqBean.description.longDescription}" scope="request" />
<c:set var="systemRFQState" value="${requestScope.rfqBean.stateInEJBType}" scope="request" />

<c:set var="EC_STATE_START" value="0" scope="request" />
<c:set var="EC_STATE_ACTIVE" value="1" scope="request" />
<c:set var="EC_STATE_CANCELED" value="2" scope="request" />
<c:set var="EC_STATE_CLOSED" value="3" scope="request" />
<c:set var="EC_STATE_COMPLETED" value="4" scope="request" />
<c:set var="EC_STATE_DRAFT" value="5" scope="request" />
<c:set var="EC_STATE_FUTURE" value="6" scope="request" />
<c:set var="EC_STATE_INEVAL" value="7" scope="request" />
<c:set var="EC_STATE_LOST" value="8" scope="request" />
<c:set var="EC_STATE_PENDINGAPPROVAL" value="9" scope="request" />
<c:set var="EC_STATE_REJECTED" value="10" scope="request" />
<c:set var="EC_STATE_RETRACTED" value="11" scope="request" />
<c:set var="EC_STATE_WON" value="12" scope="request" />
<c:set var="EC_STATE_CONTRACT_CREATED" value="13" scope="request" />
<c:set var="EC_STATE_ORDER_CREATED" value="14" scope="request" />
<c:set var="EC_STATE_NO_RESPONSE" value="15" scope="request" />
<c:set var="EC_STATE_NEXT_ROUND" value="16" scope="request" />



<c:choose>
	<c:when test="${systemRFQState eq EC_STATE_DRAFT}">
		<fmt:message key="RFQFindResultDisplay_Draft" bundle="${storeText}" var="rfq_state" scope="request"/>
	</c:when>
	<c:when test="${systemRFQState eq EC_STATE_ACTIVE}">
		<fmt:message key="RFQFindResultDisplay_Active" bundle="${storeText}" var="rfq_state" scope="request"/>					
	</c:when>
	<c:when test="${systemRFQState eq EC_STATE_FUTURE}">
		<fmt:message key="RFQListDisplay_Future" bundle="${storeText}" var="rfq_state" scope="request"/>						
	</c:when>
	<c:when test="${systemRFQState eq EC_STATE_CLOSED}">
		<fmt:message key="RFQFindResultDisplay_Closed" bundle="${storeText}" var="rfq_state" scope="request" />						
	</c:when>
	<c:when test="${systemRFQState eq EC_STATE_CANCELED}">
		<fmt:message key="RFQFindResultDisplay_Canceled" bundle="${storeText}" var="rfq_state" scope="request"/>							
	</c:when>
	<c:when test="${systemRFQState eq EC_STATE_COMPLETED}">
		<fmt:message key="RFQListDisplay_Complete" bundle="${storeText}" var="rfq_state" scope="request"/>							
	</c:when>
	<c:when test="${systemRFQState eq EC_STATE_NEXT_ROUND}">
		<fmt:message key="RFQListDisplay_NextRound" bundle="${storeText}" var="rfq_state" scope="request" />				
	</c:when>
	<c:otherwise>
		<c:set var="rfq_state" value="${systemRFQState}" scope="request" />							
	</c:otherwise>
</c:choose>


