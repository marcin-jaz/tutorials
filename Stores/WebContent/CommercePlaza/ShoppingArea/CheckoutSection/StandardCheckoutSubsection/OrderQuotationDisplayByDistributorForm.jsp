<%
/*
 *-------------------------------------------------------------------
 * Licensed Materials - Property of IBM
 *
 * WebSphere Commerce
 *
 * (c) Copyright International Business Machines Corporation. 2003
 *     All rights reserved.
 *
 * US Government Users Restricted Rights - Use, duplication or
 * disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
 *
 *-------------------------------------------------------------------
 */
%>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="com.ibm.commerce.beans.*" %>
<%@ page import="com.ibm.commerce.server.*" %>
<%@ page import="com.ibm.commerce.command.*" %>
<%@ page import="com.ibm.commerce.order.beans.*" %>
<%@ page import="com.ibm.commerce.order.objects.*" %>
<%@ page import="com.ibm.commerce.contract.beans.*" %>
<%@ page import="com.ibm.commerce.contract.objects.*" %>
<%@ page import="com.ibm.commerce.datatype.*" %>
<%@ page import="com.ibm.commerce.usermanagement.commands.ECUserConstants" %>
<%@ page import="com.ibm.commerce.security.commands.ECSecurityConstants" %>
<%@ page import="com.ibm.commerce.price.utils.*" %>
<%@ page import="com.ibm.commerce.common.objects.*" %>
<%@ page import="com.ibm.commerce.common.beans.*" %>
<%@ page import="com.ibm.commerce.user.beans.*" %>
<%@ page import="com.ibm.commerce.user.objects.*" %>
<%@ page import="com.ibm.commerce.order.beans.*" %>
<%@ page import="com.ibm.commerce.price.beans.PriceDataBean" %>
<%@ page import="com.ibm.commerce.price.beans.FormattedMonetaryAmountDataBean" %>
<%@ page import="com.ibm.commerce.order.objects.*" %>
<%@ page import="com.ibm.commerce.catalog.beans.*" %>
<%@ page import="com.ibm.commerce.tools.util.UIUtil" %>
<%@ page import="java.text.MessageFormat" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="com.ibm.commerce.ras.ECMessageHelper" %>
<%@ page import="com.ibm.commerce.utils.TimestampHelper" %>
<%@ include file="../../../include/EnvironmentSetup.jsp"%>
<%
  String orderRn = jhelper.getParameter("orderId");
  String timeoutStoreParam = jhelper.getParameter("outTimeoutOrderQuotationRelIdName");                    
                      
  String[] timeoutOrderRelIds = null;
  String[] timeoutStores = null;              

  if( timeoutStoreParam !=null ) {                             
    timeoutOrderRelIds = jhelper.getParameterValues(timeoutStoreParam);
  }
  if((timeoutOrderRelIds != null)&&(timeoutOrderRelIds.length>0)) {
    timeoutStores = new String[timeoutOrderRelIds.length];              
                             
    for(int i=0;i<timeoutOrderRelIds.length;i++) {
      OrderQuotationRelDataBean relBean = new OrderQuotationRelDataBean();
      relBean.setDataBeanKeyOrderQuotationRelId( timeoutOrderRelIds[i] );
      com.ibm.commerce.beans.DataBeanManager.activate(relBean, request);    
      timeoutStores[i] = relBean.getChildStoreId();
    }
  }
                             
  String userId = cmdcontext.getUser().getUserId();
  storeId = cmdcontext.getStoreId().toString(); 
  
  String outOrderQuotationRelIdName = null;
  String [] orderQuotationRelIds = null;
  String strErrorMessage = null;


  outOrderQuotationRelIdName = jhelper.getParameter("outOrderQuotationRelIdName");
    
  OrderQuotationRelDataBean orderQuotationRelDB = null;
  TypedProperty requestProperties = (TypedProperty)request.getAttribute(ECConstants.EC_REQUESTPROPERTIES) ;

  if ((orderRn == null)||(orderRn.equals("*"))||(orderRn.equals("."))) {
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
  %><h4><%=storeText.getString("OrderQuotationDisplayByDistributor_ErrorObtainQuot", outOrderQuotationRelIdName)%></h4><%     
    }
  } 
%>
<jsp:useBean id="orderBean" class="com.ibm.commerce.order.beans.OrderDataBean" scope="page">
<% 
orderBean.setOrderId(orderRn);
//orderBean.setCommandContext(cmdcontext);
com.ibm.commerce.beans.DataBeanManager.activate(orderBean, request);
%>
</jsp:useBean>

<jsp:useBean id="bnError" class="com.ibm.commerce.beans.ErrorDataBean" scope="page">
<% com.ibm.commerce.beans.DataBeanManager.activate(bnError, request); %>
</jsp:useBean>

<%
    strErrorMessage = bnError.getMessage();
%>


<%
catalogId = sdb.getStoreCatalogs()[0].getCatalogId();

