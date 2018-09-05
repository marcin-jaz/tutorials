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
  * This JSP page displays the Help page with customized help text.
  *****
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../include/JSTLEnvironmentSetup.jspf"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<!-- BEGIN HelpDisplay.jsp -->
<head>
<title><fmt:message key="HELP_TITLE" bundle="${storeText}"/></title>
<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${vfileStylesheet}"/>" type="text/css"/>
</head>
<body class="noMargin">
<%@ include file="../include/LayoutContainerTop.jspf"%>
<table cellpadding="8" border="0" id="WC_HelpDisplay_Table_1">
  <tbody>
    <tr>
      <td id="WC_HelpDisplay_TableCell_1">
		<h1><fmt:message key="HELP_TITLE" bundle="${storeText}"/></h1>

<%-- LI1075 Reading from ContentSpotDisplay.jsp --%>
		<c:import url="${jspStoreDir}/Snippets/Marketing/Content/ContentSpotDisplay.jsp">
			<c:param name="spotName" value="Help_Text1" />
			<c:param name="substitutionValues" value="{storeName},${storeName}" />
		</c:import>
		<c:import url="${jspStoreDir}/Snippets/Marketing/Content/ContentSpotDisplay.jsp">
			<c:param name="spotName" value="Help_Text2" />
			<c:param name="substitutionValues" value="{storeName},${storeName}" />
		</c:import>
		<c:import url="${jspStoreDir}/Snippets/Marketing/Content/ContentSpotDisplay.jsp">
			<c:param name="spotName" value="Help_Text3" />
			<c:param name="substitutionValues" value="{storeName},${storeName}" />
		</c:import>
		
	  </td>
	</tr>
  </tbody>
</table>
<%@ include file="../include/LayoutContainerBottom.jspf"%>
</body>
<!-- END HelpDisplay.jsp -->
</html>
