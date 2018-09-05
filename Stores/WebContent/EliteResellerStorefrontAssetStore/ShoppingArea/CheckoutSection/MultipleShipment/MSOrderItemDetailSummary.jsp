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
Displays the order details for Multiple Shipment on the Order Summary page
as well as Order Confirmation page 
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%-- Substring to search for --%>
<c:set var="search" value='"'/>
<%-- Substring to replace the search strng with --%>
<c:set var="replaceStr" value="'"/>

<c:set var="pageSize" value="${WCParam.pageSize}" />
<c:if test="${empty pageSize}">
	<c:set var="pageSize" value="${maxOrderItemsPerPage}"/>
</c:if>	
<fmt:parseNumber var="pageSize" value="${pageSize}"/>
<%-- Index to begin the order item paging with --%>
<c:set var="beginIndex" value="${WCParam.beginIndex}" />
<c:if test="${empty beginIndex}">
	<c:set var="beginIndex" value="0" />
</c:if> 

<%-- To identify which order page we're currently in --%>
<c:set var="orderPage" value="${param.orderPage}" />
<c:if test="${empty orderPage}">
	<c:set var="orderPage" value="${WCParam.orderPage}" />
</c:if> 
<%-- Retrieve the current page of order & order item information from this request --%>
<c:set var="mspagorder" value="${requestScope.order}" scope="request"/>

<c:if test="${empty mspagorder || mspagorder == null}">
<c:choose>
<c:when test="${WCParam.externalOrderId != null && WCParam.externalOrderId != ''}">
<wcf:getData type="com.ibm.commerce.order.facade.datatypes.OrderType" var="mspagorder" expressionBuilder="findOrderByExternalOrderID" maxItems="${pageSize}" recordSetStartNumber="${beginIndex}" varShowVerb="ShowVerbSummary" recordSetReferenceId="mssummarystatus" scope="request">
			<wcf:param name="orderId" value="${WCParam.externalOrderId}"/>
			<wcf:param name="accessProfile" value="IBM_External_Details" />
			<wcf:param name="sortOrderItemBy" value="orderItemID" />
			<wcf:param name="isSummary" value="false" />
</wcf:getData>
</c:when>
<c:when test="${WCParam.externalQuoteId != null && WCParam.externalQuoteId != ''}">
<wcf:getData type="com.ibm.commerce.order.facade.datatypes.QuoteType" var="quote" expressionBuilder="findQuoteByExternalQuoteID" maxItems="${pageSize}" recordSetStartNumber="${beginIndex}" varShowVerb="ShowVerbSummary" recordSetReferenceId="mssummarystatus" scope="request">
			<wcf:param name="quoteId" value="${WCParam.externalQuoteId}"/>
			<wcf:param name="accessProfile" value="IBM_External_Details" />
			<wcf:param name="sortOrderItemBy" value="orderItemID" />
			<wcf:param name="isSummary" value="false" />
</wcf:getData>
<c:set var="mspagorder" value="${quote.orderTemplate}" scope="request"/>
</c:when>
<c:otherwise>

	<c:choose>
		<c:when test="${orderPage == 'confirmation'}">
			<wcf:getData type="com.ibm.commerce.order.facade.datatypes.OrderType"
			var="mspagorder" expressionBuilder="findByOrderIdWithPagingOnItem" varShowVerb = "ShowVerbSummary" maxItems="${pageSize}" recordSetStartNumber="${beginIndex}" recordSetReferenceId="msconfirmstatus">
				<wcf:param name="orderId" value="${WCParam.orderId}"/>
				<wcf:param name="accessProfile" value="IBM_Details" />
				<wcf:param name="sortOrderItemBy" value="orderItemID" />
				<wcf:param name="isSummary" value="false" />
			</wcf:getData>
		</c:when>
		<c:otherwise>
			<wcf:getData type="com.ibm.commerce.order.facade.datatypes.OrderType"
	        var="mspagorder" expressionBuilder="findCurrentShoppingCartWithPagingOnItem" varShowVerb = "ShowVerbSummary" maxItems="${pageSize}" recordSetStartNumber="${beginIndex}" recordSetReferenceId="mssummarystatus">
				<wcf:param name="accessProfile" value="IBM_Details" />
				<wcf:param name="sortOrderItemBy" value="orderItemID" />
				<wcf:param name="isSummary" value="false" />
			</wcf:getData>
		</c:otherwise>
	</c:choose>
