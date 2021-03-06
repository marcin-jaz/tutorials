<%--==========================================================================
Licensed Materials - Property of IBM

WebSphere Commerce

(c) Copyright IBM Corp.  2006
All Rights Reserved

US Government Users Restricted Rights - Use, duplication or
disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
===========================================================================--%>
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
//*Note: DataBeanManager.activate() is not called because there is no 
//*CommandContext set up when jsp is executed by messaging system thru
//*scheduler 
//*-------------------------------------------------------------------
//*
--%>


<%@ include file="AuctionMessageCommon.jspf"%>

<c:set var="langId" value="${RequestProperties.langId}"/>
<c:if test="${langId == null}">
	<c:set var="langId" value="-1"/>
</c:if>
<c:set var="localeString" value="${CommandContext.locale}"/>
<c:set var="bid_id" value="${RequestProperties.bid_id}"/>

<c:if test="${localeString == null || localeString == ''}">
	<c:set var="localeString" value="en_US" />
</c:if>

<wcbase:useBean id="aBid" classname="com.ibm.commerce.negotiation.beans.BidDataBean" >
	<c:set property="bidId" value="${bid_id}" target="${aBid}" />
</wcbase:useBean>	
<c:set var="aucrfn" value="${aBid.auctionId}" />	
<c:set var="storeId" value="${aBid.storeId}" />	
<c:set var="userId" value="${aBid.ownerId}" />	
<c:set var="bidrfn" value="${aBid.referenceCode}" />	
<c:set var="bidQuant" value="${aBid.formattedBidQuantity}" />	
<c:set var="bidValue" value="${aBid.formattedBidPrice}" />	
<c:set var="bidDate" value="${aBid.formattedBidCreationTime}" />	
<c:set var="bidStatus" value="${aBid.status}" />	
<c:set var="bidPyMethod" value="${aBid.paymentDeviceType}" />	
<c:set var="bidWinValue" value="${aBid.formattedWinningPrice}" />	
<c:set var="bidWinQty" value="${aBid.formattedWinningQuantity}" />	
<c:set var="bidMsg" value="${aBid.bidComment}" />	

<wcbase:useBean id="aab" classname="com.ibm.commerce.negotiation.beans.AuctionDataBean" >
	<c:set property="auctionId" value="${aucrfn}" target="${aab}" />
</wcbase:useBean>	
<c:set var="prrfnbr" value="${aab.entryId}" />	
<c:set var="aucQuantity" value="${aab.formattedQuantity}" />	
<c:set var="aucMinimumBid" value="${aab.bestBidId}" />	
<c:set var="aucStartDate" value="${aab.formattedStartTime}" />	
<c:set var="aucDesc" value="${aab.shortDescription}"/>
<c:set var="aucEndDate" value="${aab.formattedRealEndTime}" />	
<c:if test="${aucEndDate == null || aucEndDate == ''}">
	<c:set var="aucEndDate" value="${aab.formattedEndTime}" />	
</c:if>
<c:set var="aucBestBidId" value="${aab.bestBidId}" />	
<c:set var="aucUpdateTime" value="${aab.formattedUpdateTime}" />	
<c:set var="currency" value="${aab.currency}" /> 
<c:set var="prodSku" value="${aab.auctItemSKU}" />	
<c:set var="prodDesc" value="${aab.auctItemDesc}" />	

<c:if test="${! empty aucBestBidId}">
	<c:set var="aBestBid" value="${aab.bestBid}" />
	<c:set var="bestBidrfn" value="${aBestBid.referenceCode}" />
	<c:set var="bestBidQuant" value="${aBestBid.formattedBidQuantity}" />
	<c:set var="bestBidValue" value="${aBestBid.formattedBidPrice}" />
	<c:set var="bestBidDate" value="${aBestBid.formattedBidCreationTime}" />
	<c:set var="bestBidStatus" value="${aBestBid.status}" />
	<c:set var="bestBidPyMethod" value="${aBestBid.paymentDeviceType}" />
	<c:set var="bestBidWinValue" value="${aBestBid.formattedWinningPrice}" />
	<c:set var="bestBidWinQty" value="${aBestBid.formattedBidQuantity}" />
	<c:set var="bestBidMsg" value="${aBestBid.bidComment}" />
</c:if> 

<wcbase:useBean id="sed" classname="com.ibm.commerce.common.beans.StoreEntityDescriptionDataBean" >
	<c:set property="dataBeanKeyLanguageId" value="${langId}" target="${sed}" />
	<c:set property="dataBeanKeyStoreEntityId" value="${storeId}" target="${sed}" />
</wcbase:useBean>	

<c:set var="storeName" value=" " />
<c:set var="storeDesc" value=" " />
<c:if test="${sed.displayName != null}" >
	<c:set var="storeName" value="${sed.displayName}" />
