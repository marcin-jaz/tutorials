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
  * This JSP page is used to iterate through the response products.
  *
  * Imports:
  * - RFQCompleteContract_ProductHeader.jsp
  * - RFQCompleteContractDisplay_EvalProducts.jsp
  *
  * Required parameters:
  * - rfqResponseEvals
  * - index - int
  * - negotiationType int
  *
  *****
--%>

<%@ page language="java" %>

<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="flow.tld" prefix="flow" %>

<%@ include file="../../include/JSTLEnvironmentSetup.jspf" %>


<c:set var="EC_NEGOTIATIONTYPE_PRODFIXPRICE" value="1" scope="page" />
<c:set var="EC_NEGOTIATIONTYPE_PRODPERPRICE" value="2" scope="page" />
<c:set var="EC_NEGOTIATIONTYPE_DKFIXPRICE" value="3" scope="page" />
<c:set var="EC_NEGOTIATIONTYPE_DKPERPRICE" value="4" scope="page" />
<c:set var="EC_OFFERING_ITEMBEAN" value="ItemBean" scope="page" />
<c:set var="EC_OFFERING_PRODUCTBEAN" value="ProductBean" scope="page" />
<c:set var="EC_OFFERING_PACKAGEBEAN" value="PackageBean" scope="page" />
<c:set var="EC_OFFERING_DYNAMICKITBEAN" value="DynamicKitBean" scope="page" />

<c:set var="respondProdList" value="${requestScope.respondProdList}" />
<c:set var="rfqResponseEvals" value="${requestScope.rfqResponseEvals}" />
<c:set var="negotiationType" value="${param.negotiationType}"  />

<c:set var="color" value="cellBG_2" /> 
                                                          
