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
<%@ include file="../../include/JSTLEnvironmentSetup.jspf" %>

<c:set var="status"	value="${WCParam.status}" /> 
<c:set var="aucrfn"	value="${WCParam.aucrfn}" /> 
<c:set var="yourBids" value="${WCParam.yourBids}" /> 
<c:set var="next" value="${WCParam.next}" /> 
<c:set var="count" value="5" /> 
<c:set var="flag" value="false" /> 
<c:if test="${! empty yourBids}">
	<c:set var="flag" value="true" />
</c:if> 
<c:set var="start" value="0" /> 
<c:if test="${! empty next }">
	<c:set var="start" value="${next}" />
</c:if> 
<%-- <c:set var="withdrawFlag" value="false" /> --%> 
<wcbase:useBean	id="aRegister" classname="com.ibm.commerce.user.beans.UserRegistrationDataBean" />

<c:set var="safname" value="${aRegister.firstName}" /> 
<c:set	var="samname" value="${aRegister.middleName}" /> 
<c:set	var="salname" value="${aRegister.lastName}" /> 
<c:if	test="${flag==true}">
	<wcbase:useBean id="auction" classname="com.ibm.commerce.negotiation.beans.AuctionDataBean">
		<c:set property="auctionId" value="${aucrfn}" target="${auction}" />
	</wcbase:useBean>
	<c:set var="productId" value="${auction.entryId}" />
	<c:set var="auction_Type" value="${auction.auctionType}" />								
	<c:set var="auction_Status" value="${auction.status}" />				
	<c:set var="product_Desc" value="${auction.auctItemDesc}" />
	<c:set var="prnbr" value="${auction.auctItemSKU}" />
</c:if>


