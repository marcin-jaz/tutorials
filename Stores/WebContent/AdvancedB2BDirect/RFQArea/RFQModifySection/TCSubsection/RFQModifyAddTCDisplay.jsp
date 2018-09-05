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
  * This JSP page displays fields to add a new Term and Condition to the RFQ.
  *
  * Required parameters:
  * - offering_id
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

<c:set var="catalogId" value="${param.catalogId}" />
<c:set var="rfqId" value="${param[EC_OFFERING_ID]}" />
<c:set var="strTC" value="" />
<c:set var="isRequired" value="${EC_UTF_MANDATORY}" />
<c:set var="isChangeable" value="${EC_UTF_CHANGEABLE}" />

<wcbase:useBean id="bnError" classname="com.ibm.commerce.beans.ErrorDataBean" scope="request">
</wcbase:useBean>

<c:if test="${bnError.exceptionType != null}">
	<c:set var="strErrorMessage" value="${bnError.message}" />	
	<c:choose>
	<c:when test="${bnError.messageKey eq '_ERR_CMD_INVALID_PARAM'}" >
		<c:set var="strMessageParams" value="${bnError.messageParam}" />		
		<c:set var="strTC" value="${param[EC_ATTR_VALUE]}" />
		<c:set var="isRequired" value="${param[EC_ATTR_MANDATORY]}" />
		<c:set var="isChangeable" value="${param[EC_ATTR_CHANGEABLE]}" />		
	</c:when> 
	<c:otherwise>
		<c:set var="strTC" value="" />
		<c:set var="isRequired" value="${EC_ATTR_MANDATORY}" />
		<c:set var="isChangeable" value="${EC_ATTR_CHANGEABLE}" />		
	</c:otherwise>
	</c:choose>
	
</c:if>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" lang="en">

<head>

<title><fmt:message key="RFQModifyAddTCDisplay_Title" bundle="${storeText}"/></title>
<link rel="stylesheet"	href="<c:out value="${jspStoreImgDir}${vfileStylesheet}"/>"	type="text/css" />
<meta name="GENERATOR" content="IBM WebSphere Studio"/>

<script language="javascript" src="<c:out value="${jspStoreImgDir}"/>javascript/Util.js">
</script>

<script language="javascript">
	function submitAdd(form)
	{
		if (form.value.value=='') {
			error("<fmt:message key="RFQModifyAddTCDisplay_Error1" bundle="${storeText}" />");
			return;
		}
  		else if (!isValidUTF8length(form.value.value, 254))
  		{
			error("<fmt:message key="msgInvalidSize254" bundle="${storeText}" />");
			return;
  		}
		form.submit()
	}
	function error(errMsg)
	{
		alert(errMsg);
	}

</script>

</head>

<body class="noMargin">
<%@ include file="../../../include/LayoutContainerTop.jspf"%>

<flow:ifEnabled feature="customerCare">
	<c:set var="liveHelpPageType" value="personal" />
</flow:ifEnabled>

<table border="0" cellpadding="0" cellspacing="0" width="790" height="99%" id="WC_RFQModifyAddTCDisplay_Table_1">

