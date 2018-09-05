<%--
/*
 *-------------------------------------------------------------------
 * Licensed Materials - Property of IBM
 *
 * WebSphere Commerce
 *
 * (c) Copyright International Business Machines Corporation. 2001, 2004
 *     All rights reserved.
 *
 * US Government Users Restricted Rights - Use, duplication or
 * disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
 *
 *-------------------------------------------------------------------
 */
--%>
<%-- 
  *****
  * This JSP page displays the Header in all content pages that include the Layout Container JSP fragments.
  * The following elements are displayed:
  *  - Logo
  *  - Banner
  *  - Search form with 'Search text' field and 'Submit' button.
  *  - Quick order form with 'SKU' field and 'Submit' button.
  *  - Menu: JavaScript drop down menu.
  *  - 'Live help' link.
  *****
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../JSTLEnvironmentSetup.jspf"%>

<!-- BEGIN CachedHeaderDisplay.jsp -->

<%-- 
  ***
  *	Start: Menu: JavaScript drop down menu - Set up.
  * The following JSTL and JavaScript code sets up the drop down menu objects. 
  ***
--%>
<c:url var="ApprovalToolLinkURL" value="${sdb.approvalToolLinkURL}">
</c:url>
<c:url var="BrowserVerErrorURL" value="https://${pageContext.request.serverName}${pageContext.request.contextPath}/servlet/BrowserVerErrorView">
</c:url>

<c:url var="AdvancedSearchViewURL" value="AdvancedSearchView">
	<c:param name="langId" value="${langId}"/>
	<c:param name="storeId" value="${storeId}"/>
	<c:param name="catalogId" value="${catalogId}"/>
</c:url>
<c:url var="QuickOrderViewURL" value="QuickOrderView">
	<c:param name="langId" value="${langId}"/>
	<c:param name="storeId" value="${storeId}"/>
	<c:param name="catalogId" value="${catalogId}"/>
</c:url>
<c:url var="TopCategoriesDisplayURL" value="TopCategoriesDisplay">
	<c:param name="langId" value="${langId}" />
	<c:param name="storeId" value="${storeId}" />
	<c:param name="catalogId" value="${catalogId}" />
</c:url>
<c:url var="AuctionHomeViewURL" value="AuctionHomeView">
	<c:param name="langId" value="${langId}"/>
	<c:param name="storeId" value="${storeId}"/>
	<c:param name="catalogId" value="${catalogId}"/>
</c:url>
<c:url var="AccountViewURL" value="UserAccountView">
	<c:param name="langId" value="${langId}" />
	<c:param name="storeId" value="${storeId}" />
	<c:param name="catalogId" value="${catalogId}" />
</c:url>
<c:url var="UserRegistrationFormURL" value="UserRegistrationForm">
	<c:param name="langId" value="${langId}" />
	<c:param name="storeId" value="${storeId}" />
	<c:param name="catalogId" value="${catalogId}" />
</c:url>
<c:url var="AddressBookFormURL" value="AddressBookForm">
	<c:param name="langId" value="${langId}" />
	<c:param name="storeId" value="${storeId}" />
	<c:param name="catalogId" value="${catalogId}" />
</c:url>
<c:url var="RequisitionListDisplayURL" value="RequisitionListDisplayView">
	<c:param name="langId" value="${langId}" />
	<c:param name="storeId" value="${storeId}" />
	<c:param name="catalogId" value="${catalogId}" />
</c:url>
<c:url var="OrderItemDisplayURL" value="OrderItemDisplayView">
	<c:param name="langId" value="${langId}" />
	<c:param name="storeId" value="${storeId}" />
	<c:param name="catalogId" value="${catalogId}" />
	<c:param name="orderId" value="." />
</c:url>
<c:url var="ListOrdersDisplayURL" value="ListOrdersDisplay">
	<c:param name="langId" value="${langId}" />
	<c:param name="storeId" value="${storeId}" />
	<c:param name="catalogId" value="${catalogId}" />
</c:url>
<c:url var="TrackOrderStatusURL" value="TrackOrderStatus">
	<c:param name="langId" value="${langId}" />
	<c:param name="storeId" value="${storeId}" />
	<c:param name="catalogId" value="${catalogId}" />
</c:url>
<c:url var="HelpViewURL" value="HelpView">
	<c:param name="langId" value="${langId}" />
	<c:param name="storeId" value="${storeId}" />
	<c:param name="catalogId" value="${catalogId}" />
