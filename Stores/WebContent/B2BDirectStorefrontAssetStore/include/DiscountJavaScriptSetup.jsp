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
  * This file is included from a 'cached' catalog page and retrieves discounts for products, items, categories,
  * and packages based on the specified catalogEntryId's and catalogGroupId's.  The JavaScript on this JSP was
  * created to support older Web browsers such as Netscape 4.xx.
  *
  * This file serves two main purposes:
  *	- Encapsulates discount code and keeps it in a single file
  *	- Increases performance by allowing category and product pages to be cached while this page is not.
  *	  Since the catalog JSP's are cached, they cannot show dynamic discounts which are based on shopper attributes.
  *	  To show dynamic discounts, this page was created and not cached.
  *	  If you do not wish to support dynamic discounts, this JSP can be cached as well based on the following
  *	  URL parameters: storeId, catalogId, DC_langId, DC_curr, thisCategoryID, someCategoryIDs, someProductIDs, and someItemIDs
  *
  * Parameters
  * - jsPrototypeName
  *	Required.  This specifies the class name for the generated JavaScript in this file.  Can be any name without spaces
  *
  * - thisCategoryID
  *   	An integer representing a single category ID to get discounts for
  * - thisCategoryIncludeChildItems
  *	Boolean value specifying if the child category discounts should be retrieved as well
  * - thisCategoryIncludeParentCategory
  *	Boolean value specifying if the parent category discounts should be retrieved as well
  *
  * - someCategoryIDs
  *	A comma delimitated string containing a set of category IDs to get discounts for
  * - categoryIncludeChildItems
  *	Boolean value specifying if the child category discounts should be retrieved as well
  * - categoryIncludeParentCategory
  *	Boolean value specifying if the parent category discounts should be retrieved as well
  *
  * - someProductIDs
  * 	A comma delimitated string containing a set of product IDs to get discounts for
  * - productIsProdPromoOnly
  *	
  * - productIncludeChildItems
  *	Boolean value specifying if the child item discounts should be retrieved as well
  * - productIncludeParentProduct
  *	Boolean value specifying if the item's product discounts should be retrieved as well
  *
  * - someItemIDs
  * 	A comma delimitated string containing a set of item IDs to get discounts for
  * - itemIsProdPromoOnly
  *
  * - itemIncludeChildItems
  *	Boolean value specifying if the child item discounts should be retrieved as well
  * - itemIncludeParentProduct
  *	Boolean value specifying if the item's product discounts should be retrieved as well
  *
  *
  * This is an example of how this file could be included into a page: 
  *	<c:import url="${jspStoreDir}include/DiscountJavaScriptSetup.jsp">
  *		<c:param name="jsPrototypeName" value="Discount" />
  *		<c:param name="someItemIDs" value="${WCParam.productId}"/>
  *		<c:param name="itemIncludeChildItems" value="false"/>
  *		<c:param name="itemIsProdPromoOnly" value="false"/>
  *		<c:param name="itemIncludeParentProduct" value="true"/>
  *	</c:import>
  *
  *
  * The following JavaScript functions are generated from the input parameters
  *  - getThisCategoryDiscountText() - returns discount text for the thisCategoryID parameter
  *  - getCategoryDiscountText(categoryId) - returns discount text for the someCategoryIDs specified
  *  - getProductDiscountText(productId) - returns discount text for the someProductIDs specified
  *  - getItemDiscountText(itemId) - returns discount text for the someItemIDs specified
  *  - getAreThereAnyDiscounts() - returns true if any discounts were found
  *
  * Here is an example of how to put discount text for a specific category:
  *	<script>
  *		document.write(Discount.getThisCategoryDiscountText());
  *	</script>
  *****
--%>

<!-- Start- JSP File Name: DiscountJavaScriptSetup.jsp -->

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="JSTLEnvironmentSetup.jspf"%>


