<%--  
//********************************************************************
//*-------------------------------------------------------------------
//* Licensed Materials - Property of IBM
//*
//* WebSphere Commerce
//*
//* (c) Copyright IBM Corp. 2000, 2002
//*
//* US Government Users Restricted Rights - Use, duplication or
//* disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
//*
//*
//*-------------------------------------------------------------------
//*Purpose: Display input form for Bid Create and Update.
//*-------------------------------------------------------------------
//*
--%>


<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf" %>



<c:set var="bid_action" value="${param.bid_action}" />
<c:set var="bidrfn" value="${param.bidrfn}" />
<c:set var="resubmit" value="${WCParam.resubmit}" />
<c:set var="bid_id" value="${WCParam.bid_id}" />
<c:set var="aucrfn" value="${WCParam.aucrfn}" />
<c:set var="returnFlag" value="false" />



<c:if test="${! empty bid_id}">
	<c:set var="bid_action" value="update" />
	<wcbase:useBean id="aBid" classname="com.ibm.commerce.negotiation.beans.BidDataBean">
		<c:set property="bidId" value="${bid_id}" target="${aBid}" />
	</wcbase:useBean>
	<c:set var="bid_owner_id" value="${aBid.ownerId}" />	
	<c:set var="policyId" value="${aBid.payPolicyId}" />
	<c:set var="brandName" value="${aBid.payBrandName}" />
	<c:set var="aucrfn" value="${aBid.auctionId}" />
	<c:set var="bidrfn" value="${aBid.referenceCode}" />
	<c:if test="${ bid_owner_id != userId ||  empty bid_owner_id }">
		<c:set var="returnFlag" value="true" />
	</c:if>
	<c:set var="paymentString" value="${aBid.paymentInfo}"/>
</c:if>	

<wcbase:useBean id="auction" classname="com.ibm.commerce.negotiation.beans.AuctionDataBean">
	<c:set property="auctionId" value="${aucrfn}" target="${auction}" />
</wcbase:useBean>
<c:set var="productId" value="${auction.entryId}" />
<c:set var="currency" value="${auction.currency}" />
<c:set var="auction_Deposit" value="${auction.formattedDeposit}" />
<c:set var="fulfillmentCenterId" value="${auction.fullfillmentCenterId}" />
<c:set var="auction_Type" value="${auction.auctionType}" />
<c:set var="product_Inventory_fmt" value="${auction.formattedQuantity}" /> 
<c:set var="product_Inventory" value="${auction.quantity}" />
<c:if test="${auction_Type == 'D'}">
	<c:set var="last_bidval" value="${auction.currentPrice}" />
	<c:set var="product_Inventory_fmt"	value="${auction.formattedCurrentQuantity}" />
	<c:set var="product_Inventory" value="${auction.currentQuantity}" />
</c:if>

<%@ include file="../../BidSection/BidPaymentSetup.jsp" %>
<%@ include file="../../AOPAuctionBidPayment.js" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "DTD/xhtml1-transitional.dtd" >
<html lang="en">
<body>
<script>
<%= com.ibm.commerce.tools.util.CurrencyFormatGenerator.getJSObjects() %>
</script>
<script src="<c:out value="${jspStoreImgDir}"/>javascript/tools/common/NumberFormat.js"></script>
<script language="JavaScript" src="<c:out value="${jspStoreImgDir}"/>javascript/tools/common/Util.js"> </script>

<script language="JavaScript">
	var catalog_id = top.catalog_id; // get catalog_id stored as JavaScript variable in AuctionMainHome 
</script>

