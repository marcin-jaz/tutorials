<%
/*
 *-------------------------------------------------------------------
 * Licensed Materials - Property of IBM
 *
 * WebSphere Commerce
 *
 * (c) Copyright International Business Machines Corporation. 2001, 2004
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
  * This JSP page sets up offer price information based on catalog entry
  * type for use by RFQ Response pages.
  *
  * Required parameters:
  * - catentryId 
  * - setOfferPrice_Item - true or false
  * - setOfferPrice_Product- true or false
  * - setOfferPrice_Package- true or false
  *
  *****
--%>

<%@ page language="java" %>

<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../include/JSTLEnvironmentSetup.jspf" %>


<c:set var="EC_OFFERING_ITEMBEAN" value="ItemBean" scope="request" />
<c:set var="EC_OFFERING_PRODUCTBEAN" value="ProductBean" scope="request" />
<c:set var="EC_OFFERING_PACKAGEBEAN" value="PackageBean" scope="request" />
<c:set var="EC_OFFERING_DYNAMICKITBEAN" value="DynamicKitBean" scope="request" />


<c:remove var="type" scope="request" />
<c:remove var="offerPrice" scope="request" />
<c:set var="type" />
<c:set var="offerPrice" />	

<c:if test="${param.catentryId != null}">				
	<wcbase:useBean id="ceDB" classname="com.ibm.commerce.catalog.beans.CatalogEntryDataBean">
		<c:set target="${ceDB}" property="catalogEntryID" value="${param.catentryId}" />		
	</wcbase:useBean>

	<c:choose>
		<c:when test="${ceDB.type eq EC_OFFERING_ITEMBEAN}">
			<fmt:message key="RFQModifyDisplay_Item" bundle="${storeText}" var="type" />
			
			<c:if test="${param.setOfferPrice_Item != null and param.setOfferPrice_Item == true}">
				<wcbase:useBean id="item"
					classname="com.ibm.commerce.catalog.beans.ItemDataBean">
					<c:set target="${item}" property="initKey_catalogEntryReferenceNumber" value="${param.catentryId}" />
					<c:set target="${item}" property="itemID" value="${param.catentryId}" />
					
				</wcbase:useBean>
				<c:set var="offerPrice" value="${item.standardPrice}" />
				<c:remove var="item" />
			</c:if>
		</c:when>
		<c:when test="${ceDB.type eq EC_OFFERING_PRODUCTBEAN}">
			<fmt:message key="RFQModifyDisplay_Product" bundle="${storeText}" var="type"/>
			<c:if test="${param.setOfferPrice_Product != null and param.setOfferPrice_Product == true}">
				<wcbase:useBean id="product"
					classname="com.ibm.commerce.catalog.beans.ProductDataBean">
					<c:set target="${product}" property="initKey_catalogEntryReferenceNumber" value="${param.catentryId}" />
					<c:set target="${product}" property="productID" value="${param.catentryId}" />
					
				</wcbase:useBean>
				<c:set var="offerPrice" value="${product.standardPrice}" />
				<c:remove var="product" />
			</c:if>
		</c:when>
		<c:when test="${ceDB.type eq EC_OFFERING_PACKAGEBEAN}">
			<fmt:message key="RFQModifyDisplay_Prebuilt_Kit" bundle="${storeText}" var="type"/>
			
			<c:if test="${param.setOfferPrice_Package != null and param.setOfferPrice_Package == true}">
				<wcbase:useBean id="packageDB"
					classname="com.ibm.commerce.catalog.beans.PackageDataBean">
					<c:set target="${packageDB}" property="initKey_catalogEntryReferenceNumber" value="${param.catentryId}" />
					<c:set target="${packageDB}" property="packageID" value="${param.catentryId}" />
					
				</wcbase:useBean>
				<c:set var="offerPrice" value="${packageDB.standardPrice}" />
				<c:remove var="packageDB" />
			</c:if>
		</c:when>

		<c:when test="${ceDB.type eq EC_OFFERING_DYNAMICKITBEAN}">
			<fmt:message key="RFQModifyDisplay_Dynamic_Kit" bundle="${storeText}" var="type"/>
		</c:when>
		<c:otherwise>
			<c:set var="type" value="${ceDB.type}" />
		</c:otherwise>
	</c:choose>
 </c:if>
  <c:set var="type" value="${type}" scope="request" />
  <c:set var="offerPrice" value="${offerPrice}" scope="request" />
  
 
 


