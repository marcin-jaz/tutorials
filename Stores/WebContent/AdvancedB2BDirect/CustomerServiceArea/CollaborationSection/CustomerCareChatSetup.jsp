<%
//********************************************************************
//*-------------------------------------------------------------------
//* Licensed Materials - Property of IBM
//*
//* WebSphere Commerce
//*
//* (c) Copyright IBM Corp. 2001, 2002
//*
//* US Government Users Restricted Rights - Use, duplication or
//* disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
//*
//*-------------------------------------------------------------------
//*
%>
<%@ page import="java.util.*" %>
<%@ page import="java.lang.Math" %>
<%@ page import="com.ibm.commerce.ras.*" %>
<%@ page import="com.ibm.commerce.beans.*" %>
<%@ page import="com.ibm.commerce.datatype.*" %>
<%@ page import="com.ibm.commerce.server.*" %>
<%@ page import="com.ibm.commerce.command.*" %>
<%@ page import="com.ibm.commerce.user.beans.*" %>
<%@ page import="com.ibm.commerce.order.beans.*" %>
<%@ page import="com.ibm.commerce.order.objects.*" %>
<%@ page import="com.ibm.commerce.tools.util.UIUtil" %>
<%@ page import="com.ibm.commerce.collaboration.livehelp.beans.*" %>
<%@ include file="../../include/EnvironmentSetup.jspf"%>
<%
	int MAX_RANDOM_USER_ID=1000000;
	JSPHelper jhelper = new JSPHelper(request);
	String PageDesc=jhelper.getParameter("pageDesc");
	String PageURL=jhelper.getParameter("pageURL");
	String storeId = cmdcontext.getStoreId().toString();
	String langId = cmdcontext.getLanguageId().toString();
	String placeName = storeId + "_store" + "@" + LiveHelpShopperConfiguration.getInstanceName();
	String queueName = storeId + "_store" + "_queue" + "@" + LiveHelpShopperConfiguration.getInstanceName();
	String codeBase = LiveHelpShopperConfiguration.getAppletCodeBaseURL();
	String sametimeHostName = LiveHelpShopperConfiguration.getHostName();
	String monitorType = LiveHelpShopperConfiguration.getMonitorType();
	String customer_name="";
	String customer_Id="";
	int shoppingCartItems = 0; 
	String sQueueId="";  //Store developer should implement logic to set QueueId.
	String sCSRName="";
	try {
		sCSRName=(String) ccResBundle.getString("customerCareCSRName");
		if (sCSRName==null) { 
			sCSRName="";
			} 
		else {
			sCSRName=sCSRName.trim();
			}
	} catch (Exception ex) {
		sCSRName="";
		}
%>
<wcbase:useBean id="userRDB" classname="com.ibm.commerce.user.beans.UserRegistrationDataBean" />
<%
	/* Get or create the shopper Id/name */
	customer_Id=userRDB.getUserId();
	if (userRDB.findUser()){
	   if (userRDB.getLastName() !=null && userRDB.getLastName().length() > 0){
		 if (locale.toString().equals("ja_JP")||locale.toString().equals("ko_KR")||locale.toString().equals("zh_CN")||locale.toString().equals("zh_TW"))
		    { customer_name = userRDB.getLastName() + " " + userRDB.getFirstName(); }
		 else
		   { customer_name = userRDB.getFirstName() + " " + userRDB.getLastName();}
	      }
	}
	if (customer_Id.equals("-1002"))  { 
		double dbId=Math.random()*MAX_RANDOM_USER_ID + 1;
		long randomId=(long) dbId;
		customer_Id=customer_Id + randomId;
		customer_name="" + randomId;
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
				shoppingCartItems += orderItem.getQuantityInEJBType().intValue();
				}
			}
		}
	customer_name=customer_name.trim();
	customer_Id=customer_Id.trim();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<!-- BEGIN CustomerCareChatSetup.jsp -->
<head>
<title><%=ccResBundle.getString("customerCareTitle")%></title>
</head>
<body topmargin="0" bottommargin="0" rightmargin="0" leftmargin="0" marginwidth="0" marginheight="0" marginwidth="0" bgcolor="#FFFFFF">
<%
		  if (LiveHelpShopperConfiguration.isEnabled()) 
		  {
		   %>
<center>
  <applet name="InteractivePresenceApplet" width="400" height="360" align="middle" mayscript="true" scriptable="true" alt="<%=ccResBundle.getString("customerCareTitle")%>" code="com.ibm.commerce.collaboration.livehelp.st.wcscustomer.InteractivePresenceApplet.class" codebase="<%= codeBase %>">
    <param name="MAYSCRIPT" value="true"/>
    <param name="scriptable" value="true"/>
    <param name="cabbase" value="WCSAware.cab"/>
    <param name="archive" value="WCSAware.jar"/>
    <param name="PLACE_NAME" value="<%= placeName %>"/>
    <param name="PLACE_DISPLAY_NAME" value="<%= placeName %>"/>
    <param name="QUEUE_NAME" value="<%= queueName %>"/>
    <param name="SAMETIME_SERVER" value="<%= sametimeHostName %>"/>
    <param name="contentFrame" value="_blank"/>
    <param name="WAIT_RANGE_1" value="10"/>
    <param name="WAIT_RANGE_2" value="20"/>
    <param name="WAIT_RANGE_3" value="50"/>
    <param name="USE_FRAMESET" value="0"/>
    <param name="MONITOR_TYPE" value="<%=monitorType%>"/>
    <param name="ML_PAGE_URL" value="<%=PageURL%>"/>
    <param name="ML_PAGE_DESC" value="<%=PageDesc%>"/>
    <param name="ML_CART" value="<%=shoppingCartItems%>"/>
    <param name="ML_SHOPPER_NAME" value="<%=customer_name%>"/>
    <param name="ML_SHOPPER_ID" value="<%=customer_Id%>"/>
    <param name="ML_LANG_ID" value="<%=langId%>"/>
    <param name="ML_STORE_ID" value="<%=storeId%>"/>
    <param name="QUEUE_ID" value="<%=sQueueId%>"/>
    <param name="CHAT_FONT_SIZE" value="12"/>
    <param name="CHAT_NAME_LENGTH" value="15"/>
    <param name="CHAT_FONT_COLOR" value="#0000FF"/>
    <param name="LOCALE" value="<%=locale.toString()%>"/>
    <param name="MSG_TEXT_CSR" value="<%=sCSRName%>"/>
  </applet>
</center>
<%
		  }
%>
</body>
<!-- END CustomerCareChatSetup.jsp -->
</html>
