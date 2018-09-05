<%
//********************************************************************
//*-------------------------------------------------------------------
//* Licensed Materials - Property of IBM
//*
//* WebSphere Commerce
//*
//* (c) Copyright IBM Corp. 2002
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
<%@ page import="com.ibm.commerce.server.*" %>
<%@ page import="com.ibm.commerce.command.*" %>

<%@ page import="javax.servlet.*" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="com.ibm.commerce.beans.*" %>
<%@ page import="com.ibm.commerce.common.beans.*" %>
<%@ page import="com.ibm.commerce.common.objects.*" %>
<%@ page import="com.ibm.commerce.order.beans.*" %>
<%@ page import="com.ibm.commerce.order.objects.*" %>
<%@ page import="com.ibm.commerce.user.beans.*" %>
<%@ page import="com.ibm.commerce.user.objects.*" %>
<%@ page import="com.ibm.commerce.orderstatus.beans.*" %>
<%@ page import="com.ibm.commerce.utils.TimestampHelper" %>
<%@ page import="com.ibm.commerce.price.beans.FormattedMonetaryAmountDataBean" %>
<%@ page import="com.ibm.commerce.inventory.beans.OrderReleaseDataBean" %>
<%@ page import="com.ibm.commerce.server.JSPResourceBundle" %>

<%@ include file="../../../include/EnvironmentSetup.jsp"%>


<%
String orderRn = jhelper.getParameter("orderId");
String returnPage = jhelper.getParameter("page");
%>
<jsp:useBean id="orderBean" class="com.ibm.commerce.order.beans.OrderDataBean" scope="page">
<% 
	orderBean.setOrderId(orderRn);
	DataBeanManager.activate(orderBean, request); 
	orderBean.setCommandContext(cmdcontext);
%>
</jsp:useBean>

<%
OrderFulfillmentStatusDataBean orderStatusDB = orderBean.getOrderFulfillmentStatusDataBean();

OrderItemDataBean orderItem = null;
OrderItemDataBean [] orderItems = orderBean.getOrderItemDataBeans();

OrderItemDataBean parentOrderItem = null;

OrderFulfillmentItemStatusDataBean orderItemStatusDB = null;
OrderFulfillmentItemStatusDataBean [] orderItemStatusDBs = new OrderFulfillmentItemStatusDataBean[orderItems.length];

Integer[] distStoreIds = cmdcontext.getStore().getRelatedStores("com.ibm.commerce.referral");

int distributorCounter = 0;
BigDecimal lineTotalDB = new BigDecimal(0.0);
BigDecimal subtotalDB = new BigDecimal(0.0);
double subtotal = 0;

StoreAddressAccessBean storeAddAcc = new StoreAddressAccessBean();
StoreAddressDataBean storeAddress = null;
AddressDataBean address = null;

StoreEntityDataBean stEntDataBean = null;
StoreEntityDescriptionAccessBean stEntDscAccessBean = null;
String distributorName = null;
String storePhone1 = null;

for (int i=0; i<distStoreIds.length; i++) {
	if (orderBean.getStoreEntityId().trim().equals(distStoreIds[i].toString().trim())) 
		distributorCounter = i;
}

stEntDataBean = new StoreEntityDataBean();
stEntDataBean.setDataBeanKeyStoreEntityId(distStoreIds[distributorCounter].toString());
com.ibm.commerce.beans.DataBeanManager.activate(stEntDataBean, request);
stEntDscAccessBean = stEntDataBean.getDescription(new Integer(languageId));

distributorName = stEntDscAccessBean.getDisplayName();
String contactAddressId = stEntDscAccessBean.getContactAddressId();

if (contactAddressId != null)
{
  StoreAddressDataBean storeAddressDB = new StoreAddressDataBean();
  storeAddressDB.setDataBeanKeyStoreAddressId(contactAddressId);
  com.ibm.commerce.beans.DataBeanManager.activate(storeAddressDB, request);
  storePhone1 = storeAddressDB.getPhone1();
}    

