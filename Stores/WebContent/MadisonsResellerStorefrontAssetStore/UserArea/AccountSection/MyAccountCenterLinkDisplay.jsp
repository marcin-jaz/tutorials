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
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../include/JSTLEnvironmentSetup.jspf"%>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ taglib uri="http://commerce.ibm.com/coremetrics"  prefix="cm" %>
<c:set var="isAjax" value="false"/>
<flow:ifEnabled feature="AjaxMyAccountPage">
	<c:set var="isAjax" value="true"/>
</flow:ifEnabled>

<flow:ifEnabled feature="AjaxMyAccountPage">
<wcf:url var="userRegistrationFormURL" value="UserRegistrationForm" type="Ajax">
	<wcf:param name="storeId"   value="${WCParam.storeId}"  />
	<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
	<wcf:param name="langId" value="${langId}" />
	<wcf:param name="editRegistration" value="Y" />
</wcf:url>
<wcf:url var="interestItemDisplayURL" value="AjaxAccountWishListDisplayView" type="Ajax">
	<wcf:param name="storeId"   value="${WCParam.storeId}"  />
	<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
	<wcf:param name="langId" value="${langId}" />
	<wcf:param name="listId" value="." />
</wcf:url>
<wcf:url var="profileFormViewURL" value="AjaxProfileFormView" type="Ajax">
	<wcf:param name="storeId"   value="${WCParam.storeId}"  />
	<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
	<wcf:param name="langId" value="${langId}" />
</wcf:url>	
<wcf:url var="addressBookFormURL" value="AjaxAddressBookForm" type="Ajax">
	<wcf:param name="storeId"   value="${WCParam.storeId}"  />
	<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
	<wcf:param name="langId" value="${langId}" />
</wcf:url>

<wcf:url var="trackOrderStatusURL" value="AjaxTrackOrderStatus" type="Ajax">
	<wcf:param name="storeId"   value="${WCParam.storeId}"  />
	<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
	<wcf:param name="langId" value="${langId}" />
</wcf:url>

<flow:ifEnabled feature="EnableQuotes">
	<wcf:url var="trackQuoteStatusURL" value="AjaxTrackOrderStatus" type="Ajax">
		<wcf:param name="storeId"   value="${WCParam.storeId}"  />
		<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
		<wcf:param name="langId" value="${langId}" />
		<wcf:param name="isQuote" value="true" />
	</wcf:url>
</flow:ifEnabled>

</flow:ifEnabled>


<flow:ifDisabled feature="AjaxMyAccountPage">
<wcf:url var="userRegistrationFormURL" value="UserRegistrationForm" type="Ajax">
	<wcf:param name="storeId"   value="${WCParam.storeId}"  />
	<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
	<wcf:param name="langId" value="${langId}" />
	<wcf:param name="editRegistration" value="Y" />
</wcf:url>
<wcf:url var="interestItemDisplayURL" value="NonAjaxAccountWishListDisplayView" type="Ajax">
	<wcf:param name="storeId"   value="${WCParam.storeId}"  />
	<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
	<wcf:param name="langId" value="${langId}" />
	<wcf:param name="listId" value="." />
</wcf:url>
<wcf:url var="profileFormViewURL" value="NonAjaxProfileFormView" type="Ajax">
	<wcf:param name="storeId"   value="${WCParam.storeId}"  />
	<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
	<wcf:param name="langId" value="${langId}" />
</wcf:url>	
<wcf:url var="addressBookFormURL" value="NonAjaxAddressBookForm" type="Ajax">
	<wcf:param name="storeId"   value="${WCParam.storeId}"  />
	<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
	<wcf:param name="langId" value="${langId}" />
</wcf:url>

<wcf:url var="trackOrderStatusURL" value="NonAjaxTrackOrderStatus" type="Ajax">
	<wcf:param name="storeId"   value="${WCParam.storeId}"  />
	<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
	<wcf:param name="langId" value="${langId}" />
</wcf:url>

<flow:ifEnabled feature="EnableQuotes">
	<wcf:url var="trackQuoteStatusURL" value="NonAjaxTrackOrderStatus" type="Ajax">
		<wcf:param name="storeId"   value="${WCParam.storeId}"  />
		<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
		<wcf:param name="langId" value="${langId}" />
		<wcf:param name="isQuote" value="true" />
	</wcf:url>
