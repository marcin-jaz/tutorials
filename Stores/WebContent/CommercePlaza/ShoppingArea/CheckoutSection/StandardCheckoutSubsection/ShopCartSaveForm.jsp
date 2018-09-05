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
<%@ page import="com.ibm.commerce.beans.*" %>
<%@ page import="com.ibm.commerce.catalog.objects.*" %>
<%@ page import="com.ibm.commerce.user.beans.*" %>
<%@ page import="com.ibm.commerce.order.beans.*" %>
<%@ page import="com.ibm.commerce.order.objects.*" %>
<%@ page import="com.ibm.commerce.datatype.*" %>
<%@ include file="../../../include/EnvironmentSetup.jsp"%>
<%
//Parameters may be encrypted. Use JSPHelper to get URL parameter instead of request.getParameter().
String orderRn = jhelper.getParameter("orderId");
String curOrderRn = jhelper.getParameter("curOrderId");
String comingURL = jhelper.getParameter("URL");
String targettedOrderId = jhelper.getParameter("targettedOrderId");

TypedProperty requestProperties = (TypedProperty)request.getAttribute(ECConstants.EC_REQUESTPROPERTIES) ;

request.setAttribute("pageName", "CurrentShoppingCart");

out.println("<!-- requestProperties : \n" + requestProperties + " -->");

String pageTitle;
String pageSaveCurrent;
String pageInstructions;

if(( comingURL != null )&&(comingURL.startsWith("OrderQuotationDisplay"))) {
  pageTitle = storeText.getString("ShopCartSaveForm_QuoteTitle");  
  pageSaveCurrent = storeText.getString("ShopCartSaveForm_SaveCurrentQuote");
  pageInstructions = storeText.getString("ShopCartSaveForm_QuoteInstructions");
} else {
  pageTitle = storeText.getString("ShopCartSaveForm_CartTitle");
  pageSaveCurrent = storeText.getString("ShopCartSaveForm_SaveCurrentCart");
  pageInstructions = storeText.getString("ShopCartSaveForm_CartInstructions");
}  
  
%>
<jsp:useBean id="order" class="com.ibm.commerce.order.beans.OrderDataBean" scope="page">
<% 
order.setOrderId(orderRn);
DataBeanManager.activate(order, request); 
%>
</jsp:useBean>
<% catalogId = sdb.getStoreCatalogs()[0].getCatalogId(); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "DTD/xhtml1-transitional.dtd">
<HEAD>
	<TITLE><%=pageTitle%></TITLE>
	<LINK REL=stylesheet HREF="<%=fileDir%>PCDMarket.css" TYPE="text/css">

</HEAD>
<script language="javascript">
  var busy=false;
  
  // Refresh Quote - must reselect distributors
  function saveCart(form)
  {
    if( !busy ) {
      busy=true;
      form.submit();
    }
  }

  // Refresh Quote - must reselect distributors
  function cancelForm(form)
  {
    if( !busy ) {
      busy=true;
      form.submit();
    }
  }
