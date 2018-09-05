<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2009 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>
      
<%-- 
  *****
  * This JSP page renders the buyers list of pending orders. 
  * It imports 3 JSP pages:
  *  - LayoutContainerTop.jspf, which displays the header of the page
  *  - ListOrdersDisplayTable.jsp, which displays the table of pending orders.
  *  - LayoutContainerBottom.jspf, which displays the footer of the page
  *****
--%>   
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ taglib uri="http://commerce.ibm.com/coremetrics"  prefix="cm" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf"%>
<%@ include file="../../../include/nocache.jspf"%>

<c:set var="SavedOrderListPage" value="true" scope="request"/>
<c:set var="hasBreadCrumbTrail" value="true" scope="request"/>
<c:set var="useHomeRightSidebar" value="false" scope="request"/>
   
<wcf:url var="ListOrdersDisplayTableUrl" value="ListOrdersDisplayTableView" type="Ajax">
	<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
	<wcf:param name="storeId" value="${WCParam.storeId}"/>
	<wcf:param name="langId" value="${WCParam.langId}"/>
</wcf:url>

<flow:ifEnabled feature="AjaxMyAccountPage">
	<wcf:url var="RequisitionListViewURL" value="AjaxLogonForm">
	  <wcf:param name="page" value="createrequisitionlist" />
	  <wcf:param name="langId" value="${langId}" />
	  <wcf:param name="storeId" value="${WCParam.storeId}" />
	  <wcf:param name="catalogId" value="${WCParam.catalogId}" />
	
	</wcf:url>							
</flow:ifEnabled>

<flow:ifDisabled feature="AjaxMyAccountPage">
	<wcf:url var="RequisitionListViewURL" value="RequisitionListDetailView">
	  <wcf:param name="langId" value="${langId}" />
	  <wcf:param name="storeId" value="${WCParam.storeId}" />
	  <wcf:param name="catalogId" value="${WCParam.catalogId}" />
	  <wcf:param name="editable" value="true" />
	  <wcf:param name="newList" value="true" />
	</wcf:url>							
</flow:ifDisabled>
<html  xmlns="http://www.w3.org/1999/xhtml" xmlns:wairole="http://www.w3.org/1999/xhtml"
xmlns:waistate="http://www.w3.org/2005/07/aaa" lang="${shortLocale}" xml:lang="${shortLocale}">
<head>
<title>
	<fmt:message key="SAVED_ORDERS_LIST_TITLE" bundle="${storeText}">
		<fmt:param value="${storeName}"/>
	</fmt:message> 
</title>    
      
<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${vfileStylesheet}"/>" type="text/css"/>
<!--[if lte IE 6]>
<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${vfileStylesheetie}"/>" type="text/css"/>
<![endif]-->
<!--[if gte IE 7]>
<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${vfileStylesheetie7}"/>" type="text/css"/>	
<![endif]-->
<script type="text/javascript" src="<c:out value="${dojoFile}"/>" djConfig="${dojoConfigParams}"></script>
<%@ include file="../../../include/CommonJSToInclude.jspf"%>

<script type="text/javascript" src="<c:out value="${jspStoreImgDir}javascript/MessageHelper.js"/>"></script>
<script type="text/javascript" src="<c:out value="${jspStoreImgDir}javascript/ServicesDeclaration.js"/>"></script>
<script type="text/javascript" src="<c:out value="${jspStoreImgDir}javascript/Vector.js"/>"></script>
<script type="text/javascript" src="<c:out value="${jspStoreImgDir}javascript/UserArea/SavedOrders.js"/>"></script>
<script type="text/javascript" src="<c:out value="${jspStoreImgDir}javascript/CatalogArea/CategoryDisplay.js"/>"></script>
<script type="text/javascript" src="<c:out value="${jspStoreImgDir}javascript/CatalogArea/CatalogEntryThumbnailDisplay.js"/>"></script>

