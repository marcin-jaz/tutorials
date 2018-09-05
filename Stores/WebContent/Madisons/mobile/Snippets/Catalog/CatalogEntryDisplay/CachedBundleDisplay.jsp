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
  * This JSP snippet displays the bundle details
  *****
--%>

<!-- BEGIN CachedBundleDisplay.jsp -->

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>

<%@ include file="../../../include/JSTLEnvironmentSetup.jspf" %>
<%@ include file="../../../include/ErrorMessageSetup.jspf" %>

<wcbase:useBean id="bundle" classname="com.ibm.commerce.catalog.beans.BundleDataBean"  scope="request">
	<c:set target="${bundle}" property="bundleID" value="${param.productId}"/>
</wcbase:useBean>

<c:set var="dragType" value="bundle"/>
<c:set var="type" value="bundle" />

<c:set var="search01" value="'"/>
<c:set var="replaceStr01" value="\\'"/>
<%@ include file="SetCatEntrySequence.jspf" %>

<c:set var="isBuyable" value="true"/>
<c:if test="${bundle.buyable == 0}">
	<c:set var="isBuyable" value="false"/>
</c:if>

<c:set var="someItemIDs" value="" />
	<c:forEach var="productInBundle" items="${bundle.bundledProducts}" varStatus="status">
		<c:choose>
			<c:when test="${empty someItemIDs}">
				<c:set var="someItemIDs" value="${productInBundle.product.productID}" />
			</c:when>	
			<c:otherwise>
				<c:set var="someItemIDs" value="${someItemIDs},${productInBundle.product.productID}" />
			</c:otherwise>	
		</c:choose>
	</c:forEach>

	<c:forEach var="itemInBundle" items="${bundle.bundledItems}" varStatus="iStatus">
		<c:choose>
			<c:when test="${empty someItemIDs}">
				<c:set var="someItemIDs" value="${itemInBundle.item.itemID}" />
			</c:when>	
			<c:otherwise>
				<c:set var="someItemIDs" value="${someItemIDs},${itemInBundle.item.itemID}" />
			</c:otherwise>	
		</c:choose>	
	</c:forEach>
	
	<c:forEach var="packageBundle" items="${bundle.bundledPackages}" varStatus="iStatus">
		<c:choose>
			<c:when test="${empty someItemIDs}">
				<c:set var="someItemIDs" value="${packageBundle.package.packageID}" />
			</c:when>	
			<c:otherwise>
				<c:set var="someItemIDs" value="${someItemIDs},${packageBundle.package.packageID}" />
			</c:otherwise>	
		</c:choose>	
	</c:forEach>

