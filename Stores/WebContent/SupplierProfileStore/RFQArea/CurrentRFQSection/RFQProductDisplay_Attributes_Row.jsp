<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2000, 2008 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>
<%--
  *****
  * This JSP page iterates through the attributes of an RFQ product.
  *
  * Required parameters:
  * - plist
  * - index int
  *
  *****
--%>

<%@ page language="java" %>

<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../include/JSTLEnvironmentSetup.jspf" %>


<%--
Parameters:
	index int
--%>
<c:set var="plist" value="${requestScope.plist}" />
<c:set var="pAttribute" value="${plist[param.index]}" />

<c:set var="pattribute_name" value="${pAttribute.name}" />
<c:set var="pattribute_desc" value="${pAttribute.description}" />
<fmt:message key="RFQProductDisplay_Yes" bundle="${storeText}" var="pattribute_userdefine" />

<c:if test="${pAttribute.attribute_id > 0}" >
	<c:set var="pattribute_desc" value="${pattribute_name}" />
	<fmt:message key="RFQProductDisplay_No" bundle="${storeText}" var="pattribute_userdefine" />
</c:if>

<c:if test="${pAttribute.operator_id > 0}" >
	<wcbase:useBean id="opDB"
		classname="com.ibm.commerce.catalog.beans.OperatorDescriptionDataBean">
		<c:set target="${opDB}" property="dataBeanKeyLanguageId" value="${langId}" />
		<c:set target="${opDB}" property="dataBeanKeyOperatorId" value="${pAttribute.operator_id}" />
		
	</wcbase:useBean>
		<c:set var="pattribute_opname" value="${opDB.description}" />	
</c:if>

<c:set var="pattribute_value" value="${pAttribute.value}" />




<c:if test="${pAttribute.attrtype eq 'DATETIME'}" >
	<%--
		format pattribute_value 
	--%>		
		
</c:if>

<c:set var="pattribute_unit" value="${pAttribute.unit}" />
<c:if test="${!empty pattribute_unit}" >
		<wcbase:useBean id="qudb"
			classname="com.ibm.commerce.common.beans.QuantityUnitDescriptionDataBean">
			<c:set target="${qudb}" property="dataBeanKeyLanguage_id" value="${WCParam.langId}" />
			<c:set target="${qudb}" property="dataBeanKeyQuantityUnitId" value="${pattribute_unit}" />
			
			<c:set var="pattribute_unitname" value="${qudb.description}" />
		</wcbase:useBean>
</c:if>

<c:set var="pattribute_mandatory" value="${pAttribute.mandatory}" />
<c:choose>
	<c:when test="${pattribute_mandatory eq 'true'}">
		<fmt:message key="RFQProductDisplay_Yes" bundle="${storeText}" var="mandatory" />
	</c:when>
	<c:when test="${pattribute_mandatory eq 'false'}">
		<fmt:message key="RFQProductDisplay_No" bundle="${storeText}" var="mandatory" />
	</c:when>
</c:choose>

<c:set var="pattribute_changeable" value="${pAttribute.changeable}" />
<c:choose>
	<c:when test="${pattribute_changeable eq 'false'}">
		<fmt:message key="RFQProductDisplay_No" bundle="${storeText}" var="changeable" />
	</c:when>
	<c:when test="${pattribute_changeable eq 'true'}">
		<fmt:message key="RFQProductDisplay_Yes" bundle="${storeText}" var="changeable" />
	</c:when>
</c:choose>
<c:set var="isTypeAttachment" value="${pAttribute.attrtype eq 'ATTACHMENT'}" />
<c:set var="pAttrValueId" value="0" />
<c:set var="attachment_id" />
<c:set var="filename" value="" />



<c:if test="${isTypeAttachment}" >
	<wcbase:useBean id="attachment"
		classname="com.ibm.commerce.contract.beans.AttachmentDataBean">
		<jsp:setProperty property="*" name="attachment"/>
		<c:set target="${attachment}" property="dataBeanKeyAttachmentId" value="${pAttribute.value}" />
	</wcbase:useBean>
	<c:set var="pAttrValueId" value="${pAttribute.PAttrValueId}" />
	<c:set var="attachment_id" value="${pAttribute.value}" />
	<c:set var="filename" value="${attachment.filename}" />
	<c:set var="isTypeAttachment" value="true" />
</c:if>

<td headers="a1" class="t_td" id="WC_RFQproductDisplay_AR_TableCell_1"><c:out value="${pattribute_desc}" /></td>
<td headers="a2" class="t_td" id="WC_RFQproductDisplay_AR_TableCell_2"><c:out value="${pattribute_opname}" /></td>
<c:choose>
	<c:when test="${isTypeAttachment}" >
		<td headers="a3" class="t_td" id="WC_RFQproductDisplay_AR_TableCell_3"><a	href="javascript:view('<c:out value="${attachment_id}', '${pAttrValueId}" />');"><c:out value="${filename}" /></a></td>
	</c:when>
<c:otherwise>
	<td headers="a3" class="t_td" id="WC_RFQproductDisplay_AR_TableCell_4"><c:out value="${pattribute_value}" /></td>
	</c:otherwise>
</c:choose>
<td headers="a4" class="t_td" id="WC_RFQproductDisplay_AR_TableCell_5"><c:out value="${pattribute_unitname}" /></td>
<c:choose>
	<c:when test="${isTypeAttachment}" >
		 <td headers="a5" class="t_td" id="WC_RFQproductDisplay_AR_TableCell_6"><c:out value="${filesize}" /></td>
	</c:when>
<c:otherwise>
		<td headers="a5" class="t_td" id="WC_RFQproductDisplay_AR_TableCell_7"></td>
	</c:otherwise>
</c:choose>

	<td headers="a6" class="t_td" id="WC_RFQproductDisplay_AR_TableCell_8"><c:out value="${mandatory}" /></td>
	<td headers="a7" class="t_td" id="WC_RFQproductDisplay_AR_TableCell_9"><c:out value="${changeable}" /></td>
	<td headers="a8" class="t_td" id="WC_RFQproductDisplay_AR_TableCell_10"><c:out value="${pattribute_userdefine}" /></td>





