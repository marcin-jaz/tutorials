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

<% // All JSPs requires these packages for getResource.jsp which is used for multi language support %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.ibm.commerce.server.ECConstants" %>
<%@ page import="com.ibm.commerce.server.JSPHelper" %>
<%@ page import="com.ibm.commerce.server.JSPResourceBundle" %>
<%@ page import="com.ibm.commerce.command.CommandContext" %>

<% // Page specific imports%>
<%@ page import="com.ibm.commerce.beans.DataBeanManager" %>
<%@ page import="com.ibm.commerce.beans.ErrorDataBean" %>
<%@ page import="com.ibm.commerce.common.beans.StoreDataBean" %>
<%@ page import="com.ibm.commerce.contract.objects.TradingAgreementAccessBean" %>
<%@ page import="com.ibm.commerce.contract.objects.AttachmentAccessBean" %>
<%@ page import="com.ibm.commerce.catalog.beans.CatalogDataBean" %>
<%@ page import="com.ibm.commerce.user.beans.UserRegistrationDataBean" %>
<%@ page import="com.ibm.commerce.user.beans.RoleDataBean" %>

<%@ page import="com.ibm.commerce.payment.beans.AccountDataBean" %>
<%@ taglib uri="flow.tld" prefix="flow" %>

<%@ include file="EnvironmentSetup.jspf"%>

<%
// ??? What is this  shouldn't it call JSPHelper.getParameter ????
String storeId = request.getParameter("storeId");
if (storeId == null) {
	storeId = sessionStoreId;
}
%>
<jsp:useBean id="sdbHeader" class="com.ibm.commerce.common.beans.StoreDataBean">
	<jsp:setProperty property="storeId" name="sdbHeader" value="<%= storeId %>" />
	<% com.ibm.commerce.beans.DataBeanManager.activate(sdbHeader, request); %>
</jsp:useBean>

