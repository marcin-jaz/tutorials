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



<% // All JSPs requires the first 4 packages for getResource.jsp which is used for multi language support %> 
<% // All JSPs requires these packages for EnvironmentSetup.jsp which is used for multi language support %> 
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.ibm.commerce.server.ECConstants" %>
<%@ page import="com.ibm.commerce.server.JSPHelper" %>
<%@ page import="com.ibm.commerce.server.JSPResourceBundle" %>
<%@ page import="com.ibm.commerce.command.CommandContext" %>

<% // Page specific imports%> 
<%@ page import="com.ibm.commerce.beans.DataBeanManager" %>
<%@ page import="com.ibm.commerce.user.objects.AddressAccessBean" %>
<%@ page import="com.ibm.commerce.catalog.beans.AttributeValueDataBean" %>
<%@ page import="com.ibm.commerce.catalog.beans.AttributeDataBean" %>
<%@ page import="com.ibm.commerce.catalog.beans.ItemDataBean" %>
<%@ page import="com.ibm.commerce.catalog.beans.CatalogEntryDataBean" %>
<%@ page import="com.ibm.commerce.order.beans.OrderDataBean" %>
<%@ page import="com.ibm.commerce.order.beans.OrderItemDataBean" %>
<%@ page import="com.ibm.commerce.fulfillment.objects.ShippingModeAccessBean" %>
<%@ page import="com.ibm.commerce.fulfillment.objects.ShippingModeDescriptionAccessBean" %>
<%@ page import="com.ibm.commerce.datatype.TypedProperty" %>
<%@ page import="com.ibm.commerce.fulfillment.commands.ShippingHelper" %>

<%@ include file="../../../include/EnvironmentSetup.jspf"%>

<%
boolean shipAddrError = false;
boolean shipModeError = false;

