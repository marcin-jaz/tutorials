
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
<%@ page import="com.ibm.commerce.utils.TimestampHelper" %>
<%@ page import="com.ibm.commerce.order.utils.OrderConstants"   %>
<%@ page import="com.ibm.commerce.order.beans.PRequisitionByMemberIdAndStoreIdListDataBean" %>
<%@ page import="com.ibm.commerce.order.beans.RequisitionDataBean" %>
<%@ page import="com.ibm.commerce.catalog.common.ECCatalogConstants" %>

<%@ page import="java.sql.Timestamp" %>

<%@ include file="../../../include/EnvironmentSetup.jsp"%>
<% response.setContentType(storeText.getString("ENCODESTATEMENT")); %> 

<%
CommandContext commandContext   = (CommandContext) request.getAttribute(ECConstants.EC_COMMANDCONTEXT);
Long userRefNum         = commandContext.getUserId();

String partNumber       = jhelper.getParameter("partNumber");
String quantity         = jhelper.getParameter("quantity");

request.setAttribute("pageName", "CommercePlazaCatalog");

if (partNumber==null) { partNumber = "";}
if (quantity==null) { quantity = "";}


Timestamp lastUpdate       = null;
String formattedLastUpdate     = "";

// Get locale for formatting the date appropriately
Locale jLocale         = commandContext.getLocale();

//My private lists
RequisitionDataBean[] requisitionListsP;  

PRequisitionByMemberIdAndStoreIdListDataBean pReqListDB = new PRequisitionByMemberIdAndStoreIdListDataBean();
pReqListDB.setDataBeanKeyMemberId(userRefNum.toString());
pReqListDB.setDataBeanKeyStoreId(storeId);
com.ibm.commerce.beans.DataBeanManager.activate(pReqListDB, request);
requisitionListsP = pReqListDB.getPRequisitionByMemberIdAndStoreIdList();

%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "DTD/xhtml1-transitional.dtd">

<html>
<head>
  <title><%=storeText.getString("FavoritesList_Title")%></title>
  <link REL=stylesheet HREF="<%=fileDir%>PCDMarket.css" TYPE="text/css">
</head>


