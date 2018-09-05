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
<%@ page import="javax.servlet.*" %>
<%@ page import="com.ibm.commerce.datatype.*" %>
<%@ page import="com.ibm.commerce.server.JSPHelper" %>
<%@ page import="com.ibm.commerce.server.ECConstants" %>
<%@ page import="com.ibm.commerce.command.CommandContext" %>
<%@ include file="../../../include/EnvironmentSetup.jsp"%>
<%
//Parameters may be encrypted. Use JSPHelper to get URL parameter instead of request.getParameter().
String orderRn = jhelper.getParameter("orderId");
String channelOrderRn = jhelper.getParameter("channelOrderId");
String forwardView = jhelper.getParameter("forwardView");
String multipleShopcart = jhelper.getParameter("multipleShopcart");
String autoOpen = jhelper.getParameter("autoOpen");
String openAllWindows = jhelper.getParameter("openAllWindows");
TypedProperty requestProperties = (TypedProperty)request.getAttribute(ECConstants.EC_REQUESTPROPERTIES) ;

out.println("<!-- orderId : " + orderRn + " -->");
out.println("<!-- requestProperties : \n" + requestProperties + " -->");
%>
<script language="javascript">

function submitForm(form) {
  form.submit();
}
</script>
<?xml version="1.0"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "DTD/xhtml1-transitional.dtd">
<HEAD>
  <TITLE><%=storeText.getString("OrderTransferWaitDisplay_Title")%></TITLE>
  <LINK REL=stylesheet HREF="<%=fileDir%>PCDMarket.css" TYPE="text/css">
</HEAD>
<body marginheight="0" marginwidth="0" onLoad="setTimeout('submitForm(document.quoteWaitForm)', <%=storeText.getString("OrderTransferWaitDisplay_Timeout")%>)">
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
    <!-- Begin Main Content TD -->
    <form name="quoteWaitForm" method="post" action="OrderTransferCheck">
    <INPUT type=hidden name="okURL" value="<%=forwardView%>">
    <INPUT type=hidden name="waitURL" value="OrderTransferWaitDisplayView">
    <INPUT type=hidden name="forwardView" value="<%=forwardView%>">
    <INPUT type=hidden name="timeoutURL" value="OrderTransferTimeOutDisplayView">
    <INPUT type=hidden name="errorURL" value="OrderTransferTimeOutDisplayView">    
  
    <INPUT type=hidden name="transferMode" value="0">
    <INPUT type=hidden name="outOkOrderIdName" value="childOrderId">
    <INPUT type=hidden name="outTimeoutOrderIdName" value="timeoutOrderId">
    <INPUT type=hidden name="outWaitOrderIdName" value="waitOrderId">
    <INPUT type=hidden name="channelOrderId" value="<%=channelOrderRn%>">
    <INPUT type=hidden name="multipleShopcart" value="<%=multipleShopcart%>">
    <INPUT type=hidden name="openAllWindows" value="<%=openAllWindows%>">
    <INPUT type=hidden name="autoOpen" value="<%=autoOpen%>">  
  <% if (multipleShopcart.equals("1")) {
      String[] orderChecks = jhelper.getParameterValues("orderCheckId");
      if (orderChecks == null || orderChecks.length==0) {
        orderChecks = jhelper.getParameterValues("orderId"); // refresh case
      }
      for(int checks=0;checks<orderChecks.length;checks++) { %>
    <INPUT type=hidden name="orderId" value="<%=orderChecks[checks]%>">
  <%  } 
     } else { %>
    <INPUT type=hidden name="orderId" value="<%= orderRn %>">
  <% }%>  
    </form>
    <td valign="top" width="600"><a name="mainContent"></a>
      <table width="600" border="0" cellpadding="0" cellspacing="2">
        <tr>
          <td>
            <table width="590" border="0" cellspacing="0" cellpadding="0">        
              <tr>
          			<td colspan=2><span class="bct">&nbsp;&nbsp;&nbsp;</span>
          			<a class="bctl" href="StoreCatalogDisplay?storeId=<%=storeId%>&catalogId=<%=catalogId%>&langId=<%=languageId%>"><%=storeText.getString("Breadcrumb_CommercePlaza")%></a><span class="bct">&nbsp;&nbsp;&nbsp;&gt;&nbsp;&nbsp;&nbsp;</span>
          			<span class="bct"><%=storeText.getString("Breadcrumb_RequestPriceAvail")%></span>
                </td>
              </tr>
              <tr>
                <td valign="top" width="310">
                  <div align="left"><span class="title"><%=storeText.getString("OrderTransferWaitDisplay_Intro")%></span></div>
                </td>
                <td valign="top" width="280">
                  <div align="right"><img src="<%=fileDir%>images/hdr_cart.gif" width="280" height="72" alt="<%=storeText.getString("OrderTransferWaitDisplay_Intro")%>"></div>
                </td>
              </tr>
            </table>
          </td>
        </tr>
        <tr>
          <td>
            <span class="subtitle"><%=storeText.getString("OrderTransferWaitDisplay_Wait")%></span>
          </td>
        </tr>   
      </table>
    </td>
    <!-- End Main Content TD -->
  </tr></tbody>
</table>
<!-- End Main Table -->
<!-- Start Footer -->
<%@ include file="../../../include/FooterDisplay.jspf"%>
<!-- End Footer -->
</BODY>
</HTML>
