<%
//********************************************************************
//*-------------------------------------------------------------------
//* Licensed Materials - Property of IBM
//*
//* WebSphere Commerce
//*
//* (c) Copyright IBM Corp. 2000, 2002, 2004
//*
//* US Government Users Restricted Rights - Use, duplication or
//* disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
//*
//*-------------------------------------------------------------------
//*
%>
<%-- 
  *****
  * This JSP imports CachedProductItemDisplay or CachedProductOnlyDisplay based on store configuration.
  * It also imports header, sidebar, and footer.
  *****
--%>

<!-- Start - JSP File Name:  ProductDisplay.jsp -->

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf"%>

<wcbase:useBean id="product" classname="com.ibm.commerce.catalog.beans.ProductDataBean" scope="request" />

<%-- If there is no productId in the request, then we tried to add one from partNumber, if the partnumber
	 is in the request
--%>
<c:if test="${empty productId && !empty WCParam.partNumber}">
	<wcbase:useBean id="catalogEntry" classname="com.ibm.commerce.catalog.beans.CatalogEntryDataBean">
		<c:set property="partNumber" value="${WCParam.partNumber}" target="${catalogEntry}"/>
	</wcbase:useBean>
	<c:set property="productId" value="${catalogEntry.catalogEntryID}" target="${WCParam}"/>
</c:if>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title><fmt:message key="PRODUCT_TITLE" bundle="${storeText}" />: <c:out value="${product.description.name}" escapeXml="false"/></title>
<meta name="description" content="<c:out value="${product.description.longDescription}"/>"/>
<meta name="keyword" content="<c:out value="${product.description.keyWord}"/>"/>
<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${vfileStylesheet}"/>" type="text/css"/>
</head>

<body>

<!-- JSP File Name:  ProductDisplay.jsp -->

<%@ include file="../../../include/LayoutContainerTop.jspf"%>

	<%-- 
	  ***
	  *	Start: Main Content
	  * Import JSP based on store configuration.
	  * If ProductOnlyDisplay is enabled, CachedProductOnlyDisplay.jsp is imported.  Otherwise, CachedProductItemDisplay is imported.
	  ***
	--%>
	<%-- Flush the buffer so this fragment JSP is not cached twice --%>
	<%out.flush();%>
	<flow:ifEnabled feature="ProductOnlyDisplay" >
	    <c:import url="../../../Snippets/Catalog/CatalogEntryDisplay/CachedProductOnlyDisplay.jsp">
	        <c:param name="storeId" value="${WCParam.storeId}"/>
	        <c:param name="catalogId" value="${WCParam.catalogId}"/>
	        <c:param name="langId" value="${langId}"/>
	        <c:param name="productId" value="${productId}"/>
	        <c:param name="parent_category_rn" value="${WCParam.parent_category_rn}"/>
	        <c:param name="shouldCachePage" value="${WCParam.shouldCachePage}"/>
	    </c:import>
	</flow:ifEnabled>	
	<flow:ifDisabled feature="ProductOnlyDisplay">	
	    <c:import url="../../../Snippets/Catalog/CatalogEntryDisplay/CachedProductItemDisplay.jsp">
	        <c:param name="storeId" value="${WCParam.storeId}"/>
	        <c:param name="catalogId" value="${WCParam.catalogId}"/>
	        <c:param name="langId" value="${langId}"/>
	        <c:param name="productId" value="${productId}"/>
	        <c:param name="parent_category_rn" value="${WCParam.parent_category_rn}"/>
	        <c:param name="shouldCachePage" value="${WCParam.shouldCachePage}"/>
	    </c:import>
	</flow:ifDisabled>
	<%out.flush();%>
	<%-- 
	  ***
	  *	End: Main Content
	  ***
	--%>
	
<table align="center" cellpadding="2" cellspacing="0" width="786" border="0" id="WC_ProductDisplay_Table_1">
	<tbody>
		<tr align="center">
			<td>
				<table cellpadding="0" cellspacing="0" border="0" width="100%">
					<tr>	
						<c:if test="${ !empty WCParam.parent_category_rn }" >
						<td id="subNav_1" valign="top">&nbsp;</td>
						</c:if>
						<td>
							<%-- 
							  ***
							  *	Start: Cross-Sell, Up-Sell, Accessory, Replacement
							  * Include MerchandisingAssociationsDisplay.jsp if Cross-Sell, Up-Sell, Accessory, Replacement are set up
							  ***
							--%>
							<%-- Flush the buffer so this fragment JSP is not cached twice --%>
							<%out.flush();%>
						        <c:import url="${jspStoreDir}Snippets/Catalog/MerchandisingAssociations/MerchandisingAssociationsDisplay.jsp">
				            			<c:param name="catalogEntryType" value="ProductBean"/>
				            			<c:param name="pageView" value="image"/>
				        		</c:import>
							<%out.flush();%>
							<%-- 
							  ***										  
							  *	End: Cross-Sell, Up-Sell, Accessory, Replacement
							  ***
							--%>										
			
							<%-- Now display the disclaimers for discounts, if there is at least one discounts --%>
							<fmt:message var="disclaimer" key="DISCOUNT_DISCLAIMER" bundle="${storeText}"/>
							<script type="text/javascript">
							<!-- <![CDATA[
							if (Discount.getAreThereAnyDiscounts()) {
								document.write('<br /><br /><span class="discount">');
								document.write('<img src="<c:out value="${jspStoreImgDir}" />images/Discount_star.gif" alt="<c:out value="${disclaimer}" escapeXml="true" />" />&nbsp;<c:out value="${disclaimer}" escapeXml="true"/>');
								document.write('</span>');
							}
							//[[>--> 
							</script>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</tbody>
</table>
	
	
	<%-- Hide CIP --%>
	<c:set var="HideCIP" value="true"/>

<%@ include file="../../../include/LayoutContainerBottom.jspf"%>

</body>
</html>

<!-- End - JSP File Name:  ProductDisplay.jsp -->
