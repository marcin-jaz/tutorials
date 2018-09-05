<%
//********************************************************************
//*-------------------------------------------------------------------
//* Licensed Materials - Property of IBM
//*
//* WebSphere Commerce
//*
//* (c) Copyright IBM Corp. 2000, 2003, 2004
//*
//* US Government Users Restricted Rights - Use, duplication or
//* disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
//*
//*-------------------------------------------------------------------
//*
%>
<%-- 
  *****
  * This JSP is called from CachedSidebarDisplay.jsp which is a cached page.  This JSP is not cached.  
  * WCParamValuesDisplay.jsp takes all the parameters from the Request Attributes and puts them into hidden fields which can be
  * used in a form to redisplay the current page when a Language or Currency selection is made.
  *****
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="JSTLEnvironmentSetup.jspf"%>

<%-- If a URL parameter is in the request, we must append it to the request URI to simulate the last request --%>
<c:choose>
	<c:when test="${WCParam.URL != null && WCParam.URL!=''}" >
		<input type="hidden" name="URL" value="<c:out value="${requestScope.requestURIPath}" />?URL=<c:out value="${WCParam.URL}"/>?currency*=" id="WC_SidebarDisplay_FormInput_URL_1"/>
	</c:when>
	<c:otherwise>
		<input type="hidden" name="URL" value="<c:out value="${requestScope.requestURIPath}" />?currency*=" id="WC_SidebarDisplay_FormInput_URL_2"/>
	</c:otherwise>
</c:choose>

<%-- Get all request parameters and their values --%>
<c:forEach var="aParam" items="${WCParamValues}" varStatus="paramStatus">
	<c:forEach var="aValue" items="${aParam.value}"  varStatus="paramNumStatus">
		<c:if test="${aParam.key !='langId' && aParam.key !='logonPassword' && aParam.key !='URL' && aParam.key !='currency' && aParam.key !='storeId' && aParam.key !='catalogId'}">
			<input type="hidden" name="<c:out value="${aParam.key}" />" value="<c:out value="${aValue}" />" id="WC_SidebarDisplay_FormInput_parm_<c:out value="${paramStatus.count}" />_<c:out value="${paramNumStatus.count}" />"/>
		</c:if>
	</c:forEach>
</c:forEach>

