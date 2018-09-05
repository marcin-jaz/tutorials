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
  * This JSP page displays the Sidebar in all content pages that include the Layout Container JSP fragments.
  * The following elements are displayed:
  *  - Search form with 'Search text' field and 'Submit' button.
  *  - Quick order form with 'SKU' field and 'Submit' button.
  *  - Menu
  *  - 'Live help' link.
  *****
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../JSTLEnvironmentSetup.jspf"%>

<!-- BEGIN CachedSidebarDisplay.jsp -->
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

				<table cellspacing="0" width="160" class="bgcolor" height="99%" border="0" cellpadding="0" id="WC_CachedSidebarDisplay_Table_1">
					<tbody><tr>
						<td class="navline" id="WC_CachedSidebarDisplay_TableCell_1"><img src="<c:out value="${jspStoreImgDir}${vfileColor}" />trans.gif" alt="" width="2" height="1" border="0"/></td>
					</tr>
					<%-- 
					  ***
					  *	Start: Search form
					  ***
					--%>
					<flow:ifEnabled feature="catalogSearch">
					<tr>
						<td id="WC_CachedSidebarDisplay_TableCell_2">
							<table cellspacing="0" width="160" border="0" cellpadding="0" class="navborder" id="WC_CachedSidebarDisplay_Table_2">
								<tbody><tr>
									<td class="navheader" colspan="2" id="WC_CachedSidebarDisplay_TableCell_3">
										<label for="WC_CachedSidebarDisplay_FormInput_searchTerm_In_CatalogSearchForm_1"><fmt:message key="Sidebar_CatalogSearch" bundle="${storeText}" /></label>
									</td>
								</tr>
								<tr>
									<td class="thinline" colspan="2" id="WC_CachedSidebarDisplay_TableCell_4"><img src="<c:out value="${jspStoreImgDir}${vfileColor}" />trans.gif" alt="" height="1"/></td>
								</tr>
								<tr>
									<td class="navcontent" id="WC_CachedSidebarDisplay_TableCell_5">
										<form name="CatalogSearchForm" action="CatalogSearchResultView" method="post" id="CatalogSearchForm">
											<input type="hidden" name="storeId" value="<c:out value="${storeId}"/>" id="WC_CachedSidebarDisplay_FormInput_storeId_In_CatalogSearchForm_1"/>
											<input type="hidden" name="langId" value="<c:out value="${langId}"/>" id="WC_CachedSidebarDisplay_FormInput_langId_In_CatalogSearchForm_1"/>
											<input type="hidden" name="catalogId" value="<c:out value="${catalogId}"/>" id="WC_CachedSidebarDisplay_FormInput_catalogId_In_CatalogSearchForm_1"/>
											<input type="hidden" name="pageSize" value="10" id="WC_CachedSidebarDisplay_FormInput_pageSize_In_CatalogSearchForm_1"/>
											<input type="hidden" name="beginIndex" value="0" id="WC_CachedSidebarDisplay_FormInput_beginIndex_In_CatalogSearchForm_1"/>
											<input type="hidden" name="sType" value="SimpleSearch" id="WC_CachedSidebarDisplay_FormInput_sType_In_CatalogSearchForm_1"/>
											<input type="hidden" name="searchTermScope" value="3" id="WC_CachedSidebarDisplay_FormInput_searchTermScope_In_CatalogSearchForm_1"/>
										<table cellspacing="1" border="0" cellpadding="1" id="WC_CachedSidebarDisplay_Table_3">
											<tbody>
											<tr>
												<td id="WC_CachedSidebarDisplay_TableCell_6"><input type="text" size="18" maxlength="254" name="searchTerm" id="WC_CachedSidebarDisplay_FormInput_searchTerm_In_CatalogSearchForm_1" class="nav"/></td>
											</tr>
											<tr>
												<td id="WC_CachedSidebarDisplay_TableCell_7"><a class="button" href="javascript:document.CatalogSearchForm.submit()" id="WC_CachedSidebarDisplay_Link_1"><fmt:message key="Sidebar_Go1" bundle="${storeText}" /></a></td>
											</tr>
											<tr>
												<td id="WC_CachedSidebarDisplay_TableCell_8">
													<c:url var="AdvancedSearchViewURL" value="AdvancedSearchView">
														<c:param name="langId" value="${langId}"/>
														<c:param name="storeId" value="${storeId}"/>
														<c:param name="catalogId" value="${catalogId}" />
													</c:url>
													<a href="<c:out value="${AdvancedSearchViewURL}" />" class="blacklink" id="WC_CachedSidebarDisplay_Link_2">
														<fmt:message key="Sidebar_Link1" bundle="${storeText}" />
													</a>
												</td>
											</tr>
										</tbody></table>
										</form>
									</td>
								</tr>
							</tbody></table>
						</td>
					</tr>
					</flow:ifEnabled>
					<%-- 
					  ***
					  *	End: Search form
					  ***
					--%>
					
					<%-- 
					  ***
					  *	Start: Quick order form
					  ***
					--%>
					<flow:ifEnabled feature="QuickOrder">
					<tr>
						<td class="navline" id="WC_CachedSidebarDisplay_TableCell_9"><img src="<c:out value="${jspStoreImgDir}${vfileColor}" />trans.gif" alt="" width="2" height="1" border="0"/></td>
					</tr>
					<tr>
						<td id="WC_CachedSidebarDisplay_TableCell_10">
							<table cellspacing="0" width="160" border="0" cellpadding="0" class="navborder" id="WC_CachedSidebarDisplay_Table_4">
								<tbody><tr>
									<td class="navheader" colspan="2" id="WC_CachedSidebarDisplay_TableCell_11">	
										<label for="WC_CachedSidebarDisplay_FormInput_partNumber_In_QuickOrderForm_1"><fmt:message key="Sidebar_QuickOrder" bundle="${storeText}" /></label>
									</td>
								</tr>
								<tr>
									<td class="thinline" colspan="2" id="WC_CachedSidebarDisplay_TableCell_12"><img src="<c:out value="${jspStoreImgDir}${vfileColor}" />trans.gif" alt="" height="1"/></td>
								</tr>
								<tr>
									<td class="navcontent" id="WC_CachedSidebarDisplay_TableCell_13">
									<form name="QuickOrderForm" action="OrderItemAdd" method="post" id="QuickOrderForm">
										<input type="hidden" name="catalogId" value="<c:out value="${catalogId}" />" id="WC_CachedSidebarDisplay_FormInput_catalogId_In_QuickOrderForm_1"/>
								  		<input type="hidden" name="langId" value="<c:out value="${langId}" />" id="WC_CachedSidebarDisplay_FormInput_langId_In_QuickOrderForm_1"/>
								  		<input type="hidden" name="quantity" value="1" id="WC_CachedSidebarDisplay_FormInput_quantity_In_QuickOrderForm_1"/>
								  		<input type="hidden" name="orderId" value="." id="WC_CachedSidebarDisplay_FormInput_orderId_In_QuickOrderForm_1"/>
								  		<input type="hidden" name="URL" value="SetPendingOrder?URL=OrderCalculate?URL=OrderItemDisplay?partNumber*=&quantity*=&updatePrices=1&calculationUsageId=-1" id="WC_CachedSidebarDisplay_FormInput_URL_In_QuickOrderForm_1"/>
								  		<input type="hidden" name="outOrderName" value="orderId" id="WC_CachedSidebarDisplay_FormInput_outOrderName_In_QuickOrderForm_1"/>
								  		<input type="hidden" name="errorViewName" value="QuickOrderView" id="WC_CachedSidebarDisplay_FormInput_errorViewName_In_QuickOrderForm_1"/>
		
										<table cellspacing="1" border="0" cellpadding="1" id="WC_CachedSidebarDisplay_Table_5">
											<tbody><tr>
												<td class="navblacktxt" id="WC_CachedSidebarDisplay_TableCell_14">	<fmt:message key="Sidebar_EnterSKU" bundle="${storeText}" /></td>
											</tr>
											<tr>
									  			<td id="WC_CachedSidebarDisplay_TableCell_15"><input type="text" name="partNumber" value="" size="18" class="nav" id="WC_CachedSidebarDisplay_FormInput_partNumber_In_QuickOrderForm_1"/></td>
											</tr>
											<tr>
												<td id="WC_CachedSidebarDisplay_TableCell_16"><a class="button" href="javascript:document.QuickOrderForm.submit();" id="WC_CachedSidebarDisplay_Link_3"><fmt:message key="Sidebar_Go2" bundle="${storeText}" /></a></td>
											</tr>
											<tr>
												<td id="WC_CachedSidebarDisplay_TableCell_17">
													<c:url var="QuickOrderViewURL" value="QuickOrderView">
														<c:param name="status" value="i"/>
														<c:param name="langId" value="${langId}"/>
														<c:param name="storeId" value="${storeId}"/>
														<c:param name="catalogId" value="${catalogId}"/>
													</c:url>
													<a href="<c:out value="${QuickOrderViewURL}" />" class="blacklink" id="WC_CachedSidebarDisplay_Link_4">
														<fmt:message key="Sidebar_Link2" bundle="${storeText}" />
													</a>
												</td>
											</tr>
										</tbody></table>
									</form>
									</td>
								</tr>
							</tbody></table>
						</td>
					</tr>
					</flow:ifEnabled>
					<%-- 
					  ***
					  *	End: Quick order form
					  ***
					--%>
					
					<tr>
						<td id="WC_CachedSidebarDisplay_TableCell_18">
							<%-- 
							  ***
							  *	Start: Menu
							  ***
							--%>
							<table cellspacing="0" width="160" border="0" cellpadding="0" id="WC_CachedSidebarDisplay_Table_6">
								<tbody><tr>
									<td class="navline" id="WC_CachedSidebarDisplay_TableCell_19"><img src="<c:out value="${jspStoreImgDir}${vfileColor}" />trans.gif" alt="" width="2" height="1" border="0"/></td>
								</tr>
								<tr>
									<td id="WC_CachedSidebarDisplay_TableCell_20">
										<table cellspacing="0" width="100%" border="0" cellpadding="0" class="navborder" id="WC_CachedSidebarDisplay_Table_7">
											<tbody><tr>
												<td class="colorcap" id="WC_CachedSidebarDisplay_TableCell_21"><img src="<c:out value="${jspStoreImgDir}${vfileColor}" />trans.gif" alt="" width="8" height="16" border="0"/></td>
												<td class="thinline" id="WC_CachedSidebarDisplay_TableCell_22"><img src="<c:out value="${jspStoreImgDir}${vfileColor}" />trans.gif" alt="" width="1"/></td>
												<td id="WC_CachedSidebarDisplay_TableCell_23">
													<c:url var="TopCategoriesDisplayURL" value="TopCategoriesDisplay">
														<c:param name="langId" value="${langId}" />
														<c:param name="storeId" value="${storeId}" />
														<c:param name="catalogId" value="${catalogId}" />
													</c:url>
													<a href="<c:out value="${TopCategoriesDisplayURL}" />" class="navbutton" id="WC_CachedSidebarDisplay_Link_5">
														<fmt:message key="Header_Home" bundle="${storeText}" />
													</a>
												</td>
											</tr>
										</tbody></table>
									</td>
								</tr>
								
								<flow:ifEnabled feature="auctions">
								<tr>
									<td class="navline" id="WC_CachedSidebarDisplay_TableCell_24b"><img src="<c:out value="${jspStoreImgDir}${vfileColor}" />trans.gif" alt="" width="2" height="1" border="0"/></td>
								</tr>
								<tr>
									<td id="WC_CachedSidebarDisplay_TableCell_25b">
										<table cellspacing="0" width="100%" border="0" cellpadding="0" class="navborder" id="WC_CachedSidebarDisplay_Table_8b">
											<tbody><tr>
												<td class="colorcap" id="WC_CachedSidebarDisplay_TableCell_26b"><img src="<c:out value="${jspStoreImgDir}${vfileColor}" />trans.gif" alt="" width="8" height="16" border="0"/></td>
												<td class="thinline" id="WC_CachedSidebarDisplay_TableCell_27b"><img src="<c:out value="${jspStoreImgDir}${vfileColor}" />trans.gif" alt="" width="1"/></td>
												<td id="WC_CachedSidebarDisplay_TableCell_28">
													<c:url var="AuctionHomeViewURL" value="AuctionHomeView">
														<c:param name="langId" value="${langId}"/>
														<c:param name="storeId" value="${storeId}"/>
														<c:param name="catalogId" value="${catalogId}"/>
													</c:url>
													<a href="<c:out value="${AuctionHomeViewURL}" />" class="navbutton" id="WC_CachedSidebarDisplay_Link_6b">
														<fmt:message key="Sidebar_Auctions" bundle="${storeText}" />
													</a>
												</td>
											</tr>
										</tbody></table>
									</td>
								</tr>
								</flow:ifEnabled>
								
								<tr>
									<td class="navline" id="WC_CachedSidebarDisplay_TableCell_29"><img src="<c:out value="${jspStoreImgDir}${vfileColor}" />trans.gif" alt="" width="2" height="1" border="0"/></td>
								</tr>
								<tr>
									<td id="WC_CachedSidebarDisplay_TableCell_30">
										<table cellspacing="0" width="100%" border="0" cellpadding="0" class="navborder" id="WC_CachedSidebarDisplay_Table_9">
											<tbody><tr>
												<td class="colorcap" id="WC_CachedSidebarDisplay_TableCell_31"><img src="<c:out value="${jspStoreImgDir}${vfileColor}" />trans.gif" alt="" width="8" height="16" border="0"/></td>
												<td class="thinline" id="WC_CachedSidebarDisplay_TableCell_32"><img src="<c:out value="${jspStoreImgDir}${vfileColor}" />trans.gif" alt="" width="1"/></td>
												<td id="WC_CachedSidebarDisplay_TableCell_33">
													<c:url var="AccountViewURL" value="UserAccountView">
														<c:param name="langId" value="${langId}" />
														<c:param name="storeId" value="${storeId}" />
														<c:param name="catalogId" value="${catalogId}" />
													</c:url>
													<a href="<c:out value="${AccountViewURL}" />" class="navbutton" id="WC_CachedSidebarDisplay_Link_7">
														<fmt:message key="Header_Account" bundle="${storeText}" />
													</a>
												</td>
											</tr>
										</tbody></table>
									</td>
								</tr>
								<flow:ifEnabled feature="RequisitionList">
								<tr>
									<td class="navline" id="WC_CachedSidebarDisplay_TableCell_39"><img src="<c:out value="${jspStoreImgDir}${vfileColor}" />trans.gif" alt="" width="2" height="1" border="0"/></td>
								</tr>
								<tr>
									<td id="WC_CachedSidebarDisplay_TableCell_40">
										<table cellspacing="0" width="100%" border="0" cellpadding="0" class="navborder" id="WC_CachedSidebarDisplay_Table_11">
											<tbody><tr>
												<td class="colorcap" id="WC_CachedSidebarDisplay_TableCell_41"><img src="<c:out value="${jspStoreImgDir}${vfileColor}" />trans.gif" alt="" width="8" height="16" border="0"/></td>
												<td class="thinline" id="WC_CachedSidebarDisplay_TableCell_42"><img src="<c:out value="${jspStoreImgDir}${vfileColor}" />trans.gif" alt="" width="1"/></td>
												<td id="WC_CachedSidebarDisplay_TableCell_43">
													<c:url var="RequisitionListDisplayURL" value="RequisitionListDisplayView">
														<c:param name="langId" value="${langId}" />
														<c:param name="storeId" value="${storeId}" />
														<c:param name="catalogId" value="${catalogId}" />
													</c:url>
													<a href="<c:out value="${RequisitionListDisplayURL}" />" class="navbutton" id="WC_CachedSidebarDisplay_Link_9">
														<fmt:message key="Header_RequisitionList" bundle="${storeText}" />
													</a>
												</td>
											</tr>
										</tbody></table>
									</td>
								</tr>
								</flow:ifEnabled>
								<flow:ifEnabled feature="RFQ">
									<c:if test="${rfqLinkDisplayed eq true}">
										<tr>
											<td class="navline" id="WC_CachedSidebarDisplay_TableCell_44"><img src="<c:out value="${jspStoreImgDir}${vfileColor}" />trans.gif" alt="" width="2" height="1" border="0"/></td>
										</tr>
										<tr>
											<td id="WC_CachedSidebarDisplay_TableCell_45">
												<table cellspacing="0" width="100%" border="0" cellpadding="0" class="navborder" id="WC_CachedSidebarDisplay_Table_12">
													<tbody><tr>
														<td class="colorcap" id="WC_CachedSidebarDisplay_TableCell_46"><img src="<c:out value="${jspStoreImgDir}${vfileColor}" />trans.gif" alt="" width="8" height="16" border="0"/></td>
														<td class="thinline" id="WC_CachedSidebarDisplay_TableCell_47"><img src="<c:out value="${jspStoreImgDir}${vfileColor}" />trans.gif" alt="" width="1"/></td>
														<td id="WC_CachedSidebarDisplay_TableCell_48">
															<c:url var="RFQListDisplayURL" value="RFQListDisplay">
																<c:param name="langId" value="${langId}" />
																<c:param name="storeId" value="${storeId}" />
																<c:param name="catalogId" value="${catalogId}" />
															</c:url>
															<a href="<c:out value="${RFQListDisplayURL}" />" class="navbutton" id="WC_CachedSidebarDisplay_Link_10">
																<fmt:message key="RFQ_List" bundle="${storeText}" />
															</a>
														</td>
													</tr>
												</tbody></table>
											</td>
										</tr>
									</c:if>
								</flow:ifEnabled>								
								<tr>
									<td class="navline" id="WC_CachedSidebarDisplay_TableCell_49"><img src="<c:out value="${jspStoreImgDir}${vfileColor}" />trans.gif" alt="" width="2" height="1" border="0"/></td>
								</tr>
								<tr>
									<td id="WC_CachedSidebarDisplay_TableCell_50">
										<table cellspacing="0" width="100%" border="0" cellpadding="0" class="navborder" id="WC_CachedSidebarDisplay_Table_13">
											<tbody><tr>
												<td class="colorcap" id="WC_CachedSidebarDisplay_TableCell_51"><img src="<c:out value="${jspStoreImgDir}${vfileColor}" />trans.gif" alt="" width="8" height="16" border="0"/></td>
												<td class="thinline" id="WC_CachedSidebarDisplay_TableCell_52"><img src="<c:out value="${jspStoreImgDir}${vfileColor}" />trans.gif" alt="" width="1"/></td>
												<td id="WC_CachedSidebarDisplay_TableCell_53">
													<c:url var="OrderItemDisplayURL" value="OrderItemDisplayView">
														<c:param name="langId" value="${langId}" />
														<c:param name="storeId" value="${storeId}" />
														<c:param name="catalogId" value="${catalogId}" />
														<c:param name="orderId" value="." />
													</c:url>
													<a href="<c:out value="${OrderItemDisplayURL}" />" class="navbutton" id="WC_CachedSidebarDisplay_Link_11">
														<fmt:message key="Header_CurrentOrder" bundle="${storeText}" />
													</a>
												</td>
											</tr>
										</tbody></table>
									</td>
								</tr>
								
								<flow:ifEnabled feature="MultipleActiveOrders">
								<tr>
									<td class="navline" id="WC_CachedSidebarDisplay_TableCell_54a"><img src="<c:out value="${jspStoreImgDir}${vfileColor}" />trans.gif" alt="" width="2" height="1" border="0"/></td>
								</tr>
								<tr>
									<td id="WC_CachedSidebarDisplay_TableCell_55a">
										<table cellspacing="0" width="100%" border="0" cellpadding="0" class="navborder" id="WC_CachedSidebarDisplay_Table_14">
											<tbody><tr>
												<td class="colorcap" id="WC_CachedSidebarDisplay_TableCell_56a"><img src="<c:out value="${jspStoreImgDir}${vfileColor}" />trans.gif" alt="" width="8" height="16" border="0"/></td>
												<td class="thinline" id="WC_CachedSidebarDisplay_TableCell_57a"><img src="<c:out value="${jspStoreImgDir}${vfileColor}" />trans.gif" alt="" width="1"/></td>
												<td id="WC_CachedSidebarDisplay_TableCell_58a">
													<c:url var="ListOrdersDisplayURL" value="ListOrdersDisplay">
														<c:param name="langId" value="${langId}" />
														<c:param name="storeId" value="${storeId}" />
														<c:param name="catalogId" value="${catalogId}" />
													</c:url>
													<a href="<c:out value="${ListOrdersDisplayURL}" />" class="navbutton" id="WC_CachedSidebarDisplay_Link_12a">
														<fmt:message key="Sidebar_ListOrders" bundle="${storeText}" />
													</a>
												</td>
											</tr>
										</tbody></table>
									</td>
								</tr>
								</flow:ifEnabled>
								
								<flow:ifEnabled feature="trackOrderStatus">
								<tr>
									<td class="navline" id="WC_CachedSidebarDisplay_TableCell_54"><img src="<c:out value="${jspStoreImgDir}${vfileColor}" />trans.gif" alt="" width="2" height="1" border="0"/></td>
								</tr>
								<tr>
									<td id="WC_CachedSidebarDisplay_TableCell_55">
										<table cellspacing="0" width="100%" border="0" cellpadding="0" class="navborder" id="WC_CachedSidebarDisplay_Table_14">
											<tbody><tr>
												<td class="colorcap" id="WC_CachedSidebarDisplay_TableCell_56"><img src="<c:out value="${jspStoreImgDir}${vfileColor}" />trans.gif" alt="" width="8" height="16" border="0"/></td>
												<td class="thinline" id="WC_CachedSidebarDisplay_TableCell_57"><img src="<c:out value="${jspStoreImgDir}${vfileColor}" />trans.gif" alt="" width="1"/></td>
												<td id="WC_CachedSidebarDisplay_TableCell_58">
													<c:url var="TrackOrderStatusURL" value="TrackOrderStatus">
														<c:param name="langId" value="${langId}" />
														<c:param name="storeId" value="${storeId}" />
														<c:param name="catalogId" value="${catalogId}" />
													</c:url>
													<a href="<c:out value="${TrackOrderStatusURL}" />" class="navbutton" id="WC_CachedSidebarDisplay_Link_12">
														<fmt:message key="Header_OrderHistory" bundle="${storeText}" />
													</a>
												</td>
											</tr>
										</tbody></table>
									</td>
								</tr>
								</flow:ifEnabled>
								
								<c:if test="${(!empty displayApproverLink) && (displayApproverLink=='true')}">
								<script language="JavaScript">
									checkBrowser(); //calls checkBrowser function for ApprovalToolLink() below		  
								</script>
								<tr>
									<td class="navline" id="WC_CachedSidebarDisplay_TableCell_54b"><img src="<c:out value="${jspStoreImgDir}${vfileColor}" />trans.gif" alt="" width="2" height="1" border="0"/></td>
								</tr>
								<tr>
									<td id="WC_CachedSidebarDisplay_TableCell_55b">
										<table cellspacing="0" width="100%" border="0" cellpadding="0" class="navborder" id="WC_CachedSidebarDisplay_Table_14">
											<tbody><tr>
												<td class="colorcap" id="WC_CachedSidebarDisplay_TableCell_56b"><img src="<c:out value="${jspStoreImgDir}${vfileColor}" />trans.gif" alt="" width="8" height="16" border="0"/></td>
												<td class="thinline" id="WC_CachedSidebarDisplay_TableCell_57b"><img src="<c:out value="${jspStoreImgDir}${vfileColor}" />trans.gif" alt="" width="1"/></td>
												<td id="WC_CachedSidebarDisplay_TableCell_58b">												
													<a href="javascript:ApprovalToolLink();" class="navbutton" id="WC_CachedSidebarDisplay_Link_12b">
														<fmt:message key="Header_Approvals" bundle="${storeText}" />
													</a>
												</td>
											</tr>
										</tbody></table>
									</td>
								</tr>
								</c:if>
								
								<tr>
									<td class="navline" id="WC_CachedSidebarDisplay_TableCell_67"><img src="<c:out value="${jspStoreImgDir}${vfileColor}" />trans.gif" alt="" width="2" height="1" border="0"/></td>
								</tr>
								<tr>
									<td id="WC_CachedSidebarDisplay_TableCell_68">
										<table cellspacing="0" width="100%" border="0" cellpadding="0" class="navborder" id="WC_CachedSidebarDisplay_Table_14">
											<tbody><tr>
												<td class="colorcap" id="WC_CachedSidebarDisplay_TableCell_69"><img src="<c:out value="${jspStoreImgDir}${vfileColor}" />trans.gif" alt="" width="8" height="16" border="0"/></td>
												<td class="thinline" id="WC_CachedSidebarDisplay_TableCell_70"><img src="<c:out value="${jspStoreImgDir}${vfileColor}" />trans.gif" alt="" width="1"/></td>
												<td id="WC_CachedSidebarDisplay_TableCell_71">
													<c:url var="HelpViewURL" value="HelpView">
														<c:param name="langId" value="${langId}" />
														<c:param name="storeId" value="${storeId}" />
														<c:param name="catalogId" value="${catalogId}" />
													</c:url>	
													<a href="<c:out value="${HelpViewURL}" />" class="navbutton" id="WC_CachedSidebarDisplay_Link_14">
														<fmt:message key="HELP_TITLE" bundle="${storeText}" />
													</a>
												</td>
											</tr>
										</tbody></table>
									</td>
								</tr>	
								<%-- 
								  ***
								  *	Start: 'Live help' link
								  ***
								--%>					
								<flow:ifEnabled feature="customerCare">
									<c:if test="${liveHelp eq true}">		
										<tr>
											<td class="navline" id="WC_CachedSidebarDisplay_TableCell_59"><img src="<c:out value="${jspStoreImgDir}${vfileColor}" />trans.gif" alt="" width="2" height="1" border="0"/></td>
										</tr>
										<tr>
											<td id="WC_CachedSidebarDisplay_TableCell_60">
												<table cellspacing="0" width="100%" border="0" cellpadding="0" class="navborder" id="WC_CachedSidebarDisplay_Table_15">
													<tbody><tr>
														<td class="colorcap" id="WC_CachedSidebarDisplay_TableCell_61"><img src="<c:out value="${jspStoreImgDir}${vfileColor}" />trans.gif" alt="" width="8" height="16" border="0"/></td>
														<td class="thinline" id="WC_CachedSidebarDisplay_TableCell_62"><img src="<c:out value="${jspStoreImgDir}${vfileColor}" />trans.gif" alt="" width="1"/></td>
														<td id="WC_CachedSidebarDisplay_TableCell_63"><a href="javascript:if((parent.sametime != null)) top.interact();" class="navbutton" id="WC_CachedSidebarDisplay_Link_13"><fmt:message key="LiveHelp" bundle="${storeText}" /></a></td>
													</tr>
												</tbody></table>
											</td>
										</tr>
									</c:if>
								</flow:ifEnabled>
								<%-- 
								  ***
								  *	End: 'Live help' link
								  ***
								--%>
								<tr>
									<td class="navline" id="WC_CachedSidebarDisplay_TableCell_64"><img src="<c:out value="${jspStoreImgDir}${vfileColor}" />trans.gif" alt="" width="2" height="2" border="0"/></td>
								</tr>
								<tr>
									<td bgcolor="blue" valign="top" id="WC_CachedSidebarDisplay_TableCell_65"><img src="<c:out value="${jspStoreImgDir}${vfileColor}" />nav_img.gif" alt="" width="160" height="206" border="0"/></td>
								</tr>
							</tbody></table>
							<%-- 
							  ***
							  *	End: Menu
							  ***
							--%>
						</td>
					</tr>
	<tr><td height="99%" id="WC_CachedSidebarDisplay_TableCell_66">&nbsp;</td></tr>
	</tbody></table>
	
<!-- END CachedSidebarDisplay.jsp -->
