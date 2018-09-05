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
  *  - Menu
  *  - 'Live help' link.
  *  - Sample Flash animation.
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
	<table class="gray" cellpadding="0" cellspacing="0" border="0" height="100%" width="170" id="WC_CachedSidebarDisplay_Table_1">
	<tr>
		<td valign="top" class="nav_tile" id="WC_CachedSidebarDisplay_TableCell_1">
			<table cellpadding="0" cellspacing="0" border="0" width="170" id="WC_CachedSidebarDisplay_Table_2">
				<tr>
					<td class="nav_button" id="WC_CachedSidebarDisplay_TableCell_2"><img src="<c:out value="${jspStoreImgDir}${vfileColor}" />l_nav_top.gif" alt="" width="170" height="25" border="0"></td>
				</tr>
				<tr>
					<td class="ban_blueline" id="WC_CachedSidebarDisplay_TableCell_5">&nbsp;</td>
				</tr>
				
				<%-- 
				  ***
				  *	Start: Menu
				  ***
				--%>
			<flow:ifEnabled feature="auctions">
				<tr>
					<td height="18" class="nav_button" id="WC_CachedSidebarDisplay_TableCell_8">
										<c:url var="AuctionHomeViewURL" value="AuctionHomeView">
											<c:param name="langId" value="${langId}"/>
											<c:param name="storeId" value="${storeId}"/>
											<c:param name="catalogId" value="${catalogId}"/>
										</c:url>
										<a href="<c:out value="${AuctionHomeViewURL}" />" class="nav_button" id="WC_CachedSidebarDisplay_Link_4a">
											<fmt:message key="Sidebar_Auctions" bundle="${storeText}" />
										</a></td>
				</tr>
				<tr>
					<td class="ban_blueline" id="WC_CachedSidebarDisplay_TableCell_9">&nbsp;</td>
				</tr>
			</flow:ifEnabled>
			<flow:ifEnabled feature="catalogSearch">
				<tr>
					<td height="18" class="nav_button" id="WC_CachedSidebarDisplay_TableCell_8">
										<c:url var="AdvancedSearchViewURL" value="AdvancedSearchView">
											<c:param name="langId" value="${langId}"/>
											<c:param name="storeId" value="${storeId}"/>
											<c:param name="catalogId" value="${catalogId}"/>
										</c:url>
										<a href="<c:out value="${AdvancedSearchViewURL}" />" class="nav_button" id="WC_CachedSidebarDisplay_Link_4b">
											<fmt:message key="Sidebar_Link1" bundle="${storeText}" />
										</a></td>
				</tr>
				<tr>
					<td class="ban_blueline" id="WC_CachedSidebarDisplay_TableCell_9">&nbsp;</td>
				</tr>
			</flow:ifEnabled>
				<tr>
					<td height="18" class="nav_button" id="WC_CachedSidebarDisplay_TableCell_10">
										<c:url var="AccountViewURL" value="UserAccountView">
											<c:param name="langId" value="${langId}" />
											<c:param name="storeId" value="${storeId}" />
											<c:param name="catalogId" value="${catalogId}" />
										</c:url>
										<a href="<c:out value="${AccountViewURL}" />" class="nav_button" id="WC_CachedSidebarDisplay_Link_5a">
											<fmt:message key="Header_Account" bundle="${storeText}" />
										</a></td>
				</tr>
				<tr>
					<td class="ban_blueline" id="WC_CachedSidebarDisplay_TableCell_11">&nbsp;</td>
				</tr>
			<flow:ifEnabled feature="RequisitionList">
				<tr>
					<td height="18" class="nav_button" id="WC_CachedSidebarDisplay_TableCell_14">
											<c:url var="RequisitionListDisplayURL" value="RequisitionListDisplayView">
												<c:param name="langId" value="${langId}" />
												<c:param name="storeId" value="${storeId}" />
												<c:param name="catalogId" value="${catalogId}" />
											</c:url>
											<a href="<c:out value="${RequisitionListDisplayURL}" />" class="nav_button" id="WC_CachedSidebarDisplay_Link_6">
												<fmt:message key="Header_RequisitionList" bundle="${storeText}" />
											</a></td>
				</tr>
				<tr>
					<td class="ban_blueline" id="WC_CachedSidebarDisplay_TableCell_15">&nbsp;</td>
				</tr>
			</flow:ifEnabled>
			<flow:ifEnabled feature="RFQ">
				<c:if test="${rfqLinkDisplayed eq true}">
				<tr>
					<td height="18" class="nav_button" id="WC_CachedSidebarDisplay_TableCell_16">
												<c:url var="RFQListDisplayURL" value="RFQListDisplay">
													<c:param name="langId" value="${langId}" />
													<c:param name="storeId" value="${storeId}" />
													<c:param name="catalogId" value="${catalogId}" />
												</c:url>
												<a href="<c:out value="${RFQListDisplayURL}" />" class="nav_button" id="WC_CachedSidebarDisplay_Link_7">
													<fmt:message key="RFQ_List" bundle="${storeText}" />
												</a></td>
				</tr>
				<tr>
					<td class="ban_blueline" id="WC_CachedSidebarDisplay_TableCell_17">&nbsp;</td>
				</tr>
				</c:if>
			</flow:ifEnabled>
			<flow:ifEnabled feature="MultipleActiveOrders">	
				<tr>	
   			
					<td height="18" class="nav_button" id="WC_CachedSidebarDisplay_TableCell_18">
										<c:url var="ListOrdersDisplayURL" value="ListOrdersDisplay">
											<c:param name="langId" value="${langId}" />
											<c:param name="storeId" value="${storeId}" />
											<c:param name="catalogId" value="${catalogId}" />
											
										</c:url>
										<a href="<c:out value="${ListOrdersDisplayURL}" />" class="nav_button" id="WC_CachedSidebarDisplay_Link_8a">
											<fmt:message key="Sidebar_ListOrders" bundle="${storeText}" />
										</a></td>
				</tr>
				<tr>
					<td class="ban_blueline" id="WC_CachedSidebarDisplay_TableCell_19">&nbsp;</td>
				</tr>
			</flow:ifEnabled>
				<tr>
					<td height="18" class="nav_button" id="WC_CachedSidebarDisplay_TableCell_18">
										<c:url var="OrderItemDisplayURL" value="OrderItemDisplayView">
											<c:param name="langId" value="${langId}" />
											<c:param name="storeId" value="${storeId}" />
											<c:param name="catalogId" value="${catalogId}" />
											<c:param name="orderId" value="." />											
										</c:url>
										<a href="<c:out value="${OrderItemDisplayURL}" />" class="nav_button" id="WC_CachedSidebarDisplay_Link_8b">
											<fmt:message key="Header_CurrentOrder" bundle="${storeText}" />
										</a></td>
				</tr>
				<tr>
					<td class="ban_blueline" id="WC_CachedSidebarDisplay_TableCell_19">&nbsp;</td>
				</tr>
			<flow:ifEnabled feature="trackOrderStatus">
				<tr>
					<td height="18" class="nav_button" id="WC_CachedSidebarDisplay_TableCell_20">
										<c:url var="TrackOrderStatusURL" value="TrackOrderStatus">
											<c:param name="langId" value="${langId}" />
											<c:param name="storeId" value="${storeId}" />
											<c:param name="catalogId" value="${catalogId}" />
										</c:url>	
										<a href="<c:out value="${TrackOrderStatusURL}" />" class="nav_button" id="WC_CachedSidebarDisplay_Link_9">
												<fmt:message key="Header_OrderHistory" bundle="${storeText}" />
										</a></td>
				</tr>
				<tr>
					<td class="ban_blueline" id="WC_CachedSidebarDisplay_TableCell_21">&nbsp;</td>
				</tr>
			</flow:ifEnabled>
				<%-- 
				  ***
				  *	End: Menu
				  ***
				--%>
			
			<%-- Uncomment the following to add a 'Logoff' link to the Sidebar
				<tr>
					<td height="18" class="nav_button" id="WC_CachedSidebarDisplay_TableCell_22">
										<c:url var="LogoffURL" value="Logoff">
											<c:param name="langId" value="${langId}" />
											<c:param name="storeId" value="${storeId}" />
											<c:param name="catalogId" value="${catalogId}" />
										</c:url>
										<a href="<c:out value="${LogoffURL}" />" class="nav_button" id="WC_CachedSidebarDisplay_Link_10">
											<fmt:message key="Header_Logoff" bundle="${storeText}" />
										</a></td>
				</tr>
				<tr>
					<td class="ban_blueline" id="WC_CachedSidebarDisplay_TableCell_23">&nbsp;</td>
				</tr>
			--%>
			<%-- 
			  ***
			  *	Start: 'Live help' link
			  ***
			--%>
			<flow:ifEnabled feature="customerCare">
			<c:if test="${liveHelp eq true}">
				<tr>
				   <td id="WC_CachedSidebarDisplay_TableCell_24" class="nav_button">
					   <a href="javascript:if((parent.sametime != null)) top.interact();" class="nav_button" id="WC_CachedSidebarDisplay_Link_11">
					   		<fmt:message key="LiveHelp" bundle="${storeText}" />
					   		<br/>
					   		<img alt="<fmt:message key="LiveHelp" bundle="${storeText}" />" src="<c:out value="${jspStoreImgDir}" />images/LiveHelp.gif" width="42" height="39" border="0"/>
					   </a>
					</td>
				</tr>
			    <tr>
					<td class="ban_blueline" id="WC_CachedSidebarDisplay_TableCell_23">&nbsp;</td>
				</tr>
			</c:if>
			</flow:ifEnabled>
			<%-- 
			  ***
			  *	End: 'Live help' link
			  ***
			--%>
			<c:if test="${(!empty displayApproverLink) && (displayApproverLink=='true')}">
				<script language="JavaScript">
					checkBrowser(); //calls checkBrowser function for ApprovalToolLink() below		  
				</script>
				<tr>
					<td height="18" class="nav_button" id="WC_CachedSidebarDisplay_TableCell_6">				
						<a href="javascript:ApprovalToolLink();" class="nav_button" id="WC_CachedSidebarDisplay_Link_2">
							<fmt:message key="Header3_Approvals" bundle="${storeText}" />
						</a>
					</td>
				</tr>
				<tr>
					<td class="ban_blueline" id="WC_CachedSidebarDisplay_TableCell_7">&nbsp;</td>
				</tr>
			</c:if>
				<tr>
				   <td id="WC_CachedSidebarDisplay_TableCell_24b" class="nav_button">
					   <c:url var="HelpViewURL" value="HelpView">
							<c:param name="langId" value="${langId}" />
							<c:param name="storeId" value="${storeId}" />
							<c:param name="catalogId" value="${catalogId}" />
						</c:url>	
						<a href="<c:out value="${HelpViewURL}" />" class="nav_button" id="WC_CachedSidebarDisplay_Link_11b">
							<fmt:message key="HELP_TITLE" bundle="${storeText}" />
						</a>
					</td>
				</tr>
			    <tr>
					<td class="ban_blueline" id="WC_CachedSidebarDisplay_TableCell_24c">&nbsp;</td>
				</tr>
				<tr>
					<%-- 
					  ***
					  *	Start: Sample Flash animation
					  * The Flash animation file source is obtained from the locale specific directory which matches the customer's locale.
					  ***
					--%>
					<td id="WC_CachedSidebarDisplay_TableCell_25"><img alt="<fmt:message key="Sidebar3_Flash_Demo" bundle="${storeText}" />" src="<c:out value="${jspStoreImgDir}" />images/trans.gif" width="1" height="1" border="0"/>
						<br />
						<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="https://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,0,0" name="bullets" width="168" height="107" id="bullets" >
							<param name="movie" value="<c:out value="${jspStoreImgDir}${locale}/images/" />bullets.swf"/> 
							<param name="quality" value="high"/>
							<param name="bgcolor" value="#FFFFFF"/>
							<embed src="<c:out value="${jspStoreImgDir}${locale}/images/" />bullets.swf" quality="high" bgcolor="#FFFFFF"  width="168" height="107" name="bullets" align="" type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer">
							</embed>
						</object>
					</td>
					<%-- 
					  ***
					  *	End: Sample Flash animation
					  ***
					--%>
				</tr>
			</table>
		</td>
	</tr>
	</table>
	
<!-- END CachedSidebarDisplay.jsp -->
