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
//*-------------------------------------------------------------------
//*
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="include/JSTLEnvironmentSetup.jspf" %>


<table cellpadding="0" cellspacing="0" border="0" width="600" id="WC_auc_rule_Table_1">	
	<tbody>
		<tr>
			<td bgcolor="#FFFFFF" width="600" valign="top" id="WC_auc_rule_TableCell_1" >
			<c:set var="aucrfn"	value="${WCParam.aucrfn}" />
			<c:set var="bidrfn"	value="${requestScope.bidrfn}" />
			<c:set var="autobidrfn"	value="${requestScope.autobidrfn}" />
			<c:set var="inGallery" value="false" />
			<c:set var="audaydur" value="0" />
			<c:set var="timeSeparator" value=":" />
			<c:set var="zeroDurTime" value="00${timeSeparator}00" />
			<c:set var="forum_id" value="1" />
			<wcbase:useBean id="auction" classname="com.ibm.commerce.negotiation.beans.AuctionDataBean">
				<c:set property="auctionId" value="${aucrfn}" target="${auction}" />
				<c:set property="shopperId" value="${userId}" target="${auction}" />
			</wcbase:useBean>
			<c:set var="auction_Type" value="${auction.auctionType}" />
			<c:set var="auction_Status"	value="${auction.status}" />
			<c:set var="aupricing" value="${auction.closePriceRule}" />
			<c:set var="auruletype"	value="${auction.closeType}" />
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
				<c:set var="aucDurTime"	value="${aucHourDur}${timeSeparator}${aucMinDur}" />
			</c:if> <c:set var="audesc" value="${auction.shortDescription}" />
			<c:set var="product_Desc" value="${auction.auctItemDesc}" />
			<c:choose>
				<%-- OpenCry --%>
				<c:when	test="${! empty bid_Rule and auction_Type=='O'}">
					<wcbase:useBean id="aOCControlRuleDataBean"	classname="com.ibm.commerce.negotiation.beans.OpenCryBidControlRuleDataBean">
						<c:set property="id" value="${bid_Rule}" target="${aOCControlRuleDataBean}" />
					</wcbase:useBean>
					<c:set var="brminval"
						value="${aOCControlRuleDataBean.formattedMinValue}" />
					<c:set var="brminquant"
						value="${aOCControlRuleDataBean.formattedMinQuant}" />
					<c:set var="numericRangeDataBeans"
						value="${aOCControlRuleDataBean.priceRanges}" />
				</c:when>
				<%-- SealedBid --%>
				<c:when	test="${! empty bid_Rule and auction_Type=='SB'}">
					<wcbase:useBean id="aSBControlRuleDataBean"	classname="com.ibm.commerce.negotiation.beans.SealedBidControlRuleDataBean">
						<c:set property="id" value="${bid_Rule}" target="${aSBControlRuleDataBean}" />
						<c:set var="brminval" value="${aSBControlRuleDataBean.formattedMinValue}" />
						<c:set var="brminquant"	value="${aSBControlRuleDataBean.formattedMinQuant}" />
					</wcbase:useBean>
				</c:when>
			</c:choose>

			<table cellpadding="1" cellspacing="2" width="580" border="0" id="WC_auc_rule_Table_2">
				<tbody>
					<tr>
						<td width="10" id="WC_auc_rule_TableCell_2">&nbsp;</td>
						<td align="left" valign="top" colspan="5" class="categoryspace"	width="580" id="WC_auc_rule_TableCell_3">
						<font class="pageHeading"> 
						<fmt:message key="auctionRulesMsg" bundle="${storeText}">
							<fmt:param value="${product_Desc}" />
						</fmt:message> 
						</font>

						<hr width="100%" noshade="noshade" align="left" />
						</td>
					</tr>
					<tr>
						<td width="10" id="WC_auc_rule_TableCell_4">&nbsp;</td>
						<td align="left" id="WC_auc_rule_TableCell_5">


						<table cellpadding="1" cellspacing="2" width="580" border="0" id="WC_auc_rule_Table_3">
							<tbody>
								<tr>
									<td width="400" id="WC_auc_rule_TableCell_6">
									<font class="productName"> 
									<fmt:message key="item" bundle="${storeText}">
										<fmt:param value="${product_Desc}" />
									</fmt:message> <br />
									</font>
									</td>
								</tr>
								<tr>
									<td width="400" id="WC_auc_rule_TableCell_7">
									<font class="text"> 
									<c:if test="${auction_Type == 'O'}">
										<fmt:message key="openCryMsg" bundle="${storeText}" />
										<br />
									</c:if> <c:if test="${auction_Type == 'SB'}">
										<fmt:message key="sealedBidMsg" bundle="${storeText}" />
										<br />
									</c:if> <c:if test="${auction_Type == 'D'}">
										<fmt:message key="dutchMsg" bundle="${storeText}" />
										<br />
									</c:if> 
									</font>
									</td>
								</tr>
								<tr>
									<td width="400" id="WC_auc_rule_TableCell_8">
									<font class="text"> 
									<fmt:message key="quantityMsg" bundle="${storeText}">
										<fmt:param value="${auquant}" />
									</fmt:message> <br />
									</font>
									</td>
								</tr>

								<c:if test="${ aupricing == 'ND'}">
									<tr>
										<td id="WC_auc_rule_TableCell_9">
										<font class="text"> 
										<fmt:message key="nonDiscriminativeMsg" bundle="${storeText}" /> <br />
										<fmt:message key="nonDiscriminativeMsgDesc" bundle="${storeText}" />
										</font>
										</td>
									</tr>
								</c:if>
								<c:if test="${ aupricing == 'D'}">
									<tr>
										<td id="WC_auc_rule_TableCell_10">
										<font class="text"> 
										<fmt:message key="discriminiativeMsg" bundle="${storeText}" /> <br/>
										<fmt:message key="discriminiativeMsgDesc" bundle="${storeText}" />
										</font>
										</td>
									</tr>
								</c:if>


								<tr>
									<td width="400" id="WC_auc_rule_TableCell_11">
									<font class="text"> 
									<c:if test="${ (empty auminbid ) and (auction_Type=='O' || auction_Type == 'SB')}">
										<fmt:message key="noReservePriceMsg" bundle="${storeText}" />
										<br />
									</c:if> 
									<c:if test="${(! empty auminbid) and  (auction_Type=='O' || auction_Type == 'SB')}">
										<fmt:message key="reservePriceMsg" bundle="${storeText}" />
										<br />
									</c:if> 
									</font>
									</td>
								</tr>
								<tr>
									<td width="400" id="WC_auc_rule_TableCell_12">
									<font class="text"> 
									<c:if test="${auction_Type=='D'}">
										<fmt:message key="startingPriceMsg" bundle="${storeText}">
											<fmt:param value="${aucStartPrice}" />
										</fmt:message>
										<br />
										<fmt:message key="currentPriceMsg" bundle="${storeText}">
											<fmt:param value="${aucCurPrice}" />
										</fmt:message>
										<br />
									</c:if> 
									</font>
									</td>
								</tr>
								<tr>
									<td width="400" id="WC_auc_rule_TableCell_13">
									<font class="text"> 
									<c:if test="${! empty austdate }">
										<fmt:message key="AuctionRules_auctionStartsOn"	bundle="${storeText}">
											<fmt:param value="${aucStartTimestamp}" />
										</fmt:message>
										<br />
									</c:if> 
									</font>
									</td>
								</tr>
								<tr>
									<td width="400" id="WC_auc_rule_TableCell_14">
									<font class="text"> 
									<c:if test="${auruletype == '1'}">
										<fmt:message key="auctionEndsOn" bundle="${storeText}">
											<fmt:param value="${formattedAucEndTimestamp}" />
										</fmt:message>
										<br />
									</c:if> 
									<c:choose>
										<c:when test="${auruletype == '2' and audaydur == '0'}">
											<fmt:message key="timeDurationMsg" bundle="${storeText}">
												<fmt:param value="${aucDurTime}" />
											</fmt:message>
											<br />
										</c:when>
										<c:when	test="${auruletype == '2' and aucDurTime==zeroDurTime}">
											<fmt:message key="dayDurationMsg" bundle="${storeText}">
												<fmt:param value="${audaydurStr}" />
											</fmt:message>
											<br />
										</c:when>
										<c:when test="${auruletype=='2'}">
											<fmt:message key="dayTimeDurationMsg" bundle="${storeText}">
												<fmt:param value="${audaydurStr}" />
												<fmt:param value="${aucDurTime}" />
											</fmt:message>
											<br />
										</c:when>
									</c:choose> 
									<c:choose>
										<c:when test="${auruletype == '3' and audaydur==0}">
											<fmt:message key="auctionCloseMsg1" bundle="${storeText}">
												<fmt:param value="${aucDurTime}" />
												<fmt:param value="${formattedAucEndTimestamp}" />
											</fmt:message>
											<br />
										</c:when>
										<c:when
											test="${auruletype == '3' and aucDurTime==zeroDurTime}">
											<fmt:message key="auctionCloseMsg2" bundle="${storeText}">
												<fmt:param value="${audaydurStr}" />
												<fmt:param value="${formattedAucEndTimestamp}" />
											</fmt:message>
											<br />
										</c:when>
										<c:when test="${auruletype=='3'}">
											<fmt:message key="auctionCloseMsg3" bundle="${storeText}">
												<fmt:param value="${audaydurStr}" />
												<fmt:param value="${aucDurTime}" />
												<fmt:param value="${formattedAucEndTimestamp}" />
											</fmt:message>
											<br />
										</c:when>
									</c:choose> 
									<c:choose>
										<c:when test="${auruletype == '4' and audaydur==0}">
											<fmt:message key="auctionCloseMsg4" bundle="${storeText}">
												<fmt:param value="${formattedAucEndTimestamp}" />
												<fmt:param value="${aucDurTime}" />
											</fmt:message>
											<br />
										</c:when>
										<c:when
											test="${auruletype == '4' and aucDurTime==zeroDurTime}">
											<fmt:message key="auctionCloseMsg5" bundle="${storeText}">
												<fmt:param value="${formattedAucEndTimestamp}" />
												<fmt:param value="${audaydurStr}" />
											</fmt:message>
											<br />
										</c:when>
										<c:when test="${auruletype=='4'}">
											<fmt:message key="auctionCloseMsg6" bundle="${storeText}">
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
									<td width="400" id="WC_auc_rule_TableCell_15">
									<font class="text"> 
									<c:if test="${! empty audepost }">
										<fmt:message key="depositMsg" bundle="${storeText}">
											<fmt:param value="${audepost}" />
											<fmt:param value="" />
										</fmt:message>
									</c:if> 
									</font>
									</td>
								</tr>
								<tr>
									<td width="400" id="WC_auc_rule_TableCell_16">
									<font class="text"> 
									<c:if test="${! empty audesc}">
										<c:out value="${audesc}" />
									</c:if> 
									</font>
									</td>
								</tr>
							</tbody>
						</table>

						<c:if test="${! empty bid_Rule }">
							<table width="100%" id="WC_auc_rule_Table_4">
								<c:if test="${(! empty brminval) || (! empty brminquant)}">
									<tr>
										<td id="WC_auc_rule_TableCell_17">
										<font class="text"> 
										<b><fmt:message key="bidControlRules" bundle="${storeText}" />
										</b> 
										</font>
										</td>
									</tr>
								</c:if>
								<c:if test="${! empty brminval}">
									<tr>
										<td id="WC_auc_rule_TableCell_18">
										<font class="text"> 
										<fmt:message key="minBidValue" bundle="${storeText}">
											<fmt:param value="${brminval}" />
											<fmt:param value="" />
										</fmt:message> 
										</font>
										</td>
									</tr>
								</c:if>
								<c:if test="${! empty brminquant}">
									<tr>
										<td id="WC_auc_rule_TableCell_19">
										<font class="text"> 
										<fmt:message key="minBidQuantity" bundle="${storeText}">
											<fmt:param value="${brminquant}" />
										</fmt:message> 
										</font>
										</td>
									</tr>
								</c:if>
							</table>
						
							<c:if test="${! empty numericRangeDataBeans  }">
								<table width="600" id="WC_auc_rule_Table_5">
									<tbody>
										<tr>
											<td width="250" id="WC_auc_rule_TableCell_20">
											<font class="text"> 
											<b><fmt:message	key="bidValueRange" bundle="${storeText}" /></b> 
											</font>
											</td>
											<td width="200" id="WC_auc_rule_TableCell_21">
											<font class="text"> 
											<b>
											<fmt:message key="increment" bundle="${storeText}" /></b> 
											</font>
											</td>
										</tr>
										<c:forEach var="numericRangeDataBean" items="${numericRangeDataBeans}" varStatus="aStatus">
											<c:set var="ll"	value="${numericRangeDataBean.formattedLowerLimit}" />
											<c:set var="ul"	value="${numericRangeDataBean.formattedUpperLimit}" />
											<c:set var="inc" value="${numericRangeDataBean.formattedIncrement}" />
											<tr>
												<td width="200" id="WC_auc_rule_TableCell_21_<c:out value="${aStatus.count}"/>_1">
												<font class="text"> 
												<c:out value="${ll}" />	- <c:out value="${ul}" /> 
												</font>
												</td>
												<td width="200" id="WC_auc_rule_TableCell_21_<c:out value="${aStatus.count}"/>_2">
												<font class="text"> 
												<c:out value="${inc}" />
												</font>
												</td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</c:if>
						</c:if>


						<hr width="100%" noshade="noshade" align="left" />

						<table id="WC_auc_rule_Table_6">
							<tbody>
								<tr>
									<%-- enter autobids for Future Open Cry --%>
									<c:choose>
										<c:when	test="${auction_Status=='F' and auction_Type=='O'}">
											<td class="buttonStyle" id="WC_auc_rule_TableCell_22">
											<font class="buttonStyle"> 
											<c:choose>
												<%-- if we have a bidref, we directly start AuctionArea/BidSection/AutoBidSubSection/auc_autobidform.jsp --%>
												<c:when	test="${! empty autobidrfn }">
													<a	href='UpdateGallery?storeId=<c:out value="${storeId}" />&catalogId=<c:out value="${catalogId}" />&aucrfn=<c:out value="${aucrfn}" />&autobidrfn=<c:out value="${autobidrfn}" />&GA=1&VR=1&URL=AutoBidCreateFormView' id="WC_auc_rule_Link_1">
													<b><fmt:message key="newAutoBid" bundle="${storeText}" /></b>
													</a>
												</c:when>
												<%-- else we call cmd AutoBidCreateForm --%>
												<c:otherwise>
													<a	href='AutoBidCreateForm?storeId=<c:out value="${storeId}" />&catalogId=<c:out value="${catalogId}" />&aucrfn=<c:out value="${aucrfn}" />' id="WC_auc_rule_Link_2">
													<b><fmt:message key="newAutoBid" bundle="${storeText}" /></b>
													</a>
												</c:otherwise>
											</c:choose> <%-- if we have a bidref, we directly start auc_bidformd.jsp --%>
											<c:if test="${! empty bidrfn }">
												<a href='UpdateGallery?storeId=<c:out value="${storeId}" />&catalogId=<c:out value="${catalogId}" />&aucrfn=<c:out value="${aucrfn}" />&bidrfn=<c:out value="${bidrfn}" />&GA=1&VR=1&URL=BidCreateFormView' id="WC_auc_rule_Link_3">
												<b><fmt:message key="newBid" bundle="${storeText}" /></b>
												</a>
											</c:if> </font></td>
										</c:when>
										<%-- enter autobids and bids for Current Open Cry --%>
										<c:when	test="${auction_Status == 'C' and auction_Type == 'O'}">
											<td class="buttonStyle" id="WC_auc_rule_TableCell_23">
											<font class="buttonStyle"> 
											<c:choose>
												<%-- if we have a bidref, we directly start AuctionArea/BidSection/AutoBidSubSection/auc_autobidform.jsp --%>
												<c:when	test="${! empty autobidrfn}">
													<a href='UpdateGallery?storeId=<c:out value="${storeId}" />&catalogId=<c:out value="${catalogId}" />&aucrfn=<c:out value="${aucrfn}" />&autobidrfn=<c:out value="${autobidrfn}" />&GA=1&VR=1&URL=AutoBidCreateFormView' id="WC_auc_rule_Link_4">
													<b><fmt:message key="txtNewOrderBid" bundle="${storeText}" /></b> </a>
												</c:when>
												<%-- else we call cmd AutoBidCreateForm --%>
												<c:otherwise>
													<a href='AutoBidCreateForm?storeId=<c:out value="${storeId}" />&catalogId=<c:out value="${catalogId}" />&aucrfn=<c:out value="${aucrfn}" />' id="WC_auc_rule_Link_5">
													<b><fmt:message key="txtNewOrderBid" bundle="${storeText}" /></b> </a>
												</c:otherwise>
											</c:choose> <%-- if we have a bidref, we directly start auc_bidformd.jsp --%>
											<c:if test="${! empty bidrfn }">
												<a	href='UpdateGallery?storeId=<c:out value="${storeId}" />&catalogId=<c:out value="${catalogId}" />&aucrfn=<c:out value="${aucrfn}" />&bidrfn=<c:out value="${bidrfn}" />&GA=1&VR=1&URL=BidCreateFormView' id="WC_auc_rule_Link_6">
												<b><fmt:message key="txtNewBid" bundle="${storeText}" /></b>
												</a>
											</c:if> 
											<c:if test="${empty bidrfn }">
												<a href='BidCreateForm?storeId=<c:out value="${storeId}" />&catalogId=<c:out value="${catalogId}" />&aucrfn=<c:out value="${aucrfn}" />' id="WC_auc_rule_Link_7">
												<b><fmt:message key="txtNewBid" bundle="${storeText}" /></b>
												</a>
											</c:if> 
											</font>
											</td>
										</c:when>
										<c:when test="${auction_Status == 'C'}">
											<td class="buttonStyle" id="WC_auc_rule_TableCell_24">
											<font class="buttonStyle"> 
											<c:choose>
												<%-- if we have a bidref, we directly start auc_bidformd.jsp --%>
												<c:when test="${! empty bidrfn }">
													<c:if test="${auction_Type != 'D' || currquant != '0'}">
														<a	href='UpdateGallery?storeId=<c:out value="${storeId}" />&catalogId=<c:out value="${catalogId}" />&aucrfn=<c:out value="${aucrfn}" />&bidrfn=<c:out value="${bidrfn}" />&GA=1&VR=1&URL=BidCreateFormView' id="WC_auc_rule_Link_8">
														<b><fmt:message key="txtNewBid" bundle="${storeText}" /></b>
														</a>
													</c:if>
												</c:when>
												<%-- else we call cmd BidCreateForm --%>
												<c:otherwise>
													<c:if test="${auction_Type != 'D' || currquant != '0'}">
														<a href='BidCreateForm?storeId=<c:out value="${storeId}" />&catalogId=<c:out value="${catalogId}" />&aucrfn=<c:out value="${aucrfn}" />' id="WC_auc_rule_Link_9">
														<b><fmt:message key="txtNewBid" bundle="${storeText}" /></b>
														</a>
													</c:if>
												</c:otherwise>
											</c:choose> 
											</font>
											</td>
										</c:when>
										<c:otherwise>
											<td id="WC_auc_rule_TableCell_25"></td>
										</c:otherwise>
									</c:choose>
									<c:if test="${inGallery == false}">
										<td class="buttonStyle" id="WC_auc_rule_TableCell_26">
										<font class="buttonStyle">										
										<a	href='UpdateGallery?storeId=<c:out value="${storeId}" />&catalogId=<c:out value="${catalogId}" />&aucrfn=<c:out value="${aucrfn}" />&GA=1&VR=1&URL=ShopperAuctionListView' id="WC_auc_rule_Link_10">
										<b><fmt:message key="addGallery" bundle="${storeText}" /></b>
										</a> </font></td>
									</c:if>
								</tr>
								<tr>
									<td class="buttonStyle" id="WC_auc_rule_TableCell_27">
									<font class="buttonStyle"> 
									<c:choose>
										<c:when test="${auction_Status=='C'}">
											<a href='ProductDisplay?storeId=<c:out value="${storeId}" />&catalogId=<c:out value="${catalogId}" />&productId=<c:out value="${productId}" />&langId=<c:out value="${langId}" />&fromAuction=true' id="WC_auc_rule_Link_11">
											<b><fmt:message key="goToProductDetails" bundle="${storeText}" /></b> </a>
										</c:when>
										<c:otherwise>
											<a href='DisplayAuctionItem?storeId=<c:out value="${storeId}" />&catalogId=<c:out value="${catalogId}" />&aucrfn=<c:out value="${aucrfn}" />&productId=<c:out value="${productId}" />&langId=<c:out value="${langId}" />&fromAuction=true' id="WC_auc_rule_Link_12">
											<b><fmt:message key="goToProductDetails" bundle="${storeText}" /></b> </a>
										</c:otherwise>
									</c:choose> 
									</font>
									</td>
									<td class="buttonStyle" id="WC_auc_rule_TableCell_28">
									<font class="buttonStyle">									
									<a	href='ShopperForumMsgListView?storeId=<c:out value="${storeId}" />&catalogId=<c:out value="${catalogId}" />&aucrfn=<c:out value="${aucrfn}" />&forum_id=<c:out value="${forum_id}" />&viewstatus=P&msgstatus=A' id="WC_auc_rule_Link_13">
									<b><fmt:message key="viewDiscForum" bundle="${storeText}" /></b>
									</a> 
									</font>
									</td>
								</tr>
							</tbody>
						</table>

						</td>
					</tr>
				</tbody>
			</table>

			</td>
		</tr>
		
	</tbody>
</table>




