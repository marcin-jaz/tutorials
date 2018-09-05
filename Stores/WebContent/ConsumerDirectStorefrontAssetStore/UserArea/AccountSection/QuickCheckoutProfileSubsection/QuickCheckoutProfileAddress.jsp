<%--
/*
 *-------------------------------------------------------------------
 * Licensed Materials - Property of IBM
 *
 * WebSphere Commerce
 *
 * (c) Copyright International Business Machines Corporation.
 *     2006
 *     All rights reserved.
 *
 * US Government Users Restricted Rights - Use, duplication or
 * disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
 *
 *-------------------------------------------------------------------
 */
--%> 

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf" %>

<%-- 
  ***
  *	Start: default billing address
  ***
--%>

<td>
<input type="hidden" name="addressType" value="SB" id="WC_QuickCheckoutProfileForm_FormInput_addressType_In_QuickCheckout_1"/>
<input type="hidden" name="primary" value="0" id="WC_QuickCheckoutProfileForm_FormInput_primary_In_QuickCheckout_1"/>
<input type="hidden" name="reloadStates" value="" id="WC_QuickCheckoutProfileForm_FormInput_reloadStates_In_QuickCheckout_1"/>

<c:choose>
	<c:when test="${!empty billingAddressInfoMap.addressId}">
		<input type="hidden" name="billing_addressId" value="<c:out value="${billingAddressInfoMap.addressId}"/>" id="WC_QuickCheckoutProfileForm_FormInput_billing_addressId_In_QuickCheckout_1"/>
		<c:if test="${!empty billingAddressInfoMap.nickName}">
			<input type="hidden" name="billing_nickName" value="<c:out value="${billingAddressInfoMap.nickName}"/>" id="WC_QuickCheckoutProfileForm_FormInput_billing_nickName_In_QuickCheckout_2"/>
		</c:if>
	</c:when>
	<c:otherwise>
		<input type="hidden" name="billing_nickName" value="<c:out value="${'Default_Billing_'}${WCParam.storeId}"/>" id="WC_QuickCheckoutProfileForm_FormInput_billing_nickName_In_QuickCheckout_2"/>
	</c:otherwise>
</c:choose>

	<table cellpadding="0" cellspacing="0" border="0" width="392" id="WC_QuickCheckoutProfileForm_Address_Table_1">
	<tbody><tr>
		<td valign="top" class="subHeading" id="WC_QuickCheckoutProfileForm_Address_TableCell_1">
			<fmt:message key="UPDATE_BILLINGADDRESS" bundle="${storeText}"/>
		</td>
	</tr>
	<tr><td>&nbsp;</td></tr>
	<tr><td>
	<table>
	<c:set var="paramSource" value="${billingAddressInfoMap}" />
	<%-- <c:set var="inputNamePrefix" value="billing_" /> --%>
	<c:set var="paramPrefix" value="billing_" />
	<c:set var="pageName" value="QuickCheckoutProfileForm"/>
	<c:set var="formName" value="document.QuickCheckout"/>
	<%@ include file="../../../Snippets/ReusableObjects/AddressEntryFormDisplay.jspf"%>
	</table>
	</td></tr>
	</tbody></table>
</td>

<%-- 
  ***
  *	End: default billing address
  ***
--%>

<%-- 
  ***
  *	Start: default shipping address
  ***
--%>

<td>
<c:choose>
	<c:when test="${!empty shippingAddressInfoMap.addressId}">
		<input type="hidden" name="shipping_addressId" value="<c:out value="${shippingAddressInfoMap.addressId}"/>" id="WC_QuickCheckoutProfileForm_FormInput_shipping_addressId_In_QuickCheckout_1"/>
		<c:if test="${!empty shippingAddressInfoMap.nickName}">
			<input type="hidden" name="shipping_nickName" value="<c:out value="${shippingAddressInfoMap.nickName}"/>" id="WC_QuickCheckoutProfileForm_FormInput_shipping_nickName_In_QuickCheckout_2"/>
		</c:if>
	</c:when>
	<c:otherwise>
		<input type="hidden" name="shipping_nickName" value="<c:out value="${'Default_Shipping_'}${WCParam.storeId}"/>" id="WC_QuickCheckoutProfileForm_FormInput_shipping_nickName_In_QuickCheckout_2"/>
	</c:otherwise>
</c:choose>
	
	<table cellpadding="0" cellspacing="0" border="0" width="392" id="WC_QuickCheckoutProfileForm_Address_Table_2">
	<tbody><tr>
		<td valign="top" class="subHeading" id="WC_QuickCheckoutProfileForm_Address_TableCell_2">
			<fmt:message key="UPDATE_SHIPPINGADDRESS" bundle="${storeText}"/>
		</td>
	</tr>	
	
	<%-- 
	  ***
	  *	Start: same as billing address checkbox
	  ***
	--%>
	<tr>
		<td align="left" valign="middle" id="WC_QuickCheckoutProfileForm_TableCell_71">
			<input class="checkbox" type="checkbox" name="sameaddress" onclick="copyBillingForm(document.QuickCheckout)" id="WC_QuickCheckoutProfileForm_FormInput_sameaddress_In_QuickCheckout_1"/>
			<label for="WC_QuickCheckoutProfileForm_FormInput_sameaddress_In_QuickCheckout_1"><fmt:message key="SAMEASBILLING" bundle="${storeText}"/></label>
		</td>
	</tr>
	<%-- 
	  ***
	  *	End: same as billing address checkbox
	  ***
	--%>
	
	<tr><td>
	<table>
	<c:set var="paramSource" value="${shippingAddressInfoMap}" />
	<%-- <c:set var="inputNamePrefix" value="shipping_" /> --%>
	<c:set var="paramPrefix" value="shipping_" />
	<c:set var="pageName" value="QuickCheckoutProfileForm"/>
	<c:set var="formName" value="document.QuickCheckout"/>
	<%@ include file="../../../Snippets/ReusableObjects/AddressEntryFormDisplay.jspf"%>
	</table>
	</td></tr>
	</tbody></table>
</td>
<%-- 
  ***
  *	End: default shipping address
  ***
--%>

