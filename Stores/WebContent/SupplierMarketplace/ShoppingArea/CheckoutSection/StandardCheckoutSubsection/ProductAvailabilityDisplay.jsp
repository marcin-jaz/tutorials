<%
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
<%@ page import="com.ibm.commerce.catalog.beans.AttributeValueDataBean" %>
<%@ page import="com.ibm.commerce.catalog.beans.AttributeDataBean" %>
<%@ page import="com.ibm.commerce.catalog.beans.ItemDataBean" %>
<%@ page import="com.ibm.commerce.catalog.beans.CatalogEntryDataBean" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="com.ibm.commerce.utils.TimestampHelper" %>
<%@ page import="com.ibm.commerce.order.beans.OrderDataBean" %>
<%@ page import="com.ibm.commerce.order.beans.OrderItemDataBean" %>
<%@ page import="com.ibm.commerce.inventory.beans.ItemSpecificationDataBean" %>

<%@ include file="../../../include/EnvironmentSetup.jspf"%>

<%
try{
/*
This page is displayed if insufficient inventory available for the order items.  It is is only 
reached if some order items are available, and some order items are unavailable.  It displays the
availability date for each item and the user's available options as well.
*/

//Parameters may be encrypted. Use JSPHelper to get
//URL parameter instead of request.getParameter().
JSPHelper jhelper = new JSPHelper(request);

String incfile = null;
String storeId = jhelper.getParameter("storeId");
String orderRn = jhelper.getParameter("orderId");
String paymentMethod = jhelper.getParameter("paymentMethod");
if (paymentMethod == null) paymentMethod = "";

Long userId = cmdcontext.getUserId();
%>



<jsp:useBean id="orderBean" class="com.ibm.commerce.order.beans.OrderDataBean" scope="page">
<% 
orderBean.setOrderId(orderRn);
com.ibm.commerce.beans.DataBeanManager.activate(orderBean, request);
%>
</jsp:useBean>

<% Integer nOrderStoreId = orderBean.getStoreEntityIdInEJBType(); %>

<%
// *************  CHECK IF SUFFICIENT INVENTORY AVAILABLE ****************
boolean bAllOrderItemsAvailable = true;
boolean bAllOrderItemsOnBackorder = true;
OrderItemDataBean [] orderItems = orderBean.getOrderItemDataBeans();	
String invStatus = "";

// Loop through all OrderItemBeans and check which have not been allocated
if (orderItems.length <= 0)
{
 incfile = storeDir + "ShoppingArea/CurrentOrderSection/EmptyOrderDisplay.jsp";%>
 <jsp:forward page="<%=incfile%>" />
 <%
}

for (int i=0; i < orderItems.length; i ++)
{
	invStatus = orderItems[i].getInventoryStatus();
	
	// if we find an item unallocated or on backorder, we know that all items arent available
	if (invStatus.equalsIgnoreCase("nalc") || invStatus.equalsIgnoreCase("bo")){	// backordered or unknown
		bAllOrderItemsAvailable = false;
	}
	/* if we find an item that is allocated, we know that not all items can be on backorder*/
	if (invStatus.equalsIgnoreCase("nalc") ||invStatus.equalsIgnoreCase("allc")){
		bAllOrderItemsOnBackorder = false;
	}
} // end for
%>




<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "DTD/xhtml1-transitional.dtd">
<html>
<HEAD>
	<TITLE><%= tooltechtext.getString("ProdAvail_Title") %></TITLE>
	<LINK REL=stylesheet HREF="<%=fileDir%>ToolTech.css" TYPE="text/css">
</HEAD>


<BODY MARGINHEIGHT="0" MARGINWIDTH="0" LEFTMARGIN="0" TOPMARGIN="0" >

<%
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



<TABLE CELLPADDING="8" CELLSPACING="0" BORDER="0" width="605">
	<TR>
		<TD><H1><%= tooltechtext.getString("ProdAvail_Title") %></H1>


<TABLE class="list" CELLPADDING=0 CELLSPACING=0 BORDER=0 width="605" bgcolor="#4c6178">
			<TR>
				<TD>
					<TABLE WIDTH="100%" BORDER=0 CELLPADDING=2 CELLSPACING=1>
        				<TR bgcolor="#4c6178"> 
          					<TD width="12%"> 
            					<TABLE>
              						<TR> 
                						<TD VALIGN="top"><font style="font-family : Verdana;" color="#ffffff"><strong><%= tooltechtext.getString("ProdAvail_Quantity") %></strong></font></TD>
              						</TR>
            					</TABLE>
          					</TD>
          					<TD width="17%"> 
            					<TABLE>
              						<TR> 
                						<TD VALIGN="top"><font style="font-family : Verdana;" color="#ffffff"><strong><%= tooltechtext.getString("ProdAvail_SKU") %></strong></font></TD>
              						</TR>
            					</TABLE>
          					</TD>
          					<td width="26%"> 
            					<TABLE>
              						<TR> 
                						<TD VALIGN="top"><font style="font-family : Verdana;" color="#ffffff"><strong><%= tooltechtext.getString("ProdAvail_Name") %></strong></font></TD>
              						</TR>
            					</TABLE>
          					</td>
          					<TD width="22%"> 
            					<table>
              						<tr> 
                						<td valign="top"><font style="font-family : Verdana;" color="#ffffff"><strong><%= tooltechtext.getString("ProdAvail_EstShp") %></strong></font></td>
              						</tr>
            					</table>
          					</TD>
          					<TD width="22%">&nbsp; </TD>
          					<TD width="23%">&nbsp; </TD>
        				</TR>
<%
// Get locale for formatting the date appropriately
Locale jLocale 		= cmdcontext.getLocale();

Timestamp latestOrderAvailDate = orderBean.getEstimatedShipDate();

//String latestAvailableDate = java.text.DateFormat.getDateInstance().format(orderBean.getEstimatedShipDate());
String latestAvailableDate = TimestampHelper.getDateFromTimestamp(latestOrderAvailDate, jLocale);

String availableDate = "";
int    iQuantity = 0;
String productId = "";
String desc1 = "";
String desc2 = "";
Timestamp orderAvailDate = null;
OrderItemDataBean orderItem = null;
boolean discontinued = false;
boolean avail_unknown = false;
boolean backorderable = false;
String temp = "";

   	   	
for (int i=0; i < orderItems.length; i ++)
{
	orderItem = orderItems[i];

	//--- GET REQUIRED ATTRIBUTES

	// get the quantity attribute
	iQuantity = orderItem.getQuantityInEJBType().intValue();

	// get the item description, line1 and line2
	desc1 = orderItem.getCatalogEntry().getDescription(cmdcontext.getLanguageId()).getShortDescription();
	
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

    	AttributeValueDataBean attrvalue[];
    	attrvalue = item.getAttributeValueDataBeans(cmdcontext.getLanguageId());
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
	    desc2 = attributeDesc.toString(); // Store item attributes in desc2.
    }

	invStatus = orderItem.getInventoryStatus();
	if (invStatus.equalsIgnoreCase("nalc")){
		String itemSpcId = orderItem.getItemSpecId();
		ItemSpecificationDataBean ItemSpecdb = new ItemSpecificationDataBean();
		ItemSpecdb.setDataBeanKeyItemspcId(itemSpcId);            
		String dis = ItemSpecdb.getDiscontinued();                //returns Y if discontinued and N if not.
		
		if (dis.equalsIgnoreCase("n"))         // if the item is not discontinued, but cannot be backordered. 
		{
		  avail_unknown = true;              
		  availableDate = tooltechtext.getString("ProdAvail_Unknown");

		}
		else if (dis.equalsIgnoreCase("y"))	// else if the item is discontinued	
		{
		discontinued = true;
		availableDate = tooltechtext.getString("ProdAvail_Discontinued");
		}
	}
	
	else if (invStatus.equalsIgnoreCase("bo")){
		// get the estimated availability date 
		orderAvailDate = orderItem.getEstimatedShippingTime();
		backorderable = true;
		if (orderAvailDate == null){
			availableDate = tooltechtext.getString("ProdAvail_Out"); // The product is out of stock
		} 
		else{
			// Format date formatted appropriately from the TimeStampHelper
			availableDate = TimestampHelper.getDateFromTimestamp(orderAvailDate, jLocale);
		}
	} else if (invStatus.equalsIgnoreCase("allc")){
		orderAvailDate = orderItem.getEstimatedShippingTime();
		availableDate = TimestampHelper.getDateFromTimestamp(orderAvailDate, jLocale);
	} else {
		availableDate = tooltechtext.getString("ProdAvail_Out");    //"Out of Stock";
		
	}

%>
 
        				<TR bgcolor="#ffffff"> 
          					<TD width="12%" align="left" valign="top"><%=iQuantity%></TD>
          					<TD width="17%" valign="top"><%=orderItem.getPartNumber()%></TD>
          					<TD width="26%" valign="top">
								<p><a href="ProductDisplay?productId=<%=orderItem.getCatalogEntryId()%>"><%=desc1%></a><br><%=desc2%></p>
						</TD>       					
          					<TD width="22%" valign="top">
						<% if (invStatus.equalsIgnoreCase("nalc")){    // display in red if the product is unavailable
						        	%><font color = "red" ><%=availableDate%></font><% 
						        }else // otherwise display normal
						        {
						        	%><%=availableDate%>
						        <%}%>
						</TD>
          					<% /* Link to delete the item. Use OrderItemUpdate with Quantity 0 in order to delete and reallocate. */ %> 
          					<TD width="23%" valign="top"><A HREF="OrderItemUpdate?cmdStoreId=<%=nOrderStoreId %>&orderItemId=<%=orderItem.getOrderItemId()%>&quantity=0&orderId=<%=orderRn%>&allocate=*&backorder=*&reverse=*n&check=*n&status=P&paymentMethod=<%=java.net.URLEncoder.encode(paymentMethod)%>&URL=<%= java.net.URLEncoder.encode("CheckProductAvail?cmdStoreId=") %>"><%= tooltechtext.getString("ProdAvail_Remove") %></A></TD>
        				</TR>
<%
	temp = "";
} // end for
%>
      				</TABLE>
				</TD>
			</TR>
		</TABLE>

