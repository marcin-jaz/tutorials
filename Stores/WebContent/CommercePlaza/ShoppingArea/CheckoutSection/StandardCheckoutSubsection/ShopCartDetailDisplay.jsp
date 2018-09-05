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

<%@ page import="com.ibm.commerce.catalog.beans.*" %>
<%@ page import="com.ibm.commerce.price.beans.*" %>
<%@ page import="com.ibm.commerce.order.beans.*" %>
<%@ page import="com.ibm.commerce.beans.*" %>
<%@ page import="com.ibm.commerce.catalog.objects.*" %>
<%@ page import="com.ibm.commerce.user.beans.*" %>
<%@ page import="com.ibm.commerce.order.objects.*" %>
<%@ page import="com.ibm.commerce.utils.TimestampHelper" %>
<%@ page import="com.ibm.commerce.marketing.beans.EMarketingSpot" %>  

<%@ include file="../../../include/EnvironmentSetup.jsp"%>
<%
//Parameters may be encrypted. Use JSPHelper to get URL parameter instead of request.getParameter().
String orderRn = jhelper.getParameter("orderRn");
CurrentPendingOrderAccessBean ab;

String curOrderRn = null;


for (Enumeration e = (new CurrentPendingOrderAccessBean()).findByMember(cmdcontext.getUserId()) ; e.hasMoreElements() ;) {
	ab = (CurrentPendingOrderAccessBean) e.nextElement();
	curOrderRn = ab.getOrderId();

}

double subtotal = 0;

request.setAttribute("pageName", "PendingShoppingCarts");
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
	<TITLE><%=storeText.getString("ShopCartDetailDisplay_Title")%></TITLE>
	<LINK REL=stylesheet HREF="<%=fileDir%>PCDMarket.css" TYPE="text/css">

</HEAD>
<BODY MARGINHEIGHT="0" MARGINWIDTH="0" LEFTMARGIN="0" TOPMARGIN="0">

<!-- Start Header File -->
<%@ include file="../../../include/HeaderDisplay.jspf"%>
<!-- End Header File -->
<!-- Start Main Table - Consists of TD for Left Bar, TD for Content and TD for Quicklinks -->
<table border="0" cellpadding="0" cellspacing="0" width="750">
  <tr>
    <td VALIGN="top" class="dbg" width="150"> 
      <% String incfile = includeDir + "SidebarDisplay.jsp"; %>
      <jsp:include page="<%=incfile%>" flush="true"/>
    </TD>
    <!-- End  Left Nav Bar TD -->
    <td><a name="mainContent"></a><img src="<%=fileDir%>images/c.gif" width="10" height="2" border="0" /></td>    
    <!-- Begin Main Content TD -->
    <td valign="top" width="590">
    <!--MAIN CONTENT STARTS HERE-->
      <table width="590" border="0" cellspacing="0" cellpadding="0">
    	  <tbody>
        <tr>
    	    <td width="590" colspan="2"><span class="bct">&nbsp;&nbsp;&nbsp;</span>
    			<a class="bctl" href="StoreCatalogDisplay?storeId=<%=storeId%>&catalogId=<%=catalogId%>&langId=<%=languageId%>"><%=storeText.getString("Breadcrumb_CommercePlaza")%></a><span class="bct">&nbsp;&nbsp;&nbsp;&gt;&nbsp;&nbsp;&nbsp;</span>
    			<font class="bct"><%=storeText.getString("Breadcrumb_ShopCart")%></font>
  	      </td>
  	    </tr>
  	    <tr>
   	      <td valign="top" width="310">
   	      <div align="left"><span class="title"><%=storeText.getString("ShopCartDetailDisplay_Title")%></span></div>
   	      <div><span class="subtitle"><%=orderBean.getDescription()%></span></div></td>
   	      <td valign="top" width="280"><div align="right"><img src="<%=fileDir%>images/hdr_cart.gif" width="280" height="72" alt="<%=storeText.getString("ShopCartDetailDisplay_Title")%>"></div></td>
  	    </tr>
	      </tbody>
	    </table>
      <table width="590" border="0" cellspacing="1" cellpadding="0">
        <tr>
          <td>
          	<table cellpadding="0" cellspacing="0" border="0" width="590">
              <tr>
              	<td>
              		<table cellpadding="2" cellspacing="0" border="0" width="590">
                		<tr class="tdblue">
                        <td class="tdblue"><font class="text"><b><%=storeText.getString("ShopCartDetailDisplay_CartLastSaved")%></b>&nbsp;<%=TimestampHelper.getDateFromTimestamp(orderBean.getLastUpdateInEJBType(),locale)%>&nbsp;<%=orderBean.getLastUpdateInEJBType().toString().substring(11,16)%></font></td>
                		</tr>
              		</table>
              	</td>
              </tr>
              <tr>
              	<td valign="top">
              		<table cellpadding="0" border="0" cellspacing="1">
                		<tr class="mbg">
                  		<th align="left" valign="top" id="th1"><font class="strongtext"><%=storeText.getString("ShopCartDetailDisplay_Quantity")%></font></th>
                  		<th align="left" valign="top" id="th2"><font class="strongtext"><%=storeText.getString("ShopCartDetailDisplay_IBMPartNumber")%></font></th>
                  		<th align="left" valign="top" id="th3"><font class="strongtext"><%=storeText.getString("ShopCartDetailDisplay_Description")%></font></th>
                  		<th align="left" valign="top" id="th4"><font class="strongtext"><%=storeText.getString("ShopCartDetailDisplay_IBMListPrice")%></font></th>
                  		<th align="left" valign="top" id="th5"><font class="strongtext"><%=storeText.getString("ShopCartDetailDisplay_LineTotal")%></font></th>
                		</tr>
