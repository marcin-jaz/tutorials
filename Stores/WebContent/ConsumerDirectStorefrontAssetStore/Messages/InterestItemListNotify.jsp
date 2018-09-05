<%
//********************************************************************
//*-------------------------------------------------------------------
//* Licensed Materials - Property of IBM
//*
//* WebSphere Commerce
//*
//* (c) Copyright IBM Corp. 2004
//*
//* US Government Users Restricted Rights - Use, duplication or
//* disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
//*
//*-------------------------------------------------------------------
//*
%>
<%-- 
  *****
  * This JSP constructs the wish list email content
  *****
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../include/JSTLEnvironmentSetup.jspf" %>

<c:url var="sharedWishListViewURL" value="SharedWishListView">
	<c:param name="listId" value="${WCParam.listId}" />
	<c:param name="langId" value="${langId}" />
	<c:param name="storeId" value="${WCParam.storeId}" />
	<c:param name="catalogId" value="${WCParam.catalogId}" />
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

<c:import url="${jspStoreDir}/Snippets/Marketing/Content/ContentSpotDisplay.jsp">
	<c:param name="spotName" value="Email_Content" />
	<c:param name="substitutionValues" value="{senderName},${WCParam.sender_name}"/>
	<c:param name="substitutionValues" value="{senderEmail},${senderEmail}"/>
	<c:param name="substitutionValues" value="{link},<a href=\"${link}\" id=\"WC_interestItemListNotify_link_1\">${link}</a>"/>
</c:import>

<c:if test="${!empty WCParam.wishlist_message}">
	<br/><br/>
	<fmt:message key="SENDER_MESSAGE" bundle="${storeText}">
		<fmt:param value="${WCParam.sender_name}"/>
	</fmt:message>
	<br/>
	<c:out value="${WCParam.wishlist_message}" />
</c:if>


