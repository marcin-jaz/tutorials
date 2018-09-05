<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2001, 2009 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>
<%--
  *****
  *
  * This JSP page displays the Order Status page with the following elements:
  *  - List of Orders waiting for approval.  For each order on the list, the following is displayed
  *			- Order Number, Last Updated, Purchase Order, Total Price
  *  - List of Orders already processed.  For each order on the list, the following is displayed
  *			- Order Number, Order Date, Purchase Order, Status, Total Price and a Re-Order link
  *  - List of Orders Scheduled.  For each scheduled order, the following is displayed
  * 		- Order Number, Purchase Order, Total Price, Frequency, Start Date and Order Cancel link
  *  - In each list, 'Order Number' is a link to the Order Details page for that order
  *
  *
  * How to use this snippet?
  *	<c:import url="../../../Snippets/Order/Cart/OrderStatusTableDisplay.jsp" >
  *		<c:param name= "showScheduledOrders" value="false"/>
  *		<c:param name= "showOrdersAwaitingApproval" value="false"/>
  *		<c:param name= "showPONumber" value="false"/>
  *	</c:import>
  *
  *****
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ include file="../OrderEnvironmentSetup.jspf"%>
<%@ include file="../../../include/ErrorMessageSetup.jspf"%>

<c:if test="${param.showScheduledOrders}">
	<c:set var="showScheduledOrders" value="true" />
</c:if>
<c:if test="${param.showOrdersAwaitingApproval}">
	<c:set var="showOrdersAwaitingApproval" value="true" />
</c:if>
<c:if test="${param.showPONumber}">
	<c:set var="showPONumber" value="true" />
</c:if>

<!--content start-->
<table cellpadding="0" width="100%" cellspacing="0" class="noBorder" id="WC_OrderStatusDisplay_Table_2">
	<%--
	 ***
	 *	Start: Error handling
	 * Show an appropriate error message to handle problems during product re-order
	 ***
	--%>
		<c:if test="${!empty errorMessage}">
			<span class="error"><br/><c:out value="${errorMessage}"/><br/><br/></span>
		</c:if>
	<%--
	  ***
	  *	End: Error handling
	  ***
	--%>