<%--if it is a new bid--%>
<c:choose>

	<c:when test="${bid_action eq 'create'}">
		<%--We have submitted once, but it failed. Therefore, we have already had
		info about bid from URL--%>

		<c:if test="${resubmit eq 'true'}">
			<c:set var="last_quant" value="${WCParam.bidquant}" />
			<c:set var="bidquantflg" value="${WCParam.bidquantflg}" />
			<c:if test="${bidquantflg eq 'On'}">
				<c:set var="last_winopt" value="P" />
			</c:if>
			<c:set var="last_authflg" value="${WCParam.bidauthflg}" />
			<c:set var="last_paymthd" value="${WCParam.cardBrand}" />				
			<c:set var="last_bidval" value="${WCParam.bidval}" />
			<c:set var="last_shpaddr" value="${WCParam.bidshprfn}" />
			<c:set var="last_billaddr" value="${WCParam.bidbillrfn}" />
			<c:set var="last_shpmode" value="${WCParam.bidshpmod}" />
			<c:set var="paymentString" value="${WCParam.paymentPolicyString}"/>
		</c:if>
	</c:when>
	<%--we are modifying an existing bid whose data needs to be retrieved from DB --%>
	<c:when test="${bid_action eq 'update'}">		
		<c:choose>
			<%--We have submitted once, but it failed. Therefore, we have already had
		//info about bid from URL--%>

			<c:when test="${resubmit eq 'true'}">
				<c:set var="last_quant" value="${WCParam.bidquant}" />
				<c:set var="bidquantflg" value="${WCParam.bidquantflg}" />
				<c:if test="${bidquantflg eq 'On'}">
					<c:set var="last_winopt" value="P" />
				</c:if>
				<c:set var="last_authflg" value="${WCParam.bidauthflg}" />
				<c:set var="last_paymthd" value="${WCParam.cardBrand}" />
				<c:set var="last_bidval" value="${WCParam.bidval}" />
				<c:set var="last_shpaddr" value="${WCParam.bidshprfn}" />
				<c:set var="last_billaddr" value="${WCParam.bidbillrfn}" />
				<c:set var="last_shpmode" value="${WCParam.bidshpmod}" />
				<c:set var="paymentString" value="${WCParam.paymentPolicyString}"/>
			</c:when>
			<%--This is the first time we retrieve a bid from DB for modifying--%>
			<c:otherwise>
				<c:set var="last_quant" value="${aBid.bidQuantity}" />
				<c:set var="last_winopt" value="${aBid.winOption}" />
				<c:set var="last_shpaddr" value="${aBid.shippingAddressId}" />
				<c:set var="last_billaddr" value="${aBid.billingAddressId}" />
				<c:set var="last_shpmode" value="${aBid.shippingMode}" />
				<c:set var="last_bidval" value="${aBid.bidPrice}" />
			</c:otherwise>
		</c:choose>
	</c:when>