try {

	JSPHelper jhelper = new JSPHelper(request);

	String storeId = (cmdcontext.getStoreId()).toString();
	Integer languageId = cmdcontext.getLanguageId();
	String orderRn = jhelper.getParameter("orderId");

	Long userRef = cmdcontext.getUserId();
	

%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "DTD/xhtml1-transitional.dtd">
<html>
<head>
	<title><%=tooltechtext.getString("Ship_Title")%></title>
	<link rel=stylesheet HREF="<%=fileDir%>ToolTech.css" type="text/css">

	<script language="javascript">
	var busy = false;
	
	function Handle_Next_Click(form)
	{
		if (!busy){
			busy = true;
			form.submit();
		}	
		return false;
	}
	</script>	
</head>


<body marginheight="0" marginwidth="0" leftmargin="0" topmargin="0">
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
<tr>
	<td VALIGN="top" BGCOLOR="#4c6178" WIDTH="160"> 

		<%
		incfile = includeDir + "SidebarDisplay.jsp";
		%>
		<jsp:include page="<%=incfile%>" flush="true"/>

	</td>

	<td valign="top" width="630">

	<!--content start--> 
	<form name="ShipMethodPage"  method="post" action="OrderCopy">
		<input type="hidden" name="orderId" value="<%=orderRn%>">
		<input type="hidden" name="toOrderId" value="<%=orderRn%>">
		<input type="hidden" name="status" value="P">
		<input type="hidden" name="allocate" value="*">
		<input type="hidden" name="reverse" value="*n">
		<input type="hidden" name="backorder" value="*">
		<input type="hidden" name="remerge" value="*">
		<input type="hidden" name="merge" value="*n">
		<input type="hidden" name="check" value="*n">
		<input type="hidden" name="URL" value="OrderPrepare?orderItemId*=&quantity*=&updateOrderItemId*=&addressId*=&shipModeId*=&allocate=&backorder=&reverse=&remerge=&merge=&check=&URL=<%= java.net.URLEncoder.encode("OrderDisplayPendingView?cmdStoreId=") %>">
		<?input type="hidden" name="URL" value="AllocationCheck?cmdStoreId="?>


		<TABLE CELLPADDING="8">
			<tr>
				<td>
					<H1><%=tooltechtext.getString("Ship_Title")%><br>
					</H1>
					<br>

	<jsp:useBean id="orderBean" class="com.ibm.commerce.order.beans.OrderDataBean" scope="page">
	<% 
		orderBean.setOrderId(orderRn);
		com.ibm.commerce.beans.DataBeanManager.activate(orderBean, request);
	%>
	</jsp:useBean>

		<input type=hidden name="cmdStoreId" value="<%=orderBean.getStoreEntityId()%>" >
									<br>
									<table class="list" cellpadding=0 cellspacing=0 border=0 width="605" bgcolor="#4c6178">
										<tr>
												<td>
													<table width="100%" border=0 cellpadding=2 cellspacing=1>
									<!-- begin table header -->
														<tr bgcolor="#4c6178">
															<td width="9%">
																<table>
																	<tr>
																		<td valign="top"><font style="font-family : Verdana;" color="#ffffff"><strong><%=tooltechtext.getString("Ship_Quantity")%></strong></font></td>
																	</tr>
																</table>
															</td>
															<td width="14%">
																<table>
																	<tr>
																		<td valign="top"><font style="font-family : Verdana;" color="#ffffff"><strong><%=tooltechtext.getString("Ship_SKU")%></strong></font></td>
																	</tr>
																</table>
															</td>
															<td width="26%">
																<table>
																	<tr>
																		<td valign="top"><font style="font-family : Verdana;" color="#ffffff"><strong><%=tooltechtext.getString("Ship_Name")%></strong></font></td>
																	</tr>
																</table>
															</td>
															<td width="18%">
																<table>
																	<tr>
																		<td valign="top"><font style="font-family : Verdana;" color="#ffffff"><strong><%=tooltechtext.getString("Ship_ShipAdd")%></strong></font></td>
																	</tr>
																</table>
															</td>
															<td width="18%">
																<table>
																	<tr>
																		<td valign="top"><font style="font-family : Verdana;" color="#ffffff"><strong><%=tooltechtext.getString("Ship_ShipMeth")%></strong></font></td>
																	</tr>
																</table>
															</td>
															<!--<td width="15%">
																<table>
																	<tr>
																		<td valign="top"></td>
																	</tr>
																</table>
															</td>-->
														</tr>
									<!-- end table header -->

	<%
		OrderItemDataBean [] orderItems = orderBean.getOrderItemDataBeans();	
		OrderItemDataBean orderItem;
		int    iQuantity = 0;
		String productId = "";
		String sku = "";
		String desc1 = "";
		String desc2 = "";
		String itemShipModeId  = "";
		String orderItemId = "";
		ShippingModeDescriptionAccessBean shipModeDesc;
		String aShipModeDesc =  "";
		String aShipModeId = "";
		ShippingModeAccessBean shipModeId;
		AddressAccessBean addr;
		AddressAccessBean[] listOfAddrs;
		ShippingModeAccessBean[] listOfShipModeId;
		String addressId = "";
		String aShipAddressId = "";
		String aNickName = "";
		
		String[] arrRowColour = new String[]{"#ffffff", "BCCBDB"};
		int altInd = 0;
	for (int i=0; i < orderItems.length; i ++)
	{
		orderItem = orderItems[i];

		// get the quantity 
		iQuantity = orderItem.getQuantityInEJBType().intValue();

		// get the items short description to display
		desc1 = orderItem.getCatalogEntry().getDescription(cmdcontext.getLanguageId()).getShortDescription();


		// Loop through all the attributes and store them in desc2 to print out
        desc2 = "";
        // first check whether this item supports attributes
		CatalogEntryDataBean catentry = new CatalogEntryDataBean();
		catentry.setCatalogEntryID(orderItem.getCatalogEntryId());
		DataBeanManager.activate (catentry, request);
        if (catentry.getType().equals("ItemBean")) {
		    ItemDataBean item = new ItemDataBean(catentry);

		    StringBuffer attributeDesc = new StringBuffer(256);
		    //item.setItemID(orderItem.getCatalogEntryId());
		    //DataBeanManager.activate (item, request);
	
		    AttributeValueDataBean attrvalue[];
		    attrvalue = item.getAttributeValueDataBeans(languageId);
		    AttributeDataBean attribute[] = new AttributeDataBean[attrvalue.length];
		    for (int x=0; x<attrvalue.length; x++)
		    {
		    	attribute[x] = attrvalue[x].getAttributeDataBean();
		    	attributeDesc.append("<strong>");
		    	attributeDesc.append(attribute[x].getName());
		    	attributeDesc.append(" : </strong>");
		    	attributeDesc.append(attrvalue[x].getValue());
		    	attributeDesc.append("<br>");
		    }          

		    desc2 = attributeDesc.toString(); 		// Store item attributes in desc2.
        }
		// get the sku # for the item
		sku = orderItem.getPartNumber();

		// get the list of address
		listOfAddrs = ShippingHelper.getInstance().getAllowableShippingAddresses(orderItem);
		if (listOfAddrs == null)
			shipAddrError = true;  //This shouldn't happen, but in case shipping addr in TC is no good

		// get the list of shipping method
		listOfShipModeId = ShippingHelper.getInstance().getAllowableShippingModes(orderItem);
		if (listOfShipModeId == null)
			shipModeError = true; //This shouldn't happen, but in case shipping mode in TC is no good

		orderItemId = orderItem.getOrderItemId();  
		
		altInd = i%2;    // i MOD 2
		
		/*
		The input "updateOrderItemId_i" is passed in for each value of OrderItemId
		so that OrderCopy command will call OrderItemUpdate command to update
		shipMode and ShipTo address for each item.
		*/
	%>
	<input type="hidden" name="orderItemId_<%=i+1%>" value="<%=orderItemId%>">	
	<input type="hidden" name="quantity_<%=i+1%>" value="<%=iQuantity%>">
	<input type="hidden" name="updateOrderItemId_<%=i+1%>" value="<%=orderItemId%>">

	
													<tr bgcolor="<%=arrRowColour[altInd]%>">
														<td width="9%" align="left" valign="top"><%=iQuantity%></td>
														<td width="14%" valign="top"><%=sku%></td>
														<td width="26%" valign="top">
															<p><a href="ProductDisplay?productId=<%=orderItem.getCatalogEntryId()%>"><%=desc1%></a><br><%=desc2%></p>
														</td>
														<td width="18%" valign="top"><label for="WC_BillingShippingDisplay_FormInput_addressId_1_<%=i+1%>"><img src="<%=fileDir%>images/trans.gif" height="1" width="1" border="0" alt="<%=tooltechtext.getString("Ship_ShipAdd")%>"/></label>
<select name="addressId_<%=i+1%>" size="1" style="WIDTH: 125px" id="WC_BillingShippingDisplay_FormInput_addressId_1_<%=i+1%>" title="<%=tooltechtext.getString("Ship_ShipAdd")%>">
															<%
																String selected = "";
																for (int ai = 0; ai < listOfAddrs.length; ai++) 
																{
																	addr = (AddressAccessBean) listOfAddrs[ai];
																	aShipAddressId = addr.getAddressId();
																	aNickName = addr.getNickName();
																	String shipId = orderItem.getAddressId();
																	if ((shipId != null) && (shipId.equals(aShipAddressId))){
																		selected = "selected";	
																	} else {
																		selected = "";	
																	}
															%>
																<option value="<%=aShipAddressId%>" <%=selected%>><%=aNickName%></option>
															<%
																} //end for
															%>
															</select></td>
														
														<td width="18%" valign="top"><label for="WC_BillingShippingDisplay_FormInput_shipModeId_1_<%=i+1%>"><img src="<%=fileDir%>images/trans.gif" height="1" width="1" border="0" alt="<%=tooltechtext.getString("Ship_ShipMeth")%>"/></label>
<select name="shipModeId_<%=i+1%>" size="1" style="WIDTH: 125px" id="WC_BillingShippingDisplay_FormInput_shipModeId_1_<%=i+1%>" title="<%=tooltechtext.getString("Ship_ShipMeth")%>">
															<%
																selected ="";
																for (int j = 0; j < listOfShipModeId.length; j++) 
																{
																	shipModeId = (ShippingModeAccessBean) listOfShipModeId[j];
																	aShipModeId = shipModeId.getShippingModeId();
																	shipModeDesc = shipModeId.getDescription(languageId, cmdcontext.getStoreId());
																	aShipModeDesc = shipModeDesc.getDescription();
																	String shipMode = orderItem.getShippingModeId();

																	if ((shipMode != null) && (shipMode.equals(aShipModeId))){
																		selected = "selected";	
																	} else {
																		selected = "";	
																	}																	
															%>
                 												<option VALUE="<%=aShipModeId%>" <%=selected%>><%=aShipModeDesc%></option>
															<%
																} // end for
															%>
															</select></td>
														<!--<td width="15%" align="left" valign="top"><a href="AvailableShippingMethod?orderId=<%=orderRn%>&orderItemId=<%=orderItem.getOrderItemId()%>&page=shipmethod"><%=tooltechtext.getString("Ship_Link")%></a></td>-->
													</tr>

	<%
	} // end for
	%>
													</table>
												</td>
											</tr>
									</table>
								</td>
		</tr>								
	</TABLE>

	<BR>
	  <TABLE CELLPADDING="3">
	  <tr>
		<td>
			<table cellpadding="0" cellspacing="0" border="0">
			<tr>
				<td bgcolor="#ff2d2d" class="pixel"><img src="<%=fileDir%>images/lb.gif" border="0" alt=""/></td>
				<td bgcolor="#ff2d2d" class="pixel"><img src="<%=fileDir%>images/lb.gif" border="0" alt=""/></td>
				<td class="pixel"><img src="<%=fileDir%>images/r_top.gif" border="0" alt=""/></td>
			</tr>
			<tr>
				<td bgcolor="#ff2d2d"><img alt="" src="<%=fileDir%>images/lb.gif" border="0"/></td>
				<td bgcolor="#ea2b2b">
					<table cellpadding="2" cellspacing="0" border="0">
					<tr>
						<td class="buttontext">
							<font color="#ffffff"><b>
							<a HREF="OrderItemDisplay?orderId=*&check=*n" style="color:#ffffff; text-decoration : none;">
							&lt; <%=tooltechtext.getString("Ship_Previous")%>
							</a>
							</b></font>
						</td>
					</tr>
					</table>
				</td>
				<td bgcolor="#7a1616"><img alt="" src="<%=fileDir%>images/db.gif" border="0"/></td>			<tr>
				<td class="pixel"><img src="<%=fileDir%>images/l_bot.gif" alt=""/></td>
				<td bgcolor="#7a1616" class="pixel" valign="top"><img src="<%=fileDir%>images/db.gif" border="0" alt=""/></td>
				<td bgcolor="#7a1616" class="pixel" valign="top"><img src="<%=fileDir%>images/db.gif" border="0" alt=""/></td>
			</tr>
		</table>
	</td>
	
	<% 
	if (!shipAddrError && !shipModeError) { 
		//if there's error, we won't show this button.
	%>
		<td>
			<table cellpadding="0" cellspacing="0" border="0">
			<tr>
				<td bgcolor="#ff2d2d" class="pixel"><img src="<%=fileDir%>images/lb.gif" border="0" alt=""/></td>
				<td bgcolor="#ff2d2d" class="pixel"><img src="<%=fileDir%>images/lb.gif" border="0" alt=""/></td>
				<td class="pixel"><img src="<%=fileDir%>images/r_top.gif" border="0" alt=""/></td>
			</tr>
			<tr>
				<td bgcolor="#ff2d2d"><img alt="" src="<%=fileDir%>images/lb.gif" border="0"/></td>
				<td bgcolor="#ea2b2b">
					<table cellpadding="2" cellspacing="0" border="0">
					<tr>
						<td class="buttontext">
							<font color="#ffffff"><b>
							<a href="#" onClick="Handle_Next_Click(document.ShipMethodPage); return false;" style="color:#ffffff; text-decoration : none;">
							<%=tooltechtext.getString("Ship_Next")%>&gt;
							</a>
							</b></font>
						</td>
					</tr>
					</table>
				</td>
				<td bgcolor="#7a1616"><img alt="" src="<%=fileDir%>images/db.gif" border="0"/></td>			<tr>
				<td class="pixel"><img src="<%=fileDir%>images/l_bot.gif" alt=""/></td>
				<td bgcolor="#7a1616" class="pixel" valign="top"><img src="<%=fileDir%>images/db.gif" border="0" alt=""/></td>
				<td bgcolor="#7a1616" class="pixel" valign="top"><img src="<%=fileDir%>images/db.gif" border="0" alt=""/></td>
			</tr>
		</table>	
	  </td>
	  <% } //endif error 
	  %>
	  
	 </tr>
	</TABLE>
	
	<%
	} catch (Exception e)
	{		
		e.printStackTrace();
	}

	%>

	<%
	//Display error messages. 	
	if (shipAddrError)
	{
		%><p><font color="red"><%= tooltechtext.getString("Ship_Ship_Address_Not_Found")%></font><br><br></p><%		
	}
	
	if (shipModeError)
	{
		%><p><font color="red"><%= tooltechtext.getString("Ship_Ship_Mode_Not_Found")%></font><br><br></p><%		
	}
	%>
						<p></p>
						<p></p>

	</form>

<!--content end--> 
	</td>
</tr>
</TABLE>


</BODY>

</HTML>
