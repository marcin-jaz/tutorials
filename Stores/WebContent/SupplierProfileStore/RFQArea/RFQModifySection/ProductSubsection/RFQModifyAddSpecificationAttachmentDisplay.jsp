<%
/*
 *-------------------------------------------------------------------
 * Licensed Materials - Property of IBM
 *
 * WebSphere Commerce
 *
 * (c) Copyright International Business Machines Corporation. 2001, 2004
 *     All rights reserved.
 *
 * US Government Users Restricted Rights - Use, duplication or
 * disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
 *
 *-------------------------------------------------------------------
 */
%>
<%--
  *****
  * This JSP page displays fields for adding attachments to an RFQ product
  * specification.
  *
  * Elements:
  * - Specification selection box
  * - Add button
  * - Cancel button
  *
  * Required parameters:
  * - offering_id
  * - rfqprod_id
  * - catalogId
  * - storeId
  * - langId
  *
  *****
--%>

<%@ page language="java" %>
 
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf" %>


<%@ include file="../RFQModifyConstants.jspf" %>

<c:set var="rfqprodId" value="${WCParam.rfqprod_id}" scope="request" />

<c:set var="WCParamValues" value="" scope="request" />


<script language="javascript"> 
	function submitAdd(form)
	{
		if (form.filename.value=='')
		{
			error("<fmt:message key="RFQAttachmentAddDisplay_Error1" bundle="${storeText}" />");
			return;
		}		
		form.action='RFQPattributeAttachmentAdd';
		form.submit();
	}
	function refreshHTML(form)
	{
		
		if (form.attrType.value == '<c:out value="${EC_ATTRTYPE_ATTACHMENT}" />')
		{
			form.specJSP.value = 'RFQModifyAddSpecificationAttachmentDisplay.jsp';
			return;
		} 
		if (form.attrType.value == '<c:out value="${EC_ATTRTYPE_STRING}" />')
		{
			form.specJSP.value = 'RFQModifyAddSpecificationStringDisplay.jsp';
			
		}
		if (form.attrType.value == '<c:out value="${EC_ATTRTYPE_DATETIME}" />')
		{
			form.specJSP.value = 'RFQModifyAddSpecificationTimestampDisplay.jsp';
		} 
		if (form.attrType.value == '<c:out value="${EC_ATTRTYPE_INTEGER}" />')
		{
			form.specJSP.value = 'RFQModifyAddSpecificationIntegerDisplay.jsp';
		}
	
		var prevName = form.name.value;		
		form.action = 'RFQModifyAddSpecificationDisplay?prevName='+prevName+'&offering_id=<c:out value="${requestScope.rfqId}" />&catentryid=&rfqprod_id=<c:out value="${requestScope.rfqprodId}" />&langId=<c:out value="${langId}" />&storeId=<c:out value="${storeId}" />&catalogId=<c:out value="${catalogId}" />';

		form.submit();
	}

</script>

 
			<input type="hidden" name="attrType" value="<c:out value="${EC_ATTRTYPE_STRING}" />" id="WC_RFQModifyAddSpecificationAttachmentDisplay_FormInput_attrType_1"/>
			<input type="hidden" name="specJSP" value="RFQModifyAddSpecificationAttachmentDisplay.jsp" id="WC_RFQModifyAddSpecificationAttachmentDisplay_FormInput_specJSP_1"/>
			<input type="hidden" name="<c:out value="${EC_ATTR_OPERATOR}" />" value="<c:out value="${EC_OPERATOR_EQUAL}" />" id="WC_RFQModifyAddSpecificationAttachmentDisplay_FormInput_<c:out value="${EC_ATTR_OPERATOR}" />_1"/>
			<input type="hidden" name="refcmd" value="RFQPattributeAttachmentAdd" id="WC_RFQModifyAddSpecificationAttachmentDisplay_FormInput_refcmd_1"/>
			<input type="hidden" name="value" value="" id="WC_RFQModifyAddSpecificationAttachmentDisplay_FormInput_value_1"/>





			<tr><td id="WC_RFQModifyAddSpecificationAttachmentDisplay_TableCell_1">&nbsp;</td></tr>

			<tr> 
				<td height="21" id="WC_RFQModifyAddSpecificationAttachmentDisplay_TableCell_2">
				<span class="reqd">*</span><label for="WC_RFQModifyAddSpecificationAttachmentDisplay_FormInput_filename_1"><fmt:message key="RFQModifyAddSpecificationDisplay_Value" bundle="${storeText}" /></label>
				</td>
				<input type="hidden" name="<c:out value="${EC_ATTR_VALUE}" />" value="" id="WC_RFQModifyAddSpecificationAttachmentDisplay_FormInput_<c:out value="${EC_ATTR_VALUE}" />_1"/>
				<input type="hidden" name="<c:out value="${EC_RFQOFFERING_QTYUNIT}" />" value="" id="WC_RFQModifyAddSpecificationAttachmentDisplay_FormInput_<c:out value="${EC_RFQOFFERING_QTYUNIT}" />_1"/>
				<td id="WC_RFQModifyAddSpecificationAttachmentDisplay_TableCell_3">
                <input type="file" class="input" name="filename" id="WC_RFQModifyAddSpecificationAttachmentDisplay_FormInput_filename_1"/>
				</td>
			
			</tr>