<div id="product" class="content_box">
		  <h2><c:out value="${bundle.description.name}" escapeXml="false"/></h2><br/><br/>
		  <p><fmt:message key="SKU" bundle="${storeText}" />: <c:out value="${bundle.partNumber}" escapeXml="false"/></p>

	<div class="clear_float"></div>
				
	<span class="product">
		<c:choose>
			<c:when test="${!empty bundle.description.fullImage}">
				<img id="productMainImage" src="<c:out value='${bundle.objectPath}${bundle.description.fullImage}'/>" width="150" height="150" border="0" alt="<c:out value='${bundle.description.shortDescription}'/>" />
			</c:when>
			<c:otherwise>
				<img id="productMainImage" src="<c:out value='${hostPath}${jspStoreImgDir}'/>images/NoImageIcon.jpg" width="150" height="150" border="0" alt="<c:out value='${bundle.description.shortDescription}' />" />
			</c:otherwise>
		</c:choose>
	</span>

	<c:choose>
		<c:when test="${!empty WCParam.errorMessage && WCParam.errorView=='true'}">
			<p class="error"><c:out value="${WCParam.errorMessage}" /></p>
		</c:when>
		<c:when test="${!empty errorMessage}">
			<p class="error"><c:out value="${errorMessage}" /></p>
		</c:when>		
	</c:choose>		

	<c:set var="selValSeparator" value="|" />
	<c:if test="${!empty WCParam.selectedValues}">
		<c:set var="selectedValue" value="${fn:split(WCParam.selectedValues, selValSeparator)}" />
	</c:if>

	<fmt:message var="QuantityErrorMessage" key="QUANTITY_INPUT_ERROR" bundle="${storeText}" />
	<fmt:message var="ResolveSKUErrorMessage" key="ERR_RESOLVING_SKU" bundle="${storeText}" />

	<wcf:url var="AddToProdCompare" value="mAddToProdCompare">
		<c:forEach var="parameter" items="${WCParamValues}">
			<c:forEach var="value" items="${parameter.value}">
				<c:if test="${parameter.key != 'catentryId' and parameter.key != 'productId'}">
					<wcf:param name="${parameter.key}" value="${value}" />
				</c:if>
			</c:forEach>
		</c:forEach>		
		<wcf:param name="catEntryId" value="${bundle.bundleID}"/>
		<wcf:param name="productId" value="${bundle.bundleID}"/>
	</wcf:url>		

	<c:if test="${isBuyable}">
		<ul>
			<li>
				<input type="button" onclick="javascript:submitAddToCart();" name="add_to_cart" id="add_to_cart" value="<fmt:message key="ADD_TO_CART" bundle="${storeText}" />" />
			</li>
			<li>
				<span class="bullet">&#187; </span>
				<a href="#" onclick="document.getElementById('wishlist_add').submit();" title="<fmt:message key="WISHLIST" bundle="${storeText}" />">
					<fmt:message key="WISHLIST" bundle="${storeText}" />
				</a>
			</li>
			<li>
				<span class="bullet">&#187; </span>
				<a href="${fn:escapeXml(AddToProdCompare)}" title="<fmt:message key="SELECT_TO_COMPARE" bundle="${storeText}" />">
					<fmt:message key="SELECT_TO_COMPARE" bundle="${storeText}" />
				</a>
			</li>
		</ul>
	</c:if>

	<div id="product_description" class="text_container">
		<h3><fmt:message key="DESCRIPTION" bundle="${storeText}" />:</h3>
		<p><c:out value="${bundle.description.longDescription}" escapeXml="false"/></p>
	</div>