</c:otherwise>
</c:choose>
</c:if>
<c:if test="${beginIndex == 0}">
	<c:if test="${ShowVerbSummary.recordSetTotal > ShowVerbSummary.recordSetCount}">		
		<c:set var="pageSize" value="${ShowVerbSummary.recordSetCount}" />
	</c:if>
</c:if>	
<c:set var="numEntries" value="${ShowVerbSummary.recordSetTotal}"/>	

<wcf:url var="currentMSOrderItemDetailPaging" value="MSOrderItemPageView" type="Ajax">
	<wcf:param name="storeId"   value="${storeId}" />
	<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
	<wcf:param name="langId" value="${WCParam.langId}" />
	<wcf:param name="orderPage" value="${orderPage}" />
	<c:if test="${orderPage == 'confirmation'}">
		<wcf:param name="orderId" value="${WCParam.orderId}" />
	</c:if> 
</wcf:url>

<c:set var="orderStatus" value="${mspagorder.orderStatus.status}"/>
<c:set var="isOrderScheduled" value="false"/>
<c:if test="${!empty requestScope.isOrderScheduled}">
	<c:set var="isOrderScheduled" value="${requestScope.isOrderScheduled}"/>
</c:if>

<%-- Declare the controller to refresh the order item area on page index change for multiple shipment --%>
<script type="text/javascript">
dojo.addOnLoad(function(){CommonControllersDeclarationJS.setControllerURL('MSOrderItemPaginationDisplayController','<c:out value='${currentMSOrderItemDetailPaging}'/>');});
</script>

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

	<div class="shopcart_pagination" id="MSOrderItemDetailSummaryPagination1">
		<br/><br/>
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
					<a id="MSOrderItemDetailSummaryPagination1_1" href="javaScript:setCurrentId('MSOrderItemDetailSummaryPagination1_1'); if(submitRequest()){ cursor_wait();	
					CommonControllersDeclarationJS.setControllerURL('MSOrderItemPaginationDisplayController','<c:out value='${currentMSOrderItemDetailPaging}'/>');
					wc.render.updateContext('MSOrderItemPaginationDisplay_Context',{'beginIndex':'<c:out value='${beginIndex - pageSize}'/>','pageSize':'<c:out value='${pageSize}'/>','externalOrderId':'${WCParam.externalOrderId}','externalQuoteId':'${WCParam.externalQuoteId}'});}">
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
					<a id="MSOrderItemDetailSummaryPagination1_2" href="javaScript:setCurrentId('MSOrderItemDetailSummaryPagination1_2'); if(submitRequest()){ cursor_wait();	
					CommonControllersDeclarationJS.setControllerURL('MSOrderItemPaginationDisplayController','<c:out value='${currentMSOrderItemDetailPaging}'/>');
					wc.render.updateContext('MSOrderItemPaginationDisplay_Context',{'beginIndex':'<c:out value='${beginIndex + pageSize}'/>','pageSize':'<c:out value='${pageSize}'/>','externalOrderId':'${WCParam.externalOrderId}','externalQuoteId':'${WCParam.externalQuoteId}'});}">
				</c:if>
				<img src="<c:out value="${jspStoreImgDir}${vfileColorBIDI}" />paging_next.png" alt="<fmt:message key="CATEGORY_PAGING_RIGHT_IMAGE" bundle="${storeText}"/>" />
				<c:if test="${numEntries > endIndex }">
					</a>
				</c:if>
			</span>
		</span>
	</div>
</c:if> 


