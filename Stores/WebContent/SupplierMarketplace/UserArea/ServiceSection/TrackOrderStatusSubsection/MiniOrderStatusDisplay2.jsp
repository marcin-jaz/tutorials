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
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf"%>

<!-- BEGIN MiniOrderStatusDisplay2.jsp -->
<fmt:message key="HUD_MiniOrdersPreviouslyProcessedDisplay" var="HUDFrameTitle" bundle="${storeText}" />
<c:url var="maximizeURL" value="TrackOrderStatus">
	<c:param name="langId" value="${langId}" />
	<c:param name="storeId" value="${storeId}" />
	<c:param name="catalogId" value="${catalogId}" />
</c:url>
<% out.flush(); %>
<c:import url="${jspStoreDir}${StyleDir}HUDContainerTop.jsp" >
	<c:param name="HUDFrameTitle" value="${HUDFrameTitle}" />
	<c:param name="maximizeURL" value="${maximizeURL}" />
</c:import>
<% out.flush(); %>

<c:url var="TrackOrderStatusURL" value="TrackOrderStatus">
	<c:param name="langId" value="${langId}" />
	<c:param name="storeId" value="${storeId}" />
	<c:param name="catalogId" value="${catalogId}" />
</c:url>
<c:forTokens items="${requestScope.requestURIPath}" delims="/" var="URLtoken">
	<c:set var="ReloadURL" value="${URLtoken}"/>
</c:forTokens>

<c:set var="pageToDisplay" value="${param.CIPOrderStatus2Page}" />
<c:if test="${empty pageToDisplay}">
	<c:set var="pageToDisplay" value="1" />
</c:if>
<c:set var="pageSize" value="5"/>
<c:set var="sRowColor" value="cellBG_2"/>

<!--content start-->

		<wcbase:useBean id="orderListBean2" classname="com.ibm.commerce.order.beans.OrderListDataBean">
			<c:set target="${orderListBean2}" property="currentPage" value="${pageToDisplay}"/>
			<c:set target="${orderListBean2}" property="pageSize" value="${pageSize}"/>
			<c:set target="${orderListBean2}" property="sortMethodId" value="7"/>
			<c:set target="${orderListBean2}" property="storeId" value="${storeId}"/>
			<c:set target="${orderListBean2}" property="userId" value="${userId}"/>
			<c:set target="${orderListBean2}" property="retrievalOrderStatus" value="N,M,B,C,R,S,D,A"/>
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

