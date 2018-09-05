<?xml version="1.0" encoding="UTF-8"?>

<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2013 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>
<%@page contentType="text/xml;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf"%>
<%--
	==========================================================================
	Call the get service for online store to retrieve the
	flag used to determine if cms punch-out is enabled or not.
	==========================================================================
--%>
<wcf:getData type="com.ibm.commerce.infrastructure.facade.datatypes.OnlineStoreType"
	var="onlineStore"
	varShowVerb="showVerb"
	expressionBuilder="findByUniqueID">
	<wcf:param name="usage" value="IBM_ManageAttachmentTool"/>
	<wcf:param name="storeId" value="${param.storeId}"/>
	<wcf:param name="accessProfile" value="IBM_Details"/>
</wcf:getData>

<%--
	Determine if the cms punch-out enablement feature has been enabled for this store.
	If it has then set 'cmsPunchOutEnabled' to 'true'.
--%>
<c:set var="cmsPunchOutEnabled" value="false" />
<c:if test="${!(empty onlineStore) && !(empty onlineStore.userData)}">
	<c:forEach var="userDataField" items="${onlineStore.userData.userDataField}">
		<c:if test="${userDataField.typedKey == 'wc.cmsPunchOut.enabled'}">
			<c:set var="cmsPunchOutEnabled" value="${userDataField.typedValue}" />
		</c:if>
	</c:forEach>
</c:if>
<values>
	<cmsPunchOutEnabled>${cmsPunchOutEnabled}</cmsPunchOutEnabled>
</values>
