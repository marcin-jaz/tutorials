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
<%@ include file="../../../include/nocache.jspf" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %> 
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf" %>

<c:set var="requisitionListId" value="${WCParam.requisitionListId}"/>
<c:set var="editable" value="${WCParam.editable}"/>

<wcf:url var="requisitionListURL" value="AjaxRequisitionListDisplayView" type="Ajax">
	<wcf:param name="storeId"   value="${WCParam.storeId}"  />
	<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
	<wcf:param name="langId" value="${langId}" />
</wcf:url>

<flow:ifDisabled feature="AjaxAddToCart">	
	<form name="RequisitionListDetailForm" method="post" action="AjaxRequisitionListCreate" id="RequisitionListDetailForm">
</flow:ifDisabled>
<input type="hidden" name="requisitionListId" value="<c:out value="${WCParam.requisitionListId}"/>" id="WC_AjaxRequisitionListDetailDisplay_FormInput_0"/>
<input type="hidden" name="storeId" value="<c:out value="${WCParam.storeId}"/>" id="WC_AjaxRequisitionListDetailDisplay_FormInput_1"/>
<input type="hidden" name="catalogId" value="<c:out value="${WCParam.catalogId}"/>" id="WC_AjaxRequisitionListDetailDisplay_FormInput_2"/>
<input type="hidden" name="langId" value="<c:out value="${langId}"/>" id="WC_AjaxRequisitionListDetailDisplay_FormInput_3"/>
<input type="hidden" name="editable" value="<c:out value="${WCParam.editable }"/>" id="WC_AjaxRequisitionListDetailDisplay_FormInput_4"/>
<input type="hidden" name="URL" value="" id="WC_AjaxRequisitionListDetailDisplay_FormInput_5"/>
<input type="hidden" name="numberOfProduct" value="<c:out value="${WCParam.numberOfProduct}"/>" id="WC_AjaxRequisitionListDetailDisplay_FormInput_6"/>
<input type="hidden" name="calculationUsage" value="-1,-2,-3,-4,-5,-6,-7" id="WC_AjaxRequisitionListDetailDisplay_FormInput_7"/>
<input type="hidden" name="mergeToCurrentPendingOrder" value="Y" id="WC_AjaxRequisitionListDetailDisplay_FormInput_8"/>	
		<div class="my_account" id="WC_AjaxRequisitionListDetailDisplay_div_1">			
			<div class="main_header" id="WC_AjaxRequisitionListDetailDisplay_div_2">
				<div class="left_corner" id="WC_AjaxRequisitionListDetailDisplay_div_3"></div>
				<div class="left" id="WC_AjaxRequisitionListDetailDisplay_div_4">
					<span class="main_header_text">
						<c:choose>							
							<c:when test="${!empty requisitionListId}">
								<c:choose>
									<c:when test="${editable == 'true'}">
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
				<div class="right_corner" id="WC_AjaxRequisitionListDetailDisplay_div_5"></div>
			</div>
		
			<div class="body" id="WC_AjaxRequisitionListDetailDisplay_div_6">	
				<c:import url="${jspStoreDir}UserArea/ServiceSection/RequisitionListSubsection/RequisitionListAddForm.jsp">
					<c:param name="editable" value="${editable}"/>
				</c:import>
				
					       				
				<c:if test="${!empty requisitionListId && editable == 'true' }">
						<c:import url="${jspStoreDir}UserArea/ServiceSection/RequisitionListSubsection/RequisitionListDetailAddForm.jsp">
							<c:param name="editable" value="${editable}"/>		
						</c:import>
				</c:if>
				
				<c:if test="${!empty requisitionListId || (!empty WCParam.catEntryId && !empty WCParam.quantity) || (!empty WCParam.orderId)}">
				<%-- displayed if user is editing a requisition list or user is creating a new requisition list from the product detail page --%>
					<div dojoType="wc.widget.RefreshArea" id="RequisitionListDetailTableDisplay_Widget" controllerId="RequisitionListDetailTableDisplay_Controller" role="wairole:region" waistate:live="polite" waistate:atomic="false" waistate:relevant="all">
						<%out.flush();%>
							<c:import url="${jspStoreDir}UserArea/ServiceSection/RequisitionListSubsection/RequisitionListDetailTable.jsp">
								<c:param name="editable" value="${editable}"/>
								<c:param name="orderId" value="${WCParam.orderId}"/>
							</c:import>
						<%out.flush();%>
					</div>
				</c:if>
				
							
		    </div>

			<div class="content_footer" id="add_new_requisition_list_footer">
                 <div class="left_corner" id="WC_AjaxRequisitionListDetailDisplay_div_7"></div>
                 <div class="button_footer_line" id="WC_AjaxRequisitionListDetailDisplay_div_8">
                 	<c:if test="${editable == 'true'}">
	                                 	<c:choose>
											<c:when test="${!empty requisitionListId}">
												<span class="primary_button button_fit" id="WC_AjaxRequisitionListDetailDisplay_div_9">
							                        <span class="button_container">
							                           <span class="button_bg">
							                              <span class="button_top">
							                                 <span class="button_bottom">
							                                    <a href="javascript:setCurrentId('RequisitionList_UpdateList'); RequisitionList.updateReqList('RequisitionListDetailForm','<c:out value="${requisitionListId}"/>');"  id="RequisitionList_UpdateList">
							                                       <fmt:message key="REQUISITIONLIST_UPDATE" bundle="${storeText}"/>
							                                    </a>
									                         </span>
							                              </span>
							                           </span>
							                        </span>
							                     </span>
			                                </c:when>
			                                <c:when test="${!empty catEntryId }">
									             <span class="primary_button button_fit" id="WC_AjaxRequisitionListDetailDisplay_div_9">
							                        <span class="button_container">
							                           <span class="button_bg">
							                              <span class="button_top">
							                                 <span class="button_bottom">
							                    			    <a href="javascript:setCurrentId('WC_RequisitionListDetailDisplay_UpdateList2'); RequisitionList.createNewListFromProductDetail('RequisitionListDetailForm');"  id="WC_RequisitionListDetailDisplay_UpdateList2">
							                                       <fmt:message key="REQUISITIONLIST_CREATE_NEW" bundle="${storeText}"/>
							                                    </a>     
									                         </span>
							                              </span>
							                           </span>
							                        </span>
							                     </span>       	
			                                </c:when>
											<c:when test="${!empty WCParam.orderId}">
											 <span class="primary_button button_fit" id="WC_AjaxRequisitionListDetailDisplay_div_9">
						                        <span class="button_container">
						                           <span class="button_bg">
						                              <span class="button_top">
						                                 <span class="button_bottom">
						                                    <a href="javascript:setCurrentId('WC_AjaxRequisitionListDetailDisplay_CreateNewList'); RequisitionList.createReqListFromOrder('RequisitionListDetailForm','<c:out value="${WCParam.orderId}"/>');"  id="WC_AjaxRequisitionListDetailDisplay_CreateNewList">
						                                       <fmt:message key="REQUISITIONLIST_CREATE_NEW" bundle="${storeText}"/>
						                                    </a>
								                        </span>
						                              </span>
						                           </span>
						                        </span>
						                     </span>
											</c:when>			                                
											<c:otherwise>
												<span class="primary_button button_fit" id="WC_AjaxRequisitionListDetailDisplay_div_9">
							                        <span class="button_container">
							                           <span class="button_bg">
							                              <span class="button_top">
							                                 <span class="button_bottom">
							                                    <a href="javascript:setCurrentId('WC_AjaxRequisitionListDetailDisplay_CreateNewList2'); RequisitionList.createNewReqList('RequisitionListDetailForm');"  id="WC_AjaxRequisitionListDetailDisplay_CreateNewList2">
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
                    </c:if>
                    
               		<c:set var="button2Style" value="secondary"/>
              		<c:if test="${!empty requisitionListId}">
              			<c:set var="button2Style" value="primary"/>
              		</c:if>
                 		
                    <c:choose>
                    	<c:when test="${!empty requisitionListId}">
                    		<span class="<c:out value="${button2Style}"/>_button button_fit" id="WC_AjaxRequisitionListDetailDisplay_div_10">
		                       <span class="button_container">
		                          <span class="button_bg">
		                             <span class="button_top">
		                                <span class="button_bottom">
		                                   <a href="javascript:setCurrentId('WC_RequisitionListDetailDisplay_PlaceOrder');RequisitionList.placeOrder(document.RequisitionListDetailForm);" id="WC_RequisitionListDetailDisplay_PlaceOrder">
		                                      <fmt:message key="REQUISITIONLIST_PLACE_ORDER" bundle="${storeText}"/>
		                                   </a>
		                                </span>
		                             </span>
		                          </span>
		                       </span>
		                    </span>
		                    <span class="sixpixels"></span>
   							<span class="secondary_button button_fit" id="WC_AjaxRequisitionListDetailDisplay_div_9_cancel">
	                        <span class="button_container">
	                           <span class="button_bg">
	                              <span class="button_top">
	                                 <span class="button_bottom">
	                                    <a href="javascript:MyAccountDisplay.loadContentFromURL('showRequisitionLists', '<c:out value="${requisitionListURL}"/>');">
	                                       <fmt:message key="REQUISITIONLIST_CREATE_CANCEL" bundle="${storeText}"/>
	                                    </a>
			                         </span>
	                              </span>
	                           </span>
	                        </span>
	                     </span>
							                     
                    	</c:when>
                    	<c:otherwise>         
                    		<%-- ths is the cancel button on the create page --%>	
		                   	<span class="secondary_button button_fit" id="WC_AjaxRequisitionListDetailDisplay_div_10b">
		                       <span class="button_container">
		                          <span class="button_bg">
		                             <span class="button_top">
		                                <span class="button_bottom">
		                                	<c:set var="cancelRequisitionListLink" value="${WCParam.previousPage}" />
		                                	<c:if test="${WCParam.previousPage == 'savedOrder'}">
												<wcf:url var="cancelRequisitionListLink" value="ListOrdersDisplayView">
													<wcf:param name="storeId"   value="${WCParam.storeId}"/>
													<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
													<wcf:param name="langId" value="${langId}"/>
													<wcf:param name="page" value="savedorder"/>
												</wcf:url>		                                		
		                                	</c:if>
		                                	<c:if test="${WCParam.previousPage == 'currentOrder'}">
												<wcf:url var="cancelRequisitionListLink" value="OrderCalculate" type="Ajax">
												  <wcf:param name="langId" value="${langId}" />
												  <wcf:param name="storeId" value="${WCParam.storeId}" />
												  <wcf:param name="catalogId" value="${WCParam.catalogId}" />
												  <wcf:param name="URL" value="AjaxOrderItemDisplayView" />
												  <wcf:param name="errorViewName" value="AjaxOrderItemDisplayView" />
												  <wcf:param name="updatePrices" value="1" />
												  <wcf:param name="calculationUsageId" value="-1" />
												  <wcf:param name="orderId" value="." />
												</wcf:url>	                                		
		                                	</c:if>	
		                                	<c:if test="${WCParam.previousPage == 'myAccount'}">
		                                		<%-- Since previous page is my account. If user cancels at this point, send them back to the page with a table of requisition lists.  --%>
		                                		<c:set var="cancelRequisitionListLink" value="javascript:MyAccountDisplay.loadContentFromURL('showRequisitionLists', '${requisitionListURL}');"/>                                	
		                                	</c:if>                       	
		                                	<a href="<c:out value="${cancelRequisitionListLink}" />" id="WC_AjaxRequisitionListDetailDisplay_CancelCreate">
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
                 <div class="right_corner" id="WC_AjaxRequisitionListDetailDisplay_div_11"></div>
			</div>
		</div>
<flow:ifDisabled feature="AjaxAddToCart">	
	</form>
</flow:ifDisabled>	





