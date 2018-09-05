
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
<%@ page import="com.ibm.commerce.catalog.beans.ProductDataBean" %>
<%@ page import="com.ibm.commerce.order.utils.OrderConstants"   %>
<%@ page import="com.ibm.commerce.datatype.TypedProperty" %>
<%@ page import="com.ibm.commerce.ras.ECMessageKey" %>

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

JSPHelper jhelper 		= new JSPHelper(request);

String partNumber		= jhelper.getParameter("partNumber");
String quantity 		= jhelper.getParameter("quantity");
if (partNumber==null) partNumber = "";
if (quantity==null) quantity = "";

String reqListStoreId = jhelper.getParameter("reqListStoreId");

//Switch background color
boolean displaySwitch		= true;
String requisitionListId 	= "";
String[] strPartNumber 		= new String[31];
String[] strQuantity 		= new String[31];
String strName 			= null;
String strStatus 			= null;
String strErrorMessage 		= null;
String strErrorCode 		= "";
String strFieldName 		= null;
Object strMessageParams[] 	= null;
String strMessageKey 		= bnError.getMessageKey();

if (strMessageKey != null && strMessageKey.length() > 0) {
	// We have an error


	strMessageParams = bnError.getMessageParam();
	if (strMessageKey.equals(ECMessageKey._ERR_BAD_MISSING_CMD_PARAMETER)) {
		strErrorMessage = tooltechtext.getString("Newreq_Error_Missing_Parameter");
	}  else if (strMessageKey.equals(ECMessageKey._ERR_GETTING_SKU)) {
		TypedProperty nvps = bnError.getExceptionData();
		if (nvps != null) {
			String catEntryId = nvps.getString("catEntryId");
			ProductDataBean prodDB=new ProductDataBean();
			prodDB.setProductID(catEntryId);
			com.ibm.commerce.beans.DataBeanManager.activate(prodDB, request); 
			strErrorMessage = tooltechtext.getString("Newreq_Error_ProdSKU")+ "&nbsp;&nbsp;" + prodDB.getPartNumber();
		}

	}  else if (strMessageKey.equals(ECMessageKey._ERR_PROD_NOT_EXISTING)) {
		strFieldName = (String)strMessageParams[0];
		strErrorMessage = tooltechtext.getString("Newreq_Error_SKU") + "&nbsp;&nbsp;" + strFieldName;
	} else if (strMessageKey.equals(ECMessageKey._ERR_INVALID_INPUT)) {
		strErrorMessage = tooltechtext.getString("Newreq_Error_Quantity") + "&nbsp;&nbsp;" + jhelper.getParameter("quantity");
	}
	//Retrieve form data entered before
	strName = jhelper.getParameter("name");
	strStatus = jhelper.getParameter("status");
	for (int i=1; i<31; i++) {
		strPartNumber[i] = jhelper.getParameter("partNumber_"+i);
		strQuantity[i] = jhelper.getParameter("quantity_"+i);
		if (strPartNumber[i]==null) strPartNumber[i] = "";
		if (strQuantity[i]==null) strQuantity[i] = "";
	}

} else {
	//If the form is loaded by clicking "Create New Requisition List" from the Requisition List Display page, initialize all fields to empty.
	//If the form is loaded by adding item to new requisition list from item display page, initialize the first pair of SKU and quantity.
	strName = "";
	strStatus = "Y";
	for (int i=1; i<31; i++) {
		strPartNumber[i] = jhelper.getParameter("partNumber_"+i);
		strQuantity[i] = jhelper.getParameter("quantity_"+i);
		if (strPartNumber[i]==null) strPartNumber[i] = "";
		if (strQuantity[i]==null) strQuantity[i] = "";
	}

    if ((partNumber.length() > 0) && (strPartNumber[1].length() == 0)){
	    strPartNumber[1] = partNumber;
	    strQuantity[1] = quantity;
    }

}
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "DTD/xhtml1-transitional.dtd">

