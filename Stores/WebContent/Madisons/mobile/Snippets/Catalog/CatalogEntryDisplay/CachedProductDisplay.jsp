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
  * This JSP snippet displays the product details
  *****
--%>

<!-- BEGIN CachedProductDisplay.jsp -->

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>

<%@ include file="../../../include/JSTLEnvironmentSetup.jspf" %>
<%@ include file="../../../include/ErrorMessageSetup.jspf" %>

<c:set var="catalogEntryID" value="${param.productId}" />
<c:set var="type" value="product" />
<c:set var="dragType" value="item"/>

<wcbase:useBean id="product" classname="com.ibm.commerce.catalog.beans.ProductDataBean" scope="request">
	<c:set target="${product}" property="productID" value="${catalogEntryID}"/>
</wcbase:useBean>

<wcf:getData type="com.ibm.commerce.catalog.facade.datatypes.CatalogEntryType" var="catentry" expressionBuilder="getStoreCatalogEntryAttributesByID">
	<wcf:contextData name="storeId" data="${param.storeId}"/>
	<wcf:param name="catEntryId" value="${catalogEntryID}"/>
	<wcf:param name="dataLanguageIds" value="${WCParam.langId}"/>
</wcf:getData>

<%@ include file="SetCatEntrySequence.jspf" %>

<c:set var="isBuyable" value="true"/>
<c:if test="${empty product.maximumItemPrice || product.buyable == 0}">
	<c:set var="isBuyable" value="false"/>
</c:if>

<c:set var="search01" value="'"/>
<c:set var="replaceStr01" value="\\'"/>

