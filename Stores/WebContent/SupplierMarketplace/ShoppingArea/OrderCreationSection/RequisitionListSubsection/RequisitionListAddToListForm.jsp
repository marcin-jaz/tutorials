
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
<%@ page import="java.sql.Timestamp" %>
<%@ page import="com.ibm.commerce.order.beans.PRequisitionByMemberIdAndStoreIdListDataBean" %>
<%@ page import="com.ibm.commerce.order.beans.SRequisitionByMemberIdAndStoreIdListDataBean" %>
<%@ page import="com.ibm.commerce.order.beans.RequisitionDataBean" %>
<%@ page import="com.ibm.commerce.order.objects.OrderAccessBean" %>
<%@ page import="com.ibm.commerce.order.utils.OrderConstants" %>
<%@ page import="com.ibm.commerce.utils.TimestampHelper" %>

<%@ include file="../../../include/EnvironmentSetup.jspf"%>
<% response.setContentType(tooltechtext.getString("ENCODESTATEMENT")); %> 

<%
CommandContext commandContext 	= (CommandContext) request.getAttribute(ECConstants.EC_COMMANDCONTEXT);
Long userRefNum 				= commandContext.getUserId();

// JSPHelper provides you with a easy way to retrieve URL parameters when they are encrypted.
// JSPHelper comes from Package com.ibm.commerce.server.*

JSPHelper jhelper 			= new JSPHelper(request);

String storeId 				= jhelper.getParameter("storeId");
String partNumber 			= jhelper.getParameter("partNumber");
String quantity 				= jhelper.getParameter("quantity");
if (partNumber==null) partNumber = "";
if (quantity==null) quantity = "";	

String[] strPartNumber 		= new String[31];
String[] strQuantity 		= new String[31];
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


String reqListStoreId = jhelper.getParameter("reqListStoreId");

//Switch background color
boolean displaySwitch			= true; 

Timestamp lastUpdate 			= null;
String formattedLastUpdate 		= "";

//check whether there are requisition lists
boolean empty				= true; 

// Get locale for formatting the date appropriately
Locale jLocale 				= commandContext.getLocale();
OrderAccessBean orderAB			= null;

//Get the private and shared requisition lists

//My private lists
RequisitionDataBean[] requisitionListsP;  

PRequisitionByMemberIdAndStoreIdListDataBean pReqListDB = new PRequisitionByMemberIdAndStoreIdListDataBean();
pReqListDB.setDataBeanKeyMemberId(userRefNum.toString());
// use the reqListStoreId instead of StoreId
pReqListDB.setDataBeanKeyStoreId(reqListStoreId);
com.ibm.commerce.beans.DataBeanManager.activate(pReqListDB, request);
requisitionListsP = pReqListDB.getPRequisitionByMemberIdAndStoreIdList();

//All shared lists in my organization. Only the ones owned by me will be displayed later.
RequisitionDataBean[] requisitionListsSAll; 

SRequisitionByMemberIdAndStoreIdListDataBean sReqListDB = new SRequisitionByMemberIdAndStoreIdListDataBean();
sReqListDB.setDataBeanKeyMemberId(userRefNum.toString());
sReqListDB.setDataBeanKeyStoreId(storeId);
com.ibm.commerce.beans.DataBeanManager.activate(sReqListDB, request);
requisitionListsSAll = sReqListDB.getSRequisitionByMemberIdAndStoreIdList();

%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<SCRIPT language="javascript">
function Add2ReqList(form)
{
	if (form.reqListId.length==null) {
		form.requisitionListId.value=form.reqListId.value;
	} else {
		for (var i=0;i<form.reqListId.length;i++) {
			if (form.reqListId[i].checked) {
				form.requisitionListId.value=form.reqListId[i].value;
				break;
			}
		}
	}
	form.submit();
}
</SCRIPT>

<HTML>
<HEAD>
	<TITLE><%=tooltechtext.getString("Addtoreq_Title")%></TITLE>
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

<!--content start--> 

<!--reqListStoreId=<%= reqListStoreId %>-->

