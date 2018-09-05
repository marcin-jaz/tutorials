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
<%@ page import="java.util.Enumeration" %>
<%@ page import="java.util.ResourceBundle" %>
<%@ page import="java.util.Vector" %>
<%@ page import="com.ibm.commerce.command.CommandContext" %>

<%@ page import="com.ibm.commerce.server.JSPHelper" %>
<%@ page import="com.ibm.commerce.server.ECConstants" %>

<%@ page import="com.ibm.commerce.user.beans.UserRegistrationDataBean" %>
<%@ page import="com.ibm.commerce.beans.DataBeanManager" %>
<%@ page import="com.ibm.commerce.common.objects.StoreEntityAccessBean" %>
<%@ page import="com.ibm.commerce.common.beans.StoreDataBean" %>
<%@ page import="com.ibm.commerce.user.beans.RoleDataBean" %>
<%@ page import="com.ibm.commerce.catalog.beans.CatalogDataBean" %>
<%@ page import="com.ibm.commerce.server.ConfigProperties" %>
<%@ page import="com.ibm.commerce.command.NameValuePair" %>
<%@ page import="com.ibm.commerce.common.beans.StoreEntityDataBean" %>

<%@ page import="com.ibm.commerce.common.objects.SupportedLanguageAccessBean" %>
<%@ page import="com.ibm.commerce.common.objects.LanguageDescriptionAccessBean" %>

<%@ page import="com.ibm.commerce.catalog.beans.InterestItemListDataBean" %>
<%@ page import="com.ibm.commerce.catalog.objects.InterestItemAccessBean" %>


<%@ include file="EnvironmentSetup.jsp"%>
<% response.setContentType(storeText.getString("ENCODESTATEMENT")); %> 

<%
String currentOption = request.getParameter("pageName");

boolean showStoreCreationLink = "true".equals(request.getParameter("showStoreCreationLink"));
boolean showStoreAdminLink = "true".equals(request.getParameter("showStoreAdminLink"));
boolean showOrgAdminLink = "true".equals(request.getParameter("showOrgAdminLink"));

//Create the URL for the Administration links
String host = request.getServerName();
String BrowserVerErrorURL = response.encodeURL("https://" + host + "/webapp/wcs/stores/servlet/BrowserVerErrorView");

String StoresWebPath = ConfigProperties.singleton().getValue("WebServer/StoresWebPath");

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
acceleratorURL.append("/MerchantCenterView?XMLFile=common.merchantCenterRHS&customFrameset=common.MerchantCenterFramesetRHS&webPathToUse=");
acceleratorURL.append(StoresWebPath);
acceleratorURL.append("&sidebarViewName=SidebarDisplayView&headerViewName=HeaderDisplayView&footerViewName=FooterDisplayView&actionName=managestore&showStoreSelection=true&langId=");
acceleratorURL.append(languageId);
acceleratorURL.append("&storeIdToUse=");
acceleratorURL.append(storeId);
String AcceleratorEncodedURL = response.encodeURL(acceleratorURL.toString());

StringBuffer orgAdminConsoleURL = new StringBuffer();
orgAdminConsoleURL.append("https://");
orgAdminConsoleURL.append(host);
orgAdminConsoleURL.append(":");
orgAdminConsoleURL.append(orgadminPort);
orgAdminConsoleURL.append(orgadminContextPath);
orgAdminConsoleURL.append(orgadminURLMappingPath);
orgAdminConsoleURL.append("/BuyAdminConsoleView?XMLFile=buyerconsole.BuySiteAdminConsole&customFrameset=common.MerchantCenterFramesetRHS&webPathToUse=");
orgAdminConsoleURL.append(StoresWebPath);
orgAdminConsoleURL.append("&sidebarViewName=SidebarDisplayView&headerViewName=HeaderDisplayView&footerViewName=FooterDisplayView&actionName=organization&langId=");
orgAdminConsoleURL.append(languageId);
orgAdminConsoleURL.append("&storeIdToUse=");
orgAdminConsoleURL.append(storeId);
orgAdminConsoleURL.append("&buyer=true");
String AdminConsoleEncodedURL = response.encodeURL(orgAdminConsoleURL.toString());
%>



<script language="javascript">

