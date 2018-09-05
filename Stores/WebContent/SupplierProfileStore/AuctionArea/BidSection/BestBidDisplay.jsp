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

<c:set var="errorMessage" value="${param.errorMessage}" />
<c:set var="bid_id" value="${WCParam.bid_id}" />
<c:set var="aucrfn" value="${WCParam.aucrfn}" />
<c:set var="autobid_id" value="${WCParam.autobid_id}" />


<c:if test="${empty aucrfn}">
	<c:if test="${! empty bid_id}">
		<wcbase:useBean id="aBid" classname="com.ibm.commerce.negotiation.beans.BidDataBean">
			<c:set property="bidId" target="${aBid}" value="${bid_id}" />
		</wcbase:useBean>
		<c:set var="aucrfn" value="${aBid.auctionId}" />
	</c:if>
	<c:if test="${! empty autobid_id}">
		<wcbase:useBean id="anAutoBid" classname="com.ibm.commerce.negotiation.beans.AutoBidDataBean">
			<c:set property="autoBidId" target="${anAutoBid}" value="${autobid_id}" />
		</wcbase:useBean>
		<c:set var="aucrfn" value="${anAutoBid.auctionId}" />
	</c:if>
</c:if>

<wcbase:useBean id="anAuction" classname="com.ibm.commerce.negotiation.beans.AuctionDataBean">
	<c:set property="auctionId" target="${anAuction}" value="${aucrfn}" />
</wcbase:useBean>

<c:set var="highbid_Id" value="${anAuction.highestBidId}" />
<c:set var="bestbid_Id" value="${anAuction.bestBidId}" />
<c:set var="product_Desc" value="${anAuction.auctItemDesc}" />
<c:set var="auction_Type" value="${anAuction.auctionType}" />

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "DTD/xhtml1-transitional.dtd">
<html lang="en">
<body>
<table cellpadding="1" cellspacing="2" width="580" border="0" id="WC_BestBidDisplay_Table_1">
	<tbody>
		<tr>
			<td width="10" id="WC_BestBidDisplay_TableCell_1">&nbsp;</td>
			<td align="left" valign="top" colspan="5" class="categoryspace"	width="580" id="WC_BestBidDisplay_TableCell_2">
			<font class="pageHeading"> 
			<c:out value="${product_Desc}" /> 
			</font> 
			<br />

			<c:if test="${auction_Type eq 'O'}">

				<c:set var="highbid_Val" value="0" />
				<c:if test="${! empty highbid_Id }">
					<%-- get high bid information --%>					
					<c:set var="highbid_Val" value="${anAuction.highestBid.formattedBidPrice}" />
				</c:if>
				<c:set var="bestbid_Val" value="0" />
				<c:if test="${! empty bestbid_Id}">
					<%-- get best bid information --%>					
					<c:set var="bestbid_Val" value="${anAuction.bestBid.formattedBidPrice}" />
				</c:if>
				<font class="price"> 
				(<fmt:message key="highestBid"	bundle="${storeText}">
					<fmt:param value="${highbid_Val}" />
				</fmt:message>) 
				<br />
				(<fmt:message key="lowestBid" bundle="${storeText}">
					<fmt:param value="${bestbid_Val}" />
				</fmt:message>) </font>
			</c:if> <br />
						
			<c:if test="${!empty errorMessage}">
					<c:out value="${errorMessage}"/>
			</c:if>
			</td>
		</tr>
	</tbody>
</table>

</body>
</html>
