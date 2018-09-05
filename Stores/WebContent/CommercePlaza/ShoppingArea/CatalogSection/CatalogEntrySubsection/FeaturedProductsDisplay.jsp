<%
//********************************************************************
//*-------------------------------------------------------------------
//* Licensed Materials - Property of IBM
//*
//* WebSphere Commerce
//*
//* (c) Copyright International Business Machines Corporation. 2003
//*     All rights reserved.
//*
//* US Government Users Restricted Rights - Use, duplication or
//* disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
//*
//*-------------------------------------------------------------------
//*
%>


<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.ibm.commerce.server.*" %>
<%@ page import="com.ibm.commerce.command.*" %>
<%@ page import="com.ibm.commerce.catalog.beans.*" %>
<%@ page import="com.ibm.commerce.catalog.objects.*" %>
<%@ page import="com.ibm.commerce.beans.*" %>
<%@ page import="com.ibm.commerce.user.beans.*" %>
<%@ page import="com.ibm.commerce.payment.beans.*" %>

<%@ include file="../../../include/EnvironmentSetup.jsp"%>

<%
String parentCategoryId = jhelper.getParameter("parent_category_rn");

request.setAttribute("pageName", "CommercePlazaCatalog");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title><%=storeText.getString("FeaturedProductsDisplay_Title")%></title>
	<link rel=stylesheet href="<%=fileDir%>PCDMarket.css" type="text/css">
</head>


<body marginheight="0" marginwidth="0" leftmargin="0" topmargin="0">

<%@ include file="../../../include/HeaderDisplay.jspf"%>

<!-- Start Main Table - Consists of TD for Left Bar, TD for Content and TD for Quicklinks -->
<table border="0" cellpadding="0" cellspacing="0" width="750">
<tr>
  <td valign="top" class="mbg" width="150">
    <%
     String incfile = includeDir + "SidebarDisplay.jsp";
    %>
    <jsp:include page="<%=incfile%>" flush="true"/></td>

   <!--begin td-->

	<td valign="top" width="10">&nbsp;</td>

	<td valign="top" width="590">

	<table width="590" border="0" cellspacing="0" cellpadding="0">
         <tbody>
           <tr>
             <td width="590" colspan="2"><a name="mainContent"></a>
              <span class="bct">&nbsp;&nbsp;&nbsp;</span>
		  <a class="bctl" href="StoreCatalogDisplay?storeId=<%=storeId%>&catalogId=<%=catalogId%>&langId=<%=languageId%>"><%=storeText.getString("Breadcrumb_CommercePlaza")%></a>
		  <span class="bct">&nbsp;&nbsp;&nbsp;&gt;&nbsp;&nbsp;&nbsp;</span>
		  <span class="bct"><%=storeText.getString("Breadcrumb_SelectItems")%></span>
             </td>
	     </tr>
           <tr>
             <td valign="top" width="310">
               <div align="left" class="title"><%=storeText.getString("QuickLinks_Featured")%></div></td>
             <td valign="top" width="280">
              <div align="right">
              <img src="<%=fileDir%>images/hdr_products.gif" width="280" height="72" alt="<%=storeText.getString("QuickLinks_Featured")%>"></div></td>
   	    </tr>
   	   <tr>
	     <td width="590" colspan="2">&nbsp;</td></tr>
	   </tbody></table>

<table cellspacing="0" cellpadding="0" width="590" border="0">
<tbody>

	<!--START PROMO -->
	<jsp:include page="../../../include/FeaturedProductsProductESpot.jsp" flush="true">
		<jsp:param name="emsName" value="FeaturedProductsPage" />
		<jsp:param name="catalogId" value="<%= catalogId %>" />
	</jsp:include>
	<!--END PROMO -->

</tbody></table>

  <!--END MAIN CONTENT-->

  </td>

  <!-- End of Main Content TD -->

</tr></tbody></table>

<!-- End Main Table -->

<%@ include file="../../../include/FooterDisplay.jspf"%>

</body>
</html>
