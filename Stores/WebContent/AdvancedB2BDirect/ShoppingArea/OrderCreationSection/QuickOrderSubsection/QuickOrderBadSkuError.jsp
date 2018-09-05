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
  * This JSP page handles an error that occurs while adding an item to an order. 
  * If the item was being added to an order through QuickOrder, the QuickOrder JSP page
  * is displayed to handle the error; otherwise the Generic error page is displayed.
  *****
--%>
<!-- BEGIN QuickOrderBadSkuError.jsp -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf"%>
<c:choose>
	<c:when test="${requestScope.callingpage[0] == 'QuickOrder'}">
		<% out.flush(); %>
		<c:import url="${jspStoreDir}ShoppingArea/OrderCreationSection/QuickOrderSubsection/QuickOrderForm.jsp"/>
		<% out.flush(); %>
	</c:when>
	<c:otherwise>
		<% out.flush(); %>	
		<c:import url="${jspStoreDir}GenericError.jsp" />
		<% out.flush(); %>
	</c:otherwise>
</c:choose>

<!-- END QuickOrderBadSkuError.jsp -->