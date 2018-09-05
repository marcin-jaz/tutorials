<%
/*
 *-------------------------------------------------------------------
 * Licensed Materials - Property of IBM
 *
 * WebSphere Commerce
 *
 * (c) Copyright International Business Machines Corporation. 2004
 *     All rights reserved.
 *
 * US Government Users Restricted Rights - Use, duplication or
 * disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
 *
 *-------------------------------------------------------------------
 */
%>
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

<!-- Start - JSP File Name:  DiscountDetailsDisplay.jsp -->

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../include/JSTLEnvironmentSetup.jspf"%>

<wcbase:useBean id="calculationCodeListDB" classname="com.ibm.commerce.fulfillment.beans.CalculationCodeListDataBean">
	<c:set property="calculationUsageId" value="-1" target="${calculationCodeListDB}"/>
	<c:set property="code" value="${WCParam.code}" target="${calculationCodeListDB}"/>
	<c:set property="excludePromotionCode" value="false" target="${calculationCodeListDB}"/>
	<c:set property="storeId" value="${WCParam.pStoreId}" target="${calculationCodeListDB}"/>
</wcbase:useBean>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
	<title><fmt:message key="DISCOUNT_DETAILS_TITLE" bundle="${storeText}" /></title>
	<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${vfileStylesheet}"/>" type="text/css"/>
</head>

<body class="noMargin">
<%@ include file="../../include/LayoutContainerTop.jspf"%>

