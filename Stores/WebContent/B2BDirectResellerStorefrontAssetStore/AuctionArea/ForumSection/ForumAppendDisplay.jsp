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
//*Purpose: Display the form to append to a Forum Message.
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
	<title><fmt:message key="discussionTitle" bundle="${storeText}" /></title>
	<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${vfileStylesheet}"/>" type="text/css" />
</head>

<body>
<%@ include file="../../include/LayoutContainerTop.jspf"%>
<table cellpadding="0" cellspacing="0" border="0" width="600" id="WC_ForumAppendDisplay_Table_1">
	
		<tr>
			
	
		<td bgcolor="#FFFFFF" width="600" valign="top" id="WC_ForumAppendDisplay_TableCell_1">


			<c:set var="productOnAuction" value="false" />
			<c:set var="inGallery" value="false" />
			<c:set var="msgstatus" value="A" />
			<c:set var="viewstatus" value="P" />
			<c:set var="aucrfn" value="${WCParam.aucrfn}" />
			<c:set var="msg_id" value="${WCParam.msg_id}" />
		
			<wcbase:useBean id="auction" classname="com.ibm.commerce.negotiation.beans.AuctionDataBean" >
				<c:set property="auctionId" value="${aucrfn}" target="${auction}" />
				<c:set property="shopperId" value="${userId}" target="${auction}" />
			</wcbase:useBean>	

			<c:set var="productOnAuction" value="true" />
			<c:set var="auction_Status" value="${auction.status}" />
			<c:set var="auction_Type" value="${auction.auctionType}" />
			<c:set var="productId" value="${auction.entryId}" />
			<c:set var="inGallery" value="${auction.inGallery}" />
	
			<c:if test="${auction_Status != 'R'}">
				<%-- get product description --%>
				<c:set var="product_Desc" value="${auction.auctItemDesc}" />
				<wcbase:useBean id="forumMsgBean" classname="com.ibm.commerce.negotiation.beans.ForumMessageDataBean" >
					<c:set property="msgId" value="${msg_id}" target="${forumMsgBean}" />
				</wcbase:useBean>	
				<c:set var="root_id" value="${forumMsgBean.rootMsgId}" />
				<c:set var="subject" value="${forumMsgBean.msgSubject}" />
				<c:set var="body" value="${forumMsgBean.msgBody}" />
				<c:set var="parent_id" value="${forumMsgBean.parentMsgId}" />
				<c:set var="forum_id" value="${forumMsgBean.forumId}" />
				<c:set var="posterId" value="${forumMsgBean.posterId}" />
				<c:set var="postTime" value="${forumMsgBean.formattedPostTime}" />
			
				<c:set var="safname" value="${forumMsgBean.userInfoDataBean.firstName}" />							
				<c:set var="samname" value="${forumMsgBean.userInfoDataBean.middleName}" />							
				<c:set var="salname" value="${forumMsgBean.userInfoDataBean.lastName}" />
				
				<c:set var="msgviewstatus" value="${forumMsgBean.viewStatus}" />
				<c:if test="${!(posterId != userId && msgviewstatus != 'P')}">
					<c:if test="${empty subject}">
				       	<c:set var="subject">
							<fmt:message key="Forum_msgFrom" bundle="${storeText}" >
								<fmt:param value="${safname}" />
								<fmt:param value="${salname}" />
							</fmt:message>
						</c:set>
					</c:if>


					<table cellpadding="1" cellspacing="2" width="600" border="0" id="WC_ForumAppendDisplay_Table_2">
						<tr>
							<td width="10" id="WC_ForumAppendDisplay_TableCell_2">&nbsp;</td>
							<td align="left" valign="top" class="categoryspace" width="580" id="WC_ForumAppendDisplay_TableCell_3">
								<font class="pageHeading">
									<c:choose>
										<c:when test="${empty product_Desc}">
											<fmt:message key="discussionOn1" bundle="${storeText}"/>
										</c:when>
										<c:otherwise>
											<fmt:message key="discussionOn" bundle="${storeText}">
												<fmt:param value="${product_Desc}" />
											</fmt:message>
										</c:otherwise>
									</c:choose>
								
								</font>
								<hr width="100%" noshade="noshade" align="left" /> 
								<br />
							</td>
						</tr>
						<tr>
							<td width="10" id="WC_ForumAppendDisplay_TableCell_4">&nbsp;</td>
							<td align="left" id="WC_ForumAppendDisplay_TableCell_5">   
							<font class="productName">
								<fmt:message key="messageId" bundle="${storeText}">
									<fmt:param value="${msg_id}" />
								</fmt:message>
							</font>   
							<br />
							<font class="productName">
								<fmt:message key="composedBy" bundle="${storeText}">
									<fmt:param value="${safname}" />
									<fmt:param value="${samname}" />
									<fmt:param value="${salname}" />
									<fmt:param value="${postTime}" />
								</fmt:message>	
							</font>
							<br />
							<font class="productName">
								<fmt:message key="subjectId" bundle="${storeText}">
									<fmt:param value="${subject}" />
								</fmt:message>
								<br />
								<c:out value="${body}" />
								<br />
							</font>
					
							<hr width="100%" noshade="noshade" align="left" /> 
					
							<table width=400 cellspacing=3 cellpadding=3 id="WC_ForumAppendDisplay_Table_3"> 
								<tr>
									<td width=320 align="left"id="WC_ForumAppendDisplay_TableCell_9">
										<font class="productName">
											<fmt:message key="respondMsg" bundle="${storeText}" />
										</font>
									</td>
								</tr>
							</table>

							<form name="compose" action="ShopperCreateForumMessage" id="WC_ForumAppendDisplay_compose">
								<input type="hidden" name="ProductId" value="<c:out value="${productId}" />" id="WC_ForumAppendDisplay_ProductId_in_compose"/> 
								<input type="hidden" name="aucrfn" value="<c:out value="${aucrfn}" />" id="WC_ForumAppendDisplay_aucrfn_in_compose"/> 
								<input type="hidden" name="parent_id" value="<c:out value="${parent_id}" />" id="WC_ForumAppendDisplay_parent_id_in_compose"/> 
								<input type="hidden" name="root_id" value="<c:out value="${root_id}" />" id="WC_ForumAppendDisplay_root_id_in_compose"/> 
								<input type="hidden" name="forum_id" value="<c:out value="${forum_id}" />" id="WC_ForumAppendDisplay_forum_id_in_compose"/>
								<input type="hidden" name="URL" value="ShopperForumMsgListView" id="WC_ForumAppendDisplay_URL_in_compose"/>
								<input type="hidden" name="viewstatus" value="<c:out value="${viewstatus}" />" id="WC_ForumAppendDisplay_viewstatus_in_compose"/>
								<input type="hidden" name="msgstatus" value="<c:out value="${msgstatus}" />" id="WC_ForumAppendDisplay_msgstatus_in_compose"/> 
								<input type="hidden" name="msg_id" value="<c:out value="${msg_id}" />" id="WC_ForumAppendDisplay_msg_id_in_compose"/>  
								<input type="hidden" name="catalogId" value='<c:out value="${catalogId}" />' id="WC_ForumAppendDisplay_catalogId_In_compose"/> 
								<label for="WC_ForumAppendDisplay_subject_in_compose">
								<font class="productName">
									<fmt:message key="subject" bundle="${storeText}" />
								</font>
								</label>
								<input type="text" name="subject" size="40" maxlength="253" value="<c:out value="${subject}" />" id="WC_ForumAppendDisplay_subject_in_compose"/>
								<br />
								<label for="WC_ForumAppendDisplay_body_in_compose">
								<font class="productName">
									<fmt:message key="yourMsg" bundle="${storeText}" />
								</font>
								</label>
								<br />
								<textarea name="body" cols="50" rows="5" id="WC_ForumAppendDisplay_body_in_compose"></textarea>
								<br />
								<table width="360" cellspacing="3" cellpadding="3" id="WC_ForumAppendDisplay_Table_4">
									<tr>
										<td class="button" align="left" valign="middle" id="WC_ForumAppendDisplay_TableCell_6">
										<a	class="button" href="javascript:submitForm(document.compose)" id="WC_ForumAppendDisplay_Link_6">
										<fmt:message key="submit" bundle="${storeText}" /> 
										</a>
										</td>
										<td class="button" align="left" valign="middle" id="WC_ForumAppendDisplay_TableCell_7">
										<a	class="button" href="javascript:clearForm(document.compose)" id="WC_ForumAppendDisplay_Link_7">
										<fmt:message key="reset" bundle="${storeText}" /> 
										</a>
										</td>
										<td class="button" align="left" valign="middle" id="WC_ForumAppendDisplay_TableCell_8">
										<c:url value="ShopperForumMsgListView" var="shopperForumMsgListViewUrl">
											<c:param name="aucrfn" value="${aucrfn}"/>
											<c:param name="catalogId" value="${catalogId}"/>
											<c:param name="viewstatus" value="${viewstatus}"/>
											<c:param name="forum_id" value="${forum_id}"/>	
											<c:param name="msgstatus" value="${msgstatus}"/>							
										</c:url>						
										<a	class="button" href="<c:out value="${shopperForumMsgListViewUrl}" />" id="WC_ForumAppendDisplay_Link_8">
										<fmt:message key="cancel" bundle="${storeText}" /> 
										</a>
										</td>
										  
									</tr> 
								</table>  
								</form>    
						    	<table id="WC_ForumAppendDisplay_Table_5">
						    		<c:if test="${auction_Status == 'C' || inGallery == false}" >
						    			<tr>
						    		
							    		<c:choose>
										<c:when test="${auction_Status == 'C' && auction_Type == 'O'}">
								            <td align="left" class="buttonStyle" id="WC_ForumAppendDisplay_TableCell_10">
												<font class="buttonStyle">
													<a href="AutoBidCreateForm?storeId=<c:out value="${storeId}" />&catalogId=<c:out value="${catalogId}" />&aucrfn=<c:out value="${aucrfn}" />" id="WC_ForumAppendDisplay_Link1">
														<b>
														<fmt:message key="newAutoBid" bundle="${storeText}" />
														</b>
													</a>/
													<a href="BidCreateForm?storeId=<c:out value="${storeId}" />&catalogId=<c:out value="${catalogId}" />&aucrfn=<c:out value="${aucrfn}" />" id="WC_ForumAppendDisplay_Link2">
														<b>
														<fmt:message key="newBid" bundle="${storeText}" />
														</b>
													</a>
												</font>
								            </td> 
										</c:when>
										<c:when test="${auction_Status =='C'}">
									        <td align="left" class="buttonStyle" id="WC_ForumAppendDisplay_TableCell_11">
												<font class="buttonStyle">
											      <a href="BidCreateForm?storeId=<c:out value="${storeId}" />&catalogId=<c:out value="${catalogId}" />&aucrfn=<c:out value="${aucrfn}" />" id="WC_ForumAppendDisplay_Link3">
												      <b>
														<fmt:message key="newBid" bundle="${storeText}" />
												      </b>
												  </a>
												</font>
			          						</td> 
										</c:when>
										<c:otherwise>
											<td id="WC_ForumAppendDisplay_TableCell_12">
								            </td>
										</c:otherwise>
										</c:choose>
										<c:if test="${inGallery == false}">
								            <td align="left" class="buttonStyle" id="WC_ForumAppendDisplay_TableCell_13">
												<font class="buttonStyle">										              
										            <a href="UpdateGallery?storeId=<c:out value="${storeId}" />&catalogId=<c:out value="${catalogId}" />&aucrfn=<c:out value="${aucrfn}" />&GA=1&VR=1&URL=ShopperAuctionListView" id="WC_ForumAppendDisplay_Link4">
											            <b>
														<fmt:message key="addToGallery" bundle="${storeText}" />
											           	</b>
											        </a>
												</font>
								            </td>
										</c:if>
									
										</tr>
									</c:if>         
						        	<tr> 
							            <td align="left" class="buttonStyle" id="WC_ForumAppendDisplay_TableCell_14">
											<font class="buttonStyle">
												<c:choose>
													<c:when test="${auction_Status == 'C'}">
														<a href="ProductDisplay?storeId=<c:out value="${storeId}" />&catalogId=<c:out value="${catalogId}" />&productId=<c:out value="${productId}" />&langId=<c:out value="${langId}" />&fromAuction=true" id="WC_ForumAppendDisplay_Link5">
															<b>
															<fmt:message key="gotoProduct" bundle="${storeText}" />
															</b>
														</a>	
													</c:when>
													<c:otherwise>
														<a href="DisplayAuctionItem?aucrfn=<c:out value="${aucrfn}" />&storeId=<c:out value="${storeId}" />&catalogId=<c:out value="${catalogId}" />&productId=<c:out value="${productId}" />&langId=<c:out value="${langId}" />&fromAuction=true" id="WC_ForumAppendDisplay_Link6">
															<b>
															<fmt:message key="gotoProduct" bundle="${storeText}" />
															</b>
														</a>	
													</c:otherwise>												
												</c:choose>
											</font>
							            </td>
							            <td align="left" class="buttonStyle" id="WC_ForumAppendDisplay_TableCell_15">
											<font class="buttonStyle">								              
									           <b>
									           	<a href="ShopperAddMsgView?storeId=<c:out value="${storeId}" />&catalogId=<c:out value="${catalogId}" />&forum_id=<c:out value="${forum_id}" />&aucrfn=<c:out value="${aucrfn}" />" id="WC_ForumAppendDisplay_Link7"> 
													<fmt:message key="addNewMessage" bundle="${storeText}" />
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
			</c:if>	

		</td>
	</tr>
	
</table>

<%@ include file="../../include/LayoutContainerBottom.jspf"%>


<script language="JavaScript">
var FormSubmitted = 0

function CheckResubmit() {         
	var form = document.compose;
	var msgMaxLength = 600;
	var message_length = form.body.value.length;
	
	if( form.subject.value == "" ) {              
		var msg = "<fmt:message key="subjectError" bundle="${storeText}" />";
		alert(msg);
		form.subject.focus();
		return false;
	}
	
	if( message_length > msgMaxLength) {                  
		var msg = "<fmt:message key="msgLongError" bundle="${storeText}" />";
		alert(msg);
		form.body.focus();
		return false;
	}
	
	if( FormSubmitted == 1 ) {              
		var msg = "<fmt:message key="duplicateSubmitError" bundle="${storeText}" />";
		alert(msg)
		return false
	}
	
	FormSubmitted = 1
	return true
}
function clearForm(form) {	
	for (i=0; i<form.elements.length; i++) {  
		elem = form.elements[i];
		if ( (elem.name == "subject" ) || (elem.name == "body") ){
			elem.value="";
		}
	}
}  
function submitForm(form) {
	if(CheckResubmit()==true){
		form.submit();
	}
}                       
</script>
</body>
</html>

