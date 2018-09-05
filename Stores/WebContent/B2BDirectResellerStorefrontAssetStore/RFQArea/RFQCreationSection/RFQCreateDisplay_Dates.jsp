<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2004, 2008 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>
<%--        
  *****
  * This JSP page displays date/time input fields for the RFQ Create JSP page.
  *
  * Imports:
  * - CommonSection/SelectMonthLit.jsp
  *
  * Required parameters:
  * - strDisplayDay
  * - strDisplayMon
  * - strDisplayYr
  * - selectNamePrefix
  *
  *****
--%>

<%@ page language="java" %>

<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="flow.tld" prefix="flow" %>

<%@ include file="../../include/JSTLEnvironmentSetup.jspf" %>



<fmt:message var="strYr" key="RFQCreateDisplay_SelectYear" bundle="${storeText}" />
<fmt:message var="strMon" key="RFQCreateDisplay_SelectMonth" bundle="${storeText}" />
<fmt:message var="strDay" key="RFQCreateDisplay_SelectDay" bundle="${storeText}" />

<c:set var="strDefaultYr" value="-- ${strYr} --" />
<c:set var="strDefaultMon" value="-- ${strMon} --" />
<c:set var="strDefaultDay" value="-- ${strDay} --" />

<%--
	variables used in included files
				select_name - name of select control
				default_option - default value
				selected_val - day selected, optional
--%>

<!-- YEAR -->
<!-- Get current date -->
<jsp:useBean id="now" class="java.util.Date"/>
<fmt:message key="RFQCreateDisplay_Year" bundle="${storeText}"/>
<c:set var="select_name" value="${param.selectNamePrefix}Yr"/>
<c:set var="selected_val" value="${param.strDisplayYr}"/>
<c:set var="default_option" value="${strDefaultYr}"/>
<%@ include file="../CommonSection/SelectYear.jspf" %>

<!-- MONTH -->
&nbsp;&nbsp;
<fmt:message key="RFQCreateDisplay_Month" bundle="${storeText}"/>	
<% out.flush(); %>										
<c:import url="../CommonSection/SelectMonthLit.jsp">
	<c:param name="select_name" value="${param.selectNamePrefix}Mon" />	
	<c:param name="selected_val" value="${param.strDisplayMon}" />
	<c:param name="default_option" value="${strDefaultMon}" />
</c:import>	
<% out.flush(); %>
<!-- DAY --> 
<fmt:message key="RFQCreateDisplay_Day" bundle="${storeText}"/>
<c:set var="select_name" value="${param.selectNamePrefix}Day"/>
<c:set var="selected_val" value="${param.strDisplayDay}"/>
<c:set var="default_option" value="${strDefaultDay}"/>
<%@ include file="../CommonSection/SelectDay.jspf" %>
