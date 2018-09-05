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
<%@ page import="java.net.URLEncoder" %>
<%@ include file="../../../include/EnvironmentSetup.jsp"%>
<%
//Parameters may be encrypted. Use JSPHelper to get URL parameter instead of request.getParameter().
String orderRn = jhelper.getParameter("orderId");
CurrentPendingOrderAccessBean ab;
String curOrderRn = null;

try {
	com.ibm.commerce.order.utils.ResolveOrdersCmd resolveOrdersCmd = (com.ibm.commerce.order.utils.ResolveOrdersCmd)CommandFactory.createCommand(com.ibm.commerce.order.utils.ResolveOrdersCmd.NAME, cmdcontext.getStoreId());
	resolveOrdersCmd.setCommandContext(cmdcontext);
	resolveOrdersCmd.setOrderAbbreviations(new String[] { "." });
	resolveOrdersCmd.execute();
	Long[] nOrderIds = resolveOrdersCmd.getOrderIds();
	if(nOrderIds != null && nOrderIds.length != 0) { curOrderRn = "" + nOrderIds[0]; }
}
catch(Exception e) { e.printStackTrace(); }

request.setAttribute("pageName", "PendingShoppingCarts");
%>

<jsp:useBean id="curOrderBean" class="com.ibm.commerce.order.beans.OrderDataBean" scope="page">
<% 
curOrderBean.setOrderId(curOrderRn);
com.ibm.commerce.beans.DataBeanManager.activate(curOrderBean, request);
%>
</jsp:useBean>
<jsp:useBean id="orderBean" class="com.ibm.commerce.order.beans.OrderDataBean" scope="page">
<% 
orderBean.setOrderId(orderRn);
com.ibm.commerce.beans.DataBeanManager.activate(orderBean, request);
%>
</jsp:useBean>
<%
catalogId = sdb.getStoreCatalogs()[0].getCatalogId();
String orderDesc="";
if (curOrderBean.getDescription() != null)
orderDesc = curOrderBean.getDescription();

// create a URL to pass downstream to ShopCartSaveForm.jsp to redirect to, after saving.
String  tempURL = "OrderItemDisplay&check=*n&catalogId=" + catalogId;
String  currentCartURL = java.net.URLEncoder.encode(tempURL);

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "DTD/xhtml1-transitional.dtd">
<HEAD>
	<TITLE><%=storeText.getString("ShopCartActivateDisplay_Title")%></TITLE>
	<LINK REL=stylesheet HREF="<%=fileDir%>PCDMarket.css" TYPE="text/css">
