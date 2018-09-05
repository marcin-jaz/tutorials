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
<%@ include file="../../../include/nocache.jspf" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %> 
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf" %>

<%-- Indicates whether there are requisition lists or not --%>
<c:set var="hideTable" value="false"/>

<%-- Retrieve the current user information if this cannot be retrieved --%>
<c:if test="${empty person}">
	<wcf:getData type="com.ibm.commerce.member.facade.datatypes.PersonType" var="person" expressionBuilder="findCurrentPerson" scope="request">
		<wcf:param name="accessProfile" value="IBM_All" />
	</wcf:getData>
</c:if>
<c:set var="userId" value="${person.personIdentifier.uniqueID}"/>

<%-- Retrieve all the private requisition lists --%>
<wcbase:useBean id="pReqListDB" classname="com.ibm.commerce.order.beans.PRequisitionByMemberIdAndStoreIdListDataBean" scope="page">
	<c:set target="${pReqListDB}" property="dataBeanKeyMemberId" value="${userId}"/>
	<c:set target="${pReqListDB}" property="dataBeanKeyStoreId" value="${WCParam.storeId}"/>
</wcbase:useBean>
<c:set var="privateRequisitionLists" value="${pReqListDB.PRequisitionByMemberIdAndStoreIdList}" />

<%-- Retrieve only the shared requisition lists created by me --%>
<wcbase:useBean id="sOwnedReqListDB" classname="com.ibm.commerce.order.beans.SRequisitionOwnedByMemberIdAndStoreIdListDataBean" scope="page">
	<c:set target="${sOwnedReqListDB}" property="dataBeanKeyMemberId" value="${userId}"/>
	<c:set target="${sOwnedReqListDB}" property="dataBeanKeyStoreId" value="${WCParam.storeId}"/>
</wcbase:useBean>
<c:set var="sharedRequisitionLists" value="${sOwnedReqListDB.SRequisitionOwnedByMemberIdAndStoreIdList}" />

<%-- Check whether there are requisition lists to be displayed or not --%>
<c:if test="${(fn:length(privateRequisitionLists) <= 0) && (fn:length(sharedRequisitionLists) <= 0)}">
	<c:set var="hideTable" value="true"/>
</c:if>	

<%-- Only show a message indicating the table is empty if there are no requisition lists for the selected filter --%>
<c:if test="${hideTable == 'true'}">
	<div class="requisition_list_message">
		<fmt:message key="REQUISITIONLIST_TABLE_EMPTY" bundle="${storeText}"/>
	</div>
	
	<div class="requisition_list_popup_button">
		<span class="primary_button button_fit" id="WC_RequisitionListPopupDisplay_div_11">
		   <span class="button_container">
		      <span class="button_bg">
		         <span class="button_top">
		            <span class="button_bottom">
		            	<a href="" id="addToNewReqList_popup"> 		            
		                  <fmt:message key="MYACCOUNT_REQUISITION_LISTS_CREATE" bundle="${storeText}"/>
		               	</a>
		            </span>
		         </span>
		      </span>
		   </span>
		</span>		
	</div>		
</c:if>	

