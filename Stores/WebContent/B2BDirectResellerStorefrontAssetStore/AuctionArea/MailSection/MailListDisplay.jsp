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
<%@ include file="../../include/JSTLEnvironmentSetup.jspf" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "DTD/xhtml1-transitional.dtd">
<html lang="en">
<head>
<meta http-equiv="Expires" content="Mon, 01 Jan 1996 01:01:01 GMT" />
<title><fmt:message key="mailListTitle" bundle="${storeText}" /></title>
<link rel="stylesheet" href='<c:out value="${jspStoreImgDir}${vfileStylesheet}"/>' type="text/css" />
</head>

<body>
<%@ include file="../../include/LayoutContainerTop.jspf"%>
<table cellpadding="0" cellspacing="0" border="0" width="600" id="WC_MailListDisplay_Table_1">
	
	<tbody>
		<tr>


			<td bgcolor="#FFFFFF" width="600" valign="top" id="WC_MailListDisplay_TableCell_1">
			<c:set var="removeMail" value="false" /> 
			<c:set var="totalmsgcounter" value="0" /> 
			<c:set var="next" value="0" /> 
			<c:set var="start"	value="0" /> 
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
			<wcbase:useBean id="msgList" classname="com.ibm.commerce.negotiation.beans.MessageInfoListBean">
				<c:set property="msgRecipientId" value="${userId}"	target="${msgList}" />
				<c:set property="msgMultipleStatusStr" value="N;O"	target="${msgList}" />
				<c:set property="sortAttByString" value="POSTTIME"	target="${msgList}" />
			</wcbase:useBean> 
			<c:set var="length" value="${msgList.msgsNum}" />

			<wcbase:useBean id="aRegister"	classname="com.ibm.commerce.user.beans.UserRegistrationDataBean"/>
			 	
			<c:set var="safname" value="${aRegister.firstName}" />
			<c:set var="samname" value="${aRegister.middleName}" />
			<c:set var="salname" value="${aRegister.lastName}" />
			
			<table cellpadding="5"  width="600" border="3" id="WC_MailListDisplay_Table_2">
				<tbody>
					<tr>
						<td width="10" id="WC_MailListDisplay_TableCell_2">&nbsp;</td>
						<td align="left" valign="top" class="categoryspace" width="580" id="WC_MailListDisplay_TableCell_3">
						<font	class="pageHeading"> 
						<fmt:message key="mailFor"	bundle="${storeText}">
							<fmt:param value="${safname}" />
							<fmt:param value="${samname}" />
							<fmt:param value="${salname}" />
						</fmt:message> 
						</font>
						<hr width="100%" noshade="noshade" align="left" />
						</td>
					</tr>
					<tr>
						<td width="10" id="WC_MailListDisplay_TableCell_4">&nbsp;</td>
						<td align="left" id="WC_MailListDisplay_TableCell_5">
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
								<fmt:message key="mailboxEmpty" bundle="${storeText}" /> 
								</tt> 
								</font>
							</c:when>
							<c:otherwise>
								<wcbase:useBean id="msg" classname="com.ibm.commerce.negotiation.beans.MessageCountDataBean">
									<c:set property="msgRecipientId" value="${userId}" target="${msg}" />
									<c:set property="msgStatus" value="N" target="${msg}" />
								</wcbase:useBean>
								
								<c:set var="newcnt" value="${msg.msgCount}" />
								
								<c:if test="${ empty newcnt}">
									<c:set var="newcnt" value="0" />
								</c:if>
								<%-- get new and old mails count  --%>
								<wcbase:useBean id="mclb"	classname="com.ibm.commerce.negotiation.beans.MessageCountListBean">
									<c:set property="msgRecipientId" value="${userId}"	target="${mclb}" />
									<c:set property="msgMultipleStatusStr" value="N;O"	target="${mclb}" />
								</wcbase:useBean>
								<c:set var="len" value="${mclb.msgsCountNum}" />
								<c:forEach var="anMsg" items="${mclb.messageCounts}" begin="0"	end="${len}">
									<c:set var="totalmsgcounter" value="${anMsg.msgCount+totalmsgcounter}" />
								</c:forEach>
								<font class="productName"> 
								<fmt:message key="mailTotalMsg1"	bundle="${storeText}">
									<fmt:param value="${totalmsgcounter}" />
									<fmt:param value="${newcnt}" />
								</fmt:message><br/>
								<fmt:message key="mailTotalMsg2"	bundle="${storeText}"/><br/>
								<fmt:message key="mailTotalMsg3"	bundle="${storeText}"/> 
								<br />
								</font>
								<br />
								<table cellpadding="0" cellspacing="1" border="0" width="100%" id="WC_MailListDisplay_Table_3">
									<tbody>
										<tr>
											<td width="100" align="left" valign="top" class="textOverBackgroundCharts" id="WC_MailListDisplay_TableCell_6">											
											<font class="textOverBackgroundCharts"> 
											<fmt:message key="mailList.Column1" bundle="${storeText}" /> 
											</font>											
											</td>
											<td width="250" align="left" valign="top" class="textOverBackgroundCharts" id="WC_MailListDisplay_TableCell_7">
											<font class="textOverBackgroundCharts"> 
											<fmt:message key="mailList.Column2" bundle="${storeText}" /> 
											</font>											
											</td>
											<td width="250" align="left" valign="top" class="textOverBackgroundCharts" id="WC_MailListDisplay_TableCell_8">											
											<font class="textOverBackgroundCharts"> 
											<fmt:message key="mailList.Column3" bundle="${storeText}" /> 
											</font>											
											</td>
										</tr>
										<c:set var="end" value="${start+count}" />
										<c:if test="${end > length}">
											<c:set var="end" value="${length}" />
										</c:if>
										<c:forEach var="aMessage" items="${msgList.messages}" begin="${start}" end="${end-1}" varStatus="aStatus">
											<c:set var="msgrfn" value="${aMessage.id}" />
											<c:set var="msgstatus" value="${aMessage.status}" />
											<c:set var="formattedMsgdate" value="${aMessage.formattedPostTime}" />
											<c:set var="msgsubject" value="${aMessage.subject}" />
											<tr>
												<td align="center" id="WC_MailListDisplay_TableCell_9_<c:out value="${aStatus.count}"/>">
												<font class="text"> 
												<c:choose>
													<c:when test="${msgstatus=='N'}">
															*
														</c:when>
													<c:when test="${msgstatus=='O'}">
														<c:set var="removeMail" value="true" />
														<a	href='DeleteMail?msgrfn=<c:out value="${msgrfn}" />&storeId=<c:out value="${storeId}" />&catalogId=<c:out value="${catalogId}" />&URL=MailListView' id="WC_MailListDisplay_Link_1">
														<fmt:message key="txtRemove" bundle="${storeText}" /> 
														</a>
													</c:when>
												</c:choose> 
												</font>
												</td>
												<td align="center" width="250" id="WC_MailListDisplay_TableCell_10_<c:out value="${aStatus.count}"/>">
												<font class="text"> 
												<c:out	value="${formattedMsgdate}" /> 
												</font>
												</td>
												<td align="left" width="250" id="WC_MailListDisplay_TableCell_11_<c:out value="${aStatus.count}"/>">
												<font class="text"> 
												<a	href='DisplayMessage?storeId=<c:out value="${storeId}" />&catalogId=<c:out value="${catalogId}" />&msgrfn=<c:out value="${msgrfn}" />&msgstatus=<c:out value="${msgstatus}" />&URL=MailDisplayView' id="WC_MailListDisplay_Link_2">
												<c:out value="${msgsubject}" /> 
												</a> 
												</font>
												</td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
								<hr width="100%" align="left" noshade="noshade" />
								<table cellpadding="3" cellspacing="0" border="0" id="WC_MailListDisplay_Table_4">
									<tbody>
										<tr>
											<c:set var="nextStartPt" value="${end}" />
											<c:set var="prevStartPt" value="${start-count}" />
											<c:if test="${prevStartPt >= 0}">
												<td align="center" valign="middle" class="buttonStyle" id="WC_MailListDisplay_TableCell_12">
												<font	class="buttonStyle"> 
												<a	href='MailListView?storeId=<c:out value="${storeId}" />&catalogId=<c:out value="${catalogId}" />&next=<c:out value="${prevStartPt}"/>' id="WC_MailListDisplay_Link_3">
												<fmt:message key="txtPrevious" bundle="${storeText}" /> 
												</a> 
												</font>
												</td>
											</c:if>
																						
											<c:if test="${nextStartPt < length}">
												<td align="center" valign="middle" class="buttonStyle" id="WC_MailListDisplay_TableCell_13">
												<font class="buttonStyle"> 
												<a	href='MailListView?storeId=<c:out value="${storeId}" />&catalogId=<c:out value="${catalogId}" />&next=<c:out value="${nextStartPt}"/>' id="WC_MailListDisplay_Link_4"> 
												<fmt:message key="txtNext" bundle="${storeText}" />  
												</a> 
												</font>
												</td>
											</c:if>
										</tr>
									</tbody>
								</table>
							</c:otherwise>
						</c:choose> <br />
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
