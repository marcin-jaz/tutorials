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
  * This JSP page iterates through a list of draft RFQs.
  *
  * Imports:
  * - CommonSection/RFQSetup.jsp
  * - AddToExistRFQListDisplay_Setup.jsp
  *
  * Required parameters:
  * - index - int
  * - categoryId
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
<% out.flush(); %>
<c:import url="../CommonSection/RFQSetup.jsp" />
<% out.flush(); %>
<% out.flush(); %>
<c:import url="AddToExistRFQListDisplay_Setup.jsp" />
<% out.flush(); %>

<c:set var="rfq_name" value="${rfqBean.name}" />
<c:set var="endresult" value="${rfqBean.endResultInEJBType}"  />
<c:choose>
	<c:when test="${pageScope.lang <= -7 and pageScope.lang >= -10}">
		<c:set var="wrap" value="nowrap" scope="request" />
	</c:when>
	<c:otherwise>
		<c:set var="wrap" value="" scope="request" />
	</c:otherwise>
</c:choose> 
 
<c:choose>

<c:when test="${WCParam.isContract == null or WCParam.isContract == 'false'}" >
	<c:set var="isContract" value="false" scope="request" />
</c:when>
<c:otherwise>
	<c:set var="isContract" value="true" scope="request" />
</c:otherwise>
</c:choose>
<c:set var="isContract" value="${requestScope.isContract}" scope="request" />
<label for="a8"></label>
<c:choose>
<c:when test="${isContract == 'true' or isContract == 'Y' or isContract == true }" >	
	<c:if test="${endresult == '0'}" >
	
	 <c:set var="count" value="${requestScope.count+1}" scope="request" />
	 <c:set var="countContract" value="${requestScope.countContract+1}" scope="request" />
	
 		<tr>	
			<td headers="a1" <c:out value="${wrap}='{wrap}'" /> class="<c:out value="${param.color}" /> t_td" id="WC_AddToExistRFQListDisplay_TableCell_16_<c:out value="${count}" />">
			<label for="a20"></label>
				<input type="radio" name="<c:out value="${EC_OFFERING_ID}" />" value="<c:out value="${rfqBean.rfqId}" />" 
				<c:if test="${param.index == 0}" >				
					checked="checked" 				 
				</c:if> 
				onclick="document.RFQListForm.offering_id.value=<c:out value="${rfqBean.rfqId}" />" id="a20"/>
			</td>			 
			
			<td headers="a2" <c:out value="${wrap}='{wrap}'" /> class="<c:out value="${param.color}" /> t_td" id="WC_AddToExistRFQListDisplay_TableCell_17_<c:out value="${count}" />"><c:out value="${rfq_name}" /></td>
			<td headers="a3" <c:out value="${wrap}='{wrap}'" /> class="<c:out value="${param.color}" /> t_td" id="WC_AddToExistRFQListDisplay_TableCell_18_<c:out value="${count}" />"><c:out value="${rfqBean.description.shortDescription}" />&nbsp;</td>
			<td headers="a4" <c:out value="${wrap}='{wrap}'" /> class="<c:out value="${param.color}" /> t_td" id="WC_AddToExistRFQListDisplay_TableCell_19_<c:out value="${count}" />"><c:out value="${rfq_create_date}" />&nbsp;</td>
			<td headers="a5" <c:out value="${wrap}='{wrap}'" /> class="<c:out value="${param.color}" /> t_td" id="WC_AddToExistRFQListDisplay_TableCell_20_<c:out value="${count}" />"><c:out value="${rfq_activate_date}" />&nbsp;</td>
			<td headers="a6" <c:out value="${wrap}='{wrap}'" /> class="<c:out value="${param.color}" /> t_td" id="WC_AddToExistRFQListDisplay_TableCell_21_<c:out value="${count}" />"><c:out value="${rfq_round}" /></td>
			
			<c:choose>										
			<c:when test="${attachments}" >
				<td headers="a7" <c:out value="${wrap}='{wrap}'" /> class="<c:out value="${param.color}" /> t_td" id="WC_AddToExistRFQListDisplay_TableCell_22_<c:out value="${count}" />"><fmt:message key="AddToExistRFQList_Yes" bundle="${storeText}" />
				</td>
			</c:when>
			<c:otherwise> 
			
				<td headers="a7" <c:out value="${wrap}='{wrap}'" /> class="<c:out value="${param.color}" /> t_td" id="WC_AddToExistRFQListDisplay_TableCell_23_<c:out value="${count}" />"><fmt:message key="AddToExistRFQList_No" bundle="${storeText}" />
				</td>
			</c:otherwise>	
			</c:choose>

		    <c:if test="${empty addCategoryId}" >			
			<td headers="a8" <c:out value="${wrap}='{wrap}'" /> class="<c:out value="${param.color}" /> t_td" id="WC_AddToExistRFQListDisplay_TableCell_24_<c:out value="${count}" />">
				<select class="select" id="a8" title='<fmt:message key="RFQDisplay_Product_Category" bundle="${storeText}" /> <c:out value="${rfq_name}" />' onchange="updateRadioButton(<c:out value="${count}" />, this.options[this.selectedIndex].value, <c:out value="${rfqBean.rfqId}" />)">
					<option value="" selected="selected">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</option>
			
					<c:forEach var="category" items="${categoryList}" begin="0" varStatus="iter">
						<c:set var="rfqCategoryId" value="${category.rfqCategryIdInEJBType}" />		
						<option value="<c:out value="${rfqCategoryId}" />"><c:out value="${category.name}" /> </option>
					</c:forEach>				
				</select>
			</td>
            
			<td headers="a9" <c:out value="${wrap}='{wrap}'" /> class="<c:out value="${param.color}" /> t_td" id="WC_AddToExistRFQListDisplay_TableCell_25_<c:out value="${count}" />">
				<strong><a href="RFQAddNewCategoryDisplay?<c:out value="${EC_OFFERING_ID}" />=<c:out value="${rfqBean.rfqId}" />&amp;catalogId=<c:out value="${catalogId}" />&amp;isContract=<c:out value="${isContract}" />&amp;URL=AddToExistRFQListDisplay%3FcatalogId%3D<c:out value="${catalogId}" />%26<c:out value="${EC_OFFERING_CATENTRYID}" />%3D<c:out value="${catid}" />%26orderId%3D<c:out value="${requestScope.orderId}" />" id="WC_AddToExistRFQListDisplay_Link_1_<c:out value="${count}" />">
				<fmt:message key="RFQModifyDisplay_AddNewCategory" bundle="${storeText}" />				
				</a></strong>
			</td>
		    </c:if>
  	
	 		</tr>
		</c:if>
	<c:set var="counter" value="${count}" scope="request" />
