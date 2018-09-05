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


  
<% // All JSPs require the first 4 packages for getResource.jsp which is used for multi language support %> 
<% // All JSPs requires these packages for EnvironmentSetup.jsp which is used for multi language support %> 
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.ibm.commerce.server.ECConstants" %>
<%@ page import="com.ibm.commerce.server.JSPHelper" %>
<%@ page import="com.ibm.commerce.server.JSPResourceBundle" %>
<%@ page import="com.ibm.commerce.command.CommandContext" %>

<% // Page specific imports%> 
<%@ page import="com.ibm.commerce.beans.DataBeanManager" %>
<%@ page import="com.ibm.commerce.beans.ErrorDataBean" %>
<%@ page import="com.ibm.commerce.common.beans.StoreDataBean" %>
<%@ page import="com.ibm.commerce.catalog.beans.CategoryDataBean" %>
<%@ page import="com.ibm.commerce.catalog.beans.CatalogDataBean" %>

  
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


/* If a search results in no records found, the previous button on the 
 *  result list page redirects the user to this page and we repopulate 
 * the form with data that the user entered.  Below we get the previous
 * search criteria.
 */
String searchTerm = request.getParameter("searchTerm");
String searchType = request.getParameter("searchType");
String searchTermScope = request.getParameter("searchTermScope");
String filterTerm = request.getParameter("filterTerm");
String filterType = request.getParameter("filterType");
String manuf = request.getParameter("manufacturer");
String manufPartNum = request.getParameter("manufacturerPartNum");
String sku = request.getParameter("sku");
String paSize = request.getParameter("pageSize");
String categoryId = request.getParameter("catGroupId");

%>
  
<jsp:useBean id="catalog" class="com.ibm.commerce.catalog.beans.CatalogDataBean" scope="page">
<%
catalog.setCatalogId(catalogId);
DataBeanManager.activate(catalog, request);
%>
</jsp:useBean>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "DTD/xhtml1-transitional.dtd">

