<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2008, 2009 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>

<%-- 
  *****
  * This JSP removes the products/items from the product comparison list. There is no presentation
  * logic present in this page. When the product is removed from the list, the request is redirected
  * back to the page which invoked the 'Remove' request.
  *****
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>

<%@ include file="../../../../include/parameters.jspf" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf" %>

<!-- BEGIN RemoveFromProductCompare.jsp -->

<%	
	String clearAll = request.getParameter("clearAll");
	String catEntryId = request.getParameter("catEntryId");
	String catEntryIdList = "";
	if ("true".equals(clearAll)) {
		if (session.getAttribute(PRODUCT_COMPARE_CATENTRYIDS_KEY) != null) {
			session.removeAttribute(PRODUCT_COMPARE_CATENTRYIDS_KEY);
		} 		
		session.setAttribute(NUM_PROD_TO_COMPARE_KEY, new Integer(0));		
	} else if (catEntryId != null) {
		java.util.ArrayList catEntryIds = (java.util.ArrayList) session.getAttribute(PRODUCT_COMPARE_CATENTRYIDS_KEY);
		if (catEntryIds != null) {
			catEntryIds.remove(catEntryId);
		}
		for (int i = 0;i < catEntryIds.size(); i++) {
			String s = (String) catEntryIds.get(i);
			catEntryIdList += "&catentryId=" + s;
		}
		session.setAttribute(NUM_PROD_TO_COMPARE_KEY, new Integer(catEntryIds.size()));
	} 
%>


<wcf:url var="RefURL" value="mProductCompareResultView">
	<c:forEach var="parameter" items="${WCParamValues}">
		<c:forEach var="value" items="${parameter.value}">
			<c:if test="${parameter.key ne 'catentryId'}">
				<wcf:param name="${parameter.key}" value="${value}" />
			</c:if>
		</c:forEach>
	</c:forEach>
</wcf:url>

<c:set var="RefURL">
	${RefURL}<%= catEntryIdList %>
</c:set>

<% 
	String refUrl = (String) pageContext.getAttribute("RefURL");
	response.sendRedirect(refUrl); 
	
%>

<!-- END RemoveFromProductCompare.jsp -->
