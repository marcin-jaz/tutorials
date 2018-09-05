<%--
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
--%>
<%-- 
  *****
  * This page shows items added to the shopping cart.  The following information is shown:
  *  - A table showing items in the shopping cart
  *  - A Remove button to let user remove an item from the shopping cart
  *  - List of available contracts
  *  - List of available payment methods
  *  - A New Requisition List button to let user create a requisition list based on this order
  *****
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../include/JSTLEnvironmentSetup.jspf" %>
<%@ include file="../../include/ErrorMessageSetup.jspf"%>

<c:set var="liveHelpShoppingCartItems" value="0" />

<%-- BEGIN CurrentOrderSetup.jsp --%>
<c:set var="thisOrderId" value="${WCParam.orderId}" />

<%-- Determine if multiple active orders is enabled --%>
<c:set var="multipleActiveOrders" value="false"/>
<flow:ifEnabled feature="MultipleActiveOrders">
	<c:set var="multipleActiveOrders" value="true"/>
</flow:ifEnabled>

<c:set var="pageSize" value="${maxOrderItemsPerPage}"/>
<c:if test="${empty pageSize}">
	<c:set var="pageSize" value="20"/>
</c:if>
<c:set var="currentPage" value="${WCParam.currentPage}"/>
<c:if test="${empty currentPage}">
	<c:set var="currentPage" value="1"/>
</c:if>
<wcbase:useBean id="orderListBean" classname="com.ibm.commerce.order.beans.OrderListDataBean" scope="request" >	
	<c:set target="${orderListBean}" property="storeId" value="${CommandContext.storeId}"/>		
	<c:set target="${orderListBean}" property="orderStatus" value="P"/>	
	
	<c:set target="${orderListBean}" property="userId" value="${userId}"/>
</wcbase:useBean>


<c:set var="orders" value="${orderListBean.orderDataBeans}" />

<%-- get the current pending order --%>
<wcbase:useBean id="orderListCurrentPendingOrderBean" classname="com.ibm.commerce.order.beans.OrderListDataBean">
	<c:set target="${orderListCurrentPendingOrderBean}" property="storeId" value="${storeId}"/>
	<c:set target="${orderListCurrentPendingOrderBean}" property="userId" value="${userId}"/>
	<c:set target="${orderListCurrentPendingOrderBean}" property="fetchCurrentPendingOrder" value="true"/>
</wcbase:useBean>
<c:forEach items="${orderListCurrentPendingOrderBean.orderDataBeans}" var="currentPendingOrder">
	<c:set var="currentPendingOrderStatus" value="${currentPendingOrder.status}"/>
	<c:if test="${currentPendingOrderStatus != 'X'}" >
		<c:set var="currentPendingOrderId" value="${currentPendingOrder.orderId}"/>		
	</c:if>                                                                                                            	   	 	                 				
</c:forEach> 

<c:if test="${thisOrderId eq '.' && currentPendingOrderId != null}" >
	<c:set var="thisOrderId" value="${currentPendingOrderId}"  />
</c:if>


<%-- Determine if this order is the current order --%>
<c:set var="isCurrentOrder" value="false"   />
<c:if test="${(thisOrderId eq currentPendingOrderId) or thisOrderId eq '.'}" >
	<c:set var="isCurrentOrder" value="true"   />
</c:if>

<%-- Find the first non-current pending order --%> 
<c:set var="firstNonCurrentOrderSet" value="false"/>  
<c:set var="counter" value="0"/>                            
<c:forEach items="${orderListBean.orderDataBeans}" var="ordr" >
	<c:set var="orderRn" value="${ordr.orderId}"/>
	<c:if test="${ordr.status != 'X'}" >
		<c:set var="counter" value="${counter+1}"/>
	</c:if>
    <c:if test="${orderRn != currentPendingOrderId && !firstNonCurrentOrderSet }" >
         <c:set var="firstNonCurrentOrder" value="${orderRn}"  />
         <c:set var="firstNonCurrentOrderSet" value="true"  />                                                                                                      	
    </c:if>
</c:forEach>

<c:set var="numberOfOrders" value="${counter}"  /> 

<%-- Check if this order has order items --%>
<c:set var="thisOrderHasItems" value="false"  />
<c:forEach items="${orders}" var="order">    					
	<c:set var="orderRn" value="${order.orderId}"/>	
	<c:if test="${orderRn eq thisOrderId or thisOrderId eq '.'}" >
		<c:if test="${!empty order.orderItemDataBeans}" > 
			<c:set var="thisOrderHasItems" value="true"  />
			<c:set var="currentOrderBean" value="${order}"  />
    	</c:if>
    </c:if>