</flow:ifEnabled>

</flow:ifDisabled>

<wcf:getData type="com.ibm.commerce.member.facade.datatypes.PersonType" var="person" expressionBuilder="findCurrentPerson">
       <wcf:param name="accessProfile" value="IBM_All" />
</wcf:getData>
<flow:ifEnabled feature="Analytics">
<cm:registration personType="${person}"/>
</flow:ifEnabled>

<c:set var="firstName" value="${person.contactInfo.contactName.firstName}"/>
<c:set var="lastName" value="${person.contactInfo.contactName.lastName}"/>
<c:set var="middleName" value="${person.contactInfo.contactName.middleName}"/>
<c:set var="street" value="${person.contactInfo.address.addressLine[0]}"/>
<c:set var="street2" value="${person.contactInfo.address.addressLine[1]}"/>
<c:set var="city" value="${person.contactInfo.address.city}"/>
<c:set var="email1" value="${person.contactInfo.emailAddress1.value}"/>


<c:set var="myAccountPage" value="true" scope="request"/>
<c:set var="bHasWishList" value="true" />
<c:set var="wishListPage" value="true" />
<wcbase:useBean id="userListBean" classname="com.ibm.commerce.store.beans.UserInterestItemListDataBean" scope="page">
<c:set target="${userListBean}" property="storeEntityId" value="${WCParam.storeId}"/>
	<%--
	*** 
	* Two stores on the same server shares user wish lists.  We have to set the storeentId
	* to make sure the items in this shoppers wish list belongs to this store.
	*** 
	--%>
	
</wcbase:useBean>
<c:set var="listBeans" value="${userListBean.userInterestItemListDataBeans}"/>
<c:choose>		
	<%-- Check to see if the list is empty, if no, then wish list is empty--%>		
	<c:when test="${ empty listBeans }" >
		<c:set var="bHasWishList" value="false"/>
	</c:when>    
	<c:otherwise>
		<c:set var="listBean" value="${listBeans[0]}"/>
		<c:set var="interestItems" value="${listBean.interestItemDataBeans}" />
    	<%-- if there are items, then there are items in the wish list --%>
	   	<c:if test="${ empty interestItems }" >
			<c:set var="bHasWishList" value="false"/>
   		</c:if>
	</c:otherwise>
</c:choose>

<c:set var="numEntries" value="0"/>
<c:forEach var="count" items="${listBean.interestItemDataBeans}" varStatus="status">
	<c:if test="${status.last}"><c:set var="numEntries" value="${status.count}"/></c:if>
</c:forEach>

<c:set var="startIndex" value="1"/>

<c:set var="endIndex" value="4"/>
<c:if test="${endIndex > numEntries}">
	<c:set var="endIndex" value="${numEntries}"/>
</c:if>
<c:if test="${WCParam.myAcctUpdate == 1}">
<div id="box">
<div class="my_account" id="WC_MyAccountCenterLinkDisplay_box_1">
<div class="main_header" id="WC_MyAccountCenterLinkDisplay_div_36">
		<div class="left_corner" id="WC_MyAccountCenterLinkDisplay_div_37"></div>
		<div class="left" id="WC_MyAccountCenterLinkDisplay_div_38"><span class="main_header_text"><fmt:message key='MA_SUMMARY' bundle='${storeText}'/></span></div>
		<div class="right_corner" id="WC_MyAccountCenterLinkDisplay_div_39"></div>		
</div>

<div class="contentline" id="WC_MyAccountCenterLinkDisplay_div_40">
	<div class="left_corner" id="WC_MyAccountCenterLinkDisplay_div_41"></div>		
	<div class="left" id="WC_MyAccountCenterLinkDisplay_div_42"></div>
	<div class="right_corner" id="WC_MyAccountCenterLinkDisplay_div_43"></div>		
</div>

<div class="body" id="WC_MyAccountCenterLinkDisplay_div_44">
</c:if>

