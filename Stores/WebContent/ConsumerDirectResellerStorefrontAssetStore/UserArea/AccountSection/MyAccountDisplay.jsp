<%
//********************************************************************
//*-------------------------------------------------------------------
//* Licensed Materials - Property of IBM
//*
//* WebSphere Commerce
//*
//* (c) Copyright IBM Corp. 2000, 2002
//*
//* US Government Users Restricted Rights - Use, duplication or
//* disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
//*
//*-------------------------------------------------------------------
//*
%>

<%-- 
  *****
  * This JSP shows the My Account page with the following options: 
  *  - Change personal information 
  *  - Edit my address book
  *  - Create or update Quick Checkout Profile
  *  - View wish list
  *  - View orders
  *****
--%>

<!-- Start - JSP File Name:  MyAccountDisplay.jsp -->

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../include/JSTLEnvironmentSetup.jspf" %>
<%@ include file="../../include/nocache.jspf" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
	<title><fmt:message key="ACCOUNT_TITLE" bundle="${storeText}" /></title>
	<flow:ifEnabled feature="GiftRegistry">
	<link rel="stylesheet"
			href="<c:out value="${jspStoreImgDir}"/>css/GRMaster1_1.css"
	type="text/css" />
	</flow:ifEnabled>
	<link rel="stylesheet" href="<c:out value='${jspStoreImgDir}${vfileStylesheet}' />" type="text/css" />
</head>

