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
  * DiscountDetailsDisplay.jsp displays the details of a discount code
  * - for item level discounts, display short and long description of the discount and the associated items and a clickable short
  *   description that links to the Item Display page
  * - for product level discounts, display short and long description of the discount and the associated products and a clickable
  *   name that links to the Product Display page
  * - for category level discounts, display the short and long description of the discount
  *****
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ taglib uri="http://commerce.ibm.com/coremetrics"  prefix="cm" %>
<%@ include file="../../include/JSTLEnvironmentSetup.jspf"%>
<%@ include file="../../include/nocache.jspf"%>

<wcbase:useBean id="calculationCodeListDB" classname="com.ibm.commerce.fulfillment.beans.CalculationCodeListDataBean">
	<c:set property="calculationUsageId" value="-1" target="${calculationCodeListDB}"/>
	<c:set property="code" value="${WCParam.code}" target="${calculationCodeListDB}"/>
	<c:set property="excludePromotionCode" value="false" target="${calculationCodeListDB}"/>
	<c:set property="storeId" value="${WCParam.pStoreId}" target="${calculationCodeListDB}"/>
</wcbase:useBean>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="${shortLocale}" xml:lang="${shortLocale}">
<head>
	<title>
		<fmt:message key="DISCOUNT_DETAILS_TITLE" bundle="${storeText}">
		<fmt:param value="${storeName}"/>
		</fmt:message>
	</title>
<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${vfileStylesheet}"/>" type="text/css"/>
<!--[if lte IE 6]>
<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${vfileStylesheetie}"/>" type="text/css"/>
<![endif]-->
<script type="text/javascript" src="<c:out value="${dojoFile}"/>" djConfig="${dojoConfigParams}"></script>
<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/MessageHelper.js"/>"></script>
<%@ include file="../../include/CommonJSToInclude.jspf"%>
</head>

<body>
<%@ include file="../../include/StoreCommonUtilities.jspf"%>
<!-- Page Start -->
<div id="page">
	<!-- Header Nav Start -->
	<%@ include file="../../include/LayoutContainerTop.jspf"%>
	<!-- Header Nav End -->
	<div id="MessageArea" >
		<br />
		<span id="ErrorMessageText" class="error_msg">
			
		</span>
		<br /><br />  
	</div>
	<!-- Main Content Start -->
	<div id="content_wrapper_border">

		<!-- Content Start -->
		<div id="box">
		
		<%-- CalculationCodeListDataBean is used to show the discount information of the product --%>
		<c:set var="calculationCodeDBs" value="${calculationCodeListDB.calculationCodeDataBeans}" scope="request"/>
			
		<%--
			***
			* Start check for valid discount.
			* - if true, then display the discount description and long description and the products associated with the discount.
			* - if false, then display error message stating that there is no valid discount.
			***
		--%>
		<tr>
			<td valign="top" id="WC_DiscountDetailsDisplay_td_3">
				<span class="heading"><fmt:message key="DISCOUNT_DETAILS_TITLE" bundle="${storeText}"/></span>
			</td>
		</tr>