<c:if test="${!empty showOrgLogoName && showOrgLogoName==true}">
	<wcbase:useBean id="contract_DisplayTCBean" classname="com.ibm.commerce.tools.contract.beans.DisplayCustomizationTCDataBean">
		<c:set target="${contract_DisplayTCBean}" property="commandContext" value="${CommandContext}" />
		<c:set target="${contract_DisplayTCBean}" property="languageId" value="${langId}" />
		<c:set target="${contract_DisplayTCBean}" property="userId" value="${CommandContext.userId}" />
		<c:set target="${contract_DisplayTCBean}" property="storeId" value="${WCParam.storeId}" />
	</wcbase:useBean>
	<c:set var="customAccountLogo" value="${contract_DisplayTCBean.attachmentURL[1]}"/>
	<c:if test="${!empty customAccountLogo}">
		<c:set var="loopDone" value="false"/>
		<c:forTokens items="${customAccountLogo}" delims=":" var="token">
			<c:if test="${!loopDone}">
				<c:set var="customAccountPath" value="${token}" />
				<c:set var="loopDone" value="true"/>
			</c:if>
		</c:forTokens>
		<span id="WC_MyAccountCenterLinkDisplay_ContractLogo">
			<c:choose>
				<c:when test="${(customAccountPath eq 'http') or (customAccountPath eq 'https')}">
					<img alt="<c:out value="${requestScope.orgName}"/>" title="<c:out value="${requestScope.orgName}"/>" src='<c:out value="${contract_DisplayTCBean.attachmentURL[1]}"/>' ></img>
				</c:when>
				<c:otherwise>
					<img alt="<c:out value="${requestScope.orgName}"/>" title="<c:out value="${requestScope.orgName}"/>" src='<c:out value="${storeImgDir}${contract_DisplayTCBean.attachmentURL[1]}"/>'  ></img>
				</c:otherwise>
			</c:choose>
		</span>
		<br/>
	</c:if>
	<c:if test="${!empty contract_DisplayTCBean.displayText[1]}">
		<span id="WC_MyAccountCenterLinkDisplay_displayText1">
			<c:out value="${contract_DisplayTCBean.displayText[1]}"/>
			<br/>
		</span>
	</c:if>
	<c:if test="${!empty contract_DisplayTCBean.displayText[2]}">
		<span id="WC_MyAccountCenterLinkDisplay_displayText2">
			<c:out value="${contract_DisplayTCBean.displayText[2]}"/>
			<br/>
		</span>
	</c:if>
</c:if>
<h1 class="myaccount_title">
	<fmt:message key="MA_WELCOME" bundle="${storeText}">
		<fmt:param><c:out value="${firstName}"/></fmt:param>
		<fmt:param><c:out value="${middleName}"/></fmt:param>
		<fmt:param><c:out value="${lastName}"/></fmt:param>
	</fmt:message>
</h1>
<p><fmt:message key="MA_YOURACC" bundle="${storeText}"/></p>
<br />
<div class="contentgrad_header" id="WC_MyAccountCenterLinkDisplay_div_1">
	<div class="left_corner" id="WC_MyAccountCenterLinkDisplay_div_2"></div>
	<div class="left" id="WC_MyAccountCenterLinkDisplay_div_3"><span class="header"><fmt:message key="MA_PERSONAL_INFO" bundle="${storeText}"/></span></div>
	<div class="right_corner" id="WC_MyAccountCenterLinkDisplay_div_4"></div>
</div>
<div class="content" id="WC_MyAccountCenterLinkDisplay_div_5">
	<div class="info" id="WC_MyAccountCenterLinkDisplay_div_6">
		<div class="info_table">
			<div class="row">
				<div class="label"><fmt:message key="MA_NAME" bundle="${storeText}"/></div>
				<div class="info_content"><c:out value="${firstName} ${middleName} ${lastName}"/></div>
				<div class="clear_float"></div>
			</div>
			<div class="row">
				<div class="label"><fmt:message key="MA_ADDRESS" bundle="${storeText}"/></div>
				<div class="info_content"><c:out value="${street}"/> <c:out value="${street2}"/></div>
				<div class="clear_float"></div>
			</div>
			<div class="row">
				<div class="label"><fmt:message key="MA_CITY" bundle="${storeText}"/></div>
				<div class="info_content"><c:out value="${city}"/></div>
				<div class="clear_float"></div>
			</div>
			<div class="row">
				<div class="label"><fmt:message key="MA_EMAIL" bundle="${storeText}"/></div>
				<div class="info_content"><c:out value="${email1}"/></div>
				<div class="clear_float"></div>
			</div>
		</div>
		<br />
		<p><a href="javaScript:setCurrentId('WC_MyAccountCenterLinkDisplay_inputs_1'); MyAccountDisplay.loadContentFromURL('personalInformation', '<c:out value='${userRegistrationFormURL}' />');" class="myaccount_link" id="WC_MyAccountCenterLinkDisplay_inputs_1"><fmt:message key="MA_EDIT" bundle="${storeText}"/></a></p>
	</div>
