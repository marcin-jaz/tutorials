<%
//*-------------------------------------------------------------------
//* Licensed Materials - Property of IBM
//*
//* WebSphere Commerce
//*
//* (c) Copyright IBM Corp. 2008
//*
//* US Government Users Restricted Rights - Use, duplication or
//* disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
//*
//*-------------------------------------------------------------------
//*
%>
<%-- 
  *****
  * This e-mail will be sent to the person with whom the user wants to share his wishlist.
  * This email JSP page contins the link which will take him to the shared wish list page.
  *****
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../include/JSTLEnvironmentSetup.jspf"%>

<c:set value="${pageContext.request.scheme}://${pageContext.request.serverName}" var="eHostPath" />
<c:set value="${eHostPath}${jspStoreImgDir}" var="jspStoreImgDir" />


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="${shortLocale}" xml:lang="${shortLocale}">
<head>
	<title><fmt:message key="WISHLIST_TITLE" bundle="${storeText}"/></title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
</head>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

	<table width="594" border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse;">
		<%@ include file="EmailHeader.jspf"%> 
		<tr>
			<td width="12" style="border-left: 1px solid #c9c9c9;"></td>
			<td width="570" valign="top" style="font-family: Verdana, Arial; font-size: 11px; color: #404040;">		
				<b><fmt:message key="WISHLIST_TITLE" bundle="${storeText}"/></b>
				<c:set value="${pageContext.request.scheme}://${pageContext.request.serverName}" var="hostPath" />
				<c:set value="/webapp/wcs/stores/servlet/" var="webPath" />
				<c:url var="sharedWishListViewURL" value="SharedWishListView">
						<c:param name="langId" value="${langId}" />
						<c:param name="storeId" value="${WCParam.storeId}" />
						<c:param name="catalogId" value="${WCParam.catalogId}" />
						<c:param name="wishListEMail" value="true"/>  
						<c:param name="listId" value="${WCParam.listId}" />   
					</c:url>
					<c:set var="link" value="${pageContext.request.scheme}://${pageContext.request.serverName}${pageContext.request.contextPath}/servlet/${sharedWishListViewURL}" />
					<c:choose>
						<c:when test="${!empty WCParam.sender_email}">
							<c:set var="senderEmail" value="${WCParam.sender_email}" />
						</c:when>
						<c:otherwise>
							<fmt:message key="WISHLISTMESSAGE_NA" bundle="${storeText}" var="senderEmail"/>
						</c:otherwise>
					</c:choose>
					<% out.flush(); %>
					<c:import url="${jspStoreDir}/Snippets/Marketing/Content/ContentSpotDisplay.jsp">
						<c:param name="spotName" value="Email_Content" />
						<c:param name="substitutionValues" value="{senderName},${WCParam.sender_name}"/>
						<c:param name="substitutionValues" value="{senderEmail},${senderEmail}"/>
						<c:param name="substitutionValues" value="{link},<a href=\"${link}\" id=\"WC_interestItemListNotify_link_1\" class=\"wishlist_link\">${link}</a>"/>
					</c:import>
					<% out.flush(); %>

					<c:if test="${!empty WCParam.wishlist_message}">
						<br/><br/>
						<fmt:message key="SENDER_MESSAGE" bundle="${storeText}">
							<fmt:param value="${WCParam.sender_name}"/>
						</fmt:message>
						<br/>
						<span class="myaccount_title"><c:out value="${WCParam.wishlist_message}" /></span>
					</c:if>
				<br/>
				<br/>			
			</td>
			<td width="12" style="border-right: 1px solid #c9c9c9;"></td>
		</tr>
		<tr>
			<td colspan="3" style="border-left: 1px solid #c9c9c9; border-right: 1px solid #c9c9c9; font-size: 11px;">&nbsp;</td>
		</tr>
		<%@ include file="EmailFooter.jspf"%>
	</table>
</body>
</html>

