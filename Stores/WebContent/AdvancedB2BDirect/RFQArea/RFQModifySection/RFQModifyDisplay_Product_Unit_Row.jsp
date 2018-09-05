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
  * This JSP page iterates through the product items on the 
  * RFQModifyDisplay JSP page.
  *
  * Imports:
  * - RFQModifyDisplay_Product_links.jsp
  *
  * Required parameters:
  * - RFQProdDataBean[] pList
  * - offering_id
  * - index of a bean int
  *
  *****
--%>

<%@ page language="java" %>

<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../include/JSTLEnvironmentSetup.jspf" %>



 
<c:set var="pList" value="${requestScope.pList}" />
<c:set var="product" value="${pList[param.index]}" />

<c:set var="catid" value="${product.catentryIdInEJBType}" />
<c:set var="rfqProdId" value="${product.rfqprodIdInEJBType}" />
<c:set var="categoryId" value="${product.rfqCategryIdInEJBType}" />
<c:set var="quantityUnits" value="${product.quantityUnits}" scope="request" />
<c:set var="supplier" value="${product.supplier}" scope="request" />

<c:if test="${categoryId != null && !empty categoryId}" >

	<wcbase:useBean id="rfqCategoryAB" classname="com.ibm.commerce.rfq.beans.RFQCategryDataBean">
		<c:set target="${rfqCategoryAB}" property="initKey_rfqCategryId" value="${categoryId}" />
		
	</wcbase:useBean>
	
	<c:set var="rfqCategoryABId" value="${rfqCategoryAB.rfqCategryIdInEJBType}"  />
</c:if>  
<c:choose>
	<c:when test="${!empty catid}" >
<%--
		<wcbase:useBean id="catalogAB" classname="com.ibm.commerce.catalog.beans.CatalogEntryDescriptionDataBean">
			<c:set target="${catalogAB}" property="dataBeanKeyCatalogEntryReferenceNumber" value="${catid}" />
			<c:set target="${catalogAB}" property="dataBeanKeyLanguage_id" value="${langId}" />
			
			<c:set var="prodName" value="${catalogAB.name}" />
			<c:set var="shortDesc" value="${catalogAB.shortDescription}" />
		</wcbase:useBean>
--%>
	</c:when>
	<c:otherwise>
			<c:set var="prodName" value="${product.rfqProductName}" />
		<c:if test="${prodName eq null}" >
			<fmt:message key="RFQListDisplay_MadeToOrder" bundle="${storeText}" var="prodName"/>
		</c:if>
	</c:otherwise>
</c:choose>



