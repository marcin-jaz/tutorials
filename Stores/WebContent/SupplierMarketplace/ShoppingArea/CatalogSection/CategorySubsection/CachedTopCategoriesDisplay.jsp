<%
//********************************************************************
//*-------------------------------------------------------------------
//* Licensed Materials - Property of IBM
//*
//* WebSphere Commerce
//*
//* (c) Copyright IBM Corp. 2001, 2002
//*
//* US Government Users Restricted Rights - Use, duplication or
//* disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
//*
//*-------------------------------------------------------------------
//*
%>



<% // All JSPs requires these packages for getResource.jsp which is used for multi language support %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.ibm.commerce.server.ECConstants" %>
<%@ page import="com.ibm.commerce.server.JSPHelper" %>
<%@ page import="com.ibm.commerce.server.JSPResourceBundle" %>
<%@ page import="com.ibm.commerce.command.CommandContext" %>

<% // Page specific beans%>
<%@ page import="com.ibm.commerce.beans.DataBeanManager" %>
<%@ page import="com.ibm.commerce.catalog.beans.CatalogDataBean" %>
<%@ page import="com.ibm.commerce.catalog.beans.CategoryDataBean" %>
<%@ page import="com.ibm.commerce.catalog.beans.ProductDataBean" %>
<%@ page import="com.ibm.commerce.catalog.beans.ItemDataBean" %>
<%@ page import="com.ibm.commerce.catalog.beans.PackageDataBean" %>
<%@ page import="com.ibm.commerce.catalog.beans.BundleDataBean" %>

<%@ include file="../../../include/EnvironmentSetup.jspf"%>

<% response.setContentType(tooltechtext.getString("ENCODESTATEMENT")); %>

<%
    //Parameters may be encrypted. Use JSPHelper to get
    //URL parameter instead of request.getParameter().
    JSPHelper jhelper = new JSPHelper(request);

    String storeId = jhelper.getParameter("storeId");
    String catalogId = jhelper.getParameter("catalogId");
    String languageId = jhelper.getParameter("langId");
 %>

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
%>

	<table cellpadding="8" border="0">
	<tr>
		<td>
		<h1><%=tooltechtext.getString("MainCat_Title")%></h1>
			<ul>
            <%
			//Top Category
			for (int i = 0; i < topCategories.length; ++i)
				{
				tcategory = topCategories[i];
				tcategoryId = tcategory.getCategoryId();
            %>
				<li>
				<a class="catalog" href="CategoryDisplay?catalogId=<%=catalogId%>&storeId=<%=storeId%>&categoryId=<%=tcategoryId%>&langId=<%=languageId%>&parent_category_rn=<%=tcategoryId%>">
					<font color="#4C6178" style="font-family : Verdana;" size="2">
					<b>
						<%=tcategory.getDescription().getName()%>
					</b>
					</font>
				</a>
				</li>
				<br />
				<br />
        <%
		}
        %>
			</ul>
		</td>
	</tr>
	</table>