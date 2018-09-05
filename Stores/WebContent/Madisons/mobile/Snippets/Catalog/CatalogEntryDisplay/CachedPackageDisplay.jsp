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
  * This JSP snippet displays the package details
  *****
--%>


<!-- BEGIN CachedPackageDisplay.jsp -->

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>

<%@ include file="../../../include/JSTLEnvironmentSetup.jspf" %>
<%@ include file="../../../include/ErrorMessageSetup.jspf" %>

<wcbase:useBean id="packageDataBean" classname="com.ibm.commerce.catalog.beans.PackageDataBean" scope="request">
	<c:set target="${packageDataBean}" property="packageID" value="${param.productId}"/>
</wcbase:useBean>

<c:set var="dragType" value="package"/>
<c:set var="type" value="package" />

<%@ include file="SetCatEntrySequence.jspf" %>

<c:set var="isBuyable" value="true"/>
<c:if test="${(!packageDataBean.calculatedContractPriced || packageDataBean.buyable == 0)}">
	<c:set var="isBuyable" value="false"/>
</c:if>

<div id="product" class="content_box">
	<h2><c:out value="${packageDataBean.description.name}" escapeXml="false"/></h2><br/><br/>
	<p><fmt:message key="SKU" bundle="${storeText}" />: <c:out value="${packageDataBean.partNumber}" escapeXml="false"/></p>
	<div class="clear_float"></div>

	<span class="product">
		<c:choose>
			<c:when test="${!empty packageDataBean.description.fullImage}">
				<img id="productMainImage" src="<c:out value='${packageDataBean.objectPath}${packageDataBean.description.fullImage}'/>" width="150" height="150" border="0" alt="<c:out value='${packageDataBean.description.shortDescription}' />" />
			</c:when>
			<c:otherwise>
				<img id="productMainImage" src="<c:out value='${hostPath}${jspStoreImgDir}'/>images/NoImageIcon.jpg" width="150" height="150" border="0" alt="<c:out value='${packageDataBean.description.shortDescription}'/>" />
			</c:otherwise>
		</c:choose>
	</span> 

	<ul>
		<li>
			<div class="left">
				<fmt:message key="PRICE" bundle="${storeText}"/>
				<c:set var="catalogEntryDB" value="${packageDataBean}" />
				<c:set var="displayPriceRange" value="true"/>
				<%@ include file="../../../Snippets/ReusableObjects/CatalogEntryPriceDisplay.jspf"%>
			</div>
		</li>
		<c:if test="${isBuyable}">
			<li>				
				<label for="quantity"><fmt:message key="ITEM_QTY" bundle="${storeText}" /></label>
				<input name="quantity" id="quantity" class="coloured_input" size="4" value="1" />
			</li>

			<c:choose>
				<c:when test="${!empty WCParam.errorMessage && WCParam.errorView=='true'}">
					<p class="error"><c:out value="${WCParam.errorMessage}" /></p>
				</c:when>
				<c:when test="${!empty errorMessage}">
					<p class="error"><c:out value="${errorMessage}" /></p>
				</c:when>		
			</c:choose>

			<input type="button" onclick="javascript:submitAddToCart();" name="add_to_cart" id="add_to_cart" value="<fmt:message key="ADD_TO_CART" bundle="${storeText}" />" />
			<li>
				<span class="bullet">&#187; </span>
				<a href="#" onclick="document.getElementById('wishlist_add').submit();" title="<fmt:message key="WISHLIST" bundle="${storeText}" />"><fmt:message key="WISHLIST" bundle="${storeText}" /></a>
			</li>
	
			<wcf:url var="AddToProdCompare" value="mAddToProdCompare">
				<c:forEach var="parameter" items="${WCParamValues}">
					<c:forEach var="value" items="${parameter.value}">
						<c:if test="${parameter.key != 'catentryId' and parameter.key != 'productId'}">
							<wcf:param name="${parameter.key}" value="${value}" />
						</c:if>
					</c:forEach>
				</c:forEach>		
				<wcf:param name="catEntryId" value="${packageDataBean.packageID}"/>
				<wcf:param name="productId" value="${packageDataBean.packageID}"/>
			</wcf:url>						
	
			<li>
				<span class="bullet">&#187; </span>
				<a href="${fn:escapeXml(AddToProdCompare)}" title="<fmt:message key="SELECT_TO_COMPARE" bundle="${storeText}" />"><fmt:message key="SELECT_TO_COMPARE" bundle="${storeText}" /></a>
			</li>
		</c:if>
	</ul>

	<c:if test="${isBuyable}">
		<%out.flush();%>
		<c:import url="${jspStoreDir}mobile/Snippets/Catalog/CatalogEntryDisplay/ItemAvailability.jsp">
			<c:param name="itemId" value="${packageDataBean.packageID}" />
		</c:import>
		<%out.flush();%>
	</c:if>
				
	<div id="product_description_1" class="text_container">
		<h3><fmt:message key="DESCRIPTION" bundle="${storeText}" />:</h3>
		<p><c:out value="${packageDataBean.description.longDescription}" escapeXml="false"/></p>
	</div>

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
	<input type="hidden" name="catEntryId_1" value="${packageDataBean.packageID}" id="WC_MAddToCart_FormInput_catEntryId" />
	<input type="hidden" name="URL" value="${OrderItemDisplayURL}" id="WC_MAddToCart_FormInput_URL" />
	<input type="hidden" name="catalogId" value="${WCParam.catalogId}" id="WC_MAddToCart_FormInput_catlogId" />
	<input type="hidden" name="storeId" value="${WCParam.storeId}" id="WC_MAddToCart_FormInput_storeId" />
	<input type="hidden" name="langId" value="${langId}" id="WC_MAddToCart_FormInput_langId" />
	<input type="hidden" name="quantity_1" value="1" id="WC_MAddToCart_FormInput_quantity" />
	<input type="hidden" name="productId" value="${packageDataBean.packageID}" id="WC_MAddToCart_FormInput_productId"/>
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
	<input type="hidden" name="productId" value="${packageDataBean.packageID}" />
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
	<input type="hidden" name="catEntryId" value="${packageDataBean.packageID}" />
	<input type="hidden" name="productId" value="${packageDataBean.packageID}" />
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
			
	<div id="product_package_breakdown">

	<%-- 
	  ***
	  *	Start: List the information of the items that compose the package
	  ***
	--%>
	<c:forEach var="compositeItem" items="${packageDataBean.packagedItems}" varStatus="status">
		<c:url var="ProductDisplayURL" value="ProductDisplay">
			<c:param name="productId" value="${compositeItem.item.itemID}" />
			<c:param name="langId" value="${langId}" />
			<c:param name="storeId" value="${WCParam.storeId}" />
			<c:param name="catalogId" value="${WCParam.catalogId}" />
			<c:if test="${ !empty WCParam.parent_category_rn }" >
				<c:param name="parent_category_rn" value="${WCParam.parent_category_rn}" />
			</c:if>
		</c:url>
		<wcf:url var="catEntryDisplayUrl" value="mProduct2">
			<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
			<wcf:param name="storeId" value="${WCParam.storeId}"/>
			<wcf:param name="productId" value="${compositeItem.item.itemID}"/>
			<wcf:param name="langId" value="${langId}"/>
			<wcf:param name="categoryId" value="${WCParam.categoryId}"/>
			<wcf:param name="pgGrp" value="${WCParam.pgGrp}"/>
		</wcf:url>							
		<c:set var="catalogEntryDB" value="${compositeItem.item}"/>
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
						<c:set var="displayPriceRange" value="true"/>
						<%@ include file="../../../Snippets/ReusableObjects/CatalogEntryPriceDisplay.jspf"%>
					</div>
				</li>
				<li><fmt:message key="QUANTITY" bundle="${storeText}"/>: <c:out value="${compositeItem.formattedQuantity}" /></li>
			</ul>
						
			<div id="product_description_3" class="text_container">
				<h3><fmt:message key="DESCRIPTION" bundle="${storeText}" />:</h3>
				<p><c:out value="${catalogEntryDB.description.longDescription}" escapeXml="false"/></p>
			</div>
		</div>
	</c:forEach>
	<%-- 
	  ***
	  *	End: List the information of the items that compose the package
	  ***
	--%>

	<%-- 
	 ***
	 *	Start: List the information of the products that compose the package
	 ***
	--%>
	
	<c:forEach var="compositeProduct" items="${packageDataBean.packagedProducts}" varStatus="status">	
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
		<div id="product_bundles_breakdown_2" class="content_box">
			<div class="heading_container">
			  <h2><fmt:message key="ITEM_TITLE1" bundle="${storeText}"/> <c:out value="${catalogEntryDB.description.name}" /></h2><br/><br/>
				<p><fmt:message key="SKU" bundle="${storeText}" />: <c:out value="${catalogEntryDB.partNumber}" escapeXml="false"/></p>		
				<div class="clear_float"></div>
			</div>
			<span class="product">
				<c:choose>
					<c:when test="${!empty catalogEntryDB.description.thumbNail}">
						<img src="<c:out value='${catalogEntryDB.objectPath}${catalogEntryDB.description.thumbNail}￿' />" alt="<c:out value='${catalogEntryDB.description.name}' />" hspace="5" border="0"/>
					</c:when>
					<c:otherwise>
						<img src="<c:out value='${jspStoreImgDir}'/>images/NoImageIcon_sm.jpg" alt="<fmt:message key='No_Image' bundle='${storeText}'/>" hspace="5" border="0"/>						
					</c:otherwise>
				</c:choose>
			</span> 
			<ul>
				<li>
					<div class="left">
						<fmt:message key="PRICE" bundle="${storeText}"/>
						<c:set var="type" value="product"/>
						<c:set var="displayPriceRange" value="true"/>
						<%@ include file="../../../Snippets/ReusableObjects/CatalogEntryPriceDisplay.jspf"%>
					</div>
				</li>
				<li><fmt:message key="QUANTITY" bundle="${storeText}"/>: <c:out value="${compositeProduct.formattedQuantity}" /></li>				
			</ul>
						
			<div id="product_description_2" class="text_container">
				<h3><fmt:message key="DESCRIPTION" bundle="${storeText}" />:</h3>
				<p><c:out value="${catalogEntryDB.description.longDescription}" escapeXml="false"/></p>
			</div>
		</div>		
	</c:forEach>
	
	<%-- 
	 ***
	 *	End: List the information of the products that compose the package
	 ***
	--%>
						
	<%@ include file="ProductQuickNavigation.jspf" %>		
	</div>

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
<!-- END CachedPackageDisplay.jsp -->