<TABLE CELLPADDING="8" CELLSPACING="0" BORDER="0" width="620">
	<TR>
		<TD>
			<TABLE>
				<TR>
					<td colspan="2">
						<h1><%=tooltechtext.getString("Addtoreq_Title")%></h1>
					</td>
				</tr>
				<TR>
					<td><%=tooltechtext.getString("Addtoreq_Text1")%></td>
				</TR>
				<tr>
					<td><b><%=tooltechtext.getString("Addtoreq_Store")%></b>&nbsp;&nbsp;<%= reqListStoreId %></td>
				</tr>
			</TABLE>
			<BR>

			<TABLE CELLPADDING="0" CELLSPACING="0" BORDER="0" width="520">
				<TR>
					<TD>
						<TABLE CELLPADDING="0" CELLSPACING="0" BORDER="0" width="520" bgcolor="#4C6178">
							<TR>
								<TD>
									<TABLE WIDTH="100%" BORDER="0" CELLPADDING="2" CELLSPACING="1">
									<form name="RequisitionListForm" action="RequisitionListItemUpdate" method="post">
									<input type=hidden name="requisitionListId" value="">
									<input type=hidden name="cmdStoreId" value="<%= reqListStoreId %>">
									<input type=hidden name="URL" value="RequisitionListUpdateView?cmdStoreId=">
									<!--input type=hidden name="<%= OrderConstants.EC_PART_NUMBER %>" value="<%=partNumber%>"-->
									<!--input type=hidden name="quantity" value="<%=quantity%>"-->
                                    <%                                      
                                    for (int k=1; k < strPartNumber.length; k++){   
                                        if (strPartNumber[k] != null && strPartNumber[k].length() > 0){
                                    %>
									<input type=hidden name="partNumber_<%=k%>" value="<%=strPartNumber[k]%>">
									<input type=hidden name="quantity_<%=k%>" value="<%=strQuantity[k]%>">
                                    <%
                                        }
                                    }
                                    %>
										<TR bgcolor="#4C6178">
											<TD VALIGN="TOP">
												<TABLE>
													<TR>
														<TD></TD>
													</TR>
												</TABLE>
											</TD>
											<TD VALIGN="TOP">
												<TABLE>
													<TR>
														<TD VALIGN="TOP"><font style="font-family : Verdana;" color="#FFFFFF"><strong><%=tooltechtext.getString("Addtoreq_Col1")%></strong></font></TD>
													</TR>
												</TABLE>
											</TD>																				
											<TD VALIGN="TOP">
												<TABLE>
													<TR>
														<TD VALIGN="TOP"><font style="font-family : Verdana;" color="#FFFFFF"><strong><%=tooltechtext.getString("Addtoreq_Col2")%></strong></font></TD>
													</TR>
												</TABLE>
											</TD>
											<td  VALIGN="TOP">
												<TABLE>
													<TR>
														<TD><font style="font-family : Verdana;" color="#FFFFFF"><strong><%=tooltechtext.getString("Addtoreq_Col3")%></strong></font></TD>
													</TR>
												</TABLE>
											</TD>
										</TR>
