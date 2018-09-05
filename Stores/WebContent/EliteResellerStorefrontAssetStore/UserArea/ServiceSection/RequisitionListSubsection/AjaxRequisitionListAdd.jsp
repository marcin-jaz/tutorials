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



<c:set var="myAccountPage" value="true" scope="request"/>

<div id="box">
<form name="RequisitionListDetailForm" method="post" action="AjaxRequisitionListCreate" id="RequisitionListDetailForm">
	<div dojoType="wc.widget.RefreshArea" id="RequisitionListAdd_Widget" controllerId="RequisitionListAdd_Controller" role="wairole:region" waistate:live="polite" waistate:atomic="false" waistate:relevant="all">

		<c:import url="${jspStoreDir}UserArea/ServiceSection/RequisitionListSubsection/AjaxRequisitionListDetailDisplay.jsp">
			<c:param name="isAjax" value="true"/>
			<c:param name="editable" value="${WCParam.editable}"/>						
			<c:param name="requisitionListId" value="${WCParam.requisitionListId}"/>
			<c:param name="storeId" value="${WCParam.storeId}"/>
			<c:param name="catalogId" value="${WCParam.catalogId}"/>
			<c:param name="langId" value="${langId}"/>
			<c:param name="numberOfProduct" value="${WCParam.numberOfProduct}"/>						
	        </c:import>
	</div>
</form>
</div>
