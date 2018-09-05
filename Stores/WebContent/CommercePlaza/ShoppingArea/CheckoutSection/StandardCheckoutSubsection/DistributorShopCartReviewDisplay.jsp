<%
//********************************************************************
//*-------------------------------------------------------------------
//* Licensed Materials - Property of IBM
//*
//* 5697-D24
//*
//* (c) Copyright IBM Corp. 2000, 2002
//*
//* US Government Users Restricted Rights - Use, duplication or
//* disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
//*
//*-------------------------------------------------------------------
//********************************************************************
%>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %> 
<%@ page import="java.util.Vector" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="com.ibm.commerce.server.*" %>
<%@ page import="com.ibm.commerce.command.*" %>
<%@ page import="com.ibm.commerce.beans.*" %>
<%@ page import="com.ibm.commerce.datatype.*" %>
<%@ page import="com.ibm.commerce.common.beans.*" %>
<%@ page import="com.ibm.commerce.common.objects.*" %>
<%@ page import="com.ibm.commerce.catalog.beans.*" %>
<%@ page import="com.ibm.commerce.catalog.objects.*" %>
<%@ page import="com.ibm.commerce.user.beans.*" %>
<%@ page import="com.ibm.commerce.user.objects.*" %>
<%@ page import="com.ibm.commerce.order.beans.*" %>
<%@ page import="com.ibm.commerce.order.objects.*" %>
<%@ page import="com.ibm.commerce.inventory.beans.*" %>
<%@ page import="com.ibm.commerce.price.beans.*" %>         
<%@ page import="com.ibm.commerce.utils.TimestampHelper" %>
<%@ page import="com.ibm.commerce.contract.beans.ContractDataBean" %>         
<%@ page import="java.net.URLEncoder" %>
<%@ include file="../../../include/EnvironmentSetup.jsp"%>
<% response.setContentType(storeText.getString("ENCODESTATEMENT")); %> 
<%
  String orderRn = jhelper.getParameter("orderId");
  String channelOrderId = jhelper.getParameter("channelOrderId");
  String processedOrderId = new String("");
  String submitForm = jhelper.getParameter("submitForm");
  String autoOpen = jhelper.getParameter("autoOpen");
  String openAllWindows = jhelper.getParameter("openAllWindows");
  String strSystemMessage = null;

  Integer[] distIdList = cmdcontext.getStore().getRelatedStores("com.ibm.commerce.referral");

  storeId = cmdcontext.getStoreId().toString();  
  if( (channelOrderId != null) && (channelOrderId.length() > 0) ) {
    processedOrderId = orderRn;
    orderRn = channelOrderId;
  }

  String outOrderQuotationRelIdName = null;
  String [] orderQuotationRelIds = null;
  OrderQuotationRelDataBean orderQuotationRelDB = null;
  TypedProperty requestProperties = (TypedProperty)request.getAttribute(ECConstants.EC_REQUESTPROPERTIES) ;

  if (orderRn == null) {
    // Obtain orderRn from OrderQuotationRelDB
    outOrderQuotationRelIdName = requestProperties.getString("outOrderQuotationRelIdName", null);
    if (outOrderQuotationRelIdName == null) outOrderQuotationRelIdName = "orderQuotationRelId";

    orderQuotationRelIds = requestProperties.getArray(outOrderQuotationRelIdName, null);
    if ((orderQuotationRelIds != null) && (orderQuotationRelIds.length > 0)) {
      orderQuotationRelDB = new OrderQuotationRelDataBean();
      orderQuotationRelDB.setDataBeanKeyOrderQuotationRelId(orderQuotationRelIds[0]);
      com.ibm.commerce.beans.DataBeanManager.activate(orderQuotationRelDB, request);
      orderRn = orderQuotationRelDB.getParentId();
    } else {
  %><h4>Cannot Obtain Order Quotation Rel DB from <%= outOrderQuotationRelIdName %>!! </h4><%     
    }
  }

 String returnURL = "DistributorShopCartReviewDisplayView?orderId=" + orderRn;

 out.println("<!-- orderId : " + orderRn + " -->");
 out.println("<!-- requestProperties : \n" + requestProperties + " -->");
 out.println("<!-- submitForm : " + submitForm + " -->");
%>
<jsp:useBean id="orderBean" class="com.ibm.commerce.order.beans.OrderDataBean" scope="page">
<% 
orderBean.setOrderId(orderRn);
com.ibm.commerce.beans.DataBeanManager.activate(orderBean, request);
%>
</jsp:useBean>

<jsp:useBean id="bnError" class="com.ibm.commerce.beans.ErrorDataBean" scope="page">
<% com.ibm.commerce.beans.DataBeanManager.activate(bnError, request); %>
</jsp:useBean>

<%
    strSystemMessage = bnError.getSystemMessage();
%>



<% catalogId = sdb.getStoreCatalogs()[0].getCatalogId(); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "DTD/xhtml1-transitional.dtd">
<html>
<head>
<title><%=storeText.getString("DistributorShopCartReview_Title")%></title>
<link rel=stylesheet href="<%=fileDir%>PCDMarket.css" type="text/css">
</head>
<script language="javascript">
var busy=false;
function RemoveUnassignedItems( form ) {
  if( !busy ) {
    busy = true;
    form.submit();
  }
}