</div>
<c:set var="WishlistDisplayURL" value="InterestItemDisplay?URL=mInterestListDisplay&listId=." />
<form method="post" action="InterestItemAdd" id="wishlist_add">
	<input type="hidden" name="URL" value="${WishlistDisplayURL}" />
	<input type="hidden" name="catEntryIDS" value="${someItemIDs}" />
	<input type="hidden" name="productId" value="${bundle.bundleID}" />
	<input type="hidden" name="catalogId" value="${WCParam.catalogId}" />
	<input type="hidden" name="storeId" value="${WCParam.storeId}" />
	<input type="hidden" name="langId" value="${langId}" />
	<input type="hidden" name="errorViewName" value="mProductDisplayView" />
	<input type="hidden" name="fromProdDisp" value="true" />
	<input type="hidden" name="errorView" value="true" />
	<input type="hidden" name="errorMessage" value="${ResolveSKUErrorMessage}" />
	
		<c:if test="${WCParam.pgGrp == 'catNav'}">
			<input type="hidden" name="parent_category_rn" value="${WCParam.parent_category_rn}" />
			<input type="hidden" name="top_category" value="${WCParam.top_category}" />
			<input type="hidden" name="sequence" value="${WCParam.sequence}" />
			<input type="hidden" name="categoryId" value="${WCParam.categoryId}" />
		</c:if>
		<c:if test="${WCParam.pgGrp == 'search'}">
			<input type="hidden" name="pageSize" value="${WCParam.pageSize}" />
			<input type="hidden" name="resultCatEntryType" value="${WCParam.resultCatEntryType}" />
			<input type="hidden" name="searchTerm" value="${WCParam.searchTerm}" />
			<input type="hidden" name="beginIndex" value="${WCParam.beginIndex}" />
			<input type="hidden" name="sType" value="${WCParam.sType}" />
		</c:if>			
	
	<input type="hidden" name="pgGrp" value="${WCParam.pgGrp}" />

	<div id="product_bundles_breakdown">

		<%-- 
		 ***
		 *	Start: List the information of the items that compose the bundle
		 ***
		--%>	
		<c:forEach var="compositeItem" items="${bundle.bundledItems}" varStatus="iStatus">
			<c:url var="ProductDisplayURL" value="ProductDisplay">
				<c:param name="productId" value="${compositeItem.item.itemID}" />
				<c:param name="langId" value="${langId}" />
				<c:param name="storeId" value="${WCParam.storeId}" />
				<c:param name="catalogId" value="${WCParam.catalogId}" />
				<c:if test="${ !empty WCParam.parent_category_rn }" >
					<c:param name="parent_category_rn" value="${WCParam.parent_category_rn}" />
				</c:if>
			</c:url>
			<c:set var="catalogEntryDB" value="${compositeItem.item}"/>
			
			<wcf:url var="catEntryDisplayUrl" value="mProduct2">
				<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
				<wcf:param name="storeId" value="${WCParam.storeId}"/>
				<wcf:param name="productId" value="${catalogEntryDB.itemID}"/>
				<wcf:param name="langId" value="${langId}"/>
				<wcf:param name="categoryId" value="${WCParam.categoryId}"/>
				<wcf:param name="pgGrp" value="${WCParam.pgGrp}"/>
			</wcf:url>	
		
			<div id="product_bundles_breakdown_1" class="content_box">
				<div class="heading_container">
					  <h2><fmt:message key="ITEM_TITLE1" bundle="${storeText}"/> <c:out value="${catalogEntryDB.description.name}" /></h2><br/><br/>
					  <p><fmt:message key="SKU" bundle="${storeText}" />: <c:out value="${catalogEntryDB.partNumber}" escapeXml="false"/></p>
					<div class="clear_float"></div>
				</div>
				<span class="product">
					<c:choose>
						<c:when test="${!empty catalogEntryDB.description.thumbNail}">
							<a href="${fn:escapeXml(catEntryDisplayUrl)}" ><img src="<c:out value='${catalogEntryDB.objectPath}${catalogEntryDB.description.thumbNail}' />" alt="<c:out value='${catalogEntryDB.description.name}' />" hspace="5" border="0"/></a>
						</c:when>
						<c:otherwise>
							<a href="${fn:escapeXml(catEntryDisplayUrl)}" ><img src="<c:out value='${jspStoreImgDir}'/>images/NoImageIcon_sm.jpg" alt="<fmt:message key='No_Image' bundle='${storeText}'/>" hspace="5" border="0"/></a>						
						</c:otherwise>
					</c:choose>
				</span> 
				<ul>
					<li>
						<div class="left">
							<fmt:message key="PRICE" bundle="${storeText}"/>
							<c:set var="type" value="item"/>
												
							<%@ include file="../../../Snippets/ReusableObjects/CatalogEntryPriceDisplay.jspf"%>
						</div>
					</li>
					<c:if test="${isBuyable}">
						<li>
							<label for="quantity_<c:out value='${catalogEntryDB.itemID}'/>"><fmt:message key="ITEM_QTY" bundle="${storeText}" /></label><input type="text" name="quantity_<c:out value='${iStatus.count}'/>" id="quantity_<c:out value='${catalogEntryDB.itemID}'/>" class="coloured_input" size="4" value="<c:out value='${compositeItem.formattedQuantity}'/>" />
							<input type="hidden" name="partNumber_<c:out value='${iStatus.count}'/>" value="${catalogEntryDB.partNumber}" id="partno_<c:out value='${iStatus.count}'/>"/>
							<input type="hidden" name="catEntryId_<c:out value='${iStatus.count}'/>" value="${catalogEntryDB.itemID}" id="catEntryId_<c:out value='${iStatus.count}'/>"/>
						</li>
					</c:if>
				</ul>
						
				<div class="text_container">
					<h3><fmt:message key="DESCRIPTION" bundle="${storeText}" />:</h3>						
					<p><c:out value="${catalogEntryDB.description.longDescription}" escapeXml="false"/></p>
				</div>

				<c:if test="${isBuyable}">
					<%out.flush();%>
					<c:import url="${jspStoreDir}mobile/Snippets/Catalog/CatalogEntryDisplay/ItemAvailability.jsp">
						<c:param name="itemId" value="${catalogEntryDB.itemID}" />
					</c:import>
					<%out.flush();%>
				</c:if>

			</div>
			<c:set var="runningCountInLoop" value="${iStatus.count}" />
		</c:forEach>
		<%-- 
		 ***
		 *	End: List the information of the items that compose the bundle
		 ***
		--%>
					
		<%-- 
		 ***
		 *	Start: List the information of the products that compose the bundle
		 ***
		--%>
		<c:set var="numberOfProduct" value="${runningCountInLoop}" />
		<c:forEach var="compositeProduct" items="${bundle.bundledProducts}" varStatus="iStatus">
			<c:url var="ProductDisplayURL" value="ProductDisplay">
				<c:param name="productId" value="${compositeProduct.product.productID}" />
				<c:param name="langId" value="${langId}" />
				<c:param name="storeId" value="${WCParam.storeId}" />
				<c:param name="catalogId" value="${WCParam.catalogId}" />
				<c:if test="${ !empty WCParam.parent_category_rn }" >
					<c:param name="parent_category_rn" value="${WCParam.parent_category_rn}" />
				</c:if>
			</c:url>
			<c:set var="catalogEntryDB" value="${compositeProduct.product}"/>
			
			<wcf:url var="catEntryDisplayUrl" value="mProduct2">
				<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
				<wcf:param name="storeId" value="${WCParam.storeId}"/>
				<wcf:param name="productId" value="${catalogEntryDB.itemID}"/>
				<wcf:param name="langId" value="${langId}"/>
				<wcf:param name="categoryId" value="${WCParam.categoryId}"/>
				<wcf:param name="pgGrp" value="${WCParam.pgGrp}"/>
			</wcf:url>
			
			<div id="product_bundles_breakdown_3" class="content_box">
				<div class="heading_container">
				  <h2><fmt:message key="ITEM_TITLE1" bundle="${storeText}"/> <c:out value="${catalogEntryDB.description.name}" /></h2><br/><br/>
				  <p><fmt:message key="SKU" bundle="${storeText}" />: <c:out value="${catalogEntryDB.partNumber}" escapeXml="false"/></p>						
					<div class="clear_float"></div>
				</div>
				<span class="product">
					<c:choose>
						<c:when test="${!empty catalogEntryDB.description.thumbNail}">
							<a href="${fn:escapeXml(catEntryDisplayUrl)}" ><img src="<c:out value='${catalogEntryDB.objectPath}${catalogEntryDB.description.thumbNail}' />" alt="<c:out value='${catalogEntryDB.description.name}' />" hspace="5" border="0"/></a>
						</c:when>
						<c:otherwise>
							<a href="${fn:escapeXml(catEntryDisplayUrl)}" ><img src="<c:out value='${jspStoreImgDir}'/>images/NoImageIcon_sm.jpg" alt="<fmt:message key='No_Image' bundle='${storeText}'/>" hspace="5" border="0"/></a>						
						</c:otherwise>
					</c:choose>
				</span> 
				<ul>
					<li>
						<div class="left">
							<fmt:message key="PRICE" bundle="${storeText}"/>
							<c:set var="type" value="product"/>
												
							<%@ include file="../../../Snippets/ReusableObjects/CatalogEntryPriceDisplay.jspf"%>
						</div>
					</li>
					<li>
						<label for="quantity_<c:out value='${catalogEntryDB.productID}'/>"><fmt:message key="ITEM_QTY" bundle="${storeText}" /></label><input type="text" name="quantity_<c:out value='${numberOfProduct + iStatus.count}'/>" id="quantity_<c:out value='${catalogEntryDB.productID}'/>" class="coloured_input" size="4" value="<c:out value='${compositeProduct.formattedQuantity}'/>" />
						<input type="hidden" name="catEntryId_<c:out value='${numberOfProduct + iStatus.count}'/>" value="${catalogEntryDB.productID}" id="catEntryId_<c:out value='${numberOfProduct + iStatus.count}'/>"/>
					</li>
				</ul>

				
				<%-- 
				 ***
				 *	Start: Defining Attributes
				 * The drop down box will only display defining attributes.
				 * Defining attributes are properties of SKUs.  They are used for SKU resolution.
				 ***
				--%>
					<c:if test="${!empty catalogEntryDB.definingAttributes}">
					<%-- the drop down box will only display defining attributes --%>
						<c:forEach var="attribute" items="${catalogEntryDB.definingAttributeDataBeans}" varStatus="aStatus">
							<c:set var="selectedIndex" value="${selectedIndex+1}" />				
								<input type="hidden" name="attrName" value="<c:out value="${attribute.attributeId}" />" />
								<input type="hidden" name="attrNName" value="<c:out value="${attribute.name}" />" />
								<div class="dropdown_container">
									<div><label for="attrValue_<c:out value='${numberOfProduct + iStatus.count}'/>_<c:out value='${aStatus.count}'/>" class="nodisplay"><span class="field_required_symbol">*</span><c:out value='${attribute.name}'/></label></div>
									<select name="attrValue" id="attrValue_<c:out value='${numberOfProduct + iStatus.count}'/>_<c:out value='${aStatus.count}'/>" class="drop_down">
										<option value="-n/a-">
											<fmt:message key="SELECT_ATTRIBUTE" bundle="${storeText}">
												<fmt:param><c:out value="${fn:replace(attribute.name, search01, replaceStr01)}"/></fmt:param>
											</fmt:message>
										</option>
										<c:forEach var="attributeValue" items="${attribute.distinctAttributeValues}">
											<%-- Reselect the attribute values the user selected, or select nothing if not selected. 
												 We rely on HTTP to preserve the order of the attributes submitted.  --%>
												<c:choose>
													<c:when test="${WCParamValues.attrValue[aStatus.count-1] == attributeValue}">
														<option selected="selected"><c:out value="${fn:replace(attributeValue, search01, replaceStr01)}" /></option>
													</c:when>
													<c:otherwise>
														<option value="<c:out value="${fn:replace(attributeValue, search01, replaceStr01)}" />"><c:out value="${fn:replace(attributeValue, search01, replaceStr01)}" /></option>
													</c:otherwise>
												</c:choose>

										</c:forEach>
									</select>						
								</div>
						</c:forEach>	
					</c:if>
				<%-- 
				 ***
				 *	End: Defining Attributes
				 ***
				--%>
				
				<div class="text_container">
					<h3><fmt:message key="DESCRIPTION" bundle="${storeText}" />:</h3>						
					<p><c:out value="${catalogEntryDB.description.longDescription}" escapeXml="false"/></p>
				</div>

				<c:set var="entitledItems" value="${catalogEntryDB.entitledItems}" />
				<c:if test="${!empty entitledItems and fn:length(entitledItems) == 1}">
					<%out.flush();%>
					<c:import url="${jspStoreDir}mobile/Snippets/Catalog/CatalogEntryDisplay/ItemAvailability.jsp">
						<c:param name="itemId" value="${entitledItems[0].itemID}" />
					</c:import>
					<%out.flush();%>
				</c:if>
				
			</div>
			<c:set var="runningCountInLoop" value="${numberOfProduct + iStatus.count}" />
		</c:forEach>

		<%-- 
		 ***
		 *	End: List the information of the products that compose the bundle
		 ***
		--%>
