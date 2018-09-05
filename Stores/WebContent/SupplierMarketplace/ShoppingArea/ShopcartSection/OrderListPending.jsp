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


<% // All JSPs requires these packages for EnvironmentSetup.jsp which is used for multi language support %> 
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.ibm.commerce.server.ECConstants" %>
<%@ page import="com.ibm.commerce.server.JSPHelper" %>
<%@ page import="com.ibm.commerce.server.JSPResourceBundle" %>
<%@ page import="com.ibm.commerce.command.CommandContext" %>

<% // Page specific imports%> 
<%@ page import="com.ibm.commerce.server.*" %>
<%@ page import="com.ibm.commerce.datatype.*" %>
<%@ page import="com.ibm.commerce.beans.DataBeanManager" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="com.ibm.commerce.order.beans.OrderDataBean" %>
<%@ page import="com.ibm.commerce.order.beans.OrderListDataBean" %>
<%@ page import="com.ibm.commerce.order.beans.SchedulerOrderByMemberIdListDataBean" %>
<%@ page import="com.ibm.commerce.order.objects.OrderAccessBean" %>
<%@ page import="com.ibm.commerce.base.objects.SchedulerConfigAccessBean" %>
<%@ page import="com.ibm.commerce.order.utils.OrderConstants" %> 
<%@ page import="com.ibm.commerce.catalog.beans.CatalogDataBean" %>

