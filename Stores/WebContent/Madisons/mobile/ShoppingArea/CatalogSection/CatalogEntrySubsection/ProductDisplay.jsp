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
  * This JSP displays the product details page. Depending on the type of catentry(Product/Item/Package/Bundle),
  * appropriate type display page will be invoked
  *****
--%>

<!-- BEGIN ProductDisplay.jsp -->


<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>

<%@ include file="../../../../include/parameters.jspf" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf" %>

<%@ page import="com.ibm.commerce.catalog.objects.CatalogGroupCatalogEntryRelationAccessBean" %>
<%@ page import="com.ibm.commerce.catalog.beans.CatalogEntryDataBean" %>

<%-- If there is no productId in the request, then we try to add one from partNumber, if the partnumber
	 is in the request
--%>
<c:set var="productId" value="${WCParam.productId}" />

<c:set var="pgGrp" value="${WCParam.pgGrp}" />
<c:choose>
	<c:when test='${pgGrp == "prodComp"}'>
		<c:set var="prodComparePageGroup" value="true" scope="request"/>
	</c:when>
	<c:when test='${pgGrp == "search"}'>
		<c:set var="searchPageGroup" value="true" scope="request"/>
	</c:when>	
	<c:when test='${pgGrp == "wishlist"}'>	
		<c:set var="wishlistPageGroup" value="true" scope="request"/>
	</c:when>
	<c:when test='${pgGrp == "shoppingcart"}'>
		<c:set var="shoppingcartPageGroup" value="true" scope="request"/>
	</c:when>
	<c:otherwise>
		<c:set var="categoryNavPageGroup" value="true" scope="request"/>
	</c:otherwise>
</c:choose>

<c:set var="productPage" value="true" scope="request"/>

<%

	// Required logic for the Product Quick view function. There are 3 different behaviours for the product quick
	// view functionality 
	// 1. Next/Prev Product links on a product page when the user browsed the product through category navigation
	// 2. Next/Prev Product links on a product page when the user browsed the product from the search results
	// 3. Next/Prev Product links on a product page when the user browsed the product from the product compare list
	// 4. Next/Prev Product links on a product page when the user browsed the product from the wishlist
	
	String seq = request.getParameter("sequence");		

	if ("prodComp".equals(request.getParameter("pgGrp"))) {
		if (seq != null) {
			int index = Integer.parseInt(seq);
			java.util.ArrayList catEntryIds = (java.util.ArrayList) session.getAttribute(PRODUCT_COMPARE_CATENTRYIDS_KEY);
			if (catEntryIds != null) {
				String catEntryId = (String) catEntryIds.get(index);
				%>
				<c:set var="productId" value="<%= catEntryId %>" />
				<c:set property="productId" value="${productId}" target="${WCParam}"/>
				<%
			}			
		}
	} else if ("wishlist".equals(request.getParameter("pgGrp"))) {
		if (seq != null) {
			int index = Integer.parseInt(seq);
			String catEntryIds = (String) session.getAttribute(WISHLIST_PRODUCTID_KEY);
			if (catEntryIds != null) {
				String catEntArr[] = catEntryIds.split(",");
				String catEntryId = catEntArr[index];
				%>
				<c:set var="productId" value="<%= catEntryId %>" />
				<c:set property="productId" value="${productId}" target="${WCParam}"/>
				<%
			}			
		}
	} else if ("shoppingcart".equals(request.getParameter("pgGrp"))) {
		if (seq != null) {
			int index = Integer.parseInt(seq);
			String catEntryIds = (String) session.getAttribute(SHOPPINGCART_PRODUCTID_KEY);
			if (catEntryIds != null) {
				String catEntArr[] = catEntryIds.split(",");
				String catEntryId = catEntArr[index];
				%>
				<c:set var="productId" value="<%= catEntryId %>" />
				<c:set property="productId" value="${productId}" target="${WCParam}"/>
				<%
			}			
		}
	} else {
		String categoryId = request.getParameter("categoryId");
		if (seq != null && seq.trim().length() > 0 && categoryId != null && categoryId.trim().length() > 0) {
			double sequence = Double.parseDouble(seq);
			CatalogGroupCatalogEntryRelationAccessBean catGrpCatEntRel = new CatalogGroupCatalogEntryRelationAccessBean();
			long catGrpId = Long.parseLong(categoryId);
			java.util.Enumeration e = catGrpCatEntRel.findByCatalogGroupId(new Long(catGrpId));			
			while (e.hasMoreElements()) {
				boolean useSequence = false;
				CatalogGroupCatalogEntryRelationAccessBean catEntRel = (CatalogGroupCatalogEntryRelationAccessBean) e.nextElement();

				if (catEntRel.getSequenceInEJBType().doubleValue() == sequence) {
					CatalogEntryDataBean catEntDataBean = new CatalogEntryDataBean();
					catEntDataBean.setCatalogEntryID(catEntRel.getCatalogEntryId());

					if (catEntDataBean.isItem() && (catEntDataBean.getItemDataBean().getParentProductId() == catEntDataBean.getItemDataBean().getItemID())) {
						useSequence = true;
					} else if (!catEntDataBean.isItem() && !catEntDataBean.isDynamicKit()) {
						useSequence = true;
					}
				}

				if(useSequence) { %>
					<c:set var="productId" value="<%= catEntRel.getCatalogEntryId() %>" />
					<c:set property="productId" value="${productId}" target="${WCParam}"/>
					<%
					break;
				}
			}
		}
	}
