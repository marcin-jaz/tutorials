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
<%@ page import="java.util.*" %>
<%@ page import="com.ibm.commerce.server.ECConstants" %>
<%@ page import="com.ibm.commerce.server.JSPHelper" %>
<%@ page import="com.ibm.commerce.server.JSPResourceBundle" %>
<%@ page import="com.ibm.commerce.command.CommandContext" %>

<% // Page specific beans%>
<%@ page import="com.ibm.commerce.beans.DataBeanManager" %>
<%@ page import="com.ibm.commerce.beans.ErrorDataBean" %>
<%@ page import="com.ibm.commerce.catalog.beans.CatalogDataBean" %>
<%@ page import="com.ibm.commerce.catalog.beans.CategoryDataBean" %>
<%@ page import="com.ibm.commerce.catalog.beans.ProductDataBean" %>
<%@ page import="com.ibm.commerce.catalog.beans.PackageDataBean" %>
<%@ page import="com.ibm.commerce.catalog.beans.BundleDataBean" %>

<%@ include file="../../../include/EnvironmentSetup.jspf"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>

<wcbase:useBean id="category" classname="com.ibm.commerce.catalog.beans.CategoryDataBean" />

<%
try {
	//Parameters may be encrypted. Use JSPHelper to get
	//URL parameter instead of request.getParameter().
	JSPHelper jhelper = new JSPHelper(request);

	String catalogId = jhelper.getParameter("catalogId");
	String storeId = jhelper.getParameter("storeId");
	String languageId = jhelper.getParameter("langId");
	String categoryId = jhelper.getParameter("categoryId");
	String parentCategoryId = jhelper.getParameter("parent_category_rn");

	String sParentCategoriesLinkList = "";
	CategoryDataBean parentCategories[];
	parentCategories = category.getParentCategories();
	int parentCatCounter = 0;
	while (parentCategories != null && parentCategories.length > 0 && parentCatCounter < 4) {
		com.ibm.commerce.beans.DataBeanManager.activate(parentCategories[0], request);

		String strDesc = parentCategories[0].getDescription().getShortDescription();
		if(strDesc == null || strDesc.trim().length() == 0) { strDesc = parentCategories[0].getDescription().getName(); }
		sParentCategoriesLinkList =
			"<a href=\"CategoryDisplay?catalogId=" + catalogId + "&storeId=" + storeId + "&categoryId=" + parentCategories[0].getCategoryId() +
			"&langId=" + languageId + "\">" +
			strDesc +
			"</a> &gt; " + sParentCategoriesLinkList;

		parentCategories = parentCategories[0].getParentCategories();
		parentCatCounter++;
	}
	if (parentCategories != null && parentCategories.length > 0) {
		sParentCategoriesLinkList = " ... &gt; " + sParentCategoriesLinkList;
	}
	// Append Home.
	sParentCategoriesLinkList =
		"<a href=\"TopCategoriesDisplay?langId=" + languageId + "&catalogId=" + catalogId + "&storeId=" + storeId + "\" >" +
		tooltechtext.getString ("Header_Home") +
		"</a> &gt; " + sParentCategoriesLinkList;

	/*
	 * If the parent category id is not supplied in the URL (parent_category_rn),
	 * then get any parent category id from the category databean
	 */
	if (parentCategoryId == null || parentCategoryId.equals("")) {
		if (category.getParentCategories().length > 0) {
			// Take the first product we find in the category and get its parent
			parentCategoryId = category.getParentCategories()[0].getCategoryId();
		} else {
			// Only happens when no parent exists
			parentCategoryId = catalogId;
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
	CategoryDataBean subCategories[];
	subCategories= parentCategory.getSubCategories();

	CategoryDataBean subcats[];
	subcats= category.getSubCategories();

	ProductDataBean products[];
	products = category.getProducts();

	BundleDataBean bundles[];
	bundles = category.getBundles();

	PackageDataBean packages[];
	packages = category.getPackages();
%>

    <table cellpadding="8">
        <tr>
            <td>
            <h1>
            <%= sParentCategoriesLinkList %><%=category.getDescription().getName()%>
            </h1>
            <table class="list" cellpadding="0" cellspacing="0" border="0" width="605">
				<tr>
					<td>
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
					</td>
				</tr>
			<!-- SUB-CATEGORIES -->
            <%
        	// show the subcategories
        	CategoryDataBean subcat;
        	String sImagePath = null;
        	String sName      = null;
        	String sShortDesc = null;
        	String sLongDesc  = null;

        	for (int i = 0; i < subcats.length; ++i) {
        		subcat = subcats[i];
        		sImagePath = subcat.getDescription().getThumbNail();
        		sName      = subcat.getDescription().getName();
        		sShortDesc = subcat.getDescription().getShortDescription();
        		sLongDesc  = subcat.getDescription().getLongDescription();
            %>
                <tr>
                    <td>
                    <table width="100%" border="0" cellpadding="2" cellspacing="3">
						<tr>
							<td valign="top" align="left" width="60">
								<% if (sImagePath != null && !sImagePath.equals("")) { %>
								<a href="CategoryDisplay?catalogId=<%=catalogId%>&storeId=<%=storeId%>&categoryId=<%=subcat.getCategoryId()%>&langId=<%=languageId%>&parent_category_rn=<%=categoryId%>">
								<img src="<%= subcat.getObjectPath() %><%= sImagePath %>" alt="<%=sShortDesc%>" hspace="5" width="50" height="50" border="0" align="left">
								</a>
								<% } %>
							</td>
							<td align="left" valign="top">
								<a href="CategoryDisplay?catalogId=<%=catalogId%>&storeId=<%=storeId%>&categoryId=<%=subcat.getCategoryId()%>&langId=<%=languageId%>&parent_category_rn=<%=categoryId%>">
								<font color="#4C6178" style="font-family : Verdana;" size="2">
									<B><%= sName %></B>
								</font>
								<br />
								</a>
								<% if (sShortDesc != null) { %>
								<font color="#32404F" style="font-family : Verdana;" size="2">
									<%= sShortDesc %>
								</font>
								<% } %>
								<br />
							</td>
						</tr>
					</TABLE>
					</td>
				</tr>
                <%
        	    }
            	if (subcats.length > 0) {
                %>
				<tr>
					<td>
						<hr />
					</td>
				</tr>
                <%
            	}
                %>

            	<!-- PRODUCTS -->
                <%
            	// show the products
            	ProductDataBean product;

            	for (int i = 0; i < products.length; ++i) {
            		product = products[i];
            		sImagePath = product.getDescription().getFullImage();
            		sName      = product.getDescription().getName();
            		sShortDesc = product.getDescription().getShortDescription();
            		sLongDesc  = product.getDescription().getLongDescription();
            		if(sShortDesc == null || sShortDesc.trim().length() == 0) { sShortDesc = sName; }
                %>
				<tr>
					<td>
						<table width="100%" border="0" cellpadding="2" cellspacing="3">
						<tr>
							<td valign="top" align="left" width="60">
								<% if (sImagePath != null && !sImagePath.equals("")) { %>
								<a href="ProductDisplay?catalogId=<%=catalogId%>&storeId=<%=storeId%>&productId=<%=product.getProductID()%>&langId=<%=languageId%>&parent_category_rn=<%=categoryId%>">
								<img src="<%=product.getObjectPath()%><%= sImagePath %>" alt="<%=sShortDesc%>" hspace="5" width="50" height="50" border="0" align="left">
								</a>
								<% } %>
							</td>
							<td align="left" valign="top">
								<a href="ProductDisplay?catalogId=<%=catalogId%>&storeId=<%=storeId%>&productId=<%=product.getProductID()%>&langId=<%=languageId%>&parent_category_rn=<%=categoryId%>">
								<font color="#4C6178" style="font-family : Verdana;" size="2">
								<b><%= sShortDesc %></b>
								</font>
								</a>
								<br />
								<% if (sLongDesc != null) { %>
								<font color="#32404F" style="font-family : Verdana;" size="2">
									<%= sLongDesc %><br />
								</font>
								<% } %>
							</td>
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

            	for (int i = 0; i < bundles.length; ++i) {
            		bundle = bundles[i];
            		sImagePath = bundle.getDescription().getFullImage();
            		sName      = bundle.getDescription().getName();
            		sShortDesc = bundle.getDescription().getShortDescription();
            		sLongDesc  = bundle.getDescription().getLongDescription();
            		if(sShortDesc == null || sShortDesc.trim().length() == 0) { sShortDesc = sName; }
                %>
				<tr>
					<td>
						<TABLE WIDTH="100%" BORDER=0 CELLPADDING=2 CELLSPACING=3>
						<tr>
							<td valign="top" align="left">
								<% if (sImagePath != null && !sImagePath.equals("")) { %>
								<a href="ProductDisplay?catalogId=<%=catalogId%>&storeId=<%=storeId%>&productId=<%=bundle.getBundleID()%>&langId=<%=languageId%>&parent_category_rn=<%=categoryId%>">
								<img src="<%=bundle.getObjectPath()%><%= sImagePath %>" alt="<%=sShortDesc%>" hspace="5" width="50" height="50" border="0" align="left">
								</a>
								<% } %>
							</td>
							<td align="left" valign="top">
								<a href="ProductDisplay?catalogId=<%=catalogId%>&storeId=<%=storeId%>&productId=<%=bundle.getBundleID()%>&langId=<%=languageId%>&parent_category_rn=<%=categoryId%>">
								<font color="#4C6178" style="font-family : Verdana;" size="2">
								<b><%= sShortDesc %></b>
								</font>
								</a>
								<br />
								<% if (sLongDesc != null) { %>
								<font color="#32404F" style="font-family : Verdana;" size="2">
									<%= sLongDesc %><br />
								</font>
								<% } %>
							</td>
						</tr>
						</TABLE>
					</td>
				</tr>
                <%
            	}
                %>

	            <!-- PACKAGES -->
                <%
            	// show the packages
            	PackageDataBean pack;

            	for (int i = 0; i < packages.length; ++i) {
            		pack = packages[i];
            		sImagePath = pack.getDescription().getFullImage();
            		sName      = pack.getDescription().getName();
            		sShortDesc = pack.getDescription().getShortDescription();
            		sLongDesc  = pack.getDescription().getLongDescription();
            		if(sShortDesc == null || sShortDesc.trim().length() == 0) { sShortDesc = sName; }
                %>
				<tr>
					<td>
						<table width="100%" border=0 cellpadding=2 cellspacing=3>
						<tr>
							<td valign="top" align="left">
								<% if (sImagePath != null && !sImagePath.equals("")) { %>
								<a href="ProductDisplay?catalogId=<%=catalogId%>&storeId=<%=storeId%>&productId=<%=pack.getPackageID()%>&langId=<%=languageId%>&parent_category_rn=<%=categoryId%>">
								<img src="<%=pack.getObjectPath()%><%= sImagePath %>" alt="<%=sShortDesc%>" hspace="5" width="50" height="50" border="0" align="left">
								</a>
								<% } %>
							</td>
							<td align="left" valign="top">
								<a href="ProductDisplay?catalogId=<%=catalogId%>&storeId=<%=storeId%>&productId=<%=pack.getPackageID()%>&langId=<%=languageId%>&parent_category_rn=<%=categoryId%>">
								<font color="#4C6178" style="font-family : Verdana;" size="2">
								<b><%= sShortDesc %></b>
								</font>
								</a>
								<br />
								<% if (sLongDesc != null) { %>
								<font color="#32404F" style="font-family : Verdana;" size="2">
									<%= sLongDesc %><br />
								</font>
								<% } %>
							</td>
						</tr>
						</table>
					</td>
				</tr>
                <%
            	}
                %>
				</table>
			</td>
		</tr>
	</table>
<%
}
catch (Exception e) {
    e.printStackTrace(new PrintWriter(out));

    Throwable t = e;
    while (t != null && t instanceof javax.servlet.ServletException) {
        t = (Exception) ((javax.servlet.ServletException)t).getRootCause();
        t.printStackTrace();
    }
}
%>