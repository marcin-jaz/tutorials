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

<%--
  *****
  * This page displays the category entries in the current category. The following entries will be displayed, if any, in order: 
  *	 - Categories
  *	 - Products
  *	 - Bundles
  *	 - Packages
  *	The parameter Top will be set to Y, if the current category is in the top level of the store catalog, otherwise the Top will
  *	be empty. The parent category will be indicated for the current category in the page heading, if the current category is not
  *	at the top level. 
  * This is an example of how this file could be included into a page: 
  * <c:import url="../../../Snippets/Catalog/CategoryDisplay/CachedCategoriesDisplay.jsp">
  *				<c:param name="storeId" value="${storeId}"/>
  *				<c:param name="catalogId" value="${catalogId}"/>
  *				<c:param name="langId" value="${langId}"/>
  *				<c:param name="categoryId" value="${categoryId}"/>
  *				<c:param name="parent_category_rn" value="${parentCategoryId}"/>
  *				<c:param name="top_category" value="${top_category}"/>
  *	</c:import>
  *****
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!-- JSP filename: DepartmentDisplay.jsp -->
<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/ServicesDeclaration.js"/>"></script>
<script type="text/javascript">
	dojo.addOnLoad(function() { 
		ServicesDeclarationJS.setCommonParameters('<c:out value='${WCParam.langId}'/>','<c:out value='${WCParam.storeId}'/>','<c:out value='${WCParam.catalogId}'/>');
	});
</script>

<wcbase:useBean id="category" classname="com.ibm.commerce.catalog.beans.CategoryDataBean" scope="page" />

<!-- Content Start -->
<div id="content588">
	 <h1><c:out value="${category.description.name}" /></h1>
   <div id="box">
		<div class="ad" id="ad_Department"> <img src="<c:out value="${category.objectPath}${category.description.fullIImage}"/>" alt="<c:out value="${category.description.shortDescription}" />" border="0"/> </div>

		<c:set var="emsNameTemp" value="${fn:replace(category.identifier,' ','')}"/>
		<c:set var="emsNameTemp" value="${fn:replace(emsNameTemp,'\\\\','')}"/>

		<%out.flush();%>
			<c:import url="${jspStoreDir}Snippets/Marketing/ESpot/ContentAreaESpot.jsp">
				<c:param name="emsName" value="${emsNameTemp}TopCategories" />
				<c:param name="numberCategoriesPerRow" value="3" />
				<c:param name="catalogId" value="${WCParam.catalogId}" />
				<c:param name="errorViewName" value="AjaxOrderItemDisplayView" />
			</c:import>
		<%out.flush();%>
		
		<c:set var="espotName" value="TopCategoryPageAds"/>
		<c:if test="${category.identifier == 'Apparel'}">
			<c:set var="espotName" value="ApparelPageAds"/>
		</c:if>
		
		<p class="space"></p>
		
		<c:set var="numSubCat" value="${fn:length(category.subCategories)}"/>
		
	
		<c:if test="${numSubCat > maxSubCategoriesPerCategoryInSidebar}">
		
		<div dojoType="wc.widget.RefreshArea" id="SubCategoryDisplay_Widget" controllerId="SubCategoryDisplay_Controller" role="wairole:region" waistate:live="polite" waistate:atomic="false" waistate:relevant="additions">
			<% out.flush(); %>
			<c:import url="${jspStoreDir}Snippets/Catalog/CategoryDisplay/SubCategoriesListDisplay.jsp">
				<c:param name="langId" value="${langId}" />
				<c:param name="storeId" value="${WCParam.storeId}" />
				<c:param name="catalogId" value="${WCParam.catalogId}" />
				<c:param name="categoryId" value="${WCParam.categoryId}" />
			</c:import>	
			<% out.flush(); %>
		</div>
		<script type="text/javascript">dojo.addOnLoad(function() { 
		parseWidget("SubCategoryDisplay_Widget"); 
		});</script>	
		</c:if>

		<%out.flush();%>
			<c:import url="${jspStoreDir}Snippets/Marketing/ESpot/ContentAreaESpot.jsp">
				<c:param name="emsName" value="${espotName}" />
				<c:param name="numberContentToDisplay" value="1" />
				<c:param name="numberContentPerRow" value="1" />
				<c:param name="catalogId" value="${WCParam.catalogId}" />
				<c:param name="errorViewName" value="AjaxOrderItemDisplayView" />
			</c:import>
		<%out.flush();%>
		
		<% out.flush(); %>
		<c:import url="${jspStoreDir}Snippets/Marketing/ESpot/ContentAreaESpot.jsp">
			<c:param name="storeId" value="${WCParam.storeId}" />
			<c:param name="catalogId" value="${catalogId}" />
			<c:param name="langId" value="${langId}" />
			<c:param name="numberProductsPerRow" value="4" />
			<c:param name="emsName" value="CategoryPageFeaturedProducts" />
			<c:param name="errorViewName" value="AjaxOrderItemDisplayView" />
		</c:import>
		<% out.flush(); %>
		
		<p class="space"></p>
		<div dojoType="wc.widget.RefreshArea" id="CategoryDisplay_Widget" controllerId="CategoryDisplay_Controller" role="wairole:region" waistate:live="polite" waistate:atomic="false" waistate:relevant="additions">
			<% out.flush(); %>
			<c:import url="${jspStoreDir}Snippets/Catalog/CategoryDisplay/CategoryOnlyResultsDisplay.jsp">
				<c:param name="langId" value="${langId}" />
				<c:param name="storeId" value="${WCParam.storeId}" />
				<c:param name="catalogId" value="${WCParam.catalogId}" />
				<c:param name="categoryId" value="${WCParam.categoryId}" />
			</c:import>	
			<% out.flush(); %>		
		</div>
		<script type="text/javascript">dojo.addOnLoad(function() { 
		parseWidget("CategoryDisplay_Widget");
		}); </script>
		<%@ include file="DepartmentDisplayExt.jspf"%>	
  </div>
</div>
<!-- Content End -->
