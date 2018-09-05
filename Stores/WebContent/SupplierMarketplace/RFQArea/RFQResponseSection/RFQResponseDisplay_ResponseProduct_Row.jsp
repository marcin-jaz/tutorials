<% 
/*
 *-------------------------------------------------------------------
 * Licensed Materials - Property of IBM
 *
 * WebSphere Commerce
 *
 * (c) Copyright International Business Machines Corporation. 2000, 2004
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
  * This JSP page iterates through the products of the RFQ response.
  *
  * Imports:
  * - CatalogEntryType_And_OfferPrice_Setup.jsp
  *
  * Required parameters:
  * - RFQResNewProd [] resProducts
  * - product_id
  * - count
  * - req_name
  * - req_categoryName
  * - req_catentryId
  * - res_catentry
  * - resProdName
  * - res_catentry
  *
  *****
--%>

<%@ page language="java" %>

<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../include/JSTLEnvironmentSetup.jspf" %>


<%@ include file="RFQResponseConstants.jspf" %>

<c:set var="wrap" value="${requestScope.wrap}" scope="request" />

<wcbase:useBean id="rfqRspProd" classname="com.ibm.commerce.rfq.beans.RFQResProductDataBean" scope="page">
		<c:set target="${rfqRspProd}" property="resProdId" value="${param.product_id}" />		
</wcbase:useBean>

<c:url var="RFQResponseProductDisplayHref" value="${requestScope.RFQResponseProductDisplayHref}" >
	<c:param name="${EC_RFQ_PRODUCT_ID}" value="${param.product_id}" />
	<c:param name="${RFQ_EC_OFFERING_CATENTRYID}" value="${param.res_catentry}" />
</c:url>


<c:set var="priceAdjust" value="" />
<c:set var="priceAdjust" value="${rfqRspProd.priceAdjustmentInEJBType}" />
<fmt:formatNumber value="${priceAdjust}" var="priceAdjust" />

<c:catch var="e" >  
<c:if  test="${rfqRspProd.priceAdjustmentInEJBType > 0}" >
	<fmt:message key="RFQDisplay_Percentage" bundle="${storeText}" var="percent" />
	<c:set var="priceAdjust" value="${priceAdjust} ${percent}" />
</c:if>
</c:catch>
<c:if test="${e!=null}">
	<c:set var="priceAdjust" value="" />
</c:if>	

<c:set var="resProdName" value="${ param.resProdName}" />
<c:set var="reqProdName" value="${ param.req_name}" />
<c:if test="${reqProdName eq ''}">
	<fmt:message var="reqProdName" key="RFQListDisplay_MadeToOrder" bundle="${storeText}"/>
</c:if>
<c:choose>
	<c:when test="${param.req_categoryName != ''}">
		<c:set var="rfqCategoryName" value="${param.req_categoryName}" />
	</c:when>
	<c:otherwise>
		<fmt:message var="rfqCategoryName" key="RFQExtra_NotCategorized" bundle="${storeText}"/>
	</c:otherwise>
</c:choose>

<c:if test="${param.req_catentryId != ''}" > 
<% out.flush(); %>
<c:import url="CatalogEntryType_And_OfferPrice_Setup.jsp">
	<c:param name="catentryId" value="${param.req_catentryId}" />
	<c:param name="setOfferPrice_Item" value="true" />
	<c:param name="setOfferPrice_Product" value="true" />
	<c:param name="setOfferPrice_Package" value="true" />
</c:import>
<% out.flush(); %>
<c:set var="resOfferPrice" value="${requestScope.offerPrice}"  />
<c:set var="req_type" value="${requestScope.type}"/>
<% out.flush(); %>
<c:import url="CatalogEntryType_And_OfferPrice_Setup.jsp">
	<c:param name="catentryId" value="${param.res_catentry}" />
	<c:param name="setOfferPrice_Item" value="false" />
	<c:param name="setOfferPrice_Product" value="false" />
	<c:param name="setOfferPrice_Package" value="false" />
</c:import>
<% out.flush(); %>
<c:set var="res_type" value="${requestScope.type}"/>
</c:if>

<c:choose>
	<c:when test="${param.req_catentryId != ''  }" >
		<wcbase:useBean id="catalogAB" classname="com.ibm.commerce.catalog.beans.CatalogEntryDescriptionDataBean">
			<c:set target="${catalogAB}" property="dataBeanKeyCatalogEntryReferenceNumber" value="${param.req_catentryId}" />
			<c:set target="${catalogAB}" property="dataBeanKeyLanguage_id" value="${langId}" />
			
			<c:set var="reqProdName" value="${catalogAB.name}" />
			
		</wcbase:useBean>
	</c:when>
	<c:otherwise>
			<c:set var="reqProdName" value="${reqProdName}" />
		<c:if test="${reqProdName eq null}" >
			<fmt:message key="RFQListDisplay_MadeToOrder" bundle="${storeText}" var="prodName"/>
		</c:if>
	</c:otherwise>
</c:choose>


<c:choose>
	<c:when test="${param.res_catentry != ''}" >
		<wcbase:useBean id="catalogABRes" classname="com.ibm.commerce.catalog.beans.CatalogEntryDescriptionDataBean">
			<c:set target="${catalogABRes}" property="dataBeanKeyCatalogEntryReferenceNumber" value="${param.res_catentry}" />
			<c:set target="${catalogABRes}" property="dataBeanKeyLanguage_id" value="${langId}" />
			
			<c:set var="resProdName" value="${catalogABRes.name}" />
			
		</wcbase:useBean>
	</c:when>
	<c:otherwise>
			<c:set var="resProdName" value="${resProdName}" />
		<c:if test="${resProdName eq null}" >
			<fmt:message key="RFQListDisplay_MadeToOrder" bundle="${storeText}" var="prodName"/>
		</c:if>
	</c:otherwise>
</c:choose>

<c:set var="unit" value="${rfqRspProd.quantityUnitId}" />
<c:choose>
	<c:when test="${unit != null}" >
		<wcbase:useBean id="qudb"
			classname="com.ibm.commerce.common.beans.QuantityUnitDescriptionDataBean">
			<c:set target="${qudb}" property="dataBeanKeyLanguage_id" value="${langId}" />
			<c:set target="${qudb}" property="dataBeanKeyQuantityUnitId" value="${unit}" />
			
			<c:set var="unit" value="${qudb.description}" />
		</wcbase:useBean>
	</c:when>
	<c:otherwise>
		<c:set var="unit" value="" />
	</c:otherwise>
</c:choose>
 
 		<c:if test="${!empty priceAdjust}" >
		<fmt:message key="RFQDisplay_Percentage" bundle="${storeText}" var="percent" />
		</c:if>
        <td <c:out value="${wrap}" /> headers="c1" class="t_td" id="WC_RFQResponseDisplay_TableCell_31_<c:out value="${param.count}" />"><c:out value="${reqProdName}" /></td>
        <td <c:out value="${wrap}" /> headers="c2" class="t_td" id="WC_RFQResponseDisplay_TableCell_32_<c:out value="${param.count}" />"><c:out value="${rfqCategoryName}" /></td>
        <td <c:out value="${wrap}" /> headers="c3" class="t_td" id="WC_RFQResponseDisplay_TableCell_33_<c:out value="${param.count}" />"><c:out value="${req_type}" /></td>
 
         
        <c:choose>
			<c:when test="${resOfferPrice != null}" >
	           <td <c:out value="${wrap}" /> headers="c4" class="t_td" id="WC_RFQResponseDisplay_TableCell_34_<c:out value="${param.count}" />" class="price"><c:out value="${resOfferPrice}" escapeXml="false" /></td>             		        
			</c:when>
			<c:otherwise>
	        	<td <c:out value="${wrap}" /> headers="c4" class="t_td" id="WC_RFQResponseDisplay_TableCell_34_<c:out value="${param.count}" />">&nbsp;</td>
			</c:otherwise>
		</c:choose> 
                                
        <td <c:out value="${wrap}" /> headers="c5" class="t_td" id="WC_RFQResponseDisplay_TableCell_35_<c:out value="${param.count}" />"><a href="<c:out value="${RFQResponseProductDisplayHref}"/>" id="WC_RFQResponseDisplay_Link_5_<c:out value="${param.count}" />"><c:out value="${resProdName}" /></a></td>
        <td <c:out value="${wrap}" /> headers="c6" class="t_td" id="WC_RFQResponseDisplay_TableCell_36_<c:out value="${param.count}" />"><c:out value="${res_type}" /></td>
		<td <c:out value="${wrap}" /> headers="c7" class="t_td" id="WC_RFQResponseDisplay_TableCell_37_<c:out value="${param.count}" />"><c:out value="${priceAdjust} ${percent}" /></td>
        <td <c:out value="${wrap}" /> headers="c8" class="t_td" id="WC_RFQResponseDisplay_TableCell_38_<c:out value="${param.count}" />" class="price"><c:out value="${rfqRspProd.formattedProductPrice}" escapeXml="false" /></td>
        <td <c:out value="${wrap}" /> headers="c9" class="t_td" id="WC_RFQResponseDisplay_TableCell_39_<c:out value="${param.count}" />"><c:out value="${rfqRspProd.currency}" /></td>
        <td <c:out value="${wrap}" /> headers="c10" class="t_td" id="WC_RFQResponseDisplay_TableCell_310_<c:out value="${param.count}" />"><c:out value="${rfqRspProd.formattedQuantity}" /></td>
        <td <c:out value="${wrap}" /> headers="c11" class="t_td" id="WC_RFQResponseDisplay_TableCell_311_<c:out value="${param.count}" />"><c:out value="${unit}" />&nbsp;</td>
                                           
   <c:remove var="catalogABRes" />
   <c:remove var="catalogAB" />                                        

					 						
					 						
        