</form>
	<fmt:message var="QuantityErrorMessage" key="QUANTITY_INPUT_ERROR" bundle="${storeText}" />

	<wcf:url var="OrderItemDisplayURL" value="mOrderItemDisplay">
		<wcf:param name="langId" value="${langId}" />
		<wcf:param name="storeId" value="${WCParam.storeId}" />
		<wcf:param name="catalogId" value="${WCParam.catalogId}" />

		<c:if test="${WCParam.pgGrp == 'catNav'}">
			<wcf:param name="parent_category_rn" value="${WCParam.parent_category_rn}" />
			<wcf:param name="top_category" value="${WCParam.top_category}" />
			<wcf:param name="sequence" value="${WCParam.sequence}" />
			<wcf:param name="categoryId" value="${WCParam.categoryId}" />
		</c:if>
		<c:if test="${WCParam.pgGrp == 'search'}">
			<wcf:param name="pageSize" value="${WCParam.pageSize}" />
			<wcf:param name="resultCatEntryType" value="${WCParam.resultCatEntryType}" />
			<wcf:param name="searchTerm" value="${WCParam.searchTerm}" />
			<wcf:param name="beginIndex" value="${WCParam.beginIndex}" />
			<wcf:param name="sType" value="${WCParam.sType}" />
		</c:if>

		<wcf:param name="pgGrp" value="${WCParam.pgGrp}" />
	</wcf:url>

	<form id="AddToCartForm" method="post" action="OrderChangeServiceItemAdd">
		<input type="hidden" name="URL" value="${OrderItemDisplayURL}" id="WC_MAddToCart_FormInput_URL" />
		<input type="hidden" name="catalogId" value="${WCParam.catalogId}" id="WC_MAddToCart_FormInput_catlogId" />
		<input type="hidden" name="storeId" value="${WCParam.storeId}" id="WC_MAddToCart_FormInput_storeId" />
		<input type="hidden" name="langId" value="${langId}" id="WC_MAddToCart_FormInput_langId" />
		<input type="hidden" name="productId" value="${bundle.bundleID}" id="WC_MAddToCart_FormInput_productId"/>
		<input type="hidden" name="errorViewName" value="mProductDisplayView" id="WC_MAddToCart_FormInput_errorViewName"/>

		<c:if test="${WCParam.pgGrp == 'catNav'}">
			<input type="hidden" name="parent_category_rn" value="${WCParam.parent_category_rn}" />
			<input type="hidden" name="top_category" value="${WCParam.top_category}" />
			<input type="hidden" name="sequence" value="${WCParam.sequence}" />
			<input type="hidden" name="categoryId" value="${WCParam.categoryId}" />
		</c:if>
		<c:if test="${WCParam.pgGrp == 'search'}">
			<input type="hidden" name="pageSize" value="${WCParam.pageSize}" />
			<input type="hidden" name="resultCatEntryType" value="${WCParam.resultCatEntryType}" />
			<input type="hidden" name="searchTerm" value="${WCParam.searchTerm}" />
			<input type="hidden" name="beginIndex" value="${WCParam.beginIndex}" />
			<input type="hidden" name="sType" value="${WCParam.sType}" />
		</c:if>			
	
		<input type="hidden" name="pgGrp" value="${WCParam.pgGrp}" />

		<%-- 
		  ***
		  *	Start: List the information of the items that compose the bundle
		  ***
		--%>
		<c:forEach var="compositeItem" items="${bundle.bundledItems}" varStatus="iStatus">
			<c:set var="catalogEntryDB" value="${compositeItem.item}"/>
			<input type="hidden" name="partNumber_<c:out value="${iStatus.count}"/>" value="<c:out value="${catalogEntryDB.partNumber}" />" id="WC_CachedBundleDisplay_FormInput_partNumber_<c:out value='${iStatus.count}'/>_In_OrderItemAddForm_1"/>
			<input type="hidden" name="quantity_<c:out value='${iStatus.count}'/>" id="WC_MAddToCart_FormInput_quantity_<c:out value='${catalogEntryDB.itemID}'/>" size="1" value="<c:out value='${compositeItem.formattedQuantity}'/>"/>
			<input type="hidden" name="catEntryId_<c:out value='${iStatus.count}'/>" value="<c:out value='${catalogEntryDB.itemID}'/>" id="catEntryId_<c:out value='${catalogEntryDB.itemID}'/>"/>
			<input type="hidden" name="productId_<c:out value='${iStatus.count}'/>" value="<c:out value='${catalogEntryDB.itemID}'/>" id="productId_<c:out value='${catalogEntryDB.itemID}'/>"/>
			<c:set var="runningCountInLoop" value="${iStatus.count}" />
		</c:forEach>
		
		<%-- 
		  ***
		  *	End: List the information of the items that compose the bundle
		  ***
		--%>
			
		<%-- 
		  ***
		  *	Start: List the information of the products that compose the bundle
		  ***
		--%>
		<c:set var="numberOfProduct" value="${runningCountInLoop}" />
		
		<c:forEach var="compositeProduct" items="${bundle.bundledProducts}" varStatus="iStatus">
			<c:set var="catalogEntryDB" value="${compositeProduct.product}"/>
			<input type="hidden" name="quantity_<c:out value='${numberOfProduct + iStatus.count}'/>" id="WC_MAddToCart_FormInput_quantity_<c:out value='${catalogEntryDB.productID}'/>" size="1" value="<c:out value='${compositeProduct.formattedQuantity}'/>" />
			<input type="hidden" name="catEntryId_<c:out value='${numberOfProduct + iStatus.count}'/>" value="<c:out value='${catalogEntryDB.productID}'/>" id="catEntryId_<c:out value='${catalogEntryDB.productID}'/>"/>	
			<%-- Defined attributes--%>
			<c:set var="selectedIndex" value="0" />
			<c:forEach var="attribute" items="${catalogEntryDB.definingAttributeDataBeans}" varStatus="counter">
					<c:if test="${attribute.usage == 'Defining'}">
						<c:set var="selectedIndex" value="${selectedIndex+1}" />
						<input type="hidden" id="addToCart_attrName_${numberOfProduct + iStatus.count}_${selectedIndex}" name="attrName_${numberOfProduct + iStatus.count}_${selectedIndex}" value="${attribute.attributeIdentifier.uniqueID}" />
						<input type="hidden" id="addToCart_attrValue_${numberOfProduct + iStatus.count}_${selectedIndex}" name="attrValue_${numberOfProduct + iStatus.count}_${selectedIndex}" value="" />
					</c:if>
			</c:forEach>
			<c:set var="runningCountInLoop" value="${numberOfProduct + iStatus.count}" />	
		</c:forEach>
		<%-- 
		  ***
		  *	End: List the information of the products that compose the bundle
		  ***
		--%>
		<%-- 
		  ***
		  *	Start: List the information of the packages that compose the bundle
		  ***
		--%>
		<c:set var="numberOfProduct" value="${runningCountInLoop}" />
		<c:forEach var="compositePackage" items="${bundle.bundledPackages}" varStatus="iStatus">
			<c:set var="catalogEntryDB" value="${compositePackage.package}"/>
			<input type="hidden" name="partNumber_<c:out value="${numberOfProduct + iStatus.count}"/>" value="<c:out value="${catalogEntryDB.partNumber}" />" id="WC_CachedBundleDisplay_FormInput_partNumber_<c:out value='${numberOfProduct + iStatus.count}'/>_In_OrderItemAddForm_1"/>
			<input type="hidden" name="quantity_<c:out value='${numberOfProduct + iStatus.count}'/>" id="WC_MAddToCart_FormInput_quantity_<c:out value='${catalogEntryDB.packageID}'/>" size="1" value="<c:out value='${compositePackage.formattedQuantity}'/>"/>
			<input type="hidden" name="catEntryId_<c:out value='${numberOfProduct + iStatus.count}'/>" value="<c:out value='${catalogEntryDB.packageID}'/>" id="catEntryId_<c:out value='${catalogEntryDB.packageID}'/>"/>
			<input type="hidden" name="contractId_<c:out value='${numberOfProduct + iStatus.count}'/>" value="" id="contractId_<c:out value='${catalogEntryDB.packageID}'/>"/>
		</c:forEach>
		<input type="hidden" name="numberOfProduct" id="numberOfProduct" value='<c:out value="${runningCountInLoop}"/>'/>
		<%-- 
		  ***
		  *	End: List the information of the packages that compose the bundle
		  ***
		--%>
	</form>

	<form id="InputError" method="post" action="mProductDisplayView">
		<input type="hidden" name="errorView" value="true" />
		<input type="hidden" name="errorMessage" value="${QuantityErrorMessage}" id="InputErrorMessage" />
		<input type="hidden" name="productId" value="${bundle.bundleID}" />
		<input type="hidden" name="catalogId" value="${WCParam.catalogId}" />
		<input type="hidden" name="storeId" value="${WCParam.storeId}" />
		<input type="hidden" name="langId" value="${langId}" />

		<c:if test="${WCParam.pgGrp == 'catNav'}">
			<input type="hidden" name="parent_category_rn" value="${WCParam.parent_category_rn}" />
			<input type="hidden" name="top_category" value="${WCParam.top_category}" />
			<input type="hidden" name="sequence" value="${WCParam.sequence}" />
			<input type="hidden" name="categoryId" value="${WCParam.categoryId}" />
		</c:if>
		<c:if test="${WCParam.pgGrp == 'search'}">
			<input type="hidden" name="pageSize" value="${WCParam.pageSize}" />
			<input type="hidden" name="resultCatEntryType" value="${WCParam.resultCatEntryType}" />
			<input type="hidden" name="searchTerm" value="${WCParam.searchTerm}" />
			<input type="hidden" name="beginIndex" value="${WCParam.beginIndex}" />
			<input type="hidden" name="sType" value="${WCParam.sType}" />
		</c:if>			

		<input type="hidden" name="pgGrp" value="${WCParam.pgGrp}" />
	</form>

