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
  * This JSP displays the users Wishlist. 
  *****
--%>

<!-- BEGIN WishListDisplay.jsp -->

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>

<%@ include file="../../../../../include/parameters.jspf" %>
<%@ include file="../../../../include/JSTLEnvironmentSetup.jspf" %>

<%-- Required variables for breadcrumb support --%>
<c:choose>
	<c:when test="${!empty WCParam.pgGrp and WCParam.pgGrp == 'catNav'}">
		<c:set var="categoryNavPageGroup" value="true" scope="request"/>
	</c:when>
	<c:when test="${!empty WCParam.pgGrp and WCParam.pgGrp == 'search'}">
		<c:set var="searchPageGroup" value="true" scope="request"/>
	</c:when>	
	<c:otherwise>
		<c:set var="pgGrp" value="wishlist" />
		<c:set var="wishlistPageGroup" value="true" scope="request"/>	
	</c:otherwise>
</c:choose>
<c:set var="wishlistDisplayPage" value="true" scope="request" />

<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.2//EN" "http://www.openmobilealliance.org/tech/DTD/xhtml-mobile12.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" lang="${shortLocale}" xml:lang="${shortLocale}">
	<head>
		<title>
			<fmt:message key="WISHLIST_TITLE" bundle="${storeText}" /> - <c:out value="${storeName}"/>
		</title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no" />
		<link rel="stylesheet" href="${cssPath}" type="text/css"/>
	</head>	
	<body>
		<div id="wrapper">	

			<%@ include file="../../../../include/HeaderDisplay.jspf" %>
			<%@ include file="../../../../include/BreadCrumbTrailDisplay.jspf"%>			

			<div id="wish_list" class="content_box">
				<div class="heading_container">
					<h2><fmt:message key="WISHLIST_TITLE" bundle="${storeText}" /></h2>
					<div class="clear_float"></div>
				</div>

				<c:set var="bHasWishList" value="true" />
				<c:choose>
					<%-- Check to see if there is an list id, if no, then wish list is empty--%>
					<c:when test="${ empty listId[0] }" >
						<c:set var="bHasWishList" value="false"/>
					</c:when>
					<c:otherwise>
						<wcbase:useBean id="listBean" classname="com.ibm.commerce.catalog.beans.InterestItemListDataBean" scope="page">
							<c:set value="${listId[0]}" target="${listBean}" property="listId"/>
							<%--
							  *** 
							  * Two stores on the same server shares user wish lists.  We have to set the storeentId
							  * to make sure the items in this shoppers wish list belongs to this store.
							  ***
							--%>				
							<c:set value="${WCParam.storeId}" target="${listBean}" property="storeEntityId"/>
						</wcbase:useBean>
						<c:set var="interestItems" value="${listBean.interestItemDataBeans}" />
			    			<%-- if there are items, then there are items in the wish list --%>
				   		<c:if test="${ empty interestItems }" >
							<c:set var="bHasWishList" value="false"/>
			   			</c:if>
					</c:otherwise>
				</c:choose>

				<c:choose> 
					<c:when test="${ !bHasWishList }">
						<fmt:message key="EMPTYWISHLIST" bundle="${storeText}" /><br/>
					</c:when>
					<c:otherwise>
					
						<c:set var="numEntries" value="${fn:length(listBean.interestItemDataBeans)}"/>

						<c:set var="wishlistProductIds" value="" />
						<c:forEach var="interestItem" items="${listBean.interestItemDataBeans}" varStatus="status">
							<c:set var="wishlistProductIds" value="${wishlistProductIds},${interestItem.catalogEntryDataBean.catalogEntryID}" />
						</c:forEach>

						<%
						String wishlistProdIds = (String)pageContext.getAttribute("wishlistProductIds");
						wishlistProdIds = wishlistProdIds.replaceFirst(",","");
						session.setAttribute(WISHLIST_PRODUCTID_KEY,wishlistProdIds);
						%>

						<%-- Pagination Logic --%>
						<c:set var="pageSize" value="${WCParam.pageSize}"/>
						<c:if test="${empty pageSize}">
						<c:set var="pageSize" value="${wishlistMaxPageSize}" />
						</c:if>
							
						<%-- Counts the page number we are drawing in.  --%>
						<c:set var="currentPage" value="1" />
						<c:if test="${!empty WCParam.currentPage}">
							<c:set var="currentPage" value="${WCParam.currentPage}" />
						</c:if>
						
						<fmt:formatNumber var="totalPages" value="${(numEntries/pageSize)+1}"/>
						<c:if test="${numEntries%pageSize == 0}">
							<fmt:parseNumber var="totalPages" value="${numEntries/pageSize}"/>
						</c:if>
						<fmt:parseNumber var="totalPages" value="${totalPages}" integerOnly="true" />
						
						<fmt:formatNumber var="beginIndex" value="${(currentPage-1) * pageSize}"/>
						<fmt:formatNumber var="endIndex" value="${beginIndex + pageSize}"/>
						<c:if test="${endIndex > numEntries}">
							<fmt:parseNumber var="endIndex" value="${numEntries}"/>
						</c:if>
						<fmt:parseNumber var="beginIndex" value="${beginIndex}" integerOnly="true" />
						<fmt:parseNumber var="endIndex" value="${endIndex}" integerOnly="true" />	
						<fmt:parseNumber var="numRecordsToShow" value="${endIndex-beginIndex}" integerOnly="true" />
					

						<ol start="<c:out value="${beginIndex + 1}"/>">
						<c:forEach var="interestItem" items="${listBean.interestItemDataBeans}" begin="${beginIndex}" end="${endIndex}" 
							varStatus="status">
							
							<c:if test="${status.count <= numRecordsToShow}">
							
							<c:set var="catalogEntry" value="${interestItem.catalogEntryDataBean}"/>
							<c:set var="catalogEntryId" value="${catalogEntry.catalogEntryID}"/>
																	
							<wcf:url var="ProductDisplayURL" value="mProduct4">
								<wcf:param name="productId" value="${catalogEntryId}" />
								<wcf:param name="langId" value="${langId}" />
								<wcf:param name="storeId" value="${WCParam.storeId}" />
								<wcf:param name="catalogId" value="${WCParam.catalogId}" />
								<wcf:param name="pgGrp" value="wishlist" />
							</wcf:url>
							
							<li>
								<div class="container">
									<a href="<c:out value="${ProductDisplayURL}" />" >
										<c:choose>
											<c:when test="${!empty interestItem.catalogEntryDataBean.description.thumbNail}">
												<img src="<c:out value="${interestItem.catalogEntryDataBean.objectPath}${interestItem.catalogEntryDataBean.description.thumbNail}" />" 
												alt="<c:out value="${interestItem.catalogEntryDataBean.description.name}" />" width="45" height="45" />
											</c:when>
											<c:otherwise>
												<img src="<c:out value="${jspStoreImgDir}"/>images/NoImageIcon_sm.jpg" 
												alt="<fmt:message key="No_Image" bundle="${storeText}"/>" width="45" height="45" />						
											</c:otherwise>
										</c:choose>
									</a>
									<ul>
										<li><span class="bullet">&#187; </span><a href="<c:out value="${ProductDisplayURL}" />" title="<c:out value="${interestItem.catalogEntryDataBean.description.name}" />">
											<c:out value="${interestItem.catalogEntryDataBean.description.name}" escapeXml="false"/></a></li>
										<li>&#160;&#160;<c:out value="${interestItem.catalogEntryDataBean.partNumber}" escapeXml="false"/></li>											
										<li>
											<c:set var="catalogEntryDB" value="${interestItem.catalogEntryDataBean}"/>
											<c:set var="type" value="catalogEntry"/>											
											&#160;<%@ include file="../../../../Snippets/ReusableObjects/CatalogEntryPriceDisplay.jspf"%>
										</li>
											
										<c:set var="refURL" value="InterestItemDisplay?URL=mInterestListDisplay&listId=." />	
																			
										<wcf:url var="RemoveFromWishlist" value="InterestItemDelete">
											<c:forEach var="parameter" items="${WCParamValues}">
												<c:forEach var="value" items="${parameter.value}">
													<c:if test="${parameter.key != 'catEntryId' and parameter.key != 'listId' and parameter.key != 'URL'}">
														<wcf:param name="${parameter.key}" value="${value}" />
													</c:if>
												</c:forEach>
											</c:forEach>																					
											<wcf:param name="catEntryId" value="${interestItem.catEntryID}" />
											<wcf:param name="listId" value="." />
											<wcf:param name="URL" value="${refURL}" />
										</wcf:url>															
										<li>
											<span class="bullet">&#187; </span><a href="${fn:escapeXml(RemoveFromWishlist)}" title="<fmt:message key="WISHLIST_REMOVE" bundle="${storeText}" />">
											<fmt:message key="WISHLIST_REMOVE" bundle="${storeText}" /></a>
										</li>
									</ul>
									<div class="clear_float"></div>
								</div>
							</li>
							</c:if>
						</c:forEach>
						</ol>

						<c:if test="${totalPages > 1}">
						<!-- Pagination Logic -->
						<div class="paging_control_with_underline">
							<div class="page_number">
								<fmt:message key="PAGING" bundle="${storeText}">
									<fmt:param value="${currentPage}"/>
									<fmt:param value="${totalPages}"/>				
								</fmt:message>		
							</div> 
							<c:if test="${currentPage > 1}">
								<span class="bullet">&#171; </span>
							 	<wcf:url var="WishlistDisplayURL" value="InterestItemDisplay">
									<wcf:param name="langId" value="${langId}" />
									<wcf:param name="storeId" value="${WCParam.storeId}" />
									<wcf:param name="catalogId" value="${WCParam.catalogId}" />
									<wcf:param name="currentPage" value="${currentPage-1}" />			
									<wcf:param name="listId" value="." />			
									<wcf:param name="URL" value="mInterestListDisplay" />			
								</wcf:url>
								<a href="${fn:escapeXml(WishlistDisplayURL)}" title="<fmt:message key="PAGING_PREV_PAGE_TITLE" 
									bundle="${storeText}"/>"><fmt:message key="PAGING_PREV_PAGE" bundle="${storeText}"/></a>
							</c:if>
							&#160;&#160;
							<c:if test="${currentPage < totalPages}">
								<wcf:url var="WishlistDisplayURL" value="InterestItemDisplay">
									<wcf:param name="langId" value="${langId}" />
									<wcf:param name="storeId" value="${WCParam.storeId}" />
									<wcf:param name="catalogId" value="${WCParam.catalogId}" />
									<wcf:param name="currentPage" value="${currentPage+1}" />			
									<wcf:param name="listId" value="." />			
									<wcf:param name="URL" value="mInterestListDisplay" />
								</wcf:url>			
								<a href="${fn:escapeXml(WishlistDisplayURL)}" title="<fmt:message key="PAGING_NEXT_PAGE_TITLE" 
									bundle="${storeText}"/>"><fmt:message key="PAGING_NEXT_PAGE" bundle="${storeText}"/></a>
								<span class="bullet">&#187; </span>
							</c:if>
				 		</div>
				 		</c:if>
						
						<wcf:url var="EmailWishList" value="mEmailWishlistDisplay">
							<wcf:param name="langId" value="${langId}" />
							<wcf:param name="storeId" value="${WCParam.storeId}" />
							<wcf:param name="catalogId" value="${WCParam.catalogId}" />
							<wcf:param name="listId" value="${listId[0]}" />					
							<wcf:param name="pgGrp" value="${pgGrp}" />					
						</wcf:url>				
						<span class="bullet">&#187; </span><a href="<c:out value="${EmailWishList}" />" 
							title="<fmt:message key="EMAIL_WISHLIST" bundle="${storeText}" />">
							<fmt:message key="EMAIL_WISHLIST" bundle="${storeText}" /></a>
					</c:otherwise>
				</c:choose>							
			</div>									

			<%@ include file="../../../../include/FooterDisplay.jspf" %>						
		</div>
	</body>
</html>

<!-- END WishListDisplay.jsp -->
