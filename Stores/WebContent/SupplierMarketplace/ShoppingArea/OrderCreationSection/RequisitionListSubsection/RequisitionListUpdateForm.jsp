
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
<%@ page import="com.ibm.commerce.beans.ErrorDataBean" %>
<%@ page import="com.ibm.commerce.ras.ECMessageKey" %>
<%@ page import="com.ibm.commerce.order.beans.OrderDataBean" %>
<%@ page import="com.ibm.commerce.order.objects.OrderItemAccessBean" %>
<%@ page import="com.ibm.commerce.datatype.TypedProperty" %>
<%@ page import="com.ibm.commerce.catalog.beans.CatalogDataBean" %>
<%@ page import="com.ibm.commerce.catalog.beans.ProductDataBean" %>
<%@ page import="com.ibm.commerce.catalog.beans.ItemDataBean" %>
<%@ page import="com.ibm.commerce.order.utils.OrderConstants" %>

<%@ include file="../../../include/EnvironmentSetup.jspf"%>
<% response.setContentType(tooltechtext.getString("ENCODESTATEMENT")); %>

<jsp:useBean id="bnError" class="com.ibm.commerce.beans.ErrorDataBean" scope="page">
<%
com.ibm.commerce.beans.DataBeanManager.activate(bnError, request);
%>
</jsp:useBean>

<%
// JSPHelper provides you with an easy way to retrieve URL parameters when they are encrypted.
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
OrderItemAccessBean [] orderItemAB 	= orderDB.getOrderItems();

String reqListStoreId 			= orderDB.getStoreEntityId();


String strNewPartNumber 		= "";
String strNewQuantity 			= "";
String strQuantity 			= "";

String strErrorMessage 			= null;
String strErrorCode 			= "";
String strFieldName 			= null;
Object strMessageParams[] 		= null;
String strMessageKey 			= bnError.getMessageKey();

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
			strErrorMessage = tooltechtext.getString("Newreq_Error_ProdSKU")+"&nbsp;&nbsp;"+prodDB.getPartNumber();
		}
	} else if (strMessageKey.equals(ECMessageKey._ERR_PROD_NOT_EXISTING)) {
		strFieldName = (String)strMessageParams[0];
		strErrorMessage = tooltechtext.getString("Editreq_Error_SKU") + "&nbsp;&nbsp;"+strFieldName;
	} else if (strMessageKey.equals(ECMessageKey._ERR_INVALID_INPUT)) {
		strQuantity = jhelper.getParameter("quantity");
		strErrorMessage = tooltechtext.getString("Editreq_Error_Quantity")+ "&nbsp;&nbsp;"+strQuantity;

	}

	//Retrieve form data entered before

	strNewPartNumber = jhelper.getParameter(OrderConstants.EC_PART_NUMBER);
	if (strNewPartNumber==null) strNewPartNumber="";
	strNewQuantity = jhelper.getParameter("strNewQuantity");
	if (strNewPartNumber=="") strNewQuantity="";

}
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "DTD/xhtml1-transitional.dtd">
<script language="javascript">
	function ReqListUpdateType() {
		document.RequisitionListTypeForm.name.value = document.RequisitionListNameForm.name.value;
		document.RequisitionListTypeForm.submit();
	}

	function Add2ReqList(form) {
		form.quantity.value = form.strNewQuantity.value;
		if (form.strNewQuantity.value == "") {
			form.quantity.value = "1";
		}
		form.submit();
	}
</script>

<html>
<head>
	<title><%=tooltechtext.getString("Editreq_Title")%></title>
	<link rel="stylesheet" href="<%=fileDir%>ToolTech.css" TYPE="text/css">
</head>


<body marginheight="0" marginwidth="0" leftmargin="0" topmargin="0" onload="if (typeof top.updateStInfo == 'function') top.updateStInfo();">
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
<jsp:include page="<%=incfile%>" flush="true" />


<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0" WIDTH="790" HEIGHT="99%">
<TR>
	<TD VALIGN="top" BGCOLOR="#4c6178" WIDTH="160">

		<%
		incfile = includeDir + "SidebarDisplay.jsp";
		%>
		<jsp:include page="<%=incfile%>" flush="true" />

	</TD>

	<TD valign="top" width="630">
<!--content start-->
		<%
		if (strErrorMessage != null)
			{
			//Display error messages.
			%><p><font color="red"><%=strErrorMessage%><br><br></font></p><%
			}
		%>

