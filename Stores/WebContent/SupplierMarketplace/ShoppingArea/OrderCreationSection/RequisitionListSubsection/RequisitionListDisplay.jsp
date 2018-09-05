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
<%@ page import="com.ibm.commerce.utils.TimestampHelper" %>
<%@ page import="com.ibm.commerce.order.utils.OrderConstants"   %>
<%@ page import="com.ibm.commerce.order.beans.PRequisitionByMemberIdAndStoreIdListDataBean" %>
<%@ page import="com.ibm.commerce.order.beans.SRequisitionByMemberIdAndStoreIdListDataBean" %>

<%@ page import="com.ibm.commerce.order.beans.PRequisitionByMemberIdAndStoreHostedAtChannelStoreIdListDataBean" %>
<%@ page import="com.ibm.commerce.order.beans.SRequisitionByMemberIdAndStoreHostedAtChannelStoreIdListDataBean" %>

<%@ page import="com.ibm.commerce.order.beans.RequisitionDataBean" %>
<%@ page import="com.ibm.commerce.user.beans.UserRegistrationDataBean"   %>
<%@ page import="java.sql.Timestamp" %>

<%@ include file="../../../include/EnvironmentSetup.jspf"%>
<% response.setContentType(tooltechtext.getString("ENCODESTATEMENT")); %> 

<%
CommandContext commandContext 	= (CommandContext) request.getAttribute(ECConstants.EC_COMMANDCONTEXT);
Long userRefNum 				= commandContext.getUserId();

// JSPHelper provides you with a easy way to retrieve URL parameters when they are encrypted.
// JSPHelper comes from Package com.ibm.commerce.server.*

JSPHelper jhelper 			= new JSPHelper(request);

String storeId 				= jhelper.getParameter("storeId");
String languageId 			= jhelper.getParameter("langId");
String requisitionListsType 		= jhelper.getParameter("requisitionListsType");
String reqListStoreId			= jhelper.getParameter("reqListStoreId");

// show Logon page if user is not registered or not approved
UserRegistrationDataBean bnRegUser = new UserRegistrationDataBean();
com.ibm.commerce.beans.DataBeanManager.activate(bnRegUser, request);
String userState 				= cmdcontext.getUser().getState();
String errorString 			= "";
if (!userState.equals("1"))  // if user is not approved
{
	errorString = "AUTHORIZATION_ERROR2";
	if (!bnRegUser.findUser()) // if user is a guest
		errorString = "AUTHORIZATION_ERROR1";
%>
<jsp:forward page="/servlet/LogonForm">
	<jsp:param name="storeId" value="<%= storeId%>"/>
	<jsp:param name="langId" value="<%=languageId%>"/>
	<jsp:param name="errorMessage" value="<%=errorString%>"/>
</jsp:forward>
<%
}

if (requisitionListsType==null)
	requisitionListsType = "All";
else if (requisitionListsType.equalsIgnoreCase("mine")) 
	requisitionListsType = "Mine";
else 
	requisitionListsType = "All";

String partNumber 			= jhelper.getParameter("partNumber");
String quantity 				= jhelper.getParameter("quantity");
if (partNumber==null) partNumber = "";
if (quantity==null) quantity = "";

//Switch background color
boolean displaySwitch			= true; 

Timestamp lastUpdate 			= null;
String formattedLastUpdate 		= "";

//Check whether there are requisition lists
boolean empty				= true;  

// Get locale for formatting the date appropriately
Locale jLocale 				= commandContext.getLocale();

//Get the private and shared requisition lists

//My private lists
RequisitionDataBean[] requisitionListsP;  


