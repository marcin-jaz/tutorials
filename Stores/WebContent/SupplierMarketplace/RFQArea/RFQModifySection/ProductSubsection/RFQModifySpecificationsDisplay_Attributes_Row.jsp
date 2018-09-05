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
  * This JSP page iterates through a list of RFQ product specifications.
  *
  * Imports:  
  * - RFQModifyAddSpecificationDisplay_OperatorsTS.jsp
  * - RFQModifyAddSpecificationDisplay_Operators.jsp
  *
  * Required parameters:
  * - plist
  * - index - int
  *
  *****
--%>

<%@ page language="java" %>

<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf" %>


<jsp:useBean id="now" class="java.util.Date"/>
<c:set var="expire_year" value="${now.year + 1900}"/>
 
<c:set var="plist" value="${requestScope.plist}" />
<c:set var="product" value="${pList[param.index]}" />
<c:set var="quantityUnits" value="${product.quantityUnits}" scope="request" />
<c:set var="pAttribute" value="${plist[param.index]}" />
<c:set var="pattribute_name" value="${pAttribute.name}" />
<c:set var="pattribute_desc" value="${pAttribute.description}" />

<c:set var="EC_OFFERING_ID" value="offering_id" scope="request" />
<c:set var="EC_OFFERING_CATENTRYID" value="catentryid" scope="request" />
<c:set var="EC_RFQ_PRODUCT_ID" value="rfqprod_id" scope="request" />
<c:set var="EC_UTF_MANDATORY" value="1" scope="request" />
<c:set var="EC_UTF_OPTIONAL" value="0" scope="request" />
<c:set var="EC_UTF_NON_CHANGEABLE" value="0" scope="request" />
<c:set var="EC_UTF_CHANGEABLE" value="1" scope="request" />
<c:set var="EC_ATTR_MANDATORY" value="mandatory" scope="request" />
<c:set var="EC_ATTR_CHANGEABLE" value="changeable" scope="request" />

<c:set var="EC_ATTRTYPE_DATETIME" value="DATETIME" scope="request" />
<c:set var="EC_ATTRTYPE_ATTACHMENT" value="ATTACHMENT" scope="request" />
<c:set var="EC_OPERATOR_EQUAL" value="0" scope="request" />    
<c:set var="EC_ATTRTYPE_DATETIME" value="DATETIME" scope="request" />
<c:set var="EC_ATTACH_ID" value="attachment_id" scope="request" />
<c:set var="EC_PATTRVALUE_ID" value="pAttrValueId" scope="request" />

<fmt:message key="RFQProductDisplay_Yes" bundle="${storeText}" var="pattribute_userdefine" />

<c:if test="${pAttribute.attribute_id > 0}" >
	<c:set var="pattribute_desc" value="${pattribute_name}" />
	<fmt:message key="RFQProductDisplay_No" bundle="${storeText}" var="pattribute_userdefine" />
</c:if>
 

<c:if test="${!empty pAttribute.operator_id }" >
	<wcbase:useBean id="opDB"
		classname="com.ibm.commerce.catalog.beans.OperatorDescriptionDataBean">
		<c:set target="${opDB}" property="dataBeanKeyLanguageId" value="${langId}" />
		<c:set target="${opDB}" property="dataBeanKeyOperatorId" value="${pAttribute.operator_id}" />
	
	</wcbase:useBean>
		<c:set var="pattribute_opname" value="${opDB.description}" />	
		
</c:if>
<c:set var="pattribute_value" value="${pAttribute.value}" />
<c:if test="${pAttribute.attrtype eq EC_ATTRTYPE_DATETIME}" >
  
	<fmt:parseDate value="${pattribute_value}" pattern="yyyy-MM-dd" var="pAttributeDateTime" />						
	
	<fmt:formatDate value="${pAttributeDateTime}" pattern="yyyy" var="year_value" scope="request" />
	<fmt:formatDate value="${pAttributeDateTime}" pattern="MM" var="month_value" scope="request" />
	<fmt:formatDate value="${pAttributeDateTime}" pattern="dd" var="day_value" scope="request" />
 
</c:if>