<SCRIPT language="javascript">
function Add2ReqList(form)
{
  var i;

  for (i=0;i<30;i++) 
  {
	if (( !(form.elements[i*2+4].value == "")) && (form.elements[i*2+5].value == ""))
	{
		form.elements[i*2+5].value = "1";
	}

  }

  form.submit();


}
</SCRIPT>

<HTML>
<HEAD>
	<title><%=tooltechtext.getString("Newreq_Title")%></title>
	<link rel=stylesheet href="<%=fileDir%>ToolTech.css" type="text/css">
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


		<!--content start-->

		<%
		if (strErrorMessage != null)
			{
			//Display error messages
			%><p><font color="red"><%=strErrorMessage%><br><br></font></p><%
			}
		%>	

		<TABLE CELLPADDING="8" CELLSPACING="0" BORDER="0" width="605">
			<TR>
				<TD><H1><%=tooltechtext.getString("Newreq_Title")%></H1>
				<form name="NewRequisitionListForm" action="RequisitionListItemUpdate" method="post">
				<input type=hidden name="reqListStoreId" value="<%= reqListStoreId %>">
				<input type=hidden name="cmdStoreId" value="<%= reqListStoreId %>">
				<input type=hidden name="URL" value="RequisitionListUpdateView?cmdStoreId=&partNumber_*=&quantity_*=">
				<input type=hidden name="errorViewName" value="RequisitionListCreateView">

					<TABLE CELLSPACING="0" BORDER="0">
						<TR>
							<TD><b><%=tooltechtext.getString("Newreq_Store")%></b>&nbsp;&nbsp;<%= reqListStoreId %></TD>
						</TR>
						<TR>
							<TD><FONT class="p"><label for="WC_RequisitionListCreateForm_FormInput_name_1"><%=tooltechtext.getString("Newreq_Name")%></label></FONT></TD>
						</TR>
						<TR>
							<TD><input type="text" name="name" value="<%=strName%>" id="WC_RequisitionListCreateForm_FormInput_name_1"></TD>
						</TR>
						<TR>
							<TD><label for="WC_RequisitionListCreateForm_FormInput_status_1"><%=tooltechtext.getString("Newreq_Type")%></label></TD>
						</TR>
						<TR>
							<TD><A name="status"><SELECT name="status" id="WC_RequisitionListCreateForm_FormInput_status_1">
