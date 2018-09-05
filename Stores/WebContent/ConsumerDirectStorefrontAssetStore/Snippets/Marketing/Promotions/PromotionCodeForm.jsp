<%
//********************************************************************
//*-------------------------------------------------------------------
//* Licensed Materials - Property of IBM
//*
//* WebSphere Commerce
//*
//* (c) Copyright IBM Corp. 2004
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
  *****
  * This JSP code snippet displays the following information:
  *  - the order list and the discounts applied 
  *  - the promotion code form that allows customers to enter a promotion code
  *  - the list of promotion codes entered (for each code, a 'Remove' button is provided to allow customers to remove the code) 
  * 
  * This snippet assumes that the promotion code form is in the shopping cart page.
  * If the promotion code form is not in the shopping cart page, you need to change the values for parameter 'URL' and 'errorViewName' accordingly.
  * More information is provided in the JSP comments below.
  *
  * Prerequisite:
  * Before you can enter a promotion code, you need to create a promotion (with promotion code) using the Accelerator.
  *
  * How to use this snippet? 
  * To use this snippet, you can cut and paste the code from the snippet to your shopping cart page.
  *    If your store page is based on the consumer direct starter store, the JSP page for the shopping cart is OrderItemDisplay.jsp.
  *
  *****
--%>

<!-- Start - JSP File Name:  PromotionCodeForm.jsp -->

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>

<%--
  ***
  * Activate the data bean at the beginning of the JSP file.
  * If you create a JSP file based on the following code snippet, copy the data bean
  * activation code to your JSP file and uncomment it.
  ***
--%>
<%-- [Data Bean Activation]
<wcbase:useBean id="marketing_StoreError" classname="com.ibm.commerce.common.beans.StoreErrorDataBean"  />
<wcbase:useBean id="marketing_StoreDB" classname="com.ibm.commerce.common.beans.StoreDataBean" />
[Data Bean Activation] --%>

<%-- 
	***
	* Check to see if shopcart is empty.  If empty, display shopcart is empty error message. If order items exist, display shopcart contents.
	***
--%>
<c:set var="bHasShopCart" value="false" />
<c:choose>
	<%-- Check to see if there us an order id, if no, then shopping cart is empty--%>
	<c:when test="${ empty orderId[0] }" >
		<c:set var="bHasShopCart" value="false"/>
	</c:when>
	<c:otherwise>
		<%-- If there is an order id, then activate the orderbean--%>
		<wcbase:useBean id="marketing_OrderBean" classname="com.ibm.commerce.order.beans.OrderDataBean" scope="page">
			<c:set value="${orderId[0]}" target="${marketing_OrderBean}" property="orderId"/>
		</wcbase:useBean>	
		<%-- The PromoCodeListDataBean is used to list all the promotion codes entered for an order --%>
		<wcbase:useBean id="marketing_PromoCodeListBean" classname="com.ibm.commerce.marketing.databeans.PromoCodeListDataBean" scope="page">
			<c:set value="${orderId[0]}" target="${marketing_PromoCodeListBean}" property="orderId"/>
		</wcbase:useBean>
		<%-- If there is an order id, then check to see if there are items associated with the order id obtained from the command--%>
	    <c:choose>
	    	<%-- if there are items, then there are items in the shopping cart --%>
	   		<c:when test="${ !empty marketing_OrderBean.orderItemDataBeans }" >
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

<%-- Load the store bundles --%>
<fmt:setLocale value="${CommandContext.locale}" />
<fmt:setBundle basename="${marketing_StoreDB.jspStoreDir}/Snippets/Marketing/Promotions/MarketingJSPCodeSnippetText" var="marketing_StoreText" />

<c:choose> 
	<c:when test="${ !bHasShopCart }">
		<%-- If the shopcart is empty, display nothing --%>
		&nbsp;
	</c:when>
	<c:otherwise>
		<%-- Shopcart is not empty.  Display shopcart conents. --%>

