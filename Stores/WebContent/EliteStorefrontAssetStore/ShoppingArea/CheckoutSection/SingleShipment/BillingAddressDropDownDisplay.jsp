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
  * This JSP file displays a combo box with the applicable billing addresses for the current shopper.
  *****
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf"%>

<script type="text/javascript">
	dojo.addOnLoad(function() { 
		ServicesDeclarationJS.setCommonParameters('<c:out value='${WCParam.langId}'/>','<c:out value='${WCParam.storeId}'/>','<c:out value='${WCParam.catalogId}'/>');
		CheckoutPayments.setCommonParameters('<c:out value='${WCParam.langId}'/>','<c:out value='${WCParam.storeId}'/>','<c:out value='${WCParam.catalogId}'/>');
		CheckoutPayments.paymentSpecificAddress = <c:out value='${b2bStore}'/>;
	});
</script>



<c:set var="paymentMethodSelected" value="${WCParam.payMethodId}"/>
<c:if test="${empty paymentMethodSelected}">
	<c:set var="paymentMethodSelected" value="${param.paymentMethodSelected}" />
</c:if>
<c:set var="paymentTCId" value="${WCParam.paymentTCId}"/>


<c:set var="usablePayments" value="${requestScope.usablePayments}"/>
<c:if test="${empty usablePayments || usablePayments==null}">
	<wcf:getData type="com.ibm.commerce.order.facade.datatypes.OrderType"
		var="usablePayments" expressionBuilder="findCurrentShoppingCart">
		<wcf:param name="accessProfile" value="IBM_UsablePaymentInfo" />
	</wcf:getData>
</c:if>

<!--This data beans fetches the usuable billing address list based on the order Id given-->
<wcbase:useBean id="usableBillingAddressListBean" classname="com.ibm.commerce.order.beans.UsableBillingAddressListDataBean" scope="request">
	<c:set value="${usablePayments.orderIdentifier.uniqueID}" target="${usableBillingAddressListBean}" property="orderId" />
</wcbase:useBean>
<c:set var="selectedAddressId" value="${param.selectedAddressId}"/>
<c:set var="hasValidAddresses" value="false"/>

<c:forEach var="payment" items="${usablePayments.usablePaymentInformation}">
	<c:if test = "${fn:length(payment.usableBillingAddress) > 0 && !hasValidAddresses}">
		<c:set var="hasValidAddresses" value="true"/>
	</c:if>
</c:forEach>

<c:set var="search01" value="'"/>
<c:set var="replaceStr01" value="\\'"/>

