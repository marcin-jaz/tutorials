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
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="/WEB-INF/flow.tld" prefix="flow" %>
<%@ include file="../include/JSTLEnvironmentSetup.jspf"%>

<c:if test="${CommandContext.sessionData != null}">
	<c:set var="sessionStoreId" value="${CommandContext.sessionData.storeId}" />
</c:if>
<c:if test="${sessionStoreId == null}">
	<c:set var="sessionStoreId" value="${CommandContext.storeId}" />
</c:if>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "DTD/xhtml1-transitional.dtd">
<html>
<head>
	<title><fmt:message key="AuctionHome_Title" bundle="${storeText}" /></title>
	<link rel="stylesheet" href="<c:out value="${fileDir}"/>ToolTech.css" type="text/css" />
</head>

<body>

<flow:ifEnabled feature="customerCare">
<%--Set header type needed for this JSP for LiveHelp.  This must be set before HeaderDisplay.jsp--%>
<c:set var="liveHelpPageType" value="personal" scope="request" />
</flow:ifEnabled>
 

<%@ include file="../include/LayoutContainerTop.jspf"%>
<table id="WC_AuctionHomeDisplay_Table_1"  border="0" cellpadding="0" cellspacing="0" width="790">
<tr>
	

	<td id="WC_AuctionHomeDisplay_TableCell_2" valign="top" width="630">


	<wcbase:useBean id="aRegister" classname="com.ibm.commerce.user.beans.UserRegistrationDataBean" >
	</wcbase:useBean>
	
	<c:set var="safname" value="" />
	<c:set var="samname" value="" />
	<c:set var="salname" value="" />
	<c:if test="${! empty aRegister.firstName }">
		<c:set var="safname" value="${aRegister.firstName}" />
	</c:if>
	<c:if test="${! empty aRegister.middleName }">
		<c:set var="samname" value="${aRegister.middleName}" />
	</c:if>
	<c:if test="${! empty aRegister.lastName }">
		<c:set var="salname" value="${aRegister.lastName}" />
	</c:if>
	
	<center>  
	<table id="WC_AuctionHomeDisplay_Table_2" cellpadding="0" cellspacing="1" border="0">
		<tr>
			<td id="WC_AuctionHomeDisplay_TableCell_3" align="center"  valign="top" colspan="2"  width="100%">
				<h1>
				<fmt:message key="AuctionHome_WelcomeMsg" bundle="${storeText}">
					<fmt:param value="${safname}" />
					<fmt:param value="${samname}" />
					<fmt:param value="${salname}" />
				</fmt:message>
				</h1>
			</td>
		</tr>
            
		<tr>
			<td id="WC_AuctionHomeDisplay_TableCell_4" width="30" align="right" valign="top"><strong>1.</strong></td>
			<td id="WC_AuctionHomeDisplay_TableCell_5" align="left">
				<strong>
					<c:set var="sURL" value="ShopperAuctionListView?storeId=${sessionStoreId}" />
					<fmt:message key="AuctionHome_Msg1" bundle="${storeText}">
						<fmt:param value="${sURL}" />
					</fmt:message>
				<br /><br />
				</strong>
			</td>
		</tr>
		
		<tr>
			<td id="WC_AuctionHomeDisplay_TableCell_6" width="30" align="right" valign="top"><strong>2.</strong></td>
			<td id="WC_AuctionHomeDisplay_TableCell_7" align="left">
				<strong>
					<c:set var="sURL" value="AuctionListView?status=F&storeId=${sessionStoreId}" />
					<fmt:message key="AuctionHome_Msg2" bundle="${storeText}">
						<fmt:param value="${sURL}" />
					</fmt:message>
				<br /><br />
				</strong>
			</td>
		</tr>
		
		<tr>
			<td id="WC_AuctionHomeDisplay_TableCell_8" width="30" align="right" valign="top"><strong>3.</strong></td>
			<td id="WC_AuctionHomeDisplay_TableCell_9" align="left">
				<strong>
					<c:set var="sURL" value="AuctionListView?status=C&storeId=${sessionStoreId}" />
					<fmt:message key="AuctionHome_Msg3" bundle="${storeText}">
						<fmt:param value="${sURL}" />
					</fmt:message>
				<br /><br />
				</strong>
			</td>
		</tr>
		
		<tr>
			<td id="WC_AuctionHomeDisplay_TableCell_10" width="30" align="right" valign="top"><strong>4.</strong></td>
			<td id="WC_AuctionHomeDisplay_TableCell_11" align="left">
				<strong>
					<c:set var="sURL" value="AuctionListView?status=BCSC&storeId=${sessionStoreId}" />
					<fmt:message key="AuctionHome_Msg4" bundle="${storeText}">
						<fmt:param value="${sURL}" />
					</fmt:message>
				<br /><br />
				</strong>
			</td>
		</tr>
		
		<tr>
			<td width="30" id="WC_AuctionHomeDisplay_TableCell_12" align="right" valign="top"><strong>5.</strong></td>
			<td id="WC_AuctionHomeDisplay_TableCell_13" align="left">
				<strong>
					<c:set var="sURL" value="ShopperAuctionListView?storeId=${sessionStoreId}" />
					<fmt:message key="AuctionHome_Msg5" bundle="${storeText}">
						<fmt:param value="${sURL}" />
					</fmt:message>
				<br /><br />
				</strong>
			</td>
		</tr>
		
		<tr>
			<td id="WC_AuctionHomeDisplay_TableCell_14" width="30" align="right" valign="top"><strong>6.</strong></td>
			<td id="WC_AuctionHomeDisplay_TableCell_15" align="left">
				<strong>
					<c:set var="sURL" value="ShopperBidListView?status=C&storeId=${sessionStoreId}" />
					<fmt:message key="AuctionHome_Msg6" bundle="${storeText}">
						<fmt:param value="${sURL}" />
					</fmt:message>
				<br /><br />
				</strong>
			</td>
		</tr> 

		<tr>
			<td id="WC_AuctionHomeDisplay_TableCell_16" width="30" align="right" valign="top"><strong>7.</strong></td>
			<td id="WC_AuctionHomeDisplay_TableCell_17" align="left">
				<strong>
					<c:set var="sURL" value="MailListView?storeId=${sessionStoreId}" />
					<fmt:message key="AuctionHome_Msg7" bundle="${storeText}">
						<fmt:param value="${sURL}" />
					</fmt:message>
				<br /><br />
				</strong>
			</td>
		</tr> 
	
	</table>
	</center>     


	</td>
</tr>
</table>

<%@ include file="../include/LayoutContainerBottom.jspf"%>
</body>
</html>
