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
  * This JSP fragment displays the bottom and right portion of the main content container.
  * This is an example of how this file could be included into a page: 
  * <c:import url="${jspStoreDir}${StyleDir}ContentContainerBottom.jsp">
  *		<c:param name="frameTitle" value="${frameTitle}" />
  *	</c:import>
  *****
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../JSTLEnvironmentSetup.jspf"%>

<!-- BEGIN ContentContainerBottom.jsp -->

<!-- This file is empty. Add content here that you want as a common wrapper for your main content. -->

<%-- 

 A JSTL page scoped variable 'frameTitle' is passed in if you set it in your content page before
 including 'LayoutContainerBottom.jspf'. You can use it to enhance this wrapper decoration.
 
 For example a graphical treatment that looks like a GUI window. The "GUI window" could have its
 title mentioned in an under hanging tab using <c:out value="${frameTitle}"/>
	 
--%>

					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>

<!-- END ContentContainerBottom.jsp -->