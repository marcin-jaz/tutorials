<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2008 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf"%>

<c:set var="search" value='"'/>
<c:set var="replaceStr" value="'"/>
<c:set var="search01" value="'"/>
<c:set var="replaceStr01" value="\\'"/>
<c:set var="replaceCmprStr" value=""/>

<wcbase:useBean id="catEntry" classname="com.ibm.commerce.catalog.beans.CatalogEntryDataBean" scope="request">
	<c:set property="catalogEntryID" value="${WCParam.productId}" target="${catEntry}" />
</wcbase:useBean>

<c:choose>
	<c:when  test="${catEntry.item}">
		<fmt:formatNumber var="offerPrice" value="${catEntry.itemDataBean.calculatedContractPrice.amount}" type="currency" currencySymbol="${currencyFormatterDB.currencySymbol}" maxFractionDigits="${currencyDecimal}"/>
		<c:set var="catEntryType" value="item" />
	</c:when>
	<c:when  test="${catEntry.product}">
		<fmt:formatNumber var="offerPrice" value="${catEntry.productDataBean.minimumItemPrice.amount}" type="currency" currencySymbol="${currencyFormatterDB.currencySymbol}" maxFractionDigits="${currencyDecimal}"/>		
		<c:set var="catEntryType" value="product" />
		<c:set var="entitledItems" value="${catEntry.productDataBean.entitledItems}"/>	<%-- we only need to get entitledItems for products only --%>     
		<wcf:getData type="com.ibm.commerce.catalog.facade.datatypes.CatalogEntryType[]" var="skus" expressionBuilder="getStoreCatalogEntryAttributesByIDs">
			<wcf:contextData name="storeId" data="${param.storeId}"/>
			<c:forEach var='entitledItem0' items='${entitledItems}' varStatus='status'>
				<wcf:param name="UniqueID" value="${entitledItem0.itemID}"/>
			</c:forEach>
			<wcf:param name="dataLanguageIds" value="${WCParam.langId}"/>
		</wcf:getData>
	</c:when>
	<c:when  test="${catEntry.package}">
		<c:catch var ="noPriceException">
			<fmt:formatNumber var="offerPrice" value="${catEntry.packageDataBean.calculatedContractPrice.amount}" type="currency" currencySymbol="${currencyFormatterDB.currencySymbol}" maxFractionDigits="${currencyDecimal}"/>					
		</c:catch>
		<c:if test = "${noPriceException!=null}">
			<c:set var="offerPrice" value=""/>
		</c:if>
		<c:set var="catEntryType" value="package" />
	</c:when>
	<c:when  test="${catEntry.bundle}">
		<fmt:formatNumber var="offerPrice" value="${catEntry.bundleDataBean.minimumBundlePrice.amount}" type="currency" currencySymbol="${currencyFormatterDB.currencySymbol}" maxFractionDigits="${currencyDecimal}"/>
		<c:set var="catEntryType" value="bundle" />
	</c:when>
</c:choose>

<c:set property="attachmentUsage" value="IMAGE_SIZE_40" target="${catEntry}" />
<c:set var="image40AttachmentDataBeans" value="${catEntry.attachmentsByUsage}" />
<c:choose>
	<c:when test="${!empty image40AttachmentDataBeans[0]}">
		<c:set var="productCompareImagePath" value="${image40AttachmentDataBeans[0].objectPath}${image40AttachmentDataBeans[0].path}" />
	</c:when>
	<c:when test="${!empty catEntry.description.thumbNail}">
		<c:set var="productCompareImagePath" value="${catEntry.objectPath}${catEntry.description.thumbNail}" />
	</c:when>
	<c:otherwise>
		<c:set var="productCompareImagePath" value="${jspStoreImgDir}images/NoImageIcon_sm45.jpg" />
	</c:otherwise>
</c:choose>
<c:set var="compareImageDescription" value="${fn:replace(catEntry.description.shortDescription, search, replaceCmprStr)}"/>
<c:set var="compareImageDescription" value="${fn:replace(compareImageDescription, search01, replaceCmprStr)}"/>

<c:set var="search" value='"'/>
<c:set var="replaceStr" value='&quot;'/>

<wcf:getData type="com.ibm.commerce.catalog.facade.datatypes.CatalogEntryType" var="attributes" expressionBuilder="getStoreCatalogEntryAttributesByID">
	<wcf:contextData name="storeId" data="${param.storeId}"/>
	<wcf:param name="catEntryId" value="${WCParam.productId}"/>
	<wcf:param name="dataLanguageIds" value="${WCParam.langId}"/>
</wcf:getData>

