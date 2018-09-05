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
<%@ include file="../../include/JSTLEnvironmentSetup.jspf" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "DTD/xhtml1-transitional.dtd">
<html lang="en">
<head>
<meta http-equiv="Expires" content="Mon, 01 Jan 1996 01:01:01 GMT" />
<title><fmt:message key="mailDisplayTitle" bundle="${storeText}" /></title>
<link rel="stylesheet" href='<c:out value="${jspStoreImgDir}${vfileStylesheet}"/>' type="text/css" />
</head>

<body>
<%@ include file="../../include/LayoutContainerTop.jspf"%>
<table cellpadding="0" cellspacing="0" border="0" width="600" id="WC_MailDisplay_Table_1">
	
		<tr>			

			<td bgcolor="#FFFFFF" width="600" valign="top" id="WC_MailDisplay_TableCell_1">
			<c:set var="msgrfn"	value="${WCParam.msgrfn}" /> 
			<c:if test="${! empty msgrfn }">
				<wcbase:useBean id="msg" classname="com.ibm.commerce.negotiation.beans.MessageInfoDataBean">
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
				<table border="3" width="600" cellpadding="5" id="WC_MailDisplay_Table_2">
					
						<tr>
							<td align="left" id="WC_MailDisplay_TableCell_2">
							<font class="strongtext"> 
							<fmt:message key="msgSubject" bundle="${storeText}">
								<fmt:param value="${msg_Subject}" />
							</fmt:message> 
							</font>
							</td>
						</tr>
						<tr>
							<td align="left" id="WC_MailDisplay_TableCell_3">
							<font class="strongtext"> 							
							<fmt:message key="msgDate" bundle="${storeText}">
								<fmt:param value="${formattedMsgdate}" />
							</fmt:message> 							
							</font>
							</td>
						</tr>
						
						<tr>
							
							<td align="left" id="WC_MailDisplay_TableCell_4">
							
							<font class="text"> 
							
							<c:choose>
								<c:when test="${msg_Type=='1'}">
									<c:set var="aucrfn" value="${msg_Param2}" />
								</c:when>
								<c:otherwise>
									<c:if test="${msg_Type=='2' || msg_Type=='4' || msg_Type == '5'}">
										<c:set var="bidId" value="${msg_Param1}" />
										<wcbase:useBean id="aBid"	classname="com.ibm.commerce.negotiation.beans.BidDataBean">
											<c:set property="bidId" value="${bidId}" target="${aBid}" />
										</wcbase:useBean>
										<c:set var="aucrfn" value="${aBid.auctionId}" />
										<c:set var="bidrfn" value="${aBid.referenceCode}" />
									</c:if>
								</c:otherwise>
							</c:choose> 
							<wcbase:useBean id="anAuction"	classname="com.ibm.commerce.negotiation.beans.AuctionDataBean">
								<c:set property="auctionId" value="${aucrfn}" target="${anAuction}" />
							</wcbase:useBean> 
							<c:set var="austatus"	value="${anAuction.status}" />
							<c:set var="productId" value="${anAuction.entryId}"/> 
							<c:set var="product_Desc" value="${anAuction.auctItemDesc}" /> 
							
							<c:choose>
								<c:when test="${austatus=='C'}">
									<c:url value="ProductDisplay" var="aucItemUrl">
										<c:param name="storeId" value="${storeId}"/>
										<c:param name="catalogId" value="${catalogId}"/>
										<c:param name="productId" value="${productId}"/>
										<c:param name="langId" value="${langId}"/>
										<c:param name="fromAuction" value="true"/>
									</c:url>											
								</c:when>
								<c:otherwise>
									<c:url value="DisplayAuctionItem" var="aucItemUrl">
										<c:param name="storeId" value="${storeId}"/>
										<c:param name="catalogId" value="${catalogId}"/>
										<c:param name="productId" value="${productId}"/>
										<c:param name="langId" value="${langId}"/>
										<c:param name="aucrfn" value="${aucrfn}"/>
										<c:param name="fromAuction" value="true"/>
									</c:url>											
								</c:otherwise>
							</c:choose>
							
							<c:choose>
								<%-- display messages depending on message type --%>
								<c:when test="${msg_Type=='1'}">
									<br />
									
									<fmt:message key="msgAuctionStart" bundle="${storeText}">
										<fmt:param value="${product_Desc}" />
									</fmt:message>
									<br/><br/>
									<a class="button" href="<c:out value="${aucItemUrl}"/>" id="WC_MailDisplay_Link_1">
										<fmt:message key="txtShowProduct" bundle="${storeText}"/>
									</a>
									<br />
									<br />
									<c:url value="DisplayAuctionRules" var="displayAuctionRulesUrl">
										<c:param name="storeId" value="${storeId}"/>
										<c:param name="catalogId" value="${catalogId}"/>										
										<c:param name="aucrfn" value="${aucrfn}"/>										
									</c:url>		
									<fmt:message key="rulesMsg" bundle="${storeText}"/>										
									<br/><br/>
									<a class="button" href="<c:out value="${displayAuctionRulesUrl}"/>" id="WC_MailDisplay_Link_2">
										<fmt:message key="txtAuctionRules" bundle="${storeText}"/>
									</a>
									<br />
									<br />
								</c:when>
								<c:when test="${msg_Type=='2'}">
									<br />
									<b> <fmt:message key="winnerMsg1" bundle="${storeText}" />
									</b>
									<br />
									<br />									
									<fmt:message key="msgAucItem" bundle="${storeText}">
										<fmt:param value="${product_Desc}" />
									</fmt:message>
									<br/><br/>
									<a class="button" href="<c:out value="${aucItemUrl}"/>" id="WC_MailDisplay_Link_3">
										<fmt:message key="txtShowProduct" bundle="${storeText}"/>
									</a>
									<br />
									<br />									
									<fmt:message key="winnerMsg3" bundle="${storeText}" />
									<br />
								</c:when>
								<c:when test="${msg_Type=='4'}">
									<br />
									<fmt:message key="msgAucItem" bundle="${storeText}">
										<fmt:param value="${product_Desc}" />
									</fmt:message>
									<br/><br/>
									<a class="button" href="<c:out value="${aucItemUrl}"/>" id="WC_MailDisplay_Link_4">
										<fmt:message key="txtShowProduct" bundle="${storeText}"/>
									</a>
									<br />
									<br />
									<c:url value="BidListView" var="bidListViewUrl">
										<c:param name="storeId" value="${storeId}"/>
										<c:param name="catalogId" value="${catalogId}"/>										
										<c:param name="aucrfn" value="${aucrfn}"/>
										<c:param name="type" value="AW++"/>
									</c:url>		
									<fmt:message key="checkoutMsg" bundle="${storeText}"/>										
									<br /><br/>
									<a class="button" href="<c:out value="${bidListViewUrl}"/>" id="WC_MailDisplay_Link_5">
										<fmt:message key="txtSeeAllBids" bundle="${storeText}"/>
									</a>
									<br />
								</c:when>
								<c:when test="${msg_Type=='5'}">									
									<br />
									<fmt:message key="msgAucItem" bundle="${storeText}">
										<fmt:param value="${product_Desc}" />
									</fmt:message>
									<br/><br/>
									<a class="button" href="<c:out value="${aucItemUrl}"/>" id="WC_MailDisplay_Link_6">
										<fmt:message key="txtShowProduct" bundle="${storeText}"/>
									</a>
									<br />
									<br />
								</c:when>
							</c:choose> 
							</font>
							</td>
						</tr>
						<tr>
							<td id="WC_MailDisplay_TableCell_5">							
							<pre>
<c:out value="${msg_Content}" />
							</pre> 							
							</td>
						</tr>
						<tr>
							<td align="center" id="WC_MailDisplay_TableCell_6">							
							<c:url value="DeleteMail" var="deleteMailUrl">
								<c:param name="storeId" value="${storeId}"/>
								<c:param name="catalogId" value="${catalogId}"/>
								<c:param name="msgrfn" value="${msgrfn}"/>
								<c:param name="URL" value="MailListView"/>								
							</c:url>						
							<a	class="button" href="<c:out value="${deleteMailUrl}" />" id="WC_MailDisplay_Link_7">
							<fmt:message key="deletePrompt" bundle="${storeText}" /> 
							</a>
							<br />							
							</td>
						</tr>
						<tr>
							<td align="center" id="WC_MailDisplay_TableCell_7">
							<c:url value="MailListView" var="mailListViewUrl">
								<c:param name="storeId" value="${storeId}"/>
								<c:param name="catalogId" value="${catalogId}"/>													
							</c:url>	
							<a	class="button" href="<c:out value="${mailListViewUrl}" />" id="WC_MailDisplay_Link_8"> 
							<fmt:message key="returnPrompt"	bundle="${storeText}" /> 
							</a> 
							<br />							
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