// Here is the status in the orders.status column and the ordstat.osstatus column.  If orders.status equals to G, refer to the status in ordstat.osstatus column.
String [] statusChar = {"P", "W", "N", "F", "C", "S", "I"};
String [] orderStatus = {storeText.getString("DistributorCartStatus_P"), storeText.getString("DistributorCartStatus_W"), storeText.getString("DistributorCartStatus_N"), storeText.getString("DistributorCartStatus_F"), storeText.getString("DistributorCartStatus_C"), storeText.getString("DistributorCartStatus_S"), storeText.getString("DistributorCartStatus_I")};

String statusValue = "";
String status = "";
if (orderBean.getStatus() != null && !orderBean.getStatus().equals("G"))
{
	status = orderBean.getStatus();
}
else
{
	if (orderBean.getOrderFulfillmentStatusDataBean() != null)
	{
		status = orderBean.getOrderFulfillmentStatusDataBean().getOrderStatus();
	}
}
for (int k = 0; k < statusChar.length; k++) {
	if (status.equals(statusChar[k])) {
		statusValue = orderStatus[k];
		break;
	}
}
boolean isNotConfirmed = false;
if (status.equals("F"))
{
	OrderReleaseDataBean orderRelease = new OrderReleaseDataBean();
	Enumeration results = orderRelease.findByOrdersId( orderBean.getOrderIdInEJBType() );
	orderRelease = (OrderReleaseDataBean)results.nextElement();
	String extURL = orderRelease.getExternalReference();
	if(( extURL==null) || (extURL.length()==0) || (extURL.equals("null"))) {
		statusValue = storeText.getString("DistributorCartDetails_SubmissionNotConfirmed");
	}
	isNotConfirmed = true;
}			
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "DTD/xhtml1-transitional.dtd">

<head>
	<title><%=storeText.getString("DistributorCartDetails_Title")%></title>
	<link rel="stylesheet" href="<%=fileDir%>PCDMarket.css" type="text/css">
</head>
	

<body marginheight="0" marginwidth="0" leftmargin="0" topmargin="0">

<!-- Start Header File -->
<%@ include file="../../../include/HeaderDisplay.jspf"%>
<!-- End Header File -->

<!-- Start Main Table - Consists of TD for Left Bar, TD for Content and TD for Quicklinks -->
<table border="0" cellpadding="0" cellspacing="0" width="750" height="99%">
  <tr>
    <td valign="top" class="dbg" width="150"> 
      <%
      String incfile = includeDir + "SidebarDisplay.jsp";
      %>
      <jsp:include page="<%=incfile%>" flush="true"/></TD>
    <!-- End  Left Nav Bar TD -->
    
    <!-- Begin Main Content TD -->
    <td valign="top" width="600">

    <!--MAIN CONTENT STARTS HERE-->
			
	<!-- Start Main JSP Content -->

<table width="600" border="0" cellspacing="0" cellpadding="0">
  	    <tr>
	      <td width="10" height="20"><a name="mainContent"></a></td>
	      <td width="600" colspan="2"><span class="bct">&nbsp;&nbsp;&nbsp;</span>
		<a class="bctl" href="StoreCatalogDisplay?storeId=<%=storeId%>&catalogId=<%=catalogId%>&langId=<%=languageId%>"><%=storeText.getString("Breadcrumb_CommercePlaza")%></a><span class="bct">&nbsp;&nbsp;&nbsp;&gt;&nbsp;&nbsp;&nbsp;</span>
		<font class="bct"><%=storeText.getString("Breadcrumb_ShopCart")%></font>
	      </td>
	    </tr>

	    <tr>
	      <td width="10">&nbsp;</td>
	      <td valign="top" width="320">
	        <div align="left"><span class="title"><%=storeText.getString("DistributorCartDetails_Title")%></span></div><br />
	        <span class="subtitle"><%=distributorName%></span></div>	        
	      </td>		
	      <td valign="top" width="280">
	        <div align="right">
	        <img src="<%=fileDir%>images/hdr_cart.gif" width="280" height="72" alt="<%=storeText.getString("DistributorCartDetails_Title")%>"></div></td>
	    </tr>
	    <tr>
	      <td width="600" height="1" colspan="3"><img src="<%=fileDir%>images/c.gif" width="2" height="1" class="imgHeightFix" /></td>
	    </tr>