<!--MAIN CONTENT STARTS HERE-->
<table cellpadding="0" cellspacing="0" width="580" border="0" id="Marketing_PromotionCodeForm_Table_1">
<tbody>
<tr>
	<td width="10" id="Marketing_PromotionCodeForm_TableCell_1">&nbsp;</td>
	<td id="Marketing_PromotionCodeForm_TableCell_2">

		<table cellpadding="0" cellspacing="2" id="Marketing_PromotionCodeForm_Table_2">
			<tr>
				<td colspan="4" width="580" id="Marketing_PromotionCodeForm_TableCell_3">
						&nbsp;
					<hr width="580"/>
				</td>
			</tr>
			<tr>
				<td colspan="4" width="580" id="Marketing_PromotionCodeForm_TableCell_4">
					<%-- 
					  ***
					  *	Start: Error handling
					  * This section retrieves the store error message corresponding to the ECMessage key and the error code.
					  * An appropriate error message will be displayed when there is an error.
					  ***
					--%>							
					<c:if test="${!empty marketing_StoreError.key}">
						<fmt:bundle basename="/${marketing_StoreDB.jspStoreDir}/Snippets/Marketing/Promotions/MarketingJSPCodeSnippetErrorMessages">
							<fmt:message key="${marketing_StoreError.key}" var="marketing_ErrorMessage">			
								<c:forEach var="marketing_MessageParameter" items="${marketing_StoreError.messageParameters}">
									<fmt:param value="${marketing_MessageParameter}"/>
								</c:forEach>
							</fmt:message>
							<c:set var="keyNotFound" value="???${marketing_StoreError.key}???"/>   
							<c:if test="${marketing_ErrorMessage eq keyNotFound}">
								<fmt:message key="_ERR_GENERIC" var="marketing_ErrorMessage"/>
							</c:if>
						</fmt:bundle>
					</c:if>					
					<c:if test="${!empty marketing_ErrorMessage}">
						<p>
							<font color="#B70101"><c:out value="${marketing_ErrorMessage}"/></font>
							<br/><br/>
						</p>
					</c:if>
					<%-- 
					  ***
					  *	End: Error handling
					  ***
					--%>
				</td>
			</tr>

			<tr>
				<td colspan="4" id="Marketing_PromotionCodeForm_TableCell_5">&nbsp;</td>
			</tr>

<%-- 
	***
	* Start: display the order list and the discounts applied
	***
