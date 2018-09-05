<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2008, 2009 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>
<%--
  *****
  * This JSP file displays the address page of the checkout flow. It is a page that only shows for guest users
  * that do not have an address created yet. It that allows shoppers to create both a shipping and a billing
  * address on the same page.
  *****
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../include/JSTLEnvironmentSetup.jspf"%>
<%@ include file="../../include/nocache.jspf"%>


<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/UserArea/MyAccountServicesDeclaration.js"/>"></script>
<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/UserArea/AddressBookForm.js"/>"></script>
<script type="text/javascript" src="<c:out value='${jsAssetsDir}javascript/UserArea/AddressHelper.js'/>"></script>
<script type="text/javascript">
	dojo.addOnLoad(function() {
		MyAccountServicesDeclarationJS.setCommonParameters('<c:out value='${langId}'/>','<c:out value='${WCParam.storeId}'/>','<c:out value='${WCParam.catalogId}'/>');

		<fmt:message key="ERROR_RecipientTooLong" bundle="${storeText}" var="ERROR_RecipientTooLong" />
		<fmt:message key="ERROR_FirstNameTooLong" bundle="${storeText}" var="ERROR_FirstNameTooLong" />
		<fmt:message key="ERROR_LastNameTooLong" bundle="${storeText}" var="ERROR_LastNameTooLong" />
		<fmt:message key="ERROR_AddressTooLong" bundle="${storeText}" var="ERROR_AddressTooLong" />
		<fmt:message key="ERROR_CityTooLong" bundle="${storeText}" var="ERROR_CityTooLong" />
		<fmt:message key="ERROR_StateTooLong" bundle="${storeText}" var="ERROR_StateTooLong" />
		<fmt:message key="ERROR_CountryTooLong" bundle="${storeText}" var="ERROR_CountryTooLong" />
		<fmt:message key="ERROR_ZipCodeTooLong" bundle="${storeText}" var="ERROR_ZipCodeTooLong" />
		<fmt:message key="ERROR_EmailTooLong" bundle="${storeText}" var="ERROR_EmailTooLong" />
		<fmt:message key="ERROR_PhoneTooLong" bundle="${storeText}" var="ERROR_PhoneTooLong" />
		<fmt:message key="ERROR_RecipientEmpty" bundle="${storeText}" var="ERROR_RecipientEmpty" />
		<fmt:message key="ERROR_LastNameEmpty" bundle="${storeText}" var="ERROR_LastNameEmpty" />
		<fmt:message key="ERROR_AddressEmpty" bundle="${storeText}" var="ERROR_AddressEmpty" />
		<fmt:message key="ERROR_CityEmpty" bundle="${storeText}" var="ERROR_CityEmpty" />
		<fmt:message key="ERROR_StateEmpty" bundle="${storeText}" var="ERROR_StateEmpty" />
		<fmt:message key="ERROR_CountryEmpty" bundle="${storeText}" var="ERROR_CountryEmpty" />
		<fmt:message key="ERROR_ZipCodeEmpty" bundle="${storeText}" var="ERROR_ZipCodeEmpty" />
		<fmt:message key="ERROR_EmailEmpty" bundle="${storeText}" var="ERROR_EmailEmpty" />
		<fmt:message key="ERROR_FirstNameEmpty" bundle="${storeText}" var="ERROR_FirstNameEmpty" />
		<fmt:message key="ERROR_INVALIDEMAILFORMAT" bundle="${storeText}" var="ERROR_INVALIDEMAILFORMAT" />
		<fmt:message key="ERROR_INVALIDPHONE" bundle="${storeText}" var="ERROR_INVALIDPHONE" />
		
		MessageHelper.setMessage("ERROR_RecipientTooLong", <wcf:json object="${ERROR_RecipientTooLong}"/>);
		MessageHelper.setMessage("ERROR_FirstNameTooLong", <wcf:json object="${ERROR_FirstNameTooLong}"/>);
		MessageHelper.setMessage("ERROR_LastNameTooLong", <wcf:json object="${ERROR_LastNameTooLong}"/>);
		MessageHelper.setMessage("ERROR_AddressTooLong", <wcf:json object="${ERROR_AddressTooLong}"/>);
		MessageHelper.setMessage("ERROR_CityTooLong", <wcf:json object="${ERROR_CityTooLong}"/>);
		MessageHelper.setMessage("ERROR_StateTooLong", <wcf:json object="${ERROR_StateTooLong}"/>);
		MessageHelper.setMessage("ERROR_CountryTooLong", <wcf:json object="${ERROR_CountryTooLong}"/>);
		MessageHelper.setMessage("ERROR_ZipCodeTooLong", <wcf:json object="${ERROR_ZipCodeTooLong}"/>);
		MessageHelper.setMessage("ERROR_EmailTooLong", <wcf:json object="${ERROR_EmailTooLong}"/>);
		MessageHelper.setMessage("ERROR_PhoneTooLong", <wcf:json object="${ERROR_PhoneTooLong}"/>);
		MessageHelper.setMessage("ERROR_RecipientEmpty", <wcf:json object="${ERROR_RecipientEmpty}"/>);
		MessageHelper.setMessage("ERROR_LastNameEmpty", <wcf:json object="${ERROR_LastNameEmpty}"/>);
		MessageHelper.setMessage("ERROR_AddressEmpty", <wcf:json object="${ERROR_AddressEmpty}"/>);
		MessageHelper.setMessage("ERROR_CityEmpty", <wcf:json object="${ERROR_CityEmpty}"/>);
		MessageHelper.setMessage("ERROR_StateEmpty", <wcf:json object="${ERROR_StateEmpty}"/>);
		MessageHelper.setMessage("ERROR_CountryEmpty", <wcf:json object="${ERROR_CountryEmpty}"/>);
		MessageHelper.setMessage("ERROR_ZipCodeEmpty", <wcf:json object="${ERROR_ZipCodeEmpty}"/>);
		MessageHelper.setMessage("ERROR_EmailEmpty", <wcf:json object="${ERROR_EmailEmpty}"/>);
		MessageHelper.setMessage("ERROR_FirstNameEmpty", <wcf:json object="${ERROR_FirstNameEmpty}"/>);
		MessageHelper.setMessage("ERROR_INVALIDEMAILFORMAT", <wcf:json object="${ERROR_INVALIDEMAILFORMAT}"/>);
		MessageHelper.setMessage("ERROR_INVALIDPHONE", <wcf:json object="${ERROR_INVALIDPHONE}"/>);
	});
