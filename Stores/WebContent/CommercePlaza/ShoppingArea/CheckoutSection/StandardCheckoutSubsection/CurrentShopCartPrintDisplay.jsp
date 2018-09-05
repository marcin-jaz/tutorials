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
<%@ page import="com.ibm.commerce.server.*" %>
<%@ page import="com.ibm.commerce.command.*" %>
<%@ page import="com.ibm.commerce.price.beans.*" %>
<%@ page import="com.ibm.commerce.catalog.beans.*" %>
<%@ page import="com.ibm.commerce.beans.*" %>
<%@ page import="com.ibm.commerce.catalog.objects.*" %>
<%@ page import="com.ibm.commerce.user.beans.*" %>
<%@ page import="com.ibm.commerce.order.beans.*" %>
<%@ page import="com.ibm.commerce.order.objects.*" %>
<%@ include file="../../../include/EnvironmentSetup.jsp"%>
<%

String orderRn = jhelper.getParameter("orderId");

double subtotal = 0;

request.setAttribute("pageName", "CurrentShoppingCart");

%>
<jsp:useBean id="orderBean" class="com.ibm.commerce.order.beans.OrderDataBean" scope="page">
<% 
orderBean.setOrderId(orderRn);
com.ibm.commerce.beans.DataBeanManager.activate(orderBean, request);
%>
</jsp:useBean>
<% catalogId = sdb.getStoreCatalogs()[0].getCatalogId(); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "DTD/xhtml1-transitional.dtd">
<HEAD>
	<TITLE><%=storeText.getString("CurrentShopCartPrintDisplay_Title")%></TITLE>
	<LINK REL=stylesheet HREF="<%=fileDir%>PCDMarket.css" TYPE="text/css">
</HEAD>
<BODY MARGINHEIGHT="0" MARGINWIDTH="0" LEFTMARGIN="0" TOPMARGIN="0">
<table border="0" cellpadding="0" cellspacing="0" width="750">
  <tr>
    <td>
      <table width="600" border="0" cellspacing="0" cellpadding="0">
        <tbody>
        <tr>
        	<td colspan="3"><b><%=storeText.getString("CurrentShopCartDisplay_CurrentCart")%></b></td>
        </tr>
        <tr>
          <td height=10>&nbsp;</td>
        </tr>
        <tr>
          <td valign="top">
            <table width="600" cellpadding="0" border="0" cellspacing="1">
              <tr valign="top">
                <th id="th1"><font class="small"><b><%=storeText.getString("CurrentShopCartPrintDisplay_Quantity")%></b></font></th>
                <th id="th2"><font class="small"><b><%=storeText.getString("CurrentShopCartPrintDisplay_IBMPartNumber")%></b></font></th>
                <th id="th3"><font class="small"><b><%=storeText.getString("CurrentShopCartPrintDisplay_Description")%></b></font></th>
                <th id="th4" align="right"><font class="small"><b><%=storeText.getString("CurrentShopCartPrintDisplay_IBMListPrice")%></b></font></th>
                <th id="th5" align="right"><font class="small"><b><%=storeText.getString("CurrentShopCartPrintDisplay_LineTotal")%></b></font></th>
              </tr>             
              <tr>
                <td colspan="5" class="black_bg"><img src="<%=fileDir%>images/c.gif" width="1" height="2" border="0" /></td>
              </tr>
<%                            
      OrderItemDataBean [] orderItems = orderBean.getOrderItemDataBeans();	
      OrderItemDataBean orderItem;
      String strQuantity = "0";
      String productId = "";
                       
      for (int i=0; ((orderItems != null) && (i < orderItems.length)); i ++) {
        orderItem = orderItems[i];				
		    strQuantity = orderItem.getFormattedQuantity();
		    Long childCatalogEntryId = orderItem.getCatalogEntry().getCatalogEntryReferenceNumberInEJBType();
		    if( i>0) {	%>              
              <tr>
                <td colspan="5" class="grey_bg"><img src="<%=fileDir%>images/c.gif" width="1" height="1" border="0" /></td>
              </tr>
<%      } %>              
              <tr>
                <td headers="th1"><font class="text"><%= strQuantity %></font></td>
                <td headers="th2"><font class="text"><%= orderItem.getPartNumber() %></font></td>
                <td headers="th3"><font class="text"><%= orderItem.getCatalogEntry().getDescription(cmdcontext.getLanguageId()).getShortDescription()%></td>
                <td headers="th4" align="right"><font class="text"><%=orderItem.getPriceDataBean()%></font></td>
                <td headers="th5" align="right"><font class="text"><%= orderItem.getFormattedTotalProduct()%></font></td>	              	              
              </tr>
<%    	} // end for i	%>
              <tr>
                <td colspan="5" class="black_bg"><img src="<%=fileDir%>images/c.gif" width="1" height="2" border="0" /></td>
              </tr>
              <tr>
                <td colspan=4 align="right"><b><%=storeText.getString("CurrentShopCartPrintDisplay_Subtotal")%></b></td>
                <td align="right"><font class="text"><b><%=orderBean.getFormattedTotalProductPrice()%></b></font></td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
</BODY>
</HTML>
