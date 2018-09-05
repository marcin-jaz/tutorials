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
  *****
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../JSTLEnvironmentSetup.jspf"%>

<!-- BEGIN ContentContainerTop.jsp -->

<!-- This file is empty. Add content here that you want as a common wrapper for your main content. -->

<%-- 

 A JSTL page scoped variable 'frameTitle' is passed in if you set it in your content page before
 including 'LayoutContainerTop.jspf'. You can use it to enhance this wrapper decoration.
 
 For example a graphical treatment that looks like a GUI window. The "GUI window" could have its
 title set to <c:out value="${param.frameTitle}"/>
	 
--%>

<table cellpadding="0" cellspacing="0" border="0" width="100%" height="100%" class="content" id="WC_ContentContainerTop_Table_1">
	<tr>
		<td valign="top" id="WC_ContentContainerTop_TableCell_1">
			<table cellpadding="0" cellspacing="0" border="0" id="WC_ContentContainerTop_Table_2">
				<tr>
					<td id="WC_ContentContainerTop_TableCell_2">

<!-- END ContentContainerTop.jsp -->