<%-- Only show the requisition list table if there are existing requisition lists --%>
<c:if test="${hideTable == 'false'}">
	<div class="requisition_list_popup_table" id="WC_RequisitionListPopupDisplay_div_9">
	
		<%-- Display the requisition lists according to the selected filter option --%>
		<div role="grid" id="requisition_list_popup_table" class="requisition_list_table" aria-describedby="requisition_list_table_popup_summary">
			<%-- This is the hidden table summary used for Accessibility --%>
			<div id="requisition_list_table_popup_summary" class="hidden_summary">
				<fmt:message key="REQUISITION_LIST_TABLE_POPUP_SUMMARY" bundle="${storeText}"/>
			</div>
			<div role="row" class="ul column_heading">
				 <div role="columnheader" class="li name_column_popup" id="RequisitionList_Name"><fmt:message key="REQUISITIONLIST_TABLE_NAME" bundle="${storeText}"/></div>
			     <div role="columnheader" class="li last_updated_column" id="RequisitionList_Date"><fmt:message key="REQUISITIONLIST_TABLE_LASTUPDATED" bundle="${storeText}"/></div>
			     <div role="columnheader" class="li type_column" id="RequisitionList_Type"><fmt:message key="REQUISITIONLIST_TABLE_TYPE" bundle="${storeText}"/></div>
			     <div class="li clear_float"></div>
			</div>
			
			<%-- Loop through all the private requisition lists and display them in the table --%>	
			<c:forEach var="requisitionListP" items="${privateRequisitionLists}" varStatus="istat">	
				<div role="row" class="ul row">
					<div role="gridcell" class="li name_column_popup" id="WC_RequisitionListTableDisplay_TableCell_1_1_<c:out value="${istat.count}"/>">
						<input type="radio" name="RequisitionListTableDisplay_RequisitionListSelection" value="<c:out value="${requisitionListP.orderId}"/>" id="WC_RequisitionListTableDisplay_Selection_1_<c:out value="${istat.count}"/>" />
						<label for="WC_RequisitionListTableDisplay_Selection_1_<c:out value="${istat.count}"/>"><c:out value="${requisitionListP.description}"/></label>
					</div>

					<div role="gridcell" class="li last_updated_column" id="WC_RequisitionListTableDisplay_TableCell_1_3_<c:out value="${istat.count}"/>"><c:out value="${requisitionListP.formattedLastUpdate}"/></div>
					<div role="gridcell" class="li type_column" id="WC_RequisitionListTableDisplay_TableCell_1_4_<c:out value="${istat.count}"/>">
						<img src="<c:out value="${jspStoreImgDir}${vfileColor}"/>private.gif" alt="<fmt:message key="REQUISITIONLIST_TYPE_PRIVATE" bundle="${storeText}"/>"/>
					</div>
					<div class="li clear_float"></div>
				</div>		
			</c:forEach>
			
			<%-- Loop through all the shared requisition lists and display them in the table --%>
			<c:forEach var="requisitionListSAll" items="${sharedRequisitionLists}" varStatus="istat">
				<div role="row" class="ul row">
					<div role="gridcell" class="li name_column_popup" id="WC_RequisitionListTableDisplay_TableCell_2_1_<c:out value="${istat.count}"/>">
						<input type="radio" name="RequisitionListTableDisplay_RequisitionListSelection" value="<c:out value="${requisitionListSAll.orderId}"/>" id="WC_RequisitionListTableDisplay_Selection_2_<c:out value="${istat.count}"/>" />
						<label for="WC_RequisitionListTableDisplay_Selection_2_<c:out value="${istat.count}"/>"><c:out value="${requisitionListSAll.description}"/></label>
					</div>

					<div role="gridcell" class="li last_updated_column" id="WC_RequisitionListTableDisplay_TableCell_2_3_<c:out value="${istat.count}"/>"><c:out value="${requisitionListSAll.formattedLastUpdate}"/></div>
					<div role="gridcell" class="li type_column" id="WC_RequisitionListTableDisplay_TableCell_2_4_<c:out value="${istat.count}"/>">
						<img src="<c:out value="${jspStoreImgDir}${vfileColor}"/>shared.gif" alt="<fmt:message key="REQUISITIONLIST_TYPE_SHARED" bundle="${storeText}"/>"/>
					</div>					
					<div class="li clear_float"></div>
				</div>	
			</c:forEach>
		</div>
	</div>
	
	<div class="requisition_list_popup_button">
		<span class="primary_button button_fit" id="WC_RequisitionListPopupDisplay_div_10">
		   <span class="button_container">
		      <span class="button_bg">
		         <span class="button_top">
		            <span class="button_bottom">
		            	<a href="" id="addToExistingReqList_popup">		            	
		            		<fmt:message key="REQUISITIONLIST_POPUP_ADD" bundle="${storeText}"/>
		               	</a>
		            </span>
		         </span>
		      </span>
		   </span>
		</span>
		
		<span class="primary_button button_fit" id="WC_RequisitionListPopupDisplay_div_11">
		   <span class="button_container">
		      <span class="button_bg">
		         <span class="button_top">
		            <span class="button_bottom">
		            	<a href="" id="addToNewReqList_popup"> 		            
		                  <fmt:message key="MYACCOUNT_REQUISITION_LISTS_CREATE" bundle="${storeText}"/>
		               	</a>
		            </span>
		         </span>
		      </span>
		   </span>
		</span>		
	</div>	
</c:if>