</c:choose>
<c:if test="${returnFlag == false}">
<table cellpadding="1" cellspacing="2" width="600" border="0" id="WC_BidForm_Table_1">
	<tbody>
		<tr>			
			<td width="10" id="WC_BidForm_TableCell_1">&nbsp;</td>
			<td align="left" valign="top" class="categoryspace" width="580" id="WC_BidForm_TableCell_2">
			<font class="pageHeading"> 
			<c:if test="${bid_action == 'create'}">
				<fmt:message key="createBidMsg" bundle="${storeText}">
					<fmt:param value="${auction.auctItemDesc}" />
				</fmt:message>
			</c:if> 
			<c:if test="${bid_action == 'update'}">
				<fmt:message key="updateBidMsg" bundle="${storeText}">
					<fmt:param value="${auction.auctItemDesc}" />
				</fmt:message>
			</c:if> 
			</font>
			</td>
		</tr>
		<tr>
			<td width="10" id="WC_BidForm_TableCell_3">&nbsp;</td>
			<td id="WC_BidForm_TableCell_4">
			<form name="BidForm" action="BidSubmit" method="post" id="BidForm"> 
			<input type="hidden" name="storeId" value='<c:out value="${storeId}" />' id="WC_BidForm_storeId_In_BidForm" />
			<input type="hidden" name="paymentPolicyString" value="NY_MARK4" id="WC_BidForm_paymentPolicyString_In_BidForm"/>
			<input type="hidden" name="pIndexName"	value='<c:out value="${policyIndex}" />' id="WC_BidForm_pIndexName_In_BidForm"/> 
			<input type="hidden" name="redirecturl" value="AuctionAckView" id="WC_BidForm_redirecturl_In_BidForm"/> 
			<input type="hidden" name="aucrfn" value='<c:out value="${aucrfn}" />'id="WC_BidForm_aucrfn_In_BidForm" /> 
			<input type="hidden" name="bid_action" value='<c:out value="${bid_action}" />' id="WC_BidForm_bid_action_In_BidForm"/> 
			<input type="hidden" name="resubmit" value='<c:out value="${WCParam.resubmit}" />' id="WC_BidForm_resubmit_In_BidForm"/> 
			<input type ="hidden" name="catalogId" value="<c:out value="${WCParam.catalogId}" />" id="WC_BidForm_catalogId_In_BidForm"/>
			<c:if test="${bid_action == 'update'}">
				<input type="hidden" name="bid_id"	value='<c:out value="${bid_id}" />' id="WC_BidForm_bid_id_In_BidForm"/>
			</c:if>  


			<table cellpadding="1" cellspacing="2" width="580" border="0" id="WC_BidForm_Table_2">
				<tbody>
					<tr>
						<td align="left" valign="top" class="textOverBackgroundCharts" id="WC_BidForm_TableCell_5">
						<font class="textOverBackgroundCharts"> 
						<fmt:message key="txtReferenceNumber" bundle="${storeText}" /> 
						</font>
						</td>
						<td align="left" valign="top" class="textOverBackgroundCharts" id="WC_BidForm_TableCell_6">
						<font class="textOverBackgroundCharts"> 
						<input type="hidden" name="bidrfn" value='<c:out value="${bidrfn}"/>' id="WC_BidForm_bidrfn_In_BidForm"> 
						<c:out value="${bidrfn}" /> 
						</font>
						</td>
					</tr>
				</tbody>
			</table>

			<table cellpadding="1" cellspacing="2" width="580" border="0" id="WC_BidForm_Table_3">
				<tbody>
					<tr>
						<td align="left" id="WC_BidForm_TableCell_7">
						<label for="WC_BidForm_bidval_In_BidForm">
						<font class="productName"> 
						<fmt:message key="txtBidPricePerItem" bundle="${storeText}" /> 
						</font>
						</label>
						</td>
						<td align="left" id="WC_BidForm_TableCell_8">
						<font class="price"> 
						<c:if test="${auction_Type=='O' || auction_Type=='SB'}">							
							<c:out value="${auction.prefix}" escapeXml="false"/>
							<input type="text" size="16" maxlength="16" name="bidval" value="" id="WC_BidForm_bidval_In_BidForm"/>
							<c:out value="${auction.suffix}" />
							<br />
						</c:if> 
						<c:if test="${!(auction_Type=='O' || auction_Type=='SB')}">
							<input type="hidden" size="16" maxlength="16" name="bidval"	value='<c:out value="${last_bidval}" />' id="WC_BidForm_bidval_In_BidForm"/>
							<c:out value="${auction.formattedAuctCurPrice}" escapeXml="false"/>							
							<br />
						</c:if> 
						</font>
						</td>
					</tr>
					<tr>
						<td align="left" id="WC_BidForm_TableCell_9">
						<label for="WC_BidForm_bidquant_In_BidForm">
						<font class="productName" > 
						<fmt:message key="txtRequestedQuantity" bundle="${storeText}" /><br />
						(<fmt:message key="inventory" bundle="${storeText}">
							<fmt:param value="${product_Inventory_fmt}" />
						</fmt:message> ) 
						</font>
						</label>
						<%-- This hidden input is set up for checking purpose in Javascript --%>
						<input type="hidden" name="inventory_js" value="<c:out value="${product_Inventory}"/>" id="WC_BidForm_inventory_js_In_BidForm"/>						
						</td>
						<td align="left" id="WC_BidForm_TableCell_10">
						<input type="text" size="17" maxlength="17" name="bidquant" value="" id="WC_BidForm_bidquant_In_BidForm"/>
						</td>
					</tr>
				</tbody>
			</table>
			<table cellpadding="1" cellspacing="2" width="580" border="0" id="WC_BidForm_Table_4">
				<tbody>
					<tr>
						<td align="left" id="WC_BidForm_TableCell_11">
						<label for="WC_BidForm_bidquantflg_In_BidForm">
						<font class="productName" > 
						<fmt:message key="txtMsgPartialQuantityQuery" bundle="${storeText}" /> 
						</font>
						</label>
						<input type="checkbox" name="bidquantflg" value="On" id="WC_BidForm_bidquantflg_In_BidForm">
						</td>
					</tr>
				</tbody>
			</table>
			<%-- 24805 --%> <%-- begin privacy box --%><%--29389--%> <br />
			<table cellspacing="0" cellpadding="0" id="WC_BidForm_Table_5">
				<tbody>
					<tr>
						<td valign="top" id="WC_BidForm_TableCell_12">
						<table cellpadding="3" cellspacing="0" border="1" bgcolor="#FFFFCC" width="90%" align="left" id="WC_BidForm_Table_6">
							<tbody>
								<tr>
									<td align="left" valign="top" id="WC_BidForm_TableCell_13">
									<font class="strongtext">
									<fmt:message key="Privacy_Title" bundle="${storeText}" />
									</font>
									<br />
									<font class="text"> <%--31410--%> 
									<fmt:message key="Privacy_Text7" bundle="${storeText}"/>	
									<%--
									<font class="sidebarhot"> 
									<a href='PrivacyView?langId=<c:out value="${langId}"/>&storeId=<c:out value="${storeId}"/>&catalogId=<c:out value="${catalogId}"/>' target="_top" id="WC_BidForm_Link_1"> 
									<fmt:message key="LEARN_MORE" bundle="${storeText}" /> 
									</a> 
									</font>
									--%> 
									</font>
									</td>
								</tr>
							</tbody>
						</table>
						</td>
					</tr>
				</tbody>
			</table>
			<%-- end privacy box --%> <br />
			<table cellpadding="1" cellspacing="2" width="580" border="0" id="WC_BidForm_Table_7">
				<tbody>
					<tr>
						<td align="left" valign="top" class="textOverBackgroundCharts" id="WC_BidForm_TableCell_14">
						<font class="textOverBackgroundCharts"> 
						<fmt:message key="paymentInfo" bundle="${storeText}" /> 
						</font>
						</td>
					</tr>
				</tbody>
			</table>

			<br />
			<table cellpadding="1" cellspacing="2" width="580" border="0" id="WC_BidForm_Table_8">
				<tbody>
					<tr>
						<td id="WC_BidForm_TableCell_15">
						<label for="WC_BidForm_PolicyChange_In_BidForm">
						<font class="text">
						<fmt:message key="creditCardInfo" bundle="${storeText}" />
						</font> 
						</label>
						<br />						
						<select name="PolicyChange" id="WC_BidForm_PolicyChange_In_BidForm" onchange="onPaymentPolicyRefresh()">
							<option selected></option>
							<c:set var="index3" value="0" />							
							<c:forEach var="policy" items="${policyArray}" >

								<c:set var="selectedString" value="" />
								<c:if test="${index3 == policyIndex }"> 
									<c:set var="selectedString" value=" selected" />
								</c:if>

								<option <c:out value="${selectedString}" />	value="<c:out value="${index3+1}" />">
									<c:out value="${policy.longDescription}" />
								</option>
								<c:set var="index3" value="${index3 + 1}" />
							</c:forEach>
						</select> 						
						<input type="hidden" name="PaymentPolicyChangeAction" value="BidCreateForm" id="WC_BidForm_PaymentPolicyChangeAction_In_BidForm">
						</td>
					</tr>
				</tbody>
			</table>			
			<c:if test="${! empty paymentPolicyDisplayName}">
				<c:import url="${jspStoreDir}AuctionArea/EDP/${paymentPolicyDisplayName}">
					<c:param name="cardDesc" value="${paymentCardDesc}" />
					<c:param name="cardId" value="${paymentCardId}" />
					<c:param name="cardName" value="${paymentCardName}" />
					<c:param name="cardBrand" value="${paymentCardBrand}" />
					<c:param name="paymentString" value="${paymentString}" />
				</c:import>  
			</c:if>
			<c:choose>
			<c:when test="${bid_action == 'create' and (! empty auction_Deposit)  }">
				<table cellpadding="0" cellspacing="0" border="0" width="550" id="WC_BidForm_Table_9">
					<tbody>
						<tr>
							<td id="WC_BidForm_TableCell_16">
							<label for="WC_BidForm_bidauthflg_In_BidForm">
							<font class="price"> 
							<fmt:message key="depositRequired"	bundle="${storeText}">
								<fmt:param value="${auction_Deposit}" />
							</fmt:message> 
							</font>
							</label>
							<br />
							<input type="checkbox" name="bidauthflg" value="On" id="WC_BidForm_bidauthflg_In_BidForm"/> 
							<fmt:message key="chargeDeposit" bundle="${storeText}" />
							</td>
						</tr>
					</tbody>
				</table>
			</c:when> 
			<c:otherwise>
				<input type="hidden" name="bidauthflg" value="On" id="WC_BidForm_bidauthflg_In_BidForm"/>
			</c:otherwise> 
			</c:choose> 
			<br />
			<table cellpadding="1" cellspacing="2" width="580" border="0" id="WC_BidForm_Table_10">
				<tbody>
					<tr>
						<td align="left" valign="top" class="textOverBackgroundCharts" id="WC_BidForm_TableCell_17">
						<font class="textOverBackgroundCharts"> 
						<fmt:message key="shippingInfo"	bundle="${storeText}" /> 
						</font>
						</td>
					</tr> 
				</tbody>
			</table>
			<wcbase:useBean id="abdb" classname="com.ibm.commerce.user.beans.AddressBookDataBean" />

			<table cellpadding="1" cellspacing="2" width="580" border="0" id="WC_BidForm_Table_11">
				<tbody>
					<tr>
						<td id="WC_BidForm_TableCell_18">
						<label for="WC_BidForm_bidbillrfn_In_BidForm">
						<font class="productName"> 
						<fmt:message key="billTo" bundle="${storeText}" /> 
						</font>
						</label>
						</td>
						<td id="WC_BidForm_TableCell_19">
						<select name="bidbillrfn" size="1" id="WC_BidForm_bidbillrfn_In_BidForm">
							<c:forEach var="address" items="${abdb.addressList}">
								<option value='<c:out value="${address[0]}" />'>
								<c:out	value="${address[1]}" />
								</option>
							</c:forEach>
						</select>
						</td>
					</tr>

					<tr>
						<td id="WC_BidForm_TableCell_20">
						<label for="WC_BidForm_bidshprfn_In_BidForm">
						<font class="productName"> 
						<fmt:message key="shipTo" bundle="${storeText}" /> 
						</font>
						</label>
						</td>
						<td id="WC_BidForm_TableCell_21">
						<select name="bidshprfn" size="1" id="WC_BidForm_bidshprfn_In_BidForm">
							<c:forEach var="address" items="${abdb.addressList}">
								<option value='<c:out value="${address[0]}" />'>
								<c:out	value="${address[1]}" />
								</option>
							</c:forEach>
						</select></td>
					</tr>

					<tr>
						<td id="WC_BidForm_TableCell_22">
						<label for="WC_BidForm_bidshpmod_In_BidForm">
						<font class="productName"> 
						<fmt:message key="shippingCarrier" bundle="${storeText}" /> 
						</font>
						</label>
						</td>
						<td id="WC_BidForm_TableCell_23">
						<%-- Make sure that fulfillment_id is set up in auction table --%>
						<c:if test="${! empty fulfillmentCenterId }">
							<wcbase:useBean id="shippingdb" classname="com.ibm.commerce.fulfillment.beans.ShippingDataBean">
								<c:set property="catalogEntryId" value="${productId}"	target="${shippingdb}" />
								<c:set property="fulfillmentCenterId"	value="${fulfillmentCenterId}" target="${shippingdb}" />
								<c:set property="storeId" value="${storeId}"	target="${shippingdb}" />
								<c:set property="currency" value="${currency}"	target="${shippingdb}" />								
							</wcbase:useBean>	
						</c:if> 
						<select name="bidshpmod" size="1" id="WC_BidForm_bidshpmod_In_BidForm" class="price">
							<c:set var="count" value="0" />
							<c:forEach var="smab" items="${shippingdb.shipModes}">								
								<c:set var="shippingMode0" value="${smab.shippingModeId}" />
								<wcbase:useBean id="smdab"	classname="com.ibm.commerce.fulfillment.beans.ShippingModeDescriptionDataBean">
									<c:set property="dataBeanKeyShipModeId"	value="${smab.shippingModeId}" target="${smdab}" />
									<c:set property="dataBeanKeyLanguageId" value="${langId}" target="${smdab}" />
								</wcbase:useBean>
								<c:set var="shippingMode1" value="${smab.code}" />
								<c:if test="${! empty smdab}">
									<c:set var="shippingMode1" value="${smdab.description}" />
								</c:if>								
								<c:set var="charges" value=" (${shippingdb.shippingCharges[1]})" />
								<c:set var="count" value="${count + 1}" />
								<option value='<c:out value="${shippingMode0}" />' class="price">
								<c:out	value="${shippingMode1}" /><c:out value="${charges}" escapeXml="false"/>
								</option>
							</c:forEach>
							<c:if test="${count == 0}">
								<option value="1">Overnite-hd</option>
								<option value="2">Economy-hd</option>
							</c:if>
						</select>
						</td>
					</tr>
				</tbody>
			</table>
			<br/>
			<table cellpadding="1" cellspacing="2" width="580" border="0" id="WC_BidForm_Table_12">
				<tbody>
					<tr>
						<td align="left" valign="top" class="button" id="WC_BidForm_TableCell_24">
							<a href="javascript:submitForm(document.BidForm)" class="button" id="WC_BidForm_Link_2"><fmt:message key="submit" bundle="${storeText}"/></a>
						</td>						
						<td align="left" valign="top" class="button" id="WC_BidForm_TableCell_25">
							<a href="javascript:ClearBidForm(document.BidForm)" class="button" id="WC_BidForm_Link_3"><fmt:message key="reset" bundle="${storeText}"/></a>							
						</td> 
					</tr>
				</tbody> 
			</table>
			</form>
			</td>
		</tr> 
	</tbody>
