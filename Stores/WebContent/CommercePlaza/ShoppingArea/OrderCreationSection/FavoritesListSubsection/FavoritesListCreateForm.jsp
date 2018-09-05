
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
<%@ page import="com.ibm.commerce.catalog.beans.ProductDataBean" %>
<%@ page import="com.ibm.commerce.order.utils.OrderConstants"   %>
<%@ page import="com.ibm.commerce.datatype.TypedProperty" %>
<%@ page import="com.ibm.commerce.ras.ECMessageKey" %>
<%@ page import="com.ibm.commerce.order.ras.WcOrderMessageKey" %>
<%@ page import="com.ibm.commerce.catalog.common.ECCatalogConstants" %>

<%@ include file="../../../include/EnvironmentSetup.jsp"%>
<% response.setContentType(storeText.getString("ENCODESTATEMENT")); %> 

<jsp:useBean id="bnError" class="com.ibm.commerce.beans.ErrorDataBean" scope="page">
<% 
com.ibm.commerce.beans.DataBeanManager.activate(bnError, request); 
%>
</jsp:useBean>

<%
String partNumber     = jhelper.getParameter("partNumber");
String quantity       = jhelper.getParameter("quantity");

request.setAttribute("pageName", "CommercePlazaCatalog");

if (partNumber==null) {partNumber = "";}
if (quantity==null) {quantity = "";}

int rows=15;
String[] strPartNumber     = new String[rows+1];
String[] strQuantity     = new String[rows+1];
String strName       = null;
String strErrorMessage     = null;

String strFieldName     = null;
Object strMessageParams[]   = null;
String strMessageKey     = bnError.getMessageKey();

if (strMessageKey != null && strMessageKey.length() > 0) {
  // We have an error


  strMessageParams = bnError.getMessageParam();
  if (strMessageKey.equals(WcOrderMessageKey._ERR_MISSING_COMMAND_PARAMETERS)) {
    strErrorMessage = storeText.getString("NewFavoritesList_Error_Missing_Parameter");
  }  else if (strMessageKey.equals(ECMessageKey._ERR_GETTING_SKU)) {
    TypedProperty nvps = bnError.getExceptionData();
    if (nvps != null) {
      String catEntryId = nvps.getString("catEntryId");
      ProductDataBean prodDB=new ProductDataBean();
      prodDB.setProductID(catEntryId);
      com.ibm.commerce.beans.DataBeanManager.activate(prodDB, request); 
      StringBuffer sbTemp = new StringBuffer(storeText.getString("NewFavoritesList_Error_ProdPartNumber"));
      sbTemp.append("&nbsp;&nbsp;");
      sbTemp.append(prodDB.getPartNumber());
      strErrorMessage = sbTemp.toString();
    }

  }  else if (strMessageKey.equals(ECMessageKey._ERR_PROD_NOT_EXISTING)) {
    strFieldName = (String)strMessageParams[0];
    StringBuffer sbTemp = new StringBuffer(storeText.getString("NewFavoritesList_Error_PartNumber"));
    sbTemp.append("&nbsp;&nbsp;");
    sbTemp.append(strFieldName);
    strErrorMessage = sbTemp.toString();
  } else if (strMessageKey.equals(ECMessageKey._ERR_INVALID_INPUT)) {
    StringBuffer sbTemp = new StringBuffer(storeText.getString("NewFavoritesList_Error_Quantity"));
    sbTemp.append("&nbsp;&nbsp;");
    sbTemp.append(jhelper.getParameter("quantity"));
    strErrorMessage = sbTemp.toString();    
  }
  //Retrieve form data entered before
  strName = jhelper.getParameter("orderDesc");
  for (int i=1; i<rows+1; i++) {
    strPartNumber[i] = jhelper.getParameter("partNumber_"+(rows-i+1));
    strQuantity[i] = jhelper.getParameter("quantity_"+(rows-i+1));
    if (strPartNumber[i]==null) {strPartNumber[i] = "";}
    if (strQuantity[i]==null) {strQuantity[i] = "";}
  }

} else {
  //If the form is loaded by clicking "Create New Requisition List" from the Requisition List Display page, initialize all fields to empty.
  //If the form is loaded by adding item to new requisition list from item display page, initialize the first pair of PartNumber and quantity.
  strName = "";

  for (int i=1; i<rows+1; i++) {
    strPartNumber[i] = "";
    strQuantity[i] = "";
  }  
  strPartNumber[1] = partNumber;
  strQuantity[1] = quantity;
}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "DTD/xhtml1-transitional.dtd">

