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
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../JSTLEnvironmentSetup.jspf"%>
<%-- 
  *****
  * This JSP fragment displays the top and left portion of the Configurable Store Display portlet.
  *****
--%>
<!-- BEGIN HUDContainerTop.jspf -->

<%-- 

 A JSTL page scoped variable 'miniFrameTitle' is passed in if you set it in your HUD content page before
 including 'HUDContainerTop.jspf'. You can use it to enhance this wrapper decoration.
 
 For example a graphical treatment that looks like a GUI window. The "GUI window" could have its
 title set to <c:out value="${HUDFrameTitle}"/>
	 
--%>

<!-- HUD element enclosing table -->

<table cellpadding="0" cellspacing="0" border="0" class="outline" width="100%">
	<tr>
		<td>
			<table cellpadding="0" cellspacing="0" border="0" width="100%">
				<tr class="bgColor">
					<td class="portlet_title">
						<table cellpadding="0" cellspacing="0" border="0" width="100%">
							<tr>
								<td class="portlet_title_nobg"><c:out value="${param.HUDFrameTitle}"/></td>
								<c:if test="${!empty param.maximizeURL}">
									<td class="portlet_maximize"><a href="<c:out value="${param.maximizeURL}"/>"><img src="<c:out value="${jspStoreImgDir}" />images/maximize.gif" alt="<c:out value="${param.HUDFrameTitle}"/>" width="10" height="10" border="0"/></a></td>
								</c:if>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td class="portlet_shadow">&nbsp;</td>
	</tr>
	<tr>
		<td class="p_content">
			<table cellpadding="0" cellspacing="0" border="0" width="100%">
				<tr>
					<td class="portlet_content">
		  			<!-- HUD Content -->
		  	
<!-- END HUDContainerTop.jspf -->