<body marginheight="0" marginwidth="0" leftmargin="0" topmargin="0" onLoad="if (typeof top.updateStInfo == 'function') top.updateStInfo();">
<%@ include file="../../../include/HeaderDisplay.jspf"%>
<!-- Start Main Table -->
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
        <tr valign="top">
          <td width="320">
            <div align="left" class="title">
              <img src="<%=fileDir%>images/c.gif" width="1" height="11" border="0" /><br />
              <%=storeText.getString("FavoritesList_Title")%>
            </div>
          </td>
          <td width="280">
            <div align="right">
              <img src="<%=fileDir%>images/hdr_products.gif" width="280" height="72" alt="<%=storeText.getString("FavoritesList_Title")%>" />
            </div>
          </td>
        </tr>
    </table>

  <%
  if (requisitionListsP.length==0 ) {
  %>      
    <font color="red"><%=storeText.getString("FavoritesList_EmptyListText")%></font>
  <%
  }
  %>
    <table width="590" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td valign="top">
            <table width="590" cellpadding="0" border="0" cellspacing="0">
              <tr>          
                <td class=tdblue>&nbsp;&nbsp;<%=storeText.getString("FavoritesList_SubTitle")%></td>
              </tr>
            </table>
          </td>
        </tr>
        <tr valign="top">
          <td>      
            <table width="588" border="0" cellspacing="0" cellpadding="0">
                <tr>
                  <td>
                    <table width="588" cellpadding="0" border="0" cellspacing="1">
                      <tr class="verylightgrey_bg" valign="top">
                        <th align="left" id="th1" class="mbg">&nbsp;&nbsp;<span class=small style="FONT-WEIGHT: bold"><%=storeText.getString("FavoritesList_Name")%></span></th>
                        <th width="10" align="left" id="th2" class="mbg">&nbsp;</th>
                        <th width="496" align="left" id="th3" class="mbg">&nbsp;&nbsp;<span class=small style="FONT-WEIGHT: bold"><%=storeText.getString("FavoritesList_Date")%></span></th>
                      </tr>
  <%
  for (int i=0; i<requisitionListsP.length; i++) {
      
    lastUpdate = requisitionListsP[i].getLastUpdateInEJBType();
    if (lastUpdate==null) {
      formattedLastUpdate = "";
    } else {
      // Format date appropriately from the TimeStampHelper. Allows date to be universal.
      formattedLastUpdate = TimestampHelper.getDateFromTimestamp(lastUpdate, jLocale);
    }
    String listName = requisitionListsP[i].getDescription();
    if (listName==null || listName.trim().equalsIgnoreCase("Unknown name")) 
    {
      listName = storeText.getString("AddtoFavoritesList_UnknownName");
    } 
    %>
    
                      <tr valign="top">
                        <td align="left" headers="th1">
                          <table border="0" cellspacing="0" cellpadding="0">
                            <tr>
                              <td width="2"><img class="imgHeightFix" src="<%=fileDir%>images/c.gif" width="2" height="1" border="0" /></td>
                              <td align="left" nowrap>
                                <span class=small><a href="FavoritesListUpdateFormView?<%= ECCatalogConstants.EC_CAT_MAN_CATALOGID %>=<%= catalogId %>&<%= OrderConstants.EC_REQUISITION_LIST_ID %>=<%= requisitionListsP[i].getOrderId() %>&iPartNumber=<%=partNumber%>&iQuantity=<%=quantity%>"><%= listName %></a></span>
                              </td>
                            </tr>
                          </table>
                        </td>
                        <td width="10" align="left"><span class=small><a href="RequisitionListDelete?<%= ECCatalogConstants.EC_CAT_MAN_CATALOGID %>=<%= catalogId %>&<%= ECConstants.EC_URL %>=FavoritesListDisplayView&<%= OrderConstants.EC_REQUISITION_LIST_ID %>=<%= requisitionListsP[i].getOrderId() %>"><img alt="<%=storeText.getString("FavoritesList_Remove")%>" src="<%=fileDir%>images/icn_trash.gif"  border="0" /></a></span></td>
                        <td width="496" align="left" headers="th3">&nbsp;<span class=small><%= formattedLastUpdate %></span></td>
                      </tr>
                      <%
                      if (i<(requisitionListsP.length-1)) {
                      %>
                      <tr>
                        <td valign="top" colspan="3" class="lightgrey_bg"><img class="imgHeightFix" src="<%=fileDir%>images/c.gif" width="100%" height="1" border="0" /></td>
                      </tr>
                      <%
                      }
                      %>
            
  <%
  } //end for
  %>
                      <tr>
                        <td class="black_bg" colspan="3" ><img class="imgHeightFix" src="<%=fileDir%>images/c.gif" width="1" height="2" border="0" /></td>
                      </tr>
                      <tr>
                        <td colspan="3"><img src="<%=fileDir%>images/c.gif" width="1" height="15" border="0" /></td>
                      </tr> 
                      <tr>
                        <td colspan="3" align="left">&nbsp;<a href="FavoritesListCreateFormView?<%= ECCatalogConstants.EC_CAT_MAN_CATALOGID %>=<%= catalogId %>"><img alt="<%=storeText.getString("FavoritesList_Create")%>" src="<%=fileDir%><%=locale.toString()%>/images/b_createfavorite.gif"  border=0 /></a></td>
                      </tr>
                      <tr valign="top">
                        <td colspan="3"><img src="<%=fileDir%>images/c.gif" width="1" height="15" border="0" /></td>
                      </tr>
                    </table>
                  </td>
                </tr>
            </table>
          </td>
        </tr>
    </table>
    <!--END MAIN CONTENT-->
  </td>
</tr>
</table>
<!-- End Main Table -->
<%@ include file="../../../include/FooterDisplay.jspf"%>
</body>
</html>