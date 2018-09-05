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


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "DTD/xhtml1-transitional.dtd">
<html>
<head>
	<meta http-equiv="Expires" content="Mon, 01 Jan 1996 01:01:01 GMT" />
	<title><fmt:message key="Forum_discussionTitle" bundle="${storeText}" /></title>
	<link rel="stylesheet" href="<c:out value="${fileDir}" />ToolTech.css" type="text/css" />
</head>

<body>

<flow:ifEnabled feature="customerCare">
<%--Set header type needed for this JSP for LiveHelp.  This must be set before HeaderDisplay.jsp--%>
<c:set var="liveHelpPageType" value="personal" scope="request" />
</flow:ifEnabled>


<%@ include file="../../include/LayoutContainerTop.jspf"%>
<table border="0" cellpadding="0" cellspacing="0" width="790" id="WC_ForumListDisplay_Table_1">
<tr>	

	<td valign="top" width="630" id="WC_ForumListDisplay_TableCell_2">

	<c:set var="isFirstRes1" value="true" />	
	<c:set var="needTableCloseing" value="false" />	
	<c:set var="needULCloseing" value="false" />	
	<c:set var="productOnAuction" value="true" />	
	<c:set var="inGallery" value="false" />	
	<c:set var="isNewMsgChain" value="true" />
	<c:set var="auctionStoreId" value="${WCParam.auctionStoreId}"/>
	<c:set var="count" value="15" />	
	<%-- Number of Auctions to be displayed per page  --%>
	<c:set var="aucrfn" value="${WCParam.aucrfn}" />	
	<c:set var="forum_id" value="${WCParam.forum_id}" />	
	<c:set var="target_id" value="${WCParam.aucrfn}" />	
	<c:set var="msgstatus" value="${WCParam.msgstatus}" />	
	<c:set var="viewstatus" value="${WCParam.viewstatus}" />	
	<c:set var="strNext" value="${WCParam.next}" />	
	<c:if test="${empty strNext}">
		<c:set var="strNext" value="0" />	
	</c:if>

	<fmt:parseNumber var="strNext" type="number" value="${strNext}" />
	<c:set var="start" value="${strNext}" />

	<wcbase:useBean id="auction" classname="com.ibm.commerce.negotiation.beans.AuctionDataBean" >
		<c:set property="auctionId" value="${aucrfn}" target="${auction}" />
		<c:set property="shopperId" value="${userId}" target="${auction}" />
	</wcbase:useBean>	
	<c:set var="auction_Status" value="${auction.status}" />
	<c:set var="auction_Type" value="${auction.auctionType}" />
	<c:set var="productId" value="${auction.entryId}" />
	<c:if test="${auction_Status!='R'}">
		<c:set var="inGallery" value="${auction.inGallery}" />
		<c:set var="product_Desc" value="${auction.auctItemDesc}" />
		<table cellpadding="0" cellspacing="8" border="0" id="WC_ForumListDisplay_Table_2">
			<tr>
				<td align="left" valign="top" colspan="0" class="categoryspace" width="100%" id="WC_ForumListDisplay_TableCell_3">
					<h1>
						<c:choose>
							<c:when test="${empty product_Desc}">
								<fmt:message key="Forum_discussionOn1" bundle="${storeText}" />
							</c:when>
							<c:otherwise>
								<fmt:message key="Forum_discussionOn" bundle="${storeText}">
									<fmt:param value="${product_Desc}" />
								</fmt:message>
							</c:otherwise>
						</c:choose>
					</h1>
					<hr width="100%" noshade="noshade" align="left" /> 
					<br />
				</td>
			</tr>
			<tr>
				<td id="WC_ForumListDisplay_TableCell_4">
					<wcbase:useBean id="forumMsgListBean" classname="com.ibm.commerce.negotiation.beans.ForumMessageLightListBean" >
						<c:set property="forumId" value="${forum_id}" target="${forumMsgListBean}" />
						<c:set property="targetId" value="${target_id}" target="${forumMsgListBean}" />
						<c:set property="msgStatus" value="${msgstatus}" target="${forumMsgListBean}" />
						<c:set property="viewStatus" value="${viewstatus}" target="${forumMsgListBean}" />
						<c:set property="posterId" value="${userId}" target="${forumMsgListBean}" />
						<c:set property="sortAttByString" value="ROOTMSG_ID;PARENTMSG_ID;POSTTIME" target="${forumMsgListBean}" />
					</wcbase:useBean>	
					<c:set var="length" value="${forumMsgListBean.messagesNum}" />
					<c:set var="msgCount" value="${length}" />
					<c:if test="${msgCount == 1}">
						<c:forEach var="adb" items="${forumMsgListBean.forumMessageBeans}" begin="0" end="0">
							<c:set var="msg_id" value="${adb.id}" />
						</c:forEach>
					</c:if>
					<c:set var="end" value="${start+count}" />
					<c:if test="${end > length}">
						<c:set var="end" value="${length}" />
					</c:if>
					<c:forEach var="aForumMessageLight" items="${forumMsgListBean.forumMessageBeans}" begin="${start}" end="${end}" varStatus="aStatus">
						<c:set var="msg_id" value="${aForumMessageLight.id}" />
						<c:set var="root_id" value="${aForumMessageLight.rootMsgId}" />
						<c:set var="subject" value="${aForumMessageLight.msgSubject}" />
						<c:set var="posterId" value="${aForumMessageLight.posterId}" />
						<c:set var="postTime" value="${aForumMessageLight.formattedPostTime}" />
						
						<c:set var="safname" value="${aForumMessageLight.userInfoDataBean.firstName}" />							
						<c:set var="samname" value="${aForumMessageLight.userInfoDataBean.middleName}" />							
						<c:set var="salname" value="${aForumMessageLight.userInfoDataBean.lastName}" />
						
						<%-- if root_id is equal to msg_id, it means that it is a new message chain --%>
						<c:if test="${root_id == msg_id}">
							<%-- reset flags --%>
							<c:set var="isFirstRes1" value="true" />
							<c:if test="${needULCloseing == true}">
								<br />
							</c:if>
							<%-- reset flags --%>
							<c:set var="needULCloseing" value="false" />
							<%-- This is the close tag of a MsgChain after the MsgChain finishes and before the next chain starts --%>
							<c:if test="${needTableCloseing==true}">
									</td></tr></table>		
							</c:if>
							<%-- reset flags --%>
							<c:set var="needTableCloseing" value="true" />
							<%-- Start the next MsgChain --%>
							<table id="WC_ForumListDisplay_Table_3_<c:out value="${aStatus.count}"/>">
								<tr>
									<td id="WC_ForumListDisplay_TableCell_5_<c:out value="${aStatus.count}"/>">
										<font class="text">
											<c:choose>
												<c:when test="${(! empty salname  ) && (! empty safname)}">
													<c:out value="${msg_id}" />&nbsp;<i>												
													<fmt:message key="Forum_postedBy" bundle="${storeText}" >
														<fmt:param value="${safname}" />
														<fmt:param value="${salname}" />
														<fmt:param value="${postTime}" />
													</fmt:message>
													</i>
												</c:when>
												<c:when test="${(! empty salname ) && ( empty safname  )}" >
													<c:out value="${msg_id}" />&nbsp;<i>												
													<fmt:message key="Forum_postedBy1" bundle="${storeText}" >
														<fmt:param value="${salname}" />
														<fmt:param value="${postTime}" />
													</fmt:message>
													</i>
												</c:when>
											<c:when test="${(! empty safname  ) && ( empty salname )}" >
												<c:out value="${msg_id}" />&nbsp;<i>												
													<fmt:message key="Forum_postedBy1" bundle="${storeText}" >
														<fmt:param value="${safname}" />
														<fmt:param value="${postTime}" />
													</fmt:message>
													</i>
												</c:when>
												<c:otherwise>
													<c:out value="${msg_id}" />&nbsp;<i>												
													<fmt:message key="Forum_postedOn" bundle="${storeText}" >
														<fmt:param value="${postTime}" />
													</fmt:message>
													</i>
												</c:otherwise>
											</c:choose>
											<font class="product">
												<a href="ShopperAppendMsgView?auctionStoreId=<c:out value="${auctionStoreId}" />&msg_id=<c:out value="${msg_id}" />&aucrfn=<c:out value="${aucrfn}" />" id="WC_ForumListDisplay_Link_1_<c:out value="${aStatus.count}"/>"> 
													<c:out value="${subject}" />
												</a>
											</font>
								</c:if>
								<%-- This is a response for the original message --%>
								<c:if test="${root_id != msg_id}">
									<c:if test="${isFirstRes1 == true}">
										<ul>
											<c:set var="isFirstRes1" value="false" />
											<c:set var="needULCloseing" value="true" />
									</c:if>
									<c:choose>
										<c:when test="${( ! empty salname ) && ( ! empty safname ) }">
											<li>
												<c:out value="${msg_id}" /> &nbsp; <i>
													<fmt:message key="Forum_repliedBy" bundle="${storeText}" >
														<fmt:param value="${safname}" />
														<fmt:param value="${salname}" />
														<fmt:param value="${postTime}" />
													</fmt:message>
												<font class="product">
													<a href="ShopperAppendMsgView?auctionStoreId=<c:out value="${auctionStoreId}" />&msg_id=<c:out value="${msg_id}" />&aucrfn=<c:out value="${aucrfn}" />" id="WC_ForumListDisplay_Link_2_<c:out value="${aStatus.count}"/>">
														<c:out value="${subject}" />
													</a>
												</font>		
										</c:when>
										<c:when test="${( ! empty salname ) && ( empty safname) }">
											<li>
												<c:out value="${msg_id}" /> &nbsp; <i>
													<fmt:message key="Forum_repliedBy1" bundle="${storeText}" >
														<fmt:param value="${salname}" />
														<fmt:param value="${postTime}" />
													</fmt:message>
												<font class="product">
													<a href="ShopperAppendMsgView?auctionStoreId=<c:out value="${auctionStoreId}" />&msg_id=<c:out value="${msg_id}" />&aucrfn=<c:out value="${aucrfn}" />" id="WC_ForumListDisplay_Link_3_<c:out value="${aStatus.count}"/>">
														<c:out value="${subject}" />
													</a>
												</font>		
										</c:when>
										<c:when test="${( ! empty safname ) && ( empty salname )}">
											<li>
												<c:out value="${msg_id}" /> &nbsp; <i>
													<fmt:message key="Forum_repliedBy1" bundle="${storeText}" >
														<fmt:param value="${safname}" />
														<fmt:param value="${postTime}" />
													</fmt:message>
												<font class="product">
													<a href="ShopperAppendMsgView?auctionStoreId=<c:out value="${auctionStoreId}" />&msg_id=<c:out value="${msg_id}" />&aucrfn=<c:out value="${aucrfn}" />" id="WC_ForumListDisplay_Link_4_<c:out value="${aStatus.count}"/>">
														<c:out value="${subject}" />
													</a>
												</font>		
										</c:when>
										<c:otherwise>
											<li>
												<c:out value="${msg_id}" /> &nbsp; <i>
													<fmt:message key="Forum_repliedOn" bundle="${storeText}" >
														<fmt:param value="${postTime}" />
													</fmt:message>
												<font class="product">
													<a href="ShopperAppendMsgView?auctionStoreId=<c:out value="${auctionStoreId}" />&msg_id=<c:out value="${msg_id}" />&aucrfn=<c:out value="${aucrfn}" />" id="WC_ForumListDisplay_Link_5_<c:out value="${aStatus.count}"/>">
														<c:out value="${subject}" />
													</a>
												</font>		
										</c:otherwise>
									</c:choose>
								</c:if>
					</c:forEach>
				<%-- This is the close tag of the very first MsgChain --%>	
				<c:if test="${needTableCloseing == true}">
					<c:if test="${needULCloseing == true}">
						</ul>
					</c:if>
						</font>
					</td></tr>
					</table>
				</c:if>
				<c:set var="nextStartPt" value="${end}" />			
				<c:set var="prevStartPt" value="${start - count}" />			
