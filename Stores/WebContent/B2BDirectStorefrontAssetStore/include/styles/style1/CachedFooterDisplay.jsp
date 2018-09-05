<%--
/*
 *-------------------------------------------------------------------
 * Licensed Materials - Property of IBM
 *
 * WebSphere Commerce
 *
 * (c) Copyright International Business Machines Corporation. 2005
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
  * This JSP page displays the Footer in all content pages that include the Layout Container JSP fragments.
  *****
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../JSTLEnvironmentSetup.jspf"%>
<c:url var="ApprovalToolLinkURL" value="${sdb.approvalToolLinkURL}">
</c:url>
<c:url var="BrowserVerErrorURL" value="https://${pageContext.request.serverName}${pageContext.request.contextPath}/servlet/BrowserVerErrorView">
</c:url>
<c:url var="RequisitionListDisplayURL" value="RequisitionListDisplayView">
	<c:param name="langId" value="${langId}" />
	<c:param name="storeId" value="${storeId}" />
	<c:param name="catalogId" value="${catalogId}" />
</c:url>
<c:url var="AuctionHomeViewURL" value="AuctionHomeView">
	<c:param name="langId" value="${langId}"/>
	<c:param name="storeId" value="${storeId}"/>
	<c:param name="catalogId" value="${catalogId}"/>
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

<!-- BEGIN CachedFooterDisplay.jsp -->
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

<table cellpadding="0" cellspacing="0" border="0" width="100%" height="100%" id="WC_CachedFooterDisplay_Table_1">
	<tr>
		<td class="f_back" align="center" valign="top" id="WC_CachedFooterDisplay_TableCell_1">
			<table cellpadding="0" cellspacing="0" border="0" width="100%" id="WC_CachedFooterDisplay_Table_2">
				<tr>
					<td valign="top" id="WC_CachedFooterDisplay_TableCell_2">
						<table cellpadding="0" cellspacing="0" border="0">
							<tr>
								<td class="f_padding">
									<table cellpadding="0" cellspacing="0" border="0">
										<tr>
											<td class="f_title"><fmt:message key="Footer1_LinksHeading" bundle="${storeText}" /></td>
										</tr>
										<tr>
											<td>
											<flow:ifEnabled feature="RequisitionList">
					                					<a href="<c:out value="${RequisitionListDisplayURL}"/>" id="WC_CachedFooterDisplay_Link_1"><fmt:message key="Footer1_RequisitionList" bundle="${storeText}" /></a><br />
			        							</flow:ifEnabled>
											</td>
										</tr>
										<tr>
											<td>
											<flow:ifEnabled feature="RFQ">
											<c:if test="${rfqLinkDisplayed eq true}">
												<c:url var="RFQListDisplayURL" value="RFQListDisplay">
													<c:param name="langId" value="${langId}" />
													<c:param name="storeId" value="${storeId}" />
													<c:param name="catalogId" value="${catalogId}" />
												</c:url>
												<a href="<c:out value="${RFQListDisplayURL}" />" id="WC_CachedFooterDisplay_Link_2">
													<fmt:message key="Footer1_RfqList" bundle="${storeText}" />
												</a><br />
											</c:if>
											</flow:ifEnabled>
											</td>
										</tr>
										<tr>
											<td>
											<c:if test="${(!empty displayApproverLink) && (displayApproverLink=='true')}">
												<script language="JavaScript">
													checkBrowser(); //calls checkBrowser function for ApprovalToolLink() below		  
												</script>
												<a href="javascript:ApprovalToolLink();" id="WC_CachedFooterDisplay_Link_3"><fmt:message key="Footer1_Approvals" bundle="${storeText}"/></a><br />
											</c:if>
											</td>
										</tr>
									</table>
								</td>
								<td class="f_padding">
									<table cellpadding="0" cellspacing="0" border="0">
										<tr>
											<td class="f_title"><fmt:message key="Footer1_OrderHeading" bundle="${storeText}" /></td>
										</tr>
										<tr>
											<td>
											<flow:ifEnabled feature="trackOrderStatus">
					                					<a href="<c:out value="${TrackOrderStatusURL}"/>" id="WC_CachedFooterDisplay_Link_4"><fmt:message key="Footer1_OrderHistory" bundle="${storeText}" /></a><br />
			        							</flow:ifEnabled>
											</td>
										</tr>
										<tr>
											<td>
											<flow:ifEnabled feature="MultipleActiveOrders">
												<a href="<c:out value="${ListOrdersDisplayURL}" />" id="WC_CachedFooterDisplay_Link_5"><fmt:message key="Footer1_ListOrders" bundle="${storeText}" /></a><br />
											</flow:ifEnabled>
											</td>
										</tr>
										<tr>
											<td>
											<flow:ifEnabled feature="auctions">
												<a href="<c:out value="${AuctionHomeViewURL}" />" id="WC_CachedFooterDisplay_Link_6"><fmt:message key="Footer1_Auctions" bundle="${storeText}"/></a><br />
											</flow:ifEnabled>
											</td>
										</tr>
									</table>
								</td>
								<td class="f_padding">
									<table cellpadding="0" cellspacing="0" border="0">
										<tr>
											<td class="f_title"><fmt:message key="Footer1_CustomerServiceHeading" bundle="${storeText}" /></td>
										</tr>
										<tr>
											<td>
												<a href="<c:out value="${HelpViewURL}"/>" id="WC_CachedFooterDisplay_Link_7"><fmt:message key="Footer1_Help" bundle="${storeText}" /></a>
											</td>
										</tr>
										<tr>
											<td>
											<flow:ifEnabled feature="customerCare">
												<c:if test="${liveHelp eq true}">
													<a href="javascript:if((parent.sametime != null)) top.interact();" id="WC_CachedFooterDisplay_Link_9">
										   				<fmt:message key="LiveHelp" bundle="${storeText}" />
										   			</a><br />
												</c:if>
											</flow:ifEnabled>
											</td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
					</td>
					<td align="right">
						<flow:ifEnabled feature="CustomBanner">
							<img width="329" height="148" alt="" src="<c:out value="${storeImgDir}${vfileBanner}" />" border="0"/>
						</flow:ifEnabled>	
						<flow:ifDisabled feature="CustomBanner">
			        			<img width="329" height="148" alt="" src="<c:out value="${jspStoreImgDir}${vfileSelectedBanner}" />" border="0"/>
						</flow:ifDisabled>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<!-- END CachedFooterDisplay.jsp -->
