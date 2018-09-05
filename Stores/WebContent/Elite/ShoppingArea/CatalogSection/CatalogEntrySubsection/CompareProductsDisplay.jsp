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
  * This JSP file renders the compare products page. It shows up to 4 products side-by-side showing comparisons
  * of price, brand, and all of its attributes.
  *****
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ taglib uri="http://commerce.ibm.com/coremetrics"  prefix="cm" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf" %>
<%@ include file="../../../include/nocache.jspf"%>

<c:set var="compareProductPage" value="true" scope="request"/>
<c:set var="hasBreadCrumbTrail" value="true" scope="request"/>
<c:set var="useHomeRightSidebar" value="true" scope="request"/>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"
xmlns:wairole="http://www.w3.org/2005/01/wai-rdf/GUIRoleTaxonomy#"
xmlns:waistate="http://www.w3.org/2005/07/aaa" lang="${shortLocale}" xml:lang="${shortLocale}">
<head>
<title><c:out value="${storeName}"/> - <fmt:message key="COMPARE_PAGE_TITLE" bundle="${storeText}"/></title>
<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${vfileStylesheet}"/>" type="text/css"/>
<!--[if lte IE 6]>
<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${vfileStylesheetie}"/>" type="text/css"/>
<![endif]-->
<script type="text/javascript" src="<c:out value="${dojoFile}"/>" djConfig="${dojoConfigParams}"></script>
<%@ include file="../../../include/CommonJSToInclude.jspf"%>
<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/CatalogArea/CategoryDisplay.js"/>"></script>
<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/MessageHelper.js"/>"></script>
<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/CatalogArea/CompareProduct.js"/>"></script>
<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/ServicesDeclaration.js"/>"></script>
<script type="text/javascript">
	dojo.addOnLoad(function() { 
		<fmt:message key="ERR_RESOLVING_SKU" bundle="${storeText}" var="ERR_RESOLVING_SKU" />
		<fmt:message key="QUANTITY_INPUT_ERROR" bundle="${storeText}" var="QUANTITY_INPUT_ERROR" />
		<fmt:message key="WISHLIST_ADDED" bundle="${storeText}" var="WISHLIST_ADDED" />
		<fmt:message key="SHOPCART_ADDED" bundle="${storeText}" var="SHOPCART_ADDED" />
		<fmt:message key="ERROR_MESSAGE_TYPE" bundle="${storeText}" var="ERROR_MESSAGE_TYPE" />
		<fmt:message key="ERROR_CONTRACT_EXPIRED_GOTO_ORDER" bundle="${storeText}" var="ERROR_CONTRACT_EXPIRED_GOTO_ORDER" />
		<fmt:message key="GENERICERR_MAINTEXT" bundle="${storeText}" var="ERROR_RETRIEVE_PRICE">                                     
			<fmt:param><fmt:message key="GENERICERR_CONTACT_US" bundle="${storeText}" /></fmt:param>
		</fmt:message>
		
		MessageHelper.setMessage("ERROR_RETRIEVE_PRICE", <wcf:json object="${ERROR_RETRIEVE_PRICE}"/>);
		MessageHelper.setMessage("ERR_RESOLVING_SKU", <wcf:json object="${ERR_RESOLVING_SKU}"/>);
		MessageHelper.setMessage("QUANTITY_INPUT_ERROR", <wcf:json object="${QUANTITY_INPUT_ERROR}"/>);
		MessageHelper.setMessage("WISHLIST_ADDED", <wcf:json object="${WISHLIST_ADDED}"/>);
		MessageHelper.setMessage("SHOPCART_ADDED", <wcf:json object="${SHOPCART_ADDED}"/>);
		MessageHelper.setMessage("ERROR_MESSAGE_TYPE", <wcf:json object="${ERROR_MESSAGE_TYPE}"/>);
		MessageHelper.setMessage("ERROR_CONTRACT_EXPIRED_GOTO_ORDER", <wcf:json object="${ERROR_CONTRACT_EXPIRED_GOTO_ORDER}"/>);
		categoryDisplayJS.setCommonParameters('${WCParam.langId}','${WCParam.storeId}','${WCParam.catalogId}','${userType}');
		ServicesDeclarationJS.setCommonParameters('${WCParam.langId}','${WCParam.storeId}','${WCParam.catalogId}');
		compareProductJS.setCommonParameters('${WCParam.langId}','${WCParam.storeId}','${WCParam.catalogId}');
	});
