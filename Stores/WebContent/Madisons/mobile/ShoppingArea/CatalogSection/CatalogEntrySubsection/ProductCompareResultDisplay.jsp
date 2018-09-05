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

<!-- BEGIN ProductCompareResultDisplay.jsp -->

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>

<%@ include file="../../../../include/parameters.jspf" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf" %>

<%-- For breadcrumb support --%>
<c:set var="prodComparePageGroup" value="true" scope="request" />
<c:set var="prodComparePage" value="true" scope="request" />

<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.2//EN" "http://www.openmobilealliance.org/tech/DTD/xhtml-mobile12.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" lang="${shortLocale}" xml:lang="${shortLocale}">
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
			
			<div id="product_compare_list" class="content_box">
				<div class="heading_container_with_underline">
					<h2><fmt:message key="PRODUCT_COMPARE_LIST" bundle="${storeText}"/></h2>
					<div class="clear_float"></div>
				</div>
				
				<wcf:url var="RemoveAllFromProdCompare" value="mRemoveFromProdCompare">
					<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
					<wcf:param name="storeId" value="${WCParam.storeId}"/>
					<wcf:param name="clearAll" value="true"/>
				</wcf:url>												
				
				
				<div class="skip"><span class="bullet">&#187; </span>
				<a href="${fn:escapeXml(RemoveAllFromProdCompare)}" title="<fmt:message key="PROD_CMPR_CLEAR_LIST" bundle="${storeText}"/>"><fmt:message key="PROD_CMPR_CLEAR_LIST" bundle="${storeText}"/></a></div>

				<c:choose>
					<c:when test="${!empty sessionScope.productCompareCatentryIds}">
						<wcbase:useBean id="catalogEntryHelper" classname="com.ibm.commerce.store.beans.CatalogEntryHelperDataBean"/>
						<ol>
							<c:forEach var="catEntryID" items="${sessionScope.productCompareCatentryIds}" varStatus="counter">
							
								<wcf:url var="RemoveFromProdCompare" value="mRemoveFromProdCompare">
									<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
									<wcf:param name="storeId" value="${WCParam.storeId}"/>
									<wcf:param name="catEntryId" value="${catEntryID}"/>
								</wcf:url>												
							
								<li class="entry">								
									<wcf:url var="catEntryDisplayUrl" value="mProduct2">
										<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
										<wcf:param name="storeId" value="${WCParam.storeId}"/>
										<wcf:param name="productId" value="${catEntryID}"/>
										<wcf:param name="langId" value="${langId}"/>
										<wcf:param name="categoryId" value="${WCParam.categoryId}"/>
										<wcf:param name="pgGrp" value="prodComp"/>										
									</wcf:url>								
								
									<c:remove var="catEntry"/>
									<wcbase:useBean id="catEntry" classname="com.ibm.commerce.catalog.beans.CatalogEntryDataBean">
										<c:set target="${catEntry}" property="catalogEntryID" value="${catEntryID}"/>
									</wcbase:useBean>
									
									<c:choose>
										<c:when test="${catEntry.product}">
											<%-- set the catalogEntry var to the product bean --%>
											<c:set var="catalogEntry2" value="${catEntry.productDataBean.productID}"/>
											<c:set var="catalogEntryDB2" value="${catEntry.productDataBean}"/>
											<c:set var="type" value="product"/>
										</c:when>
										<c:when test="${catEntry.item}">
											<%-- set the catalogEntry var to the item bean --%>
											<c:set var="catalogEntry2" value="${catEntry.itemDataBean.itemID}"/>
											<c:set var="catalogEntryDB2" value="${catEntry.itemDataBean}"/>
											<c:set var="type" value="item"/>
										</c:when>
										<c:when test="${catEntry.package}">
											<%-- set the catalogEntry var to the package bean --%>
											<c:set var="catalogEntry2" value="${catEntry.packageDataBean.packageID}"/>
											<c:set var="catalogEntryDB2" value="${catEntry.packageDataBean}"/>
											<c:set var="type" value="package"/>
										</c:when>
										<c:when test="${catEntry.bundle}">
											<%-- set the catalogEntry var to the bundle bean --%>
											<c:set var="catalogEntry2" value="${catEntry.bundleDataBean.bundleID}"/>
											<c:set var="catalogEntryDB2" value="${catEntry.bundleDataBean}"/>
											<c:set var="type" value="bundle"/>
										</c:when>
									</c:choose>
																		
									<ul>
										<li><a href="${fn:escapeXml(catEntryDisplayUrl)}" ><img alt="<c:out value="${catEntry.description.name}"/>" 
											src="<c:out value="${hostPath}${catEntry.objectPath}${catEntry.description.thumbNail}"/>" border="0" width="45" height="45"/></a></li>
										
										<li><fmt:message key="PROD_CMPR_DESCRIPTION" bundle="${storeText}"/>: <span class="bullet">&#187; </span><a href="${fn:escapeXml(catEntryDisplayUrl)}" title="<c:out value="${catEntry.description.name}"/> ">${catEntry.description.name}</a></li>
										<li><fmt:message key="PROD_CMPR_BRAND" bundle="${storeText}"/>: ${catEntry.manufacturerName}</li>

										<li>
											<fmt:message key="PROD_CMPR_PRICE" bundle="${storeText}"/>
											<c:set var="catalogEntryDB" value="${catalogEntryDB2}" />													
											<c:set var="displayPriceRange" value="true"/>
											<%@ include file="../../../Snippets/ReusableObjects/CatalogEntryPriceDisplay.jspf"%>
										</li>
											
										<li><fmt:message key="PROD_CMPR_ONLINE_AVAIL" bundle="${storeText}"/>: In Stock</li>
										<c:set var="descriptiveAttributes" value="${catalogEntryHelper.distinctDescriptiveAttributeNames}"/>
										<c:forEach var="descriptiveAttribute" items="${descriptiveAttributes}" varStatus="status">								
											<li>
												<c:out value="${descriptiveAttribute}" escapeXml="false" />: 
												<c:set property="catalogEntryId" target="${catalogEntryHelper}" value="${catEntryID}"/>
												<c:set var="attributeValues" value="${catalogEntryHelper.attributeValueHashMap}"/>
												<c:if test="${!empty attributeValues[descriptiveAttribute]}">
													<c:out value="${attributeValues[descriptiveAttribute]}"  escapeXml="false" />
												</c:if>													
											</li>
										</c:forEach>
										<c:set var="definingAttributes" value="${catalogEntryHelper.distinctDefiningAttributeNames}"/>
										<c:forEach var="definingAttribute" items="${definingAttributes}" varStatus="status">									
											<li>
												<c:out value="${definingAttribute}" escapeXml="false" />: 
												<c:set property="catalogEntryId" target="${catalogEntryHelper}" value="${catEntryID}"/>
												<c:set var="attributeValues" value="${catalogEntryHelper.attributeValueHashMap}"/>
												<c:if test="${!empty attributeValues[definingAttribute]}">
													<c:out value="${attributeValues[definingAttribute]}"  escapeXml="false" />
												</c:if>
											</li>									
										</c:forEach>
										<li><span class="bullet">&#187; </span><a href="${fn:escapeXml(RemoveFromProdCompare)}" title="<fmt:message key="PROD_CMPR_REMOVE" bundle="${storeText}"/>">
											<fmt:message key="PROD_CMPR_REMOVE" bundle="${storeText}"/></a></li>
									</ul>
									
	 								<div class="clear_float"></div>						 
								</li>									
							</c:forEach>					
						</ol>
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

<!-- END ProductCompareResultDisplay.jsp -->
