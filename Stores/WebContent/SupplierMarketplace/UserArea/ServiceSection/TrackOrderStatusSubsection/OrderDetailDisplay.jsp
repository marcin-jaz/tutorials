<%
//********************************************************************
//*-------------------------------------------------------------------
//* Licensed Materials - Property of IBM
//*
//* WebSphere Commerce
//*tooltechtext
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
<%@ page import="java.sql.Timestamp" %>
<%@ page import="com.ibm.commerce.user.beans.AddressDataBean" %>
<%@ page import="com.ibm.commerce.order.beans.OrderDataBean" %>
<%@ page import="com.ibm.commerce.order.beans.OrderItemDataBean" %>
<%@ page import="com.ibm.commerce.catalog.objects.CatalogEntryAccessBean" %>
<%@ page import="com.ibm.commerce.catalog.beans.ItemDataBean" %>
<%@ page import="com.ibm.commerce.catalog.beans.AttributeDataBean" %>
<%@ page import="com.ibm.commerce.catalog.beans.AttributeValueDataBean" %>
<%@ page import="com.ibm.commerce.utils.TimestampHelper" %>
<%@ page import="com.ibm.commerce.fulfillment.beans.ShippingModeDescriptionDataBean" %>
<%@ page import="com.ibm.commerce.price.beans.FormattedMonetaryAmountDataBean" %>
<%@ page import="com.ibm.commerce.price.beans.CategorizedMonetaryAmountsDataBean" %>
<%@ page import="java.math.BigDecimal" %>

<%@ include file="../../../include/EnvironmentSetup.jspf"%>

<%
// JSPHelper provides you with a easy way to retrieve 
//		URL parameters when they are encrypted
JSPHelper jhelper = new JSPHelper(request);

String storeId = jhelper.getParameter("storeId");
String catalogId = jhelper.getParameter("catalogId");
String languageId = jhelper.getParameter("langId");
String orderId = jhelper.getParameter("orderId");
String orderStatusCode = jhelper.getParameter("orderStatusCode");

CommandContext commandContext = (CommandContext) request.getAttribute(ECConstants.EC_COMMANDCONTEXT);

%>

<HTML>
<HEAD>
	<TITLE><%= tooltechtext.getString("Details_Title") %></TITLE>
	<LINK REL=stylesheet HREF="<%=fileDir%>ToolTech.css" TYPE="text/css">
</HEAD>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "DTD/xhtml1-transitional.dtd">

<BODY MARGINHEIGHT="0" MARGINWIDTH="0" LEFTMARGIN="0" TOPMARGIN="0" onLoad="if (typeof top.updateStInfo == 'function') top.updateStInfo();">
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

<TD valign="top" width="605">

<!-- Insert JSP Content Here -->

<jsp:useBean id="dbOrder" class="com.ibm.commerce.order.beans.OrderDataBean" scope="page">
</jsp:useBean>

<%
//Find all the orderItems from order

if (orderId!=null){
	dbOrder.setOrderId(orderId);
}
com.ibm.commerce.beans.DataBeanManager.activate(dbOrder, request);

String billaddress_id = dbOrder.getAddressId();

OrderItemDataBean[] dbOrderItem = dbOrder.getOrderItemDataBeans();
int dbOrderItemlength = dbOrderItem.length;

Vector shippingAddrIdList = new Vector();  //store all shipping address ID


Timestamp estShipDate = null;
String formattedEstShipDate = "";

// Get locale for formatting the date appropriately
Locale jLocale 	= cmdcontext.getLocale();

if (orderStatusCode!=null)  {
	if (orderStatusCode.equals("S"))  {
		estShipDate = dbOrder.getActualShipDate();
		if (estShipDate != null){
			// Format date appropriately from the TimeStampHelper. Allows date to be universal.
		    	formattedEstShipDate = TimestampHelper.getDateFromTimestamp(estShipDate, jLocale);
		}
	}else {
		estShipDate = dbOrder.getEstimatedShipDate();
		if (estShipDate != null){
			formattedEstShipDate = TimestampHelper.getDateFromTimestamp(estShipDate, jLocale);
		}
	}
}


