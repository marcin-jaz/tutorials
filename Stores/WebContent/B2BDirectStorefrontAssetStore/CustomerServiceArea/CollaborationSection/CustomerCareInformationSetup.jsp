<%--
/*
 *-------------------------------------------------------------------
 * Licensed Materials - Property of IBM 
 *
 * WebSphere Commerce
 *
 * (c) Copyright International Business Machines Corporation. 2003
 *     All rights reserved.
 *
 * US Government Users Restricted Rights - Use, duplication or
 * disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
 *-------------------------------------------------------------------
*/
////////////////////////////////////////////////////////////////////////////////
//
// Change History
//
// YYMMDD    F/D#   WHO       Description
//------------------------------------------------------------------------------
// 030819    677    wrehman   xhtml conversion
//
////////////////////////////////////////////////////////////////////////////////
--%>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.ibm.commerce.server.*" %>
<%@ page import="com.ibm.commerce.command.*" %>
<%@ page import="com.ibm.commerce.catalog.beans.*" %>
<%@ page import="com.ibm.commerce.beans.*" %>
<%@ page import="com.ibm.commerce.order.beans.*" %>
<%@ page import="com.ibm.commerce.order.objects.*" %>
<%@ page import="com.ibm.commerce.price.beans.*" %>
<%@ page import="com.ibm.commerce.datatype.*" %>
<%@ page import="com.ibm.commerce.catalog.beans.*" %>
<%@ page import="com.ibm.commerce.webcontroller.ControllerCmdExecUnit" %>
<%@ page import="com.ibm.commerce.order.utils.OrderConstants" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ include file="../../include/EnvironmentSetup.jspf"%>
<%
JSPHelper jhelper = new JSPHelper(request);
String storeId = jhelper.getParameter("storeId");
long shoppingCartItems = 0; 
%>
<wcbase:useBean id="userRDB" classname="com.ibm.commerce.user.beans.UserRegistrationDataBean" />
<%
String customer_name="";

customer_name=userRDB.getUserId();
if (userRDB.findUser()){
   if (userRDB.getLastName() !=null && userRDB.getLastName().length() > 0){
         if (locale.toString().equals("ja_JP")||locale.toString().equals("ko_KR")||locale.toString().equals("zh_CN")||locale.toString().equals("zh_TW"))
            {customer_name = userRDB.getLastName() + " " + userRDB.getFirstName();}
         else
            {customer_name = userRDB.getFirstName() + " " + userRDB.getLastName();}
      }
}
if (customer_name.equals("-1002")) {
	customer_name="";
	}
else {
	// need to check order items
	OrderListDataBean orderListBean = new OrderListDataBean();
	orderListBean.setStoreId(new Integer(storeId));
	orderListBean.setOrderStatus("P");
	orderListBean.setUserId(cmdcontext.getUserId());
	DataBeanManager.activate(orderListBean, request); 
	Vector pendingOrders = orderListBean.getOrders();
	for (int k=0; k< pendingOrders.size(); k++) {
		OrderAccessBean next_order = (OrderAccessBean) pendingOrders.elementAt(k);
		OrderDataBean orderBean = new OrderDataBean();
		orderBean.setOrderId(next_order.getOrderId());
		DataBeanManager.activate(orderBean, request);		
		//Get items in the order
		OrderItemDataBean [] orderItems = orderBean.getOrderItemDataBeans();
		for (int i = 0; ((orderItems != null) && (i < orderItems.length)); i++) 
		{
			OrderItemDataBean orderItem = orderItems[i];
			shoppingCartItems += orderItem.getQuantityInEJBType().longValue();
		}
	}
}
customer_name=customer_name.trim();

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<!-- BEGIN CustomerCareInformationSetup.jsp -->
<head>
<title><%=ccResBundle.getString("customerCarePageTitleShopperInformation")%></title>
<script language="javascript">
function isLoad()
{ return;}

function changeSTAttributes()
{ 
	if (typeof top.setCustomerName == 'function') {
	   top.setCustomerName(<%=userRDB.getUserId()%>, '<%=customer_name%>');
	   top.setShoppingCartItems(<%=shoppingCartItems%>);
	   top.setStoreLocale('<%=locale.toString()%>');
	   top.changeSTAttributes();
	   }
}

</script>
</head>
<body onLoad="changeSTAttributes();">
</body>
<!-- END CustomerCareInformationSetup.jsp -->
</html>