--%>
			<%--
				***
				* Start: Display the main heading
				***
			--%>
			<tr>
				<th id="t1">
					<label for="qty1"><fmt:message key="QTY" bundle="${marketing_StoreText}"/></label>
				</th>
				<th id="t2" width="250">
					<fmt:message key="ITEM" bundle="${marketing_StoreText}"/>
				</th>
				<th id="t3">
					<div align="right"><fmt:message key="EACH" bundle="${marketing_StoreText}"/></div>
				</th>
				<th id="t4">
					<div align="right"><fmt:message key="TOTAL" bundle="${marketing_StoreText}"/></div>
				</th>
			</tr>
			<%--
				***
				* End: Display the main heading
				***
			--%>

			<%-- use variable "hasOrderItemDiscount" to track whether the order contains order item level discounts --%>
			<c:set var="hasOrderItemDiscount" value="false" />
			<%--
				***
				* Start: Display order item information
				* For each order item, it displays the following information:
				*  - quantity
				*  - item short description
				*  - item price
				*  - total product price
				*  - discount description and discount amount
				***
			--%>
			<c:forEach var="marketing_OrderItem" items="${marketing_OrderBean.orderItemDataBeans}" varStatus="status">
			<tr>
				<td headers="t1" id="Marketing_PromotionCodeForm_TableCell_Quantity_<c:out value="${status.count}"/>">
					<%-- Display the quantity  --%>
					<c:out value="${marketing_OrderItem.formattedQuantity}"/>
				</td>
				<td headers="t2" width="250" id="Marketing_PromotionCodeForm_TableCell_ItemName_<c:out value="${status.count}"/>" >
					<%-- Display the item name  --%>
					<c:out value="${marketing_OrderItem.catalogEntryDataBean.description.name}" escapeXml="false"  /><br/>
				</td>
				<td headers="t3" align="right" id="Marketing_PromotionCodeForm_TableCell_ItemPrice_<c:out value="${status.count}"/>">
					<%-- Display item prices --%>
					<c:out value="${marketing_OrderItem.priceDataBean}" escapeXml="false" ><fmt:message key="NO_PRICE_AVAILABLE" bundle="${marketing_StoreText}" /></c:out>
				</td>
				<%--
					***
					* Start: Display total product price if it is not a freebie
					***
				--%>
				<td headers="t4" align="right" id="Marketing_PromotionCodeForm_TableCell_TotalProduct_<c:out value='${status.count}'/>" >
					<%-- check to see if the order item is a freebie --%>
					<c:choose>
						<c:when test="${marketing_OrderItem.free}">
							<%-- the OrderItem is a freebie --%>
							<i><fmt:message key="SHOPCART_FREE" bundle="${marketing_StoreText}"/></i>
						</c:when>
						<c:otherwise>
							<c:out value="${marketing_OrderItem.formattedTotalProduct}" escapeXml="false" />
						</c:otherwise>
					</c:choose>
				</td>
				<%--
					***
					* End: Display total product price if it is not a freebie
					***
				--%>
			</tr>
			<%-- 
				***
				* Start: Display discount description and discount amount
				* Check to see if there is an order item level discount before displaying the discount information
				***
			--%>			
			<c:if test="${!empty marketing_OrderItem.appliedProductPromotions}" >
				<c:forEach var="productPromo" items="${marketing_OrderItem.appliedProductPromotions}" varStatus="counter"> 
					<tr>
						<td colspan="3" align="left" id="Marketing_PromotionCodeForm_TableCell_DiscountDesc_<c:out value="${counter.count}"/>">
								<i>
								*&nbsp;<c:out value="${productPromo.nationalizedShortDescription}"/>
								</i>
						</td>
						<td align="right" id="Marketing_PromotionCodeForm_TableCell_DiscountAmount_<c:out value="${counter.count}"/>">
							<i><c:out value="${productPromo.formattedTotal}" escapeXml="false" /></i>
						</td>
					</tr>
					<tr ><td colspan="4" id="Marketing_PromotionCodeForm_TableCell_6">&nbsp;</td></tr>
					<c:set var="hasOrderItemDiscount" value="true" />
				</c:forEach>
			</c:if>
			<%--
				***
				* End: Display discount description and discount amount
				***
			--%>
			</c:forEach>
			<%--
				***
				* End: Display order item information
				***
			--%>			
			<tr>
				<td colspan="4" width="580" id="Marketing_PromotionCodeForm_TableCell_7">
					<hr width="100%"/>
				</td>
			</tr>
			<tr>
			<%-- 
				***
				* Start: Display order information
				* This section displays the following order information:
				*  - order subtotal before discount
				*  - total of applicable orderitem discounts
				*  - applicable order discounts
				*  - order subtotal
				*** 
			--%>
				<td align="right" colspan="4" width="580" id="Marketing_PromotionCodeForm_TableCell_8">
					<table cellpadding="2" cellspacing="1" border="0" id="Marketing_PromotionCodeForm_Table_3">
						<tbody>
							<c:set var="orderAdjustmentDBs" value="${marketing_OrderBean.orderLevelDiscountOrderAdjustmentDataBeans}"/>
							<%-- If there are discounts, display the SubTotal before discounts --%>
							<c:if test="${ !empty orderAdjustmentDBs || !empty marketing_OrderBean.formattedOrderItemDiscountTotal }">
								<tr>
									<td width="10" id="Marketing_PromotionCodeForm_TableCell_9">&nbsp;</td>
									<td align="right" id="Marketing_PromotionCodeForm_TableCell_10">
										&nbsp;<fmt:message key="SUBTOTAL_BEFORE_DISCOUNTS" bundle="${marketing_StoreText}" />
										&nbsp;&nbsp;<c:out value="${marketing_OrderBean.formattedTotalProductPrice}" escapeXml="false"/>
									</td>
								</tr>
								<%-- Display total of applicable orderitem discounts --%>
								<c:if test="${hasOrderItemDiscount}">	
									<tr>
										<td width="10" id="Marketing_PromotionCodeForm_TableCell_11">
											&nbsp;
										</td>
										<td align="right" id="Marketing_PromotionCodeForm_TableCell_12">
											<i>
												*&nbsp;<fmt:message key="PRODUCT_DISCOUNT_TOTAL" bundle="${marketing_StoreText}" />
												<c:out value="${marketing_OrderBean.formattedOrderItemDiscountTotal}" escapeXml="false"/>
											</i>
										</td>
									</tr>
								</c:if>
								<%-- Display applicable Order discounts --%>
								<c:if test="${ !empty orderAdjustmentDBs }">	
									<tr>
										<td width="10" id="Marketing_PromotionCodeForm_TableCell_13">
											&nbsp;
										</td>
										<td align="right" id="Marketing_PromotionCodeForm_TableCell_14">
											<c:forEach var="adjustmentDB" items="${orderAdjustmentDBs}">
												<i>
													*&nbsp;<c:out value="${adjustmentDB.calculationCodeDescriptionString}" escapeXml="false"/>
													<c:out value="${adjustmentDB.formattedAmount}" escapeXml="false"/>
												</i>
											</c:forEach>
										</td>
									</tr>
								</c:if>													
							</c:if>
							<tr>
								<td width="10" id="Marketing_PromotionCodeForm_TableCell_15">&nbsp;</td>
								<td align="right" id="Marketing_PromotionCodeForm_TableCell_16">
									<fmt:message key="SUBTOTAL" bundle="${marketing_StoreText}" />
									&nbsp;&nbsp;<c:out value="${marketing_OrderBean.formattedDiscountAdjustedProductTotal}" escapeXml="false"/>
								</td>
							</tr>
						</tbody>
					</table>
				</td>
			<%-- 
				***
				* End: Display order information
				*** 
			--%>
			</tr>
