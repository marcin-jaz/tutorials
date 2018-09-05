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
  * This JSP imports CachedItemDisplay.jsp
  *****
--%>
<% // All JSPs requires these packages for getResource.jsp which is used for multi language support %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf"%>

<wcbase:useBean id="item" classname="com.ibm.commerce.catalog.beans.ItemDataBean" scope="request" />

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "DTD/xhtml1-transitional.dtd">
<html>
<!-- BEGIN ItemDisplay.jsp -->
<head>
<title><fmt:message key="ItemDisp_Title2" bundle="${storeText}"/></title>
<meta name="description" content="<c:out value="${item.description.longDescription}"/>">
<meta name="keyword" content="<c:out value="${item.description.keyWord}"/>">
<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${vfileStylesheet}"/>" type="text/css"/>
</head>
<body class="noMargin">
<flow:ifEnabled feature="customerCare"> 
<%
	// Set header type needed for this JSP for LiveHelp.  
	// This must be set before HeaderDisplay.jsp
	request.setAttribute("liveHelpPageType", "personal");
%>
</flow:ifEnabled> 
<%@ include file="../../../include/LayoutContainerTop.jspf"%>
<!--START MAIN CONTENT-->

	<%-- Flush the buffer so this fragment JSP is not cached twice --%>
	<%out.flush();%>
	<c:import url="../../../Snippets/Catalog/CatalogEntryDisplay/CachedItemDisplay.jsp">
	    <c:param name="storeId" value="${WCParam.storeId}"/>
	    <c:param name="catalogId" value="${WCParam.catalogId}"/>
	    <c:param name="langId" value="${langId}"/>
	    <c:param name="productId" value="${productId}"/>
	    <c:param name="parent_category_rn" value="${WCParam.parent_category_rn}"/>
	    <c:param name="shouldCachePage" value="${WCParam.shouldCachePage}"/>
	    <c:param name="summaryOnly" value="${WCParam.summaryOnly}"/>
	    <c:param name="displayContractPrices" value="true"/>
	</c:import>
	<%out.flush();%>

	<flow:ifEnabled feature="RequisitionList">
	<table id="WC_ItemDisplay_Table_1">
		<tr>
			<td id="WC_ItemDisplay_TableCell_1" colspan="2">
				<span class="subHeading"><fmt:message key="ItemDisp_Label_ReqList" bundle="${storeText}"/></span>
			</td>
		</tr>
		<tr>
			<td id="WC_ItemDisplay_TableCell_2" colspan="2">
				<fmt:message key="ItemDisp_Message2" bundle="${storeText}"/>
			</td>
		</tr>
		<form name="RequisitionListSelectForm" action="" method="post" id="RequisitionListSelectForm">
			<input type="hidden" name="partNumber" value="<c:out value="${item.partNumber}"/>" id="WC_CachedItemDisplay_FormInput_partNumber_In_RequisitionListSelectForm_1">
			<input type="hidden" name="quantity" value="" id="WC_CachedItemDisplay_FormInput_quantity_In_RequisitionListSelectForm_1">
			<input type="hidden" name="storeId" value="<c:out value="${storeId}" />" id="WC_CachedItemDisplay_FormInput_storeId_In_RequisitionListSelectForm_1">
			<input type="hidden" name="catalogId" value="<c:out value="${catalogId}" />" id="WC_CachedItemDisplay_FormInput_catalogId_In_RequisitionListSelectForm_1">
			<input type="hidden" name="langId" value="<c:out value="${langId }" />" id="WC_CachedItemDisplay_FormInput_langId_In_RequisitionListSelectForm_1">
		<tr>
			<td id="WC_ItemDisplay_TableCell_3" colspan="2">
				<input type="radio" class="radio" name="Type" value="NEW" checked="checked" id="WC_ItemDisplay_FormInput_Type_In_RequisitionListSelectForm_1">
				<label for="WC_ItemDisplay_FormInput_Type_In_RequisitionListSelectForm_1"><fmt:message key="ItemDisp_Radio1" bundle="${storeText}"/></label>
			</td>
		</tr>
		<tr>
			<td id="WC_ItemDisplay_TableCell_4" colspan="2">
				<input type="radio" class="radio" name="Type" value="EXISTING" id="WC_ItemDisplay_FormInput_Type_In_RequisitionListSelectForm_2">
				<label for="WC_ItemDisplay_FormInput_Type_In_RequisitionListSelectForm_2"><fmt:message key="ItemDisp_Radio2" bundle="${storeText}"/></label>
			</td>
		</tr>
		<tr>
			<td id="WC_ItemDisplay_TableCell_5" colspan="2">
				<a class="button" href="#" onclick="Add2ReqList(document.RequisitionListSelectForm); return false;" id="WC_ItemDisplay_Link_1">
					<fmt:message key="ItemDisp_AddItemReq" bundle="${storeText}"/>
				</a>
			</td>
		</tr>
		</form>
	</table>
      </flow:ifEnabled>

      <!-- Code for Add to RFQ begins -->
      <flow:ifEnabled feature="RFQ"> 
	<c:if test="${!empty rfqLinkDisplayed && rfqLinkDisplayed=='true'}">
	<table id="WC_ItemDisplay_Table_2">
		<tr>
			<td id="WC_ItemDisplay_TableCell_6" colspan="2">
				<span class="subHeading"><fmt:message key="Sidebar_RFQ" bundle="${storeText}"/></span>
			</td>
		</tr>
		<tr>
			<td id="WC_ItemDisplay_TableCell_7" colspan="2">
				<fmt:message key="RFQExtra_Desc" bundle="${storeText}"/>
			</td>
		</tr>
		<form name="RFQAddForm" action="" method="post" id="RFQAddForm">
		<input type="hidden" name="storeId" value="<c:out value="${storeId}" />" id="WC_CachedItemDisplay_FormInput_storeId_In_RFQAddForm_1">
		<input type="hidden" name="catalogId" value="<c:out value="${catalogId}" />" id="WC_CachedItemDisplay_FormInput_catalogId_In_RFQAddForm_1">
		<input type="hidden" name="langId" value="<c:out value="${langId }" />" id="WC_CachedItemDisplay_FormInput_langId_In_RFQAddForm_1">
		<input type="hidden" name="catentryid" value="<c:out value="${productId}" />" id="WC_CachedItemDisplay_FormInput_catentryid_In_RFQAddForm_1">
		<tr>
			<td id="WC_ItemDisplay_TableCell_8" colspan="2">
				<input type="radio" class="radio" name="Type" value="NEW" checked="checked" id="WC_ItemDisplay_FormInput_Type_In_RFQAddForm_1">
				<label for="WC_ItemDisplay_FormInput_Type_In_RFQAddForm_1"><fmt:message key="ItemDisp_Radio1" bundle="${storeText}"/></label>
			</td>
		</tr>
		<tr>
			<td id="WC_ItemDisplay_TableCell_9" colspan="2">
				<input type="radio" class="radio" name="Type" value="EXISTING" id="WC_ItemDisplay_FormInput_Type_In_RFQAddForm_2"> 
				<label for="WC_ItemDisplay_FormInput_Type_In_RFQAddForm_2"><fmt:message key="ItemDisp_Radio2" bundle="${storeText}"/></label>
			</td>
		</tr>
		<tr>
			<td id="WC_ItemDisplay_TableCell_10" colspan="2">
				<a class="button" href="#" onclick="Add2RFQ(document.RFQAddForm);" id="WC_ItemDisplay_Link_2"> 
					<fmt:message key="ItemDisp_AddItemRFQ" bundle="${storeText}"/>
				</a>
			</td>
		</tr>
		</form>
	</table>
	</c:if>
	</flow:ifEnabled> 
	<!-- Code for Add to RFQ ends -->
      
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
	<table cellpadding="8" id="WC_ItemDisplay_Table_3">
	<tr>					
		<td valign="top" class="categoryspace" id="WC_ItemDisplay_TableCell_11" colspan="2">
	
		<% out.flush(); %>  
		<c:import url="../../../Snippets/Catalog/MerchandisingAssociations/MerchandisingAssociationsDisplay.jsp" >	
			<c:param name="catalogEntryType" value="ItemBean"/>
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

<!-- END MAIN CONTENT -->
<%@ include file="../../../include/LayoutContainerBottom.jspf"%>
</body>
<!-- END ItemDisplay.jsp -->
</html>
