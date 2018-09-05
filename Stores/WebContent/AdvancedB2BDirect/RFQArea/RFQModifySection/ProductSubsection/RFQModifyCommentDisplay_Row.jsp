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
  * This JSP page iterates through RFQ product comments.
  *
  * Required parameters:
  * - pcomment
  * - index
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

<c:set var="pcomment" value="${requestScope.pcomment}" />
<c:set var="aComment" value="${pcomment[param.index]}" />
<c:set var="com_desc" value="${aComment.description}" />
<c:set var="com_value" value="${aComment.value}" />

<c:set var="pAttrValueId" value="${aComment.PAttrValueId}" />
<c:set var="pAttributeId" value="${aComment.pattribute_id}" />


<c:set var="com_mandatory" value="${aComment.mandatory}" />

<c:choose>
	<c:when test="${com_mandatory eq EC_UTF_MANDATORY}">
		<fmt:message key="RFQProductDisplay_Yes" bundle="${storeText}" var="mandatory" />
	</c:when>
	<c:when test="${com_mandatory eq EC_UTF_OPTIONAL}">
		<fmt:message key="RFQProductDisplay_No" bundle="${storeText}" var="mandatory" />
	</c:when>
</c:choose>

<c:set var="com_changeable" value="${aComment.changeable}" />
<c:choose>
	<c:when test="${com_changeable eq EC_UTF_NON_CHANGEABLE}">
		<fmt:message key="RFQProductDisplay_No" bundle="${storeText}" var="changeable" />
	</c:when>
	<c:when test="${com_changeable eq EC_UTF_CHANGEABLE}">
		<label for="WC_RFQModifyCommentDisplay_Select_1"><fmt:message key="RFQProductDisplay_Yes" bundle="${storeText}" var="changeable" />
	</label></c:when>
</c:choose>

		<wcbase:useBean id="rfqProduct" classname="com.ibm.commerce.utf.beans.RFQProdDataBean">
			<jsp:setProperty property="*" name="rfqProduct"/>			
		</wcbase:useBean>
		<c:set var="attributesList" value="${rfqProduct.allAttributes}"  scope="request" />

<td headers="a1" class="t_td" id="WC_RFQModifyCommentDisplay_TableCell_11_<c:out value="${param.index + 1}" />">
	<input type="hidden" name="<c:out value="${EC_PATTRVALUE_ID}" />_<c:out value="${param.index + 1}" />" value="<c:out value="${pAttrValueId}" />" id="WC_RFQModifyCommentDisplay_FormInput_<c:out value="${EC_PATTRVALUE_ID}" />_<c:out value="${param.index + 1}" />_In_RFQModifyCommentForm_1"/>
	<select id="WC_RFQModifyCommentDisplay_Select_1" class="select" name="<c:out value="${EC_ATTR_PATTRID}" />_<c:out value="${param.index + 1}" />">
 
	<c:forEach var="attribute" items="${attributesList}" begin="0" varStatus="iter">
		<c:choose>
		<c:when test="${attribute.attrTypeId eq EC_ATTRTYPE_FREEFORM}" >	
			<c:set var="specDesc" value="${attribute.name}" />
			<c:set var="specId" value="${attribute.referenceNumber}" />
			<c:set var="checked" value="" />
			<c:if test="${aComment.name eq attribute.name}" >
				<c:set var="checked" value="selected" />
			</c:if>
			
			<option value="<c:out value="${specId}" />" <c:out value="${checked}" />="<c:out value="${checked}" />"><c:out value="${specDesc}" /></option>
					
		</c:when>		
		<c:otherwise>						 
		</c:otherwise>
		</c:choose>	
		
	</c:forEach>
	<c:remove var="pAttDB" />
	</select>

</td>

<td headers="a2" class="t_td" id="WC_RFQModifyCommentDisplay_TableCell_12_<c:out value="${param.index + 1}" />"><label for="WC_RFQModifyCommentDisplay_Textarea_1"></label><textarea id="WC_RFQModifyCommentDisplay_Textarea_1" rows="1" name="<c:out value="${EC_ATTR_VALUE}" />_<c:out value="${param.index + 1}" />"><c:out value="${com_value}" /></textarea></td>

