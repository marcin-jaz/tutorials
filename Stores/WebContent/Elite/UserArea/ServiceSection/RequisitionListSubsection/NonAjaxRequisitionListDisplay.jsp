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

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf"%>
<%@ include file="../../../include/nocache.jspf" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>  
<%@ taglib uri="http://commerce.ibm.com/coremetrics"  prefix="cm" %>
<%-- ErrorMessageSetup.jspf is used to retrieve an appropriate error message when there is an error --%>
<%@ include file="../../../include/ErrorMessageSetup.jspf" %>

<c:set var="myAccountPage" value="true" scope="request"/>
<c:set var="hasBreadCrumbTrail" value="false" scope="request"/>

<wcf:url var="addressBookFormURL" value="NonAjaxAddressBookForm">
	<wcf:param name="storeId"   value="${WCParam.storeId}"  />
	<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
	<wcf:param name="langId" value="${langId}" />
</wcf:url>
<wcf:url var="profileFormViewURL" value="NonAjaxProfileFormView">
	<wcf:param name="storeId"   value="${WCParam.storeId}"  />
	<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
	<wcf:param name="langId" value="${langId}" />
</wcf:url>	
<wcf:url var="trackOrderStatusURL" value="NonAjaxTrackOrderStatus">
	<wcf:param name="storeId"   value="${WCParam.storeId}"  />
	<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
	<wcf:param name="langId" value="${langId}" />
</wcf:url>
<wcf:url var="userRegistrationFormURL" value="NonAjaxUserRegistrationForm">
	<wcf:param name="storeId"   value="${WCParam.storeId}"  />
	<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
	<wcf:param name="langId" value="${langId}" />
	<wcf:param name="editRegistration" value="Y" />
</wcf:url>
<wcf:url var="AjaxCheckoutDisplayViewURL" value="AjaxCheckoutDisplayView">
	<wcf:param name="storeId"   value="${WCParam.storeId}"  />
	<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
	<wcf:param name="langId" value="${langId}" />
</wcf:url>
<wcf:url var="PrepareOrderURL" value="OrderProcessServiceOrderPrepare">
	<wcf:param name="storeId"   value="${WCParam.storeId}"  />
	<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
	<wcf:param name="langId" value="${langId}" />
	<wcf:param name="URL" value="${AjaxCheckoutDisplayViewURL}" />
</wcf:url>
<wcf:url var="couponWalletURL" value="NonAjaxCouponWallet" type="Ajax">
	<wcf:param name="storeId"   value="${WCParam.storeId}"  />
	<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
	<wcf:param name="langId" value="${langId}" />
</wcf:url>
<wcf:url var="requisitionListURL" value="RequisitionListDisplayView" type="Ajax">
	<wcf:param name="storeId"   value="${WCParam.storeId}"  />
	<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
	<wcf:param name="langId" value="${langId}" />
</wcf:url>
<wcf:url var="requisitionListCreateView" value="RequisitionListCreateView" type="Ajax">
	<wcf:param name="storeId"   value="${WCParam.storeId}"  />
	<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
	<wcf:param name="langId" value="${langId}" />
	<wcf:param name="newList" value="true"/>
	<wcf:param name="editable" value="true"/>
</wcf:url>