<c:set var="pattribute_unit" value="${pAttribute.unit}" />
<c:if test="${!empty pattribute_unit}" > 
		<wcbase:useBean id="qudb"	classname="com.ibm.commerce.common.beans.QuantityUnitDescriptionDataBean">
			<c:set target="${qudb}" property="dataBeanKeyLanguage_id" value="${langId}" />
			<c:set target="${qudb}" property="dataBeanKeyQuantityUnitId" value="${pattribute_unit}" />
			
			<c:set var="pattribute_unitname" value="${qudb.description}" />
		</wcbase:useBean>
</c:if>
<c:set var="pattribute_mandatory" value="${pAttribute.mandatory}" />
<c:choose>
	<c:when test="${pattribute_mandatory eq EC_UTF_MANDATORY or pattribute_mandatory eq 'true' }">
		<fmt:message key="RFQProductDisplay_Yes" bundle="${storeText}" var="mandatory" />
	</c:when>
	<c:when test="${pattribute_mandatory eq EC_UTF_OPTIONAL or pattribute_mandatory eq 'false'}">
		<fmt:message key="RFQProductDisplay_No" bundle="${storeText}" var="mandatory" />
	</c:when>
</c:choose>
 
<c:set var="pattribute_changeable" value="${pAttribute.changeable}" />
<c:choose>
	<c:when test="${pattribute_changeable eq EC_UTF_NON_CHANGEABLE or pattribute_changeable eq 'false' }">
		<fmt:message key="RFQProductDisplay_No" bundle="${storeText}" var="changeable" />
	</c:when>
	<c:when test="${pattribute_changeable eq EC_UTF_CHANGEABLE or pattribute_changeable eq 'true'}">
		<fmt:message key="RFQProductDisplay_Yes" bundle="${storeText}" var="changeable" />
	</c:when>
</c:choose>
<c:set var="isTypeAttachment" value="${pAttribute.attrtype eq EC_ATTRTYPE_ATTACHMENT}" />
<c:set var="pAttrValueId" value="0" />
<c:set var="attachment_id" />
<c:set var="filename" value="" />


<c:choose> 
<c:when test="${isTypeAttachment}" >
	<wcbase:useBean id="attachment" classname="com.ibm.commerce.contract.beans.AttachmentDataBean">
		<jsp:setProperty property="*" name="attachment" />
		<c:set target="${attachment}" property="dataBeanKeyAttachmentId" value="${pAttribute.value}" />
	</wcbase:useBean>
	<c:set var="pAttrValueId" value="${pAttribute.PAttrValueId}" />
	<c:set var="attachment_id" value="${pAttribute.value}" />
	<c:set var="filename" value="${attachment.filename}" />
	<c:set var="isTypeAttachment" value="true" />
</c:when>
<c:otherwise>
	<c:set var="pAttrValueId" value="${pAttribute.PAttrValueId}" />	
</c:otherwise>
</c:choose>
 
 
<c:choose> 
<c:when test="${empty pAttribute.pattribute_id}" >

	<td headers="a1" class="t_td" id="WC_RFQModifySpecificationDisplay_TableCell_21"><c:out value="${pattribute_desc}" />&nbsp;</td>
	<td headers="a2" class="t_td" id="WC_RFQModifySpecificationDisplay_TableCell_22"><c:out value="${pattribute_opname}" /></td>
	<td headers="a3" class="t_td" id="WC_RFQModifySpecificationDisplay_TableCell_23"><c:out value="${pattribute_value}" /></td>	
	<td headers="a4" class="t_td" id="WC_RFQModifySpecificationDisplay_TableCell_24"><c:out value="${pattribute_unitname}" /></td>
	<td headers="a5" class="t_td" id="WC_RFQModifySpecificationDisplay_TableCell_25" ><c:out value="${mandatory}" /></td>
	<td headers="a6" class="t_td" id="WC_RFQModifySpecificationDisplay_TableCell_26"><c:out value="${changeable}" /></td>
	<td headers="a7" class="t_td" id="WC_RFQModifySpecificationDisplay_TableCell_27">&nbsp;</td>		
 	<c:set var="count" value="${requestScope.count+1}" scope="request" />