<tbody><tr>
	<td valign="top" width="630" id="WC_RFQModifyAddTCDisplay_TableCell_2">

		<!--MAIN CONTENT STARTS HERE-->

		<table cellpadding="8" border="0" id="WC_RFQModifyAddTCDisplay_Table_2">
		<tbody><tr>
			<td id="WC_RFQModifyAddTCDisplay_TableCell_3">
				<h1><fmt:message key="RFQModifyAddTCDisplay_AddTC" bundle="${storeText}"/></h1>
				
		<c:if test="${strErrorMessage != null}">
				<span class="warning"><c:out value="${strErrorMessage}"/></span><br /><br />
		</c:if>	
				
				<p><fmt:message key="RFQModifyAddTCDisplay_Desc" bundle="${storeText}"/> <fmt:message key="RFQ_TC_INSTRUCTION" bundle="${storeText}"/></p>

				<span class="reqd">*</span><fmt:message key="RFQModifyAddTCDisplay_Req" bundle="${storeText}"/>
				<p></p>

				<form name="addForm" action="RFQTCAdd" method="post" id="addForm">
				<input type="hidden" name="langId" value="<c:out value="${langId}"/>" id="WC_RFQModifyAddTCDisplay_FormInput_langId_In_addForm_1"/>
				<input type="hidden" name="storeId" value="<c:out value="${storeId}"/>" id="WC_RFQModifyAddTCDisplay_FormInput_storeId_In_addForm_1"/>
				<input type="hidden" name="catalogId" value="<c:out value="${catalogId}"/>" id="WC_RFQModifyAddTCDisplay_FormInput_catalogId_In_addForm_1"/>
				<input type="hidden" name="<c:out value="${EC_OFFERING_ID}"/>" value="<c:out value="${rfqId}"/>" id="WC_RFQModifyAddTCDisplay_FormInput_<c:out value="${EC_OFFERING_ID}"/>_In_addForm_1"/>
			<table border="0" id="WC_RFQModifyAddTCDisplay_Table_3">

			<tbody><tr>
				<td height="21" colspan="2" id="WC_RFQModifyAddTCDisplay_TableCell_4">
					<span class="reqd">*</span><label for="WC_RFQModifyAddTCDisplay_Textarea_1"><fmt:message key="RFQModifyAddTCDisplay_TC" bundle="${storeText}"/>
					</label></td>
			</tr>
 
			<tr>
				<td colspan="2" id="WC_RFQModifyAddTCDisplay_TableCell_5">
					<textarea id="WC_RFQModifyAddTCDisplay_Textarea_1" cols="40" rows="6" name="<c:out value="${EC_ATTR_VALUE}"/>"><c:out value="${strTC}"/></textarea>
			
				</td>
			</tr>

			<tr><td id="WC_RFQModifyAddTCDisplay_TableCell_6">&nbsp;</td></tr>

			<tr>
				<td height="21" colspan="2" id="WC_RFQModifyAddTCDisplay_TableCell_7">
					<fmt:message key="RFQModifyAddTCDisplay_isReq" bundle="${storeText}"/>					
				</td>
			</tr>
			<tr>
				<td width="20%" id="WC_RFQModifyAddTCDisplay_TableCell_8">
				
				<c:choose>
				<c:when test="${isRequired eq EC_UTF_MANDATORY}" >
					<c:set var="checked" value="checked" />
				</c:when>
				<c:otherwise>
					<c:set var="checked" value="" />
				</c:otherwise>
				</c:choose>
                    <label for="WC_RFQModifyAddTCDisplay_FormInput_<c:out value="${EC_ATTR_MANDATORY}"/>_In_addForm_1"></label>
					<input id="WC_RFQModifyAddTCDisplay_FormInput_<c:out value="${EC_ATTR_MANDATORY}"/>_In_addForm_1" size="53" type="radio" class="radio" name="<c:out value="${EC_ATTR_MANDATORY}"/>" value="<c:out value="${EC_UTF_MANDATORY}"/>" <c:out value="${checked}"/>="<c:out value="${checked}"/>" /> <fmt:message key="RFQModifyAddTCDisplay_Yes" bundle="${storeText}"/>
				
				</td>
				<td id="WC_RFQModifyAddTCDisplay_TableCell_9">
				
				<c:choose>
				<c:when test="${isRequired eq EC_UTF_OPTIONAL}" >
					<c:set var="checked" value="checked" />
				</c:when>
				<c:otherwise>
					<c:set var="checked" value="" />
				</c:otherwise>
				</c:choose>
                    <label for="WC_RFQModifyAddTCDisplay_FormInput_<c:out value="${EC_ATTR_MANDATORY}"/>_In_addForm_2"></label>
					<input id="WC_RFQModifyAddTCDisplay_FormInput_<c:out value="${EC_ATTR_MANDATORY}"/>_In_addForm_2" size="53" type="radio" class="radio" name="<c:out value="${EC_ATTR_MANDATORY}"/>" value="<c:out value="${EC_UTF_OPTIONAL}"/>" <c:out value="${checked}"/>="<c:out value="${checked}"/>" /> <fmt:message key="RFQModifyAddTCDisplay_No" bundle="${storeText}"/>
				
				</td>
			</tr>

			<tr><td id="WC_RFQModifyAddTCDisplay_TableCell_10">&nbsp;</td></tr>

			<tr>
				<td height="21" colspan="2" id="WC_RFQModifyAddTCDisplay_TableCell_11">
					<fmt:message key="RFQModifyAddTCDisplay_Change" bundle="${storeText}"/>					
				</td>
			</tr>
			<tr>
				<td width="20%" id="WC_RFQModifyAddTCDisplay_TableCell_12">
				
				<c:choose>
				<c:when test="${isChangeable eq EC_UTF_CHANGEABLE}" >
					<c:set var="checked" value="checked" />
				</c:when>
				<c:otherwise>
					<c:set var="checked" value="" /> 
				</c:otherwise>
				</c:choose>				
                    <label for="WC_RFQModifyAddTCDisplay_FormInput_<c:out value="${EC_ATTR_CHANGEABLE}"/>_In_addForm_3"></label>
					<input id="WC_RFQModifyAddTCDisplay_FormInput_<c:out value="${EC_ATTR_CHANGEABLE}"/>_In_addForm_3" size="53" type="radio" class="radio" name="<c:out value="${EC_ATTR_CHANGEABLE}"/>" value="<c:out value="${EC_UTF_CHANGEABLE}"/>" <c:out value="${checked}"/>="<c:out value="${checked}"/>" /> <fmt:message key="RFQModifyAddTCDisplay_Yes" bundle="${storeText}"/>
				
				</td>
				<td id="WC_RFQModifyAddTCDisplay_TableCell_13">
				 
				<c:choose>
				<c:when test="${isChangeable eq EC_UTF_NON_CHANGEABLE}" >
					<c:set var="checked" value="checked" />
				</c:when> 
				<c:otherwise>
					<c:set var="checked" value="" />
				</c:otherwise>
				</c:choose>	
                    <label for="WC_RFQModifyAddTCDisplay_FormInput_<c:out value="${EC_ATTR_CHANGEABLE}"/>_In_addForm_4"></label>
					<input id="WC_RFQModifyAddTCDisplay_FormInput_<c:out value="${EC_ATTR_CHANGEABLE}"/>_In_addForm_4" size="53" type="radio" class="radio" name="<c:out value="${EC_ATTR_CHANGEABLE}"/>" value="<c:out value="${EC_UTF_NON_CHANGEABLE}"/>" <c:out value="${checked}"/>="<c:out value="${checked}"/>" /> <fmt:message key="RFQModifyAddTCDisplay_No" bundle="${storeText}"/>
				
				</td>
			</tr>

			<tr>
				<td colspan="2" id="WC_RFQModifyAddTCDisplay_TableCell_14">
