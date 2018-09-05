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
  *	This JSP displays a form for adding partNumbers to an order in a quick manner.
  *****
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ taglib uri="http://commerce.ibm.com/coremetrics"  prefix="cm" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf" %>
<%@ include file="../../../include/nocache.jspf" %>
<%@ include file="../../../include/ErrorMessageSetup.jspf"%>

<c:set var="topCategoryPage" value="true" scope="request"/>
<c:set var="hasBreadCrumbTrail" value="true" scope="request"/>
<c:set var="useHomeRightSidebar" value="true" scope="request"/>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="${shortLocale}" xml:lang="${shortLocale}">
<head>
<title><fmt:message key="Quick_Title" bundle="${storeText}"/></title>
<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${vfileStylesheet}"/>" type="text/css"/>
<!--[if lte IE 6]>
<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${vfileStylesheetie}"/>" type="text/css"/>
<![endif]-->
<script type="text/javascript" src="<c:out value="${dojoFile}"/>" djConfig="${dojoConfigParams}"></script>
<%@ include file="../../../include/CommonJSToInclude.jspf"%>
<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/Miscellaneous/QuickOrder.js"/>"></script>
<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/MessageHelper.js"/>"></script>
<script type="text/javascript">
	<fmt:message key="ERR_RESOLVING_SKU" bundle="${storeText}" var="ERR_RESOLVING_SKU" />
	<fmt:message key="QUANTITY_INPUT_ERROR" bundle="${storeText}" var="QUANTITY_INPUT_ERROR" />
	<fmt:message key="WISHLIST_ADDED" bundle="${storeText}" var="WISHLIST_ADDED" />
	<fmt:message key="SHOPCART_ADDED" bundle="${storeText}" var="SHOPCART_ADDED" />
	<fmt:message key="ERROR_MESSAGE_TYPE" bundle="${storeText}" var="ERROR_MESSAGE_TYPE" />	
	<fmt:message key="ERROR_CONTRACT_EXPIRED_GOTO_ORDER" bundle="${storeText}" var="ERROR_CONTRACT_EXPIRED_GOTO_ORDER" />	
	<fmt:message key="GENERICERR_MAINTEXT" bundle="${storeText}" var="ERROR_RETRIEVE_PRICE">                                     
		<fmt:param><fmt:message key="GENERICERR_CONTACT_US" bundle="${storeText}" /></fmt:param>
	</fmt:message>
		
	MessageHelper.setMessage("ERROR_RETRIEVE_PRICE", <wcf:json object="${ERROR_RETRIEVE_PRICE}"/>);
	MessageHelper.setMessage("ERR_RESOLVING_SKU", <wcf:json object="${ERR_RESOLVING_SKU}"/>);
	MessageHelper.setMessage("QUANTITY_INPUT_ERROR", <wcf:json object="${QUANTITY_INPUT_ERROR}"/>);
	MessageHelper.setMessage("WISHLIST_ADDED", <wcf:json object="${WISHLIST_ADDED}"/>);
	MessageHelper.setMessage("SHOPCART_ADDED", <wcf:json object="${SHOPCART_ADDED}"/>);
	MessageHelper.setMessage("ERROR_MESSAGE_TYPE", <wcf:json object="${ERROR_MESSAGE_TYPE}"/>);
	MessageHelper.setMessage("ERROR_CONTRACT_EXPIRED_GOTO_ORDER", <wcf:json object="${ERROR_CONTRACT_EXPIRED_GOTO_ORDER}"/>);

	dojo.addOnLoad(function() {
		quickOrderJS.setCommonParameters('<c:out value='${WCParam.langId}'/>','<c:out value='${WCParam.storeId}'/>','<c:out value='${WCParam.catalogId}'/>', "<fmt:message key="Quick_Script_Empty_All" bundle="${storeText}"/>", "<fmt:message key="Quick_Script_Non_Integer" bundle="${storeText}"/>");
	});
</script>

</head>

