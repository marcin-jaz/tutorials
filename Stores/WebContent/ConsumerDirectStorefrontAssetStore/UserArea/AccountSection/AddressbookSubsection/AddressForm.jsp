<%--==========================================================================
Licensed Materials - Property of IBM

WebSphere Commerce

(c) Copyright IBM Corp.  2000, 2006, 2009
All Rights Reserved

US Government Users Restricted Rights - Use, duplication or
disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
===========================================================================--%>
<%-- 
  *****
  * This JSP is used for both adding and updating an address.
  * This page will display the address form with the following fields:
  *  - Nickname 
  *    (if the page is for adding address, the Nickname field will be an input box. Otherwise, the Nickname in the database will be displayed.
  *  - First name, Last name
  *  - Address Information 
  *   (i.e. Street address, City, State/Province, ZIP code/Postal Code, Country/Region, Phone number)
  *****
--%>

<!-- Start - JSP File Name:  AddressForm.jsp -->

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf" %>
<%@ include file="../../../include/nocache.jspf" %>
<%-- ErrorMessageSetup.jspf is used to retrieve an appropriate error message when there is an error --%>
<%@ include file="../../../include/ErrorMessageSetup.jspf" %>

<%--
  ***
  * If there is no error and there is no addressId (i.e. add address, instead of update address),
  * the entry fields will be pre-filled with the address information in the database.
  * The entry fields below use e.g. paramSource.nickName to get the previously entered value.
  * In this case, the paramSource is set to the AddressDataBean.
  * If there is an error, the page will refresh and the entry fields will be pre-filled with the previously entered value.
  * In the case of error, the paramSource is set to WCParam.  
  ***
--%>
<c:choose>
	<c:when test="${!empty WCParam.addressId && empty storeError.key && empty WCParam.reloadStates}">
		<wcbase:useBean id="address" classname="com.ibm.commerce.user.beans.AddressDataBean" />
		<c:set var="paramSource" value="${address}"/>
	</c:when>
	<c:otherwise>
		<c:set var="paramSource" value="${WCParam}"/>
	</c:otherwise>
</c:choose>

<c:choose>
	<c:when test="${empty WCParam.addressId}">
		<c:set var="title"><fmt:message key="ADD_ADDRESS" bundle="${storeText}"/></c:set>
	</c:when>
	<c:otherwise>
		<c:set var="title"><fmt:message key="UPDATE_ADDRESS2" bundle="${storeText}"/></c:set>
	</c:otherwise>
</c:choose>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html>
<head>
	<title><fmt:message key="ADDRESS_TITLE" bundle="${storeText}" /></title>
	<link rel="stylesheet" href='<c:out value="${jspStoreImgDir}${vfileStylesheet}"/>' type="text/css"/>
</head>

<script language="javascript" src='<c:out value="${jspStoreImgDir}"/>javascript/Util.js'></script>
<script language="javascript">
<%-- 
  ***
  * This javascript function is used by the address 'Submit' button.
  * It is used to ensure that the entered value does not exceed the maximum number of bytes allowed.
  * This function makes use of isValidUTF8length function.  Details about that function can be found in Util.js.
  ***
 --%>
function submitForm(form, reloadtype) {
 if (reloadtype == undefined) {
	<fmt:message key="ERROR_FirstNameTooLong" bundle="${storeText}" var="ERROR_FirstNameTooLong" />
	<fmt:message key="ERROR_LastNameTooLong" bundle="${storeText}" var="ERROR_LastNameTooLong" />
	<fmt:message key="ERROR_AddressTooLong" bundle="${storeText}" var="ERROR_AddressTooLong" />
	<fmt:message key="ERROR_CityTooLong" bundle="${storeText}" var="ERROR_CityTooLong" />
	<fmt:message key="ERROR_StateTooLong" bundle="${storeText}" var="ERROR_StateTooLong" />
	<fmt:message key="ERROR_CountryTooLong" bundle="${storeText}" var="ERROR_CountryTooLong" />
	<fmt:message key="ERROR_ZipCodeTooLong" bundle="${storeText}" var="ERROR_ZipCodeTooLong" />
	<fmt:message key="ERROR_PhoneTooLong" bundle="${storeText}" var="ERROR_PhoneTooLong" />

	if(!isValidUTF8length(form.address1.value     , 50 )) { alert(<wcf:json object="${ERROR_AddressTooLong}"/>); }
	else if(!isValidUTF8length(form.address2.value     , 50 )) { alert(<wcf:json object="${ERROR_AddressTooLong}"/>); }
	else if(!isValidUTF8length(form.city.value         , 128)) { alert(<wcf:json object="${ERROR_CityTooLong}"/>); }
	else if(!isValidUTF8length(form.state.value        , 128)) { alert(<wcf:json object="${ERROR_StateTooLong}"/>); }
	else if(!isValidUTF8length(form.country.value      , 128)) { alert(<wcf:json object="${ERROR_CountryTooLong}"/>); }
	else if(!isValidUTF8length(form.zipCode.value      , 40 )) { alert(<wcf:json object="${ERROR_ZipCodeTooLong}"/>); }
	else if(!isValidUTF8length(form.phone1.value       , 32 )) { alert(<wcf:json object="${ERROR_PhoneTooLong}"/>); }

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
 else
 {
   form.reloadStates.value='true';
   form.action='AddressForm';
	 form.submit();
 }	
}

function prepareSubmit(form)
{
	// submit the shipping address entered by the user
	if (!isValidUTF8length(form.address1.value, 50) 
	|| !isValidUTF8length(form.address2.value, 50))
	{
		<fmt:message key="ERROR_AddressTooLong" bundle="${storeText}" var="ERROR_AddressTooLong" />
		alert(<wcf:json object="${ERROR_AddressTooLong}"/>);
	}
	else
	{
		form.submit();
	}
}
</script>

	<body>
	<!-- JSP File Name:  AddressForm.jsp -->

	<%@ include file="../../../include/LayoutContainerTop.jspf"%>
	
		<!--MAIN CONTENT STARTS HERE-->
		<span class="heading"><c:out value="${title}"/></span>

		<table cellpadding="0" cellspacing="0" border="0" width="100%" id="WC_AddressForm_Table_1">
			<tr>
				<td class="t_td2" id="WC_AddressForm_TableCell_1">
				<%-- 
				  ***
				  *	Start: Error handling
				  * Show an appropriate error message when a user enters invalid information into the form.
				  ***
				--%>
				<c:if test="${!empty errorMessage}">
					<span class="error"><c:out value="${errorMessage}"/></span><br /><br />
				</c:if>
				<%-- 
				  ***
				  *	End: Error handling
				  ***
				--%>
				<c:if test="${empty WCParam.page}">
					<%-- If the customers does not come from the Select billing/shipping address page, one more text message is displayed --%>
					<fmt:message key="SHIPPING_ADDRESS" bundle="${storeText}" />
				</c:if>
				</td>
			</tr>
			<tr>
				<td class="t_td2" id="WC_AddressForm_TableCell_2">
					<span class="required">*</span><fmt:message key="REQUIRED_FIELDS" bundle="${storeText}" />
				</td>
			</tr>
			<tr>
				<td class="t_td2" id="WC_AddressForm_TableCell_3">
				<%-- 
				  ***
				  *	Start: Address Form
				  ***
				--%>
				<form name="AddressForm" method="post" action="AddressAdd" id="AddressForm">
				<input type="hidden" name="storeId" value='<c:out value="${WCParam.storeId}" />' id="WC_AddressForm_FormInput_storeId_In_AddressForm_1"/>
				<input type="hidden" name="langId" value='<c:out value="${CommandContext.languageId}" />' id="WC_AddressForm_FormInput_langId_In_AddressForm_1"/>
				<input type="hidden" name="catalogId" value='<c:out value="${WCParam.catalogId}"  />' id="WC_AddressForm_FormInput_catalogId_In_AddressForm_1"/>
				<input type="hidden" name="reloadStates" value="" id="WC_AddressForm_FormInput_reloadStates_In_AddressForm_1"/>
				<input type="hidden" name="authToken" value="${authToken}" id="WC_AddressForm_FormInput_authToken_1"/>
				<%--
				  ***
				  * Customers can click "Edit Address Book" from the Select shipping address page (checkout) to go to the Address Book page.
				  * If customers go to the Address book page from the Select shipping address page, the Address book displays a "Return to Checkout" and does not show the address "remove" button.
				  * "mode" parameter is used to check whether customers are coming from the Address book page with "Return to Checkout" button.
				  *
				  * Customers can click "Create new address" from the Select billing/shipping address page to go directly to this page.
				  * "page" parameter is used to check whether customers are coming directly from the Select billing/shipping address page.
				  * 
				  * The logic below determines where the customers are coming from, and sets the proper URL value accordingly.
				  ***
				--%>
				<c:choose>
					<c:when test="${!empty WCParam.returnView}">
						<%-- 
						Customers go to this page from a page that provided a returnView. 
						--%>
						<input type="hidden" name="URL" value="<c:out value="${WCParam.returnView}"/>" id="WC_AddressForm_FormInput_URL_In_AddressForm_1"/>
					</c:when>
					<c:when test="${WCParam.mode ne 'AddressBookReturnToCheckout' && WCParam.page eq 'shipaddress'}">
						<%-- 
						Customers go to this page from 'Select shipping address' page (checkout). 
						So, the proper URL value is set to go back to 'select shipping address' page after the address information is submitted.
						--%>
						<input type="hidden" name="URL" value="<flow:url exitPort='ActualAddressformPage.i1.xBackToCheckout'/>" id="WC_AddressForm_FormInput_URL_In_AddressForm_1"/>
					</c:when>
					<c:when test="${WCParam.page eq 'billingaddress'}">
						<%-- 
						Customers go to this page from 'Select billing address' page (checkout). 
						So, the proper URL value is set to go back to BillingAddressView page after the address information is submitted 
						--%>
						<input type="hidden" name="URL" value="BillingAddressView" id="WC_AddressForm_FormInput_URL_In_AddressForm_2"/>
					</c:when>
					<c:otherwise>
						<%-- Otherwise, the proper URL value is set to go back to Address Book page --%>
						<input type="hidden" name="URL" value="AddressBookForm" id="WC_AddressForm_FormInput_URL_In_AddressForm_3"/>
						<c:if test="${WCParam.mode eq 'AddressBookReturnToCheckout'}">
							<%-- Check whether the customers come from the Address book page which displays "Return to Checkout" button or from the normal Address book page --%>
							<input type="hidden" name="mode" value="AddressBookReturnToCheckout" id="WC_AddressForm_FormInput_mode_In_AddressForm_1"/>
						</c:if>
					</c:otherwise>
				</c:choose>
				<input type="hidden" name="returnView" value='<c:out value="${WCParam.returnView}"/>' id="WC_AddressForm_FormInput_page_In_AddressForm_1"/>
				<input type="hidden" name="page" value='<c:out value="${WCParam.page}"  />' id="WC_AddressForm_FormInput_page_In_AddressForm_1"/>
				<input type="hidden" name="orderId" value='<c:out value="${WCParam.orderId}"  />' id="WC_AddressForm_FormInput_orderId_In_AddressForm_1"/>
				<input type="hidden" name="addressType" value="SB" id="WC_AddressForm_FormInput_addressType_In_AddressForm_1"/><%-- 'R' stands for residential --%>
				<input type="hidden" name="primary" value="0" id="WC_AddressForm_FormInput_primary_In_AddressForm_1"/>

				<table class="t_table" id="WC_AddressForm_Table_2">
				<%--
				  ***
				  * Start: Address Form - Nick name field
				  *	If there is no addressId, the page is used for adding address, instead of updating address.
				  * If the page is for adding address, the nickName field is an input box.
				  * Otherwise, the nickname field in the database is displayed.
				  ***
				--%>
				<c:choose>
					<c:when test="${empty WCParam.addressId}">
					<tr>
						<td class="t_td2" colspan="2" id="WC_AddressForm_TableCell_4">
							<span class="required">*</span><label for="WC_AddressForm_FormInput_nickName_In_AddressForm_2"><fmt:message key="NICK_NAME" bundle="${storeText}" /></label>
						</td>
					</tr>
					<tr>
						<td id="WC_AddressForm_TableCell_5">
							<input class="input" size="35" maxlength="128" type="text" name="nickName" id="WC_AddressForm_FormInput_nickName_In_AddressForm_2" value="<c:out value="${paramSource.nickName}" />"/>
							&nbsp;
							<fmt:message key="NICKNAME_DESC" bundle="${storeText}"/>
						</td>
					</tr>
					</c:when>
					<c:otherwise>
					<tr>
						<td valign="middle" id="WC_AddressForm_TableCell_6">
						<input type="hidden" name="addressId" value="<c:out value="${paramSource.addressId}" />" id="WC_AddressForm_FormInput_addressId_In_AddressForm_1"/>
						<input type="hidden" name="nickName" value="<c:out value="${paramSource.nickName}" />" id="WC_AddressForm_FormInput_nickName_In_AddressForm_1"/>
							<fmt:message key="NICK_NAME" bundle="${storeText}" />
							<c:out value="${paramSource.nickName}" />
						</td>
					</tr>
					</c:otherwise>
				</c:choose>
				<%--
				  ***
				  * End: Address Form - Nick name field
				  ***
				--%>
				
				<c:set var="paramPrefix" value="" scope="request"/>
				<c:set var="pageName" value="AddressForm" scope="request"/>
				<c:set var="formName" value="document.AddressForm" scope="request"/>
				
					<%-- 
					  ***
					  *	Start: GiftRegistryCode
					  *
					  ***
					--%>	
					<flow:ifEnabled feature="GiftRegistry">
				
				<%@ include file="../../../Snippets/ReusableObjects/NameEntryFormDisplay.jspf" %>
				
				</flow:ifEnabled>
					<%-- 
					  ***
					  *	End: GiftRegistryCode
					  ***
					--%>				
				<%-- 
				  ***
				  *	Start: Address Form - First Name, Last Name, Address Information
				  * The layouts of these entry fields are different depending on the locale.
				  ***
				--%>
				<%@ include file="../../../Snippets/ReusableObjects/AddressEntryFormDisplay.jspf" %>
				<%-- 
				  ***
				  *	End: Address Form - First Name, Last Name, Address Information
				  ***
				--%>
				<tr>
					<td class="t_td2" id="WC_AddressForm_TableCell_8">
						<a href="javascript:submitForm(document.AddressForm)" class="button" id="WC_AddressForm_Link_1"><fmt:message key="SUBMIT" bundle="${storeText}" /></a>
					</td>
				</tr>
				</table>	
				</form>
				
				<%-- 
				  ***
				  *	End: Address Form
				  ***
				--%>

				</td>
			</tr>
		</table>
			
	<!--MAIN CONTENT ENDS HERE-->
		
	<%-- Hide CIP --%>
	<c:set var="HideCIP" value="true"/>

	<%@ include file="../../../include/LayoutContainerBottom.jspf"%>

	</body>
</html>

<!-- End - JSP File Name:  AddressForm.jsp -->