<script language="javascript">
var busy = false;
	
function GoToOrderSummary(form)
{
	if (!busy)
	{
		busy = true;
		if(form.isAllItemsAvailable.value == 'false')
		{
			if (form.orderOption[0].checked) 			// Entire option
			{	
				submitForm(document.EntireOrderForm);
			} 
			else if (form.orderOption[1].checked) 		// Split and place both	
			{
				document.OrderSplitForm.outOrderName.value = "orderId";
				submitForm(document.OrderSplitForm);
			}
			// ** modify here, to change shipping method option
		} 
		else {
			submitForm(document.EntireOrderForm);   // all items available
		}
	}
}

function submitForm(form)
{
	form.submit()
}

</SCRIPT>

<!-- Submit this Form for option 2 -->
<form NAME=OrderSplitForm Method=post action="OrderItemMove">
<input type=hidden name="cmdStoreId" value="<%=nOrderStoreId%>">
<input type=hidden name="fromOrderId" value="<%=orderRn%>">
<input type=hidden name="fromOrderItemId" value="*ub">
<input type=hidden name="toOrderId" value="**">
<input type=hidden name="inOrderName" value="orderId">
<input type=hidden name="outOrderName" value="">
<input type=hidden name="inAllocate" value="*n">
<input type=hidden name="inBackorder" value="*n">
<input type=hidden name="inRemerge" value="*n">
<input type=hidden name="inMerge" value="*n">
<input type=hidden name="inReverse" value="*n">
<input type=hidden name="inCheck" value="*n">
<input type=hidden name="outAllocate" value="*n">
<input type=hidden name="outBackorder" value="*">
<input type=hidden name="outRemerge" value="*">
<input type=hidden name="outMerge" value="*n">
<input type=hidden name="outReverse" value="*n">
<input type=hidden name="outCheck" value="*n">
<input type=hidden name="URL" value="OrderPrepare?cmdStoreId=&merge=*n&remerge=*&check=*n&allocate=*aig&allocate=*ubg&backorder=*aig&backorder=*ubg&reverse=*n&URL=OrderDisplay">
<input type=hidden name="status" value="P">
<input type=hidden name="paymentMethod" value="<%=paymentMethod%>">
</form>

