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
<%@ include file="../../include/JSTLEnvironmentSetup.jspf"%>

<!-- BEGIN MiniEmptyOrderDisplay.jsp -->

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

<flow:ifEnabled feature="customerCare"> 
<script language="javascript">
			if (typeof parent.setShoppingCartItems == 'function')
				parent.setShoppingCartItems(0);
</script>
</flow:ifEnabled> 
<c:set var="multipleActiveOrders" value="false" />
<flow:ifEnabled feature="MultipleActiveOrders">
	<c:set var="multipleActiveOrders" value="true" />
</flow:ifEnabled>

<c:set var="sRowColor" value="cellBG_1"/>
<table cellpadding="0" cellspacing="0" border="0" width="100%" id="WC_MiniEmptyOrderDisplay_Table_1">
	<tbody>
		<tr class="<c:out value="${sRowColor}"/>" >
			<td id="WC_MiniEmptyOrderDisplay_TableCell_1" class="portlet_content">				
				<c:choose>       
				<c:when test="${multipleActiveOrders}" >
					<%-- message to show if multipleActiveOrders enabled --%>
					<fmt:message key="YourOrder_Err_MiniEmptyCOOrder" bundle="${storeText}" />
				</c:when>
				<c:otherwise>
					<%-- message to show if multipleActiveOrders disabled --%>
					<fmt:message key="YourOrder_Err_EmptyOrder" bundle="${storeText}" />				
				</c:otherwise>
				</c:choose>
			</td>
		</tr> 
		<tr class="<c:out value="${sRowColor}"/>" >
			<td id="WC_MiniEmptyOrderDisplay_TableCell_1" class="portlet_content">				  
				<c:if test="${multipleActiveOrders}" >
				<%-- show List Active Orders button if multipleActiveOrders enabled --%>
				<c:url var="ListOrdersDisplayURL" value="ListOrdersDisplay">
					<c:param name="langId" value="${langId}" />
					<c:param name="storeId" value="${storeId}" />
					<c:param name="catalogId" value="${catalogId}" />									
				</c:url>
				<br />
				<a href="<c:out value="${ListOrdersDisplayURL}" />" class="button" id="WC_MiniEmptyOrderDisplay_Link_1">
					<fmt:message key="ListOrders_Title" bundle="${storeText}" />
				</a>
				</c:if>
				<%-- end - show List Active Orders button --%>				
			</td>
		</tr>
	</tbody>
</table>
<% out.flush(); %>
<c:import url="${jspStoreDir}${StyleDir}HUDContainerBottom.jsp" />
<% out.flush(); %>
<!-- END MiniEmptyOrderDisplay.jsp -->
