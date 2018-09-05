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
<%@ include file="../../../include/EnvironmentSetup.jsp"%>
<%
//Parameters may be encrypted. Use JSPHelper to get URL parameter instead of request.getParameter().
String orderRn = jhelper.getParameter("orderId");

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
	<TITLE><%=storeText.getString("ShopCartDeleteDisplay_Title")%></TITLE>
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
    <td valign="top" width="444">
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
    		  <td valign="top" width="300" align="left" valign="top"><span class="title"><%=storeText.getString("ShopCartDeleteDisplay_Title")%></span></td>
  		    <td valign="top" width="280" align="right" valign="top"><img src="<%=fileDir%>images/hdr_cart.gif" width="280" height="72" alt="<%=storeText.getString("ShopCartDeleteDisplay_Title")%>"></td>
  		  </tr>
		  </tbody>
		  </table>
      <table width="590" border="0" cellspacing="0" cellpadding="0">
        <tr>
                <td><%=storeText.getString("ShopCartDeleteDisplay_Text1")%>&nbsp;<font class="strongtext"><b><%= orderBean.getDescription() %></b></font></td>
        </tr>
        <tr> 
                <td><img src="<%=fileDir%>images/c.gif" width="1" height="10" border="0" /></td>    
        </tr>
        <tr>
                <td>
                  <table cellspacing="0" cellpadding="0">
                    <tr>
                      <td width=450>&nbsp;</td>
                      <td valign="top" width=28><img src="<%=fileDir%>images/arrow_rd.gif" width="23" height="23" border="0" alt=""></td>
                      <td valign="top" align="left"><a href="OrderCancel?orderId=<%= orderRn %>&URL=PendingShopCartsDisplayView?catalogId=<%=catalogId%>"><%=storeText.getString("ShopCartDeleteDisplay_DeleteCart")%></a></td>
                    </tr>
                  </table>
                </td>
        </tr>
        <tr> 
                <td><img src="<%=fileDir%>images/c.gif" width="1" height="10" border="0" /></td>    
        </tr>
        <tr>
                <td>
                  <table cellspacing="0" cellpadding="0">
                    <tr>
                      <td width=450>&nbsp;</td>
                      <td valign="top" width=28><img src="<%=fileDir%>images/arrow_lt.gif" width="23" height="23" border="0" alt=""></td>
                      <td valign="top" align="left"><a href="PendingShopCartsDisplayView?catalogId=<%=catalogId%>"><%=storeText.getString("ShopCartDeleteDisplay_Cancel")%></a></td>
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