<%
if (strStatus.equals("Y")) {
								out.println("<option value='Y' SELECTED><FONT class='p'>"+tooltechtext.getString("Newreq_Drop1")+"</FONT></option>");
								out.println("<option value='Z'><FONT class='p'>"+tooltechtext.getString("Newreq_Drop2")+"</FONT></option>");
} else  {
								out.println("<option value='Y'><FONT class='p'>"+tooltechtext.getString("Newreq_Drop1")+"</FONT></option>");
								out.println("<option value='Z' SELECTED><FONT class='p'>"+tooltechtext.getString("Newreq_Drop2")+"</FONT></option>");
}
%>
								</SELECT></A>
							</TD>
						</TR>
					</TABLE>
					<BR>

				
					<FONT class="p"><%=tooltechtext.getString("Newreq_Text")%>
					</FONT>

				</TD>
			</TR>
			<TR>
				<TD>

					<table cellpadding="0" cellspacing="0" border="0" width="605" bgcolor="#4C6178">
						<tr>
							<td>
								<table width="100%" border="0" cellpadding="2" cellspacing="1">
									<tr bgcolor="#4C6178">
										<td valign="TOP">
											<table align="center">
												<tr>
													<td valign="TOP"><font style="font-family : Verdana;" color="#FFFFFF"><strong>&nbsp;</strong></font></td>
												</tr>
											</table>
										</td>
										<td valign="TOP" colspan="2">
											<table align="center">
												<tr>
													<td valign="TOP"><font style="font-family : Verdana;" color="#FFFFFF"><strong><%=tooltechtext.getString("Newreq_SKU")%></strong></font></td>
												</tr>
											</table>
										</td>
										<td valign="TOP">
											<table align="center">
												<tr>
													<td><font style="font-family : Verdana;" color="#FFFFFF"><strong><%=tooltechtext.getString("Newreq_Quantity")%></strong></font></td>
												</tr>
											</table>
										</td>
										<td>
											<table align="center">
												<tr>
													<td valign="TOP"><font style="font-family : Verdana;" color="#FFFFFF"><strong>&nbsp;</strong></font></td>
												</tr>
											</table>
										</td>
										<td valign="TOP" colspan="2">
											<table align="center">
												<tr>
													<td valign="TOP"><font style="font-family : Verdana;" color="#FFFFFF"><strong><%=tooltechtext.getString("Newreq_SKU")%></strong></font></td>
												</tr>
											</table>
										</td>
										<td valign="TOP">
											<table align="center">
												<tr>
													<td><font style="font-family : Verdana;" color="#FFFFFF"><strong><%=tooltechtext.getString("Newreq_Quantity")%></strong></font></td>
												</tr>
											</table>
										</td>
									</tr>
									<tr bgcolor='#ffffff'>
										<td align="center">1</td>
										<td align="center" colspan="2">
										<label for="WC_RequisitionListCreateForm_FormInput_partNumber_1_1"><img src="<%=fileDir%>images/trans.gif" height="1" width="1" border="0" alt="<%=tooltechtext.getString("Newreq_SKU")%>"/></label>
										<input type="text" name="partNumber_1"  size="8" value="<%=strPartNumber[1]%>" id="WC_RequisitionListCreateForm_FormInput_partNumber_1_1" title="<%=tooltechtext.getString("Newreq_SKU")%>"></td>
										<td align="center">
										<label for="WC_RequisitionListCreateForm_FormInput_quantity_1_1"><img src="<%=fileDir%>images/trans.gif" height="1" width="1" border="0" alt="<%=tooltechtext.getString("Newreq_Quantity")%>"/></label>
										<input type="text" name="quantity_1" size="6" value="<%=strQuantity[1]%>" id="WC_RequisitionListCreateForm_FormInput_quantity_1_1" title="<%=tooltechtext.getString("Newreq_Quantity")%>"></td>
										<td align="center">2</td>
										<td align="center" colspan="2">
										<label for="WC_RequisitionListCreateForm_FormInput_partNumber_2_1"><img src="<%=fileDir%>images/trans.gif" height="1" width="1" border="0" alt="<%=tooltechtext.getString("Newreq_SKU")%>"/></label>
										<input type="text" name="partNumber_2"  size="8" value="<%=strPartNumber[2]%>" id="WC_RequisitionListCreateForm_FormInput_partNumber_2_1" title="<%=tooltechtext.getString("Newreq_SKU")%>"></td>
										<td align="center">
										<label for="WC_RequisitionListCreateForm_FormInput_quantity_2_1"><img src="<%=fileDir%>images/trans.gif" height="1" width="1" border="0" alt="<%=tooltechtext.getString("Newreq_Quantity")%>"/></label>
										<input type="text" name="quantity_2" size="6" value="<%=strQuantity[2]%>" id="WC_RequisitionListCreateForm_FormInput_quantity_2_1" title="<%=tooltechtext.getString("Newreq_Quantity")%>"></td>
									</tr>