</c:url>
<script language="JavaScript">
<!--
function mmLoadMenus() {

<%-- 
  ***
  *	Start: Menu: JavaScript drop down menu - Sample menu object.
  * The following JSTL and JavaScript code sets up a sample menu object "mm_menu_1_0" with two menu items.
  * The method addMenuItem(link text, link href) adds a text link to the sample menu object.
  * This menu object can be activated by adding onMouseOver="MM_showMenu(window.mm_menu_1_0,25,19,null,'drop_menu_1')" to an HTML object.
  * Note that this example the menu object will appear at the location of the HTML object with the name or id attribute of 'drop_menu_1'.
  ***
--%>
  if (window.mm_menu_1_0) return;

   window.mm_menu_1_0 = new Menu("root",174,17,"Arial, Helvetica, sans-serif",12,"#000000","#FFFFFF","#9999CC","#000084","left","top",0,0,1000,-5,7,true,true,true,0,false,true,18);
   <%-- Add entries here to get more options for this drop down menu --%>
   mm_menu_1_0.addMenuItem("Example Link 1","location='#'");
   mm_menu_1_0.addMenuItem("Example Link 2","location='#'");
   mm_menu_1_0.hideOnMouseOut=true;
   mm_menu_1_0.bgColor='#666699';
   mm_menu_1_0.menuBorder=1;
   mm_menu_1_0.menuLiteBgColor='#FFFFFF';
   mm_menu_1_0.menuBorderBgColor='#666699';
<%-- 
  ***
  *	End: Menu: JavaScript drop down menu - Sample menu object.
  ***
--%>

   window.mm_menu_2_0 = new Menu("root",174,17,"Arial, Helvetica, sans-serif",12,"#000000","#FFFFFF","#9999CC","#000084","left","top",0,0,1000,-5,7,true,true,true,0,false,true,18);
   mm_menu_2_0.addMenuItem("<fmt:message key="Account_Heading1" bundle="${storeText}"/>","location='UserRegistrationForm?langId=<c:out value="${langId}"/>&storeId=<c:out value="${storeId}"/>&catalogId=<c:out value="${catalogId}"/>'");
   mm_menu_2_0.addMenuItem("<fmt:message key="Account_Heading2" bundle="${storeText}"/>","location='AddressBookForm?langId=<c:out value="${langId}"/>&storeId=<c:out value="${storeId}"/>&catalogId=<c:out value="${catalogId}"/>'");
   mm_menu_2_0.addMenuItem("<fmt:message key="HELP_TITLE" bundle="${storeText}"/>","location='HelpView?langId=<c:out value="${langId}"/>&storeId=<c:out value="${storeId}"/>&catalogId=<c:out value="${catalogId}"/>'");
   mm_menu_2_0.hideOnMouseOut=true;
   mm_menu_2_0.bgColor='#666699';
   mm_menu_2_0.menuBorder=1;
   mm_menu_2_0.menuLiteBgColor='#FFFFFF';
   mm_menu_2_0.menuBorderBgColor='#666699';
   
   window.mm_menu_3_0 = new Menu("root",174,17,"Arial, Helvetica, sans-serif",12,"#000000","#FFFFFF","#9999CC","#000084","left","top",0,0,1000,-5,7,true,true,true,0,false,true,18);
<flow:ifEnabled feature="catalogSearch">   
   mm_menu_3_0.addMenuItem("<fmt:message key="Sidebar_Link1" bundle="${storeText}" />","location='AdvancedSearchView?langId=<c:out value="${langId}"/>&storeId=<c:out value="${storeId}"/>&catalogId=<c:out value="${catalogId}"/>'");
</flow:ifEnabled>   
<flow:ifEnabled feature="auctions">
   mm_menu_3_0.addMenuItem("<fmt:message key="Sidebar_Auctions" bundle="${storeText}" />","location='AuctionHomeView?langId=<c:out value="${langId}"/>&storeId=<c:out value="${storeId}"/>&catalogId=<c:out value="${catalogId}"/>'");
</flow:ifEnabled>
   mm_menu_3_0.hideOnMouseOut=true;
   mm_menu_3_0.bgColor='#666699';
   mm_menu_3_0.menuBorder=1;
   mm_menu_3_0.menuLiteBgColor='#FFFFFF';
   mm_menu_3_0.menuBorderBgColor='#666699';
   
   window.mm_menu_4_0 = new Menu("root",174,17,"Arial, Helvetica, sans-serif",12,"#000000","#FFFFFF","#9999CC","#000084","left","top",0,0,1000,-5,7,true,true,true,0,false,true,18);
   mm_menu_4_0.addMenuItem("<fmt:message key="Header_CurrentOrder" bundle="${storeText}" />","location='OrderItemDisplayView?langId=<c:out value="${langId}"/>&storeId=<c:out value="${storeId}"/>&catalogId=<c:out value="${catalogId}"/>&orderId=.'");
<flow:ifEnabled feature="MultipleActiveOrders">
   mm_menu_4_0.addMenuItem("<fmt:message key="Sidebar_ListOrders" bundle="${storeText}" />","location='ListOrdersDisplay?langId=<c:out value="${langId}"/>&storeId=<c:out value="${storeId}"/>&catalogId=<c:out value="${catalogId}"/>'");
</flow:ifEnabled>
<flow:ifEnabled feature="trackOrderStatus">
   mm_menu_4_0.addMenuItem("<fmt:message key="Header_OrderHistory" bundle="${storeText}" />","location='TrackOrderStatus?langId=<c:out value="${langId}"/>&storeId=<c:out value="${storeId}"/>&catalogId=<c:out value="${catalogId}"/>'");
</flow:ifEnabled>
<flow:ifEnabled feature="RequisitionList">
   mm_menu_4_0.addMenuItem("<fmt:message key="Header_RequisitionList" bundle="${storeText}" />","location='RequisitionListDisplay?langId=<c:out value="${langId}"/>&storeId=<c:out value="${storeId}"/>&catalogId=<c:out value="${catalogId}"/>'");
</flow:ifEnabled>
<flow:ifEnabled feature="RFQ">
	<c:if test="${rfqLinkDisplayed eq true}">
   mm_menu_4_0.addMenuItem("<fmt:message key="RFQ_List" bundle="${storeText}" />","location='RFQListDisplay?langId=<c:out value="${langId}"/>&storeId=<c:out value="${storeId}"/>&catalogId=<c:out value="${catalogId}"/>'");
	</c:if>
</flow:ifEnabled>
<flow:ifEnabled feature="QuickOrder">
   mm_menu_4_0.addMenuItem("<fmt:message key="Sidebar_QuickOrder" bundle="${storeText}" />","location='QuickOrderView?langId=<c:out value="${langId}"/>&storeId=<c:out value="${storeId}"/>&catalogId=<c:out value="${catalogId}"/>'");
</flow:ifEnabled>   
   mm_menu_4_0.hideOnMouseOut=true;
   mm_menu_4_0.bgColor='#666699';
   mm_menu_4_0.menuBorder=1;
   mm_menu_4_0.menuLiteBgColor='#FFFFFF';
   mm_menu_4_0.menuBorderBgColor='#666699';

   mm_menu_1_0.writeMenus();
} // mmLoadMenus()
//-->
</script>
<script language="JavaScript" src="<c:out value="${jspStoreImgDir}" />javascript/cssmenu.js"></script>
<script language="JavaScript1.2">mmLoadMenus();</script>
<%-- 
  ***
  *	End: Menu: JavaScript drop down menu - Set up.
  ***