function reloadOrderQuotationForm(form) {
  if( !busy ) {
    busy = true; 
    form.action='OrderQuotationDisplayByDistributorFormView?storeId=<%=storeId%>&catalogId=<%=catalogId%>&langId=<%=languageId%>&orderId=<%=orderRn%>';
    form.submit();
  }
}

function submitAllCartsForm(form) {

  if( !busy ) {
    busy = true; 
    if(document.UpdateOrderDesc.description.value == "") {
      alert("<%=storeText.getString("DistributorShopCartReview_JSWarning")%>");
      busy = false;
    }
    else {
      if(document.UpdateOrderDesc.changed.value == "1") {
        if (document.openWindowForm.openWindow.checked) document.UpdateOrderDesc.openAllWindows.value = "Y";
        document.UpdateOrderDesc.URL.value = "DistributorShopCartReviewDisplayView?storeId=<%=storeId%>&orderId=<%=orderRn%>&submitForm=" + form.name;
        document.UpdateOrderDesc.action='OrderCopy';
        document.UpdateOrderDesc.submit();
      }
      else {
        if (document.openWindowForm.openWindow.checked) form.openAllWindows.value = "Y";
        form.submit();
      }
    }
    
  }
}

function removeCartForm(form) {
  if( !busy ) {
    busy = true;  
    form.submit();
  }
}

function submitOneCartForm(form) {
  if( !busy ) {
    busy = true;   
    if(document.UpdateOrderDesc.description.value == "") {
      alert("<%=storeText.getString("DistributorShopCartReview_JSWarning")%>");
      busy = false;
    }
    else {
      if(document.UpdateOrderDesc.changed.value == "1") {
        document.UpdateOrderDesc.URL.value = "DistributorShopCartReviewDisplayView?storeId=<%=storeId%>&orderId=<%=orderRn%>&submitForm=" + form.name;
        document.UpdateOrderDesc.action='OrderCopy';
        document.UpdateOrderDesc.submit();
      }
      else {
        form.submit();
      }
    }
  }
}
<%String newURL = "";
  if((autoOpen!=null)&&(autoOpen.length()>0)) { 
    try {
      OrderDataBean autoOpenOrder = new OrderDataBean();
      autoOpenOrder.setOrderId( autoOpen );
      com.ibm.commerce.beans.DataBeanManager.activate(autoOpenOrder, request);  
      
      OrderReleaseDataBean orderRelease = new OrderReleaseDataBean();
      orderRelease.setDataBeanKeyOrdersId( autoOpen );
      orderRelease.setDataBeanKeyOrderReleaseNum( autoOpenOrder.getOrderItemDataBeans()[0].getOrderReleaseNumber());
      com.ibm.commerce.beans.DataBeanManager.activate(orderRelease, request);  
      newURL = orderRelease.getExternalReference();      
    } catch(Exception e) {
      out.println("<!-- Exception caught (autoOpen) : " + e + " -->");
    }    %>
function openNewWindow() {
    window.open("ExitToDistributorSiteDisplayView?storeId=<%=storeId%>&langId=<%=languageId%>&forwardURL=<%=java.net.URLEncoder.encode(newURL)%>","<%=autoOpen%>");
}
<%} %>
</script>
<%String submitAction = "";
  if ((submitForm!=null)&&(submitForm.length()>0)) {
   submitAction = "document." + submitForm + ".submit();"; 
  } else if ((autoOpen!=null)&&(autoOpen.length()>0)) {
   submitAction = "openNewWindow();";
  } %>
<body marginheight="0" marginwidth="0" onLoad="<%=submitAction%>">
<!-- Start Header -->
<%@ include file="../../../include/HeaderDisplay.jspf"%>
<!-- End Header -->
<!-- Start Main Table - Consists of TD for Left Bar, TD for Content and TD for Quicklinks -->
<table border="0" cellpadding="0" cellspacing="0" width="750">
<tr>
  <td valign="top" class="mbg" width="150">
    <% String incfile = includeDir + "SidebarDisplay.jsp";  %>
    <jsp:include page="<%=incfile%>" flush="true"/>
  </td>
  <!-- End  Left Nav Bar TD -->
  <td width="10"><a name="mainContent"></a><img height="1" width="10" alt="" src="<%=fileDir%>images/c.gif"></td> 
  <td valign="top" width="590"><a name="main">
  <!--START MAIN CONTENT-->
