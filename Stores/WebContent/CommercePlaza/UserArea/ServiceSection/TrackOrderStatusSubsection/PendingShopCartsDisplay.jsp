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


<% // All JSPs requires the first 4 packages for EnvironmentSetup.jsp which is used for multi language support %> 
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.ibm.commerce.server.*" %>
<%@ page import="com.ibm.commerce.command.*" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="com.ibm.commerce.user.beans.*" %>
<%@ page import="com.ibm.commerce.user.objects.*" %>
<%@ page import="com.ibm.commerce.order.beans.*" %>
<%@ page import="com.ibm.commerce.order.objects.*" %>
<%@ page import="com.ibm.commerce.common.beans.*" %>
<%@ page import="com.ibm.commerce.common.objects.*" %>
<%@ page import="com.ibm.commerce.price.beans.*" %>
<%@ page import="com.ibm.commerce.contract.beans.*" %>
<%@ page import="com.ibm.commerce.contract.objects.*" %>
<%@ page import="com.ibm.commerce.utils.TimestampHelper" %>
<%@ page import="com.ibm.commerce.inventory.beans.OrderReleaseDataBean" %>
<%@ page import="com.ibm.commerce.catalog.common.ECCatalogConstants" %>

<%@ include file="../../../include/EnvironmentSetup.jsp"%>

<% response.setContentType(storeText.getString("ENCODESTATEMENT")); %>
<%
	request.setAttribute("pageName", "PendingShoppingCarts");
	
        String orderRn = jhelper.getParameter("orderId");
        String currentPage=jhelper.getParameter("currentPage");
        int currentPageNumber=1;
	if (currentPage==null) {
	  currentPageNumber=1;
	} else {
          Integer page_Number= new Integer(currentPage);
          currentPageNumber = page_Number.intValue();
        
          if (currentPageNumber<1)
          {
          currentPageNumber=1;
          }
        }
        int pageSize=10; //how many pending carts in one page
        int totalPage=0; //initialize
        int total=0; //initialize
        	
       	// Get the current Year/Month/Date
	Calendar NOW = Calendar.getInstance();

        //default values for from YYYY-MM-DD and to YYYY-MM-DD, one month up to today
        String fromYYYY = jhelper.getParameter("fromYYYY");
        if (fromYYYY==null) { fromYYYY=""+NOW.get(Calendar.YEAR); }
        String fromMM = jhelper.getParameter("fromMM");
        if (fromMM==null) { 
        	if (NOW.get(Calendar.MONTH)==0) //January, set fromMM to last Dec
        	{
        		fromMM="12";
        		fromYYYY=""+(NOW.get(Calendar.YEAR) - 1);
        	} else {
                	fromMM=""+NOW.get(Calendar.MONTH); 
                }
        }
        String fromDD = jhelper.getParameter("fromDD");
        if (fromDD==null) { fromDD=""+NOW.get(Calendar.DATE);; }
        String toYYYY = jhelper.getParameter("toYYYY");
        if (toYYYY==null) { toYYYY=""+NOW.get(Calendar.YEAR); }
        String toMM = jhelper.getParameter("toMM");
        if (toMM==null) { toMM=""+(NOW.get(Calendar.MONTH) + 1); }
        String toDD = jhelper.getParameter("toDD");
        if (toDD==null) { toDD=""+NOW.get(Calendar.DATE); }
        
        FormattedMonetaryAmountDataBean formattedTotalPrice = null;
        FormattedMonetaryAmountDataBean formattedAmount = null; 

        OrderListDataBean orderListBean = new OrderListDataBean(); //main list to hold all pending carts.
        
        OrderDataBean[] orders = new OrderDataBean[pageSize]; // used for each page

        // Quotation Orders
        OrderDataBean [] initialchildOrderbeans = new OrderDataBean[5];

        StoreEntityDataBean stEntDataBean = null;
        StoreEntityDescriptionAccessBean stEntDscAccessBean = null;
        String distributorName = null;

        Integer[] distIdList = cmdcontext.getStore().getRelatedStores("com.ibm.commerce.referral");
        
        OrderListDataBean dbOrderList = new OrderListDataBean();
        dbOrderList.setFetchCurrentPendingOrder(true);
        dbOrderList.setStoreId(cmdcontext.getStoreId());
        dbOrderList.setUserId(cmdcontext.getUserId());
        com.ibm.commerce.beans.DataBeanManager.activate(dbOrderList, request);
        OrderDataBean[] dbCurrentPendingOrders = dbOrderList.getOrderDataBeans();
        Set setCurrentPendingOrderIds = new HashSet();
        if(dbCurrentPendingOrders != null) {
        	for(int i = 0; i < dbCurrentPendingOrders.length; i++) {
        		setCurrentPendingOrderIds.add(dbCurrentPendingOrders[i].getOrderIdInEJBType());
        	}
        }
        System.out.println(setCurrentPendingOrderIds);
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "DTD/xhtml1-transitional.dtd">
<html>
<head>
  <title><%=storeText.getString("PendingShopCartsDisplay_Title")%></title>
  <link REL=stylesheet HREF="<%=fileDir%>PCDMarket.css" TYPE="text/css">
