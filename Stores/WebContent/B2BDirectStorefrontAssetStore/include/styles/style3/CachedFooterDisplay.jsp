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
  * This JSP page displays the Footer in all content pages that include the Layout Container JSP fragments.
  *****
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../JSTLEnvironmentSetup.jspf"%>

<!-- BEGIN CachedFooterDisplay.jsp -->

<!-- Add content here that you want as a common footer. -->
<table cellpadding="0" cellspacing="0" border="0" width="100%" height="100%" background="<c:out value="${jspStoreImgDir}${vfileColor}" />background.gif" id="WC_CachedHeadsUpDisplay_Table_1">
	<tr>
		<td width="209" id="WC_CachedFooterDisplay_TableCell_1"><img src="<c:out value="${jspStoreImgDir}${vfileColor}" />footer_curve.gif" alt="" width="209" height="33" border="0" id="WC_CachedFooterDisplay_Image_1"></td>
		<td class="footer_tile" id="WC_CachedFooterDisplay_TableCell_2"><img src="<c:out value="${jspStoreImgDir}${vfileColor}" />footer_tile.gif" alt="" width="213" height="33" border="0" id="WC_CachedFooterDisplay_Image_2"></td>
	</tr>
	<tr>
		<td colspan="2" class="footer_shadow" id="WC_CachedFooterDisplay_TableCell_3">&nbsp;</td>
	</tr>
	<tr><td height="20" id="WC_CachedFooterDisplay_TableCell_4">&nbsp;</td></tr>
</table>
<!-- END CachedFooterDisplay.jsp -->