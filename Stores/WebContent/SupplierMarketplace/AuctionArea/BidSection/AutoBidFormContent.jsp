<%--
/* 
 *-------------------------------------------------------------------
 * Licensed Materials - Property of IBM
 *
 * WebSphere Commerce
 *
 * (c) Copyright International Business Machines Corporation. 2003
 *     All rights reserved.
 *
 * US Government Users Restricted Rights - Use, duplication or
 * disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
 *
 *-------------------------------------------------------------------
 */
 ////////////////////////////////////////////////////////////////////
 //
 // Change History:
 //
 // YYMMDD      F/D#        WHO        Description
 // -----------------------------------------------------------------
 //
 ////////////////////////////////////////////////////////////////////
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../include/JSTLEnvironmentSetup.jspf"%>
<%@ include file="../../include/ErrorMessageSetup.jspf" %>
<html>
<table id="WC_AutoBidForm_Table_1" border="0" cellpadding="0" cellspacing="0" width="790" >
	
	<tr>		

		<td id="WC_AutoBidForm_TableCell_2" valign="top" width="630">
		<c:set	var="auctionStoreId" value="${WCParam.auctionStoreId}" /> 
		<c:set	var="autobidrfn" value="${requestScope.autobidrfn}" /> 
		<c:set var="resubmit" value="${WCParam.resubmit}" />
		<c:if test="${resubmit eq 'true'}">
			<c:set var="autobidrfn" value="${WCParam.autobidrfn}" />
		</c:if> 
		<c:if test="${WCParam.GA eq '1'}">
			<c:set var="autobidrfn" value="${WCParam.autobidrfn}" />
		</c:if> 				
		<c:set	var="last_quant" value="${WCParam.bidquant}" /> 
		<c:if test="${WCParam.bidquantflg == 'On'}">
			<c:set var="last_winopt" value="P" />
		</c:if> 
		<c:set var="last_authflg" value="${WCParam.bidauthflg}" /> 
		<c:set var="last_bidval" value="${WCParam.bidval}" /> 
		<c:set var="last_shpaddr" value="${WCParam.bidshprfn}" /> 
		<c:set var="last_billaddr" value="${WCParam.bidbillrfn}" /> 
		<c:set var="last_shpmode" value="${WCParam.bidshpmod}" /> 
		<c:set var="last_maxbdlimit" value="${WCParam.maxbidlimit}" /> 			
		<c:set var="autobid_id"	value="${WCParam.autobid_id}" /> 
		<c:set var="returnFlag"	value="false" /> 
		<wcbase:useBean id="auction" classname="com.ibm.commerce.negotiation.beans.AuctionDataBean">
			<c:set property="auctionId" value="${WCParam.aucrfn}" target="${auction}" />
		</wcbase:useBean> 
		<c:set var="productId" value="${auction.entryId}" />
		<c:set var="currency" value="${auction.currency}" /> 
		<c:set var="auction_Deposit" value="${auction.formattedDeposit}" /> 
		<c:set var="fulfillmentCenterId" value="${auction.fullfillmentCenterId}" />
		<c:set var="autobid_action" value="create" /> 
		<c:if test="${! empty autobid_id}">
			<wcbase:useBean id="anAutoBid"	classname="com.ibm.commerce.negotiation.beans.AutoBidDataBean">
				<c:set property="autoBidId" value="${autobid_id}"	target="${anAutoBid}" />
			</wcbase:useBean>
			<c:set var="autobid_owner_id" value="${anAutoBid.ownerId}" />
			<c:if test="${autobid_owner_id != userId || empty autobid_owner_id }">
				<c:set var="returnFlag" value="true" />
			</c:if>
			<c:set var="autobid_action" value="update" />
			<c:set var="ccnumber" value="${anAutoBid.ccNumber}" />
			<c:set var="ccyear" value="${anAutoBid.ccYear}" />
			<c:set var="ccmonth" value="${anAutoBid.ccMonth}" />
			<c:set var="policyId" value="${anAutoBid.payPolicyId}" />				
			<c:set var="brandName" value="${anAutoBid.payBrandName}" />					
			<c:set var="autobidrfn" value="${anAutoBid.referenceCode}" />
			<c:set var="last_quant" value="${anAutoBid.bidQuantity}" />
			<c:set var="last_winopt" value="${anAutoBid.winOption}" />
			<c:set var="last_shpaddr" value="${anAutoBid.shippingAddressId}" />
			<c:set var="last_billaddr" value="${anAutoBid.billingAddressId}" />
			<c:set var="last_shpmode" value="${anAutoBid.shippingMode}" />
			<c:set var="last_maxbdlimit" value="${anAutoBid.maxBidLimit}" />
			<c:set var="bid_id" value="${anAutoBid.firstBidId}" />
			<c:set var="last_bidval" value="${anAutoBid.initialBidPrice}" />
			<c:if test="${anAutoBid.status ne 'F'}">
				<wcbase:useBean id="aBid" classname="com.ibm.commerce.negotiation.beans.BidDataBean">
					<c:set property="bidId" value="${bid_id}" target="${aBid}" />
				</wcbase:useBean>
				<c:set var="last_bidval" value="${aBid.bidPrice}" />
			</c:if>
		</c:if>			
		 
		<c:if test="${returnFlag == false}">
			<table id="WC_AutoBidForm_Table_2" cellpadding="0" cellspacing="8"	width="580" border="0">
				
				<tr>
					<td id="WC_AutoBidForm_TableCell_3" align="left" valign="top" class="categoryspace" width="580">
					<h1>
					<c:if test="${autobid_action == 'create'}">
						<fmt:message key="AutoBid_createAutoBidMsg"	bundle="${storeText}">
							<fmt:param value="${auction.auctItemDesc}" />
						</fmt:message>
					</c:if> 
					<c:if test="${autobid_action == 'update'}">
						<fmt:message key="AutoBid_updateAutoBidMsg"	bundle="${storeText}">
							<fmt:param value="${auction.auctItemDesc}" />
						</fmt:message>
					</c:if>
					</h1>
					</td>
				</tr>
				
			</table>
			
			<table id="WC_AutoBidForm_Table_3" cellpadding="0" cellspacing="8" width="580" border="0">
				
				<tr>
					<td id="WC_AutoBidForm_TableCell_4" align="left" valign="top" colspan="5" class="categoryspace" width="580">
					<c:set var="highbid_Val" value="0" /> 
					<c:if test="${! empty auction.highestBidId }">
						<%-- get high bid information --%>						
						<c:set var="highbid_Val" value="${auction.highestBid.formattedBidPrice}" />
					</c:if> 
					<c:set var="bestbid_Val" value="0" /> 
					<c:if test="${! empty auction.bestBidId }">
						<%-- get best bid information --%>						
						<c:set var="bestbid_Val" value="${auction.bestBid.formattedBidPrice}" />
					</c:if> 
					<font class="price"> 
					(<fmt:message key="BestBid_highestBid" bundle="${storeText}">
						<fmt:param value="${highbid_Val}" />
					</fmt:message>) <br />
					(<fmt:message key="BestBid_lowestBid" bundle="${storeText}">
						<fmt:param value="${bestbid_Val}" />
					</fmt:message>) 
					</font> <br />
					</td>
				</tr>
				
			</table>
			
			<table id="WC_AutoBidForm_Table_4" cellpadding="0" cellspacing="8" width="580" border="0">
				
				<tr>
					<td id="WC_AutoBidForm_TableCell_5" align="left" valign="top" colspan="5" class="categoryspace" width="580">
					<font color="red">
					<%-- Check if there are any error message --%> 					
					<c:out value="${errorMessage}"/>						
					</font>
					<hr width="100%" noshade="noshade" align="left" />
					</td>
				</tr>
				
			</table>

			<%@ include file="BidPaymentSetup.jsp"%>
			<%@ include file="../AuctionBidPayment.js"%>

			<script>
			<%= com.ibm.commerce.tools.util.CurrencyFormatGenerator.getJSObjects() %>
			</script>
		
			<script src="/wcs/javascript/tools/common/NumberFormat.js"></script>
			<script language="JavaScript" src="/wcs/javascript/tools/common/Util.js"> </script>

			<script language="JavaScript">
				var catalog_id = top.catalog_id; // get catalog_id stored as JavaScript variable in AuctionMainHome 
			</script>

			<table id="WC_AutoBidForm_Table_5" cellpadding="0" cellspacing="8"	width="600" border="0">
				
				<tr>
					<td id="WC_AutoBidForm_TableCell_6">
					<form name="BidForm" action="AutoBidSubmit" method="post" id="BidForm">
					<input	type="hidden" name="auctionStoreId"	value='<c:out value="${auctionStoreId}" />'	id="WC_AutoBidForm_FormInput_auctionStoreId_In_BidBorm_1" /> 
					<input	type="hidden" name="paymentPolicyString" value="NY_MARK4" id="WC_AutoBidForm_FormInput_paymentPolicyString_In_BidBorm_1" />
					<input type="hidden" name="pIndexName"	value='<c:out value="${policyIndex}" />'id="WC_AutoBidForm_FormInput_pIndexName_In_BidBorm_1" /> 
					<input	type="hidden" name="redirecturl" value="AuctionAckView"	id="WC_AutoBidForm_FormInput_redirecturl_In_BidBorm_1" /> 
					<input	type="hidden" name="aucrfn"	value='<c:out value="${WCParam.aucrfn}" />'	id="WC_AutoBidForm_FormInput_aucrfn_In_BidBorm_1" /> 
					<input	type="hidden" name="autobid_action"	value='<c:out value="${autobid_action}" />'	id="WC_AutoBidForm_FormInput_autobid_action_In_BidBorm_1" /> 
					<input	type="hidden" name="resubmit"	value='<c:out value="${WCParam.resubmit}" />'id="WC_AutoBidForm_FormInput_resubmit_In_BidBorm_1" />
					<table id="WC_AutoBidForm_Table_6" cellpadding="1"	cellspacing="2" width="580" border="0">
						
						<tr bgcolor="#4C6178">
							<td id="WC_AutoBidForm_TableCell_7" align="left" valign="top"	class="textOverBackgroundCharts">
							<font style="font-family: Verdana" color="#FFFFFF"> 
							<fmt:message key="AuctionCommonText_ReferenceNumber" bundle="${storeText}" /> 
							</font>
							</td>
							<td id="WC_AutoBidForm_TableCell_8" align="left" valign="top" class="textOverBackgroundCharts">
							<font style="font-family: Verdana" color="#FFFFFF"> 
							<input	type="hidden" name="autobidrfn"	value='<c:out value="${autobidrfn}" />'	id="WC_AutoBidForm_FormInput_autobidrfn_In_BidBorm_1" /> 
							<c:out	value="${autobidrfn}" /> 
							</font>
							</td>
						</tr>
						
					</table>
					<table id="WC_AutoBidForm_Table_7" cellpadding="1"	cellspacing="2" width="580" border="0">								
						<tr>
							<td id="WC_AutoBidForm_TableCell_9" align="left">
							<label for="WC_AutoBidForm_FormInput_bidval_In_BidBorm_1">
							<font	class="productName"> 
							<fmt:message key="AuctionCommonText_BidPricePerItem" bundle="${storeText}" /> 
							</font>
							</label>
							</td>										
							<td id="WC_AutoBidForm_TableCell_10" align="left">
							<font	class="price"> 										
							<c:out value="${auction.prefix}" escapeXml="false"/>
							<c:if	test="${autobid_action == 'create'}">											
								<input type="text" size="16" maxlength="16" name="bidval"	value="" id="WC_AutoBidForm_FormInput_bidval_In_BidBorm_1" />
								
							</c:if> 
							<c:if test="${autobid_action == 'update'}">
								<input type="hidden" name="bidval"	value="last_bidval" id="WC_AutoBidForm_FormInput_bidval_In_BidBorm_2" />
								<script>document.write(numberToCurrency( "<c:out value="${last_bidval}"/>", "<c:out value="${currency}" />","<c:out value="${langId}" />" ));</script>											
								<input type="hidden" name="autobid_id"	value='<c:out value="${autobid_id}" />'	id="WC_AutoBidForm_FormInput_autobid_id_In_BidBorm_1" />
							</c:if> 
							<c:out value="${auction.suffix}" escapeXml="false"/>
							</font>
							</td>
						</tr>
						<tr>
							<td id="WC_AutoBidForm_TableCell_11" align="left">
							<label for="WC_AutoBidForm_FormInput_maxbidlimit_In_BidBorm_1">
							<font	class="productName"> 
							<fmt:message key="AutoBid_highLimit" bundle="${storeText}" /> 
							</font>
							</label>
							</td>
							<c:set var="formattedMaxBidval" value="" />										
							<td id="WC_AutoBidForm_TableCell_12" align="left">
							<font class="price"> 
							<c:out value="${auction.prefix}" escapeXml="false"/>
							<input	type="text" size="15" maxlength="16" name="maxbidlimit"	value="" id="WC_AutoBidForm_FormInput_maxbidlimit_In_BidBorm_1" />
							<c:out value="${auction.suffix}" escapeXml="false"/>
							</font> 
							<br/>
							</td>
						</tr>
						<tr>
							<td id="WC_AutoBidForm_TableCell_13" align="left">
							<label for="WC_AutoBidForm_FormInput_bidquant_In_BidBorm_1">
							<font	class="productName"> 
							<fmt:message key="AuctionCommonText_RequestedQuantity"	bundle="${storeText}" /><br />
							(<fmt:message key="Bid_inventory" bundle="${storeText}">
								<fmt:param value="${auction.formattedQuantity}" />
							</fmt:message> ) 
							<%-- This hidden input is set up for checking purpose in Javascript --%>
							<input type="hidden" name="inventory_js" value='<c:out value="${auction.quantity}" />'id="WC_AutoBidForm_FormInput_inventory_js_In_BidBorm_1" /> 
							</font>
							</label>
							</td>
							<td id="WC_AutoBidForm_TableCell_14" align="left">
							<c:if test="${autobid_action == 'create'}">
								<input type="text" size="17" name="bidquant" value="" id="WC_AutoBidForm_FormInput_bidquant_In_BidBorm_1" />
							</c:if> 
							<c:if test="${autobid_action == 'update'}">
								<input type="hidden" name="bidquant" value='<c:out value="${last_quant}" />'id="WC_AutoBidForm_FormInput_bidquant_In_BidBorm_2" />
								<script>document.write(numberToStr( "<c:out value="${last_quant}"/>", "<c:out value="${langId}" />" ));</script>
							</c:if>
							</td>
						</tr>							
					</table>
					<table id="WC_AutoBidForm_Table_8" cellpadding="1"	cellspacing="2" width="580" border="0">							
						<tr>
							<td id="WC_AutoBidForm_TableCell_15" align="left">
							<label for="WC_AutoBidForm_FormInput_bidquantflag_In_BidBorm_1">
							<font class="productName"> 
							<fmt:message key="AuctionCommonText_MsgPartialQuantityQuery" bundle="${storeText}" /> 
							</font> 
							</label>
							<input type="checkbox"	name="bidquantflg" value="On" id="WC_AutoBidForm_FormInput_bidquantflag_In_BidBorm_1" />
							</td>
						</tr>								
					</table>
					<%-- begin privacy box --%> <br />
					<table id="WC_AutoBidForm_Table_9" cellspacing="0"	cellpadding="0">							
						<tr>
							<td id="WC_AutoBidForm_TableCell_16" valign="top">
							<table id="WC_AutoBidForm_Table_10" cellpadding="3"	cellspacing="0" border="1" bgcolor="#FFFFCC" width="90%" align="left">
								
								<tr>
									<td id="WC_AutoBidForm_TableCell_17" align="left"	valign="top">
									<strong> 
									<fmt:message key="Privacy_Title" bundle="${storeText}" /> 
									</strong> <br />
									<fmt:message key="Privacy_Text7" bundle="${storeText}" />
									</td>
								</tr>											
							</table>
							</td>
						</tr>								
					</table>
					<%-- end privacy box --%> <br />
					<table id="WC_AutoBidForm_Table_11" cellpadding="1"	cellspacing="2" width="580" border="0">
						
						<tr bgcolor="#4C6178">
							<td id="WC_AutoBidForm_TableCell_18" align="left" valign="top" class="textOverBackgroundCharts">
							<font style="font-family: Verdana" color="#FFFFFF"> 
							<fmt:message key="Bid_paymentInfo" bundle="${storeText}" /> 
							</font>
							</td>
						</tr>
						
					</table>
					<br />
					<table id="WC_AutoBidForm_Table_12" cellpadding="1"	cellspacing="2" width="580" border="0">								
						<tr>
							<td id="WC_AutoBidForm_TableCell_19">
							<label for="WC_AutoBidForm_FormInput_PolicyChange_In_BidBorm_1">
							<font class="text">
							<fmt:message key="Bid_creditCardInfo" bundle="${storeText}" />
							</font>
							</label>
							<br />
							<select name="PolicyChange"	onchange="onPaymentPolicyRefresh()" id="WC_AutoBidForm_FormInput_PolicyChange_In_BidBorm_1">
								<option selected="selected"></option>
								<c:set var="index3" value="0" />
								<c:forEach var="policy" items="${policyArray}">
									<c:set var="index3" value="${index3 + 1}" />
									<c:set var="selectedString" value="" />
									<c:if test="${index3 == policyIndex}">
										<c:set var="selectedString" value=" selected" />
									</c:if>
									<option	<c:out value="${selectedstring}" />="<c:out value="${selectedString}" />"
										value='<c:out value="${index3}" />'><c:out	value="${policy.longDescription}" />
									</option>
								</c:forEach>
							</select> 
							<input type="hidden"	name="PaymentPolicyChangeAction" value="AutoBidCreateForm"	id="WC_AutoBidForm_FormInput_PaymentPolicyChangeAction_In_BidBorm_1" />
							</td>
						</tr>								
					</table>					
					<c:import url="../PaymentSection/${paymentPolicyDisplayName}">
						<c:param name="cardDesc" value="${paymentCardDesc}" />
						<c:param name="cardId" value="${paymentCardId}" />
						<c:param name="cardName" value="${paymentCardName}" />
						<c:param name="cardBrand" value="${paymentCardBrand}" />
						<c:param name="paymentString" value="${paymentPolicyString}" />
					</c:import> 
					<c:if	test="${autobid_action == 'create' and ! empty  auction_Deposit }">
						<table id="WC_AutoBidForm_Table_13" cellpadding="0"	cellspacing="0" border="0" width="550">									
							<tr>
								<td id="WC_AutoBidForm_TableCell_21">
								<label for="WC_AutoBidForm_FormInput_bidauthflg_In_BidBorm_1">
								<font class="price"> 
								<fmt:message key="Bid_depositRequired" bundle="${storeText}">
									<fmt:param value="${auction_Deposit}" />
								</fmt:message> 								
								</font> 
								</label>
								<br />
								<input type="checkbox" name="bidauthflg" value="On"	id="WC_AutoBidForm_FormInput_bidauthflg_In_BidBorm_1" /> 
								<fmt:message key="Bid_chargeDeposit" bundle="${storeText}" /></td>
							</tr>									
						</table>
					</c:if> 
					<c:if test="${!(autobid_action == 'create' and ! empty  auction_Deposit) }">
						<input type="hidden" name="bidauthflg" value="On" id="WC_AutoBidForm_FormInput_bidquthflg_In_BidBorm_2" />
					</c:if> 
					<br />
					<table id="WC_AutoBidForm_Table_14" cellpadding="1" cellspacing="2" width="580" border="0">								
						<tr bgcolor="#4C6178">
							<td id="WC_AutoBidForm_TableCell_22" align="left" valign="top"	class="textOverBackgroundCharts">
							<font	style="font-family: Verdana" color="#FFFFFF"> 
							<fmt:message key="Bid_shippingInfo" bundle="${storeText}" /> 
							</font>
							</td>
						</tr>
						
					</table>
					<wcbase:useBean id="abdb"	classname="com.ibm.commerce.user.beans.AddressBookDataBean"/>
					
					<table id="WC_AutoBidForm_Table_15" cellpadding="1" cellspacing="2" width="580" border="0">							
						<tr>
							<td id="WC_AutoBidForm_TableCell_23">
							<label for="WC_AutoBidForm_FormInput_bidbillrfn_In_BidBorm_1">
							<font class="productName"> 
							<fmt:message key="Bid_billTo" bundle="${storeText}" /> 
							</font>
							</label>
							</td>
							<td id="WC_AutoBidForm_TableCell_24">
							<select	name="bidbillrfn" size="1" id="WC_AutoBidForm_FormInput_bidbillrfn_In_BidBorm_1">
								<c:forEach var="address" items="${abdb.addressList}">									
									<option value='<c:out value="${address[0]}" />'>
									<c:out	value="${address[1]}" />
									</option>
								</c:forEach>
							</select>
							</td>
						</tr>
						<tr>
							<td id="WC_AutoBidForm_TableCell_25">
							<label for="WC_AutoBidForm_FormInput_bidshprfn_In_BidBorm_1">
							<font	class="productName"> 
							<fmt:message key="Bid_shipTo" bundle="${storeText}" /> 
							</font>
							</label>
							</td>
							<td id="WC_AutoBidForm_TableCell_26">
							<select name="bidshprfn" size="1" id="WC_AutoBidForm_FormInput_bidshprfn_In_BidBorm_1">
								<c:forEach var="address" items="${abdb.addressList}">
									<option value='<c:out value="${address[0]}" />'>
									<c:out	value="${address[1]}" />
									</option>
								</c:forEach>
							</select>
							</td>
						</tr>
						<tr>
							<td id="WC_AutoBidForm_TableCell_27">
							<label for="WC_AutoBidForm_FormInput_bidshpmod_In_BidBorm_1">
							<font	class="productName"> 
							<fmt:message key="Bid_shippingCarrier"	bundle="${storeText}" /> 
							</font>
							</label>
							</td>
							<td id="WC_AutoBidForm_TableCell_28">
							<%-- Make sure that fulfillment_id is set up in auctio table --%>
							<c:if test="${! empty fulfillmentCenterId }">
								<wcbase:useBean id="shippingdb" classname="com.ibm.commerce.fulfillment.beans.ShippingDataBean">
									<c:set property="catalogEntryId" value="${productId}"	target="${shippingdb}" />
									<c:set property="fulfillmentCenterId"	value="${fulfillmentCenterId}" target="${shippingdb}" />
									<c:set property="storeId" value="${auctionStoreId}"	target="${shippingdb}" />
									<c:set property="currency" value="${currency}"	target="${shippingdb}" />									
								</wcbase:useBean>	
							</c:if> 
							<select name="bidshpmod" size="1" id="WC_AutoBidForm_FormInput_bidshpmod_In_BidBorm_1" class="price">
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
									<c:set var="charges" value=" (${shippingdb.shippingCharges[count]})" />
									<c:set var="count" value="${count + 1}" />
									<option value='<c:out value="${shippingMode0}" />'>
									<c:out	value="${shippingMode1}" /><c:out value="${charges}" escapeXml="false"/>
									</option>
								</c:forEach>
								<c:if test="${count == 0}">
									<option value="1">Overnite-hd</option>
									<option value="2">Economy-hd</option>
								</c:if>
							</select></td>
						</tr>							
					</table>
					<br />
					<table id="WC_AutoBidForm_Table_16" cellpadding="1"	cellspacing="2" width="580" border="0">								
						<tr bgcolor="#4C6178">
							<td id="WC_AutoBidForm_TableCell_29" align="left" valign="top"	class="textOverBackgroundCharts">
							<!-- Start display for button -->
							<table id="WC_AutoBidForm_Table_17" cellpadding="0"	cellspacing="0" border="0">										
								<tr>
									<td id="WC_AutoBidForm_TableCell_30" bgcolor="#ff2d2d"	class="pixel">
									<img src='<c:out value="${jspStoreImgDir}" />images/lb.gif'	border="0" alt=""/>
									</td>
									<td id="WC_AutoBidForm_TableCell_31" bgcolor="#ff2d2d"	class="pixel">
									<img src='<c:out value="${jspStoreImgDir}" />images/lb.gif'	border="0" alt=""/>
									</td>
									<td id="WC_AutoBidForm_TableCell_32" class="pixel">
									<img src='<c:out value="${jspStoreImgDir}" />images/r_top.gif'	border="0" alt=""/>
									</td>
								</tr>
								<tr>
									<td id="WC_AutoBidForm_TableCell_33" bgcolor="#ff2d2d">
									<img src='<c:out value="${jspStoreImgDir}" />images/lb.gif'	border="0" alt=""/>
									</td>
									<td id="WC_AutoBidForm_TableCell_34" bgcolor="#ea2b2b">
									<table id="WC_AutoBidForm_Table_18" cellpadding="2"	cellspacing="0" border="0">										
										<tr>
											<td id="WC_AutoBidForm_TableCell_35" class="buttontext">
											<font color="#ffffff"> 
											<a	href="javascript:document.BidForm.submit()"	onclick="return CheckResubmitWithPayment()"
												style="color: #ffffff; text-decoration: none"	id="WC_AutoBidForm_Link_1"> 
												<fmt:message key="AuctionCommonText_Submit" bundle="${storeText}" />
											</a> 
											</font>											
											</td>
										</tr>										
									</table>
									</td>
									<td id="WC_AutoBidForm_TableCell_36" bgcolor="#7a1616">
									<img src='<c:out value="${jspStoreImgDir}" />images/db.gif'	border="0" alt=""/>
									</td>
								</tr>
								<tr>
									<td id="WC_AutoBidForm_TableCell_37" class="pixel">
									<img src='<c:out value="${jspStoreImgDir}" />images/l_bot.gif' alt=""/>
									</td>
									<td id="WC_AutoBidForm_TableCell_38" bgcolor="#7a1616"	class="pixel" valign="top">
									<img src='<c:out value="${jspStoreImgDir}" />images/db.gif'	border="0" alt=""/>
									</td>
									<td id="WC_AutoBidForm_TableCell_39" bgcolor="#7a1616"	class="pixel" valign="top">
									<img src='<c:out value="${jspStoreImgDir}" />images/db.gif'	border="0" alt=""/>
									</td>
								</tr>
									
							</table>
							<!-- End display for button -->
							</td>
							<td align="left" valign="top" class="textOverBackgroundCharts">
								<!-- Start display for button -->
								<table id="WC_AutoBidForm_Table_19" cellpadding="0"	cellspacing="0" border="0">
									<tbody>
										<tr>
											<td id="WC_AutoBidForm_TableCell_40" bgcolor="#ff2d2d" class="pixel">
											<img src='<c:out value="${jspStoreImgDir}" />images/lb.gif'	border="0" alt=""/>
											</td>
											<td id="WC_AutoBidForm_TableCell_41" bgcolor="#ff2d2d"	class="pixel">
											<img src='<c:out value="${jspStoreImgDir}" />images/lb.gif'	border="0" alt=""/>
											</td>
											<td id="WC_AutoBidForm_TableCell_42" class="pixel">
											<img src='<c:out value="${jspStoreImgDir}" />images/r_top.gif'	border="0" alt=""/>
											</td>
										</tr>
										<tr>
											<td bgcolor="#ff2d2d">
											<img src='<c:out value="${jspStoreImgDir}" />images/lb.gif'	border="0" alt=""/>
											</td>
											<td bgcolor="#ea2b2b">
											<table id="WC_AutoBidForm_Table_20" cellpadding="2"	cellspacing="0" border="0">
												<tbody>
													<tr>
														<td id="WC_AutoBidForm_TableCell_43" class="buttontext">
														<font color="#ffffff"> 
														<a href ="" onclick="return ClearBidForm()"	style="color: #ffffff; text-decoration: none"> 
														<fmt:message key="AuctionCommonText_Reset" bundle="${storeText}" />
														</a> 
														</font>
														</td>
													</tr>
												</tbody>
											</table>
											</td>
											<td bgcolor="#7a1616"><img src='<c:out value="${jspStoreImgDir}" />images/db.gif'	border="0" alt=""/>
											</td>
										</tr>
										<tr>
											<td id="WC_AutoBidForm_TableCell_44" class="pixel">
											<img src='<c:out value="${jspStoreImgDir}" />images/l_bot.gif' alt=""/>
											</td>
											<td id="WC_AutoBidForm_TableCell_45" bgcolor="#7a1616"	class="pixel" valign="top">
											<img src='<c:out value="${jspStoreImgDir}" />images/db.gif'	border="0" alt=""/>
											</td>
											<td id="WC_AutoBidForm_TableCell_46" bgcolor="#7a1616"	class="pixel" valign="top">
											<img src='<c:out value="${jspStoreImgDir}" />images/db.gif'	border="0" alt=""/>
											</td>
										</tr>
									</tbody>
								</table>
								<!-- End display for button -->
							</td>
						</tr>								
					</table>
					</form>
					</td>
				</tr>					
			</table>
		</c:if> <%-- end for returnflag --%></td>
	</tr>
	
</table>
<%@ include file="../AuctionBidValidate.js"%>

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
	
	if("<c:out value="${last_maxbdlimit}"/>" !="")
	{
		self.document.BidForm.maxbidlimit.value=numberToCurrency("<c:out value="${last_maxbdlimit}"/>", "<c:out value="${currency}" />","<c:out value="${langId}" />");
	}
	
	//Win option field
	if( "<c:out value="${last_winopt}" />" == "P") {                 
		self.document.BidForm.bidquantflg.checked = true;
	}
	
	//NY_MARK5
	self.document.BidForm.PolicyChange.selectedIndex = <c:out value="${policyIndex}" />;
	if(<c:out value="${policyIndex}" /> >0 && <c:out value="${policyIndex}" /> < 1000) { 
		policyInit();	
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
             
setInitialValues();
</script>
</html>

