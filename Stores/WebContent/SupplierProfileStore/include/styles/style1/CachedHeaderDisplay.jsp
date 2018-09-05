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
  * This JSP is called from HeaderDisplay.jsp and is cached based on the parameters passed in and defined in the cachespec.xml file.
  * The header includes the following information:
  *  - Common links, such as 'Shopping Cart', 'Contact Us', 'Help', etc  
  *  - Category selection list that displays all categories and subcategories in the store. 
  *  - Top Categories list
  *****
--%>
<!-- Start - JSP File name:  style1/CachedHeaderDisplay.jsp -->

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../JSTLEnvironmentSetup.jspf"%>

<wcbase:useBean id="catalog" classname="com.ibm.commerce.catalog.beans.CatalogDataBean" />

<c:url var="AdvancedSearchViewURL" value="AdvancedSearchView">
	<c:param name="langId" value="${langId}"/>
	<c:param name="storeId" value="${storeId}"/>
	<c:param name="catalogId" value="${catalogId}"/>
</c:url>
<c:url var="QuickOrderViewURL" value="QuickOrderView">
	<c:param name="langId" value="${langId}"/>
	<c:param name="storeId" value="${storeId}"/>
	<c:param name="catalogId" value="${catalogId}"/>
</c:url>
<c:url var="TopCategoriesDisplayURL" value="TopCategoriesDisplay">
	<c:param name="langId" value="${langId}" />
	<c:param name="storeId" value="${storeId}" />
	<c:param name="catalogId" value="${catalogId}" />
</c:url>
<c:url var="AccountViewURL" value="UserAccountView">
	<c:param name="langId" value="${langId}" />
	<c:param name="storeId" value="${storeId}" />
	<c:param name="catalogId" value="${catalogId}" />
</c:url>
<c:url var="OrderItemDisplayURL" value="OrderItemDisplayView">
	<c:param name="langId" value="${langId}" />
	<c:param name="storeId" value="${storeId}" />
	<c:param name="catalogId" value="${catalogId}" />
	<c:param name="orderId" value="." />
</c:url>

<!--START HEADER-->