</div>
<div class="footer" id="WC_MyAccountCenterLinkDisplay_div_7">
	<div class="left_corner" id="WC_MyAccountCenterLinkDisplay_div_8"></div>
	<div class="left" id="WC_MyAccountCenterLinkDisplay_div_9"></div>
	<div class="right_corner" id="WC_MyAccountCenterLinkDisplay_div_10"></div>
</div>
<p class="space" />
<flow:ifEnabled feature="TrackingStatus">
	<div class="contentgrad_header" id="WC_MyAccountCenterLinkDisplay_div_11">
		<div class="left_corner" id="WC_MyAccountCenterLinkDisplay_div_12"></div>
		<div class="left" id="WC_MyAccountCenterLinkDisplay_div_13"><span class="header"><fmt:message key="MA_RECENTORDERS" bundle="${storeText}"/></span></div>
		<div class="right_corner" id="WC_MyAccountCenterLinkDisplay_div_14"></div>
	</div>
	<div class="content" id="WC_MyAccountCenterLinkDisplay_div_15">
		<div class="info" id="WC_MyAccountCenterLinkDisplay_div_16">
			<% out.flush(); %>
				<c:import url="${jspStoreDir}Snippets/Order/Cart/OrderStatusTableDisplay.jsp" >
					<c:param name="isMyAccountMainPage" value="true"/>
				</c:import>
			<% out.flush();%>				
			<a href="javaScript:setCurrentId('WC_MyAccountCenterLinkDisplay_inputs_2'); MyAccountDisplay.loadContentFromURL('trackOrderStatus', '<c:out value='${trackOrderStatusURL}' />');" class="myaccount_link" id="WC_MyAccountCenterLinkDisplay_inputs_2"><fmt:message key="MA_VIEWALL" bundle="${storeText}"/></a>
			<br clear="all" />
		</div>
	</div>
	<div class="footer" id="WC_MyAccountCenterLinkDisplay_div_17">
		<div class="left_corner" id="WC_MyAccountCenterLinkDisplay_div_18"></div>
		<div class="left" id="WC_MyAccountCenterLinkDisplay_div_19"></div>
		<div class="right_corner" id="WC_MyAccountCenterLinkDisplay_div_20"></div>
	</div>
	<p class="space" />
	
	<flow:ifEnabled feature="EnableQuotes">
		<div class="contentgrad_header" id="WC_MyAccountCenterLinkDisplay_div_46">
			<div class="left_corner" id="WC_MyAccountCenterLinkDisplay_div_47"></div>
			<div class="left" id="WC_MyAccountCenterLinkDisplay_div_48"><span class="header"><fmt:message key="MA_RECENTQUOTES" bundle="${storeText}"/></span></div>
			<div class="right_corner" id="WC_MyAccountCenterLinkDisplay_div_49"></div>
		</div>
		<div class="content" id="WC_MyAccountCenterLinkDisplay_div_50">
			<div class="info" id="WC_MyAccountCenterLinkDisplay_div_51">
				<% out.flush(); %>
					<c:import url="${jspStoreDir}Snippets/Order/Cart/OrderStatusTableDisplay.jsp" >
						<c:param name="isMyAccountMainPage" value="true"/>
						<c:param name="isQuote" value="true"/>
					</c:import>
				<% out.flush();%>				
				<a href="javaScript:setCurrentId('WC_MyAccountCenterLinkDisplay_inputs_3'); MyAccountDisplay.loadContentFromURL('trackQuoteStatus', '<c:out value='${trackQuoteStatusURL}' />');" class="myaccount_link" id="WC_MyAccountCenterLinkDisplay_inputs_3"><fmt:message key="MA_VIEWALL_QUOTES" bundle="${storeText}"/></a>
				<br clear="all" />
			</div>
		</div>
		<div class="footer" id="WC_MyAccountCenterLinkDisplay_div_52">
			<div class="left_corner" id="WC_MyAccountCenterLinkDisplay_div_53"></div>
			<div class="left" id="WC_MyAccountCenterLinkDisplay_div_54"></div>
			<div class="right_corner" id="WC_MyAccountCenterLinkDisplay_div_55"></div>
		</div>
		<p class="space" />
	</flow:ifEnabled>
