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
  * This JSP fragment displays the bottom and right portion of the Configurable Store Display portlet.
  *****
--%>
<!-- BEGIN HUDContainerBottom.jspf -->

<%-- 

 A JSTL page scoped variable 'HUDFrameTitle' is passed in if you set it in your content page before
 including 'HUDContainerBottom.jspf'. You can use it to enhance this wrapper decoration.
 
 For example a graphical treatment that looks like a GUI window. The "GUI window" could have its
 title mentioned in an under hanging tab using <c:out value="${HUDFrameTitle}"/>
	 
--%>
     	  <!-- /HUD Content -->
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>

<!-- /HUD element enclosing table -->

<!-- END HUDContainerBottom.jspf -->