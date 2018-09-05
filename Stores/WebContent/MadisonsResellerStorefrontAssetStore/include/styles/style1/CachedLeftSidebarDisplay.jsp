<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2007, 2009 All Rights Reserved.

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

<c:if test="${requestScope.topCategoryPage || requestScope.categoryPage || requestScope.productPage || requestScope.compareProductPage || requestScope.sharedWishList || requestScope.fastFinder || requestScope.searchPage || requestScope.myAccountPage}">
	<div id="left_nav">
		<div class="left_nav_container" id="WC_LeftSidebarDisplay_div_1">
			<div class="left_nav_options" id="WC_LeftSidebarDisplay_div_2">
				<c:if test="${requestScope.topCategoryPage || requestScope.categoryPage || requestScope.productPage || requestScope.compareProductPage || requestScope.sharedWishList}">
					<%@ include file="../../../Snippets/ReusableObjects/CategoriesNavDisplay.jspf"%>
				</c:if>
				
				<c:if test="${requestScope.fastFinder}">
					<%@ include file="../../../Snippets/ReusableObjects/FastFinderNavDisplay.jspf"%>
				</c:if>
				<c:if test="${requestScope.searchPage}">
					<%@ include file="../../../Snippets/ReusableObjects/SearchPageNavDisplay.jspf"%>
				</c:if>
				<%@ include file="../../../Snippets/ReusableObjects/NavigationExt.jspf"%>
				<c:if test="${requestScope.myAccountPage}">
					<%@ include file="../../../Snippets/ReusableObjects/MyAccountNavDisplay.jspf" %>
				</c:if>
			</div>
		</div>
	</div>
</c:if>