</flow:ifEnabled>

<flow:ifEnabled feature="accountParticipantRole">
	<%@ include file="B2BMyAccountParticipantRole.jspf" %>
	<p class="space" />
</flow:ifEnabled> 

<flow:ifEnabled feature="wishList">
<div class="contentgrad_header" id="WC_MyAccountCenterLinkDisplay_div_21">
	<div class="left_corner" id="WC_MyAccountCenterLinkDisplay_div_22"></div>
	<div class="left" id="WC_MyAccountCenterLinkDisplay_div_23"><span class="header"><fmt:message key="MA_RECENT_WISHLIST" bundle="${storeText}"/></span></div>
	<div class="right_corner" id="WC_MyAccountCenterLinkDisplay_div_24"></div>
</div>
<div class="content" id="WC_MyAccountCenterLinkDisplay_div_25">
	<div class="info" id="WC_MyAccountCenterLinkDisplay_div_26">
		<table id="four-grid" cellpadding="0" cellspacing="0" border="0">
		<c:choose>
		<c:when test="${bHasWishList == 'true'}">
			<c:set var="rowBeginIndex" value="0"/>
			<c:set var="rowItemCount" value="0"/>
			<tr>
				<td class="divider_line" colspan="4" id="WC_MyAccountCenterLinkDisplay_td_1"></td>
			</tr>
			<tr>
			<c:forEach var="interestItem" items="${listBean.interestItemDataBeans}" varStatus="status"  begin="${startIndex-1}" end="${endIndex-1}">
				<td class="item" id="WC_MyAccountCenterLinkDisplay_td_2_${status.count}">
					<div id="WC_MyAccountCenterLinkDisplay_div_27_${status.count}" <c:if test="${status.count > 1}"> class="container" </c:if>>
						<c:set var="rowItemCount" value="${rowItemCount+1}"/>
						<c:set var="catEntry" value="${interestItem.catalogEntryDataBean}"/>
						<c:set var="prefix" value="wishList"/>
						<c:set var="catEntryIdentifier" value="${catEntry.catalogEntryID}"/>
						<c:set var="pageView" value="image"/>
						<c:set var="interestItem2" value="${interestItem}"/>
						<c:set var="includeRemoveFromWishList" value="false"/>
						<%@ include file="../../Snippets/ReusableObjects/CatalogEntryDBThumbnailDisplay.jspf" %> 
					</div>
				</td>
			</c:forEach>         
			</tr>
			<tr>
				<td class="divider_line" colspan="4" id="WC_MyAccountCenterLinkDisplay_td_3"></td>
			</tr>
			</c:when>
			<c:otherwise>
				<fmt:message key="MA_WISHLIST_EMPTY" bundle="${storeText}"/>
			</c:otherwise>
		</c:choose>
		</table>
	</div>
</div>
<div class="footer" id="WC_MyAccountCenterLinkDisplay_div_28">
	<div class="left_corner" id="WC_MyAccountCenterLinkDisplay_div_29"></div>
	<div class="left" id="WC_MyAccountCenterLinkDisplay_div_30"></div>
	<div class="right_corner" id="WC_MyAccountCenterLinkDisplay_div_31"></div>
</div>
</flow:ifEnabled>
<c:if test="${WCParam.myAcctUpdate == 1}">
</div>
<div class="footer" id="WC_MyAccountCenterLinkDisplay_div_32">
	<div class="left_corner" id="WC_MyAccountCenterLinkDisplay_div_33"></div>
	<div class="tile" id="WC_MyAccountCenterLinkDisplay_div_34"></div>
	<div class="right_corner" id="WC_MyAccountCenterLinkDisplay_div_35"></div>
</div>
</div>
</div>
</c:if>
