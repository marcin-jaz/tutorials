<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2008, 2009 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>
<%-- 
  *****
  * This JSP file renders editable shipping information on the single shipment shipping and billing page of the
  * checkout flow. Information shown includes: shipping method, shipping instructions, requested shipping date
  * and ship as complete. 
  *****
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf"%>


<c:set var="isAjaxCheckOut" value="true"/>
<%-- Check if its a non-ajax checkout..--%>
<flow:ifDisabled feature="AjaxCheckout"> 
	<c:set var="isAjaxCheckOut" value="false"/>
</flow:ifDisabled>


<script type="text/javascript">
	dojo.addOnLoad(function() {
		SBServicesDeclarationJS.setCommonParameters('<c:out value='${WCParam.langId}'/>','<c:out value='${WCParam.storeId}'/>','<c:out value='${WCParam.catalogId}'/>');
		SBServicesDeclarationJS.setAjaxCheckOut('<c:out value='${isAjaxCheckOut}'/>');
	});
</script>

<c:set var="order" value="${requestScope.order}" />
<c:if test="${empty order || order==null}">
	<wcf:getData type="com.ibm.commerce.order.facade.datatypes.OrderType"
		var="order" expressionBuilder="findCurrentShoppingCartWithPagingOnItem" varShowVerb="ShowVerbShipment" maxItems="${pageSize}" recordSetStartNumber="${beginIndex}" recordSetReferenceId="ostatus">
		<wcf:param name="accessProfile" value="IBM_Details" />	 
		<wcf:param name="sortOrderItemBy" value="orderItemID" />
		<wcf:param name="isSummary" value="false" />
	</wcf:getData>
</c:if>


<c:set var="pageSize" value="${WCParam.pageSize}" />
<c:if test="${empty pageSize}">
	<c:set var="pageSize" value="${maxOrderItemsPerPage}"/>
</c:if>

<c:set var="beginIndex" value="${WCParam.beginIndex}" />
 <c:if test="${empty beginIndex}">
	<c:set var="beginIndex" value="0" />
</c:if>

<c:set var="shipDetails" value="${requestScope.orderUsableShipping}"/>
<c:if test="${empty shipDetails || shipDetails==null}">
	<c:choose>
		<c:when test="${empty param.orderId || param.orderId == null}">
			<wcf:getData type="com.ibm.commerce.order.facade.datatypes.OrderType"
			   var="shipDetails" expressionBuilder="findCurrentShoppingCart">
			   <wcf:param name="accessProfile" value="IBM_UsableShippingInfo" />
			</wcf:getData>
	</c:when>
	<c:otherwise>
		<wcf:getData type="com.ibm.commerce.order.facade.datatypes.OrderType"
		   		var="shipDetails" expressionBuilder="findUsableShippingInfoWithPagingOnItem" varShowVerb="ShowVerbUsableShippingInfo" maxItems="${pageSize}" recordSetStartNumber="${beginIndex}" recordSetReferenceId="usistatus" scope="request">
			<wcf:param name="orderId" value="${param.orderId}" />	
			<wcf:param name="accessProfile" value="IBM_UsableShippingInfo" />
		</wcf:getData>	
	</c:otherwise>
	</c:choose>
</c:if>

<%-- get the shipping method --%>
<c:set var="blockShipModeId" value="${order.orderItem[0].orderItemShippingInfo.shippingMode.shippingModeIdentifier.uniqueID}"/>
<%-- do we need to ship all items at once.. is it shipAsComplete...--%>
<c:set var="shipAsCompleteCheckBoxStatus" value="false"/>
<c:if test="${order.shipAsComplete}">
	<c:set var="shipAsCompleteCheckBoxStatus" value="true"/>
</c:if>
<%-- Are there any shipping instructions..If so get them --%>
<c:set var="shipInstructions" value="${order.orderItem[0].orderItemShippingInfo.shippingInstruction}"/>
<c:set var="requestedShipDate" value="${order.orderItem[0].orderItemShippingInfo.requestedShipDate}"/>

<c:catch>
	<fmt:parseDate var="requestedShipDate" value="${requestedShipDate}" pattern="yyyy-MM-dd'T'HH:mm:ss.SSS'Z'" timeZone="GMT"/>
</c:catch>
<c:if test="${empty requestedShipDate}">
	<c:catch>
		<fmt:parseDate var="requestedShipDate" value="${requestedShipDate}" pattern="yyyy-MM-dd'T'HH:mm:ss'Z'" timeZone="GMT"/>
	</c:catch>