%>


<%-- If there is no productId in the request, then we tried to add one from partNumber, if the partnumber
	 is in the request
--%>

<c:choose>
	<c:when test="${empty productId && !empty WCParam.partNumber}">
		<wcbase:useBean id="catalogEntry" classname="com.ibm.commerce.catalog.beans.CatalogEntryDataBean">
			<c:set property="partNumber" value="${WCParam.partNumber}" target="${catalogEntry}"/>
		</wcbase:useBean>
	</c:when>
	<c:otherwise>
		<wcbase:useBean id="catalogEntry" classname="com.ibm.commerce.catalog.beans.CatalogEntryDataBean">
			<c:set property="catalogEntryID" value="${productId}" target="${catalogEntry}"/>
		</wcbase:useBean>
	</c:otherwise>
</c:choose>
<c:set property="productId" value="${catalogEntry.catalogEntryID}" target="${WCParam}"/>

<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.2//EN" "http://www.openmobilealliance.org/tech/DTD/xhtml-mobile12.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" lang="${shortLocale}" xml:lang="${shortLocale}">
	<head>
		<title><fmt:message key="PRODUCT_TITLE" bundle="${storeText}" />: <c:out value="${catalogEntry.description.name}" escapeXml="false"/></title>
		<meta http-equiv="content-type" content="application/xhtml+xml" />
		<meta http-equiv="cache-control" content="max-age=300" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no" />
		<link rel="stylesheet" href="${cssPath}"/>
	</head>
	
	<body>
		<div id="wrapper">
		
			<%@ include file="../../../include/HeaderDisplay.jspf" %>
			<%@ include file="../../../include/BreadCrumbTrailDisplay.jspf"%>			
			
			<%out.flush();%>			
			
			<c:choose>
				<c:when test="${catalogEntry.bundle == true}">
					<c:import url="${jspStoreDir}mobile/Snippets/Catalog/CatalogEntryDisplay/CachedBundleDisplay.jsp">
						<c:param name="storeId" value="${WCParam.storeId}"/>
						<c:param name="catalogId" value="${WCParam.catalogId}"/>
						<c:param name="langId" value="${langId}"/>
						<c:param name="productId" value="${productId}"/>
					</c:import>											
				</c:when>
				<c:when test="${catalogEntry.package == true}">
					<c:import url="${jspStoreDir}mobile/Snippets/Catalog/CatalogEntryDisplay/CachedPackageDisplay.jsp">
						<c:param name="storeId" value="${WCParam.storeId}"/>
						<c:param name="catalogId" value="${WCParam.catalogId}"/>
						<c:param name="langId" value="${langId}"/>
						<c:param name="productId" value="${productId}"/>
					</c:import>											
				</c:when>
				<c:when test="${catalogEntry.item == true}">
					<c:import url="${jspStoreDir}mobile/Snippets/Catalog/CatalogEntryDisplay/CachedItemDisplay.jsp">
						<c:param name="storeId" value="${WCParam.storeId}"/>
						<c:param name="catalogId" value="${WCParam.catalogId}"/>
						<c:param name="langId" value="${langId}"/>
						<c:param name="productId" value="${productId}"/>
					</c:import>											
				</c:when>
				<c:when test="${catalogEntry.product == true}">
					<c:import url="${jspStoreDir}mobile/Snippets/Catalog/CatalogEntryDisplay/CachedProductDisplay.jsp">
						<c:param name="storeId" value="${WCParam.storeId}"/>
						<c:param name="catalogId" value="${WCParam.catalogId}"/>
						<c:param name="langId" value="${langId}"/>
						<c:param name="productId" value="${productId}"/>
					</c:import>							
				</c:when>												
			</c:choose>
			<%out.flush();%>
			<%@ include file="../../../include/FooterDisplay.jspf" %>									
		</div>			
	</body>
</html>

<!-- END ProductDisplay.jsp -->