%>
<!--content start--> 

<TABLE CELLPADDING="8" CELLSPACING="0" BORDER="0">
	<TR>
		<TD>
		<H1><%= tooltechtext.getString("Details_Title") %></H1>
		<B>
		<%
		
		if (orderStatusCode!=null)  {
			if (orderStatusCode.equals("S"))  {
		%>
				<%= tooltechtext.getString("Details_Actual_Ship_Date")%>
		<%
			} else { 
		%>
				<%= tooltechtext.getString("Details_Text1")%> 
		<% 	}
		%>
			<%=formattedEstShipDate%><P>
		<%
		}%>
		</B>
		
		
			<TABLE CELLPADDING="0" CELLSPACING="0" BORDER="0" width="605" bgcolor="#4C6178">
				<TR>
					<TD>
						<TABLE WIDTH="100%" BORDER="0" CELLPADDING="2" CELLSPACING="1">
							<TR bgcolor="#4C6178">
								<TD VALIGN="TOP">
									<TABLE CELLPADDING="0" CELLSPACING="0" BORDER="0">
										<TR>
											<TD VALIGN="TOP"><font face="Verdana,Arial" color="#FFFFFF"><strong><%= tooltechtext.getString("Details_Col1")%></strong></font></TD>
										</TR>
									</TABLE>
								</TD>
								<TD VALIGN="TOP">
									<TABLE CELLPADDING="0" CELLSPACING="0" BORDER="0">
										<TR>
										<TD VALIGN="TOP"><font face="Verdana,Arial" color="#FFFFFF"><strong><%= tooltechtext.getString("Details_Col2")%></strong></font></TD>
										</TR>
									</TABLE>
								</TD>
								<TD VALIGN="TOP">
									<TABLE CELLPADDING="0" CELLSPACING="0" BORDER="0">
										<TR>
											<TD VALIGN="TOP"><font face="Verdana,Arial" color="#FFFFFF"><strong><%= tooltechtext.getString("Details_Col3")%></strong></font></TD>
										</TR>
									</TABLE>
								</TD>
								<td  VALIGN="TOP">
									<TABLE CELLPADDING="0" CELLSPACING="0" BORDER="0">
										<TR>
											<TD><font face="Verdana,Arial" color="#FFFFFF"><strong><%= tooltechtext.getString("Details_Col4")%></strong></font></TD>
										</TR>
									</TABLE>
								</TD>
								<TD VALIGN="TOP">
									<TABLE CELLPADDING="0" CELLSPACING="0" BORDER="0">
										<TR>
											<TD VALIGN="TOP"><font face="Verdana,Arial" color="#FFFFFF"><strong><%= tooltechtext.getString("Details_Col5")%></strong></font></TD>
										</TR>
									</TABLE>
								</TD>
								<TD VALIGN="TOP">
									<TABLE CELLPADDING="0" CELLSPACING="0" BORDER="0">
										<TR>
											<TD VALIGN="TOP"><font face="Verdana,Arial" color="#FFFFFF"><strong><%= tooltechtext.getString("Details_Col6")%></strong></font></TD>
										</TR>
									</TABLE>
								</TD>
								<TD VALIGN="TOP">
									<TABLE CELLPADDING="0" CELLSPACING="0" BORDER="0">
										<TR>
											<TD VALIGN="TOP"><font face="Verdana,Arial" color="#FFFFFF"><strong><%= tooltechtext.getString("Details_Col7")%></strong></font></TD>
										</TR>
									</TABLE>
								</TD>

								<TD VALIGN="TOP">
									<TABLE CELLPADDING="0" CELLSPACING="0" BORDER="0">
										<TR>
											<TD align="right"><font face="Verdana,Arial" color="#FFFFFF"><strong><%= tooltechtext.getString("Details_Col9")%></strong></font></TD>
										</TR>
									</TABLE>
								</TD>
								<TD VALIGN="TOP">
									<TABLE CELLPADDING="0" CELLSPACING="0" BORDER="0">
										<TR>
											<TD align="right"><font face="Verdana,Arial" color="#FFFFFF"><strong><%= tooltechtext.getString("Details_Col10")%></strong></font></TD>
										</TR>
									</TABLE>
								</TD>
							</TR>
							<%
							
							int diffColour = 0;
							for (int i=0; i < dbOrderItemlength; i++) {
								String strShipAddress_id = dbOrderItem[i].getAddressId();
								
								//Get AddressDataBean
								AddressDataBean bnAddress = new AddressDataBean();
								bnAddress.setAddressId(strShipAddress_id);								
							 	DataBeanManager.activate(bnAddress, request);
							 	
							 	if (!shippingAddrIdList.contains(strShipAddress_id))
	   								shippingAddrIdList.addElement(strShipAddress_id);

								// Get shipping method
								
								String shipmodeId = dbOrderItem[i].getShippingModeId().trim();
								String shippingMethodName =null;
								ShippingModeDescriptionDataBean shipmodeDsc = new ShippingModeDescriptionDataBean();
							
								shipmodeDsc.setInitKey_shipModeId(shipmodeId);
								shipmodeDsc.setInitKey_languageId(languageId);
								//shippingMethodName = shipmodeDsc.getDescription();
								
								FormattedMonetaryAmountDataBean dbFormattedMonetaryAmount = new FormattedMonetaryAmountDataBean();
								dbFormattedMonetaryAmount.setAmount ( new BigDecimal(dbOrderItem[i].getPrice()));
								DataBeanManager.activate(dbFormattedMonetaryAmount, request);
								
								if (diffColour == 0) {
								%>
								  <TR bgcolor="#ffffff">
								<% 	diffColour++;
								} 
								else {
									diffColour--;
								%>
								  <TR bgcolor="#BCCBDB">
								<% }

								%>
							
									<td valign="top"><%= dbOrderItem[i].getQuantityInEJBType().intValue() %></TD>
									<TD valign="top"><%= dbOrderItem[i].getCatalogEntry().getPartNumber() %></TD>
									<TD valign="top">
										<%= dbOrderItem[i].getCatalogEntry().getDescription(cmdcontext.getLanguageId()).getShortDescription() %>
										<br>
										<%
										CatalogEntryAccessBean abCatEntry;
										abCatEntry = dbOrderItem[i].getCatalogEntry();

										//If the catentry is an item, we get all the attributes and attribute values for the item using AttributeValueDataBean and AttributeDataBean
										ItemDataBean item = new ItemDataBean(abCatEntry);
										AttributeValueDataBean attrvalue[];
										attrvalue = item.getAttributeValueDataBeans(new Integer(languageId));
										AttributeDataBean attribute[] = new AttributeDataBean[attrvalue.length];
										for (int x=0; x<attrvalue.length; x++) {
											attribute[x] = attrvalue[x].getAttributeDataBean();
											%>
											<font style="font-family : Verdana,Ariel;"><strong><%=attribute[x].getName()%>: </strong>
											<%=attrvalue[x].getValue()%></font><br>
											<%
										}
										%>
									</TD>
									<TD valign="top"><%= dbOrderItem[i].getCatalogEntry().getManufacturerName()%></TD>
									<TD valign="top"><%= dbOrderItem[i].getCatalogEntry().getManufacturerPartNumber()%></TD>
<% if (locale.toString().equals("ja_JP")||locale.toString().equals("ko_KR")||locale.toString().equals("zh_CN")) { %>
									<TD valign="top"><%= bnAddress.getLastName() %>&nbsp;<%= bnAddress.getFirstName() %></TD>
<% } else if (locale.toString().equals("zh_TW")){ %>
									<TD valign="top"><%= bnAddress.getLastName() %><%= bnAddress.getFirstName() %></TD>
<% } else { %>
									<TD valign="top"><%= bnAddress.getFirstName() %>&nbsp;<%= bnAddress.getLastName() %></TD>
<% } %>
									<TD valign="top"><%= dbOrderItem[i].getShippingMode().getCarrier() %> </TD>
									<TD valign="top" align="right"><font class="price"><%= dbOrderItem[i].getPriceDataBean() %></font></TD>
									<TD valign="top" align="right"><font class="price"><%= dbOrderItem[i].getFormattedTotalProduct() %></font></TD>
								
								  </TR>
							<%
							}  //end for
							
							%>
							<TR bgcolor="#ffffff">
								<td valign="top" align="right" COLSPAN="8"><%= tooltechtext.getString("Details_Text2")%></TD>
								<TD valign="top" align="right"><font class="price"><%= dbOrder.getFormattedTotalProductPrice()%></font></TD>
							</TR>
							<%
							//Get taxes, e.g.: GST, PST
							/*
							CategorizedMonetaryAmountsDataBean categorizedMonetaryAmountsDataBean = dbOrder.getTaxes();
							if (categorizedMonetaryAmountsDataBean != null) {
								Hashtable hashName = categorizedMonetaryAmountsDataBean.getCategorizedAmountsAndNames();
								Hashtable hashAmount = categorizedMonetaryAmountsDataBean.getCategorizedAmountsDBAndNames();
								Hashtable hashDescription = categorizedMonetaryAmountsDataBean.getCategorizedDescriptionsAndNames();
								Enumeration e1 = hashName.keys() ;
								while (e1.hasMoreElements()) {
									Object key = e1.nextElement();
									if (hashDescription.get(key) != null 
									&& !hashDescription.get(key).toString().trim().equals("")
									&& ((MonetaryAmountDataBean) hashAmount.get(key)).getPrimaryPrice().getValue().doubleValue() >= 0.01)
									{ */
							%>
							
							<!-- <TR bgcolor="#ffffff">
								<td valign="top" align="right" COLSPAN="9"> <%--  =hashDescription.get(key) --%>:</TD> 
								<TD valign="top" align="right"> <%--  =hashAmount.get(key) --%>  </TD>
							</TR> -->							
							<%/*
									} 
								} //end while
							}*/
							%>

							<%
							// Display Total Tax
							if (dbOrder.getTotalTaxInEJBType().doubleValue() >= 0.01)
							{
							%>							
							<TR bgcolor="#ffffff">
								<td valign="top" align="right" COLSPAN="8"><%= tooltechtext.getString("Details_Text5")%></TD>
								<TD valign="top" align="right"><font class="price"><%= dbOrder.getFormattedTotalTax() %></font></TD>
							</TR>
							<%
							} %>
							
							<%
							//Display Shipping Charge
							if (dbOrder.getTotalShippingChargeInEJBType().doubleValue() >= 0.01)
							{
							%>
							<TR bgcolor="#ffffff">
								<td valign="top" align="right" COLSPAN="8"><%= tooltechtext.getString("Details_Text6")%></TD>
								<TD valign="top" align="right"><font class="price"><%= dbOrder.getFormattedTotalShippingCharge() %></font></TD>
							</TR>
							<%
							} %>
							
							<%
							//Display Shipping Tax
							if (dbOrder.getTotalShippingTaxInEJBType().doubleValue() >= 0.01)
							{
							%>
							<TR bgcolor="#ffffff">
								<td valign="top" align="right" COLSPAN="8"><%= tooltechtext.getString("Details_Text7")%></TD>
								<TD valign="top" align="right"><font class="price"><%= dbOrder.getFormattedTotalShippingTax() %></font></TD>
							</TR>
							<%
							} %>
							
							<%
							//Display discount amount.
							if (dbOrder.getTotalAdjustmentInEJBType().doubleValue() <= -0.01)
							{
							%>
							<TR bgcolor="#ffffff">
								<td valign="top" align="right" COLSPAN="8"><%= tooltechtext.getString("Details_Text8")%></TD>
								<TD valign="top" align="right"><font class="price">
									<%=dbOrder.getFormattedTotalAdjustment()%>;</font>						
								</TD>
							</TR>
							<%
							} %>
							<TR bgcolor="#ffffff">
								<td valign="top" align="right" COLSPAN="8"><%= tooltechtext.getString("Details_Text9")%></TD>
								<TD valign="top" align="right"><font class="price"><%=dbOrder.getGrandTotal()%></font></TD>
							</TR>
						</TABLE>
					</TD>
				</TR>
			</TABLE>
			
			
			<P>
			<B><%= tooltechtext.getString("Details_Shipadd")%></B><P>
			<%= tooltechtext.getString("Details_Text10")%><P>

			<TABLE WIDTH="100%" BORDER="0" CELLPADDING="0" CELLSPACING="0">

