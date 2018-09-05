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
<%@ page import="com.ibm.commerce.datatype.*" %>
<%@ page import="com.ibm.commerce.beans.UrlCommandInvokerDataBean" %>
<%@ page import="com.ibm.commerce.common.beans.*" %>
<%@ page import="com.ibm.commerce.order.beans.*" %>
<%@ include file="../../../include/EnvironmentSetup.jsp"%>
<%
//Parameters may be encrypted. Use JSPHelper to get URL parameter instead of request.getParameter().
String orderRn = jhelper.getParameter("orderId");

OrderDataBean orderBean = new OrderDataBean();
orderBean.setOrderId( orderRn );
com.ibm.commerce.beans.DataBeanManager.activate(orderBean, request);

Integer[] distIdList = cmdcontext.getStore().getRelatedStores("com.ibm.commerce.referral");
String quotationType = jhelper.getParameter("quotationType");
String orderQuotationRelId = jhelper.getParameter("orderQuotationRelId");
String[] waitOrderQuotationRelIds = jhelper.getParameterValues("waitOrderQuotationRelId"); 

if (waitOrderQuotationRelIds != null && waitOrderQuotationRelIds.length >0) {
// if there are still waiting quotation, continue to check until no waiting quotation
%>
    <script language="javascript">
    function submitForm(form) {
    
      if (form.quotationType.value == "initial") {
        form.okURL.value = "OrderQuotationDisplay?orderQuotationDisplayViewName=OrderQuotationDisplayByDistributorFormView&outOrderQuotationRelIdName=orderQuotationIDs";
      }
    
      if (form.quotationType.value == "final") {
        form.okURL.value = "DistributorShopCartReviewDisplayView";
      }
    
      form.submit();
    }
    </script>
    <?xml version="1.0"?>
    <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "DTD/xhtml1-transitional.dtd">    
    <body marginheight="0" marginwidth="0" onLoad="setTimeout('submitForm(document.quoteWaitForm)', 0)">
    <form name="quoteWaitForm" method="POST" action="OrderQuotationCheck">
    <INPUT type=hidden name="okURL" value="">
    <INPUT type=hidden name="waitURL" value="OrderQuotationWaitDisplayView">
    <INPUT type=hidden name="timeoutURL" value="OrderQuotationTimeOutDisplayView">
    <INPUT type=hidden name="errorURL" value="OrderQuotationTimeOutDisplayView">
    <INPUT type=hidden name="outTimeoutOrderQuotationRelIdName" value="timeoutOrderRelId">
    <INPUT type=hidden name="outWaitOrderQuotationRelIdName" value="waitOrderQuotationRelId">
    <INPUT type=hidden name="orderId" value="<%= orderRn %>">
    <% if (orderQuotationRelId != null ) { %>
    <INPUT type=hidden name="orderQuotationRelId" value="<%= orderQuotationRelId %>">
    <% } %>
    <INPUT type=hidden name="quotationType" value="<%= quotationType %>">
    </form>
    </body>
    </html>
<%
}
else
{
 
  String[] failOrderQuotationRelIds = jhelper.getParameterValues("failOrderQuotationRelId");
  UrlCommandInvokerDataBean urlBean = null;
  if(quotationType.equals("initial")) {
    urlBean = new UrlCommandInvokerDataBean();
    urlBean.setUrlName("OrderQuotationDisplay");
    TypedProperty iProperties = cmdcontext.getRequestProperties();
    iProperties.put("orderQuotationDisplayViewName","OrderQuotationDisplayByDistributorFormView");
    iProperties.put("outOrderQuotationRelIdName","orderQuotationIDs");
    urlBean.setRequestProperties(iProperties);    
  } else { 
    urlBean = new UrlCommandInvokerDataBean();
    TypedProperty iProperties = cmdcontext.getRequestProperties();
    urlBean.setRequestProperties(iProperties);
    urlBean.setUrlName("DistributorShopCartReviewDisplayView");
  }  
  
  // if there are any errors with code 1, DistributorSelectionDisplayView will be invoked
  if ((failOrderQuotationRelIds!= null) && (failOrderQuotationRelIds.length>0)) {
    for(int i=0;i<failOrderQuotationRelIds.length;i++) {
      StringTokenizer st = new StringTokenizer(failOrderQuotationRelIds[i], "_");
      String orderQuotRelId = st.nextToken();
      String errorCode = st.nextToken();
      if (errorCode!=null && errorCode.equals("1")) {
        urlBean = new UrlCommandInvokerDataBean();
        urlBean.setUrlName("DistributorSelectionDisplayView");
      }
    }
  }
  com.ibm.commerce.beans.DataBeanManager.activate(urlBean, request);
} // end else
%>