Integer[] distIdList = cmdcontext.getStore().getRelatedStores("com.ibm.commerce.referral");
OrderDataBean [] childOrderBeans = orderBean.getChildOrders(distIdList, "initial");
OrderDataBean childOrderBean = null;

out.println("<!-- user Id : " + userId  + " -->");
out.println("<!-- orderId : " + orderRn + " -->");
out.println("<!-- parent shopcart name : " + orderBean.getDescription() + "-->");
out.println("<!-- # of related stores  : " + distIdList.length + "-->");
out.println("<!-- number of quotes     : " + childOrderBeans.length + "-->");
if( timeoutStores != null ) {
  out.println("<!-- timeouts : " + timeoutStores.length + " -->");
} else { 
  out.println("<!-- timeouts is null -->");
}  
out.println("<!-- requestProperties : \n" + requestProperties + " -->");
  
int distributorCounter = 0;
int distOrderItemCounter = 0;
String distributorName = null;
String url = null;
String phone1 = null;
StoreDataBean distStore;

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "DTD/xhtml1-transitional.dtd">
<html>
<head>
  <title><%=storeText.getString("OrderQuotationDisplayByDistributor_Title")%></title>
  <link rel=stylesheet href="<%=fileDir%>PCDMarket.css" type="text/css">

<script language="javascript">
  var busy=false;

  // Refresh Quote - must reselect distributors
  function refreshForm(form)
  {
    if( !busy ) {
      busy = true;
      form.URL.value = "DistributorSelectionDisplayView?orderId=<%=orderRn%>&orderItemId_*=&quantity_*=";
      form.submit();
    }
  }
  
  function checkQuantity()
  {
    counter = 0;
    sum = 0;
    while (1) {
      inputName = "quantity_" + counter;
      if (!document.PriceAvailabilityForm.elements[inputName]) {
        break;
      }
      else {
        sum = sum + document.PriceAvailabilityForm.elements[inputName].value;
      }
      counter++;
    }
    if (sum==0){
      return false;
    }
    else{
      return true;
    }
  }


  <% /* Prepare URL String for submitForm function */
  String tempURLString = "OrderQuotationRequest?URL=OrderQuotationWaitDisplayView&quotationType=final&orderId="+orderRn+"&deleteOrderQuotationRelId=*final*parent.";
  tempURLString += "&orderItemId_*=&quantity_*=";

  String quotationParams = new String();
  OrderPaymentInfoAccessBean credentials = new OrderPaymentInfoAccessBean();
  Enumeration searchResults = credentials.findByOrder(new Long(orderRn));
  while( searchResults.hasMoreElements() ) {
    OrderPaymentInfoAccessBean info = (OrderPaymentInfoAccessBean)searchResults.nextElement();
    String name = info.getPaymentPairName();
    String value = info.getPaymentPairValue();
    quotationParams += ("&" + name + "=" + value);   
  }                                                             
  tempURLString += quotationParams;
  out.println("<!-- quotationParams : " + quotationParams + "-->");  
  out.println("<!-- Form URL string : " + tempURLString + "-->");
  %>
  // Prepare Shopcart
  function submitForm(form)
  {
    if( !busy ) {
      busy = true;
      form.URL.value = "<%=tempURLString%>";
      if (checkQuantity() == true)
      {
          form.submit();
      }
      else
      {
          alert("<%= UIUtil.toJavaScript((String) storeText.getString("OrderQuotationDisplayByDistributor_ErrorNoAssignedQuantities")) %>");
          busy = false;
      }    
    }
  }
  // Update Shopcart
  <% String updateURLString = "OrderQuotationDisplay?orderQuotationDisplayViewName=OrderQuotationDisplayByDistributorFormView&orderId=" + orderRn;
    updateURLString += "&orderItemId_*=&quantity_*="; %>
  <!-- updateURLString : <%=updateURLString%> -->
  function updateForm(form)
  {
    if( !busy ) {
      busy = true;
      form.URL.value = "<%=updateURLString%>";
      form.submit();                                                
    }
  }
  //View by Item
  <% String viewbyitemURLString = "OrderQuotationDisplay?orderQuotationDisplayViewName=OrderQuotationDisplayByItemFormView&outOrderQuotationRelIdName=orderQuotationIDs&orderId=" + orderRn;
  if( timeoutStoreParam != null ) {
    viewbyitemURLString += ("&outTimeoutOrderQuotationRelIdName=" + timeoutStoreParam);
    
    if( (timeoutOrderRelIds!= null)&&(timeoutOrderRelIds.length>0)) {
      for(int i=0;i<timeoutOrderRelIds.length;i++) {
        viewbyitemURLString += ("&" + timeoutStoreParam + "=" + timeoutOrderRelIds[i]);
      }
    }
  }
  viewbyitemURLString += "&orderItemId_*=&quantity_*=";  %>
  function viewByItem(form)
  {
    if( !busy ) {
      busy = true;
      form.action    = "OrderItemSelect";
      form.URL.value = "<%=viewbyitemURLString%>";
      form.submit();
    }
  }

  //Save Cart  
  <% String saveURLString = "ShopCartSaveFormView?orderId="+orderRn+"&URL=OrderQuotationDisplayByDistributorFormView";
    saveURLString += "&orderItemId_*=&quantity_*="; %>
  function saveForm(form)
  {
    if( !busy ) {
      busy = true;
      form.URL.value = "<%=saveURLString%>";
      form.submit();
    }
  }
