<!--==========================================================================
Licensed Materials - Property of IBM

WebSphere Commerce

(c) Copyright IBM Corp.  2003, 2005
All Rights Reserved

US Government Users Restricted Rights - Use, duplication or
disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
===========================================================================-->
 

<% // All JSPs requires the first 4 packages for EnvironmentSetup.jsp which is used for multi language support %> 
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.ibm.commerce.server.*" %>
<%@ page import="com.ibm.commerce.command.*" %>

<%@ page import="com.ibm.commerce.beans.DataBeanManager" %>
<%@ page import="com.ibm.commerce.catalog.beans.*" %>
<%@ page import="com.ibm.commerce.catalog.objects.*" %>
<%@ page import="com.ibm.commerce.common.objects.*" %>
<%@ page import="com.ibm.commerce.price.utils.*" %>
<%@ page import="com.ibm.commerce.price.beans.*" %>
<%@ page import="java.math.*" %>

<%@ include file="../../../include/EnvironmentSetup.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>

<wcbase:useBean id="category" classname="com.ibm.commerce.catalog.beans.CategoryDataBean" />

<%
String parentCategoryId = jhelper.getParameter("parent_category_rn");

request.setAttribute("pageName", "Catalog");

%>

<%
/*
 * If the parent category id is not supplied in the URL (parent_category_rn),
 * then get any parent category id from the category databean
 */
if (parentCategoryId == null || parentCategoryId.equals(""))
{
	if (category.getParentCategories().length > 0)
	{
		// Take the first product we find in the category and get its parent
		parentCategoryId = category.getParentCategories()[0].getCategoryId();
	}
	else 
	{                
		// Only happens when no parent exists
		parentCategoryId = categoryId;
	}
}

%>

<jsp:useBean id="parentCategory" class="com.ibm.commerce.catalog.beans.CategoryDataBean" scope="page">
<% 
parentCategory.setCategoryId(parentCategoryId);
com.ibm.commerce.beans.DataBeanManager.activate(parentCategory, request); 
%>
</jsp:useBean>
<%

CategoryDataBean subcats[];
subcats= category.getSubCategories();

ProductDataBean products[];
products = category.getProducts();

// PriceDataBean listPrice[];
// listPrice = products.getListPrice();

BundleDataBean bundles[];
bundles = category.getBundles();

PackageDataBean packages[];
packages = category.getPackages();

%>



<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title><%=category.getDescription().getName()%></title>
	<link rel=stylesheet href="<%=fileDir%>PCDMarket.css" type="text/css">
</head>


<body marginheight="0" marginwidth="0" leftmargin="0" topmargin="0">

<%@ include file="../../../include/HeaderDisplay.jspf"%>

<!-- Start Main Table - Consists of TD for Left Bar, and TD for Content -->
<table border="0" cellpadding="0" cellspacing="0" width="750">
<tr>

  <td valign="top" class="dbg" width="150"> 
    <%
    String incfile = includeDir + "SidebarDisplay.jsp";
    %>
    <jsp:include page="<%=incfile%>" flush="true"/></td>
  <!-- End  Left Nav Bar TD -->

  <!-- Begin Main Content TD -->

  <td valign="top" width="10"><a name="mainContent"></a>&nbsp;</td>

  <td valign="top" width="590">
   <table width="590" border="0" cellspacing="0" cellpadding="0">
      <tbody>
        <tr>
          <td width="590" colspan="2">
		<span class="bct">&nbsp;&nbsp;&nbsp;</span>
		<a class="bctl" href="StoreCatalogDisplay?storeId=<%=storeId%>&catalogId=<%=catalogId%>&langId=<%=languageId%>"><%=storeText.getString("Breadcrumb_CommercePlaza")%></a><span class="bct">&nbsp;&nbsp;&nbsp;&gt;&nbsp;&nbsp;&nbsp;</span>
		<span class="bct"><%=storeText.getString("Breadcrumb_SelectItems")%></span>
	</td></tr>
        <tr>
          <td valign="top" width="310">
            <div align="left" class="title"><%=category.getDescription().getName()%></div></td>
          <td valign="top" width="280">
            <div align="right">
            <img src="<%=fileDir%>images/hdr_products.gif" width="280" height="72" alt="<%=storeText.getString("SubCategoriesDisplay_Title")%>"></div></td>
      	    </tr>

		<tr width="590">	
		<%
			if ( category.getDescription().getFullIImage() != null)
			{
		%>	
				<td align="left" valign="center" width="125">		
				<img src="<%=category.getObjectPath()%><%=category.getDescription().getFullIImage()%>" alt="<%=category.getDescription().getName()%>" /></td>
		<%  
			} // end if
		%>  

		<%
			if ( category.getDescription().getLongDescription() != null && !category.getDescription().getLongDescription().equals("") )
			{
		%>	
				<td align="left" valign="center"><%=category.getDescription().getLongDescription()%><br /></td>
		<%  
			} // end if
		%>  
		</tr>

	</tbody></table>
 

