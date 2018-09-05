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

<!-- BEGIN MiniOrderStatusDisplay3.jsp -->
<fmt:message key="HUD_MiniOrdersScheduledDisplay" var="HUDFrameTitle" bundle="${storeText}" />
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
<%--
	Screen out URLs that are not safe to link to upon deleting a Requisition List
--%>
<c:choose>
	<c:when test="${ReloadURL=='OrderDetail'}">
		<c:set var="ReloadURL" value="TrackOrderStatus"/>
	</c:when>
	<c:otherwise>
		<%-- Leave ReloadURL as it is because it should be safe --%>
	</c:otherwise>
</c:choose>
<c:url var="ReloadWithParametersURL" value="${ReloadURL}">
	<c:forEach var="parameter" items="${WCParamValues}" >
		<c:if test="${parameter.key != 'logonPassword'}">
			<c:param name="${parameter.key}">
				<c:forEach var="value" items="${parameter.value}" >
					<c:out value="${value}" />
				</c:forEach>
			</c:param>
		</c:if>
	</c:forEach>
</c:url>

<c:set var="pageToDisplay" value="${param.CIPOrderStatus3Page}" />
<c:if test="${empty pageToDisplay}">
	<c:set var="pageToDisplay" value="1" />
</c:if>
<c:set var="pageSize" value="5"/>
<c:set var="sRowColor" value="cellBG_2"/>

<wcbase:useBean id="schOrderListBean" classname="com.ibm.commerce.order.beans.SchedulerOrderByMemberIdListDataBean" scope="page">
	<c:set target="${schOrderListBean}" property="dataBeanKeyMemberId" value="${userId}"/>
	<c:set target="${schOrderListBean}" property="searchForStoreId" value="${storeId}"/>
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

<!--content start-->
<c:choose>
	<c:when test="${schOrderListBean.numberOfOrders > 0}">
