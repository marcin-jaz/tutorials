<%
//********************************************************************
//*-------------------------------------------------------------------
//* Licensed Materials - Property of IBM
//*
//* WebSphere Commerce
//*
//* (c) Copyright IBM Corp. 2007
//*
//* US Government Users Restricted Rights - Use, duplication or
//* disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
//*
//*-------------------------------------------------------------------
//*
%>
<%-- 
  *****
  * When there is a problem authorizing the customer's payment, this email will be sent.
  * This email JSP page informs the customer that the order cannot be completed and provide the following order information:
  *  - Information of each order item (such as item description, shipping address, shipping method)
  *  - Tax, Shipping Charge, and Grand Total of the order
  *****
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../include/JSTLEnvironmentSetup.jspf"%>
<%@ include file="../include/nocache.jspf"%>

<c:set value="${pageContext.request.scheme}://${pageContext.request.serverName}" var="eHostPath" />
<c:set value="${eHostPath}${jspStoreImgDir}" var="jspStoreImgDir" />

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="${shortLocale}" xml:lang="${shortLocale}">
<head>

	<title><fmt:message key="ORDER_CANCELED_TITLE" bundle="${storeText}"/></title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
</head>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

	<table width="594" border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse;">
		<%@ include file="EmailHeader.jspf"%> 
		<tr>
			<td width="12" style="border-left: 1px solid #c9c9c9;"></td>
			<td width="570" valign="top" style="font-family: Verdana, Arial; font-size: 11px; color: #404040;">			
				<% out.flush(); %>
					<c:import url="${jspStoreDir}Snippets/Marketing/Content/ContentSpotDisplay.jsp">
						<c:param name="spotName" value="Order_Rejected1" />
						<c:param name="substitutionValues" value="{storeName},${storeName}"/>
						<c:param name="substitutionValues" value="{orderId},${WCParam.orderId}"/>
					</c:import>
				<% out.flush(); %>				
			</td>
		<td width="12" style="border-right: 1px solid #c9c9c9;"></td>
		</tr>
		<%@ include file="OrderAndShippingSummary.jspf"%> 
		<%@ include file="EmailFooter.jspf"%>
	</table>
</body>
</html>