<form NAME=EntireOrderForm Method=post action="OrderPrepare">
<input type=hidden name="URL" value="OrderDisplay?&orderItemId*=&quantity*=">
<input type=hidden name="orderId" value="<%=orderRn%>">
<input type=hidden name="paymentMethod" value="<%=paymentMethod%>">
<input type=hidden name="status" value="P">
<input type=hidden name="merge" value="*n">
<input type=hidden name="remerge" value="*">
<input type=hidden name="check" value="*n">
<input type=hidden name="allocate" value="*aig">
<input type=hidden name="allocate" value="*ubg">
<input type=hidden name="backorder" value="*aig">
<input type=hidden name="backorder" value="*ubg">
<input type=hidden name="reverse" value="*n">
</form>



<form name="MainForm">
<table width="622" border="0" cellspacing="0" cellpadding="0">

<% 

/* Print out a message if there is an item with an unknown or discontinued availability date.
Users must delete these items before proceeding */

if ((avail_unknown == true) || (discontinued == true)){
	
%>
<tr>
<td colspan="2" align="left" valign="top"><font color="red"><%=tooltechtext.getString("ProdAvail_Not_Backorderable")%></font><br><br></td>
</tr>
<%

} // end if
//-- *************  INVENTORY AVAILABLE **************** -->
//if all the orderitems are available, set the input parameter appropriately
if (bAllOrderItemsAvailable) {
%>
<input type=hidden name="isAllItemsAvailable" value="true">
   <tr valign="top"> 
    <td colspan="2" height="24"><%= tooltechtext.getString("ProdAvail_AllAvail") %><P>
      </td>
  </tr>

<% 
} // end if
//otherwise there is at least one item that is on backorder 
else 
{
	//if all the orderitems are on back order, set the input parameter appropriately
	if ((backorderable == true) && (bAllOrderItemsOnBackorder)) {
	%>
	<input type=hidden name="isAllItemsAvailable" value="true">
	
  	<tr valign="top"> 
    	  <td colspan="2" height="24"><B><%= tooltechtext.getString("ProdAvail_No_Avail_Items") %> (<%=latestAvailableDate %>).</B><P>
     	  </td>
	</tr>
	
	<% 
	} 
	/* if there is at least one backorderable item and one non-backorderable item,
	 then display the options*/
	if ((backorderable == true) && (bAllOrderItemsOnBackorder == false))
	{
	%>
	<input type=hidden name="isAllItemsAvailable" value="false">
<tr valign="top"> <td colspan ="2"><b><%= tooltechtext.getString("ProdAvail_Text1") %> </b><br></td></tr>
 
  
  <tr valign="top"> 
    	 <td colspan="2" height="24"><%= tooltechtext.getString("ProdAvail_Text2") %><P>
     	 </td>
  </tr>	
  <tr> 
    <td width="31" valign="top" height="25"> 
        <input type="radio" name="orderOption" value="1" checked="checked" id="WC_ProductAvailabilityDisplay_FormInput_orderOption_1_1">
    </td>
    <td width="591" valign="top" height="25"><label for="WC_ProductAvailabilityDisplay_FormInput_orderOption_1_1"><%= tooltechtext.getString("ProdAvail_Option1") %> (<%=latestAvailableDate %>).</label></td>
  </tr>
  <tr> 
    <td width="31" valign="top"> 
        <input type="radio" name="orderOption" value="2" id="WC_ProductAvailabilityDisplay_FormInput_orderOption_1_2">
    </td>
    <td width="591" valign="top"> 
      <p><label for="WC_ProductAvailabilityDisplay_FormInput_orderOption_1_2"><%= tooltechtext.getString("ProdAvail_Option2") %> (<%=latestAvailableDate %>)</label></p>
      </td>
  </tr>
<%
   } // end if
} // end else
%>
</table>
									<br>
									<table border="0" cellspacing="5" cellpadding="0" height="0">
										<tr>
											<td valign="top">
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
																<a href="BillingShippingView?orderId=<%=orderRn%>&paymentMethod=<%=java.net.URLEncoder.encode(paymentMethod)%>" style="color:#ffffff; text-decoration : none;">
																<%// Would like to add these params eventually somehow: check=*n&merge=*n&remerge=*&allocate=*n&backorder=*n&reverse=*& %>
																&lt; <%= tooltechtext.getString("ProdAvail_Previous") %>
																</a>
																</b></font>
															</td>
														</tr>
														</table>
													</td>
													<td bgcolor="#7a1616"><img alt="" src="<%=fileDir%>images/db.gif" border="0"/></td>
												</tr>	
												<tr>
													<td class="pixel"><img src="<%=fileDir%>images/l_bot.gif" alt=""/></td>
													<td bgcolor="#7a1616" class="pixel" valign="top"><img src="<%=fileDir%>images/db.gif" border="0" alt=""/></td>
													<td bgcolor="#7a1616" class="pixel" valign="top"><img src="<%=fileDir%>images/db.gif" border="0" alt=""/></td>
												</tr>
												</table>
											</td>
											<%if ((avail_unknown == false) && (discontinued == false)){   // Hide the next button if non-backorderable items remain in the shopcart.%>
											<td valign="top">
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
																<a href="#" onClick="GoToOrderSummary(document.MainForm); return false;" style="color:#ffffff; text-decoration : none;">
																<%= tooltechtext.getString("ProdAvail_Next") %> &gt;
																</a>
																</b></font>
															</td>
														</tr>
														</table>
													</td>
													<td bgcolor="#7a1616"><img alt="" src="<%=fileDir%>images/db.gif" border="0"/></td>
												</tr>	
												<tr>
													<td class="pixel"><img src="<%=fileDir%>images/l_bot.gif" alt=""/></td>
													<td bgcolor="#7a1616" class="pixel" valign="top"><img src="<%=fileDir%>images/db.gif" border="0" alt=""/></td>
													<td bgcolor="#7a1616" class="pixel" valign="top"><img src="<%=fileDir%>images/db.gif" border="0" alt=""/></td>
												</tr>
												</table>											
											</TD>
											<%}%>	
										</TR>
									</table>
								</form>
							</td>
</tr>
</TABLE>
<!--content end--> 

	</TD>
</TR>
</TABLE>

</BODY>
<% }catch (Exception e){
		System.out.println("Error:  "+ e);
		e.printStackTrace();
}
%>
</HTML>
