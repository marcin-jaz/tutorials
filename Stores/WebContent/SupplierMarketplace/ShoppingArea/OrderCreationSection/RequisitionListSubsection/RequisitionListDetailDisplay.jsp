
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
<%@ page import="com.ibm.commerce.beans.DataBeanManager" %>
<%@ page import="com.ibm.commerce.order.objects.OrderItemAccessBean" %>
<%@ page import="com.ibm.commerce.order.beans.OrderDataBean" %>
<%@ page import="com.ibm.commerce.catalog.beans.CatalogDataBean" %>
<%@ page import="com.ibm.commerce.catalog.beans.ItemDataBean" %>
<%@ page import="com.ibm.commerce.order.utils.OrderConstants" %>

<%@ include file="../../../include/EnvironmentSetup.jspf"%>
<% response.setContentType(tooltechtext.getString("ENCODESTATEMENT")); %> 

<%
CommandContext commandContext 	= (CommandContext) request.getAttribute(ECConstants.EC_COMMANDCONTEXT);
Long userRefNum 				= commandContext.getUserId();

// JSPHelper provides you with a easy way to retrieve URL parameters when they are encrypted.
// JSPHelper comes from Package com.ibm.commerce.server.*

JSPHelper jhelper 			= new JSPHelper(request);

String storeId 				= jhelper.getParameter("storeId");
String languageId 			= jhelper.getParameter("langId");
CatalogDataBean Catalogs[] 		= sdb.getStoreCatalogs();
String catalogId 				= Catalogs[0].getCatalogId();
String requisitionListId 		= jhelper.getParameter("requisitionListId");

OrderDataBean orderDB 			= new OrderDataBean();
orderDB.setOrderId(requisitionListId);
com.ibm.commerce.beans.DataBeanManager.activate(orderDB, request);


String reqListStoreId 			= orderDB.getStoreEntityId();

OrderItemAccessBean [] orderItemAB = orderDB.getOrderItems();

%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "DTD/xhtml1-transitional.dtd">
<html>
<HEAD>
	<TITLE><%=tooltechtext.getString("Viewreq_Title")%></TITLE>
	<LINK REL=stylesheet HREF="<%=fileDir%>ToolTech.css" TYPE="text/css">
</HEAD>


<BODY MARGINHEIGHT="0" MARGINWIDTH="0" LEFTMARGIN="0" TOPMARGIN="0" onLoad="if (typeof top.updateStInfo == 'function') top.updateStInfo();">
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


<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0" WIDTH="790" HEIGHT="99%">
<TR>
	<TD VALIGN="top" BGCOLOR="#4c6178" WIDTH="160"> 

		<%
		incfile = includeDir + "SidebarDisplay.jsp";
		%>
		<jsp:include page="<%=incfile%>" flush="true"/>

	</TD>

	<TD valign="top" width="630">

<!-- content start -->

<TABLE CELLPADDING="8" CELLSPACING="0" BORDER="0" width="605">
	<TR>
		<TD>
			<TABLE>
				<TR>
					<TD><H1><%=tooltechtext.getString("Viewreq_Title")%></H1></TD>
				</TR>
				<tr>
					<td><b><%=tooltechtext.getString("Viewreq_Store")%></b>&nbsp;&nbsp;<%= reqListStoreId %></td>
				</tr>
				<TR>
					<TD><B><%=tooltechtext.getString("Viewreq_Text1")%></B>&nbsp;&nbsp;<%= orderDB.getDescription() %></TD>
				</TR>
				<TR>
					<TD><B><%=tooltechtext.getString("Viewreq_Text2")%></B>&nbsp;&nbsp;<%= orderItemAB.length %></TD>
				</TR>
				<TR>
					<TD><b><%=tooltechtext.getString("Viewreq_Text3")%></b>&nbsp;&nbsp;<%= (orderDB.getStatus().equals("Y"))?tooltechtext.getString("Viewreq_Drop1"):tooltechtext.getString("Viewreq_Drop2")%></TD>
				</TR>
			</TABLE>
			<BR>

			<TABLE CELLPADDING="0" CELLSPACING="0" BORDER="0" width="605">
				<TR>
					<TD>
						<TABLE CELLPADDING="0" CELLSPACING="0" BORDER="0" width="605" bgcolor="#4C6178">
							<TR>
								<TD>
									<TABLE WIDTH="100%" BORDER="0" CELLPADDING="2" CELLSPACING="1">
										<TR bgcolor="#4C6178">
											<TD VALIGN="TOP">
												<TABLE>
													<TR>
														<TD VALIGN="TOP"><font style="font-family : Verdana;" color="#FFFFFF"><strong><%=tooltechtext.getString("Viewreq_Col1")%></strong></font></TD>
													</TR>
												</TABLE>
											</TD>
											<TD VALIGN="TOP">
												<TABLE>
													<TR>
														<TD VALIGN="TOP"><font style="font-family : Verdana;" color="#FFFFFF"><strong><%=tooltechtext.getString("Viewreq_Col2")%></strong></font></TD>
													</TR>
												</TABLE>
											</TD>
											<TD VALIGN="TOP">
												<TABLE>
													<TR>
														<TD VALIGN="TOP"><font style="font-family : Verdana;" color="#FFFFFF"><strong><%=tooltechtext.getString("Viewreq_Col3")%></strong></font></TD>
													</TR>
												</TABLE>
											</TD>
											<td  VALIGN="TOP">
												<TABLE>
													<TR>
														<TD><font style="font-family : Verdana;" color="#FFFFFF"><strong><%=tooltechtext.getString("Viewreq_Col4")%></strong></font></TD>
													</TR>
												</TABLE>
											</TD>
											<TD>
												<TABLE>
													<TR>
														<TD VALIGN="TOP"><font style="font-family : Verdana;" color="#FFFFFF"><strong><%=tooltechtext.getString("Viewreq_Col5")%></strong></font></TD>
													</TR>
												</TABLE>
											</TD>
											
										</TR>

