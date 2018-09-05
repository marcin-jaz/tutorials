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
<%@ page import="com.ibm.commerce.member.facade.client.MemberFacadeClient" %>
<%@ page import="com.ibm.commerce.member.facade.datatypes.PersonType" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf" %>
<%@ include file="../../../include/nocache.jspf" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>             
<%@ include file="../../../include/ErrorMessageSetup.jspf" %>
<c:set var="myAccountPage" value="true" scope="request"/>

<wcbase:useBean id="countryBean" classname="com.ibm.commerce.user.beans.CountryStateListDataBean">
	<c:set target="${countryBean}" property="countryCode" value="${contact.address.country}"/>
</wcbase:useBean>

<wcf:getData var="person" type="com.ibm.commerce.member.facade.datatypes.PersonType" expressionBuilder="findCurrentPerson">
	<wcf:param name="accessProfile" value="IBM_All" />
</wcf:getData>
<c:set var="addressBookBean" value="${person.addressBook}"/>
<c:choose>
		<c:when test="${empty WCParam.selectedAddress}">
			<c:set var="selectedAddress" value="${person.contactInfo.contactInfoIdentifier.uniqueID}"/>
		</c:when>
		<c:otherwise>
			<c:set var="selectedAddress" value="${WCParam.selectedAddress}"/>
		</c:otherwise>
</c:choose>

<%-- validate the selected address...it may be the scenario that the address has been deleted 
     in this case just default to the primary address --%>
<c:set var="foundSelectedAddress" value="false"/>
<c:set var="defaultAddress" value="${person.contactInfo.contactInfoIdentifier.uniqueID}"/>
<c:choose>
	<c:when test="${selectedAddress == person.contactInfo.contactInfoIdentifier.uniqueID}">
		<c:set var="foundSelectedAddress" value="true"/>
	</c:when>
</c:choose>								
<c:if test="${!foundSelectedAddress}" >
	<c:forEach items="${addressBookBean.contact}" var="contact" varStatus="status">
		<%-- Do not show the special addresses used for quick checkout profile --%>
		<c:if test="${ contact.contactInfoIdentifier.externalIdentifier.contactInfoNickName != profileShippingNickname && contact.contactInfoIdentifier.externalIdentifier.contactInfoNickName != profileBillingNickname }" >
			<c:if test="${selectedAddress == contact.contactInfoIdentifier.uniqueID}">
				<c:set var="foundSelectedAddress" value="true"/>
			</c:if>
		</c:if>
	</c:forEach>
</c:if>
<c:if test="${!foundSelectedAddress}">
	<c:set var="selectedAddress" value="${defaultAddress}"/>
</c:if>

