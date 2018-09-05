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


<%@ page import="java.util.Locale" %>
<%@ page import="java.util.ResourceBundle" %>
<%@ page import="com.ibm.commerce.command.CommandContext" %>

<%@ page import="java.text.MessageFormat" %>
<%@ page import="com.ibm.commerce.server.JSPHelper" %>
<%@ page import="com.ibm.commerce.beans.DataBeanManager" %>
<%@ page import="com.ibm.commerce.ras.ECMessageHelper" %>
<%@ page import="com.ibm.commerce.server.ECConstants" %>
<%@ page import="com.ibm.commerce.catalog.beans.CatalogEntryDataBean" %>
<%@ page import="com.ibm.commerce.catalog.objects.CatalogEntryDescriptionAccessBean" %>
<%@ page import="com.ibm.commerce.catalog.objects.CatalogAccessBean" %>
<%@ page import="com.ibm.commerce.search.beans.CatEntrySearchListDataBean" %>
<%@ page import="com.ibm.commerce.catalog.beans.CatalogEntryDataBean" %>
<%@ page import="com.ibm.commerce.price.beans.PriceDataBean" %>


<%@ include file="../../../include/EnvironmentSetup.jsp"%><%

request.setAttribute("pageName", "CommercePlazaCatalog");

// Get all search specific URL parameters
String searchTerm = jhelper.getParameter("searchTerm");
String searchType = jhelper.getParameter("searchType");
String searchTermScope = jhelper.getParameter("searchTermScope");
String paSize = jhelper.getParameter("pageSize");
String beIndex = jhelper.getParameter("beginIndex");
String sType = jhelper.getParameter("sType");
String sResultType = jhelper.getParameter("resultType");
String sku = request.getParameter("sku");
String coSearchSkuEnabled = request.getParameter("coSearchSkuEnabled");
String skuOperator = request.getParameter("skuOperator");
String skuCaseSensitive = request.getParameter("skuCaseSensitive");
String searchTermOperator = request.getParameter("searchTermOperator");
String searchTermCaseSensitive = request.getParameter("searchTermCaseSensitive");
%>

<jsp:useBean id="catEntSearchListBean" scope="page" class="com.ibm.commerce.search.beans.CatEntrySearchListDataBean" />
<jsp:setProperty property="*" name="catEntSearchListBean" />
<%
catEntSearchListBean.setCommandContext(cmdcontext);
		
// Execute the search bean
com.ibm.commerce.beans.DataBeanManager.activate(catEntSearchListBean, request);

int beginIndex = 0;  // Number of first record on page
int pageSize = 10;   // Number of records per page
int totalCount = Integer.parseInt(catEntSearchListBean.getResultCount()); // Total num of results

if (beIndex != null && beIndex.length() != 0)
{
	beginIndex = Integer.parseInt(beIndex); // Set the index of the first result on the page
}
if (paSize != null && paSize.length() != 0)
{
	pageSize = Integer.parseInt(paSize);  // Set the number of results on a page
}
		
// Get results from the search query
CatalogEntryDataBean catalogEntries[] = null;
int totalsize = 0;
catalogEntries = catEntSearchListBean.getResultList();

