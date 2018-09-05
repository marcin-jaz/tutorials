<%--
 * 
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

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "DTD/xhtml1-transitional.dtd"/>
<html>
<head>
	<meta http-equiv="Expires" content="Mon, 01 Jan 1996 01:01:01 GMT"/>
	<title><fmt:message key="BidList_allBidsTitle" bundle="${storeText}" /></title>
	<link rel="stylesheet" href="<c:out value="${fileDir}"/>ToolTech.css" type="text/css"/>
</head>
<body>

<flow:ifEnabled feature="customerCare">
<%--Set header type needed for this JSP for LiveHelp.  This must be set before HeaderDisplay.jsp--%>
<c:set var="liveHelpPageType" value="personal" scope="request" />
</flow:ifEnabled>

<%@ include file="../../include/LayoutContainerTop.jspf"%>

<table id="WC_BidListDisplay_Table_1" border="0" cellpadding="0" cellspacing="0" width="790" >
<tr>	

	<td id="WC_BidListDisplay_TableCell_2" valign="top" width="630">
	
	<c:set var="AuctionIsClosedND" value="false" />
	<c:set var="isAutoBid" value="false" />
	<c:set var="count" value="5" />
	<c:set var="aucrfn" value="${WCParam.aucrfn}" />
	<c:set var="auctionStoreId" value="${WCParam.auctionStoreId}" />
	<c:set var="strNext" value="${WCParam.next}" />	
	<c:if test="${empty strNext}">
		<c:set var="strNext" value="0" />
	</c:if>
	<c:set var="start" value="${strNext}" />
	<wcbase:useBean id="anAuction" classname="com.ibm.commerce.negotiation.beans.AuctionDataBean" >
		<c:set property="auctionId" value="${aucrfn}" target="${anAuction}" />
	</wcbase:useBean>
	<c:set var="auction_Type" value="${anAuction.auctionType}" />
	<%-- Verify whether the Auction is Sealed Bid Auction --%>
	<c:choose>
		<c:when test="${auction_Type == 'SB'}">
			<p>
			<font size="+1">
				<fmt:message key="BidList_errorSBMsg" bundle="${storeText}" />
			</font>
			</p>
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
			<wcbase:useBean id="aBidList" classname="com.ibm.commerce.negotiation.beans.BidListBean" >
				<c:set property="bidAuctionId" value="${aucrfn}" target="${aBidList}" />
				<c:set property="multipleBidStatusStr" value="A;W;WF;C" target="${aBidList}" />
				<c:set property="sortAttByString" value="BIDPRICE;BIDQUANT;BIDTIME" target="${aBidList}" />
			</wcbase:useBean>
			<c:set var="length" value="${aBidList.bidsNum}" />
			<table id="WC_BidListDisplay_Table_2" cellpadding="0" cellspacing="8" border="0">
				<tr>
					<td id="WC_BidListDisplay_TableCell_3" align="left" valign="top" class="categoryspace" width="100%">
						<h1>
							<fmt:message key="BidList_bidsSubmittedFor" bundle="${storeText}">
								<fmt:param value="${product_Desc}" />
							</fmt:message>
						</h1>
						<hr width="100%" noshade="noshade" align="left" /> 
					</td>
				</tr>
				<tr>
					<td>
						<c:if test="${length > 0}">
						<table id="WC_BidListDisplay_Table_3" cellpadding="0" cellspacing="1" width="100%" border="0" bgcolor="#4C6178">
							<tr bgcolor="#4C6178">
								<td id="WC_BidListDisplay_TableCell_4" align="left" valign="top" class="textOverBackgroundCharts">
									<strong>
										<font style="font-family : Verdana;" color="#FFFFFF">
											<fmt:message key="BidList_shopperName" bundle="${storeText}" />
										</font>
									</strong>
								</td>
								<td id="WC_BidListDisplay_TableCell_5" align="left" valign="top" class="textOverBackgroundCharts">
									<strong>
										<font style="font-family : Verdana;" color="#FFFFFF">
											<fmt:message key="BidList_bidValue" bundle="${storeText}" />
										</font>
									</strong>
								</td>
								<c:if test="${AuctionIsClosedND == 'true'}">
						        <td id="WC_BidListDisplay_TableCell_6" align="left" valign="top" class="textOverBackgroundCharts">
									<strong>
							        	<font style="font-family : Verdana;" color="#FFFFFF">
											<fmt:message key="BidList_nonDiscriminative" bundle="${storeText}" /><br />
							        	</font>
									</strong>
        						</td>
								</c:if>								
								<td id="WC_BidListDisplay_TableCell_7" align="left" valign="top" class="textOverBackgroundCharts">
									<strong>
										<font style="font-family : Verdana;" color="#FFFFFF">
											<fmt:message key="BidList_bidQuantity" bundle="${storeText}" />
										</font>
									</strong>
								</td>
								<td id="WC_BidListDisplay_TableCell_8" align="left" valign="top" class="textOverBackgroundCharts">
									<strong>
										<font style="font-family : Verdana;" color="#FFFFFF">
											<fmt:message key="BidList_bidNumber" bundle="${storeText}" />
										</font>
									</strong>
								</td>                   
							</tr>
							<c:set var="end" value="${start + count}" />
							<c:if test="${end > length}">
								<c:set var="end" value="${length}" />
							</c:if>								
							<c:forEach var="aBid" items="${aBidList.bids}" begin="${start}" end="${end-1}" varStatus="aStatus">
								<c:set var="bdrefnum" value="${aBid.referenceCode}" />
								<c:set var="bid_id" value="${aBid.id}" />
								<c:set var="bid_Status" value="${aBid.status}" />
								<c:set var="bid_Value" value="${aBid.formattedBidPrice}" />
								<c:set var="bdwinvalue" value="${aBid.formattedWinningPrice}" />
								<c:set var="bid_Quant" value="${aBid.formattedBidQuantity}" />
								<c:set var="bid_Child" value="${aBid.rootBidId}" />
								<c:set var="bdshrfn" value="${aBid.ownerId}" />
								<c:set var="obrefnum" value="${aBid.autoBidId}" />								
								<c:set var="isAutoBid" value="false" />
								<c:if test="${! empty obrefnum }">
									<c:set var="isAutoBid" value="true" />
								</c:if>
								<c:choose>
									<c:when test="${aStatus.count%2 == 0}">
										<c:set var="color" value="#ffffff" />
									</c:when>
									<c:otherwise>
										<c:set var="color" value="#bccbdb" />
									</c:otherwise>
								</c:choose>
							<tr bgcolor="<c:out value="${color}"/>">								
								
								<c:set var="safname" value="${aBid.userInfoDataBean.firstName}" />							
								<c:set var="samname" value="${aBid.userInfoDataBean.middleName}" />							
								<c:set var="salname" value="${aBid.userInfoDataBean.lastName}" />
								
								<td id="WC_BidListDisplay_TableCell_9_<c:out value="${aStatus.count}"/>" align="left">
									<font class="text">
										<fmt:message key="BidList_bidOwnerName" bundle="${storeText}">
											<fmt:param value="${safname}" />
											<fmt:param value="${samname}" />
											<fmt:param value="${salname}" />
										</fmt:message>
										<c:if test="${( auction_Status == 'SC' && ( bid_Status == 'W' || bid_Status == 'C' )) || ( auction_Type == 'D' && ( bid_Status == 'W' || bid_Status == 'C' ) )}">
											
											<b>
												<font color="0000FF" > 
												(<fmt:message key="BidList_winner" bundle="${storeText}" />)
												</font>
											</b>
											                       
										</c:if>
									</font>
								</td>   
								<td id="WC_BidListDisplay_TableCell_10_<c:out value="${aStatus.count}"/>" align="left">
									
										<font class="price">
											<c:out value="${bid_Value}" escapeXml="false"/>
										</font>     
										<font class="text">
										<c:choose>
											<c:when test="${userId == bdshrfn && auction_Status == 'C' && auction_Type == 'O' && isAutoBid == true}">
						                        <br />
	                					        (<a href="AutoBidUpdateForm?autobid_id=<c:out value="${obrefnum}" />&aucrfn=<c:out value="${aucrfn}" />&auctionStoreId=<c:out value="${auctionStoreId}" />" id="WC_BidListDisplay_Link_1_<c:out value="${aStatus.count}"/>">
													<fmt:message key="BidList_modifyAutobid" bundle="${storeText}" />
												 </a>)
											</c:when>
											<c:when test="${userId == bdshrfn && auction_Status=='C' && auction_Type=='O' }">
						                        <br />
	                					        (<a href="BidUpdateForm?bid_id=<c:out value="${bid_id}" />&aucrfn=<c:out value="${aucrfn}" />&auctionStoreId=<c:out value="${auctionStoreId}" />" id="WC_BidListDisplay_Link_2_<c:out value="${aStatus.count}"/>">
													<fmt:message key="BidList_modifyBid" bundle="${storeText}" />
												 </a>)
											</c:when>
										</c:choose>
									</font>
								</td>   
						<c:choose>
							<c:when test="${AuctionIsClosedND == 'true' && (bid_Status == 'W' || bid_Status == 'C')}">
								<td id="WC_BidListDisplay_TableCell_11_<c:out value="${aStatus.count}"/>" nowrap="nowrap" align="center">
									<font class="price">
										<c:out value="${bdwinvalue}" escapeXml="false"/>
									</font>
								</td>   
							</c:when>
							<c:when test="${AuctionIsClosedND == 'true'}">
								<td id="WC_BidListDisplay_TableCell_12_<c:out value="${aStatus.count}"/>" nowrap="nowrap" align="center">
									<font class="text">
										---
									</font>
								</td>   
							</c:when>							
						</c:choose>	
								<td id="WC_BidListDisplay_TableCell_13_<c:out value="${aStatus.count}"/>" align="left">
									<font class="text">
										<c:out value="${bid_Quant}" />
									</font>
								</td>   
								<td id="WC_BidListDisplay_TableCell_14_<c:out value="${aStatus.count}"/>" align="left">
									<font class="text">
										<c:out value="${bdrefnum}" /><br />
									</font>
								</td>   
							</tr>  
							</c:forEach>
						</table>         

						<hr width="100%" noshade="noshade" align="left" /> 
						<br />
						<table id="WC_BidListDisplay_Table_4" cellpadding="3" cellspacing="0" border="0">
							<tr>
								<c:set var="nextStartPt" value="${end}" />
								<c:set var="prevStartPt" value="${start - count}" />
								<c:if test="${prevStartPt >= 0}" >
								<td id="WC_BidListDisplay_TableCell_15" align="center" valign="middle" class="buttonStyle">
									<!-- Start display for button -->
									<table id="WC_BidListDisplay_Table_5" cellpadding="0" cellspacing="0" border="0">
										<tr>
											<td id="WC_BidListDisplay_TableCell_16" bgcolor="#ff2d2d" class="pixel"><img src="<c:out value="${jspStoreImgDir}" />images/lb.gif" border="0" alt=""/></td>
											<td id="WC_BidListDisplay_TableCell_17" bgcolor="#ff2d2d" class="pixel"><img src="<c:out value="${jspStoreImgDir}" />images/lb.gif" border="0" alt=""/></td>
											<td id="WC_BidListDisplay_TableCell_18" class="pixel"><img src="<c:out value="${jspStoreImgDir}" />images/r_top.gif" border="0" alt=""/></td>
										</tr>
										<tr>
											<td id="WC_BidListDisplay_TableCell_19" bgcolor="#ff2d2d"><img src="<c:out value="${jspStoreImgDir}" />images/lb.gif" border="0" alt=""/></td>
											<td id="WC_BidListDisplay_TableCell_20" bgcolor="#ea2b2b">
												<table id="WC_BidListDisplay_Table_6" cellpadding="2" cellspacing="0" border="0">
													<tr>
														<td id="WC_BidListDisplay_TableCell_21" class="buttontext">
															<font color="#ffffff">
																<a href="BidListView?auctionStoreId=<c:out value="${auctionStoreId}" />&aucrfn=<c:out value="${aucrfn}" />&next=<c:out value="${prevStartPt}" />" style="color:#ffffff; text-decoration : none;" id="WC_BidListDisplay_Link_3">
																	&lt;
																	<fmt:message key="AuctionCommonText_Previous" bundle="${storeText}" />
																</a>
															</font>
														</td>
													</tr>
												</table>
											</td>
											<td id="WC_BidListDisplay_TableCell_22" bgcolor="#7a1616"><img src="<c:out value="${jspStoreImgDir}" />images/db.gif" border="0" alt=""/></td>			
										</tr>	
										<tr>
											<td id="WC_BidListDisplay_TableCell_23" class="pixel"><img src="<c:out value="${jspStoreImgDir}" />images/l_bot.gif" alt=""/></td>
											<td id="WC_BidListDisplay_TableCell_24" bgcolor="#7a1616" class="pixel" valign="top"><img src="<c:out value="${jspStoreImgDir}" />images/db.gif" border="0" alt=""/></td>
											<td id="WC_BidListDisplay_TableCell_25" bgcolor="#7a1616" class="pixel" valign="top"><img src="<c:out value="${jspStoreImgDir}" />images/db.gif" border="0" alt=""/></td>
										</tr>
									</table>
									<!-- End display for button -->
								</td>
								</c:if>
								<c:if test="${nextStartPt < length}">
								<td id="WC_BidListDisplay_TableCell_26" align="center" valign="middle" class="buttonStyle">
									<!-- Start display for button -->
									<table id="WC_BidListDisplay_Table_7" cellpadding="0" cellspacing="0" border="0">
										<tr>
											<td id="WC_BidListDisplay_TableCell_27" bgcolor="#ff2d2d" class="pixel"><img src="<c:out value="${jspStoreImgDir}" />images/lb.gif" border="0" alt=""/></td>
											<td id="WC_BidListDisplay_TableCell_28" bgcolor="#ff2d2d" class="pixel"><img src="<c:out value="${jspStoreImgDir}" />images/lb.gif" border="0" alt=""/></td>
											<td id="WC_BidListDisplay_TableCell_29" class="pixel"><img src="<c:out value="${jspStoreImgDir}" />images/r_top.gif" border="0" alt=""/></td>
										</tr>
										<tr>
											<td id="WC_BidListDisplay_TableCell_30" bgcolor="#ff2d2d"><img src="<c:out value="${jspStoreImgDir}" />images/lb.gif" border="0" alt=""/></td>
											<td id="WC_BidListDisplay_TableCell_31" bgcolor="#ea2b2b">
												<table id="WC_BidListDisplay_Table_8" cellpadding="2" cellspacing="0" border="0">
													<tr>
														<td id="WC_BidListDisplay_TableCell_32" class="buttontext">
															<font color="#ffffff">
																<a href="BidListView?auctionStoreId=<c:out value="${auctionStoreId}" />&aucrfn=<c:out value="${aucrfn}" />&next=<c:out value="${nextStartPt}" />" style="color:#ffffff; text-decoration : none;" id="WC_BidListDisplay_Link_1">
																	<fmt:message key="AuctionCommonText_Next" bundle="${storeText}" />
																	&gt;
																</a>
															</font>
														</td>
													</tr>
												</table>
											</td>
											<td bgcolor="#7a1616"><img src="<c:out value="${jspStoreImgDir}" />images/db.gif" border="0" alt=""/></td>			
										</tr>
										<tr>
											<td id="WC_BidListDisplay_TableCell_33" class="pixel"><img src="<c:out value="${jspStoreImgDir}" />images/l_bot.gif" alt=""/></td>
											<td id="WC_BidListDisplay_TableCell_34" bgcolor="#7a1616" class="pixel" valign="top"><img src="<c:out value="${jspStoreImgDir}" />images/db.gif" border="0" alt=""/></td>
											<td id="WC_BidListDisplay_TableCell_35" bgcolor="#7a1616" class="pixel" valign="top"><img src="<c:out value="${jspStoreImgDir}" />images/db.gif" border="0" alt=""/></td>
										</tr>
									</table>
									<!-- End display for button -->
								</td>
								</c:if>
							</tr>
						</table>
						</c:if>
						<c:if test="${length == 0}">
			               <font class="productName">
							   <tt>
							   	<fmt:message key="BidList_noBidPrd" bundle="${storeText}" />
				               </tt>
				               <br />
			              </font>
			               <font class="text">
							   	<fmt:message key="BidList_returnHomeMsg" bundle="${storeText}" />
						   </font>
						</c:if>			
					</td>
				</tr>
			</table>		
		</c:otherwise>
	</c:choose>
	</td>
</tr>
</table>

<%@ include file="../../include/LayoutContainerBottom.jspf"%>
</body>
</html>