var feedbackURL = "FeedbackFormView?storeId=<%=storeId%>";

function FeedbackWindow(url) 
{
  var windowObject;
  var name = "popup";
  var width = 650;
  var height = 475;
  
  o = "width="+width+",height="+height+",resizable=1,status=0,left=0,top=0,menubar=0,scrollbars=1,toolbar=0,location=0,directories=0";
  windowObject = window.open(url, name, "height=" + height + ",innerHeight=" + height + ",width=" + width + ",innerWidth=" + width + ",screenX=0,screenY=0,scrollbars=yes,resizable=yes");
  windowObject.focus();
}

function checkBrowser()
{
	var bRightBrowser = false;
	var detect = navigator.userAgent.toLowerCase();  // Checks platform
	var iPlatform = 0;

	if ( navigator.appName == "Microsoft Internet Explorer") {
		var locOfMSIE = navigator.appVersion.indexOf('MSIE') + 5;
		var bInstalled = false;  		
  		iPlatform = (detect.indexOf('mac') + 1);  // Detect is MAC computer

		if (iPlatform == 0 && locOfMSIE > -1 && navigator.appVersion.substring(locOfMSIE, locOfMSIE + 1) > 4) {
			bInstalled = oClientCaps.isComponentInstalled("{89820200-ECBD-11CF-8B85-00AA005B4383}", "ComponentID");
			}

		if (bInstalled) {
			IEversion = oClientCaps.getComponentVersion("{89820200-ECBD-11CF-8B85-00AA005B4383}", "ComponentID");
			version = IEversion.substr(0,3);
			versionNumber = parseInt(IEversion.substr(0,1));
			revisionNumber = parseInt(IEversion.substr(2,1));
			if ( (version == "5,5") || (versionNumber > 5) || (versionNumber == 5 && revisionNumber > 5) ) {
				bRightBrowser = true
			}
		}
	}
	
	if (bRightBrowser) 
		{
		return (true);
		}
	else if (!bRightBrowser)
		{
		return (false);
		}
}

function launchAdminStore() {
	
	if (checkBrowser()) 
		{
		top.location.href=('<%=AcceleratorEncodedURL%>');
				
		}
	else
		{
		window.location.href=('<%=BrowserVerErrorURL%>?actionName=managestore');
		}				
}

function launchAdminConsole() {

	if (checkBrowser()) 
		{
		top.location.href=('<%=AdminConsoleEncodedURL%>');
		}
	else
		{
		window.location.href=('<%=BrowserVerErrorURL%>?actionName=organization');
		}				
}

function launchRequestStore() {

	if (checkBrowser()) 
		{
		top.location.href=('RequestHostedStoreDisplayView?storeId=<%=storeId%>&catalogId=<%=catalogId%>&langId=<%=languageId%>');
		}
	else
		{
		window.location.href=('<%=BrowserVerErrorURL%>?actionName=createstore');
		}			
}

function SwitchTheLanguage() {
	// Switches the store language
	urlAddress = new String(self.window.location)
	var indexOfQuestion = urlAddress.indexOf("?");
	urlAddress = urlAddress.substring(0,indexOfQuestion);

	document.SwitchLanguage.action=urlAddress;
	document.SwitchLanguage.submit();	
}
</script>
<IE:clientCaps ID="oClientCaps" STYLE="behavior:url('#default#clientCaps')"></IE:clientCaps>