<script type="text/javascript">
	dojo.addOnLoad(function() {
		<fmt:message key="ERR_RESOLVING_SKU" bundle="${storeText}" var="ERR_RESOLVING_SKU"/>
		<fmt:message key="QUANTITY_INPUT_ERROR" bundle="${storeText}" var="QUANTITY_INPUT_ERROR"/>
		<fmt:message key="WISHLIST_ADDED" bundle="${storeText}" var="WISHLIST_ADDED"/>
		<fmt:message key="SHOPCART_ADDED" bundle="${storeText}" var="SHOPCART_ADDED"/>
		<fmt:message key="ERROR_MESSAGE_TYPE" bundle="${storeText}" var="ERROR_MESSAGE_TYPE"/>
		<fmt:message key="ORDERS_CANCELLED" bundle="${storeText}" var="ORDERS_CANCELLED"/>
		<fmt:message key="ORDER_CREATED" bundle="${storeText}" var="ORDER_CREATED"/>
		<fmt:message key="ORDER_SET_CURRENT" bundle="${storeText}" var="ORDER_SET_CURRENT"/>
		<fmt:message key="ORDER_COPIED" bundle="${storeText}" var="ORDER_COPIED"/>
		<fmt:message key="ORDER_NOT_COPIED" bundle="${storeText}" var="ORDER_NOT_COPIED"/>
		<fmt:message key="ORDER_NOT_SET_CURRENT" bundle="${storeText}" var="ORDER_NOT_SET_CURRENT"/>
		<fmt:message key="ORDER_NOT_CANCELLED" bundle="${storeText}" var="ORDER_NOT_CANCELLED"/>
		<fmt:message key="ORDER_NOT_CREATED" bundle="${storeText}" var="ORDER_NOT_CREATED"/>
		<fmt:message key="ORDER_DESC_NOT_SAVED" bundle="${storeText}" var="ORDER_DESC_NOT_SAVED"/>
		<fmt:message key="ORDERS_SAVED" bundle="${storeText}" var="ORDERS_SAVED"/>
		<fmt:message key="ORDER_NOT_SAVED" bundle="${storeText}" var="ORDER_NOT_SAVED"/>
		<fmt:message key="ERROR_CONTRACT_EXPIRED_GOTO_ORDER" bundle="${storeText}" var="ERROR_CONTRACT_EXPIRED_GOTO_ORDER"/>
		<fmt:message key="GENERICERR_MAINTEXT" bundle="${storeText}" var="ERROR_RETRIEVE_PRICE">                                     
			<fmt:param><fmt:message key="GENERICERR_CONTACT_US" bundle="${storeText}" /></fmt:param>
		</fmt:message>
		
		MessageHelper.setMessage("ERROR_RETRIEVE_PRICE", <wcf:json object="${ERROR_RETRIEVE_PRICE}"/>);
		MessageHelper.setMessage("ERR_RESOLVING_SKU", <wcf:json object="${ERR_RESOLVING_SKU}"/>);
		MessageHelper.setMessage("QUANTITY_INPUT_ERROR", <wcf:json object="${QUANTITY_INPUT_ERROR}"/>);
		MessageHelper.setMessage("WISHLIST_ADDED", <wcf:json object="${WISHLIST_ADDED}"/>);
		MessageHelper.setMessage("SHOPCART_ADDED", <wcf:json object="${SHOPCART_ADDED}"/>);
		MessageHelper.setMessage("ERROR_MESSAGE_TYPE", <wcf:json object="${ERROR_MESSAGE_TYPE}"/>);
		MessageHelper.setMessage("ORDERS_CANCELLED", <wcf:json object="${ORDERS_CANCELLED}"/>);
		MessageHelper.setMessage("ORDER_CREATED", <wcf:json object="${ORDER_CREATED}"/>);
		MessageHelper.setMessage("ORDER_SET_CURRENT", <wcf:json object="${ORDER_SET_CURRENT}"/>);
		MessageHelper.setMessage("ORDER_COPIED", <wcf:json object="${ORDER_COPIED}"/>);
		MessageHelper.setMessage("ORDER_NOT_COPIED", <wcf:json object="${ORDER_NOT_COPIED}"/>);
		MessageHelper.setMessage("ORDER_NOT_SET_CURRENT", <wcf:json object="${ORDER_NOT_SET_CURRENT}"/>);
		MessageHelper.setMessage("ORDER_NOT_CANCELLED", <wcf:json object="${ORDER_NOT_CANCELLED}"/>);
		MessageHelper.setMessage("ORDER_NOT_CREATED", <wcf:json object="${ORDER_NOT_CREATED}"/>);
		MessageHelper.setMessage("ORDER_DESC_NOT_SAVED", <wcf:json object="${ORDER_DESC_NOT_SAVED}"/>);
		MessageHelper.setMessage("ORDERS_SAVED", <wcf:json object="${ORDERS_SAVED}"/>);
		MessageHelper.setMessage("ORDER_NOT_SAVED", <wcf:json object="${ORDER_NOT_SAVED}"/>);
		MessageHelper.setMessage("ERROR_CONTRACT_EXPIRED_GOTO_ORDER", <wcf:json object="${ERROR_CONTRACT_EXPIRED_GOTO_ORDER}"/>);
		  
		ServicesDeclarationJS.setCommonParameters('${WCParam.langId}','${WCParam.storeId}','${WCParam.catalogId}');
		savedOrdersJS.setCommonParameters('${WCParam.langId}','${WCParam.storeId}','${WCParam.catalogId}');
		savedOrdersJS.setImgParameters("ADD_ENABLED","<c:out value='${jspStoreImgDir}' />images/add_reqlist.gif","<fmt:message key="ADD_BUTTON" bundle="${storeText}"/>");
		savedOrdersJS.setImgParameters("ADD_DISABLED","<c:out value='${jspStoreImgDir}' />images/add_reqlist_disabled.gif","<fmt:message key="ADD_BUTTON_DISABLED" bundle="${storeText}"/>");
		savedOrdersJS.setImgParameters("SAVE_ENABLED","<c:out value='${jspStoreImgDir}' />images/order_save.gif","<fmt:message key="SAVE_BUTTON" bundle="${storeText}"/>");
		savedOrdersJS.setImgParameters("SAVE_DISABLED","<c:out value='${jspStoreImgDir}' />images/order_save_disabled.gif","<fmt:message key="SAVE_BUTTON_DISABLED" bundle="${storeText}"/>");
		savedOrdersJS.setImgParameters("COPY_ENABLED","<c:out value='${jspStoreImgDir}' />images/order_copy.gif","<fmt:message key="COPY_BUTTON" bundle="${storeText}"/>");
		savedOrdersJS.setImgParameters("COPY_DISABLED","<c:out value='${jspStoreImgDir}' />images/order_copy_disabled.gif","<fmt:message key="COPY_BUTTON_DISABLED" bundle="${storeText}"/>");
		savedOrdersJS.setImgParameters("CANCEL_ENABLED","<c:out value='${jspStoreImgDir}' />images/order_clear.gif","<fmt:message key="CANCEL_BUTTON" bundle="${storeText}"/>");
		savedOrdersJS.setImgParameters("CANCEL_DISABLED","<c:out value='${jspStoreImgDir}' />images/order_clear_disabled.gif","<fmt:message key="CANCEL_BUTTON_DISABLED" bundle="${storeText}"/>");
		savedOrdersJS.setImgParameters("SET_CURRENT_ORDER_ENABLED","","<fmt:message key="SET_CURRENT_ORDER_ENABLED" bundle="${storeText}"/>");
		savedOrdersJS.setImgParameters("SET_CURRENT_ORDER_DISABLED","","<fmt:message key="SET_CURRENT_ORDER_DISABLED" bundle="${storeText}"/>");
		savedOrdersJS.setRequisitionListViewURL('${RequisitionListViewURL}');
		savedOrdersJS.updateToolbar();  
		CommonControllersDeclarationJS.setControllerURL('ListOrdersDisplay_Controller','<c:out value="${ListOrdersDisplayTableUrl}"/>');
		
		//The current shopping cart will be used as the current order.
		savedOrdersJS.initializeCurrentOrder();
	});
