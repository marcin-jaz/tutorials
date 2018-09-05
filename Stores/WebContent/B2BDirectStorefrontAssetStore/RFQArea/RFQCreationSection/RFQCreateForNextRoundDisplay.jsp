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
  * This JSP page displays input fields for creating a next round RFQ.
  *
  * Required parameters:
  * - oldRfqId
  * - rfqName
  * - copyAllAttach
  * - rfqId
  *
  *****
--%>

<%@ page language="java" %>

<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../include/JSTLEnvironmentSetup.jspf" %>


<%@ include file="RFQCreateConstants.jspf" %>

<wcbase:useBean id="bnError" classname="com.ibm.commerce.beans.ErrorDataBean" scope="request">
</wcbase:useBean>
<c:if test="${bnError.exceptionType != null}">
	<c:set var="strErrorMessage" value="${bnError.message}" />
</c:if>

<c:choose>
	<c:when test="${!empty bnError.exceptionType}">
		<c:set var="strErrorMessage" value="${dbError.message}" />
		<c:set var="strRFQname" value="${WCParam[EC_NEW_RFQ_NAME]}" />
		<c:set var="rfqId" value="${WCParam[EC_ORIG_RFQ_ID]}" />
		<c:set var="copyAllAttach" value="${WCParam[EC_COPY_ATTACHMENT]}" />
	</c:when>
	<c:otherwise>
		<c:set var="rfqId" value="${WCParam[EC_OFFERING_ID]}" />
	</c:otherwise>
</c:choose>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" lang="en">

<head>

<title><fmt:message key="RFQCreateForNextRoundDisplay_Title" bundle="${storeText}"/></title>
<link rel="stylesheet"	href="<c:out value="${jspStoreImgDir}${vfileStylesheet}"/>"	type="text/css" />
<meta name="GENERATOR" content="IBM WebSphere Studio"/>