<tbody>
<c:if test="${showOrdersAwaitingApproval}">
	<%--
	***
	* Start: List of orders awaiting approval
	***
	--%>
    <tr>
      <td id="WC_OrderStatusDisplay_TableCell_3">


	<c:set var="pageToDisplay" value="${WCParam.OrderStatus1Page}" />
	<c:if test="${empty pageToDisplay}">
		<c:set var="pageToDisplay" value="1" />
	</c:if>
	<c:set var="pageSize" value="20"/>
	<c:set var="sRowColor" value="cellBG_2"/>

	<h2><fmt:message key="OrderStatus_WaitingForApproval" bundle="${orderText}" /><h2>
	
        <table width="100%" class="bgColor" border="0" cellpadding="2" cellspacing="1" id="WC_OrderStatusDisplay_Table_4">
                <tr>
                    <th valign="top" class="colHeader" id="WC_OrderStatusDisplay_TableCell_6"><fmt:message key="OrderStatus_OrderNumber" bundle="${orderText}" /></th>
                   	<th valign="top" class="colHeader" id="WC_OrderStatusDisplay_TableCell_8"><fmt:message key="OrderStatus_LastUpdated" bundle="${orderText}" /></th>
                   	<c:if test="${showPONumber}">
                    	<th valign="top" class="colHeader" id="WC_OrderStatusDisplay_TableCell_10"><fmt:message key="OrderStatus_PO" bundle="${orderText}" /></th>
                    </c:if>
                    <th class="colHeader_price" id="WC_OrderStatusDisplay_TableCell_12"><span class="t_hd_rght"><fmt:message key="OrderStatus_TotalPrice" bundle="${orderText}" /></span></th>
                </tr>

		<wcbase:useBean id="orderListBean1" classname="com.ibm.commerce.order.beans.OrderListDataBean">
			<c:set target="${orderListBean1}" property="currentPage" value="${pageToDisplay}"/>
      <c:set target="${orderListBean1}" property="pageSize" value="${pageSize}"/>
      <c:set target="${orderListBean1}" property="sortMethodId" value="7"/>
			<c:set target="${orderListBean1}" property="storeId" value="${CommandContext.storeId}"/>
			<c:set target="${orderListBean1}" property="retrievalOrderStatus" value="W"/>
			<c:set target="${orderListBean1}" property="userId" value="${CommandContext.userId}"/>
		</wcbase:useBean>
		
		<%-- get pageSize from OrderListDataBean again - if passed in page size is greater than max value, pageSize will set to max value --%>
		<c:set var="pageSize" value="${orderListBean1.pageSize}"/>
		
		<c:set var="orderBeanList"  value="${orderListBean1.orderDataBeansForCurrentPage}" />

    <c:set var="rowStart" value="${(pageToDisplay-1)*pageSize}"/>
    <c:set var="rowsTotal" value="${orderListBean1.numberOfOrders}"/>
    <c:choose>
	  	<c:when test="${((pageToDisplay)*pageSize) > rowsTotal}">
	         	<c:set var="rowsDisplayed" value="${rowsTotal-rowStart}"/>
	    </c:when>
	    <c:otherwise>
	         	<c:set var="rowsDisplayed" value="${pageSize}"/>
	    </c:otherwise>
		</c:choose>

    <c:set var="ordersCount" value="${orderListBean1.numberOfOrders}" />
    <c:forEach var="orderBean"  items="${orderBeanList}" varStatus="j" >
			<c:set var="poNumber" value="${orderBean.purchaseOrderNumber}"/>
			<c:if test="${empty poNumber}">
				<fmt:message key="OrderStatus_none" bundle="${orderText}" var="poNumber"/>
			</c:if>
			<c:url value="OrderDetail" var="OrderDetailUrl">
				<c:param name="orderId" value="${orderBean.orderId}"/>
				<c:param name="orderStatusCode" value="${orderBean.status}"/>
				<c:param name="storeId" value="${WCParam.storeId}"/>
				<c:param name="catalogId" value="${WCParam.catalogId}"/>
				<c:param name="langId" value="${WCParam.langId}"/>
			</c:url>
      <c:choose>
				<c:when test="${sRowColor ne 'cellBG_1'}">
				  <c:set var="sRowColor" value="cellBG_1"/>
				</c:when>
				<c:otherwise>
				  <c:set var="sRowColor" value="cellBG_2"/>
				</c:otherwise>
			</c:choose>
                   <tr>
                       <td headers="WC_OrderStatusDisplay_TableCell_6" class="<c:out value='${sRowColor}'/> t_td" align="center" id="WC_OrderStatusDisplay_TableCell_13_<c:out value='${j.count}'/>"><a href="<c:out value='${OrderDetailUrl}'/>" id="WC_OrderStatusDisplay_Link_1"><c:out value="${orderBean.orderId}"/></a></td>
                       <td headers="WC_OrderStatusDisplay_TableCell_8" class="<c:out value='${sRowColor}'/> t_td" id="WC_OrderStatusDisplay_TableCell_14_<c:out value='${j.count}'/>"><c:out value='${orderBean.formattedLastUpdateTime}'/></td>
                       <c:if test="${showPONumber}">
                       	<td headers="WC_OrderStatusDisplay_TableCell_10" class="<c:out value='${sRowColor}'/> t_td" id="WC_OrderStatusDisplay_TableCell_15_<c:out value='${j.count}'/>"><c:out value="${poNumber}"/></td>
                       </c:if>
                       <td headers="WC_OrderStatusDisplay_TableCell_12" class="<c:out value='${sRowColor}'/> t_td price" id="WC_OrderStatusDisplay_TableCell_16_<c:out value='${j.count}'/>"><c:out value='${orderBean.grandTotal}' escapeXml="false"/></td>
                   </tr>
		</c:forEach>

		  <c:if test="${ordersCount == 0}">
              <tr>
                   <td colspan="4" class="cellBG_1 t_td" id="WC_OrderStatusDisplay_TableCell_17"><p><fmt:message key="OrderStatus_No_Orders_Found" bundle="${orderText}" /></p></td>
              </tr>
	      </c:if>


				<c:if test="${rowsDisplayed < rowsTotal}">
	                <c:url var="ReloadWithParametersNextPageURL" value="${TrackOrderStatus}">
						<c:forEach var="parameter" items="${WCParamValues}" >
							<c:if test="${parameter.key != 'OrderStatus1Page'}">
								<c:param name="${parameter.key}">
									<c:forEach var="value" items="${parameter.value}" >
										<c:out value="${value}" />
									</c:forEach>
								</c:param>
							</c:if>
						</c:forEach>
						<c:param name="OrderStatus1Page" value="${pageToDisplay+1}"/>
					</c:url>
					<c:url var="ReloadWithParametersPrevPageURL" value="${TrackOrderStatus}">
						<c:forEach var="parameter" items="${WCParamValues}" >
							<c:if test="${parameter.key != 'OrderStatus1Page'}">
								<c:param name="${parameter.key}">
									<c:forEach var="value" items="${parameter.value}" >
										<c:out value="${value}" />
									</c:forEach>
								</c:param>
							</c:if>
						</c:forEach>
						<c:param name="OrderStatus1Page" value="${pageToDisplay-1}"/>
					</c:url>
					<c:choose>
				    	<c:when test="${sRowColor ne 'cellBG_1'}">
				    		<c:set var="sRowColor" value="cellBG_1"/>
				    	</c:when>
				    	<c:otherwise>
				    		<c:set var="sRowColor" value="cellBG_2"/>
				    	</c:otherwise>
				    </c:choose>
				    <tr class="<c:out value="${sRowColor}"/>">
						<td colspan="4" id="WC_OrderStatusDisplay_TableCell_17a">
						<fmt:message key="OrderStatus_Page_Results" bundle="${orderText}">
							<fmt:param value="${rowStart + 1}"/>
							<fmt:param value="${rowStart + rowsDisplayed}"/>
							<fmt:param value="${rowsTotal}"/>
						</fmt:message>
						<c:if test="${pageToDisplay > 1}">
							&nbsp;
							<a href="<c:out value="${ReloadWithParametersPrevPageURL}" />" id="WC_OrderStatusDisplay_Link_17b">
								<fmt:message key="OrderStatus_Page_Prev" bundle="${orderText}" />
							</a>
						</c:if>
						<c:if test="${rowsTotal > (rowStart + rowsDisplayed)}">
							&nbsp;
							<a href="<c:out value="${ReloadWithParametersNextPageURL}" />" id="WC_OrderStatusDisplay_Link_17c">
								<fmt:message key="OrderStatus_Page_Next" bundle="${orderText}" />
							</a>
						</c:if>
						</td>
					</tr>
				</c:if>
                   </table>
                    </td>
                  </tr>
			<%--
			***
			* End: List of orders awaiting approval
			***
			--%>
