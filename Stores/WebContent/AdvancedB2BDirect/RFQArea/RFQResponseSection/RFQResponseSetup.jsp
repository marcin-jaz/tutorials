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
  * This JSP page determines the state of an RFQ response. 
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
	RFQResponseDataBean rfqRes is set as a request attribute
--%>
<c:set var="RFQ_EC_RESPONSE_STATE_DRAFT" value="1" scope="request" />
<c:set var="RFQ_EC_RESPONSE_STATE_ACTIVE" value="2" scope="request" />
<c:set var="RFQ_EC_RESPONSE_STATE_CANCELLED" value="3" scope="request" />
<c:set var="RFQ_EC_RESPONSE_STATE_RETRACTED" value="7" scope="request" />
<c:set var="RFQ_EC_RESPONSE_STATE_IN_EVALUATION" value="4" scope="request" />
<c:set var="RFQ_EC_RESPONSE_STATE_WON" value="8" scope="request" />
<c:set var="RFQ_EC_RESPONSE_STATE_LOST" value="9" scope="request" />
<c:set var="RFQ_EC_RESPONSE_STATE_WON_COMPLETED" value="10" scope="request" />
<c:set var="RFQ_EC_RESPONSE_STATE_LOST_COMPLETED" value="11" scope="request" />
<c:set var="RFQ_EC_RESPONSE_STATE_PENDING_APPROVAL" value="5" scope="request" />
<c:set var="RFQ_EC_RESPONSE_STATE_REJECTED" value="6" scope="request" />
<c:set var="RFQ_EC_RESPONSE_STATE_LOST_NEXTROUND" value="13" scope="request" />
<c:set var="RFQ_EC_RESPONSE_STATE_WON_NEXTROUND" value="12" scope="request" />

<c:set var="RFQ_EC_RESPONSE_ACCEPTACTION_ALL" value="0" scope="request" />
<c:set var="RFQ_EC_RFQ_RESPONSE_PRODUCT_ID" value="responseProductId" scope="request" />

 

<c:set var="systemRFQRespState" value="${requestScope.rfqRes.stateInEJBType}" scope="request" />
<c:set var="responseState" scope="request" />	
<c:choose>
	<c:when test="${systemRFQRespState eq RFQ_EC_RESPONSE_STATE_DRAFT}">
		<fmt:message key="RFQResponseDisplay_Draft" bundle="${storeText}" var="responseState" scope="request"/>
	</c:when>
	<c:when test="${systemRFQRespState eq RFQ_EC_RESPONSE_STATE_ACTIVE}">
		<fmt:message key="RFQResponseDisplay_Active" bundle="${storeText}" var="responseState" scope="request"/>					
	</c:when>
	<c:when test="${systemRFQRespState eq RFQ_EC_RESPONSE_STATE_RETRACTED}">
		<fmt:message key="RFQResponseDisplay_Retracted" bundle="${storeText}" var="responseState" scope="request"/>						
	</c:when>
	<c:when test="${systemRFQRespState eq RFQ_EC_RESPONSE_STATE_IN_EVALUATION}">
		<fmt:message key="RFQResponseDisplay_Inevaluation" bundle="${storeText}" var="responseState" scope="request" />						
	</c:when>
	<c:when test="${systemRFQRespState eq RFQ_EC_RESPONSE_STATE_CANCELLED}">
		<fmt:message key="RFQResponseDisplay_Cancelled" bundle="${storeText}" var="responseState" scope="request"/>							
	</c:when>
	<c:when test="${systemRFQRespState eq RFQ_EC_RESPONSE_STATE_LOST_COMPLETED}">
		<fmt:message key="RFQResponseDisplay_LostComplete" bundle="${storeText}" var="responseState" scope="request"/>							
	</c:when>
	<c:when test="${systemRFQRespState eq RFQ_EC_RESPONSE_STATE_WON_COMPLETED}">
		<fmt:message key="RFQResponseDisplay_WonComplete" bundle="${storeText}" var="responseState" scope="request"/>							
	</c:when>
	<c:when test="${systemRFQRespState eq RFQ_EC_RESPONSE_STATE_LOST}">
		<fmt:message key="RFQResponseDisplay_Lost" bundle="${storeText}" var="responseState" scope="request"/>							
	</c:when>
	<c:when test="${systemRFQRespState eq RFQ_EC_RESPONSE_STATE_WON}">
		<fmt:message key="RFQResponseDisplay_Won" bundle="${storeText}" var="responseState" scope="request"/>							
	</c:when>
	<c:when test="${systemRFQRespState eq RFQ_EC_RESPONSE_STATE_PENDING_APPROVAL}">
		<fmt:message key="RFQResponseDisplay_PendingApproval" bundle="${storeText}" var="responseState" scope="request" />				
	</c:when>  
	<c:when test="${systemRFQRespState eq RFQ_EC_RESPONSE_STATE_REJECTED}">
		<fmt:message key="RFQResponseDisplay_Rejected" bundle="${storeText}" var="responseState" scope="request" />				
	</c:when>  
	<c:when test="${systemRFQRespState eq RFQ_EC_RESPONSE_STATE_WON_NEXTROUND}">
		<fmt:message key="RFQResponseDisplay_Won" bundle="${storeText}" var="responseState" scope="request" /> 	
		<fmt:message key="RFQ_Next_Round" bundle="${storeText}" var="RFQ_Next_Round" /> 	
		<c:set var="responseState" value="${responseState} ${RFQ_Next_Round}" scope="request" />												
	</c:when>	
	<c:when test="${systemRFQRespState eq RFQ_EC_RESPONSE_STATE_LOST_NEXTROUND}">
		<fmt:message key="RFQResponseDisplay_Lost" bundle="${storeText}" var="responseState" scope="request" />									
	    <fmt:message key="RFQ_Next_Round" bundle="${storeText}" var="RFQ_Next_Round" /> 
		<c:set var="responseState" value="${responseState} ${RFQ_Next_Round}" scope="request" />								
	</c:when>	 
	<c:otherwise>
		<c:set var="responseState" value="${systemRFQRespState}" scope="request" />							
	</c:otherwise>
</c:choose>









				
					
