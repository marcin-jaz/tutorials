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
  * This JSP file displays the order items of the shopper's current shopping cart. It is used for showing the order item
  * details for a multiple shipment shopping cart.
  *****
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%@ include file="../../../include/JSTLEnvironmentSetup.jspf"%>

<script type="text/javascript">
	dojo.addOnLoad(function() { 
              categoryDisplayJS.setCommonParameters('<c:out value='${WCParam.langId}'/>','<c:out value='${WCParam.storeId}'/>','<c:out value='${WCParam.catalogId}'/>','<c:out value='${userType}'/>');
	});
</script>

<flow:ifEnabled feature="AjaxCheckout"> 
	<c:set var="isAjaxCheckout" value="true" />
</flow:ifEnabled>
<flow:ifDisabled feature="AjaxCheckout"> 
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

<!-- Get order Details using the ORDER SOI -->

<%-- Substring to search for --%>
<c:set var="search" value='"'/>
<%-- Substring to replace the search strng with --%>
<c:set var="replaceStr" value="'"/>

<c:set var="pageSize" value="${WCParam.pageSize}" />
<c:if test="${empty pageSize}">
	<c:set var="pageSize" value="${maxOrderItemsPerPage}"/>
</c:if>

<%-- Index to begin the order item paging with --%>
<c:set var="beginIndex" value="${WCParam.beginIndex}" />
<c:if test="${empty beginIndex}">
	<c:set var="beginIndex" value="0" />
</c:if>

<c:set var="currentPage" value="1"/>

<%-- Retrieve the current page of order & order item information from this request --%>
<c:set var="pgorder" value="${requestScope.order}"/>
<c:if test="${empty pgorder || pgorder==null}">
	<wcf:getData type="com.ibm.commerce.order.facade.datatypes.OrderType"
		var="pgorder" expressionBuilder="findCurrentShoppingCartWithPagingOnItem" varShowVerb="ShowVerbShipment" maxItems="${pageSize}" recordSetStartNumber="${beginIndex}" recordSetReferenceId="ostatus">
		<wcf:param name="accessProfile" value="IBM_Details" />	 
		<wcf:param name="sortOrderItemBy" value="orderItemID" />
		<wcf:param name="isSummary" value="false" />
	</wcf:getData>
</c:if>

<c:if test="${beginIndex == 0}">
	<c:if test="${ShowVerbShipment.recordSetTotal > ShowVerbShipment.recordSetCount}">		
		<c:set var="pageSize" value="${ShowVerbShipment.recordSetCount}" />
	</c:if>
</c:if>	

<c:set var="numEntries" value="${ShowVerbShipment.recordSetTotal}"/>
<c:set var="orderUniqueId" value="${pgorder.orderIdentifier.uniqueID}"/>

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

	<div class="shopcart_pagination" id="MSOrderItemDetailsPaginationText1">
		<br/>
		<span class="text">
			<fmt:message key="CATEGORY_RESULTS_DISPLAYING" bundle="${storeText}"> 
				<%-- Indicate the range of order items currently displayed --%>
				<%-- Each page displays <pageSize> of order items, from <beginIndex+1> to <endIndex> --%>				
				<fmt:param><fmt:formatNumber value="${beginIndex + 1}"/></fmt:param>
				<fmt:param><fmt:formatNumber value="${endIndex}"/></fmt:param>
				<fmt:param><fmt:formatNumber value="${numEntries}"/></fmt:param>
			</fmt:message>
			<span class="paging">
				<%-- Enable the previous page link if the current page is not the first page --%>
				<c:if test="${beginIndex != 0}">
					<a id="MSOrderItemDetailsPaginationText1_1" href="javaScript:if(!CheckoutHelperJS.checkForDirtyFlag()){ setCurrentId('MSOrderItemDetailsPaginationText1_1'); if(submitRequest()){ cursor_wait();	
					wc.render.updateContext('multipleShipmentDetailsContext',{'beginIndex':'<c:out value='${beginIndex - pageSize}'/>','pageSize':'<c:out value='${pageSize}'/>'});}}">
				</c:if>
				<img src="<c:out value="${jspStoreImgDir}${vfileColorBIDI}" />paging_back.png" alt="<fmt:message key="CATEGORY_PAGING_LEFT_IMAGE" bundle="${storeText}"/>" />
				<c:if test="${beginIndex != 0}">
					</a>
				</c:if>
				<fmt:message key="CATEGORY_RESULTS_PAGES_DISPLAYING" bundle="${storeText}"> 
					<fmt:param><fmt:formatNumber value="${currentPage}"/></fmt:param>
					<fmt:param><fmt:formatNumber value="${totalPages}"/></fmt:param>
				</fmt:message>
				<%-- Enable the next page link if the current page is not the last page --%>	
				<c:if test="${numEntries > endIndex }">
					<a id="MSOrderItemDetailsPaginationText1_2" href="javaScript:if(!CheckoutHelperJS.checkForDirtyFlag()){ setCurrentId('MSOrderItemDetailsPaginationText1_2'); if(submitRequest()){ cursor_wait();	
					wc.render.updateContext('multipleShipmentDetailsContext',{'beginIndex':'<c:out value='${beginIndex + pageSize}'/>','pageSize':'<c:out value='${pageSize}'/>'});}}">		
				</c:if>
				<img src="<c:out value="${jspStoreImgDir}${vfileColorBIDI}" />paging_next.png" alt="<fmt:message key="CATEGORY_PAGING_RIGHT_IMAGE" bundle="${storeText}"/>" />
				<c:if test="${numEntries > endIndex }">
					</a>
				</c:if>
			</span>
		</span>
	</div>
