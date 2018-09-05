<%
//********************************************************************
//*-------------------------------------------------------------------
//* Licensed Materials - Property of IBM
//*
//* WebSphere Commerce
//*
//* (c) Copyright IBM Corp. 2001, 2002, 2004
//*
//* US Government Users Restricted Rights - Use, duplication or
//* disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
//*
//*-------------------------------------------------------------------
//*
%>

<%-- 
  *****
  * This JSP will display the ResetPassword form with the following fields:
  *  - Current password
  *  - New password
  *  - New Verify password
  * If the user password expired, this page will be displayed after the user logs on.
  *****
--%>

<!-- Start - JSP File Name:  PasswordUpdateForm.jsp -->

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf" %>
<%@ include file="../../../include/nocache.jspf" %>
<%-- ErrorMessageSetup.jspf is used to retrieve an appropriate error message when there is an error --%>
<%@ include file="../../../include/ErrorMessageSetup.jspf" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
	<title><fmt:message key="CHANGE_PWORD_TITLE" bundle="${storeText}"/></title>
	<link rel="stylesheet" href='<c:out value="${jspStoreImgDir}${vfileStylesheet}"/>' type="text/css"/>
</head>

<body>

<%@ include file="../../../include/LayoutContainerTop.jspf"%>

	<!--MAIN CONTENT STARTS HERE-->
	
	<h1><fmt:message key="CHANGE_PWORD" bundle="${storeText}"/></h1>

	<%-- 
	  ***
	  *	Start: Error handling
	  * Show an appropriate error message when there is an error
	  ***
	--%>
	<c:if test="${!empty errorMessage}">
		<span class="error"><br/><c:out value="${errorMessage}"/><br/><br/></span>
	</c:if>
	<%-- 
	  ***
	  *	End: Error handling
	  ***
	--%>				

	<%-- 
	  ***
	  *	Start: Reset Password Form
	  ***
	--%>
	<form name="Logon" method="post" action="ResetPassword" id="Logon">
	<input type="hidden" name="storeId" value='<c:out value="${WCParam.storeId}" />' id="WC_PasswordUpdateForm_FormInput_storeId_In_Logon_1"/>
	<input type="hidden" name="catalogId" value='<c:out value="${WCParam.catalogId}" />' id="WC_PasswordUpdateForm_FormInput_catalogId_In_Logon_1"/>
	<input type="hidden" name="langId" value='<c:out value="${langId}" />' id="WC_PasswordUpdateForm_FormInput_langId_In_Logon_1"/>
	<input type="hidden" name="logonId" value='<c:out value="${WCParam.logonId}" />' id="WC_PasswordUpdateForm_FormInput_logonId_In_Logon_1"/>
	<input type="hidden" name="reLogonURL" value="ChangePassword" id="WC_PasswordUpdateForm_FormInput_reLogonURL_In_Logon_1"/>
	<input type="hidden" name="Relogon" value="Update" id="WC_PasswordUpdateForm_FormInput_Relogon_In_Logon_1"/>
	
	<input type="hidden" name="fromOrderId" value="*" id="WC_PasswordResetForm_FormInput_fromOrderId_In_Logon_1"/>
	<input type="hidden" name="toOrderId" value="." id="WC_PasswordResetForm_FormInput_toOrderId_In_Logon_1"/>
	<input type="hidden" name="deleteIfEmpty" value="*" id="WC_PasswordResetForm_FormInput_deleteIfEmpty_In_Logon_1" />
	<input type="hidden" name="continue" value="1" id="WC_PasswordResetForm_FormInput_continue_In_Logon_1" />
	<input type="hidden" name="createIfEmpty" value="1" id="WC_PasswordResetForm_FormInput_createIfEmpty_In_Logon_1" />
	<%-- the parameter 'calculationUsageId' and 'updatePrices' are used by the OrderCalculate command --%>
	<input type="hidden" name="calculationUsageId" value="-1" id="WC_PasswordResetForm_FormInput_calculationUsageId_In_Logon_1" />
	<input type="hidden" name="updatePrices" value="1" id="WC_PasswordResetForm_FormInput_updatePrices_In_Logon_1"/>
	<input type="hidden" name="URL" value="OrderItemMove?page=account&amp;URL=OrderCalculate%3FURL%3DLogonForm" id="WC_PasswordResetForm_FormInput_URL_In_ResetPasswordForm_1"/>
	
	<table cellpadding="0" cellspacing="0" border="0" class="t_table" id="WC_PasswordUpdateForm_Table_1">
	<tbody><tr>
		<td class="t_td2" id="WC_PasswordUpdateForm_TableCell_1">
			<fmt:message key="PWORD_EXPIRED" bundle="${storeText}"/>
		</td>
	</tr>
	<tr>
		<td class="t_td2" id="WC_PasswordUpdateForm_TableCell_2">
			<label for="WC_PasswordUpdateForm_FormInput_logonPasswordOld_In_Logon_1">
				<fmt:message key="CURRENT_PWORD" bundle="${storeText}"/>
			</label>
		</td>
	</tr>
	<tr>
		<td class="t_td2" id="WC_PasswordUpdateForm_TableCell_3">
			<input size="25" maxlength="50" name="logonPasswordOld" type="password" value="" id="WC_PasswordUpdateForm_FormInput_logonPasswordOld_In_Logon_1"/>
		</td>
	</tr>
	<tr>
		<td class="t_td2" id="WC_PasswordUpdateForm_TableCell_4">
			<label for="WC_PasswordUpdateForm_FormInput_logonPassword_In_Logon_1">
				<fmt:message key="PASSWORD" bundle="${storeText}"/>
			</label>
		</td>
	</tr>
	<tr>
		<td class="t_td2" id="WC_PasswordUpdateForm_TableCell_5">
			<input size="25" maxlength="50" name="logonPassword" type="password" value="" id="WC_PasswordUpdateForm_FormInput_logonPassword_In_Logon_1"/>
		</td>
	</tr>
	<tr>
		<td class="t_td2" id="WC_PasswordUpdateForm_TableCell_6">
			<label for="WC_PasswordUpdateForm_FormInput_logonPasswordVerify_In_Logon_1">
				<fmt:message key="VERIFY_PASS" bundle="${storeText}"/>
			</label>
		</td>
	</tr>
	<tr>
		<td class="t_td2" id="WC_PasswordUpdateForm_TableCell_7">
			<input size="25" maxlength="50" name="logonPasswordVerify" type="password" value="" id="WC_PasswordUpdateForm_FormInput_logonPasswordVerify_In_Logon_1"/>
		</td>
	</tr>
	</table>
	
	<br/><br/>

	<a href="javascript:document.Logon.submit()" class="button" id="WC_PasswordUpdateForm_Link_1">
		<fmt:message key="SUBMIT" bundle="${storeText}"/>
	</a>

	</form>
	<%-- 
	  ***
	  *	End: Reset Password Form
	  ***
	--%>				

<%-- Hide CIP --%>
<c:set var="HideCIP" value="true"/>

<%@ include file="../../../include/LayoutContainerBottom.jspf"%>

</body>
</html>
<!-- End - JSP File Name:  PasswordUpdateForm.jsp -->
