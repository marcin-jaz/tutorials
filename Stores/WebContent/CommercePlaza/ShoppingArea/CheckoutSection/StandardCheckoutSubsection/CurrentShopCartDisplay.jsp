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
<%@ page import="java.math.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="com.ibm.commerce.beans.*" %>
<%@ page import="com.ibm.commerce.server.*" %>
<%@ page import="com.ibm.commerce.command.*" %>
<%@ page import="com.ibm.commerce.datatype.*" %>
<%@ page import="com.ibm.commerce.price.beans.*" %>
<%@ page import="com.ibm.commerce.catalog.beans.*" %>
<%@ page import="com.ibm.commerce.order.beans.*" %>
<%@ page import="com.ibm.commerce.order.objects.*" %>
<%@ page import="com.ibm.commerce.contract.beans.*" %>
<%@ page import="com.ibm.commerce.contract.objects.*" %>
<%@ page import="com.ibm.commerce.catalog.common.ECCatalogConstants" %>
<%@ page import="java.net.URLEncoder" %>
<%@ include file="../../../include/EnvironmentSetup.jsp"%>
<% response.setContentType(storeText.getString("ENCODESTATEMENT")); %>
<%
String orderRn = jhelper.getParameter("orderId");

storeName=sdb.getDescription(cmdcontext.getLanguageId()).getDisplayName();

 //This will be used to store the list of all distributor StoreIds
 Integer[] distributorStoreIds = null;  
  	 
 //Get all distributor stores
 distributorStoreIds = cmdcontext.getStore().getRelatedStores("com.ibm.commerce.referral");
 
int orderInitialQuotes = 0;
String strErrorMessage = null;

String createCartURL = null;
String tempURL = null;    
request.setAttribute("pageName", "CurrentShoppingCart");

%>
<% catalogId = sdb.getStoreCatalogs()[0].getCatalogId(); %>
<jsp:useBean id="catalog" class="com.ibm.commerce.catalog.beans.CatalogDataBean" scope="page">
<% 
catalog.setCatalogId(catalogId);
DataBeanManager.activate(catalog, request); 
%>
</jsp:useBean>
<jsp:useBean id="orderBean" class="com.ibm.commerce.order.beans.OrderDataBean" scope="page">
<%
orderBean.setOrderId(orderRn);
DataBeanManager.activate(orderBean, request);
%>
</jsp:useBean>

<jsp:useBean id="bnError" class="com.ibm.commerce.beans.ErrorDataBean" scope="page">
<% com.ibm.commerce.beans.DataBeanManager.activate(bnError, request); %>
</jsp:useBean>

<%
    strErrorMessage = bnError.getSystemMessage();
    if (strErrorMessage == null || strErrorMessage.equals("")) {
    	strErrorMessage = bnError.getMessage();
    }
%>

<%
CategoryDataBean topCategories[] = catalog.getTopCategories();
CategoryDataBean tcategory;
String tcategoryId;
String orderDescription = orderBean.getDescription();

if (orderBean.getChildInitialOrders()!=null) {
  orderInitialQuotes = orderBean.getChildInitialOrders().length;
} //endif
if( (orderBean.getDescription()==null)||(orderBean.getDescription().trim().length()==0)) {
  createCartURL = ("ShopCartCreateDisplayView?orderId=" + orderRn + "&orderItemId*=&quantity*=");
} else {                                                    
  tempURL = java.net.URLEncoder.encode("SetPendingOrder?URL=OrderItemDisplay&orderItemId*=&quantity*=");
  createCartURL = "OrderCopy?toOrderId=**&URL=" + tempURL + "&orderItemId*=&quantity*=";
}    
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "DTD/xhtml1-transitional.dtd">
<html>
<head>
<title><%=storeText.getString("CurrentShopCartDisplay_Title")%></title>
<link rel=stylesheet href="<%=fileDir%>PCDMarket.css" type="text/css">
</head>
<%

/* 
 * By default, all input parameters to the controller command are propagated to the redirect view command.
 *  If there is a limit on the number of characters in the redirect URL, this may cause a problem.
 *  To handle a limited length redirect URL, the javascript below invokes the command using special parameters to indicate 
 *  that certain input parameters should be removed. For example, you can specify the following as the URL parameter: 
 *  orderItemId*=&quantity*=
 *  This specification means that all parameters whose names start with orderItemId and quantity should be removed.
 */
