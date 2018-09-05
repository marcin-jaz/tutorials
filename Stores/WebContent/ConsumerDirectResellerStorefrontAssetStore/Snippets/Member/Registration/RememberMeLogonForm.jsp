<%
//********************************************************************
//*-------------------------------------------------------------------
//* Licensed Materials - Property of IBM
//*
//* WebSphere Commerce
//*
//* (c) Copyright IBM Corp. 2000, 2002, 2004
//*
//* US Government Users Restricted Rights - Use, duplication or
//* disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
//*
//*-------------------------------------------------------------------
//*
//*---------------------------------------------------------------------
//* The sample contained herein is provided to you "AS IS".
//*
//* It is furnished by IBM as a simple example and has not been
//* thoroughly tested
//* under all conditions.  IBM, therefore, cannot guarantee its
//* reliability, serviceability or functionality.
//*
//* This sample may include the names of individuals, companies, brands
//* and products in order to illustrate concepts as completely as
//* possible.  All of these names
//* are fictitious and any similarity to the names and addresses used by
//* actual persons
//* or business enterprises is entirely coincidental.
//*---------------------------------------------------------------------
//*
%>
<%--
  ***
  * This RememberMeLogonForm.jsp is built as a sample JSP code snippet to display Logon form in a store page with following additional context:
  *
  *	- Remember Me check box
  *	- Logonid filled in when user is Remembered
  *	- URL propagation when user is Remembered
  *
  *     User can refer to LogonForm.jsp JSP code snippet for comparison on how the above entities are being added.
  *
  * Prerequisites:
  * 	These three parameters are required by this code:
  *		- storeId
  *		- catalogId
  *		- langId (language Id)
  *		these Ids needs to be passed in as it is required to build proper URL.
  *
  * How to use this snippet?
  *	This is an example of how this file could be included into a page:
  *		<c:import url="${jspStoreDir}include/RememberMeLogonForm.jsp">
  *			<c:param name="storeId" value="${WCParam.storeId}"/>
  *			<c:param name="catalogId" value="${WCParam.catalogId}"/>
  *			<c:param name="langId" value="${langId}"/>
  *		</c:import>
  ***
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf"%>

	<%-- 
	  ***
	  * Start: Remember Me Logon Form
	  *
	  * OrderItemMove is invoked after Logon because of the following situation:
	  * A guest shopper has a shopping cart and he/she logons as a registered shopper who already has another shopping cart.
	  * In this case, OrderItemMove is invoked to merge the order items in the two shopping carts because this store only supports one cart.
	  * OrderCalculate is invoked after OrderItemMove so that the mini-shopping cart subtotal in the sidebar is re-calculated after the items are merged.
	  ***
	--%>

	<c:url var="ForgetPasswordURL" value="Logoff">
		<c:param name="langId" value="${langId}" />
		<c:param name="storeId" value="${WCParam.storeId}" />
		<c:param name="catalogId" value="${WCParam.catalogId}" />
		<c:param name="state" value="forgetpassword" />
	</c:url>							
	
	<form method="post" name="Logon" action="Logon" id="Logon">
	<input type="hidden" name="storeId" value="<c:out value="${WCParam.storeId}"/>" id="WC_RememberMeLogonForm_FormInput_storeId_In_Logon_1"/>
	<input type="hidden" name="catalogId" value="<c:out value="${WCParam.catalogId}"/>" id="WC_RememberMeLogonForm_FormInput_catalogId_In_Logon_1"/>
	<input type="hidden" name="reLogonURL" value="LogonForm" id="WC_RememberMeLogonForm_FormInput_reLogonURL_In_Logon_1"/>
	<%-- The parameter 'personalizedCatalog' is used by LogonSetup.jsp --%>
	<input type="hidden" name="personalizedCatalog" value="true" id="WC_RememberMeLogonForm_FormInput_personalizedCatalog_In_Logon_1"/>
	<%-- the parameter 'fromOrderId', 'toOrderId', 'deleteIfEmpty', 'continue' and 'createIfEmpty' are used by the OrderItemMove command --%>
	<input type="hidden" name="fromOrderId" value="*" id="WC_RememberMeLogonForm_FormInput_fromOrderId_In_Logon_1"/>
	<input type="hidden" name="toOrderId" value="." id="WC_RememberMeLogonForm_FormInput_toOrderId_In_Logon_1"/>
	<input type="hidden" name="deleteIfEmpty" value="*" id="WC_RememberMeLogonForm_FormInput_deleteIfEmpty_In_Logon_1" />
	<input type="hidden" name="continue" value="1" id="WC_RememberMeLogonForm_FormInput_continue_In_Logon_1" />
	<input type="hidden" name="createIfEmpty" value="1" id="WC_RememberMeLogonForm_FormInput_createIfEmpty_In_Logon_1" />
	<%-- the parameter 'calculationUsageId' and 'updatePrices' are used by the OrderCalculate command --%>
	<input type="hidden" name="calculationUsageId" value="-1" id="WC_RememberMeLogonForm_FormInput_calculationUsageId_In_Logon_1" />
	<input type="hidden" name="updatePrices" value="1" id="WC_RememberMeLogonForm_FormInput_updatePrices_In_Logon_1"/>

	<input type="hidden" name="previousPage" value="logon" id="WC_RememberMeLogonForm_FormInput_previousPage_In_Logon_1"/>
	<input type="hidden" name="returnPage" value="${WCParam.returnPage}" id="WC_RememberMeLogonForm_FormInput_returnPage_In_Logon_1"/>
	<c:choose>
		<c:when test="${WCParam.returnPage eq 'quickcheckout'}">
			<c:url var="QuickCheckoutView" value="OrderCopy">
				<c:param name="URL" value="OrderPrepare?URL=QuickCheckoutSummaryView"/>
				<c:param name="orderId" value="."/>
				<c:param name="toOrderId" value="."/>
				<c:param name="shippingAddressFromOrderProfile" value="1"/>
				<c:param name="orderInfoFrom" value="q"/>
				<c:param name="payInfoFrom" value="q"/>
				<c:param name="langId" value="${langId}" />
				<c:param name="storeId" value="${WCParam.storeId}" />
				<c:param name="catalogId" value="${WCParam.catalogId}" />
				<c:param name="status" value="P" />	
				<c:param name="orderItemId*" value="" />
				<c:param name="quantity*" value="" />
				<c:param name="allocate" value="*" />
				<c:param name="reverse" value="*n" />
				<c:param name="backorder" value="*" />
				<c:param name="remerge" value="*" />
				<c:param name="merge" value="*n" />
				<c:param name="check" value="*n" />
				<c:param name="errorViewName" value="OrderCopyErrorView" /> 												
			</c:url>

			<c:url var="orderMove" value="OrderItemMove">
				<c:param name="URL" value="OrderCalculate?URL=${QuickCheckoutView}"/>
				<c:param name="page" value="account"/>
				<c:param name="fromOrderId" value="*"/>
				<c:param name="toOrderId" value="."/>
				<c:param name="deleteIfEmpty" value="*"/>
				<c:param name="continue" value="1"/>
				<c:param name="createIfEmpty" value="1"/>
				<c:param name="calculationUsageId" value="-1"/>
				<c:param name="updatePrices" value="1"/>
			</c:url>
			<input type="hidden" name="URL" value="<c:out value='${orderMove}' />" id="WC_RememberMeLogonForm_FormInput_URL_In_Logon_1" />
		</c:when>
		<c:otherwise>
			<c:choose>
				<c:when test="${!empty WCParam.URL}">
					<input type="hidden" name="URL" value="${WCParam.URL}" id="WC_RememberMeLogonForm_FormInput_URL_In_Logon_1" />
				</c:when>
				<c:otherwise>
					<input type="hidden" name="URL" value="OrderItemMove?page=account&amp;errorViewName=TopCategoriesDisplayView&amp;URL=OrderCalculate%3FURL%3DLogonForm" id="WC_RememberMeLogonForm_FormInput_URL_In_Logon_1" />
				</c:otherwise>
			</c:choose>
		</c:otherwise>
	</c:choose>

	<table cellpadding="0" cellspacing="0" border="0" width="100%" class="t_table" id="WC_RememberMeLogonForm_Table_1">
	<tbody><tr>
		<td class="t_td2" id="WC_RememberMeLogonForm_TableCell_1" colspan="2">
			<label for="WC_RememberMeLogonForm_FormInput_logonId_In_Logon_1">
				<fmt:message key="LOGON_ID" bundle="${storeText}" />
			</label>
		</td>
	</tr><tr>
		<td id="WC_RememberMeLogonForm_TableCell_2" colspan="2">

		<c:choose>
			<c:when test="${!empty param.logonId}">
			<input size="30" class="input" name="logonId" id="WC_RememberMeLogonForm_FormInput_logonId_In_Logon_1" value="<c:out value="${WCParam.logonId}" />"/>
			</c:when>
			<c:otherwise>
			<input size="30" class="input" name="logonId" value="" id="WC_RememberMeLogonForm_FormInput_logonId_In_Logon_1" />
			</c:otherwise>
		</c:choose>
		
		</td>
	</tr><tr>
		<td class="t_td2" id="WC_RememberMeLogonForm_TableCell_3">
			<label for="WC_RememberMeLogonForm_FormInput_logonPassword_In_Logon_1">
				<fmt:message key="PASSWORD2" bundle="${storeText}" />
			</label>
		</td>
		<td class="t_td_last" id="WC_RememberMeLogonForm_TableCell_31">
			<a href='<c:out value="${ForgetPasswordURL}" />' id="WC_RememberMeLogonForm_Link_31">
			<fmt:message key="FORGOT_YOUR_PASSWORD" bundle="${storeText}" /></a>
		</td>
	</tr><tr>
		<td id="WC_RememberMeLogonForm_TableCell_4" colspan="2">
			<input size="30" class="input" name="logonPassword" type="password" id="WC_RememberMeLogonForm_FormInput_logonPassword_In_Logon_1"/>
		</td>
	</tr><tr>
		<td class="t_td2" id="WC_RememberMeLogonForm_TableCell_5" colspan="2">
		<wcbase:isRemembered>
			<input type="checkbox" name="rememberMe" title="rememberMe"  value="true" id="WC_RememberMeLogonForm_FormInput_rememberMe_In_Logon_1" checked/><label for="WC_RememberMeLogonForm_FormInput_rememberMe_In_Logon_1"><fmt:message key="REMEMBER_ME" bundle="${storeText}" /></label>
		</wcbase:isRemembered>
		<wcbase:isNotRemembered>
			<input type="checkbox" name="rememberMe" title="rememberMe"  value="true" id="WC_RememberMeLogonForm_FormInput_rememberMe_In_Logon_1"/><label for="WC_RememberMeLogonForm_FormInput_rememberMe_In_Logon_1"><fmt:message key="REMEMBER_ME" bundle="${storeText}" /></label>
		</wcbase:isNotRemembered>
		</td>
	</tr>
	</tbody></table>
	<br/>

	<a href="javascript:document.Logon.submit()" class="button" id="WC_RememberMeLogonForm_Link_2">
		<fmt:message key="LOGIN" bundle="${storeText}" />
	</a>

	</form>
	<%-- 
	  ***
	  * End: Remember Me Logon Form
	  ***
	--%>
