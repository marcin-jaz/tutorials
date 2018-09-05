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

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<flow:ifEnabled feature="AjaxCheckout"> 
	<c:set var="isAjaxCheckout" value="true" />
</flow:ifEnabled>
<flow:ifDisabled feature="AjaxCheckout"> 
<form name="ShopCartForm" method="post" action="OrderChangeServiceItemUpdate" id="ShopCartForm">
	<c:set var="isAjaxCheckout" value="false" />
</flow:ifDisabled>

<flow:ifEnabled feature="AjaxAddToCart"> 
	<c:set var="isAjaxAddToCart" value="true" />
</flow:ifEnabled>
<flow:ifDisabled feature="AjaxAddToCart"> 
	<c:set var="isAjaxAddToCart" value="false" />
</flow:ifDisabled>

<flow:ifEnabled feature="AjaxMyAccountPage">
	<wcf:url var="WishListDisplayURL" value="AjaxLogonForm">
		<wcf:param name="storeId"   value="${WCParam.storeId}"  />
		<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
		<wcf:param name="langId" value="${langId}" />
		<wcf:param name="listId" value="." />    
		<wcf:param name="page" value="customerlinkwishlist"/>
	</wcf:url>
</flow:ifEnabled>
<flow:ifDisabled feature="AjaxMyAccountPage">
	<wcf:url var="WishListDisplayURL" value="NonAjaxAccountWishListDisplayView">
		<wcf:param name="storeId"   value="${WCParam.storeId}"  />
		<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
		<wcf:param name="langId" value="${langId}" />
		<wcf:param name="listId" value="." />           
	</wcf:url>
</flow:ifDisabled>

<wcf:url var="GuestWishListDisplayURL" value="InterestItemDisplay">
		<wcf:param name="storeId"   value="${WCParam.storeId}"  />
		<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
		<wcf:param name="langId" value="${langId}" />
		<wcf:param name="listId" value="." />           
	</wcf:url>

<c:choose>
	<c:when test="${userType eq 'G'}">
		<c:set var="interestItemDisplayURL" value="${GuestWishListDisplayURL}"/>
	</c:when>
	<c:otherwise>
		<c:set var="interestItemDisplayURL" value="${WishListDisplayURL}"/>
	</c:otherwise>
</c:choose>

<c:set var="search" value='"'/>
<c:set var="replaceStr" value="'"/>
<c:set var="search01" value="'"/>
<c:set var="replaceStr01" value="\\'"/>

<c:set var="pageSize" value="${WCParam.pageSize}" />
<c:if test="${empty pageSize}">
	<c:set var="pageSize" value="${maxOrderItemsPerPage}"/>
</c:if>

<c:set var="beginIndex" value="${WCParam.beginIndex}" />
<c:if test="${empty beginIndex}">
	<c:set var="beginIndex" value="0" />
</c:if>
	
<c:set var="pagorder" value="${requestScope.order}"/>
<c:set var="orderId" value="${WCParam.orderId}"/>

<c:choose>
	<c:when test="${(empty pagorder || pagorder == null) && (!empty orderId && orderId != null) && (!empty WCParam.fromPage && WCParam.fromPage == 'pendingOrderDisplay')}">
	
			<wcf:getData type="com.ibm.commerce.order.facade.datatypes.OrderType" scope="request" 
				var="pagorder" expressionBuilder="findByOrderIdWithPagingOnItem" varShowVerb="ShowVerbCart" maxItems="${pageSize}" recordSetStartNumber="${beginIndex}" recordSetReferenceId="ostatus">
				<wcf:param name="orderId" value="${orderId}" />	 
				<wcf:param name="sortOrderItemBy" value="orderItemID" />
				<wcf:param name="isSummary" value="false" />
			</wcf:getData>
			<c:if test="${beginIndex > ShowVerbCart.recordSetTotal}">
				<fmt:formatNumber var="totalPages" value="${(ShowVerbCart.recordSetTotal/pageSize)}"/>		
				<c:if test="${ShowVerbCart.recordSetTotal%pageSize < (pageSize/2)}">
					<fmt:parseNumber var="totalPages" value="${(ShowVerbCart.recordSetTotal+(pageSize/2)-1)/pageSize}"/>
				</c:if>
				<fmt:parseNumber var="totalPages" value="${totalPages}" integerOnly="true"/>
				<c:set var="beginIndex" value="${(totalPages-1)*pageSize}" />
				<wcf:getData type="com.ibm.commerce.order.facade.datatypes.OrderType" scope="request" 
					var="pagorder" expressionBuilder="findByOrderIdWithPagingOnItem" varShowVerb="ShowVerbCart" maxItems="${pageSize}" recordSetStartNumber="${beginIndex}" recordSetReferenceId="ostatus">
					<wcf:param name="orderId" value="${orderId}" />	 
					<wcf:param name="sortOrderItemBy" value="orderItemID" />
					<wcf:param name="isSummary" value="false" />
				</wcf:getData>
			</c:if>
	</c:when>
	<c:otherwise>
		<c:if test="${empty pagorder || pagorder == null}">
			<wcf:getData type="com.ibm.commerce.order.facade.datatypes.OrderType"
				var="pagorder" expressionBuilder="findCurrentShoppingCartWithPagingOnItem" varShowVerb = "ShowVerbCart" maxItems="${pageSize}" recordSetStartNumber="${beginIndex}" recordSetReferenceId="ostatus">
				<wcf:param name="accessProfile" value="IBM_Details" />	 
				<wcf:param name="sortOrderItemBy" value="orderItemID" />
				<wcf:param name="isSummary" value="false" />
			</wcf:getData>
			<c:if test="${beginIndex > ShowVerbCart.recordSetTotal}">
				<fmt:formatNumber var="totalPages" value="${(ShowVerbCart.recordSetTotal/pageSize)}"/>		
				<c:if test="${ShowVerbCart.recordSetTotal%pageSize < (pageSize/2)}">
					<fmt:parseNumber var="totalPages" value="${(ShowVerbCart.recordSetTotal+(pageSize/2)-1)/pageSize}"/>
				</c:if>
				<fmt:parseNumber var="totalPages" value="${totalPages}" integerOnly="true"/>
				<c:set var="beginIndex" value="${(totalPages-1)*pageSize}" />
				<wcf:getData type="com.ibm.commerce.order.facade.datatypes.OrderType"
					var="pagorder" expressionBuilder="findCurrentShoppingCartWithPagingOnItem" varShowVerb = "ShowVerbCart" maxItems="${pageSize}" recordSetStartNumber="${beginIndex}" recordSetReferenceId="ostatus">
					<wcf:param name="accessProfile" value="IBM_Details" />	 
					<wcf:param name="sortOrderItemBy" value="orderItemID" />
					<wcf:param name="isSummary" value="false" />
				</wcf:getData>
			</c:if>
		</c:if>		
	</c:otherwise>
