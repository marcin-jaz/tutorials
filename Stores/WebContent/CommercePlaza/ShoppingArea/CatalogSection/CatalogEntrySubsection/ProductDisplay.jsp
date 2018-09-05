<!--==========================================================================
Licensed Materials - Property of IBM

WebSphere Commerce

(c) Copyright IBM Corp.  2003, 2005
All Rights Reserved

US Government Users Restricted Rights - Use, duplication or
disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
===========================================================================-->

<%@ page import="java.io.*" %>

<% // Needed for: ResourceBundle, Locale %>
<%@ page import="java.util.*" %>

<% // Needed for: CommandContext %>
<%@ page import="com.ibm.commerce.command.*" %>

<% // Needed for: JSPHelper %>
<%@ page import="com.ibm.commerce.server.*" %>

<% // Needed for: DataBeanManager %>
<%@ page import="com.ibm.commerce.beans.*" %>

<% // Needed for: ItemDataBean, ProductDataBean, CategoryDataBean, AttributeValueDataBean, AttributeDataBean %>
<%@ page import="com.ibm.commerce.catalog.beans.*" %>

<% // Needed for: PriceDataBean to format the price %>
<%@ page import="com.ibm.commerce.price.beans.PriceDataBean" %>

<% // Needed for: AttributeAccessBean, ItemAccessBean, CatalogEntryDescriptionAccessBean %>
<%@ page import="com.ibm.commerce.catalog.objects.*" %>

<% // Needed for: BigDecimal %>
<%@ page import="java.math.*" %>


<%@ include file="../../../include/EnvironmentSetup.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>

<wcbase:useBean id="product" classname="com.ibm.commerce.catalog.beans.ProductDataBean" />

<%
String parentCategoryId = jhelper.getParameter("parent_category_rn");
String productId = jhelper.getParameter("productId");



// Get all the items for this product.
ItemAccessBean itemsAB[] = product.getItems();
ItemAccessBean itemAB;

CatalogEntryDescriptionAccessBean catalogEntryDescriptionAB;

CategoryDataBean parentCategory = null;

if (parentCategoryId != null)
{
	parentCategory = new CategoryDataBean ();
	parentCategory.setCategoryId(parentCategoryId);	
	DataBeanManager.activate(parentCategory, request);
}

request.setAttribute("pageName", "Catalog");

%>

<SCRIPT language="javascript">

function AddToShopCart(form, newCatEntry)
{
	form.action='OrderItemAdd';
	form.URL.value='OrderItemDisplay?orderId=.'
	form.catEntryId.value=newCatEntry;
	form.submit();
	}


</SCRIPT>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title><%=product.getDescription().getName()%></title>
	<link rel=stylesheet HREF="<%=fileDir%>PCDMarket.css" type="text/css">
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
	    
  <!-- Begin Main Content TD -->

  <td valign="top" width="10">&nbsp;</td>

  <td valign="top" width="590">

  <!--START MAIN CONTENT-->
				
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
               <div align="left" class="title"><%=product.getDescription().getName()%></div></td>
             <td valign="top" width="280">
              <div align="right">
              <img src="<%=fileDir%>images/hdr_products.gif" width="280" height="72" alt="<%=storeText.getString("ProductDisplay_Title")%>"></div></td>
   	    </tr>
		<tr width="590">	
		<%
			if ( product.getDescription().getFullImage() != null)
			{
		%>	
				<td align="left" valign="center" width="125">		
				<img src="<%=product.getObjectPath()%><%=product.getDescription().getFullImage()%>" alt="<%=product.getDescription().getName()%>" /></td>
		<%  
			} // end if
		%>  

		<td align="left" valign="center">
		<%
			if ( product.getDescription().getLongDescription() != null && !product.getDescription().getLongDescription().equals("") )
			{
		%>	
				<%=product.getDescription().getLongDescription()%>
		<%  
			} // end if
		%>  
		<%
		AttributeDataBean productDescriptiveAttributes[] = product.getDescriptiveAttributeDataBeans();
		if(productDescriptiveAttributes != null && productDescriptiveAttributes.length != 0) {
		%>
			<br/>
			<% for(int i = 0; i < productDescriptiveAttributes.length; i++) { %>
				<% if(!"2".equals(productDescriptiveAttributes[i].getUsage())) { continue; } //skip all non-descriptive attributes %>
				<br/><strong><%=productDescriptiveAttributes[i].getDescription()%>:</strong>
				<%
				AttributeValueDataBean[] attributeValues = productDescriptiveAttributes[i].getAttributeValueDataBeans();
				for(int j = 0; j < attributeValues.length; j++) {
				%>
					<% if(j != 0) { %>,<% } %><%=attributeValues[j].getValue()%>
				<% } %>
			<% } %>
		<% } %>
		</td>
		
		</tr>
	   </tbody></table>