<%
for (int i=0;i<orderItemAB.length;i++) {
		ItemDataBean itemDB=new ItemDataBean();
		itemDB.setItemID(orderItemAB[i].getCatalogEntryId());
		com.ibm.commerce.beans.DataBeanManager.activate(itemDB, request); 

		Double quantity = orderItemAB[i].getQuantityInEJBType();
		
		int j=i+1;
										if ((i % 2) == 0) out.println("<TR bgcolor='#ffffff'>");
										else out.println("<TR bgcolor='#BCCBDB'>");
%>
										<td><font class='P'><%= itemDB.getPartNumber() %></font></td>
<%
										if (quantity.intValue() == quantity.doubleValue()) 
											out.println("<td><font class='P'>"+quantity.intValue()+"</font></td>");
		
										else 
											out.println("<td><font class='P'>"+quantity.doubleValue()+"</font></td>");
%>
										<td><font class='P'><A HREF="ProductDisplay?catalogId=<%= catalogId %>&storeId=<%= storeId %>&productId=<%=orderItemAB[i].getCatalogEntryId() %>&langId=<%= languageId %>"><%= itemDB.getDescription().getShortDescription() %></A></font></td>
										<td><font class='P'><%= itemDB.getManufacturerName() %></font></td>
										<td><%= itemDB.getManufacturerPartNumber() %></td>
										</tr>
<%
}
%>
									</TABLE>
								</TD>
							</TR>
						</TABLE>
		<P>
				<FORM NAME="OrderItemAddForm" ACTION="CatalogItemAdd" method="post">
					<input type="hidden" name="storeId" value="<%=storeId%>">
					<input type="hidden" name="orderId" value=".">
					<input type="hidden" name="langId" value="<%=languageId%>">
					<input type="hidden" name="catalogId" value="<%=catalogId%>">
					<input type="hidden" name="URL" value="OrderItemDisplay?orderId=*">
					
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
}
%>
				</FORM>
				
				<FORM NAME="RequisitionListSubmitForm" ACTION="RequisitionListSubmit" method="post">
					<input type="hidden" name="cmdStoreId" value="<%= reqListStoreId %>">
					<input type="hidden" name="langId" value="<%=languageId%>">
					<input type="hidden" name="catalogId" value="<%=catalogId%>">
					<input type="hidden" name="URL" value="OrderItemDisplayViewShiptoAssoc?cmdStoreId=">
					<input type="hidden" name="<%= OrderConstants.EC_REQUISITION_LIST_ID %>" value="<%= requisitionListId %>">
				</FORM>
				
						<table cellpadding="0" cellspacing="0" border="0">
							<tr>
								<td>
<% 
if (orderItemAB.length>0) {
%>

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
													<a href="javascript:document.RequisitionListSubmitForm.submit()" style="color:#ffffff; text-decoration : none;">
													<%=tooltechtext.getString("Viewreq_Link")%>
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
								<td>&nbsp;&nbsp;</TD>
<%
}
%>
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
													<a href="RequisitionListView" style="color:#ffffff; text-decoration : none;">
													<%=tooltechtext.getString("Viewreq_Button")%>
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
				</TD>
			</TR>
		</TABLE>
		</TD>
	</TR>
</TABLE>

<!--content end-->

	</TD>
</TR>
</TABLE>

</BODY>
</HTML>
