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
  * This JSP imports CachedPackageDisplay.jsp to display package details.
  * It also imports header, sidebar, and footer.
  *****
--%>
<!-- Start - JSP File Name:  PackageDisplay.jsp -->

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title><fmt:message key="PackageDisplay_Package_Title" bundle="${storeText}" /></title>
<meta name="description" content="<c:out value="${packageDataBean.description.longDescription}"/>">
<meta name="keyword" content="<c:out value="${packageDataBean.description.keyWord}"/>">
<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${vfileStylesheet}"/>" type="text/css"/>
</head>
<body class="noMargin">
<%@ include file="../../../include/LayoutContainerTop.jspf"%>
<!--START MAIN CONTENT-->	
	<%-- Flush the buffer so this fragment JSP is not cached twice --%>
	<%out.flush();%>
        <c:import url="../../../Snippets/Catalog/CatalogEntryDisplay/CachedPackageDisplay.jsp">
            <c:param name="storeId" value="${WCParam.storeId}"/>
            <c:param name="catalogId" value="${WCParam.catalogId}"/>
            <c:param name="langId" value="${langId}"/>
            <c:param name="productId" value="${productId}"/>
            <c:param name="rfqLinkDisplayed" value="${rfqLinkDisplayed}" />
            <c:param name="shouldCachePage" value="true"/>
            <c:param name="displayContractPrices" value="true"/>
        </c:import>
	<%out.flush();%>

	<table align="center" cellpadding="2" cellspacing="0" width="786" border="0" id="WC_PackageDisplay_Table_1">
		<tr align="center">
			<td id="WC_PackageDisplay_TableCell_1">
				<table cellpadding="0" cellspacing="0" border="0" width="100%" id="WC_PackageDisplay_Table_2">

				<flow:ifEnabled feature="RequisitionList">
					<tr>
					<td valign="top" class="categoryspace" id="WC_PackageDisplay_TableCell_2" colspan="2" >

			                    <h2><fmt:message key="ItemDisp_Label_ReqList" bundle="${storeText}"/></h2>
			                    <fmt:message key="ItemDisp_Message2" bundle="${storeText}"/><br />
			                    <form name="RequisitionListSelectForm" action="" method="post" id="RequisitionListSelectForm">
			                      	<input type="hidden" name="partNumber" value="<c:out value="${packageDataBean.partNumber}"/>" id="WC_CachedPackageDisplay_FormInput_partNumber_In_RequisitionListSelectForm_1">
			                      	<input type="hidden" name="quantity" value="" id="WC_CachedPackageDisplay_FormInput_quantity_In_RequisitionListSelectForm_1">
			                        <input type="hidden" name="storeId" value="<c:out value="${storeId}" />" id="WC_CachedPackageDisplay_FormInput_storeId_In_RequisitionListSelectForm_1">
			                        <input type="hidden" name="catalogId" value="<c:out value="${catalogId}" />" id="WC_CachedPackageDisplay_FormInput_catalogId_In_RequisitionListSelectForm_1">
			                        <input type="hidden" name="langId" value="<c:out value="${langId }" />" id="WC_CachedPackageDisplay_FormInput_langId_In_RequisitionListSelectForm_1">                                           
			                      <table id="WC_CachedPackageDisplay_Table_7" id="WC_PackageDisplay_Table_3">
			                        <tr>
			                          <td id="WC_PackageDisplay_TableCell_3"><input type="radio" name="Type" value="NEW" checked="checked" id="WC_CachedPackageDisplay_FormInput_Type_In_RequisitionListSelectForm_1">
			                          </td>
			                          <td id="WC_PackageDisplay_TableCell_4"><label for="WC_CachedPackageDisplay_FormInput_Type_In_RequisitionListSelectForm_1"><fmt:message key="ItemDisp_Radio1" bundle="${storeText}"/></label></td>
			                        </tr>
			                        <tr>
			                          <td id="WC_PackageDisplay_TableCell_5"> <input type="radio" name="Type" value="EXISTING" id="WC_CachedPackageDisplay_FormInput_Type_In_RequisitionListSelectForm_2"> </td>
			                          <td id="WC_PackageDisplay_TableCell_6"><label for="WC_CachedPackageDisplay_FormInput_Type_In_RequisitionListSelectForm_2"><fmt:message key="ItemDisp_Radio2" bundle="${storeText}"/></label></td>
			                        </tr>
			                      </table>
			                    </form>
			                    <a class="button" href="#" onclick="PreAdd2ReqList(document.RequisitionListSelectForm); return false;" id="WC_PackageDisplay_Link_1">
			                    <fmt:message key="ItemDisp_AddItemReq" bundle="${storeText}"/> </a>
			                </td>
					</tr>
				</flow:ifEnabled>
   
			     	<%-- 
				 ***
				 *	Start: 'Add to RFQ' button 
				 ***
				 --%>     
			      	<flow:ifEnabled feature="RFQ"> 
			      		<c:if test="${!empty rfqLinkDisplayed && rfqLinkDisplayed=='true'}" >
			  			<tr>
			    				<td id="WC_PackageDisplay_TableCell_7">
			             			<h2><fmt:message key="Sidebar_RFQ" bundle="${storeText}"/></h2>
			             			<fmt:message key="RFQExtra_Desc" bundle="${storeText}"/> <br />
			             			
			             			<form name="RFQAddForm" action="" method="post" id="RFQAddForm">
			               			<input type="hidden" name="storeId" value="<c:out value="${storeId}" />" id="WC_CachedPackageDisplay_FormInput_storeId_In_RFQAddForm_1">
			               			<input type="hidden" name="catalogId" value="<c:out value="${catalogId}" />" id="WC_CachedPackageDisplay_FormInput_catalogId_In_RFQAddForm_1">
			               			<input type="hidden" name="langId" value="<c:out value="${langId }" />" id="WC_CachedPackageDisplay_FormInput_langId_In_RFQAddForm_1">
			               			<input type="hidden" name="catentryid" value="<c:out value="${packageDataBean.packageID}" />" id="WC_CachedPackageDisplay_FormInput_catentryid_In_RFQAddForm_1">
			               			<table id="WC_CachedPackageDisplay_Table_8" id="WC_PackageDisplay_Table_4">
			                 			<tr>
			                   				<td id="WC_PackageDisplay_TableCell_8"> 
			                   				<input type="radio" name="Type" value="NEW" checked="checked" id="WC_CachedPackageDisplay_FormInput_Type_In_RFQAddForm_1">
			                   				</td>
			                   				<td id="WC_PackageDisplay_TableCell_9"><label for="WC_CachedPackageDisplay_FormInput_Type_In_RFQAddForm_1"><fmt:message key="ItemDisp_Radio1" bundle="${storeText}"/></label></td>
			                 			</tr>
			                 			<tr>
			                   				<td id="WC_PackageDisplay_TableCell_10"> 
			                   				<input type="radio" name="Type" value="EXISTING" id="WC_CachedPackageDisplay_FormInput_Type_In_RFQAddForm_2"> 
			                   				</td>
			                   				<td id="WC_PackageDisplay_TableCell_11"><label for="WC_CachedPackageDisplay_FormInput_Type_In_RFQAddForm_2"><fmt:message key="ItemDisp_Radio2" bundle="${storeText}"/></label></td>
			                 			</tr>
			               			</table>
			               			<br /><a class="button" href="#" onclick="Add2RFQ(document.RFQAddForm);" id="WC_PackageDisplay_Link_2"> 
			              			<fmt:message key="RFQModifyAddProductDisplay_Add" bundle="${storeText}"/> </a>
			             			</form>
							</td>
			     			</tr>
			      		</c:if>
			      	</flow:ifEnabled> 
			     	<%-- 
				 ***
				 *	End: 'Add to RFQ' button 
				 ***
				 --%>

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
				<tr>					
					<td valign="top" class="categoryspace" id="WC_PackageDisplay_TableCell_12" colspan="2">
				
					<% out.flush(); %>  
					<c:import url="../../../Snippets/Catalog/MerchandisingAssociations/MerchandisingAssociationsDisplay.jsp" >	
						<c:param name="catalogEntryType" value="PackageBean"/>
					</c:import>
					<% out.flush(); %>
					</td>
				</tr>	
				<%-- 
				***
				*	END: Display Merchandising Associations  
				***
				--%>
				</table>
			</td>
		</tr>
	</table>

	<script language="javascript">
	function PreAdd2ReqList(form) {
		form.quantity.value = document.OrderItemAddForm.quantity.value;
		
		Add2ReqList(form);
	}
	</script>

<!--END MAIN CONTENT-->
<%@ include file="../../../include/LayoutContainerBottom.jspf"%>
</body>
</html>
<!-- End - JSP File Name:  PackageDisplay.jsp -->