<c:if test="${!empty catid }">
	<wcbase:useBean id="ceDB"
		classname="com.ibm.commerce.catalog.beans.CatalogEntryDataBean">
		<c:set target="${ceDB}" property="catalogEntryID" value="${catid}" />
		
	</wcbase:useBean>

	<c:choose>
		<c:when test="${ceDB.type eq 'ItemBean'}">
			<fmt:message key="RFQModifyDisplay_Item" bundle="${storeText}" var="type"/>
			<wcbase:useBean id="itemAB" classname="com.ibm.commerce.catalog.beans.ItemDataBean">
				<c:set target="${itemAB}" property="initKey_catalogEntryReferenceNumber" value="${catid}" />
				<c:set target="${itemAB}" property="itemID" value="${catid}" />
			</wcbase:useBean> 		
			<c:set var="catalogEntryDescriptionAB" value="${itemAB.description}"/>
			<c:set var="prodName" value="${catalogEntryDescriptionAB.name}" />  
			<c:set var="shortDesc" value="${catalogEntryDescriptionAB.shortDescription}" /> 
		</c:when>
		<c:when test="${ceDB.type eq 'ProductBean'}">
			<fmt:message key="RFQModifyDisplay_Product" bundle="${storeText}" var="type"/>
			<wcbase:useBean id="productAB" classname="com.ibm.commerce.catalog.beans.ProductDataBean">
				<c:set target="${productAB}" property="initKey_catalogEntryReferenceNumber" value="${catid}" />
				<c:set target="${productAB}" property="productID" value="${catid}" />
			</wcbase:useBean> 		
			<c:set var="catalogEntryDescriptionAB" value="${productAB.description}"/>
			<c:set var="prodName" value="${catalogEntryDescriptionAB.name}" />  
			<c:set var="shortDesc" value="${catalogEntryDescriptionAB.shortDescription}" /> 
		</c:when>
		<c:when test="${ceDB.type eq 'PackageBean'}">
			<fmt:message key="RFQModifyDisplay_Prebuilt_Kit" bundle="${storeText}" var="type"/>
			<wcbase:useBean id="packAB" classname="com.ibm.commerce.catalog.beans.PackageDataBean">
				<c:set target="${packAB}" property="initKey_catalogEntryReferenceNumber" value="${catid}" />
				<c:set target="${packAB}" property="packageID" value="${catid}" />
			</wcbase:useBean> 	
			<c:set var="catalogEntryDescriptionAB" value="${packAB.description}"/>
			<c:set var="prodName" value="${catalogEntryDescriptionAB.name}" />  
			<c:set var="shortDesc" value="${catalogEntryDescriptionAB.shortDescription}" /> 
		</c:when>
		<c:when test="${ceDB.type eq 'DynamicKitBean'}">
			<fmt:message key="RFQModifyDisplay_Dynamic_Kit" bundle="${storeText}" var="type"/>
		</c:when>
		<c:when test="${ceDB.type eq 'BundleBean'}">
			<fmt:message key="RFQModifyDisplay_Bundle" bundle="${storeText}" var="type"/>
			<wcbase:useBean id="bundleAB" classname="com.ibm.commerce.catalog.beans.BundleDataBean">
				<c:set target="${bundleAB}" property="initKey_catalogEntryReferenceNumber" value="${catid}" />
				<c:set target="${bundleAB}" property="bundleID" value="${catid}" />
			</wcbase:useBean> 		
			<c:set var="catalogEntryDescriptionAB" value="${bundleAB.description}"/>
			<c:set var="prodName" value="${catalogEntryDescriptionAB.name}" />  
			<c:set var="shortDesc" value="${catalogEntryDescriptionAB.shortDescription}" /> 
		</c:when>
		<c:otherwise>
			<c:set var="type" value="${ceDB.type}" />
		</c:otherwise>
	</c:choose>
	<fmt:message key="RFQModifyDisplay_Item" bundle="${storeText}" 	var="RFQModifyDisplay_Item" />
	<fmt:message key="RFQModifyDisplay_Product"	bundle="${storeText}" var="RFQModifyDisplay_Product" />		
	<fmt:message key="RFQModifyDisplay_Dynamic_Kit"	bundle="${storeText}" var="RFQModifyDisplay_Dynamic_Kit" />
	<fmt:message key="RFQModifyDisplay_Prebuilt_Kit" bundle="${storeText}" var="RFQModifyDisplay_Prebuilt_Kit"/>
	
	<c:set var="offerPrice" />	

	<c:if test="${type eq RFQModifyDisplay_Item}" >
		<wcbase:useBean id="iDB"
			classname="com.ibm.commerce.catalog.beans.ItemDataBean">
			<c:set target="${iDB}" property="initKey_catalogEntryReferenceNumber" value="${catid}" />
			<c:set target="${iDB}" property="itemID" value="${catid}" />
			
		</wcbase:useBean>
		<c:set var="offerPrice" value="${iDB.standardPrice}" />
	</c:if>
	<c:if test="${type eq RFQModifyDisplay_Product}" >
		<wcbase:useBean id="pDB" classname="com.ibm.commerce.catalog.beans.ProductDataBean">
			<c:set target="${pDB}" property="initKey_catalogEntryReferenceNumber" value="${catid}" />
			<c:set target="${pDB}" property="productID" value="${catid}" />			
		</wcbase:useBean>
		<c:set var="offerPrice" value="${pDB.standardPrice}" />
	</c:if>
	<c:if test="${type eq RFQModifyDisplay_Prebuilt_Kit}" >
		<wcbase:useBean id="dkDB" classname="com.ibm.commerce.catalog.beans.PackageDataBean">
			<c:set target="${dkDB}" property="initKey_catalogEntryReferenceNumber" value="${catid}" />
			<c:set target="${dkDB}" property="packageID" value="${catid}" />			
		</wcbase:useBean>
		<c:set var="offerPrice" value="${dkDB.standardPrice}" />
	</c:if>
