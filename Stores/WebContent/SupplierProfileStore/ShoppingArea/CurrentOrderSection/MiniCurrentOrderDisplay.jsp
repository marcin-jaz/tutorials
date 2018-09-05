<%--==========================================================================
Licensed Materials - Property of IBM

WebSphere Commerce

(c) Copyright IBM Corp.  2001, 2006
All Rights Reserved

US Government Users Restricted Rights - Use, duplication or
disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
===========================================================================--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../include/JSTLEnvironmentSetup.jspf" %>

<!-- BEGIN MiniCurrentOrderDisplay.jsp -->

	<c:set var="currentPendingOrderId" value="."/>
	<%-- get the current pending order --%>                   			
	<wcbase:useBean id="orderListCurrentPendingOrderBean" classname="com.ibm.commerce.order.beans.OrderListDataBean">
		<c:set target="${orderListCurrentPendingOrderBean}" property="storeId" value="${CommandContext.storeId}"/>
		<c:set target="${orderListCurrentPendingOrderBean}" property="userId" value="${userId}"/>
		<c:set target="${orderListCurrentPendingOrderBean}" property="fetchCurrentPendingOrder" value="true"/>
	</wcbase:useBean>
	<c:forEach items="${orderListCurrentPendingOrderBean.orderDataBeans}" var="currentPendingOrder">
		<c:set var="currentPendingOrderStatus" value="${currentPendingOrder.status}"/>
		<c:if test="${currentPendingOrderStatus != 'X'}" >
			<c:set var="currentPendingOrderId" value="${currentPendingOrder.orderId}"/>
		</c:if>                                                                                                            	   	 	                 				
	</c:forEach>
	
	<wcbase:useBean id="orderListBean" classname="com.ibm.commerce.order.beans.OrderListDataBean" scope="request">
		<c:set target="${orderListBean}" property="storeId" value="${CommandContext.storeId}"/>

				<c:set target="${orderListBean}" property="retrievalOrderStatus" value="P"/>	


		<c:set target="${orderListBean}" property="userId" value="${userId}"/>
	</wcbase:useBean>
	<c:set var="orders" value="${orderListBean.orderDataBeans}" />
	<c:forEach items="${orders}" var="order">    					
			<c:set var="orderRn" value="${order.orderId}"/>       					 					
			<c:if test="${orderRn eq currentPendingOrderId or currentPendingOrderId eq '.'}" >
				<c:set var="currentPendingOrderId" value="${orderRn}"/>
			</c:if>
	</c:forEach>
    
<c:forTokens items="${requestScope.requestURIPath}" delims="/" var="URLtoken">
	<c:set var="ReloadURL" value="${URLtoken}"/>
</c:forTokens>
<c:url var="ReloadWithParametersURL" value="${ReloadURL}">
	<c:forEach var="parameter" items="${WCParamValues}" >
		<c:if test="${parameter.key != 'logonPassword'}">
			<c:choose>
				<c:when test="${parameter.key == 'orderId'}">
					<c:param name="${parameter.key}" value="." />
				</c:when>
				<c:when test="${parameter.key != 'URL'}">
					<c:param name="${parameter.key}">
						<c:forEach var="value" items="${parameter.value}" >
							<c:out value="${value}" />
						</c:forEach>
					</c:param>
				</c:when>
				<c:otherwise>
					<c:set var="urlParam" value="${parameter.key}"/>
					<c:set var="urlParamValue" value="${parameter.value}"/>
				</c:otherwise>
			</c:choose>	
		</c:if>
	</c:forEach>
	<c:if test="${!empty urlParam}">
		<c:param name="${urlParam}">
			<c:out value="${urlParamValue}" />
		</c:param>		
	</c:if>
</c:url>

<%-- use variable "hasOrderItemDiscount" to track whether the order contains order item level discounts --%>
<c:set var="hasOrderItemDiscount" value="false" />

<wcbase:useBean id="orderListBean" classname="com.ibm.commerce.order.beans.OrderListDataBean" scope="request">
	<c:set target="${orderListBean}" property="storeId" value="${CommandContext.storeId}"/>
	<c:set target="${orderListBean}" property="retrievalOrderStatus" value="P"/>	
	<c:set target="${orderListBean}" property="userId" value="${userId}"/>
</wcbase:useBean>

