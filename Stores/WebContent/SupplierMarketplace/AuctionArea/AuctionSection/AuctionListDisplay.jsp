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

<%@ include file="../../include/JSTLEnvironmentSetup.jspf"%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "DTD/xhtml1-transitional.dtd" >
<html>
<head>
<title><fmt:message key="AuctionList_allAuctions" bundle="${storeText}" /></title>
<link rel="stylesheet" href='<c:out value="${fileDir}"/>ToolTech.css' type="text/css" />
</head>

<body>

<flow:ifEnabled feature="customerCare">
<%--Set header type needed for this JSP for LiveHelp.  This must be set before HeaderDisplay.jsp--%>
<c:set var="liveHelpPageType" value="personal" scope="request" />
</flow:ifEnabled>
 
<%@ include file="../../include/LayoutContainerTop.jspf"%>

<table id="WC_AuctionListDisplay_Table_1" border="0" cellpadding="0" cellspacing="0" width="790" >
	<tr>		

		<td id="WC_AuctionListDisplay_TableCell_2" valign="top" width="630">
		<c:set	var="status" value="${WCParam.status}" /> 
		<c:set var="strNext" value="${WCParam.next}" /> 
		<c:set var="auctionStoreId"	value="${WCParam.auctionStoreId}" /> 
		<c:set var="lang" value="${CommandContext.languageId}" /> 
		<c:set var="count" value="5" />
		<c:set var="length" value="0" /> 
		<c:set var="noItemOnAuction" value="true" /> 
		<wcbase:useBean id="ailb" classname="com.ibm.commerce.negotiation.beans.AuctionInfoListBean">
			<c:choose>
				<c:when test="${! empty auctionStoreId }">
					<c:set property="auctStoreId" value="${auctionStoreId}"	target="${ailb}" />
				</c:when>
				<c:otherwise>
					<c:set property="auctChannelStoreId" value="${storeId}"	target="${ailb}" />
				</c:otherwise>
			</c:choose>
			<c:choose>
				<c:when test="${status=='C' || status=='F'}">
					<c:set property="auctStatus" value="${status}" target="${ailb}" />
				</c:when>
				<c:otherwise>
					<c:set property="auctMultipleStatusWithString" value="SC;BC" target="${ailb}" />
				</c:otherwise>
			</c:choose>
		</wcbase:useBean>
		<c:choose>
			<c:when test="{empty strNext}">
				<c:set var="start" value="0" />
			</c:when>
			<c:otherwise>
				<c:set var="start" value="${strNext}" />
			</c:otherwise>
		</c:choose>
		<table id="WC_AuctionListDisplay_Table_2" cellpadding="0" cellspacing="8" border="0">
			<tr>
				<td id="WC_AuctionListDisplay_TableCell_3" align="left" valign="top" colspan="5" class="categoryspace" width="100%">
				<h1>
				<c:choose>
					<c:when test="${status=='C'}">
						<fmt:message key="AuctionCommonText_CurrentAuctions" bundle="${storeText}" />
					</c:when>
					<c:when test="${status=='F'}">
						<fmt:message key="AuctionCommonText_FutureAuctions"	bundle="${storeText}" />
					</c:when>
					<c:otherwise>
						<fmt:message key="AuctionCommonText_RecentlyClosedAuctions"	bundle="${storeText}" />
					</c:otherwise>
				</c:choose>
				</h1>

				<hr width="100%" noshade="noshade" align="left" />
				
				<font class="productName"> 
				<%-- date needs to be formatted here --%>
				<fmt:message key="AuctionList_lastRefreshMsg" bundle="${storeText}">
					<fmt:param value="${ailb.formattedCurrentTime}"/>									
				</fmt:message> <br />
				<br />
				<br />
				</font>
				</td>
			</tr>


			

			<c:set var="aList" value="${ailb.auctions}" />

			<c:set var="length" value="${ailb.auctionsNum}" />

			<%-- Make sure that we have some current auctions, otherwise do not bother --%>
			<c:if test="${length > 0}">
				<c:set var="noItemOnAuction" value="false" />
				<tr>
					<td>
					<table id="WC_AuctionListDisplay_Table_3" cellpadding="0" cellspacing="1" width="100%" border="0" bgcolor="#4C6178">
						<tr bgcolor="#4C6178">
							<td id="WC_AuctionListDisplay_TableCell_4" align="left"	valign="top" class="textOverBackgroundCharts">
							<font style="font-family: Verdana" color="#FFFFFF"> 
							<fmt:message key="AuctionCommonText_ProductName" bundle="${storeText}" />
							<c:if test="${status=='F'}">
								<br /> (<fmt:message key="AuctionList_auctionRules"	bundle="${storeText}" />)
							</c:if> 
							</font>
							</td>
							<td id="WC_AuctionListDisplay_TableCell_5" align="left"	valign="top" class="textOverBackgroundCharts">
							<font	style="font-family: Verdana" color="#FFFFFF"> 
							<fmt:message key="AuctionCommonText_Quantity" bundle="${storeText}" /> 
							</font>
							</td>
							<td id="WC_AuctionListDisplay_TableCell_6" align="left"	valign="top" class="textOverBackgroundCharts">
							<font style="font-family: Verdana" color="#FFFFFF"> 
							<fmt:message key="AuctionCommonText_AuctionType" bundle="${storeText}" />
							<c:if test="${status=='C'}">
								<br /> 
								(<fmt:message key="AuctionCommonText_BestBid" bundle="${storeText}" />)
								<br /> (<fmt:message key="AuctionCommonText_SeeAllBids"	bundle="${storeText}" />)
							</c:if> 
							</font>
							</td>
							<td id="WC_AuctionListDisplay_TableCell_7" align="left"	valign="top" class="textOverBackgroundCharts">
							<font style="font-family: Verdana" color="#FFFFFF"> 
							<c:choose>
								<c:when test="${status=='C'}">
									<fmt:message key="AuctionCommonText_ColBidSubmissionDeadline" bundle="${storeText}" />
								</c:when>
								<c:when test="${status=='F'}">
									<fmt:message key="AuctionList_auctionStarts" bundle="${storeText}" />
								</c:when>
								<c:otherwise>
									<fmt:message key="AuctionCommonText_LowestWinningBid" bundle="${storeText}" />
								</c:otherwise>
							</c:choose> 
							</font>
							</td>
							<td id="WC_AuctionListDisplay_TableCell_8" align="left"	valign="top" class="textOverBackgroundCharts">
							<font style="font-family: Verdana" color="#FFFFFF"> 
							<c:choose>
								<c:when test="${status=='C' || status=='F'}">
									<fmt:message key="AuctionCommonText_CMBidMsg" bundle="${storeText}" />
								</c:when>
								<c:otherwise>
									<fmt:message key="AuctionCommonText_ClosingTime" bundle="${storeText}" />
								</c:otherwise>
							</c:choose> 
							</font>
							</td>
						</tr>

						<c:set var="end" value="${start+count}" />
						<c:if test="${end > length}">
							<c:set var="end" value="${length}" />
						</c:if>

						<c:forEach var="anAuctionInfoDataBean" items="${ailb.auctions}"	begin="${start}" end="${end-1}" varStatus="aStatus">
							<c:set var="aucrfn" value="${anAuctionInfoDataBean.id}" />
							<c:set var="austatus" value="${anAuctionInfoDataBean.status}" />
							<c:set var="autype" value="${anAuctionInfoDataBean.auctionType}" />
							<c:set var="auenddat" value="${anAuctionInfoDataBean.formattedRealEndTime}" />
							<c:set var="austartdat"	value="${anAuctionInfoDataBean.formattedStartTime}" />
							<c:set var="auminbid" value="${anAuctionInfoDataBean.formattedAuctReservePrice}" />
							<c:set var="productId" value="${anAuctionInfoDataBean.entryId}" />
							<c:set var="bestBidId" value="${anAuctionInfoDataBean.bestBidId}" />
							<c:set var="currency" value="${anAuctionInfoDataBean.currency}" />
							<c:set var="auctionStoreId"	value="${anAuctionInfoDataBean.storeId}" />
							<c:if test="${! empty productId }">
								<c:set var="prsdesc" value="${anAuctionInfoDataBean.catalogEntryShortDescription}" />
							</c:if>
							<c:if test="${status != 'F'}">
								<c:choose>
									<c:when test="${! empty bestBidId }">
										<c:set var="bdvalue" value="${anAuctionInfoDataBean.formattedBestBidVal}" />
									</c:when>
									<c:otherwise>
										<c:set var="bdvalue" value="0" />
									</c:otherwise>
								</c:choose>
							</c:if>
							<c:choose>
								<c:when test="${aStatus.count%2 == 0}">
									<c:set var="color" value="#ffffff" />
								</c:when>
								<c:otherwise>
									<c:set var="color" value="#bccbdb" />
								</c:otherwise>
							</c:choose>
							<tr bgcolor='<c:out value="${color}" />'>
								<td	id='WC_AuctionListDisplay_TableCell_9_<c:out value="${aStatus.count}"/>' width="150" align="left">
								<font class="text"> 
								<c:choose>
									<c:when test="${status=='C'}">
										<a	href='ProductDisplay?storeId=<c:out value="${storeId}" />&productId=<c:out value="${productId}" />&langId=<c:out value="${lang}" />&fromAuction=true'
											id='WC_AuctionListDisplay_Link_1_<c:out value="${aStatus.count}"/>'>
										<c:out value="${prsdesc}" /></a>
									</c:when>
									<c:otherwise>
										<a	href='DisplayAuctionItem?auctionStoreId=<c:out value="${auctionStoreId}" />&aucrfn=<c:out value="${aucrfn}" />&productId=<c:out value="${productId}" />&langId=<c:out value="${lang}" />&fromAuction=true'
											id='WC_AuctionListDisplay_Link_2_<c:out value="${aStatus.count}"/>'>
										<c:out value="${prsdesc}" /></a>
									</c:otherwise>
								</c:choose> 
								<c:if test="${! empty auminbid }">
									*
								</c:if> 
								<br />
								<a	href='DisplayAuctionRules?auctionStoreId=<c:out value="${auctionStoreId}" />&aucrfn=<c:out value="${aucrfn}" />'
									id='WC_AuctionListDisplay_Link_3_<c:out value="${aStatus.count}"/>'>
								<fmt:message key="AuctionList_auctionRules"	bundle="${storeText}" /> 
								</a> 
								</font>
								</td>
								<c:choose>
									<c:when test="${status=='C'}">
										<c:choose>
											<c:when test="${autype=='O' || autype=='SB'}">
												<c:set var="auquant" value="${anAuctionInfoDataBean.formattedQuantity}" />
											</c:when>
											<c:otherwise>
												<c:set var="auquant" value="${anAuctionInfoDataBean.formattedCurrentQuantity}" />
											</c:otherwise>
										</c:choose>
									</c:when>
									<c:otherwise>
										<c:set var="auquant" value="${anAuctionInfoDataBean.formattedQuantity}" />
									</c:otherwise>
								</c:choose>
								<td	id='WC_AuctionListDisplay_TableCell_10_<c:out value="${aStatus.count}"/>' width="75" align="left">
								<font class="text"> 
								<c:out	value="${auquant}" /> 
								</font>
								</td>
								<td	id='WC_AuctionListDisplay_TableCell_11_<c:out value="${aStatus.count}"/>' width="125" align="left"><font class="text"> 
								<c:choose>
									<c:when test="${autype=='O'}">
										<fmt:message key="AuctionList_openCry"	bundle="${storeText}" />
										<c:if test="${status=='C'}">
											<br />(<font class="price"><c:out value="${bdvalue}" escapeXml="false"/></font>)
											<br />
											<a href='BidListView?auctionStoreId=<c:out value="${auctionStoreId}" />&aucrfn=<c:out value="${aucrfn}" /> '
												id='WC_AuctionListDisplay_Link_4_<c:out value="${aStatus.count}"/>'>
												(<fmt:message key="AuctionList_seeAllBids" bundle="${storeText}" />)
												</a>
										</c:if>
									</c:when>
									<c:when test="${autype=='SB'}">
										<fmt:message key="AuctionList_sealedBid" bundle="${storeText}" />
										<br />
									</c:when>
									<c:when test="${autype=='D'}">
										<fmt:message key="AuctionList_dutchAuction"	bundle="${storeText}" />
										<br />
										<c:if test="${status=='C'}">
											<a	href='BidListView?auctionStoreId=<c:out value="${auctionStoreId}" />&aucrfn=<c:out value="${aucrfn}" />'
												id='WC_AuctionListDisplay_Link_5_<c:out value="${aStatus.count}"/>'>
												(<fmt:message key="AuctionList_seeAllBids" bundle="${storeText}" />)
												</a>
										</c:if>
									</c:when>
									<c:otherwise>
										<fmt:message key="AuctionList_unknownType"	bundle="${storeText}" />
									</c:otherwise>
								</c:choose> 
								</font>
								</td>
								<td id='WC_AuctionListDisplay_TableCell_12_<c:out value="${aStatus.count}"/>'width="140" align="left">
								<font class="text"> 
								<c:choose>
									<c:when test="${status=='F'}">
										<c:out value="${austartdat}" />
									</c:when>
									<c:when test="${status=='C'}">
										<c:out value="${auenddat}" />
										<br />
									</c:when>
									<c:otherwise>
										<c:choose>
											<c:when test="${empty bdvalue || autype=='D'}">
												---
											</c:when>
											<c:otherwise>
												<font class="price">
												<c:out value="${bdvalue}" escapeXml="false"/>
												</font>

											</c:otherwise>
										</c:choose>
									</c:otherwise>
								</c:choose> 
								</font>
								</td>
								<td	id='WC_AuctionListDisplay_TableCell_13_<c:out value="${aStatus.count}"/>'width="140" align="left">
								<font class="text"> 
								<c:choose>
									<c:when test="${status=='C' || status=='F'}">
										<c:if test="${status=='C' && auquant!='0'}">
											<a	href='BidCreateForm?auctionStoreId=<c:out value="${auctionStoreId}" />&aucrfn=<c:out value="${aucrfn}" />'
												id='WC_AuctionListDisplay_Link_5_<c:out value="${aStatus.count}"/>'>
											<fmt:message key="AuctionList_newBid" bundle="${storeText}" /> 
											</a>
											<br />
										</c:if>
										<c:if test="${autype=='O'}">
											<a	href='AutoBidCreateForm?auctionStoreId=<c:out value="${auctionStoreId}" />&aucrfn=<c:out value="${aucrfn}" />'
												id='WC_AuctionListDisplay_Link_6_<c:out value="${aStatus.count}"/>'>
											<fmt:message key="AuctionList_newAutoBid" bundle="${storeText}" /> </a>
											<br />
										</c:if>
										<c:choose>
											<c:when	test="${status=='C' || (status == 'F' && autype=='O')}">
												<a	href='ShopperBidListView?status=<c:out value="${status}" />&yourBids=true&aucrfn=<c:out value="${aucrfn}" />'
													id='WC_AuctionListDisplay_Link_7_<c:out value="${aStatus.count}"/>'>
												<fmt:message key="AuctionList_yourBids"	bundle="${storeText}" /> 
												</a>
											</c:when>
											<c:otherwise>
												---
											</c:otherwise>
										</c:choose>
									</c:when>
									<c:otherwise>
										<c:out value="${auenddat}" />
										<br />
									</c:otherwise>
								</c:choose> 
								</font>
								</td>
							</tr>
						</c:forEach>
					</table>
					</td>
				</tr>
			</c:if>
		</table>
		<table id="WC_AuctionListDisplay_Table_4" cellpadding="0" cellspacing="8" border="0" width="100%">
			<tr>
				<td id="WC_AuctionListDisplay_TableCell_14" align="left" valign="top" colspan="5" class="categoryspace" width="100%">
				<hr width="100%" noshade="noshade" align="left" />
				<font class="strongtext"> 
				<fmt:message key="AuctionList_reservePrice" bundle="${storeText}" /> 
				</font>
				</td>
			</tr>
		</table>
		<table id="WC_AuctionListDisplay_Table_5" cellpadding="0" cellspacing="8" border="0" width="100%">
			<tr>
				<c:set var="nextStartPt" value="${end}" />
				<c:set var="prevStartPt" value="${start - count}" />
				<c:if test="${prevStartPt gt 0 }">
					<td><br />
					<!-- Start display for button -->
					<table id="WC_AuctionListDisplay_Table_6" cellpadding="0"
						cellspacing="0" border="0">
						<tr>
							<td id="WC_AuctionListDisplay_TableCell_15" bgcolor="#ff2d2d" class="pixel">
							<img src='<c:out value="${jspStoreImgDir}" />images/lb.gif'	border="0" alt=""/>
							</td>
							<td id="WC_AuctionListDisplay_TableCell_16" bgcolor="#ff2d2d" class="pixel">
							<img src='<c:out value="${jspStoreImgDir}" />images/lb.gif'	border="0" alt=""/>
							</td>
							<td id="WC_AuctionListDisplay_TableCell_17" class="pixel">
							<img src='<c:out value="${jspStoreImgDir}" />images/r_top.gif'	border="0" alt=""/>
							</td>
						</tr>
						<tr>
							<td id="WC_AuctionListDisplay_TableCell_18" bgcolor="#ff2d2d">
							<img src='<c:out value="${jspStoreImgDir}" />images/lb.gif' border="0" alt=""/>
							</td>
							<td id="WC_AuctionListDisplay_TableCell_19" bgcolor="#ea2b2b">
							<table id="WC_AuctionListDisplay_Table_7" cellpadding="2" cellspacing="0" border="0">
								<tr>
									<td id="WC_AuctionListDisplay_TableCell_20" class="buttontext">
									<font color="#ffffff"> 
									<a	href='AuctionListView?status=<c:out value="${status}" />&next=<c:out value="${prevStartPt}" />'
										style="color: #ffffff; text-decoration: none"
										id="WC_AuctionListDisplay_Link_8"> &lt; 
										<fmt:message key="AuctionCommonText_Previous" bundle="${storeText}" />
									</a> 
									</font>
									</td>
								</tr>
							</table>
							</td>
							<td id="WC_AuctionListDisplay_TableCell_21" bgcolor="#7a1616">
							<img src='<c:out value="${jspStoreImgDir}"/>images/db.gif' border="0" alt="" />
							</td>
						</tr>
						<tr>
							<td id="WC_AuctionListDisplay_TableCell_21" class="pixel">
							<img src='<c:out value="${jspStoreImgDir}" />images/l_bot.gif' alt=""/>
							</td>
							<td id="WC_AuctionListDisplay_TableCell_22" bgcolor="#7a1616"	class="pixel" valign="top">
							<img src='<c:out value="${jspStoreImgDir}" />images/db.gif'	border="0" alt=""/>
							</td>
							<td id="WC_AuctionListDisplay_TableCell_23" bgcolor="#7a1616" class="pixel" valign="top">
							<img src='<c:out value="${jspStoreImgDir}" />images/db.gif'	border="0" alt=""/>
							</td>
						</tr>
					</table>
					<!-- End display for button --></td>
				</c:if>
				<c:if test="${nextStartPt < length}">
					<td><!-- Start display for button -->
					<table id="WC_AuctionListDisplay_Table_8" cellpadding="0"	cellspacing="0" border="0">
						<tr>
							<td id="WC_AuctionListDisplay_TableCell_24" bgcolor="#ff2d2d"class="pixel">
							<img src='<c:out value="${jspStoreImgDir}" />images/lb.gif'	border="0" alt=""/>
							</td>
							<td id="WC_AuctionListDisplay_TableCell_25" bgcolor="#ff2d2d" class="pixel">
							<img src='<c:out value="${jspStoreImgDir}" />images/lb.gif'	border="0" alt=""/>
							</td>
							<td id="WC_AuctionListDisplay_TableCell_26" class="pixel">
							<img src='<c:out value="${jspStoreImgDir}" />images/r_top.gif' border="0" alt=""/>
							</td>
						</tr>
						<tr>
							<td id="WC_AuctionListDisplay_TableCell_27" bgcolor="#ff2d2d">
							<img src='<c:out value="${jspStoreImgDir}" />images/lb.gif'	border="0" alt=""/>
							</td>
							<td id="WC_AuctionListDisplay_TableCell_28" bgcolor="#ea2b2b">
							<table id="WC_AuctionListDisplay_Table_9" cellpadding="2" cellspacing="0" border="0">
								<tr>
									<td id="WC_AuctionListDisplay_TableCell_29" class="buttontext">
									<font color="#ffffff"> 
									<a	href='AuctionListView?status=<c:out value="${status}" />&next=<c:out value="${nextStartPt}" />'
										style="color: #ffffff; text-decoration: none"
										id="WC_AuctionListDisplay_Link_9"> 
										<fmt:message key="AuctionCommonText_Next" bundle="${storeText}" /> &gt;
									</a> 
									</font>
									</td>
								</tr>
							</table>
							</td>
							<td id="WC_AuctionListDisplay_TableCell_30" bgcolor="#7a1616">
							<img src='<c:out value="${jspStoreImgDir}" />images/db.gif' border="0" alt=""/>
							</td>
						</tr>
						<tr>
							<td id="WC_AuctionListDisplay_TableCell_31" class="pixel">
							<img src='<c:out value="${jspStoreImgDir}" />images/l_bot.gif' alt=""/>
							</td>
							<td id="WC_AuctionListDisplay_TableCell_32" bgcolor="#7a1616" class="pixel" valign="top">
							<img src='<c:out value="${jspStoreImgDir}" />images/db.gif'	border="0" alt=""/>
							</td>
							<td id="WC_AuctionListDisplay_TableCell_33" bgcolor="#7a1616" class="pixel" valign="top">
							<img src='<c:out value="${jspStoreImgDir}" />images/db.gif'	border="0" alt=""/>
							</td>
						</tr>
					</table>
					<!-- End display for button -->
					</td>
				</c:if>				

				<c:if test="${noItemOnAuction == true}">
					<td id="WC_AuctionListDisplay_TableCell_34" width="100%" align="left" nowrap="nowrap">
					<font class="productName"> <tt>
					<fmt:message key="AuctionList_noAuctionsMsg" bundle="${storeText}" /></tt>
					</font>
					</td>					
				</c:if>
			</tr>
		</table>



		<table id="WC_AuctionListDisplay_Table_10" cellpadding="0"
			cellspacing="8" border="0" width="100%">
			<tr>
				<td id="WC_AuctionListDisplay_TableCell_35"><br />
				<font> <c:choose>
					<c:when test="${status=='C'}">
						<a href="AuctionListView?status=F"	id="WC_AuctionListDisplay_Link_10"> 
						<fmt:message key="AuctionList_futureAuctionsMsg" bundle="${storeText}" />
						</a>
						<br />
						<br />
						<a href="AuctionListView?status=BCSC" id="WC_AuctionListDisplay_Link_11"> 
						<fmt:message key="AuctionList_closedAuctionsMsg" bundle="${storeText}" />
						</a>
					</c:when>
					<c:when test="${status=='F'}">
						<a href="AuctionListView?status=C"	id="WC_AuctionListDisplay_Link_12"> 
						<fmt:message key="AuctionList_currentAuctionsMsg" bundle="${storeText}" />
						</a>
						<br />
						<br />
						<a href="AuctionListView?status=BCSC" id="WC_AuctionListDisplay_Link_13"> 
						<fmt:message key="AuctionList_closedAuctionsMsg" bundle="${storeText}" />
						</a>
					</c:when>
					<c:otherwise>
						<a href="AuctionListView?status=F" id="WC_AuctionListDisplay_Link_14"> 
						<fmt:message key="AuctionList_futureAuctionsMsg" bundle="${storeText}" />
						</a>
						<br />
						<br />
						<a href="AuctionListView?status=C"	id="WC_AuctionListDisplay_Link_15"> 
						<fmt:message key="AuctionList_currentAuctionsMsg" bundle="${storeText}" />
						</a>
					</c:otherwise>
				</c:choose> 
				</font>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<%@ include file="../../include/LayoutContainerBottom.jspf"%>
</body>
</html>
