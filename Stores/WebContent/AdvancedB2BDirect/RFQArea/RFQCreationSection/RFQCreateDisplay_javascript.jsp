<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2001, 2009 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>
<%--
  *****
  * This JSP page displays holds javascript code used by the Create RFQ page.
  *
  * Required parameters:
  * - orderId
  * - productId
  * - catentry_id
  * - categoryId
  * - accountid
  * - multiSeller
  *
  *****
--%>

<%@ page language="java" %>

<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../include/JSTLEnvironmentSetup.jspf" %>


<%@ include file="RFQCreateConstants.jspf" %>

<c:set var="orderId" value="${param.orderId}" />
<c:set var="productId" value="${param.productId }" />
<c:set var="catentry_id" value="${param.catentry_id }" />
<c:set var="categoryId" value="${param.categoryId }" />
<c:set var="accountid" value="${param.accountid }" />


				
<script language="javascript">
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
 
	function getValueFromSelection(formObject) {
		var selectedIndex = formObject.selectedIndex;
		return formObject.options[selectedIndex].value;
	}

	function submitCreate(form)
	{
		
		
		if (form.name.value=='') {
			error("<fmt:message key="RFQCreateDisplay_Error1" bundle="${storeText}" />");
			return;
		}
		if (form.starttime.value!='hh:mm') {
			var temp;
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
		
		var numProd = "numProd";
		
		if (form[numProd]) {
			for (var i = 0; i < form.numProd.value; i++) {
				var percentagePrice = 'percentagePrice_' + (i + 1);
				var price = 'price_' + (i + 1);
				var quantity = 'quantity_' + (i + 1);
				var quantityunit = 'quantityunit_' + (i + 1);
				var substitutable = 'subst_' + (i + 1); 
				var prodType = 'prodType_' + (i + 1); 				
				
				var endresult = "0"; //is Contract
				if (form.endresult[0].checked) {	
					endresult = "1"; //is Order
				}			
							
					
				if (form[percentagePrice]) {
					var numPerAdjust = parseInt(form[percentagePrice].value);
					}
				var numFixedPrice = parseInt(form[price].value);
				var numQuantity = parseInt(form[quantity].value);		
				
				 
			if (form[percentagePrice]) {
				if (Trim(form[percentagePrice].value)!='') {
					if (form[percentagePrice].value!='0.0') {	
					
						if (isNaN(numPerAdjust)) {	
								error('<fmt:message key='RFQModifyDisplay_Error16' bundle='${storeText}' />');
								return;
						}
					
						if ((numPerAdjust<0) || (numPerAdjust>100)) {	
								error("<fmt:message key="RFQModifyDisplay_Error20" bundle="${storeText}" />");
								return;
						}
					
					
						if (form[price]) {
							if (Trim(form[price].value)!='') {
								error("<fmt:message key="RFQModifyDisplay_Error18" bundle="${storeText}" />");
								return;
							}
						}				
						
					}
				} 
			}	
					
								
			if (endresult == '1'){	//Order
				if (!isNaN(numPerAdjust)) {	
				
					if (form[quantity]) {
						if (Trim(form[quantity].value)=='') {								
							error("<fmt:message key="RFQModifyDisplay_Error10" bundle="${storeText}" />");
							return;
						}
					}
					
																				
				} 				
			}	
			 
			if (endresult == '0'){	//Contract
				if (!isNaN(numPerAdjust)) {	
				
					if (form[quantity]) {
						if (Trim(form[quantity].value)!='') {
							if (form[quantity].value!='0') { 
								error("<fmt:message key="RFQModifyDisplay_Error18" bundle="${storeText}" />");
								return;
							}
						}
					}	
					
					var index = form[quantityunit].selectedIndex;
					var item = form[quantityunit].options[index].value;		
							
					if (Trim(item)!='') {
						error("<fmt:message key="RFQModifyDisplay_Error18" bundle="${storeText}" />");
						return;
					}	 				
					
				} 
				
			}		
				
						

			if (form[price]) {
				if (Trim(form[price].value)!='') {
					if (form[price].value!='0') {
												
						if (isNaN(numFixedPrice)) {			
							error('<fmt:message key='RFQModifyDisplay_Error21' bundle='${storeText}' />');
							return;
						}
						if ((numFixedPrice<0) ) {
							error('<fmt:message key='RFQModifyDisplay_Error22' bundle='${storeText}' />');
							return;
						}
						
					}
				}
			}
			
			if (form[quantity]) {
				if (Trim(form[quantity].value)!='') {
					if (form[quantity].value!='0') {									
												
						if (isNaN(numQuantity)) {			
							error('<fmt:message key='RFQModifyDisplay_Error23' bundle='${storeText}' />');
							return;
						}
						if ((numQuantity<0)) {
							error('<fmt:message key='RFQModifyDisplay_Error24' bundle='${storeText}' />');
							return;
						}
						
					}
				}
			}	
			
<c:if test="${orderId != null and orderId != ''}" >
	if (form[percentagePrice]) {
			if (Trim(form[percentagePrice].value)!='') {
				if (form[percentagePrice].value!='0.0') {	
					if (form[prodType].value=='<fmt:message key="RFQModifyDisplay_Product" bundle="${storeText}" />') {	
						if (form.endresult[0].checked) {								
							error("<fmt:message key="RFQModifyDisplay_Error25" bundle="${storeText}" />");
							return;
						}
					}	
				}
			}
		}

</c:if>			
			}
		}


<c:if test="${productId != null and productId != '' and accountid != ''}" >			
		if (form.endresult[0].checked) {			
			error("<fmt:message key="RFQModifyDisplay_Error25" bundle="${storeText}" />");
			return;
		}
</c:if>


<c:if test="${catentry_id != null and catentry_id != ''}" >	
		
		if (form[percentagePrice]) {
			if (Trim(form[percentagePrice].value)!='') {
				if (form[percentagePrice].value!='0.0') {	
					if (form[prodType].value=='<fmt:message key="RFQModifyDisplay_Product" bundle="${storeText}" />') {	
						if (form.endresult[0].checked) {									
							error("<fmt:message key="RFQModifyDisplay_Error25" bundle="${storeText}" />");
							return;
						}
					}
				}
			}
		}
</c:if>


<c:if test="${categoryId != null and categoryId != '' and accountid != null and accountid != ''}" >	

						
			if (form.categoryPercentagePrice.value=='') {			
				error("<fmt:message key="RFQModifyDisplay_Error17" bundle="${storeText}" />");
				return;
			}
			var temp = parseInt(form.categoryPercentagePrice.value);
			if (isNaN(temp)) {			
				error('<fmt:message key='RFQModifyDisplay_Error16' bundle='${storeText}' />');
				return;
			}
			if ((temp<0) || (temp>100)) {
				error("<fmt:message key="RFQModifyDisplay_Error20" bundle="${storeText}" />");
				return;
			}		
			if (form.endresult[0].checked) {
				error("<fmt:message key="RFQModifyDisplay_Error19" bundle="${storeText}" />");
				return;		
			}
		
</c:if>
	
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
	function checkAccount(form)
	{
		if (form.account_id.value=='') {
			error("<fmt:message key="RFQCreateDisplay_Error6" bundle="${storeText}" />");
			form.endresult.value = '1';
			return;
		}		
		
	}
	function error(errMsg)
	{
		alert(errMsg);
	}
	
	function Trim(str) {
 		var r=/\b(.*)\b/.exec(str);
		return (r==null)?"":r[1];
	}


</script>