<HEAD>
	<TITLE><%=tooltechtext.getString("AdvSer_Title")%></TITLE>
	<LINK REL=stylesheet HREF="<%=fileDir%>ToolTech.css" TYPE="text/css">
	
	<SCRIPT LANGUAGE="javascript">
		function submitSearch(form)
		{
			<% /* Show products & items if a SKU number is entered. 
			    * (A SKU number is unique in a store)
			    * Only list items on the result page if 'manufacturer name' or
			    * 'manufacturer part number' fields are input.
			    */ %>
			if (form.sku.value !="")
			{
				form.resultType.value = "3"
			}
			else if (form.manufacturer.value != "" || 
				form.manufacturerPartNum.value != "") 
			{
				form.resultType.value = "1"
			}
			form.submit()
		}
	</SCRIPT>
	
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
		<TABLE CELLPADDING="8" CELLSPACING="0" BORDER="0">
		<TR>  
			<TD>
				<p><H1><%=tooltechtext.getString("AdvSer_Title")%></H1>
				
				<!-- Start Search Form -->
				<form method="post" action="CatalogSearchResultView" name="AdvancedSearchForm">
				
     				<table border="0" cellpadding="3" cellspacing="2">
       				<tr>
        				<td>
         					<div align="left">
          					<input type="hidden" name="storeId" value="<%= storeId %>">
          					<input type="hidden" name="langId" value="<%= languageId %>">
          					<input type="hidden" name="catalogId" value="<%= catalogId %>">
          
          					<% /* result type: 
          					1 = list items
             					2 = list products
             					3 = list items & products
           					*/ %>
          					<input type="hidden" name="resultType" value="2">
          					<input type="hidden" name="qtyAvailable" value="">
          					<input type="hidden" name="qtyAvailableOperator" value="EQUAL">
          					<input type="hidden" name="qtyMeasure" value="">
          					<input type="hidden" name="qtyMeasureCaseSensitive" value="">
          					<input type="hidden" name="qtyMeasureOperator" value="EQUAL">
          
          					<font class="strongtext"><label for="WC_AdvancedCatalogSearchForm_FormInput_searchTerm_1"><%=tooltechtext.getString("AdvSer_Text1")%></label><br>
          					</font><font class="text">&nbsp;<input size="30" maxlength="254" type="text" name="searchTerm" id="WC_AdvancedCatalogSearchForm_FormInput_searchTerm_1" value="<%=searchTerm!=null ? searchTerm : ""%>"></font></div>
        				</td>
        				<td>	
        					<font class="text"><br><label for="WC_AdvancedCatalogSearchForm_FormInput_searchType_1"><img src="<%=fileDir%>images/trans.gif" height="1" width="1" border="0" alt="<%=tooltechtext.getString("RFQProductDisplay_Comm_Type")%>"/></label>
        					<select name="searchType" size="1" id="WC_AdvancedCatalogSearchForm_FormInput_searchType_1">
         					<option value="ALL" <%= searchType!=null && searchType.equals("ALL") ? "selected" : ""%>><%=tooltechtext.getString("AdvSer_Drop1")%></option>
         					<option value="ANY" <%= searchType!=null && searchType.equals("ANY") ? "selected" : ""%>><%=tooltechtext.getString("AdvSer_Drop2")%></option>
         					<option value="EXACT" <%= searchType!=null && searchType.equals("EXACT") ? "selected" : ""%>><%=tooltechtext.getString("AdvSer_Drop3")%></option>
        					</select>
         					</font>
         					<input type="hidden" name="searchTermCaseSensitive" value= "no">
         					<input type="hidden" name="searchTermOperator" value= "LIKE">
         				</td>
        				<td>
        				</td>
       				</tr>
       				<tr>
        				<td>
         					<div align="left">
          					<font class="text"><label for="WC_AdvancedCatalogSearchForm_FormInput_filterTerm_1"><%=tooltechtext.getString("AdvSer_Text2")%></label><br>
           					&nbsp;<input size="30" maxlength="254" type="text" name="filterTerm" id="WC_AdvancedCatalogSearchForm_FormInput_filterTerm_1" value="<%=filterTerm!=null ? filterTerm : ""%>"></font></div>
        				</td>
        				<td>
        					<font class="text"><br><label for="WC_AdvancedCatalogSearchForm_FormInput_filterType_1"><img src="<%=fileDir%>images/trans.gif" height="1" width="1" border="0" alt="<%=tooltechtext.getString("RFQProductDisplay_Comm_Type")%>"/></label>
          					<select name="filterType" size="1" id="WC_AdvancedCatalogSearchForm_FormInput_filterType_1">
           					<option value="ALL" <%= filterType!=null && filterType.equals("ALL") ? "selected" : ""%>><%=tooltechtext.getString("AdvSer_Drop1")%></option>
           					<option value="ANY" <%= filterType!=null && filterType.equals("ANY") ? "selected" : ""%>><%=tooltechtext.getString("AdvSer_Drop2")%></option>
           					<option value="EXACT" <%= filterType!=null && filterType.equals("EXACT") ? "selected" : ""%>><%=tooltechtext.getString("AdvSer_Drop3")%></option>
          					</select>
          					</font>
          					<input type="hidden" name="filterTermCaseSensitive" value= "no">
          					<input type="hidden" name="filterTermOperator" value= "LIKE">
          				</td>
        				<td>
        				</td>
       				</tr>
       				<tr>
        				<td>
        				</td>
        				<td>
        				</td>
				        <td>
				        </td>
       				</tr>
       				<tr>
        				<td>
        					<font class="strongtext"><label for="WC_AdvancedCatalogSearchForm_FormInput_searchTermScope_1"><%=tooltechtext.getString("AdvSer_Text3")%></label><br>
         					</font><font class="text">&nbsp;<select name="searchTermScope" id="WC_AdvancedCatalogSearchForm_FormInput_searchTermScope_1">
           					<option value="1" <%= searchTermScope!=null && searchTermScope.equals("1") ? "selected" : ""%>><%=tooltechtext.getString("AdvSer_Drop4")%>
           					<option value="2" <%= searchTermScope!=null && searchTermScope.equals("2") ? "selected" : ""%>><%=tooltechtext.getString("AdvSer_Drop5")%> 
          					</select></font>
          				</td>
        				<td>
        				</td>
        				<td>
        				</td>
       				</tr>
       				<tr>
        				<td colspan="3">
         					<div align="left">
          					<font class="text"><label for="WC_AdvancedCatalogSearchForm_FormInput_catGroupId_1"><%=tooltechtext.getString("AdvSer_Text4")%></label><br></font>
          					<font class="text">&nbsp;<select name="catGroupId" id="WC_AdvancedCatalogSearchForm_FormInput_catGroupId_1">
            					<option value=""><%=tooltechtext.getString("AdvSer_Drop6")%>
            					<%
            					// Get all primary (top) categories
            					CategoryDataBean topCategories[] = catalog.getTopCategories();
            					CategoryDataBean topCategory;
	
	    					// Loop through all main categories and then loop through all their subcategories
            					for (int i = 0; i < topCategories.length; ++i)
            					{
             						topCategory = topCategories[i];
             						if (!topCategory.getIdentifier().trim().equals("HOMEPAGE_PROMO")) 
             						{ 
             
             							%>
             							<option value="">           							
             							<%
              							// Get sub categories for the top category
              							CategoryDataBean category = new CategoryDataBean();
              							category.setCatalogId(catalogId);
              							category.setCategoryId(topCategory.getCategoryId());
              							com.ibm.commerce.beans.DataBeanManager.activate (category, request);
		              
	              
              							CategoryDataBean subCategories[] = category.getSubCategories();
              							CategoryDataBean cat;
	            
              							// Loop through subcategories for each main category
              							for (int j = 0; j < subCategories.length; ++j)
              							{
		               						cat = subCategories[j];
               								%><option value="<%=cat.getCategoryId()%>" <%= categoryId!=null && categoryId.equals(cat.getCategoryId()) ? "selected" : ""%>><%=topCategory.getDescription().getName()%>: <%=cat.getDescription().getName()%><%
              							}              

            					 	}
            					}
            
            					%>
          					</select>
          					</font>
           					<INPUT TYPE="hidden" NAME="categoryType" VALUE="ANY">
         					</div>
        				</td>
       				</tr>
       				<tr>
        				<td>
        				</td>
        				<td>
        				</td>
        				<td>
        				</td>
       				</tr>
       				<tr>
        				<td>
         					<div align="left">
          					<font class="text"><label for="WC_AdvancedCatalogSearchForm_FormInput_manufacturer_1"><%=tooltechtext.getString("AdvSer_Text5")%></label><br>
           					&nbsp;<input size="30" maxlength="254" type="text" name="manufacturer" id="WC_AdvancedCatalogSearchForm_FormInput_manufacturer_1" value="<%=manuf!=null ? manuf : ""%>"></font></div>
						<input type="hidden" name="manufacturerCaseSensitive" value="no">
           					<input type="hidden" name="manufacturerOperator" value="LIKE">
        				</td>
        				<td>
        					<BR>
          				</td>
        				<td>
        				</td>
       				</tr>
       				<tr>
        				<td>
         					<div align="left">
          					<font class="text"><label for="WC_AdvancedCatalogSearchForm_FormInput_manufacturerPartNum_1"><%=tooltechtext.getString("AdvSer_Text6")%></label><br>
           					&nbsp;<input size="30" maxlength="254" type="text" name="manufacturerPartNum" id="WC_AdvancedCatalogSearchForm_FormInput_manufacturerPartNum_1" value="<%=manufPartNum!=null ? manufPartNum : ""%>"></font></div>
           					<input type="hidden" name="manufacturerPartNumCaseSensitive" value="no">
           					<input type="hidden" name="manufacturerPartNumOperator" value="LIKE">
        				</td>
        				<td>
        					<BR>
          				</td>
        				<td>
        				</td>
       				</tr>
       				<tr>
        				<td>
         					<div align="left">
          					<font class="text"><label for="WC_AdvancedCatalogSearchForm_FormInput_sku_1"><%=tooltechtext.getString("AdvSer_Text7")%></label><br>
           					&nbsp;<input size="30" maxlength="254" type="text" name="sku" id="WC_AdvancedCatalogSearchForm_FormInput_sku_1" value="<%=sku!=null ? sku : ""%>"></font></div>
           					<input type="hidden" name="skuCaseSensitive" value="no">
           					<input type="hidden" name="skuOperator" value="LIKE">
        				</td>
        				<td>
        					<BR>
          				</td>
        				<td>
        				</td>
       				</tr>       				       				
       				<tr>
        				<td>
         					<div align="left">
          					<font class="strongtext"><label for="WC_AdvancedCatalogSearchForm_FormInput_pageSize_1"><%=tooltechtext.getString("AdvSer_Text8")%></label><br>
          					</font><font class="text">&nbsp;
           					<SELECT name="pageSize" SINGLE="single" id="WC_AdvancedCatalogSearchForm_FormInput_pageSize_1">
            					<OPTION selected value="10">10</OPTION>
            					<OPTION value="25" <%= paSize!=null && paSize.equals("25") ? "selected" : ""%>>25</OPTION>
            					<OPTION value="50" <%= paSize!=null && paSize.equals("50") ? "selected" : ""%>>50</OPTION>
            					<OPTION value="75" <%= paSize!=null && paSize.equals("75") ? "selected" : ""%>>75</OPTION>
            					<OPTION value="100" <%= paSize!=null && paSize.equals("100") ? "selected" : ""%>>100</OPTION>
           					</SELECT>
           					</font>
					         </div>
         					<input type="hidden" name="beginIndex" value="0">
         					<input type="hidden" name="sType" value="AdvancedSearch">
        				</td>
        				<td>
        				</td>
        				<td>
        				</td>
       				</tr>
       				<tr>
        				<td>
         					<div align="left"></div>
        				</td>
        				<td>
        				</td>
        				<td>
        				</td>
       				</tr>
       				<tr>
        				<td>
         					<div align="left">
          					<font class="text"><br>
          					</font>
          					
          					<!-- Start Submit Button -->
						<table cellpadding="0" cellspacing="0" border="0">
						<tr>
							<td bgcolor="#ff2d2d" class="pixel"><img src="<%=jspStoreImgDir%>images/lb.gif" border="0" alt=""/></td>
							<td bgcolor="#ff2d2d" class="pixel"><img src="<%=jspStoreImgDir%>images/lb.gif" border="0" alt=""/></td>
							<td class="pixel"><img src="<%=jspStoreImgDir%>images/r_top.gif" border="0" alt=""/></td>
						</tr>
						<tr>
							<td bgcolor="#ff2d2d"><img alt="" src="<%=jspStoreImgDir%>images/lb.gif" border="0"/></td>
							<td bgcolor="#ea2b2b">
								<table cellpadding="2" cellspacing="0" border="0">
								<tr>
									<td class="buttontext">
										<font color="#ffffff">
										<a href="javascript:submitSearch(document.AdvancedSearchForm)" style="color:#ffffff; text-decoration : none;">
											<%= tooltechtext.getString("AdvSer_Button") %>
										</a>
										</font>
									</td>
								</tr>
								</table>
							</td>
							<td bgcolor="#7a1616"><img alt="" src="<%=jspStoreImgDir%>images/db.gif" border="0"/></td>
						</tr>	
						<tr>
							<td class="pixel"><img src="<%=jspStoreImgDir%>images/l_bot.gif" alt=""/></td>
							<td bgcolor="#7a1616" class="pixel" valign="top"><img src="<%=jspStoreImgDir%>images/db.gif" border="0" alt=""/></td>
							<td bgcolor="#7a1616" class="pixel" valign="top"><img src="<%=jspStoreImgDir%>images/db.gif" border="0" alt=""/></td>
						</tr>
						</table>          					
					<!-- End Submit Button -->
	
         				</div>
        				</td>
        				<td>
        				</td>
        				<td>
        				</td>
        			</tr>
      				</table>				
				
				
				</form>
				<!-- End Search Form -->
				
			</TD>
		</TR>
		</TABLE>

	<!-- End Main JSP Content -->
	</TD>
</TR>
</TABLE>

</BODY>
</HTML>
