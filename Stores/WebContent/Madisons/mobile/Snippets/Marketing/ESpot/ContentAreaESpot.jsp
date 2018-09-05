<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2009 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>

<%--
  * How to use this snippet?
  *	This is an example of how this file could be included into a page:
  *		<c:import url="${jspStoreDir}mobile/Snippets/Marketing/ESpot/ContentAreaESpot.jsp">
  *			<c:param name="emsName" value="MobileStoreHomePage" />
  *			<c:param name="catalogId" value="${WCParam.catalogId}" />
  *			<c:param name="numberCategoriesToDisplay" value="20" />
  *		</c:import>
 --%>

<!-- BEGIN ContentAreaESpot.jsp -->

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ include file="../../../../include/parameters.jspf" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf" %>

<% 
   /* Get the e-Marketing Spot name from the request parameters, and decode it in case it has been encoded */
   	String emsName = request.getParameter("emsName");
	if (emsName != null) {
		emsName = java.net.URLDecoder.decode(emsName, "UTF-8");
		request.setAttribute("emsName", emsName);
   	}

   /* Set the values for the maximum number of data to display. This is used to create the appropriate  */
   /* key to find the e-Marketing Spot data created by the campaigns filter when using e-Marketing Spot */
   /* JSP snippet caching. The snippet caching is configured in EMarketingSpotInvocationList.xml        */
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
   
   /* Set the name of the command that has called this page */
   String pathInfo = (String)request.getAttribute("javax.servlet.forward.path_info");
   if (pathInfo != null && pathInfo.startsWith ("/")) {
      pathInfo = pathInfo.substring (1);
   }
   request.setAttribute("requestURI", pathInfo);
   
   /* Get the marketing context information if it has been configured in businessContext.xml */
   request.setAttribute("marketingContext", com.ibm.commerce.foundation.server.services.businesscontext.ContextServiceFactory.getContextService().findContext(com.ibm.commerce.marketing.dialog.context.MarketingContext.CONTEXT_NAME));

%> 

  <%--
    *
    * Set up the variables required by the snippet
    *
  --%>
	<c:set var="requestURI"                	value="${requestScope.requestURI}"/>
	<c:set var="marketingContext"          	value="${requestScope.marketingContext}"/>
	<c:set var="emsFromFilter"             	value="${requestScope.emsFromFilter}"/>
	<c:set var="emsName"                   	value="${requestScope.emsName}"/>
	<c:set var="numberCategoriesToDisplay" 	value="${requestScope.numberCategoriesToDisplay}"/>
	<c:set var="numberProductsToDisplay"   	value="${requestScope.numberProductsToDisplay}"/>
	<c:set var="numberContentToDisplay"    	value="${requestScope.numberContentToDisplay}"/>
  <%--
    *
    * Specifies if a fully qualified URL or relative paths should be used for
    * image tags. Fully qualified URL is required for email activity functionality.
    *
  --%>
  <c:set var="prependFullURL">
 	<c:out value="${param.useFullURL}" default="false" />
  </c:set>

  <%--
    *
    * Sets the ClickInfo command URL if the optional clickInfoURL parameter is provided. Use the
    * default value of the URL otherwise.
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
    * Host name of the URL that is used to point to the shared image directory.  Use this variable to reference images.
    *
  --%>
  <c:set var="hostPath" value="" />
  <c:if test="${prependFullURL}">
    <c:set value="${pageContext.request.scheme}://${header.host}" var="hostPath" />
  </c:if>

  <%--
    *
    * Create the e-Marketing Spot
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
		
				<%-- referral url --%>
				<wcf:param name="DM_RefUrl" value="${cookie.REFERRER.value}" />
				
				<%-- url command name --%>
				<wcf:param name="DM_ReqCmd" value="${requestURI}" />
					
        		<%-- url name value pair parameters --%>					
				<c:forEach var="aParam" items="${WCParamValues}">
					<c:forEach var="aValue" items="${aParam.value}">
						<wcf:param name="${aParam.key}" value="${aValue}" />
					</c:forEach>
				</c:forEach>
				
				<%-- marketing context name value pair parameters --%>
				<c:forEach var="aPair" items="${marketingContext.nameValuePairs}">
					<wcf:param name="${aPair.key}" value="${aPair.value}" />
				</c:forEach>
				
			</wcf:getData>
		</c:otherwise>
	</c:choose>

