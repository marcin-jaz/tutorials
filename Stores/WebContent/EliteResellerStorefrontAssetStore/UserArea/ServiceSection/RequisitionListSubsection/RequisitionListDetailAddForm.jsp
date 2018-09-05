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

<!-- add item to requisition list form -->
<h3><fmt:message key='REQUISITIONLIST_ADD_ITEM_DESC' bundle='${storeText}'/></h3>


	<div class="new_requisition_list_details" id="WC_RequisitionListDetailsAddForm_div_1">
		<div class="left" id="WC_RequisitionListDetailsAddForm_div_2">
			<div id="WC_RequisitionListDetailsAddForm_div_2a">
				<label for="newSku" class="nodisplay">					
					<fmt:message key="AB_ADDRESS_LABEL_TEXT" bundle="${storeText}">
						<fmt:param><fmt:message key='SKU' bundle='${storeText}'/></fmt:param>
						<fmt:param><fmt:message key="Checkout_ACCE_required" bundle="${storeText}"/></fmt:param>
					</fmt:message>
				</label>
				<div class="requisition_list_required_field" id="WC_RequisitionListDetailsAddForm_div_2b"> *</div>
				<fmt:message key='SKU' bundle='${storeText}'/>
			</div>
			<div id="WC_RequisitionListDetailsAddForm_div_2c">
				<input type="text" name="newSku" id="newSku"/>
			</div>
		</div>
								
		<div class="left" id="WC_RequisitionListDetailsAddForm_div_3">
			<div id="WC_RequisitionListDetailsAddForm_div_3a"><label for="newQuantity"><fmt:message key='REQUISITIONLIST_ITEM_QUANTITY' bundle='${storeText}'/></label></div>
			<div id="WC_RequisitionListDetailsAddForm_div_3b"><input type="text" name="newQuantity" id="newQuantity"/></div>
		</div>
		
	    <span class="secondary_button button_fit myAccountRequisitionListAddItem" id="WC_RequisitionListDetailsAddForm_div_4">
	       <span class="button_container">
	          <span class="button_bg">
	             <span class="button_top">
	                <span class="button_bottom">
	                   <a href="javascript:setCurrentId('WC_RequisitionListDetailsAddForm_AddItemToList');RequisitionList.AddToReqList('RequisitionListDetailForm','<c:out value="${WCParam.requisitionListId}"/>','<c:out value="${WCParam.editable}"/>')" id="WC_RequisitionListDetailsAddForm_AddItemToList">
	                      <fmt:message key="REQUISITIONLIST_ADD_ITEM" bundle="${storeText}"/>
	                   </a>
	                </span>
	             </span>
	          </span>
	       </span>
	    </span>
	</div>		
			