<body>
<%@ include file="../../../include/StoreCommonUtilities.jspf"%>
<!-- Page Start -->
<div id="page">
	<%@ include file="../../../include/LayoutContainerTop.jspf"%>
	
	<!-- Main Content Start -->
	<div id="content_wrapper_box">
		
		<!-- Content Start -->
		<div id="MessageArea" >
			<br />
			<span id="ErrorMessageText" class="error_msg" tabindex="-1">
				
			</span>
			<br /><br />  
		</div>
		
		<div id="content588">
			<div id="box">
				<div class="main_header" id="WC_QuickOrderForm_div_1">
					<div class="left_corner" id="WC_QuickOrderForm_div_2"></div>
					<div class="left" id="WC_QuickOrderForm_div_3"><span class="main_header_text"><fmt:message key="Quick_Title" bundle="${storeText}"/></div>
					<div class="right_corner" id="WC_QuickOrderForm_div_4"></div>
				</div>
				<div class="body588" id="WC_QuickOrderForm_div_5">
					<div id="quick_order"> <span><fmt:message key="Quick_Text" bundle="${storeText}"/></span> <br clear="left" />
						<br />
						<%-- display error message if any --%>
						<div class="error_text" id="WC_QuickOrderForm_div_6">
	  					<c:if test="${!empty errorMessage}">
								<span class="error"><c:out value="${errorMessage}"/><br /><br /></span>
							</c:if>					
						</div>
						
						<div class="input_form" id="WC_QuickOrderForm_div_7">
							<div class="headers" id="WC_QuickOrderForm_div_8">
								<div class="SKU" id="WC_QuickOrderForm_div_9"><fmt:message key="Quick_Col1" bundle="${storeText}"><fmt:param value=""/></fmt:message></div>
								<div class="QTY" id="WC_QuickOrderForm_div_10"><fmt:message key="Quick_Col2" bundle="${storeText}"><fmt:param value=""/></fmt:message></div>
							</div>
							<br clear="left" />
							
							<form name="MQuickOrderForm" method="post" action="OrderChangeServiceItemAdd" id="MQuickOrderForm">
								<input type="hidden" name="storeId" value="<c:out value='${WCParam.storeId}'/>" id="WC_QuickOrderForm_FormInput_storeId_In_MQuickOrderForm_1"/>
								<input type="hidden" name="catalogId" value="<c:out value='${WCParam.catalogId}'/>" id="WC_QuickOrderForm_FormInput_catalogId_In_MQuickOrderForm_1"/>
								<input type="hidden" name="langId" value="<c:out value='${langId}'/>" id="WC_QuickOrderForm_FormInput_langId_In_MQuickOrderForm_1"/>
								<input type="hidden" name="URL" value="AjaxOrderItemDisplayView?storeId=${WCParam.storeId}&catalogId=${WCParam.catalogId}&langId=${WCParam.langId}" id="WC_QuickOrderForm_FormInput_url_${catalogEntryID}"/>
								<%-- <input type="hidden" name="orderId" value="." id="WC_QuickOrderForm_FormInput_orderId_In_MQuickOrderForm_1"/> --%>
								<input type="hidden" name="outOrderName" value="orderId" id="WC_QuickOrderForm_FormInput_outOrderName_In_MQuickOrderForm_1"/>
								<input type="hidden" name="errorViewName" value="QuickOrderView" id="WC_QuickOrderForm_FormInput_errorViewName_<c:out value='${catalogEntryID}'/>"/>
								<input type="hidden" name="calculationUsage" value="-1,-2,-3,-4,-5,-6,-7" id="WC_QuickOrderForm_FormInput_calcUsage_<c:out value='${catalogEntryID}'/>"/>
								<c:set var="x" value="12"/>
								<c:forEach begin="1" end="${x}" var="k" step="1" varStatus="b">
									<c:choose>
										<c:when test="${count == 1}">
											<c:set var="p" value="${count + k - 1}"/>
										</c:when>
										<c:otherwise>
											<c:set var="p" value="${count + k}"/>
										</c:otherwise>
									</c:choose>

									<c:set var="partNumber_p" value="partNumber_${p}"/>
									<c:set var="quantity_p" value="quantity_${p}"/>
									<div class="input" id="WC_QuickOrderForm_div_11_<c:out value='${b.count}'/>">
										<div class="line_number" id="WC_QuickOrderForm_div_12_<c:out value='${b.count}'/>"><c:out value="${p}"/>.</div>
										<div class="input_fields">
											<label class="nodisplay" for="<c:out value="${partNumber_p}"/>">
												<fmt:message key="Quick_Col1" bundle="${storeText}">
													<fmt:param value="${p}"/>
												</fmt:message> 
											</label>
											<input name="<c:out value="${partNumber_p}"/>" id="<c:out value="${partNumber_p}"/>" type="text" class="SKU_field"/>
											<label class="nodisplay" for="<c:out value="${quantity_p}"/>">
												<fmt:message key="Quick_Col2" bundle="${storeText}">
													<fmt:param value="${p}"/>
												</fmt:message> 
											</label>
											<input name="<c:out value="${quantity_p}"/>" id="<c:out value="${quantity_p}"/>" type="text" size="4" />
									</div>
									</div>
								</c:forEach>
								<br />
								<div class="order_button" id="WC_QuickOrderForm_div_13">
									<flow:ifEnabled feature="AjaxAddToCart"> 
										<span class="primary_button button_fit" >
											<span class="button_container">
												<span class="button_bg">
													<span class="button_top">
														<span class="button_bottom">   
															<a href='javaScript: setCurrentId("WC_QuickOrderForm_link_1"); quickOrderJS.addToOrderAjax("MQuickOrderForm");' id="WC_QuickOrderForm_link_1"><fmt:message key="Quick_Add_To_Order" bundle="${storeText}"/></a>
														</span>
													</span>	
												</span>
											</span>
										</span>	
									</flow:ifEnabled>
									<flow:ifDisabled feature="AjaxAddToCart">
										<span class="primary_button button_fit" >
											<span class="button_container">
												<span class="button_bg">
													<span class="button_top">
														<span class="button_bottom">   
															<a href="#" onclick='javaScript: quickOrderJS.addToOrder("MQuickOrderForm");return false;'  id="WC_QuickOrderForm_link_2"><fmt:message key="Quick_Add_To_Order" bundle="${storeText}"/></a>
														</span>
													</span>	
												</span>
											</span>
										</span>	
									</flow:ifDisabled>
								</div>
							</form>
						</div>
								
						<div class="img" id="WC_QuickOrderForm_div_18"><img src="<c:out value="${jspStoreImgDir}images/advertisements/${locale}/" />ad_quick_cart.jpg" alt=""/></div>
						<br clear="all" /><br />
					</div>
				</div>
				<div class="footer" id="WC_QuickOrderForm_div_19">
					<div class="left_corner" id="WC_QuickOrderForm_div_20"></div>
					<div class="tile" id="WC_QuickOrderForm_div_21"></div>
					<div class="right_corner" id="WC_QuickOrderForm_div_22"></div>
				</div>
			</div>
		</div>
		<!-- Content End -->
	</div>
	<!-- Main Content End -->

	<%@ include file="../../../include/LayoutContainerBottom.jspf"%>  
</div>
<div id="page_shadow" class="shadow"></div>
<flow:ifEnabled feature="Analytics"><cm:pageview/></flow:ifEnabled>
</body>
</html>
