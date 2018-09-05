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

<table cellpadding="0" cellspacing="0" border="0" width="100%" height="100%" class="gray" id="WC_ContentContainerTopTable_1">
	<tr>
	<td class="content" valign="top" id="WC_ContentContainerTopTableCell_1">
		<table cellpadding="0" cellspacing="0" border="0" width="100%" height="100%" id="WC_ContentContainerTopTable_2">
		<tr>
			<td width="8" height="7" id="WC_ContentContainerTopTableCell_2"><img src="<c:out value="${jspStoreImgDir}${vfileColor}" />c_topleft.gif" alt="" width="8" height="7" border="0"></td>
			<td class="c_topline" height="7" id="WC_ContentContainerTopTableCell_3"><img src="<c:out value="${jspStoreImgDir}${vfileColor}" />c_top_side.gif" alt="" width="8" height="7" border="0"></td>
			<td width="8" height="7" id="WC_ContentContainerTopTableCell_4"><img src="<c:out value="${jspStoreImgDir}${vfileColor}" />c_topright.gif" alt="" width="8" height="7" border="0"></td>
		</tr>
		<tr>
			<td class="c_leftline" width="8" id="WC_ContentContainerTopTableCell_5"><img src="<c:out value="${jspStoreImgDir}${vfileColor}" />c_left_side.gif" alt="" width="8" height="7" border="0"></td>
			<td class="white" valign="top" id="WC_ContentContainerTopTableCell_6">
				<c:if test="${!empty param.frameTitle}">
					<table cellpadding="8" cellspacing="0" border="0" width="100%" id="WC_ContentContainerTopTable_3">
						<tr>
							<td class="portlet_content" id="WC_ContentContainerTopTableCell_7">
								<c:out value="${param.frameTitle}" escapeXml="false"/>
							</td>
						</tr>
					</table>
				</c:if>
				<table cellpadding="0" cellspacing="0" border="0" width="100%" id="WC_ContentContainerTopTable_4">
					<tr>
						<td id="WC_ContentContainerTopTableCell_8">

<!-- END ContentContainerTop.jsp -->