<!-- Start to display attachments -->
										<%-- 
										  ***
										  *	Start: Show Catalog Attachments
										  * The attachments for each usage will be displayed
										  ***
										--%>
										<c:forEach var="attachUsage" items="${product.attachmentUsages}" >	
											<c:set property="attachmentUsage" value="${attachUsage.identifier}" target="${product}" />
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
														<c:set var="AttachmentDataBeans" value="${product.attachmentsByUsage}" />
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

  		        <form name="OrderItemForm" action="" method="post">
			  <input type="hidden" name="storeId" value="<%=storeId%>">
			  <input type="hidden" name="quantity" value="1">
			  <input type="hidden" name="orderId" value=".">
			  <input type="hidden" name="langId" value="<%=languageId%>">
			  <input type="hidden" name="catalogId" value="<%=catalogId%>">
			  <input type="hidden" name="catEntryId" value="">
			  <input type="hidden" name="URL" value="">
			  <input type="hidden" name="errorViewName" value="GenericApplicationError">				
			  <input type="hidden" name="allocate" value="*n">
			  <input type="hidden" name="reverse" value="*n">
			  <input type="hidden" name="backorder" value="*n">
			  <input type="hidden" name="check" value="*n">
			  <input type="hidden" name="merge" value="*n">
	  		  <input type="hidden" name="remerge" value="*n">		
      			  </form>
	      <table cellspacing="0" cellpadding="0" border="0" width="590">
		<tbody>
		<tr>
		<td>				
	      <!-- Display items -->

			<table cellpadding=0 cellspacing=0 border=0 width="590" align="left">
			<tbody>
				<tr>
					<td>
					<table width="100%" border=0 cellpadding=0 cellspacing=1>
						<tr class="tblue" height="20">
							<th valign="center" width="25%" align="left" id="th1" class="tdblue">
								<span>&nbsp;&nbsp;<%=storeText.getString("ProductDisplay_ColModel")%></span>
							</th>
							<th valign="center" width="25%" align="left" id="th2" class="tdblue">
								<span>&nbsp;&nbsp;<%=storeText.getString("ProductDisplay_ColListPrice")%></span>
							</th>
							<th valign="center" width="50%" align="left" id="th3" class="tdblue">
								<span>&nbsp;&nbsp;<%=storeText.getString("ProductDisplay_ColDescription")%></span>
							</th>
						</tr>

						<%
						
		      for (int i = 0; i < itemsAB.length; i++) 
		      {
		    	  
		    	  
		    	  itemAB = itemsAB[i];
			  catalogEntryDescriptionAB = itemAB.getDescription(new Integer(languageId));
			
			  ItemDataBean item = new ItemDataBean();
			  item.setItemID(itemAB.getCatalogEntryReferenceNumber());
			  DataBeanManager.activate (item, request);
                      PriceDataBean itemPrice = null;

			    try {
	    			itemPrice = item.getCalculatedContractPrice();
			    }
			    catch (Exception e) {
			    // no price	
			    }
			
			  %>



						<tr>
							<td valign="top" headers="th1"><a class="catalog"
								href="ProductDisplay?catalogId=<%= catalogId %>&storeId=<%= storeId %>&productId=<%= itemAB.getCatalogEntryReferenceNumber() %>&langId=<%= languageId %>&parent_category_rn=<%= parentCategoryId %>">
							<b><%= catalogEntryDescriptionAB.getName()%></b> <br />
							<b><%= itemAB.getPartNumber()%></b></a> <br />
							<br />
							<br />
							<br />
							<% if(itemPrice != null) { %>
							<a class="catalog"
								href="javascript:AddToShopCart(document.OrderItemForm, <%=itemAB.getCatalogEntryReferenceNumber()%>)"> 
								<img alt="<%=storeText.getString("ItemDisplay_AddToCart")%>" src="<%=fileDir%>images/btn_addcart.gif" align="middle" border=0 />
								 <b><%=storeText.getString("ProductDisplay_AddToCart")%></b></a>
							<% } %>
							<br />
							<br />
							</td>

			<td valign="top" headers="th2"><%
		      if (itemPrice != null) {
			%>
				<span class="oprice"><%=itemPrice%></span>
				<%
			}
			%>
				</td><td valign="top" headers="th3"><%
			
						
		  AttributeValueDataBean attributeValues[] = item.getAttributeValueDataBeans(new Integer(languageId));
						
	    	// Loop through attributes values and only show the value that is relavent to the attribute for this SKU
	    	for (int x=0; x < attributeValues.length; x++) 
		{
			//String usage = attributeValues[x].getAttributeDataBean().getUsage();
			//if (usage == null || usage.equals("1") || usage.equals("3")) {
		%> <strong><%=attributeValues[x].getAttributeDataBean().getDescription()%>
							: </strong> <%=attributeValues[x].getValue()%> <br />
							<%
			//}
		}
			if (itemPrice != null) {
				%></td><%
			}
		%>
						</tr>

						<tr>
							<td colspan="3">
							<table cellSpacing=0 cellPadding=0 width=590 align="center"
								border=0>
								<tr>
									<td class="gbg"><img class="imgHeightFix"
										src="<%=fileDir%>images/c.gif" width="590" height="1"
										border="0" alt="" /></td>
								</tr>
							</table>
							<br />
							</td>
						</tr>
						<%
		        }
		      %></table>
					</td>
				</tr>
				</tbody>
			</table>



			<!--END MAIN CONTENT-->

	</td>

    <!-- End of Main Content TD -->

   
</tr></table>
</tr></table>   
<!-- End Main Table -->
<%@ include file="../../../include/FooterDisplay.jspf"%>

</body>
</html>
