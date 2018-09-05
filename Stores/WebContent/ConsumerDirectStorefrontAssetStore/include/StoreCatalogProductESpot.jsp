<%--
 ===================================================================
  Licensed Materials - Property of IBM
 
  WebSphere Commerce
 
  (c) Copyright International Business Machines Corporation.
      2003, 2008
      All Rights Reserved.
 
  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
 ===================================================================
--%>

<%--
  * This StoreCatalogProductESpot.jsp file is built as a sample snippet to display an e-Marketing Spot in a
  * store page. It uses Web services to call the Dialog Marketing runtime to get the data to display
  * in the e-Marketing Spot. 
  * 
  * Use this version of the sample snippet for e-Marketing Spots that use the marketing tool 
  * supplied with Management Center. For e-Marketing Spots that use the marketing tool 
  * supplied with WebSphere Commerce Accelerator, use the snippet called eMarketingSpotDisplay.jsp.
  * 
  * The code in this e-Marketing Spot .jsp file supports the display of the following types of data:
  *	- Catalog entries (specified in Web activities and through merchandising associations)
  * - Categories
  *	- Content (also known as ad copy or collateral)
  *
  * If you intend to display only one type of data in the e-Marketing Spot,
  * then you can remove the applicable sections of the code that will not be used.
  *
  * Prerequisites:
  * 	This code requires the following two parameters:
  *		- emsName
  *		  This .jsp file can be reused in different store pages by including it and assigning 
  * 	          a unique value for the emsName parameter. This value should match exactly with an 
  *               eMarketingSpot name that is defined in the Management Center when creating a new 
  *               eMarketingSpot.
  *		- catalogId
  *		  The catalogId parameter needs to be passed because it is required to build the proper URLs.
  *
  *   This code supports the following optional parameters:
  *   - numberCategoriesToDisplay
  *     The maximum number of categories that can be displayed in the e-Marketing Spot at the same time.
  *   - numberProductsToDisplay
  *     The maximum number of catalog entries that can be displayed in the e-Marketing Spot at the same time.
  *   - numberContentToDisplay    
  *     The maximum number of content that can be displayed in the e-Marketing Spot at the same time.
  *		- useFullURL
  *			Tells the page to use full paths when retrieving images, static assets, etc. This flag must be set
  *			to true if using this JSP in an email.
  *		- clickInfoURL
  *			This is the clickInfoURL that should be used instead.
  * 
  *   This code supports the following optional parameters for substituting variables in marketing content:
  *   - substitutionName1, substitutionValue1
  *     The name and value of a variable to replace in marketing content text.
  *   - substitutionName2, substitutionValue2
  *     The name and value of a variable to replace in marketing content text.
  *  
  *   This code supports the following two optional parameters:
  *   - errorViewName
  *     The URL to call if there is an error or exception when clicking on a content link in the e-Marketing Spot snippet.
  *   - orderId
  *     The ID of the current order of the customer to include when calling the errorViewName URL.
  *  
  * How to use this snippet:
  *	This is an example of how this file can be included in a page:
  *		<c:import url="${jspStoreDir}include/StoreCatalogProductESpot.jsp">
  *			<c:param name="emsName" value="ShoppingCartPage" />
  *			<c:param name="catalogId" value="${WCParam.catalogId}" />
  *		</c:import>
  *
  * This is another example including some of the optional parameters:
  *		<%out.flush();%>
  *		<c:import url="${jspStoreDir}include/StoreCatalogProductESpot.jsp">
  *			<c:param name="emsName" value="HomePageRow1Ads" />
  *			<c:param name="catalogId" value="${WCParam.catalogId}" />
  *			<c:param name="numberContentToDisplay" value="1" />	
  *			<c:param name="errorViewName" value="AjaxOrderItemDisplayView" />
  *			<c:param name="substitutionName1" value="[storeName]" />
  *		  <c:param name="substitutionValue1" value="Madisons" />
  *		</c:import>
  *		<%out.flush();%>
  *		   
  * If the e-Marketing Spot name (emsName) contains special characters, they must be encoded to pass
  * successfully to this page through the request parameter. Use the following technique:
  *   
  *   1. Before setting the emsName parameter in the import statement:
  * 	 request.setAttribute("emsName", java.net.URLEncoder.encode("ShoppingCartPage"));
  *   
  *   2.To retrieve the emsName parameter from the request when setting the parameter in the import statement:
  *     <c:param name="emsName" value="${requestScope.emsName}"/>
  *
--%>

<!-- BEGIN StoreCatalogProductESpot.jsp -->

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="JSTLEnvironmentSetup.jspf"%>