<div class="genericESpot"><div class="caption" style="display:none">[<c:out value="${emsName}"/>]</div>	

	<%--
  	*
  	* Start: Categories
  	* The following block is used to display the categories associated with this e-Marketing Spot.
  	* The category display page which shows the selected category will be referenced
  	* through the submission of the HTML form in the calling JSP.
  	*
	--%>
	<c:set var="currentCategoryCount" value="0" />
	<c:forEach var="marketingSpotData" items="${marketingSpotDatas.baseMarketingSpotActivityData}" varStatus="status1">
		<c:if test='${marketingSpotData.dataType eq "CatalogGroup"}'>		    	
	   	 	<%--
		   		*
		   		* Set up the URL to call when clicking on the image
				*
			--%>
			
			<wcf:url var="TargetURL" value="mCategory4">
				<wcf:param name="langId" value="${langId}" />	
				<wcf:param name="storeId" value="${WCParam.storeId}" />
				<wcf:param name="catalogId" value="${param.catalogId}" />
				<wcf:param name="categoryId" value="${marketingSpotData.catalogGroup.catalogGroupIdentifier.uniqueID}" />
			</wcf:url>
			
			<c:url value="${clickInfoCommand}" var="ClickInfoURL">
				<c:param name="evtype" value="CpgnClick" />
				<c:param name="mpe_id" value="${marketingSpotDatas.marketingSpotIdentifier.uniqueID}" />
				<c:param name="intv_id" value="${marketingSpotData.activityIdentifier.uniqueID}" />
				<c:param name="storeId" value="${WCParam.storeId}" />
				<c:forEach var="expResult" items="${marketingSpotData.experimentResult}" begin="0" end="0">					    
					<c:param name="experimentId" value="${expResult.experiment.uniqueID}" />
					<c:param name="testElementId" value="${expResult.testElement.uniqueID}" />
					<c:param name="expDataType" value="${marketingSpotData.dataType}" />
					<c:param name="expDataUniqueID" value="${marketingSpotData.uniqueID}" />
				</c:forEach>				    	
				<c:param name="URL" value="${TargetURL}" />
			</c:url>
			   
          	<c:forEach var="attribute" items="${marketingSpotData.catalogGroup.attributes}">	
				<c:if test='${attribute.key eq "rootDirectory"}'>				    
                	<c:set var="imageFilePath" value="${staticAssetContextRoot}/${attribute.value}/" />
             	</c:if>		
			</c:forEach>

			<c:set value="${marketingSpotData.catalogGroup.description[0].name}" var="marketing_CategoryName" />
		
			<c:set var="currentCategoryCount" value="${currentCategoryCount+1}" />

			<div id="index_banner_1_${status1.index}" class="banner">
				<a href="${fn:escapeXml(ClickInfoURL)}" title="<c:out value="${marketing_CategoryName}" />">
					<c:import url="${jspStoreDir}/mobile/Snippets/Catalog/Attachments/CatalogAttachmentAssetsDisplay.jsp">
  						<c:param name="storeId" value="${WCParam.storeId}"/>
  						<c:param name="catalogId" value="${WCparam.catalogId}"/>
  						<c:param name="langId" value="${langId}"/>
  						<c:param name="categoryId" value="${marketingSpotData.catalogGroup.catalogGroupIdentifier.uniqueID}"/>
  						<c:param name="catType" value="category"/>
  						<c:param name="usage" value="MOBILE"/>
  					</c:import>
				</a>
			</div>
		</c:if>
	</c:forEach>
	<%--
  	*
  	* End: Categories
  	*
	--%>  
	

	<%--
  	*
  	* Start: Catalog Entries
  	* The following block is used to display the products or items associated with this e-Marketing Spot. The
  	* product display page which shows the selected product will be referenced
  	* through the submission of the HTML form in the calling JSP.
  	*
	--%>
	<c:set var="currentProductCount" value="0" />
	<c:forEach var="marketingSpotData" items="${marketingSpotDatas.baseMarketingSpotActivityData}">
		<c:if test='${marketingSpotData.dataType eq "CatalogEntry"}'>
    		<%--
           	*
           	* Set up the URL to call when clicking on the image
           	*
         	--%>
         
			<wcf:url var="TargetURL" value="mProduct4">
				<wcf:param name="catalogId" value="${param.catalogId}"/>
				<wcf:param name="storeId" value="${WCParam.storeId}"/>
				<wcf:param name="productId" value="${marketingSpotData.catalogEntry.catalogEntryIdentifier.uniqueID}"/>
				<wcf:param name="langId" value="${langId}"/>
				<wcf:param name="categoryId" value="${WCParam.categoryId}"/>
			</wcf:url>         
			
			<c:url value="${clickInfoCommand}" var="ClickInfoURL">
				<c:param name="evtype" value="CpgnClick" />
				<c:param name="mpe_id" value="${marketingSpotDatas.marketingSpotIdentifier.uniqueID}" />
				<c:param name="intv_id" value="${marketingSpotData.activityIdentifier.uniqueID}" />
				<c:param name="storeId" value="${WCParam.storeId}" />
				<c:forEach var="expResult" items="${marketingSpotData.experimentResult}" begin="0" end="0">					    
					<c:param name="experimentId" value="${expResult.experiment.uniqueID}" />
					<c:param name="testElementId" value="${expResult.testElement.uniqueID}" />
					<c:param name="expDataType" value="${marketingSpotData.dataType}" />
					<c:param name="expDataUniqueID" value="${marketingSpotData.uniqueID}" />							    	
				</c:forEach>				    	
				<c:param name="URL" value="${TargetURL}" />
			</c:url>
			    
			<c:set var="currentProductCount" value="${currentProductCount+1}" />
			    
          	<c:forEach var="attribute" items="${marketingSpotData.catalogEntry.catalogEntryAttributes.attributes}">	
				<c:if test='${attribute.name eq "rootDirectory"}'>				    
                	<c:set var="imageFilePath" value="${staticAssetContextRoot}/${attribute.stringValue.value}/" />
             	</c:if>		          	
          	</c:forEach>

			<c:set value="${marketingSpotData.catalogEntry.description[0].thumbnail}" var="marketing_catalogEntryThumbNail" />
			<c:set value="${marketingSpotData.catalogEntry.description[0].fullImage}" var="marketing_catalogEntryFullImage" />
			<c:set value="${marketingSpotData.catalogEntry.description[0].shortDescription}" var="marketing_catalogEntryShortDescription" />
			<c:set value="${marketingSpotData.catalogEntry.description[0].name}" var="marketing_catalogEntryName" />

			<c:choose>
				<c:when test="${!empty marketing_catalogEntryThumbNail}">
					<c:set value="${marketing_catalogEntryThumbNail}" var="marketing_catalogEntryImage" />
				</c:when>
				<c:otherwise>
					<c:set value="${marketing_catalogEntryFullImage}" var="marketing_catalogEntryImage" />
				</c:otherwise>
			</c:choose>
			
			<c:set var="currentCategoryCount" value="${currentCategoryCount+1}" />

			<c:choose>
				<c:when test="${!empty marketing_catalogEntryImage}">
					<a href="${fn:escapeXml(ClickInfoURL)}" 
					title="<c:out value='${marketing_catalogEntryName}' />">
						<img src="<c:out value='${hostPath}${imageFilePath}${marketing_catalogEntryImage}'/>" 
						width="45" height="45" border="0" alt="<c:out value='${marketing_catalogEntryShortDescription}' />" />
					</a>						
				</c:when>
				<c:otherwise>
					<a href="${fn:escapeXml(ClickInfoURL)}" 
					title="<c:out value='${marketing_catalogEntryName}' />">
						<img src="<c:out value='${hostPath}${jspStoreImgDir}' />images/NoImageIcon.jpg" 
						width="45" height="45" border="0" alt="<c:out value='${marketing_catalogEntryShortDescription}' />" />
					</a>						
				</c:otherwise>
			</c:choose>
		</c:if>
	</c:forEach>
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
  	* the HTML form in the calling JSP.
  	*
	--%>
	<c:set var="currentRowCount" value="0" />
	<c:forEach var="marketingSpotData" items="${marketingSpotDatas.baseMarketingSpotActivityData}" varStatus="status3">
		<c:if test='${marketingSpotData.dataType eq "MarketingContent"}'>
			<c:set var="currentRowCount" value="${currentRowCount+1}" />
	
			<%--
			*
			* Set up the URL to call when clicking on the image/text
			*
			--%>		  	
			<c:url value="${clickInfoCommand}" var="ClickInfoURL">
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
				<c:param name="URL" value="${marketingSpotData.marketingContent.url}" />
			</c:url>
		    
			<c:choose>
				<c:when test="${marketingSpotData.marketingContent.marketingContentFormat.name == 'File'}">
					<c:choose>
						<c:when test="${(marketingSpotData.marketingContent.mimeType eq 'image') || (marketingSpotData.marketingContent.mimeType eq 'images')}">		
							<%--
							*
							* Display the content image, with optional click information
							*
							--%>
							<c:if test="${!empty marketingSpotData.marketingContent.url}">
								<a href="${fn:escapeXml(ClickInfoURL)}">
							</c:if>

							<div id="index_banner_3_${status3.index}" class="banner">
								<img
									src='<c:out value="${hostPath}${staticAssetContextRoot}/${marketingSpotData.marketingContent.attachment.attachmentAsset[0].rootDirectory}/${marketingSpotData.marketingContent.attachment.attachmentAsset[0].attachmentAssetPath}"/>'
									alt='<c:out value="${marketingSpotData.marketingContent.attachment.attachmentDescription[0].shortDescription}" />'
									border="0" /> 
							</div>

							<c:if test="${!empty marketingSpotData.marketingContent.url}">	           
								</a>
							</c:if>
							<div class="text_container"> 
								<p><c:out value="${marketingSpotData.marketingContent.marketingContentDescription[0].marketingText}" escapeXml="false" /></p>
							</div>
							
						</c:when>	
						<c:when test="${marketingSpotData.marketingContent.mimeType eq 'text'}">	
							<%--
							*
							* Display the content text, with optional click information
							*
							--%>	                      
							<c:if test="${!empty marketingSpotData.marketingContent.url}">
								<a href="${fn:escapeXml(ClickInfoURL)}">
							</c:if>
							<c:out value="${marketingSpotData.marketingContent.marketingContentDescription[0].marketingText}" escapeXml="false" />
							<c:if test="${!empty marketingSpotData.marketingContent.url}">	           
								</a>
							</c:if>							
						</c:when>
						<c:otherwise>
							<%--
							* Content type is File, but no image or known mime type is associated, so display the marketing text 
							*
							* Display the content text, with optional click information
							*
							--%>						          	
							<c:if test="${!empty marketingSpotData.marketingContent.url}">
								<a href="${fn:escapeXml(ClickInfoURL)}">
							</c:if>
							<c:out value="${marketingSpotData.marketingContent.marketingContentDescription[0].marketingText}" escapeXml="false" />
							<c:if test="${!empty marketingSpotData.marketingContent.url}">	           
								</a>
							</c:if> 			       	
						</c:otherwise>
					</c:choose>
				</c:when>
				<c:when test="${marketingSpotData.marketingContent.marketingContentFormat.name == 'Text'}">		  
					<%--
					*
					* Display the content text, with optional click information
					*
					--%>			          	
					<c:if test="${!empty marketingSpotData.marketingContent.url}">
						<a href="${fn:escapeXml(ClickInfoURL)}">
					</c:if>
					<c:out value="${marketingSpotData.marketingContent.marketingContentDescription[0].marketingText}" escapeXml="false" />
					<c:if test="${!empty marketingSpotData.marketingContent.url}">	           
						</a>
					</c:if>        	
				</c:when>	
			</c:choose>        
		</c:if>
	</c:forEach>

	<%--
  	*
  	* End: Content
  	*
	--%>	

</div>

<!-- END ContentAreaESpot.jsp -->