<table id="order_details" cellpadding="0" cellspacing="0" border="0" width="100%" summary="<fmt:message key="SHOPCART_TABLE_CONFIRM_SUMMARY_MULTI_SHIP" bundle="${storeText}"/>">
	<tr class="nested">
		<th class="align_left" id="MultipleShipments_tableCell_productName"><fmt:message key="PRODUCT" bundle="${storeText}"/></th>
		<th class="align_left" id="MultipleShipments_tableCell_shipAddress"><fmt:message key="SHIP_SHIPPING_ADDRESS" bundle="${storeText}"/></th>
		<th class="align_left" id="MultipleShipments_tableCell_shipMethod"><fmt:message key="SHIP_SHIPPING_METHOD" bundle="${storeText}"/></th>
		<th class="align_left" id="MultipleShipments_tableCell_availability"><fmt:message key="AVAILABILITY" bundle="${storeText}"/></th>
		<th class="align_center" id="MultipleShipments_tableCell_quantity" abbr="<fmt:message key="QUANTITY1" bundle="${storeText}"/>"><fmt:message key="QTY" bundle="${storeText}"/></th>
		<th class="align_right" id="MultipleShipments_tableCell_unitPrice" abbr="<fmt:message key="UNIT_PRICE" bundle="${storeText}"/>"><fmt:message key="EACH" bundle="${storeText}"/></th>
		<th class="align_right" id="MultipleShipments_tableCell_totalPrice" abbr="<fmt:message key="TOTAL_PRICE" bundle="${storeText}"/>"><fmt:message key="TOTAL" bundle="${storeText}"/></th>
	</tr>
	
	<c:if test="${!empty mspagorder.orderItem}">
		<wcf:getData type="com.ibm.commerce.catalog.facade.datatypes.CatalogEntryType[]" var="catalogEntriesForAttributes" expressionBuilder="getStoreCatalogEntryAttributesByIDs">
			<wcf:contextData name="storeId" data="${WCParam.storeId}"/>
			<c:forEach var="orderItem" items="${mspagorder.orderItem}">
				<%@ include file="../../../Snippets/Catalog/CatalogEntryDisplay/ResolveCatalogEntryIDExt.jspf" %>
				<wcf:param name="UniqueID" value="${orderItem.catalogEntryIdentifier.uniqueID}"/>
			</c:forEach>
			<wcf:param name="dataLanguageIds" value="${WCParam.langId}"/>
		</wcf:getData>
	</c:if>
	
	<c:forEach var="orderItem" items="${mspagorder.orderItem}" varStatus="status">
		<wcbase:useBean id="catEntry" classname="com.ibm.commerce.catalog.beans.CatalogEntryDataBean" scope="request">
			<c:set property="catalogEntryID" value="${orderItem.catalogEntryIdentifier.uniqueID}" target="${catEntry}" />
		</wcbase:useBean>
		
		<%-- get the formatted qty for this item --%>
		<fmt:formatNumber	var="quickCartOrderItemQuantity" value="${orderItem.quantity.value}" type="number" maxFractionDigits="0"/>
		<%-- keep setting total number of items variable..in the last loop, it will contain correct value :-)better to get this value using length function.. --%>
		<c:set var="totalNumberOfItems" value="${status.count}"/>
		<input type="hidden" value='<c:out value="${orderItem.orderItemIdentifier.uniqueID}"/>' name='orderItem_<c:out value="${status.count}"/>' id='orderItem_<c:out value="${status.count}"/>'/>
		<input type="hidden" value='<c:out value="${orderItem.catalogEntryIdentifier.uniqueID}"/>' name='catalogId_<c:out value="${status.count}"/>' id='catalogId_<c:out value="${status.count}"/>'/>
		
		<c:forEach var="discounts" items="${orderItem.orderItemAmount.adjustment}">	
				<c:if test="${discounts.displayLevel == 'OrderItem'}">
					<c:set var="nobottom" value="th_align_left_no_bottom"/>
				</c:if>
		</c:forEach>
		<tr>
			 <th class="<c:out value="${nobottom}"/> th_align_left_normal" id="MultipleShipping_rowHeader_product<c:out value='${status.count}'/>" abbr="<fmt:message key="Checkout_ACCE_for" bundle="${storeText}"/> <c:out value='${catEntry.description.name}'/>" width="150">
				<div class="img" id="WC_MSOrderItemDetailsSummaryf_div_1_<c:out value='${status.count}'/>">
					<c:choose>
						<c:when test="${!empty catEntry.description.thumbNail}">
							<img src="<c:out value='${catEntry.objectPath}${catEntry.description.thumbNail}'/>" 
							alt="<c:out value='${catEntry.description.name}' escapeXml='false'/>" 
							border="0" width="70" height="70"/>							
						</c:when>
						<c:otherwise>
							<img src="<c:out value='${jspStoreImgDir}' />images/NoImageIcon_sm.jpg" 
							alt="<c:out value='${catEntry.description.name}' escapeXml='false'/>" 
							border="0" width="70" height="70"/>							
						</c:otherwise>
					</c:choose>
				</div>
				<div class="itemspecs" id="WC_MSOrderItemDetailsSummaryf_div_2_<c:out value='${status.count}'/>">
					<c:out value="${catEntry.description.name}" escapeXml="false"/><br/>
					<fmt:message key="CurrentOrder_SKU" bundle="${storeText}"/> 
					<c:choose>
						<c:when test="${ catEntry.partNumber == null}">
							<fmt:message key="MO_NOT_AVAILABLE" bundle="${storeText}"/>		
						</c:when>
						<c:otherwise>
							<c:out value="${catEntry.partNumber}" escapeXml="false"/>
						</c:otherwise>
					</c:choose>		
					<br/>

										<%--
					 ***
					 * Start: Display Defining attributes
					 * Loop through the attribute values and display the defining attributes
					 ***
					--%>
					
					<c:forEach var="catalogEntry1" items="${catalogEntriesForAttributes}">
						<c:if test="${catalogEntry1.catalogEntryIdentifier.uniqueID == orderItem.catalogEntryIdentifier.uniqueID}">
							<c:forEach var="attribute" items="${catalogEntry1.catalogEntryAttributes.attributes}">
								<c:if test="${ attribute.usage=='Defining' }" >	
									<span class="strongtext"><c:out value="${attribute.name}"  escapeXml="false" /> : </span>
									<c:choose>
									<c:when test="${ !empty attribute.value.value}">
										<c:out value="${attribute.value.value}"  escapeXml="false" />		
									</c:when>
									<c:otherwise>
										<fmt:message key="MO_NOT_AVAILABLE" bundle="${storeText}"/>
									</c:otherwise>
								</c:choose>		
									
																	
									<br />
								</c:if>
							</c:forEach>
						</c:if>
					</c:forEach>
					<%--
					 ***
					 * End: Display Defining attributes
					 ***
					--%>
					<c:if test="${b2bStore}">
						<c:set var="isShoppingCartPage" value="false"/>
						<%@ include file="../../../Snippets/Order/Cart/B2BContractSelectExt.jspf" %>
					</c:if>	
					<br />
				</div>
			</th>
			
			<td class="<c:out value="${nobottom}"/> shipAddress" headers="MultipleShipments_tableCell_shipAddress MultipleShipping_rowHeader_product<c:out value='${status.count}'/>" id="WC_MSOrderItemDetailsSummaryf_td_1_<c:out value='${status.count}'/>">
				<div class="shipping_address_nester" id="WC_MSOrderItemDetailsSummaryf_div_3_<c:out value='${status.count}'/>"> 
				<c:if test="${!empty orderItem.orderItemShippingInfo}">
					<c:set var="contact" value="${orderItem.orderItemShippingInfo.shippingAddress}"/>
					<c:if test="${!empty contact.contactInfoIdentifier.externalIdentifier.contactInfoNickName}">
					<p><c:choose><c:when test="${contact.contactInfoIdentifier.externalIdentifier.contactInfoNickName eq  profileShippingNickname}"><fmt:message key="QC_DEFAULT_SHIPPING" bundle="${storeText}"/></c:when>
						<c:when test="${contact.contactInfoIdentifier.externalIdentifier.contactInfoNickName eq  profileBillingNickname}"><fmt:message key="QC_DEFAULT_BILLING" bundle="${storeText}"/></c:when>
						<c:otherwise>${contact.contactInfoIdentifier.externalIdentifier.contactInfoNickName}</c:otherwise></c:choose></p>
					</c:if>
					<!-- Display shiping address of the order -->
					<%@ include file="../../../Snippets/ReusableObjects/AddressDisplay.jspf"%>
				</c:if>
				</div>
			</td>

			<td class="<c:out value="${nobottom}"/> shipMethod" id="WC_MSOrderItemDetailsSummaryf_td_2_<c:out value='${status.count}'/>" headers="MultipleShipments_tableCell_shipMethod MultipleShipping_rowHeader_product<c:out value='${status.count}'/>">
				<div class="shipping_method_nested" id="WC_MSOrderItemDetailsSummaryf_div_4_<c:out value='${status.count}'/>">
					
					<c:if test="${!empty orderItem.orderItemShippingInfo}">
					<p>
						<c:out value="${orderItem.orderItemShippingInfo.shippingMode.description.value}"/>
					</p>
					</c:if>
					
					<br/>

					<flow:ifEnabled feature="ShippingChargeType">
						<wcbase:useBean id="shipCharges" classname="com.ibm.commerce.order.beans.UsableShipChargesAndAccountByShipModeDataBean" scope="page">
							<c:set property="orderId" value="${order.orderIdentifier.uniqueID}" 	target="${shipCharges}"  />
						</wcbase:useBean>
						
						<c:if test="${not empty shipCharges.shipChargesByShipMode}">
							<c:forEach items="${shipCharges.shipChargesByShipMode}" var="shipCharges_shipModeData"  varStatus="counter1">
						<c:if test="${!empty orderItem.orderItemShippingInfo}">	
								<c:if test="${shipCharges_shipModeData.shipModeDesc == orderItem.orderItemShippingInfo.shippingMode.description.value}">
									<c:forEach items="${shipCharges_shipModeData.shippingChargeTypes}" var="shipCharges_data"  varStatus="counter2">
										<c:if test="${shipCharges_data.selected}">
											<p>
												<span class="title"><fmt:message key="ShippingChargeType" bundle="${storeText}"/>:</span>
												<span class="text"><fmt:message key="${shipCharges_data.policyName}" bundle="${storeText}"/></span>
											</p>
											<c:if test="${shipCharges_data.carrAccntNumber != null && shipCharges_data.carrAccntNumber != ''}">
												<p>
													<span class="title"><fmt:message key="ShippingChargeAcctNum" bundle="${storeText}"/>:</span>
													<span class="text"><c:out value="${shipCharges_data.carrAccntNumber}"/></span>
												</p>
											</c:if>
										</c:if>
									</c:forEach>
								</c:if>
							</c:if>	
							</c:forEach>
						</c:if>
					</flow:ifEnabled>

					<c:if test="${!orderItem.orderItemAmount.freeGift}">
						<flow:ifEnabled feature="ShippingInstructions">
							<c:set var="shipInstructions" value="${orderItem.orderItemShippingInfo.shippingInstruction}"/>
							<c:if test="${!empty shipInstructions}">
								<p class="text"><fmt:message key="SHIP_SHIPPING_INSTRUCTIONS" bundle="${storeText}" />:</p>
								<p class="text"><c:out value = "${shipInstructions}"/></p>
								<br />
							</c:if>
							<c:if test="${shipInstructions == null}">
							<p class="text"><fmt:message key="SHIP_SHIPPING_INSTRUCTIONS" bundle="${storeText}" />:</p>
							<p class="text">	
								<fmt:message key="MO_NOT_AVAILABLE" bundle="${storeText}"/>
							</p>
							</c:if>
						</flow:ifEnabled>
									
						<flow:ifEnabled feature="FutureOrders">
							<c:if test="${orderStatus != 'I' && !isOrderScheduled && !empty orderItem.orderItemShippingInfo}">
								<c:set var="requestedShipDate" value="${orderItem.orderItemShippingInfo.requestedShipDate}"/>
								<c:remove var="formattedDate"/>
								
								<c:if test='${!empty requestedShipDate}'>
									<c:catch>
										<fmt:parseDate var="expectedShipDate" value="${requestedShipDate}" pattern="yyyy-MM-dd'T'HH:mm:ss.SSS'Z'" timeZone="GMT"/>
									</c:catch>
									<c:if test="${empty expectedShipDate}">
										<c:catch>
											<fmt:parseDate var="expectedShipDate" value="${requestedShipDate}" pattern="yyyy-MM-dd'T'HH:mm:ss'Z'" timeZone="GMT"/>
										</c:catch>
									</c:if>
									<%-- use value from WC_timeoffset to adjust to browser time zone --%>
									<%-- Format the timezone retrieved from cookie since it is in decimal representation --%>
									<%-- Convert the decimals back to the correct timezone format such as :30 and :45 --%>
									<%-- Only .75 and .5 are converted as currently these are the only timezones with decimals --%>								
									<c:set var="formattedTimeZone" value="${fn:replace(cookie.WC_timeoffset.value, '%2B', '+')}"/>													
									<c:set var="formattedTimeZone" value="${fn:replace(formattedTimeZone, '.75', ':45')}"/>	
									<c:set var="formattedTimeZone" value="${fn:replace(formattedTimeZone, '.5', ':30')}"/>							
									<fmt:formatDate value="${expectedShipDate}" type="date" dateStyle="long" var="formattedDate" timeZone="${formattedTimeZone}"/>
								</c:if>
								<c:if test="${!empty formattedDate}">
									<p>
										<p class="text"><fmt:message key="SHIP_REQUESTED_DATE" bundle="${storeText}" />:</p>
										<p class="text">
										<c:choose>
											<c:when test = "${formattedDate == null}">
												<fmt:message key="MO_NOT_AVAILABLE" bundle="${storeText}"/>
											</c:when>
											<c:otherwise>
												<c:out value="${formattedDate}"/>
											</c:otherwise>
										</c:choose>		
										</p>
									 </p>
									<br />
								</c:if>
							</c:if>
						</flow:ifEnabled>
						<flow:ifEnabled feature="ExpeditedOrders">
							<c:if test="${orderStatus != 'I' && !isOrderScheduled && !empty orderItem.orderItemShippingInfo}">
								<c:if test="${orderItem.orderItemShippingInfo.expedite}">
									<span class="text"><fmt:message key="SHIP_EXPEDITE_SHIPPING" bundle="${storeText}"/>:</span>
									<span class="text"><fmt:message key="YES" bundle="${storeText}"/></span>
									<br />
								</c:if>
							</c:if>
						</flow:ifEnabled>
					</c:if>
				</div>
			</td>  

			<td id="WC_MSOrderItemDetailsSummaryf_td_3_<c:out value='${status.count}'/>" class="<c:out value="${nobottom}"/> avail" headers="MultipleShipments_tableCell_availability MultipleShipping_rowHeader_product<c:out value='${status.count}'/>">
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
			<td id="WC_MSOrderItemDetailsSummaryf_td_4_<c:out value='${status.count}'/>" class="<c:out value="${nobottom}"/> QTY" headers="MultipleShipments_tableCell_quantity MultipleShipping_rowHeader_product<c:out value='${status.count}'/>">
				<p class="item-quantity">
					<fmt:formatNumber	var="quickCartOrderItemQuantity" value="${orderItem.quantity.value}" type="number" maxFractionDigits="0"/>
					<c:choose>
							<c:when test="${!empty quickCartOrderItemQuantity}">
								<c:out value="${quickCartOrderItemQuantity}"/>
							</c:when>
							<c:otherwise>
								<fmt:message key="MO_NOT_AVAILABLE" bundle="${storeText}"/>
							</c:otherwise>
					</c:choose>			
					
					
				</p>
			</td>
			<td id="WC_MSOrderItemDetailsSummaryf_td_5_<c:out value='${status.count}'/>" class="<c:out value="${nobottom}"/> each" headers="MultipleShipments_tableCell_unitPrice MultipleShipping_rowHeader_product<c:out value='${status.count}'/>">
				<c:choose>
					<c:when test="${catEntry.item}">
						<c:set var="type" value="item" />
						<c:set var="catalogEntryDB" value="${catEntry.itemDataBean}" />
					</c:when>
					<c:when test="${catEntry.package}">
						<c:set var="type" value="package" />
						<c:set var="catalogEntryDB" value="${catEntry.packageDataBean}" />
					</c:when>
				</c:choose>
				<%-- unit price column of order item details table --%>
				<%-- shows unit price of the order item --%>
				<span class="price">
					<c:choose>
							<c:when test="${!empty orderItem.orderItemAmount.unitPrice.price.value}">
								<fmt:formatNumber value="${orderItem.orderItemAmount.unitPrice.price.value}" type="currency" maxFractionDigits="${currencyDecimal}" currencySymbol="${currencyFormatterDB.currencySymbol}"/>
							</c:when>
							<c:otherwise>
								<fmt:message key="MO_NOT_AVAILABLE" bundle="${storeText}"/>
							</c:otherwise>
					</c:choose>		

					
				</span>					
			</td>
			<td id="WC_MSOrderItemDetailsSummaryf_td_6_<c:out value='${status.count}'/>" class="<c:out value="${nobottom}"/> total" headers="MultipleShipments_tableCell_totalPrice MultipleShipping_rowHeader_product<c:out value='${status.count}'/>">
				<c:choose>
					<c:when test="${orderItem.orderItemAmount.freeGift}">
						<%-- the OrderItem is a freebie --%>
						<span class="details">
							<fmt:message key="Free" bundle="${storeText}"/>
						</span>
					</c:when>
					<c:otherwise>
						<span class="price">
							
						<c:choose>
							<c:when test="${ !empty orderItem.orderItemAmount.orderItemPrice.value}">
								<fmt:formatNumber var="totalFormattedProductPrice" value="${orderItem.orderItemAmount.orderItemPrice.value}" type="currency" maxFractionDigits="${currencyDecimal}" currencySymbol="${currencyFormatterDB.currencySymbol}"/>
								<c:out value="${totalFormattedProductPrice}" escapeXml="false" />
							</c:when>
							<c:otherwise>
								<fmt:message key="MO_NOT_AVAILABLE" bundle="${storeText}"/>
							</c:otherwise>
						</c:choose>		
													
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
						<th colspan="6" class="th_align_left_dotted_top_solid_bottom" abbr="<fmt:message key="Checkout_ACCE_prod_discount" bundle="${storeText}"/> <c:out value='${catEntry.description.name}'/>" id="MultipleShipment_rowHeader_discount<c:out value='${status.count}'/>_<c:out value='${status2.count}'/>">
							<div class="itemspecs" id="WC_MSOrderItemDetailsSummaryf_div_5_<c:out value='${status.count}'/>_<c:out value='${status2.count}'/>">
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
						<td id="WC_MSOrderItemDetailsSummaryf_td_7_<c:out value='${status.count}'/>_<c:out value='${status2.count}'/>" class="th_align_left_dotted_top_solid_bottom total" headers="MultipleShipment_rowHeader_discount<c:out value='${status.count}'/>_<c:out value='${status2.count}'/>">
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
	<%-- dont change the name of this hidden input element. This variable is used in CheckoutHelper.js --%>
	<input type="hidden" id = "totalNumberOfItems" name="totalNumberOfItems" value='<c:out value="${totalNumberOfItems}"/>'/>
 </table>

