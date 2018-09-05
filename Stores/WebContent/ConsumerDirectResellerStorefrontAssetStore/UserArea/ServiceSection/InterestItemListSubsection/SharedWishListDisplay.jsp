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
  * This page shows a wishlist that has been shared to you by another user
  *
  * -A list of order items that a user has added to their wish list
  * 	- For each interest item:
  * 		- Checkbox to select the item (used to select products that user wants to add to their shopcart)
  *			- Clickable item name (links to display page for order item)
  * 		- Attribute values for each interest item
  *			- Item price 
  * - 'Add Selected items to shopping cart' button (adds item to Shopping Cart)
  *****
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf" %>
<!-- Start - JSP File Name: SharedWishListDisplay.jsp -->

<%-- 
	***
	* By setting the variable 'sharedWishList' to 'true', this page will not display
	* the 'Remove' button and the Send Wish List form.
	***
--%>
<c:set var="sharedWishList" value="true" scope="request" />
<c:import url="WishListDisplay.jsp"/> 

<!-- End - JSP File Name: SharedWishListDisplay.jsp -->