%>
<script language="javascript">
  var busy=false;
  function updateForm(form)
  {
    if( !busy ) {
      busy = true;   
      form.URL.value = 'OrderItemDisplay?orderId=.&orderItemId*=&quantity*=';
      form.submit();
    }
  }

  function createOrderForm(form)
  {              
    if( !busy ) {
      busy = true;
      form.URL.value = '<%=createCartURL%>';
      form.submit();
    }
  }                        
  
  function saveShopCart(form)
  {              
    if( !busy ) {
      busy = true;
      form.URL.value = 'ShopCartSaveFormView?orderId=<%= orderRn %>&orderItemId*=&quantity*=';
      form.submit();
    }
  }                        

  function addToFavorites(form)
  {              
    if( !busy ) {
      busy = true;   
      form.URL.value = 'FavoritesListAddToExistDisplayView?<%= ECCatalogConstants.EC_CAT_MAN_CATALOGID %>=<%= catalogId %>&orderId=<%= orderRn %>&orderItemId*=&quantity*=';
      form.submit();
    }
  }                        

  function requestQuotes(form)
  {              
    if( !busy ) {
      busy = true;
      form.URL.value = 'DistributorSelectionDisplayView?orderId=<%= orderRn %>&orderItemId*=&quantity*=';
      form.submit();
    }
  }                        

  function viewQuote(form)
  {              
    if( !busy ) {
      busy = true;
      form.URL.value = 'OrderQuotationDisplay?orderQuotationDisplayViewName=OrderQuotationDisplayByDistributorFormView&orderId=<%= orderRn %>&storeId=<%= storeId %>&orderItemId*=&quantity*=';
      form.submit();
    }
  }                        
