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

<% // Needed for: PriceDataBean %>
<%@ page import="com.ibm.commerce.price.beans.PriceDataBean" %>

<% // Needed for: AttributeAccessBean, ItemAccessBean, CatalogEntryDescriptionAccessBean %>
<%@ page import="com.ibm.commerce.catalog.objects.*" %>

<% // Needed for: BigDecimal %>
<%@ page import="java.math.*" %>

<%@ page import="com.ibm.commerce.server.JSPResourceBundle" %>  



<%@ include file="../../../include/EnvironmentSetup.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>

<wcbase:useBean id="bundle" classname="com.ibm.commerce.catalog.beans.BundleDataBean" />

<%
String parentCategoryId = jhelper.getParameter("parent_category_rn");
String productId = jhelper.getParameter("productId");

%>


<%

request.setAttribute("pageName", "Catalog");

%>

<script language="javascript">

function AddBundleToShopCart(form)
{
	form.action="OrderItemAdd";
	form.URL.value='OrderItemDisplay?orderId=*'
	form.submit();
	}


function AddItemToShopCart(form, newCatentryId)
{
	form.action="OrderItemAdd";
	form.URL.value='OrderItemDisplay?orderId=*'
	form.catEntryId.value=newCatentryId;
	form.submit();
	}

</script>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title><%=bundle.getDescription().getName()%></title>
	<link rel=stylesheet href="<%=fileDir%>PCDMarket.css" type="text/css" />
</head>


<body marginheight="0" marginwidth="0">

<%@ include file="../../../include/HeaderDisplay.jspf"%>

<!-- Start Main Table - Consists of TD for Left Bar, TD for Content and TD for Quicklinks -->
<table border="0" cellpadding="0" cellspacing="0" width="750">
<tbody>
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
              </td></tr>
           <tr>
             <td valign="top" width="310">
               <div align="left" class="title"><%=bundle.getDescription().getName()%></div></td>
             <td valign="top" width="280">
              <div align="right">
              <img src="<%=fileDir%>images/hdr_products.gif" width="280" height="72" alt="<%=storeText.getString("ProductDisplay_Title")%>" /></div></td>
	       </tr>
	   </tbody>
   </table>

			<form name="OrderItemForm" action="" method="post">
				<input type="hidden" name="storeId" value="<%=storeId%>"/>
				<input type="hidden" name="orderId" value="."/>
				<input type="hidden" name="langId" value="<%=languageId%>"/>
				<input type="hidden" name="catalogId" value="<%=catalogId%>"/>
				<input type="hidden" name="URL" value=""/>
				<input type="hidden" name="errorViewName" value=""/>				
				<input type="hidden" name="catEntryId" value=""/>
				<input type="hidden" name="quantity" value="1"/>
				<input type="hidden" name="allocate" value="*n"/>
				<input type="hidden" name="reverse" value="*n"/>
				<input type="hidden" name="backorder" value="*n"/>
				<input type="hidden" name="check" value="*n"/>
				<input type="hidden" name="merge" value="*n"/>
				<input type="hidden" name="remerge" value="*n"/>
			</form>

  		    <form name="OrderBundleForm" action="" method="post">
			  <input type="hidden" name="storeId" value="<%=storeId%>"/>
			  <input type="hidden" name="langId" value="<%=languageId%>"/>
			  <input type="hidden" name="catalogId" value="<%=catalogId%>"/>
			  <input type="hidden" name="URL" value=""/>
			  <input type="hidden" name="errorViewName" value=""/>				
			  <input type="hidden" name="allocate" value="*n"/>
			  <input type="hidden" name="reverse" value="*n"/>
			  <input type="hidden" name="backorder" value="*n"/>
			  <input type="hidden" name="check" value="*n"/>
			  <input type="hidden" name="merge" value="*n"/>
	  		  <input type="hidden" name="remerge" value="*n"/>		




	      <table border="0" cellspacing="0" cellpadding="0" width="590">
			<tbody>
			<tr>

			<%
				if ( bundle.getDescription().getFullImage() != null)
				{
			%>	
					<td align="left" valign="middle" width="125">		
						<img src="<%=bundle.getObjectPath()%><%=bundle.getDescription().getFullImage()%>" alt="<%=bundle.getDescription().getName()%>" border="0" />
					</td>
			<%  
				} // end if
			%>  
	<td valign="top" width="10">&nbsp;</td>
      <td>
	      <table cellspacing="0" cellpadding="0" border="0">
			<tbody>
		<%
			if ( bundle.getDescription().getLongDescription() != null && !bundle.getDescription().getLongDescription().equals("") )
			{
		%>	
			<tr>
				<td align="left" valign="middle">
					<%=bundle.getDescription().getLongDescription()%>
				</td>
			</tr>
		<%  
			} // end if
		%>  

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
	
	<tr>
	    <td>
	    	<span class="oprice"><b><%=bundlePrice%></b></span>
	    	<span class="small">&nbsp;<%=storeText.getString("ItemDisplay_ListPrice")%></span>
	    </td>
	</tr>

	<%
	}
	%>		    
	
		<tr>
   		  <td>
   		  	<img src="<%=fileDir%>images/btn_addcart.gif" alt="<%=storeText.getString("ProductDisplay_AddToCart")%>" align="absMiddle" border="0" />
			<a style="TEXT-DECORATION: none" href="javascript:AddBundleToShopCart(document.OrderBundleForm)"><b><%=storeText.getString("ProductDisplay_AddToCart")%></b></a>
		  </td>
		</tr>
		

		  </tbody>
		</table>
		</td>

			</tr>
		  </tbody>
		</table>
