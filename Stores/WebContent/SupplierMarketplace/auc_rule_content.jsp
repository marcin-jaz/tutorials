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
<%@ taglib uri="/WEB-INF/flow.tld" prefix="flow" %>
<%@ include file="./include/JSTLEnvironmentSetup.jspf"%>

<c:if test="${CommandContext.sessionData != null}">
	<c:set var="sessionStoreId" value="${CommandContext.sessionData.storeId}" />
</c:if>
<c:if test="${sessionStoreId == null}">
	<c:set var="sessionStoreId" value="${CommandContext.storeId}" />
</c:if>
<c:set var="auctionStoreId" value="${WCParam.auctionStoreId}" />
<c:if test="${empty auctionStoreId}">
	<c:set var="auctionStoreId" value="${storeId}" />
</c:if>

<table border="0" cellpadding="0" cellspacing="0" width="790" id="WC_AuctionRule_Table_1">
<tr>
	

	<td valign="top" width="630" id="WC_AuctionRule_TableCell_2">
		<c:set var="aucrfn" value="${WCParam.aucrfn}" />
		<c:set var="bidrfn" value="${requestScope.bidrfn}" />
		<c:set var="autobidrfn" value="${requestScope.autobidrfn}" />
		<c:set var="inGallery" value="false" />
		<c:set var="audaydur" value="0" />
		<c:set var="timeSeparator" value=":" />
		<c:set var="zeroDurTime" value="00${timeSeparator}00" />
		<c:set var="forum_id" value="1" />

		<wcbase:useBean id="auction" classname="com.ibm.commerce.negotiation.beans.AuctionDataBean" >
			<c:set property="auctionId" value="${aucrfn}" target="${auction}" />
			<c:set property="shopperId" value="${userId}" target="${auction}" />
		</wcbase:useBean>
		
		<c:set var="auction_Type" value="${auction.auctionType}" /> 
		<c:set var="auction_Status" value="${auction.status}" /> 
		<c:set var="aupricing" value="${auction.closePriceRule}" /> 
		<c:set var="auruletype" value="${auction.closeType}" /> 
		<c:set var="auminbid" value="${auction.formattedAuctReservePrice}" /> 
		<c:set var="aucStartPrice" value="${auction.formattedOpenPrice}" /> 
		<c:set var="aucCurPrice" value="${auction.formattedAuctCurPrice}" /> 
		<c:set var="aucStartTimestamp" value="${auction.formattedStartTime}" /> 
		<c:set var="formattedAucEndTimestamp" value="${auction.formattedEndTime}" /> 
		<c:if test="empty formattedAucEndTimestamp">
			<c:set var="formattedAucEndTimestamp" value="${auction.formattedRealEndTime}" /> 
		</c:if>		
		<c:set var="audepost" value="${auction.formattedDeposit}" /> 
		<c:set var="bid_Rule" value="${auction.bidRuleId}" /> 
		<c:set var="productId" value="${auction.entryId}" /> 
		<c:set var="auquant" value="${auction.formattedQuantity}" /> 
		<c:set var="inGallery" value="${auction.inGallery}" /> 
		<c:set var="currency" value="${auction.currency}" /> 
		<c:if test="${auction_Type=='D'}">
			<c:set var="currquant" value="${auction.formattedCurrentQuantity}" /> 
		</c:if>
		<c:if test="${auruletype!='1'}">
			<c:set var="audaydur" value="${auction.durationDays}" /> 
			<c:set var="audaydurStr" value="${auction.durationDays}" /> 
			<c:set var="aucHourDur" value="${auction.auctDurationHour}" /> 
			<c:set var="aucMinDur" value="${auction.auctDurationMinute}" /> 
			<c:set var="aucDurTime" value="${aucHourDur}${timeSeparator}${aucMinDur}" /> 
		</c:if>
		<c:set var="audesc" value="auction.shortDescription" />
		<c:set var="product_Desc" value="${auction.auctItemDesc}" />
		<c:choose>
			<%-- OpenCry --%>
			<c:when test="${! empty bid_Rule && auction_Type=='O'}">
				<wcbase:useBean id="aOCControlRuleDataBean" classname="com.ibm.commerce.negotiation.beans.OpenCryBidControlRuleDataBean" >
					<c:set property="id" value="${bid_Rule}" target="${aOCControlRuleDataBean}" />
				</wcbase:useBean>
				<c:set var="brminval" value="${aOCControlRuleDataBean.formattedMinValue}" />
				<c:set var="brminquant" value="${aOCControlRuleDataBean.formattedMinQuant}" />
				<c:set var="numericRangeDataBeans" value="${aOCControlRuleDataBean.priceRanges}" />
			</c:when>
			<%-- SealedBid --%>
			<c:when test="${! empty bid_Rule && auction_Type=='SB'}">
				<wcbase:useBean id="aSBControlRuleDataBean" classname="com.ibm.commerce.negotiation.beans.SealedBidControlRuleDataBean" >
					<c:set property="id" value="${bid_Rule}" target="${aSBControlRuleDataBean}" />
					<c:set var="brminval" value="${aSBControlRuleDataBean.formattedMinValue}" />
					<c:set var="brminquant" value="${aSBControlRuleDataBean.formattedMinQuant}" />
				</wcbase:useBean>
			</c:when>
		</c:choose>	
          
		<table cellpadding="0" cellspacing="8" border="0" id="WC_AuctionRule_Table_2">
			<tr>
				<td align="left" valign="top" colspan="5" class="categoryspace" width="100%" id="WC_AuctionRule_TableCell_3">
					<h1>
						<fmt:message key="AuctionRules_Msg" bundle="${storeText}">
							<fmt:param value="${product_Desc}" />
						</fmt:message>	
					</h1>
					<hr width="100%" align="left" noshade="noshade"/> 
				</td>
			</tr>
			<tr>
				<td align="left" id="WC_AuctionRule_TableCell_4">
					<table cellpadding="0" cellspacing="1" width="100%" border="0" id="WC_AuctionRule_Table_3">
						<tr>
							<td id="WC_AuctionRule_TableCell_5">
								<font class="productName">
									<fmt:message key="AuctionRules_item" bundle="${storeText}">
										<fmt:param value="${product_Desc}" />
									</fmt:message>	
									<br />
								</font> 
							</td>
						</tr>
						<tr>
							<td id="WC_AuctionRule_TableCell_6">
								<font class="text">
									<c:if test="${auction_Type == 'O'}">
										<fmt:message key="AuctionRules_openCryMsg" bundle="${storeText}" /><br />
									</c:if>
									<c:if test="${auction_Type == 'SB'}">
										<fmt:message key="AuctionRules_sealedBidMsg" bundle="${storeText}" /><br />
									</c:if>
									<c:if test="${auction_Type == 'D'}">
										<fmt:message key="AuctionRules_dutchMsg" bundle="${storeText}" /><br />
									</c:if>
								</font>
							</td>
						</tr> 
						<tr>
							<td id="WC_AuctionRule_TableCell_7">
								<font class="text">
									<fmt:message key="AuctionRules_quantityMsg" bundle="${storeText}">
										<fmt:param value="${auquant}" />
									</fmt:message>	
									<br />
								</font>
							</td>
						</tr>
					<c:if test="${aupricing == 'ND'}">
						<tr>
							<td id="WC_AuctionRule_TableCell_8">
								<font class="text">
									<fmt:message key="AuctionRules_nonDiscriminativeMsg" bundle="${storeText}" />
								</font>
							</td>
						</tr>
					</c:if>	
					<c:if test="${ aupricing == 'D'}">
						<tr>
							<td id="WC_AuctionRule_TableCell_9">
								<font class="text">
									<fmt:message key="AuctionRules_discriminiativeMsg" bundle="${storeText}" />
								</font>
							</td>
						</tr>
					</c:if>	
						<tr>
							<td id="WC_AuctionRule_TableCell_10">
								<font class="text">
									<c:if test="${empty auminbid && (auction_Type=='O' || auction_Type == 'SB')}">
										<fmt:message key="AuctionRules_noReservePriceMsg" bundle="${storeText}" /> <br />
									</c:if>
									<c:if test="${! empty auminbid && (auction_Type=='O' || auction_Type == 'SB')}">
										<fmt:message key="AuctionRules_reservePriceMsg" bundle="${storeText}" /> <br />
									</c:if>
								</font>
							</td>
						</tr>
						<tr>
							<td id="WC_AuctionRule_TableCell_11">
								<font class="text">
									<c:if test="${auction_Type=='D'}">
										<fmt:message key="AuctionRules_startingPriceMsg" bundle="${storeText}">
											<fmt:param value="${aucStartPrice}" />
										</fmt:message>	
										<br />
										<fmt:message key="AuctionRules_currentPriceMsg" bundle="${storeText}">
											<fmt:param value="${aucCurPrice}" />
										</fmt:message>	
										<br />
									</c:if>
								</font>
							</td>
						</tr>
						<tr>
							<td id="WC_AuctionRule_TableCell_12">
								<font class="text">
									<c:if test="${! empty austdate}">
										<fmt:message key="AuctionRules_auctionStartsOn" bundle="${storeText}">
											<fmt:param value="${aucStartTimestamp}" />
										</fmt:message>	
										<br />
									</c:if>
								</font>
							</td>
						</tr>	
						<tr>
							<td id="WC_AuctionRule_TableCell_13">
								<font class="text">
									<c:if test="${auruletype == '1'}">
										<fmt:message key="AuctionRules_auctionEndsOn" bundle="${storeText}">
											<fmt:param value="${formattedAucEndTimestamp}" />
										</fmt:message>	
										<br />
									</c:if>
									<c:choose>
										<c:when test="${auruletype == '2' && audaydur==0}">
											<fmt:message key="AuctionRules_timeDurationMsg" bundle="${storeText}">
												<fmt:param value="${aucDurTime}" />
											</fmt:message>	
											<br />
										</c:when>
										<c:when test="${auruletype == '2' && aucDurTime==zeroDurTime}">
											<fmt:message key="AuctionRules_dayDurationMsg" bundle="${storeText}">
												<fmt:param value="${audaydurStr}" />
											</fmt:message>	
											<br />
										</c:when>
										<c:when test="${auruletype=='2'}">
											<fmt:message key="AuctionRules_dayTimeDurationMsg" bundle="${storeText}">
												<fmt:param value="${audaydurStr}" />
												<fmt:param value="${aucDurTime}" />
											</fmt:message>	
											<br />
										</c:when>
									</c:choose>	
									<c:choose>
										<c:when test="${auruletype == '3' && audaydur==0}">
											<fmt:message key="AuctionRules_auctionCloseMsg1" bundle="${storeText}">
												<fmt:param value="${aucDurTime}" />
												<fmt:param value="${formattedAucEndTimestamp}" />
											</fmt:message>	
											<br />
										</c:when>
										<c:when test="${auruletype == '3' && aucDurTime==zeroDurTime}">
											<fmt:message key="AuctionRules_auctionCloseMsg2" bundle="${storeText}">
												<fmt:param value="${audaydurStr}" />
												<fmt:param value="${formattedAucEndTimestamp}" />
											</fmt:message>	
											<br />
										</c:when>
										<c:when test="${auruletype=='3'}">
											<fmt:message key="AuctionRules_auctionCloseMsg3" bundle="${storeText}">
												<fmt:param value="${audaydurStr}" />
												<fmt:param value="${aucDurTime}" />
												<fmt:param value="${formattedAucEndTimestamp}" />
											</fmt:message>	
											<br />
										</c:when>
									</c:choose>	
									<c:choose>
										<c:when test="${auruletype == '4' && audaydur==0}">
											<fmt:message key="AuctionRules_auctionCloseMsg4" bundle="${storeText}">
												<fmt:param value="${formattedAucEndTimestamp}" />
												<fmt:param value="${aucDurTime}" />
											</fmt:message>	
											<br />
										</c:when>
										<c:when test="${auruletype == '4' && aucDurTime==zeroDurTime}">
											<fmt:message key="AuctionRules_auctionCloseMsg5" bundle="${storeText}">
												<fmt:param value="${formattedAucEndTimestamp}" />
												<fmt:param value="${audaydurStr}" />
											</fmt:message>	
											<br />
										</c:when>
										<c:when test="${auruletype=='4'}">
											<fmt:message key="AuctionRules_auctionCloseMsg6" bundle="${storeText}">
												<fmt:param value="${formattedAucEndTimestamp}" />
												<fmt:param value="${audaydurStr}" />
												<fmt:param value="${aucDurTime}" />
											</fmt:message>	
											<br />
										</c:when>
									</c:choose>	
								</font>
							</td>
							</tr>
							<tr>
								<td id="WC_AuctionRule_TableCell_14">
									<font class="text">
										<c:if test="${! empty audepost}">
											<fmt:message key="AuctionRules_depositMsg" bundle="${storeText}">
												<fmt:param value="${audepost}" />
												<fmt:param value="" />
											</fmt:message>	
										</c:if>
									</font>
								</td>
							</tr>
							<tr>
								<td id="WC_AuctionRule_TableCell_15">
									<font class="text">
										<c:if test="${! empty audesc }">
											<c:out value="${audesc}" />
										</c:if>
									</font>
								</td>
							</tr> 
						</table> 
					<c:if test="${! empty bid_Rule }" >
						
						<table width="100%" id="WC_AuctionRule_Table_4">
							<tr>	
								<td id="WC_AuctionRule_TableCell_16">
									<font class="text">
										<b><fmt:message key="AuctionRules_bidControlRules" bundle="${storeText}" /></b>
									</font>
								</td>
							</tr>						
						<c:if test="${! empty brminval}">
								<tr>
									<td id="WC_AuctionRule_TableCell_17">
										<font class="text">
											<fmt:message key="AuctionRules_minBidValue" bundle="${storeText}">
												<fmt:param value="${brminval}" />
											</fmt:message>	
										</font>
									</td>
								</tr>
						</c:if>
						<c:if test="${! empty brminquant}">
								<tr>
									<td id="WC_AuctionRule_TableCell_18">
										<font class="text">
											<fmt:message key="AuctionRules_minBidQuantity" bundle="${storeText}">
												<fmt:param value="${brminquant}" />
											</fmt:message>	
										</font>
									</td>
								</tr>
						</c:if>
						</table>
						<c:if test="${! empty numericRangeDataBeans }" >
							<table width="600" id="WC_AuctionRule_Table_5">
								<tr>
									<td width="250" id="WC_AuctionRule_TableCell_19">  
										<font class="text">
						                     <b><fmt:message key="AuctionRules_bidValueRange" bundle="${storeText}" /></b> 
										</font>
									</td>
									<td width="200" id="WC_AuctionRule_TableCell_20"> 
										<font class="text">
											<b><fmt:message key="AuctionRules_increment" bundle="${storeText}" /></b> 
										</font>
									</td>
								</tr>                
							<c:forEach var="numericRangeDataBean" items="${numericRangeDataBeans}"  varStatus="aStatus">
								<c:set var="ll" value="${numericRangeDataBean.formattedLowerLimit}" />
								<c:set var="ul" value="${numericRangeDataBean.formattedUpperLimit}" />
								<c:set var="inc" value="${numericRangeDataBean.formattedIncrement}" />
								<tr>
									<td width="200" id="WC_AuctionRule_TableCell_21">  
										<font class="text">
											<c:out value="${ll}" /> - <c:out value="${ul}" />
										</font>
									</td>
									<td width="200" id="WC_AuctionRule_TableCell_22">  
										<font class="text">
											<c:out value="${inc}" />
										</font>
									</td>
								</tr>                
							</c:forEach>
							</table>
						</c:if>
					</c:if>
					<hr width="100%" noshade="noshade" align="left" /> 
       
					<table id="WC_AuctionRule_Table_6">
						<tr>   
						<%-- enter autobids for Future Open Cry --%>
					<c:choose>	
						<c:when test="${auction_Status=='F' && auction_Type=='O'}" >
							<td class="buttonStyle" id="WC_AuctionRule_TableCell_23">
								<font class="buttonStyle">
									<c:choose>
										<%-- if we have a bidref, we directly start AuctionArea/BidSection/AutoBidSubSection/auc_autobidform.jsp --%>
										<c:when test="${! empty autobidrfn}">
											<a href="UpdateGallery?auctionStoreId=<c:out value="${auctionStoreId}" />&aucrfn=<c:out value="${aucrfn}" />&autobidrfn=<c:out value="${autobidrfn}" />&GA=1&VR=1&URL=AutoBidCreateFormView" id="WC_AuctionRule_Link_1">
												<b><fmt:message key="AuctionCommonText_NewAutoBid" bundle="${storeText}" /></b>
											</a>
										</c:when>
										<%-- else we call cmd AutoBidCreateForm --%>
										<c:otherwise>
											<a href="AutoBidCreateForm?auctionStoreId=<c:out value="${auctionStoreId}" />&aucrfn=<c:out value="${aucrfn}" />" id="WC_AuctionRule_Link_2">
												<b><fmt:message key="AuctionCommonText_NewAutoBid" bundle="${storeText}" /></b>
											</a>
										</c:otherwise>
									</c:choose>						
									<%-- if we have a bidref, we directly start auc_bidformd.jsp --%>
									<c:if test="${! empty bidrfn }">
										<a href="UpdateGallery?auctionStoreId=<c:out value="${auctionStoreId}" />&aucrfn=<c:out value="${aucrfn}" />&bidrfn=<c:out value="${bidrfn}" />&GA=1&VR=1&URL=BidCreateFormView" id="WC_AuctionRule_Link_3">
											<b><fmt:message key="AuctionCommonText_NewBid" bundle="${storeText}" /></b>
										</a>
									</c:if>
								</font>
							</td>
						</c:when>
						<%-- enter autobids and bids for Current Open Cry --%>
						<c:when test="${auction_Status == 'C' && auction_Type == 'O'}">
							<td class="buttonStyle" id="WC_AuctionRule_TableCell_24">
								<font class="buttonStyle">
									<c:choose>
										<%-- if we have a bidref, we directly start AuctionArea/BidSection/AutoBidSubSection/auc_autobidform.jsp --%>
										<c:when test="${! empty autobidrfn}">
											<a href="UpdateGallery?auctionStoreId=<c:out value="${auctionStoreId}" />&aucrfn=<c:out value="${aucrfn}" />&autobidrfn=<c:out value="${autobidrfn}" />&GA=1&VR=1&URL=AutoBidCreateFormView" id="WC_AuctionRule_Link_4">
												<b><fmt:message key="AuctionCommonText_NewAutoBid" bundle="${storeText}" /></b>
											</a>
										</c:when>
										<%-- else we call cmd AutoBidCreateForm --%>
										<c:otherwise>
											<a href="AutoBidCreateForm?auctionStoreId=<c:out value="${auctionStoreId}" />&aucrfn=<c:out value="${aucrfn}" />" id="WC_AuctionRule_Link_5">
												<b><fmt:message key="AuctionCommonText_NewAutoBid" bundle="${storeText}" /></b>
											</a>
										</c:otherwise>
									</c:choose>
									<%-- if we have a bidref, we directly start auc_bidformd.jsp --%>
									<c:if test="${! empty bidrfn}">
										<a href="UpdateGallery?auctionStoreId=<c:out value="${auctionStoreId}" />&aucrfn=<c:out value="${aucrfn}" />&bidrfn=<c:out value="${bidrfn}" />&GA=1&VR=1&URL=BidCreateFormView" id="WC_AuctionRule_Link_6">
											<b><fmt:message key="AuctionCommonText_NewBid" bundle="${storeText}" /></b>
										</a>
									</c:if>
									<c:if test="${empty bidrfn}" >
										<a href="BidCreateForm?auctionStoreId=<c:out value="${auctionStoreId}" />&aucrfn=<c:out value="${aucrfn}" />" id="WC_AuctionRule_Link_7">
											<b><fmt:message key="AuctionCommonText_NewBid" bundle="${storeText}" /></b>
										</a>
									</c:if>
								</font>
							</td>
						</c:when>
						<c:when test="${auction_Status == 'C'}">
							<td class="buttonStyle" id="WC_AuctionRule_TableCell_25">
								<font class="buttonStyle">
									<c:choose>
										<%-- if we have a bidref, we directly start auc_bidformd.jsp --%>
										<c:when test="${! empty bidrfn}">
											<c:if test="${auction_Type != 'D' || currquant != '0'}">
												<a href="UpdateGallery?auctionStoreId=<c:out value="${auctionStoreId}" />&aucrfn=<c:out value="${aucrfn}" />&bidrfn=<c:out value="${bidrfn}" />&GA=1&VR=1&URL=BidCreateFormView" id="WC_AuctionRule_Link_8">
													<b><fmt:message key="AuctionCommonText_NewBid" bundle="${storeText}" /></b>
												</a>
											</c:if>
										</c:when>
										<%-- else we call cmd BidCreateForm --%>
										<c:otherwise>
											<c:if test="${auction_Type != 'D' || currquant != '0'}">
												<a href="BidCreateForm?auctionStoreId=<c:out value="${auctionStoreId}" />&aucrfn=<c:out value="${aucrfn}" />" id="WC_AuctionRule_Link_9">
													<b><fmt:message key="AuctionCommonText_NewBid" bundle="${storeText}" /></b>
												</a>
											</c:if>
										</c:otherwise>
									</c:choose>			
								</font>
							</td>
						</c:when>
						<c:otherwise>
							<td id="WC_AuctionRule_TableCell_26"></td>
						</c:otherwise>
					</c:choose>	
					<c:if test="${inGallery == false}">
							<td class="buttonStyle" id="WC_AuctionRule_TableCell_27">
								<font class="buttonStyle">
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									<a href="UpdateGallery?storeId=<c:out value="${sessionStoreId}" />&aucrfn=<c:out value="${aucrfn}" />&GA=1&VR=1&URL=ShopperAuctionListView" id="WC_AuctionRule_Link_10">
										<b><fmt:message key="AuctionRules_addGallery" bundle="${storeText}" /></b>
									</a>
								</font>
							</td>
					</c:if>
			            </tr>
			            <tr>
            			   <td class="buttonStyle" id="WC_AuctionRule_TableCell_28">
								<font class="buttonStyle">
									<c:choose>
										<c:when test="${auction_Status=='C'}">
											<a href="ProductDisplay?storeId=<c:out value="${sessionStoreId}" />&productId=<c:out value="${productId}" />&langId=<c:out value="${langId}" />&fromAuction=true" id="WC_AuctionRule_Link_11">
												<b><fmt:message key="AuctionRules_goToProductDetails" bundle="${storeText}" /></b>
											</a>
										</c:when>
										<c:otherwise>
											<a href="DisplayAuctionItem?aucrfn=<c:out value="${aucrfn}" />&auctionStoreId=<c:out value="${auctionStoreId}" />&productId=<c:out value="${productId}" />&langId=<c:out value="${langId}" />&fromAuction=true" id="WC_AuctionRule_Link_12">
												<b><fmt:message key="AuctionRules_goToProductDetails" bundle="${storeText}" /></b>
											</a>
										</c:otherwise>
									</c:choose>
								</font>
			               </td>
			               <td class="buttonStyle" id="WC_AuctionRule_TableCell_29">
								<font class="buttonStyle">
				                  	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	        				        <a href="ShopperForumMsgListView?auctionStoreId=<c:out value="${auctionStoreId}" />&aucrfn=<c:out value="${aucrfn}" />&forum_id=<c:out value="${forum_id}" />&viewstatus=P&msgstatus=A" id="WC_AuctionRule_Link_13"> 
										<b><fmt:message key="AuctionRules_viewDiscForum" bundle="${storeText}" /></b>
									</a>
								</font>
			               </td>
            			</tr>
			         </table> 
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>


