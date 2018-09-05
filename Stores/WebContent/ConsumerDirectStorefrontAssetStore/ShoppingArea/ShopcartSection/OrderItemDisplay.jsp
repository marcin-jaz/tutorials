<%
//********************************************************************
//*-------------------------------------------------------------------
//* Licensed Materials - Property of IBM
//*
//* WebSphere Commerce
//*
//* (c) Copyright IBM Corp. 2000, 2002, 2004
//*
//* US Government Users Restricted Rights - Use, duplication or
//* disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
//*
//*-------------------------------------------------------------------
//*
%>

<%--
  *****
  * This page show the shopping cart for the user's order.
  *
  * The main content panel shows:
  * - A breadcrumb trail for the checkout process
  * - For each order item:
  * 	- Quantity
  *		- Clickable item short description (links to display page for order item)
  * 	- Attribute values for each order item
  * 	- Order item level promotion (if applicable)
  *		- Listed price and item price (item price shown if less then listed price)
  *		- Total price for each order item (quantity adjusted) 	
  * 	- Link to remove items from shopcart
  *	- 'Update totals' button (used to recalculate shopcart contents after quantity field changed)
  *	- Error status if there is a problem with the item
  * - 'Quick checkout' button (links to Quick Checkout Summary page)
  * - 'Checkout' button (submits shopcart to begin checkout process)
  * 
  * The page also displays the 'ShoppingCartPage' eMarketing Spot at the bottom of the page
  *****
--%>

<!-- Start - JSP File Name:  OrderItemDisplay.jsp -->

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../include/JSTLEnvironmentSetup.jspf"%>
<%@ include file="../../include/nocache.jspf"%>

<wcbase:useBean id="bnError" classname="com.ibm.commerce.beans.ErrorDataBean" scope="page" />

<%-- ErrorMessageSetup.jspf is used to retrieve an appropriate error message when there is an error --%>
<%@ include file="../../include/ErrorMessageSetup.jspf"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>

<c:set var="bHasShopCart" value="false" />
<c:set var="thisOrderId" value="${WCParam.orderId}" />

<%-- 
	***
	* Check to see if shopcart is empty.  If empty, display shopcart is empty error message. If order items exist, display shopcart contents.
	***
--%>
<c:choose>
	<%-- Check to see if there us an order id, if no, then shopping cart is empty--%>
	<%-- 
		***
		* The checking below cannot be used in the JSP preview environment because orderId[0] is not available.
		* If this file is going to be used for previewing, replace <c:when test="${empty WCParam.orderId}" > with:
		*  <c:when test="false" >
		***
	--%>
	<c:when test="${ empty WCParam.orderId }" >
		<c:set var="bHasShopCart" value="false"/>
	</c:when>
	<c:otherwise>

		<c:set var="pageSize" value="${maxOrderItemsPerPage}"/>
		<c:if test="${empty pageSize}">
			<c:set var="pageSize" value="20"/>
		</c:if>
		<c:set var="currentPage" value="${WCParam.currentPage}"/>
		<c:if test="${empty currentPage}">
			<c:set var="currentPage" value="1"/>
		</c:if>

		<%-- If there is an order id, then activate the orderbean--%>
		<flow:ifDisabled feature="GiftRegistry">
		<wcbase:useBean id="orderBean" classname="com.ibm.commerce.order.beans.OrderDataBean" scope="page">
			<c:set value="${WCParam.orderId}" target="${orderBean}" property="orderId"/>
			<c:set value="${pageSize}" target="${orderBean}" property="pageSize"/>
			<c:set value="${currentPage}" target="${orderBean}" property="currentPage" />
		</wcbase:useBean>

		<%-- get pageSize from OrderDataBean again - if passed in page size is greater than max value, pageSize will set to max value --%>
		<c:set var="pageSize" value="${orderBean.pageSize}"/>

		<%-- If there is an order id, then check to see if there are items associated with the order id obtained from the command--%>
		<c:set var="orderItems" value="${orderBean.orderItemDataBeans}" />
		</flow:ifDisabled>
		
		<%-- 
		  ***
		  *	Start: GiftRegistryCode
		  *
		  ***
		--%>
		<flow:ifEnabled feature="GiftRegistry">
			<%@ include file="..\..\Snippets\OrderItemGRDisplay.jspf" %>
			<c:set var="orderItems" value="${orderBean.giftRegistryOrderItemDBs}" />
		</flow:ifEnabled>
		<%-- 
		  ***
		  *	End: GiftRegistryCode
		  ***
		--%>	
		
	    <c:choose>
	    	<%-- if there are items, then there are items in the shopping cart --%>
	   		<c:when test="${ !empty orderItems }" >
				<c:set var="bHasShopCart" value="true"/>
	   		</c:when>
			<%--if there are no items,then the shopping cart is empty --%>
			<c:otherwise>
				<c:set var="bHasShopCart" value="false"/>
			</c:otherwise>
		</c:choose>
	</c:otherwise>
