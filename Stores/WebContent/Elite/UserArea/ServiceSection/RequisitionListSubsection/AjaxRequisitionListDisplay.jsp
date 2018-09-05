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

<c:set var="myAccountPage" value="true" scope="request"/>

<wcf:url var="AjaxMyAccountCenterLinkDisplayURL" value="AjaxLogonFormCenterLinksDisplayView" type="Ajax">    
	<wcf:param name="storeId"   value="${WCParam.storeId}"  />
	<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
	<wcf:param name="langId" value="${langId}" />
</wcf:url>

<wcf:url var="requisitionListURL" value="AjaxRequisitionListDisplayView" type="Ajax">
	<wcf:param name="storeId"   value="${WCParam.storeId}"  />
	<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
	<wcf:param name="langId" value="${langId}" />
</wcf:url>

<wcf:url var="requisitionListTableView" value="RequisitionListTableView" type="Ajax">
	<wcf:param name="storeId"   value="${WCParam.storeId}"  />
	<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
	<wcf:param name="langId" value="${langId}" />
</wcf:url>

<wcf:url var="requisitionListCreateView" value="AjaxRequisitionListCreateView" type="Ajax">
	<wcf:param name="storeId"   value="${WCParam.storeId}"  />
	<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
	<wcf:param name="langId" value="${langId}" />
	<wcf:param name="newList" value="true"/>
	<wcf:param name="editable" value="true"/>
	<wcf:param name="previousPage" value="myAccount"/>
</wcf:url>

<div id="box">
	<div class="my_account" id="WC_AjaxRequisitionListDisplay_div_1">			
	
		<div class="main_header" id="WC_AjaxRequisitionListDisplay_div_2">
			<div class="left_corner" id="WC_AjaxRequisitionListDisplay_div_3"></div>
			<div class="left" id="WC_AjaxRequisitionListDisplay_div_4">
				<span class="main_header_text">
					<fmt:message key="MYACCOUNT_REQUISITION_LISTS" bundle="${storeText}"/>
				</span>
			</div>
			<div class="right_corner" id="WC_AjaxRequisitionListDisplay_div_5"></div>
		</div>


		<div class="content_header" id="WC_AjaxRequisitionListDisplay_div_6">
			<div class="left_corner" id="WC_AjaxRequisitionListDisplay_div_7"></div>
			<div class="addrbook_header" id="WC_AjaxRequisitionListDisplay_div_8">
				<label for="filterOption"><fmt:message key="REQUISITIONLIST_VIEW" bundle="${storeText}"/></label>
				<select width="10" name="filterOption" id="filterOption" class="drop_down"
				onchange="javascript:setCurrentId('filterOption');RequisitionList.filterRequisitionList(this);">
					<option value="All"><fmt:message key="REQUISITIONLIST_VIEW_ALL" bundle="${storeText}"/></option>
					<option value="Mylists"><fmt:message key="REQUISITIONLIST_VIEW_MYLISTS" bundle="${storeText}"/></option>
				</select>
			</div>
			<div class="sixpixels"></div>
			<div id="WC_AjaxRequisitionListDisplay_div_9" class="addrbook_header">		
				<span class="primary_button button_fit" id="WC_AjaxRequisitionListDisplay_div_10">
				   <span class="button_container">
				      <span class="button_bg">
				         <span class="button_top">
				            <span class="button_bottom">
				            	<a href="javaScript:setCurrentId('createNewRequisitionList'); MyAccountDisplay.loadContentFromURL('createNewRequisitionList', '<c:out value='${requisitionListCreateView}' />');" id="createNewRequisitionList">				               
				                  <fmt:message key="REQUISITIONLIST_ADD_NEW" bundle="${storeText}"/>
				               	</a>
				            </span>
				         </span>
				      </span>
				   </span>
				</span>
			</div>
			<div id="WC_AjaxRequisitionListDisplay_div_11" class="right_corner"></div>
		</div>		
		
		<div class="body">
			<div dojoType="wc.widget.RefreshArea" id="RequisitionListDisplay_Widget" controllerId="RequisitionListDisplay_Controller" role="wairole:region" waistate:live="polite" waistate:atomic="false" waistate:relevant="all">					
				<%out.flush();%>
				<c:import url="${jspStoreDir}UserArea/ServiceSection/RequisitionListSubsection/RequisitionListTableDisplay.jsp">
				</c:import>
				<%out.flush();%>
			</div>
		</div>
		
		<div class="footer" id="WC_AjaxRequisitionListDisplay_div_12">
		  <div class="left_corner" id="WC_AjaxRequisitionListDisplay_div_13"></div>
		  <div class="tile" id="WC_AjaxRequisitionListDisplay_div_14"></div>
		  <div class="right_corner" id="WC_AjaxRequisitionListDisplay_div_15"></div>
		</div>		
	</div>
</div>