<script language="javascript">
	function submitCreate(form)
	{
		if (form.newRfqName.value=='') {
			error("<fmt:message key="RFQCreateForNextRoundDisplay_Error1" bundle="${storeText}"/>");
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
<%@ include file="../../include/LayoutContainerTop.jspf"%>


<flow:ifEnabled feature="customerCare">	
	<c:set var="liveHelpPageType" value="personal" scope="request" />
</flow:ifEnabled>

<table border="0" cellpadding="0" cellspacing="0" width="790" height="99%" id="WC_RFQCreateForNextRoundDisplay_Table_1">
    <tbody>
        <tr>
            <td valign="top" width="630" id="WC_RFQCreateForNextRoundDisplay_TableCell_2">

            <!--MAIN CONTENT STARTS HERE-->

            <table cellpadding="0" border="0" width="100%" id="WC_RFQCreateForNextRoundDisplay_Table_2">
                <tbody>
                    <tr>
                        <td rowspan="3" id="WC_RFQCreateForNextRoundDisplay_TableCell_3">&nbsp;</td>
                        <td id="WC_RFQCreateForNextRoundDisplay_TableCell_4">
                        <h1><fmt:message key="RFQCreateForNextRoundDisplay_NextRound" bundle="${storeText}"/></h1>
				<c:if test="${!empty strErrorMessage}" >
                        <span class="warning"><c:out value="${strErrorMessage}" /></span><br /><br />
                        <p></p>
                </c:if>
                        <span class="reqd">*</span><fmt:message key="RFQCreateForNextRoundDisplay_Required" bundle="${storeText}"/><br />

                    </tr>
                    <tr>
                        <td id="WC_RFQCreateForNextRoundDisplay_TableCell_5">

            			<form name="RFQForm" method="get" action="RFQCreateForNextRound" id="RFQForm">
						<input type="hidden" name="langId" value="<c:out value="${langId}" />" id="WC_RFQCreateForNextRoundDisplay_FormInput_langId_In_RFQForm_1"/>
						<input type="hidden" name="storeId" value="<c:out value="${storeId}" />" id="WC_RFQCreateForNextRoundDisplay_FormInput_storeId_In_RFQForm_1"/>
						<input type="hidden" name="catalogId" value="<c:out value="${WCParam.catalogId}" />" id="WC_RFQCreateForNextRoundDisplay_FormInput_catalogId_In_RFQForm_1"/>
						<input type="hidden" name="<c:out value="${EC_ORIG_RFQ_ID}" />" value="<c:out value="${rfqId}" />" id="WC_RFQCreateForNextRoundDisplay_FormInput_<c:out value="${EC_ORIG_RFQ_ID}" />_In_RFQForm_1"/>

                       <table border="0" id="WC_RFQCreateForNextRoundDisplay_Table_3">
                            <tbody>
                                <tr>
                                    <td width="100%" height="21" colspan="3" id="WC_RFQCreateForNextRoundDisplay_TableCell_6">
                                    <br />
                                    <span class="reqd">*</span><label for="WC_RFQCreateForNextRoundDisplay_FormInput_<c:out value="${EC_NEW_RFQ_NAME}" />_In_RFQForm_1"><fmt:message key="RFQCreateForNextRoundDisplay_Name" bundle="${storeText}"/></label><br />
                                    <input size="53" class="input" type="text" maxlength="254" name="<c:out value="${EC_NEW_RFQ_NAME}" />" value="<c:out value="${strRFQname}" />" id="WC_RFQCreateForNextRoundDisplay_FormInput_<c:out value="${EC_NEW_RFQ_NAME}" />_In_RFQForm_1"/><br />
                                    
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                       <table border="0" width="100%" id="WC_RFQCreateForNextRoundDisplay_Table_4">
                            <tbody>
                                <tr>
                                    <td width="100%" height="21" colspan="3" id="WC_RFQCreateForNextRoundDisplay_TableCell_7">
                                    <br />
                                    <span class="reqd">*</span>                                                            
                                    <label for="WC_RFQCreateForNextRoundDisplay_FormInput_<c:out value="${EC_COPY_ATTACHMENT}" />_In_RFQForm_1">
                                    <fmt:message key="RFQCreateForNextRoundDisplay_copyAttachment" bundle="${storeText}"/>
                                    </label>
                                    </td>
                                </tr>
                                <tr>
                                    <td id="WC_RFQCreateForNextRoundDisplay_TableCell_8">
                                    <c:choose>
										<c:when test="${copyAllAttach eq EC_COPY_ATTACHMENT_YES}" >
										    <input size="53" class="radio" type="radio" name="<c:out value="${EC_COPY_ATTACHMENT}" />" value="<c:out value="${EC_COPY_ATTACHMENT_YES}" />" checked="checked" id="WC_RFQCreateForNextRoundDisplay_FormInput_<c:out value="${EC_COPY_ATTACHMENT}" />_In_RFQForm_1"/>
										    <label for="WC_RFQCreateForNextRoundDisplay_FormInput_<c:out value="${EC_COPY_ATTACHMENT}" />_In_RFQForm_2">
										    <fmt:message key="RFQCreateForNextRoundDisplay_Yes" bundle="${storeText}"/></label><br />
                                    		<input size="53" class="radio" type="radio" name="<c:out value="${EC_COPY_ATTACHMENT}" />" value="<c:out value="${EC_COPY_ATTACHMENT_NO}" />" id="WC_RFQCreateForNextRoundDisplay_FormInput_<c:out value="${EC_COPY_ATTACHMENT}" />_In_RFQForm_2"/>
                                    		<fmt:message key="RFQCreateForNextRoundDisplay_No" bundle="${storeText}"/><br />
										</c:when>
										<c:otherwise>
											<label for="WC_RFQCreateForNextRoundDisplay_FormInput_<c:out value="${EC_COPY_ATTACHMENT}" />_In_RFQForm_3" ></label>
											<input size="53" class="radio" type="radio" name="<c:out value="${EC_COPY_ATTACHMENT}" />" value="<c:out value="${EC_COPY_ATTACHMENT_YES}" />" id="WC_RFQCreateForNextRoundDisplay_FormInput_<c:out value="${EC_COPY_ATTACHMENT}" />_In_RFQForm_3"/>
											
											<label for="WC_RFQCreateForNextRoundDisplay_FormInput_<c:out value="${EC_COPY_ATTACHMENT}" />_In_RFQForm_4">
											<fmt:message key="RFQCreateForNextRoundDisplay_Yes" bundle="${storeText}"/>
											</label>
											<br />
                                    		<input size="53" class="radio" type="radio" name="<c:out value="${EC_COPY_ATTACHMENT}" />" value="<c:out value="${EC_COPY_ATTACHMENT_NO}" />" checked="checked" id="WC_RFQCreateForNextRoundDisplay_FormInput_<c:out value="${EC_COPY_ATTACHMENT}" />_In_RFQForm_4"/>
                                    		<fmt:message key="RFQCreateForNextRoundDisplay_No" bundle="${storeText}"/><br />
										</c:otherwise>
									</c:choose>
                                    </td>
                                </tr>
                            </tbody>
                        </table>

                        <input type="hidden" name="URL" value="RFQListDisplay" id="WC_RFQCreateForNextRoundDisplay_FormInput_URL_In_RFQForm_1"/>
                        </form>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3" id="WC_RFQCreateForNextRoundDisplay_TableCell_9">
                        <table id="WC_RFQCreateForNextRoundDisplay_Table_5">
                            <tbody><tr>


								<!-- Start display for button "RFQCreateForNextRoundDisplay_Ok" -->
                               
								<td height="41" id="WC_RFQCreateForNextRoundDisplay_TableCell_10">
								<a class="button" href="javascript:submitCreate(document.RFQForm)" id="WC_RFQCreateForNextRoundDisplay_Link_1"> &nbsp;<fmt:message key="RFQCreateForNextRoundDisplay_Ok" bundle="${storeText}"/>&nbsp; 
								</a>
								</td>
								<!-- End display for button ... -->
								
								<td id="WC_RFQCreateForNextRoundDisplay_TableCell_11">&nbsp;</td>
								
								<!-- Start display for button "RFQCreateForNextRoundDisplay_Cancel" -->
								<td height="41" id="WC_RFQCreateForNextRoundDisplay_TableCell_12">
								
		
								<a class="button" href="RFQDisplay?<c:out value="${EC_OFFERING_ID}" />=<c:out value="${rfqId}" />&langId=<c:out value="${langId}" />&storeId=<c:out value="${storeId}" />&catalogId=<c:out value="${catalogId}" />" id="WC_RFQCreateForNextRoundDisplay_Link_2">&nbsp;<fmt:message key="RFQCreateForNextRoundDisplay_Cancel" bundle="${storeText}"/>&nbsp; 
								</a>								
								
								</td>
								<!-- End display for button ... -->
                           </tr> 
                        </tbody></table>
                        </td>
                    </tr>
                    <tr>
                        <td id="WC_RFQCreateForNextRoundDisplay_TableCell_13">&nbsp;</td>
                     </tr>
                </tbody>
            </table>
            <!--content end-->

            </td>
        </tr>
    </tbody>
</table>

<%@ include file="../../include/LayoutContainerBottom.jspf"%>
</body>
</html>								
								
								
								
								
								
								
								
								
