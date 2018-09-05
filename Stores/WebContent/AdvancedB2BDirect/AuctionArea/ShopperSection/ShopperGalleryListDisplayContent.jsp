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


<table cellpadding="0" cellspacing="0" border="0" width="600" id="WC_ShopperGalleryListDisplay_Table_1">
	
	<tr>
		
		<td bgcolor="#FFFFFF" width="600" valign="top" id="WC_ShopperGalleryListDisplay_TableCell_1">
		<wcbase:useBean	id="aRegister" classname="com.ibm.commerce.user.beans.UserRegistrationDataBean" /> 
		
		<c:set var="safname" value="${aRegister.firstName}" />		
		<c:set var="samname" value="${aRegister.middleName}" />		
		<c:set var="salname" value="${aRegister.lastName}" />
		 <%-- ******get a list of current auctions ****** --%> 
		 <wcbase:useBean id="alb1"	classname="com.ibm.commerce.negotiation.beans.AuctionInfoListBean">
			<c:set property="auctShopperId" value="${userId}" target="${alb1}" />
			<c:set property="auctMultipleStatusWithString" value="C" target="${alb1}" />
			<c:set property="sortAttByString" value="ENDTIME;AUTYPE" target="${alb1}" />
		</wcbase:useBean> 
		<c:set var="length1" value="${alb1.auctionsNum}" />
		<c:set var="inStoreFlag1" value="false" /> 
		<c:set var="aucLength1"	value="0" /> 
		<c:forEach var="currentMars" items="${alb1.auctions}"	begin="0" end="${length1}">
			<c:set var="auctStoreId" value="${currentMars.storeId}" />
			<c:if test="${auctStoreId eq storeId}">
				<c:set var="aucLength1" value="${aucLength1+1}" />
			</c:if>
			<c:set var="inStoreFlag1" value="true" />
		</c:forEach> 
		<%-- ******get a list of future auctions ****** --%> 
		<wcbase:useBean	id="alb2" classname="com.ibm.commerce.negotiation.beans.AuctionInfoListBean">
			<c:set property="auctShopperId" value="${userId}" target="${alb2}" />
			<c:set property="auctMultipleStatusWithString" value="F" target="${alb2}" />
			<c:set property="sortAttByString" value="STARTTIME;AUTYPE" target="${alb2}" />
		</wcbase:useBean> 
		<c:set var="length2" value="${alb2.auctionsNum}" />
		<c:set var="inStoreFlag2" value="false" /> 
		<c:set var="aucLength2"	value="0" /> 
		<c:forEach var="futureMars" items="${alb2.auctions}" begin="0" end="${length2}">
			<c:set var="auctStoreId" value="${futureMars.storeId}" />
			<c:if test="${auctStoreId eq storeId}">
				<c:set var="aucLength2" value="${aucLength2+1}" />
			</c:if>
			<c:set var="inStoreFlag2" value="true" />
		</c:forEach> 
		<%-- ******get a list of closed auctions (bid closed or settlement closed)****** --%>
		<wcbase:useBean id="alb3" classname="com.ibm.commerce.negotiation.beans.AuctionInfoListBean">
			<c:set property="auctShopperId" value="${userId}" target="${alb3}" />
			<c:set property="auctMultipleStatusWithString" value="SC;BC" target="${alb3}" />
			<c:set property="sortAttByString" value="AUSTATUS;ENDTIME;AUTYPE" target="${alb3}" />
		</wcbase:useBean> 
		<c:set var="length3" value="${alb3.auctionsNum}" />
		<c:set var="inStoreFlag3" value="false" /> 
		<c:set var="aucLength3"	value="0" /> 
		<c:forEach var="closedMars" items="${alb3.auctions}" begin="0" end="${length3}">
			<c:set var="auctStoreId" value="${closedMars.storeId}" />
			<c:if test="${auctStoreId eq storeId}">
				<c:set var="aucLength3" value="${aucLength3+1}" />
			</c:if>
			<c:set var="inStoreFlag3" value="true" />
		</c:forEach> 
		<c:choose>
			<c:when test="${(aucLength1 + aucLength2 + aucLength3) > 0}">
				<c:set var="noItemInGallery" value="false" />
			</c:when>
			<c:otherwise>
				<c:set var="noItemInGallery" value="true" />
			</c:otherwise>
		</c:choose>


		<table cellpadding="1" cellspacing="2" width="600" border="0" id="WC_ShopperGalleryListDisplay_Table_2">
			<tr>
				<td width="10" id="WC_ShopperGalleryListDisplay_TableCell_2">&nbsp;</td>
				<td align="left" valign="top" colspan="5" class="categoryspace"	width="580" id="WC_ShopperGalleryListDisplay_TableCell_3">
				<font class="pageHeading"> 
				<fmt:message key="galleryFor" bundle="${storeText}">
					<fmt:param value="${safname}" />
					<fmt:param value="${samname}" />
					<fmt:param value="${salname}" />
				</fmt:message> 
				<br />
				</font>

				<hr width="100%" noshade="noshade" align="left" />
				<c:choose>
					<c:when test="${noItemInGallery == 'true'}">
						<font class="productName"> 
						<tt> 
						<fmt:message key="txtMsgGalleryEmpty" bundle="${storeText}" /> 
						</tt> 
						<br />
						</font>
					</c:when>
					<c:otherwise>
						<font class="productName"> 
						<fmt:message key="lastRefreshMsg" bundle="${storeText}">
							<fmt:param value="${alb1.formattedCurrentTime}"/>									
						</fmt:message> <br />
						</font>
					</c:otherwise>
				</c:choose>
				</td>
			</tr>
			<c:if test="${noItemInGallery ne 'true'}">
			<tr>
				<td width="10" id="WC_ShopperGalleryListDisplay_TableCell_4">&nbsp;</td>
				<td id="WC_ShopperGalleryListDisplay_TableCell_5">
				<font class="productName"> 
				<fmt:message key="txtGalleryHeader"	bundle="${storeText}" /> 
				<fmt:message key="txtGalleryDesc"	bundle="${storeText}" /> 
				</font> 
				<br />
				<br />
				<%-- ******This section  is to display a list of current auctions ****** --%>
				<c:if test="${(length1 >0 ) && (inStoreFlag1==true)}">
					<font class="pageHeading"> 
					<fmt:message key="txtCurrentAuctions" bundle="${storeText}" /> 
					</font>
					<table cellpadding="1" cellspacing="2" width="580" border="0" id="WC_ShopperGalleryListDisplay_Table_3">
						<tr>
							<td align="left" valign="top" class="textOverBackgroundCharts" id="WC_ShopperGalleryListDisplay_TableCell_6">
							<font class="textOverBackgroundCharts"> 
							<fmt:message key="txtProductName" bundle="${storeText}" /> 
							<br />
							(<fmt:message key="txtAuctionRules" bundle="${storeText}" />)
							</font>
							</td>
							<td align="left" valign="top" class="textOverBackgroundCharts" id="WC_ShopperGalleryListDisplay_TableCell_7">
							<font class="textOverBackgroundCharts"> 
							<fmt:message key="txtQuantity"	bundle="${storeText}" /> 
							</font>
							</td>
							<td align="left" valign="top" class="textOverBackgroundCharts" id="WC_ShopperGalleryListDisplay_TableCell_8">
							<font class="textOverBackgroundCharts"> 
							<fmt:message key="txtAuctionType" bundle="${storeText}" /> 
							<br />
							(<fmt:message key="txtBestBid" bundle="${storeText}" />) 
							<br />
							(<fmt:message key="txtSeeAllBids" bundle="${storeText}" />)

							</font>
							</td>
							<td align="left" valign="top" class="textOverBackgroundCharts" id="WC_ShopperGalleryListDisplay_TableCell_9">
							<font class="strongtext"> 
							<fmt:message key="txtColBidSubmissionDeadline" bundle="${storeText}" />
							</font>
							</td>
							<td align="left" valign="top" class="textOverBackgroundCharts" id="WC_ShopperGalleryListDisplay_TableCell_10">
							<font class="textOverBackgroundCharts"> 
							<fmt:message key="txtCMBidMsg"	bundle="${storeText}" /> 
							</font>
							</td>
							<td align="left" valign="top" class="textOverBackgroundCharts" id="WC_ShopperGalleryListDisplay_TableCell_11">
							<!-- Remove -->
							</td>
						</tr>

						<c:forEach var="anAuction" items="${alb1.auctions}" begin="0" end="${length1}" varStatus="aStatus">
							<c:set var="aucrfn" value="${anAuction.id}" />
							<c:set var="austatus" value="${anAuction.status}" />
							<c:set var="autype" value="${anAuction.auctionType}" />
							<c:set var="austdate" value="${anAuction.formattedStartTime}" />
							<c:set var="auenddat" value="${anAuction.formattedRealEndTime}" />
							<c:set var="auminbid" value="${anAuction.formattedAuctReservePrice}" />
							<c:set var="bestBidId" value="${anAuction.bestBidId}" />
							<c:set var="productId" value="${anAuction.entryId}" />
							<c:set var="currency" value="${anAuction.currency}" />
							<c:set var="auctStoreId" value="${anAuction.storeId}" />
							<c:set var="prsdesc" value="${anAuction.auctItemDesc}" />
							<c:choose>
								<c:when test="${! empty bestBidId }">
									<c:set var="bdvalue" value="${anAuction.formattedBestBidVal}" />
								</c:when>
								<c:otherwise>
									<c:set var="bdvalue" value="0" />
								</c:otherwise>
							</c:choose>
							<c:if test="${auctStoreId eq storeId}">

								<tr>
									<td width="130" align="left" id="WC_ShopperGalleryListDisplay_TableCell_12">
									<font class="text"> 
									<a	href='ProductDisplay?storeId=<c:out value="${storeId}" />&catalogId=<c:out value="${catalogId}" />&productId=<c:out value="${productId}" />&langId=<c:out value="${langId}" />&fromAuction=true' id="WC_ShopperGalleryListDisplay_Link_1_<c:out value="${aStatus.count}"/>" id="WC_ShopperGalleryListDisplay_Link_2_<c:out value="${aStatus.count}"/>">
									<c:choose>
										<c:when	test="${! empty auminbid }">
											<c:out value="${prsdesc}" />*
										</c:when>
										<c:otherwise>
											<c:out value="${prsdesc}" />
										</c:otherwise>
									</c:choose> 
									</a> 
									<br />
									<a href='DisplayAuctionRules?storeId=<c:out value="${storeId}" />&catalogId=<c:out value="${catalogId}" />&aucrfn=<c:out value="${aucrfn}" /> ' id="WC_ShopperGalleryListDisplay_Link_3_<c:out value="${aStatus.count}"/>">
									<fmt:message key="auctionRules" bundle="${storeText}" /> 
									</a>
									</font>
									</td>
									<td width="65" align="left"><font class="text" id="WC_ShopperGalleryListDisplay_TableCell_13"> 
									<c:choose>
										<c:when test="${autype == 'O' || autype == 'SB'}">
											<c:set var="auquant" value="${anAuction.formattedQuantity}" />
										</c:when>
										<c:otherwise>
											<c:set var="auquant" value="${anAuction.formattedCurrentQuantity}" />
										</c:otherwise>
									</c:choose> 
									</font>
									</td>
									<td width="100" align="left" id="WC_ShopperGalleryListDisplay_TableCell_14">
									<font class="text"> 
									<c:choose>
										<c:when test="${autype=='O'}">
											<fmt:message key="txtOpenCry" bundle="${storeText}" />
											<br />
											(<font class="price"><c:out value="${bdvalue}" /></font>)
											<br />
											<a href='BidListView?storeId=<c:out value="${storeId}" />&catalogId=<c:out value="${catalogId}" />&aucrfn=<c:out value="${aucrfn}" />' id="WC_ShopperGalleryListDisplay_Link_4_<c:out value="${aStatus.count}"/>"> 
											(<fmt:message key="txtSeeAllBids" bundle="${storeText}" />) 
											</a>
										</c:when>
										<c:when test="${autype == 'SB'}">
											<fmt:message key="txtSealedBid" bundle="${storeText}" />
											<br />
										</c:when>
										<c:otherwise>
											<fmt:message key="txtDutchAuction" bundle="${storeText}" />
											<br />
											<br />
											<a href='BidListView?storeId=<c:out value="${storeId}" />&catalogId=<c:out value="${catalogId}" />&aucrfn=<c:out value="${aucrfn}" />' id="WC_ShopperGalleryListDisplay_Link_5_<c:out value="${aStatus.count}"/>"> 
											(<fmt:message key="txtSeeAllBids" bundle="${storeText}" />) 
											</a>
										</c:otherwise>
									</c:choose> 
									</font>
									</td>
									<td width="210" align="left" id="WC_ShopperGalleryListDisplay_TableCell_15">
									<font class="text"> 
									<c:out value="${auenddat}" />
									<br />
									</font>
									</td>
									<td width="100" align="left" id="WC_ShopperGalleryListDisplay_TableCell_16">
									<font class="text"> 
									<c:choose>
										<c:when test="${austatus=='C' && autype=='O'}">
											<a	href='BidCreateForm?storeId=<c:out value="${storeId}" />&catalogId=<c:out value="${catalogId}" />&aucrfn=<c:out value="${aucrfn}" />' id="WC_ShopperGalleryListDisplay_Link_6_<c:out value="${aStatus.count}"/>">
											<fmt:message key="txtNewBid" bundle="${storeText}" /> 
											</a>
											<br />
											<a	href='AutoBidCreateForm?storeId=<c:out value="${storeId}" />&catalogId=<c:out value="${catalogId}" />&aucrfn=<c:out value="${aucrfn}" />' id="WC_ShopperGalleryListDisplay_Link_7_<c:out value="${aStatus.count}"/>">
											<fmt:message key="newAutoBid" bundle="${storeText}" /> 
											</a>
										</c:when>
										<c:otherwise>
											<a	href='BidCreateForm?storeId=<c:out value="${storeId}" />&catalogId=<c:out value="${catalogId}" />&aucrfn=<c:out value="${aucrfn}" />' id="WC_ShopperGalleryListDisplay_Link_8_<c:out value="${aStatus.count}"/>">
											<fmt:message key="txtNewBid" bundle="${storeText}" /> 
											</a>
										</c:otherwise>
									</c:choose> 
									<br />
									<a	href='ShopperBidListView?storeId=<c:out value="${storeId}" />&catalogId=<c:out value="${catalogId}" />&status=C&yourBids=true&aucrfn=<c:out value="${aucrfn}" />' id="WC_ShopperGalleryListDisplay_Link_9_<c:out value="${aStatus.count}"/>">
									<fmt:message key="txtYourBids" bundle="${storeText}" /> 
									</a>

									</font>
									</td>

									<td width="65" align="left" id="WC_ShopperGalleryListDisplay_TableCell_17">
									<font class="text"> 
									<a	href='GalleryDelete?storeId=<c:out value="${storeId}" />&catalogId=<c:out value="${catalogId}" />&aucrfn=<c:out value="${aucrfn}" />&URL=ShopperAuctionListView' id="WC_ShopperGalleryListDisplay_Link_10_<c:out value="${aStatus.count}"/>">
									<fmt:message key="txtRemove" bundle="${storeText}" /> 
									</a>
									</font>
									</td>

								</tr>
							</c:if>
						</c:forEach>
					</table>

				</c:if> 
				<%--This section  is to display a list of closed auctions --%>
				<c:if test="${length3 >0 && inStoreFlag3==true}">
					<br />
					<font class="pageHeading"> 
					<fmt:message key="txtRecentlyClosedAuctions" bundle="${storeText}" /> 
					</font>


					<table cellpadding="1" cellspacing="2" width="580" border="0" id="WC_ShopperGalleryListDisplay_Table_4">
						<tr>
							<td align="left" valign="top" class="textOverBackgroundCharts" id="WC_ShopperGalleryListDisplay_TableCell_18">
							<font class="textOverBackgroundCharts"> 
							<fmt:message key="txtProductName" bundle="${storeText}" /> <br />
							(<fmt:message key="txtAuctionRules" bundle="${storeText}" />)
							</font>
							</td>
							<td align="left" valign="top" class="textOverBackgroundCharts" id="WC_ShopperGalleryListDisplay_TableCell_19">
							<font class="textOverBackgroundCharts"> 
							<fmt:message key="txtQuantity"	bundle="${storeText}" /> 
							</font>
							</td>
							<td align="left" valign="top" class="textOverBackgroundCharts" id="WC_ShopperGalleryListDisplay_TableCell_20">
							<font class="textOverBackgroundCharts"> 
							<fmt:message key="txtAuctionType" bundle="${storeText}" /> 
							<br />
							(<fmt:message key="txtSeeAllBids" bundle="${storeText}" />)
							</font>
							</td>
							<td align="left" valign="top" class="textOverBackgroundCharts" id="WC_ShopperGalleryListDisplay_TableCell_21">
							<font	class="textOverBackgroundCharts"> 
							<fmt:message key="txtLowestWinningBid" bundle="${storeText}" /> 
							</font>
							</td>
							<td align="left" valign="top" class="textOverBackgroundCharts" id="WC_ShopperGalleryListDisplay_TableCell_22">
							<font class="textOverBackgroundCharts"> 
							<fmt:message key="txtClosingTime" bundle="${storeText}" /> 
							</font>
							</td>
							<td align="left" valign="top" class="textOverBackgroundCharts" id="WC_ShopperGalleryListDisplay_TableCell_23">
							<!-- Remove -->
							</td>
						</tr>

						<c:forEach var="anAuction" items="${alb3.auctions}" begin="0" end="${length3}" varStatus="aStatus">
							<c:set var="aucrfn" value="${anAuction.id}" />
							<c:set var="austatus" value="${anAuction.status}" />
							<c:set var="autype" value="${anAuction.auctionType}" />
							<c:set var="austdate" value="${anAuction.formattedStartTime}" />
							<c:set var="auenddat" value="${anAuction.formattedRealEndTime}" />
							<c:set var="auminbid" value="${anAuction.formattedAuctReservePrice}" />
							<c:set var="bestBidId" value="${anAuction.bestBidId}" />
							<c:set var="productId" value="${anAuction.entryId}" />
							<c:set var="currency" value="${anAuction.currency}" />
							<c:set var="auctStoreId" value="${anAuction.storeId}" />
							<c:set var="prsdesc" value="${anAuction.auctItemDesc}" />
							<c:choose>
								<c:when test="${! empty bestBidId }">
									<c:set var="bdvalue" value="${anAuction.formattedBestBidVal}" />
								</c:when>
								<c:otherwise>
									<c:set var="bdvalue" value="0" />
								</c:otherwise>
							</c:choose>							
							<c:if test="${auctStoreId eq storeId}">

								<tr>
									<td width="120" align="left" id="WC_ShopperGalleryListDisplay_TableCell_24">
									<font class="text"> 
									<a	href='DisplayAuctionItem?storeId=<c:out value="${storeId}" />&catalogId=<c:out value="${catalogId}" />&aucrfn=<c:out value="${aucrfn}" />&productId=<c:out value="${productId}" />&langId=<c:out value="${langId}" />&fromAuction=true' id="WC_ShopperGalleryListDisplay_Link_11_<c:out value="${aStatus.count}"/>">
									<c:choose>
										<c:when	test="${!empty auminbid}">
											<c:out value="${prsdesc}" />*
										</c:when>
										<c:otherwise>
											<c:out value="${prsdesc}" />
										</c:otherwise>
									</c:choose> 
									</a> 
									<br />
									<a	href='DisplayAuctionRules?storeId=<c:out value="${storeId}" />&catalogId=<c:out value="${catalogId}" />&aucrfn=<c:out value="${aucrfn}" />' id="WC_ShopperGalleryListDisplay_Link_12_<c:out value="${aStatus.count}"/>">
									<fmt:message key="auctionRules" bundle="${storeText}" /> 
									</a>

									</font>
									</td>
									<td width="65" align="left" id="WC_ShopperGalleryListDisplay_TableCell_25">
									<font class="text"> 
									<c:out	value="${anAuction.formattedQuantity}" /> 
									</font>
									</td>
									<td width="110" align="left" id="WC_ShopperGalleryListDisplay_TableCell_26">
									<font class="text"> 
									<c:choose>
										<c:when test="${autype=='O'}">
											<fmt:message key="txtOpenCry" bundle="${storeText}" />
											<br />
											<a href='BidListView?storeId=<c:out value="${storeId}" />&catalogId=<c:out value="${catalogId}" />&aucrfn=<c:out value="${aucrfn}" />' id="WC_ShopperGalleryListDisplay_Link_13_<c:out value="${aStatus.count}"/>"> 
											(<fmt:message key="txtSeeAllBids" bundle="${storeText}" />) 
											</a>
										</c:when>
										<c:when test="${autype=='SB'}">
											<fmt:message key="txtSealedBid" bundle="${storeText}" />
											<br />
										</c:when>
										<c:otherwise>
											<fmt:message key="txtDutchAuction" bundle="${storeText}" />
											<br />
											<a href='BidListView?storeId=<c:out value="${storeId}" />&catalogId=<c:out value="${catalogId}" />&aucrfn=<c:out value="${aucrfn}" />' id="WC_ShopperGalleryListDisplay_Link_14_<c:out value="${aStatus.count}"/>"> 
											(<fmt:message key="txtSeeAllBids" bundle="${storeText}" />) 
											</a>
										</c:otherwise>
									</c:choose> 
									</font>
									</td>
									<td width="100" align="left" id="WC_ShopperGalleryListDisplay_TableCell_27">
									<font class="text"> 
									<c:choose>
										<c:when test="${empty bdvalue || autype=='D'}">
											---
										</c:when>
										<c:otherwise>
											<font class="price">
											<c:out value="${bdvalue}" /> 
											</font>
										</c:otherwise>
									</c:choose> 
									</font>
									</td>
									<td width="210" align="left" id="WC_ShopperGalleryListDisplay_TableCell_28">
									<font class="text"> 
									<c:out	value="${auenddat}" />
									<br />
									</font>
									</td>
									<td width="65" align="left" id="WC_ShopperGalleryListDisplay_TableCell_29">
									<font class="text"> 
									<a	href='GalleryDelete?storeId=<c:out value="${storeId}" />&catalogId=<c:out value="${catalogId}" />&aucrfn=<c:out value="${aucrfn}" />&URL=ShopperAuctionListView' id="WC_ShopperGalleryListDisplay_Link_15_<c:out value="${aStatus.count}"/>">
									<fmt:message key="txtRemove" bundle="${storeText}" /><br />
									</a> 
									</font>
									</td>

								</tr>
							</c:if>
						</c:forEach>
					</table>

				</c:if> <%--This section  is to display a list of future auctions --%>
				<c:if test="${length2 >0 && inStoreFlag2 == true}">
					<br />
					<font class="pageHeading"> 
					<fmt:message key="txtFutureAuctions" bundle="${storeText}" /> 
					</font>
					<table cellpadding="1" cellspacing="2" width="580" border="0" id="WC_ShopperGalleryListDisplay_Table_5">
						<tr>
							<td align="left" valign="top" class="textOverBackgroundCharts" id="WC_ShopperGalleryListDisplay_TableCell_30">
							<font	class="textOverBackgroundCharts"> 
								<fmt:message key="txtProductName" bundle="${storeText}" /> 
								<br />
								(<fmt:message key="txtAuctionRules" bundle="${storeText}" />)
							</font>
							</td>
							<td align="left" valign="top" class="textOverBackgroundCharts" id="WC_ShopperGalleryListDisplay_TableCell_31">
							<font	class="textOverBackgroundCharts"> 
							<fmt:message key="txtQuantity"	bundle="${storeText}" /> 
							</font>
							</td>
							<td align="left" valign="top" class="textOverBackgroundCharts" id="WC_ShopperGalleryListDisplay_TableCell_32">
							<font class="textOverBackgroundCharts"> 
							<fmt:message key="txtAuctionType" bundle="${storeText}" /> 
							</font>
							</td>
							<td align="left" valign="top" class="textOverBackgroundCharts" id="WC_ShopperGalleryListDisplay_TableCell_33">
							<font class="strongtext"> 
							<fmt:message key="txtAuctionStarts"	bundle="${storeText}" /> 
							</font>
							</td>
							<td align="left" valign="top" class="textOverBackgroundCharts" id="WC_ShopperGalleryListDisplay_TableCell_34">
							<!-- Remove -->
							</td>
						</tr>

						<c:forEach var="anAuction" items="${alb2.auctions}" begin="0" end="${length2}" varStatus="aStatus">
							<c:set var="aucrfn" value="${anAuction.id}" />
							<c:set var="austatus" value="${anAuction.status}" />
							<c:set var="autype" value="${anAuction.auctionType}" />
							<c:set var="austdate" value="${anAuction.formattedStartTime}" />
							<c:set var="auminbid"	value="${anAuction.formattedAuctReservePrice}" />
							<c:set var="productId" value="${anAuction.entryId}" />
							<c:set var="auctStoreId" value="${anAuction.storeId}" />
							<c:set var="prsdesc" value="${anAuction.auctItemDesc}" />

							<c:if test="${auctStoreId eq storeId}">

								<tr>
									<td width="130" align="left" id="WC_ShopperGalleryListDisplay_TableCell_35">
									<font class="text"> 
									<a	href='DisplayAuctionItem?storeId=<c:out value="${storeId}" />&catalogId=<c:out value="${catalogId}" />&aucrfn=<c:out value="${aucrfn}" />&productId=<c:out value="${productId}" />&langId=<c:out value="${langId}" />&fromAuction=true' id="WC_ShopperGalleryListDisplay_Link_16_<c:out value="${aStatus.count}"/>">
									<c:choose>
										<c:when	test="${! empty auminbid }">
											<c:out value="${prsdesc}" />*
										</c:when>
										<c:otherwise>
											<c:out value="${prsdesc}" />
										</c:otherwise>
									</c:choose>
									</a> 
									<br />
									<a href='DisplayAuctionRules?storeId=<c:out value="${storeId}" />&catalogId=<c:out value="${catalogId}" />&aucrfn=<c:out value="${aucrfn}" />' id="WC_ShopperGalleryListDisplay_Link_17_<c:out value="${aStatus.count}"/>">
									<fmt:message key="txtAuctionRules" bundle="${storeText}" />
									</a> 
									</font>
									</td>
									<td width="65" align="left" id="WC_ShopperGalleryListDisplay_TableCell_36">
									<font class="text"> 
									<c:out	value="${anAuction.formattedQuantity}" /> 
									</font>
									</td>
									<td width="185" align="left" id="WC_ShopperGalleryListDisplay_TableCell_37">
									<font class="text"> 
									<c:choose>
										<c:when test="${autype=='O'}">
											<fmt:message key="txtOpenCry" bundle="${storeText}" />
											<br />
										</c:when>
										<c:when test="${autype=='SB'}">
											<fmt:message key="txtSealedBid" bundle="${storeText}" />
											<br />
										</c:when>
										<c:otherwise>
											<fmt:message key="txtDutchAuction" bundle="${storeText}" />
											<br />
										</c:otherwise>
									</c:choose> 
									</font>
									</td>
									<td width="210" align="left" id="WC_ShopperGalleryListDisplay_TableCell_38">
									<font class="text"> 
									<c:out	value="${austdate}" />
									<br />
									</font>
									</td>
									<td width="65" align="left" id="WC_ShopperGalleryListDisplay_TableCell_39">
									<font class="text"> 
									<a	href='GalleryDelete?storeId=<c:out value="${storeId}" />&catalogId=<c:out value="${catalogId}" />&aucrfn=<c:out value="${aucrfn}" />&URL=ShopperAuctionListView' id="WC_ShopperGalleryListDisplay_Link_18_<c:out value="${aStatus.count}"/>">
									<fmt:message key="txtRemove" bundle="${storeText}" /><br />
									</a> 
									</font>
									</td>
								</tr>
							</c:if>
						</c:forEach>
					</table>

				</c:if> 
				<br />

				</td>
			</tr>			 
			</c:if>
		</table>


		</td>
	</tr>
	
</table>