<% try{
%>

<%@ include file="../../include/EnvironmentSetup.jspf"%>

<% 
response.setContentType(tooltechtext.getString("ENCODESTATEMENT"));  
Long userId = cmdcontext.getUserId();
Locale jLocale 	= cmdcontext.getLocale();	
DateFormat formatter = DateFormat.getDateInstance(DateFormat.SHORT, jLocale);

JSPHelper jhelper = new JSPHelper(request);
String languageId = jhelper.getParameter("langId");

String orderStatus = ((TypedProperty)request.getAttribute(ECConstants.EC_REQUESTPROPERTIES)).getString(ECConstants.EC_STATUS);
String storeId = ((TypedProperty)request.getAttribute(ECConstants.EC_REQUESTPROPERTIES)).getString(ECConstants.EC_STORE_ID);
String orderStoreId = ((TypedProperty)request.getAttribute(ECConstants.EC_REQUESTPROPERTIES)).getString("orderStoreId",null);

%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "DTD/xhtml1-transitional.dtd">

<head>
	<title><%= tooltechtext.getString("Status_Title") %></title>
	<link rel="stylesheet" href="<%=fileDir%>ToolTech.css" type="text/css">
</head>
<script language="javascript">
	function init(form){
		for(var i = 0; i < form.orderStoreId.length; i++){
			if(form.orderStoreId.options[i].value == '<%=orderStoreId%>'){
				form.orderStoreId.options[i].selected = true;
				break;
			}
		}
	}
</script>

<body marginheight="0" marginwidth="0" leftmargin="0" topmargin="0" onLoad="if (typeof top.updateStInfo == 'function') top.updateStInfo(); init(document.SelectSupplier);">

<flow:ifEnabled feature="customerCare">
<%
// Set header type needed for this JSP for LiveHelp.  This must
// be set before HeaderDisplay.jsp
request.setAttribute("liveHelpPageType", "personal");
%>
</flow:ifEnabled>

<%
	String incfile;
	incfile = includeDir + "HeaderDisplay.jsp";
%>
<jsp:include page="<%=incfile%>" flush="true"/>  


<table border="0" cellpadding="0" cellspacing="0" width="790" height="99%">
<tr>
	<td valign="top" bgcolor="#4c6178" width="160"> 
<%
	incfile = includeDir + "SidebarDisplay.jsp";
%>
		<jsp:include page="<%=incfile%>" flush="true"/>
	</td>

	<td valign="top" width="630">
		<!--content start-->
		<table cellpadding="8" cellspacing="0" border="0">
			<tr>
				<td>
					<p><H1><%= tooltechtext.getString("OrderListPending_Title") %></H1>
					<br />
					


					
         <jsp:useBean id="orderFinder" class="com.ibm.commerce.order.objects.OrderAccessBean" scope="page" />
<%

	Vector orderListVector = null;
		
	OrderListDataBean orderListDB = new OrderListDataBean();
	orderListDB.setOrderStatus(orderStatus);
	if (orderStoreId != null && !orderStoreId.equals("")) {
		orderListDB.setStoreId(new Integer(orderStoreId));
	}
	com.ibm.commerce.beans.DataBeanManager.activate(orderListDB, request);
	orderListVector = orderListDB.getOrders(); 
		
	if (orderListVector == null || orderListVector.size() == 0) {
	
		CatalogDataBean Catalogs[] = sdb.getStoreCatalogs();
		String catalogId = Catalogs[0].getCatalogId();
	
%>
					<%=tooltechtext.getString("OrderListPending_No_Orders_Found")%>
					<br />
					<br />

						<table cellpadding="0" cellspacing="0" border="0">
						<tr>
							<td bgcolor="#ff2d2d" class="pixel"><img src="<%=jspStoreImgDir%>images/lb.gif" border="0"/></td>
							<td bgcolor="#ff2d2d" class="pixel"><img src="<%=jspStoreImgDir%>images/lb.gif" border="0"/></td>
							<td class="pixel"><img src="<%=jspStoreImgDir%>images/r_top.gif" border="0"/></td>
						</tr>
						<tr>
							<td bgcolor="#ff2d2d"><img alt="" src="<%=jspStoreImgDir%>images/lb.gif" border="0"/></td>
							<td bgcolor="#ea2b2b">
								<table cellpadding="2" cellspacing="0" border="0">
								<tr>
									<td class="buttontext">
										<font color="#ffffff"><b>
										<a href="TopCategoriesDisplay?langId=<%=languageId%>&catalogId=<%=catalogId%>&storeId=<%=storeId%>" style="color:#ffffff; text-decoration : none;">
										<%=tooltechtext.getString ("Home_Button1")%>
										</a>
										</b></font>
									</td>
								</tr>
								</table>
							</td>
							<td bgcolor="#7a1616"><img alt="" src="<%=jspStoreImgDir%>images/db.gif" border="0"/></td>
						</tr>	
						<tr>
							<td class="pixel"><img src="<%=jspStoreImgDir%>images/l_bot.gif"/></td>
							<td bgcolor="#7a1616" class="pixel" valign="top"><img src="<%=jspStoreImgDir%>images/db.gif" border="0"/></td>
							<td bgcolor="#7a1616" class="pixel" valign="top"><img src="<%=jspStoreImgDir%>images/db.gif" border="0"/></td>
						</tr>
						</table>
<%         
	} else {
%>
					<table cellpadding="2" cellspacing="2" border="0">
					<tr>	
						<td>
							<b><label for="orderStoreId"><%= tooltechtext.getString("SupplierDropDown_SelectSupplier") %></label></b>
						</td>
							<form name="SelectSupplier" action="OrderList">
						<td>
								<input type="hidden" name="langId" value="<%= lang %>">
								<input type="hidden" name="status" value="<%= orderStatus %>">
								<input type="hidden" name="storeId" value="<%= sessionStoreId %>">
								<select name="orderStoreId" id="orderStoreId">
									<option value=""><%= tooltechtext.getString("SupplierDropDown_AllSupplier") %></option>
									<%
										HashMap relatedStores = com.ibm.commerce.store.util.StoreRelationUtil.getRelatedOpenStores(new Integer(sessionStoreId),ECConstants.EC_STRELTYP_HOSTED_STORE);
										Integer[] anStoreIds = com.ibm.commerce.common.helpers.StoreUtil.getRelatedStores(new Integer(sessionStoreId),ECConstants.EC_STRELTYP_HOSTED_STORE);
										for (int s=0; s<anStoreIds.length; s++) {
												String rStoreId = anStoreIds[s].toString();
												String rStoreName = (String) relatedStores.get(rStoreId);
									%>
													<option value="<%= rStoreId %>"><%= rStoreName %></option>
									<%
											}
									%>
								</select>
						</td>
							</form>
						<td>
							<table cellpadding="0" cellspacing="0" border="0">
							<tr>	
								<td bgcolor="#ff2d2d" class="pixel"><img src="<%=jspStoreImgDir%>images/lb.gif" border="0"/></td>
								<td bgcolor="#ff2d2d" class="pixel"><img src="<%=jspStoreImgDir%>images/lb.gif" border="0"/></td>
								<td class="pixel"><img src="<%=jspStoreImgDir%>images/r_top.gif" border="0"/></td>
							</tr>
							<tr>
								<td bgcolor="#ff2d2d"><img alt="" src="<%=jspStoreImgDir%>images/lb.gif" border="0"/></td>
								<td bgcolor="#ea2b2b">
									<table cellpadding="2" cellspacing="0" border="0">
									<tr>
										<td class="buttontext">
											<font color="#ffffff"><b>
											<a href="javascript:document.SelectSupplier.submit()"  style="color:#ffffff; text-decoration : none;">
											<%= tooltechtext.getString("SupplierDropDown_Go") %>
											</a>
											</b></font>
										</td>
									</tr>
									</table>
								</td>
								<td bgcolor="#7a1616"><img alt="" src="<%=jspStoreImgDir%>images/db.gif" border="0"/></td>
							</tr>	
							<tr>
								<td class="pixel"><img src="<%=jspStoreImgDir%>images/l_bot.gif"/></td>
								<td bgcolor="#7a1616" class="pixel" valign="top"><img src="<%=jspStoreImgDir%>images/db.gif" border="0"/></td>
								<td bgcolor="#7a1616" class="pixel" valign="top"><img src="<%=jspStoreImgDir%>images/db.gif" border="0"/></td>
							</tr>
							</table>
						</td>
					</tr>
					</table>


					<form name="OrderList">

					<table WIDTH="100%" border="0" cellpadding="2" cellspacing="1" bgcolor="#4C6178">
						<tr bgcolor="#4C6178">
							<td>
								<table>
									<tr>
										<td valign="TOP"><font style="font-family : Verdana;" color="#FFFFFF"><strong><%= tooltechtext.getString("OrderListPending_OrderId") %></strong></font></td>
									</tr>
								</table>
							</td>
							<td>
								<table>
									<tr>
										<td valign="TOP"><font style="font-family : Verdana;" color="#FFFFFF"><strong><%= tooltechtext.getString("OrderListPending_StoreId") %></strong></font></td>
									</tr>
								</table>
							</td>
							<td>
								<table>
									<tr>
										<td valign="TOP"><font style="font-family : Verdana;" color="#FFFFFF"><strong><%= tooltechtext.getString("OrderListPending_OrderDate") %></strong></font></td>
									</tr>
								</table>
							</td>
							<td>
								<table>
									<tr>
										<td><font style="font-family : Verdana;" color="#FFFFFF"><strong><%= tooltechtext.getString("OrderListPending_Description") %></strong></font></td>
									</tr>
								</table>
							</td>
							<td>
							</td>
						</tr>

<%
		for (int i=0; i<orderListVector.size(); i++) {
			//OrderAccessBean orderDB = (OrderAccessBean)orderListVector.elementAt(i);
			OrderDataBean orderDB = new OrderDataBean((OrderAccessBean)orderListVector.elementAt(i), cmdcontext);
			String sLink = "OrderItemDisplayViewShiptoAssoc?storeId=" + storeId + "&catalogId=" + jhelper.getParameter("catalogId") + "&orderId=" + orderDB.getOrderId();
			
			//get the date ordered
			String orderDateString = "";
			Date orderDate;
			orderDate = orderDB.getPlaceOrderTimeInEJBType();
			
			if (orderDate != null) {
				orderDateString = formatter.format(orderDate);
			}
			
%>
						<tr bgcolor="#ffffff">
							<td align="center"><a href="<%= sLink %>"><%= orderDB.getOrderId()  %></a></td>
							<td><%= orderDB.getStoreEntityId() %></td>
							<td><%= orderDateString %></td>
							<td><%= (orderDB.getDescription() == null ? "" : orderDB.getDescription()) %></td>
							<td>
								<a href="OrderCancel?<%= ECConstants.EC_URL %>=OrderList%3F<%= ECConstants.EC_FOR_STORE_ID %>%3D&<%= ECConstants.EC_FOR_STORE_ID %>=<%= orderDB.getStoreEntityId() %>&<%= OrderConstants.EC_ORDER_ID %>=<%= orderDB.getOrderId() %>&<%= OrderConstants.EC_STATUS %>=<%= orderDB.getStatus() %>">
										<%= tooltechtext.getString("OrderListPending_Cancel") %>
								</a>
								<br />
								<a href="OrderCopy?<%= ECConstants.EC_URL + "=OrderList%3F" + ECConstants.EC_FOR_STORE_ID + "%3D" + "&" +
											ECConstants.EC_FOR_STORE_ID + "=" + orderDB.getStoreEntityId() + "&" +
											"fromOrderId_1=" + orderDB.getOrderId() + "&" +
											"toOrderId=**&" +
											"copyOrderItemId_1=*&" +
											OrderConstants.EC_STATUS + "=" + orderDB.getStatus() %>">
										<%= tooltechtext.getString("OrderListPending_Copy") %>
								</a>
							</td>
						</tr>
	
<%
		}  // end for
%>
					</table>
					
					</form>
<% 
	} 
%>

				</td>
			</tr>
		</table>
		<!--content end--> 
	</td>
</tr>
</table>

</BODY>


<% } catch (Exception e) {
	e.printStackTrace();
}
%>
</HTML>