<!-- Start to display attachments -->
										<%-- 
										  ***
										  *	Start: Show Catalog Attachments
										  * The attachments for each usage will be displayed
										  ***
										--%>
										<c:forEach var="attachUsage" items="${bundle.attachmentUsages}" >	
											<c:set property="attachmentUsage" value="${attachUsage.identifier}" target="${bundle}" />
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
														<c:set var="AttachmentDataBeans" value="${bundle.attachmentsByUsage}" />
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
	      <!-- Display items -->

	      <table cellpadding="0" cellspacing="0" border="0" width="590" align="left">
	      <tbody>
			<tr>
				<td>
				<table width="100%" border="0" cellpadding="0" cellspacing="1">
					<tr class="tblue" height="20">
						<th valign="middle" width="25%" align="left">
							<span>&nbsp;&nbsp;<%=storeText.getString("ProductDisplay_ColModel")%></span>
						</th>
						<th valign="middle" width="25%" align="left">
							<span>&nbsp;&nbsp;<%=storeText.getString("ProductDisplay_ColListPrice")%></span>
						</th>
						<th valign="middle" width="50%" align="left">
							<span>&nbsp;&nbsp;<%=storeText.getString("ProductDisplay_ColDescription")%></span>
						</th>
					</tr>

					<!-- start of items -->

					<%

			CompositeItemDataBean[] compositeItems = bundle.getBundledItems();
					
		      for (int m = 0; m < compositeItems.length; m++) 
		      {
		   	  ItemDataBean item = compositeItems[m].getItem();
		
			%>

					<!-- needed for OrderItemAdd command -->
					<input type="hidden" name="catEntryId_<%= m+1%>"
						value="<%= item.getItemID()%>" />
					<input type="hidden" name="quantity_<%= m+1%>" value="<%=(new Double (compositeItems[m].getQuantity())).longValue()%>" />

					<tr>
						<td valign="top"><a class="catalog"
							href="ProductDisplay?catalogId=<%=catalogId%>&storeId=<%=storeId%>&productId=<%=item.getItemID()%>&langId=<%=languageId%>&parent_category_rn=<%=parentCategoryId%>">
						<b><%= item.getDescription(new Integer(languageId)).getName()%><br />
						<%= item.getPartNumber() %></b></a>
						<br />
						<br />
						<br />
						<a class="catalog"
							href="javascript:Customize(document.OrderItemForm)"
							onClick="Customize(document.OrderItemForm); return false;""> <img
							alt="<%=storeText.getString("Alt_Customize")%>"
							src="<%=fileDir%><%=locale.toString()%>/images/button_customize.gif"
							border=0 /></a> <br />
						<a class="catalog"
							href="javascript:AddItemToShopCart(document.OrderItemForm, <%=item.getItemID()%>)"
							returnfalse;"> <img
							alt="<%=storeText.getString("ItemDisplay_AddToCart")%>"
							src="<%=fileDir%>images/btn_addcart.gif" align=absMiddle border=0 />
						<b><%=storeText.getString("ProductDisplay_AddToCart")%></b></a> <br />
						</td>

						<%
			PriceDataBean itemPrice = null;

			try {
	  			itemPrice = item.getCalculatedContractPrice();
			}
			catch (Exception e) {
			// no price	
			}

			if (itemPrice != null) {
			%>

						<td valign="top"><span class="oprice"><%=itemPrice%></span></td>

						<%
			} // end if
			else {
			%>

						<td valign="top"><span></span></td>

						<%
			} // end else
			%>

						<td valign="top"><%
						
				AttributeValueDataBean attributeValues[] = item.getAttributeValueDataBeans(new Integer(languageId));
																		
				// For each item attribute, display the attribute value.
				for (int n = 0; n < attributeValues.length; n++) 
				{
					AttributeValueDataBean attributeValue = attributeValues[n];
					AttributeDataBean attribute = attributeValues[n].getAttributeDataBean();
								
					if ((attributeValue.getValue() != null) && !(attributeValue.getValue().equals("")))
					{
						if (attributeValue.getAttributeDataBean().getUsage().equals("3")) {
			%> <strong><%=attribute.getDescription()%> : </strong><%=attributeValue.getValue()%>
						<br />
						<%
						}
					}
				} //End of Loop								
			%>
			</td>
			</tr>

					<tr>
						<td colspan="3">
						<table cellspacing="0" cellpadding="0" width="590" align="center" border="0">
							<tbody>
							<tr>
								<td class="gbg"><img class="imgHeightFix"
									src="<%=fileDir%>images/c.gif" width="590" height="1"
									border="0" alt="" /></td>
							</tr>
							</tbody>
						</table>
						<br />
						</td>
					</tr>
					<%
		        } // end of items
		      %>

					<!-- end of items -->
					</table>
				</td>
			</tr>

			</tbody>
		</table>
	</form>		
	<!--END MAIN CONTENT-->

	</td>

    <!-- End of Main Content TD -->

   
</tr></tbody></table>
   
<!-- End Main Table -->

<%@ include file="../../../include/FooterDisplay.jspf"%>

</body>
</html>

