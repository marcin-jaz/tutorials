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
  * This JSP snippet fetches and displays the search result details
  *****
--%>

<!-- BEGIN CatalogSearchResultOnlyDisplay.jsp -->

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>

<wcbase:useBean id="catEntSearchListBean" scope="page" classname="com.ibm.commerce.search.beans.CatEntrySearchListDataBean">
	<jsp:setProperty property="*" name="catEntSearchListBean" />
	<%-- Set the kind of Catalog Entries to show --%>
	<c:choose>
		<%-- resultCatEntryType 2 stands for searching product but not item --%>
		<c:when test="${WCParam.resultCatEntryType == 2}">
			<c:set property="isProduct" value="true" target="${catEntSearchListBean}" />
			<c:set property="isItem" value="false" target="${catEntSearchListBean}" />
		</c:when>
		<%-- resultCatEntryType 1 stands for searching item, but not product --%>
		<c:when test="${WCParam.resultCatEntryType == 1}">
			<c:set property="isProduct" value="false" target="${catEntSearchListBean}" />
			<c:set property="isItem" value="true" target="${catEntSearchListBean}" />
		</c:when>
		<%-- Otherwise, search for both item and product --%>
		<c:otherwise>
			<c:set property="isProduct" value="true" target="${catEntSearchListBean}" />
			<c:set property="isItem" value="true" target="${catEntSearchListBean}" />
		</c:otherwise>
	</c:choose>
				
	<%-- always search for bundles and packages --%>
	<c:set property="isBundle" value="true" target="${catEntSearchListBean}" />
	<c:set property="isPackage" value="true" target="${catEntSearchListBean}" />
	<%-- Set the sort order to sort by CatEntDescName --%>
	<c:set property="orderBy1" value="CatEntDescName" target="${catEntSearchListBean}" />
	<%-- Set the search Term --%>
	<c:set property="searchTerm" value="${WCParam.searchTerm}" target="${catEntSearchListBean}" />
</wcbase:useBean>

<c:set var="totalCount" value="${catEntSearchListBean.resultCount}"/>
<c:if test="${empty catEntSearchListBean.resultList || totalCount == 0}">
	<c:remove var="catEntSearchListBean" />
	<wcbase:useBean id="catEntSearchListBean" scope="page" classname="com.ibm.commerce.search.beans.CatEntrySearchListDataBean">
		<jsp:setProperty property="*" name="catEntSearchListBean" />
		<%-- Set the kind of Catalog Entries to show --%>
		<c:choose>
			<%-- resultCatEntryType 2 stands for searching product but not item --%>
			<c:when test="${WCParam.resultCatEntryType == 2}">
				<c:set property="isProduct" value="true" target="${catEntSearchListBean}" />
				<c:set property="isItem" value="false" target="${catEntSearchListBean}" />
			</c:when>
			<%-- resultCatEntryType 1 stands for searching item, but not product --%>
			<c:when test="${WCParam.resultCatEntryType == 1}">
				<c:set property="isProduct" value="false" target="${catEntSearchListBean}" />
				<c:set property="isItem" value="true" target="${catEntSearchListBean}" />
			</c:when>
			<%-- Otherwise, search for both item and product --%>
			<c:otherwise>
				<c:set property="isProduct" value="true" target="${catEntSearchListBean}" />
				<c:set property="isItem" value="true" target="${catEntSearchListBean}" />
			</c:otherwise>
		</c:choose>
					
		<%-- always search for bundles and packages --%>
		<c:set property="isBundle" value="true" target="${catEntSearchListBean}" />
		<c:set property="isPackage" value="true" target="${catEntSearchListBean}" />
		<%-- Set the sort order to sort by CatEntDescName --%>
		<c:set property="orderBy1" value="CatEntDescName" target="${catEntSearchListBean}" />
		
		<%-- Set the search by SKU --%>
		<c:set property="coSearchSkuEnabled" value="true" target="${catEntSearchListBean}" />
		<c:set property="sku" value="${WCParam.searchTerm}" target="${catEntSearchListBean}" />
		<c:set property="skuCaseSensitive" value="no" target="${catEntSearchListBean}" />
	</wcbase:useBean>