</c:if>

<%-- use value from WC_timeoffset to adjust to browser time zone --%>
<%-- Format the timezone retrieved from cookie since it is in decimal representation --%>
<%-- Convert the decimals back to the correct timezone format such as :30 and :45 --%>
<%-- Only .75 and .5 are converted as currently these are the only timezones with decimals --%>	
<c:set var="formattedTimeZone" value="${fn:replace(cookie.WC_timeoffset.value, '%2B', '+')}"/>
<c:set var="formattedTimeZone" value="${fn:replace(formattedTimeZone, '.75', ':45')}"/>	
<c:set var="formattedTimeZone" value="${fn:replace(formattedTimeZone, '.5', ':30')}"/>
<fmt:formatDate value="${requestedShipDate}" type="date" pattern="yyyy-MM-dd" var="formattedReqShipDate" dateStyle="long" timeZone="${formattedTimeZone}"/>

<!-- If shipping instructions are empty, then hide the div which displays the date and instructions -->
<c:choose>
	<c:when test="${empty shipInstructions && empty requestedShipDate}">
		<c:set var="divDisplayStyle" value="none"/>
		<c:set var="checkBoxStatus" value="false"/>
	</c:when>
	<c:otherwise>
		<c:set var="divDisplayStyle" value="block"/>
		<c:set var="checkBoxStatus" value="true"/>
	</c:otherwise>
</c:choose>
<c:set var="shipModeMap" value="${requestScope.shipModeMap}"/>