</c:if>

<c:catch var="e" >
<c:set var="priceAdjust" value="${product.priceAdjustmentInEJBType}" />

<c:if  test="${priceAdjust eq '0.0'}" >
	<c:set var="priceAdjust" value="" />
</c:if>
<c:if  test="${!empty priceAdjust}" >
	<fmt:message key="RFQDisplay_Percentage" bundle="${storeText}" var="percentage"/>
	
	<c:set var="priceAdjust" value="${priceAdjust * -1}" />
</c:if>
</c:catch>
<c:if test="${e!=null}">
	<c:set var="priceAdjust" value="" />
</c:if>	

<fmt:formatNumber value="${priceAdjust}" var="priceAdjust" />
 
<c:set var="changeable" value="${product.changeableInEJBType eq '1'}" />
<c:set var="unit" value="${product.qtyUnitId}" />
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
<c:set var="quantity" value="${product.formattedQuantity}" />
<c:choose>
	<c:when	test="${type eq RFQModifyDisplay_Item or type eq RFQModifyDisplay_Product}">
		
	<td headers="c1" class="t_td" id="WC_RFQDisplay_TableCell_48_<c:out value="${param.index + 1}" />">
		<c:if test="${!empty catid}" >  
			<c:out value="${prodName}" />
		</c:if>
		
</c:when>
<c:when test="${type eq RFQModifyDisplay_Dynamic_Kit}">
		
		<td headers="c1" class="t_td" id="WC_RFQDisplay_TableCell_48_<c:out value="${param.index + 1}" />">
			<c:if test="${!empty catid}" >  
				<c:out value="${prodName}" />
			</c:if>
	</c:when> 
	<c:otherwise>
		<c:choose>
		<c:when test="${!empty catid}" >  
		<td headers="c1" class="t_td" id="WC_RFQDisplay_TableCell_48_<c:out value="${param.index + 1}" />"><c:out
			value="${prodName}" />
		</c:when>
		<c:otherwise>
			<td headers="c1" class="t_td" id="WC_RFQDisplay_TableCell_48_<c:out value="${param.index + 1}" />">
		</c:otherwise>
		</c:choose>
			
	</c:otherwise>
</c:choose>


<c:choose>
	<c:when test="${!empty catid}">
		<input type="hidden" name="prodName_<c:out value="${param.index + 1}" />" value="" id="WC_RFQModifyDisplay_FormInput_prodName_<c:out value="${param.index + 1}" />_In_RFQModifyProductForm_1"/>
	</c:when>
	<c:otherwise>
   <label for="WC_RFQModifyDisplay_FormInput_prodName_<c:out value="${param.index + 1}" />_In_RFQModifyProductForm_2"></label>
   	<input type="text" class="input" name="prodName_<c:out value="${param.index + 1}" />" title="<fmt:message key="RFQModifyDisplay_ProdName" bundle="${storeText}" /> <c:out value="${prodName}" />" value="<c:out value="${prodName}" />" id="WC_RFQModifyDisplay_FormInput_prodName_<c:out value="${param.index + 1}" />_In_RFQModifyProductForm_2"/>		
	
	</c:otherwise>
</c:choose>
</td>


<td headers="c2" class="t_td" id="WC_RFQDisplay_TableCell_49_<c:out value="${param.index + 1}" />">
	<c:out	value="${shortDesc}" />&nbsp;</td>
		
