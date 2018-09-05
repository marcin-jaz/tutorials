<%--
//********************************************************************
//*-------------------------------------------------------------------
//* Licensed Materials - Property of IBM
//*
//* WebSphere Commerce
//*
//* (c) Copyright IBM Corp. 2000, 2002
//*
//* US Government Users Restricted Rights - Use, duplication or
//* disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
//*
//*-------------------------------------------------------------------
//*
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../include/JSTLEnvironmentSetup.jspf" %>
<%@ include file="../../include/ErrorMessageSetup.jspf" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "DTD/xhtml1-transitional.dtd">
<html lang="en">
<head>
<meta http-equiv="Expires" content="Mon, 01 Jan 1996 01:01:01 GMT" />
<title><fmt:message key="errorPageTitle" bundle="${storeText}" /></title>
<link rel="stylesheet"	href='<c:out value="${jspStoreImgDir}${vfileStylesheet}"/>' type="text/css" />
</head>
<c:set var="bid_action" value="${WCParam.bid_action}" />
<c:choose>
	<c:when test="${empty bid_action}"> 
		<c:set var="actionJSP"	value="AutoBidSubSection/AOPAutoBidForm.jsp" />
	</c:when>
	<c:otherwise>
		<c:set var="actionJSP"	value="NormalBidSubSection/AOPBidForm.jsp" />
	</c:otherwise>
</c:choose>


<body>
<%@ include file="../../include/LayoutContainerTop.jspf"%>
<table cellpadding="0" cellspacing="0" border="0" width="600" id="WC_BestSubmitError_Table_1">

	<tbody>
		<tr>
			

			<td bgcolor="#FFFFFF" width="600" valign="top" id="WC_BestSubmitError_TableCell_1">
			<c:set var="incfile" value="BestBidDisplay.jsp" /> 
			<c:import url="${incfile}">					
				<c:param name="errorMessage" value="${errorMessage}" />				
			</c:import>
			<table cellpadding="1" cellspacing="2" width="600" border="0" id="WC_BestSubmitError_Table_2">
				<tbody>
					<tr>
						<td width="10" id="WC_BestSubmitError_TableCell_2">&nbsp;</td>
						<td align="left" valign="top" colspan="5" class="categoryspace"	width="580" id="WC_BestSubmitError_TableCell_3">
						<hr width="100%" noshade="noshade" align="left" />
						<br />
						</td>
					</tr>
				</tbody>
			</table>

			<c:import url="${actionJSP}" /></td>
		</tr>
		
	</tbody>
</table>
<%@ include file="../../include/LayoutContainerBottom.jspf"%>

</body>
</html>

