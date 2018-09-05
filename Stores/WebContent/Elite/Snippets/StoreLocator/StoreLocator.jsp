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
  * This JSP displays the store locator content.
  * 
	* Parameters
	*
	* -fromPage (optional)
	* It can be one of these options: "ProductDetails", "StoreLocator", or "ShoppingCart". If coming from the product details
	* page this page shows a short summary of the product at the top of the page. If coming from the shopping cart page then
	* the page will show the inventory information in the physical store list section. Otherwise, fromPage defaults to "StoreLocator"
	* and it will just show a default store locator page with search results and physical store list management.
	* 
	* -productId (optional)
	* The product id for the product that the shopper is checking inventory for.
	* 
	* -type (optional)
	* The type of product that the shopper is checking inventory for. This type parameter maybe "item", "product", "package" or "bundle".
  *****
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ include file="../../include/JSTLEnvironmentSetup.jspf" %>

<c:set var="fromPage" value="StoreLocator" />
<c:if test="${!empty WCParam.fromPage}">
  <c:set var="fromPage" value="${WCParam.fromPage}" />
</c:if>
<c:if test="${!empty param.fromPage}">
  <c:set var="fromPage" value="${param.fromPage}" />
</c:if>

<script type="text/javascript" src='<c:out value="${jsAssetsDir}javascript/MessageHelper.js"/>'></script>
<script type="text/javascript" src='<c:out value="${jsAssetsDir}javascript/StoreLocatorArea/PhysicalStoreCookie.js"/>'></script>
<script type="text/javascript" src='<c:out value="${jsAssetsDir}javascript/StoreLocatorArea/StoreLocator.js"/>'></script>
<script type="text/javascript" src='<c:out value="${jsAssetsDir}javascript/StoreLocatorArea/StoreLocatorContextsDeclarations.js"/>'></script>
<script type="text/javascript" src='<c:out value="${jsAssetsDir}javascript/StoreLocatorArea/StoreLocatorControllersDeclaration.js" />'></script>

<wcf:url var="AjaxProvinceSelectionDisplayURL" value="AjaxProvinceSelectionDisplayView" type="Ajax">
  <wcf:param name="storeId" value="${param.storeId}" />
  <wcf:param name="catalogId" value="${param.catalogId}" />
  <wcf:param name="langId" value="${langId}" />
</wcf:url>
<wcf:url var="AjaxCitySelectionDisplayURL" value="AjaxCitySelectionDisplayView" type="Ajax">
  <wcf:param name="storeId" value="${param.storeId}" />
  <wcf:param name="catalogId" value="${param.catalogId}" />
  <wcf:param name="langId" value="${langId}" />						
</wcf:url>
<wcf:url var="AjaxStoreLocatorResultsURL" value="AjaxStoreLocatorResultsView" type="Ajax">
  <wcf:param name="storeId" value="${param.storeId}" />
  <wcf:param name="catalogId" value="${param.catalogId}" />
  <wcf:param name="orderId" value="${param.orderId}" />
  <wcf:param name="langId" value="${langId}" />						
</wcf:url>
<wcf:url var="AjaxSelectedStoreListURL" value="AjaxSelectedStoreListView" type="Ajax">
  <wcf:param name="storeId" value="${param.storeId}" />
  <wcf:param name="catalogId" value="${param.catalogId}" />
  <wcf:param name="orderId" value="${param.orderId}" />
  <wcf:param name="langId" value="${langId}" />						
</wcf:url>
<wcf:url var="TopCategoriesDisplayURL" value="TopCategories1">
  <wcf:param name="storeId" value="${param.storeId}" />
  <wcf:param name="catalogId" value="${param.catalogId}" />
  <wcf:param name="langId" value="${langId}" />
</wcf:url>
<wcf:url var="ProductDisplayURL" value="Product2">
  <wcf:param name="langId" value="${langId}" />						
  <wcf:param name="storeId" value="${param.storeId}" />
  <wcf:param name="catalogId" value="${param.catalogId}" />
  <wcf:param name="productId" value="${param.productId}"/>
  <wcf:param name="categoryId" value="${param.categoryId}"/>		  
  <wcf:param name="parent_category_rn" value="${param.parent_category_rn}"/>
  <wcf:param name="top_category" value="${param.top_category}" />
</wcf:url>

<wcf:getData type="com.ibm.commerce.store.facade.datatypes.GeoNodeType[]"
  var="topGeoNodes" varException="topGeoNodeException" expressionBuilder="findTopGeoNodes">
  <wcf:param name="accessProfile" value="IBM_Store_All" />
</wcf:getData>

