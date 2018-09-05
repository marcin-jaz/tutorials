<%
//********************************************************************
//*-------------------------------------------------------------------
//* Licensed Materials - Property of IBM
//*
//* WebSphere Commerce
//*
//* (c) Copyright IBM Corp. 2003
//*
//* US Government Users Restricted Rights - Use, duplication or
//* disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
//*
//*-------------------------------------------------------------------
//*
//*---------------------------------------------------------------------
//* The sample contained herein is provided to you "AS IS".
//*
//* It is furnished by IBM as a simple example and has not been  
//* thoroughly tested
//* under all conditions.  IBM, therefore, cannot guarantee its 
//* reliability, serviceability or functionality.  
//*
//* This sample may include the names of individuals, companies, brands 
//* and products in order to illustrate concepts as completely as 
//* possible.  All of these names
//* are fictitious and any similarity to the names and addresses used by 
//* actual persons 
//* or business enterprises is entirely coincidental.
//*---------------------------------------------------------------------
//*
%>
<%-- 
  ***
  * This Jsp snippet displays current charges and total charges of an order (functional description)
  *
  * How to use this snippet?
  * 1. This snippet is available under the <WC-Install Dir>/samples/Snippets/web/Order/Inventory/
  *
  * 2. You can use this snippet in your xxx.jsp in the following 2-ways
  *		A. copy and paste the entire code in your xxx.jsp
  *		B. do import (example)
  *			<c:import url="${snippetJSPStoreDir}Snippets/Order/Inventory/CurrentAndTotalCharges.jsp" >
  *         	<c:param name= "orderid" value= "10001501"/>
  *				<c:param name= "showCurrentCharges" value= "true"/>
  *				<c:param name= "showFutureCharges"  value= "true"/>
  *             <c:param name= "notShowAdjustedShipCharges"  value= "true"/>
  *             <c:param name= "notShowBaseShipAndAdjust"  value= "true"/>
  *     	</c:import>
  *		if this snippet is going to be included in another JSP Snippet
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../OrderEnvironmentSetup.jspf"%>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf"%>

<flow:fileRef id="vfileColor" fileId="vfile.color"/>

<c:set var="orderId" value="${param.orderId}" />
<c:if test="${param.showFutureCharges}">
	<c:set var="showFutureCharges" value="true" />
</c:if>
<c:if test="${param.showCurrentCharges}">
	<c:set var="showCurrentCharges" value="true" />
</c:if>

<c:set var="showAdjustedShipCharges" value="true" />

<c:if test="${param.notShowAdjustedShipCharges}">
	<c:set var="showAdjustedShipCharges" value="false" />
</c:if>

<c:set var="showBaseShipAndAdjust" value="true" />

<c:if test="${param.notShowBaseShipAndAdjust}">
	<c:set var="showBaseShipAndAdjust" value="false" />
</c:if>

<c:set var="pageSize" value="${maxOrderItemsPerPage}"/>
<c:if test="${empty pageSize}">
	<c:set var="pageSize" value="20"/>
</c:if>
<c:set var="currentPage" value="${WCParam.currentPage}"/>
<c:if test="${empty currentPage}">
	<c:set var="currentPage" value="1"/>
</c:if>

<wcbase:useBean id="order_OrderDataBean" classname="com.ibm.commerce.order.beans.OrderDataBean">
	<c:set target="${order_OrderDataBean}" property="orderId" value="${orderId}" />
	<c:set target="${order_OrderDataBean}" property="pageSize" value="${pageSize}"/>
	<c:set target="${order_OrderDataBean}" property="currentPage" value="${currentPage}"/>
</wcbase:useBean>

<%-- get pageSize from OrderDataBean again - if passed in page size is greater than max value, pageSize will set to max value --%>
<c:set var="pageSize" value="${order_OrderDataBean.pageSize}"/>

<c:set var="curChargesAndItems"	value="${order_OrderDataBean.currentCharges}" />
<c:set var="futChargesAndItems" value="${order_OrderDataBean.futureCharges}"/>

<c:if test="${showCurrentCharges && !empty curChargesAndItems.dates && !empty futChargesAndItems.dates && order_OrderDataBean.totalSize < pageSize}" >
<h2>
	<fmt:message key="OrderSummary_CURRENT_CHARGE_HEAD" bundle="${orderText}" />
</h2>

<c:set var="rowClass" value="cellBG_2"/>
<c:forEach items="${curChargesAndItems.dates}" var="datesMap">
	
	<strong> 
		<fmt:message key="OrderSummary_ESTIMATED_SHIP_DATE" bundle="${orderText}" /> <c:out value="${datesMap.key}"/>
	</strong>