<c:forEach items="${respondProdList}" var="rfqRspProd" varStatus="iter">
	<c:choose>
		<c:when test="${color == 'cellBG_1'}">
			<c:set var="color" value="cellBG_2" />
		</c:when>
		<c:when test="${color == 'cellBG_2'}">
			<c:set var="color" value="cellBG_1" />
		</c:when>
	</c:choose>	
		 
	<%--display product only if eval.rfqResponseProductId eq resProduct.rfqResponseProdId --%>
	<c:forEach items="${rfqResponseEvals}" var="eval">
						
		<c:if test="${eval.rfqResponseProductId eq rfqRspProd.rfqResponseProdId }" >
		
					<wcbase:useBean id="ceDB"
						classname="com.ibm.commerce.catalog.beans.CatalogEntryDataBean">
						<c:set target="${ceDB}" property="catalogEntryID" value="${rfqRspProd.catentryId}" />
						
					</wcbase:useBean>
					
					<c:choose>
						<c:when test="${ceDB.type eq EC_OFFERING_ITEMBEAN}">
							<fmt:message key="RFQModifyDisplay_Item" bundle="${storeText}" var="type"/>
						</c:when>
						<c:when test="${ceDB.type eq EC_OFFERING_PRODUCTBEAN}">
							<fmt:message key="RFQModifyDisplay_Product" bundle="${storeText}" var="type"/>
						</c:when>
						<c:when test="${ceDB.type eq EC_OFFERING_PACKAGEBEAN}">
							<fmt:message key="RFQModifyDisplay_Prebuilt_Kit" bundle="${storeText}" var="type"/>
						</c:when>
						<c:when test="${ceDB.type eq EC_OFFERING_DYNAMICKITBEAN}">
							<fmt:message key="RFQModifyDisplay_Dynamic_Kit" bundle="${storeText}" var="type"/>
						</c:when>
						<c:otherwise>
							<c:set var="type" value="${ceDB.type}" />
						</c:otherwise>
					</c:choose>
										
					<wcbase:useBean id="catalogDB" classname="com.ibm.commerce.catalog.beans.CatalogEntryDescriptionDataBean">
						<c:set target="${catalogDB}" property="dataBeanKeyCatalogEntryReferenceNumber" value="${rfqRspProd.catentryId}" />
						<c:set target="${catalogDB}" property="dataBeanKeyLanguage_id" value="${langId}" />
						
					</wcbase:useBean>
										
					<c:set var="ppAdjust" value="${rfqRspProd.priceAdjustmentInEJBType}" />
					<fmt:formatNumber value="${ppAdjust}" var="ppAdjust" />					
					<c:if  test="${product.priceAdjustmentInEJBType > 0}" >
					    
						<fmt:message key="RFQDisplay_Percentage" bundle="${storeText}" var="percentage"/>
						<c:set var="ppAdjust" value="${ppAdjust} ${percentage}" />
					</c:if>
				<%--
					display is different for each negotiation type
				--%>	
				 <c:if test="${!empty ppAdjust}" >
					<fmt:message key="RFQDisplay_Percentage" bundle="${storeText}" var="percent" />
				</c:if>			
				<tr>   
					<c:choose>
						<c:when test="${negotiationType eq EC_NEGOTIATIONTYPE_PRODPERPRICE}">      
							<td headers="a1" class="<c:out value="${color}" /> t_td" id="WC_RFQCompleteContractDisplay_TableCell_15_<c:out value="${iter.count}"/>"><c:out value="${ catalogDB.name }"/></td>
							<td headers="a2" class="<c:out value="${color}" /> t_td" id="WC_RFQCompleteContractDisplay_TableCell_16_<c:out value="${iter.count}"/>"><c:out value="${ type }"/> </td>
							<td headers="a3" class="<c:out value="${color}" /> t_td" id="WC_RFQCompleteContractDisplay_TableCell_17_<c:out value="${iter.count}"/>"><c:out value="${ ceDB.partNumber }"/></td>
							<td headers="a4" class="<c:out value="${color}" /> t_td" id="WC_RFQCompleteContractDisplay_TableCell_18_<c:out value="${iter.count}"/>"><c:out value="${ ppAdjust } ${percent}"/></td>
						</c:when>
						<c:when test="${negotiationType eq EC_NEGOTIATIONTYPE_PRODFIXPRICE}">
							<td headers="a1" class="<c:out value="${color}" /> t_td" id="WC_RFQCompleteContractDisplay_TableCell_15_<c:out value="${iter.count}"/>"><c:out value="${ catalogDB.name }"/></td>
							<td headers="a2" class="<c:out value="${color}" /> t_td" id="WC_RFQCompleteContractDisplay_TableCell_16_<c:out value="${iter.count}"/>"><c:out value="${ type }"/> </td>
							<td headers="a3" class="<c:out value="${color}" /> t_td" id="WC_RFQCompleteContractDisplay_TableCell_17_<c:out value="${iter.count}"/>"><c:out value="${ ceDB.partNumber }"/></td>
							<td headers="a4" class="<c:out value="${color}" /> t_td" id="WC_RFQCompleteContractDisplay_TableCell_18_<c:out value="${iter.count}"/>"><c:out value="${ rfqRspProd.formattedQuantity }"/></td>
						</c:when>
						<c:when test="${negotiationType eq 'EC_NEGOTIATIONTYPE_DKPERPRICE'}">                
							<td headers="a1" class="<c:out value="${color}" /> t_td" id="WC_RFQCompleteContractDisplay_TableCell_15_<c:out value="${iter.count}"/>"><c:out value="${ catalogDB.name }"/></td>
							<td headers="a3" class="<c:out value="${color}" /> t_td" id="WC_RFQCompleteContractDisplay_TableCell_17_<c:out value="${iter.count}"/>"><c:out value="${ ceDB.partNumber }"/></td>
							<td headers="a4" class="<c:out value="${color}" /> t_td" id="WC_RFQCompleteContractDisplay_TableCell_18_<c:out value="${iter.count}"/>"><c:out value="${ ppAdjust } ${percent}"/></td>
						</c:when>
						<c:when test="${negotiationType eq 'EC_NEGOTIATIONTYPE_DKFIXPRICE'}">		              
							<td headers="a1" class="<c:out value="${color}" /> t_td" id="WC_RFQCompleteContractDisplay_TableCell_15_<c:out value="${iter.count}"/>"><c:out value="${ catalogDB.name }"/></td>
							<td headers="a3" class="<c:out value="${color}" /> t_td" id="WC_RFQCompleteContractDisplay_TableCell_17_<c:out value="${iter.count}"/>"><c:out value="${ ceDB.partNumber }"/></td>
							<td headers="a4" class="<c:out value="${color}" /> t_td" id="WC_RFQCompleteContractDisplay_TableCell_18_<c:out value="${iter.count}"/>"><c:out value="${ rfqRspProd.formattedQuantity }"/></td>
						</c:when>
					</c:choose>
				</tr>
			</c:if>
			
			<c:remove var="ceDB" />
			<c:remove var="catalogDB" />
			
	</c:forEach>
</c:forEach>
					