</script>
</head>

<body>

<%@ include file="../../../include/StoreCommonUtilities.jspf"%>

<!-- Page Start -->
<div id="page">
	<%@ include file="../../../include/LayoutContainerTop.jspf"%>
	<%@ include file="../../../Snippets/ReusableObjects/CatalogEntryQuickInfoDetails.jspf" %>
	
  	<!-- Main Content Start -->
  	<div id="content_wrapper_box">
    	<!-- Content Start -->
    	<div id="content588">
			<div id="MessageArea" >
				<br />
				<span id="ErrorMessageText" class="error_msg" tabindex="-1">
					
				</span>
				<br /><br />  
			</div>    	
			<h1><fmt:message key="COMPARE_PAGE_TITLE" bundle="${storeText}"/></h1>
		    <div id="box">
		    	<div class="contentgrad_header" id="WC_CompareProductsDisplay_div_1">
		        	<div class="left_corner" id="WC_CompareProductsDisplay_div_2"></div>
		          	<div class="left" id="WC_CompareProductsDisplay_div_3"><span class="text"><fmt:message key="COMPARE_PRODUCT_TITLE" bundle="${storeText}"/></span></div>
		         	<div class="right_corner" id="WC_CompareProductsDisplay_div_4"></div>
		          	<br clear="all" />
		        </div>
		        <div class="body588" id="WC_CompareProductsDisplay_div_5">
			        <div class="static_pages_line" id="WC_CompareProductsDisplay_div_6"></div>
			        <div id="compare_body">
			        	<c:forEach var="parameter" items="${WCParamValues}" >
							<c:if test="${parameter.key == 'catentryId'}">
									<c:set var="catEntryIDs" value="${parameter.value}"/>
							</c:if>
						</c:forEach>
						<c:if test="${!empty catEntryIDs}">
							<table id ="compare_details" border="0" cellspacing="0" cellpadding="0" style="border-collapse: collapse">
								
								      <jsp:useBean id="catEntryMap" class="java.util.HashMap" scope="request"/>
									<jsp:useBean id="priceMap" class="java.util.HashMap" scope="request"/>
									<jsp:useBean id="brandMap" class="java.util.HashMap" scope="request"/>
									<jsp:useBean id="descriptionMap" class="java.util.HashMap" scope="request"/>
									<c:forEach var="catEntryID" items="${catEntryIDs}" varStatus="counter">

										<wcbase:useBean id="catEntry" classname="com.ibm.commerce.catalog.beans.CatalogEntryDataBean">
											<c:set target="${catEntry}" property="catalogEntryID" value="${catEntryID}"/>
										</wcbase:useBean>

										<c:choose>
											<c:when test="${catEntry.product}">
												<%-- set the catalogEntry var to the product bean --%>
												<c:set var="catalogEntry2" value="${catEntry.productDataBean.productID}"/>
												<c:set var="catalogEntryDB2" value="${catEntry.productDataBean}"/>
											</c:when>
											<c:when test="${catEntry.item}">
												<%-- set the catalogEntry var to the item bean --%>
												<c:set var="catalogEntry2" value="${catEntry.itemDataBean.itemID}"/>
												<c:set var="catalogEntryDB2" value="${catEntry.itemDataBean}"/>
											</c:when>
											<c:when test="${catEntry.package}">
												<%-- set the catalogEntry var to the package bean --%>
												<c:set var="catalogEntry2" value="${catEntry.packageDataBean.packageID}"/>
												<c:set var="catalogEntryDB2" value="${catEntry.packageDataBean}"/>
											</c:when>
											<c:when test="${catEntry.bundle}">
												<%-- set the catalogEntry var to the bundle bean --%>
												<c:set var="catalogEntry2" value="${catEntry.bundleDataBean.bundleID}"/>
												<c:set var="catalogEntryDB2" value="${catEntry.bundleDataBean}"/>
											</c:when>
										</c:choose>																					

										<c:set target="${catEntryMap}" property="${catEntryID}" value="${catEntry}"/>	
										<c:set target="${priceMap}" property="${catalogEntry2}" value="${catalogEntryDB2.calculatedContractPrice.amount}"/>
										<c:set target="${brandMap}" property="${catEntryID}" value="${catEntry.manufacturerName}"/>
										<c:set target="${descriptionMap}" property="${catEntryID}" value="${catEntry.description.name}"/>

										<c:remove var="catEntry"/>

									</c:forEach>

								<tr>
									<td class="feature" id="WC_CompareProductsDisplay_td_1">&nbsp;</td>
									<c:forEach var="catEntryID" items="${catEntryIDs}" varStatus="counter">
										<c:forEach var="catEntrys" items="${catEntryMap}">
												<c:if test="${catEntrys.key == catEntryID}">
													<c:set var="catEntry" value="${catEntrys.value}"/>													
												</c:if>
										</c:forEach>
										<td id="WC_CompareProductsDisplay_td_2_${counter.count}"><a href="javaScript: compareProductJS.remove('${catEntryID}');" id="WC_CompareProductsDisplay_link_1_${counter.count}"><img src="<c:out value="${jspStoreImgDir}${vfileColor}" />table_x_delete.png" alt="<c:out value="${catEntry.description.name}" />" /><fmt:message key='COMPARE_REMOVE' bundle='${storeText}'/></a></td>
										
									</c:forEach>
								</tr>
								<tr>
									<td class="feature" id="WC_CompareProductsDisplay_td_3"><fmt:message key='COMPARE_PRODUCT_IMAGE' bundle='${storeText}'/></td>
									
									<c:forEach var="catEntryID" items="${catEntryIDs}" varStatus="counter">
										<c:forEach var="catEntrys" items="${catEntryMap}">
												<c:if test="${catEntrys.key == catEntryID}">
													<c:set var="catEntry" value="${catEntrys.value}"/>
													<c:set var="catEntryIdentifier" value="${catEntry.catalogEntryID}"/>
												</c:if>
										</c:forEach>
										<c:set var="pageView" value="imageForCompare"/>
										<c:set var="prefix" value="compare"/>
										<%@ include file="../../../Snippets/ReusableObjects/CatalogEntryDBThumbnailDisplay.jspf" %>
									</c:forEach>
								</tr>
								<tr>
									<td class="feature" id="WC_CompareProductsDisplay_td_4"><fmt:message key='PRODUCT_TITLE' bundle='${storeText}'/></td>
									<c:forEach var="catEntryID" items="${catEntryIDs}" varStatus="status">
										<td id="WC_CompareProductsDisplay_td_5_${status.count}">
											<c:forEach var="desc" items="${descriptionMap}">
												<c:if test="${desc.key == catEntryID}">
													<%-- The URL that links to the display page --%>
													<wcf:url var="catEntryDisplayUrl" value="Product2">
													    <wcf:param name="catalogId" value="${WCParam.catalogId}"/>
													    <wcf:param name="storeId" value="${WCParam.storeId}"/>
													    <wcf:param name="productId" value="${catEntryID}"/>
													    <wcf:param name="langId" value="${langId}"/>
													    <wcf:param name="errorViewName" value="ProductDisplayErrorView"/>
														<wcf:param name="categoryId" value="${WCParam.categoryId}" />
													</wcf:url>
													<span><a href="<c:out value="${catEntryDisplayUrl}"/>"><c:out value="${desc.value}"/></a></span>
												</c:if>
											</c:forEach>
										</td>
									</c:forEach>
								</tr>
								<tr>
									<td class="feature" id="WC_CompareProductsDisplay_td_6"><fmt:message key="COMPARE_PRODUCT_PRICE" bundle="${storeText}"/></td>
									<c:forEach var="catEntryID" items="${catEntryIDs}" varStatus="status">
										<td class="price" id="WC_CompareProductsDisplay_td_7_${status.count}">
											<c:set var="executeExtensionFragment" value="false"/>
											<%@ include file="CompareProductsDisplayExt.jspf"%>
											<c:if test="${!executeExtensionFragment}">
												<c:forEach var="priceEntry" items="${priceMap}">
													<c:if test="${priceEntry.key == catEntryID}">
														<fmt:formatNumber value="${priceEntry.value}" type="currency" currencySymbol="${currencyFormatterDB.currencySymbol}" maxFractionDigits="${currencyDecimal}"/>
													</c:if>
												</c:forEach>
											</c:if>
										</td>
									</c:forEach>
								</tr>
								<tr>
									<td class="feature" id="WC_CompareProductsDisplay_td_8"><fmt:message key="COMPARE_PRODUCT_BRAND" bundle="${storeText}"/></td>
									<c:forEach var="catEntryID" items="${catEntryIDs}" varStatus="status">
										<td id="WC_CompareProductsDisplay_td_9_${status.count}">
											<c:forEach var="brandEntry" items="${brandMap}">
												<c:if test="${brandEntry.key == catEntryID}">
													<c:out value="${brandEntry.value}" escapeXml="false"/>
												</c:if>
											</c:forEach>
										</td>
									</c:forEach>
								</tr>
								<wcbase:useBean id="catalogEntryHelper" classname="com.ibm.commerce.store.beans.CatalogEntryHelperDataBean"/>
								<c:set var="featureNames" value="${catalogEntryHelper.distinctFeatureNames}"/>
								<c:forEach var="featureName" items="${featureNames}" varStatus="status">
									<tr>
										<td class="feature" id="WC_CompareProductsDisplay_td_10_${status.count}"><c:out value="${featureName}" escapeXml="false" /></td>
										<c:forEach var="catEntryID" items="${catEntryIDs}" varStatus="status2">
											<c:set property="catalogEntryId" target="${catalogEntryHelper}" value="${catEntryID}"/>
											<c:set var="attributeValues" value="${catalogEntryHelper.attributeValueHashMap}"/>
											<c:choose>
												<c:when test="${!empty attributeValues[featureName]}">
													<td id="WC_CompareProductsDisplay_td_11_${status.count}_${status2.count}"><img src="<c:out value="${jspStoreImgDir}${vfileColor}" />i_checkmark.png" alt="<fmt:message key="COMPARE_CHECKMARK_IMAGE" bundle="${storeText}"/>" border="0"/></td>
												</c:when>
												<c:otherwise>
													<td id="WC_CompareProductsDisplay_td_12_${status.count}_${status2.count}">&nbsp;</td>
												</c:otherwise>
											</c:choose>
										</c:forEach>
									</tr>
								</c:forEach>
								<c:set var="descriptiveAttributes" value="${catalogEntryHelper.distinctDescriptiveAttributeNames}"/>
								<c:forEach var="descriptiveAttribute" items="${descriptiveAttributes}" varStatus="status">
									<tr>
										<td class="feature" id="WC_CompareProductsDisplay_td_13_${status.count}"><c:out value="${descriptiveAttribute}" escapeXml="false" /></td>
										<c:forEach var="catEntryID" items="${catEntryIDs}" varStatus="status2">
											<c:set property="catalogEntryId" target="${catalogEntryHelper}" value="${catEntryID}"/>
											<c:set var="attributeValues" value="${catalogEntryHelper.attributeValueHashMap}"/>
											<c:choose>
												<c:when test="${!empty attributeValues[descriptiveAttribute]}">
													<td id="WC_CompareProductsDisplay_td_14_${status.count}_${status2.count}">
														<c:choose>
															<c:when test="${attributeValues[descriptiveAttribute] == descriptiveAttribute}">
																<img src="<c:out value="${jspStoreImgDir}${vfileColor}" />i_checkmark.png" alt="<fmt:message key="COMPARE_CHECKMARK_IMAGE" bundle="${storeText}"/>" border="0"/>
															</c:when>
															<c:otherwise>
																<c:out value="${attributeValues[descriptiveAttribute]}" />
															</c:otherwise>
														</c:choose>
													</td>
												</c:when>
												<c:otherwise>
													<td id="WC_CompareProductsDisplay_td_15_${status.count}_${status2.count}">&nbsp;</td>
												</c:otherwise>
											</c:choose>
										</c:forEach>
									</tr>
								</c:forEach>
								<c:set var="definingAttributes" value="${catalogEntryHelper.distinctDefiningAttributeNames}"/>
								<c:forEach var="definingAttribute" items="${definingAttributes}" varStatus="status">
									<tr>
										<td class="feature" id="WC_CompareProductsDisplay_td_16_${status.count}"><c:out value="${definingAttribute}" escapeXml="false" /></td>
										<c:forEach var="catEntryID" items="${catEntryIDs}" varStatus="status2">
											<c:set property="catalogEntryId" target="${catalogEntryHelper}" value="${catEntryID}"/>
											<c:set var="attributeValues" value="${catalogEntryHelper.attributeValueHashMap}"/>
											<c:choose>
												<c:when test="${!empty attributeValues[definingAttribute]}">
													<td id="WC_CompareProductsDisplay_td_17_${status.count}_${status2.count}"><c:out value="${attributeValues[definingAttribute]}" /></td>
												</c:when>
												<c:otherwise>
														<td id="WC_CompareProductsDisplay_td_18_${status.count}_${status2.count}">&nbsp;</td> 
												</c:otherwise>
											</c:choose>
										</c:forEach>
									</tr>
								</c:forEach>
								<tr>
									<td class="last_row" id="WC_CompareProductsDisplay_td_19">&nbsp;</td>
									<c:forEach var="catEntryID" items="${catEntryIDs}" varStatus="counter">
										<td class="last_row" id="WC_CompareProductsDisplay_td_20_${counter.count}">&nbsp;</td>
									</c:forEach>
								</tr>
							</table>
						</c:if>
						<c:if test="${empty catEntryIDs}">  
		        			<div id="WC_CompareProductsDisplay_div_7">&nbsp;</div>
		        		 		<fmt:message key='COMPARE_PRODUCT_EMPTY' bundle='${storeText}'/>
		        		 	<div id="WC_CompareProductsDisplay_div_8">&nbsp;</div>
		        		</c:if>
		          	</div>   
		        </div>
        		<div class="footer" id="WC_CompareProductsDisplay_div_9">
          		<div class="left_corner" id="WC_CompareProductsDisplay_div_10"></div>
          		<div class="left" id="WC_CompareProductsDisplay_div_11"></div>
          		<div class="right_corner" id="WC_CompareProductsDisplay_div_12"></div>
        	</div>
          	<input id="compareProductPage" name="compareProductPage" type="hidden" value="<c:out value='${compareProductPage}'/>" />
      	</div>
      	<!-- Content End -->
    </div>
    <!-- Main Content End -->
      
</div>
<!-- Page End -->
	<%@ include file="../../../include/LayoutContainerBottom.jspf"%>
</div>
<div id="page_shadow" class="shadow"></div>
<flow:ifEnabled feature="Analytics"><cm:pageview/></flow:ifEnabled>
</body>
</html>
