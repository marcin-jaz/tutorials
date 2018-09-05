<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2009 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>
<%--
  *****
  *
  * This JSP page displays the pending/current orders table with the following elements:
  *  - List of orders in pending state (saved Orders). For each order in the list the following is displayed:
  *    Order number, Order name, Last updated, Total price.
  *  - The current order (shopping cart order) is highlighted in bold.
  *  - For each order there is a 'Details' link that takes the user to the appropriate order details page.
  *
  * How to use this snippet?
  *	<c:import url="${jspStoreDir}Snippets/Order/Cart/ListOrdersDisplayTable.jsp" >
  *	</c:import>
  *
  *****
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>    
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf"%>

<c:set var="startNumber" value="${WCParam.startNumber}"/>
<c:if test="${empty startNumber || startNumber < 0}">
	<c:set var="startNumber" value="0" />
</c:if>

<c:set var="pageSize" value="${savedOrdersPageSize}"/>


<%--Content start--%>

<%--
***
* Start: List of pending (saved) orders
***
--%>
	
	<%-- Retrieve a list of pending orders. --%>
<wcf:getData type="com.ibm.commerce.order.facade.datatypes.OrderType[]"
		var="orders" varShowVerb = "ShowVerb" expressionBuilder="findByOrderStatus"
		maxItems='${pageSize}' recordSetStartNumber='${startNumber}' recordSetReferenceId="savedorders">
   <wcf:param name="status" value="P" />
</wcf:getData>

<c:if test="${ShowVerb.recordSetTotal == 1}">
	<script type="text/javascript">
	dojo.addOnLoad(function() {
		savedOrdersJS.checkAllIfNeeded();
	});
	</script>
</c:if>

<c:if test="${ShowVerb.recordSetTotal == 0}">
	<div id="current_orders" class="body737">
	  <fmt:message key="NO_SAVED_ORDERS" bundle="${storeText}"/>
	</div>
</c:if>

<c:if test="${ShowVerb.recordSetTotal != 0}">

<%-- If there are no orders on the current page then return to the first previous page that has orders on it. --%>
	<c:if test="${empty orders}">

		<c:set var="startNumber" value="${ShowVerb.recordSetTotal - pageSize}" />
		
		<wcf:getData type="com.ibm.commerce.order.facade.datatypes.OrderType[]"
				var="orders" varShowVerb = "ShowVerb" expressionBuilder="findByOrderStatus"
				maxItems='${pageSize}' recordSetStartNumber='${startNumber}' recordSetReferenceId="savedorders">
			<wcf:param name="status" value="P" />
		</wcf:getData>
	</c:if>
	
	
	<%--
	***
	* Get current order id (The current shopping cart).
	***
	--%>
	
	<c:set var="cart" value="${requestScope.orderInCart}"/>
	
	<c:if test="${empty cart || cart == null}">
		<wcf:getData type="com.ibm.commerce.order.facade.datatypes.OrderType"
				var="cart" expressionBuilder="findCurrentShoppingCartWithPagingOnItem"
				varShowVerb="ShowVerbCurrentCart" maxItems="1" recordSetStartNumber="0" recordSetReferenceId="currentOrderCart">
			<wcf:param name="accessProfile" value="IBM_Summary" />
		</wcf:getData>
	</c:if>
	
	<c:set var="currentOrderId" value="${cart.orderIdentifier.uniqueID}"/>
	
	<%-- Put the current order ID into a JSON so that it can be used in SavedOrders.js for further processing when needed. --%>
	<c:if test="${!empty cart}">
		<div id="currentOrderJSON" style="display: none">
		{
			"currentOrderId" : "${currentOrderId}"
		}
		</div>
	</c:if>
	
