<%
//********************************************************************
//*-------------------------------------------------------------------
//* Licensed Materials - Property of IBM
//*
//* WebSphere Commerce
//*
//* (c) Copyright IBM Corp. 2003
//*
//* US Government Users Restricted Rights - Use, duplication or
//* disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
//*
//*-------------------------------------------------------------------
//*
//*---------------------------------------------------------------------
//* The sample contained herein is provided to you "AS IS".
//*
//* It is furnished by IBM as a simple example and has not been  
//* thoroughly tested
//* under all conditions.  IBM, therefore, cannot guarantee its 
//* reliability, serviceability or functionality.  
//*
//* This sample may include the names of individuals, companies, brands 
//* and products in order to illustrate concepts as completely as 
//* possible.  All of these names
//* are fictitious and any similarity to the names and addresses used by 
//* actual persons 
//* or business enterprises is entirely coincidental.
//*---------------------------------------------------------------------
//*
%>
<%-- 
  *****
  * This Jsp snippet displays all the available discounts associated with a particular category or catalog entry.
  * Use the CalculationCodeListDataBean to retrieve all the CalculationCodeDataBeans in order to get required information.
  *
  * Prerequisites:
  * 1. Before you can see the category discounts, you must create some category or product promotions associated with the category or
  *    product, which will be displayed on the test page. The short description, long description and the promotion's period of availability 
  *    are required when you create these promotions.          
  *
  *  How to use this snippet? 
  * 1. To display category discounts in your store's category page, cut and paste the code from the
  *    snippet to your category page.
  *
  *   For more information on using the sample, refer to the topic "Displaying Promotion" in the Sample gallery.
  *****
--%>


<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>

<%--
  ***
  * Activate the data beans at the beginning of the JSP file. 
  * If you create a JSP file based on the following code snippet, copy the data bean 
  * activation code to your JSP file and uncomment it.
  ***
--%>
<%-- [Data Bean Activation]
<wcbase:useBean id="marketing_snippetSDB" classname="com.ibm.commerce.common.beans.StoreDataBean" />

<wcbase:useBean id="marketing_Category" classname="com.ibm.commerce.catalog.beans.CategoryDataBean" />

<wcbase:useBean id="marketing_CategoryPromotionList" classname="com.ibm.commerce.fulfillment.beans.CalculationCodeListDataBean" >
  <c:set target="${marketing_CategoryPromotionList}" property="catalogGroupId" value="${marketing_Category.categoryId}"/>
</wcbase:useBean>
[Data Bean Activation] --%>      

<%-- URL pointing to the shared image directory.  Use this variable to reference images --%>
<c:set var="marketing_snippetJspStoreImgDir" value="${marketing_snippetSDB.jspStoreDirFilePath}" scope="page" />

<table border="0" cellpadding="0" cellspacing="10" width="600">
<tbody>
  <tr>
    <td colspan="3">
      <c:out value="${marketing_Category.description.name}" />
<%-- 
  ***
  * Start: Main Category Promotion Description 
  *
  * Use the marketing_Promotion variable to represent each returned promotion in the promotion list, and display its short description,
  * long description and period of availability.
  *** 
--%>      
      <c:forEach var="marketing_Promotion" items="${marketing_CategoryPromotionList.calculationCodeDataBeans}">
      <%-- Display promotion's short description --%>
      <br/><font color="red">*</font>&nbsp;<c:out value="${marketing_Promotion.descriptionString}" />
      <%-- Display promotion's long description --%>
      <br/><c:out value="${marketing_Promotion.longDescriptionString}" escapeXml="false"/>
      <%-- Display promotion's start and end date --%>
      <br/><c:out value="${marketing_Promotion.localizedStartDate}" /> - <c:out value="${marketing_Promotion.localizedEndDate}" />
      </c:forEach>
<%--
  *** 
  * End: Main Category Promotion Description
  ***
--%>
      <hr width="580" noshade="noshade" align="left"/>
    </td>
  </tr>
  <tr>
    <td width="340">&nbsp;</td>
    <td width="1"><img src="<c:out value="${marketing_snippetJspStoreImgDir}" />images/trans_pixel.gif" width="1" alt="" border="0"/></td>
    <td width="256" valign="top">&nbsp;</td>
    </tr>
  <tr>
    <td colspan="3">
      <table cellpadding="0" cellspacing="0" width="579" border="0">
      <tbody>
<!-- Start: Subcategories -->
      <c:forEach var="marketing_Subcat" items="${marketing_Category.subCategories}">
        <tr>
          <td width="10">&nbsp;</td>
          <td align="left" valign="top" colspan="2">
            <c:url var="marketing_CategoryDisplayURL" value="CategoryDisplay">
              <c:param name="catalogId" value="${catalogId}" />
              <c:param name="storeId" value="${storeId[0]}" />
              <c:param name="categoryId" value="${marketing_Subcat.categoryId}" />
              <c:param name="langId" value="${langId[0]}" />
            </c:url>
            <a href="<c:out value="${marketing_CategoryDisplayURL}"/>"><c:out value="${marketing_Subcat.description.name}"/></a>
            