<fmt:message var="profileshipping" key="QC_DEFAULT_SHIPPING" bundle="${storeText}"/>
<fmt:message var="profilebilling"  key="QC_DEFAULT_BILLING" bundle="${storeText}"/>
<c:set var="orgAddressList" value="${requestScope.contactOrgAddress}" scope="request"/>
<div class="billing_address" id="WC_BillingAddressDropDownDisplay_div_1">
	<p class="title"><label for="billing_address_id"><fmt:message key="BILL_BILLING_ADDRESS_CAPS" bundle="${storeText}"/></label>:</p>
		<c:choose>
			<c:when test="${hasValidAddresses}">
				<select class="drop_down" name="billing_address_id" id="billing_address_id" onchange="JavaScript:MessageHelper.hideAndClearMessage();CheckoutPayments.displayBillingAddressDetails(this,'<c:out value='${param.paymentAreaNumber}'/>','Billing'); CheckoutPayments.removeCreditCardNumberAndCVV(<c:out value='${param.paymentAreaNumber}'/>, true, true);CheckoutPayments.updatePaymentObject(<c:out value='${param.paymentAreaNumber}'/>, 'billing_address_id');CheckoutHelperJS.showHideEditBillingAddressLink(this,'<c:out value='${usablePayments.orderIdentifier.uniqueID}'/>','<c:out value='${param.paymentAreaNumber}'/>'); CheckoutHelperJS.showHideCreateBillingAddressLink(this,'<c:out value='${usablePayments.orderIdentifier.uniqueID}'/>','<c:out value='${param.paymentAreaNumber}'/>'); <flow:ifEnabled feature='AjaxCheckout'> if(submitRequest()){ cursor_wait();}</flow:ifEnabled>">
					<%-- Loop through all the payment options available and test if this option is the selected one or not..If this 
					option is the selected one, then get the valid billing address for this payment option.. Billing address varies based on the payment method selected..--%>
					<c:forEach var="payment" items="${usablePayments.usablePaymentInformation}">
						<c:choose>
							<c:when test="${(!empty paymentTCId && payment.paymentTermConditionId eq paymentTCId) || (empty paymentTCId && payment.paymentMethod.paymentMethodName eq paymentMethodSelected)}">
								<c:forEach var="addressInPayment" items="${payment.usableBillingAddress}">
									<c:if test="${empty selectedAddressId}" >
										<c:set var="selectedAddressId" value="${addressInPayment.uniqueID}"/>
									</c:if>
									<c:set var="hasValidAddresses" value="true"/>
									
									<c:if test="${addressInPayment.uniqueID == selectedAddressId}">
										<c:set var="selectStr" value='selected="selected"' />
									</c:if>
									
									<option <c:out value="${selectStr}" escapeXml='false'/> value="${addressInPayment.uniqueID}"><c:choose><c:when test="${addressInPayment.externalIdentifier.contactInfoNickName eq  profileShippingNickname}"><fmt:message key="QC_DEFAULT_SHIPPING" bundle="${storeText}"/></c:when>
									<c:when test="${addressInPayment.externalIdentifier.contactInfoNickName eq  profileBillingNickname}"><fmt:message key="QC_DEFAULT_BILLING" bundle="${storeText}"/></c:when><c:otherwise>${addressInPayment.externalIdentifier.contactInfoNickName}</c:otherwise></c:choose></option>
									
									<c:set var="selectStr" value="" />
								</c:forEach>
							</c:when>
						</c:choose>
					</c:forEach>
							
					<!-- Sets the value to '-2' (for use in the CheckoutHelper.js) in the event that paymentMethodSelected is empty -->
						<c:if test="${paymentMethodSelected == 'empty' || paymentMethodSelected == ''}">
								<option value="-2">
									<fmt:message key="EDPPaymentMethods_SELECT_PAYMENT_METHOD" bundle="${storeText}"/>
								</option>
						</c:if>
				</select>
			</c:when>
			<c:otherwise>
				<div id="addBillingAddressButton<c:out value="${param.paymentAreaNumber}_${usablePayments.orderIdentifier.uniqueID}"/>">
					<a href="JavaScript:MessageHelper.hideAndClearMessage();CheckoutPayments.createBillingAddress(<c:out value="${param.paymentAreaNumber}"/>,'Billing');">
						<img src="<c:out value='${jspStoreImgDir}${vfileColor}'/>table_plus_add.png" alt="<fmt:message key="ADDR_CREATE_ADDRESS" bundle="${storeText}"/>" />
						<fmt:message key="ADDR_CREATE_ADDRESS" bundle="${storeText}"/>
					</a>
				</div>
			</c:otherwise>
		</c:choose>

		<!-- Area where selected billing Address details is showed in short.. Needed only in case of web2.0 -->
		<flow:ifEnabled feature="AjaxCheckout">
			<br/>
			<div dojoType="wc.widget.RefreshArea" role="wairole:region" waistate:live="polite" waistate:atomic="true" waistate:relevant="text" objectId="billingAddressDisplayArea_<c:out value="${param.paymentAreaNumber}"/>" id="billingAddressDisplayArea_<c:out value="${param.paymentAreaNumber}"/>" widgetId="billingAddressDisplayArea_<c:out value="${param.paymentAreaNumber}"/>" controllerId="billingAdddressDisplayAreaController" >
				<!-- This value is equal to value in struts-config-ext.xml for view Name AjaxAddressDisplayView -->
				<c:import url="${jspStoreDir}Snippets/Member/Address/AddressDisplay.jsp">
					<c:param name="addressId" value= "${selectedAddressId}"/>
				</c:import>
			</div>
				<div class="clear_float"></div>
			<script type="text/javascript">
			dojo.addOnLoad(function() { 
				var widgetText = "billingAddressDisplayArea_" + "<c:out value="${param.paymentAreaNumber}"/>";
				parseWidget(widgetText);
				});
			</script>
	

