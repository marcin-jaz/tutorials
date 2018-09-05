<%--
/*
 *-------------------------------------------------------------------
 * Licensed Materials - Property of IBM
 *
 * WebSphere Commerce
 *
 * (c) Copyright International Business Machines Corporation. 2001-2004
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
  * This page displays the user name/address section of the registration
  * forms.
  *****
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>

<%@ include file="../../../include/JSTLEnvironmentSetup.jspf" %>
<%@ include file="../../../include/ErrorMessageSetup.jspf" %>



<%--
  ***
  *	Start: User name section
  ***
--%>
<c:choose>
	<c:when test="${locale == 'ja_JP' || locale == 'ko_KR'}">
		<%@ include file="NameEntryForm_JP_KR.jspf" %>
	</c:when>
	<c:when test="${locale == 'zh_CN' || locale == 'zh_TW'}">
		<%@ include file="NameEntryForm_CN_TW.jspf" %>
	</c:when>
	<c:otherwise>
		<%@ include file="NameEntryForm.jspf" %>
	</c:otherwise>
</c:choose>
<%--
  ***
  *	End: User name section
  ***
--%>



<%--
  ***
  *	Start: User address section
  ***
--%>
<c:choose>
	<c:when test="${locale == 'ja_JP' || locale == 'ko_KR'}">
		<%@ include file="AddressEntryForm_JP_KR.jspf" %>
	</c:when>
	<c:when test="${locale == 'zh_CN'}">
		<%@ include file="AddressEntryForm_CN.jspf" %>
	</c:when>
	<c:when test="${locale == 'zh_TW'}">
		<%@ include file="AddressEntryForm_TW.jspf" %>
	</c:when>
	<c:when test="${locale == 'de_DE' || locale == 'es_ES' || locale == 'fr_FR' || locale == 'it_IT'}">
		<%@ include file="AddressEntryForm_DE_ES_FR_IT.jspf" %>
	</c:when>
	<c:otherwise>
		<%@ include file="AddressEntryForm.jspf" %>
	</c:otherwise>
</c:choose>
<%--
  ***
  *	End: User address section
  ***
--%>
