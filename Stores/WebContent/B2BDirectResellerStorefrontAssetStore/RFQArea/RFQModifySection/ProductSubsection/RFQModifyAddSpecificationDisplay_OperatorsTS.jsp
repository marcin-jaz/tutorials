<%
/*
 *-------------------------------------------------------------------
 * Licensed Materials - Property of IBM
 *
 * WebSphere Commerce
 *
 * (c) Copyright International Business Machines Corporation. 2001, 2004
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
  * This JSP page imports a list of operators (timestamp) for the
  * RFQModifyAddSpecificationDisplay JSP pages.
  *
  *****
--%>

<%@ page language="java" %>

<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf" %>



<c:set var="operator_id" value="${param.operator_id}" />

 	<wcbase:useBean id="rfqProduct" classname="com.ibm.commerce.utf.beans.RFQProdDataBean">
           <jsp:setProperty property="*" name="rfqProduct"/>                     
    </wcbase:useBean>
    <c:set var="operatorsTSList" value="${rfqProduct.operatorsTS}"  scope="request" />
    <c:set var="operatorsList" value="${rfqProduct.operators}"  scope="request" />
	

	
	 <c:forEach var="units" items="${requestScope.operatorsTSList}" varStatus="iter">
				
				<c:catch var="e">													
				<option value="<c:out value='${units.key}'/>" 				
				<c:if test="${operator_id eq units.key}" >
					selected 				
				</c:if>				
				>		 
				<c:out value='${units.value}'/>
				</option>	
				</c:catch>	
				<c:if test="${e!=null}">
					<option value="" ></option>
				</c:if>
						
	</c:forEach> 
	<c:remove var="rfqProduct" />
	

	
	
	
	