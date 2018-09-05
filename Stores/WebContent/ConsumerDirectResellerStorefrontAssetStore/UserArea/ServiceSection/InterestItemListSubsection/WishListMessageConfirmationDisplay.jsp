<%
//********************************************************************
//*-------------------------------------------------------------------
//* Licensed Materials - Property of IBM
//*
//* WebSphere Commerce
//*
//* (c) Copyright IBM Corp. 2000, 2002, 2004
//*
//* US Government Users Restricted Rights - Use, duplication or
//* disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
//*
//*-------------------------------------------------------------------
//*
%>
<%--
  *****
  * This page indicates to the user that the wishlist e-mail was properly sent to the specified e-mail address. 
  *****
--%>

<!-- Start - JSP File Name:  WishListMessageConfirmationDisplay.jsp -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf"%>
<%@ include file="../../../include/nocache.jspf" %>

<%-- ErrorMessageSetup.jspf is used to retrieve an appropriate error message when there is an error --%>
<%@ include file="../../../include/ErrorMessageSetup.jspf"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
	<title><fmt:message key="SENDWISHLISTMSG_TITLE" bundle="${storeText}" /></title>
	<link rel="stylesheet" href='<c:out value="${jspStoreImgDir}${vfileStylesheet}" />' type="text/css" />
</head>

<body>
<!-- JSP File Name:  WishListMessageConfirmationDisplay.jsp -->

<%@ include file="../../../include/LayoutContainerTop.jspf"%>

	<!--MAIN CONTENT STARTS HERE-->
	<c:choose>
		<%--
			***
			* Start: Email confirmation
			* If the command that sends the wish list email does not have error, a confirmation message is displayed.
			***
		--%>
		<c:when test="${empty storeError.key}" >
		
			<fmt:message key="WISHLIST_SENDTO" bundle="${storeText}" />
			<c:out value="${WCParam.recipient}" />

		<%--
			***
			* End: Email confirmation
			***
		--%>			
		</c:when>
		<c:otherwise>			
		<%--
			***
			* Start: Error on sending Wish List email
			***
		--%>			

			<fmt:message key="INVALID_EMAIL_ADDRSS" bundle="${storeText}" />
			<br/><br/>

			<form name="WishlistDisplayForm" id="WishlistDisplayForm" action="InterestItemDisplay">
				<input type="hidden" name="storeId" value="<c:out value="${WCParam.storeId}" />" id="WC_WishListMessageConfirmationDisplay_Input_InForm_WishlistDisplayForm_1"/>
				<input type="hidden" name="langId" value="<c:out value="${langId}" />" id="WC_WishListMessageConfirmationDisplay_Input_InForm_WishlistDisplayForm_2"/>
				<input type="hidden" name="catalogId" value="<c:out value="${WCParam.catalogId}" />" id="WC_WishListMessageConfirmationDisplay_Input_InForm_WishlistDisplayForm_3"/>
				<input type="hidden" name="recipient" value="<c:out value="${WCParam.recipient}" />" id="WC_WishListMessageConfirmationDisplay_Input_InForm_WishlistDisplayForm_4"/>
				<input type="hidden" name="wishlist_message" value="<c:out value="${WCParam.wishlist_message}" />" id="WC_WishListMessageConfirmationDisplay_Input_InForm_WishlistDisplayForm_5"/>
				<input type="hidden" name="sender_name" value="<c:out value="${WCParam.sender_name}" />" id="WC_WishListMessageConfirmationDisplay_Input_InForm_WishlistDisplayForm6"/>
				<input type="hidden" name="sender" value="<c:out value="${WCParam.sender}" />" id="WC_WishListMessageConfirmationDisplay_Input_InForm_WishlistDisplayForm_7"/>
			</form>

			<a href="#" onclick="javascript:document.WishlistDisplayForm.submit()" class="button" id="WC_WishListMessageConfirmationDisplay_Link_2">
				<fmt:message key="RETURN_WISHLIST" bundle="${storeText}" />
			</a>

		<%--
			***
			* End: Error on sending Wish List email
			***
		--%>			
		</c:otherwise>
	</c:choose>

        <!-- End Main JSP Content -->
<%@ include file="../../../include/LayoutContainerBottom.jspf"%>

</body>
</html>

<!-- End - JSP File Name:  WishListMessageConfirmationDisplay.jsp -->
