<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2002, 2009 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%-- 
  *****
  * This JSP can be called directly from a URL such as http://<hostname>/<webpath>/<storedir>/index.jsp.
  *  index.jsp acquires the storeId from parameters.jspf and finds the stores master catalogId if the
  * catalogId is not provided in the URL.
  * This JSP redirects to the TopCategoriesDisplay view to display the store's home page.
  *****
--%>
<%@ page import="com.ibm.commerce.server.*" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/coremetrics"  prefix="cm" %>
<%@ taglib uri="flow.tld" prefix="flow" %>

<%@ include file="include/parameters.jspf" %>
<%@ include file="include/nocache.jspf" %>
<c:set var="langId" value="${CommandContext.languageId}" scope="page" />


<c:if test="${empty requestScope.requestServletPath}">
	<c:redirect url="${requestScope.contextPath}/servlet${pageContext.request.servletPath}"/>
</c:if>

<%
JSPHelper jhelper = new JSPHelper(request);
String storeentID = jhelper.getParameter("storeId");
if (storeentID!= null && !storeentID.equals("")) {
	storeId = storeentID;
}
request.setAttribute("storeId", storeId);

String catalogId = jhelper.getParameter("catalogId");
request.setAttribute("catalogId", catalogId);
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
<c:set var="catalogId" value="${requestScope.catalogId}"/>
<c:if test="${empty catalogId}">
	<c:set var="catalogId" value="${storeDB.masterCatalogDataBean.catalogId}"/>
</c:if>

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
* End: Code fragment to get appropriate sales catalog ID.
***
--%>

<c:set var="userType" value="${CommandContext.user.registerType}" scope="page"/>
<c:set var="guest" value="G"/>
<c:choose>
	<c:when test="${!userType eq guest}">
              <wcf:url var="homePageUrl" value="TopCategories1">
                <wcf:param name="langId" value="${langId}" />
                <wcf:param name="storeId" value="${requestScope.storeId}" />
                <wcf:param name="catalogId" value="${catalogId}" />
              </wcf:url>
	</c:when>
	<c:otherwise>
		<wcf:url var="homePageUrl" value="LogonForm">
			<wcf:param name="catalogId" value="${catalogId}"/>
			<wcf:param name="storeId" value="${requestScope.storeId}"/>
			<wcf:param name="langId" value="${langId}"/>
			<wcf:param name="myAcctMain" value="1"/>
			<wcf:param name="page" value="${WCParam.page}"/>
		</wcf:url>
	</c:otherwise>
</c:choose>

<html lang="en" xml:lang="en">
	<head>
		<meta http-equiv="Refresh" content="0;URL=${homePageUrl}"/>
	</head>
	<body>
	<flow:ifEnabled feature="Analytics"><cm:pageview/></flow:ifEnabled>
	</body>
</html>