</script>

</head>

<body>
	<%@ include file="../../../include/StoreCommonUtilities.jspf"%>
	<%@ include file="../../../Snippets/ReusableObjects/CatalogEntryQuickInfoDetails.jspf"%>
	<div id="page" class="savedOrdersPage">
	   	<!-- Header Nav Start -->
		<%@ include file="../../../include/LayoutContainerTop.jspf"%>
		<!-- Header Nav End -->

		<!-- Main Content Start -->
		<div id="content759">
   
			<!-- Content Start -->
			<div id="MessageArea" >
				<br />
				<span id="ErrorMessageText" class="error_msg" tabindex="-1"></span>
				<br /><br />
			</div>       
			<div id="box">            
				<div class="saved_orders" id="WC_ListOrdersDisplay_div_1">
					<h1><fmt:message key='SAVED_ORDERS' bundle='${storeText}'/></h1>
					
						<div class="contentgrad_header">

							<div class="left_corner"></div>
							<div class="left"></div>
							<div class="right_corner"></div>
  
													
							<%@ include file="../../../Snippets/ReusableObjects/SavedOrdersToolbar.jspf" %>
						</div>
						<div dojoType="wc.widget.RefreshArea" id="ListOrdersDisplay_Widget" controllerId="ListOrdersDisplay_Controller" role="wairole:region" waistate:live="polite" waistate:atomic="false" waistate:relevant="additions">				
						<% out.flush(); %>
						<c:import url="${jspStoreDir}Snippets/Order/Cart/ListOrdersDisplayTable.jsp" ></c:import>
						<% out.flush();%>				
						</div>
						<script type="text/javascript">
							dojo.addOnLoad(function() { 
									parseWidget("ListOrdersDisplay_Widget");
							});</script>				
						
				  
					<div class="footer" id="WC_ListOrdersDisplay_div_8">
						<div class="left_corner" id="WC_ListOrdersDisplay_div_9"></div>
						<div class="tile" id="WC_ListOrdersDisplay_div_10"></div>
						<div class="right_corner" id="WC_ListOrdersDisplay_div_11"></div>
					</div>
				</div>
 			</div>
			<!-- Content End -->
			
		</div>
		<!-- Main Content End -->
		
		<!-- Footer Start Start -->
		<%@ include file="../../../include/LayoutContainerBottom.jspf"%>  
		<!-- Footer Start End -->
	</div>
	<div id="page_shadow" class="shadow"></div>
	 <flow:ifEnabled feature="Analytics"><cm:pageview/></flow:ifEnabled>
</body>
</html>