<script language="JavaScript">

	<%-- Create a prototype constructor for this JavaScript Class.  All the JavaScript on this page is encapsulated
	     in a Classs so it can be reused more then once on the same JSP --%>
	function <c:out value="${param.jsPrototypeName}" />1() {
		
		this.categoryDiscount = new Array();  	// Array of all category IDs on the page to store category discounts
		this.productDiscount = new Array();	// Array of all product IDs on the page to store product discounts
		this.itemDiscount = new Array();		// Array of all item IDs on the page to store item discounts
		this.thisCategoryDiscount = '';		// String to store discount for the current category
		
		this.foundDiscount = false;

		<%-- 
		***
		* Start:  Create the JavaScript array 'categoryDiscount[categoryId]' to hold all the discount text for each catagory
		***
		--%>
		<c:if test="${!empty param.thisCategoryID}">
				<wcbase:useBean id="categoryDiscountDataBean" classname="com.ibm.commerce.fulfillment.beans.CalculationCodeListDataBean">
					<c:set property="catalogGroupId" value="${param.thisCategoryID}" target="${categoryDiscountDataBean}" />
					<%-- UsageId for discount is -1 --%>
					<c:set property="calculationUsageId" value="-1" target="${categoryDiscountDataBean}" />
					<c:set property="includeChildItems" value="${param.thisCategoryIncludeChildItems}" target="${categoryDiscountDataBean}" />
					<c:set property="includeParentCategory" value="${param.thisCategoryIncludeParentCategory}" target="${categoryDiscountDataBean}" />
				</wcbase:useBean>
	
				<c:forEach var="discountEntry" items="${categoryDiscountDataBean.calculationCodeDataBeans}" varStatus="subCounter">
					<%-- Create the discount details display URL --%>
					<c:url var="DiscountDetailsDisplayViewURL" value="DiscountDetailsDisplayView">
					   <c:param name="code" value="${discountEntry.code}" />
					   <c:param name="langId" value="${langId}" />
					   <c:param name="storeId" value="${WCParam.storeId}" />
					   <c:param name="catalogId" value="${WCParam.catalogId}" />
					   <c:param name="top" value="${WCParam.top}"/> 
					   <c:param name="categoryId" value="${param.thisCategoryID}"/>
					</c:url>
	
					// Create discount text as a hyperlink
					this.thisCategoryDiscount = '<img src="<c:out value="${jspStoreImgDir}" />images/Discount_star.gif" alt="<c:out value="${discountEntry.descriptionString}" />"/>&nbsp;';
					this.thisCategoryDiscount += '<a class="discount" href="<c:out value="${DiscountDetailsDisplayViewURL}" />" alt="<c:out value="${discountEntry.descriptionString}" />" id="WC_Link_CatDiscount_1_<c:out value="${counter.count}"/>">';
					this.thisCategoryDiscount += '<c:out value="${discountEntry.descriptionString}" escapeXml="true" /></a><br /><br />';
					this.foundDiscount = true;
				</c:forEach>
		</c:if>
		<%-- 
		***
		* End:  Create the JavaScript array 'categoryDiscount[categoryId]' to hold all the discount text for each catagory
		***
		--%>
		
		
		<%-- 
		***
		* Start:  Create the JavaScript array 'categoryDiscount[categoryId]' to hold all the discount text for each catagory
		***
		--%>
		<c:if test="${!empty param.someCategoryIDs}">
			<c:forTokens var="aCategoryId" delims=" ," items="${param.someCategoryIDs}">
				<%-- Make sure the CalculationListDataBean will be instantiated each time --%>
				<c:remove var="categoryDiscountDataBean" />
				
				<wcbase:useBean id="categoryDiscountDataBean" classname="com.ibm.commerce.fulfillment.beans.CalculationCodeListDataBean">
					<c:set property="catalogGroupId" value="${aCategoryId}" target="${categoryDiscountDataBean}" />
					<%-- UsageId for discount is -1 --%>
					<c:set property="calculationUsageId" value="-1" target="${categoryDiscountDataBean}" />
					<c:set property="includeChildItems" value="${param.categoryIncludeChildItems}" target="${categoryDiscountDataBean}" />
					<c:set property="includeParentCategory" value="${param.categoryIncludeParentCategory}" target="${categoryDiscountDataBean}" />
				</wcbase:useBean>
					
				// Initialize the discount string
				this.categoryDiscount[<c:out value="${aCategoryId}"/>] = '';
			
				<c:forEach var="discountEntry" items="${categoryDiscountDataBean.calculationCodeDataBeans}" varStatus="subCounter">
					<%-- Create the discount details display URL --%>
					<c:url var="DiscountDetailsDisplayViewURL" value="DiscountDetailsDisplayView">
					   <c:param name="code" value="${discountEntry.code}" />
					   <c:param name="langId" value="${langId}" />
					   <c:param name="storeId" value="${WCParam.storeId}" />
					   <c:param name="catalogId" value="${WCParam.catalogId}" />
					   <c:param name="top" value="${WCParam.top}"/> 
					   <c:param name="categoryId" value="${aCategoryId}"/>
					</c:url>
	
					// Create discount text as a hyperlink
					this.categoryDiscount[<c:out value="${aCategoryId}"/>] += '<img src="<c:out value="${jspStoreImgDir}" />images/Discount_star.gif" alt="<c:out value="${discountEntry.descriptionString}" />"/>&nbsp;';
					this.categoryDiscount[<c:out value="${aCategoryId}"/>] += '<a class="discount" href="<c:out value="${DiscountDetailsDisplayViewURL}" />" alt="<c:out value="${discountEntry.descriptionString}" />" id="WC_Link_CatDiscount_2_<c:out value="${counter.count}"/>">';
					this.categoryDiscount[<c:out value="${aCategoryId}"/>] += '<c:out value="${discountEntry.descriptionString}" escapeXml="true" /></a><br /><br />';
					this.foundDiscount = true;
				</c:forEach>
			</c:forTokens>
		</c:if>
		<%-- 
		***
		* End:  Create the JavaScript array 'categoryDiscount[categoryId]' to hold all the discount text for each catagory
		***
		--%>
	
		<%-- 
		***
		* Start:  Create the JavaScript array 'productDiscount[productId]' to hold all the discount text for each product
		***
		--%>
		<c:if test="${!empty param.someProductIDs}">
			<c:forTokens var="productId" delims=" ," items="${param.someProductIDs}">
				<%-- Remove the exiting productDiscounts, otherwise wcbase:useBean or jsp:useBean won't instantiate
				     the productDiscounts.
				--%>
	
				<c:remove var="productDiscounts"/>
	
				<%-- CalculationCodeListDataBean is used to show the discount information of the product --%>
				<wcbase:useBean id="productDiscounts" classname="com.ibm.commerce.fulfillment.beans.CalculationCodeListDataBean">
					<c:set property="catalogEntryId" value="${productId}" target="${productDiscounts}" />
					<c:set property="isProdPromoOnly" value="${param.productIsProdPromoOnly}" target="${productDiscounts}"/>
					<c:set property="includeChildItems" value="${param.productIncludeChildItems}" target="${productDiscounts}"/>
					<c:set property="includeParentProduct" value="${param.productIncludeParentProduct}" target="${productDiscounts}" />
					<%-- UsageId for discount is -1 --%>
					<c:set property="calculationUsageId" value="-1" target="${productDiscounts}" />
				</wcbase:useBean>
	
				// Initialize the discount string
				this.productDiscount[<c:out value="${productId}"/>] = '';
	
				<c:if test="${!empty productDiscounts}">
					<c:forEach var="discountEntry" items="${productDiscounts.calculationCodeDataBeans}" varStatus="discountCounter">
		
						<c:url var="DiscountDetailsDisplayViewURL" value="DiscountDetailsDisplayView">
					           <c:param name="code" value="${discountEntry.code}" />
					           <c:param name="langId" value="${langId}" />
					           <c:param name="storeId" value="${WCParam.storeId}" />
					           <c:param name="catalogId" value="${WCParam.catalogId}" />
					           <%-- This category ID will be used to retrieve the category information on DiscountDetailDisplay.jsp --%>
					           <c:param name="productId" value="${productId}"/> 
					    	</c:url>
					
			    			this.productDiscount[<c:out value="${productId}"/>] += '<span class="discount">';
						this.productDiscount[<c:out value="${productId}"/>] += '<img src="<c:out value="${jspStoreImgDir}" />images/Discount_star.gif" alt="<c:out value="${discountEntry.descriptionString}" escapeXml="true" />"/>&nbsp;';
						this.productDiscount[<c:out value="${productId}"/>] += '<a class="discount" href="<c:out value="${DiscountDetailsDisplayViewURL}" />" id="WC_Link_ProductDiscount_1_<c:out value="${discountCounter.count}"/>">';
			        		this.productDiscount[<c:out value="${productId}"/>] += '<c:out value="${discountEntry.descriptionString}" escapeXml="true" />';
						this.productDiscount[<c:out value="${productId}"/>] += '</a></span><br /><br />';
						this.foundDiscount = true;
					</c:forEach>
				</c:if>
			</c:forTokens>
		</c:if>
		<%-- 
		***
		* End:  Create the JavaScript array 'productDiscount[productId]' to hold all the discount text for each product
		***
		--%>
	
		<%-- 
		***
		* Start:  Create the JavaScript array 'itemDiscount[itemId]' to hold all the discount text for each item
		***
		--%>
		<c:if test="${!empty param.someItemIDs}">
			<c:forTokens var="itemId" delims=" ," items="${param.someItemIDs}">
				<%-- Remove the exiting itemDiscounts, otherwise wcbase:useBean or jsp:useBean won't instantiate
				     the itemDiscounts.
				--%>
				<c:remove var="itemDiscounts"/>
	
				<%-- CalculationCodeListDataBean is used to show the discount information of the item --%>
				<wcbase:useBean id="itemDiscounts" classname="com.ibm.commerce.fulfillment.beans.CalculationCodeListDataBean">
					<c:set property="catalogEntryId" value="${itemId}" target="${itemDiscounts}" />
					<c:set property="isProdPromoOnly" value="${param.itemIsProdPromoOnly}" target="${itemDiscounts}"/>
					<c:set property="includeChildItems" value="${param.itemIncludeChildItems}" target="${itemDiscounts}"/>
					<c:set property="includeParentProduct" value="${param.itemIncludeParentProduct}" target="${itemDiscounts}" />
					<%-- UsageId for discount is -1 --%>
					<c:set property="calculationUsageId" value="-1" target="${itemDiscounts}" />
				</wcbase:useBean>
	
				// Initialize the discount string
				this.itemDiscount[<c:out value="${itemId}"/>] = '';
	
				<c:if test="${!empty itemDiscounts}">
					<c:forEach var="discountEntry" items="${itemDiscounts.calculationCodeDataBeans}" varStatus="discountCounter">
		
						<c:url var="DiscountDetailsDisplayViewURL" value="DiscountDetailsDisplayView">
					           <c:param name="code" value="${discountEntry.code}" />
					           <c:param name="langId" value="${langId}" />
					           <c:param name="storeId" value="${WCParam.storeId}" />
					           <c:param name="catalogId" value="${WCParam.catalogId}" />
					           <%-- This category ID will be used to retrieve the category information on DiscountDetailDisplay.jsp --%>
					           <c:param name="itemId" value="${itemId}"/> 
					    	</c:url>
					
			    			this.itemDiscount[<c:out value="${itemId}"/>] += '<span class="discount">';
						this.itemDiscount[<c:out value="${itemId}"/>] += '<img src="<c:out value="${jspStoreImgDir}" />images/Discount_star.gif" alt="<c:out value="${discountEntry.descriptionString}" escapeXml="true" />"/>&nbsp;';
						this.itemDiscount[<c:out value="${itemId}"/>] += '<a class="discount" href="<c:out value="${DiscountDetailsDisplayViewURL}" />" id="WC_Link_ProductDiscount_2_<c:out value="${discountCounter.count}"/>">';
			        		this.itemDiscount[<c:out value="${itemId}"/>] += '<c:out value="${discountEntry.descriptionString}" escapeXml="true" />';
						this.itemDiscount[<c:out value="${itemId}"/>] += '</a></span><br /><br />';
						this.foundDiscount = true;
					</c:forEach>
				</c:if>
			</c:forTokens>
		</c:if>
		<%-- 
		***
		* End:  Create the JavaScript array 'itemDiscount[itemId]' to hold all the discount text for each item
		***
		--%>
	} // end function <c:out value="${param.jsPrototypeName}" />1

	<%-- 
	***
	* Start: Construct Get JavaScript methods to return discount text for various types of discounts
	***
	--%>
	// Function getThisCategoryDiscountText();
	<c:out value="${param.jsPrototypeName}" />1.prototype.getThisCategoryDiscountText = function()
	{
		return this.thisCategoryDiscount;
	}
	
	// Function getCategoryDiscountText(categoryId);
	<c:out value="${param.jsPrototypeName}" />1.prototype.getCategoryDiscountText = function(categoryId)
	{
		if (this.categoryDiscount[categoryId] == null || typeof(this.categoryDiscount[categoryId]) == 'undefined') {
			return '';
		}else {
			return this.categoryDiscount[categoryId];
		}
	} // End getCategoryDiscountText(categoryId)

	// Function getProductDiscountText(productId);
	<c:out value="${param.jsPrototypeName}" />1.prototype.getProductDiscountText = function(productId)
	{
		if (this.productDiscount[productId] == null || typeof(this.productDiscount[productId]) == 'undefined') {
			return '';
		}else {
			return this.productDiscount[productId];
		}
	} // End getProductDiscountText(productId)
	
	// Function getItemDiscountText(itemId)
	<c:out value="${param.jsPrototypeName}" />1.prototype.getItemDiscountText = function(itemId)
	{
		if (this.itemDiscount[itemId] == null || typeof(this.itemDiscount[itemId]) == 'undefined') {
			return '';
		}else {
			return this.itemDiscount[itemId];
		}
	} // End getItemDiscountText(itemId)
	
	// Function getAreThereAnyDiscounts();
	// Returns true if any discounts were found 
	<c:out value="${param.jsPrototypeName}" />1.prototype.getAreThereAnyDiscounts = function() {
		return this.foundDiscount;
	}
	
	<%-- Create the discount object now --%>
	var <c:out value="${param.jsPrototypeName}" /> = new <c:out value="${param.jsPrototypeName}" />1();
	
	<%-- 
	***
	* End: Construct Get JavaScript methods to return discount text for various types of discounts
	***
	--%>
</script>


<!-- End - JSP File Name: DiscountJavaScriptSetup.jsp -->