<table cellspacing="0" cellpadding="0" width="150" border="0" background="<%=fileDir%>images/logo_back.gif">
	<tbody>	

		<jsp:useBean id="supportedLanguageAccessBean" class="com.ibm.commerce.common.objects.SupportedLanguageAccessBean" scope="page" />
		<%
		Enumeration enStoreLangList = supportedLanguageAccessBean.findByStore(new Integer(storeId));
		Enumeration enTestMorethen2 = supportedLanguageAccessBean.findByStore(new Integer(storeId));
		
		String switchTheLanguage = jhelper.getParameter("switchTheLanguage");

		// Test to make sure we have at least 2 language in the Enumeration.  If so, allow the user to select which on they prefer.
		if (enTestMorethen2.hasMoreElements() && (switchTheLanguage==null || !switchTheLanguage.equalsIgnoreCase("no"))) 
		{ 
			enTestMorethen2.nextElement();
			if (enTestMorethen2.hasMoreElements()) 
			{ 
				%>
				<tr width="150" height="4">
					<td width="5"><img src="<%=fileDir%>images/c.gif" height="4" width="1" /></td>
					<td width="145" colspan="2"><img src="<%=fileDir%>images/c.gif" height="4" width="1" /></td>	
				</tr>
				<tr width="150" height="30">
					<td width="5" ><spacer type="block" width="2" height="30" /></td>
					<td width="145" colspan="2"><span class="related"><label for="langId"><%=storeText.getString("Logon_Lang")%></label></span><br />
		
						<form name="SwitchLanguage" action="LogonForm" method="post" class="inlineform">
						<select name="langId" id="langId" onchange="javascript:SwitchTheLanguage()" class="iform" style="width: 140px">
						<%
						while (enStoreLangList.hasMoreElements()) 
							{
							SupportedLanguageAccessBean storeLang = (SupportedLanguageAccessBean) enStoreLangList.nextElement();
							String storelangId = storeLang.getLanguageId();
			
							//Get the display name of the language in the language currently selected by the shopper.
							LanguageDescriptionAccessBean langDesc = new LanguageDescriptionAccessBean();
							langDesc.setInitKey_languageId(languageId);
							langDesc.setInitKey_descriptionLanguageId(storelangId);
			
							//If this language is currently selected, select it in the drop down list.
							if (languageId.equals(storelangId))
								{
			
								%>
								<option value="<%= storelangId %>" selected="selected"><%=langDesc.getDescription()%></option>
								<%
								} 
							else 
								{
								%>
								<option value="<%= storelangId %>"><%=langDesc.getDescription()%></option>
								<%
								}
						}
						%>
						</select>&nbsp;
						<%
					 	for (Enumeration jspParams = jhelper.getURLParameters(request).elements(); jspParams.hasMoreElements();)
						{
							NameValuePair nvp = (NameValuePair)jspParams.nextElement();
							if (!nvp.getName().equals("langId") && !nvp.getName().equals("pageName")) {
								%><input type="hidden" name="<%=nvp.getName()%>" value="<%=nvp.getValue()%>" /><%
							}
						}
						%>
						</form>
					</td>
				</tr>
				<tr width="150" height="8">
					<td width="5"><img src="<%=fileDir%>images/c.gif" height="8" width="1" /></td>
					<td width="145" colspan="2"><img src="<%=fileDir%>images/c.gif" height="8" width="1" /></td>	
				</tr>				
				<% 
			}
		}
		%>
