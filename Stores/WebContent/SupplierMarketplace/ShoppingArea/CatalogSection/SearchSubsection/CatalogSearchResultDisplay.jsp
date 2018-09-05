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


<% // All JSPs requires these packages for EnvironmentSetup.jsp which is used for multi language support %> 
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.ibm.commerce.server.ECConstants" %>
<%@ page import="com.ibm.commerce.server.JSPHelper" %>
<%@ page import="com.ibm.commerce.server.JSPResourceBundle" %>
<%@ page import="com.ibm.commerce.command.CommandContext" %>

<% // Page specific imports%> 
<%@ page import="com.ibm.commerce.beans.DataBeanManager" %>
<%@ page import="com.ibm.commerce.common.beans.StoreDataBean" %>
<%@ page import="java.text.MessageFormat" %>
<%@ page import="com.ibm.commerce.catalog.beans.CatalogDataBean" %>
<%@ page import="com.ibm.commerce.catalog.beans.CategoryDataBean" %>
<%@ page import="com.ibm.commerce.catalog.beans.CatalogEntryDataBean" %>
<%@ page import="com.ibm.commerce.catalog.objects.CatalogEntryAccessBean" %>
<%@ page import="com.ibm.commerce.catalog.objects.CatalogEntryDescriptionAccessBean" %>
<%@ page import="com.ibm.commerce.catalog.objects.CatalogAccessBean" %>
<%@ page import="com.ibm.commerce.catalog.beans.ItemDataBean" %>
<%@ page import="com.ibm.commerce.catalog.beans.AttributeDataBean" %>
<%@ page import="com.ibm.commerce.catalog.beans.AttributeValueDataBean" %>
<%@ page import="com.ibm.commerce.search.beans.CatEntrySearchListDataBean"%>
<%@ page import="com.ibm.commerce.beans.UrlCommandInvokerDataBean"%>
<%@ page import="com.ibm.commerce.datatype.TypedProperty"%>

<%@ include file="../../../include/EnvironmentSetup.jspf"%>


<%
CommandContext commandContext = (CommandContext) request.getAttribute(ECConstants.EC_COMMANDCONTEXT);

//Parameters may be encrypted. Use JSPHelper to get
//URL parameter instead of request.getParameter().
JSPHelper jhelper = new JSPHelper(request);

String storeId = jhelper.getParameter("storeId");
String languageId = jhelper.getParameter("langId");

//Using the StoreDataBean, find the CatalogID for the this store.
com.ibm.commerce.catalog.beans.CatalogDataBean Catalogs[] = sdb.getStoreCatalogs();
String catalogId = Catalogs[0].getCatalogId();

%>

<jsp:useBean id="catalog" class="com.ibm.commerce.catalog.beans.CatalogDataBean" scope="page">
<%
catalog.setCatalogId(catalogId);
DataBeanManager.activate(catalog, request);
%>
</jsp:useBean>

<%
CategoryDataBean topCategories[] = catalog.getTopCategories();
CategoryDataBean category;
%>


<%

	// Get all search specific URL parameters
	String searchTerm = request.getParameter("searchTerm");
	String searchType = request.getParameter("searchType");
	String searchTermCaseSensitive = request.getParameter("searchTermCaseSensitive");
	String searchTermOperator = request.getParameter("searchTermOperator");
	String filterTerm = request.getParameter("filterTerm");
	String filterType = request.getParameter("filterType");
	String filterTermCaseSensitive = request.getParameter("filterTermCaseSensitive");
	String filterTermOperator = request.getParameter("filterTermOperator");
	String searchTermScope = request.getParameter("searchTermScope");
	String categoryId = request.getParameter("catGroupId");
	String categoryType = request.getParameter("categoryType");
	String qtyAvailable = request.getParameter("qtyAvailable");
	String qtyAvailableOperator = request.getParameter("qtyAvailableOperator");
	String qtyMeasure = request.getParameter("qtyMeasure");
	String qtyMeasureCaseSensitive = request.getParameter("qtyMeasureCaseSensitive");
	String qtyMeasureOperator = request.getParameter("qtyMeasureOperator");
	String paSize = request.getParameter("pageSize");
	String beIndex = request.getParameter("beginIndex");
	String sType = request.getParameter("sType");
	String sResultType = request.getParameter("resultType");

	// B2B model specific parameters 
	String manuf = request.getParameter("manufacturer");
	String manufCaseSensitive = request.getParameter("manufacturerCaseSensitive");
	String manufOperator = request.getParameter("manufacturerOperator");
	String manufPartNum = request.getParameter("manufacturerPartNum");
	String manufPartNumOperator = request.getParameter("manufacturerPartNumOperator");
	String manufPartNumCaseSensitive = request.getParameter("manufacturerPartNumCaseSensitive");
	String sku = request.getParameter("sku");		
	String skuCasesensitive = request.getParameter("skuCaseSensitive");
	String skuOperator = request.getParameter("skuOperator");
	