<%-- 
  ***
  * Start: SubCategories Promotion Description
  * Find all of the promotions associated with sub category, and assign a category ID to the bean.
  * Remove variable first to make sure CalculationCodeListDataBean be instantiated each time.
  * Set property "includeParentCategory" to true, return all the promotions associated with sub category and its parent categories as well.
  * Set property "includeParentCategory" to false, only return the promotions associated with sub category.
  *** 
--%>
            <c:remove var="marketing_subCategoryPromotionList"/>
            <wcbase:useBean id="marketing_subCategoryPromotionList" classname="com.ibm.commerce.fulfillment.beans.CalculationCodeListDataBean">
              <c:set target="${marketing_subCategoryPromotionList}" property="catalogGroupId" value="${marketing_Subcat.categoryId}"/>  
              <c:set target="${marketing_subCategoryPromotionList}" property="includeParentCategory" value="true" />
            </wcbase:useBean>
            
            
            <c:forEach var="marketing_Promotion" items="${marketing_subCategoryPromotionList.calculationCodeDataBeans}">
            <%-- Display promotion short description --%>
            <br/><font color="red">*</font>&nbsp;<c:out value="${marketing_Promotion.descriptionString}" />
            <%-- Display promotion long description --%>
            <br/><c:out value="${marketing_Promotion.longDescriptionString}" escapeXml="false"/>
            <%-- Display promotion start and end date --%>
            <br/><c:out value="${marketing_Promotion.localizedStartDate}" /> - <c:out value="${marketing_Promotion.localizedEndDate}" />
            </c:forEach>
<%-- 
  ***
  * End: SubCategories Promotion Description
  ***
--%>
            <br/><br/>
          </td> 
        </tr>

      </c:forEach>

<!-- Start: Products -->
      <c:forEach var="marketing_Product" items="${marketing_Category.products}">
        <c:url var="marketing_ProductDisplayURL" value="ProductDisplay">
          <c:param name="catalogId" value="${catalogId}" />
          <c:param name="storeId" value="${storeId[0]}" />
          <c:param name="productId" value="${marketing_Product.productID}" />
          <c:param name="langId" value="${langId[0]}" />
        </c:url>

        <tr>
          <td width="10" >&nbsp;</td>
          <td align="left" valign="top">
            <a href="<c:out value="${marketing_ProductDisplayURL}"/>" >
            <img src="<c:out value="${marketing_Product.objectPath}" /><c:out value="${marketing_Product.description.fullImage}" />" alt="<c:out value="${marketing_Product.description.shortDescription}" />" hspace="5" width="50" height="50" border="0" align="left"/>
            </a>
          </td>
          <td align="left" valign="top" >
            <a href="<c:out value="${marketing_ProductDisplayURL}"/>" >
            <c:out value="${marketing_Product.description.shortDescription}" />
            </a>
            <br/>
            <c:out value="${marketing_Product.description.longDescription}" escapeXml="false"/>							
            <br/>
<%-- 
  ***
  * Start: Product Promotion Description
  * Pass the product ID into the marketing_ProductPromotionList databean to retrieve all of the promotions associated with this product.
  * Remove variable first to make sure CalculationCodeListDataBean be instantiated each time.
  ***
--%>
            <c:remove var="marketing_ProductPromotionList"/>
            <wcbase:useBean id="marketing_ProductPromotionList" classname="com.ibm.commerce.fulfillment.beans.CalculationCodeListDataBean">
              <c:set target="${marketing_ProductPromotionList}" property="catalogEntryId" value="${marketing_Product.productID}"/>
            </wcbase:useBean>
            				
            <c:forEach var="marketing_ProductPromotion" items="${marketing_ProductPromotionList.calculationCodeDataBeans}">
            <%-- Display promotion short description --%>
            <br/><font color="red">*</font>&nbsp;<c:out value="${marketing_ProductPromotion.descriptionString}" />
            <%-- Display promotion long description --%>
            <br/><c:out value="${marketing_ProductPromotion.longDescriptionString}" escapeXml="false"/>
            <%-- Display promotion start and end date --%>
            <br/><c:out value="${marketing_ProductPromotion.localizedStartDate}" /> - <c:out value="${marketing_ProductPromotion.localizedEndDate}" />			
            </c:forEach>
<%-- 
  ***
  * End: Product Promotion Description
  ***
--%>
            <br/><br/>
          </td>
        </tr>
      </c:forEach>
    </tbody>
    </table>
  </td>
  </tr>
</tbody>
</table>	

	
