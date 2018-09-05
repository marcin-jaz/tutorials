<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2005, 2009 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
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
<%@ include file="../../JSTLCacheParametersSetup.jspf"%>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>  

<c:choose>
	<c:when test="${userType != 'G'}">
	
	<c:url var="ApprovalToolLinkURL" value="${sdb.approvalToolLinkURL}">
	</c:url>
	
	<flow:ifDisabled feature="AjaxMyAccountPage">
		<wcf:url var="TrackOrderStatusURL" value="NonAjaxTrackOrderStatus">
			<wcf:param name="storeId"   value="${param.storeId}"  />
			<wcf:param name="catalogId" value="${param.catalogId}"/>
			<wcf:param name="langId" value="${param.langId}" />
		</wcf:url>
		<flow:ifEnabled feature="EnableQuotes">
			<wcf:url var="TrackQuoteStatusURL" value="NonAjaxTrackOrderStatus">
				<wcf:param name="storeId"   value="${param.storeId}"  />
				<wcf:param name="catalogId" value="${param.catalogId}"/>
				<wcf:param name="langId" value="${param.langId}" />
				<wcf:param name="isQuote" value="true" />
			</wcf:url>
		</flow:ifEnabled>
	</flow:ifDisabled>
	<flow:ifEnabled feature="AjaxMyAccountPage">
		<wcf:url var="OrderStatusURL" value="AjaxLogonForm">
		  <wcf:param name="langId" value="${param.langId}" />
		  <wcf:param name="storeId" value="${param.storeId}" />
		  <wcf:param name="catalogId" value="${param.catalogId}" />
		  <wcf:param name="page" value="orderstatus" />
		</wcf:url>							
		<flow:ifEnabled feature="EnableQuotes">
			<wcf:url var="QuoteStatusURL" value="AjaxLogonForm">
			  <wcf:param name="langId" value="${param.langId}" />
			  <wcf:param name="storeId" value="${param.storeId}" />
			  <wcf:param name="catalogId" value="${param.catalogId}" />
			  <wcf:param name="page" value="orderstatus" />
			  <wcf:param name="isQuote" value="true" />
			</wcf:url>							
		</flow:ifEnabled>
	</flow:ifEnabled>
	<wcf:url var="MyAccountURL" value="AjaxLogonForm">
	  <wcf:param name="langId" value="${param.langId}" />
	  <wcf:param name="storeId" value="${param.storeId}" />
	  <wcf:param name="catalogId" value="${param.catalogId}" />
	  <wcf:param name="myAcctMain" value="1" />
	</wcf:url>
	<flow:ifEnabled feature="AjaxMyAccountPage">
		<wcf:url var="WishListDisplayURL" value="AjaxLogonForm">
			<wcf:param name="storeId"   value="${param.storeId}"  />
			<wcf:param name="catalogId" value="${param.catalogId}"/>
			<wcf:param name="langId" value="${param.langId}" />
			<wcf:param name="listId" value="." />    
			<wcf:param name="page" value="customerlinkwishlist"/>
		</wcf:url>
	</flow:ifEnabled>
	<flow:ifDisabled feature="AjaxMyAccountPage">
		<wcf:url var="WishListDisplayURL" value="NonAjaxAccountWishListDisplayView">
			<wcf:param name="storeId"   value="${param.storeId}"  />
			<wcf:param name="catalogId" value="${param.catalogId}"/>
			<wcf:param name="langId" value="${param.langId}" />
			<wcf:param name="listId" value="." />           
		</wcf:url>
	</flow:ifDisabled>
	<wcf:url var="SavedOrderListDisplayURL" value="ListOrdersDisplayView">
		<wcf:param name="storeId"   value="${param.storeId}"  />
			<wcf:param name="catalogId" value="${param.catalogId}"/>
			<wcf:param name="langId" value="${param.langId}" />
			<wcf:param name="myAcctMain" value="1" />   
		<wcf:param name="page" value="savedorder"/>
	</wcf:url>							
	<wcf:url var="HelpContactViewURL" value="Help">
		<wcf:param name="langId" value="${param.langId}" />
		<wcf:param name="storeId" value="${param.storeId}" />
		<wcf:param name="catalogId" value="${param.catalogId}" />
	</wcf:url>
	
	<wcf:url var="PrivacyViewURL" value="PrivacyPolicy">
		<wcf:param name="langId" value="${param.langId}" />
		<wcf:param name="storeId" value="${param.storeId}" />
		<wcf:param name="catalogId" value="${param.catalogId}" />
	</wcf:url>
	<wcf:url var="SiteMapURL" value="SiteMap">
		<wcf:param name="langId" value="${param.langId}" />
		<wcf:param name="storeId" value="${param.storeId}" />
		<wcf:param name="catalogId" value="${param.catalogId}" />
	</wcf:url>
	
	<wcf:url var="GuestWishListDisplayURL" value="InterestItemDisplay">
			<wcf:param name="storeId"   value="${param.storeId}"  />
			<wcf:param name="catalogId" value="${param.catalogId}"/>
			<wcf:param name="langId" value="${param.langId}" />
			<wcf:param name="listId" value="." />           
		</wcf:url>
		
