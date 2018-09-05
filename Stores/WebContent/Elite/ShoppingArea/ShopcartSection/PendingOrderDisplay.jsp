<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2007, 2009 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>
<%--
  *****
  * This JSP file displays the pending order details page. It shows shopping cart details plus lets the shopper
  * initiate the checkout process either as a guest user, a registered user, or as a registered user
  * that has a quick checkout profile saved with the store.
  *****
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ taglib uri="http://commerce.ibm.com/coremetrics"  prefix="cm" %>
<%@ include file="../../include/JSTLEnvironmentSetup.jspf"%>
<%@ include file="../../include/nocache.jspf"%>

<%@ include file="../../include/ErrorMessageSetup.jspf" %>
<c:set var="orderId" value="${param.orderId}"/>
<c:if test="${empty orderId}">
	<c:set var="orderId" value="${WCParam.orderId}"/>
</c:if>

<wcf:url var="currentShoppingCartLink" value="ShopCartPageView" type="Ajax">
	<wcf:param name="storeId"   value="${WCParam.storeId}"  />
	<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
	<wcf:param name="langId" value="${WCParam.langId}" />
	<wcf:param name="orderId" value="${orderId}" />
	<wcf:param name="fromPage" value="pendingOrderDisplay" />
	
</wcf:url>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:wairole="http://www.w3.org/2005/01/wai-rdf/GUIRoleTaxonomy#"
xmlns:waistate="http://www.w3.org/2005/07/aaa" lang="${shortLocale}" xml:lang="${shortLocale}">
       <head>
              <title><fmt:message key="PENDING_ORDER_HEADER_TITLE" bundle="${storeText}" /></title>
              <link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${vfileStylesheet}"/>" type="text/css"/>
              <!--[if lte IE 6]>
              <link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${vfileStylesheetie}"/>" type="text/css"/>
              <![endif]-->
              <script type="text/javascript" src="<c:out value="${dojoFile}"/>" djConfig="${dojoConfigParams}"></script>
              <%@ include file="../../include/CommonJSToInclude.jspf"%>
              <script type="text/javascript" src="<c:out value="${jspStoreImgDir}javascript/CatalogArea/CategoryDisplay.js"/>"></script>
              <script type="text/javascript" src="<c:out value="${jspStoreImgDir}javascript/MessageHelper.js"/>"></script>
              <script type="text/javascript" src="<c:out value="${jspStoreImgDir}javascript/CheckoutArea/CheckoutHelper.js"/>"></script>
              <script type="text/javascript" src="<c:out value="${jspStoreImgDir}javascript/UserArea/LogonForm.js"/>"></script>
              <script type="text/javascript" src="<c:out value="${jspStoreImgDir}javascript/ServicesDeclaration.js"/>"></script>
              <script type="text/javascript" src="<c:out value="${jspStoreImgDir}javascript/Vector.js"/>"></script>
              <script type="text/javascript" src="<c:out value="${jspStoreImgDir}javascript/UserArea/SavedOrders.js"/>"></script>
	      	  <script type="text/javascript" src="<c:out value="${jspStoreImgDir}javascript/CheckoutArea/ShipmodeSelectionExt.js"/>"></script>
	      	  
              <script type="text/javascript">
                     dojo.addOnLoad(function() { 
                     		<fmt:message key="ERR_RESOLVING_SKU" bundle="${storeText}" var="ERR_RESOLVING_SKU" />
							<fmt:message key="QUANTITY_INPUT_ERROR" bundle="${storeText}" var="QUANTITY_INPUT_ERROR" />
							<fmt:message key="REQUIRED_FIELD_ENTER" bundle="${storeText}" var="PROMOTION_CODE_EMPTY"/>
							<fmt:message key="WISHLIST_ADDED" bundle="${storeText}" var="WISHLIST_ADDED" />
							<fmt:message key="SHOPCART_ADDED" bundle="${storeText}" var="SHOPCART_ADDED" />
							<fmt:message key="SHOPCART_REMOVEITEM" bundle="${storeText}" var="SHOPCART_REMOVEITEM"/>
							<fmt:message key="ERROR_MESSAGE_TYPE" bundle="${storeText}" var="ERROR_MESSAGE_TYPE" />	                     		
                     		<fmt:message key="ORDER_SET_CURRENT" bundle="${storeText}" var="ORDER_SET_CURRENT"/>
                     		<fmt:message key="ORDER_NOT_SET_CURRENT" bundle="${storeText}" var="ORDER_NOT_SET_CURRENT"/>
                     		<fmt:message key="ORDERS_SAVED" bundle="${storeText}" var="ORDERS_SAVED"/>
                     		<fmt:message key="ORDER_NOT_SAVED" bundle="${storeText}" var="ORDER_NOT_SAVED"/>                     		
                     		<fmt:message key="PENDING_ORDER_SAVED" bundle="${storeText}" var="PENDING_ORDER_SAVED"/>
                     		<fmt:message key="PENDING_ORDER_NOT_SAVED" bundle="${storeText}" var="PENDING_ORDER_NOT_SAVED"/>
                     		<fmt:message key="ORDER_DESC_NOT_SAVED" bundle="${storeText}" var="ORDER_DESC_NOT_SAVED"/>
                     		<fmt:message key="ERROR_UPDATE_FIRST_SHOPPING_CART" bundle="${storeText}" var="ERROR_UPDATE_FIRST_SHOPPING_CART"/>
                     		<fmt:message key="PROMOTION_CODE_EMPTY" bundle="${storeText}" var="PROMOTION_CODE_EMPTY"/>
                     		<fmt:message key="ERROR_CONTRACT_EXPIRED_GOTO_ORDER" bundle="${storeText}" var="ERROR_CONTRACT_EXPIRED_GOTO_ORDER"/>
                     		<fmt:message key="GENERICERR_MAINTEXT" bundle="${storeText}" var="ERROR_RETRIEVE_PRICE">                                     
													<fmt:param><fmt:message key="GENERICERR_CONTACT_US" bundle="${storeText}" /></fmt:param>
												</fmt:message>
												
														MessageHelper.setMessage("ERROR_RETRIEVE_PRICE", <wcf:json object="${ERROR_RETRIEVE_PRICE}"/>);
                            MessageHelper.setMessage("ERR_RESOLVING_SKU", <wcf:json object="${ERR_RESOLVING_SKU}"/>);
                            MessageHelper.setMessage("QUANTITY_INPUT_ERROR", <wcf:json object="${QUANTITY_INPUT_ERROR}"/>);
                            MessageHelper.setMessage("REQUIRED_FIELD_ENTER", <wcf:json object="${REQUIRED_FIELD_ENTER}"/>);
                            MessageHelper.setMessage("WISHLIST_ADDED", <wcf:json object="${WISHLIST_ADDED}"/>);
                            MessageHelper.setMessage("SHOPCART_ADDED", <wcf:json object="${SHOPCART_ADDED}"/>);
                            MessageHelper.setMessage("SHOPCART_REMOVEITEM", <wcf:json object="${SHOPCART_REMOVEITEM}"/>);
                            MessageHelper.setMessage("ERROR_MESSAGE_TYPE", <wcf:json object="${ERROR_MESSAGE_TYPE}"/>);
                            MessageHelper.setMessage("ORDER_SET_CURRENT", <wcf:json object="${ORDER_SET_CURRENT}"/>);
                            MessageHelper.setMessage("ORDER_NOT_SET_CURRENT", <wcf:json object="${ORDER_NOT_SET_CURRENT}"/>);
                            MessageHelper.setMessage("ORDERS_SAVED", <wcf:json object="${ORDERS_SAVED}"/>);
							MessageHelper.setMessage("ORDER_NOT_SAVED", <wcf:json object="${ORDER_NOT_SAVED}"/>);
                            MessageHelper.setMessage("PENDING_ORDER_SAVED", <wcf:json object="${PENDING_ORDER_SAVED}"/>);
							MessageHelper.setMessage("PENDING_ORDER_NOT_SAVED", <wcf:json object="${PENDING_ORDER_NOT_SAVED}"/>);
							MessageHelper.setMessage("ORDER_DESC_NOT_SAVED", <wcf:json object="${ORDER_DESC_NOT_SAVED}"/>);
                            categoryDisplayJS.setCommonParameters('<c:out value='${WCParam.langId}'/>','<c:out value='${WCParam.storeId}'/>','<c:out value='${WCParam.catalogId}'/>','<c:out value='${userType}'/>');
                            ServicesDeclarationJS.setCommonParameters('<c:out value='${WCParam.langId}'/>','<c:out value='${WCParam.storeId}'/>','<c:out value='${WCParam.catalogId}'/>');
                            MessageHelper.setMessage("ERROR_UPDATE_FIRST_SHOPPING_CART", <wcf:json object="${ERROR_UPDATE_FIRST_SHOPPING_CART}"/>);
                            MessageHelper.setMessage("PROMOTION_CODE_EMPTY", <wcf:json object="${PROMOTION_CODE_EMPTY}"/>);
                            MessageHelper.setMessage("ERROR_CONTRACT_EXPIRED_GOTO_ORDER", <wcf:json object="${ERROR_CONTRACT_EXPIRED_GOTO_ORDER}"/>);
			    			ShipmodeSelectionExtJS.setCommonParameters('<c:out value='${WCParam.langId}'/>','<c:out value='${WCParam.storeId}'/>','<c:out value='${WCParam.catalogId}'/>');
                    		savedOrdersJS.setCommonParameters('${WCParam.langId}','${WCParam.storeId}','${WCParam.catalogId}');
                    		savedOrdersJS.isOrderDetailsPage(true);
                    		savedOrdersJS.setImgParameters("SAVE_ENABLED","<c:out value='${jspStoreImgDir}' />images/order_save.gif","<fmt:message key="SAVE_BUTTON" bundle="${storeText}"/>");
							savedOrdersJS.setImgParameters("SAVE_DISABLED","<c:out value='${jspStoreImgDir}' />images/order_save_disabled.gif","<fmt:message key="SAVE_BUTTON_DISABLED" bundle="${storeText}"/>");
							categoryDisplayJS.setOrderId('${orderId}');
                    		CheckoutHelperJS.setOrderId('${orderId}');
                    		
                     });
              </script>  

              <c:set var="AjaxAddToCart" value="false"/>
              <flow:ifEnabled feature="AjaxAddToCart"> 
                     <c:set var="AjaxAddToCart" value="true"/>
              </flow:ifEnabled>
              
              <c:set var="isAjaxCheckOut" value="true"/>
              <flow:ifDisabled feature="AjaxCheckout"> 
                     <c:set var="isAjaxCheckOut" value="false"/>
              </flow:ifDisabled>
              
              <script type="text/javascript">
                     dojo.addOnLoad(shopCartPageLoaded);
                     
                     function shopCartPageLoaded(){
                            categoryDisplayJS.setAjaxShopCart(<c:out value='${AjaxAddToCart && isAjaxCheckOut}'/>);
                            CheckoutHelperJS.setAjaxCheckOut(<c:out value="${isAjaxCheckOut}"/>);
                          
                            CheckoutHelperJS.pendingOrderDetailsPage="true";
                     }
              </script>
              
              <script type="text/javascript">
              
                     dojo.addOnLoad(initGetTimeZone);
              
                     function initGetTimeZone(){
                            // get the browser's current date and time
                            var d = new Date();
                            
                            // find the timeoffset between browser time and GMT
                            var timeOffset = -d.getTimezoneOffset()/60;
              
                            // store the time offset in cookie
                            var gmtTimeZone;
                            if (timeOffset < 0)
                                   gmtTimeZone = "GMT" + timeOffset;
                            else if (timeOffset == 0)
                                   gmtTimeZone = "GMT";
                            else
                                   gmtTimeZone = "GMT+" + timeOffset;
                                   
                            dojo.cookie("WC_timeoffset", gmtTimeZone);
                     }
              </script>
              
              <wcf:url var="PendingOrderItemDisplayViewURL" value="PendingOrderItemDisplayView" type="Ajax">
                <wcf:param name="langId" value="${langId}" />                                          
                <wcf:param name="storeId" value="${WCParam.storeId}" />
                <wcf:param name="catalogId" value="${WCParam.catalogId}" />
                 <wcf:param name="orderId" value="${param.orderId}" />
              </wcf:url>     
              
              <%-- This following section is only loaded and executed if the current page flow is non-AJAX --%>
              <c:if test="${!isAjaxCheckOut}">
                     <script type="text/javascript">
                            ///////////////////////////////////////////////////
                            // summary              : Set a dirty flag
                            // description       : Set a dirty flag in CheckoutPayments.js when the user modifies order item quantities in a non-AJAX shopping cart
                            //
                            // event              : DOM/Dojo/Dijit event, e.g. onclick, onchange, etc.
                            // assumptions       : Used in non-AJAX checkout flow
                            // dojo API              : 
                            // returns              : void
                            ///////////////////////////////////////////////////
                            function setDirtyFlag(){
                                   CheckoutHelperJS.setFieldDirtyFlag(true);
                                   console.debug("Order item information on the Shopping Cart page was modified.");
                            }
                            
                            /////////////////////////////////////////////////////////////////////////
                            // On page load, add editable fields in the shipping information
                            // section to Dojo event listener so that when they are changed by the
                            // user, the user is required to to update the shopping cart before
                            // proceeding to checkout.
                            /////////////////////////////////////////////////////////////////////////
                            dojo.addOnLoad(CheckoutHelperJS.initDojoEventListenerShoppingCartPage);
                     </script>
              </c:if>
       </head>

  <body>
 
       <c:set var="shoppingCartPage" value="false" scope="request"/>
       <c:set var="hasBreadCrumbTrail" value="true" scope="request"/>
       <c:set var="useHomeRightSidebar" value="false" scope="request"/>
       <c:set var="pendingOrderDetailsPage" value="true" scope="request"/> 
  
        <%@ include file="../../include/StoreCommonUtilities.jspf"%>
        
       <div id="page">
              <%@ include file="../../include/LayoutContainerTop.jspf"%>
              <script type="text/javascript">
                     dojo.addOnLoad(function() {
                            CommonControllersDeclarationJS.setControllerURL('PendingOrderDisplayController','<c:out value="${PendingOrderItemDisplayViewURL}"/>');
                            CommonControllersDeclarationJS.setControllerURL('PendingOrderPaginationDisplayController','<c:out value="${currentShoppingCartLink}"/>');
                            checkForErrors();
                     });
                     
                 	function checkForErrors(){
                 		<c:if test="${!empty errorMessage}">
                 			MessageHelper.displayErrorMessage(<wcf:json object="${errorMessage}"/>); 
                 		</c:if>	
                 	}
               
              </script>
              <div id="content_wrapper_box">
	              <div id="MessageArea" >
	                     <br />
						<span id="ErrorMessageText" class="error_msg" tabindex="-1">
	                           
	                     </span>
	                     <br /><br />  
	              </div>
                     <%@ include file="../../Snippets/Order/Cart/B2BOrderPricingPopup.jspf" %>
                     <%@ include file="../../Snippets/ReusableObjects/CatalogEntryQuickInfoDetails.jspf" %>
                     <%@ include file="../../Snippets/Marketing/Promotions/PromotionChoiceOfFreeGiftsPopup.jspf" %>
     
                     <flow:ifDisabled feature="AjaxCheckout">
                            <form name="ReplaceItemForm" method="post" action="OrderChangeServiceItemDelete" id="ReplaceItemForm">
                                   <!-- Define all the hidden fields required for submitting this form in case of Non-Ajax Checkout -->
                                   <input type="hidden" name="storeId" value='<c:out value="${storeId}"/>' id="WC_OrderItemDisplay_inputs_2"/>
                                   <input type="hidden" name="langId" value='<c:out value="${langId}" />' id="WC_OrderItemDisplay_inputs_3"/>
                                   <input type="hidden" name="orderId" value='<c:out value="${order.orderIdentifier.uniqueID}"/>' id="WC_OrderItemDisplay_inputs_4"/>
                                   <input type="hidden" name="catalogId" value='<c:out value="${catalogId}"/>' id="WC_OrderItemDisplay_inputs_5"/>
                                   <input type="hidden" name="errorViewName" value="InvalidInputErrorView" id="WC_OrderItemDisplay_inputs_6"/>
                                   <input type="hidden" name="orderItemId" value="" id="WC_OrderItemDisplay_inputs_7"/>
                                   <input type="hidden" name="URL" value="PendingOrderDisplayView" id="WC_OrderItemDisplay_inputs_1"/>
                                   <input type="hidden" name="calculationUsage" value="-1,-2,-3,-4,-5,-6,-7" id="WC_OrderItemDisplay_inputs_8"/>
                            </form>
                     </flow:ifDisabled>
					
                     <div dojoType="wc.widget.RefreshArea" widgetId="PendingOrderDisplay" id="PendingOrderDisplay" controllerId="PendingOrderDisplayController" role="wairole:region" waistate:live="polite" waistate:atomic="false" waistate:relevant="all">
                            <%out.flush();%>
                            <c:import url="${jspStoreDir}ShoppingArea/ShopcartSection/PendingOrderItemDisplay.jsp"/> 
                            <%out.flush();%>
                     </div> 
                     <script type="text/javascript">
                     dojo.addOnLoad(function() { 
                     parseWidget("PendingOrderDisplay");
                     });
                     </script> 
              </div>
              
              <%@ include file="../../include/LayoutContainerBottom.jspf"%>   
       </div>
       <div id="page_shadow" class="shadow"></div>

<flow:ifEnabled feature="Analytics">
  <c:if test="${order != null}">
	<cm:cart orderType="${order}"/>	
  </c:if>
  <cm:pageview/>
</flow:ifEnabled>
       </body>
 </html>
   


      