%>
 
	<jsp:useBean id="catEntSearchListBean" scope="page" class="com.ibm.commerce.search.beans.CatEntrySearchListDataBean" />
	<jsp:setProperty property="*" name="catEntSearchListBean" />

	<%
	catEntSearchListBean.setCommandContext(cmdcontext);


	try {
		// Execute the search bean
   		com.ibm.commerce.beans.DataBeanManager.activate(catEntSearchListBean, request);
	}
	catch(Exception e) {}


	int beginIndex = 0;  // Number of first record on page
	int pageSize = 10;   // Number of records per page
	int totalCount = Integer.parseInt(catEntSearchListBean.getResultCount()); // Total num of results
	
	if (beIndex != null && beIndex.length() != 0)
	{
		beginIndex = Integer.parseInt(beIndex);
	}
	if (paSize != null && paSize.length() != 0)
	{
		pageSize = Integer.parseInt(paSize);
	}
		
	// Get results from the search query
	CatalogEntryDataBean catalogEntries[] = null;
	int totalsize = 0;
	catalogEntries = catEntSearchListBean.getResultList();
	if (catalogEntries != null)
	{
		totalsize = catalogEntries.length;
	}

	// If a SKU, PartNumber or Manufacturer name was searched on, and only 1 result
	//  is available, go to the item display page.
	if (totalsize == 1 && manufPartNum != null && sku != null &&
	    (manufPartNum.length() > 0 || sku.length() > 0)) 
	{
	       UrlCommandInvokerDataBean urlBean = new UrlCommandInvokerDataBean();
	       urlBean.setUrlName("ProductDisplay");
	       TypedProperty iProperties = cmdcontext.getRequestProperties();
	       iProperties.putUrlParam("storeId",storeId);
	       iProperties.putUrlParam("langId",languageId);
	       iProperties.putUrlParam("catalogId",catalogId);
	       iProperties.putUrlParam("productId",catalogEntries[0].getCatalogEntryID());
	
	       urlBean.setRequestProperties(iProperties);  
	       com.ibm.commerce.beans.DataBeanManager.activate(urlBean, request);	
	}
	%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "DTD/xhtml1-transitional.dtd">

<HEAD>
	<TITLE><%=tooltechtext.getString("SerRes_Title")%></TITLE>
	<LINK REL=stylesheet HREF="<%=fileDir%>ToolTech.css" TYPE="text/css">
</HEAD>


<BODY MARGINHEIGHT="0" MARGINWIDTH="0" LEFTMARGIN="0" TOPMARGIN="0" onLoad="if (typeof top.updateStInfo == 'function') top.updateStInfo();">

<flow:ifEnabled feature="customerCare">
<%
// Set header type needed for this JSP for LiveHelp.  This must
// be set before HeaderDisplay.jsp
request.setAttribute("liveHelpPageType", "personal");
%>
</flow:ifEnabled>

<%
String incfile;
incfile = includeDir + "HeaderDisplay.jsp";
%>
<jsp:include page="<%=incfile%>" flush="true"/>  


