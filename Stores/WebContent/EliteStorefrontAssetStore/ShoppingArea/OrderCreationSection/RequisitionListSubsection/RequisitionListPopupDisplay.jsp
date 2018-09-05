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

<!-- BEGIN RequisitioListPopupDisplay.jsp -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../../include/nocache.jspf" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %> 
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf" %>
<%@ include file="../../../include/RequisitionListSetup.jspf" %>

<%-- Check whether or not the flex flow "Ajax Add to Cart" is enabled --%>
<flow:ifEnabled feature="AjaxAddToCart">
	<script type="text/javascript">
		dojo.addOnLoad(function() {
			RequisitionList.setAjaxShopCart(true);
		});
	</script>	
</flow:ifEnabled>	
<flow:ifDisabled feature="AjaxAddToCart">
	<script type="text/javascript">
		dojo.addOnLoad(function() {
			RequisitionList.setAjaxShopCart(false);
		});
	</script>	
</flow:ifDisabled>	

<%-- Check whether or not the flex flow "Ajax My Account" is enabled --%>
<flow:ifEnabled feature="AjaxMyAccountPage">
	<script type="text/javascript">
		dojo.addOnLoad(function() {
			categoryDisplayJS.setAjaxMyAccount(true);
		});
	</script>
</flow:ifEnabled>
<flow:ifDisabled feature="AjaxMyAccountPage">
	<script type="text/javascript">
		dojo.addOnLoad(function() {
			categoryDisplayJS.setAjaxMyAccount(false);
		});
	</script>
</flow:ifDisabled>
 
<div id="requisition_list_popup_main_div">
	<div id="requisition_list_popup" dojoType="dijit.Dialog" >
		<div class="top_left" id="WC_RequisitionListPopupDisplay_div_1"><img alt="" src="<c:out value="${jspStoreImgDir}" />images/trasparent.gif" /></div>
	 	<div class="top_right" id="WC_RequisitionListPopupDisplay_div_2"><img alt="" src="<c:out value="${jspStoreImgDir}" />images/trasparent.gif" /></div>
		<div class="header" id="WC_RequisitionListPopupDisplay_popupHeader"> 
			<div class="close" id="WC_RequisitionListPopupDisplay_div_3">
			    <a id="WC_RequisitionListPopupDisplay_closeLink" href="javascript:hidePopup('requisition_list_popup');" onkeydown="javaScript:RequisitionList.reqSetbackFocus(event);" onmousedown="javaScript:RequisitionList.reqSetbackFocus(event);">
			        <span onclick="javaScript:hidePopup('requisition_list_popup');" class="icon" id="WC_RequisitionListPopupDisplay_div_4">
			            <img alt="<fmt:message key="QuickInfo_Close" bundle="${storeText}"/>" src="<c:out value="${jspStoreImgDir}${vfileColor}" />popup_close.png" />
			        </span>
			        <fmt:message key="QuickInfo_Close" bundle="${storeText}"/>
			    </a>
			</div>
		</div>
		
		<div class="bodyarea" id="WC_RequisitionListPopupDisplay_div_5">
		    <div class="bodycontent" id="WC_RequisitionListPopupDisplay_div_6">
		       <div class="title" id="WC_RequisitionListPopupDisplay_div_7"> 
			       <h2 id="WC_RequisitionListPopupDisplay_heading"><fmt:message key="REQUISITIONLIST_POPUP_ADD" bundle="${storeText}"/></h2>
			       <h1 id="WC_RequisitionListPopupDisplay_select"><fmt:message key="REQUISITIONLIST_POPUP_SELECT" bundle="${storeText}"/></h1>
			   </div>	   
			   
			   <form name="RequisitionListPopupForm" method="post" action="RequisitionListItemUpdate" id="RequisitionListPopupForm">
				   	<input type="hidden" name="storeId" value="<c:out value="${WCParam.storeId}"/>" id="RequisitionListPopupForm_FormInput_1"/>
			        <input type="hidden" name="catalogId" value="<c:out value="${WCParam.catalogId}"/>" id="RequisitionListPopupForm_FormInput_2"/>
			        <input type="hidden" name="langId" value="<c:out value="${langId}"/>" id="RequisitionListPopupForm_FormInput_3"/>
			        <input type="hidden" name="URL" value="RequisitionListDetailView" id="RequisitionListPopupForm_FormInput_4"/>
			        <input type="hidden" name="requisitionListId" value="" id="RequisitionListPopupForm_FormInput_5"/>
			        <input type="hidden" name="catEntryId" value="" id="RequisitionListPopupForm_FormInput_6"/>
			        <input type="hidden" name="quantity" value="" id="RequisitionListPopupForm_FormInput_7"/>
			        <input type="hidden" name="editable" value="true" id="RequisitionListPopupForm_FormInput_8"/>
			        <input type="hidden" name="errorViewName" value="RequisitionListDetailView" id="WC_NonAjaxRequisitionListAdd_FormInput_9"/>         		       
			       		
			       	<div class="body" id="WC_RequisitionListPopupDisplay_div_8">
						<%out.flush();%>
						<c:import url="${jspStoreDir}ShoppingArea/OrderCreationSection/RequisitionListSubsection/RequisitionListPopupTableDisplay.jsp">										
						</c:import>
						<%out.flush();%>
					</div>
				</form>
					       
		       <div class="product_details" id="WC_RequisitionListPopupDisplay_div_12">                
		       		<div class="clear_float" id="WC_RequisitionListPopupDisplay_div_13"></div>
		       		<span tabindex="0" id="reqFocusConveyer" onfocus="javaScript:RequisitionList.reqGobackFocus();"></span>
		       </div>
		       
		    </div>
		</div>
		
		<div class="footer" id="WC_RequisitionListPopupDisplay_div_14">
	    <div class="bot_left" id="WC_RequisitionListPopupDisplay_div_15"></div>
	    <div class="bot_right" id="WC_RequisitionListPopupDisplay_div_16"></div>
	  </div>
	  	<!--[if lte IE 6.5]><iframe id="dropDownIFrame" scrolling="no" frameborder="0" src="<c:out value="${jspStoreImgDir}"/>images/empty.gif"></iframe><![endif]-->
	</div>
</div>
<script type="text/javascript">dojo.addOnLoad(function() { parseWidget("requisition_list_popup"); } );</script>
<!-- END RequisitioListPopupDisplay.jsp -->