</c:when>
<c:otherwise>

	
	
	<td headers="a1" class="t_td" id="WC_RFQModifySpecificationDisplay_TableCell_16"><c:out value="${pattribute_desc}" />
		<input type="hidden" name="pAttrType_<c:out value="${param.index + 1 - count}" />" value="<c:out value="${pAttribute.attrtype}" />" id="WC_RFQModifySpecificationDisplay_FormInput_pAttrType_<c:out value="${param.index + 1 - count}" />_In_RFQModifySpecificationForm_1"/>
		<input type="hidden" name="valuedelim_<c:out value="${param.index + 1 - count}" />" value=";" id="WC_RFQModifySpecificationDisplay_FormInput_valuedelim_<c:out value="${param.index + 1 - count}" />_In_RFQModifySpecificationForm_1"/>
		<input type="hidden" name="name_<c:out value="${param.index + 1 - count}" />" value="<c:out value="${pAttribute.name}" />" id="WC_RFQModifySpecificationDisplay_FormInput_name_<c:out value="${param.index + 1 - count}" />_In_RFQModifySpecificationForm_1"/>
		<input type="hidden" name="pAttrValueId_<c:out value="${param.index + 1 - count}" />" value="<c:out value="${pAttrValueId}" />" id="WC_RFQModifySpecificationDisplay_FormInput_pAttrValueId_<c:out value="${param.index + 1 - count}" />_In_RFQModifySpecificationForm_1"/>
		<input type="hidden" name="rfqprod_id_<c:out value="${param.index + 1 - count}" />" value="<c:out value="${rfqprodId}" />" id="WC_RFQModifySpecificationDisplay_FormInput_rfqprod_id_<c:out value="${param.index + 1 - count}" />_In_RFQModifySpecificationForm_1"/>
	</td>




	<td headers="a2" class="t_td" id="WC_RFQModifySpecificationDisplay_TableCell_17">	
	
	<c:choose>
	<c:when test="${pAttribute.attrtype eq EC_ATTRTYPE_ATTACHMENT}" >
		<input type="hidden" name="operator_<c:out value="${param.index + 1 - count}" />" value="<c:out value="${EC_OPERATOR_EQUAL}" />" id="WC_RFQModifySpecificationDisplay_FormInput_operator_<c:out value="${param.index + 1 - count}" />_In_RFQModifySpecificationForm_1" />	
		<c:out value="${pattribute_opname}" />
	</c:when>
	<c:when test="${pAttribute.attrtype eq EC_ATTRTYPE_DATETIME}" >
    <label for="WC_RFQModifySpecificationDisplay_Select_1"></label>  
		<select id="WC_RFQModifySpecificationDisplay_Select_1" class="select" name="operator_<c:out value="${param.index + 1 - count}" />" title="<fmt:message key="RFQModifySpecificationDisplay_Op" bundle="${storeText}" /> <c:out value="${pattribute_desc}" />">
			   <% out.flush(); %>
			   <c:import url="RFQModifyAddSpecificationDisplay_OperatorsTS.jsp" > 
			   		<c:param name="operator_id" value="${pAttribute.operator_id}" />
			   </c:import>   
			   <% out.flush(); %> 
 	 					 
		</select> 

	</c:when>
	<c:otherwise>
        <label for="WC_RFQModifySpecificationDisplay_Select_2"></label>    
		<select id="WC_RFQModifySpecificationDisplay_Select_2" class="select" name="operator_<c:out value="${param.index + 1 - count}" />" title="<fmt:message key="RFQModifySpecificationDisplay_Op" bundle="${storeText}" /> <c:out value="${pattribute_desc}" />">
 		<% out.flush(); %>
		<c:import url="RFQModifyAddSpecificationDisplay_Operators.jsp" />     
 		<% out.flush(); %>		
		<c:forEach items="${requestScope.operatorsList}" begin="0" varStatus="iter">
				<c:set var="indx" value="${iter.index}" />	
				<wcbase:useBean id="opDB2"	classname="com.ibm.commerce.catalog.beans.OperatorDescriptionDataBean">
					<c:set target="${opDB2}" property="dataBeanKeyLanguageId" value="${langId}" />
					<c:set target="${opDB2}" property="dataBeanKeyOperatorId" value="${indx}" />
					
				</wcbase:useBean>
				<c:set var="opname" value="${opDB2.description}" />			
		
				<option value="<c:out value="${indx}" />" 
				
				<c:if test="${pAttribute.operator_id eq indx}" >
					selected 				
				</c:if>
				
				><c:out value="${opname}" /></option>			
		<c:remove var="opDB2" />
		</c:forEach>		


			</select>


		
	</c:otherwise>
	</c:choose>
	</td> 

	<td headers="a3" nowrap="nowrap" class="t_td" id="WC_RFQModifySpecificationDisplay_TableCell_18">
	
	
	
	<c:choose>
	<c:when test="${pAttribute.attrtype eq EC_ATTRTYPE_ATTACHMENT}" >		
		<a href="RFQAttachmentView?<c:out value="${EC_ATTACH_ID}" />=<c:out value="${attachment_id}" />&<c:out value="${EC_PATTRVALUE_ID}" />=<c:out value="${pAttrValueId}" />&langId=<c:out value="${langId}" />&storeId=<c:out value="${storeId}" />" id="WC_RFQModifySpecificationDisplay_Link_1"><c:out value="${filename}" /></a>
		<input id="WC_RFQModifySpecificationDisplay_Select_3" type="hidden" name="value_<c:out value="${param.index + 1 - count}" />" value="<c:out value="${pAttribute.value}" />" id="WC_RFQModifySpecificationDisplay_FormInput_value_<c:out value="${param.index + 1 - count}" />_In_RFQModifySpecificationForm_1"/>		
	</c:when>
	<c:when test="${pAttribute.attrtype eq EC_ATTRTYPE_DATETIME}" >
	
					
	<c:choose>
	 <c:when test="${locale == 'pt_BR'  or locale == 'fr_FR' or locale == 'de_DE' or locale == 'it_IT' or locale == 'es_ES'}">
        <label for="WC_RFQModifySpecificationDisplay_Select_11">
        <fmt:message key="RFQCreateDisplay_Day" bundle="${storeText}"/>:</label>
		<select id="WC_RFQModifySpecificationDisplay_Select_11" class="select" name="day_<c:out value="${param.index + 1 - count}" />" onchange="document.RFQModifySpecificationForm.value_<c:out value="${param.index + 1 - count}" />.value=getValueFromHTMLElement(document.RFQModifySpecificationForm.year_<c:out value="${param.index + 1 - count}" />)+'-'+getValueFromHTMLElement(document.RFQModifySpecificationForm.month_<c:out value="${param.index + 1 - count}" />)+'-'+getValueFromHTMLElement(document.RFQModifySpecificationForm.day_<c:out value="${param.index + 1 - count}" />)+' 00:00:00'">              
				<c:forTokens var="day"
					items="01,02,03,04,05,06,07,08,09,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31"
					delims=","> 
					<OPTION value="<c:out value="${day}"/>" <c:if test="${day_value eq day}"><c:out value="selected='selected'" /></c:if>><c:out value="${day}" /></OPTION>
				</c:forTokens>
		</select>

	</c:when>
	<c:otherwise>	
    <label for="WC_RFQModifySpecificationDisplay_Select_4">
		<fmt:message key="RFQCreateDisplay_Year" bundle="${storeText}"/>:</label>
		
		<SELECT id="WC_RFQModifySpecificationDisplay_Select_4" class="select" name="year_<c:out value="${param.index + 1 - count}" />" onchange="document.RFQModifySpecificationForm.value_<c:out value="${param.index + 1 - count}" />.value=getValueFromHTMLElement(document.RFQModifySpecificationForm.year_<c:out value="${param.index + 1 - count}" />)+'-'+getValueFromHTMLElement(document.RFQModifySpecificationForm.month_<c:out value="${param.index + 1 - count}" />)+'-'+getValueFromHTMLElement(document.RFQModifySpecificationForm.day_<c:out value="${param.index + 1 - count}" />)+' 00:00:00'">
	    	<c:forEach begin="0" end="10" varStatus="counter">
			<c:set var="year" value="${expire_year+counter.index}"/>
			<OPTION value="<c:out value="${year}"/>" <c:if test="${year_value eq year}"><c:out value="selected='selected'" /></c:if>><c:out value="${year}"/></OPTION>
	    	</c:forEach>
		</SELECT>
		
        
	</c:otherwise>
	</c:choose>
	
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
	
	
         <label for="WC_RFQModifySpecificationDisplay_Select_5">
	  	<fmt:message key="RFQCreateDisplay_Month" bundle="${storeText}"/>:</label>
		<select id="WC_RFQModifySpecificationDisplay_Select_5" class="select" name="month_<c:out value="${param.index + 1 - count}" />" onchange="document.RFQModifySpecificationForm.value_<c:out value="${param.index + 1 - count}" />.value=getValueFromHTMLElement(document.RFQModifySpecificationForm.year_<c:out value="${param.index + 1 - count}" />)+'-'+getValueFromHTMLElement(document.RFQModifySpecificationForm.month_<c:out value="${param.index + 1 - count}" />)+'-'+getValueFromHTMLElement(document.RFQModifySpecificationForm.day_<c:out value="${param.index + 1 - count}" />)+' 00:00:00'">
                 
         		<c:forTokens var="month" items="01,02,03,04,05,06,07,08,09,10,11,12" delims=",">
					<option value="<c:out value="${month}"/>"<c:if test="${month_value eq month}"> <c:out value="selected='selected'" /></c:if>>
					
					<c:choose>
					<c:when test="${month eq '01'}" ><c:out value="${Jan}" /></c:when>
					<c:when test="${month eq '02'}" ><c:out value="${Feb}" /></c:when>
					<c:when test="${month eq '03'}" ><c:out value="${Mar}" /></c:when>
					<c:when test="${month eq '04'}" ><c:out value="${Apr}" /></c:when>
					<c:when test="${month eq '05'}" ><c:out value="${May}" /></c:when>
					<c:when test="${month eq '06'}" ><c:out value="${Jun}" /></c:when>
					<c:when test="${month eq '07'}" ><c:out value="${Jul}" /></c:when>
					<c:when test="${month eq '08'}" ><c:out value="${Aug}" /></c:when>
					<c:when test="${month eq '09'}" ><c:out value="${Sep}" /></c:when>
					<c:when test="${month eq '10'}" ><c:out value="${Oct}" /></c:when>
					<c:when test="${month eq '11'}" ><c:out value="${Nov}" /></c:when>
					<c:when test="${month eq '12'}" ><c:out value="${Dec}" /></c:when>			
					<c:otherwise>				
					</c:otherwise>			
					</c:choose>	
					
					
					</option>
				</c:forTokens>    		   		
		</select>	
         
	<c:choose>
	 <c:when test="${locale == 'pt_BR'  or locale == 'fr_FR' or locale == 'de_DE' or locale == 'it_IT' or locale == 'es_ES'}">
         <label for="WC_RFQModifySpecificationDisplay_Select_6">
        <fmt:message key="RFQCreateDisplay_Year" bundle="${storeText}"/>:</label>
		
		<SELECT id="WC_RFQModifySpecificationDisplay_Select_6" class="select" name="year_<c:out value="${param.index + 1 - count}" />" onchange="document.RFQModifySpecificationForm.value_<c:out value="${param.index + 1 - count}" />.value=getValueFromHTMLElement(document.RFQModifySpecificationForm.year_<c:out value="${param.index + 1 - count}" />)+'-'+getValueFromHTMLElement(document.RFQModifySpecificationForm.month_<c:out value="${param.index + 1 - count}" />)+'-'+getValueFromHTMLElement(document.RFQModifySpecificationForm.day_<c:out value="${param.index + 1 - count}" />)+' 00:00:00'">
	    	<c:forEach begin="0" end="10" varStatus="counter">
			<c:set var="year" value="${expire_year+counter.index}"/>
			<OPTION value="<c:out value="${year}"/>" <c:if test="${year_value eq year}"><c:out value="selected='selected'" /></c:if>><c:out value="${year}"/></OPTION>
	    	</c:forEach>
		</SELECT>
		
        
	</c:when>
	<c:otherwise> 
    <label for="WC_RFQModifySpecificationDisplay_Select_7"> 
		<fmt:message key="RFQCreateDisplay_Day" bundle="${storeText}"/>:</label>
		<select id="WC_RFQModifySpecificationDisplay_Select_7" class="select" name="day_<c:out value="${param.index + 1 - count}" />" onchange="document.RFQModifySpecificationForm.value_<c:out value="${param.index + 1 - count}" />.value=getValueFromHTMLElement(document.RFQModifySpecificationForm.year_<c:out value="${param.index + 1 - count}" />)+'-'+getValueFromHTMLElement(document.RFQModifySpecificationForm.month_<c:out value="${param.index + 1 - count}" />)+'-'+getValueFromHTMLElement(document.RFQModifySpecificationForm.day_<c:out value="${param.index + 1 - count}" />)+' 00:00:00'">              
				<c:forTokens var="day"
					items="01,02,03,04,05,06,07,08,09,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31"
					delims=","> 
					<OPTION value="<c:out value="${day}"/>" <c:if test="${day_value eq day}"><c:out value="selected='selected'" /></c:if>><c:out value="${day}" /></OPTION>
				</c:forTokens>
		</select>
         
	</c:otherwise>
	</c:choose>
	
		
	<input type="hidden" name="value_<c:out value="${param.index + 1 - count}" />" value="<c:out value="${pattribute_value}" />" id="WC_RFQModifySpecificationDisplay_FormInput_value_<c:out value="${param.index + 1 - count}" />_In_RFQModifySpecificationForm_2"/>	
		
		
		
	</c:when>
	<c:otherwise>
    <label for="WC_RFQModifySpecificationDisplay_Input_1"></label>

		<input id="WC_RFQModifySpecificationDisplay_Input_1" class="input" type="text" name="value_<c:out value="${param.index + 1 - count}" />" title="<fmt:message key="RFQModifySpecificationDisplay_Value" bundle="${storeText}" /> <c:out value="${pattribute_desc}" />" value="<c:out value="${pattribute_value}" />" />
      

    </c:otherwise>
	</c:choose>
	</td>
		
	<td headers="a4" class="t_td" id="WC_RFQModifySpecificationDisplay_TableCell_19">	

