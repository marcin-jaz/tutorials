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
  * This JSP displays help tips to the customer. It shows the following information:
  *  - How to complete an order
  *  - How to make payment for an order
  *  - Credit card security policy
  *  - How to track an order
  *****
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../include/JSTLEnvironmentSetup.jspf" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
	<title><fmt:message key="HELP_TITLE" bundle="${storeText}" /></title>
	<link rel="stylesheet" href='<c:out value="${jspStoreImgDir}${vfileStylesheet}"/>' type="text/css"/>
</head>

<body>
<!-- JSP File Name:  HelpDisplay.jsp -->

<%@ include file="../include/LayoutContainerTop.jspf"%>

	<!--MAIN CONTENT STARTS HERE-->

	<h1><fmt:message key="HELP3" bundle="${storeText}" /></h1>

	<c:import url="${jspStoreDir}/Snippets/Marketing/Content/ContentSpotDisplay.jsp">
		<c:param name="spotName" value="HelpSpot_part1" />
		<c:param name="substitutionValues" value="{storeName},${storeName}" />
	</c:import>
	<c:import url="${jspStoreDir}/Snippets/Marketing/Content/ContentSpotDisplay.jsp">
		<c:param name="spotName" value="HelpSpot_part2" />
		<c:param name="substitutionValues" value="{storeName},${storeName}" />
	</c:import>
	
<%@ include file="../include/LayoutContainerBottom.jspf"%>

</body>
</html>
