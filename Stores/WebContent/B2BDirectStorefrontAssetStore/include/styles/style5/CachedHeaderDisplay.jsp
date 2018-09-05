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
  *  - Menu
  *  - 'Live help' link
  *****
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../JSTLEnvironmentSetup.jspf"%>

<!-- BEGIN CachedHeaderDisplay.jsp -->
<c:url var="ApprovalToolLinkURL" value="${sdb.approvalToolLinkURL}">
</c:url>
<c:url var="BrowserVerErrorURL" value="https://${pageContext.request.serverName}${pageContext.request.contextPath}/servlet/BrowserVerErrorView">
</c:url>

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

<table cellpadding="0" cellspacing="0" border="0" width="100%" id="WC_CachedHeaderDisplay_Table_1">
	<tr>
		<td class="logotile" id="WC_CachedHeaderDisplay_TableCell_1">
			<table width="100%" cellpadding="0" cellspacing="0" border="0" id="WC_CachedHeaderDisplay_Table_2">
				<tr>
					<td class="tenpx" id="WC_CachedHeaderDisplay_TableCell_2">
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
					<c:if test="${userState eq '1'}" >
					<td class="logbut" id="WC_CachedHeaderDisplay_TableCell_3">
						<c:url var="LogoffURL" value="Logoff">
							<c:param name="langId" value="${langId}" />
							<c:param name="storeId" value="${storeId}" />
							<c:param name="catalogId" value="${catalogId}" />
						</c:url>
						<a href="<c:out value="${LogoffURL}" />" class="button" id="WC_CachedHeaderDisplay_Link_10">
							<fmt:message key="Header3_Logoff" bundle="${storeText}" />
						</a>
					</td>
					</c:if>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td class="greyline" id="WC_CachedHeaderDisplay_TableCell_4">&nbsp;</td>
	</tr>
	<tr>
		<td class="buttontile" id="WC_CachedHeaderDisplay_TableCell_5">
			<table cellpadding="0" cellspacing="0" border="0" id="WC_CachedHeaderDisplay_Table_3">
				<tr>
					<%-- 
					  ***
					  *	Start: Search form
					  ***
					--%>
					<flow:ifEnabled feature="catalogSearch">
						<form name="HeaderCatalogSearchForm" action="CatalogSearchResultView" method="post" id="CatalogSearchForm" >
						<td class="searchtile" valign="top" id="WC_CachedHeaderDisplay_TableCell_6">
							<input type="hidden" name="storeId" value="<c:out value="${storeId}" />" id="WC_CachedHeaderDisplay_FormInput_storeId_In_CatalogSearchForm_1"/>
							<input type="hidden" name="langId" value="<c:out value="${langId}" />" id="WC_CachedHeaderDisplay_FormInput_langId_In_CatalogSearchForm_1"/>
							<input type="hidden" name="catalogId" value="<c:out value="${catalogId}" />" id="WC_CachedHeaderDisplay_FormInput_catalogId_In_CatalogSearchForm_1"/>
							<input type="hidden" name="pageSize" value="10" id="WC_CachedHeaderDisplay_FormInput_pageSize_In_CatalogSearchForm_1"/>
							<input type="hidden" name="beginIndex" value="0" id="WC_CachedHeaderDisplay_FormInput_beginIndex_In_CatalogSearchForm_1"/>
							<input type="hidden" name="sType" value="SimpleSearch" id="WC_CachedHeaderDisplay_FormInput_sType_In_CatalogSearchForm_1"/>
							<input type="hidden" name="searchTermScope" value="3" id="WC_CachedHeaderDisplay_FormInput_searchTermScope_In_CatalogSearchForm_1"/>
							<table cellpadding="0" cellspacing="0" border="0" id="WC_CachedHeaderDisplay_Table_4">
								<tr class="searchtile">
									<td class="searchpx" valign="top" id="WC_CachedHeaderDisplay_TableCell_7">
									<label for="WC_CachedHeaderDisplay_FormInput_searchTerm_In_CatalogSearchForm_1"><img alt="<fmt:message key="Sidebar_CatalogSearch" bundle="${storeText}" />" src="<c:out value="${jspStoreImgDir}" />images/trans.gif" height="1" width="1"/></label>
									<input type="text" name="searchTerm" size="12" maxlength="254" class="search" id="WC_CachedHeaderDisplay_FormInput_searchTerm_In_CatalogSearchForm_1">
									</td>
									<td class="searchbut" valign="top" id="WC_CachedHeaderDisplay_TableCell_8"><a href="javascript:document.HeaderCatalogSearchForm.submit()" class="button"><fmt:message key="Sidebar_CatalogSearch" bundle="${storeText}" /></a></td>
								</tr>
							</table>
						</td>
						</form>
					</flow:ifEnabled>
					<%-- 
					  ***
					  *	End: Search form
					  ***
					--%>
					
					<%-- 
					  ***
					  *	Start: Menu
					  ***
					--%>
					<td valign="top" id="WC_CachedHeaderDisplay_TableCell_9"><img src="<c:out value="${jspStoreImgDir}${vfileColor}" />menu_line.gif" alt="" width="1" height="28" border="0"></td>
					<td valign="top" id="WC_CachedHeaderDisplay_TableCell_10">
						<c:url var="TopCategoriesDisplayURL" value="TopCategoriesDisplay">
							<c:param name="langId" value="${langId}" />
							<c:param name="storeId" value="${storeId}" />
							<c:param name="catalogId" value="${catalogId}" />
						</c:url>
						<a href="<c:out value="${TopCategoriesDisplayURL}" />" class="menubutton" id="WC_CachedHeaderDisplay_Link_2">
							<fmt:message key="Header3_Home" bundle="${storeText}" />
						</a>
					</td>
					<td valign="top" id="WC_CachedHeaderDisplay_TableCell_13"><img src="<c:out value="${jspStoreImgDir}${vfileColor}" />menu_line.gif" alt="" width="1" height="28" border="0"></td>
					<td valign="top" id="WC_CachedHeaderDisplay_TableCell_14">
						<c:url var="AccountViewURL" value="UserAccountView">
							<c:param name="langId" value="${langId}" />
							<c:param name="storeId" value="${storeId}" />
							<c:param name="catalogId" value="${catalogId}" />
						</c:url>
						<a href="<c:out value="${AccountViewURL}" />" class="menubutton" id="WC_CachedHeaderDisplay_Link_4">
							<fmt:message key="Header3_Account" bundle="${storeText}" />
						</a>
					</td>

				<flow:ifEnabled feature="RequisitionList">
					<td valign="top" id="WC_CachedHeaderDisplay_TableCell_17"><img src="<c:out value="${jspStoreImgDir}${vfileColor}" />menu_line.gif" alt="" width="1" height="28" border="0"></td>
					<td valign="top" id="WC_CachedHeaderDisplay_TableCell_18">
						<c:url var="RequisitionListDisplayURL" value="RequisitionListDisplay">
							<c:param name="langId" value="${langId}" />
							<c:param name="storeId" value="${storeId}" />
							<c:param name="catalogId" value="${catalogId}" />
						</c:url>
						<a href="<c:out value="${RequisitionListDisplayURL}" />" class="menubutton" id="WC_CachedHeaderDisplay_Link_6">
							<fmt:message key="Header3_RequisitionList" bundle="${storeText}" />
						</a>
					</td>
				</flow:ifEnabled>
				
				<flow:ifEnabled feature="RFQ">
					<c:if test="${rfqLinkDisplayed eq true}">
						<td valign="top" id="WC_CachedHeaderDisplay_TableCell_19"><img src="<c:out value="${jspStoreImgDir}${vfileColor}" />menu_line.gif" alt="" width="1" height="28" border="0"></td>
						<td valign="top" id="WC_CachedHeaderDisplay_TableCell_20">
							<c:url var="RFQListDisplayURL" value="RFQListDisplay">
								<c:param name="langId" value="${langId}" />
								<c:param name="storeId" value="${storeId}" />
								<c:param name="catalogId" value="${catalogId}" />
							</c:url>
							<a href="<c:out value="${RFQListDisplayURL}" />" class="menubutton" id="WC_CachedHeaderDisplay_Link_7">
								<fmt:message key="Header4_RFQ" bundle="${storeText}" />
							</a>
						</td>
					</c:if>
				</flow:ifEnabled>
					
					<td valign="top" id="WC_CachedHeaderDisplay_TableCell_21"><img src="<c:out value="${jspStoreImgDir}${vfileColor}" />menu_line.gif" alt="" width="1" height="28" border="0"></td>
					<td valign="top" id="WC_CachedHeaderDisplay_TableCell_22">
						<c:url var="OrderItemDisplayURL" value="OrderItemDisplay">
							<c:param name="langId" value="${langId}" />
							<c:param name="storeId" value="${storeId}" />
							<c:param name="catalogId" value="${catalogId}" />
							<c:param name="orderId" value="*" />
						</c:url>
						<a href="<c:out value="${OrderItemDisplayURL}" />" class="menubutton" id="WC_CachedHeaderDisplay_Link_8">
							<fmt:message key="Header3_CurrentOrder" bundle="${storeText}" />
						</a>
					</td>
					
				<flow:ifEnabled feature="trackOrderStatus">
					<td valign="top" id="WC_CachedHeaderDisplay_TableCell_23"><img src="<c:out value="${jspStoreImgDir}${vfileColor}" />menu_line.gif" alt="" width="1" height="28" border="0"></td>
					<td valign="top" id="WC_CachedHeaderDisplay_TableCell_24">
						<c:url var="TrackOrderStatusURL" value="TrackOrderStatus">
							<c:param name="langId" value="${langId}" />
							<c:param name="storeId" value="${storeId}" />
							<c:param name="catalogId" value="${catalogId}" />
						</c:url>
						<a href="<c:out value="${TrackOrderStatusURL}"/>" class="menubutton" id="WC_CachedHeaderDisplay_Link_9">
							<fmt:message key="Header3_OrderHistory" bundle="${storeText}" />
						</a>
					</td>
				</flow:ifEnabled>
				<c:if test="${(!empty displayApproverLink) && (displayApproverLink=='true')}">
					<script language="JavaScript">
						checkBrowser(); //calls checkBrowser function for ApprovalToolLink() below		  
					</script>
					<td valign="top" id="WC_CachedHeaderDisplay_TableCell_11"><img src="<c:out value="${jspStoreImgDir}${vfileColor}" />menu_line.gif" alt="" width="1" height="28" border="0"></td>
					<td valign="top" id="WC_CachedHeaderDisplay_TableCell_12">
						<a href="javascript:ApprovalToolLink();" class="menubutton" id="WC_CachedHeaderDisplay_Link_3">
							<fmt:message key="Header5_Approvals" bundle="${storeText}" />
						</a>
					</td>
				</c:if>
					<td valign="top" id="WC_CachedHeaderDisplay_TableCell_24a"><img src="<c:out value="${jspStoreImgDir}${vfileColor}" />menu_line.gif" alt="" width="1" height="28" border="0"></td>
					<td valign="top" id="WC_CachedHeaderDisplay_TableCell_24b">
						<c:url var="HelpViewURL" value="HelpView">
							<c:param name="langId" value="${langId}" />
							<c:param name="storeId" value="${storeId}" />
							<c:param name="catalogId" value="${catalogId}" />
						</c:url>
						<a href="<c:out value="${HelpViewURL}"/>" class="menubutton" id="WC_CachedHeaderDisplay_Link_9b">
							<fmt:message key="Header3_Help" bundle="${storeText}" />
						</a>
					</td>
					<%-- 
					  ***
					  *	End: Menu
					  ***
					--%>
					
				<%-- 
				  ***
				  *	Start: Quick order form
				  ***
				--%>
				<flow:ifEnabled feature="QuickOrder">
					<td valign="top" id="WC_CachedHeaderDisplay_TableCell_25"><img src="<c:out value="${jspStoreImgDir}${vfileColor}" />menu_line.gif" alt="" width="1" height="28" border="0"></td>
					
					<td class="skutext" valign="top" id="WC_CachedHeaderDisplay_TableCell_26"><label for="WC_CachedHeaderDisplay_FormInput_partNumber_In_QuickOrderForm_1"><fmt:message key="Sidebar_QuickOrder" bundle="${storeText}" /></label></td>
					
					<td valign="top" id="WC_CachedHeaderDisplay_TableCell_27">
					
						<table cellpadding="0" cellspacing="0" border="0" id="WC_CachedHeaderDisplay_Table_5">
							<form name="QuickOrderForm" action="OrderItemAdd" method="POST" id="QuickOrderForm">
							<tr>
								<td valign="top" class="skupx" id="WC_CachedHeaderDisplay_TableCell_28">
									<input type="hidden" name="storeId" value="<c:out value="${storeId}" />" id="WC_CachedHeaderDisplay_FormInput_storeId_In_QuickOrderForm_1"/>
							  		<input type="hidden" name="catalogId" value="<c:out value="${catalogId}" />" id="WC_CachedHeaderDisplay_FormInput_catalogId_In_QuickOrderForm_1"/>
							  		<input type="hidden" name="langId" value="<c:out value="${langId}" />" id="WC_CachedHeaderDisplay_FormInput_langId_In_QuickOrderForm_1"/>
							  		<input type="hidden" name="quantity" value="1" id="WC_CachedHeaderDisplay_FormInput_quantity_In_QuickOrderForm_1"/>
							  		<input type="hidden" name="orderId" value="." id="WC_CachedHeaderDisplay_FormInput_orderId_In_QuickOrderForm_1"/>
							  		<input type="hidden" name="URL" value="SetPendingOrder?URL=OrderCalculate?URL=OrderItemDisplay?partNumber*=&quantity*=&updatePrices=1&calculationUsageId=-1" id="WC_CachedHeaderDisplay_FormInput_URL_In_QuickOrderForm_1"/>
							  		<input type="hidden" name="outOrderName" value="orderId" id="WC_CachedHeaderDisplay_FormInput_outOrderName_In_QuickOrderForm_1"/>
							  		<input type="hidden" name="status" value="s" id="WC_CachedHeaderDisplay_FormInput_status_In_QuickOrderForm_1"/>
							  		<input type="hidden" name="errorViewName" value="QuickOrderView" id="WC_CachedHeaderDisplay_FormInput_errorViewName_In_QuickOrderForm_1"/>
							  		<input type="text" name="partNumber" value="<fmt:message key="Sidebar_EnterSKU" bundle="${storeText}" />" size="22" class="sku" id="WC_CachedHeaderDisplay_FormInput_partNumber_In_QuickOrderForm_1">
						  		</td>
								<td class="skubut" valign="top" id="WC_CachedHeaderDisplay_TableCell_29"><a href="javascript:document.QuickOrderForm.submit()" class="button"><fmt:message key="Sidebar_Go2" bundle="${storeText}" /></a>&nbsp;</td>
							</tr>
							</form>
						</table>

					</td>
				</flow:ifEnabled>
				<%-- 
				  ***
				  *	End: Quick order form
				  ***
				--%>
				
				<%-- 
				  ***
				  *	Start: 'Live help' link
				  ***
				--%>
				<flow:ifEnabled feature="customerCare">
				<c:if test="${liveHelp eq true}">
					<td valign="top" id="WC_CachedHeaderDisplay_TableCell_29a"><img src="<c:out value="${jspStoreImgDir}${vfileColor}" />menu_line.gif" alt="" width="1" height="28" border="0"></td>
					<td class="skutext" valign="top" id="WC_CachedHeaderDisplay_TableCell_29b">
						<fmt:message key="LiveHelp" bundle="${storeText}" />
					</td>
					<td class="skubut" valign="top" id="WC_CachedHeaderDisplay_TableCell_29c">
					   <a href="javascript:if((parent.sametime != null)) top.interact();" class="button" id="WC_CachedHeaderDisplay_Link_5">
					   		<fmt:message key="Sidebar_Go2" bundle="${storeText}" />
					   </a>
				    </td>
				</c:if>
				</flow:ifEnabled>
				<%-- 
				  ***
				  *	End: 'Live help' link
				  ***
				--%>
				
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td class="greyline2" id="WC_CachedHeaderDisplay_TableCell_30">&nbsp;</td>
	</tr>
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
		<td class="bannertile" id="WC_CachedHeaderDisplay_TableCell_31">
			<table id="WC_CachedHeaderDisplay_Table_2_1" cellpadding="0" cellspacing="0" border="0" width="100%">
				<tr>
					<td id="WC_CachedHeaderDisplay_TableCell_32_1" background="<c:out value="${bannerImg}" />" ><img alt="" src="<c:out value="${jspStoreImgDir}" />images/trans.gif" height="53" width="1"/></td>
				</tr>
			</table>
		</td>
		<%-- 
		  ***
		  *	End: Banner
		  ***
		--%>
	</tr>
	<tr>
		<td class="gtile" id="WC_CachedHeaderDisplay_TableCell_32"><img src="<c:out value="${jspStoreImgDir}${vfileColor}" />graphic_line.gif" alt="" width="50" height="9" border="0"></td>
	</tr>
	<tr>
		<td class="greyline3" id="WC_CachedHeaderDisplay_TableCell_33">&nbsp;</td>
	</tr>
</table>

<flow:ifEnabled feature="customerCare">
	<jsp:include page="../../CustomerCareHeaderSetup.jsp" flush="true" />
</flow:ifEnabled>

<!-- END CachedHeaderDisplay.jsp -->
