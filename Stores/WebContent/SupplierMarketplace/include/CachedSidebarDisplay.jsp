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
<%@ page import="com.ibm.commerce.server.ConfigProperties" %>
<%@ page import="com.ibm.commerce.server.JSPHelper" %>
<%@ page import="com.ibm.commerce.server.JSPResourceBundle" %>
<%@ page import="com.ibm.commerce.command.CommandContext" %>

<% // Page specific beans%>
<%@ page import="com.ibm.commerce.beans.DataBeanManager" %>
<%@ page import="com.ibm.commerce.beans.ErrorDataBean" %>
<%@ page import="com.ibm.commerce.common.beans.StoreDataBean" %>

<%@ page import="com.ibm.commerce.common.objects.*" %>
<%@ page import="com.ibm.commerce.price.utils.*" %>
<%@ page import="com.ibm.commerce.user.beans.UserRegistrationDataBean" %>
<%@ page import="com.ibm.commerce.user.beans.RoleDataBean" %>
<%@ page import="com.ibm.commerce.datatype.TypedProperty" %>
<%@ page import="com.ibm.commerce.catalog.beans.CatalogDataBean" %>
<%@ page import="com.ibm.commerce.catalog.beans.InterestItemListDataBean" %>
<%@ page import="com.ibm.commerce.catalog.objects.InterestItemAccessBean" %>

<%@ include file="EnvironmentSetup.jspf"%>

<SCRIPT LANGUAGE="JavaScript">

	var bRightBrowser = false;

	function checkBrowser() {

		if ( navigator.appName == "Microsoft Internet Explorer") {

			var locOfMSIE = navigator.appVersion.indexOf('MSIE') + 5;
			var bInstalled = false;

			if (locOfMSIE > -1 && navigator.appVersion.substring(locOfMSIE, locOfMSIE + 1) > 4) {
				bInstalled = oClientCaps.isComponentInstalled("{89820200-ECBD-11CF-8B85-00AA005B4383}", "ComponentID");
			}

			if (bInstalled) {
				IEversion = oClientCaps.getComponentVersion("{89820200-ECBD-11CF-8B85-00AA005B4383}", "ComponentID");
				version = IEversion.substr(0,3);
				versionNumber = parseInt(IEversion.substr(0,1));
				revisionNumber = parseInt(IEversion.substr(2,1));
				if ( (version == "5,5") || (versionNumber > 5) || (versionNumber == 5 && revisionNumber > 5) ) {
					bRightBrowser = true
					return true;
				}
			}
		}
		return false;

	}


	function CallQuickOrder() {
		if(document.QuickOrderForm.partNumber.value == "") {
			document.QuickOrderForm.action = "QuickOrderView?status=i";
		}
		document.QuickOrderForm.submit();
	}
</SCRIPT>

<% response.setContentType(tooltechtext.getString("ENCODESTATEMENT")); %>