<div id="box">
	<div class="my_account" id="WC_AjaxAddressBookForm_div_1">
		<div class="main_header" id="WC_AjaxAddressBookForm_div_2">
			 <div class="left_corner" id="WC_AjaxAddressBookForm_div_3"></div>
			 <div class="left" id="WC_AjaxAddressBookForm_div_4"><span class="main_header_text"><fmt:message key="ADDRESSBOOK_TITLE" bundle="${storeText}"/></span></div>
			 <div class="right_corner" id="WC_AjaxAddressBookForm_div_5"></div>
		</div>	
		<div class="content_header" id="WC_AjaxAddressBookForm_div_6">
			<div class="left_corner" id="WC_AjaxAddressBookForm_div_7"></div>
			<div class="addrbook_header" id="WC_AjaxAddressBookForm_div_8"><label for="addressId"></label>
				<select width="10" name="addressId" id="addressId" onchange="JavaScript:MessageHelper.hideAndClearMessage();AddressBookFormJS.showFooter();
				wc.render.updateContext('addressBookContext', {'addressId':this.options[this.selectedIndex].value,'type':'edit'});" style="width:180px" class="drop_down">
					<%-- Make sure the seleted address is displayed --%>
					<c:choose>
						<c:when test="${selectedAddress == person.contactInfo.contactInfoIdentifier.uniqueID}">
							<option selected="selected" value="<c:out value="${person.contactInfo.contactInfoIdentifier.uniqueID}"/>">
								<c:out value="${person.contactInfo.contactInfoIdentifier.externalIdentifier.contactInfoNickName}"/>
							</option>
							<c:set var="selectedContact" value="${person.contactInfo}"/>
						</c:when>
						<c:otherwise>
							<option value="<c:out value="${person.contactInfo.contactInfoIdentifier.uniqueID}"/>">
								<c:out value="${person.contactInfo.contactInfoIdentifier.externalIdentifier.contactInfoNickName}"/>
							</option>
						</c:otherwise>
					</c:choose>
						
					<c:forEach items="${addressBookBean.contact}" var="contact" varStatus="status">
						<%-- Do not show the special addresses used for quick checkout profile --%>
						<c:if test="${ contact.contactInfoIdentifier.externalIdentifier.contactInfoNickName != profileShippingNickname && contact.contactInfoIdentifier.externalIdentifier.contactInfoNickName != profileBillingNickname }" >
							<%-- Make sure the seleted address is displayed --%>
							<c:choose>
								<c:when test="${selectedAddress == contact.contactInfoIdentifier.uniqueID}">
									<option selected="selected" value="<c:out value="${contact.contactInfoIdentifier.uniqueID}"/>">
										<c:out value="${contact.contactInfoIdentifier.externalIdentifier.contactInfoNickName}"/>
									</option>
									<c:set var="selectedContact" value="${contact}"/>
								</c:when>
								<c:otherwise>
									<option value="<c:out value="${contact.contactInfoIdentifier.uniqueID}"/>">
										<c:out value="${contact.contactInfoIdentifier.externalIdentifier.contactInfoNickName}"/>
									</option>
								</c:otherwise>
							</c:choose>
						</c:if>
					</c:forEach>
				</select>
				
				<c:set var="contact" value="${person.contactInfo}"/>
				<wcf:url var="AddressFormCreateURL" value="AjaxAccountAddressForm" type="Ajax">
					<wcf:param name="storeId"   value="${WCParam.storeId}"  />
					<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
					<wcf:param name="langId" value="${langId}" />
					<c:if test="${! empty WCParam.returnView}">
						<wcf:param name="returnView" value="${WCParam.returnView}"/>
						<wcf:param name="orderId" value="${WCParam.orderId}"   />
					</c:if>
					<c:if test="${WCParam.mode == 'AddressBookReturnToCheckout'}">
						<wcf:param name="mode" value="AddressBookReturnToCheckout"/>
						<wcf:param name="page" value="shipaddress"/>
						<wcf:param name="orderId" value="${WCParam.orderId}"/>
					</c:if>
				</wcf:url>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div><div class="addrbook_header" id="WC_AjaxAddressBookForm_div_22">
				<span class="secondary_button button_fit" id="WC_AjaxAddressBookForm_div_9">
					<span class="button_container">
						<span class="button_bg">
							<span class="button_top">
								<span class="button_bottom">   
									<a href="JavaScript:MessageHelper.hideAndClearMessage();AddressBookFormJS.showFooterNew();wc.render.updateContext('addressBookContext', {'addressId':'empty','type':'add'});"  id="WC_AjaxAddressBookForm_links_1">
										<fmt:message key="AB_ADDNEW" bundle="${storeText}"/>
									</a>
								</span>
							</span>	
						</span>
					</span>
				</span>	
						
				<wcf:url var="addressBookFormURL1" value="AjaxAddressBookForm" type="Ajax">
					<wcf:param name="storeId"   value="${WCParam.storeId}"  />
					<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
					<wcf:param name="langId" value="${WCParam.langId}" />
				</wcf:url>
				<wcf:url var="AddressDeleteURL" value="AjaxPersonChangeServiceAddressDelete">
					<wcf:param name="storeId"   value="${WCParam.storeId}"  />
					<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
					<wcf:param name="langId" value="${WCParam.langId}" />
					<wcf:param name="URL" value="${addressBookFormURL1}"/>
				</wcf:url>
				<span class="secondary_button button_fit" id="WC_AjaxAddressBookForm_div_11">
					<span class="button_container">
						<span class="button_bg">
							<span class="button_top">
								<span class="button_bottom">   
									<a href="#" onclick="javascript:setCurrentId('WC_AjaxAddressBookForm_links_2'); AddressBookFormJS.newDeleteAddress('addressId','<c:out value="${AddressDeleteURL}" />','<c:out value="${addressBookFormURL1}"/>'); return false;"  id="WC_AjaxAddressBookForm_links_2" waistate:controls="addressId">
										<fmt:message key="REMOVE" bundle="${storeText}"/>
									</a>
								</span>
							</span>	
						</span>
					</span>
				</span>	

			</div>
			<div class="right_corner" id="WC_AjaxAddressBookForm_div_13"></div>
			<br/>
			
		</div>					
		
		
		<div dojoType="wc.widget.RefreshArea" widgetId="addressId" objectId="addressId" controllerId="addressBookController" class="body" id="addressIdRefreshArea" role="wairole:region" waistate:live="polite" waistate:atomic="false" waistate:relevant="all">
		<c:set var="final" value="${contact}"/>
		<jsp:include page="../AddressbookSubsection/AccountForm.jsp" flush="true">
			<jsp:param name="addressId" value="${final.contactInfoIdentifier.uniqueID}" />
			<jsp:param name="nickName" value="${final.contactInfoIdentifier.externalIdentifier.contactInfoNickName}" />
			<jsp:param name="firstName" value="${final.contactName.firstName}"/>
			<jsp:param name="lastName" value="${final.contactName.lastName}"/>
			<jsp:param name="middleName" value="${final.contactName.middleName}"/>
			<jsp:param name="address1" value="${final.address.addressLine[0]}"/>
			<jsp:param name="address2" value="${final.address.addressLine[1]}"/>
			<jsp:param name="city" value="${final.address.city}"/>
			<jsp:param name="state" value="${final.address.stateOrProvinceName}"/>
			<jsp:param name="countryReg" value="${final.address.country}"/>
			<jsp:param name="zipCode" value="${final.address.postalCode}"/>
			<jsp:param name="phone" value="${final.telephone1.value}"/>
			<jsp:param name="email1" value="${final.emailAddress1.value}"/>
			<jsp:param name="addressType" value="${final.address.type_}"/>
		</jsp:include>
		</div>
		<script type="text/javascript">dojo.addOnLoad(function() { parseWidget("addressId"); } );</script>
		
		<wcf:url var="addressBookFormURL" value="AjaxAddressBookForm" type="Ajax">
						<wcf:param name="storeId"   value="${param.storeId}"  />
						<wcf:param name="catalogId" value="${param.catalogId}"/>
						<wcf:param name="langId" value="${langId}" />
		</wcf:url>
		<div class="content_footer" id="content_footer">
			<div class="left_corner" id="WC_AjaxAddressBookForm_div_15"></div>
			<div class="button_footer_line" id="WC_AjaxAddressBookForm_div_16">
					<wcf:url var="addressBookFormURL" value="AjaxAddressBookForm" type="Ajax">
						<wcf:param name="storeId"   value="${param.storeId}"  />
						<wcf:param name="catalogId" value="${param.catalogId}"/>
						<wcf:param name="langId" value="${langId}" />
					</wcf:url>
					<span class="primary_button button_fit" id="WC_AjaxAddressBookForm_div_19">
						<span class="button_container">
							<span class="button_bg">
								<span class="button_top">
									<span class="button_bottom">   
										<a href="#" onclick="javascript:setCurrentId('WC_AjaxAddressBookForm_links_4'); AddressBookFormJS.updateAddress('AddressForm', '<c:out value="${addressBookFormURL}"/>'); return false;"  id="WC_AjaxAddressBookForm_links_4">
											<fmt:message key="UPDATE" bundle="${storeText}"/>
										</a>
									</span>
								</span>	
							</span>
						</span>
					</span>	
			</div>
			<div class="right_corner" id="WC_AjaxAddressBookForm_div_21"></div>			
		</div>		
		<div class="content_footer" id="addnew_content_footer" style="display:none">
			<div class="left_corner" id="WC_AjaxAddressBookForm_div_15a"></div>
			<div class="button_footer_line" id="WC_AjaxAddressBookForm_div_16a">
					<wcf:url var="addressBookFormURL" value="AjaxAddressBookForm" type="Ajax">
						<wcf:param name="storeId"   value="${param.storeId}"  />
						<wcf:param name="catalogId" value="${param.catalogId}"/>
						<wcf:param name="langId" value="${langId}" />
					</wcf:url>
					<span class="primary_button button_fit" id="WC_AjaxAddressBookForm_div_19_1">
						<span class="button_container">
							<span class="button_bg">
								<span class="button_top">
									<span class="button_bottom">   
										<a href="#" onclick="javascript:setCurrentId('WC_AjaxAddressBookForm_links_4a'); AddressBookFormJS.newUpdateAddressBook('AddressForm', '<c:out value="${addressBookFormURL}"/>'); return false;"  id="WC_AjaxAddressBookForm_links_4a">
											<fmt:message key="SUBMIT" bundle="${storeText}"/>
										</a>
									</span>
								</span>	
							</span>
						</span>
					</span>	
					<span class="secondary_button button_fit" id="WC_AjaxAddressBookForm_div_11a">
					<span class="button_container">
						<span class="button_bg">
							<span class="button_top">
								<span class="button_bottom">   
									<a href="#" onclick="javascript:setCurrentId('WC_AjaxAddressBookForm_links_2c'); var addressId = document.getElementById('addressId');wc.render.updateContext('addressBookContext', {'addressId':addressId.options[addressId.selectedIndex].value,'type':'edit'}); AddressBookFormJS.showFooter(); return false;"  id="WC_AjaxAddressBookForm_links_2c" waistate:controls="addressId">
										<fmt:message key="CANCEL" bundle="${storeText}"/>
									</a>
								</span>
							</span>	
						</span>
					</span>
				</span>	
			</div>
			<div class="right_corner" id="WC_AjaxAddressBookForm_div_21a"></div>			
		</div>	
	</div>
</div>
