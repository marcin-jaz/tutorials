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
<%@ page import="java.sql.Timestamp" %>
<%@ page import="com.ibm.commerce.user.beans.AddressDataBean" %>
<%@ page import="com.ibm.commerce.order.beans.OrderDataBean" %>
<%@ page import="com.ibm.commerce.order.beans.OrderItemDataBean" %>
<%@ page import="com.ibm.commerce.datatype.TypedProperty" %>
<%@ page import="com.ibm.commerce.fulfillment.objects.ShippingModeAccessBean" %>
<%@ page import="com.ibm.commerce.payment.beans.UsablePaymentTCListDataBean" %>
<%@ page import="com.ibm.commerce.contract.beans.ContractDataBean" %>
<%@ page import="com.ibm.commerce.contract.objects.TradingAgreementAccessBean" %>
<%@ page import="com.ibm.commerce.contract.objects.TermConditionAccessBean" %>
<%@ page import="com.ibm.commerce.utils.TimestampHelper" %>
<%@ page import="com.ibm.commerce.payment.beans.PaymentTCInfo" %>
<%@ page import="com.ibm.commerce.catalog.beans.AttributeValueDataBean" %>
<%@ page import="com.ibm.commerce.catalog.beans.AttributeDataBean" %>
<%@ page import="com.ibm.commerce.catalog.beans.ItemDataBean" %>
<%@ page import="com.ibm.commerce.catalog.beans.CatalogEntryDataBean" %>
<%@ page import="java.text.MessageFormat" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
try {
%>

<%
/* This page shows the order summary for the users order.  It is the last step in the checkout flow */
%>

<%@ include file="../../../include/EnvironmentSetup.jspf"%>
<% response.setContentType(tooltechtext.getString("ENCODESTATEMENT")); %>

<% String strNoWrap = (locale.toString().equals("ja_JP")||locale.toString().equals("ko_KR")||locale.toString().equals("zh_CN")||locale.toString().equals("zh_TW") ? " nowrap" : ""); %>

<html>
<head>
	<title><%= tooltechtext.getString("OrderSum_Title")%></title>
	<link rel=stylesheet href="<%=fileDir%>ToolTech.css" type="text/css">
</head>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "DTD/xhtml1-transitional.dtd">

<body leftmargin="0" marginheight="0" marginwidth="0" topmargin="0">
<flow:ifEnabled feature="customerCare">
<%
// Set header type needed for this JSP for LiveHelp.  This must
// be set before HeaderDisplay.jsp
request.setAttribute("liveHelpPageType", "personal");
%>
</flow:ifEnabled>

<%
String incfile;
String strPOSchedule = "";
incfile = includeDir + "HeaderDisplay.jsp";
%>
<jsp:include page="<%=incfile%>" flush="true"/>  



<TABLE CELLPADDING="0" CELLSPACING="0" BORDER="0" height="99%" width="790">
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
		<TD>
		<h1><%= tooltechtext.getString("OrderSum_Title")%><br>
		</h1>
<%
/* OrderSchedule Code Begins */

JSPHelper jhelper = new JSPHelper(request); 
boolean bScheduledOrder = false;
String scheduled = jhelper.getParameter("scheduled");
String OrderConfirmation="";
if ((scheduled != null) && (scheduled.equalsIgnoreCase("Y"))){
	bScheduledOrder = true;
}

/* OrderSchedule Code Ends */

ErrorDataBean errorBean = new ErrorDataBean ();

com.ibm.commerce.beans.DataBeanManager.activate (errorBean, request);
TypedProperty errProp = errorBean.getExceptionData();

String strErrorMessageKey = errorBean.getMessageKey().trim();
String StatusMessage = "";
if (errProp != null)
{    
	String errCode  = errProp.getString( ECConstants.EC_ERROR_CODE, "" );
	String buyerMsg = errProp.getString( "MessageForBuyer"        , "" );
	if (strErrorMessageKey.equals("_ERR_PAY_PURCHASE_AMOUNT_EXCEED_LIMIT_OF_TA")) { 
		StatusMessage = tooltechtext.getString("OrderSum_trading_limit_exceeded");
	} else if (strErrorMessageKey.equals("_ERR_PAY_INVALID_PO_INDIVIDUAL_PO_NOT_UNIQUE")) { 
		StatusMessage = tooltechtext.getString("OrderSum_pmerror_message8");
	} else if (strErrorMessageKey.equals("_ERR_PAY_INVALID_PO_INDIVIDUAL_PO_NOT_ALLOWED")) { 
		StatusMessage = tooltechtext.getString("OrderSum_pmerror_message9");
	} else if (strErrorMessageKey.equals("_ERR_CMD_MISSING_PARAM")) { 
		StatusMessage = tooltechtext.getString("OrderSum_pmerror_message7");
	} else if ( errCode.equals("190") ) {
		StatusMessage = tooltechtext.getString("OrderSum_pmerror_message1");
	} else if ( errCode.equals("1007") && buyerMsg.length() > 0 ) {
		StatusMessage = buyerMsg;
	} else if ( errCode.equals("1007") ) {
		StatusMessage = tooltechtext.getString("OrderSum_pmerror_message2");
	} else if ( errCode.equals("1005") ) {
		StatusMessage = tooltechtext.getString("OrderSum_pmerror_message3");
	} else if ( errCode.equals("1006") ) {
		StatusMessage = tooltechtext.getString("OrderSum_pmerror_message4");
	} else {
		StatusMessage = tooltechtext.getString("OrderSum_pmerror_message5");
	}
}
/* OrderSchedule Code Begins */

if (bScheduledOrder)
{
	OrderConfirmation = tooltechtext.getString("OrderCon_Text4");
} 

/* OrderSchedule Code Ends */
%>
<%
//if the error status message contains content, then we print out the error status message.
if (!StatusMessage.equals(""))
{
%>
<p><font color="red"><%=StatusMessage%></font><br>
<P>
<% 
}
/* OrderSchedule Code Begins */
if (!OrderConfirmation.equals(""))
{
%>
<p><B><font color="#E7B610"><%=OrderConfirmation%></font></B><br>
<P>
<%
}
/* OrderSchedule Code Ends */

String languageId = cmdcontext.getLanguageId().toString();
String storeId = cmdcontext.getStoreId().toString();

//Parameters may be encrypted. Use JSPHelper to get
//URL parameter instead of request.getParameter().
/* OrderSchedule Code Begins */
/* JSPHelper jhelper = new JSPHelper(request); */
/* OrderSchedule Code Ends */

String paymentMethod = jhelper.getParameter("paymentMethod");
if (paymentMethod == null) paymentMethod = "";

// for loop starts here
String orderStoreId = null;
OrderDataBean orderBean;
Vector shippingAddrIdList = new Vector();
String [] arrorderRn = jhelper.getParameterValues ("orderId");
String orderRn= arrorderRn[0]; 
Timestamp estShipDate = null;
String [] formattedEstShipDate = new String[arrorderRn.length];
String accountNumber = "";
String policyId="";
String tcId="";
boolean [] showPONumberBox = new boolean[arrorderRn.length];  // A boolean for each order, implicitly initialized to false.

// Get locale for formatting the date appropriately
Locale jLocale 	= cmdcontext.getLocale();

for(int i=0; i < arrorderRn.length; i++) {
	orderBean = new OrderDataBean();
	orderBean.setOrderId(arrorderRn[i]);
	DataBeanManager.activate(orderBean, request);
	orderStoreId = orderBean.getStoreEntityId();
	estShipDate = orderBean.getEstimatedShipDate();
	if (estShipDate == null){
		formattedEstShipDate[i] = tooltechtext.getString("ProdAvail_Unknown");
	} else{
		// Format date appropriately from the TimeStampHelper. Allows date to be universal.
		formattedEstShipDate[i] = TimestampHelper.getDateFromTimestamp(estShipDate, jLocale);	
		
	}
	
%>						
		<p><b><%=tooltechtext.getString("OrderSum_EstShp")%>: <%=formattedEstShipDate[i]%></b></p>
		<table class="list" cellpadding=0 cellspacing=0 border=0 width="605" bgcolor="#4c6178">
			<tr>
				<td>
					<table width="100%" border=0 cellpadding=2 cellspacing=1>
						<tr bgcolor="#4c6178">
							<td width="9%">
								<table>
									<tr>
										<td valign="top"<%= strNoWrap %>><font style="font-family : Verdana;" color="#ffffff"><strong><%=tooltechtext.getString("OrderSum_Quantity")%></strong></font></td>
									</tr>
								</table>
							</td>
							<td width="9%">
								<table>
									<tr>
										<td valign="top"<%= strNoWrap %>><font style="font-family : Verdana;" color="#ffffff"><strong><%=tooltechtext.getString("OrderSum_SKU")%></strong></font></td>
									</tr>
								</table>
							</td>
							<td width="14%">
								<table>
									<tr>
										<td valign="top"<%= strNoWrap %>><font style="font-family : Verdana;" color="#ffffff"><strong><%=tooltechtext.getString("OrderSum_Name")%></strong></font></td>
									</tr>
								</table>
							</td>
							<td width="14%">
								<table>
									<tr>
										<td valign="top"<%= strNoWrap %>><font style="font-family : Verdana;" color="#ffffff"><strong><%=tooltechtext.getString("OrderSum_Man")%></strong></font></td>
									</tr>
								</table>
							</td>
							<td width="14%">
								<table>
									<tr>
										<td valign="top"<%= strNoWrap %>><font style="font-family : Verdana;" color="#ffffff"><strong><%=tooltechtext.getString("OrderSum_Add")%></strong></font></td>
									</tr>
								</table>
							</td>
							<td width="14%">
								<table>
									<tr>
										<td valign="top"<%= strNoWrap %>><font style="font-family : Verdana;" color="#ffffff"><strong><%=tooltechtext.getString("OrderSum_Meth")%></strong></font></td>
									</tr>
								</table>
							</td>
							<td width="12%">
								<table>
									<tr>
										<td valign="top"<%= strNoWrap %>><font style="font-family : Verdana;" color="#ffffff"><strong><%=tooltechtext.getString("OrderSum_Contract")%></strong></font></td>
									</tr>
								</table>
							</td>
							<td width="14%">
								<table align="right">
									<tr>
										<td valign="top"<%= strNoWrap %>><font style="font-family : Verdana;" color="#ffffff"><strong><%=tooltechtext.getString("OrderSum_Total1")%></strong></font></td>
									</tr>
								</table>
							</td>
						</tr>
<%
	OrderItemDataBean[] orderItemDataBean = orderBean.getOrderItemDataBeans();
	
	for(int j = 0; j < orderItemDataBean.length; j++) 
	{
	
		//All items get shipped to one address. So just get it from
		//the first line item
		String shipmodeId = orderItemDataBean[j].getShippingModeId().trim();
		String shippingMethodName =null;
		ShippingModeAccessBean abShippingMode = new ShippingModeAccessBean();
	
		abShippingMode.setInitKey_shippingModeId(shipmodeId);
		shippingMethodName = abShippingMode.getDescription(cmdcontext.getLanguageId(), cmdcontext.getStoreId()).getDescription();
		
		// get Contract Information
		ContractDataBean contractDataBean = new ContractDataBean();
		String contractId = orderItemDataBean[j].getContractId();
		contractDataBean.setDataBeanKeyReferenceNumber(contractId);
		
		//Check to see if PONumber box show be display by checking if a POTC exists in the
		TradingAgreementAccessBean tradingAgreementAB = cmdcontext.getTradingAgreement (contractId);				
		if (!(showPONumberBox[i])) {  // if we have already found an orderitem with a contract that requires a PONumber, then we don't have to check again. 
			//Checks if there's an accountId, we don't need PO Number from default contract
			if (tradingAgreementAB.getAccountId() != null || tradingAgreementAB.getAccountId().equals ("")) {
				TermConditionAccessBean[] TCAB = tradingAgreementAB.getTCsByTCType ("PurchaseOrderTC"); //The 'PurchaseOrderTC' Type ID is from TCType Table
				if (TCAB != null && TCAB.length != 0) {
					showPONumberBox[i] = true;
				}
			}
		}
		
	   
%>
						<tr bgcolor="#FFFFFF">
							<td width="9%" align="left" valign="top" height="124"><font style="font-size : 8pt;"><%=orderItemDataBean[j].getQuantityInEJBType().intValue()%></font></td>
							<td width="9%" valign="top" height="124"><font style="font-size : 8pt;"><%= orderItemDataBean[j].getPartNumber()%></font></td>
							<td width="14%" valign="top" height="124">
								<font style="font-size : 8pt;">
									<font style="font-size : 8pt;"><%= orderItemDataBean[j].getCatalogEntry().getDescription(new Integer(languageId)).getShortDescription()%></font><br>
<%
                                    // first check whether this item supports attributes
                            		CatalogEntryDataBean catentry = new CatalogEntryDataBean();
                            		catentry.setCatalogEntryID(orderItemDataBean[j].getCatalogEntryId());
                            		DataBeanManager.activate (catentry, request);
                                    if (catentry.getType().equals("ItemBean")) {
                            		    ItemDataBean item = new ItemDataBean(catentry);

									    AttributeValueDataBean attrvalue[];
									    attrvalue = item.getAttributeValueDataBeans(new Integer(languageId));
							
							                // Loop through attributes values and only show the value that is relavent to the attribute for this SKU
									    for (int x=0; x < attrvalue.length; x++)  {
%>
									    	<strong><%=attrvalue[x].getAttributeDataBean().getDescription()%> : </strong>
									    	<%=attrvalue[x].getValue()%><br>
<%
									    }
                                    }
%>
								</font>
							</td>
							<td width="14%" valign="top" height="124">
								<font style="font-size : 8pt;"><%=orderItemDataBean[j].getCatalogEntry().getManufacturerName()%><br>
									<strong><%=tooltechtext.getString("YourOrder_Part")%>:</strong><%=orderItemDataBean[j].getCatalogEntry().getManufacturerPartNumber()%></font>
							</td>
<%
	String shipaddress_id = orderItemDataBean[j].getAddressId();
	
	if (!shippingAddrIdList.contains(shipaddress_id))
	   shippingAddrIdList.addElement(shipaddress_id);
	
	String strNickName = "";
	if (shipaddress_id !=null && shipaddress_id.trim().length() != 0) {
		AddressDataBean bnAddressDisplay = new AddressDataBean();
		bnAddressDisplay.setAddressId(shipaddress_id);
		DataBeanManager.activate(bnAddressDisplay, request);
	
		strNickName = bnAddressDisplay.getNickName();
	}	
%>
							
							<td width="14%" valign="top" height="124"><font style="font-size : 8pt;"><%=strNickName%><br></font>
							</td>
							<td width="14%" valign="top" height="124"><font style="font-size : 8pt;"><%=shippingMethodName%></font></td>
							<td width="12%" valign="top" height="124"><font style="font-size : 8pt;"><%=contractDataBean.getName()%></font></td>
							<td width="14%" valign="top" height="124">
								<div align="right">
									<font style="font-size : 8pt;font-family : Arial, Helvetica, Verdana;"><%=orderItemDataBean[j].getFormattedTotalProduct()%></font></div>
							</td>
						</tr>


<%
}
%>

						<tr bgcolor="#BCCBDB">
							<td colspan="7" align="right" valign="top" height="19">
								<div align="right">
									<font style="font-size : 8pt;">
									<%=tooltechtext.getString("OrderSum_SubTotoal")%><br>		
									<%=tooltechtext.getString("OrderSum_Tax")%><br>	
									<%=tooltechtext.getString("OrderSum_Shipping")%><br>		
									<%=tooltechtext.getString("OrderSum_ShipTax")%><br>
									<%
									//Display discount
									if (orderBean.getTotalAdjustmentInEJBType().doubleValue() <= -0.01)
									{
										%>
										<%=tooltechtext.getString("OrderSum_Disc")%>
										<%
									}
									%>
									</font>
								</div>
							</td>
							<td width="14%" valign="top" height="19" nowrap>
								<div align="right">
									<font style="font-size : 8pt;font-family : Arial, Helvetica, Verdana;">
									<%= orderBean.getFormattedTotalProductPrice()%><br>
									<%= orderBean.getFormattedTotalTax()%><br>
									<%= orderBean.getFormattedTotalShippingCharge()%><br>
									<%= orderBean.getFormattedTotalShippingTax()%><br>
									<%
									//Display discount amount.
									if (orderBean.getTotalAdjustmentInEJBType().doubleValue() <= -0.01)
									{
										%>
										<%=orderBean.getFormattedTotalAdjustment()%>;
										<%
									}
									%>						
									</font>
								</div>
							</td>
						</tr>
						<tr bgcolor="#FFFFFF">
							<td colspan="7" align="left" valign="top">
								<div align="right">
									<b><%=tooltechtext.getString("OrderSum_Total2")%></b></div>
							</td>
							<td width="14%" valign="top">
								<div align="right">
									<b><font class="price"><%=orderBean.getGrandTotal()%></font></b></div>
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
		<br>
<% 
} // for loop ends
%>

<% out.flush(); %>
<c:import url="../../../Snippets/EDP/PaymentMethods/PaymentMethodsDisplay.jsp">
	<c:param name="shippingURL" value="${WCParam.ShippingURL}"/>
	<c:param name="previousURL" value="BillingShippingView?orderId=<%=orderRn%>&storeId=<%=storeId%>&langId=<%=languageId%>"/>
	<c:param name="cmdStoreId" value="<%=orderStoreId%>"/>
	<c:param name="doNotCollectPaymentForZeroAmount" value="true"/>
	<c:param name="showScheduleOrder" value="true"/>
	<c:param name="showPONumber" value="true"/>
</c:import>
<% out.flush(); %>

</TD>
</TR>
</TABLE>

<script language="javascript">
       var busy = false;
       
       function Handle_Submit_Order(form)
       {
              if (!busy){
                     busy = true;
                     form.submit();
              }       
              return false;
       }
 
 function date()
{

      var form = document.CardInfo1;
       
       var d = new Date();    //today's date
      var oneday = 86400000;   
//       alert(form.start1.value*oneday);      
      var millsec = d.getTime() + (form.start1.value*oneday);
      var today = new Date(millsec);
          
       var  yy = today.getYear();
       var yy1 = ''+yy;
       if(yy1.length < 4)
       {
         yy = yy+1900;
       }

       var mm = today.getMonth();
       mm++;
       var dd=  today.getDate();
       var hrs = today.getHours();
       var min  = today.getMinutes();
       var ss  = today.getSeconds();
       var format = '';
       
       var fmm, fdd, fhrs, fmin, fss; 
       if (ss<10) {
       		fss = '0'+ss;
       } else {
       	  fss = ss;
       }

       if (min<10) {
       		fmin = '0'+min;
       } else {
       	  fmin = min;
       }

       if (hrs<10) {
       		fhrs = '0'+hrs;
       } else {
       	  fhrs = hrs;
       }

       if (dd<10) {
       		fdd = '0'+dd;
       } else {
       	  fdd = dd;
       }

       if (mm<10) {
       		fmm = '0'+mm;
       } else {
       	  fmm = mm;
       }
              
			 format = yy+":"+fmm+":"+fdd+":"+fhrs+":"+fmin+":"+fss;

//alert(format);
       return format;

}
 
 
 
 function verifyFormCC()
{
      var flag = true;
  if (flag)
    {              
              var dat = date();
              var startDate = dat;
              document.CardInfo1.pay_cardBrand.value = document.CardInfo.cardBrand.value;       
              document.CardInfo1.pay_cardNumber.value=  document.CardInfo.cardNumber.value;       
              document.CardInfo1.pay_cardExpiryMonth.value = document.CardInfo.cardExpiryMonth.options[document.CardInfo.cardExpiryMonth.selectedIndex].value;
              document.CardInfo1.pay_cardExpiryYear.value = document.CardInfo.cardExpiryYear.options[document.CardInfo.cardExpiryYear.selectedIndex].value;
              document.CardInfo1.start.value = startDate;
              document.CardInfo1.pay_PONumber.value =  document.CardInfo.PONumber.value;

                document.CardInfo1.submit();
    }
}

function verifyFormCL()
{
      var flag = true;
  if (flag)
    {               
        var dat = date();
       var startDate = dat;

       document.CardInfo1.pay_accountNumber.value = document.PIInfo.account.value;
       document.CardInfo1.start.value = startDate;
        //document.CardInfo1.pay_PONumber.value =  document.CardInfo.PONumber.value;
       document.CardInfo1.pay_PONumber.value = <c:out value="${WCParam.orderId}" />;
                       
               document.CardInfo1.submit();

                 
     }

}
</script>

</body>
</html>

<%
} catch (Exception e)
{
	out.println("exception:"+e);
}
%>