<table cellpadding="0" cellspacing="0" border="0" width="100%" class="bgColor" id="WC_MiniOrderStatusDisplay3_Table_3">
	<tbody>
		<tr>
			<td id="WC_MiniOrderStatusDisplay3_TableCell_4">
				<table width="100%" border="0" cellpadding="2" cellspacing="1" id="WC_MiniOrderStatusDisplay3_Table_4_1">
					<tbody>
						<tr class="bgColor">
							<td valign="top" class="portlet_colHeader" id="WC_MiniOrderStatusDisplay3_TableCell_4_1">
								<fmt:message key="Status_Col13" bundle="${storeText}" />
							</td>
							<%--
							<td valign="top" class="portlet_colHeader" id="WC_MiniOrderStatusDisplay3_TableCell_4_2">
								<fmt:message key="Status_Col15" bundle="${storeText}" />
							</td>
							--%>
							<td valign="top" class="portlet_colHeader" id="WC_MiniOrderStatusDisplay3_TableCell_4_3">
								<fmt:message key="Status_Col16" bundle="${storeText}" />
							</td>
							<td valign="top" class="portlet_colHeader" id="WC_MiniOrderStatusDisplay3_TableCell_4_4">
								<fmt:message key="Status_Col17" bundle="${storeText}" />
							</td>
							<td valign="top" class="portlet_colHeader" id="WC_MiniOrderStatusDisplay3_TableCell_4_5">
								<fmt:message key="Status_Col18" bundle="${storeText}" />
							</td>
							<td valign="top" class="portlet_colHeader" id="WC_MiniOrderStatusDisplay3_TableCell_4_6">
								&nbsp;
							</td>
						</tr>
				<c:forEach var="schOrderBean"  items="${schOrderListBean.schedulerOrderByMemberIdListByPageNumber}" varStatus="i">
				  	<c:set var="intervalKey">
				  		<c:choose>
				  			<c:when test="${schOrderBean.schedulerItemsDataBean.firstInterval eq '86400'}">
				  				<c:out value="OrderSum_Interval_1"/>
				  			</c:when>
				  			<c:when test="${schOrderBean.schedulerItemsDataBean.firstInterval eq '604800'}">
				  			    <c:out value="OrderSum_Interval_2"/>
				  			</c:when>
				  			<c:when test="${schOrderBean.schedulerItemsDataBean.firstInterval eq '120960'}">
				  				<c:out value="OrderSum_Interval_3"/>                          				
				  			</c:when>
				  			<c:when test="${schOrderBean.schedulerItemsDataBean.firstInterval eq '1814400'}">
				  				<c:out value="OrderSum_Interval_4"/>                          				
				  			</c:when>
				  			<c:when test="${schOrderBean.schedulerItemsDataBean.firstInterval eq '2592000'}">
				  				<c:out value="OrderSum_Interval_5"/>                          				
				  			</c:when>
				  			<c:when test="${schOrderBean.schedulerItemsDataBean.firstInterval eq '0'}">
				  				<c:out value="OrderSum_Interval_6"/>                          				
				  			</c:when>                          				                          				                          				                          				                          				
				  		</c:choose>
				  	</c:set>
                  			<c:set var="poNumber" value="${schOrderBean.orderDataBean.purchaseOrderNumber}"/>
					<c:if test="${empty poNumber}">
						<fmt:message key="Status_none" bundle="${storeText}" var="poNumber"/>
					</c:if>
					<c:url value="OrderDetail" var="OrderDetailUrl">
						<c:param name="orderId" value="${schOrderBean.orderId}"/>
						<c:param name="storeId" value="${storeId}"/>
						<c:param name="catalogId" value="${catalogId}"/>
						<c:param name="langId" value="${langId}"/>									
					</c:url> 
					<c:url value="ScheduledOrderCancel" var="ScheduledOrderCancelUrl">
						<c:param name="orderId" value="${schOrderBean.orderId}"/>
						<c:param name="URL" value="OrderCancel?URL=${ReloadWithParametersURL}" />
						<c:param name="errorViewName" value="TrackOrderStatus"/>	
					</c:url>
					<c:choose>
				        	<c:when test="${sRowColor ne 'cellBG_1'}">
				        		<c:set var="sRowColor" value="cellBG_1"/>
				       		</c:when>
				        	<c:otherwise>
				        		<c:set var="sRowColor" value="cellBG_2"/>
				        	</c:otherwise>
				        </c:choose>
				        <fmt:message var="schOrderCancelConfirmMini" key="Status_OrderCancel_Confirm" bundle="${storeText}"/>
						<tr>
                            <td align="center" id="WC_MiniOrderStatusDisplay3_TableCell_54_<c:out value='${i.count}'/>" class="<c:out value='${sRowColor}'/> portlet_content">
                            	<a href="<c:out value='${OrderDetailUrl}'/>" id="WC_MiniOrderStatusDisplay3_Link_5_<c:out value='${i.count}'/>" class="portlet_content">
                            		<c:out value="${schOrderBean.orderId}"/>
                            	</a>
                            </td>
                            <%--
                            <td id="WC_MiniOrderStatusDisplay3_TableCell_55_<c:out value='${i.count}'/>" class="<c:out value='${sRowColor}'/> portlet_content">
                            	<c:out value="${poNumber}"/>
                            </td>
                            --%>
                            <td class="<c:out value='${sRowColor}'/> portlet_price" id="WC_MiniOrderStatusDisplay3_TableCell_56_<c:out value='${i.count}'/>">
                            	<c:out value="${schOrderBean.orderDataBean.grandTotal}" escapeXml="false"/>
                            </td>
                            <td id="WC_MiniOrderStatusDisplay3_TableCell_57_<c:out value='${i.count}'/>" class="<c:out value='${sRowColor}'/>portlet_content">
                            	<fmt:message key="${intervalKey}" bundle="${storeText}"/>
                            </td>
                            <td id="WC_MiniOrderStatusDisplay3_TableCell_58_<c:out value='${i.count}'/>" class="<c:out value='${sRowColor}'/> portlet_content">
                            	<c:out value="${schOrderBean.schedulerItemsDataBean.formattedStart}"/>
                            </td>
                            <td id="WC_MiniOrderStatusDisplay3_TableCell_59_<c:out value='${i.count}'/>" class="<c:out value='${sRowColor}'/> portlet_content">
                            	<a href="<c:out value='${ScheduledOrderCancelUrl}'/>"  onclick="return confirm('<%=com.ibm.commerce.tools.util.UIUtil.toJavaScript(pageContext.getAttribute("schOrderCancelConfirmMini"))%>');" class="portlet_content" id="WC_MiniOrderStatusDisplay3_Link_6_<c:out value='${i.count}'/>">
									<fmt:message key="Status_Button2" bundle="${storeText}" />
								</a>
							</td>
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
								<c:if test="${parameter.key != 'CIPOrderStatus3Page' && parameter.key != 'logonPassword'}">
									<c:param name="${parameter.key}">
										<c:forEach var="value" items="${parameter.value}" >
											<c:out value="${value}" />
										</c:forEach>
									</c:param>
								</c:if>
							</c:forEach>
							<c:param name="CIPOrderStatus3Page" value="${pageToDisplay+1}"/>
						</c:url>
						<c:url var="ReloadWithParametersPrevPageURL" value="${ReloadURL}">
							<c:forEach var="parameter" items="${WCParamValues}" >
								<c:if test="${parameter.key != 'CIPOrderStatus3Page' && parameter.key != 'logonPassword'}">
									<c:param name="${parameter.key}">
										<c:forEach var="value" items="${parameter.value}" >
											<c:out value="${value}" />
										</c:forEach>
									</c:param>
								</c:if>
							</c:forEach>
							<c:param name="CIPOrderStatus3Page" value="${pageToDisplay-1}"/>
						</c:url>
						<tr class="<c:out value="${sRowColor}"/>"> 
							<td colspan="5" class="portlet_content" id="WC_MiniOrderStatusDisplay3_TableCell_60">
								<fmt:message key="HUD_Page_Results" bundle="${storeText}">
									<fmt:param value="${rowStart + 1}"/>
									<fmt:param value="${rowStart + rowsDisplayed}"/>
									<fmt:param value="${rowsTotal}"/>
								</fmt:message>
								<c:if test="${pageToDisplay > 1}">
									&nbsp;
									<a href="<c:out value="${ReloadWithParametersPrevPageURL}" />" id="WC_MiniOrderStatusDisplay3_Link_7" class="portlet_content"
									><fmt:message key="HUD_Page_Prev" bundle="${storeText}" /></a>
								</c:if>
								<c:if test="${rowsTotal > (rowStart + rowsDisplayed)}">
									&nbsp;
									<a href="<c:out value="${ReloadWithParametersNextPageURL}" />" id="WC_MiniOrderStatusDisplay3_Link_8" class="portlet_content"
									><fmt:message key="HUD_Page_Next" bundle="${storeText}" /></a>
								</c:if>
								<br/>
								<a href="<c:out value="${TrackOrderStatusURL}" />" id="WC_MiniOrderStatusDisplay3_Link_9" class="portlet_content">
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
		<table cellpadding="0" cellspacing="0" border="0" width="100%" id="WC_MiniOrderStatusDisplay3_Table_5">
			<tbody>
				<tr>
					<td id="WC_MiniOrderStatusDisplay3_TableCell_61" class="portlet_content">
						<fmt:message key="Status_No_Orders_Found" bundle="${storeText}" />
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
<!-- END MiniOrderStatusDisplay3.jsp -->
