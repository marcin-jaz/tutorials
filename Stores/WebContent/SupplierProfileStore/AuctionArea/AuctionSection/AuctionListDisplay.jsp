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
<title><fmt:message key="allAuctions" bundle="${storeText}" /></title>
<link rel="stylesheet"	href='<c:out value="${jspStoreImgDir}${vfileStylesheet}"/>' type="text/css" />
</head>

<body>
<%@ include file="../../include/LayoutContainerTop.jspf"%>
<table cellpadding="0" cellspacing="0" border="0" width="600" id="WC_AuctionListDisplay_Table_1">
	
	<tbody>
		<tr>			
			<td bgcolor="#FFFFFF" width="600" valign="top" id="WC_AuctionListDisplay_TableCell_1">
			<c:set var="status"	value="${WCParam.status}" /> 
			<c:set var="strNext" value="${WCParam.next}" /> 
			<c:set var="count" value="5" /> 
			<c:set var="length" value="0" /> 
			<c:set var="noItemOnAuction" value="true" />

			<c:choose>
				<c:when test="{empty strNext}">
					<c:set var="start" value="0" />
				</c:when>
				<c:otherwise>
					<c:set var="start" value="${strNext}" />
				</c:otherwise>
			</c:choose>

			<table cellpadding="1" cellspacing="2" width="600" border="0" id="WC_AuctionListDisplay_Table_2">
				<tbody>
					<wcbase:useBean id="ailb" classname="com.ibm.commerce.negotiation.beans.AuctionInfoListBean">
						<c:set property="auctStoreId" target="${ailb}" value="${storeId}" />
						<c:choose>
							<c:when test="${status=='C' || status=='F'}">
								<c:set property="auctStatus" value="${status}" target="${ailb}" />
							</c:when>
							<c:otherwise>
								<c:set property="auctMultipleStatusWithString" value="SC;BC" target="${ailb}" />
							</c:otherwise>
						</c:choose>

					</wcbase:useBean>
					<tr>
						<td width="10" id="WC_AuctionListDisplay_TableCell_2">&nbsp;</td>
						<td align="left" valign="top" colspan="5" class="categoryspace"	width="580" id="WC_AuctionListDisplay_TableCell_3">
						<font class="pageHeading"> 
						<c:choose>
							<c:when test="${status=='C'}">
								<fmt:message key="txtCurrentAuctions" bundle="${storeText}" />
							</c:when>
							<c:when test="${status=='F'}">
								<fmt:message key="txtFutureAuctions" bundle="${storeText}" />
							</c:when>
							<c:otherwise>
								<fmt:message key="txtRecentlyClosedAuctions" bundle="${storeText}" />
							</c:otherwise>
						</c:choose> <br />
						</font>

						<hr width="100%" noshade="noshade" align="left" />

						<font class="productName"> <%-- date needs to be formatted here --%>
							
						<fmt:message key="lastRefreshMsg" bundle="${storeText}">
							<fmt:param value="${ailb.formattedCurrentTime}"/>									
						</fmt:message> <br />
						</font>
						</td>
					</tr>

					

					<c:set var="length" value="${ailb.auctionsNum}" />


					<%-- Make sure that we have some current auctions, otherwise do not bother--%>
					<c:if test="${length > 0}">
						<c:set var="noItemOnAuction" value="false" />

						<tr>
							<td width="10" id="WC_AuctionListDisplay_TableCell_4">&nbsp;</td>
							<td align="left" valign="top" class="textOverBackgroundCharts" id="WC_AuctionListDisplay_TableCell_5">
							<font class="textOverBackgroundCharts"> 
							<fmt:message key="txtProductName" bundle="${storeText}" /> 
							<c:if test="${status=='F'}">
								<br /> (<fmt:message key="auctionRules"
									bundle="${storeText}" />)
							</c:if> 
							</font>
							</td>
							<td align="left" valign="top" class="textOverBackgroundCharts" id="WC_AuctionListDisplay_TableCell_6">
							<font class="textOverBackgroundCharts"> 
							<fmt:message key="txtQuantity" bundle="${storeText}" /> 
							</font>
							</td>
							<td align="left" valign="top" class="textOverBackgroundCharts" id="WC_AuctionListDisplay_TableCell_7">
							<font class="textOverBackgroundCharts"> 
							<fmt:message key="txtAuctionType" bundle="${storeText}" /> 
							<c:if test="${status=='C'}">
								<br /> (<fmt:message key="txtBestBid" bundle="${storeText}" />)
								<br /> (<fmt:message key="txtSeeAllBids" bundle="${storeText}" />)
							</c:if> 
							</font>
							</td>
							<td align="left" valign="top" class="textOverBackgroundCharts" id="WC_AuctionListDisplay_TableCell_8">
							<font class="textOverBackgroundCharts"> 
							<c:choose>
								<c:when test="${status=='C'}">
									<fmt:message key="txtColBidSubmissionDeadline"	bundle="${storeText}" />
								</c:when>
								<c:when test="${status=='F'}">
									<fmt:message key="auctionStarts" bundle="${storeText}" />
								</c:when>
								<c:otherwise>
									<fmt:message key="txtLowestWinningBid"	bundle="${storeText}" />
								</c:otherwise>
							</c:choose> 
							</font>
							</td>
							<td align="left" valign="top" class="textOverBackgroundCharts" id="WC_AuctionListDisplay_TableCell_9">
							<font class="textOverBackgroundCharts"> 
							<c:choose>
								<c:when test="${status=='C' || status=='F'}">
									<fmt:message key="txtCMBidMsg" bundle="${storeText}" />
								</c:when>
								<c:otherwise>
									<fmt:message key="txtClosingTime" bundle="${storeText}" />
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
							<c:set var="status" value="${anAuctionInfoDataBean.status}" />
							<c:set var="autype" value="${anAuctionInfoDataBean.auctionType}" />
							<c:set var="auenddat" value="${anAuctionInfoDataBean.formattedRealEndTime}" />
							<c:set var="austartdat" value="${anAuctionInfoDataBean.formattedStartTime}" />
							<c:set var="auminbid" value="${anAuctionInfoDataBean.formattedAuctReservePrice}" />
							<c:set var="productId" value="${anAuctionInfoDataBean.entryId}" />
							<c:set var="bestBidId" value="${anAuctionInfoDataBean.bestBidId}" />
							<c:set var="currency" value="${anAuctionInfoDataBean.currency}" />				
							
							<c:if test="${! empty productId }">
								<c:set var="prsdesc" value="${anAuctionInfoDataBean.auctItemName}" />
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
							<tr>
								<td width="10" id="WC_AuctionListDisplay_TableCell_10_<c:out value="${aStatus.count}"/>">&nbsp;</td>
								<!--First Column  -->
								<td width="150" align="left" id="WC_AuctionListDisplay_TableCell_11_<c:out value="${aStatus.count}"/>">
								<font class="text"> 
								<c:choose>
									<c:when test="${status=='C'}">
										<a	href='ProductDisplay?storeId=<c:out value="${storeId}" />&catalogId=<c:out value="${WCParam.catalogId}" />&productId=<c:out value="${productId}" />&langId=<c:out value="${langId}" />&fromAuction=true' id="WC_AuctionListDisplay_Link_1">
										<c:out value="${prsdesc}" /> 
										</a>
									</c:when>
									<c:otherwise>
										<a	href='DisplayAuctionItem?storeId=<c:out value="${storeId}" />&catalogId=<c:out value="${WCParam.catalogId}" />&aucrfn=<c:out value="${aucrfn}" />&productId=<c:out value="${productId}" />&langId=<c:out value="${langId}" />&fromAuction=true' id="WC_AuctionListDisplay_Link_2">
										<c:out value="${prsdesc}" /> 
										</a>
									</c:otherwise>
								</c:choose> 
								<c:if test="${! empty auminbid }"> 
										*
								</c:if>  <br />
								<a	href='DisplayAuctionRules?storeId=<c:out value="${storeId}" />&catalogId=<c:out value="${WCParam.catalogId}" />&aucrfn=<c:out value="${aucrfn}" />' id="WC_AuctionListDisplay_Link_3">
								<fmt:message key="auctionRules" bundle="${storeText}" /> </a>
								</font>
								</td>
								<!--Second Column  -->
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
								<td width="75" align="left" id="WC_AuctionListDisplay_TableCell_12_<c:out value="${aStatus.count}"/>">
								<font class="text"> 
								<c:out value="${auquant}" /> 
								</font>
								</td>
								<!--Third Column  -->
								<td width="125" align="left" id="WC_AuctionListDisplay_TableCell_13_<c:out value="${aStatus.count}"/>">
								<font class="text"> 
								<c:choose>
									<c:when test="${autype=='O'}">
										<fmt:message key="openCry" bundle="${storeText}" />
										<c:if test="${status=='C'}">
											<br />(<font class="price"><c:out value="${bdvalue}" escapeXml="false"/></font>)
											<br />
											<a href='BidListView?storeId=<c:out value="${WCParam.storeId}" />&catalogId=<c:out value="${WCParam.catalogId}" />&aucrfn=<c:out value="${aucrfn}" />' id="WC_AuctionListDisplay_Link_4">
											(<fmt:message key="seeAllBids" bundle="${storeText}" />)
											</a>
										</c:if>
									</c:when>
									<c:when test="${autype=='SB'}">
										<fmt:message key="sealedBid" bundle="${storeText}" />
										<br />
									</c:when>
									<c:when test="${autype=='D'}">
										<fmt:message key="dutchAuction" bundle="${storeText}" />
										<br />
										<c:if test="${status=='C'}">
											<a href='BidListView?storeId=<c:out value="${WCParam.storeId}" />&catalogId=<c:out value="${WCParam.catalogId}" />&aucrfn=<c:out value="${aucrfn}" />' id="WC_AuctionListDisplay_Link_5">
											(<fmt:message key="seeAllBids" bundle="${storeText}" />)
											</a>
										</c:if>
									</c:when>
									<c:otherwise>
										<fmt:message key="unknownType" bundle="${storeText}" />
									</c:otherwise>
								</c:choose> 
								</font>
								</td>


								<!--Forth Column  -->
								<td width="140" align="left" id="WC_AuctionListDisplay_TableCell_14_<c:out value="${aStatus.count}"/>">
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
												<font class="price"><c:out value="${bdvalue}" escapeXml="false"/></font>

											</c:otherwise>
										</c:choose>
									</c:otherwise>
								</c:choose> </font></td>
								<!--Fifth Column  -->
								<td width="140" align="left" id="WC_AuctionListDisplay_TableCell_15_<c:out value="${aStatus.count}"/>">
								<font class="text" > 
								<c:choose>
									<c:when test="${status=='C' || status=='F'}">
										<c:if test="${status=='C' && auquant!='0'}">
											<a	href='BidCreateForm?storeId=<c:out value="${storeId}" />&catalogId=<c:out value="${WCParam.catalogId}" />&aucrfn=<c:out value="${aucrfn}" />' id="WC_AuctionListDisplay_Link_6">
											<fmt:message key="newBid" bundle="${storeText}" />
											 </a>
											<br />
										</c:if>
										<c:if test="${autype=='O'}">
											<a	href='AutoBidCreateForm?storeId=<c:out value="${storeId}" />&catalogId=<c:out value="${WCParam.catalogId}" />&aucrfn=<c:out value="${aucrfn}" />' id="WC_AuctionListDisplay_Link_7">
											<fmt:message key="newAutoBid" bundle="${storeText}" /> </a>
											<br />
										</c:if>
										<c:choose>
											<c:when	test="${status=='C' || (status == 'F' && autype=='O')}">
												<a	href='ShopperBidListView?storeId=<c:out value="${WCParam.storeId}" />&catalogId=<c:out value="${WCParam.catalogId}" />&status=<c:out value="${status}" />&yourBids=true&aucrfn=<c:out value="${aucrfn}" />' id="WC_AuctionListDisplay_Link_8">
												<fmt:message key="yourBids" bundle="${storeText}" /> 
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
					</c:if>
				</tbody>
			</table>
			<c:if test="${noItemOnAuction == false}">
				<table cellpadding="1" cellspacing="2" width="580" border="0" id="WC_AuctionListDisplay_Table_3">
					<tbody>
						<tr>
							<td width="10" id="WC_AuctionListDisplay_TableCell_16">&nbsp;</td>
							<td align="left" valign="top" colspan="5" class="categoryspace"	width="580" id="WC_AuctionListDisplay_TableCell_17">
							<hr width="100%" noshade="noshade" align="left" />
							<font class="strongtext"> 
							<fmt:message key="reservePrice" bundle="${storeText}" /> 
							</font>
							</td>
						</tr>
					</tbody>
				</table>
			</c:if>
			<table cellpadding="3" cellspacing="0" border="0" id="WC_AuctionListDisplay_Table_4">
				<tbody>
					<tr>
						<td width="10" id="WC_AuctionListDisplay_TableCell_18">&nbsp;</td>
						<c:set var="nextStartPt" value="${end}" />
						<c:set var="prevStartPt" value="${start - count}" />
						<c:if test="${prevStartPt >= 0 }">

							<td align="center" valign="middle" class="buttonStyle" id="WC_AuctionListDisplay_TableCell_19">
							<font class="buttonStyle"> 
							<a	href='AuctionListView?storeId=<c:out value="${WCParam.storeId}" />&catalogId=<c:out value="${WCParam.catalogId}" />&status=<c:out value="${status}" />&next=<c:out value="${prevStartPt}" />' id="WC_AuctionListDisplay_Link_9">
								&lt;
								<fmt:message key="txtPrevious" bundle="${storeText}" />
							</a> 
							</font>
							</td>
						</c:if>


						<c:if test="${nextStartPt < length}">
							<td align="center" valign="middle" class="buttonStyle" id="WC_AuctionListDisplay_TableCell_20">
							<font class="buttonStyle"> 
							<a	href='AuctionListView?storeId=<c:out value="${storeId}" />&catalogId=<c:out value="${WCParam.catalogId}" />&status=<c:out value="${status}" />&next=<c:out value="${nextStartPt}" />' id="WC_AuctionListDisplay_Link_10">
								<fmt:message key="txtNext" bundle="${storeText}" />  
								&gt;
							</a>
							</font>
							</td>
						</c:if>


						<c:if test="${noItemOnAuction == true}">
							<td width="100%" align="left" nowrap="nowrap" id="WC_AuctionListDisplay_TableCell_21">
							<font class="productName"> <tt>
							<fmt:message key="noAuctionsMsg" bundle="${storeText}" /></tt> 
							</font>
							</td>							
						</c:if>
					</tr>
				</tbody>
			</table>


			<br />

			</td>
		</tr>
		
	</tbody>
</table>

<%@ include file="../../include/LayoutContainerBottom.jspf"%>
</body>
</html>


