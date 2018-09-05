<%--==========================================================================
Licensed Materials - Property of IBM

WebSphere Commerce

(c) Copyright IBM Corp.  2006
All Rights Reserved

US Government Users Restricted Rights - Use, duplication or
disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
===========================================================================--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../JSTLEnvironmentSetup.jspf"%>

<wcbase:useBean id="userReg" classname="com.ibm.commerce.user.beans.UserRegistrationDataBean"/>
<wcbase:useBean id="entitledOrgs" classname="com.ibm.commerce.user.beans.OrganizationListDataBean">
<c:set target="${entitledOrgs}" property="accountCheck" value="true"/>
</wcbase:useBean>

<wcbase:useBean id="entitledContracts" classname="com.ibm.commerce.user.beans.ContractListDataBean">
	<c:set target="${entitledContracts}" property="commandContext" value="${CommandContext}"/>
</wcbase:useBean>

<c:set var="activeOrgId" value="${CommandContext.activeOrganizationId}"/>

<fmt:message key="Account_Title" var="HUDFrameTitle" bundle="${storeText}"/>
<c:set var="maximizeURL" value=""/>
<% out.flush(); %>
<c:import url="${jspStoreDir}${StyleDir}HUDContainerTop.jsp" >
	<c:param name="HUDFrameTitle" value="${HUDFrameTitle}" />
	<c:param name="maximizeURL" value="${maximizeURL}" />
</c:import>
<% out.flush(); %>

<table cellpadding="0" cellspacing="0" border="0" width="100%" id="WC_MiniActiveOrganizationDisplay_Table_0"><tbody>
	
	<tr><td colspan="2" height="5" id="WC_MiniActiveOrganizationDisplay_TableCell_1"></td></tr>
	
	<tr>
		<td class="portlet_content" id="WC_MiniActiveOrganizationDisplay_TableCell_2">
			<fmt:message key="MinActiveOrganizationDisplay_UserName" bundle="${storeText}" />
		</td>
		<td class="portlet_content" id="WC_MiniActiveOrganizationDisplay_TableCell_3">
			<strong>
				<c:out value="${userReg.firstName}"/>
				<c:out value="${userReg.lastName}"/>
			</strong>
		</td>
	</tr>
	<flow:ifEnabled feature="HUDminiOrganizationIdDisplay">
		<tr><td colspan="2" height="5" id="WC_MiniActiveOrganizationDisplay_TableCell_4"></td></tr>
		<form name="OrganizationSetInSessionForm" id="OrganizationSetInSessionForm" action="OrganizationSetInSession" method="get">
			<input type="hidden" name="storeId"   value="<c:out value="${storeId}"/>" id="WC_MiniActiveOrganizationDisplay_FormInput_storeId_In_OrganizationSetInSessionForm_1"/>
			<input type="hidden" name="catalogId" value="<c:out value="${catalogId}"/>" id="WC_MiniActiveOrganizationDisplay_FormInput_catalogId_In_OrganizationSetInSessionForm_1"/>
			<input type="hidden" name="URL"       value="TopCategoriesDisplay" id="WC_MiniActiveOrganizationDisplay_FormInput_url_In_OrganizationSetInSessionForm_1"/>
			<tr>
				<td class="portlet_content" valign="middle" id="WC_MiniActiveOrganizationDisplay_TableCell_5">
					<label for="WC_MiniActiveOrganizationDisplay_FormInput_activeOrgId_In_OrganizationSetInSessionForm_1">
					<fmt:message key="MinActiveOrganizationDisplay_ActiveOrg" bundle="${storeText}" />
					</label>
				</td>
				<td class="portlet_content" id="WC_MiniActiveOrganizationDisplay_TableCell_6">
					<select name="activeOrgId" onchange="document.OrganizationSetInSessionForm.submit()" id="WC_MiniActiveOrganizationDisplay_FormInput_activeOrgId_In_OrganizationSetInSessionForm_1">
						<c:forEach items="${entitledOrgs.entitledOrganizations}" var="entitledOrg">
							<c:set var="entitledOrgId" value="${entitledOrg.organizationIdInEJBType}"/>
							<option value="<c:out value="${entitledOrgId}"/>"<c:if test="${entitledOrgId == activeOrgId}"> selected="selected"</c:if>>
								<c:out value="${entitledOrg.organizationName}"/>
							</option>
						</c:forEach>
					</select>
				</td>
			</tr>
		</form>
	</flow:ifEnabled>

<flow:ifEnabled feature="HUDminiOrganizationContractsDisplay">
	<tr><td colspan="2" height="5" id="WC_MiniActiveOrganizationDisplay_TableCell_7"></td></tr>
	<form name="ContractSetInSessionForm" id="ContractSetInSessionForm" action="ContractSetInSession" method="get">
		<input type="hidden" name="storeId"   value="<c:out value="${storeId}"/>" id="WC_MiniActiveOrganizationDisplay_FormInput_storeId_In_ContractSetInSessionForm_1"/>
		<input type="hidden" name="catalogId" value="<c:out value="${catalogId}"/>" id="WC_MiniActiveOrganizationDisplay_FormInput_catalogId_In_ContractSetInSessionForm_1"/>
		<input type="hidden" name="URL"       value="TopCategoriesDisplay" id="WC_MiniActiveOrganizationDisplay_FormInput_url_In_ContractSetInSessionForm_1"/>
		<tr>
			<td class="portlet_content" valign="top" id="WC_MiniActiveOrganizationDisplay_TableCell_8">
				<label for="WC_MiniActiveOrganizationDisplay_FormInput_contractId_In_ContractSetInSessionForm_1">
				<fmt:message key="MinActiveOrganizationDisplay_EligibleContracts" bundle="${storeText}" />
				</label>
			</td>
			<td class="portlet_content" id="WC_MiniActiveOrganizationDisplay_TableCell_9">
				<select name="contractId"  multiple="multiple" size="5" id="WC_MiniActiveOrganizationDisplay_FormInput_contractId_In_ContractSetInSessionForm_1">
						<c:forEach items="${entitledContracts.contracts}" var="entitledContract">
							<option value="<c:out value="${entitledContract.key}"/>">
								<c:out value="${entitledContract.value}"/>
							</option>
						</c:forEach>
				</select>
			</td>
		</tr>
	</form>
</flow:ifEnabled>
	
</tbody></table>
<% out.flush(); %>
<c:import url="${jspStoreDir}${StyleDir}HUDContainerBottom.jsp" />
<% out.flush(); %>