</c:forEach>
<c:if test="${thisOrderHasItems}">
	<wcbase:useBean id="orderBean" classname="com.ibm.commerce.order.beans.OrderDataBean" scope="page">
	<c:set target="${orderBean}" property="orderId" value="${currentOrderBean.orderId}"/>
	<c:set target="${orderBean}" property="pageSize" value="${pageSize}"/>
	<c:set target="${orderBean}" property="currentPage" value="${currentPage}"/>
	</wcbase:useBean>

	<%-- get pageSize from OrderDataBean again - if passed in page size is greater than max value, pageSize will set to max value --%>
	<c:set var="pageSize" value="${orderBean.pageSize}"/>
</c:if>

<%-- URL links --%>
<c:url var="ListOrdersDisplayURL" value="ListOrdersDisplay" >
		<c:param name="langId" value="${langId}" />
		<c:param name="storeId" value="${storeId}" />
		<c:param name="catalogId" value="${catalogId}" />									
</c:url>       
 
<%-- use variable "hasOrderItemDiscount" to track whether the order contains order item level discounts --%>
<c:set var="hasOrderItemDiscount" value="false"  />

<%-- Page heading --%>
<c:choose>       
<c:when test="${multipleActiveOrders}" >

<c:choose>
	<c:when test="${isCurrentOrder or numberOfOrders eq '1'}" >
	<fmt:message key="YourOrder_CurrentOrder" bundle="${storeText}" var="cOrder" />
	<c:set var="pageHeading" value="${cOrder}"  />	
	</c:when>
    <c:otherwise>
    <fmt:message key="YourOrder_PendingOrder" bundle="${storeText}" var="pOrder" />
    <c:set var="pageHeading" value="${pOrder}"  />    		
    </c:otherwise>
</c:choose>
	<c:if test="${numberOfOrders > 1}" >
		<fmt:message key="YourOrder_CountOrders" bundle="${storeText}" var="cOrders" >
			<fmt:param value="${numberOfOrders-1}"/>
		</fmt:message> 
		<fmt:message key="YourOrder_ListOrdersLink" bundle="${storeText}" var="lOrders" />
		<c:set var="countOrdersHeading" value="${cOrders}"  />	
		<c:set var="listOrdersLink" value="${lOrders}"  />	
	</c:if>		 
</c:when>
<c:otherwise>
	<fmt:message key="YourOrder_CurrentOrder" bundle="${storeText}" var="cOrder" />
	<c:set var="pageHeading" value="${cOrder}"  />
</c:otherwise>
</c:choose>	
<%-- END CurrentOrderSetup.jsp --%>

<%-- 
	check to see if this order has any order items; if not show 
	EmptyOrderDisplay page if so, display order and order item information.	
--%>

<c:choose>       
<c:when test="${thisOrderHasItems eq 'false' }">
     <c:set var="EmptyOrderFile" value="${jspStoreDir}ShoppingArea/CurrentOrderSection/EmptyOrderDisplay.jsp"/>
     <% out.flush(); %>
     <c:import url="${EmptyOrderFile}"/>
     <% out.flush(); %>