<%@ include file="ProductQuickNavigation.jspf" %>

<script type="text/javascript">
//<![CDATA[

function submitAddToCart() {
    var invalidQTY = false;
    var attrValue;
	<c:forEach var="compositeItem" items="${bundle.bundledItems}" varStatus="iStatus">
		<c:set var="catalogEntryDB" value="${compositeItem.item}"/>
		var v = document.getElementById("quantity_<c:out value='${catalogEntryDB.itemID}'/>").value;
		if(v=="" || isNaN(v) || v < 1) {
			invalidQTY=true;
		}
		document.getElementById("WC_MAddToCart_FormInput_quantity_<c:out value='${catalogEntryDB.itemID}'/>").value = v;
		<c:set var="runningCountInLoop" value="${iStatus.count}" />
	</c:forEach>
	
	<c:set var="numberOfProduct" value="${runningCountInLoop}" />
	<c:forEach var="compositeProduct" items="${bundle.bundledProducts}" varStatus="iStatus">
		<c:set var="catalogEntryDB" value="${compositeProduct.product}"/>
		var v = document.getElementById("quantity_<c:out value='${catalogEntryDB.productID}'/>").value;
		if(v=="" || isNaN(v) || v < 1) {
			invalidQTY=true;
		}
		document.getElementById("WC_MAddToCart_FormInput_quantity_<c:out value='${catalogEntryDB.productID}'/>").value = v;
		<c:set var="selectedIndex" value="0" />
		<c:forEach var="attribute" items="${catentry.catalogEntryAttributes.attributes}" varStatus="counter">
			<c:if test="${attribute.usage == 'Defining'}">
				<c:set var="selectedIndex" value="${selectedIndex+1}" />
				attrValue = document.getElementById("attrValue_<c:out value='${numberOfProduct + iStatus.count}'/>_${counter.count}").value;
				if(attrValue == "-n/a-") {
					document.getElementById("InputErrorMessage").value = "<c:out value="${ResolveSKUErrorMessage}" />"
					document.getElementById("InputError").submit();
					return;
				}
				document.getElementById("addToCart_attrValue_${numberOfProduct + iStatus.count}_${selectedIndex}").value = attrValue;
			</c:if>
		</c:forEach>
		<c:set var="runningCountInLoop" value="${numberOfProduct + iStatus.count}" />
	</c:forEach>
	
	<c:set var="numberOfProduct" value="${runningCountInLoop}" />
	<c:forEach var="compositePackage" items="${bundle.bundledPackages}" varStatus="iStatus">
		<c:set var="catalogEntryDB" value="${compositePackage.package}"/>
		var v = document.getElementById("quantity_<c:out value='${catalogEntryDB.packageID}'/>").value;
		if(v=="" || isNaN(v) || v < 1) {
			invalidQTY=true;
		}
		document.getElementById("WC_MAddToCart_FormInput_quantity_<c:out value='${catalogEntryDB.packageID}'/>").value = v;
	</c:forEach>
	
	if(invalidQTY) {
		document.getElementById("InputError").submit();
	}
	else {
		document.getElementById("AddToCartForm").submit();
	}
}
//]]> 
</script>
<!-- END CachedBundleDisplay.jsp -->