</script>
</head>
<body marginheight="0" marginwidth="0" leftmargin="0" topmargin="0">
<!-- Start Header -->
<%@ include file="../../../include/HeaderDisplay.jspf"%>
<!-- End Header -->

<!-- Start Main Table - Consists of TD for Left Bar, TD for Content and TD for Quicklinks -->
<table border="0" cellpadding="0" cellspacing="0" width="750">
<tr>
  <td valign="top" class="mbg" width="150"> 
    <%
    String incfile = includeDir + "SidebarDisplay.jsp";
    %>
    <jsp:include page="<%=incfile%>" flush="true"/></td>
    
  <td width="10"><a name="mainContent"></a><img src="<%=fileDir%>images/c.gif" height="1" /></td>

  <td valign="top" width="590"> <!-- if using a sidebar, use 450.  If no sidebar, use 590 -->
    <!--START MAIN CONTENT-->
    <form name="PriceAvailabilityForm" action="OrderItemSelect" method="POST">
    <input type="hidden" name="orderId" value="<%=orderRn%>">
    <input type="hidden" name="URL" value="OrderQuotationWaitDisplayView">
    <input type="hidden" name="outOrderQuotationRelIdName" value="orderQuotationIDs">
    <input type="hidden" name="orderQuotationRelId" value="*final*parent<%= orderRn %>">
    <input type="hidden" name="outSelectionOrderQuotationRelIdName" value="orderQuotationIDs">
    <input type="hidden" name="errorViewName" value="OrderQuotationDisplayByDistributorFormView">

     <table width="590" cellpadding="2" border="0" cellspacing="1">
      <tr>
        <td>   
          <table width="100%" cellspacing="0" cellpadding="0" border="0">
      		<tbody>
            <tr>
        	<td colspan="2" height="20"><span class="bct">&nbsp;&nbsp;&nbsp;</span>
        	<a class="bctl" href="StoreCatalogDisplay?storeId=<%=storeId%>&catalogId=<%=catalogId%>&langId=<%=languageId%>"><%=storeText.getString("Breadcrumb_CommercePlaza")%></a><span class="bct">&nbsp;&nbsp;&nbsp;&gt;&nbsp;&nbsp;&nbsp;</span>
        	<span class="bct"><%=storeText.getString("Breadcrumb_RequestPriceAvail")%></span>
              </td>
            </tr>
            <tr>
              <td valign="top" width="53%">
                <div align="left" class="title">
                  <img src="<%=fileDir%>images/c.gif" width="1" height="11" border="0" /><br />
                  <%=storeText.getString("OrderQuotationDisplayByDistributor_AssignQuantities")%>
                </div>              
                <div><span class="subtitle"><%=storeText.getString("OrderQuotationDisplayByDistributor_Step")%></span></div>
              </td>
              <td valign="top" width="47%">
                <div align="right"><img src="<%=fileDir%>images/hdr_cart.gif" height="72" alt="<%=storeText.getString("OrderQuotationDisplayByDistributor_AssignQuantities")%>"></div>
              </td>
            </tr>
            </tbody>
          </table>       
        </td>
      </tr>
      <tr>
        <td><b><%=storeText.getString("OrderQuotationDisplayByDistributor_Response")%>&nbsp;<%=TimestampHelper.getDateFromTimestamp(orderBean.getLastUpdateInEJBType(),locale)%> <%=orderBean.getLastUpdateInEJBType().toString().substring(11,16)%></b></td>
      </tr>
      <tr>
        <td><%=storeText.getString("OrderQuotationDisplayByDistributor_Instruction")%></td>
      </tr>
      
    <!-- Show error message if it isn't null-->
    <%
    if((strErrorMessage != null)&&(strErrorMessage.trim().length()>0))
    {
        %>
        <tr><td><font class="error"><%=strErrorMessage%></font></td></tr>
        <%
    }
    %>

      
      <tr>
        <td>
          <table width="590" cellpadding="0" cellspacing="0" border="0">
            <td align="right"><b><%=storeText.getString("OrderQuotationDisplayByDistributor_SortBy")%>&nbsp;<a href="javascript:viewByItem(document.PriceAvailabilityForm)"><%=storeText.getString("OrderQuotationDisplayByDistributor_SortByItem")%></a> | <%=storeText.getString("OrderQuotationDisplayByDistributor_SortByDist")%></b></td>
          </table>
        </td>
      </tr>
      <%
      StoreDataBean quoteStore;
      String quoteStoreId;
      
      int selectOICount = 0;
      int respondedOrderCount = childOrderBeans.length; // initially set to the number of child orders
      for (int x=0;x<childOrderBeans.length;x++) { 
        OrderDataBean quoteBean = childOrderBeans[x];
        OrderDataBean selectionBean;
        quoteStoreId = quoteBean.getStoreEntityId();
        
        quoteStore = new StoreDataBean();
        quoteStore.setStoreId( quoteStoreId );
        com.ibm.commerce.beans.DataBeanManager.activate(quoteStore, request);
          
        OrderItemDataBean[] quoteOrderItems = quoteBean.getOrderItemDataBeans();

        String selectSubtotalString;        
        try { //will not be any selection items on first quotation
          selectionBean = quoteBean.getSiblingSelectionOrders()[0];
          selectSubtotalString = selectionBean.getSubTotal().toString();
        } catch(Exception e) {
          FormattedMonetaryAmountDataBean selectSubtotal = new FormattedMonetaryAmountDataBean();
          com.ibm.commerce.beans.DataBeanManager.activate(selectSubtotal, request);
          selectSubtotalString = selectSubtotal.toString();
        }

        String distName=null;
        String distURL=null;
        String distPhone=null;

        // First, get the StoreEntityDataBean
        StoreEntityDataBean storeEntity = new StoreEntityDataBean();
        storeEntity.setDataBeanKeyStoreEntityId( quoteBean.getStoreEntityId() );
        com.ibm.commerce.beans.DataBeanManager.activate(storeEntity, request);
        
        try { 
        
          // Get the appropriate description of the store entity - for the store display name       
          Integer iLangId = Integer.valueOf(languageId);  
          StoreEntityDescriptionAccessBean storeDesc = storeEntity.getDescription(iLangId);        
          distName = storeDesc.getDisplayName();
 
          // Next, get the store location address - for the phone number
          String distLocId = storeDesc.getLocationAddressId();        
          StoreAddressDataBean storeAddr = new StoreAddressDataBean();
          storeAddr.setDataBeanKeyStoreAddressId(distLocId);
          com.ibm.commerce.beans.DataBeanManager.activate(storeAddr, request);         
          distPhone = storeAddr.getPhone1();
          distURL = storeAddr.getURL();        
        } catch(Exception e) {
          out.println("<!-- Exception caught (1) : " + e + " -->");
          if( distName==null )
            distName = quoteStore.getIdentifier();
          if( distPhone==null )
            distPhone = "&nbsp;";
        }
      if (quoteBean.getStatus().equals("H")) {
        respondedOrderCount = respondedOrderCount - 1;
      %>
      <tr><td><font class="error">
        <%=storeText.getString("ErrorStatus_Text5" , distName, distPhone)%>
      </font></td></tr>
      <tr><td><img height="5" width="1" alt="" src="<%=fileDir%>images/c.gif" /></td></tr>
      <%
      }        
      %>
      <tr valign="top">
        <td>
          <table cellpadding="0" cellspacing="0" border="0" width="590">
            <tr>
              <td>
                <table cellpadding="0" cellspacing="0" border="0" width="590">
                  <tr  class="tdblue">
                    <% if ((distURL!=null)&&(distURL.length()>0)) { %>
                    <th id="th_dist<%=x%>" width="300" align="left" class="tdblue">&nbsp;<a href="ExitToDistributorSiteDisplayView?storeId=<%=storeId%>&langId=<%=languageId%>&forwardURL=<%=java.net.URLEncoder.encode(distURL)%>" target="_blank"><span class=small style="FONT-WEIGHT: bold; COLOR: #ffffff; text-decoration: underline"><%=distName%></span></a></th>
                    <% } else { %>
                    <th id="th_dist<%=x%>" width="300" align="left" class="tdblue">&nbsp;<b><%=distName%></b></th>
                    <% } %>
                    <td width="300" align="right" class="tdblue"><span class=small style="FONT-WEIGHT: bold; COLOR: #ffffff"><%=distPhone%></span></td>
                  </tr>
                </table>
              </td>
            </tr>
            <tr>
              <td>
                <table width="590" cellpadding="0" border="0" cellspacing="1">
                  <tr class="mbg" valign="top">
                          <th id="th1_<%=x%>" class="mbg"><font class="small"><b><%=storeText.getString("OrderQuotationDisplayByDistributor_ColumnDistSKU")%></b></font></th>
                          <th id="th2_<%=x%>" class="mbg"><font class="small"><b><%=storeText.getString("OrderQuotationDisplayByDistributor_ColumnPartNum")%></b></font></th>
                          <th id="th3_<%=x%>" class="mbg"><font class="small"><b><%=storeText.getString("OrderQuotationDisplayByDistributor_ColumnDesc")%></b></font></th>
                          <th id="th4_<%=x%>" class="mbg"><font class="small"><b><%=storeText.getString("OrderQuotationDisplayByDistributor_ColumnListPrice")%></b></font></th>
                          <th id="th5_<%=x%>" class="mbg"><font class="small"><b><%=storeText.getString("OrderQuotationDisplayByDistributor_ColumnDistPrice")%></b></font></th>
                          <th id="th6_<%=x%>" class="mbg"><font class="small"><b><%=storeText.getString("OrderQuotationDisplayByDistributor_ColumnQtyReq")%></b></font></th>
                          <th id="th7_<%=x%>" class="mbg"><font class="small"><b><%=storeText.getString("OrderQuotationDisplayByDistributor_ColumnQtyInv")%></b></font></th>
                          <th id="th8_<%=x%>" class="mbg"><font class="small"><b><%=storeText.getString("OrderQuotationDisplayByDistributor_ColumnQtyAss")%></b></font></th>
                          <th id="th9_<%=x%>" colspan="2" align="right" class="mbg"><font class="small"><b><%=storeText.getString("OrderQuotationDisplayByDistributor_ColumnLineTotal")%></b></font></th>
                  </tr>
                  <%
                  for (int y=0; y<quoteOrderItems.length; y++) {
                    OrderItemDataBean orderItemBean = quoteOrderItems[y];
                    CatalogEntryDataBean catEntryBean = orderItemBean.getCatalogEntryDataBean();
                    OrderItemDataBean parentOIBean = orderItemBean.getParentItems()[0];
                    String selectionItemTotalString;
                    try { //will not be any selection items on first quotation
                      OrderItemDataBean selectionOIBean = orderItemBean.getSiblingSelectionItems()[0];
                      selectionOIBean.setCommandContext(cmdcontext);  
                      selectionItemTotalString = selectionOIBean.getPerItemTotalPrice().toString();
                    } catch(Exception e) {
                      FormattedMonetaryAmountDataBean selectionItemTotal = new FormattedMonetaryAmountDataBean();
                      com.ibm.commerce.beans.DataBeanManager.activate(selectionItemTotal, request);
                      selectionItemTotalString = selectionItemTotal.toString();
                    }
                    
                    parentOIBean.setCommandContext(cmdcontext);
                  %>
                  <input type="hidden" name="orderItemId_<%=selectOICount%>" value="<%=orderItemBean.getOrderItemId()%>">
                  <% if ((orderItemBean.getLineItemType()!=null)&&(orderItemBean.getLineItemType().equals("ALT"))) { %>
                  <tr>
                    <td colspan="9"><b><%=storeText.getString("OrderQuotationDisplayByDistributor_Alternative")%> : <%=catEntryBean.getDescription().getShortDescription()%></b></td>
                  </tr>
                  <tr valign="top">
                    <td headers="th_dist<%=x%> th1_<%=x%>"><font class="small"><%=orderItemBean.getSupplierPartNumber().trim()%></font></td>
                    <td headers="th_dist<%=x%> th2_<%=x%>"><font class="small">&nbsp;</font></td>
                    <td headers="th_dist<%=x%> th3_<%=x%>"><font class="small"><%=catEntryBean.getDescription().getShortDescription()%></font></td>
                    <td headers="th_dist<%=x%> th4_<%=x%>"><font class="small">&nbsp;</font></td>
                    <td headers="th_dist<%=x%> th5_<%=x%>"><font class="small"><%=orderItemBean.getPriceDataBean()%></font></td>
                    <td headers="th_dist<%=x%> th6_<%=x%>"><font class="small"><%=parentOIBean.getFormattedQuantity()%></font></td>
                    <td headers="th_dist<%=x%> th7_<%=x%>"><font class="small"><%=orderItemBean.getAvailableQuantity()%></font></td>
                    <td headers="th_dist<%=x%> th8_<%=x%>">
                    <label for="th_dist<%=x%> th8_<%=x%>"><img src="<%=fileDir%>images/trans.gif" height="1" width="1" border="0" alt="<%=storeText.getString("OrderQuotationDisplayByDistributor_ColumnQtyAss")%>"/></label>
                    <input type="text" size="3" id="th_dist<%=x%> th8_<%=x%>" name="quantity_<%=selectOICount%>" class="iform" value="<%=orderItemBean.getSelectionQuantity().longValue()%>"></td>
                    <td headers="th_dist<%=x%> th9_<%=x%>"><font class="small"><%=selectionItemTotalString %></font></td>
                  </tr>
                  <% } else { %>
                  <tr valign="top">
                    <td headers="th_dist<%=x%> th1_<%=x%>"><font class="small"><%=orderItemBean.getSupplierPartNumber().trim()%></font></td>
                    <td headers="th_dist<%=x%> th2_<%=x%>"><font class="small"><a href="ProductDisplay?storeId=<%=storeId%>&langId=<%=languageId%>&productId=<%=orderItemBean.getCatalogEntryId()%>"><%=parentOIBean.getCatalogEntryDataBean().getPartNumber()%></a></font></td>
                    <td headers="th_dist<%=x%> th3_<%=x%>"><font class="small"><%=catEntryBean.getDescription().getShortDescription()%></font></td>
                    <td headers="th_dist<%=x%> th4_<%=x%>"><font class="small"><%=parentOIBean.getPriceDataBean()%></font></td>
                    <td headers="th_dist<%=x%> th5_<%=x%>"><font class="small"><%=orderItemBean.getPriceDataBean()%></font></td>
                    <td headers="th_dist<%=x%> th6_<%=x%>"><font class="small"><%=parentOIBean.getFormattedQuantity()%></font></td>
                    <td headers="th_dist<%=x%> th7_<%=x%>"><font class="small"><%=orderItemBean.getAvailableQuantity()%></font></td>
                    <td headers="th_dist<%=x%> th8_<%=x%>">
                    <label for="th_dist<%=x%> th8_<%=x%>"><img src="<%=fileDir%>images/trans.gif" height="1" width="1" border="0" alt="<%=storeText.getString("OrderQuotationDisplayByDistributor_ColumnQtyAss")%>"/></label>
                    <input type="text" size="3" id="th_dist<%=x%> th8_<%=x%>" name="quantity_<%=selectOICount%>" class="iform" value="<%=orderItemBean.getSelectionQuantity().longValue()%>"></td>
                    <td headers="th_dist<%=x%> th9_<%=x%>"><font class="small"><%=selectionItemTotalString %></font></td>
                  </tr>
                  <% } 
                  selectOICount++;
                  } //end item loop
                  %>                 
                  <tr>
                    <td width="590" colspan="9" class="bbg"><img src="<%=fileDir%>images/c.gif" width="1" height="2" border="0" alt=""></td>
                  </tr>
                  <tr>
                    <td colspan="8" align="right"><b><%=storeText.getString("OrderQuotationDisplayByDistributor_SubTotal")%> :</b></td>
                    <td align="right"><%=selectSubtotalString%></td>
                  </tr>
                </table>
              </td>
            </tr>
          <% if (x<childOrderBeans.length-1) { %>
            <tr>
              <td><img class="imgHeightFix" src="<%=fileDir%>images/c.gif" width="1" height="10" border="0" alt=""></td>
            </tr>
          <%}%>
          </table>
        </td>
      </tr>     
      <% } /* end childOrderBeans loop */ 

      //loop for timeout stores
      if( (timeoutStores!=null)&&(timeoutStores.length>0)) {
        for(int i=0;i<timeoutStores.length;i++) {
          String timeoutStoreId = timeoutStores[i];

          String distName=null;
          String distURL=null;
          String distPhone=null;
  
          // First, get the StoreEntityDataBean
          StoreEntityDataBean storeEntity = new StoreEntityDataBean();
          storeEntity.setDataBeanKeyStoreEntityId( timeoutStoreId );
          com.ibm.commerce.beans.DataBeanManager.activate(storeEntity, request);

          try { 
          
            // Get the appropriate description of the store entity - for the store display name       
            Integer iLangId = Integer.valueOf(languageId);  
            StoreEntityDescriptionAccessBean storeDesc = storeEntity.getDescription(iLangId);        
            distName = storeDesc.getDisplayName();
   
            // Next, get the store location address - for the phone number
            String distLocId = storeDesc.getLocationAddressId();        
            StoreAddressDataBean storeAddr = new StoreAddressDataBean();
            storeAddr.setDataBeanKeyStoreAddressId(distLocId);
            com.ibm.commerce.beans.DataBeanManager.activate(storeAddr, request);         
            distPhone = storeAddr.getPhone1();            
            distURL = storeAddr.getURL();
          
          } catch(Exception e) {
            out.println("<!-- Exception caught (1) : " + e + " -->");
            if( distName==null ) {
              StoreDataBean timeoutStoreBean = new StoreDataBean(); 
              timeoutStoreBean.setStoreId( timeoutStoreId );
              com.ibm.commerce.beans.DataBeanManager.activate(timeoutStoreBean, request);            
              distName = timeoutStoreBean.getIdentifier();
            }
            if( distPhone==null )
              distPhone = "";
          }
        %>
        <% if (childOrderBeans.length>0) {%>
        <tr>
          <td><img class="imgHeightFix" src="<%=fileDir%>images/c.gif" width="1" height="10" border="0" alt=""></td>
        </tr>
        <%}%>        
        
        <tr valign="top">
          <td>
            <table cellpadding="0" cellspacing="0" border="0" width="590">
              <tr>
                <td>
                  <table cellpadding="0" cellspacing="0" border="0" width="590">
                    <tr  class=tdblue>
                      <% if ((distURL!=null)&&(distURL.length()>0)) { %>
                      <td width="300" align="left">&nbsp;<a href="ExitToDistributorSiteDisplayView?storeId=<%=storeId%>&langId=<%=languageId%>&forwardURL=<%=java.net.URLEncoder.encode(distURL)%>" target="_blank"><SPAN class=small style="FONT-WEIGHT: bold; COLOR: #ffffff; text-decoration: underline"><%=distName%></SPAN></a></td>
                      <% } else { %>
                      <td width="300" align="left">&nbsp;<b><%=distName%></b></td>
                      <% } %>
                      <td width="300" align="right"><SPAN class=small style="FONT-WEIGHT: bold; COLOR: #ffffff"><%=distPhone%></span></td>
                    </tr>
                  </table>
                </td>
              </tr>
              <tr>
                <td>
                  <table width="590" cellpadding="0" border="0" cellspacing="1">
                    <tr class="mbg" valign="top">
                      <td>
                        <table cellSpacing="1" cellPadding="0" border="0">
                          <tr valign="top">
                            <td><img class="imgHeightFix" src="<%=fileDir%>images/c.gif" width="2" height="1" border="0" /></td>
                            <td><font class="small"><b><%=storeText.getString("OrderQuotationDisplayByDistributor_ColumnDistSKU")%></b></font></td>
                          </tr>
                        </table>
                      </td>
                      <td>
                        <table cellSpacing="1" cellPadding="0" border="0">
                          <tr valign="top">
                            <td><img class="imgHeightFix" src="<%=fileDir%>images/c.gif" width="2" height="1" border="0" /></td>
                            <td><font class="small"><b><%=storeText.getString("OrderQuotationDisplayByDistributor_ColumnPartNum")%></b></font></td>
                          </tr>
                        </table>
                      </td>
                      <td>
                        <table cellSpacing="1" cellPadding="0" border="0">
                          <tr valign="top">
                            <td><img class="imgHeightFix" src="<%=fileDir%>images/c.gif" width="2" height="1" border="0" /></td>
                            <td><font class="small"><b><%=storeText.getString("OrderQuotationDisplayByDistributor_ColumnDesc")%></b></font></td>
                          </tr>
                        </table>
                      </td>
                      <td>
                        <table cellSpacing="1" cellPadding="0" border="0">
                          <tr valign="top">
                            <td><img class="imgHeightFix" src="<%=fileDir%>images/c.gif" width="2" height="1" border="0" /></td>
                            <td><font class="small"><b><%=storeText.getString("OrderQuotationDisplayByDistributor_ColumnListPrice")%></b></font></td>
                          </tr>
                        </table>
                      </td>
                      <td>
                        <table cellSpacing="1" cellPadding="0" border="0">
                          <tr valign="top">
                            <td><img class="imgHeightFix" src="<%=fileDir%>images/c.gif" width="2" height="1" border="0" /></td>
                            <td><font class="small"><b><%=storeText.getString("OrderQuotationDisplayByDistributor_ColumnDistPrice")%></b></font></td>
                          </tr>
                        </table>
                      </td>
                      <td>
                        <table cellSpacing="1" cellPadding="0" border="0">
                          <tr valign="top">
                            <td><img class="imgHeightFix" src="<%=fileDir%>images/c.gif" width="2" height="1" border="0" /></td>
                            <td><font class="small"><b><%=storeText.getString("OrderQuotationDisplayByDistributor_ColumnQtyReq")%></b></font></td>
                          </tr>
                        </table>
                      </td>
                      <td>
                        <table cellSpacing="1" cellPadding="0" border="0">
                          <tr valign="top">
                            <td><img class="imgHeightFix" src="<%=fileDir%>images/c.gif" width="2" height="1" border="0" /></td>
                            <td><font class="small"><b><%=storeText.getString("OrderQuotationDisplayByDistributor_ColumnQtyInv")%></b></font></td>
                          </tr>
                        </table>
                      </td>
                      <td>
                        <table cellSpacing="1" cellPadding="0" border="0">
                          <tr valign="top">
                            <td><img class="imgHeightFix" src="<%=fileDir%>images/c.gif" width="2" height="1" border="0" /></td>
                            <td><font class="small"><b><%=storeText.getString("OrderQuotationDisplayByDistributor_ColumnQtyAss")%></b></font></td>
                          </tr>
                        </table>
                      </td>                                                                                
                      <td>
                        <table cellSpacing="1" cellPadding="0" border="0">
                          <tr valign="top">
                            <td colspan="2" align="right"><font class="small"><b><%=storeText.getString("OrderQuotationDisplayByDistributor_ColumnLineTotal")%></b></font></td>
                          </tr>
                        </table>
                      </td>
                    </tr>
                    <tr>
                      <td colspan="9"><font color="red"><%=distName%> <%=storeText.getString("OrderQuotationDisplayByDistributor_Timeout")%></font></td>              
                    </tr>
                  </table>
                </td>
              </tr>
              <tr>
                <td width="100%" class="bbg"><img class="imgHeightFix" src="<%=fileDir%>images/c.gif" width="1" height="2" border="0" alt=""></td>
              </tr>
              <tr>
                <td><img class="imgHeightFix" src="<%=fileDir%>images/c.gif" width="1" height="10" border="0" alt=""></td>
              </tr>
            </table>
          </td>
        </tr> 
        
<%      } //end timeout for loop
      } // end if

      if (childOrderBeans.length==0) { %>
      <tr>
        <td align="center"><b><%=storeText.getString("OrderQuotationDisplayByDistributor_Error")%></b></td>
      </tr>
      <%  } %>
      <tr>
        <td align="right"><img src="<%=fileDir%>images/ar_blue.gif"><a href="javascript:updateForm(document.PriceAvailabilityForm)"><%=storeText.getString("OrderQuotationDisplayByDistributor_Update")%></a></td>
      </tr>
      <tr>
        <td><img src="<%=fileDir%>images/c.gif" width="1" height="15" border="0" /></td>
      </tr>
    </table>
	</form>
    <table cellpadding="1" cellspacing="1" border="0" width="590">
      <tr valign="top">
        <td width="384">
          <table cellpadding="0" cellspacing="0" border="0" width="384">
            <tr>
              <td>
                <span style="FONT-WEIGHT: bold"><label for="contshop"><%=storeText.getString("ContinueShopping_Title")%></label></span>
              </td>
            </tr>
            <tr>
              <td>
                <form name="NavigationForm" method="POST" action="">
                <select name="Destination" id="contshop" size="1" class="iform" onchange="top.location.href = this.options[this.selectedIndex].value;"> 
                <span class="small">
                <option value="" selected><%=storeText.getString("ContinueShopping_Default")%></option>
       <% CatalogDataBean catalog = new CatalogDataBean();
          catalog.setCatalogId(catalogId);
          DataBeanManager.activate(catalog, request);        
          CategoryDataBean topCategories[] = catalog.getTopCategories();
          CategoryDataBean tcategory;
          String tcategoryId;

          for (int i = 0; i < topCategories.length; ++i)
          {
            tcategory = topCategories[i];
            tcategoryId = tcategory.getCategoryId(); %>                
                <option value="CategoryDisplay?catalogId=<%=catalogId%>&storeId=<%=storeId%>&categoryId=<%=tcategoryId%>&langId=<%=languageId%>"><%=tcategory.getDescription().getName()%></option>
          <% } %>
                </span>
                </select>
                </form>
              </td>      
            </tr>
            <tr>
              <td>* <%=storeText.getString("OrderQuotationDisplayByDistributor_Disclaimer")%></td>
            </tr>
          </table>
        </td>
        <td width="206">
          <table cellpadding="0" cellspacing="0" border="0" width="206">
            <%
            if (respondedOrderCount > 0) {
            %>
            <tr>
              <td><a href="javascript:submitForm( document.PriceAvailabilityForm )"><img src="<%=fileDir%><%=locale.toString()%>/images/b_request_carts.gif" border="0" alt="<%=storeText.getString("Alt_RequestCarts")%>"></a></td>
            </tr>
            <%
            }
            %>
            <tr>
              <td><img src="<%=fileDir%>images/c.gif" width="1" height="15" border="0" /></td>
            </tr>            
            <tr>
              <td>
                <table cellpadding="0" cellspacing="0" border="0">
                  <tr>
                    <td align="left"><a href="javascript:refreshForm(document.PriceAvailabilityForm)"><img src="<%=fileDir%>images/arrow_rd.gif" width="23" height="23" border="0" alt="<%=storeText.getString("OrderQuotationDisplayByDistributor_Refresh")%>"></a></td>
                    <td>&nbsp;<a href="javascript:refreshForm(document.PriceAvailabilityForm)"><%=storeText.getString("OrderQuotationDisplayByDistributor_Refresh")%></a></td>
                  </tr>
                </table>
              </td>            
            </tr>
          <%String currDescription = orderBean.getDescription();
          if ( (currDescription==null)||(currDescription.length()==0)) { %>      
            <tr>
              <td><img src="<%=fileDir%>images/c.gif" width="1" height="15" border="0" /></td>
            </tr>            
            <tr>
              <td>
                <table cellpadding="0" cellspacing="0" border="0">
                  <tr>
                    <td><a href="javascript:saveForm(document.PriceAvailabilityForm)"><img src="<%=fileDir%>images/arrow_rd.gif" width="23" height="23" border="0" alt="<%=storeText.getString("OrderQuotationDisplayByDistributor_Save")%>"></a></td>
                    <td align="left">&nbsp;<a href="javascript:saveForm(document.PriceAvailabilityForm)"><%=storeText.getString("OrderQuotationDisplayByDistributor_Save")%></a></td>
                  </tr>
                </table>
              </td>
            </tr>
          <% } %>            
          </table>
        </td>
      </tr>
    </table>
  <!--END MAIN CONTENT-->
  </td>
</tr></table>
<%@ include file="../../../include/FooterDisplay.jspf"%>
</body>
</html>
