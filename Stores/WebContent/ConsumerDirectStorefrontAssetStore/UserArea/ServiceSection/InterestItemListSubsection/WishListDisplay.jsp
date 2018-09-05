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
%>
<%--
  *****
  * This page show the wishlist of a user and contains the following:
  *
  * -A list of interest items that a user has added to their wish list
  * 	- For each interest item:
  * 		- Checkbox to select the item (used to select products that user wants to add to their shopcart)
  *			- Clickable item name (links to display page for order item)
  * 		- Attribute values for each interest item
  *			- Item price
  * 		- Link to remove items from wishlist 
  * - 'Add Selected items to shopping cart' button (adds item to Shopping Cart)
  * 
  * - A section to send your wish list friends and/or family. This section contains the following:
  * 	- A To 'E-mail address' field to enter the e-mail address of the recipient
  *		- A From 'Name' field to enter the name of the user sending the Wish List
  *		- A From 'E-mail address' field to enter the e-mail address of the user sending the Wish List
  *		- A 'E-mail message' field to enter comments along with the email being sent
  * 	- A 'Send wish list' button to send the email to the recipeient's address
  *****
--%>

<!-- Start - JSP File Name:  WishListDisplay.jsp -->

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf" %>
<%@ include file="../../../include/nocache.jspf" %>

<%-- activate the UserRegistrationDataBean to get the user information to pre-fill the send wishlist form--%>
<wcbase:useBean id="bnRegister" classname="com.ibm.commerce.user.beans.UserRegistrationDataBean" />
<%-- activate the StoreAddressDataBean to get the store email and use it as the sender of the wish list email --%>
<wcbase:useBean id="storeAddress" classname="com.ibm.commerce.common.beans.StoreAddressDataBean" scope="page" >
	<c:set value="${sdb.storeEntityDescriptionDataBean.contactAddressId}" target="${storeAddress}" property="dataBeanKeyStoreAddressId"/>
</wcbase:useBean>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
	<title><fmt:message key="WISHLIST_TITLE" bundle="${storeText}" /></title>
	<link rel="stylesheet" href='<c:out value="${jspStoreImgDir}${vfileStylesheet}" />' type="text/css" />
</head>

<body>
<!-- JSP File Name:  WishListDisplay.jsp -->