<c:choose>
<c:when test="${orderListBean.emptyShopCart}">
	<c:set var="EmptyOrderFile" value="${jspStoreDir}ShoppingArea/CurrentOrderSection/MiniEmptyOrderDisplay.jsp"/>
	<% out.flush(); %>
	<c:import url="${EmptyOrderFile}"/>
	<% out.flush(); %>
</c:when>	
<c:otherwise>	
	
	<!-- content start -->
	<fmt:message key="HUD_MiniCurrentOrderDisplay" var="HUDFrameTitle" bundle="${storeText}" />
	<c:url var="maximizeURL" value="OrderItemDisplayView">
		<c:param name="langId" value="${langId}" />
		<c:param name="storeId" value="${storeId}" />
		<c:param name="catalogId" value="${catalogId}" />
		<c:param name="orderId" value="." />
	</c:url>
	<% out.flush(); %>
	<c:import url="${jspStoreDir}${StyleDir}HUDContainerTop.jsp" >
		<c:param name="HUDFrameTitle" value="${HUDFrameTitle}" />
		<c:param name="maximizeURL" value="${maximizeURL}" />
	</c:import>
	<% out.flush(); %>
	
<c:set var="pageToDisplay" value="${param.CIPCurrentOrderPage}" />
<c:if test="${empty pageToDisplay}">
	<c:set var="pageToDisplay" value="0" />
</c:if>
<c:set var="rowsToDisplay" value="${param.rowsToDisplay}" />
<c:if test="${empty rowsToDisplay}">
	<c:set var="rowsToDisplay" value="5" />
</c:if>
  
<c:set var="orders" value="${orderListBean.orderDataBeans}" />

<c:if test="${currentPendingOrderId != '.'}" >
<wcbase:useBean id="usablePaymentTC" classname="com.ibm.commerce.payment.beans.UsablePaymentTCListDataBean" scope="request">
	<c:set target="${usablePaymentTC}" property="orderId" value="${currentPendingOrderId}"/>
</wcbase:useBean>
</c:if>

<c:set var="rowsTotal" value="0"/>
<c:set var="precheckRowsTotal" value="0"/>
<c:if test="${(!empty pageToDisplay) and (pageToDisplay != 0)}">
	<c:set var="orders2" value="${orders}" />
	<c:forEach items="${orders2}" var="order">
		<c:forEach items="${order.orderItemDataBeans}" var="orderItem" varStatus="istat">
			<c:set var="rowsTotal" value="${rowsTotal + 1}"/>
			<c:if test="${(((rowsToDisplay * pageToDisplay) + 1) <= istat.count) and (istat.count <= (rowsToDisplay * (pageToDisplay +1))) }">
				<c:set var="precheckRowsTotal" value="${precheckRowsTotal + 1}"/>
			</c:if>
		</c:forEach>
	</c:forEach>
	<c:if test="${precheckRowsTotal == 0}">
		<c:set var="pageShouldDisplay" value="${(rowsTotal -(rowsTotal % rowsToDisplay))/ rowsToDisplay}" />
		<c:if test="${(rowsTotal % rowsToDisplay) == 0}">
			<c:set var="pageShouldDisplay" value="${pageShouldDisplay - 1}" />
		</c:if>
	</c:if>
	<c:set var="firstToken" value="true"/>
	<c:forTokens items="${pageShouldDisplay}" delims="." var="token">
		<c:if test="${firstToken==true}">
			<c:set var="firstToken" value="false"/>
			<c:set var="pageToDisplay" value="${token}" />
		</c:if>
	</c:forTokens>
</c:if>

<c:set var="rowStart" value="${pageToDisplay * rowsToDisplay}" />
<c:set var="rowsDisplayed" value="0"/>
<c:set var="rowsShownInFirstForEach" value="0"/>
<c:set var="rowsTotal" value="0"/>