<table cellpadding="0" cellspacing="0" border="0" width="600" id="WC_DiscountDetailsDisplay_Table_1">
	<tbody>

		<tr>

			<td width="600" valign="top" class="mainContent" id="WC_DiscountDetailsDisplay_TableCell_3">

				<!--MAIN CONTENT STARTS HERE-->

				<table cellpadding="2" cellspacing="0" width="580" border="0" id="WC_DiscountDetailsDisplay_Table_2">
				<tbody>
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
						<td width="10" rowspan="10" id="WC_DiscountDetailsDisplay_TableCell_4">
							&nbsp;
						</td>
						<td class="categoryspace" width="580" id="WC_DiscountDetailsDisplay_TableCell_5">
							<h1>
								<fmt:message key="DISCOUNT_DETAILS_TITLE" bundle="${storeText}"/>
							</h1>

						</td>
					</tr>
					<c:choose>
						<c:when test="${ !empty calculationCodeDBs }"  >
								<tr>
									<td valign="top" class="categoryspace" id="WC_DiscountDetailsDisplay_TableCell_7">
										<%-- Show the description of the discount --%>
										<img src="<c:out value="${jspStoreImgDir}" />images/Discount_star.gif" alt="<c:out value="${calculationCodeDBs[0].descriptionString}" />" align="middle"/>&nbsp;<strong><c:out value="${calculationCodeDBs[0].descriptionString}" /></strong>

									</td>
								</tr>
								<tr>
									<td valign="top" width="580" class="topspace" id="WC_DiscountDetailsDisplay_TableCell_8">
										<%-- Show the long description of the discount --%>
											<c:out value="${calculationCodeDBs[0].longDescriptionString}" escapeXml="false" />

									</td>
								</tr>

								<tr>
									<td valign="top" width="580" class="topspace" id="WC_DiscountDetailsDisplay_TableCell_9">
										<br />
										<table cellpadding="5" cellspacing="0" border="0" id="WC_DiscountDetailsDisplay_Table_3">
											<tbody>
												<tr>
													<%--
														***
														* Begin check for discounted products.  For each product, get the parent product and then display the product short description and link to product display page.
														***
													--%>
													<td valign="top" colspan="3" width="580" class="topspace" id="WC_DiscountDetailsDisplay_TableCell_10">
														<table cellpadding="5" cellspacing="0" border="0" id="WC_DiscountDetailsDisplay_Table_4">
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
																				<c:param name="top" value="${WCParam.top}"/>
																			</c:url>

																			<div align="center">
																				<a href="<c:out value="${categoryDisplayUrl}"/>" id="WC_DiscountDetailsDisplay_Link_Cat_1">
																					<img src="<c:out value="${category.objectPath}${category.description.fullIImage}"/>" alt="<c:out value="${category.description.name}"/>" border="0" />
																				</a>
																			</div>
																		</c:if>
																		</td>
																	</c:if>
																	<c:if test="${!empty category.description.shortDescription}">
																		<span class="text"><c:out value="${category.description.shortDescription}" /></span>

																	</c:if>
																</tr>
															</c:if>
															<tr>
																<%-- Set the number of items to show on each row --%>

																<c:set var="maxInRow" value="4"/>
																<c:forEach var="catalogEntry" items="${calculationCodeDBs[0].attachedCatalogEntryDataBeansForPromotion}" varStatus="counter">
																	<c:set var="discountCatalogEntryDB" value="${catalogEntry}"/>

																	<%-- Display the associated products with the discount code --%>
																	<td valign="top" width="100" id="WC_DiscountDetailsDisplay_TableCell_11_<c:out value="${counter.count}"/>">
																		<span class="productName">
																			<%-- URL that links to the Product Display Page --%>
																			<c:choose>
																			<c:when test="${catalogEntry.package}" >
																			<c:url var="ProductDisplayURL" value="PackageDisplay">
																				<c:param name="langId" value="${langId}" />
																				<c:param name="storeId" value="${WCParam.storeId}" />
																				<c:param name="catalogId" value="${WCParam.catalogId}" />
																				<c:param name="productId" value="${discountCatalogEntryDB.catalogEntryReferenceNumber}" />
																			</c:url>
																			</c:when>
																			<c:otherwise>
																			<c:url var="ProductDisplayURL" value="ProductDisplay">
																				<c:param name="langId" value="${langId}" />
																				<c:param name="storeId" value="${WCParam.storeId}" />
																				<c:param name="catalogId" value="${WCParam.catalogId}" />
																				<c:param name="productId" value="${discountCatalogEntryDB.catalogEntryReferenceNumber}" />
																			</c:url>
																			</c:otherwise>
																			</c:choose>

																			<a href="<c:out value="${ProductDisplayURL}"/>" id="WC_DiscountDetailsDisplay_Link_1_<c:out value="${counter.count}"/>">
																				<img src="<c:out value="${discountCatalogEntryDB.objectPath}" /><c:out value="${discountCatalogEntryDB.description.fullImage}" />" alt="<c:out value="${discountCatalogEntryDB.description.shortDescription}" />" border="0"/>
																				<br /><c:out value="${discountCatalogEntryDB.description.name}" escapeXml="false"  /><br />
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

																			 	<c:choose>
																					<c:when test="${empty discountCatalogEntryDB.productDataBean.maximumItemPrice}" >
																						<c:set var="productDataBeanPriceString"><fmt:message key="NO_PRICE_AVAILABLE" bundle="${storeText}" /></c:set>
																					</c:when>
																					<c:when test="${discountCatalogEntryDB.productDataBean.maximumItemPrice.amount == discountCatalogEntryDB.productDataBean.minimumItemPrice.amount}" >
																						<c:set var="productDataBeanPriceString" value="${discountCatalogEntryDB.productDataBean.minimumItemPrice}" />
																					</c:when>
																					<c:otherwise>
																						<c:set var="productDataBeanPriceString" value="${discountCatalogEntryDB.productDataBean.minimumItemPrice} - ${discountCatalogEntryDB.productDataBean.maximumItemPrice}" />
																					</c:otherwise>
																				</c:choose>
																				<c:choose>
																			<%-- show the list price only if it is greater than the discountCatalogEntryDB.productDataBean price and if the discountCatalogEntryDB.productDataBean does not have price range (i.e. min price == max price) --%>

																					<c:when test="${ discountCatalogEntryDB.productDataBean.listPriced && (!empty discountCatalogEntryDB.productDataBean.maximumItemPrice) && (discountCatalogEntryDB.productDataBean.maximumItemPrice.amount < discountCatalogEntryDB.productDataBean.listPrice.amount) && (discountCatalogEntryDB.productDataBean.maximumItemPrice.amount == discountCatalogEntryDB.productDataBean.minimumItemPrice.amount)}" >
																						<!-- The empty gif are put in front of the prices so that the alt text can be read by the IBM Homepage Reader to describe the two prices displayed.
																						These descriptions are necessary for meeting Accessibility requirements -->
																						<a href="#" id="WC_CacheddiscountCatalogEntryDB.productDataBeanOnlyDisplay_Link_2"><img src="<c:out value="${jspStoreImgDir}" />images/empty.gif" alt='<fmt:message key="RegularPriceIs" bundle="${storeText}" />' width="1" height="1" border="0"/></a>
																						<span class="listPrice"><c:out value="${discountCatalogEntryDB.productDataBean.listPrice}" escapeXml="false" /></span>
																						<br />
																						<a href="#" id="WC_CachedProductOnlyDisplay_Link_3"><img src="<c:out value="${jspStoreImgDir}" />images/empty.gif" alt='<fmt:message key="SalePriceIs" bundle="${storeText}" />' width="1" height="1" border="0"/></a>
																						<span class="offerPrice"><c:out value="${productDataBeanPriceString}" escapeXml="false" /></span>


																					</c:when>
																					 <c:otherwise >
																					<%--	The empty gif are put in front of the prices so that the alt text can be read by the IBM Homepage Reader to describe the two prices displayed.
																						These descriptions are necessary for meeting Accessibility requirements --%>
																						<a href="#" id="WC_CacheddiscountCatalogEntryDB.productDataBeanOnlyDisplay_Link_4"><img src="<c:out value="${jspStoreImgDir}" />images/empty.gif" alt='<fmt:message key="PriceIs" bundle="${storeText}" />' width="1" height="1" border="0"/></a>
																						<span class="price"><c:out value="${productDataBeanPriceString}" escapeXml="false" /> </span>
																					</c:otherwise>
																				</c:choose>
																			</c:when>
																			<c:otherwise>
																				<c:set var="discountItemDB" value="${catalogEntry}"/>

																				<c:choose>

																					<%-- c:when test="${(empty discountItemDB.listPrice)&&(empty discountItemDB.calculatedContractPrice)}" --%>
																					<c:when test="${ !discountItemDB.listPriced &&(empty discountItemDB.calculatedContractPrice)}" >
																						<c:set var="productDataBeanPriceString"><fmt:message key="NO_PRICE_AVAILABLE" bundle="${storeText}" /></c:set>
																					</c:when>

																					<c:when test="${ discountItemDB.listPriced && (!empty discountItemDB.listPrice) && (!empty discountItemDB.calculatedContractPrice) && (discountItemDB.calculatedContractPrice.amount < discountItemDB.listPrice.amount)}" >
																						<c:set var="productDataBeanPriceString" value="${discountItemDB.calculatedContractPrice}" />
																						<!-- The empty gif are put in front of the prices so that the alt text can be read by the IBM Homepage Reader to describe the two prices displayed.
																						These descriptions are necessary for meeting Accessibility requirements -->
																						<fmt:message key="RegularPriceIs" bundle="${storeText}" />
																						<a href="#" id="WC_CacheddiscountCatalogEntryDB.productDataBeanOnlyDisplay_Link_2"><img src="<c:out value="${jspStoreImgDir}" />images/empty.gif" alt='<fmt:message key="RegularPriceIs" bundle="${storeText}" />' width="1" height="1" border="0"/></a>
																						<span class="listPrice">
																						<c:out value="${discountItemDB.listPrice}" escapeXml="false" /></span>
																						<br />
																						<fmt:message key="SalePriceIs" bundle="${storeText}" />
																						<a href="#" id="WC_CachedProductOnlyDisplay_Link_3"><img src="<c:out value="${jspStoreImgDir}" />images/empty.gif" alt='<fmt:message key="SalePriceIs" bundle="${storeText}" />' width="1" height="1" border="0"/></a>
																						<span class="offerPrice"><c:out value="${productDataBeanPriceString}" escapeXml="false" /></span>
																				       </c:when>
																			 		<c:otherwise >
																					<%--	The empty gif are put in front of the prices so that the alt text can be read by the IBM Homepage Reader to describe the two prices displayed.
																						These descriptions are necessary for meeting Accessibility requirements --%>
																						<a href="#" id="WC_CacheddiscountCatalogEntryDB.productDataBeanOnlyDisplay_Link_4"><img src="<c:out value="${jspStoreImgDir}" />images/empty.gif" alt='<fmt:message key="PriceIs" bundle="${storeText}" />' width="1" height="1" border="0"/></a>
																						<span class="price"><c:out value="${discountItemDB.calculatedContractPrice}" escapeXml="false" /> </span>


																					</c:otherwise>
																				</c:choose>

																			</c:otherwise>
																		</c:choose>

																		</td>
																		<td valign="top" width="20" id="WC_DiscountDetailsDisplay_TableCell_11_<c:out value="${counter.count}"/>">&nbsp;</td>
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
																	<td colspan="3" id="WC_DiscountDetailsDisplay_TableCell_12">
																		<br />
																		<br />
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
							</tbody>
						</c:when>
						<c:otherwise>
							<tr>
								<td id="WC_DiscountDetailsDisplay_TableCell_12"><fmt:message key="DISCOUNTDETAILS_ERROR" bundle="${storeText}"/>
								</td>
							</tr>
						</c:otherwise>
					</c:choose>
						<%--
							***
							* End check for valid discount
							***
						--%>
				</table>
			</td>
		</tr>

		</tbody>
	</table>
	<%@ include file="../../include/LayoutContainerBottom.jspf"%>
</body>
</html>

<!-- End - JSP File Name:  DiscountDetailsDisplay.jsp -->