</c:choose>
<%-- 
	***
	* End of check to see if shopcart is empty.  
	***
--%>

<c:choose> 
	<c:when test="${ !bHasShopCart }">
		<%-- If the shopcart is empty, then display the empty shopcart jsp --%>
		<c:set var="incfile" value="${jspStoreDir}ShoppingArea/ShopcartSection/EmptyShopCartDisplay.jsp" />
		<c:import url="${incfile}"/> 
	</c:when>
	<%-- 
		*** 
		* Shopcart is not empty.  display shopcart conents
		***
	--%>
	<c:otherwise>

	<flow:ifEnabled feature="quickCheckout">
	
	<!-- get the "profile" order containing the default payment and billing info -->
	<wcbase:useBean id="orderProfileListBean" classname="com.ibm.commerce.order.beans.OrderListDataBean" scope="request"> 
		<c:set target="${orderProfileListBean}" property="storeId" value="${WCParam.storeId}"/>
		<c:set target="${orderProfileListBean}" property="userId" value="${CommandContext.userId}"/>   
		<c:set target="${orderProfileListBean}" property="retrievalOrderStatus" value="Q"/>
	</wcbase:useBean>
	
	<c:forEach items="${orderProfileListBean.orderDataBeans}" var="prof_orderBean" varStatus="status">
		<c:forEach var="orderProfileItem" items="${prof_orderBean.orderItemDataBeans}" varStatus="status2">
			<c:set var="profileShipModeId" value="${orderProfileItem.shippingModeId}"/>
		</c:forEach>
	</c:forEach>
	
	</flow:ifEnabled>
	
<head>
	<title>
		<fmt:message key="SHOPPINGCART_TITLE" bundle="${storeText}"/>
	</title>
		<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${vfileStylesheet}"/>" type="text/css"/>

	<%--
		***
		* Javascript that will activate recalculation of shopcart contents
		***
	--%>
	<script type="text/javascript" language="javascript">
	var busy = false;
	var shipModeUpdate = false;

	function UpdateTotal(form, url, pageNumber)
	{
		form.page.value ='';
		var index=0;
		if (form.URL.type == undefined) {
			//means multiple options such as radio selection
			while (form.URL[index].checked!=true)
			{
				index++;
			}
			if (url == undefined) {
				form.URL[index].value = 'OrderCalculate?updatePrices=1&calculationUsageId=-1&orderItemId*=&quantity*=&URL=OrderItemDisplay';
			} else {
				if (pageNumber == undefined) {
					form.URL[index].value = url + '&orderItemId*=&quantity*=';
				} else {
					form.URL[index].value = url + '&orderItemId*=&quantity*=&currentPage=' + pageNumber;
				}
			}
		} else {
			//means no option, which is a hidden
			if (url == undefined) {
				form.URL.value = 'OrderCalculate?updatePrices=1&calculationUsageId=-1&orderItemId*=&quantity*=&URL=OrderItemDisplay';
			} else {
				if (pageNumber == undefined) {
					form.URL.value = url + '&orderItemId*=&quantity*=';
				} else {
					form.URL.value = url + '&orderItemId*=&quantity*=&currentPage=' + pageNumber;
				}
			}
		}
		form.submit();
	}


	function updateShipModeField(shipModeUpdateValue)
	{
		shipModeUpdate = shipModeUpdateValue;
	}

	function SubmitCart(form)
	{
		if(form.currentPage!= undefined){
			var pageNumber = parseInt(form.currentPage.value);
			if ( pageNumber !="NaN" && pageNumber >=1 && pageNumber > <c:out value="${orderBean.totalPages}" /> )
				form.currentPage.value = 1;
		}
		if (!busy)
		{
			busy = true;			
			if (shipModeUpdate)
			{
			<c:forEach var="orderItem" items="${orderBean.orderItemDataBeans}" varStatus="status">
				form.shipModeId_<c:out value="${status.count}"/>.value = '<c:out value="${profileShipModeId}"/>';
			</c:forEach>
			}
			var qtyFlag = 0;
			for (var i=0; i<document.ShopCartForm.length; i++) {	
				var elem = document.ShopCartForm.elements[i];
					if(elem.name.length >= 10 && elem.name.substring(0,8) =='quantity' && elem.value > 0)
					{
						qtyFlag = 1;
						break;
					}
			}
			if(qtyFlag == 0)
			{
				var index=0;
				if (form.URL.type == undefined) {
					while (form.URL[index].checked!=true)
					{
						index++;
					}
					form.URL[index].value = 'OrderCalculate?updatePrices=1&calculationUsageId=-1&orderItemId*=&quantity*=&URL=OrderItemDisplay';
				}
				else{
					form.URL.value = 'OrderCalculate?updatePrices=1&calculationUsageId=-1&orderItemId*=&quantity*=&URL=OrderItemDisplay';
				}
			}
			form.submit();
		}
	}