<table border="0" cellpadding="8" cellspacing="0" width="605">
	<tr>
		<td>
			<form name="RequisitionListNameForm" action="RequisitionListUpdate" method="post">
			<input type="hidden" name="<%= OrderConstants.EC_REQUISITION_LIST_ID %>" value="<%= requisitionListId %>">
			<input type="hidden" name="<%= ECConstants.EC_URL %>" value="RequisitionListUpdateView?<%= OrderConstants.EC_REQUISITION_LIST_ID %>=<%= requisitionListId %>">
			<table>
				<tr>
					<td>
						<h1><%=tooltechtext.getString("Editreq_Title")%></h1>
					</td>
				</tr>
				<tr>
					<td><b><%=tooltechtext.getString("Editreq_Store")%></b>&nbsp;&nbsp;<%= reqListStoreId %></td>
				</tr>
				<tr>
					<td><b><label for="WC_RequisitionListUpdateForm_FormInput_name_1"><%=tooltechtext.getString("Editreq_Text1")%></label></b>&nbsp;&nbsp;<input type="text" name="name" value="<%= orderDB.getDescription() %>" id="WC_RequisitionListUpdateForm_FormInput_name_1"></td>
					<td>
						<table cellpadding="0" cellspacing="0" border="0">
						<tr>
							<td bgcolor="#ff2d2d" class="pixel"><img src="<%=jspStoreImgDir%>images/lb.gif" border="0" alt=""/></td>
							<td bgcolor="#ff2d2d" class="pixel"><img src="<%=jspStoreImgDir%>images/lb.gif" border="0" alt=""/></td>
							<td class="pixel"><img src="<%=jspStoreImgDir%>images/r_top.gif" border="0" alt=""/></td>
						</tr>
						<tr>
							<td bgcolor="#ff2d2d"><img alt="" src="<%=jspStoreImgDir%>images/lb.gif" border="0" /></td>
							<td bgcolor="#ea2b2b">
								<table cellpadding="2" cellspacing="0" border="0">
								<tr>
									<td class="buttontext">
										<font color="#ffffff"><b>
										<a href="javascript:document.RequisitionListNameForm.submit()" style="color:#ffffff; text-decoration : none;">
										<%=tooltechtext.getString("Editreq_Button1")%>
										</a>
										</b></font>
									</td>
								</tr>
								</table>
							</td>
							<td bgcolor="#7a1616"><img alt="" src="<%=jspStoreImgDir%>images/db.gif" border="0" /></td>
						</tr>
						<tr>
							<td class="pixel"><img src="<%=jspStoreImgDir%>images/l_bot.gif" alt=""/></td>
							<td bgcolor="#7a1616" class="pixel" valign="top"><img src="<%=jspStoreImgDir%>images/db.gif" border="0" alt=""/></td>
							<td bgcolor="#7a1616" class="pixel" valign="top"><img src="<%=jspStoreImgDir%>images/db.gif" border="0" alt=""/></td>
						</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td><b><%=tooltechtext.getString("Editreq_Text2")%></b>&nbsp;&nbsp;<%= orderItemAB.length %></td>
				</tr>
			</table>
			</form>
			<br>
			<form name="RequisitionListTypeForm" action="RequisitionListUpdate" method="post">
			<table border="0" cellpadding="0" cellspacing="2">
			<input type="hidden" name="name" value="">
			<input type="hidden" name="<%= OrderConstants.EC_REQUISITION_LIST_ID %>" value="<%= requisitionListId %>">
			<input type="hidden" name="<%= ECConstants.EC_URL %>" value="RequisitionListUpdateView?<%= OrderConstants.EC_REQUISITION_LIST_ID %>=<%= requisitionListId %>">

				<tr>
					<td width="150"><b><label for="WC_RequisitionListUpdateForm_FormInput_status_1"><%=tooltechtext.getString("ReqList_Type")%></label></b>&nbsp;&nbsp;
					<a name="status">
					<select NAME="status" onChange="javascript:ReqListUpdateType()" id="WC_RequisitionListUpdateForm_FormInput_status_1">

						<% if (orderDB.getStatus().equals("Y")) { %>
							<option value="Y" selected><%= tooltechtext.getString("Editreq_Drop1") %></option>
							<option value="Z"><%= tooltechtext.getString("Editreq_Drop2") %></option>
						<% } else  { %>
							<option value="Y"><%= tooltechtext.getString("Editreq_Drop1") %></option>
							<option value="Z" selected><%= tooltechtext.getString("Editreq_Drop2") %></option>
						<% } %>
						</select>
						</a>
					</td>

				</tr>
			</table>
			</form>
			<br>

			<table cellpadding="0" cellspacing="0" border="0" width="605">
				<tr>
					<td><%=tooltechtext.getString("Editreq_Text3")%></td>
				</tr>
			</table>
			<br>
		</td>
	</tr>