if (reqListStoreId != null && !reqListStoreId.equals("")) {
	PRequisitionByMemberIdAndStoreIdListDataBean pReqListDB = new PRequisitionByMemberIdAndStoreIdListDataBean();
	pReqListDB.setDataBeanKeyMemberId(userRefNum.toString());
	pReqListDB.setDataBeanKeyStoreId(reqListStoreId);
	com.ibm.commerce.beans.DataBeanManager.activate(pReqListDB, request);
	requisitionListsP = pReqListDB.getPRequisitionByMemberIdAndStoreIdList();
} else {
	PRequisitionByMemberIdAndStoreHostedAtChannelStoreIdListDataBean pReqListDB = new PRequisitionByMemberIdAndStoreHostedAtChannelStoreIdListDataBean();
	pReqListDB.setDataBeanKeyMemberId(userRefNum.toString());
	pReqListDB.setDataBeanKeyStoreId(sessionStoreId);
	com.ibm.commerce.beans.DataBeanManager.activate(pReqListDB, request);
	requisitionListsP = pReqListDB.getPRequisitionByMemberIdAndStoreHostedAtChannelStoreIdList();
}

//All shared lists in my organization
RequisitionDataBean[] requisitionListsSAll; 

if (reqListStoreId != null && !reqListStoreId.equals("")) {
	SRequisitionByMemberIdAndStoreIdListDataBean sReqListDB = new SRequisitionByMemberIdAndStoreIdListDataBean();
	sReqListDB.setDataBeanKeyMemberId(userRefNum.toString());
	sReqListDB.setDataBeanKeyStoreId(reqListStoreId);
	com.ibm.commerce.beans.DataBeanManager.activate(sReqListDB, request);
	requisitionListsSAll = sReqListDB.getSRequisitionByMemberIdAndStoreIdList();
} else {
	SRequisitionByMemberIdAndStoreHostedAtChannelStoreIdListDataBean sReqListDB = new SRequisitionByMemberIdAndStoreHostedAtChannelStoreIdListDataBean();
	sReqListDB.setDataBeanKeyMemberId(userRefNum.toString());
	sReqListDB.setDataBeanKeyStoreId(sessionStoreId);
	com.ibm.commerce.beans.DataBeanManager.activate(sReqListDB, request);
	requisitionListsSAll = sReqListDB.getSRequisitionByMemberIdAndStoreHostedAtChannelStoreIdList();
}



//Store shared lists owned by other people in my organization. 
//Display my shared lists before displaying other shared lists
Vector requisitionListsSOther=new Vector(); 
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title><%=tooltechtext.getString("ReqList_Title")%></title>
	<link rel="stylesheet" href="<%=fileDir%>ToolTech.css" type="text/css">
</head>

<script language="javascript">
	function init(form){
		for(var i = 0; i < form.reqListStoreId.length; i++){
			if(form.reqListStoreId.options[i].value == '<%=reqListStoreId%>'){
				form.reqListStoreId.options[i].selected = true;
				break;
			}
		}
	}
</script>


<body marginheight="0" marginwidth="0" leftmargin="0" topmargin="0" onload="if (typeof top.updateStInfo == 'function') top.updateStInfo();  init(document.RequisitionListsTypeForm);">
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
	<TD VALIGN="top" BGCOLOR="#4c6178" WIDTH="160"> 

		<%
		incfile = includeDir + "SidebarDisplay.jsp";
		%>
		<jsp:include page="<%=incfile%>" flush="true"/>

	</td>

	<TD valign="top" width="630">

<!--content start--> 

<table cellpadding="8" cellspacing="0" border="0" width="605">
	<tr>
		<td>
			<TABLE>
				<tr>
					<td colspan="2">
						<h1><%=tooltechtext.getString("ReqList_Title")%></h1>
					</td>
				</tr>
					<form name="RequisitionListsTypeForm" action="RequisitionListView" method="post">
							<input type="hidden" name="langId" value="<%= lang %>">
							<input type="hidden" name="storeId" value="<%= sessionStoreId %>">
<%
	HashMap relatedStores = com.ibm.commerce.store.util.StoreRelationUtil.getRelatedOpenStores(new Integer(sessionStoreId),ECConstants.EC_STRELTYP_HOSTED_STORE);
	Integer[] anStoreIds = com.ibm.commerce.common.helpers.StoreUtil.getRelatedStores(new Integer(sessionStoreId),ECConstants.EC_STRELTYP_HOSTED_STORE);
