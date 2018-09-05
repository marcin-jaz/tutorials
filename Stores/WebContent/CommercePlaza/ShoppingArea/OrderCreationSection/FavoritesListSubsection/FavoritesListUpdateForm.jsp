
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

<% // All JSPs requires these packages for EnvironmentSetup.jsp which is used for multi language support %> 
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.ibm.commerce.server.ECConstants" %>
<%@ page import="com.ibm.commerce.server.JSPHelper" %>
<%@ page import="com.ibm.commerce.command.CommandContext" %>

<% // Page specific imports%> 
<%@ page import="com.ibm.commerce.beans.DataBeanManager" %>
<%@ page import="com.ibm.commerce.beans.ErrorDataBean" %>
<%@ page import="com.ibm.commerce.ras.ECMessageKey" %>
<%@ page import="com.ibm.commerce.order.beans.OrderDataBean" %>
<%@ page import="com.ibm.commerce.order.objects.OrderItemAccessBean" %>
<%@ page import="com.ibm.commerce.datatype.TypedProperty" %>
<%@ page import="com.ibm.commerce.catalog.beans.CatalogDataBean" %>
<%@ page import="com.ibm.commerce.catalog.beans.ProductDataBean" %>
<%@ page import="com.ibm.commerce.catalog.beans.ItemDataBean" %>
<%@ page import="com.ibm.commerce.order.utils.OrderConstants" %>
<%@ page import="com.ibm.commerce.catalog.common.ECCatalogConstants" %>
<%@ page import="com.ibm.commerce.order.beans.*" %>

<%@ include file="../../../include/EnvironmentSetup.jsp"%>
<% response.setContentType(storeText.getString("ENCODESTATEMENT")); %> 

<jsp:useBean id="bnError" class="com.ibm.commerce.beans.ErrorDataBean" scope="page">
<% 
com.ibm.commerce.beans.DataBeanManager.activate(bnError, request); 
%>
</jsp:useBean>

<%
String requisitionListId     = jhelper.getParameter("requisitionListId");

request.setAttribute("pageName", "CommercePlazaCatalog");

OrderDataBean orderDB       = new OrderDataBean();
orderDB.setOrderId(requisitionListId);
com.ibm.commerce.beans.DataBeanManager.activate(orderDB, request);
// OrderItemAccessBean [] orderItemAB   = orderDB.getOrderItems();
OrderItemDataBean [] orderItemAB   = orderDB.getOrderItemDataBeans();


String listName = orderDB.getDescription();
if (listName==null || listName.trim().equalsIgnoreCase("Unknown name")) 
{
  listName = storeText.getString("AddtoFavoritesList_UnknownName");
} 


String strNewPartNumber     = "";
String strNewQuantity       = "";
String strQuantity       = "";

String strErrorMessage       = null;
String strFieldName       = null;
Object strMessageParams[]     = null;
String strMessageKey       = bnError.getMessageKey();

if (strMessageKey != null && strMessageKey.length() > 0) {
  // We have an error

  strMessageParams = bnError.getMessageParam();
  if (strMessageKey.equals(ECMessageKey._ERR_GETTING_SKU)) {
    TypedProperty nvps = bnError.getExceptionData();
    if (nvps != null) {
      String catEntryId = nvps.getString("catEntryId");
      ProductDataBean prodDB=new ProductDataBean();
      prodDB.setProductID(catEntryId);
      com.ibm.commerce.beans.DataBeanManager.activate(prodDB, request); 
      StringBuffer sbTemp = new StringBuffer(storeText.getString("EditFavoritesList_Error_PartNumber"));
      sbTemp.append("&nbsp;&nbsp;");
      sbTemp.append(prodDB.getPartNumber());
      strErrorMessage = sbTemp.toString();	      
    }
  } else if (strMessageKey.equals(ECMessageKey._ERR_PROD_NOT_EXISTING)) {
    strFieldName = (String)strMessageParams[0];
    StringBuffer sbTemp = new StringBuffer(storeText.getString("EditFavoritesList_Error_PartNumber"));
    sbTemp.append("&nbsp;&nbsp;");
    sbTemp.append(strFieldName);
    strErrorMessage = sbTemp.toString();	          
  } else if (strMessageKey.equals(ECMessageKey._ERR_INVALID_INPUT)) {
    strQuantity = jhelper.getParameter("quantity");
    StringBuffer sbTemp = new StringBuffer(storeText.getString("EditFavoritesList_Error_Quantity"));
    sbTemp.append("&nbsp;&nbsp;");
    sbTemp.append(strQuantity);
    strErrorMessage = sbTemp.toString();    

  }

  //Retrieve form data entered before

  strNewPartNumber = jhelper.getParameter(OrderConstants.EC_PART_NUMBER);
  if (strNewPartNumber==null) { strNewPartNumber=""; }
  strNewQuantity = jhelper.getParameter("strNewQuantity");
  if (strNewPartNumber=="") { strNewQuantity=""; }

} 
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "DTD/xhtml1-transitional.dtd">
<script language="javascript">