<table cellpadding="0" cellspacing="0" border="0" width="100%" class="bgColor" id="WC_MiniCurrentOrderDisplay_Table_3">
	<tbody>
		<tr>
			<td id="WC_MiniCurrentOrderDisplay_TableCell_4">
			
				<c:set var="currentPendingOrderHasItems" value="false" />
				<%-- Check if current pending order has order items --%>
				<c:forEach items="${orders}" var="order">    					
    					<c:set var="orderRn" value="${order.orderId}"/>       					 					
    					<c:if test="${orderRn eq currentPendingOrderId or currentPendingOrderId eq '.'}" >
    						<c:if test="${!empty order.orderItemDataBeans}" > 
    							<c:set var="currentPendingOrderHasItems" value="true" />
    						</c:if>
    					</c:if>
				</c:forEach>
			
			 <c:choose>
    			<c:when test="${currentPendingOrderHasItems eq 'false'}" >   			
    				<c:set var="EmptyOrderFile" value="${jspStoreDir}ShoppingArea/CurrentOrderSection/MiniEmptyOrderDisplay.jsp"/>
					<% out.flush(); %>
					<c:import url="${EmptyOrderFile}"/>
					<% out.flush(); %>			   				
    			</c:when>
    			<c:otherwise>
				<table width="100%" border="0" cellpadding="2" cellspacing="1" id="WC_MiniCurrentOrderDisplay_Table_4">
					<tr class="bgColor">
						<td valign="top" class="portlet_colHeader" id="WC_MiniCurrentOrderDisplay_TableCell_6"><fmt:message key="YourOrder_Quantity" bundle="${storeText}"/></td>
						<td valign="top" class="portlet_colHeader" id="WC_MiniCurrentOrderDisplay_TableCell_10"><fmt:message key="YourOrder_Name" bundle="${storeText}"/></td>
						<td valign="top" class="portlet_colHeader" id="WC_MiniCurrentOrderDisplay_TableCell_16"><fmt:message key="YourOrder_Unit" bundle="${storeText}"/></td>
						<td valign="top" class="portlet_colHeader" id="WC_MiniCurrentOrderDisplay_TableCell_18"><fmt:message key="YourOrder_Total" bundle="${storeText}"/></td>
						<td valign="top" class="portlet_colHeader" id="WC_MiniCurrentOrderDisplay_TableCell_20">&nbsp;</td>
					</tr>
                    <c:set var="counter" value="0"/>
                    <c:set var="i" value="0"/>
                    <c:forEach items="${orders}" var="order">
    					<c:set var="orderItems" value="${order.orderItemDataBeans}"/>
    					<c:set var="orderRn" value="${order.orderId}"/>    					
    					<c:set var="j" value="0"/>
    					 
    					 <c:if test="${orderRn eq currentPendingOrderId or currentPendingOrderId eq '.'}" > 
    					 
    					<c:set var="orderAdjustmentDBs" value="${order.orderLevelDiscountOrderAdjustmentDataBeans}" />
    					
    					<c:forEach items="${order.orderItemDataBeans}" var="orderItem" varStatus="istat">
							<c:set var="rowsTotal" value="${rowsTotal + 1}"/>
							<%-- Check to see if the order has any product promotions --%>
							<c:if test="${!empty orderItem.appliedProductPromotions}">
								<c:set var="hasOrderItemDiscount" value="true" />
							</c:if>
							
							<c:if test="${(((rowsToDisplay * pageToDisplay) + 1) <= istat.count) and (istat.count <= (rowsToDisplay * (pageToDisplay +1))) }">
								<c:set var="rowsDisplayed" value="${rowsDisplayed + 1}"/>
    					
    						<c:set var="counter" value="${counter+1}"/>
    						<c:choose>
					        	<c:when test="${(j mod 2)==0}">
					        		<c:set var="sRowColor" value="cellBG_1"/>
					        	</c:when>
					        	<c:otherwise>
					        		<c:set var="sRowColor" value="cellBG_2"/>
					        	</c:otherwise>
					        </c:choose>
					        
                            <flow:ifEnabled feature="customerCare"> 
                            	<c:set var="liveHelpShoppingCartItems" value="${orderItem.quantityInEJBType}"/>
                            </flow:ifEnabled>  
                            <tr valign="top">
                              <td class="<c:out value="${sRowColor}"/> portlet_content" align="center" id="WC_MiniCurrentOrderDisplay_TableCell_21_<c:out value="${i}"/>_<c:out value="${j}"/>"><c:out value="${orderItem.quantityInEJBType}"/></td>
                              <td class="<c:out value="${sRowColor}"/> portlet_content" id="WC_MiniCurrentOrderDisplay_TableCell_23_<c:out value="${i}"/>_<c:out value="${j}"/>">
                              
                               <wcbase:useBean id="catalogEntryDB" classname="com.ibm.commerce.catalog.beans.CatalogEntryDataBean">
										<c:set target="${catalogEntryDB}" property="catalogEntryID" value="${orderItem.catalogEntryId}" />		
								</wcbase:useBean>
                              
                              <c:if test="${catalogEntryDB.type eq 'ItemBean'}">
                              	<c:url var="ProductDisplayURL" value="ProductDisplay">
							        <c:param name="catalogId" value="${catalogId}"/>
							        <c:param name="storeId" value="${storeId}"/>
							        <c:param name="langId" value="${langId}"/>
							        <c:param name="productId" value="${orderItem.catalogEntryId}"/>
								</c:url>
							  </c:if>
             				  <c:if test="${catalogEntryDB.type eq 'PackageBean'}">
                              	<c:url var="ProductDisplayURL" value="PackageDisplay">
							        <c:param name="catalogId" value="${catalogId}"/>
							        <c:param name="storeId" value="${storeId}"/>
							        <c:param name="langId" value="${langId}"/>
							        <c:param name="productId" value="${orderItem.catalogEntryId}"/>
								</c:url>
							  </c:if>								
								<c:remove var="catalogEntryDB" />
								
                              	<a class="portlet_content" href="<c:out value="${ProductDisplayURL}"/>" id="WC_MiniCurrentOrderDisplay_Link_2_<c:out value="${i}"/>_<c:out value="${j}"/>">
                              		<c:out value="${orderItem.catalogEntry.description.shortDescription}" escapeXml="false"/>
                              	</a>
                              	<br />
                              	<strong><fmt:message key="YourOrder_SKU" bundle="${storeText}"/>:</strong>&nbsp;<c:out value="${orderItem.catalogEntry.partNumber}"/> 
                              </td>
                              <td class="<c:out value="${sRowColor}"/> portlet_price" id="WC_MiniCurrentOrderDisplay_TableCell_26_<c:out value="${i}"/>_<c:out value="${j}"/>">
                              	<c:out value="${orderItem.priceDataBean}" escapeXml="false"/>
                              </td>
							<%--
								***
								* Begin: display discounted amount if there is a applicable promotion
								***
							--%>
							<c:choose>
								<c:when test="${orderItem.free}">
									<%-- the OrderItem is a freebie --%>
									<td class="<c:out value="${sRowColor}"/> portlet_price" valign="top" id="WC_MiniCurrentOrderDisplay_TableCell_27_<c:out value="${i}"/>_<c:out value="${j}"/>">
										<fmt:message key="CurrentOrder_SHOPCART_FREE" bundle="${storeText}"/>
									</td>
								</c:when>
								<c:otherwise>
									<td class="<c:out value="${sRowColor}"/> portlet_price" valign="top" id="WC_MiniCurrentOrderDisplay_TableCell_27_<c:out value="${i}"/>_<c:out value="${j}"/>">
	                  <c:out value="${orderItem.formattedTotalProduct}" escapeXml="false"/>
	                </td>	
								</c:otherwise>
							</c:choose>
							<%--
								***
								* End: display discounted amount
								***
							--%>
							          
                  <td class="<c:out value="${sRowColor}"/>" id="WC_MiniCurrentOrderDisplay_TableCell_28_<c:out value="${i}"/>_<c:out value="${j}"/>">
                  <c:if test="${!orderItem.free}">
                    <%-- the OrderItem is a freebie --%>
	                  <c:url var="OrderItemDeleteURL" value="OrderItemDelete">
								        <c:param name="catalogId" value="${catalogId}"/>
								        <c:param name="storeId" value="${storeId}"/>
								        <c:param name="orderItemId" value="${orderItem.orderItemId}"/>
								        <c:param name="langId" value="${langId}"/> 
								        <c:param name="updatePrices" value="1" />
										    <c:param name="calculationUsageId" value="-1" />
								        <c:param name="URL" value="OrderCalculate?URL=${ReloadWithParametersURL}"/>
							      </c:url>
							      <a href="<c:out value="${OrderItemDeleteURL}"/>" id="WC_MiniCurrentOrderDisplay_Link_3_<c:out value="${i}"/>_<c:out value="${j}"/>" class="garbage" title="<fmt:message key="YourOrder_Remove" bundle="${storeText}"/>">
							      	<img src="<c:out value="${jspStoreImgDir}"/>images/garbage3.gif" alt="<fmt:message key="YourOrder_Remove" bundle="${storeText}"/>" width="16" height="16" border="0">
							      </a>
							    </c:if>
                  </td>
                </tr>
              </c:if>
              
						<c:set var="j" value="${j+1}"/>
			</c:forEach>
                <%//end j%>
                
                
                <c:choose>
		        	<c:when test="${(i == 0)}">
		        		<c:set var="formattedTotalPrice" value="${order.formattedTotalProductPrice}"/>
		        		<c:set var="formattedOrderItemDiscountTotal" value="${order.formattedOrderItemDiscountTotal}" />
                        <c:set var="formattedDiscountAdjustedSubTotal" value="${order.formattedDiscountAdjustedProductTotal}"/>		        		
		        	</c:when>
		        	<c:otherwise> 
		        		<c:set var="formattedAmount" value="${order.formattedTotalProductPrice}"/>		        		
		        		<c:set var="formattedOrderItemDiscountTotalAmount" value="${order.formattedOrderItemDiscountTotal}" />
                        <c:set target="${formattedTotalPrice}" property="amount" value="${formattedAmount.amount+formattedTotalPrice.amount}"/>
                        <c:set target="${formattedOrderItemDiscountTotal}" property="amount" value="${formattedOrderItemDiscountTotalAmount.amount+formattedOrderItemDiscountTotal.amount}"/>		        				        		 				   
		        		
		        	</c:otherwise>
		        </c:choose>  
                 
                <c:set var="i" value="${i+1}"/>
               
               	<c:set var="formattedOrderItemDiscountTotal" value="${order.formattedOrderItemDiscountTotal}" />
		        </c:if>
		        
		</c:forEach>
		<%//end i%>
		
        