<script type="text/javascript">
  StoreLocatorControllersDeclarationJS.setCommonParameters('${langId}','${WCParam.storeId}','${WCParam.catalogId}','${WCParam.orderId}','${WCParam.fromPage}');
  StoreLocatorControllersDeclarationJS.setControllerURL('provinceSelectionsController','<c:out value="${AjaxProvinceSelectionDisplayURL}"/>');
  StoreLocatorControllersDeclarationJS.setControllerURL('citySelectionsController','<c:out value="${AjaxCitySelectionDisplayURL}"/>');
  StoreLocatorControllersDeclarationJS.setControllerURL('storeLocatorResultsController','<c:out value="${AjaxStoreLocatorResultsURL}"/>');
  StoreLocatorControllersDeclarationJS.setControllerURL('selectedStoreListController','<c:out value="${AjaxSelectedStoreListURL}"/>');
  StoreLocatorContextsJS.setCommonParameters('${langId}','${WCParam.storeId}','${WCParam.catalogId}','${WCParam.orderId}','${WCParam.fromPage}');

  <fmt:message key='MISSING_CITY' bundle='${storeText}' var="MISSING_CITY"/>
  <fmt:message key='EXCEED_PHYSICAL_STORE_SIZE' bundle='${storeText}' var="EXCEED_PHYSICAL_STORE_SIZE"/>
  
  MessageHelper.setMessage("MISSING_CITY", <wcf:json object="${MISSING_CITY}"/>);
  MessageHelper.setMessage("EXCEED_PHYSICAL_STORE_SIZE", <wcf:json object="${EXCEED_PHYSICAL_STORE_SIZE}"/>);
	
	dojo.addOnLoad(function() { parseWidget("selectedStoreList"); } );
	dojo.addOnLoad(function() { parseWidget("provinceSelections"); } );
	dojo.addOnLoad(function() { parseWidget("citySelections"); } );
	dojo.addOnLoad(function() { parseWidget("storeLocatorResults"); } );
  dojo.addOnLoad(storeLocatorJS.initProvinceSelections);
</script>


<c:choose>
  <c:when test="${fromPage == 'ProductDetails'}">
    <c:set var="productId" value="" />
    <c:if test="${!empty WCParam.productId}">
      <c:set var="productId" value="${WCParam.productId}" />
    </c:if>
    <c:if test="${!empty param.productId}">
      <c:set var="productId" value="${param.productId}" />
    </c:if>

    <c:set var="type" value="bundle" />
    <c:if test="${!empty WCParam.type}">
      <c:set var="type" value="${WCParam.type}" />
    </c:if>
    <c:if test="${!empty param.type}">
      <c:set var="type" value="${param.type}" />
    </c:if>

    <c:if test="${!empty productId}">
      <c:if test="${type == 'item'}">
        <wcbase:useBean id="itemDB" classname="com.ibm.commerce.catalog.beans.ItemDataBean" scope="request" />
      </c:if>
      <c:if test="${type == 'product'}">
        <wcbase:useBean id="productDB" classname="com.ibm.commerce.catalog.beans.ProductDataBean" scope="request" />
      </c:if>
      <c:if test="${type == 'package'}">
        <wcbase:useBean id="packageDB" classname="com.ibm.commerce.catalog.beans.PackageDataBean"  scope="request" />
      </c:if>
      <c:if test="${type == 'bundle'}">
        <wcbase:useBean id="bundleDB" classname="com.ibm.commerce.catalog.beans.BundleDataBean"  scope="request" />
      </c:if>
    </c:if>

    <div id="check_product_availability_container" class="contentgrad_header">
      <div class="left_corner"></div>
      <div class="left"><span class="contentgrad_text"><fmt:message key="STORELOCATOR_TITLE2" bundle="${storeText}" /></span></div>
      <div class="right_corner"></div>
    </div>
  </c:when>
  <c:otherwise>
    <div id="store_selection_container" class="contentgrad_header">
      <div class="left_corner"></div>
      <div class="left"></div>
      <div class="right_corner"></div>
    </div>
  </c:otherwise>
</c:choose>
		
<div id="store_selection" class="body">