<table cellpadding="2" cellspacing="1" width="100%" class="bgColor" id="WC_CurrentAndTotalCharges_Table_1">	
	<tr>
		<th class="colHeader" width="40%" id="WC_CurrentAndTotalCharges_Desc">
			<fmt:message key="OrderSummary_DESC" bundle="${orderText}" />
		</th>
		<th class="colHeader" id="WC_CurrentAndTotalCharges_QTY"><span class="t_hd_cntr">
			<fmt:message key="OrderSummary_QTY" bundle="${orderText}" /></span>
		</th>
		<th class="colHeader" id="WC_CurrentAndTotalCharges_Address">
			<fmt:message key="OrderSummary_ADDRESS" bundle="${orderText}" />
		</th>
		<th class="colHeader" id="WC_CurrentAndTotalCharges_Method">
			<fmt:message key="OrderSummary_SHIPPING_METHOD" bundle="${orderText}" />
		</th>
		<th class="colHeader" id="WC_CurrentAndTotalCharges_UnitPrice"><span class="t_hd_rght">
			<fmt:message key="OrderSummary_UNIT_EACH_PRICE" bundle="${orderText}" /></span>
		</th>
		<th class="colHeader_price" id="WC_CurrentAndTotalCharges_Total"><span class="t_hd_rght">
			<fmt:message key="OrderSummary_UNIT_TOTAL_PRICE" bundle="${orderText}" /></span>
		</th>
	</tr>
 <c:forEach items="${datesMap.value}" var="itemBeansMap" >
  <c:forEach items="${itemBeansMap.value}" var="orderItem" varStatus="status">

	<c:choose>
		<c:when test="${orderItem.catalogEntryDataBean.package}">
			<c:set var="catalogEntry" value="${orderItem.catalogEntryDataBean.packageDataBean}"/>
			<c:set var="catalogEntryId" value="${catalogEntry.packageID}"/>
		</c:when>
		
		<c:when test="${orderItem.catalogEntryDataBean.item}">
			<c:set var="catalogEntry" value="${orderItem.catalogEntryDataBean.itemDataBean.parentProductDataBean}"/>
			<c:set var="catalogEntryId" value="${catalogEntry.productID}"/>
		</c:when>
		
		<c:otherwise>
			<c:set var="catalogEntry" value="${orderItem.catalogEntryDataBean.productDataBean}" />
			<c:set var="catalogEntryId" value="${catalogEntry.productID}"/>
		</c:otherwise>
	</c:choose>
	<c:choose>
		<c:when test="${rowClass eq 'cellBG_2'}">
			<c:set var="rowClass" value="cellBG_1"/>
		</c:when>
		<c:otherwise>
			<c:set var="rowClass" value="cellBG_2"/>
		</c:otherwise>
	</c:choose>
	<tr valign="top">
		<td class="<c:out value="${rowClass}"/> t_td" headers="WC_CurrentAndTotalCharges_Desc" id="WC_CurrentAndTotalCharges_Desc_1_<c:out value="${status.count}"/>">
			<c:url var="ProductDisplayURL" value="ProductDisplay">
				<c:param name="langId" value="${WCParam.langId}" />
				<c:param name="storeId" value="${WCParam.storeId}" />
				<c:param name="catalogId" value="${WCParam.catalogId}" />
				<c:param name="productId" value="${catalogEntryId}" />
				<c:param name="summaryOnly" value="true" />
			</c:url>
			<a href="<c:out value="${ProductDisplayURL}"/>" id="WC_CurrentAndTotalCharges_Link_1_<c:out value="${status.count}"/>">
				<c:out value="${catalogEntry.description.name}" escapeXml="false"  /><br/>
			</a>
			<%-- 
				***
				* Begin: display order item attributes
				***
			--%>			
			<c:if test="${orderItem.catalogEntryDataBean.item}">
					<%-- If the catentry is an item, we get all the attributes and attribute values for the item using AttributeValueDataBean and AttributeDataBean --%>
					<c:set var="item" value="${orderItem.catalogEntryDataBean.itemDataBean}" />
					<c:forEach var="attr" items="${item.attributeValueDataBeans}"> 	
						<c:set var="attribute" value="${attr.attributeDataBean}" />
							<c:if test="${attribute.definingAttribute}">
								<span class="strongtext"><c:out value="${attribute.name}" escapeXml="false"/>:
								<c:out value="${attr.value}" escapeXml="false"/></span><br/>
							</c:if>
					</c:forEach>
					<br/>
			</c:if>
			<%--  
				***
				* End: display order item attributes
				***  
			--%>

			<%-- Display the order item SKU number --%>
			<fmt:message key="OrderSummary_SKU" bundle="${orderText}"/> <c:out value="${orderItem.catalogEntryDataBean.partNumber}" escapeXml="false"/>
		</td>
		<td class="<c:out value="${rowClass}"/> t_td" align="center" headers="WC_CurrentAndTotalCharges_QTY" id="WC_CurrentAndTotalCharges_QTY_1_<c:out value="${status.count}"/>">
			<span class="t_cntr">
			<c:out value="${orderItem.formattedQuantity}" />
			</span>
		</td>
		<td class="<c:out value="${rowClass}"/> t_td" headers="WC_CurrentAndTotalCharges_Address" id="WC_CurrentAndTotalCharges_Address_1_<c:out value="${status.count}"/>">
		<flow:ifDisabled feature="GiftRegistry">
			<c:set var="address" value="${orderItem.addressDataBean}"/>
			<%-- Print the appropriate address information out depending on locale --%>				
			<%@ include file="../../../Snippets/ReusableObjects/AddressDisplay.jspf"%>
		</flow:ifDisabled>
		<flow:ifEnabled feature="GiftRegistry">
			<%--
				***  
				* Begin: hide registrant shipping addresses 
				***  
			--%>
			<c:remove var="grOrderItem" scope="page"/>
			<%@ include file="CurrentAndTotalGRCharges.jspf" %>
			<c:choose>
				<c:when test='${grOrderItem.shipToRegistrant == 1}'>
					<c:out value="${grOrderItem.addressDataBean.firstName} "/>
					<c:out value="${grOrderItem.addressDataBean.lastName}"/> <br/>
					<fmt:message key="GR_SHIPTO_REGISTRY" bundle="${storeText}"/>
					<c:out value=": ${grOrderItem.externalGiftRegistryId}"/>
					<br/>
				</c:when>
				<c:otherwise>
					<c:set var="address" value="${orderItem.addressDataBean}"/>
					<%-- Print the appropriate address information out depending on locale --%>				
					<%@ include file="../../../Snippets/ReusableObjects/AddressDisplay.jspf"%>
				</c:otherwise>
			</c:choose>
		</flow:ifEnabled>
		</td>
		<td class="<c:out value="${rowClass}"/> t_td" headers="WC_CurrentAndTotalCharges_Method" id="WC_CurrentAndTotalCharges_Method_1_<c:out value="${status.count}"/>">
			<c:out value="${orderItem.shippingModeDataBean.description.description}"/>
			<c:if test="${!empty orderItem.requestedShipDateYear}" > 
				<br />
				<fmt:message key="OrderSummary_REQUESTED_SHIP_DATE" bundle="${orderText}" />:
				<br />
				<c:out value="${orderItem.formattedRequestedShipDate}"/>
			</c:if>
			<c:if test="${orderItem.expedited}" >
				<br />
				<fmt:message key="OrderSummary_EXPEDITE" bundle="${orderText}" />
			</c:if>
		</td>
		<td class="<c:out value="${rowClass}"/> price t_td" headers="WC_CurrentAndTotalCharges_UnitPrice" id="WC_CurrentAndTotalCharges_UnitPrice_1_<c:out value="${status.count}"/>">
			<%-- 
				***
				* Begin: check item for listed price 
				***
			--%>
	
			<c:choose>
				<c:when test="${catalogEntry.listPriced}">
					<c:set var="orderItemListPriceString" value="${orderItem.catalogEntryDataBean.listPrice}"/>
					<c:set var="showListPrice" value="true"/>
					<%-- Compare to see if items listed price is less than the items price.  If it is less, then also show the item price --%>
					<c:if test="${ orderItem.catalogEntryDataBean.listPrice.amount <= orderItem.priceDataBean.amount }" > 
						<c:set var="showListPrice" value="false"/>					
					</c:if>
				</c:when>
				<c:otherwise>
					<c:set var="showListPrice" value="false" />	
				</c:otherwise>
			</c:choose>
			<%-- 
				***
				* End: check item for listed price 
				***
			--%>
			<%-- 
				***
				* Begin: display the items price and listed price if it is more then the items price 
				***
			--%>
			<c:choose>
				<%-- show both the list price & item price if list price is > item price --%>
				<c:when test="${showListPrice}">
					<%-- the empty gif are put in front of the prices so that the alt text can be read by the IBM Homepage Reader to describe the two prices displayed. 
					These descriptions are necessary for meeting Accessibility requirements --%>
					<a href="#" id="WC_CurrentAndTotalCharges_Link_4_<c:out value="${status.count}"/>"><img src="<c:out value="${snippetJspStoreImgDir}"/>images/empty.gif" alt="<fmt:message key="OrderSummary_RegularPriceIs" bundle="${orderText}" />" width="0" height="0" border="0"/></a>
					<span class="listPrice">
						<c:out value="${orderItemListPriceString}" escapeXml="false" />
					</span>
					<br/>
					<%-- the empty gif are put in front of the prices so that the alt text can be read by the IBM Homepage Reader to describe the two prices displayed. 
					These descriptions are necessary for meeting Accessibility requirements --%>
					<a href="#" id="WC_CurrentAndTotalCharges_Link_5_<c:out value="${status.count}"/>"><img src="<c:out value="${snippetJspStoreImgDir}"/>images/empty.gif" alt="<fmt:message key="OrderSummary_SalePriceIs" bundle="${orderText}" />" width="0" height="0" border="0" /></a>
					<span class="offerPrice">
						<c:out value="${orderItem.priceDataBean}" escapeXml="false" ><fmt:message key="OrderSummary_NO_PRICE_AVAILABLE" bundle="${orderText}" /></c:out>
					</span>
				</c:when>
				<%-- show only item price since it is greated than listed price --%>
				<c:otherwise>
					<%-- the empty gif are put in front of the prices so that the alt text can be read by the IBM Homepage Reader to describe the two prices displayed. 
					These descriptions are necessary for meeting Accessibility requirements --%>
					<a href="#" id="WC_CurrentAndTotalCharges_Link_6_<c:out value="${status.count}"/>"><img src="<c:out value="${snippetJspStoreImgDir}"/>images/empty.gif" alt="<fmt:message key="OrderSummary_PriceIs" bundle="${orderText}" />" width="1" height="1" border="0" /></a>
					<span class="price">
						<c:out value="${orderItem.priceDataBean}" escapeXml="false" ><fmt:message key="OrderSummary_NO_PRICE_AVAILABLE" bundle="${orderText}" /></c:out>
					</span>
				</c:otherwise>
			</c:choose>
		</td>
		<td class="<c:out value="${rowClass}"/> price t_td" headers="WC_CurrentAndTotalCharges_Total" id="WC_CurrentAndTotalCharges_Total_1_<c:out value="${status.count}"/>">
			<c:choose>
				<c:when test="${orderItem.free}">
					<%-- the OrderItem is a freebie --%>
					<span class="offerPrice"><fmt:message key="OrderSummary_SHOPCART_FREE" bundle="${orderText}"/></span>
				</c:when>
				<c:otherwise>
					<span class="price">
						<c:out value="${orderItem.formattedTotalProduct}" escapeXml="false" />
					</span>
	
				</c:otherwise>
			</c:choose>
		</td>
	</tr>
	<%--
	***
	* Begin: Gift Registry Order integration
	***
	--%>
	<%-- Display gift registry, if this is a gift item --%>
	<flow:ifEnabled feature="GiftRegistry">
	<c:if test='${!empty grOrderItem.externalGiftRegistryId}'>
	<tr>
	<td></td>
	<td colspan="5">
	<img src="<c:out value='${jspStoreImgDir}images/gift_item.gif'/>" border="0" alt="<fmt:message key='GR_GIFT_ITEM' bundle='${storeText}' />" />
	<span class="text">
	<fmt:message key='GR_GIFT_ITEM_FOR_REG' bundle='${storeText}' /> <c:out value="${grOrderItem.giftRegistryDB.description}"/><br/>
	</span>
	</td>
	</tr>
	<tr>
	<td colspan="6" class="c_line">&nbsp;</td>
	</tr>		
	</c:if>
	</flow:ifEnabled>
	<%--
	***
	* End: Gift Registry Order integration
	***
	--%> 
  </c:forEach>
 </c:forEach>

        <c:choose>
		<c:when test="${rowClass eq 'cellBG_2'}">
			<c:set var="rowClass" value="cellBG_1"/>
		</c:when>
		<c:otherwise>
			<c:set var="rowClass" value="cellBG_2"/>
		</c:otherwise>
        </c:choose>
	<tr valign="top">
		<td colspan="5" class="<c:out value="${rowClass}"/> price t_td" id="WC_CurrentAndTotalCharges_TableCell_1">
			<fmt:message key="OrderSummary_TOTAL_PRODUCT" bundle="${orderText}" /><br/>
			<fmt:message key="OrderSummary_TOTAL_DISCOUNT" bundle="${orderText}" /><br/>
			<fmt:message key="OrderSummary_TOTAL_SURCHARGE" bundle="${orderText}" /><br/>
			<fmt:message key="OrderSummary_TOTAL_TAX" bundle="${orderText}" /><br/>
			<c:if test="${showBaseShipAndAdjust}" >
			<fmt:message key="OrderSummary_TOTAL_ORIGINAL_SHIPPING" bundle="${orderText}" /><br/>
			<fmt:message key="OrderSummary_TOTAL_SHIPPING_ADJUSTMENT" bundle="${orderText}" /><br/>			
			</c:if>
			<c:if test="${showAdjustedShipCharges}" >
			<fmt:message key="OrderSummary_TOTAL_SHIPPING" bundle="${orderText}" /><br/>
			</c:if>
			<fmt:message key="OrderSummary_TOTAL_SHIPPINGTAX" bundle="${orderText}" />
		</td>
		<td class="<c:out value="${rowClass}"/> price t_td" id="WC_CurrentAndTotalCharges_TableCell_2">
			<c:out value="${order_OrderDataBean.formattedCurrentProductTotal}" escapeXml="false"/><br/>
			<c:out value="${order_OrderDataBean.formattedCurrentDiscountAdjustmentTotal}" escapeXml="false"/><br/>
			<c:out value="${order_OrderDataBean.formattedCurrentSurchargeAdjustmentTotal}" escapeXml="false"/><br/>
			<c:out value="${order_OrderDataBean.formattedCurrentTaxTotal}" escapeXml="false"/><br/>
			<c:if test="${showBaseShipAndAdjust}" >
			<c:out value="${order_OrderDataBean.formattedCurrentShippingCharge}" escapeXml="false"/><br/>
			<c:out value="${order_OrderDataBean.formattedCurrentShippingAdjustmentTotal}" escapeXml="false"/><br/>			
			</c:if>
			<c:if test="${showAdjustedShipCharges}" >
			<c:out value="${order_OrderDataBean.formattedCurrentTotalShippingCharge}" escapeXml="false"/> <br/>
			</c:if>
			<c:out value="${order_OrderDataBean.formattedCurrentShippingTaxTotal}" escapeXml="false"/>
		</td>
	</tr>
	<c:choose>
		<c:when test="${rowClass eq 'cellBG_2'}">
			<c:set var="rowClass" value="cellBG_1"/>
		</c:when>
		<c:otherwise>
			<c:set var="rowClass" value="cellBG_2"/>
		</c:otherwise>
	</c:choose>
	<tr valign="top">
		<td colspan="5" class="<c:out value="${rowClass}"/> price t_total" id="WC_CurrentAndTotalCharges_TableCell_3">
			<strong>
				<fmt:message key="OrderSummary_TOTAL_CHARGE" bundle="${orderText}" />
			</strong>
		</td>
		<td class="<c:out value="${rowClass}"/> price t_total_figure" id="WC_CurrentAndTotalCharges_TableCell_4">
			<c:out value="${order_OrderDataBean.formattedCurrentTotal}" escapeXml="false"/>
		</td>
	</tr>