<%
try {
    //Parameters may be encrypted. Use JSPHelper to get URL parameter instead of request.getParameter().
    JSPHelper jhelper = new JSPHelper(request);

    String languageId = cmdcontext.getLanguageId().toString();
    String cmpCategoryId = jhelper.getParameter("categoryId");
    String inFrame  = jhelper.getParameter("inFrame");
    String navState = jhelper.getParameter("navState");
    String userType = jhelper.getParameter("userType");
    String userState = jhelper.getParameter("userState");
    String rfqLinkDisplayed = jhelper.getParameter("rfqLinkDisplayed");

    CatalogDataBean Catalogs[] = sdbHeader.getStoreCatalogs();
    String catalogId = Catalogs[0].getCatalogId();

    if (cmpCategoryId == null) cmpCategoryId = "";
    if (userState == null) userState = "";

    %>

    <jsp:useBean id="userRegistrationDataBean" class="com.ibm.commerce.user.beans.UserRegistrationDataBean" scope="page">
    	<%
    	userRegistrationDataBean.setCommandContext(cmdcontext);
    	DataBeanManager.activate(userRegistrationDataBean, request); 
    	%>
    </jsp:useBean>
<%
    TradingAgreementAccessBean[] currentTradingACBean = cmdcontext.getCurrentTradingAgreements();
    String attachmentURL = "";
    String accountId = "";
    if (currentTradingACBean != null) {

    	accountId = (currentTradingACBean[currentTradingACBean.length-1].getAccountId());

    	if (accountId != "")
    	{
    		AccountDataBean dbAccount = new AccountDataBean();
    		dbAccount.setDataBeanKeyAccountId(accountId);
    		com.ibm.commerce.beans.DataBeanManager.activate(dbAccount, request);
    		AttachmentAccessBean abAttachment = dbAccount.getDisplayCustomizationTCAttachment();

    	if (abAttachment != null)
    		attachmentURL = fileDir + abAttachment.getAttachmentURL();
    	}
    }
%>

<!--START HEADER-->
<table cellpadding="0" cellspacing="0" border="0" width="100%">
	<tr>
		<td>
			<table  cellpadding="0" cellspacing="0" border="0">
			<tr>
				<td width="1%"><img alt="<%=storeName.trim()%>" src="<%=fileDir%>images/logo.gif" border=0></td>
				<td width="97%"><FONT FACE="Verdana" STYLE="font-size : 17pt; color : #32404F;" ><%=storeName.trim()%></font></td>
				<td width="1%">
					<% if (attachmentURL != "") {%>
					<img height=42 alt="" src="<%=attachmentURL%>" width=42 border=0>
					<% } %>
					&nbsp;
				</td>
				<td width="1%" ALIGN="right"><img height=60 alt="" src="<%=fileDir%>images/right_banner.gif" width=321 border=0></td>
			</tr>
			</table>
		</td>

	</tr>

<%
	if (inFrame == null || (navState == null || !navState.equals("admin") )) {
		if (navState != null && navState.equals("admin")) {
%>
	<tr>
		<td background="<%=fileDir%>images/row1_tile.gif">
				<table cellpadding="0" cellspacing="0" border="0" width="100%" height="28">
					<tr>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td align="right"><br>
						</td>
					</tr>
				</table>
		</td>
	</tr>
	<tr>
		<td background="<%=fileDir%>images/row2_tile.gif">
				<table cellpadding="0" cellspacing="0" border="0" width="100%" height="32">
					<tr>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td align="right"><br>
						</td>
					</tr>
				</table>
		</td>
	</td>
<%
		}
		else if (userType.equals("G")) {
%>
	<tr>
		<td background="<%=fileDir%>images/row1_tile.gif">
				<table cellpadding="0" cellspacing="0" border="0" width="100%" height="28">
					<tr>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td align="right">
							<table cellpadding="0" cellspacing="0" border="0">
								<tr>
									<td background="<%=fileDir%>images/row1_butbk.gif"><img src="<%=fileDir%>images/row1_dots.gif" width="3" height="28" border="0" alt=""></td>
									<td background="<%=fileDir%>images/row1_butbk.gif"><img src="<%=fileDir%>images/trans.gif" width="7" height="2" border="0" alt=""></td>
									<td background="<%=fileDir%>images/row1_butbk.gif" nowrap><a href="LogonForm?langId=<%=languageId%>&storeId=<%=storeId%>&catalogId=<%=catalogId%>" class="nav" target="_top"><font face="Verdana" color="#ffffff" size="-1"><%=tooltechtext.getString("Logon_Title")%></font></a></td>
									<td background="<%=fileDir%>images/row1_butbk.gif"><img src="<%=fileDir%>images/trans.gif" width="7" height="2" border="0" alt=""></td>
									<td background="<%=fileDir%>images/row1_butbk.gif"><img src="<%=fileDir%>images/row1_dots.gif" width="3" height="28" border="0" alt=""></td>
									<td>&nbsp;&nbsp;</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
		</td>
	</tr>
	<tr>
		<td background="<%=fileDir%>images/row2_tile.gif">
				<table cellpadding="0" cellspacing="0" border="0" width="100%" height="32">
					<tr>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td align="right"><br>
						</td>
					</tr>
				</table>
		</td>
	</td>
<%
		} else if (userState.equals("0")) {
			//Pending State : Account, & Loggoff
%>
	<tr>
		<td background="<%=fileDir%>images/row1_tile.gif">
				<table cellpadding="0" cellspacing="0" border="0" width="100%" height="28">
					<tr>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td align="right">
							<table cellpadding="0" cellspacing="0" border="0">
								<tr>
									<td background="<%=fileDir%>images/row1_butbk.gif"><img src="<%=fileDir%>images/row1_dots.gif" width="3" height="28" border="0" alt=""></td>
									<td background="<%=fileDir%>images/row1_butbk.gif"><img src="<%=fileDir%>images/trans.gif" width="7" height="2" border="0" alt=""></td>
									<td background="<%=fileDir%>images/row1_butbk.gif" nowrap><a href="LogonForm?langId=<%=languageId%>&storeId=<%=storeId%>&catalogId=<%=catalogId%>&page=account" class="nav" target="_top"><font face="Verdana" color="#ffffff" size="-1"><%=tooltechtext.getString("Header_Account")%></font></a></td>
									<td background="<%=fileDir%>images/row1_butbk.gif"><img src="<%=fileDir%>images/trans.gif" width="7" height="2" border="0" alt=""></td>
									<td background="<%=fileDir%>images/row1_butbk.gif"><img src="<%=fileDir%>images/row1_dots.gif" width="3" height="28" border="0" alt=""></td>
									<td>&nbsp;&nbsp;</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
		</td>
	</tr>
	<tr>
		<td background="<%=fileDir%>images/row2_tile.gif">
				<table cellpadding="0" cellspacing="0" border="0" width="100%" height="32">
					<tr>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td align="right">
							<table  cellpadding="0" cellspacing="0" border="0">
								<tr>
									<td background="<%=fileDir%>images/row2_butbk.gif"><img src="<%=fileDir%>images/row2_dots.gif" width="3" height="32" border="0" alt=""></td>
									<td background="<%=fileDir%>images/row2_butbk.gif"><img src="<%=fileDir%>images/trans.gif" width="7" height="2" border="0" alt=""></td>
									<td background="<%=fileDir%>images/row2_butbk.gif" nowrap><a href="Logoff?storeId=<%=storeId%>&langId=<%=languageId%>&catalogId=<%=catalogId%>" class="nav" target="_top"><font face="Verdana" color="#ffffff" size="-1"><%=tooltechtext.getString("Header_Logoff")%></font></a></td>
									<td background="<%=fileDir%>images/row2_butbk.gif"><img src="<%=fileDir%>images/trans.gif" width="7" height="2" border="0" alt=""></td>
									<td background="<%=fileDir%>images/row2_butbk.gif"><img src="<%=fileDir%>images/row2_dots.gif" width="3" height="32" border="0" alt=""></td>
									<td background="<%=fileDir%>images/row2_tile.gif">&nbsp;&nbsp;</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
		</td>
	</td>
<%
		} else {
			//Full Navbar
%>
	<tr>
		<td background="<%=fileDir%>images/row1_tile.gif">
				<table cellpadding="0" cellspacing="0" border="0" width="100%" height="28">
					<tr>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td align="right">
							<table cellpadding="0" cellspacing="0" border="0">
								<tr>
									<td background="<%=fileDir%>images/row1_butbk.gif"><img src="<%=fileDir%>images/row1_dots.gif" width="3" height="28" border="0" alt=""></td>
									<td background="<%=fileDir%>images/row1_butbk.gif"><img src="<%=fileDir%>images/trans.gif" width="7" height="2" border="0" alt=""></td>
									<td background="<%=fileDir%>images/row1_butbk.gif" nowrap><a href="StoreCatalogDisplay?langId=<%=languageId%>&storeId=<%=storeId%>&catalogId=<%=catalogId%>" class="nav" target="_top"><font face="Verdana" color="#ffffff" size="-1"><%=tooltechtext.getString("Header_Home")%></font></a></td>
									<td background="<%=fileDir%>images/row1_butbk.gif"><img height="28" alt="" src="<%=fileDir%>images/line_spacer.gif" width="16" border="0"></td>
									<td background="<%=fileDir%>images/row1_butbk.gif" nowrap><a href="TopCategoriesDisplay?langId=<%=languageId%>&storeId=<%=storeId%>&catalogId=<%=catalogId%>" class="nav" target="_top"><font face="Verdana" color="#ffffff" size="-1"><%=tooltechtext.getString("Header_Catalog")%></font></a></td>
									<td background="<%=fileDir%>images/row1_butbk.gif"><img height="28" alt="" src="<%=fileDir%>images/line_spacer.gif" width="16" border="0"></td>
									<td background="<%=fileDir%>images/row1_butbk.gif" nowrap><a href="AuctionHomeView?langId=<%=languageId%>&storeId=<%=storeId%>&catalogId=<%=catalogId%>" class="nav" target="_top"><font face="Verdana" color="#ffffff" size="-1"><%=tooltechtext.getString("Header_Auction")%></font></a></td>
									<td background="<%=fileDir%>images/row1_butbk.gif"><img height="28" alt="" src="<%=fileDir%>images/line_spacer.gif" width="16" border="0"></td>
									<td background="<%=fileDir%>images/row1_butbk.gif" nowrap><a href="LogonForm?langId=<%=languageId%>&storeId=<%=storeId%>&catalogId=<%=catalogId%>&page=account" class="nav" target="_top"><font face="Verdana" color="#ffffff" size="-1"><%=tooltechtext.getString("Header_Account")%></font></a></td>
									<flow:ifEnabled feature="collaborativeWorkspaces">
										<td background="<%=fileDir%>images/row1_butbk.gif"><img height="28" alt="" src="<%=fileDir%>images/line_spacer.gif" width="16" border="0"></td>
										<td background="<%=fileDir%>images/row1_butbk.gif" nowrap><a href="StoreCollabListDisplay?langId=<%=languageId%>&storeId=<%=storeId%>&catalogId=<%=catalogId%>" class="nav" target="_top"><font face="Verdana" color="#ffffff" size="-1"><%=tooltechtext.getString("Collab_Title")%></font></a></td>
									</flow:ifEnabled>
									<td background="<%=fileDir%>images/row1_butbk.gif"><img height="28" alt="" src="<%=fileDir%>images/line_spacer.gif" width="16" border="0"></td>
									<td background="<%=fileDir%>images/row1_butbk.gif" nowrap><a href="RequisitionListDisplay?langId=<%=languageId%>&storeId=<%=storeId%>" class="nav" target="_top"><font face="Verdana" color="#ffffff" size="-1"><%=tooltechtext.getString("Header_RequisitionList")%></font></a></td>
									<td background="<%=fileDir%>images/row1_butbk.gif"><img src="<%=fileDir%>images/trans.gif" width="7" height="2" border="0" alt=""></td>
									<td background="<%=fileDir%>images/row1_butbk.gif"><img src="<%=fileDir%>images/row1_dots.gif" width="3" height="28" border="0" alt=""></td>
									<td>&nbsp;&nbsp;</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
		</td>
	</tr>
	<tr>
		<td background="<%=fileDir%>images/row2_tile.gif">
				<table cellpadding="0" cellspacing="0" border="0" width="100%" height="32">
					<tr>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td align="right">
							<table  cellpadding="0" cellspacing="0" border="0">
								<tr>
									<td background="<%=fileDir%>images/row2_butbk.gif"><img src="<%=fileDir%>images/row2_dots.gif" width="3" height="32" border="0" alt=""></td>
									<td background="<%=fileDir%>images/row2_butbk.gif"><img src="<%=fileDir%>images/trans.gif" width="7" height="2" border="0" alt=""></td>
						            <%
						            if (rfqLinkDisplayed!=null && rfqLinkDisplayed.equalsIgnoreCase("true"))  {
						            %>
										<td background="<%=fileDir%>images/row2_butbk.gif" nowrap><A HREF="RFQListDisplay?langId=<%=languageId%>&storeId=<%=storeId%>&catalogId=<%=catalogId%>" class="nav"><font face="Verdana" color="#ffffff" size="-1"><%=tooltechtext.getString("RFQ_List")%></font></a></td>
										<td background="<%=fileDir%>images/row2_butbk.gif"><img height=32 alt="" src="<%=fileDir%>images/line2_spacer.gif" width="16" border="0"></td>
						            <%
						            }
						            %>									
									<td background="<%=fileDir%>images/row2_butbk.gif" nowrap><a href="OrderList?langId=<%=languageId%>&storeId=<%=storeId%>&catalogId=<%=catalogId%>&status=P" class="nav" target="_top"><font face="Verdana" color="#ffffff" size="-1"><%=tooltechtext.getString("Header_ListPendingOrder")%></font></a></td>
									<td background="<%=fileDir%>images/row2_butbk.gif"><img height=32 alt="" src="<%=fileDir%>images/line2_spacer.gif" width="16" border="0"></td>
									<td background="<%=fileDir%>images/row2_butbk.gif" nowrap><a href="TrackOrderStatus" class="nav" target="_top"><font face="Verdana" color="#ffffff" size="-1"><%=tooltechtext.getString("Header_OrderHistory")%></font></a></td>
									<td background="<%=fileDir%>images/row2_butbk.gif"><img height=32 alt="" src="<%=fileDir%>images/line2_spacer.gif" width="16" border="0"></td>
									<td background="<%=fileDir%>images/row2_butbk.gif" nowrap><a href="Logoff?storeId=<%=storeId%>&langId=<%=languageId%>&catalogId=<%=catalogId%>" class="nav" target="_top"><font face="Verdana" color="#ffffff" size="-1"><%=tooltechtext.getString("Header_Logoff")%></font></a></td>
									<td background="<%=fileDir%>images/row2_butbk.gif"><img src="<%=fileDir%>images/trans.gif" width="7" height="2" border="0" alt=""></td>
									<td background="<%=fileDir%>images/row2_butbk.gif"><img src="<%=fileDir%>images/row2_dots.gif" width="3" height="32" border="0" alt=""></td>
									<td background="<%=fileDir%>images/row2_tile.gif">&nbsp;&nbsp;</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
		</td>
	</td>
<%
		}
%>
<%
	}
%>
</table>




<flow:ifEnabled feature="customerCare">
<%
String incHeader;
incHeader = includeDir + "CustomerCareHeaderSetup.jsp";
%>
<jsp:include page="<%=incHeader%>" flush="true"/>
</flow:ifEnabled>

<!--END HEADER-->
<%
}
catch (Exception e) {
    out.println(e);
}
%>