%>
				<tr>
					<td>
						<b><label for="WC_RequisitionListDisplay_FormInput_reqListStoreId_1"><%= tooltechtext.getString("SupplierDropDown_SelectSupplier") %></label></b>
					</td>
					<td>
							<select name="reqListStoreId" id="WC_RequisitionListDisplay_FormInput_reqListStoreId_1">
								<option value=""><%= tooltechtext.getString("SupplierDropDown_AllSupplier") %></option>
								<%
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
				</tr>
<%

%>
				<tr>
					<td><B><label for="WC_RequisitionListDisplay_FormInput_requisitionListsType_1"><%=tooltechtext.getString("ReqList_ViewType")%></label></B></td>
					<td><select NAME="requisitionListsType" id="WC_RequisitionListDisplay_FormInput_requisitionListsType_1">

						<%
						if (requisitionListsType.equals("All")) {
							out.println("<option value='All' SELECTED>"+tooltechtext.getString("ReqList_Drop1")+"</option>");
							out.println("<option value='Mine'>"+tooltechtext.getString("ReqList_Drop2")+"</option>");
						} else if (requisitionListsType.equals("Mine")) {
							out.println("<option value='All'>"+tooltechtext.getString("ReqList_Drop1")+"</option>");
							out.println("<option value='Mine' SELECTED>"+tooltechtext.getString("ReqList_Drop2")+"</option>");
						}
						%>

					</select></td>
				</tr>
				<tr>
					<td colspan="2">					
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
										<a href="javascript:document.RequisitionListsTypeForm.submit()"  style="color:#ffffff; text-decoration : none;">
										<%=tooltechtext.getString("ReqList_Go")%>
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
					</form>
				</TR>

				<tr>
					<td></td>
					<td></td>
				</tr>
			</table>
			<br>

			<table cellpadding="0" cellspacing="0" border="0" width="605">
				<tr>
					<td>
						<table cellpadding="0" cellspacing="0" border="0" width="605" bgcolor="#4c6178">
							<tr>
								<td>
									<table width="100%" border="0" cellpadding="2" cellspacing="1">
										<tr bgcolor="#4c6178">
											<td valign="middle">
												<font style="font-family : Verdana;" color="#FFFFFF"><strong><%=tooltechtext.getString("ReqList_Store")%></strong></font>
											</td>
											<td valign="top">
												<table>
													<tr>
														<td valign="top"><font style="font-family : Verdana;" color="#FFFFFF"><strong><%=tooltechtext.getString("ReqList_Name")%></strong></font></td>
													</tr>
												</table>
											</td>
											<td valign="top">
												<table>
													<tr>
														<td valign="top"><font style="font-family : Verdana;" color="#FFFFFF"><strong><%=tooltechtext.getString("ReqList_Owner")%></strong></font></td>
													</tr>
												</table>
											</td>										
											<td valign="top">
												<table>
													<tr>
														<td valign="top"><font style="font-family : Verdana;" color="#FFFFFF"><strong><%=tooltechtext.getString("ReqList_Date")%></strong></font></td>
													</tr>
												</table>
											</td>
											<td  valign="top">
												<table>
													<tr>
														<td><font style="font-family : Verdana;" color="#FFFFFF"><strong><%=tooltechtext.getString("ReqList_Type")%></strong></font></td>
													</tr>
												</table>
											</td>
											<td>
												<table>
													<tr>
														<td valign="top"></td>
													</tr>
												</table>
											</td>
										</tr>
