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
<%@ page import="com.ibm.commerce.common.beans.StoreDataBean" %>
<%@ page import="com.ibm.commerce.catalog.beans.CatalogDataBean" %>

<%@ include file="../../../include/EnvironmentSetup.jspf"%>



<jsp:useBean id="storeData" class="com.ibm.commerce.common.beans.StoreDataBean" scope="page">
<% com.ibm.commerce.beans.DataBeanManager.activate(storeData, request); %>
</jsp:useBean>


<%
try {
//Parameters may be encrypted. Use JSPHelper to get
//URL parameter instead of request.getParameter().
JSPHelper jhelper = new JSPHelper(request);

String languageId = jhelper.getParameter("langId");
String storeId = jhelper.getParameter("storeId");

CatalogDataBean Catalogs[] = sdb.getStoreCatalogs();
String catalogId = Catalogs[0].getCatalogId();

%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "DTD/xhtml1-transitional.dtd">
<html>
<HEAD>
	<TITLE><%= tooltechtext.getString("YourOrder_Title")%></TITLE>
	<LINK REL=stylesheet HREF="<%=fileDir%>ToolTech.css" TYPE="text/css">
</HEAD>


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

	<TD valign="top" width="630">

	<!--content start-->
		<TABLE CELLPADDING="5">
		<TR>
			<TD>
				<br>
				<P><%=tooltechtext.getString ("Order_Approval_Waiting")%><P>
			
				<TABLE border="0" cellspacing="0" cellpadding="0">
 
			
				<tr>
					<td>
						<table cellpadding="0" cellspacing="0" border="0">
						<tr>
							<td bgcolor="#ff2d2d" class="pixel"><img src="<%=jspStoreImgDir%>images/lb.gif" border="0"/></td>
							<td bgcolor="#ff2d2d" class="pixel"><img src="<%=jspStoreImgDir%>images/lb.gif" border="0"/></td>
							<td class="pixel"><img src="<%=jspStoreImgDir%>images/r_top.gif" border="0"/></td>
						</tr>
						<tr>
							<td bgcolor="#ff2d2d"><img alt="" src="<%=jspStoreImgDir%>images/lb.gif" border="0"/></td>
							<td bgcolor="#ea2b2b">
								<table cellpadding="2" cellspacing="0" border="0">
								<tr>
									<td class="buttontext">
										<font color="#ffffff"><b>
										<a href="TopCategoriesDisplay?langId=<%=languageId%>&catalogId=<%=catalogId%>&storeId=<%=storeId%>" style="color:#ffffff; text-decoration : none;">
										<%=tooltechtext.getString ("Home_Button1")%>
										</a>
										</b></font>
									</td>
								</tr>
								</table>
							</td>
							<td bgcolor="#7a1616"><img alt="" src="<%=jspStoreImgDir%>images/db.gif" border="0"/></td>
						</tr>	
						<tr>
							<td class="pixel"><img src="<%=jspStoreImgDir%>images/l_bot.gif"/></td>
							<td bgcolor="#7a1616" class="pixel" valign="top"><img src="<%=jspStoreImgDir%>images/db.gif" border="0"/></td>
							<td bgcolor="#7a1616" class="pixel" valign="top"><img src="<%=jspStoreImgDir%>images/db.gif" border="0"/></td>
						</tr>
						</table>
	  				</td>
	  			</TR>
	  			</TABLE>
			</TD>
		</TR>
		</TABLE>

	
	<!--content end-->
	</TD>
</TR>
</TABLE>

</BODY>
</HTML>

<%} catch (Exception e) {
out.println(e);
}
%>	