<td headers="a3" class="t_td" id="WC_RFQModifyCommentDisplay_TableCell_13_<c:out value="${param.index + 1}" />">
	<label for="WC_RFQModifyCommentDisplay_Select_2"></label>
	<select id="WC_RFQModifyCommentDisplay_Select_2" class="select" name="<c:out value="${EC_ATTR_MANDATORY}" />_<c:out value="${param.index + 1}" />">
	<c:choose>
		<c:when test="${com_mandatory}">
		<option value="<c:out value="${EC_UTF_MANDATORY}" />" selected ><fmt:message key="RFQModifyAddSpecificationDisplay_Yes" bundle="${storeText}" />
		</option>
		<option value="<c:out value="${EC_UTF_OPTIONAL}" />" ><fmt:message key="RFQModifyAddSpecificationDisplay_No" bundle="${storeText}" />
		</option>
		</c:when>
	<c:otherwise>
		<option value="<c:out value="${EC_UTF_MANDATORY}" />" ><fmt:message key="RFQModifyAddSpecificationDisplay_Yes" bundle="${storeText}" />
		</option> 
		<option value="<c:out value="${EC_UTF_OPTIONAL}" />" selected ><fmt:message key="RFQModifyAddSpecificationDisplay_No" bundle="${storeText}" />
		</option>
	</c:otherwise> 
	</c:choose>
	</select>

</td>

<td headers="a4" class="t_td" id="WC_RFQModifyCommentDisplay_TableCell_14_<c:out value="${param.index + 1}" />">
	<label for="WC_RFQModifyCommentDisplay_Select_3"></label>
	<select id="WC_RFQModifyCommentDisplay_Select_3" class="select" name="<c:out value="${EC_ATTR_CHANGEABLE}" />_<c:out value="${param.index + 1}" />">

	<c:choose>
		<c:when test="${com_changeable}">
		<option value="<c:out value="${EC_OFFERING_SUBST_YES}" />" selected ><fmt:message key="RFQModifyAddCommentDisplay_Yes" bundle="${storeText}" />
		</option>
		<option value="<c:out value="${EC_OFFERING_SUBST_NO}" />" ><fmt:message key="RFQModifyAddCommentDisplay_No" bundle="${storeText}" />
		</option>
		</c:when>
	<c:otherwise>
		<option value="<c:out value="${EC_OFFERING_SUBST_YES}" />" ><fmt:message key="RFQModifyAddCommentDisplay_Yes" bundle="${storeText}" />
		</option> 
		<option value="<c:out value="${EC_OFFERING_SUBST_NO}" />" selected ><fmt:message key="RFQModifyAddCommentDisplay_No" bundle="${storeText}" />
		</option>
	</c:otherwise> 
	</c:choose>
	</select>

</td>


<td headers="a5" class="t_td" id="WC_RFQModifyCommentDisplay_TableCell_15_<c:out value="${param.index + 1}" />"><a href="RFQItemCommentRemove?<c:out value="${EC_OFFERING_ID}" />=<c:out value="${rfqId}" />&<c:out value="${EC_RFQ_PRODUCT_ID}" />=<c:out value="${rfqprodId}" />&<c:out value="${EC_PATTRVALUE_ID}" />=<c:out value="${pAttrValueId}" />&langId=<c:out value="${langId}" />&storeId=<c:out value="${storeId}" />&catalogId=<c:out value="${catalogId}" />&URL=RFQModifyCommentDisplay" class="t_button" id="WC_RFQModifyCommentDisplay_Link_1_<c:out value="${param.index + 1}" />"><fmt:message key="RFQModifySpecificationDisplay_Remove" bundle="${storeText}" /></a></td>

<c:choose>
	<c:when test="${param.index == 0}" >
		<c:set var="parmList" value="${EC_ATTR_VALUE}_${param.index + 1}=" scope="request" />
	</c:when>
	<c:otherwise>
		<c:set var="parmList" value="${parmList}&${EC_ATTR_VALUE}_${param.index + 1}=" scope="request" />
	</c:otherwise>
</c:choose>
 

<c:set var="numComment" value="${param.index + 1}" scope="request" />	
