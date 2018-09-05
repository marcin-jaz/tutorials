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
<%@ page import="com.ibm.commerce.price.beans.FormattedMonetaryAmountDataBean" %>
<%@ page import="com.ibm.commerce.price.beans.PriceDataBean" %>
<%@ page import="com.ibm.commerce.contract.beans.ContractDataBean" %>
<%@ page import="com.ibm.commerce.datatype.TypedProperty" %>
<%@ page import="com.ibm.commerce.catalog.beans.ItemDataBean" %>
<%@ page import="com.ibm.commerce.catalog.beans.CatalogEntryDataBean" %>
<%@ page import="com.ibm.commerce.catalog.beans.AttributeDataBean" %>
<%@ page import="com.ibm.commerce.catalog.beans.AttributeValueDataBean" %>
<%@ page import="com.ibm.commerce.order.beans.OrderDataBean" %>
<%@ page import="com.ibm.commerce.order.beans.OrderItemDataBean" %>
<%@ page import="com.ibm.commerce.order.beans.OrderListDataBean" %>
<%@ page import="com.ibm.commerce.order.objects.OrderAccessBean" %>
<%@ page import="com.ibm.commerce.user.beans.UserRegistrationDataBean" %> 

<%@ include file="../../include/EnvironmentSetup.jspf"%>

<jsp:useBean id="bnError" class="com.ibm.commerce.beans.ErrorDataBean" scope="page">
<% com.ibm.commerce.beans.DataBeanManager.activate(bnError, request); %>
</jsp:useBean>

