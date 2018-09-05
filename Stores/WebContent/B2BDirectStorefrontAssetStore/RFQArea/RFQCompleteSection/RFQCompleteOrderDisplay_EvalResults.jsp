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
  * This JSP page is used to iterate through the response products for
  * the order.
  *
  * Required parameters:
  * - respStoreId
  * - index - int
  *
  *****
--%>

<%@ page language="java" %>

<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="flow.tld" prefix="flow" %>

<%@ include file="../../include/JSTLEnvironmentSetup.jspf" %>

<c:set var="EC_RFQ_RESPONSE_PRODUCT_EVAL_ID" value="responseProductEvalId" scope="page" />
<c:set var="EC_SHIPPING_ADDRESS"  value="ShippingAddress" scope="page" />
<c:set var="EC_SHIPPING_MODE"  value="ShippingMode" scope="page" />

<c:set var="rfqResponseEvals" value="${requestScope.rfqResponseEvals}" />
<c:set var="evalResult" value="${rfqResponseEvals[param.index]}" />
<c:set var="respStoreId" value="${param.respStoreId}" />
<c:set var="TCShipMode" value="${requestScope.TCShipMode}" />

<wcbase:useBean id="rfqRspProd" classname="com.ibm.commerce.rfq.beans.RFQResProductDataBean" scope="page">
	<c:set target="${rfqRspProd}" property="resProdId" value="${evalResult.rfqResponseProductId}" />
	<c:set target="${rfqRspProd}" property="resStoreId" value="${param.respStoreId}" />	
</wcbase:useBean>

<c:url var="TrackOrderStatusHref" value="${TrackOrderStatusHref}">
	<c:param name="${EC_RFQ_RESPONSE_PRODUCT_EVAL_ID}_${param.index + 1}" value="" />
	<c:param name="${EC_SHIPPING_ADDRESS}_${param.index + 1}" value="" />
	<c:param name="${EC_RFQ_RESPONSE_PRODUCT_EVAL_ID}_${param.index + 1}" value="" />
</c:url>


<c:set var="prodNum" value="" />
	
<c:if test="${!empty rfqRspProd.catentryId}">
	<wcbase:useBean id="ceDB"	classname="com.ibm.commerce.catalog.beans.CatalogEntryDataBean">
		<c:set target="${ceDB}" property="catalogEntryID" value="${rfqRspProd.catentryId}" />
	</wcbase:useBean>

	<c:choose>
		<c:when test="${ceDB.type eq 'ItemBean'}">
			<wcbase:useBean id="item" classname="com.ibm.commerce.catalog.beans.ItemDataBean">
				<c:set target="${item}" property="itemID" value="${rfqRspProd.catentryId}" />	
			</wcbase:useBean> 
			<c:set var="prodNum" value="${item.partNumber}" />	
		</c:when>
		<c:when test="${ceDB.type eq 'ProductBean'}">
			<wcbase:useBean id="product" classname="com.ibm.commerce.catalog.beans.ProductDataBean">
				<c:set target="${product}" property="productID" value="${rfqRspProd.catentryId}" />	
			</wcbase:useBean> 
			<c:set var="prodNum" value="${product.partNumber}" />		
		</c:when>
		<c:when test="${ceDB.type eq 'PackageBean'}">
			<wcbase:useBean id="pkg" classname="com.ibm.commerce.catalog.beans.PackageDataBean">
				<c:set target="${pkg}" property="packageID" value="${rfqRspProd.catentryId}" />	
			</wcbase:useBean> 
			<c:set var="prodNum" value="${pkg.partNumber}" />		
		</c:when> 
		<c:when test="${ceDB.type eq 'DynamicKitBean'}">
			<wcbase:useBean id="dk" classname="com.ibm.commerce.catalog.beans.DynamicKitDataBean">
				<c:set target="${dk}" property="dynamicKitID" value="${rfqRspProd.catentryId}" />	
			</wcbase:useBean> 
			<c:set var="prodNum" value="${dk.partNumber}" />
		</c:when>
		<c:otherwise>
			<c:set var="prodNum" value="" />
		</c:otherwise>
		</c:choose>
</c:if>

<wcbase:useBean id="catalogDB" classname="com.ibm.commerce.catalog.beans.CatalogEntryDescriptionDataBean">
	<c:set target="${catalogDB}" property="dataBeanKeyCatalogEntryReferenceNumber" value="${rfqRspProd.catentryId}" />
	<c:set target="${catalogDB}" property="dataBeanKeyLanguage_id" value="${langId}" />	