<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0" WIDTH="790" HEIGHT="99%">
<TR>
	<TD VALIGN="top" BGCOLOR="#4c6178" WIDTH="160"> 

		<%
		incfile = includeDir + "SidebarDisplay.jsp";
		%>
		<jsp:include page="<%=incfile%>" flush="true"/>

	</TD>

	<TD valign="top" width="630">

	<!-- Start Main JSP Content -->
		<table cellpadding="8" cellspacing="0" width="580" border="0" align="left">
		<tr>
			
			<td align="left" valign="top" colspan="3" class="categoryspace">
				<H1><%=tooltechtext.getString("SerRes_Title")%></H1>
				<%
				// Check to see if there are no results.  Make sure this is the first set of results
				if (totalsize == 0 && beginIndex == 0) 
				{ 
				%>
					<font color="red"><font class="strongtext"><br><%=tooltechtext.getString("SerRes_Text3")%></font></font>
				<%
				}else 
				{
				int resultCountOnPage = pageSize + beginIndex;
				if (resultCountOnPage > totalCount) resultCountOnPage = totalCount;
				
				Object[] arguments = {
					new Integer(beginIndex + 1),
					new Integer(resultCountOnPage),
					new Integer(totalCount)
				};
				String myText =  MessageFormat.format(tooltechtext.getString("SerRes_Text9"), arguments);

				%>
					<font class="text"><%=myText%></font>

				<%
				}
				%>
				</td>
		</tr>

		<tr>
			<td align="left" valign="top" width="400" class="topspace" colspan="3"></td>
		</tr>
		<tr>
			<td align="left" valign="top" class="topspace" colspan="3">
				<!-- Start search result table -->
				<table cellpadding="0" width="100%" cellspacing="0" border="0" align="left">

				<%
			
				// Display all results returned by the search bean
				CatalogEntryDataBean catEntry;
				String type="";

				for (int i = 0; i < totalsize; i++)
				{
					catEntry = catalogEntries[i];
					type = catEntry.getType();
			
					String catEntryID = catEntry.getCatalogEntryID();
					catEntry.setCommandContext(catEntSearchListBean.getCommandContext());
	
					if (type.equalsIgnoreCase("ProductBean"))
					{
					%>
						<tr>
							<td align="left" valign="top" class="categoryspace" colspan="8">
								<font class="strongtext"><a href="ProductDisplay?catalogId=<%=catalogId%>&storeId=<%= storeId%>&productId=<%=catEntryID%>&langId=<%=languageId%>"><%=catEntry.getDescription().getShortDescription()%></a></font>
								<font class="text"><br><%=catEntry.getDescription().getLongDescription()%><br><br></font>
							</td>
						</tr>
					<%
					}else  // We have an item bean
					{
					%>
						<tr>
							<td align="left" valign="top" class="categoryspace" colspan="8">
								
								<font class="strongtext"><a href="ProductDisplay?catalogId=<%=catalogId%>&storeId=<%= storeId%>&productId=<%=catEntryID%>&langId=<%=languageId%>"><%=catEntry.getDescription().getShortDescription()%></a></font>
								<font class="text"><br><%=catEntry.getDescription().getLongDescription()%><br>

								<!-- Display item attributes !-->

								<%
								CatalogEntryAccessBean abCatEntry = (CatalogEntryAccessBean)catEntry;
		
								if (abCatEntry.getType().equals(com.ibm.commerce.catalog.common.ECCatalogConstants.EC_CAT_ITEM_BEAN))
								{
									//If the catentry is an item, we get all the attributes and attribute values for the item 
									// using AttributeValueDataBean and AttributeDataBean
									com.ibm.commerce.catalog.beans.ItemDataBean item = new ItemDataBean(abCatEntry);
									AttributeValueDataBean attrvalue[];
									attrvalue = item.getAttributeValueDataBeans(new Integer(languageId));
									AttributeDataBean attribute[] = new AttributeDataBean[attrvalue.length];
									for (int x=0; x<attrvalue.length; x++) 
									{
										attribute[x] = attrvalue[x].getAttributeDataBean();
										%>
										<strong><%=attribute[x].getName()%>:  </strong><%=attrvalue[x].getValue()%>
										<%
									}

								}
								%>
								<br><br></font>
							</td>
						</tr>
					<%
					}
				}
				%>
				</table>
				<!-- End search result table -->  
				
				<%
			
				// If we don't have any results to display, show search tips					
				if (totalsize == 0 && beginIndex == 0) 
				{ 
				%>
					<table cellpadding="4" cellspacing="0" border="0">
					<tr>
						<td>
							<font class="strongtext"><br><%=tooltechtext.getString("SerRes_Text4")%></font><ul>
							<font class="text"><li><%=tooltechtext.getString("SerRes_Text5")%>
							<font class="text"><br><li><%=tooltechtext.getString("SerRes_Text6")%>
							<font class="text"><br><li><%=tooltechtext.getString("SerRes_Text7")%>
							<font class="text"><br><li><%=tooltechtext.getString("SerRes_Text8")%><br><br>
							</ul>
						</td>
					</tr>
					<tr>
						<td align="left">
						
							<!-- Start Back to Search Page Button -->
							<table cellpadding="0" cellspacing="0" border="0">
							<tr>
								<td bgcolor="#ff2d2d" class="pixel"><img src="<%=jspStoreImgDir%>images/lb.gif" border="0"/></td>
								<td bgcolor="#ff2d2d" class="pixel"><img src="<%=jspStoreImgDir%>images/lb.gif" border="0"/></td>
								<td class="pixel"><img src="<%=jspStoreImgDir%>images/r_top.gif" border="0"/></td>
							</tr>
							<tr>
								<td bgcolor="#ff2d2d"><img alt="" src="<%=jspStoreImgDir%>images/lb.gif" border="0"/></td>
								<td bgcolor="#ea2b2b">
								<table cellpadding="2" cellspacing="0" border="0">
									<tr>
										<td class="buttontext">
											<font color="#ffffff"><b>
											<%
											if (sType.equalsIgnoreCase("AdvancedSearch")) 
											{
											%>
												<a href="AdvancedSearchView?langId=<%=languageId%>&storeId=<%=storeId%>&catalogId=<%=catalogId%>&searchTerm=<%=java.net.URLEncoder.encode(searchTerm)%>&searchType=<%=searchType%>&filterTerm=<%=java.net.URLEncoder.encode(filterTerm)%>&filterType=<%=filterType%>&searchTermScope=<%=searchTermScope%>&catGroupId=<%=categoryId%>&manufacturer=<%=java.net.URLEncoder.encode(manuf)%>&manufacturerPartNum=<%=java.net.URLEncoder.encode(manufPartNum)%>&sku=<%=java.net.URLEncoder.encode(sku)%>&pageSize=<%=paSize%>" style="color:#ffffff; text-decoration : none;"><%=tooltechtext.getString("SerRes_Button1")%></a>
											<%
											}
											else
											{
											%>
												<a href="AdvancedSearchView?langId=<%=languageId%>&storeId=<%=storeId%>&catalogId=<%=catalogId%>&searchTerm=<%=java.net.URLEncoder.encode(searchTerm)%>" style="color:#ffffff; text-decoration : none;"><%=tooltechtext.getString("Sidebar_Link1")%></a>
											<%
											}
											%>
											</b></font>
										</td>
									</tr>
									</table>
								</td>
								<td bgcolor="#7a1616"><img alt="" src="<%=jspStoreImgDir%>images/db.gif" border="0"/></td>
							</tr>	
							<tr>
								<td class="pixel"><img src="<%=jspStoreImgDir%>images/l_bot.gif"/></td>
								<td bgcolor="#7a1616" class="pixel" valign="top"><img src="<%=jspStoreImgDir%>images/db.gif" border="0"/></td>
								<td bgcolor="#7a1616" class="pixel" valign="top"><img src="<%=jspStoreImgDir%>images/db.gif" border="0"/></td>
							</tr>
							</table>
							<!-- End Back to Search Page Button -->
							
						</td>
					</tr>
					</table>
										
				<%
				}
				%>
				</td>
			</tr>
			<tr>
				<td>					
				<%
			
							
				// Display previous and next buttons
				if (totalsize > 0 || beginIndex > 0) 
				{ 
				%>
					<table cellpadding="2" cellspacing="0" border="0">
					<tr>
					<td>
					<%
					// Display previous button
					if ((beginIndex-pageSize)>=0) 
					{
					%>
						<!-- Start Previous Button -->
						<table cellpadding="0" cellspacing="0" border="0">
						<tr>
							<td bgcolor="#ff2d2d" class="pixel"><img src="<%=jspStoreImgDir%>images/lb.gif" border="0"/></td>
							<td bgcolor="#ff2d2d" class="pixel"><img src="<%=jspStoreImgDir%>images/lb.gif" border="0"/></td>
							<td class="pixel"><img src="<%=jspStoreImgDir%>images/r_top.gif" border="0"/></td>
						</tr>
						<tr>
							<td bgcolor="#ff2d2d"><img alt="" src="<%=jspStoreImgDir%>images/lb.gif" border="0"/></td>
							<td bgcolor="#ea2b2b">
							<table cellpadding="2" cellspacing="0" border="0">
								<tr>
									<td class="buttontext">
										<font color="#ffffff"><b>
										<%
										// Insert proper URL
										if (sType.equalsIgnoreCase("AdvancedSearch")) 
										{
										%>
											<a href="CatalogSearchResultView?langId=<%=languageId%>&storeId=<%=storeId%>&catalogId=<%=catalogId%>&searchTerm=<%=java.net.URLEncoder.encode(searchTerm)%>&resultType=<%=sResultType%>&searchType=<%=searchType%>&searchTermCaseSensitive=<%=searchTermCaseSensitive%>&searchTermOperator=<%=searchTermOperator%>&filterTerm=<%=java.net.URLEncoder.encode(filterTerm)%>&filterType=<%=filterType%>&filterTermCaseSensitive=<%=filterTermCaseSensitive%>&filterTermOperator=<%=filterTermOperator%>&searchTermScope=<%=searchTermScope%>&catGroupId=<%=categoryId%>&categoryType=<%=categoryType%>&qtyAvailable=<%=qtyAvailable%>&qtyAvailableOperator=<%=qtyAvailableOperator%>&qtyMeasure=<%=qtyMeasure%>&qtyMeasureCaseSensitive=<%=qtyMeasureCaseSensitive%>&qtyMeasureOperator=<%=qtyMeasureOperator%>&pageSize=<%=String.valueOf(pageSize)%>&beginIndex=<%=(String.valueOf(beginIndex-pageSize))%>&sType=<%=sType%>&manufacturer=<%=java.net.URLEncoder.encode(manuf)%>&manufacturerCaseSensitive=<%=manufCaseSensitive%>&manufacturerOperator=<%=manufOperator%>&manufacturerPartNum=<%=java.net.URLEncoder.encode(manufPartNum)%>&manufacturerPartNumOperator=<%=manufPartNumOperator%>&manufacturerPartNumCaseSensitive=<%=manufPartNumCaseSensitive%>&skuCaseSensitive=<%=skuCasesensitive%>&skuOperator=<%=skuOperator%>" style="color:#ffffff; text-decoration : none;">
										<%
										} else {
										%>
											<a href="CatalogSearchResultView?langId=<%=languageId%>&storeId=<%=storeId%>&catalogId=<%=catalogId%>&searchTerm=<%=java.net.URLEncoder.encode(searchTerm)%>&resultType=<%=sResultType%>&pageSize=<%=String.valueOf(pageSize)%>&beginIndex=<%=String.valueOf(beginIndex-pageSize)%>&sType=<%=sType%>&searchTermScope=<%=searchTermScope%>" style="color:#ffffff; text-decoration : none;">
										<%
										}
										%>
										<%= tooltechtext.getString("SerRes_Button1")%></a>
										</b></font>
									</td>
								</tr>
								</table>
							</td>
							<td bgcolor="#7a1616"><img alt="" src="<%=jspStoreImgDir%>images/db.gif" border="0"/></td>
						</tr>	
						<tr>
							<td class="pixel"><img src="<%=jspStoreImgDir%>images/l_bot.gif"/></td>
							<td bgcolor="#7a1616" class="pixel" valign="top"><img src="<%=jspStoreImgDir%>images/db.gif" border="0"/></td>
							<td bgcolor="#7a1616" class="pixel" valign="top"><img src="<%=jspStoreImgDir%>images/db.gif" border="0"/></td>
						</tr>
						</table>						
          					<!-- End Previous Button -->
					<%
					}
					%>
					</td>				
					<td width="20">&nbsp;</td>
					<td>
					<%
					// Display next button
					if (totalsize>=pageSize && beginIndex+pageSize != totalCount)
					{
					%>
						<!-- Start Next Button -->
						<table cellpadding="0" cellspacing="0" border="0">
						<tr>
							<td bgcolor="#ff2d2d" class="pixel"><img src="<%=jspStoreImgDir%>images/lb.gif" border="0"/></td>
							<td bgcolor="#ff2d2d" class="pixel"><img src="<%=jspStoreImgDir%>images/lb.gif" border="0"/></td>
							<td class="pixel"><img src="<%=jspStoreImgDir%>images/r_top.gif" border="0"/></td>
						</tr>
						<tr>
							<td bgcolor="#ff2d2d"><img alt="" src="<%=jspStoreImgDir%>images/lb.gif" border="0"/></td>
							<td bgcolor="#ea2b2b">
							<table cellpadding="2" cellspacing="0" border="0">
								<tr>
									<td class="buttontext">
										<font color="#ffffff"><b>
										<%
										if (sType.equalsIgnoreCase("AdvancedSearch")) 
										{
										%>
											<a href="CatalogSearchResultView?langId=<%=languageId%>&storeId=<%=storeId%>&catalogId=<%=catalogId%>&searchTerm=<%=java.net.URLEncoder.encode(searchTerm)%>&searchType=<%=searchType%>&resultType=<%=sResultType%>&searchTermCaseSensitive=<%=searchTermCaseSensitive%>&searchTermOperator=<%=searchTermOperator%>&filterTerm=<%=java.net.URLEncoder.encode(filterTerm)%>&filterType=<%=filterType%>&filterTermCaseSensitive=<%=filterTermCaseSensitive%>&filterTermOperator=<%=filterTermOperator%>&searchTermScope=<%=searchTermScope%>&catGroupId=<%=categoryId%>&categoryType=<%=categoryType%>&qtyAvailable=<%=qtyAvailable%>&qtyAvailableOperator=<%=qtyAvailableOperator%>&qtyMeasure=<%=qtyMeasure%>&qtyMeasureCaseSensitive=<%=qtyMeasureCaseSensitive%>&qtyMeasureOperator=<%=qtyMeasureOperator%>&pageSize=<%=String.valueOf(pageSize)%>&beginIndex=<%=String.valueOf(beginIndex+pageSize)%>&sType=<%=sType%>&manufacturer=<%=java.net.URLEncoder.encode(manuf)%>&manufacturerCaseSensitive=<%=manufCaseSensitive%>&manufacturerOperator=<%=manufOperator%>&manufacturerPartNum=<%=java.net.URLEncoder.encode(manufPartNum)%>&manufacturerPartNumOperator=<%=manufPartNumOperator%>&manufacturerPartNumCaseSensitive=<%=manufPartNumCaseSensitive%>&skuCaseSensitive=<%=skuCasesensitive%>&skuOperator=<%=skuOperator%>"  style="color:#ffffff; text-decoration : none;">
									
										<%
										} else {
										%>
											<a href="CatalogSearchResultView?langId=<%=languageId%>&storeId=<%=storeId%>&catalogId=<%=catalogId%>&searchTerm=<%=java.net.URLEncoder.encode(searchTerm)%>&resultType=<%=sResultType%>&pageSize=<%=String.valueOf(pageSize)%>&beginIndex=<%=String.valueOf(beginIndex+pageSize)%>&sType=<%=sType%>&searchTermScope=<%=searchTermScope%>" style="color:#ffffff; text-decoration : none;">
										<%
										}
										%>
										<%= tooltechtext.getString("SerRes_Button2") %></a>
										</b></font>
									</td>
								</tr>
								</table>
							</td>
							<td bgcolor="#7a1616"><img alt="" src="<%=jspStoreImgDir%>images/db.gif" border="0"/></td>
						</tr>	
						<tr>
							<td class="pixel"><img src="<%=jspStoreImgDir%>images/l_bot.gif"/></td>
							<td bgcolor="#7a1616" class="pixel" valign="top"><img src="<%=jspStoreImgDir%>images/db.gif" border="0"/></td>
							<td bgcolor="#7a1616" class="pixel" valign="top"><img src="<%=jspStoreImgDir%>images/db.gif" border="0"/></td>
						</tr>
						</table>												
          					<!-- End Next Button -->
					<%
					}
					%>
         					
        				</td>
        				
        			</tr>
      				</table>				
				<%
				}
				%>
				
				
				</tr>
				</table>
				<br>
			</td>
		</tr>
		</table>	
	
	<!-- End Main JSP Content -->

	</TD>
</TR>
</TABLE>

</BODY>
</HTML>