<input type="hidden" name="rfqprod_id_<c:out value="${param.index + 1}" />" value="<c:out value="${rfqProdId}" />" id="WC_RFQModifyDisplay_FormInput_rfqprod_id_<c:out value="${param.index + 1}" />_In_RFQModifyProductForm_1"/>
<input type="hidden" name="catentryid_<c:out value="${param.index + 1}" />" value="<c:out value="${catid}" />" id="WC_RFQModifyDisplay_FormInput_catentryid_<c:out value="${param.index + 1}" />_In_RFQModifyProductForm_1"/>
	 
	
<c:if test="${multiSeller}"> 
       <td headers="c3" class="t_td" id="WC_RFQModifyDisplay_TableCell_93_<c:out value="${param.index + 1}" />">
		<c:if test="${catid != ''}">
			<c:out value="${supplier}" />        
        </c:if>         
       </td>                 	           
</c:if>	
	
	
			
<td headers="c4" class="t_td" id="WC_RFQDisplay_TableCell_50_<c:out value="${param.index + 1}" />">
<label for="c4"></label>
<select name="categoryId_<c:out value="${param.index + 1}" />" class="select" id="c4" title='<fmt:message key="RFQModifyDisplay_ProdCat" bundle="${storeText}" /> <c:out value="${prodName}" />'>
	<c:forEach var="category" items="${categoryList}" begin="0" varStatus="iter">
	<c:set var="rfqCategoryId1" value="${category.rfqCategryIdInEJBType}" />	                        	
	<c:set var="rfqCategoryId" value="${rfqCategoryABId}" />
	<option value="<c:out value="${rfqCategoryId1}" />"
	<c:if test="${rfqCategoryId eq rfqCategoryId1}" >
	selected 
	</c:if>
	> <c:out value="${category.name}" /></option>
	</c:forEach>
	<option value="null" 
	<c:if test="${empty rfqCategoryId}" >
	selected
	</c:if>
	> <fmt:message key="RFQExtra_NotCategorized" bundle="${storeText}"/></option>                            	                            	
</select>

</td>


<td headers="c5" class="t_td" id="WC_RFQDisplay_TableCell_51_<c:out value="${param.index + 1}" />"><c:out	value="${type}" />
	<input type="hidden" name="prodType_<c:out value="${param.index + 1}" />" value="<c:out	value="${type}" />"> 	
</td>


<fmt:message key="RFQModifyDisplay_Item" bundle="${storeText}" var="isItem"/>
<fmt:message key="RFQModifyDisplay_Product" bundle="${storeText}" var="isProduct"/>
<fmt:message key="RFQModifyDisplay_Prebuilt_Kit" bundle="${storeText}" var="isPrebuiltKit"/>
<fmt:message key="RFQModifyDisplay_Dynamic_Kit" bundle="${storeText}" var="isDynamicKit"/>



	<c:choose>
		<c:when test="${type eq isItem or type eq isProduct or type eq isPrebuiltKit}">
			<c:choose> 
				<c:when test="${offerPrice != null}">
				<td headers="c6" class="t_td" id="WC_RFQModifyDisplay_TableCell_95_<c:out value="${param.index + 1}" />" class="price"><c:out
					value="${offerPrice}" escapeXml="false" /></td>
				</c:when>
				<c:otherwise>
					<td headers="c6" class="t_td" id="WC_RFQModifyDisplay_TableCell_95_<c:out value="${param.index + 1}" />">&nbsp;
					</td>
				</c:otherwise> 
			</c:choose>		
		</c:when>
	<c:otherwise>
		
				<td headers="c7" class="t_td" id="WC_RFQModifyDisplay_TableCell_95_<c:out value="${param.index + 1}" />">&nbsp; 
                </td>
		
	</c:otherwise>
	</c:choose>
	