<%-- Display a list of pending order --%>
<div id="current_orders" class="body737">	
	<%-- Determine whether to show the paging buttons --%>	 
	<c:if test="${ShowVerb.recordSetTotal > pageSize}">		
		<div id="saved_orders_paging_top">
			<span id="saved_orders_paging_top_span">
				<c:if test="${ShowVerb.recordSetStartNumber != 0}">
					<c:set var="startNumberPrev" value= '${ShowVerb.recordSetStartNumber - pageSize}' />
						
					<a id="WC_ListOrdersDisplayTable_Link_1" href="javascript:savedOrdersJS.changePage('${startNumberPrev}');" >
				</c:if>
					<img src="<c:out value="${jspStoreImgDir}${vfileColorBIDI}" />paging_back.png" alt="<fmt:message key="PREVIOUS" bundle="${storeText}"/>" />
				<c:if test="${ShowVerb.recordSetStartNumber != 0}">
					</a>
				</c:if>
				
				<fmt:message key="PAGE_RESULTS" bundle="${storeText}">
					<fmt:param value="${ShowVerb.recordSetStartNumber+1}"/>
					<fmt:param value="${ShowVerb.recordSetStartNumber + ShowVerb.recordSetCount}"/>
					<fmt:param value="${ShowVerb.recordSetTotal}"/>
				</fmt:message>
				
				<c:if test="${!ShowVerb.recordSetCompleteIndicator}">
					<c:set var="startNumberNext" value= '${ShowVerb.recordSetStartNumber + pageSize}' />
					
					<a id="WC_ListOrdersDisplayTable_Link_2" href="javascript:savedOrdersJS.changePage('${startNumberNext}');">
				</c:if>			
					<img id="savedOrdersNextLink" src="<c:out value="${jspStoreImgDir}${vfileColorBIDI}" />paging_next.png" alt="<fmt:message key="NEXT" bundle="${storeText}"/>" />		
				<c:if test="${!ShowVerb.recordSetCompleteIndicator}">
					</a>
				</c:if>	
			</span>
		</div>  
	</c:if>


