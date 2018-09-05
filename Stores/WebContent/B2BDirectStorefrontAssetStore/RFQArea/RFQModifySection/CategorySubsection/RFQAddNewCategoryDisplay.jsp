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
  * This JSP page displays an input field to add a new category to the RFQ.
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

<c:set var="catalogId" value="${WCParam.catalogId}" />
<c:set var="rfqId" value="${WCParam.offering_id}" scope="request" />
<c:set var="URL" value="${WCParam.URL}" scope="request" />
<c:set var="isContract" value="${WCParam.isContract}" scope="request" />  

<wcbase:useBean id="bnError" classname="com.ibm.commerce.beans.ErrorDataBean" scope="request">
</wcbase:useBean>
<c:if test="${bnError.exceptionType != null}">
	<c:set var="strErrorMessage" value="${bnError.message}" />
</c:if>

<c:if test="${bnError.exceptionType != null}">
	<c:set var="strErrorMessage" value="${bnError.message}" />	
</c:if>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="en">

<head>

<title><fmt:message key="RFQCreateCategoryDisplay_Title" bundle="${storeText}" />
</title>
<link rel="stylesheet"
	href="<c:out value="${jspStoreImgDir}${vfileStylesheet}"/>"
	type="text/css" />
<script language="javascript">
	function sumbitAddCategory(form) {
		if (form.categoryName.value=='') {
			error("<fmt:message key="RFQCreateCategoryDisplay_Error2" bundle="${storeText}" />");
			return;
		}		
		form.submit();
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

<table border="0" cellpadding="0" cellspacing="0" width="790" height="99%" id="WC_RFQAddNewCategoryDisplay_Table_1">
<tr>
	<td valign="top" width="630" id="WC_RFQAddNewCategoryDisplay_TableCell_2">

		<!--MAIN CONTENT STARTS HERE-->

		<table cellpadding="8" border="0" id="WC_RFQAddNewCategoryDisplay_Table_2">
		<tr>
			<td id="WC_RFQAddNewCategoryDisplay_TableCell_3">
			<h1><fmt:message key="RFQCreateCategoryDisplay_Title" bundle="${storeText}" /></h1>
			
			<c:if test="${strErrorMessage != null}">
				<p><span class="warning"><c:out value="${strErrorMessage}"/></span><br /><br /></p>
			</c:if>	

			<span class="reqd">*</span><fmt:message key="RFQModifyAddCommentDisplay_Req" bundle="${storeText}" />
			<p>

			<form name="addForm" action="RFQCategoryAdd" method="post" id="addForm">
			<input type="hidden" name="<c:out value="${EC_OFFERING_ID}" />" value="<c:out value="${rfqId}" />" id="WC_RFQAddNewCategoryDisplay_FormInput_<c:out value="${EC_OFFERING_ID}" />_In_addForm_1"/>
			<input type="hidden" name="langId" value="<c:out value="${langId}" />" id="WC_RFQAddNewCategoryDisplay_FormInput_langId_In_addForm_1"/>
			<input type="hidden" name="storeId" value="<c:out value="${storeId}" />" id="WC_RFQAddNewCategoryDisplay_FormInput_storeId_In_addForm_1"/>
			<input type="hidden" name="catalogId" value="<c:out value="${catalogId}" />" id="WC_RFQAddNewCategoryDisplay_FormInput_catalogId_In_addForm_1"/>
			<input type="hidden" name="isContract" value="<c:out value="${isContract}" />" id="WC_RFQAddNewCategoryDisplay_FormInput_isContract_In_addForm_1"/>

			<table border="0" id="WC_RFQAddNewCategoryDisplay_Table_3">

			<tr>
				<td height="21" id="WC_RFQAddNewCategoryDisplay_TableCell_4">
					<span class="reqd">*</span><label for="WC_RFQAddNewCategoryDisplay_FormInput_<c:out value="${EC_RFQ_CATEGORY_NAME}" />_In_addForm_1"><fmt:message key="RFQCreateCategoryDisplay_Name" bundle="${storeText}" />
				</label></td>
				<td id="WC_RFQAddNewCategoryDisplay_TableCell_5">
				<input type="text" class="input" name="<c:out value="${EC_RFQ_CATEGORY_NAME}" />" id="WC_RFQAddNewCategoryDisplay_FormInput_<c:out value="${EC_RFQ_CATEGORY_NAME}" />_In_addForm_1"/>
				</td> 

			</tr>

			<tr>
				<td colspan="4" id="WC_RFQAddNewCategoryDisplay_TableCell_6">
				<table id="WC_RFQAddNewCategoryDisplay_Table_4"><tr>

<!-- Start display for button "RFQMadeToOrderDisplay_Create" -->
<td height="41" id="WC_RFQAddNewCategoryDisplay_TableCell_7">
<a class="button" href="javascript:sumbitAddCategory(document.addForm);" id="WC_RFQAddNewCategoryDisplay_Link_1"> &nbsp; <fmt:message key="RFQMadeToOrderDisplay_Create" bundle="${storeText}" /> &nbsp;
</a>
</td>
<!-- End display for button ... -->

				<td id="WC_RFQAddNewCategoryDisplay_TableCell_8">&nbsp;</td>

<!-- Start display for button "RFQMadeToOrderDisplay_Cancel" -->
<td height="41" id="WC_RFQAddNewCategoryDisplay_TableCell_9">
<a class="button" href="RFQModifyDisplay?<c:out value="${EC_OFFERING_ID}" />=<c:out value="${rfqId}" />&langId=<c:out value="${langId}" />&storeId=<c:out value="${storeId}" />&catalogId=<c:out value="${catalogId}" />" id="WC_RFQAddNewCategoryDisplay_Link_2">&nbsp;<fmt:message key="RFQMadeToOrderDisplay_Cancel" bundle="${storeText}" />&nbsp;
</a>
</td>
<!-- End display for button ... -->

				</tr></table>
				</td>
				<td id="WC_RFQAddNewCategoryDisplay_TableCell_10">&nbsp;</td>
				<td id="WC_RFQAddNewCategoryDisplay_TableCell_11">&nbsp;</td>
			</tr>

			</table>
			<input type="hidden" name="URL" value="<c:out value="${URL}" />" id="WC_RFQAddNewCategoryDisplay_FormInput_URL_In_addForm_1"/>
		</form>
		
		</td>
		</tr>
		</table>

		<!--content end-->
	</td>
</tr>
</table> 

<%@ include file="../../../include/LayoutContainerBottom.jspf"%>
</body>
</html>