<body>

	<%@ include file="../../include/LayoutContainerTop.jspf"%>

		<!--MAIN CONTENT STARTS HERE-->

		<table cellpadding="0" cellspacing="0" width="768" border="0" id="WC_MyAccountDisplay_Table_1">
		<tbody>
			<tr>
				<td><h1><fmt:message key="MY_ACCOUNT3" bundle="${storeText}" /></h1></td>
			</tr>
			
			<tr><td>&nbsp;</td></tr>

			<tr>
				<td id="WC_MyAccountDisplay_TableCell_11">
					<h2><fmt:message key="PERSONAL_INFO" bundle="${storeText}" /></h2>
					<span class="text">
						<%-- 
						<fmt:message key="UPDATE_NAME" bundle="${storeDynamicText}" >
							<fmt:param value="${storeName}"/>
						</fmt:message>
						--%>
					</span>
						<c:import url="${jspStoreDir}/Snippets/Marketing/Content/ContentSpotDisplay.jsp">
							<c:param name="spotName" value="Update_Name" />
							<c:param name="substitutionValues" value="{storeName},${storeName}" />
						</c:import>
					<c:url var="userRegistrationFormURL" value="UserRegistrationForm">
						<c:param name="storeId"   value="${WCParam.storeId}"  />
						<c:param name="catalogId" value="${WCParam.catalogId}"/>
						<c:param name="langId" value="${langId}" />
						<c:param name="editRegistration" value="Y" />
					</c:url>												
					<a class="button" href="<c:out value='${userRegistrationFormURL}' />" id="WC_MyAccountDisplay_Link_1">
						<fmt:message key="CHANGE_INFO" bundle="${storeText}" />
					</a>
					<br/><br/>
					<%-- 
					  ***
					  *	Start: GiftRegistryCode
					  *
					  ***
					--%>
					<flow:ifEnabled feature="GiftRegistry">
						<h2><fmt:message key="HEADER_GIFT_REGISTRY" bundle="${storeText}" /></h2>
						<br/>				
							<c:url var="GiftRegistryHomeURL" value="GiftRegistryHomeView">
 								<c:param name="langId" value="${langId}" />
  								<c:param name="storeId" value="${WCParam.storeId}" />
  								<c:param name="catalogId" value="${WCParam.catalogId}" />
							</c:url>																						
						<a class="button" href="<c:out value='${GiftRegistryHomeURL}' />" id="WC_MyAccountDisplay_Link_RegistryHome">
							<fmt:message key="GR_CREATE_OR_UPDATE_REGISTRY" bundle="${storeText}" />
						</a>
					<br/><br/>
						
					<%@ include file="..\..\Snippets\MyAccountGRDisplay.jspf" %>
					<c:forEach var="grEntType" items="${grEntTypeList.eventList}" varStatus="counter">
						<c:if test="${grEntType.eventTypeName == 'Wish List'}">
							<c:set var="wishListEventTypeId" value="${grEntType.eventTypeId}"/>
						</c:if>							
					</c:forEach>
					
					
					<c:set var="hasWishList" value="false" />
										
					<c:if test="${searchResults.resultCount!=0}">
						<c:forEach var="giftRegistryDB"
							items="${searchResults.registries}" varStatus="counter">
							<c:if test="${giftRegistryDB.eventTypeId==wishListEventTypeId}">
								<c:set var="hasWishList" value="true" />
								<c:set var="wishListId" value="${giftRegistryDB.externalId}" />
							</c:if>
						</c:forEach>
					</c:if>
					</flow:ifEnabled>
					<%-- 
					  ***
					  *	End: GiftRegistryCode
					  ***
					--%>	
					
				<flow:ifEnabled  feature="wishList">
					<h2><fmt:message key="ACCOUNT_WISHLIST" bundle="${storeText}" /></h2>
					<span class="text">
						<%-- 
							<fmt:message key="ACCOUNT_WISHLIST_MESSAGE" bundle="${storeDynamicText}" >
								<fmt:param value="${storeName}"/>
							</fmt:message> 
						--%>
					</span>
						<c:import url="${jspStoreDir}/Snippets/Marketing/Content/ContentSpotDisplay.jsp">
							<c:param name="spotName" value="Account_WishList_Message" />
							<c:param name="substitutionValues" value="{storeName},${storeName}" />
						</c:import>									
					<br/>
					<flow:ifDisabled feature="GiftRegistry">
					<c:url var="interestItemDisplayURL" value="InterestItemDisplay">
						<c:param name="storeId"   value="${WCParam.storeId}"  />
						<c:param name="catalogId" value="${WCParam.catalogId}"/>
						<c:param name="langId" value="${langId}" />
						<c:param name="listId" value="." />
					</c:url>												
					<a class="button" href="<c:out value='${interestItemDisplayURL}' />" id="WC_MyAccountDisplay_Link_2">
						<fmt:message key="ACCOUNT_WISHLIST2" bundle="${storeText}" />
					</a>
					</flow:ifDisabled>
					<%-- 
					  ***
					  *	Start: GiftRegistryCode
					  *
					  ***
					--%>
					<flow:ifEnabled feature="GiftRegistry">
						<c:choose>
							<c:when test="${hasWishList==false}">
								<c:url var="WishListCreateURL" value="WishListCreateView">
									<c:param name="langId" value="${langId}" />
									<c:param name="storeId" value="${WCParam.storeId}" />
									<c:param name="catalogId" value="${WCParam.catalogId}" />
								</c:url>
								<a href="<c:out value="${WishListCreateURL}"/>"	id="WC_MyAccountDisplay_Link_3" class="button">
									<fmt:message key="GR_SIDE_BAR_CREATE_YOUR_WISH_LIST" bundle="${storeText}" />
								</a>
							</c:when>
							<c:otherwise>
								<c:url var="GiftRegistryManageRegistry"	value="GiftRegistryManageAuthenticate">
									<c:param name="externalId" value="${wishListId}" />
									<c:param name="storeId" value="${WCParam.storeId}" />
									<c:param name="catalogId" value="${WCParam.catalogId}" />
									<c:param name="URL" value="GiftRegistryItemUpdateView" />
								</c:url>

								<a href="<c:out value="${GiftRegistryManageRegistry}"/>" id="WC_MyAccountDisplay_Link_3" class="button">
									<fmt:message key="GR_SIDE_BAR_MANAGE_YOUR_WISH_LIST" bundle="${storeText}" />
								</a>
							</c:otherwise>
						</c:choose>
					</flow:ifEnabled>
					<%-- 
					  ***
					  *	End: GiftRegistryCode
					  ***
					--%>					
					<br/><br/>
				</flow:ifEnabled>
	
				<flow:ifEnabled  feature="RequisitionList">
					<h2><fmt:message key="ACCOUNT_REQUISITIONLIST" bundle="${storeText}" /></h2>
					<span class="text">
						<%-- 
							<fmt:message key="ACCOUNT_REQUISITIONLIST_MESSAGE" bundle="${storeDynamicText}" >
								<fmt:param value="${storeName}"/>
							</fmt:message> 
						--%>
					</span>
						<c:import url="${jspStoreDir}/Snippets/Marketing/Content/ContentSpotDisplay.jsp">
							<c:param name="spotName" value="Account_RequisitionList_Message" />
							<c:param name="substitutionValues" value="{storeName},${storeName}" />
						</c:import>									
					<c:url var="requisitionListDisplayURL" value="RequisitionListDisplay">
						<c:param name="storeId"   value="${WCParam.storeId}"  />
						<c:param name="catalogId" value="${WCParam.catalogId}"/>
						<c:param name="langId" value="${langId}" />
						<c:param name="listId" value="." />
					</c:url>																						
					<a class="button" href="<c:out value='${requisitionListDisplayURL}' />" id="WC_MyAccountDisplay_Link_2">
						<fmt:message key="ACCOUNT_REQUISITIONLIST2" bundle="${storeText}" />
					</a>
					<br/><br/>
				</flow:ifEnabled>
	
				<flow:ifEnabled feature="quickCheckout">
					<h2><fmt:message key="ONESTEP_CHECKOUT" bundle="${storeText}" /></h2>
					<span class="text">
						<%-- 
							<fmt:message key="ONESTEP_CHECKOUT_MESSAGE" bundle="${storeDynamicText}" >
								<fmt:param value="${storeName}"/>
							</fmt:message> 
						--%>
					</span>
						<c:import url="${jspStoreDir}/Snippets/Marketing/Content/ContentSpotDisplay.jsp">
							<c:param name="spotName" value="OneStep_CheckOut_Message" />
							<c:param name="substitutionValues" value="{storeName},${storeName}" />
						</c:import>
					<c:url var="profileFormViewURL" value="ProfileFormView">
						<c:param name="storeId"   value="${WCParam.storeId}"  />
						<c:param name="catalogId" value="${WCParam.catalogId}"/>
						<c:param name="langId" value="${langId}" />
					</c:url>												
					<a class="button" href="<c:out value='${profileFormViewURL}' />" id="WC_MyAccountDisplay_Link_3">
						<fmt:message key="ACCOUNT_CHANGEPROFILE" bundle="${storeText}" />
					</a>
					<br/><br/>
				</flow:ifEnabled>

					<h2><fmt:message key="ADDRESS_BOOK" bundle="${storeText}" /></h2>
					<span class="text">
						<%-- 
							<fmt:message key="UPDATE_ADDRESS1" bundle="${storeDynamicText}" >
								<fmt:param value="${storeName}"/>
							</fmt:message> 
						--%>
					</span>
						<c:import url="${jspStoreDir}/Snippets/Marketing/Content/ContentSpotDisplay.jsp">
							<c:param name="spotName" value="Update_Address1" />
							<c:param name="substitutionValues" value="{storeName},${storeName}" />
						</c:import>								
					<c:url var="addressBookFormURL" value="AddressBookForm">
						<c:param name="storeId"   value="${WCParam.storeId}"  />
						<c:param name="catalogId" value="${WCParam.catalogId}"/>
						<c:param name="langId" value="${langId}" />
					</c:url>												
					<a class="button" href="<c:out value='${addressBookFormURL}' />" id="WC_MyAccountDisplay_Link_4">
						<fmt:message key="EDIT_ADD" bundle="${storeText}" />
					</a>
					<br/><br/>

					<flow:ifEnabled feature="TrackingStatus">
					<h2><fmt:message key="TRACK_ORDER_STATUS" bundle="${storeText}" /></h2>
					<span class="text">
						<%-- 
							<fmt:message key="TRACKORDER_STATUS_MESSAGE" bundle="${storeDynamicText}" >
								<fmt:param value="${storeName}"/>
							</fmt:message> 
						--%>
					</span>
						<c:import url="${jspStoreDir}/Snippets/Marketing/Content/ContentSpotDisplay.jsp">
							<c:param name="spotName" value="TrackOrder_Status_Message" />
							<c:param name="substitutionValues" value="{storeName},${storeName}" />
						</c:import>
					<c:url var="trackOrderStatusURL" value="TrackOrderStatus">
						<c:param name="storeId"   value="${WCParam.storeId}"  />
						<c:param name="catalogId" value="${WCParam.catalogId}"/>
						<c:param name="langId" value="${langId}" />
					</c:url>												
					<a class="button" href="<c:out value='${trackOrderStatusURL}' />" id="WC_MyAccountDisplay_Link_5">
						<fmt:message key="TRACK_STATUS" bundle="${storeText}" />
					</a>
					<br/><br/>
					</flow:ifEnabled>
				</td>
			</tr>
		</tbody>
		</table>

	<!-- MAIN CONTENT ENDS HERE -->

	<%-- Hide CIP --%>
	<c:set var="HideCIP" value="true"/>

	<%@ include file="../../include/LayoutContainerBottom.jspf"%>

</body>
</html>

<!-- End - JSP File Name:  MyAccountDisplay.jsp -->
