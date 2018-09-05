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
  * This JSP page is used to iterate through all RFQ products associated
  * with a specific RFQ category.
  *
  * Required parameters:
  * - pList
  * - index - int, index of current object
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
<c:set var="rfqprodId" value="${product.rfqprodIdInEJBType}" />
<c:set var="categoryId" value="${product.rfqCategryIdInEJBType}" />


<c:choose>
	<c:when test="${catid != null and catid != ''}" >
		<wcbase:useBean id="catalogAB" classname="com.ibm.commerce.catalog.beans.CatalogEntryDescriptionDataBean">
			<c:set target="${catalogAB}" property="dataBeanKeyCatalogEntryReferenceNumber" value="${catid}" />
			<c:set target="${catalogAB}" property="dataBeanKeyLanguage_id" value="${langId}" />
			<c:set var="prodName" value="${catalogAB.name}" />
			<c:set var="shortDesc" value="${catalogAB.shortDescription}" />
		</wcbase:useBean>
	</c:when>
	<c:otherwise>
			<c:set var="prodName" value="${product.rfqProductName}" />
		<c:if test="${prodName eq null}" >
			<fmt:message key="RFQListDisplay_MadeToOrder" bundle="${storeText}" var="prodName"/>
		</c:if>
	</c:otherwise>
</c:choose>

<c:set var="unit" value="${product.qtyUnitId}" />
<c:choose>
	<c:when test="${unit != null}" >
		<wcbase:useBean id="qudb" classname="com.ibm.commerce.common.beans.QuantityUnitDescriptionDataBean">
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


<c:if test="${!empty catid}">
	<wcbase:useBean id="ceDB"
		classname="com.ibm.commerce.catalog.beans.CatalogEntryDataBean">
		<c:set target="${ceDB}" property="catalogEntryID" value="${catid}" />
		
	</wcbase:useBean>

	<c:choose>
		<c:when test="${ceDB.type eq 'ItemBean'}">
			<fmt:message key="RFQModifyDisplay_Item" bundle="${storeText}" var="type"/>
		</c:when>
		<c:when test="${ceDB.type eq 'ProductBean'}">
			<fmt:message key="RFQModifyDisplay_Product" bundle="${storeText}" var="type"/>
		</c:when>
		<c:when test="${ceDB.type eq 'PackageBean'}">
			<fmt:message key="RFQModifyDisplay_Prebuilt_Kit" bundle="${storeText}" var="type"/>
		</c:when>
		<c:when test="${ceDB.type eq 'DynamicKitBean'}">
			<fmt:message key="RFQModifyDisplay_Dynamic_Kit" bundle="${storeText}" var="type"/>
		</c:when>
		<c:otherwise>
			<c:set var="type" value="${ceDB.type}" />
		</c:otherwise>
	</c:choose>
	<fmt:message key="RFQModifyDisplay_Item"
		bundle="${storeText}" 
		var="RFQModifyDisplay_Item" />
	<fmt:message key="RFQModifyDisplay_Product"
		bundle="${storeText}" 
		var="RFQModifyDisplay_Product" />
	<fmt:message key="RFQModifyDisplay_Dynamic_Kit"
		bundle="${storeText}" 
		var="RFQModifyDisplay_Dynamic_Kit" />
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
			
			<c:set var="offerPrice" value="${pDB.standardPrice}" />
		</wcbase:useBean>
	</c:if> 
	<c:if test="${type eq RFQModifyDisplay_Prebuilt_Kit}" >
		<wcbase:useBean id="dkDB"
			classname="com.ibm.commerce.catalog.beans.PackageDataBean">
			<c:set target="${dkDB}" property="initKey_catalogEntryReferenceNumber" value="${catid}" />
			<c:set target="${dkDB}" property="packageID" value="${catid}" />
			
			<c:set var="offerPrice" value="${dkDB.standardPrice}" />
		</wcbase:useBean>
	</c:if>
</c:if>


<c:set var="priceAdjust" value="" />
<c:set var="priceAdjust" value="${product.priceAdjustmentInEJBType}" />
<fmt:formatNumber value="${priceAdjust}" var="priceAdjust" /> 
<c:if  test="${product.priceAdjustmentInEJBType > 0}" >
	<fmt:message key="RFQDisplay_Percentage" bundle="${storeText}" var="percentage"/>
	  
	<c:set var="priceAdjust" value="${priceAdjust} ${percentage}" />