</table>
</c:forEach>
</c:if>
<%---
 ******
--%>
<c:if test="${showFutureCharges && !empty futChargesAndItems.dates && order_OrderDataBean.totalSize < pageSize}" >

<h2>
 	<fmt:message key="OrderSummary_FUTURE_CHARGE_HEAD" bundle="${orderText}" />
</h2>
<c:set var="rowClass" value="cellBG_2"/>

<c:forEach items="${futChargesAndItems.dates}" var="datesMap">
  <strong>
  	<fmt:message key="OrderSummary_ESTIMATED_SHIP_DATE" bundle="${orderText}" /> <c:out value="${datesMap.key}"/>
  </strong>
  <table cellpadding="2" cellspacing="1" width="100%" class="bgColor" id="WC_CurrentAndTotalCharges_Table_2">
	<tr>
		<th class="colHeader" width="40%" id="WC_CurrentAndTotalCharges_Desc_2">
			<fmt:message key="OrderSummary_DESC" bundle="${orderText}" />
		</th>
		<th class="colHeader" id="WC_CurrentAndTotalCharges_QTY_2"><span class="t_hd_cntr">
			<fmt:message key="OrderSummary_QTY" bundle="${orderText}" /></span>
		</th>
		<th class="colHeader" id="WC_CurrentAndTotalCharges_Address_2">
			<fmt:message key="OrderSummary_ADDRESS" bundle="${orderText}" />
		</th>
		<th class="colHeader" id="WC_CurrentAndTotalCharges_Method_2">
			<fmt:message key="OrderSummary_SHIPPING_METHOD" bundle="${orderText}" />
		</th>
		<th class="colHeader" id="WC_CurrentAndTotalCharges_UnitPrice_2"><span class="t_hd_rght">
			<fmt:message key="OrderSummary_UNIT_EACH_PRICE" bundle="${orderText}" /></span>
		</th>
		<th class="colHeader_price" id="WC_CurrentAndTotalCharges_Total_2"><span class="t_hd_rght">
			<fmt:message key="OrderSummary_UNIT_TOTAL_PRICE" bundle="${orderText}" /></span>
		</th>
	</tr>
	
  <c:set var="dateEntryMap" value="${datesMap.value}"/>
    <c:forEach items="${dateEntryMap.orderItems}" var="itemBeansMap">
  <c:forEach items="${itemBeansMap.value}" var="orderItem" varStatus="status">

	<c:choose>
		<c:when test="${orderItem.catalogEntryDataBean.package}">
			<c:set var="catalogEntry" value="${orderItem.catalogEntryDataBean.packageDataBean}"/>
			<c:set var="catalogEntryId" value="${catalogEntry.packageID}"/>
		</c:when>
		
		<c:when test="${orderItem.catalogEntryDataBean.item}">
			<c:set var="catalogEntry" value="${orderItem.catalogEntryDataBean.itemDataBean.parentProductDataBean}"/>
			<c:set var="catalogEntryId" value="${catalogEntry.productID}"/>
		</c:when>
		
		<c:otherwise>
			<c:set var="catalogEntry" value="${orderItem.catalogEntryDataBean.productDataBean}" />
			<c:set var="catalogEntryId" value="${catalogEntry.productID}"/>
		</c:otherwise>
	</c:choose>
	<c:choose>
		<c:when test="${rowClass eq 'cellBG_2'}">
			<c:set var="rowClass" value="cellBG_1"/>
		</c:when>
		<c:otherwise>
			<c:set var="rowClass" value="cellBG_2"/>
		</c:otherwise>
	</c:choose>
	<tr valign="top">
		<td class="<c:out value="${rowClass}"/> t_td" headers="WC_CurrentAndTotalCharges_Desc_2" id="WC_CurrentAndTotalCharges_Desc_2_<c:out value="${status.count}"/>">
			<c:url var="ProductDisplayURL" value="ProductDisplay">
				<c:param name="langId" value="${WCParam.langId}" />
				<c:param name="storeId" value="${WCParam.storeId}" />
				<c:param name="catalogId" value="${WCParam.catalogId}" />
				<c:param name="productId" value="${catalogEntryId}" />
				<c:param name="summaryOnly" value="true" />
			</c:url>
			<a href="<c:out value="${ProductDisplayURL}"/>" id="WC_CurrentAndTotalCharges_Link_2_<c:out value="${status.count}"/>">
				<c:out value="${catalogEntry.description.name}" escapeXml="false"  /><br/>
			</a>
			<%-- 
				***
				* Begin: display order item attributes
				***
			--%>			
			<c:if test="${orderItem.catalogEntryDataBean.item}">
					<%-- If the catentry is an item, we get all the attributes and attribute values for the item using AttributeValueDataBean and AttributeDataBean --%>
					<c:set var="item" value="${orderItem.catalogEntryDataBean.itemDataBean}" />
					<c:forEach var="attr" items="${item.attributeValueDataBeans}"> 	
						<c:set var="attribute" value="${attr.attributeDataBean}" />
							<c:if test="${attribute.definingAttribute}">
								<span class="strongtext"><c:out value="${attribute.name}" escapeXml="false"/>:
								<c:out value="${attr.value}" escapeXml="false"/></span><br/>
							</c:if>
					</c:forEach>
					<br/>
			</c:if>
			<%--  
				***
				* End: display order item attributes
				***  
			--%>
			<%-- Display the order item SKU number --%>
			<fmt:message key="OrderSummary_SKU" bundle="${orderText}"/> <c:out value="${orderItem.catalogEntryDataBean.partNumber}" escapeXml="false"/>
		</td>
		<td class="<c:out value="${rowClass}"/> t_td" align="center" headers="WC_CurrentAndTotalCharges_QTY_2" id="WC_CurrentAndTotalCharges_QTY_2_<c:out value="${status.count}"/>"><span class="t_cntr">
			<c:out value="${orderItem.formattedQuantity}" />
			</span>
		</td>
		<td class="<c:out value="${rowClass}"/> t_td" headers="WC_CurrentAndTotalCharges_Address_2" id="WC_CurrentAndTotalCharges_Address_2_<c:out value="${status.count}"/>">
		<flow:ifDisabled feature="GiftRegistry">
			<c:set var="address" value="${orderItem.addressDataBean}"/>
			<%-- Print the appropriate address information out depending on locale --%>				
			<%@ include file="../../../Snippets/ReusableObjects/AddressDisplay.jspf"%>
		</flow:ifDisabled>
		<flow:ifEnabled feature="GiftRegistry">
			<%--
				***  
				* Begin: hide registrant shipping addresses 
				***  
			--%>
			<c:remove var="grOrderItem" scope="page"/>
			<%@ include file="CurrentAndTotalGRCharges.jspf" %>
			<c:choose>
				<c:when test='${grOrderItem.shipToRegistrant == 1}'>
					<c:out value="${grOrderItem.addressDataBean.firstName} "/>
					<c:out value="${grOrderItem.addressDataBean.lastName}"/> <br/>
					<fmt:message key="GR_SHIPTO_REGISTRY" bundle="${storeText}"/>
					<c:out value=": ${grOrderItem.externalGiftRegistryId}"/>
					<br/>
				</c:when>
				<c:otherwise>
					<c:set var="address" value="${orderItem.addressDataBean}"/>
					<%-- Print the appropriate address information out depending on locale --%>				
					<%@ include file="../../../Snippets/ReusableObjects/AddressDisplay.jspf"%>
				</c:otherwise>
			</c:choose>
		</flow:ifEnabled>
		</td>
		<td class="<c:out value="${rowClass}"/> t_td" headers="WC_CurrentAndTotalCharges_Method_2" id="WC_CurrentAndTotalCharges_Method_2_<c:out value="${status.count}"/>">
			<c:out value="${orderItem.shippingModeDataBean.description.description}"/>
			<c:if test="${!empty orderItem.requestedShipDateYear}" > 
				<br />
				<fmt:message key="OrderSummary_REQUESTED_SHIP_DATE" bundle="${orderText}" />:
				<br />
				<c:out value="${orderItem.formattedRequestedShipDate}"/>
			</c:if>
			<c:if test="${orderItem.expedited}" >
				<br />
				<fmt:message key="OrderSummary_EXPEDITE" bundle="${orderText}" />
			</c:if>
		</td>
		<td class="<c:out value="${rowClass}"/> price t_td" headers="WC_CurrentAndTotalCharges_UnitPrice_2" id="WC_CurrentAndTotalCharges_UnitPrice_2_<c:out value="${status.count}"/>">
			<%-- 
				***
				* Begin: check item for listed price 
				***
			--%>
	
			<c:choose>
				<c:when test="${catalogEntry.listPriced}">
					<c:set var="orderItemListPriceString" value="${orderItem.catalogEntryDataBean.listPrice}"/>
					<c:set var="showListPrice" value="true"/>
					<%-- Compare to see if items listed price is less than the items price.  If it is less, then also show the item price --%>
					<c:if test="${ orderItem.catalogEntryDataBean.listPrice.amount <= orderItem.priceDataBean.amount }" > 
						<c:set var="showListPrice" value="false"/>					
					</c:if>
				</c:when>
				<c:otherwise>
					<c:set var="showListPrice" value="false" />	
				</c:otherwise>
			</c:choose>
			<%-- 
				***
				* End: check item for listed price 
				***
			--%>
			<%-- 
				***
				* Begin: display the items price and listed price if it is more then the items price 
				***
			--%>
			<c:choose>
				<%-- show both the list price & item price if list price is > item price --%>
				<c:when test="${showListPrice}">
					<%-- the empty gif are put in front of the prices so that the alt text can be read by the IBM Homepage Reader to describe the two prices displayed. 
					These descriptions are necessary for meeting Accessibility requirements --%>
					<a href="#" id="WC_CurrentAndTotalCharges_Link_7_<c:out value="${status.count}"/>"><img src="<c:out value="${snippetJspStoreImgDir}"/>images/empty.gif" alt="<fmt:message key="OrderSummary_RegularPriceIs" bundle="${orderText}" />" width="0" height="0" border="0"/></a>
					<span class="listPrice">
						<c:out value="${orderItemListPriceString}" escapeXml="false" />
					</span>
					<br/>
					<%-- the empty gif are put in front of the prices so that the alt text can be read by the IBM Homepage Reader to describe the two prices displayed. 
					These descriptions are necessary for meeting Accessibility requirements --%>
					<a href="#" id="WC_CurrentAndTotalCharges_Link_8_<c:out value="${status.count}"/>"><img src="<c:out value="${snippetJspStoreImgDir}"/>images/empty.gif" alt="<fmt:message key="OrderSummary_SalePriceIs" bundle="${orderText}" />" width="0" height="0" border="0" /></a>
					<span class="offerPrice">
						<c:out value="${orderItem.priceDataBean}" escapeXml="false" ><fmt:message key="OrderSummary_NO_PRICE_AVAILABLE" bundle="${orderText}" /></c:out>
					</span>
				</c:when>
				<%-- show only item price since it is greated than listed price --%>
				<c:otherwise>
					<%-- the empty gif are put in front of the prices so that the alt text can be read by the IBM Homepage Reader to describe the two prices displayed. 
					These descriptions are necessary for meeting Accessibility requirements --%>
					<a href="#" id="WC_CurrentAndTotalCharges_Link_9_<c:out value="${status.count}"/>"><img src="<c:out value="${snippetJspStoreImgDir}"/>images/empty.gif" alt="<fmt:message key="OrderSummary_PriceIs" bundle="${orderText}" />" width="1" height="1" border="0" /></a>
					<span class="price">
						<c:out value="${orderItem.priceDataBean}" escapeXml="false" ><fmt:message key="OrderSummary_NO_PRICE_AVAILABLE" bundle="${orderText}" /></c:out>
					</span>
				</c:otherwise>
			</c:choose>
		</td>
		<td class="<c:out value="${rowClass}"/> price t_td" headers="WC_CurrentAndTotalCharges_Total_2" id="WC_CurrentAndTotalCharges_Total_2_<c:out value="${status.count}"/>">
			<c:choose>
				<c:when test="${orderItem.free}">
					<%-- the OrderItem is a freebie --%>
					<span class="offerPrice"><fmt:message key="OrderSummary_SHOPCART_FREE" bundle="${orderText}"/></span>
				</c:when>
				<c:otherwise>
					<span class="price">
						<c:out value="${orderItem.formattedTotalProduct}" escapeXml="false" />
					</span>
	
				</c:otherwise>
			</c:choose>
		</td>
	</tr>
	<%--
	***
	* Begin: Gift Registry Order integration
	***
	--%>
	<%-- Display gift registry, if this is a gift item --%>
	<flow:ifEnabled feature="GiftRegistry">
	<c:if test='${!empty grOrderItem.externalGiftRegistryId}'>
	<tr>
	<td></td>
	<td colspan="5">
	<img src="<c:out value='${jspStoreImgDir}images/gift_item.gif'/>" border="0" alt="<fmt:message key='GR_GIFT_ITEM' bundle='${storeText}' />" />
	<span class="text">
	<fmt:message key='GR_GIFT_ITEM_FOR_REG' bundle='${storeText}' /> <c:out value="${grOrderItem.giftRegistryDB.description}"/><br/>
	</span>
	</td>
	</tr>
	<tr>
	<td colspan="6" class="c_line">&nbsp;</td>
	</tr>		
	</c:if>
	</flow:ifEnabled>
	<%--
	***
	* End: Gift Registry Order integration
	***
	--%> 
  </c:forEach>
 </c:forEach>

        <c:choose>
		<c:when test="${rowClass eq 'cellBG_2'}">
			<c:set var="rowClass" value="cellBG_1"/>
		</c:when>
		<c:otherwise>
			<c:set var="rowClass" value="cellBG_2"/>
		</c:otherwise>
	</c:choose>
	<tr>
		<td colspan="5" class="<c:out value="${rowClass}"/> price t_td" id="WC_CurrentAndTotalCharges_TableCell_5">
		<fmt:message key="OrderSummary_TOTAL_PRODUCT" bundle="${orderText}" /><br />
		<fmt:message key="OrderSummary_TOTAL_DISCOUNT" bundle="${orderText}" /><br />
		<fmt:message key="OrderSummary_TOTAL_SURCHARGE" bundle="${orderText}" /><br />
		<fmt:message key="OrderSummary_TOTAL_TAX" bundle="${orderText}" /><br />
		<c:if test="${showBaseShipAndAdjust}" >
			<fmt:message key="OrderSummary_TOTAL_ORIGINAL_SHIPPING" bundle="${orderText}" /><br />
			<fmt:message key="OrderSummary_TOTAL_SHIPPING_ADJUSTMENT" bundle="${orderText}" /><br />
		</c:if>
		<c:if test="${showAdjustedShipCharges}">
			<fmt:message key="OrderSummary_TOTAL_SHIPPING" bundle="${orderText}" /><br />
		</c:if>
		<fmt:message key="OrderSummary_TOTAL_SHIPPINGTAX" bundle="${orderText}" />
		</td>
		<c:set var="chargeTypesMap" value="${dateEntryMap.chargeTypes}"/>
		<td class="<c:out value="${rowClass}"/> price t_td" id="WC_CurrentAndTotalCharges_TableCell_6">
			<c:out value="${chargeTypesMap.productTotal}" escapeXml="false" /><br/>
			<c:out value="${chargeTypesMap.discountAdjustmentTotal}" escapeXml="false" /><br/>
			<c:out value="${chargeTypesMap.surchargeAdjustmentTotal}" escapeXml="false" /><br/>
			<c:out value="${chargeTypesMap.taxTotal}" escapeXml="false" /><br/>
			<c:if test="${showBaseShipAndAdjust}" >
			<c:out value="${chargeTypesMap.baseShippingTotal}" escapeXml="false" /><br/>
			<c:out value="${chargeTypesMap.shippingAdjustmentTotal}" escapeXml="false" /><br/>
			</c:if>			
			<c:if test="${showAdjustedShipCharges}" >
			<c:out value="${chargeTypesMap.shippingTotal}" escapeXml="false" /><br/>
			</c:if> 
			<c:out value="${chargeTypesMap.shippingTaxTotal}" escapeXml="false" />
		</td>
	</tr>
	<c:choose>
		<c:when test="${rowClass eq 'cellBG_2'}">
			<c:set var="rowClass" value="cellBG_1"/>
		</c:when>
		<c:otherwise>
			<c:set var="rowClass" value="cellBG_2"/>
		</c:otherwise>
	</c:choose>
	<tr valign="top">
		<td colspan="5" class="<c:out value="${rowClass}"/> price t_total" id="WC_CurrentAndTotalCharges_TableCell_7">
			<strong>
				<fmt:message key="OrderSummary_TOTAL_CHARGE" bundle="${orderText}" />
			</strong>
		</td>
		<td class="<c:out value="${rowClass}"/> price t_total_figure" id="WC_CurrentAndTotalCharges_TableCell_8">
			<c:out value="${chargeTypesMap.total}" escapeXml="false"/> 
		</td>
	</tr>
