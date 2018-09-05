<%--==========================================================================
Licensed Materials - Property of IBM

WebSphere Commerce

(c) Copyright IBM Corp.  2001, 2006
All Rights Reserved

US Government Users Restricted Rights - Use, duplication or
disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
===========================================================================--%>


<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf"%>

<wcbase:useBean id="catalog" classname="com.ibm.commerce.catalog.beans.CatalogDataBean"/>

<fmt:message key="HUD_MiniTopCategoriesDisplay" var="HUDFrameTitle" bundle="${storeText}" />
<c:url var="maximizeURL" value="TopCategoriesDisplay">
	<c:param name="langId" value="${langId}" />
	<c:param name="storeId" value="${storeId}" />
	<c:param name="catalogId" value="${catalogId}" />
</c:url>
<% out.flush(); %>
<c:import url="${jspStoreDir}${StyleDir}HUDContainerTop.jsp" >
	<c:param name="HUDFrameTitle" value="${HUDFrameTitle}" />
	<c:param name="maximizeURL" value="${maximizeURL}" />
</c:import>
<% out.flush(); %>

<table cellpadding="0" cellspacing="0" border="0" width="100%" id="WC_MiniTopCategoriesDisplay_Table_1"><tbody>
	<c:forEach items="${catalog.topCategories}" var="category">
		<tr>
			<td class="portlet_content" id="WC_MiniTopCategoriesDisplay_Tablecell_1">
				<strong><c:out value="${category.description.name}"/></strong>
			</td>
		</tr>
		<c:set value="${category.subCategories}" var="subCategories"/>
		<c:forEach items="${subCategories}" var="scategory">
			<c:url var="categoryDisplayURL" value="CategoryDisplay">
				<c:param name="storeId" value="${storeId}"/>
				<c:param name="catalogId" value="${catalogId}"/>
				<c:param name="categoryId" value="${scategory.categoryId}"/>
				<c:param name="parent_category_rn" value="${category.categoryId}"/>
			</c:url>
        	<tr>
        		<td class="portlet_content" id="WC_MiniTopCategoriesDisplay_Tablecell_2_<c:out value="${scategory.categoryId}" />_<c:out value="${category.categoryId}" />">
        			&nbsp;&nbsp;&nbsp;
              		<a href="<c:out value="${categoryDisplayURL}"/>" id="WC_MiniTopCategoriesDisplay_Link_1_<c:out value="${scategory.categoryId}" />_<c:out value="${category.categoryId}" />" class="logon">
             			<c:out value="${scategory.description.name}" />
             		</a>
             	</td>
			</tr>
        </c:forEach>
	</c:forEach>
</tbody></table>
<% out.flush(); %>
<c:import url="${jspStoreDir}${StyleDir}HUDContainerBottom.jsp" />
<% out.flush(); %>
<!--content end-->
<!-- END MiniTopCategoriesDisplay.jsp -->