</c:when>
<c:otherwise>

	<tr>
			<td headers="a1" <c:out value="${wrap}='{wrap}'" /> class="<c:out value="${param.color}" /> t_td" id="WC_AddToExistRFQListDisplay_TableCell_16_<c:out value="${param.index + 1}" />">
				<label for="a21"></label>
				<input type="radio" name="offering_id" value="<c:out value="${rfqBean.rfqId}" />" 
				<c:if test="${param.index  == 0}" >				
					checked="checked" 				 
				</c:if>
				onclick="document.RFQListForm.offering_id.value=<c:out value="${rfqBean.rfqId}" />" id="a21"/>
			</td>			
			
			<td headers="a2" <c:out value="${wrap}='{wrap}'" /> class="<c:out value="${param.color}" /> t_td" id="WC_AddToExistRFQListDisplay_TableCell_17_<c:out value="${param.index + 1}" />"><c:out value="${rfq_name}" /></td>
			<td headers="a3" <c:out value="${wrap}='{wrap}'" /> class="<c:out value="${param.color}" /> t_td" id="WC_AddToExistRFQListDisplay_TableCell_18_<c:out value="${param.index + 1}" />"><c:out value="${rfqBean.description.shortDescription}" />&nbsp;</td>
			<td headers="a4" <c:out value="${wrap}='{wrap}'" /> class="<c:out value="${param.color}" /> t_td" id="WC_AddToExistRFQListDisplay_TableCell_19_<c:out value="${param.index + 1}" />"><c:out value="${rfq_create_date}" />&nbsp;</td>
			<td headers="a5" <c:out value="${wrap}='{wrap}'" /> class="<c:out value="${param.color}" /> t_td" id="WC_AddToExistRFQListDisplay_TableCell_20_<c:out value="${param.index + 1}" />"><c:out value="${rfq_activate_date}" />&nbsp;</td>
			<td headers="a6" <c:out value="${wrap}='{wrap}'" /> class="<c:out value="${param.color}" /> t_td" id="WC_AddToExistRFQListDisplay_TableCell_21_<c:out value="${param.index + 1}" />"><c:out value="${rfq_round}" /></td>
			
			<c:choose>										
			<c:when test="${attachments}" >
				<td headers="a7" <c:out value="${wrap}='{wrap}'" /> class="<c:out value="${param.color}" /> t_td" id="WC_AddToExistRFQListDisplay_TableCell_22_<c:out value="${param.index + 1}" />"><fmt:message key="AddToExistRFQList_Yes" bundle="${storeText}" />
				</td> 
			</c:when>
			<c:otherwise>
			
				<td headers="a7" <c:out value="${wrap}='{wrap}'" /> class="<c:out value="${param.color}" /> t_td" id="WC_AddToExistRFQListDisplay_TableCell_23_<c:out value="${param.index + 1}" />"><fmt:message key="AddToExistRFQList_No" bundle="${storeText}" />
				</td>
			</c:otherwise>	
			</c:choose>

		    <c:if test="${empty addCategoryId}" >	
			<td headers="a8" <c:out value="${wrap}='{wrap}'" /> class="<c:out value="${param.color}" /> t_td" id="WC_AddToExistRFQListDisplay_TableCell_24_<c:out value="${param.index + 1}" />">
				<select class="select" id="a8" title='<fmt:message key="RFQDisplay_Product_Category" bundle="${storeText}" /> <c:out value="${rfq_name}" />' onchange="updateRadioButton(<c:out value="${param.index + 1}" />, this.options[this.selectedIndex].value, <c:out value="${rfqBean.rfqId}" /> )">
					<option value="" selected="selected">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</option>
			 
					<c:forEach var="category" items="${categoryList}" begin="0" varStatus="iter">
						<c:set var="rfqCategoryId" value="${category.rfqCategryIdInEJBType}" />		
						<option value="<c:out value="${rfqCategoryId}" />"><c:out value="${category.name}" /> </option>
					</c:forEach>				
				</select>
			</td>
            
			<td headers="a9" <c:out value="${wrap}='{wrap}'" /> class="<c:out value="${param.color}" /> t_td" id="WC_AddToExistRFQListDisplay_TableCell_25_<c:out value="${param.index + 1}" />">
				<strong><a href="RFQAddNewCategoryDisplay?<c:out value="${EC_OFFERING_ID}" />=<c:out value="${rfqBean.rfqId}" />&amp;catalogId=<c:out value="${catalogId}" />&amp;isContract=<c:out value="${isContract}" />&amp;URL=AddToExistRFQListDisplay%3FcatalogId%3D<c:out value="${catalogId}" />%26<c:out value="${EC_OFFERING_CATENTRYID}" />%3D<c:out value="${requestScope.catid}" />%26orderId%3D<c:out value="${requestScope.orderId}" />" id="WC_AddToExistRFQListDisplay_Link_1_<c:out value="${param.index + 1}" />">
				<fmt:message key="RFQModifyDisplay_AddNewCategory" bundle="${storeText}" />				
				</a></strong>
			</td>  	 
		    </c:if>
		    	
			</tr>
			<c:set var="counter" value="${param.index + 1}" scope="request" />
			
</c:otherwise>

</c:choose>


