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
  * This JSP page displays javascript used on the RFQModifyDisplay 
  * JSP page.
  *
  *****
--%>
<%@ page language="java" %>

<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="flow.tld" prefix="flow" %>

<%@ include file="../../include/JSTLEnvironmentSetup.jspf" %>


<%@ include file="RFQModifyConstants.jspf" %>
 

<script language="javascript">                                        
	function getValueFromSelection(formObject) {
		var selectedIndex = formObject.selectedIndex;
		return formObject.options[selectedIndex].value;
	}

	function view() {
		window.open("RFQAttachmentView?<c:out value="${EC_ATTACH_ID}" />=" + document.attachmentSelectForm.attachment_id.value + "&<c:out value="${EC_RFQ_REQUEST_ID}" />=<c:out value="${rfqId}" />");
	}

	function getFront(mainStr,searchStr) {
		foundOffset = mainStr.indexOf(searchStr);
		if (foundOffset <= 0) {
			return null;
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

	function submitUpdateBasic(form)
	{
		if (form.productName.value=='') {
			error("<fmt:message key="RFQModifyDisplay_Error1" bundle="${storeText}" />");
			return;
		}

		if (document.RFQModifyPercentagePricingForm != undefined)
		{
   			var numCat = document.RFQModifyPercentagePricingForm.numPPTC.value;
			if (document.RFQModifyPercentagePricingForm[numCat]) {
				for (var i = 0; i < numCat; i++) {
					var name = 'categoryPercentagePrice_' + (i + 1);				
					if (form.endresult[0].checked) {			
						error("<fmt:message key="RFQModifyDisplay_Error25" bundle="${storeText}" />");
						return;
					}
				}	
			}
		}
			
		var numProd = document.RFQModifyProductForm.numProd.value;
						
		if (document.RFQModifyProductForm[numProd]) {
			for (var i = 0; i < numProd; i++) {
				var percentagePrice = 'percentagePrice_' + (i + 1);
				var prodType = 'prodType_' + (i + 1); 
				
   				if (document.RFQModifyProductForm[prodType].value=='<fmt:message key="RFQModifyDisplay_Product" bundle="${storeText}" />') {		
					if (form.endresult[0].checked) {			
						error("<fmt:message key="RFQModifyDisplay_Error25" bundle="${storeText}" />");
						return;
					}
				}
				if (document.RFQModifyProductForm[percentagePrice]) {
					if (Trim(document.RFQModifyProductForm[percentagePrice].value)!='') {
						if (document.RFQModifyProductForm[percentagePrice].value!='0.0') {
							if (document.RFQModifyProductForm[prodType].value=='<fmt:message key="RFQModifyDisplay_Product" bundle="${storeText}" />') {		
								if (form.endresult[0].checked) {			
									error("<fmt:message key="RFQModifyDisplay_Error25" bundle="${storeText}" />");
									return;
								}
							}	
						} 
					}
				}	
							
			}
		}
				

		var temp;
		if ( (form.starttime.value != '') || (getValueFromSelection(form.beginYr) != '') || (getValueFromSelection(form.beginMon) !='') || (getValueFromSelection(form.beginDay) != ''))
		{
			temp = getFront(form.starttime.value, ':');
			temp = parseInt(temp);
			if (isNaN(temp))
			{
				error("<fmt:message key="RFQExtra_Error1" bundle="${storeText}" />");
				return;
			}
			if ((temp<0) || (temp>23))
			{
				error("<fmt:message key="RFQExtra_Error1" bundle="${storeText}" />");
				return;
			}

			temp = getEnd(form.starttime.value, ':');
			temp = parseInt(temp);
			if (isNaN(temp))
			{
				error("<fmt:message key="RFQExtra_Error1" bundle="${storeText}" />");
				return;
			}
			if ((temp<0) || (temp>59))
			{
				error("<fmt:message key="RFQExtra_Error1" bundle="${storeText}" />");
				return;
			}
			if (getValueFromSelection(form.beginYr)=='') {
				error("<fmt:message key="RFQCreateDisplay_Error7" bundle="${storeText}" />");
				return;
			}
			if (getValueFromSelection(form.beginMon)=='') {
				error("<fmt:message key="RFQCreateDisplay_Error7" bundle="${storeText}" />");
				return;
			}
			if (getValueFromSelection(form.beginDay)=='') {
				error("<fmt:message key="RFQCreateDisplay_Error7" bundle="${storeText}" />");
				return;
			}
		}

<c:choose>
	<c:when test="${multiSeller}">
	
		if (form.ruletype.value=='') {
			error("<fmt:message key="RFQCreateDisplay_Error3" bundle="${storeText}" />");
			return;
		}

		if ((form.ruletype.value=='<c:out value="${EC_CLOSE_RULE2}" />') || (form.ruletype.value=='<c:out value="${EC_CLOSE_RULE3}" />') || (form.ruletype.value=='<c:out value="${EC_CLOSE_RULE4}" />')) {
			var temp = parseInt(form.numResponses.value);
			if (isNaN(temp))
			{
				error("<fmt:message key="RFQCreateDisplay_Error5" bundle="${storeText}" />");
				return;
			}
			if (temp < 1)
			{
				error("<fmt:message key="RFQCreateDisplay_Error5" bundle="${storeText}" />");
				return;
			}
		}

		if ((form.ruletype.value=='<c:out value="${EC_CLOSE_RULE1}" />') || (form.ruletype.value=='<c:out value="${EC_CLOSE_RULE3}" />') || (form.ruletype.value=='<c:out value="${EC_CLOSE_RULE4}" />')) {
			if (getValueFromSelection(form.endYr)=='') {
				error("<fmt:message key="RFQCreateDisplay_Error4" bundle="${storeText}" />"); 
				return;
			}
			if (getValueFromSelection(form.endMon)=='') {
				error("<fmt:message key="RFQCreateDisplay_Error4" bundle="${storeText}" />");
				return;
			}
			if (getValueFromSelection(form.endDay)=='') {
				error("<fmt:message key="RFQCreateDisplay_Error4" bundle="${storeText}" />");
				return;
			}

			var temp;

			temp = getFront(form.endtime.value, ':');
			temp = parseInt(temp);
			if (isNaN(temp))
			{
				error("<fmt:message key="RFQExtra_Error1" bundle="${storeText}" />");
				return;
			}
			if ((temp<0) || (temp>23))
			{
				error("<fmt:message key="RFQExtra_Error1" bundle="${storeText}" />");
				return;
			}

			temp = getEnd(form.endtime.value, ':');
			temp = parseInt(temp);
			if (isNaN(temp))
			{
				error("<fmt:message key="RFQExtra_Error1" bundle="${storeText}" />");
				return;
			}
			if ((temp<0) || (temp>59))
			{
				error("<fmt:message key="RFQExtra_Error1" bundle="${storeText}" />");
				return;
			}
		}

	</c:when>	
	<c:otherwise>
	
		if (getValueFromSelection(form.endYr)=='') {
			error("<fmt:message key="RFQCreateDisplay_Error4" bundle="${storeText}" />");
			return;
		}
		if (getValueFromSelection(form.endMon)=='') {
			error("<fmt:message key="RFQCreateDisplay_Error4" bundle="${storeText}" />");
			return;
		}
		if (getValueFromSelection(form.endDay)=='') {
			error("<fmt:message key="RFQCreateDisplay_Error4" bundle="${storeText}" />");
			return;
		}

		var temp;
		temp = getFront(form.endtime.value, ':');
		temp = parseInt(temp);
		if (isNaN(temp))
		{
			error("<fmt:message key="RFQExtra_Error1" bundle="${storeText}" />");
			return;
		}
		if ((temp<0) || (temp>23))
		{
			error("<fmt:message key="RFQExtra_Error1" bundle="${storeText}" />");
			return;
		}

		temp = getEnd(form.endtime.value, ':');
		temp = parseInt(temp);
		if (isNaN(temp))
		{
			error("<fmt:message key="RFQExtra_Error1" bundle="${storeText}" />");
			return; 
		}
		if ((temp<0) || (temp>59))
		{
			error("<fmt:message key="RFQExtra_Error1" bundle="${storeText}" />");
			return;
		}
	</c:otherwise>
</c:choose>
				
		 
		form.submit()
	} 

	function submitUpdateAttachment(form)
	{
		for (var i = 0; i < form.numAttachment.value; i++) {
			var name = 'attachDesc_' + (i + 1);
			if (form[name].value=='') {
				error("<fmt:message key="RFQModifyDisplay_Error6" bundle="${storeText}" />");
				return;
			}
		}
		form.submit()
	}

	function submitUpdateTC(form)
	{
		for (var i = 0; i < form.numTC.value; i++) {
			var name = 'value_' + (i + 1);
			if (form[name].value=='') {
				error("<fmt:message key="RFQModifyDisplay_Error7" bundle="${storeText}" />");
				return;
			}
		}
		form.submit()
	}


	




</script>