--%>

<%-- 
  ***
  *	Start: Banner
  * If a custom banner is being used, it is obtained from the Hosted Store home directory so that
  * in a hosted environment, each Hosted Store can have its own unique banner. 
  ***
--%>
<flow:ifEnabled feature="CustomBanner">
	<c:set var="bannerImg" value="${storeImgDir}${vfileBanner}" />
</flow:ifEnabled>	
<flow:ifDisabled feature="CustomBanner">
	<c:set var="bannerImg" value="${jspStoreImgDir}${vfileSelectedBanner}" />
</flow:ifDisabled>
<%-- 
  ***
  *	End: Banner
  ***
--%>

<script language="javascript" src="<c:out value="${jspStoreImgDir}javascript/CheckBrowser.js"/>"></script>

<script language="JavaScript">										
       function ApprovalToolLink() {
              //bRightBrowser variable will be populated.
              if (bRightBrowser) {
                     RFQwindow=window.open('<c:out value="${ApprovalToolLinkURL}"/>');
              }
              else {
                     window.location.href=('<c:out value="${BrowserVerErrorURL}"/>');
              }
       }
</script>

<IE:clientCaps ID="oClientCaps" STYLE="behavior:url('#default#clientCaps')"></IE:clientCaps>

<table cellpadding="0" cellspacing="0" border="0" width="100%" class="white" id="WC_CachedHeaderDisplay_Table_1">

	<tr>
		<td class="top_strip" id="WC_CachedHeaderDisplay_TableCell_1"><img src="<c:out value="${jspStoreImgDir}${vfileColor}" />top_strip.gif" alt="" width="447" height="5" border="0" /></td>
	</tr>

	<tr>
		<td id="WC_CachedHeaderDisplay_TableCell_2">
			<table cellpadding="0" cellspacing="0" border="0" width="100%" id="WC_CachedHeaderDisplay_Table_2">
				<tr>
					<td class="padding" id="WC_CachedHeaderDisplay_TableCell_3">
						<%-- 
						  ***
						  *	Start: Logo
						  * If a custom logo is being used, it is obtained from the Hosted Store home directory so that
						  * in a hosted environment, each Hosted Store can have its own unique logo. 
						  ***
						--%>
						<flow:ifEnabled feature="CustomLogo">
							<img alt="<c:out value="${storeName}" />" src="<c:out value="${storeImgDir}${vfileLogo}" />" align="middle"/>
						</flow:ifEnabled>
						<flow:ifDisabled feature="CustomLogo">
							<img alt="<c:out value="${storeName}" />" src="<c:out value="${jspStoreImgDir}${vfileLogo}" />" align="middle"/>
						</flow:ifDisabled>
						<%-- 
						  ***
						  *	End: Logo
						  ***
						--%>
					</td>
					<td class="gradient" id="WC_CachedHeaderDisplay_TableCell_4">
						<table cellpadding="0" cellspacing="0" border="0" width="100%" id="WC_CachedHeaderDisplay_Table_3_1">
							<tr><td id="WC_CachedHeaderDisplay_TableCell_5_1" background="<c:out value="${bannerImg}" />"><img alt="" src="<c:out value="${jspStoreImgDir}" />images/trans.gif" height="30"/></td></tr>
						</table>
					</td>
				</tr>
			</table>
		</td>
	</tr>

	<tr>
		<td class="line" id="WC_CachedHeaderDisplay_TableCell_5">&nbsp;</td>
	</tr>