</c:when>           
<c:otherwise>   
	<c:set var="orderRn" value="${currentOrderBean.orderId}"/>
	<c:set var="thisOrderId" value="${currentOrderBean.orderId}"/>

	<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
	<html xmlns="http://www.w3.org/1999/xhtml">
	<!-- BEGIN CurrentOrderDisplay.jsp -->
	<head>
	<title><fmt:message bundle="${storeText}" key="YourOrder_Title" /></title>
	<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${vfileStylesheet}"/>" type="text/css"/>
	
	<script language="JavaScript" type="text/JavaScript">
	
	function MM_findObj(n, d) { //v4.01
		var p,i,x;  
		if(!d) d=document;
		if((p=n.indexOf("?"))>0&&parent.frames.length) {
		   d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);
		}
		if(!(x=d[n])&&d.all) x=d.all[n]; 
		for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
		for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
		if(!x && d.getElementById) x=d.getElementById(n);
		return x;
	}
	
	function MM_showHideLayers() { //v6.0
		var i,p,v,obj,args=MM_showHideLayers.arguments;
		for (i=0; i<(args.length-2); i+=3) if ((obj=MM_findObj(args[i]))!=null) {
			v=args[i+2];
			if (obj.style) { 
				obj=obj.style;
				if(v=='show'){
					obj.visibility='visible';
					obj.display='block';
				}
				if(v=='hide'){
					obj.visibility='hidden';
					obj.display='none';
				} 
			}
		}
	}

	function MM_showHideLayer() { //v6.0
		var i,p,v,obj,args=MM_showHideLayer.arguments;
		i=0;
		if ((obj=MM_findObj(args[i]))!=null) {
			if ((v=MM_findObj(args[i+2]))!=null) {
				if (obj.style) { 
					obj=obj.style;
					if(v.checked){
						obj.visibility='visible';
						obj.display='block';
					}
					else{
						obj.visibility='hidden';
						obj.display='none';
					} 
				}
			}
		}
	}

	function Add2RFQ(form, orderRn) {
		if (form.Type[0].checked) {
			form.action="RFQCreateDisplay?langId=<c:out value="${langId}"/>&catalogId=<c:out value="${catalogId}"/>&storeId=<c:out value="${storeId}"/>&orderId="+ orderRn;
		} else {
			form.action="AddToExistRFQListDisplay?langId=<c:out value="${langId}"/>&catalogId=<c:out value="${catalogId}"/>&storeId=<c:out value="${storeId}"/>&orderId=" + orderRn;
		}
		form.submit();              
	}

	function checkContractId(object) {              
		var contraceId;                     
		for (var i = 0;i < object.length;i++){
			if (object.options[i].selected == true) 
			return(object.options[i].value);
		}
		return "0";
	}
       
   <%--
   /* 
    * By default, all input parameters to the controller command are propagated to the redirect view command.
    *  If there is a limit on the number of characters in the redirect URL, this may cause a problem.
    *  To handle a limited length redirect URL, the javascript below invokes the command using special parameters to indicate 
    *  that certain input parameters should be removed. For example, you can specify the following as the URL parameter: 
    *  orderItemId*=&quantity*=
    *  This specification means that all parameters whose names start with orderItemId and quantity should be removed.
    */
   --%>
	

	function UpdateTotal(form, url, pageNumber){   
		var shipAsComplete = 'Y';
	<flow:ifEnabled feature="MultipleReleases">
		if (form.ShipAsComplete[1].checked) shipAsComplete ='N';    
	</flow:ifEnabled>
		if (url == undefined) {
			form.URL.value = 'OrderCopy?<c:out value="storeId=${storeId}&langId=${langId}&catalogId=${catalogId}&toOrderId=${orderRn}" escapeXml="false"/>&shipAsComplete=' + shipAsComplete + '&requestedShipDate*=&isExpedited*=&orderItemId*=&quantity*=&contractId*=&shipModeId*=&addressId*=&pa*=&URL=OrderCalculate?URL=OrderItemDisplay?<c:out value="storeId=${storeId}&langId=${langId}&catalogId=${catalogId}&orderId=${thisOrderId}" escapeXml="false"/>&updatePrices=1&calculationUsageId=-1';
		} else {
			if (pageNumber == undefined) {
				form.URL.value = url + '&orderItemId*=&quantity*=&contractId*=&shipModeId*=&addressId*=&pa*=';
			} else {
				form.URL.value = url + '&orderItemId*=&quantity*=&contractId*=&shipModeId*=&addressId*=&pa*=&currentPage=' + pageNumber;
			}
		}
		<flow:ifEnabled feature="ShippingInstructions">
			if (form.shipInstructions != null && form.shipInstructions.value == "") {
				form.shipInstructions.name="tempShipInstructions";
			}
		</flow:ifEnabled>
		form.submit();              
	}

	function submitForm(form, url){
		if(form.currentPage!= undefined){
			var pageNumber = parseInt(form.currentPage.value);
			if ( pageNumber !="NaN" && pageNumber >=1 && pageNumber > <c:out value="${orderBean.totalPages}" /> )
				form.currentPage.value = 1;
		}
		var shipAsComplete = 'Y';
	<flow:ifEnabled feature="MultipleReleases">
		if (form.ShipAsComplete[1].checked) shipAsComplete ='N';
	</flow:ifEnabled>
		var qtyFlag = 0;
		for (var i=0; i<document.ShopCartForm.length; i++) {	
			var elem = document.ShopCartForm.elements[i];
				if(elem.name.length >= 10 && elem.name.substring(0,8) =='quantity' && elem.value > 0)
				{
					qtyFlag = 1;
					break;
				}
		}
		if(qtyFlag == 1)
		{
			if (url == undefined) {
				if (form.ShippingURL[0].checked) {
					form.URL.value = 'OrderCopy?<c:out value="storeId=${storeId}&langId=${langId}&catalogId=${catalogId}&toOrderId=${orderRn}" escapeXml="false"/>&shipAsComplete=' + shipAsComplete + '&orderItemId*=&quantity*=&contractId*=&shipModeId*=&addressId*=&requestedShipDate*=&isExpedited*=&pa*=&URL=' + form.ShippingURL[0].value;
				} else {
					form.URL.value = 'OrderCopy?<c:out value="storeId=${storeId}&langId=${langId}&catalogId=${catalogId}&toOrderId=${orderRn}" escapeXml="false"/>&shipAsComplete=' + shipAsComplete + '&orderItemId*=&quantity*=&contractId*=&shipModeId*=&addressId*=&requestedShipDate*=&isExpedited*=&pa*=&URL=' + form.ShippingURL[1].value;
				}
			} else {
				form.URL.value = 'OrderCopy?<c:out value="storeId=${storeId}&langId=${langId}&catalogId=${catalogId}&toOrderId=${orderRn}" escapeXml="false"/>&shipAsComplete=' + shipAsComplete + '&orderItemId*=&quantity*=&contractId*=&shipModeId*=&addressId*=&requestedShipDate*=&isExpedited*=&pa*=&URL=' + url;
			}
		}
		else
		{
			form.URL.value = 'OrderCopy?<c:out value="storeId=${storeId}&langId=${langId}&catalogId=${catalogId}&toOrderId=${orderRn}" escapeXml="false"/>&shipAsComplete=' + shipAsComplete + '&requestedShipDate*=&isExpedited*=&orderItemId*=&quantity*=&contractId*=&shipModeId*=&addressId*=&pa*=&URL=OrderCalculate?URL=OrderItemDisplay?<c:out value="storeId=${storeId}&langId=${langId}&catalogId=${catalogId}&orderId=${thisOrderId}" escapeXml="false"/>&updatePrices=1&calculationUsageId=-1';
		}
		<flow:ifEnabled feature="ShippingInstructions">
			if (form.shipInstructions != null && form.shipInstructions.value == "") {
				form.shipInstructions.name="tempShipInstructions";
			}
		</flow:ifEnabled>
		form.submit();
	}

	function confirmRemove(){
		var agree=confirm("<fmt:message key="YourOrder_OrderDeleteConfirm" bundle="${storeText}"/>");
		if (agree) return true;
		else return false;
	}
	
	</script>
	
	<flow:ifEnabled feature="customerCare"> 
	<script language="javascript">
	      if (typeof parent.setShoppingCartItems == 'function')
	      parent.setShoppingCartItems(<c:out value="${liveHelpShoppingCartItems}"/>);              
	</script>
	</flow:ifEnabled> 
	
	</head>
	<body class="noMargin"> 
	<%@ include file="../../include/LayoutContainerTop.jspf"%>
	
	<table cellpadding="0" cellspacing="0" border="0" class="p_width" id="WC_CurrentOrderDisplay_Table_10">
		<tr>
			<td id="WC_CurrentOrderDisplay_TableCell_10">
	
	<%-- bread crumb trail snippet --%>
	<c:set var="bctCurrentPage" value="ShoppingCart" />
	<c:set var="storeText" value="${storeText}" />
	<%@ include file="../../Snippets/Order/Cart/BreadCrumbTrailDisplay.jspf"%>

    <%-- Page heading information --%>
    <h1><c:out value="${pageHeading}" /></h1>
    
    <%-- Link to List Orders page --%>  
    <c:if test="${multipleActiveOrders}" >                             				
	<c:out value="${countOrdersHeading}" />
	<a href="<c:out value="${ListOrdersDisplayURL}" />"  id="WC_MiniEmptyOrderDisplay_Link_1">
		<c:out value="${listOrdersLink}" />
        </a>
    </c:if>
    <%-- End Link to List Orders page --%>                
    
    <c:choose>
    <c:when test="${'_ERR_RETRIEVE_PRICE.1002' eq storeError.key}">
    	<fmt:bundle basename="${jspStoreDir}storeErrorMessages">
            <fmt:message key="${storeError.key}" var="pageErrorMessage">       
                 <fmt:param value="${storeError.messageParameters[4]}"/>
            </fmt:message>
        </fmt:bundle>
    </c:when>
    <c:otherwise>
          <c:set var="pageErrorMessage" value="${errorMessage}"/>
    </c:otherwise>
    </c:choose>
    <c:if test="${!empty pageErrorMessage}">
         <p><span class="error"><c:out value="${pageErrorMessage}"/></span><br />
         </p>
    </c:if>
    
	<form name="ShopCartForm" action="OrderItemUpdate" method="post" id="ShopCartForm">
	<input type="hidden" name="storeId" value="<c:out value="${storeId}"/>" id="WC_CurrentOrderDisplay_FormInput_check_In_ShopCartForm_1"/>
	<input type="hidden" name="catalogId" value="<c:out value="${catalogId}"/>" id="WC_CurrentOrderDisplay_FormInput_merge_In_ShopCartForm_1"/>
	<input type="hidden" name="langId" value="<c:out value="${langId}"/>" id="WC_CurrentOrderDisplay_FormInput_remerge_In_ShopCartForm_1"/>
	<input type="hidden" name="errorViewName" value="InvalidInputErrorView"/>
	<input type="hidden" name="check" value="*n" id="WC_CurrentOrderDisplay_FormInput_check_In_ShopCartForm_1"/>
	<input type="hidden" name="merge" value="*n" id="WC_CurrentOrderDisplay_FormInput_merge_In_ShopCartForm_1"/>
	<input type="hidden" name="remerge" value="*n" id="WC_CurrentOrderDisplay_FormInput_remerge_In_ShopCartForm_1"/>
	<input type="hidden" name="reverse" value="*n" id="WC_CurrentOrderDisplay_FormInput_reverse_In_ShopCartForm_1"/>
	<input type="hidden" name="allocate" value="*n" id="WC_CurrentOrderDisplay_FormInput_allocate_In_ShopCartForm_1"/>
	<input type="hidden" name="backorder" value="*n" id="WC_CurrentOrderDisplay_FormInput_backorder_In_ShopCartForm_1"/>
	<input type="hidden" name="orderId" value="<c:out value="${thisOrderId}" />" id="WC_CurrentOrderDisplay_FormInput_orderId_In_ShopCartForm_1"/>
	<input type="hidden" name="URL" value="" id="WC_CurrentOrderDisplay_FormInput_URL_In_ShopCartForm_1"/>
	<input type="hidden" name="addressId" value="" id="WC_CurrentOrderDisplay_FormInput_addressId_In_ShopCartForm_1"/>
	<input type="hidden" name="shipModeId" value="" id="WC_CurrentOrderDisplay_FormInput_shipModeId_In_ShopCartForm_1"/>				
	
	<c:import url="CurrentOrderDisplayCartSection.jsp">
		<c:param name="storeId" value="${storeId}"/>
		<c:param name="catalogId" value="${catalogId}"/>
		<c:param name="langId" value="${langId}"/>
		<c:param name="orderId" value="${orderRn}"/>
		<c:param name="multipleActiveOrders" value="${multipleActiveOrders}"/>
		<c:param name="firstNonCurrentOrder" value="${firstNonCurrentOrder}"/>
	</c:import>
	
	<h2><fmt:message key="YourOrder_ChooseOrderAction" bundle="${storeText}" /></h2>
	
	<table cellpadding="0" cellspacing="0" border="0" id="WC_CurrentOrderDisplay_Table_1">
		<flow:ifEnabled feature="RequisitionList">
		<tr>
			<td id="WC_CurrentOrderDisplay_TableCell_47">
				<input class="radio" type="radio" name="orderAction" onclick="MM_showHideLayers('ReqListLayer','','show','RFQLayer','','hide','CheckoutLayer','','hide','ExpressCheckoutLayer','','hide');" id="Order_orderActionChoice_1" value="ReqList"/>
				<label for="Order_orderActionChoice_1"><fmt:message key="YourOrder_RequisitionListChoice" bundle="${storeText}" /></label>
			</td>
		</tr>
		</flow:ifEnabled>
		<c:if test="${rfqLinkDisplayed}">
		<flow:ifEnabled feature="RFQ">
		<tr>
			<td id="WC_CurrentOrderDisplay_TableCell_48">
				<input class="radio" type="radio" name="orderAction" onclick="MM_showHideLayers('ReqListLayer','','hide','RFQLayer','','show','CheckoutLayer','','hide','ExpressCheckoutLayer','','hide');" id="Order_orderActionChoice_2" value="RFQ"/>
				<label for="Order_orderActionChoice_2"><fmt:message key="YourOrder_RFQChoice" bundle="${storeText}" /></label>
			</td>
		</tr>
		</flow:ifEnabled>
		</c:if>
		<tr>
			<td id="WC_CurrentOrderDisplay_TableCell_49">
				<input class="radio" type="radio" name="orderAction" onclick="MM_showHideLayers('ReqListLayer','','hide','RFQLayer','','hide','CheckoutLayer','','show','ExpressCheckoutLayer','','hide');" id="Order_orderActionChoice_3" value="Checkout" checked="checked"/>
				<label for="Order_orderActionChoice_3"><fmt:message key="YourOrder_CheckoutChoice" bundle="${storeText}" /></label>
			</td>
		</tr>
		<tr>
			<td id="WC_CurrentOrderDisplay_TableCell_49a">
				<input class="radio" type="radio" name="orderAction" onclick="MM_showHideLayers('ReqListLayer','','hide','RFQLayer','','hide','CheckoutLayer','','hide','ExpressCheckoutLayer','','show');" id="Order_orderActionChoice_4" value="ExpressCheckout"/>
				<label for="Order_orderActionChoice_4"><fmt:message key="YourOrder_ExpressCheckoutChoice" bundle="${storeText}" /></label>
			</td>
		</tr>
	</table>
	
	<div id="CheckoutLayer" style="visibility: visible; display: block;">
	<table cellpadding="0" cellspacing="0" border="0" id="WC_CurrentOrderDisplay_Table_2" width="100%">
	<flow:ifEnabled feature="MultipleReleases">
		<tr>
			<td id="WC_CurrentOrderDisplay_TableCell_50">
			    <%-- Show choice of complete or partial shipments --%>
				<%@ include file="../../Snippets/Order/Ship/ShipAsCompleteChoice.jspf" %>
			</td>
		</tr>
	</flow:ifEnabled>
		<tr>
			<td id="WC_CurrentOrderDisplay_TableCell_55">
				<h2><fmt:message key="YourOrder_ChooseAddressPreference" bundle="${storeText}" /></h2>
			</td>
		</tr>	
		<tr>
			<td valign="top" id="WC_CurrentOrderDisplay_TableCell_56">
				<!-- single shipping address -->							
				<input name="ShippingURL" id="Order_ShipAddressOption_1" class="radio" type="radio" value="SingleShippingAddressView" 
					<c:if test="${WCParam.ShippingURL ne 'MultipleShippingAddressView'}">
						checked="checked"
					</c:if>
				/>
				<label for="Order_ShipAddressOption_1"><fmt:message key="YourOrder_SingleAddressChoice" bundle="${storeText}"  /></label>
		</tr>
		<tr>
			<td valign="top" id="WC_CurrentOrderDisplay_TableCell_58">
			<!-- multiple shipping address -->
				<input name="ShippingURL" id="Order_ShipAddressOption_2" class="radio" type="radio" value="MultipleShippingAddressView"
					<c:if test="${WCParam.ShippingURL eq 'MultipleShippingAddressView'}">
						checked="checked"
					</c:if>
				/>
				<label for="Order_ShipAddressOption_2"><fmt:message key="YourOrder_MultipleAddressChoice" bundle="${storeText}"  /></label>
			</td>
		</tr>
	</table>
	<p>
		<a href="javascript:submitForm(document.ShopCartForm)" class="button" id="WC_CurrentOrderDisplay_Link_6">
			<fmt:message key="YourOrder_Submit" bundle="${storeText}"/>
		</a>
	</p>
    </div>