<%
	
	if ((requisitionListsP.length==0) && (requisitionListsSAll.length==0) ) {
		//no requisition list, do nothing
	} else {
	    empty=false;

	    //Private lists start
	
	    for (int i=0; i<requisitionListsP.length; i++) {
	
		String memberId=requisitionListsP[i].getMemberId();
		
		String status=tooltechtext.getString("ReqList_Type1");

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
%>
											<td><FONT class="p"><%= requisitionListsP[i].getStoreEntityId() %></FONT></td>
											<td><A href="RequisitionListUpdateView?<%= OrderConstants.EC_REQUISITION_LIST_ID %>=<%= requisitionListsP[i].getOrderId() %>&iPartNumber=<%=partNumber%>&iQuantity=<%=quantity%>"><FONT class="p"><%= requisitionListsP[i].getDescription() %></FONT></A></td>
<% if (jLocale.toString().equals("ja_JP")||jLocale.toString().equals("ko_KR")||jLocale.toString().equals("zh_CN")) { %>

											<td><FONT class="p"><%= bnRegUser.getLastName() %>&nbsp;<%= bnRegUser.getFirstName() %></FONT></td>
<% } else if (jLocale.toString().equals("zh_TW")) { %>
											<td><FONT class="p"><%= bnRegUser.getLastName() %><%= bnRegUser.getFirstName() %></FONT></td>

<% } else { %>

											<td><FONT class="p"><%= bnRegUser.getFirstName() %>&nbsp;<%= bnRegUser.getLastName() %></FONT></td>
<% } %>
											<td><FONT class="p"><%= formattedLastUpdate %></FONT></td>
											<td><FONT class="p"><%= status %></FONT></td>
											<td><A HREF="RequisitionListDelete?<%= ECConstants.EC_URL %>=RequisitionListView&<%= OrderConstants.EC_REQUISITION_LIST_ID %>=<%= requisitionListsP[i].getOrderId() %>"><FONT class="p"><%=tooltechtext.getString("ReqList_Remove")%></FONT></A></td>
										</tr>
<%
	    } //end of private lists

	    //My shared lists start
	    for (int i=0; i<requisitionListsSAll.length; i++) {
		
		String memberId=requisitionListsSAll[i].getMemberId();

		if (userRefNum.compareTo(new Long(memberId))==0) {

		  lastUpdate = requisitionListsSAll[i].getLastUpdateInEJBType();
		  if (lastUpdate==null) {
			formattedLastUpdate = "";
		  } else {
			// Format date appropriately from the TimeStampHelper. Allows date to be universal.
			formattedLastUpdate = TimestampHelper.getDateFromTimestamp(lastUpdate, jLocale);
		  }		  
		  String status=tooltechtext.getString("ReqList_Type2");
		  
										if (displaySwitch) out.println("<TR bgcolor='#ffffff'>");
										else out.println("<TR bgcolor='#BCCBDB'>");
		  displaySwitch =!displaySwitch;
%>
											<td><FONT class="p"><%= requisitionListsSAll[i].getStoreEntityId() %></FONT></td>
											<td><A href="RequisitionListUpdateView?<%= OrderConstants.EC_REQUISITION_LIST_ID %>=<%= requisitionListsSAll[i].getOrderId() %>&iPartNumber=<%=partNumber%>&iQuantity=<%=quantity%>"><FONT class="p"><%= requisitionListsSAll[i].getDescription() %></FONT></A></td>
<% if (jLocale.toString().equals("ja_JP")||jLocale.toString().equals("ko_KR")||jLocale.toString().equals("zh_CN")) { %>

											<td><FONT class="p"><%= bnRegUser.getLastName() %>&nbsp;<%= bnRegUser.getFirstName() %></FONT></td>
<% } else if (jLocale.toString().equals("zh_TW")) { %>
											<td><FONT class="p"><%= bnRegUser.getLastName() %><%= bnRegUser.getFirstName() %></FONT></td>
<% } else { %>

											<td><FONT class="p"><%= bnRegUser.getFirstName() %>&nbsp;<%= bnRegUser.getLastName() %></FONT></td>
<% } %>
											<td><FONT class="p"><%= formattedLastUpdate %></FONT></td>
											<td><FONT class="p"><%= status %></FONT></td>
											<td><A HREF="RequisitionListDelete?<%= ECConstants.EC_URL %>=RequisitionListView&<%= OrderConstants.EC_REQUISITION_LIST_ID %>=<%= requisitionListsSAll[i].getOrderId() %>"><FONT class="p"><%=tooltechtext.getString("ReqList_Remove")%></FONT></A></td>
										</tr>
<%
		} else {
		  requisitionListsSOther.add(requisitionListsSAll[i]); //Save this requisition list to display later
		}//endif
	    }//end of my shared lists	 

	    if  (requisitionListsType.equals("All")) {
	    	RequisitionDataBean reqDB = new RequisitionDataBean();
		
		//Other shared lists start
		for (int i=0;i<requisitionListsSOther.size();i++) {
			reqDB= (RequisitionDataBean) requisitionListsSOther.elementAt(i);
			String memberId=reqDB.getMemberId();
			String status=tooltechtext.getString("ReqList_Type2");

			lastUpdate = reqDB.getLastUpdateInEJBType();
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
											<td><FONT class="p"><%= reqDB.getStoreEntityId() %></FONT></td>
											<td><A href="RequisitionListDetailView?<%= OrderConstants.EC_REQUISITION_LIST_ID %>=<%=reqDB.getOrderId() %>"><FONT class="p"><%= reqDB.getDescription() %></FONT></A></td>
<% if (jLocale.toString().equals("ja_JP")||jLocale.toString().equals("ko_KR")||jLocale.toString().equals("zh_CN")) { %>

											<td><FONT class="p"><%= bnRegUser.getLastName() %>&nbsp;<%= bnRegUser.getFirstName() %></FONT></td>
<% } else if (jLocale.toString().equals("zh_TW")) { %>
											<td><FONT class="p"><%= bnRegUser.getLastName() %><%= bnRegUser.getFirstName() %></FONT></td>
<% } else { %>

											<td><FONT class="p"><%= bnRegUser.getFirstName() %>&nbsp;<%= bnRegUser.getLastName() %></FONT></td>
<% } %>
											<td><FONT class="p"><%= formattedLastUpdate %></FONT></td>
											<td><FONT class="p"><%= status %></FONT></td>
											<td>&nbsp;</td>
										</tr>
<%
			
	  	}//end of other's shared lists	 
	    }//endif
	}//endif
