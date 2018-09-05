<%--
/*
 *-------------------------------------------------------------------
 * Licensed Materials - Property of IBM
 *
 * WebSphere Commerce
 *
 * (c) Copyright International Business Machines Corporation. 2001-2004, 2009
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
  * This page displays the address form. It allows a user to add a new address
  * or update an existing addresss in the address book. An address consists of
  * the following information:
  *  - nickname
  *  - title
  *  - first name
  *  - last name
  *  - address
  *  - city
  *  - state/province
  *  - country/region
  *  - zip/postal code
  *****
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ taglib uri="flow.tld" prefix="flow" %>

<%@ include file="../../../include/JSTLEnvironmentSetup.jspf" %>
<%@ include file="../../../include/ErrorMessageSetup.jspf" %>

<c:choose>
	<c:when test="${empty WCParam.addressId}">
		<c:set var="title"><fmt:message key="AddAdd_Title" bundle="${storeText}"/></c:set>
		<c:set var="action" value="AddressAdd"/>
	</c:when>
	<c:otherwise>
		<c:set var="title"><fmt:message key="EditAdd_Title" bundle="${storeText}"/></c:set>
		<c:set var="action" value="AddressUpdate"/>
	</c:otherwise>
</c:choose>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><c:out value="${title}"/></title>
<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${vfileStylesheet}"/>" type="text/css"/>
<style type="text/css">
	form table tr {vertical-align: bottom}
</style>
</head>

<body class="noMargin">

<%@ include file="../../../include/LayoutContainerTop.jspf"%>

<script language="javascript" src="<c:out value="${jspStoreImgDir}javascript/Util.js"/>"></script>

<script language="javascript">

function submitForm(form) {
	<fmt:message key="Reg_ERROR_FirstNameTooLong" bundle="${storeText}" var="Reg_ERROR_FirstNameTooLong" />
	<fmt:message key="Reg_ERROR_LastNameTooLong" bundle="${storeText}" var="Reg_ERROR_LastNameTooLong" />
	<fmt:message key="Reg_ERROR_AddressTooLong" bundle="${storeText}" var="Reg_ERROR_AddressTooLong" />
	<fmt:message key="Reg_ERROR_CityTooLong" bundle="${storeText}" var="Reg_ERROR_CityTooLong" />
	<fmt:message key="Reg_ERROR_StateTooLong" bundle="${storeText}" var="Reg_ERROR_StateTooLong" />
	<fmt:message key="Reg_ERROR_CountryTooLong" bundle="${storeText}" var="Reg_ERROR_CountryTooLong" />
	<fmt:message key="Reg_ERROR_ZipCodeTooLong" bundle="${storeText}" var="Reg_ERROR_ZipCodeTooLong" />
	<fmt:message key="Reg_ERROR_PhoneTooLong" bundle="${storeText}" var="Reg_ERROR_PhoneTooLong" />

	if(!isValidUTF8length(form.firstName.value     , 50 )) { alert(<wcf:json object="${Reg_ERROR_FirstNameTooLong}"/>); }
	else if(!isValidUTF8length(form.lastName.value     , 50 )) { alert(<wcf:json object="${Reg_ERROR_LastNameTooLong}"/>); }
			
	else if(!isValidUTF8length(form.address1.value     , 50 )) { alert(<wcf:json object="${Reg_ERROR_AddressTooLong}"/>); }
	else if(!isValidUTF8length(form.address2.value     , 50 )) { alert(<wcf:json object="${Reg_ERROR_AddressTooLong}"/>); }
	else if(!isValidUTF8length(form.city.value         , 128)) { alert(<wcf:json object="${Reg_ERROR_CityTooLong}"/>); }
	else if(!isValidUTF8length(form.state.value        , 128)) { alert(<wcf:json object="${Reg_ERROR_StateTooLong}"/>); }
	else if(!isValidUTF8length(form.country.value      , 128)) { alert(<wcf:json object="${Reg_ERROR_CountryTooLong}"/>); }
	else if(!isValidUTF8length(form.zipCode.value      , 40 )) { alert(<wcf:json object="${Reg_ERROR_ZipCodeTooLong}"/>); }
	else if(!isValidUTF8length(form.phone1.value       , 32 )) { alert(<wcf:json object="${Reg_ERROR_PhoneTooLong}"/>); }

	else {
		//verify address fields #1-#2, if #2 is filled and not #1 then move the data for the user
		if (form.address1.value == "") {
			if (form.address2.value != "") {
				form.address1.value = form.address2.value;
				form.address2.value = "";
			}
		}

	 	form.submit();
	 }
}

</script>

<h1><c:out value="${title}"/></h1>

<table cellpadding="0" cellspacing="0" class="t_table" id="WC_AddressForm_Table_1">
	<tr>
		<td class="t_td2" id="WC_AddressForm_TableCell_1">
			<fmt:message key="AddAdd_Text1" bundle="${storeText}"/>
		</td>
	</tr>
	<tr>
		<td class="t_td2" id="WC_AddressForm_TableCell_2">
			<span class="required">*</span><fmt:message key="AddAdd_REQUIRED" bundle="${storeText}"/>
		</td>
	</tr>
	<tr>
		<td id="WC_AddressForm_TableCell_3">
			<c:if test="${!empty errorMessage}">
				<!-- storeError.key == <c:out value="${storeError.key}"/> -->
				<!-- <c:if test="${!empty invalidParamErrorKey}">invalidParamErrorKey == <c:out value="${invalidParamErrorKey}"/></c:if> -->
				<br /><span class="error"><c:out value="${errorMessage}"/></span>
			</c:if>
		</td>
	</tr>

<form name="AddressForm" method="post" action="<c:out value="${action}"/>" id="AddressForm">

<input type="hidden" name="storeId"   value="<c:out value="${WCParam.storeId}"  />"/>
<input type="hidden" name="catalogId" value="<c:out value="${WCParam.catalogId}"/>"/>
<input type="hidden" name="returnView" value="<c:out value="${WCParam.returnView}"/>"/>
<input type="hidden" name="authToken" value="${authToken}" id="WC_AddressForm_FormInput_authToken_1"/>

<c:choose>
	<c:when test="${!empty WCParam.returnView}">
		<input type="hidden" name="URL" value="<c:out value="${WCParam.returnView}"/>" id="WC_AddressForm_FormInput_URL_1"/>
		<input type="hidden" name="orderId" value="<c:out value="${WCParam.orderId}"/>" id="WC_AddressForm_FormInput_orderId_1"/>
		<input type="hidden" name="paymentMethod" value="<c:out value="${WCParam.paymentMethod}"/>" id="WC_AddressForm_FormInput_paymentMethod_1"/>
	</c:when>
	<c:when test="${WCParam.mode == 'AddressBookReturnToCheckout'}">
		<input type="hidden" name="URL" value="BillingShippingView" id="WC_AddressForm_FormInput_URL_1"/>
		<input type="hidden" name="orderId" value="<c:out value="${WCParam.orderId}"/>" id="WC_AddressForm_FormInput_orderId_1"/>
		<input type="hidden" name="paymentMethod" value="<c:out value="${WCParam.paymentMethod}"/>" id="WC_AddressForm_FormInput_paymentMethod_1"/>
	</c:when>
	<c:when test="${WCParam.page == 'shipaddress'}">
		<input type="hidden" name="URL" value="MultipleShippingAddressView" id="WC_AddressForm_FormInput_URL_1"/>
		<input type="hidden" name="orderId" value="<c:out value="${WCParam.orderId}"/>" id="WC_AddressForm_FormInput_orderId_1"/>
	</c:when>
	<c:otherwise>
		<input type="hidden" name="URL" value="AddressBookForm" id="WC_AddressForm_FormInput_URL_1"/>
	</c:otherwise>
</c:choose>

<input type="hidden" name="addressType" value="SB" id="WC_AddressForm_FormInput_addressType_1"/>
<input type="hidden" name="primary" value="0" id="WC_AddressForm_FormInput_primary_1"/>



<c:set var="paramPrefix" value="" scope="request"/>
<c:set var="pageName" value="AddressForm" scope="request"/>
<c:set var="formName" value="document.AddressForm" scope="request"/>

<c:choose>
	<c:when test="${!empty WCParam.addressId && empty storeError.key}">
		<wcbase:useBean id="address" classname="com.ibm.commerce.user.beans.AddressDataBean"/>
		<c:set var="paramSource" value="${address}" scope="request"/>
	</c:when>
	<c:otherwise>
		<c:set var="paramSource" value="${WCParam}" scope="request"/>
	</c:otherwise>
</c:choose>



<c:if test="${!empty WCParam.addressId}">
	<input type="hidden" name="addressId" value="<c:out value="${paramSource.addressId}"/>" id="WC_AddressForm_FormInput_addressId_1"/>
	<input type="hidden" name="nickName"  value="<c:out value="${paramSource.nickName}" />" id="WC_AddressForm_FormInput_nickName_1" />
</c:if>


<c:choose> 
	<c:when test="${empty WCParam.addressId}">
		<tr><td class="logonheading t_td2" id="WC_AddressForm_TableCell_5"><span class="required">*</span><label for="WC_AddressForm_FormInput_nickName_1"><span><fmt:message key="AddAdd_Nick" bundle="${storeText}"/></span></label></td></tr>
		<tr><td id="WC_AddressForm_TableCell_6"><input type="text" class="logon input" maxlength="53" size="35" name="nickName" value="<c:out value="${paramSource.nickName}"/>" id="WC_AddressForm_FormInput_nickName_1"/></td></tr>
	</c:when>
	<c:otherwise>
		<tr><td class="t_td2" colspan="3" id="WC_AddressForm_TableCell_7"><strong><fmt:message key="AddAdd_Nick" bundle="${storeText}"/></strong> <c:out value="${paramSource.nickName}"/></td></tr>
	</c:otherwise>
</c:choose>


<%--
  ***
  *	Start: User name section
  ***
--%>
<%@ include file="../../../Snippets/ReusableObjects/NameEntryFormDisplay.jspf" %>
<%--
  ***
  *	End: User name section
  ***
--%>

<%--
  ***
  *	Start: Address section
  ***
--%>
<%@ include file="../../../Snippets/ReusableObjects/AddressEntryFormDisplay.jspf" %>
<%--
  ***
  *	End: Address section
  ***
--%>

</form>

<tr><td class="t_td2" id="WC_AddressForm_TableCell_8">
<c:if test="${!empty WCParam.returnView}">
	<c:url value="${WCParam.returnView}" var="returnViewURL">
		<c:param name="storeId" value="${WCParam.storeId}"/>
		<c:param name="catalogId" value="${WCParam.catalogId}"/>
		<c:if test="${!empty WCParam.orderId}">
			<c:param name="orderId" value="${WCParam.orderId}"/>
		</c:if>
		<c:if test="${!empty WCParam.paymentMethod}">
			<c:param name="paymentMethod" value="${WCParam.paymentMethod}"/>
		</c:if>
	</c:url>
	<a href="<c:out value="${returnViewURL}"/>" class="button" id="WC_AddressForm_Link_1a">
		<fmt:message key="AddAdd_Previous" bundle="${storeText}"/>
	</a>
	&nbsp;
</c:if>
<a href="javascript:submitForm(document.AddressForm)" class="button" id="WC_AddressForm_Link_1">
	<fmt:message key="AddAdd_Submit" bundle="${storeText}"/>
</a>
</td></tr>

</table>

<%@ include file="../../../include/LayoutContainerBottom.jspf"%>

</body>

</html>
