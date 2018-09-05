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
  * This page shows express checkout form.  The following information is shown:
  *  - Ship to selection (with create new address option)
  *  - Shipping method selection
  *  - Requested ship date selection
  *  - Expedite selection
  *  - Shipping instructions
  *****
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../include/JSTLEnvironmentSetup.jspf" %>

<c:if test="${param.showInstructions eq 'true'}" >
	<c:set var="showInstructions" value="true"/>
</c:if>
<c:if test="${param.showRequestedShipdate eq 'true'}" >
	<c:set var="showRequestedShipdate" value="true"/>
</c:if>
<c:if test="${param.showExpedite eq 'true'}" >
	<c:set var="showExpedite" value="true"/>
</c:if>

		<tr>
			<td id="WC_CurrentOrderDisplayExpressSection_TableCell_1">
				<h2><fmt:message key="YourOrder_ExpressCheckout_ShippingOptions" bundle="${storeText}" /></h2>
			</td>
		</tr>
		<tr>
			<td id="WC_CurrentOrderDisplayExpressSection_TableCell_2">
				<c:url var="AddressFormUrl" value="AddressForm">
					<c:param name="catalogId" value="${param.catalogId}"/>
					<c:param name="orderId" value="${param.orderId}"/>
					<c:param name="returnView" value="OrderItemDisplay"/>
					<c:param name="storeId" value="${param.storeId}"/>
					<c:param name="langId" value="${langId}"/>
				</c:url>
				<a href="<c:out value="${AddressFormUrl}"/>" class="button" id="WC_CurrentOrderDisplayExpressSection_Link1">
					<fmt:message key="YourOrder_ExpressCheckout_CreateAddress" bundle="${storeText}"/>
				</a>
			</td>
		</tr>
		<tr>
			<td id="WC_CurrentOrderDisplayExpressSection_TableCell_3">
				&nbsp;
			</td>
		</tr>
			
		<wcbase:useBean id="orderBean" classname="com.ibm.commerce.order.beans.OrderDataBean">
			<c:set value="${param.orderId}" target="${orderBean}" property="orderId"/>
		</wcbase:useBean>
	
		<c:forEach items="${orderBean.allowableShippingAddress}" var="address" varStatus="addressStatus">
			<c:if test="${ !(address.selfAddress && empty address.country) }" >
				<c:set var="hasAddress"  value="true"/>
			</c:if>
		</c:forEach>
		
		<c:if test="${!empty orderBean.orderItemDataBeans}">
			<c:if test="${ !empty orderBean.orderItemDataBeans[0].currentAddressDataBean}" >
				<c:set var="orderShippingAddressId" value="${orderBean.orderItemDataBeans[0].currentAddressDataBean.addressId}" />
			</c:if>
		</c:if>
		
		<c:choose>
			<c:when test="${hasAddress}">
				<tr>
					<td id="WC_CurrentOrderDisplayExpressSection_TableCell_4">
						<label for="WC_CurrentOrderDisplayExpressSection_FormInput_expressAddressId_In_CurrentOrderPage_1"><fmt:message key="YourOrder_ExpressCheckout_ShipTo" bundle="${storeText}" /></label>
					</td>
				</tr>
				<tr>
					<td id="WC_CurrentOrderDisplayExpressSection_TableCell_5">
						<select class="select" id="WC_CurrentOrderDisplayExpressSection_FormInput_expressAddressId_In_CurrentOrderPage_1" name="expressAddressId">
						<c:forEach items="${orderBean.allowableShippingAddress}" var="address" varStatus="status">
							<c:if test="${!(address.selfAddress && empty address.country) && address.addressId != billingAddressId && address.addressId != shippingAddressId && address.nickName != defaultShipping && address.nickName != defaultBilling}" >	
								<c:choose>
									<c:when test="${address.addressId == orderShippingAddressId}">
										<c:set var="selection" value="selected"/>
										<c:set var="shipaddr_applied" value="true"/>
										<c:set var="selectedAddress" value="${address}"/>
									</c:when>
									<c:when test="${!shipaddr_applied && status.last}">
										<c:set var="selection" value="selected" />
										<c:set var="selectedAddress" value="${address}"/>
									</c:when>		
									<c:otherwise>
										<c:set var="selection" value=""/>
									</c:otherwise>
								</c:choose>
								<%--
								***
								* If this is the last address and shipping address wasn't selected
								* before, select the last address as default.
								***
								--%>
								<option value="<c:out value="${address.addressId}"/>" <c:out value="${selection}"/>="<c:out value="${selection}"/>"><c:out value="${address.nickName}" /></option>			
							</c:if>
						</c:forEach>
						</select>
					</td>
				</tr>
				
				<tr>
					<td id="WC_CurrentOrderDisplayExpressSection_TableCell_6">
						&nbsp;
					</td>
				</tr>
				<tr>
					<td id="WC_CurrentOrderDisplayExpressSection_TableCell_7">
						<label for="WC_CurrentOrderDisplayExpressSection_FormInput_expressShipModeId_In_CurrentOrderPage_1"><fmt:message key="YourOrder_ExpressCheckout_ShippingMethod" bundle="${storeText}" /></label>
					</td>
				</tr>	
				<tr>
					<td id="WC_CurrentOrderDisplayExpressSection_TableCell_8">
					<c:if test="${!empty orderBean.orderItemDataBeans}">
						<c:if test="${ !empty orderBean.orderItemDataBeans[0].currentAddressDataBean}" >
							<c:set var="orderItem" value="${orderBean.orderItemDataBeans[0]}" />
						</c:if>
					</c:if>
					<c:set value="${orderItem.allowableShippingModeDataBeans}" var="listOfShipModeId"/>
							<c:set value="${orderItem.shippingModeDataBean.shippingModeId}" var="selectedShipModeId"/>
								<select class="select" id="WC_CurrentOrderDisplayExpressSection_FormInput_expressShipModeId_In_CurrentOrderPage_1" name="expressShipModeId" size="1">
					                    	<c:forEach items="${listOfShipModeId}" var="shipModeId">
						                        <c:set var="aShipModeId" value="${shipModeId.shippingModeId}"/>
						                        <c:set var="shipModeDesc" value="${shipModeId.description}"/>
						                        <c:set var="aShipModeDesc" value="${shipModeDesc.description}"/>
					                        	<c:choose>
					                            		<c:when test="${!empty selectedShipModeId && selectedShipModeId==aShipModeId}">
					                                		<c:set var="sel" value="selected=\"selected\""/>
					                                	</c:when>
					                                	<c:otherwise>
					                                		<c:set var="sel" value=""/>
					                                	</c:otherwise>
					                            	</c:choose>
					                        	<option value="<c:out value="${aShipModeId}"/>" <c:out value="${sel}"/>><c:out value="${aShipModeDesc}"/></option>                     
					                      	</c:forEach>
								</select>
					</td>
				</tr>
				<tr>
					<td id="WC_CurrentOrderDisplayExpressSection_TableCell_9">
						<c:if test="${showRequestedShipdate eq true}" >
							<input type=hidden name="requestedShipDate" value="-- 00:00:00.000000000" />
							<input class="checkbox" type="checkbox" onclick="MM_showHideLayer('ShipdateRequestedLayer','','isShipdateRequested');" name="isShipdateRequested" id="isShipdateRequested" <c:if test="${!empty orderItem.requestedShipDateYear}" > checked="checked" </c:if> />
							<label for="isShipdateRequested"><fmt:message key="YourOrder_ExpressCheckout_ShippingDate" bundle="${storeText}" /></label>
							<br/>
							<div id="ShipdateRequestedLayer" 
								<c:choose>
									<c:when test="${empty orderItem.requestedShipDateYear}">
										style="visibility: hidden; display: none;"
									</c:when>
									<c:otherwise>
										style="visibility: visible; display: block;"
									</c:otherwise>
								</c:choose> 
							>
				                	<table cellpadding=0 cellspacing=0 id="Advanced_OrderForm_Table_2">
				                    	<tr>
				                        	<td id="WC_CurrentOrderDisplayExpressSection_TableCell_10">
									<label for="requestedDateYear"><fmt:message key="YourOrder_ExpressCheckout_ShippingDateYear" bundle="${storeText}" /></label>
								</td>
				                        	<td id="WC_CurrentOrderDisplayExpressSection_TableCell_11">
									<label for="requestedDateMonth"><fmt:message key="YourOrder_ExpressCheckout_ShippingDateMonth" bundle="${storeText}" /></label>
								</td>
				                        	<td id="WC_CurrentOrderDisplayExpressSection_TableCell_12">
									<label for="requestedDateDay"><fmt:message key="YourOrder_ExpressCheckout_ShippingDateDay" bundle="${storeText}" /></label>
								</td>
				                        </tr>
				                        <tr>
				                           <td id="WC_CurrentOrderDisplayExpressSection_TableCell_13">
				                           		<input class="input" type='text' name='requestedDateYear' id='requestedDateYear' value='<c:out value="${orderItem.requestedShipDateYear}"/>'  size=4 maxlength=4 />&nbsp;
				                           </td>
				                           <td id="WC_CurrentOrderDisplayExpressSection_TableCell_14">
				                           		<input class="input" type='text' name='requestedDateMonth' id='requestedDateMonth' value='<c:out value="${orderItem.requestedShipDateMonth}"/>'  size=4 maxlength=2 />&nbsp;
				                           </td>
				                           <td id="WC_CurrentOrderDisplayExpressSection_TableCell_15">
				                           		<input class="input" type='text' name='requestedDateDay' id='requestedDateDay'  value='<c:out value="${orderItem.requestedShipDateDay}"/>'  size=4 maxlength=2 />
				                           </td>
				                        </tr>
				                    </table>
			                    	</div>
			                </c:if>
			                <c:if test="${showExpedite eq true}" >
						<input class="checkbox" type="checkbox" name="isExpeditedCB" id="isExpeditedCB" <c:if test="${orderItem.expedited}" > checked="checked" </c:if> />
						<label for="isExpeditedCB"><fmt:message key="YourOrder_ExpressCheckout_Expedite" bundle="${storeText}" /></label>
						<input type="hidden" name="isExpedited" value="N" />
		                	</c:if>
		                	</td>
				</tr>
				<tr>
					<td id="WC_CurrentOrderDisplayExpressSection_TableCell_16">
						&nbsp;
					</td>
				</tr>
				<c:if test="${showInstructions eq true}" >
					<tr>
						<td id="WC_CurrentOrderDisplayExpressSection_TableCell_17">
							<label for="shipInstructions"><fmt:message key="YourOrder_ExpressCheckout_ShippingInstructions" bundle="${storeText}" /></label>
						</td>
					</tr>
					<tr>
						<td id="WC_CurrentOrderDisplayExpressSection_TableCell_18">
							<textarea rows="3" cols="60" name="shipInstructions" id="shipInstructions"></textarea>
						</td>
					</tr>
				</c:if>
				<tr>
					<td id="WC_CurrentOrderDisplayExpressSection_TableCell_19">
						<a href="javascript:order_SubmitCart(document.ShopCartForm, 'OrderDisplay')" class="button" id="WC_CurrentOrderDisplayExpressSection_Link2">
							<fmt:message key="YourOrder_ExpressCheckoutButton" bundle="${storeText}"/>
						</a>
					</td>
				</tr>
			</c:when>		
			<c:otherwise>
				<tr>
					<td id="WC_CurrentOrderDisplayExpressSection_TableCell_19a">
						<fmt:message key="YourOrder_ExpressCheckoutNoAddressInstructions" bundle="${storeText}"/>
					</td>
				</tr>
			</c:otherwise>
		</c:choose>

