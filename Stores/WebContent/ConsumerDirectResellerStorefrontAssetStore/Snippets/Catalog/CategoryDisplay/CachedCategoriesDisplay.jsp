<%
//********************************************************************
//*-------------------------------------------------------------------
//* Licensed Materials - Property of IBM
//*
//* WebSphere Commerce
//*
//* (c) Copyright IBM Corp. 2000, 2002, 2004
//*
//* US Government Users Restricted Rights - Use, duplication or
//* disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
//*
//*-------------------------------------------------------------------
//*
%>

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
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf"%>

<%-- Show the subcategories/catentries as detailed view or image view --%>
<c:set var="pageView" value="${WCParam.pageView}" />
<c:if test="${empty pageView}">
	<c:set var="pageView" value="image" />
</c:if>

<%-- Constant for the number of results to display on a row --%>
<c:set var="resultsOnRow" value="${WCParam.resultsOnRow}" />
<c:if test="${empty resultsOnRow}">
	<c:set var="resultsOnRow" value="3" />
</c:if>
<c:if test="${pageView == 'detailed'}">
	<c:set var="resultsOnRow" value="1" />
</c:if>

<%-- Constans for the number of results to display on a page --%>
<c:set var="pageSize" value="${WCParam.pageSize}" />
<c:if test="${empty pageSize}">
	<c:set var="pageSize" value="6" />
</c:if>

<%-- Constant for the width of the display area divided by the number of results on each row --%>
<c:set var="columnWidth" value="${(400/resultsOnRow)}" />

<%-- Counts the column number we are drawing in.  From 0 to resultsOnRow - 1 --%>
<c:set var="numberOfResults" value="0" />

<%-- Counts the page number we are drawing in.  --%>
<c:set var="currentPage" value="${WCParam.currentPage}" />
<c:if test="${empty currentPage}">
	<c:set var="currentPage" value="0" />
</c:if>

<c:if test="${empty imgHeight}">
	<c:set var="imgHeight" value="150"/>
</c:if>
<c:if test="${empty imgWidth}">
	<c:set var="imgWidth" value="150"/>
</c:if>

<c:if test="${empty subimgHeight}">
	<c:set var="subimgHeight" value="73"/>
</c:if>
<c:if test="${empty subimgWidth}">
	<c:set var="subimgWidth" value="73"/>
</c:if>


<wcbase:useBean id="category" classname="com.ibm.commerce.catalog.beans.CategoryDataBean" scope="page" />

<%-- 
***
* Start:  Get all category, product and package IDs displayed on this page and pass them to the discount code
***
--%>
	<%-- Create a comma delimited string containing all IDs to pass to the discount code.
		For an in depth explanation of why this is done, see DiscountJavaScriptSetup.jsp --%>
	<c:forEach var="categoryID" items="${category.subCategories}">
		<c:set var="someCategoryIDs" value="${someCategoryIDs},${categoryID.categoryId}" />
	</c:forEach>
	<c:forEach var="packageIDs" items="${category.packages}">
		<c:set var="someProductIDs" value="${someProductIDs},${packageIDs.packageID}" />
	</c:forEach>
	<c:forEach var="productIDs" items="${category.products}">			
		<c:set var="someProductIDs" value="${someProductIDs},${productIDs.productID}" />
	</c:forEach>

	<%-- Pass the IDs to the discount JavaScript --%>
	<%-- Flush the buffer so this fragment JSP is not cached twice --%>
	<%out.flush();%>
	<c:import url="${jspStoreDir}include/DiscountJavaScriptSetup.jsp">  
		<c:param name="jsPrototypeName" value="Discount" />
		<c:param name="thisCategoryID" value="${categoryId}"/>
		<c:param name="thisCategoryIncludeChildItems" value="false"/>
		<c:param name="thisCategoryIncludeParentCategory" value="true"/>

		<c:param name="someCategoryIDs" value="${someCategoryIDs}"/>
		<c:param name="categoryIncludeChildItems" value="false"/>
		<c:param name="categoryIncludeParentCategory" value="false"/>

		<c:param name="someProductIDs" value="${someProductIDs}"/>
		<c:param name="productIncludeChildItems" value="true"/>
		<c:param name="productIsProdPromoOnly" value="true"/>
		<c:param name="productIncludeParentProduct" value="false"/>
	</c:import>
	<%out.flush();%>
<%-- 
***
* End:  Get all category, product and package IDs displayed on this page and pass them to the discount code
***
--%>