<br />
<table cellpadding="3" cellspacing="0" border="0" id="WC_ForumListDisplay_Table_4">
<tr>
	<c:if test="${prevStartPt >= 0}" >
		<td align="center" valign="middle" class="buttonStyle" id="WC_ForumListDisplay_TableCell_6">
			<font class="buttonStyle">
			<a href="ShopperForumMsgListView?auctionStoreId=<c:out value="${auctionStoreId}" />&aucrfn=<c:out value="${aucrfn}" />&forum_id=<c:out value="${forum_id}" />&viewstatus=P&msgstatus=A&next=<c:out value="${prevStartPt}" />" id="WC_ForumListDisplay_Link_6">
				&lt;
				<fmt:message key="AuctionCommonText_Previous" bundle="${storeText}" />
			</a>&nbsp;&nbsp;&nbsp;&nbsp;
			</font>
		</td> 
	</c:if>
	<c:if test="${nextStartPt < length}" >
		<td align="center" valign="middle" class="buttonStyle" id="WC_ForumListDisplay_TableCell_7">
			<font class="buttonStyle">
			<a href="ShopperForumMsgListView?auctionStoreId=<c:out value="${auctionStoreId}" />&aucrfn=<c:out value="${aucrfn}" />&forum_id=<c:out value="${forum_id}" />&viewstatus=P&msgstatus=A&next=<c:out value="${nextStartPt}" />" id="WC_ForumListDisplay_Link_7">
				<fmt:message key="AuctionCommonText_Next" bundle="${storeText}" />
				&gt;
			</a>
			</font>
		</td> 
	</c:if>	
