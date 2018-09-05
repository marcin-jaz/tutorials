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
<%@ page import="com.ibm.commerce.inventory.beans.*" %>
<%@ page import="com.ibm.commerce.contract.beans.ContractDataBean" %>
<%@ page import="com.ibm.commerce.server.JSPResourceBundle" %>
<%@ page import="java.net.URLEncoder" %>
<%@ include file="../../../include/EnvironmentSetup.jsp"%>
<% response.setContentType(storeText.getString("ENCODESTATEMENT")); %> 
<%
  catalogId = sdb.getStoreCatalogs()[0].getCatalogId();
  String orderId = jhelper.getParameter("channelOrderId");
  String multipleShopcart = jhelper.getParameter("multipleShopcart");
  String autoOpen = jhelper.getParameter("autoOpen");
  String forwardView = jhelper.getParameter("forwardView");
  String[] timeoutOrderIds = jhelper.getParameterValues("timeoutOrderId"); 
  String openAllWindows = jhelper.getParameter("openAllWindows");
  
  if(autoOpen.equalsIgnoreCase("null")){
	autoOpen="";
  }
  OrderDataBean  childOrderBean=new OrderDataBean();
  OrderDataBean  orderBean = new OrderDataBean();
  
  if( orderId==null) {
    String childOrderId = jhelper.getParameter("childOrderId");
    if( childOrderId != null) {
      childOrderBean.setOrderId(childOrderId);
      com.ibm.commerce.beans.DataBeanManager.activate(childOrderBean, request);
      orderBean = childOrderBean.getParentOrder();
      orderId = orderBean.getOrderId();
    }
  }
  else {
    orderBean.setOrderId(orderId);
    com.ibm.commerce.beans.DataBeanManager.activate(orderBean, request);
  }
    
  TypedProperty requestProperties = (TypedProperty)request.getAttribute(ECConstants.EC_REQUESTPROPERTIES) ;
  out.println("<!-- orderId : " + orderId + " -->");
  out.println("<!-- requestProperties : \n" + requestProperties + " -->");
  
  Integer[] distIdList = cmdcontext.getStore().getRelatedStores("com.ibm.commerce.referral");
  OrderDataBean [] submitOrderBeans = orderBean.getChildOrders(distIdList, "submission");

  OrderItemDataBean [] unassignedItems = orderBean.getOrderItemDataBeans();  
  
  String returnURL = "ShopCartOrderConfirmationDisplayView?channelOrderId="+orderId;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "DTD/xhtml1-transitional.dtd">

<HEAD>
  <TITLE><%=storeText.getString("ShopcartOrderConfirmation_Title")%></TITLE>
  <link rel=stylesheet href="<%=fileDir%>PCDMarket.css" type="text/css">
</HEAD>
<script language="javascript">
var busy=false;
function openAllWindows() {
<%
if (openAllWindows != null && openAllWindows.equals("Y"))
{
  for(int loop=0;loop<submitOrderBeans.length;loop++) {
    // Order-specific URL 
    String extURL = new String();
    try {
      OrderReleaseDataBean orderRelease = new OrderReleaseDataBean();
      orderRelease.setDataBeanKeyOrdersId( submitOrderBeans[loop].getOrderId() );
      orderRelease.setDataBeanKeyOrderReleaseNum( submitOrderBeans[loop].getOrderItemDataBeans()[0].getOrderReleaseNumber());
      com.ibm.commerce.beans.DataBeanManager.activate(orderRelease, request);    
      
      extURL = orderRelease.getExternalReference();
    } catch(Exception e) {
      out.println("<!-- Exception caught (openAll) : " + e + " -->");
    }
    if(( extURL!=null)&&(extURL.length()>0)&&(!extURL.equals("null"))) {%>
    window.open("ExitToDistributorSiteDisplayView?storeId=<%=storeId%>&langId=<%=languageId%>&forwardURL=<%=java.net.URLEncoder.encode(extURL)%>","<%=submitOrderBeans[loop].getOrderId()%>");  
<%  }
  } 
}
%>
}

