<%--==========================================================================
Licensed Materials - Property of IBM

WebSphere Commerce

(c) Copyright IBM Corp.  2001, 2006
All Rights Reserved

US Government Users Restricted Rights - Use, duplication or
disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
===========================================================================--%>


<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../include/JSTLEnvironmentSetup.jspf" %>

<wcbase:useBean id="userReg" classname="com.ibm.commerce.user.beans.UserRegistrationDataBean"/>

<!-- BEGIN MiniUserAccountDisplay.jsp -->

<fmt:message key="Account_Heading1" var="HUDFrameTitle" bundle="${storeText}"/>
<c:url var="maximizeURL" value="UserAccountView">
	<c:param name="langId" value="${langId}" />
	<c:param name="storeId" value="${storeId}" />
	<c:param name="catalogId" value="${catalogId}" />
</c:url>
<% out.flush(); %>
<c:import url="${jspStoreDir}${StyleDir}HUDContainerTop.jsp" >
	<c:param name="HUDFrameTitle" value="${HUDFrameTitle}" />
	<c:param name="maximizeURL" value="${maximizeURL}" />
</c:import>
<% out.flush(); %>

<table cellpadding="0" cellspacing="0" border="0" width="100%" id="WC_MiniUserAccountDisplay_Table_1"><tbody>
	
	<tr><td class="portlet_content" id="WC_MiniUserAccountDisplay_TableCell_1">
		<fmt:message key="Logon_LoggedInAs" bundle="${storeText}"/>
	</td></tr>
	
	<tr><td class="portlet_content" id="WC_MiniUserAccountDisplay_TableCell_2">
		<strong>
			<c:choose>
				<c:when test="${locale == 'ja_JP' || locale == 'ko_KR' || locale == 'zh_CN' || locale == 'zh_TW'}">
					<c:out value="${userReg.personTitle}"/>
					<c:out value="${userReg.lastName}"/>
					<c:out value="${userReg.firstName}"/>
				</c:when>
				<c:otherwise>
					<c:out value="${userReg.personTitle}"/>
					<c:out value="${userReg.firstName}"/>
					<c:out value="${userReg.lastName}"/>
				</c:otherwise>
			</c:choose>
		</strong>
	</td></tr>
	
	<tr><td class="portlet_content" id="WC_MiniUserAccountDisplay_TableCell_3">
		<br/>
		<c:url var="userRegistrationFormURL" value="UserRegistrationForm">
			<c:param name="storeId"   value="${storeId}"  />
			<c:param name="catalogId" value="${catalogId}"/>
			<c:param name="langId" value="${langId}"/>
		</c:url>
		<a href="<c:out value="${userRegistrationFormURL}"/>" class="logon" id="WC_MiniUserAccountDisplay_Link_1">
			<fmt:message key="Account_Button1" bundle="${storeText}"/>
		</a><br/>
		<c:url var="addressBookFormURL" value="AddressBookForm">
			<c:param name="storeId"   value="${storeId}"  />
			<c:param name="catalogId" value="${catalogId}"/>
			<c:param name="langId" value="${langId}"/>
		</c:url>
		<a href="<c:out value="${addressBookFormURL}"/>" class="logon" id="WC_MiniUserAccountDisplay_Link_2">
			<fmt:message key="Account_Button2" bundle="${storeText}"/>
		</a>
	</td></tr>
	
</tbody></table>
<% out.flush(); %>
<c:import url="${jspStoreDir}${StyleDir}HUDContainerBottom.jsp" />
<% out.flush(); %>
<!-- END MiniUserAccountDisplay.jsp -->