</script>
	<%--	
		***
		* End of javascript
		***
	--%>

</head>

	<body>
	<!-- JSP File Name:  TopCategoriesDisplay.jsp -->

	<%@ include file="../../include/LayoutContainerTop.jspf"%>

	<!--MAIN CONTENT STARTS HERE-->
	<form name="ShopCartForm" method="post" action="OrderItemUpdate" id="ShopCartForm">
		<input type="hidden" name="storeId" value="<c:out value="${WCParam.storeId}" />" id="WC_OrderItemDisplay_FormInput_storeId_In_ShopCartForm_1"/>
		<input type="hidden" name="langId" value="<c:out value="${langId}" />" id="WC_OrderItemDisplay_FormInput_langId_In_ShopCartForm_1"/>
		<input type="hidden" name="orderId" value="<c:out value="${WCParam.orderId}" />" id="WC_OrderItemDisplay_FormInput_orderId_In_ShopCartForm_1"/>
		<input type="hidden" name="catalogId" value="<c:out value="${WCParam.catalogId}" />"  id="WC_OrderItemDisplay_FormInput_catalogId_In_ShopCartForm_1"/>
		<input type="hidden" name="page" value="" id="WC_OrderItemDisplay_FormInput_page_In_ShopCartForm_1"/>
		<input type="hidden" name="errorViewName" value="InvalidInputErrorView" id="WC_OrderItemDisplay_FormInput_errorViewName_In_ShopCartForm_1"/>
		<input type="hidden" name="allocate" value="*n" />
		<input type="hidden" name="reverse" value="*n" />
		<input type="hidden" name="backorder" value="*n" />

		<table cellpadding="0" cellspacing="0" width="100%" border="0" id="WC_OrderItemDisplay_Table_1">
		<tbody>

		<%--
			***
			* Begin: display the bread crumb trail for the checkout process
			***
		--%>
		<tr>
			<td id="WC_OrderItemDisplay_TableCell_1">
				<c:set var="bctCurrentPage" value="ShoppingCart" />
				<%@ include file="../../Snippets/Order/Cart/BreadCrumbTrailDisplay.jspf" %>
			</td>
		</tr>
		<%--
			***
			* End: display the bread crumb trail section
			***
		--%>
		<tr>
			<%--
				***
				* Prepare Shopcart form when order is submitted for checkout
				***
			--%>
			<td id="WC_OrderItemDisplay_TableCell_2">

				<table width="100%" id="WC_OrderItemDisplay_Table_2">
					<tr>
						<td id="WC_OrderItemDisplay_TableCell_3">
							<h1><fmt:message key="SHOPPING_CART3" bundle="${storeText}"/></h1>
						</td>
					</tr>
					<tr>
						<td class="t_td2" id="WC_OrderItemDisplay_TableCell_4">
							<%-- 
							  ***
							  *	Start: Error handling
							  * Show an appropriate error message when there is an error
							  ***
							--%>

							<%-- Declare a string to hold Order Item Id's that have problems in the shopping cart --%>
							<c:set var="problemIds" value=""/>
							
							<%-- Loop through the error keys search for a string of orderItemId's with errors --%>
							<c:forEach var="returnKey" items="${bnError.exceptionData}">
								<c:if test="${returnKey.key eq 'orderItemId'}">
									<c:set var="problemIds" value="${returnKey.value}"/>
								</c:if>
							</c:forEach>
							
							<c:if test="${!empty errorMessage}">
								<p>
									<span class="error">
										<c:out value="${errorMessage}"/>
									</span>
									<br/><br/>
								</p>
							</c:if>
							<%-- 
							  ***
							  *	End: Error handling
							  ***
							--%>
							<fmt:message key="CART_CONTAINS" bundle="${storeText}"/>
						</td>
					</tr>

					<tr>
						<td id="WC_OrderItemDisplay_TableCell_5">
							<%@ include file="../../Snippets/Order/Cart/CurrentOrderDisplay.jspf" %>
						</td>
					</tr>


					<tr>
				        <td valign="top" id="WC_OrderItemDisplay_TableCell_6">
						<fmt:message key="ShopCart_Text" bundle="${storeDynamicText}" />
				        </td>
					</tr>
				</table>
			<%--
				***
				* End of form prepare for shopcart submission
				***
			--%>
		</td>
	</tr>		
	<tr>
		<td id="WC_OrderItemDisplay_TableCell_7">
		    <%-- Show choice of complete or partial shipments --%>
			<%@ include file="../../Snippets/Order/Ship/ShipAsCompleteChoice.jspf" %>
		</td>
	</tr>

	<%-- Show choice of single address, multiple address, or quick checkout --%>
	<c:set var="singleAddressInputType" value="radio"/>
	<flow:ifDisabled feature="MultipleShippingAddressPage.i1.impl.f">
		<flow:ifDisabled feature="quickCheckout">
			<c:set var="singleAddressInputType" value="hidden"/>
		</flow:ifDisabled>
	</flow:ifDisabled>
	
	<c:url var="SingleShippingAddressURL" value="OrderCopy">
		<c:param name="URL" value="SingleShippingAddressView"/>
		<c:param name="storeId" value="${WCParam.storeId}" />
		<c:param name="catalogId" value="${WCParam.catalogId}" />
		<c:param name="orderId" value="${WCParam.orderId}" />
		<c:param name="toOrderId" value="${WCParam.orderId}" />
	</c:url>
	<c:choose>
		<c:when test="${singleAddressInputType eq 'radio'}">
			<tr>
				<td id="WC_OrderItemDisplay_TableCell_8" ><h2><fmt:message key="CHOOSE_SHIPPING_ADDRESS" bundle="${storeText}" /></h2></td>
			</tr>		
			
			<%--single address --%>
			<tr>
				<td valign="top" id="WC_OrderItemDisplay_TableCell_9">
					<label for= "Order_ChooseShippingAddress_Single">
						<input name="URL" class="radio" onclick="javascript:updateShipModeField(false)" id="Order_ChooseShippingAddress_Single" checked="checked" type="<c:out value="${singleAddressInputType}"/>" value="OrderCalculate?updatePrices=1&calculationUsageId=-1&orderItemId*=&quantity*=&shipModeId*=&URL=<c:out value="${SingleShippingAddressURL}"/>" />
					</label>
					<fmt:message key="SHIP_TO_SINGLE_ADDRESS" bundle="${storeText}" />
				</td>
			</tr>
		</c:when>
		<c:otherwise>
			<input name="URL" id="Order_ChooseShippingAddress_Single" type="<c:out value="${singleAddressInputType}"/>" value="OrderCalculate?updatePrices=1&calculationUsageId=-1&orderItemId*=&quantity*=&shipModeId*=&URL=<c:out value="${SingleShippingAddressURL}"/>" />
		</c:otherwise>
	</c:choose>
	
	<flow:ifEnabled feature="MultipleShippingAddressPage.i1.impl.f">
		<%--multiple address' --%>
		<c:url var="MultipleShippingAddressURL" value="OrderCopy">
			<c:param name="URL" value="MultipleShippingAddressView"/>
			<c:param name="storeId" value="${WCParam.storeId}" />
			<c:param name="catalogId" value="${WCParam.catalogId}" />
			<c:param name="orderId" value="${WCParam.orderId}" />
			<c:param name="toOrderId" value="${WCParam.orderId}" />
			<c:param name="multipleShippingAddress" value="true" />
		</c:url>
	
		<tr>
			<td valign="top" id="WC_OrderItemDisplay_TableCell_10">
				<label for="Order_ChooseShippingAddress_Multiple">
					<input class="radio" name="URL" onclick="javascript:updateShipModeField(false)" id="Order_ChooseShippingAddress_Multiple" type="radio" value="OrderCalculate?updatePrices=1&calculationUsageId=-1&orderItemId*=&quantity*=&shipModeId*=&URL=<c:out value="${MultipleShippingAddressURL}"/>"/>
				</label>
				<fmt:message key="SHIP_TO_MULTIPLE_ADDRESSES" bundle="${storeText}" />
			</td>
		</tr>
	</flow:ifEnabled>

	<flow:ifEnabled feature="quickCheckout">
		<%-- If enabled, show quick checkout choice --%>
		<c:url var="QuickCheckoutView" value="OrderCopy">
			<c:param name="URL" value="OrderPrepare?URL=QuickCheckoutSummaryView"/>
			<c:param name="orderId" value="${WCParam.orderId}"/>
			<c:param name="toOrderId" value="${WCParam.orderId}"/>
			<c:param name="shippingAddressFromOrderProfile" value="1"/>
			<c:param name="orderInfoFrom" value="q"/>
			<c:param name="payInfoFrom" value="q"/>
			<c:param name="langId" value="${langId}" />
			<c:param name="storeId" value="${WCParam.storeId}" />
			<c:param name="catalogId" value="${WCParam.catalogId}" />
			<c:param name="status" value="P" />	
			<c:param name="orderItemId*" value="" />
			<c:param name="quantity*" value="" />
			<c:param name="allocate" value="*" />
			<c:param name="reverse" value="*n" />
			<c:param name="backorder" value="*" />
			<c:param name="remerge" value="*" />
			<c:param name="merge" value="*n" />
			<c:param name="check" value="*n" />
			<c:param name="errorViewName" value="OrderCopyErrorView" /> 												
		</c:url>	
	
		<tr>
			<td valign="top" id="WC_OrderItemDisplay_TableCell_11">
	               <label for="Order_ChooseShippingAddress_QuickCheckout">
		                 <input class="radio" name="URL" onclick="javascript:updateShipModeField(true)" id="Order_ChooseShippingAddress_QuickCheckout" type="radio" value="<c:out value="${QuickCheckoutView}"/>"/>
	               </label>
			<fmt:message key="QUICKCHECKOUT1" bundle="${storeText}" />
			</td>
		</tr>
	</flow:ifEnabled>
	
	<%-- Display the 'Checkout' button --%>
	<tr>
		<td id="WC_OrderItemDisplay_TableCell_12">&nbsp;</td>
	</tr>
	<tr>
		<td id="WC_OrderItemDisplay_TableCell_13">
			<%-- display the 'Checkout' button --%> 
			<a href="javascript:SubmitCart(document.ShopCartForm)" class="button" id="WC_OrderItemDisplay_Link_5">
				<fmt:message key="CHECKOUT1" bundle="${storeText}" />
			</a>
		</td>
	</tr>
	</form>
	<%-- 
	  ***
	  *	Start: GiftRegistryCode
	  *
	  ***
	--%>
	<%-- Display gift registry, if this is a gift item --%>
	<flow:ifEnabled feature="GiftRegistry">
	<c:if test='${!empty orderItem.externalGiftRegistryId}'>
	<c:url var="GiftRegistryUrl" value="GiftRegistryAuthenticate">
		<c:param name="storeId" value="${WCParam.storeId}" />
		<c:param name="catalogId" value="${WCParam.catalogId}" />
		<c:param name="externalId" value="${orderItem.externalGiftRegistryId}" />
	</c:url>
	<tr>
	<td></td>
	<td colspan="5">
	<input type="hidden" name="externalId_<c:out value='${counter.count}'/>" value="<c:out value='${orderItem.externalGiftRegistryId}' />"/>
	<img src="<c:out value='${jspStoreImgDir}images/gift_item.gif'/>" border="0" alt="<fmt:message key='GR_GIFT_ITEM' bundle='${storeText}' />" />
	<span class="text">
		<fmt:message key='GR_GIFT_ITEM_FOR_REG' bundle='${storeText}' /> <a href="<c:out value='${GiftRegistryUrl}'/>"><c:out value="${orderItem.giftRegistryDB.description}"/></a><br/>
	</span>
	</td>
	</tr>
	</c:if>
	</flow:ifEnabled>
	<%-- 
	  ***
	  *	End: GiftRegistryCode
	  ***
	--%>	

	<%-- 
	  ***WC_OrderItemDisplay_TableCell
	  * Begin: Promotion Code
	  ***
	--%>
	