function openOneWindow() { 
<%
  if( (autoOpen!=null)&&(autoOpen.length()>0)) {
    // Order-specific URL 
    String autoOpenURL = new String();
    try {
      OrderDataBean autoOpenOrder = new OrderDataBean();
      autoOpenOrder.setOrderId( autoOpen );
      com.ibm.commerce.beans.DataBeanManager.activate(autoOpenOrder, request);  
      
      OrderReleaseDataBean orderRelease = new OrderReleaseDataBean();
      orderRelease.setDataBeanKeyOrdersId( autoOpen );
      orderRelease.setDataBeanKeyOrderReleaseNum( autoOpenOrder.getOrderItemDataBeans()[0].getOrderReleaseNumber());
      com.ibm.commerce.beans.DataBeanManager.activate(orderRelease, request);  
      autoOpenURL = orderRelease.getExternalReference();      
    } catch( Exception e ) {
      out.println("<!--Exception caught (autoOpen) : " + e + " -->");
    }
    if(( autoOpenURL!=null)&&(autoOpenURL.length()>0)&&(!autoOpenURL.equals("null"))) {
 %>
    window.open("ExitToDistributorSiteDisplayView?storeId=<%=storeId%>&langId=<%=languageId%>&forwardURL=<%=java.net.URLEncoder.encode(autoOpenURL)%>","<%=autoOpen%>");    
<%
    }
  } 
%>    
}

function removeUnassignedItem( form, item )
{
  if( !busy ) {
    busy=true;
    form.orderItemId.value=item;
    form.submit();
  }
}

function removeUnassignedItems(form)
{
  if( !busy ) {
    busy=true;
    form.submit();
  }
}
  
</script>
<% String submitCall = "";
  if ((multipleShopcart!=null)&&(multipleShopcart.equals("1"))) {
    submitCall = "openAllWindows();";
  } else if ((autoOpen!=null)&&(autoOpen.length()>0)) {
    submitCall = "openOneWindow();";    
  } 
%>
<BODY MARGINHEIGHT="0" MARGINWIDTH="0" LEFTMARGIN="0" TOPMARGIN="0" onLoad="<%=submitCall%>">
<!-- Start Header -->
<%@ include file="../../../include/HeaderDisplay.jspf"%>
<!-- End Header -->

