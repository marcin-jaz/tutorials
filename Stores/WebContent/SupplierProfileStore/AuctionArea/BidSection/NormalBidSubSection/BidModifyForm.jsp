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
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "DTD/xhtml1-transitional.dtd">
<html lang="en">
<head>
<meta http-equiv="Expires" content="Mon, 01 Jan 1996 01:01:01 GMT" />
<title><fmt:message key="bidModifyTitle" bundle="${storeText}" /></title>
<link rel="stylesheet"
	href='<c:out value="${jspStoreImgDir}${vfileStylesheet}"/>'
	type="text/css" />
</head>

<body>
<%@ include file="../../../include/LayoutContainerTop.jspf"%>
<table cellpadding="0" cellspacing="0" border="0" width="600" id="WC_BidModify_Table_1">
	
	<tbody>
		<tr>
			
			<td bgcolor="#FFFFFF" width="600" valign="top" id="WC_BidModify_TableCell_1">
			<c:set var="aucrfn"	value="${WCParam.aucrfn}" /> 
			<c:set var="bidrfn"	value="${requestScope.bidrfn}" /> 
			<c:if test="${empty bidrfn}">
				<c:set var="bidrfn" value="${WCParam.bidrfn}" />
			</c:if> 
			<c:import url="../BestBidDisplay.jsp" />



			<table cellpadding="1" cellspacing="2" width="600" border="0" id="WC_BidModify_Table_2">
				<tbody>
					<tr>
						<td width="10" id="WC_BidModify_TableCell_2">&nbsp;</td>
						<td align="left" valign="top" colspan="5" class="categoryspace"	width="580" id="WC_BidModify_TableCell_3">
						<hr width="100%" noshade="noshade" align="left" />
						<br />
						</td>
					</tr>
				</tbody>
			</table>
		
			<c:import url="AOPBidForm.jsp">
				<c:param name="bid_action" value="update" />
				<c:param name="bidrfn" value="${bidrfn}" />
			</c:import>
			
			</td>
		</tr>
		
	</tbody>
</table>

<%@ include file="../../../include/LayoutContainerBottom.jspf"%>
</body>
</html>

