<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2001, 2008 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>
<%--
  *****
  * This JSP page displays fields for adding specifications (date types)
  * to an RFQ product specification.
  *
  * Elements:
  * - Specification selection box
  * - Operator selection box
  * - Date/Time selection boxes
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

<jsp:useBean id="now" class="java.util.Date"/>
<c:set var="expire_year" value="${now.year + 1900}"/>

<c:set var="rfqprodId" value="${WCParam.rfqprod_id}" scope="request" />
<script language="javascript">
	function submitAdd(form)
	{
		if (getValueFromSelection(form.year) == '') {
			error("<fmt:message key="RFQModifyAddSpecificationDisplay_Error1" bundle="${storeText}" />");
			return;
		}
		if (getValueFromSelection(form.month) == '') {
			error("<fmt:message key="RFQModifyAddSpecificationDisplay_Error1" bundle="${storeText}" />");
			return;
		}
		if (getValueFromSelection(form.day) == '') {
			error("<fmt:message key="RFQModifyAddSpecificationDisplay_Error1" bundle="${storeText}" />");
			return;
		}
		form.value.value = getValueFromSelection(form.year) + '-' + getValueFromSelection(form.month) + '-' + getValueFromSelection(form.day) + ' 00:00:00';
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
		} 
		if (form.attrType.value == '<c:out value="${EC_ATTRTYPE_DATETIME}" />')
		{
			form.specJSP.value = 'RFQModifyAddSpecificationTimestampDisplay.jsp';
			return;
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

<fmt:message key="RFQCompleteOrderDisplay_Jan" bundle="${storeText}" var="Jan"/>
<fmt:message key="RFQCompleteOrderDisplay_Feb" bundle="${storeText}" var="Feb"/>
<fmt:message key="RFQCompleteOrderDisplay_Mar" bundle="${storeText}" var="Mar"/>
<fmt:message key="RFQCompleteOrderDisplay_Apr" bundle="${storeText}" var="Apr"/>
<fmt:message key="RFQCompleteOrderDisplay_May" bundle="${storeText}" var="May"/>
<fmt:message key="RFQCompleteOrderDisplay_Jun" bundle="${storeText}" var="Jun"/>
<fmt:message key="RFQCompleteOrderDisplay_Jul" bundle="${storeText}" var="Jul"/>
<fmt:message key="RFQCompleteOrderDisplay_Aug" bundle="${storeText}" var="Aug"/>
<fmt:message key="RFQCompleteOrderDisplay_Sep" bundle="${storeText}" var="Sep"/>
<fmt:message key="RFQCompleteOrderDisplay_Oct" bundle="${storeText}" var="Oct"/>
<fmt:message key="RFQCompleteOrderDisplay_Nov" bundle="${storeText}" var="Nov"/>
<fmt:message key="RFQCompleteOrderDisplay_Dec" bundle="${storeText}" var="Dec"/>



<c:set var="value" value="${param.value}" scope="request" />

			<input type="hidden" name="attrType" value="<c:out value="${EC_ATTRTYPE_STRING}" />" id="WC_RFQModifyAddSpecificationTimestampDisplay_FormInput_attrType_1"/>
			<input type="hidden" name="specJSP" value="RFQModifyAddSpecificationTimestampDisplay.jsp" id="WC_RFQModifyAddSpecificationTimestampDisplay_FormInput_specJSP_1"/>
			
			<wcbase:useBean id="rfqProduct" classname="com.ibm.commerce.utf.beans.RFQProdDataBean">
                     <jsp:setProperty property="*" name="rfqProduct"/>                     
              </wcbase:useBean>
         	  <c:set var="operatorsTSList" value="${rfqProduct.operatorsTS}"  scope="request" />
	
			
			
			<tr>
				<td height="21" id="WC_RFQModifyAddSpecificationTimestampDisplay_TableCell_1">
					<label for="WC_RFQModifyAddSpecificationTimestampDisplay_Select_1"><fmt:message key="RFQModifyAddSpecificationDisplay_Op" bundle="${storeText}" />					
				</label></td>
				<td id="WC_RFQModifyAddSpecificationTimestampDisplay_TableCell_2">
 					<select id="WC_RFQModifyAddSpecificationTimestampDisplay_Select_1" class="select" name="<c:out value="${EC_ATTR_OPERATOR}" />">
 						<c:catch var="e">
 						<c:forEach var="units" items="${requestScope.operatorsTSList}" varStatus="iter">
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

			<tr><td id="WC_RFQModifyAddSpecificationTimestampDisplay_TableCell_3">&nbsp;</td></tr>

			<tr>
				<td height="21" id="WC_RFQModifyAddSpecificationTimestampDisplay_TableCell_4">
					<span class="reqd">*</span><fmt:message key="RFQModifyAddSpecificationDisplay_Value" bundle="${storeText}" />
				</td>
				<input type="hidden" name="<c:out value="${EC_ATTR_VALUE}" />" value="" id="WC_RFQModifyAddSpecificationTimestampDisplay_FormInput_<c:out value="${EC_ATTR_VALUE}" />_1"/>
				<input type="hidden" name="<c:out value="${EC_OFFERING_QTYUNIT}" />" value="" id="WC_RFQModifyAddSpecificationTimestampDisplay_FormInput_<c:out value="${EC_OFFERING_QTYUNIT}" />_1"/>
				<td nowrap="nowrap" id="WC_RFQModifyAddSpecificationTimestampDisplay_TableCell_5">
				
				<c:choose>
				<c:when test="${locale == 'pt_BR'  or locale == 'fr_FR' or locale == 'de_DE' or locale == 'it_IT' or locale == 'es_ES'}">
 						
 						<label for="WC_RFQModifyAddSpecificationTimestampDisplay_Select_2"><fmt:message key="RFQCreateDisplay_Day" bundle="${storeText}"/></label>:
						<select id="WC_RFQModifyAddSpecificationTimestampDisplay_Select_2" class="select" name="day">
             			<option value=""> --<fmt:message key="RFQCreateDisplay_SelectDay" bundle="${storeText}" />-- </option>         
							<c:forTokens var="day"
								items="1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31"
								delims=","> 
							<OPTION value="<c:out value="${day}"/>" ><c:out	value="${day}" /></OPTION>
							</c:forTokens>
						</select>
 						
				</c:when>
				<c:otherwise>
						<label for="WC_RFQModifyAddSpecificationTimestampDisplay_Select_2"><fmt:message key="RFQCreateDisplay_Year" bundle="${storeText}"/></label>:
						
						<SELECT id="WC_RFQModifyAddSpecificationTimestampDisplay_Select_2" class="select" name="year">
						<option value=""> --<fmt:message key="RFQCreateDisplay_SelectYear" bundle="${storeText}" />-- </option>
						<c:forEach begin="0" end="10" varStatus="counter">
						<c:set var="year" value="${expire_year+counter.index}"/>
						<OPTION value="<c:out value="${year}"/>" ><c:out value="${year}"/></OPTION>
						</c:forEach>
		</SELECT>
										
				
				</c:otherwise>
				</c:choose> 
				
				
				<label for="WC_RFQModifyAddSpecificationTimestampDisplay_Select_3"><fmt:message key="RFQCreateDisplay_Month" bundle="${storeText}"/></label>:   		
				<select id="WC_RFQModifyAddSpecificationTimestampDisplay_Select_3" class="select" name="month">
             		<option value=""> --<fmt:message key="RFQCreateDisplay_SelectMonth" bundle="${storeText}" />-- </option>         
         			<c:forTokens var="month" items="1,2,3,4,5,6,7,8,9,10,11,12" delims=",">
						<option value="<c:out value="${month}"/>">
						
					<c:choose>
					<c:when test="${month eq 1}" ><c:out value="${Jan}" /></c:when>
					<c:when test="${month eq 2}" ><c:out value="${Feb}" /></c:when>
					<c:when test="${month eq 3}" ><c:out value="${Mar}" /></c:when>
					<c:when test="${month eq 4}" ><c:out value="${Apr}" /></c:when>
					<c:when test="${month eq 5}" ><c:out value="${May}" /></c:when>
					<c:when test="${month eq 6}" ><c:out value="${Jun}" /></c:when>
					<c:when test="${month eq 7}" ><c:out value="${Jul}" /></c:when>
					<c:when test="${month eq 8}" ><c:out value="${Aug}" /></c:when>
					<c:when test="${month eq 9}" ><c:out value="${Sep}" /></c:when>
					<c:when test="${month eq 10}" ><c:out value="${Oct}" /></c:when>
					<c:when test="${month eq 11}" ><c:out value="${Nov}" /></c:when>
					<c:when test="${month eq 12}" ><c:out value="${Dec}" /></c:when>			
					<c:otherwise>				
					</c:otherwise>			
					</c:choose>			
						
						
					</option>			
					
					
					
					
					</c:forTokens>    		   		
				</select>	
				
	
				<c:choose>
				<c:when test="${locale == 'pt_BR'  or locale == 'fr_FR' or locale == 'de_DE' or locale == 'it_IT' or locale == 'es_ES'}">
 						<label for="WC_RFQModifyAddSpecificationTimestampDisplay_Select_4"><fmt:message key="RFQCreateDisplay_Year" bundle="${storeText}"/></label>:
						
						<SELECT id="WC_RFQModifyAddSpecificationTimestampDisplay_Select_4" class="select" name="year">
						<option value=""> --<fmt:message key="RFQCreateDisplay_SelectYear" bundle="${storeText}" />-- </option>
						<c:forEach begin="0" end="10" varStatus="counter">
						<c:set var="year" value="${expire_year+counter.index}"/>
						<OPTION value="<c:out value="${year}"/>" ><c:out value="${year}"/></OPTION>
						</c:forEach>
						</SELECT>
						
				
				</c:when>
				<c:otherwise>
					 	<label for="WC_RFQModifyAddSpecificationTimestampDisplay_Select_5"><fmt:message key="RFQCreateDisplay_Day" bundle="${storeText}"/></label>:
						<select id="WC_RFQModifyAddSpecificationTimestampDisplay_Select_5" class="select" name="day">
             			<option value=""> --<fmt:message key="RFQCreateDisplay_SelectDay" bundle="${storeText}" />-- </option>         
							<c:forTokens var="day"
								items="1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31"
								delims=","> 
							<OPTION value="<c:out value="${day}"/>" ><c:out	value="${day}" /></OPTION>
							</c:forTokens>
						</select>
				
				</c:otherwise>
				</c:choose>
				
				


				</td>
			</tr>