<% try { %>
  <table width="590" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td><span class="bct">&nbsp;&nbsp;&nbsp;</span>
	<a class="bctl" href="StoreCatalogDisplay?storeId=<%=storeId%>&catalogId=<%=catalogId%>&langId=<%=languageId%>"><%=storeText.getString("Breadcrumb_CommercePlaza")%></a><span class="bct">&nbsp;&nbsp;&nbsp;&gt;&nbsp;&nbsp;&nbsp;</span>
	<span class="bct"><%=storeText.getString("Breadcrumb_SubmitCart")%></span>
      </td>
    </tr>
    <tr>
      <td>
        <table width="590" border="0" cellspacing="0" cellpadding="0">        
          <tr>
            <td valign="top" width="310">
              <div align="left"><span class="title"><%=storeText.getString("DistributorShopCartReview_Submit")%></span></div>
              <div><span class="subtitle"><%=storeText.getString("DistributorShopCartReview_Step")%></span></div>
            </td>
            <td valign="top" width="280">
              <div align="right"><img src="<%=fileDir%>images/hdr_cart.gif" width="280" height="72" alt="<%=storeText.getString("DistributorShopCartReview_Submit")%>"></div>
            </td>
          </tr>
        </table>
      </td>
    </tr>

    <!-- Show error message if it isn't null-->
    <%
    if((strSystemMessage != null)&&(strSystemMessage.trim().length()>0))
    {
        %>
        <tr><td><font class="error"><%=strSystemMessage%></font></td></tr>
        <%
    }
    %>

    <tr>
       <td><b><%=storeText.getString("DistributorShopCartReview_Inquiry")%></b>&nbsp;<b><%=TimestampHelper.getDateFromTimestamp(orderBean.getLastUpdateInEJBType(),locale)%> <%=orderBean.getLastUpdateInEJBType().toString().substring(11,16)%>*</b></td>
    </tr>
    <tr>
      <td><img src="<%=fileDir%>images/c.gif" height="10" width=1 alt=""></td>              
    </tr>
    <tr>
      <td>
        <table width="590" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td><%=storeText.getString("DistributorShopCartReview_Save1")%></td>
          </tr>
          <tr height=10><td></td></tr>
          <tr>
            <td><b><label for="descriptiontext"><%=storeText.getString("DistributorShopCartReview_Save2")%></label></b>&nbsp;<b><%=storeText.getString("DistributorShopCartReview_Save3")%></b></td>
          </tr>
     <% String formValue = orderBean.getDescription();
        if( formValue == null )
           formValue=""; %>
          <form name="UpdateOrderDesc" method="post" action="#">
          <input type="hidden" name="toOrderId" value="<%=orderRn%>">
          <input type="hidden" name="URL" value="#">
          <input type="hidden" name="changed" value="0">
          <input type="hidden" name="check" value="*n">
          <INPUT TYPE="hidden" NAME="errorViewName" value="DistributorShopCartReviewDisplayView">
          <input type=hidden name="openAllWindows" value="N">
          <tr>
            <td><input type="text" id="descriptiontext" name="description" size="12" value="<%=formValue%>" onchange="document.UpdateOrderDesc.changed.value='1';" class="iform"></td>
          </tr>
          </form>
          <tr height=10><td></td></tr>
        </table>
      </td>
    </tr>
    <form name="ReviewDistributorForm" method="post" action="OrderPrepare">
    <INPUT type=hidden name="channelOrderId" value="<%=orderRn%>">
    <INPUT type=hidden name="quotationSubmission" value="1">
    <INPUT type=hidden name="reduceParentQuantities" value="1">
    <INPUT type=hidden name="policyId" value="-9900">
    <INPUT type=hidden name="reverse" value="*n">
    <INPUT type=hidden name="multipleShopcart" value="1">
    <INPUT type=hidden name="openAllWindows" value="<%=openAllWindows%>">
    <INPUT TYPE="hidden" NAME="errorViewName" value="DistributorShopCartReviewDisplayView">
    <INPUT type=hidden name="URL" value="OrderProcess?commit=1&channelOrderId=<%=orderRn%>">
            
    <%
    OrderDataBean [] finalOrderBeans = orderBean.getChildOrders(distIdList, "final");
    OrderDataBean [] submissionOrderBeans = orderBean.getChildOrders(distIdList, "submission");
    
    // this loop is used to construct the form for submitting all carts
    for (int i=0; i<finalOrderBeans.length; i++) {     
      OrderDataBean distOrder = finalOrderBeans[i];
      OrderDataBean[] siblingOrders;
      OrderDataBean selectOrder;
      
      siblingOrders = distOrder.getSiblingSelectionOrders();
      if( siblingOrders.length > 0 ) {
        selectOrder = siblingOrders[0];      
        if (selectOrder.getStatus().equals("P")) {  %>
    <INPUT type=hidden name="orderId" value="<%=selectOrder.getOrderId() %>">
    <INPUT type=hidden name="orderCheckId" value="<%=selectOrder.getOrderId() %>">  
  <%    } //End-if, only unsubmitted carts should be in this list
      }  
    } %>
</form>

<%  // outer loop - for child selection orders
    for (int i=0; i<finalOrderBeans.length; i++) {     
      OrderDataBean distOrder = finalOrderBeans[i];

      OrderDataBean[] siblingOrders;
      OrderDataBean selectOrder;
      String distName=null;
      String distURL=null;
      String storePhone1 = null;
      
      siblingOrders = distOrder.getSiblingSelectionOrders();
      if( (siblingOrders!=null)&&(siblingOrders.length>0)) {
        selectOrder = siblingOrders[0];
  
        // Find the StoreEntityDataBean
        StoreEntityDataBean storeEntity = new StoreEntityDataBean();
        storeEntity.setDataBeanKeyStoreEntityId( selectOrder.getStoreEntityId() );
        com.ibm.commerce.beans.DataBeanManager.activate(storeEntity, request);
  
        try {
          // Get the appropriate description of the store entity - for the store display name       
          Integer iLangId = Integer.valueOf(languageId);  
          StoreEntityDescriptionAccessBean storeDesc = storeEntity.getDescription(iLangId);        
          distName = storeDesc.getDisplayName();
          String contactAddressId = storeDesc.getContactAddressId();
          if (contactAddressId != null)
          {
            StoreAddressDataBean storeAddressDB = new StoreAddressDataBean();
            storeAddressDB.setDataBeanKeyStoreAddressId(contactAddressId);
            com.ibm.commerce.beans.DataBeanManager.activate(storeAddressDB, request);
            storePhone1 = storeAddressDB.getPhone1();
            distURL = storeAddressDB.getURL();
  
          }    
        } catch(Exception e) {
          out.println("<!-- Exception caught (1) : " + e + " -->");
          if( distName==null ) {
            distName = storeEntity.getIdentifier();
          }
          if( storePhone1==null) {
            storePhone1 = new String();
          }
        }
        OrderItemDataBean[] distOrderItems = distOrder.getOrderItemDataBeans();
        String URLString = "OrderProcess?orderId=" + selectOrder.getOrderId() + "&quotationSubmission=1&policyId=-9900&reduceParentQuantities=1&URL=DistributorShopcartReviewDisplayView";  
    %>
    <form name="ReviewDistributorShopCart_<%= i %>" method="POST" action="OrderPrepare">
    <INPUT type=hidden name="URL" value="<%=URLString%>" >
    <INPUT type=hidden name="orderId" value="<%=selectOrder.getOrderId() %>">  
    <INPUT type=hidden name="parentOrderId" value="<%=orderBean.getOrderId() %>">    
    <INPUT type=hidden name="policyId" value="-9900">
    <INPUT type=hidden name="reverse" value="*n">
    <INPUT type=hidden name="reduceParentQuantities" value="1">
    <INPUT type=hidden name="quotationSubmission" value="1">
    <INPUT type=hidden name="multipleShopcart" value="0">
    <INPUT type=hidden name="autoOpen" value="<%=selectOrder.getOrderId() %>">
    <INPUT TYPE="hidden" NAME="errorViewName" value="DistributorShopCartReviewDisplayView">
    
    </form>
    <tr>
      <td>
        <table cellpadding="2" cellspacing="0" border="0" width="590">
          <tr class="tdblue">
            <%if (distURL!=null) { %>
            <th width="300" id="th_dist<%=i%>" class="tdblue"><a href="ExitToDistributorSiteDisplayView?storeId=<%=storeId%>&langId=<%=languageId%>&forwardURL=<%=java.net.URLEncoder.encode(distURL)%>" target="_blank"><SPAN class=small style="FONT-WEIGHT: bold; COLOR: #ffffff; text-decoration: underline"><%=distName%></span></a></th>
            <% } else { %>
            <th width="300" id="th_dist<%=i%>" class="tdblue"><SPAN class=small style="FONT-WEIGHT: bold; COLOR: #ffffff"><%=distName%></span> </th>
            <% } %>
            <td align="right" width=300>
              <table>
                 <tr>
                   <td class="tdblue"><a href="javascript:submitOneCartForm(document.ReviewDistributorShopCart_<%= i %>)"><SPAN class=small style="FONT-WEIGHT: bold; COLOR: #ffffff; text-decoration: underline"><%=storeText.getString("DistributorShopCartReview_Submit2")%></span></a></td>
                   <td class="tdblue"><a href="javascript:submitOneCartForm(document.ReviewDistributorShopCart_<%= i %>)"><img src="<%=fileDir%>images/shopping_cart_t.gif" width="21" height="21" border="0" alt="<%=storeText.getString("DistributorShopCartReview_Submit2")%>"></a></td>
                 </tr>
              </table>
            </td>
          </tr>
        </table>
      </td>
    </tr>
    <tr>
      <td>
        <table width="590" cellpadding="2" border="0" cellspacing="1">
          <tr class="mbg" valign="top">
            <th width=75 valign="top" align="left" id="th1_<%=i%>"><SPAN class=small style="FONT-WEIGHT: bold"><%=storeText.getString("DistributorShopCartReview_DistSKU")%></span></th>
            <th width=75 valign="top" align="left" id="th2_<%=i%>"><SPAN class=small style="FONT-WEIGHT: bold"><%=storeText.getString("DistributorShopCartReview_IBMPart")%></span></th>
            <th width=250 valign="top" align="left" id="th3_<%=i%>"><SPAN class=small style="FONT-WEIGHT: bold"><%=storeText.getString("DistributorShopCartReview_Desc")%></span></th>
            <th width=75 valign="top" align="left" id="th4_<%=i%>"><SPAN class=small style="FONT-WEIGHT: bold"><%=storeText.getString("DistributorShopCartReview_DistPrice")%> *</span></th>
            <th width=50 valign="top" align="left" id="th5_<%=i%>"><SPAN class=small style="FONT-WEIGHT: bold"><%=storeText.getString("DistributorShopCartReview_OrdQty")%></span></th>
            <th width=75 valign="top" align="left" id="th6_<%=i%>"><SPAN class=small style="FONT-WEIGHT: bold"><%=storeText.getString("DistributorShopCartReview_LineTotal")%></span></th>
          </tr>
     <% // inner loop - for order items
        for( int j=0;j<distOrderItems.length;j++) {
          OrderItemDataBean distOI = distOrderItems[j];
          OrderItemDataBean selectOI;
          selectOI = distOI.getSiblingSelectionItems()[0];
          if ((distOI.getLineItemType()!=null)&&(distOI.getLineItemType().equals("ALT"))) { 
     %>
          <tr>
            <td valign="top" headers="=th_dist<%=i%> th1_<%=i%>"><span class=small><%=distOI.getPartNumber()%></span></td>
            <td valign="top" headers="th_dist<%=i%> th2_<%=i%>">&nbsp</td>
            <td valign="top" headers="th_dist<%=i%> th3_<%=i%>"><span class=small><%=distOI.getCatalogEntry().getDescription().getShortDescription()%></span></td>
            <td align="right" valign="top" headers="th_dist<%=i%> th4_<%=i%>"><span class=small><%=distOI.getPriceDataBean()%></span></td>
            <td valign="top" headers="th_dist<%=i%> th5_<%=i%>"><span class=small><%=selectOI.getFormattedQuantity() %></span></td>
            <td align="right" valign="top" headers="th_dist<%=i%> th6_<%=i%>"><span class=small><%=selectOI.getPerItemTotalPrice().toString()%></span></td>
          </tr>
    <% } else { %>
          <tr>
            <td valign="top" headers="th_dist<%=i%> th1_<%=i%>"><span class=small><%=distOI.getPartNumber()%></span></td>
            <td valign="top" headers="th_dist<%=i%> th2_<%=i%>"><a href="ProductDisplay?storeId=<%=storeId%>&langId=<%=languageId%>&productId=<%=distOI.getCatalogEntryId()%>"><span class=small><%=distOI.getPartNumber()%></span></a></td>
            <td valign="top" headers="th_dist<%=i%> th3_<%=i%>"><span class=small><%=distOI.getCatalogEntry().getDescription().getShortDescription()%></span></td>
            <td align="right" valign="top" headers="th_dist<%=i%> th4_<%=i%>"><span class=small><%=distOI.getPriceDataBean()%></span></td>
            <td valign="top" headers="th_dist<%=i%> th5_<%=i%>"><span class=small><%=selectOI.getFormattedQuantity() %></span></td>
            <td align="right" valign="top" headers="th_dist<%=i%> th6_<%=i%>"><span class=small><%=selectOI.getPerItemTotalPrice().toString()%></span></td>
          </tr>
    <% } %>          
          <tr>
            <td colspan="7" class="gbg"></td>
          </tr>
     <% } // end inner loop %>          
          <tr>
            <td colspan=4>&nbsp;</td>
            <td><span class=small><strong><%=storeText.getString("DistributorShopCartReview_Subtotal")%></strong></span></td>
            <td align="right"><span class=small><strong><%=selectOrder.getSubTotal()%></strong></span></td>
          </tr>
          <tr height=10>
            <td>&nbsp</td>
          </tr>
        </table>
      </TD>
    </tr>
 <%   }
    }  // end outer loop   
    
  /* Submission children */
    if( (submissionOrderBeans!=null)&&(submissionOrderBeans.length>0)) {
      for(int i=0;i<submissionOrderBeans.length;i++) {
        OrderDataBean submissionOrder = submissionOrderBeans[i];              
        com.ibm.commerce.beans.DataBeanManager.activate(submissionOrder, request);
        
        String distName=null;
        String distURL=null;
        String storePhone1 = null;
        String transferredURL = null;  
        OrderItemDataBean[] distOrderItems = submissionOrder.getOrderItemDataBeans();
  
        // Find the StoreEntityDataBean
        StoreEntityDataBean storeEntity = new StoreEntityDataBean();
        storeEntity.setDataBeanKeyStoreEntityId( submissionOrder.getStoreEntityId() );
        // com.ibm.commerce.beans.DataBeanManager.activate(storeEntity, request);
    
        try {
          // Get the appropriate description of the store entity - for the store display name       
          Integer iLangId = Integer.valueOf(languageId);  
          StoreEntityDescriptionAccessBean storeDesc = storeEntity.getDescription(iLangId);        
          distName = storeDesc.getDisplayName();
          String contactAddressId = storeDesc.getContactAddressId();
          if (contactAddressId != null)
          {
            StoreAddressDataBean storeAddressDB = new StoreAddressDataBean();
            storeAddressDB.setDataBeanKeyStoreAddressId(contactAddressId);
            com.ibm.commerce.beans.DataBeanManager.activate(storeAddressDB, request);
            storePhone1 = storeAddressDB.getPhone1();
            distURL = storeAddressDB.getURL();
    
          }    
        } catch(Exception e) {
          if( distName==null ) {
            distName = storeEntity.getIdentifier();
          }
          if( storePhone1==null) {
            storePhone1 = new String();
          }
        }
  
        try {
          OrderReleaseDataBean orderRelease = new OrderReleaseDataBean();
          orderRelease.setDataBeanKeyOrdersId( submissionOrder.getOrderId() );
          orderRelease.setDataBeanKeyOrderReleaseNum( submissionOrder.getOrderItemDataBeans()[0].getOrderReleaseNumber());
          com.ibm.commerce.beans.DataBeanManager.activate(orderRelease, request);    
          
          transferredURL = orderRelease.getExternalReference();
        } catch(Exception e) {
          out.println("<!-- Exception caught (openAll) : " + e + " -->");
          transferredURL = new String();
        } %>
    <tr>
      <td>
        <table cellpadding="2" cellspacing="0" border="0" width="590">
          <tr  class=tdblue>
            <%if (distURL!=null) { %>
            <td width=300><a href="ExitToDistributorSiteDisplayView?storeId=<%=storeId%>&langId=<%=languageId%>&forwardURL=<%=java.net.URLEncoder.encode(distURL)%>" target="_blank"><SPAN class=small style="FONT-WEIGHT: bold; COLOR: #ffffff; text-decoration: underline"><%=distName%></span></a></td>
            <% } else { %>
            <td width=300><SPAN class=small style="FONT-WEIGHT: bold; COLOR: #ffffff"><%=distName%></span> </td>
            <% } %>
            <td align="right" width=300>
<%    if(( transferredURL!=null)&&(transferredURL.length()>0)&&(!transferredURL.equals("null"))) { %>
              <table>
                 <tr>
                   <td align="right"><a href="ExitToDistributorSiteDisplayView?storeId=<%=storeId%>&langId=<%=languageId%>&forwardURL=<%=java.net.URLEncoder.encode(transferredURL)%>" target="_blank"><SPAN class=small style="FONT-WEIGHT: bold; COLOR: #ffffff; text-decoration: underline"><%=storeText.getString("DistributorShopCartReview_Open")%></span></a></td>
                   <td><a href="ExitToDistributorSiteDisplayView?storeId=<%=storeId%>&langId=<%=languageId%>&forwardURL=<%=java.net.URLEncoder.encode(transferredURL)%>" target="_blank"><img src="<%=fileDir%>images/btn_addcart.gif" width="21" height="21" border="0" alt="<%=storeText.getString("DistributorShopCartReview_Open")%>"></a></td>
                 </tr>
              </table>
<%    } else {  %>
              <table>
                 <tr>
                   <td align="right">&nbsp;</td>
                   <td><SPAN class=small style="FONT-WEIGHT: bold; COLOR: #ffffff"><%=storeText.getString("ShopcartOrderConfirmation_Call")%> <%=storePhone1%></span></td>
                 </tr>
              </table>
<%    }     %>
            </td>
          </tr>
        </table>
      </td>
    </tr>
    <tr>
      <td>
        <table width="590" cellpadding="2" border="0" cellspacing="1">
          <tr class="mbg" valign="top">
            <th width=75 valign="top" align="left"><SPAN class=small style="FONT-WEIGHT: bold"><%=storeText.getString("DistributorShopCartReview_DistSKU")%></span></th>
            <th width=75 valign="top" align="left"><SPAN class=small style="FONT-WEIGHT: bold"><%=storeText.getString("DistributorShopCartReview_IBMPart")%></span></th>
            <th width=250 valign="top" align="left"><SPAN class=small style="FONT-WEIGHT: bold"><%=storeText.getString("DistributorShopCartReview_Desc")%></span></th>
            <th width=75 valign="top" align="left"><SPAN class=small style="FONT-WEIGHT: bold"><%=storeText.getString("DistributorShopCartReview_DistPrice")%> *</span></th>
            <th width=50 valign="top" align="left"><SPAN class=small style="FONT-WEIGHT: bold"><%=storeText.getString("DistributorShopCartReview_OrdQty")%></span></th>
            <th width=75 valign="top" align="left"><SPAN class=small style="FONT-WEIGHT: bold"><%=storeText.getString("DistributorShopCartReview_LineTotal")%></span></th>
          </tr>
     <% // inner loop - for order items
        for( int j=0;j<distOrderItems.length;j++) {
          OrderItemDataBean distOI = distOrderItems[j];
          OrderItemDataBean selectOI = distOI.getSiblingSubmissionItems()[0];
          if ((distOI.getLineItemType()!=null)&&(distOI.getLineItemType().equals("ALT"))) { 
     %>
          <tr>
            <td valign="top"><span class=small><%=distOI.getPartNumber()%></span></td>
            <td valign="top">&nbsp</td>
            <td valign="top"><span class=small><%=distOI.getCatalogEntry().getDescription().getShortDescription()%></span></td>
            <td align="right" valign="top"><span class=small><%=distOI.getPriceDataBean()%></span></td>
            <td valign="top"><span class=small><%=selectOI.getFormattedQuantity() %></span></td>
            <td align="right" valign="top"><span class=small><%=selectOI.getPerItemTotalPrice().toString()%></span></td>
          </tr>
    <%    } else { %>
          <tr>
            <td valign="top"><span class=small><%=distOI.getPartNumber()%></span></td>
            <td valign="top"><a href="ProductDisplay?storeId=<%=storeId%>&langId=<%=languageId%>&productId=<%=distOI.getCatalogEntryId()%>"><span class=small><%=distOI.getPartNumber()%></span></a></td>
            <td valign="top"><span class=small><%=distOI.getCatalogEntry().getDescription().getShortDescription()%></span></td>
            <td align="right" valign="top"><span class=small><%=distOI.getPriceDataBean()%></span></td>
            <td valign="top"><span class=small><%=selectOI.getFormattedQuantity() %></span></td>
            <td align="right" valign="top"><span class=small><%=selectOI.getPerItemTotalPrice().toString()%></span></td>
          </tr>
    <%    } %>          
          <tr>
            <td colspan="7" class="gbg"></td>
          </tr>
     <% } // end inner loop %>          
          <tr>
            <td colspan=4>&nbsp;</td>
            <td><span class=small><strong><%=storeText.getString("DistributorShopCartReview_Subtotal")%></strong></span></td>
            <td align="right"><span class=small><strong><%=submissionOrder.getSubTotal()%></strong></span></td>
          </tr>
          <tr height=10>
            <td>&nbsp</td>
          </tr>
        </table>
      </TD>
    </tr>
<%    } //End of submission loop
    }  
    if ((finalOrderBeans.length == 0)) { %>
    <tr><td colspan=4><b><%=storeText.getString("DistributorShopCartReview_Error")%></b><br><br></td></tr>
 <% }
 
    // Find & display unassigned items
    Vector unassignedItems = new Vector();
    OrderItemDataBean[] parentItems = orderBean.getOrderItemDataBeans();
    for( int i=0;i<parentItems.length;i++) {
      OrderItemDataBean orderItem = parentItems[i];                                  
      OrderItemDataBean[] selectItems = orderItem.getChildItems(distIdList, "BOTH", "selection");
      double assigned=0.0;
      double requested = orderItem.getQuantityInEJBType().doubleValue();
      for (int loop=0;loop<selectItems.length;loop++) {
        if(selectItems[loop].getOrder().getStatus().equals("P")) {
          assigned += selectItems[loop].getSelectionQuantity().doubleValue();                
        }
      }
      if (requested > assigned) {         
        orderItem.setField2( String.valueOf(requested-assigned));
        unassignedItems.add(orderItem);
      }
    } // end of loop     
     
    // don't display the unassigned items unless there are some!!
    if( unassignedItems.size() > 0 ) {    %>
    <form name="AllUnassignedItems" action="OrderItemUpdate" method="POST">
    <input type="hidden" name="URL" value="<%=returnURL%>">
<%    for(int i=0;i<unassignedItems.size();i++) {
        OrderItemDataBean orderItem = (OrderItemDataBean)unassignedItems.elementAt(i);    
        String thisId = orderItem.getOrderItemId();
        double thisQty = Double.parseDouble(orderItem.getQuantity()) - Double.parseDouble(orderItem.getField2()); %>
    <input type="hidden" name="orderItemId_<%=i%>" value="<%=thisId%>">
    <input type="hidden" name="quantity_<%=i%>" value="<%=thisQty%>">
<%    } %>    
    <input type="hidden" name="storeId" value="<%=storeId%>">
    <input type="hidden" name="catalogId" value="<%=catalogId%>">
    <input type="hidden" name="allocate" value="*n">
    <input type="hidden" name="reverse" value="*n">
    <input type="hidden" name="backorder" value="*n">
    <input type="hidden" name="check" value="*n">
    <input type="hidden" name="merge" value="*n">
    <input type="hidden" name="remerge" value="*n">            
    </form>
    <tr>
      <td>
        <table cellpadding="2" cellspacing="0" border="0" width="590">
          <tr  class=tdblue>
            <td><SPAN class=small style="FONT-WEIGHT: bold; COLOR: #ffffff"><%=storeText.getString("DistributorShopCartReview_NotAssigned")%></span> </td>
            <td align="right">
              <table>
                 <tr>
                   <td><a href="javascript:RemoveUnassignedItems(document.AllUnassignedItems)"><SPAN class=small style="FONT-WEIGHT: bold; COLOR: #ffffff; text-decoration: underline"><%=storeText.getString("DistributorShopCartReview_RemoveAll")%></span></a></td>
                   <td><a href="javascript:RemoveUnassignedItems(document.AllUnassignedItems)"><img src="<%=fileDir%>images/icn_trash.gif" border="0" alt="<%=storeText.getString("DistributorShopCartReview_RemoveAll")%>"></a></td>
                 </tr>
              </table>
            </td>
          </tr>
        </table>
      </td>
    </tr>
    <tr>
      <td>
        <table width="590" cellpadding="2" border="0" cellspacing="1">
          <tr class="mbg" valign="top">
            <th width=75 valign="top" align="left"><SPAN class=small style="FONT-WEIGHT: bold"><%=storeText.getString("DistributorShopCartReview_Quantity")%></span></th>
            <th width=75 valign="top" align="left"><SPAN class=small style="FONT-WEIGHT: bold"><%=storeText.getString("DistributorShopCartReview_IBMPart")%></span></th>
            <th width=250 valign="top" align="left"><SPAN class=small style="FONT-WEIGHT: bold"><%=storeText.getString("DistributorShopCartReview_Desc")%></span></th>
            <th width=100 valign="top" align="left"><SPAN class=small style="FONT-WEIGHT: bold"><%=storeText.getString("DistributorShopCartReview_IBMPrice")%></span></th>
            <th width=100 colspan=2 valign="top" align="left"><SPAN class=small style="FONT-WEIGHT: bold"><%=storeText.getString("DistributorShopCartReview_LineTotal")%></span></th>
          </tr>          
 <%   for( int i=0; i<unassignedItems.size();i++) {
        OrderItemDataBean orderItem = (OrderItemDataBean)unassignedItems.elementAt(i);
        double requested = orderItem.getQuantityInEJBType().doubleValue();
        double remaining = Double.parseDouble(orderItem.getField2());
        double assigned = requested-remaining;

        double itemPrice = orderItem.getPriceDataBean().getAmount().doubleValue();
        
        long displayQty = (long)remaining;

        BigDecimal qty = new BigDecimal( orderItem.getField2() );
        BigDecimal price = orderItem.getPriceDataBean().getAmount();
        BigDecimal lineprice = price.multiply(qty);
        FormattedMonetaryAmountDataBean fma = new FormattedMonetaryAmountDataBean();
        fma.setAmount(lineprice);
        fma.setCurrency(cmdcontext.getCurrency());
        fma.setLangId(cmdcontext.getLanguageId());
        com.ibm.commerce.beans.DataBeanManager.activate(fma, request);
        String lineTotal = fma.toString();
        
          %>
          <form name="UnassignedItem_<%=i%>" action="OrderItemUpdate" method="POST">
          <input type="hidden" name="URL" value="<%=returnURL%>">
          <input type="hidden" name="orderItemId_1" value="<%=orderItem.getOrderItemId()%>">
          <input type="hidden" name="quantity_1" value="<%=assigned%>">
          <input type="hidden" name="storeId" value="<%=storeId%>">
          <input type="hidden" name="catalogId" value="<%=catalogId%>">
          <input type="hidden" name="allocate" value="*n">
          <input type="hidden" name="reverse" value="*n">
          <input type="hidden" name="backorder" value="*n">
          <input type="hidden" name="check" value="*n">
          <input type="hidden" name="merge" value="*n">
          <input type="hidden" name="remerge" value="*n">            
          </form>
          <tr>
            <td valign="top"><span class=small><%=String.valueOf(displayQty)%></span></td>
            <td valign="top"><a href="ProductDisplay?storeId=<%=storeId%>&langId=<%=languageId%>&productId=<%=orderItem.getCatalogEntryId()%>"><span class=small><%=orderItem.getPartNumber()%></span></a></td>
            <td valign="top"><span class=small><%=orderItem.getCatalogEntry().getDescription().getShortDescription()%></span></td>
            <td align="right" valign="top"><span class=small><%=orderItem.getPriceDataBean()%></span></td>
            <td width=85 align="right" valign="top"><span class=small><%=lineTotal%></span></td> 
            <td width=15 align="right" valign="top"><a href="javascript:RemoveUnassignedItems(document.UnassignedItem_<%=i%>)"><img src="<%=fileDir%>images/icn_trash.gif" alt="<%=storeText.getString("PartialTransferShopCartDisplay_Remove")%>" border="0" align="right"></a></td>
          </tr>
          <tr>
            <td colspan="7" class="gbg"></td>
          </tr>
 <%   } // end of second loop %>
          <tr height=15><td>&nbsp</td></tr>
        </table>
      </td>
    </tr>
<%  } /*end of conditional unassigned items code*/
    String assignURL = "OrderQuotationDisplay?orderQuotationDisplayViewName=OrderQuotationDisplayByDistributorFormView&outOrderQuotationRelIdName=orderQuotationIDs"; %>  
    <tr>
      <td>
        <table width="590" cellpadding="0" border="0" cellspacing="2">
          <tr valign="top"> 
            <td valign="top"> <!-- column one - instructional text -->
              <table width="320" cellpadding="2" border="0" cellspacing="0">
                <tr>
                  <td>*<b><%=storeText.getString("DistributorShopCartReview_Important")%>:</b> <%=storeText.getString("DistributorShopCartReview_Disclaimer")%></td>                
                </tr>
              </table>
            </td>
            <form name="openWindowForm" action="" method="POST">
            <td valign="top"> <!-- column two - buttons -->
              <table width="260" cellpadding="2" border="0" cellspacing="0">
                <tr>
                  <td valign="top"><input type="checkbox" id="newwindowtext" name="openWindow" checked></td>
                  <td valign="top"><label for="newwindowtext"><%=storeText.getString("DistributorShopCartReview_NewWindow")%></label></td>
                </tr>
                <tr>
                  <td colspan=2><img src="<%=fileDir%>images/c.gif" height="5" width=1 alt=""></td>              
                </tr>
                <% if(finalOrderBeans.length != 0 && (strSystemMessage == null || strSystemMessage.trim().length() == 0)) { %>
                <tr>
                  <td colspan=2><a onclick="submitAllCartsForm(document.ReviewDistributorForm); return false;" href="#"><img src="<%=fileDir%><%=locale.toString()%>/images/b_submit.gif" valign="middle" border="0" alt="<%=storeText.getString("Alt_SubmitAll")%>"></a></td>
                </tr>
                <% } %>
                <tr>
                  <td colspan=2><img src="<%=fileDir%>images/c.gif" height="10" width=1 alt=""></td>              
                </tr>
                <tr>
                  <td colspan=2><a href="<%=assignURL%>"><img src="<%=fileDir%>images/blue_arrow_button.gif" width="23" height="23" border="0" alt="<%=storeText.getString("DistributorShopCartReview_Reassign")%>" align="absmiddle"></a>&nbsp;<a href="<%=assignURL%>"><b><%=storeText.getString("DistributorShopCartReview_Reassign")%></b></a></td>
                </tr>
                <tr>
                  <td colspan=2><img src="<%=fileDir%>images/c.gif" height="10" width=1 alt=""></td>              
                </tr>
                <tr>
                  <td colspan=2><a href="<%=returnURL%>"><img src="<%=fileDir%>images/blue_arrow_button.gif" width="23" height="23" border="0" alt="<%=storeText.getString("DistributorShopCartReview_Refresh")%>" align="absmiddle"></a>&nbsp;<a href="<%=returnURL%>"><b><%=storeText.getString("DistributorShopCartReview_Refresh")%></b></a></td>
                </tr>
              </table>          
            </td>
            </form>
          </tr>
        </table>
      </td>
    </tr>
    <tr>
      <td><img height="10" width="1" alt="" src="<%=fileDir%>images/c.gif"></td>     
    </tr>
  </table>
<% } catch (Exception ex) {
     out.println("<!-- Exception caught (bottom) : " + ex + " -->");
   }    %>
  <!--END MAIN CONTENT-->
  </td>
</tr>
</table>
<!-- End Main Table -->
<!-- Start Footer -->
<%@ include file="../../../include/FooterDisplay.jspf"%>
<!-- End Footer -->
</body>
</html>
