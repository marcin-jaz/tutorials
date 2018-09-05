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

<table id="WC_ShopperGalleryListDisplay_Table_1" border="0" cellpadding="0" cellspacing="0" width="790" >
<tr>	

	<td id="WC_ShopperGalleryListDisplay_TableCell_2" valign="top" width="630">

	<wcbase:useBean id="aRegister" classname="com.ibm.commerce.user.beans.UserRegistrationDataBean" >
	</wcbase:useBean>
	<c:set var="safname" value="" />
	<c:set var="samname" value="" />
	<c:set var="salname" value="" />
	<c:if test="${! empty aRegister.firstName}">
		<c:set var="safname" value="${aRegister.firstName}" />
	</c:if>
	<c:if test="${! empty aRegister.middleName }">
		<c:set var="samname" value="${aRegister.middleName}" />
	</c:if>
	<c:if test="${! empty aRegister.lastName}">
		<c:set var="salname" value="${aRegister.lastName}" />
	</c:if>

    <%-- ******get a list of current auctions ****** --%>      
	<wcbase:useBean id="alb1" classname="com.ibm.commerce.negotiation.beans.AuctionInfoListBean" >
		<c:set property="auctShopperId" value="${userId}" target="${alb1}" />
		<c:set property="auctMultipleStatusWithString" value="C" target="${alb1}" />
		<c:set property="sortAttByString" value="ENDTIME;AUTYPE" target="${alb1}" />
	</wcbase:useBean>
	<c:set var="length1" value="${alb1.auctionsNum}" />     
	<c:set var="inStoreFlag1" value="false" />
	<c:set var="aucLength1" value="0" />	
	<c:forEach var="currentMars" items="${alb1.auctions}" begin="0" end="${length1}">
		<c:set var="auctStoreId" value="${currentMars.storeId}" />	
		<c:set var="aucLength1" value="${aucLength1+1}" />	
		<c:set var="inStoreFlag1" value="true" />
	</c:forEach>
      
    <%-- ******get a list of future auctions ****** --%>
	<wcbase:useBean id="alb2" classname="com.ibm.commerce.negotiation.beans.AuctionInfoListBean" >
		<c:set property="auctShopperId" value="${userId}" target="${alb2}" />
		<c:set property="auctMultipleStatusWithString" value="F" target="${alb2}" />
		<c:set property="sortAttByString" value="STARTTIME;AUTYPE" target="${alb2}" />
	</wcbase:useBean>
	<c:set var="length2" value="${alb2.auctionsNum}" />     
	<c:set var="inStoreFlag2" value="false" />
	<c:set var="aucLength2" value="0" />	
	<c:forEach var="futureMars" items="${alb2.auctions}" begin="0" end="${length2}">
		<c:set var="auctStoreId" value="${futureMars.storeId}" />	
		<c:set var="aucLength2" value="${aucLength2+1}" />	
		<c:set var="inStoreFlag2" value="true" />
	</c:forEach>

     <%-- ******get a list of closed auctions (bid closed or settlement closed)****** --%>
	<wcbase:useBean id="alb3" classname="com.ibm.commerce.negotiation.beans.AuctionInfoListBean" >
		<c:set property="auctShopperId" value="${userId}" target="${alb3}" />
		<c:set property="auctMultipleStatusWithString" value="SC;BC" target="${alb3}" />
		<c:set property="sortAttByString" value="AUSTATUS;ENDTIME;AUTYPE" target="${alb3}" />
	</wcbase:useBean>
	<c:set var="length3" value="${alb3.auctionsNum}" />     
	<c:set var="inStoreFlag3" value="false" />
	<c:set var="aucLength3" value="0" />	
	<c:forEach var="closedMars" items="${alb3.auctions}" begin="0" end="${length3}">
		<c:set var="auctStoreId" value="${closedMars.storeId}" />	
		<c:set var="aucLength3" value="${aucLength3+1}" />	
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
	<table id="WC_ShopperGalleryListDisplay_Table_2" cellpadding="0" cellspacing="8" border="0">
		<tr>
			<td id="WC_ShopperGalleryListDisplay_TableCell_3" align="left" valign="top" colspan="5" class="categoryspace" width="100%">
				<h1>
					<fmt:message key="ShopperGallery_For" bundle="${storeText}">
						<fmt:param value="${safname}" />
						<fmt:param value="${samname}" />
						<fmt:param value="${salname}" />
					</fmt:message>
					<br />
				</h1>
				<hr width="100%" noshade="noshade" align="left" /> 
				<c:choose>
					<c:when test="${noItemInGallery == true}">
						<font class="productName">
							<tt>
								<fmt:message key="AuctionCommonText_MsgGalleryEmpty" bundle="${storeText}" />
							</tt>
							<br />
						</font>
					</c:when>
					<c:otherwise>
						<font class="productName">
							<fmt:message key="AuctionList_lastRefreshMsg" bundle="${storeText}">
								<fmt:param value="${alb1.formattedCurrentTime}"/>									
							</fmt:message>
							<br />
						</font>
					</c:otherwise>
				</c:choose>	
			</td>
		</tr>
		<c:if test="${noItemInGallery ne 'true'}">	
		<tr>
			<td id="WC_ShopperGalleryListDisplay_TableCell_4" >
				<font class="productName">
					<fmt:message key="ShopperGallery_Header" bundle="${storeText}" />
				</font>
				<br />
				<br />

				<%-- ******This section  is to display a list of current auctions ****** --%>
				<c:if test="${(length1 >0 ) && (inStoreFlag1==true)}">
					<h1>
						<fmt:message key="AuctionCommonText_CurrentAuctions" bundle="${storeText}" />
					</h1> 
					<table id="WC_ShopperGalleryListDisplay_Table_3" cellpadding="0" cellspacing="1" width="100%" border="0" bgcolor="#4C6178">
						<tr bgcolor="#4C6178">
							<td id="WC_ShopperGalleryListDisplay_TableCell_5" align="left" valign="top" class="textOverBackgroundCharts">
								<font style="font-family : Verdana;" color="#FFFFFF">
									<strong>
										<fmt:message key="AuctionCommonText_ProductName" bundle="${storeText}" />
									</strong>
									<br />(<fmt:message key="AuctionCommonText_AuctionRules" bundle="${storeText}" />)
								</font>
							</td>
							<td id="WC_ShopperGalleryListDisplay_TableCell_6" align="left" valign="top" class="textOverBackgroundCharts">
								<font style="font-family : Verdana;" color="#FFFFFF">
									<strong>
										<fmt:message key="AuctionCommonText_Quantity" bundle="${storeText}" />
									</strong>
								</font>
							</td>			
							<td id="WC_ShopperGalleryListDisplay_TableCell_7" align="left" valign="top" class="textOverBackgroundCharts">
								<font style="font-family : Verdana;" color="#FFFFFF">
									<strong>
										<fmt:message key="AuctionCommonText_AuctionType" bundle="${storeText}" />
									</strong>
									<br />(<fmt:message key="AuctionCommonText_BestBid" bundle="${storeText}" />)
									<br />(<fmt:message key="AuctionCommonText_SeeAllBids" bundle="${storeText}" />)
								</font>
							</td>
							<td id="WC_ShopperGalleryListDisplay_TableCell_8" align="left" valign="top" class="textOverBackgroundCharts">
								<font style="font-family : Verdana;" color="#FFFFFF">
									<strong>
										<fmt:message key="AuctionCommonText_ColBidSubmissionDeadline" bundle="${storeText}" />
									</strong>
								</font>
							</td>
							<td id="WC_ShopperGalleryListDisplay_TableCell_9" align="left" valign="top" class="textOverBackgroundCharts">
								<font style="font-family : Verdana;" color="#FFFFFF">
									<strong>
										<fmt:message key="AuctionCommonText_CMBidMsg" bundle="${storeText}" />
									</strong>
								</font>
							</td>
							<td id="WC_ShopperGalleryListDisplay_TableCell_10" align="left" valign="top" class="textOverBackgroundCharts">
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
							<c:set var="bestbidid" value="${anAuction.bestBidId}" />
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
							<c:choose>
								<c:when test="${aStatus.count%2 == 0}">
									<c:set var="color" value="#ffffff" />
								</c:when>
								<c:otherwise>
									<c:set var="color" value="#bccbdb" />
								</c:otherwise>
							</c:choose>
							<tr bgcolor="<c:out value="${color}" />">
								<td id="WC_ShopperGalleryListDisplay_TableCell_11_<c:out value="${aStatus.count}"/>" width="130" align="left">
									<font class="text">
										<a href="ProductDisplay?storeId=<c:out value="${storeId}" />&productId=<c:out value="${productId}" />&langId=<c:out value="${langId}" />&fromAuction=true" id="WC_ShopperGarllery_Link_1_<c:out value="${aStatus.count}"/>">
											<c:choose>
												<c:when test="${! empty auminbid }">
													<c:out value="${prsdesc}" />*
												</c:when>
												<c:otherwise>
													<c:out value="${prsdesc}" />
												</c:otherwise>
											</c:choose>	
										</a> 
									<br />  
									<a href="DisplayAuctionRules?auctionStoreId=<c:out value="${auctStoreId}" />&aucrfn=<c:out value="${aucrfn}" /> " id="WC_ShopperGarllery_Link_2_<c:out value="${aStatus.count}"/>">
										<fmt:message key="AuctionCommonText_AuctionRules" bundle="${storeText}" />
									</a>     
									</font>
								</td>
								<td id="WC_ShopperGalleryListDisplay_TableCell_12_<c:out value="${aStatus.count}"/>" width="65" align="left">
									<font class="text">
										<c:choose>
											<c:when test="${autype == 'O' || autype == 'SB'}">
												<c:set var="auquant" value="${anAuction.formattedQuantity}" />
												<c:out value="${auquant}"/>
											</c:when>
											<c:otherwise>
												<c:set var="auquant" value="${anAuction.formattedCurrentQuantity}" />
												<c:out value="${auquant}"/>
											</c:otherwise>
										</c:choose>	
									</font>
								</td>
								<td id="WC_ShopperGalleryListDisplay_TableCell_13_<c:out value="${aStatus.count}"/>" width="100" align="left">
									<font class="text">
										<c:choose>
											<c:when test="${autype=='O'}">
												<fmt:message key="AuctionCommonText_OpenCry" bundle="${storeText}" /><br />
												(<font class="price"><c:out value="${bdvalue}" /></font>)
												<br />
												<a href="BidListView?auctionStoreId=<c:out value="${auctStoreId}" />&aucrfn=<c:out value="${aucrfn}" />" id="WC_ShopperGarllery_Link_3_<c:out value="${aStatus.count}"/>">
													(<fmt:message key="AuctionCommonText_SeeAllBids" bundle="${storeText}" />)
												</a> 
											</c:when>
											<c:when test="${autype == 'SB'}">
												<fmt:message key="AuctionCommonText_SealedBid" bundle="${storeText}" /><br />
											</c:when>
											<c:otherwise>
												<fmt:message key="AuctionCommonText_DutchAuction" bundle="${storeText}" /><br />
												<br />
												<a href="BidListView?auctionStoreId=<c:out value="${auctStoreId}" />&aucrfn=<c:out value="${aucrfn}" />" id="WC_ShopperGarllery_Link_4_<c:out value="${aStatus.count}"/>">
													(<fmt:message key="AuctionCommonText_SeeAllBids" bundle="${storeText}" />)
												</a>            
											</c:otherwise>
										</c:choose>
									</font>
								</td>
								<td id="WC_ShopperGalleryListDisplay_TableCell_14_<c:out value="${aStatus.count}"/>" width="210" align="left">
									<font class="text">
										<c:out value="${auenddat}" /><br />
									</font>
								</td>
								<td id="WC_ShopperGalleryListDisplay_TableCell_15_<c:out value="${aStatus.count}"/>" width="100" align="left">
									<font class="text">
										<c:choose>
											<c:when test="${austatus=='C' && autype=='O'}">
												<a href="BidCreateForm?auctionStoreId=<c:out value="${auctStoreId}" />&aucrfn=<c:out value="${aucrfn}" />" id="WC_ShopperGarllery_Link_5_<c:out value="${aStatus.count}"/>">
													<fmt:message key="AuctionCommonText_NewBid" bundle="${storeText}" />
												</a>
												<br /> 
												<a href="AutoBidCreateForm?auctionStoreId=<c:out value="${auctStoreId}" />&aucrfn=<c:out value="${aucrfn}" />" id="WC_ShopperGarllery_Link_6_<c:out value="${aStatus.count}"/>">
													<fmt:message key="AuctionCommonText_NewAutoBid" bundle="${storeText}" />
												</a>
											</c:when>
											<c:otherwise>
												<a href="BidCreateForm?auctionStoreId=<c:out value="${auctStoreId}" />&aucrfn=<c:out value="${aucrfn}" />" id="WC_ShopperGarllery_Link_7_<c:out value="${aStatus.count}"/>">
													<fmt:message key="AuctionCommonText_NewBid" bundle="${storeText}" />
												</a>
											</c:otherwise>
										</c:choose>
										<br /> 
										<a href="ShopperBidListView?status=C&yourBids=true&aucrfn=<c:out value="${aucrfn}" />" id="WC_ShopperGarllery_Link_8_<c:out value="${aStatus.count}"/>">
											<fmt:message key="AuctionCommonText_YourBids" bundle="${storeText}" />
										</a>
									</font>
								</td>
								<td id="WC_ShopperGalleryListDisplay_TableCell_16_<c:out value="${aStatus.count}"/>" width="65" align="left">
									<font class="text">
										<a href="GalleryDelete?aucrfn=<c:out value="${aucrfn}" />&storeId=<c:out value="${storeId}" />&URL=ShopperAuctionListView" id="WC_ShopperGarllery_Link_9_<c:out value="${aStatus.count}"/>">
											<fmt:message key="AuctionCommonText_Remove" bundle="${storeText}" />
										</a> 
									</font>
								</td>
							</tr>
						</c:forEach>
					</table>
				</c:if>
				<%--This section  is to display a list of closed auctions --%>
				<c:if test="${length3 >0 && inStoreFlag3==true}">
					<br />
					<h1>
						<fmt:message key="AuctionCommonText_RecentlyClosedAuctions" bundle="${storeText}" />
					</h1>
					<table id="WC_ShopperGalleryListDisplay_Table_4" cellpadding="0" cellspacing="1" width="100%" border="0" bgcolor="#4C6178">
						<tr bgcolor="#4C6178">
							<td id="WC_ShopperGalleryListDisplay_TableCell_17" align="left" valign="top" class="textOverBackgroundCharts">
								<font style="font-family : Verdana;" color="#FFFFFF">
								<strong>
									<fmt:message key="AuctionCommonText_ProductName" bundle="${storeText}" />
								</strong>
								<br />(<fmt:message key="AuctionCommonText_AuctionRules" bundle="${storeText}" />) 
								</font>
							</td>
							<td id="WC_ShopperGalleryListDisplay_TableCell_18" align="left" valign="top" class="textOverBackgroundCharts">
								<font style="font-family : Verdana;" color="#FFFFFF">
								<strong>
									<fmt:message key="AuctionCommonText_Quantity" bundle="${storeText}" />
								</strong>
								</font>
							</td>
							<td id="WC_ShopperGalleryListDisplay_TableCell_19" align="left" valign="top" class="textOverBackgroundCharts">
								<font style="font-family : Verdana;" color="#FFFFFF">
								<strong>
									<fmt:message key="AuctionCommonText_AuctionType" bundle="${storeText}" />
								</strong>
								<br />(<fmt:message key="AuctionCommonText_SeeAllBids" bundle="${storeText}" />) 
								</font>
							</td>               
							<td id="WC_ShopperGalleryListDisplay_TableCell_20" align="left" valign="top" class="textOverBackgroundCharts">
								<font style="font-family : Verdana;" color="#FFFFFF">
								<strong>
									<fmt:message key="AuctionCommonText_LowestWinningBid" bundle="${storeText}" />
								</strong>
								</font>
							</td>
							<td id="WC_ShopperGalleryListDisplay_TableCell_21" align="left" valign="top" class="textOverBackgroundCharts">
								<font style="font-family : Verdana;" color="#FFFFFF">
								<strong>
									<fmt:message key="AuctionCommonText_ClosingTime" bundle="${storeText}" />
								</strong>
								</font>
							</td>
							<td id="WC_ShopperGalleryListDisplay_TableCell_22" align="left" valign="top" class="textOverBackgroundCharts">
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
							<c:set var="bestbidid" value="${anAuction.bestBidId}" />
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
							
							<c:choose>
								<c:when test="${aStatus.count%2 == 0}">
									<c:set var="color" value="#ffffff" />
								</c:when>
								<c:otherwise>
									<c:set var="color" value="#bccbdb" />
								</c:otherwise>
							</c:choose>
							<tr bgcolor="<c:out value="${color}"/>" >                
								<td id="WC_ShopperGalleryListDisplay_TableCell_23_<c:out value="${aStatus.count}"/>" width="120" align="left">
									<font class="text">
										<a href="DisplayAuctionItem?aucrfn=<c:out value="${aucrfn}" />&auctionStoreId=<c:out value="${auctStoreId}" />&productId=<c:out value="${productId}" />&langId=<c:out value="${langId}" />&fromAuction=true" id="WC_ShopperGarllery_Link_10_<c:out value="${aStatus.count}"/>">
											<c:choose>
												<c:when test="${! empty auminbid }">
													<c:out value="${prsdesc}" />*
												</c:when>
												<c:otherwise>
													<c:out value="${prsdesc}" />
												</c:otherwise>
											</c:choose>	
										</a> 
										<br />
										<a href="DisplayAuctionRules?auctionStoreId=<c:out value="${auctStoreId}" />&aucrfn=<c:out value="${aucrfn}" />" id="WC_ShopperGarllery_Link_11_<c:out value="${aStatus.count}"/>">
											<fmt:message key="AuctionCommonText_AuctionRules" bundle="${storeText}" />
										</a>
									</font>
								</td>
								<td id="WC_ShopperGalleryListDisplay_TableCell_24_<c:out value="${aStatus.count}"/>" width="65" align="left">                  
									<font class="text">
										<c:out value="${anAuction.formattedQuantity}" />
									</font>
								</td>
								<td id="WC_ShopperGalleryListDisplay_TableCell_25_<c:out value="${aStatus.count}"/>" width="110" align="left">
									<font class="text">
										<c:choose>
											<c:when test="${autype=='O'}">
												<fmt:message key="AuctionCommonText_OpenCry" bundle="${storeText}" /><br />
												<a href="BidListView?auctionStoreId=<c:out value="${auctStoreId}" />&aucrfn=<c:out value="${aucrfn}" />" id="WC_ShopperGarllery_Link_12_<c:out value="${aStatus.count}"/>">
													(<fmt:message key="AuctionCommonText_SeeAllBids" bundle="${storeText}" />)
												</a>  
											</c:when>
											<c:when test="${autype=='SB'}">
												<fmt:message key="AuctionCommonText_SealedBid" bundle="${storeText}" /><br />
											</c:when>
											<c:otherwise>
												<fmt:message key="AuctionCommonText_DutchAuction" bundle="${storeText}" /><br />
												<a href="BidListView?auctionStoreId=<c:out value="${auctStoreId}" />&aucrfn=<c:out value="${aucrfn}" />" id="WC_ShopperGarllery_Link_13_<c:out value="${aStatus.count}"/>">
													(<fmt:message key="AuctionCommonText_SeeAllBids" bundle="${storeText}" />)
												</a>  
											</c:otherwise>
										</c:choose>
									</font>
								</td>
								<td id="WC_ShopperGalleryListDisplay_TableCell_26_<c:out value="${aStatus.count}"/>" width="100" align="left">        
									<font class="text">
										<c:choose>
											<c:when test="${empty bdvalue || autype=='D'}">
												---
											</c:when>
											<c:otherwise>
												<font class="price"><c:out value="${bdvalue}" /> </font>
											</c:otherwise>
										</c:choose>
									</font>
								</td>
								<td id="WC_ShopperGalleryListDisplay_TableCell_27_<c:out value="${aStatus.count}"/>" width="210" align="left">
									<font class="text">
									<c:out value="${auenddat}" /><br />
									</font>
								</td>
								<td id="WC_ShopperGalleryListDisplay_TableCell_2_<c:out value="${aStatus.count}"/>8" width="65" align="left">
									<font class="text">
										<a href="GalleryDelete?aucrfn=<c:out value="${aucrfn}" />&storeId=<c:out value="${storeId}" />&URL=ShopperAuctionListView" id="WC_ShopperGarllery_Link_14_<c:out value="${aStatus.count}"/>">
											<fmt:message key="AuctionCommonText_Remove" bundle="${storeText}" /><br />
										</a> 
									</font>
								</td> 
							</tr>
						</c:forEach>	
					</table>
				</c:if>
				<%--This section  is to display a list of future auctions --%>
				<c:if test="${length2 >0 && inStoreFlag2 == true}">
					<br />
					<h1>
						<fmt:message key="AuctionCommonText_FutureAuctions" bundle="${storeText}" />
					</h1>
					<table id="WC_ShopperGalleryListDisplay_Table_5" cellpadding="0" cellspacing="1" width="100%" border="0" bgcolor="#4C6178">
						<tr bgcolor="#4C6178">
							<td id="WC_ShopperGalleryListDisplay_TableCell_29" align="left" valign="top" class="textOverBackgroundCharts">
								<font style="font-family : Verdana;" color="#FFFFFF">
								<strong>
									<fmt:message key="AuctionCommonText_ProductName" bundle="${storeText}" />
								</strong>
								<br />(<fmt:message key="AuctionCommonText_AuctionRules" bundle="${storeText}" />)
								</font>
							</td>
							<td id="WC_ShopperGalleryListDisplay_TableCell_30" align="left" valign="top" class="textOverBackgroundCharts">
								<font style="font-family : Verdana;" color="#FFFFFF">
								<strong>
									<fmt:message key="AuctionCommonText_Quantity" bundle="${storeText}" />
								</strong>
								</font>
							</td>
							<td id="WC_ShopperGalleryListDisplay_TableCell_31" align="left" valign="top" class="textOverBackgroundCharts">
								<font style="font-family : Verdana;" color="#FFFFFF">
								<strong>
									<fmt:message key="AuctionCommonText_AuctionType" bundle="${storeText}" />
								</strong>
								</font>
							</td>
							<td id="WC_ShopperGalleryListDisplay_TableCell_32" align="left" valign="top" class="textOverBackgroundCharts">
								<font style="font-family : Verdana;" color="#FFFFFF">
								<strong>
									<fmt:message key="AuctionCommonText_AuctionStarts" bundle="${storeText}" />
								</strong>
								</font>
							</td>
							<td id="WC_ShopperGalleryListDisplay_TableCell_33" align="left" valign="top" class="textOverBackgroundCharts">
								<!-- Remove -->
							</td>
						</tr>
						<c:forEach var="anAuction" items="${alb2.auctions}" begin="0" end="${length2}" varStatus="aStatus">
							<c:set var="aucrfn" value="${anAuction.id}" />	
							<c:set var="austatus" value="${anAuction.status}" />	
							<c:set var="autype" value="${anAuction.auctionType}" />
							<c:set var="austdate" value="${anAuction.formattedStartTime}" />	
							<c:set var="auminbid" value="${anAuction.formattedAuctReservePrice}" />
							<c:set var="productId" value="${anAuction.entryId}" />	
							<c:set var="auctStoreId" value="${anAuction.storeId}" />
							<c:set var="prsdesc" value="${anAuction.auctItemDesc}" />

							<c:choose>
								<c:when test="${aStatus.count%2 == 0}">
									<c:set var="color" value="#ffffff" />
								</c:when>
								<c:otherwise>
									<c:set var="color" value="#bccbdb" />
								</c:otherwise>
							</c:choose>
							<tr bgcolor="<c:out value="${color}"/>" > 
								<td id="WC_ShopperGalleryListDisplay_TableCell_34" width="130" align="left">
									<font class="text">
										<a href="DisplayAuctionItem?aucrfn=<c:out value="${aucrfn}" />&auctionStoreId=<c:out value="${auctStoreId}" />&productId=<c:out value="${productId}" />&langId=<c:out value="${langId}" />&fromAuction=true" id="WC_ShopperGarllery_Link_15">
											<c:choose>
												<c:when test="${! empty auminbid }">
													<c:out value="${prsdesc}" />*
												</c:when>
												<c:otherwise>
													<c:out value="${prsdesc}" />
												</c:otherwise>
											</c:choose>	
										</a> 
										<br />
										<a href="DisplayAuctionRules?auctionStoreId=<c:out value="${auctStoreId}" />&aucrfn=<c:out value="${aucrfn}" />" id="WC_ShopperGarllery_Link_16">
											<fmt:message key="AuctionCommonText_AuctionRules" bundle="${storeText}" />
										</a>
									</font>
								</td>
								<td id="WC_ShopperGalleryListDisplay_TableCell_35" width="65" align="left">                  
									<font class="text">
										<c:out value="${anAuction.formattedQuantity}" />
									</font>
								</td>                 
								<td id="WC_ShopperGalleryListDisplay_TableCell_36" width="185" align="left">
									<font class="text">
										<c:choose>
											<c:when test="${autype=='O'}">
												<fmt:message key="AuctionCommonText_OpenCry" bundle="${storeText}" /><br />
											</c:when>
											<c:when test="${autype=='SB'}">
												<fmt:message key="AuctionCommonText_SealedBid" bundle="${storeText}" /><br />
											</c:when>
											<c:otherwise>
												<fmt:message key="AuctionCommonText_DutchAuction" bundle="${storeText}" /><br />
											</c:otherwise>
										</c:choose>
									</font>
								</td>
								<td id="WC_ShopperGalleryListDisplay_TableCell_37" width="210" align="left">
									<font class="text">
										<c:out value="${austdate}" /><br />
									</font>
								</td>
								<td id="WC_ShopperGalleryListDisplay_TableCell_38" width="65" align="left">
									<font class="text">
										<a href="GalleryDelete?aucrfn=<c:out value="${aucrfn}" />&storeId=<c:out value="${storeId}" />&URL=ShopperAuctionListView" id="WC_ShopperGarllery_Link_17">
											<fmt:message key="AuctionCommonText_Remove" bundle="${storeText}" /><br />
										</a> 
									</font>
								</td>
							</tr> 
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