<%-- If the current category is a sub category, then the following setup is needed --%>
<c:if test="${empty WCParam.top}">
	<%-- Set the parentCategoryId if it is not set yet --%>
	<c:choose>
		<c:when test="${empty WCParam.parent_category_rn}">
			<c:if test="${!empty category.parentCategories}">
				<c:set var="parentCategoryId" value="${category.parentCategories[0].categoryId}" />
			</c:if>
		</c:when>
		<c:otherwise>
			<c:set var="parentCategoryId" value="${WCParam.parent_category_rn}" />
		</c:otherwise>
	</c:choose>
</c:if>

<%-- Start:  Calculate amount of entries to be shown --%>
<c:set var="numEntries" value="0"/>
<c:forEach var="count" items="${category.subCategories}" varStatus="status">
	<c:if test="${status.last}"><c:set var="numEntries" value="${status.count}"/></c:if>
</c:forEach>
<c:set var="numEntriesForSubCategories" value="${numEntries}"/>
<c:forEach var="count" items="${category.catalogEntryDataBeans}" varStatus="status">
	<c:set var="skuWithNoParent" value="false" />
	<c:if test="${count.item}">
		<c:if test="${count.itemDataBean.parentProductId eq count.itemDataBean.itemID}">
			<c:set var="skuWithNoParent" value="true" />
		</c:if>
	</c:if>
												
	<c:if test="${skuWithNoParent || (!count.item && !count.dynamicKit)}">
		<c:set var="numEntries" value="${numEntries+1}"/>
	</c:if>
</c:forEach>
<fmt:formatNumber var="totalPages" value="${(numEntries/pageSize)+1}"/>
<c:if test="${numEntries%pageSize == 0}">
	<fmt:parseNumber var="totalPages" value="${numEntries/pageSize}"/>
</c:if>
<fmt:parseNumber var="totalPages" value="${totalPages}" integerOnly="true"/>

<%-- current page starts from 0 --%>
<c:if test="${currentPage < 0}">
	<c:set var="currentPage" value="0"/>
</c:if>
<c:if test="${currentPage >= (totalPages)}">
	<c:set var="currentPage" value="${totalPages-1}"/>
</c:if>

<%-- End:  Calculate amount of entries to be shown --%>

<!-- JSP filename: CachedCategoriesDisplay.jsp -->

