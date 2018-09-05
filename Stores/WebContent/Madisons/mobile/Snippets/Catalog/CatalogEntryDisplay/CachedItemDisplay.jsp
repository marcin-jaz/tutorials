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
  * This JSP snippet displays the item details
  *****
--%>

<!-- BEGIN CachedItemDisplay.jsp -->

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>

<%@ include file="../../../include/JSTLEnvironmentSetup.jspf" %>
<%@ include file="../../../include/ErrorMessageSetup.jspf" %>

<wcbase:useBean id="item" classname="com.ibm.commerce.catalog.beans.ItemDataBean" scope="request">
        <c:set target="${item}" property="itemID" value="${param.productId}"/>
</wcbase:useBean>

<c:set var="type" value="item" />
<c:set var="dragType" value="item"/>

<%@ include file="SetCatEntrySequence.jspf" %>

<c:set var="isBuyable" value="true"/>
<c:if test="${item.buyable == 0}">
	<c:set var="isBuyable" value="false"/>
</c:if>

<div id="product" class="content_box">
		  <h2><c:out value="${item.description.name}" escapeXml="false"/></h2><br/><br/>
		  <p><fmt:message key="SKU" bundle="${storeText}" />: <c:out value="${item.partNumber}" escapeXml="false"/></p>
	<div class="clear_float"></div>
				
	<span class="product">
		<c:choose>
			<c:when test="${!empty item.description.fullImage}">
				<img id="productMainImage" src="<c:out value="${item.objectPath}${item.description.fullImage}"/>" width="150" height="150" border="0" alt="<c:out value="${item.description.shortDescription}"/>" />
			</c:when>
			<c:otherwise>
				<img id="productMainImage" src="<c:out value="${hostPath}${jspStoreImgDir}"/>images/NoImageIcon.jpg" width="150" height="150" border="0" alt="<c:out value="${item.description.shortDescription}"/>" />
			</c:otherwise>
		</c:choose>
	</span> 
	<ul>
		<li>
			<div class="left">
				<c:set var="catalogEntryDB" value="${item}" />
				<c:set var="displayPriceRange" value="true"/>
				<dl>
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

				<c:if test="${isBuyable}">
					<input type="button" onclick="javascript:submitAddToCart();" name="add_to_cart" id="add_to_cart" value="<fmt:message key="ADD_TO_CART" bundle="${storeText}" />" />
				</c:if>
			</div>
		</li>

		<c:if test="${isBuyable}">	
			<c:set var="WishlistDisplayURL" value="InterestItemDisplay?URL=mInterestListDisplay&listId=." />
			<wcf:url var="AddToWishlist" value="InterestItemAdd">
				<wcf:param name="catEntryId" value="${item.itemID}"/>
				<wcf:param name="URL" value="${WishlistDisplayURL}"/>
				<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
				<wcf:param name="storeId" value="${WCParam.storeId}"/>
				<wcf:param name="langId" value="${langId}"/>
				<c:if test="${WCParam.pgGrp == 'catNav'}">
					<wcf:param name="parent_category_rn" value="${WCParam.parent_category_rn}"/>
					<wcf:param name="top_category" value="${WCParam.top_category}"/>
					<wcf:param name="sequence" value="${WCParam.sequence}"/>
					<wcf:param name="categoryId" value="${WCParam.categoryId}"/>
				</c:if>
				<c:if test="${WCParam.pgGrp == 'search'}">
					<wcf:param name="pageSize" value="${WCParam.pageSize}"/>
					<wcf:param name="resultCatEntryType" value="${WCParam.resultCatEntryType}"/>
					<wcf:param name="searchTerm" value="${WCParam.searchTerm}"/>
					<wcf:param name="beginIndex" value="${WCParam.beginIndex}"/>
					<wcf:param name="sType" value="${WCParam.sType}"/>
				</c:if>					
				<wcf:param name="pgGrp" value="${WCParam.pgGrp}"/>		
			</wcf:url>		

			<wcf:url var="AddToProdCompare" value="mAddToProdCompare">
				<c:forEach var="parameter" items="${WCParamValues}">
					<c:forEach var="value" items="${parameter.value}">
						<c:if test="${parameter.key != 'catentryId' and parameter.key != 'productId'}">
							<wcf:param name="${parameter.key}" value="${value}" />
						</c:if>
					</c:forEach>
				</c:forEach>		
				<wcf:param name="catEntryId" value="${item.parentProductId}"/>
				<wcf:param name="productId" value="${item.parentProductId}"/>
			</wcf:url>						

			<li><span class="bullet">&#187; </span><a href="${fn:escapeXml(AddToWishlist)}" title="<fmt:message key="WISHLIST" bundle="${storeText}" />"><fmt:message key="WISHLIST" bundle="${storeText}" /></a></li>
			<li><span class="bullet">&#187; </span><a href="${fn:escapeXml(AddToProdCompare)}" title="<fmt:message key="SELECT_TO_COMPARE" bundle="${storeText}" />"><fmt:message key="SELECT_TO_COMPARE" bundle="${storeText}" /></a></li>

			<li>
				<%out.flush();%>
				<c:import url="${jspStoreDir}mobile/Snippets/Catalog/CatalogEntryDisplay/ItemAvailability.jsp">
					<c:param name="itemId" value="${item.itemID}" />
				</c:import>
				<%out.flush();%>
			</li>

		</c:if>
	</ul>
				
	<div id="product_description" class="text_container">
		<h3><fmt:message key="DESCRIPTION" bundle="${storeText}" />:</h3>
		<p><c:out value="${item.description.longDescription}" escapeXml="false"/></p>
	</div>
					
	<%@ include file="ProductQuickNavigation.jspf" %>	
</div>

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
	<input type="hidden" name="catEntryId_1" value="${item.itemID}" id="WC_MAddToCart_FormInput_catEntryId" />
	<input type="hidden" name="URL" value="${OrderItemDisplayURL}" id="WC_MAddToCart_FormInput_URL" />
	<input type="hidden" name="catalogId" value="${WCParam.catalogId}" id="WC_MAddToCart_FormInput_catlogId" />
	<input type="hidden" name="storeId" value="${WCParam.storeId}" id="WC_MAddToCart_FormInput_storeId" />
	<input type="hidden" name="langId" value="${langId}" id="WC_MAddToCart_FormInput_langId" />
	<input type="hidden" name="quantity_1" value="1" id="WC_MAddToCart_FormInput_quantity" />
	<input type="hidden" name="productId" value="${item.itemID}" id="WC_MAddToCart_FormInput_productId"/>
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
</form>

<form id="InputError" method="post" action="mProductDisplayView">	
	<input type="hidden" name="errorView" value="true" />
	<input type="hidden" name="errorMessage" value="${QuantityErrorMessage}" id="InputErrorMessage" />
	<input type="hidden" name="productId" value="${item.itemID}" />
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

<script type="text/javascript">
//<![CDATA[
function submitAddToCart() {
	var v = document.getElementById("quantity").value;
	document.getElementById("WC_MAddToCart_FormInput_quantity").value = v;
	
	if(v=="" || isNaN(v) || v < 1) {
		document.getElementById("InputError").submit();
	}
	else {
		document.getElementById("AddToCartForm").submit();
	}
}
//]]> 
</script>


<!-- END CachedItemDisplay.jsp -->