<IE:clientCaps ID="oClientCaps" STYLE="behavior:url('#default#clientCaps')"></IE:clientCaps>
<table cellpadding="0" cellspacing="0" border="0" width="100%" id="WC_CachedHeaderDisplay_Table_1">
	<tr>
	   <td id="WC_CachedHeaderDisplay_TableCell_1" align="center" class="m_back">
           <table cellpadding="0" cellspacing="0" border="0" id="WC_CachedHeaderDisplay_Table_2" width="100%">
                  <tr><td id="WC_CachedHeaderDisplay_TableCell_2">
	          <%-- 
	            ***
	            *  Start: Custom Banner and Logo
	            ***
	          --%>                      
                  <%-- Height and store name removal is to adapt new style --%>
                  <flow:ifEnabled feature="CustomLogo">
                   	<a href="<c:out value="${TopCategoriesDisplayURL}"/>" id="WC_CachedHeaderDisplay_Link_1"><img src="<c:out value="${storeImgDir}${vfileLogo}" />" alt="<c:out value="${storeName}" />" border="0"/></a>
                  </flow:ifEnabled>
                  <flow:ifDisabled feature="CustomLogo">
                        <a href="<c:out value="${TopCategoriesDisplayURL}"/>" id="WC_CachedHeaderDisplay_Link_1"><img src="<c:out value="${jspStoreImgDir}${vfileLogo}" />" alt="<c:out value="${storeName}" />" border="0"/></a>
                  </flow:ifDisabled>
	          <%-- 
	            ***
	            *  End: Custom Banner and Logo
	            ***
	          --%>
	          </td>                                               
		  <td id="WC_CachedHeaderDisplay_TableCell_3" align="right">
			<table cellpadding="0" cellspacing="0" border="0" id="WC_CachedHeaderDisplay_Table_3">
			<tr>
							<td class="m_top" id="WC_CachedHeaderDisplay_TableCell_6a">                                          
			        	<a href="<c:out value="${TopCategoriesDisplayURL}"/>" class="m_top_link" id="WC_CachedHeaderDisplay_Link_2a"><fmt:message key="Header1_Home" bundle="${storeText}" /></a>
			        </td>
							<td class="m_line" id="WC_CachedHeaderDisplay_TableCell_7"><img src="<c:out value="${jspStoreImgDir}${vfileColor}m_line.gif"/>" alt="" width="19" height="31" border="0"></td>
			        <td class="m_top" id="WC_CachedHeaderDisplay_TableCell_6">                                          
			        	<a href="<c:out value="${OrderItemDisplayURL}"/>" class="m_top_link" id="WC_CachedHeaderDisplay_Link_2"><fmt:message key="Header1_CurrentOrder" bundle="${storeText}" /></a>
			        </td>
							<td class="m_line" id="WC_CachedHeaderDisplay_TableCell_7"><img src="<c:out value="${jspStoreImgDir}${vfileColor}m_line.gif"/>" alt="" width="19" height="31" border="0"></td>
			        <c:if test="${userType != 'G'}">
				        <td class="m_top" id="WC_CachedHeaderDisplay_TableCell_8">
			                	<a href="<c:out value="${AccountViewURL}"/>" class="m_top_link" id="WC_CachedHeaderDisplay_Link_3"><fmt:message key="Header1_Account" bundle="${storeText}" /></a>
				        </td>
  						<td class="m_line" id="WC_CachedHeaderDisplay_TableCell_9"><img src="<c:out value="${jspStoreImgDir}${vfileColor}" />m_line.gif" alt="" width="19" height="31" border="0"></td>
			        </c:if>
					<flow:ifEnabled feature="catalogSearch"> 
						<td class="m_top" id="WC_CachedHeaderDisplay_TableCell_4">                                          
							<a href="<c:out value="${AdvancedSearchViewURL}"/>" class="m_top_link" id="WC_CachedHeaderDisplay_Link_1"><fmt:message key="Header1_AdvSearch" bundle="${storeText}" /></a>
						</td>
						<td class="m_line" id="WC_CachedHeaderDisplay_TableCell_5"><img src="<c:out value="${jspStoreImgDir}${vfileColor}m_line.gif"/>" alt="" width="19" height="31" border="0"></td>
					</flow:ifEnabled>
					<flow:ifEnabled feature="QuickOrder">
						<td class="m_top" id="WC_CachedHeaderDisplay_TableCell_4">
							<a href="<c:out value="${QuickOrderViewURL}"/>" class="m_top_link" id="WC_CachedHeaderDisplay_Link_1"><fmt:message key="Header1_QuickOrder" bundle="${storeText}" /></a>
						</td>
				        <td class="m_line" id="WC_CachedHeaderDisplay_TableCell_5"><img src="<c:out value="${jspStoreImgDir}${vfileColor}m_line.gif"/>" alt="" width="19" height="31" border="0"></td>
					</flow:ifEnabled>
			        <td class="m_top" id="WC_CachedHeaderDisplay_TableCell_10">
			        <c:choose>
			        	<c:when test="${userType == 'G'}">      
			        		<c:url var="LogonFormURL" value="LogonForm">
							<c:param name="langId" value="${langId}" />
							<c:param name="storeId" value="${WCParam.storeId}" />
							<c:param name="catalogId" value="${WCParam.catalogId}" />
						</c:url>                      
				        	<a href="<c:out value="${LogonFormURL}"/>" class="m_top_link" id="WC_CachedHeaderDisplay_Link_5"><fmt:message key="Header1_Logon" bundle="${storeText}" /></a>
				        </c:when>
					<c:otherwise>
				        	<c:url var="LogoffURL" value="Logoff">
				                	<c:param name="storeId" value="${WCParam.storeId}" />
				                	<c:param name="catalogId" value="${WCParam.catalogId}" />
				                	<c:param name="URL" value="LogonForm" />
				                </c:url>                                          
				                <a href="<c:out value="${LogoffURL}"/>" class="m_top_link" id="WC_CachedHeaderDisplay_Link_4"><fmt:message key="Header1_Logoff" bundle="${storeText}" /></a>
				        </c:otherwise>
			        </c:choose>
			        </td>
			</tr>
			</table>
		</td>
                </tr>
	        </table>
	</td>
	</tr>
        <tr>
        <td class="m_tile" align="center" id="WC_CachedHeaderDisplay_TableCell_11">
		<table cellpadding="0" cellspacing="0" border="0" width="100%" id="WC_CachedHeaderDisplay_Table_4">
		<tr>
			<td id="WC_CachedHeaderDisplay_TableCell_12">
                        <%-- 
                          ***
                          *  Start: Display the Top Categories
                          *  The top categories link will be displayed.  Each top category will be a link to the corresponding category page, except that the currently selected category is not a link.
                          ***
                        --%>
                        <table cellpadding="0" cellspacing="0" border="0" id="WC_CachedHeaderDisplay_Table_5">
                        <tr>
                        <c:forEach var="topCategory" items="${catalog.topCategories}" varStatus="status">
                                
	                        <%-- For the currently selected category, the category name will not be a link to the corresponding category page. --%>
	                        <c:choose>
	                        	<c:when test="${topCategory.categoryId == categoryId}">
	                        		<td valign="top" id="WC_CachedHeaderDisplay_TableCell_15_<c:out value="${status.count}" />"><img src="<c:out value="${jspStoreImgDir}${vfileColor}"/>m_but_line.gif" alt="" width="1" height="22" border="0"></td>
	                        		<td valign="top" class="m_link" id="WC_CachedHeaderDisplay_TableCell_13_<c:out value="${status.count}" />">
	                                	<c:out value="${topCategory.description.name}" escapeXml="false"/>
	                                	</td>
	                                </c:when>
	                                <c:otherwise>
	                                	<td valign="top" id="WC_CachedHeaderDisplay_TableCell_15_<c:out value="${status.count}" />"><img src="<c:out value="${jspStoreImgDir}${vfileColor}"/>m_but_line.gif" alt="" width="1" height="22" border="0"></td>
	                                	<c:url var="CategoryDisplayURL" value="CategoryDisplay">
	                                        	<c:param name="langId" value="${langId}" /><c:param name="storeId" value="${WCParam.storeId}" /><c:param name="catalogId" value="${WCParam.catalogId}" /><c:param name="top" value="Y" /><c:param name="categoryId" value="${topCategory.categoryId}" />
	                                        </c:url>
	                                        <td id="WC_CachedHeaderDisplay_TableCell_14_<c:out value="${status.count}" />">
	                                        <a href="<c:out value="${CategoryDisplayURL}" />" class="m_link" id="WC_CachedHeaderDisplay_Link_6_<c:out value="${status.count}" />"><c:out value="${topCategory.description.name}" escapeXml="false"/></a>
	                                	</td>
	                                </c:otherwise>
	                                </c:choose>
			</c:forEach>
			<td valign="top" id="WC_CachedHeaderDisplay_TableCell_16a"><img src="<c:out value="${jspStoreImgDir}${vfileColor}"/>m_but_line.gif" alt="" width="1" height="22" border="0"></td>
                        </tr>
                        </table>
			</td>
                </tr>
		</table>
        </td>
        </tr>
	<tr>
		<td class="s_back" align="center" id="WC_CachedHeaderDisplay_TableCell_16">
			<table cellpadding="0" cellspacing="0" border="0" width="100%" id="WC_CachedHeaderDisplay_Table_6">
                                 <%-- 
                                   ***
                                   *  Start: Search
                                   *  The top categories and the 'Home' link will be displayed.  Each top category will be a link to the corresponding category page, except that the currently selected category is not a link.
                                   ***
                                 --%>
				<tr>
				      <flow:ifEnabled  feature="catalogSearch"> 
				       <td id="WC_CachedHeaderDisplay_TableCell_17">
				       <table cellpadding="0" cellspacing="0" border="0" id="WC_CachedHeaderDisplay_Table_7">
				              <tr>
				                     <td valign="middle" id="WC_CachedHeaderDisplay_TableCell_18">
				                     <form name="CatalogSearchForm" action="CatalogSearchResultView" method="post" id="CatalogSearchForm">
				                     <input type="hidden" name="storeId" value="<c:out value="${storeId}" />" id="WC_CachedHeaderDisplay_FormInput_storeId_In_CatalogSearchForm_1"/>
						     <input type="hidden" name="langId" value="<c:out value="${langId}" />" id="WC_CachedHeaderDisplay_FormInput_langId_In_CatalogSearchForm_1"/>
						     <input type="hidden" name="catalogId" value="<c:out value="${catalogId}" />" id="WC_CachedHeaderDisplay_FormInput_catalogId_In_CatalogSearchForm_1"/>
						     <input type="hidden" name="pageSize" value="10" id="WC_CachedHeaderDisplay_FormInput_pageSize_In_CatalogSearchForm_1"/>
						     <input type="hidden" name="beginIndex" value="0" id="WC_CachedHeaderDisplay_FormInput_beginIndex_In_CatalogSearchForm_1"/>
						     <input type="hidden" name="sType" value="SimpleSearch" id="WC_CachedHeaderDisplay_FormInput_sType_In_CatalogSearchForm_1"/>
						     <input type="hidden" name="searchTermScope" value="3" id="WC_CachedHeaderDisplay_FormInput_searchTermScope_In_CatalogSearchForm_1"/>
						     
						     	<label for="WC_CachedHeaderDisplay_FormInput_searchTerm_In_CatalogSearchForm_1_2"></label>
						     	<input class="input" id="WC_CachedHeaderDisplay_FormInput_searchTerm_In_CatalogSearchForm_1_2" type="text" size="20" maxlength="254" id="search" class="srch" name="searchTerm" />
						     </td>
				                     <td class="s_padding" id="WC_CachedHeaderDisplay_TableCell_19">
				                        <a href="javascript:document.CatalogSearchForm.submit()" id="WC_CachedHeaderDisplay_Link_7" class="button"><fmt:message key="Sidebar_CatalogSearch" bundle="${storeText}" /></a>
				                     </td>
				                     </form>
				              </tr>
				       </table>
				       </td>
				  </flow:ifEnabled> 
				</tr>
			</table>
		</td>
	</tr>
</table>
<!--END HEADER-->
<!-- End - JSP File name:  style1/CachedHeaderDisplay.jsp -->

<flow:ifEnabled feature="customerCare">
	<jsp:include page="../../CustomerCareHeaderSetup.jsp" flush="true" />
</flow:ifEnabled>