<%
for (int i=1;i<15;i++) {
	displaySwitch=!displaySwitch;
									if (displaySwitch) out.println("<tr bgcolor='#ffffff'>");
									else out.println("<tr bgcolor='#BCCBDB'>");
	
%>
					
										<td align="center"><%= i*2+1 %></td>
										<td align="center" colspan="2">
										<label for="WC_RequisitionListCreateForm_FormInput_partNumber_<%= i*2+1 %>_1"><img src="<%=fileDir%>images/trans.gif" height="1" width="1" border="0" alt="<%=tooltechtext.getString("Newreq_SKU")%>"/></label>
										<input type="text" name="partNumber_<%= i*2+1 %>"  size="8" value="<%=strPartNumber[i*2+1]%>" id="WC_RequisitionListCreateForm_FormInput_partNumber_<%= i*2+1 %>_1" title="<%=tooltechtext.getString("Newreq_SKU")%>"></td>
										<td align="center">
										<label for="WC_RequisitionListCreateForm_FormInput_quantity_<%= i*2+1 %>_1"><img src="<%=fileDir%>images/trans.gif" height="1" width="1" border="0" alt="<%=tooltechtext.getString("Newreq_Quantity")%>"/></label>
										<input type="text" name="quantity_<%= i*2+1 %>" size="6" value="<%=strQuantity[i*2+1]%>" id="WC_RequisitionListCreateForm_FormInput_quantity_<%= i*2+1 %>_1" title="<%=tooltechtext.getString("Newreq_Quantity")%>"></td>
										<td align="center"><%= i*2+2 %></td>
										<td align="center" colspan="2">
										<label for="WC_RequisitionListCreateForm_FormInput_partNumber_<%= i*2+2 %>_1"><img src="<%=fileDir%>images/trans.gif" height="1" width="1" border="0" alt="<%=tooltechtext.getString("Newreq_SKU")%>"/></label>
										<input type="text" name="partNumber_<%= i*2+2 %>"  size="8" value="<%=strPartNumber[i*2+2]%>" id="WC_RequisitionListCreateForm_FormInput_partNumber_<%= i*2+2 %>_1" title="<%=tooltechtext.getString("Newreq_SKU")%>"></td>
										<td align="center">
										<label for="WC_RequisitionListCreateForm_FormInput_quantity_<%= i*2+2 %>_1"><img src="<%=fileDir%>images/trans.gif" height="1" width="1" border="0" alt="<%=tooltechtext.getString("Newreq_Quantity")%>"/></label>
										<input type="text" name="quantity_<%= i*2+2 %>" size="6" value="<%=strQuantity[i*2+2]%>" id="WC_RequisitionListCreateForm_FormInput_quantity_<%= i*2+2 %>_1" title="<%=tooltechtext.getString("Newreq_Quantity")%>"></td>
									</tr>


<%
}
%>

								</table>
							
							</td>
						</tr>
					</table>
				</form>
				</TD>
			</TR>
		</TABLE>

		<p></p>
		<TABLE CELLPADDING="8" CELLSPACING="0" BORDER="0">
			<TR>
				<TD>
					<table cellpadding="0" cellspacing="0" border="0">
					<tr>
						<td bgcolor="#ff2d2d" class="pixel"><img src="<%=jspStoreImgDir%>images/lb.gif" border="0" alt=""/></td>
						<td bgcolor="#ff2d2d" class="pixel"><img src="<%=jspStoreImgDir%>images/lb.gif" border="0" alt=""/></td>
						<td class="pixel"><img src="<%=jspStoreImgDir%>images/r_top.gif" border="0" alt=""/></td>
					</tr>
					<tr>
						<td bgcolor="#ff2d2d"><img alt="" src="<%=jspStoreImgDir%>images/lb.gif" border="0"/></td>
						<td bgcolor="#ea2b2b">
							<table cellpadding="2" cellspacing="0" border="0">
							<tr>
								<td class="buttontext">
									<font color="#ffffff"><b>
									<a href="javascript:Add2ReqList(document.NewRequisitionListForm)" style="color:#ffffff; text-decoration : none;">
									&nbsp;<%=tooltechtext.getString("Newreq_Button")%>&nbsp;
									</a>
									</b></font>
								</td>
							</tr>
							</table>
						</td>
						<td bgcolor="#7a1616"><img alt="" src="<%=jspStoreImgDir%>images/db.gif" border="0"/></td>
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


		<!--content end-->

	</TD>
</TR>
</TABLE>
</BODY>
</HTML>