<div id="product" class="content_box">
	<div class="heading_container">
	  	<h2><c:out value="${product.description.name}" escapeXml="false"/></h2><br/><br/>
	  	<p><fmt:message key="SKU" bundle="${storeText}" />: <c:out value="${product.partNumber}" escapeXml="false"/></p>
		<div class="clear_float"></div>
	</div>
				
	<span class="product">
		<c:choose>
			<c:when test="${!empty product.description.fullImage}">
				<img id="productMainImage" src="<c:out value='${product.objectPath}${product.description.fullImage}'/>" width="150" height="150" border="0" alt="<c:out value='${product.description.shortDescription}' />" />
			</c:when>
			<c:otherwise>
				<img id="productMainImage" src="<c:out value='${hostPath}${jspStoreImgDir}'/>images/NoImageIcon.jpg" width="150" height="150" border="0" alt="<c:out value='${product.description.shortDescription}'/>" />
			</c:otherwise>
		</c:choose>
	</span> 

	<dl>
		<c:set var="catalogEntryDB" value="${product}" />
		<c:set var="displayPriceRange" value="true"/>
	
		<dt><fmt:message key="PRICE" bundle="${storeText}"/></dt><dd><%@ include file="../../../Snippets/ReusableObjects/CatalogEntryPriceDisplay.jspf"%></dd>
		<c:if test="${isBuyable}">		
			<dt><label for="quantity"><fmt:message key="ITEM_QTY" bundle="${storeText}" /></label></dt><dd><input name="quantity" id="quantity" class="coloured_input" size="4" value="1" /></dd>
		</c:if>
	</dl>
	
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
		<input type="hidden" name="catEntryId_1" value="${product.productID}" id="WC_MAddToCart_FormInput_catEntryId" />
		<input type="hidden" name="URL" value="${OrderItemDisplayURL}" id="WC_MAddToCart_FormInput_URL" />
		<input type="hidden" name="catalogId" value="${WCParam.catalogId}" id="WC_MAddToCart_FormInput_catlogId" />
		<input type="hidden" name="storeId" value="${WCParam.storeId}" id="WC_MAddToCart_FormInput_storeId" />
		<input type="hidden" name="langId" value="${langId}" id="WC_MAddToCart_FormInput_langId" />
		<input type="hidden" name="quantity_1" value="1" id="WC_MAddToCart_FormInput_quantity" />
		<input type="hidden" name="productId" value="${product.productID}" id="WC_MAddToCart_FormInput_productId"/>
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
	
		<c:set var="selectedIndex" value="0" />
		<c:forEach var="attribute" items="${catentry.catalogEntryAttributes.attributes}" varStatus="counter">
				<c:if test="${attribute.usage == 'Defining'}">
					<c:set var="selectedIndex" value="${selectedIndex+1}" />
					<input type="hidden" id="addToCart_attrName_1_${selectedIndex}" name="attrName_1_${selectedIndex}" value="${attribute.attributeIdentifier.uniqueID}" />
					<input type="hidden" id="addToCart_attrValue_1_${selectedIndex}" name="attrValue_1_${selectedIndex}" value="" />
				</c:if>
		</c:forEach>	
	</form>
	
	<form id="InputError" method="post" action="mProductDisplayView">	
		<input type="hidden" name="errorView" value="true" />
		<input type="hidden" name="errorMessage" value="${QuantityErrorMessage}" id="InputErrorMessage" />

		<input type="hidden" name="productId" value="${product.productID}" />
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

	<c:set var="WishlistDisplayURL" value="InterestItemDisplay?URL=mInterestListDisplay&listId=." />
	<form method="post" action="InterestItemAdd" id="wishlist_add">
		<input type="hidden" name="URL" value="${WishlistDisplayURL}" />
		<input type="hidden" name="catEntryId" value="${product.productID}" />
		<input type="hidden" name="productId" value="${product.productID}" />
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

		<%-- 
	  		***
			*	Start:	Product Defining Attributes
			* 		The drop down box will only display defining attributes.
			* 		Defining attributes are properties of SKUs.  They are used for SKU resolution.
			***
		--%>


		<c:set var="selectedIndex" value="0" />
		<fieldset>				
			<c:forEach var="attribute" items="${catentry.catalogEntryAttributes.attributes}" varStatus="aStatus">
				<c:if test="${attribute.usage == 'Defining'}">
				<c:set var="selectedIndex" value="${selectedIndex+1}" />				
					<input type="hidden" name="attrName" value="<c:out value="${attribute.attributeIdentifier.uniqueID}" />" />
					<input type="hidden" name="attrNName" value="<c:out value="${attribute.name}" />" />
					<div class="dropdown_container">
						<div><label for="attrValue_<c:out value='${aStatus.count}'/>" class="nodisplay"><span class="field_required_symbol">*</span><c:out value='${attribute.name}'/></label></div>
						<select name="attrValue" id="attrValue_<c:out value='${aStatus.count}'/>" class="drop_down">
							<option value="-n/a-">
								<fmt:message key="SELECT_ATTRIBUTE" bundle="${storeText}">
									<fmt:param><c:out value="${fn:replace(attribute.name, search01, replaceStr01)}"/></fmt:param>
								</fmt:message>
							</option>
							<c:forEach var="allowedValue" items="${attribute.allowedValue}" varStatus="allowedValueStatus">
								<c:set var="optionValue" value="${fn:replace(allowedValue.value, search01, replaceStr01)}" />
								<c:choose>						
									<c:when test="${selectedValue != undefined and allowedValueStatus.count == selectedValue[selectedIndex]}">
										<option selected="selected" value='<c:out value="${optionValue}" />'>
											<c:out value="${optionValue}" />
										</option>
									</c:when>
									<c:otherwise>
										<option value='<c:out value="${optionValue}" />'>
											<c:out value="${optionValue}" />
										</option>
									</c:otherwise>							
								</c:choose>							
							</c:forEach>
						</select>						
					</div>
				</c:if>
			</c:forEach>
		</fieldset>
		<%-- 
		  	***
			*	End: Product Defining Attributes
			***
		--%>


	</form>

	<c:if test="${isBuyable}">
		<input type="button" onclick="javascript:submitAddToCart();" name="add_to_cart" id="add_to_cart" value="<fmt:message key="ADD_TO_CART" bundle="${storeText}" />" />

		<c:set var="entitledItems" value="${product.entitledItems}" />
		<c:if test="${!empty entitledItems and fn:length(entitledItems) > 1}">
			<c:set var="itemsAttributes" value="" />
			<c:forEach var="entitledItem" items="${entitledItems}">
				<c:set var="itemsAttributes" value="${itemsAttributes}${selValSeparator}itemID=${entitledItem.itemID}" />

				<c:forEach var="entitledItemAttribute" items="${entitledItem.definingAttributeValueDataBeans}">
					<c:set var="itemsAttributes" value="${itemsAttributes}${selValSeparator}${entitledItemAttribute.attributeDataBean.name}${entitledItemAttribute.value}" />
				</c:forEach>
				<c:set var="itemsAttributes" value="${itemsAttributes}${selValSeparator}" />
			</c:forEach>

			<form method="post" action="mProduct1" id="product_avail_refresh">
				<input type="hidden" name="catalogId" value="${WCParam.catalogId}" />
				<input type="hidden" name="storeId" value="${WCParam.storeId}" />
				<input type="hidden" name="productId" value="${catalogEntryID}" />
				<input type="hidden" name="langId" value="${langId}" />
				<input type="hidden" name="errorViewName" value="mProduct1" />
				<input type="hidden" name="top_category" value="${WCParam.top_category}" />
				<input type="hidden" name="parent_category_rn" value="${WCParam.parent_category_rn}" />
				<input type="hidden" name="categoryId" value="${WCParam.categoryId}" />
				<input type="hidden" name="pgGrp" value="${WCParam.pgGrp}" />
				<input type="hidden" name="selectedValues" value="" />
			</form>
			<fmt:message var="showStoreAvail" key="SHOW_STORE_AVAIL" bundle="${storeText}" />
			<p><span class="bullet">&#187; </span> <a href="#" onclick="javascript:resolveSKU('<c:out value="${itemsAttributes}" />', '<c:out value="${selValSeparator}" />');" title="${fn:escapeXml(showStoreAvail)}"><c:out value="${showStoreAvail}" /></a></p>
		</c:if>

		<wcf:url var="AddToProdCompare" value="mAddToProdCompare">
			<c:forEach var="parameter" items="${WCParamValues}">
				<c:forEach var="value" items="${parameter.value}">
					<c:if test="${parameter.key != 'catentryId' and parameter.key != 'productId'}">
						<wcf:param name="${parameter.key}" value="${value}" />
					</c:if>
				</c:forEach>
			</c:forEach>		
			<wcf:param name="catEntryId" value="${product.productID}"/>
			<wcf:param name="productId" value="${product.productID}"/>
		</wcf:url>					

		<ul>
			<li>
				<span class="bullet">&#187; </span>
				<a href="#" onclick="document.getElementById('wishlist_add').submit();" title="<fmt:message key="WISHLIST" bundle="${storeText}" />">
					<fmt:message key="WISHLIST" bundle="${storeText}" />
				</a>
			</li>		
			<li><span class="bullet">&#187; </span><a href="${fn:escapeXml(AddToProdCompare)}" title="<fmt:message key="SELECT_TO_COMPARE" bundle="${storeText}" />"><fmt:message key="SELECT_TO_COMPARE" bundle="${storeText}" /></a></li>
		</ul>

		<c:if test="${!empty entitledItems and fn:length(entitledItems) == 1}">
			<%out.flush();%>
			<c:import url="${jspStoreDir}mobile/Snippets/Catalog/CatalogEntryDisplay/ItemAvailability.jsp">
				<c:param name="itemId" value="${entitledItems[0].itemID}" />
			</c:import>
			<%out.flush();%>
		</c:if>
		<c:if test="${!empty entitledItems and fn:length(entitledItems) > 1 and selectedValue != undefined}">
			<%out.flush();%>
			<c:import url="${jspStoreDir}mobile/Snippets/Catalog/CatalogEntryDisplay/ItemAvailability.jsp">
				<c:param name="itemId" value="${selectedValue[0]}" />
			</c:import>
			<%out.flush();%>
		</c:if>
	</c:if>

	<div id="product_description" class="text_container">
		<h3><fmt:message key="DESCRIPTION" bundle="${storeText}" />:</h3>
		<p><c:out value="${product.description.longDescription}" escapeXml="false"/></p>
	</div>

	<%@ include file="ProductQuickNavigation.jspf" %>	
