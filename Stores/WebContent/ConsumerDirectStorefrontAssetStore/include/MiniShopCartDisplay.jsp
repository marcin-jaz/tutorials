<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2000, 2009 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>

  <%-- 
  *****
  * This file is used to display the Mini shopping cart in the sidebar of each page. 
  * The Mini shopping cart will display  
  *	- current number of items that are currently in the shopping cart 
  * 	- current subtotal of the items in the shopping cart
  *****
--%>

<!-- Start - JSP File Name: MiniShopCartDisplay.jsp -->

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="JSTLEnvironmentSetup.jspf" %>


	<%--
	***
	* Start: UserOrderList
	* This code block retrieves the list of orders that belongs to the current user, in Pending state and is from the 
	* current store. 
	***
	--%>
	

	<%--Get the order list that belongs to this user--%>
	<c:if test="${!empty CommandContext.userId}">
		<wcbase:useBean id="statusPordersList" classname="com.ibm.commerce.order.beans.OrderListDataBean" scope="request">
			<%-- Return orders from this particular user--%>
			<c:set value="${CommandContext.userId}" target="${statusPordersList}" property="userId" />
			<%-- only retrieve orders that are in Pending state --%>
			<c:set value="P" target="${statusPordersList}" property="retrievalOrderStatus" />
			<%--return orders only from this store --%>
			<c:set value="${WCParam.storeId}" target="${statusPordersList}" property="storeId" />
		</wcbase:useBean>

		<wcbase:useBean id="cpendOrdersList" classname="com.ibm.commerce.order.beans.OrderListDataBean" scope="request">
			<%-- Return orders from this particular user--%>
			<c:set value="${CommandContext.userId}" target="${cpendOrdersList}" property="userId" />
			<%-- only retrieve orders that are in CPEND order table. 
			Orders placed in store front will be added to this table, by calling setPendingOrdercommand --%>
			<c:set value="true" target="${cpendOrdersList}" property="fetchCurrentPendingOrder"/> 
			<%--return orders only from this store --%>
			<c:set value="${WCParam.storeId}" target="${cpendOrdersList}" property="storeId" />
		</wcbase:useBean>

		<%-- Now we have one orders list with status 'P' and and another orders list present in CPENDORDER table.
		Get the order which is present in both the list..--%>
		<%-- Loop through orders in cpendorder table and see if it has status == 'P' --%>
		<c:forEach var="order" items="${cpendOrdersList.orderDataBeans}">
			<c:forEach var="pOrder" items="${statusPordersList.orderDataBeans}">
				<c:if test="${order.orderId == pOrder.orderId}">
					<c:set var="currentOrderDataBean" value="${order}"/>
				</c:if>
			</c:forEach>
		</c:forEach>

		<%-- If the currentOrderDataBean is empty then it means we dont have any orders which has an entry in CPENDORDER table
		and status P (means shopper has not created any order in store front).
		But there might be some order created in accelerator for this shopper and shopping cart page displays this order when user clicks
		on shopping cart link. So to keep mini shop cart in sink with shopping cart page, use the order created in accelerator, if any --%>
		<c:if test = "${empty currentOrderDataBean}">
			<c:forEach var="pOrder" items="${statusPordersList.orderDataBeans}" begin = "0" end = "0">
				<c:set var="currentOrderDataBean" value="${pOrder}"/>
			</c:forEach>
		</c:if>

	<c:set var="totalNumberOfItems" value="0"/>
	<fmt:formatNumber var="formattedDiscountAdjustedProductTotal" value="0" type="currency" currencyCode="${CommandContext.currency}"/>

	<%--Get the order details that belongs to this user --%>
	<c:if test="${!empty currentOrderDataBean}">
		<c:set var="formattedDiscountAdjustedProductTotal" value="${currentOrderDataBean.formattedDiscountAdjustedProductTotal}"/>
		<c:forEach var="orderItem" items="${currentOrderDataBean.orderItemDataBeans}">
			<c:set var="totalNumberOfItems" value="${totalNumberOfItems + orderItem.quantityInIntValue}"/>
		</c:forEach>
	</c:if>		

	<%--
	***
	* End: UserOrderList
	***
	--%>

	<%--
	***
	* Start: Display MiniShopCart 
	***
	--%>
	<c:url var="OrderCalculateURL" value="OrderCalculate">
	  <c:param name="URL" value="OrderItemDisplay" />
	  <c:param name="storeId" value="${WCParam.storeId}" />
	  <c:param name="catalogId" value="${WCParam.catalogId}" />
	  <c:param name="calculationUsageId" value="-1" />
	  <c:param name="orderId" value="." />
	  <c:param name="errorViewName" value="ProductDisplayErrorView" />
	</c:url>
		<table id="WC_MiniShopCartDisplay_Table_1" cellpadding="0" cellspacing="0" border="0">
			<tbody>
				<tr>
					<%-- Display the MiniShopCart image --%>
					<td align="right" class="s_text" id="WC_MiniShopCartDisplay_TableCell_3_1">
						<a href="<c:out value="${OrderCalculateURL}"/>" class="s_link" id="WC_MiniShopCartDisplay_Link_2_1">
							<img src="<c:out value="${jspStoreImgDir}${vfileColor}cart.gif"/>" border="0" alt="<fmt:message key="MINI_CART" bundle="${storeText}" />" />
						</a>
					</td>
					<td align="left" valign="middle" class="s_text" id="WC_MiniShopCartDisplay_TableCell_3_2">
						<a href="<c:out value="${OrderCalculateURL}"/>" class="s_link" id="WC_MiniShopCartDisplay_Link_2_2">
							<%-- Display current number of items in the shopping cart --%>
							<fmt:message key="NumItemsInCart" bundle="${storeText}">
								<fmt:param><fmt:formatNumber value="${totalNumberOfItems}"/></fmt:param>
							</fmt:message>
							<%-- Display current subtotal amount of the shopping cart --%>
							<fmt:message key="Subtotal" bundle="${storeText}" />
							<c:out value="${formattedDiscountAdjustedProductTotal}" escapeXml="false"/>
						</a>
					</td>
				</tr>
			</tbody>
		</table>
	<%--
	***
	* End: Display MiniShopCart
	***
	--%>
	</c:if>		