</table>	    
<table width="600" border="0" cellspacing="0" cellpadding="0">
<tr>	
	<td width="10">&nbsp;</td><td height="18" align="left" ><b><%=storeText.getString("DistributorCartDetails_PriceInquiryDate")%> <%= TimestampHelper.getDateFromTimestamp(orderBean.getLastUpdateInEJBType(),locale) %></b>&nbsp;&nbsp;</td>
</tr>
<tr>	
	<td height="18" align="left" colspan="2">&nbsp;</td>
</tr>
<tr>	
	<td width="10">&nbsp;</td><td height="18" align="left"><b><%=storeText.getString("DistributorCartDetails_Status")%> <%= statusValue %></b></td>
</tr>
<%
if (orderBean.getStatus() != null && orderBean.getStatus().equals("P"))
{
%>
<tr>	
	<td width="10">&nbsp;</td><td height="18" align="left"><b><%=storeText.getString("DistributorCartDetails_Action")%> </b> <%=storeText.getString("DistributorCartDetails_Text1")%></td>
</tr>
<%
}
else if (orderBean.getStatus() != null && orderBean.getStatus().equals("F"))
{
	if (isNotConfirmed) {
%>
<tr>	
	<td width="10">&nbsp;</td><td height="18" align="left"><b><%=storeText.getString("DistributorCartDetails_Action")%> </b> <%=storeText.getString("ShopcartOrderConfirmation_NotConfirmCall", distributorName, storePhone1 )%></td>
</tr>
<%	} else { %>
<tr>	
	<td width="10">&nbsp;</td><td height="18" align="left"><b><%=storeText.getString("DistributorCartDetails_Action")%> </b> <%=storeText.getString("DistributorCartDetails_Text2")%> </td>
</tr>
<%
	}
}
%>
<tr>	
	<td height="18" align="left" colspan="2">&nbsp;</td>
</tr>

<tr>
	<td width="10" >&nbsp;</td>
	<td>
		<table cellpadding="0" cellspacing="1" border="0" width="590">
			<tr class="tdblue">
				<td colspan="7" height="18" class="tdblue">&nbsp;&nbsp;<%=orderBean.getParentOrder().getDescription()%></td>
			</tr>
	
			<tr valign="top"> 
		                <th id="t1" align="left" valign="top" class="mbg">
		                  <table cellspacing="0" cellpadding="0" border="0"><tr><td height="18"><img src="<%=fileDir%>images/c.gif" width="2" height="1" /></td><td align="left" valign="top"><span class="small" style="font-weight: bold"><%=storeText.getString("DistributorCartDetails_DistSKU")%><br /></span></td></tr></table>
		                </th>
		                <th id="t2" width="80" align="left" valign="top" class="mbg">
		                 <table cellspacing="0" cellpadding="0" border="0"><tr><td height="18"><img src="<%=fileDir%>images/c.gif" width="2" height="1" /></td><td align="left" valign="top"><span class="small" style="font-weight: bold"><%=storeText.getString("DistributorCartDetails_PartNum")%></span></td></tr></table>
		                </th>
		                <th id="t3" align="left" valign="top" class="mbg">
		                 <table cellspacing="0" cellpadding="0" border="0"><tr><td height="18"><img src="<%=fileDir%>images/c.gif" width="2" height="1" /></td><td align="left" valign="top"><span class="small" style="font-weight: bold"><%=storeText.getString("DistributorCartDetails_Desc")%>&nbsp;&nbsp;&nbsp;</span></td></tr></table>		        
		                </th>
		                <th id="t4" width="80" align="left" valign="top" class="mbg">
		                 <table cellspacing="0" cellpadding="0" border="0"><tr><td height="18"><img src="<%=fileDir%>images/c.gif" width="2" height="1" /></td><td align="left" valign="top"><span class="small" style="font-weight: bold"><%=storeText.getString("DistributorCartDetails_Price")%>&nbsp;</span></td></tr></table>
		                </th>
		                <th id="t5" align="left" valign="top" class="mbg">
		                 <table cellspacing="0" cellpadding="0" border="0"><tr><td height="18"><img src="<%=fileDir%>images/c.gif" width="2" height="1" /></td><td align="left" valign="top"><span class="small" style="font-weight: bold"><%=storeText.getString("DistributorCartDetails_Qty")%></span></td></tr></table>
		                </th>
		                <th id="t6" align="left" valign="top" class="mbg">
		                 <table cellspacing="0" cellpadding="0" border="0"><tr><td height="18"><img src="<%=fileDir%>images/c.gif" width="2" height="1" /></td><td align="left" valign="top"><span class="small" style="font-weight: bold"><%=storeText.getString("DistributorCartDetails_LineTotal")%></span></td></tr></table>
		                </th>
			</tr>