</table>
</c:forEach>
</c:if>
<%---
 ******
--%>

<h2>
	<fmt:message key="OrderSummary_TOTAL_CHARGE_HEAD" bundle="${orderText}" />
</h2>

<fmt:setBundle basename="${snippetJspStoreDir}tooltechtext" var="storeText" />
<fmt:message var="resultsText" key="SerRes_Text9" bundle="${storeText}">
	<fmt:param value="${beginIndex+1}"/>
	<fmt:param value="${resultCountOnPage}"/>
	<fmt:param value="${order_OrderDataBean.totalSize}"/>
</fmt:message>
<c:if test="${resultsText eq '???SerRes_Text9???'}">
	<fmt:setBundle basename="${snippetJspStoreDir}storetext" var="storeText" />
	<fmt:message var="resultsText" key="SEARCH_RESULT_LIST" bundle="${storeText}">
		<fmt:param value="${beginIndex+1}"/>
		<fmt:param value="${resultCountOnPage}"/>
		<fmt:param value="${order_OrderDataBean.totalSize}"/>
	</fmt:message>
</c:if>

<c:if test="${order_OrderDataBean.totalSize > pageSize}" >
				<c:forTokens items="${requestScope.requestURIPath}" delims="/" var="URLtoken">
					<c:set var="ReloadURL" value="${URLtoken}"/>
				</c:forTokens>

				<c:choose>
					<c:when test="${currentPage == 1}">
						<c:set var="prevPageIndex" value="1"/>
					</c:when>
					<c:otherwise>
						<c:set var="prevPageIndex" value="${currentPage - 1}"/>
					</c:otherwise>
				</c:choose>
				<c:choose>
					<c:when test="${pageSize*currentPage <= order_OrderDataBean.totalSize}">
						<c:set var="nextPageIndex" value="${currentPage + 1}"/>
					</c:when>
					<c:otherwise>
						<c:set var="nextPageIndex" value="${currentPage}"/>
					</c:otherwise>
				</c:choose>
				
				<c:url value="${ReloadURL}" var="FirstURL">
					<c:param name="storeId" value="${WCParam.storeId}"/>
					<c:param name="langId" value="${WCParam.langId}"/>
					<c:param name="catalogId" value="${WCParam.catalogId}"/>
					<c:param name="orderId" value="${order_OrderDataBean.orderId}"/>
					<c:param name="pageSize" value="${pageSize}"/>
					<c:param name="currentPage" value="1"/>
				</c:url>
				<c:url value="${ReloadURL}" var="PrevURL">
					<c:param name="storeId" value="${WCParam.storeId}"/>
					<c:param name="langId" value="${WCParam.langId}"/>
					<c:param name="catalogId" value="${WCParam.catalogId}"/>
					<c:param name="orderId" value="${order_OrderDataBean.orderId}"/>
					<c:param name="pageSize" value="${pageSize}"/>
					<c:param name="currentPage" value="${prevPageIndex}"/>
				</c:url>
				<c:url value="${ReloadURL}" var="NextURL">
					<c:param name="storeId" value="${WCParam.storeId}"/>
					<c:param name="langId" value="${WCParam.langId}"/>
					<c:param name="catalogId" value="${WCParam.catalogId}"/>
					<c:param name="orderId" value="${order_OrderDataBean.orderId}"/>
					<c:param name="pageSize" value="${pageSize}"/>
					<c:param name="currentPage" value="${nextPageIndex}"/>
				</c:url>
				<c:url value="${ReloadURL}" var="LastURL">
					<c:param name="storeId" value="${WCParam.storeId}"/>
					<c:param name="langId" value="${WCParam.langId}"/>
					<c:param name="catalogId" value="${WCParam.catalogId}"/>
					<c:param name="orderId" value="${order_OrderDataBean.orderId}"/>
					<c:param name="pageSize" value="${pageSize}"/>
					<c:param name="currentPage" value="${order_OrderDataBean.totalPages}"/>
				</c:url>		

		<table cellpadding="0" cellspacing="0" border="0" class="t_table" id="WC_CurrentAndTotalCharges_Table_2">
			<tr>
				<td id="WC_CurrentAndTotalCharges_TableCell_2">	
					<table cellpadding="0" cellspacing="0" border="0" id="WC_CurrentAndTotalCharges_Table_3">
					<form name="JumpToPageForm" action="<c:out value="${ReloadURL}" />" method="post" id="JumpToPageForm">
						<input type="hidden" name="storeId" value="<c:out value="${WCParam.storeId}" />" id="WC_CurrentAndTotalCharges_FormInput_storeId_In_JumpToPageForm_1"/>
						<input type="hidden" name="langId" value="<c:out value="${WCParam.langId}" />" id="WC_CurrentAndTotalCharges_FormInput_langId_In_JumpToPageForm_1"/>
						<input type="hidden" name="catalogId" value="<c:out value="${WCParam.catalogId}" />" id="WC_CurrentAndTotalCharges_FormInput_catalogId_In_JumpToPageForm_1"/>
						<input type="hidden" name="orderId" value="<c:out value="${order_OrderDataBean.orderId}" />" id="WC_CurrentAndTotalCharges_FormInput_orderId_In_JumpToPageForm_1"/>
						<input type="hidden" name="pageSize" value="" id="WC_CurrentAndTotalCharges_FormInput_pageSize_In_JumpToPageForm_1"/>
						<tr>
							<td id="WC_CurrentAndTotalCharges_TableCell_5"><a href="<c:out value="${FirstURL}" />" id="WC_CurrentAndTotalCharges_Link_1"><img src="<c:out value="${snippetJspStoreImgDir}${vfileColor}"/>ps_first.gif" alt="<fmt:message key="SEARCH_FIRST" bundle="${storeText}" />" width="14" height="14" border="0"></a></td>																					
							<td class="ps_pad" id="WC_CurrentAndTotalCharges_TableCell_6"><a href="<c:out value="${PrevURL}" />" id="WC_CurrentAndTotalCharges_Link_2"><img src="<c:out value="${snippetJspStoreImgDir}${vfileColor}"/>ps_previous.gif" alt="<fmt:message key="SEARCH_PREV" bundle="${storeText}" />" width="14" height="14" border="0"></a></td>
							<fmt:message var="pageNumberText" key="PAGE_NUMBER" bundle="${storeText}">
								<fmt:param><c:out value="${order_OrderDataBean.currentPage}" /></fmt:param>
								<fmt:param><c:out value="${order_OrderDataBean.totalPages}" /></fmt:param>
							</fmt:message>
							<td class="ps_text" id="WC_CurrentAndTotalCharges_TableCell_7"><c:out value="${pageNumberText}" /></td>																		
							<td class="ps_pad" id="WC_CurrentAndTotalCharges_TableCell_8"><a href="<c:out value="${NextURL}" />" id="WC_CurrentAndTotalCharges_Link_3"><img src="<c:out value="${snippetJspStoreImgDir}${vfileColor}"/>ps_next.gif" alt="<fmt:message key="SEARCH_NEXT" bundle="${storeText}" />" width="14" height="14" border="0"></a></td>									
							<td class="ps_pad" id="WC_CurrentAndTotalCharges_TableCell_9"><a href="<c:out value="${LastURL}" />" id="WC_CurrentAndTotalCharges_Link_4"><img src="<c:out value="${snippetJspStoreImgDir}${vfileColor}"/>ps_last.gif" alt="<fmt:message key="SEARCH_LAST" bundle="${storeText}" />" width="14" height="14" border="0"></a></td>
							<td class="ps_text" id="WC_CurrentAndTotalCharges_TableCell_10"><label for="WC_CurrentAndTotalCharges_JumpToPage"><fmt:message key="JUMP_TO_PAGE" bundle="${storeText}"/></label></td>
							<td class="ps_pad" id="WC_CurrentAndTotalCharges_TableCell_11"><input type="text" maxlength="4" size="3" class="ps_input" name="currentPage" id="WC_CurrentAndTotalCharges_JumpToPage"><input type="hidden" name="pageSize" value="<c:out value="${pageSize}"/>" id="WC_CurrentAndTotalCharges_FormInput_pageSize_In_JumpToPageForm_1"/></td>
							<td class="ps_pad" id="WC_CurrentAndTotalCharges_TableCell_12"><a href="javascript:jumpToPage(document.JumpToPageForm);" id="WC_CurrentAndTotalCharges_Link_5"><img src="<c:out value="${snippetJspStoreImgDir}${vfileColor}"/>ps_page_jump.gif" alt="<fmt:message key="SEARCH_JUMP" bundle="${storeText}" />" width="16" height="16" border="0"></a></td>
						</tr>
						</form>
					</table>
				</td>
				<td align="right" id="WC_CurrentAndTotalCharges_TableCell_12a">
					<table cellpadding="0" cellspacing="0" border="0" id="WC_CurrentAndTotalCharges_Table_3a">
						<tr>
							<c:set var="beginIndex" value="${currentPage*pageSize - pageSize}"/>
						  <c:set var="resultCountOnPage" value="${pageSize + beginIndex}"/>
							<c:choose>
								<c:when test="${resultCountOnPage > order_OrderDataBean.totalSize}">
									<c:set var="resultCountOnPage" value="${order_OrderDataBean.totalSize}"/>
								</c:when>
							</c:choose>
							<fmt:message var="resultsText" key="SEARCH_RESULT_LIST" bundle="${storeText}">
								<fmt:param value="${beginIndex+1}"/>
								<fmt:param value="${resultCountOnPage}"/>
								<fmt:param value="${order_OrderDataBean.totalSize}"/>
							</fmt:message>
							<td class="ps_text" id="WC_CurrentAndTotalCharges_TableCell_301"><c:out value="${resultsText}" /></td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
