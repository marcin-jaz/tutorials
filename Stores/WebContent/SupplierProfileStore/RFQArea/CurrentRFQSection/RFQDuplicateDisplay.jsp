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
  * This JSP page allows the user to create a duplicate of an RFQ.
  *
  * Elements:  
  * - name input field
  * - OK button
  * - Cancel button
  *
  * Required parameters:
  * - offering_id
  *
  *****
--%>

<%@ page language="java" %>

<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../include/JSTLEnvironmentSetup.jspf" %>

<wcbase:useBean id="bnError" classname="com.ibm.commerce.beans.ErrorDataBean" scope="request">
</wcbase:useBean>
<c:if test="${bnError.exceptionType != null}">
	<c:set var="strErrorMessage" value="${bnError.message}" />
</c:if>

<c:set var="copyAttachmentsYes" value="1" />

<c:set var="strRFQname" />
	
<c:set var="rfqId" value="${WCParam.offering_id}" />
<c:set var="copyAllAttach" value="${copyAttachmentsYes}" />

<c:if test="${bnError.exceptionType != null}" >
	<c:set var="strRFQname" value="${WCParam.newRfqName}" />
	<c:set var="rfqId" value="${WCParam.origRfqId}" />
	<c:set var="copyAllAttach" value="${WCParam.copyAttachment}" />
</c:if>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" lang="en">
<head>
<title><fmt:message key="RFQDuplicateDisplay_Title"	bundle="${storeText}" /></title>
<link rel="stylesheet"	href="<c:out value="${jspStoreImgDir}${vfileStylesheet}"/>"	type="text/css" />
<meta name="GENERATOR" content="IBM WebSphere Studio" />

<script language="javascript">
	function submitDuplicate(form)
	{
		if (form.newRfqName.value=='') {
			error("<fmt:message key="RFQCreateForNextRoundDisplay_Error1" bundle="${storeText}" />");
			return;
		}
		form.submit();
	}

	function error(errMsg)
	{
		alert(errMsg);
	}

</script>

</head>

<body class="noMargin">
<%@ include file="../../include/LayoutContainerTop.jspf"%>

<!--MAIN CONTENT STARTS HERE-->