</c:if>

<%-- total number of search result. This number will be used to decide how many pages
	should be used to display all the search results
--%>
<c:set var="totalCount" value="${catEntSearchListBean.resultCount}"/>

<c:set var="numEntries" value="${totalCount}"/>
<c:set var="pageSize" value="${param.pageSize}"/>
<c:if test="${empty pageSize}">
<c:set var="pageSize" value="${searchResultsMaxPageSize}"/>
</c:if>
<c:if test="${empty beginIndex}">
	<c:set var="beginIndex" value="0"/>
</c:if>	
	
<%-- Check to see if there are no results.  Make sure this is the first set of results --%>
<c:choose>
	<%-- If there are no items found, only display a message that indicates no item is found --%>
	<c:when test="${empty catEntSearchListBean.resultList || totalCount == 0}">
		<div id="search_results" class="content_box">
			<div class="heading_container_with_underline">
				<h2><fmt:message key="TITLE_SEARCH_RESULTS" bundle="${storeText}"/></h2>
				<div class="clear_float"></div>
			</div>
			<p>
				<span class="strong">
					<fmt:message key="SEARCH_NO_RESULTS" bundle="${storeText}"/><br/>
				</span>
			</p>
		</div>
	</c:when>

	<%-- If there are items in the search result, then first decide how many pages should be used --%>
	<c:otherwise>	
		<%-- Output what the user searched on at the top of the search results page --%>
		<c:choose>
			<c:when test="${resultCountOnPage > totalCount}">
				<c:set var="resultCountOnPage" value="${totalCount}"/>
			</c:when>
		</c:choose>
			
		<div id="search_results" class="content_box">
			<div class="heading_container_with_underline">
				<h2><fmt:message key="TITLE_SEARCH_RESULTS" bundle="${storeText}"/></h2>
				<div class="clear_float"></div>
			</div>
				
			<p>
				<fmt:message key="SEARCHED_ITEMS_FOUND_FOR" bundle="${storeText}">
					<fmt:param value="${catEntSearchListBean.beginIndex + 1}"/>
					<fmt:param value="${catEntSearchListBean.endIndex + 1}"/>				
					<fmt:param value="${totalCount}"/>									
				</fmt:message> 			
				<%-- 				
				<c:out value="${beginIndex+1}" /> - <c:out value="${endIndex}" /> of <c:out value="${totalCount}" /> items found for 
				--%>
				
				<%-- output the search term if the user entered a search term else output the 'search all products' message if no search term was searched on --%>

				<c:choose>
					<c:when test="${!empty WCParam.searchTerm}">
						<c:set var="outputSrchTerm">
							<c:out value="${WCParam.searchTerm}" escapeXml="false"/>
						</c:set>
					</c:when>
					<c:otherwise>
						<c:set var="outputSrchTerm">
							<fmt:message key="SEARCH_ALL_PRODUCTS" bundle="${storeText}"/>
						</c:set>					
					</c:otherwise>
				</c:choose>
				<span class="bold">"<c:out value="${outputSrchTerm}" escapeXml="true"/>"</span>
			</p>
			
			<c:set var="prevPageIndex" value="${catEntSearchListBean.beginIndex - pageSize}"/>
			<c:choose>
				<c:when test="${!catEntSearchListBean.previousPageExists}">
					<c:set var="prevPageIndex" value="0"/>
				</c:when>
			</c:choose>
			<c:set var="nextPageIndex" value="${catEntSearchListBean.endIndex + 1}"/>
			<c:choose>
				<c:when test="${!catEntSearchListBean.nextPageExists}">
					<c:set var="nextPageIndex" value="${catEntSearchListBean.beginIndex}"/>
				</c:when>
			</c:choose>	

			
			<ol start="<c:out value="${catEntSearchListBean.beginIndex + 1}"/>">
				<c:forEach var="catEntry" items="${catEntSearchListBean.resultList}" varStatus="counter">
					<c:set property="commandContext" value="${catEntSearchListBean.commandContext}" target="${catEntry}"/>
					<c:choose>
						<c:when test="${catEntry.product}">
							<%-- convert the catEntry to the product bean --%>
							<c:set var="product" value="${catEntry.productDataBean}"/>
							<%-- The URL that links to the product display page --%>
							<wcf:url var="productDisplayUrl" value="mProduct3">
								<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
								<wcf:param name="storeId" value="${WCParam.storeId}"/>
								<wcf:param name="productId" value="${product.productID}"/>
								<wcf:param name="langId" value="${langId}"/>
								<wcf:param name="pgGrp" value="search"/>
								<wcf:param name="resultCatEntryType" value="${WCParam.resultCatEntryType}"/>
								<wcf:param name="pageSize" value="${pageSize}"/>
								<wcf:param name="searchTerm" value="${WCParam.searchTerm}"/>
								<wcf:param name="beginIndex" value="${catEntSearchListBean.beginIndex}"/>
								<wcf:param name="sType" value="${WCParam.sType}"/>
							</wcf:url>
							<li>
							<div class="container">		
	
								<a href="${fn:escapeXml(productDisplayUrl)}">
								<c:choose>
									<c:when test="${!empty product.description.thumbNail}">
										<span class="t_img_border"><img src="<c:out value="${product.objectPath}"/><c:out value="${product.description.thumbNail}"/>" alt="<c:out value="${product.description.shortDescription}" />" border="0" width="45" height="45"/></span>
									</c:when>
									<c:otherwise>
										<img src="<c:out value="${jspStoreImgDir}" />images/NoImageIcon_sm.jpg" alt="<fmt:message key="No_Image" bundle="${storeText}"/>" border="0" width="45" height="45"/>
									</c:otherwise>
								</c:choose>
								</a>
								<ul>	
								<li>
									<span class="bullet">&#187; </span>
									<a href="${fn:escapeXml(productDisplayUrl)}">
										<c:out value="${product.description.name}" escapeXml="false"/>
									</a>
								</li>
								<%-- 
								<li>
									<span>&#160;&#160;&#160;<c:out value="${product.description.shortDescription}" escapeXml="false"/></span>
								</li>
								--%>	
								<li>
									<span>&#160;&#160;&#160;<fmt:message key="SKU" bundle="${storeText}" />: <c:out value="${product.partNumber}" escapeXml="false"/></span>
								</li>									
								<li>
									<c:choose>
										<%-- If there is no price for any of the product items, the product is not
										buyable. Therefore, there will be no available price
										--%>
										<c:when test="${empty product.minimumItemPrice}">
											<c:set var="productPriceString"><fmt:message key="NO_PRICE_AVAILABLE" bundle="${storeText}" /></c:set>
										</c:when>
															
										<%-- If there is no price range but there is item price for the product, then
										     the item price will be displayed. 
										--%>			
										<c:when test="${ product.maximumItemPrice.amount == product.minimumItemPrice.amount}" >
											<c:set var="productPriceString" value="${product.minimumItemPrice}" />
										</c:when>
																	
										<%-- If there is price range for the product items, the price range will be displayed --%>
										<c:otherwise>
											<c:set var="productPriceString" value="${product.minimumItemPrice} - ${product.maximumItemPrice}" />
										</c:otherwise>
									</c:choose>							
																	
									<%-- Determine if the list price will be displayed along with the product's offer price --%>
									<c:choose>
										<%-- show the list price only if it is larger than the product price and the product does not have price range (i.e. min price == max price) --%>
										<c:when test="${ product.listPriced && (!empty product.maximumItemPrice) && (product.maximumItemPrice.amount < product.listPrice.amount) && (product.maximumItemPrice.amount == product.minimumItemPrice.amount)}" >
											&#160;&#160;&#160;<span class="listprice"><c:out value="${product.listPrice}" escapeXml="false"/></span>
											<br />
											<span class="price">&#160;&#160;&#160;
												<c:out value="${productPriceString}" escapeXml="false"/>
											</span>								
										</c:when>
										<c:otherwise>
											<span class="price">&#160;&#160;&#160;
												<c:out value="${productPriceString}" escapeXml="false"/>
											</span>								
										</c:otherwise>
									</c:choose>					
								</li>
							</ul>
							</div>
							<div class="clear_float"></div>						 				 
						</li>
					</c:when>	
					<c:when test="${catEntry.item}">
						<c:set var="item" value="${catEntry.itemDataBean}"/>
						<wcf:url var="itemDisplayUrl" value="mProduct3">
							<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
							<wcf:param name="storeId" value="${WCParam.storeId}"/>
							<wcf:param name="productId" value="${item.itemID}"/>
							<wcf:param name="langId" value="${langId}"/>
							<wcf:param name="pgGrp" value="search"/>
							<wcf:param name="resultCatEntryType" value="${WCParam.resultCatEntryType}"/>
							<wcf:param name="pageSize" value="${pageSize}"/>
							<wcf:param name="searchTerm" value="${WCParam.searchTerm}"/>
							<wcf:param name="beginIndex" value="${catEntSearchListBean.beginIndex}"/>
							<wcf:param name="sType" value="${WCParam.sType}"/>
						</wcf:url>						
						<li>
						<div class="container">
							
							<a href="${fn:escapeXml(itemDisplayUrl)}">
								<c:choose>
									<c:when test="${!empty item.description.thumbNail}">
										<span class="t_img_border"><img src="<c:out value="${item.objectPath}"/><c:out value="${item.description.thumbNail}"/>" alt="<c:out value="${item.description.shortDescription}" />" border="0" width="45" height="45"/></span>
									</c:when>
									<c:otherwise>
										<img src="<c:out value="${jspStoreImgDir}" />images/NoImageIcon_sm.jpg" alt="<fmt:message key="No_Image" bundle="${storeText}"/>" border="0" width="45" height="45"/>
									</c:otherwise>
								</c:choose>
							</a>
						
						<ul>
							<li>
								<span class="bullet">&#187; </span>
								<a href="${fn:escapeXml(itemDisplayUrl)}"><c:out value="${item.description.name}" escapeXml="false"/></a>
							</li>
							<%-- 
							<li>
								<span>&#160;&#160;&#160;<c:out value="${item.description.shortDescription}" escapeXml="false"/></span>
							</li>
							--%>	
							<li>
								<span>&#160;&#160;&#160;<fmt:message key="SKU" bundle="${storeText}" />: <c:out value="${item.partNumber}" escapeXml="false"/></span>
							</li>								
							<li>
								<c:choose>
									<c:when test="${ item.listPriced && item.calculatedContractPriced && (item.calculatedContractPrice.amount < item.listPrice.amount)}" >
										&#160;&#160;&#160;<span class="listprice"><c:out value="${item.listPrice}" escapeXml="false"/></span>	
										<br />
										<span class="price">&#160;&#160;&#160;<c:out value="${item.calculatedContractPrice}" escapeXml="false"/></span>
									</c:when>
									<c:otherwise>
										<span class="price">&#160;&#160;&#160;<c:out value="${item.calculatedContractPrice}" escapeXml="false"/></span>
									</c:otherwise>
								</c:choose>										
							</li>
						</ul>
			 			</div>
						<div class="clear_float"></div>						 
						</li>			
					</c:when>
					<c:when test="${catEntry.bundle}">
						<c:set var="bundle" value="${catEntry.bundleDataBean}"/>
						<%-- The URL that links to the product display page for the item --%>
						<wcf:url var="bundleDisplayUrl" value="mProduct3">
							<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
							<wcf:param name="storeId" value="${WCParam.storeId}"/>
							<wcf:param name="productId" value="${bundle.bundleID}"/>
							<wcf:param name="langId" value="${langId}"/>
							<wcf:param name="pgGrp" value="search"/>
							<wcf:param name="resultCatEntryType" value="${WCParam.resultCatEntryType}"/>
							<wcf:param name="pageSize" value="${pageSize}"/>
							<wcf:param name="searchTerm" value="${WCParam.searchTerm}"/>
							<wcf:param name="beginIndex" value="${catEntSearchListBean.beginIndex}"/>
							<wcf:param name="sType" value="${WCParam.sType}"/>
						</wcf:url>												
						<li>
						<div class="container">
						
						<a href="${fn:escapeXml(bundleDisplayUrl)}">
						<c:choose>
							<c:when test="${!empty bundle.description.thumbNail}">
								<span class="t_img_border"><img src="<c:out value="${bundle.objectPath}"/><c:out value="${bundle.description.thumbNail}"/>" alt="<c:out value="${bundle.description.shortDescription}" />" border="0" width="45" height="45"/></span>
							</c:when>
							<c:otherwise>
								<img src="<c:out value="${jspStoreImgDir}" />images/NoImageIcon_sm.jpg" alt="<fmt:message key="No_Image" bundle="${storeText}"/>" border="0"  width="45" height="45"/>
							</c:otherwise>
						</c:choose>
						</a>
						
						<ul>
							<li>
								<span class="bullet">&#187; </span>
								<a href="${fn:escapeXml(bundleDisplayUrl)}"><c:out value="${bundle.description.name}" escapeXml="false"/></a>
							</li>
							<%-- 
							<li>
								<span>&#160;&#160;&#160;<c:out value="${bundle.description.longDescription}" escapeXml="false"/></span>
							</li>
							--%>	
							<li>
								<span>&#160;&#160;&#160;<fmt:message key="SKU" bundle="${storeText}" />: <c:out value="${bundle.partNumber}" escapeXml="false"/></span>
							</li>									
							<li>
								<c:choose>
									<%-- show the list price only if it is larger than the item price --%>
									<c:when test="${ bundle.listPriced && bundle.calculatedContractPriced && (bundle.calculatedContractPrice.amount < bundle.listPrice.amount)}" >
										&#160;&#160;&#160;<span class="listprice"><c:out value="${bundle.listPrice}" escapeXml="false"/></span>
										<br />
										<span class="price">&#160;&#160;&#160;<c:out value="${bundle.calculatedContractPrice}" escapeXml="false"/></span>
									</c:when>
									<c:otherwise>
										<span class="price">&#160;&#160;&#160;<c:out value="${bundle.calculatedContractPrice}" escapeXml="false"/></span>
									</c:otherwise>
								</c:choose>																												
							</li>
						</ul>
			 			</div>		
						<div class="clear_float"></div>						 
						</li>							
					</c:when>
					<c:when test="${catEntry.package}">
						<c:set var="package" value="${catEntry.packageDataBean}"/>
						<wcf:url var="packageDisplayUrl" value="mProduct3">
							<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
							<wcf:param name="storeId" value="${WCParam.storeId}"/>
							<wcf:param name="productId" value="${package.packageID}"/>
							<wcf:param name="langId" value="${langId}"/>
							<wcf:param name="pgGrp" value="search"/>
							<wcf:param name="resultCatEntryType" value="${WCParam.resultCatEntryType}"/>
							<wcf:param name="pageSize" value="${pageSize}"/>
							<wcf:param name="searchTerm" value="${WCParam.searchTerm}"/>
							<wcf:param name="beginIndex" value="${catEntSearchListBean.beginIndex}"/>
							<wcf:param name="sType" value="${WCParam.sType}"/>
						</wcf:url>			
						<li>		
						<div class="container">	
						
						<a href="${fn:escapeXml(packageDisplayUrl)}">
							<c:choose>
								<c:when test="${!empty package.description.thumbNail}">
									<span class="t_img_border"><img src="<c:out value="${package.objectPath}"/><c:out value="${package.description.thumbNail}"/>" alt="<c:out value="${package.description.shortDescription}"/>" border="0" width="45" height="45"/></span>
								</c:when>
								<c:otherwise>
									<img src="<c:out value="${jspStoreImgDir}" />images/NoImageIcon_sm.jpg" alt="<fmt:message key="No_Image" bundle="${storeText}"/>" border="0" width="45" height="45"/>
								</c:otherwise>
							</c:choose>
						</a>						
						
						<ul>
							<li>
								<span class="bullet">&#187; </span>
								<a href="${fn:escapeXml(packageDisplayUrl)}"><c:out value="${package.description.name}" escapeXml="false"/></a>
							</li>
							<li>
								<span>&#160;&#160;&#160;<fmt:message key="SKU" bundle="${storeText}" />: <c:out value="${package.partNumber}" escapeXml="false"/></span>
							</li>			
							<li>
								<c:choose>
									<%-- show the list price only if it is larger than the item price --%>
									<c:when test="${ package.listPriced && package.calculatedContractPriced && (package.calculatedContractPrice.amount < package.listPrice.amount)}" >
										&#160;&#160;&#160;<span class="listprice"><c:out value="${package.listPrice}" escapeXml="false"/></span>
										<br />
										<span class="price">&#160;&#160;&#160;<c:out value="${package.calculatedContractPrice}" escapeXml="false"/></span>
									</c:when>
									<c:otherwise>
										<span class="price">&#160;&#160;&#160;<c:out value="${package.calculatedContractPrice}" escapeXml="false"/></span>
									</c:otherwise>
								</c:choose>																												
							</li>
						</ul>
				 		</div>	
						<div class="clear_float"></div>						 			 
						</li>
					</c:when>
				</c:choose>

			</c:forEach>
		</ol>
			<c:if test="${catEntSearchListBean.totalNumberOfResultSetPages > 1}">
			<div class="paging_control">
				<div class="page_number">
					<fmt:message key="PAGING" bundle="${storeText}">
						<fmt:param value="${catEntSearchListBean.currentPageNumber}"/>
						<fmt:param value="${catEntSearchListBean.totalNumberOfResultSetPages}"/>				
					</fmt:message>
					<%-- 
					Page <c:out value="${currentPage}" />/<c:out value="${totalPages}" />
					--%>				
				</div> 
				<c:if test="${catEntSearchListBean.currentPageNumber > 1}">
					<span class="bullet">&#171; </span>
					<wcf:url var="CatalogSearchResultURL" value="mCatalogSearchResultView">
						<wcf:param name="storeId" value="${WCParam.storeId}" />
						<wcf:param name="catalogId" value="${WCParam.catalogId}" />
						<wcf:param name="beginIndex" value="${prevPageIndex}"/>
						<wcf:param name="searchTerm" value="${WCParam.searchTerm}" />		
						<wcf:param name="resultCatEntryType" value="${WCParam.resultCatEntryType}" />	
						<wcf:param name="sType" value="${WCParam.sType}"/>
						<wcf:param name="pageSize" value="${WCParam.pageSize}"/>	
					</wcf:url>
					<a href="${fn:escapeXml(CatalogSearchResultURL)}" title="<fmt:message key="PAGING_PREV_PAGE_TITLE" bundle="${storeText}"/>">
					<fmt:message key="PAGING_PREV_PAGE" bundle="${storeText}"/></a>
				</c:if>
				&#160;&#160;
				<c:if test="${catEntSearchListBean.currentPageNumber < catEntSearchListBean.totalNumberOfResultSetPages}">
					<wcf:url var="CatalogSearchResultURL" value="mCatalogSearchResultView">
						<wcf:param name="storeId" value="${WCParam.storeId}" />
						<wcf:param name="catalogId" value="${WCParam.catalogId}" />
						<wcf:param name="beginIndex" value="${nextPageIndex}"/>
						<wcf:param name="searchTerm" value="${WCParam.searchTerm}" />		
						<wcf:param name="resultCatEntryType" value="${WCParam.resultCatEntryType}" />
						<wcf:param name="sType" value="${WCParam.sType}"/>
						<wcf:param name="pageSize" value="${WCParam.pageSize}"/>									
					</wcf:url>			
					<a href="${fn:escapeXml(CatalogSearchResultURL)}" title="<fmt:message key="PAGING_NEXT_PAGE_TITLE" bundle="${storeText}"/>"><fmt:message key="PAGING_NEXT_PAGE" bundle="${storeText}"/></a>
					<span class="bullet">&#187; </span>
				</c:if>
			</div>
			</c:if>		
		</div>
	</c:otherwise>
