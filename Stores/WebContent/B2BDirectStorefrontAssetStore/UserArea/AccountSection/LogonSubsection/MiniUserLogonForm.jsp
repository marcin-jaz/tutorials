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
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf"%>

<!-- BEGIN MiniUserLogonForm.jsp -->	
<c:choose>
<c:when test="${userType != 'G'}">
	<% out.flush(); %>
	<c:import url="${jspStoreDir}UserArea/AccountSection/MiniUserAccountDisplay.jsp"/>
	<% out.flush(); %>
</c:when>	
<c:otherwise>	

<c:forTokens items="${requestScope.requestURIPath}" delims="/" var="URLtoken">
	<c:set var="ReloadURL" value="${URLtoken}"/>
</c:forTokens>
<c:url var="ReloadWithParametersURL" value="${ReloadURL}">
	<c:forEach var="parameter" items="${WCParamValues}" >
		<c:if test="${parameter.key != 'logonPassword'}">
			<c:param name="${parameter.key}">
				<c:forEach var="value" items="${parameter.value}" >
					<c:out value="${value}" />
				</c:forEach>
			</c:param>
		</c:if>
	</c:forEach>
</c:url>

<fmt:message key="Logon_Title" var="HUDFrameTitle" bundle="${storeText}"/>
<c:url var="maximizeURL" value="LogonForm">
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

<table cellpadding="0" cellspacing="0" border="0" width="100%" id="WC_MiniUserLogonForm_Table_1"><tbody>	
	<tr>
		<td class="portlet_content" id="WC_MiniUserLogonForm_TableCell_1">
			<form name="MiniUserLogonForm" action="Logon" method="post" id="WC_MiniUserLogonForm_Form_1">
				<table cellpadding="0" cellspacing="0" border="0" width="100%" id="WC_MiniUserLogonForm_Table_2">
					<tr>
						<td class="portlet_content" id="WC_MiniUserLogonForm_TableCell_2">
							<label for="WC_MiniUserLogonForm_Form_1_Input_logonId"><fmt:message key="Logon_UserID" bundle="${storeText}"/></label>:
						</td>
						<td class="portlet_content" id="WC_MiniUserLogonForm_TableCell_3">
							<input type="text" name="logonId" size="10" class="logon" id="WC_MiniUserLogonForm_Form_1_Input_logonId"/>
						</td>
					</tr>
					
					<tr>
						<td class="portlet_content" id="WC_MiniUserLogonForm_TableCell_4">
							<label for="WC_MiniUserLogonForm_Form_1_Input_logonId"><fmt:message key="Logon_Password" bundle="${storeText}"/></label>:
						</td>
						<td class="portlet_content" id="WC_MiniUserLogonForm_Tablecell_5">
							<input type="password" autocomplete="off" name="logonPassword" size="10" class="logon" id="WC_MiniUserLogonForm_Form_1_Input_logonId"/>
						</td>
					</tr>
				</table>
			<c:url var="resetPasswordFormURL" value="ResetPasswordForm">
				<c:param name="storeId" value="${storeId}"/>
				<c:param name="catalogId" value="${catalogId}"/>
				<c:param name="langId" value="${langId}"/>
			</c:url>
			<a href="<c:out value="${resetPasswordFormURL}"/>" class="logon" id="WC_MiniUserLogonForm_Link_1">
				<fmt:message key="Logon_Forgot" bundle="${storeText}"/>
			</a>
			<br/><br/>
			<input type="hidden" name="storeId" value="<c:out value="${storeId}"/>" id="WC_MiniUserLogonForm_Form_1_Input_storeId"/>
			<input type="hidden" name="catalogId" value="<c:out value="${catalogId}"/>" id="WC_MiniUserLogonForm_Form_1_Input_catalogId"/>
			<input type="hidden" name="langId" value="<c:out value="${langId}"/>" id="WC_MiniUserLogonForm_Form_1_Input_langId"/>
			<input type="hidden" name="URL" value="<c:out value="${ReloadWithParametersURL}"/>" id="WC_MiniUserLogonForm_Form_1_Input_URL"/>
			<input type="hidden" name="reLogonURL" value="LogonForm" id="WC_MiniUserLogonForm_FormInput_reLogonURL_In_Logon_1"/>
			<a href="javascript:document.MiniUserLogonForm.submit()" class="portlet_button" id="WC_MiniUserLogonForm_Link_2">
				<fmt:message key="Logon_Submit" bundle="${storeText}"/>
			</a>
			<br/><br/>
			<c:url var="userRegistrationFormURL" value="UserRegistrationForm">
				<c:param name="storeId" value="${storeId}"/>
				<c:param name="catalogId" value="${catalogId}"/>
				<c:param name="langId" value="${langId}"/>
				<c:param name="new" value="Y"/>
			</c:url>
			<a href="<c:out value="${userRegistrationFormURL}"/>" class="logon" id="WC_MiniUserLogonForm_Link_3">
				<fmt:message key="Logon_RegisterUser" bundle="${storeText}"/>
			</a>
			<br/>
			<c:url var="organizationRegistrationAddFormURL" value="OrganizationRegistrationAddForm">
				<c:param name="storeId" value="${storeId}"/>
				<c:param name="catalogId" value="${catalogId}"/>
				<c:param name="langId" value="${langId}"/>
				<c:param name="new" value="Y"/>
			</c:url>
			<a href="<c:out value="${organizationRegistrationAddFormURL}"/>" class="logon" id="WC_MiniUserLogonForm_Link_4">
				<fmt:message key="Logon_RegisterOrganization" bundle="${storeText}"/>
			</a>
			</form>
		</td>
	</tr>
<%-- DISPLAY ERROR MESSAGES --%>
<%-- 
	Uncomment the following if you want to use a normal page as the reLogonURL
 	instead of the LogonForm. This will display any logon related error messages on the
 	current page. You will need to change the reLogonURL in the logon form above to
 	"TopCategoriesDisplay" or another unregistered-user friendly view.
--%>
<%--
	<c:if test="${!empty errorMessage}">
		<tr>
			<td class="warning" id="WC_MiniUserLogonForm_TableCell_2xz">
				<c:out value="${errorMessage}" />
			</td>	
		</tr>
	</c:if>
--%>
</tbody></table>
<% out.flush(); %>
<c:import url="${jspStoreDir}${StyleDir}HUDContainerBottom.jsp" />
<% out.flush(); %>
	</c:otherwise>
</c:choose>

<!-- END MiniUserLogonForm.jsp -->
