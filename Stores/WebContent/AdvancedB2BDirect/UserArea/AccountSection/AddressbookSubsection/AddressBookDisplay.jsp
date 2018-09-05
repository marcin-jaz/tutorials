<%--
/*
 *-------------------------------------------------------------------
 * Licensed Materials - Property of IBM
 *
 * WebSphere Commerce
 *
 * (c) Copyright International Business Machines Corporation. 2001-2004
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
  * This page displays the address book. It allows a user to add new addresses
  * or update existing addresses in the address book.
  *****
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>

<%@ include file="../../../include/JSTLEnvironmentSetup.jspf" %>
<%@ include file="../../../include/ErrorMessageSetup.jspf" %>


<wcbase:useBean id="addressBook" classname="com.ibm.commerce.user.beans.AddressBookDataBean">
	<c:set target="${addressBook}" property="userId" value="${CommandContext.userId}"/>
</wcbase:useBean>

<wcbase:useBean id="userReg" classname="com.ibm.commerce.user.beans.UserRegistrationDataBean"/>

<wcbase:useBean id="parentOrgAddressBook" classname="com.ibm.commerce.user.beans.AddressBookDataBean">
	<c:set target="${parentOrgAddressBook}" property="userId" value="${userReg.parentMemberId}"/>
</wcbase:useBean>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><fmt:message key="AddBook_Title" bundle="${storeText}"/></title>
<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${vfileStylesheet}"/>" type="text/css"/>
</head>

<body class="noMargin">

<%@ include file="../../../include/LayoutContainerTop.jspf" %>

<h1><fmt:message key="AddBook_Title" bundle="${storeText}"/></h1>

<table class="noBorder" width="100%" cellpadding="0" cellspacing="0" id="WC_AddressBookDisplay_Table_1">
<tr>
	<td class="c_headings" id="WC_AddressBookDisplay_TableCell_1">
		<fmt:message key="AddBook_Pal" bundle="${storeText}"/>
	</td>
</tr>
<tr><td id="WC_AddressBookDisplay_TableCell_2">

<c:url var="addressFormURL" value="AddressForm">
	<c:param name="storeId"   value="${WCParam.storeId}"  />
	<c:param name="catalogId" value="${WCParam.catalogId}"/>
	<c:if test="${! empty WCParam.returnView}">
		<c:param name="returnView"    value="${WCParam.returnView}"/>
		<c:if test="${!empty WCParam.orderId}">
			<c:param name="orderId"       value="${WCParam.orderId}"   />
		</c:if>
		<c:if test="${!empty WCParam.paymentMethod}">
			<c:param name="paymentMethod" value="${WCParam.paymentMethod}"   />
		</c:if>
	</c:if>
	<c:if test="${empty WCParam.returnView}">
		<c:param name="returnView" value="AddressBookForm"/>
	</c:if>
	<c:if test="${WCParam.mode == 'AddressBookReturnToCheckout'}">
		<c:param name="mode"          value="AddressBookReturnToCheckout"/>
		<c:param name="page"          value="${WCParam.page}"            />
		<c:param name="orderId"       value="${WCParam.orderId}"         />
		<c:param name="paymentMethod" value="${WCParam.paymentMethod}"   />
	</c:if>
</c:url>
<br />
<a class="button" href="<c:out value="${addressFormURL}"/>" id="WC_AddressBookDisplay_Link_1">
	<fmt:message key="AddBook_Add" bundle="${storeText}"/>
</a>
</td></tr>
<tr><td class="c_line" id="WC_AddressBookDisplay_TableCell_3">&nbsp;</td></tr>

<%--
  ***
  *	Start: List of personal addresses
  ***
--%>
<tr><td id="WC_AddressBookDisplay_TableCell_4">

<table class="bgColor" width="100%" border="0" cellpadding="2" cellspacing="1" id="WC_AddressBookDisplay_Table_2">
<c:forEach items="${addressBook.addressDataBeansList}" var="address" varStatus="status">
	<tr>
		<td class="<c:out value="cellBG_${status.index%2 + 1}"/>" id="<c:out value="WC_AddressBookDisplay_TableCell_5_${status.count}"/>">
			<em><c:out value="${address.nickName}"/></em><br/>
			<%-- Print the appropriate address information out depending on locale --%>				
			<%@ include file="../../../Snippets/ReusableObjects/AddressDisplay.jspf"%>
		</td>
	</tr>
	<tr>
		<td class="<c:out value="cellBG_${status.index%2 + 1}"/>" id="<c:out value="WC_AddressBookDisplay_TableCell_6_${status.count}"/>">
			<c:url var="addressFormURL" value="AddressForm">
				<c:param name="storeId"   value="${WCParam.storeId}"  />
				<c:param name="catalogId" value="${WCParam.catalogId}"/>
				<c:param name="addressId" value="${address.addressId}"/>
				<c:if test="${! empty WCParam.returnView}">
					<c:param name="returnView"    value="${WCParam.returnView}"/>
					<c:param name="orderId"       value="${WCParam.orderId}"   />
					<c:param name="paymentMethod" value="${WCParam.paymentMethod}"   />
				</c:if>
				<c:if test="${WCParam.mode == 'AddressBookReturnToCheckout'}">
					<c:param name="mode"          value="AddressBookReturnToCheckout"/>
					<c:param name="page"          value="${WCParam.page}"            />
					<c:param name="orderId"       value="${WCParam.orderId}"         />
					<c:param name="paymentMethod" value="${WCParam.paymentMethod}"   />
				</c:if>
			</c:url>
			<a class="button" href="<c:out value="${addressFormURL}"/>" id="<c:out value="WC_AddressBookDisplay_Link_2_${status.count}"/>">
				<fmt:message key="AddBook_Link1" bundle="${storeText}"/>
			</a>&nbsp;
		<c:if test="${WCParam.mode != 'AddressBookReturnToCheckout'}">
			<c:if test="${address.selfAddress == '0'}">
				<c:url var="addressDeleteURL" value="AddressDelete">
					<c:param name="storeId"   value="${WCParam.storeId}"  />
					<c:param name="catalogId" value="${WCParam.catalogId}"/>
					<c:param name="addressId" value="${address.addressId}"/>
					<c:param name="URL"       value="AddressBookForm"     />
				</c:url>
				<a class="button" href="<c:out value="${addressDeleteURL}"/>" id="<c:out value="WC_AddressBookDisplay_Link_3_${status.count}"/>">
					<fmt:message key="AddBook_Link2" bundle="${storeText}"/>
				</a>
			</c:if>
		</c:if>
	</tr>
	<tr><td class="c_line" id="WC_AddressBookDisplay_TableCell_7">&nbsp;</td></tr>
</c:forEach>
</table>

</td></tr>
<%--
  ***
  *	End: List of personal addresses
  ***
--%>

<%--
  ***
  *	Start: List of organization addresses
  ***
--%>
<tr><td class="c_headings" id="WC_AddressBookDisplay_TableCell_8"><fmt:message key="AddBook_Oal" bundle="${storeText}"/></td></tr>

<tr><td id="WC_AddressBookDisplay_TableCell_9">

<table class="bgColor" width="100%" border="0" cellpadding="2" cellspacing="1" id="WC_AddressBookDisplay_Table_3">
<c:forEach items="${parentOrgAddressBook.addressDataBeansList}" var="address" varStatus="status">

	<tr><td class="<c:out value="cellBG_${status.index%2 + 1}"/>" id="<c:out value="WC_AddressBookDisplay_TableCell_10_${status.count}"/>">
		<em><c:out value="${address.nickName}"/></em><br/>
		<%-- Print the appropriate address information out depending on locale --%>				
		<%@ include file="../../../Snippets/ReusableObjects/AddressDisplay.jspf"%>
	</td></tr>

</c:forEach>
</table>

</td></tr>
<%--
  ***
  *	End: List of organization addresses
  ***
--%>


</table>

<%@ include file="../../../include/LayoutContainerBottom.jspf" %>

</body>

</html>