</c:choose>

<%-- START Required logic for the quick product navigation from the search results page --%>

<c:remove var="catEntSearchListBean" />
<wcbase:useBean id="catEntSearchListBean" scope="page" classname="com.ibm.commerce.search.beans.CatEntrySearchListDataBean">
	<jsp:setProperty property="*" name="catEntSearchListBean" />
	<%-- Set the kind of Catalog Entries to show --%>
	<c:choose>
		<%-- resultCatEntryType 2 stands for searching product but not item --%>
		<c:when test="${WCParam.resultCatEntryType == 2}">
			<c:set property="isProduct" value="true" target="${catEntSearchListBean}" />
			<c:set property="isItem" value="false" target="${catEntSearchListBean}" />
		</c:when>
		<%-- resultCatEntryType 1 stands for searching item, but not product --%>
		<c:when test="${WCParam.resultCatEntryType == 1}">
			<c:set property="isProduct" value="false" target="${catEntSearchListBean}" />
			<c:set property="isItem" value="true" target="${catEntSearchListBean}" />
		</c:when>
		<%-- Otherwise, search for both item and product --%>
		<c:otherwise>
			<c:set property="isProduct" value="true" target="${catEntSearchListBean}" />
			<c:set property="isItem" value="true" target="${catEntSearchListBean}" />
		</c:otherwise>
	</c:choose>
				
	<%-- always search for bundles and packages --%>
	<c:set property="isBundle" value="true" target="${catEntSearchListBean}" />
	<c:set property="isPackage" value="true" target="${catEntSearchListBean}" />
	<%-- Set the sort order to sort by CatEntDescName --%>
	<c:set property="orderBy1" value="CatEntDescName" target="${catEntSearchListBean}" />
	<%-- Set the search Term --%>
	<%-- setting this property for defect 137532.. This property will be present in the request properties and there is no need to set it here...But if the search page was accessed using http protocol, then this property is available only in this page and it will not be available in the bean..So we need to explicitly set this here --%>
	<c:set property="searchTerm" value="${WCParam.searchTerm}" target="${catEntSearchListBean}" />
	<c:set property="pageSize" value="${totalCount}" target="${catEntSearchListBean}" />