<td headers="c8" class="t_td" id="WC_RFQDisplay_TableCell_52_<c:out value="${param.index + 1}" />"
	align="center">
	
	<c:choose>
		<c:when test="${type eq isItem or type eq isProduct or type eq isPrebuiltKit}">
			<c:choose>
				<c:when test="${offerPrice != null}">
		 			<label for="WC_RFQModifyDisplay_FormInput_percentagePrice_<c:out value="${param.index + 1}" />_In_RFQModifyProductForm_1"></label>
		 			<input size="6" maxlength="9" type="text" class="input" name="percentagePrice_<c:out value="${param.index + 1}" />" title="<fmt:message key="RFQModifyDisplay_ProdPPAdjust" bundle="${storeText}"/> <c:out value="${prodName}" />" value="<c:out value="${priceAdjust}" />" id="WC_RFQModifyDisplay_FormInput_percentagePrice_<c:out value="${param.index + 1}" />_In_RFQModifyProductForm_1"/>		
				
				</c:when>
				<c:otherwise>
					<label for="WC_RFQModifyDisplay_FormInput_percentagePrice_<c:out value="${param.index + 1}" />_In_RFQModifyProductForm_1"></label>
					<input size="6" maxlength="9" type="text" class="input" name="percentagePrice_<c:out value="${param.index + 1}" />" title="<fmt:message key="RFQModifyDisplay_ProdPPAdjust" bundle="${storeText}"/> <c:out value="${prodName}" />" value="<c:out value="${priceAdjust}" />" id="WC_RFQModifyDisplay_FormInput_percentagePrice_<c:out value="${param.index + 1}" />_In_RFQModifyProductForm_1"/>		
		
				</c:otherwise>
			</c:choose>		
		</c:when>
		<c:when test="${type eq isDynamicKit }">
			<c:choose>
				<c:when test="${isContract}">
		 				<label for="WC_RFQModifyDisplay_FormInput_percentagePrice_<c:out value="${param.index + 1}" />_In_RFQModifyProductForm_1"></label>
		 				<input size="6" maxlength="9" type="text" class="input" name="percentagePrice_<c:out value="${param.index + 1}" />" title="<fmt:message key="RFQModifyDisplay_ProdPPAdjust" bundle="${storeText}"/>  <c:out value="${prodName}" />" value="<c:out value="${priceAdjust}" />" id="WC_RFQModifyDisplay_FormInput_percentagePrice_<c:out value="${param.index + 1}" />_In_RFQModifyProductForm_1"/>
		 			
				</c:when>
				<c:otherwise>
						&nbsp; 
							
				</c:otherwise>
			</c:choose>		
		</c:when>
		<c:otherwise>
		
		<input type="hidden" name="percentagePrice_<c:out value="${param.index + 1}" />" value="" >
		</c:otherwise>
	</c:choose>
	
	</td>
	
<input type="hidden" name="negotiationType_<c:out value="${param.index + 1}" />" value="1" />


<c:if test="${!empty product.formattedProductPrice}">	
	<c:set var="iNumber" value="${product.priceInEJBType}${number}" />	
	<c:set var="productPrice" value="${iNumber}" />	
</c:if>		 
	
						 	
<td headers="c9" class="t_td" id="WC_RFQDisplay_TableCell_53_<c:out value="${param.index + 1}" />">	
	<label for="WC_RFQModifyDisplay_FormInput_price_<c:out value="${param.index + 1}" />_In_RFQModifyProductForm_1"></label>
	<input size="6" maxlength="9" type="text" class="input" name="price_<c:out value="${param.index + 1}" />" title="<fmt:message key="RFQModifyDisplay_ProdPrice" bundle="${storeText}"/> <c:out value="${prodName}" />" value="<fmt:formatNumber value="${productPrice}" />" id="WC_RFQModifyDisplay_FormInput_price_<c:out value="${param.index + 1}" />_In_RFQModifyProductForm_1"/>
	
	</td>  
	
<td headers="c10" class="t_td" id="WC_RFQDisplay_TableCell_54_<c:out value="${param.index + 1}" />">		
		<input type="hidden" name="currency_<c:out value="${param.index + 1}" />" value="<c:out value="${product.currency}" />" id="WC_RFQModifyDisplay_FormInput_currency_<c:out value="${param.index + 1}" />_In_RFQModifyProductForm_1"/><c:out value="${product.currency}" />                      	