</c:if>

<table cellpadding="2" cellspacing="1" width="100%" class="bgColor" id="WC_CurrentAndTotalCharges_Table_3">
	<tr>
		<th class="colHeader" width="40%" id="WC_CurrentAndTotalCharges_Desc_3">
			<fmt:message key="OrderSummary_DESC" bundle="${orderText}" />
		</th>
		<th class="colHeader" id="WC_CurrentAndTotalCharges_QTY_3"><span class="t_hd_cntr">
			<fmt:message key="OrderSummary_QTY" bundle="${orderText}" /></span>
		</th>
		<th class="colHeader" id="WC_CurrentAndTotalCharges_Address_3">
			<fmt:message key="OrderSummary_ADDRESS" bundle="${orderText}" />
		</th>
		<th class="colHeader" id="WC_CurrentAndTotalCharges_Method_3">
			<fmt:message key="OrderSummary_SHIPPING_METHOD" bundle="${orderText}" />
		</th>
		<th class="colHeader" id="WC_CurrentAndTotalCharges_UnitPrice_3"><span class="t_hd_rght">
			<fmt:message key="OrderSummary_UNIT_EACH_PRICE" bundle="${orderText}" /></span>
		</th>
		<th class="colHeader_price" id="WC_CurrentAndTotalCharges_Total_3"><span class="t_hd_rght">
			<fmt:message key="OrderSummary_UNIT_TOTAL_PRICE" bundle="${orderText}" /></span>
		</th>
	</tr>