<%-- Retrieve the selected filter option from the context update or URL --%>
<c:set var="filterOption" value="${WCParam.filterOption}"/>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="${shortLocale}" xml:lang="${shortLocale}">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title><fmt:message key="MYACCOUNT_REQUISITION_LISTS" bundle="${storeText}"/></title>
		<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${vfileStylesheet}"/>" type="text/css"/>
	    <!--[if lte IE 6]>
	    	<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${vfileStylesheetie}"/>" type="text/css"/>
	    <![endif]-->		
		<script type="text/javascript" src="<c:out value="${dojoFile}"/>" djConfig="${dojoConfigParams}"></script>
		<%@ include file="../../../include/CommonJSToInclude.jspf"%>
		<script type="text/javascript" src="<c:out value="${jspStoreImgDir}javascript/MessageHelper.js"/>"></script>
		<script type="text/javascript" src="<c:out value="${jspStoreImgDir}javascript/UserArea/MyAccountDisplay.js"/>"></script>
		<%@ include file="../../../include/RequisitionListSetup.jspf"%>
	</head>
	<body>
		<%@ include file="../../../include/StoreCommonUtilities.jspf"%>
		<!-- Page Start -->
		<div id="page">
			<%@ include file="../../../include/LayoutContainerTop.jspf"%>
		
		    	<!-- Main Content Start -->
				<c:set var="myAccountPage" value="true" scope="request"/>
		
				<wcf:url var="AjaxMyAccountCenterLinkDisplayURL" value="AjaxLogonFormCenterLinksDisplayView">    
					<wcf:param name="storeId"   value="${WCParam.storeId}"  />
					<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
					<wcf:param name="langId" value="${langId}" />
				</wcf:url>
		
				<div id="box">
					<c:if test="${!empty errorMessage}">	
						<div class="error_msg requisitionListBorder" id="WC_NonAjaxRequisitionListDisplay_div_errorMessage">
							<c:out value="${errorMessage}"/>
						</div>	
					</c:if>
					
					<div class="my_account" id="WC_NonAjaxRequisitionListDisplay_div_1">		
		
						<div class="main_header" id="WC_NonAjaxRequisitionListDisplay_div_2">
							<div class="left_corner" id="WC_NonAjaxRequisitionListDisplay_div_3"></div>
							<div class="left" id="WC_NonAjaxRequisitionListDisplay_div_4">
								<span class="main_header_text">
									<fmt:message key='MYACCOUNT_REQUISITION_LISTS' bundle='${storeText}'/>
								</span>
							</div>
							<div class="right_corner" id="WC_NonAjaxRequisitionListDisplay_div_5"></div>
						</div>
				
						<div class="content_header" id="WC_NonAjaxRequisitionListDisplay_div_6">
							<div class="left_corner" id="WC_NonAjaxRequisitionListDisplay_div_7"></div>
							<div class="addrbook_header" id="WC_NonAjaxRequisitionListDisplay_div_8">
								<form name="RequisitionListsTypeForm" action="RequisitionListDisplayView" method="post" id="RequisitionListsTypeForm">
									<input type="hidden" name="storeId" value="<c:out value="${WCParam.storeId}"/>" id="WC_NonAjaxRequisitionListDisplay_FormInput_storeId"/>
									<input type="hidden" name="langId" value="<c:out value="${langId}"/>" id="WC_NonAjaxRequisitionListDisplay_FormInput_langId"/>
									<input type="hidden" name="catalogId" value="<c:out value="${WCParam.catalogId}"/>" id="WC_NonAjaxRequisitionListDisplay_FormInput_catalogId"/>	
									
									<label for="filterOption"><fmt:message key="REQUISITIONLIST_VIEW" bundle="${storeText}"/></label>
									<select width="10" name="filterOption" id="filterOption" class="drop_down"
									onchange="javascript:setCurrentId('filterOption');RequisitionList.filterRequisitionList(this,document.RequisitionListsTypeForm);">
										<c:choose>
										<c:when test="${filterOption eq 'Mylists'}">
											<option value="All"><fmt:message key="REQUISITIONLIST_VIEW_ALL" bundle="${storeText}"/></option>
											<option value="Mylists" selected="selected"><fmt:message key="REQUISITIONLIST_VIEW_MYLISTS" bundle="${storeText}"/></option>
										</c:when>
										<c:otherwise>
											<option value="All" selected="selected"><fmt:message key="REQUISITIONLIST_VIEW_ALL" bundle="${storeText}"/></option>
											<option value="Mylists"><fmt:message key="REQUISITIONLIST_VIEW_MYLISTS" bundle="${storeText}"/></option>
										</c:otherwise>
										</c:choose>
									</select>
								</form>
							</div>						
							<div class="sixpixels"></div>
							<div id="WC_NonAjaxRequisitionListDisplay_div_9" class="addrbook_header">		
								<span class="primary_button button_fit" id="WC_NonAjaxRequisitionListDisplay_div_10">
								   <span class="button_container">
								      <span class="button_bg">
								         <span class="button_top">
								            <span class="button_bottom">
								               <a href="<c:out value='${requisitionListCreateView}'/>" id="WC_NonAjaxRequisitionListDisplay_AddNewList">
								                  <fmt:message key="REQUISITIONLIST_ADD_NEW" bundle="${storeText}"/>
								               </a>
								            </span>
								         </span>
								      </span>
								   </span>
								</span>
							</div>
							<div id="WC_NonAjaxRequisitionListDisplay_div_11" class="right_corner"></div>
						</div>		
										
						<div class="body" id="RequisitionListDisplay_Widget_id">	
							<div dojoType="wc.widget.RefreshArea" id="RequisitionListDisplay_Widget" controllerId="RequisitionListDisplay_Controller" role="wairole:region" waistate:live="polite" waistate:atomic="false" waistate:relevant="all">												
								<div id="WC_NonAjaxRequisitionListDisplay_div_12" class="requisitionListBorder">					
									<%out.flush();%>
									<c:import url="${jspStoreDir}UserArea/ServiceSection/RequisitionListSubsection/RequisitionListTableDisplay.jsp">
									</c:import>
									<%out.flush();%>
								</div>
							</div>	
							<script type="text/javascript">dojo.addOnLoad(function() { parseWidget("RequisitionListDisplay_Widget"); } );</script>
									
						</div>			
						
						<div class="footer" id="WC_NonAjaxRequisitionListDisplay_div_13">
						  <div class="left_corner" id="WC_NonAjaxRequisitionListDisplay_div_14"></div>
						  <div class="tile" id="WC_NonAjaxRequisitionListDisplay_div_15"></div>
						  <div class="right_corner" id="WC_NonAjaxRequisitionListDisplay_div_16"></div>
						</div>
					</div>
				  </div>
			<%@ include file="../../../include/LayoutContainerBottom.jspf"%>
		</div>
		<div id="page_shadow" class="shadow"></div>
		 <flow:ifEnabled feature="Analytics"><cm:pageview/></flow:ifEnabled>
	</body>
</html>
					