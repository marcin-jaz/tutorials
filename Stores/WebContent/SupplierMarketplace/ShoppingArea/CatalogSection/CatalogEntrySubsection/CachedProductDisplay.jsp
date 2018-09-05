<!--==========================================================================
Licensed Materials - Property of IBM

WebSphere Commerce

(c) Copyright IBM Corp.  2001, 2005
All Rights Reserved

US Government Users Restricted Rights - Use, duplication or
disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
===========================================================================-->
 
<% // All JSPs requires these packages for getResource.jsp which is used for multi language support %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>  <% // Needed for: ResourceBundle, Locale %>
<%@ page import="com.ibm.commerce.server.ECConstants" %>
<%@ page import="com.ibm.commerce.server.JSPHelper" %>
<%@ page import="com.ibm.commerce.server.JSPResourceBundle" %>
<%@ page import="com.ibm.commerce.command.CommandContext" %>

<% // Page specific beans%>
<%@ page import="com.ibm.commerce.beans.DataBeanManager" %>
<%@ page import="com.ibm.commerce.catalog.beans.AttributeValueDataBean" %>
<%@ page import="com.ibm.commerce.catalog.beans.AttributeDataBean" %>
<%@ page import="com.ibm.commerce.catalog.beans.CategoryDataBean" %>
<%@ page import="com.ibm.commerce.catalog.beans.ProductDataBean" %>
<%@ page import="com.ibm.commerce.catalog.beans.ItemDataBean" %>
<%@ page import="com.ibm.commerce.catalog.objects.ItemAccessBean" %>
<%@ page import="com.ibm.commerce.catalog.objects.AttributeAccessBean" %>
<%@ page import="com.ibm.commerce.catalog.objects.CatalogEntryDescriptionAccessBean" %>

<%@ include file="../../../include/EnvironmentSetup.jspf"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>

<wcbase:useBean id="product" classname="com.ibm.commerce.catalog.beans.ProductDataBean" />

<%
    // JSPHelper provides you with a easy way to retrieve URL parameters when they are encrypted
    JSPHelper jhelper = new JSPHelper(request);

    String catalogId = jhelper.getParameter("catalogId");
    String languageId = jhelper.getParameter("langId");
    String storeId = jhelper.getParameter("storeId");
    String parentCategoryId = jhelper.getParameter("parent_category_rn");
    String productId = jhelper.getParameter("productId");

    String strProdDesc = product.getDescription().getShortDescription();
    if(strProdDesc == null || strProdDesc.trim().length() == 0) {
        strProdDesc = product.getDescription().getName();
    }

    // Get all the items for this product.
    ItemAccessBean itemsAB[] = product.getItems();
    ItemAccessBean itemAB;

    CatalogEntryDescriptionAccessBean catalogEntryDescriptionAB;

    CategoryDataBean parentCategory = null;

    if (parentCategoryId != null && !parentCategoryId.equals(""))
    {
    	parentCategory = new CategoryDataBean ();
    	parentCategory.setCategoryId(parentCategoryId);
    	DataBeanManager.activate(parentCategory, request);
    }
%>

	<table cellpadding="5">
	<tr>
		<td>
			<h1><%=tooltechtext.getString("ProdDisp_Title")%></h1>
			<p><br />

			<table border="0" cellspacing="0" cellpadding="0">

			<tr>
				<td>
					<img src="<%=product.getObjectPath()%><%=product.getDescription().getFullImage()%>" alt="<%=strProdDesc%> <%=tooltechtext.getString("ProdDisp_image")%>" width="150" height="150" border="0">
				</td>

				<td Valign="top">
					<table WIDTH=100% CELLSPACING="0" CELLPADDING="0">
					<tr>
						<td valign="top">&nbsp;&nbsp;</td>
						<td valign="top">
							<strong><%=tooltechtext.getString("ProdDisp_Text1")%> </strong>
							<font class="P"><%=strProdDesc%></FONT>
							<br /><br />
						</td>
					</tr>

					<tr>
						<td valign="top">&nbsp;&nbsp;</td>
						<td valign="top">
							<strong><%=tooltechtext.getString("ProdDisp_Text2")%> </strong>
							<font class="P"><%=product.getDescription().getLongDescription()%></FONT>
							<br /><br />
						</td>
					</tr>
					</table>
				</td>

			</tr>
			</table>