<%

	int count = 0;
	if ((requisitionListsP.length==0) && (requisitionListsSAll.length==0) ) {
		//empty list
	} else {
	    //Private lists start
	    for (int i=0; i<requisitionListsP.length; i++) {
			empty=false;
			count++;
			String status=tooltechtext.getString("Addtoreq_Type1");

			lastUpdate = requisitionListsP[i].getLastUpdateInEJBType();
			if (lastUpdate==null) {
				formattedLastUpdate = "";
			} else {
				// Format date appropriately from the TimeStampHelper. Allows date to be universal.
				formattedLastUpdate = TimestampHelper.getDateFromTimestamp(lastUpdate, jLocale);
			}


										if (displaySwitch) out.println("<TR bgcolor='#ffffff'>");
										else out.println("<TR bgcolor='#BCCBDB'>");
			displaySwitch =!displaySwitch;
			if (count==1) {
%>
											<td><input type="radio" name="reqListId" value="<%=requisitionListsP[i].getOrderId()%>" checked="checked" id="WC_RequisitionListAddToListForm_FormInput_reqListId_1_<%=requisitionListsP[i].getOrderId()%>"></td>
<%
			}
			else {
%>
											<td><input type="radio" name="reqListId" value="<%=requisitionListsP[i].getOrderId()%>" id="WC_RequisitionListAddToListForm_FormInput_reqListId_1_<%=requisitionListsP[i].getOrderId()%>"></td>
<%
			}
%>
											<td><FONT class="p"><label for="WC_RequisitionListAddToListForm_FormInput_reqListId_1_<%=requisitionListsP[i].getOrderId()%>"><%= requisitionListsP[i].getDescription() %></label></FONT></A></td>
											<td><FONT class="p"><%= formattedLastUpdate %></FONT></td>
											<td><FONT class="p"><%= status %></FONT></td>
										</tr>
<%
	  	} //end of private lists

	  	//My shared lists start
	    	for (int i=0; i<requisitionListsSAll.length; i++) {
			
			String memberId=requisitionListsSAll[i].getMemberId();
			if (userRefNum.compareTo(new Long(memberId))==0) {
				empty=false;
		  		String status=tooltechtext.getString("Addtoreq_Type2");

				lastUpdate = requisitionListsSAll[i].getLastUpdateInEJBType();
				if (lastUpdate==null) {
					formattedLastUpdate = "";
				} else {
					// Format date appropriately from the TimeStampHelper. Allows date to be universal.
					formattedLastUpdate = TimestampHelper.getDateFromTimestamp(lastUpdate, jLocale);
				}

		  
										if (displaySwitch) out.println("<TR bgcolor='#ffffff'>");
										else out.println("<TR bgcolor='#BCCBDB'>");
				displaySwitch =!displaySwitch;
%>
											<td><input type="radio" name="reqListId" value="<%=requisitionListsSAll[i].getOrderId()%>" id="WC_RequisitionListAddToListForm_FormInput_reqListId_1_<%=requisitionListsSAll[i].getOrderId()%>"></td>
											<td><FONT class="p"><label for="WC_RequisitionListAddToListForm_FormInput_reqListId_1_<%=requisitionListsSAll[i].getOrderId()%>"><%= requisitionListsSAll[i].getDescription() %></label></FONT></A></td>
											<td><FONT class="p"><%= formattedLastUpdate %></FONT></td>
											<td><FONT class="p"><%= status %></FONT></td>
											
										</tr>
<%
		
		  	}//end of my shared lists	 
		}//endloop
	}//endif

%>
									</form>
									</TABLE>
								</TD>
							</TR>
						</TABLE>
						<P>
					</TD>
				</TR>
			</TABLE>
		</TD>
	</TR>
<%
if (empty) {
%>
	<TR>
		<TD><font color="red"><%=tooltechtext.getString("Addtoreq_Text2")%></font></TD>
	</TR>
<%
} else { 
%>
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
							<font color="#ffffff">
							<a href="javascript:Add2ReqList(document.RequisitionListForm)" style="color:#ffffff; text-decoration : none;">
							<%=tooltechtext.getString("Addtoreq_Button")%>
							</a>
							</font>
						</td>
					</tr>
					</table>
				</td>
				<td bgcolor="#7a1616"><img alt="" src="<%=jspStoreImgDir%>images/db.gif" border="0"/></td>			<tr>
				<td class="pixel"><img src="<%=jspStoreImgDir%>images/l_bot.gif" alt=""/></td>
				<td bgcolor="#7a1616" class="pixel" valign="top"><img src="<%=jspStoreImgDir%>images/db.gif" border="0" alt=""/></td>
				<td bgcolor="#7a1616" class="pixel" valign="top"><img src="<%=jspStoreImgDir%>images/db.gif" border="0" alt=""/></td>
			</tr>
			</table>
		</TD>
	</TR>
<%
}
%>
</TABLE>
<!--content end-->

	</TD>
</TR>
</TABLE>

</BODY>
</HTML>
