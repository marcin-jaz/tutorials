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
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="com.ibm.commerce.order.beans.OrderDataBean" %>
<%@ page import="com.ibm.commerce.order.beans.OrderItemDataBean" %>
<%@ page import="com.ibm.commerce.order.beans.SchedulerOrderByMemberIdListDataBean" %>
<%@ page import="com.ibm.commerce.contract.objects.TradingAgreementAccessBean" %>
<%@ page import="com.ibm.commerce.order.objects.OrderAccessBean" %>
<%@ page import="com.ibm.commerce.base.objects.SchedulerConfigAccessBean" %>

<%!
public boolean isRFQOrder(OrderDataBean inOrderDB) throws Exception {
	String tradingId = null;
	String tradingType = null;
	boolean isRfqOrder = false;
	if (inOrderDB != null) {
		OrderItemDataBean[] orderItemDBs = inOrderDB.getOrderItemDataBeans();
		if (orderItemDBs != null) {
			tradingId = orderItemDBs[0].getContractId();
			TradingAgreementAccessBean tradingAB = new TradingAgreementAccessBean();
			tradingAB.setInitKey_tradingId(tradingId);
			tradingAB.refreshCopyHelper();
			tradingType = tradingAB.getTradingType();
			if (tradingType.equals("3")) {
				isRfqOrder = true;
			}
		}
	}
	return isRfqOrder;
}
%>

<%@ include file="../../../include/EnvironmentSetup.jspf"%>

<% 
//Parameters may be encrypted. Use JSPHelper to get
//URL parameter instead of request.getParameter().
JSPHelper jhelper = new JSPHelper(request);
String storeId = jhelper.getParameter("storeId");

response.setContentType(tooltechtext.getString("ENCODESTATEMENT"));  

Long userId = cmdcontext.getUserId();
Locale jLocale 	= cmdcontext.getLocale();	
DateFormat formatter = DateFormat.getDateInstance(DateFormat.SHORT, jLocale);
String nextOrderId="";
%>

<% String strNoWrap = (locale.toString().equals("ja_JP")||locale.toString().equals("ko_KR")||locale.toString().equals("zh_CN")||locale.toString().equals("zh_TW") ? " nowrap" : ""); %>

<HEAD>
	<TITLE><%= tooltechtext.getString("Status_Title") %></TITLE>
	<LINK REL=stylesheet HREF="<%=fileDir%>ToolTech.css" TYPE="text/css">
</HEAD>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "DTD/xhtml1-transitional.dtd">

<BODY MARGINHEIGHT="0" MARGINWIDTH="0" LEFTMARGIN="0" TOPMARGIN="0">

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
          <TABLE CELLPADDING="8" CELLSPACING="0" BORDER="0">
            <TR>
    	      <TD>
    		<p><H1><%= tooltechtext.getString("Status_Title") %></H1>
    		<strong><%= tooltechtext.getString("Status_Heading1") %></strong><p>
    		<TABLE CELLPADDING="0" CELLSPACING="0" BORDER="0" width="605" bgcolor="#4C6178">
    		  <TR>
    		    <TD>
                      <TABLE WIDTH="100%" BORDER="0" CELLPADDING="2" CELLSPACING="1">
                        <TR bgcolor="#4C6178">
                          <TD>
                            <TABLE>
                              <TR>
                              	<TD VALIGN="TOP"<%= strNoWrap %>><font style="font-family : Verdana;" color="#FFFFFF"><strong><%= tooltechtext.getString("Status_Col1") %></strong></font></TD>
                              </TR>
                            </TABLE>
                          </TD>
                          <TD>
                            <TABLE>
                              <TR>
                              	<TD VALIGN="TOP"<%= strNoWrap %>><font style="font-family : Verdana;" color="#FFFFFF"><strong><%= tooltechtext.getString("Addtoreq_Col2") %></strong></font></TD>
                              </TR>
                            </TABLE>
                          </TD>
                          <TD>
                            <TABLE>
                              <TR>
                              	<TD VALIGN="TOP"<%= strNoWrap %>><font style="font-family : Verdana;" color="#FFFFFF"><strong><%= tooltechtext.getString("Status_Col3") %></strong></font></TD>
                              </TR>
                            </TABLE>
                          </TD>
                          <td>
                            <TABLE>
                              <TR>
                              	<TD<%= strNoWrap %>><font style="font-family : Verdana;" color="#FFFFFF"><strong><%= tooltechtext.getString("Status_Col5") %></strong></font></TD>
                              </TR>
                            </TABLE>
                          </TD>
                        </TR>


         <jsp:useBean id="orderListBean1" class="com.ibm.commerce.order.beans.OrderListDataBean" scope="page" />
