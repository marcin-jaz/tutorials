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
  * This JSP page iterates through a list of Terms and Conditions for the RFQ.
  *
  * Required parameters:
  * - OrderCommentData [] commentsList
  * - index - int, index of current OrderCommentData object
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

<c:set var="commentsList" value="${commentsList}" scope="request" />
<c:set var="comment" value="${commentsList[param.index]}" />
<c:set var="tccomment" value="${comment.comment}" />
<c:set var="tcmandatory" value="${comment.mandatoryFlag}" />
<c:set var="tcchange" value="${comment.changeableFlag}" />
<c:set var="tcid" value="${comment.tcId}" />


  	<td headers="b1" class="t_td" id="WC_RFQModifyDisplay_TableCell_55_<c:out value="${param.index + 1}" />">
  	  	<input type="hidden" name="tc_id_<c:out value="${param.index + 1}" />" value="<c:out value="${tcid}" />" id="WC_RFQModifyDisplay_FormInput_<c:out value="${EC_ATTR_TCID}" />_<c:out value="${param.index + 1}" />_In_RFQModifyTCForm_1"/>        
        <label for="WC_RFQModifyDisplay_FormInput_<c:out value="${EC_ATTR_VALUE}" />_<c:out value="${param.index + 1}" />_In_RFQModifyTCForm_1"></label>
        <input type="text" class="input" name="<c:out value="${EC_ATTR_VALUE}" />_<c:out value="${param.index + 1}" />" title="<fmt:message key="RFQModifyDisplay_TC" bundle="${storeText}"/> <c:out value="${tccomment}" />" value="<c:out value="${tccomment}" />" size="50" maxlength="254" id="WC_RFQModifyDisplay_FormInput_<c:out value="${EC_ATTR_VALUE}" />_<c:out value="${param.index + 1}" />_In_RFQModifyTCForm_1"/>  	
  	
  	</td>
  	<td headers="b2" class="t_td" id="WC_RFQModifyDisplay_TableCell_56_<c:out value="${param.index + 1}" />">
  	<label for="WC_RFQModify_TCRow_Select_1"></label>
  	<select id="WC_RFQModify_TCRow_Select_1" class="select" name="mandatory_<c:out value="${param.index + 1}" />" title="<fmt:message key="RFQModifyDisplay_Man" bundle="${storeText}"/> <c:out value="${tccomment}" />">
  	   	
  	<c:choose>
  	<c:when test="${tcmandatory == 1}" >
  	  	<option value="1" selected ><fmt:message key="RFQModifyAddCommentDisplay_Yes" bundle="${storeText}"/></option>
  		<option value="0" ><fmt:message key="RFQModifyAddCommentDisplay_No" bundle="${storeText}"/></option> 	
  	
  	</c:when>
  	<c:otherwise>
  	  	<option value="1" ><fmt:message key="RFQModifyAddCommentDisplay_Yes" bundle="${storeText}"/></option>
  		<option value="0" selected ><fmt:message key="RFQModifyAddCommentDisplay_No" bundle="${storeText}"/></option> 	  	
  	
  	</c:otherwise>
  	</c:choose> 	 

	  </select> 	
  	 
  	 </td>
  	
	<td headers="b3" class="t_td" id="WC_RFQModifyDisplay_TableCell_57_<c:out value="${param.index + 1}" />_b3">
	
	  	<label for="WC_RFQModify_TCRow_Select_2"></label>
	  	<select id="WC_RFQModify_TCRow_Select_2" class="select" name="changeable_<c:out value="${param.index + 1}" />" title="<fmt:message key="RFQModifyAddTCDisplay_Change" bundle="${storeText}"/>">
 
				<c:choose>
				<c:when test="${tcchange == 1}" >
				 	<option value="1" selected ><fmt:message key="RFQDisplay_Yes" bundle="${storeText}"/></option>
  					<option value="0" ><fmt:message key="RFQDisplay_No" bundle="${storeText}"/></option>
					 
				</c:when>
				<c:otherwise>
				  	<option value="0" selected ><fmt:message key="RFQDisplay_No" bundle="${storeText}"/></option>
  					<option value="1" ><fmt:message key="RFQDisplay_Yes" bundle="${storeText}"/></option>					
				
					
				</c:otherwise> 
				</c:choose>	
	 
	 	</select> 
	
	</td>
	
	
	
	<td headers="b4" class="t_td" id="WC_RFQModifyDisplay_TableCell_57_<c:out value="${param.index + 1}" />_b4"><a href="RFQTCRemove?<c:out value="${EC_OFFERING_ID}" />=<c:out value="${rfqId}" />&amp;tc_id=<c:out value="${tcid}" />&amp;URL=RFQModifyDisplay?&amp;langId=<c:out value="${langId}" />&amp;storeId=<c:out value="${storeId}" />&amp;catalogId=<c:out value="${catalogId}" />" class="t_button" id="WC_RFQModifyDisplay_Link_7_<c:out value="${param.index + 1}" />"><fmt:message key="RFQModifyDisplay_Remove" bundle="${storeText}"/></a></td>
                                                 
                                            
	<c:set var="numTC" value="${param.index + 1}" scope="request" />                                         