</table>
</c:if>

<%@ include file="../../AOPAuctionBidValidate.js" %>

<script language="JavaScript">
function onPaymentPolicyRefresh() {
	var ret=CheckResubmit();
	if( ret ) {
		getPolicy();
	}
	self.document.BidForm.PolicyChange.selectedIndex = <c:out value="${policyIndex}" />;
	return ret;
}
         
function setInitialValues() { 
	//This part of JavaScript code is used for setting existing values 
	//for several fields of the form 
	if("<c:out value="${last_quant}"/>" !="")
	{
		self.document.BidForm.bidquant.value=numberToStr( "<c:out value="${last_quant}"/>", "<c:out value="${langId}" />" );
	}
	if("<c:out value="${last_bidval}"/>" !="")
	{
		self.document.BidForm.bidval.value=numberToCurrency("<c:out value="${last_bidval}"/>", "<c:out value="${currency}" />","<c:out value="${langId}" />");
	}
	//Win option field
	
	if( "<c:out value="${last_winopt}" />" == "P") {                 
		self.document.BidForm.bidquantflg.checked = true;
	}
	
	//NY_MARK5
	self.document.BidForm.PolicyChange.selectedIndex = <c:out value="${policyIndex}" />;
	
	if(<c:out value="${policyIndex}" /> >0 && <c:out value="${policyIndex}" /> < 1000) { 
		
		//policyInit();
	} 
	//NY_MARK5_END
          
	//Deposit authorization field
	if( "<c:out value="${last_authflg}" />"  == "On" && self.document.BidForm.bidauthflg.type == "checkbox") {
		self.document.BidForm.bidauthflg.checked = true 
	}
	
	//Billing address field
	self.document.BidForm.bidbillrfn.selectedIndex = 0
	for(var i=0; i< self.document.BidForm.bidbillrfn.length; i++) {
		if ( "<c:out value="${last_billaddr}" />"  == self.document.BidForm.bidbillrfn.options[i].value) {
			self.document.BidForm.bidbillrfn.selectedIndex = i
			break
		}
	}
	
	//Shipping address field
	self.document.BidForm.bidshprfn.selectedIndex = 0
	for(var i=0; i< self.document.BidForm.bidshprfn.length; i++) {
		if ( "<c:out value="${last_shpaddr}" />"  == self.document.BidForm.bidshprfn.options[i].value) {
			self.document.BidForm.bidshprfn.selectedIndex = i
			break
		}
	}
	
	//Shipping mode field
	self.document.BidForm.bidshpmod.selectedIndex = 0
	for(var i=0; i< self.document.BidForm.bidshpmod.length; i++) {
		if ( "<c:out value="${last_shpmode}" />"  == self.document.BidForm.bidshpmod.options[i].value) {
			self.document.BidForm.bidshpmod.selectedIndex = i
			break
		}
	}
}     
             
function submitForm(form) {
	//policyCheck();
	if(CheckResubmitWithPayment() == true)
	{
		form.submit();
	}
	
}             
             
setInitialValues();
</script>
</body>
</html>