<% 
   /* Get the e-Marketing Spot name from the request parameters, and decode it in case it has been encoded. */
   String emsName = request.getParameter("emsName");
   if (emsName != null) {
   	emsName = java.net.URLDecoder.decode(emsName, "UTF-8");
	  request.setAttribute("emsName", emsName);
   }
   
   /* Set the values for the maximum number of data to display. This is used to create the appropriate     */
   /* key to find the e-Marketing Spot data created by the campaigns filter when using e-Marketing Spot    */
   /* JSP snippet caching. The snippet caching is configured in the EMarketingSpotInvocationList.xml file. */
   int displayCategories = 20;
   int displayProducts   = 20;
   int displayContent    = 20;
   
   String numberCategoriesToDisplayString = request.getParameter("numberCategoriesToDisplay");
   if (numberCategoriesToDisplayString != null) {
   	request.setAttribute("numberCategoriesToDisplay", numberCategoriesToDisplayString);
   	displayCategories = Integer.parseInt(numberCategoriesToDisplayString);
   }
   String numberProductsToDisplayString = request.getParameter("numberProductsToDisplay");
   if (numberProductsToDisplayString != null) {
   	request.setAttribute("numberProductsToDisplay", numberProductsToDisplayString);
   	displayProducts = Integer.parseInt(numberProductsToDisplayString);
   }
   String numberContentToDisplayString = request.getParameter("numberContentToDisplay");
   if (numberContentToDisplayString != null) {
   	request.setAttribute("numberContentToDisplay", numberContentToDisplayString);
   	displayContent = Integer.parseInt(numberContentToDisplayString);
   }   
   
   java.util.Hashtable emsHash = (java.util.Hashtable)request.getAttribute(com.ibm.commerce.marketing.beans.EMarketingSpot.EMS_REQUEST_ATTRIBUTE_CONTAINER_NAME);
   if (emsHash != null) {
      request.setAttribute("emsFromFilter", 
           emsHash.get(com.ibm.commerce.tools.campaigns.CampaignRuntimeUtil.generateEMarketingSpotInvocationKey(emsName, 20, displayProducts, displayCategories, displayContent)));      
   }
   
   /* Set the name of the command that has called this page. */
   String pathInfo = (String)request.getAttribute("javax.servlet.forward.path_info");
   if (pathInfo != null && pathInfo.startsWith ("/")) {
      pathInfo = pathInfo.substring (1);
   }
   request.setAttribute("requestURI", pathInfo);
   
   /* Get the marketing context information if it has been configured in the businessContext.xml file. */
   request.setAttribute("marketingContext", com.ibm.commerce.foundation.server.services.businesscontext.ContextServiceFactory.getContextService().findContext(com.ibm.commerce.marketing.dialog.context.MarketingContext.CONTEXT_NAME));
   
%>   

  <%--
    *
    * Set up the variables required by the snippet.
    *
  --%>
	<c:set var="requestURI"                value="${requestScope.requestURI}"/>
	<c:set var="marketingContext"          value="${requestScope.marketingContext}"/>
	<c:set var="emsFromFilter"             value="${requestScope.emsFromFilter}"/>
	<c:set var="emsName"                   value="${requestScope.emsName}"/>
	<c:set var="numberCategoriesToDisplay" value="${requestScope.numberCategoriesToDisplay}"/>
	<c:set var="numberProductsToDisplay"   value="${requestScope.numberProductsToDisplay}"/>
	<c:set var="numberContentToDisplay"    value="${requestScope.numberContentToDisplay}"/>

  <%--
    *
    * Specify if a fully qualified URL or relative paths should be used for
    * image tags. A fully qualified URL is required for e-mail activity functionality.
    *
  --%>
  <c:set var="prependFullURL">
	  <c:out value="${param.useFullURL}" default="false" />
  </c:set>

  <%--
    *
    * Set the ClickInfo command URL if the optional clickInfoURL parameter is provided; otherwise, use the
    * default value of the URL.
    *
  --%>
  <c:set value="ClickInfo" var="clickInfoCommand" />
  <c:set value="" var="clickOpenBrowser" />
  <c:if test="${!empty param.clickInfoURL}">
	  <c:set value="${param.clickInfoURL}" var="clickInfoCommand" />
	  <c:set value='target="_blank"' var="clickOpenBrowser" />
  </c:if>

  <%--
    *
    * Specify the host name of the URL that is used to point to the shared image directory.  
    * Use this variable to reference images.
    *
  --%>
  <c:set var="hostPath" value="" />
  <c:if test="${prependFullURL}">
	<c:set value="${pageContext.request.scheme}://${pageContext.request.serverName}" var="hostPath" />
  </c:if>


<!-- e-Marketing Spot Name: "<c:out value="${requestScope.emsName}"/>" -->
<c:set var="storeId" value="${CommandContext.storeId}"/>
<c:set var="langId" value="${CommandContext.languageId}"/>

<%--
  ***
  * Sets the current catalog ID from the parameter object if provided. Use the default value from
  * the command context otherwise.
  ***
--%>
<c:set value="${WCParam.catalogId}" var="marketing_ESpotCatalogId" />
<c:if test="${!empty param.catalogId}">
	<c:set value="${param.catalogId}" var="marketing_ESpotCatalogId" />