</c:choose>

<c:if test="${beginIndex == 0}">
	<c:if test="${ShowVerbCart.recordSetTotal > ShowVerbCart.recordSetCount}">		
		<c:set var="pageSize" value="${ShowVerbCart.recordSetCount}" />
	</c:if>
</c:if>	

<c:set var="numEntries" value="${ShowVerbCart.recordSetTotal}"/>	

<c:if test="${numEntries > pageSize}">
	<fmt:formatNumber var="totalPages" value="${(numEntries/pageSize)}"/>		
	<c:if test="${numEntries%pageSize < (pageSize/2)}">
		<fmt:parseNumber var="totalPages" value="${(numEntries+(pageSize/2)-1)/pageSize}"/>
	</c:if>
	<fmt:parseNumber var="totalPages" value="${totalPages}" integerOnly="true"/> 
		
	<c:choose>
		<c:when test="${beginIndex + pageSize >= numEntries}">
			<c:set var="endIndex" value="${numEntries}" />
		</c:when>
		<c:otherwise>
			<c:set var="endIndex" value="${beginIndex + pageSize}" />
		</c:otherwise>
	</c:choose>

	<fmt:formatNumber var="currentPage" value="${(beginIndex/pageSize)+1}"/>
	<fmt:parseNumber var="currentPage" value="${currentPage}" integerOnly="true"/>

	<div id="ShopcartPaginationText1">
		<div class="textfloat">
		<fmt:message key="CATEGORY_RESULTS_DISPLAYING" bundle="${storeText}"> 
				<fmt:param><fmt:formatNumber value="${beginIndex + 1}"/></fmt:param>
				<fmt:param><fmt:formatNumber value="${endIndex}"/></fmt:param>
				<fmt:param><fmt:formatNumber value="${numEntries}"/></fmt:param>
		</fmt:message>
		</div>
		<div class="text textfloat divpadding">
		
			<c:if test="${beginIndex != 0}">	
					
				<c:choose>
					<c:when test="${param.fromPage == 'pendingOrderDisplay'}">
							<a id="ShopcartPaginationText1_1" href="javaScript:if(!CheckoutHelperJS.checkForDirtyFlag()){setCurrentId('ShopcartPaginationText1_1'); if(submitRequest()){ cursor_wait();
						wc.render.updateContext('PendingOrderPaginationDisplay_Context',{'beginIndex':'<c:out value='${beginIndex - pageSize}'/>','pageSize':'<c:out value='${pageSize}'/>'});}}">
				
					</c:when>
					<c:otherwise>
						<a id="ShopcartPaginationText1_1" href="javaScript:if(!CheckoutHelperJS.checkForDirtyFlag()){setCurrentId('ShopcartPaginationText1_1'); if(submitRequest()){ cursor_wait();
					wc.render.updateContext('ShopCartPaginationDisplay_Context',{'beginIndex':'<c:out value='${beginIndex - pageSize}'/>','pageSize':'<c:out value='${pageSize}'/>'});}}">
				
					</c:otherwise>
				</c:choose>
				
				</c:if>
				
					<img src="<c:out value="${jspStoreImgDir}${vfileColorBIDI}" />paging_back.png" alt="<fmt:message key="CATEGORY_PAGING_LEFT_IMAGE" bundle="${storeText}"/>" />
				
				<c:if test="${beginIndex != 0}">
					</a>
				</c:if>
			<span>
			
			<fmt:message key="CATEGORY_RESULTS_PAGES_DISPLAYING" bundle="${storeText}"> 
					<fmt:param><fmt:formatNumber value="${currentPage}"/></fmt:param>
					<fmt:param><fmt:formatNumber value="${totalPages}"/></fmt:param>
				</fmt:message>
			
			</span>
				
				<c:if test="${numEntries > endIndex }">
				<c:choose>
					<c:when test="${param.fromPage == 'pendingOrderDisplay'}">
							<a id="ShopcartPaginationText1_2" href="javaScript:if(!CheckoutHelperJS.checkForDirtyFlag()){setCurrentId('ShopcartPaginationText1_2'); if(submitRequest()){ cursor_wait();
						wc.render.updateContext('PendingOrderPaginationDisplay_Context',{'beginIndex':'<c:out value='${beginIndex + pageSize}'/>','pageSize':'<c:out value='${pageSize}'/>'});}}">
				
					</c:when>
					<c:otherwise>
						<a id="ShopcartPaginationText1_2" href="javaScript:if(!CheckoutHelperJS.checkForDirtyFlag()){setCurrentId('ShopcartPaginationText1_2'); if(submitRequest()){ cursor_wait();
						wc.render.updateContext('ShopCartPaginationDisplay_Context',{'beginIndex':'<c:out value='${beginIndex + pageSize}'/>','pageSize':'<c:out value='${pageSize}'/>'});}}">
					
					</c:otherwise>
				</c:choose>
					</c:if>
				<img src="<c:out value="${jspStoreImgDir}${vfileColorBIDI}" />paging_next.png" alt="<fmt:message key="CATEGORY_PAGING_RIGHT_IMAGE" bundle="${storeText}"/>" />
				<c:if test="${numEntries > endIndex }">
					</a>
				</c:if>
		
		</div>
	</div>
	<div class="clear_float"></div>
</c:if> 

<c:set var="allContractsValid" value="true" scope="request"/>
<table id="order_details" cellpadding="0" cellspacing="0" border="0" width="100%" summary="<fmt:message key="SHOPCART_TABLE_SUMMARY" bundle="${storeText}"/>">
	  <tr class="nested">
		   <th class="align_left" id="shoppingCart_tableCell_productName"><fmt:message key="SHOPCART_PRODUCT" bundle="${storeText}"/></th>
		   <th class="align_left" id="shoppingCart_tableCell_availability"><fmt:message key="SHOPCART_AVAILABILITY" bundle="${storeText}"/></th>
		   <th class="align_center" id="shoppingCart_tableCell_quantity" abbr="<fmt:message key="QUANTITY1" bundle="${storeText}"/>"><fmt:message key="SHOPCART_QTY" bundle="${storeText}"/></th>
		   <th class="align_right" id="shoppingCart_tableCell_each" abbr="<fmt:message key="UNIT_PRICE" bundle="${storeText}"/>"><fmt:message key="SHOPCART_EACH" bundle="${storeText}"/></th>
		   <th class="align_right" id="shoppingCart_tableCell_total" abbr="<fmt:message key="TOTAL_PRICE" bundle="${storeText}"/>"><fmt:message key="SHOPCART_TOTAL" bundle="${storeText}"/></th>
	  </tr>
	
