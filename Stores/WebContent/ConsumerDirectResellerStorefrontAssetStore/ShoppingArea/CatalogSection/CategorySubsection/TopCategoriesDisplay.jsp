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
  * This JSP page displays the store's top-level categories. It is used as the starter store's homepage. 
  * It imports three JSP pages:
  *  - CachedHeaderDisplay.jsp, which displays the header of the page
  *  - CachedTopCategoriesDisplay.jsp, which displays the top-level categories
  *  - CachedFooter.jsp, which displays the footer of the page
  *****
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf"%>

<wcbase:useBean id="catalog" classname="com.ibm.commerce.catalog.beans.CatalogDataBean" scope="page" />

<c:set var="storeCatalogKeyword" value="${storeName}, "/>
<c:forEach var="topCategory" items="${catalog.topCategories}" varStatus="counter">
	<c:set var="storeCatalogKeyword" value="${storeCatalogKeyword}, ${topCategory.description.name}" />
</c:forEach>
<c:set var="storeCatalogKeyword" value="${storeCatalogKeyword}, ${catalog.description.longDescription}" />

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>
	<fmt:message key="INDEX_TITLE" bundle="${storeText}">
		<fmt:param value="${storeName}"/>
	</fmt:message> 
</title>
<meta name="description" content="<c:out value="${catalog.description.longDescription}"/>" />
<meta name="keyword" content="<c:out value="${storeCatalogKeyword}"/>"/>      
<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${vfileStylesheet}"/>" type="text/css"/>
</head>

	<body>
	<!-- JSP File Name:  TopCategoriesDisplay.jsp -->

	<%@ include file="../../../include/LayoutContainerTop.jspf"%>

	<!--MAIN CONTENT STARTS HERE-->
		<table cellpadding="0" cellspacing="0" width="100%" border="0" id="WC_TopCategoriesDisplay_Table_1">
			<tbody>
				<tr>
					<td valign="top" id="WC_TopCategoriesDisplay_TableCell_12">
						<%out.flush();%>
						<c:import url="${jspStoreDir}Snippets/Marketing/Content/ContentSpotDisplay.jsp">
							<c:param name="spotName" value="HomeSpot-Top" />
						</c:import>
						<%out.flush();%>
					</td>
				</tr>
				<tr>
					<td width="100%" valign="top" id="WC_TopCategoriesDisplay_TableCell_15">
					<%-- Flush the buffer so this fragment JSP is not cached twice --%>
					<%out.flush();%>
			    		<c:import url="../../../Snippets/Catalog/CategoryDisplay/CachedTopCategoriesDisplay.jsp">
                        			<c:param name="storeId" value="${WCParam.storeId}"/>
                        			<c:param name="catalogId" value="${WCParam.catalogId}"/>
                        			<c:param name="langId" value="${langId}"/>
                        			<c:param name="showLanguageCurrency" value="true"/>
                        			<c:param name="showContractDisplayCustomization" value="false"/>
                        		</c:import>
					<%out.flush();%>
					</td>
				</tr>
				<tr>
				    <td valign="top" id="WC_TopCategoriesDisplay_TableCell_18">
				    <%out.flush();%>
				    <c:import url="${jspStoreDir}Snippets/Marketing/Content/ContentSpotDisplay.jsp">
						<c:param name="spotName" value="HomeSpot-Bottom" />
					</c:import>
					<%out.flush();%>
				    </td>
				</tr>
			</tbody>
		</table>

	<!-- MAIN CONTENT ENDS HERE -->

	<%-- Hide CIP --%>
	<c:set var="HideCIP" value="true"/>

	<%@ include file="../../../include/LayoutContainerBottom.jspf"%>

	</body>
</html>