</c:if>
<c:set var="price" value="${product.formattedProductPrice}" />
<c:set var="quantity" value="${product.formattedQuantity}" />
<c:set var="changeable" value="${product.changeableInEJBType eq '1'}" />

	<c:choose>
		<c:when test="${type eq RFQModifyDisplay_Item or type eq RFQModifyDisplay_Product}">
			<c:url var="RFQProductDisplayHref" value="RFQProductDisplay">
				<c:param name="offering_id" value="${param.rfqId}" />
				<c:param name="rfqprod_id" value="${rfqprodId}" />
				<c:param name="langId" value="${langId}" />
				<c:param name="storeId" value="${storeId}" />
				<c:param name="catalogId" value="${catalogId}" />
			</c:url>
			<td headers="a1" class="t_td" id="WC_RFQCategoryDisplay_ProductInfo_Row_TableCell_1b<c:out value="${param.index + 1}" />">
				<a href="<c:out value="${RFQProductDisplayHref}" />" id="WC_RFQDisplay_Link_9_<c:out value="${param.index + 1}" />">
					<c:out value="${prodName}" />
				</a>
			</td>
		</c:when>
		
		<c:when test="${type eq RFQModifyDisplay_Dynamic_Kit}">
			<c:url var="RFQDynamicKitComponentListDisplayHref" value="RFQDynamicKitComponentListDisplay">
				<c:param name="rfqprod_id" value="${rfqprodId}" />
				<c:param name="offering_id" value="${param.rfqId}" />
				<c:param name="catentryid" value="${catid}" />
				<c:param name="langId" value="${langId}" />
				<c:param name="storeId" value="${storeId}" />
				<c:param name="catalogId" value="${catalogId}" />
			</c:url>
			<td headers="a1" class="t_td" id="WC_RFQCategoryDisplay_ProductInfo_Row_TableCell_1c<c:out value="${param.index + 1}" />">
				<a href="<c:out value="${RFQDynamicKitComponentListDisplayHref}" />" id="WC_RFQModifyDisplay_Link_14_<c:out value="${param.index + 1}" />">
					<c:out value="${prodName}" />
				</a>
			</td>
		</c:when>
		
		<c:otherwise>
			<td headers="a1" class="t_td" id="WC_RFQCategoryDisplay_ProductInfo_Row_TableCell_1<c:out value="${param.index + 1}" />">
				<c:out value="${prodName}" />
			</td>
		</c:otherwise>
	</c:choose>

	<c:choose>
		<c:when test="${!empty catid}">
			<td headers="a2" class="t_td" id="WC_RFQCategoryDisplay_ProductInfo_Row_TableCell_2"><c:out value="${catalogAB.shortDescription}" /></td>
		</c:when>
		<c:otherwise>
			<td headers="a2" class="t_td" id="WC_RFQCategoryDisplay_ProductInfo_Row_TableCell_3"></td>
		</c:otherwise>
	</c:choose>
				<td headers="a3" class="t_td" id="WC_RFQCategoryDisplay_ProductInfo_Row_TableCell_4"><c:out value="${type}" /></td>
	<c:if test="${requestScope.isContract}" >
	    <c:choose>
			<c:when test="${offerPrice != null}" >
	            <td headers="a4" class="t_td" id="WC_RFQCategoryDisplay_ProductInfo_Row_TableCell_5_<c:out value="${param.index + 1}" />" class="price"><c:out value="${offerPrice}"  escapeXml="false" /> 
	            </td>                  		        
			</c:when>
			<c:otherwise>
	        	<td headers="a4" class="t_td" id="WC_RFQCategoryDisplay_ProductInfo_Row_TableCell_5_<c:out value="${param.index + 1}" />">&nbsp; 
	        	</td>
			</c:otherwise>
		</c:choose>                 		        
	</c:if>
	<c:if test="${requestScope.isContract}" > 
	
			<td headers="a5" class="t_td" id="WC_RFQCategoryDisplay_ProductInfo_Row_TableCell_6_<c:out value="${param.index + 1}" />" align="center"><c:if test="${priceAdjust != '0'}" ><c:out value="${priceAdjust}" /></c:if>
			</td> 
			
	</c:if>
    	<td headers="a6" class="t_td" id="WC_RFQCategoryDisplay_ProductInfo_Row_TableCell_7" class="price"><c:out value="${price}"  escapeXml="false" /></td>
		<td headers="a7" class="t_td" id="WC_RFQCategoryDisplay_ProductInfo_Row_TableCell_8"><c:out value="${currencyCode}" /></td>
		<td headers="a8" class="t_td" id="WC_RFQCategoryDisplay_ProductInfo_Row_TableCell_9"><c:out value="${quantity}" /></td>
		<td headers="a9" class="t_td" id="WC_RFQCategoryDisplay_ProductInfo_Row_TableCell_10"><c:out value="${unit}" /></td>
<c:choose>
	<c:when test="${changeable}">
		 <td headers="a10" class="t_td" id="WC_RFQCategoryDisplay_ProductInfo_Row_TableCell_11"><fmt:message key="RFQModifyAddCommentDisplay_Yes" bundle="${storeText}" /></td>
	</c:when>
	<c:otherwise>
		<td headers="a10" class="t_td" id="WC_RFQCategoryDisplay_ProductInfo_Row_TableCell_11"><fmt:message key="RFQModifyAddCommentDisplay_No" bundle="${storeText}" /></td>							
	</c:otherwise>
</c:choose>

 

	
	