</c:if>

<%-- URL pointing to the shared image directory.  Use this variable to reference images --%>
<c:set var="marketing_CollateralPath" value="${storeImgDir}" scope="page" />

<%-- create ID/Counter for generating HTML ids --%>
<c:set value="WC_eMarketingSpot_TopCategoriesDisplay_Table_" var="marketing_Table_ID_Prefix" />
<c:set value="WC_eMarketingSpot_TopCategoriesDisplay_Cell_" var="marketing_TableCell_ID_Prefix" />
<c:set value="WC_eMarketingSpot_TopCategoriesDisplay_Link_" var="marketing_Link_ID_Prefix" />
<c:set value="WC_eMarketingSpot_TopCategoriesDisplay_Flash_" var="marketing_Flash_ID_Prefix" />
<c:set value="${0}" var="marketing_TableCounter" />
<c:set value="${0}" var="marketing_TableCellCounter" />
<c:set value="${0}" var="marketing_LinkCounter" />
<c:set value="${0}" var="marketing_FlashCounter" />


  <%--
    *
    * Create the e-Marketing Spot.
    *
  --%>
	<c:choose>
		<%-- Check if we already have the data - it could have been populated in the campaigns filter when JSP snippet caching is configured --%>
		<c:when test="${emsFromFilter != null && emsFromFilter.name eq emsName}">
			<c:set var="marketingSpotDatas" value="${emsFromFilter.marketingSpotData}"/>
		</c:when>

    <%-- Call the web service to get the data to display in the e-Marketing Spot --%>
		<c:otherwise>
			<%-- Set up the information required for the web service call --%>
			<wcf:getData type="com.ibm.commerce.marketing.facade.datatypes.MarketingSpotDataType" var="marketingSpotDatas" expressionBuilder="findByMarketingSpotName">
			
				<%-- the name of the e-Marketing Spot --%>
				<wcf:param name="DM_EmsName" value="${emsName}" />
								
				<%-- the maximum number of items to display --%>
				<c:if test="${numberCategoriesToDisplay != null}">
					<wcf:param name="DM_DisplayCategories" value="${numberCategoriesToDisplay}" />
				</c:if>
				<c:if test="${numberProductsToDisplay != null}">
					<wcf:param name="DM_DisplayProducts"   value="${numberProductsToDisplay}" />
				</c:if>
				<c:if test="${numberContentToDisplay != null}">
					<wcf:param name="DM_DisplayContent"    value="${numberContentToDisplay}" />
				</c:if>								
		
				<%-- url command name --%>
				<wcf:param name="DM_ReqCmd" value="${requestURI}" />
					
        <%-- url name value pair parameters --%>					
				<c:forEach var="aParam" items="${WCParamValues}">
					<c:forEach var="aValue" items="${aParam.value}">
						<wcf:param name="${aParam.key}" value="${aValue}" />
					</c:forEach>
				</c:forEach>
			
				<%-- Example of specifying the customer is viewing a particular product.
				     The marketing activity could then display merchandising associations
				     of this product.
				     
				<wcf:param name="productId" value="12345" />
				--%>
				<%-- Example of specifying the customer is viewing a set of product.
				     The marketing activity could then display merchandising associations
				     of these products.
				     
				<wcf:param name="productId" value="12345,67890,54321" />
				--%>
												
				<%-- Example of including a value from a specific cookie
				<wcf:param name="MYCOOKIE" value="${cookie.MYCOOKIE.value}" />
				--%>
				
				<%-- Example of including all cookies 
				<c:forEach var="cookieEntry" items="${cookie}">
					<wcf:param name="${cookieEntry.key}" value="${cookieEntry.value.value}" />					
				</c:forEach>
				--%>
				
				<%-- Example of including substitution variables. These variables will be replaced
				     in the Marketing Content marketing text string. For example, if the marketing
				     text is: "Marketing text [parameterName1],[parameterName2]"
				     then it will be changed to: "Marketing text parameterValue1,parameterValue2"
				     
				<wcf:param name="DM_SubstitutionName1" value="[parameterName1]" />
				<wcf:param name="DM_SubstitutionValue1" value="parameterValue1" />
				<wcf:param name="DM_SubstitutionName2" value="[parameterName2]" />
				<wcf:param name="DM_SubstitutionValue2" value="parameterValue2" />
				--%>		
				<c:if test="${!empty param.substitutionName1 && !empty param.substitutionValue1}">
				    <wcf:param name="DM_SubstitutionName1" value="${param.substitutionName1}" />
				    <wcf:param name="DM_SubstitutionValue1" value="${param.substitutionValue1}" />
				</c:if>
				<c:if test="${!empty param.substitutionName2 && !empty param.substitutionValue2}">
				    <wcf:param name="DM_SubstitutionName2" value="${param.substitutionName2}" />
				    <wcf:param name="DM_SubstitutionValue2" value="${param.substitutionValue2}" />
				</c:if>				
	 	
				<%-- marketing context name value pair parameters, currently not used
				<c:forEach var="aPair" items="${marketingContext.nameValuePairs}">
					<wcf:param name="${aPair.key}" value="${aPair.value}" />
				</c:forEach>
				--%>
					 	
			</wcf:getData>
		</c:otherwise>
	</c:choose>
		
  <%-- Example of the marketing content being the name of a JSP to include - this is useful in JSP experiments
  <c:choose>
    <c:when test="${!empty marketingSpotDatas.baseMarketingSpotActivityData}">
      <c:forEach var="marketingSpotData" items="${marketingSpotDatas.baseMarketingSpotActivityData}">
        <c:if test='${marketingSpotData.dataType eq "MarketingContent"}'>
          <c:import url="${marketingSpotData.marketingContent.url}" />
        </c:if>
      </c:forEach> 
    </c:when>
    <c:otherwise>
      <c:import url="DefaultPageName.jsp" />
    </c:otherwise>
  </c:choose>
  --%>
