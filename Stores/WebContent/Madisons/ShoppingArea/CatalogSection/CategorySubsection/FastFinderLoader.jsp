<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2009 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>
<%-- 
  *****
  * This JSP file creates a JSON object with product information required by the Fast Finder page in the Madisons
  * store. It is to be used by the store to request products for a specific category to be returned as JSON object
  * via AJAX calls.
  *****
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf"%>


<c:if test="${WCParam.resultType == 'OfferPricePrice'}">
   <wcbase:useBean id="catEntSearchListBean" scope="page" classname="com.ibm.commerce.search.beans.CatEntrySearchListDataBean" >
		<c:set property="catGroupId" value="${WCParam.categoryId}" target="${catEntSearchListBean}" />
		<c:set property="isProduct" value="true" target="${catEntSearchListBean}" />
		<c:set property="isBundle" value="true" target="${catEntSearchListBean}" />
		<c:set property="isPackage" value="true" target="${catEntSearchListBean}" />
		<c:set property="pageSize" value="${WCParam.pageSize}" target="${catEntSearchListBean}" />
		<c:set property="orderBy1" value="OfferPricePrice" target="${catEntSearchListBean}" />
		<c:set property="beginIndex" value="${WCParam.beginIndex}" target="${catEntSearchListBean}" />	
	</wcbase:useBean>
	<c:set var="totalCountByBrand" value="${catEntSearchListBean.resultCount}"/>
</c:if>

<c:if test="${WCParam.resultType == 'Brand'}">
	<wcbase:useBean id="catEntSearchListBeanByBrand" scope="page" classname="com.ibm.commerce.search.beans.CatEntrySearchListDataBean" >
		<c:set property="catGroupId" value="${WCParam.categoryId}" target="${catEntSearchListBeanByBrand}" />
		<c:set property="isProduct" value="true" target="${catEntSearchListBeanByBrand}" />
		<c:set property="isBundle" value="true" target="${catEntSearchListBeanByBrand}" />
		<c:set property="isPackage" value="true" target="${catEntSearchListBeanByBrand}" />
		<c:set property="pageSize" value="${WCParam.pageSize}" target="${catEntSearchListBeanByBrand}" />
		<c:set property="orderBy1" value="CatEntryMfname" target="${catEntSearchListBeanByBrand}" />
		<c:set property="beginIndex" value="${WCParam.beginIndex}" target="${catEntSearchListBeanByBrand}" />	
	</wcbase:useBean>
	<c:set var="totalCountByBrand" value="${catEntSearchListBeanByBrand.resultCount}"/>