<%
try {
    //Parameters may be encrypted. Use JSPHelper to get URL parameter instead of request.getParameter().
    JSPHelper jhelper = new JSPHelper(request);

    String storeId = jhelper.getParameter("storeId");
    if (storeId == null) {
    	storeId = sessionStoreId;
    }

    String languageId = jhelper.getParameter("langId");
    String inFrame  = jhelper.getParameter("inFrame");
    String navState = jhelper.getParameter("navState");
    String userState = jhelper.getParameter("userState");
    String userType  = jhelper.getParameter("userType");
    String siteAdmin = jhelper.getParameter("siteAdmin");
    String sellAdmin = jhelper.getParameter("sellAdmin");
    String buyAdmin = jhelper.getParameter("buyAdmin");
    String seller = jhelper.getParameter("seller");

    if (inFrame != null && inFrame.equals("")) {
        inFrame = null;
    }

    if (navState!= null && navState.equals("")) {
        navState = null;
    }
%>

<jsp:useBean id="sdbSidebar" class="com.ibm.commerce.common.beans.StoreDataBean">
	<jsp:setProperty property="storeId" name="sdbSidebar" value="<%= storeId %>" />
	<% com.ibm.commerce.beans.DataBeanManager.activate(sdbSidebar, request); %>
</jsp:useBean>

<%
    CatalogDataBean Catalogs[] = sdbSidebar.getStoreCatalogs();
    String catalogId = Catalogs[0].getCatalogId();

    //Create URL for RFQ
    String host = request.getServerName();
    String BrowserVerErrorURL = response.encodeURL("https://" + host + cmdcontext.getWebpath() + "/BrowserVerErrorView");
%>

<IE:clientCaps ID="oClientCaps" STYLE="behavior:url('#default#clientCaps')"></IE:clientCaps>

<% if (inFrame != null) { %>
    <table cellpadding="0" cellspacing="0" border="0" width="100%">
    	<tr>
    		<td background="<%=fileDir%>images/row1_tile.gif">
    			<table cellpadding="0" cellspacing="0" border="0" width="100%" height="28">
    				<tr>
    					<td>&nbsp;</td>
    					<td>&nbsp;</td>
    					<td align="right"><br>
    					</td>
    				</tr>
    			</table>
    		</td>
    	</tr>
    	<tr>
    		<td background="<%=fileDir%>images/row2_tile.gif">
    			<table cellpadding="0" cellspacing="0" border="0" width="100%" height="32">
    				<tr>
    					<td>&nbsp;</td>
    					<td>&nbsp;</td>
    					<td align="right"><br>
    					</td>
    				</tr>
    			</table>
    		</td>
    	</td>
    </table>
<% } %>

<table border="0" cellpadding="2" cellspacing="0" width="160" height="100%" bgcolor="#4c6178">
    <%
    //if (seller || sellAdmin || siteAdmin || buyerAdmin) {
    if ( (seller != null && seller.equalsIgnoreCase("true") ) ||
         (siteAdmin != null && siteAdmin.equalsIgnoreCase("true")) ||
         (sellAdmin != null && sellAdmin.equalsIgnoreCase("true")) ||
         (buyAdmin  != null && buyAdmin.equalsIgnoreCase("true")) ) {

    	if (navState != null && navState.equals("admin") ) {
    %>
    	<tr>
    		<td colspan="2">
    			<font color="#ffffff">
    			<a href="StoreCatalogDisplay?langId=<%=languageId%>&storeId=<%=storeId%>&catalogId=<%=catalogId%>" target="_top">
    				<font color="#ffffff">
    				<%= tooltechtext.getString("Sidebar_GoShop")%>
    				</font>
    			</a>
    			</font>
    		</td>
    		<td width="6"><br /></td>
    	</tr>
    <%
    	} else {
    %>
    	<tr>
    		<td colspan="2">
    			<font color="#ffffff">
    			<a href="StoreView?langId=<%=languageId%>&storeId=<%=storeId%>&catalogId=<%=catalogId%>&navState=admin" target="_top">
    				<font color="#ffffff">
    				<%= tooltechtext.getString("Sidebar_GoAdmin")%>
    				</font>
    			</a>
    			</font>
    		</td>
    		<td width="6"><br /></td>
    	</tr>
    <%
    	}
    }
    %>


    <%
    if (navState == null || !navState.equals("admin") ) {
    	if (!userType.equals("G") && (userState.equals("1") || userState.equals(""))) {
    %>

    	<TR><TD COLSPAN="3"><br /></TD></TR>

    	<TR>
    		<TD COLSPAN="2" BGCOLOR="#394959">
    			<B><FONT COLOR="#b7d9ff"><%=tooltechtext.getString("Sidebar_CatalogSearch")%></FONT></B>
    		</TD>
    		<TD WIDTH="6" BGCOLOR="#394959"><br /></TD>
    	</TR>

    	<TR><TD COLSPAN="3"></TD></TR>

    	<!-- START SEARCH FORM CODE -->
    	<FORM NAME="CatalogSearchForm" ACTION= "CatalogSearchResultView" METHOD="post">

    		<INPUT TYPE="hidden" NAME="storeId" VALUE="<%= storeId %>">
    		<INPUT TYPE="hidden" NAME="langId" VALUE="<%= languageId %>">
    		<INPUT TYPE="hidden" NAME="pageSize" VALUE="10">
    		<INPUT TYPE="hidden" NAME="beginIndex" VALUE="0">
    		<INPUT TYPE="hidden" NAME="sType" VALUE="SimpleSearch">
    		<INPUT TYPE="hidden" NAME="resultType" VALUE="2">
    		<INPUT TYPE="hidden" NAME="searchTermScope" VALUE="3">

    	<TR>
    		<TD WIDTH="105">
    			<label for="search"><img src="<%=fileDir%>images/trans.gif" height="1" width="1" border="0" alt="<%=tooltechtext.getString("AdvSer_Text1")%>"/></label><INPUT SIZE="12" MAXLENGTH="254" TYPE="text" ID="search" NAME="searchTerm">
    		</TD>
    		<TD WIDTH="37">

    			<!-- Start display for Search GO button -->
    			<table cellpadding="0" cellspacing="0" border="0">
    			<tr>
    				<td bgcolor="#ff2d2d" class="pixel"><img src="<%=fileDir%>images/lb.gif" border="0" alt=""/></td>
    				<td bgcolor="#ff2d2d" class="pixel"><img src="<%=fileDir%>images/lb.gif" border="0" alt=""/></td>
    				<td class="pixel"><img src="<%=fileDir%>images/r_top.gif" border="0" alt=""/></td>
    			</tr>
    			<tr>
    				<td bgcolor="#ff2d2d"><img alt="" src="<%=fileDir%>images/lb.gif" border="0" alt=""/></td>
    				<td bgcolor="#ea2b2b">
    					<table cellpadding="2" cellspacing="0" border="0">
    					<tr>
    						<td class="buttontext">
    							<font color="#ffffff">
    							<a href="javascript:document.CatalogSearchForm.submit()" style="color:#ffffff; text-decoration : none;" target="_top">
    								<%=tooltechtext.getString("Sidebar_Go1")%>
    							</a>
    							</font>
    						</td>
    					</tr>
    					</table>
    				</td>
    				<td bgcolor="#7a1616"><img alt="" src="<%=fileDir%>images/db.gif" border="0"/></td>			<tr>
    				<td class="pixel"><img src="<%=fileDir%>images/l_bot.gif" alt=""/></td>
    				<td bgcolor="#7a1616" class="pixel" valign="top"><img src="<%=fileDir%>images/db.gif" border="0" alt=""/></td>
    				<td bgcolor="#7a1616" class="pixel" valign="top"><img src="<%=fileDir%>images/db.gif" border="0" alt=""/></td>
    			</tr>
    			</table>
    			<!-- End display for Search GO button -->

    		</TD>
    		<TD WIDTH="6"><br /></TD>
    	</TR>

    	<TR>
    		<TD COLSPAN="3">
    			<A HREF="AdvancedSearchView?langId=<%=languageId%>&storeId=<%=storeId%>" target="_top">
    				<FONT COLOR="#ffffff">
    				<%=tooltechtext.getString("Sidebar_Link1")%>
    				</FONT>
    			</A>
    		</TD>
    	</TR>

    	</FORM>
    	<!-- End Search form Code-->

    	<TR><TD COLSPAN="3"><br /></TD></TR>

    	<!-- START CODE FOR QUICKORDER -->
    	<FORM NAME="QuickOrderForm" ACTION="OrderItemAdd" METHOD="POST">
      		<INPUT TYPE="hidden" NAME="quantity" VALUE="1">
      		<INPUT TYPE="hidden" NAME="orderId" VALUE=".">
      		<INPUT TYPE="hidden" NAME="URL" VALUE="OrderItemDisplayViewShiptoAssoc?cmdStoreId=&partNumber*=&quantity*=">
      		<INPUT TYPE="hidden" NAME="catalogId" VALUE="<%=catalogId%>" >
      		<INPUT TYPE="hidden" NAME="langId" VALUE="<%=languageId%>" >
      		<INPUT TYPE="hidden" NAME="outOrderName" VALUE="orderId">
      		<INPUT TYPE="hidden" NAME="status" VALUE="s">
      		<INPUT TYPE="hidden" NAME="callingpage" VALUE="QuickOrder" >
      		<INPUT TYPE="hidden" NAME="errorViewName" VALUE="QuickOrderView" >

    	<tr>
    		<td colspan="2" bgcolor="#394959">
    			<b><font color="#b7d9ff"><%=tooltechtext.getString("Sidebar_QuickOrder")%></font></b>
    		</td>
    		<td width="6" bgcolor="#394959"><br /></td>
    	</tr>

		<%
		if (multiSeller) {
		%>
			<tr>
				<td colspan="2">
					<font color="#ffffff"><label for="WC_CachedSidebarDisplay_FormInput_cmdStoreId_1"><%=tooltechtext.getString("SupplierDropDown_SelectSupplier")%></label></font>
				</td>
				<td width="6"><br /></td>
			</tr>
			<tr>
				<td colspan="2">
					<select name="cmdStoreId" id="WC_CachedSidebarDisplay_FormInput_cmdStoreId_1">
		<%
			HashMap relatedStores = com.ibm.commerce.store.util.StoreRelationUtil.getRelatedOpenStores(new Integer(sessionStoreId),ECConstants.EC_STRELTYP_HOSTED_STORE);
			Integer[] anStoreIds = com.ibm.commerce.common.helpers.StoreUtil.getRelatedStores(new Integer(sessionStoreId),ECConstants.EC_STRELTYP_HOSTED_STORE);
			for (int s=0; s<anStoreIds.length; s++) {
				String rStoreId = anStoreIds[s].toString();
				String rStoreName = (String) relatedStores.get(rStoreId);
		%>
						<option value="<%= rStoreId %>"><%= rStoreName %></option>
		<%
				}
		%>
					</select>
				</td>
				<td width="6"><br /></td>
			</tr>
		<%
		} // end check store type
		%>
    	<tr>
    		<td colspan="2">
    			<font color="#ffffff"><label for="WC_CachedSidebarDisplay_FormInput_partNumber_1"><%=tooltechtext.getString("Sidebar_EnterSKU")%></label></font>
    		</td>
    		<td width="6"><br /></td>
    	</tr>

    	<tr>
    		<td width="105">
    			<input type="text" name="partNumber" size="12" value="" id="WC_CachedSidebarDisplay_FormInput_partNumber_1">
    		</td>

    		<td width="37">

    			<!-- Start display Quickorder GO button -->
    			<table cellpadding="0" cellspacing="0" border="0">
    			<tr>
    				<td bgcolor="#ff2d2d" class="pixel"><img src="<%=fileDir%>images/lb.gif" border="0" alt=""/></td>
    				<td bgcolor="#ff2d2d" class="pixel"><img src="<%=fileDir%>images/lb.gif" border="0" alt=""/></td>
    				<td class="pixel"><img src="<%=fileDir%>images/r_top.gif" border="0" alt=""/></td>
    			</tr>
    			<tr>
    				<td bgcolor="#ff2d2d"><img alt="" src="<%=fileDir%>images/lb.gif" border="0"/></td>
    				<td bgcolor="#ea2b2b">
    					<table cellpadding="2" cellspacing="0" border="0">
    					<tr>
    						<td class="buttontext">
    							<font color="#ffffff">
    							<a href="javascript:CallQuickOrder()" style="color:#ffffff; text-decoration : none;" target="_top">
    								<%=tooltechtext.getString("Sidebar_Go2")%>
    							</a>
    							</font>
    						</td>
    					</tr>
    					</table>
    				</td>
    				<td bgcolor="#7a1616"><img alt="" src="<%=fileDir%>images/db.gif" border="0"/></td>			<tr>
    				<td class="pixel"><img src="<%=fileDir%>images/l_bot.gif" alt=""/></td>
    				<td bgcolor="#7a1616" class="pixel" valign="top"><img src="<%=fileDir%>images/db.gif" border="0" alt=""/></td>
    				<td bgcolor="#7a1616" class="pixel" valign="top"><img src="<%=fileDir%>images/db.gif" border="0" alt=""/></td>
    			</tr>
    			</table>
    			<!-- End display Quickorder GO button -->

    		</td>
    		<td width="6"><br /></td>
    	</tr>

    	<tr>
    		<td colspan="2">
    			<font color="#ffffff">
    			<a href="QuickOrderView?status=i&langId=<%=languageId %>&storeId=<%=storeId%>&catalogId=<%=catalogId%>" target="_top">
    				<font color="#ffffff">
    				<%=tooltechtext.getString("Sidebar_Link2")%>
    				</font>
    			</a>
    			</font>
    		</td>
    		<td width="6"><br /></td>
    	</tr>

    	</form>
    	<!-- END CODE FOR QUICKORDER-->



    	<flow:ifEnabled  feature="customerCare">
    	<tr><td colspan="3"><br /></td></tr>
    	<%
    	//Link for Live Help
    	if (com.ibm.commerce.collaboration.livehelp.beans.LiveHelpShopperConfiguration.isEnabled()) {%>
    	<tr>
    	   <td colspan="2">
    	   <a href="javascript:if((parent.sametime != null)) top.interact();" target="_top">
    	   	<font color="#ffffff" style="font-size : 8pt"><%= tooltechtext.getString("LiveHelp")%></font>
    	   </a>
        	   </td>
        	   <td width="42">
    	   <a href="javascript:if((parent.sametime != null)) top.interact();" target="_top">
        	   <img alt="" src="<%=fileDir%>images/LiveHelp.gif" width="42" height="39" border="0">
    	   </a>
        	   </td>
        	</tr>
    	<tr><td colspan="3"><br /></td></tr>
    	<%}%>
    	</flow:ifEnabled>

    <%
    	} //  end Userstate check
    } // end navState check
    %>



    <%
    if ((navState != null && navState.equals("admin")) || userType.equals("G") || userState.equals("0")) {
    %>

    	<!--  Begin of General Area -->

    	<tr><td colspan="3"><br /></td></tr>

    	<tr>
    		<td colspan="2" bgcolor="#394959">
    			<b><font color="#b7d9ff"><%=tooltechtext.getString("Sidebar_Welcome")%></font></b>
    		</td>
    		<td width="6" bgcolor="#394959"><br /></td>
    	</tr>
    	<tr>
    		<td colspan="2">
    			<font color="#ffffff">
    			<a href="StoreView?langId=<%=languageId%>&storeId=<%=storeId%>&catalogId=<%=catalogId%>&navState=<%=navState%>" target="_top">
    				<font color="#ffffff">
    				<%= tooltechtext.getString("Sidebar_Home")%>
    				</font>
    			</a>
    			</font>
    		</td>
    		<td width="6"><br /></td>
    	</tr>
    	<tr>
    		<td colspan="2">
    			<font color="#ffffff">
    			<a href="AboutUsView?langId=<%=languageId%>&storeId=<%=storeId%>&catalogId=<%=catalogId%>&navState=<%=navState%>" target="_top">
    				<font color="#ffffff">
    				<%= tooltechtext.getString("Sidebar_AboutUs")%>
    				</font>
    			</a>
    			</font>
    		</td>
    		<td width="6"><br /></td>
    	</tr>
    	<tr>
    		<td colspan="2">
    			<font color="#ffffff">
    			<a href="PricesView?langId=<%=languageId%>&storeId=<%=storeId%>&catalogId=<%=catalogId%>&navState=<%=navState%>" target="_top">
    				<font color="#ffffff">
    				<%= tooltechtext.getString("Sidebar_Prices")%>
    				</font>
    			</a>
    			</font>
    		</td>
    		<td width="6"><br /></td>
    	</tr>
    	<tr>
    		<td colspan="2">
    			<font color="#ffffff">
    			<a href="FaqView?langId=<%=languageId%>&storeId=<%=storeId%>&catalogId=<%=catalogId%>&navState=<%=navState%>" target="_top">
    				<font color="#ffffff">
    				<%= tooltechtext.getString("Sidebar_FAQ")%>
    				</font>
    			</a>
    			</font>
    		</td>
    		<td width="6"><br /></td>
    	</tr>
    	<tr>
    		<td colspan="2">
    			<font color="#ffffff">
    			<a href="ContactUsView?langId=<%=languageId%>&storeId=<%=storeId%>&catalogId=<%=catalogId%>&navState=<%=navState%>" target="_top">
    				<font color="#ffffff">
    				<%= tooltechtext.getString("Sidebar_ContactUs")%>
    				</font>
    			</a>
    			</font>
    		</td>
    		<td width="6"><br /></td>
    	</tr>
    <%
    	if (userType.equals("G")) {
    %>
    	<tr>
    		<td colspan="2">
    			<font color="#ffffff">
    			<a href="UserRegistrationForm?new=Y&langId=<%=languageId%>&storeId=<%=storeId%>&catalogId=<%=catalogId%>&navState=<%=navState%>" target="_top">
    				<font color="#ffffff">
    				<%= tooltechtext.getString("Sidebar_Registration")%>
    				</font>
    			</a>
    			</font>
    		</td>
    		<td width="6"><br /></td>
    	</tr>
    	<tr>
    		<td colspan="2">
    			<font color="#ffffff">
    			<a href="LogonForm?langId=<%=languageId%>&storeId=<%=storeId%>&catalogId=<%=catalogId%>" target="_top">
    				<font color="#ffffff">
    				<%= tooltechtext.getString("Sidebar_Logon")%>
    				</font>
    			</a>
    			</font>
    		</td>
    		<td width="6"><br /></td>
    	</tr>
    <%
    	} else {
    %>
    	<tr>
    		<td colspan="2">
    			<font color="#ffffff">
    			<a href="Logoff?storeId=<%=storeId%>&langId=<%=languageId%>&catalogId=<%=catalogId%>" target="_top">
    				<font color="#ffffff">
    				<%= tooltechtext.getString("Sidebar_Logoff")%>
    				</font>
    			</a>
    			</font>
    		</td>
    		<td width="6"><br /></td>
    	</tr>
    <%
    	}
    %>

    <%
    }
    %>


	<!--  End of General Area -->


<%
if (navState != null && navState.equals("admin")) {
%>

<%
if (!userType.equals("G") && (userState.equals("1") || userState.equals(""))) {
%>

<%

	String langId = cmdcontext.getLanguageId().toString();

	String StoresWebPath = cmdcontext.getWebpath();

	String portUsed = null;
	String requestURL = request.getRequestURL().toString();
	String[] parts = requestURL.split(":");
	if (parts.length > 2) {
	       //therefore parts[2] should have the port section
	       String[] parts2 = parts[2].split("/");
	       portUsed = parts2[0];
	}

	String acceleratorContextPath = null;
	String acceleratorURLMappingPath = null;
	String orgadminContextPath = null;
	String orgadminURLMappingPath = null;
	Vector contextPath = ConfigProperties.singleton().getAllValues("Websphere/WebModule/Module/contextPath");
	Vector urlMappingPath = ConfigProperties.singleton().getAllValues("Websphere/WebModule/Module/urlMappingPath");
	Vector moduleNames = ConfigProperties.singleton().getAllValues("Websphere/WebModule/Module/name");
	for (int i=0; i<moduleNames.size(); i++) {
		String name = (String)moduleNames.elementAt(i);
		if (name.equals("CommerceAccelerator")) {
			acceleratorContextPath = (String)contextPath.elementAt(i);
			acceleratorURLMappingPath = (String)urlMappingPath.elementAt(i);
		} else if (name.equals("OrganizationAdministration")) {
			orgadminContextPath = (String)contextPath.elementAt(i);
			orgadminURLMappingPath = (String)urlMappingPath.elementAt(i);
		}
	}

	String toolsPort = ConfigProperties.singleton().getValue("WebServer/ToolsPort");
	String orgadminPort = ConfigProperties.singleton().getValue("WebServer/OrgAdminPort");

	StringBuffer acceleratorURL = new StringBuffer();
	acceleratorURL.append("https://");
	acceleratorURL.append(host);
	acceleratorURL.append(":");
	acceleratorURL.append(toolsPort);
	acceleratorURL.append(acceleratorContextPath);
	acceleratorURL.append(acceleratorURLMappingPath);
	acceleratorURL.append("/MerchantCenterView?XMLFile=common.merchantCenterSHS&customFrameset=common.MerchantCenterFramesetSHS&webPathToUse=");
	acceleratorURL.append(StoresWebPath);
	if (portUsed != null) {
	       acceleratorURL.append("&portToUse=");
	       acceleratorURL.append(portUsed);
	}
	acceleratorURL.append("&sidebarViewName=SidebarDisplayView&headerViewName=HeaderDisplayView&actionName=managestore&showStoreSelection=true&langId=");
	acceleratorURL.append(langId);
	acceleratorURL.append("&storeIdToUse=");
	acceleratorURL.append(storeId);
	String acceleratorEncodedURL = response.encodeURL(acceleratorURL.toString());

	StringBuffer orgAdminConsoleURL = new StringBuffer();
	orgAdminConsoleURL.append("https://");
	orgAdminConsoleURL.append(host);
	orgAdminConsoleURL.append(":");
	orgAdminConsoleURL.append(orgadminPort);
	orgAdminConsoleURL.append(orgadminContextPath);
	orgAdminConsoleURL.append(orgadminURLMappingPath);
	orgAdminConsoleURL.append("/BuyAdminConsoleView?XMLFile=buyerconsole.BuySiteAdminConsole&customFrameset=common.MerchantCenterFramesetSHS&webPathToUse=");
	orgAdminConsoleURL.append(StoresWebPath);
	if (portUsed != null) {
	       orgAdminConsoleURL.append("&portToUse=");
	       orgAdminConsoleURL.append(portUsed);
	}
	orgAdminConsoleURL.append("&sidebarViewName=SidebarDisplayView&headerViewName=HeaderDisplayView&actionName=organization&langId=");
	orgAdminConsoleURL.append(langId);
	orgAdminConsoleURL.append("&storeIdToUse=");
	orgAdminConsoleURL.append(storeId);
	orgAdminConsoleURL.append("&buyer=true");
	String orgAdminConsoleEncodedURL = response.encodeURL(orgAdminConsoleURL.toString());

%>

<script language="javascript">
function launchAccelerator() {
	var bRightBrowser = checkBrowser();

	if (bRightBrowser) {
		top.location.href=('<%=acceleratorEncodedURL%>');
	} else if (!bRightBrowser) {
		window.location.href=('<%=BrowserVerErrorURL%>');
	}
}

function launchOrgAdminConsole() {
	var bRightBrowser = checkBrowser();

	if (bRightBrowser) {
		top.location.href=('<%=orgAdminConsoleEncodedURL%>');
	} else if (!bRightBrowser) {
		window.location.href=('<%=BrowserVerErrorURL%>');
	}
}

function launchCreateStore() {
	var bRightBrowser = checkBrowser();
	if (bRightBrowser) {
		top.location.href="CreateStoreView?=<%= storeId %>&<%= ECConstants.EC_LANGUAGE_ID %>=<%=langId%>&actionName=managestore";
	} else if (!bRightBrowser) {
		window.location.href=('<%=BrowserVerErrorURL%>');
	}
}
</script>


<%

	// If the user is not a guest, then do not show registration. Also, see which admin links to display.
	if (!userState.equalsIgnoreCase("G")) {
      //if (seller || sellAdmin || siteAdmin || buyerAdmin) {
        if ( (seller != null && seller.equalsIgnoreCase("true")) ||
             (siteAdmin != null && siteAdmin.equalsIgnoreCase("true")) ||
             (sellAdmin != null && sellAdmin.equalsIgnoreCase("true")) ||
             (buyAdmin  != null && buyAdmin.equalsIgnoreCase("true")) ) {
%>
        	<tr><td colspan="3"><br /></td></tr>
        	<tr>
        		<td colspan="2" bgcolor="#394959">
        			<b><font color="#b7d9ff"><%=tooltechtext.getString("Sidebar_Admin")%></font></b>
        		</td>
        		<td width="6" bgcolor="#394959"><br /></td>
        	</tr>
<%
            // if (seller || sellAdmin || siteAdmin) {
            if ( (siteAdmin != null && siteAdmin.equalsIgnoreCase("true")) ||
                 (sellAdmin != null && sellAdmin.equalsIgnoreCase("true")) ) {

				if (multiSeller) {
					//  only should create store link when you are in Marketplace area.
%>
            	<tr>
            		<td colspan="2">
            			<font color="#ffffff">
            			<a href="javascript:<% if (inFrame != null) { %><%= inFrame %>.<% } %>launchCreateStore();" target="_top">
            				<font color="#ffffff">
            				<%= tooltechtext.getString("Sidebar_CreateStore")%>
            				</font>
            			</a>
            			</font>
            		</td>
            		<td width="6"><br /></td>
            	</tr>
<%
				}
			}

//			if (sellAdmin || siteAdmin || buyerAdmin) {
            if ( (siteAdmin != null && siteAdmin.equalsIgnoreCase("true")) ||
                 (sellAdmin != null && sellAdmin.equalsIgnoreCase("true")) ||
                 (buyAdmin  != null && buyAdmin.equalsIgnoreCase("true")) ) {
%>
            	<tr>
            		<td colspan="2">
            			<font color="#ffffff">
            			<a href="javascript:<% if (inFrame != null) { %><%= inFrame %>.<% } %>launchOrgAdminConsole();" target="_top">
            				<font color="#ffffff">
            				<%= tooltechtext.getString("Sidebar_ManageOrganization")%>
            				</font>
            			</a>
            			</font>
            		</td>
            		<td width="6"><br /></td>
            	</tr>
<%
			}

            if ( (seller != null && seller.equalsIgnoreCase("true")) ||
                 (siteAdmin != null && siteAdmin.equalsIgnoreCase("true")) ){
			//if (siteAdmin || seller) {
%>
            	<tr>
            		<td colspan="2">
            			<font color="#ffffff">
            			<a href="javascript:<% if (inFrame != null) { %><%= inFrame %>.<% } %>launchAccelerator();" target="_top">
            				<font color="#ffffff">
            				<%= tooltechtext.getString("Sidebar_ManageStore")%>
            				</font>
            			</a>
            			</font>
            		</td>
            		<td width="6"><br /></td>
            	</tr>
<%
			}
		}
	}
%>

<%
}
%>


<%
}
%>
	<tr><td colspan="3"><br /></td></tr>

	<tr><td colspan="3" height="100%"><br /></td></tr>

</table>


<br />
<!--END SIDEBAR NAVIGATION-->

<%
}
catch (Exception e) {
    out.println("Exception:" + e);
}
%>