<c:set var="rowClass" value="cellBG_2"/>
<c:forEach items="${order_OrderDataBean.orderItemDataBeansInCurrentPage}" var="orderItem" varStatus="status">


	<c:choose>
		<c:when test="${orderItem.catalogEntryDataBean.package}">
			<c:set var="catalogEntry" value="${orderItem.catalogEntryDataBean.packageDataBean}"/>
			<c:set var="catalogEntryId" value="${catalogEntry.packageID}"/>
		</c:when>
		
		<c:when test="${orderItem.catalogEntryDataBean.item}">
			<c:set var="catalogEntry" value="${orderItem.catalogEntryDataBean.itemDataBean.parentProductDataBean}"/>
			<c:set var="catalogEntryId" value="${catalogEntry.productID}"/>
		</c:when>
		
		<c:otherwise>
			<c:set var="catalogEntry" value="${orderItem.catalogEntryDataBean.productDataBean}" />
			<c:set var="catalogEntryId" value="${catalogEntry.productID}"/>
		</c:otherwise>
	</c:choose>
	<c:choose>
		<c:when test="${rowClass eq 'cellBG_2'}">
			<c:set var="rowClass" value="cellBG_1"/>
		</c:when>
		<c:otherwise>
			<c:set var="rowClass" value="cellBG_2"/>
		</c:otherwise>
	</c:choose>
	<tr valign="top">
		<td class="<c:out value="${rowClass}"/> t_td" headers="WC_CurrentAndTotalCharges_Desc_3" id="WC_CurrentAndTotalCharges_Desc_3_<c:out value="${status.count}"/>">
			<c:url var="ProductDisplayURL" value="ProductDisplay">
				<c:param name="langId" value="${WCParam.langId}" />
				<c:param name="storeId" value="${WCParam.storeId}" />
				<c:param name="catalogId" value="${WCParam.catalogId}" />
				<c:param name="productId" value="${catalogEntryId}" />
				<c:param name="summaryOnly" value="true" />
			</c:url>
			<a href="<c:out value="${ProductDisplayURL}"/>" id="WC_CurrentAndTotalCharges_Link_3_<c:out value="${status.count}"/>">
				<c:out value="${catalogEntry.description.name}" escapeXml="false"  /><br/>
			</a>
			<%-- 
				***
				* Begin: display order item attributes
				***
			--%>			
			<c:if test="${orderItem.catalogEntryDataBean.item}">
					<%-- If the catentry is an item, we get all the attributes and attribute values for the item using AttributeValueDataBean and AttributeDataBean --%>
					<c:set var="item" value="${orderItem.catalogEntryDataBean.itemDataBean}" />
					<c:forEach var="attr" items="${item.attributeValueDataBeans}"> 	
						<c:set var="attribute" value="${attr.attributeDataBean}" />
							<c:if test="${attribute.definingAttribute}">
								<span class="strongtext"><c:out value="${attribute.name}" escapeXml="false"/>:
								<c:out value="${attr.value}" escapeXml="false"/></span><br/>
							</c:if>
					</c:forEach>
					<br/>
			</c:if>
			<%--  
				***
				* End: display order item attributes
				***  
			--%>
			<%-- Display the order item SKU number --%>
			<fmt:message key="OrderSummary_SKU" bundle="${orderText}"/> <c:out value="${orderItem.catalogEntryDataBean.partNumber}" escapeXml="false"/>
		</td>
		<td class="<c:out value="${rowClass}"/> t_td" align="center" headers="WC_CurrentAndTotalCharges_QTY_3" id="WC_CurrentAndTotalCharges_QTY_3_<c:out value="${status.count}"/>"><span class="t_cntr">
			<c:out value="${orderItem.formattedQuantity}" />
			</span>
		</td>
		<td class="<c:out value="${rowClass}"/> t_td" headers="WC_CurrentAndTotalCharges_Address_3" id="WC_CurrentAndTotalCharges_Address_3_<c:out value="${status.count}"/>">
		<flow:ifDisabled feature="GiftRegistry">
			<c:set var="address" value="${orderItem.addressDataBean}"/>
			<%-- Print the appropriate address information out depending on locale --%>				
			<%@ include file="../../../Snippets/ReusableObjects/AddressDisplay.jspf"%>
		</flow:ifDisabled>
		<flow:ifEnabled feature="GiftRegistry">
			<%--
				***  
				* Begin: hide registrant shipping addresses 
				***  
			--%>
			<c:remove var="grOrderItem" scope="page"/>
			<%@ include file="CurrentAndTotalGRCharges.jspf" %>
			<c:choose>
				<c:when test='${grOrderItem.shipToRegistrant == 1}'>
					<c:out value="${grOrderItem.addressDataBean.firstName} "/>
					<c:out value="${grOrderItem.addressDataBean.lastName}"/> <br/>
					<fmt:message key="GR_SHIPTO_REGISTRY" bundle="${storeText}"/>
					<c:out value=": ${grOrderItem.externalGiftRegistryId}"/>
					<br/>
				</c:when>
				<c:otherwise>
					<c:set var="address" value="${orderItem.addressDataBean}"/>
					<%-- Print the appropriate address information out depending on locale --%>				
					<%@ include file="../../../Snippets/ReusableObjects/AddressDisplay.jspf"%>
				</c:otherwise>
			</c:choose>
		</flow:ifEnabled>
		</td>
		<td class="<c:out value="${rowClass}"/> t_td" headers="WC_CurrentAndTotalCharges_Method_3" id="WC_CurrentAndTotalCharges_Method_3_<c:out value="${status.count}"/>">
			<c:out value="${orderItem.shippingModeDataBean.description.description}"/>
			<c:if test="${!empty orderItem.requestedShipDateYear}" > 
				<br />
				<fmt:message key="OrderSummary_REQUESTED_SHIP_DATE" bundle="${orderText}" />:
				<br />
				<c:out value="${orderItem.formattedRequestedShipDate}"/>
			</c:if>
			<c:if test="${orderItem.expedited}" >
				<br />
				<fmt:message key="OrderSummary_EXPEDITE" bundle="${orderText}" />
			</c:if>
		</td>
		<td class="<c:out value="${rowClass}"/> price t_td" headers="WC_CurrentAndTotalCharges_UnitPrice_3" id="WC_CurrentAndTotalCharges_UnitPrice_3_<c:out value="${status.count}"/>">
			<%-- 
				***
				* Begin: check item for listed price 
				***
			--%>
	
			<c:choose>
				<c:when test="${catalogEntry.listPriced}">
					<c:set var="orderItemListPriceString" value="${orderItem.catalogEntryDataBean.listPrice}"/>
					<c:set var="showListPrice" value="true"/>
					<%-- Compare to see if items listed price is less than the items price.  If it is less, then also show the item price --%>
					<c:if test="${ orderItem.catalogEntryDataBean.listPrice.amount <= orderItem.priceDataBean.amount }" > 
						<c:set var="showListPrice" value="false"/>					
					</c:if>
				</c:when>
				<c:otherwise>
					<c:set var="showListPrice" value="false" />	
				</c:otherwise>
			</c:choose>
			<%-- 
				***
				* End: check item for listed price 
				***
			--%>
			<%-- 
				***
				* Begin: display the items price and listed price if it is more then the items price 
				***
			--%>
			<c:choose>
				<%-- show both the list price & item price if list price is > item price --%>
				<c:when test="${showListPrice}">
					<%-- the empty gif are put in front of the prices so that the alt text can be read by the IBM Homepage Reader to describe the two prices displayed. 
					These descriptions are necessary for meeting Accessibility requirements --%>
					<a href="#" id="WC_CurrentAndTotalCharges_Link_10_<c:out value="${status.count}"/>"><img src="<c:out value="${snippetJspStoreImgDir}"/>images/empty.gif" alt="<fmt:message key="OrderSummary_RegularPriceIs" bundle="${orderText}" />" width="0" height="0" border="0"/></a>
					<span class="listPrice">
						<c:out value="${orderItemListPriceString}" escapeXml="false" />
					</span>
					<br/>
					<%-- the empty gif are put in front of the prices so that the alt text can be read by the IBM Homepage Reader to describe the two prices displayed. 
					These descriptions are necessary for meeting Accessibility requirements --%>
					<a href="#" id="WC_CurrentAndTotalCharges_Link_11_<c:out value="${status.count}"/>"><img src="<c:out value="${snippetJspStoreImgDir}"/>images/empty.gif" alt="<fmt:message key="OrderSummary_SalePriceIs" bundle="${orderText}" />" width="0" height="0" border="0" /></a>
					<span class="offerPrice">
						<c:out value="${orderItem.priceDataBean}" escapeXml="false" ><fmt:message key="OrderSummary_NO_PRICE_AVAILABLE" bundle="${orderText}" /></c:out>
					</span>
				</c:when>
				<%-- show only item price since it is greated than listed price --%>
				<c:otherwise>
					<%-- the empty gif are put in front of the prices so that the alt text can be read by the IBM Homepage Reader to describe the two prices displayed. 
					These descriptions are necessary for meeting Accessibility requirements --%>
					<a href="#" id="WC_CurrentAndTotalCharges_Link_12_<c:out value="${status.count}"/>"><img src="<c:out value="${snippetJspStoreImgDir}"/>images/empty.gif" alt="<fmt:message key="OrderSummary_PriceIs" bundle="${orderText}" />" width="1" height="1" border="0" /></a>
					<span class="price">
						<c:out value="${orderItem.priceDataBean}" escapeXml="false" ><fmt:message key="OrderSummary_NO_PRICE_AVAILABLE" bundle="${orderText}" /></c:out>
					</span>
				</c:otherwise>
			</c:choose>
		</td>
		<td class="<c:out value="${rowClass}"/> price t_td" headers="WC_CurrentAndTotalCharges_Total_3" id="WC_CurrentAndTotalCharges_Total_3_<c:out value="${status.count}"/>">
			<c:choose>
				<c:when test="${orderItem.free}">
					<%-- the OrderItem is a freebie --%>
					<span class="offerPrice"><fmt:message key="OrderSummary_SHOPCART_FREE" bundle="${orderText}"/></span>
				</c:when>
				<c:otherwise>
					<span class="price">
						<c:out value="${orderItem.formattedTotalProduct}" escapeXml="false" />
					</span>
				</c:otherwise>
			</c:choose>
		</td>
	</tr>

				<%--
					***
					* Begin: display tracking number
					***
				--%>
				<c:if test="${param.trackingNumber eq 'true'}" >														
					<c:set var="shipModeDB" value="${orderItem.shippingModeDataBean}" /> 					
					<tr>
						<td class="<c:out value="${rowClass}"/> price t_td" align="left" colspan="3" valign="top" id="WC_CurrentAndTotalCharges_Total_4_<c:out value="${status.count}"/>">
							<span class="strongtext"><c:out value="${shipmodeDB.carrier}" /></span>
						</td>
						<td class="<c:out value="${rowClass}"/> price t_td" align="left" colspan="3" valign="top" id="WC_CurrentAndTotalCharges_Total_5_<c:out value="${status.count}"/>">	
							<c:choose>
								<c:when test="${!empty orderItem.trackingIds}">
									<c:forEach var="trackingId" items="${orderItem.trackingIds}" varStatus="status">
										<a href="<c:out value="${shipModeDB.trackURL}"/>" target="_blank" id="WC_CurrentAndTotalCharges_Total_6_<c:out value="${status.count}"/><c:out value="${trackingId}"/>">
										<span class="strongtext"><fmt:message key="TRACKING_ID" bundle="${storeText}"/></span>: <c:out value="${trackingId}"/></a>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<span class="strongtext"><fmt:message key="TRACKING_ID" bundle="${storeText}"/></span>: <fmt:message key="NOT_AVAILABLE" bundle="${storeText}"/><br/>
								</c:otherwise>
							</c:choose>
						</td>							
					</tr>
				</c:if>		
				<%--
					***
					* End: display tracking number
					***
				--%>

	<%--
	***
	* Begin: Gift Registry Order integration
	***
	--%>
	<%-- Display gift registry, if this is a gift item --%>
	<flow:ifEnabled feature="GiftRegistry">
	<c:if test='${!empty grOrderItem.externalGiftRegistryId}'>
	<tr>
	<td></td>
	<td colspan="5">
	<img src="<c:out value='${jspStoreImgDir}images/gift_item.gif'/>" border="0" alt="<fmt:message key='GR_GIFT_ITEM' bundle='${storeText}' />" />
	<span class="text">
	<fmt:message key='GR_GIFT_ITEM_FOR_REG' bundle='${storeText}' /> <c:out value="${grOrderItem.giftRegistryDB.description}"/><br/>
	</span>
	</td>
	</tr>
	<tr>
	<td colspan="6" class="c_line">&nbsp;</td>
	</tr>		
	</c:if>
	</flow:ifEnabled>
	<%--
	***
	* End: Gift Registry Order integration
	***
	--%>   