<%
// If the user is a guest, don't show the sidebar
if (userState.equalsIgnoreCase("G"))
 {  // guest state
	%>
		<tr>
			<td class="line" colspan="3"></td>
		</tr>
		<tr class="hil" width="150" height="30">
			<td class="nav_sel" colspan="3"><a class="rlinksblk" href="LogonForm?langId=<%=languageId%>&storeId=<%=storeId%>&catalogId=<%=catalogId%>" target="_top"><%=storeText.getString("Logon_Title")%></a></td>
		</tr>
		<tr>
			<td class="line" colspan="3"></td>
		</tr>
		<tr class="mbg" width="150" height="30">
			<td class="nav_def" colspan="3"><a class="rlinksblk" href="javascript:FeedbackWindow(feedbackURL)"><%=storeText.getString("NavSidebar_FeedbackTitle")%></a></td>
		</tr>
<%
}
else if (currentOption.equals("ChangePasswordForm"))
{  // If the user is on the Change Password page, they cannot navigate into the site
	%>
		<tr>
			<td class="line" colspan="3"></td>
		</tr>
		<tr class="hil" width="150" height="30">
			<td class="nav_sel" colspan="3"><a class="rlinksblk" href="ChangePassword?langId=<%=languageId%>&storeId=<%=storeId%>&catalogId=<%=catalogId%>" target="_top"><%=storeText.getString("CHANGEPWD_TITLE")%></a></td>
		</tr>
		<tr>
			<td class="line" colspan="3"></td>
		</tr>
		<tr class="mbg" width="150" height="30">
			<td class="nav_def" colspan="3"><a class="rlinksblk" href="javascript:FeedbackWindow(feedbackURL)"><%=storeText.getString("NavSidebar_FeedbackTitle")%></a></td>
		</tr>
<%
}
else 
{	// display the sidebar
    if (currentOption.equals("CurrentShoppingCart"))
    	{
    	%>
		<tr>
			<td class="line" colspan="3"></td>
		</tr>
		<tr class="hil" width="150" height="30">
			<td class="nav_sel" colspan="3"><a class="rlinksblk" href="OrderItemDisplay?check=*n&langId=<%=languageId%>&storeId=<%=storeId%>&catalogId=<%=catalogId%>&orderId=." target="_top"><%=storeText.getString("NavSidebar_ShoppingCartTitle")%></a></td>
		</tr>
		<tr>
			<td class="line" colspan="3"></td>
		</tr>
		<tr class="lbg" width="150" height="30">
			<td class="nav_def" colspan="3">&nbsp;&nbsp;&nbsp;<a class="rlinksblk" href="PendingShopCartsDisplayView?langId=<%=languageId%>&storeId=<%=storeId%>&catalogId=<%=catalogId%>&orderId=*" target="_top"><%=storeText.getString("NavSidebar_ShoppingCartPending")%></a></td>
		</tr>
		<%
    	}
    else if (currentOption.equals("PendingShoppingCarts"))
    	{
	%>
		<tr>
			<td class="line" colspan="3"></td>
		</tr>
		<tr class="lbg" width="150" height="30">
			<td class="nav_def" colspan="3"><a class="rlinksblk" href="OrderItemDisplay?check=*n&langId=<%=languageId%>&storeId=<%=storeId%>&catalogId=<%=catalogId%>&orderId=." target="_top"><%=storeText.getString("NavSidebar_ShoppingCartTitle")%></a></td>
		</tr>
		<tr>
			<td class="line" colspan="3"></td>
		</tr>
		<tr class="hil" width="150" height="30">
			<td class="nav_sel" colspan="3">&nbsp;&nbsp;&nbsp;<a class="rlinksblk" href="PendingShopCartsDisplayView?langId=<%=languageId%>&storeId=<%=storeId%>&catalogId=<%=catalogId%>&orderId=*" target="_top"><%=storeText.getString("NavSidebar_ShoppingCartPending")%></a></td>
		</tr>
		<%
    	}
    else
    	{
    	%>
		<tr>
			<td class="line" colspan="3"></td>
		</tr>
		<tr class="mbg" width="150" height="30">
			<td class="nav_def" colspan="3"><a class="rlinksblk" href="OrderItemDisplay?check=*n&langId=<%=languageId%>&storeId=<%=storeId%>&catalogId=<%=catalogId%>&orderId=." target="_top"><%=storeText.getString("NavSidebar_ShoppingCartTitle")%></a></td>
		</tr>
		<%
    	}
    
    if (currentOption.equals("DistributorCarts"))
    	{
    	%>
		<tr>
			<td class="line" colspan="3"></td>
		</tr>
		<tr class="hil" width="150" height="30">
			<td class="nav_sel" colspan="3"><a class="rlinksblk" href="#"><%=storeText.getString("NavSidebar_ShoppingCartDist")%></a></td>
		</tr>
		<%
    	}
    else
    	{
    	%>
		<tr>
			<td class="line" colspan="3"></td>
		</tr>
		<tr class="mbg" width="150" height="30">
			<td class="nav_def" colspan="3"><a class="rlinksblk" href="DistributorCartsByStatusDisplayView?langId=<%=languageId%>&storeId=<%=storeId%>&catalogId=<%=catalogId%>" target="_top"><%=storeText.getString("NavSidebar_ShoppingCartDist")%></a></td>
		</tr>
		<%
	}

    if (currentOption.equals("OrderStatus"))
    	{
    	%>
		<tr>
			<td class="line" colspan="3"></td>
		</tr>
		<tr class="hil" width="150" height="30">
			<td class="nav_sel" colspan="3"><span class="rlinksblk">
				<a href="ProcessedShopCartsByStatusDisplayView?langId=<%=languageId%>&storeId=<%=storeId%>&catalogId=<%=catalogId%>"><%=storeText.getString("NavSidebar_OrderStatusTitle")%></a></span></td>
		</tr>
		<%
	}
    else
    	{
    	%>
		<tr>
			<td class="line" colspan="3"></td>
		</tr>
		<tr class="mbg" width="150" height="30">
			<td class="nav_def" colspan="3"><a class="rlinksblk" href="ProcessedShopCartsByStatusDisplayView?langId=<%=languageId%>&storeId=<%=storeId%>&catalogId=<%=catalogId%>" target="_top"><%=storeText.getString("NavSidebar_OrderStatusTitle")%></a></td>
		</tr>
		<%
    	}
    %>

	<%
    // determine whether user should see the administrative links
    if (showStoreCreationLink || showStoreAdminLink || showOrgAdminLink)
    {
    %>

        <%
        if(showStoreCreationLink) {
        if (currentOption.equals("RequestHostedStore"))
        {
        %>
		<tr>
			<td class="line" colspan="3"></td>
		</tr>
		<tr class="hil" width="150" height="30">
			<td class="nav_sel" colspan="3"><a class="rlinksblk" href="javascript:launchRequestStore();"><%=storeText.getString("NavSidebar_RequestHostedStore")%></a></td>
		</tr>
        <%
        }
        else
        {
            %>
		<tr>
			<td class="line" colspan="3"></td>
		</tr>
		<tr class="mbg" width="150" height="30">
			<td class="nav_def" colspan="3"><a class="rlinksblk" href="javascript:launchRequestStore();"><%=storeText.getString("NavSidebar_RequestHostedStore")%></a></td>
		</tr>
            <%
        }
        }
        %>
        

        <%
        if (showStoreAdminLink)
        {
            if (currentOption.equals("adminConsole"))
            {
                %>
		<tr>
			<td class="line" colspan="3"></td>
		</tr>  
                <tr class="hil" width="150" height="30">
                    <td class="nav_sel" colspan="3"><a class="rlinksblk" href="javascript:launchAdminStore();"><%=storeText.getString("NavSidebar_AdministerStorefront")%></a></td>
                </tr>
                <%
            }
            else
            {
                %>
		<tr>
			<td class="line" colspan="3"></td>
		</tr>
                <tr class="mbg" width="150" height="30">
                    <td class="nav_def" colspan="3"><a class="rlinksblk" href="javascript:launchAdminStore();"><%=storeText.getString("NavSidebar_AdministerStorefront")%></a></td>
                </tr>       
                <%
            }
        }
        %>


        <%
        if(showOrgAdminLink) {
        if (currentOption.equals("MyOrganization"))
        {
            %>
		<tr>
			<td class="line" colspan="3"></td>
		</tr>
		<tr class="hil" width="150" height="30">
			<td class="nav_sel" colspan="3"><a class="rlinksblk" href="javascript:launchAdminConsole();"><%=storeText.getString("NavSidebar_EditOrganization")%></a></td>
		</tr>
            <%
        }
        else
        {
            %>
		<tr>
			<td class="line" colspan="3"></td>
		</tr>
		<tr class="mbg" width="150" height="30">
			<td class="nav_def" colspan="3"><a class="rlinksblk" href="javascript:launchAdminConsole();"><%=storeText.getString("NavSidebar_EditOrganization")%></a></td>
		</tr>
            <%
        }
        }


	} //end selladmin if
	%>
		<tr>
			<td class="line" colspan="3"></td>
		</tr>
		<tr class="mbg" width="150" height="30">
			<td class="nav_def" colspan="3"><a class="rlinksblk" href="javascript:FeedbackWindow(feedbackURL)"><%=storeText.getString("NavSidebar_FeedbackTitle")%></a></td>
		</tr>
		<tr>
			<td class="line" colspan="3"></td>
		</tr>
		<tr class="mbg" width="150" height="30">
			<td class="nav_def" colspan="3"><a class="rlinksblk" href="Logoff?langId=<%=languageId%>&storeId=<%=storeId%>&catalogId=<%=catalogId%>&URL=LogonForm"  target="_top"><%=storeText.getString("NavSidebar_LogoffLink")%></a></td>
		</tr>


<%
}  // end registered if

%>
	</tbody>
</table>

<!--END SIDEBAR NAVIGATION-->
