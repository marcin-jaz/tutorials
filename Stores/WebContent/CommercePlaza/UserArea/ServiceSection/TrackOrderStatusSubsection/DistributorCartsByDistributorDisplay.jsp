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
<%@ page import="java.sql.Timestamp" %>

<%@ page import="com.ibm.commerce.server.*" %>
<%@ page import="com.ibm.commerce.command.*" %>
<%@ page import="com.ibm.commerce.common.beans.*" %>
<%@ page import="com.ibm.commerce.common.objects.*" %>
<%@ page import="com.ibm.commerce.order.beans.*" %>
<%@ page import="com.ibm.commerce.utils.TimestampHelper" %>
<%@ page import="com.ibm.commerce.orderstatus.beans.OrderFulfillmentStatusDataBean" %>
<%@ page import="com.ibm.commerce.price.beans.FormattedMonetaryAmountDataBean" %>
<%@ page import="com.ibm.commerce.inventory.beans.OrderReleaseDataBean" %>
<%@ include file="../../../include/EnvironmentSetup.jsp"%>
<%
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
    int pageSize=10; //how many orders in one page
    int totalPage=0; //initialize
    int total=0; //initialize
        
    //Get the distStoreId and dateChoice from the drop down
    String distStoreId = jhelper.getParameter("distStoreId");
    if (distStoreId==null) {
      //Get all distributor stores and take the first one as default choice
      Integer[] distributorStoreIds  = cmdcontext.getStore().getRelatedStores("com.ibm.commerce.referral");
      if (distributorStoreIds.length>0) {
	distStoreId=distributorStoreIds[0].toString();
      } else {
        distStoreId="";
      }
    }
    
    String dateChoice = jhelper.getParameter("dateChoice");
    if (dateChoice==null) {dateChoice="";}

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

    String orderRn = null;

    OrderDataBean [] orders = null;

    OrderItemDataBean orderItem = null;
    OrderItemDataBean [] orderItems = null;

    OrderFulfillmentStatusDataBean orderStatusDB = null;

    // Channel Orders
    OrderDataBean parentOrderBean = null;
    OrderItemDataBean childOrderItem = null;
    OrderListDataBean orderListBean = null;
      
    StoreEntityDataBean stEntDataBean = null;
    StoreEntityDescriptionAccessBean stEntDscAccessBean = null;

    String distributorName = null;
    String distNameSelected = null;

    request.setAttribute("pageName", "DistributorCarts");
    boolean haveDistShopCart = false;

    // Here is the status in the orders.status column
    String ordersStatus = "W,N,F,G,H,S";

    // Here is the status in the orders.status column and the ordstat.osstatus column.  If orders.status equals to G, refer to the status in ordstat.osstatus column.
    String [] statusChar = {"W", "N", "F", "C","S","I","SP","BP","X" };
    String [] orderStatus = {storeText.getString("DistributorCartStatus_W"),
                         storeText.getString("DistributorCartStatus_N"),
                         storeText.getString("DistributorCartStatus_F"),
                         storeText.getString("DistributorCartStatus_C"),
                         storeText.getString("DistributorCartStatus_S"),
                         storeText.getString("DistributorCartStatus_I"),
                         storeText.getString("DistributorCartStatus_SP"),
                         storeText.getString("DistributorCartStatus_BP"),
                         storeText.getString("DistributorCartStatus_X") };
  
    if (distStoreId.trim().length()>0) {
      Integer[] distIdList = {new Integer(distStoreId)};

      orderListBean = new OrderListDataBean();
      orderListBean.setStoreId(distIdList);
      orderListBean.setOrderStatus(ordersStatus);
      orderListBean.setUserId(cmdcontext.getUserId());
      Timestamp start= new Timestamp(Integer.parseInt(fromYYYY)-1900,Integer.parseInt(fromMM)-1,Integer.parseInt(fromDD),0,0,0,0);
      Timestamp end= new Timestamp(Integer.parseInt(toYYYY)-1900,Integer.parseInt(toMM)-1,Integer.parseInt(toDD),24,0,0,0);
      orderListBean.setStartEndDateAndScopeMethod(start,end,1);
      orderListBean.setAscendingSortOrder();
      orderListBean.setSortMethodId(8); // sort by status
      orderListBean.setPageSize(pageSize);
      orderListBean.setUserId(cmdcontext.getUserId());      
      com.ibm.commerce.beans.DataBeanManager.activate(orderListBean, request);
      total = orderListBean.getNumberOfOrders();
      orders = orderListBean.getOrderDataBeansByPageNumber(currentPageNumber);

      //calculate totalPage
      if (total%pageSize>0) { totalPage=total/pageSize+1; }
      else { totalPage=total/pageSize; }

      for (int j = 0; j < orders.length; j++) {
	if ((orders[j].getParentOrder().getOrderId() != null)) {
		haveDistShopCart = true;
		break;
	}
      }// end for
    } else {
      haveDistShopCart = false;
    }//end if

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "DTD/xhtml1-transitional.dtd">
<head>
	<title><%=storeText.getString("DistributorCarts_Title")%></title>
	<link rel="stylesheet" href="<%=fileDir%>PCDMarket.css" type="text/css">
