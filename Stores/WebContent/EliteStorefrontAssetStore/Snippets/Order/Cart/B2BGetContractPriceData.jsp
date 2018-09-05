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

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf"%>

<wcbase:useBean id="catEntryDB" classname="com.ibm.commerce.catalog.beans.CatalogEntryDataBean" scope="request">
	<c:set property="catalogEntryID" value="${WCParam.catentryId}" target="${catEntryDB}" />
</wcbase:useBean>

<c:choose>
	<%-- 
		this page only accepts catentries that are either a package or an item, for other catentry types we cannot
		get the contract price - a product has to be resolved to an item, and bundle also needs to be resolved to the 
		component items
	--%>
	<c:when test="${catEntryDB.package}">
		<c:set var="catentry" value="${catEntryDB.packageDataBean}"/>
	</c:when>
	<c:when test="${catEntryDB.item}">
		<c:set var="catentry" value="${catEntryDB.itemDataBean}"/>
	</c:when>
</c:choose>

/*
{
	"itemId": "${WCParam.catentryId}"
	,"orderItemId": "${WCParam.orderItemId}"
	,"currentContractId": "${WCParam.curContractId}"
	,"fromBundlePage": "${param.isBundle}"

	,"contracts":
	<c:choose>
		<c:when test="${!empty catentry.checkNumberOfApplicableContractIds}">
			[
			<c:set var="numContract" value="0"/>
			<c:catch var ="catchException">
				<c:set var="numApplicableContracts" value="${catentry.numberOfApplicableContractIds}"/>
			</c:catch>
			<c:if test = "${catchException == null}">
			<c:forEach var="i" begin="0" end="${catentry.numberOfApplicableContractIds}" varStatus="appContractIdCounter">
				<c:if test="${!empty catentry.applicableContractPrices[i]}">
					<c:if test="${numContract > 0}">
						,
					</c:if>
					<c:set var="numContract" value="${numContract + 1}"/>
					<wcbase:useBean id="contractDataBean" classname="com.ibm.commerce.contract.beans.ContractDataBean">
						<c:set target="${contractDataBean}" property="dataBeanKeyReferenceNumber" value="${catentry.applicableContractIds[i]}"/>
					</wcbase:useBean>
					{
					"contractId": "<c:out value="${catentry.applicableContractIds[i]}"/>",
					"contractName": "<c:out value="${contractDataBean.name}"/>",
					"contractPrice":
					<c:forEach var="contractPriceRange" items="${catentry.applicableContractPriceRanges}" varStatus="priceRangeContractCounter">
						<c:if test="${priceRangeContractCounter.index == appContractIdCounter.index}">												
							<c:forEach var="priceRange" items="${contractPriceRange.rangePrices}" varStatus="priceRangeCounter">							
								<c:choose>
									<c:when test="${empty priceRange.endingNumberOfUnits && priceRangeCounter.index == '0'}">
										"<fmt:formatNumber value="${priceRange.contractPrice.amount}" type="currency" currencySymbol="${currencyFormatterDB.currencySymbol}" maxFractionDigits="${currencyDecimal}"/>"
									</c:when>
									<c:when test="${!empty priceRange.endingNumberOfUnits}">
										<c:set var="hasPriceRange" value="true"/>
										<c:if test="${0 == priceRangeCounter.index}">
										<%--Even the tiered pricing is available, still need this for display purpose. This is displayed in front of the contract name. In the if block because I only want to set it once --%>
											<fmt:formatNumber var="localizedPrice" value="${priceRange.contractPrice.amount}" type="currency" currencySymbol="${currencyFormatterDB.currencySymbol}" maxFractionDigits="${currencyDecimal}"/>
											<c:set var="contractDisplayPrice" value='"contractDisplayPrice":"${localizedPrice}"'/> 										
											[{
										</c:if> <%-- print if it's the first set --%>
											<fmt:formatNumber var="localizedPrice" value="${priceRange.contractPrice.amount}" type="currency" currencySymbol="${currencyFormatterDB.currencySymbol}" maxFractionDigits="${currencyDecimal}"/>										
											<fmt:message var="TieredPricingDisp" key="TieredPricingDisp" bundle="${storeText}">
												<fmt:param value="${priceRange.startingNumberOfUnits}" />
												<fmt:param value="${priceRange.endingNumberOfUnits}" />
												<fmt:param value="${localizedPrice}" />
											</fmt:message>
											"${priceRangeCounter.index}":"${TieredPricingDisp}",						
										</c:when>
									<c:otherwise>
										<fmt:formatNumber var="localizedPrice" value="${priceRange.contractPrice.amount}" type="currency" currencySymbol="${currencyFormatterDB.currencySymbol}" maxFractionDigits="${currencyDecimal}"/>
										<fmt:message var="TieredPricingDispLast" key="TieredPricingDispLast" bundle="${storeText}">
											<fmt:param value="${priceRange.startingNumberOfUnits}" />
											<fmt:param value="${localizedPrice}" />
										</fmt:message>
										
										"${priceRangeCounter.index}":"<c:out value="${TieredPricingDispLast}" escapeXml="false"/>"										
									<c:if test="${priceRangeCounter.last}">}]</c:if> <%-- print if it's the last set --%>
									</c:otherwise>
								</c:choose>
							</c:forEach>
						</c:if>
					</c:forEach>
					<c:if test="${hasPriceRange == 'true'}">
						,${contractDisplayPrice},"hasPriceRange":"true"
					</c:if> 
					}
					<c:remove var="contractDataBean"/>
				</c:if>
			</c:forEach>
			</c:if>
			]
		</c:when>
		<c:when test="${empty catentry.checkNumberOfApplicableContractIds && catEntryDB.dynamicKit}">
			[
				<c:if test="${!empty CommandContext.eligibleTradingAgreementIds}">
					<c:set var="numContract" value="0"/>
					<c:forEach var="contractId" items="${CommandContext.eligibleTradingAgreementIds}" varStatus="eligibleTradingAgreementIdsCount">
						<c:if test="${numContract > 0}">
							,
						</c:if>
						<c:set var="numContract" value="${numContract + 1}"/>
						<wcbase:useBean id="contractDataBean" classname="com.ibm.commerce.contract.beans.ContractDataBean">
							<c:set target="${contractDataBean}" property="dataBeanKeyReferenceNumber" value="${contractId}"/>
						</wcbase:useBean>
						{
						"contractId": "<c:out value="${contractId}"/>",
						"contractName": "<c:out value="${contractDataBean.name}"/>",
						"contractPrice": ""
						}
						<c:remove var="contractDataBean"/>
					</c:forEach>
				</c:if>
			]
		</c:when>
	</c:choose>

	,"numContracts": "${numContract}"
	,"isOrderItemADynamicKit": "${catEntryDB.dynamicKit}"
}
*/
