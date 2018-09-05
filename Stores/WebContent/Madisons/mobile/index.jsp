<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2001, 2009 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>

<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.2//EN" "http://www.openmobilealliance.org/tech/DTD/xhtml-mobile12.dtd">

<%-- 
  *****
  * This JSP can be called directly from a URL such as http://<hostname>/<webpath>/<storedir>/mobile/index.jsp.
  * index.jsp acquires the storeId from parameters.jspf and finds the stores master catalogId.
  * This JSP redirects to the TopCategoriesDisplay view to display the store's home page.
  *****
--%>

<!-- BEGIN index.jsp -->

<%@ include file="../include/parameters.jspf" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>

<c:if test="${empty requestScope.requestServletPath}">
	<c:redirect url="${requestScope.contextPath}/servlet${pageContext.request.servletPath}"/>
</c:if>

<%

com.ibm.commerce.server.JSPHelper jhelper = new com.ibm.commerce.server.JSPHelper(request);
String storeentID = jhelper.getParameter("storeId");
if (storeentID!= null && !storeentID.equals("")) {
	storeId = storeentID;
}
request.setAttribute("storeId", storeId);
%>


<wcbase:useBean id="storeDB" classname="com.ibm.commerce.common.beans.StoreDataBean">
	<% storeDB.setStoreId(storeId); %>
</wcbase:useBean>


<%--
***
* By default, the catalogId in the initial URL is set to the master catalog ID.
* This implies that the master catalog will be displayed in the store pages.
***
--%>
<c:set var="catalogId" value="${storeDB.masterCatalogDataBean.catalogId}"/>


<%--
***
* Start: Code sample to get appropriate sale catalog ID.
* 
* Please uncomment the code fragment below if you want to display sale catalog in the store pages.
* The following code fragment will return the first sales catalog ID returned by the StoreDataBean.getSalesCatalogs() method.
* If there are more than 1 sale catalog, you can select the desired catalog by
* changing the value of 'desiredSalesCatalogIndex'.
* If the desired sale catalog is not available, it will revert back to the master catalog.
***
--%>
<%--
<c:if test="${!empty storeDB.salesCatalogs}">
	<c:if test="${!empty storeDB.salesCatalogs[0]}">
		<c:set var="catalogId" value="${storeDB.salesCatalogs[0].catalogId}"/>
	</c:if>
	
</c:if>
--%>
<%--
***
* End: Code fragment to get appropriate sale catalog ID.
***
--%>

<wcf:url var="mobileHome" value="mIndex">
	<wcf:param name="catalogId" value="${catalogId}"/>
	<wcf:param name="storeId" value="${requestScope.storeId}"/>
</wcf:url>

<html xmlns="http://www.w3.org/1999/xhtml" lang="en" xml:lang="en">
	<head>
		<meta http-equiv="Refresh" content="0;URL=${mobileHome}"/>
	</head>
	<body>
	</body>
</html>

<!-- END index.jsp -->