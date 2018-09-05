<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2007, 2009 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.ibm.commerce.bi.taglib.TagUtils" %>
<%@ page import="com.ibm.commerce.command.CommandContext" %>
<%@ page import="com.ibm.commerce.server.ECConstants" %>
<%@ page import="com.ibm.commerce.datatype.WcParam" %>

<%
// check to see if the wcparam is available; initialise it if it is not available
if( null == request.getAttribute(com.ibm.commerce.server.ECConstants.EC_INPUT_PARAM)){
	request.setAttribute(com.ibm.commerce.server.ECConstants.EC_INPUT_PARAM, new WcParam(request));
}
WcParam wcParam = (WcParam)request.getAttribute(com.ibm.commerce.server.ECConstants.EC_INPUT_PARAM);
CommandContext commandContext = (CommandContext) request.getAttribute(ECConstants.EC_COMMANDCONTEXT);
Integer storeId = commandContext.getStoreId();
%>

<wcf:getData type="com.ibm.commerce.order.facade.datatypes.OrderType" var="order" expressionBuilder="findCurrentShoppingCart">
       <wcf:param name="accessProfile" value="IBM_Details" />
</wcf:getData>
<%-- insert into acaction values(-99999, 'AnalyticsShopcartView', 0);
insert into acactactgp values (10401, -99999, NULL, 0);
--%>
[
	{ cart: [

			<c:forEach var="orderItem" items="${order.orderItem}" varStatus="loopStatus">
				{
					<c:remove var="catEntry"/>
					<wcbase:useBean id="catEntry" classname="com.ibm.commerce.catalog.beans.CatalogEntryDataBean">
						<c:set target="${catEntry}" property="catalogEntryID" value="${orderItem.catalogEntryIdentifier.uniqueID}"/>
					</wcbase:useBean>
					
					<c:if test="${catEntry.product}">
						<c:set var="catEnt" value="${catEntry.productDataBean}"/>
					</c:if>
					<c:if test="${catEntry.item}">
						<c:choose>
							<c:when test="${catEntry.itemDataBean.parentProductDataBean != null}">
								<c:set var="catEnt" value="${catEntry.itemDataBean.parentProductDataBean}"/>							
							</c:when>
							<c:otherwise>
								<c:set var="catEnt" value="${catEntry.itemDataBean}"/>
							</c:otherwise>
						</c:choose>
					</c:if>					
					<c:if test="${catEntry.package}">
						<c:set var="catEnt" value="${catEntry.packageDataBean}"/>
					</c:if>					
					<c:if test="${catEntry.bundle}">
						<c:set var="catEnt" value="${catEntry.bundleDataBean}"/>
					</c:if>										
					<c:if test="${catEntry.dynamicKit}">
						<c:set var="catEnt" value="${catEntry.dynamicKitDataBean}"/>
					</c:if>
					
					productId: '<c:out value="${catEnt.partNumber}"/>', 
					
					<c:set var="singleQuote" value="'"/>
					<c:set var="escapedSingleQuote" value="\\\\'"/>
					<c:set var="doubleQuote" value="\""/>
					<c:set var="escapedDoubleQuote" value="\\\\\""/>

					<c:remove var="itemName"/>
					<c:set var="itemName" value="${fn:replace(catEnt.description.name, singleQuote, escapedSingleQuote)}"/>
					<c:set var="itemName" value="${fn:replace(itemName, doubleQuote, escapedDoubleQuote)}"/>
					name: '<c:out value="${itemName}" escapeXml="false"/>',
					quantity: '<c:out value="${orderItem.quantity.value}"/>',
					<c:set var="price" value="${orderItem.orderItemAmount.orderItemPrice.value}"/>
					<c:forEach var="adjustment" items="${orderItem.orderItemAmount.adjustment}">
						<c:set var="price" value="${price + adjustment.amount.value}"/>
					</c:forEach>
					<c:set var="price" value="${price / orderItem.quantity.value}"/>
					price: '<fmt:formatNumber value="${price}"  maxFractionDigits="2" minFractionDigits="2"/>', 
					currency: '<c:out value="${orderItem.orderItemAmount.orderItemPrice.currency}"/>', 
					
					<%-- code that gets category and master category --%>
					<%
					  Long productId = Long.valueOf(catEntry.getCatalogEntryID());
						
		        try {
							com.ibm.commerce.catalog.objects.CatalogEntryRelationAccessBean rel = new com.ibm.commerce.catalog.objects.CatalogEntryRelationAccessBean();
							java.util.Enumeration catEntryParents = rel.findByCatalogEntryChildIdAndStore(productId, storeId);
							while(catEntryParents.hasMoreElements()){
								productId = ((com.ibm.commerce.catalog.objects.CatalogEntryRelationAccessBean)catEntryParents.nextElement()).getCatalogEntryIdParentInEJBType();
								catEntryParents = rel.findByCatalogEntryChildIdAndStore(productId, storeId);
							}
		        }catch(Exception e) {
		           // a page should never throw an exception
		        }
	       %>
	       
				 category: '<%=TagUtils.getCategoryID(commandContext, productId)%>',
				 masterCategory: '<%=TagUtils.getMasterCategoryId(commandContext, productId)%>',
				 <c:remove var="catEntry"/>
				 storeId: '<%=storeId%>'
				}<c:if test="${!loopStatus.last}">,</c:if>
			</c:forEach>
		]
	}
]