<c:if test="${numEntries > pageSize}">
	 <div class="shopcart_pagination" id="MSOrderItemDetailSummaryPagination2">
		<span class="text">
			<fmt:message key="CATEGORY_RESULTS_DISPLAYING" bundle="${storeText}"> 
				<fmt:param><fmt:formatNumber value="${beginIndex + 1}"/></fmt:param>
				<fmt:param><fmt:formatNumber value="${endIndex}"/></fmt:param>
				<fmt:param><fmt:formatNumber value="${numEntries}"/></fmt:param>
			</fmt:message>
			<span class="paging">
				<c:if test="${beginIndex != 0}">
					<a id="MSOrderItemDetailSummaryPagination2_1" href="javaScript:setCurrentId('MSOrderItemDetailSummaryPagination2_1'); if(submitRequest()){ cursor_wait();	
					CommonControllersDeclarationJS.setControllerURL('MSOrderItemPaginationDisplayController','<c:out value='${currentMSOrderItemDetailPaging}'/>');
					wc.render.updateContext('MSOrderItemPaginationDisplay_Context',{'beginIndex':'<c:out value='${beginIndex - pageSize}'/>','pageSize':'<c:out value='${pageSize}'/>','externalOrderId':'${WCParam.externalOrderId}','externalQuoteId':'${WCParam.externalQuoteId}'});}">
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
					<a id="MSOrderItemDetailSummaryPagination2_2" href="javaScript:setCurrentId('MSOrderItemDetailSummaryPagination2_2'); if(submitRequest()){ cursor_wait();	
					CommonControllersDeclarationJS.setControllerURL('MSOrderItemPaginationDisplayController','<c:out value='${currentMSOrderItemDetailPaging}'/>');
					wc.render.updateContext('MSOrderItemPaginationDisplay_Context',{'beginIndex':'<c:out value='${beginIndex + pageSize}'/>','pageSize':'<c:out value='${pageSize}'/>','externalOrderId':'${WCParam.externalOrderId}','externalQuoteId':'${WCParam.externalQuoteId}'});}">
				</c:if>
				<img src="<c:out value="${jspStoreImgDir}${vfileColorBIDI}" />paging_next.png" alt="<fmt:message key="CATEGORY_PAGING_RIGHT_IMAGE" bundle="${storeText}"/>" />
				<c:if test="${numEntries > endIndex }">
					</a>
				</c:if>
			</span>
		</span>
	</div>
</c:if> 
