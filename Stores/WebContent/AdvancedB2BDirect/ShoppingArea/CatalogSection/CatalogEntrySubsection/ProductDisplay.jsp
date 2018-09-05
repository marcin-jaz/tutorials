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
  * This JSP imports CachedProductDisplay.jsp
  *****
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf"%>

<wcbase:useBean id="product" classname="com.ibm.commerce.catalog.beans.ProductDataBean" scope="request" />

<%-- If there is no productId in the request, then we tried to add one from partNumber, if the partnumber
	 is in the request
--%>
<c:if test="${empty WCParam.productId && !empty WCParam.partNumber}">
	<wcbase:useBean id="catalogEntry" classname="com.ibm.commerce.catalog.beans.CatalogEntryDataBean">
		<c:set property="partNumber" value="${WCParam.partNumber}" target="${catalogEntry}"/>
	</wcbase:useBean>
	<c:set property="productId" value="${catalogEntry.catalogEntryID}" target="${WCParam}"/>
</c:if>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<!-- BEGIN ProductDisplay.jsp -->
<head>
<title><fmt:message key="ProdDisp_Title" bundle="${storeText}"/> <c:out value="${product.description.shortDescription}" escapeXml="false"/></title>
<meta name="description" content="<c:out value="${product.description.longDescription}"/>">
<meta name="keyword" content="<c:out value="${product.description.keyWord}"/>">
<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${vfileStylesheet}"/>" type="text/css"/>
</head>
<body class="noMargin">
<%@ include file="../../../include/LayoutContainerTop.jspf"%>
<!--START MAIN CONTENT-->
	<%out.flush();%>
	    <c:import url="../../../Snippets/Catalog/CatalogEntryDisplay/CachedProductItemDisplay.jsp">
	        <c:param name="storeId" value="${WCParam.storeId}"/>
	        <c:param name="catalogId" value="${WCParam.catalogId}"/>
	        <c:param name="langId" value="${langId}"/>
	        <c:param name="productId" value="${productId}"/>
	        <c:param name="parent_category_rn" value="${WCParam.parent_category_rn}"/>
	        <c:param name="shouldCachePage" value="${WCParam.shouldCachePage}"/>
	    </c:import>
	<%out.flush();%>
	
	<!-- RFQ Product section begins -->
	<c:if test="${!empty rfqLinkDisplayed && rfqLinkDisplayed=='true'}">
        <flow:ifEnabled feature="RFQ">
	<table cellpadding="0" cellspacing="0" border="0" id="WC_ProductDisplay_Table_1" >
		<tr>
			<td id="WC_ProductDisplay_TableCell_1" colspan="2">
				<span class="subHeading"><fmt:message key="ProdDisp_RFQRequestQuote" bundle="${storeText}"/></span>
			</td>
		</tr>
                <tr>                   
                    	<td id="WC_ProductDisplay_TableCell_2" colspan="2">
                    		<fmt:message key="ProdDisp_NewRFQ" bundle="${storeText}"/>
                        </td>
                </tr>
                <form id="WC_ProductDisplay_AddToRFQForm" name="AddToRFQ" action="" method="post">
                <input type="hidden" name="storeId" value="<c:out value="${storeId}" />" id="WC_CachedProductDisplay_FormInput_storeId_In_AddToRFQForm_1">
		<input type="hidden" name="catalogId" value="<c:out value="${catalogId}" />" id="WC_CachedProductDisplay_FormInput_catalogId_In_AddToRFQForm_1">
		<input type="hidden" name="langId" value="<c:out value="${langId }" />" id="WC_CachedProductDisplay_FormInput_langId_In_AddToRFQForm_1">
		<input type="hidden" name="productId" value="<c:out value="${productId}" />" id="WC_CachedProductDisplay_FormInput_productid_In_AddToRFQForm_1">               
                <tr> 
            	    	<td id="WC_ProductDisplay_TableCell_3" colspan="2">
            	    		<input id="WC_CachedProductDisplay_FormInput_Type_In_AddToRFQForm_1" type="radio" class="radio" name="Type" value="NEW" checked="checked">            			
            			<label for="WC_CachedProductDisplay_FormInput_Type_In_AddToRFQForm_1"><fmt:message key="ProdDisp_New" bundle="${storeText}"/></label>
            		</td>
          	</tr>
          	<tr> 
            	    	<td id="WC_ProductDisplay_TableCell_4" colspan="2">
            	    		<input id="WC_ProductDisplay_FormInput_Type_In_AddToRFQForm_2" type="radio" class="radio" name="Type" value="EXISTING">
            			<label for="WC_ProductDisplay_FormInput_Type_In_AddToRFQForm_2"><fmt:message key="ProdDisp_Existing" bundle="${storeText}"/></label>
            		</td>
          	</tr>
          	<tr>
          		<td id="WC_CachedProductDisplay_TableCell_6_4">
               			<a class="button" href="#" onclick="Add2RFQ(document.AddToRFQ);" id="WC_ProductDisplay_Link_1">
               				<fmt:message key="ProdDisp_AddToRFQ" bundle="${storeText}"/>
               			</a> 
               		</td>
                </tr>
                </form>
	</table>
        </flow:ifEnabled>
	</c:if>
	<!-- RFQ Product section ends -->
	
	<%-- 
	***
	*	START: Display Merchandising Associations 
	***
	--%>	
	<%--
  	***
  	* Import the MerchandisingAssociationsDisplay.jsp file. This file displays any
  	* cross-sells, up-sells, accessories or replacements for this product.    
  	***
	--%>
	<table cellpadding="8" id="WC_CachedProductDisplay_Table_8">
	<tr>					
		<td valign="top" class="categoryspace" id="WC_CachedItemDisplay_TableCell_8_1" colspan="2">
	
		<% out.flush(); %>   
		<c:import url="../../../Snippets/Catalog/MerchandisingAssociations/MerchandisingAssociationsDisplay.jsp" >	
			<c:param name="catalogEntryType" value="ProductBean"/>
		</c:import>
		<% out.flush(); %>
		</td>
	</tr>	
	</table>
	<%-- 
	***
	*	END: Display Merchandising Associations 
	***
	--%>


<!--END MAIN CONTENT-->
<%@ include file="../../../include/LayoutContainerBottom.jspf"%>
</body>
<!-- END ProductDisplay.jsp -->
</html>