</c:if>
<!--secondtable-->
			<%--
			***
			* Start: List of orders already processed
			***
			--%>

			<c:set var="pageToDisplay" value="${WCParam.OrderStatus2Page}" />
			<c:if test="${empty pageToDisplay}">
				<c:set var="pageToDisplay" value="1" />
			</c:if>
			<c:set var="pageSize" value="20"/>
			<c:set var="sRowColor" value="cellBG_2"/>
            <tr>
    	      <td id="WC_OrderStatusDisplay_TableCell_18">
    	      <h2><fmt:message key="OrderStatus_PrevProcessed" bundle="${orderText}" /></h2>
              <table width="100%" class="bgColor" border="0" cellpadding="2" cellspacing="1" id="WC_OrderStatusDisplay_Table_10">
                        <tr>
                              <th valign="top" class="colHeader" id="WC_OrderStatusDisplay_TableCell_21"><fmt:message key="OrderStatus_OrderNumber" bundle="${orderText}" /></th>
                              <th valign="top" width="100" class="colHeader" id="WC_OrderStatusDisplay_TableCell_23"><fmt:message key="OrderStatus_OrderDate" bundle="${orderText}" /></th>
                              <c:if test="${showPONumber}">
                              	<th valign="top" class="colHeader" id="WC_OrderStatusDisplay_TableCell_25"><fmt:message key="OrderStatus_PO" bundle="${orderText}" /></th>
                              </c:if>
                              <th class="colHeader" id="WC_OrderStatusDisplay_TableCell_27"><fmt:message key="OrderStatus_Status" bundle="${orderText}" /></th>
                              <th class="colHeader_price" id="WC_OrderStatusDisplay_TableCell_29"><span class="t_hd_rght"><fmt:message key="OrderStatus_TotalPrice" bundle="${orderText}" /></span></th>
                              <th valign="top" class="colHeader_last" id="WC_OrderStatusDisplay_TableCell_31"></th>
                        </tr>
                        
		<wcbase:useBean id="orderListBean2" classname="com.ibm.commerce.order.beans.OrderListDataBean">
			<c:set target="${orderListBean2}" property="currentPage" value="${pageToDisplay}"/>
      <c:set target="${orderListBean2}" property="pageSize" value="${pageSize}"/>
      <c:set target="${orderListBean2}" property="sortMethodId" value="7"/>
			<c:set target="${orderListBean2}" property="storeId" value="${CommandContext.storeId}"/>
			<c:set target="${orderListBean2}" property="retrievalOrderStatus" value="N,M,A,B,C,R,S,D,F,G"/>
			<c:set target="${orderListBean2}" property="userId" value="${CommandContext.userId}"/>
		</wcbase:useBean>
		
		<%-- get pageSize from OrderListDataBean again - if passed in page size is greater than max value, pageSize will set to max value --%>
		<c:set var="pageSize" value="${orderListBean2.pageSize}"/>

		<c:set var="orderBeanList2"  value="${orderListBean2.orderDataBeansForCurrentPage}" />

         <c:set var="rowStart" value="${(pageToDisplay-1)*pageSize}"/>
         <c:set var="rowsTotal" value="${orderListBean2.numberOfOrders}"/>
         <c:choose>
	         <c:when test="${((pageToDisplay)*pageSize) > rowsTotal}">
	         	<c:set var="rowsDisplayed" value="${rowsTotal-rowStart}"/>
	         </c:when>
	         <c:otherwise>
	         	<c:set var="rowsDisplayed" value="${pageSize}"/>
	         </c:otherwise>
	     </c:choose>


         <c:set var="ordersCount2" value="${orderListBean2.numberOfOrders}" />
         <c:forEach var="orderBean"  items="${orderBeanList2}" varStatus="j">
						<c:set var="poNumber" value="${orderBean.purchaseOrderNumber}"/>
						<c:choose>
						<c:when test="${!orderBean.blocked}" >
						<c:if test="${empty poNumber}">
							<fmt:message key="OrderStatus_none" bundle="${orderText}" var="poNumber"/>
						</c:if>
						<c:url value="OrderDetail" var="OrderDetailUrl">
							<c:param name="orderId" value="${orderBean.orderId}"/>
							<c:param name="orderStatusCode" value="${orderBean.status}"/>
							<c:param name="storeId" value="${WCParam.storeId}"/>
							<c:param name="catalogId" value="${WCParam.catalogId}"/>
							<c:param name="langId" value="${WCParam.langId}"/>
						</c:url>
                        <c:choose>
				        	<c:when test="${sRowColor ne 'cellBG_1'}">
				        		<c:set var="sRowColor" value="cellBG_1"/>
				        	</c:when>
				        	<c:otherwise>
				        		<c:set var="sRowColor" value="cellBG_2"/>
				        	</c:otherwise>
				        </c:choose>
                    	<tr>
                          <td headers="WC_OrderStatusDisplay_TableCell_21" class="<c:out value='${sRowColor}'/> t_td" align="center" id="WC_OrderStatusDisplay_TableCell_32_<c:out value='${j.count}'/>"><a href="<c:out value='${OrderDetailUrl}'/>" id="WC_OrderStatusDisplay_Link_2_<c:out value='${j.count}'/>"><c:out value="${orderBean.orderId}"/></a></td>
                          <td headers="WC_OrderStatusDisplay_TableCell_23" class="<c:out value='${sRowColor}'/> t_td" id="WC_OrderStatusDisplay_TableCell_33_<c:out value='${j.count}'/>"><c:out value='${orderBean.formattedOrderPlacedTime}'/></td>
                          <c:if test="${showPONumber}">
                          	<td headers="WC_OrderStatusDisplay_TableCell_25" class="<c:out value='${sRowColor}'/> t_td" id="WC_OrderStatusDisplay_TableCell_34_<c:out value='${j.count}'/>"><c:out value="${poNumber}"/><a id="WC_OrderStatusDisplay_Link_3"></a></td>
                          </c:if>
                          <td headers="WC_OrderStatusDisplay_TableCell_27" class="<c:out value='${sRowColor}'/> t_td" id="WC_OrderStatusDisplay_TableCell_35_<c:out value='${j.count}'/>">
                  		<fmt:message key="OrderStatus_${orderBean.status}" bundle="${orderText}"/>
                          </td>
                          <td headers="WC_OrderStatusDisplay_TableCell_29" class="<c:out value='${sRowColor}'/> t_td price" id="WC_OrderStatusDisplay_TableCell_36_<c:out value='${j.count}'/>"><c:out value='${orderBean.grandTotal}' escapeXml='false'/></td>
						  <c:choose>
						  <c:when test="${!orderBean.RFQOrder}">
						    <c:url value="OrderCopy" var="OrderCopyUrl">
						    	<c:param name="fromOrderId_1" value="${orderBean.orderId}"/>
						    	<c:param name="toOrderId" value=".**."/>
						    	<c:param name="copyOrderItemId_1" value="*"/>
						    	<c:param name="URL" value="OrderCalculate?URL=OrderItemDisplay?updatePrices=1&calculationUsageId=-1"/>
						    	<c:param name="storeId" value="${WCParam.storeId}"/>
								<c:param name="catalogId" value="${WCParam.catalogId}"/>
								<c:param name="langId" value="${WCParam.langId}"/>
								<c:param name="errorViewName" value="TrackOrderStatus"/>
						    </c:url>
                          	<td headers="WC_OrderStatusDisplay_TableCell_31" class="<c:out value='${sRowColor}'/> t_td" id="WC_OrderStatusDisplay_TableCell_37_<c:out value='${j.count}'/>"><a href="<c:out value='${OrderCopyUrl}'/>" class="t_button" id="WC_OrderStatusDisplay_Link_4_<c:out value='${j.count}'/>"><fmt:message key="OrderStatus_ReOrder" bundle="${orderText}" /></a></td>
                          </c:when>
                          <c:otherwise>
                          	<td headers="WC_OrderStatusDisplay_TableCell_31" class="<c:out value='${sRowColor}'/> t_td" id="WC_OrderStatusDisplay_TableCell_38_<c:out value='${j.count}'/>">&nbsp;</td>
                          </c:otherwise>
                          </c:choose>
                        </tr>
                        </c:when>
                        <c:otherwise>
                        <c:set var="ordersCount2" value="${ordersCount-1}" />
                        </c:otherwise>
                        </c:choose>

		</c:forEach>

		<c:if test="${ordersCount2 == 0}">
                        <tr>
                          <td class="cellBG_1 t_td" colspan="6" id="WC_OrderStatusDisplay_TableCell_39"><p><fmt:message key="OrderStatus_No_Orders_Found" bundle="${orderText}" /></p></td>
                        </tr>
		</c:if>
		
                <c:if test="${rowsDisplayed < rowsTotal}">
	                <c:url var="ReloadWithParametersNextPageURL" value="${TrackOrderStatus}">
						<c:forEach var="parameter" items="${WCParamValues}" >
							<c:if test="${parameter.key != 'OrderStatus2Page'}">
								<c:param name="${parameter.key}">
									<c:forEach var="value" items="${parameter.value}" >
										<c:out value="${value}" />
									</c:forEach>
								</c:param>
							</c:if>
						</c:forEach>
						<c:param name="OrderStatus2Page" value="${pageToDisplay+1}"/>
					</c:url>
					<c:url var="ReloadWithParametersPrevPageURL" value="${TrackOrderStatus}">
						<c:forEach var="parameter" items="${WCParamValues}" >
							<c:if test="${parameter.key != 'OrderStatus2Page'}">
								<c:param name="${parameter.key}">
									<c:forEach var="value" items="${parameter.value}" >
										<c:out value="${value}" />
									</c:forEach>
								</c:param>
							</c:if>
						</c:forEach>
						<c:param name="OrderStatus2Page" value="${pageToDisplay-1}"/>
					</c:url>
					<c:choose>
				    	<c:when test="${sRowColor ne 'cellBG_1'}">
				    		<c:set var="sRowColor" value="cellBG_1"/>
				    	</c:when>
				    	<c:otherwise>
				    		<c:set var="sRowColor" value="cellBG_2"/>
				    	</c:otherwise>
				    </c:choose>
				    <tr class="<c:out value="${sRowColor}"/>">
						<td colspan="6" id="WC_OrderStatusDisplay_TableCell_39a">
						<fmt:message key="OrderStatus_Page_Results" bundle="${orderText}">
							<fmt:param value="${rowStart + 1}"/>
							<fmt:param value="${rowStart + rowsDisplayed}"/>
							<fmt:param value="${rowsTotal}"/>
						</fmt:message>
						<c:if test="${pageToDisplay > 1}">
							&nbsp;
							<a href="<c:out value="${ReloadWithParametersPrevPageURL}" />" id="WC_OrderStatusDisplay_Link_39b">
								<fmt:message key="OrderStatus_Page_Prev" bundle="${orderText}" />
							</a>
						</c:if>
						<c:if test="${rowsTotal > (rowStart + rowsDisplayed)}">
							&nbsp;
							<a href="<c:out value="${ReloadWithParametersNextPageURL}" />" id="WC_OrderStatusDisplay_Link_39c">
								<fmt:message key="OrderStatus_Page_Next" bundle="${orderText}" />
							</a>
						</c:if>
						</td>
					</tr>
				</c:if>
						</table>
					</td>
                  </tr>

			<%--
			***
			* End: List of orders already processed
			***
			--%>

