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
<%@ page import="java.text.*" %> 
<%@ page import="java.util.Vector" %>
<%@ page import="com.ibm.commerce.server.*" %>
<%@ page import="com.ibm.commerce.command.*" %>
<%@ page import="com.ibm.commerce.user.beans.*" %>
<%@ page import="com.ibm.commerce.user.objects.*" %>
<%@ page import="com.ibm.commerce.order.beans.*" %>
<%@ page import="com.ibm.commerce.order.objects.*" %>
<%@ page import="com.ibm.commerce.common.beans.*" %>
<%@ page import="com.ibm.commerce.common.objects.*" %>
<%@ page import="com.ibm.commerce.contract.beans.*" %>
<%@ page import="com.ibm.commerce.contract.objects.*" %>
<%@ page import="com.ibm.commerce.inventory.beans.*" %>
<%@ page import="com.ibm.commerce.order.objects.*" %>
<%@ page import="com.ibm.commerce.price.beans.*" %>       
<%@ page import="com.ibm.commerce.utils.TimestampHelper" %>  
<%@ page import="com.ibm.commerce.catalog.common.ECCatalogConstants" %>
<%@ page import="com.ibm.commerce.server.JSPResourceBundle" %>
<%@ page import="java.math.BigDecimal" %>
<%@ include file="../../../include/EnvironmentSetup.jsp"%>
<% response.setContentType(storeText.getString("ENCODESTATEMENT")); 
	
	String orderId = jhelper.getParameter("orderId");
  
	OrderItemDataBean orderItem = null;
	OrderItemDataBean [] orderItems = null;

	// Quotation Orders
	OrderDataBean childOrder = null;
	OrderDataBean [] childOrders = null;
	OrderItemDataBean childOrderItem = null;
	OrderItemDataBean [] childOrderItems = null;

	Integer[] distIdList = cmdcontext.getStore().getRelatedStores("com.ibm.commerce.referral");

  request.setAttribute("pageName", "PendingShoppingCarts");
  
  // URL for all forms
  String returnURL = "PartialTransferShopCartDisplayView?storeId="+storeId+"&langId="+languageId+"&catalogId="+catalogId+"&orderId="+orderId;
  
  // Order data bean for channel shopcart order
  OrderDataBean order = new OrderDataBean();
  order.setOrderId(orderId);
  com.ibm.commerce.beans.DataBeanManager.activate(order, request);
  
  //Build a vector of unassigned items - need to know if there are any before we try to display
  Vector unassignedItems = new Vector();
  orderItems = order.getOrderItemDataBeans();
  
  int unassignedItemCount = 0;
  
  boolean emptyChannelCart = false;
  if (orderItems.length == 0) 
     emptyChannelCart = true;
     
  for (int i=0; i < orderItems.length; i++) {
  
  	orderItem = orderItems[i];
  	OrderItemDataBean[] selectItems = orderItem.getChildItems(distIdList, "BOTH", "selection");
  	double assigned = 0.0;
  	double requested = orderItem.getQuantityInEJBType().doubleValue();
  	for (int loop = 0; loop < selectItems.length; loop++) {
  		if (selectItems[loop].getOrder().getStatus().equals("P")) {
  			assigned += selectItems[loop].getSelectionQuantity().doubleValue();
  		}
  	}		
  	if (requested > assigned) {
  		double  remaining = (requested - assigned);
  		orderItem.setField2( String.valueOf( (new Double(remaining)).longValue() )); //Temporary usage - this is OK as long as we don't call commitCopyHelper()!!!!
  		unassignedItems.add(orderItem);
  		unassignedItemCount++;
    }
  }
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "DTD/xhtml1-transitional.dtd">
<html>
<head>
  <title><%=storeText.getString("PartialTransferShopCartDisplay_Title")%></title>
  <link rel="stylesheet" href="<%=fileDir%>PCDMarket.css" type="text/css" />