</head>

<script language="javascript">
        function setTimeRange(form1,num)
        {
                form1.currentPage.value=num;
                form1.submit();
        }
</script>

<body marginheight="0" marginwidth="0" leftmargin="0" topmargin="0">
<!-- Start Header File -->
<%@ include file="../../../include/HeaderDisplay.jspf"%>
<!-- End Header File -->
<!-- Start Main Table - Consists of TD for Left Bar, TD for Content and TD for Quicklinks -->
<table border="0" cellpadding="0" cellspacing="0" width="750" height="99%">
  <tr>
    <td valign="top" class="dbg" width="150"> 
      <% String incfile = includeDir + "SidebarDisplay.jsp"; %>
      <jsp:include page="<%=incfile%>" flush="true"/></TD>
    <!-- End  Left Nav Bar TD -->
    <td><a name="mainContent"></a><img src="<%=fileDir%>images/c.gif" width="10" height="1"  class="imgHeightFix" /></td>
    <!-- Begin Main Content TD -->
    <td valign="top" width="590">
  	<!-- Start Main JSP Content -->
      <table width="590" border="0" cellspacing="0" cellpadding="0">
  	    <tr>
  	      <td width="590" colspan="2"><span class="bct">&nbsp;&nbsp;&nbsp;</span>
        		<a class="bctl" href="StoreCatalogDisplay?storeId=<%=storeId%>&catalogId=<%=catalogId%>&langId=<%=languageId%>"><%=storeText.getString("Breadcrumb_CommercePlaza")%></a><span class="bct">&nbsp;&nbsp;&nbsp;&gt;&nbsp;&nbsp;&nbsp;</span>
        		<font class="bct"><%=storeText.getString("Breadcrumb_ShopCart")%></font>
	        </td>
	      </tr>
  	    <tr>
  	      <td valign="top" width="320"><div align="left"><span class="title"><%=storeText.getString("DistributorCarts_Title1")%></span></div></td>
  	      <td valign="top" width="280"><div align="right"><img src="<%=fileDir%>images/hdr_cart.gif" width="280" height="72" alt="<%=storeText.getString("DistributorCarts_Title1")%>"></div></td>
  	    </tr>
  	    <tr>
  	      <td width="590" height="1" colspan="3"><img src="<%=fileDir%>images/c.gif" width="2" height="1"  class="imgHeightFix" /></td>
  	    </tr>
      </table>	    
      <form name="TimeRange" action="DistributorCartsByDistributorDisplayView" method="post">
      <input type="hidden" name="currentPage" value="">
        <table width="590" border="0" cellspacing="0" cellpadding="0">
          <tbody>            
            <tr>
              <td>
                <table>
                  <tr>
                    <td><b>&nbsp;</b></td>
                    <td><b>&nbsp;</b></td>
                    <td><b>&nbsp;</b></td>
                    <td><label for="year1text"><%=storeText.getString("OrderList_Year")%></label></td>
                    <td><label for="month1text"><%=storeText.getString("OrderList_Month")%></label></td>
                    <td><label for="day1text"><%=storeText.getString("OrderList_Day")%></label></td>
                    <td>&nbsp;</td>
                    <td><label for="year2text"><%=storeText.getString("OrderList_Year")%></label></td>
                    <td><label for="month2text"><%=storeText.getString("OrderList_Month")%></label></td>
                    <td><label for="day2text"><%=storeText.getString("OrderList_Day")%></label></td>
                    <td>&nbsp;</td>
                  </tr>
                  <tr>
                    <td>                    
                    <b><label for="distributorstext"><%=storeText.getString("OrderList_Display")%></label></b>
                    </td>
                    <td>
                    <select name="distStoreId" id="distributorstext">
                      <%
                        //Get all distributor stores
			Integer[] distributorStoreIds  = cmdcontext.getStore().getRelatedStores("com.ibm.commerce.referral");
			
                        for (int i=0; i<distributorStoreIds.length; i++) {
				stEntDataBean = new StoreEntityDataBean();
  				stEntDataBean.setDataBeanKeyStoreEntityId(distributorStoreIds[i].toString());
  				com.ibm.commerce.beans.DataBeanManager.activate(stEntDataBean, request);
  				stEntDscAccessBean = stEntDataBean.getDescription(new Integer(languageId));
				
        			distributorName = stEntDscAccessBean.getDisplayName();
        			if (distributorStoreIds[i].toString().equals(distStoreId)) {
        			  distNameSelected = distributorName;
        			}
                      %>
                      <option value="<%= distributorStoreIds[i].toString() %>" <% if (distributorStoreIds[i].toString().equals(distStoreId)) {%> selected <%}%> ><%= distributorName %></option>
                      <%
                      }//end for
                     %>
                    </select></td>
                    <td>
                    <b><%=storeText.getString("OrderList_carts")%>&nbsp;<%=storeText.getString("OrderList_from")%></b>
                    </td>
                    <td> 
                    <select name="fromYYYY" id="year1text">
                      <%
                      for (int i=0; i<12; i++) {
                      %>
                      <option value="<%= 2002+i %>" <% if (Integer.parseInt(fromYYYY)==(2002+i)) {%> selected <%}%> ><%= 2002+i %></option>
                      <%
                      }
                      %>
                    </select></td>
                    <td>
                    <select name="fromMM" id="month1text">
                      <%
                      for (int i=0; i<12; i++) {
                      %>
                      <option value="<%= 1+i %>" <% if (Integer.parseInt(fromMM)==(1+i)) {%> selected <%}%> ><%= 1+i %></option>
                      <%
                      }
                      %>
                    </select></td>
                    <td>
                    <select name="fromDD" id="day1text">
                      <%
                      for (int i=0; i<31; i++) {
                      %>
                      <option value="<%= 1+i %>" <% if (Integer.parseInt(fromDD)==(1+i)) {%> selected <%}%> ><%= 1+i %></option>
                      <%
                      }
                      %>
                    </select></td>
                    <td><b><%=storeText.getString("OrderList_To")%></b></td>
                    <td> 
                    <select name="toYYYY" id="year2text">
                      <%
                      for (int i=0; i<12; i++) {
                      %>
                      <option value="<%= 2002+i %>" <% if (Integer.parseInt(toYYYY)==(2002+i)) {%> selected <%}%> ><%= 2002+i %></option>
                      <%
                      }
                      %>
                    </select></td>
                    <td>
                    <select name="toMM" id="month2text">
                      <%
                      for (int i=0; i<12; i++) {
                      %>
                      <option value="<%= 1+i %>" <% if (Integer.parseInt(toMM)==(1+i)) {%> selected <%}%> ><%= 1+i %></option>
                      <%
                      }
                      %>
                    </select></td>
                    <td>
                    <select name="toDD" id="day2text">
                      <%
                      for (int i=0; i<31; i++) {
                      %>
                      <option value="<%= 1+i %>" <% if (Integer.parseInt(toDD)==(1+i)) {%> selected<%}%> ><%= 1+i %></option>
                      <%
                      }
                      %>
                    </select></td>
                    <td>&nbsp;<a href="javascript:setTimeRange(document.TimeRange,<%=currentPageNumber%>)"><img src="<%=fileDir%><%=locale.toString()%>/images/go.gif" alt='<%=storeText.getString("OrderList_Go")%>' border="0" /></a></td>                  
                  </tr>
                </table>
              </td>
            </tr>      
