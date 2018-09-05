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
//*Purpose: Display the form to add a new Forum Message.
//*-------------------------------------------------------------------
//*
--%>


<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../include/JSTLEnvironmentSetup.jspf"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "DTD/xhtml1-transitional.dtd">
<html>
<head>
	<title><fmt:message key="Forum_discussionTitle" bundle="${storeText}" /></title>
	<link rel="stylesheet" href="<c:out value="${fileDir}" />ToolTech.css" type="text/css" />

<script language="JavaScript">
var FormSubmitted = 0

function CheckResubmit() {           
	var form = document.compose;                  
	var msgMaxLength = 600;
	var message_length = form.body.value.length;
	
	if( form.subject.value == "" ) {              
		var msg = "<fmt:message key="Forum_subjectError" bundle="${storeText}" />";
		alert(msg);
		form.subject.focus();
		return false;
	}
	
	if( message_length > msgMaxLength) {                         
		var msg = "<fmt:message key="Forum_msgLongError" bundle="${storeText}" />";
		alert(msg);
		form.body.focus();
		return false;
	}
	
	if( FormSubmitted == 1 ) {             
		var msg= "<fmt:message key="Forum_duplicateSubmitError" bundle="${storeText}" />";
		alert(msg);
		return false;
	}
	
	FormSubmitted = 1;
	return true;
}            
</script>

</head>

<body>

<flow:ifEnabled feature="customerCare">
<%--Set header type needed for this JSP for LiveHelp.  This must be set before HeaderDisplay.jsp--%>
<c:set var="liveHelpPageType" value="personal" scope="request" />
</flow:ifEnabled>

<%@ include file="../../include/LayoutContainerTop.jspf"%>

