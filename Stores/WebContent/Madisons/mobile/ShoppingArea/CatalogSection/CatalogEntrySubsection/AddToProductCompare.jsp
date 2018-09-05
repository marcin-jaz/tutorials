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


<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>

<%@ include file="../../../../include/parameters.jspf" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf" %>

<%-- 
  *****
  * This JSP adds the products/items which the user selects to the product comparison list. There is 
  * no presentation logic present in this page. The product comparison list is a session variable 
  * and once the product/item is added to this list, the request is redirected back to the page 
  * which invoked the 'Add to product compare' request.
  *****
--%>


<!-- BEGIN AddToProductCompare.jsp -->

<%	
	
	String maxProdToComp = (String) pageContext.getAttribute("maxProdToCompare");
	Integer maxProductToCompare = new Integer(maxProdToComp);
	
	java.util.ArrayList catEntryIds = (java.util.ArrayList) session.getAttribute(PRODUCT_COMPARE_CATENTRYIDS_KEY);
	if (catEntryIds == null) {
		catEntryIds = new java.util.ArrayList();
	}

	String catEntryId = request.getParameter("catEntryId");	
	
	if (catEntryId != null && catEntryIds.size() < maxProductToCompare.intValue() && !catEntryIds.contains(catEntryId)) {
		catEntryIds.add(catEntryId);
		session.setAttribute(PRODUCT_COMPARE_CATENTRYIDS_KEY, catEntryIds);
		session.setAttribute(NUM_PROD_TO_COMPARE_KEY, new Integer(catEntryIds.size()));
	}

%>

<wcf:url var="ProductCompareResultView" value="mProductCompareResultView">
	<c:forEach var="parameter" items="${WCParamValues}">
		<c:forEach var="value" items="${parameter.value}">
			<c:if test="${parameter.key ne 'catentryId'}">
				<wcf:param name="${parameter.key}" value="${value}" />
			</c:if>
		</c:forEach>
	</c:forEach>
</wcf:url>

<c:set var="catEntryValues" value="" />
<c:forEach var="catEntId" items="${sessionScope.productCompareCatentryIds}">
	<c:set var="catEntryValues" value="${catEntryValues}&catentryId=${catEntId}" />
</c:forEach>
<c:set var="ProductCompareResultView" value="${ProductCompareResultView}${catEntryValues}" />

<% 
	String url = (String) pageContext.getAttribute("ProductCompareResultView");
	response.sendRedirect(url); 
	
%>

<!-- END AddToProductCompare.jsp -->