<% 
	if (!multiSeller) {
		orderListBean1.setStoreId(new Integer(storeId));
	}
	orderListBean1.setUserId(cmdcontext.getUserId());
	orderListBean1.setOrderStatus("W"); //waiting for approval
	com.ibm.commerce.beans.DataBeanManager.activate(orderListBean1, request);
	Vector orders = orderListBean1.getOrders();
	
	for (int j = 0; j < orders.size(); j++) {

		OrderAccessBean next_order = (OrderAccessBean) orders.elementAt(j);
		OrderDataBean orderBean = new OrderDataBean();
		nextOrderId=next_order.getOrderId();
		orderBean.setOrderId(nextOrderId);
		com.ibm.commerce.beans.DataBeanManager.activate(orderBean, request);
		String orderStatusCode = orderBean.getStatus();
		
		//get the date ordered 
		String orderDateString = "";
		Date orderDate = orderBean.getLastUpdateInEJBType();
		if (orderDate != null)
		orderDateString = formatter.format(orderDate);		
		
		
		//get purchase order number
		String poNumber = orderBean.getPurchaseOrderNumber();
		if (poNumber == null || poNumber.length() == 0) {
			poNumber = tooltechtext.getString("Status_none");
		}
%>

                        <TR bgcolor="#ffffff">
                          <td align="center"><A href="OrderDetail?orderId=<%=nextOrderId%>&orderStatusCode=<%=orderStatusCode%>"><%=nextOrderId%></a></TD>
                          <TD><%=orderDateString%></TD>
                          <TD><%=poNumber%></TD>
                          <TD><FONT class="price"><%=orderBean.getGrandTotal()%></font></TD>
                        </TR>
	
<%
	}
		
	if (orders.size()==0) {
	//no past orders
%>
                        <tr bgcolor="#ffffff">
                          <td colspan="4"><p><%=tooltechtext.getString("Status_No_Orders_Found_2")%></p></td>
                        </tr>
<% 
	}
%>
                      </TABLE>
                    </TD>
                  </TR>
                </TABLE>
              </TD>
            </TR>
            <P>


<!-----second table---->

            <TR>
    	      <TD>
              <br><br>
    	      <strong><%= tooltechtext.getString("Status_Heading2") %></strong><P>
                <TABLE CELLPADDING="0" CELLSPACING="0" BORDER="0" width="605" bgcolor="#4C6178">
                  <TR>
                    <TD>
                      <TABLE WIDTH="100%" BORDER="0" CELLPADDING="2" CELLSPACING="1">
                        <TR bgcolor="#4C6178">
                          <TD>
                            <TABLE>
                              <TR>
                                <TD VALIGN="TOP"<%= strNoWrap %>><font style="font-family : Verdana;" color="#FFFFFF"><strong><%= tooltechtext.getString("Status_Col7") %></strong></font></TD>
                              </TR>
                            </TABLE>
                          </TD>
                          <TD>
                            <TABLE>
                              <TR>
                                <TD VALIGN="TOP" width=100<%= strNoWrap %>><font style="font-family : Verdana;" color="#FFFFFF"><strong><%= tooltechtext.getString("Status_Col8") %></strong></font></TD>
                              </TR>
                            </TABLE>
                          </TD>
                          <TD>
                            <TABLE>
                          	<TR>
                                <TD VALIGN="TOP"<%= strNoWrap %>><font style="font-family : Verdana;" color="#FFFFFF"><strong><%= tooltechtext.getString("Status_Col9") %></strong></font></TD>
                          	</TR>
                            </TABLE>
                          </TD>
                          <td>
                            <TABLE>
                          	<TR>
                          	  <TD<%= strNoWrap %>><font style="font-family : Verdana;" color="#FFFFFF"><strong><%= tooltechtext.getString("Status_Col10") %></strong></font></TD>
                          	</TR>
                            </TABLE>
                          </TD>
                          <td>
                            <TABLE>
                          	<TR>
                          	  <TD<%= strNoWrap %>><font style="font-family : Verdana;" color="#FFFFFF"><strong><%= tooltechtext.getString("Status_Col11") %></strong></font></TD>
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
         <jsp:useBean id="orderListBean2" class="com.ibm.commerce.order.beans.OrderListDataBean" scope="page" />                        