<%
try {
// JSPHelper provides you with a easy way to retrieve URL parameters when they are encrypted.
// JSPHelper Comes from Package com.ibm.commerce.server.*

	TypedProperty tpRequest = (TypedProperty)request.getAttribute(ECConstants.EC_REQUESTPROPERTIES);
	String[] sOrderIdArray = tpRequest.getArray("orderId", null);

	JSPHelper jhelper = new JSPHelper(request);

	String store_Id = (cmdcontext.getStoreId()).toString();
	String languageId = jhelper.getParameter("langId");
String orderStoreId = ((TypedProperty)request.getAttribute(ECConstants.EC_REQUESTPROPERTIES)).getString("orderStoreId",null);

	int liveHelpShoppingCartItems = 0;  //Order Items count for LiveHelp.  Cannot be put into flow tags or else page won't compile.
%>

<% String strNoWrap = (locale.toString().equals("ja_JP")||locale.toString().equals("ko_KR")||locale.toString().equals("zh_CN")||locale.toString().equals("zh_TW") ? " nowrap" : ""); %>

<%

	// show Logon page if user is not registered or not approved
	UserRegistrationDataBean bnRegUser = new UserRegistrationDataBean();
	com.ibm.commerce.beans.DataBeanManager.activate(bnRegUser, request);
	String userState = cmdcontext.getUser().getState();
	String errorString = "";
	if (!userState.equals("1"))  // if user is not approved
	{
		errorString = "AUTHORIZATION_ERROR2";
		if (!bnRegUser.findUser()) // if user is a guest
			errorString = "AUTHORIZATION_ERROR1";
%>
<jsp:forward page="/servlet/LogonForm">
	<jsp:param name="storeId" value="<%=store_Id%>"/>
	<jsp:param name="langId" value="<%=languageId%>"/>
	<jsp:param name="errorMessage" value="<%=errorString%>"/>
</jsp:forward>
<%
	}
	
	String EmptyOrderFile = null;
	
	Vector orders = null;
	OrderDataBean orderBean= null;
	boolean bHasShopCart = false;
	
	if (sOrderIdArray == null || sOrderIdArray.length == 0) {
		//find the pending orders for this buyer and see if the Order is empty
		OrderListDataBean orderListBean = new OrderListDataBean();
		if (orderStoreId != null && !orderStoreId.equals("")) {
			orderListBean.setStoreId(new Integer(orderStoreId));
		}
		orderListBean.setOrderStatus("P");
		orderListBean.setUserId(cmdcontext.getUserId());
		com.ibm.commerce.beans.DataBeanManager.activate(orderListBean, request);
			
		orders = orderListBean.getOrders();
	} else {
		orders = new Vector();
		// construct orders from input orderId
		for (int counter = 0; counter<sOrderIdArray.length; counter++) {
			OrderDataBean orderDB = new OrderDataBean();
			orderDB.setOrderId(sOrderIdArray[counter]);   
			DataBeanManager.activate(orderDB, request);
			orders.addElement(orderDB);
		}
	}


	OrderAccessBean next_order;	
	String orderRefNum = null;
	OrderItemDataBean [] orderItems = null;
	
	for (int k=0; k<orders.size(); k++) { // check each order to see if empty	
	
		orderBean = new OrderDataBean();
		next_order =(OrderAccessBean) orders.elementAt(k);
		orderRefNum = next_order.getOrderId();
	
		System.out.println("orderId=" + orderRefNum);
	
		if (orderRefNum != null) 
		{
			orderBean.setOrderId(orderRefNum);
			com.ibm.commerce.beans.DataBeanManager.activate(orderBean, request);
			orderItems = orderBean.getOrderItemDataBeans();
			if (orderItems.length > 0)
				bHasShopCart = true;
		}
	}

	if (!bHasShopCart) {
		EmptyOrderFile = storeDir + "ShoppingArea/CurrentOrderSection/EmptyOrderDisplay.jsp";
%>
		<jsp:include page="<%=EmptyOrderFile%>" flush="true"/>
<%
	} else {

		/* 
		   If there is more than 1 order, OrderItemMove is called to move all the orders into one order. 
		   OrderItemMove uses the deleteIfEmpty parameter to delete all the empty orders left over after the move. 
		   Here, we use inRemerge/outRemerge=* to remerge previously split order items together and 
		   use inReverse/outReverse=* to de-allocate the order items.
		*/
	// XXXX@conan   stopped the move.		
		if (orders.size()>1 && false)
		{
%>
		<jsp:forward page="/servlet/OrderItemMove">
			<jsp:param name="deleteIfEmpty" value="*"/>
			<jsp:param name="fromOrderId" value="*"/>
			<jsp:param name="toOrderId" value="."/>
			<jsp:param name="inAllocate" value="*n"/>
			<jsp:param name="inBackorder" value="*n"/>
			<jsp:param name="inRemerge" value="*"/>
			<jsp:param name="inMerge" value="*n"/>
			<jsp:param name="inReverse" value="*"/>
			<jsp:param name="outAllocate" value="*n"/>
			<jsp:param name="outBackorder" value="*n"/>
			<jsp:param name="outRemerge" value="*"/>
			<jsp:param name="outMerge" value="*n"/>
			<jsp:param name="outReverse" value="*"/>
			<jsp:param name="URL" value="OrderItemDisplay?orderId=.&orderItemId*=&quantity*="/>	
		</jsp:forward>
<%
		} 
		/* Otherwise if there is just one order, go directly to the shopping cart */
		else {

		
			
			OrderItemDataBean orderItem = null;
			
			String strErrorMessageKey = "";
			String strErrorCode = "";
			String strErrorMessage = null;
			TypedProperty hshErrorProperties = bnError.getExceptionData();
			strErrorMessageKey = bnError.getMessageKey().trim();

			// If there is an error indicating that the orderitems within the order fail to share a common payment method within its contracts
			if (hshErrorProperties != null && strErrorMessageKey.equals("_ERR_TRADINGS_INCOMPATIBLE_ACCOUNT_PAYMENT"))
			{
				strErrorMessage = tooltechtext.getString("YourOrder_Err_Incompatible_contract_general");
			}
			
			// If there is an error indicating that the input was invalid
			if (hshErrorProperties != null && strErrorMessageKey.equals("_ERR_INVALID_INPUT"))
			{
				strErrorMessage = tooltechtext.getString("YourOrder_Quantity_Input_Error");
			}

%>

<html>
<HEAD>
	<TITLE><%=tooltechtext.getString("YourOrder_Title") %></TITLE>
	<LINK REL=stylesheet HREF="<%=fileDir%>ToolTech.css" TYPE="text/css">
</HEAD>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "DTD/xhtml1-transitional.dtd">

<script language="javascript">

	function checkContractId(object) {
    	   
    	   	var contraceId;
    	   	
    		for (var i = 0;i < object.length;i++)
		{
			if (object.options[i].selected == true) 
				return(object.options[i].value);
	    	}
	    	return "0";
	}
	<%
	/* 
	   The 'orderItemId*=&quantity*=&...' used in the URL value below prevents the parameters from being passed to 
	   the next redirection URL.  Without this, the parameter list would be too long and would be unable to 
	   handle orders that have too many orderitems.
	*/ 
	%>
	
	function updateForm(form)
	{
		form.URL.value = 'OrderItemDisplayViewShiptoAssoc?storeId=<%= store_Id %>&orderItemId*=&quantity*=&contract*=';
		form.submit();
	}

	function submitForm(form)
	{
		form.URL.value = 'BillingShippingView?orderItemId*=&quantity*=&contract*=&cmdStoreId=';
		form.submit();
	}

	function init(form){
		for(var i = 0; i < form.orderStoreId.length; i++){
			if(form.orderStoreId.options[i].value == '<%=orderStoreId%>'){
				form.orderStoreId.options[i].selected = true;
				break;
			}
		}
	}
</script>



<body marginheight="0" marginwidth="0" leftmargin="0" topmargin="0" onload="if (typeof top.updateStInfo == 'function') top.updateStInfo(); init(document.SelectSupplier);">
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
	<td VALIGN="top" BGCOLOR="#4c6178" WIDTH="160"> 

		<%
		incfile = includeDir + "SidebarDisplay.jsp";
		%>
		<jsp:include page="<%=incfile%>" flush="true"/>

	</td>

	<td valign="top" width="630">

	<!-- content start -->
		<TABLE CELLPADDING="8" CELLSPACING="0" BORDER="0">
			<tr>
				<td>
					<p><H1><%= tooltechtext.getString("YourOrder_Title") %></H1>


					<table cellpadding="2" cellspacing="2" border="0">
					<tr>	
						<td>
							<b><label for="WC_CurrentOrderDisplay_FormInput_orderStoreId_1"><%= tooltechtext.getString("SupplierDropDown_SelectSupplier") %></label></b>
						</td>
							<form name="SelectSupplier" action="OrderItemDisplayViewShiptoAssoc">
						<td>
								<input type="hidden" name="langId" value="<%= lang %>">
								<input type="hidden" name="storeId" value="<%= sessionStoreId %>">
								<select name="orderStoreId" id="WC_CurrentOrderDisplay_FormInput_orderStoreId_1">
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
								<td class="pixel"><img src="<%=jspStoreImgDir%>images/l_bot.gif" alt=""/></td>
								<td bgcolor="#7a1616" class="pixel" valign="top"><img src="<%=jspStoreImgDir%>images/db.gif" border="0" alt=""/></td>
								<td bgcolor="#7a1616" class="pixel" valign="top"><img src="<%=jspStoreImgDir%>images/db.gif" border="0" alt=""/></td>
							</tr>
							</table>
						</td>
					</tr>
					</table>

<%
					if (strErrorMessage != null)
					{
						//We have error message.
%>
						<p><font color="red"><%=strErrorMessage%></font><br><br></p>
<%
					}
%>
<%

	int counter = 0;
	int j = 0;
	FormattedMonetaryAmountDataBean formattedTotalPrice = null;
	FormattedMonetaryAmountDataBean formattedAmount = null; 
	// For each order 
	String orderRn = "";
	for (int i = 0; i < orders.size(); i++) {

		next_order = (OrderAccessBean) orders.elementAt(i);
		orderBean = new OrderDataBean();
		orderRn = next_order.getOrderId();
		orderBean.setOrderId(orderRn);
				
		com.ibm.commerce.beans.DataBeanManager.activate(orderBean, request);
		orderItems = orderBean.getOrderItemDataBeans();
%>
						<form name="ShopCartForm<%= orderRn %>" action="OrderItemUpdate" method="POST">
							<input type="hidden" name="check" value="*n">
							<input type="hidden" name="merge" value="*n">
							<input type="hidden" name="remerge" value="*n">
							<input type="hidden" name="reverse" value="*n">
							<input type="hidden" name="allocate" value="*n">
							<input type="hidden" name="backorder" value="*n">
							<input type="hidden" name="orderId" value="*">
							<input type="hidden" name="URL" value="BillingShippingView?cmdStoreId=">

<%					if (orders.size() == 1) { %>
							<table cellpadding="0" cellspacing="3" border="0" width="100%">
							<tr>
								<td align="right">
								
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
													<a href="javascript:updateForm(document.ShopCartForm<%= orderRn %>)"  style="color:#ffffff; text-decoration : none;">
													<%= tooltechtext.getString("YourOrder_UpdateThis") %>
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
<%					} %>
							<table width="100%" border="0" cellpadding="2" cellspacing="1" bgcolor="#4C6178">
								<tr bgcolor="#ffffff">
									<td colspan="8" align="left">
										<table width="100%" border="0">
										<tr>
											<td align="left">
											<strong>
											<%= tooltechtext.getString("YourOrder_OrderId") %> : <i><%= orderRn %></i>
											</strong>
											</td>
											<td align="right">
											<strong>
											<%= tooltechtext.getString("YourOrder_Store") %> : <i><%= orderBean.getStoreEntityId() %></i>
											</strong>
											</td>
										</tr>
										</table>
									</td>
								</tr>
								<tr bgcolor="#4C6178">
									<td<%= strNoWrap %>>
										<font style="font-family : Verdana;" color="#FFFFFF"><strong><%= tooltechtext.getString("YourOrder_Quantity") %></strong></font>
									</td>
									<td<%= strNoWrap %>>
										<font style="font-family : Verdana;" color="#FFFFFF"><strong><%= tooltechtext.getString("YourOrder_SKU") %></strong></font>
									</td>
									<td<%= strNoWrap %>>
										<font style="font-family : Verdana;" color="#FFFFFF"><strong><%= tooltechtext.getString("YourOrder_Name") %></strong></font>
									</td>
									<td<%= strNoWrap %>>
										<font style="font-family : Verdana;" color="#FFFFFF"><strong><%= tooltechtext.getString("YourOrder_Man") %></strong></font>
									</td>
									<td<%= strNoWrap %>>
										<font style="font-family : Verdana;" color="#FFFFFF"><strong><%= tooltechtext.getString("YourOrder_Part") %></strong></font>
									</td>
									<td<%= strNoWrap %>>
										<font style="font-family : Verdana;" color="#FFFFFF"><strong><%= tooltechtext.getString("Details_Col9") %></strong></font>
									</td>
									<td<%= strNoWrap %>>
										<font style="font-family : Verdana;" color="#FFFFFF"><strong><%= tooltechtext.getString("YourOrder_Total") %></strong></font>
									</td>
									<td>
									</td>
								</tr>
<%
		for (j = 0; ((orderItems != null) && (j < orderItems.length)); j++) {
			orderItem = orderItems[j];
			counter += 1;
%>
			<flow:ifEnabled feature="customerCare">
			<%
				liveHelpShoppingCartItems+= orderItem.getQuantityInEJBType().intValue();
			%>
			</flow:ifEnabled>
			

								<input type="hidden" name="orderItemId_<%=counter%>" value="<%=orderItem.getOrderItemId()%>" >
								<input type="hidden" name="cmdStoreId" value="<%=orderBean.getStoreEntityId()%>" >

								<tr bgcolor="<%if (j % 2 == 0) {%><%="#ffffff"%><%} else {%><%="#bccbdb"%><%}%>">
									<%
									int nQty = orderItem.getQuantityInEJBType().intValue();
									int nFldSize = Integer.toString(nQty).length();
									if(nFldSize < 2) { nFldSize = 2; }
									else if(nFldSize > 10) { nFldSize = 10; }
									%>
									<td align="center" rowspan="2"><label for="WC_CurrentOrderDisplay_FormInput_quantity_<%=counter%>_1"><img src="<%=fileDir%>images/trans.gif" height="1" width="1" border="0" alt="<%=tooltechtext.getString("YourOrder_Quantity")%>"/></label>
<input type="text" name="quantity_<%=counter%>" size="<%= nFldSize %>" value="<%= nQty %>" id="WC_CurrentOrderDisplay_FormInput_quantity_<%=counter%>_1" title="<%= tooltechtext.getString("YourOrder_Quantity") %>"></td>
									<td rowspan="2"><%=orderItem.getCatalogEntry().getPartNumber()%></td>
									<td rowspan="2">
										<a href="ProductDisplay?productId=<%=orderItem.getCatalogEntryId()%>"><%=orderItem.getCatalogEntry().getDescription(cmdcontext.getLanguageId()).getShortDescription()%></a><BR>
										<font style="font-family : Verdana;font-size : 8pt;" size="#32404F">
										<% // Loop through all the attributes and print them out                                                                              
		    
                                        // first check whether this item supports attributes
										com.ibm.commerce.catalog.beans.CatalogEntryDataBean catentry = new CatalogEntryDataBean();
										catentry.setCatalogEntryID(orderItem.getCatalogEntryId());
										com.ibm.commerce.beans.DataBeanManager.activate (catentry, request);
                                        if (catentry.getType().equals("ItemBean")) {
										    com.ibm.commerce.catalog.beans.ItemDataBean item = new ItemDataBean(catentry);
										    //item.setItemID(orderItem.getCatalogEntryId());
										    //com.ibm.commerce.beans.DataBeanManager.activate (item, request);
					
										    AttributeValueDataBean attrvalue[];
										    attrvalue = item.getAttributeValueDataBeans(new Integer(languageId));
										    AttributeDataBean attribute[] = new AttributeDataBean[attrvalue.length];
										    for (int x=0; x<attrvalue.length; x++)
										    {
											    attribute[x] = attrvalue[x].getAttributeDataBean();
										%>
										    	<strong><%=attribute[x].getName()%>:  </strong><%=attrvalue[x].getValue()%><BR>
										<%
										    }          
                                        } // if item bean
										%> 
										</font>
									</td>
									<td><%=orderItem.getCatalogEntry().getManufacturerName()%></td>
									<td><%=orderItem.getCatalogEntry().getManufacturerPartNumber()%></td>
									<td><FONT class="price"><%=orderItem.getPriceDataBean()%></FONT></td>
									<td align="right"><FONT class="price"><%=orderItem.getFormattedTotalProduct()%></FONT></td>
									<td<%= strNoWrap %>><A HREF="OrderItemDelete?cmdStoreId=<%=orderBean.getStoreEntityId()%>&orderItemId=<%=orderItem.getOrderItemId()%>&URL=OrderItemDisplayViewShiptoAssoc%3FcmdStoreId%3D"><%=tooltechtext.getString("YourOrder_Remove")%></A></td>
								</tr>
								<tr>
									<td bgcolor="<%if (j % 2 == 0) {%><%="#ffffff"%><%} else {%><%="#bccbdb"%><%}%>" colspan="5" align="right">
										<TABLE cellspacing="2">
										<tr>
											<td><strong><label for="WC_CurrentOrderDisplay_FormInput_contractId_<%=counter%>_1"><%= tooltechtext.getString("YourOrder_Contract") %></label></strong>
											</td>
											<td>&nbsp;</td>
											<td>
												<SELECT name="contractId_<%=counter%>" id="WC_CurrentOrderDisplay_FormInput_contractId_<%=counter%>_1">
												<% 
													// begin select contracts
													//String[] contractIds = cmdcontext.getEligibleTradingAgreementIds();
													
													String[] contractIds = com.ibm.commerce.contract.util.ContractCmdUtil.getEligibleTradingAgreements(
															new Long (bnRegUser.getUserId()),
															orderBean.getStoreEntityIdInEJBType(),
															com.ibm.commerce.contract.helper.ECContractConstants.EC_TRADING_TYPE_CONTRACT);
													
													for (int k=0; k < contractIds.length; k += 1)
													{
														ContractDataBean contractDataBean = new ContractDataBean();
														contractDataBean.setDataBeanKeyReferenceNumber(contractIds[k]);
														DataBeanManager.activate(contractDataBean, request);
														String sel = "";
														if (contractIds[k].equals(orderItem.getContractId())){
															sel = "selected";	
														}

												%>
															<OPTION value="<%=contractIds[k]%>" <%= sel %>><%=contractDataBean.getName()%></OPTION>
												<%
													} // end for
												%>
												</SELECT>
											</td>
											<td>&nbsp;</td>
										</tr>
										</TABLE>
									</td>
								</tr>

<%
		}  // end for j

//		if (i == 0) {
			formattedTotalPrice = orderBean.getFormattedTotalProductPrice();
//		} else {
			formattedAmount = orderBean.getFormattedTotalProductPrice(); 
			formattedTotalPrice.setAmount(formattedAmount.getAmount().add(formattedTotalPrice.getAmount()));
//		}
%>
								<tr bgcolor="<%if (j % 2 == 0) {%><%="#ffffff"%><%} else {%><%="#bccbdb"%><%}%>">
									<td colspan="6" align="right"><strong><%= tooltechtext.getString("YourOrder_Sub") %></strong></td>
									<td align="right"><strong><FONT class="price"><%= formattedTotalPrice %></FONT></strong></td>
									<td>&nbsp;</td>
								</tr>
							</table>
							
							
							<table cellpadding="0" cellspacing="3" border="0" width="100%">
								<tr>
					<% if (orders.size() > 1) { %>
									<td align="left">
									
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
														<a href="OrderItemDisplayViewShiptoAssoc?<%= ECConstants.EC_STORE_ID %>=<%= store_Id %>&orderId=<%=orderRn%>"  style="color:#ffffff; text-decoration : none;">
														<%= tooltechtext.getString("YourOrder_CheckoutThis") %>
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
					<% } %>
									<td align="right">
									
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
														<a href="javascript:updateForm(document.ShopCartForm<%= orderRn %>)"  style="color:#ffffff; text-decoration : none;">
														<%= tooltechtext.getString("YourOrder_UpdateThis") %>
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
							<br />
							<br />
							
																		<% if (orders.size() == 1) { %>
                                                 <table cellpadding="0" cellspacing="0" border="0">
                                                        <tr>
                                                               <td>
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
                                                                                                  <a href="javascript:submitForm(document.ShopCartForm<%= orderRn %>)"  style="color:#ffffff; text-decoration : none;">
                                                                                                  <%= tooltechtext.getString("YourOrder_Submit") %>&gt;
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
                                   <% } %>
						</form>

<%
	} // end for i
%>

					<% if (orders.size() == 1) { %>

						<br />
						<br />
						<br />
						<table cellpadding="0" cellspacing="0" border="0">
							<tr>
								<td>
									<p><%= tooltechtext.getString("YourOrder_Message1") %></p>
									<form name="requisitionListForm" action="RequisitionListCopy">
										<input type="hidden" name="URL" value="RequisitionListUpdateView">
										<input type="hidden" name="orderId" value="<%=orderRn%>">
										<label for="WC_CurrentOrderDisplay_FormInput_name_1"><%= tooltechtext.getString("YourOrder_ReqListName") %></label><br>
										<input type="text" name="name" size="30" id="WC_CurrentOrderDisplay_FormInput_name_1">
										<br><br>
										<table cellpadding="0" cellspacing="0" border="0">
										<tr>
											<td>
											
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
																<a href="javascript:document.requisitionListForm.submit()" style="color:#ffffff; text-decoration : none;">
																<%= tooltechtext.getString("YourOrder_Button1") %>
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
								    	</form>
								</td>
							</tr>
						</table>
						
					<% } %>
						

					</td>
				</tr>
			</table>
		<!--content end--> 

	</td>
</tr>
</table>

</body>

<flow:ifEnabled feature="customerCare">
	<script language="javascript">
		if (typeof parent.setShoppingCartItems == 'function')
			parent.setShoppingCartItems(<%=liveHelpShoppingCartItems%>);
	</script>
</flow:ifEnabled>


</HTML>




<%


		}
}

} catch (Exception ex) {
	System.err.println("In Exception: " + ex.getMessage());
	ex.printStackTrace();
}

%>
