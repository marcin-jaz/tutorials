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
//* IBM Confidential
//* OCO Source Materials
//*
//* The source code for this program is not published or otherwise
//* divested of its trade secrets, irrespective of what has been
//* deposited with the US Copyright Office.
//*--------------------------------------------------------------------------------------
//* The sample contained herein is provided to you "AS IS".
//*
//* It is furnished by IBM as a simple example and has not been thoroughly tested
//* under all conditions.  IBM, therefore, cannot guarantee its reliability, 
//* serviceability or functionality.  
//*
//* This sample may include the names of individuals, companies, brands and products 
//* in order to illustrate concepts as completely as possible.  All of these names
//* are fictitious and any similarity to the names and addresses used by actual persons 
//* or business enterprises is entirely coincidental.
//*--------------------------------------------------------------------------------------
//*-------------------------------------------------------------------
//*Purpose: Display message following submission of Bid or AutoBid.
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
<title><fmt:message key="bidAckTitle" bundle="${storeText}" /></title>
<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${vfileStylesheet}"/>" type="text/css" />
</head>

<body>
<%@ include file="../../include/LayoutContainerTop.jspf"%>
<table cellpadding="0" cellspacing="0" border="0" width="600" id="WC_BidAckDisplay_Table_1">
	
	<tbody>
		<tr>
			
			<td bgcolor="#FFFFFF" width="600" valign="top" id="WC_BidAckDisplay_TableCell_1">
			<c:set	var="aucShowBidRef" value="true" /> 
			<c:set var="aucrfn"	value="${WCParam.aucrfn}" /> 
			<c:set var="bidval"	value="${WCParam.bidval}" /> 
			<c:set var="bidquant" value="${WCParam.bidquant}" /> 
			<c:set var="bidrfn"	value="${WCParam.bidrfn}" /> 
			<c:set var="autobidrfn"	value="${WCParam.autobidrfn}" /> 
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
			
			<table cellpadding="1" cellspacing="2" width="600" border="0" id="WC_BidAckDisplay_Table_2">
				<tbody>
					<tr>
						<td width="10" id="WC_BidAckDisplay_TableCell_2">&nbsp;</td>
						<td align="left" valign="top" class="categoryspace" width="580" id="WC_BidAckDisplay_TableCell_3">
						
						<c:choose>
							<%-- If this is a regular bid --%>
							<c:when test="${! empty bidrfn}">
								<h1><fmt:message key="bidSubMsg" bundle="${storeText}" /></h1>
								<br />
								<hr width="100%" noshade="noshade" align="left" />
								<c:if test="${aucShowBidRef == true}">
									<font class="productName"> 
									<fmt:message key="refNumberMsg"	bundle="${storeText}">
										<fmt:param value="${bidrfn}" />
									</fmt:message> 
									</font>
									<br />
								</c:if>
								<font class="price"> 
								<fmt:message key="bidItemsMsg" bundle="${storeText}">
									<fmt:param value="${formattedBidquant}" />
									<fmt:param value="${formattedBidVal}" />
								</fmt:message> 
								</font>
							</c:when>
							<%-- This is autobid --%>
							<c:when test="${! empty autobidrfn}">
								
								<h1><fmt:message key="bidSubMsg" bundle="${storeText}" /></h1>
								<br />
								<hr width="100%" noshade="noshade" align="left" />
								<c:if test="${aucShowBidRef == true}">
									<font class="productName"> 
									<fmt:message key="refNumberMsg"	bundle="${storeText}">
										<fmt:param value="${autobidrfn}" />
									</fmt:message> 
									</font>
									<br />
								</c:if>
								<font class="price"> 
								<fmt:message key="autoBidMsg" bundle="${storeText}">
									<fmt:param value="${formattedBidquant}" />
									<fmt:param value="${formattedMaxbidlimit}" />
								</fmt:message> 
								<br />

								<fmt:message key="startBidMsg" bundle="${storeText}">
									<fmt:param value="${formattedBidVal}" />
								</fmt:message> 
								</font>
							</c:when>
							<%-- Should not be here --%>
							<c:otherwise>
								<font class="productName"> 
								<fmt:message key="noBidMsg"	bundle="${storeText}" /> 
								</font>
							</c:otherwise>
						</c:choose>
						</td>
					</tr>
					<tr>
						<td width="10" id="WC_BidAckDisplay_TableCell_4">&nbsp;</td>
						<td align="left" id="WC_BidAckDisplay_TableCell_5">
						<br />
						<table cellpadding="3" cellspacing="3" border="0" id="WC_BidAckDisplay_Table_3">
							<tbody>
								<tr>
									<td align="left" class="buttonStyle" id="WC_BidAckDisplay_TableCell_6">
									<font class="buttonStyle">
									<a href="ShopperAuctionListView?storeId=<c:out value="${storeId}"/>&catalogId=<c:out value="${catalogId}"/>" id="WC_BidAckDisplay_Link_1"> 
									<fmt:message key="goToGallery" bundle="${storeText}" /> 
									</a> 
									</font>
									</td>
								</tr>
							</tbody>
						</table>
						</td>
					</tr>
				</tbody>
			</table>
			</td>
		</tr>		
	</tbody>
</table>
<%@ include file="../../include/LayoutContainerBottom.jspf"%>

</body>
</html>
