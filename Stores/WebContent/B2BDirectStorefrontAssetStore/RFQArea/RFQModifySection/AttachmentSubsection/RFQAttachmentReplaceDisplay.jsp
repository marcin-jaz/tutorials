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
  * This JSP page displays input fields to replace one attachment with
  * another attachment.
  *
  * Elements:  
  * - Upload button
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
<c:set var="rfqId" value="${WCParam[EC_OFFERING_ID]}" scope="request" />
<c:set var="attachmentId" value="${WCParam[EC_ATTACH_ID]}" scope="request" />

<wcbase:useBean id="bnError" classname="com.ibm.commerce.beans.ErrorDataBean" scope="request">
</wcbase:useBean>
<c:if test="${bnError.exceptionType != null}">
	<c:set var="strErrorMessage" value="${bnError.message}" />
</c:if>

<c:if test="${bnError.exceptionType != null}">
	<c:set var="strErrorMessage" value="${bnError.message}" />
	<c:set var="filename" value="${WCParam[EC_ATTACH_FILENAME]}" />
	<c:set var="filedesc" value="${WCParam[EC_ATTACH_DESC]}" />
</c:if>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" lang="en"><head> 

<title><fmt:message key="RFQAttachmentReplaceDisplay_Title" bundle="${storeText}" /></title>
<link rel="stylesheet"	href="<c:out value="${jspStoreImgDir}${vfileStylesheet}"/>"	type="text/css" />
<meta name="GENERATOR" content="IBM WebSphere Studio"/>

