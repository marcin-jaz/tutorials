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


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "DTD/xhtml1-transitional.dtd">
<html lang="en">
<head>
<meta http-equiv="Expires" content="Mon, 01 Jan 1996 01:01:01 GMT" />
<title><fmt:message key="allBidsTitle" bundle="${storeText}" /></title>
<link rel="stylesheet" href='<c:out value="${jspStoreImgDir}${vfileStylesheet}"/>' type="text/css" />
</head>

<body>
<%@ include file="../../include/LayoutContainerTop.jspf"%>
<table cellpadding="0" cellspacing="0" border="0" width="600" id="WC_BidListDisplay_Table_1">
	
	<tbody>
		<tr>
			
			<td bgcolor="#FFFFFF" width="600" valign="top" id="WC_BidListDisplay_TableCell_1">
			<c:set var="AuctionIsClosedND" value="false" /> 
			<c:set var="isAutoBid" value="false" /> 
			<c:set var="count" value="5" /> 
			<c:set var="aucrfn" value="${WCParam.aucrfn}" /> 
			<c:set var="strNext" value="${WCParam.next}" /> 
			<c:if test="${empty strNext}">
				<c:set var="strNext" value="0" />
			</c:if> <c:set var="start" value="${strNext}" /> 
			<wcbase:useBean	id="anAuction" classname="com.ibm.commerce.negotiation.beans.AuctionDataBean">
				<c:set property="auctionId" target="${anAuction}" value="${aucrfn}" />
			</wcbase:useBean> 
			<c:set var="auction_Type" value="${anAuction.auctionType}" /> 
			<%-- Verify whether the Auction is Sealed Bid Auction --%>
			<c:choose>
				<c:when test="${auction_Type == 'SB'}">
					<p><font size="+1"> 
					<fmt:message key="errorSBMsg" bundle="${storeText}" /> 
					</font></p>
				</c:when>
				<c:otherwise>
					<c:set var="auction_Currency" value="${anAuction.currency}" />
					<c:set var="productId" value="${anAuction.entryId}" />
					<c:set var="auction_price_rule" value="${anAuction.closePriceRule}" />
					<c:set var="auction_Status" value="${anAuction.status}" />
					<c:set var="product_Desc" value="${anAuction.auctItemDesc}" />
					<c:if test="${auction_price_rule == 'ND' && auction_Status == 'SC'}">
						<c:set var="AuctionIsClosedND" value="true" />
					</c:if>
					<%-- Show all bids --%>
					<wcbase:useBean id="aBidList" classname="com.ibm.commerce.negotiation.beans.BidListBean">
						<c:set property="bidAuctionId" value="${aucrfn}" target="${aBidList}" />
						<c:set property="multipleBidStatusStr" value="A;W;WF;C"	target="${aBidList}" />
						<c:set property="sortAttByString" value="BIDPRICE;BIDQUANT;BIDTIME" target="${aBidList}" />
					</wcbase:useBean>
					<c:set var="length" value="${aBidList.bidsNum}" />

					<table cellpadding="1" cellspacing="2" width="600" border="0" id="WC_BidListDisplay_Table_2">
						<tbody>
							<tr>
								<td width="10" id="WC_BidListDisplay_TableCell_2">&nbsp;</td>
								<td align="left" valign="top" class="categoryspace" width="580" id="WC_BidListDisplay_TableCell_3">
								<font class="pageHeading"> 
								<fmt:message key="bidsSubmittedFor"	bundle="${storeText}">
									<fmt:param value="${product_Desc}" />
								</fmt:message> 
								</font>
								<hr width="100%" noshade="noshade" align="left" />
								</td>
							</tr>
							<tr>
								<td width="10" id="WC_BidListDisplay_TableCell_4">&nbsp;</td>
								<td id="WC_BidListDisplay_TableCell_5">
								<c:if test="${length > 0}">
									<table cellpadding="1" cellspacing="2" width="580" border="0" id="WC_BidListDisplay_Table_3">
										<tbody>
											<tr>
												<td align="left" valign="top" class="textOverBackgroundCharts" id="WC_BidListDisplay_TableCell_6">
												<font class="textOverBackgroundCharts"> 
												<fmt:message key="shopperName" bundle="${storeText}" /> 
												</font>
												</td>
												<td align="left" valign="top" class="textOverBackgroundCharts" id="WC_BidListDisplay_TableCell_7">
												<font class="textOverBackgroundCharts"> 
												<fmt:message key="bidValue" bundle="${storeText}" /> 
												</font>
												</td>
												<c:if test="${AuctionIsClosedND == 'true'}">
													<td align="left" valign="top" class="textOverBackgroundCharts" id="WC_BidListDisplay_TableCell_8">
													<font class="textOverBackgroundCharts"> 
													<fmt:message key="nonDiscriminative" bundle="${storeText}" /> 
													<fmt:message key="nonDiscriminativeDesc" bundle="${storeText}" />
													</font>
													<br />
													</td>
												</c:if>
												<td align="left" valign="top" class="textOverBackgroundCharts" id="WC_BidListDisplay_TableCell_9">
												<font class="textOverBackgroundCharts"> 
												<fmt:message key="bidQuantity" bundle="${storeText}" /> 
												</font>
												</td>
												<td align="left" valign="top" class="textOverBackgroundCharts" id="WC_BidListDisplay_TableCell_10">
												<font class="textOverBackgroundCharts"> 
												<fmt:message key="bidNumber" bundle="${storeText}" /> 
												</font>
												</td>
											</tr>

											<c:set var="end" value="${start + count}" />
											<c:if test="${end > length}">
												<c:set var="end" value="${length}" />
											</c:if>
											<c:forEach var="aBid" items="${aBidList.bids}"	begin="${start}" end="${end-1}" varStatus="aStatus">
												<c:set var="bdrefnum" value="${aBid.referenceCode}" />
												<c:set var="bid_id" value="${aBid.id}" />
												<c:set var="bid_Status" value="${aBid.status}" />
												<c:set var="bid_Value" value="${aBid.formattedBidPrice}" />
												<c:set var="bdwinvalue"	value="${aBid.formattedWinningPrice}" />
												<c:set var="bid_Quant" value="${aBid.formattedBidQuantity}" />
												<c:set var="bid_Child" value="${aBid.rootBidId}" />
												<c:set var="bdshrfn" value="${aBid.ownerId}" />
												<c:set var="obrefnum" value="${aBid.autoBidId}" />
												<c:set var="isAutoBid" value="false" />
												<c:if test="${! empty obrefnum}">
													<c:set var="isAutoBid" value="true" />
												</c:if>
												<c:set var="safname" value="${aBid.userInfoDataBean.firstName}" />							
												<c:set var="samname" value="${aBid.userInfoDataBean.middleName}" />							
												<c:set var="salname" value="${aBid.userInfoDataBean.lastName}" />												
												<tr>
													<td align="left" id="WC_BidListDisplay_TableCell_11_<c:out value="${aStatus.count}"/>">
													<font class="text"> 
													<fmt:message key="bidOwnerName" bundle="${storeText}">
														<fmt:param value="${safname}" />
														<fmt:param value="${samname}" />
														<fmt:param value="${salname}" />
													</fmt:message> 
													<c:if test="${( auction_Status == 'SC' && ( bid_Status == 'W' || bid_Status == 'C' )) || ( auction_Type == 'D' && ( bid_Status == 'W' || bid_Status == 'C' ) )}">
														
														<b> 
														<font color="0000FF"> 
														(<fmt:message key="winner" bundle="${storeText}" />) 
														</font> 
														</b>
														
													</c:if> </font></td>
													<td align="left" id="WC_BidListDisplay_TableCell_12_<c:out value="${aStatus.count}"/>">
													<font class="price"> 
													<c:out value="${bid_Value}" escapeXml="false"/> 
													<c:choose>
														<c:when	test="${userId == bdshrfn && auction_Status == 'C' && auction_Type == 'O' && isAutoBid == true}">
															<br />
												        	(<a	href='AutoBidUpdateForm?autobid_id=<c:out value="${obrefnum}" />&aucrfn=<c:out value="${aucrfn}" />&storeId=<c:out value="${storeId}" />&catalogId=<c:out value="${catalogId}" />' id="WC_BidListDisplay_Link_1_<c:out value="${aStatus.count}"/>">
															<fmt:message key="modifyAutobid" bundle="${storeText}" /> 
															</a>)
														</c:when>
														<c:when
															test="${userId == bdshrfn && auction_Status=='C' && auction_Type=='O' }">
															<br />
												        	(<a	href='BidUpdateForm?bid_id=<c:out value="${bid_id}" />&aucrfn=<c:out value="${aucrfn}" />&storeId=<c:out value="${storeId}" />&catalogId=<c:out value="${catalogId}" />' id="WC_BidListDisplay_Link_2_<c:out value="${aStatus.count}"/>">
															<fmt:message key="modifyBid" bundle="${storeText}" />
															</a>)
														</c:when>
													</c:choose> 
													</font>
													</td>
													<c:choose>
														<c:when	test="${AuctionIsClosedND == 'true' && (bid_Status == 'W' || bid_Status == 'C')}">
															<td nowrap="nowrap" align="center" id="WC_BidListDisplay_TableCell_13_<c:out value="${aStatus.count}"/>">
															<font class="price"> 
															<c:out value="${bdwinvalue}" /> 
															</font>
															</td>
														</c:when>
														<c:when test="${AuctionIsClosedND == 'true'}">
															<td nowrap="nowrap" align="center" id="WC_BidListDisplay_TableCell_14_<c:out value="${aStatus.count}"/>">
															<font class="text">
															--- </font>
															</td>
														</c:when>
													</c:choose>


													<td align="left" id="WC_BidListDisplay_TableCell_15_<c:out value="${aStatus.count}"/>">
													<font class="text"> 
													<c:out value="${bid_Quant}" /> 
													</font>
													</td>
													<td align="left" id="WC_BidListDisplay_TableCell_16_<c:out value="${aStatus.count}"/>">
													<font class="text"> 
													<c:out value="${bdrefnum}" />
													<br />
													</font>
													</td>
												</tr>

											</c:forEach>
										</tbody>
									</table>
								</c:if>

								<hr width="100%" noshade="noshade" align="left" />
								<br />
								<table cellpadding="3" cellspacing="0" border="0" id="WC_BidListDisplay_Table_4">
									<tbody>
										<tr>
											<c:set var="nextStartPt" value="${end}" />
											<c:set var="prevStartPt" value="${start - count}" />
											<c:if test="${prevStartPt >= 0}">
												<td align="center" valign="middle" class="buttonStyle" id="WC_BidListDisplay_TableCell_17">
												<font class="buttonStyle"> 
												<a href='BidListView?storeId=<c:out value="${storeId}" />&catalogId=<c:out value="${catalogId}" />&aucrfn=<c:out value="${aucrfn}" />&next=<c:out value="${prevStartPt}" />' id="WC_BidListDisplay_Link_3">
												&lt;
												<fmt:message key="txtPrevious" bundle="${storeText}" /> 
												</a> 
												</font>
												</td>
											</c:if>
											<c:if test="${nextStartPt < length}">
												<td align="center" valign="middle" class="buttonStyle" id="WC_BidListDisplay_TableCell_18">
												<font class="buttonStyle"> 
												<a href='BidListView?storeId=<c:out value="${storeId}" />&catalogId=<c:out value="${catalogId}" />&aucrfn=<c:out value="${aucrfn}" />&next=<c:out value="${nextStartPt}" />' id="WC_BidListDisplay_Link_4">
												<fmt:message key="txtNext" bundle="${storeText}" />
												&gt;
												</a> 
												</font>
												</td>
											</c:if>
										</tr>
									</tbody>
								</table>

								</td>
							</tr>
						</tbody>
					</table>

					<c:if test="${length eq 0}">

						<font class="productName"> <tt> 
						<fmt:message key="noBidPrd" bundle="${storeText}" /> 
						</tt> <br />
						</font> 						
						<fmt:message key="returnHomeMsg" bundle="${storeText}"/>
						<br/><br/>
						<c:url value="AuctionHomeView" var="auctionHomeViewUrl">
							<c:param name="storeId" value="${storeId}"/>
							<c:param name="catalogId" value="${catalogId}"/>								
						</c:url>						
						<a class="button" href="<c:out value="${auctionHomeViewUrl}"/>" id="WC_BidListDisplay_Link_5">
							<fmt:message key="auctionHomePage" bundle="${storeText}"/>
						</a>		
						
					</c:if>
				</c:otherwise>
			</c:choose>
			</td>
		</tr>
		
	</tbody>
</table>

<%@ include file="../../include/LayoutContainerBottom.jspf"%>
</body>
</html>