<%-- The displayed content is in a single table so that this snippet can be easily plugged into other pages --%>
<table align="center" cellpadding="0" cellspacing="0" width="786" border="0" id="WC_CachedCategoriesDisplay_Table_1">
<tbody>
	<tr align="center">
		<td>
			<table cellpadding="0" cellspacing="0" border="0" width="100%">
				<tr>	
					<td id="subNav" valign="top">
						<%@ include file="../../../Snippets/ReusableObjects/CategoriesSidebarDisplay.jspf"%>
					</td>
					<td valign="top">
						<h1><c:out value="${category.description.name}" escapeXml="false"/></h1>
					                                                
						<table cellpadding="0" cellspacing="0" border="0" class="t_table" id="table">
							<tr>
								<%-- Show category image and short description if available --%>
								<td class="c_large_img">
								<c:choose>
									<c:when test="${!empty category.description.fullIImage}">
										<img
											src="<c:out value="${category.objectPath}${category.description.fullIImage}" />"
											alt="<c:out value="${category.description.shortDescription}" />"
											border="0" width="${imgWidth}" height="${imgHeight}" /><br/>
									</c:when>
									<c:otherwise>
										<img 
											src="<c:out value="${jspStoreImgDir}"/>images/NoImageIcon.jpg" 
											alt="<fmt:message key="No_Image" bundle="${storeText}"/>" 
											border="0"/><br/>					
									</c:otherwise>
								</c:choose>
								<c:if test="${!empty category.description.shortDescription}">
									<br/>
									<span class="s_text"><c:out value="${category.description.shortDescription}" escapeXml="false"/></span>
									<br/>
								</c:if>
								
								<%-- 
								  ***
								  *       Start: Show Catalog Attachments
								  * The attachments for each usage will be displayed
								  ***
								--%>
								<c:forEach var="attachUsage" items="${category.attachmentUsages}" >       
								       <c:set property="attachmentUsage" value="${attachUsage.identifier}" target="${category}" />
								       <table border="0" id="WC_CatalogAttachment_Table_1">
								       <tr><td id="WC_CatalogAttachment_TableCell_1">
								              <table border="1" cellpadding="0" cellspacing="0" width="100%" id="WC_CatalogAttachment_Table_2">
								              <tr><td class="labelText1" height="16" nowrap id="WC_CatalogAttachment_TableCell_2"><span class="strongtext"><c:out value="${attachUsage.name}"  /><br /></span></td></tr>
								              </table>
								              <table border="1" width="100%" id="WC_CatalogAttachment_Table_3">
								              <tr>
								                     <td class="mainContent" id="WC_CatalogAttachment_TableCell_3"> 
								                            <c:set var="maxNumDisp" value ="4"/>
								                            <c:set var="maxItemsInRow" value ="1"/>
								                            <c:set var="showName" value="true" /> 
								                            <c:set var="showShortDescription" value="false" />
								                            <c:set var="AttachmentDataBeans" value="${category.attachmentsByUsage}" />
								                            <%@ include file="../../../Snippets/Catalog/Attachments/CatalogAttachmentAssetsDisplay.jspf" %>
								                     </td>                     
								              </tr>
								              </table>
								       </td></tr>
								       </table><br />       
								</c:forEach>
								<%--
								       ***
								       * End: Show Catalog Attachment
								       ***
								--%>
																
								<%-- We output the discounts using simple JavaScript to support older browsers such as Netscape 4  --%>
								<br/>
								<script type="text/javascript">
									document.write(Discount.getThisCategoryDiscountText(<c:out value="${categoryId}"/>));
								</script>

								</td>				
								<td valign="top">
						
									<%-- Display all the details under this category. --%>						
									<table cellpadding="0" cellspacing="0" border="0" class="t_table">
										<tr>
										<c:choose>
											<c:when test="${pageView == 'image'}">												
											<td class="ps_align" colspan="<c:out value="${resultsOnRow+(resultsOnRow-1)}"/>">
											</c:when>
											<c:otherwise>
											<td class="ps_align" colspan="3">
											</c:otherwise>
										</c:choose>
												<table cellpadding="0" cellspacing="0" border="0" class="t_table">
													<tr>
														<td>
															<table cellpadding="0" cellspacing="0" border="0">
																<tr>
																	<c:url var="categoryDisplayFirstUrl" value="CategoryDisplay">
																		<c:param name="catalogId" value="${WCParam.catalogId}" />
																		<c:param name="storeId" value="${WCParam.storeId}" />
																		<c:param name="categoryId" value="${categoryId}" />
																		<c:param name="langId" value="${langId}" />
																		<c:param name="parent_category_rn" value="${WCParam.parent_category_rn}" />
																		<c:param name="top_category" value="${WCParam.top_category}" />
																		<c:param name="top" value="${WCParam.top}" />
																		<c:param name="currentPage" value="0"/>
																		<c:param name="pageView" value="${WCParam.pageView}" />
																	</c:url>															
																	<td><a href="<c:out value="${categoryDisplayFirstUrl}" />"><img src="<c:out value="${jspStoreImgDir}${vfileColor}"/>ps_first.gif" alt="" width="14" height="14" border="0" /></a></td>
																	<c:url var="categoryDisplayPreviousUrl" value="CategoryDisplay">
																		<c:param name="catalogId" value="${WCParam.catalogId}" />
																		<c:param name="storeId" value="${WCParam.storeId}" />
																		<c:param name="categoryId" value="${categoryId}" />
																		<c:param name="langId" value="${langId}" />
																		<c:param name="parent_category_rn" value="${WCParam.parent_category_rn}" />
																		<c:param name="top_category" value="${WCParam.top_category}" />
																		<c:param name="top" value="${WCParam.top}" />
																		<c:param name="currentPage" value="${currentPage-1}"/>
																		<c:param name="pageView" value="${WCParam.pageView}" />
																	</c:url>															
																	<td class="ps_pad"><a href="<c:out value="${categoryDisplayPreviousUrl}" />"><img src="<c:out value="${jspStoreImgDir}${vfileColor}"/>ps_previous.gif" alt="" width="14" height="14" border="0" /></a></td>
																		<fmt:message var="pageNumber" key="PAGE_NUMBER" bundle="${storeText}">
																			<fmt:param><c:out value="${currentPage+1}"/></fmt:param>
																			<fmt:param><c:out value="${totalPages}"/></fmt:param>
																		</fmt:message>
																	<td class="ps_text"><c:out value="${pageNumber}"/></td>
																	<c:url var="categoryDisplayNextUrl" value="CategoryDisplay">
																		<c:param name="catalogId" value="${WCParam.catalogId}" />
																		<c:param name="storeId" value="${WCParam.storeId}" />
																		<c:param name="categoryId" value="${categoryId}" />
																		<c:param name="langId" value="${langId}" />
																		<c:param name="parent_category_rn" value="${WCParam.parent_category_rn}" />
																		<c:param name="top_category" value="${WCParam.top_category}" />
																		<c:param name="top" value="${WCParam.top}" />
																		<c:param name="currentPage" value="${currentPage+1}"/>
																		<c:param name="pageView" value="${WCParam.pageView}" />
																	</c:url>															
																	<td class="ps_pad"><a href="<c:out value="${categoryDisplayNextUrl}" />"><img src="<c:out value="${jspStoreImgDir}${vfileColor}"/>ps_next.gif" alt="" width="14" height="14" border="0" /></a></td>
																	<c:url var="categoryDisplayLastUrl" value="CategoryDisplay">
																		<c:param name="catalogId" value="${WCParam.catalogId}" />
																		<c:param name="storeId" value="${WCParam.storeId}" />
																		<c:param name="categoryId" value="${categoryId}" />
																		<c:param name="langId" value="${langId}" />
																		<c:param name="parent_category_rn" value="${WCParam.parent_category_rn}" />
																		<c:param name="top_category" value="${WCParam.top_category}" />
																		<c:param name="top" value="${WCParam.top}" />
																		<c:param name="currentPage" value="${totalPages-1}"/>
																		<c:param name="pageView" value="${WCParam.pageView}" />
																	</c:url>															
																	<td class="ps_pad"><a href="<c:out value="${categoryDisplayLastUrl}" />"><img src="<c:out value="${jspStoreImgDir}${vfileColor}"/>ps_last.gif" alt="" width="14" height="14" border="0" /></a></td>
																	<td  cellpadding="0" cellspacing="0" border="0" height="100%">
																	<form name="JumpToForm" action="CategoryDisplay" method="post" id="JumpToForm">
																	<input type="hidden" name="catalogId" value="<c:out value="${WCParam.catalogId}" />" id="WC_CachedCategoriesDisplay_FormInput_catalogId_In_JumpToForm_1"/>
																	<input type="hidden" name="storeId" value="<c:out value="${WCParam.storeId}" />" id="WC_CachedCategoriesDisplay_FormInput_storeId_In_JumpToForm_1"/>
																	<input type="hidden" name="langId" value="<c:out value="${langId}" />" id="WC_CachedCategoriesDisplay_FormInput_langId_In_JumpToForm_1"/>
																	<input type="hidden" name="categoryId" value="<c:out value="${categoryId}" />" id="WC_CachedCategoriesDisplay_FormInput_categoryId_In_JumpToForm_1"/>
																	<input type="hidden" name="parent_category_rn" value="<c:out value="${WCParam.parent_category_rn}" />" id="WC_CachedCategoriesDisplay_FormInput_top_category_rn_In_JumpToForm_1"/>
																	<input type="hidden" name="top_category" value="<c:out value="${WCParam.top_category}" />" id="WC_CachedCategoriesDisplay_FormInput_top_category_In_JumpToForm_1"/>
																	<input type="hidden" name="top" value="<c:out value="${WCParam.top}" />" id="WC_CachedCategoriesDisplay_FormInput_top_In_JumpToForm_1"/>																		
																	<input type="hidden" name="currentPage" value="" id="WC_CachedCategoriesDisplay_FormInput_currentPage_In_JumpToForm_1"/>
																	<input type="hidden" name="pageView" value="<c:out value="${WCParam.pageView}" />" id="WC_CachedCategoriesDisplay_FormInput_pageView_In_JumpToForm_1"/>			
																	<table  cellpadding="0" cellspacing="0" border="0" width="100%" height="100%"><tr>
																	<td class="ps_text"><label for="jumpToPage"><fmt:message key="JUMP_TO_PAGE" bundle="${storeText}"/></label></td>
																	<td class="ps_pad"><input type="text" id="jumpToPage" name="jumpToPage" maxlength="4" size="3" class="ps_input"/></td>
																	<td class="ps_pad"><a href="javascript:submitJump(document.JumpToForm)"><img src="<c:out value="${jspStoreImgDir}${vfileColor}"/>ps_page_jump.gif" alt="" width="16" height="16" border="0" /></a></td>
																	</tr></table>
																  </form>
																	</td>
																</tr>
															</table>
														</td>
														<td align="right">
															<table cellpadding="0" cellspacing="0" border="0">
																<tr>
																	<td class="ps_view"><img src="<c:out value="${jspStoreImgDir}${vfileColor}"/>ps_v_line.gif" alt="" width="7" height="22" border="0" /></td>
																	<c:url var="detailedViewUrl" value="CategoryDisplay">
																		<c:param name="catalogId" value="${WCParam.catalogId}" />
																		<c:param name="storeId" value="${WCParam.storeId}" />
																		<c:param name="categoryId" value="${categoryId}" />
																		<c:param name="langId" value="${langId}" />
																		<c:param name="parent_category_rn" value="${WCParam.parentCategoryId}" />
																		<c:param name="top_category" value="${WCParam.top_category}" />
																		<c:param name="top" value="${WCParam.top}" />
																		<c:param name="currentPage" value="${currentPage}"/>
																		<c:param name="pageView" value="detailed" />
																	</c:url>													
																	<td class="ps_view"><a href="<c:out value="${detailedViewUrl}" />"><img src="<c:out value="${jspStoreImgDir}${vfileColor}"/>c_icon_detail_view.gif" alt="" width="15" height="16" border="0" /></a></td>
																	<c:url var="imageViewUrl" value="CategoryDisplay">
																		<c:param name="catalogId" value="${WCParam.catalogId}" />
																		<c:param name="storeId" value="${WCParam.storeId}" />
																		<c:param name="categoryId" value="${categoryId}" />
																		<c:param name="langId" value="${langId}" />
																		<c:param name="parent_category_rn" value="${WCParam.parentCategoryId}" />
																		<c:param name="top_category" value="${WCParam.top_category}" />
																		<c:param name="top" value="${WCParam.top}" />
																		<c:param name="currentPage" value="${currentPage}"/>
																		<c:param name="pageView" value="image" />
																	</c:url>													
																	<td class="ps_view"><a href="<c:out value="${imageViewUrl}" />"><img src="<c:out value="${jspStoreImgDir}${vfileColor}"/>c_icon_img_view.gif" alt="" width="15" height="16" border="0" /></a></td>
																</tr>
															</table>
														</td>
													</tr>
												</table>
											</td>												
										</tr>											
										<%-- Start: Show subcategories with image view or detailed view --%>
										<c:if test="${!empty category.subCategories}">
										<tr>
											<%-- idCounter starts with 1 --%>
											<c:forEach var="subCategory" items="${category.subCategories}" varStatus="idCounter">
												<c:if test="${((idCounter.count > (currentPage * pageSize)) && (idCounter.count <= ((currentPage+1) * pageSize)))}">
													<%-- Always assume images exist --%>
													<c:choose>
														<c:when test="${pageView == 'image'}">
											<td class="t_img_view">
														</c:when>
														<c:otherwise>
											<td class="t_row_img" valign="top">
														</c:otherwise>
													</c:choose>														
														
													<%-- The URL command that will display the sub-category --%>
													<c:url var="categoryDisplayUrl" value="CategoryDisplay">
														<c:param name="catalogId" value="${WCParam.catalogId}" />
														<c:param name="storeId" value="${WCParam.storeId}" />
														<c:param name="categoryId" value="${subCategory.categoryId}" />
														<c:param name="langId" value="${langId}" />
														<c:param name="parent_category_rn" value="${categoryId}" />
														<c:param name="top_category" value="${categoryId}" />
														<c:param name="pageView" value="${WCParam.pageView}" />
													</c:url>
													
													<a href="<c:out value="${categoryDisplayUrl}" />" id="WC_CachedCategoriesDisplay_Link_ForSubCatImg_<c:out value="${idCounter.count}"/>">
													<c:choose>
														<c:when test="${!empty subCategory.description.thumbNail}">
															<span class="t_img_border"><img src="<c:out value="${subCategory.objectPath}${subCategory.description.thumbNail}" />" alt="<c:out value="${subCategory.description.shortDescription}" />" border="0" width="${subimgWidth}" height="${subimgHeight}" /></span>
														</c:when>
														<c:otherwise>
															<span class="t_img_border"><img src="<c:out value="${jspStoreImgDir}"/>images/NoImageIcon_sm.jpg" alt="<fmt:message key="No_Image" bundle="${storeText}"/>" border="0"/></span>
														</c:otherwise>
													</c:choose>
													</a><br/>
													<c:if test="${pageView == 'image'}">
														<br/>
													</c:if>
													<c:if test="${pageView == 'detailed'}">
											</td><td class="t_row_detail">
													</c:if>
												<span class="productName">
													<a href="<c:out value="${categoryDisplayUrl}" />" id="WC_CachedCategoriesDisplay_Link_ForSubCat_<c:out value="${idCounter.count}"/>">
														<c:out value="${subCategory.description.name}" escapeXml="false"/>
													</a>
												</span><br/>
													<c:if test="${pageView == 'detailed'}">
												<span class="t_txt_detail">
													<c:out value="${subCategory.description.shortDescription}" escapeXml="false"/>
												</span>
												<%-- Code changes for defect 116585 - START --%>
												<!-- 	The code below is added to display discount link for subcategories.	
													For "Image" view it will display link with default text
													For "Detail" view it will display the short decription of the promotion.	-->
													</c:if>
													<br/>
													<c:if test="${empty hideDiscounts || hideDiscounts == false}">
														<c:remove var="discounts"/>
														<wcbase:useBean id="discounts" classname="com.ibm.commerce.fulfillment.beans.CalculationCodeListDataBean">
															<c:set property="catalogGroupId" value="${subCategory.categoryId}" target="${discounts}" />
															<c:set property="includeParentCategory" value="$true" target="${discounts}" />			
															<c:set property="includeChildItems" value="true" target="${discounts}" />
															<%-- UsageId for discount is -1 --%>
															<c:set property="calculationUsageId" value="-1" target="${discounts}" />
														</wcbase:useBean>

														<c:if test="${ !empty discounts.calculationCodeDataBeans }" >
															<c:forEach var="discountEntry" items="${discounts.calculationCodeDataBeans}" varStatus="discountCounter">
																<c:set var="hasDiscount" value="true"/>
																<c:url var="DiscountDetailsDisplayViewURL" value="DiscountDetailsDisplayView">
																	<c:param name="code" value="${discountEntry.code}" />
																	<c:param name="langId" value="${langId}" />
																	<c:param name="storeId" value="${WCParam.storeId}" />
																	<c:param name="catalogId" value="${WCParam.catalogId}" />
																</c:url>
																
																<c:choose>
																	<c:when test="${pageView == 'image'}">
																		<img src="<c:out value="${hostPath}"/><c:out value="${jspStoreImgDir}" />images/Discount_star.gif" alt="<c:out value="${discountEntry.descriptionString}" escapeXml="false" />" align="middle"/>
																		<a class="discount" href='<c:out value="${DiscountDetailsDisplayViewURL}" />' id="WC_CatalogEntryThumbnailDisplay_Link_1_<c:out value="${discountCounter.count}"/>_<c:out value="${counter.count}"/>">
																			<fmt:message key="PRODUCT_DISCOUNT_DETAILS" bundle="${storeText}" />
																		</a>
																	</c:when>
																	<c:otherwise>
																		<br/>
																		<img src="<c:out value="${hostPath}"/><c:out value="${jspStoreImgDir}" />images/Discount_star.gif" alt="<c:out value="${discountEntry.descriptionString}" escapeXml="false" />" align="middle"/>
																		<a class="discount" href='<c:out value="${DiscountDetailsDisplayViewURL}" />' id="WC_CatalogEntryThumbnailDisplay_Link_1_<c:out value="${discountCounter.count}"/>_<c:out value="${counter.count}"/>">
																			<c:out value="${discountEntry.descriptionString}" escapeXml="false" />
																		</a>
																	</c:otherwise>
																</c:choose>
															</c:forEach>
															<c:if test="${pageView == 'detailed'}">
											</td>
											<td>&nbsp;
											<br />
															</c:if>
														</c:if>
													</c:if>
												<%-- Code changes for defect 116585 - END --%>
											</td>
													<%-- Set the last column number we drew so we know what column to draw next --%>
													<c:set var="numberOfResults" value="${numberOfResults+1}" />
													
													<c:choose>
													<c:when test="${(numberOfResults % resultsOnRow) == 0}">
										</tr><tr>
														<c:if test="${pageView == 'detailed'}">
											<td class="t_line" colspan="3">&nbsp;
											</td>
										</tr>
										<tr>																
														</c:if>

														<c:set var="numberOfResults" value="0" />
													</c:when>
													<c:otherwise>
														<c:if test="${pageView == 'image'}">
											<td class="t_empty_cell">&nbsp;</td>
														</c:if>
													</c:otherwise>
													</c:choose>
												</c:if>
											</c:forEach>												
										<td></td>
										</tr>
										</c:if>
										<%-- End: Show subcategories with image view --%>
										<tr>
										<%-- CatEntries under top categories allowed? --%>
										<%-- <c:if test="${empty WCParam.top}"> --%>
											<%-- statusCounter starts with 0 if no subcategories listed --%>
											<c:set var="statusCounter" value="0" />
											<c:forEach var="catEntry" items="${category.catalogEntryDataBeans}" varStatus="idCounter">
												<c:set var="skuWithNoParent" value="false" />
												<c:if test="${catEntry.item}">
													<c:if test="${catEntry.itemDataBean.parentProductId eq catEntry.itemDataBean.itemID}">
														<c:set var="skuWithNoParent" value="true" />
													</c:if>
												</c:if>
												
												<c:if test="${skuWithNoParent || (!catEntry.item && !catEntry.dynamicKit)}">
													<c:if test="${((statusCounter >= (currentPage * pageSize - numEntriesForSubCategories)) && (statusCounter < ((currentPage+1) * pageSize - numEntriesForSubCategories)))}">
											<td valign="top" id="WC_CachedCategoriesDisplay_TableCell_ForProduct_<c:out value="${idCounter.count}"/>" width="<c:out value="${columnWidth}"/>" class="innerDashedLines">
												<table cellpadding="0" cellspacing="0" border="0" id="WC_CachedCategoriesDisplay_Table_1_<c:out value="${idCounter.count}"/>" width="100%">
												<tbody>
													<tr>
														<td class="t_img_view" valign="top" id="WC_CachedCategoriesDisplay_TableCell_Product_<c:out value="${idCounter.count}"/>">
														<%-- We output the discounts using custom logic to support caching after using the thumbnail --%>
														<%-- <c:set var="hideDiscounts" value="true"/> --%>
														<c:set var="thumbnailCounter" value="${idCounter.count}"/>
														<%@ include file="../../../Snippets/ReusableObjects/CatalogEntryThumbnailDisplay.jspf" %>
														</td>
													</tr>
												</tbody>
												</table>
											</td>
														
														<%-- Set the last column number we drew so we know what column to draw next --%>
														<c:set var="numberOfResults" value="${numberOfResults+1}" />
													
														<%-- end new row for every x number of  products --%>
														<c:if test="${(numberOfResults % resultsOnRow) == 0}">
										</tr><tr>
															<c:if test="${pageView == 'detailed'}">
											<td class="t_line" colspan="3">&nbsp;</td>
										</tr><tr>																
															</c:if>
														</c:if>
													</c:if>
													<c:set var="statusCounter" value="${statusCounter+1}" />								                                                	
												</c:if>
											</c:forEach>
								
											<%-- If we end up with a row showing less then x number of products, we draw the remaining columns to complete the table --%>
											<c:if test="${(idCounter.count+numberOfResults) % resultsOnRow != 0}">
											<td colspan="<c:out value="${resultsOnRow - ((idCounter.count+numberOfResults) % resultsOnRow)}" />" width="<c:out value="${columnWidth}"/>" id="WC_CachedCategoriesDisplay_TableCell_columnFiller_1"><br/>
											</td>
											</c:if>
