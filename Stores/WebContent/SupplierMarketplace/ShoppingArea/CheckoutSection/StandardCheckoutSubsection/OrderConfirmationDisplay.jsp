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
<%@ page import="com.ibm.commerce.order.beans.OrderDataBean" %>
<%@ page import="com.ibm.commerce.payment.beans.PayStatusPMDataBean" %>
<%@ page import="com.ibm.etill.framework.clientapi.PaymentCommandConstants" %>
<%@ page import="com.ibm.commerce.ras.*" %>
<%@ page import="com.ibm.commerce.exception.*"  %>
<%@ page import="com.ibm.commerce.utils.TimestampHelper" %>
<%@ page import="java.sql.Timestamp" %>

<%@ include file="../../../include/EnvironmentSetup.jspf"%>

<%

JSPHelper jhelper = new JSPHelper(request);
String[] arrorderRn = jhelper.getParameterValues("orderId");
String scheduled = jhelper.getParameter("scheduled");
boolean bScheduledOrder = false;
if ((scheduled != null) && (scheduled.equalsIgnoreCase("Y"))){
	bScheduledOrder = true;
}

String orderRn = arrorderRn[0];
Timestamp estShipDate = null;
String formattedEstShipDate = "";
String StatusMessage = "";

// Get locale for formatting the date appropriately
Locale jLocale 	= cmdcontext.getLocale();

boolean isFailureUrl  = false;
boolean isCancelUrl   = false;

String failParm = request.getParameter("fail");
if ( failParm != null && failParm.equals("1") ) isFailureUrl = true; 

String cancelParm = request.getParameter("cancel");
if ( cancelParm != null && cancelParm.equals("1") ) isCancelUrl = true; 

%>

<% String strNoWrap = (locale.toString().equals("ja_JP")||locale.toString().equals("ko_KR")||locale.toString().equals("zh_CN")||locale.toString().equals("zh_TW") ? " nowrap" : ""); %>

<HEAD>
	<TITLE><%= tooltechtext.getString("OrderCon_Title")%></TITLE>
	<LINK REL=stylesheet HREF="<%=fileDir%>ToolTech.css" TYPE="text/css">
</HEAD>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "DTD/xhtml1-transitional.dtd">

<BODY MARGINHEIGHT="0" MARGINWIDTH="0" LEFTMARGIN="0" TOPMARGIN="0" onLoad="if (typeof top.updateStInfo == 'function') top.updateStInfo();">

<flow:ifEnabled feature="customerCare">
<%
// Set header type needed for this JSP for LiveHelp.  This must
// be set before HeaderDisplay.jsp
request.setAttribute("liveHelpPageType", "personal");
%>
<script language="javascript">
	if (typeof parent.setShoppingCartItems == 'function')
		parent.setShoppingCartItems(0);
</script>
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
if (bScheduledOrder)
{
	StatusMessage = tooltechtext.getString("OrderCon_Text4");
} else {

%>
<jsp:useBean id="payStatus" class="com.ibm.commerce.payment.beans.PayStatusPMDataBean" scope="page">
<% com.ibm.commerce.beans.DataBeanManager.activate(payStatus, request); %>
</jsp:useBean>

<%
	String etOrderState   = payStatus.getOrderState();
	String etPaymentState = payStatus.getPaymentState();
	String ncOrderStatus  = payStatus.getOrderStatus();

%>

    <% if ( ncOrderStatus.equals("") )
       { 
    
          StatusMessage = tooltechtext.getString("STATUS_MESSAGE1");
       } 
       else if ( payStatus.getPrimaryRC() != 0 )
       { 
    
          StatusMessage = tooltechtext.getString("STATUS_MESSAGE2");
       } 
       else if ( etOrderState.equals( PaymentCommandConstants.ORDERSTATE_CLOSED ) )
       { 
          StatusMessage = tooltechtext.getString("STATUS_MESSAGE3");
       } 
       else if ( etOrderState.equals( PaymentCommandConstants.ORDERSTATE_PENDING ) 
                   || etPaymentState.equals( PaymentCommandConstants.PAYMENTSTATE_PENDING ) )
       { 
    
          StatusMessage = tooltechtext.getString("STATUS_MESSAGE4");
       } 
       else if ( etOrderState.equals( PaymentCommandConstants.ORDERSTATE_ORDERED ) 
                   && ( etPaymentState.equals( PaymentCommandConstants.PAYMENTSTATE_RESET )
                        || etPaymentState.equals("")  ) )
       { 
          StatusMessage = tooltechtext.getString("STATUS_MESSAGE5");
       } 
	else if ( etOrderState.equals( PaymentCommandConstants.ORDERSTATE_REFUNDABLE ) 
		&& ( etPaymentState.equals( PaymentCommandConstants.PAYMENTSTATE_RESET )
		|| etPaymentState.equals("")  ) ) 
	{ 
		StatusMessage = tooltechtext.getString("STATUS_MESSAGE5");
	}				       
       else if ( etPaymentState.equals( PaymentCommandConstants.PAYMENTSTATE_APPROVED ) 
                   || etPaymentState.equals( PaymentCommandConstants.PAYMENTSTATE_DEPOSITED ) 
                   || etPaymentState.equals( PaymentCommandConstants.PAYMENTSTATE_CLOSED ) )
       { 
    
          StatusMessage = tooltechtext.getString("STATUS_MESSAGE3");
       } 
	else if ( etPaymentState.equals( PaymentCommandConstants.PAYMENTSTATE_DECLINED ) 
	            || etPaymentState.equals( PaymentCommandConstants.PAYMENTSTATE_VOID ) )
       { 
        StatusMessage = tooltechtext.getString("STATUS_MESSAGE6");
       } 
       else if ( etOrderState.equals( PaymentCommandConstants.ORDERSTATE_REJECTED ) )
       { 
        StatusMessage = tooltechtext.getString("STATUS_MESSAGE7");
       } 
	else if ( isFailureUrl && ncOrderStatus.equals("P") ) 
	{ 
	        StatusMessage = tooltechtext.getString("STATUS_MESSAGE10");
	}
	else if ( isCancelUrl && ncOrderStatus.equals("P") ) 
	{ 
	        StatusMessage = tooltechtext.getString("STATUS_MESSAGE11");
	}       
       else if ( ncOrderStatus.equals("X") )
       { 
		  StatusMessage = tooltechtext.getString("STATUS_MESSAGE8");
       } else {
    	  StatusMessage = tooltechtext.getString("STATUS_MESSAGE9");            
       } 
	} // else
