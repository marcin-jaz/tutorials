<%
//********************************************************************
//*-------------------------------------------------------------------
//* Licensed Materials - Property of IBM
//*
//* 5697-D24
//*
//* (c) Copyright IBM Corp. 2000, 2002
//*
//* US Government Users Restricted Rights - Use, duplication or
//* disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
//*
//*-------------------------------------------------------------------
//*
%>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="com.ibm.commerce.beans.*" %>
<%@ page import="com.ibm.commerce.server.*" %>
<%@ page import="com.ibm.commerce.command.*" %>
<%@ page import="com.ibm.commerce.datatype.*" %>
<%@ page import="com.ibm.commerce.registry.*" %>
<%@ page import="com.ibm.commerce.common.beans.*" %>
<%@ page import="com.ibm.commerce.webcontroller.*" %>
<%@ page import="com.ibm.commerce.catalog.beans.*" %>
<%@ page import="com.ibm.commerce.catalog.objects.*" %>
<%@ page import="com.ibm.commerce.order.beans.*" %>
<%@ page import="com.ibm.commerce.order.utils.*"   %>
<%@ page import="com.ibm.commerce.order.objects.*" %>
<%@ include file="../../../include/EnvironmentSetup.jsp"%>
<% response.setContentType(storeText.getString("ENCODESTATEMENT")); %>
<jsp:useBean id="orderBean" class="com.ibm.commerce.order.beans.OrderDataBean" scope="page">
</jsp:useBean>
<%	
	boolean bHasShopCart = false;
	String incfile;

	// Retrieve shopping cart
	TypedProperty requestProperty = (TypedProperty) request.getAttribute(ECConstants.EC_REQUESTPROPERTIES);    	
	String [] orderRefNum = (String[]) requestProperty.get(OrderConstants.EC_ORDER_ID, null);	
	OrderItemAccessBean orderItem;
	OrderItemAccessBean [] orderItems = null;

	if (orderRefNum != null && orderRefNum.length > 0) {
		orderBean.setOrderId(orderRefNum[0]);
		com.ibm.commerce.beans.DataBeanManager.activate(orderBean, request);
		orderBean.setCommandContext(cmdcontext);
		orderItems = orderBean.getOrderItems();
		if (orderItems != null && orderItems.length > 0)
		{
			bHasShopCart = true;
		}
	}
	
	if (bHasShopCart)
	{
		incfile = storeDir + "ShoppingArea/CheckoutSection/StandardCheckoutSubsection/CurrentShopCartDisplay.jsp";
	}
	else
	{
		incfile = storeDir + "ShoppingArea/CheckoutSection/StandardCheckoutSubsection/EmptyShopCartDisplay.jsp";
	}

%>
<jsp:include page="<%=incfile%>" flush="true"/>