<table id="WC_RFQModifyAddTCDisplay_Table_4"><tbody><tr>

<!-- Start display for button "RFQModifyAddTCDisplay_Add" -->
<td height="41" id="WC_RFQModifyAddTCDisplay_TableCell_15">
<a class="button" href="javascript:submitAdd(document.addForm)" id="WC_RFQModifyAddTCDisplay_Link_1"> &nbsp; <fmt:message key="RFQModifyAddTCDisplay_Add" bundle="${storeText}"/> &nbsp;
</a>
</td>
<!-- End display for button ... -->

			<td id="WC_RFQModifyAddTCDisplay_TableCell_16">&nbsp;</td>

<!-- Start display for button "RFQModifyAddTCDisplay_Cancel" -->
<td height="41" id="WC_RFQModifyAddTCDisplay_TableCell_17">
<a class="button" href="RFQModifyDisplay?<c:out value="${EC_OFFERING_ID}"/>=<c:out value="${rfqId}"/>&langId=<c:out value="${langId}"/>&storeId=<c:out value="${storeId}"/>&catalogId=<c:out value="${catalogId}"/>" id="WC_RFQModifyAddTCDisplay_Link_2"> &nbsp; <fmt:message key="RFQModifyAddTCDisplay_Cancel" bundle="${storeText}"/> &nbsp;
</a>
</td>
<!-- End display for button ... -->

</tr></tbody></table>
				</td>
				<td id="WC_RFQModifyAddTCDisplay_TableCell_18">&nbsp;</td> 
				<td id="WC_RFQModifyAddTCDisplay_TableCell_19">&nbsp;</td>
			</tr>

			</tbody></table>
			<input type="hidden" name="URL" value="RFQModifyDisplay?<c:out value="${EC_ATTR_VALUE}"/>=" id="WC_RFQModifyAddTCDisplay_FormInput_URL_In_addForm_1"/>
			</form>
		</td>
		</tr>
		</tbody></table>

		<!--content end-->
	</td>
</tr>
</tbody></table>

<%@ include file="../../../include/LayoutContainerBottom.jspf"%>
</body>
</html>


