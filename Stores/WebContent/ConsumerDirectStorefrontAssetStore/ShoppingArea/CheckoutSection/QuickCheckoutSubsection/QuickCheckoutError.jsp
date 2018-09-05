<%
//********************************************************************
//*-------------------------------------------------------------------
//* Licensed Materials - Property of IBM
//*
//* WebSphere Commerce
//*
//* (c) Copyright IBM Corp. 2000, 2002, 2004
//*
//* US Government Users Restricted Rights - Use, duplication or
//* disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
//*
//*-------------------------------------------------------------------
//*
%>

<%--
  *****
  * The QuickCheckoutError page is displayed when the user has selected the QuickCheckout option on the shopcart page, but 
  * the user is either not logged in or not registered.  Quick checkout is currently only available to registered shoppers.
  * A 'Register or login' button is shown (links to Logon Form Display )
  *****
--%>

<!-- Start - JSP File Name: QuickCheckoutError.jsp -->


<% // All JSPs requires the first 4 packages for getResource.jsp which is used for multi language support %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf" %>

<%-- ErrorMessageSetup.jspf is used to retrieve an appropriate error message when there is an error --%>
<%@ include file="../../../include/ErrorMessageSetup.jspf" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
	<title><fmt:message key="QUICKCHECKOUTERROR_TITLE" bundle="${storeText}"/></title>
	<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${vfileStylesheet}"/>" type="text/css"/>
</head>

<body>

	<%@ include file="../../../include/LayoutContainerTop.jspf"%>

	<!--MAIN CONTENT STARTS HERE-->

	<c:choose>
		<c:when test="${userType eq 'G'}">
			<c:set var="errorMessage">
				<fmt:message key="QCERROR_MESSAGE1" bundle="${storeText}"/>
			</c:set>
		</c:when>
		<c:otherwise>
			<c:set var="errorMessage">
				<fmt:message key="QCERROR_MESSAGE2" bundle="${storeText}"/>
			</c:set>
		</c:otherwise>
	</c:choose>



	<table cellpadding="0" cellspacing="0" width="786" border="0" id="WC_QuickCheckoutError_Table_1">
	<tr>
		<td id="WC_QuickCheckoutError_TableCell_1">
			<span class="text"><br/><c:out value="${errorMessage}"/><br/><br/></span>
		</td>
	</tr>
	<tr>
		<td id="WC_QuickCheckoutError_TableCell_2">
			<%--
			*
			* Check if the customer is registered or not.
			* If registered, clicking on the link will take
			* the user straight to the Quick Checkout Profile Form page.
			* Otherwise, user will be asked to login.
			*
			--%>

			<c:choose>
				<c:when test="${userType eq 'G'}">
					<c:url var="LogonFormURL" value="LogonForm">
						<c:param name="langId" value="${WCParam.langId}" />
						<c:param name="storeId" value="${WCParam.storeId}" />
						<c:param name="catalogId" value="${WCParam.catalogId}" />
						<c:param name="orderId" value="${WCParam.toOrderId}" />
						<c:param name="returnPage" value="quickcheckout" />
					</c:url>
					<a href="<c:out value="${LogonFormURL}"/>" class="button" id="WC_QuickCheckoutError_Link_1">
						<fmt:message key="QC_STATUS1" bundle="${storeText}"/>
					</a>
				</c:when>
				<c:otherwise>
					<c:url var="ProfileFormURL" value="ProfileFormView">
						<c:param name="langId" value="${WCParam.langId}" />
						<c:param name="storeId" value="${WCParam.storeId}" />
						<c:param name="catalogId" value="${WCParam.catalogId}" />
						<c:param name="orderId" value="${WCParam.toOrderId}" />
						<c:param name="returnPage" value="quickcheckout" />
						<c:param name="previousPage" value="${WCParam.previousPage}" />
					</c:url>
					<a href="<c:out value="${ProfileFormURL}"/>" class="button" id="WC_QuickCheckoutError_Link_2">
						<fmt:message key="QC_STATUS2" bundle="${storeText}"/>
					</a>
				</c:otherwise>
			</c:choose>
		</td>
	</tr>
	</table>

	<!-- MAIN CONTENT ENDS HERE -->

	<%-- Hide CIP --%>
	<c:set var="HideCIP" value="true"/>

	<%@ include file="../../../include/LayoutContainerBottom.jspf"%>

</body>
</html>
<!-- End - JSP File Name: QuickCheckoutError.jsp -->