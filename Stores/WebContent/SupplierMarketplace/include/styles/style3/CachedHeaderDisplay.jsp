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
  *  - 'Home' button
  *  - 'Logoff' button
  *****
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../JSTLEnvironmentSetup.jspf"%>

<!-- BEGIN CachedHeaderDisplay.jsp -->

<%--
//  This JSP is called from HeaderDisplay.jsp and is cached based on the parameters 
//  passed in and defined in the cachespec.xml file.
--%>

<table cellpadding="0" cellspacing="0" border="0" width="100%" id="WC_CachedHeaderDisplay_Table_1">	
	<tr>
	<td id="WC_CachedHeaderDisplay_TableCell_1a">
	<table cellpadding="0" cellspacing="0" border="0" width="100%" id="WC_CachedHeaderDisplay_Table_1a">	
	<tr>
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
		<td class="banner" width="715" background="<c:out value="${bannerImg}"/>" id="WC_CachedHeaderDisplay_TableCell_1">
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
		<td class="ban_tile" id="WC_CachedHeaderDisplay_TableCell_2"><img src="<c:out value="${jspStoreImgDir}${vfileColor}" />tile.gif" alt="" width="12" height="50" border="0"></td>
	<%-- 
	  ***
	  *	Start: Search form
	  ***
	--%>
	<flow:ifEnabled feature="catalogSearch">
		<td align="right" class="ban_tile" id="WC_CachedHeaderDisplay_TableCell_3">			
			<form name="HeaderCatalogSearchForm" action="CatalogSearchResultView" method="post" id="CatalogSearchForm" style="margin: 0px;padding: 0px;">
			<table cellpadding="0" cellspacing="0" border="0" id="WC_CachedHeaderDisplay_Table_2">
				
				<tr>
					<td width="30" rowspan="2" id="WC_CachedHeaderDisplay_TableCell_4"><img src="<c:out value="${jspStoreImgDir}${vfileColor}" />srch_curve.gif" alt="" width="30" height="50" border="0"></td>
					<td class="ban_srchtile" colspan="2" id="WC_CachedHeaderDisplay_TableCell_5"><img src="<c:out value="${jspStoreImgDir}${vfileColor}" />srch_tile.gif" alt="" width="18" height="17" border="0"></td>
				</tr>
				<tr>
					<td height="33" class="ban_search" id="WC_CachedHeaderDisplay_TableCell_6">
						<input type="hidden" name="storeId" value="<c:out value="${storeId}" />" id="WC_CachedSidebarDisplay_FormInput_storeId_In_CatalogSearchForm_1"/>
						<input type="hidden" name="langId" value="<c:out value="${langId}" />" id="WC_CachedSidebarDisplay_FormInput_langId_In_CatalogSearchForm_1"/>
						<input type="hidden" name="catalogId" value="<c:out value="${catalogId}" />" id="WC_CachedSidebarDisplay_FormInput_catalogId_In_CatalogSearchForm_1"/>
						<input type="hidden" name="pageSize" value="10" id="WC_CachedSidebarDisplay_FormInput_pageSize_In_CatalogSearchForm_1"/>
						<input type="hidden" name="beginIndex" value="0" id="WC_CachedSidebarDisplay_FormInput_beginIndex_In_CatalogSearchForm_1"/>
						<input type="hidden" name="sType" value="SimpleSearch" id="WC_CachedSidebarDisplay_FormInput_sType_In_CatalogSearchForm_1"/>
						<input type="hidden" name="searchTermScope" value="3" id="WC_CachedSidebarDisplay_FormInput_searchTermScope_In_CatalogSearchForm_1"/>
						<label for="WC_CachedSidebarDisplay_FormInput_searchTerm_In_CatalogSearchForm_1"><img alt="<fmt:message key="Sidebar_CatalogSearch" bundle="${storeText}" />" src="<c:out value="${storeImgDir}" />images/trans.gif" height="1" width="1"/></label>
						<input type="text" size="17" maxlength="254" class="search" name="searchTerm" id="WC_CachedSidebarDisplay_FormInput_searchTerm_In_CatalogSearchForm_1"/>
					</td>
					<td height="33" class="ban_search" id="WC_CachedHeaderDisplay_TableCell_7">&nbsp;<a href="javascript:document.HeaderCatalogSearchForm.submit()" class="ban_srch_button" id="WC_CachedHeaderDisplay_Link_1"><fmt:message key="Sidebar_CatalogSearch" bundle="${storeText}" /></a></td>
				</tr>	
			</table>
			</form>
		</td>
	</flow:ifEnabled>
	<%-- 
	  ***
	  *	End: Search form
	  ***
	--%>
	</tr></table></td>
	</tr>
	<tr>
		<td class="ban_blueline" width="715" id="WC_CachedHeaderDisplay_TableCell_8">&nbsp;</td>
	</tr>
	<tr>
		<td class="ban_buttons_bk" id="WC_CachedHeaderDisplay_TableCell_9">
			<table cellpadding="0" cellspacing="0" border="0" id="WC_CachedHeaderDisplay_Table_3">
				<tr>
					<%-- 
					  ***
					  *	Start: 'Home' button
					  ***
					--%>
					<td id="WC_CachedHeaderDisplay_TableCell_10"><img src="<c:out value="${jspStoreImgDir}${vfileColor}" />v_line.gif" alt="" width="1" height="22" border="0"></td>
					<td id="WC_CachedHeaderDisplay_TableCell_11">
						<c:url var="TopCategoriesDisplayURL" value="TopCategoriesDisplay">
							<c:param name="langId" value="${langId}" />
							<c:param name="storeId" value="${storeId}" />
							<c:param name="catalogId" value="${catalogId}" />
						</c:url>
						<a href="<c:out value="${TopCategoriesDisplayURL}" />" class="ban_button" id="WC_CachedHeaderDisplay_Link_2">
							<fmt:message key="Header3_Home" bundle="${storeText}" />
						</a>
					</td>
					<%-- 
					  ***
					  *	End: 'Home' button
					  ***
					--%>
					
					<%-- Uncomment the following for additional buttons
					<td id="WC_CachedHeaderDisplay_TableCell_12"><img src="<c:out value="${jspStoreImgDir}${vfileColor}" />v_line.gif" alt="" width="1" height="22" border="0"></td>
					<td id="WC_CachedHeaderDisplay_TableCell_13"><a href="#" class="ban_button" id="WC_CachedHeaderDisplay_Link_e1"><fmt:message key="Header3_AboutUs" bundle="${storeText}" /></a></td>
					<td id="WC_CachedHeaderDisplay_TableCell_14"><img src="<c:out value="${jspStoreImgDir}${vfileColor}" />v_line.gif" alt="" width="1" height="22" border="0"></td>
					<td id="WC_CachedHeaderDisplay_TableCell_15"><a href="#" class="ban_button" id="WC_CachedHeaderDisplay_Link_e2"><fmt:message key="Header3_CustomerService" bundle="${storeText}" /></a></td>
					<td id="WC_CachedHeaderDisplay_TableCell_16"><img src="<c:out value="${jspStoreImgDir}${vfileColor}" />v_line.gif" alt="" width="1" height="22" border="0"></td>
					<td id="WC_CachedHeaderDisplay_TableCell_17"><a href="#" class="ban_button" id="WC_CachedHeaderDisplay_Link_e3"><fmt:message key="Header3_FAQ" bundle="${storeText}" /></a></td>
					<td id="WC_CachedHeaderDisplay_TableCell_18"><img src="<c:out value="${jspStoreImgDir}${vfileColor}" />v_line.gif" alt="" width="1" height="22" border="0"></td>
					<td id="WC_CachedHeaderDisplay_TableCell_19"><a href="#" class="ban_button" id="WC_CachedHeaderDisplay_Link_e4"><fmt:message key="Header3_ContactUs" bundle="${storeText}" /></a></td>
					<td id="WC_CachedHeaderDisplay_TableCell_20"><img src="<c:out value="${jspStoreImgDir}${vfileColor}" />v_line.gif" alt="" width="1" height="22" border="0"></td>
					<td id="WC_CachedHeaderDisplay_TableCell_21"><a href="#" class="ban_button" id="WC_CachedHeaderDisplay_Link_e5"><fmt:message key="Header3_Sitemap" bundle="${storeText}" /></a></td>
					--%>
					
					<%-- 
					  ***
					  *	Start: 'Logoff' button
					  ***
					--%>
					<c:if test="${userState eq '1'}" >
					<td id="WC_CachedHeaderDisplay_TableCell_22"><img src="<c:out value="${jspStoreImgDir}${vfileColor}" />v_line.gif" alt="" width="1" height="22" border="0"></td>
					<td id="WC_CachedHeaderDisplay_TableCell_23"><c:url var="LogoffURL" value="Logoff">
							<c:param name="langId" value="${langId}" />
							<c:param name="storeId" value="${storeId}" />
							<c:param name="catalogId" value="${catalogId}" />
						</c:url><a href="<c:out value="${LogoffURL}" />" class="ban_button" id="WC_CachedHeaderDisplay_Link_10"><fmt:message key="Header3_Logoff" bundle="${storeText}" /></a></td>
					</c:if>
					<td id="WC_CachedHeaderDisplay_TableCell_24"><img src="<c:out value="${jspStoreImgDir}${vfileColor}" />v_line.gif" alt="" width="1" height="22" border="0"></td>
					
					<%-- 
					  ***
					  *	End: 'Logoff' button
					  ***
					--%>
					
				<%-- 
				  ***
				  *	Start: Quick order form
				  ***
				--%>
				<flow:ifEnabled feature="QuickOrder">
					<td id="WC_CachedHeaderDisplay_TableCell_25"><span class="ban_text"><label for="WC_CachedSidebarDisplay_FormInput_partNumber_In_QuickOrderForm_1"><fmt:message key="Sidebar_QuickOrder" bundle="${storeText}" /></label></span></td>
					<td id="WC_CachedHeaderDisplay_TableCell_26">
						<form name="QuickOrderForm" action="OrderItemAdd" method="POST" id="QuickOrderForm" style="margin: 0px;padding: 0px;">
						<table cellpadding="0" cellspacing="0" border="0" id="WC_CachedHeaderDisplay_Table_4">
							<tr>
								<td class="ban_quickorder" width="115" id="WC_CachedHeaderDisplay_TableCell_27">
									<input type="hidden" name="storeId" value="<c:out value="${storeId}" />" id="WC_CachedSidebarDisplay_FormInput_storeId_In_QuickOrderForm_1"/>
							  		<input type="hidden" name="catalogId" value="<c:out value="${catalogId}" />" id="WC_CachedSidebarDisplay_FormInput_catalogId_In_QuickOrderForm_1"/>
							  		<input type="hidden" name="langId" value="<c:out value="${langId}" />" id="WC_CachedSidebarDisplay_FormInput_langId_In_QuickOrderForm_1"/>
							  		<input type="hidden" name="quantity" value="1" id="WC_CachedSidebarDisplay_FormInput_quantity_In_QuickOrderForm_1"/>
							  		<input type="hidden" name="orderId" value="." id="WC_CachedSidebarDisplay_FormInput_orderId_In_QuickOrderForm_1"/>
							  		<input type="hidden" name="URL" value="SetPendingOrder?URL=OrderCalculate?URL=OrderItemDisplay?partNumber*=&quantity*=&updatePrices=1&calculationUsageId=-1" id="WC_CachedSidebarDisplay_FormInput_URL_In_QuickOrderForm_1"/>
							  		<input type="hidden" name="outOrderName" value="orderId" id="WC_CachedSidebarDisplay_FormInput_outOrderName_In_QuickOrderForm_1"/>
							  		<input type="hidden" name="errorViewName" value="QuickOrderView" id="WC_CachedSidebarDisplay_FormInput_errorViewName_In_QuickOrderForm_1"/>
							  		<input class="search" type="text" name="partNumber" value="<fmt:message key="Sidebar_EnterSKU" bundle="${storeText}" />" size="19" id="WC_CachedSidebarDisplay_FormInput_partNumber_In_QuickOrderForm_1">
						  		</td>
								<td class="ban_quickorder" id="WC_CachedHeaderDisplay_TableCell_28"><a href="javascript:document.QuickOrderForm.submit()" class="ban_srch_button" id="WC_CachedHeaderDisplay_Link_11"><fmt:message key="Sidebar_Go2" bundle="${storeText}" /></a>&nbsp;&nbsp;</td>
							</tr>
						</table>
						</form>
					</td>
					<td id="WC_CachedHeaderDisplay_TableCell_29"><img src="<c:out value="${jspStoreImgDir}${vfileColor}" />v_line.gif" alt="" width="1" height="22" border="0"></td>
				</flow:ifEnabled>
				<%-- 
				  ***
				  *	End: Quick order form
				  ***
				--%>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td class="ban_blueline" id="WC_CachedHeaderDisplay_TableCell_30">&nbsp;</td>
	</tr>
	<tr>
		<td class="ban_shadow" id="WC_CachedHeaderDisplay_TableCell_31">&nbsp;</td>
	</tr>
</table>

<flow:ifEnabled feature="customerCare">
	<jsp:include page="../../CustomerCareHeaderSetup.jsp" flush="true" />
</flow:ifEnabled>

<!-- END CachedHeaderDisplay.jsp -->