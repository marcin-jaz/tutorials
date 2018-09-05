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
  * This JSP page displays an input table for category percentage
  * price adjustment.
  *
  * Required parameters:
  * - categoryId
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


<wcbase:useBean id="category" classname="com.ibm.commerce.catalog.beans.CategoryDataBean" scope="page">
</wcbase:useBean>	
<wcbase:useBean id="catalog" classname="com.ibm.commerce.catalog.beans.CatalogDataBean" scope="page">
</wcbase:useBean>
<c:set var="parentCatId" />
<c:forEach items="${catalog.topCategories}" var="topCategory" varStatus="iter">
	<c:forEach items="${topCategory.subCategories}" var="subCategory" >
		<c:if test="${subCategory.categoryId eq param.categoryId}" >
			<c:set var="parentCatId" value="${topCategory.categoryId}" />
		</c:if>
	</c:forEach>
</c:forEach>
<c:set var="wrap" value="${requestScope.wrap}" scope="request" />


 	<table cellpadding="0" cellspacing="0" border="0" id="WC_RFQCreateDisplay_Table_7" >
		<tbody>
			<tr>
				    <td id="WC_RFQCreateDisplay_TableCell_29" class="header" background="<c:out value="${jspStoreImgDir}"/>images/header_back.gif"><fmt:message key="RFQModifyDisplay_RFQPercentagePricing" bundle="${storeText}" /></td>
			</tr>
			<tr>
				    <td id="WC_RFQCreateDisplay_TableCell_30"><img src="<c:out value="${jspStoreImgDir}"/>images/strip.gif" alt="" width="630" height="2" border="0" /></td>
			</tr>
			<tr>
				<td id="WC_RFQCreateDisplay_TableCell_31">
					<br /><fmt:message key="RFQExtra_PercentagePricing" bundle="${storeText}" />
				</td>	
			</tr>					
			</tbody>		
	</table>
	<br />


    <input type="hidden" name="catalogId" value="<c:out value="${catalogId}" />" /> 	
				
	<table width="100%" border="0" cellpadding="2" cellspacing="1" class="bgColor" id="WC_RFQCreateDisplay_Table_8">
	   <tbody> 
		<tr>		
			<th <c:out value="${wrap}" /> id="c1"  valign="center"  class="colHeader" > <fmt:message key="RFQModifyDisplay_PPName" bundle="${storeText}" /></th>
			<th <c:out value="${wrap}" /> id="c2"  valign="center"  class="colHeader" > <fmt:message key="RFQModifyDisplay_PPDescription" bundle="${storeText}" /></th>
			<th <c:out value="${wrap}" /> id="c3"  valign="center"  class="colHeader" > <fmt:message key="RFQModifyDisplay_PPPrice" bundle="${storeText}" /></th>
			<th <c:out value="${wrap}" /> id="c4"  valign="center"  class="colHeader_last" > <fmt:message key="RFQModifyDisplay_PPCatalogUpdatesSync" bundle="${storeText}" /></th>  
		</tr>     	
		<tr>  
			<td id="WC_RFQCreateDisplay_TableCell_32" class="cellBG_1 t_td"><a href="CategoryDisplay?catalogId=<c:out value="${catalogId}" />&storeId=<c:out value="${storeId}" />&categoryId=<c:out value="${param.categoryId}" />&langId=<c:out value="${langId}" />&parent_category_rn=<c:out value="${parentCatId}"/>"><c:out value="${category.description.name}"/></a> 
				<input type="hidden" name="categoryName" value="<c:out value="${category.description.name}"/>" />
				<input type="hidden" name="categoryId" value="<c:out value="${param.categoryId}"/>" />         
			</td>
			<td id="WC_RFQCreateDisplay_TableCell_33" class="cellBG_1 t_td"><c:out value="${category.description.name}"/> 
				<input type="hidden" name="desc" value="<c:out value="${category.description.name}"/>" />
			</td>
			<td align="center" id="WC_RFQCreateDisplay_TableCell_34" class="cellBG_1 t_td">
				<label for="WC_RFQCreateDisplay_CategoryAdjustment_Input_1"></label>                
					<input id="WC_RFQCreateDisplay_CategoryAdjustment_Input_1" size="16" maxlength="20" class="input" type="text" name="categoryPercentagePrice" title='<fmt:message key="RFQModifyDisplay_PPPrice" bundle="${storeText}" />' value="0" />
				
			</td>
			<td id="WC_RFQModifyDisplay_TableCell_34" class="cellBG_1 t_td" align="center">				
				<label for="WC_RFQCreateDisplay_CategoryAdjustment_Select_1"></label>
				<select name="synchronize" class="select" id="WC_RFQCreateDisplay_CategoryAdjustment_Select_1">
					<option value="true" selected="selected"><fmt:message key="RFQModifyDisplay_PPSynchronize_Yes" bundle="${storeText}"/></option>
				      	<option value="false"><fmt:message key="RFQModifyDisplay_PPSynchronize_No" bundle="${storeText}"/></option>
				</select>  			
			
			</td>
		</tr>
	</tbody>		 			
 	</table>	