</script>
<BODY MARGINHEIGHT="0" MARGINWIDTH="0" LEFTMARGIN="0" TOPMARGIN="0">
<!-- Start Header File -->
<%@ include file="../../../include/HeaderDisplay.jspf"%>
<!-- End Header File -->
<!-- Start Main Table - Consists of TD for Left Bar, TD for Content and TD for Quicklinks -->
<table border="0" cellpadding="0" cellspacing="0" width="750">
  <tr>
    <td VALIGN="top" class="mbg" width="150"> 
      <% String incfile = includeDir + "SidebarDisplay.jsp"; %>
      <jsp:include page="<%=incfile%>" flush="true"/>
    </TD>
    <!-- End  Left Nav Bar TD -->
    <td><a name="mainContent"></a><img src="<%=fileDir%>images/c.gif" width="10" height="2" border="0" /></td>
    <!-- Begin Main Content TD -->
    <td valign="top" >
    <!--MAIN CONTENT STARTS HERE-->
      <table width="590" cellspacing="0" cellpadding="0" border="0">
        <tr>
          <td><span class="bct">&nbsp;&nbsp;&nbsp;</span>
      		<a class="bctl" href="StoreCatalogDisplay?storeId=<%=storeId%>&catalogId=<%=catalogId%>&langId=<%=languageId%>"><%=storeText.getString("Breadcrumb_CommercePlaza")%></a><span class="bct">&nbsp;&nbsp;&nbsp;&gt;&nbsp;&nbsp;&nbsp;</span>
      		<span class="bct"><%=storeText.getString("Breadcrumb_ShopCart")%></span>
          </td>
        </tr>
        <tr>
          <td>
           	<table cellpadding=0 cellspacing="0" border="0" width="590">
           	  <tr>
                <td valign="top" width="300">
                  <div align="left"><span class="title"><%=pageTitle%></span></div>
                </td>
                <td valign="top" width="280">
                  <div align="right"><img src="<%=fileDir%>images/hdr_cart.gif" width="280" height="72" alt="<%=pageTitle%>"></div>
                </td>
              </tr>
            </table>
          </td>
        </tr>
        <tr valign="top">
          <td>
            <form NAME="CancelSaveForm" METHOD="POST" action="OrderItemDisplay">
            <input type=hidden name="orderId" value="<%=orderRn%>">
            <input type=hidden name="check" value="*n">
            <input type=hidden name="storeId" value="<%=storeId%>">
            <input type=hidden name="catalogId" value="<%=catalogId%>">
            </form>
          	<form NAME="SaveCartForm" METHOD="POST" action="OrderCopy">	
          	<input type="hidden" name="check" value="*n">	
          	<input type=hidden name="orderId*" value="">
            <%
            if (targettedOrderId != null && !targettedOrderId.equals(""))
            {	
            	if (comingURL != null) { %>
          	<input type=hidden name="URL" value="SetPendingOrder?orderId=<%= targettedOrderId %>&URL=<%= comingURL %>">
            <% } else { %>	
          	<input type=hidden name="URL" value="SetPendingOrder?orderId=<%= targettedOrderId %>&URL=PendingShopCartsDisplayView">
            <% }
            } 
            else
            {
		if (comingURL != null) { %>
          	<input type=hidden name="URL" value="<%= comingURL %>">
            <% } else { %>	
          	<input type=hidden name="URL" value="PendingShopCartsDisplayView">
            <% } 
            }
            %>
          	<input type=hidden name="toOrderId" value="<%= orderRn %>">
          	<table cellpadding=0 cellspacing="0" border="0" width="590">
  	          <tr>
          	    <td valign="top"><span class="text"><%=pageInstructions%></span></td>
              </tr>
              <tr>
                <td><img src="<%=fileDir%>images/c.gif" height="10" width=1 alt=""></td>              
              </tr>
              <tr>
                <td><b><label for="desc"><%=storeText.getString("ShopCartSaveForm_CartPrompt")%></label> </b></td>
              </tr>
              <tr>
          	    <td><input id="desc" type="text" name="description" size=30 maxlength="30"></td>
              </tr>
              <tr height=10>
                <td>&nbsp;</td>
          	  </tr>
          	  <tr>
          	    <td><A href="javascript:saveCart(document.SaveCartForm)"><img src="<%=fileDir%><%=locale.toString()%>/images/b_save.gif" width="120" height="21" border=0 alt="<%=storeText.getString("Alt_Save")%>"></a></td>	
              </tr>
              <tr height=10>
                <td>&nbsp;</td>
          	  </tr>
          	  <tr>
          	    <td>
          	      <table cellpadding=0 cellspacing="0" border="0">
                    <tr>
                      <td width=28><a href="javascript:cancelForm(document.CancelSaveForm)"><img src="<%=fileDir%>images/arrow_lt.gif" border="0" alt="<%=storeText.getString("ShopCartSaveForm_Cancel")%>"></a></td>
                      <td><a href="javascript:cancelForm(document.CancelSaveForm)"><%=storeText.getString("ShopCartSaveForm_Cancel")%></a></td>
                    </tr>
                  </table>
                </td>
              </tr>
          	</table>
  	      </form>
          </td>
        </tr>
      </table>
    </td>
	  <!-- End of Main Content TD -->
  </tr>
</table>
<%@ include file="../../../include/FooterDisplay.jspf"%>
</BODY>
</HTML>