<%                            
		OrderItemDataBean [] orderItems = orderBean.getOrderItemDataBeans();	
		OrderItemDataBean orderItem;
              
         	int itemCount = 0;
		for (int i = 0; ((orderItems != null) && (i < orderItems.length)); i++) {
			itemCount = itemCount + 1;
			orderItem = orderItems[i];				
			Long childCatalogEntryId = orderItem.getCatalogEntry().getCatalogEntryReferenceNumberInEJBType();
%>
                  <tr> 		              
                    <td valign="top" headers="th1"><%= orderItem.getFormattedQuantity() %></td>
                    <td valign="top" headers="th2"><a href="ProductDisplay?storeId=<%= storeId %>&langId=<%= languageId %>&catalogId=<%= catalogId %>&productId=<%= orderItem.getCatalogEntry().getCatalogEntryReferenceNumberInEJBType() %>"><%= orderItem.getPartNumber()%></a></td>
                    <td valign="top" headers="th3"><%= orderItem.getCatalogEntry().getDescription(cmdcontext.getLanguageId()).getShortDescription()%></td>                     
                    <td align="right" valign="top" headers="th4"><%= orderItem.getPriceDataBean()%></td>                
                    <td align="right" valign="top" headers="th5"><%= orderItem.getFormattedTotalProduct()%></td>	
              	</tr>
<% 	  if (itemCount < orderItems.length) {  %>
                          <tr>
                            <td colspan="5" class="dgbg"><img src="<%=fileDir%>images/c.gif" width="1" height="1" border="0" /></td>
                          </tr>
<%	  }
		} // end for loop i
%>
              		<tr>
                            <td colspan="5" class="bbg"><img src="<%=fileDir%>images/c.gif" width="590" height="2" border="0" /></td>
                          </tr>

              		<tr>
                    <td colspan="3">&nbsp;</td>
                		<td valign="top"><font class="strongtext"><b><%=storeText.getString("ShopCartDetailDisplay_SubTotal")%></b></font></td>
                		<td align="right" valign="top"><font class="text"><b><%=orderBean.getFormattedTotalProductPrice()%></b></font></td>
              		</tr>
            		</table>
            	</td>
          	</tr>
        	</table>
          <table width=590 cellpadding=0 cellspacing=0 border=0>
          	<tr>
            	<td colspan=7>&nbsp;</td>
          	</tr>
          	<tr>
          	  <td width=190>&nbsp;</td>
<%  if (curOrderRn != null) { %>
              <td colspan=3 align="left" valign="middle"><font class="subtotal"><a href="ShopCartActivateDisplayView?orderId=<%=orderRn%>&catalogId=<%=catalogId%>&storeId=<%=storeId%>&langId=<%=languageId%>"><img src="<%=fileDir%><%=locale.toString()%>/images/b_current_cart.gif" border="0" alt="<%=storeText.getString("ShopCartDetailDisplay_MakeCurrent")%>"></a></font></td>
<%  } else {  %>
              <td colspan=3 align="left" valign="middle"><font class="subtotal"><a href="OrderItemDisplay?check=*n&langId=<%=languageId%>&storeId=<%=storeId%>&catalogId=<%=catalogId%>&orderId=<%=orderRn%>"><img src="<%=fileDir%><%=locale.toString()%>/images/b_current_cart.gif" border="0" alt="<%=storeText.getString("ShopCartDetailDisplay_MakeCurrent")%>"></a></font></td>
<%  }  %>
          	  <td width=45 valign="middle" align="right"><img src="<%=fileDir%>images/blue_arrow_button.gif" width="23" height="23" border="0" alt=""></td>
          	  <td width=5>&nbsp;</td>
          	  <td width=150 valign="middle" align="left"><a href="OrderCopy?fromOrderId_1=<%= orderRn %>&copyOrderItemId_1=*&toOrderId=.&URL=OrderItemDisplay?catalogId=<%=catalogId%>&check=*n"><%=storeText.getString("ShopCartDetailDisplay_Append")%></a></td>

          	
            </tr>
            <tr> 
            	<td width=190>&nbsp;</td>
            	<td width=23 valign="middle" align="left"><img src="<%=fileDir%>images/blue_arrow_button.gif" width="23" height="23" border="0" alt=""></td>
            	<td width=5>&nbsp;</td>
            	<td width=172 valign="middle" align="left"><font class="subtotal"><a href="ShopCartDeleteDisplayView?orderId=<%=orderRn%>&catalogId=<%=catalogId%>"><%=storeText.getString("ShopCartDetailDisplay_DeleteCart")%></a></td>
            	<td width=45 valign="middle" align="right"><img src="<%=fileDir%>images/blue_arrow_button.gif" width="23" height="23" border="0" alt=""></td>
            	<td width=5>&nbsp;</td>
            	<td width=150 valign="middle" align="left"><font class="subtotal"><a href="PendingShopCartsDisplayView?catalogId=<%=catalogId%>"><%=storeText.getString("ShopCartDetailDisplay_ReturnSaved")%></a></font></td>
            	
            </tr>
          </table>
        </td>
      </tr>
    </table>
  </td>
	<!-- End of Main Content TD -->
</tr></table>
<%@ include file="../../../include/FooterDisplay.jspf"%>
</BODY>
</HTML>