<script language="javascript">
function defined(obj)
{
  var str = typeof obj;

  if((str == "undefined") || (obj == null))
    return false;
  else
    return true;
}// END defined


// timestamp in JDBC format yyyy-mm-dd hh:mm:ss.fffffffff
// The use of JDBC format has no tie to the JDBC impl
// instead being a globalized timestamp from java.sql.Timestamp which is supported by WC
function order_ToJDBCTimestampString(year, month, day)
{
	var returnString = year  + "-" +
			   month + "-" +
			   day   + " 00:00:00.000000000";
	return returnString;
}

function order_SubmitCart(form, url)
{
	
	<c:if test="${showRequestedShipdate eq true}" >
		if (order_SetAllShipDates(form) == false) {
			return;
		}
	</c:if>
	
	<c:if test="${showExpedite eq true}" >
		order_SetIsExpedited(form);
	</c:if>
	
	if (defined(form.expressAddressId)) {
		form.addressId.value = form.expressAddressId.value;
	}
	if (defined(form.expressShipModeId)) {
		form.shipModeId.value = form.expressShipModeId.value;
	}
	
	submitForm(form, url);
}

<c:if test="${showRequestedShipdate eq true}" >
	function order_SetupShipDate()
	{
		window.yearField = document.all["requestedDateYear"];
		window.monthField = document.all["requestedDateMonth"];
		window.dayField = document.all["requestedDateDay"];
	
	}
	function order_SetAllShipDates(form)
	{
		if(form["isShipdateRequested"].checked){
			    // check the date to see that it matches the form of a date
			    var strdate = form["requestedDateMonth"].value + "/" + form["requestedDateDay"].value + "/" + form["requestedDateYear"].value;
			    if (isNaN(Date.parse(strdate))) {
			    	alert(strdate + "<fmt:message key="YourOrder_ExpressCheckout_Invalid_Requested_Shipdate" bundle="${storeText}" />");
			    	return false;
			    } else {
					form["requestedShipDate"].value = 
						order_ToJDBCTimestampString(form["requestedDateYear"].value, 
										  form["requestedDateMonth"].value, 
										  form["requestedDateDay"].value);
			    }
		} else {
			    // this results in "-- 00:00:00.000000000"
			    // the server will interpret this as no date -- and reset the requested ship date
			    form["requestedDateYear"].value = '';
			    form["requestedDateMonth"].value= '';
			    form["requestedDateDay"].value  = '';
			    form["requestedShipDate"].value = 
					order_ToJDBCTimestampString('', '', '');
		}
		return true;
	}
</c:if>

<c:if test="${showExpedite eq true}" >
	// isExpedited should be sent regardless as part of the form regardless of whether is checked
	// or not. A checkbox is only sent when it is checked. This function circumvents that 
	// restriction. An alternative is to set the checked attribute, but that has the side
	// affect of showing up on the screen as checked after pushing the submit button.
	// So, a hidden field is used, which ends up posting 2 variables, the check box and the 
	// the hidden field.
	function order_SetIsExpedited(form)
	{
		if (form["isExpeditedCB"].checked) {
			form["isExpedited"].value = "Y";
		} else {
			form["isExpedited"].value = "N";
		}
	}
</c:if>
</script>
