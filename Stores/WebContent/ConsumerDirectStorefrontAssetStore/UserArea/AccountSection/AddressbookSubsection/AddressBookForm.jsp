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
  * This JSP shows the Address Book page, which lists all the addresses added by the users. 
  * Next to each address are two buttons: 'Edit' and 'Delete'. 
  * If the customer clicks 'Delete', the corresponding address is deleted. If the customer clicks 'Edit', the Address Form page will be displayed.
  * Also, there is an 'Add a new address' button for customers to add new addresses.
  *****
--%>

<!-- Start - JSP File Name:  AddressBookForm.jsp -->



<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf" %>
<%@ include file="../../../include/nocache.jspf" %>

<wcbase:useBean id="profileOrderListBean" classname="com.ibm.commerce.order.beans.OrderListDataBean" scope="page">
	<c:set value="Q" target="${profileOrderListBean}" property="retrievalOrderStatus"/>
	<c:set value="${CommandContext.userId}" target="${profileOrderListBean}" property="userId"/>
</wcbase:useBean>	
<wcbase:useBean id="addressBookBean" classname="com.ibm.commerce.user.beans.AddressBookDataBean" scope="page">
	<c:set value="${CommandContext.userId}" target="${addressBookBean}" property="userId"/>
</wcbase:useBean>	


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
	<title><fmt:message key="ADDRESSBOOK_TITLE" bundle="${storeText}" /></title>
	<link rel="stylesheet" href='<c:out value="${jspStoreImgDir}${vfileStylesheet}" />' type="text/css" />