</c:forEach>
	<c:choose>
		<c:when test="${rowClass eq 'cellBG_2'}">
			<c:set var="rowClass" value="cellBG_1"/>
		</c:when>
		<c:otherwise>
			<c:set var="rowClass" value="cellBG_2"/>
		</c:otherwise>
	</c:choose>
	<tr>
		<td colspan="5" class="<c:out value="${rowClass}"/> price t_td" id="WC_CurrentAndTotalCharges_TableCell_9">
		<fmt:message key="OrderSummary_TOTAL_PRODUCT" bundle="${orderText}" /><br />
		<fmt:message key="OrderSummary_TOTAL_DISCOUNT" bundle="${orderText}" /><br />
		<fmt:message key="OrderSummary_TOTAL_SURCHARGE" bundle="${orderText}" /><br />
		<fmt:message key="OrderSummary_TOTAL_TAX" bundle="${orderText}" /><br />
		<c:if test="${showBaseShipAndAdjust}" >
			<fmt:message key="OrderSummary_TOTAL_ORIGINAL_SHIPPING" bundle="${orderText}" /><br />
			<fmt:message key="OrderSummary_TOTAL_SHIPPING_ADJUSTMENT" bundle="${orderText}" /><br />
		</c:if>
		<c:if test="${showAdjustedShipCharges}">
			<fmt:message key="OrderSummary_TOTAL_SHIPPING" bundle="${orderText}" /><br />
		</c:if>
		<fmt:message key="OrderSummary_TOTAL_SHIPPINGTAX" bundle="${orderText}" />
		</td>
		<td class="<c:out value="${rowClass}"/> price t_td" id="WC_CurrentAndTotalCharges_TableCell_10">
		<c:out value="${order_OrderDataBean.formattedTotalProductPrice}" escapeXml="false" /><br />
		<c:out value="${order_OrderDataBean.formattedTotalDiscountAdjustment}" escapeXml="false" /><br />
		<c:out value="${order_OrderDataBean.formattedTotalSurchargeAdjustment}" escapeXml="false" /><br />
		<c:out value="${order_OrderDataBean.formattedTotalTax}" escapeXml="false" /><br />
		<c:if test="${showBaseShipAndAdjust}" >
			<c:out value="${order_OrderDataBean.formattedShippingCharge}" escapeXml="false"/><br />
			<c:out value="${order_OrderDataBean.formattedTotalShippingAdjustment}" escapeXml="false" /><br />
		</c:if>
		<c:if test="${showAdjustedShipCharges}">
			<c:out value="${order_OrderDataBean.formattedTotalShippingCharge}" escapeXml="false" /><br />
		</c:if>
		<c:out value="${order_OrderDataBean.formattedTotalShippingTax}" escapeXml="false" />
		</td>
	</tr>
	<c:choose>
		<c:when test="${rowClass eq 'cellBG_2'}">
			<c:set var="rowClass" value="cellBG_1"/>
		</c:when>
		<c:otherwise>
			<c:set var="rowClass" value="cellBG_2"/>
		</c:otherwise>
	</c:choose>
	<tr valign="top">
		<td colspan="5" class="<c:out value="${rowClass}"/> price t_total" id="WC_CurrentAndTotalCharges_TableCell_11">
			<strong>
				<fmt:message key="OrderSummary_TOTAL_CHARGE" bundle="${orderText}" />
			</strong>
		</td>
		<td class="<c:out value="${rowClass}"/> price t_total_figure" id="WC_CurrentAndTotalCharges_TableCell_12">
			<c:out value="${order_OrderDataBean.grandTotal}" escapeXml="false"/>
		</td>
	</tr>
</table>

<script type="text/javascript" language="javascript">
<!--<![CDATA[
function jumpToPage(form)
{
		var pageNumber = parseInt(form.currentPage.value);
    if ( pageNumber !="NaN" && pageNumber >=1 && pageNumber <= <c:out value="${order_OrderDataBean.totalPages}" /> ) {
    	 form.pageSize.value = document.JumpToPageForm.pageSize.value;
    	 form.currentPage.value = pageNumber;
       form.submit();
    } else {
    	alert("<fmt:message key="SEARCH_INVALID_PAGE_NUM" bundle="${storeText}"/>");
    }
}
//[[>-->
</script>