</c:if>
<c:if test="${sed.description != null}" >
	<c:set var="storeDesc" value="${sed.description}" />
</c:if>

<c:set var="storeEmail1" value=" " />
<c:set var="storeEmail2" value=" " />
<c:set var="storeFax" value=" " />
<c:set var="storePhone1" value=" " />
<c:set var="storePhone2" value=" " />
<c:set var="storeAddress1" value=" " />
<c:set var="storeAddress2" value=" " />
<c:set var="storeAddress3" value=" " />
<c:set var="storeCity" value=" " />
<c:set var="storeState" value=" " />
<c:set var="storeCountry" value=" " />
<c:set var="storeZipcode" value=" " />

<c:if test="${! empty sed.contactAddressId}">
	<wcbase:useBean id="sa" classname="com.ibm.commerce.common.beans.StoreAddressDataBean" >
		<c:set property="dataBeanKeyStoreAddressId" value="${sed.contactAddressId}" target="${sa}" />
	</wcbase:useBean>
	<c:if test="${sa.email1 != null}" >
		<c:set var="storeEmail1" value="${sa.email1}" />
	</c:if>	
	<c:if test="${sa.email2 != null}" >
		<c:set var="storeEmail2" value="${sa.email2}" />
	</c:if>	
	<c:if test="${sa.fax1 != null}" >
		<c:set var="storeFax" value="${sa.fax1}" />
	</c:if>	
	<c:if test="${sa.phone1 != null}" >
		<c:set var="storePhone1" value="${sa.phone1}" />
	</c:if>	
	<c:if test="${sa.phone2 != null}" >
		<c:set var="storePhone2" value="${sa.phone2}" />
	</c:if>	
	<c:if test="${sa.address1 != null}" >
		<c:set var="storeAddress1" value="${sa.address1}" />
	</c:if>	
	<c:if test="${sa.address2 != null}" >
		<c:set var="storeAddress2" value="${sa.address2}" />
	</c:if>	
	<c:if test="${sa.address3 != null}" >
		<c:set var="storeAddress3" value="${sa.address3}" />
	</c:if>	
	<c:if test="${sa.city != null}" >
		<c:set var="storeCity" value="${sa.city}" />
	</c:if>	
	<c:if test="${sa.state != null}" >
		<c:set var="storeState" value="${sa.state}" />
	</c:if>	
	<c:if test="${sa.country != null}" >
		<c:set var="storeCountry" value="${sa.country}" />
	</c:if>	
	<c:if test="${sa.zipCode != null}" >
		<c:set var="storeZipcode" value="${sa.zipCode}" />
	</c:if>	
</c:if>	
<%--
<wcbase:useBean id="aRegister" classname="com.ibm.commerce.user.beans.UserRegistrationDataBean" >
	<c:set property="userId" value="${userId}" target="${aRegister}" />
</wcbase:useBean>
<c:set var="safname" value="" />
<c:set var="samname" value="" />
<c:set var="salname" value="" />
<c:if test="${aRegister.firstName != null}">
	<c:set var="safname" value="${aRegister.firstName}" />
</c:if>
<c:if test="${aRegister.middleName != null}">
	<c:set var="samname" value="${aRegister.middleName}" />
</c:if>
<c:if test="${aRegister.lastName != null}">
	<c:set var="salname" value="${aRegister.lastName}" />
</c:if>
--%>
<c:set var="prodWeight" value="" />
<c:set var="prodWeightUnit" value="" />
<c:set var="prodWidth" value="" />
<c:set var="prodLength" value="" />
<c:set var="prodShCode" value="" />
<c:set var="prodUrl" value="" />

<%--
<wcbase:useBean id="cesab" classname="com.ibm.commerce.fulfillment.beans.CatalogEntryShippingDataBean" >
	<c:set property="dataBeanKeyCatalogEntryId" value="${prrfnbr}" target="${cesab}" />
</wcbase:useBean>

<c:set var="prodWeight" value="${cesab.weight}" />
--%>

<%--
<c:set var="nameDisplayOutString1">
	<fmt:message key="shopper.lastName" bundle="${storeText}" >
		<fmt:param value="${salname}" />
	</fmt:message>
	<fmt:message key="shopper.firstName" bundle="${storeText}" >
		<fmt:param value="${safname}" />
	</fmt:message>	
</c:set>
<c:set var="nameDisplayOutString2">
	<fmt:message key="shopper.firstName" bundle="${storeText}" >
		<fmt:param value="${safname}" />
	</fmt:message>
	<fmt:message key="shopper.middleName" bundle="${storeText}" >
		<fmt:param value="${samname}" />
	</fmt:message>
	<fmt:message key="shopper.lastName" bundle="${storeText}" >
		<fmt:param value="${salname}" />
	</fmt:message>
