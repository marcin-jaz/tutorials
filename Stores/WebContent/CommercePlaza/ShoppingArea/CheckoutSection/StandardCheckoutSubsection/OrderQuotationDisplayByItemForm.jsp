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
<%@ page import="java.util.Vector" %>
<%@ page import="com.ibm.commerce.beans.*" %>
<%@ page import="com.ibm.commerce.server.*" %>
<%@ page import="com.ibm.commerce.command.*" %>
<%@ page import="com.ibm.commerce.order.beans.*" %>
<%@ page import="com.ibm.commerce.order.objects.*" %>
<%@ page import="com.ibm.commerce.contract.beans.*" %>
<%@ page import="com.ibm.commerce.contract.objects.*" %>
<%@ page import="com.ibm.commerce.catalog.objects.*" %>
<%@ page import="com.ibm.commerce.datatype.*" %>
<%@ page import="com.ibm.commerce.usermanagement.commands.ECUserConstants" %>
<%@ page import="com.ibm.commerce.security.commands.ECSecurityConstants" %>
<%@ page import="com.ibm.commerce.price.utils.*" %>
<%@ page import="com.ibm.commerce.common.objects.*" %>
<%@ page import="com.ibm.commerce.common.beans.*" %>
<%@ page import="com.ibm.commerce.user.beans.*" %>
<%@ page import="com.ibm.commerce.user.objects.*" %>
<%@ page import="com.ibm.commerce.order.beans.*" %>
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

  if( timeoutStoreParam != null ) {
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
  %><h4><%=storeText.getString("OrderQuotationDisplayByItem_ErrorObtainQuot", outOrderQuotationRelIdName)%></h4><%     
    }
  } 
%>

<jsp:useBean id="bnError" class="com.ibm.commerce.beans.ErrorDataBean" scope="page">
<% com.ibm.commerce.beans.DataBeanManager.activate(bnError, request); %>
</jsp:useBean>

<%
    strErrorMessage = bnError.getMessage();
%>

<jsp:useBean id="orderBean" class="com.ibm.commerce.order.beans.OrderDataBean" scope="page">
<%  orderBean.setOrderId(orderRn);
    com.ibm.commerce.beans.DataBeanManager.activate(orderBean, request);  %>
</jsp:useBean>
<%
catalogId = sdb.getStoreCatalogs()[0].getCatalogId();

Integer[] distIdList = cmdcontext.getStore().getRelatedStores("com.ibm.commerce.referral");
OrderDataBean [] childOrderBeans = orderBean.getChildOrders(distIdList, "initial");
OrderDataBean [] selectOrderBeans = orderBean.getChildOrders(distIdList, "selection");
OrderDataBean childOrderBean = null;

out.println("<!-- user Id : " + userId  + " -->");
out.println("<!-- orderId : " + orderRn + " -->");
out.println("<!-- parent shopcart name : " + orderBean.getDescription() + "-->");
out.println("<!-- # of related stores  : " + distIdList.length + "-->");
out.println("<!-- number of quotes     : " + childOrderBeans.length + "-->");
out.println("<!-- number of selections : " + selectOrderBeans.length + "-->");
out.println("<!-- requestProperties : \n" + requestProperties + " -->");