<flow:ifEnabled feature="promotionCode">
<tr>
	<td class="c_line" id="WC_OrderItemDisplay_TableCell_14">
		&nbsp;
	</td>
</tr>
<tr>
	<td colspan="4" class="c_headings" id="WC_OrderItemDisplay_TableCell_15">
		<h2><fmt:message key="PROMOTION_CODE_TITLE" bundle="${storeText}"/></h2>
	</td>
</tr>
<%-- 
	***
	* Begin: Promotion Code Form
	***
--%>
<tr>
	<td colspan="4" id="WC_OrderItemDisplay_TableCell_16">
			<form name="PromotionCodeForm" method="post" action="PromotionCodeManage" id="PromotionCodeForm">
			<input type="hidden" name="storeId" value="<c:out value="${WCParam.storeId}"/>" id="WC_OrderSubmitForm_PromoCode_FormInput_storeId_In_ShopCartForm_1"/>
			<input type="hidden" name="langId" value="<c:out value="${langId}"/>" id="WC_OrderSubmitForm_PromoCode_FormInput_langId_In_ShopCartForm_1"/>
			<input type="hidden" name="orderId" value="<c:out value="${WCParam.orderId}"/>" id="WC_OrderSubmitForm_PromoCode_FormInput_orderId_In_ShopCartForm_1"/>
			<input type="hidden" name="catalogId" value="<c:out value="${WCParam.catalogId}"/>"  id="WC_OrderSubmitForm_PromoCode_FormInput_catalogId_In_ShopCartForm_1"/>
			<input type="hidden" name="taskType" value="A" id="WC_OrderSubmitForm_PromoCode_FormInput_page_In_ShopCartForm_1"/>
			<input type="hidden" name="URL" value="OrderCalculate?URL=OrderItemDisplay&orderId=<c:out value="${thisOrderId}" />&updatePrices=1&calculationUsageId=-1" id="WC_OrderSubmitForm_FormInput_URL_In_PromotionCodeForm_1"/>
			<input type="hidden" name="errorViewName" value="OrderItemDisplayViewShiptoAssoc" id="WC_OrderSubmitForm_FormInput_errorViewName_In_PromotionCodeForm_1" />
			<table id="WC_OrderItemDisplay_Table_3">
			<tr>
				<td id="WC_OrderItemDisplay_TableCell_17">
					<fmt:message key="PROMOTION_CODE" bundle="${storeText}"/>
				</td>
			</tr>
			<tr>
				<td id="WC_OrderItemDisplay_TableCell_18">
					<label for= "promoCode1">
					<input class="input" size="20" name="promoCode" id="promoCode1" value="" title="promoCode"/>
					</label>
					<a class="button" href="javascript:document.PromotionCodeForm.submit()" id="WC_OrderSubmitForm_PromoCode_Link_5"><fmt:message key="SUBMIT" bundle="${storeText}"/></a>
				</td>
			</tr>
			</table>
		</form>
	</td>
