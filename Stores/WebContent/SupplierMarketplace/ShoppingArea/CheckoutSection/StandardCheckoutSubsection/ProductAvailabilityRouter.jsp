<%
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


<% // All JSPs requires these packages for EnvironmentSetup.jsp which is used for multi language support %> 
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.ibm.commerce.server.ECConstants" %>
<%@ page import="com.ibm.commerce.server.JSPHelper" %>
<%@ page import="com.ibm.commerce.server.JSPResourceBundle" %>
<%@ page import="com.ibm.commerce.command.CommandContext" %>

<% // Page specific imports%> 
<%@ page import="com.ibm.commerce.beans.DataBeanManager" %>
<%@ page import="com.ibm.commerce.order.beans.OrderDataBean" %>
<%@ page import="com.ibm.commerce.order.beans.OrderItemDataBean" %>
<%@ page import="com.ibm.commerce.beans.UrlCommandInvokerDataBean" %>
<%@ page import="com.ibm.commerce.datatype.TypedProperty"%>


<%@ include file="../../../include/EnvironmentSetup.jspf"%>

<flow:ifEnabled feature="customerCare">
<%
// Set header type needed for this JSP for LiveHelp.  This must
// be set before HeaderDisplay.jsp
request.setAttribute("liveHelpPageType", "personal");
%>
</flow:ifEnabled>

<%
try{
//Parameters may be encrypted. Use JSPHelper to get
//URL parameter instead of request.getParameter().
JSPHelper jhelper = new JSPHelper(request);

String orderRn = jhelper.getParameter("orderId");

%>

<jsp:useBean id="orderBean" class="com.ibm.commerce.order.beans.OrderDataBean" scope="page">
<% 
orderBean.setOrderId(orderRn);
com.ibm.commerce.beans.DataBeanManager.activate(orderBean, request);
%>
</jsp:useBean>

<%
/*
This page checks if there is sufficient inventory available for the order items.
If all the order items are available, or all the order items are on backorder, OrderDisplay is called
 to show the Order Summary page.
If some order items are available, and some order items are unavailable, the Product Availability 
 page is displayed.
*/

// Loop through all OrderItemBeans and check which have not been allocated
boolean bAllOrderItemsAvailable = true;
boolean bAllOrderItemsOnBackorder = true;
OrderItemDataBean [] orderItems = orderBean.getOrderItemDataBeans();	
String inventoryStatus = "";
for (int i=0; i < orderItems.length; i ++)
{
	
	inventoryStatus = orderItems[i].getInventoryStatus();

	// if we find an item that cannot be allocated (NALC), set bAllOrderItemsAvailable and bAllOrderItemsAvailable to false
	if (inventoryStatus.equalsIgnoreCase("nalc")){
		bAllOrderItemsAvailable = false;
		bAllOrderItemsOnBackorder = false;		
	}
	// if we find an item on backorder, we know that all items arent available
	else if (inventoryStatus.equalsIgnoreCase("bo")){
		bAllOrderItemsAvailable = false;
	}
	/* if we find an item allocated, we know that not all items can be on backorder*/
	else if (inventoryStatus.equalsIgnoreCase("allc")) {
		bAllOrderItemsOnBackorder = false;
	}
	
	/* break out of the loop once we know that we will know we have a mix of 
	   unavailable and available items*/ 
	if ((!bAllOrderItemsAvailable) && (!bAllOrderItemsOnBackorder)) {
		break;
	}
	
}

String incfile = storeDir + "";

/* Go the order summary only if items are all on backorder or all allocated,
   otherwise go to ProductAvailability page to show the availability of each item */
if (bAllOrderItemsAvailable || bAllOrderItemsOnBackorder) {

	// Forward to OrderDisplay command and display the Order Summary page
       UrlCommandInvokerDataBean urlBean = new UrlCommandInvokerDataBean();
       urlBean.setUrlName("OrderDisplay");
       TypedProperty iProperties = cmdcontext.getRequestProperties();
       iProperties.putUrlParam("merge","*n");
       iProperties.putUrlParam("remerge","*");
       iProperties.putUrlParam("check","*n");
       iProperties.putUrlParam("allocate","*aig");
       iProperties.putUrlParam("allocate","*ubg");              
       iProperties.putUrlParam("backorder","*aig");
       iProperties.putUrlParam("backorder","*ubg");
       iProperties.putUrlParam("reverse","*n");

       urlBean.setRequestProperties(iProperties);  
       com.ibm.commerce.beans.DataBeanManager.activate(urlBean, request);
       
} else {
	incfile += "ShoppingArea/CheckoutSection/StandardCheckoutSubsection/ProductAvailabilityDisplay.jsp";
	%>
	<jsp:include page="<%=incfile%>" flush="true"/>
	<%
}


} catch  (Exception e) {
	System.out.println("Error: " + e);
	e.printStackTrace();
}
%>
