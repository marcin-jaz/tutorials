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
  * This JSP page displays fields for adding a made-to-order product to the RFQ.
  *
  * Elements:  
  * - Create button
  * - Cancel button
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
<c:set var="rfqId" value="${param[EC_OFFERING_ID]}" scope="request" />
<c:set var="strComment" value="" />
<c:set var="isRequired" value="${EC_UTF_MANDATORY}" />
<c:set var="isChangeable" value="${EC_UTF_CHANGEABLE}" />

<wcbase:useBean id="bnError" classname="com.ibm.commerce.beans.ErrorDataBean" scope="request">
</wcbase:useBean>
<c:if test="${bnError.exceptionType != null}">
	<c:set var="strErrorMessage" value="${bnError.message}" />
</c:if>



<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="en">
 
<head>

<title><fmt:message key="RFQMadeToOrderDisplay_Title" bundle="${storeText}" /></title>
<link rel="stylesheet"	href="<c:out value="${jspStoreImgDir}${vfileStylesheet}"/>"	type="text/css" />

<script language="javascript">
	function submitCreate(form) {
		if (form.<c:out value="${EC_RFQ_PRODUCT_NAME}" />.value=='') {			
			error("<fmt:message key="RFQMadeToOrderDisplay_Error2" bundle="${storeText}" />");
			return;
		}
		form.submit()
	}
	function error(errMsg) {
		alert(errMsg);
	}

</script>

</head>

<body class="noMargin">
<%@ include file="../../../include/LayoutContainerTop.jspf"%>

<flow:ifEnabled feature="customerCare">
	<c:set var="liveHelpPageType" value="personal" />  
</flow:ifEnabled>

<table border="0" cellpadding="0" cellspacing="0" width="790" height="99%" id="WC_RFQMadeToOrderDisplay_Table_1">
<tbody><tr>
	<td valign="top" width="630" id="WC_RFQMadeToOrderDisplay_TableCell_2">

		<!--MAIN CONTENT STARTS HERE-->

		<table cellpadding="8" border="0" id="WC_RFQMadeToOrderDisplay_Table_2">
		<tbody><tr>
			<td id="WC_RFQMadeToOrderDisplay_TableCell_3">
				<h1><fmt:message key="RFQMadeToOrderDisplay_Desc" bundle="${storeText}" /></h1>

<c:if test="${strErrorMessage != null}">
				<p><span class="warning"><c:out value="${strErrorMessage}"/></span><br /><br /></p>
</c:if>
			
				<fmt:message key="RFQExtra_MadeToOrder" bundle="${storeText}" />
				<fmt:message key="RFQExtra_MadeToOrder_Inst" bundle="${storeText}" />
				<br /><br />
				<span class="reqd">*</span><fmt:message key="RFQModifyAddCommentDisplay_Req" bundle="${storeText}" />
				<p></p>

			<form name="addForm" action="RFQItemAdd" method="get" id="addForm">
			<input type="hidden" name="storeId" value="<c:out value="${storeId}"/>" id="WC_RFQMadeToOrderDisplay_FormInput_storeId_In_addForm_1"/>
			<input type="hidden" name="langId" value="<c:out value="${langId}"/>" id="WC_RFQMadeToOrderDisplay_FormInput_langId_In_addForm_1"/>
			<input type="hidden" name="catalogId" value="<c:out value="${catalogId}"/>" id="WC_RFQMadeToOrderDisplay_FormInput_catalogId_In_addForm_1"/>
			<input type="hidden" name="<c:out value="${EC_OFFERING_CATENTRYID}"/>" value="madeToOrder" id="WC_RFQMadeToOrderDisplay_FormInput_<c:out value="${EC_OFFERING_CATENTRYID}"/>_In_addForm_1"/>
			<input type="hidden" name="<c:out value="${EC_OFFERING_ID}"/>" value="<c:out value="${rfqId}"/>" id="WC_RFQMadeToOrderDisplay_FormInput_<c:out value="${EC_OFFERING_ID}"/>_In_addForm_1"/>

			<c:set var="defaultCurrency" value="${sdb.storeDefaultCurrency}" scope="page" />
			
			<input type="hidden" name="<c:out value="${EC_OFFERING_CURRENCY}"/>" value="<c:out value="${defaultCurrency}"/>" id="WC_RFQMadeToOrderDisplay_FormInput_<c:out value="${EC_OFFERING_CURRENCY}"/>_In_addForm_1"/>




			<table border="0" id="WC_RFQMadeToOrderDisplay_Table_3">
 
			<tbody><tr>
				<td height="21" id="WC_RFQMadeToOrderDisplay_TableCell_4">
					<label for="WC_RFQMadeToOrderDisplay_FormInput_<c:out value="${EC_RFQ_PRODUCT_NAME}"/>_In_addForm_1"><fmt:message key="RFQMadeToOrderDisplay_Name" bundle="${storeText}" />
				</label></td>
				<td id="WC_RFQMadeToOrderDisplay_TableCell_5">
					<input class="input" type="text" name="<c:out value="${EC_RFQ_PRODUCT_NAME}"/>" id="WC_RFQMadeToOrderDisplay_FormInput_<c:out value="${EC_RFQ_PRODUCT_NAME}"/>_In_addForm_1"/>
				</td>
			
			</tr>

			<tr>
				<td colspan="4" id="WC_RFQMadeToOrderDisplay_TableCell_6">
<table id="WC_RFQMadeToOrderDisplay_Table_4"><tbody><tr>

<!-- Start display for button "RFQMadeToOrderDisplay_Create" -->
<td height="41" id="WC_RFQMadeToOrderDisplay_TableCell_7">
<a class="button" href="javascript:submitCreate(document.addForm);" id="WC_RFQMadeToOrderDisplay_Link_1">&nbsp;<fmt:message key="RFQMadeToOrderDisplay_Create" bundle="${storeText}" />&nbsp;
</a>
</td>
<!-- End display for button ... -->

			<td id="WC_RFQMadeToOrderDisplay_TableCell_8">&nbsp;</td>

<!-- Start display for button "RFQMadeToOrderDisplay_Cancel" -->
<td height="41" id="WC_RFQMadeToOrderDisplay_TableCell_9">
<a class="button" href="RFQModifyDisplay?<c:out value="${EC_OFFERING_ID}"/>=<c:out value="${rfqId}"/>&amp;langId=<c:out value="${langId}"/>&amp;storeId=<c:out value="${storeId}"/>&amp;catalogId=<c:out value="${catalogId}"/>" id="WC_RFQMadeToOrderDisplay_Link_2">&nbsp;<fmt:message key="RFQMadeToOrderDisplay_Cancel" bundle="${storeText}" />&nbsp;
</a>
</td>
<!-- End display for button ... -->

</tr></tbody></table>
				</td>
				<td id="WC_RFQMadeToOrderDisplay_TableCell_10">&nbsp;</td>
				<td id="WC_RFQMadeToOrderDisplay_TableCell_11">&nbsp;</td>
			</tr>

			</tbody>
			</table>
		<input type="hidden" name="URL" value="RFQModifyDisplay" id="WC_RFQMadeToOrderDisplay_FormInput_URL_In_addForm_1"/>
		</form>
			
		</td>
		</tr>
		<tr><td id="WC_RFQMadeToOrderDisplay_TableCell_13">&nbsp;</td></tr>
		</tbody>
		</table>

		<!--content end-->
	</td>
</tr>
</tbody>
</table>

<%@ include file="../../../include/LayoutContainerBottom.jspf"%>
</body>
</html>