<%-- 
  ***
  *	Start: Search form
  ***
--%>
<flow:ifEnabled feature="catalogSearch">
	<tr>
		<td id="WC_CachedHeaderDisplay_TableCell_6">
			<form name="HeaderCatalogSearchForm" action="CatalogSearchResultView" method="post" id="CatalogSearchForm" style="margin: 0px;padding: 0px;">
			<table cellpadding="0" cellspacing="0" border="0" width="100%" class="srch" id="WC_CachedHeaderDisplay_Table_3">
				<tr>
					<td class="srch" id="WC_CachedHeaderDisplay_TableCell_7">
						<input type="hidden" name="storeId" value="<c:out value="${storeId}" />" id="WC_CachedHeaderDisplay_FormInput_storeId_In_CatalogSearchForm_1"/>
						<input type="hidden" name="langId" value="<c:out value="${langId}" />" id="WC_CachedHeaderDisplay_FormInput_langId_In_CatalogSearchForm_1"/>
						<input type="hidden" name="catalogId" value="<c:out value="${catalogId}" />" id="WC_CachedHeaderDisplay_FormInput_catalogId_In_CatalogSearchForm_1"/>
						<input type="hidden" name="pageSize" value="10" id="WC_CachedHeaderDisplay_FormInput_pageSize_In_CatalogSearchForm_1"/>
						<input type="hidden" name="beginIndex" value="0" id="WC_CachedHeaderDisplay_FormInput_beginIndex_In_CatalogSearchForm_1"/>
						<input type="hidden" name="sType" value="SimpleSearch" id="WC_CachedHeaderDisplay_FormInput_sType_In_CatalogSearchForm_1"/>
						<input type="hidden" name="searchTermScope" value="3" id="WC_CachedHeaderDisplay_FormInput_searchTermScope_In_CatalogSearchForm_1"/>
						<label for="WC_CachedHeaderDisplay_FormInput_searchTerm_In_CatalogSearchForm_1"><img alt="<fmt:message key="Sidebar_CatalogSearch" bundle="${storeText}" />" src="<c:out value="${jspStoreImgDir}" />images/trans.gif" height="1" width="1"/></label>
						<label for="WC_CachedHeaderDisplay_FormInput_searchTerm_In_CatalogSearchForm_1_2"></label>
						<input id="WC_CachedHeaderDisplay_FormInput_searchTerm_In_CatalogSearchForm_1_2" type="text" size="20" maxlength="254" id="search" class="srch" name="searchTerm" />
					</td>
					<td nowrap id="WC_CachedHeaderDisplay_TableCell_8"><a href="javascript:document.HeaderCatalogSearchForm.submit()" class="srch_but"><fmt:message key="Sidebar_CatalogSearch" bundle="${storeText}" /></a>
					 	<c:url var="AdvancedSearchViewURL" value="AdvancedSearchView">
							<c:param name="langId" value="${langId}"/>
							<c:param name="storeId" value="${storeId}"/>
							<c:param name="catalogId" value="${catalogId}"/>
						</c:url>
						<a href="<c:out value="${AdvancedSearchViewURL}" />" class="smallMenu" id="WC_CachedHeaderDisplay_Link_2a">
							<fmt:message key="Sidebar_Link1" bundle="${storeText}" />
						</a>
					</td>
					
				<%-- 
				  ***
				  *	Start: 'Live help' link
				  ***
				--%>
				<flow:ifEnabled feature="customerCare">
				<c:if test="${liveHelp eq true}">
					<td id="WC_CachedHeaderDisplay_TableCell_8_a" class="nav_button">
					   <a href="javascript:if((parent.sametime != null)) top.interact();" class="smallMenu" id="WC_CachedHeaderDisplay_Link_2b">
					   		<fmt:message key="LiveHelp" bundle="${storeText}" />
					   </a>
					</td>
				</c:if>
				</flow:ifEnabled>
				<%-- 
				  ***
				  *	End: 'Live help' link
				  ***
				--%>
				
					<td id="WC_CachedHeaderDisplay_TableCell_9">&nbsp;</td>
					<td class="stripes" id="WC_CachedHeaderDisplay_TableCell_10" background="<c:out value="${jspStoreImgDir}${vfileColor}" />stripes.gif">&nbsp;</td>
				</tr>
			</table>
			</form>
		</td>
	</tr>