<flow:ifDisabled feature="AjaxCheckout">                                 
	
	<input type="hidden" name="storeId" value='<c:out value="${storeId}"/>' id="WC_OrderItemDetailsf_inputs_5"/>
	<input type="hidden" name="langId" value='<c:out value="${langId}" />' id="WC_OrderItemDetailsf_inputs_6"/>
	<input type="hidden" name="orderId" value='<c:out value="${pagorder.orderIdentifier.uniqueID}"/>' id="WC_OrderItemDetailsf_inputs_7"/>
	<input type="hidden" name="catalogId" value='<c:out value="${catalogId}"/>' id="WC_OrderItemDetailsf_inputs_8"/>
	<c:choose>
		<c:when test="${param.fromPage == 'pendingOrderDisplay'}">
			<input type="hidden" name="URL" id="WC_OrderItemDetailsf_inputs_4" value='PendingOrderDisplayView?orderId=<c:out value="${pagorder.orderIdentifier.uniqueID}"/>&catalogId=<c:out value="${catalogId}"/>&storeId=<c:out value="${storeId}"/>&langId=<c:out value="${langId}"/>'/>
			<input type="hidden" name="errorViewName" value="PendingOrderDisplayView" id="WC_OrderItemDetailsf_inputs_9"/>
		</c:when>
		<c:otherwise>
			<input type="hidden" name="URL" id="WC_OrderItemDetailsf_inputs_4" value='AjaxOrderItemDisplayView?&orderItem*=&quantity*=&selectedAttr*=&catalogId_*=&beginIndex*=&orderId*='/>
			<input type="hidden" name="errorViewName" value="AjaxOrderItemDisplayView" id="WC_OrderItemDetailsf_inputs_9"/>
		</c:otherwise>
	</c:choose>
				
		
	<input type="hidden" name="calculationUsage" value="-1,-2,-3,-4,-5,-6,-7" id="WC_OrderItemDetailsf_inputs_10"/>
							