</script>


<wcf:url var="TopCategoriesDisplayURL" value="TopCategories1">
  <wcf:param name="langId" value="${langId}" />
  <wcf:param name="storeId" value="${WCParam.storeId}" />
  <wcf:param name="catalogId" value="${WCParam.catalogId}" />
</wcf:url>

<c:set var="catalogId" value="${WCParam.catalogId}"/>
<wcf:url var="OrderCalculateURL" value="OrderShippingBillingView">
  <wcf:param name="langId" value="${langId}" />						
  <wcf:param name="storeId" value="${WCParam.storeId}" />
  <wcf:param name="catalogId" value="${WCParam.catalogId}" />
  <wcf:param name="shipmentType" value="single" />
</wcf:url>

<wcf:url var="ShoppingCartURL" value="OrderCalculate" type="Ajax">
   <wcf:param name="langId" value="${langId}" />
  <wcf:param name="storeId" value="${WCParam.storeId}" />
  <wcf:param name="catalogId" value="${WCParam.catalogId}" />
  <wcf:param name="URL" value="AjaxOrderItemDisplayView" />
  <wcf:param name="errorViewName" value="AjaxOrderItemDisplayView" />
  <wcf:param name="updatePrices" value="1" />
  <wcf:param name="calculationUsageId" value="-1" />
  <wcf:param name="orderId" value="." />
</wcf:url>

<wcf:url var="MyAccountURL" value="AjaxLogonFormCenterLinksDisplayView">
  <wcf:param name="langId" value="${langId}" />
  <wcf:param name="storeId" value="${WCParam.storeId}" />
  <wcf:param name="catalogId" value="${WCParam.catalogId}" />