<!-- this will update the Shipping info(Instructions, shipAsComplete and requested ship date) for each orderItem -->
<div class="shipping_method" id="WC_SingleShipmentShippingMethodDetails_div_1">
	<p class="title">
		<label for="singleShipmentShippingMode"><fmt:message key="SHIP_SHIPPING_METHOD" bundle="${storeText}"/></label>:
	</p>
	<p>
		<select class="drop_down" name="singleShipmentShippingMode" id="singleShipmentShippingMode" onchange="JavaScript:setCurrentId('singleShipmentShippingMode'); CheckoutHelperJS.updateShipModeForAllItems(this)">
			<c:forEach var="shippingMode" items="${shipDetails.orderItem[0].usableShippingMode}">
				<c:set var="shippingModeIdentifier" value="${shippingMode.shippingModeIdentifier}"/>
			
				<c:if test="${shippingModeIdentifier.externalIdentifier.shipModeCode != 'PickupInStore' && (!b2bStore || (b2bStore && shipModeMap[shippingModeIdentifier.uniqueID] == param.recordSetTotal))}">
					
					<%-- Show all the shipping options available except for pickUp in Store --%>
					<%-- This block is to select the shipMode Id in the drop down box.. if this shipMode is selected then set selected = true --%>
					<option <c:if test="${(shippingModeIdentifier.uniqueID eq blockShipModeId)}">selected="selected"</c:if> value="<c:out value='${shippingModeIdentifier.uniqueID}'/>">
						<c:out value="${shippingMode.description.value}"/>
					</option>
				</c:if>				
			</c:forEach>
		</select>
	</p>
	<flow:ifEnabled feature="ShippingChargeType">
		<%out.flush();%>
		<div id="WC_SingleShipmentDisplay_ShipCharge_Area" dojoType="wc.widget.RefreshArea" widgetId="singleShipmentShipCharge"  controllerId="singleShipmentShipChargeController" role="wairole:region" waistate:live="polite" waistate:atomic="true" waistate:relevant="text">
				<c:import url="${jspStoreDir}ShoppingArea/CheckoutSection/SingleShipment/SingleShipmentShipChargeExt.jsp">
					<c:param name="orderId" value="${param.orderId}"/>
				</c:import>	
		</div>
		<script type="text/javascript">dojo.addOnLoad(function() { 
			parseWidget("WC_SingleShipmentDisplay_ShipCharge_Area"); 
		});</script>
		<%out.flush();%>
	</flow:ifEnabled>

	<span class="checkbox">
		
			<input type="checkbox" class="checkbox" id="shipAsComplete" name = "shipAsComplete" onclick="setCurrentId('shipAsComplete'); CheckoutHelperJS.shipAsComplete(this)"
			<c:if test="${shipAsCompleteCheckBoxStatus}">
				checked="checked"
			</c:if> />
		<span class="text">
			<label for="shipAsComplete"><fmt:message key="SHIP_SHIP_AS_COMPLETE" bundle="${storeText}"/></label>
		</span>
	</span>
	<br />

	<flow:ifEnabled feature="ShippingInstructions">
		<c:choose>
			<c:when test="${empty shipInstructions}">
				<c:set var="shippingInstructionsDivDisplay" value="none"/>
				<c:set var="shippingInstructionsChecked" value="false"/>
			</c:when>
			<c:otherwise>
				<c:set var="shippingInstructionsDivDisplay" value="block"/>
				<c:set var="shippingInstructionsChecked" value="true"/>
			</c:otherwise>
		</c:choose>
		<p>
			<span class="checkbox">
				<label for='shippingInstructionsCheckbox'></label>
				<input type="checkbox" class="checkbox" id="shippingInstructionsCheckbox" name="shippingInstructionsCheckbox" onclick="JavaScript:setCurrentId('shippingInstructionsCheckbox'); CheckoutHelperJS.checkShippingInstructionsBox('shippingInstructionsCheckbox','shippingInstructionsDiv')"
					<c:if test="${shippingInstructionsChecked}">
						checked="checked"
					</c:if>
				/>
				<span class="text">
					<fmt:message key="SHIP_SHIPPING_INSTRUCTIONS_ADD" bundle="${storeText}"/>
				</span>
			</span>
		</p>
		<div name = "shippingInstructionsDiv" id = "shippingInstructionsDiv" style="display:<c:out value='${shippingInstructionsDivDisplay}'/>">
			<p>
			<span>
					<label for="shipInstructions">
						<span style="display:none"><fmt:message key="SHIP_SHIPPING_INSTRUCTIONS_LABEL" bundle="${storeText}"/></span>
					</label>
				
					
					<textarea id="shipInstructions" name="shipInstructions" rows="2" cols="35" onchange="JavaScript:setCurrentId('shipInstructions'); CheckoutHelperJS.updateShippingInstructionsForAllItems()"><c:out value = "${shipInstructions}" /></textarea>
				
			</span>
			</p>
		</div>
	</flow:ifEnabled>
	
	<flow:ifEnabled feature="FutureOrders">
		<c:choose>
			<c:when test="${empty requestedShipDate}">
				<c:set var="requestShippingDateDivDisplay" value="none"/>
				<c:set var="requestShippingDateChecked" value="false"/>
			</c:when>
			<c:otherwise>
				<c:set var="requestShippingDateDivDisplay" value="block"/>
				<c:set var="requestShippingDateChecked" value="true"/>
			</c:otherwise>
		</c:choose>
		<p>
			<span class="checkbox">
				<label for='requestShippingDateCheckbox'></label>
				<input type="checkbox" class="checkbox" id="requestShippingDateCheckbox" name="requestShippingDateCheckbox" onclick="JavaScript:setCurrentId('requestShippingDateCheckbox'); CheckoutHelperJS.checkRequestShippingDateBox('requestShippingDateCheckbox','requestShippingDateDiv')"
					<c:if test="${requestShippingDateChecked}">
						checked="checked"
					</c:if>
				/>
				<span class="text"><fmt:message key="SHIP_REQUESTED_DATE_ADD" bundle="${storeText}"/></span>
			</span>
		</p>
		<div name = "requestShippingDateDiv" id = "requestShippingDateDiv" style="display:<c:out value='${requestShippingDateDivDisplay}'/>">
			<div id="requestedShippingDate_label">
				<label for="requestedShippingDate">
					<span style="display:none"><fmt:message key="SHIP_REQUESTED_DATE_LABEL" bundle="${storeText}" /></span>
				</label>
			</div>
			<div id="requestedShippingDate_inputField" class="dijitCalendarWidth">
				<input 
					id="requestedShippingDate" 
					name="requestedShippingDate" 
					size="6" 
					onchange="JavaScript:setCurrentId('requestedShippingDate'); CheckoutHelperJS.updateRequestedShipDate(this); <c:if test="${!isAjaxCheckOut}">setDirtyFlag()</c:if>" 
					dojoType="dijit.form.DateTextBox" 
					invalidMessage="<fmt:message key="SHIP_REQUESTED_ERROR" bundle="${storeText}"/>"  
					value="<c:out value="${formattedReqShipDate}"/>" 
				/>
				<script type="text/javascript">
					dojo.addOnLoad(function() { parseWidget("requestedShippingDate"); });
				</script>
			</div>
		</div>
	</flow:ifEnabled>
</div>	