<%-- 
	***
	* End: display the order list and the discounts applied
	***
--%>


			<tr>
				<td colspan="4" width="580" id="Marketing_PromotionCodeForm_TableCell_17">
					<hr width="100%"/>
				</td>
			</tr>

			<tr>
				<td colspan="4" width="580" id="Marketing_PromotionCodeForm_TableCell_18">
					<label for="Marketing_PromotionCodeForm_FormInput_promoCode_In_PromotionCodeForm_1"><fmt:message key="ENTER_PROMO_CODE" bundle="${marketing_StoreText}" /></label><br/>
				</td>
			</tr>

<%-- 
	***
	* Begin: Promotion Code Form
	***
--%>
			<tr>
				<td colspan="4" width="580" id="Marketing_PromotionCodeForm_TableCell_19">
					<%--
					  ***
					  * This snippet assumes that the promotion code form is in the shopping cart page.
					  * In the promotion code form, the parameter 'URL' is set to OrderCalculate followed by OrderItemDisplay.
					  * The parameter 'errorViewName' is set to OrderItemDisplayViewShiptoAssoc.
					  * In this case, after the promotion code is added, the order is calculated and the shopping cart page (OrderItemDisplay) is displayed again.
					  * If there is an error adding the promotion code, the shopping cart view will be displayed.
					  * 
					  * If the promotion code form is not the shopping cart, you can simply set the value for parameter 'URL' and 'errorViewName' properly
					  * so that the correct view will be displayed after the promotion code is added or after an error occurs.
					  ***
					--%>
					<form name="PromotionCodeForm" method="post" action="PromotionCodeManage" id="PromotionCodeForm">
						<input type="hidden" name="storeId" value="<c:out value="${WCParam.storeId}" />" id="Marketing_PromotionCodeForm_FormInput_storeId_In_ShopCartForm_1"/>
						<input type="hidden" name="langId" value="<c:out value="${CommandContext.languageId}" />" id="Marketing_PromotionCodeForm_FormInput_langId_In_ShopCartForm_1"/>
						<input type="hidden" name="orderId" value="<c:out value="${orderId[0]}" />" id="Marketing_PromotionCodeForm_FormInput_orderId_In_ShopCartForm_1"/>
						<input type="hidden" name="catalogId" value="<c:out value="${WCParam.catalogId}" />"  id="Marketing_PromotionCodeForm_FormInput_catalogId_In_ShopCartForm_1"/>
						<input type="hidden" name="taskType" value="A" id="Marketing_PromotionCodeForm_FormInput_taskType_In_PromotionCodeForm_1"/>
						<input size="10" name="promoCode" id="Marketing_PromotionCodeForm_FormInput_promoCode_In_PromotionCodeForm_1" value=""/>
						<input type="hidden" name="URL" value="OrderCalculate?URL=OrderItemDisplay&updatePrices=1&calculationUsageId=-1" id="Marketing_PromotionCodeForm_FormInput_URL_In_PromotionCodeForm_1"/>
						<input type="hidden" name="errorViewName" value="OrderItemDisplayViewShiptoAssoc" id="Marketing_PromotionCodeForm_FormInput_errorViewName_In_PromotionCodeForm_1"/>
					<a href="javascript:document.PromotionCodeForm.submit()" id="Marketing_PromotionCodeForm_Link_1"><fmt:message key="SUBMIT" bundle="${marketing_StoreText}" /></a>
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
	* Begin: List all the Promotion Codes entered
	***
