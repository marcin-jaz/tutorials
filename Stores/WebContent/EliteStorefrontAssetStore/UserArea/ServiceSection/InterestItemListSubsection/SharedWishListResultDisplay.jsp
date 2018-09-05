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
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf" %>
<%@ include file="../../../include/nocache.jspf" %>


<%-- activate the StoreAddressDataBean to get the store email and use it as the sender of the wish list email --%>
<wcbase:useBean id="storeAddress" classname="com.ibm.commerce.common.beans.StoreAddressDataBean" scope="page" >
	<c:set value="${sdb.storeEntityDescriptionDataBean.contactAddressId}" target="${storeAddress}" property="dataBeanKeyStoreAddressId"/>
</wcbase:useBean>

<c:choose>
	<%-- users have explicitly chosen a pageView --%>
	<c:when test="${WCParam.wishListEMail=='true'}">
		<c:set var="displayPageViewURL" value="SharedWishListView"/>
	</c:when>
	<c:otherwise>
		<%-- use defaultPageView, set in JSTLEnvironmentSetup --%>
		<c:set var="displayPageViewURL" value="InterestItemDisplay"/>
	</c:otherwise>
</c:choose>

	<c:set var="wishListPage" value="true" />   
	<c:set var="sharedWishList" value="true"/>
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
							<%--
								***
								* Start: Empty Wish List 
								* If the wish list is empty, display the empty wish list message
								***
							--%>
							<div class="contentgrad_header" id="WC_SharedWishListResultDisplay_div_20">
								<div class="left_corner" id="WC_SharedWishListResultDisplay_div_18"></div>
								<div class="right_corner_wishlist" id ="WC_SharedWishListResultDisplay_div_19"></div>
							</div>
							<div class="wishlist_body588" id="WC_SharedWishListResultDisplay_div_5">
								<div id="WC_SharedWishListResultDisplay_div_21" style="padding:0 10px;"><fmt:message key="EMPTYWISHLIST" bundle="${storeText}" /><br/><br/></div>
								<div class="center" id="WC_SharedWishListResultDisplay_div_7"><img src="<c:out value="${jspStoreImgDir}${vfileColor}wish_list.jpg"/>" alt="" /></div>
							</div>
							<%--
								***
								* End: Empty Wish List 
								***
							--%>
						</c:when>
						<c:otherwise>
							<%-- 
								*** 
								* Wish list is not empty.  Display wish list contents
								***
							--%>
							
							<c:set var="numberProductsPerRow" value="4"/>
							<c:set var="pageSize" value="${param.pageSize}" />
							<c:if test="${empty pageSize}">
								<c:set var="pageSize" value="12" />
							</c:if>
							<c:set var="numEntries" value="0"/>
							<c:forEach var="count" items="${listBean.interestItemDataBeans}" varStatus="status">
								<c:if test="${status.last}"><c:set var="numEntries" value="${status.count}"/></c:if>
							</c:forEach>
							<fmt:formatNumber var="totalPages" value="${(numEntries/pageSize)+1}"/>
							<c:if test="${numEntries%pageSize == 0}">
								<fmt:formatNumber var="totalPages" value="${numEntries/pageSize}"/>
								<c:if test="${totalPages == 0 && numEntries!=0}">
									<fmt:formatNumber var="totalPages" value="1"/>
								</c:if>
							</c:if>
							<fmt:parseNumber var="totalPages" value="${totalPages}" integerOnly="true"/>
							<c:set var="currentPage" value="${param.currentPage}" />
							<c:if test="${empty currentPage}">
								<c:set var="currentPage" value="0" />
							</c:if>
							<c:if test="${currentPage < 0}">
								<c:set var="currentPage" value="0"/>
							</c:if>
							<c:if test="${currentPage >= (totalPages)}">
								<c:set var="currentPage" value="${totalPages-1}"/>
							</c:if>
							<c:set var="startIndex" value="1"/>
							<c:if test="${currentPage != 0}">
								<c:set var="startIndex" value="${(currentPage * pageSize) + 1}"/>
							</c:if>
							<c:set var="endIndex" value="${(currentPage + 1) * pageSize}"/>
							<c:if test="${endIndex > numEntries}">
								<c:set var="endIndex" value="${numEntries}"/>
							</c:if>
							<c:choose>
								<%-- users have explicitly chosen a pageView --%>
								<c:when test="${!empty WCParam.pageView}">
									<c:set var="pageView" value="${WCParam.pageView}"/>
								</c:when>
								<c:otherwise>
									<%-- use defaultPageView, set in JSTLEnvironmentSetup --%>
									<c:set var="pageView" value="${defaultPageView}"/>
								</c:otherwise>
							</c:choose>
							<c:if test="${currentPage != 0}">
								<wcf:url var="WishListResultDisplayViewPrevURL" value="${displayPageViewURL}" type="Ajax">
									<wcf:param name="langId" value="${langId}" />						
									<wcf:param name="storeId" value="${WCParam.storeId}" />
									<wcf:param name="catalogId" value="${WCParam.catalogId}" />
									<wcf:param name="currentPage" value="${currentPage - 1}" />
									<wcf:param name="pageView" value="${pageView}" />
									<wcf:param name="listId" value="${WCParam.listId}"/>
									<wcf:param name="wishListEMail" value="${WCParam.wishListEMail}"/>
								</wcf:url>
							</c:if>
							<c:if test="${currentPage < totalPages-1}">
								<wcf:url var="WishListResultDisplayViewNextURL" value="${displayPageViewURL}" type="Ajax">
									<wcf:param name="langId" value="${langId}" />						
									<wcf:param name="storeId" value="${WCParam.storeId}" />
									<wcf:param name="catalogId" value="${WCParam.catalogId}" />
									<wcf:param name="currentPage" value="${currentPage + 1}" />
									<wcf:param name="pageView" value="${pageView}" />
									<wcf:param name="listId" value="${WCParam.listId}"/>
									<wcf:param name="wishListEMail" value="${WCParam.wishListEMail}"/>
								</wcf:url>
							</c:if>
							<wcf:url var="WishListResultDisplayViewFullURL" value="${displayPageViewURL}" type="Ajax">
								<wcf:param name="langId" value="${langId}" />						
								<wcf:param name="storeId" value="${WCParam.storeId}" />
								<wcf:param name="catalogId" value="${WCParam.catalogId}" />
								<wcf:param name="currentPage" value="${currentPage}" />
								<wcf:param name="pageView" value="detailed" />
								<wcf:param name="listId" value="${WCParam.listId}"/>
								<wcf:param name="wishListEMail" value="${WCParam.wishListEMail}"/>
							</wcf:url>
							<wcf:url var="WishListResultDisplayViewURL" value="${displayPageViewURL}" type="Ajax">
							  <wcf:param name="langId" value="${langId}" />						
							  <wcf:param name="storeId" value="${WCParam.storeId}" />
							  <wcf:param name="catalogId" value="${WCParam.catalogId}" />
							  <wcf:param name="currentPage" value="${currentPage}" />
							  <wcf:param name="pageView" value="image" />
							  <wcf:param name="listId" value="${WCParam.listId}"/>
							  <wcf:param name="wishListEMail" value="${WCParam.wishListEMail}"/>
							</wcf:url>
							<wcf:url var="WishListResultDisplay" value="${displayPageViewURL}" type="Ajax">
							  <wcf:param name="langId" value="${langId}" />						
							  <wcf:param name="storeId" value="${WCParam.storeId}" />
							  <wcf:param name="catalogId" value="${WCParam.catalogId}" />
							  <wcf:param name="currentPage" value="${currentPage}" />
							  <wcf:param name="pageView" value="${pageView}" />
							</wcf:url>
							<div class="contentgrad_header" id="WC_SharedWishListResultDisplay_div_15">
								<div class="left_corner" id="WC_SharedWishListResultDisplay_div_16"></div>
								<div class="left" id="WC_SharedWishListResultDisplay_div4">
									<span class="text">
										<fmt:message key="CATEGORY_RESULTS_DISPLAYING" bundle="${storeText}"> 
											<fmt:param><fmt:formatNumber value="${startIndex}"/></fmt:param>
											<fmt:param><fmt:formatNumber value="${endIndex}"/></fmt:param>
											<fmt:param><fmt:formatNumber value="${numEntries}"/></fmt:param>
										</fmt:message>
										<c:if test="${totalPages > 1}">
											<span class="paging">
												<c:if test="${currentPage != 0}">
													<a href="<c:out value='${WishListResultDisplayViewPrevURL}'/>" id="WC_WishListResultDisplay_links_1">
												</c:if>
												<img src="<c:out value="${jspStoreImgDir}${vfileColorBIDI}" />paging_back.png" alt="<fmt:message key="CATEGORY_PAGING_LEFT_IMAGE" bundle="${storeText}"/>" />
												<c:if test="${currentPage != 0}">
													</a>
												</c:if>
												<fmt:message key="CATEGORY_RESULTS_PAGES_DISPLAYING" bundle="${storeText}"> 
													<fmt:param><fmt:formatNumber value="${currentPage + 1}"/></fmt:param>
													<fmt:param><fmt:formatNumber value="${totalPages}"/></fmt:param>
												</fmt:message>
												<c:if test="${currentPage < totalPages-1}">
													<a href="<c:out value='${WishListResultDisplayViewNextURL}'/>" id="WC_WishListResultDisplay_links_2">
												</c:if>
												<img src="<c:out value="${jspStoreImgDir}${vfileColorBIDI}" />paging_next.png" alt="<fmt:message key="CATEGORY_PAGING_RIGHT_IMAGE" bundle="${storeText}"/>" />
												<c:if test="${currentPage < totalPages-1}">
													</a>
												</c:if>
											</span>
										</c:if>
									</span>
								</div>
								<div class="right_corner_wishlist" id="WC_SharedWishListResultDisplay_div_8"></div>
								<div class="right" id="WC_SharedWishListResultDisplay_div_9">  
									<span class="views">  
										<c:if test="${pageView !='image'}">
											<c:set var="gridView" value="horizontal_grid"/>
											<a href="<c:out value='${WishListResultDisplayViewURL}'/>" id="WC_WishListResultDisplay_links_3">
												<img src="<c:out value="${jspStoreImgDir}${vfileColor}" />grid_normal.png" alt="<fmt:message key="CATEGORY_IMAGE_VIEW" bundle="${storeText}"/>" />
											</a>
											 <img id="detailedTypeImageSelected" src="<c:out value="${jspStoreImgDir}${vfileColor}list_selected.png"/>" alt="<fmt:message key="FF_VIEWDETAILS" bundle="${storeText}"/>"/>	
										</c:if>
										<c:if test="${pageView !='detailed'}">
											<c:set var="gridView" value="four-grid"/>
											<img id="imageTypeImageSelected" src="<c:out value="${jspStoreImgDir}${vfileColor}grid_selected.png"/>" alt="<fmt:message key="FF_VIEWICONS" bundle="${storeText}"/>"/>
											<a href="<c:out value='${WishListResultDisplayViewFullURL}'/>" id="WC_WishListResultDisplay_links_4">
												<img src="<c:out value="${jspStoreImgDir}${vfileColor}" />list_normal.png" alt="<fmt:message key="CATEGORY_DETAILED_VIEW" bundle="${storeText}"/>" />
											</a>
										</c:if>
									</span> 
								</div>
							<br/>
							<br clear="all"/>
						</div>
			<div class="wishlist_body588" id="WC_SharedWishListResultDisplay_div_5_2" >
								<%--
									***
									* Loop through each of the interest items and display the item name, the attribute values and the price
									***
								--%>
								<br clear="all"/>
								<table id="${gridView}" cellpadding="0" cellspacing="0" border="0">
									<c:set var="rowItemCount" value="0"/>
									<c:set var="rowBeginIndex" value="0"/>
									<c:forEach var="interestItem" items="${listBean.interestItemDataBeans}" varStatus="status" begin="${startIndex-1}" end="${endIndex-1}">
										<c:set var="catEntry" value="${interestItem.catalogEntryDataBean}"/>
										<c:set var="prefix" value="wishList"/>
										<c:set var="catEntryIdentifier" value="${catEntry.catalogEntryID}"/>
										<c:if test="${pageView == 'detailed'}">
											<wcf:url var="interestItemDeleteURL" value="InterestItemDelete" type="Ajax">
												<wcf:param name="catEntryId" value="${catEntry.catalogEntryID}" />
												<wcf:param name="storeId" value="${WCParam.storeId}" />
												<wcf:param name="catalogId" value="${WCParam.catalogId}" />
												<wcf:param name="langId" value="${langId}"/>
												<wcf:param name="listId" value="." />
												<wcf:param name="pageView" value="detailed"/>
												<wcf:param name="URL" value="InterestItemDisplay"/>
												<wcf:param name="errorViewName" value="InterestItemDisplay"/>
											</wcf:url>
										</c:if>  
										<c:if test="${rowItemCount == 0}">
											<tr class="item_container">
												<td class="divider_line" colspan="4" id="WC_WishListResultDisplay_td_1_<c:out value='${status.count}'/>"></td>
											</tr>
											<tr class="item_container">	       
										</c:if>
										<c:choose>
											<c:when test="${WCParam.wishListEMail=='true'}">
												<c:set var="includeRemoveFromWishList" value="false"/>
											</c:when>
											<c:otherwise>
												<c:set var="includeRemoveFromWishList" value="true"/>
											</c:otherwise>
										</c:choose> 
										<c:choose>
											<c:when test="${pageView == 'image'}">
												<td class="item" id="WC_WishListResultDisplay_td_2_<c:out value='${status.count}'/>">
													<div id="WC_SharedWishListResultDisplay_div_9_<c:out value='${status.count}'/>" <c:if test="${rowItemCount!=0}"> class="container" </c:if>>
														<c:set var="rowItemCount" value="${rowItemCount+1}"/>
														<c:set var="interestItem2" value="${interestItem}"/>
														<%@ include file="../../../Snippets/ReusableObjects/CatalogEntryDBThumbnailDisplay.jspf" %> 
													</div>
												</td>
											
												<c:if test="${rowItemCount%numberProductsPerRow == 0}">
													</tr>
													<c:set var="rowItemCount" value="0"/>
													<c:set var="rowBeginIndex" value="${status.index+1}"/>
												</c:if>
											</c:when>
											<c:otherwise>
												<%@ include file="../../../Snippets/ReusableObjects/CatalogEntryDBThumbnailDisplay.jspf" %>
											</c:otherwise>
										</c:choose>
									</c:forEach>
									<c:if test="${rowItemCount != 0 && pageView !='detailed'}">
										</tr>
									</c:if>
									<tr class="item_container">
										<td class="divider_line" colspan="4" id="WC_WishListResultDisplay_td_1a"></td>
									</tr>
								</table>
								<br clear="all"/>
								<div class="left" id="WC_SharedWishListResultDisplay_div_10">
									<span class="display_text">
										<fmt:message key="CATEGORY_RESULTS_DISPLAYING" bundle="${storeText}"> 
											<fmt:param><fmt:formatNumber value="${startIndex}"/></fmt:param>
											<fmt:param><fmt:formatNumber value="${endIndex}"/></fmt:param>
											<fmt:param><fmt:formatNumber value="${numEntries}"/></fmt:param>
										</fmt:message>
										<c:if test="${totalPages > 1}">
											<span class="paging">
												<c:if test="${currentPage != 0}">
													<a href="<c:out value='${WishListResultDisplayViewPrevURL}'/>" id="WC_WishListResultDisplay_links_1_2">
												</c:if>
													<img src="<c:out value="${jspStoreImgDir}${vfileColorBIDI}" />paging_back.png" alt="<fmt:message key="CATEGORY_PAGING_LEFT_IMAGE" bundle="${storeText}"/>" />
												<c:if test="${currentPage != 0}">
													</a>
												</c:if>
												<fmt:message key="CATEGORY_RESULTS_PAGES_DISPLAYING" bundle="${storeText}"> 
													<fmt:param><fmt:formatNumber value="${currentPage + 1}"/></fmt:param>
													<fmt:param><fmt:formatNumber value="${totalPages}"/></fmt:param>
												</fmt:message>
												<c:if test="${currentPage < totalPages-1}">
													<a href="<c:out value='${WishListResultDisplayViewNextURL}'/>" id="WC_WishListResultDisplay_links_2_2">
												</c:if>
													<img src="<c:out value="${jspStoreImgDir}${vfileColorBIDI}" />paging_next.png" alt="<fmt:message key="CATEGORY_PAGING_RIGHT_IMAGE" bundle="${storeText}"/>" />
												<c:if test="${currentPage < totalPages-1}">
													</a>
												</c:if>
											</span>
										</c:if>
									</span>
								</div>
								<br clear="all"/>
								</div>
						</c:otherwise>
					</c:choose>  
				<div class="footer" id="WC_SharedWishListResultDisplay_div_11">
					<div class="left_corner" id="WC_SharedWishListResultDisplay_div_12"></div>
					<div class="left" id="WC_SharedWishListResultDisplay_div_13"></div>
					<div class="right_corner" id="WC_SharedWishListResultDisplay_div_14"></div>
				</div>
