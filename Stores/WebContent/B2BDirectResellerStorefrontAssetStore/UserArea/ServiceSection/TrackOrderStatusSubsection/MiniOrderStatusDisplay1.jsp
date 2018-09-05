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

<!-- BEGIN MiniOrderStatusDisplay1.jsp -->
<fmt:message key="HUD_MiniOrdersWaitingApprovalDisplay" var="HUDFrameTitle" bundle="${storeText}" />
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

<c:set var="pageToDisplay" value="${param.CIPOrderStatus1Page}" />
<c:if test="${empty pageToDisplay}">
	<c:set var="pageToDisplay" value="1" />
</c:if>
<c:set var="pageSize" value="5"/>
<c:set var="sRowColor" value="cellBG_2"/>


		<wcbase:useBean id="orderListBean1" classname="com.ibm.commerce.order.beans.OrderListDataBean">
	      		<c:set target="${orderListBean1}" property="currentPage" value="${pageToDisplay}"/>
	      		<c:set target="${orderListBean1}" property="pageSize" value="${pageSize}"/>
	        	<c:set target="${orderListBean1}" property="sortMethodId" value="7"/>
	         	<c:set target="${orderListBean1}" property="storeId" value="${storeId}"/>
	         	<c:set target="${orderListBean1}" property="userId" value="${userId}"/>   
	         	<c:set target="${orderListBean1}" property="retrievalOrderStatus" value="W"/>
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

<!--content start-->
<c:choose>
	<c:when test="${orderListBean1.numberOfOrders > 0}">
	
		<table cellpadding="0" cellspacing="0" border="0" width="100%" class="bgColor" id="WC_MiniOrderStatusDisplay1_Table_3">
			<tbody>
				<tr>
					<td id="WC_MiniOrderStatusDisplay1_TableCell_4">
						<table width="100%" border="0" cellpadding="2" cellspacing="1" id="WC_MiniOrderStatusDisplay1_Table_4_1">
							<tbody>
								<tr class="bgColor">
									<td valign="top" class="portlet_colHeader" id="WC_MiniOrderStatusDisplay1_TableCell_4_1">
										<fmt:message key="Status_Col1" bundle="${storeText}" />
									</td>
									<td valign="top" class="portlet_colHeader" id="WC_MiniOrderStatusDisplay1_TableCell_4_2">
										<fmt:message key="Addtoreq_Col2" bundle="${storeText}" />
									</td>
									<td valign="top" class="portlet_colHeader" id="WC_MiniOrderStatusDisplay1_TableCell_4_3">
										<fmt:message key="Status_Col3" bundle="${storeText}" />
									</td>
									<td valign="top" class="portlet_colHeader" id="WC_MiniOrderStatusDisplay1_TableCell_4_4">
										<fmt:message key="Status_Col5" bundle="${storeText}" />
									</td>
								</tr>
								<c:forEach var="orderBean" items="${orderBeanList}" varStatus="j">
									<c:set var="poNumber" value="${orderBean.purchaseOrderNumber}"/>
									<c:if test="${empty poNumber}">
										<fmt:message key="Status_none" bundle="${storeText}"	var="poNumber" />
									</c:if>
																			
									<c:url value="OrderDetail" var="OrderDetailUrl">
										<c:param name="orderId" value="${orderBean.orderId}" />
										<c:param name="orderStatusCode" value="${orderBean.status}" />
										<c:param name="storeId" value="${storeId}" />
										<c:param name="catalogId" value="${catalogId}" />
										<c:param name="langId" value="${langId}" />
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
										<td align="center" id="WC_MiniOrderStatusDisplay1_TableCell_13_<c:out value='${j.count}'/>" class="<c:out value='${sRowColor}'/> portlet_content">
											<a href="<c:out value='${OrderDetailUrl}'/>" id="WC_MiniOrderStatusDisplay1_Link_1" class="portlet_content">
												<c:out value="${orderBean.orderId}" />
											</a>
										</td>
										<td id="WC_MiniOrderStatusDisplay1_TableCell_14_<c:out value='${j.count}'/>" class="<c:out value='${sRowColor}'/> portlet_content">
											<c:out value='${orderBean.formattedLastUpdateTime}' />
										</td>
										<td id="WC_MiniOrderStatusDisplay1_TableCell_15_<c:out value='${j.count}'/>" class="<c:out value='${sRowColor}'/> portlet_content">
											<c:out value="${poNumber}" />
										</td>
										<td class="<c:out value='${sRowColor}'/> portlet_price" id="WC_MiniOrderStatusDisplay1_TableCell_16_<c:out value='${j.count}'/>">
											<c:out value="${orderBean.grandTotal}" escapeXml="false"/>
										</td>
									</tr>
								</c:forEach>
															
								<c:if test="${rowsTotal > pageSize}">
									<c:url var="ReloadWithParametersNextPageURL" value="${ReloadURL}">
										<c:forEach var="parameter" items="${WCParamValues}" >
											<c:if test="${parameter.key != 'CIPOrderStatus1Page' && parameter.key != 'logonPassword'}">
												<c:param name="${parameter.key}">
													<c:forEach var="value" items="${parameter.value}" >
														<c:out value="${value}" />
													</c:forEach>
												</c:param>
											</c:if>
										</c:forEach>
										<c:param name="CIPOrderStatus1Page" value="${pageToDisplay+1}"/>
									</c:url>
									<c:url var="ReloadWithParametersPrevPageURL" value="${ReloadURL}">
										<c:forEach var="parameter" items="${WCParamValues}" >
											<c:if test="${parameter.key != 'CIPOrderStatus1Page' && parameter.key != 'logonPassword'}">
												<c:param name="${parameter.key}">
													<c:forEach var="value" items="${parameter.value}" >
														<c:out value="${value}" />
													</c:forEach>
												</c:param>
											</c:if>
										</c:forEach>
										<c:param name="CIPOrderStatus1Page" value="${pageToDisplay-1}"/>
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
										<td colspan="4" class="portlet_content" id="WC_MiniOrderStatusDisplay1_TableCell_17">
											<fmt:message key="HUD_Page_Results" bundle="${storeText}">
												<fmt:param value="${rowStart + 1}"/>
												<fmt:param value="${rowStart + rowsDisplayed}"/>
												<fmt:param value="${rowsTotal}"/>
											</fmt:message>
											<c:if test="${pageToDisplay > 1}">
												&nbsp;
												<a href="<c:out value="${ReloadWithParametersPrevPageURL}" />" id="WC_MiniOrderStatusDisplay1_Link_2" class="portlet_content">
													<fmt:message key="HUD_Page_Prev" bundle="${storeText}" />
												</a>
											</c:if>
											<c:if test="${rowsTotal > (rowStart + rowsDisplayed)}">
												&nbsp;
												<a href="<c:out value="${ReloadWithParametersNextPageURL}" />" id="WC_MiniOrderStatusDisplay1_Link_3" class="portlet_content">
													<fmt:message key="HUD_Page_Next" bundle="${storeText}" />
												</a>
											</c:if>
											<br/>
											<a href="<c:out value="${TrackOrderStatusURL}" />" id="WC_MiniOrderStatusDisplay1_Link_4" class="portlet_content">
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
		<table cellpadding="0" cellspacing="0" border="0" width="100%" id="WC_MiniOrderStatusDisplay1_Table_5">
			<tbody>
				<tr>
					<td id="WC_MiniOrderStatusDisplay1_TableCell_18" class="portlet_content">
						<fmt:message key="Status_No_Orders_Found_2"	bundle="${storeText}" />
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
<!-- END MiniOrderStatusDisplay1.jsp -->