</head>

	<body>
	<!-- JSP File Name:  AddressBookForm.jsp -->

	<%@ include file="../../../include/LayoutContainerTop.jspf"%>
	
		<!--MAIN CONTENT STARTS HERE-->

		<span class="heading"><fmt:message key="ADRESS_BOOK1" bundle="${storeText}" /></span>

		<table cellpadding="0" cellspacing="0" width="100%" border="0" id="WC_AddressBookForm_Table_1">
		<tr>
			<td valign="top" colspan="3" class="categoryspace" id="WC_AddressBookForm_TableCell_1">
				<span class="text"><fmt:message key="SHIPPING_ADDRESS3" bundle="${storeText}" /></span><br/><br/>
				<%-- 
				  ***
				  *	Start: Add New Address button
				  ***
				--%>				
				<table cellpadding="0" cellspacing="0" border="0" id="WC_AddressBookForm_Table_2">
				<tr>
					<td id="WC_AddressBookForm_TableCell_2">
						<%--
						  ***
						  *	If the customer comes from the checkout page to the Address book page, "mode" parameter is set to AddressBookReturnToCheckout,
						  * and "page" parameter is set to shipaddress
						  ***
						--%>
						<c:url var="AddressFormURL" value="AddressForm">
							<c:param name="storeId"   value="${WCParam.storeId}"  />
							<c:param name="catalogId" value="${WCParam.catalogId}"/>
							<c:param name="langId" value="${langId}" />
							<c:if test="${! empty WCParam.returnView}">
								<c:param name="returnView"    value="${WCParam.returnView}"/>
								<c:param name="orderId"       value="${WCParam.orderId}"   />
							</c:if>
							<c:if test="${WCParam.mode == 'AddressBookReturnToCheckout'}">
								<c:param name="mode"          value="AddressBookReturnToCheckout"/>
								<c:param name="page"          value="shipaddress"            />
								<c:param name="orderId"       value="${WCParam.orderId}"         />
							</c:if>
						</c:url>
						<a href="<c:out value="${AddressFormURL}"/>" class="button" id="WC_AddressBookForm_Link_1"><fmt:message key="ADD_NEW_ADDRESS" bundle="${storeText}" /></a>
					</td>
				</tr>
				</table>
				<%-- 
				  ***
				  *	End: Add New Address button
				  ***
				--%>
			</td>
		</tr>
		<tr><td class="c_line" id="WC_AddressBookDisplay_TableCell_3">&nbsp;</td></tr>
		<tr>
			<td valign="top" id="WC_AddressBookForm_TableCell_4">
				<%-- 
				  ***
				  *	Start: find the billing/shipping addressId for the quick checkout profile
				  * The information can be retrieved from the profile order.
				  * Profile order has a single order item, and we can get the shipping/billing address from there
				  ***
				--%>				
				<c:if test="${ !empty profileOrderListBean.orderDataBeans }" >
				<%-- no Quick Checkout Profile if the list is empty --%>
					<c:set var="billingAddressId" value="${profileOrderListBean.orderDataBeans[0].addressId}" />
				</c:if>
				<c:set var="defaultShipping" value="Default_Shipping_${WCParam.storeId}" />
				<c:set var="defaultBilling" value="Default_Billing_${WCParam.storeId}" />
				<%-- 
				  ***
				  *	End: find the billing/shipping addressId for the quick checkout profile
				  ***
				--%>								
				<%-- 
				  ***
				  *	Start: List all the addresses
				  * Next to each address are two buttons: 'Edit' and 'Delete'. 
				  ***
				--%>								
				<c:forEach items="${addressBookBean.addressDataBeansList}" var="address" varStatus="status">
					<%--
					 ***
					 * Do not show the special addresses used for quick checkout profile
					 ***
					--%>
					<c:if test="${ address.addressId != billingAddressId && address.nickName != defaultShipping && address.nickName != defaultBilling}" >
						<table class="t_table" cellpadding="0" cellspacing="0" border="0" id="WC_AddressBookForm_Table_3_<c:out value='${status.count}'/>">
						<tr>
						<td class="t_td2" id="WC_AddressBookForm_TableCell_5_<c:out value='${status.count}'/>">
						<c:out value="${address.nickName}" /><br />
						<%-- Print the appropriate address information out depending on locale --%>
						<%@ include file="../../../Snippets/ReusableObjects/AddressDisplay.jspf"%>
			
						<%-- Display the 'Edit' button --%>
						</td>
						</tr>
						<tr>
							<td class="space" id="WC_AddressBookForm_TableCell_6_<c:out value='${status.count}'/>">
								<c:url var="AddressFormURL" value="AddressForm">
									<c:param name="storeId"   value="${WCParam.storeId}"  />
									<c:param name="catalogId" value="${WCParam.catalogId}"/>
									<c:param name="addressId" value="${address.addressId}"/>
									<c:param name="langId" value="${langId}" />
									<c:if test="${! empty WCParam.returnView}">
										<c:param name="returnView"    value="${WCParam.returnView}"/>
										<c:param name="orderId"       value="${WCParam.orderId}"   />
									</c:if>
									<c:if test="${WCParam.mode == 'AddressBookReturnToCheckout'}">
										<c:param name="mode"          value="AddressBookReturnToCheckout"/>
										<c:param name="page"          value="shipaddress"            />
										<c:param name="orderId"       value="${WCParam.orderId}"         />
									</c:if>
								</c:url>
								<span class="t_rght_space">
								<a href='<c:out value="${AddressFormURL}" />' class="button" id="WC_AddressBookForm_Link_2_<c:out value='${status.count}'/>">&nbsp;<fmt:message key="EDIT" bundle="${storeText}" /></a>
								</span>
							<%--
							  ***
							  * Display the 'Delete' button
							  * Only give the user an option to delete the address if they come from the myaccount page. 
 							  * We do not want customers to delete addresses if they are comming from the checkout flow.
 							  ***
 							--%>
 							<c:if test="${WCParam.mode != 'AddressBookReturnToCheckout'}">
 								<%--
								 ***
								 * Do not let user delete the self address
								 ***
								--%>
 								<c:if test="${ address.selfAddress == '0' }" >
									<c:url var="AddressDeleteURL" value="AddressDelete">
										<c:param name="storeId"   value="${WCParam.storeId}"  />
										<c:param name="catalogId" value="${WCParam.catalogId}"/>
										<c:param name="addressId" value="${address.addressId}"/>
										<c:param name="langId" value="${langId}" />
										<c:param name="URL" value="AddressBookForm" />
									</c:url>
									<span>
										<a href="<c:out value="${AddressDeleteURL}" />" class="button" id="WC_AddressBookForm_Link_3_<c:out value='${status.count}' />">&nbsp;<fmt:message key="DELETE" bundle="${storeText}" /></a>
									</span>
								</c:if>
 							</c:if>
							</td>
						</tr>
						<tr><td class="c_line" id="WC_AddressBookDisplay_TableCell_7_<c:out value='${status.count}'/>">&nbsp;</td></tr>
						</table>
					</c:if>
				</c:forEach>
				<%-- 
				  ***
				  *	End: List all the addresses
				  ***
				--%>								

				<%-- if customers come from the checkout flow, display the "Return to Checkout" button and use returnView parameter --%>
				<c:if test="${! empty WCParam.returnView}">
					<table cellpadding="0" cellspacing="0" border="0" id="WC_AddressBookForm_Table_4">
					<tr>
						<td id="WC_AddressBookForm_TableCell_8">
							<c:url var="BackToCheckoutURL" value="${WCParam.returnView}">
								<c:param name="storeId"   value="${WCParam.storeId}"  />
								<c:param name="catalogId" value="${WCParam.catalogId}"/>
								<c:param name="langId" value="${langId}" />
								<c:param name="orderId" value="${WCParam.orderId}" />
								<c:param name="page" value="${WCParam.page}" />
							</c:url>
							<a href="<c:out value='${BackToCheckoutURL}' />" id="WC_AddressBookForm_Link_4"><fmt:message key="RETURN_TO_CHECKOUT" bundle="${storeText}" /></a>
						</td>
					</tr>
					</table>
				</c:if>
				<%-- if customers come from the checkout flow, display the "Return to Checkout" button --%>
				<c:if test="${WCParam.mode == 'AddressBookReturnToCheckout'}">
					<table cellpadding="0" cellspacing="0" border="0" id="WC_AddressBookForm_Table_5">
					<tr>
						<td id="WC_AddressBookForm_TableCell_9">
						<c:choose>
							<c:when test="${WCParam.page == 'shipaddress'}">
								<c:set var="BackToCheckoutURL">
									<flow:url exitPort='ActualAddressBookFormPage.i1.xBackToCheckout'/>
								</c:set>
								<c:url var="BackToCheckoutURL" value="${BackToCheckoutURL}">
									<c:param name="storeId"   value="${WCParam.storeId}"  />
									<c:param name="catalogId" value="${WCParam.catalogId}"/>
									<c:param name="langId" value="${langId}" />
									<c:param name="orderId" value="${WCParam.orderId}" />
									<c:param name="page" value="${WCParam.page}" />
								</c:url>
								<a href="<c:out value='${BackToCheckoutURL}' />" id="WC_AddressBookForm_Link_5"><fmt:message key="RETURN_TO_CHECKOUT" bundle="${storeText}" /></a>
							</c:when>
							<c:otherwise>
								<c:url var="BillingAddressViewURL" value="BillingAddressView">
									<c:param name="storeId"   value="${WCParam.storeId}"  />
									<c:param name="catalogId" value="${WCParam.catalogId}"/>
									<c:param name="langId" value="${langId}" />
									<c:param name="orderId" value="${WCParam.orderId}" />
									<c:param name="page" value="${WCParam.page}" />
								</c:url>
								<a href="<c:out value='${BillingAddressViewURL}' />" id="WC_AddressBookForm_Link_6"><fmt:message key="RETURN_TO_CHECKOUT" bundle="${storeText}" /></a>
							</c:otherwise>
						</c:choose>
						</td>
					</tr>
					
					</table>
				</c:if>
			</td>
		</tr>
		
		</table>
	<!--MAIN CONTENT ENDS HERE-->
		
	<%-- Hide CIP --%>
	<c:set var="HideCIP" value="true"/>

	<%@ include file="../../../include/LayoutContainerBottom.jspf"%>

	</body>
</html>

<!-- End - JSP File Name:  AddressBookForm.jsp -->