--%>
			<c:if test="${!empty marketing_PromoCodeListBean.codes}" >
			<tr>
				<td colspan="4" width="580" id="Marketing_PromotionCodeForm_TableCell_20">
					<fmt:message key="REDEEMED_PROMO" bundle="${marketing_StoreText}" />
				</td>
			</tr>
			<tr>
				<td colspan="4" width="580" id="Marketing_PromotionCodeForm_TableCell_21">
					<%-- list all the promotion code discounts entered--%>
						<c:forEach var="marketing_PromoCode" items="${marketing_PromoCodeListBean.codes}" varStatus="status">	
							<c:out value="${marketing_PromoCode.description}"/>
							<c:url var="marketing_PromotionCodeManageURL" value="PromotionCodeManage">
								<c:param name="langId" value="${CommandContext.languageId}" />
								<c:param name="storeId" value="${WCParam.storeId}" />
								<c:param name="catalogId" value="${WCParam.catalogId}" />
								<c:param name="taskType" value="R" />
								<c:param name="orderId" value="${orderId[0]}" />
								<c:param name="promoCode" value="${marketing_PromoCode.code}" />
								<c:param name="URL" value="OrderCalculate?URL=OrderItemDisplay&updatePrices=1&calculationUsageId=-1" />
							</c:url>
							<a href="<c:out value="${marketing_PromotionCodeManageURL}"/>" id="Marketing_PromotionCodeForm_Link_2"><fmt:message key="REMOVE" bundle="${marketing_StoreText}" /></a> <br/>
						</c:forEach>
				</td>
			</tr>
			<tr>
				<td colspan="4" width="580" id="Marketing_PromotionCodeForm_TableCell_22">
					&nbsp;
				</td>
			</tr>

			</c:if>
<%-- 
	***
	* End: List all the Promotion Codes applied
	***
--%>
		</table>

	</td>
</tr>

</tbody>
</table>

	</c:otherwise>
</c:choose>


<!-- End - JSP File Name:  PromotionCodeForm.jsp -->
