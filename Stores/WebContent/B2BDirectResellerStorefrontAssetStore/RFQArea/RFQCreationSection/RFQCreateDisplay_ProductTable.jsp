<%
/*
 *-------------------------------------------------------------------
 * Licensed Materials - Property of IBM
 *
 * WebSphere Commerce
 *
 * (c) Copyright International Business Machines Corporation. 2001, 2004
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
  * This JSP page displays an input table for product price adjustment.
  *
  * Required parameters:
  * - productId
  * - defaultCurrency
  *
  *****
--%>

<%@ page language="java" %>

<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../include/JSTLEnvironmentSetup.jspf" %>


<%@ include file="RFQCreateConstants.jspf" %>

<c:set var="wrap" value="${requestScope.wrap}" scope="request" />

<wcbase:useBean id="product"
	classname="com.ibm.commerce.catalog.beans.ProductDataBean">
	<c:set target="${product}" property="productID" value="${param.productId}" />
	
</wcbase:useBean>

 <c:if test="${product.catalogEntryReferenceNumber != ''}">
	<wcbase:useBean id="ceDB"
		classname="com.ibm.commerce.catalog.beans.CatalogEntryDataBean">
		<c:set target="${ceDB}" property="catalogEntryID" value="${product.catalogEntryReferenceNumber}" />
		
	</wcbase:useBean>
	
		<fmt:message key="RFQModifyDisplay_Item" bundle="${storeText}" var="RFQModifyDisplay_Item"/>
		<fmt:message key="RFQModifyDisplay_Product" bundle="${storeText}" var="RFQModifyDisplay_Product"/>
		<fmt:message key="RFQModifyDisplay_Prebuilt_Kit" bundle="${storeText}" var="RFQModifyDisplay_Prebuilt_Kit"/>
		<fmt:message key="RFQModifyDisplay_Bundle" bundle="${storeText}" var="RFQModifyDisplay_Bundle"/>
		<fmt:message key="RFQModifyDisplay_Dynamic_Kit" bundle="${storeText}" var="RFQModifyDisplay_Dynamic_Kit"/>
	

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
</c:if>
<c:set var="offerPrice" value="${product.standardPrice}" />

<wcbase:useBean id="QuantityUnitList" classname="com.ibm.commerce.common.beans.QuantityUnitListDataBean">
        <c:set target="${QuantityUnitList}" property="languageId" value="${langId}" />
</wcbase:useBean>
<c:set var="quantitiesByLanguage" value="${QuantityUnitList.quantityUnitList}"/>

<table cellpadding="0" cellspacing="0" border="0" width="1000" class="bgColor" id="WC_RFQCreateDisplay_ProductTable_Table_1">
<tbody><tr>
    <td id="WC_RFQCreateDisplay_ProductTable_TableCell_1">
    <table width="100%" border="0" cellpadding="2" cellspacing="1" class="bgColor" id="WC_RFQCreateDisplay_ProductTable_Table_2">
	<tbody>
		<tr>
			<th <c:out value="${wrap}" /> id="c1" valign="center"  class="colHeader"> <fmt:message key="RFQCreateDisplay_ItemName" bundle="${storeText}" />   </th>
			<th <c:out value="${wrap}" /> id="c2" valign="center"  class="colHeader"> <fmt:message key="RFQCreateDisplay_ItemDesc" bundle="${storeText}" />   </th>
			<th <c:out value="${wrap}" /> id="c3" valign="center"  class="colHeader"> <fmt:message key="RFQCreateDisplay_ItemSKU" bundle="${storeText}" />    </th>
			<th <c:out value="${wrap}" /> id="c4" valign="center"  class="colHeader"> <fmt:message key="RFQCreateDisplay_ItemManu" bundle="${storeText}" />   </th>
			<th <c:out value="${wrap}" /> id="c5" valign="center"  class="colHeader"> <fmt:message key="RFQCreateDisplay_ItemPartNum" bundle="${storeText}" /></th>                                             
			<th <c:out value="${wrap}" /> id="c6" valign="center"  class="colHeader"> <fmt:message key="RFQCreateDisplay_ItemProdType" bundle="${storeText}" /></th>
			<th <c:out value="${wrap}" /> id="c7" valign="center"  class="colHeader_price"> <fmt:message key="RFQCreateDisplay_ItemOfferPrice" bundle="${storeText}" /></th>
			<th <c:out value="${wrap}" /> id="c8" valign="center"  class="colHeader"> <fmt:message key="RFQCreateDisplay_ItemPriceAdjustment" bundle="${storeText}" /></th>                                               
			<th <c:out value="${wrap}" /> id="c9" valign="center"  class="colHeader_price"> <fmt:message key="RFQCreateDisplay_ItemFixedPrice" bundle="${storeText}" />  </th>
			<th <c:out value="${wrap}" /> id="c10" valign="center"  class="colHeader"> <fmt:message key="RFQCreateDisplay_ItemCurr" bundle="${storeText}" />   </th>
			<th <c:out value="${wrap}" /> id="c11" valign="center"  class="colHeader"> <fmt:message key="RFQCreateDisplay_ItemQuan" bundle="${storeText}" />   </th>
			<th <c:out value="${wrap}" /> id="c12" valign="center"  class="colHeader_last"> <fmt:message key="RFQCreateDisplay_ItemUnit" bundle="${storeText}" />   </th>
		</tr>
		<tr>
			<td headers="c1" class="cellBG_1 t_td" id="WC_RFQCreateDisplay_ProductTable_TableCell_2"><c:out value="${product.description.shortDescription}" /></td>
			<td headers="c2" class="cellBG_1 t_td" id="WC_RFQCreateDisplay_ProductTable_TableCell_3">&nbsp;</td>                                                
			<td headers="c3" class="cellBG_1 t_td" id="WC_RFQCreateDisplay_ProductTable_TableCell_4"><c:out value="${product.partNumber}" /></td>                                                
			<td headers="c4" class="cellBG_1 t_td" id="WC_RFQCreateDisplay_ProductTable_TableCell_5"><c:out value="${product.manufacturerName}" /></td>
			<td headers="c5" class="cellBG_1 t_td" id="WC_RFQCreateDisplay_ProductTable_TableCell_6"><c:out value="${product.manufacturerPartNumber}" /></td>
                        <input type="hidden" name="<c:out value="${EC_OFFERING_CATENTRYID}" />_1" value="<c:out value="${product.catalogEntryReferenceNumber}" />" />                                                                                             
			<td headers="c6" class="cellBG_1 t_td" id="WC_RFQCreateDisplay_ProductTable_TableCell_7"><c:out value="${type}" /></td>
                        <input type="hidden" name="prodType_1" value="<c:out value="${type}" />">                            
			<c:choose>
				<c:when test="${offerPrice != null}" >
					<td headers="c7" class="cellBG_1 t_td" id="WC_RFQCreateDisplay_ProductTable_TableCell_8" class="price"><c:out value="${offerPrice}" escapeXml="false" /></td>
					<td headers="c8" class="cellBG_1 t_td" id="WC_RFQCreateDisplay_ProductTable_TableCell_9">
						<label for="WC_RFQModifyDisplay_FormInput_<c:out value="${EC_OFFERING_PERCENTAGEPRICE}_1" />_In_RFQModifyProductForm_1"></label> 
							<input size="6" maxlength="9" class="input" type="text" name="<c:out value="${EC_OFFERING_PERCENTAGEPRICE}_1" />" title="<fmt:message key="RFQModifyDisplay_ProdPPAdjust" bundle="${storeText}" /><c:out value="${product.description.shortDescription}" />" value="" id="WC_RFQModifyDisplay_FormInput_<c:out value="${EC_OFFERING_PERCENTAGEPRICE}_1" />_In_RFQModifyProductForm_1"/>
						
					</td>
				</c:when> 
				<c:otherwise>
					<td headers="c7" class="cellBG_1 t_td" id="WC_RFQCreateDisplay_ProductTable_TableCell_10">&nbsp;</td>	        	
					<td headers="c8" class="cellBG_1 t_td" id="WC_RFQCreateDisplay_ProductTable_TableCell_11">
						<label for="WC_RFQModifyDisplay_FormInput_<c:out value="${EC_OFFERING_PERCENTAGEPRICE}_1" />_In_RFQModifyProductForm_1"></label>
							<input size="6" maxlength="9" class="input" type="text" name="<c:out value="${EC_OFFERING_PERCENTAGEPRICE}_1" />" title="<fmt:message key="RFQModifyDisplay_ProdPPAdjust" bundle="${storeText}" /><c:out value="${product.description.shortDescription}" />" value="" id="WC_RFQModifyDisplay_FormInput_<c:out value="${EC_OFFERING_PERCENTAGEPRICE}_1" />_In_RFQModifyProductForm_1"/>
						
					</td>
				</c:otherwise>
			</c:choose>                       	
                           	 
			<!-- input type="hidden" name="<c:out value="${EC_OFFERING_NEGOTIATIONTYPE}" />_1" value="1" / -->
                            <input type="hidden" name="<c:out value="${EC_OFFERING_ORDERITEMID}" />_1" value="" />  
                            <td headers="c9" class="cellBG_1 t_td" id="WC_RFQCreateDisplay_ProductTable_TableCell_12"><label for="WC_RFQCreateDisplay_ProductTable_FormInput_1"></label><input class="input" type="text" id="WC_RFQCreateDisplay_ProductTable_FormInput_1" name="<c:out value="${EC_OFFERING_PRICE}" />_1" maxlength="9" size="6" /></td>
                            <td headers="c10" class="cellBG_1 t_td" id="WC_RFQCreateDisplay_ProductTable_TableCell_13"><input type="hidden" name="<c:out value="${EC_OFFERING_CURRENCY}" />_1" value="<c:out value="${param.defaultCurrency}" />" /><c:out value="${param.defaultCurrency}" /></td>
                            <td headers="c11" class="cellBG_1 t_td" id="WC_RFQCreateDisplay_ProductTable_TableCell_14"><label for="WC_RFQCreateDisplay_ProductTable_FormInput_2"></label><input class="input" type="text" id="WC_RFQCreateDisplay_ProductTable_FormInput_2" name="<c:out value="${EC_OFFERING_QUANTITY}" />_1" maxlength="6" size="6" /></td>
                            <td headers="c12" class="cellBG_1 t_td" id="WC_RFQCreateDisplay_ProductTable_TableCell_15"><label for="WC_RFQCreateDisplay_ProductTable_FormSelect_1"></label><select class="select" id="WC_RFQCreateDisplay_ProductTable_FormSelect_1" name="<c:out value="${EC_OFFERING_QTYUNIT}" />_1">
                                	<option value=""></option>
                                <c:forEach items="${pageScope.quantitiesByLanguage}" var="quantity">
                                	<option value="<c:out value="${quantity.quantityUnitId}" />"><c:out value="${quantity.description}" /></option>
                                </c:forEach>
                            </select></td>
                        </tr>
                        <input type="hidden" name="productId" value="<c:out value="${param.productId}" />" id="WC_RFQCreateDisplay_FormInput_numProd_In_RFQCreateForm_1"/>       
                        <input type="hidden" name="numProd" value="1" id="WC_RFQCreateDisplay_FormInput_numProd_In_RFQCreateForm_2"/>
        </tbody>
        </table>
        </td>
    </tr>
</tbody>                           
</table>                           
  



     