</script>
<BODY MARGINHEIGHT="0" MARGINWIDTH="0" LEFTMARGIN="0" TOPMARGIN="0">
<%@ include file="../../../include/HeaderDisplay.jspf"%>
<!-- Start Main Table - Consists of TD for Left Bar, gutter, TD for Content -->
<table border="0" cellpadding="0" cellspacing="0" width="750">
  <tr>
    <td valign="top" CLASS="dbg" width="150">
    <% String incfile = includeDir + "SidebarDisplay.jsp"; %>
    <jsp:include page="<%=incfile%>" flush="true"/>
    </td>
    <td><a name="mainContent"></a><img src="<%=fileDir%>images/c.gif" width="10" height="2" border="0"  class="imgHeightFix" /></td>
    <!-- Start of Main Content TD -->
    <td valign="top" width="590">
      <table width="590" cellspacing="0" cellpadding="0" border="0" >
        <tr>
          <td>   
            <table width="100%" cellspacing="0" cellpadding="0" border="0">
              <tbody>
              <tr>
		<td colspan=2><span class="bct">&nbsp;&nbsp;&nbsp;</span>
		<a class="bctl" href="StoreCatalogDisplay?storeId=<%=storeId%>&catalogId=<%=catalogId%>&langId=<%=languageId%>"><%=storeText.getString("Breadcrumb_CommercePlaza")%></a><span class="bct">&nbsp;&nbsp;&nbsp;&gt;&nbsp;&nbsp;&nbsp;</span>
		<span class="bct"><%=storeText.getString("Breadcrumb_ShopCart")%></span>
                </td>
              </tr>
              <tr>
                <td valign="top">
                  <div align="left"><span class="title"><%=storeText.getString("CurrentShopCartDisplay_Title")%></span></div>
                  <% if ((orderDescription!=null)&&(orderDescription.trim().length()>0)) { %>
                  <div><span class="subtitle"><%=orderDescription%></span></div>
                  <% } else { %>
                  <div><span class="subtitle"><%=storeText.getString("CurrentShopCartDisplay_CartNotSaved")%></span></div>
                  <% } %>
                </td>
                <td valign="top">
                  <div align="right"><img src="<%=fileDir%>images/hdr_cart.gif" height="72" width="323" alt="<%=storeText.getString("CurrentShopCartDisplay_Title")%>" /></div>
                </td>
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

              
              </tbody>
            </table>       
          </td>
        </tr>
        <tr>
          <td>
            <table width="100%" cellspacing="1" cellpadding="0" border="0">
            <tbody>
              <tr class="tdblue">
                <td class="tdblue"><img src="<%=fileDir%>images/c.gif" width="4" height="1" border="0" /><%=storeText.getString("CurrentShopCartDisplay_CurrentCart").trim()%></td>
              </tr>
              <tr valign="top">
                <td>
                  <table cellpadding="0" cellspacing="0" border="0" width="100%">
                    <tr>
                      <td valign="top">
                        <table width="100%" cellpadding="0" border="0" cellspacing="1">
	  		  <tr valign="top">
                            <th align="left" id="th1" class="mbg"><img src="<%=fileDir%>images/c.gif" width="2" height="1" border="0" /><b><%=storeText.getString("CurrentShopCartDisplay_Quantity")%></b></th>
                            <th align="left" id="th2" class="mbg"><img src="<%=fileDir%>images/c.gif" width="2" height="1" border="0" /><b><%=storeText.getString("CurrentShopCartDisplay_IBMPartNumber")%></b></th>
                            <th align="left" id="th3" class="mbg"><img src="<%=fileDir%>images/c.gif" width="2" height="1" border="0" /><b><%=storeText.getString("CurrentShopCartDisplay_Description")%></b></th>
                            <th align="left" id="th4" class="mbg"><img src="<%=fileDir%>images/c.gif" width="2" height="1" border="0" /><b><%=storeText.getString("CurrentShopCartDisplay_IBMListPrice")%></b></th>
                            <th align="left" id="th5" class="mbg"><img src="<%=fileDir%>images/c.gif" width="2" height="1" border="0" /><b><%=storeText.getString("CurrentShopCartDisplay_LineTotal")%></b></th>
                          </tr>
                  				<form name="ShopCartForm" method="post" action="OrderItemUpdate">
                  				<input type=hidden name="storeId" value="<%= storeId %>">
                  				<input type=hidden name="langId" value="<%= languageId %>">
                                <input type=hidden name="orderId" value="<%= orderRn %>">
                  				<input type=hidden name="toOrderId" value="">
                  				<input type=hidden name="catalogId" value="<%= catalogId %>">
                 				<input type=hidden name="URL" value="OrderItemDisplay?orderId=.&orderItemId*=&quantity*=">
                                <input type=hidden name="errorViewName" value="CurrentShopCartDisplayView">
                  				<input type="hidden" name="allocate" value="*n">
                  				<input type="hidden" name="reverse" value="*n">
                  				<input type="hidden" name="backorder" value="*n">
                  				<input type="hidden" name="check" value="*n">
                  				<input type="hidden" name="merge" value="*n">
                  				<input type="hidden" name="remerge" value="*n">
	  <%          OrderItemDataBean orderItem = null;
                OrderItemDataBean [] orderItems = null;
                ContractDataBean [] contractDataBean = null;
        
                double subtotal = 0;
                int itemCount = 0;
    
                orderItems = orderBean.getOrderItemDataBeans();
                contractDataBean = new ContractDataBean[orderItems.length];
                            
                for (int j = 0; ((orderItems != null) && (j < orderItems.length)); j++) {
                  itemCount = itemCount + 1;
                  orderItem = orderItems[j];
                  contractDataBean[j] = new ContractDataBean();
    
                  try { 
                    contractDataBean[j].setDataBeanKeyReferenceNumber(new String(orderItem.getContractId()));
                  } catch (Exception ex1) {
                  contractDataBean[j].setDataBeanKeyReferenceNumber("12");
                  }  %>			
                  				<tr>
                    				<input type="hidden" name="orderItemId_<%= itemCount %>" value="<%=orderItem.getOrderItemId()%>" >
                    				<td align="left" headers="th1">
                    					<label for="quantity_<%= itemCount %>"><img src="<%=fileDir%>images/trans.gif" height="1" width="1" border="0" alt="<%=storeText.getString("CurrentShopCartDisplay_Quantity")%>"/></label>
                    					<input class="iform" size="4" name="quantity_<%= itemCount %>" id="quantity_<%= itemCount %>" value="<%=orderItem.getFormattedQuantity()%>"><a href="OrderItemDelete?orderItemId=<%=orderItem.getOrderItemId()%>&URL=OrderItemDisplay&langId=<%=languageId%>&catalogId=<%=catalogId%>&storeId=<%=storeId%>&check=*n&orderId=*"><img src="<%= fileDir %>images/icn_trash.gif" alt="<%=storeText.getString("CurrentShopCartDisplay_Remove")%>" border="0" align="middle" /></a></td>
                    				<td align="left" headers="th2"><font class="text"><A href="ProductDisplay?storeId=<%=storeId%>&langId=<%=languageId%>&catalogId=<%=catalogId%>&productId=<%=orderItem.getCatalogEntryId()%>"><%=orderItem.getCatalogEntry().getPartNumber()%></a></font></td>
                    				<td align="left" headers="th3"><font class="text"><%=orderItem.getCatalogEntry().getDescription(cmdcontext.getLanguageId()).getShortDescription()%></font></td>
                    				<td align="right" headers="th4"><font class="text"><%=orderItem.getPriceDataBean()%></font></td>
                    				<td align="right" headers="th5"><font class="text"><%=orderItem.getFormattedTotalProduct()%></font></td>
                  				</tr>
                  <% if (itemCount < orderItems.length) { %>
                          <tr>
                            <td colspan="5" class="dgbg" height="1"><img class="imgHeightFix" src="<%=fileDir%>images/c.gif" width="1" height="1" border="0" /></td>
                          </tr>
                  <% }
                } // for j %>
                          <tr>
                            <td colspan="5" class="bbg"><img src="<%=fileDir%>images/c.gif" width="1" height="2" border="0"  class="imgHeightFix" /></td>
                          </tr>
                          <tr>
                            <td align="left" colspan="3" valign="top" colspan="2">
                              <img src="<%=fileDir%>images/ar_blue.gif">&nbsp;<a href="javascript:updateForm(document.ShopCartForm)"><font class="strongtext"><%=storeText.getString("CurrentShopCartDisplay_Update")%>&nbsp;</font></a>
                            </td>
                            <td valign="top"><font class="small"><b><%=storeText.getString("CurrentShopCartDisplay_Subtotal")%></b></font></td>
                            <td align="right" valign="top"><font class="text"><b><%=orderBean.getFormattedTotalProductPrice()%></b></font></td>
                          </tr>
                          <tr>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                          </tr>
                        </form>
                        </table>
                      </td>
                    </tr>
                  </table>
                </td>
              </tr>
              <tr>
                <td>
                  <table width=100% cellpadding=0 cellspacing=0 border=0>
                    <tr>
                      <td valign="top">
                        <table  cellpadding=0 cellspacing=0 border=0> <!-- column 1 - keep shopping -->
                          <tr valign="top">
                            <td>
                              <b><label for="ContShop"><%=storeText.getString("ContinueShopping_Title")%></label></b>
                            </td>
                          </tr>
                          <form name="NavigationForm" METHOD="POST" action="">
                          <tr valign="top">
                            <td>
                              <select id="ContShop" name="Destination" size="1" class="iform" onchange="top.location.href = this.options[this.selectedIndex].value;"> 
                              <span class="small">
                              <option selected value="#"><%=storeText.getString("ContinueShopping_Default")%></option>
           <%                  for (int i = 0; i < topCategories.length; ++i) {
                                tcategory = topCategories[i];
                                tcategoryId = tcategory.getCategoryId(); %>                
                              <option value="CategoryDisplay?catalogId=<%=catalogId%>&storeId=<%=storeId%>&categoryId=<%=tcategoryId%>&langId=<%=languageId%>"><%=tcategory.getDescription().getName()%></option>
          <%                  } %>
                              </span>
                              </select>
                            </td>
                          </tr>
                          </form>
                        </table>              
                      </td>
                      <td valign="top">
                        <table cellpadding=0 cellspacing=0 border=0> <!-- column 2 - save cart / other buttons -->
          <%                if (orderBean.getDescription() == null || orderBean.getDescription().trim().length() == 0) { %>
                          <tr valign="top">
				                    <td valign=top>
                              <table cellpadding=2 cellspacing=0 border=0>
                                <tr valign=top>
                                  <td width=23><img src="<%=fileDir%>images/blue_arrow_button.gif" width="23" height="23" border="0" alt=""></td>
                                  <td nowrap><a href="javascript:saveShopCart(document.ShopCartForm)"><%=storeText.getString("CurrentShopCartDisplay_SaveCart")%></a></td>
                                </tr>
                              </table>
                            </td>
                          </tr>
                          <tr>
                            <td><img src="<%=fileDir%>images/c.gif" width="1" height="10" border="0" /></td>
                          </tr>
         <%                } %>
                          <tr>
                      		  <td>
                              <table cellpadding=2 cellspacing=0 border=0>
                                <tr>
                                  <td width=23><img src="<%=fileDir%>images/blue_arrow_button.gif" width="23" height="23" border="0" alt=""></td>
                                  <td nowrap><a href="javascript:addToFavorites(document.ShopCartForm)"><%=storeText.getString("CurrentShopCartDisplay_AddFavorites")%></a></td>
                                </tr>
                              </table>
                            </td>
                          </tr>
                          <tr>
                            <td><img src="<%=fileDir%>images/c.gif" width="1" height="10" border="0" /></td>
                          </tr>												
                          <tr>
                            <td>
                              <table cellpadding=2 cellspacing=0 border=0>
                                <tr>
                                  <td width=23><img src="<%=fileDir%>images/blue_arrow_button.gif" width="23" height="23" border="0" alt=""></td>
                                  <td><a href="javascript:createOrderForm(document.ShopCartForm)"><%=storeText.getString("CurrentShopCartDisplay_CreateCart")%></a></td>                       
                                </tr>
                              </table>
                            </td>
                          </tr>
                        </table>              
                      </td>
                      <td valign="top">
                        <table cellpadding=0 cellspacing=0 border=0> <!-- column 3 - submit, view quote, print -->
                        <% if ((distributorStoreIds != null) && (distributorStoreIds.length>0)) {
			%>
                          <tr>
                            <td><a href="javascript:requestQuotes(document.ShopCartForm)"><img src="<%=fileDir%><%=locale.toString()%>/images/b_request_quotes.gif" border="0" alt="<%=storeText.getString("Alt_RequestQuotes")%>"></a></td>
                          </tr>
                          <tr><td><img src="<%=fileDir%>images/c.gif" width="1" height="10" border="0" /></td></tr>
			<%} else {%>
                          <tr>
                            <td>
                              <table cellpadding=2 cellspacing=0 border=0>
                                <tr valign="top">
                                  <td width=23><img src="<%=fileDir%>images/blue_arrow_button.gif" width="23" height="23" border="0" alt=""></td>
                                  <td><%=storeText.getString("CurrentShopCartDisplay_NoDistributor", storeName)%></td>
                                </tr>
                              </table>
                            </td>                          
                          </tr>
                        <%
                        }
                        if (orderInitialQuotes > 0) { %>
                          <tr>
                            <td>
                              <table cellpadding=2 cellspacing=0 border=0>
                                <tr>
                                  <td width=23><img src="<%=fileDir%>images/blue_arrow_button.gif" width="23" height="23" border="0" alt=""></td>
                                  <td nowrap><a href="javascript:viewQuote(document.ShopCartForm)"><%=storeText.getString("CurrentShopCartDisplay_ViewInitialQuote")%></a></td>
                                </tr>
                              </table>
                            </td>
                          </tr>
                          <tr><td><img src="<%=fileDir%>images/c.gif" width="1" height="10" border="0" /></td></tr>
                        <% } %>                        											                      
                          <tr>
                            <td>
                              <table cellpadding=2 cellspacing=0 border=0>
                                <tr>
                                  <td width=23><img src="<%=fileDir%>images/blue_arrow_button.gif" width="23" height="23" border="0" alt=""></td>
                                  <td><a href="CurrentShopCartPrintDisplayView?orderId=<%= orderRn %>" target="_blank"><%=storeText.getString("CurrentShopCartDisplay_PrintCart")%></a></td>
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
            </table>
          </td>
        </tr>
      </table>
    </td>
    <!-- End of Main Content TD -->
  </tr>
</table>
<!-- End Main Table -->
<%@ include file="../../../include/FooterDisplay.jspf"%>
</body>
</html>
