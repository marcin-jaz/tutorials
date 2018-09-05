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
	* This JSP file is a fragment that prepares the user interface elements to show the inventory information for the product
	* display pages. Its contents are refreshed by data retrieved via AJAX and JSON.
	* 
	* Parameters
	*
	* -fromPage (required)
	* The page that calls this snippet (valid values are "productDisplay", "itemDisplay", "packageDisplay", "bundleDisplayItem",
	* or "bundleDisplayProduct")
	*
	* This is an example of how this file could be included into a page - to display inventory status of an item:
	* <c:set var="fromPage" value="productDisplay"/>
	* <%@ include file="CatalogEntryInventoryStatusExt.jspf"%>
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf"%>

<!-- BEGIN CatalogEntryInventoryStatus.jsp -->
<flow:ifEnabled feature="InventoryAvailability">
	<c:set var="catentryId" value="${param.catentryId}"/>
	<c:set var="defaultDisplayStyle" value=""/>
	<c:set var="htmlIdentifier" value=""/>
	<%-- handle catentryId setting from different pages --%>
	<c:choose>
		<c:when test="${param.fromPage == 'productDisplay' || param.fromPage == 'bundleDisplayProduct'}">
			<c:choose>
				<c:when test="${param.numberOfSKUs == 1}">
					<c:set var="htmlIdentifier" value="${catentryId}"/>
				</c:when>
				<c:otherwise>
					<c:set var="htmlIdentifier" value="${param.catalogEntryID}"/>
					<c:set var="defaultDisplayStyle" value="display:none"/>
				</c:otherwise>
			</c:choose>
		</c:when>
		<c:otherwise>
			<c:set var="htmlIdentifier" value="${catentryId}"/>
		</c:otherwise>
	</c:choose>
	
	<c:if test="${!includedStoreDetailsJSPF}">
		<c:set var="includedStoreDetailsJSPF" value="true"/>
		<%@ include file="../../ReusableObjects/CatalogEntryInventoryStatusDetails.jspf"%>
	</c:if>
	
	<script type="text/javascript">
		// variables used by CatalogEntryInventoryStatus.js
		
		<fmt:message key="INV_STATUS_Available" bundle="${storeText}" var="INV_STATUS_Available"/>
		<fmt:message key="INV_STATUS_Backorderable" bundle="${storeText}" var="INV_STATUS_Backorderable"/>
		<fmt:message key="INV_STATUS_Unavailable" bundle="${storeText}" var="INV_STATUS_Unavailable"/>
		<fmt:message key="INV_SELECT_PRODUCT" bundle="${storeText}" var="INV_SELECT_PRODUCT"/>
		var message_Available = <wcf:json object="${INV_STATUS_Available}"/>;
		var message_Backorderable = <wcf:json object="${INV_STATUS_Backorderable}"/>;
		var message_Unavailable = <wcf:json object="${INV_STATUS_Unavailable}"/>;
		var message_no_item = <wcf:json object="${INV_SELECT_PRODUCT}"/>;
		dojo.addOnLoad(function() { 
		setNumberOfSKUs(<c:out value="${param.numberOfSKUs}"/>);
			<fmt:message key="INV_STATUS_RETRIEVAL_ERROR" bundle="${storeText}" var="INV_STATUS_RETRIEVAL_ERROR"/>	
			MessageHelper.setMessage("INV_STATUS_RETRIEVAL_ERROR",<wcf:json object="${INV_STATUS_RETRIEVAL_ERROR}"/> );
		});	
	</script>

	<%-- link to the store locator page - this link is used by this jspf and CatalogEntryInventoryStatusDetails.jspf --%>
	<wcf:url var="StoreLocatorURL" value="AjaxStoreLocatorDisplayView">
		<wcf:param name="langId" value="${langId}" />						
		<wcf:param name="storeId" value="${WCParam.storeId}" />
		<wcf:param name="catalogId" value="${WCParam.catalogId}" />
		<wcf:param name="productId" value="${WCParam.productId}"/>
		<wcf:param name="categoryId" value="${WCParam.categoryId}"/>		  
		<wcf:param name="parent_category_rn" value="${WCParam.parent_category_rn}"/>
		<wcf:param name="top_category" value="${WCParam.top_category}" />
		<wcf:param name="fromPage" value="ProductDetails" />
		<c:choose>
			<c:when test="${param.fromPage == 'productDisplay'}">
				<wcf:param name="type" value="product" />
			</c:when>
			<c:when test="${param.fromPage == 'itemDisplay'}">
				<wcf:param name="type" value="item" />
			</c:when>
			<c:when test="${param.fromPage == 'packageDisplay'}">
				<wcf:param name="type" value="package" />
			</c:when>
			<c:when test="${param.fromPage == 'bundleDisplayItem'}">
				<wcf:param name="type" value="bundle" />
			</c:when>
			<c:when test="${param.fromPage == 'bundleDisplayProduct'}">
				<wcf:param name="type" value="bundle" />
			</c:when>
		</c:choose>		
	</wcf:url>
	
	<%-- Get online inventory availability of item --%>
	<c:if test="${catentryId != null && catentryId != ''}">
		<c:catch>
			<wcf:getData type="com.ibm.commerce.inventory.facade.datatypes.InventoryAvailabilityType[]"
			     var="onlineInventory" expressionBuilder="findInventoryAvailabilityByCatalogEntryIdsAndOnlineStoreIdsAndPhysicalStoreIds">
				<wcf:param name="accessProfile" value="IBM_Store_Details" />
				<wcf:param name="catalogEntryId" value="${catentryId}" />
				<wcf:param name="onlineStoreId" value="${WCParam.storeId}" />
			</wcf:getData>
		</c:catch>		
	</c:if>
	
 	<c:set var="emptyCookie" value="false"/>
 	<c:if test="${cookie.WC_physicalStores.value == null}">
 		<c:set var="emptyCookie" value="true"/>
 	</c:if>
 	<c:if test="${empty cookie.WC_physicalStores.value}">
 		<c:set var="emptyCookie" value="true"/>
 	</c:if>

	<div id="check_store_availability" class="rounded_content_box">
		<div class="contentgrad_header">
			<div class="left_corner"></div>
			<div class="heading"><span class="contentgrad_text"><fmt:message key="CHECK_STORE_AVAIL" bundle="${storeText}"/></span></div>
			<div class="right_corner"></div>
		</div>
		<div class="body588">
			<p class="online_availability" id="online_availability_message_${htmlIdentifier}" style="<c:out value="${defaultDisplayStyle}"/>"><fmt:message key="PRODUCT_INV_ONLINE" bundle="${storeText}"/></p>
			<c:choose>
			 	<c:when test="${(catentryId != null && catentryId != '') && (!empty onlineInventory) && (onlineInventory[0] != null)}">
			 		<c:set var="invStatus" value="${onlineInventory[0].inventoryStatus}"/>
			 		<fmt:message key="INV_STATUS_${invStatus}" bundle="${storeText}" var="invStatusDisplay"/> 
			 	</c:when>
			 	<c:otherwise>
			 		<c:set var="invStatus" value="NA"/>
			 		<fmt:message key="INV_INV_NA" bundle="${storeText}" var="invStatusDisplay"/>
			 	</c:otherwise>
			</c:choose>
			<p class="stock_status" id="online_availability_inventory_section_${htmlIdentifier}" style="<c:out value="${defaultDisplayStyle}"/>"><img id="onlinestore_inventory_status_image_${htmlIdentifier}" src="${jspStoreImgDir}images/${invStatus}.gif" alt="<c:out value="${invStatusDisplay}"/>" border="0" />&nbsp;<span id="onlinestore_inventory_status_${htmlIdentifier}"><c:out value="${invStatusDisplay}"/></span></p>
			
			<flow:ifEnabled feature="StoreLocator">
				<p class="instore_availability" id="instore_availability_message_${htmlIdentifier}" style="<c:out value="${defaultDisplayStyle}"/>"><fmt:message key="PRODUCT_INV_STORE" bundle="${storeText}"/></p>
				
				<p class="stock_status" id="store_inv_status_p_0_${htmlIdentifier}" style="display:none"><img alt="" border="0" id="store_inv_status_img_0_${htmlIdentifier}"/>&nbsp;<a href="#" class="bopis_link" id="store_inv_status_link_0_${htmlIdentifier}"></a>&nbsp;<span id="store_inv_status_0_${htmlIdentifier}"></span></p>
				<p class="stock_status" id="store_inv_status_p_1_${htmlIdentifier}" style="display:none"><img alt="" border="0" id="store_inv_status_img_1_${htmlIdentifier}"/>&nbsp;<a href="#" class="bopis_link" id="store_inv_status_link_1_${htmlIdentifier}"></a>&nbsp;<span id="store_inv_status_1_${htmlIdentifier}"></span></p>
				<p class="stock_status" id="store_inv_status_p_2_${htmlIdentifier}" style="display:none"><img alt="" border="0" id="store_inv_status_img_2_${htmlIdentifier}"/>&nbsp;<a href="#" class="bopis_link" id="store_inv_status_link_2_${htmlIdentifier}"></a>&nbsp;<span id="store_inv_status_2_${htmlIdentifier}"></span></p>
				<p class="stock_status" id="store_inv_status_p_3_${htmlIdentifier}" style="display:none"><img alt="" border="0" id="store_inv_status_img_3_${htmlIdentifier}"/>&nbsp;<a href="#" class="bopis_link" id="store_inv_status_link_3_${htmlIdentifier}"></a>&nbsp;<span id="store_inv_status_3_${htmlIdentifier}"></span></p>
				<p class="stock_status" id="store_inv_status_p_4_${htmlIdentifier}" style="display:none"><img alt="" border="0" id="store_inv_status_img_4_${htmlIdentifier}"/>&nbsp;<a href="#" class="bopis_link" id="store_inv_status_link_4_${htmlIdentifier}"></a>&nbsp;<span id="store_inv_status_4_${htmlIdentifier}"></span></p>
			
				<c:choose>
					<%-- case when physical store cookie is empty, goes to store locator page --%>
					<c:when test="${emptyCookie}">
						<p><a class="bopis_link" href="<c:out value='${StoreLocatorURL}'/>">
							<fmt:message key="INV_Link_Check_Store" bundle="${storeText}"/>
						</a></p>
					</c:when>
					<c:otherwise>
						<p id="storeSearchSection_${htmlIdentifier}" style="display:none"><a id="storeSearchLink_${htmlIdentifier}" class="bopis_link" href="<c:out value='${StoreLocatorURL}'/>"><fmt:message key="INV_Link_Change_Store" bundle="${storeText}"/></a></p>
					</c:otherwise>
				</c:choose>
				<c:choose>
					<%-- if catentryId is not populated, it is a product with multiple items, determine selected catentryId before calling inventory pop-up --%>
					<c:when test="${catentryId == null || catentryId == ''}">
						<c:set var="catentryId" value="${param.catalogEntryID}"/>
						<c:choose>
							<c:when test="${param.fromPage == 'productDisplay'}">
								<c:if test="${param.numberOfSKUs > 1}">
									<p id="storeShowAvail_${htmlIdentifier}"><a class="bopis_link" href="#" onclick="JavaScript:var ID=getItemId('entitledItem_${param.catalogEntryID}'); if (ID == null) MessageHelper.displayErrorMessage(message_no_item); else retrieveInvDetailsFromServer('${catentryId}',ID,'${WCParam.storeId}','${WCParam.langId}','${WCParam.catalogId}', '<c:out value="${jspStoreImgDir}images/"/>', '.gif', event);">
										<fmt:message key="INV_Link_Show_Avail" bundle="${storeText}"/>
									</a></p>
								</c:if>
							</c:when>
							<c:when test="${param.fromPage == 'bundleDisplayProduct'}">
								<p id="storeShowAvail_${htmlIdentifier}"><a class="bopis_link" href="#" onclick="JavaScript:var ID=getItemIdForBundleProduct('${param.catalogEntryID}'); if (ID == null) MessageHelper.displayErrorMessage(message_no_item); else retrieveInvDetailsFromServer('${catentryId}',ID,'${WCParam.storeId}','${WCParam.langId}','${WCParam.catalogId}', '<c:out value="${jspStoreImgDir}images/"/>', '.gif', event);">
									<fmt:message key="INV_Link_Show_Avail" bundle="${storeText}"/>
								</a></p>
							</c:when>
						</c:choose>
					</c:when>
					<c:when test="${!emptyCookie}">
						<p id="storeShowAvail_${htmlIdentifier}"><a class="bopis_link" href="#" onclick="javaScript:retrieveInvDetailsFromServer('${catentryId}','${catentryId}','${WCParam.storeId}','${WCParam.langId}','${WCParam.catalogId}', '<c:out value="${jspStoreImgDir}images/"/>', '.gif', event);">
							<fmt:message key="INV_Link_Show_Avail" bundle="${storeText}"/>
						</a></p>
					</c:when>
				</c:choose>
				
			</flow:ifEnabled>
			
			<flow:ifDisabled feature="StoreLocator">
				<c:set var="catentryId" value="${param.catalogEntryID}"/>
				<c:choose>
					<c:when test="${param.fromPage == 'productDisplay'}">
						<c:if test="${param.numberOfSKUs > 1}">
							<p id="storeShowAvail_${htmlIdentifier}"><a class="bopis_link" href="#" onclick="JavaScript:var ID=getItemId('entitledItem_${param.catalogEntryID}'); if (ID == null) MessageHelper.displayErrorMessage(message_no_item); else retrieveInvDetailsFromServer('${catentryId}',ID,'${WCParam.storeId}','${WCParam.langId}','${WCParam.catalogId}', '<c:out value="${jspStoreImgDir}images/"/>', '.gif', event);">
								<fmt:message key="INV_Link_Show_Avail" bundle="${storeText}"/>
							</a></p>
						</c:if>
					</c:when>
					<c:when test="${param.fromPage == 'bundleDisplayProduct'}">
						<c:if test="${param.numberOfSKUs > 1}">
							<p id="storeShowAvail_${htmlIdentifier}"><a class="bopis_link" href="#" onclick="JavaScript:var ID=getItemIdForBundleProduct('${param.catalogEntryID}'); if (ID == null) MessageHelper.displayErrorMessage(message_no_item); else retrieveInvDetailsFromServer('${catentryId}',ID,'${WCParam.storeId}','${WCParam.langId}','${WCParam.catalogId}', '<c:out value="${jspStoreImgDir}images/"/>', '.gif', event);">
								<fmt:message key="INV_Link_Show_Avail" bundle="${storeText}"/>
							</a></p>
						</c:if>
					</c:when>
				</c:choose>
					
			</flow:ifDisabled>
		</div>
		<div class="footer">
			<div class="left_corner"></div>
			<div class="left"></div>
			<div class="right_corner"></div>
		</div>						 
	</div>	
	<br />
</flow:ifEnabled>
<!-- End CatalogEntryInventoryStatus.jsp -->
