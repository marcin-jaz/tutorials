<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2008, 2009 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>

<%-- 
  *****
  * This JSP displays the Email Wishlist page. 
  *****
--%>

<!-- BEGIN EmailWishlist.jsp -->

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>

<%@ include file="../../../../../include/parameters.jspf" %>
<%@ include file="../../../../include/JSTLEnvironmentSetup.jspf" %>

<%-- Required variables for breadcrumb support --%>
<c:set var="wishlistPageGroup" value="true" scope="request"/>
<c:set var="emailWishlistPage" value="true" scope="request" />

<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.2//EN" "http://www.openmobilealliance.org/tech/DTD/xhtml-mobile12.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" lang="${shortLocale}" xml:lang="${shortLocale}">
	<head>
		<title>
			<fmt:message key="WISHLIST_TITLE" bundle="${storeText}" /> - <c:out value="${storeName}"/>
		</title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no" />
		<link rel="stylesheet" href="${cssPath}" type="text/css"/>
	</head>	
	<body>
		<div id="wrapper">	

			<%@ include file="../../../../include/HeaderDisplay.jspf" %>
			<%@ include file="../../../../include/BreadCrumbTrailDisplay.jspf"%>			

			<div id="email_wish_list" class="content_box">
				<div class="heading_container">
					<h2><fmt:message key="EMAIL_WISHLIST" bundle="${storeText}" /></h2>
					<div class="clear_float"></div>
				</div>
				
				<p class="paragraph_blurb">
					<fmt:message key="SENDEMAIL" bundle="${storeText}" />
				</p>
				<p class="paragraph_blurb">
					<fmt:message key="SENDEMAIL1" bundle="${storeText}" />
				</p>
				<form id="emailWishList_form" method="post" action="InterestItemListMessage">
					<fieldset>
						<input type="hidden" name="storeId" value="<c:out value="${WCParam.storeId}" />"/>
						<input type="hidden" name="catalogId" value="<c:out value="${WCParam.catalogId}" />"/>
						<input type="hidden" name="langId" value="<c:out value="${langId}" />"/>
						<input type="hidden" name="listId" value="<c:out value="${WCParam.listId}"/>" />
						<input type="hidden" name="URL" value="mSendWishListMessage"/>
						<input type="hidden" name="errorViewName" value="mSendWishListMessage"/>
						<input type="hidden" name="sender" value="<c:out value="${strSender}" />"/>				
					
						<div>
							<label for="recipient"><fmt:message key="WISHLIST_TO" bundle="${storeText}" /></label>
						</div>
						
						<input type="text" id="recipient" name="recipient" class="coloured_input" value="<c:out value="${WCParam.recipient}"/>"/>	
	
						<div>
							<label for="from_name"><fmt:message key="WISHLIST_FROM" bundle="${storeText}" /></label>
						</div>
							
						<input type="text" id="sender_name" name="sender_name" title="sender_name" 
							value="<c:out value="${WCParam.sender_name}"/>" class="coloured_input" />	

						<div>						
							<label for="your_email_address"><fmt:message key="WISHLIST_EMAIL" bundle="${storeText}" /></label>
						</div>
						
						<input type="text" name="sender_email" title="sender_email" value="<c:out value="${WCParam.sender_email}"/>" class="coloured_input" />	
							
						<div>					
							<label for="message"><fmt:message key="WISHLIST_MESSAGE" bundle="${storeText}" /></label>
						</div>
							
						<div><textarea name="wishlist_message" title="wishlist_message" id="wishlist_message" class="coloured_input"><c:out value="${WCParam.wishlist_message}"/></textarea></div>
						
						<input type="submit" id="send_wish_list" name="send_wish_list" value="<fmt:message key="EMAIL_WISHLIST_SEND" bundle="${storeText}" />" />
					</fieldset>
				</form>
			</div>

			<%@ include file="../../../../include/FooterDisplay.jspf" %>						
		</div>
	</body>
</html>

<!-- END EmailWishlist.jsp -->