</c:set>

<c:choose>
	<c:when test="${localeString == 'zh_TW' || localeString == 'zh_CN' || localeString == 'ko_KR' || localeString == 'ja_JP'}" >
		<c:set var="nameDisplayOutString" value="${nameDisplayOutString1}" />
	</c:when>
	<c:otherwise>
		<c:set var="nameDisplayOutString" value="${nameDisplayOutString2}" />
	</c:otherwise>
</c:choose>
--%>
<c:set var="addressDisplayOutString1">
	<fmt:message key="merchant.country" bundle="${storeText}" >
		<fmt:param value="${storeCountry}" />
	</fmt:message>
	<fmt:message key="merchant.zip" bundle="${storeText}" >
		<fmt:param value="${storeZipcode}" />
	</fmt:message>
	<fmt:message key="merchant.state" bundle="${storeText}" >
		<fmt:param value="${storeState}" />
	</fmt:message>
	<fmt:message key="merchant.city" bundle="${storeText}" >
		<fmt:param value="${storeCity}" />
	</fmt:message>
	<fmt:message key="merchant.address1" bundle="${storeText}" >
		<fmt:param value="${storeAddress1}" />
	</fmt:message>
	<fmt:message key="merchant.address2" bundle="${storeText}" >
		<fmt:param value="${storeAddress2}" />
	</fmt:message>
	<fmt:message key="merchant.address3" bundle="${storeText}" >
		<fmt:param value="${storeAddress3}" />
	</fmt:message>	
</c:set>
<c:set var="addressDisplayOutString2">
	<fmt:message key="merchant.address1" bundle="${storeText}" >
		<fmt:param value="${storeAddress1}" />
	</fmt:message>
	<fmt:message key="merchant.address2" bundle="${storeText}" >
		<fmt:param value="${storeAddress2}" />
	</fmt:message>
	<fmt:message key="merchant.address3" bundle="${storeText}" >
		<fmt:param value="${storeAddress3}" />
	</fmt:message>	
	<fmt:message key="merchant.city" bundle="${storeText}" >
		<fmt:param value="${storeCity}" />
	</fmt:message>
	<fmt:message key="merchant.state" bundle="${storeText}" >
		<fmt:param value="${storeState}" />
	</fmt:message>
	<fmt:message key="merchant.country" bundle="${storeText}" >
		<fmt:param value="${storeCountry}" />
	</fmt:message>
	<fmt:message key="merchant.zip" bundle="${storeText}" >
		<fmt:param value="${storeZipcode}" />
	</fmt:message>	
</c:set>

<c:choose>
	<c:when test="${localeString == 'zh_TW' || localeString == 'zh_CN' || localeString == 'ko_KR' || localeString == 'ja_JP'}" >
		<c:set var="addressDisplayOutString" value="${addressDisplayOutString1}" />
	</c:when>
	<c:otherwise>
		<c:set var="addressDisplayOutString" value="${addressDisplayOutString2}" />
	</c:otherwise>
</c:choose>

	<fmt:message key="bidOverrideIntro" bundle="${storeText}" >
		<fmt:param value="${bidrfn}" />
		<fmt:param value="${prodDesc}" />
	</fmt:message>
	
	<fmt:message key="auction.info" bundle="${storeText}" >
		<fmt:param value="${aucrfn}" />
	</fmt:message>
	-------------------------------------------------------------------    
	<fmt:message key="auction.quantity" bundle="${storeText}" >
		<fmt:param value="${aucQuantity}" />
	</fmt:message>
	<fmt:message key="auction.start" bundle="${storeText}" >
		<fmt:param value="${aucStartDate}" />
		<fmt:param value=" " />
	</fmt:message>
	<fmt:message key="auction.end" bundle="${storeText}" >
		<fmt:param value="${aucEndDate}" />
		<fmt:param value=" " />
	</fmt:message>
	<fmt:message key="auction.description" bundle="${storeText}" >
		<fmt:param value="${aucDesc}" />
	</fmt:message>
	<fmt:message key="auction.updatetime" bundle="${storeText}" >
		<fmt:param value="${aucUpdateTime}" />
	</fmt:message>
	
	<fmt:message key="merchant.info" bundle="${storeText}" >
		<fmt:param value="${storeId}" />
	</fmt:message>
	-------------------------------------------------------------------      
	<fmt:message key="merchant.store" bundle="${storeText}" >
		<fmt:param value="${storeName}" />
	</fmt:message>
	<fmt:message key="merchant.description" bundle="${storeText}" >
		<fmt:param value="${storeDesc}" />
	</fmt:message>
	<fmt:message key="merchant.email1" bundle="${storeText}" >
		<fmt:param value="${storeEmail1}" />
	</fmt:message>
	<fmt:message key="merchant.email2" bundle="${storeText}" >
		<fmt:param value="${storeEmail2}" />
	</fmt:message>
	<fmt:message key="merchant.fax" bundle="${storeText}" >
		<fmt:param value="${storeFax}" />
	</fmt:message>
	<fmt:message key="merchant.phone" bundle="${storeText}" >
		<fmt:param value="${storePhone1}" />
	</fmt:message>
	<c:out value="${addressDisplayOutString}" />