<div class="genericESpot"><div class="caption" style="display:none">[<c:out value="${emsName}"/>]</div>

<%--
  *
  * Start: Categories
  * The following block is used to display the categories associated with this e-Marketing Spot.
  * The category display page that shows the selected category will be referenced
  * through the submission of the HTML form in the calling .jsp file.
  *
--%>
<table align="center" cellpadding="0" cellspacing="0" width="786" border="0" id="<c:out value="${marketing_Table_ID_Prefix}" /><c:out value="${marketing_TableCounter}" />">
	<c:set var="CategoryExist" value="false" />
	<c:set  var="CategoriesCounter" value="0" />
	<c:forEach var="marketingSpotData" items="${marketingSpotDatas.baseMarketingSpotActivityData}" varStatus="counter">
		<c:if test='${marketingSpotData.dataType eq "CatalogGroup"}'>
		<c:set var="CategoryExist" value="true" />
		<c:set var="CategoriesCounter" value="${CategoriesCounter + 1}" />
		<c:if test='${CategoriesCounter==1}'>
			<tbody>
				<tr>
					<td align="left" id="<c:out value="${marketing_TableCell_ID_Prefix}" /><c:out value="${marketing_TableCellCounter }" />">
					<span class="c_home_txt_blue"><fmt:message key="CHOOSE_CATEGORY" bundle="${storeText}" />&nbsp;&nbsp;</span>
					<span class="c_home_txt_black"><fmt:message key="GREAT_DEAL" bundle="${storeText}" /></span><br/><br/>
					</td>
				</tr>
				<tr>
					<td width="100%" id="<c:out value="${marketing_TableCell_ID_Prefix}" /><c:out value="${marketing_TableCellCounter + 1}" />">
						<table cellpadding="0" cellspacing="0" class="t_table" id="<c:out value="${marketing_Table_ID_Prefix}" /><c:out value="${marketing_TableCounter + 1}" />">
							<tr>
								<c:set value="${marketing_TableCellCounter + 2}" var="marketing_TableCellCounter" />
								<c:set value="${marketing_TableCounter + 2}" var="marketing_TableCounter" />
		</c:if>
		
		<c:forEach var="description" items="${marketingSpotData.catalogGroup.description}" begin="0" end="0">
			<c:set value="${description.thumbnail}" var="marketing_catalogGroupThumbNail" />
			<c:set value="${description.name}" var="marketing_CategoryName" />
		</c:forEach>
		
		<c:url value="CategoryDisplay" var="marketing_TargetURL">
			<c:param name="categoryId" value="${marketingSpotData.catalogGroup.catalogGroupIdentifier.uniqueID}" />
			<c:param name="catalogId" value="${param.catalogId}" />
			<c:param name="storeId" value="${WCParam.storeId}" />
			<c:param name="langId" value="${langId}" />
			<c:if test="${marketingSpotData.catalogGroup.topCatalogGroup}">
				<c:param name="top" value="Y"/>
				<c:param name="top_category" value="${marketingSpotData.catalogGroup.catalogGroupIdentifier.uniqueID}"/>
			</c:if>
		</c:url>
		<c:url value="${clickInfoCommand}" var="marketing_ClickInfoURL">
			<c:param name="evtype" value="CpgnClick" />
			<c:param name="mpe_id" value="${marketingSpotDatas.marketingSpotIdentifier.uniqueID}" />
			<c:param name="intv_id" value="${marketingSpotData.activityIdentifier.uniqueID}" />
			<c:param name="storeId" value="${WCParam.storeId}" />
			<c:param name="catalogId" value="${param.catalogId}" />
			<c:param name="langId" value="${langId}" />
			<c:forEach var="expResult" items="${marketingSpotData.experimentResult}" begin="0" end="0">			
				    <c:param name="experimentId" value="${expResult.experiment.uniqueID}" />
				    <c:param name="testElementId" value="${expResult.testElement.uniqueID}" />
				    <c:param name="expDataType" value="${marketingSpotData.dataType}" />
				    <c:param name="expDataUniqueID" value="${marketingSpotData.uniqueID}" />
			</c:forEach>
			<c:param name="URL" value="${marketing_TargetURL}" />
		</c:url>

		<%-- Place three categories images per row and then change to the next line--%>
		<%-- counter starts from 1 --%>
		
		<c:if test="${(CategoriesCounter - 1) % 3 == 0}">
			</tr><tr><td>&nbsp;</td></tr><tr>
		</c:if>
		
		<c:choose>
			<c:when test="${(CategoriesCounter - 1) % 3 == 0}">
				<td width="262" align="left" id="<c:out value="${marketing_TableCell_ID_Prefix}" /><c:out value="${marketing_TableCellCounter}" />">
			</c:when>
			<c:when test="${(CategoriesCounter - 1) % 3 == 1}">
				<td width="262" align="center" id="<c:out value="${marketing_TableCell_ID_Prefix}" /><c:out value="${marketing_TableCellCounter}" />">
			</c:when>
			<c:otherwise>
				<td width="262" align="right" id="<c:out value="${marketing_TableCell_ID_Prefix}" /><c:out value="${marketing_TableCellCounter}" />">
			</c:otherwise>
		</c:choose>

		<table align="left" valign="top" cellpadding="0" cellspacing="0" border="0" class="c_homepage_cat" id="<c:out value="${marketing_Table_ID_Prefix}" /><c:out value="${marketing_TableCounter}" />">
			<tr>
				<td valign="top" id="<c:out value="${marketing_TableCell_ID_Prefix}" /><c:out value="${marketing_TableCellCounter + 1}" />">
					<a href="<c:out value="${marketing_ClickInfoURL}"/>" id="<c:out value="${marketing_Link_ID_Prefix}" /><c:out value="${marketing_LinkCounter}" />">
						<c:choose>
							<c:when test="${!empty marketing_catalogGroupThumbNail}">
								<c:forEach var="attribute" items="${marketingSpotData.catalogGroup.attributes}">	
			             <c:if test='${attribute.key eq "rootDirectory"}'>				    
			                <c:set var="imageFilePath" value="${staticAssetContextRoot}/${attribute.value}/" />
			             </c:if>
			          </c:forEach>
								<img 
									src="<c:out value="${hostPath}"/><c:out value="${imageFilePath}${marketing_catalogGroupThumbNail}"/>" 
									alt="<c:out value="${marketing_CategoryName}" escapeXml="false"/>" border="0" />
							</c:when>
							<c:otherwise>
								<img 
									src="<c:out value="${hostPath}"/><c:out value="${jspStoreImgDir}" />images/NoImageIcon_sm45.jpg"
									alt="<fmt:message key="No_Image" bundle="${storeText}"/>" border="0" />
							</c:otherwise>
						</c:choose>
					</a>
				</td>
			</tr>
			<tr>
				<td id="<c:out value="${marketing_TableCell_ID_Prefix}" /><c:out value="${marketing_TableCellCounter + 2}" />"><span class="c_homepage_cat_txt">
					<c:out value="${marketing_CategoryName}" escapeXml="false"/>
				</span></td>
			</tr>
		</table>
	</td>
	<%-- Adjust counter  --%>
	<c:set value="${marketing_TableCellCounter + 3}" var="marketing_TableCellCounter"   />
	<c:set value="${marketing_LinkCounter + 1}" var="marketing_LinkCounter"   />
	<c:set value="${marketing_TableCounter + 1}" var="marketing_TableCounter"   />
	</c:if>
	</c:forEach>
	<c:if test='${CategoryExist=="true"}'>
					</tr>
					</table>
				</td>
			</tr>
		</tbody>
	</c:if>				
