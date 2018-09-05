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
//*Purpose: Display the contents of a message.
//*-------------------------------------------------------------------
//*
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../include/JSTLEnvironmentSetup.jspf"%>

<c:set var="storeId" value="${CommandContext.store.storeEntityId}" />

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "DTD/xhtml1-transitional.dtd">
<html>
<head>
	<meta http-equiv="Expires" http-equiv="Mon, 01 Jan 1996 01:01:01 GMT"/>
	<title><fmt:message key="AuctionMail_Title" bundle="${storeText}" /></title>
	<link rel="stylesheet" href="<c:out value="${fileDir}"/>ToolTech.css" type="text/css"/>
</head>

<body>

<flow:ifEnabled feature="customerCare">
<%--Set header type needed for this JSP for LiveHelp.  This must be set before HeaderDisplay.jsp--%>
<c:set var="liveHelpPageType" value="personal" scope="request" />
</flow:ifEnabled>

<%@ include file="../../include/LayoutContainerTop.jspf"%>

<table border="0" cellpadding="0" cellspacing="0" width="790" id="WC_MailDisplay_Table_1">
<tr>	

	<td valign="top" width="630" id="WC_MailDisplay_TableCell_2">
		<c:set var="msgrfn" value="${WCParam.msgrfn}" />
		<c:if test="${! empty msgrfn}">
			<wcbase:useBean id="msg" classname="com.ibm.commerce.negotiation.beans.MessageInfoDataBean" >
				<c:set property="messageId" value="${msgrfn}" target="${msg}" />
				<c:set property="msgRecipientId" value="${userId}" target="${msg}" />
			</wcbase:useBean>
			<c:set var="msg_Status" value="${msg.status}" />			
			<c:set var="formattedMsgdate" value="${msg.formattedPostTime}" />			
			<c:set var="msg_Subject" value="${msg.subject}" />			
			<c:set var="msg_Type" value="${msg.msgType}" />			
			<c:set var="msg_Param1" value="${msg.msgParam1}" />			
			<c:set var="msg_Param2" value="${msg.msgParam2}" />			
			<c:set var="msg_Content" value="${msg.content}" />			
			<table border="3" width="600" cellpadding="5" id="WC_MailDisplay_Table_1">
				<tr>
					<td align="left" id="WC_MailDisplay_TableCell_3">
						<font class="strongtext">	
							<fmt:message key="AuctionMail_msgSubject" bundle="${storeText}" >
								<fmt:param value="${msg_Subject}" />
							</fmt:message>
						</font>
					</td>
				</tr>
				<tr>
					<td align="left" id="WC_MailDisplay_TableCell_4">
						<font class="strongtext">	
							<b>&nbsp;&nbsp;&nbsp; 
							<fmt:message key="AuctionMail_msgDate" bundle="${storeText}" >
								<fmt:param value="${formattedMsgdate}" />
							</fmt:message>
							</b>
						</font>
					</td>
				</tr>
				<tr>
					<td align="left" id="WC_MailDisplay_TableCell_5">
						<font class="text">						
							<c:choose>
								<c:when test="${msg_Type=='1'}">
									<c:set var="aucrfn" value="${msg_Param2}" />
								</c:when>
								<c:otherwise>
									<c:if test="${msg_Type=='2' || msg_Type=='4' || msg_Type == '5'}">
										<c:set var="bidId" value="${msg_Param1}" />
										<wcbase:useBean id="aBid" classname="com.ibm.commerce.negotiation.beans.BidDataBean" >
											<c:set property="bidId" value="${bidId}" target="${aBid}" />
										</wcbase:useBean>
										<c:set var="aucrfn" value="${aBid.auctionId}" />
										<c:set var="bidrfn" value="${aBid.referenceCode}" />
									</c:if>
								</c:otherwise>
							</c:choose>							
							<wcbase:useBean id="anAuction" classname="com.ibm.commerce.negotiation.beans.AuctionDataBean" >
								<c:set property="auctionId" value="${aucrfn}" target="${anAuction}" />
							</wcbase:useBean>
							<c:set var="austatus" value="${anAuction.status}" />
							<c:set var="productId" value="${anAuction.entryId}"/>
							<c:set var="product_Desc" value="${anAuction.auctItemDesc}" />
							<c:choose>
								<%-- display messages depending on message type --%>
								<c:when test="${msg_Type=='1'}">
      				            	<br /> 
      				            	<c:choose>
      				            		<c:when test="${austatus=='C'}">
											<fmt:message key="AuctionMail_auctionStartMsg1" bundle="${storeText}" >
												<fmt:param value="${storeId}" />
												<fmt:param value="${productId}" />
												<fmt:param value="${langId}" />
												<fmt:param value="${product_Desc}" />
											</fmt:message>
      				            		</c:when>
      				            		<c:otherwise>
											<fmt:message key="AuctionMail_auctionStartMsg2" bundle="${storeText}" >
												<fmt:param value="${storeId}" />
												<fmt:param value="${productId}" />
												<fmt:param value="${langId}" />
												<fmt:param value="${aucrfn}" />
												<fmt:param value="${product_Desc}" />
											</fmt:message>
      				            		</c:otherwise>
      				            	</c:choose>
									<br />
                              		<br /> 
									<fmt:message key="AuctionMail_rulesMsg" bundle="${storeText}" >
										<fmt:param value="${storeId}" />
										<fmt:param value="${aucrfn}" />
									</fmt:message>
                              		<br />
      							</c:when>
      							<c:when test="${msg_Type=='2'}">
									<br /> 
									<b>
									<fmt:message key="AuctionMail_winnerMsg1" bundle="${storeText}" />
									</b>
									<br />
									<br /> 
      				            	<c:choose>
      				            		<c:when test="${austatus=='C'}">
											<fmt:message key="AuctionMail_msgAucItemLink1" bundle="${storeText}" >
												<fmt:param value="${storeId}" />
												<fmt:param value="${productId}" />
												<fmt:param value="${langId}" />
												<fmt:param value="${product_Desc}" />
											</fmt:message>
      				            		</c:when>
      				            		<c:otherwise>
											&nbsp;&nbsp;&nbsp; 
											<fmt:message key="AuctionMail_msgAucItemLink2" bundle="${storeText}" >
												<fmt:param value="${storeId}" />
												<fmt:param value="${productId}" />
												<fmt:param value="${langId}" />
												<fmt:param value="${aucrfn}" />
												<fmt:param value="${product_Desc}" />
											</fmt:message>
      				            		</c:otherwise>
      				            	</c:choose>
									<br />
									<br /> 
									<fmt:message key="AuctionMail_winnerMsg3" bundle="${storeText}" />
									<br />     
      							</c:when>
      							<c:when test="${msg_Type=='4'}">
									<br />
      				            	<c:choose>
      				            		<c:when test="${austatus=='C'}">
											<fmt:message key="AuctionMail_msgAucItemLink1" bundle="${storeText}" >
												<fmt:param value="${storeId}" />
												<fmt:param value="${productId}" />
												<fmt:param value="${langId}" />
												<fmt:param value="${product_Desc}" />
											</fmt:message>
      				            		</c:when>
      				            		<c:otherwise>
											&nbsp;&nbsp;&nbsp; 
											<fmt:message key="AuctionMail_msgAucItemLink2" bundle="${storeText}" >
												<fmt:param value="${storeId}" />
												<fmt:param value="${productId}" />
												<fmt:param value="${langId}" />
												<fmt:param value="${aucrfn}" />
												<fmt:param value="${product_Desc}" />
											</fmt:message>
      				            		</c:otherwise>
      				            	</c:choose>
									<br /> 
									<br /> 
									<fmt:message key="AuctionMail_checkoutMsg" bundle="${storeText}" >
										<fmt:param value="${aucrfn}" />
									</fmt:message>
									<br />                        
      							</c:when>
      							<c:when test="${msg_Type=='5'}">
									<br /> 
      				            	<c:choose>
      				            		<c:when test="${austatus=='C'}">
											<fmt:message key="AuctionMail_msgAucItemLink1" bundle="${storeText}" >
												<fmt:param value="${storeId}" />
												<fmt:param value="${productId}" />
												<fmt:param value="${langId}" />
												<fmt:param value="${product_Desc}" />
											</fmt:message>
      				            		</c:when>
      				            		<c:otherwise>
											&nbsp;&nbsp;&nbsp; 
											<fmt:message key="AuctionMail_msgAucItemLink2" bundle="${storeText}" >
												<fmt:param value="${storeId}" />
												<fmt:param value="${productId}" />
												<fmt:param value="${langId}" />
												<fmt:param value="${aucrfn}" />
												<fmt:param value="${product_Desc}" />
											</fmt:message>
      				            		</c:otherwise>
      				            	</c:choose>
									<br />
									<br />   
      							</c:when>
      							<c:otherwise>
      							</c:otherwise>
							</c:choose>
						</font>
					</td>
				</tr>
				<tr>						
					<td align="left" id="WC_MailDisplay_TableCell_6">
						<pre>
<c:out value="${msg_Content}" />
						</pre>
					</td>					
				</tr>
				<tr>
					<td align="center" id="WC_MailDisplay_TableCell_7">
						<font class="strongtext">	
							<a href="DeleteMail?msgrfn=<c:out value="${msgrfn}" />&URL=MailListView" id="WC_MailDisplay_Link_1">
								<fmt:message key="AuctionMail_deletePrompt" bundle="${storeText}" />
							</a>                              
							<br />
						</font>
					</td> 
				</tr>
				<tr>
					<td align="center" id="WC_MailDisplay_TableCell_8">
						<font class="strongtext">	
							<a href="MailListView" id="WC_MailDisplay_Link_2">
								<fmt:message key="AuctionMail_returnPrompt" bundle="${storeText}" />
							</a>
							<br />
						</font>
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