<c:if test="${fromPage == 'ProductDetails'}">
  <c:if test="${!empty productId}">
    <div id="check_product_availability">
    <c:if test="${type == 'item'}">
      <c:set var="catalogEntryDB" value="${itemDB}"/>
        <img src="${itemDB.objectPath}${itemDB.description.thumbNail}" alt="${itemDB.description.shortDescription}"/>
        <div class="product_options">
          <h1><a href='<c:out value="${ProductDisplayURL}"/>'><c:out value="${itemDB.description.name}" escapeXml="false" /></a></h1>
    </c:if>
    <c:if test="${type == 'product'}">
      <c:set var="catalogEntryDB" value="${productDB}" />
        <img src="${productDB.objectPath}${productDB.description.thumbNail}" alt="${productDB.description.shortDescription}"/>
        <div class="product_options">
          <h1><a href='<c:out value="${ProductDisplayURL}"/>'><c:out value="${productDB.description.name}" escapeXml="false" /></a></h1>
    </c:if>
    <c:if test="${type == 'package'}">
      <c:set var="catalogEntryDB" value="${packageDB}"/>
        <img src="${packageDB.objectPath}${packageDB.description.thumbNail}" alt="${packageDB.description.shortDescription}"/>
        <div class="product_options">
          <h1><a href='<c:out value="${ProductDisplayURL}"/>'><c:out value="${packageDB.description.name}" escapeXml="false" /></a></h1>
    </c:if>
    <c:if test="${type == 'bundle'}">
      <c:set var="catalogEntryDB" value="${bundleDB}"/>
        <img src="${bundleDB.objectPath}${bundleDB.description.thumbNail}" alt="${bundleDB.description.shortDescription}"/>
        <div class="product_options">
          <h1><a href='<c:out value="${ProductDisplayURL}"/>'><span class="bopis_link"><c:out value="${bundleDB.description.name}" escapeXml="false" /></a></h1>
    </c:if>
        <div class="font3"><fmt:message key="PRICE_LABEL" bundle="${storeText}" /><%@ include file="../ReusableObjects/CatalogEntryPriceDisplay.jspf" %></div>
      </div>
    </div>
    <br clear="all" />
  </c:if>
</c:if>

<!-- your store list -->
<div id="hideStoreListHeader" class="content_header" style="display:block">
    <div class="left_corner"></div>
    <div class="left"><span class="content_text"><fmt:message key="STORE_LIST_TITLE" bundle="${storeText}" /></span></div>
    <div class="hide"><a href="Javascript:storeLocatorJS.hideStoreList();"><fmt:message key="STORE_LIST_HIDE" bundle="${storeText}" /> <img src="<c:out value='${jspStoreImgDir}images/'/>collapse_icon.gif" border="0" alt="<fmt:message key="STORE_LIST_HIDE" bundle="${storeText}" />"/></a></div>
    <div class="right_corner"></div>
</div>
<div id="showStoreListHeader" class="content_header" style="display:none">

    <div class="left_corner"></div>
    <div class="left"><span class="content_text"><fmt:message key="STORE_LIST_TITLE" bundle="${storeText}" /></span></div>
    <div class="hide"><a href="Javascript:storeLocatorJS.showStoreList();"><fmt:message key="STORE_LIST_SHOW" bundle="${storeText}" /> <img src="<c:out value='${jspStoreImgDir}images/'/>expand_icon.gif" border="0" alt="<fmt:message key="STORE_LIST_SHOW" bundle="${storeText}" />"/></a></div>
    <div class="right_corner"></div>
</div>
	
<div dojoType="wc.widget.RefreshArea" id="selectedStoreList" widgetId="selectedStoreList" controllerId="selectedStoreListController" style="display:block;">
  <% out.flush(); %>
  <c:import url="${jspStoreDir}Snippets/StoreLocator/SelectedStoreList.jsp">
    <c:param name="storeId" value="${param.storeId}" />
    <c:param name="catalogId" value="${param.catalogId}" />
    <c:param name="langId" value="${langId}" />
  </c:import>	
  <% out.flush(); %>
</div>

<div class="footer">
  <div class="left_corner"></div>
  <div class="left"></div>
  <div class="right_corner"></div>
</div><br />
<!-- your store list -->

<!-- store locator -->
<div class="content_header">
  <div class="left_corner"></div>
  <div class="left"><span class="content_text"><fmt:message key="STORELOCATOR_TITLE1" bundle="${storeText}" /> <span class="small_bold"><fmt:message key="SELECT_ENTER_OPTIONS" bundle="${storeText}" /></span></span></div>
  <div class="right_corner"></div>
</div>
	
