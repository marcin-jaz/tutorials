<%
/*
 *-------------------------------------------------------------------
 * Licensed Materials - Property of IBM
 *
 * WebSphere Commerce
 *
 * (c) Copyright International Business Machines Corporation. 2000, 2004
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
  * This JSP page is used to iterate through the RFQ's products.
  *
  * Required parameters:
  * - RFQProdDataBean[] pList
  * - index - int, index of current object
  * - offeringId
  *
  *****
--%>


<%@ page language="java" %>


<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../include/JSTLEnvironmentSetup.jspf" %>


<c:set var="pList" value="${requestScope.pList}" />
<c:set var="product" value="${pList[param.index]}" />
<c:set var="currencyCode" value="${product.currency}" />

<c:set var="catid" value="${product.catentryIdInEJBType}" />
<c:set var="rfqProdId" value="${product.rfqprodIdInEJBType}" />
<c:set var="categoryId" value="${product.rfqCategryIdInEJBType}" />
<c:if test="${categoryId != null && !empty categoryId}" >
	<wcbase:useBean id="rfqCategoryAB" classname="com.ibm.commerce.rfq.beans.RFQCategryDataBean">
		<c:set target="${rfqCategoryAB}" property="initKey_rfqCategryId" value="${categoryId}" />
		
	</wcbase:useBean>
</c:if>
<c:choose>
	<c:when test="${!empty catid}" >
		<%--
		<wcbase:useBean id="catalogAB" classname="com.ibm.commerce.catalog.beans.CatalogEntryDescriptionDataBean">
			<c:set target="${catalogAB}" property="dataBeanKeyCatalogEntryReferenceNumber" value="${catid}" />
			<c:set target="${catalogAB}" property="dataBeanKeyLanguage_id" value="${langId}" />
			
			<c:set var="prodName" value="${catalogAB.name}" />
			<c:set var="shortDesc" value="${catalogAB.shortDescription}" />
		</wcbase:useBean>
		--%>
	</c:when>
	<c:otherwise>
			<c:set var="prodName" value="${product.rfqProductName}" />
		<c:if test="${prodName eq null}" >
			<fmt:message key="RFQListDisplay_MadeToOrder" bundle="${storeText}" var="prodName"/>
		</c:if>
	</c:otherwise>
</c:choose>



<c:if test="${!empty catid}">
	<wcbase:useBean id="ceDB"
		classname="com.ibm.commerce.catalog.beans.CatalogEntryDataBean">
		<c:set target="${ceDB}" property="catalogEntryID" value="${catid}" />
		
	</wcbase:useBean>

	<c:choose>
		<c:when test="${ceDB.type eq 'ItemBean'}">
			<fmt:message key="RFQModifyDisplay_Item" bundle="${storeText}" var="type"/>
			<wcbase:useBean id="itemAB" classname="com.ibm.commerce.catalog.beans.ItemDataBean">
				<c:set target="${itemAB}" property="initKey_catalogEntryReferenceNumber" value="${catid}" />
				<c:set target="${itemAB}" property="itemID" value="${catid}" />
			</wcbase:useBean> 		
			<c:set var="catalogEntryDescriptionAB" value="${itemAB.description}"/>
			<c:set var="prodName" value="${catalogEntryDescriptionAB.name}" />  
			<c:set var="shortDesc" value="${catalogEntryDescriptionAB.shortDescription}" /> 
		</c:when>
		<c:when test="${ceDB.type eq 'ProductBean'}">
			<fmt:message key="RFQModifyDisplay_Product" bundle="${storeText}" var="type"/>
			<wcbase:useBean id="productAB" classname="com.ibm.commerce.catalog.beans.ProductDataBean">
				<c:set target="${productAB}" property="initKey_catalogEntryReferenceNumber" value="${catid}" />
				<c:set target="${productAB}" property="productID" value="${catid}" />
			</wcbase:useBean> 		
			<c:set var="catalogEntryDescriptionAB" value="${productAB.description}"/>
			<c:set var="prodName" value="${catalogEntryDescriptionAB.name}" />  
			<c:set var="shortDesc" value="${catalogEntryDescriptionAB.shortDescription}" /> 
		</c:when>
		<c:when test="${ceDB.type eq 'PackageBean'}">
			<fmt:message key="RFQModifyDisplay_Prebuilt_Kit" bundle="${storeText}" var="type"/>
			<wcbase:useBean id="packAB" classname="com.ibm.commerce.catalog.beans.PackageDataBean">
				<c:set target="${packAB}" property="initKey_catalogEntryReferenceNumber" value="${catid}" />
				<c:set target="${packAB}" property="packageID" value="${catid}" />
			</wcbase:useBean> 	
			<c:set var="catalogEntryDescriptionAB" value="${packAB.description}"/>
			<c:set var="prodName" value="${catalogEntryDescriptionAB.name}" />  
			<c:set var="shortDesc" value="${catalogEntryDescriptionAB.shortDescription}" /> 
		</c:when>
		<c:when test="${ceDB.type eq 'DynamicKitBean'}">
			<fmt:message key="RFQModifyDisplay_Dynamic_Kit" bundle="${storeText}" var="type"/>
		</c:when>
		<c:when test="${ceDB.type eq 'BundleBean'}">
			<fmt:message key="RFQModifyDisplay_Bundle" bundle="${storeText}" var="type"/>
			<wcbase:useBean id="bundleAB" classname="com.ibm.commerce.catalog.beans.BundleDataBean">
				<c:set target="${bundleAB}" property="initKey_catalogEntryReferenceNumber" value="${catid}" />
				<c:set target="${bundleAB}" property="bundleID" value="${catid}" />
			</wcbase:useBean> 		
			<c:set var="catalogEntryDescriptionAB" value="${bundleAB.description}"/>
			<c:set var="prodName" value="${catalogEntryDescriptionAB.name}" />  
			<c:set var="shortDesc" value="${catalogEntryDescriptionAB.shortDescription}" /> 
		</c:when>
		<c:otherwise>
			<c:set var="type" value="${ceDB.type}" />
		</c:otherwise>
	</c:choose>
	<fmt:message key="RFQModifyDisplay_Item" bundle="${storeText}" 	var="RFQModifyDisplay_Item" />
	<fmt:message key="RFQModifyDisplay_Product"	bundle="${storeText}" var="RFQModifyDisplay_Product" />		
	<fmt:message key="RFQModifyDisplay_Dynamic_Kit"	bundle="${storeText}" var="RFQModifyDisplay_Dynamic_Kit" />
	<fmt:message key="RFQModifyDisplay_Prebuilt_Kit" bundle="${storeText}" var="RFQModifyDisplay_Prebuilt_Kit"/>
		
		
	<c:set var="offerPrice" />	

	<c:if test="${type eq RFQModifyDisplay_Item}" >
		<wcbase:useBean id="iDB"
			classname="com.ibm.commerce.catalog.beans.ItemDataBean">
			<c:set target="${iDB}" property="initKey_catalogEntryReferenceNumber" value="${catid}" />
			<c:set target="${iDB}" property="itemID" value="${catid}" />
			
		</wcbase:useBean>
		<c:set var="offerPrice" value="${iDB.standardPrice}" />
	</c:if>
	<c:if test="${type eq RFQModifyDisplay_Product}" >
		<wcbase:useBean id="pDB"
			classname="com.ibm.commerce.catalog.beans.ProductDataBean">
			<c:set target="${pDB}" property="initKey_catalogEntryReferenceNumber" value="${catid}" />
			<c:set target="${pDB}" property="productID" value="${catid}" />
			
		</wcbase:useBean>
		<c:set var="offerPrice" value="${pDB.standardPrice}" />
	</c:if>
	<c:if test="${type eq RFQModifyDisplay_Prebuilt_Kit}" >
		<wcbase:useBean id="dkDB"
			classname="com.ibm.commerce.catalog.beans.PackageDataBean">
			<c:set target="${dkDB}" property="initKey_catalogEntryReferenceNumber" value="${catid}" />
			<c:set target="${dkDB}" property="packageID" value="${catid}" />
			
		</wcbase:useBean>
		<c:set var="offerPrice" value="${dkDB.standardPrice}" />
	</c:if>
</c:if>

<c:set var="priceAdjust" value="${product.priceAdjustmentInEJBType}" />

<c:if  test="${priceAdjust eq '0.0'}" >
	<c:set var="priceAdjust" value="" />
</c:if>
<c:if  test="${!empty priceAdjust}" >
	<fmt:message key="RFQDisplay_Percentage" bundle="${storeText}" var="percentage"/>
	<fmt:formatNumber value="${priceAdjust}" var="priceAdjust" />
	<c:set var="priceAdjust" value="${priceAdjust} ${percentage}" />
</c:if>

<c:set var="changeable" value="${product.changeableInEJBType eq '1'}" />
<c:set var="unit" value="${product.qtyUnitId}" />
<c:choose>
	<c:when test="${unit != null}" >
		<wcbase:useBean id="qudb"
			classname="com.ibm.commerce.common.beans.QuantityUnitDescriptionDataBean">
			<c:set target="${qudb}" property="dataBeanKeyLanguage_id" value="${langId}" />
			<c:set target="${qudb}" property="dataBeanKeyQuantityUnitId" value="${unit}" />
			
			<c:set var="unit" value="${qudb.description}" />
		</wcbase:useBean>
	</c:when>
	<c:otherwise>
		<c:set var="unit" value="" />
	</c:otherwise>
</c:choose>
<c:set var="quantity" value="${product.formattedQuantity}" />
<c:choose>
	<c:when
		test="${type eq RFQModifyDisplay_Item or type eq RFQModifyDisplay_Product or type eq RFQModifyDisplay_Prebuilt_Kit }">
		<c:url var="RFQProductDisplayHref" value="RFQProductDisplay">
			<c:param name="offering_id" value="${param.offeringId}" />
			
			<c:param name="rfqprod_id" value="${rfqProdId}" />
			<c:param name="langId" value="${langId}" />
			<c:param name="storeId" value="${storeId}" />
			<c:param name="catalogId" value="${catalogId}" />
		</c:url>
	<td headers="d1" class="t_td" id="WC_RFQDisplay_Product_Unit_Row_TableCell_1_<c:out value="${param.index + 1}" />"><a
		href="<c:out value="${RFQProductDisplayHref}" />"
		id="WC_RFQDisplay_Link_9_<c:out value="${param.index + 1}" />"><c:out
		value="${prodName}" /></a></td>
</c:when>
<c:when test="${type eq RFQModifyDisplay_Dynamic_Kit}">
	<c:url var="RFQDynamicKitComponentListDisplayHref"
		value="RFQDynamicKitComponentListDisplay">
		<c:param name="rfqprod_id" value="${rfqProdId}" />
		<c:param name="offering_id" value="${param.offeringId}" />
		<c:param name="catentryid" value="${catid}" />
		<c:param name="langId" value="${langId}" />
		<c:param name="storeId" value="${storeId}" />
		<c:param name="catalogId" value="${catalogId}" />
	</c:url>
		<td headers="d1" class="t_td" id="WC_RFQDisplay_Product_Unit_Row_TableCell_2_<c:out value="${param.index + 1}" />"><a
			href="<c:out value="${RFQDynamicKitComponentListDisplayHref}" />"
			id="WC_RFQModifyDisplay_Link_14_<c:out value="${param.index + 1}" />"><c:out
			value="${prodName}" /></a></td>
	</c:when>
	<c:otherwise>
		<td headers="d1" class="t_td" id="WC_RFQDisplay_Product_Unit_Row_TableCell_3_<c:out value="${param.index + 1}" />"><c:out
			value="${prodName}" /></td>
	</c:otherwise>
</c:choose>


<td headers="d2" class="t_td" id="WC_RFQDisplay_Product_Unit_Row_TableCell_4_<c:out value="${param.index + 1}" />">
	<c:out value="${shortDesc}" />&nbsp;</td>
<td headers="d3" class="t_td" id="WC_RFQDisplay_Product_Unit_Row_TableCell_5_<c:out value="${param.index + 1}" />">
<c:choose>
	<c:when test="${rfqCategoryAB != null}">
		<c:out value="${rfqCategoryAB.name}" />
	</c:when>
	<c:otherwise>
		<fmt:message key="RFQExtra_NotCategorized"
			bundle="${storeText}" />
	</c:otherwise>
</c:choose></td>


<td headers="d4" class="t_td" id="WC_RFQDisplay_Product_Unit_Row_TableCell_6_<c:out value="${param.index + 1}" />"><c:out
	value="${type}" /></td>
<c:choose>
	<c:when test="${offerPrice != null}">
		<td headers="d5" class="t_td" id="WC_RFQDisplay_Product_Unit_Row_TableCell_7_<c:out value="${param.index + 1}" />" class="price"><c:out
			value="${offerPrice}" escapeXml="false" /></td>
	</c:when>
	<c:otherwise>
		<td headers="d5" class="t_td" id="WC_RFQDisplay_Product_Unit_Row_TableCell_8_<c:out value="${param.index + 1}" />">&nbsp;
		</td>
	</c:otherwise>
</c:choose>

<!--add Percentage Adjustment column if RFQ is intended for contract-->
<td width="100" headers="d6" class="t_td" id="WC_RFQDisplay_Product_Unit_Row_TableCell_9_<c:out value="${param.index + 1}" />"
	align="center"><c:out value="${priceAdjust}" /></td>
<td headers="d7" class="t_td" id="WC_RFQDisplay_Product_Unit_Row_TableCell_10_<c:out value="${param.index + 1}" />" class="price"><c:out
	value="${product.formattedProductPrice}" escapeXml="false" />&nbsp;</td>
<td headers="d8" class="t_td" id="WC_RFQDisplay_Product_Unit_Row_TableCell_11_<c:out value="${param.index + 1}" />"><c:out
	value="${currencyCode}" /></td>
<td headers="d9" class="t_td" id="WC_RFQDisplay_Product_Unit_Row_TableCell_12_<c:out value="${param.index + 1}" />"><c:out
	value="${quantity}" />&nbsp;</td>
<td headers="d10" class="t_td" id="WC_RFQDisplay_Product_Unit_Row_TableCell_13_<c:out value="${param.index + 1}" />"><c:out
	value="${unit}" />&nbsp;</td>
<c:choose>
	<c:when test="${changeable}">
		<td headers="d11" class="t_td" id="WC_RFQDisplay_Product_Unit_Row_TableCell_14_<c:out value="${param.index + 1}" />"><fmt:message
			key="RFQModifyAddCommentDisplay_Yes" bundle="${storeText}" /></td>
	</c:when>
	<c:otherwise>
		<td headers="d11" class="t_td" id="WC_RFQDisplay_Product_Unit_Row_TableCell_15_<c:out value="${param.index + 1}" />"><fmt:message
			key="RFQModifyAddCommentDisplay_No" bundle="${storeText}" /></td>
	</c:otherwise>
</c:choose>



			
