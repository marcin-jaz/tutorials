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
<%@ page import="com.ibm.commerce.beans.*" %>
<%@ page import="com.ibm.commerce.catalog.objects.*" %>
<%@ page import="com.ibm.commerce.user.beans.*" %>


<%@ include file="../../../include/EnvironmentSetup.jsp"%>


<jsp:useBean id="catalog" class="com.ibm.commerce.catalog.beans.CatalogDataBean" scope="page">
<%
//catalog.setCatalogId(catalogId);
DataBeanManager.activate(catalog, request);
%>
</jsp:useBean>

<%
CategoryDataBean topCategories[] = catalog.getTopCategories();
CategoryDataBean tcategory;
String tcategoryId;

request.setAttribute("pageName", "StoreCatalogDisplay");

%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title><%=storeText.getString("StoreCatalogDisplay_Title")%></title>
	<link rel="stylesheet" href="<%=fileDir%>PCDMarket.css" type="text/css" />

</head>


<body marginheight="0" marginwidth="0" leftmargin="0" topmargin="0">

<%@ include file="../../../include/HeaderDisplay.jspf"%>

<!-- Start Main Table - Consists of TD for Left Bar, TD for Content and TD for Quicklinks -->
<table border="0" cellpadding="0" cellspacing="0" width="750">
  <tbody><tr>
    <td valign="top" class="dbg" width="150">
      <%
      String incfile = includeDir + "SidebarDisplay.jsp";
      %>
      <jsp:include page="<%=incfile%>" flush="true"/></td>
    <!-- End  Left Nav Bar TD -->

    <!-- Begin Main Content TD -->
    <td width="10"><a name="mainContent"></a><spacer type="horizontal" size="10"></spacer><br /></td>
    <td valign="top" width="590">

    <!--MAIN CONTENT STARTS HERE-->

		<!-- Start Main JSP Content -->

		<table width="590" border="0" cellspacing="0" cellpadding="0">
  		<tbody>
  		  <tr>
		    <td colspan="2">
		        <span class="bct">&nbsp;&nbsp;&nbsp;</span>
     			<a class="bctl" href="StoreCatalogDisplay?storeId=<%=storeId%>&amp;catalogId=<%=catalogId%>&amp;langId=<%=languageId%>"><%=storeText.getString("Breadcrumb_CommercePlaza")%></a><span class="bct">&nbsp;&nbsp;&nbsp;&gt;&nbsp;&nbsp;&nbsp;</span>
			<span class="bct"><%=storeText.getString("Breadcrumb_CommercePlaza")%></span>
			</td></tr>
		  <tr>
		    <td valign="top" width="320">
		      <div align="left" class="title"><%=storeText.getString("StoreCatalogDisplay_SubTitle")%></div></td>
		    <td valign="top" width="280">
		      <div align="right">
		        <img src="<%=fileDir%>images/hdr_products.gif" width="280" height="72" alt='<%=storeText.getString("StoreCatalogDisplay_SubTitle")%>' /></div></td>
		  </tr>
		  </tbody></table>

		<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tbody>
		  <tr>
       		<td valign="top" width="250">
		      <table width="250" cellspacing="0" cellpadding="0">
		      <tbody>
		        <tr>
		          <td class="tblue" height="20">&nbsp;<%=storeText.getString("StoreCatalogDisplay_WhatWouldYouLike")%></td></tr>
		        <tr>
		          <td>&nbsp;</td></tr>
			<tr>
			  <td class="catalog"><a href="FavoritesListDisplayView?storeId=<%=storeId%>&amp;catalogId=<%=catalogId%>&amp;langId=<%=languageId%>"><%=storeText.getString("StoreCatalogDisplay_ViewFavorites")%></a></td></tr>
			<tr>
			  <td class="catalog"><a href="FavoritesListCreateFormView?storeId=<%=storeId%>&amp;catalogId=<%=catalogId%>&amp;langId=<%=languageId%>"><%=storeText.getString("StoreCatalogDisplay_CreateFavorites")%></a></td></tr>
		        <tr>
			  <td class="catalog"><a href="UserRegistrationModifyFormView?storeId=<%=storeId%>&amp;catalogId=<%=catalogId%>&amp;langId=<%=languageId%>"><%=storeText.getString("StoreCatalogDisplay_UpdateAccount")%></a></td></tr>
			</tbody></table>

	</td>
		<td valign="top" width="10">&nbsp;</td>
		    <td valign="top" width="170">

		       <table width="170" cellspacing="0" cellpadding="0">
		         <tbody>

			<!--START PROMO -->
			<jsp:include page="../../../include/StoreCatalogProductESpot.jsp" flush="true">
				<jsp:param name="emsName" value="FeaturedProductsPage" />
				<jsp:param name="catalogId" value="<%= catalogId %>" />
			</jsp:include>
			<!--END PROMO -->

			</tbody></table></td>
		    <td valign="top" width="10">&nbsp;</td>

		    <!-- Begin QuickLinks TD> -->
		    <td valign="top" width="150">
			      <%
			      incfile = includeDir + "QuickLinksDisplay.jsp";
			      %>
			      <jsp:include page="<%=incfile%>" flush="true"/>
		    </td>
	       	    <!-- End Quicklinks TD -->

		    </tr></tbody></table>

		</td>
	<!-- End of Main Content TD -->


</tr></tbody></table>

<!-- End Main Table -->

<%@ include file="../../../include/FooterDisplay.jspf"%>

</body>
</html>