<div class="body">
<br />		       
  <div id="location">
    <c:set var="formName" value="searchByGeoNodeForm" />
    <form id='<c:out value="${formName}" />' name='<c:out value="${formName}" />'>

      <div class="location_select">
        <div class="location_select_label"><label for="selectCountry"><fmt:message key="SELECT_COUNTRY" bundle="${storeText}" /></label></div>
        <div class="location_select_form">
            <select name="selectCountry" id="selectCountry" class="drop_down" onchange="JavaScript:storeLocatorJS.changeCountrySelection(this.options[this.selectedIndex].value);">
              <c:if test="${!empty topGeoNodeException}">
                <c:out value="${topGeoNodeException.changeStatus.description.value}" />
                <c:out value="${topGeoNodeException.clientErrors[0].errorKey}" />
              </c:if>	
              <c:if test="${empty topGeoNodeException}">
                <c:set var="resultNum" value="${fn:length(topGeoNodes)}" />
                <c:if test="${resultNum > 0}">
                  <c:forEach var="i" begin="0" end="${resultNum-1}">
                    <option value='<c:out value="${topGeoNodes[i].geoNodeIdentifier.uniqueID}" />'><c:out value="${topGeoNodes[i].description[0].name}" /></option>
                  </c:forEach>
                </c:if>
              </c:if>
            </select>
          </div>
      </div>
      <div class="location_select">
        <div class="location_select_label"><label for="selectState"><fmt:message key="SELECT_STATEPROVINCE" bundle="${storeText}" /></label></div>
        <div class="location_select_form">

            <div dojoType="wc.widget.RefreshArea" id="provinceSelections" widgetId="provinceSelections" controllerId="provinceSelectionsController" >
              <% out.flush(); %>
              <c:import url="${jspStoreDir}Snippets/StoreLocator/ProvinceSelectionDisplay.jsp">
                <c:param name="storeId" value="${param.storeId}" />
                <c:param name="catalogId" value="${param.catalogId}" />
                <c:param name="langId" value="${langId}" />
              </c:import>	
              <% out.flush(); %>
            </div>
						
        </div>
      </div>
      <div class="location_select">
        <div class="location_select_label"><label for="selectCity"><fmt:message key="SELECT_CITY" bundle="${storeText}" /></label></div>
        <div class="location_select_form">

            <div dojoType="wc.widget.RefreshArea" id="citySelections" widgetId="citySelections" controllerId="citySelectionsController" >
              <% out.flush(); %>
              <c:import url="${jspStoreDir}Snippets/StoreLocator/CitySelectionDisplay.jsp">
                <c:param name="storeId" value="${param.storeId}" />
                <c:param name="catalogId" value="${param.catalogId}" />
                <c:param name="langId" value="${langId}" />
              </c:import>	
              <% out.flush(); %>
            </div>
						
            <img src="<c:out value='${jspStoreImgDir}${vfileColor}' />blank_white.png" alt="<fmt:message key='WHITE_COLOR' bundle='${storeText}' />" width="2" />
          </div>
      </div>
      <div class="location_select">
        <div class="location_select_button">
        	<span class="primary_button button_fit" >
						<span class="button_container">
							<span class="button_bg">
								<span class="button_top">
									<span class="button_bottom">   
										<a id="cityGo" href="Javascript:setCurrentId('cityGo'); storeLocatorJS.refreshResultsFromCity(document.${formName}, '${fromPage}');">
											<fmt:message key="GO_BUTTON_LABEL" bundle="${storeText}" />
										</a>
									</span>
								</span>	
							</span>
						</span>
					</span>
        </div>
      </div>

    </form>
    <br clear="all"/><br />
        
      <div dojoType="wc.widget.RefreshArea" id="storeLocatorResults" widgetId="storeLocatorResults" controllerId="storeLocatorResultsController" >
        <% out.flush(); %>
        <c:import url="${jspStoreDir}Snippets/StoreLocator/StoreLocatorResults.jsp">
          <c:param name="storeId" value="${param.storeId}" />
          <c:param name="catalogId" value="${param.catalogId}" />
          <c:param name="langId" value="${langId}" />
        </c:import>	
        <% out.flush(); %>
      </div>
			
      <c:choose>
        <c:when test="${fromPage == 'ProductDetails'}">
        	<span class="primary_button" >
						<span class="button_container">
							<span class="button_bg">
								<span class="button_top">
									<span class="button_bottom">   
										<a id="continueShoppingStoreLocator_2" href="<c:out value="${ProductDisplayURL}"/>">
											<fmt:message key="CONTINUE_SHOPPING" bundle="${storeText}"/>
										</a>
									</span>
								</span>	
							</span>
						</span>
					</span>
        </c:when>
        <c:when test="${fromPage == 'StoreLocator'}">
        	<span class="primary_button" >
						<span class="button_container">
							<span class="button_bg">
								<span class="button_top">
									<span class="button_bottom">   
										<a id="continueShoppingStoreLocator_2_2" href="<c:out value="${TopCategoriesDisplayURL}"/>">
											<fmt:message key="CONTINUE_SHOPPING" bundle="${storeText}"/>
										</a>
									</span>
								</span>	
							</span>
						</span>
					</span>
        </c:when>
      </c:choose>
    </div>
		
  </div>
  <div class="footer">
    <div class="left_corner"></div>
    <div class="left"></div>
    <div class="right_corner"></div>
  </div><br />
  <!-- store locator -->	
</div>

<c:if test="${fromPage != 'ShoppingCart'}">
  <div class="footer">
    <div class="left_corner"></div>
    <div class="left"></div>
    <div class="right_corner"></div>
  </div>
</c:if>