<!-- Start Main Table - Consists of TD for Left Bar, TD for Content and TD for Quicklinks -->
<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0" WIDTH="750">
<TR>
  <TD VALIGN="top" class="mbg" WIDTH="150"> 
    <%
    String incfile = includeDir + "SidebarDisplay.jsp";
    %>
    <jsp:include page="<%=incfile%>" flush="true"/></TD>
  <!-- End  Left Nav Bar TD -->
  <td width="10"><a name="mainContent"></a><img height="1" width="10" alt="" src="<%=fileDir%>images/c.gif"></td> 
  <!-- Begin Main Content TD -->
  <TD valign="top" width="590">
    <!--START MAIN CONTENT-->
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
                  <span class="title"><%=storeText.getString("ShopcartOrderConfirmation_SubmissionTitle")%></span>
                </td>
                <td valign="top" width="280">
                  <div align="right"><img src="<%=fileDir%>images/hdr_cart.gif" width="280" height="72" alt="<%=storeText.getString("ShopcartOrderConfirmation_SubmissionTitle")%>"></div>
                </td>
              </tr>
            </table>
          </td>
        <tr>
        <tr>
          <td><%=storeText.getString("ShopcartOrderConfirmation_Submitted")%></td>
        </tr>
        <tr>
          <td><img src="<%=fileDir%>images/c.gif" height="10" width=1 alt=""></td>              
        </tr>
        <% for(int loop=0;loop<submitOrderBeans.length;loop++) { // outer loop - orders
                    
            OrderDataBean distOrder = submitOrderBeans[loop];
            if (( forwardView != null && !forwardView.equals("DistributorShopCartReviewDisplayView")) || (timeoutOrderIds != null && distOrder.getOrderId().equals(timeoutOrderIds[0])) || (distOrder.getStatus().equals("H")))
            {
            OrderItemDataBean[] distOrderItems = distOrder.getOrderItemDataBeans();

            String distName=null;
            String distURL=null;
            String storePhone1 = null;

            // First, get the StoreEntityDataBean
            StoreEntityDataBean storeEntity = new StoreEntityDataBean();
            storeEntity.setDataBeanKeyStoreEntityId( distOrder.getStoreEntityId() );
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
                StoreDataBean quoteStore = new StoreDataBean();
                quoteStore.setStoreId( distOrder.getStoreEntityId() );
                com.ibm.commerce.beans.DataBeanManager.activate(quoteStore, request);
                distName = quoteStore.getIdentifier();
              }
            }

            // Order-specific URL 
            String orderReleaseURL = new String();
            try {
              OrderReleaseDataBean orderRelease = new OrderReleaseDataBean();
              orderRelease.setDataBeanKeyOrdersId( distOrder.getOrderId() );
              orderRelease.setDataBeanKeyOrderReleaseNum( distOrder.getOrderItemDataBeans()[0].getOrderReleaseNumber());
              com.ibm.commerce.beans.DataBeanManager.activate(orderRelease, request);           
              orderReleaseURL = orderRelease.getExternalReference();
            } catch(Exception e) {
              out.println("<!-- Exception caught (release) : " + e + " -->");
            }
            if (distOrder.getStatus().equals("H")) {
      %>
        <tr>
          <td><span class="warning"><%=storeText.getString("ErrorStatus_Text5", distName, storePhone1 )%></span></td>
        </tr>
        <tr>
          <td><img src="<%=fileDir%>images/c.gif" height="10" width=1 alt=""></td>              
        </tr>        
      <%
            }
            else if (orderReleaseURL == null || orderReleaseURL.equals("") || orderReleaseURL.equals("null"))
            {
      %>
        <tr>
          <td><span class="warning"><%=storeText.getString("ShopcartOrderConfirmation_NotConfirmCall", distName, storePhone1 )%></span></td>
        </tr>
        <tr>
          <td><img src="<%=fileDir%>images/c.gif" height="10" width=1 alt=""></td>              
        </tr>        
      <%
            }
      %>
        <tr>
          <td>
            <table cellpadding="2" cellspacing="0" border="0" width="590">
              <tr class="tdblue">
                <% if ((distURL!=null)&&(distURL.length()>0)) { %>
                <th class="tdblue" id="th_dist<%=loop%>"><a href="ExitToDistributorSiteDisplayView?storeId=<%=storeId%>&langId=<%=languageId%>&forwardURL=<%=java.net.URLEncoder.encode(distURL)%>" target="_blank"><SPAN class=small style="FONT-WEIGHT: bold; COLOR: #ffffff; text-decoration: underline"><%=distName%></span></a></th>
                <% } else { %>
                <td class="tdblue"><SPAN class=small style="FONT-WEIGHT: bold; COLOR: #ffffff"><%=distName%></span></td>                
                <% } %>
                <td align="right">
                  <%
                  if (orderReleaseURL != null && !orderReleaseURL.equals("") & !orderReleaseURL.equals("null"))
                  {
                  %>
                  <table>
                     <tr>
                       <td class="tdblue"><a href="ExitToDistributorSiteDisplayView?storeId=<%=storeId%>&langId=<%=languageId%>&forwardURL=<%=java.net.URLEncoder.encode(orderReleaseURL)%>" target="_blank"><SPAN class=small style="FONT-WEIGHT: bold; COLOR: #ffffff; text-decoration: underline"><%=storeText.getString("ShopcartOrderConfirmation_Open")%></span></a></td>
                       <td class="tdblue"><img src="<%=fileDir%>/images/shopping_cart_t.gif" width="21" height="21" border="0" alt=""></td>
                     </tr>
                  </table>
                  <%
                  }
                  else
                  {
                  %>
                  <table>
                     <tr>
                       <td class="tdblue"><SPAN class=small style="FONT-WEIGHT: bold; COLOR: #ffffff"><%=storeText.getString("ShopcartOrderConfirmation_Call")%> <%=storePhone1%></span></td>
                     </tr>
                  </table>                  
                  <%
                  }
                  %>
                </td>
              </tr>
            </table>
          </td>
        </tr>
        <tr>
          <td>
            <table width="590" cellpadding="2" border="0" cellspacing="1">
              <tr class="mbg" valign="top">
                <th width=75 valign="top" id="th1"><SPAN class=small style="FONT-WEIGHT: bold"><%=storeText.getString("ShopcartOrderConfirmation_DistSKU")%></span></th>
                <th width=70 valign="top" id="th2"><SPAN class=small style="FONT-WEIGHT: bold"><%=storeText.getString("ShopcartOrderConfirmation_IBMPart")%></span></th>
                <th width=225 valign="top" id="th3"><SPAN class=small style="FONT-WEIGHT: bold"><%=storeText.getString("ShopcartOrderConfirmation_Desc")%></span></th>
                <th width=80 valign="top" id="th4"><SPAN class=small style="FONT-WEIGHT: bold"><%=storeText.getString("ShopcartOrderConfirmation_DistPrice")%></span></th>
                <th width=65 valign="top" id="th5"><SPAN class=small style="FONT-WEIGHT: bold"><%=storeText.getString("ShopcartOrderConfirmation_OrdQty")%></span></th>
                <th width=65 valign="top" id="th6"><SPAN class=small style="FONT-WEIGHT: bold"><%=storeText.getString("ShopcartOrderConfirmation_LineTotal")%></span></th>
              </tr>
              <% for(int items=0;items<distOrderItems.length;items++) { // inner loop - items
                    OrderItemDataBean thisItem = distOrderItems[items];
                    if ((thisItem.getLineItemType()!=null)&&(thisItem.getLineItemType().equals("ALT"))) {  %>
              <tr>
                <td valign="top" headers="th_dist<%=loop%> th1"><span class=small><%=thisItem.getSupplierPartNumber()%></span></td>
                <td headers="th_dist<%=loop%> th2">&nbsp;</td>
                <td valign="top" headers="th_dist<%=loop%> th3"><span class=small><%=thisItem.getCatalogEntryDataBean().getDescription().getShortDescription()%></span></td>
                <td align="right" valign="top" headers="th_dist<%=loop%> th4"><span class=small><%=thisItem.getPriceDataBean()%></span></td>
                <td valign="top" headers="th_dist<%=loop%> th5"><span class=small><%=thisItem.getFormattedQuantity()%></span></td>
                <td align="right" valign="top" headers="th_dist<%=loop%> th6"><span class=small><%=thisItem.getPerItemTotalPrice()%></span></td>
              </tr>
              <%    } else { %> 
              <tr>
                <td valign="top" headers="th_dist<%=loop%> th1"><span class=small><%=thisItem.getSupplierPartNumber()%></span></td>
                <td valign="top" headers="th_dist<%=loop%> th2"><a href="ProductDisplay?storeId=<%=storeId%>&langId=<%=languageId%>&productId=<%=thisItem.getCatalogEntryId()%>"><span class=small><%=thisItem.getPartNumber()%></span></a></td>
                <td valign="top" headers="th_dist<%=loop%> th3"><span class=small><%=thisItem.getCatalogEntryDataBean().getDescription().getShortDescription()%></span></td>
                <td align="right" valign="top" headers="th_dist<%=loop%> th4"><span class=small><%=thisItem.getPriceDataBean()%></span></td>
                <td valign="top" headers="th_dist<%=loop%> th5"><span class=small><%=thisItem.getFormattedQuantity()%></span></td>
                <td align="right" valign="top" headers="th_dist<%=loop%> th6"><span class=small><%=thisItem.getPerItemTotalPrice()%></span></td>
              </tr>
              <% } %>              
              <tr>
                <td colspan="7" class="gbg"></td>
              </tr>
              <% } // end of inner loop %>
              <tr>
                <td colspan=4>&nbsp;</td>
                <td><span class=small><strong><%=storeText.getString("ShopcartOrderConfirmation_Subtotal")%></strong></span></td>
                <td align="right"><span class=small><strong><%=distOrder.getSubTotal()%></strong></span></td>
              </tr>
            </table>
          </td>
        </tr>
        <tr height=10>
          <td>&nbsp;</td>
        </tr>
        <% }
        } // end of outer loop %>
 <% 
