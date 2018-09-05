
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
<%@ page import="java.sql.Timestamp" %>
<%@ page import="com.ibm.commerce.order.beans.PRequisitionByMemberIdAndStoreIdListDataBean" %>
<%@ page import="com.ibm.commerce.order.beans.RequisitionDataBean" %>
<%@ page import="com.ibm.commerce.order.utils.OrderConstants" %>
<%@ page import="com.ibm.commerce.order.beans.OrderDataBean" %>
<%@ page import="com.ibm.commerce.order.objects.OrderItemAccessBean" %>
<%@ page import="com.ibm.commerce.catalog.beans.ItemDataBean" %>
<%@ page import="com.ibm.commerce.catalog.common.ECCatalogConstants" %>

<%@ include file="../../../include/EnvironmentSetup.jsp"%>
<% response.setContentType(storeText.getString("ENCODESTATEMENT")); %> 

<%
try {
CommandContext commandContext   = (CommandContext) request.getAttribute(ECConstants.EC_COMMANDCONTEXT);
Long userRefNum         = commandContext.getUserId();

String partNumber       = jhelper.getParameter("partNumber");
String quantity         = jhelper.getParameter("quantity");
String orderId          = jhelper.getParameter("orderId");

request.setAttribute("pageName", "CommercePlazaCatalog");


//My private lists
RequisitionDataBean[] requisitionListsP;  

PRequisitionByMemberIdAndStoreIdListDataBean pReqListDB = new PRequisitionByMemberIdAndStoreIdListDataBean();
pReqListDB.setDataBeanKeyMemberId(userRefNum.toString());
pReqListDB.setDataBeanKeyStoreId(storeId);
com.ibm.commerce.beans.DataBeanManager.activate(pReqListDB, request);
requisitionListsP = pReqListDB.getPRequisitionByMemberIdAndStoreIdList();
String newname = "";

int rows=20; //maximum number to fit in the limit of URL request
String[] strPartNumber   = new String[rows+1];
String[] strQuantity     = new String[rows+1];

for (int i=1; i<(rows+1); i++) 
{
  strPartNumber[i]="";
  strQuantity[i]="";
}

if (partNumber==null) 
{
  partNumber = "";
} else {
  strPartNumber[1]=partNumber; // if passed from item display page
}

if (quantity==null) 
{
  quantity = "";
} else {
  strQuantity[1]=quantity; // if passed from item display page
}

if ((orderId==null) || (orderId.equals(".")) ) // passed from item display page 
{
  newname=storeText.getString("AddtoFavoritesList_UnknownName");
} 
else { // passed from shop cart
  OrderDataBean orderDB       = new OrderDataBean();
  orderDB.setOrderId(orderId);
  com.ibm.commerce.beans.DataBeanManager.activate(orderDB, request);

  newname = orderDB.getDescription();
  if (newname==null || newname.trim().equalsIgnoreCase("Unknown name")) 
  {
    newname = storeText.getString("AddtoFavoritesList_UnknownName");
  } // current shop cart does not have name
  
  OrderItemAccessBean [] orderItemAB   = orderDB.getOrderItems();
  int upperbound = (orderItemAB.length > rows)? rows : orderItemAB.length;
  
  for (int i=1;i<(upperbound+1);i++) {
    ItemDataBean itemDB=new ItemDataBean();
    itemDB.setItemID(orderItemAB[i-1].getCatalogEntryId());
    com.ibm.commerce.beans.DataBeanManager.activate(itemDB, request);                 
    strPartNumber[rows+1-i]=itemDB.getPartNumber();
    Double EJBquantity = orderItemAB[i-1].getQuantityInEJBType();
    if (EJBquantity.intValue() == EJBquantity.doubleValue())
    {
      strQuantity[rows+1-i] = Integer.toString(EJBquantity.intValue());
    }
    else {
      strQuantity[rows+1-i]= Double.toString(EJBquantity.doubleValue());
    }
  }
}
%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "DTD/xhtml1-transitional.dtd">

<html>
<head>
  <title><%=storeText.getString("AddtoFavoritesList_Title")%></title>
  <link rel=stylesheet href="<%=fileDir%>PCDMarket.css" type="text/css">
</head>


<body marginheight="0" marginwidth="0" leftmargin="0" topmargin="0" onLoad="if (typeof top.updateStInfo == 'function') top.updateStInfo();">
<%@ include file="../../../include/HeaderDisplay.jspf"%>

<table border="0" cellpadding="0" cellspacing="0" width="750">
<tr>
  <td valign="top" class="dbg" width="150">

    <%
    String incfile = includeDir + "SidebarDisplay.jsp";
    %>
    <jsp:include page="<%=incfile%>" flush="true"/>
    
  </td>

  <td width="10"><a name="mainContent"></a><img height="1" alt="" src="<%=fileDir%>images/c.gif" /></td>
  
  <td valign="top" width="590">
  <!--START MAIN CONTENT-->
    <table width="590" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="590" colspan="2"><span class="bct">&nbsp;&nbsp;&nbsp;</span>
            <a class="bctl" href="StoreCatalogDisplay?storeId=<%=storeId%>&catalogId=<%=catalogId%>&langId=<%=languageId%>"><%=storeText.getString("Breadcrumb_CommercePlaza")%></a><span class="bct">&nbsp;&nbsp;&nbsp;&gt;&nbsp;&nbsp;&nbsp;</span>
            <font class="bct"><%=storeText.getString("Breadcrumb_SelectItems")%></font>
          </td>
        </tr>
        <tr>
          <td valign="top" width="320">
            <div align="left" class="title">
              <img src="<%=fileDir%>images/c.gif" width="1" height="11" border="0" /><br />
              <%=storeText.getString("AddtoFavoritesList_Title")%>
            </div>
          </td>
          <td valign="top" width="280">
            <div align="right">
              <img src="<%=fileDir%>images/hdr_products.gif" width="280" height="72" alt="<%=storeText.getString("AddtoFavoritesList_Title")%>" />
            </div>
          </td>
        </tr>
        <tr>
          <td width="590" colspan="2">&nbsp;</td>
        </tr>
    </table>
      
    <table width="590" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td>
          <table>
            <tr>
              <td align="right"><img alt="<%=storeText.getString("AddtoFavoritesList_AddToExisting")%>" src="<%=fileDir%>images/arrow_rd.gif"  border=0 /></td>
              <td><label for="AddToFavorites"><%=storeText.getString("AddtoFavoritesList_AddToExisting")%></label></td>
            </tr>
            <tr>
              <td>&nbsp;</td>
              <td><form name="FavoritesListForm" action="RequisitionListItemUpdate" method="post">
                  <input type="hidden" name="URL" value="FavoritesListUpdateFormView">
                  <input type="hidden" name="<%= ECCatalogConstants.EC_CAT_MAN_CATALOGID %>" value="<%= catalogId %>">
<%
for (int i=1; i<(rows+1); i++)
{
%>  
                  <input type="hidden" name="partNumber_<%=i%>" value="<%=strPartNumber[i]%>">
                  <input type="hidden" name="quantity_<%=i%>" value="<%=strQuantity[i]%>">
<%
}
%>
                  <select onchange="javascript:document.FavoritesListForm.submit()" id="AddToFavorites" name="requisitionListId" width="120">
                    <option select><%=storeText.getString("AddtoFavoritesList_Select")%></option>
                    <%
                    for (int i=0; i<requisitionListsP.length; i++) {
                      String listName = requisitionListsP[i].getDescription();
                      if (listName==null || listName.trim().equalsIgnoreCase("Unknown name")) 
                      {
                        listName = storeText.getString("AddtoFavoritesList_UnknownName");
                      } 
                    %>
                    <option value="<%=requisitionListsP[i].getOrderId()%>"><%= listName %></option>
                    <%
                    }
                    %>
                  </select>
              </form></td>
            </tr>
            <tr>
              <td align="right"><img alt="<%=storeText.getString("AddtoFavoritesList_Create")%>" src="<%=fileDir%>images/arrow_rd.gif"  border=0 /></td>
              <%
              if (partNumber.equals("")) {
              %>
              <td><a href="RequisitionListCopy?URL=FavoritesListUpdateFormView&orderId=<%=orderId%>&name=<%=java.net.URLEncoder.encode(newname)%>"><%=storeText.getString("AddtoFavoritesList_Create")%></a></td>
              <%
              } else {
              %>
              <td><a href="RequisitionListItemUpdate?URL=FavoritesListUpdateFormView&orderDesc=<%=java.net.URLEncoder.encode(newname)%>&partNumber_1=<%=partNumber%>&quantity_1=<%=quantity%>"><%=storeText.getString("AddtoFavoritesList_Create")%></a></td>
              <%
              }
              %>
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
<%
} catch (Exception e) {
	out.println(e);
}
%>