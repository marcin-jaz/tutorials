<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2008, 2009 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>

<%--
  *****
  * This JSP page displays the store home page which is made up of 5 rows of eMarketing spots
  * 
  * This is an example of how this file could be included into a page: 
  *<c:import url="../../../Snippets/Catalog/CategoryDisplay/CachedTopCategoriesDisplay.jsp">
  *          <c:param name="storeId" value="${storeId}"/>
  *          <c:param name="catalogId" value="${catalogId}"/>
  *          <c:param name="langId" value="${langId}"/>
  *</c:import>
  *****
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf"%>
<%@ include file="../../../Snippets/ReusableObjects/CatalogEntryQuickInfoDetails.jspf" %>

<div id="content588">
   <div id="box">
		
			<%out.flush();%>
			<c:import url="${jspStoreDir}Snippets/Marketing/ESpot/ContentAreaESpot.jsp">
				<c:param name="emsName" value="HomePageRow1Ads" />
				<c:param name="numberContentPerRow" value="1" />
				<c:param name="catalogId" value="${WCParam.catalogId}" />
				<c:param name="adWidth" value="586" />
				<c:param name="adHeight" value="216" />
				<c:param name="errorViewName" value="AjaxOrderItemDisplayView" />
			</c:import>
			<%out.flush();%>
		
			<%out.flush();%>
			<c:import url="${jspStoreDir}Snippets/Marketing/ESpot/ContentAreaESpot.jsp">
				<c:param name="emsName" value="HomePageRow2Ads" />
				<c:param name="numberCategoriesPerRow" value="4" />
				<c:param name="catalogId" value="${WCParam.catalogId}" />
				<c:param name="errorViewName" value="AjaxOrderItemDisplayView" />
			</c:import>
			<%out.flush();%>
			
			<%out.flush();%>
			<c:import url="${jspStoreDir}Snippets/Marketing/ESpot/ContentAreaESpot.jsp">
				<c:param name="emsName" value="HomePageRow3Ads" />
				<c:param name="numberContentPerRow" value="2" />
				<c:param name="catalogId" value="${WCParam.catalogId}" />
				<c:param name="errorViewName" value="AjaxOrderItemDisplayView" />
			</c:import>
			<%out.flush();%>
			
			<%out.flush();%>
			<c:import url="${jspStoreDir}Snippets/Marketing/ESpot/ContentAreaESpot.jsp">
				<c:param name="emsName" value="HomePageGeneralFeaturedProducts" />
				<c:param name="catalogId" value="${WCParam.catalogId}" />
				<c:param name="errorViewName" value="AjaxOrderItemDisplayView" />
			</c:import>
			<%out.flush();%>

			<%out.flush();%>
			<c:import url="${jspStoreDir}Snippets/Marketing/ESpot/ContentAreaESpot.jsp">
				<c:param name="emsName" value="HomePageRow4Ads" />
				<c:param name="numberContentPerRow" value="1" />
				<c:param name="catalogId" value="${WCParam.catalogId}" />
				<c:param name="errorViewName" value="AjaxOrderItemDisplayView" />
			</c:import>
			<%out.flush();%>

			<div id="HompageScrollableEspot" class="genericESpot">
				<div class="caption" id="CachedTopCategoriesDisplay_div_1a" style="display:none">[<c:out value="HomePageFeaturedProducts"/>]</div>
				<div class="contentgrad_header" id="CachedTopCategoriesDisplay_div_1">
					 <div class="left_corner" id="CachedTopCategoriesDisplay_div_2"></div>
					 <div class="left" id="CachedTopCategoriesDisplay_div_3"><span class="contentgrad_text"><fmt:message key="CLEARANCE_SALE" bundle="${storeText}" /></span></div>
					 <div class="right_corner" id="CachedTopCategoriesDisplay_div_4"></div>
				</div>
				<div class="body588" id="CachedTopCategoriesDisplay_div_5">
					<div id="id" dojoType="wc.widget.ScrollablePane" autoScroll='false' itemSize="135" altPrev = '<fmt:message key="SCROLL_LEFT" bundle="${storeText}" />' altNext = '<fmt:message key="SCROLL_RIGHT" bundle="${storeText}" />' tempImgPath = "<c:out value='${jspStoreImgDir}'/>images/empty.gif">
						<%out.flush();%>
						<c:import url="${jspStoreDir}Snippets/Marketing/ESpot/ScrollingProductsESpot.jsp">
							<c:param name="emsName" value="HomePageFeaturedProducts" />
							<c:param name="scrollable" value="true" />
							<c:param name="catalogId" value="${WCParam.catalogId}" />
							<c:param name="skipAttachments" value="true"/> <%-- do not load attachments --%>
						</c:import>
						<%out.flush();%>					
					</div>
					<script type="text/javascript">dojo.addOnLoad(function() { parseWidget("id"); });</script>
					<br />
				</div>
				
				<div class="footer" id="CachedTopCategoriesDisplay_div_6">
					 <div class="left_corner" id="CachedTopCategoriesDisplay_div_7"></div>
					 <div class="left" id="CachedTopCategoriesDisplay_div_8"></div>
					 <div class="right_corner" id="CachedTopCategoriesDisplay_div_9"></div>
				</div>
		</div>
   </div>
</div>
