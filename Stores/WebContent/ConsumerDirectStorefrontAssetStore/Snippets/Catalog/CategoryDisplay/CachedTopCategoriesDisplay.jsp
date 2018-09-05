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
  * This JSP page displays the following for each top category in a store:
  *  - The thumbnail of the category
  *  - The link to the page that displays details for the category (CategoriesDispaly.jsp)
  *  - The category-level discounts will be displayed for each category
  * This is an example of how this file could be included into a page: 
  *<c:import url="../../../Snippets/Catalog/CategoryDisplay/CachedTopCategoriesDisplay.jsp">
  *          <c:param name="storeId" value="${storeId}"/>
  *          <c:param name="catalogId" value="${catalogId}"/>
  *          <c:param name="langId" value="${langId}"/>
  *          <c:param name="showLanguageCurrency" value="true"/>
  *          <c:param name="showContractDisplayCustomization" value="false"/>
  *</c:import>
  *****
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf"%>

<c:if test="${param.showLanguageCurrency eq 'true'}" >
	<c:set var="showLanguageCurrency" value="true"/>
</c:if>
<c:if test="${param.showContractDisplayCustomization eq 'true'}" >
	<c:set var="showContractDisplayCustomization" value="true"/>
</c:if>

<wcbase:useBean id="catalog" classname="com.ibm.commerce.catalog.beans.CatalogDataBean" scope="page" />

<%-- 
***
* Start:  Get all category IDs displayed on this page and pass them to the discount code
***
--%>
	<%-- Create a comma delimited string containing all Category IDs to pass to the discount code
		For an in depth explanation of why this is done, see DiscountJavaScriptSetup.jsp. --%>
	<c:forEach var="topCategory" items="${catalog.topCategories}" varStatus="counter">
		<c:set var="someCategoryIDs" value="${someCategoryIDs},${topCategory.categoryId}" />
	</c:forEach>
	
	<%-- Pass the Category IDs to the discount JavaScript --%>
	<%-- Flush the buffer so this fragment JSP is not cached twice --%>
	<%out.flush();%>
	<c:import url="${jspStoreDir}include/DiscountJavaScriptSetup.jsp">
		<c:param name="jsPrototypeName" value="Discount" />
		<c:param name="someCategoryIDs" value="${someCategoryIDs}"/>
		<c:param name="categoryIncludeChildItems" value="false"/>
		<c:param name="categoryIncludeParentCategory" value="false"/>
	</c:import>
	<%out.flush();%>
<%-- 
***
* End:  Get all category IDs displayed on this page and pass them to the discount code
***
--%>