<wcf:url var="catEntryDisplayUrl" value="Product3">
			<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
		    <wcf:param name="storeId" value="${WCParam.storeId}"/>
		    <wcf:param name="productId" value="${WCParam.productId}"/>
		    <wcf:param name="langId" value="${langId}"/>
		    <wcf:param name="categoryId" value="${catalogEntry.parentCatalogGroupIdentifier.uniqueID}"/>
		    <wcf:param name="parent_category_rn" value="${catalogEntry.parentCatalogGroupIdentifier.uniqueID}"/>
</wcf:url>

/*
{"catalogEntry": {
	"catalogEntryIdentifier": {
		"uniqueID": "${catEntry.catalogEntryID}",
		"externalIdentifier": {
			"partNumber": "${catEntry.partNumber}",
			"ownerID": "${catEntry.memberId}"
		}
	},
	"description": [{
		"name": "${fn:replace(catEntry.description.name, search, replaceStr)}",
		"thumbnail": "${catEntry.objectPath}${catEntry.description.thumbNail}",
		"fullImage": "${catEntry.objectPath}${catEntry.description.fullImage}",
		"shortDescription": "${fn:replace(catEntry.description.shortDescription, search, replaceStr)}",
		"longDescription": "${fn:replace(catEntry.description.longDescription, search, replaceStr)}",
		"keyword": "${fn:replace(catEntry.description.keyWord, search, replaceStr)}",
		"attributes": [
			{
				"value": "${catEntry.description.auxDescription2}",
				"key": "auxDescription2"
			}
			],
		"language": "${langId}"
	}],
	"objectPath": "${catEntry.objectPath}",
	"catalogEntryTypeCode": "${catEntry.type}",
	"buyable": "${catEntry.buyable}",
	"offerPrice": "${offerPrice}"
},
"catEntryType":"${catEntryType}",
"catalogEntryURL": "<c:out value="${catEntryDisplayUrl}" escapeXml="false"/>",
"catalogEntryAttributes": <wcf:json object="${attributes.catalogEntryAttributes}"/>,
"productCompareImagePath": "<c:out value="${productCompareImagePath}"/>",
"compareImageDescription": "<c:out value="${compareImageDescription}"/>",
"catalogEntryPromotions": [
											<wcbase:useBean id="discounts" classname="com.ibm.commerce.fulfillment.beans.CalculationCodeListDataBean" scope="page">
												<c:set property="catalogEntryId" value="${WCParam.productId}" target="${discounts}" />
												<c:set property="includeParentProduct" value="true" target="${discounts}" />
												<c:set property="includeChildItems" value="true" target="${discounts}"/>
												<%-- UsageId for discount is -1 --%>
												<c:set property="calculationUsageId" value="-1" target="${discounts}" />
											</wcbase:useBean>
											<c:if test="${ !empty discounts.calculationCodeDataBeans }" >
												<c:forEach var="discountEntry" items="${discounts.calculationCodeDataBeans}" varStatus="discountCounter">
													"<c:out value="${discountEntry.descriptionString}" escapeXml="false" />"
													<c:choose>
														<c:when test="${discountCounter.last}"></c:when>
														<c:otherwise>,</c:otherwise>
													</c:choose>
												</c:forEach>
											</c:if>
											],
"productAttributes":[						<c:forEach var='entitledItem' items='${entitledItems}' varStatus='outerStatus'>								
									{
									"catentry_id" : "<c:out value='${entitledItem.itemID}' />",
									"Attributes" :	{
                                        <c:if test="${not empty skus}">             
                                        	<c:set var="hasAttributes" value="false"/>                                                                 
                                            <c:forEach var="sku" items="${skus}" varStatus="skuStatus">
                                                <c:if test="${sku.catalogEntryIdentifier.uniqueID eq entitledItem.itemID}">
                                                    <c:forEach var="definingAttrValue2" items="${sku.catalogEntryAttributes.attributes}" varStatus="innerStatus">
                                                        <c:if test="${definingAttrValue2.usage == 'Defining'}">
                                                            <c:if test='${hasAttributes eq "true"}'>,</c:if>
                                                            "<c:out value="${fn:replace(definingAttrValue2.name, search01, replaceStr01)}_${fn:replace(definingAttrValue2.value.value, search01, replaceStr01)}" />":"<c:out value='${innerStatus.count}' />"
                                                        </c:if>
                                                        <c:set var="hasAttributes" value="true"/>                                                        	
                                                    </c:forEach>
                                                </c:if>
                                            </c:forEach>
                                        </c:if>
										}
									}<c:if test='${!outerStatus.last}'>,</c:if>
								</c:forEach>
		]											
}
*/
