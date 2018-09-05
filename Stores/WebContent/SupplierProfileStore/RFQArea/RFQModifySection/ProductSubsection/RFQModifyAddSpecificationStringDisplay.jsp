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
  * This JSP page displays fields for adding specifications (string types)
  * to an RFQ product specification.
  *
  * Elements:
  * - Specification selection box
  * - Operator selection box
  * - Units selection box
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
<c:set var="quantByLanguage" value="${requestScope.quantByLanguage}"  />

<c:set var="WCParamValues" value="" scope="request" />

<script language="javascript"> 
	function getFront(mainStr,searchStr) {
		foundOffset = mainStr.indexOf(searchStr);
		if (foundOffset <= 0) {
			return "";
		} else {
			return mainStr.substring(0,foundOffset);
		}
	}
	function getEnd(mainStr,searchStr) {
		foundOffset = mainStr.indexOf(searchStr);
		if (foundOffset <= 0) {
			return "";
		} else {
			return mainStr.substring(foundOffset+searchStr.length,mainStr.length);
	        }
	}
	function isValidString(value)
	{
		if (value == '')
		{
			return false;
		}
		return true;
	}
	function submitAdd(form)
	{
		if (getValueFromSelection(form.<c:out value="${EC_ATTR_OPERATOR}" />) == '<c:out value="${EC_OPERATOR_ENUMERATION}" />') {
			var tmpValue = form.value.value;
			while (true)
			{
				var tmpValue1 = getFront(tmpValue, ';');
				if (getFront(tmpValue, ';') == '')
				{
					tmpValue1 = tmpValue;
				}

				if (isValidString(tmpValue1, ';') == false)
				{
					error("<fmt:message key="RFQModifySpecificationDisplay_Error1" bundle="${storeText}" />");
					return;
				}
				if (tmpValue1.indexOf(';') >= 0)
				{
					error("<fmt:message key="RFQModifySpecificationDisplay_Error1" bundle="${storeText}" />");
					return;
				}
				if (getFront(tmpValue, ';') == '')
				{
					break;
				}
				tmpValue = getEnd(tmpValue, ';');
			}
		} else if (getValueFromSelection(form.<c:out value="${EC_ATTR_OPERATOR}" />) == '<c:out value="${EC_OPERATOR_INCLUSIVE_RANGE}" />') {
			if (isValidString(getFront(form.value.value, ';')) == false)
			{
				error("<fmt:message key="RFQModifyAddSpecificationDisplay_Error1" bundle="${storeText}" />");
				return;
			}
			if (isValidString(getEnd(form.value.value, ';')) == false)
			{
				error("<fmt:message key="RFQModifyAddSpecificationDisplay_Error1" bundle="${storeText}" />");
				return; 
			}			
		} else if (getValueFromSelection(form.<c:out value="${EC_ATTR_OPERATOR}" />) == '<c:out value="${EC_OPERATOR_EXCLUSIVE_RANGE}" />') {
			if (isValidString(getFront(form.value.value, ';')) == false)
			{
				error("<fmt:message key="RFQModifyAddSpecificationDisplay_Error1" bundle="${storeText}" />");
				return;
			}
			if (isValidString(getEnd(form.value.value, ';')) == false)
			{
				error("<fmt:message key="RFQModifyAddSpecificationDisplay_Error1" bundle="${storeText}" />");
				return;
			}			
		} else {
			if (isValidString(form.value.value) == false)
			{
				error("<fmt:message key="RFQModifyAddSpecificationDisplay_Error1" bundle="${storeText}" />");
				return;
			}
		}
		form.submit();
	}
	function refreshHTML(form) 
	{
		if (form.attrType.value == '<c:out value="${EC_ATTRTYPE_ATTACHMENT}" />')
		{
			form.specJSP.value = 'RFQModifyAddSpecificationAttachmentDisplay.jsp';
		}
		if (form.attrType.value == '<c:out value="${EC_ATTRTYPE_STRING}" />')
		{
			form.specJSP.value = 'RFQModifyAddSpecificationStringDisplay.jsp';
			return;
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
 

 
<c:set var="value" value="${WCParam.value}" scope="request" />
			<input type="hidden" name="attrType" value="<c:out value="${EC_ATTRTYPE_STRING}" />" id="WC_RFQModifyAddSpecificationStringDisplay_FormInput_attrType_1"/>
			<input type="hidden" name="specJSP" value="RFQModifyAddSpecificationStringDisplay.jsp" id="WC_RFQModifyAddSpecificationStringDisplay_FormInput_specJSP_1"/>
			 
			 <wcbase:useBean id="rfqProduct" classname="com.ibm.commerce.utf.beans.RFQProdDataBean">
                     <jsp:setProperty property="*" name="rfqProduct"/>                     
              </wcbase:useBean>
              <c:set var="operatorsList" value="${rfqProduct.operators}"  scope="request" />
		
			
			<tr>
				<td height="21" id="WC_RFQModifyAddSpecificationStringDisplay_TableCell_1">
					<label for="WC_RFQModifyAddSpecificationStringDisplay_Select_1"><fmt:message key="RFQModifyAddSpecificationDisplay_Op" bundle="${storeText}" />
				</label></td>
				<td id="WC_RFQModifyAddSpecificationStringDisplay_TableCell_2">
 					<select id="WC_RFQModifyAddSpecificationStringDisplay_Select_1" class="select" name="<c:out value="${EC_ATTR_OPERATOR}" />">
 						<c:catch var="e">
 						<c:forEach var="units" items="${requestScope.operatorsList}" varStatus="iter">
							<option value="<c:out value='${units.key}'/>" >		
							<c:out value='${units.value}'/>
							</option>				
						</c:forEach> 
						</c:catch>
						<c:if test="${e!=null}">
							<option value="" ></option>
						</c:if>						
 	 		
					</select></td>
			</tr>

			<tr><td id="WC_RFQModifyAddSpecificationStringDisplay_TableCell_3">&nbsp;</td></tr>

			<tr>
				<td height="21" id="WC_RFQModifyAddSpecificationStringDisplay_TableCell_4">
					<span class="reqd">*</span><label for="WC_RFQModifyAddSpecificationStringDisplay_FormInput_<c:out value="${EC_ATTR_VALUE}" />_1"><fmt:message key="RFQModifyAddSpecificationDisplay_Value" bundle="${storeText}" />
				</label></td>
				<td id="WC_RFQModifyAddSpecificationStringDisplay_TableCell_5">
					<input size="53" class="input" type="text" maxlength="128" name="<c:out value="${EC_ATTR_VALUE}" />" value="<c:out value="${value}" />" id="WC_RFQModifyAddSpecificationStringDisplay_FormInput_<c:out value="${EC_ATTR_VALUE}" />_1"/>
				
				</td>
			</tr>
 
			<tr>
				<td height="21" colspan="2" id="WC_RFQModifyAddSpecificationStringDisplay_TableCell_6">
					<fmt:message key="RFQModifyAddSpecificationDisplay_MultiValue" bundle="${storeText}" />
				</td>
			</tr> 

			<tr><td id="WC_RFQModifyAddSpecificationStringDisplay_TableCell_7">&nbsp;</td></tr>
 
			<tr>
				<td height="21" id="WC_RFQModifyAddSpecificationStringDisplay_TableCell_8">
					<label for="WC_RFQModifyAddSpecificationStringDisplay_Select_2"><fmt:message key="RFQModifyAddSpecificationDisplay_Unit" bundle="${storeText}" />
				</label></td>
				<td id="WC_RFQModifyAddSpecificationStringDisplay_TableCell_9">
					<select id="WC_RFQModifyAddSpecificationStringDisplay_Select_2" class="select" name="<c:out value="${EC_OFFERING_QTYUNIT}" />">
					<option value=""></option>
					
							<c:forEach items="${quantByLanguage}" var="quantity">
             					<option value="<c:out value="${quantity.quantityUnitId}" />"><c:out value="${quantity.description}" /></option>
       						 </c:forEach>	
							<c:remove var="quantity" />
						
					</select></td>
			</tr>


		
