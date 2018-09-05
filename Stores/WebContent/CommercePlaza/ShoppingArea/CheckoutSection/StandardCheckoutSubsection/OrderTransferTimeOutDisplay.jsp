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


<% // All JSPs requires the first 4 packages for EnvironmentSetup.jsp which is used for multi language support %> 
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.ibm.commerce.server.JSPHelper" %>
<%@ page import="com.ibm.commerce.server.ECConstants" %>
<%@ page import="com.ibm.commerce.command.CommandContext" %>

<%@ page import="com.ibm.commerce.server.*" %>
<%@ page import="com.ibm.commerce.command.*" %>
<%@ page import="com.ibm.commerce.beans.*" %>
<%@ page import="com.ibm.commerce.datatype.*" %>
<%@ page import="com.ibm.commerce.beans.UrlCommandInvokerDataBean" %>
<%@ page import="com.ibm.commerce.datatype.TypedProperty"%>

<%@ include file="../../../include/EnvironmentSetup.jsp"%>
<script language="javascript">

function submitForm(form) {
  form.submit();
}

</script>
<?xml version="1.0"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "DTD/xhtml1-transitional.dtd">

<head>
  <title><%=storeText.getString("OrderTransferTimeOutDisplay_Title")%></title>
  <link rel=stylesheet href="<%=fileDir%>PCDMarket.css" type="text/css">
</head>
<%
try {
//Parameters may be encrypted. Use JSPHelper to get URL parameter instead of request.getParameter().
String orderRn = jhelper.getParameter("orderId");
String channelOrderRn = jhelper.getParameter("channelOrderId");
String forwardView = jhelper.getParameter("forwardView");
String multipleShopcart = jhelper.getParameter("multipleShopcart");
String autoOpen = jhelper.getParameter("autoOpen");
String[] orderIds = jhelper.getParameterValues("orderId");
String childOrderId = jhelper.getParameter("childOrderId");
String openAllWindows = jhelper.getParameter("openAllWindows");
String[] timeoutOrderIds = jhelper.getParameterValues("timeoutOrderId"); 
String[] waitOrderIds = jhelper.getParameterValues("waitOrderId"); 
Integer[] distIdList = cmdcontext.getStore().getRelatedStores("com.ibm.commerce.referral");

// if there are still waiting orders, continue to check using OrderTransferWaitDisplayView until no waiting orders
if (waitOrderIds != null && waitOrderIds.length >0) 
{
	%>
		<form name="TimeOutForm" method="POST" action="OrderTransferWaitDisplayView">
		<input type=hidden name="channelOrderId" value="<%=channelOrderRn%>">
		<input type=hidden name="forwardView" value="<%=forwardView%>">
		<input type=hidden name="multipleShopcart" value="<%=multipleShopcart%>">
		<input type=hidden name="autoOpen" value="<%=autoOpen%>">
		<input type=hidden name="storeId" value="<%=storeId%>">
		<input type=hidden name="catalogId" value="<%=catalogId%>">
		<input type=hidden name="openAllWindows" value="<%=openAllWindows%>">	
	<%
	if (orderIds != null && orderIds.length > 0)
	{
		for(int i=0;i<orderIds.length;i++)
		{
	%>
		<input type=hidden name="orderId" value="<%=orderIds[i]%>">		
	<%
		}
	}
  %>  
		</form>
<%
}
else
{
	// get the IDs of the failed orders
  String[] failedOrderIds = jhelper.getParameterValues("failOrderId");   
  String forwardFile = null;
  
  // if there are any errors with code 1, forwardFile will be set to "DistributorSelectionDisplayView"
  if ((failedOrderIds!= null) && (failedOrderIds.length>0)) {
    for(int i=0;i<failedOrderIds.length;i++) {
      StringTokenizer st = new StringTokenizer(failedOrderIds[i], "_");
      String fOrderId = st.nextToken();
      String errorCode = st.nextToken();
      if (errorCode!=null && errorCode.equals("1")) {
        forwardFile = "DistributorSelectionDisplayView";
      }
    }
  }
  // if there are any errors with code 1, foward to /servlet/DistributorSelectionDisplayView
  if (forwardFile != null) {

	UrlCommandInvokerDataBean urlBean = new UrlCommandInvokerDataBean();
	urlBean.setUrlName(forwardFile);
	TypedProperty iProperties = cmdcontext.getRequestProperties();
	iProperties.putUrlParam("storeId",cmdcontext.getStoreId());

	urlBean.setRequestProperties(iProperties);  
	com.ibm.commerce.beans.DataBeanManager.activate(urlBean, request);

  } else {
  // else (i.e. no waiting orders and no errors with code 1), go to ShopCartOrderConfirmationDisplay page
  %>
		<form name="TimeOutForm" method="POST" action="ShopCartOrderConfirmationDisplayView">
		<input type=hidden name="childOrderId" value="<%=childOrderId%>">
		<input type=hidden name="storeId" value="<%=storeId%>">
		<input type=hidden name="catalogId" value="<%=catalogId%>">
		<input type=hidden name="channelOrderId" value="<%=channelOrderRn%>">
		<input type=hidden name="multipleShopcart" value="<%=multipleShopcart%>">
		<input type=hidden name="autoOpen" value="<%=autoOpen%>">
		<input type=hidden name="forwardView" value="<%=forwardView%>">
		<input type=hidden name="openAllWindows" value="<%=openAllWindows%>">	
    <%
    	if (timeoutOrderIds != null) {
      	for(int i=0;i<timeoutOrderIds.length;i++) {
      %>
      		<input type=hidden name="timeoutOrderId" value="<%=timeoutOrderIds[i]%>">	
      <%	
      	}
      }
    %>
		</form>
	<%
	}
}

}
catch (Exception e)
{
	out.println("e:"+e);
}
%>
<body marginheight="0" marginwidth="0" onLoad="setTimeout('submitForm(document.TimeOutForm)', 0)">
</body>
</html>