<% 
String shipId = "";
String strNickName = "";
String strFirstName = "";
String strLastName = "";
String strAddrLn1 = "";
String strAddrLn2 = "";
String strCity = "";
String strState = "";
String strZipCode ="";
String strCountry = "";
String strDayPhone = "";

for (int i=0; i < shippingAddrIdList.size(); i++) { 
	shipId = (String)(shippingAddrIdList.elementAt(i));
	if (shipId !=null || shipId.trim().length() != 0) {
		AddressDataBean bnAddressDisplay = new AddressDataBean();
		bnAddressDisplay.setAddressId(shipId);
		DataBeanManager.activate(bnAddressDisplay, request);

		strNickName = bnAddressDisplay.getNickName();
		strLastName = bnAddressDisplay.getLastName();
		strFirstName = bnAddressDisplay.getFirstName();
		strAddrLn1 = bnAddressDisplay.getAddress1();
		strAddrLn2 = bnAddressDisplay.getAddress2();
		strCity = bnAddressDisplay.getCity();
		strState = bnAddressDisplay.getStateProvDisplayName();
		strZipCode = bnAddressDisplay.getZipCode();
		strCountry = bnAddressDisplay.getCountryDisplayName();
		strDayPhone = bnAddressDisplay.getPhone1();
		if (strFirstName == null) strFirstName = "";
		if (strAddrLn2 == null) strAddrLn2 = "";
		if (strState == null) strState = "";
		if (strDayPhone == null) strDayPhone = "";
	} //end if
%>
				<TR>
					<TD BGCOLOR="white"><B><%= tooltechtext.getString("Details_Add")%> <%= i+1 %> </B><BR>
							
							<% if (locale.toString().equals("ja_JP")||locale.toString().equals("ko_KR")||locale.toString().equals("zh_CN")) { %>
							<%=strLastName%>&nbsp;<%=strFirstName%><br>
							<%=strCountry%>&nbsp;<%=strZipCode%><br>
							<%=strState%><%=strCity%><br>
							<%=strAddrLn1%><br>
							<% if (!strAddrLn2.trim().equals("")) {
								out.print (strAddrLn2); %><br>
								<% } %>
							<% } else if (locale.toString().equals("zh_TW")) { %>
							<%=strLastName%><%=strFirstName%><br>
							<%=strCountry%>&nbsp;<%=strZipCode%><br>
							<%=strState%><%=strCity%><br>
							<%=strAddrLn1%><br>
							<% if (!strAddrLn2.trim().equals("")) {
								out.print (strAddrLn2); %><br>
								<% } %>
							<% } else if (locale.toString().equals("fr_FR")||locale.toString().equals("de_DE")){ %>
							<%=strFirstName%>&nbsp;<%=strLastName%><br>
							<%=strAddrLn1%><br>
							<% 	if (!strAddrLn2.trim().equals("")) {
									out.print (strAddrLn2); %><br>
								<%}%>
							<%=strZipCode%>&nbsp;<%=strCity%><br>
							<% if (locale.toString().equals("de_DE")) { %>
							<%=strState%><BR>
							<% } %>
							<%=strCountry%><br>
							<% } else { %>
							<%=strFirstName%>&nbsp;<%=strLastName%><br>
							<%=strAddrLn1%><br>
							<% if (!strAddrLn2.trim().equals("")) {
								out.print (strAddrLn2);%><br>
								<% } %>
							<%=strCity%>&nbsp;<%=strState%>&nbsp;<%=strZipCode%><br>
							<%=strCountry%><br>
							<% } %>
					</TD>
				</TR>
				<TR>
					<TD>&nbsp;</TD>
				</TR>
<% } //end for
%>


			</TABLE>
			<%
			if (billaddress_id !=null && billaddress_id.trim().length() != 0) 
			{
			%>
			<P>
			<B><%= tooltechtext.getString("Details_Billadd")%></B><P>
			<TABLE WIDTH="100%" BORDER="0" CELLPADDING="5" CELLSPACING="1">
			<TR>
			    	<TD>        					
				        	<jsp:useBean id="billingAddressDisplay" class="com.ibm.commerce.user.beans.AddressDataBean" scope="page">
				        	<%
				        	billingAddressDisplay.setAddressId(billaddress_id);
				        	com.ibm.commerce.beans.DataBeanManager.activate(billingAddressDisplay, request);
				        	%>
				        	</jsp:useBean>
        
				        	<%
			        		strNickName = billingAddressDisplay.getNickName();
			        		strLastName = billingAddressDisplay.getLastName();
			        		strFirstName = billingAddressDisplay.getFirstName();
				        	strAddrLn1 = billingAddressDisplay.getAddress1();
			        		strAddrLn2 = billingAddressDisplay.getAddress2();
			        		strCity = billingAddressDisplay.getCity();
			        		strState = billingAddressDisplay.getStateProvDisplayName();
			        		strZipCode = billingAddressDisplay.getZipCode();
			        		strCountry = billingAddressDisplay.getCountryDisplayName();
			        		strDayPhone = billingAddressDisplay.getPhone1();
									%>
									<p>
									<% 
									if (locale.toString().equals("ja_JP")||locale.toString().equals("ko_KR")||locale.toString().equals("zh_CN")) 
									{ 
										%>
									        <%=strLastName%>&nbsp;<%=strFirstName%><br>
										<%=strCountry%>&nbsp;<%=strZipCode%><br>
										<%=strState%><%=strCity%><br>
										<%=strAddrLn1%><br>
										<% if (!strAddrLn2.trim().equals("")) {
											out.print(strAddrLn2);%><br>
											<% } %>
										<% } else if (locale.toString().equals("zh_TW")) { %>
										<%=strLastName%><%=strFirstName%><br>
										<%=strCountry%>&nbsp;<%=strZipCode%><br>
										<%=strState%><%=strCity%><br>
										<%=strAddrLn1%><br>
										<% if (!strAddrLn2.trim().equals("")) {
											out.print(strAddrLn2);%><br>
											<% } %>
										<% } else if (locale.toString().equals("fr_FR")||locale.toString().equals("de_DE")){ %>
										<%=strFirstName%>&nbsp;<%=strLastName%><br>
										<%=strAddrLn1%><br>
										<%if (!strAddrLn2.trim().equals("")){ 
											out.print(strAddrLn2);%><br>
											<% }%>
										<%=strZipCode%>&nbsp;<%=strCity%><br>
										<% if (locale.toString().equals("de_DE")) { %>
										<%=strState%><BR>
										<% } %>
										<%=strCountry%><br>
									<% 
									} else 
									{ 
										%>
										<%=strFirstName%>&nbsp;<%=strLastName%><br>
										<%=strAddrLn1%><br>
										<%if (!strAddrLn2.trim().equals("")){ 
											out.print(strAddrLn2);%><br>
											<% }%>
										<%=strCity%>&nbsp;<%=strState%>&nbsp;<%=strZipCode%><br>
										<%=strCountry%><br>
										<% 
									}
									%>
					</TD>
				</TR>
			</TABLE>
			<%
			}	
			%>
		</TD>
	</TR>
</TABLE>

<!--content end--> 
 </TD>
 </TR>
 </TABLE>
</BODY>
</HTML>