</table>


<table border="0" cellpadding="8" cellspacing="0" width="605">
	<tr>
		<td>
			<form name="AddRequisitionListItemForm" action="RequisitionListItemUpdate" method="post">
			<input type="hidden" name="cmdStoreId" value="<%= reqListStoreId %>">
			<input type="hidden" name="<%= OrderConstants.EC_REQUISITION_LIST_ID %>" value="<%= requisitionListId %>">
			<input type="hidden" name="<%= ECConstants.EC_URL %>" value="RequisitionListUpdateView?cmdStoreId=">
			<input type="hidden" name="quantity" value="">
			<input type="hidden" name="errorViewName" value="RequisitionListUpdateView">

			<TABLE BORDER="0" CELLPADDING="2" CELLSPACING="0" BORDER="0">
				<TR>
					<TD><B><label for="WC_RequisitionListUpdateForm_FormInput_<%= OrderConstants.EC_PART_NUMBER %>_1"><%=tooltechtext.getString("Editreq_SKU")%></label></B></TD>
					<TD><B><label for="WC_RequisitionListUpdateForm_FormInput_strNewQuantity_1"><%=tooltechtext.getString("Editreq_Quantity")%></label></B></TD>
					<TD>&nbsp;</TD>
				</TR>
				<TR>
					<TD><input type="text" name="<%= OrderConstants.EC_PART_NUMBER %>" value="<%=strNewPartNumber%>" id="WC_RequisitionListUpdateForm_FormInput_<%= OrderConstants.EC_PART_NUMBER %>_1"></TD>
					<TD><input type="text" name="strNewQuantity" value="<%=strNewQuantity%>" id="WC_RequisitionListUpdateForm_FormInput_strNewQuantity_1"></TD>
					<TD>
						<table cellpadding="0" cellspacing="0" border="0">
						<tr>
							<td bgcolor="#ff2d2d" class="pixel"><img src="<%=jspStoreImgDir%>images/lb.gif" border="0" alt=""/></td>
							<td bgcolor="#ff2d2d" class="pixel"><img src="<%=jspStoreImgDir%>images/lb.gif" border="0" alt=""/></td>
							<td class="pixel"><img src="<%=jspStoreImgDir%>images/r_top.gif" border="0" alt=""/></td>
						</tr>
						<tr>
							<td bgcolor="#ff2d2d"><img alt="" src="<%=jspStoreImgDir%>images/lb.gif" border="0" /></td>
							<td bgcolor="#ea2b2b">
								<table cellpadding="2" cellspacing="0" border="0">
								<tr>
									<td class="buttontext">
										<font color="#ffffff"><b>
										<a href="javascript:Add2ReqList(document.AddRequisitionListItemForm)" style="color:#ffffff; text-decoration : none;">
										<%=tooltechtext.getString("Editreq_Button2")%>
										</a>
										</b></font>
									</td>
								</tr>
								</table>
							</td>
							<td bgcolor="#7a1616"><img alt="" src="<%=jspStoreImgDir%>images/db.gif" border="0" /></td>
						</tr>
						<tr>
							<td class="pixel"><img src="<%=jspStoreImgDir%>images/l_bot.gif" alt=""/></td>
							<td bgcolor="#7a1616" class="pixel" valign="top"><img src="<%=jspStoreImgDir%>images/db.gif" border="0" alt=""/></td>
							<td bgcolor="#7a1616" class="pixel" valign="top"><img src="<%=jspStoreImgDir%>images/db.gif" border="0" alt=""/></td>
						</tr>
						</table>
					</TD>
				</TR>

			</TABLE>
			</form>

			<br>
			<form method="post" name="UpdateRequisitionListItemForm" action="RequisitionListItemUpdate">
			<input type="hidden" name="cmdStoreId" value="<%= reqListStoreId %>">
			<input type="hidden" name="<%= OrderConstants.EC_REQUISITION_LIST_ID %>" value="<%= requisitionListId %>">
			<input type="hidden" name="<%= ECConstants.EC_URL %>" value="RequisitionListUpdateView?cmdStoreId=&orderItemId*=&quantity_*=">
			<input type="hidden" name="errorViewName" value="RequisitionListUpdateView">

			<TABLE CELLPADDING="0" CELLSPACING="0" BORDER="0" width="605" bgcolor="#4C6178">
				<TR>
					<TD>
						<TABLE WIDTH="100%" BORDER="0" CELLPADDING="2" CELLSPACING="1">
							<TR bgcolor="#4C6178">
								<TD VALIGN="TOP">
									<TABLE>
										<TR>
											<TD></TD>
											<TD VALIGN="TOP"><font color="#FFFFFF" style="font-family : Verdana;"><strong><%=tooltechtext.getString("Editreq_Col2")%></strong></font></TD>
										</TR>
									</TABLE>
								</TD>
								<TD VALIGN="TOP">
									<TABLE>
										<TR>
											<TD VALIGN="TOP"><font style="font-family : Verdana;" color="#FFFFFF"><strong><%=tooltechtext.getString("Editreq_Col1")%></strong></font></TD>
										</TR>
									</TABLE>
								</TD>
								<TD VALIGN="TOP">
									<TABLE>
										<TR>
											<TD VALIGN="TOP"><font style="font-family : Verdana;" color="#FFFFFF"><strong><%=tooltechtext.getString("Editreq_Col3")%></strong></font></TD>
										</TR>
									</TABLE>
								</TD>
								<td  VALIGN="TOP">
									<TABLE>
										<TR>
											<TD><font style="font-family : Verdana;" color="#FFFFFF"><strong><%=tooltechtext.getString("Editreq_Col4")%></strong></font></TD>
										</TR>
									</TABLE>
								</TD>
								<TD>
									<TABLE>
										<TR>
											<TD VALIGN="TOP"><font style="font-family : Verdana;" color="#FFFFFF"><strong><%=tooltechtext.getString("Editreq_Col5")%></strong></font></TD>
										</TR>
									</TABLE>
								</TD>
								<TD>
									<TABLE>
										<TR>
											<TD VALIGN="TOP"></TD>
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
								<td>
									<table border="0" cellpadding="0" cellspacing="0">
										<tr>
											<td><input type="hidden" name="orderItemId_<%= j %>" value="<%= orderItemAB[i].getOrderItemId() %>" ></td>
											<td>
											<label for="quantity_<%= j %>"><img src="<%=fileDir%>images/trans.gif" height="1" width="1" border="0" alt="<%=tooltechtext.getString("Editreq_Col2")%>"/></label>
											<input type='text' size=2 maxlength=256 name="quantity_<%= j %>" id="quantity_<%= j %>" value="<%= quantity.intValue() == quantity.doubleValue() ? Integer.toString(quantity.intValue()) : Double.toString(quantity.doubleValue()) %>"></td>
										</tr>
									</table>
								</td>
								<td><%= itemDB.getPartNumber() %></td>
								<td><font color='blue'><A HREF="ProductDisplay?catalogId=<%= catalogId %>&storeId=<%= storeId %>&productId=<%=orderItemAB[i].getCatalogEntryId() %>&langId=<%= languageId %>"><%= itemDB.getDescription().getShortDescription() %></A></font></td>
								<td><%= itemDB.getManufacturerName() %></td>
								<td><%= itemDB.getManufacturerPartNumber() %></td>
								<td><A HREF="RequisitionListItemUpdate?cmdStoreId=<%= reqListStoreId %>&quantity=0&<%= OrderConstants.EC_REQUISITION_LIST_ID %>=<%= requisitionListId %>&<%= OrderConstants.EC_ORDERITEM_ID %>=<%= orderItemAB[i].getOrderItemId() %>&<%= ECConstants.EC_URL %>=RequisitionListUpdateView%3FcmdStoreId%3D">
								<%=tooltechtext.getString("Editreq_Remove")%></A></td>
							</tr>