<div id="saved_orders" role="grid" class="table" aria-describedby="saved_orders_table_summary">
 <div id="saved_orders_table_summary" class="hidden_summary">
 	<fmt:message key="SAVED_ORDERS_LIST_SUMMARY" bundle="${storeText}"/>
 </div>	
	<div id="savedOrdersTable_header" role="row" class="row column_heading">
		<div role="columnheader" class="gridcell checkbox_column" id="WC_ListOrdersDisplayTable_TableCell_1">
			<input id="WC_ListOrdersDisplayTable_CurrentOrder_Checkbox" type="checkbox" value="" class="checkbox"
				onclick="javascript:savedOrdersJS.checkAll();" onfocus="dojo.addClass(this, 'savedOrderCheckboxFocus');"  onblur="dojo.removeClass(this, 'savedOrderCheckboxFocus');" />
			<label class="nodisplay" for="WC_ListOrdersDisplayTable_CurrentOrder_Checkbox"><fmt:message key="SAVED_ORDERS_SELECT_ALL" bundle="${storeText}"/></label>	
		</div>
		<div role="columnheader" class="gridcell order_number_column" id="WC_ListOrdersDisplayTable_TableCell_2"><fmt:message key="ORDER_NUMBER" bundle="${storeText}"/></div>
		<div role="columnheader" class="gridcell order_description_column" id="WC_ListOrdersDisplayTable_TableCell_3"><fmt:message key="ORDER_NAME" bundle="${storeText}" /></div>
		<div role="columnheader" class="gridcell last_update_column" id="WC_ListOrdersDisplayTable_TableCell_4"><fmt:message key="LAST_UPDATE" bundle="${storeText}"/></div>
		<div role="columnheader" class="gridcell total_price_column" id="WC_ListOrdersDisplayTable_TableCell_5"><fmt:message key="TOTAL_PRICE" bundle="${storeText}"/></div>
		<div class="gridcell clear_float"></div>
	</div>
	
	<c:forEach var="order" items="${orders}" varStatus="status">	
		<%-- Need to reset currencyFormatterDB as initialized in JSTLEnvironmentSetup.jspf, as the currency code used there is from commandContext. For saved orders we want to display which currency was used when the order was placed. --%>
		<c:remove var="currencyFormatterDB"/>
		
		<wcbase:useBean id="currencyFormatterDB" classname="com.ibm.commerce.common.beans.StoreCurrencyFormatDescriptionDataBean" scope="request" >
			<c:set property="storeId" value="${storeId}" target="${currencyFormatterDB}" />
			<c:set property="langId" value="${langId}" target="${currencyFormatterDB}" />
			<c:set property="currencyCode" value="${order.orderAmount.grandTotal.currency}" target="${currencyFormatterDB}" />
			<c:set property="numberUsage" value="-1" target="${currencyFormatterDB}" />
		</wcbase:useBean>
		
		<c:set var="currencyDecimal" value="${currencyFormatterDB.decimalPlaces}"/>
		
		<c:if test="${order.orderAmount.grandTotal.currency == 'KRW'}">
			<c:set property="currencySymbol" value="&#8361;" target="${currencyFormatterDB}"/>
		</c:if>
		
		<c:set var="orderId" value="${order.orderIdentifier.uniqueID}"/>
		
			<div role="row" id="savedOrdersTable_row_${status.count}" class="row">
		
			<div id="WC_ListOrdersDisplayTable_TableCell_10_<c:out value='${status.count}'/>" role="gridcell" class="gridcell checkbox_column">
				<input id="WC_ListOrdersDisplayTable_Checkbox_2_<c:out value='${orderId}'/>" type="checkbox" value="${orderId}"	class="checkbox"
					onclick="javascript:savedOrdersJS.checkOrder();" name="checkbox" onfocus="dojo.addClass(this, 'savedOrderCheckboxFocus');"  onblur="dojo.removeClass(this, 'savedOrderCheckboxFocus');"/>
			</div>
			
			<label class="nodisplay" for="WC_ListOrdersDisplayTable_Checkbox_2_<c:out value='${orderId}'/>">
				<fmt:message key="SAVED_ORDER_CHECKBOX_LABEL" bundle="${storeText}">
					<fmt:param value="${orderId}"/>
				</fmt:message>
			</label>
			<div id="WC_ListOrdersDisplayTable_TableCell_11_<c:out value='${status.count}'/>" role="gridcell" class="gridcell order_number_column">
				<p><span  class="left"><c:out value="${orderId}"/></span>
			
					<c:choose>
					<c:when test="${orderId == currentOrderId}">
						<wcf:url var="SavedOrderDetailsURL" value="OrderCalculate" type="Ajax">
						   <wcf:param name="langId" value="${langId}" />
						  <wcf:param name="storeId" value="${WCParam.storeId}" />
						  <wcf:param name="catalogId" value="${WCParam.catalogId}" />
						  <wcf:param name="URL" value="AjaxOrderItemDisplayView" />
						  <wcf:param name="errorViewName" value="AjaxOrderItemDisplayView" />
						  <wcf:param name="updatePrices" value="1" />
						  <wcf:param name="calculationUsageId" value="-1" />
						  <wcf:param name="orderId" value="." />
						</wcf:url>
					</c:when>
					<c:otherwise>
						<wcf:url var="SavedOrderDetailsURL" value="PendingOrderDisplayView" type="Ajax">
						  <wcf:param name="langId" value="${langId}" />						
						  <wcf:param name="storeId" value="${WCParam.storeId}" />
						  <wcf:param name="catalogId" value="${WCParam.catalogId}" />
						    <wcf:param name="orderId" value="${orderId}" />
						</wcf:url>
					</c:otherwise>
					</c:choose>
						<span class="left savedOrderDetailsLinkText"><a href="${SavedOrderDetailsURL}" title="<fmt:message key="SAVED_ORDERS_DETAILS_LABEL" bundle="${storeText}"><fmt:param value="${orderId}"/></fmt:message>" 
							onclick="if (!savedOrdersJS.noSavesPending()) return false;" class="order_content" id="WC_ListOrdersDisplayTable_Link_3_<c:out value='${status.count}'/>"><fmt:message key="DETAILS" bundle="${storeText}"/></a>
							<label class="nodisplay" for="WC_ListOrdersDisplayTable_Link_3_<c:out value='${status.count}'/>">
								<fmt:message key="SAVED_ORDERS_DETAILS_LABEL" bundle="${storeText}">
									<fmt:param value="${orderId}"/>
								</fmt:message>
							</label>
						</span>
						<span class="left">
							<c:if test="${orderId == currentOrderId}">
								- <fmt:message key="HEADER_SHOPPING_CART" bundle="${storeText}" />
							</c:if>
						</span>
						
				</p>
			</div>

			<div id="WC_ListOrdersDisplayTable_TableCell_12_<c:out value='${status.count}'/>" role="gridcell" class="gridcell order_description_column">
				<p>
					<input class="savedOrderDetailsInputBorder" title="<fmt:message key="SAVED_ORDERS_ORDER_NAME_LABEL" bundle="${storeText}"><fmt:param value="${orderId}"/></fmt:message>" type="text" value='<c:out value="${order.orderDescription}"/>' name="OrderDescription_${status.count}" id="OrderDescription_${orderId}" maxlength="254" onchange='javascript: savedOrdersJS.descriptionChanged("${orderId}","OrderDescription_${orderId}","OldOrderID_${orderId}");'/>
					<input type="hidden" id="OldOrderID_${orderId}" name="OldOrderID_${orderId}" value='<c:out value="${order.orderDescription}"/>' />
				</p>
			</div>

			<div id="WC_ListOrdersDisplayTable_TableCell_13_<c:out value='${status.count}'/>" role="gridcell" class="gridcell last_update_column">
				<c:choose>
					<c:when test="${!empty order.lastUpdateDate}">
						<c:catch>
							<fmt:parseDate var="lastUpdateDate" value="${order.lastUpdateDate}" pattern="yyyy-MM-dd'T'HH:mm:ss.SSS'Z'" timeZone="GMT"/>
						</c:catch>
						<c:if test="${empty lastUpdateDate}">
							<c:catch>
								<fmt:parseDate var="lastUpdateDate" value="${order.lastUpdateDate}" pattern="yyyy-MM-dd'T'HH:mm:ss'Z'" timeZone="GMT"/>
							</c:catch>
						</c:if>
						<p><fmt:formatDate value="${lastUpdateDate}" dateStyle="long"/></p>
					</c:when>
					<c:otherwise>
						<p><br /></p>
					</c:otherwise>
				</c:choose>
			</div>

			<div id="WC_ListOrdersDisplayTable_TableCell_14_<c:out value='${status.count}'/>" role="gridcell" class="gridcell total_price_column">
				<p><fmt:formatNumber value="${order.orderAmount.totalProductPrice.value}" type="currency" maxFractionDigits="${currencyDecimal}" currencySymbol="${currencyFormatterDB.currencySymbol}"/></p>
			</div>
			<div class="gridcell clear_float"></div>
		</div>
		
	</c:forEach>					