<script language="javascript">
  var busy=false;
	function ActivateShoppingCart(form)
	{
    if( !busy ) {
      busy = true;  
  		form.submit();
    }
	}
		function ActivateNewCart(form)
	{
    if( !busy ) {
      busy = true;  
  		form.submit();
    }
	}
	function RemoveUnassignedItem(form, itemId, qty )
	{
    if( !busy ) {
      busy = true;	  
  	  form.orderItemId_1.value = itemId;
  	  form.quantity_1.value = qty;
  	  form.submit();
  	}
	}

	function RemoveAllUnassignedItems()
	{
    if( !busy ) {
      busy = true;  
  	  document.AllUnassignedItems.submit();
  	}
	}

  function RemoveOrder( form )
  {
    if( !busy ) {
      busy = true;    
      form.submit();
    }
  }

  function CancelOrder( form, orderNum )
  {
    if( !busy ) {
      busy = true;
      form.orderId.value=orderNum;
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
  <tbody>
  <tr>
    <td valign="top" class="mbg" width="150"> 
      <%
      String incfile = includeDir + "SidebarDisplay.jsp";
      %>
      <jsp:include page="<%=incfile%>" flush="true"/></td>
    <!-- End  Left Nav Bar TD -->
    <td><a name="mainContent"></a><img src="<%=fileDir%>images/c.gif" width="10" height="1" class="imgHeightFix" /></td>        
    <!-- Begin Main Content TD -->
    <td valign="top" width="590">
      <!--START MAIN CONTENT-->
      <form name="CancelOrder" action="OrderCancel" method="post">
      <input type="hidden" name="URL" value="<%=returnURL%>" />
      <input type="hidden" name="orderId" value="xxx" />
      <input type="hidden" name="storeId" value="<%=storeId%>" />
      <input type="hidden" name="langId" value="<%=languageId%>" />
      </form>
    	<table width="590" border="0" cellspacing="0" cellpadding="0">
    	  <tbody>
        <tr>
      		<td width="590" colspan="2"><span class="bct">&nbsp;&nbsp;&nbsp;</span>
      			<a class="bctl" href="StoreCatalogDisplay?storeId=<%=storeId%>&catalogId=<%=catalogId%>&langId=<%=languageId%>"><%=storeText.getString("Breadcrumb_CommercePlaza")%></a><span class="bct">&nbsp;&nbsp;&nbsp;&gt;&nbsp;&nbsp;&nbsp;</span>
      			<font class="bct"><%=storeText.getString("Breadcrumb_ShopCart")%></font>
      		</td>
        </tr>
        <tr>
          <td valign="top" width="320">
            <div align="left"><span class="title"><%=storeText.getString("PartialTransferShopCartDisplay_Title")%></span></div>
            <div align="left"><span class="subtitle"><%=order.getDescription()%></span></div>            
      		</td>
          <td valign="top" width="280">
            <div align="right"><img src="<%=fileDir%>images/hdr_cart.gif" width="280" height="72" alt='<%=storeText.getString("PartialTransferShopCartDisplay_Title")%>' /></div>
      		</td>
        </tr>
        </tbody>
    	</table>
      <table width="590" border="0" cellspacing="0" cellpadding="0">
        <tbody>
        <!-- start of main display body -->
        <tr>
          <td> 
          	<span class="subtitle"><%=storeText.getString("PartialTransferShopCartDisplay_Price_Inquiry_Response")%>
    				<%=TimestampHelper.getDateFromTimestamp(order.getLastUpdateInEJBType(),locale)%>
    				<%=order.getLastUpdateInEJBType().toString().substring(11,16)%>
    			  </span>
          </td>
        </tr>
        <tr> 
          <td>&nbsp;&nbsp;</td>
        </tr>
        <tr> 
          <td class="bbg"><img src="<%=fileDir%>images/c.gif" width="1" height="2" class="imgHeightFix" /></td>
        </tr>
        <tr>
          <td>&nbsp;</td>
        </tr>
    <!-- start processing of "submission" orders -->
    <%
    	childOrders = order.getChildOrders(distIdList, "submission");
      int ordersDisplayed = 0;    
    	for (int i=0; i < childOrders.length; i++) {   
    		childOrder = childOrders[i];

      	String status = childOrder.getStatus();
        
        if(status.equals("F") || status.equals("H")) {
          ordersDisplayed++;
          String storePhone1 = null;
          String distributorName = null;
          String extURL = null;
          String distURL = null;
      
          StoreEntityDataBean storeEntity = new StoreEntityDataBean();
      		storeEntity.setDataBeanKeyStoreEntityId(childOrder.getStoreEntityId());
          com.ibm.commerce.beans.DataBeanManager.activate(storeEntity, request);
          Integer iLangId = Integer.valueOf(languageId);  
          StoreEntityDescriptionAccessBean storeDesc = storeEntity.getDescription(iLangId);
          distributorName = storeDesc.getDisplayName();
          String contactAddressId = storeDesc.getContactAddressId();
          if (contactAddressId != null)
          {
            StoreAddressDataBean storeAddressDB = new StoreAddressDataBean();
            storeAddressDB.setDataBeanKeyStoreAddressId(contactAddressId);
            com.ibm.commerce.beans.DataBeanManager.activate(storeAddressDB, request);
            storePhone1 = storeAddressDB.getPhone1();
            distURL = storeAddressDB.getURL();
          }
          
          try {
            OrderReleaseDataBean orderRelease = new OrderReleaseDataBean();
            orderRelease.setDataBeanKeyOrdersId( childOrder.getOrderId() );
            orderRelease.setDataBeanKeyOrderReleaseNum( childOrder.getOrderItemDataBeans()[0].getOrderReleaseNumber());
            com.ibm.commerce.beans.DataBeanManager.activate(orderRelease, request);    
  
            extURL = orderRelease.getExternalReference();          
          } catch(Exception e) {
            out.println("<!-- Exception caught (extURL) : " + e + " -->");
          }
          
        	if (extURL != null && !extURL.equals("") && !extURL.equals("null") )  {  		  %>
        <tr> 
          <td>
            <b><%=storeText.getString("PartialTransferShopCartDisplay_Status_Submitted")%></b><br />
            <b><%=storeText.getString("PartialTransferShopCartDisplay_Action")%></b>
    			  <%=storeText.getString("PartialTransferShopCartDisplay_Status_Submitted_Text")%>
    		  </td>
        </tr>
   <%     } else { %>
        <tr> 
          <td>
            <b><%=storeText.getString("PartialTransferShopCartDisplay_Status")%> <%=storeText.getString("DistributorCartDetails_SubmissionNotConfirmed")%></b><br />
            <b><%=storeText.getString("PartialTransferShopCartDisplay_Action")%></b>
    			  <%=storeText.getString("ShopcartOrderConfirmation_NotConfirmCall", distributorName, storePhone1 )%>
    		  </td>
        </tr>
   <%     } %>
        <tr> 
          <td>&nbsp;&nbsp;</td>
        </tr>        
        <tr> 
          <td> 
            <table cellpadding="2" cellspacing="0" border="0" width="590">
              <tr class="tdblue"> 
<%        if ((distURL!=null)&&(distURL.length()>0)) { %>              
                <td width="300" class="tdblue"><a href="ExitToDistributorSiteDisplayView?storeId=<%=storeId%>&langId=<%=languageId%>&forwardURL=<%=java.net.URLEncoder.encode(distURL)%>" target="_blank"><span class="small" style="font-weight: bold; color: #ffffff; text-decoration: underline"><%=storeEntity.getDescription(new Integer(languageId)).getDisplayName()%></span></a></td>
<%        } else { %>
                <td width="300" class="tdblue"><span class="small" style="font-weight: bold; color: #ffffff; text-decoration: underline"><%=storeEntity.getDescription(new Integer(languageId)).getDisplayName()%></span></td>
<%        } %>                
              </tr>
    	      </table>
          </td>
        </tr>
        <tr> 
          <td> 
            <table width="590" cellpadding="2" border="0" cellspacing="1">
              <tr valign="top"> 
                <th width="75" valign="top" id="th1" class="mbg"><span class="small" style="font-weight: bold"><%=storeText.getString("PartialTransferShopCartDisplay_Distributor_SKU")%></span></th>
                <th width="75" valign="top" id="th2" class="mbg"><span class="small" style="font-weight: bold"><%=storeText.getString("PartialTransferShopCartDisplay_IBM_Part_Number")%></span></th>
                <th width="250" valign="top" id="th3" class="mbg"><span class="small" style="font-weight: bold"><%=storeText.getString("PartialTransferShopCartDisplay_Description")%></span></th>
      		<th width="75" valign="top" id="th4" class="mbg"><span class="small" style="font-weight: bold"><%=storeText.getString("PartialTransferShopCartDisplay_Distributors_Price")%></span></th>
                <th width="50" valign="top" id="th5" class="mbg"><span class="small" style="font-weight: bold"><%=storeText.getString("PartialTransferShopCartDisplay_Order_Quantity")%></span></th>
                <th width="75" valign="top" id="th6" class="mbg"><span class="small" style="font-weight: bold"><%=storeText.getString("PartialTransferShopCartDisplay_Line_Total")%></span></th>
              </tr>
<%  		  childOrderItems = childOrder.getOrderItemDataBeans();
      		for (int j = 0; j < childOrderItems.length ; j++ ) {
      			childOrderItem = childOrderItems[j];   %>
              <tr>
        	<td valign="top" headers="th1"><span class="small"><%=childOrderItem.getSupplierPartNumber()%></span></td>
              	<td valign="top" headers="th2"><a href="ProductDisplay?storeId=<%=storeId%>&langId=<%=languageId%>&productId=<%=childOrderItem.getCatalogEntryId()%>"><span class="small"><%=childOrderItem.getPartNumber()%></span></a></td>
                <td valign="top" headers="th3"><span class="small"><%=childOrderItem.getCatalogEntry().getDescription().getShortDescription()%></span></td>
                <td align="right" valign="top" headers="th4"><span class="small"><%=childOrderItem.getPriceDataBean()%></span></td>
              	<td valign="top" headers="th5"><span class="small"><%=childOrderItem.getFormattedQuantity() %></span></td>
                <td align="right" valign="top" headers="th6"><span class="small"><%=childOrderItem.getPerItemTotalPrice().toString()%></span></td>
        	    </tr>
<%   		  } // end for loop for child order item   %>
      		    <tr>	
                  <td colspan="7" class="gbg"></td>
              </tr>
              <tr> 
                <td colspan="4">&nbsp;</td>
                <td valign="top"><span class="small"><strong><%=storeText.getString("PartialTransferShopCartDisplay_Subtotal")%></strong></span></td>
                <td align="right" valign="top"><span class="small"><strong><%=childOrder.getSubTotal()%></strong></span></td>
              </tr>
            </table>
          </td>
        </tr>
<%	      if (extURL != null && !extURL.equals("") && !extURL.equals("null") ) {  %>
        <tr align="left"> 
          <td> 
            <table cellpadding="0" border="0" cellspacing="0">
              <tr> 
                <td><a href="ExitToDistributorSiteDisplayView?storeId=<%=storeId%>&langId=<%=languageId%>&forwardURL=<%=java.net.URLEncoder.encode(extURL)%>" target="_blank"><img src="<%=fileDir%><%=locale.toString()%>/images/b_opendistcart.gif" height="21" border="0" alt="<%=storeText.getString("Alt_OpenDistCart")%>"></a></td>
              </tr>
            </table>
          </td>
        </tr>
<%        }      %>
        <tr> 
          <td>&nbsp;&nbsp;</td>
        </tr>
<%      } // end if status=='F'
     	} // end for loop for submission orders
     	if( ordersDisplayed>0 ) {    %>
        <tr> 
          <td class="bbg"><img src="<%=fileDir%>images/c.gif" width="1" height="2" class="imgHeightFix" /></td>
        </tr>
        <tr>
          <td>&nbsp;</td>
        </tr>                
        <!-- end processing of "submission" orders -->        
<%    }   %>        
        <!-- start processing of "selection" orders and "not assigned" items -->
 <%   childOrders = order.getChildOrders(distIdList, "selection");
      int untransferredOrders = childOrders.length;
      String sectionTitle="";
      if(( untransferredOrders > 0 )&&(unassignedItemCount>0) ) {
        sectionTitle = storeText.getString("PartialTransferShopCartDisplay_Status_Not_Submitted_and_Not_Assigned");
      } else {
        if( untransferredOrders > 0 )
          sectionTitle = storeText.getString("PartialTransferShopCartDisplay_Status_Not_Submitted");
        else if( unassignedItemCount>0)
          sectionTitle = storeText.getString("PartialTransferShopCartDisplay_Status_Not_Assigned");      
      }
    
      //Title section
      if ((untransferredOrders>0)&& (emptyChannelCart)) { %>
      
      <tr align="right"> 
          <td> &nbsp;</td>
        </tr>
         <tr> 
          <td colspan=6>
            <B><%=sectionTitle%></B><br>
            <B><%=storeText.getString("PartialTransferShopCartDisplay_Action")%></B>
    			  <%=storeText.getString("PartialTransferShopCartDisplay_CreateNew_Text")%>
          </td>
        </tr>
      <% }
      else if( (untransferredOrders>0)||(unassignedItemCount>0)) { %>
        <!-- UntransferredOrders : <%=untransferredOrders%> -->
        <!-- UnassignedItemCount : <%=unassignedItemCount%> -->
        <tr> 
          <td>
            <b><%=sectionTitle%></b><br />
            <b><%=storeText.getString("PartialTransferShopCartDisplay_Action")%></b>
    			  <%=storeText.getString("PartialTransferShopCartDisplay_Activate_Text")%>
          </td>
        </tr>
<%    }     
      if( childOrders.length > 0 ) { 
        int selectionOrderItemCount=0;     %>
        <tr> 
          <td>&nbsp;&nbsp;</td>
        </tr>
<%   for (int i=0; i < childOrders.length; i++) {   
    		childOrder = childOrders[i];
    
    	  StoreEntityDataBean storeEntity = new StoreEntityDataBean();
    		storeEntity.setDataBeanKeyStoreEntityId(childOrder.getStoreEntityId());
    	  com.ibm.commerce.beans.DataBeanManager.activate(storeEntity, request);
    	  
    	  String orderItemMoveURL = "PartialTransferShopCartDisplayView?forStoreId=&langId="+languageId+"&catalogId="+catalogId+"&orderId="+orderId;
    	  String orderItemMove = "OrderItemMove?fromOrderItemId=*" + 
    	                         "&fromOrderId=" + childOrder.getOrderId() + 
    	                         "&deleteIfEmpty=" + childOrder.getOrderId() + 
    	                         "&forStoreId=" + childOrder.getStoreEntityId() + 
    	                         "&URL=" + java.net.URLEncoder.encode(orderItemMoveURL);
 %>
        <form name="RemoveSelectionOrder_<%=i%>" action="OrderItemUpdate" method="post">
        <input type="hidden" name="URL" value="<%=orderItemMove%>" />
        <input type="hidden" name="catalogId" value="<%=catalogId%>" />
        <input type="hidden" name="allocate" value="*n" />
        <input type="hidden" name="reverse" value="*n" />
        <input type="hidden" name="backorder" value="*n" />
        <input type="hidden" name="check" value="*n" />
        <input type="hidden" name="merge" value="*n" />
        <input type="hidden" name="remerge" value="*n" />   
        <tr> 
          <td> 
            <table cellpadding="2" cellspacing="0" border="0" width="590">
              <tr  class="tdblue"> 
    <%  String distURL = null;

        Integer iLangId = Integer.valueOf(languageId);  
        StoreEntityDescriptionAccessBean storeDesc = storeEntity.getDescription(iLangId);
        String contactAddressId = storeDesc.getContactAddressId();
        if (contactAddressId != null)
        {
          StoreAddressDataBean storeAddressDB = new StoreAddressDataBean();
          storeAddressDB.setDataBeanKeyStoreAddressId(contactAddressId);
          com.ibm.commerce.beans.DataBeanManager.activate(storeAddressDB, request);
          distURL = storeAddressDB.getURL();
        }
    %>
                <td width="300"><a href="ExitToDistributorSiteDisplayView?storeId=<%=storeId%>&langId=<%=languageId%>&forwardURL=<%=java.net.URLEncoder.encode(distURL)%>" target="_blank"><span class="small" style="font-weight: bold; color: #ffffff; text-decoration: underline"><%=storeEntity.getDescription(new Integer(languageId)).getDisplayName()%></span></a></td>
                <td align="right"> 
                  <table>
                    <tr> 
                      <td><a href="javascript:RemoveOrder(document.RemoveSelectionOrder_<%=i%>)"><span class="small" style="font-weight: bold; color: #ffffff; text-decoration: underline"><%=storeText.getString("PartialTransferShopCartDisplay_RemoveCart")%></span></a></td>
                      <td><a href="javascript:RemoveOrder(document.RemoveSelectionOrder_<%=i%>)"><img src="<%=fileDir%>images/icn_trash.gif" border="0" alt='<%=storeText.getString("PartialTransferShopCartDisplay_RemoveCart")%>' width="12" height="14" /></a></td>
                    </tr>
                  </table>
                </td>
              </tr>
            </table>
          </td>
        </tr>
        <tr class="tdblue"> 
          <td align="right"></td>
        </tr>
        <tr> 
          <td> 
            <table width="590" cellpadding="2" border="0" cellspacing="1">
              <tr valign="top"> 
                <th width="75" valign="top" id="th2_1" class="mbg"><span class="small" style="font-weight: bold"><%=storeText.getString("PartialTransferShopCartDisplay_Distributor_SKU")%></span></th>
                <th width="75" valign="top" id="th2_2" class="mbg"><span class="small" style="font-weight: bold"><%=storeText.getString("PartialTransferShopCartDisplay_IBM_Part_Number")%></span></th>
                <th width="250" valign="top" id="th2_3" class="mbg"><span class="small" style="font-weight: bold"><%=storeText.getString("PartialTransferShopCartDisplay_Description")%></span></th>
                <th width="75" valign="top" id="th2_4" class="mbg"><span class="small" style="font-weight: bold"><%=storeText.getString("PartialTransferShopCartDisplay_Distributors_Price")%></span></th>
                <th width="50" valign="top" id="th2_5" class="mbg"><span class="small" style="font-weight: bold"><%=storeText.getString("PartialTransferShopCartDisplay_Order_Quantity")%></span></th>
                <th width="75" valign="top" id="th2_6" class="mbg"><span class="small" style="font-weight: bold"><%=storeText.getString("PartialTransferShopCartDisplay_Line_Total")%></span></th>
              </tr>
    <%
    		childOrderItems = childOrder.getOrderItemDataBeans();
    
    		for (int j = 0; j < childOrderItems.length ; j++ ) {
    			childOrderItem = childOrderItems[j];
    			OrderItemDataBean [] parentItems = childOrderItem.getParentItems();
    			if (parentItems != null && parentItems.length > 0)
    			{  
    			  /* If parentItems is not null, there are still order items in the channel order.
    			  *  In this case, the quantity of the orderitem in the channel order needs to be reduced once the 'not submitted' order is removed.
    			   *  The adjusted quantity is calculated below, and OrderItemUpdate is used to update the channel order item will this quantity
    			   */
    			  double newQuantity = parentItems[0].getQuantityInEJBType().doubleValue() - childOrderItem.getQuantityInEJBType().doubleValue();
    %>
              <input type="hidden" name="orderItemId_<%=(i+1)%>" value="<%=parentItems[0].getOrderItemId()%>" />
              <input type="hidden" name="quantity_<%=(i+1)%>" value="<%=newQuantity%>" />
          <%
          }
          %> 
              <tr>
                <td valign="top" headers="th2_1"><span class=small><%=childOrderItem.getSupplierPartNumber()%></span></td>
                <td valign="top" headers="th2_2"><a href="ProductDisplay?storeId=<%=storeId%>&langId=<%=languageId%>&productId=<%=childOrderItem.getCatalogEntryId()%>"><span class=small><%=childOrderItem.getPartNumber()%></span></a></td>
                <td valign="top" headers="th2_3"><span class=small><%=childOrderItem.getCatalogEntry().getDescription().getShortDescription()%></span></td>
                <td align="right" valign="top" headers="th2_4"><span class=small><%=childOrderItem.getPriceDataBean()%></span></td>
                <td valign="top" headers="th2_5"><span class=small><%=childOrderItem.getFormattedQuantity() %></span></td>
                <td align="right" valign="top" headers="th2_6"><span class=small><%=childOrderItem.getPerItemTotalPrice().toString()%></span></td>
              </tr>
    <%
      selectionOrderItemCount++;
    		} // end for loop for child order item
    %>
      		    <tr>	
                <td class="gbg"></td>
              </tr>
              <tr> 
                <td colspan="4">&nbsp;</td>
                <td><span class="small"><strong><%=storeText.getString("PartialTransferShopCartDisplay_Subtotal")%></strong></span></td>
                <td align="right"><span class="small"><strong><%=childOrder.getSubTotal()%></strong></span></td>
              </tr>
            </table>
          </td>
        </tr>
        </form>
  <%	} // end for loop for selection orders   	
    }
      /* Behavior of order activate, if current pending cart is :
         1) Unsaved & empty     : make this cart current pending 
         2) Saved               : copy items into a new cart, set that cart to be current
         3) Unsaved, not empty  : give use option of appending or saving existing
      */ 
      
      String currOrderId = "xxx";
      
      try {
        CurrentPendingOrderDataBean currPendOrder = new CurrentPendingOrderDataBean();
        Enumeration currResults = currPendOrder.findByMemberAndStore( cmdcontext.getUserId(), cmdcontext.getStoreId() );  
      if (currResults.hasMoreElements())
         {
        CurrentPendingOrderAccessBean currOrder = (CurrentPendingOrderAccessBean)currResults.nextElement();
        currOrderId = currOrder.getOrderId();
         }
        else
         currOrderId = orderId; 
      } catch( Exception e) { 
        out.println("<!-- Exception caught (currPendingOrder) : " + e + " -->");
      }
      out.println("<!-- Current pending order ID : " + currOrderId + " -->");
      
      OrderDataBean parentOrder = new OrderDataBean();
      parentOrder.setOrderId(currOrderId);
      com.ibm.commerce.beans.DataBeanManager.activate(parentOrder, request);      
      
      String parentDescription = parentOrder.getDescription();
      int parentOrderItems = parentOrder.getOrderItemDataBeans().length;
      
      out.println("<!-- Shopcart :" + parentDescription + ":(" + parentOrder.getOrderId() + ") has " + parentOrderItems + " items -->");

    /* 
    If the channel cart is empty and there are still untransferred orders, a "Create new cart" button will be shown.
    Also, if the current pending cart is unsaved and not empty, a "Save current cart" button will be shown as well.
    */
    if ((untransferredOrders>0)&& (emptyChannelCart)) { 
  %>
      <tr align="left"> 
        <td> 
          <table cellpadding="0" border="0" cellspacing="0">
            <tr> 
              <td><a href="javascript:ActivateNewCart(document.CreateNewCart)"><img src="<%=fileDir%><%=locale.toString()%>/images/b_shopcart_new.gif" height="21" border="0" alt="<%=storeText.getString("PartialTransferShopCartDisplay_CreateNew")%>"></a></td>
            </tr>
          </table>
        </td>
      </tr>
  <%
     if( ((parentDescription==null)||(parentDescription.length()==0)) && (parentOrderItems>0) ) 
     {  
        // create a URL to pass downstream to ShopCartSaveForm.jsp to redirect back to PartialTransferShopCartDisplayView, after saving.
        String  tempURL = "PartialTransferShopCartDisplayView?orderId=" + orderId;
        String  partialCartURL = java.net.URLEncoder.encode(tempURL);
  %>
      <tr align="left"> 
        <td> 
          <table cellpadding="2" border="0" cellspacing="0">
            <tr>               
              <td><a href="ShopCartSaveFormView?orderId=<%=currOrderId%>&catalogId=<%=catalogId%>&URL=<%=partialCartURL%>"><img src="<%=fileDir%>images/arrow_rd.gif" width="23" height="23" border="0" alt="<%=storeText.getString("PartialTransferShopCartDisplay_CreateNew")%>"></a></td>
              <td><a href="ShopCartSaveFormView?orderId=<%=currOrderId%>&catalogId=<%=catalogId%>&URL=<%=partialCartURL%>"><%=storeText.getString("PartialTransferShopCartDisplay_SaveCart")%></a></td>
            </tr>
          </table>
        </td>
      </tr>   
   <%
      } 
    }
   %>        
    <!-- end processing of "selection" orders -->
         <!-- code to check empty channel cart with unsubmitted distributor orders -->
     <!-- Create a new order, copy items from all unsubmitted distributor carts-->
     <!-- to it, Set this as pending order and delete the unsubmitted          -->
     <!-- distributor order and then display the newly created order           -->
                                                         
 <%     if ((emptyChannelCart) && ( untransferredOrders > 0 )) { 
          String url1 = "SetPendingOrder?URL=";
          String url2 = "OrderQuotationRequest?orderId="+ orderId + "&deleteOrderQuotationRelId=*selection*parent" + orderId + "&URL=";
          String url3 = "OrderItemDisplay?orderId=.";
          String orderCopyURL = url1 + java.net.URLEncoder.encode(url2 + java.net.URLEncoder.encode(url3));
                     
 %>
      
       <table border="0" cellspacing="0" cellpadding="0" width="590">
		      <tbody>
  		  <form NAME="CreateNewCart" action="OrderCopy" method="POST">
		  <input type="hidden" name="storeId" value="<%=storeId%>">
		  <input type="hidden" name="langId" value="<%=languageId%>">
		  <input type="hidden" name="catalogId" value="<%=catalogId%>">
		  <input type="hidden" name="catalogId" value="<%=catalogId%>">
		  <input type="hidden" name="URL" value="<%=orderCopyURL%>">
		  <input type="hidden" name="outOrderName" value="orderId">
		  <input type="hidden" name="allocate" value="*n">
		  <input type="hidden" name="reverse" value="*n">
		  <input type="hidden" name="backorder" value="*n">
		  <input type="hidden" name="check" value="*n">
		  <input type="hidden" name="merge" value="*n">
	  	  <input type="hidden" name="remerge" value="*n">	
	  	  <input type="hidden" name="fromOrderId" value="<%=orderId%>">	
	  		
		<% 
	  		
     		 if( childOrders.length > 0 ) { 
           	   for (int i=0; i < childOrders.length; i++) {   
                      out.println("<!-- fromOrderId_" + (i + 1) + " " + childOrder.getOrderId() + " -->");   
   		%>
	  	  <input type="hidden" name="fromOrderId_<%= (i + 1)%>" value="<%=childOrder.getOrderId()%>">      	
	  	  <input type="hidden" name="copyOrderItemId_<%= (i + 1)%>" value="*">      	
	  	   	  	  
                <% 
      		 }
      		} 
    
                %>
	  		
  </form>
 <% 
  }
  %>
        <!-- end code to check empty channel cart with unsubmitted distributor orders -->
   
    <!-- start processing of unassigned orders -->
    <form name="OneUnassignedItem" action="OrderItemUpdate" method="post">
    <input type="hidden" name="URL" value="<%=returnURL%>" />
    <input type="hidden" name="orderItemId_1" value="xxx" />
    <input type="hidden" name="quantity_1" value="yyy" />
    <input type="hidden" name="storeId" value="<%=storeId%>" />
    <input type="hidden" name="catalogId" value="<%=catalogId%>" />
    <input type="hidden" name="allocate" value="*n" />
    <input type="hidden" name="reverse" value="*n" />
    <input type="hidden" name="backorder" value="*n" />
    <input type="hidden" name="check" value="*n" />
    <input type="hidden" name="merge" value="*n" />
    <input type="hidden" name="remerge" value="*n" />   
    </form>


        <form name="RemainingItems" action="SetPendingOrder" method="post">
        <input type="hidden" name="URL" value="OrderItemDisplay?check=*n&langId=<%=languageId%>&storeId=<%=cmdcontext.getStoreId()%>&catalogId=<%=catalogId%>&orderId=." />
        <input type="hidden" name="langId" value="<%=languageId%>" />
        <input type="hidden" name="storeId" value="<%=cmdcontext.getStoreId()%>" />
        <input type="hidden" name="orderId" value="<%=orderId%>" />
        </form>   		  
<%   	if( unassignedItemCount > 0 ) {    %>
        <tr> 
          <td>&nbsp;&nbsp;</td>
        </tr>
        <tr> 
          <td> 
            <table cellpadding="2" cellspacing="0" border="0" width="590">
              <tr class="tdblue"> 
                <td><span class="small" style="font-weight: bold; color: #ffffff"><%=storeText.getString("PartialTransferShopCartDisplay_Not_Assigned")%></span></td>
                <td align="right"> 
                  <table>
                    <tr> 
                      <td class="tdblue"><a href="javascript:RemoveAllUnassignedItems()"><span class="small" style="font-weight: bold; color: #ffffff; text-decoration: underline"><%=storeText.getString("PartialTransferShopCartDisplay_Remove_All")%></span></a></td>
                      <td class="tdblue"><a href="javascript:RemoveAllUnassignedItems()"><img src="<%=fileDir%>images/icn_trash.gif" border="0" alt='<%=storeText.getString("PartialTransferShopCartDisplay_Remove_All")%>' width="12" height="14" /></a></td>
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
              <tr valign="top">
                <th width="20" valign="top" id="th3_1" class="mbg"><span class="small" style="font-weight: bold"><%=storeText.getString("PartialTransferShopCartDisplay_Quantity")%></span></th>
                <th width="73" valign="top" id="th3_2" class="mbg"><span class="small" style="font-weight: bold"><%=storeText.getString("PartialTransferShopCartDisplay_IBM_Part_Number")%></span></th>
                <th width="146" valign="top" id="th3_3" class="mbg"><span class="small" style="font-weight: bold"><%=storeText.getString("PartialTransferShopCartDisplay_Description")%></span></th>
                <th width="80" valign="top" id="th3_4" class="mbg"><span class="small" style="font-weight: bold"><%=storeText.getString("PartialTransferShopCartDisplay_IBM_List_Price")%></span></th>
                <th width="91" colspan="2" valign="top" id="th3_5" class="mbg"><div align="center"><span class="small" style="font-weight: bold"><%=storeText.getString("PartialTransferShopCartDisplay_Line_Total")%></span></div></th>
              </tr>
              <form name="AllUnassignedItems" action="OrderItemUpdate" method="post">
              <input type="hidden" name="URL" value="<%=returnURL%>" />
              <input type="hidden" name="storeId" value="<%=storeId%>" />
              <input type="hidden" name="catalogId" value="<%=catalogId%>" />
              <input type="hidden" name="allocate" value="*n" />
              <input type="hidden" name="reverse" value="*n" />
              <input type="hidden" name="backorder" value="*n" />
              <input type="hidden" name="check" value="*n" />
              <input type="hidden" name="merge" value="*n" />
              <input type="hidden" name="remerge" value="*n" />   
<%      for( int vloop=0; vloop<unassignedItems.size();vloop++) {
          orderItem = (OrderItemDataBean)(unassignedItems.elementAt(vloop));
          long itemQuantity = orderItem.getQuantityInEJBType().longValue() - Long.parseLong(orderItem.getField2());

          BigDecimal qty = new BigDecimal( orderItem.getField2() );
          BigDecimal price = orderItem.getPriceDataBean().getAmount();
          BigDecimal lineprice = price.multiply(qty);
          FormattedMonetaryAmountDataBean fma = new FormattedMonetaryAmountDataBean();
          fma.setAmount(lineprice);
          fma.setCurrency(cmdcontext.getCurrency());
          fma.setLangId(cmdcontext.getLanguageId());
          com.ibm.commerce.beans.DataBeanManager.activate(fma, request);
          String lineTotal = fma.toString();      %>    
              <input type="hidden" name="orderItemId_<%=(vloop+1)%>" value="<%=orderItem.getOrderItemId()%>" />
              <input type="hidden" name="quantity_<%=(vloop+1)%>" value="<%=itemQuantity%>" />
              <tr>
              	<td height="13" valign="top" headers="th3_1"><span class="small"><%=orderItem.getField2()%></span></td>
              	<td height="13" valign="top" headers="th3_2"><a href="ProductDisplay?storeId=<%=storeId%>&langId=<%=languageId%>&productId=<%=orderItem.getCatalogEntryId()%>"><span class="small"><%=orderItem.getPartNumber()%></span></a></td>
                <td height="13" valign="top" headers="th3_3"><span class="small"><%=orderItem.getCatalogEntry().getDescription().getShortDescription()%></span></td>
         		<td height="13" align="right" valign="top" headers="th3_4"><span class="small"><%=orderItem.getPriceDataBean()%></span></td>
                <td height="13" align="right" valign="top" headers="th3_5">
                  <table cellspacing="0" cellpadding="0">
                    <tr valign="top">
                      <td align="right" valign="top"><span class="small"><%=lineTotal%></span></td>
                      <td align="right" valign="top"><a href="javascript:RemoveUnassignedItem(OneUnassignedItem,<%=orderItem.getOrderItemId()%>,<%=itemQuantity%>)"><img src="<%=fileDir%>images/icn_trash.gif" border="0" alt='<%=storeText.getString("YourOrder_Remove")%>' align="top" /></a></td>
                    </tr>
                  </table>
 		      </td>
          	  </tr>
          	  <%    } // end for   %>
              </form>
              <tr>	
                <td colspan="7" class="gbg"></td>
              </tr>
            </table>
          </td>
        </tr>
        <tr>
          <td><img src="<%=fileDir%>images/c.gif" width="1" height="10" /></td>
        </tr>
 <%  	} /* end if  for unassigned */   
     if (!emptyChannelCart)  {  
      if(( untransferredOrders > 0 )||(unassignedItemCount>0) ) {        
        if( ((parentDescription==null)||(parentDescription.length()==0)) && (parentOrderItems>0) ) { %>        
        <tr align="left"> 
          <td> 
            <table cellpadding="2" border="0" cellspacing="0">
              <tr>               
                <td><a href="ShopCartActivateDisplayView?orderId=<%=orderId%>&catalogId=<%=catalogId%>&storeId=<%=storeId%>&langId=<%=languageId%>"><img src="<%=fileDir%>images/arrow_rd.gif" width="23" height="23" border="0" alt='<%=storeText.getString("PartialTransferShopCartDisplay_Activate")%>' /></a></td>
                <td><a href="ShopCartActivateDisplayView?orderId=<%=orderId%>&catalogId=<%=catalogId%>&storeId=<%=storeId%>&langId=<%=languageId%>"><%=storeText.getString("PartialTransferShopCartDisplay_Activate")%></a></td>
              </tr>
            </table>
          </td>
        </tr>
  <%    } else { %>
        <tr align="left"> 
          <td> 
            <table cellpadding="2" border="0" cellspacing="0">
              <tr> 
                <td><a href="javascript:ActivateShoppingCart(document.RemainingItems)"><img src="<%=fileDir%>images/arrow_rd.gif" width="23" height="23" border="0" alt='<%=storeText.getString("PartialTransferShopCartDisplay_Activate")%>' /></a></td>
                <td><a href="javascript:ActivateShoppingCart(document.RemainingItems)"><%=storeText.getString("PartialTransferShopCartDisplay_Activate")%></a></td>
              </tr>
            </table>
          </td>
        </tr>
  <%    }
      }
     }  %>
        <tr>
          <td><img src="<%=fileDir%>images/c.gif" width="1" height="10" /></td>
        </tr>
        <tr> 
          <td class="bbg"><img src="<%=fileDir%>images/c.gif" width="1" height="2" class="imgHeightFix" /></td>
        </tr>
        <tr>
          <td><img src="<%=fileDir%>images/c.gif" width="1" height="10" /></td>
        </tr>
        <tr> 
        	<td>
          <table cellpadding="2" border="0" cellspacing="0">
            <tr> 
              <td><a href="PendingShopCartsDisplayView?storeId=<%=storeId%>&langId=<%=languageId%>&catalogId=<%=catalogId%>&orderId=*"><img src="<%=fileDir%>images/arrow_ld.gif" width="23" height="23"  border="0" alt='<%=storeText.getString("PartialTransferShopCartDisplay_Return")%>' /></a></td>
              <td><a href="PendingShopCartsDisplayView?storeId=<%=storeId%>&langId=<%=languageId%>&catalogId=<%=catalogId%>&orderId=*"><%=storeText.getString("PartialTransferShopCartDisplay_Return")%></a></td>
            </tr>
            <tr>
              <td colspan="2"><img src="<%=fileDir%>images/c.gif" width="1" height="10" /></td>
            </tr>
          </table>
          </td>
        </tr>
      </tbody>
      </table>
      
   
<!-- End Main Table -->
</td>
</tr>
</tbody>
</table>
<!-- Start Footer -->
<%@ include file="../../../include/FooterDisplay.jspf"%>
<!-- End Footer -->
</body>
</html>