if (( forwardView != null && !forwardView.equals("DistributorShopCartReviewDisplayView")))
{
 if(unassignedItems.length>0) { //Conditional section for unassigned items %>
    <form name="UnassignedItem" action="OrderItemDelete" method="POST">
      <input type="hidden" name="URL" value="<%=returnURL%>">
      <input type="hidden" name="orderItemId" value="xyz">
      <input type="hidden" name="langId" value="<%=languageId%>">
      <input type="hidden" name="storeId" value="<%=storeId%>">
      <input type="hidden" name="forwardView" value="ShopCartOrderConfirmationDisplayView">
    </form>  
    <form name="AllUnassignedItems" action="OrderItemMove" method="POST">         
      <input type="hidden" name="fromOrderId" value="<%=orderId%>">
      <input type="hidden" name="fromOrderItemId" value="*">
      <input type="hidden" name="URL" value="<%=returnURL%>">
      <input type="hidden" name="allocate" value="*n">
      <input type="hidden" name="reverse" value="*n">
      <input type="hidden" name="backorder" value="*n">
      <input type="hidden" name="check" value="*n">
      <input type="hidden" name="merge" value="*n">
      <input type="hidden" name="remerge" value="*n">   
      <input type="hidden" name="forwardView" value="ShopCartOrderConfirmationDisplayView">
    </form>
    <tr>
      <td>
        <table width="590" cellpadding="2" border="0" cellspacing="1">
          <tr>
            <td colspan=6><%=storeText.getString("ShopcartOrderConfirmation_NotAssigned_Text")%></td>
          </tr>
          <tr>
            <td><img height="5" width="1" alt="" src="<%=fileDir%>images/c.gif"></td> 
          </tr>
          <tr class="tdblue">
            <td colspan=6>
              <table width="590" cellpadding="2" border="0" cellspacing="0">            
                <tr class="tdblue">
                  <td valign="top"><%=storeText.getString("DistributorShopCartReview_NotAssigned")%></td>
                  <td valign="top" align="right">
                    <table cellpadding="0" border="0" cellspacing="0">
                       <tr>
                         <td valign="top"><a href="javascript:removeUnassignedItems(document.AllUnassignedItems)"><SPAN class=small style="FONT-WEIGHT: bold; COLOR: #ffffff; text-decoration: underline"><%=storeText.getString("DistributorShopCartReview_RemoveAll")%></span></a></td>
                         <td valign="top"><a href="javascript:removeUnassignedItems(document.AllUnassignedItems)"><img src="<%=fileDir%>images/icn_trash.gif" border="0" alt="<%=storeText.getString("PartialTransferShopCartDisplay_Remove")%>"></a></td>
                       </tr>
                    </table>
                  </td>           
                </tr>
              </table>
            </td>
          </tr>
          <tr class="mbg" valign="top">
            <td width=75 valign="top"><SPAN class=small style="FONT-WEIGHT: bold"><%=storeText.getString("ShopcartOrderConfirmation_OrdQty")%></span></td>
            <td width=75 valign="top"><SPAN class=small style="FONT-WEIGHT: bold"><%=storeText.getString("ShopcartOrderConfirmation_IBMPart")%></span></td>
            <td width=250 valign="top"><SPAN class=small style="FONT-WEIGHT: bold"><%=storeText.getString("ShopcartOrderConfirmation_Desc")%></span></td>
            <td width=100 valign="top"><SPAN class=small style="FONT-WEIGHT: bold"><%=storeText.getString("ShopcartOrderConfirmation_IBMPrice")%></span></td>
            <td colspan=2 width=100 valign="top"><SPAN class=small style="FONT-WEIGHT: bold"><%=storeText.getString("ShopcartOrderConfirmation_LineTotal")%></span></td>
            </td>
          </tr> 
 <%
      for( int i=0; i<unassignedItems.length;i++) {
        OrderItemDataBean orderItem = unassignedItems[i];
    %>
          <form name="UnassignedItem_<%=i%>" action="OrderItemUpdate" method="POST">
          <input type="hidden" name="URL" value="<%=returnURL%>">
          <input type="hidden" name="orderItemId_1" value="<%=orderItem.getOrderItemId()%>">
          <input type="hidden" name="quantity_1" value="0">
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
            <td valign="top"><span class=small><%=orderItem.getFormattedQuantity()%></span></td>
            <td valign="top"><a href="ProductDisplay?storeId=<%=storeId%>&langId=<%=languageId%>&productId=<%=orderItem.getCatalogEntryId()%>"><span class=small><%=orderItem.getPartNumber()%></span></a></td>
            <td valign="top"><span class=small><%=orderItem.getCatalogEntry().getDescription().getShortDescription()%></span></td>
            <td align="right" valign="top"><span class=small><%=orderItem.getPriceDataBean()%></span></td>
            <td align="right" valign="top"><span class=small><%=orderItem.getPerItemTotalPrice()%></span></td> 
            <td width=15 align="right" valign="top"><a href="javascript:removeUnassignedItem(document.UnassignedItem,<%=orderItem.getOrderItemId()%>)"><img src="<%=fileDir%>images/icn_trash.gif" alt="<%=storeText.getString("PartialTransferShopCartDisplay_Remove")%>" border="0" align="right"></a></td>
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
} 
    if ( forwardView != null && forwardView.equals("DistributorShopCartReviewDisplayView"))
    {
      // show a link to DistributorShopCartReviewDisplay if there are still non-submitted carts
%>
<tr>
      <td height="18" align="right" colspan="2">
        <table cellpadding=0 cellspacing=0 border=0>
          <tr>
            <td width=23 align="right"><a href="DistributorShopCartReviewDisplayView?orderId=<%=orderId%>&langId=<%=languageId%>&storeId=<%=storeId%>&catalogId=<%=catalogId%>"><img src="<%=fileDir%><%=locale.toString()%>/images/b_return_submittedcart.gif" border="0" alt="<%=storeText.getString("Alt_ReturnSubmitted")%>"></a></td>
          </tr>
        </table>
      </td>
</tr>
<%  }   %>
       </table>
    <!--END MAIN CONTENT-->
  </TD>
  <!-- End of Main Content TD -->
</tr></tbody></table>
<!-- End Main Table -->
<!-- Start Footer -->
<%@ include file="../../../include/FooterDisplay.jspf"%>
<!-- End Footer -->
</BODY>
</HTML>