<!-- Start to display attachments -->
										<%-- 
										  ***
										  *	Start: Show Catalog Attachments
										  * The attachments for each usage will be displayed
										  ***
										--%>
										<c:forEach var="attachUsage" items="${category.attachmentUsages}" >	
											<c:set property="attachmentUsage" value="${attachUsage.identifier}" target="${category}" />
											<table border="0" id="WC_CatalogAttachment_Table_1">
											<tr><td id="WC_CatalogAttachment_TableCell_1">
												<table border="1" cellpadding="0" cellspacing="0" width="100%" id="WC_CatalogAttachment_Table_2">
												<tr><td class="labelText1" height="16" nowrap id="WC_CatalogAttachment_TableCell_2"><span class="strongtext"><c:out value="${attachUsage.name}"  /><br /></span></td></tr>
												</table>
												<table border="1" width="100%" id="WC_CatalogAttachment_Table_3">
												<tr>
													<td class="mainContent" id="WC_CatalogAttachment_TableCell_3"> 
														<c:set var="maxNumDisp" value ="4"/>
														<c:set var="maxItemsInRow" value ="1"/>
														<c:set var="showName" value="true" /> 
														<c:set var="showShortDescription" value="false" />
														<c:set var="AttachmentDataBeans" value="${category.attachmentsByUsage}" />
                                                        <c:set var="iconImagePath" value="<%=fileDir%>"  />
														<%@ include file="../../../Snippets/Catalog/Attachments/CatalogAttachmentAssetsDisplay.jspf" %>
													</td>			
												</tr>
												</table>
											</td></tr>
											</table><br/>
										</c:forEach>
										<%--
											***
											* End: Show Catalog Attachment
											***
										--%>	
