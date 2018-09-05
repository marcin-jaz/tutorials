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
  * This JSP displays the store's privacy policy. It shows the following information:
  *  - How personal information is maintained
  *  - How cookies are used by the store
  *  - Important notices
  *****
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../include/JSTLEnvironmentSetup.jspf" %>

<!--START HEADER-->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
	<title><fmt:message key="PRIVACY_TITLE" bundle="${storeText}" /></title>
	<link rel="stylesheet" href='<c:out value="${jspStoreImgDir}${vfileStylesheet}"/>' type="text/css"/>
</head>

<body>

<%@ include file="../include/LayoutContainerTop.jspf"%>

	<!--MAIN CONTENT STARTS HERE-->

	<h1><fmt:message key="PRIVACY_POLICY" bundle="${storeText}" /></h1>

	<c:import url="${jspStoreDir}Snippets/Marketing/Content/ContentSpotDisplay.jsp">
		<c:param name="spotName" value="PrivacyPolicy_part1" />
		<c:param name="substitutionValues" value="{storeName},${storeName}" />
 	</c:import>
	<c:import url="${jspStoreDir}Snippets/Marketing/Content/ContentSpotDisplay.jsp">
		<c:param name="spotName" value="PrivacyPolicy_part2" />
		<c:param name="substitutionValues" value="{storeName},${storeName}" />
 	</c:import>
	<c:import url="${jspStoreDir}Snippets/Marketing/Content/ContentSpotDisplay.jsp">
		<c:param name="spotName" value="PrivacyPolicy_part3" />
		<c:param name="substitutionValues" value="{storeName},${storeName}" />
 	</c:import>
	<c:import url="${jspStoreDir}Snippets/Marketing/Content/ContentSpotDisplay.jsp">
		<c:param name="spotName" value="PrivacyPolicy_part4" />
		<c:param name="substitutionValues" value="{storeName},${storeName}" />
 	</c:import>
	<c:import url="${jspStoreDir}Snippets/Marketing/Content/ContentSpotDisplay.jsp">
		<c:param name="spotName" value="PrivacyPolicy_part5" />
 	</c:import>
<%@ include file="../include/LayoutContainerBottom.jspf"%>

</body>
</html>