<!-- Start of display attachments -->
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
<!-- End of display attachments -->
			<!-- Display items -->

			<H1><%=tooltechtext.getString("ProdDisp_Items")%> </H1>

			<table cellpadding=0 cellspacing=0 border=0 width="605" bgcolor="#4C6178">
			<tr>
				<td>
					<table width="100%" border="0" cellpadding="2" cellspacing="1">
					<tr bgcolor="#4C6178" height="25">

						<th valign="center" align="left">
							<strong><%=tooltechtext.getString("ProdDisp_Col1")%> </strong>
						</th>

						<th valign="center" align="left">
							<font style="font-family : Verdana;" color="#FFFFFF">
							<strong><%=tooltechtext.getString("ProdDisp_Col2")%> </strong>
							</font>
						</th>

						<th valign="center" align="left">
							<font style="font-family : Verdana;" color="#FFFFFF">
							<strong><%=tooltechtext.getString("ProdDisp_Col3")%> </strong>
							</font>
						</th>

						<th valign="center" align="left">
							<font style="font-family : Verdana;" color="#FFFFFF">
							<strong><%=tooltechtext.getString("ProdDisp_Col4")%> </strong>
							</font>
						</th>

						<th valign="center" align="left">
							<font style="font-family : Verdana;" color="#FFFFFF">
							<strong><%=tooltechtext.getString("ProdDisp_Col5")%> </strong>
							</font>
						</th>

					</tr>

<%

					String rowColor;

					for (int i = 0; i < itemsAB.length; i++) {
						itemAB = itemsAB[i];
						catalogEntryDescriptionAB = itemAB.getDescription(new Integer(languageId));

						//To alternate row color for the item list table

						if (i%2 == 0) {
							rowColor = "#ffffff";
						} else {
							rowColor = "#bccbdb";
						}

						String sOnAuction = itemAB.getOnAuction();
						String sItemURL = null;
						sItemURL = "ProductDisplay?catalogId=" + catalogId + "&storeId=" + storeId + "&productId=" + itemAB.getCatalogEntryReferenceNumber() + "&langId=" + languageId;

						// This is added mainly for caching
						if (sOnAuction.equals("1")) {
							sItemURL = sItemURL + "&onAuction=true";
						}
%>


					<tr bgcolor="<%=rowColor%>">
						<td>
							<%
							%>
							<A class="catalog" href="<%= sItemURL %>">
							<%= catalogEntryDescriptionAB.getName() %>
							</A>
						</td>
						<td>
							<%
							ItemDataBean item = new ItemDataBean();
							item.setItemID(itemAB.getCatalogEntryReferenceNumber());
							DataBeanManager.activate (item, request);

							AttributeValueDataBean attrvalue[];
							attrvalue = item.getAttributeValueDataBeans(new Integer(languageId));

			                // Loop through attributes values and only show the value that is relavent to the attribute for this SKU
			                for (int x=0; x < attrvalue.length; x++)
			              	{
			                     %>
			                     <strong><%=attrvalue[x].getAttributeDataBean().getDescription()%> : </strong>
			                     <%=attrvalue[x].getValue()%><br>
			              	     <%
			              	}
			              	%>
						</td>
						<td><%= itemAB.getPartNumber() %></td>
						<td><%= itemAB.getManufacturerName() %></td>
						<td><%= itemAB.getManufacturerPartNumber() %></td>
					</tr>

						<%
						}
						%>

					</table>
				</td>
			</tr>
			</table>
		</td>
	</tr>
	</table>

