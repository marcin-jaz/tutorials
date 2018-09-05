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
<wcf:url var="requisitionListURL" value="RequisitionListDisplayView">
	<wcf:param name="storeId"   value="${WCParam.storeId}"  />
	<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
	<wcf:param name="langId" value="${langId}" />
	<wcf:param name="requisitionListStyle" value="strong"/>	
</wcf:url>

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


	<form name="RequisitionListDetailForm" method="post" action="RequisitionListUpdate" id="RequisitionListDetailForm">
	 <c:if test="${!empty WCParam.requisitionListId}"><input type="hidden" name="requisitionListId" value="<c:out value="${WCParam.requisitionListId}"/>" id="WC_NonAjaxRequisitionListDetailDisplay_FormInput_0"/></c:if>
         <input type="hidden" name="storeId" value="<c:out value="${WCParam.storeId}"/>" id="WC_NonAjaxRequisitionListDetailDisplay_FormInput_1"/>
         <input type="hidden" name="catalogId" value="<c:out value="${WCParam.catalogId}"/>" id="WC_NonAjaxRequisitionListDetailDisplay_FormInput_2"/>
         <input type="hidden" name="langId" value="<c:out value="${langId}"/>" id="WC_NonAjaxRequisitionListDetailDisplay_FormInput_3"/>
         <input type="hidden" name="URL" value="RequisitionListDetailView?quantity*=&partNumber*=&orderItemId*=" id="WC_NonAjaxRequisitionListDetailDisplay_FormInput_4"/>
         <input type="hidden" name="errorViewName" value="RequisitionListDetailView" id="WC_NonAjaxRequisitionListDetailDisplay_FormInput_5"/>
         <input type="hidden" name="editable" value="<c:out value="${WCParam.editable }"/>" id="WC_NonAjaxRequisitionListDetailDisplay_FormInput_6"/>
         <input type="hidden" name="calculationUsage" value="-1,-2,-3,-4,-5,-6,-7" id="WC_NonAjaxRequisitionListDetailDisplay_FormInput_7"/>
         <input type="hidden" name="mergeToCurrentPendingOrder" value="Y" id="WC_NonAjaxRequisitionListDetailDisplay_FormInput_8"/>	
         
         <div id="box">
         	<c:if test="${!empty errorMessage}">
            	<div class="error_msg requisitionListBorder" id="WC_NonAjaxRequisitionListDetailDisplay_div_errorMessage">
                  <c:out value="${errorMessage}"/>
               </div>
            </c:if>
            <div class="my_account" id="WC_NonAjaxRequisitionListDetailDisplay_div_1">
               <div class="main_header" id="WC_NonAjaxRequisitionListDetailDisplay_div_2">
                  <div class="left_corner" id="WC_NonAjaxRequisitionListDetailDisplay_div_3"></div>
                  <div class="left" id="WC_NonAjaxRequisitionListDetailDisplay_div_4">
                     <span class="main_header_text">
                     	<c:choose>							
							<c:when test="${!empty WCParam.requisitionListId}">
								<c:choose>
									<c:when test="${WCParam.editable == 'true'}">
										<fmt:message key="MYACCOUNT_REQUISITION_LISTS_EDIT" bundle="${storeText}"/>
									</c:when>
									<c:otherwise>
										<fmt:message key="MYACCOUNT_REQUISITION_LISTS_VIEW" bundle="${storeText}"/>
									</c:otherwise>
								</c:choose>								
							</c:when>
							<c:otherwise>
								<fmt:message key="MYACCOUNT_REQUISITION_LISTS_CREATE" bundle="${storeText}"/>
							</c:otherwise>										
						</c:choose>
                     </span>
                  </div>
                  <div class="right_corner" id="WC_NonAjaxRequisitionListDetailDisplay_div_5"></div>
               </div>

               <div class="body" id="WC_NonAjaxRequisitionListDetailDisplay_div_6">   
                     <c:import url="${jspStoreDir}UserArea/ServiceSection/RequisitionListSubsection/RequisitionListAddForm.jsp">
                     	<c:param name="editable" value="${WCParam.editable}"/>
                     </c:import>
                     
                     <%-- only show this fragment if catEntryId is empty (meaning that the user comes from the product detail page) 
                     and editable is true, meaning the user has the rights add items to the requisition list --%>
                     <c:if test="${WCParam.editable == 'true' && !empty WCParam.requisitionListId}">        
	                     <c:import url="${jspStoreDir}UserArea/ServiceSection/RequisitionListSubsection/RequisitionListDetailAddForm.jsp">
	                     	<c:param name="editable" value="${WCParam.editable}"/>
	                     </c:import>
	                 </c:if>
	                 
	                 <div dojoType="wc.widget.RefreshArea" id="RequisitionListDetailTableDisplay_Widget" controllerId="RequisitionListDetailTableDisplay_Controller" role="wairole:region" waistate:live="polite" waistate:atomic="false" waistate:relevant="all">
						 <%out.flush();%>
						 <c:import url="${jspStoreDir}UserArea/ServiceSection/RequisitionListSubsection/RequisitionListDetailTable.jsp">
						 	<c:param name="editable" value="${WCParam.editable}"/>
	                     </c:import>
						 <%out.flush();%>
					 </div>
					 <script type="text/javascript">dojo.addOnLoad(function() { parseWidget("RequisitionListDetailTableDisplay_Widget"); } );</script>
					 
               </div>
               
               
               <div class="content_footer" id="add_new_requisition_list_footer">
                  <div class="left_corner" id="WC_NonAjaxRequisitionListDetailDisplay_div_7"></div>
                  <div class="button_footer_line" id="WC_NonAjaxRequisitionListDetailDisplay_div_8">

	               <c:choose>
                  		<c:when test="${empty WCParam.requisitionListId}">                         
                            <c:choose>
                                <c:when test="${!empty WCParam.catEntryId }">
						            <span class="primary_button button_fit" id="WC_NonAjaxRequisitionListDetailDisplay_div_9">
					                    <span class="button_container">
					                       <span class="button_bg">
					                          <span class="button_top">
					                             <span class="button_bottom">	    
						                            <a href="javascript:setCurrentId('WC_RequisitionListDetailDisplay_CreateList'); RequisitionList.createNewListFromProductDetail('RequisitionListDetailForm');" id="WC_RequisitionListDetailDisplay_CreateList">
						                               <fmt:message key="REQUISITIONLIST_CREATE_NEW" bundle="${storeText}"/>
						                            </a> 
		    			               			  </span>
					                           </span>
					                      </span>
					                   </span>
					                 </span>           	
                                </c:when>
								<c:when test="${!empty WCParam.orderId}">
									<span class="primary_button button_fit" id="WC_NonAjaxRequisitionListDetailDisplay_div_9">
					                    <span class="button_container">
					                       <span class="button_bg">
					                          <span class="button_top">
					                             <span class="button_bottom">	    
				                                    <a href="javascript:setCurrentId('WC_RequisitionListDetailDisplay_CreateList2'); RequisitionList.createReqListFromOrder('RequisitionListDetailForm','<c:out value="${WCParam.orderId}"/>');"  id="WC_AjaxRequisitionListDetailDisplay_CreateList2">
				                                       <fmt:message key="REQUISITIONLIST_CREATE_NEW" bundle="${storeText}"/>
				                                    </a>
		              			               	 </span>
					                           </span>
					                      </span>
					                   </span>
					                 </span>
								</c:when>					                                
								<c:otherwise>
									<span class="primary_button button_fit" id="WC_NonAjaxRequisitionListDetailDisplay_div_9">
					                    <span class="button_container">
					                       <span class="button_bg">
					                          <span class="button_top">
					                             <span class="button_bottom">	    
				                                    <a href="javascript:setCurrentId('WC_RequisitionListDetailDisplay_CreateList3'); RequisitionList.updateReqList('RequisitionListDetailForm');"  id="WC_RequisitionListDetailDisplay_CreateList3">
				                                       <fmt:message key="REQUISITIONLIST_CREATE_NEW" bundle="${storeText}"/>
				                                    </a>
												</span>
					                           </span>
					                      </span>
					                   </span>
					                 </span>
								</c:otherwise>										
							</c:choose>					                            

			                 <div class="sixpixels"></div>	                 					                            
                  		</c:when>
                  		<c:when test="${!empty WCParam.requisitionListId && WCParam.editable == 'true'}">
							<span class="primary_button button_fit" id="WC_NonAjaxRequisitionListDetailDisplay_div_9b">
			                    <span class="button_container">
			                       <span class="button_bg">
			                          <span class="button_top">
			                             <span class="button_bottom">					                  			                  		
				                            <a href="javascript:setCurrentId('RequisitionList_UpdateList');RequisitionList.updateReqList('RequisitionListDetailForm','<c:out value="${WCParam.requisitionListId}"/>')" id="RequisitionList_UpdateList">
				                               <fmt:message key="REQUISITIONLIST_UPDATE" bundle="${storeText}"/>
				                            </a>
			               			      </span>
			                         </span>
			                      </span>
			                   </span>
			               </span>	
		                     <span class="sixpixels"></span>			                            	                     
                  		</c:when>                  		
                 	  </c:choose>

                     <c:choose>
                     	<c:when test="${empty WCParam.requisitionListId}">
							<span class="secondary_button button_fit" id="WC_NonAjaxRequisitionListDetailDisplay_div_10">
			                   <span class="button_container">
			                      <span class="button_bg">
			                         <span class="button_top">
			                            <span class="button_bottom">
		                                    <a href="javascript:history.back()" id="WC_NonAjaxRequisitionListAdd_CancelCreate">
		                                       <fmt:message key="REQUISITIONLIST_CREATE_CANCEL" bundle="${storeText}"/>
		                                    </a>
				                        </span>
		                            </span>
		                          </span>
		                       </span>
		                    </span>  
		               </c:when>
		               <c:otherwise>
						<span class="primary_button button_fit" id="WC_NonAjaxRequisitionListDetailDisplay_div_10">
		                   <span class="button_container">
		                      <span class="button_bg">
		                         <span class="button_top">
		                            <span class="button_bottom">
			                          <a href="javascript:setCurrentId('WC_RequisitionListDetailDisplay_PlaceOrder'); RequisitionList.placeOrder(document.RequisitionListDetailForm);" id="WC_RequisitionListDetailDisplay_PlaceOrder">
			                             <fmt:message key="REQUISITIONLIST_PLACE_ORDER" bundle="${storeText}"/>
			                          </a>
									</span>
	                            </span>
	                          </span>
	                       </span>
	                    </span>
      			        <span class="sixpixels"></span>
	           				<span class="secondary_button button_fit" id="WC_NonAjaxRequisitionListDetailDisplay_div_9b_cancel">
		                        <span class="button_container">
		                           <span class="button_bg">
		                              <span class="button_top">
		                                 <span class="button_bottom">
		                                    <a href="<c:out value="${requisitionListURL}"/>">
		                                       <fmt:message key="REQUISITIONLIST_CREATE_CANCEL" bundle="${storeText}"/>
		                                    </a>
				                         </span>
		                              </span>
		                           </span>
		                        </span>
		                     </span>  
		               </c:otherwise>
		            </c:choose> 
                                       
                  </div>                  
                  <div class="right_corner" id="WC_NonAjaxRequisitionListDetailDisplay_div_11"></div>
               </div>
            </div>
         </div>
		</form>
         <!-- Main Content Start -->

         <%@ include file="../../../include/LayoutContainerBottom.jspf"%>
      </div>
      <div id="page_shadow" class="shadow"></div>
	   <flow:ifEnabled feature="Analytics"><cm:pageview/></flow:ifEnabled>
   </body>
</html>