</flow:ifEnabled>
		<!-- If its a non-ajax checkout page, then we should get all the address details during page load and use div show/hide logic -->
		<flow:ifDisabled feature="AjaxCheckout"> 
			<c:set var="displayMethod" value="display:none" />
			<c:set var="previousAddressUniqueIds" value=""/>
			<c:forEach var="payment" items="${usablePayments.usablePaymentInformation}">
				<c:choose>
					<c:when test="${payment.paymentMethod.paymentMethodName eq paymentMethodSelected}">
						<c:forEach var="addressInPayment" items="${payment.usableBillingAddress}">
							<c:set var="createAddressDiv" value="yes"/>											
							<c:set var="hasValidAddresses" value="true"/>
							<c:if test="${selectedAddressId eq addressInPayment.uniqueID}" >
								<!-- Show the address details div for this addressId -->
								<c:set var="displayMethod" value="display:block" />
							</c:if>
							<%-- in B2B, the account and the contract may have the same address. In this case, we only want to display it once. 
							Before displaying the address, first check if addressInPayment.uniqueID is in previousAddressUniqueIds --%>
							<c:forTokens items="${previousAddressUniqueIds}" delims="," var="previousAddressUniqueId">
								<c:if test="${previousAddressUniqueId == addressInPayment.uniqueID}">																									
									<c:set var="createAddressDiv" value="no"/> 
								</c:if> 								
							</c:forTokens>	
							<c:if test="${createAddressDiv == 'yes'}">
								<c:choose>
									<c:when test="${empty previousAddressUniqueIds}">
										<c:set var="previousAddressUniqueIds" value="${addressInPayment.uniqueID}"/>
									</c:when>
									<c:otherwise>
										<c:set var="previousAddressUniqueIds" value="${previousAddressUniqueIds},${addressInPayment.uniqueID}"/>
									</c:otherwise>								
								</c:choose>
								<div id="billingAddressDetails_<c:out value="${addressInPayment.uniqueID}"/>_<c:out value="${param.paymentAreaNumber}"/>" style="<c:out value="${displayMethod}"/>">
										<c:import url="${jspStoreDir}Snippets/Member/Address/AddressDisplay.jsp">
											<c:param name="addressId" value= "${addressInPayment.uniqueID}"/>
										</c:import>
								</div>
							</c:if>
							<c:set var="displayMethod" value="display:none" />
						</c:forEach>
					</c:when>
				</c:choose>
			</c:forEach>
			<!-- One empty div for the option "Please Select" -->
			<div id="billingAddressDetails_-1_<c:out value="${param.paymentAreaNumber}"/>" style="display:block">
			</div>
		</flow:ifDisabled>
			<!-- Checks to see if billing addresses should be displayed based on the checkboxes selected in the payment and billing section in the contract" -->
	<c:if test="${usableBillingAddressListBean.personalAddressAllowForBilling}" >	
		<c:if test="${selectedAddressId != -1 && hasValidAddresses}" >		
			<br/>
			<div id="editBillingAddressLink<c:out value='${param.paymentAreaNumber}'/>_<c:out value='${usablePayments.orderIdentifier.uniqueID}'/>" 
			<c:if test="${fn:contains(orgAddressList, selectedAddressId)}">
				style="display:none;"
			</c:if>
			>
					<a href="JavaScript:CheckoutPayments.saveBillingAddressDropDownBoxContextProperties('edit','<c:out value="${param.paymentAreaNumber}"/>');JavaScript:CheckoutHelperJS.editBillingAddress('0','<c:out value="${param.paymentAreaNumber}"/>','<c:out value='${fn:replace(profileshipping,search01,replaceStr01)}'/>','<c:out value='${fn:replace(profilebilling,search01,replaceStr01)}'/>')">
					<img src="<c:out value='${jspStoreImgDir}'/>images/edit_icon.png" alt="<fmt:message key="ADDR_EDIT_ADDRESS" bundle="${storeText}"/>" />
					<fmt:message key="ADDR_EDIT_ADDRESS" bundle="${storeText}"/>
					</a>
			</div>
			
		
		<!--  create a new address  -->
			<div id="createBillingAddressLink<c:out value="${param.paymentAreaNumber}"/>_<c:out value='${usablePayments.orderIdentifier.uniqueID}'/>" 
			<c:if test="${fn:contains(orgAddressList, selectedAddressId)}">
				style="display:none;"
			</c:if>
			>
					<a href="JavaScript:MessageHelper.hideAndClearMessage();CheckoutPayments.createBillingAddress(<c:out value="${param.paymentAreaNumber}"/>,'Billing');">
						<img src="<c:out value='${jspStoreImgDir}${vfileColor}'/>table_plus_add.png" alt="<fmt:message key="ADDR_CREATE_ADDRESS" bundle="${storeText}"/>" />
						<fmt:message key="ADDR_CREATE_ADDRESS" bundle="${storeText}"/>
					</a>
			</div>
		</c:if>
		
</c:if>		
 </div>