<table cellpadding="1" cellspacing="2" width="580" border="0" id="WC_ShopperBidListDisplay_Table_2">
	<tbody>
		<tr>
			<td width="10" id="WC_ShopperBidListDisplay_TableCell_2">&nbsp;</td>
			<td align="left" valign="top" colspan="5" class="categoryspace"	width="580" id="WC_ShopperBidListDisplay_TableCell_3">
			<font class="pageHeading"> 
			<fmt:message key="bidsSubmittedBy" bundle="${storeText}">
				<fmt:param value="${safname}" />
				<fmt:param value="${samname}" />
				<fmt:param value="${salname}" />
			</fmt:message> 
			<br />
			<c:if test="${flag == true && ! empty product_Desc}">
				<c:out value="${product_Desc}" />
			</c:if> 
			<c:if test="${!(flag == true && ! empty product_Desc )}">
				<c:if test="${status=='C'}">
					<fmt:message key="txtCurrentAuctions" bundle="${storeText}" />
				</c:if>
				<c:if test="${status=='F'}">
					<fmt:message key="txtFutureAuctions" bundle="${storeText}" />
				</c:if>
				<c:if test="${status != 'C' && status != 'F' }">
					<fmt:message key="txtRecentlyClosedAuctions"
						bundle="${storeText}" />
				</c:if>
			</c:if> 
			</font>

			<hr width="100%" noshade="noshade" align="left" />
			</td>
		</tr>
		<tr>
			<td width="10" id="WC_ShopperBidListDisplay_TableCell_4">&nbsp;</td>
			<td id="WC_ShopperBidListDisplay_TableCell_5">
			<c:if test="${flag == false || (flag == true && (auction_Type == 'O' || auction_Type == 'SB'))}">
				<wcbase:useBean id="anAutoBidList"	classname="com.ibm.commerce.negotiation.beans.AutoBidListBean">
					<c:set property="ownerId" value="${userId}"	target="${anAutoBidList}" />
					<c:set property="autoBidStatus" value="A" target="${anAutoBidList}" />
					<c:if test="${flag == true}">
						<c:set property="auctionId" value="${aucrfn}"	target="${anAutoBidList}" />
					</c:if>
					<c:if test="${status=='C'}">
						<c:set property="auctionStatusString" value="C"	target="${anAutoBidList}" />
					</c:if>
					<c:if test="${status=='F'}">
						<c:set property="auctionStatusString" value="F"	target="${anAutoBidList}" />
					</c:if>
					<c:if test="${status != 'C' && status != 'F'}">
						<c:set property="auctionStatusString" value="BC;SC"	target="${anAutoBidList}" />
					</c:if>
				</wcbase:useBean>
				<c:set var="length1" value="${anAutoBidList.autoBidsNum}" />

				<c:if test="${ length1 gt start}">

					<font class="productName"> 
					<fmt:message key="yourAutobids"	bundle="${storeText}" /> 
					<br />
					<c:if test="${status=='C' || status=='F'}">
						<fmt:message key="modifyAutobidMsg" bundle="${storeText}" />
					</c:if> <br />
					</font>
					<br />
					<table cellpadding="1" cellspacing="2" width="580" border="0" id="WC_ShopperBidListDisplay_Table_3">
						<tbody>
							<tr>
								<td align="left" valign="top" class="textOverBackgroundCharts" id="WC_ShopperBidListDisplay_TableCell_6">
								<font class="textOverBackgroundCharts"> 
								<fmt:message key="product"	bundle="${storeText}" /> 
								</font>
								</td>
								<td align="left" valign="top" class="textOverBackgroundCharts" id="WC_ShopperBidListDisplay_TableCell_7">
								<font class="textOverBackgroundCharts"> 
								<fmt:message key="upperLimit" bundle="${storeText}" />
								<br />
								<fmt:message key="currentBid" bundle="${storeText}" />
								<br />
								(<fmt:message key="quantity1" bundle="${storeText}" />)
								</font>
								</td>
								<td align="left" valign="top" class="textOverBackgroundCharts" id="WC_ShopperBidListDisplay_TableCell_8">
								<font class="textOverBackgroundCharts"> 
								<fmt:message key="bdNumber" bundle="${storeText}" />
								<br />
								<fmt:message key="dateTime" bundle="${storeText}" /> 
								</font>
								</td>
								<td align="left" valign="top" class="textOverBackgroundCharts" id="WC_ShopperBidListDisplay_TableCell_9">
								<%-- Withdraw --%> 
								<font class="textOverBackgroundCharts"> 
								<fmt:message key="withdraw" bundle="${storeText}" /> 
								</font>
								</td>
							</tr>

							<c:set var="end1" value="${start + count}" />
							<c:if test="${end1 > length1}">
								<c:set var="end1" value="${length1}" />
							</c:if>

							<c:forEach var="anAutoBid" items="${anAutoBidList.autoBids}" begin="${start}" end="${end1-1 }" varStatus="aStatus">
								<c:set property="commandContext" value="${CommandContext}"	target="${anAutoBid}" />
								<c:set var="autobid_id" value="${anAutoBid.autoBidId}" />
								<c:set var="obrefnum" value="${anAutoBid.referenceCode}" />
								<c:set var="obquant" value="${anAutoBid.formattedBidQuantity}" />
								<c:set var="obdate" value="${anAutoBid.formattedCreationTime}" />
								<c:set var="bd_bid_Value" value="${anAutoBid.initialBidPrice}" />
								<c:set var="obaucref" value="${anAutoBid.auctionId}" />
								<c:set var="auctStoreId" value="${anAutoBid.storeId}" />
								<c:if test="${flag==false}">
									<c:set var="auction_Status" value="${anAutoBid.auctionDataBean.status}" />
									<c:set var="auction_Type" value="${anAutoBid.auctionDataBean.auctionType}" />
									<c:set var="productId" value="${anAutoBid.auctionDataBean.entryId}" />
									<c:set var="product_Desc" value="${anAutoBid.auctionDataBean.auctItemDesc}" />
									<c:set var="prnbr" value="${anAutoBid.auctionDataBean.auctItemSKU}" />
								</c:if>		

								<c:set var="formattedBidValue"	value="${anAutoBid.formattedInitBidPrice}" />
								<c:set var="formattedObMaxBdLimit"	value="${anAutoBid.formattedMaxBidLimit}" />

								<c:if test="${auctStoreId eq storeId}">

									<tr>
										<%-- first column --%>
										<td id="WC_ShopperBidListDisplay_TableCell_10_<c:out value="${aStatus.count}"/>">
										<font class="text"> 
										<c:choose>
											<c:when test="${auction_Status=='C'}">
												<a	href='ProductDisplay?storeId=<c:out value="${storeId}" />&catalogId=<c:out value="${catalogId}" />&productId=<c:out value="${productId}" />&langId=<c:out value="${lang}" />&fromAuction=true' id="WC_ShopperBidListDisplay_Link_1_<c:out value="${aStatus.count}"/>">
												<c:out value="${product_Desc}" /> 
												</a>
												<br />
												(<c:out value="${prnbr}" />)<br />
											</c:when>
											<c:otherwise>
												<a	href='DisplayAuctionItem?aucrfn=<c:out value="${bdaucref}" />&storeId=<c:out value="${storeId}" />&catalogId=<c:out value="${catalogId}" />&productId=<c:out value="${productId}" />&langId=<c:out value="${lang}" />&fromAuction=true' id="WC_ShopperBidListDisplay_Link_2_<c:out value="${aStatus.count}"/>">
												<c:out value="${product_Desc}" /> 
												</a>
												<br />
												(<c:out value="${prnbr}" />)<br />
											</c:otherwise>
										</c:choose> 
										<c:if test="${auction_Type=='O' || auction_Type=='D'}">
											<c:if test="${status == 'C' || status == 'F'}">
												<a	href='BidListView?storeId=<c:out value="${storeId}" />&catalogId=<c:out value="${catalogId}" />&aucrfn=<c:out value="${obaucref}" />' id="WC_ShopperBidListDisplay_Link_3_<c:out value="${aStatus.count}"/>">
												<fmt:message key="txtSeeAllBids"	bundle="${storeText}" /> </a>
											</c:if>
										</c:if> 
										</font>
										</td>

										<%-- 2nd column --%>
										<td id="WC_ShopperBidListDisplay_TableCell_11_<c:out value="${aStatus.count}"/>">
										<font class="text"> 
										<font class="price">
										<c:out	value="${formattedObMaxBdLimit}" escapeXml="false"/>
										</font> 
										<br />
										<font class="price">
										<c:out value="${formattedBidValue}" escapeXml="false"/>
										</font>
										<br />
										(<c:out value="${obquant}" />) <br />
										<c:if test="${auction_Status=='C' || auction_Status=='F' && (auction_Type=='O' || auction_Type == 'SB')}">
											<c:if test="${empty autoBidId}">
												<a	href='AutoBidUpdateForm?storeId=<c:out value="${storeId}" />&catalogId=<c:out value="${catalogId}" />&aucrfn=<c:out value="${obaucref}" />&autobid_id=<c:out value="${autobid_id}" />' id="WC_ShopperBidListDisplay_Link_4_<c:out value="${aStatus.count}"/>">
												<fmt:message key="modifyAutobid" bundle="${storeText}" /> 
												</a>
											</c:if>
										</c:if> 
										</font></td>

										<%-- 3rd column --%>
										<td id="WC_ShopperBidListDisplay_TableCell_12_<c:out value="${aStatus.count}"/>">
										<font class="text"> 
										<c:out value="${obrefnum}" /> <br />
										<c:out value="${obdate}" /> 
										</font>
										</td>

										<%-- 4th column --%>
										<td id="WC_ShopperBidListDisplay_TableCell_13_<c:out value="${aStatus.count}"/>">
										<font class="text"> 
										<c:choose>
											<c:when	test="${auction_Status=='C' || auction_Status=='F' && (auction_Type=='O' || auction_Type=='SB')}">
												<a	href='AutoBidDelete?storeId=<c:out value="${storeId}" />&catalogId=<c:out value="${catalogId}" />&autobid_id=<c:out value="${autobid_id}" />&URL=ShopperBidListView&status=<c:out value="${status}" />' id="WC_ShopperBidListDisplay_Link_5_<c:out value="${aStatus.count}"/>">
												<fmt:message key="withdraw" bundle="${storeText}" />
												</a>
											</c:when>
											<c:otherwise>
													--
												</c:otherwise>
										</c:choose> 
										</font></td>
									</tr>
								</c:if>
							</c:forEach>
						</tbody>
					</table>
					<br />
					<c:if test="{status ne 'F'}">
						<hr width="100%" />
					</c:if>
				</c:if>
				<c:if test="${length1 eq 0}">
					<font class="productName"> <tt> 
					<c:choose>
						<c:when	test="${flag==true && ! empty product_Desc}">
							<fmt:message key="noAutoBidMsg4" bundle="${storeText}">
								<fmt:param value="${product_Desc}" />
							</fmt:message>
						</c:when>
						<c:otherwise>
							<c:choose>
								<c:when test="${status=='C'}">
									<fmt:message key="noAutoBidMsg1" bundle="${storeText}" />
								</c:when>
								<c:when test="${status=='F'}">
									<fmt:message key="noAutoBidMsg3" bundle="${storeText}" />
								</c:when>
								<c:otherwise>
									<fmt:message key="noAutoBidMsg2" bundle="${storeText}" />
								</c:otherwise>
							</c:choose>
						</c:otherwise>
					</c:choose> </tt> </font>
				</c:if>

			</c:if> <%-- Show bids for Current or Future Auctions only   --%>
			<c:if test="${status != 'F'}">
				<wcbase:useBean id="aBidList"	classname="com.ibm.commerce.negotiation.beans.BidListBean">
					<c:set property="bidOwnerId" value="${userId}"	target="${aBidList}" />
					<c:set property="multipleBidStatusStr" value="A;W;WF;C"	target="${aBidList}" />
					<c:if test="${flag==true}">
						<c:set property="bidAuctionId" value="${aucrfn}" target="${aBidList}" />
					</c:if>
					<c:choose>
						<c:when test="${status=='C'}">
							<c:set property="multipleAuctionStatusStr" value="C" target="${aBidList}" />
						</c:when>
						<c:otherwise>
							<c:set property="multipleAuctionStatusStr" value="BC;SC" target="${aBidList}" />
						</c:otherwise>
					</c:choose>
				</wcbase:useBean>
				<c:set var="length2" value="${aBidList.bidsNum}" />
				<c:if test="${length2 > 0}">
					<c:if test="${length2 > start}">
						<br />
						<c:if	test="${flag==false || (flag==true && (auction_Type == 'O' || auction_Type=='SB'))}">
							<font class="productName"> 
							<fmt:message key="yourBidsMsg"	bundle="${storeText}" /><br />
							<c:if test="${status=='C'}">
								<fmt:message key="modifyBidsMsg" bundle="${storeText}" />
								<br />
							</c:if> 
							</font>
						</c:if>
						<br />
						<table cellpadding="1" cellspacing="2" width="580" border="0" id="WC_ShopperBidListDisplay_Table_4">
							<tbody>
								<tr>
									<td width="150" align="left" valign="top" class="textOverBackgroundCharts" id="WC_ShopperBidListDisplay_TableCell_14">
									<font class="textOverBackgroundCharts"> 
									<fmt:message key="product" bundle="${storeText}" /> 
									</font>
									</td>
									<td width="130" align="left" valign="top" class="textOverBackgroundCharts" id="WC_ShopperBidListDisplay_TableCell_15">
									<font	class="textOverBackgroundCharts"> 
									<fmt:message key="currentBid" bundle="${storeText}" /><br />
									(<fmt:message key="quantity1" bundle="${storeText}" />)
									</font>
									</td>
									<td width="250" align="left" valign="top"	class="textOverBackgroundCharts" id="WC_ShopperBidListDisplay_TableCell_16">
									<font	class="textOverBackgroundCharts"> 
									<fmt:message key="bdNumber" bundle="${storeText}" /><br />
									(<fmt:message key="dateTime" bundle="${storeText}" />)
									</font>
									</td>
									<td width="75" align="left" valign="top" class="textOverBackgroundCharts" id="WC_ShopperBidListDisplay_TableCell_17">
									<!-- withdraw --> 
									<font	class="textOverBackgroundCharts"> 
									<fmt:message key="withdraw" bundle="${storeText}" /><br />
									</font>
									</td>

								</tr>

								<c:set var="end2" value="${start+count}" />
								<c:if test="${end2 > length2}">
									<c:set var="end2" value="${length2}" />
								</c:if>
								<c:forEach var="aBid" items="${aBidList.bids}"	begin="${start}" end="${end2-1}" varStatus="aStatus">
									<c:set var="autoBidId" value="${aBid.autoBidId}" />
									<c:set var="bid_id" value="${aBid.id}" />
									<c:set var="bdrefnum" value="${aBid.referenceCode}" />
									<c:set var="bid_Status" value="${aBid.status}" />
									<c:set var="auctStoreId" value="${aBid.storeId}" />
									<c:set var="bdaucref" value="${aBid.auctionId}" />
									<c:set var="bid_Quant" value="${aBid.formattedBidQuantity}" />
									<c:set var="formattedBidValue"	value="${aBid.formattedBidPrice}" />
									<c:set var="bddate" value="${aBid.formattedBidCreationTime}" />

									<c:if test="${flag==false}">
										<c:set var="auction_Status" value="${aBid.auctionDataBean.status}" />
										<c:set var="auction_Type" value="${aBid.auctionDataBean.auctionType}" />
										<c:set var="productId" value="${aBid.auctionDataBean.entryId}" />
										<c:set var="product_Desc" value="${aBid.auctionDataBean.auctItemDesc}" />
										<c:set var="prnbr" value="${aBid.auctionDataBean.auctItemSKU}" />
									</c:if>		
						

									<c:if test="${auctStoreId eq storeId}">
										<tr>
											<%-- 1st column --%>
											<td width="150" align="left" id="WC_ShopperBidListDisplay_TableCell_18_<c:out value="${aStatus.count}"/>">
											<font class="text"> 
											<c:choose>
												<c:when test="${auction_Status=='C'}">
													<a	href='ProductDisplay?storeId=<c:out value="${storeId}" />&catalogId=<c:out value="${catalogId}" />&productId=<c:out value="${productId}" />&langId=<c:out value="${lang}" />&fromAuction=true' id="WC_ShopperBidListDisplay_Link_6_<c:out value="${aStatus.count}"/>">
													<c:out value="${product_Desc}" /> 
													</a>
													<br />
													(<c:out value="${prnbr}" />)<br />
												</c:when>
												<c:otherwise>
													<a href='DisplayAuctionItem?aucrfn=<c:out value="${bdaucref}" />&storeId=<c:out value="${storeId}" />&catalogId=<c:out value="${catalogId}" />&productId=<c:out value="${productId}" />&langId=<c:out value="${lang}" />&fromAuction=true' id="WC_ShopperBidListDisplay_Link_7_<c:out value="${aStatus.count}"/>">
													<c:out value="${product_Desc}" /> 
													</a>
													<br />
												(<c:out value="${prnbr}" />)<br />
												</c:otherwise>
											</c:choose> 
											<c:if test="${auction_Type=='O' || auction_Type=='D'}">
												<c:if test="${status == 'C' || status == 'F'}">
													<a	href='BidListView?storeId=<c:out value="${auctStoreId}" />&catalogId=<c:out value="${catalogId}" />&aucrfn=<c:out value="${bdaucref}" />' id="WC_ShopperBidListDisplay_Link_8_<c:out value="${aStatus.count}"/>">
													<fmt:message key="seeAllBids" bundle="${storeText}" />
													</a>
												</c:if>
											</c:if> 
											</font>
											</td>

											<%-- 2nd column --%>
											<td width="130" align="left" id="WC_ShopperBidListDisplay_TableCell_19_<c:out value="${aStatus.count}"/>">
											<font class="text"> 
											<font	class="price"> 
											<c:out value="${formattedBidValue}" escapeXml="false"/>
											</font>
											<br />
											(<c:out value="${bid_Quant}" />) <br />
											<c:if	test="${auction_Status=='C' && (auction_Type=='O' || auction_Type == 'SB')}">
												<c:if test="${empty autoBidId}">
													<a	href='BidUpdateForm?storeId=<c:out value="${storeId}" />&catalogId=<c:out value="${catalogId}" />&aucrfn=<c:out value="${bdaucref}" />&bid_id=<c:out value="${bid_id}" />' id="WC_ShopperBidListDisplay_Link_9_<c:out value="${aStatus.count}"/>">
													<fmt:message key="modifyBid" bundle="${storeText}" />
													</a>
												</c:if>
											</c:if> 
											</font>
											</td>

											<%-- 3rd column --%>
											<td width="250" align="left" id="WC_ShopperBidListDisplay_TableCell_20_<c:out value="${aStatus.count}"/>">
											<font class="text"> 
											<c:out	value="${bdrefnum}" /> 
											<br />
											<c:out value="${bddate}" /> 
											</font>
											</td>

											<%-- 4th column --%>
											<td width="75" align="left" id="WC_ShopperBidListDisplay_TableCell_21_<c:out value="${aStatus.count}"/>">
											<font class="text"> 
											<c:choose>
												<c:when	test="${auction_Status=='C' && (auction_Type=='O' || auction_Type=='SB')}">
													<c:if test="${empty autoBidId}">
														<%-- <c:set var="withdrawFlag" value="true" /> --%>
														<a	href='BidDelete?storeId=<c:out value="${storeId}" />&catalogId=<c:out value="${catalogId}" />&bid_id=<c:out value="${bid_id}" />&URL=ShopperBidListView&status=<c:out value="${status}" />' id="WC_ShopperBidListDisplay_Link_10_<c:out value="${aStatus.count}"/>">
														<fmt:message key="withdraw" bundle="${storeText}" />
														</a>
													</c:if>
													<c:if test="${!empty autoBidId }">
														--
													</c:if>
												</c:when>
												<c:when	test="${auction_Status == 'SC' && bid_Status == 'W'}">
													
													<b><font color="0000FF"> 
													(<fmt:message key="winner"	bundle="${storeText}" />) 
													</font>
													</b>
													
												</c:when>
												<c:when	test="${auction_Status == 'D' && bid_Status == 'W'}">
													
													<b><font color="0000FF"> 
													(<fmt:message key="winner"	bundle="${storeText}" />) 
													</font>
													</b>
													
												</c:when>
												<c:otherwise>
											--
										</c:otherwise>
											</c:choose> </font></td>
										</tr>
									</c:if>
								</c:forEach>
							</tbody>
						</table>
						<br />
					</c:if>
					<font class="productName"> <tt> <c:if test="${length2 eq 0}">
						<c:choose>
							<c:when	test="${flag==true && ! empty product_Desc}">
								<fmt:message key="ShopperBid_noBidMsg3"	bundle="${storeText}">
									<fmt:param value="${product_Desc}" />
								</fmt:message>
							</c:when>
							<c:otherwise>
								<c:if test="${status=='C'}">
									<fmt:message key="ShopperBid_noBidMsg1"	bundle="${storeText}" />
								</c:if>
								<c:if test="${status=='BCSC'}">
									<fmt:message key="ShopperBid_noBidMsg2"	bundle="${storeText}" />
								</c:if>
							</c:otherwise>
						</c:choose>
					</c:if> </tt> </font>
				</c:if>
			</c:if>
			<table cellpadding="3" cellspacing="0" border="0" id="WC_ShopperBidListDisplay_Table_5">
				<tbody>
					<tr>
						<c:if test="${length1 gt length2}">
							<c:set var="nextStartPt" value="${end1}" />
						</c:if>
						<c:if test="${length1 le length2}">
							<c:set var="nextStartPt" value="${end2}" />
						</c:if>
						<c:set var="prevStartPt" value="${start - count}" />
						<c:if test="${prevStartPt >= 0}">
							<td align="center" valign="middle" class="buttonStyle" id="WC_ShopperBidListDisplay_TableCell_22">
							<font	class="buttonStyle"> 
							<a href='ShopperBidListView?storeId=<c:out value="${storeId}" />&catalogId=<c:out value="${catalogId}" />&status=<c:out value="${status}"/>&next=<c:out value="${prevStartPt}"/>&yourBids=<c:out value="${yourBids}"/>&aucrfn=<c:out value="${aucrfn}"/>' id="WC_ShopperBidListDisplay_Link_11">
								&lt;
								<fmt:message key="txtPrevious" bundle="${storeText}" />
							</a> 
							</font>
							</td>
						</c:if>

						<c:if test="${(nextStartPt < length1) || (nextStartPt < length2)}">
							<td align="center" valign="middle" class="buttonStyle" id="WC_ShopperBidListDisplay_TableCell_23">
							<font class="buttonStyle"> 
							<a href='ShopperBidListView?storeId=<c:out value="${storeId}" />&catalogId=<c:out value="${catalogId}" />&status=<c:out value="${status}"/>&next=<c:out value="${nextStartPt}"/>&yourBids=<c:out value="${yourBids}"/>&aucrfn=<c:out value="${aucrfn}"/>' id="WC_ShopperBidListDisplay_Link_12">
								<fmt:message key="txtNext" bundle="${storeText}" /> 
								&gt;
							</a> 
							</font>
							</td>
						</c:if>
					</tr>
				</tbody>
			</table>

			<br />
			<hr width="100%" />
			<br />
			<font> 
			<c:if test="${status=='C'}">
				<a href="ShopperBidListView?storeId=<c:out value="${storeId}" />&catalogId=<c:out value="${catalogId}" />&status=F" id="WC_ShopperBidListDisplay_Link_13"> 
				<fmt:message key="futureAuctionsMsg" bundle="${storeText}" /> 
				</a>
				<br />
				<br />
				<a href="ShopperBidListView?storeId=<c:out value="${storeId}" />&catalogId=<c:out value="${catalogId}" />&status=BCSC" id="WC_ShopperBidListDisplay_Link_14"> 
				<fmt:message key="closedAuctionsMsg" bundle="${storeText}" /> 
				</a>
			</c:if> <c:if test="${status=='F'}">
				<a href="ShopperBidListView?storeId=<c:out value="${storeId}" />&catalogId=<c:out value="${catalogId}" />&status=C" id="WC_ShopperBidListDisplay_Link_15"> 
				<fmt:message key="currentAuctionsMsg" bundle="${storeText}" /> 
				</a>
				<br />
				<br />
				<a href="ShopperBidListView?storeId=<c:out value="${storeId}" />&catalogId=<c:out value="${catalogId}" />&status=BCSC" id="WC_ShopperBidListDisplay_Link_16"> 
				<fmt:message key="closedAuctionsMsg" bundle="${storeText}" /> 
				</a>
			</c:if> 
			<c:if test="${status!='F'&& status!= 'C'}">
				<a href="ShopperBidListView?storeId=<c:out value="${storeId}" />&catalogId=<c:out value="${catalogId}" />&status=F" id="WC_ShopperBidListDisplay_Link_17"> 
				<fmt:message key="futureAuctionsMsg" bundle="${storeText}" /> 
				</a>
				<br />
				<br />
				<a href="ShopperBidListView?storeId=<c:out value="${storeId}" />&catalogId=<c:out value="${catalogId}" />&status=C" id="WC_ShopperBidListDisplay_Link_18"> 
				<fmt:message key="currentAuctionsMsg" bundle="${storeText}" /> 
				</a>
			</c:if> 
			</font>
			</td>
		</tr>
	</tbody>
</table>