</flow:ifEnabled>
<%-- 
  ***
  *	End: Search form
  ***
--%>

<flow:ifDisabled feature="catalogSearch">
	<tr>
		<td id="WC_CachedHeaderDisplay_TableCell_11">
			<table cellpadding="0" cellspacing="0" border="0" width="100%" class="srch" id="WC_CachedHeaderDisplay_Table_4">
				<tr>
				
				<%-- 
				  ***
				  *	Start: 'Live help' link
				  ***
				--%>
				<flow:ifEnabled feature="customerCare">
				<c:if test="${liveHelp eq true}">
					<td id="WC_CachedHeaderDisplay_TableCell_11_a" class="nav_button">
					   <a href="javascript:if((parent.sametime != null)) top.interact();" class="smallMenu" id="WC_CachedHeaderDisplay_Link_2c">
					   		<fmt:message key="LiveHelp" bundle="${storeText}" />
					   </a>
					</td>
				</c:if>
				</flow:ifEnabled>
				<%-- 
				  ***
				  *	End: 'Live help' link
				  ***
				--%>
				
					<td id="WC_CachedHeaderDisplay_TableCell_12">&nbsp;</td>
					<td class="stripes" id="WC_CachedHeaderDisplay_TableCell_13" background="<c:out value="${jspStoreImgDir}${vfileColor}" />stripes.gif">&nbsp;</td>
				</tr>
			</table>
		</td>
	</tr>