<%		
if ((!"G".equals(orderBean.getStatus())) && (!"S".equals(orderBean.getStatus()))) 
{
	for (int j=0; ((orderItems != null) && (j < orderItems.length)); j++) 
	{
		orderItem = orderItems[j];
		orderItemStatusDB = orderItem.getOrderFulfillmentItemStatusDataBean();
		if (orderItemStatusDB != null)
		{
			orderItemStatusDBs[j] = orderItemStatusDB;
		}
%>		             
			<tr> 
				<td headers="t1" height="19" align="left"><span class="small"><%= orderItem.getSupplierPartNumber() %></span></td>
				<td headers="t2" height="19" align="left"><span class="small"><%= orderItem.getCatalogEntry().getPartNumber() %>&nbsp;</span></td>
				<td headers="t3" height="19" align="left"><span class="small"><%= orderItem.getCatalogEntry().getDescription( cmdcontext.getLanguageId() ).getShortDescription() %></span></td>
				<td headers="t4" align="right"><span class="small"><%=orderItem.getPriceDataBean()%></span></td>
				<td headers="t5" height="19" align="left"><span class="small"><%= orderItem.getFormattedQuantity() %></span></td>
				<td headers="t6" height="19" align="right"><span class="small"><%=orderItem.getFormattedTotalProduct()%></span></td>
			</tr>
<%		
		if ( orderItems.length == j+1)
		{
%>
			<tr>
			  <td colspan="6" class="bbg"><img src="<%=fileDir%>images/c.gif" width="1" height="2" border="0" class="imgHeightFix" /></td>  
			</tr>
<%
		}
		else
		{
%>
			<tr>
                          <td colspan="6" class="gbg"><img src="<%=fileDir%>images/c.gif" width="1" height="1" border="0" class="imgHeightFix" /></td>
                        </tr>
<%
		}
	}
%>
			<tr>
			  <td colspan="4"><img src="<%=fileDir%>images/c.gif" width="1" height="2" border="0" /></td>  
			  <td headers="t5" height="19" align="right"><span class="small"><b><%=storeText.getString("DistributorCartDetails_Subtotal")%></b></span></td>
			  <td headers="t6" height="19" align="right"><span class="small"><b><%=orderBean.getFormattedTotalProductPrice()%></b></span></td>
			</tr>
<%
}
else
{
	for (int j=0; ((orderItemStatusDBs != null) && (j < orderItemStatusDBs.length)); j++) 
	{
		orderItemStatusDB = orderItemStatusDBs[j];
		orderItem = orderItems[j];
		if (orderItemStatusDB != null) {
%>
			<tr> 
				<td headers="t1" height="19" align="left"><span class="small"><%= orderItemStatusDB.getPartNumber() %></span></td>
				<td headers="t2" height="19" align="left"><span class="small"><%= orderItem.getCatalogEntry().getPartNumber() %>&nbsp;</span></td>
				<td headers="t3" height="19" align="left"><span class="small"><%= orderItem.getCatalogEntry().getDescription( cmdcontext.getLanguageId() ).getShortDescription() %></span></td>
				<%
				FormattedMonetaryAmountDataBean formattedTotal = new FormattedMonetaryAmountDataBean();
				if (orderItemStatusDB.getUnitPrice() != null) 
				{
					formattedTotal.setAmount(orderItemStatusDB.getUnitPrice());				
					com.ibm.commerce.beans.DataBeanManager.activate(formattedTotal, request); 
				%>
				<td headers="t4" align="right"><span class="small"><%=formattedTotal%></span></td>
				<%
				} else {
				%>
				<td headers="t4" align="right"><span class="small">&nbsp;</span></td>
				<% } %>
				<td headers="t5" height="19" align="left"><span class="small"><%= orderItem.getFormattedQuantity() %></span></td>
				<%
				if (orderItemStatusDB.getPriceTotal() != null) 
				{
					formattedTotal.setAmount(orderItemStatusDB.getPriceTotal());				
					com.ibm.commerce.beans.DataBeanManager.activate(formattedTotal, request); 
				%>
				<td headers="t6" height="19" align="right"><span class="small"><%=formattedTotal%></span></td>
				<%
				} else {
				%>
				<td headers="t6" height="19" align="right"><span class="small">&nbsp;</span></td>
				<% } %>				
			</tr>
<%
		}
		else
		{
%>
			<tr> 
				<td headers="t1" height="19" align="left"><span class="small"><%= orderItem.getSupplierPartNumber() %></span></td>
				<td headers="t2" height="19" align="left"><span class="small"><%= orderItem.getCatalogEntry().getPartNumber() %>&nbsp;</span></td>
				<td headers="t3" height="19" align="left"><span class="small"><%= orderItem.getCatalogEntry().getDescription( cmdcontext.getLanguageId() ).getShortDescription() %></span></td>
				<td headers="t4" align="right"><span class="small"><%=orderItem.getPriceDataBean()%></span></td>
				<td headers="t5" height="19" align="left"><span class="small"><%= orderItem.getFormattedQuantity() %></span></td>
				<td headers="t6" height="19" align="right"><span class="small"><%=orderItem.getFormattedTotalProduct()%></span></td>
			</tr>
<%
		}		
%>
			<tr>
                          <td colspan="6" class="gbg"><img src="<%=fileDir%>images/c.gif" width="1" height="1" border="0" class="imgHeightFix" /></td>
                        </tr>		
<%
	}
			FormattedMonetaryAmountDataBean orderFormattedTotal = new FormattedMonetaryAmountDataBean();			
			if (orderStatusDB.getPriceTotal() != null) 
			{
				orderFormattedTotal.setAmount(orderStatusDB.getPriceTotal());				
				com.ibm.commerce.beans.DataBeanManager.activate(orderFormattedTotal, request); 
			%>
			<tr>
			  <td colspan="4"><img src="<%=fileDir%>images/c.gif" width="1" height="2" border="0" /></td>  
			  <td headers="t5" height="19" align="right"><span class="small"><b><%=storeText.getString("DistributorCartDetails_Subtotal")%></b></span></td>
			  <td headers="t6" height="19" align="right"><span class="small"><b><%=orderFormattedTotal%></b></span></td>
			</tr>		              
			<%
			}
			if (orderStatusDB.getTaxTotal() != null) 
			{
				orderFormattedTotal.setAmount(orderStatusDB.getTaxTotal());				
				com.ibm.commerce.beans.DataBeanManager.activate(orderFormattedTotal, request); 
			%>
			<tr>
			  <td colspan="4"><img src="<%=fileDir%>images/c.gif" width="1" height="2" border="0" /></td>  
			  <td headers="t5" height="19" align="right"><span class="small"><b><%=storeText.getString("DistributorCartDetails_Tax")%></b></span></td>
			  <td headers="t6" height="19" align="right"><span class="small"><b><%=orderFormattedTotal%></b></span></td>
			</tr>		              
			<%
			}
			if (orderStatusDB.getShippingTotal() != null) 
			{
				orderFormattedTotal.setAmount(orderStatusDB.getShippingTotal());				
				com.ibm.commerce.beans.DataBeanManager.activate(orderFormattedTotal, request); 
			%>
			<tr>
			  <td colspan="4"><img src="<%=fileDir%>images/c.gif" width="1" height="2" border="0" /></td>  
			  <td headers="t5" height="19" align="right"><span class="small"><b><%=storeText.getString("DistributorCartDetails_Shipping")%></b></span></td>
			  <td headers="t6" height="19" align="right"><span class="small"><b><%=orderFormattedTotal%></b></span></td>
			</tr>		              
			<%
			}
			if (orderStatusDB.getShippingTaxTotal() != null) 
			{
				orderFormattedTotal.setAmount(orderStatusDB.getShippingTaxTotal());				
				com.ibm.commerce.beans.DataBeanManager.activate(orderFormattedTotal, request); 
			%>
			<tr>
			  <td colspan="4"><img src="<%=fileDir%>images/c.gif" width="1" height="2" border="0" /></td>  
			  <td headers="t5" height="19" align="right"><span class="small"><b><%=storeText.getString("DistributorCartDetails_ShippingTax")%></b></span></td>
			  <td headers="t6" height="19" align="right"><span class="small"><b><%=orderFormattedTotal%></b></span></td>
			</tr>		              
			<%
			}
			%>
			<tr>
			  <td colspan="6"><img src="<%=fileDir%>images/c.gif" width="1" height="2" border="0" class="imgHeightFix" /></td>  
			</tr>
			<tr>
			  <td colspan="6" class="bbg"><img src="<%=fileDir%>images/c.gif" width="1" height="2" border="0" class="imgHeightFix" /></td>  
			</tr>
			<%
			if ((orderStatusDB.getShippingTotal() != null) && (orderStatusDB.getShippingTaxTotal() != null) && (orderStatusDB.getTaxTotal() != null) && (orderStatusDB.getPriceTotal() != null))
			{
				orderFormattedTotal.setAmount(orderStatusDB.getShippingTotal().add(orderStatusDB.getShippingTaxTotal()).add(orderStatusDB.getTaxTotal()).add(orderStatusDB.getPriceTotal()));
				com.ibm.commerce.beans.DataBeanManager.activate(orderFormattedTotal, request); 
			%>			
			<tr>
			  <td colspan="4"><img src="<%=fileDir%>images/c.gif" width="1" height="2" border="0" /></td>  
			  <td headers="t5" height="19" align="right"><span class="small"><b><%=storeText.getString("DistributorCartDetails_Total")%></b></span></td>
			  <td headers="t6" height="19" align="right"><span class="small"><b><%=orderFormattedTotal%></b></span></td>
			</tr>
<%
			}
}
%>		              
		</table>
	</td>
