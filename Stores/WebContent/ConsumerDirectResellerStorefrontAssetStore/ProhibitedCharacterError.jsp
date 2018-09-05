<%--==========================================================================
Licensed Materials - Property of IBM

WebSphere Commerce

(c) Copyright IBM Corp.  2006
All Rights Reserved

US Government Users Restricted Rights - Use, duplication or
disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
===========================================================================--%>
<%-- 
  *****
  * This JSP displays error message when trying to execute some URL that is found to be
  * harmful to the server.
  *****
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="include/JSTLEnvironmentSetup.jspf" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
	<title><fmt:message key="PROHIBITEDCHAR_ERROR_TITLE" bundle="${storeText}" /></title>
	<link rel="stylesheet" href='<c:out value="${jspStoreImgDir}${vfileStylesheet}"/>' type="text/css"/>
</head>

<body>
<!-- JSP File Name:  ProhibitedCharacterError.jsp -->

<%@ include file="include/LayoutContainerTop.jspf"%>

	<!--MAIN CONTENT STARTS HERE-->
			
	<h1><fmt:message key="PROHIBITEDCHAR_ERROR_TITLE" bundle="${storeText}" /></h1>

	<table cellpadding="0" cellspacing="0" width="100%" id="WC_ProhibitedCharacterError_Table_1">
				<tr>
					<td valign="top" id="WC_ProhibitedCharacterError_TableCell_2">
						<fmt:message key="PROHIBITEDCHAR_ERROR_DESC" bundle="${storeText}" />
					</td>
				</tr>
				<tr>
					<td valign="top" id="WC_ProhibitedCharacterError_TableCell_3_1">
						&nbsp;
					</td>
				</tr>
				<tr>
					<td valign="top" id="WC_ProhibitedCharacterError_TableCell_3_2">
						<fmt:message key="PROHIBITEDCHAR_ERROR_BACK_DESC" bundle="${storeText}" />
					</td>
				</tr>
				<tr>
					<td valign="top" id="WC_ProhibitedCharacterError_TableCell_3_3">
						&nbsp;
					</td>
				</tr>
				<tr>
					<td valign="top" id="WC_ProhibitedCharacterError_TableCell_4">
						<a href="javascript:history.back(1)" class="button" id="WC_ProhibitedCharacterError_Link_1">
        			<fmt:message key="PROHIBITEDCHAR_ERROR_BACK" bundle="${storeText}"/>
        		</a>
        	</td>
				</tr>
	</table>

<%@ include file="include/LayoutContainerBottom.jspf"%>

</body>
</html>
