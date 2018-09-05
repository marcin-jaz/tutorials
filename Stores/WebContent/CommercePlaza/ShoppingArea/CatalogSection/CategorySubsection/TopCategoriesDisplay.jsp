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


<% // All JSPs requires the first 4 packages for EnvironmentSetup.jsp which is used for multi language support %> 
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.ibm.commerce.server.*" %>
<%@ page import="com.ibm.commerce.command.*" %>

<%@ page import="com.ibm.commerce.catalog.beans.*" %>
<%@ page import="com.ibm.commerce.beans.*" %>
<%@ page import="com.ibm.commerce.catalog.objects.*" %>
<%@ page import="com.ibm.commerce.user.beans.*" %> 

<%@ include file="../../../include/EnvironmentSetup.jsp"%>

<% response.setContentType(storeText.getString("ENCODESTATEMENT")); %> 

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

CategoryDataBean subCategories[];
CategoryDataBean scategory;

ProductDataBean products[];
ProductDataBean product;

ItemDataBean items[];
ItemDataBean item;

PackageDataBean packages[];
PackageDataBean pack;

BundleDataBean bundles[];
BundleDataBean bundle;

request.setAttribute("pageName", "CommercePlazaCatalog");
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title><%=storeText.getString("NavSidebar_CommercePlazaCatalog")%></title>
	<link rel=stylesheet href="<%=fileDir%>PCDMarket.css" type="text/css">
</head>


<body marginheight="0" marginwidth="0" leftmargin="0" topmargin="0">

<%@ include file="../../../include/HeaderDisplay.jspf"%>

<!-- Start Main Table - Consists of TD for Left Bar, TD for Content and TD for Quicklinks -->
<table border="0" cellpadding="0" cellspacing="0" width="750">
		<tr>
			<td valign="top" class="dbg" width="150"> 
			      <%
			      String incfile = includeDir + "SidebarDisplay.jsp";
			      %>
			      <jsp:include page="<%=incfile%>" flush="true"/></td>
<!-- End  Left Nav Bar TD -->

<td valign="top" width="10"><a name="mainContent"></a>&nbsp;</td>