<%--	
	<fmt:message key="shopper.info" bundle="${storeText}" >
		<fmt:param value="${userId}" />
	</fmt:message>
	------------------------------------------------------------------- 
	<c:out value="${nameDisplayOutString}" />
--%>	  
	<fmt:message key="product.info" bundle="${storeText}" >
		<fmt:param value="${prrfnbr}" />
	</fmt:message>
	-------------------------------------------------------------------      
	<fmt:message key="product.sku" bundle="${storeText}" >
		<fmt:param value="${prodSku}" />
	</fmt:message>
	<fmt:message key="product.description" bundle="${storeText}" >
		<fmt:param value="${prodDesc}" />
	</fmt:message>
	<fmt:message key="product.weight" bundle="${storeText}" >
		<fmt:param value="${prodWeight}" />
	</fmt:message>
	<fmt:message key="product.weightUnit" bundle="${storeText}" >
		<fmt:param value="${prodWeightUnit}" />
	</fmt:message>
	<fmt:message key="product.length" bundle="${storeText}" >
		<fmt:param value="${prodLength}" />
	</fmt:message>
	<fmt:message key="product.width" bundle="${storeText}" >
		<fmt:param value="${prodWidth}" />
	</fmt:message>
	<fmt:message key="product.shippingCode" bundle="${storeText}" >
		<fmt:param value="${prodShCode}" />
	</fmt:message>
	<fmt:message key="product.url" bundle="${storeText}" >
		<fmt:param value="${prodUrl}" />
	</fmt:message>
	   
	<fmt:message key="bid.info" bundle="${storeText}" >
		<fmt:param value="${bidrfn}" />
	</fmt:message>
	------------------------------------------------------------------- 
	<fmt:message key="bid.quantity" bundle="${storeText}" >
		<fmt:param value="${bidQuant}" />
	</fmt:message>
	<fmt:message key="bid.value" bundle="${storeText}" >
		<fmt:param value="${bidValue}" />
	</fmt:message>
	<fmt:message key="bid.dateTime" bundle="${storeText}" >
		<fmt:param value="${bidDate}" />
		<fmt:param value=" " />
	</fmt:message>
	<fmt:message key="bid.status" bundle="${storeText}" >
		<fmt:param value="${bidStatus}" />
	</fmt:message>
	<fmt:message key="bid.payMethod" bundle="${storeText}" >
		<fmt:param value="${bidPyMethod}" />
	</fmt:message>
	<fmt:message key="bid.winValue" bundle="${storeText}" >
		<fmt:param value="${bidWinValue}" />
	</fmt:message>
	<fmt:message key="bid.winQuantity" bundle="${storeText}" >
		<fmt:param value="${bidWinQty}" />
	</fmt:message>
	<fmt:message key="bid.message" bundle="${storeText}" >
		<fmt:param value="${bidMsg}" />
	</fmt:message>
	        
	<fmt:message key="bestBid.info" bundle="${storeText}" >
		<fmt:param value="${bestBidrfn}" />
	</fmt:message>
	------------------------------------------------------------------- 
	<fmt:message key="bestBid.quantity" bundle="${storeText}" >
		<fmt:param value="${bestBidQuant}" />
	</fmt:message>
	<fmt:message key="bestBid.value" bundle="${storeText}" >
		<fmt:param value="${bestBidValue}" />
	</fmt:message>
	<fmt:message key="bestBid.dateTime" bundle="${storeText}" >
		<fmt:param value="${bestBidDate}" />
		<fmt:param value=" " />
	</fmt:message>
	<fmt:message key="bestBid.status" bundle="${storeText}" >
		<fmt:param value="${bestBidStatus}" />
	</fmt:message>
	<fmt:message key="bestBid.winValue" bundle="${storeText}" >
		<fmt:param value="${bestBidWinValue}" />
	</fmt:message>
	<fmt:message key="bestBid.winQuantity" bundle="${storeText}" >
		<fmt:param value="${bestBidWinQty}" />
	</fmt:message>
	<fmt:message key="bestBid.message" bundle="${storeText}" >
		<fmt:param value="${bestBidMsg}" />
	</fmt:message>