function Add2ReqList(form)
{
  form.quantity.value = form.strNewQuantity.value;
  if (form.strNewQuantity.value == "") {
  form.quantity.value = "1";
  }
  form.submit();
}

</script>

<html>
<head>
  <title><%=storeText.getString("EditFavoritesList_Title")%></title>
  <link REL=stylesheet HREF="<%=fileDir%>PCDMarket.css" TYPE="text/css">
</head>


<body marginheight="0" marginwidth="0" leftmargin="0" topmargin="0" onLoad="if (typeof top.updateStInfo == 'function') top.updateStInfo();">
<!-- Start Header -->
<%@ include file="../../../include/HeaderDisplay.jspf"%>
<!-- End Header -->

<!-- Start Main Table - Consists of TD for Left Bar, TD for Content and TD for Quicklinks -->
<table border="0" cellpadding="0" cellspacing="0" width="750">
<tr>
  <td valign="top" class="dbg" width="150"> 

    <%
    String incfile = includeDir + "SidebarDisplay.jsp";
    %>
    <jsp:include page="<%=incfile%>" flush="true" />

  </td>

  <td width="10"><a name="mainContent"></a><img alt="" src="<%=fileDir%>images/c.gif" height="1" /></td>

  <td valign="top" width="590">
  <!--START MAIN CONTENT-->        
      
    <table width="590" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="590" height="20" colspan="2"><span class="bct">&nbsp;&nbsp;&nbsp;</span>
          <a class="bctl" href="StoreCatalogDisplay?storeId=<%=storeId%>&catalogId=<%=catalogId%>&langId=<%=languageId%>"><%=storeText.getString("Breadcrumb_CommercePlaza")%></a><span class="bct">&nbsp;&nbsp;&nbsp;&gt;&nbsp;&nbsp;&nbsp;</span>
          <font class="bct"><%=storeText.getString("Breadcrumb_SelectItems")%></font>
        </td>
      </tr>
      <tr valign="top">
        <td width="320">
          <table border="0" cellspacing="0" cellpadding="0">
            <tr valign="top">
              <td>
                <div align="left" class="title">
                  <img src="<%=fileDir%>images/c.gif" width="1" height="11" border="0" /><br />
                  <%=storeText.getString("EditFavoritesList_Title")%>
                </div>
              </td>
            </tr>
            <tr valign="top">
              <td>
                <div align="left" class="subtitle">
                  <%= listName %>
                </div>
              </td>
            </tr>
          </table>
        </td>
        <td valign="top" width="280">
            <div align="right">
              <img src="<%=fileDir%>images/hdr_products.gif" width="280" height="70" alt="<%=storeText.getString("EditFavoritesList_Title")%>" />
            </div>
          </td>
        </tr>
      </table>

    <%
    if (strErrorMessage != null)
    {
      //Display error messages
      %><font color="red"><%=strErrorMessage%></font><%
    }
    %>
      
    <table width="590" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td><form name="FavoritesListNameForm" action="RequisitionListUpdate" method="post">
          <input type=hidden name="<%= OrderConstants.EC_REQUISITION_LIST_ID %>" value="<%= requisitionListId %>">
          <input type=hidden name="<%= ECConstants.EC_URL %>" value="FavoritesListUpdateFormView?<%= ECCatalogConstants.EC_CAT_MAN_CATALOGID %>=<%= catalogId %>&<%= OrderConstants.EC_REQUISITION_LIST_ID %>=<%= requisitionListId %>">
          <table border="0" cellpadding="0" cellspacing="0">
            <tr>
              <td colspan="3"><span class=small style="FONT-WEIGHT: bold"><label for="favlistname"><%=storeText.getString("EditFavoritesList_ChangeName")%></label></span><td>
            </tr>
            <tr>
              <td><span><input class=iform size="20" type="text" name="name" id="favlistname" value="<%= listName %>"></span></td>
              <td align="right">&nbsp;<a href="javascript:document.FavoritesListNameForm.submit()"><img alt="<%=storeText.getString("EditFavoritesList_Save")%>" src="<%=fileDir%>images/arrow_rd.gif"  border=0 /></a></td>
              <td>&nbsp;<a href="javascript:document.FavoritesListNameForm.submit()"><%=storeText.getString("EditFavoritesList_Save")%></a></td>          
            </tr>
          </table>
        </form></td>
      </tr>
    </table>

    <table border="0" cellpadding="0" cellspacing="0" width="590">
      <tr>
        <td><span class=small><%=storeText.getString("EditFavoritesList_UsageText")%></span></td>
      </tr>    
      <tr>
        <td>
          <form name="AddFavoritesListItemForm" action="RequisitionListItemUpdate" method="post">
          <input type=hidden name="<%= OrderConstants.EC_REQUISITION_LIST_ID %>" value="<%= requisitionListId %>">
          <input type=hidden name="<%= ECConstants.EC_URL %>" value="FavoritesListUpdateFormView?<%= ECCatalogConstants.EC_CAT_MAN_CATALOGID %>=<%= catalogId %>">
          <input type=hidden name="quantity" value="">
          <input type=hidden name="errorViewName" value="FavoritesListUpdateFormView">

          <table border="0" cellpadding="0" cellspacing="0">
            <tr>
              <td><span class=small style="FONT-WEIGHT: bold"><label for="favpartnum"><%=storeText.getString("EditFavoritesList_PartNumber")%></label></span></td>
              <td>&nbsp;<span class=small style="FONT-WEIGHT: bold"><label for="favquantity"><%=storeText.getString("EditFavoritesList_Quantity")%></label></span></td>
              <td>&nbsp;</td>
            </tr>
            <tr>
              <td><input class=iform type="text" name="<%= OrderConstants.EC_PART_NUMBER %>" id="favpartnum" value="<%=strNewPartNumber%>"></td>
              <td>&nbsp;<input class=iform type="text" name="strNewQuantity" id="favquantity" value="<%=strNewQuantity%>"></td>
              <td>
                <table border="0" cellpadding="0" cellspacing="0">
                  <tr>
                    <td align="right">&nbsp;<a href="javascript:Add2ReqList(document.AddFavoritesListItemForm)"><img alt="<%=storeText.getString("EditFavoritesList_Add")%>" src="<%=fileDir%>images/arrow_rd.gif"  border=0 /></a></td>
                    <td>&nbsp;<a href="javascript:Add2ReqList(document.AddFavoritesListItemForm)"><%=storeText.getString("EditFavoritesList_Add")%></a></td>
                  </tr>
                </table>
              </td>
            </tr>
          </table>
          </form>
          
          <form method="post" name="UpdateFavoritesListItemForm" action="RequisitionListItemUpdate">
          <input type=hidden name="<%= ECConstants.EC_URL %>" value="FavoritesListUpdateFormView?<%= ECCatalogConstants.EC_CAT_MAN_CATALOGID %>=<%= catalogId %>&orderItemId_*=&quantity_*=">
          <input type=hidden name="<%= OrderConstants.EC_REQUISITION_LIST_ID %>" value="<%= requisitionListId %>">
          <input type=hidden name="errorViewName" value="FavoritesListUpdateFormView">
            <table width="590" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td valign="top">
                   <table width="590" cellpadding="0" border="0" cellspacing="0">
                    <tr>          
                      <td class=tdblue>&nbsp;&nbsp;<%=storeText.getString("EditFavoritesList_SubTitle")%></td>
                    </tr>
                  </table>
                </td>
              </tr>
              <tr valign="top">
                <td>    
                  <table cellpadding="0" cellspacing="1" border="0" width="591">
                    <tr class="verylightgrey_bg" valign="top">
                      <th id="th1" class="mbg">&nbsp;<span class=small style="FONT-WEIGHT: bold"><%=storeText.getString("EditFavoritesList_Quantity")%></span></th>
                      <th id="th2" class="mbg">&nbsp;<span class=small style="FONT-WEIGHT: bold"><%=storeText.getString("EditFavoritesList_PartNumber")%></span></th>
                      <th id="th3" class="mbg">&nbsp;<span class=small style="FONT-WEIGHT: bold"><%=storeText.getString("EditFavoritesList_Description")%></span></th>
                    </tr>
  
  <%
  for (int i=0;i<orderItemAB.length;i++) {
    ItemDataBean itemDB=new ItemDataBean();
    itemDB.setItemID(orderItemAB[i].getCatalogEntryId());
    com.ibm.commerce.beans.DataBeanManager.activate(itemDB, request); 

    // Double quantity = orderItemAB[i].getQuantityInEJBType();
    String strFormattedQuantity = orderItemAB[i].getFormattedQuantity();
    
    int j=i+1;
  %>
                    <tr>
                      <td headers="th1">
                        <table border="0" cellpadding="0" cellspacing="0">
                          <tr>
                            <td><input type=hidden name="orderItemId_<%= j %>" value="<%= orderItemAB[i].getOrderItemId() %>" ></td>
                            <td><label for="qty_<%= j %>"><img src="<%=fileDir%>images/trans.gif" height="1" width="1" border="0" alt="<%=storeText.getString("EditFavoritesList_Quantity")%>"/></label>
                            &nbsp;<span><input headers="th1" type="text" class=iform size="4" maxlength="256" name="quantity_<%= j %>" id="qty_<%= j %>" value="<%= strFormattedQuantity %>"></span></td>
                            <td><span class=small><a href="RequisitionListItemUpdate?<%= ECCatalogConstants.EC_CAT_MAN_CATALOGID %>=<%= catalogId %>&quantity=0&<%= ECConstants.EC_URL %>=FavoritesListUpdateFormView&<%= OrderConstants.EC_REQUISITION_LIST_ID %>=<%= requisitionListId %>&<%= OrderConstants.EC_ORDERITEM_ID %>=<%= orderItemAB[i].getOrderItemId() %>"><img alt="<%=storeText.getString("EditFavoritesList_Remove")%>" src="<%=fileDir%>images/icn_trash.gif"  border="0" /></a></span></td>
                          </tr>
                        </table>  
                      </td>  
                      <td headers="th2">&nbsp;<span class=small><a href="ProductDisplay?<%= ECCatalogConstants.EC_CAT_MAN_CATALOGID %>=<%= catalogId %>&storeId=<%= storeId %>&productId=<%=orderItemAB[i].getCatalogEntryId() %>&langId=<%= languageId %>"><%= itemDB.getPartNumber() %></a></span></td>
                      <td headers="th3">&nbsp;<span class=small><%= itemDB.getDescription().getShortDescription() %></span></td>
                      
                    </tr>
                    <%
                    if (j<orderItemAB.length) {
                    %>                                               
                    <tr>
                      <td valign="top" colspan="3" class="lightgrey_bg"><img class="imgHeightFix" src="<%=fileDir%>images/c.gif" width="100%" height="1" border="0" /></td>
                    </tr>
                    <%
                    }//end if
                    %>
  <%  
  }// end for
  %>  
                    <tr>
                      <td class="black_bg" colspan="3" ><img class="imgHeightFix" src="<%=fileDir%>images/c.gif" width="1" height="2" border="0" /></td>
                    </tr>
                  <% 
                  if (orderItemAB.length>0) {
                  %>
                    <tr valign="top">
                      <td colspan="3" align="left"><a href="javascript:document.UpdateFavoritesListItemForm.submit()"><img src="<%=fileDir%>images/ar_blue.gif" width="7" height="7" border="0" alt="<%=storeText.getString("EditFavoritesList_UpdateQuantity")%>"><%=storeText.getString("EditFavoritesList_UpdateQuantity")%></a></td>
                    </tr>
                  <%
                  }
                  %>
                  </table>
                </td>
              </tr>
            </table>
          </form>
                
          <table width="590" border="0" cellspacing="0" cellpadding="0">
          <% 
          if (orderItemAB.length>0) { //display button add list to cart
          %>    
              <tr valign="top">
                <td align="left">
                  <form name="OrderItemAddForm" action="OrderItemAdd" method="post">
                     <input type="hidden" name="storeId" value="<%=storeId%>">
                     <input type="hidden" name="orderId" value=".">
                     <input type="hidden" name="langId" value="<%=languageId%>">
                     <input type="hidden" name="<%= ECCatalogConstants.EC_CAT_MAN_CATALOGID %>" value="<%=catalogId%>">
                     <input type="hidden" name="URL" value="OrderItemDisplay?<%= ECCatalogConstants.EC_CAT_MAN_CATALOGID %>=<%= catalogId %>&orderId=.">
                     <input type="hidden" name="check" value="*n">
                     <input type="hidden" name="allocate" value="*n">
                     <input type="hidden" name="reverse" value="*n">
                     <input type="hidden" name="backorder" value="*n">
          
                   <%
                   for (int k=0; k<orderItemAB.length; k++) {
                     Double quantity = orderItemAB[k].getQuantityInEJBType();
                   %>
                     <input type=hidden name="catEntryId_<%= k %>" value="<%= orderItemAB[k].getCatalogEntryId() %>" >
                     <input type=hidden name="quantity_<%= k %>" value="<%= quantity.intValue() == quantity.doubleValue() ? Integer.toString(quantity.intValue()) : Double.toString(quantity.doubleValue()) %>">
                   <%
                   }//end for
                   %>
                  </form>          
                  <table border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td align="left"><a href="javascript:document.OrderItemAddForm.submit()"><img alt="<%=storeText.getString("EditFavoritesList_AddListToCart")%>" src="<%=fileDir%><%=locale.toString()%>/images/b_addlisttocart.gif"  border=0 /></a></td>
                    </tr>
                  </table>
                </td>
              </tr>

              <tr>
                <td colspan="2"><img src="<%=fileDir%>images/c.gif" width="1" height="15" border="0" /></td>
              </tr>
          <%
          }//end if
          %>
              <tr valign="top">
                <td colspan="2" align="left">
                  <table border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td align="left"><a href="FavoritesListDisplayView?<%= ECCatalogConstants.EC_CAT_MAN_CATALOGID %>=<%= catalogId %>"><img alt="<%=storeText.getString("EditFavoritesList_ViewAllList")%>" src="<%=fileDir%>images/arrow_rd.gif"  border=0 /></a></td>
                      <td>&nbsp;<a href="FavoritesListDisplayView?<%= ECCatalogConstants.EC_CAT_MAN_CATALOGID %>=<%= catalogId %>"><%=storeText.getString("EditFavoritesList_ViewAllList")%></a></td>
                    </tr>
                  </table>
                </td>
              </tr>
              <tr valign="top">
                <td colspan="2"><img src="<%=fileDir%>images/c.gif" width="1" height="15" border="0" /></td>
              </tr>
          </table>
        </td>
      </tr>
    </table>
    <!--END MAIN CONTENT-->
  </td>
</tr>
</table>
<%@ include file="../../../include/FooterDisplay.jspf"%>
</body>
</html>