</c:if>
	
	
	<c:set var="maxPrice" value="0" />
	<c:set var="minPrice" value="99999999" />

	<jsp:useBean id="brandsHash" class="java.util.Hashtable" scope="request"/>
	<jsp:useBean id="featuresHash" class="java.util.Hashtable" scope="request"/>
	
	
	
	/*

	
		{
		
		
		
		<c:if test="${WCParam.resultType == 'OfferPricePrice'}">
				<c:set var="resultCount" value="${0}"/>
			
			"catalogEntriesByPrice" : [
		
			
		<c:forEach var="catEntry" items="${catEntSearchListBean.resultList}" varStatus="counter">
		<c:choose>
				<c:when test="${catEntry.product}">
					<%-- set the catalogEntry var to the product bean --%>
					<c:set var="catalogEntry" value="${catEntry.productDataBean}"/>
					<c:set var="type" value="product" />
				</c:when>
				<c:when test="${catEntry.item}">
					<%-- set the catalogEntry var to the item bean --%>
					<c:set var="catalogEntry" value="${catEntry.itemDataBean}"/>
					<c:set var="type" value="item" />
				</c:when>
				<c:when test="${catEntry.package}">
					<%-- set the catalogEntry var to the package bean --%>
					<c:set var="catalogEntry" value="${catEntry.packageDataBean}"/>
					<c:set var="type" value="package" />
				</c:when>
				<c:when test="${catEntry.bundle}">
					<%-- set the catalogEntry var to the bundle bean --%>
					<c:set var="catalogEntry" value="${catEntry.bundleDataBean}"/>
					<c:set var="type" value="bundle" />
				</c:when>
			</c:choose>
			
			<wcf:url var="catEntryDisplayUrl" value="Product2">
				<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
				<wcf:param name="storeId" value="${WCParam.storeId}"/>
				<wcf:param name="productId" value="${catEntry.catalogEntryID}"/>
				<wcf:param name="langId" value="${langId}"/>
				<wcf:param name="categoryId" value="${WCParam.categoryId}"/>
				<wcf:param name="parent_category_rn" value="${WCParam.parent_category_rn}"/>
				<wcf:param name="top_category" value="${WCParam.top_category}"/>
				<wcf:param name="errorViewName" value="ProductDisplayErrorView"/>
			</wcf:url>
			
			<wcf:getData type="com.ibm.commerce.catalog.facade.datatypes.CatalogEntryType" var="catEntryAttr" expressionBuilder="getStoreCatalogEntryAttributesByID">
				<wcf:contextData name="storeId" data="${WCParam.storeId}"/>
				<wcf:param name="catEntryId" value="${catEntry.catalogEntryID}"/>
				<wcf:param name="dataLanguageIds" value="${WCParam.langId}"/>
			</wcf:getData>
			
			<c:if test="${catEntry.product && empty catalogEntry.entitledItems[1] && !empty catalogEntry.entitledItems[0].partNumber }">
			 			<c:set var="noAttributes" value="true" />
			 			<c:forEach var="attribute" items="${catEntryAttr.catalogEntryAttributes.attributes}">
							<c:if test="${attribute.usage == 'Defining'}">
								<c:set var="noAttributes" value="false" />
							</c:if>
						</c:forEach>
						<c:if test="${ noAttributes }">
							<c:set var="type" value="item" />
						</c:if>
			</c:if>
				
				<c:set value="false" var="hasFeatures"/>
				<c:forEach var='attribute' items='${catEntryAttr.catalogEntryAttributes.attributes}'>
					<c:if test="${attribute.usage == 'Descriptive'}">
						<c:set value="true" var="hasFeatures"/>
					</c:if>
				</c:forEach>
				
				<c:if test="${hasFeatures == 'true'}">
	
					<c:set property="attachmentUsage" value="IMAGE_SIZE_40" target="${catalogEntry}" />
					<c:set var="image40AttachmentDataBeans" value="${catalogEntry.attachmentsByUsage}" />
					<c:choose>
						<c:when test="${!empty image40AttachmentDataBeans[0]}">
							<c:set var="productCompareImagePath" value="${image40AttachmentDataBeans[0].objectPath}${image40AttachmentDataBeans[0].path}" />
						</c:when>
						<c:when test="${!empty catalogEntry.description.thumbNail}">
							<c:set var="productCompareImagePath" value="${catalogEntry.objectPath}${catalogEntry.description.thumbNail}" />
						</c:when>
						<c:otherwise>
							<c:set var="productCompareImagePath" value="${jspStoreImgDir}images/NoImageIcon_sm45.jpg" />
						</c:otherwise>
					</c:choose> 
					<c:set var="smallImageSrc" value="" />
					<c:if test="${!empty catalogEntry.description.thumbNail}">
						<c:set var="smallImageSrc" value="${catalogEntry.objectPath}${catalogEntry.description.thumbNail}" />
					</c:if>
	
					<c:set var="mediumImageSrc" value="" />
					<c:if test="${!empty catalogEntry.description.thumbNail}">
						<c:set var="mediumImageSrc" value="${catalogEntry.objectPath}${catalogEntry.description.thumbNail}" />
					</c:if>
					<c:set var="catEntryIdentifier" value="catBrowse${counter.count}"/>
					<c:set var="showAdvancedTooltip" value="true"/>
				
					<c:if test="${type == 'product'}">
							
							<c:set var="resultCount" value="${resultCount + 1}"/>
								
						{ 
						
							"catalogEntry" : { 
												"catentryId" : "${catEntry.catalogEntryID}", 
												"partNumber" : "${catalogEntry.partNumber}",
												"name" : "<c:out value='${catalogEntry.description.name}' escapeXml='true'/>",
												"counter" : "${counter.count}",
												"shortDesc" : "<c:out value='${catalogEntry.description.shortDescription}' escapeXml='true'/>",
												"smallImgSrc" : "${smallImageSrc}",
												"productCompareImagePath" : "${productCompareImagePath}", 
												"mediumImageSrc" : "${mediumImageSrc}",
												"calculatedContractPrice" : "${catalogEntry.calculatedContractPrice.amount}",
												"displayPrice" : "<fmt:formatNumber value='${catalogEntry.calculatedContractPrice.amount}' type='currency' currencySymbol='${currencyFormatterDB.currencySymbol}' maxFractionDigits='${currencyDecimal}'/>",
												"manufacturerName" : "${catalogEntry.manufacturerName}",
												"catEntryDisplayUrl" : "${catEntryDisplayUrl}",
												"type" : "${type}",
												"attributes" : 
													[
														<c:set var="hasAttributes" value="false"/>
														<c:forEach var='attribute' items='${catEntryAttr.catalogEntryAttributes.attributes}' varStatus='aStatus'>
															<c:if test="${attribute.usage == 'Descriptive'}">
																<c:if test='${hasAttributes eq "true"}'><c:out value=',' /></c:if>
																'<c:out value="${attribute.name}"/>'
																<c:set var="hasAttributes" value="true"/>
																<c:set target='${featuresHash}' property='${attribute.name}' value='${attribute.name}'/>
															</c:if>
														</c:forEach>
													],
												"items" : 
													[
													<wcf:getData type="com.ibm.commerce.catalog.facade.datatypes.CatalogEntryType[]" var="entitledItemsAttributes" expressionBuilder="getStoreCatalogEntryAttributesByIDs">
															<wcf:contextData name="storeId" data="${WCParam.storeId}"/>
															<c:forEach var='entitledItem' items='${catalogEntry.entitledItems}'>
																<wcf:param name="UniqueID" value="${entitledItem.itemID}"/>
															</c:forEach>
															<wcf:param name="dataLanguageIds" value="${WCParam.langId}"/>
													</wcf:getData>
													<c:forEach var='entitledItem' items='${catalogEntry.entitledItems}' varStatus='outerStatus'>
														<c:set var="someItemIDs" value=''/>
														<c:forEach var="definingAttrValue2" items="${entitledItemsAttributes[outerStatus.index].catalogEntryAttributes.attributes}" varStatus="innerStatus">
															<c:if test="${definingAttrValue2.usage == 'Defining'}">
																<c:choose>
																	<c:when test="${empty someItemIDs}">
																		<c:set var="someItemIDs" value="${definingAttrValue2.name}_${definingAttrValue2.value.value}" />
																	</c:when>	
																	<c:otherwise>
																		<c:set var="someItemIDs" value="${someItemIDs},${definingAttrValue2.name}_${definingAttrValue2.value.value}" />
																  </c:otherwise>	
																</c:choose>
															</c:if>	
														</c:forEach>
													   '<c:out value='${someItemIDs}'/>'
														<c:if test='${!outerStatus.last}'>,</c:if>
													   </c:forEach>
													],

												 "entitledItemArray" :
												   [
														<c:forEach var='entitledItem' items='${catalogEntry.entitledItems}' varStatus='outerStatus'>
															'<c:out value='${entitledItem.itemID}' />'
																<c:if test='${!outerStatus.last}'>,</c:if>
														</c:forEach>
												   ]
											 } 
						}
						
						
					
					</c:if>
					
					<c:if test="${type != 'product'}">
						
							<c:set var="resultCount" value="${resultCount + 1}"/>
								
								
						{ 
						
							"catalogEntry" : { 
												"catentryId" : "${catEntry.catalogEntryID}", 
												"partNumber" : "${catalogEntry.partNumber}",
												"name" : "<c:out value='${catalogEntry.description.name}' escapeXml='true'/>",
												"counter" : "${counter.count}",
												"shortDesc" : "<c:out value='${catalogEntry.description.shortDescription}' escapeXml='true'/>",
												"smallImgSrc" : "${smallImageSrc}",
												"productCompareImagePath" : "${productCompareImagePath}", 
												"mediumImageSrc" : "${mediumImageSrc}",
												"calculatedContractPrice" : "${catalogEntry.calculatedContractPrice.amount}",
												"displayPrice" : "<fmt:formatNumber value='${catalogEntry.calculatedContractPrice.amount}' type='currency' currencySymbol='${currencyFormatterDB.currencySymbol}' maxFractionDigits='${currencyDecimal}'/>",
												"manufacturerName" : "${catalogEntry.manufacturerName}",
												"catEntryDisplayUrl" : "${catEntryDisplayUrl}",
												"type" : "${type}",
												"attributes" : 
												[  
													<c:set var="hasAttributes" value="false"/>
													<c:forEach var='attribute' items='${catEntryAttr.catalogEntryAttributes.attributes}' varStatus='aStatus'>
														<c:if test="${attribute.usage == 'Descriptive'}">
															<c:if test='${hasAttributes eq "true"}'><c:out value=',' /></c:if>
															'<c:out value="${attribute.name}"/>'
															<c:set var="hasAttributes" value="true"/>
															<c:set target='${featuresHash}' property='${attribute.name}' value='${attribute.name}'/>
														</c:if>
													</c:forEach>
												]
											 } 
						}
						
					</c:if>
					
					
				<c:set var="prefix" value="${currencyFormatterDB.currencySymbol}"/>
				<c:if test="${catalogEntry.calculatedContractPrice.amount > maxPrice}">
					<c:set var="maxPrice" value="${catalogEntry.calculatedContractPrice.amount}" />
				</c:if>
				<c:if test="${catalogEntry.calculatedContractPrice.amount < minPrice}">
					<c:set var="minPrice" value="${catalogEntry.calculatedContractPrice.amount}" />
				</c:if>
					
				<c:set target="${brandsHash}" property="${catalogEntry.manufacturerName}" value="${catalogEntry.manufacturerName}"/>
				</c:if>
				
				<c:choose>
							<c:when test="${counter.last}"></c:when>
							<c:otherwise>,</c:otherwise>
						</c:choose>
			
			
					
			</c:forEach>
			],
			
		</c:if>
		
		<c:if test="${WCParam.resultType == 'Brand'}">
			
			"catalogEntriesByBrand" : [
			
			
				<c:forEach var="catEntry" items="${catEntSearchListBeanByBrand.resultList}" varStatus="counter">
					<c:choose>
						<c:when test="${catEntry.product}">
							<%-- set the catalogEntry var to the product bean --%>
							<c:set var="catalogEntry" value="${catEntry.productDataBean}"/>
							<c:set var="type" value="product" />
						</c:when>
						<c:when test="${catEntry.item}">
							<%-- set the catalogEntry var to the item bean --%>
							<c:set var="catalogEntry" value="${catEntry.itemDataBean}"/>
							<c:set var="type" value="item" />
						</c:when>
						<c:when test="${catEntry.package}">
							<%-- set the catalogEntry var to the package bean --%>
							<c:set var="catalogEntry" value="${catEntry.packageDataBean}"/>
							<c:set var="type" value="package" />
						</c:when>
						<c:when test="${catEntry.bundle}">
							<%-- set the catalogEntry var to the bundle bean --%>
							<c:set var="catalogEntry" value="${catEntry.bundleDataBean}"/>
							<c:set var="type" value="bundle" />
						</c:when>
					</c:choose>
					
					<wcf:url var="catEntryDisplayUrl" value="Product2">
						<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
						<wcf:param name="storeId" value="${WCParam.storeId}"/>
						<wcf:param name="productId" value="${catEntry.catalogEntryID}"/>
						<wcf:param name="langId" value="${langId}"/>
						<wcf:param name="categoryId" value="${WCParam.categoryId}"/>
						<wcf:param name="parent_category_rn" value="${WCParam.parent_category_rn}"/>
						<wcf:param name="top_category" value="${WCParam.top_category}"/>
						<wcf:param name="errorViewName" value="ProductDisplayErrorView"/>
					</wcf:url>

					<wcf:getData type="com.ibm.commerce.catalog.facade.datatypes.CatalogEntryType" var="catEntryAttr" expressionBuilder="getStoreCatalogEntryAttributesByID">
						<wcf:contextData name="storeId" data="${WCParam.storeId}"/>
						<wcf:param name="catEntryId" value="${catEntry.catalogEntryID}"/>
						<wcf:param name="dataLanguageIds" value="${WCParam.langId}"/>
					</wcf:getData>
					
					<c:if test="${empty catalogEntry.entitledItems[1] && !empty catalogEntry.entitledItems[0].partNumber}">
								<c:set var="noAttributes" value="true" />
					 			<c:forEach var="attribute" items="${catEntryAttr.catalogEntryAttributes.attributes}">
									<c:if test="${attribute.usage == 'Defining'}">
										<c:set var="noAttributes" value="false" />
									</c:if>
								</c:forEach>
								<c:if test="${ noAttributes }">
									<c:set var="type" value="item" />
								</c:if>
					</c:if>
							
					<c:set value="false" var="hasFeatures"/>
					<c:forEach var='attribute' items='${catEntryAttr.catalogEntryAttributes.attributes}'>
						<c:if test="${attribute.usage == 'Descriptive'}">
							<c:set value="true" var="hasFeatures"/>
						</c:if>
					</c:forEach>
					<c:if test="${hasFeatures == 'true'}">
						<c:set property="attachmentUsage" value="IMAGE_SIZE_40" target="${catalogEntry}" />
						<c:set var="image40AttachmentDataBeans" value="${catalogEntry.attachmentsByUsage}" />
						<c:choose>
							<c:when test="${!empty image40AttachmentDataBeans[0]}">
								<c:set var="productCompareImagePath" value="${image40AttachmentDataBeans[0].objectPath}${image40AttachmentDataBeans[0].path}" />
							</c:when>
							<c:when test="${!empty catalogEntry.description.thumbNail}">
								<c:set var="productCompareImagePath" value="${catalogEntry.objectPath}${catalogEntry.description.thumbNail}" />
							</c:when>
							<c:otherwise>
								<c:set var="productCompareImagePath" value="${jspStoreImgDir}images/NoImageIcon_sm45.jpg" />
							</c:otherwise>
						</c:choose> 
		
						<c:set var="smallImageSrc" value="" />
						<c:if test="${!empty catalogEntry.description.thumbNail}">
							<c:set var="smallImageSrc" value="${catalogEntry.objectPath}${catalogEntry.description.thumbNail}"/>
						</c:if>
		
						<c:set var="mediumImageSrc" value="" />
						<c:if test="${!empty catalogEntry.description.thumbNail}">
							<c:set var="mediumImageSrc" value="${catalogEntry.objectPath}${catalogEntry.description.thumbNail}"/>
						</c:if>
						<c:set var="catEntryIdentifier" value="catBrowse${counter.count}"/>
						<c:set var="showAdvancedTooltip" value="true"/>
						
						<c:set var="prefix" value="${currencyFormatterDB.currencySymbol}"/>
						
						
						<c:if test="${type == 'product'}">
							
							{ 
						
							"catalogEntry" : { 
												"catentryId" : "${catEntry.catalogEntryID}", 
												"partNumber" : "${catalogEntry.partNumber}",
												"name" : "<c:out value='${catalogEntry.description.name}' escapeXml='true'/>",
												"counter" : "${counter.count}",
												"shortDesc" : "<c:out value='${catalogEntry.description.shortDescription}' escapeXml='true'/>",
												"smallImgSrc" : "${smallImageSrc}",
												"productCompareImagePath" : "${productCompareImagePath}", 
												"mediumImageSrc" : "${mediumImageSrc}",
												"calculatedContractPrice" : "${catalogEntry.calculatedContractPrice.amount}",
												"displayPrice" : "<fmt:formatNumber value='${catalogEntry.calculatedContractPrice.amount}' type='currency' currencySymbol='${currencyFormatterDB.currencySymbol}' maxFractionDigits='${currencyDecimal}'/>",
												"manufacturerName" : "${catalogEntry.manufacturerName}",
												"catEntryDisplayUrl" : "${catEntryDisplayUrl}",
												"type" : "${type}",
												"attributes" : 
													[
														<c:set var="hasAttributes" value="false"/>
														<c:forEach var='attribute' items='${catEntryAttr.catalogEntryAttributes.attributes}' varStatus='aStatus'>
															<c:if test="${attribute.usage == 'Descriptive'}">
																<c:if test='${hasAttributes eq "true"}'><c:out value=',' /></c:if>
																'<c:out value="${attribute.name}"/>'
																<c:set var="hasAttributes" value="true"/>
																<c:set target='${featuresHash}' property='${attribute.name}' value='${attribute.name}'/>
															</c:if>
														</c:forEach>
													],
												"items" : 
													[
													<wcf:getData type="com.ibm.commerce.catalog.facade.datatypes.CatalogEntryType[]" var="entitledItemsAttributes" expressionBuilder="getStoreCatalogEntryAttributesByIDs">
															<wcf:contextData name="storeId" data="${WCParam.storeId}"/>
															<c:forEach var='entitledItem' items='${catalogEntry.entitledItems}'>
																<wcf:param name="UniqueID" value="${entitledItem.itemID}"/>
															</c:forEach>
															<wcf:param name="dataLanguageIds" value="${WCParam.langId}"/>
													</wcf:getData>
													<c:forEach var='entitledItem' items='${catalogEntry.entitledItems}' varStatus='outerStatus'>
														<c:set var="someItemIDs" value=''/>
														<c:forEach var="definingAttrValue2" items="${entitledItemsAttributes[outerStatus.index].catalogEntryAttributes.attributes}" varStatus="innerStatus">
															<c:if test="${definingAttrValue2.usage == 'Defining'}">
																<c:choose>
																	<c:when test="${empty someItemIDs}">
																		<c:set var="someItemIDs" value="${definingAttrValue2.name}_${definingAttrValue2.value.value}" />
																	</c:when>	
																	<c:otherwise>
																		<c:set var="someItemIDs" value="${someItemIDs},${definingAttrValue2.name}_${definingAttrValue2.value.value}" />
																  </c:otherwise>	
																</c:choose>
															</c:if>	
														</c:forEach>
													   '<c:out value='${someItemIDs}'/>'
														<c:if test='${!outerStatus.last}'>,</c:if>
													   </c:forEach>
													],
												 "entitledItemArray" :
												   [
														<c:forEach var='entitledItem' items='${catalogEntry.entitledItems}' varStatus='outerStatus'>
															'<c:out value='${entitledItem.itemID}' />'
																<c:if test='${!outerStatus.last}'>,</c:if>
														</c:forEach>
												   ]
											 } 
							
							
							
											}
							
							}
						</c:if>
		
						
						<c:if test="${type != 'product'}">
						
							{ 
						
							"catalogEntry" : {
												"catentryId" : "${catEntry.catalogEntryID}", 
												"partNumber" : "${catalogEntry.partNumber}",
												"name" : "<c:out value='${catalogEntry.description.name}' escapeXml='true'/>",
												"counter" : "${counter.count}",
												"shortDesc" : "<c:out value='${catalogEntry.description.shortDescription}' escapeXml='true'/>",
												"smallImgSrc" : "${smallImageSrc}",
												"productCompareImagePath" : "${productCompareImagePath}", 
												"mediumImageSrc" : "${mediumImageSrc}",
												"calculatedContractPrice" : "${catalogEntry.calculatedContractPrice.amount}",
												"displayPrice" : "<c:out value='${catalogEntry.calculatedContractPrice}' escapeXml='false'/>",
												"manufacturerName" : "${catalogEntry.manufacturerName}",
												"catEntryDisplayUrl" : "${catEntryDisplayUrl}",
												"type" : "${type}",
												"attributes" : 
												[  
													<c:set var="hasAttributes" value="false"/>
													<c:forEach var='attribute' items='${catEntryAttr.catalogEntryAttributes.attributes}' varStatus='aStatus'>
													<c:if test="${attribute.usage == 'Descriptive'}">
														<c:if test='${hasAttributes eq "true"}'><c:out value=',' /></c:if>
														'<c:out value="${attribute.name}"/>'
														<c:set var="hasAttributes" value="true"/>
														<c:set target='${featuresHash}' property='${attribute.name}' value='${attribute.name}'/>
													</c:if>
													</c:forEach>
												]
											}
							
							}
						</c:if>
						
						<c:choose>
							<c:when test="${counter.last}"></c:when>
							<c:otherwise>,</c:otherwise>
						</c:choose>
					</c:if>
					
						
				</c:forEach>
			],
			
		</c:if>
			
			
			
			
			
			 "brands" : 
			[   
				<c:forEach var="brand" items="${brandsHash}" varStatus="brandCounter">
					"<c:out value='${brand.value}'/>"
					<c:if test="${!brandCounter.last}">,</c:if>
				</c:forEach>
			
			
			],
			
			
			"features" : 
			[   
				<c:forEach var="feature" items="${featuresHash}" varStatus="featureCounter">
					"<c:out value='${feature.value}'/>"
					<c:if test="${!featureCounter.last}">,</c:if>
				</c:forEach>
			
			
			],
			
			
			"totalCountByBrand" : "<c:out value="${totalCountByBrand}"/>",
			
			"minPrice" : "${minPrice}",
			
			"maxPrice" : "${maxPrice}",
			
			"resultsReturned" : "${resultCount}",
			
			"pageSize" : "${WCParam.pageSize}",
			
			"beginIndex" : "${WCParam.beginIndex}"
		}

	*/

	