<script language="javascript">
function Add2ReqList(form)
{
  var i;
  var rows=15;
  
  for (i=0;i<rows;i++) 
  {
  if (( !(form.elements[i*2+3].value == "")) && (form.elements[i*2+4].value == ""))
  {
    form.elements[i*2+4].value = "1";
  }

  }

  form.submit();


}
</script>

<html>
<head>
  <title><%=storeText.getString("NewFavoritesList_Title")%></title>
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

  <td width="10"><img height="1" alt="" src="<%=fileDir%>images/c.gif" /></td>
  
  <td valign="top" width="590"><a name="mainContent"></a>
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
            <div align="left" class="title">
              <img src="<%=fileDir%>images/c.gif" width="1" height="11" border="0" /><br />
              <%=storeText.getString("NewFavoritesList_Title")%>
            </div>
          </td>
          <td width="280">
            <div align="right">
              <img src="<%=fileDir%>images/hdr_products.gif" width="280" height="70" alt="<%=storeText.getString("NewFavoritesList_Title")%>" />
            </div>
          </td>
        </tr>
    </table>
      
    <table width="590" border="0" cellspacing="0" cellpadding="0">
      <tr valign="top">
        <td>
        
        <%
        if (strErrorMessage != null)
          {
          //Display error messages
          %><font color="red"><%=strErrorMessage%></font><%
          }
        %>
                  
        <form name="NewFavoritesListForm" action="RequisitionListItemUpdate" method="post">
        <input type=hidden name="<%= ECConstants.EC_URL %>" value="FavoritesListUpdateFormView?<%= ECCatalogConstants.EC_CAT_MAN_CATALOGID %>=<%= catalogId %>&partNumber_*=&quantity_*=">
        <input type=hidden name="errorViewName" value="FavoritesListCreateFormView">

          <table cellspacing="0" border="0" cellpadding="0">
            <tr>
              <td><span class=small style="FONT-WEIGHT: bold"><label for="orderDesc"><%=storeText.getString("NewFavoritesList_Name")%></label>&nbsp;&nbsp;</span></td>
            </tr>
            <tr>
              <td><span><input type="text" id="orderDesc" name="orderDesc" value="<%=strName%>" class=iform size="20"></span></td>
            </tr>
            <tr>
              <td>&nbsp;</td>
            </tr>
            <tr>
              <td><span class=small ><%=storeText.getString("NewFavoritesList_UsageText")%></span></td>
            </tr>
          </table>
          
          <table width="590" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td valign="top">
                <table width="590" cellpadding="0" border="0" cellspacing="0">
                  <tr>
                    <td class=tdblue>&nbsp;&nbsp;<%=storeText.getString("NewFavoritesList_SubTitle")%></td>
                  </tr>
                </table>
              </td>
            </tr>
            <tr>
              <td>          
                <table width="590" cellpadding="0" border="0" cellspacing="1">
                  <tr class="verylightgrey_bg">
                    <th width="10" id="th1" class="mbg">&nbsp;</th>
                    <th class="mbg"><span class=small style="FONT-WEIGHT: bold" id="th2">&nbsp;<label for="partNumText"><%=storeText.getString("NewFavoritesList_PartNumber")%></label></span></th>
                    <th class="mbg"><span class=small style="FONT-WEIGHT: bold" id="th3">&nbsp;<label for="quantityText"><%=storeText.getString("NewFavoritesList_Quantity")%></label></span></th>
                  </tr>    
                  <tr>
                    <td width="10" headers="th1"><div align="right"><span class="small">1</span></div></td>
                    <td headers="th2">&nbsp;<input type="text" class="iform" size="8" name="partNumber_<%=rows%>" value="<%=strPartNumber[1]%>" id="partNumText"></td>
                    <td headers="th3">&nbsp;<input type="text" class="iform" size="6" name="quantity_<%=rows%>" value="<%=strQuantity[1]%>" id="quantityText"></td>
                  </tr>
                  <tr>
                    <td valign="top" colspan="3" class="lightgrey_bg"><img class="imgHeightFix" src="<%=fileDir%>images/c.gif" width="100%" height="1" border="0" /></td>
                  </tr>
                <%
                for (int i=1;i<(rows-1);i++) {
                %>
                  <tr>
                    <td width="10" headers="th1"><div align="right"><span class=small><%= i+1 %></span></div></td>
                    <td headers="th2">
                    <label for="partNumText_<%= rows-i %>"><img src="<%=fileDir%>images/trans.gif" height="1" width="1" border="0" alt="<%=storeText.getString("NewFavoritesList_PartNumber")%>"/></label>
                    &nbsp;<input type="text" class=iform size="8" name="partNumber_<%= rows-i %>" value="<%=strPartNumber[i+1]%>" id="partNumText_<%= rows-i %>"></td>
                    <td headers="th3">
                    <label for="quantityText_<%= rows-i %>"><img src="<%=fileDir%>images/trans.gif" height="1" width="1" border="0" alt="<%=storeText.getString("NewFavoritesList_Quantity")%>"/></label>
                    &nbsp;<input type="text" class=iform size="6" name="quantity_<%= rows-i %>" value="<%=strQuantity[i+1]%>" id="quantityText_<%= rows-i %>"></td>
                  </tr>
                  <tr>
                    <td valign="top" colspan="3" class="lightgrey_bg"><img class="imgHeightFix" src="<%=fileDir%>images/c.gif" width="100%" height="1" border="0" /></td>
                  </tr>
                <%
                }
                %>
                  <tr>
                    <td width="10" headers="th1"><div align="right"><span class=small><%=rows%></span></div></td>
                    <td headers="th2">
                    <label for="partNumText_1"><img src="<%=fileDir%>images/trans.gif" height="1" width="1" border="0" alt="<%=storeText.getString("NewFavoritesList_PartNumber")%>"/></label>
                    &nbsp;<input type="text" class=iform size="8" name="partNumber_1" value="<%=strPartNumber[rows]%>" id="partNumText_1"></td>
                    <td headers="th3">
                    &nbsp;<label for="quantityText_1"><img src="<%=fileDir%>images/trans.gif" height="1" width="1" border="0" alt="<%=storeText.getString("NewFavoritesList_Quantity")%>"/></label>
                    <input type="text" class=iform size="6" name="quantity_1" value="<%=strQuantity[rows]%>" id="quantityText_1"></td>
                    
                  </tr>
                  <tr>
                    <td class="white_bg" colspan="3" ><img class="imgHeightFix" src="<%=fileDir%>images/c.gif" width="1" height="2" border="0" /></td>
                  </tr>
                  <tr>
                    <td class="black_bg" colspan="3" ><img class="imgHeightFix" src="<%=fileDir%>images/c.gif" width="1" height="24" border="0" /></td>
                  </tr>
                  <tr>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td align="left">&nbsp;&nbsp;<a href="javascript:Add2ReqList(document.NewFavoritesListForm)"><img alt="<%=storeText.getString("Alt_Save")%>" src="<%=fileDir%><%=locale.toString()%>/images/b_save.gif"  border="0" /></a></td>
                  </tr>                            
                </table>
              </td>
            </tr>
          </table>
        </form>
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
