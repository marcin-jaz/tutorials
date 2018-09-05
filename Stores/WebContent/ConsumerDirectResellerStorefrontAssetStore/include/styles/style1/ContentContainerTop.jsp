<%--
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
--%>
<%-- 
  *****
  * This JSP fragment displays the top and left portion of the main content container.
  * The container displays a breadcrumb trail or title with the value of the 'frameTitle' JSTL variable.
  * This is an example of how this file could be included into a page: 
  * <c:import url="${jspStoreDir}${StyleDir}ContentContainerTop.jsp">
  *		<c:param name="frameTitle" value="${frameTitle}" />
  *	</c:import>
  *****
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../JSTLEnvironmentSetup.jspf"%>

<!-- BEGIN ContentContainerTop.jsp -->

<%-- 

 A JSTL page scoped variable 'frameTitle' is passed in if you set it in your content page before
 including 'LayoutContainerTop.jspf'. You can use it to enhance this wrapper decoration.
 
 For example a graphical treatment that looks like a GUI window. The "GUI window" could have its
 title set to <c:out value="${param.frameTitle}"/>
	 
--%>

<table align="center" cellpadding="0" cellspacing="0" border="0" width="100%"  id="WC_ContentContainerTop_Table_1">
	<tr>
		<td align="center" class="c_back" valign="top">
			<table cellpadding="0" cellspacing="0" border="0" class="p_width">
				<tr>
					<td>

<!-- END ContentContainerTop.jsp -->