<wcbase:useBean id="QuantityUnitList" classname="com.ibm.commerce.common.beans.QuantityUnitListDataBean">
        <c:set target="${QuantityUnitList}" property="languageId" value="${langId}" />
</wcbase:useBean>
<c:set var="quantitiesByLanguage" value="${QuantityUnitList.quantityUnitList}"/>


	<c:choose>
	<c:when test="${pAttribute.attrtype eq EC_ATTRTYPE_ATTACHMENT or pAttribute.attrtype eq EC_ATTRTYPE_DATETIME}" >	
		<input type="hidden" name="quantityunit_<c:out value="${param.index + 1 - count}" />" value="" id="WC_RFQModifySpecificationDisplay_FormInput_quantityunit_<c:out value="${param.index + 1 - count}" />_In_RFQModifySpecificationForm_1"/>
	</c:when>	
	<c:otherwise> 
		<select id="WC_RFQModifySpecificationDisplay_Select_7" class="select" name="quantityunit_<c:out value="${param.index + 1 - count}" />" title="<fmt:message key="RFQModifySpecificationDisplay_Unit" bundle="${storeText}" /> <c:out value="${pattribute_desc}" />">
		<option value=""></option>		
		<c:forEach var="quantity" items="${pageScope.quantitiesByLanguage}" begin="0" varStatus="iter">
			<option value="<c:out value='${quantity.quantityUnitId}'/>" 		
			<c:if test="${pattribute_unitname eq quantity.description}">
			selected 
			</c:if>  
			>		
			<c:out value='${quantity.description}'/>
			</option>		
		</c:forEach>
	 </select>
	</c:otherwise>
	</c:choose>
	</td>
	
	<td headers="a5" class="t_td" id="WC_RFQModifySpecificationDisplay_TableCell_20">
    <label for="WC_RFQModifySpecificationDisplay_Select_8"></label>

	<select id="WC_RFQModifySpecificationDisplay_Select_8" class="select" name="mandatory_<c:out value="${param.index + 1 - count}" />" title="<fmt:message key="RFQModifySpecificationDisplay_Man" bundle="${storeText}" /> <c:out value="${pattribute_desc}" />">
	<c:choose>
		<c:when test="${pattribute_mandatory eq 'true'}">
			<option value="<c:out value="${EC_UTF_MANDATORY}" />" selected ><fmt:message key="RFQDisplay_Yes" bundle="${storeText}" />
			</option>
			<option value="<c:out value="${EC_UTF_OPTIONAL}" />" ><fmt:message key="RFQDisplay_No" bundle="${storeText}" />
			</option>			
		</c:when> 
		<c:when test="${pattribute_mandatory eq 'false' }">
			<option value="<c:out value="${EC_UTF_OPTIONAL}" />" selected ><fmt:message key="RFQDisplay_No" bundle="${storeText}" />
			</option>
			<option value="<c:out value="${EC_UTF_MANDATORY}" />" ><fmt:message key="RFQDisplay_Yes" bundle="${storeText}" />
			</option>
		</c:when>
	</c:choose> 

	</select>
    
	</td>

	<td headers="a6" class="t_td" id="WC_RFQModifySpecificationDisplay_TableCell_21">
    <label for="WC_RFQModifySpecificationDisplay_Select_9"></label>

	<select id="WC_RFQModifySpecificationDisplay_Select_9" class="select" name="changeable_<c:out value="${param.index + 1 - count}" />" title="<fmt:message key="RFQModifySpecificationDisplay_Change" bundle="${storeText}" /> <c:out value="${pattribute_desc}" />">
	<c:choose>
		<c:when test="${pattribute_changeable eq 'false' }" >
			<option value="<c:out value="${EC_UTF_NON_CHANGEABLE}" />" selected ><fmt:message key="RFQProductDisplay_No" bundle="${storeText}" />
			</option>
			<option value="<c:out value="${EC_UTF_CHANGEABLE}" />" ><fmt:message key="RFQProductDisplay_Yes" bundle="${storeText}" />
			</option>		
		</c:when>
		<c:when test="${pattribute_changeable eq 'true' }" >
			<option value="<c:out value="${EC_UTF_CHANGEABLE}" />" selected ><fmt:message key="RFQProductDisplay_Yes" bundle="${storeText}" />
			</option>
			<option value="<c:out value="${EC_UTF_NON_CHANGEABLE}" />" ><fmt:message key="RFQProductDisplay_No" bundle="${storeText}" />
			</option>			
		</c:when>
	</c:choose> 
	</select> 
    
	</td>		    
		
	<td headers="a7" class="t_td" id="WC_RFQModifySpecificationDisplay_TableCell_22"><a href="RFQItemSpecificationRemove?<c:out value="${EC_PATTRVALUE_ID}" />=<c:out value="${pAttrValueId}" />&<c:out value="${EC_OFFERING_ID}" />=<c:out value="${rfqId}" />&tc_id=<c:out value="${product.tc_id}" />&<c:out value="${EC_RFQ_PRODUCT_ID}" />=<c:out value="${rfqprodId}" />&langId=<c:out value="${langId}" />&storeId=<c:out value="${storeId}" />&catalogId=<c:out value="${catalogId}" />&URL=RFQModifySpecificationDisplay&<c:out value="${EC_OFFERING_CATENTRYID}" />=<c:out value="${catId}" />" class="t_button" id="WC_RFQModifySpecificationDisplay_Link_2"><fmt:message key="RFQModifySpecificationDisplay_Remove" bundle="${storeText}" /></a>
	</td>
	
	</c:otherwise> 
</c:choose>
	</tr>		
<c:set var="numSpec" value="${param.index + 1 - count}" scope="request" />
