<%--
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
	<meta http-equiv="Expires" content="Mon, 01 Jan 1996 01:01:01 GMT"/>
	<title><fmt:message key="AuctionMailList_Title" bundle="${storeText}" /></title>
	<link rel="stylesheet" href="<c:out value="${fileDir}"/>ToolTech.css" type="text/css"/>
</head>

<body>

<flow:ifEnabled feature="customerCare">
<%--Set header type needed for this JSP for LiveHelp.  This must be set before HeaderDisplay.jsp--%>
<c:set var="liveHelpPageType" value="personal" scope="request" />
</flow:ifEnabled>

<%@ include file="../../include/LayoutContainerTop.jspf"%>

<table border="0" cellpadding="0" cellspacing="0" width="790" id="WC_MailListDisplay_Table_1">
<tr>	

	<td valign="top" width="630" id="WC_MailListDisplay_TableCell_2">
	<c:set var="removeMail" value="false" />
	<c:set var="totalmsgcounter" value="0" />
	<c:set var="next" value="0" />
	<c:set var="start" value="0" />
	<c:set var="count" value="5" />
	<c:set var="strNext" value="${WCParam.next}" />
	<c:choose>
		<c:when test="${empty strNext}">
			<c:set var="start" value="0" />
		</c:when>
		<c:otherwise>
			<c:set var="start" value="${strNext}" />
		</c:otherwise>
	</c:choose>

	<wcbase:useBean id="msgList" classname="com.ibm.commerce.negotiation.beans.MessageInfoListBean" >
		<c:set property="msgRecipientId" value="${userId}" target="${msgList}" />
		<c:set property="msgMultipleStatusStr" value="N;O" target="${msgList}" />
		<c:set property="sortAttByString" value="POSTTIME" target="${msgList}" />
	</wcbase:useBean>
	<c:set var="length" value="${msgList.msgsNum}" />

	<wcbase:useBean id="aRegister" classname="com.ibm.commerce.user.beans.UserRegistrationDataBean" >
	</wcbase:useBean>	
	
	<c:set var="safname" value="${aRegister.firstName}" />
	<c:set var="samname" value="${aRegister.middleName}" />
	<c:set var="salname" value="${aRegister.lastName}" />
	

	<table cellpadding="0" cellspacing="8" border="0" id="WC_MailListDisplay_Table_2">
		<tr>
			<td align="left" valign="top" class="categoryspace" width="100%" id="WC_MailListDisplay_TableCell_3">
				<h1>
					<fmt:message key="AuctionMailList_mailFor" bundle="${storeText}" >
						<fmt:param value="${safname}" />
						<fmt:param value="${samname}" />
						<fmt:param value="${salname}" />
					</fmt:message>
					<br />             
				</h1>
				<hr width="100%" align="left" noshade="noshade"/> 
			</td>                  
		</tr>
		<tr>
			<td align="left" id="WC_MailListDisplay_TableCell_4">
				<c:choose>
					<c:when test="${length > 0}">
						<c:set var="noMail" value="false" />
					</c:when>
					<c:otherwise>
						<c:set var="noMail" value="true" />
					</c:otherwise>
				</c:choose>
				<c:choose>
					<c:when test="${noMail == true}">
						<font class="productName">
							<tt>
							<fmt:message key="AuctionMailList_mailboxEmpty" bundle="${storeText}" />
							</tt>
						</font>
					</c:when>
					<c:otherwise>
						<wcbase:useBean id="msg" classname="com.ibm.commerce.negotiation.beans.MessageCountDataBean" >
							<c:set property="msgRecipientId" value="${userId}" target="${msg}" />
							<c:set property="msgStatus" value="N" target="${msg}" />
						</wcbase:useBean>
						<c:set var="newcnt" value="${msg.msgCount}" />
						<c:if test="${empty newcnt}">
							<c:set var="newcnt" value="0" />
						</c:if>
				      	<%-- get new and old mails count  --%> 
						<wcbase:useBean id="mclb" classname="com.ibm.commerce.negotiation.beans.MessageCountListBean" >
							<c:set property="msgRecipientId" value="${userId}" target="${mclb}" />
							<c:set property="msgMultipleStatusStr" value="N;O" target="${mclb}" />
						</wcbase:useBean>
						<c:set var="len" value="${mclb.msgsCountNum}" />
						<c:forEach var="anMsg" items="${mclb.messageCounts}" begin="0" end="${len}">
							<c:set var="totalmsgcounter" value="${anMsg.count+totalmsgcounter}" />
						</c:forEach>
						<font class="productName">
							<fmt:message key="AuctionMailList_mailTotalMsg" bundle="${storeText}" >
								<fmt:param value="${totalmsgcounter}" />
								<fmt:param value="${newcnt}" />
							</fmt:message>
							<br />
						</font>
						<br />
						<table cellpadding="0" cellspacing="1" border="0" width="100%" bgcolor="#4C6178" id="WC_MailListDisplay_Table_3">
							<tr bgcolor="#4C6178">
								<td width="100" align="left" valign="top" class="textOverBackgroundCharts" id="WC_MailListDisplay_TableCell_5">
									<strong>
										<font style="font-family : Verdana;" color="#FFFFFF">
											<fmt:message key="AuctionMailList_mailList.Column1" bundle="${storeText}" />
										</font>
									</strong>
								</td>
								<td width="250" align="left" valign="top" class="textOverBackgroundCharts" id="WC_MailListDisplay_TableCell_6">
									<strong>
										<font style="font-family : Verdana;" color="#FFFFFF">	
											<fmt:message key="AuctionMailList_mailList.Column2" bundle="${storeText}" />
										</font>
									</strong>
								</td>
								<td width="250" align="left" valign="top" class="textOverBackgroundCharts" id="WC_MailListDisplay_TableCell_7">
									<strong>
										<font style="font-family : Verdana;" color="#FFFFFF">
											<fmt:message key="AuctionMailList_mailList.Column3" bundle="${storeText}" />
										</font>
									</strong>
								</td>               
							</tr>
							<c:set var="end" value="${start+count}" />
							<c:if test="${end > length}">
								<c:set var="end" value="${length}" />
							</c:if>
							<c:forEach var="aMessage" items="${msgList.messages}" begin="${start}" end="${end}" varStatus="aStatus">
								<c:set var="msgrfn" value="${aMessage.id}" />
								<c:set var="msgstatus" value="${aMessage.status}" />
								<c:set var="formattedMsgdate" value="${aMessage.formattedPostTime}" />
								<c:set var="msgsubject" value="${aMessage.subject}" />
								
								<c:choose>
									<c:when test="${aStatus.count%2==0}">
										<c:set var="color" value="#ffffff"/>
									</c:when>
									<c:otherwise>
										<c:set var="color" value="#bccbdb"/>
									</c:otherwise>
								</c:choose>
								<tr bgcolor="<c:out value="${color}"/>">
									<td align="center" id="WC_MailListDisplay_TableCell_8">
										<font class="text">
											<c:choose>
												<c:when test="${msgstatus=='N'}">
													*
												</c:when>
												<c:when test="${msgstatus=='O'}">
													<c:set var="removeMail" value="true" />
													<a href="DeleteMail?msgrfn=<c:out value="${msgrfn}" />&storeId=<c:out value="${storeId}" />&URL=MailListView" id="WC_MailListDisplay_Link_1">
														<fmt:message key="AuctionCommonText_Remove" bundle="${storeText}" />
													</a> 
												</c:when>
											</c:choose>
										</font>
                        			</td>
			                        <td align="center" width="250" id="WC_MailListDisplay_TableCell_9">
										<font class="text">
											<c:out value="${formattedMsgdate}" />
										</font>
			                        </td>
									<td align="left" width="250" id="WC_MailListDisplay_TableCell_10">
										<font class="text">
											<a href="DisplayMessage?msgrfn=<c:out value="${msgrfn}" />&msgstatus=<c:out value="${msgstatus}" />&URL=MailDisplayView" id="WC_MailListDisplay_Link_2">
												<c:out value="${msgsubject}" />
											</a>
										</font>
									</td>
                  				</tr>
							</c:forEach>
				            </table>
				            <hr width="100%" align="left" noshade="noshade"/> 
							<table cellpadding="3" cellspacing="0" border="0" id="WC_MailListDisplay_Table_4">
								<tr>
									<c:set var="nextStartPt" value="${end}" />
									<c:set var="prevStartPt" value="${start-count}" />
									<c:if test="${prevStartPt >= 0}">
									<td align="center" valign="middle" class="buttonStyle" id="WC_MailListDisplay_TableCell_11">
										<!-- Start display for button -->
										<table cellpadding="0" cellspacing="0" border="0" id="WC_MailListDisplay_Table_5">
											<tr>
												<td bgcolor="#ff2d2d" class="pixel" id="WC_MailListDisplay_TableCell_12">
													<img src="<c:out value="${jspStoreImgDir}" />images/lb.gif" border="0" alt=""/>
												</td>
												<td bgcolor="#ff2d2d" class="pixel" id="WC_MailListDisplay_TableCell_13">
													<img src="<c:out value="${jspStoreImgDir}" />images/lb.gif" border="0" alt=""/>
												</td>
												<td class="pixel" id="WC_MailListDisplay_TableCell_14">
													<img src="<c:out value="${jspStoreImgDir}" />images/r_top.gif" border="0" alt=""/>
												</td>
											</tr>
											<tr>
												<td bgcolor="#ff2d2d" id="WC_MailListDisplay_TableCell_15">
													<img src="<c:out value="${jspStoreImgDir}" />images/lb.gif" border="0" alt=""/>
												</td>
												<td bgcolor="#ea2b2b" id="WC_MailListDisplay_TableCell_16">
													<table cellpadding="2" cellspacing="0" border="0" id="WC_MailListDisplay_Table_6">
														<tr>
															<td class="buttontext" id="WC_MailListDisplay_TableCell_17">
																<font color="#ffffff">
																	<a href="MailListView?next=<c:out value="${prevStartPt}" />" style="color:#ffffff; text-decoration : none;" id="WC_MailListDisplay_Link_3">
																		&lt;
																		<fmt:message key="AuctionCommonText_Previous" bundle="${storeText}" />
																	</a>
																</font>
															</td>
														</tr>
													</table>
												</td>
												<td bgcolor="#7a1616" id="WC_MailListDisplay_TableCell_18">
													<img src="<c:out value="${jspStoreImgDir}" />images/db.gif" border="0" alt=""/>
												</td>
											</tr>	
											<tr>
												<td class="pixel" id="WC_MailListDisplay_TableCell_19">
													<img src="<c:out value="${jspStoreImgDir}" />images/l_bot.gif" alt=""/>
												</td>
												<td bgcolor="#7a1616" class="pixel" valign="top" id="WC_MailListDisplay_TableCell_20">
													<img src="<c:out value="${jspStoreImgDir}" />images/db.gif" border="0" alt=""/>
												</td>
												<td bgcolor="#7a1616" class="pixel" valign="top" id="WC_MailListDisplay_TableCell_21">
													<img src="<c:out value="${jspStoreImgDir}" />images/db.gif" border="0" alt=""/>
												</td>
											</tr>
										</table>
										<!-- End display for button -->
									</td>
									</c:if>
									<c:if test="${nextStartPt < length}">
									<td align="center" valign="middle" class="buttonStyle" id="WC_MailListDisplay_TableCell_22">
										<!-- Start display for button -->
										<table cellpadding="0" cellspacing="0" border="0" id="WC_MailListDisplay_Table_7">
											<tr>
												<td bgcolor="#ff2d2d" class="pixel" id="WC_MailListDisplay_TableCell_23">
													<img src="<c:out value="${jspStoreImgDir}" />images/lb.gif" border="0" alt=""/>
												</td>
												<td bgcolor="#ff2d2d" class="pixel" id="WC_MailListDisplay_TableCell_24">
													<img src="<c:out value="${jspStoreImgDir}" />images/lb.gif" border="0" alt=""/>
												</td>
												<td class="pixel" id="WC_MailListDisplay_TableCell_25">
													<img src="<c:out value="${jspStoreImgDir}" />images/r_top.gif" border="0" alt=""/>
												</td>
											</tr>
											<tr>
												<td bgcolor="#ff2d2d" id="WC_MailListDisplay_TableCell_26">
													<img src="<c:out value="${jspStoreImgDir}" />images/lb.gif" border="0" alt=""/>
												</td>
												<td bgcolor="#ea2b2b" id="WC_MailListDisplay_TableCell_27">
													<table cellpadding="2" cellspacing="0" border="0" id="WC_MailListDisplay_Table_8">
														<tr>
															<td class="buttontext" id="WC_MailListDisplay_TableCell_28">
																<font color="#ffffff">
																	<a href="MailListView?next=<c:out value="${nextStartPt}" />" style="color:#ffffff; text-decoration : none;" id="WC_MailListDisplay_Link_4">
																		<fmt:message key="AuctionCommonText_Next" bundle="${storeText}" />
																		&gt;
																	</a>
																</font>
															</td>
														</tr>
													</table>
												</td>
												<td bgcolor="#7a1616" id="WC_MailListDisplay_TableCell_29">
													<img src="<c:out value="${jspStoreImgDir}" />images/db.gif" border="0" alt=""/>
												</td>			
											</tr>	
											<tr>
												<td class="pixel" id="WC_MailListDisplay_TableCell_30">
													<img src="<c:out value="${jspStoreImgDir}" />images/l_bot.gif" alt=""/>
												</td>
												<td bgcolor="#7a1616" class="pixel" valign="top" id="WC_MailListDisplay_TableCell_31">
													<img src="<c:out value="${jspStoreImgDir}" />images/db.gif" border="0" alt=""/>
												</td>
												<td bgcolor="#7a1616" class="pixel" valign="top" id="WC_MailListDisplay_TableCell_32">
													<img src="<c:out value="${jspStoreImgDir}" />images/db.gif" border="0" alt=""/>
												</td>
											</tr>
										</table>
										<!-- End display for button -->
									</td>
									</c:if>
								</tr>
							</table>
					</c:otherwise>
				</c:choose>
				<br />
			</td>
		</tr>
	</table>
				
	</td>
</tr>
</table>
<%@ include file="../../include/LayoutContainerBottom.jspf"%>

</body>
</html>
      
