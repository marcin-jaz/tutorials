<%
/*
 *-------------------------------------------------------------------
 * Licensed Materials - Property of IBM
 *
 * WebSphere Commerce
 *
 * (c) Copyright International Business Machines Corporation. 2004
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
  * This JSP page constructs the month drop-down
  * selection box for RFQ JSP pages (using named
  * month literals).                                     . 
  *  
  * Required parameters:
  * - select_name - name of select control
  * - default_option - default value
  * - selected_val - month selected
  *
  *****
--%>
<%@ page language="java" %>

<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="flow.tld" prefix="flow" %>

<%@ include file="../../include/JSTLEnvironmentSetup.jspf" %>

<fmt:message key="RFQCompleteOrderDisplay_Jan" bundle="${storeText}" var="Jan"/>
<fmt:message key="RFQCompleteOrderDisplay_Feb" bundle="${storeText}" var="Feb"/>
<fmt:message key="RFQCompleteOrderDisplay_Mar" bundle="${storeText}" var="Mar"/>
<fmt:message key="RFQCompleteOrderDisplay_Apr" bundle="${storeText}" var="Apr"/>
<fmt:message key="RFQCompleteOrderDisplay_May" bundle="${storeText}" var="May"/>
<fmt:message key="RFQCompleteOrderDisplay_Jun" bundle="${storeText}" var="Jun"/>
<fmt:message key="RFQCompleteOrderDisplay_Jul" bundle="${storeText}" var="Jul"/>
<fmt:message key="RFQCompleteOrderDisplay_Aug" bundle="${storeText}" var="Aug"/>
<fmt:message key="RFQCompleteOrderDisplay_Sep" bundle="${storeText}" var="Sep"/>
<fmt:message key="RFQCompleteOrderDisplay_Oct" bundle="${storeText}" var="Oct"/>
<fmt:message key="RFQCompleteOrderDisplay_Nov" bundle="${storeText}" var="Nov"/>
<fmt:message key="RFQCompleteOrderDisplay_Dec" bundle="${storeText}" var="Dec"/>

<label for="WC_SelectMonthLit_Select_1"><fmt:message var="strMon" key="RFQCreateDisplay_SelectMonth" bundle="${storeText}" /></label>
<c:set var="strDefaultMon" value="-- ${strMon} --" />

<!--SELECT MONTH LITERALS-->
	
	<SELECT id="WC_SelectMonthLit_Select_1" class="select" name="<c:out value="${param.select_name}"/>"  >
<c:if test="${param.default_option != null}">
		<option value=""><c:out value="${strDefaultMon}" /></option>
</c:if>
	<c:forTokens var="month" items="1,2,3,4,5,6,7,8,9,10,11,12" delims=",">
		<OPTION value="<c:out value="${month}"/>"
			<c:if test="${param.selected_val != null and param.selected_val eq month}"><c:out value="selected=selected" /></c:if>>
			
		<c:choose>
			<c:when test="${month eq 1}" ><c:out value="${Jan}" /></c:when>
			<c:when test="${month eq 2}" ><c:out value="${Feb}" /></c:when>
			<c:when test="${month eq 3}" ><c:out value="${Mar}" /></c:when>
			<c:when test="${month eq 4}" ><c:out value="${Apr}" /></c:when>
			<c:when test="${month eq 5}" ><c:out value="${May}" /></c:when>
			<c:when test="${month eq 6}" ><c:out value="${Jun}" /></c:when>
			<c:when test="${month eq 7}" ><c:out value="${Jul}" /></c:when>
			<c:when test="${month eq 8}" ><c:out value="${Aug}" /></c:when>
			<c:when test="${month eq 9}" ><c:out value="${Sep}" /></c:when>
			<c:when test="${month eq 10}" ><c:out value="${Oct}" /></c:when>
			<c:when test="${month eq 11}" ><c:out value="${Nov}" /></c:when>
			<c:when test="${month eq 12}" ><c:out value="${Dec}" /></c:when>			
			<c:otherwise>			
			</c:otherwise>			
		</c:choose>		
			
		</OPTION>
	</c:forTokens>
	</SELECT>

<!--END SELECT MONTH LITERALS-->
