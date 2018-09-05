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

<c:url var="orderCancelSetPendingURL" value="OrderCancel" >
		<c:param name="storeId" value="${param.storeId}"/>			
		<c:param name="orderId" value="${param.orderId}"/>
		<c:param name="catalogId" value="${param.catalogId}"/>
		<c:param name="URL" value="SetPendingOrder?orderId=${param.firstNonCurrentOrder}&storeId=${param.storeId}&catalogId=${param.catalogId}&URL=ListOrdersDisplay"/>									
</c:url>
<c:url var="orderCancelURL" value="OrderCancel" >
		<c:param name="storeId" value="${param.storeId}"/>			
		<c:param name="orderId" value="${param.orderId}"/>
		<c:param name="catalogId" value="${param.catalogId}"/>
		<c:param name="URL" value="ListOrdersDisplay"/>									
</c:url>
<c:url var="orderCancelOrderItemDisplayURL" value="OrderCancel" >
		<c:param name="storeId" value="${param.storeId}"/>			
		<c:param name="orderId" value="${param.orderId}"/>
		<c:param name="catalogId" value="${param.catalogId}"/>
		<c:param name="URL" value="OrderItemDisplayView?storeId=${param.storeId}&catalogId=${param.catalogId}&orderId=."/>									
</c:url>                                       	  
<c:url var="OrderCopyUrl" value="OrderCopy"  >
		<c:param name="fromOrderId_1" value="${param.orderId}"/>
		<c:param name="toOrderId" value="**" />						    										    					
		<c:param name="copyOrderItemId_1" value="*"/>
		<c:param name="URL" value="OrderCalculate?URL=ListOrdersDisplay?orderId=${param.orderId}&updatePrices=1&calculationUsageId=-1"/>		
		<c:param name="storeId" value="${param.storeId}"/>
		<c:param name="catalogId" value="${param.catalogId}"/>
		<c:param name="langId" value="${param.langId}"/>
		<c:param name="errorViewName" value="ListOrdersDisplay"/>													    					    							    	
</c:url>

<c:set var="pageSize" value="${maxOrderItemsPerPage}"/>
<c:if test="${empty pageSize}">
	<c:set var="pageSize" value="20"/>
</c:if>
<c:set var="currentPage" value="${WCParam.currentPage}"/>
<c:if test="${empty currentPage}">
	<c:set var="currentPage" value="1"/>
</c:if>

<wcbase:useBean id="orderBean" classname="com.ibm.commerce.order.beans.OrderDataBean" scope="page">
<c:set target="${orderBean}" property="orderId" value="${param.orderId}"/>
<c:set target="${orderBean}" property="pageSize" value="${pageSize}"/>
<c:set target="${orderBean}" property="currentPage" value="${currentPage}"/>
</wcbase:useBean>

<%-- get pageSize from OrderDataBean again - if passed in page size is greater than max value, pageSize will set to max value --%>
<c:set var="pageSize" value="${orderBean.pageSize}"/>

<%-- Order description field --%>
<c:set var="orderDescription" value="${orderBean.description}" />
<c:if test="${param.multipleActiveOrders}" >
	<table width="100%" cellpadding="0" cellspacing="0" border="0" id="WC_CurrentOrderDisplayCartSection_Table_1">
		<tr>
	        	<td id="WC_CurrentOrderDisplayCartSection_TableCell_1">  
				<label for="WC_CurrentOrderDisplayCartSection_Input_1"><fmt:message key="YourOrder_Description" bundle="${storeText}"/></label>
			</td>
		</tr>
		<tr>
	        	<td id="WC_CurrentOrderDisplayCartSection_TableCell_2">
	       			<input id="WC_CurrentOrderDisplayCartSection_Input_1" class="input" type="text" size="50" name="orderDesc" value="<c:out value="${orderDescription}" />" >
	        		<span class="t_rght_space">
	        		<a href="javascript:UpdateTotal(document.ShopCartForm)" class="button" id="WC_CurrentOrderDisplayCartSection_Link_1">
	        			<fmt:message key="YourOrder_Update" bundle="${storeText}"/>
				</a>
				</span>
	        		<span class="t_rght_space">
	       			<img src="<c:out value="${jspStoreImgDir}"/>images/ps_v_line.gif" alt="" width="7" height="22" border="0">
	        		</span>
	        	
			    <%-- Order Copy icon --%>
			    <c:if test="${param.multipleActiveOrders}" >
			    	<span class="t_rght_space">
			    	<a href="<c:out value='${OrderCopyUrl}'/>" class="button" id="WC_MiniCurrentOrderDisplay_Link_2">
					<fmt:message key="ListOrders_Copy" bundle="${storeText}"/>
			    	</a>
			    	</span>   
			    </c:if>
			    <%-- Order Cancel icon --%> 
			    <c:choose>
			    	<c:when test="${param.multipleActiveOrders}">
			    		<c:choose> 
						<c:when test="${orderRn eq currentPendingOrderId && numberOfOrders > 1}">			                                  				 
							<%-- If the order being removed is the current pending order --%>
							<%-- then set the current pending order to the first order on the pending order list --%>
							<span class="t_rght_space">
							<a onclick="return confirmRemove()" class="button" href="<c:out value="${orderCancelSetPendingURL}"/>" id="WC_MiniCurrentOrderDisplay_Link_3">
								<fmt:message key="ListOrders_Remove" bundle="${storeText}"/>
							</a>
							</span>
						</c:when>
						<c:otherwise>
							<span class="t_rght_space">
							<a onclick="return confirmRemove()" class="button" href="<c:out value="${orderCancelURL}"/>" id="WC_MiniCurrentOrderDisplay_Link_4">
								<fmt:message key="ListOrders_Remove" bundle="${storeText}"/>
							</a>
							</span>
						</c:otherwise>
					</c:choose>
			    	</c:when>
			    	<c:otherwise>
			    		<span class="t_rght_space">
			    		<a onclick="return confirmRemove()" class="button" href="<c:out value="${orderCancelOrderItemDisplayURL}"/>" id="WC_MiniCurrentOrderDisplay_Link_5">
						<fmt:message key="ListOrders_Remove" bundle="${storeText}"/>
					</a>
					</span>
			    	</c:otherwise>
			    </c:choose>
		</tr>
	</table>
</c:if>
<c:set var="showContracts" value="true"/>	                    
<%@ include file="../../Snippets/Order/Cart/CurrentOrderDisplay.jspf"%>