</flow:ifDisabled>
	
	<c:if test="${pagorder.orderItem != null && !empty pagorder.orderItem}">
		<wcf:getData type="com.ibm.commerce.catalog.facade.datatypes.CatalogEntryType[]" var="catalogEntriesForAttributes" expressionBuilder="getStoreCatalogEntryAttributesByIDs">
			<wcf:contextData name="storeId" data="${WCParam.storeId}"/>
			<c:forEach var="orderItem" items="${pagorder.orderItem}">
				<wcf:param name="UniqueID" value="${orderItem.catalogEntryIdentifier.uniqueID}"/>
			</c:forEach>
			<wcf:param name="dataLanguageIds" value="${WCParam.langId}"/>
		</wcf:getData>
	</c:if>
	
	<%--
		The following snippet retrieves all the catalog entries associated with each item in the current order.
		It was taken out of the larger c:forEach loop below for performance reasons.
	--%>
	<jsp:useBean id="catalogEntryDataBeansInThisOrder" class="java.util.HashMap" scope="page"/>
	<c:forEach var="orderItem0" items="${pagorder.orderItem}" varStatus="status">
		<wcbase:useBean id="catalogEntryDataBean" classname="com.ibm.commerce.catalog.beans.CatalogEntryDataBean" scope="request">
			<c:set property="catalogEntryID" value="${orderItem0.catalogEntryIdentifier.uniqueID}" target="${catalogEntryDataBean}" />
		</wcbase:useBean>
		<c:if test="${empty catalogEntryDataBeansInThisOrder[orderItem0.catalogEntryIdentifier.uniqueID]}">
			<c:set property="${orderItem0.catalogEntryIdentifier.uniqueID}" value="" target="${catalogEntryDataBeansInThisOrder}"/>
		</c:if>
		<c:set property="${orderItem0.catalogEntryIdentifier.uniqueID}" value="${catalogEntryDataBean}" target="${catalogEntryDataBeansInThisOrder}"/>
		<c:remove var="catalogEntryDataBean"/>
	</c:forEach>
	
	
	<%-- 
		The following code snippet checks if the catalog entry of any item in the current order has entitled items.  
	--%>
	<c:set var="hasEntitledItems" value="false"/>
	<c:forEach var="currentOrderItem" items="${pagorder.orderItem}" varStatus="count">
		<c:if test="${!hasEntitledItems}">
			<c:set var="currentCatEntry" value="${catalogEntryDataBeansInThisOrder[currentOrderItem.catalogEntryIdentifier.uniqueID]}"/>
			<c:if test="${!empty currentCatEntry.itemDataBean.parentProductDataBean.entitledItems}">	
				<c:set var="hasEntitledItems" value="true"/>
			</c:if>
		</c:if>
	</c:forEach>
	
	
	<%-- 
		The following snippet retrieves all the SKUs for each catalog entry associated with each item in the current oder.
		It was taken out of the larger c:forEach loop below for performance reasons.
	--%>
	<c:if test="${hasEntitledItems}">
		<wcf:getData type="com.ibm.commerce.catalog.facade.datatypes.CatalogEntryType[]" var="skus" expressionBuilder="getStoreCatalogEntryAttributesByIDs">
			<wcf:contextData name="storeId" data="${param.storeId}"/>
			<c:forEach var="orderItem1" items="${pagorder.orderItem}">
				<c:set var="catalogEntryForThisOrderItem" value="${catalogEntryDataBeansInThisOrder[orderItem1.catalogEntryIdentifier.uniqueID]}"/>
				<c:forEach var='entitledItemForThisCatEntry' items='${catalogEntryForThisOrderItem.itemDataBean.parentProductDataBean.entitledItems}' varStatus='outerStatus1'>	
					<wcf:param name="UniqueID" value="${entitledItemForThisCatEntry.itemID}"/>
				</c:forEach>
			</c:forEach>
			<wcf:param name="dataLanguageIds" value="${WCParam.langId}"/>
		</wcf:getData>
	</c:if>
	
	
	<c:forEach var="orderItem" items="${pagorder.orderItem}" varStatus="status">
		<c:set var="catEntry" value="${catalogEntryDataBeansInThisOrder[orderItem.catalogEntryIdentifier.uniqueID]}"/>
		
		<c:choose>
			<c:when test="${empty useClickInfoURL || useClickInfoURL == false}">
				<%-- The URL that links to the display page --%>
				<wcf:url var="catEntryDisplayUrl" value="Product2">
				    <wcf:param name="catalogId" value="${WCParam.catalogId}"/>
				    <wcf:param name="storeId" value="${WCParam.storeId}"/>
				    <wcf:param name="productId" value="${catEntry.catalogEntryID}"/>
				    <wcf:param name="langId" value="${langId}"/>
				    <wcf:param name="errorViewName" value="ProductDisplayErrorView"/>
					<wcf:param name="categoryId" value="${WCParam.categoryId}" />
					<c:choose>
						<%-- Use the context parameters if they are available; usually in a subcategory --%>			
						<c:when test="${!empty WCParam.parent_category_rn && !empty WCParam.top_category}">
							<wcf:param name="parent_category_rn" value="${WCParam.parent_category_rn}" />
							<wcf:param name="top_category" value="${WCParam.top_category}" />
						</c:when>
						<%-- In a top category; use top category parameters --%>
						<c:when test="${WCParam.top == 'Y'}">
							<wcf:param name="parent_category_rn" value="${WCParam.categoryId}" />
							<wcf:param name="top_category" value="${WCParam.categoryId}" />
						</c:when>
						<%-- Store front main page; usually eSpots, parents unknown --%>
						<c:otherwise>
							<wcf:param name="parent_category_rn" value="" />
							<wcf:param name="top_category" value="" />
						</c:otherwise>
					</c:choose>
				</wcf:url>
			</c:when>
			<c:otherwise>
				<c:set var="catEntryDisplayUrl" value="${ClickInfoURL}"/>
			</c:otherwise>
		</c:choose>
		
		
		
		<%-- If this is a product and has defining attributes, then allow user to change --%>
		<c:set var="parentCatEntry" value="${catEntry.itemDataBean.parentProductDataBean.productID}"/>
		<c:if test="${!empty parentCatEntry}">
			<c:set var="items1" value="${catEntry.itemDataBean.parentProductDataBean.entitledItems}"/>
			<div id="entitledItem_<c:out value='${parentCatEntry}'/>" style="display:none;">
				[						
			 	<c:forEach var='entitledItem' items='${items1}' varStatus='outerStatus'>	
					{
						"orderItemId_remove":"<c:out value="${orderItem.orderItemIdentifier.uniqueID}" />",
						"catentry_id" : "<c:out value='${entitledItem.itemID}' />",
						"Attributes" :	{
							<c:set var="hasAttributes" value="false"/>
							<c:forEach var="sku" items="${skus}">
								<c:if test="${sku.catalogEntryIdentifier.uniqueID eq entitledItem.itemID}">
									<c:forEach var="definingAttrValue2" items="${sku.catalogEntryAttributes.attributes}" varStatus="innerStatus">
										<c:if test="${definingAttrValue2.usage == 'Defining'}">
											<c:if test='${hasAttributes eq "true"}'>,</c:if>
											"<c:out value="${fn:replace(definingAttrValue2.name, search01, replaceStr01)}_${fn:replace(definingAttrValue2.value.value, search01, replaceStr01)}" />":"<c:out value='${innerStatus.count}' />"
											<c:set var="hasAttributes" value="true"/>
										</c:if>
									</c:forEach>
								</c:if>
							</c:forEach>
						}
					}<c:if test='${!outerStatus.last}'>,</c:if>
				</c:forEach>
				]
			</div>
		</c:if>

		<%-- get the formatted qty for this item --%>
		<fmt:formatNumber var="quickCartOrderItemQuantity" value="${orderItem.quantity.value}"  pattern='#####'/>
		<%-- keep setting total number of items variable..in the last loop, it will contain correct value :-)better to get this value using length function.. --%>
		<c:set var="totalNumberOfItems" value="${status.count}"/>
		<input type="hidden" value='<c:out value="${orderItem.orderItemIdentifier.uniqueID}"/>' name='orderItem_<c:out value="${status.count}"/>' id='orderItem_<c:out value="${status.count}"/>'/>
		<input type="hidden" value='<c:out value="${orderItem.catalogEntryIdentifier.uniqueID}"/>' name='catalogId_<c:out value="${status.count}"/>' id='catalogId_<c:out value="${status.count}"/>'/>
		<tr>
		
			<c:forEach var="discounts" items="${orderItem.orderItemAmount.adjustment}">			
					<%-- only show the adjustment detail if display level is OrderItem, if display level is order, display it at the order summary section --%>
					<c:if test="${discounts.displayLevel == 'OrderItem'}">
						<c:set var="nobottom" value="th_align_left_no_bottom"/>
					</c:if>
			</c:forEach>
			<th class="th_align_left_normal <c:out value="${nobottom}"/>" id="shoppingCart_rowHeader_product<c:out value='${status.count}'/>" abbr="<fmt:message key="Checkout_ACCE_for" bundle="${storeText}"/> <c:out value="${fn:replace(catEntry.description.name, search, replaceStr)}" escapeXml="false"/>">
				<div class="img" id="WC_OrderItemDetailsf_div_1_<c:out value='${status.count}'/>">
					<c:set var="catEntryIdentifier" value="${catEntry.catalogEntryID}"/>
					<c:set var="pageView" value="imageOnlyDisplay"/>
					<c:set var="showTooltip" value="false"/>
					<c:set var="add2CartForm" value="false"/>
					<%@ include file="../../../Snippets/ReusableObjects/CatalogEntryDBThumbnailDisplay.jspf" %>   
				</div>
				<div id="WC_OrderItemDetailsf_div_2_<c:out value='${status.count}'/>">
					<p><a href="<c:out value="${catEntryDisplayUrl}"/>"><c:out value="${catEntry.description.name}" escapeXml="false"/></a></p>
					<span><fmt:message key="CurrentOrder_SKU" bundle="${storeText}"/> <c:out value="${catEntry.partNumber}" escapeXml="false"/></span><br/>	
					<c:if test="${orderItem.orderItemAmount.freeGift}">
						<p class="italic"><fmt:message key="SHOPCART_FREEGIFT" bundle="${storeText}"/></p>
					</c:if>
					<br />
					<%--
					 ***
					 * Start: Display Defining attributes
					 * Loop through the attribute values and display the defining attributes
					 ***
					--%>
					<c:if test="${!orderItem.orderItemAmount.freeGift}">
						<c:forEach var="catalogEntry1" items="${catalogEntriesForAttributes}">
							<c:if test="${catalogEntry1.catalogEntryIdentifier.uniqueID == orderItem.catalogEntryIdentifier.uniqueID}">
							<c:remove var="selectedAttr"/>
								<c:forEach var="attribute" items="${catalogEntry1.catalogEntryAttributes.attributes}" varStatus="status2">
									<c:if test="${ attribute.usage=='Defining' }" >	
										<c:choose>
											<c:when test="${empty selectedAttr}">
												<c:set var="selectedAttr" value="${attribute.value.value}"/>
											</c:when>
											<c:otherwise>
												<c:set var="selectedAttr" value="${selectedAttr}|${attribute.value.value}"/>
											</c:otherwise>
										</c:choose>
									</c:if>
								</c:forEach>
								<c:if test="${!empty selectedAttr}">
								<a class="order_link" id="WC_OrderItemDetailsf_links_1_<c:out value='${status.count}'/>_<c:out value='${status2.count}'/>" href="javascript:;"  
									onClick="JavaScript:var actionListAttribute = new popupActionProperties(); actionListAttribute.showAddToCart=false; actionListAttribute.showWishList=false; actionListAttribute.showProductCompare=false; actionListAttribute.showReplaceCartItem=true; showPopup('<c:out value='${parentCatEntry}'/>','<c:out value='${WCParam.storeId}'/>','<c:out value='${WCParam.langId}'/>','<c:out value='${WCParam.catalogId}'/>',event,null,'',actionListAttribute,${quickCartOrderItemQuantity}); saveChangeOrderItemId('<c:out value='${orderItem.orderItemIdentifier.uniqueID}'/>');"> 
									<fmt:message key="CHANGE_ATTRIBUTES" bundle="${storeText}"/>
								</a>
								<br/>
								</c:if>
								<input type="hidden" name="selectedAttr" id="selectedAttr_${orderItem.orderItemIdentifier.uniqueID}" value="${selectedAttr}"/>
							</c:if>
						</c:forEach>
					</c:if>
					<%--
					 ***
					 * End: Display Defining attributes
					 ***
					--%>
					             
					<c:set var="fromPage" value="${param.fromPage}" scope="request"/>
					<c:set var="orderId" value="${pagorder.orderIdentifier.uniqueID}" scope="request"/>
					
					<c:if test="${!orderItem.orderItemAmount.freeGift}">
						<c:set var="isShoppingCartPage" value="true"/>
						<%@ include file="B2BContractSelectExt.jspf" %>						
						<p tabindex="0">
							<flow:ifEnabled feature="AjaxCheckout">
								<a id="WC_OrderItemDetailsf_links_2_<c:out value='${status.count}'/>" href="JavaScript:setCurrentId('WC_OrderItemDetailsf_links_2_<c:out value='${status.count}'/>'); CheckoutHelperJS.deleteFromCart('<c:out value='${orderItem.orderItemIdentifier.uniqueID}'/>');">
									<img src="<c:out value='${jspStoreImgDir}${vfileColor}'/>table_x_delete.png" alt="<fmt:message key="SHOPCART_REMOVE" bundle="${storeText}"/>"/>
									<fmt:message key="SHOPCART_REMOVE" bundle="${storeText}"/>
								</a>
							</flow:ifEnabled>
							<flow:ifDisabled feature="AjaxCheckout">
								<wcf:url var="OrderItemDelete" value="OrderChangeServiceItemDelete">
									<wcf:param name="orderItemId" value="${orderItem.orderItemIdentifier.uniqueID}"/>
									<wcf:param name="orderId" value="${pagorder.orderIdentifier.uniqueID}"/>
									<wcf:param name="langId" value="${WCParam.langId}" />
									<wcf:param name="storeId" value="${WCParam.storeId}" />
									<wcf:param name="catalogId" value="${WCParam.catalogId}" />
									<wcf:param name="calculationUsage" value="-1,-2,-3,-4,-5,-6,-7" />
									<c:choose>
										<c:when test="${param.fromPage != null && param.fromPage == 'pendingOrderDisplay'}">
											<wcf:param name="URL" value="PendingOrderDisplayView" />
											<wcf:param name="errorViewName" value="PendingOrderDisplayView" />
										</c:when>
										<c:otherwise>
											<wcf:param name="URL" value="AjaxOrderItemDisplayView" />
											<wcf:param name="errorViewName" value="AjaxOrderItemDisplayView" />
										</c:otherwise>
									</c:choose>
									
									<wcf:param name="beginIndex" value="${beginIndex}" />
								</wcf:url>
								<a href="#" onclick="Javascript:setPageLocation('<c:out value='${OrderItemDelete}'/>');return false;" id="WC_OrderItemDetailsf_links_3_<c:out value='${status.count}'/>">
									<img src="<c:out value='${jspStoreImgDir}${vfileColor}'/>table_x_delete.png" alt="<fmt:message key="SHOPCART_REMOVE" bundle="${storeText}" />"/>
									<fmt:message key="SHOPCART_REMOVE" bundle="${storeText}" />
								</a>
							</flow:ifDisabled>
						</p>
						<flow:ifEnabled feature="wishList">
							<p tabindex="0">
							
							<%-- The following choose statement handles all aplicable cases of change flow: AjaxCheckout and AjaxAddToCart--%>
								<c:choose>
									<c:when test="${isAjaxCheckout && isAjaxAddToCart}">
										<a id="WC_OrderItemDetailsf_links_4_<c:out value='${status.count}'/>" href="JavaScript:setCurrentId('WC_OrderItemDetailsf_links_4_<c:out value='${status.count}'/>'); CheckoutHelperJS.addToWishListAndDeleteFromCart('<c:out value='${orderItem.catalogEntryIdentifier.uniqueID}'/>','<c:out value='${orderItem.orderItemIdentifier.uniqueID}'/>');">
											<img src="<c:out value='${jspStoreImgDir}${vfileColor}'/>table_plus_add.png" alt="<fmt:message key="MOVE_TO_WISH_LIST" bundle="${storeText}"/>"/>
											<fmt:message key="MOVE_TO_WISH_LIST" bundle="${storeText}"/>
										</a>
									</c:when>
									<c:when test="${(isAjaxCheckout && !isAjaxAddToCart) || (!isAjaxCheckout && !isAjaxAddToCart)}">	
										<wcf:url var="OrderItemMove" value="OrderChangeServiceItemDelete">
											<wcf:param name="storeId"   value="${WCParam.storeId}"  />
											<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
											<wcf:param name="langId" value="${langId}" />
											<wcf:param name="orderItemId" value="${orderItem.orderItemIdentifier.uniqueID}"/>
											<wcf:param name="orderId" value="${pagorder.orderIdentifier.uniqueID}"/>
											<wcf:param name="catEntryId" value="${orderItem.catalogEntryIdentifier.uniqueID}" />
											<wcf:param name="URL" value="InterestItemAdd?URL=${interestItemDisplayURL}" />
											<wcf:param name="errorViewName" value="AjaxOrderItemDisplayView" />
											<wcf:param name="updateable" value="0" />
										</wcf:url>
										<a href="#" onclick="Javascript:setPageLocation('<c:out value='${OrderItemMove}'/>');return false;" id="WC_OrderItemDetailsf_links_4a_<c:out value='${status.count}'/>">
											<img src="<c:out value='${jspStoreImgDir}${vfileColor}'/>table_plus_add.png" alt="<fmt:message key="MOVE_TO_WISH_LIST" bundle="${storeText}"/>"/>
											<fmt:message key="MOVE_TO_WISH_LIST" bundle="${storeText}"/>
										</a>
									</c:when>
									<c:when test="${!isAjaxCheckout && isAjaxAddToCart}">
										<wcf:url var="OrderItemMove" value="OrderChangeServiceItemDelete">
											<wcf:param name="orderItemId" value="${orderItem.orderItemIdentifier.uniqueID}"/>
											<wcf:param name="orderId" value="${pagorder.orderIdentifier.uniqueID}"/>
											<wcf:param name="langId" value="${WCParam.langId}" />
											<wcf:param name="storeId" value="${WCParam.storeId}" />
											<wcf:param name="catalogId" value="${WCParam.catalogId}" />
										<wcf:param name="catEntryId" value="${orderItem.catalogEntryIdentifier.uniqueID}" />
										<c:choose>
											<c:when test="${param.fromPage != null && param.fromPage == 'pendingOrderDisplay'}">
												<wcf:param name="URL" value="InterestItemAdd?URL=PendingOrderDisplayView?orderId=${pagorder.orderIdentifier.uniqueID}" />
												<wcf:param name="errorViewName" value="PendingOrderDisplayView" />
											</c:when>
											<c:otherwise>
												<wcf:param name="URL" value="InterestItemAdd?URL=AjaxOrderItemDisplayView" />
												<wcf:param name="errorViewName" value="AjaxOrderItemDisplayView" />
											</c:otherwise>
										</c:choose>
										
										<wcf:param name="beginIndex" value="${beginIndex}" />
										<wcf:param name="calculationUsage" value="-1,-2,-3,-4,-5,-6,-7" />
										<wcf:param name="updateable" value="0" />
									</wcf:url>
									<a href="#" onclick="Javascript:setPageLocation('<c:out value='${OrderItemMove}'/>');return false;" id="WC_OrderItemDetailsf_links_5_<c:out value='${status.count}'/>">
										<img src="<c:out value='${jspStoreImgDir}${vfileColor}'/>table_plus_add.png" alt="<fmt:message key="MOVE_TO_WISH_LIST" bundle="${storeText}"/>"/>
										<fmt:message key="MOVE_TO_WISH_LIST" bundle="${storeText}"/>
									</a>
									</c:when>
								</c:choose>
							</p>
						</flow:ifEnabled>
					</c:if>
				</div>
			</th>
			<td id="WC_OrderItemDetailsf_td_1_<c:out value='${status.count}'/>" class="<c:out value="${nobottom}"/> avail" headers="shoppingCart_tableCell_availability shoppingCart_rowHeader_product<c:out value='${status.count}'/>">
				<p>
					<c:catch>
						<fmt:parseDate var="availableDate" value="${orderItem.orderItemFulfillmentInfo.availableDate}" pattern="yyyy-MM-dd'T'HH:mm:ss.SSS'Z'" timeZone="GMT"/>
					</c:catch>
					<c:if test="${empty availableDate}">
						<c:catch>
							<fmt:parseDate var="availableDate" value="${orderItem.orderItemFulfillmentInfo.availableDate}" pattern="yyyy-MM-dd'T'HH:mm:ss'Z'" timeZone="GMT"/>
						</c:catch>
					</c:if>
					<jsp:useBean id="now" class="java.util.Date" />
					
					<c:choose>
						<c:when test="${empty availableDate}">
							<c:choose>
								<c:when test="${(orderItem.orderItemStatus.inventoryStatus == 'Available') || (orderItem.orderItemStatus.inventoryStatus == 'Allocated')}">
									<fmt:message key="SHIP_IN_STOCK" bundle="${storeText}"/>
								</c:when>
								<c:otherwise>
									<fmt:message key="SHIP_OUT_OF_STOCK" bundle="${storeText}"/>
								</c:otherwise>
							</c:choose>
						</c:when>
						<c:when test="${availableDate <= now}">
							<fmt:message key="SHIP_IN_STOCK" bundle="${storeText}"/>
						</c:when>
						<c:otherwise>
							<c:choose>
								<c:when test="${(!empty orderItem.orderItemShippingInfo.requestedShipDate) && (orderItem.orderItemStatus.inventoryStatus != 'Backordered')}">
									<fmt:message key="SHIP_IN_STOCK" bundle="${storeText}"/>
								</c:when>
								<c:otherwise>
									<fmt:formatDate var="formattedAvailableDate" value="${availableDate}" dateStyle="long"/>
									<fmt:message key="SHIP_BACKORDERED" bundle="${storeText}">
										<fmt:param value="${formattedAvailableDate}"/>
									</fmt:message>
								</c:otherwise>
							</c:choose>
						</c:otherwise>
					</c:choose>
				</p>
			</td>
			<td id="WC_OrderItemDetailsf_td_2_<c:out value='${status.count}'/>" class="<c:out value="${nobottom}"/> QTY" headers="shoppingCart_tableCell_quantity shoppingCart_rowHeader_product<c:out value='${status.count}'/>">
				<p class="item-quantity">
					<c:choose>
						<c:when test="${orderItem.orderItemAmount.freeGift}">
							<%-- This is a free item..can't change the qty --%>
							<input type="hidden" value="-1" id='freeGift_qty_<c:out value="${status.count}"/>' name='qty_<c:out value="${status.count}"/>'/><span><c:out value="${quickCartOrderItemQuantity}"/></span>
						</c:when>
						<c:otherwise>
							<flow:ifEnabled feature="AjaxCheckout">
								<label for='qty_<c:out value="${status.count}"/>' style='display:none'><fmt:message key="QUANTITY1" bundle="${storeText}"/></label>
								<input id='qty_<c:out value="${status.count}"/>' name='qty_<c:out value="${status.count}"/>' type="text" size="1" style="width:25px;" value='<c:out value="${quickCartOrderItemQuantity}"/>' onkeydown="JavaScript:setCurrentId('qty_<c:out value='${status.count}'/>'); CheckoutHelperJS.updateCartWait(this, '<c:out value='${orderItem.orderItemIdentifier.uniqueID}'/>',event)" />
							</flow:ifEnabled>
							<flow:ifDisabled feature="AjaxCheckout">
								<label for='quantity_<c:out value="${status.count}"/>' style='display:none'><fmt:message key="QUANTITY1" bundle="${storeText}"/></label>
								<input type="hidden" value='<c:out value="${orderItem.orderItemIdentifier.uniqueID}"/>' name='orderItemId_<c:out value="${status.count}"/>' id='orderItemId_<c:out value="${status.count}"/>'/>
								<fmt:formatNumber	var="quickCartOrderItemQuantity" value="${orderItem.quantity.value}" type="number" maxFractionDigits="0"/>
								<input type="text" size="2" class="input" value='<c:out value="${quickCartOrderItemQuantity}"/>' id='quantity_<c:out value="${status.count}"/>' name='quantity_<c:out value="${status.count}"/>'/>
							</flow:ifDisabled>
						</c:otherwise>
					</c:choose>
				</p>
			</td>
			<td id="WC_OrderItemDetailsf_td_3_<c:out value='${status.count}'/>" class="<c:out value="${nobottom}"/> each" headers="shoppingCart_tableCell_each shoppingCart_rowHeader_product<c:out value='${status.count}'/>">

				<%-- unit price column of order item details table --%>
				<%-- shows unit price of the order item --%>
				<span class="price">
					<fmt:formatNumber var="formattedUnitPrice" value="${orderItem.orderItemAmount.unitPrice.price.value}" type="currency" maxFractionDigits="${currencyDecimal}" currencySymbol="${currencyFormatterDB.currencySymbol}"/>
					<c:out value="${formattedUnitPrice}" escapeXml="false" />
				</span>

			</td>
			<td id="WC_OrderItemDetailsf_td_4_<c:out value='${status.count}'/>" class="<c:out value="${nobottom}"/> total" headers="shoppingCart_tableCell_total shoppingCart_rowHeader_product<c:out value='${status.count}'/>">
				<c:choose>
					<c:when test="${orderItem.orderItemAmount.freeGift}">
						<%-- the OrderItem is a freebie --%>
						<span class="details">
							<fmt:message key="OrderSummary_SHOPCART_FREE" bundle="${storeText}"/>
						</span>
					</c:when>
					<c:otherwise>
						<span class="price">
							<fmt:formatNumber var="totalFormattedProductPrice" value="${orderItem.orderItemAmount.orderItemPrice.value}" type="currency" maxFractionDigits="${currencyDecimal}" currencySymbol="${currencyFormatterDB.currencySymbol}"/>
							<c:out value="${totalFormattedProductPrice}" escapeXml="false" />
						</span>
					</c:otherwise>
				</c:choose>
			</td>
		</tr>
		<c:remove var="nobottom"/>
		<%-- row to display product level discount --%>
		<c:if test="${!empty orderItem.orderItemAmount.adjustment}">
			<jsp:useBean id="aggregatedDiscounts" class="java.util.HashMap" scope="page" />
			<jsp:useBean id="discountReferences" class="java.util.HashMap" scope="page" />
			
			<%-- Loop through the discounts, summing discounts with the same code --%>
			<c:forEach var="discounts" items="${orderItem.orderItemAmount.adjustment}">			
				<%-- only show the adjustment detail if display level is OrderItem, if display level is order, display it at the order summary section --%>
				<c:if test="${discounts.displayLevel == 'OrderItem'}">
					<c:set property="${discounts.code}" value="${discounts}" target="${discountReferences}"/> 
					<c:if test="${empty aggregatedDiscounts[discounts.code]}">
  						<c:set property="${discounts.code}" value="0" target="${aggregatedDiscounts}"/>	
  					</c:if>				
  					<c:set property="${discounts.code}" value="${aggregatedDiscounts[discounts.code]+discounts.amount.value}" target="${aggregatedDiscounts}"/>
				</c:if>
			</c:forEach>	
											
			<c:forEach var="discountsIterator" items="${discountReferences}" varStatus="status2">									
			    <c:set var="discounts" value="${discountsIterator.value}" />
   				<%-- only show the adjustment detail if display level is OrderItem, if display level is order, display it at the order summary section --%>
				<c:if test="${discounts.displayLevel == 'OrderItem'}">
					<tr>
						<th colspan="4" class="th_align_left_dotted_top_solid_bottom" abbr="<fmt:message key="Checkout_ACCE_prod_discount" bundle="${storeText}"/> <c:out value="${fn:replace(catEntry.description.name, search, replaceStr)}" escapeXml="false"/>" id="shopcart_rowHeader_discount<c:out value='${status.count}'/>_<c:out value='${status2.count}'/>">
							<div class="itemspecs" id="WC_OrderItemDetailsf_div_3_<c:out value='${status.count}'/>_<c:out value='${status2.count}'/>">
								<c:url var="DiscountDetailsDisplayViewURL" value="DiscountDetailsDisplayView">
									<c:param name="code" value="${discounts.code}" />
									<c:param name="langId" value="${langId}" />
									<c:param name="storeId" value="${WCParam.storeId}" />
									<c:param name="catalogId" value="${WCParam.catalogId}" />
								</c:url>	
								<a class="discount" href='<c:out value="${DiscountDetailsDisplayViewURL}" />' id="WC_OrderItemDetails_Link_ItemDiscount_1_<c:out value="${((status2.count+1) % 2) + 1}"/>">
									<img src="<c:out value="${jspStoreImgDir}" />images/empty.gif" alt="<fmt:message key="Checkout_ACCE_prod_discount" bundle="${storeText}"/> <c:out value="${fn:replace(catalogEntry.description.name, search, replaceStr)}" escapeXml="false"/>"/>
									<c:out 	value="${discounts.description.value}" escapeXml="false"/>
								</a>
								<br />
							</div>
						</th>
						<td id="WC_OrderItemDetailsf_td_5_<c:out value='${status.count}'/>_<c:out value='${status2.count}'/>" class="th_align_left_dotted_top_solid_bottom total" headers="shopcart_rowHeader_discount<c:out value='${status.count}'/>_<c:out value='${status2.count}'/>">
							<fmt:formatNumber	var="formattedDiscountValue" value="${aggregatedDiscounts[discounts.code]}" type="currency" maxFractionDigits="${currencyDecimal}" currencySymbol="${currencyFormatterDB.currencySymbol}"/>
							<c:out value="${formattedDiscountValue}" escapeXml="false" />							
							<br />
						</td>
					</tr>	
				</c:if>			
			</c:forEach>
			<c:remove var="aggregatedDiscounts"/>
			<c:remove var="discountReferences"/>
		</c:if>
		<c:remove var="catEntry"/>
	</c:forEach>