%>									</TABLE>
								</td>
							</TR>
						</TABLE>
						<P>
					</td>
				</TR>
			</TABLE>
		</td>
	</TR>
<%
if (empty) { //display message
%>
	<tr>
		<td><font color="red"><%=tooltechtext.getString("ReqList_Text1")%></font></td>
	</TR>
<%
} 
%>
</table>



<script language="javascript">
	function CreateNewReqList() {
		if (document.RequisitionListCreatForm.reqListStoreId.selectedIndex==0) {
			alert("<%=tooltechtext.getString("ReqList_NoSelectedStore")%>");
		}
		else {
			document.RequisitionListCreatForm.submit();
		}
	}
</script>



<table cellpadding="8" cellspacing="0" border="0">
	<tr>

		<form name="RequisitionListCreatForm" action="RequisitionListCreateView" method="post">

		<td>
			<b><label for="WC_RequisitionListDisplay_FormInput_reqListStoreId_2"><%= tooltechtext.getString("SupplierDropDown_SelectSupplier") %></label></b>
		</td>
		<td>
			<select name="reqListStoreId" id="WC_RequisitionListDisplay_FormInput_reqListStoreId_2">
				<option value=""><%= tooltechtext.getString("SupplierDropDown_AllSupplier") %></option>
				<%
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
	</tr>
	<tr>
		<td colspan="2">
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
							<a href="javascript:CreateNewReqList()" style="color:#ffffff; text-decoration : none;">
							<%=tooltechtext.getString("ReqList_Create")%>
							</a>
							</b></font>
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
		</td>
	</tr>
</table>
<!--content end-->

	</td>
</TR>
</TABLE>

</BODY>
</HTML>


