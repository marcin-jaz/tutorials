<%
//********************************************************************
//*-------------------------------------------------------------------
//* Licensed Materials - Property of IBM
//*
//* 5697-D24
//*
//* (c) Copyright IBM Corp. 2000, 2002
//*
//* US Government Users Restricted Rights - Use, duplication or
//* disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
//*
//*-------------------------------------------------------------------
//********************************************************************
%>



<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="javax.servlet.*" %>

<%@ page import="com.ibm.commerce.server.*" %>
<%@ page import="com.ibm.commerce.command.*" %>
<%@ page import="com.ibm.commerce.order.beans.*" %>
<%@ page import="com.ibm.commerce.order.objects.*" %>
<%@ page import="com.ibm.commerce.beans.*" %>
<%@ page import="com.ibm.commerce.catalog.beans.*" %>
<%@ page import="com.ibm.commerce.catalog.objects.*" %>
<%@ page import="com.ibm.commerce.command.CommandContext" %>
<%@ page import="com.ibm.commerce.user.objects.*" %>
<%@ page import="java.math.*" %>
<%@ page import="com.ibm.commerce.common.beans.*" %>
<%@ page import="com.ibm.commerce.payment.beans.*" %>
<%@ page import="com.ibm.etill.framework.clientapi.PaymentCommandConstants" %>
<%@ page import="com.ibm.commerce.ras.*" %>
<%@ page import="com.ibm.commerce.exception.*"  %>
<%@ page import="com.ibm.commerce.contract.beans.*" %>
<%@ page import="com.ibm.commerce.contract.objects.*" %>
<%@ page import="com.ibm.commerce.catalog.common.ECCatalogConstants" %>

<%@ include file="../../../include/EnvironmentSetup.jsp"%>

<% response.setContentType(storeText.getString("ENCODESTATEMENT")); %>

<%
CatalogDataBean Catalogs[] = sdb.getStoreCatalogs();
catalogId = Catalogs[0].getCatalogId();

request.setAttribute("pageName", "CurrentShoppingCart");

%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "DTD/xhtml1-transitional.dtd">

<head>
<title><%=storeText.getString("EmptyShopCartDisplay_Title")%></title>
<link rel=stylesheet href="<%=fileDir%>PCDMarket.css" type="text/css">
</head>


<BODY MARGINHEIGHT="0" MARGINWIDTH="0" LEFTMARGIN="0" TOPMARGIN="0">

<%@ include file="../../../include/HeaderDisplay.jspf"%>

<!-- Start Main Table - Consists of TD for Left Bar, TD for Content -->
<table border="0" cellpadding="0" cellspacing="0" width="750">
	<tr>
		<td valign="top" CLASS="dbg" width="150">
		<%
		String incfile = includeDir + "SidebarDisplay.jsp";
		%>
		<jsp:include page="<%=incfile%>" flush="true"/>
		</td>

		<!-- Start of Main Content TD -->
		<td valign="top" width="600"><a name="mainContent"></a>
				<table width="600" border="0" cellspacing="0" cellpadding="0">
				  <tr>
				    <td><span class="bct">&nbsp;&nbsp;&nbsp;</span>
					<a class="bctl" href="StoreCatalogDisplay?storeId=<%=storeId%>&catalogId=<%=catalogId%>&langId=<%=languageId%>"><%=storeText.getString("Breadcrumb_CommercePlaza")%></a><span class="bct">&nbsp;&nbsp;&nbsp;&gt;&nbsp;&nbsp;&nbsp;</span>
					<font class="bct"><%=storeText.getString("Breadcrumb_ShopCart")%></font>
				    </td></tr>
				   <tr>
				    <td valign="top" width="320">
				      <div align="left"><span class="title"><%=storeText.getString("EmptyShopCartDisplay_Title")%></span></div></td>
				    <td valign="top" width="280">
				      <div align="right">
				      <img src="<%=fileDir%>images/hdr_cart.gif" width="280" height="72" alt="<%=storeText.getString("EmptyShopCartDisplay_Title")%>"></div></td>
				  </tr>
				  <tr>
				    <td width="600" colspan="2">&nbsp;</td></tr>
		  		</tbody></table>
					
				<table width="600" border="0" cellspacing="0" cellpadding="0">									
					<tr><td>&nbsp;</td></tr>
					<tr valign="top">
						<td><%=storeText.getString("EmptyShopCartDisplay_NoCart")%></td></tr></table>
													
		</td>
		<!-- End of Main Content TD -->
	</tr>
</table>

<!-- End Main Table -->
<%@ include file="../../../include/FooterDisplay.jspf"%>
</body>
</html>