</td>


<td headers="c11" class="t_td" id="WC_RFQDisplay_TableCell_55_<c:out value="${param.index + 1}" />">	
	<label for="c10_<c:out value="${param.index + 1}" />"></label>
	<input size="6" maxlength="6" type="text" class="input" name="quantity_<c:out value="${param.index + 1}" />" id="c10_<c:out value="${param.index + 1}" />" title="<fmt:message key="RFQModifyDisplay_ProdQuan" bundle="${storeText}"/> <c:out value="${prodName}" />" value="<c:out value="${quantity}" />"/>		

</td>  
 
 

<td headers="c12" class="t_td" id="WC_RFQDisplay_TableCell_56_<c:out value="${param.index + 1}" />">	
	<label for="WC_RFQDisplay_Product_Unit_Row_Select_1"></label>
	<select id="WC_RFQDisplay_Product_Unit_Row_Select_1" class="select" name="quantityunit_<c:out value="${param.index + 1}" />" title="<fmt:message key="RFQModifyDisplay_ProdUnit" bundle="${storeText}"/> <c:out value="${prodName}" />">
    <option value=""></option>
	<c:forEach var="units" items="${quantityUnits}" begin="0" varStatus="iter">
		<option value="<c:out value='${units.value}'/>" 		
		<c:if test="${unit eq units.key}">
		selected 
		</c:if>   
		>		
		<c:out value='${units.key}'/>
		</option>				
	</c:forEach>
	 </select>
	
	</td>
	


<c:choose>
<c:when test="${catid != null}">	
<td headers="c13" class="t_td" id="WC_RFQModifyDisplay_TableCell_101_<c:out value="${param.index + 1}" />">	
	<label for="WC_RFQDisplay_Product_Unit_Row_Select_2"></label>
	<select id="WC_RFQDisplay_Product_Unit_Row_Select_2" class="select" name="subst_<c:out value="${param.index + 1}" />" title="<fmt:message key="RFQModifyDisplay_ProdSub" bundle="${storeText}"/> <c:out value="${prodName}" />">									
	<c:choose>
		<c:when test="${changeable}">
		<option value="1" selected ><fmt:message key="RFQModifyAddCommentDisplay_Yes" bundle="${storeText}" />
		</option>
		<option value="0" ><fmt:message key="RFQModifyAddCommentDisplay_No" bundle="${storeText}" />
		</option>
		</c:when>
	<c:otherwise>
		<option value="1" ><fmt:message key="RFQModifyAddCommentDisplay_Yes" bundle="${storeText}" />
		</option> 
		<option value="0" selected ><fmt:message key="RFQModifyAddCommentDisplay_No" bundle="${storeText}" />
		</option>
	</c:otherwise> 
	</c:choose>
	</select>

</td>
</c:when>
<c:otherwise>
   	<td headers="c13" class="t_td" id="WC_RFQModifyDisplay_TableCell_102_<c:out value="${param.index + 1}" />"><fmt:message key="RFQModifyAddCommentDisplay_Yes" bundle="${storeText}" />
		<input type="hidden" name="subst_<c:out value="${param.index + 1}" />" value="1" id="WC_RFQModifyDisplay_FormInput_subst_<c:out value="${param.index + 1}" />_In_RFQModifyProductForm_1"/>
	</td>
</c:otherwise>  
</c:choose> 
<% out.flush(); %>	
<c:import url="RFQModifyDisplay_Product_links.jsp">
		<c:param name="index" value="${param.index + 1}" />	
		<c:param name="rfqProdId" value="${rfqProdId}" />
		<c:param name="isItem" value="${isItem}" />
		<c:param name="isProduct" value="${isProduct}" />
		<c:param name="isPrebuiltKit" value="${isPrebuiltKit}" />
		<c:param name="isDynamicKit" value="${isDynamicKit}" />
		<c:param name="type" value="${type}" />
				
</c:import>	 
<% out.flush(); %>
<c:set var="numProd" value="${param.index + 1}" scope="request" />			