</flow:ifDisabled>
	<tr>
		<td class="srch_strip" id="WC_CachedHeaderDisplay_TableCell_14"><img src="<c:out value="${jspStoreImgDir}${vfileColor}" />srch_strip.gif" alt="" width="78" height="6" border="0"></td>
	</tr>
	<tr>
		<td valign="top" id="WC_CachedHeaderDisplay_TableCell_15">
			<table cellpadding="0" cellspacing="0" border="0" width="100%" id="WC_CachedHeaderDisplay_Table_5">
				<tr class="menu_row">
				
					<%-- 
					  ***
					  *	Start: Menu: JavaScript drop down menu - Activate.
					  * The following JSTL and JavaScript code activates the drop down menu objects. 
					  * Note the images with name and id attributes of the pattern 'drop_menu_X'. 
					  * These are used as the location where the menu objects will appear when activated.
					  ***
					--%>
					<td id="WC_CachedHeaderDisplay_TableCell_16">
						<table cellpadding="0" cellspacing="0" border="0" width="100%" id="WC_CachedHeaderDisplay_Table_6">
							<tr>
								<c:choose>
									<c:when test="${(!empty displayApproverLink) && (displayApproverLink=='true')}">
										<td id="WC_CachedHeaderDisplay_TableCell_17"><img src="<c:out value="${jspStoreImgDir}${vfileColor}" />menu_angle.gif" alt="" width="25" height="19" border="0" name="drop_menu_1" id="drop_menu_1" /></td>
										<td id="WC_CachedHeaderDisplay_TableCell_18">
											<script language="JavaScript">
												checkBrowser(); //calls checkBrowser function for ApprovalToolLink() below		  
											</script>
											<a href="javascript:ApprovalToolLink();" class="menu_but" id="WC_CachedHeaderDisplay_Link_2">
												<fmt:message key="Header4_Approvals" bundle="${storeText}" />
											</a>
										</td>
									</c:when>
									<c:otherwise>
										<td id="WC_CachedHeaderDisplay_TableCell_17"><img src="<c:out value="${jspStoreImgDir}${vfileColor}" />menu_angle.gif" alt="" width="25" height="19" border="0" name="drop_menu_1" id="drop_menu_1" /></td>
										<td id="WC_CachedHeaderDisplay_TableCell_18">
										<a href="<c:out value="${TopCategoriesDisplayURL}" />" class="menu_but" id="WC_CachedHeaderDisplay_Link_2">
											<fmt:message key="Header3_Home" bundle="${storeText}" />
										</a>
										</td>
									</c:otherwise>
								</c:choose>
								<td id="WC_CachedHeaderDisplay_TableCell_19"><img src="<c:out value="${jspStoreImgDir}${vfileColor}" />menu_angle.gif" alt="" width="25" height="19" border="0" name="drop_menu_2" id="drop_menu_2" /></td>
								<td id="WC_CachedHeaderDisplay_TableCell_20">
										<a href="<c:out value="${AccountViewURL}" />" class="menu_but" id="WC_CachedHeaderDisplay_Link_3" onMouseOver="MM_showMenu(window.mm_menu_2_0,25,19,null,'drop_menu_2')" onMouseOut="MM_startTimeout();">
											<fmt:message key="Header3_Account" bundle="${storeText}" />
										</a>
								</td>
								<td id="WC_CachedHeaderDisplay_TableCell_21"><img src="<c:out value="${jspStoreImgDir}${vfileColor}" />menu_angle.gif" alt="" width="25" height="19" border="0" name="drop_menu_3" id="drop_menu_3" /></td>
								<td id="WC_CachedHeaderDisplay_TableCell_22">
										<a href="<c:out value="${TopCategoriesDisplayURL}" />" class="menu_but" id="WC_CachedHeaderDisplay_Link_4" onMouseOver="MM_showMenu(window.mm_menu_3_0,25,19,null,'drop_menu_3')" onMouseOut="MM_startTimeout();">
											<fmt:message key="Header3_Catalog" bundle="${storeText}" />
										</a>
								</td>
								<td id="WC_CachedHeaderDisplay_TableCell_25"><img src="<c:out value="${jspStoreImgDir}${vfileColor}" />menu_angle.gif" alt="" width="25" height="19" border="0" name="drop_menu_4" id="drop_menu_4" /></td>
								<td id="WC_CachedHeaderDisplay_TableCell_26">
										<a href="<c:out value="${OrderItemDisplayURL}" />" class="menu_but" id="WC_CachedHeaderDisplay_Link_7" onMouseOver="MM_showMenu(window.mm_menu_4_0,25,19,null,'drop_menu_4')" onMouseOut="MM_startTimeout();">
											<fmt:message key="Header4_Orders" bundle="${storeText}" />
										</a>
								</td>
								<td id="WC_CachedHeaderDisplay_TableCell_27"><img src="<c:out value="${jspStoreImgDir}${vfileColor}" />menu_angle.gif" alt="" width="25" height="19" border="0" /></td>
								<c:if test="${userState eq '1'}" >
								<td id="WC_CachedHeaderDisplay_TableCell_28">
									<c:url var="LogoffURL" value="Logoff">
										<c:param name="langId" value="${langId}" />
										<c:param name="storeId" value="${storeId}" />
										<c:param name="catalogId" value="${catalogId}" />
									</c:url>
									<a href="<c:out value="${LogoffURL}" />" class="menu_but" id="WC_CachedHeaderDisplay_Link_10"><fmt:message key="Header3_Logoff" bundle="${storeText}" /></a>
								</td>
								</c:if>

								<td id="WC_CachedHeaderDisplay_TableCell_29"><img src="<c:out value="${jspStoreImgDir}${vfileColor}" />menu_angle.gif" alt="" width="25" height="19" border="0" /></td>
							</tr>
						</table>
					</td>
					<%-- 
					  ***
					  *	End: Menu: JavaScript drop down menu - Activate.
					  ***
					--%>
					
				<%-- 
				  ***
				  *	Start: Quick order form
				  ***
				--%>
				<flow:ifEnabled feature="QuickOrder">
					<td align="right" valign="top" id="WC_CachedHeaderDisplay_TableCell_30">
						<form name="QuickOrderForm" action="OrderItemAdd" method="POST" id="QuickOrderForm" style="margin: 0px;padding: 0px;">
						<table cellpadding="0" cellspacing="0" border="0" id="WC_CachedHeaderDisplay_Table_7">
							<tr>
								<td class="sku" id="WC_CachedHeaderDisplay_TableCell_31">
									<input type="hidden" name="storeId" value="<c:out value="${storeId}" />" id="WC_CachedSidebarDisplay_FormInput_storeId_In_QuickOrderForm_1"/>
							  		<input type="hidden" name="catalogId" value="<c:out value="${catalogId}" />" id="WC_CachedSidebarDisplay_FormInput_catalogId_In_QuickOrderForm_1"/>
							  		<input type="hidden" name="langId" value="<c:out value="${langId}" />" id="WC_CachedSidebarDisplay_FormInput_langId_In_QuickOrderForm_1"/>
							  		<input type="hidden" name="quantity" value="1" id="WC_CachedSidebarDisplay_FormInput_quantity_In_QuickOrderForm_1"/>
							  		<input type="hidden" name="orderId" value="." id="WC_CachedSidebarDisplay_FormInput_orderId_In_QuickOrderForm_1"/>
							  		<input type="hidden" name="URL" value="SetPendingOrder?URL=OrderCalculate?URL=OrderItemDisplay?partNumber*=&quantity*=&updatePrices=1&calculationUsageId=-1" id="WC_CachedSidebarDisplay_FormInput_URL_In_QuickOrderForm_1"/>
							  		<input type="hidden" name="outOrderName" value="orderId" id="WC_CachedSidebarDisplay_FormInput_outOrderName_In_QuickOrderForm_1"/>
							  		<input type="hidden" name="errorViewName" value="QuickOrderView" id="WC_CachedSidebarDisplay_FormInput_errorViewName_In_QuickOrderForm_1"/>
							  		<input type="text" name="partNumber" size="14" class="sku" id="WC_CachedHeaderDisplay_FormInput_partNumber_In_QuickOrderForm_1">
						  		</td>
						  		<td class="sku_but" id="WC_CachedHeaderDisplay_TableCell_32"><a href="javascript:document.QuickOrderForm.submit()" class="sku_but"><label for="WC_CachedHeaderDisplay_FormInput_partNumber_In_QuickOrderForm_1"><fmt:message key="Sidebar_QuickOrder" bundle="${storeText}" /></label></a></td>
							</tr>
						</table>
						</form>
					</td>
				</flow:ifEnabled>
				<%-- 
				  ***
				  *	End: Quick order form
				  ***
				--%>
				
				<flow:ifDisabled feature="QuickOrder">
					<td align="right" valign="top" id="WC_CachedHeaderDisplay_TableCell_33">
						&nbsp;
					</td>
				</flow:ifDisabled>

				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td class="menu_strip" id="WC_CachedHeaderDisplay_TableCell_34"><img src="<c:out value="${jspStoreImgDir}${vfileColor}" />menu_strip.gif" alt="" width="21" height="5" border="0"></td>
	</tr>
</table>

<flow:ifEnabled feature="customerCare">
	<jsp:include page="../../CustomerCareHeaderSetup.jsp" flush="true" />
</flow:ifEnabled>

<!-- END CachedHeaderDisplay.jsp -->