<table border="0" cellpadding="0" cellspacing="0" width="790" id="WC_ForumAddDisplay_Table_1">
<tr>	

	<td valign="top" width="630" id="WC_ForumAddDisplay_TableCell_2">
	<c:set var="aucrfn" value="${WCParam.aucrfn}" />
	<c:set var="forum_id" value="${WCParam.forum_id}" />
	<c:set var="auctionStoreId"	value="${WCParam.auctionStoreId}" /> 
	<c:set var="viewstatus" value="P" />	
	<c:set var="msgstatus" value="A" />	
	<c:set var="inGallery" value="false" />	
	<c:set var="root_id" value="-1" />	
	<c:set var="parent_id" value="-1" />	
	
	<wcbase:useBean id="auction" classname="com.ibm.commerce.negotiation.beans.AuctionDataBean" >
		<c:set property="auctionId" value="${aucrfn}" target="${auction}" />
		<c:set property="shopperId" value="${userId}" target="${auction}" />
	</wcbase:useBean>	
	<c:set var="productOnAuction" value="true" />	
	<c:set var="auction_Status" value="${auction.status}" />	
	<c:set var="auction_Type" value="${auction.auctionType}" />	
	<c:set var="inGallery" value="${auction.inGallery}" />	
	<c:if test="${auction_Status != 'R'}">
		<c:set var="product_Desc" value="${auction.auctItemName}" />	
		<table cellpadding="0" cellspacing="8" border="0" id="WC_ForumAddDisplay_Table_2">
			<tr>
				<td align="left" valign="top" class="categoryspace" width="100%" id="WC_ForumAddDisplay_TableCell_3">
					<h1>
						<c:choose>
							<c:when test="${empty product_Desc}">
								<fmt:message key="Forum_newMessage1" bundle="${storeText}" />
							</c:when>
							<c:otherwise>
								<fmt:message key="Forum_newMessage" bundle="${storeText}">
									<fmt:param value="${product_Desc}" />
								</fmt:message>
							</c:otherwise>
						</c:choose>
					</h1>
					<hr width="100%" align="left" noshade="noshade"/> 
					<br />
				</td>
			</tr>
			<tr>
				<td align="left" id="WC_ForumAddDisplay_TableCell_4">
					<form name="compose" action="ShopperCreateForumMessage" method="post" id="compose">  
						<input type="hidden" name="ProductId"  value="<c:out value="${productId}" />" id="WC_ForumAddDisplay_ProductId_In_compose"/> 
						<input type="hidden" name="aucrfn"     value="<c:out value="${aucrfn}" />" id="WC_ForumAddDisplay_aucrfn_In_compose"/> 
						<input type="hidden" name="parent_id"  value="<c:out value="${parent_id}" />" id="WC_ForumAddDisplay_parent_id_In_compose"/> 
						<input type="hidden" name="root_id"    value="<c:out value="${root_id}" />" id="WC_ForumAddDisplay_root_id_In_compose"/> 
						<input type="hidden" name="forum_id"   value="<c:out value="${forum_id}" />" id="WC_ForumAddDisplay_forum_id_In_compose"/>
						<input type="hidden" name="URL"        value="ShopperForumMsgListView" id="WC_ForumAddDisplay_URL_In_compose"/>
						<input type="hidden" name="viewstatus" value="<c:out value="${viewstatus}" />" id="WC_ForumAddDisplay_viewstatus_In_compose"/>
						<input type="hidden" name="msgstatus"  value="<c:out value="${msgstatus}" />" id="WC_ForumAddDisplay_msgstatus_In_compose"/> 
						<label for="WC_ForumAddDisplay_subject_In_compose">
						<font class="productName">
							<fmt:message key="Forum_subject" bundle="${storeText}" />
						</font>
						</label>
						<input type="text" name="subject" size="40" maxlength="253" value="<c:out value="${subject}" />" id="WC_ForumAddDisplay_subject_In_compose"/>
						<br />
						
						<font class="productName">
							<label for="WC_ForumAddDisplay_body_In_compose">
							<fmt:message key="Forum_yourMsg" bundle="${storeText}" />
							<br />
							</label>
							<textarea name="body" cols="50" rows="5" id="WC_ForumAddDisplay_body_In_compose"></textarea>
						</font>
						<br />
						<table width=360 cellspacing=3 cellpadding=3 id="WC_ForumAddDisplay_Table_3">
							<tr>
								<td width=130 align="left" valign="middle" id="WC_ForumAddDisplay_TableCell_5">  
									<input type="submit" value="<fmt:message key="AuctionCommonText_Submit" bundle="${storeText}" />" onclick="return CheckResubmit()" />
								</td>
								<td width=130 align="left" valign="middle" id="WC_ForumAddDisplay_TableCell_6"> 
									<input type="reset" value="<fmt:message key="AuctionCommonText_Reset" bundle="${storeText}" />"  />
								</td>
					</form>
				<form action="ShopperForumMsgListView" id="ShopperForumMsgListView">
					<input type="hidden" name="aucrfn" value="<c:out value="${aucrfn}" />" id="WC_ForumAddDisplay_aucrfn_In_ShopperForumMsgListView"/> 
					<input type="hidden" name="forum_id" value="<c:out value="${forum_id}" />" id="WC_ForumAddDisplay_forum_id_In_ShopperForumMsgListView"/>              
					<input type="hidden" name="viewstatus" value="<c:out value="${viewstatus}" />" id="WC_ForumAddDisplay_viewstatus_In_ShopperForumMsgListView"/>
					<input type="hidden" name="msgstatus" value="<c:out value="${msgstatus}" />" id="WC_ForumAddDisplay_msgstatus_In_ShopperForumMsgListView"/>
			
					<td width=130 align="left" valign="middle" id="WC_ForumAddDisplay_TableCell_7">  
						<input type="submit" value="<fmt:message key="AuctionCommonText_Cancel" bundle="${storeText}" />" />
					</td>
		 		</form>
				</tr> 
			</table> 
			<table id="WC_ForumAddDisplay_Table_4">
				<c:if test="${auction_Status=='C' || inGallery == false}" >
					<tr>
				</c:if>
				<c:choose>
					<c:when test="${auction_Status=='C' && auction_Type=='O'}" >
						<td align="left" class="buttonStyle" id="WC_ForumAddDisplay_TableCell_8">
							<font class="buttonStyle">
								<a href="AutoBidCreateForm?auctionStoreId=<c:out value="${auctionStoreId}" />&aucrfn=<c:out value="${aucrfn}" />" id="WC_ForumAddDisplay_Link_1">
									<b><fmt:message key="AuctionCommonText_newAutoBid" bundle="${storeText}" />
									</b>
								</a>/
								<a href="BidCreateForm?auctionStoreId=<c:out value="${auctionStoreId}" />&aucrfn=<c:out value="${aucrfn}" />" id="WC_ForumAddDisplay_Link_2">
									<b><fmt:message key="AuctionCommonText_newBid" bundle="${storeText}" />
									</b>
								</a>
							</font>
						</td> 
					</c:when>
					<c:when test="${auction_Status=='C'}">
						<td align="left" class="buttonStyle" id="WC_ForumAddDisplay_TableCell_9">
							<font class="buttonStyle">
								<a href="BidCreateForm?auctionStoreId=<c:out value="${auctionStoreId}" />&aucrfn=<c:out value="${aucrfn}" />" id="WC_ForumAddDisplay_Link_3">
									<b><fmt:message key="AuctionCommonText_newBid" bundle="${storeText}" />
									</b>
								</a>
							</font>
						</td> 
					</c:when>
					<c:otherwise>
						<td id="WC_ForumAddDisplay_TableCell_10">
						</td>
					</c:otherwise>
				</c:choose>
				<c:if test="${inGallery == false}">
					<td align="left" class="buttonStyle" id="WC_ForumAddDisplay_TableCell_11">
						<font class="buttonStyle">
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<a href="UpdateGallery?storeId=<c:out value="${storeId}" />&aucrfn=<c:out value="${aucrfn}" />&GA=1&VR=1&URL=ShopperAuctionListView" id="WC_ForumAddDisplay_Link_4">                  
								<b><fmt:message key="Forum_addToGallery" bundle="${storeText}" />
								</b>
							</a>
						</font>
					</td>
				</c:if>
				<c:if test="${auction_Status=='C' || inGallery == false}">
					</tr>
				</c:if>
		         <tr> 
        		    <td align="left" class="buttonStyle" id="WC_ForumAddDisplay_TableCell_12">
						<font class="buttonStyle">
						<c:choose>
							<c:when test="${auction_Status=='C'}">
								<a href="ProductDisplay?storeId=<c:out value="${storeId}" />&productId=<c:out value="${productId}" />&langId=<c:out value="${lang}" />&fromAuction=true" id="WC_ForumAddDisplay_Link_5">
				                    <b><fmt:message key="Forum_gotoProduct" bundle="${storeText}" />
	        			            </b>
	                    		</a> 
							</c:when>
							<c:otherwise>
								<a href="DisplayAuctionItem?aucrfn=<c:out value="${aucrfn}" />&storeId=<c:out value="${storeId}" />&productId=<c:out value="${productId}" />&langId=<c:out value="${lang}" />&fromAuction=true" id="WC_ForumAddDisplay_Link_6">
				                    <b><fmt:message key="Forum_gotoProduct" bundle="${storeText}" />
	        			            </b>
	                    		</a> 
							</c:otherwise>
						</c:choose>
						</font>
            		</td>
		            <td align="left" class="buttonStyle" id="WC_ForumAddDisplay_TableCell_13">
						<font class="buttonStyle">
               				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			               	<b>
			               	<a href="ShopperForumMsgListView?auctionStoreId=<c:out value="${auctionStoreId}" />&aucrfn=<c:out value="${aucrfn}" />&forum_id=<c:out value="${forum_id}" />&viewstatus=<c:out value="${viewstatus}" />&msgstatus=<c:out value="${msgstatus}" />" id="WC_ForumAddDisplay_Link_7"> 
				                <fmt:message key="Forum_msgList" bundle="${storeText}" />
				            </a>
				           	</b>
						</font>
            		</td>   
         		</tr>
	      </table> 
		</td>
	</tr>
</table>
	</c:if>
	</td>
</tr>
</table>

<%@ include file="../../include/LayoutContainerBottom.jspf"%>
</body>
</html>