</tr>
<tr>
  <td colspan="2">&nbsp;</td>  
</tr>
<%
String extURL = null;
if (!"P".equals(orderBean.getStatus())) 
{
	OrderReleaseDataBean orderRelease = new OrderReleaseDataBean();
	try {
		Enumeration results = orderRelease.findByOrdersId( orderBean.getOrderIdInEJBType() );
		orderRelease = (OrderReleaseDataBean)results.nextElement();
		extURL = orderRelease.getExternalReference();
	} catch (Exception ex)
	{
		out.println("<!-- no order release -->");
	}
}
if (("G".equals(orderBean.getStatus())) || ("S".equals(orderBean.getStatus()))) 
{
	if(( extURL!=null)&&(extURL.length()>0)&&(!extURL.equals("null"))) 
	{
%>
<tr>
	<td height="18" align="right" colspan="2">
		<table cellpadding=0 cellspacing=0 border=0>
		<tr>
		  <td width=23 align="right"><a href="ExitToDistributorSiteDisplayView?storeId=<%=storeId%>&langId=<%=languageId%>&forwardURL=<%=java.net.URLEncoder.encode(extURL)%>" target="_blank"><img src="<%=fileDir%>images/blue_arrow_button.gif" width="23" height="23" border="0" alt="<%=storeText.getString("DistributorCartDetails_ViewOrderNum")%> <%=orderStatusDB.getMerchantOrderNumber()%>"></a></td><td><a href="ExitToDistributorSiteDisplayView?storeId=<%=storeId%>&langId=<%=languageId%>&forwardURL=<%=java.net.URLEncoder.encode(extURL)%>" target="_blank">&nbsp;<%=storeText.getString("DistributorCartDetails_ViewOrderNum")%> <%=orderStatusDB.getMerchantOrderNumber()%></a></td>
		</tr>
		</table>
	</td>
</tr>
<%
	}
}
else if ("F".equals(orderBean.getStatus())) 
{
	if(( extURL!=null)&&(extURL.length()>0)&&(!extURL.equals("null"))) 
	{
%>
<tr>
	<td height="18" align="right" colspan="2"><a href="ExitToDistributorSiteDisplayView?storeId=<%=storeId%>&langId=<%=languageId%>&forwardURL=<%=java.net.URLEncoder.encode(extURL)%>" target="_blank"><img src="<%=fileDir%><%=locale.toString()%>/images/b_opendistcart.gif" border="0" alt="<%=storeText.getString("DistributorCartDetails_OpenCart")%>"></a></td>
</tr>
<%
	}
%>
<tr>
	<td width="600" height="2" colspan="2"><img src="<%=fileDir%>images/c.gif" width="2" height="2" class="imgHeightFix" /></td>
</tr>
<tr>
	<td height="18" align="right" colspan="2">
		<table cellpadding=0 cellspacing=0 border=0>
		<tr>
		  <td width=23 align="right"><a href="PartialTransferShopCartDisplayView?orderId=<%=orderBean.getParentOrder().getOrderId()%>&langId=<%=languageId%>&storeId=<%=storeId%>&catalogId=<%=catalogId%>"><img src="<%=fileDir%>images/blue_arrow_button.gif" width="23" height="23" border="0" alt="<%=storeText.getString("PartialTransferShopCartDisplay_OpenPending")%>"></a></td><td><a href="PartialTransferShopCartDisplayView?orderId=<%=orderBean.getParentOrder().getOrderId()%>&langId=<%=languageId%>&storeId=<%=storeId%>&catalogId=<%=catalogId%>">&nbsp;<%=storeText.getString("PartialTransferShopCartDisplay_OpenPending")%></a></td>
		</tr>
		</table>
	</td>
</tr>

<%
}
else if ("P".equals(orderBean.getStatus())) 
{
%>
<tr>
	<td height="18" align="right" colspan="2"><a href="PartialTransferShopCartDisplayView?orderId=<%=orderBean.getParentOrder().getOrderId()%>&langId=<%=languageId%>&storeId=<%=storeId%>&catalogId=<%=catalogId%>"><img src="<%=fileDir%><%=locale.toString()%>/images/b_pending_cart.gif" border="0" alt="<%=storeText.getString("PartialTransferShopCartDisplay_OpenPending")%>"></a></td>
</tr>

<%
}
%>
<tr>
	<td width="600" height="2" colspan="2"><img src="<%=fileDir%>images/c.gif" width="2" height="2" class="imgHeightFix" /></td>