<flow:ifEnabled feature="AjaxMyAccountPage">
	<wcf:url var="requisitionListURL" value="AjaxLogonForm" type="Ajax">
		<wcf:param name="storeId"   value="${param.storeId}"  />
		<wcf:param name="catalogId" value="${param.catalogId}"/>
		<wcf:param name="langId" value="${param.langId}" />
		<wcf:param name="page" value="requisitionlist"/>	
	</wcf:url>
</flow:ifEnabled>

<flow:ifDisabled feature="AjaxMyAccountPage">
	<wcf:url var="requisitionListURL" value="RequisitionListDisplayView">
		<wcf:param name="storeId"   value="${param.storeId}"  />
		<wcf:param name="catalogId" value="${param.catalogId}"/>
		<wcf:param name="langId" value="${param.langId}" />
		<wcf:param name="requisitionListStyle" value="strong"/>	
	</wcf:url>
</flow:ifDisabled>
	
	<script type="text/javascript" src="<c:out value="${jspStoreImgDir}javascript/StoreCommonUtilities.js"/>"></script>
	<script type="text/javascript">
			dojo.addOnLoad(function() { 
			<fmt:message key="ERROR_INCORRECT_BROWSER" bundle="${storeText}" var="ERROR_INCORRECT_BROWSER"/>	
			MessageHelper.setMessage("ERROR_INCORRECT_BROWSER",<wcf:json object="${ERROR_INCORRECT_BROWSER}"/> );
			});	
	</script>
	<c:choose>
		<c:when test="${userType eq 'G'}">
			<c:set var="interestItemDisplayURL" value="${GuestWishListDisplayURL}"/>
		</c:when>
		<c:otherwise>
			<c:set var="interestItemDisplayURL" value="${WishListDisplayURL}"/>
		</c:otherwise>
	</c:choose>
	
	<c:set var="footerColumnSizeCounter" value="0"/>
	
	 <div id="footer" class="footer-box">
		  <div class="left" id="WC_CachedFooterDisplay_div_1">
				<p class="sidebar_header"><strong><fmt:message key="FOOTER_CUSTOMER_SERVICE" bundle="${storeText}" /></strong></p>
				<p>
				<flow:ifEnabled feature="TrackingStatus">
					<c:set var="footerColumnSizeCounter" value="${footerColumnSizeCounter + 1}"/>
					<flow:ifEnabled feature="AjaxMyAccountPage">
						<a href="<c:out value="${OrderStatusURL}"/>" class="h_tnav_but" id="WC_CachedFooterDisplay_Link_1"><fmt:message key="FOOTER_ORDER_STATUS" bundle="${storeText}" /></a>
					</flow:ifEnabled>
					<flow:ifDisabled feature="AjaxMyAccountPage">
						<a href="<c:out value="${TrackOrderStatusURL}"/>" class="h_tnav_but" id="WC_CachedFooterDisplay_Link_2"><fmt:message key="FOOTER_ORDER_STATUS" bundle="${storeText}" /></a>
					</flow:ifDisabled>
					<flow:ifEnabled feature="EnableQuotes">
						</p>
						<p>
						<c:set var="footerColumnSizeCounter" value="${footerColumnSizeCounter + 1}"/>
						<flow:ifEnabled feature="AjaxMyAccountPage">
							<a href="<c:out value="${QuoteStatusURL}"/>" class="h_tnav_but" id="WC_CachedFooterDisplay_Link_9"><fmt:message key="FOOTER_QUOTE_STATUS" bundle="${storeText}" /></a>
						</flow:ifEnabled>
						<flow:ifDisabled feature="AjaxMyAccountPage">
							<a href="<c:out value="${TrackQuoteStatusURL}"/>" class="h_tnav_but" id="WC_CachedFooterDisplay_Link_10"><fmt:message key="FOOTER_QUOTE_STATUS" bundle="${storeText}" /></a>
						</flow:ifDisabled>
					</flow:ifEnabled>
				</flow:ifEnabled>
				</p>
				<p>
				<c:if test="${userType != 'G'}">
					<flow:ifEnabled feature="MultipleActiveOrders">
					<c:set var="footerColumnSizeCounter" value="${footerColumnSizeCounter + 1}"/>
						<a href="<c:out value="${SavedOrderListDisplayURL}"/>" class="h_tnav_but" id="WC_CachedFooterDisplay_Link_5"><fmt:message key="FOOTER_SAVED_ORDERS" bundle="${storeText}" /></a>
					</flow:ifEnabled>
				
				</p>
				<p>
					<flow:ifEnabled feature="wishList">
					<c:set var="footerColumnSizeCounter" value="${footerColumnSizeCounter + 1}"/>
						<a href="${interestItemDisplayURL}" id="WC_CachedFooterDisplay_link_3"><fmt:message key="FOOTER_WISH_LIST" bundle="${storeText}" />
						</a>
					</flow:ifEnabled>
				</c:if>
				</p>
				
				<c:if test="${footerColumnSizeCounter >= 3}">
					<c:set var="footerColumnSizeCounter" value="0"/>
					</div> <%-- have more than 3 items in the column. Closing the div of the previous column --%>
					<c:set var="numOfColumns" value="0"/> <%-- at this point, there will be at least 1 column --%>		
					<div class="left footerSecondColumn" id="WC_CachedFooterDisplay_Column${numOfColumns+1}"> 
				</c:if>
							
				<c:set var="footerColumnSizeCounter" value="${footerColumnSizeCounter + 1}"/>
				<p><a href="${MyAccountURL}" id="WC_CachedFooterDisplay_link_4"><fmt:message key="FOOTER_MY_ACCOUNT" bundle="${storeText}" /></a></p>
				
				<%-- need to check if i should close the <div> of the previous column and start a new one --%>	
				<c:if test="${footerColumnSizeCounter >= 3}">
				<c:set var="footerColumnSizeCounter" value="0"/>
					</div>
					<div class="left footerSecondColumn" id="WC_CachedFooterDisplay_secondColumn_${numOfColumn + 1}"> 
				</c:if> 
	
				<c:if test="${(!empty displayApproverLink) && (displayApproverLink=='true')}">
					<c:set var="footerColumnSizeCounter" value="${footerColumnSizeCounter + 1}"/>
					<p><a href="javascript:ApprovalToolLink('WC_CachedFooterDisplay_link_5_1', '<c:out value="${ApprovalToolLinkURL}"/>');"  onMouseout="javascript: this.blur();" onblur="javascript: this.blur();" id="WC_CachedFooterDisplay_link_5_1"><fmt:message key="FOOTER_APPROVALS" bundle="${storeText}"/></a></p>
				</c:if>
				
				<%-- need to check if i should close the <div> of the previous column and start a new one --%>
				<c:if test="${footerColumnSizeCounter >= 3}">
					<c:set var="footerColumnSizeCounter" value="0"/>
					</div>
					<div class="left footerSecondColumn" id="WC_CachedFooterDisplay_secondColumn_${numOfColumn + 1}"> 
				</c:if> 
				
				
				<flow:ifEnabled feature="RequisitionList">					
							<p><a href="<c:out value='${requisitionListURL}' />" id="requisitionList"><fmt:message key="MYACCOUNT_REQUISITION_LISTS" bundle="${storeText}"/></a></p>			
				</flow:ifEnabled>	
				
		  </div>
		  <div class="left" id="WC_CachedFooterDisplay_div_2">
			   <p class="sidebar_header"><strong><fmt:message key="FOOTER_CUSTOMER_SUPPORT" bundle="${storeText}" /></strong></p>
			   <p><a href="${PrivacyViewURL}" id="WC_CachedFooterDisplay_link_5"><fmt:message key="FOOTER_PRIVACY_POLICY" bundle="${storeText}" /></a></p>
			   <p><a href="${HelpContactViewURL}" id="WC_CachedFooterDisplay_link_6"><fmt:message key="FOOTER_HELP" bundle="${storeText}" /></a></p>
			   <p><a href="${SiteMapURL}" id="WC_CachedFooterDisplay_link_7"><fmt:message key="FOOTER_SITE_MAP" bundle="${storeText}" /></a></p>
			   <p><a href="#" tabindex="-1" id="WC_CachedFooterDisplay_links_8"></a></p>
		  </div>
	      <div id="WC_CachedFooterDisplay_div_3" class="clear_float"></div>
	 </div>
 </c:when>
 <c:otherwise>
	<div id="footer" class="footer-box footer-box-unregistered"></div> 
 </c:otherwise>
</c:choose>
 