<% if (!haveDistShopCart) { %>
            <tr>
              <td> 
                <table cellpadding="0" cellspacing="1" border="0" width="590">
                  <tr>
          	    <td><%=storeText.getString("DistributorCarts_NoCart")%></td>
                  </tr>
<% } else { %>		      
            <tr>
              <td>
                <table cellpadding="1" cellspacing="1" border="0" width="590">
                  <tr>
                    <td colspan="6"><img src="<%=fileDir%>images/c.gif" width="1" height="11" border="0" /></td>
                  </tr>                
                  <tr>
                    <td colspan="2"><b><%=storeText.getString("OrderList_DistributorOf", new Integer((currentPageNumber-1)*pageSize+1).toString(), new Integer(Math.min(currentPageNumber*pageSize,total)).toString(), new Integer(total).toString())%></b></td>
                    <td colspan="5" align="right"><b><%=storeText.getString("DistributorCarts_SortBy")%> <a href="DistributorCartsByStatusDisplayView?storeId=<%=storeId%>&catalogId=<%=catalogId%>&langId=<%=languageId%>"><%=storeText.getString("DistributorCarts_Status")%> </a> | <%=storeText.getString("DistributorCarts_Distributor")%> | <a href="DistributorCartsByDateDisplayView?storeId=<%=storeId%>&catalogId=<%=catalogId%>&langId=<%=languageId%>"><%=storeText.getString("OrderList_LastUpdated")%> / <%=storeText.getString("DistributorCarts_Date")%></a></b></td>
                  </tr>                
                  <tr class="tdblue">
    		    <td colspan="6" height="18" class="tdblue">&nbsp;&nbsp;<%=distNameSelected%></td>
      	          </tr>
                  <tr valign="top"> 
		    <th id="t1" align="left" valign="top" class="mbg">
		      <table cellspacing="0" cellpadding="0" border="0">
		        <tr>
		          <td height="18"><img src="<%=fileDir%>images/c.gif" width="2" height="1" /></td><td align="left" valign="top"><span class="small" style="font-weight: bold"><%=storeText.getString("DistributorCarts_DistributorCart")%><br /></span></td>
		        </tr>
		      </table>
		    </th>
		    <th id="t2" align="left" valign="top" class="mbg">
		      <table cellspacing="0" cellpadding="0" border="0">
		        <tr>
		          <td height="18"><img src="<%=fileDir%>images/c.gif" width="2" height="1" /></td>
		          <td align="left" valign="top"><span class="small" style="font-weight: bold"><%=storeText.getString("DistributorCarts_Description")%></span></td>
		        </tr>
		      </table>		        
		    </th>
		    <th id="t3" width="80" align="left" valign="top" class="mbg">
		      <table cellspacing="0" cellpadding="0" border="0">
		        <tr>
		          <td height="18"><img src="<%=fileDir%>images/c.gif" width="2" height="1" /></td>
		          <td align="left" valign="top"><span class="small" style="font-weight: bold"><%=storeText.getString("DistributorCarts_Status1")%></span></td>
		        </tr>
		      </table>
		    </th>
		    <th id="t4" align="left" valign="top" class="mbg">
		      <table cellspacing="0" cellpadding="0" border="0">
		        <tr>
		          <td height="18"><img src="<%=fileDir%>images/c.gif" width="2" height="1" /></td>
		          <td align="left" valign="top"><span class="small" style="font-weight: bold"><%=storeText.getString("DistributorCarts_OrderNum")%></span></td>
		        </tr>
                      </table>
	            </th>
	            <th id="t5" align="left" valign="top" class="mbg">
	              <table cellspacing="0" cellpadding="0" border="0">
	                <tr>
	                  <td height="18"><img src="<%=fileDir%>images/c.gif" width="2" height="1" /></td>
	                  <td align="left" valign="top"><span class="small" style="font-weight: bold"><%=storeText.getString("OrderList_LastUpdated")%>/<%=storeText.getString("DistributorCarts_Date1")%></span></td>
	                </tr>
	              </table>
	            </th>
	            <th id="t6" align="left" valign="top" class="mbg">
	              <table cellspacing="0" cellpadding="0" border="0">
	                <tr>
	                  <td height="18"><img src="<%=fileDir%>images/c.gif" width="2" height="1" /></td>
	                  <td align="left" valign="top"><span class="small" style="font-weight: bold"><%=storeText.getString("DistributorCarts_Total")%></span></td>
	                </tr>
	              </table>
	            </th>
	          </tr>
<%
	boolean isFirstRow = true;
  	try {
  	  for (int j = 0; j < orders.length; j++) {
  		OrderDataBean orderBean = orders[j];
  		orderRn = orderBean.getOrderId();
  		out.println("<!-- OrderID = " + orderRn + " -->");
  		
  		stEntDataBean = new StoreEntityDataBean();
  		stEntDataBean.setDataBeanKeyStoreEntityId(orderBean.getStoreEntityId());
  		com.ibm.commerce.beans.DataBeanManager.activate(stEntDataBean, request);
  		stEntDscAccessBean = stEntDataBean.getDescription(new Integer(languageId));
		
//                distributorName = stEntDscAccessBean.getDisplayName();
  		
  		if ((orderBean.getParentOrder().getOrderId() != null)) {
  			orderItems = orderBean.getOrderItemDataBeans();
  			parentOrderBean = orderBean.getParentOrder();		              
  			if (!isFirstRow) {     %>
	          <tr>
		    <td colspan="6">
	              <table width="590" cellspacing=0 cellpadding=0>
		        <tr>
                          <td class="gbg"><img src="<%=fileDir%>images/c.gif" width="1" height="1" border="0"  class="imgHeightFix" /></td>
                        </tr>
                      </table>
                    </td>
                  </tr>
<%		        }
			isFirstRow = false;
%>
                  <tr>
            	    <td headers="t1" height="19" align="left" valign="top"><span class="small"><a href="ProcessedDistributorCartDetailsDisplayView?orderId=<%= orderBean.getOrderId()%>&catalogId=<%=catalogId%>&langId=<%=languageId%>&page=distributorCarts"><%= orderBean.getOrderId() %></a></span></td>
<%
  			String orderDesc = "";
  			if ((parentOrderBean != null) && (parentOrderBean.getDescription() != null)) {
  				orderDesc = parentOrderBean.getDescription();
  			}else {
  				orderDesc = "";
  			}
  			 			
  			String statusValue = "";
  			String status = "";
  			if (orderBean.getStatus() != null && !orderBean.getStatus().equals("G") && !orderBean.getStatus().equals("H")) {
  				status = orderBean.getStatus();
  			} else {
  				if (orderBean.getOrderFulfillmentStatusDataBean() != null) {
  					status = orderBean.getOrderFulfillmentStatusDataBean().getOrderStatus();
  				}
  			}
  			for (int k = 0; k < statusChar.length; k++) {
  				if (status.equals(statusChar[k])) {
  					statusValue = orderStatus[k];
  					break;
  				}
  			}
  			if (status.equals("F")) {
  			  String extURL = null;
  			  try {
    				OrderReleaseDataBean orderRelease = new OrderReleaseDataBean();
    				Enumeration results = orderRelease.findByOrdersId( orderBean.getOrderIdInEJBType() );
    				orderRelease = (OrderReleaseDataBean)results.nextElement();
    				extURL = orderRelease.getExternalReference();
    		  	  } catch(Exception e) {
    		    		out.println("<!-- Exception caught (release) : " + e + " -->");
    		  	  }
  			  if(( extURL==null) || (extURL.length()==0) || (extURL.equals("null"))) {
  				statusValue = storeText.getString("DistributorCarts_SubmitNotConfirmed");
  			  }
  			}
  			if (orderBean.getStatus().equals("P") || orderBean.getStatus().equals("F")) {
%>
		    <td headers="t2" height="19" align="left" valign="top"><span class="small"><a href="PartialTransferShopCartDisplayView?orderId=<%=parentOrderBean.getOrderId()%>&catalogId=<%=catalogId%>&langId=<%=languageId%>"><%= orderDesc %></a></span></td>
<%  			} else {     %>			
		    <td headers="t2" height="19" align="left" valign="top"><span class="small"><%= orderDesc %></span></td>
<%			}  %>
		    <td headers="t3" align="left" nowrap valign="top"><span class="small"><%= statusValue %></span></td>
<%		  	if (orderBean.getStatus().equals("P") || orderBean.getStatus().equals("F") || orderBean.getStatus().equals("W") || orderBean.getStatus().equals("N")) {  %>
            	    <td headers="t4" height="19" align="left" nowrap valign="top"><span class="small"><%=storeText.getString("DistributorCarts_NotAvailable")%></span></td>
            	    <td headers="t5" height="19" align="left" nowrap valign="top"><span class="small"><%= TimestampHelper.getDateFromTimestamp(orderBean.getLastUpdateInEJBType(),locale) %></span></td>
<%	  		} else {         
          		  String extURL = null;
          		  try{
    				orderStatusDB = orderBean.getOrderFulfillmentStatusDataBean();
    				OrderReleaseDataBean orderRelease = new OrderReleaseDataBean();
    				Enumeration results = orderRelease.findByOrdersId( orderBean.getOrderIdInEJBType() );
    				orderRelease = (OrderReleaseDataBean)results.nextElement();
    				extURL = orderRelease.getExternalReference();
          		  } catch(Exception e) {
            			out.println("<!-- Exception caught (fulfill) : " + e + " -->");
          		  }      				
  			  if(( extURL!=null)&&(extURL.length()>0)&&(!extURL.equals("null"))) {  %>				
            	    <td headers="t4" height="19" align="left" nowrap valign="top"><a href="ExitToDistributorSiteDisplayView?storeId=<%=storeId%>&langId=<%=languageId%>&forwardURL=<%=java.net.URLEncoder.encode(extURL)%>" target="_blank"><span class="small"><%= orderStatusDB.getMerchantOrderNumber() %></span></a></td>
<%	      		  }	else	{ %>
            	    <td headers="t4" height="19" align="left" nowrap valign="top"><span class="small"><%= orderStatusDB.getMerchantOrderNumber() %></span></td>
<%			  } %>
            	    <td headers="t5" height="19" align="left" nowrap valign="top"><span class="small"><%= TimestampHelper.getDateFromTimestamp(orderBean.getPlaceOrderTimeInEJBType(),locale) %></span></td>
<%		  	} //end if
%>
            	    <td headers="t6" align="right" valign="top"><span class="small"><%= orderBean.getFormattedTotalProductPrice() %></span></td>
                  </tr>
<%	        } // end if this is distributor proxy store ids
          } // end for loop j
        } catch(Exception e) {
    		out.println("<!-- Exception caught (j) : " + e + " -->");
        }
}  // end if no distributor shop cart
%>		              
                </table>
              </td>
            </tr>
            <tr>
              <td><img src="<%=fileDir%>images/c.gif" width="1" height="2" border="0"  class="imgHeightFix" /></td>
            </tr>
      
            <tr>
              <td class="bbg"><img src="<%=fileDir%>images/c.gif" width="1" height="2" border="0"  class="imgHeightFix" /></td>
            </tr>
            <tr>
	      <td><img src="<%=fileDir%>images/c.gif" width="1" height="11" border="0" /></td>                    
            </tr>
            <tr valign="top">
              <td align="right"><b>
                <% 
                  // display Previous 10 link and set the current page to be the last page in that range if Previous 10 link is clicked
                  if (currentPageNumber>10) {%>
                    <a href="javascript:setTimeRange(document.TimeRange,<%= ((currentPageNumber-1)/10-1)*10+10 %>)"><%=storeText.getString("OrderList_Previous10")%></a>
                  <%}
                  
                  if (currentPageNumber>1) {
                    if (currentPageNumber>10) {%>
                      &nbsp;|&nbsp;
                    <%}%>
                    <a href="javascript:setTimeRange(document.TimeRange,<%= currentPageNumber-1 %>)"><%=storeText.getString("OrderList_Previous")%></a>
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
                    &nbsp;|&nbsp;<a href="javascript:setTimeRange(document.TimeRange,<%= currentPageNumber+1 %>)"><%=storeText.getString("OrderList_Next")%></a>
                  <% }
                  
                  //The range that current page is in is less than the last range, display Next 10 link,and set the current page to be the first page in that range if Next 10 link is clicked
                  if ( (currentPageNumber-1)/10  < (totalPage-1)/10  ) {%>
                    &nbsp;|&nbsp;<a href="javascript:setTimeRange(document.TimeRange,<%= ((currentPageNumber-1)/10+1)*10+1 %>)"><%=storeText.getString("OrderList_Next10")%></a>
                  <%}%>
                  
              </b></td>
            </tr>
          </tbody>      
        </table>
      </form>
    </td>
  </tr>
</table>
</td>
  <!-- End of Main Content TD -->        
</tr></table>
<!-- End Main Table -->
<!-- Start Footer -->
<%@ include file="../../../include/FooterDisplay.jspf"%>
<!-- End Footer -->
</body>
</html>
