<%
/* 
 *-------------------------------------------------------------------
 * Licensed Materials - Property of IBM
 *
 * WebSphere Commerce
 *
 * (c) Copyright International Business Machines Corporation. yyyy, 2003
 *     All rights reserved.
 *
 * US Government Users Restricted Rights - Use, duplication or
 * disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
 *
 *-------------------------------------------------------------------
 */
 ////////////////////////////////////////////////////////////////////
 //
 // Change History:
 //
 // YYMMDD      F/D#        WHO        Description
 // -----------------------------------------------------------------
 // Nov 2,2002              XL         Initial
 ////////////////////////////////////////////////////////////////////
%>

<% // All JSPs requires the first 4 packages for EnvironmentSetup.jsp which is used for multi language support %> 
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.ibm.commerce.command.*" %>
<%@ page import="com.ibm.commerce.server.*" %>

<%@ include file="../../../include/EnvironmentSetup.jspf"%>
<%@ include file="../../../include/CacheParametersSetup.jspf" %>

<%
	//Parameters may be encrypted. Use JSPHelper to get URL parameters instead of request.getParameter()
	JSPHelper jspHelper = new JSPHelper(request);

	String storeId   = jspHelper.getParameter("storeId");
	String langId    = jspHelper.getParameter("langId");

	String catalogId = sdb.getStoreCatalogs()[0].getCatalogId();
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "DTD/xhtml1-transitional.dtd">

<%
boolean approved = !userType.equalsIgnoreCase("G");
if(approved) {
%>

<HTML>
	<HEAD>
		<META HTTP-EQUIV=Refresh CONTENT="0;URL=StoreCatalogDisplay?storeId=<%= storeId %>&langId=<%= langId %>&catalogId=<%= catalogId %>"/>
	</HEAD>
</HTML>

<% } else { //if(approved) %>

<HTML>
<HEAD>
	<TITLE><%=tooltechtext.getString("UsrReg_Title")%></TITLE>
	<link rel="stylesheet" href="<%=fileDir%>ToolTech.css" type="text/css">
</head>
<body marginheight="0" marginwidth="0" leftmargin="0" topmargin="0" onload="if (typeof top.updateStInfo == 'function') top.updateStInfo();">

<%
String incfile;
incfile = includeDir + "HeaderDisplay.jsp";
%>
<jsp:include page="<%=incfile%>" flush="true"/>  


<table cellpadding="0" cellspacing="0" border="0" height="99%" width="790">
<tr>
	<td valign="top" bgcolor="#4c6178" width="160"> 
		<%
		incfile = includeDir + "SidebarDisplay.jsp";
		%>
		<jsp:include page="<%=incfile%>" flush="true"/>  

	</td>

	<td valign="top" width="630">
<!--MAIN CONTENT STARTS HERE-->

<TABLE BORDER="0" WIDTH="630" ALIGN="center" CELLPADDING="2" CELLSPACING="4">
<TR>
	<flow:ifEnabled  feature="customerCare">
	<TD>
		<TABLE BORDER="0" WIDTH="200" CELLPADDING="0" CELLSPACING="4">
		<tr><td>&nbsp;</td></tr>
		<tr><td>&nbsp;</td></tr>
		<%
		//Link for Live Help
		if (com.ibm.commerce.collaboration.livehelp.beans.LiveHelpShopperConfiguration.isEnabled()) {%>

		<tr> 
			<td width="42">
				<a href="javascript:if((parent.sametime != null)) top.interact();">
				<IMG SRC="<%=jspStoreImgDir%>images/LiveHelp.gif" WIDTH="42" HEIGHT="39" BORDER="0" ALT=""> 
				</a>
			</td>
			<td>
				<a href="javascript:if((parent.sametime != null)) top.interact();">
				<%= tooltechtext.getString("LiveHelp")%>
				</a>
			</td>
		</tr>
		<%} else  {%>
			<tr><td>&nbsp;</td></tr>
		<% } %>
		<tr><td>&nbsp;</td></tr>
		<tr><td>&nbsp;</td></tr>
		<tr><td>&nbsp;</td></tr>
		<tr><td>&nbsp;</td></tr>
		<tr><td>&nbsp;</td></tr>
		<tr><td>&nbsp;</td></tr>
		<tr><td>&nbsp;</td></tr>
		<tr><td>&nbsp;</td></tr>
		<tr><td>&nbsp;</td></tr>
		<tr><td>&nbsp;</td></tr>
		<tr><td>&nbsp;</td></tr>
		<tr><td>&nbsp;</td></tr>
		<tr><td>&nbsp;</td></tr>
		<tr><td>&nbsp;</td></tr>
		<tr><td>&nbsp;</td></tr>
		<tr><td>&nbsp;</td></tr>
		<tr><td>&nbsp;</td></tr>
		<tr><td>&nbsp;</td></tr>
		<tr><td>&nbsp;</td></tr>
		<tr><td>&nbsp;</td></tr>
		<tr><td>&nbsp;</td></tr>
		<tr><td>&nbsp;</td></tr>
		<tr><td>&nbsp;</td></tr>
		<tr><td>&nbsp;</td></tr>
		<tr><td>&nbsp;</td></tr>
		<tr><td>&nbsp;</td></tr>
		<tr><td>&nbsp;</td></tr>
		<tr><td>&nbsp;</td></tr>
		<tr><td>&nbsp;</td></tr>
		<tr><td>&nbsp;</td></tr>
		</TABLE>
	</TD>
	</flow:ifEnabled>
	
	
<td>


<p>
<p>
</td>
<td>
<center><font class="text"><%=tooltechtext.getString("UsrReg_Approval")%></font></center>

</td>
	<flow:ifEnabled  feature="customerCare">
	<td>
	<table border="0" width="80" cellpadding="2" cellspacing="4">
		<tr>
			<td>
			&nbsp;
			</td>
		</tr>
	</table>
	</td>
	</flow:ifEnabled>	
</tr>
</table>

</td>
</tr>
</table>

</body>
</html>

<% } //if(approved) %>