<!-- End to display attachments -->
 
     <table cellspacing="0" cellpadding="0" width="590" align="center" border="0">
       <tr>
         <td class="gbg"><img class="imgHeightFix" src="<%=fileDir%>images/c.gif" width="590" height="8" border="0" alt="" /></td></tr></table>
 
      <table cellpadding="0" cellspacing="0" border="0" width="590">
		
	<!-- SUB-CATEGORIES -->
				
	<%
	// show the subcategories
	CategoryDataBean subcat;

	for (int i = 0; i < subcats.length; ++i)
	{
		subcat = subcats[i];
		%>

			<tr>
				<td align="left">
				<table width="590" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td valign="top" align="center" width="100">
							<a href="CategoryDisplay?catalogId=<%=catalogId%>&storeId=<%=storeId%>&categoryId=<%=subcat.getCategoryId()%>&langId=<%=languageId%>&parent_category_rn=<%=categoryId%>">
						<img
							src="<%=subcat.getObjectPath()%><%=subcat.getDescription().getThumbNail()%>"
							width="65" height="65"
							alt="<%=subcat.getDescription().getName()%>" vspace="2"
							hspace="5" width="65" height="65" border="0" align="center" /></a></td>

						<td align="left" valign="top" width="490"><span color="#4C6178"
							style="font-family: Verdana" size="2"> <a
							href="CategoryDisplay?catalogId=<%=catalogId%>&storeId=<%=storeId%>&categoryId=<%=subcat.getCategoryId()%>&langId=<%=languageId%>&parent_category_rn=<%=categoryId%>"><B><%=subcat.getDescription().getName()%></B></a></span>
						<br />
						<span color="#32404F" style="font-family: Verdana" size="2"> <%=subcat.getDescription().getShortDescription()%></span>
						<br />
						</td>
					</tr>
				</table>
				</td>
			</tr>
			
			<tr>
				<td>
				<table cellspacing="0" cellpadding="0" width="590" align="center" border="0">
					<tr>
						<td class="gbg"><img class="imgHeightFix" src="<%=fileDir%>images/c.gif" width="590" height="1" border="0"	alt="" /></td>
					</tr>
				</table>
				</td>
			</tr>
		
			
			<%
		} 
		%>				
				
	<!-- PRODUCTS -->
				
	<%
	// show the products
	ProductDataBean product;

	for (int i = 0; i < products.length; ++i)
	{
		product = products[i];
		%>		
				
		<tr>
		  <td align="left">
		    <table width="590" border="0" cellpadding="0" cellspacing="0">
		      <tr>
			<td valign="top" align="center" width="100">
		  	  <a href="ProductDisplay?catalogId=<%=catalogId%>&storeId=<%=storeId%>&productId=<%=product.getProductID()%>&langId=<%=languageId%>&parent_category_rn=<%=categoryId%>">
			  <img src="<%=category.getObjectPath()%><%=product.getDescription().getThumbNail() %>" alt="<%=product.getDescription().getName()%>" vspace="2" hspace="5" width="65" height="65" border="0" align="center" /></a></td>
			<td align="left" valign="top" width="490">
			  <span color="#4C6178" style="font-family : Verdana;" size="2">
			  <a href="ProductDisplay?catalogId=<%=catalogId%>&storeId=<%=storeId%>&productId=<%=product.getProductID()%>&langId=<%=languageId%>&parent_category_rn=<%=categoryId%>"><B><%=product.getDescription().getName()%></B></a></span>
 			  <br />

          		  <!-- Start - FIND LOWEST PRICED ITEM FOR PRODUCT -->

			  <%

			  ItemAccessBean itemsAB[] = product.getItems();
			  ItemAccessBean itemAB;
	
	   		  PriceDataBean itemPrice = null;
			  PriceDataBean lowestPrice = null;
              
		 	  for (int j = 0; j < itemsAB.length; ++j) 
			  {
			    itemAB = itemsAB[j];
			
			    ItemDataBean item = new ItemDataBean();
			    item.setItemID(itemAB.getCatalogEntryReferenceNumber());
			    DataBeanManager.activate (item, request);
			 			
			    try {
			    	itemPrice = item.getCalculatedContractPrice();
			    }
			    catch (Exception e) {
			    // no price	
			    }
				
			    if (lowestPrice == null)
                {
			    	lowestPrice = itemPrice;
                }
			    else 
                {
                    // if lowestPrice is greater than itemPrice
                    if ( lowestPrice.getAmount().compareTo(itemPrice.getAmount()) == 1) 
                    {
                        lowestPrice = itemPrice;
                    }
                }
			  }

			  if (lowestPrice != null) {
 			  %>

          		  <!-- End - FIND LOWEST PRICED ITEM FOR PRODUCT -->

 			  <span class=small style="COLOR: #666666">
			  <b><%=storeText.getString("SubCategoriesDisplay_AvailableFrom")%>&nbsp;</b></span><span class="oprice"><%=lowestPrice%></span>
			  <span class=small style="COLOR: #666666"> <%=storeText.getString("SubCategoriesDisplay_IBMListPrice")%></span>
 			  <br />
			  <%
				}
 			  %>
 			  <span color="#32404F" style="font-family : Verdana;" size="2">
			  <%=product.getDescription().getShortDescription()%>
			  <br /><br /></span>
			  </td></tr></table>
					
		  </td></tr>

			<tr>
				<td>
				<table cellspacing="0" cellpadding="0" width="590" align="center" border="0">
					<tr>
						<td class="gbg"><img class="imgHeightFix" src="<%=fileDir%>images/c.gif" width="590" height="1" border="0"	alt="" /></td>
					</tr>
				</table>
				</td>
			</tr>

			<%
		} 
		%>	
					
	<!-- BUNDLES -->
				
	<%
	// show the bundles
	BundleDataBean bundle;

	for (int i = 0; i < bundles.length; ++i)
	{
		bundle = bundles[i];
		%>
				
				
		<tr>
		  <td align="left">
		    <table width="590" border="0" cellpadding="0" cellspacing="0">
		      <tr>
			<td valign="top" align="center" width="100">
		  	  <a href="ProductDisplay?catalogId=<%=catalogId%>&storeId=<%=storeId%>&productId=<%=bundle.getBundleID()%>&langId=<%=languageId%>&parent_category_rn=<%=categoryId%>">
			  <img src="<%=category.getObjectPath()%><%=bundle.getDescription().getThumbNail() %>" alt="<%=bundle.getDescription().getName()%>" vspace="2" hspace="5" width="65" height="65" border="0" align="center" /></a></td>
			<td align="left" valign="top" width="490">
			  <span color="#4C6178" style="font-family : Verdana;" size="2">
          	  	  <a href="ProductDisplay?catalogId=<%=catalogId%>&storeId=<%=storeId%>&productId=<%=bundle.getBundleID()%>&langId=<%=languageId%>&parent_category_rn=<%=categoryId%>"><b><%=bundle.getDescription().getName()%></b></a></span> 
			  <br />

			<%
	   		  PriceDataBean bundlePrice = null;
			
			    try {
			    	bundlePrice = bundle.getCalculatedContractPrice();
			    }
			    catch (Exception e) {
			    // no price	
			    }
				
			  if (bundlePrice != null) {
 			  %>

 			  <span class=small style="COLOR: #666666"></span><span class="oprice"><%=bundlePrice%></span>
			  <span class=small style="COLOR: #666666"><%=storeText.getString("SubCategoriesDisplay_IBMListPrice")%></span>
 			  <br />
			  <%
				}
 			  %>

			  <span color="#32404F" style="font-family : Verdana;" size="2">
			  <%=bundle.getDescription().getShortDescription()%>
			  <br /><br /></span></td></tr></table>
			
		  </td></tr>

			<tr>
				<td>
				<table cellspacing="0" cellpadding="0" width="590" align="center" border="0">
					<tr>
						<td class="gbg"><img class="imgHeightFix" src="<%=fileDir%>images/c.gif" width="590" height="1" border="0"	alt="" /></td>
					</tr>
				</table>
				</td>
			</tr>
				
		<%
		}
		%>				
				
	<!-- PACKAGES -->
	<%
	// show the packages
	PackageDataBean pack;

	for (int i = 0; i < packages.length; ++i)
	{
		pack = packages[i];
		%>
					
		<tr>
	  	  <td align="left">
		    <table width="590" border="0" cellpadding="0" cellspacing="0">
		      <tr>
			<td valign="top" align="center" width="100">
			  <a href="ProductDisplay?catalogId=<%=catalogId%>&storeId=<%=storeId%>&productId=<%=pack.getPackageID()%>&langId=<%=languageId%>&parent_category_rn=<%=categoryId%>">
			  <img src="<%=category.getObjectPath()%><%=pack.getDescription().getThumbNail() %>" alt="<%=pack.getDescription().getName()%>" vspace="2" hspace="5" width="65" height="65" border="0" align="center" /></a></td>
			<td align="left" valign="top" width="490">
			  <span color="#4C6178" style="font-family : Verdana;" size="2">
			  <a href="ProductDisplay?catalogId=<%=catalogId%>&storeId=<%=storeId%>&productId=<%=pack.getPackageID()%>&langId=<%=languageId%>&parent_category_rn=<%=categoryId%>"><b><%=pack.getDescription().getName()%></b></a></span>
			  <br />

			<%
	   		  PriceDataBean packPrice = null;
			
			    try {
			    	packPrice = pack.getCalculatedContractPrice();
			    }
			    catch (Exception e) {
			    // no price	
			    }
				
			  if (packPrice != null) {
 			  %>

 			  <span class=small style="COLOR: #666666"></span><span class="oprice"><%=packPrice%></span>
			  <span class=small style="COLOR: #666666"><%=storeText.getString("SubCategoriesDisplay_IBMListPrice")%></span>
 			  <br />
			  <%
				}
 			  %>


			  <span color="#32404F" style="font-family : Verdana;" size="2">
			  <%=pack.getDescription().getShortDescription()%><br /><br /></span></td></tr></table>
					
		  </td></tr>
		  
			<tr>
				<td>
				<table cellspacing="0" cellpadding="0" width="590" align="center" border="0">
					<tr>
						<td class="gbg"><img class="imgHeightFix" src="<%=fileDir%>images/c.gif" width="590" height="1" border="0"	alt="" /></td>
					</tr>
				</table>
				</td>
			</tr>
	  
		<%
		}
		%>				
					
					
	
	</table>
	

    </td>


    <!-- End of Main Content TD -->
 
<!-- End Main Table -->

</tr></tbody></table>


<%@ include file="../../../include/FooterDisplay.jspf"%>


</body>

</html>