</table>

<%--
  *
  * End: Categories
  *
--%>  
	

<%--
  *
  * Start: Catalog Entries
  * The following block is used to display the catalog entries associated with this e-Marketing Spot. The
  * product display page that shows the selected catalog entry will be referenced
  * through the submission of the HTML form in the calling .jsp file.
  *
--%>	
<%-- Constant for the number of results to display on a row --%>
<c:set var="resultsOnRow" value="6" />

<%-- Counts the column number we are drawing in.  From 0 to resultsOnRow - 1 --%>
<c:set var="numberOfResults" value="0" />


<table align="center" cellpadding="0" cellspacing="0" width="786" border="0" id="<c:out value="${marketing_Table_ID_Prefix}" /><c:out value="${marketing_TableCounter}" />">
		
	<c:set var="CatalogEntryExist" value="false" />
	<c:forEach var="marketingSpotData" items="${marketingSpotDatas.baseMarketingSpotActivityData}" varStatus="status">
		<c:if test='${marketingSpotData.dataType eq "CatalogEntry"}'>
			<c:set var="CatalogEntryExist" value="true" />
			<c:if test='${status.count==1}'>
				<tbody>
					<tr>
						<td id="<c:out value="${marketing_TableCell_ID_Prefix}" /><c:out value="${marketing_TableCellCounter }" />"></br>
							<span class="c_home_txt_blue"><fmt:message key="SPECIALS" bundle="${storeText}" /></span>
							<span class="c_home_txt_black"><fmt:message key="OVERSTOCK_PRODUCTS" bundle="${storeText}" /></span></br></br>
						</td>
					</tr>
					<tr>
						<td id="<c:out value="${marketing_TableCell_ID_Prefix}" /><c:out value="${marketing_TableCellCounter + 1}" />">
							<table cellpadding="0" cellspacing="0" border="0" width="100%" id="<c:out value="${marketing_Table_ID_Prefix}" /><c:out value="${marketing_TableCounter + 1}" />">
								<tr>
									<c:set value="${marketing_TableCellCounter + 2}" var="marketing_TableCellCounter" />
									<c:set value="${marketing_TableCounter + 2}" var="marketing_TableCounter" />
									
			</c:if>
			
			<c:forEach var="description" items="${marketingSpotData.catalogEntry.description}" begin="0" end="0">
				<c:set value="${description.thumbnail}" var="marketing_CatalogEntryThumbNail" />
				<c:set value="${description.name}" var="marketing_CatalogEntryName" />
			</c:forEach>
			
			
		
			<c:url value="ProductDisplay" var="marketing_TargetURL">
				<c:param name="catalogId" value="${marketing_ESpotCatalogId}" />
				<c:param name="productId" value="${marketingSpotData.catalogEntry.catalogEntryIdentifier.uniqueID}" />
				<c:param name="storeId" value="${storeId}" />
				<c:param name="langId" value="${langId}" />
			</c:url>
			<c:url value="${clickInfoCommand}" var="marketing_ClickInfoURL">
				<c:param name="evtype" value="CpgnClick" />
				<c:param name="mpe_id" value="${marketingSpotDatas.marketingSpotIdentifier.uniqueID}" />
				<c:param name="intv_id" value="${marketingSpotData.activityIdentifier.uniqueID}" />
				<c:param name="storeId" value="${WCParam.storeId}" />
				<c:param name="catalogId" value="${param.catalogId}" />
				<c:param name="langId" value="${langId}" />
				<c:forEach var="expResult" items="${marketingSpotData.experimentResult}" begin="0" end="0">			
				    <c:param name="experimentId" value="${expResult.experiment.uniqueID}" />
				    <c:param name="testElementId" value="${expResult.testElement.uniqueID}" />
				    <c:param name="expDataType" value="${marketingSpotData.dataType}" />
				    <c:param name="expDataUniqueID" value="${marketingSpotData.uniqueID}" />
				</c:forEach>
				<c:param name="URL" value="${marketing_TargetURL}" />
			</c:url>
				
			<td id="<c:out value="${marketing_TableCell_ID_Prefix}" /><c:out value="${marketing_TableCellCounter}" />">
			
				<table valign="top" cellpadding="0" cellspacing="0" border="0" id="<c:out value="${marketing_Table_ID_Prefix}" /><c:out value="${marketing_TableCounter}" />">
					<tr>
						<td align="center" valign="top" id="<c:out value="${marketing_TableCell_ID_Prefix}" /><c:out value="${marketing_TableCellCounter + 1}" />">
							<c:forEach var="attribute" items="${marketingSpotData.catalogEntry.catalogEntryAttributes.attributes}">	
				      	<c:if test='${attribute.name eq "rootDirectory"}'>				    
									<c:set var="imageFilePath" value="${staticAssetContextRoot}/${attribute.stringValue.value}/" />
				        </c:if>
				      </c:forEach>
							<a href="<c:out value="${marketing_ClickInfoURL}"/>" id="<c:out value="${marketing_Link_ID_Prefix}" /><c:out value="${marketing_LinkCounter}" />">
								<img 
									src="<c:out value="${hostPath}"/><c:out value="${imageFilePath}"/><c:out value="${marketing_CatalogEntryThumbNail}"/>" 
									alt="<c:out value="${marketing_CatalogEntryName}" escapeXml="false"/>" width="73" height="73" border="0" />
							</a>
						</td>
					</tr>
					<tr>
						<td align="center" class="productName" id="<c:out value="${marketing_TableCell_ID_Prefix}" /><c:out value="${marketing_TableCellCounter + 2}" />">
							<c:out value="${marketing_CatalogEntryName}" escapeXml="false"/>
						</td>
					</tr>
					<tr>
						<td align="center" id="<c:out value="${marketing_TableCell_ID_Prefix}" /><c:out value="${marketing_TableCellCounter + 3}" />">
							<span class="h_price">
								<fmt:formatNumber value="${marketingSpotData.catalogEntry.price.standardPrice.price.price.value}" type="currency" currencyCode="${marketingSpotData.catalogEntry.price.standardPrice.price.price.currency}" />
							</span>
						</td>
					</tr>
				</table>
			</td>	
													
			<%-- Set the last column number we drew so we know what column to draw next --%>
			<c:set var="numberOfResults" value="${numberOfResults+1}" />
								
			<c:if test="${(numberOfResults % resultsOnRow) == 0}">
				</tr><tr>
				<c:set var="numberOfResults" value="0" />
			</c:if>
				
			<%-- Adjust counters  --%>
			<c:set value="${marketing_TableCellCounter + 4}" var="marketing_TableCellCounter"   />
			<c:set value="${marketing_LinkCounter + 1}" var="marketing_LinkCounter"   />
			<c:set value="${marketing_TableCounter + 1}" var="marketing_TableCounter"   />
		</c:if>
	</c:forEach>
	<c:if test='${numberOfResults != 0}'>
		</tr>
	</c:if>
	<c:if test='${CatalogEntryExist == "true"}'>
					</table>
				</td>
			</tr>
		</tbody>
	</c:if>