</HEAD>
<script language="javascript">
var busy=false;
function setPendingOrderForm(form) {
  if( !busy ) {
    busy = true;  
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
    <td VALIGN="top" class="dbg" width="150"> 
      <% String incfile = includeDir + "SidebarDisplay.jsp"; %>
      <jsp:include page="<%=incfile%>" flush="true"/></TD>
    <!-- End  Left Nav Bar TD -->
    <td><a name="mainContent"></a><img src="<%=fileDir%>images/c.gif" width="10" height="2" border="0" /></td>    
    <!-- Begin Main Content TD -->
    <td valign="top" width="590">
    <!--MAIN CONTENT STARTS HERE-->
      <table width="590" border="0" cellspacing="0" cellpadding="0">
   		<tbody>
    	  <tr>
          <td width="590" colspan="2"><span class="bct">&nbsp;&nbsp;&nbsp;</span>
      			<a class="bctl" href="StoreCatalogDisplay?storeId=<%=storeId%>&catalogId=<%=catalogId%>&langId=<%=languageId%>"><%=storeText.getString("Breadcrumb_CommercePlaza")%></a>
   		    </td>
   		  </tr>
    		<tr>
    		  <td valign="top" width="320"><span class="title"><%=storeText.getString("ShopCartActivateDisplay_Title")%></span></td>
   		    <td valign="top" width="280" align="right"><img src="<%=fileDir%>images/hdr_cart.gif" width="280" height="72" alt="<%=storeText.getString("ShopCartActivateDisplay_Title")%>"></td>
  		  </tr>
		  </tbody>
		  </table>
      <table width="590" border="0" cellspacing="0" cellpadding="0">
        <tr valign="top">
          <td>
            <table>
              <tr height=10>
                <td>&nbsp; </td>
              </tr>
              <tr>
                <td><font class="text"><%=storeText.getString("ShopCartActivateDisplay_Text1")%>&nbsp;<b>"<%=orderBean.getDescription()%>"</b></font>
                   <font class="text"><%=storeText.getString("ShopCartActivateDisplay_Text2")%></font>
<%
if (orderDesc.trim().length() == 0) { 
%>
	<font class="text"><%=storeText.getString("ShopCartActivateDisplay_UnsavedCart")%>
	<br><br>
	<font class="text"><%=storeText.getString("ShopCartActivateDisplay_UnsavedText1")%></font> 
	<font class="strongtext"><%=storeText.getString("ShopCartActivateDisplay_UnsavedText2")%></font><br>
	<font class="text"><%=storeText.getString("ShopCartActivateDisplay_UnsavedText3")%></font>
	<br><br>
	<font class="text"><%=storeText.getString("ShopCartActivateDisplay_UnsavedText4")%></font>
	<br><br>
<%
}
%>
                </td>
              </tr>
              <tr height=10>
                <td>&nbsp;</td>
              </tr>
              <tr>
                <td>
                	<table border="0" cellspacing="0" cellpadding="0">
                		<tr>
<% if (orderDesc.trim().length() == 0) { %>
				<td width="400">&nbsp;</td>
                  		<td valign="top"><img src="<%=fileDir%>images/arrow_rd.gif" width="23" height="23" border="0" alt=""></td>
                  		<td>&nbsp;</td>
                  		<td valign="top" align="left"><font class="subtotal"><a href="ShopCartSaveFormView?orderId=<%=curOrderRn%>&catalogId=<%=catalogId%>&targettedOrderId=<%=orderRn%>&URL=<%=currentCartURL%>"><%=storeText.getString("ShopCartActivateDisplay_SaveCart")%></a></font></td>
                  	</tr>
                  	<tr>
<% } %>
                  		<td width="400">&nbsp;</td>
                  		<td valign="top"><img src="<%=fileDir%>images/arrow_rd.gif" width="23" height="23" border="0" alt=""></td>
				<td>&nbsp;</td>
                  		<td valign="top" align="left">
<% if (orderDesc.trim().length() == 0) { 
    // if the current order is not saved, the current order will be cancelled before the other pending order is set to current
%>		
                    		<form name="CancelAndSetPendingOrderForm" method="post" action="OrderCancel">
                    		<input type=hidden name="orderId" value="<%=curOrderRn%>">
                    		<input type=hidden name="catalogId" value="<%=catalogId%>">
                    		<input type=hidden name="URL" value="SetPendingOrder?orderId=<%= orderRn %>&URL=OrderItemDisplay&check=*n">
                    		</form>
                    		<font class="subtotal"><a href="javascript:setPendingOrderForm(document.CancelAndSetPendingOrderForm)"><%=storeText.getString("ShopCartActivateDisplay_ReplaceCart")%></a></font>
<% } else {  %>
                    		<font class="subtotal"><a href="SetPendingOrder?orderId=<%= orderRn %>&URL=OrderItemDisplay&check=*n&catalogId=<%=catalogId%>"><%=storeText.getString("ShopCartActivateDisplay_ReplaceCart")%></a></font>
<% } %>
                    	</td>		
                  	</tr>
                  	<tr>
                  		<td width="400">&nbsp;</td>
                  		<td valign="top"><img src="<%=fileDir%>images/arrow_lt.gif" width="23" height="23" border="0" alt=""></td>
                      		<td>&nbsp;</td>
                      		<td valign="top" align="left"><font class="subtotal"><a href="PendingShopCartsDisplayView?catalogId=<%=catalogId%>"><%=storeText.getString("ShopCartActivateDisplay_Cancel")%></a></font></td>
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
  </tr>
</table>
<%@ include file="../../../include/FooterDisplay.jspf"%>
</BODY>
</HTML>