<c:choose>
	<c:when test="${orderListBean2.numberOfOrders > 0}">
		<table cellpadding="0" cellspacing="0" border="0" width="100%" class="bgColor" id="WC_MiniOrderStatusDisplay2_Table_3">
			<tbody>
				<tr>
					<td id="WC_MiniOrderStatusDisplay2_TableCell_4" class="portlet_content">
				<table width="100%" border="0" cellpadding="2" cellspacing="1" id="WC_MiniOrderStatusDisplay2_Table_4_1">
					<tbody>
						<tr class="bgColor">
							<td valign="top" class="portlet_colHeader" id="WC_MiniOrderStatusDisplay2_TableCell_4_1">
								<fmt:message key="Status_Col7" bundle="${storeText}" />
							</td>
							<td valign="top" class="portlet_colHeader" id="WC_MiniOrderStatusDisplay2_TableCell_4_2">
								<fmt:message key="Status_Col8" bundle="${storeText}" />
							</td>
							<%--
							<td valign="top" class="portlet_colHeader" id="WC_MiniOrderStatusDisplay2_TableCell_4_3">
								<fmt:message key="Status_Col9" bundle="${storeText}" />
							</td>
							<td valign="top" class="portlet_colHeader" id="WC_MiniOrderStatusDisplay2_TableCell_4_4">
								<fmt:message key="Status_Col10" bundle="${storeText}" />
							</td>
							--%>
							<td valign="top" class="portlet_colHeader" id="WC_MiniOrderStatusDisplay2_TableCell_4_5">
								<fmt:message key="Status_Col11" bundle="${storeText}" />
							</td>
							<td valign="top" class="portlet_colHeader" id="WC_MiniOrderStatusDisplay2_TableCell_4_6">
								&nbsp;
							</td>
						</tr>
			         <c:forEach var="orderBean"  items="${orderBeanList2}" varStatus="j">
			         	<c:set var="poNumber" value="${orderBean.purchaseOrderNumber}"/>
			         	<c:if test="${empty poNumber}">
						<fmt:message key="Status_none" bundle="${storeText}" var="poNumber"/>
					</c:if>		      
					
					<c:url value="OrderDetail" var="OrderDetailUrl">
						<c:param name="orderId" value="${orderBean.orderId}"/>
						<c:param name="orderStatusCode" value="${orderBean.status}"/>
						<c:param name="storeId" value="${storeId}"/>
						<c:param name="catalogId" value="${catalogId}"/>
						<c:param name="langId" value="${langId}"/>							
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
	                        	<td align="center" id="WC_MiniOrderStatusDisplay2_TableCell_32_<c:out value='${j.count}'/>" class="<c:out value='${sRowColor}'/> portlet_content">
	                        		<a href="<c:out value='${OrderDetailUrl}'/>" id="WC_MiniOrderStatusDisplay2_Link_2" class="portlet_content">
	                        			<c:out value="${orderBean.orderId}"/>
	                        		</a>
	                        	</td>
	                        	<td id="WC_MiniOrderStatusDisplay2_TableCell_33_<c:out value='${j.count}'/>" class="<c:out value='${sRowColor}'/> portlet_content">
	                        		<c:out value='${orderBean.formattedOrderPlacedTime}'/>
	                        	</td>
	                        	<%--
	                        	<td id="WC_MiniOrderStatusDisplay2_TableCell_34_<c:out value='${j.count}'/>" class="<c:out value='${sRowColor}'/> portlet_content">
	                        		<c:out value="${poNumber}"/>
	                        	</td>
	                        	<td id="WC_MiniOrderStatusDisplay2_TableCell_35_<c:out value='${j.count}'/>" class="<c:out value='${sRowColor}'/> portlet_content">
	                        		<fmt:message key="Status_${orderBean.status}" bundle="${storeText}"/>
	                        	</td>
	                        	--%>
	                        	<td class="<c:out value='${sRowColor}'/> portlet_price" id="WC_MiniOrderStatusDisplay2_TableCell_36_<c:out value='${j.count}'/>">
	                        		<c:out value="${orderBean.grandTotal}" escapeXml="false"/>
	                        	</td>
					<c:choose>
						<%--
						 Only show the re-order link for orders that are not originated from RFQ
						--%>
						<c:when test="${!orderBean.RFQOrder}">
							<c:url value="OrderCopy" var="OrderCopyUrl">
								<c:param name="fromOrderId_1" value="${orderBean.orderId}"/>
								<c:param name="toOrderId" value=".**."/>
								<c:param name="copyOrderItemId_1" value="*"/>
								<c:param name="URL" value="OrderCalculate?URL=OrderItemDisplay?updatePrices=1&calculationUsageId=-1"/>
								<c:param name="storeId" value="${storeId}"/>
								<c:param name="catalogId" value="${catalogId}"/>
								<c:param name="langId" value="${langId}"/>
								<c:param name="errorViewName" value="TrackOrderStatus"/>				    							    	
							</c:url>
			                          	<td id="WC_MiniOrderStatusDisplay2_TableCell_37_<c:out value='${j.count}'/>" class="<c:out value='${sRowColor}'/> portlet_content">
			                          		<a href="<c:out value='${OrderCopyUrl}'/>" id="WC_MiniOrderStatusDisplay2_Link_4" class="portlet_content">
			                          			<fmt:message key="Status_Link1" bundle="${storeText}" />
			                          		</a>
			                          	</td>
		                          	</c:when>
	                          		<c:otherwise>	
	                          			<td id="WC_MiniOrderStatusDisplay2_TableCell_38_<c:out value='${j.count}'/>" class="<c:out value='${sRowColor}'/> portlet_content">&nbsp;</td>
	                          		</c:otherwise>
	                          	</c:choose>
                        		</tr>
				</c:forEach>
				
				<c:if test="${rowsTotal > pageSize}">
					<c:choose>
					    	<c:when test="${sRowColor ne 'cellBG_1'}">
					    		<c:set var="sRowColor" value="cellBG_1"/>
					    	</c:when>
					    	<c:otherwise>
					    		<c:set var="sRowColor" value="cellBG_2"/>
					    	</c:otherwise>
					</c:choose>
					<c:url var="ReloadWithParametersNextPageURL" value="${ReloadURL}">
						<c:forEach var="parameter" items="${WCParamValues}" >
							<c:if test="${parameter.key != 'CIPOrderStatus2Page' && parameter.key != 'logonPassword'}">
								<c:param name="${parameter.key}">
								<c:forEach var="value" items="${parameter.value}" >
									<c:out value="${value}" />
								</c:forEach>
								</c:param>
							</c:if>
						</c:forEach>
						<c:param name="CIPOrderStatus2Page" value="${pageToDisplay+1}"/>
					</c:url>
					<c:url var="ReloadWithParametersPrevPageURL" value="${ReloadURL}">
						<c:forEach var="parameter" items="${WCParamValues}" >
							<c:if test="${parameter.key != 'CIPOrderStatus2Page' && parameter.key != 'logonPassword'}">
								<c:param name="${parameter.key}">
								<c:forEach var="value" items="${parameter.value}" >
									<c:out value="${value}" />
								</c:forEach>
								</c:param>
							</c:if>
						</c:forEach>
						<c:param name="CIPOrderStatus2Page" value="${pageToDisplay-1}"/>
					</c:url>
						<tr class="<c:out value="${sRowColor}"/>"> 
							<td colspan="4" class="portlet_content" id="WC_MiniOrderStatusDisplay2_TableCell_39">
								<fmt:message key="HUD_Page_Results" bundle="${storeText}">
									<fmt:param value="${rowStart + 1}"/>
									<fmt:param value="${rowStart + rowsDisplayed}"/>
									<fmt:param value="${rowsTotal}"/>
								</fmt:message>
								<c:if test="${pageToDisplay > 1}">
									&nbsp;
									<a href="<c:out value="${ReloadWithParametersPrevPageURL}" />" id="WC_MiniOrderStatusDisplay2_Link_5" class="portlet_content"
									><fmt:message key="HUD_Page_Prev" bundle="${storeText}" /></a>
								</c:if>
								<c:if test="${rowsTotal > (rowStart + rowsDisplayed)}">
									&nbsp;
									<a href="<c:out value="${ReloadWithParametersNextPageURL}" />" id="WC_MiniOrderStatusDisplay2_Link_6" class="portlet_content"
									><fmt:message key="HUD_Page_Next" bundle="${storeText}" /></a>
								</c:if>
								<br/>
								<a href="<c:out value="${TrackOrderStatusURL}" />" id="WC_MiniOrderStatusDisplay2_Link_7" class="portlet_content">
									<fmt:message key="HUD_More" bundle="${storeText}" />
								</a>
							</td>
						</tr>
					</c:if>
					</tbody>
				</table>	
			</td>
		</tr>
	</tbody>
</table>
	</c:when>
	<c:otherwise>
		<table cellpadding="0" cellspacing="0" border="0" width="100%" id="WC_MiniOrderStatusDisplay2_Table_5">
			<tbody>
				<tr>
					<td id="WC_MiniOrderStatusDisplay2_TableCell_40" class="portlet_content">
						<fmt:message key="Status_No_Orders_Found_2" bundle="${storeText}" />
					</td>
				</tr>
			</tbody>
		</table>		
	</c:otherwise>
</c:choose>
<% out.flush(); %>
<c:import url="${jspStoreDir}${StyleDir}HUDContainerBottom.jsp" />
<% out.flush(); %>
<!--content end-->
<!-- END MiniOrderStatusDisplay2.jsp -->