<%@ include file="../../../include/LayoutContainerTop.jspf"%>

	<!--MAIN CONTENT STARTS HERE-->
	<table cellpadding="0" cellspacing="0" width="786" border="0" id="WC_WishListDisplay_Table_0">
	<tbody><tr><td>

	<c:set var="bHasWishList" value="true" />
	<c:choose>
		<%-- Check to see if there is an list id, if no, then wish list is empty--%>
		<c:when test="${ empty listId[0] }" >
			<c:set var="bHasWishList" value="false"/>
		</c:when>
		<c:otherwise>
			<wcbase:useBean id="listBean" classname="com.ibm.commerce.catalog.beans.InterestItemListDataBean" scope="page">
				<c:set value="${listId[0]}" target="${listBean}" property="listId"/>
				<%--
				  *** 
				  * Two stores on the same server shares user wish lists.  We have to set the storeentId
				  * to make sure the items in this shoppers wish list belongs to this store.
				  ***
				--%>				
				<c:set value="${WCParam.storeId}" target="${listBean}" property="storeEntityId"/>
			</wcbase:useBean>
			<c:set var="interestItems" value="${listBean.interestItemDataBeans}" />
    			<%-- if there are items, then there are items in the wish list --%>
	   		<c:if test="${ empty interestItems }" >
				<c:set var="bHasWishList" value="false"/>
   			</c:if>
		</c:otherwise>
	</c:choose>
	 
	<c:choose> 
		<c:when test="${ !bHasWishList }">
			<%--
				***
				* Start: Empty Wish List 
				* If the wish list is empty, display the empty wish list message
				***
			--%>
			<table class="t_table" cellpadding="2" cellspacing="0" width="786" border="0" id="WC_WishListDisplay_Table_2">
			<tr>
				<td id="WC_WishListDisplay_TableCell_5" valign="top">
					<br/><fmt:message key="EMPTYWISHLIST" bundle="${storeText}" />
					<br/><br/>
				</td>
				<td id="WC_WishListDisplay_TableCell_6" align="right">
					<img src="<c:out value="${jspStoreImgDir}"/>/images/wish_list.jpg" alt="" border="0" />
				</td>
			</tr>			 
			</table>
			<%--
				***
				* End: Empty Wish List 
				***
			--%>
		</c:when>
		<c:otherwise>
			<%-- 
				*** 
				* Wish list is not empty.  Display wish list contents
				***
			--%>
			
			<h1><fmt:message key="WISHLIST_TITLE" bundle="${storeText}" /></h1>
			<h2><fmt:message key="WISHLIST_CONTAIN" bundle="${storeText}" /></h2>
			
			<%--
				***
				* Start: Wish List Form
				* Prepare the WishList form and list all the interest items
				***
			--%>		
			<form name="WishListForm" method="post" action="OrderItemAdd" id="WishListForm">
			<input type="hidden" name="storeId" value="<c:out value="${WCParam.storeId}" />" id="WC_WishListDisplay_FormInput_storeId_In_WishListForm_1"/>
			<input type="hidden" name="langId" value="<c:out value="${langId}" />" id="WC_WishListDisplay_FormInput_langId_In_WishListForm_1"/>
			<input type="hidden" name="catalogId" value="<c:out value="${WCParam.catalogId}" />" id="WC_WishListDisplay_FormInput_catalogId_In_WishListForm_1"/>
			<input type="hidden" name="URL" value="SetPendingOrder?URL=OrderCalculate?URL=OrderItemDisplay&catEntryId*=&amp;quantity*=" id="WC_WishListDisplay_FormInput_URL_In_WishListForm_1"/>
			<input type="hidden" name="calculationUsageId" value="-1" id="WC_WishListDisplay_FormInput_calculationUsageId_In_WishListForm_1"/>
			<input type="hidden" name="errorViewName" value="ProductDisplayErrorView" id="WC_WishListDisplay_FormInput_errorViewName_In_WishListForm_1"/>						
		
			<table cellpadding="0" cellspacing="0" width="100%" border="0" id="WC_WishListDisplay_Table_4">
			<tbody>
			<tr>
				<th class="colHeader" colspan="2" id="th1">
					<fmt:message key="WISHLIST_ITEM" bundle="${storeText}"/>
				</th>
				<th class="colHeader_price" id="th2">
					<fmt:message key="WISHLIST_ITEM_PRICE" bundle="${storeText}" />
				</th>
				<th class="t_hd_last" id="th3">
					&nbsp;
				</th>					
			</tr>
			<%--
				***
				* Loop through each of the interest items and display the item name, the attribute values and the price
				***
			--%>
			<c:forEach var="interestItem" items="${listBean.interestItemDataBeans}" varStatus="status">
				<c:choose>
					<c:when test="${interestItem.catalogEntryDataBean.package}">
						<c:set var="catalogEntry" value="${interestItem.catalogEntryDataBean.packageDataBean}"/>
						<c:set var="catalogEntryId" value="${catalogEntry.packageID}"/>
						<c:set var="type" value="package"/>
					</c:when>					
					<c:when test="${interestItem.catalogEntryDataBean.item}">
						<%-- use the parent product of an item as the catalog entry--%>
						<c:set var="catalogEntry" value="${interestItem.catalogEntryDataBean.itemDataBean.parentProductDataBean}"/>
						<c:set var="catalogEntryId" value="${catalogEntry.productID}"/>
						<c:set var="type" value="item"/>
					</c:when>		
				</c:choose>
			<tr>
				<c:url var="ProductDisplayURL" value="ProductDisplay">
					<c:param name="productId" value="${catalogEntryId}" />
					<c:param name="langId" value="${langId}" />
					<c:param name="storeId" value="${WCParam.storeId}" />
					<c:param name="catalogId" value="${WCParam.catalogId}" />
					<c:if test="${ !empty WCParam.parent_category_rn }" >
						<c:param name="parent_category_rn" value="${WCParam.parent_category_rn}" />
					</c:if>
				</c:url>
									
				<td headers="th1" valign="top" class="t_td" id="WC_WishListDisplay_TableCell_12_<c:out value="${status.count}"/>">
					<a href="<c:out value="${ProductDisplayURL}" />" id="WC_WishListDisplay_Link_1_<c:out value="${status.count}"/>">
						<!--						
						<img src="<c:out value="${interestItem.catalogEntryDataBean.objectPath}${interestItem.catalogEntryDataBean.description.thumbNail}" />" alt="<c:out value="${catalogEntry.description.name}" />" hspace="5" border="0"/></a>
						-->
						<c:choose>
							<c:when test="${!empty interestItem.catalogEntryDataBean.description.thumbNail}">
								<img src="<c:out value="${interestItem.catalogEntryDataBean.objectPath}${interestItem.catalogEntryDataBean.description.thumbNail}" />" alt="<c:out value="${catalogEntry.description.name}" />" hspace="5" border="0"/>
							</c:when>
							<c:otherwise>
								<img src="<c:out value="${jspStoreImgDir}"/>images/NoImageIcon_sm.jpg" alt="<fmt:message key="No_Image" bundle="${storeText}"/>" hspace="5" border="0"/>						
							</c:otherwise>
						</c:choose>
					</a>
				</td>
				<td headers="th1" valign="top" align="left" class="t_td" id="WC_WishListDisplay_TableCell_13_<c:out value="${status.count}"/>">
					<a href="<c:out value="${ProductDisplayURL}" />" id="WC_WishListDisplay_Link_0_<c:out value="${status.count}"/>">
					<span class="productName"><c:out value="${interestItem.catalogEntryDataBean.description.name}" escapeXml="false"/></span></a>
					<br/>
					<c:out value="${interestItem.catalogEntryDataBean.description.shortDescription}" escapeXml="false"/>
					<br/><br/>
					<%-- 
						***
						* Begin: display order item attributes 
						***
					--%>
					<c:choose>					
						<c:when test="${interestItem.catalogEntryDataBean.item}">
							<%-- If the catentry is an item, we get all the attributes and attribute values for the item using AttributeValueDataBean and AttributeDataBean --%>
							<c:set var="item" value="${interestItem.catalogEntryDataBean.itemDataBean}" />
							<c:forEach var="attr" items="${item.attributeValueDataBeans}"> 	
								<c:set var="attribute" value="${attr.attributeDataBean}" />
									<c:if test="${attribute.definingAttribute}">
										<span class="text"><c:out value="${attribute.name}" escapeXml="false"/>:
										<c:out value="${attr.value}" escapeXml="false"/></span><br/>
									</c:if>
							</c:forEach>									
						</c:when>
						<c:otherwise>	
							<span class="text"><c:out value="${interestItem.catalogEntryDataBean.description.auxDescription1}" escapeXml="false"/></span>&nbsp;
						</c:otherwise>
					</c:choose>
					<%-- 
						***
						* End: display order item attributes
						***
					--%>		
				</td>
				
				<td headers="th2" align="right" valign="middle" class="t_td" width="16%" id="WC_WishListDisplay_TableCell_14_<c:out value='${status.count}'/>">
				<%-- 
				  ***
				  *	Start: Catalog Entry Price
				  ***
				--%>
				<c:set var="catalogEntry" value="${interestItem.catalogEntryDataBean}"/>
				<c:set var="type" value="catalogEntry"/>
				<span class="t_rght"><%@ include file="../../../Snippets/ReusableObjects/CatalogEntryPriceDisplay.jspf"%></span>
				<%-- 
				  ***
				  *	End: Catalog Entry Price
				  ***
				--%>						
				</td>
				
				<%-- 
				  ***
				  *	Start: "Add to Cart" and "Remove" buttons
				  ***
				--%>
				<td headers="th3" valign="top" class="t_td" width="16%" id="WC_WishListDisplay_TableCell_15">
				<input type="hidden" name="catEntryId_<c:out value="${status.count}"/>" value="<c:out value="${interestItem.catEntryID}"/>" id="WC_WishListDisplay_FormInput_catEntryId_<c:out value="${status.count}"/>_In_WishListForm_1"/>
				<input type="hidden" name="quantity_<c:out value="${status.count}"/>" value="1" id="WC_WishListDisplay_FormInput_quantity_<c:out value="${status.count}"/>_In_WishListForm_1"/>
				<c:if test="${interestItem.catalogEntryDataBean.calculatedContractPriced && interestItem.catalogEntryDataBean.buyable ne '0'}" >
				
					<c:url var="SingleOrderItemAddURL" value="OrderItemAdd">
						<c:param name="catEntryId" value="${interestItem.catEntryID}" />
						<c:param name="calculationUsageId" value="-1" />
						<c:param name="quantity" value="1" />
						<c:param name="errorViewName" value="ProductDisplayErrorView" />
						<c:param name="URL" value="SetPendingOrder?URL=OrderCalculate?URL=OrderItemDisplay" />
						<c:param name="storeId" value="${WCParam.storeId}" />
						<c:param name="catalogId" value="${WCParam.catalogId}" />
						<c:param name="langId" value="${langId}" />						
					</c:url>						
					<a href="<c:out value="${SingleOrderItemAddURL}" />" id="WC_WishListDisplay_Link_2" class="t_button">
						<fmt:message key="WISHLIST_ADD_SHOPPING_CART" bundle="${storeText}" />
					</a>
				</c:if>
				<%-- 
					***
					* This page is included by the SharedWishList page with the variable 'sharedWishList' 
					* set to 'true'.  So, the 'Remove' button will not be displayed in the SharedWishList page.
					***
				--%>						
				<c:if test="${sharedWishList != 'true'}" >
					<c:url var="interestItemDeleteURL" value="InterestItemDelete">
						<c:param name="catEntryId" value="${interestItem.catEntryID}" />
						<c:param name="URL" value="InterestItemDisplay" />
						<c:param name="storeId" value="${WCParam.storeId}" />
						<c:param name="catalogId" value="${WCParam.catalogId}" />
						<c:param name="langId" value="${langId}" />
						<c:param name="listId" value="." />
					</c:url>						
					<a href="<c:out value="${interestItemDeleteURL}" />" id="WC_WishListDisplay_Link_3_<c:out value='${status.count}'/>" class="t_button">
						<fmt:message key="WISHLIST_REMOVE" bundle="${storeText}" />
					</a>
					<br/>
				</c:if>
				</td>						
				<%-- 
				  ***
				  *	End: "Add to Cart" and "Remove" buttons
				  ***
				--%>
			</tr>
			</c:forEach>
			
			<tr>
				<td colspan="4" valign="top" class="t_td" width="100%" id="WC_WishListDisplay_TableCell_10">
					<a href="#" onclick="submitForm(document.WishListForm); return false;" class="button" id="WC_WishListDisplay_Link_5">
						<fmt:message key="WISHLIST_ADDALLITEMS" bundle="${storeText}" /></a>
					<br/><br/>
				</td>
			</tr>					
			</tbody>
			</table>
			</form>
			<%--
				***
				* End: Wish List Form
				***
			--%>

			<%-- 
				***
				* Start: Form to send your wish list friends and/or family. 
				* This page is included by the SharedWishList page with the variable 'sharedWishList' 
				* set to 'true'.  So, the Send Wish List Form will not be displayed in the SharedWishList page.
				***
			--%>						
			<c:if test="${sharedWishList != 'true'}" >
				<c:if test="${userType != 'G'}">
					<c:choose>
						<c:when test="${locale == 'ja_JP' || locale == 'ko_KR' || locale == 'zh_CN' || locale == 'zh_TW'}">
							<c:set var="strSenderName" value="${bnRegister.lastName} ${bnRegister.firstName}" />
						</c:when>
						<c:otherwise>
							<c:set var="strSenderName" value="${bnRegister.firstName} ${bnRegister.lastName}" />
						</c:otherwise>
					</c:choose>
					<c:set var="strSenderEmail" value="${bnRegister.firstName} ${bnRegister.email1}" />
				</c:if>					
	
				<h2><fmt:message key="WISHLIST_SHARE_WISHLIST" bundle="${storeText}" /></h2>

				<form name="SendMsgForm" method="post" action="InterestItemListMessage" id="SendMsgForm">
				<input type="hidden" name="storeId" value="<c:out value="${WCParam.storeId}" />" id="WC_WishListDisplay_FormInput_storeId_In_SendMsgForm_1"/>
				<input type="hidden" name="catalogId" value="<c:out value="${WCParam.catalogId}" />" id="WC_WishListDisplay_FormInput_catalogId_In_SendMsgForm_1"/>
				<input type="hidden" name="langId" value="<c:out value="${langId}" />" id="WC_WishListDisplay_FormInput_langId_In_SendMsgForm_1"/>
				<input type="hidden" name="listId" value="<c:out value="${listId[0]}" />" id="WC_WishListDisplay_FormInput_listId_In_SendMsgForm_1"/>
				<input type="hidden" name="URL" value="SendWishListMsg" id="WC_WishListDisplay_FormInput_URL_In_SendMsgForm_1"/>
				<input type="hidden" name="errorViewName" value="SendWishListMsg" id="WC_WishListDisplay_FormInput_errorViewName_In_SendMsgForm_1"/>
				<input type="hidden" name="sender" value="<c:out value="${strSender}" />" id="WC_WishListDisplay_FormInput_sender_In_SendMsgForm_1"/>

				<table cellpadding="0" cellspacing="0" border="0" class="t_table" id="table">
				<tr>
					<td class="t_td2">
						<fmt:message key="SENDEMAIL" bundle="${storeText}" />&nbsp;
						<fmt:message key="SENDEMAIL1" bundle="${storeText}" />
					</td>
					<td align="right" valign="bottom" rowspan="9">
						<img src="<c:out value="${jspStoreImgDir}"/>/images/wish_list.jpg" alt="" border="0"/>
					</td>
				</tr>
				<tr>
					<td class="t_td2">
						<label for="WC_WishListDisplay_FormInput_recipient_In_SendMsgForm_1"><fmt:message key="WISHLIST_TO" bundle="${storeText}" /></label>
						<span class="required">*</span><fmt:message key="WISHLIST_EMAIL" bundle="${storeText}" />
					</td>
				</tr>					
				<tr>
					<td><input type="text" size="35" maxlength="50" name="recipient" title="recipient" value="<c:out value="${WCParam.recipient}"/>" id="WC_WishListDisplay_FormInput_recipient_In_SendMsgForm_1"/></td>
				</tr>
				<tr>
					<td class="t_td2">
						<label for="WC_WishListDisplay_FormInput_sender_name_In_SendMsgForm_1"><fmt:message key="WISHLIST_FROM" bundle="${storeText}" /></label>
						<span class="required">*</span><fmt:message key="WISHLIST_NAME" bundle="${storeText}" />
					</td>
				</tr>					
				<tr>
					<td><input type="text" size="35" maxlength="110" name="sender_name" title="sender_name" value="<c:out value="${WCParam.sender_name}"/>" id="WC_WishListDisplay_FormInput_sender_name_In_SendMsgForm_1"/></td>
				</tr>
				<tr>
					<td class="t_td2">
						<label for="WC_WishListDisplay_FormInput_sender_email_In_SendMsgForm_1"><fmt:message key="WISHLIST_EMAIL" bundle="${storeText}" /></label>
					</td>
				</tr>					
				<tr>
					<td><input type="text" size="35" maxlength="50" name="sender_email" title="sender_email" value="<c:out value="${WCParam.sender_email}"/>" id="WC_WishListDisplay_FormInput_sender_email_In_SendMsgForm_1"/></td>
				</tr>
				<tr>
					<td class="t_td2">
						<label for="wishlist_message"><fmt:message key="WISHLIST_MESSAGE" bundle="${storeText}" /></label>
					</td>
				</tr>					
				<tr>
					<td><textarea rows="6" cols="75" name="wishlist_message" title="wishlist_message" id="wishlist_message"><c:out value="${WCParam.wishlist_message}"/></textarea></td>
				</tr>
				</table>
				<br/>
				<a href="javascript:checkEmailForm(document.SendMsgForm)" class="button" id="WC_WishListDisplay_Link_6"><fmt:message key="SENDWISHLIST" bundle="${storeText}" /></a>
				<%--
					***
					* End: Form to send your wish list friends and/or family. 
					***
				--%>
				</form>
			</c:if>

		</c:otherwise>
	</c:choose>

			</td>
		</tr>
	</tbody>
</table>

	<script type="text/javascript" language="javascript">
	var busy = false;
	
	function submitForm(form)
	{
		if (!busy){
			busy = true;
			form.submit();
		}
	}
	
	function checkEmailForm(form)
	{
		form.sender_name.value = form.sender_name.value.replace(/^\s+/g, "");
		form.recipient.value = form.recipient.value.replace(/^\s+/g, "");
	
		if (form.sender_name.value == '')
			alert("<fmt:message key="WISHLIST_MISSINGNAME" bundle="${storeText}" />");
		else if (form.recipient.value == '')
			alert("<fmt:message key="WISHLIST_MISSINGEMAIL" bundle="${storeText}" />");
		else
			form.submit();
	}

	</script>

	<%-- Hide CIP --%>
	<c:set var="HideCIP" value="true"/>

<%@ include file="../../../include/LayoutContainerBottom.jspf"%>

</body>
</html>

<!-- End - JSP File Name:  WishListDisplay.jsp -->