<%
	if (!multiSeller) {
		orderListBean2.setStoreId(new Integer(storeId));
	}
	orderListBean2.setUserId(cmdcontext.getUserId());
	String statusChar = "N,M,B,C,R,S";
	orderListBean2.setOrderStatus(statusChar);
	
	com.ibm.commerce.beans.DataBeanManager.activate(orderListBean2, request);
	orders = orderListBean2.getOrders();
	
	for (int j = 0; j < orders.size(); j++) {
		OrderAccessBean next_order = (OrderAccessBean) orders.elementAt(j);
		OrderDataBean orderBean = new OrderDataBean();
		nextOrderId=next_order.getOrderId();
		orderBean.setOrderId(nextOrderId);
		com.ibm.commerce.beans.DataBeanManager.activate(orderBean, request);
		String orderStatusCode = orderBean.getStatus();
		
		//get the date ordered
		String orderDateString = "";
		
		Date orderDate;
		orderDate = next_order.getPlaceOrderTimeInEJBType();
		
		if (orderDate != null)
		orderDateString = formatter.format(orderDate);
		
		OrderDataBean orderDB = new OrderDataBean();
		orderDB.setOrderId(next_order.getOrderId());   
		DataBeanManager.activate(orderDB, request);
		
		//get purchase order number
		String poNumber = orderBean.getPurchaseOrderNumber();
		if (poNumber == null || poNumber.length() == 0) 
		{
			poNumber =  tooltechtext.getString("Status_none");
		}
		                  
		//get status
		String orderSFixed = "Status_";
		String orderStatus = tooltechtext.getString(orderSFixed.concat(orderStatusCode));
              
%>

                        <TR bgcolor="#ffffff">
                          <td align="center"><A href="OrderDetail?orderId=<%=nextOrderId%>&orderStatusCode=<%=orderStatusCode%>"><%=nextOrderId%></TD>
                          <TD><%=orderDateString%></TD>
                          <TD><%=poNumber%></a></TD>
                          <TD><%=orderStatus%></TD>
                          <TD><FONT class="price"><%=orderBean.getGrandTotal()%></FONT></TD>
                          
                          <% if (!isRFQOrder(orderBean)) {
                          	%>
                          <TD<%= strNoWrap %>><A HREF="OrderCopy?cmdStoreId=<%=orderDB.getStoreEntityId()%>&fromOrderId_1=<%=nextOrderId%>&toOrderId=.**.&copyOrderItemId_1=*&URL=OrderItemDisplayViewShiptoAssoc%3FcmdStoreId%3D"><%= tooltechtext.getString("Status_Link1") %></A></TD>
                          <% } else { %>
                          	<TD>&nbsp;</TD>
                          <% } %>
                        </TR>
<%

	}
	
	if (orders.size()==0)
	{
		//no past orders
%>

                        <tr bgcolor="#ffffff">
                          <td colspan="6"><p><%=tooltechtext.getString("Status_No_Orders_Found_2")%></p></td>
                        </tr>
<% 
	}
%>
                      </TABLE>
                    </TD>
                  </TR>
                </TABLE>
              </TD>
            </TR>
            
            
<!-----Third Table Start--->
<!---Scheduled Orders Code Started---->    
            <TR>
    	      <TD>
    		<br><br>
    		<strong><%=  tooltechtext.getString("Status_Heading3") %></strong><P>
    		  <TABLE  CELLPADDING="0" CELLSPACING="0" BORDER="0" width="605" bgcolor="#4C6178">
    		    <TR>
    		      <TD>
	
	<% 

	String orderId = null;
	//CommandContext commandContext = (CommandContext)  request.getAttribute(ECConstants.EC_COMMANDCONTEXT);
	SchedulerOrderByMemberIdListDataBean orderABFinder = new  SchedulerOrderByMemberIdListDataBean();
	//Long userId = commandContext.getUserId();
	orderABFinder.setDataBeanKeyMemberId(userId.toString());
	com.ibm.commerce.beans.DataBeanManager.activate(orderABFinder, request);
	com.ibm.commerce.order.beans.SchedulerOrderDataBean bnSchOrd[] =  orderABFinder.getSchedulerOrderByMemberIdList();