<c:choose>
	<c:when test="${ !empty calculationCodeDBs }"  >
		<div id="WC_DiscountDetailsDisplay_div_1">
				<%-- Show the description of the discount --%>
				<span class="discount">
					<img src="<c:out value="${jspStoreImgDir}" />images/Discount_star.gif" alt="<c:out value="${calculationCodeDBs[0].descriptionString}" />" align="middle"/>&nbsp;<c:out value="${calculationCodeDBs[0].descriptionString}" />
				</span>
		</div>
		<div id="WC_DiscountDetailsDisplay_div_2">
				<%-- Show the long description of the discount --%>
				<span>
					<c:out value="${calculationCodeDBs[0].longDescriptionString}" escapeXml="false" />
				</span>
		</div>

		<tr>
			<td valign="top" id="WC_DiscountDetailsDisplay_TableCell_9">
				<br />
				<table cellpadding="0" cellspacing="0" border="0" id="WC_DiscountDetailsDisplay_Table_3">
				<tbody>
					<tr>
						<%--
							***
							* Begin check for discounted products.  For each product, get the parent product and then display the product short description and link to product display page.
							***
						--%>
						<td valign="top" id="WC_DiscountDetailsDisplay_TableCell_10">
							<table cellpadding="0" cellspacing="0" border="0" id="WC_DiscountDetailsDisplay_Table_4">
								<%-- Display the discounted category --%>

								<c:if test="${!empty WCParam.categoryId}">
									<tr>
										<wcbase:useBean id="category" classname="com.ibm.commerce.catalog.beans.CategoryDataBean" scope="page">
											<c:set target="${category}" property="catalogId" value="${WCParam.catalogId}" />
										</wcbase:useBean>

										<c:if test="${!empty category.description.fullIImage || !empty category.description.shortDescription}">
											<td valign="top" class="categoryspace" width="165" id="WC_CachedCategoriesDisplay_TableCell_3">
											<%-- Show category image and short description if available --%>
											<c:if test="${!empty category.description.fullIImage}">
												<%-- URL that links to the category display page --%>
												<c:url var="categoryDisplayUrl" value="CategoryDisplay">
													<c:param name="catalogId" value="${WCParam.catalogId}"/>
													<c:param name="storeId" value="${WCParam.storeId}"/>
													<c:param name="categoryId" value="${category.categoryId}"/>
													<c:param name="langId" value="${langId}"/>
													<c:param name="top" value="Y"/>
												</c:url>

												<div align="center" id="WC_DiscountDetailsDisplay_div_3">
													<a href="<c:out value="${categoryDisplayUrl}"/>" id="WC_DiscountDetailsDisplay_Link_Cat_1">
														<img src="<c:out value="${category.objectPath}${category.description.fullIImage}"/>" alt="<c:out value="${category.description.name}"/>" border="0" />
													</a>
												</div>
											</c:if>
											</td>
										</c:if>
									</tr>
										<c:if test="${!empty category.description.shortDescription}">
									<tr>
										<td id="WC_DiscountDetailsDisplay_td_1">
											<span class="text"><c:out value="${category.description.shortDescription}" /></span>
										</td>
									</tr>
									</c:if>
								</c:if>
								<tr>
									<td id="WC_DiscountDetailsDisplay_td_2"></td>
									<%-- Set the number of items to show on each row --%>

									<c:set var="maxInRow" value="4"/>
									<c:forEach var="catalogEntry" items="${calculationCodeDBs[0].attachedCatalogEntryDataBeans}" varStatus="counter">
										<c:set var="discountCatalogEntryDB" value="${catalogEntry}"/>

										<%-- Display the associated products with the discount code --%>
										<td valign="top" align="center" id="WC_DiscountDetailsDisplay_TableCell_11_<c:out value="${counter.count}"/>">
										
										<%-- Will only execute the following code if the catalog entry is not a dynamic kit --%>		
										<c:if test="${empty discountCatalogEntryDB.dynamicKitDataBean}" >
												<span class="productName">
													<%-- URL that links to the Product Display Page --%>
													<c:url var="ProductDisplayURL" value="ProductDisplay">
														<c:param name="langId" value="${langId}" />
														<c:param name="storeId" value="${WCParam.storeId}" />
														<c:param name="catalogId" value="${WCParam.catalogId}" />
														<c:param name="productId" value="${discountCatalogEntryDB.catalogEntryReferenceNumber}" />
													</c:url>
													<a href="<c:out value="${ProductDisplayURL}"/>" id="WC_DiscountDetailsDisplay_Link_1_<c:out value="${counter.count}"/>">
														<c:choose>
															<c:when test="${!empty discountCatalogEntryDB.description.fullImage}">
																<img src="<c:out value="${discountCatalogEntryDB.objectPath}" /><c:out value="${discountCatalogEntryDB.description.fullImage}" />" alt="<c:out value="${discountCatalogEntryDB.description.shortDescription}" />" border="0"/>
															</c:when>
															<c:otherwise>
																<img src="<c:out value="${jspStoreImgDir}"/>images/NoImageIcon.jpg" alt="<fmt:message key="No_Image" bundle="${storeText}"/>" border="0"/>						
															</c:otherwise>
														</c:choose>
														<br /><c:out value="${discountCatalogEntryDB.description.name}" escapeXml="false"  /><br /><br />
													</a>
												</span>
												 <%--
												  ***
												  *	Start: discountCatalogEntryDB.productDataBean Price
												  * The 1st choose block below determines the way to show the discountCatalogEntryDB.productDataBean contract price: a) no price available, b) the minimum price, c) the price range.
												  * The 2nd choose block determines whether to show the list price.
												  * List price is only displayed if it is greater than the discountCatalogEntryDB.productDataBean price and if the discountCatalogEntryDB.productDataBean does not have price range (i.e. min price == max price)
												  ***
												--%>
												<c:choose>
													<c:when test="${catalogEntry.product}">
													 	<c:set var="type" value="product"/>
														<c:set var="catalogEntryDB" value="${catalogEntry.productDataBean}"/>
														<%@ include file="../../Snippets/ReusableObjects/CatalogEntryPriceDisplay.jspf"%>
													</c:when>
													<c:otherwise>
														<c:set var="discountItemDB" value="${catalogEntry}"/>
														<c:choose>
															<c:when test="${(empty discountItemDB.listPrice)&&(empty discountItemDB.calculatedContractPrice)}" >
																<c:set var="productDataBeanPriceString"><fmt:message key="NO_PRICE_AVAILABLE" bundle="${storeText}" /></c:set>
															</c:when>
															<c:when test="${ discountItemDB.listPriced && (!empty discountItemDB.listPrice) && (!empty discountItemDB.calculatedContractPrice) && (discountItemDB.calculatedContractPrice.amount < discountItemDB.listPrice.amount)}" >
																<c:set var="productDataBeanPriceString" value="${discountItemDB.calculatedContractPrice}" />
																<!-- The empty gif are put in front of the prices so that the alt text can be read by the IBM Homepage Reader to describe the two prices displayed.
																These descriptions are necessary for meeting Accessibility requirements -->
																<a href="#" id="WC_CacheddiscountCatalogEntryDB.productDataBeanOnlyDisplay_Link_2"><img src="<c:out value="${jspStoreImgDir}" />images/empty.gif" alt='<fmt:message key="RegularPriceIs" bundle="${storeText}" />' width="1" height="1" border="0"/></a>
																<span class="listPrice"><c:out value="${discountItemDB.listPrice}" escapeXml="false" /></span>
																<br />
																<a href="#" id="WC_CachedProductOnlyDisplay_Link_3_<c:out value='${counter.count}'/>"><img src="<c:out value="${jspStoreImgDir}" />images/empty.gif" alt='<fmt:message key="SalePriceIs" bundle="${storeText}" />' width="1" height="1" border="0"/></a>
																<span class="redPrice"><c:out value="${productDataBeanPriceString}" escapeXml="false" /></span>
															</c:when>
													 		<c:otherwise>
															<%--	The empty gif are put in front of the prices so that the alt text can be read by the IBM Homepage Reader to describe the two prices displayed.
																These descriptions are necessary for meeting Accessibility requirements --%>
																<a href="#" id="WC_CacheddiscountCatalogEntryDB.productDataBeanOnlyDisplay_Link_4"><img src="<c:out value="${jspStoreImgDir}" />images/empty.gif" alt='<fmt:message key="PriceIs" bundle="${storeText}" />' width="1" height="1" border="0"/></a>
																<span class="price">
																	<fmt:formatNumber value="${discountItemDB.calculatedContractPrice.amount}" type="currency" currencySymbol="${currencyFormatterDB.currencySymbol}" maxFractionDigits="${currencyDecimal}"/>	
																</span>
															</c:otherwise>
														</c:choose>
													</c:otherwise>
												</c:choose>
											</c:if>

											</td>
											<%--
												***
												* Draw another row if number of items/products displayed on this row is greater than
												* the number specified by MaxInRow
												***
											--%>
											<c:if test="${(counter.count) % maxInRow==0 }">
												</tr>
												<tr>
											</c:if>
									</c:forEach>
								</tr>

								<tr>
									<td colspan="<c:out value="${maxInRow}"/>" id="WC_DiscountDetailsDisplay_TableCell_12">
										<br />
										<span class="discount">
											<img src="<c:out value="${jspStoreImgDir}" />images/Discount_star.gif" alt="<fmt:message key="DETAILED_DISCOUNT_DISCLAIMER" bundle="${storeText}"/>" align="middle"/>&nbsp;<fmt:message key="DETAILED_DISCOUNT_DISCLAIMER" bundle="${storeText}"/>
										</span>
									</td>
								</tr>
							</table>
						</td>
				<%--
					***
					* End check for discounted products.
					***
				--%>

					</tr>
				</tbody>
				</table>
			</td>
		</tr>
	</c:when>
	<c:otherwise>
		<tr>
			<td id="WC_DiscountDetailsDisplay_TableCell_13">
				<fmt:message key="DISCOUNTDETAILS_ERROR" bundle="${storeText}"/>
			</td>
		</tr>
	</c:otherwise>
</c:choose>
		<%--
			***
			* End check for valid discount
			***
		--%>
		</div>
		<!-- Content End -->
	</div>
	<!-- Main Content End -->
	
	<!-- Footer Start -->
	<%@ include file="../../include/LayoutContainerBottom.jspf"%>
	<!-- Footer End -->
	
</div>	
<!-- Page End -->
<div id="page_shadow" class="shadow"></div>
<flow:ifEnabled feature="Analytics"><cm:pageview/></flow:ifEnabled>
</body>
</html>