</head>

<script language="javascript">

        function ShopCartActivate(form)
        {
                form.action = 'ShopCartActivateDisplayView';
                form.submit();
        }

        function ShopCartDetail(form, newOrderRn, currentPendingOrder)
        {   
                form.orderRn.value=newOrderRn;
                if(currentPendingOrder) {
	                form.action = 'OrderItemDisplay';
	            }
	            else {
	                form.action = 'ShopCartDetailDisplayView';
	            }
                form.submit();
        }

        function ShopCartDelete(form)
        {
                form.action = 'ShopCartDeleteDisplayView';
                form.submit();
        }
        
        function setTimeRange(form1,num)
        {
                form1.currentPage.value=num;
                form1.submit();
        }

</script>

<body marginheight="0" marginwidth="0" leftmargin="0" topmargin="0">
<%@ include file="../../../include/HeaderDisplay.jspf"%>
<!-- Start Main Table - Consists of TD for Left Bar, TD for Content and TD for Quicklinks -->
<table border="0" cellpadding="0" cellspacing="0" width="750" height="99%">
<tr>
  <td valign="top" class="dbg" width="150"> 
      <% String incfile = includeDir + "SidebarDisplay.jsp"; %>
    <jsp:include page="<%=incfile%>" flush="true"/>
  </td>
  
  <td width="10"><a name="mainContent"></a><img height="1" alt="" src="<%=fileDir%>images/c.gif" /></td>

  <td valign="top" width="590">
    <!--START MAIN CONTENT-->

        <table width="590" border="0" cellspacing="0" cellpadding="0">
          <tbody>
              <tr>
              <td width="590" height="20" colspan="2"><span class="bct">&nbsp;&nbsp;&nbsp;</span>
                        <a class="bctl" href="StoreCatalogDisplay?storeId=<%=storeId%>&catalogId=<%=catalogId%>&langId=<%=languageId%>"><%=storeText.getString("Breadcrumb_CommercePlaza")%></a><span class="bct">&nbsp;&nbsp;&nbsp;&gt;&nbsp;&nbsp;&nbsp;</span>
                        <span class="bct"><%=storeText.getString("Breadcrumb_ShopCart")%></span>
              </td>
            </tr>
            <tr>
              <td valign="top" width="310">
                <div align="left" class="title">
                  <img src="<%=fileDir%>images/c.gif" width="1" height="11" border="0" /><br />
                  <%=storeText.getString("PendingShopCartsDisplay_Title")%>
                </div>
              </td>
              <td valign="top" width="280">
                <div align="right">
                <img src="<%=fileDir%>images/hdr_cart.gif" width="280" height="70" alt="<%=storeText.getString("PendingShopCartsDisplay_Title")%>"></div></td>
            </tr>
          </tbody>
        </table>
            
        <form name="PendingCarts">
        <input type="hidden" name="storeId" value="<%=storeId%>">
        <input type="hidden" name="catalogId" value="<%=catalogId%>">
        <input type="hidden" name="langId" value="<%=languageId%>">
        <input type="hidden" name="orderRn" value="">
        </form>          
 
        <form name="TimeRange" action="PendingShopCartsDisplayView" method="post">
        <input type="hidden" name="currentPage" value="">
        <table width="590" border="0" cellspacing="0" cellpadding="0">
          <tbody>
           <tr>
              <td>
                <%=storeText.getString("PendingShopCartsDisplay_Text")%><br /><br />
              </td>
            </tr>
            <tr>
              <td>
                <table>
                  <tr>
                    <td>&nbsp;</td>
                    <th><label for="date1"><%=storeText.getString("PendingShopCartsDisplay_Year")%></label></th>
                    <th><label for="date2"><%=storeText.getString("PendingShopCartsDisplay_Month")%></label></th>
                    <th><label for="date3"><%=storeText.getString("PendingShopCartsDisplay_Day")%></label></th>
                    <th>&nbsp;</th>
                    <th><label for="date4"><%=storeText.getString("PendingShopCartsDisplay_Year")%></label></th>
                    <th><label for="date5"><%=storeText.getString("PendingShopCartsDisplay_Month")%></label></th>
                    <th><label for="date6"><%=storeText.getString("PendingShopCartsDisplay_Day")%></label></th>
                  <tr>
                    <td><b><%=storeText.getString("PendingShopCartsDisplay_DisplayFrom")%></b></td>
                    <td> 
                    <select name="fromYYYY" id="date1">
                      <%
                      for (int i=0; i<12; i++) {
                      %>
                      <option value="<%= 2002+i %>" <% if (Integer.parseInt(fromYYYY)==(2002+i)) {%> selected <%}%> ><%= 2002+i %></option>
                      <%
                      }
                      %>
                    </select></td>
                    <td>
                    <select name="fromMM" id="date2">
                      <%
                      for (int i=0; i<12; i++) {
                      %>
                      <option value="<%= 1+i %>" <% if (Integer.parseInt(fromMM)==(1+i)) {%> selected <%}%> ><%= 1+i %></option>
                      <%
                      }
                      %>
                    </select></td>
                    <td>
                    <select name="fromDD" id="date3">
                      <%
                      for (int i=0; i<31; i++) {
                      %>
                      <option value="<%= 1+i %>" <% if (Integer.parseInt(fromDD)==(1+i)) {%> selected <%}%> ><%= 1+i %></option>
                      <%
                      }
                      %>
                    </select></td>
                    <td><b><%=storeText.getString("PendingShopCartsDisplay_To")%></b></td>
                    <td> 
                    <select name="toYYYY" id="date4">
                      <%
                      for (int i=0; i<12; i++) {
                      %>
                      <option value="<%= 2002+i %>" <% if (Integer.parseInt(toYYYY)==(2002+i)) {%> selected <%}%> ><%= 2002+i %></option>
                      <%
                      }
                      %>
                    </select></td>
                    <td>
                    <select name="toMM" id="date5">
                      <%
                      for (int i=0; i<12; i++) {
                      %>
                      <option value="<%= 1+i %>" <% if (Integer.parseInt(toMM)==(1+i)) {%> selected <%}%> ><%= 1+i %></option>
                      <%
                      }
                      %>
                    </select></td>
                    <td>
                    <select name="toDD" id="date6">
                      <%
                      for (int i=0; i<31; i++) {
                      %>
                      <option value="<%= 1+i %>" <% if (Integer.parseInt(toDD)==(1+i)) {%> selected<%}%> ><%= 1+i %></option>
                      <%
                      }
                      %>
                    </select></td>
                    <td>&nbsp;<a href="javascript:setTimeRange(document.TimeRange,<%=currentPageNumber%>)"><img src="<%=fileDir%><%=locale.toString()%>/images/go.gif"  alt='<%=storeText.getString("PendingShopCartsDisplay_Go")%>' border="0" /></a></td>                  
                  </tr>
                </table>
              </td>
            </tr>                
          </tbody>
        </table>
 
          <%        
          int itemCount = 0;
          float subtotal = 0;
          int pendingCarts = 0;

          //setMaxRows(int aMaxRows)
                    
          orderListBean = new OrderListDataBean();
          orderListBean.setStoreId(new Integer(storeId));
          orderListBean.setChannelStoreId(new Integer(storeId));
          orderListBean.setChannelStoreOrderStatus(new String[] { "a", "b", "c" });//a-not transferred, b-partly transferred, c-fully transferred, d-processed
          Timestamp start= new Timestamp(Integer.parseInt(fromYYYY)-1900,Integer.parseInt(fromMM)-1,Integer.parseInt(fromDD),0,0,0,0);
          Timestamp end= new Timestamp(Integer.parseInt(toYYYY)-1900,Integer.parseInt(toMM)-1,Integer.parseInt(toDD),24,0,0,0);
          orderListBean.setStartEndDateAndScopeMethod(start,end,1);
          orderListBean.setPageSize(pageSize);
          orderListBean.setUserId(cmdcontext.getUserId());
          orderListBean.setFilterOrdersWithNoDescription(true);          
          
          com.ibm.commerce.beans.DataBeanManager.activate(orderListBean, request);
          total = orderListBean.getNumberOfOrders();
          orders = orderListBean.getOrderDataBeansByPageNumber(currentPageNumber);

          //calculate totalPage
          if (total%pageSize>0) { totalPage=total/pageSize+1; }
          else { totalPage=total/pageSize; }
           
      if (orders.length>0) {  
      %>                               
        <table width="590" border="0" cellspacing="0" cellpadding="0">
          <tbody>
          <tr>
            <td>
              <table cellpadding="0" cellspacing="0" border="0" width="590">
                <tbody>
                <tr>
                  <td colspan="6"><img src="<%=fileDir%>images/c.gif" width="1" height="11" border="0" /></td>
                </tr>
                <tr>
                  <td colspan="6"><b>&nbsp;<%=storeText.getString("OrderList_OrderOf", new Integer((currentPageNumber-1)*pageSize+1).toString(), new Integer(Math.min(currentPageNumber*pageSize,total)).toString(), new Integer(total).toString())%></b></td>
                </tr>
                                
                <tr class="tdblue">
                  <td colspan="6" class="tdblue">&nbsp;&nbsp;<%=storeText.getString("PendingShopCartsDisplay_YourPendingCarts")%></td></tr>
                <tr>
                  <td width="590">
                    <table cellSpacing="1" cellPadding="0" width="590" border="0">
                      <tr class="verylightgrey_bg" valign="top" width="590">
                        <th width="125" id="th1" class="mbg"><span class="small">&nbsp;<b><%=storeText.getString("PendingShopCartsDisplay_DescriptionLabel")%></b></span></th>
                        <th width="85" id="th2" class="mbg"><span class="small">&nbsp;<b><%=storeText.getString("PendingShopCartsDisplay_SavedLabel")%></b></span></th>
                        <th width="85" id="th3" class="mbg">
                          <table width="85" cellSpacing="1" cellPadding="0" border="0">
                            <tr valign="top">
                              <td><img class="imgHeightFix" src="<%=fileDir%>images/c.gif" width="2" height="1" border="0" /></td>
                              <td><span class="small"><b><%=storeText.getString("PendingShopCartsDisplay_PriceAvailLabel")%></b></span></td>
                            </tr>
                          </table>
                        </th>
                        <th width="115" id="th4" class="mbg"><span class="small">&nbsp;<b><%=storeText.getString("PendingShopCartsDisplay_DistributorLabel")%></b></span></th>
                        <th width="95" id="th5" class="mbg"><span class="small">&nbsp;<b><%=storeText.getString("PendingShopCartsDisplay_StatusLabel")%></b></span></th>
                        <th align="right"width="85" id="th6" class="mbg"><span class="small"><b><%=storeText.getString("PendingShopCartsDisplay_SubtotalLabel")%></b></span>&nbsp;</th>
                      </tr>
                    
                <%                
                          

                 
              for (int j = 0; j < orders.length; j++) {

                OrderAccessBean order = (OrderAccessBean) orders[j];
                OrderDataBean orderBean = new OrderDataBean();
                orderBean.setOrderId(order.getOrderId());
                orderRn = order.getOrderId();
                           
                com.ibm.commerce.beans.DataBeanManager.activate(orderBean, request);
                
                if ((order.getDescription() != null) && (!order.getDescription().equals(""))) {
                    if (itemCount !=0) {
                    %>
                      <tr><td colspan="6" class="lightgrey_bg"><img class="imgHeightFix" src="<%=fileDir%>images/c.gif" width="1" height="1" border="0" /></td></tr>
                    <%
                    }
                    itemCount = itemCount + 1;
                    %>
                      <tr valign="top">
                      <td width="125" headers="th1"><span class="text">&nbsp;                        
                    <%                    
                    OrderItemDataBean [] orderItems2 = orderBean.getOrderItemDataBeans();
                    OrderDataBean [] selectionChildOrderBeans = orderBean.getChildOrders(distIdList,"selection");
                    OrderDataBean [] submissionChildOrderBeans = orderBean.getChildOrders(distIdList,"submission");
                    initialchildOrderbeans = orderBean.getChildOrders(distIdList, "initial");

                    if ( submissionChildOrderBeans != null && submissionChildOrderBeans.length > 0 ) {
                    %>
                        <a href="PartialTransferShopCartDisplayView?storeId=<%=storeId%>&langId=<%=languageId%>&catalogId=<%=catalogId%>&orderId=<%=orderRn%>"><%= order.getDescription()%></a>
                    <% } else if(setCurrentPendingOrderIds.contains(orderBean.getOrderIdInEJBType())) { %>
                    	<a href="javascript:ShopCartDetail(document.PendingCarts, <%=orderRn%>, true)"><%= order.getDescription() %></a>
                    	<br/><span class="bct"><%=storeText.getString("CurrentShopCartDisplay_Title")%></span>
                    <%
                    }
                    else {          
                    %>
                        <a href="javascript:ShopCartDetail(document.PendingCarts, <%=orderRn%>, false)"><%= order.getDescription() %></a>                    
                    <%
                    }                    
                    %>
                    	</span></td>
                        <td width="85" headers="th2"><span class="text">&nbsp;<%= TimestampHelper.getDateFromTimestamp(order.getLastUpdateInEJBType(),locale) %></span></td>
                    <%
                    if (initialchildOrderbeans!= null && initialchildOrderbeans.length == 0) { //price and availabillity
                    %>
                        <td width="85" headers="th3"><span class="text">&nbsp;<%=storeText.getString("PendingShopCartsDisplay_NotAvailable")%></span></td>
                    <%
                    } else {                    
                    %>
                        <td width="85" headers="th3"><span class="text">&nbsp;<%= TimestampHelper.getDateFromTimestamp(orderBean.getLastUpdateInEJBType(),locale) %></span></td>
                    <%
                    }                
                    %>
                    <% //distributor, status, subtotal
                    if ((initialchildOrderbeans!= null && initialchildOrderbeans.length == 0) || (submissionChildOrderBeans !=null && submissionChildOrderBeans.length ==0 )) {
                    //no quotuation or no submission
                    %>                
                        <td width="115" headers="th4"><span class="text">&nbsp;<%=storeText.getString("PendingShopCartsDisplay_NotAvailable")%></span></td>
                        <td width="95" headers="th5"><span class="text">&nbsp;<%=storeText.getString("PendingShopCartsDisplay_NotSubmitted")%></span></td>
                        <td align="right" width="85" headers="th6"><span class="text"><%=orderBean.getFormattedTotalProductPrice()%></span>&nbsp;</td>
                    <%
                    } else { // has quot, first row is for whole channel order, then display each distributor
                    %>
                        <td width="295" colspan="3">
                          <table width="295" border="0" cellspacing="1" cellpadding="0">
                            <tr valign="top">
                              <td width="115">&nbsp;</td>
                            <%
                            if (submissionChildOrderBeans == null || submissionChildOrderBeans.length ==0 ) {// not submitted
                            %>
                              <td width="95"><span class="text"><%=storeText.getString("PendingShopCartsDisplay_NotSubmitted")%></span></td>
                            <%
                            } else {// at least one submission
                              if ((selectionChildOrderBeans == null || selectionChildOrderBeans.length == 0) && (orderItems2 ==null || orderItems2.length ==0)) {
                              // no selection i.e. all submitted AND no unassigned item
                            %>
                              <td width="95"><span class="text"><%=storeText.getString("PendingShopCartsDisplay_OrderSubmitted")%></span></td>	
                            <% } else { %>                            
                              <td width="95"><span class="text"><%=storeText.getString("PendingShopCartsDisplay_PartlySubmitted")%></span></td>
                            <%
                              }
                            }
                            %>
                              <td align="right" width="85"><span class="text">&nbsp;</span></td>
                            </tr>
                          <%
                          // First, list the distributors carts with status equals to "submitted". 
                          // Do not list confirmed or shipped carts because those carts do not require further actions
                          // Then, list the distributors carts that are not submitted                          
                          for (int i=0; submissionChildOrderBeans != null && i < submissionChildOrderBeans.length; i++) {
                            String status = submissionChildOrderBeans[i].getStatus();                          
                            if(status.equals("F") || status.equals("H")) {
                                String distributorDisplayName = null;
                                String extURL = null;
                                String statusDesc = null;
                                StoreEntityDataBean storeEntity = new StoreEntityDataBean();
                                storeEntity.setDataBeanKeyStoreEntityId(submissionChildOrderBeans[i].getStoreEntityId());
                                com.ibm.commerce.beans.DataBeanManager.activate(storeEntity, request);
                                Integer iLangId = Integer.valueOf(languageId);  
                                StoreEntityDescriptionAccessBean storeDesc = storeEntity.getDescription(iLangId);
                                distributorDisplayName = storeDesc.getDisplayName();
                                try {
                                  OrderReleaseDataBean orderRelease = new OrderReleaseDataBean();
                                  orderRelease.setDataBeanKeyOrdersId( submissionChildOrderBeans[i].getOrderId() );
                                  orderRelease.setDataBeanKeyOrderReleaseNum( submissionChildOrderBeans[i].getOrderItemDataBeans()[0].getOrderReleaseNumber());
                                  com.ibm.commerce.beans.DataBeanManager.activate(orderRelease, request);    
                                  extURL = orderRelease.getExternalReference();          
                                } catch(Exception e) {
                                  out.println("<!-- Exception caught (extURL) : " + e + " -->");
                                }
                                if (extURL != null && !extURL.equals("") && !extURL.equals("null") )  {
                                  statusDesc = storeText.getString("PendingShopCartsDisplay_Submitted");
                                }
                                else
                                {
                                  statusDesc = storeText.getString("DistributorCartDetails_SubmissionNotConfirmed");
                                }
                              %>
                              <tr>
                                <td colspan="3" class="lightgrey_bg"><img class="imgHeightFix" src="<%=fileDir%>images/c.gif" width="1" height="1" border="0" /></td>
                              </tr>
                            <tr valign="top">
                              <td width="115"><span class="text">&nbsp;<%=distributorDisplayName%></span></td>
                              <td width="95"><span class="text"><%=statusDesc%></span></td>
                              <td align="right" width="85"><span class="text"><%=submissionChildOrderBeans[i].getSubTotal()%></span></td>
                            </tr>
                            <%
                            }
                          }
                          for (int i=0; selectionChildOrderBeans != null && i < selectionChildOrderBeans.length; i++) {                           
                            String status = selectionChildOrderBeans[i].getStatus();
                                String distributorDisplayName = null;
                                StoreEntityDataBean storeEntity = new StoreEntityDataBean();
                                storeEntity.setDataBeanKeyStoreEntityId(selectionChildOrderBeans[i].getStoreEntityId());
                                com.ibm.commerce.beans.DataBeanManager.activate(storeEntity, request);
                                Integer iLangId = Integer.valueOf(languageId);  
                                StoreEntityDescriptionAccessBean storeDesc = storeEntity.getDescription(iLangId);
                                distributorDisplayName = storeDesc.getDisplayName();
                                %>
                                <tr>
                                  <td colspan="3" class="lightgrey_bg"><img class="imgHeightFix" src="<%=fileDir%>images/c.gif" width="1" height="1" border="0" /></td>
                                </tr>
                            <tr valign="top">
                              <td width="115"><span class="text">&nbsp;<%=distributorDisplayName%></span></td>
                              <td width="95"><span class="text"><%=storeText.getString("PendingShopCartsDisplay_NotSubmitted")%></span></td>
                              <td align="right" width="85"><span class="text"><%=selectionChildOrderBeans[i].getSubTotal()%></span></td>
                            </tr>
                            <%
                          }
                          %>
                          </table>
                        </td>
                    <%
                    }
                    %>
                      </tr>
                <%
                }                        
                pendingCarts += 1;
              } // end for loop j
                %>
                      <tr>
                        <td class="tdheightFix_black_bg" colspan="6" ><img class="imgHeightFix" src="<%=fileDir%>images/c.gif" width="1" height="2" border="0" /></td>
                      </tr>
                    </table>
                  </td>
                </tr>
                </tbody>
              </table>
                
              <table cellpadding="0" cellspacing="1" border="0" width="590">
                <tr>
                  <td><img src="<%=fileDir%>images/c.gif" width="1" height="11" border="0" />
                </tr>                
                <tr valign="top">
                  <td align="right"><b>
                  <% 
                  // display Previous 10 link and set the current page to be the last page in that range if Previous 10 link is clicked
                  if (currentPageNumber>10) {%>
                    <a href="javascript:setTimeRange(document.TimeRange,<%= ((currentPageNumber-1)/10-1)*10+10 %>)"><%=storeText.getString("PendingShopCartsDisplay_Previous10")%></a>
                  <%}
                  
                  if (currentPageNumber>1) {
                    if (currentPageNumber>10) {%>
                      &nbsp;|&nbsp;
                    <%}%>
                    <a href="javascript:setTimeRange(document.TimeRange,<%= currentPageNumber-1 %>)"><%=storeText.getString("PendingShopCartsDisplay_Previous")%></a>
                  <%}
                  
                  if (currentPageNumber>1) {%>
                      &nbsp;|&nbsp;
                  <%}
                   //if this is the not the last range, display full range , else display up to the last page
                  if ( (currentPageNumber-1)/10  < (totalPage-1)/10  ) {
                      for (int i=0; i<10; i++) {
                        if (i>0) {%>
                            &nbsp;|&nbsp;
                        <%}
                        if ((((currentPageNumber-1)/10)*10+i+1)==currentPageNumber) {%>
                          <%= (((currentPageNumber-1)/10)*10+i+1) %>
                        <%} else {%>
                          <a href="javascript:setTimeRange(document.TimeRange,<%= (((currentPageNumber-1)/10)*10+i+1) %>)"><%= (((currentPageNumber-1)/10)*10+i+1) %></a>
                        <%}
                      }
                  } else {
                      for (int i=0; i<totalPage%10; i++) { //display last range
                        if (i>0) {%>
                            &nbsp;|&nbsp;
                        <%}
                        if ((((currentPageNumber-1)/10)*10+i+1)==currentPageNumber) {%>
                          <%= (((currentPageNumber-1)/10)*10+i+1) %>
                        <%} else {%>
                          <a href="javascript:setTimeRange(document.TimeRange,<%= (((currentPageNumber-1)/10)*10+i+1) %>)"><%= (((currentPageNumber-1)/10)*10+i+1) %></a>
                        <%}
                      }
                  }
                    
                  //The current page< totalPage, display Next link,and set the current page to be next page
                  if (currentPageNumber<totalPage) {%> 
                    &nbsp;|&nbsp;<a href="javascript:setTimeRange(document.TimeRange,<%= currentPageNumber+1 %>)"><%=storeText.getString("PendingShopCartsDisplay_Next")%></a>
                  <% }
                  
                  //The range that current page is in is less than the last range, display Next 10 link,and set the current page to be the first page in that range if Next 10 link is clicked
                  if ( (currentPageNumber-1)/10  < (totalPage-1)/10  ) {%>
                    &nbsp;|&nbsp;<a href="javascript:setTimeRange(document.TimeRange,<%= ((currentPageNumber-1)/10+1)*10+1 %>)"><%=storeText.getString("PendingShopCartsDisplay_Next10")%></a>
                  <%}%>
                  
                  </b></td>
                </tr>
              </table>
            </td>
          </tr>
          </tbody>
        </table>
      <%
      }
      else
      {
      %>
        <table width="590" border="0" cellspacing="0" cellpadding="0">
        <tbody>
          <tr>
             <td colspan="6"><span class="text">&nbsp;<%=storeText.getString("PendingShopCartsDisplay_NoPendingCarts")%></span></td>
          </tr>
          </tbody>
        </table>
      <%
      }// end hasShopCart
      %>

        </form>   
    <!--END MAIN CONTENT-->
  </td>

</tr></tbody></table>
   
<!-- End Main Table -->

<%@ include file="../../../include/FooterDisplay.jspf"%>

</body>
</html>