</wcf:url>


	
	
	<div id="content_wrapper">
		<div id="box">
			<div class="contentgrad_header" id="WC_UnregisteredCheckout_div_5">
				 <div class="left_corner" id="WC_UnregisteredCheckout_div_6"></div>
				 <div class="left" id="WC_UnregisteredCheckout_div_7"></div>
				 <div class="right_corner" id="WC_UnregisteredCheckout_div_8"></div>
			</div>
			
			<div class="body" id="WC_UnregisteredCheckout_div_9">
				 <div id="unregistered_form">

				<div class="col1_bill" id="WC_UnregisteredCheckout_div_10">
					<h1><fmt:message key="UC_BILLINGADDRESS" bundle="${storeText}"/></h1>
				</div>
								   
				<div class="col2_ship" id="WC_UnregisteredCheckout_div_11">
					<h1><fmt:message key="UC_SHIPPINGADDRESS" bundle="${storeText}"/></h1>
				</div>
				<div class="col1_bill" id="billingCreateEditArea1">
				<br/>

			   <c:set var="formName" value="billingAddressCreateEditFormDiv_1"/>
				<form id="billingAddressCreateEditFormDiv_1" name="billingAddressCreateEditFormDiv_1">
					<input type="hidden" name="storeId" value="<c:out value="${storeId}" />" id="WC_UnregisteredCheckout_inputs_1"/>
					<input type="hidden" name="catalogId" value="<c:out value="${catalogId}" />" id="WC_UnregisteredCheckout_inputs_2"/>
					<input type="hidden" name="langId" value="<c:out value="${langId}" />" id="WC_UnregisteredCheckout_inputs_3"/>
					<input type="hidden" name="status" value="Billing" id="WC_UnregisteredCheckout_inputs_4"/>
					<input type="hidden" name="addressType" value="Billing" id="WC_UnregisteredCheckout_inputs_5"/>
					<input type="hidden" name="authToken" value="${authToken}" id="WC_UnregisteredCheckout_inputs_authToken_billing" />

					<c:set var="formName" value="billingAddressCreateEditFormDiv_1" />
					<c:set var="divNum" value="1"/>
					<c:set var="stateDivName1" value="${paramPrefix}stateDiv${divNum}"/>
					<fmt:message key="BILL_BILLING_ADDRESS" bundle="${storeText}" var="address"/>
					<br/>
					<br/>
					
					<%-- 
						1. The hidden field "AddressForm_FieldsOrderByLocale" is to set all the mandatory fields AND the order of the fields
						that are going to be displayed in each locale-dependent address form, so that the JavaScript
						used for validation knows which fields to validate and in which order it should validate them.
						2. Mandatory fields use UPPER CASE, non-mandatory fields use lower case.
					--%>
					<c:choose>
						<c:when test="${locale == 'zh_CN'}">
							<%@ include file="../../Snippets/ReusableObjects/UnregisteredCheckoutAddressEntryForm_CN.jspf"%>
							<input type="hidden" id="AddressForm_FieldsOrderByLocale" value="NICK_NAME,LAST_NAME,first_name,COUNTRY/REGION,STATE/PROVINCE,CITY,ADDRESS,ZIP,phone1,EMAIL1"/>
						</c:when>
						<c:when test="${locale == 'zh_TW'}">
							<%@ include file="../../Snippets/ReusableObjects/UnregisteredCheckoutAddressEntryForm_TW.jspf"%>
							<input type="hidden" id="AddressForm_FieldsOrderByLocale" value="NICK_NAME,LAST_NAME,first_name,COUNTRY/REGION,STATE/PROVINCE,CITY,ZIP,ADDRESS,phone1,EMAIL1"/>
						</c:when>
						<c:when test="${locale == 'ru_RU'}">
							<%@ include file="../../Snippets/ReusableObjects/UnregisteredCheckoutAddressEntryForm_RU.jspf"%>
							<input type="hidden" id="AddressForm_FieldsOrderByLocale" value="NICK_NAME,first_name,middle_name,LAST_NAME,ADDRESS,ZIP,CITY,state/province,COUNTRY/REGION,phone1,EMAIL1"/>
						</c:when>
						<c:when test="${locale == 'ja_JP' || locale == 'ko_KR'}">
							<%@ include file="../../Snippets/ReusableObjects/UnregisteredCheckoutAddressEntryForm_JP_KR.jspf"%>
							<input type="hidden" id="AddressForm_FieldsOrderByLocale" value="NICK_NAME,LAST_NAME,FIRST_NAME,COUNTRY/REGION,ZIP,STATE/PROVINCE,CITY,ADDRESS,phone1,EMAIL1"/>
						</c:when>
						<c:when test="${locale == 'de_DE' || locale == 'es_ES' || locale == 'fr_FR' || locale == 'it_IT' || locale == 'ro_RO'}">
							<%@ include file="../../Snippets/ReusableObjects/UnregisteredCheckoutAddressEntryForm_DE_ES_FR_IT_RO.jspf"%>
							<input type="hidden" id="AddressForm_FieldsOrderByLocale" value="NICK_NAME,first_name,LAST_NAME,ADDRESS,ZIP,CITY,state/province,COUNTRY/REGION,phone1,EMAIL1"/>
						</c:when>
						<c:when test="${locale == 'pl_PL'}">
							<%@ include file="../../Snippets/ReusableObjects/UnregisteredCheckoutAddressEntryForm_PL.jspf"%>
							<input type="hidden" id="AddressForm_FieldsOrderByLocale" value="NICK_NAME,first_name,LAST_NAME,ADDRESS,ZIP,CITY,STATE/PROVINCE,COUNTRY/REGION,phone1,EMAIL1"/>
						</c:when>
						<c:otherwise>
							<%@ include file="../../Snippets/ReusableObjects/UnregisteredCheckoutAddressEntryForm.jspf"%>
							<input type="hidden" id="AddressForm_FieldsOrderByLocale" value="NICK_NAME,first_name,LAST_NAME,ADDRESS,CITY,COUNTRY/REGION,STATE/PROVINCE,ZIP,phone1,EMAIL1"/>
						</c:otherwise>
					</c:choose>
					<br />
					<br />
				</form>
			</div>

			<div class="col2_ship" id="shippingCreateEditArea1">
					<div class="label_spacer" id="WC_UnregisteredCheckout_div_12">
						<span class="same_as_billing_checkbox">
							<label for="SameShippingAndBillingAddress">
								<img src="<c:out value='${jspStoreImgDir}'/>images/empty.gif" alt="<fmt:message key="SHIP_SHIPPING_ADDRESS" bundle="${storeText}"/>"/>
								<img src="<c:out value='${jspStoreImgDir}'/>images/empty.gif" alt="<fmt:message key="UC_SAME" bundle="${storeText}"/>"/>
							</label>
						</span>
						<input class="checkbox" type="checkbox" name="SameShippingAndBillingAddress" onclick="JavaScript:AddressBookFormJS.copyBillingFormNew('billingAddressCreateEditFormDiv_1','shippingAddressCreateEditFormDiv_1');" id="SameShippingAndBillingAddress"/>
						<span class="unregisteredCheckbox">
							<fmt:message key="UC_SAME" bundle="${storeText}"/>
						</span>
					</div>
				<c:set var="formName" value="shippingAddressCreateEditFormDiv_1"/>


				<form id="shippingAddressCreateEditFormDiv_1" name="shippingAddressCreateEditFormDiv_1">                                 <br />
					<input type="hidden" name="storeId" value="<c:out value="${storeId}" />" id="WC_UnregisteredCheckout_inputs_6"/>
					<input type="hidden" name="catalogId" value="<c:out value="${catalogId}" />" id="WC_UnregisteredCheckout_inputs_7"/>
					<input type="hidden" name="langId" value="<c:out value="${langId}" />" id="WC_UnregisteredCheckout_inputs_8"/>
					<input type="hidden" name="status" value="Shipping" id="WC_UnregisteredCheckout_inputs_9"/>
					<input type="hidden" name="addressType" value="Shipping" id="WC_UnregisteredCheckout_inputs_10"/>
					<input type="hidden" name="authToken" value="${authToken}" id="WC_UnregisteredCheckout_inputs_authToken_shipping" />
					
					<c:set var="formName" value="shippingAddressCreateEditFormDiv_1" />
					<c:set var="divNum" value="2"/>
					<c:set var="stateDivName2" value="${paramPrefix}stateDiv${divNum}"/>
					<fmt:message key="SHIP_SHIPPING_ADDRESS" bundle="${storeText}" var="address"/>

					<%-- 
						1. The hidden field "AddressForm_FieldsOrderByLocale" is to set all the mandatory fields AND the order of the fields
						that are going to be displayed in each locale-dependent address form, so that the JavaScript
						used for validation knows which fields to validate and in which order it should validate them.
						2. Mandatory fields use UPPER CASE, non-mandatory fields use lower case.
					--%>
					<c:choose>
						<c:when test="${locale == 'zh_CN'}">
							<%@ include file="../../Snippets/ReusableObjects/UnregisteredCheckoutAddressEntryForm_CN.jspf"%>
							<input type="hidden" id="AddressForm_FieldsOrderByLocale1" value="NICK_NAME,LAST_NAME,first_name,COUNTRY/REGION,STATE/PROVINCE,CITY,ADDRESS,ZIP,phone1,EMAIL1"/>
						</c:when>
						<c:when test="${locale == 'zh_TW'}">
							<%@ include file="../../Snippets/ReusableObjects/UnregisteredCheckoutAddressEntryForm_TW.jspf"%>
							<input type="hidden" id="AddressForm_FieldsOrderByLocale1" value="NICK_NAME,LAST_NAME,first_name,COUNTRY/REGION,STATE/PROVINCE,CITY,ZIP,ADDRESS,phone1,EMAIL1"/>
						</c:when>
						<c:when test="${locale == 'ru_RU'}">
							<%@ include file="../../Snippets/ReusableObjects/UnregisteredCheckoutAddressEntryForm_RU.jspf"%>
							<input type="hidden" id="AddressForm_FieldsOrderByLocale1" value="NICK_NAME,first_name,middle_name,LAST_NAME,ADDRESS,ZIP,CITY,state/province,COUNTRY/REGION,phone1,EMAIL1"/>
						</c:when>
						<c:when test="${locale == 'ja_JP' || locale == 'ko_KR'}">
							<%@ include file="../../Snippets/ReusableObjects/UnregisteredCheckoutAddressEntryForm_JP_KR.jspf"%>
							<input type="hidden" id="AddressForm_FieldsOrderByLocale1" value="NICK_NAME,LAST_NAME,FIRST_NAME,COUNTRY/REGION,ZIP,STATE/PROVINCE,CITY,ADDRESS,phone1,EMAIL1"/>
						</c:when>
						<c:when test="${locale == 'de_DE' || locale == 'es_ES' || locale == 'fr_FR' || locale == 'it_IT' || locale == 'ro_RO'}">
							<%@ include file="../../Snippets/ReusableObjects/UnregisteredCheckoutAddressEntryForm_DE_ES_FR_IT_RO.jspf"%>
							<input type="hidden" id="AddressForm_FieldsOrderByLocale1" value="NICK_NAME,first_name,LAST_NAME,ADDRESS,ZIP,CITY,state/province,COUNTRY/REGION,phone1,EMAIL1"/>
						</c:when>
						<c:when test="${locale == 'pl_PL'}">
							<%@ include file="../../Snippets/ReusableObjects/UnregisteredCheckoutAddressEntryForm_PL.jspf"%>
							<input type="hidden" id="AddressForm_FieldsOrderByLocale1" value="NICK_NAME,first_name,LAST_NAME,ADDRESS,ZIP,CITY,STATE/PROVINCE,COUNTRY/REGION,phone1,EMAIL1"/>
						</c:when>
						<c:otherwise>
							<%@ include file="../../Snippets/ReusableObjects/UnregisteredCheckoutAddressEntryForm.jspf"%>
							<input type="hidden" id="AddressForm_FieldsOrderByLocale1" value="NICK_NAME,first_name,LAST_NAME,ADDRESS,CITY,COUNTRY/REGION,STATE/PROVINCE,ZIP,phone1,EMAIL1"/>
						</c:otherwise>
					</c:choose>
			
				</form>
			</div>							
			<br/>
			<br/>
		</div>
		<br clear="all" />
	</div>

	<div class="content_footer" id="WC_UnregisteredCheckout_div_13">
		<div class="left_corner" id="WC_UnregisteredCheckout_div_14"></div>
		<div class="left" id="WC_UnregisteredCheckout_div_15">
			<div class="unregistered" id="WC_UnregisteredCheckout_div_16">	
					<div class="left" id="WC_UnregisteredCheckout_div_22">
						<span class="secondary_button button_fit" >
							<span class="button_container">
								<span class="button_bg">
									<span class="button_top">
										<span class="button_bottom">   
											<a href="<c:out value="${ShoppingCartURL}"/>" id="WC_UnregisteredCheckout_links_3">
												<fmt:message key="UC_BACK" bundle="${storeText}"/>
											</a>
										</span>
									</span>	
								</span>
							</span>
						</span>	
					</div>
					<div class="sixpixels"></div>
					<div class="left" id="WC_UnregisteredCheckout_div_23">
						<span class="primary_button button_fit" >
							<span class="button_container">
								<span class="button_bg">
									<span class="button_top">
										<span class="button_bottom">   
											<a href="JavaScript:setCurrentId('WC_UnregisteredCheckout_links_4'); AddressHelper.saveUnregisteredCheckoutAddress('billingAddressCreateEditFormDiv_1', 'shippingAddressCreateEditFormDiv_1', '<c:out value='${stateDivName1}'/>', '<c:out value='${stateDivName2}'/>');" id="WC_UnregisteredCheckout_links_4">
												<fmt:message key="UC_NEXT" bundle="${storeText}"/>
											</a>
							
										</span>
									</span>	
								</span>
							</span>
						</span>	
					</div>
					<div class="button_side_message" id="WC_UnregisteredCheckout_div_24">
						<fmt:message key="UC_NEXTSTEP" bundle="${storeText}"/>
					</div>
			</div>
		</div>
		<div class="right_corner" id="WC_UnregisteredCheckout_div_21"></div>
	</div>
</div>
</div>
	

