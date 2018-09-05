<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2008, 2009 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../JSTLEnvironmentSetup.jspf"%>

<c:if test="${requestScope.useHomeRightSidebar != null && !empty requestScope.useHomeRightSidebar}">
	<div id="right_nav">
		<c:choose>
			<c:when test="${requestScope.useHomeRightSidebar}">
				<c:choose>
					<c:when test="${requestScope.compareProductPage}">
						<div class="ads" id="WC_CachedHomeSidebarDisplay_div_1">
							<% out.flush(); %>
							<c:import url="${jspStoreDir}Snippets/Marketing/ESpot/ESpotNavDisplay.jsp">
								<c:param name="storeId" value="${WCParam.storeId}" />
								<c:param name="catalogId" value="${catalogId}" />
								<c:param name="langId" value="${langId}" />
								<c:param name="emsName" value="HomePageRightSideBarAds" />
								<c:param name="adclass" value="no_ad" />
								<c:param name="errorViewName" value="AjaxOrderItemDisplayView" />							
							</c:import>
							<% out.flush(); %>
						</div>
					</c:when>
					<c:otherwise>
						<div class="home_sidebar_container" id="WC_CachedHomeSidebarDisplay_div_2">
							<div class="home_sidebar_content" id="WC_CachedHomeSidebarDisplay_div_3">
								<% out.flush(); %>
								<c:import url="${jspStoreDir}Snippets/Marketing/ESpot/ESpotNavDisplay.jsp">
									<c:param name="storeId" value="${WCParam.storeId}" />
									<c:param name="catalogId" value="${catalogId}" />
									<c:param name="langId" value="${langId}" />
									<c:param name="emsName" value="HomePageRightSideBarAds" />
									<c:param name="adclass" value="sidebar_ad" />
									<c:param name="errorViewName" value="AjaxOrderItemDisplayView" />
								</c:import>
								<% out.flush(); %>
								
								<%@ include file="CachedHomeRightSidebarExt.jspf"%>
							</div>
						</div>
					</c:otherwise>
				</c:choose>
			</c:when>
			<c:otherwise>
				<div class="rightads" id="WC_CachedRightSidebarDisplay_div_1">
				<c:choose>
					<c:when test="${requestScope.shoppingCartPage || requestScope.pendingOrderDetailsPage}">
						<% out.flush(); %>
						<c:import url="${jspStoreDir}Snippets/Marketing/ESpot/ESpotNavDisplay.jsp">
							<c:param name="storeId" value="${WCParam.storeId}" />
							<c:param name="catalogId" value="${catalogId}" />
							<c:param name="langId" value="${langId}" />
							<c:param name="emsName" value="ShoppingCartRightSideBarAds" />
							<c:param name="adclass" value="email_ad" />
							<c:param name="errorViewName" value="AjaxOrderItemDisplayView" />
						</c:import>
						<% out.flush(); %>
					</c:when>
					<c:otherwise>
						<flow:ifEnabled feature="ProductCompare">
							<div id="compare">  
								<div  class="compare_top" id="WC_CachedRightSidebarDisplay_div_2"></div>
								<div class="toptext" id="WC_CachedRightSidebarDisplay_div_3">
									<h2 class="sidebar_header"><fmt:message key='COMPARE_TITLE' bundle='${storeText}'/></h2>
								</div>
								<%@ include file="../../../Snippets/ReusableObjects/CompareZoneDisplay.jspf" %> 
							</div>     
						</flow:ifEnabled>
							
						<% out.flush(); %>
						<c:import url="${jspStoreDir}Snippets/Marketing/ESpot/ESpotNavDisplay.jsp">
							<c:param name="storeId" value="${WCParam.storeId}" />
							<c:param name="catalogId" value="${catalogId}" />
							<c:param name="langId" value="${langId}" />
							<c:param name="emsName" value="RightSideBarAds" />
							<c:param name="adclass" value="email_ad" />
							<c:param name="errorViewName" value="AjaxOrderItemDisplayView" />
						</c:import>
						<% out.flush(); %>
					</c:otherwise>
				</c:choose>
				
				<c:choose>
					<c:when test="${requestScope.shoppingCartPage || requestScope.pendingOrderDetailsPage}">
						<c:set var="eMarketingSpotName" value="ShoppingCartFeaturedProducts"/>
					</c:when>
					<c:when test="${requestScope.categoryPage || requestScope.productPage || requestScope.topCategoryPage}">
						<c:set var="eMarketingSpotName" value="CategoryPageRecommendations"/>
					</c:when>
					<c:otherwise>
						<c:set var="eMarketingSpotName" value="RightSideBarFeaturedProducts"/>
					</c:otherwise>
				</c:choose>
				
				<% out.flush(); %>
				<c:import url="${jspStoreDir}Snippets/Marketing/ESpot/ESpotNavDisplay.jsp">
					<c:param name="storeId" value="${WCParam.storeId}" />
					<c:param name="catalogId" value="${catalogId}" />
					<c:param name="langId" value="${langId}" />
					<c:param name="emsName" value="${eMarketingSpotName}" />
					<c:param name="errorViewName" value="AjaxOrderItemDisplayView" />
				</c:import>
				<% out.flush(); %>
				<%@ include file="CachedRightSidebarExt.jspf"%>
				</div>
			</c:otherwise>
		</c:choose>
	</div>
</c:if>