</tr>
<tr>
	<td height="18" align="right" colspan="2">
		<table cellpadding=0 cellspacing=0 border=0>
		<tr>
		  <%
		  if (returnPage != null && returnPage.equals("distributorCarts"))
		  {
		  %>
		  <td width=23 align="right"><a href="DistributorCartsByStatusDisplayView?langId=<%=languageId%>&storeId=<%=storeId%>&catalogId=<%=catalogId%>"><img src="<%=fileDir%>images/blue_arrow_button_left.gif" width="23" height="23" border="0" alt="<%=storeText.getString("DistributorCartDetails_ReturnDistCarts")%>"></a></td><td><a href="DistributorCartsByStatusDisplayView?langId=<%=languageId%>&storeId=<%=storeId%>&catalogId=<%=catalogId%>">&nbsp;<%=storeText.getString("DistributorCartDetails_ReturnDistCarts")%></a></td>
		  <%
		  }
		  else
		  {
		  %>
		  <td width=23 align="right"><a href="ProcessedShopCartsByStatusDisplayView?langId=<%=languageId%>&storeId=<%=storeId%>&catalogId=<%=catalogId%>"><img src="<%=fileDir%>images/blue_arrow_button_left.gif" width="23" height="23" border="0" alt="<%=storeText.getString("DistributorCartDetails_ReturnOrderStatus")%>"></a></td><td><a href="ProcessedShopCartsByStatusDisplayView?langId=<%=languageId%>&storeId=<%=storeId%>&catalogId=<%=catalogId%>">&nbsp;<%=storeText.getString("DistributorCartDetails_ReturnOrderStatus")%></a></td>
		  <%
		  }
		  %>
		</tr>
		</table>
	</td>
</tr>

</table>

</td>
</tr>
</table>
</td>
	<!-- End of Main Content TD -->        

 
   
</tr></table>
   
<!-- End Main Table -->

<!-- Start Footer -->
<%@ include file="../../../include/FooterDisplay.jspf"%>
<!-- End Footer -->

</body>
</html>