<%	}
%>
						</TABLE>
					</TD>
				</TR>
			</TABLE>
			</form>
			<br>
			<br>

<%
if (orderItemAB.length>0) {
%>

			<table border="0" cellpadding="0" cellspacing="2">
				<tr>
					<td>
						<table cellpadding="0" cellspacing="0" border="0">
						<tr>
							<td bgcolor="#ff2d2d" class="pixel"><img src="<%=jspStoreImgDir%>images/lb.gif" border="0" alt=""/></td>
							<td bgcolor="#ff2d2d" class="pixel"><img src="<%=jspStoreImgDir%>images/lb.gif" border="0" alt=""/></td>
							<td class="pixel"><img src="<%=jspStoreImgDir%>images/r_top.gif" border="0" alt=""/></td>
						</tr>
						<tr>
							<td bgcolor="#ff2d2d"><img alt="" src="<%=jspStoreImgDir%>images/lb.gif" border="0" /></td>
							<td bgcolor="#ea2b2b">
								<table cellpadding="2" cellspacing="0" border="0">
								<tr>
									<td class="buttontext">
										<font color="#ffffff"><b>
										<a href="javascript:document.UpdateRequisitionListItemForm.submit()" style="color:#ffffff; text-decoration : none;">
										<%=tooltechtext.getString("Editreq_Button3")%>
										</a>
										</b></font>
									</td>
								</tr>
								</table>
							</td>
							<td bgcolor="#7a1616"><img alt="" src="<%=jspStoreImgDir%>images/db.gif" border="0" /></td>
						</tr>
						<tr>
							<td class="pixel"><img src="<%=jspStoreImgDir%>images/l_bot.gif" alt=""/></td>
							<td bgcolor="#7a1616" class="pixel" valign="top"><img src="<%=jspStoreImgDir%>images/db.gif" border="0" alt=""/></td>
							<td bgcolor="#7a1616" class="pixel" valign="top"><img src="<%=jspStoreImgDir%>images/db.gif" border="0" alt=""/></td>
						</tr>
						</table>
					</td>
					<td>&nbsp;&nbsp;</td>

				<FORM NAME="RequisitionListSubmitForm" ACTION="RequisitionListSubmit" method="post">
					<input type="hidden" name="cmdStoreId" value="<%= reqListStoreId %>">
					<input type="hidden" name="langId" value="<%=languageId%>">
					<input type="hidden" name="catalogId" value="<%=catalogId%>">
					<input type="hidden" name="URL" value="OrderItemDisplayViewShiptoAssoc?cmdStoreId=">
					<input type="hidden" name="<%= OrderConstants.EC_REQUISITION_LIST_ID %>" value="<%= requisitionListId %>">
				</FORM>
					<td>

						<table cellpadding="0" cellspacing="0" border="0">
						<tr>
							<td bgcolor="#ff2d2d" class="pixel"><img src="<%=jspStoreImgDir%>images/lb.gif" border="0" alt=""/></td>
							<td bgcolor="#ff2d2d" class="pixel"><img src="<%=jspStoreImgDir%>images/lb.gif" border="0" alt=""/></td>
							<td class="pixel"><img src="<%=jspStoreImgDir%>images/r_top.gif" border="0" alt=""/></td>
						</tr>
						<tr>
							<td bgcolor="#ff2d2d"><img alt="" src="<%=jspStoreImgDir%>images/lb.gif" border="0" /></td>
							<td bgcolor="#ea2b2b">
								<table cellpadding="2" cellspacing="0" border="0">
								<tr>
									<td class="buttontext">
										<font color="#ffffff"><b>
										<a href="javascript:document.RequisitionListSubmitForm.submit()" style="color:#ffffff; text-decoration : none;">
										<%=tooltechtext.getString("Editreq_Button4")%>
										</a>
										</b></font>
									</td>
								</tr>
								</table>
							</td>
							<td bgcolor="#7a1616"><img alt="" src="<%=jspStoreImgDir%>images/db.gif" border="0" /></td>
						</tr>
						<tr>
							<td class="pixel"><img src="<%=jspStoreImgDir%>images/l_bot.gif" alt=""/></td>
							<td bgcolor="#7a1616" class="pixel" valign="top"><img src="<%=jspStoreImgDir%>images/db.gif" border="0" alt=""/></td>
							<td bgcolor="#7a1616" class="pixel" valign="top"><img src="<%=jspStoreImgDir%>images/db.gif" border="0" alt=""/></td>
						</tr>
						</table>
					</td>
				</tr>
			</table>
<%
}
%>
		</td>
	</tr>
</table>

<!-- content end -->

	</TD>
</TR>
</TABLE>

</BODY>
</HTML>