<script language="javascript">
	function submitAttach(form)
	{
		if (form.attachDesc.value=='') {
			error("<fmt:message key="RFQAttachmentReplaceDisplay_Error2" bundle="${storeText}" />");
			return;
		}
		if (form.filename.value=='') {
			error("<fmt:message key="RFQAttachmentReplaceDisplay_Error1" bundle="${storeText}" />");
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


<table border="0" cellpadding="0" cellspacing="0" width="790" height="99%" id="WC_RFQAttachmentReplaceDisplay_Table_1">
<tbody><tr>
	<td valign="top" width="630" id="WC_RFQAttachmentReplaceDisplay_TableCell_2">

		<!--MAIN CONTENT STARTS HERE-->

		<table cellpadding="8" border="0" id="WC_RFQAttachmentReplaceDisplay_Table_2">
		<tbody><tr>
			<td id="WC_RFQAttachmentReplaceDisplay_TableCell_3">
				<h1>
				<fmt:message key="RFQAttachmentReplaceDisplay_AddAttachment" bundle="${storeText}" />
				</h1>
				
		<c:if test="${strErrorMessage != null}">
				<span class="warning"><c:out value="${strErrorMessage}"/></span><br /><br />
		</c:if>					
				

<wcbase:useBean id="attachment" classname="com.ibm.commerce.contract.beans.AttachmentDataBean">
<jsp:setProperty property="*" name="attachment"/>
<c:set property="dataBeanKeyAttachmentId" value="${attachmentId}" target="${attachment}" /> 
</wcbase:useBean>


<c:set var="filenameAtt" value="${attachment.filename}"  />
<c:set var="filedescAtt" value="${attachment.description}"  />				
				<p>
				<fmt:message key="RFQAttachmentReplaceDisplay_Filename" bundle="${storeText}" />
				: <i><c:out value="${filenameAtt}" /></i></p>

				<p><fmt:message key="RFQAttachmentReplaceDisplay_Desc" bundle="${storeText}" />: <i><c:out value="${filedescAtt}" /></i></p><br />
				<p><fmt:message key="RFQAttachmentReplaceDisplay_Title" bundle="${storeText}" /></p>

				<p><span class="reqd">*</span><fmt:message key="RFQAttachmentReplaceDisplay_Required" bundle="${storeText}" /></p>

				<form name="attachmentReplaceForm" action="RFQAttachmentReplace" enctype="multipart/form-data" method="post" id="attachmentReplaceForm"/>
				<input type="hidden" name="refcmd" value="RFQAttachmentUploadCmd" id="WC_RFQAttachmentReplaceDisplay_FormInput_refcmd_In_attachmentReplaceForm_1"/>
				<input type="hidden" name="orderBy" value="size" id="WC_RFQAttachmentReplaceDisplay_FormInput_orderBy_In_attachmentReplaceForm_1"/>
				<input type="hidden" name="XMLFile" value="contract.ContractImportPanel" id="WC_RFQAttachmentReplaceDisplay_FormInput_XMLFile_In_attachmentReplaceForm_1"/>
				<input type="hidden" name="<c:out value="${EC_OFFERING_ID}" />" value="<c:out value="${rfqId}" />" id="WC_RFQAttachmentReplaceDisplay_FormInput_<c:out value="${EC_OFFERING_ID}" />_In_attachmentReplaceForm_1"/>
				<input type="hidden" name="storeId" value="<c:out value="${storeId}" />" id="WC_RFQAttachmentReplaceDisplay_FormInput_storeId_In_attachmentReplaceForm_1"/>
				<input type="hidden" name="langId" value="<c:out value="${langId}" />" id="WC_RFQAttachmentReplaceDisplay_FormInput_langId_In_attachmentReplaceForm_1"/>
				<input type="hidden" name="catalogId" value="<c:out value="${catalogId}" />" id="WC_RFQAttachmentReplaceDisplay_FormInput_catalogId_In_attachmentReplaceForm_1"/>
				<input type="hidden" name="<c:out value="${EC_ATTACH_ID}" />" value="<c:out value="${attachmentId}" />" id="WC_RFQAttachmentReplaceDisplay_FormInput_<c:out value="${EC_ATTACH_ID}" />_In_attachmentReplaceForm_1"/>
				<input type="hidden" name="URL" value="RFQModifyDisplay" id="WC_RFQAttachmentReplaceDisplay_FormInput_URL_In_attachmentReplaceForm_1"/>
 
			<table border="0" id="WC_RFQAttachmentReplaceDisplay_Table_3">
			<tbody><tr>
				<td height="21" colspan="2" id="WC_RFQAttachmentReplaceDisplay_TableCell_4">
					<span class="reqd">*</span>
					<label for="WC_RFQAttachmentReplaceDisplay_FormInput_<c:out value="${EC_ATTACH_DESC}" />_In_attachmentReplaceForm_1">
					<fmt:message key="RFQAttachmentReplaceDisplay_Desc" bundle="${storeText}" />					
					</label>
				</td>
			</tr>
			<tr>
				<td colspan="2" id="WC_RFQAttachmentReplaceDisplay_TableCell_5">
					<input type="text" name="<c:out value="${EC_ATTACH_DESC}" />" value="<c:out value="${filedescAtt}" />" id="WC_RFQAttachmentReplaceDisplay_FormInput_<c:out value="${EC_ATTACH_DESC}" />_In_attachmentReplaceForm_1"/>
				</td>
			</tr>
			<tr>
				<td height="21" colspan="2" id="WC_RFQAttachmentReplaceDisplay_TableCell_6">
					<span class="reqd">*</span>
					<label for="WC_RFQAttachmentReplaceDisplay_FormInput_<c:out value="${EC_ATTACH_FILENAME}" />_In_attachmentReplaceForm_1">
					<fmt:message key="RFQAttachmentReplaceDisplay_Filename" bundle="${storeText}" />
					</label>
				</td>
			</tr>
			<tr>
				<td colspan="2" id="WC_RFQAttachmentReplaceDisplay_TableCell_7">
					<input type="file" name="<c:out value="${EC_ATTACH_FILENAME}" />" value="<c:out value="${filenameAtt}" />" id="WC_RFQAttachmentReplaceDisplay_FormInput_<c:out value="${EC_ATTACH_FILENAME}" />_In_attachmentReplaceForm_1"/>
				</td>
			</tr> 
			<tr><td id="WC_RFQAttachmentReplaceDisplay_TableCell_8">&nbsp;</td></tr>

			<tr>
				<td colspan="2" id="WC_RFQAttachmentReplaceDisplay_TableCell_9">

				<table id="WC_RFQAttachmentReplaceDisplay_Table_4">
				<tbody>
				<tr>

<!-- Start display for button "RFQAttachmentReplaceDisplay_Upload" -->
<td height="41" id="WC_RFQAttachmentReplaceDisplay_TableCell_10">
<a class="button" href="javascript:submitAttach(document.attachmentReplaceForm)" id="WC_RFQAttachmentReplaceDisplay_Link_1"> &nbsp; <fmt:message key="RFQAttachmentReplaceDisplay_Upload" bundle="${storeText}" /> &nbsp;
</a>
</td>
<!-- End display for button ... -->
 
				<td id="WC_RFQAttachmentReplaceDisplay_TableCell_11">&nbsp;</td>

<!-- Start display for button "RFQAttachmentReplaceDisplay_Cancel" -->
<td height="41" id="WC_RFQAttachmentReplaceDisplay_TableCell_12">
<a class="button" href="RFQModifyDisplay?<c:out value="${EC_OFFERING_ID}" />=<c:out value="${rfqId}" />&langId=<c:out value="${langId}" />&storeId=<c:out value="${storeId}" />&catalogId=<c:out value="${catalogId}" />" id="WC_RFQAttachmentReplaceDisplay_Link_2">&nbsp;<fmt:message key="RFQAttachmentReplaceDisplay_Cancel" bundle="${storeText}" />&nbsp;
</a>
</td>
<!-- End display for button ... -->

				</tr>
				</tbody>
				</table>

				</td>
				<td id="WC_RFQAttachmentReplaceDisplay_TableCell_13">&nbsp;</td>
				<td id="WC_RFQAttachmentReplaceDisplay_TableCell_14">&nbsp;</td>
			</tr>
			</tbody>
			</table>

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