<flow:ifEnabled feature="ShippingInstructions">
	<c:set var="showInstructions" value="true"/>
</flow:ifEnabled>
<flow:ifEnabled feature="ExpeditedOrders">
	<c:set var="showExpedite" value="true"/>
</flow:ifEnabled>
<flow:ifEnabled feature="FutureOrders">
	<c:set var="showRequestedShipdate" value="true"/>
</flow:ifEnabled>

    <div id="ExpressCheckoutLayer" style="visibility: hidden; display: none;">
	<table cellpadding="0" cellspacing="0" border="0" id="WC_CurrentOrderDisplay_Table_2a" width="100%">
	<c:import url="CurrentOrderDisplayExpressSection.jsp">
		<c:param name="storeId" value="${storeId}"/>
		<c:param name="catalogId" value="${catalogId}"/>
		<c:param name="langId" value="${langId}"/>
		<c:param name="orderId" value="${thisOrderId}"/>
		<c:param name="showInstructions" value="${showInstructions}"/>
		<c:param name="showRequestedShipdate" value="${showRequestedShipdate}"/>
		<c:param name="showExpedite" value="${showExpedite}"/>
	</c:import>

	</table>
    </div>
    
    </form>
	
	<!-- begin Convert shopcart to Requisition List section -->
	<div id="ReqListLayer" style="visibility: hidden; display: none;">
	<flow:ifEnabled feature="RequisitionList">
	<table cellpadding="0" cellspacing="0" border="0" id="WC_CurrentOrderDisplay_Table_3" width="100%">
		<tr>
			<td id="WC_CurrentOrderDisplay_TableCell_60">
				<h2><fmt:message key="YourOrder_CreateReqList" bundle="${storeText}" /></h2>
			</td>
		</tr>
		<tr>
			<td valign="top" id="WC_CurrentOrderDisplay_TableCell_61">
				<fmt:message key="YourOrder_Message1" bundle="${storeText}"/>
				<form name="requisitionListForm" action="RequisitionListCopy" id="requisitionListForm" style="margin: 0px;padding: 0px;">
					<input type="hidden" name="URL" value="RequisitionListUpdateView?<c:out value='storeId=${storeId}&catalogId=${catalogId}'/>" id="WC_CurrentOrderDisplay_FormInput_URL_In_requisitionListForm_1"/>
					<input type="hidden" name="orderId" value="<c:out value="${orderRn}"/>" id="WC_CurrentOrderDisplay_FormInput_orderId_In_requisitionListForm_1"/>
					<label for="WC_CurrentOrderDisplay_FormInput_name_In_requisitionListForm_1"><fmt:message key="YourOrder_ReqListName" bundle="${storeText}"/></label>
					<input class="input" type="text" name="name" size="30" id="WC_CurrentOrderDisplay_FormInput_name_In_requisitionListForm_1"/>
				</form>
			</td>
		</tr>
	</table>
	<p>
		<a href="javascript:document.requisitionListForm.submit()" class="button" id="WC_CurrentOrderDisplay_Link_7">
			<fmt:message key="YourOrder_Button1" bundle="${storeText}"/>
		</a>
	</p>
    </flow:ifEnabled>
    </div>
    <!-- end Convert shopcart to Requisition List section -->
	
	<!-- begin Convert shopcart to RFQ section --> 
	<div id="RFQLayer" style="visibility: hidden; display: none;">             
	<c:if test="${rfqLinkDisplayed}">
	<flow:ifEnabled feature="RFQ">
	<table cellpadding="0" cellspacing="0" border="0" id="WC_CurrentOrderDisplay_Table_4" width="100%">
		<tr>
			<td valign="top" id="WC_CurrentOrderDisplay_TableCell_64">
				<form name="AddToRFQ" action="" method="post" id="AddToRFQForm" style="margin: 0px;padding: 0px;">
				<table cellpadding="0" cellspacing="0" border="0" id="WC_CurrentOrderDisplay_Table_5">
					<tbody>
						<tr>                   
							<td id="WC_CurrentOrderDisplay_TableCell_90">
						               	<h2><fmt:message key="YourOrder_ChooseRFQPreference" bundle="${storeText}"/></h2>
						        </td>
						</tr>
						<tr>
						        <td id="WC_CurrentOrderDisplay_TableCell_91">
								<input id="WC_CurrentOrderDisplay_FormInput_type_1" class="radio" type="radio" name="Type" value="NEW" checked="checked"/>
						           	<label for="WC_CurrentOrderDisplay_FormInput_type_1">
						           		<fmt:message key="YourOrder_NewRFQChoice" bundle="${storeText}"/>
						           	</label>
						        </td>
						</tr>
						<tr> 
							<td id="WC_CurrentOrderDisplay_TableCell_92">
						        	<input id="WC_CurrentOrderDisplay_FormInput_type_2" class="radio" type="radio"  name="Type" value="EXISTING"/> 
						            	<label for="WC_CurrentOrderDisplay_FormInput_type_2">
						            		<fmt:message key="YourOrder_ExistingRFQChoice" bundle="${storeText}"/>
						            	</label>
						        </td>
						</tr>
					</tbody>       
				</table>
				</form>
			</td>
		</tr>
	</table>
	<p>
		<a href="#" class="button" onclick="Add2RFQ(document.AddToRFQ, <c:out value="${thisOrderId}"/>);" id="WC_CurrentOrderDisplay_Link_8">
			 <fmt:message key="YourOrder_AddToRFQ" bundle="${storeText}"/>
		</a> 
	</p>
	</flow:ifEnabled>
	</c:if> 
	</div>
	<!-- end Convert shopcart to RFQ section -->

	<!-- begin Promotion section -->
	<%-- The PromoCodeListDataBean is used to list all the promotion codes entered for an order --%>
	<wcbase:useBean id="marketing_PromoCodeListBean" classname="com.ibm.commerce.marketing.databeans.PromoCodeListDataBean" >					 
		<c:set target="${marketing_PromoCodeListBean}" property="orderId" value="${currentOrderBean.orderId}"/> 	
	</wcbase:useBean>  
	<%-- The promotion code submit form --%>
	<table class="t_table" id="WC_CurrentOrderDisplay_Table_6">
		<tr>
			<td class="c_line" id="PaymentMethodsDisplay_TableCell_47">&nbsp;</td>
		</tr>
	</table>
	<h2><fmt:message key="YourOrder_PROMO_INFO" bundle="${storeText}" /></h2>
	
    <table cellpadding="0" cellspacing="0" border="0" id="WC_CurrentOrderDisplay_Table_7">
        <tr valign="top">
          <td id="WC_CurrentOrderDisplay_TableCell_94">
            	<label for="Marketing_PromotionCodeForm_FormInput_promoCode_In_PromotionCodeForm_1"><fmt:message key="YourOrder_Enter_code" bundle="${storeText}"/></label>
          </td>
        </tr>
        <tr valign="top">
          <td id="WC_CurrentOrderDisplay_TableCell_94a">
              	<form name="PromotionCodeForm" method="post" action="PromotionCodeManage" id="PromotionCodeForm">
			<input type="hidden" name="storeId" value="<c:out value="${storeId}" />" id="Marketing_PromotionCodeForm_FormInput_storeId_In_ShopCartForm_1"/>
			<input type="hidden" name="langId" value="<c:out value="${langId}" />" id="Marketing_PromotionCodeForm_FormInput_langId_In_ShopCartForm_1"/>
			<input type="hidden" name="orderId" value="<c:out value="${thisOrderId}" />" id="Marketing_PromotionCodeForm_FormInput_orderId_In_ShopCartForm_1"/>
			<input type="hidden" name="catalogId" value="<c:out value="${catalogId}" />"  id="Marketing_PromotionCodeForm_FormInput_catalogId_In_ShopCartForm_1"/>
			<input type="hidden" name="taskType" value="A" id="Marketing_PromotionCodeForm_FormInput_taskType_In_PromotionCodeForm_1"/>									
			<input class="input" size="20" name="promoCode" id="Marketing_PromotionCodeForm_FormInput_promoCode_In_PromotionCodeForm_1" value=""/>
			<input type="hidden" name="URL" value="OrderCalculate?URL=OrderItemDisplay&orderId=<c:out value="${thisOrderId}" />&updatePrices=1&calculationUsageId=-1" id="Marketing_PromotionCodeForm_FormInput_URL_In_PromotionCodeForm_1"/>
			<input type="hidden" name="errorViewName" value="OrderItemDisplayViewShiptoAssoc" id="Marketing_PromotionCodeForm_FormInput_errorViewName_In_PromotionCodeForm_1"/>
			
		</form>
	  </td>
	  <td id="WC_CurrentOrderDisplay_TableCell_94b">
		<a class="button" href="javascript:document.PromotionCodeForm.submit()" id="Marketing_PromotionCodeForm_Link_1"><fmt:message key="YourOrder_SUBMIT" bundle="${storeText}" /></a>
    	  </td>
    	</tr>
    	<%-- list all the promotion code discounts that have been entered--%>
     	<c:if test="${!empty marketing_PromoCodeListBean.codes}" > 
    	<tr valign="top">    	
			<td id="WC_CurrentOrderDisplay_TableCell_95">     							
				<c:forEach var="marketing_PromoCode" items="${marketing_PromoCodeListBean.codes}" varStatus="status">	
					<c:out value="${marketing_PromoCode.code}"/> -
					<c:out value="${marketing_PromoCode.description}"/>
					<c:url var="marketing_PromotionCodeManageURL" value="PromotionCodeManage">
						<c:param name="langId" value="${langId}" />
						<c:param name="storeId" value="${storeId}" />
						<c:param name="catalogId" value="${catalogId}" />
						<c:param name="taskType" value="R" />
						<c:param name="orderId" value="${thisOrderId}" />
						<c:param name="promoCode" value="${marketing_PromoCode.code}" />
						<c:param name="URL" value="OrderCalculate?URL=OrderItemDisplay&orderId=${thisOrderId}&updatePrices=1&calculationUsageId=-1" />
					</c:url>
					&nbsp;&nbsp;<a href="<c:out value="${marketing_PromotionCodeManageURL}"/>" class="button" id="Marketing_PromotionCodeForm_Link_2"><fmt:message key="YourOrder_REMOVE" bundle="${storeText}" /></a>
					<br/>
				</c:forEach>  
			</td>
		</tr>
		</c:if>
    </table>
	<!-- end Promotion section -->
	
	</td>
	</tr>
	</table>
	
	<%-- Hide CIP --%>
	<c:set var="HideCIP" value="true"/>
	
	<%@ include file="../../include/LayoutContainerBottom.jspf"%> 
	</body>
	<!-- END CurrentOrderDisplay.jsp -->
	</html>
	
</c:otherwise>
</c:choose>