<!--Third Table Start-->
<c:if test="${showScheduledOrders}">


			<%--
			***
			* Start: List of scheduled orders
			***
			--%>

			<c:set var="pageToDisplay" value="${WCParam.OrderStatus3Page}" />
			<c:if test="${empty pageToDisplay}">
				<c:set var="pageToDisplay" value="1" />
			</c:if>
			<c:set var="pageSize" value="20"/>
			<c:set var="sRowColor" value="cellBG_2"/>

<!---Scheduled Orders Code Started--->
	         <wcbase:useBean id="schOrderListBean" classname="com.ibm.commerce.order.beans.SchedulerOrderByMemberIdListDataBean" scope="page">
	         	<c:set target="${schOrderListBean}" property="dataBeanKeyMemberId" value="${CommandContext.userId}"/>
	         	<c:set target="${schOrderListBean}" property="searchForStoreId" value="${CommandContext.storeId}"/>
	         	<c:set target="${schOrderListBean}" property="currentPage" value="${pageToDisplay}"/>
         	    <c:set target="${schOrderListBean}" property="pageSize" value="${pageSize}"/>
	         </wcbase:useBean>
	     <c:set var="rowStart" value="${(pageToDisplay-1)*pageSize}"/>
         <c:set var="rowsTotal" value="${schOrderListBean.numberOfOrders}"/>
         <c:choose>
	         <c:when test="${((pageToDisplay)*pageSize) > rowsTotal}">
	         	<c:set var="rowsDisplayed" value="${rowsTotal-rowStart}"/>
	         </c:when>
	         <c:otherwise>
	         	<c:set var="rowsDisplayed" value="${pageSize}"/>
	         </c:otherwise>
	     </c:choose>


            <tr>
    	      <td id="WC_OrderStatusDisplay_TableCell_40">
    	      	<h2><fmt:message key="OrderStatus_Scheduled" bundle="${orderText}" /></h2>
    		  <table cellpadding="0" cellspacing="0" border="0" width="100%" class="bgColor" id="WC_OrderStatusDisplay_Table_17">
    		    <tbody><tr>
    		      <td id="WC_OrderStatusDisplay_TableCell_41">
                        <table width="100%" class="bgColor" border="0" cellpadding="2" cellspacing="1" id="WC_OrderStatusDisplay_Table_18">
                          <tbody>
                          <tr>
                    		  <th valign="top" class="colHeader" id="WC_OrderStatusDisplay_TableCell_43"><fmt:message key="OrderStatus_OrderNumber" bundle="${orderText}" /></th>
                    		  <c:if test="${showPONumber}">
                    		  	<th valign="top" class="colHeader" id="WC_OrderStatusDisplay_TableCell_45"><fmt:message key="OrderStatus_PO" bundle="${orderText}" /></th>
                    			</c:if>
                    		  <th valign="top" class="colHeader_price" id="WC_OrderStatusDisplay_TableCell_47"><span class="t_hd_rght"><fmt:message key="OrderStatus_TotalPrice" bundle="${orderText}" /></span></th>
                    		  <th valign="top" class="colHeader" id="WC_OrderStatusDisplay_TableCell_49"><fmt:message key="OrderStatus_Freq" bundle="${orderText}" /></th>
                    		  <th valign="top" class="colHeader" id="WC_OrderStatusDisplay_TableCell_51"><fmt:message key="OrderStatus_StartDate" bundle="${orderText}" /></th>
                    		  <th valign="top" class="colHeader_last" id="WC_OrderStatusDisplay_TableCell_53"></th>
                          </tr>
                          <c:forEach var="schOrderBean"  items="${schOrderListBean.schedulerOrderByMemberIdListByPageNumber}" varStatus="i">
                          <c:if test="${schOrderBean.orderDataBean.storeEntityId eq CommandContext.storeId}">
                          		<c:set var="intervalKey">
                          			<c:choose>
                          				<c:when test="${schOrderBean.schedulerItemsDataBean.firstInterval eq '86400'}">
                          					<c:out value="OrderStatus_Interval_1"/>
                          				</c:when>
                          				<c:when test="${schOrderBean.schedulerItemsDataBean.firstInterval eq '604800'}">
                          				    <c:out value="OrderStatus_Interval_2"/>
                          				</c:when>
                          				<c:when test="${schOrderBean.schedulerItemsDataBean.firstInterval eq '120960'}">
                          					<c:out value="OrderStatus_Interval_3"/>
                          				</c:when>
                          				<c:when test="${schOrderBean.schedulerItemsDataBean.firstInterval eq '1814400'}">
                          					<c:out value="OrderStatus_Interval_4"/>
                          				</c:when>
                          				<c:when test="${schOrderBean.schedulerItemsDataBean.firstInterval eq '2592000'}">
                          					<c:out value="OrderStatus_Interval_5"/>
                          				</c:when>
                          				<c:when test="${schOrderBean.schedulerItemsDataBean.firstInterval eq '0'}">
                          					<c:out value="OrderStatus_Interval_6"/>
                          				</c:when>
                          			</c:choose>
                          		</c:set>
                          		<c:set var="poNumber" value="${schOrderBean.orderDataBean.purchaseOrderNumber}"/>
								<c:if test="${empty poNumber}">
									<fmt:message key="OrderStatus_none" bundle="${orderText}" var="poNumber"/>
								</c:if>
								<c:url value="OrderDetail" var="OrderDetailUrl">
									<c:param name="orderId" value="${schOrderBean.orderId}"/>
									<c:param name="storeId" value="${WCParam.storeId}"/>
									<c:param name="catalogId" value="${WCParam.catalogId}"/>
									<c:param name="langId" value="${WCParam.langId}"/>
								</c:url>
								<c:url value="TrackOrderStatus" var="TrackOrderStatusURL">
									<c:param name="storeId" value="${WCParam.storeId}"/>
									<c:param name="catalogId" value="${WCParam.catalogId}"/>
									<c:param name="langId" value="${WCParam.langId}"/>
								</c:url>
								<c:url value="OrderCancel" var="OrderCancelUrl">
							    	<c:param name="URL" value="${TrackOrderStatusURL}"/>
							    </c:url>
								<c:url value="ScheduledOrderCancel" var="ScheduledOrderCancelUrl">
									<c:param name="orderId" value="${schOrderBean.orderId}"/>
									<c:param name="URL" value="${OrderCancelUrl}" />
								</c:url>

						  <fmt:message var="schOrderCancelConfirm" key="OrderStatus_OrderCancel_Confirm" bundle="${orderText}"/>
                          <c:choose>
				        	<c:when test="${sRowColor ne 'cellBG_1'}">
				        		<c:set var="sRowColor" value="cellBG_1"/>
				        	</c:when>
				        	<c:otherwise>
				        		<c:set var="sRowColor" value="cellBG_2"/>
				        	</c:otherwise>
				          </c:choose>
                    	  <tr>
                            <td headers="WC_OrderStatusDisplay_TableCell_43" align="center" class="<c:out value='${sRowColor}'/> t_td" id="WC_OrderStatusDisplay_TableCell_54_<c:out value='${i.count}'/>"><a href="<c:out value='${OrderDetailUrl}'/>" id="WC_OrderStatusDisplay_Link_5"><c:out value="${schOrderBean.orderId}"/></a></td>
                            <c:if test="${showPONumber}">
                            	<td headers="WC_OrderStatusDisplay_TableCell_45" class="<c:out value='${sRowColor}'/> t_td" id="WC_OrderStatusDisplay_TableCell_55_<c:out value='${i.count}'/>"><c:out value="${poNumber}"/></td>
                            </c:if>
                            <td headers="WC_OrderStatusDisplay_TableCell_47" class="<c:out value='${sRowColor}'/> t_td price" id="WC_OrderStatusDisplay_TableCell_56_<c:out value='${i.count}'/>"><c:out value="${schOrderBean.orderDataBean.grandTotal}"  escapeXml="false"/></td>
                            <td headers="WC_OrderStatusDisplay_TableCell_49" class="<c:out value='${sRowColor}'/> t_td" id="WC_OrderStatusDisplay_TableCell_57_<c:out value='${i.count}'/>"><fmt:message key="${intervalKey}" bundle="${orderText}"/></td>
                            <td headers="WC_OrderStatusDisplay_TableCell_51" class="<c:out value='${sRowColor}'/> t_td" id="WC_OrderStatusDisplay_TableCell_58_<c:out value='${i.count}'/>"><c:out value="${schOrderBean.schedulerItemsDataBean.formattedStart}"/></td>
                            <td headers="WC_OrderStatusDisplay_TableCell_53" class="<c:out value='${sRowColor}'/> t_td" id="WC_OrderStatusDisplay_TableCell_59_<c:out value='${i.count}'/>">
                            	<a href="<c:out value='${ScheduledOrderCancelUrl}'/>" class="t_button" onclick="return confirm('<%=com.ibm.commerce.tools.util.UIUtil.toJavaScript(pageContext.getAttribute("schOrderCancelConfirm"))%>');">
									<fmt:message key="OrderStatus_CancelButton" bundle="${orderText}" />
								</a>
							</td>
                          </tr>

               </c:if>

