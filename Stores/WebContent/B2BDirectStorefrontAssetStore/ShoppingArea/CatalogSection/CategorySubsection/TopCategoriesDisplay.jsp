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
  * This JSP imports CachedTopCategoriesDisplay.jsp
  *****
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf"%>

<wcbase:useBean id="catalog" classname="com.ibm.commerce.catalog.beans.CatalogDataBean" scope="page" />

<c:set var="storeCatalogKeyword" value="${storeName}, "/>
<c:forEach var="topCategory" items="${catalog.topCategories}" varStatus="counter">
	<c:set var="storeCatalogKeyword" value="${storeCatalogKeyword}, ${topCategory.description.name}" />
</c:forEach>
<c:set var="storeCatalogKeyword" value="${storeCatalogKeyword}, ${catalog.description.longDescription}" />

<c:set property="contentType" target="${pageContext.response}">
	<fmt:message key="ENCODESTATEMENT" bundle="${storeText}" />
</c:set>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<!-- BEGIN TopCategoriesDisplay.jsp -->
<head>
<title><c:out value="${storeName}"/> - <fmt:message key="MainCat_TopTitle" bundle="${storeText}"/></title>
<meta name="description" content="<c:out value="${catalog.description.longDescription}"/>">
<meta name="keyword" content="<c:out value="${storeCatalogKeyword}"/>">
<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${vfileStylesheet}"/>" type="text/css"/>
</head>
<body class="noMargin">
<flow:ifEnabled feature="customerCare"> 
<%
// Set header type needed for this JSP for LiveHelp.  This must
// be set before HeaderDisplay.jsp
request.setAttribute("liveHelpPageType", "personal");
%>
</flow:ifEnabled> 
<%@ include file="../../../include/LayoutContainerTop.jspf"%>

<!--START MAIN CONTENT-->

		<table cellpadding="0" cellspacing="0" width="100%" border="0" id="WC_TopCategoriesDisplay_Table_1">
			<tbody>
				<tr>
					<td width="100%" valign="top" id="WC_TopCategoriesDisplay_TableCell_15">
						<fmt:message key="Home_Text1" bundle="${storeDynamicText}"/>
						<!-- DEPARTMENT CONTENTS START HERE -->
					<%-- Flush the buffer so this fragment JSP is not cached twice --%>
					<%out.flush();%>
			    		<c:import url="../../../Snippets/Catalog/CategoryDisplay/CachedTopCategoriesDisplay.jsp">
                        			<c:param name="storeId" value="${WCParam.storeId}"/>
                        			<c:param name="catalogId" value="${WCParam.catalogId}"/>
                        			<c:param name="langId" value="${langId}"/>
                        			<c:param name="showLanguageCurrency" value="false"/>
                        			<c:param name="showContractDisplayCustomization" value="true"/>
                        		</c:import>
					<%out.flush();%>
						<!-- DEPARTMENT CONTENTS ENDS HERE -->
					</td>
				</tr>
			</tbody>
		</table>

<!--END MAIN CONTENT-->

<%@ include file="../../../include/LayoutContainerBottom.jspf"%>
</body>
<!-- END TopCategoriesDisplay.jsp -->
</html>