<c:if test="${rowsDisplayed < rowsTotal}">
	<c:choose>
    	<c:when test="${(j mod 2)==0}">
    		<c:set var="sRowColor" value="cellBG_1"/>
    	</c:when>
    	<c:otherwise>
    		<c:set var="sRowColor" value="cellBG_2"/>
    	</c:otherwise>
    </c:choose>
    <c:set var="j" value="${j+1}"/>
    <c:if test="${currentPendingOrderId eq '.'}" >
    	<c:set var="currentPendingOrderId" value="."/>
    </c:if>
    <c:url var="OrderItemDisplayURL" value="OrderItemDisplayView">
		<c:param name="langId" value="${langId}" />
		<c:param name="storeId" value="${storeId}" />
		<c:param name="catalogId" value="${catalogId}" />
		<c:param name="orderId" value="${currentPendingOrderId}" />
	</c:url>
	<c:url var="ReloadWithParametersNextPageURL" value="${ReloadURL}">
		<c:forEach var="parameter" items="${WCParamValues}" >
			<c:if test="${parameter.key != 'CIPCurrentOrderPage' && parameter.key != 'logonPassword'}">
				<c:param name="${parameter.key}">
					<c:forEach var="value" items="${parameter.value}" >
						<c:out value="${value}" />
					</c:forEach>
				</c:param>
			</c:if>
		</c:forEach>
		<c:param name="CIPCurrentOrderPage" value="${pageToDisplay+1}"/>
	</c:url>
	<c:url var="ReloadWithParametersPrevPageURL" value="${ReloadURL}">
		<c:forEach var="parameter" items="${WCParamValues}" >
			<c:if test="${parameter.key != 'CIPCurrentOrderPage' && parameter.key != 'logonPassword'}">
				<c:param name="${parameter.key}">
					<c:forEach var="value" items="${parameter.value}" >
						<c:out value="${value}" />
					</c:forEach>
				</c:param>
			</c:if>
		</c:forEach>
		<c:param name="CIPCurrentOrderPage" value="${pageToDisplay-1}"/>
	</c:url>
	<tr class="<c:out value="${sRowColor}"/>"> 
		<td colspan="5" class="portlet_content" id="WC_MiniCurrentOrderDisplay_TableCell_36">
			<fmt:message key="HUD_Page_Results" bundle="${storeText}">
				<fmt:param value="${rowStart + 1}"/>
				<fmt:param value="${rowStart + rowsDisplayed}"/>
				<fmt:param value="${rowsTotal}"/>
			</fmt:message>
			<c:if test="${pageToDisplay > 0}">
				&nbsp;
				<a href="<c:out value="${ReloadWithParametersPrevPageURL}" />" id="WC_CachedHeaderDisplay_Link_8" class="portlet_content"
				><fmt:message key="HUD_Page_Prev" bundle="${storeText}" /></a>
			</c:if>
			<c:if test="${rowsTotal > (rowStart + rowsDisplayed)}">
				&nbsp;
				<a href="<c:out value="${ReloadWithParametersNextPageURL}" />" id="WC_CachedHeaderDisplay_Link_8" class="portlet_content"
				><fmt:message key="HUD_Page_Next" bundle="${storeText}" /></a>
			</c:if>
			<br/>
			<a href="<c:out value="${OrderItemDisplayURL}" />" id="WC_CachedHeaderDisplay_Link_8" class="portlet_content">
				<fmt:message key="HUD_More" bundle="${storeText}" />
			</a>
		</td>
	</tr>