int distributorCounter = 0;
int distOrderItemCounter = 0;
String distributorName = null;
String url = null;
String phone1 = null;
double subtotal = 0;
StoreDataBean distStore;

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "DTD/xhtml1-transitional.dtd">
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
  String quotationParams = new String();
  OrderPaymentInfoAccessBean credentials = new OrderPaymentInfoAccessBean();
  Enumeration searchResults = credentials.findByOrder(new Long(orderRn));
  while( searchResults.hasMoreElements() ) {
    OrderPaymentInfoAccessBean info = (OrderPaymentInfoAccessBean)searchResults.nextElement();
    String name = info.getPaymentPairName();
    String value = info.getPaymentPairValue();
    quotationParams += ("&" + name + "=" + value);   
  }                                                             

  tempURLString += "&orderItemId_*=&quantity_*=";  
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
          alert("<%= UIUtil.toJavaScript((String) storeText.getString("OrderQuotationDisplayByItem_ErrorNoAssignedQuantities"))%>");
          busy = false;
      }    
    }
  }

  // Update Shopcart
  <% String updateURLString = "OrderQuotationDisplay?orderQuotationDisplayViewName=OrderQuotationDisplayByItemFormView&orderId=" + orderRn;
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

  <% String viewbydistURLString = "OrderQuotationDisplay?orderQuotationDisplayViewName=OrderQuotationDisplayByDistributorFormView&outOrderQuotationRelIdName=orderQuotationIDs&orderId=" + orderRn;
  if( timeoutStoreParam != null ) {
    viewbydistURLString += ("&outTimeoutOrderQuotationRelIdName=" + timeoutStoreParam);
    
    if( (timeoutOrderRelIds!= null)&&(timeoutOrderRelIds.length>0)) {
      for(int i=0;i<timeoutOrderRelIds.length;i++) {
        viewbydistURLString += ("&" + timeoutStoreParam + "=" + timeoutOrderRelIds[i]);
      }
    }
  }
  viewbydistURLString += "&orderItemId_*=&quantity_*="; %>
  function viewByDist(form)
  {
    if( !busy ) {
      busy = true;
      form.action    = "OrderItemSelect";
      form.URL.value = "<%=viewbydistURLString%>";    
      form.submit();
    }
  }
  <% String saveURLString = "ShopCartSaveFormView?orderId="+orderRn+"&URL=OrderQuotationDisplayByItemFormView";
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
    <% String incfile = includeDir + "SidebarDisplay.jsp"; %>
    <jsp:include page="<%=incfile%>" flush="true"/></td>
  <!-- End  Left Nav Bar TD -->
  <td><a name="mainContent"></a><img src="<%=fileDir%>images/c.gif" width="10" height="2" border="0" /></td>
  <!-- Begin Main Content TD -->
  <td valign="top" width="590">
  <!--START MAIN CONTENT-->
    <form name="PriceAvailabilityForm" action="OrderItemSelect" method="POST">
    <input type="hidden" name="orderId" value="<%=orderRn%>">
    <input type="hidden" name="URL" value="OrderQuotationWaitDisplayView">
    <input type="hidden" name="outOrderQuotationRelIdName" value="orderQuotationIDs">
    <input type="hidden" name="orderQuotationRelId" value="*final*parent<%= orderRn %>">
    <input type="hidden" name="outSelectionOrderQuotationRelIdName" value="orderQuotationIDs">
    <input type="hidden" name="errorViewName" value="OrderQuotationDisplayByItemFormView">

    <table width="590" border="0" cellspacing="0" cellpadding="0">
      <tr>
  	<td colspan="2" height="20"><span class="bct">&nbsp;&nbsp;&nbsp;</span>
  	  <a class="bctl" href="StoreCatalogDisplay?storeId=<%=storeId%>&catalogId=<%=catalogId%>&langId=<%=languageId%>"><%=storeText.getString("Breadcrumb_CommercePlaza")%></a><span class="bct">&nbsp;&nbsp;&nbsp;&gt;&nbsp;&nbsp;&nbsp;</span>
  	  <span class="bct"><%=storeText.getString("Breadcrumb_RequestPriceAvail")%></span>
        </td>
      </tr>
      <tr>
        <td>
          <table width="590" border="0" cellspacing="0" cellpadding="0">        
            <tr>
              <td valign="top" width="310">
                <div align="left" class="title">
                  <img src="<%=fileDir%>images/c.gif" width="1" height="11" border="0" /><br />
                  <%=storeText.getString("OrderQuotationDisplayByItem_AssignQuantities")%>
                </div>              
                <div><span class="subtitle"><%=storeText.getString("OrderQuotationDisplayByItem_Step")%></span></div>
              </td>
              <td valign="top" width="280">
                <div align="right"><img src="<%=fileDir%>images/hdr_cart.gif" width="280" height="72" alt="<%=storeText.getString("OrderQuotationDisplayByItem_AssignQuantities")%>"></div>
              </td>
            </tr>
          </table>
        </td>
      </tr>
      <tr>
        <td><span style="FONT-WEIGHT: bold"><%=storeText.getString("OrderQuotationDisplayByItem_Response")%>&nbsp;<%=TimestampHelper.getDateFromTimestamp(orderBean.getLastUpdateInEJBType(),locale)%> <%=orderBean.getLastUpdateInEJBType().toString().substring(11,16)%></span></td>
      </tr>      
      <tr>
        <td><img src="<%=fileDir%>images/c.gif" width="1" height="16" border="0" />
      <tr>
        <td><%=storeText.getString("OrderQuotationDisplayByItem_Instruction")%></td>
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

      
<%
    Vector errorDistributorNames = new Vector();
    Vector errorDistributorPhones = new Vector();
    for (int x=0;x<childOrderBeans.length;x++) { 
      OrderDataBean quoteBean = childOrderBeans[x];    
      if (quoteBean.getStatus().equals("H")) {
        StoreEntityDataBean storeEntity = new StoreEntityDataBean();
        storeEntity.setDataBeanKeyStoreEntityId( quoteBean.getStoreEntityId()  );
        com.ibm.commerce.beans.DataBeanManager.activate(storeEntity, request);
        // Get the appropriate description of the store entity - for the store display name       
        Integer iLangId = Integer.valueOf(languageId);  
        StoreEntityDescriptionAccessBean storeDesc = storeEntity.getDescription(iLangId);        
        errorDistributorNames.addElement(storeDesc.getDisplayName());
        
        // Next, get the store location address - for the phone number
        String distLocId = storeDesc.getLocationAddressId();        
        StoreAddressDataBean storeAddr = new StoreAddressDataBean();
        storeAddr.setDataBeanKeyStoreAddressId(distLocId);
        com.ibm.commerce.beans.DataBeanManager.activate(storeAddr, request);         
        errorDistributorPhones.addElement(storeAddr.getPhone1());
      }
    }

    // display error message if distributors return error codes i.e. status=H
    if (errorDistributorNames.size() > 0) {
%>
      <tr>
        <td><img src="<%=fileDir%>images/c.gif" width="1" height="5" border="0" />
      <tr>
      <tr>
        <td><b><%=storeText.getString("ErrorStatus_Text8")%></b> 
<%
         for (int i=1; i<=errorDistributorNames.size(); i++) { 
%>        
        <br><b><font class="error"><%=storeText.getString("ErrorStatus_Text9", (String) errorDistributorNames.elementAt(i-1), (String) errorDistributorPhones.elementAt(i-1) )%></font></b>
<%
         }
%>        
      </tr>     
<%  } %>                       
<%  // display error message if distributors responses timeout
    if( (timeoutStores!=null)&&(timeoutStores.length>0) ) { %>
      <tr>
        <td><img src="<%=fileDir%>images/c.gif" width="1" height="5" border="0" />
      <tr>
      <tr>
        <td><b><%=storeText.getString("OrderQuotationDisplayByItem_Timeout")%></b> 
<%      String timeoutDistName=null;
        String distPhone=null;
        for(int i=0;i<timeoutStores.length;i++) {
        
          // First, get the StoreEntityDataBean
          StoreEntityDataBean storeEntity = new StoreEntityDataBean();
          storeEntity.setDataBeanKeyStoreEntityId( timeoutStores[i] );
          com.ibm.commerce.beans.DataBeanManager.activate(storeEntity, request);

          try { 
          
            // Get the appropriate description of the store entity - for the store display name       
            Integer iLangId = Integer.valueOf(languageId);  
            StoreEntityDescriptionAccessBean storeDesc = storeEntity.getDescription(iLangId);        
            timeoutDistName = storeDesc.getDisplayName();
            
            // Next, get the store location address - for the phone number
            String distLocId = storeDesc.getLocationAddressId();        
            StoreAddressDataBean storeAddr = new StoreAddressDataBean();
            storeAddr.setDataBeanKeyStoreAddressId(distLocId);
            com.ibm.commerce.beans.DataBeanManager.activate(storeAddr, request);         
            distPhone = storeAddr.getPhone1();            
          } catch(Exception e) {
            out.println("<!-- Exception caught (1) : " + e + " -->");
            StoreDataBean timeoutStoreBean = new StoreDataBean(); 
            timeoutStoreBean.setStoreId( timeoutStores[i] );
            com.ibm.commerce.beans.DataBeanManager.activate(timeoutStoreBean, request);            
            timeoutDistName = timeoutStoreBean.getIdentifier();
          } %>
        <br><b><font class="error"><%=storeText.getString("ErrorStatus_Text9",timeoutDistName, distPhone )%></font></b>
<%      } %>                
      </tr>
<%    } %>      
      <tr>
        <td>
          <table width=590>
            <td align="right"><b><%=storeText.getString("OrderQuotationDisplayByItem_SortBy")%>&nbsp;<%=storeText.getString("OrderQuotationDisplayByItem_SortByItem")%> | <a href="javascript:viewByDist(document.PriceAvailabilityForm)"><%=storeText.getString("OrderQuotationDisplayByItem_SortByDist")%></a></b></td>
          </table>
        </td>
      </tr>
  <%    OrderItemDataBean[] orderItemDataBeans = orderBean.getOrderItemDataBeans();
        int selectOICount = 0;        
        
        for( int items=0; items<orderItemDataBeans.length; items++) {
          OrderItemDataBean thisOI = orderItemDataBeans[items];
          
          CatalogEntryDataBean catEntryBean = thisOI.getCatalogEntryDataBean();
          OrderItemDataBean[] quoteOIBeans = thisOI.getChildItems(distIdList, "PRIM", "initial");
          OrderItemDataBean[] altOIBeans = thisOI.getChildItems(distIdList, "ALT","initial");
          // OrderItemDataBean[] quoteOIBeans = thisOI.getChildInitialItems();
          double assigned=0.0;
          double remaining = 0.0;
          for (int loop=0;loop<quoteOIBeans.length;loop++) {
            assigned += quoteOIBeans[loop].getSelectionQuantity().doubleValue();
          }
          remaining = Double.parseDouble(thisOI.getQuantity())-assigned;
          if (remaining < 0.0) {
            remaining=0.0;      
          }
          String orderItemDelete = "OrderItemDelete?orderItemId=" + thisOI.getOrderItemId() 
                                  + "&URL=" + java.net.URLEncoder.encode("OrderQuotationDisplay?orderQuotationDisplayViewName=OrderQuotationDisplayByItemFormView&outOrderQuotationRelIdName=orderQuotationIDs&orderId=" + orderRn);
          
      %>
      <tr valign="top">
        <td>
          <table cellpadding="0" cellspacing="0" border="0" width="590">
            <tr class=tdblue>
              <td valign="top">
                <table width="590" cellpadding="2" cellspacing="0" border="0">
                  <tr>
                    <td width="400" align="left"><span class=small style="FONT-WEIGHT: bold; COLOR: #ffffff"><%=catEntryBean.getDescription().getShortDescription()%></span></td>                                    
                    <td align="right">
                      <table cellpadding="2" cellspacing="0" border="0">
                        <tr>
                          <td><a href="<%=orderItemDelete%>"><span class=small style="FONT-WEIGHT: bold; COLOR: #ffffff; text-decoration: underline"><%=storeText.getString("OrderQuotationDisplayByItem_RemoveItem")%></a></span></td>
                          <td><a href="<%=orderItemDelete%>"><img src="<%=fileDir%>images/icn_trash.gif" width="11" height="13" border="0" alt="<%=storeText.getString("OrderQuotationDisplayByItem_RemoveItem")%>"></a></td>
                        </tr>
                      </table>
                    </td>
                  </tr>
                </table>
              </td>
            </tr>
          </table>
        </td>
      </tr>
      <tr class=tlblue>
        <td>
          <table cellpadding="3" cellspacing="0" border="0" width="590">
            <tr>                                                                                                                              
              <td valign="top"><A href="ProductDisplay?storeId=<%=storeId%>&langId=<%=languageId%>&productId=<%=thisOI.getCatalogEntryId()%>"><span class=medblk><%=storeText.getString("OrderQuotationDisplayByItem_ColumnPartNum")%> : </span><span class=medblk style="FONT-WEIGHT: bold; text-decoration:underline"><%=catEntryBean.getPartNumber()%></span></a></td>
            </tr>
            <tr>
              <td valign="top"><span class=medblk><%=storeText.getString("OrderQuotationDisplayByItem_ColumnListPrice")%> <b><%=thisOI.getPriceDataBean()%></b></span></td>
            <tr>
            <tr>
              <td valign="top"><span class=medblk><%=storeText.getString("OrderQuotationDisplayByItem_ColumnQtyRemaining")%> : <span style="FONT-WEIGHT: bold"><%=(new Double(remaining)).longValue()%></span> of <%=thisOI.getFormattedQuantity()%></span></td>
            </tr>
          </table>
        </td>
      </tr>
      <tr valign="top">
        <td>
          <table cellpadding="0" cellspacing="0" border="0" width="590">
            <tr>
              <td valign="top">
                <table width="590" cellpadding="2" border="0" cellspacing="1">
                  <tr class="mbg" valign="top">
                    <th width=150 align="left" id="th1"><span class=small style="FONT-WEIGHT: bold"><%=storeText.getString("OrderQuotationDisplayByItem_SortByDist")%></span></th>
                    <th width=120 align="left" id="th2"><span class=small style="FONT-WEIGHT: bold"><%=storeText.getString("OrderQuotationDisplayByItem_ColumnDistSKU")%></span></th>
                    <th width=120 align="left" id="th3"><span class=small style="FONT-WEIGHT: bold"><%=storeText.getString("OrderQuotationDisplayByItem_ColumnDistPrice")%></span></th>
                    <th width=120 align="left" id="th4"><span class=small style="FONT-WEIGHT: bold"><%=storeText.getString("OrderQuotationDisplayByItem_ColumnQtyInv")%></span></th>
                    <th width=80 align="left" id="th5"><span class=small style="FONT-WEIGHT: bold"><%=storeText.getString("OrderQuotationDisplayByItem_ColumnQtyAss")%></span></th>
                  </tr>
  <%    for( int children=0;children<quoteOIBeans.length;children++) { //inner loop
          OrderItemDataBean thisQuoteOI = quoteOIBeans[children];
          thisQuoteOI.setCommandContext(cmdcontext);

        String distName=null;
        String distURL=null;

        // First, get the StoreEntityDataBean
        StoreEntityDataBean storeEntity = new StoreEntityDataBean();
        storeEntity.setDataBeanKeyStoreEntityId( thisQuoteOI.getStoreId() );
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
          distURL = storeAddr.getURL();        
        } catch(Exception e) {
          out.println("<!-- Exception caught (1) : " + e + " -->");
          if( distName==null ) {
            StoreDataBean quoteStore = new StoreDataBean();
            quoteStore.setStoreId( thisQuoteOI.getStoreId() );
            com.ibm.commerce.beans.DataBeanManager.activate(quoteStore, request);
            distName = quoteStore.getIdentifier();
          }
        }

        if( children>0) { %>      
                  <tr>
                    <td colspan=5>
                      <table width="582" cellpadding="0" border="0" cellspacing="0">
                        <tr>
                          <td height="1" class="gbg"><img src="<%=fileDir%>images/c.gif" width="1" height="1" border="0" alt=""></td>
                        </tr>
                      </table>
                    </td>
                  </tr><% } %>
                  <tr>
                    <input type="hidden" name="orderItemId_<%=selectOICount%>" value="<%=thisQuoteOI.getOrderItemId()%>">
                    <% if (distURL!=null) { %>
                    <td headers="th1"><a href="ExitToDistributorSiteDisplayView?storeId=<%=storeId%>&langId=<%=languageId%>&forwardURL=<%=java.net.URLEncoder.encode(distURL)%>" target="_blank"><%=distName%></a></td>
                    <% } else { %>
                    <td headers="th1"><%=distName%></td>                    
                    <% } %>
                    <td align="left" headers="th2"><%=thisQuoteOI.getPartNumber()%></td>
                    <td align="right" headers="th3"><%=thisQuoteOI.getPriceDataBean()%></td>
                    <td align="left" headers="th4"><%=thisQuoteOI.getAvailableQuantity()%></td>
                    <td width=80 align="left" headers="th5_<%=children%>">
                    <label for="th5_<%=children%>"><img src="<%=fileDir%>images/trans.gif" height="1" width="1" border="0" alt="<%=storeText.getString("OrderQuotationDisplayByItem_ColumnQtyAss")%>"/></label>
                    <input type="text" id="th5_<%=children%>" size=4 name="quantity_<%=selectOICount%>" class="iform" value="<%=thisQuoteOI.getSelectionQuantity().longValue()%>"></td>
                  </tr>
      <% selectOICount++; } // end inner for loop  %>
                </table>
              </td>
            </tr>
          </table>
        </td>
      </tr>
      <tr>
        <td><img src="<%=fileDir%>images/c.gif" width="1" height="10" border="0" /></td>
      </tr>
      <!-- start of alternatives -->
   <%    try {
           for( int alts=0;alts<altOIBeans.length;alts++) { //alt loop
            OrderItemDataBean thisAltOI = altOIBeans[alts];
            String altStoreId = thisAltOI.getStoreId();
            String catEntryDesc;
            CatalogEntryAccessBean thisCatEntry=null;
            try {
              catEntryDesc = thisAltOI.getDescription();
              if( catEntryDesc==null) {
                catEntryDesc = catEntryBean.getDescription().getShortDescription();
                out.println("<!-- ORDERITEMS.DESCRIPTION is null -->");
              }
            } catch(Exception e) {
              catEntryDesc = "xxx";
              out.println("<!--Exception caught (alt) : " + e + " -->");
            }
            
            String distName=null;
            String distURL=null;
    
            // First, get the StoreEntityDataBean
            StoreEntityDataBean storeEntity = new StoreEntityDataBean();
            storeEntity.setDataBeanKeyStoreEntityId( thisAltOI.getStoreId() );
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
              distURL = storeAddr.getURL();        

            } catch(Exception e) {
              out.println("<!-- Exception caught (1a) : " + e + " -->");
              if( distName==null ) {
                StoreDataBean quoteStore = new StoreDataBean();
                quoteStore.setStoreId( thisAltOI.getStoreId() );
                com.ibm.commerce.beans.DataBeanManager.activate(quoteStore, request);
                distName = quoteStore.getIdentifier();
              }
            }
 %>
      <tr>
        <td>
          <table cellpadding="0" cellspacing="0" border="0" width="590">
            <tr class="tdblue">
              <td>
                <table cellpadding="0" cellspacing="0" border="0" width="590">
                  <tr>
                    <td align="left"><span class=small style="FONT-WEIGHT: bold; COLOR: #ffffff"><%=catEntryDesc%> (<%=storeText.getString("OrderQuotationDisplayByItem_Alternative")%>)</span></td>
                    <td align="right"><a href="OrderItemDelete?orderItemId=<%=thisAltOI.getOrderItemId()%>&URL=<%="OrderQuotationDisplay?orderQuotationDisplayViewName=OrderQuotationDisplayByItemFormView&outOrderQuotationRelIdName=orderQuotationIDs&orderId=" + orderRn + "&"%>" class=tdblue><span class=small style="FONT-WEIGHT: bold; COLOR: #ffffff; text-decoration: underline"><%=storeText.getString("OrderQuotationDisplayByItem_RemoveItem")%></span><img src="<%=fileDir%>images/icn_trash.gif" width="11" height="13" border="0" alt="<%=storeText.getString("OrderQuotationDisplayByItem_RemoveItem")%>" valign="middle"></a>
                  </tr>
                </table>
              </td>
            </tr>
            <tr>
              <td>
                <table cellpadding="2" cellspacing="1" border="0" width="590">
                  <tr  class="mbg" valign="top">
                    <th width=150 align="left" id="th1"><span class=small style="FONT-WEIGHT: bold"><%=storeText.getString("OrderQuotationDisplayByItem_SortByDist")%></span></th>
                    <th width=120 align="left" id="th2"><span class=small style="FONT-WEIGHT: bold"><%=storeText.getString("OrderQuotationDisplayByItem_ColumnDistSKU")%></span></th>
                    <th width=120 align="left" id="th3"><span class=small style="FONT-WEIGHT: bold"><%=storeText.getString("OrderQuotationDisplayByItem_ColumnDistPrice")%></span></th>
                    <th width=120 align="left" id="th4"><span class=small style="FONT-WEIGHT: bold"><%=storeText.getString("OrderQuotationDisplayByItem_ColumnQtyInv")%></span></th>
                    <th width=80 align="left" id="th5"><span class=small style="FONT-WEIGHT: bold"><%=storeText.getString("OrderQuotationDisplayByItem_ColumnQtyAss")%></span></th>
                  </tr>
                  <tr>          
                <%if( (distURL != null) && (distURL.length()>0) ) { %>
                    <td headers="th1"><a href="ExitToDistributorSiteDisplayView?storeId=<%=storeId%>&langId=<%=languageId%>&forwardURL=<%=java.net.URLEncoder.encode(distURL)%>" target="_blank"><%=distName%></a></td>
                <%} else {%>                    
                    <td headers="th1"><%=distName%></td>
                <%}%>                      
                    <td headers="th2"><%=thisAltOI.getSupplierPartNumber()%></td>
                    <td align="right" headers="th3"><%=thisAltOI.getPriceDataBean()%></td>
                    <td align="left" headers="th4"><%=thisAltOI.getAvailableQuantity()%></td>
                    <td width=80 align="left" headers="th5">
                    <label for="th5_<%=alts%>"><img src="<%=fileDir%>images/trans.gif" height="1" width="1" border="0" alt="<%=storeText.getString("OrderQuotationDisplayByItem_ColumnQtyAss")%>"/></label>
                    <input type="text" size=4 name="quantity_<%=selectOICount%>" id="th5_<%=alts%>" class="iform" value="<%=thisAltOI.getSelectionQuantity().longValue()%>"></td>
                  </tr>
                </table>
              </td>
            </tr>
          </table>
        </td>
      </tr>

    <% selectOICount++;
          } // end alt loop %>
    <%    } catch(Exception e) {
          out.println("<!-- Exception caugh (alt) : " + e + " -->");
        } %>
       <!-- end of alternatives -->          
    <%  } // end outer for loop 
      if( orderItemDataBeans.length == 0 ) {%>
      <tr><td><b><%=storeText.getString("OrderQuotationDisplayByItem_NoItems")%></b></td></tr>
      <% } %>
      <tr>
        <td>
          <table cellpadding="0" cellspacing="0" border="0" width=590>
            <tr>
              <td width="100%" class="bbg"><img class="imgHeightFix" src="<%=fileDir%>images/c.gif" width="1" height="2" border="0" alt=""></td>
            </tr>
            <tr>
              <td align="right"><img src="<%=fileDir%>images/ar_blue.gif"><a href="javascript:updateForm(document.PriceAvailabilityForm)"><%=storeText.getString("OrderQuotationDisplayByItem_Update")%></a></td>
            </tr>
          </table>
        </td>
      </tr>
      <tr>
        <td><img src="<%=fileDir%>images/c.gif" height="10" width="1"></td>
      </tr>
      <tr>
        <td>
          <table cellpadding="0" cellspacing="0" border=0 width=590>
            <tr>
              <td valign="top"> <!-- column 1 - continue shopping and disclaimer -->
                <table cellpadding=2 cellspacing=1 border=0 width=376>
                  <tr>
                    <td><span style="FONT-WEIGHT: bold"><label for="contshop"><%=storeText.getString("ContinueShopping_Title")%></label></span></td>
                  </tr>
                  <form name="NavigationForm" METHOD="POST" action="">
                  <tr valign="top">
                    <td width=250>
                      <select name="Destination" id="contshop" size="1" class="iform" onchange="top.location.href = this.options[this.selectedIndex].value;"> 
                      <span class="small">                    
                      <option selected><%=storeText.getString("ContinueShopping_Default")%></option>
                   <% try { 
                      CatalogDataBean catalog = new CatalogDataBean();
                      catalog.setCatalogId(catalogId);
                      DataBeanManager.activate(catalog, request);        
                      CategoryDataBean ltopCategories[] = catalog.getTopCategories();
                      CategoryDataBean lcategory;
                      String lcategoryId;
            
                      for (int i = 0; i < ltopCategories.length; ++i) {
                        lcategory = ltopCategories[i];
                        lcategoryId = lcategory.getCategoryId(); %>                
                      <option value="CategoryDisplay?catalogId=<%=catalogId%>&storeId=<%=storeId%>&categoryId=<%=lcategoryId%>&langId=<%=languageId%>"><%=lcategory.getDescription().getName()%></option>
                      <% }
                      } catch(Exception e){} %>
                      </span>
                      </select>
                    </td>      
                  </tr>
                  </form>
                  <tr>
                    <td><img src="<%=fileDir%>images/c.gif" width="1" height="5" border="0" /></td>                  
                  </tr>
                  <tr valign="top">
                    <td width=384>*<%=storeText.getString("OrderQuotationDisplayByItem_Disclaimer")%></td>
                  </tr>
                </table>
              </td>
              <td valign="top"> <!-- column 2 - buttons -->
                <table cellpadding=0 cellspacing=1 border=0 width=206>              
                  <tr>
                    <td width=206 align="left"><a href="javascript:submitForm( document.PriceAvailabilityForm )"><img src="<%=fileDir%><%=locale.toString()%>/images/b_request_carts.gif" border=0 alt="<%=storeText.getString("Alt_RequestCarts")%>"></a></td>              
                  </tr>
                  <tr>
                    <td><img src="<%=fileDir%>images/c.gif" width="1" height="10" border="0" /></td>                  
                  </tr>
                  <tr>
                    <td width=206>
                      <table cellpadding=2 cellspacing=0 border=0>
                        <tr>
                          <td><a href="DistributorSelectionDisplayView"><img src="<%=fileDir%>images/arrow_rd.gif" width="23" height="23" border="0" alt="<%=storeText.getString("OrderQuotationDisplayByItem_Refresh")%>"></a></td>
                          <td><a href="DistributorSelectionDisplayView"><%=storeText.getString("OrderQuotationDisplayByItem_Refresh")%></a></td>
                        </tr>
                      </table>
                    </td>
                  </tr>
    <%  String currDescription = orderBean.getDescription();
        if ( (currDescription==null)||(currDescription.length()==0)) { %>      
                  <tr>
                    <td><img src="<%=fileDir%>images/c.gif" width="1" height="10" border="0" /></td>                  
                  </tr>
                  <tr>
                    <td width=206>
                      <table cellpadding=2 cellspacing=0 border=0>
                        <tr>
                          <td><a href="javascript:saveForm(document.PriceAvailabilityForm)"><img src="<%=fileDir%>images/arrow_rd.gif" width="23" height="23" border="0" alt="<%=storeText.getString("OrderQuotationDisplayByItem_Save")%>"></a></td>
                          <td align="left"><a href="javascript:saveForm(document.PriceAvailabilityForm)"><%=storeText.getString("OrderQuotationDisplayByItem_Save")%></a></td>
                        </tr>
                      </table>
                    </td>
                  </tr>
    <%  } %>      
                </table>
              </td>
            </tr>
          </table>
        </td>
      </tr>

    </table>
    </form>
  <!--END MAIN CONTENT-->
  </td>
  <!-- End of Main Content TD -->
</tr></tbody></table>
<!-- End Main Table -->
<!-- Start Footer -->
<%@ include file="../../../include/FooterDisplay.jspf"%>
<!-- End Footer -->
</body>
</html>