// Get total number of results
if (catalogEntries != null)
{
	totalsize = catalogEntries.length; 
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

	<head>
		<title><%=storeText.getString("StoreCatalogDisplay_Title")%></title>
		<link rel="stylesheet" href="<%=fileDir%>PCDMarket.css" type="text/css" />

		<script>
		<!--
		function nextPage()
		{
			// link to next page
			document.navigateForm.beginIndex.value = <%=String.valueOf(beginIndex+pageSize)%>;
			document.navigateForm.submit();
		}

		function previousPage()
		{
			// link to previous page
			document.navigateForm.beginIndex.value = <%=String.valueOf(beginIndex-pageSize)%>;
			document.navigateForm.submit();
		}
		-->
		</script>
	</head>

	<body marginheight="0" marginwidth="0" leftmargin="0" topmargin="0">

	<%@ include file="../../../include/HeaderDisplay.jspf"%>
	<!-- Start Main Table -->

		<table border="0" cellpadding="0" cellspacing="0" width="750">
			<tbody><tr><!-- Start  Left Nav Bar TD -->
				<td valign="top" class="dbg" width="150">
					<%
					String incfile = includeDir + "SidebarDisplay.jsp";%>
					<jsp:include page="<%=incfile%>" flush="true"></jsp:include>
				</td>
				<td width="10"><a name="mainContent"></a><spacer type="horizontal" size="10" /><br />
				</td>
				<!-- End  Left Nav Bar TD --><!-- Begin Main Content TD -->
				<td valign="top" width="590">
					<table width="100%" border="0" cellpadding="0" cellspacing="0">
						<tbody><tr>
							<td colspan="2">
		        					<span class="bct">&nbsp;&nbsp;&nbsp;</span>
								<a class="bctl" href="StoreCatalogDisplay?storeId=<%=storeId%>&amp;catalogId=<%=catalogId%>&amp;langId=<%=languageId%>"><%=storeText.getString("Breadcrumb_CommercePlaza")%></a><span class="bct">&nbsp;&nbsp;&nbsp;&gt;&nbsp;&nbsp;&nbsp;</span>
								<span class="bct"><%=storeText.getString("Breadcrumb_SelectItems")%></span>
							</td>
						</tr>
						<tr>
							<td valign="top" height="11"><img src="<%=fileDir%>images/c.gif" height="11" width="11" /></td>
							<td valign="top" rowspan="2">
								<div align="right">
									<img src="<%=fileDir%>images/hdr_products.gif" width="280" height="72" alt='<%=storeText.getString("SerRes_Title")%>' />
								</div>
							</td>
						</tr>
						<tr>
							<td valign="top">
								<span class="title"><%=storeText.getString("SerRes_Title")%></span>
							</td>
						</tr>
					</tbody></table>
					<%
	// Check to see if there are no results.  Make sure this is the first set of results
	if (totalsize == 0 && beginIndex == 0 || searchTerm.equals("")) 
	{ 
		%>
					<table width="560" border="0" cellpadding="0" cellspacing="0">
						<tbody><tr>
							<td><span class="strongtext"><span class="error">
									
									<%
									String searchResultText = "";

									if (searchTerm.equals("") ) {
										searchResultText = storeText.getString("SerRes_Text1");
									}
									else {
										searchResultText = storeText.getString("SerRes_Text3","<i>"+searchTerm+"</i>");
									}
									%>
									<%=searchResultText%></span></span>
								<br />
							</td>
						</tr>
						<tr>
							<td><b><br />
									<span class="text"><%=storeText.getString("SerRes_Text4")%></span></b>
								<ul>
									<li><span class="text"><%=storeText.getString("SerRes_Text5")%></span></li>
									<li><span class="text"><%=storeText.getString("SerRes_Text6")%></span></li>
									<li><span class="text"><%=storeText.getString("SerRes_Text7")%></span></li>
								</ul>
							</td>
						</tr>
						<tr>
							<td>
					          	<form class="blk" name="CatalogSearchForm" action="CatalogSearchResultDisplayView" method="post">	
					  		<input type="hidden" name="storeId" value="<%= storeId %>" />
							<input type="hidden" name="langId" value="<%= languageId %>" />
							<input type="hidden" name="catalogId" value="<%= catalogId %>" />
							<input type="hidden" name="pageSize" value="10" />
							<input type="hidden" name="beginIndex" value="0" />
							<input type="hidden" name="sType" value="SimpleSearch" />
							<input type="hidden" name="resultType" value="1" />
							<input type="hidden" name="searchTermScope" value="3" />
							<input type="hidden" name="searchType" value="ANY" />
							<input type="hidden" name="skuCaseSensitive" value="no" />
							<input type="hidden" name="skuOperator" value="EQUAL" />
					              	<input type="hidden" name="coSearchSkuEnabled" value="true" />
					              	<input type="hidden" name="searchTermCaseSensitive" value="no" />
					              	<input type="hidden" name="searchTermOperator" value="LIKE" />
							<br />
							<span class="strongtext"><label for="searchTerm"><%=storeText.getString("SerRes_Text12")%></label></span><br />
							<table>
							<tbody><tr>
								<td>
							              <input maxlength="254" size="25" type="text" class="iform" name="searchTerm" id="searchTerm" class="iform" value="" />
								</td>
								<td>
					       		       &nbsp;&nbsp;<a href="javascript:document.CatalogSearchForm.submit()"><img src="<%=fileDir%><%=locale.toString()%>/images/go.gif" name="go" alt="<%=storeText.getString("SerRes_Button3")%>'" border="0" /></a>
								</td>
							</tr>
							</tbody></table>
							</form>
								<br />
								<br />
								<br />
							</td>
						</tr>
					</tbody></table>
					<%
					}
					else {
						// Display all the results

						int resultCountOnPage = pageSize + beginIndex;
						if (resultCountOnPage > totalCount) resultCountOnPage = totalCount;
                            
						Object[] arguments = {
							new Integer(beginIndex + 1),
							new Integer(resultCountOnPage),
							new Integer(totalCount)
				                };
				                String searchResultText =  MessageFormat.format(storeText.getString("SerRes_Text9"), arguments);
						%>
					<table width="98%" border="0" cellpadding="0" cellspacing="0">
						<tbody><tr>
							<td>
				          	<form class="blk" name="CatalogSearchForm" action="CatalogSearchResultDisplayView" method="post">	
				  		<input type="hidden" name="storeId" value="<%= storeId %>" />
						<input type="hidden" name="langId" value="<%= languageId %>" />
						<input type="hidden" name="catalogId" value="<%= catalogId %>" />
						<input type="hidden" name="pageSize" value="10" />
						<input type="hidden" name="beginIndex" value="0" />
						<input type="hidden" name="sType" value="SimpleSearch" />
						<input type="hidden" name="resultType" value="1" />
						<input type="hidden" name="searchTermScope" value="3" />
						<input type="hidden" name="searchType" value="ANY" />
						<input type="hidden" name="skuCaseSensitive" value="no" />
						<input type="hidden" name="skuOperator" value="EQUAL" />
				               	<input type="hidden" name="coSearchSkuEnabled" value="true" />
				              	<input type="hidden" name="searchTermCaseSensitive" value="no" />
				              	<input type="hidden" name="searchTermOperator" value="LIKE" />
					<table cellpadding="0" cellspacing="0" border="0" width="100%">
						<tbody><tr>
							<td valign="bottom">
							<span class="strongtext"><label for="searchTerm"><%=storeText.getString("SerRes_Text12")%></label></span><br />
							<table border="0" cellpadding="0" cellspacing="0">
							<tbody><tr>
								<td>
							              <input maxlength="254" size="25" type="text" class="iform" name="searchTerm" id="searchTerm" class="iform" value="<%=searchTerm%>" />
								</td>
								<td>
					    		          &nbsp;&nbsp;<a href="javascript:document.CatalogSearchForm.submit()"><img src="<%=fileDir%><%=locale.toString()%>/images/go.gif" name="go" alt="<%=storeText.getString("SerRes_Button3")%>'" border="0" /></a>
								</td>
							</tr>
							</tbody></table>
							
							</td>							
							<td align="right" valign="bottom">
								<table cellpadding="0" cellspacing="0" border="0">
									<tbody><tr>
									<%
									// Display previous button
									if ((beginIndex-pageSize)>=0) 
									{
										%>
										<td align="left" valign="middle" class="buttonStyle"><a href="#" onclick="previousPage(); return false;">
										<img src="<%=fileDir%>images/arrow_ld.gif" border="0" alt='<%=storeText.getString("SerRes_Button1")%>' /></a>&nbsp;<a href="#" onclick="previousPage(); return false;"><span class="buttonStyle"><%=storeText.getString("SerRes_Button1")%></span></a></td>
										<%
									}
									else
									{
									%>
										<td align="left" valign="middle" class="white_bg"><span class="text">&nbsp;<br />
												
										</span></td>
										<%
									}
										%>
										<td width="20">&nbsp;</td>
										<%
										// Display next button
									if (totalsize>=pageSize && beginIndex+pageSize != totalCount) 
									{
										%>
										<td align="right" valign="middle" class="buttonStyle"><a href="#" onclick="nextPage(); return false;">
											<img src="<%=fileDir%>images/arrow_rd.gif" border="0" alt='<%=storeText.getString("SerRes_Button2")%>' /></a>&nbsp;
											<a href="#" onclick="nextPage(); return false;"><span class="buttonStyle"><%=storeText.getString("SerRes_Button2")%></span></a>
										</td>
										<%
									} 
									%></tr>
								</tbody></table>
							</td>
						</tr>
						<tr>
														<td><span class="small"><br />&nbsp;<%=searchResultText%></span><br />
							</td>
													</tr>
					</tbody></table>
					</form>

							</td>
						</tr>

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
		
							if (type.equalsIgnoreCase("ItemBean"))
							{
								%>
								<tr>
									<td valign="top"><span class="bodytxt2"><b><%=beginIndex + 1 + i%>.&nbsp;&nbsp;<a href="ProductDisplay?catalogId=<%=catalogId%>&amp;storeId=<%= storeId%>&amp;productId=<%=catEntryID%>&amp;langId=<%=languageId%>"><%=catEntry.getDescription().getShortDescription()%></a></b></span><br />
										<span class="text"><%=catEntry.getPartNumber()%></span><br />
										<%
										PriceDataBean dbPrice = null;
										try { dbPrice = catEntry.getCalculatedContractPrice(); }
										catch(Exception e) {}
										if(dbPrice != null) {
										%>
										<span class="oprice"><%=dbPrice%></span>&nbsp;<span class="greytext">&nbsp;<%=storeText.getString("SerRes_Text11")%>&nbsp;</span></td>
										<% } %>
								</tr>
								<tr>
									<td>
										<%
										// Get the long description for this product
		 								String Description = catEntry.getDescription().getLongDescription();
					 					if (Description != null) 
						 				{
						 					// Shorten description at a maximum of 180 characters.  Cut description at a blank space.
						 					if (Description.length() > 180) { 
						 						Description = Description.substring(0, 180);
						 						Description = Description.substring(0, Description.lastIndexOf(" "));
						 						Description = Description + " ...";
						 					}
				 							%><span class="small"><%=Description%><br />
											<br />
										</span><%
										}
										%>
									</td>
								</tr>
								<tr>
									<td  height="1"><img src="<%=fileDir%>images/dotted_rule_150px.gif" width="100%" height="1" border="0" alt="" /></td>
								</tr>
								<tr>
									<td><span class="small"><br />
										</span></td>
								</tr>
								<%
							}
						}
						%>
						</tbody></table>
						<table cellpadding="0" cellspacing="0" border="0" width="560">
						<tbody><tr>
							<td align="right">
								<table cellpadding="4" cellspacing="0" border="0">
									<tbody><tr>
									<%
									// Display previous button
									if ((beginIndex-pageSize)>=0) 
									{
										%>
										<td align="left" valign="middle" class="buttonStyle"><a href="#" onclick="previousPage(); return false;">
											<img src="<%=fileDir%>images/arrow_ld.gif" border="0" alt='<%=storeText.getString("SerRes_Button1")%>' /></a>&nbsp;<a href="#" onclick="previousPage(); return false;"><span class="buttonStyle"><%=storeText.getString("SerRes_Button1")%></span></a>
										</td>
										<%
									}
									else
									{
										%>
										<td align="left" valign="middle" class="white_bg"><span class="text">&nbsp;<br />						
											</span></td>
										<%
									}
									%>
									<td width="20">&nbsp;</td>
									<%
									// Display next button
									if (totalsize>=pageSize && beginIndex+pageSize != totalCount) 
									{
										%>
										<td align="right" valign="middle" class="buttonStyle"><a href="#" onclick="nextPage(); return false;">
										<img src="<%=fileDir%>images/arrow_rd.gif" border="0" alt='<%=storeText.getString("SerRes_Button2")%>' /></a>&nbsp;<a href="#" onclick="nextPage(); return false;"><span class="buttonStyle"><%=storeText.getString("SerRes_Button2")%></span></a></td>
										<%
									} 
									%></tr>
								</tbody></table>

								<form name="navigateForm" action="CatalogSearchResultDisplayView" method="post" class="inlineform">
								<input name="langId" value="<%=languageId%>" type="hidden" />
								<input name="storeId" value="<%=storeId%>" type="hidden" />
								<input name="catalogId" value="<%=catalogId%>" type="hidden" />
								<input name="searchTerm" value="<%=searchTerm%>" type="hidden" />
								<input name="resultType" value="<%=sResultType%>" type="hidden" />
								<input name="pageSize" value="<%=pageSize%>" type="hidden" />
								<input name="beginIndex" value="0" type="hidden" />
								<input name="sType" value="<%=sType%>" type="hidden" />
								<input name="coSearchSkuEnabled" value="<%=coSearchSkuEnabled%>" type="hidden" />
								<input name="skuOperator" value="<%=skuOperator%>" type="hidden"  />
								<input name="skuCaseSensitive" value="<%=skuCaseSensitive%>" type="hidden" />
								<input name="searchTermScope" value="<%=searchTermScope%>" type="hidden" />
								<input name="searchType" value="<%=searchType%>" type="hidden" />
								<input name="searchTermOperator" value="<%=searchTermOperator%>" type="hidden" />
								<input name="searchTermCaseSensitive" value="<%=searchTermCaseSensitive%>" type="hidden" />
								</form>
							</td>
						</tr>
					</tbody></table>
					<%
					}
				%></td>
				<!-- End Main Content TD -->
				</tr>
		</tbody></table>
		<%@ include file="../../../include/FooterDisplay.jspf"%>
	</body>

</html>