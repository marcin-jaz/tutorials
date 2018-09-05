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
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ taglib uri="http://commerce.ibm.com/coremetrics"  prefix="cm" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf" %>
<%@ include file="../../../include/nocache.jspf" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"
xmlns:wairole="http://www.w3.org/2005/01/wai-rdf/GUIRoleTaxonomy#"
xmlns:waistate="http://www.w3.org/2005/07/aaa" lang="${shortLocale}" xml:lang="${shortLocale}">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Personal Wishlist</title>
<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${vfileStylesheet}"/>" type="text/css"/>
<!--[if lte IE 6]>
<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${vfileStylesheetie}"/>" type="text/css"/>
<![endif]-->
<script type="text/javascript" src="<c:out value="${dojoFile}"/>" djConfig="${dojoConfigParams}"></script>
<%@ include file="../../../include/CommonJSToInclude.jspf"%>
<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/CatalogArea/CategoryDisplay.js"/>"></script>
<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/MessageHelper.js"/>"></script>
<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/CatalogArea/CompareProduct.js"/>"></script>
<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/UserArea/AccountWishListDisplay.js"/>"></script>
<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/ServicesDeclaration.js"/>"></script>
<script type="text/javascript">
	dojo.addOnLoad(function() { 
		categoryDisplayJS.setCommonParameters('<c:out value='${WCParam.langId}'/>','<c:out value='${WCParam.storeId}'/>','<c:out value='${WCParam.catalogId}'/>','<c:out value='${userType}'/>');
		ServicesDeclarationJS.setCommonParameters('<c:out value='${WCParam.langId}'/>','<c:out value='${WCParam.storeId}'/>','<c:out value='${WCParam.catalogId}'/>');
		
		<fmt:message key="WISHLIST_MISSINGNAME" bundle="${storeText}" var="WISHLIST_MISSINGNAME"/>
		<fmt:message key="WISHLIST_MISSINGEMAIL" bundle="${storeText}" var="WISHLIST_MISSINGEMAIL"/>
		<fmt:message key="WISHLIST_INVALIDEMAILFORMAT" bundle="${storeText}" var="WISHLIST_INVALIDEMAILFORMAT"/>
		<fmt:message key="REQUIRED_FIELD_ENTER" bundle="${storeText}" var="REQUIRED_FIELD_ENTER"/>
		<fmt:message key="WISHLIST_EMPTY" bundle="${storeText}" var="WISHLIST_EMPTY"/>
		<fmt:message key="SHOPCART_ADDED" bundle="${storeText}" var="SHOPCART_ADDED"/>
		<fmt:message key="ERROR_MESSAGE_TYPE" bundle="${storeText}" var="ERROR_MESSAGE_TYPE"/>
		<fmt:message key="WISHLIST_ADDED" bundle="${storeText}" var="WISHLIST_ADDED"/>
		<fmt:message key="QUANTITY_INPUT_ERROR" bundle="${storeText}" var="QUANTITY_INPUT_ERROR"/>
		<fmt:message key="ERROR_CONTRACT_EXPIRED_GOTO_ORDER" bundle="${storeText}" var="ERROR_CONTRACT_EXPIRED_GOTO_ORDER"/>
		<fmt:message key="GENERICERR_MAINTEXT" bundle="${storeText}" var="ERROR_RETRIEVE_PRICE">                                     
			<fmt:param><fmt:message key="GENERICERR_CONTACT_US" bundle="${storeText}" /></fmt:param>
		</fmt:message>
		<fmt:message key="ERR_RESOLVING_SKU" bundle="${storeText}" var="ERR_RESOLVING_SKU"/>
		MessageHelper.setMessage("ERROR_RETRIEVE_PRICE", <wcf:json object="${ERROR_RETRIEVE_PRICE}"/>);
		MessageHelper.setMessage("WISHLIST_MISSINGNAME", <wcf:json object="${WISHLIST_MISSINGNAME}"/>);
		MessageHelper.setMessage("WISHLIST_MISSINGEMAIL", <wcf:json object="${WISHLIST_MISSINGEMAIL}"/>);
		MessageHelper.setMessage("WISHLIST_INVALIDEMAILFORMAT", <wcf:json object="${WISHLIST_INVALIDEMAILFORMAT}"/>);
		MessageHelper.setMessage("REQUIRED_FIELD_ENTER", <wcf:json object="${REQUIRED_FIELD_ENTER}"/>);
		MessageHelper.setMessage("WISHLIST_EMPTY", <wcf:json object="${WISHLIST_EMPTY}"/>);
		MessageHelper.setMessage("SHOPCART_ADDED", <wcf:json object="${SHOPCART_ADDED}"/>);
		MessageHelper.setMessage("ERROR_MESSAGE_TYPE", <wcf:json object="${ERROR_MESSAGE_TYPE}"/>);
		MessageHelper.setMessage("WISHLIST_ADDED", <wcf:json object="${WISHLIST_ADDED}"/>);
		MessageHelper.setMessage("QUANTITY_INPUT_ERROR", <wcf:json object="${QUANTITY_INPUT_ERROR}"/>);
		MessageHelper.setMessage("ERROR_CONTRACT_EXPIRED_GOTO_ORDER", <wcf:json object="${ERROR_CONTRACT_EXPIRED_GOTO_ORDER}"/>);
		MessageHelper.setMessage("ERR_RESOLVING_SKU", <wcf:json object="${ERR_RESOLVING_SKU}"/>);
	});
	dojo.addOnLoad(AccountWishListDisplay.processBookmarkURL); 
	dojo.addOnLoad(function() { AccountWishListDisplay.initHistory("WishlistDisplay_Widget", '${WishListResultDisplayViewURL}') });
