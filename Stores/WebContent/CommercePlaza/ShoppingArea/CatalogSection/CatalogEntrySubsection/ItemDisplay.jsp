<!--==========================================================================
Licensed Materials - Property of IBM

WebSphere Commerce

(c) Copyright IBM Corp.  2003, 2005
All Rights Reserved

US Government Users Restricted Rights - Use, duplication or
disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
===========================================================================-->
 
 
<%@ page import="java.io.*" %>

<% // Needed for: Long %>
<%@ page import="java.lang.*" %>

<% // Needed for: ResourceBundle, Locale %>
<%@ page import="java.util.*" %>

<% // Needed for: CommandContext %>
<%@ page import="com.ibm.commerce.command.*" %>

<% // Needed for: JSPHelper %>
<%@ page import="com.ibm.commerce.server.*" %>

<% // Needed for: DataBeanManager %>
<%@ page import="com.ibm.commerce.beans.*" %>

<% // Needed for: UserRegistrationDataBean, RoleDataBean %>
<%@ page import="com.ibm.commerce.user.beans.*" %> 

<% // Needed for: CatalogEntryDataBean, ProductDataBean, ItemDataBean, AttributeDataBean %>
<%@ page import="com.ibm.commerce.catalog.beans.*" %>

<% // Needed for: AttributeAccessBean %>
<%@ page import="com.ibm.commerce.catalog.objects.*" %>

<% // Needed for: ContractDataBean %>
<%@ page import="com.ibm.commerce.contract.beans.*" %>

<% // Needed for: PriceDataBean to format the price %>
<%@ page import="com.ibm.commerce.price.beans.PriceDataBean" %>

<% // Needed for: BigDecimal %>
<%@ page import="java.math.*" %>

<%@ include file="../../../include/EnvironmentSetup.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>

<wcbase:useBean id="item" classname="com.ibm.commerce.catalog.beans.ItemDataBean"  />

<%
String itemId = jhelper.getParameter("productId");
String parent_category_rn = jhelper.getParameter("parent_category_rn");


PriceDataBean itemPrice = null; 

try {
  itemPrice = item.getCalculatedContractPrice();
}
catch (Exception e) {
// no price	
}

request.setAttribute("pageName", "Catalog");

%>

<SCRIPT language="javascript">

function AddToShopCart(form)
{
	form.action='OrderItemAdd';
	form.URL.value='OrderItemDisplay?orderId=.';
	form.submit();
}

function AddToFavorites(form)
{
	form.action='FavoritesListAddToExistDisplayView';
	form.submit();
}

</SCRIPT>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title><%=item.getDescription().getName()%></title>
	<link rel=stylesheet href="<%=fileDir%>PCDMarket.css" type="text/css">
</head>


<body marginheight="0" marginwidth="0" leftmargin="0" topmargin="0">

<%@ include file="../../../include/HeaderDisplay.jspf"%>

<!-- Start Main Table - Consists of TD for Left Bar, TD for Content and TD for Quicklinks -->
<table border="0" cellpadding="0" cellspacing="0" width="750">
<tbody>
<tr>
  <td valign="top" class="dbg" width="150" rowspan="2"> 
    <%
     String incfile = includeDir + "SidebarDisplay.jsp";
    %>
    <jsp:include page="<%=incfile%>" flush="true"/></td>
  <!-- End  Left Nav Bar TD -->

  <td valign="top" width="10">&nbsp;</td>

  <!-- Begin Main Content TD -->

  <td valign="top" colspan="2">

  <!--START MAIN CONTENT-->
	<div align="left">
	<table border="0" cellspacing="0" cellpadding="0" width="600">
       <tbody>
        <tr>
          <td><a name="mainContent"></a>
            <span class="bct">&nbsp;&nbsp;&nbsp;</span>
		<a class="bctl" href="StoreCatalogDisplay?storeId=<%=storeId%>&catalogId=<%=catalogId%>&langId=<%=languageId%>"><%=storeText.getString("Breadcrumb_CommercePlaza")%></a>
		<span class="bct">&nbsp;&nbsp;&nbsp;&gt;&nbsp;&nbsp;&nbsp;</span>
		<span class="bct"><%=storeText.getString("Breadcrumb_SelectItems")%></span>
		</td>
	  </tr>
        <tr>
          <td valign="top" align="left">
            <div align="left" class="title"><%=item.getDescription().getName()%></div></td>
          <td valign="top" align="right">
            <div align="right">
            <img src="<%=fileDir%>images/hdr_products.gif" height="72" alt="<%=storeText.getString("ItemDisplay_Title")%>"></div></td>
   	   </tr>
	</tbody></table>
	</div>