<!-- Start of the JSP: CachedTopCategoriesDisplay.jsp -->

	<table align="center" cellpadding="0" cellspacing="0" width="786" border="0" id="WC_CachedTopCategoriesDisplay_Table_1">
	<tbody>
		<tr><td id="WC_CachedTopCategoriesDisplay_TableCell_1">
			<c:if test="${showLanguageCurrency}">
				<table cellpadding="0" cellspacing="0" border="0" id="WC_CachedTopCategoriesDisplay_Table_2">
					<tr>
					<flow:ifEnabled  feature="preferredLanguage">
					<td id="WC_CachedTopCategoriesDisplay_TableCell_2">
						<%-- 
					          ***
					          *  Start: Language selection box
					          *  This form allows shopper to switch langauge.
					          *  Only display form if there is more than 1 language
					          ***
					        --%>
					        <c:if test="${!empty sdb.languageDataBeans[1]}">
				                	<form name="LanguageSelectionForm" action="TopCategoriesDisplay" method="post" id="LanguageSelectionForm">
				                        <%-- Get all request parameters and their values --%>
							<%-- Flush the buffer so this fragment JSP is not cached twice --%>
							<%out.flush();%>
								<c:import url="${jspStoreDir}include/WCParamValuesDisplay.jsp">
									<c:param name="count" value="TableCell_2"/>
								</c:import>
							<%out.flush();%>
								<label for="languageSelection">
								<select class="select" id="languageSelection" name="langId" title="langId" onchange="LanguageSelectionForm.submit()">
									<c:forEach var="dbLanguage" items="${sdb.languageDataBeans}">
										<c:choose>
											<%--  If this language is currently selected, pre-select it in the drop down list. --%>
											<c:when test="${dbLanguage.languageId == langId}">
												<option value='<c:out value="${dbLanguage.languageId}" />' selected="selected"><c:out value="${dbLanguage.nativeDescriptionString}" escapeXml="false"/></option>
											</c:when>
											<c:otherwise>
												<option value='<c:out value="${dbLanguage.languageId}" />'><c:out value="${dbLanguage.nativeDescriptionString}" escapeXml="false"/></option>
											</c:otherwise>
										</c:choose>
									</c:forEach>
								</select>
								</label>
							</form>
						</c:if>
						<%-- 
						  ***
						  *  End: Language selection box
						  ***
						--%>
					</td>
					</flow:ifEnabled>
					<flow:ifEnabled  feature="preferredCurrency">
					<td id="WC_CachedTopCategoriesDisplay_TableCell_3">&nbsp;</td><td id="WC_CachedTopCategoriesDisplay_TableCell_4">
					       	<%-- 
					          ***
					          *  Start: Currency selection box
					          *  This form allows shopper to switch currency.
					          *  Only display form if there is more than 1 currency
					          ***
					        --%>
						<c:if test="${!empty sdb.storeCurrencies[1]}">
							<form name="SetCurrencyPreferenceForm" action="SetCurrencyPreference" method="post" id="SetCurrencyPreferenceForm">
							<%-- Get all request parameters and their values --%>
							<%-- Flush the buffer so this fragment JSP is not cached twice --%>
							<%out.flush();%>
								<c:import url="${jspStoreDir}include/WCParamValuesDisplay.jsp">
									<c:param name="count" value="TableCell_3"/>
								</c:import>
							<%out.flush();%>
	                                        <label for="currencySelection">
							<select class="select" id="currencySelection" name="currency" title="currency" onchange="form.submit()">
								<c:forEach var="dbCurrency" items="${sdb.storeCurrencies}">
									<c:choose>
										<c:when test="${dbCurrency.currencyCode == CommandContext.currency}">
											<option value='<c:out value="${dbCurrency.currencyCode}" escapeXml="false"/>' selected="selected"><c:out value="${dbCurrency.currencyDescription}" escapeXml="false"/></option>
										</c:when>
										<c:otherwise>
											<option value='<c:out value="${dbCurrency.currencyCode}" escapeXml="false"/>'><c:out value="${dbCurrency.currencyDescription}"  escapeXml="false"/></option>
										</c:otherwise>
									</c:choose>
								</c:forEach>
							</select>
	                                        </label>
							</form>
						</c:if>
					        <%-- 
					          ***
					          *  End: Currency selection box
					          ***
					        --%>
		        		</td>
						</flow:ifEnabled>
						</tr>
		        	</table>
		        </c:if>
		        
		        <c:if test="${showContractDisplayCustomization}">
				<table cellpadding="0" cellspacing="0" border="0" id="WC_CachedTopCategoriesDisplay_Table_3">
		          		<wcbase:useBean id="contract_DisplayTCBean" classname="com.ibm.commerce.tools.contract.beans.DisplayCustomizationTCDataBean">
						<c:set target="${contract_DisplayTCBean}" property="commandContext" value="${CommandContext}" />
						<c:set target="${contract_DisplayTCBean}" property="languageId" value="${langId}" />
						<c:set target="${contract_DisplayTCBean}" property="userId" value="${CommandContext.userId}" />
						<c:set target="${contract_DisplayTCBean}" property="storeId" value="${WCParam.storeId}" />
					</wcbase:useBean>
					<c:choose>
						<c:when test="${userType eq 'G'}">
							<c:set var="orgName" value=""/>
						</c:when>
						<c:otherwise>
							<wcbase:useBean id="parentOrg" classname="com.ibm.commerce.user.beans.OrgEntityDataBean">
								<c:set target="${parentOrg}" property="orgEntityId" value="${CommandContext.activeOrganizationId}"/>
							</wcbase:useBean>
							<c:set var="orgName" value="${parentOrg.displayName}"/>
						</c:otherwise>
					</c:choose>

					<c:set var="customAccountLogo" value="${contract_DisplayTCBean.attachmentURL[1]}"/>
					<c:if test="${!empty customAccountLogo}">
						<tr>
							<td id="WC_CachedTopCategoriesDisplay_TableCell_1_1">
								<c:set var="firstToken" value="true"/>
								<c:forTokens items="${customAccountLogo}" delims=":" var="token">
									<c:if test="${firstToken==true}">
										<c:set var="firstToken" value="false"/>
										<c:set var="customAccountPath" value="${token}" />
									</c:if>
								</c:forTokens>
								<c:choose>
									<c:when test="${(customAccountPath eq 'http') or (customAccountPath eq 'https')}">
										<img alt="<c:out value="${orgName}"/>" src='<c:out value="${contract_DisplayTCBean.attachmentURL[1]}"/>' >
									</c:when>
									<c:otherwise>
										<img alt="<c:out value="${orgName}"/>" src='<c:out value="${storeImgDir}${contract_DisplayTCBean.attachmentURL[1]}"/>' >
									</c:otherwise>
								</c:choose>
								<br/>
								<strong><c:out value="${orgName}"/></strong>
							</td>
						</tr>
					</c:if>
					<c:if test="${(!empty contract_DisplayTCBean.displayText[1]) or (!empty contract_DisplayTCBean.displayText[2])}">
						<tr>
							<td id="WC_CachedStoreCatalogDisplay_TableCell_1_2">
								<c:out value="${contract_DisplayTCBean.displayText[1]}"/><br/>
								<c:out value="${contract_DisplayTCBean.displayText[2]}"/>
							</td>
						</tr>
					</c:if>
				</table>
			</c:if>        
		        
                </td></tr>
		<tr align="center">
			<td class="c_flash" id="WC_CachedTopCategoriesDisplay_TableCell_5">
					<object data="<c:out value="${jspStoreImgDir}${CommandContext.locale}"/>/images/Homepage_Ad.swf"
							 width="786" height="384" type="application/x-shockwave-flash">
					<param name="movie" value="<c:out value="${jspStoreImgDir}${CommandContext.locale}"/>/images/Homepage_Ad.swf" />
					<param name="quality" value="high"/>
					<param name="bgcolor" value="#FFFFFF"/>
					<param name="pluginurl" value="http://www.macromedia.com/go/getflashplayer"/>
					</object>
			</td>
		</tr>
	</tbody>
	</table>

	<%out.flush();%>
	<c:import url="${jspStoreDir}include/StoreCatalogProductESpot.jsp">
		<c:param name="emsName" value="StoreHomePage"/>
        	<c:param name="catalogId" value="${catalogId}"/>
	</c:import>
	<%out.flush();%>

	<table cellpadding="0" cellspacing="0" width="100%" border="0" id="WC_CachedTopCategoriesDisplay_Table_4">
		<tbody>
			<tr>
				<td class="underStoreName" align="center" height="1" id="WC_CachedTopCategoriesDisplay_TableCell_6">
					<img src="<c:out value="${storeImgDir}"/>images/trans_pixel.gif" width="1" height="1" alt="" border="0"/>
				</td>
			</tr>
		</tbody>
	</table>

		