</c:if>        
        
        
			<c:choose>
	        	<c:when test="${(j mod 2)==0}">
	        		<c:set var="sRowColor" value="cellBG_1"/>
	        	</c:when>
	        	<c:otherwise>
	        		<c:set var="sRowColor" value="cellBG_2"/>
	        	</c:otherwise>
	        </c:choose>        
            <tr class="<c:out value="${sRowColor}"/>"> 
              <td colspan="3" align="right" id="WC_MiniCurrentOrderDisplay_TableCell_33" class="portlet_content"><strong><fmt:message key="YourOrder_SUBTOTAL" bundle="${storeText}"/></strong></td>
              <td class="portlet_price" id="WC_MiniCurrentOrderDisplay_TableCell_34"><c:out value="${formattedTotalPrice}" escapeXml="false"/></td>
              <td id="WC_MiniCurrentOrderDisplay_TableCell_35">&nbsp;</td>
            </tr>
            
             <%-- Display product discount total --%> 
             <c:if test="${hasOrderItemDiscount}"> 
	             <tr class="<c:out value="${sRowColor}"/>"> 
	              <td colspan="3" align="right" id="WC_MiniCurrentOrderDisplay_TableCell_36" class="portlet_content"><strong><fmt:message key="YourOrder_PRODUCT_DISCOUNT_TOTAL" bundle="${storeText}"/></strong></td>
	              <td class="portlet_discountPrice" id="WC_MiniCurrentOrderDisplay_TableCell_37"><c:out value="${formattedOrderItemDiscountTotal}" escapeXml="false"/></td>
	              <td id="WC_MiniCurrentOrderDisplay_TableCell_38">&nbsp;</td>
	             </tr>
             </c:if>
             
             <%-- Display order discount total --%>
             <c:if test="${!empty orderAdjustmentDBs }">
	             <c:forEach var="adjustmentDB" items="${orderAdjustmentDBs}">
	             <tr class="<c:out value="${sRowColor}"/>">   
	             	<td colspan="3" align="right" id="WC_MiniCurrentOrderDisplay_TableCell_39" class="portlet_content" ><strong><fmt:message key="YourOrder_ORDER_DISCOUNT_TOTAL" bundle="${storeText}"/></strong></td>
	               	<td class="portlet_discountPrice" id="WC_MiniCurrentOrderDisplay_TableCell_40"><c:out value="${adjustmentDB.formattedAmount}" escapeXml="false"/></td>
	               	<td id="WC_MiniCurrentOrderDisplay_TableCell_41">&nbsp;</td>                    
				 </tr>
	             </c:forEach>
             </c:if> 
            
             <%-- Display subtotal with discount  --%> 
             <c:if test="${!empty orderAdjustmentDBs or hasOrderItemDiscount}">
	             <tr class="<c:out value="${sRowColor}"/>"> 
	               <td colspan="3" align="right" id="WC_MiniCurrentOrderDisplay_TableCell_42" class="portlet_content" ><strong><fmt:message key="YourOrder_SUBTOTAL" bundle="${storeText}"/></strong></td>
	               <td class="portlet_price" id="WC_MiniCurrentOrderDisplay_TableCell_43"><c:out value="${formattedDiscountAdjustedSubTotal}" escapeXml="false"/></td>
	               <td id="WC_MiniCurrentOrderDisplay_TableCell_44">&nbsp;</td>
	             </tr>
             </c:if>       
            
            
          </table>
           </c:otherwise>
          </c:choose>
          
          </td>
      </tr>
    </tbody>
  </table>
  <% out.flush(); %>
  <c:import url="${jspStoreDir}${StyleDir}HUDContainerBottom.jsp" />
  <% out.flush(); %>
        <!--content end-->

	</c:otherwise>
</c:choose>
<!-- END MiniCurrentOrderDisplay.jsp -->