</td></tr>

<tr>
  <td valign="top" width="10">&nbsp;</td>

 <td valign="top" width="440">
	
  <table cellSpacing="0" cellPadding="0" width="600" border="0">
    <tbody>
    <form NAME="OrderItemForm" ACTION="" METHOD="POST">
    	 <input type="hidden" name="storeId" value="<%=storeId%>">
    	  <input type="hidden" name="orderId" value=".">
    	  <input type="hidden" name="langId" value="<%=languageId%>">
    	  <input type="hidden" name="catalogId" value="<%=catalogId%>">
    	  <input type="hidden" name="URL" value="">
    	  <input type="hidden" name="errorViewName" value="GenericApplicationError">				
    	  <input type="hidden" name="catEntryId" value="<%=itemId%>">
    	  <input type="hidden" name="quantity" value="1">
    	  <input type="hidden" name="allocate" value="*n">
    	  <input type="hidden" name="reverse" value="*n">
    	  <input type="hidden" name="backorder" value="*n">
    	  <input type="hidden" name="check" value="*n">
    	  <input type="hidden" name="merge" value="*n">
	  <input type="hidden" name="remerge" value="*n">
        <input type=hidden name="partNumber" value="<%=item.getPartNumber()%>">
    </form>
    
    <tr>
      <td><img src="<%=item.getObjectPath()%><%=item.getDescription().getFullImage()%>" alt="<%=item.getDescription().getName()%>" border="0" /></td>
 	<td valign="top" width="10">&nbsp;</td>
      <td>
      	<div align="right">
	<table cellSpacing="0" cellPadding="0" border="0" width="300">
	 <tbody>

	<%
	if (itemPrice != null)
	{
	%>	
	  <tr>
	    <td><span class=small style="COLOR: #cc6600"><b><%=itemPrice%></b></span>
	    <span class=small style="COLOR: #666666"><%=storeText.getString("ItemDisplay_ListPrice")%></span></td>
	  </tr>
	<%
	} // end if
	%>

	  <tr>
	    <td><img height="4" width="1" src="<%=fileDir%>images/c.gif" /></td></tr>

	  <tr>
	    <td><img height="4" width="1" src="<%=fileDir%>images/c.gif" /></td></tr>

	  <tr>
	    <td><img height="4" width="1" src="<%=fileDir%>images/c.gif" /></td></tr>

	  <% if(itemPrice != null) { %>
	  <tr>
	    <td><img alt="<%=storeText.getString("ItemDisplay_AddToCart")%>" src="<%=fileDir%>images/btn_addcart.gif" align=absMiddle border=0 />
	      <a style="TEXT-DECORATION: none" href="javascript:AddToShopCart(document.OrderItemForm)" onClick="AddToShopCart(document.OrderItemForm); return false;">&nbsp;<b><%=storeText.getString("ItemDisplay_AddToCart")%>
	      </b></a></td></tr>

	  <tr>
	    <td><img height="4" width="1" src="<%=fileDir%>images/c.gif" /></td></tr>
	
	  <tr>
	    <td><img alt="<%=storeText.getString("ItemDisplay_AddFavorites")%>" src="<%=fileDir%>images/arrow_rd.gif" border="0" />
	    <a style="TEXT-DECORATION: none" href="javascript:AddToFavorites(document.OrderItemForm)" onClick="AddToFavorites(document.OrderItemForm); return false;">&nbsp;<b><%=storeText.getString("ItemDisplay_AddFavorites")%>
		</b></a></td></tr>
	  <% } %>
	</tbody></table>
	</div>
	
    </td></tr></tbody></table>