</c:forEach>

<c:if test="${empty schOrderListBean.schedulerOrderByMemberIdList[0]}">
                          <tr>
                            <td colspan="6" class="cellBG_1 t_td" id="WC_OrderStatusDisplay_TableCell_60"><p><fmt:message key="OrderStatus_No_Orders_Found" bundle="${orderText}" /></p></td>
                          </tr>
</c:if>

                <c:if test="${rowsDisplayed < rowsTotal}">
	                <c:url var="ReloadWithParametersNextPageURL" value="${TrackOrderStatus}">
						<c:forEach var="parameter" items="${WCParamValues}" >
							<c:if test="${parameter.key != 'OrderStatus3Page'}">
								<c:param name="${parameter.key}">
									<c:forEach var="value" items="${parameter.value}" >
										<c:out value="${value}" />
									</c:forEach>
								</c:param>
							</c:if>
						</c:forEach>
						<c:param name="OrderStatus3Page" value="${pageToDisplay+1}"/>
					</c:url>
					<c:url var="ReloadWithParametersPrevPageURL" value="${TrackOrderStatus}">
						<c:forEach var="parameter" items="${WCParamValues}" >
							<c:if test="${parameter.key != 'OrderStatus3Page'}">
								<c:param name="${parameter.key}">
									<c:forEach var="value" items="${parameter.value}" >
										<c:out value="${value}" />
									</c:forEach>
								</c:param>
							</c:if>
						</c:forEach>
						<c:param name="OrderStatus3Page" value="${pageToDisplay-1}"/>
					</c:url>
					<c:choose>
				    	<c:when test="${sRowColor ne 'cellBG_1'}">
				    		<c:set var="sRowColor" value="cellBG_1"/>
				    	</c:when>
				    	<c:otherwise>
				    		<c:set var="sRowColor" value="cellBG_2"/>
				    	</c:otherwise>
				    </c:choose>
				    <tr class="<c:out value="${sRowColor}"/>">
						<td colspan="6" id="WC_OrderStatusDisplay_TableCell_60a">
						<fmt:message key="OrderStatus_Page_Results" bundle="${orderText}">
							<fmt:param value="${rowStart + 1}"/>
							<fmt:param value="${rowStart + rowsDisplayed}"/>
							<fmt:param value="${rowsTotal}"/>
						</fmt:message>
						<c:if test="${pageToDisplay > 1}">
							&nbsp;
							<a href="<c:out value="${ReloadWithParametersPrevPageURL}" />" id="WC_OrderStatusDisplay_Link_60b">
								<fmt:message key="OrderStatus_Page_Prev" bundle="${orderText}" />
							</a>
						</c:if>
						<c:if test="${rowsTotal > (rowStart + rowsDisplayed)}">
							&nbsp;
							<a href="<c:out value="${ReloadWithParametersNextPageURL}" />" id="WC_OrderStatusDisplay_Link_60c">
								<fmt:message key="OrderStatus_Page_Next" bundle="${orderText}" />
							</a>
						</c:if>
						</td>
					</tr>
				</c:if>

            </tbody></table>
          </td>
        </tr>
      </tbody></table>
      </td>
  </tr>
  </c:if>
<%--
***
* End: List of scheduled orders
***
--%>
	</tbody>
</table> 
 
<!-- Scheduled Orders Code Ended -->