%>
    				
                        <TABLE WIDTH="100%" BORDER="0" CELLPADDING="2" CELLSPACING="1">
                          <TR bgcolor="#4C6178">
                            <TD>
                              <TABLE>
                    		<TR>
                    		  <TD VALIGN="TOP"<%= strNoWrap %>><font  color="#FFFFFF"><strong><%=  tooltechtext.getString("Status_Col13") %></strong></font></TD>
                    		</TR>
                              </TABLE>
                            </TD>
                            <TD>
                    	      <TABLE>
                    		<TR>
                    		  <TD VALIGN="TOP"<%= strNoWrap %>><font  color="#FFFFFF"><strong><%=  tooltechtext.getString("Status_Col15") %></strong></font></TD>
                    		</TR>
                              </TABLE>
                            </TD>
                            <td >
                              <TABLE>
                    		<TR>
                    		  <TD<%= strNoWrap %>><font  color="#FFFFFF"><strong><%=  tooltechtext.getString("Status_Col16") %></strong></font></TD>
                    		</TR>
                              </TABLE>
                            </TD>
	
                            <TD>
                              <TABLE>
                    		<TR>
                    		  <TD VALIGN="TOP"<%= strNoWrap %>><font  color="#FFFFFF"><strong><%=  tooltechtext.getString("Status_Col17") %></strong></font></TD>
                    		</TR>
                              </TABLE>
                            </TD>
                            <TD>
                              <TABLE>
                    		<TR>
                    		  <TD VALIGN="TOP"<%= strNoWrap %>><font  color="#FFFFFF"><strong><%=  tooltechtext.getString("Status_Col18") %></strong></font></TD>
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

	if (bnSchOrd.length != 0) {

		for(int i=0;i< bnSchOrd.length;i++) {
		
			OrderDataBean orderBean = new OrderDataBean();
			orderBean.setOrderId(bnSchOrd[i].getOrderId());
			com.ibm.commerce.beans.DataBeanManager.activate(orderBean, request);
			
			SchedulerConfigAccessBean SchConBean = new SchedulerConfigAccessBean();
			SchConBean.setInitKey_jobReferenceNumber(bnSchOrd[i].getJobReferenceNumber());
			String Interval = "";
			String frequency = SchConBean.getInterval()+"";
			if(frequency.equals("0"))
			Interval = tooltechtext.getString("OrderSum_Interval_6");
			else if(frequency.equals("86400"))
			Interval = tooltechtext.getString("OrderSum_Interval_1");
			else if(frequency.equals("604800"))
			Interval = tooltechtext.getString("OrderSum_Interval_2");
			else if(frequency.equals("1209600"))
			Interval = tooltechtext.getString("OrderSum_Interval_3");
			else if(frequency.equals("1814400"))
			Interval = tooltechtext.getString("OrderSum_Interval_4");
			else if(frequency.equals("2592000"))
			Interval = tooltechtext.getString("OrderSum_Interval_5");
			
			
			//get purchase order number
			String poNumber = orderBean.getPurchaseOrderNumber();
			if (poNumber == null || poNumber.length() == 0) 
			{
				poNumber =  tooltechtext.getString("Status_none");
			}
			
			Date OrderDateTemp;                                         // Date variable to hold the scheduled order start date
			String OrderDateStr = "";                                   //  String variable to hold the scheduled order start date
			OrderDateTemp = SchConBean.getStartInEJBType();             // Get the scheduled Order's start Date
			OrderDateStr = formatter.format(OrderDateTemp);             // Convert date to locale specific format
%>


                          <TR bgcolor="ffffff">
                            <td align="center"><A  href="OrderDetail?orderId=<%=orderBean.getOrderId()%>"><%=orderBean.getOrderId()%></A></TD>
                            <TD><font class="strongtext"><%=poNumber%></font></TD>
                            <TD><FONT class="price"><%=orderBean.getGrandTotal()%></FONT></TD>
                            <TD><%=Interval%></TD>
                            <TD><%=OrderDateStr%></TD>
                            <TD<%= strNoWrap %>><A href="ScheduledOrderCancel?orderId=<%=orderBean.getOrderId()%>&URL=TrackOrderStatus"  onClick="return confirm('<%=tooltechtext.getString("Status_OrderCancel_Confirm")%>');">
<%=tooltechtext.getString("Status_Button2")%></A></TD>
                          </TR>

<%
		} //End of For loop
%>



<%
	} else {
	//no past orders
%>
                          <tr bgcolor="#ffffff">
                            <td colspan="6"><p><%=tooltechtext.getString("Status_No_Orders_Found")%></p></td>
                          </tr>
<%
	}
%>
                        </TABLE>
                      </TD>
                    </TR>
                  </TABLE>
                  <P>
                </TD>
              </TR>
            </TABLE>

<!---Scheduled Orders Code Ended---->
	<!--content end-->
	</TD>
</TR>
</TABLE>

</BODY>
</HTML>

