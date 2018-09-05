<%
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
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../include/JSTLEnvironmentSetup.jspf"%>

<table id="WC_ShopperBidListDisplay_Table_1" border="0" cellpadding="0" cellspacing="0" width="790" >
	<tr>
		
		<td id="WC_ShopperBidListDisplay_TableCell_2" valign="top" width="630">
		<c:set var="status" value="${WCParam.status}" /> 
		<c:set var="aucrfn"	value="${WCParam.aucrfn}" /> 
		<c:set var="yourBids" value="${WCParam.yourBids}" /> 
		<c:set var="count" value="5" /> 
		<c:set var="flag" value="false" /> 
		<c:set var="start" value="0" /> 
		<c:if test="${! empty WCParam.next}">
			<c:set var="start" value="${WCParam.next}" />
		</c:if> 
		<c:if test="${! empty yourBids}">
			<c:set var="flag" value="true" /> 
		</c:if>
		<wcbase:useBean	id="aRegister" classname="com.ibm.commerce.user.beans.UserRegistrationDataBean">
		</wcbase:useBean>		
		<c:set var="safname" value="${aRegister.firstName}" />	
		<c:set var="samname" value="${aRegister.middleName}" />	
		<c:set var="salname" value="${aRegister.lastName}" />		
		<c:if test="${flag==true}">
			<wcbase:useBean id="auction" classname="com.ibm.commerce.negotiation.beans.AuctionDataBean">
				<c:set property="auctionId" value="${aucrfn}" target="${auction}" />
			</wcbase:useBean>
			<c:set var="productId" value="${auction.entryId}" />
			<c:set var="auction_Type" value="${auction.auctionType}" />				
			<c:set var="auction_Status" value="${auction.status}" />			
			<c:set var="product_Desc" value="${auction.auctItemDesc}" />
			<c:set var="prnbr" value="${auction.auctItemSKU}" />		
		</c:if>

		<table id="WC_ShopperBidListDisplay_Table_2" cellpadding="0" cellspacing="8" border="0">
			<tr>
				<td id="WC_ShopperBidListDisplay_TableCell_3" align="left"	valign="top" colspan="5" class="categoryspace" width="100%">
				<h1>
				<fmt:message key="ShopperBid_bidsSubmittedBy" bundle="${storeText}">
					<fmt:param value="${safname}" />
					<fmt:param value="${samname}" />
					<fmt:param value="${salname}" />
				</fmt:message> 
				<br />
				<c:if test="${flag == true && ! empty product_Desc }">
					<c:out value="${product_Desc}" />
				</c:if> 
				<c:if test="${!(flag == true && ! empty product_Desc )}">
					<c:if test="${status=='C'}">
						<fmt:message key="AuctionCommonText_CurrentAuctions" bundle="${storeText}" />
					</c:if>
					<c:if test="${status=='F'}">
						<fmt:message key="AuctionCommonText_FutureAuctions"	bundle="${storeText}" />
					</c:if>
					<c:if test="${status != 'C' && status != 'F' }">
						<fmt:message key="AuctionCommonText_RecentlyClosedAuctions"	bundle="${storeText}" />
					</c:if>
				</c:if>
				</h1>
				<hr width="100%" noshade="noshade" align="left" />
				</td>
			</tr>
			<tr>
				<td id="WC_ShopperBidListDisplay_TableCell_4">
				<c:if test="${flag == false || (flag == true && (auction_Type == 'O' || auction_Type == 'SB'))}">
					<wcbase:useBean id="anAutoBidList"	classname="com.ibm.commerce.negotiation.beans.AutoBidListBean">
						<c:set property="ownerId" value="${userId}"	target="${anAutoBidList}" />
						<c:set property="autoBidStatus" value="A"	target="${anAutoBidList}" />
						<c:if test="${flag == true}">
							<c:set property="auctionId" value="${aucrfn}" target="${anAutoBidList}" />
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
					<c:if test="${length1 > 0}">
						<c:if test="${length1 > start}">
							<font class="productName"> 
							<fmt:message key="ShopperBid_yourAutobids" bundle="${storeText}" /> <br />
							<c:if test="${status=='C' || status=='F'}">
								<fmt:message key="ShopperBid_modifyAutobidMsg"	bundle="${storeText}" />
							</c:if> 
							<br />
							</font>

							<br />
							<c:set var="end1" value="${start + count}" />
							<c:if test="${end1 > length1} ">
								<c:set var="end1" value="${length1}" />
							</c:if>
							<table id="WC_ShopperBidListDisplay_Table_3" cellpadding="0" cellspacing="1" width="100%" border="0" bgcolor="#4C6178">

								<tr bgcolor="#4C6178">
									<td id="WC_ShopperBidListDisplay_TableCell_5" align="left"	valign="top" class="textOverBackgroundCharts">
									<font style="font-family: Verdana" color="#FFFFFF"> 
									<fmt:message key="ShopperBid_product" bundle="${storeText}" /> 
									</font>
									</td>
									<td id="WC_ShopperBidListDisplay_TableCell_6" align="left"	valign="top" class="textOverBackgroundCharts">
									<font style="font-family: Verdana" color="#FFFFFF"> 
									<fmt:message key="ShopperBid_upperLimit" bundle="${storeText}" /><br />
									<fmt:message key="ShopperBid_currentBid"
										bundle="${storeText}" /><br />
									(<fmt:message key="ShopperBid_quantity1"
										bundle="${storeText}" />) 
									</font>
									</td>
									<td id="WC_ShopperBidListDisplay_TableCell_7" align="left"	valign="top" class="textOverBackgroundCharts">
									<font style="font-family: Verdana" color="#FFFFFF"> 
									<fmt:message key="ShopperBid_bdNumber" bundle="${storeText}" /><br />
									<fmt:message key="ShopperBid_dateTime" bundle="${storeText}" />
									</font>
									</td>
									<td id="WC_ShopperBidListDisplay_TableCell_8" align="left"	valign="top" class="textOverBackgroundCharts">
									<!-- Withdraw -->
									<font style="font-family: Verdana" color="#FFFFFF"> 
									<fmt:message key="ShopperBid_withdraw" bundle="${storeText}" /> 
									</font>
									</td>
								</tr>

								<c:forEach var="anAutoBid" items="${anAutoBidList.autoBids}" begin="${start}" end="${end1-1}" varStatus="aStatus">
									<c:set property="commandContext" value="${CommandContext}"	target="${anAutoBid}" />
									<c:set var="autobid_id" value="${anAutoBid.autoBidId}" />
									<c:set var="obrefnum" value="${anAutoBid.referenceCode}" />
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

									<c:choose>
										<c:when test="${aStatus.count%2 == 0}">
											<c:set var="color" value="#ffffff" />
										</c:when>
										<c:otherwise>
											<c:set var="color" value="#bccbdb" />
										</c:otherwise>
									</c:choose>
									<tr bgcolor='<c:out value="${color}" />'>
										<td	id='WC_ShopperBidListDisplay_TableCell_9_<c:out value="${aStatus.count}"/>'>
										<font class="text"> 
										<c:choose>
											<c:when test="${auction_Status=='C'}">
												<a	href='ProductDisplay?storeId=<c:out value="${storeId}"/>&productId=<c:out value="${productId}"/>&langId=<c:out value="${langId}"/>&fromAuction=true'
													id="WC_ShopperBidListDisplay_Link_1"> 
													<c:out	value="${product_Desc}" /> </a>
												<br />
		           				            (<c:out value="${prnbr}" />)<br />
											</c:when>
											<c:otherwise>
												<a	href='DisplayAuctionItem?aucrfn=<c:out value="${obaucref}"/>&storeId=<c:out value="${storeId}"/>&productId=<c:out value="${productId}"/>&langId=<c:out value="${langId}"/>&fromAuction=true'
													id="WC_ShopperBidListDisplay_Link_2"> 
													<c:out value="${product_Desc}" /> </a>
												<br />
           					            	(<c:out value="${prnbr}" />)<br />
											</c:otherwise>
										</c:choose> 
										<c:if	test="${auction_Type=='O' || auction_Type=='D'}">
											<c:if test="${status == 'C'}">
												<a	href='BidListView?auctionStoreId=<c:out value="${auctStoreId}" />&aucrfn=<c:out value="${obaucref}" />'
													id="WC_ShopperBidListDisplay_Link_3"> 
													<fmt:message key="AuctionCommonText_SeeAllBids" bundle="${storeText}" />
												</a>
											</c:if>
										</c:if> 
										</font>
										</td>
										<%-- 2nd column --%>
										<td id="WC_ShopperBidListDisplay_TableCell_10">
										<font class="text"> 
										<c:if test="${! empty bd_bid_Value }">
											<font class="price"><c:out value="${formattedObMaxBdLimit}" escapeXml="false"/></font>
											<br />
											<font class="price"><c:out value="${formattedBidValue}" escapeXml="false"/></font>
											<br />
			                           (<c:out	value="${anAutoBid.formattedBidQuantity}" /> ) <br />
										</c:if> 
										<c:if test="${empty bd_bid_Value}">
											<font class="price"><c:out value="${formattedObMaxBdLimit}" escapeXml="false"/></font>
											<br />
		           						---<br />
			                           (<c:out	value="${anAutoBid.formattedBidQuantity}" /> ) <br />
										</c:if> 
										<c:if test="${auction_Status=='C' || auction_Status=='F' && (auction_Type=='O' || auction_Type=='SB')}">
											<a	href='AutoBidUpdateForm?auctionStoreId=<c:out value="${auctStoreId}" />&aucrfn=<c:out value="${obaucref}" />&autobid_id=<c:out value="${autobid_id}" />'
												id="WC_ShopperBidListDisplay_Link_4"> 
												<fmt:message	key="AuctionCommonText_modifyAutobid"	bundle="${storeText}" /> </a>
										</c:if> 
										</font>
										</td>
										<%-- 3rd column --%>
										<td id="WC_ShopperBidListDisplay_TableCell_11">
										<font class="text"> 
										<c:out value="${obrefnum}" /> <br />
										<c:out value="${obdate}" /> 
										</font>
										</td>
										<%-- 4th column --%>
										<td id="WC_ShopperBidListDisplay_TableCell_12">
										<font	class="text"> 
										<c:choose>
											<c:when	test="${auction_Status=='C' || auction_Status=='F' && (auction_Type=='O' || auction_Type=='SB')}">
												<a	href='AutoBidDelete?storeId=<c:out value="${storeId}" />&autobid_id=<c:out value="${autobid_id}" />&URL=ShopperBidListView&status=<c:out value="${status}" />'
													id="WC_ShopperBidListDisplay_Link_5"> 
													<fmt:message key="ShopperBid_withdraw" bundle="${storeText}" /> </a>
											</c:when>
											<c:otherwise>
											--
										</c:otherwise>
										</c:choose> 
										</font>
										</td>
									</tr>
								</c:forEach>
							</table>
							<br />
							<c:if test="${status != 'F'}">
								<hr width="100%" />
							</c:if>
						</c:if>
						<c:if test="${length1==0}">
							<font class="productName"> <tt> 
							<c:choose>
								<c:when	test="${flag==true && ! empty product_Desc }">
									<fmt:message key="ShopperBid_noAutoBidMsg4"	bundle="${storeText}">
										<fmt:param value="${product_Desc}" />
									</fmt:message>
								</c:when>
								<c:otherwise>
									<c:if test="${status=='C'}">
										<fmt:message key="ShopperBid_noAutoBidMsg1"	bundle="${storeText}" />
									</c:if>
									<c:if test="${status=='F'}">
										<fmt:message key="ShopperBid_noAutoBidMsg3"	bundle="${storeText}" />
									</c:if>
									<c:if test="${status != 'C' && status != 'F'}">
										<fmt:message key="ShopperBid_noAutoBidMsg2"	bundle="${storeText}" />
									</c:if>
								</c:otherwise>
							</c:choose> 
							</tt> 
							</font>
						</c:if>
					</c:if>
				</c:if> 
				<%-- Show bids for Current or Future Auctions only   --%> 
				<c:if	test="${status != 'F'}">
					<wcbase:useBean id="aBidList" classname="com.ibm.commerce.negotiation.beans.BidListBean">
						<c:set property="bidOwnerId" value="${userId}" target="${aBidList}" />
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
							<c:if test="${flag==false || (flag==true && (auction_Type == 'O' || auction_Type=='SB'))}">
								<font class="productName"> 
								<fmt:message key="ShopperBid_yourBidsMsg" bundle="${storeText}" /><br />
								<c:if test="${status=='C'}">
									<fmt:message key="ShopperBid_modifyBidsMsg"	bundle="${storeText}" />
									<br />
								</c:if> 
								</font>
							</c:if>
							<br />
							<table id="WC_ShopperBidListDisplay_Table_4" cellpadding="0" cellspacing="1" width="100%" border="0" bgcolor="#4C6178">
								<tr bgcolor="#4C6178">
									<td id="WC_ShopperBidListDisplay_TableCell_13" width="150"	align="left" valign="top" class="textOverBackgroundCharts">
									<font style="font-family: Verdana" color="#FFFFFF"> 
									<fmt:message key="ShopperBid_product" bundle="${storeText}" /> 
									</font>
									</td>
									<td id="WC_ShopperBidListDisplay_TableCell_14" width="130"	align="left" valign="top" class="textOverBackgroundCharts">
									<font style="font-family: Verdana" color="#FFFFFF"> 
									<fmt:message key="ShopperBid_currentBid" bundle="${storeText}" /><br />
									(<fmt:message key="ShopperBid_quantity1" bundle="${storeText}" />) 
									</font>
									</td>
									<td id="WC_ShopperBidListDisplay_TableCell_15" width="250" align="left" valign="top" class="textOverBackgroundCharts">
									<font	style="font-family: Verdana" color="#FFFFFF"> 
									<fmt:message key="ShopperBid_bdNumber" bundle="${storeText}" /><br />
									(<fmt:message key="ShopperBid_dateTime"	bundle="${storeText}" />) 
									</font>
									</td>
									<td id="WC_ShopperBidListDisplay_TableCell_16" width="75"	align="left" valign="top" class="textOverBackgroundCharts"><!-- withdraw -->
									<font style="font-family: Verdana" color="#FFFFFF"> 
									<fmt:message	key="ShopperBid_withdraw" bundle="${storeText}" /><br />
									</font>
									</td>
								</tr>
								<c:set var="end2" value="${start+count}" />
								<c:if test="${end2 > length2}">
									<c:set var="end2" value="${length2}" />
								</c:if>
								<c:if test="${start < end2}" />
								<c:forEach var="aBid" items="${aBidList.bids}" begin="${start}"	end="${end2-1}" varStatus="aStatus">
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
									
									<c:if test="${aStatus.count%2 == 0}">
										<c:set var="color" value="#ffffff" />
									</c:if>
									<c:if test="${aStatus.count%2 != 0}">
										<c:set var="color" value="#bccbdb" />
									</c:if>

									<tr bgcolor='<c:out value="${color}" />'>
										<%-- 1st column --%>
										<td id="WC_ShopperBidListDisplay_TableCell_17" width="150"	align="left">
										<font class="text"> 
										<c:choose>
											<c:when test="${auction_Status=='C'}">
												<a	href='ProductDisplay?storeId=<c:out value="${storeId}" />&productId=<c:out value="${productId}" />&langId=<c:out value="${lang}" />&fromAuction=true'
													id="WC_ShopperBidListDisplay_Link_6"> 
													<c:out value="${product_Desc}" /> </a>
												<br />
											(<c:out value="${prnbr}" />)<br />
											</c:when>
											<c:otherwise>
												<a	href='DisplayAuctionItem?aucrfn=<c:out value="${bdaucref}" />&storeId=<c:out value="${storeId}" />&productId=<c:out value="${productId}" />&langId=<c:out value="${lang}" />&fromAuction=true'
													id="WC_ShopperBidListDisplay_Link_7"> 
													<c:out	value="${product_Desc}" /> </a>
												<br />
											(<c:out value="${prnbr}" />)<br />
											</c:otherwise>
										</c:choose> 
										<c:if test="${auction_Type=='O' || auction_Type=='D'}">
											<c:if test="${status == 'C' || status == 'F'}">
												<a	href='BidListView?auctionStoreId=<c:out value="${auctStoreId}" />&aucrfn=<c:out value="${bdaucref}" />'
													id="WC_ShopperBidListDisplay_Link_8"> 
													<fmt:message key="AuctionCommonText_SeeAllBids"	bundle="${storeText}" /> </a>
											</c:if>
										</c:if> 
										</font>
										</td>
										<%-- 2nd column --%>
										<td id="WC_ShopperBidListDisplay_TableCell_18" width="130"	align="left">
										<font class="text"> 
										<font class="price">
										<c:out	value="${formattedBidValue}" escapeXml="false"/>
										</font> <br />
										(<c:out value="${bid_Quant}" />) <br />
										<c:if	test="${auction_Status=='C' && (auction_Type=='O' || auction_Type == 'SB')}">
											<c:if test="${empty autoBidId}">
												<a	href='BidUpdateForm?auctionStoreId=<c:out value="${auctStoreId}" />&aucrfn=<c:out value="${bdaucref}" />&bid_id=<c:out value="${bid_id}" />'
													id="WC_ShopperBidListDisplay_Link_9"> 
													<fmt:message key="AuctionCommonText_modifyBid" bundle="${storeText}" />
												</a>
											</c:if>
										</c:if> 
										</font>
										</td>
										<%-- 3rd column --%>
										<td id="WC_ShopperBidListDisplay_TableCell_19" width="250"	align="left">
										<font class="text"> <c:out value="${bdrefnum}" />
										<br />
										<c:out value="${bddate}" /> 
										</font>
										</td>
										<%-- 4th column --%>
										<td id="WC_ShopperBidListDisplay_TableCell_20" width="75" align="left">
										<font class="text"> 
										<c:choose>
											<c:when	test="${auction_Status=='C' && (auction_Type=='O' || auction_Type=='SB')}">
												<c:if test="${empty autoBidId}">
													<%-- <c:set var="withdrawFlag" value="true" /> --%>
													<a	href='BidDelete?storeId=<c:out value="${storeId}" />&bid_id=<c:out value="${bid_id}" />&URL=ShopperBidListView&status=<c:out value="${status}" />'
														id="WC_ShopperBidListDisplay_Link_10"> 
														<fmt:message key="ShopperBid_withdraw" bundle="${storeText}" /> </a>
												</c:if>
											
												--
											
										</c:when>
											<c:when	test="${auction_Status == 'SC' && bid_Status == 'W'}">
												<b><font color="0000FF"> 
												(<fmt:message key="AuctionCommonText_Winner" bundle="${storeText}" />)
												</font></b>
											</c:when>
											<c:when	test="${auction_Status == 'D' && bid_Status == 'W'}">
												<b><font color="0000FF"> 
												(<fmt:message key="AuctionCommonText_Winner" bundle="${storeText}" />)
												</font></b> 
											</c:when>
											<c:otherwise>
											--
										</c:otherwise>
										</c:choose> 
										</font>
										</td>
									</tr>
								</c:forEach>									
							</table>
							<br />
							
							<font class="productName"> 
							<tt> 
							<c:if	test="${length2 <= start}">
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
							</c:if> 
							</tt> 
							</font>
						</c:if>
					</c:if>
					<table id="WC_ShopperBidListDisplay_Table_5" cellpadding="3" cellspacing="0" border="0">
						<tr>
							<c:if test="${length1 > length2}">
								<c:set var="nextStartPt" value="${end1}" />
							</c:if>
							<c:if test="${length1 <= length2}">
								<c:set var="nextStartPt" value="${end2}" />
							</c:if>
							<c:set var="prevStartPt" value="${start - count}" />
							<c:if test="${prevStartPt >= 0}">
								<td id="WC_ShopperBidListDisplay_TableCell_21" align="center" valign="middle" class="buttonStyle">
								<c:if test="${flag==true}">
									<c:set var="sPreviousLink"	value="ShopperBidListView?status=${status}&next=${prevStartPt}&yourBids=${yourBids}&aucrfn=${aucrfn}" />
								</c:if> 
								<c:if test="${flag==false}">
									<c:set var="sPreviousLink" value="ShopperBidListView?status=${status}&next=${prevStartPt}" />
								</c:if> 
								<!-- Start display for button -->
								<table id="WC_ShopperBidListDisplay_Table_6" cellpadding="0" cellspacing="0" border="0">
									<tr>
										<td id="WC_ShopperBidListDisplay_TableCell_22"	bgcolor="#ff2d2d" class="pixel">
										<img alt=""	src='<c:out value="${jspStoreImgDir}" />images/lb.gif'	border="0" />
										</td>
										<td id="WC_ShopperBidListDisplay_TableCell_23"	bgcolor="#ff2d2d" class="pixel">
										<img alt=""	src='<c:out value="${jspStoreImgDir}" />images/lb.gif'	border="0" />
										</td>
										<td id="WC_ShopperBidListDisplay_TableCell_24" class="pixel">
										<img alt=""	src='<c:out value="${jspStoreImgDir}" />images/r_top.gif' border="0" />
										</td>
									</tr>
									<tr>
										<td id="WC_ShopperBidListDisplay_TableCell_25"	bgcolor="#ff2d2d">
										<img alt=""	src='<c:out value="${jspStoreImgDir}" />images/lb.gif'	border="0" />
										</td>
										<td id="WC_ShopperBidListDisplay_TableCell_26"	bgcolor="#ea2b2b">
										<table id="WC_ShopperBidListDisplay_Table_7" cellpadding="2" cellspacing="0" border="0">
											<tr>
												<td id="WC_ShopperBidListDisplay_TableCell_27" class="buttontext"><font color="#ffffff"> 
												<a	href='<c:out value="${sPreviousLink}" />'style="color: #ffffff; text-decoration: none"> 
												&lt; 
												<fmt:message key="AuctionCommonText_Previous" bundle="${storeText}" />
												</a> 
												</font>
												</td>
											</tr>
										</table>
										</td>
										<td id="WC_ShopperBidListDisplay_TableCell_28"	bgcolor="#7a1616">
										<img alt=""	src='<c:out value="${jspStoreImgDir}" />images/db.gif'	border="0" />
										</td>
									</tr>
									<tr>
										<td id="WC_ShopperBidListDisplay_TableCell_29" class="pixel">
										<img src='<c:out value="${jspStoreImgDir}" />images/l_bot.gif' alt=""/>
										</td>
										<td id="WC_ShopperBidListDisplay_TableCell_30"	bgcolor="#7a1616" class="pixel" valign="top">
										<img src='<c:out value="${jspStoreImgDir}" />images/db.gif'	border="0" alt=""/>
										</td>
										<td id="WC_ShopperBidListDisplay_TableCell_31"	bgcolor="#7a1616" class="pixel" valign="top">
										<img src='<c:out value="${jspStoreImgDir}" />images/db.gif'	border="0" alt=""/>
										</td>
									</tr>
								</table>
								<!-- End display for button -->
								</td>
							</c:if>
							<c:if	test="${(nextStartPt < length1) || (nextStartPt < length2)}">
								<td id="WC_ShopperBidListDisplay_TableCell_32" align="center" valign="middle" class="buttonStyle">
								<c:if test="${flag==true}">
									<c:set var="sNextLink"	value="ShopperBidListView?status=${status}&next=${nextStartPt}&yourBids=${yourBids}&aucrfn=${aucrfn}" />
								</c:if> 
								<c:if test="${flag==false}">
									<c:set var="sNextLink"	value="ShopperBidListView?status=${status}&next=${nextStartPt}" />
								</c:if> 
								<!-- Start display for button -->
								<table id="WC_ShopperBidListDisplay_Table_8" cellpadding="0" cellspacing="0" border="0">
									<tr>
										<td id="WC_ShopperBidListDisplay_TableCell_33"	bgcolor="#ff2d2d" class="pixel">
										<img src='<c:out value="${jspStoreImgDir}" />images/lb.gif'	border="0" alt=""/>
										</td>
										<td id="WC_ShopperBidListDisplay_TableCell_34"	bgcolor="#ff2d2d" class="pixel">
										<img src='<c:out value="${jspStoreImgDir}" />images/lb.gif'	border="0" alt=""/>
										</td>
										<td id="WC_ShopperBidListDisplay_TableCell_35" class="pixel">
										<img src='<c:out value="${jspStoreImgDir}" />images/r_top.gif'	border="0" alt=""/>
										</td>
									</tr>
									<tr>
										<td id="WC_ShopperBidListDisplay_TableCell_36"	bgcolor="#ff2d2d">
										<img alt=""	src='<c:out value="${jspStoreImgDir}" />images/lb.gif'	border="0" />
										</td>
										<td id="WC_ShopperBidListDisplay_TableCell_37"	bgcolor="#ea2b2b">
										<table id="WC_ShopperBidListDisplay_Table_9" cellpadding="2" cellspacing="0" border="0">
											<tr>
												<td id="WC_ShopperBidListDisplay_TableCell_38"	class="buttontext">
												<font color="#ffffff"> 
												<a	href='<c:out value="${sNextLink}" />'	style="color: #ffffff; text-decoration: none"> 
												<fmt:message key="AuctionCommonText_Next" bundle="${storeText}" />
												&gt; </a> 
												</font>
												</td>
											</tr>
										</table>
										</td>
										<td id="WC_ShopperBidListDisplay_TableCell_39"	bgcolor="#7a1616">
										<img alt=""	src='<c:out value="${jspStoreImgDir}" />images/db.gif'	border="0" />
										</td>
									</tr>
									<tr>
										<td id="WC_ShopperBidListDisplay_TableCell_40" class="pixel">
										<img src='<c:out value="${jspStoreImgDir}" />images/l_bot.gif' alt=""/>
										</td>
										<td id="WC_ShopperBidListDisplay_TableCell_41"	bgcolor="#7a1616" class="pixel" valign="top">
										<img src='<c:out value="${jspStoreImgDir}" />images/db.gif'	border="0" alt=""/>
										</td>
										<td id="WC_ShopperBidListDisplay_TableCell_42"	bgcolor="#7a1616" class="pixel" valign="top">
										<img src='<c:out value="${jspStoreImgDir}" />images/db.gif'	border="0" alt=""/>
										</td>
									</tr>
								</table>								
								<!-- End display for button -->
								</td>
							</c:if>							
						</tr>
					</table>
				</c:if>
				<br />
				<hr width="100%" />
				<br />

				<font> 
				<c:if test="${status=='C'}">
					<a href="ShopperBidListView?status=F"	id="WC_ShopperBidListDisplay_Link_11"> 
					<fmt:message key="ShopperBid_futureAuctionsMsg" bundle="${storeText}" /> </a>
					<br />
					<br />
					<a href="ShopperBidListView?status=BCSC" id="WC_ShopperBidListDisplay_Link_12"> 
					<fmt:message	key="ShopperBid_closedAuctionsMsg" bundle="${storeText}" /> </a>
				</c:if> 
				<c:if test="${status=='F'}">
					<a href="ShopperBidListView?status=C" id="WC_ShopperBidListDisplay_Link_13"> 
					<fmt:message key="ShopperBid_currentAuctionsMsg" bundle="${storeText}" />
					</a>
					<br />
					<br />
					<a href="ShopperBidListView?status=BCSC" id="WC_ShopperBidListDisplay_Link_14"> 
					<fmt:message key="ShopperBid_closedAuctionsMsg" bundle="${storeText}" /> 
					</a>
				</c:if> 
				<c:if test="${status!='F'&& status!= 'C'}">
					<a href="ShopperBidListView?status=F"	id="WC_ShopperBidListDisplay_Link_15"> 
					<fmt:message key="ShopperBid_futureAuctionsMsg" bundle="${storeText}" /> 
					</a>
					<br />
					<br />
					<a href="ShopperBidListView?status=C" id="WC_ShopperBidListDisplay_Link_16"> 
					<fmt:message key="ShopperBid_currentAuctionsMsg" bundle="${storeText}" />
					</a>
				</c:if> 
				</font>
				
				</td>
			</tr>
		</table>


		</td>
	</tr>
</table>