</div>



<script type="text/javascript">
//<![CDATA[

function resolveSKU(itemsAttributes, strSeparator){
	var itemAttributes = itemsAttributes.split(strSeparator + "itemID=");

	var fromForm = document.getElementById("wishlist_add");
	var attrNName = fromForm.attrNName;
	var attrValue = fromForm.attrValue;

	var toForm = document.getElementById("product_avail_refresh");

	var selectedAttrNameValue = new Array();
	var selectedAttrValues = "";

	if (attrNName.length == undefined) {
		selectedAttrNameValue[0] = attrNName.value + attrValue.options[attrValue.selectedIndex].value;
		selectedAttrValues = attrValue.selectedIndex;
	}
	else {
		for (i=0; i<attrNName.length; i++) {
			selectedAttrNameValue[i] = attrNName[i].value + attrValue[i].options[attrValue[i].selectedIndex].value;
			selectedAttrValues = selectedAttrValues + strSeparator + attrValue[i].selectedIndex;
		}
	}	

	var itemIdFound = "";
	for (i=0; i<itemAttributes.length; i++) {
		var found = true;
		for (j=0; j<selectedAttrNameValue.length; j++) {
			if (itemAttributes[i].indexOf(selectedAttrNameValue[j]) < 0) {
				found = false;
			}
		}

		if (found) {
			var foundItem = itemAttributes[i].split(strSeparator);
			itemIdFound = foundItem[0];
			toForm.selectedValues.value = foundItem[0] + strSeparator + selectedAttrValues;
			i = itemAttributes.length;
		}
	}

	if (found) {
		toForm.submit();
	}
}

function submitAddToCart() {
	var attrValue;
	var v = document.getElementById("quantity").value;
	document.getElementById("WC_MAddToCart_FormInput_quantity").value = v;

	<c:set var="selectedIndex" value="0" />
	<c:forEach var="attribute" items="${catentry.catalogEntryAttributes.attributes}" varStatus="counter">
		<c:if test="${attribute.usage == 'Defining'}">
			<c:set var="selectedIndex" value="${selectedIndex+1}" />
			attrValue = document.getElementById("attrValue_${counter.count}").value;
			if(attrValue == "-n/a-") {
				document.getElementById("InputErrorMessage").value = "<c:out value="${ResolveSKUErrorMessage}" />"
				document.getElementById("InputError").submit();
				return;
			}
			document.getElementById("addToCart_attrValue_1_${selectedIndex}").value = attrValue;
		</c:if>
	</c:forEach>	

	if(v=="" || isNaN(v) || v < 1) {
		document.getElementById("InputError").submit();
	}
	else {
		document.getElementById("AddToCartForm").submit();
	}
}
//]]> 
</script>

<!-- END CachedProductDisplay.jsp -->