</tr>
<%-- 
	***
	* End: Promotion Code Form
	***
--%>
<%-- 
	***
	* Begin: List all the Promotion Codes applied
	***
--%>
<c:set var="headerPrinted" value="false" />  
<wcbase:useBean id="promoCodeListBean" classname="com.ibm.commerce.marketing.databeans.PromoCodeListDataBean" scope="page">
	<c:set property="orderId" value="${WCParam.orderId}" target="${promoCodeListBean}" />
</wcbase:useBean>  

<tr> 
	<td colspan="4" width="100%" id="WC_OrderItemDisplay_TableCell_19"> 
		<table id="WC_OrderItemDisplay_Table_4"> 
			<%-- list all the promotion code discounts entered--%>
				<c:forEach var="promotionCode" items="${promoCodeListBean.codes}" varStatus="status">	
					<c:if test="${!headerPrinted}">
						<tr>
							<td colspan="2" id="WC_OrderItemDisplay_TableCell_20">
								<span class="strongtext"><fmt:message key="PROMOTION_CODES_REDEEMED" bundle="${storeText}"/></span>
							</td>
						</tr>
						<c:set var="headerPrinted" value="true" />
					</c:if>
					<tr>
						<td id="WC_OrderItemDisplay_TableCell_21">
							<span class="discount"><c:out value="${promotionCode.description}"/></span>
						</td>
						<td class="buttoncell" id="WC_OrderItemDisplay_TableCell_22">
							<c:url var="PromotionCodeManageURL" value="PromotionCodeManage">
								<c:param name="langId" value="${WCParam.langId}" />
								<c:param name="storeId" value="${WCParam.storeId}" />
								<c:param name="catalogId" value="${WCParam.catalogId}" />
								<c:param name="taskType" value="R" />
								<c:param name="orderId" value="${WCParam.orderId}" />
								<c:param name="promoCode" value="${promotionCode.code}" />
								<c:param name="URL" value="OrderCalculate?URL=OrderItemDisplay&orderId=${thisOrderId}&updatePrices=1&calculationUsageId=-1" />
							</c:url>
							<a class="buttonstyle" href="<c:out value="${PromotionCodeManageURL}"/>" id="WC_OrderSubmitForm_PromoCode_Link_2"><fmt:message key="REMOVE_ITEM" bundle="${storeText}"/></a>
						</td>
					</tr>
				</c:forEach>
				<tr><td></td></tr>
		</table>
	</td>
