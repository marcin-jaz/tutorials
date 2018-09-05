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
<%@ include file="../include/JSTLEnvironmentSetup.jspf" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "DTD/xhtml1-transitional.dtd" >
<html lang="en"> 
 
<head>
	<title><fmt:message key="homeTitle" bundle="${storeText}" /></title>
	<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${vfileStylesheet}"/>" type="text/css" />
</head>

<body class="noMargin">

<%@ include file="../include/LayoutContainerTop.jspf"%>


	<wcbase:useBean id="aRegister" classname="com.ibm.commerce.user.beans.UserRegistrationDataBean" />
	<c:set var="safname" value="${aRegister.firstName}"/>                           
	<c:set var="samname" value="${aRegister.middleName}"/>  
	<c:set var="salname" value="${aRegister.lastName}"/>  
	 
	
	<table class="noBorder" cellpadding="0" cellspacing="12"  id="WC_AuctionHomeDisplay_Table_1">
		<tr>
			<td id="WC_AuctionHomeDisplay_TableCell_1">
				<h1>
				<fmt:message key="welcomeMsg" bundle="${storeText}">
					<fmt:param value="${safname}"/>
					<fmt:param value="${samname}"/>
					<fmt:param value="${salname}"/>
				</fmt:message>				
				</h1>
			</td>
		</tr>
            
		<tr>
			<td id="WC_AuctionHomeDisplay_TableCell_2">
			<fmt:message key="auc_home.msg1" bundle="${storeText}"/>
			<br/>
			</td>
		</tr>
		<tr>
			<td id="WC_AuctionHomeDisplay_TableCell_3">
				<c:url value="ShopperAuctionListView" var="shopperAuctionListViewUrl" >
					<c:param name="storeId" value="${storeId}"/>
					<c:param name="catalogId" value="${catalogId}"/>
				</c:url>						
				<a class="button" href="<c:out value="${shopperAuctionListViewUrl}"/>" id="WC_AuctionHomeDisplay_Link_1">
					<fmt:message key="txtGallery" bundle="${storeText}"/>
				</a>
				<br /><br />
					
			</td>
		</tr>
		
		<tr>
			<td  id="WC_AuctionHomeDisplay_TableCell_4">
			<fmt:message key="auc_home.msg2" bundle="${storeText}"/>
			</td>
		</tr>
		<tr>
			<td id="WC_AuctionHomeDisplay_TableCell_5">
				<c:url value="AuctionListView" var="auctionListViewUrl">
					<c:param name="storeId" value="${storeId}"/>
					<c:param name="catalogId" value="${catalogId}"/>
					<c:param name="status" value="F"/>
				</c:url>						
				<a class="button" href="<c:out value="${auctionListViewUrl}"/>" id="WC_AuctionHomeDisplay_Link_2">
					<fmt:message key="txtFutureAuctions" bundle="${storeText}"/>
				</a>
				<br /><br />
				
			</td>
		</tr>
		
		<tr>
			<td  id="WC_AuctionHomeDisplay_TableCell_6">
			<fmt:message key="auc_home.msg3" bundle="${storeText}"/>
			</td>
		</tr>
		<tr>
			<td id="WC_AuctionHomeDisplay_TableCell_7">
				<c:url value="AuctionListView" var="auctionListViewUrl">
					<c:param name="storeId" value="${storeId}"/>
					<c:param name="catalogId" value="${catalogId}"/>
					<c:param name="status" value="C"/>
				</c:url>						
				<a class="button" href="<c:out value="${auctionListViewUrl}"/>" id="WC_AuctionHomeDisplay_Link_3">
					<fmt:message key="txtCurrentAuctions" bundle="${storeText}"/>
				</a>
				<br /><br />
				
			</td>
		</tr>
		
		<tr>
			<td  id="WC_AuctionHomeDisplay_TableCell_8">
			<fmt:message key="auc_home.msg4" bundle="${storeText}"/>
			</td>
		</tr>
		<tr>
			<td id="WC_AuctionHomeDisplay_TableCell_9">
				<c:url value="AuctionListView" var="auctionListViewUrl">
					<c:param name="storeId" value="${storeId}"/>
					<c:param name="catalogId" value="${catalogId}"/>
					<c:param name="status" value="BCSC"/>
				</c:url>						
				<a class="button" href="<c:out value="${auctionListViewUrl}"/>" id="WC_AuctionHomeDisplay_Link_4">
					<fmt:message key="txtRecentlyClosedAuctions" bundle="${storeText}"/>
				</a>
				<br /><br />
				
			</td>
		</tr>
		
		<tr>
			<td  id="WC_AuctionHomeDisplay_TableCell_10">
			<fmt:message key="auc_home.msg5" bundle="${storeText}"/>
			</td>
		</tr>
		<tr>
			<td id="WC_AuctionHomeDisplay_TableCell_11">
				<c:url value="ShopperAuctionListView" var="shopperAuctionListViewUrl">
					<c:param name="storeId" value="${storeId}"/>
					<c:param name="catalogId" value="${catalogId}"/>					
				</c:url>						
				<a class="button" href="<c:out value="${shopperAuctionListViewUrl}"/>" id="WC_AuctionHomeDisplay_Link_5">
					<fmt:message key="txtGallery" bundle="${storeText}"/>
				</a>
				<br /><br />
				
			</td>
		</tr>		
		
		<tr>
			<td  id="WC_AuctionHomeDisplay_TableCell_12">
			<fmt:message key="auc_home.msg6" bundle="${storeText}"/>
			</td>
		</tr>
		<tr>
			<td id="WC_AuctionHomeDisplay_TableCell_13">
				<c:url value="ShopperBidListView" var="shopperBidListViewUrl">
					<c:param name="storeId" value="${storeId}"/>
					<c:param name="catalogId" value="${catalogId}"/>
					<c:param name="status" value="C"/>
				</c:url>						
				<a class="button" href="<c:out value="${shopperBidListViewUrl}"/>" id="WC_AuctionHomeDisplay_Link_6">
					<fmt:message key="yourBidsTitle" bundle="${storeText}"/>
				</a>
				<br /><br />
				
			</td>
		</tr>		
		
		<tr>
			<td  id="WC_AuctionHomeDisplay_TableCell_14">
			<fmt:message key="auc_home.msg7" bundle="${storeText}"/>
			</td>
		</tr>
		<tr>
			<td id="WC_AuctionHomeDisplay_TableCell_15">
				<c:url value="MailListView" var="mailListViewUrl">
					<c:param name="storeId" value="${storeId}"/>
					<c:param name="catalogId" value="${catalogId}"/>
					<c:param name="status" value="C"/>
				</c:url>						
				<a class="button" href="<c:out value="${mailListViewUrl}"/>" id="WC_AuctionHomeDisplay_Link_7">
					<fmt:message key="txtMailBox" bundle="${storeText}"/>
				</a>
				<br /><br />
				
			</td>
		</tr>		
		
	
	</table>
	

	

<%@ include file="../include/LayoutContainerBottom.jspf"%>
</body>
</html>
 