</div>



	<c:if test="${ShowVerb.recordSetTotal > pageSize}">
		<div id="saved_orders_paging_bottom">
			<span id="saved_orders_paging_bottom_span">
				<c:if test="${ShowVerb.recordSetStartNumber != 0}">
					<a id="WC_ListOrdersDisplayTable_Link_3" href="javascript:savedOrdersJS.changePage('${startNumberPrev}');">
				</c:if>
					<img id="paging_back_bottom_image" src="<c:out value="${jspStoreImgDir}${vfileColorBIDI}" />paging_back.png" alt="<fmt:message key="PREVIOUS" bundle="${storeText}"/>" />
				<c:if test="${ShowVerb.recordSetStartNumber != 0}">
					</a>
					<label class="nodisplay" for="WC_ListOrdersDisplayTable_Link_3"><fmt:message key="SAVED_ORDERS_PREV_PAGE_LABEL" bundle="${storeText}"/></label>
				</c:if>
				
				<fmt:message key="PAGE_RESULTS" bundle="${storeText}">
					<fmt:param value="${ShowVerb.recordSetStartNumber+1}"/>
					<fmt:param value="${ShowVerb.recordSetStartNumber + ShowVerb.recordSetCount}"/>
					<fmt:param value="${ShowVerb.recordSetTotal}"/>
				</fmt:message>
				
				<c:if test="${!ShowVerb.recordSetCompleteIndicator}">
					<a id="WC_ListOrdersDisplayTable_Link_4" href="javascript:savedOrdersJS.changePage('${startNumberNext}');">
				</c:if>			
					<img id="paging_next_bottom_image" src="<c:out value="${jspStoreImgDir}${vfileColorBIDI}" />paging_next.png" alt="<fmt:message key="NEXT" bundle="${storeText}"/>" />		
				<c:if test="${!ShowVerb.recordSetCompleteIndicator}">
					</a>
					<label class="nodisplay" for="WC_ListOrdersDisplayTable_Link_4"><fmt:message key="SAVED_ORDERS_NEXT_PAGE_LABEL" bundle="${storeText}"/></label>
				</c:if>	
			</span>
		</div>
	</c:if>	

	<span class="disabled_button" id="WC_ListOrdersDisplayTable_CurrentOrder_Button">
		<span class="button_container">
			<span class="button_bg">
				<span class="button_top">
					<span class="button_bottom">
						<a id="WC_ListOrdersDisplayTable_CurrentOrder_Link" onclick="javascript: savedOrdersJS.setCurrentOrder()" href="#">
							<fmt:message key="SET_CURRENT_ORDER" bundle="${storeText}"/><span id="WC_ListOrdersDisplayTable_CurrentOrder_Hidden_Label" class="hidden_summary"><fmt:message key="SET_CURRENT_ORDER_DISABLED" bundle="${storeText}"/></span>
						</a>
						<label id="WC_ListOrdersDisplayTable_CurrentOrder_Label" class="nodisplay" for="WC_ListOrdersDisplayTable_CurrentOrder_Link"><fmt:message key="SET_CURRENT_ORDER_DISABLED" bundle="${storeText}"/></label>
					</span>
				</span>
			</span>
		</span>
	</span>

</div>
</c:if>	


<%--
***
* End: List of pending (saved) orders
***
--%>
<%-- Content end --%>
