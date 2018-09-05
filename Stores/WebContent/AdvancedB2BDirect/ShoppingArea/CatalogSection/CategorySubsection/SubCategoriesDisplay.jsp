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
  * This JSP imports CachedSubCategoriesDisplay.jsp
  *****
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf"%>

<wcbase:useBean id="category" classname="com.ibm.commerce.catalog.beans.CategoryDataBean" scope="page" />

<%-- If the current category is a sub category, then the following setup is needed --%>
<c:if test="${empty WCParam.top}">
	<%-- Set the parentCategoryId if it is not set yet --%>
	<c:choose>
		<c:when test="${empty WCParam.parent_category_rn}">
			<c:if test="${!empty category.parentCategories}">
				<c:set var="parentCategoryId" value="${category.parentCategories[0].categoryId}" />
			</c:if>
		</c:when>
		<c:otherwise>
			<c:set var="parentCategoryId" value="${WCParam.parent_category_rn}" />
		</c:otherwise>
	</c:choose>
</c:if>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<!-- BEGIN SubCategoriesDisplay.jsp -->
<head>
<title><c:out value="${storeName}"/> - <c:out value="${category.description.name}"/> - <fmt:message key="SubCategoriesDisp_Title" bundle="${storeText}"/></title>
<meta name="description" content="<c:out value="${category.description.longDescription}"/>">
<meta name="keyword" content="<c:out value="${category.description.keyWord}"/>">
<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${vfileStylesheet}"/>" type="text/css"/>
</head>
<body class="noMargin">
<%@ include file="../../../include/LayoutContainerTop.jspf"%>
<!--START MAIN CONTENT-->

		<%-- The c:import is nested in the c:choose because the other way around is not alloed by the standard. Therefore, we have to
		     live with some duplications here.
		--%>
		<%-- Determine which URl command to use for the CachedCategoriesDisplay import. For sub-categories, two more parameters
		     are needed than top-level categories
		--%>
		<%-- Flush the buffer so this fragment JSP is not cached twice --%>
		<c:choose>
			<c:when test="${empty top}">
				<%out.flush();%>
				<c:import url="../../../Snippets/Catalog/CategoryDisplay/CachedCategoriesDisplay.jsp">
					<c:param name="storeId" value="${WCParam.storeId}"/>
					<c:param name="catalogId" value="${WCParam.catalogId}"/>
					<c:param name="langId" value="${langId}"/>
					<c:param name="categoryId" value="${categoryId}"/>
					<%-- The follow two parms are for the sub category only --%>
					<c:param name="parent_category_rn" value="${parentCategoryId}"/>
					<c:param name="top_category" value="${WCParam.top_category}"/>
				</c:import>
				<%out.flush();%>
		    </c:when>

		    <c:otherwise>
		    	<%out.flush();%>
		    	<c:import url="../../../Snippets/Catalog/CategoryDisplay/CachedCategoriesDisplay.jsp">
		            <c:param name="storeId" value="${WCParam.storeId}"/>
		            <c:param name="catalogId" value="${WCParam.catalogId}"/>
		            <c:param name="langId" value="${langId}"/>
		            <c:param name="categoryId" value="${categoryId}"/>
		        </c:import>
		        <%out.flush();%>
		    </c:otherwise>
		</c:choose>

<!-- RFQ Category Price Adjustment section -->
<c:choose>
	<c:when test="${empty top}">
		<c:if test="${!empty rfqLinkDisplayed && rfqLinkDisplayed=='true'}">
		<flow:ifEnabled feature="RFQ">
		<table id="WC_SubCategoriesDisplay_Table_1">
			<tr>
				<td id="WC_SubCategoriesDisplay_TableCell_1" colspan="2">
					<span class="subHeading"><fmt:message key="SubCategoriesDisp_RFQRequestQuote" bundle="${storeText}"/></span>
				</td>
			</tr>
		        <tr>                   
		               	<td id="WC_SubCategoriesDisplay_TableCell_2" colspan="2">
		               		<fmt:message key="SubCategoriesDisp_NewRFQ" bundle="${storeText}"/>
		               	</td>
		        </tr>
		        <form name="AddToRFQ" action="" method="post" id="AddToRFQForm">              
		        <tr> 
		           	<td id="WC_SubCategoriesDisplay_TableCell_3" colspan="2">
		           		<input id="WC_SubCategoriesDisplay_FormInput_Type_In_AddToRFQForm_1" type="radio" class="radio" name="Type" value="NEW" checked="checked">
		           		<label for="WC_SubCategoriesDisplay_FormInput_Type_In_AddToRFQForm_1"><fmt:message key="SubCategoriesDisp_New" bundle="${storeText}"/></label>
				</td>
		        </tr>
		        <tr> 
		            	<td id="WC_SubCategoriesDisplay_TableCell_4" colspan="2">
		            		<input id="WC_SubCategoriesDisplay_FormInput_Type_In_AddToRFQForm_2" type="radio" class="radio" name="Type" value="EXISTING">
		            		<label for="WC_SubCategoriesDisplay_FormInput_Type_In_AddToRFQForm_2"><fmt:message key="SubCategoriesDisp_Existing" bundle="${storeText}"/></label>
				</td>
		        </tr>
		        <tr>
		          	<td id="WC_SubCategoriesDisplay_TableCell_5" colspan="2">
		               		<a class="button" href="#" onclick="Add2RFQ(document.AddToRFQ);" id="WC_SubCategoriesDisplay_Link_1">
		               			<fmt:message key="SubCategoriesDisp_AddToRFQ" bundle="${storeText}"/>
		               		</a>
		              	</td>
		        </tr>
		</table>
		</form>
		</flow:ifEnabled>
		</c:if>
		<!-- End RFQ Category Price Adjustment Section -->
		
		<script language="javascript">
			function Add2RFQ(form) {
				if (form.Type[0].checked) {
					form.action="RFQCreateDisplay?categoryId=<c:out value="${categoryId}" />&langId=<c:out value="${langId}" />&storeId=<c:out value="${storeId}" />&catalogId=<c:out value="${catalogId}" />&endresult=0";
				} else 	{
					form.action="AddToExistRFQListDisplay?categoryId=<c:out value="${categoryId}" />&langId=<c:out value="${langId}" />&storeId=<c:out value="${storeId}" />&catalogId=<c:out value="${catalogId}" />&isContract=Y";
				}
				form.submit();		
			}
		</script>
	</c:when>
</c:choose>

<!--END MAIN CONTENT-->
<%@ include file="../../../include/LayoutContainerBottom.jspf"%>
</body>
<!-- END SubCategoriesDisplay.jsp -->
</html>