<td valign="top" width="590">
<!-- Begin Main Content TD -->
			
     <table width="590" border="0" cellspacing="0" cellpadding="0">
       <tbody>
        <tr>
          <td width="590" colspan="2">
          	<span class="bct">&nbsp;&nbsp;&nbsp;</span>
		<a class="bctl" href="StoreCatalogDisplay?storeId=<%=storeId%>&catalogId=<%=catalogId%>&langId=<%=languageId%>"><%=storeText.getString("Breadcrumb_CommercePlaza")%></a>
	      <span class="bct">&nbsp;&nbsp;&nbsp;&gt;&nbsp;&nbsp;&nbsp;</span>
		<span class="bct"><%=storeText.getString("Breadcrumb_SelectItems")%></span>
	</td></tr>
        <tr>
          <td valign="top" width="310">
            <div align="left" class="title"><%=storeText.getString("NavSidebar_CommercePlazaCatalog")%></div></td>
          <td valign="top" width="280">
            <div align="right">
            <img src="<%=fileDir%>images/hdr_products.gif" width="280" height="72" alt="<%=storeText.getString("TopCategoriesDisplay_Title")%>"></div></td>
   	    </tr>
	<tr>
	  <td width="590" colspan="2">&nbsp;</td></tr>
	</tbody></table>
		
	      
      <table cellSpacing="0" cellPadding="0" width="590" border="0">
        <tbody>
          <tr>
            <td valign="top" width="440">
            <table width="440" cellspacing="0" cellpadding="0">
             <tbody>
               <tr>
		 <td class="tblue" height="20"><span>&nbsp;</span><%=storeText.getString("TopCategoriesDisplay_SubTitle")%></td></tr>
                  <%
		  //Top Category
		  for (int i = 0; i < topCategories.length; ++i)
		    {
		    	tcategory = topCategories[i];
		    	tcategoryId = tcategory.getCategoryId();
		    	%>
                  <tr>
                     <td>
				<span>&nbsp;</span>
			  	<b><%=tcategory.getDescription().getName()%></b>
                     </td>
                  </tr>
		  	<%
		  
		  	//Display Subcategory of Top Category
		  	subCategories = tcategory.getSubCategories();
		  					
		  	for (int j = 0; j < subCategories.length; ++j)
		  		{
		  			scategory = subCategories[j];
		  			%>
			            <tr>
			              <td>
						<span>&nbsp;&nbsp;&nbsp;</span>
			  			<a class="catalog" href="CategoryDisplay?catalogId=<%=catalogId%>&storeId=<%=storeId%>&categoryId=<%=scategory.getCategoryId()%>&langId=<%=languageId%>&parent_category_rn=<%=tcategoryId%>">
			  			<%=scategory.getDescription().getName()%>
		  				</a>
			              </td>
			            </tr>
		  			<%
		  			} 
		  	
		  	//Display Product of Top Category
		  		products = tcategory.getProducts();
		  	if (products.length != 0) 
		  	{
		   		for (int j = 0; j < products.length; ++j) 
		    		{
		  			product = products[j];
		  			%>
			            <tr>
			              <td>
						<span>&nbsp;&nbsp;&nbsp;</span>
			  			<a class="catalog" href="ProductDisplay?catalogId=<%=catalogId%>&storeId=<%=storeId%>&productId=<%=product.getProductID()%>&langId=<%=languageId%>&parent_category_rn=<%=tcategoryId%>">
			  			<%=product.getDescription().getName()%>
		  				</a>
			              </td>
			            </tr>
		  			<%
		  			}
		  		}
		  
		  	//Display Item of Top Category
		  	items = tcategory.getItems();
		  	if (items.length != 0) 
		  	{	
		  		for (int j = 0; j < items.length; ++j) 
		  		{
		 			item = items[j];
		 			%>
			            <tr>
			              <td>
						<span>&nbsp;&nbsp;&nbsp;</span>
			 			<a class="catalog" href="ProductDisplay?catalogId=<%=catalogId%>&storeId=<%=storeId%>&productId=<%=item.getItemID()%>&langId=<%=languageId%>">
			 			<%=item.getDescription().getName()%>
		 				</a>									
			              </td>
			            </tr>
		 			<%
		 			}
		 		}
		  
		  	//Display package of Top Category
		  	packages = tcategory.getPackages();
		  	if (packages.length != 0) 
		  	{
		  		for (int j = 0; j < packages.length; ++j) 
				{
					pack = packages[j];
					%>
			            <tr>
			              <td>
						<span>&nbsp;&nbsp;&nbsp;</span>
						<a class="catalog" href="PackageDisplay?catalogId=<%=catalogId%>&storeId=<%=storeId%>&productId=<%=pack.getPackageID()%>&langId=<%=languageId%>&parent_category_rn=<%=tcategoryId%>">
						<%=pack.getDescription().getName()%>
						</a>																				
			              </td>
			            </tr>
					<%
					}
				}
		  	
		  	//Display bundle of Top Category
		  	bundles = tcategory.getBundles();
		  	if (bundles.length != 0) 
		  	{
		  		for (int j = 0; j < bundles.length; ++j) 
				{
					bundle = bundles[j];
					%>
			            <tr>
			              <td>
						<span>&nbsp;&nbsp;&nbsp;</span>
						<a class="catalog" href="BundleDisplay?catalogId=<%=catalogId%>&storeId=<%=storeId%>&productId=<%=bundle.getBundleID()%>&langId=<%=languageId%>&parent_category_rn=<%=tcategoryId%>">
						<%=bundle.getDescription().getName()%>
						</a>											
			              </td>
			            </tr>
					<%
					}
				}
				%>
			            <tr>
			              <td height="6">
						<span>&nbsp;</span>
			              </td>
			            </tr>
				<%
                 	  } // end for top categories
		  	  %>                   
	</tbody></table>
    </td>
    <!-- End of Main Content TD -->
    
    <td valign="top" width="10">&nbsp;</td>
         
    <td valign="top" width="150">   
      <%
      /* This is set in the request to determine the errorViewName used in QuickLinksDisplay.jsp
       *  The errorViewName is either StoreCatalogDisplayView or TopCategoriesDisplayView, depending on where it is launched from.
       */
      request.setAttribute("RequestPriceAvailErrorView", "TopCategoriesDisplay");
      %>
      <%
      incfile = includeDir + "QuickLinksDisplay.jsp";
      %>
      <jsp:include page="<%=incfile%>" flush="true"/>
    </td>
    
</tr></table>

</td></tr></table>
   
<!-- End Main Table -->

<%@ include file="../../../include/FooterDisplay.jspf"%>

</body>
</html>