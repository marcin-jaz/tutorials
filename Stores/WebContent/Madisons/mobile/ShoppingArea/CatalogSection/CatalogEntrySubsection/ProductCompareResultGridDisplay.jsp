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
  * This JSP page will display the product comparison results for the mobile store front.
  *****
--%>

<!-- BEGIN ProductCompareResultGridDisplay.jsp -->

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>

<%@ include file="../../../../include/parameters.jspf" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf" %>

<%-- For breadcrumb support --%>
<c:choose>
	<c:when test="${!empty WCParam.pgGrp and WCParam.pgGrp == 'catNav'}">
		<c:set var="categoryNavPageGroup" value="true" scope="request"/>
	</c:when>
	<c:when test="${!empty WCParam.pgGrp and WCParam.pgGrp == 'search'}">
		<c:set var="searchPageGroup" value="true" scope="request"/>
	</c:when>	
	<c:otherwise>
		<c:set var="prodComparePageGroup" value="true" scope="request" />	
	</c:otherwise>
</c:choose>
<c:set var="prodComparePage" value="true" scope="request" />

<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.2//EN" "http://www.openmobilealliance.org/tech/DTD/xhtml-mobile12.dtd">

<%@page import="java.util.ArrayList"%>

<%@page import="com.ibm.commerce.catalog.beans.CatalogEntryDataBean"%><html xmlns="http://www.w3.org/1999/xhtml" lang="${shortLocale}" xml:lang="${shortLocale}">
	<head>
		<title><fmt:message key="PRODUCT_COMPARE_LIST" bundle="${storeText}"/></title>
		<meta http-equiv="content-type" content="application/xhtml+xml" />
		<meta http-equiv="cache-control" content="max-age=300" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no" />
		<link rel="stylesheet" href="${cssPath}"/>
	</head>
	
	<body>
		<div id="wrapper">
			<%@ include file="../../../include/HeaderDisplay.jspf" %>
			<%@ include file="../../../include/BreadCrumbTrailDisplay.jspf"%>						
			
			<% ArrayList catEntryObjs = new ArrayList(); %>
			
			<c:forEach var="catEntryID" items="${sessionScope.productCompareCatentryIds}" varStatus="counter">
				<c:remove var="catEntry" />
				<wcbase:useBean id="catEntry" classname="com.ibm.commerce.catalog.beans.CatalogEntryDataBean">
					<c:set target="${catEntry}" property="catalogEntryID" value="${catEntryID}"/>
				</wcbase:useBean>
				<% catEntryObjs.add(pageContext.getAttribute("catEntry")); %>
			</c:forEach>
			<% request.setAttribute("catEntryObjs", catEntryObjs); %>
			
			<div id="product_compare_grid" class="content_box"> 
				<wcf:url var="RemoveAllFromProdCompare" value="mRemoveFromProdCompare">
					<c:forEach var="parameter" items="${WCParamValues}">
						<c:forEach var="value" items="${parameter.value}">
							<c:if test="${parameter.key != 'catEntryId'}">
								<wcf:param name="${parameter.key}" value="${value}" />
							</c:if>
						</c:forEach>
					</c:forEach>											
					<wcf:param name="clearAll" value="true"/>
				</wcf:url>	
				<div class="heading_container_with_underline">
					<h2><fmt:message key="PRODUCT_COMPARE_LIST" bundle="${storeText}"/></h2>
					<div class="skip"><span class="bullet">&#187; </span>
						<a href="${fn:escapeXml(RemoveAllFromProdCompare)}" title="<fmt:message key="PROD_CMPR_CLEAR_LIST" bundle="${storeText}"/>"><fmt:message key="PROD_CMPR_CLEAR_LIST" bundle="${storeText}"/></a>
					</div> 
					<div class="clear_float"></div> 
				</div>
				
				<c:choose>
					<c:when test="${!empty sessionScope.productCompareCatentryIds}">
						<wcbase:useBean id="catalogEntryHelper" classname="com.ibm.commerce.store.beans.CatalogEntryHelperDataBean"/>
						
						<div class="compare_grid">
							<div id="remove_links" class="grid_heading_row">
								<c:forEach var="catEntryID" items="${sessionScope.productCompareCatentryIds}" varStatus="counter">
									
									<wcf:url var="RemoveFromProdCompare" value="mRemoveFromProdCompare">
										<c:forEach var="parameter" items="${WCParamValues}">
											<c:forEach var="value" items="${parameter.value}">
												<c:if test="${parameter.key != 'catEntryId'}">
													<wcf:param name="${parameter.key}" value="${value}" />
												</c:if>
											</c:forEach>
										</c:forEach>											
										<wcf:param name="catEntryId" value="${catEntryID}"/>
									</wcf:url>
									
									<div class="grid_column"><div class="grid_column_padding">
										<span class="bullet">&#187; </span>
										<a href="${fn:escapeXml(RemoveFromProdCompare)}" title="<fmt:message key="PROD_CMPR_REMOVE" bundle="${storeText}"/>">
											<fmt:message key="PROD_CMPR_REMOVE" bundle="${storeText}"/></a>
									</div></div>
								</c:forEach> 
								<div class="clear_float"></div>
							</div>
							
							<div id="product_images" class="grid_row"> 
								<c:forEach var="catEntry" items="${requestScope.catEntryObjs}" varStatus="counter">
								
									<wcf:url var="catEntryDisplayUrl" value="mProduct2">
										<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
										<wcf:param name="storeId" value="${WCParam.storeId}"/>
										<wcf:param name="productId" value="${catEntry.catalogEntryID}"/>
										<wcf:param name="langId" value="${langId}"/>
										<wcf:param name="categoryId" value="${WCParam.categoryId}"/>
										<wcf:param name="pgGrp" value="prodComp"/>										
									</wcf:url>								
								
									<div class="grid_column"><div class="grid_column_padding">
										<a href="${fn:escapeXml(catEntryDisplayUrl)}" ><img alt="<c:out value="${catEntry.description.name}"/>" 
											src="<c:out value="${hostPath}${catEntry.objectPath}${catEntry.description.thumbNail}"/>" border="0" width="45" height="45"/></a>
									</div></div> 
								</c:forEach> 
								<div class="clear_float"></div>
							</div>

							<div id="brand">
								<div class="grid_row compare_criteria">
									<div class="grid_column"><div class="grid_column_padding"><span class="bold"><fmt:message key="PROD_CMPR_BRAND" bundle="${storeText}"/></span></div></div>
									<div class="clear_float"></div>
								</div>
								<div class="grid_row">
									<c:forEach var="catEntry" items="${requestScope.catEntryObjs}" varStatus="counter">
										<wcf:url var="catEntryDisplayUrl" value="mProduct2">
											<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
											<wcf:param name="storeId" value="${WCParam.storeId}"/>
											<wcf:param name="productId" value="${catEntry.catalogEntryID}"/>
											<wcf:param name="langId" value="${langId}"/>
											<wcf:param name="categoryId" value="${WCParam.categoryId}"/>
											<wcf:param name="pgGrp" value="prodComp"/>										
										</wcf:url>
										<div class="grid_column"><div class="grid_column_padding"><span class="bullet">&#187; </span><a href="${fn:escapeXml(catEntryDisplayUrl)}" >${catEntry.description.name}</a></div></div> 
									</c:forEach> 
									<div class="clear_float"></div>  
								</div>
							</div>

							<div id="price">
								<div  class="grid_row compare_criteria"> 
									<div class="grid_column"><div class="grid_column_padding"><span class="bold"><fmt:message key="PROD_CMPR_PRICE" bundle="${storeText}"/></span></div></div>
									<div class="clear_float"></div>
								</div>
								<div class="grid_row">
									<c:forEach var="catEntry" items="${requestScope.catEntryObjs}" varStatus="counter">
										<c:choose>
											<c:when test="${catEntry.product}">
												<%-- set the catalogEntry var to the product bean --%>
												<c:set var="catalogEntryDB2" value="${catEntry.productDataBean}"/>
												<c:set var="type" value="product"/>
											</c:when>
											<c:when test="${catEntry.item}">
												<%-- set the catalogEntry var to the item bean --%>
												<c:set var="catalogEntryDB2" value="${catEntry.itemDataBean}"/>
												<c:set var="type" value="item"/>
											</c:when>
											<c:when test="${catEntry.package}">
												<%-- set the catalogEntry var to the package bean --%>
												<c:set var="catalogEntryDB2" value="${catEntry.packageDataBean}"/>
												<c:set var="type" value="package"/>
											</c:when>
											<c:when test="${catEntry.bundle}">
												<%-- set the catalogEntry var to the bundle bean --%>
												<c:set var="catalogEntryDB2" value="${catEntry.bundleDataBean}"/>
												<c:set var="type" value="bundle"/>
											</c:when>
										</c:choose>
									
										<div class="grid_column"><div class="grid_column_padding">
											<c:set var="catalogEntryDB" value="${catalogEntryDB2}" />													
											<c:set var="displayPriceRange" value="true"/>
											<%@ include file="../../../Snippets/ReusableObjects/CatalogEntryPriceDisplay.jspf"%>									
										</div></div>
									</c:forEach> 
									<div class="clear_float"></div> 
								</div>
							</div>
							
							<div id="online_availability">
								<div class="grid_row compare_criteria"> 
									<div class="grid_column"><div class="grid_column_padding"><span class="bold"><fmt:message key="PROD_CMPR_STOCK_AVAIL" bundle="${storeText}"/></span></div></div> 
									<div class="clear_float"></div>
								</div>
								<div class="grid_row">
									<c:forEach var="catEntry" items="${requestScope.catEntryObjs}" varStatus="counter">
										<div class="grid_column"><div class="grid_column_padding">
		
											<c:choose>
												<c:when test="${catEntry.product}">
													<c:set var="entitledItems" value="${catEntry.productDataBean.entitledItems}" />
													<c:if test="${!empty entitledItems and fn:length(entitledItems) == 1}">
														<c:import url="${jspStoreDir}mobile/Snippets/Catalog/CatalogEntryDisplay/ItemAvailForProdCompare.jsp">
															<c:param name="itemId" value="${entitledItems[0].itemID}" />
															<c:param name="productId" value="${catEntry.productDataBean.productID}" />
														</c:import>
													</c:if>
												</c:when>
												<c:when test="${catEntry.item}">
													<c:import url="${jspStoreDir}mobile/Snippets/Catalog/CatalogEntryDisplay/ItemAvailForProdCompare.jsp">
														<c:param name="itemId" value="${catEntry.itemDataBean.itemID}" />
														<c:param name="productId" value="${catEntry.itemDataBean.itemID}" />
													</c:import>
												</c:when>
												<c:when test="${catEntry.package}">
													<c:import url="${jspStoreDir}mobile/Snippets/Catalog/CatalogEntryDisplay/ItemAvailForProdCompare.jsp">
														<c:param name="itemId" value="${catEntry.packageDataBean.packageID}" />
														<c:param name="productId" value="${catEntry.packageDataBean.packageID}" />
													</c:import>
												</c:when>
												<%-- 
												<c:when test="${catEntry.bundle}">
												</c:when>
												--%>
											</c:choose>														 
		
										</div></div> 
									</c:forEach> 
									<div class="clear_float"></div> 
								</div>
							</div> 
							
							<wcbase:useBean id="catalogEntryHelper" classname="com.ibm.commerce.store.beans.CatalogEntryHelperDataBean"/>
							
							<c:set var="descriptiveAttributes" value="${catalogEntryHelper.distinctDescriptiveAttributeNames}"/>
							<c:forEach var="descriptiveAttribute" items="${descriptiveAttributes}" varStatus="status">
								<div class="grid_row compare_criteria"> 
									<div class="grid_column"><div class="grid_column_padding"><span class="bold"><c:out value="${descriptiveAttribute}" escapeXml="false" /></span></div></div> 
									<div class="clear_float"></div>
								</div>
								<div class="grid_row">
									<c:forEach var="catEntID" items="${sessionScope.productCompareCatentryIds}" varStatus="counter">
										<div class="grid_column"><div class="grid_column_padding">
											<c:set property="catalogEntryId" target="${catalogEntryHelper}" value="${catEntID}"/>
											<c:set var="attributeValues" value="${catalogEntryHelper.attributeValueHashMap}"/>
											<c:if test="${!empty attributeValues[descriptiveAttribute]}">
												<c:out value="${attributeValues[descriptiveAttribute]}"  escapeXml="false" />
											</c:if>	
											<c:if test="${empty attributeValues[descriptiveAttribute]}">
												&#160;
											</c:if>	
										</div></div>
									</c:forEach>
									<div class="clear_float"></div> 
								</div> 							
							</c:forEach>
							
							<c:set var="definingAttributes" value="${catalogEntryHelper.distinctDefiningAttributeNames}"/>
							<c:forEach var="definingAttribute" items="${definingAttributes}" varStatus="status">									
								<div class="grid_row compare_criteria"> 
									<div class="grid_column"><div class="grid_column_padding"><span class="bold"><c:out value="${definingAttribute}" escapeXml="false" /></span></div></div> 
									<div class="clear_float"></div>
								</div>
								<div class="grid_row">
									<c:forEach var="catEntID" items="${sessionScope.productCompareCatentryIds}" varStatus="counter">
										<div class="grid_column"><div class="grid_column_padding">
											<c:set property="catalogEntryId" target="${catalogEntryHelper}" value="${catEntID}"/>
											<c:set var="attributeValues" value="${catalogEntryHelper.attributeValueHashMap}"/>
											<c:if test="${!empty attributeValues[definingAttribute]}">
												<c:out value="${attributeValues[definingAttribute]}"  escapeXml="false" />
											</c:if>
											<c:if test="${empty attributeValues[definingAttribute]}">
												&#160;
											</c:if>										
										</div></div>
									</c:forEach>
									<div class="clear_float"></div> 
								</div> 							
							</c:forEach>							 							
						</div>
					</c:when>
					<c:otherwise>
						<fmt:message key="PROD_CMPR_NOTHING_TO_COMP" bundle="${storeText}"/>
					</c:otherwise>
				</c:choose>
			</div>	
			<%@ include file="../../../include/FooterDisplay.jspf" %>											
		</div>
	</body>
</html>			

<!-- END ProductCompareResultGridDisplay.jsp -->