<!-- Start to display attachments -->
										<%-- 
										  ***
										  *	Start: Show Catalog Attachments
										  * The attachments for each usage will be displayed
										  ***
										--%>
										<c:forEach var="attachUsage" items="${item.attachmentUsages}" >	
											<c:set property="attachmentUsage" value="${attachUsage.identifier}" target="${item}" />
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
														<c:set var="AttachmentDataBeans" value="${item.attachmentsByUsage}" />
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
     <div align="left">
     <table cellSpacing="0" cellPadding="0" width="442" border="0">
       <tr>
         <td class="hbg"><img class="imgHeightFix" src="<%=fileDir%>images/c.gif" width="100" height="8" border="0" alt="" /></td>
       </tr>
     </table>
     </div>


    <!-- Display General Information -->
    
			<table cellspacing="0" cellpadding="2" width="442">
				<tbody>

					<tr>
						<td><span class="subtitle"><%=storeText.getString("ItemDisplay_GenHeading")%></span></td>
					</tr>

					<tr vAlign=top>
						<td width="142"><span class=small><%=storeText.getString("ItemDisplay_SKU")%></span></td>
						<td width="300"><span class=small><%=item.getPartNumber()%></span></td>
					</tr>

					<tr vAlign=top>
						<td width="142"><span class=small><%=storeText.getString("ItemDisplay_Description")%></span></td>
						<td width="300"><span class=small><%=item.getDescription().getShortDescription()%></span></td>
					</tr>

	<%
	if (itemPrice != null) {	
	%>
					<tr vAlign=top>
						<td width="142"><span class=small><%=storeText.getString("ItemDisplay_ListPrice")%></span></td>
						<td width="300"><span class=small><%=itemPrice%></span></td>
					</tr>
	<%
	} // end if
	%>
				</tbody>
			</table>

			<!-- Display Attributes -->
    <table cellspacing="0" cellpadding="2" width="442">
      <tbody>	
	<tr>
	  <td colspan="2"><span class="subtitle"><%=storeText.getString("ItemDisplay_ModelAttr")%></span></td></tr>
	  <%

	  String currentGroupName = "";
	  String groupName = "";

	  AttributeValueDataBean attributeValues[] = item.getAttributeValueDataBeans(new Integer(languageId));
								
	    	// Loop through attributes values and only show the value that is relavent to the attribute for this SKU
	    	for (int x=0; x < attributeValues.length; x++) 
		{
			groupName = attributeValues[x].getAttributeDataBean().getGroupName();
			if(groupName == null) { groupName = ""; }
			if ( !groupName.equals(currentGroupName) ) {
				currentGroupName = groupName;
			%>
				<tr><td colspan="2"><br/><span class="subtitle"><%=groupName%></span></td></tr>
	            <tr><td colspan="2" class="gbg" height="1"><img class="imgHeightFix" src="<%=fileDir%>images/c.gif" width="1" alt="" /></td></tr>
			<%
			}
			%>

			<tr>
    			<td width="142"><span class="small"><strong><%=attributeValues[x].getAttributeDataBean().getDescription()%></strong></span></td>
				<td width="300"><span class="small" style="word-break: break-all;"><%=attributeValues[x].getValue()%></span></td>
			</tr>
		<%
		}
		%>
	</tbody></table>
     
     <!-- Display footer buttons -->

     <% if(itemPrice != null) { %>
     <table cellSpacing="0" cellPadding="0" width="442" align="center" border="0">
       <tr>
         <td class="gbg"><img class="imgHeightFix" src="<%=fileDir%>images/c.gif" width="100%" height="1" border="0" alt="" /></td></tr></table>

	<br/>
     
	<table cellSpacing="0" cellPadding="0" width="342" border="0">
	<tbody>
		<tr>
			<td valign="left"><img src="<%=fileDir%>images/c.gif" width="1" height="1" border="0" alt="" /></td>
			<td align="right"><img alt="<%=storeText.getString("ItemDisplay_AddToCart")%>" src="<%=fileDir%>images/btn_addcart.gif" align=absMiddle border=0 /></td>
		      <td><a style="TEXT-DECORATION: none" href="javascript:AddToShopCart(document.OrderItemForm)" onClick="AddToShopCart(document.OrderItemForm); return false;">&nbsp;<b><%=storeText.getString("ItemDisplay_AddToCart")%></b></a>&nbsp;&nbsp;&nbsp;</td>           
		      <td align="right"><img alt="<%=storeText.getString("ItemDisplay_AddFavorites")%>" src="<%=fileDir%>images/arrow_rd.gif"  border=0 /></td>
	            <td><a style="TEXT-DECORATION: none" href="javascript:AddToFavorites(document.OrderItemForm)" onClick="AddToFavorites(document.OrderItemForm); return false;">&nbsp;<b><%=storeText.getString("ItemDisplay_AddFavorites")%></b></a></td>
		</tr>
	</tbody></table>
	<% } %>

	<br/>

     <table cellSpacing="0" cellPadding="0" width="442" align="center" border="0">
       <tr>
         <td class="gbg"><img class="imgHeightFix" src="<%=fileDir%>images/c.gif" width="100" height="1" border="0" alt="" /></td></tr></table>

	<br/>
     
    <!--END MAIN CONTENT-->

    </td>

    <!-- End of Main Content TD -->
 
    <td valign="top" width="150">   
    	<%@ include file="../../../include/ProductCrossSellDisplay.jspf"%>
    </td>
   
    
</tr></tbody></table>
   
<!-- End Main Table -->

<%@ include file="../../../include/FooterDisplay.jspf"%>

</body>
</html>