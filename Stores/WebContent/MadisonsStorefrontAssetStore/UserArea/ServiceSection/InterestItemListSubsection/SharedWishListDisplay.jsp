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
  * This page shows a wishlist that has been shared to you by another user
  *
  * -A list of order items that a user has added to their wish list
  * 	- For each interest item:
  * 		- Checkbox to select the item (used to select products that user wants to add to their shopcart)
  *			- Clickable item name (links to display page for order item)
  * 		- Attribute values for each interest item
  *			- Item price 
  * - 'Add Selected items to shopping cart' button (adds item to Shopping Cart)
  *****
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ taglib uri="http://commerce.ibm.com/coremetrics"  prefix="cm" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf" %>


<%-- activate the StoreAddressDataBean to get the store email and use it as the sender of the wish list email --%>
<wcbase:useBean id="storeAddress" classname="com.ibm.commerce.common.beans.StoreAddressDataBean" scope="page" >
	<c:set value="${sdb.storeEntityDescriptionDataBean.contactAddressId}" target="${storeAddress}" property="dataBeanKeyStoreAddressId"/>
</wcbase:useBean>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns:wairole="http://www.w3.org/2005/01/wai-rdf/GUIRoleTaxonomy#"
xmlns:waistate="http://www.w3.org/2005/07/aaa" lang="${shortLocale}" xml:lang="${shortLocale}">
<head>
	<title><fmt:message key="WISHLIST_TITLE" bundle="${storeText}" /></title>
	<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${vfileStylesheet}"/>" type="text/css"/>
	<!--[if lte IE 6]>
	<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${vfileStylesheetie}"/>" type="text/css"/>
	<![endif]-->
	<script type="text/javascript" src="<c:out value="${dojoFile}"/>" djConfig="${dojoConfigParams}"></script>
	<%@ include file="../../../include/CommonJSToInclude.jspf"%>
	<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/CatalogArea/CategoryDisplay.js"/>"></script>
	<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/MessageHelper.js"/>"></script>
	<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/UserArea/AccountWishListDisplay.js"/>"></script>
	<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/CatalogArea/CompareProduct.js"/>"></script>
	<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/StoreCommonUtilities.js"/>"></script>
	<script type="text/javascript">
		categoryDisplayJS.setCommonParameters('<c:out value='${WCParam.langId}'/>','<c:out value='${WCParam.storeId}'/>','<c:out value='${WCParam.catalogId}'/>');
	</script>

	<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/ServicesDeclaration.js"/>"></script>
	<script type="text/javascript">
		ServicesDeclarationJS.setCommonParameters('<c:out value='${WCParam.langId}'/>','<c:out value='${WCParam.storeId}'/>','<c:out value='${WCParam.catalogId}'/>');
		<fmt:message key="SHOPCART_ADDED" bundle="${storeText}" var="SHOPCART_ADDED"/>
		<fmt:message key="QUANTITY_INPUT_ERROR" bundle="${storeText}" var="QUANTITY_INPUT_ERROR"/>
		<fmt:message key="ERROR_CONTRACT_EXPIRED_GOTO_ORDER" bundle="${storeText}" var="ERROR_CONTRACT_EXPIRED_GOTO_ORDER"/>
		<fmt:message key="GENERICERR_MAINTEXT" bundle="${storeText}" var="ERROR_RETRIEVE_PRICE">                                     
			<fmt:param><fmt:message key="GENERICERR_CONTACT_US" bundle="${storeText}" /></fmt:param>
		</fmt:message>
		
		MessageHelper.setMessage("ERROR_RETRIEVE_PRICE", <wcf:json object="${ERROR_RETRIEVE_PRICE}"/>);
		MessageHelper.setMessage("SHOPCART_ADDED", <wcf:json object="${SHOPCART_ADDED}"/>);
		MessageHelper.setMessage("QUANTITY_INPUT_ERROR", <wcf:json object="${QUANTITY_INPUT_ERROR}"/>);
		MessageHelper.setMessage("ERROR_CONTRACT_EXPIRED_GOTO_ORDER", <wcf:json object="${ERROR_CONTRACT_EXPIRED_GOTO_ORDER}"/>);
	</script>
</head>

<body>
	<c:set var="wishListPage" value="true"/>   
	<c:set var="sharedWishList" value="true" scope="request"/>
	<c:set var="hasBreadCrumbTrail" value="false" scope="request"/>
	<c:set var="useHomeRightSidebar" value="true" scope="request"/>
	
	<%@ include file="../../../include/StoreCommonUtilities.jspf"%>
	<div id="page">
		<%@ include file="../../../include/LayoutContainerTop.jspf"%>
			<div id="content_wrapper_box">
			<div id="MessageArea">
				<br />  
				<span id="ErrorMessageText" class="error_msg" tabindex="-1">
					
				</span>
				<br /><br />  
			</div>
			<%@ include file="../../../Snippets/ReusableObjects/CatalogEntryQuickInfoDetails.jspf" %>
			<div id="box" class ="my_account_wishlist">
				<h1><fmt:message key="MA_PERSONAL_WL" bundle="${storeText}"/></h1>
				<!-- Start - JSP File Name: SharedWishListDisplay.jsp -->
				
				<%-- 
					***
					* By setting the variable 'sharedWishList' to 'true', this page will not display
					* the 'Remove' button and the Send Wish List form.
					***
				--%>
				<c:set var="sharedWishList" value="true" scope="request" />
				<c:import url="SharedWishListResultDisplay.jsp"/> 
			</div>
			<!-- Content End -->
		</div>

		<%@ include file="../../../include/LayoutContainerBottom.jspf"%>

	</div>
<div id="page_shadow" class="shadow"></div>
</div>
<flow:ifEnabled feature="Analytics"><cm:pageview/></flow:ifEnabled>
</body>
</html>