</c:if> 

<c:if test="${empty requestScope.orderBean || requestScope.orderBean==null}">
	<wcbase:useBean id="orderBean" classname="com.ibm.commerce.order.beans.OrderDataBean" scope="request">
		<c:set value="${orderUniqueId}" target="${orderBean}" property="orderId"/>
		<c:set value="${currentPage}" target="${orderBean}" property="currentPage"/>
		<c:set value="${pageSize}" target="${orderBean}" property="pageSize"/>
	</wcbase:useBean>
</c:if>
<input type="hidden" name="OrderTotalAmount" value="<c:out value='${pgorder.orderAmount.grandTotal.value}'/>" id="OrderTotalAmount" />
<input type="hidden" name="currentPageNumber" value="${currentPage}" id="currentPageNumber"/>

<table id="order_details" cellpadding="0" cellspacing="0" border="0" width="100%" summary="<fmt:message key="SHOPCART_TABLE_CONFIRM_SUMMARY_MULTI_SHIP" bundle="${storeText}"/>">
	<tr class="nested">
		<th class="align_left" id="MultipleShipments_tableCell_productName"><fmt:message key="PRODUCT" bundle="${storeText}"/></th>
		<th class="align_left" id="MultipleShipments_tableCell_shipAddress"><fmt:message key="SHIP_SHIPPING_ADDRESS" bundle="${storeText}"/></th>
		<th class="align_left" id="MultipleShipments_tableCell_shipMethod"><fmt:message key="SHIP_SHIPPING_METHOD" bundle="${storeText}"/></th>
		<th class="align_left" id="MultipleShipments_tableCell_availability"><fmt:message key="AVAILABILITY" bundle="${storeText}"/></th>
		<th class="align_center" id="MultipleShipments_tableCell_quantity" abbr="<fmt:message key="QUANTITY1" bundle="${storeText}"/>"><fmt:message key="QTY" bundle="${storeText}"/></th>
		<th class="align_right" id="MultipleShipments_tableCell_unitPrice" abbr="<fmt:message key="UNIT_PRICE" bundle="${storeText}"/>"><fmt:message key="EACH" bundle="${storeText}"/></th>
		<th class="align_right" id="MultipleShipments_tableCell_totalPrie" abbr="<fmt:message key="TOTAL_PRICE" bundle="${storeText}"/>"><fmt:message key="TOTAL" bundle="${storeText}"/></th>
	</tr>
	
	<c:if test="${!empty pgorder.orderItem}">
		<wcf:getData type="com.ibm.commerce.catalog.facade.datatypes.CatalogEntryType[]" var="catalogEntriesForAttributes" expressionBuilder="getStoreCatalogEntryAttributesByIDs">
			<wcf:contextData name="storeId" data="${WCParam.storeId}"/>
			<c:forEach var="orderItem" items="${pgorder.orderItem}">
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
	<c:forEach var="orderItem0" items="${pgorder.orderItem}" varStatus="status">
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
	<c:forEach var="currentOrderItem" items="${pgorder.orderItem}" varStatus="count">
		<c:if test="${!hasEntitledItems}">
			<c:set var="currentCatEntry" value="${catalogEntryDataBeansInThisOrder[currentOrderItem.catalogEntryIdentifier.uniqueID]}"/>
			<c:if test="${!empty currentCatEntry.itemDataBean.parentProductDataBean.entitledItems}">	
				<c:set var="hasEntitledItems" value="true"/>
			</c:if>
		</c:if>
	</c:forEach>
	
	
	<%-- 
		The following code snippet retrieves all the SKUs for each catalog entry associated with each item in the current oder. 
		It was taken out of the larger c:forEach loop below for performance reasons.
	--%>
	<c:if test="${hasEntitledItems}">
		<wcf:getData type="com.ibm.commerce.catalog.facade.datatypes.CatalogEntryType[]" var="skus" expressionBuilder="getStoreCatalogEntryAttributesByIDs">
			<wcf:contextData name="storeId" data="${param.storeId}"/>
			<c:forEach var="orderItem1" items="${pgorder.orderItem}">
				<c:set var="catalogEntryForThisOrderItem" value="${catalogEntryDataBeansInThisOrder[orderItem1.catalogEntryIdentifier.uniqueID]}"/>
				<c:forEach var='entitledItemForThisCatEntry' items='${catalogEntryForThisOrderItem.itemDataBean.parentProductDataBean.entitledItems}' varStatus='outerStatus1'>	
					<wcf:param name="UniqueID" value="${entitledItemForThisCatEntry.itemID}"/>
				</c:forEach>
			</c:forEach>
			<wcf:param name="dataLanguageIds" value="${WCParam.langId}"/>
		</wcf:getData>
	</c:if>
	
	
	<c:set var="numberOfNonFreeItemsOnThisPage" value="0"/>
	<c:forEach var="orderItem0" items="${pgorder.orderItem}" varStatus="status0">
		<c:set var="numberOfNonFreeItemsOnThisPage" value="${numberOfNonFreeItemsOnThisPage + 1}"/>
		<c:if test="${orderItem0.orderItemAmount.freeGift}">
			<c:set var="numberOfNonFreeItemsOnThisPage" value="${numberOfNonFreeItemsOnThisPage - 1}"/>
		</c:if>
	</c:forEach>
	
	<c:set var="callOrderPrepareOnItemRemove" value="true"/>
	<c:if test="${numberOfNonFreeItemsOnThisPage <= 1 && currentPage == 1}">
		<c:set var="callOrderPrepareOnItemRemove" value="false"/>
	</c:if>
	
	<c:forEach var="orderItem" items="${pgorder.orderItem}" varStatus="status">
		<c:set var="isFreeGift" value="${orderItem.orderItemAmount.freeGift}"/>
		<c:set var="itemUniqueId" value="${orderItem.orderItemIdentifier.uniqueID}"/>
		<c:set var="catEntryUniqueId" value="${orderItem.catalogEntryIdentifier.uniqueID}"/>
		<c:set var="orderItemShippingInfo" value="${orderItem.orderItemShippingInfo}"/>
		
		<c:set var="catEntry" value="${catalogEntryDataBeansInThisOrder[orderItem.catalogEntryIdentifier.uniqueID]}"/>

		<%-- If this is a product and has defining attributes, then allow user to change --%>
		<c:set var="parentCatEntry" value="${catEntry.itemDataBean.parentProductDataBean.productID}"/>
		<c:if test="${!empty parentCatEntry}">
			<c:set var="items1" value="${catEntry.itemDataBean.parentProductDataBean.entitledItems}"/>
			<div id="entitledItem_<c:out value='${parentCatEntry}'/>" style="display:none;">
			[
			<c:forEach var='entitledItem' items='${items1}' varStatus='outerStatus'>
				{
				"orderItemId_remove":"<c:out value="${itemUniqueId}" />",
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
		<fmt:formatNumber	var="quickCartOrderItemQuantity" value="${orderItem.quantity.value}" type="number" maxFractionDigits="0"/>
		<%-- keep setting total number of items variable..in the last loop, it will contain correct value :-)better to get this value using length function.. --%>
		<c:set var="totalNumberOfItems" value="${status.count}"/>
		<input type="hidden" value='<c:out value="${itemUniqueId}"/>' name='orderItem_<c:out value="${status.count}"/>' id='orderItem_<c:out value="${status.count}"/>'/>
		<input type="hidden" value='<c:out value="${catEntryUniqueId}"/>' name='catalogId_<c:out value="${status.count}"/>' id='catalogId_<c:out value="${status.count}"/>'/>
		<c:forEach var="discounts" items="${orderItem.orderItemAmount.adjustment}">	
				<c:if test="${discounts.displayLevel == 'OrderItem'}">
					<c:set var="nobottom" value="th_align_left_no_bottom"/>
				</c:if>
		</c:forEach>		
		<tr>
			 <th class="th_align_left_normal <c:out value="${nobottom}"/>" id="MultipleShipping_rowHeader_product<c:out value='${status.count}'/>" abbr="<fmt:message key="Checkout_ACCE_for" bundle="${storeText}"/> ${catEntry.description.name}" width="150">
				<div class="img" id="WC_MSOrderItemDetails_div_1_<c:out value='${status.count}'/>">
					<c:set var="catEntryIdentifier" value="${catEntry.catalogEntryID}"/>
					<c:set var="pageView" value="imageOnlyDisplay"/>
					<c:set var="showTooltip" value="false"/>
					<%@ include file="../../../Snippets/ReusableObjects/CatalogEntryDBThumbnailDisplay.jspf" %>   
				</div>
				<div class="itemspecs" id="WC_MSOrderItemDetails_div_2_<c:out value='${status.count}'/>">
					<p><c:out value="${catEntry.description.name}" escapeXml="false"/></p>
					<span><fmt:message key="CurrentOrder_SKU" bundle="${storeText}"/> <c:out value="${catEntry.partNumber}" escapeXml="false"/></span></br>
					<br />
					<%--
					 ***
					 * Start: Display Defining attributes
					 * Loop through the attribute values and display the defining attributes
					 ***
					--%>
					<c:forEach var="catalogEntry1" items="${catalogEntriesForAttributes}">
						<c:if test="${catalogEntry1.catalogEntryIdentifier.uniqueID == orderItem.catalogEntryIdentifier.uniqueID}">
						<c:remove var="selectedAttr"/>
							<c:forEach var="attribute" items="${catalogEntry1.catalogEntryAttributes.attributes}" varStatus="status3">
								<c:if test="${ attribute.usage =='Defining' }" >
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
									<a class="order_link" id="WC_MSOrderItemDetails_link_1_<c:out value='${status.count}'/>_<c:out value='${status3.count}'/>" href="javascript:;"  onClick="JavaScript:var actionListAttributeMS = new popupActionProperties(); actionListAttributeMS.showAddToCart=false; actionListAttributeMS.showWishList=false; actionListAttributeMS.showProductCompare=false; actionListAttributeMS.showReplaceCartItem=true; showPopup('<c:out value='${parentCatEntry}'/>','<c:out value='${WCParam.storeId}'/>','<c:out value='${WCParam.langId}'/>','<c:out value='${WCParam.catalogId}'/>',event,null,'',actionListAttributeMS,${quickCartOrderItemQuantity}); saveChangeOrderItemId('<c:out value='${itemUniqueId}'/>');"> 
									<fmt:message key="CHANGE_ATTRIBUTES" bundle="${storeText}"/>
									</a>

								 </c:if>
								 <input type="hidden" name="selectedAttr" id="selectedAttr_${orderItem.orderItemIdentifier.uniqueID}" value="${selectedAttr}"/>
						</c:if>
					</c:forEach>
					<%--
					 ***
					 * End: Display Defining attributes
					 ***
					--%>
					<br />
					<c:if test="${b2bStore}">
						<c:set var="isShoppingCartPage" value="false"/>
						<%@ include file="../../../Snippets/Order/Cart/B2BContractSelectExt.jspf" %>
					</c:if>
					<p>
					<c:if test="${!isFreeGift}">
						<flow:ifEnabled feature="AjaxCheckout">
							<a href="JavaScript:setCurrentId('WC_MSOrderItemDetails_link_2_${status.count}'); CheckoutHelperJS.deleteFromCart('<c:out value='${itemUniqueId}'/>');" id="WC_MSOrderItemDetails_link_2_<c:out value='${status.count}'/>">
								<img src="<c:out value='${jspStoreImgDir}${vfileColor}'/>table_x_delete.png" alt="<fmt:message key="REMOVE" bundle="${storeText}"/>"/>
								<fmt:message key="REMOVE" bundle="${storeText}"/>
							</a>
						</flow:ifEnabled>
						<flow:ifDisabled feature="AjaxCheckout">
							<wcf:url var="OrderItemDelete" value="OrderChangeServiceItemDelete">
								<wcf:param name="orderItemId" value="${itemUniqueId}"/>
								<wcf:param name="orderId" value="${orderUniqueId}"/>
								<wcf:param name="langId" value="${WCParam.langId}" />
								<wcf:param name="storeId" value="${WCParam.storeId}" />
								<wcf:param name="catalogId" value="${WCParam.catalogId}" />
								<wcf:param name="forceShipmentType" value="2" />
								<wcf:param name="calculationUsage" value="-1,-2,-3,-4,-5,-6,-7" />
								<wcf:param name="URL" value="OrderShippingBillingView" />
								<c:if test="${callOrderPrepareOnItemRemove}">
									<wcf:param name="allocate" value="***" />
									<wcf:param name="backorder" value="***" />
									<wcf:param name="remerge" value="***" />
									<wcf:param name="check" value="*n" />
								</c:if>

								<wcf:param name="errorViewName" value="OrderShippingBillingView" />
								<wcf:param name="beginIndex" value="${beginIndex}" />
							</wcf:url>
							<a href="#" onclick="Javascript:setPageLocation('<c:out value='${OrderItemDelete}'/>');return false;" id="WC_MSOrderItemDetails_link_3_<c:out value='${status.count}'/>">
								<img src="<c:out value='${jspStoreImgDir}${vfileColor}'/>table_x_delete.png" alt="<fmt:message key="REMOVE" bundle="${storeText}"/>"/>
								<fmt:message key="REMOVE" bundle="${storeText}"/>
							</a>
						</flow:ifDisabled>
					</c:if>
					</p>
					<p>
					<c:if test="${!isFreeGift}">
						<flow:ifEnabled feature="wishList">
							<%-- The following choose statement handles all aplicable cases of change flow: AjaxCheckout and AjaxAddToCart--%>
								<c:choose>
									<c:when test="${isAjaxCheckout && isAjaxAddToCart}">
								<a href="JavaScript:setCurrentId('WC_MSOrderItemDetails_link_4_${status.count}'); CheckoutHelperJS.addToWishListAndDeleteFromCart('<c:out value='${catEntryUniqueId}'/>','<c:out value='${itemUniqueId}'/>');" id="WC_MSOrderItemDetails_link_4_<c:out value='${status.count}'/>">
									<img src="<c:out value='${jspStoreImgDir}${vfileColor}'/>table_plus_add.png" alt="<fmt:message key="MOVE_TO_WISH_LIST" bundle="${storeText}"/>"/>
									<fmt:message key="MOVE_TO_WISH_LIST" bundle="${storeText}"/>
								</a>
									</c:when>
									<c:when test="${(isAjaxCheckout && !isAjaxAddToCart) || (!isAjaxCheckout && !isAjaxAddToCart)}">	
								<wcf:url var="OrderItemMove" value="OrderChangeServiceItemDelete">
											<wcf:param name="langId" value="${WCParam.langId}" />
											<wcf:param name="storeId" value="${WCParam.storeId}" />
											<wcf:param name="catalogId" value="${WCParam.catalogId}" />
											<wcf:param name="orderItemId" value="${orderItem.orderItemIdentifier.uniqueID}"/>
											<wcf:param name="orderId" value="${pagorder.orderIdentifier.uniqueID}"/>
											<wcf:param name="catEntryId" value="${orderItem.catalogEntryIdentifier.uniqueID}" />
											<wcf:param name="URL" value="InterestItemAdd?URL=${interestItemDisplayURL}" />
											<wcf:param name="errorViewName" value="OrderShippingBillingView" />
											<wcf:param name="updateable" value="0" />
										</wcf:url>
										
										<a href="#" onclick="Javascript:setPageLocation('<c:out value='${OrderItemMove}'/>');return false;" id="WC_MSOrderItemDetails_link_4c_<c:out value='${status.count}'/>">
											<img src="<c:out value='${jspStoreImgDir}${vfileColor}'/>table_plus_add.png" alt="<fmt:message key="MOVE_TO_WISH_LIST" bundle="${storeText}"/>"/>
											<fmt:message key="MOVE_TO_WISH_LIST" bundle="${storeText}"/>
										</a>
									</c:when>
									<c:when test="${!isAjaxCheckout && isAjaxAddToCart}">
										<wcf:url var="OrderItemMove" value="OrderChangeServiceItemDelete">
									<wcf:param name="orderItemId" value="${itemUniqueId}"/>
									<wcf:param name="orderId" value="${orderUniqueId}"/>
									<wcf:param name="langId" value="${WCParam.langId}" />
									<wcf:param name="storeId" value="${WCParam.storeId}" />
									<wcf:param name="catalogId" value="${WCParam.catalogId}" />
									<wcf:param name="forceShipmentType" value="2" />
									<wcf:param name="catEntryId" value="${catEntryUniqueId}" />
									<wcf:param name="calculationUsage" value="-1,-2,-3,-4,-5,-6,-7" />
									<wcf:param name="URL" value="InterestItemAdd?URL=OrderShippingBillingView" />
									<c:if test="${callOrderPrepareOnItemRemove}">
										<wcf:param name="allocate" value="***" />
										<wcf:param name="backorder" value="***" />
										<wcf:param name="remerge" value="***" />
										<wcf:param name="check" value="*n" />
									</c:if>
									<wcf:param name="errorViewName" value="OrderShippingBillingView" />
									<wcf:param name="beginIndex" value="${beginIndex}" />
									<wcf:param name="updateable" value="0" />
								</wcf:url>
								<a href="#" onclick="Javascript:setPageLocation('<c:out value='${OrderItemMove}'/>');return false;" id="WC_MSOrderItemDetails_link_5_<c:out value='${status.count}'/>">
									<img src="<c:out value='${jspStoreImgDir}${vfileColor}'/>table_plus_add.png" alt="<fmt:message key="MOVE_TO_WISH_LIST" bundle="${storeText}"/>"/>
									<fmt:message key="MOVE_TO_WISH_LIST" bundle="${storeText}"/>
								</a>
									</c:when>
								</c:choose>
						</flow:ifEnabled>
					</c:if>
					</p>
				</div>
			</th>
			
			<td class="<c:out value="${nobottom}"/>" width="200" id="WC_MSOrderItemDetails_td_1_<c:out value='${status.count}'/>" headers="MultipleShipments_tableCell_shipAddress MultipleShipping_rowHeader_product<c:out value='${status.count}'/>">
				<div class="shipping_address_nester" id="WC_MSOrderItemDetails_div_3_<c:out value='${status.count}'/>"> 
					<%-- Retrieve the order item data bean information to help hide/show create and edit address links.--%>
					<c:set var="orderItemDataBeans" value="${orderBean.orderItemDataBeansInCurrentPage}"/>
					<c:set var="personalAddressAllowForShipping" value="false"/>
					<%-- Set the value of personalAddressAllowForShipping boolean variable which will be used to decide whether to hide/show create and edit address links. --%>
					<c:forEach var="orderItemBean" items="${orderItemDataBeans}">
						<c:if test="${(orderItemBean.orderItemId eq itemUniqueId) && (orderItemBean.personalAddressAllowForShipping)}">
							<c:set var="personalAddressAllowForShipping" value="true"/>
						</c:if>
					</c:forEach>
					<%out.flush();%>
						<c:import url="${jspStoreDir}ShoppingArea/CheckoutSection/MultipleShipment/ShippingAddressSelect.jsp">
							<c:param value="${orderItemShippingInfo.shippingAddress.contactInfoIdentifier.uniqueID}" name="addressId"/>
							<c:param value="${orderItemShippingInfo.shippingAddress.contactInfoIdentifier.externalIdentifier.contactInfoNickName}" name="addressNickName"/>
							<c:param name="orderItemId" value="${itemUniqueId}" />
							<c:param name="orderId" value="${orderUniqueId}" />
							<c:param name="personalAddressAllowed" value="${personalAddressAllowForShipping}"/>
						</c:import>
					<%out.flush();%>
				</div>
			</td>

			<td class="<c:out value="${nobottom}"/>" id="WC_MSOrderItemDetails_td_2_<c:out value='${status.count}'/>" headers="MultipleShipments_tableCell_shipMethod MultipleShipping_rowHeader_product<c:out value='${status.count}'/>">
				<div class="shipping_method_nested" id="WC_MSOrderItemDetails_div_4_<c:out value='${status.count}'/>">
					<%out.flush();%>
						<c:import url="${jspStoreDir}ShoppingArea/CheckoutSection/MultipleShipment/ShippingMethodDetails.jsp">
							<c:param value="${orderItemShippingInfo.shippingMode.shippingModeIdentifier.uniqueID}" name="shipModeId"/>
							<c:param name="orderItemId" value="${itemUniqueId}" />
							<c:param name="orderId" value="${orderUniqueId}" />
							<c:param name="shipInstructions" value="${orderItemShippingInfo.shippingInstruction}"/>
							<c:param name="requestedShipDate" value="${orderItemShippingInfo.requestedShipDate}"/>
							<c:param name="isFreeGift" value="${isFreeGift}"/>
							<c:param name="isExpedited" value="${orderItemShippingInfo.expedite}"/>
						</c:import>
					<%out.flush();%>
				</div>
			</td>  

			<td id="WC_MSOrderItemDetails_td_3_<c:out value='${status.count}'/>" class="<c:out value="${nobottom}"/> avail" headers="MultipleShipments_tableCell_availability MultipleShipping_rowHeader_product<c:out value='${status.count}'/>">
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
								<c:when test="${(!empty orderItemShippingInfo.requestedShipDate) && (orderItem.orderItemStatus.inventoryStatus != 'Backordered')}">
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
			<td class="<c:out value="${nobottom}"/>" id="WC_MSOrderItemDetails_td_4_<c:out value='${status.count}'/>" class="QTY" headers="MultipleShipments_tableCell_quantity MultipleShipping_rowHeader_product<c:out value='${status.count}'/>">
				<p class="item-quantity">
					<c:choose>
						<c:when test="${isFreeGift}">
							<%-- This is a free item..can't change the qty --%>
							<input type="hidden" value="-1" id='freeGift_qty_<c:out value="${status.count}"/>' name='qty_<c:out value="${status.count}"/>'><span><c:out value="${quickCartOrderItemQuantity}"/></span>
						</c:when>
						<c:otherwise>
							<input type="hidden" value="<c:out value="${quickCartOrderItemQuantity}"/>" id='qty_<c:out value="${status.count}"/>' name='qty_<c:out value="${status.count}"/>'/><span><c:out value="${quickCartOrderItemQuantity}"/></span>
						</c:otherwise>
					</c:choose>
				</p>
			</td>
			<td id="WC_MSOrderItemDetails_td_5_<c:out value='${status.count}'/>" class="<c:out value="${nobottom}"/> each" headers="MultipleShipments_tableCell_unitPrice MultipleShipping_rowHeader_product<c:out value='${status.count}'/>">
				<%-- unit price column of order item details table --%>
				<%-- shows unit price of the order item --%>
				<span class="price">
					<fmt:formatNumber value="${orderItem.orderItemAmount.unitPrice.price.value}" type="currency" maxFractionDigits="${currencyDecimal}" currencySymbol="${currencyFormatterDB.currencySymbol}"/>
				</span>				
			</td>
			<td id="WC_MSOrderItemDetails_td_6_<c:out value='${status.count}'/>" class="<c:out value="${nobottom}"/> total" headers="MultipleShipments_tableCell_totalPrice MultipleShipping_rowHeader_product<c:out value='${status.count}'/>">
				<c:choose>
					<c:when test="${isFreeGift}">
						<%-- the OrderItem is a freebie --%>
						<span class="details">
							<fmt:message key="Free" bundle="${storeText}"/>
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
						<th colspan="6" class="th_align_left_dotted_top_solid_bottom" abbr="<fmt:message key="Checkout_ACCE_prod_discount" bundle="${storeText}"/> ${catEntry.description.name}" id="MultipleShipment_rowHeader_discount<c:out value='${status.count}'/>_<c:out value='${status2.count}'/>">
							<div class="itemspecs" id="WC_MSOrderItemDetails_div_5_<c:out value='${status.count}'/>_<c:out value='${status2.count}'/>">
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
						<td id="WC_MSOrderItemDetails_td_7_<c:out value='${status.count}'/>_<c:out value='${status2.count}'/>" class="th_align_left_dotted_top_solid_bottom total" headers="MultipleShipment_rowHeader_discount<c:out value='${status.count}'/>_<c:out value='${status2.count}'/>">
							<fmt:formatNumber	var="formattedDiscountValue"	value="${aggregatedDiscounts[discounts.code]}" type="currency" maxFractionDigits="${currencyDecimal}" currencySymbol="${currencyFormatterDB.currencySymbol}"/>
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
	<%-- dont change the name of this hidden input element. This variable is used in CheckoutHelper.js --%>
	<input type="hidden" id = "totalNumberOfItems" name="totalNumberOfItems" value='<c:out value="${totalNumberOfItems}"/>'/>

	<flow:ifDisabled feature="AjaxCheckout">
		<form name="ReplaceItemForm" method="post" action="OrderChangeServiceItemDelete" id="ReplaceItemForm">
			<!-- Define all the hidden fields required for submitting this form in case of Non-Ajax Checkout -->
			<input type="hidden" name="storeId" value='<c:out value="${storeId}"/>' id="WC_MSOrderItemDetails_inputs_11"/>
			<input type="hidden" name="langId" value='<c:out value="${langId}" />' id="WC_MSOrderItemDetails_inputs_12"/>
			<input type="hidden" name="orderId" value='<c:out value="${orderUniqueId}"/>' id="WC_MSOrderItemDetails_inputs_13"/>
			<input type="hidden" name="catalogId" value='<c:out value="${catalogId}"/>' id="WC_MSOrderItemDetails_inputs_14"/>
			<input type="hidden" name="errorViewName" value="OrderShippingBillingView" id="WC_MSOrderItemDetails_inputs_15"/>
			<input type="hidden" name="orderItemId" value="" id="WC_MSOrderItemDetails_inputs_16"/>
			<input type="hidden" name="quickCheckoutProfileForPayment" value="<c:out value='${quickCheckoutProfileForPayment}'/>" id="WC_MSOrderItemDetails_inputs_1"/>
			<input type="hidden" name="quickCheckOut" value="<c:out value='${quickCheckOut}'/>" id="WC_MSOrderItemDetails_inputs_2"/>
			<input type="hidden" name="forceShipmentType" value="2" id="WC_MSOrderItemDetails_inputs_3"/>
			<input type="hidden" name="shipmentTypeId" value="2" id="WC_MSOrderItemDetails_inputs_4"/>
			<input type="hidden" name="URL" value="OrderShippingBillingView" id="WC_MSOrderItemDetails_inputs_5"/>
			<input type="hidden" name="calculationUsage" value="-1,-2,-3,-4,-5,-6,-7" id="WC_MSOrderItemDetails_inputs_6"/>
		</form>
	</flow:ifDisabled>
<!-- We need this form in case of non-ajax checkout process... In Non-Ajax checkout process we will submit the entire form 
	 All the required hidden fields are defined at the end of this page before closing form tag. Update Shopping Cart function will
	 submit this form.. 
 -->

<flow:ifDisabled feature="AjaxCheckout"> 
	<form name="ShopCartForm" method="post" action="" id="ShopCartForm">
		<!-- Define all the hidden fields required for submitting this form in case of Non-Ajax Checkout -->
		<!-- for requesteddate, shipModeId, addressId, instructions, shipAscomplete fields, value is not needed here.. since values will be
		reset in the updateShoppingCart javascript function.. -->
		<input type="hidden" name="storeId" value='<c:out value="${storeId}"/>' id="WC_MSOrderItemDetails_inputs_19"/>
		<input type="hidden" name="langId" value='<c:out value="${langId}" />' id="WC_MSOrderItemDetails_inputs_20"/>
		<input type="hidden" name="orderId" value='<c:out value="${orderUniqueId}"/>' id="WC_MSOrderItemDetails_inputs_21"/>
		<input type="hidden" name="catalogId" value='<c:out value="${catalogId}"/>' id="WC_MSOrderItemDetails_inputs_22"/>
		<input type="hidden" name="errorViewName" value="OrderShippingBillingView" id="WC_MSOrderItemDetails_inputs_23"/>
		<input type="hidden" name="forceShipmentType" value="2" id="WC_MSOrderItemDetails_inputs_9"/>
		<c:forEach var="orderItem" items="${pgorder.orderItem}" varStatus="status">
			<flow:ifEnabled feature="StoreLocator">
				<input type="hidden" name='physicalStoreId_<c:out value="${status.count}"/>' id='physicalStoreId_<c:out value="${status.count}"/>' />
			</flow:ifEnabled>
			
			<input type="hidden" name='orderItemId_<c:out value="${status.count}"/>' id='orderItemId_<c:out value="${status.count}"/>' />				
			<input type="hidden" name='addressId_<c:out value="${status.count}"/>' id='addressId_<c:out value="${status.count}"/>' />				
			<input type="hidden" name='shipModeId_<c:out value="${status.count}"/>' id='shipModeId_<c:out value="${status.count}"/>' />				
			<c:if test="${!orderItem.orderItemAmount.freeGift}">
				<input type="hidden" name='shipInstructions_<c:out value="${status.count}"/>' id='shipInstructions_<c:out value="${status.count}"/>' />				
				<input type="hidden" name='requestedShipDate_<c:out value="${status.count}"/>' id='requestedShipDate_<c:out value="${status.count}"/>' />				
				<input type="hidden" name='isExpedited_<c:out value="${status.count}"/>' id='isExpedited_<c:out value="${status.count}"/>' />
			</c:if>
		</c:forEach>
		<!-- shipAsComplete is at order level..not at orderItemLevels..so one variable is enough -->
		<input type="hidden" name='ShipAsComplete' id='ShipAsComplete' />		
		<input type="hidden" name="URL" value="" id="URL"/>
		<input type="hidden" name="quickCheckoutProfileForPayment" value="<c:out value='${quickCheckoutProfileForPayment}'/>" id="WC_MSOrderItemDetails_inputs_10"/>
		<input type="hidden" name="calculationUsage" value="-1,-2,-3,-4,-5,-6,-7" id="WC_MSOrderItemDetails_inputs_24"/>
	</form>
</flow:ifDisabled>
 </table>
<c:if test="${numEntries > pageSize}">
	 <div class="shopcart_pagination" id="MSOrderItemDetailsPaginationText2">
		<span class="text">
			<fmt:message key="CATEGORY_RESULTS_DISPLAYING" bundle="${storeText}"> 
				<fmt:param><fmt:formatNumber value="${beginIndex + 1}"/></fmt:param>
				<fmt:param><fmt:formatNumber value="${endIndex}"/></fmt:param>
				<fmt:param><fmt:formatNumber value="${numEntries}"/></fmt:param>
			</fmt:message>
			<span class="paging">
				<c:if test="${beginIndex != 0}">
					<a id="MSOrderItemDetailsPaginationText2_1" href="javaScript:if(!CheckoutHelperJS.checkForDirtyFlag()){ setCurrentId('MSOrderItemDetailsPaginationText2_1'); if(submitRequest()){ cursor_wait();	
					wc.render.updateContext('multipleShipmentDetailsContext',{'beginIndex':'<c:out value='${beginIndex - pageSize}'/>','pageSize':'<c:out value='${pageSize}'/>'});}}">
				</c:if>
				<img src="<c:out value="${jspStoreImgDir}${vfileColorBIDI}" />paging_back.png" alt="<fmt:message key="CATEGORY_PAGING_LEFT_IMAGE" bundle="${storeText}"/>" />
				<c:if test="${beginIndex != 0}">
					</a>
				</c:if>
				<fmt:message key="CATEGORY_RESULTS_PAGES_DISPLAYING" bundle="${storeText}"> 
					<fmt:param><fmt:formatNumber value="${currentPage}"/></fmt:param>
					<fmt:param><fmt:formatNumber value="${totalPages}"/></fmt:param>
				</fmt:message>
				<c:if test="${numEntries > endIndex }">
					<a id="MSOrderItemDetailsPaginationText2_2" href="javaScript:if(!CheckoutHelperJS.checkForDirtyFlag()){ setCurrentId('MSOrderItemDetailsPaginationText2_2'); if(submitRequest()){ cursor_wait();	
					wc.render.updateContext('multipleShipmentDetailsContext',{'beginIndex':'<c:out value='${beginIndex + pageSize}'/>','pageSize':'<c:out value='${pageSize}'/>'});}}">		
				</c:if>
				<img src="<c:out value="${jspStoreImgDir}${vfileColorBIDI}" />paging_next.png" alt="<fmt:message key="CATEGORY_PAGING_RIGHT_IMAGE" bundle="${storeText}"/>" />
				<c:if test="${numEntries > endIndex }">
					</a>
				</c:if>
			</span>
		</span>
	</div>
</c:if> 
<div class="free_gifts_block">
	<%out.flush();%>
		<c:import url="${jspStoreDir}Snippets/Marketing/Promotions/PromotionPickYourFreeGift.jsp"/>
	<%out.flush();%>				
</div>	