</script>

<wcf:url var="WishListResultDisplayViewURL" value="WishListResultDisplayView">
  <wcf:param name="langId" value="${langId}" />						
  <wcf:param name="storeId" value="${WCParam.storeId}" />
  <wcf:param name="catalogId" value="${WCParam.catalogId}" />
</wcf:url>

</head>
                 
<body>
<script type="text/javascript">
		dojo.addOnLoad(setAjax);
		function setAjax(){
			AccountWishListDisplay.setAjaxVar(false);
		}
</script> 


<c:set var="myAccountPage" value="true" scope="request"/>
<c:set var="wishListPage" value="true" />
<c:set var="hasBreadCrumbTrail" value="false" scope="request"/>

<input type="hidden" id="compareMsgDisplay" value="true"/>

<%@ include file="../../../include/StoreCommonUtilities.jspf"%>
<div id=page>
	<%@ include file="../../../include/LayoutContainerTop.jspf"%>
    <!-- Main Content Start -->

      <%@ include file="../../../Snippets/ReusableObjects/CatalogEntryQuickInfoDetails.jspf" %>
		
		<c:set var="myAccountPage" value="true" scope="request"/>
		<c:set var="bHasWishList" value="true" />
		<c:set var="wishListPage" value="true" />
		<wcbase:useBean id="userListBean" classname="com.ibm.commerce.store.beans.UserInterestItemListDataBean" scope="page">
		<c:set target="${userListBean}" property="storeEntityId" value="${WCParam.storeId}"/>
			<%--
			*** 
			* Two stores on the same server shares user wish lists.  We have to set the storeentId
			* to make sure the items in this shoppers wish list belongs to this store.
			*** 
			--%>
			
		</wcbase:useBean>
		<c:set var="listBeans" value="${userListBean.userInterestItemListDataBeans}"/>
		<c:choose>		
			<%-- Check to see if the list is empty, if no, then wish list is empty--%>		
			<c:when test="${ empty listBeans }" >
				<c:set var="bHasWishList" value="false"/>
			</c:when>    
			<c:otherwise>
				<c:set var="listBean" value="${listBeans[0]}"/>
				<c:set var="interestItems" value="${listBean.interestItemDataBeans}" />
				<%-- if there are items, then there are items in the wish list --%>
				<c:if test="${ empty interestItems }" >
					<c:set var="bHasWishList" value="false"/>
				</c:if>
			</c:otherwise>
		</c:choose>

		<flow:ifEnabled feature="AjaxMyAccountPage">
			<c:set var="url" value="AjaxAccountWishListDisplayView"/>
			<c:set var="errorViewName" value="AjaxAccountWishListDisplayView"/>
		</flow:ifEnabled>

		<flow:ifDisabled feature="AjaxMyAccountPage">
			<c:set var="url" value="NonAjaxAccountWishListDisplayView"/>
			<c:set var="errorViewName" value="NonAjaxAccountWishListDisplayView"/>
		</flow:ifDisabled>
		<!-- Right Nav Start -->
		<div id="right_nav">
			<div id="wishlist">
				<form name="SendMsgForm" method="post" action="InterestItemListMessage" id="SendMsgForm">
				<input type="hidden" name="storeId" value="<c:out value="${WCParam.storeId}" />" id="WC_WishListDisplay_FormInput_storeId_In_SendMsgForm_1"/>
				<input type="hidden" name="catalogId" value="<c:out value="${WCParam.catalogId}" />" id="WC_WishListDisplay_FormInput_catalogId_In_SendMsgForm_1"/>
				<input type="hidden" name="langId" value="<c:out value="${langId}" />" id="WC_WishListDisplay_FormInput_langId_In_SendMsgForm_1"/>
				<input type="hidden" name="listId" value="<c:out value="${listBean.listId}" />" id="WC_WishListDisplay_FormInput_listId_In_SendMsgForm_1"/>
				<input type="hidden" name="URL" value="${url}" id="WC_WishListDisplay_FormInput_URL_In_SendMsgForm_1"/>
				<input type="hidden" name="errorViewName" value="${errorViewName}" id="WC_WishListDisplay_FormInput_errorViewName_In_SendMsgForm_1"/>
				<input type="hidden" name="sender" value="<c:out value="${strSender}" />" id="WC_WishListDisplay_FormInput_sender_In_SendMsgForm_1"/>
				<input type="hidden" name="wishListHasItem" value="<c:out value='${bHasWishList}'/>" id="WC_WishListDisplay_FormInput_wishListItem_In_SendMsgForm_1"/>
					<div class="header" id="WC_WishListDisplay_div_4">
						<h2 class="sidebar_header"><fmt:message key="EMAIL_WISHLIST" bundle="${storeText}"/></h2>
					</div>
					<div class="contents" id="WC_WishListDisplay_div_5">
							<p class="header_text"><fmt:message key="SENDEMAIL" bundle="${storeText}"/></p>
					<p class="header_text"><fmt:message key="SENDEMAIL1" bundle="${storeText}"/></p>
							<br/>
							<div id="WC_WishListDisplay_div_6"><label for="SendWishListForm_Recipient_Email"><span class="required-field_wishlist">*</span><fmt:message key="WISHLIST_TO" bundle="${storeText}" /></label> <fmt:message key="WISHLIST_EMAIL_ADDRESS" bundle="${storeText}" /> </div>
							<div id="WC_WishListDisplay_div_7" class="wishlist_side_space"><input type="text" size="21" maxlength="50" name="recipient" value="<c:out value="${WCParam.recipient}"/>" id="SendWishListForm_Recipient_Email"/></div>
							<div id="WC_WishListDisplay_div_8"><label for="SendWishListForm_Sender_Name"><span class="required-field_wishlist">*</span><fmt:message key="WISHLIST_FROM" bundle="${storeText}" /></label> <fmt:message key="WISHLIST_NAME" bundle="${storeText}" /></div>
							<div id="WC_WishListDisplay_div_9" class="wishlist_side_space"><input type="text" size="21" maxlength="110" name="sender_name" value="<c:out value="${strSenderName}"/>" id="SendWishListForm_Sender_Name"/></div>
							<div id="WC_WishListDisplay_div_10" class="wishlist_side_space"><label for="SendWishListForm_Sender_Email"><fmt:message key="WISHLIST_EMAIL" bundle="${storeText}" /></label></div>
							<div id="WC_WishListDisplay_div_11" class="wishlist_side_space"><input type="text" size="21" maxlength="50" name="sender_email" value="<c:out value="${strSenderEmail}"/>" id="SendWishListForm_Sender_Email"/></div>
							<div id="WC_WishListDisplay_div_12" class="wishlist_side_space"><label for="wishlist_message"><fmt:message key="WISHLIST_MESSAGE" bundle="${storeText}" /></label></div>
							<div id="WC_WishListDisplay_div_13" class="wishlist_side_space"><textarea rows="6" cols="22" name="wishlist_message" id="wishlist_message"><c:out value="${WCParam.wishlist_message}"/></textarea></div>
						   <br />
					   <div id="WC_WishListDisplay_div_14" class="wishlist_side_space">
						   <span class="secondary_button button_fit" >
								<span class="button_container">
									<span class="button_bg">
										<span class="button_top">
											<span class="button_bottom">   
												<a href="#" onclick="JavaScript:AccountWishListDisplay.checkEmailForm('SendMsgForm','refreshArea');return false;" id="WC_WishListDisplay_links_1"><fmt:message key="SENDWISHLIST" bundle="${storeText}"/></a>
								   			</span>
										</span>	
									</span>
								</span>
							</span>	
					   </div>
					   <div class="clear_float"></div>
					</div>
					<div class="side_footer" id="WC_WishListDisplay_div_17"></div>
				</form>
				
			</div>
			 <div id="WishListEmailSucMsg_Div" class="text" tabindex="-1">
			<c:if test="${empty storeError.key}" >
				<c:if test="${!empty WCParam.recipient}">
					<fmt:message key="WISHLIST_SENDTO" bundle="${storeText}"><fmt:param value="${WCParam.recipient}"/></fmt:message>
					<script type="text/javascript">
						dojo.addOnLoad(function() {
							AccountWishListDisplay.clearWishListEmailForm('SendMsgForm');
							setTimeout("dojo.byId('WishListEmailSucMsg_Div').focus()",2000);
						});
					</script>
				</c:if>
			</c:if>
			</div>
		</div>
		<!-- Right Nav End -->
		<!-- Content Start -->
		<div id="box">
			<div class="my_account_wishlist" id="WC_WishListDisplay_div_18">
				<div class="main_header" id="WC_WishListDisplay_div_19">
					<div class="left_corner" id="WC_WishListDisplay_div_20"></div>
					<div class="left" id="WC_WishListDisplay_div_21"><span class="main_header_text"><fmt:message key="MA_PERSONAL_WL" bundle="${storeText}"/></span></div>
					<div class="right_corner" id="WC_WishListDisplay_div_22"></div>
				</div>
				
				<div dojoType="wc.widget.RefreshArea" id="WishlistDisplay_Widget" controllerId="WishlistDisplay_Controller" role="wairole:region" waistate:live="polite" waistate:atomic="false" waistate:relevant="all">
					<% out.flush(); %>
						<c:import url="${jspStoreDir}UserArea/ServiceSection/InterestItemListSubsection/WishListResultDisplay.jsp">
							<c:param name="storeId" value="${WCParam.storeId}" />
							<c:param name="catalogId" value="${catalogId}" />
							<c:param name="langId" value="${langId}" />
						</c:import>
					<% out.flush(); %>
				</div>	
				<script type="text/javascript">dojo.addOnLoad(function() { parseWidget("WishlistDisplay_Widget"); });</script>					
				 <p class="space"></p>
				
				<fmt:message var="titleString" key="WISHLIST_ESPOT_TITLE" bundle="${storeText}"/>	
				<% out.flush(); %>
					<c:import url="${jspStoreDir}Snippets/Marketing/ESpot/ContentAreaESpot.jsp">
						<c:param name="storeId" value="${WCParam.storeId}" />
						<c:param name="catalogId" value="${catalogId}" />
						<c:param name="langId" value="${langId}" />
						<c:param name="numberProductsPerRow" value="4" />
						<c:param name="emsName" value="WishListFeaturedProducts"/>
						<c:param name="espotTitle" value="${titleString}" />
						<c:param name="errorViewName" value="AjaxOrderItemDisplayView" />
					</c:import>
				<% out.flush(); %>
			</div>
			<!-- Content End -->
		</div>

<!-- Main Content End -->
<%@ include file="../../../include/LayoutContainerBottom.jspf"%>

</div>
<div id="page_shadow" class="shadow"></div>
	<flow:ifEnabled feature="Analytics">
		<cm:pageview/>
	</flow:ifEnabled>
</body>
</html>