<flow:ifDisabled feature="AjaxCheckout">
</form>
</flow:ifDisabled>
	<%-- dont change the name of this hidden input element. This variable is used in CheckoutHelper.js --%>
	<input type="hidden" id = "totalNumberOfItems" name="totalNumberOfItems" value='<c:out value="${totalNumberOfItems}"/>'/>
	
	<c:forEach var="paymentInstruction" items="${pagorder.orderPaymentInfo.paymentInstruction}">
		<c:if test="${!empty existingPaymentInstructionIds}">
			<c:set var="existingPaymentInstructionIds" value="${existingPaymentInstructionIds},"/>
		</c:if>
		<c:set var="existingPaymentInstructionIds" value="${existingPaymentInstructionIds}${paymentInstruction.uniqueID}"/>
	</c:forEach>
	<input type="hidden" name="existingPaymentInstructionId" value="<c:out value="${existingPaymentInstructionIds}"/>" id="existingPaymentInstructionId"/>

 </table>

<c:if test="${numEntries > pageSize}">
	<div id="ShopcartPaginationText2">
		<div class="textfloat">
		<fmt:message key="CATEGORY_RESULTS_DISPLAYING" bundle="${storeText}"> 
				<fmt:param><fmt:formatNumber value="${beginIndex + 1}"/></fmt:param>
				<fmt:param><fmt:formatNumber value="${endIndex}"/></fmt:param>
				<fmt:param><fmt:formatNumber value="${numEntries}"/></fmt:param>
		</fmt:message>
		</div>
		<div class="text textfloat divpadding">
		
			<c:if test="${beginIndex != 0}">	
					
				<c:choose>
					<c:when test="${param.fromPage == 'pendingOrderDisplay'}">
							<a id="ShopcartPaginationText2_1" href="javaScript:if(!CheckoutHelperJS.checkForDirtyFlag()){setCurrentId('ShopcartPaginationText2_1'); if(submitRequest()){ cursor_wait();
						wc.render.updateContext('PendingOrderPaginationDisplay_Context',{'beginIndex':'<c:out value='${beginIndex - pageSize}'/>','pageSize':'<c:out value='${pageSize}'/>'});}}">
				
					</c:when>
					<c:otherwise>
						<a id="ShopcartPaginationText2_1" href="javaScript:if(!CheckoutHelperJS.checkForDirtyFlag()){setCurrentId('ShopcartPaginationText2_1'); if(submitRequest()){ cursor_wait();
					wc.render.updateContext('ShopCartPaginationDisplay_Context',{'beginIndex':'<c:out value='${beginIndex - pageSize}'/>','pageSize':'<c:out value='${pageSize}'/>'});}}">
				
					</c:otherwise>
				</c:choose>
				
				</c:if>
				
					<img src="<c:out value="${jspStoreImgDir}${vfileColorBIDI}" />paging_back.png" alt="<fmt:message key="CATEGORY_PAGING_LEFT_IMAGE" bundle="${storeText}"/>" />
				
				<c:if test="${beginIndex != 0}">
					</a>
				</c:if>
			<span>
			
			<fmt:message key="CATEGORY_RESULTS_PAGES_DISPLAYING" bundle="${storeText}"> 
					<fmt:param><fmt:formatNumber value="${currentPage}"/></fmt:param>
					<fmt:param><fmt:formatNumber value="${totalPages}"/></fmt:param>
				</fmt:message>
			
			</span>
				
				<c:if test="${numEntries > endIndex }">
				<c:choose>
					<c:when test="${param.fromPage == 'pendingOrderDisplay'}">
							<a id="ShopcartPaginationText2_2" href="javaScript:if(!CheckoutHelperJS.checkForDirtyFlag()){setCurrentId('ShopcartPaginationText2_2'); if(submitRequest()){ cursor_wait();
						wc.render.updateContext('PendingOrderPaginationDisplay_Context',{'beginIndex':'<c:out value='${beginIndex + pageSize}'/>','pageSize':'<c:out value='${pageSize}'/>'});}}">
				
					</c:when>
					<c:otherwise>
						<a id="ShopcartPaginationText2_2" href="javaScript:if(!CheckoutHelperJS.checkForDirtyFlag()){setCurrentId('ShopcartPaginationText2_2'); if(submitRequest()){ cursor_wait();
						wc.render.updateContext('ShopCartPaginationDisplay_Context',{'beginIndex':'<c:out value='${beginIndex + pageSize}'/>','pageSize':'<c:out value='${pageSize}'/>'});}}">
					
					</c:otherwise>
				</c:choose>
					</c:if>
				<img src="<c:out value="${jspStoreImgDir}${vfileColorBIDI}" />paging_next.png" alt="<fmt:message key="CATEGORY_PAGING_RIGHT_IMAGE" bundle="${storeText}"/>" />
				<c:if test="${numEntries > endIndex }">
					</a>
				</c:if>
		
		</div>
	</div>
</c:if> 

<flow:ifEnabled feature="Analytics">
	<flow:ifEnabled feature="AjaxCheckout"> 
		<script type="text/javascript">
			dojo.addOnLoad(function() {
				analyticsJS.storeId=<c:out value="${WCParam.storeId}" />;
				analyticsJS.catalogId=<c:out value="${WCParam.catalogId}" />;
				analyticsJS.publishCartView();
				analyticsJS.loadShopCartPaginationHandler();
			});
		</script>
	</flow:ifEnabled>	
</flow:ifEnabled>	

