<%
/*
 *-------------------------------------------------------------------
 * Licensed Materials - Property of IBM
 *
 * WebSphere Commerce
 *
 * (c) Copyright International Business Machines Corporation. 2000, 2004
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
  * This JSP page displays javascript used by the RFQModifySpecificationDisplay
  * JSP page.
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
	function isValidInteger(value)
	{
		if (value == '')
		{
			return false;
		}
		if (isNaN(parseInt(value)) || value != parseInt(value))
		{
			return false;
		}
		return true;
	}
	function isValidString(value)
	{
		if (value == '')
		{
			return false;
		}
		return true;
	}
	//this function only accepts Selections and Text, TextArea, Hidden
	function getValueFromHTMLElement(formObject) {
		if (formObject.type == "select-one") {
			var selectedIndex = formObject.selectedIndex;
			return formObject.options[selectedIndex].value;
		} else {
			formObject.value;
		}
	}
	function submitUpdate(form)
	{
		for (var i = 0; i < form.numSpec.value; i++) {			
			var type = 'pAttrType_' + (i + 1);
			var value = 'value_' + (i + 1);
			var operator = 'operator_' + (i + 1);				
			
			if (getValueFromHTMLElement(form[type])=='<c:out value="${EC_ATTRTYPE_STRING}"/>')
			{
				if (getValueFromHTMLElement(form[operator]) == '<c:out value="${EC_OPERATOR_ENUMERATION}"/>') {
					var tmpValue = getValueFromHTMLElement(form[value]);
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
				} else if (getValueFromHTMLElement(form[operator]) == '<c:out value="${EC_OPERATOR_INCLUSIVE_RANGE}"/>') {
					if (isValidString(getFront(getValueFromHTMLElement(form[value]), ';')) == false)
					{
						error("<fmt:message key="RFQModifySpecificationDisplay_Error1" bundle="${storeText}" />");
						return;
					}
					if (isValidString(getEnd(getValueFromHTMLElement(form[value]), ';')) == false)
					{
						error("<fmt:message key="RFQModifySpecificationDisplay_Error1" bundle="${storeText}" />");
						return;
					}			
				} else if (getValueFromHTMLElement(form[operator]) == '<c:out value="${EC_OPERATOR_EXCLUSIVE_RANGE}"/>') {
					if (isValidString(getFront(getValueFromHTMLElement(form[value]), ';')) == false)
					{
						error("<fmt:message key="RFQModifySpecificationDisplay_Error1" bundle="${storeText}" />");
						return;
					}
					if (isValidString(getEnd(getValueFromHTMLElement(form[value]), ';')) == false)
					{
						error("<fmt:message key="RFQModifySpecificationDisplay_Error1" bundle="${storeText}" />");
						return;
					}			
				} else {
					if (isValidString(getValueFromHTMLElement(form[value])) == false) {
						error("<fmt:message key="RFQModifySpecificationDisplay_Error1" bundle="${storeText}" />");
						return;
					}
				}
			}
			if (getValueFromHTMLElement(form[type])=='<c:out value="${EC_ATTRTYPE_INTEGER}"/>')
			{
				if (getValueFromHTMLElement(form[operator]) == '<c:out value="${EC_OPERATOR_ENUMERATION}"/>') {
					var tmpValue = getValueFromHTMLElement(form[value]);
					while (true)
					{
						var tmpValue1 = getFront(tmpValue, ';');
						if (getFront(tmpValue, ';') == '')
						{
							tmpValue1 = tmpValue;
						}

						if (isValidInteger(tmpValue1, ';') == false)
						{
							error("<fmt:message key="RFQExtra_Error5" bundle="${storeText}" />");
							return;
						}

						if (getFront(tmpValue, ';') == '')
						{
							break;
						}
						tmpValue = getEnd(tmpValue, ';');
					}
				} else if (getValueFromHTMLElement(form[operator]) == '<c:out value="${EC_OPERATOR_ENUMERATION}"/>') {
					if (isValidInteger(getFront(getValueFromHTMLElement(form[value]), ';')) == false)
					{
						error("<fmt:message key="RFQExtra_Error5" bundle="${storeText}" />");
						return;
					}
					if (isValidInteger(getEnd(getValueFromHTMLElement(form[value]), ';')) == false)
					{
						error("<fmt:message key="RFQExtra_Error5" bundle="${storeText}" />");
						return;
					}			
				} else if (getValueFromHTMLElement(form[operator]) == '<c:out value="${EC_OPERATOR_INCLUSIVE_RANGE}"/>') {
					if (isValidInteger(getFront(getValueFromHTMLElement(form[value]), ';')) == false)
					{
						error("<fmt:message key="RFQExtra_Error5" bundle="${storeText}" />");
						return;
					}
					if (isValidInteger(getEnd(getValueFromHTMLElement(form[value]), ';')) == false)
					{
						error("<fmt:message key="RFQExtra_Error5" bundle="${storeText}" />");
						return;
					}			 
				} else if (getValueFromHTMLElement(form[operator]) == '<c:out value="${EC_OPERATOR_EXCLUSIVE_RANGE}"/>') {
					if (isValidInteger(getFront(getValueFromHTMLElement(form[value]), ';')) == false)
					{
						error("<fmt:message key="RFQExtra_Error5" bundle="${storeText}" />");
						return;
					}
					if (isValidInteger(getEnd(getValueFromHTMLElement(form[value]), ';')) == false)
					{
						error("<fmt:message key="RFQExtra_Error5" bundle="${storeText}" />");
						return;
					}			
				} else {
					if (isValidInteger(getValueFromHTMLElement(form[value])) == false) {
						error("<fmt:message key="RFQExtra_Error5" bundle="${storeText}" />");
						return;
					}
				}
			}
		} 
		form.submit();
	}
	function error(errMsg)
	{
		alert(errMsg);
	}

</script>