</wcbase:useBean>

<c:set var="srchProductIds" value="" />
<c:forEach var="catEntry" items="${catEntSearchListBean.resultList}" varStatus="counter">
	<c:set property="commandContext" value="${catEntSearchListBean.commandContext}" target="${catEntry}"/>
	<c:choose>
		<c:when test="${catEntry.product}">
			<c:set var="product" value="${catEntry.productDataBean}"/>
			<c:set var="srchProductIds" value="${srchProductIds},${product.productID}" />
		</c:when>
		<c:when test="${catEntry.item}">
			<c:set var="item" value="${catEntry.itemDataBean}"/>
			<c:set var="srchProductIds" value="${srchProductIds},${item.itemID}" />
		</c:when>		
		<c:when test="${catEntry.bundle}">
			<c:set var="bundle" value="${catEntry.bundleDataBean}"/>
			<c:set var="srchProductIds" value="${srchProductIds},${bundle.bundleID}" />
		</c:when>		
		<c:when test="${catEntry.package}">
			<c:set var="package" value="${catEntry.packageDataBean}"/>
			<c:set var="srchProductIds" value="${srchProductIds},${package.packageID}" />
		</c:when>		
	</c:choose>
</c:forEach>

<%
String srchProdIds = (String)pageContext.getAttribute("srchProductIds");
srchProdIds = srchProdIds.replaceFirst(",","");
session.setAttribute(SEARCH_PRODUCTIDS_KEY,srchProdIds);
%>

<%-- END Required logic for the quick product navigation from the search results page --%>
					
<!-- END CatalogSearchResultOnlyDisplay.jsp -->					
