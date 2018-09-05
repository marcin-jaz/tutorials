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
  * This JSP file shows shipping charge snippet used by B2B checkout
  *****
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf"%>

	<script type="text/javascript">
		dojo.addOnLoad(function() { 
			CheckoutHelperJS.setShipChargeEnabled(true);
		});
	</script>
	
	<c:set var="orderUniqueId" value="${WCParam.orderId}" />
	<c:if test="${orderUniqueId == '.' || orderUniqueId == '' || orderUniqueId == undefined || orderUniqueId == null}">
		<c:set var="orderUniqueId" value="${param.orderId}" />
	</c:if>
	
	<%-- use the UsableShipChargesAndAccountByShipModeDataBean instead of getting from order service as it will give how many ship modes shopper has selected --%>
	<wcbase:useBean id="shipCharges" classname="com.ibm.commerce.order.beans.UsableShipChargesAndAccountByShipModeDataBean" scope="page">
		<c:set property="orderId" value="${orderUniqueId}" 	target="${shipCharges}"  />
	</wcbase:useBean>
	
	<c:if test="${not empty shipCharges.shipChargesByShipMode}">

		<%-- for single shipment --%>
		<c:forEach items="${shipCharges.shipChargesByShipMode}" var="shipCharges_data"  varStatus="counter">
			<div id="B2BShippingChargeExt_main_div_<c:out value="${counter.count}"/>">
				<label for="shipChargTypeId_<c:out value="${counter.count}"/>"><fmt:message key="ShippingChargeType" bundle="${storeText}"/></label><br />
			</div>
			<select class="drop_down shipcharge" name="shipChargTypeId_<c:out value="${counter.count}"/>" id="shipChargTypeId_<c:out value="${counter.count}"/>" 
						onchange="javascript:setCurrentId('shipChargTypeId_<c:out value="${counter.count}"/>'); 
							CheckoutHelperJS.hideShipChargeAccountField('shipChargTypeId_<c:out value="${counter.count}"/>','ShipChargeAcctDiv_<c:out value="${counter.count}"/>');
							CheckoutHelperJS.updateShippingChargeForShipModeAjax('<c:out value="${orderUniqueId}"/>', document.getElementById('singleShipmentShippingMode').value, this.value);">
				<c:forEach items="${shipCharges_data.shippingChargeTypes}" var="shipChargeType_data" >
					<c:choose>
						<c:when test="${shipChargeType_data.selected}">
							<c:set var="chargeByCarrier" value="${shipChargeType_data.internalPolicyId}"/>
							<option value="<c:out value="${shipChargeType_data.policyId}"/>" selected="selected">
						</c:when> 
						<c:otherwise>
							<option value="<c:out value="${shipChargeType_data.policyId}"/>">
						</c:otherwise>
					</c:choose>
						<fmt:message key="${shipChargeType_data.policyName}" bundle="${storeText}" />
					</option>
				</c:forEach>
			</select>
	
			<c:choose>
				<c:when test="${chargeByCarrier eq -7002}">
					<div id="ShipChargeAcctDiv_<c:out value="${counter.count}"/>" style="display: block;">
				</c:when>
				<c:otherwise>
					<div id="ShipChargeAcctDiv_<c:out value="${counter.count}"/>" style="display: none;">
				</c:otherwise>
			</c:choose> 
				<div id="ShipChargeAcctLabelDiv"/>
					<label for="shipCarrAccntNum_<c:out value="${counter.count}"/>"><fmt:message key="ShippingChargeAcctNum" bundle="${storeText}"/></label>
				</div>
				<input class="input" type="text" name="shipCarrAccntNum_<c:out value="${counter.count}"/>" 
						size="20" maxlength="100" value="<c:out value="${shipCharges_data.carrierAccountNumber}" />" 
							id="shipCarrAccntNum_<c:out value="${counter.count}"/>"
							onblur="javascript:setCurrentId('shipChargTypeId_<c:out value="${counter.count}"/>'); 
							CheckoutHelperJS.updateShippingChargeForShipModeAjax('<c:out value="${orderUniqueId}"/>', document.getElementById('singleShipmentShippingMode').value, document.getElementById('shipChargTypeId_<c:out value="${counter.count}"/>').value, this.value);"/>
			</div>
		</c:forEach>
		<div class="shipChargePadding"></div>
	</c:if>