<td></td>
										</tr>
										<%-- </c:if> --%>
									</table>
								
									<%-- Display all the associated up-sells, cross-sells, and accessories available to this category. --%>
									
									<c:if test="${category.merchandisingAssociated}">
									<table cellpadding="0" cellspacing="0" border="0" class="t_table">									
										<tr>
											<td valign="top" colspan="3" class="categoryspace" id="WC_CachedCategoriesDisplay_TableCell_5">
												<table cellpadding="3" cellspacing="0" border="0" id="WC_CachedCategoriesDisplay_Table_7">
												<tbody>
													<tr>
														<td width="256" valign="top" id="WC_CachedCategoriesDisplay_TableCell_6">
																	<%-- Display heading for the cross-sell categories, if there is at least one associated cross-sell  --%>
																	<c:if test="${!empty category.categoryCrossSells}">
															<span class="strongtext"><fmt:message key="CATEGORY_XSELL" bundle="storeText" /></span>
																<br/><br/>
																	</c:if> <%-- Display all the cross-sell categories, one per row within the same table cell --%>
																	<c:forEach var="crossSellCategory" items="category.categoryCrossSells" varStatus="counter">
																	<c:url var="categoryXSellUrl" value="CategoryDisplay">
																		<c:param name="catalogId" value="${WCParam.catalogId}" />
																		<c:param name="storeId" value="${WCParam.storeId}" />
																		<c:param name="categoryId" value="${crossSellCategory.category.categoryId}" />
																		<c:param name="langId" value="${langId}" />
																	</c:url>
															<span class="productName"> 
																<a href="<c:out value="${categoryXSellUrl}"/>" id="WC_CachedCategoriesDisplay_Link_ForCrossSell_<c:out value="${counter.count}"/>">
																	<c:out value="${crossSellCategory.category.description.name}" escapeXml="false"/>
																</a>
															</span><br/>
																	</c:forEach> <%-- Display heading for the up-sell categories, if there is at least one associated up-sell  --%>
																	<c:if test="${!empty category.categoryUpSells}">
																		<span class="strongtext"><fmt:message key="CATEGORY_UPSELL" bundle="storeText" /></span>
																		<br/><br/>
																	</c:if> 
																	<%-- Display all the up-sell categories, one per row within the same table cell --%>
																	<c:forEach var="upSellCategory" items="category.categoryUpSells" varStatus="counter">
																	<c:url var="categoryUpSellUrl" value="CategoryDisplay">
																		<c:param name="catalogId" value="${WCParam.catalogId}" />
																		<c:param name="storeId" value="${WCParam.storeId}" />
																		<c:param name="categoryId" value="${upSellCategory.category.categoryId}" />
																		<c:param name="langId" value="${langId}" />
																	</c:url>
															<span class="productName"> 
																<a href="<c:out value="${categoryUpSellUrl}"/>"	id="WC_CachedCategoriesDisplay_Link_ForUpSell_<c:out value="${counter.count}"/>">
																	<c:out value="${upSellCategory.category.description.name}" escapeXml="false"/>
																</a>
															</span><br/>
																	</c:forEach> <%-- Display heading for the accessories categories, if there is at least one accessories up-sell  --%>
																<c:if test="${!empty category.categoryAccessories}">
															<span class="strongtext">
																<fmt:message key="CATEGORY_ACCESSORY" bundle="storeText" />
															</span><br/><br/>
																</c:if> <%-- Display all the accessories categories, one per row within the same table cell --%>
																<c:forEach var="accessoriesCategory" items="category.categoryAccessories" varStatus="counter">
																	<c:url var="categoryAccessoriesUrl" value="CategoryDisplay">
																		<c:param name="catalogId" value="${WCParam.catalogId}" />
																		<c:param name="storeId" value="${WCParam.storeId}" />
																		<c:param name="categoryId" value="${accessoriesCategory.category.categoryId}" />
																		<c:param name="langId" value="${langId}" />
																	</c:url>
															<span class="productName"> 
																<a href="<c:out value="${categoryAccessoriesUrl}"/>" id="WC_CachedCategoriesDisplay_Link_ForAccessories_<c:out value="${counter.count}"/>">
																	<c:out value="${accessoriesCategory.category.description.name}" escapeXml="false" />
																</a>
															</span><br/>
																</c:forEach>
														</td>
													</tr>
												</tbody>
												</table>									
											</td>
										</tr>
									</table>
									</c:if>
									<%--End Cross-Sell, Up-Sell, Accessory	--%>											
								</td>
							</tr>
						</table>							
					</td>
				</tr>
			</table>
		</td>
	</tr>
</tbody>
</table>						

<script type="text/javascript" language="javascript">
<!-- <![CDATA[
var busy = false;
<%-- 
  ***
  * This javascript function is used by the 'Jump to page' icon.
  ***
 --%>
function submitJump(form)
{
    if ( form.jumpToPage.value >=1 && form.jumpToPage.value <= <c:out value="${totalPages}" /> ) {
       if (!busy) {
              busy = true;
              form.currentPage.value = form.jumpToPage.value-1;
              form.submit();
       }
    } else {
    	alert("<fmt:message key="SEARCH_INVALID_PAGE_NUM" bundle="${storeText}"/>");
    }
}
//[[>-->  
</script>			
<!-- End - JSP filename: CachedCategoriesDisplay.jsp -->