%>
						<TABLE CELLPADDING="8">
	<TR>
		<TD>
		<h1><%= tooltechtext.getString("OrderCon_Title")%></h1>
									<font class="P"><strong><%=StatusMessage%></strong></font><br>
									<br>
<% if (!bScheduledOrder) { %>

<% for (int i=0; i < arrorderRn.length ; i++) { 
	OrderDataBean orderBean = new OrderDataBean();
	orderBean.setOrderId(arrorderRn[i]);   
	DataBeanManager.activate(orderBean, request); 
	
	estShipDate = orderBean.getEstimatedShipDate();
	
	if (estShipDate == null){
		formattedEstShipDate = tooltechtext.getString("ProdAvail_Unknown");
	} else{
		// Format date appropriately from the TimeStampHelper. Allows date to be universal.
		formattedEstShipDate = TimestampHelper.getDateFromTimestamp(estShipDate, jLocale);	
	}
%>

									<table cellspacing=2 cellpadding=2 width=190 border=0>
										<tbody>
											<tr>
												<td valign=center align=left<%= strNoWrap %>><font class="P"><%= tooltechtext.getString("OrderCon_Number")%></font></td>
												<td valign=center align=right><font class="P"><strong><%=orderBean.getOrderId() %></strong></font></td>
											</tr>
											<tr>
												<td valign=center align=left<%= strNoWrap %>><font class="P"><%= tooltechtext.getString("OrderCon_Subtotal")%></font></td>
												<td valign=center align=right><font class="price"><%= orderBean.getFormattedTotalProductPrice() %></font></td>
											</tr>
											<tr>
												<td valign=center align=left<%= strNoWrap %>><font class="P"><%= tooltechtext.getString("OrderCon_Tax")%></font></td>
												<td valign=center align=right><font class="price"><%= orderBean.getFormattedTotalTax() %></font></td>
											</tr>
											<tr>
												<td valign=center align=left<%= strNoWrap %>><font class="P"><%= tooltechtext.getString("OrderCon_Ship")%></font></td>
												<td valign=center align=right><font class="price"><%= orderBean.getFormattedTotalShippingCharge() %></font></td>
											</tr>
											<tr>
												<td valign=center align=left<%= strNoWrap %>><font class="P"><%= tooltechtext.getString("OrderCon_Total")%></font></td>
												<td valign=center align=right><font class="price"><strong><%=orderBean.getGrandTotal()%></strong></font></td>
											</tr>
																					
										</tbody>
									</table>
									<table cellspacing=2 cellpadding=2 border=0>
										<tbody>
											<tr>									
												<td valign="center" align="left">
													<br><font class=product><%= tooltechtext.getString("OrderCon_EstShp")%>: <%=formattedEstShipDate%></font>
												</td>
											</tr>
										</tbody>
									</table>
									<br>
	<% } %>								
									<table cellspacing=2 cellpadding=2 border=0>
										<tbody>
											<tr>									
												<td valign="center" align="left">
													<font class="P"><%= tooltechtext.getString("OrderCon_Text2")%></font>
												</td>
											</tr>
										</tbody>
									</table>									
<% } // end if  %>
								<table cellspacing=2 cellpadding=2 border=0>
									<tbody>
										<tr>									
											<td valign="center" align="left">
												<font class="P"><strong><%= tooltechtext.getString("OrderCon_Text3")%></strong></font>
											</td>
										</tr>
									</tbody>
								</table>									
								<p><br>
								</p>
							</TD>
						</TR>
					</TABLE>
					<!--content end-->
				</TD>
			</TR>
		</TABLE>
</BODY>
</HTML>
