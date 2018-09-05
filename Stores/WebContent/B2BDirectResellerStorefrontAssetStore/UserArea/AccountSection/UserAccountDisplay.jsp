<%--
/*
 *-------------------------------------------------------------------
 * Licensed Materials - Property of IBM
 *
 * WebSphere Commerce
 *
 * (c) Copyright International Business Machines Corporation. 2001-2004
 *     All rights reserved.
 *
 * US Government Users Restricted Rights - Use, duplication or
 * disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
 *
 *-------------------------------------------------------------------
 */
--%>

<%--
  *****
  * This page allows a user to access the user registration update form and
  * the address book.
  *****
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../include/JSTLEnvironmentSetup.jspf" %>

<wcbase:useBean id="userReg" classname="com.ibm.commerce.user.beans.UserRegistrationDataBean"/>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<!-- BEGIN UserAccountDisplay.jsp -->
<head>
<title><fmt:message key="Account_Title" bundle="${storeText}"/></title>
<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${vfileStylesheet}"/>" type="text/css"/>
</head>

<body class="noMargin">

<%@ include file="../../include/LayoutContainerTop.jspf" %>

<table class="noBorder" cellpadding="0" cellspacing="12" id="WC_UserAccountDisplay_Table_1">

<tr><td id="WC_UserAccountDisplay_TableCell_1"><h1><fmt:message key="Account_Title" bundle="${storeText}"/></h1></td></tr>

<c:if test="${CommandContext.user.state == '0'}">
	<c:if test="${WCParam.errorState == 'approvalError'}">
		<tr><td id="WC_UserAccountDisplay_TableCell_2"><strong><fmt:message key="OrderApproval_no_approver" bundle="${storeText}"/></strong></td></tr>
	</c:if>
	<tr><td id="WC_UserAccountDisplay_TableCell_3"><strong><fmt:message key="AddBook_PendingState" bundle="${storeText}"/></strong></td></tr>
</c:if>

<c:if test="${userReg.profileType == 'C'}">
	<tr><td id="WC_UserAccountDisplay_TableCell_4"><fmt:message key="Account_Message_ProfileType" bundle="${storeText}"/></td></tr>
</c:if>

<tr><td id="WC_UserAccountDisplay_TableCell_5">
	<strong><fmt:message key="Account_Heading1" bundle="${storeText}"/></strong><br/>
	<fmt:message key="Account_Text1" bundle="${storeText}"/>
</td></tr>

<tr><td id="WC_UserAccountDisplay_TableCell_6">
	<c:url var="userRegFormURL" value="UserRegistrationForm">
		<c:param name="storeId"   value="${WCParam.storeId}"  />
		<c:param name="catalogId" value="${WCParam.catalogId}"/>
	</c:url>
	<a class="button" href="<c:out value="${userRegFormURL}"/>" id="WC_UserAccountDisplay_Link_1">
		<fmt:message key="Account_Button1" bundle="${storeText}"/>
	</a>
	<br/><br/>
</td></tr>

<tr><td id="WC_UserAccountDisplay_TableCell_7">
	<strong><fmt:message key="Account_Heading2" bundle="${storeText}"/></strong><br/>
	<fmt:message key="Account_Text2" bundle="${storeText}"/>
</td></tr>

<tr><td id="WC_UserAccountDisplay_TableCell_8">
	<c:url var="addrFormURL" value="AddressBookForm">
		<c:param name="storeId"   value="${WCParam.storeId}"  />
		<c:param name="catalogId" value="${WCParam.catalogId}"/>
	</c:url>
	<a class="button" href="<c:out value="${addrFormURL}"/>" id="WC_UserAccountDisplay_Link_2">
		<fmt:message key="Account_Button2" bundle="${storeText}"/>
	</a>
	<br/><br/>
</td></tr>

</table>

<%@ include file="../../include/LayoutContainerBottom.jspf" %>

</body>
<!-- END UserAccountDisplay.jsp -->
</html>