</tr>
</table>   
<table cellpadding="3" cellspacing="0" border="0" id="WC_ForumListDisplay_Table_5">
	<c:if  test="${auction_Status == 'C' || inGallery == false}">
		<tr>
	</c:if>
	<c:choose>
		<c:when test="${auction_Status=='C' && auction_Type=='O'}">
			<td align="left" class="buttonStyle" id="WC_ForumListDisplay_TableCell_8">
				<font class="buttonStyle">
				<a href="AutoBidCreateForm?auctionStoreId=<c:out value="${auctionStoreId}" />&aucrfn=<c:out value="${aucrfn}" />" id="WC_ForumListDisplay_Link_8">
					<b>
						<fmt:message key="AuctionCommonText_newAutoBid" bundle="${storeText}" />
					</b>
				</a>/
				<a href="BidCreateForm?auctionStoreId=<c:out value="${auctionStoreId}" />&aucrfn=<c:out value="${aucrfn}" />" id="WC_ForumListDisplay_Link_9">
					<b>
						<fmt:message key="AuctionCommonText_newBid" bundle="${storeText}" />
					</b>
				</a>
				</font>
			</td> 
		</c:when>
		<c:when test="${auction_Status == 'C'}">
			<td align="left" class="buttonStyle" id="WC_ForumListDisplay_TableCell_9">
				<font class="buttonStyle">
				<a href="BidCreateForm?auctionStoreId=<c:out value="${auctionStoreId}" />&aucrfn=<c:out value="${aucrfn}" />" id="WC_ForumListDisplay_Link_10">
					<b>
						<fmt:message key="AuctionCommonText_newBid" bundle="${storeText}" />
					</b>
				</a>
				</font>
			</td> 
		</c:when>	
		<c:otherwise>
			<td id="WC_ForumListDisplay_TableCell_10">
			</td>
		</c:otherwise>
	</c:choose>		
	<c:if test="${inGallery == false}">
		<td align="left" class="buttonStyle" id="WC_ForumListDisplay_TableCell_11">
			<font class="buttonStyle">
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<a href="UpdateGallery?storeId=<c:out value="${storeId}" />&aucrfn=<c:out value="${aucrfn}" />&GA=1&VR=1&URL=ShopperAuctionListView" id="WC_ForumListDisplay_Link_11">
				<b>
					<fmt:message key="Forum_addToGallery" bundle="${storeText}" />
				</b>
			</a>
			</font>
		</td>
	</c:if>
	<c:if test="${auction_Status=='C' || inGallery == false}">
		</tr>
	</c:if>
	<tr> 
		<td align="left" bgcolor="#ea2b2b" class="buttontext" id="WC_ForumListDisplay_TableCell_12">
			<font color="#ffffff">
				<b>
					<c:if test="${auction_Status == 'C'}">
						<a href="ProductDisplay?storeId=<c:out value="${storeId}" />&productId=<c:out value="${productId}" />&langId=<c:out value="${langId}" />&fromAuction=true"
							 style="color:#ffffff; text-decoration : none;" id="WC_ForumListDisplay_Link_12">
						<fmt:message key="Forum_gotoProduct" bundle="${storeText}" />
						</a>
					</c:if>
					<c:if test="${auction_Status != 'C'}">
						<a href="DisplayAuctionItem?aucrfn=<c:out value="${aucrfn}" />&storeId=<c:out value="${storeId}" />&productId=<c:out value="${productId}" />&langId=<c:out value="${langId}" />&fromAuction=true"
							 style="color:#ffffff; text-decoration : none;" id="WC_ForumListDisplay_Link_13">
						<fmt:message key="Forum_gotoProduct" bundle="${storeText}" />
						</a>
					</c:if>
							
				</b>
			</font>
		</td>            
		<td align="left" bgcolor="#ea2b2b" class="buttontext" id="WC_ForumListDisplay_TableCell_13">
			<font color="#ffffff">
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
			<b>
				<a href="ShopperAddMsgView?auctionStoreId=<c:out value="${auctionStoreId}" />&ProductId=<c:out value="${productId}" />&aucrfn=<c:out value="${aucrfn}" />&msgstatus=<c:out value="${msgstatus}" />&viewstatus=<c:out value="${viewstatus}" />&forum_id=<c:out value="${forum_id}" />"
					 style="color:#ffffff; text-decoration : none;" id="WC_ForumListDisplay_Link_14">
					<fmt:message key="Forum_addNewMessage" bundle="${storeText}" />
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