</wcbase:useBean>
 
<c:set var="orderByParam" value="" />
<wcbase:useBean id="shipAddrListDataBean" classname="com.ibm.commerce.tools.optools.order.beans.ShippingAddressListDataBean" scope="page">
	<c:set target="${shipAddrListDataBean}" property="customerId" value="${userId}" />
	<c:set target="${shipAddrListDataBean}" property="orderByParmValue" value="${orderByParam}"  />	
</wcbase:useBean>

	<td headers="a1" class="t_td" id="WC_RFQCompleteOrderDisplay_TableCell_11_<c:out value="${param.index + 1}"/>">
	<input type="hidden" name="<c:out value="${EC_RFQ_RESPONSE_PRODUCT_EVAL_ID}"/>_<c:out value="${param.index + 1}"/>" value="<c:out value="${evalResult.rfqResponseEvalId}"/>" id="WC_RFQCompleteOrderDisplay_FormInput_<c:out value="${EC_RFQ_RESPONSE_PRODUCT_EVAL_ID}"/>_<c:out value="${param.index + 1}"/>_In_RFQCompleteForm_1"/>
	<c:out value="${catalogDB.name}" /></td>
	<td headers="a2" class="t_td" id="WC_RFQCompleteOrderDisplay_TableCell_12_<c:out value="${param.index + 1}"/>"><c:out value="${prodNum}"/></td>
	<td headers="a3" class="t_td" id="WC_RFQCompleteOrderDisplay_TableCell_13_<c:out value="${param.index + 1}"/>"><c:out value="${rfqRspProd.formattedQuantity}"/></td>

	<td headers="a4" class="t_td" id="WC_RFQCompleteOrderDisplay_TableCell_14_<c:out value="${param.index + 1}"/>">
     	<label for="WC_RFQCompleteOrderDisplay_EvalResults_Select_1"></label>
     	<select name="<c:out value="${EC_SHIPPING_ADDRESS}" />_<c:out value="${param.index + 1}"/>" class="select" id="WC_RFQCompleteOrderDisplay_EvalResults_Select_1">	
	<c:set var="alladdresses" value="${shipAddrListDataBean.addressList}" />:	 	
		<c:forEach items="${alladdresses}" var="anAddress"	varStatus="iter">
			<wcbase:useBean id="address" classname="com.ibm.commerce.user.beans.AddressDataBean">
				<c:set target="${address}" property="addressId" value="${anAddress.addressId}" />
				
			</wcbase:useBean>
			<c:if test="${param.ShippingAddress==anAddress.addressId}">
			<option selected value="<c:out value="${anAddress.addressId}" />"><c:out value="${address.nickName}" /></option>
			</c:if>
			<c:if test="${param.ShippingAddress!=anAddress.addressId}">
			<option value="<c:out value="${anAddress.addressId}" />"><c:out value="${address.nickName}" /></option>
			</c:if>
			<c:remove var="address" />

		</c:forEach>
       	</select>
	
	</td> 
	
	<td headers="a5" class="t_td" id="WC_RFQCompleteOrderDisplay_TableCell_15_<c:out value="${param.index + 1}"/>">
	<label for="WC_RFQCompleteOrderDisplay_EvalResults_Select_2"></label>
	<select name="<c:out value="${EC_SHIPPING_MODE}" />_<c:out value="${param.index + 1}"/>" class="select" id="WC_RFQCompleteOrderDisplay_EvalResults_Select_2">
		<c:forEach items="${TCShipMode}" var="aShipMode"  varStatus="iter">
			<wcbase:useBean id="dbShipModeDesc" classname="com.ibm.commerce.fulfillment.beans.ShippingModeDescriptionDataBean">
				<c:set target="${dbShipModeDesc}" property="dataBeanKeyShipModeId" value="${aShipMode.shippingModeId}" />
				<c:set target="${dbShipModeDesc}" property="dataBeanKeyLanguageId" value="${langId}" />
			</wcbase:useBean>
			<c:if test="${param.ShippingMode==aShipMode.shippingModeId}">
			<option selected value="<c:out value="${aShipMode.shippingModeId}" />"><c:out value="${dbShipModeDesc.description}" /></option>
			</c:if>
			<c:if test="${param.ShippingMode!=aShipMode.shippingModeId}">
			<option value="<c:out value="${aShipMode.shippingModeId}" />"><c:out value="${dbShipModeDesc.description}" /></option>
			</c:if>
			<c:remove var="dbShipModeDesc" />
		</c:forEach>
	</select>
	
	</td>
