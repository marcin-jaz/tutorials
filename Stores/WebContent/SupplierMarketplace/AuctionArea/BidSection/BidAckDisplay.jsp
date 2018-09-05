<%--
/* 
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

<c:if test="${CommandContext.sessionData != null}">
	<c:set var="sessionStoreId" value="${CommandContext.sessionData.storeId}" />
</c:if>
<c:if test="${sessionStoreId == null}">
	<c:set var="sessionStoreId" value="${CommandContext.storeId}" />
</c:if>	
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "DTD/xhtml1-transitional.dtd">

<html>
<head>
	<meta http-equiv="Expires" content="Mon, 01 Jan 1996 01:01:01 GMT" />
	<title><fmt:message key="BidAck_bidAckTitle" bundle="${storeText}" /></title>
	<link rel="stylesheet" href="<c:out value="${fileDir}"/>ToolTech.css" type="text/css" />
</head>

<body>

<flow:ifEnabled feature="customerCare">
<%--Set header type needed for this JSP for LiveHelp.  This must be set before HeaderDisplay.jsp--%>
<c:set var="liveHelpPageType" value="personal" scope="request" />
</flow:ifEnabled>

<%@ include file="../../include/LayoutContainerTop.jspf"%>
<table id="WC_BidAckDisplay_Table_1" border="0" cellpadding="0" cellspacing="0" width="790" >
<tr>
	
	<td id="WC_BidAckDisplay_TableCell_2" valign="top" width="630">
	<c:set var="aucShowBidRef" value="true" />
	<c:set var="aucrfn" value="${WCParam.aucrfn}" />
	<c:set var="bidval" value="${WCParam.bidval}" />
	<c:set var="bidquant" value="${WCParam.bidquant}" />
	<c:set var="bidrfn" value="${WCParam.bidrfn}" />
	<c:set var="autobidrfn" value="${WCParam.autobidrfn}" />
	<c:set var="maxbidlimit" value="${WCParam.maxbidlimit}" />	
	<c:if test ="${! empty bidrfn}">
		<wcbase:useBean id="aBid" classname="com.ibm.commerce.negotiation.beans.BidDataBean">
			<c:set property="bidReferenceCode" value="${bidrfn}" target="${aBid}" />
		</wcbase:useBean> 
		<c:set var="formattedBidVal"	value="${aBid.formattedBidPrice}" /> 
		<c:set var="formattedBidquant" value="${aBid.formattedBidQuantity}" /> 
	</c:if>
	<c:if test ="${! empty autobidrfn}">
		<wcbase:useBean id="anAutoBid" classname="com.ibm.commerce.negotiation.beans.AutoBidDataBean">
			<c:set property="bidReferenceCode" value="${autobidrfn}" target="${anAutoBid}" />
		</wcbase:useBean> 
		<c:set var="formattedBidVal"	value="${anAutoBid.formattedInitBidPrice}" /> 
		<c:set var="formattedBidquant" value="${anAutoBid.formattedBidQuantity}" /> 
		<c:set var="formattedMaxbidlimit" value="${anAutoBid.formattedMaxBidLimit}" /> 
	</c:if>
	<table id="WC_BidAckDisplay_Table_2" cellpadding="1" cellspacing="2" width="600" border="0">
		<tr>
			<td id="WC_BidAckDisplay_TableCell_3" width="10">&nbsp;</td>
				<td id="WC_BidAckDisplay_TableCell_4" align="left" valign="top" class="categoryspace" width="580">					
				<c:choose>
					<%-- If this is a regular bid --%>
					<c:when test="${ ! empty bidrfn }">
						<h1>
							<fmt:message key="BidAck_bidSubMsg" bundle="${storeText}" />				
						</h1>
						<br />
						<hr width="100%" noshade="noshade" align="left" />
						<c:if test="${aucShowBidRef == true}" >
							<font class="productName">
								<fmt:message key="BidAck_refNumberMsg" bundle="${storeText}" >
									<fmt:param value="${bidrfn}" />
								</fmt:message>
							</font><br />
						</c:if>
						<font class="price">
							<fmt:message key="BidAck_bidItemsMsg" bundle="${storeText}" >
								<fmt:param value="${formattedBidquant}" />
								<fmt:param value="${formattedBidVal}" />
							</fmt:message>
						</font>
					</c:when>
					<%-- This is autobid --%>
					<c:when test="${! empty autobidrfn }" >								
						<h1>
							<fmt:message key="BidAck_bidSubMsg" bundle="${storeText}" />
						</h1><br />
						<hr width="100%" noshade="noshade" align="left" />
						<c:if test="${aucShowBidRef == true}">
							<font class="productName">
								<fmt:message key="BidAck_refNumberMsg" bundle="${storeText}" >
									<fmt:param value="${autobidrfn}" />
								</fmt:message>
							</font><br />
						</c:if>
						<font class="price">
							<fmt:message key="BidAck_autoBidMsg" bundle="${storeText}" >
								<fmt:param value="${formattedBidquant}" />
								<fmt:param value="${formattedMaxbidlimit}" />
							</fmt:message>
							<br />
							
							<fmt:message key="BidAck_startBidMsg" bundle="${storeText}" >
								<fmt:param value="${formattedBidVal}" />
							</fmt:message>
							
						</font>
					</c:when>
					<%-- Should not be here --%>
					<c:otherwise>
						<font class="productName">
							<fmt:message key="BidAck_noBidMsg" bundle="${storeText}" />
						</font>
					</c:otherwise>
				</c:choose>
				</td>
			</tr>
			<tr>
				<td id="WC_BidAckDisplay_TableCell_5" width="10">&nbsp;</td>
				<td id="WC_BidAckDisplay_TableCell_6" align="left">
					<br />
					<table id="WC_BidAckDisplay_Table_3" cellpadding="3" cellspacing="3" border="0">
						<tr>
							<td id="WC_BidAckDisplay_TableCell_7" align="left" class="buttonStyle">
								<font class="buttonStyle">
									<a href="ShopperAuctionListView?storeId=<c:out value="${sessionStoreId}" />" id="WC_BidAckDisplay_Link_1">
										<fmt:message key="BidAck_goToGallery" bundle="${storeText}" />
									</a>     
								</font>
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
	</td>
</tr>
</table>

<%@ include file="../../include/LayoutContainerBottom.jspf"%>
</body>
</html>