</tr>
</flow:ifEnabled>
<%-- 
	***
	* End: Promotion Code
	***
--%>
	

	<%-- 
	***
	* Start: Manage Coupons Code
	***
	--%>
	<tr>
		<td class="c_line" id="WC_OrderItemDisplay_TableCell_14a">
			&nbsp;
		</td>
	</tr>
	<tr>
		<td valign="middle" class="categoryspace" id="WC_OrderItemDisplay_TableCell_25_1">
		<c:import url="../../Snippets/Marketing/Promotions/ManageCouponForm.jsp">
		  <c:param name="cpf_storeId" value="${WCParam.storeId}" />
		  <c:param name="cpf_langId" value="${WCParam.langId}" />
		  <c:param name="cpf_orderId" value="${WCParam.orderId}" />
		  <c:param name="cpf_catalogId" value="${WCParam.catalogId}" />
		  <c:param name="cpf_errorViewPage" value="OrderItemDisplayViewShiptoAssoc" />
		  <c:param name="cpf_userId" value="${CommandContext.userId}" />
		  <c:param name="cpf_successURL" value="OrderCalculate?URL=OrderItemDisplay&orderId=${WCParam.orderId}&updatePrices=1&calculationUsageId=-1" />
	  </c:import>
		</td>
	</tr>
	<%-- 
	***
	* End: Manage Coupons Code
	***
	--%>
	
	
	<%-- Include eMarketingSpot to display promotions and suggestions --%>
	<tr>
		<td class="c_line" id="WC_OrderItemDisplay_TableCell_14b">
			&nbsp;
		</td>
	</tr>
	<tr>
		<td valign="middle" class="categoryspace" id="WC_OrderItemDisplay_TableCell_25_2">
			<c:import url="../../include/eMarketingSpotDisplay.jsp">
				<c:param name="emsName" value="ShoppingCartPage" />
				<c:param name="maxNumDisp" value="8" />
				<c:param name="catalogId" value="${WCParam.catalogId}" />
				<c:param name="maxItemsInRow" value="4" />
				<c:param name="maxColInRow" value="3" />
			</c:import>
		</td>
	</tr>

	</tbody>
	</table>
		
	<!-- MAIN CONTENT ENDS HERE -->

	<%-- Hide CIP --%>
	<c:set var="HideCIP" value="true"/>

	<%@ include file="../../include/LayoutContainerBottom.jspf"%>

	</body>
	</c:otherwise>
</c:choose>
</html>

<!-- End - JSP File Name:  OrderItemDisplay.jsp -->