</table>	

<%--
  *
  * End: CatalogEntries
  *
--%>	


<%--
  *
  * Start: Content
  * The following block is used to display the content associated with this e-Marketing
  * Spot. The URL link defined with the content can be referenced through the submission of
  * the HTML form in the calling .jsp file.
  *
--%>

	<c:forEach var="marketingSpotData" items="${marketingSpotDatas.baseMarketingSpotActivityData}">
		<c:if test='${marketingSpotData.dataType eq "MarketingContent"}'>
			<table id="<c:out value="${marketing_Table_ID_Prefix}" /><c:out value="${marketing_TableCounter}" />">
		   <%--
         *
         * Set up the URL to call when the image or text is clicked.
         *
        --%>	
        
			  <c:url value="${marketingSpotData.marketingContent.url}" var="contentClickUrl">
				  <c:if test="${!empty param.errorViewName}" >
					  <c:param name="errorViewName" value="${param.errorViewName}" />
					  <c:if test="${!empty param.orderId}">
						  <c:param name="orderId" value="${param.orderId}"/>
					  </c:if>
				  </c:if>
			  </c:url>
			        	  	
				<c:url value="${clickInfoCommand}" var="ClickInfoURL">
					<c:param name="evtype" value="CpgnClick" />
					<c:param name="mpe_id" value="${marketingSpotDatas.marketingSpotIdentifier.uniqueID}" />
					<c:param name="intv_id" value="${marketingSpotData.activityIdentifier.uniqueID}" />
					<c:param name="storeId" value="${storeId}" />
					<c:param name="catalogId" value="${marketing_ESpotCatalogId}" />
					<c:param name="langId" value="${langId}" />
					<c:forEach var="expResult" items="${marketingSpotData.experimentResult}" begin="0" end="0">			
				    <c:param name="experimentId" value="${expResult.experiment.uniqueID}" />
				    <c:param name="testElementId" value="${expResult.testElement.uniqueID}" />
				    <c:param name="expDataType" value="${marketingSpotData.dataType}" />
				    <c:param name="expDataUniqueID" value="${marketingSpotData.uniqueID}" />
					</c:forEach>
 					<c:param name="URL" value="${contentClickUrl}" /> 					
				</c:url>
				<tr valign="top">
					<td  colspan="2" id="<c:out value="${marketing_TableCell_ID_Prefix}" /><c:out value="${marketing_TableCellCounter }" />">
						<strong><fmt:message key="eMarketingSpot_AdCopy" bundle="${storeText}" /></strong>
					</td>
				</tr>
				<tr>
					<td>
					<c:choose>
						
					  <c:when test="${marketingSpotData.marketingContent.marketingContentFormat.name == 'File'}">		  	
						   <c:choose>
								<c:when test="${(marketingSpotData.marketingContent.mimeType eq 'image') || (marketingSpotData.marketingContent.mimeType eq 'images')}">
	              	 <%--
                    *
                    * Display the content image, with optional click information.
                    *
                   --%>			
									<c:if test="${!empty marketingSpotData.marketingContent.url}">
									  <a href="${ClickInfoURL}" ${clickOpenBrowser} >
									</c:if>
									<c:forEach var="attachmentAsset" items="${marketingSpotData.marketingContent.attachment.attachmentAsset}" begin="0" end="0">			        
										<img
										   src='<c:out value="${hostPath}"/><c:out value="${staticAssetContextRoot}/${attachmentAsset.rootDirectory}/${attachmentAsset.attachmentAssetPath}"/>'
										   alt='<c:out value="${marketingSpotData.marketingContent.attachment.attachmentDescription[0].shortDescription}"/>'
										/>
									</c:forEach> 
									<c:if test="${!empty marketingSpotData.marketingContent.url}">	           
										</a>
									</c:if>
								</c:when>
								<c:when test="${(marketingSpotData.marketingContent.mimeType eq 'application') || 
								  (marketingSpotData.marketingContent.mimeType eq 'applications') || 
								  (marketingSpotData.marketingContent.mimeType eq 'text') || 
								  (marketingSpotData.marketingContent.mimeType eq 'textyv') || 
								  (marketingSpotData.marketingContent.mimeType eq 'video') || 
								  (marketingSpotData.marketingContent.mimeType eq 'audio') || 
								  (marketingSpotData.marketingContent.mimeType eq 'model')
								  }">		
		          	   <%--
                    *
                    * Display the content: flash, audio, or other.
                    *
                   --%>		
									<c:forEach var="attachmentAsset" items="${marketingSpotData.marketingContent.attachment.attachmentAsset}" begin="0" end="0">			        
										<c:choose>
											<c:when test="${(attachmentAsset.mimeType eq 'application/x-shockwave-flash')}" >
												<EMBED src='<c:out value="${hostPath}"/><c:out value="${staticAssetContextRoot}/${attachmentAsset.rootDirectory}/${attachmentAsset.attachmentAssetPath}"/>'
												quality=high bgcolor=#FFFFFF type="application/x-shockwave-flash" />
											</c:when>
											<c:otherwise>
												<a href="<c:out value="${hostPath}"/><c:out value="${staticAssetContextRoot}/${attachmentAsset.rootDirectory}/${attachmentAsset.attachmentAssetPath}"/>" target="_blank"> 
												<img
												   src='<c:out value="${hostPath}"/><c:out value="${staticAssetContextRoot}/${attachmentAsset.rootDirectory}/${marketingSpotData.marketingContent.attachment.attachmentUsage.image}"/>'
												   alt='<c:out value="${marketingSpotData.marketingContent.attachment.attachmentDescription[0].shortDescription}"/>'
												/>
												</a>
											 </c:otherwise>
										</c:choose>
                      
		       	          <%--
                       *
                       * Display the content text, with optional click information.
                       *
                      --%>	                      
 				              <c:if test="${!empty marketingSpotData.marketingContent.url}">
				                 <a href="${ClickInfoURL}" ${clickOpenBrowser} >
				              </c:if>
				              <c:forEach var="contentDescription" items="${marketingSpotData.marketingContent.marketingContentDescription}" begin="0" end="0">
					            		<c:out value="${contentDescription.marketingText}" escapeXml="false" />
					            </c:forEach> 
                      <c:if test="${!empty marketingSpotData.marketingContent.url}">	           
					              </a>
					            </c:if>                         	
        
	                 </c:forEach> 

			          </c:when>	
			          
			          <c:otherwise>
		       	       <%--
                    * Content type is File, but no image or known mime type is associated, so display a link to the URL. 
                    * Display the content text, with optional click information.
                    *
                   --%>				
                   <a href="<c:out value='${marketingSpotData.marketingContent.attachment.attachmentAsset[0].attachmentAssetPath}' />" target="_new"> 
                   	 <c:out value="${marketingSpotData.marketingContent.attachment.attachmentAsset[0].attachmentAssetPath}"/>
                   </a>		          	
 				           <c:if test="${!empty marketingSpotData.marketingContent.url}">
				             <a href="${ClickInfoURL}" ${clickOpenBrowser} >
				           </c:if>
				           <c:if test="${!empty marketingSpotData.marketingContent.marketingContentDescription[0].marketingText}">
				           	    <br/>
       						      <c:out value="${marketingSpotData.marketingContent.marketingContentDescription[0].marketingText}" escapeXml="false" />
				           </c:if>
                   <c:if test="${!empty marketingSpotData.marketingContent.url}">	           
					           </a>
					         </c:if> 			       	
			          </c:otherwise>
			       </c:choose>
          </c:when>
          <c:when test="${marketingSpotData.marketingContent.marketingContentFormat.name == 'Text'}">		  
		       	 <%--
              *
              * Display the content text, with optional click information.
              *
             --%>			          	
 				     <c:if test="${!empty marketingSpotData.marketingContent.url}">
				       <a href="${ClickInfoURL}" ${clickOpenBrowser} >
				     </c:if>
				     <c:forEach var="contentDescription" items="${marketingSpotData.marketingContent.marketingContentDescription}" begin="0" end="0">
					   		<c:out value="${contentDescription.marketingText}" escapeXml="false" />
					   </c:forEach> 
             <c:if test="${!empty marketingSpotData.marketingContent.url}">	           
					     </a>
					   </c:if>        	
          </c:when>	
        </c:choose>        
					</td>
				</tr>
				<%-- Adjust counter  --%>
				<c:set value="${marketing_TableCellCounter + 2}" var="marketing_TableCellCounter"   />
				<c:set value="${marketing_LinkCounter + 2}" var="marketing_LinkCounter"   />
			</table>
			<%-- Adjust the table counter  --%>
			<c:set value="${marketing_TableCounter + 1}" var="marketing_TableCounter"   />
		</c:if>
	</c:forEach>

<%--
  *
  * End: Content
  *
--%>	

</div>
<!-- END StoreCatalogProductESpot.jsp -->