<table cellpadding="0" border="0" width="100%"	id="WC_RFQDuplicateDisplay_Table_2">
	<tbody>
		<tr>
			<td rowspan="3" id="WC_RFQDuplicateDisplay_TableCell_3">&nbsp;</td>
			<td id="WC_RFQDuplicateDisplay_TableCell_4">
			<h1><fmt:message key="RFQDuplicateDisplay_Duplicate"
				bundle="${storeText}" /></h1>
			<br />
			<c:if test="${strErrorMessage != null}">
				<span class="warning"><c:out value="${strErrorMessage}" /> </span>
				<br />
				<br />
			</c:if> 

			<span class="reqd">*</span><fmt:message
				key="RFQDuplicateDisplay_Required" bundle="${storeText}" /><br />
			</td>
		</tr>
		<tr>
			<td id="WC_RFQDuplicateDisplay_TableCell_5">
			<form name="RFQForm" method="post" action="RFQCopy" id="RFQForm"><input
				type="hidden" name="storeId" value="<c:out value="${storeId}" />"
				id="WC_RFQDuplicateDisplay_FormInput_storeId_In_RFQForm_1" /> <input
				type="hidden" name="langId" value="<c:out value="${langId}" />"
				id="WC_RFQDuplicateDisplay_FormInput_langId_In_RFQForm_1" /> <input
				type="hidden" name="catalogId"
				value="<c:out value="${catalogId}" />"
				id="WC_RFQDuplicateDisplay_FormInput_catalogId_In_RFQForm_1" /> <input
				type="hidden" name="origRfqId"
				value="<c:out value="${rfqId}" />"
				id="WC_RFQDuplicateDisplay_FormInput_origRfqId_In_RFQForm_1" />

			<table border="0" id="WC_RFQDuplicateDisplay_Table_3">

				<tbody>
					<tr>
					<td width="100%" height="21" colspan="3" id="WC_RFQDuplicateDisplay_TableCell_6"><br />
					
						<span class="reqd">*</span><label for="WC_RFQDuplicateDisplay_FormInput_newRfqName_In_RFQForm_1"><fmt:message
							key="RFQDuplicateDisplay_Name" bundle="${storeText}" /></label><br />
							<input size="53" class="input" type="text" maxlength="254"
							name="newRfqName"
							value="<c:out value="${strRFQname}" />"
							id="WC_RFQDuplicateDisplay_FormInput_newRfqName_In_RFQForm_1" /><br />
					
					</td>
					</tr>
				</tbody>
			</table>
			<table border="0" width="100%" id="WC_RFQDuplicateDisplay_Table_4">
				<tbody>
					<tr>
						<td width="100%" height="21" colspan="3" id="WC_RFQDuplicateDisplay_TableCell_7"><br />
						
                                     <span class="reqd">*</span><fmt:message
							key="RFQDuplicateDisplay_copyAttachment" bundle="${storeText}" />
						</td>
					</tr>
					<tr>
						<td id="WC_RFQDuplicateDisplay_TableCell_8"><c:choose>
						<c:when test="${copyAllAttach eq copyAttachmentsYes}">
	               			<input size="53" class="radio" type="radio"
						name="copyAttachment"
						value="1"
						checked="checked"
						id="WC_RFQDuplicateDisplay_FormInput_copyAttachment_In_RFQForm_1" />
					
                                      <label for="WC_RFQDuplicateDisplay_FormInput_copyAttachment_In_RFQForm_1" >
                                                         <fmt:message key="RFQDuplicateDisplay_All"
									bundle="${storeText}" /></label>
							
								<br />
							        <copyAttachment>								
                                                                    <input size="53" class="radio" type="radio"
									name="copyAttachment"
									value="0"
									id="WC_RFQDuplicateDisplay_FormInput_copyAttachment_In_RFQForm_2" />
						    
                                                <label for="WC_RFQDuplicateDisplay_FormInput_copyAttachment_In_RFQForm_2">
                                                          <fmt:message key="RFQDuplicateDisplay_None"
									bundle="${storeText}" /></label>
							<br />
							</c:when>
							<c:otherwise>
							<input size="53" class="radio" type="radio"
									name="copyAttachment"
									value="1"
									id="WC_RFQDuplicateDisplay_FormInput_copyAttachment_In_RFQForm_3" />
					                                  

                         <label for="WC_RFQDuplicateDisplay_FormInput_copyAttachment_In_RFQForm_3">
                                                     <fmt:message key="RFQDuplicateDisplay_All"
									bundle="${storeText}" /></label>
							<br />

									<input size="53" class="radio" type="radio"
									name="copyAttachment"
									value="0"
									checked="checked"
									id="WC_RFQDuplicateDisplay_FormInput_copyAttachment_In_RFQForm_4" />
                                                  <label for="WC_RFQDuplicateDisplay_FormInput_copyAttachment_In_RFQForm_4">
                                                          <fmt:message key="RFQDuplicateDisplay_None"
									bundle="${storeText}" /></label>
								<br />
							</c:otherwise>
						</c:choose>
						
						</td>
					</tr>
				</tbody>
			</table>
			<input type="hidden" name="URL" value="RFQListDisplay"
				id="WC_RFQDuplicateDisplay_FormInput_URL_In_RFQForm_1" /></form>
			</td>
		</tr>
		<tr>
			<td colspan="3" id="WC_RFQDuplicateDisplay_TableCell_9">
			<table id="WC_RFQDuplicateDisplay_Table_5">
				<tr>

					<!-- Start display for Search button No. 1 "RFQDuplicateDisplay_Ok" -->
					<td height="41" id="WC_RFQDuplicateDisplay_TableCell_10"><a
						class="button" href="javascript:submitDuplicate(document.RFQForm)"
						id="WC_RFQDuplicateDisplay_Link_1">&nbsp;<fmt:message
						key="RFQDuplicateDisplay_Ok" bundle="${storeText}" />&nbsp; </a>
					</td>
					<!-- End display for Search button No.1 -->

					<td id="WC_RFQDuplicateDisplay_TableCell_11">&nbsp;</td>

					<!-- Start display for Search button No. 2 "RFQDuplicateDisplay_Cancel" -->
					<td height="41" id="WC_RFQDuplicateDisplay_TableCell_12"><c:url
						var="RFQDisplayLink" value="RFQDisplay">
						<c:param name="offering_id" value="${rfqId}" />
						<c:param name="langId" value="${langId}" />
						<c:param name="storeId" value="${storeId}" />
						<c:param name="catalogId" value="${catalogId}" />
					</c:url> <a class="button" 
						href="<c:out value="${RFQDisplayLink}" />"
						id="WC_RFQDuplicateDisplay_Link_2">&nbsp;<fmt:message
						key="RFQDuplicateDisplay_Cancel" bundle="${storeText}" />&nbsp;
					</a></td>
					<!-- End display for Search button No. 2 -->

				</tr>
			</table> 
			</td>
		</tr>
		<tr>
			<td id="WC_RFQDuplicateDisplay_TableCell_13">&nbsp;</td>
		</tr>
	</tbody>
</table>

<!-- content end -->


<%@ include file="../../include/LayoutContainerBottom.jspf"%>
</body>
</html>





