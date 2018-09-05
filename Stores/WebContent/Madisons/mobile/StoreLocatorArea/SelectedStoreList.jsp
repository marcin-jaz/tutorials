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
  *****
  * This JSP displays the selected store list page.
  *****
--%>

<!-- BEGIN SelectedStoreList.jsp -->

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>

<%@ include file="../include/JSTLEnvironmentSetup.jspf" %>

<c:set var="storeLocatorPageGroup" value="true" />
<c:set var="selectedStoreListPage" value="true" />

<c:set var="fromPage" value="" />
<c:if test="${!empty WCParam.fromPage}">
	<c:set var="fromPage" value="${WCParam.fromPage}" />
</c:if>

<c:set var="wcPhysicalStores" value="${cookie.WC_physicalStores.value}" />
<c:if test="${!empty wcPhysicalStores}">
	<c:set var="wcPhysicalStores" value="${fn:replace(wcPhysicalStores, '%2C', ',')}" scope="page" />
	<wcf:getData type="com.ibm.commerce.store.facade.datatypes.PhysicalStoreType[]"
		     var="physicalStores" varException="physicalStoreException" expressionBuilder="findPhysicalStoresByUniqueIDs">
		<wcf:param name="accessProfile" value="IBM_Store_Details" />
		<c:forTokens items="${wcPhysicalStores}" delims="," var="phyStoreId">
			<wcf:param name="uniqueId" value="${phyStoreId}" />	
		</c:forTokens>
	</wcf:getData>

	<c:if test="${fromPage == 'ShoppingCart'}">
		<wcf:getData type="com.ibm.commerce.order.facade.datatypes.OrderType" scope="request" var="order" expressionBuilder="findCurrentShoppingCartWithPagingOnItem" varShowVerb="ShowVerbCart" maxItems="${pageSize}" recordSetStartNumber="${beginIndex}" recordSetReferenceId="ostatus">
			<wcf:param name="accessProfile" value="IBM_Details" />	 
			<wcf:param name="sortOrderItemBy" value="orderItemID" />
			<wcf:param name="isSummary" value="false" />
		</wcf:getData>
		
		<c:set var="orderId" value="${order.orderIdentifier.uniqueID}" />
		
		<c:if test="${!empty orderId}">
		<%
		String cookieVal = (String)pageContext.getAttribute("wcPhysicalStores");
		if (cookieVal!=null && cookieVal.length()>0) {
			java.util.Map parameters = new java.util.HashMap();
			
			String[] orderId = {((String)pageContext.getAttribute("orderId"))};
			parameters.put("orderId", orderId);
	
			java.util.StringTokenizer tokenizer = new java.util.StringTokenizer(cookieVal, ",");
			java.util.Vector physicalStoreIds = new java.util.Vector();
			physicalStoreIds.add(tokenizer.nextToken());
			while (tokenizer.hasMoreTokens()) {
				physicalStoreIds.add(tokenizer.nextToken());
			}

			for (int i=0; i<physicalStoreIds.size(); i++) {
				String[] physicalStoreId = {((String)physicalStoreIds.elementAt(i))};
				parameters.put("physicalStoreId_"+i, physicalStoreId);
			}
			
		    	java.util.Map results = null;
			try {
				com.ibm.commerce.inventory.facade.client.InventoryFacadeClient inventoryFacadeClient = new com.ibm.commerce.inventory.facade.client.InventoryFacadeClient();
				results = inventoryFacadeClient.checkInventory(parameters);
				java.util.List physicalStoreInventoryAvailabilityResult = (java.util.List)(results.get("physicalStoreInventoryAvailability"));
				
				pageContext.setAttribute("physicalStoreSize", Integer.toString(physicalStoreInventoryAvailabilityResult.size()));
				
				java.util.Map physicalStoreResults = null;
				String resultPhysicalStoreIds = null;
				String resultPhysicalStoreInvStatus = null;
				if (physicalStoreInventoryAvailabilityResult.size() > 0) {
					physicalStoreResults = (java.util.Map)physicalStoreInventoryAvailabilityResult.get(0);
					resultPhysicalStoreIds = (String)physicalStoreResults.get("physicalStoreId");
					resultPhysicalStoreInvStatus = (String)physicalStoreResults.get("overallInventoryStatus");
					
					for (int i=1; i<physicalStoreInventoryAvailabilityResult.size(); i++) {
						physicalStoreResults = (java.util.Map)physicalStoreInventoryAvailabilityResult.get(i);
						resultPhysicalStoreIds = resultPhysicalStoreIds + "," + (String)physicalStoreResults.get("physicalStoreId");
						resultPhysicalStoreInvStatus = resultPhysicalStoreInvStatus + "," + (String)physicalStoreResults.get("overallInventoryStatus");
					}
					
					pageContext.setAttribute("resultPhysicalStoreIds", resultPhysicalStoreIds);
					pageContext.setAttribute("resultPhysicalStoreInvStatus", resultPhysicalStoreInvStatus);
				}
//			} catch (com.ibm.commerce.inventory.facade.client.InventoryRequirementException exception) {
			} catch (Exception exception) {
			}
		}
		%>
		</c:if>

		<c:set var="resultPhyStoreInvStatusArray" value="${fn:split(resultPhysicalStoreInvStatus, ',')}" />
		<c:set var="pickUpStoreId" value="${cookie.WC_pickUpStore.value}" />
	</c:if>
</c:if>


<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.2//EN" "http://www.openmobilealliance.org/tech/DTD/xhtml-mobile12.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" lang="${shortLocale}" xml:lang="${shortLocale}">

	<head>

		<title>
			<fmt:message key="MSTLST_TITLE" bundle="${storeText}">
				<fmt:param value="${storeName}" />
			</fmt:message>
		</title>
		
		<meta http-equiv="content-type" content="application/xhtml+xml" />
		<meta http-equiv="cache-control" content="max-age=300" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no" />

		<link rel="stylesheet" href="${cssPath}" type="text/css" />

	</head>
	
	<body>
		
		<div id="wrapper">
		
			<%@ include file="../include/HeaderDisplay.jspf" %>

			<fmt:message var="finalBreadcrumb" key="MSTORE_LIST" bundle="${storeText}" />
			<%@ include file="../include/BreadCrumbTrailDisplay.jspf" %>	
			
			<div id="address_list" class="content_box">
				<div class="heading_container_with_underline">
					<h2><fmt:message key="MSTLST_HEADING" bundle="${storeText}" /></h2>
					<div class="clear_float"></div>
				</div>

				<c:if test="${WCParam.errorView=='true'}">
					<p class="error"><fmt:message key="MSTLST_PICK_STORE_ERROR" bundle="${storeText}" /></p>
				</c:if>

				<c:if test="${fromPage == 'ShoppingCart'}">
						<form name="storeSelectionForm" id="your_store_list_cont_checkout_button" method="post" action="mSaveStoreSelection">
				</c:if>
				
				<c:url var="mStoreLocatorURL" value="mStoreLocatorView">
					<c:param name="storeId" value="${WCParam.storeId}" />
					<c:param name="langId" value="${WCParam.langId}" />
					<c:param name="catalogId" value="${WCParam.catalogId}" />
					<c:param name="productId" value="${WCParam.productId}" />
				
					<c:if test="${!empty WCParam.pgGrp}">
						<c:param name="pgGrp" value="${WCParam.pgGrp}" />
						<c:choose>
							<c:when test="${WCParam.pgGrp == 'catNav'}">
								<c:param name="categoryId" value="${WCParam.categoryId}" />
								<c:param name="parent_category_rn" value="${WCParam.parent_category_rn}" />
								<c:param name="top_category" value="${WCParam.top_category}" />
								<c:param name="sequence" value="${WCParam.sequence}" />
							</c:when>
							<c:when test="${WCParam.pgGrp == 'search'}">
								<c:param name="resultCatEntryType" value="${WCParam.resultCatEntryType}" />
								<c:param name="pageSize" value="${WCParam.pageSize}" />
								<c:param name="searchTerm" value="${WCParam.searchTerm}" />
								<c:param name="beginIndex" value="${WCParam.beginIndex}" />			
								<c:param name="sType" value="${WCParam.sType}" />			
							</c:when>
						</c:choose>
					</c:if>
					<c:param name="fromPage" value="${fromPage}" />
					<c:if test="${fromPage == 'ShoppingCart'}">
						<c:param name="orderId" value="${WCParam.orderId}" />
					</c:if>
				</c:url>

				<c:choose>
					<c:when test="${(!empty wcPhysicalStores) && (empty physicalStoreException)}">
						<c:if test="${fromPage == 'ShoppingCart'}">
							<p class="paragraph_blurb"><fmt:message key="MSTLST_PICK_STORE" bundle="${storeText}" /></p>
						</c:if>					
					
						<c:set var="resultStoreNum" value="${fn:length(physicalStores)}" />
						<c:forEach var="i" begin="0" end="${resultStoreNum-1}">
							<ul class="last">
								<c:set var="storeListIndex" value="${i}" />
								
								<c:url var="mStoreDetailURL" value="mStoreDetailView">
									<c:param name="storeListIndex" value="${storeListIndex}" />
									<c:param name="storeId" value="${WCParam.storeId}" />
									<c:param name="langId" value="${WCParam.langId}" />
									<c:param name="catalogId" value="${WCParam.catalogId}" />
									<c:param name="productId" value="${WCParam.productId}" />
	
									<c:if test="${!empty WCParam.storeList}">
										<c:param name="storeList" value="${WCParam.storeList}" />
									</c:if>								
									<c:if test="${!empty WCParam.fromPage}">								
										<c:param name="fromPage" value="${WCParam.fromPage}" />
									</c:if>
									<c:if test="${!empty WCParam.pgGrp}">
										<c:param name="pgGrp" value="${WCParam.pgGrp}" />
										<c:choose>
											<c:when test="${WCParam.pgGrp == 'catNav'}">
												<c:param name="categoryId" value="${WCParam.categoryId}" />
												<c:param name="parent_category_rn" value="${WCParam.parent_category_rn}" />
												<c:param name="top_category" value="${WCParam.top_category}" />
												<c:param name="sequence" value="${WCParam.sequence}" />
											</c:when>
											<c:when test="${WCParam.pgGrp == 'search'}">
												<c:param name="resultCatEntryType" value="${WCParam.resultCatEntryType}" />
												<c:param name="pageSize" value="${WCParam.pageSize}" />
												<c:param name="searchTerm" value="${WCParam.searchTerm}" />
												<c:param name="beginIndex" value="${WCParam.beginIndex}" />			
												<c:param name="sType" value="${WCParam.sType}" />			
											</c:when>
										</c:choose>
									</c:if>								
								</c:url>
								<c:set var="phoneWithNoSpace" value="${fn:trim(physicalStores[i].locationInfo.telephone1.value)}" />
								<c:set var="physicalStoreId" value="${physicalStores[i].physicalStoreIdentifier.uniqueID}" />
								<c:url var="mRemoveFromStoreList" value="mRemoveFromStoreList">
									<c:param name="storeId" value="${WCParam.storeId}" />
									<c:param name="langId" value="${WCParam.langId}" />
									<c:param name="catalogId" value="${WCParam.catalogId}" />
									<c:param name="productId" value="${WCParam.productId}" />
									<c:if test="${!empty WCParam.pgGrp}">
										<c:param name="pgGrp" value="${WCParam.pgGrp}" />
										<c:choose>
											<c:when test="${WCParam.pgGrp == 'catNav'}">
												<c:param name="categoryId" value="${WCParam.categoryId}" />
												<c:param name="parent_category_rn" value="${WCParam.parent_category_rn}" />
												<c:param name="top_category" value="${WCParam.top_category}" />
												<c:param name="sequence" value="${WCParam.sequence}" />
											</c:when>
											<c:when test="${WCParam.pgGrp == 'search'}">
												<c:param name="resultCatEntryType" value="${WCParam.resultCatEntryType}" />
												<c:param name="pageSize" value="${WCParam.pageSize}" />
												<c:param name="searchTerm" value="${WCParam.searchTerm}" />
												<c:param name="beginIndex" value="${WCParam.beginIndex}" />			
												<c:param name="sType" value="${WCParam.sType}" />			
											</c:when>
										</c:choose>
									</c:if>									
									<c:param name="physicalStoreId" value="${physicalStoreId}" />
									<c:param name="fromPage" value="${fromPage}" />
									<c:if test="${fromPage == 'ShoppingCart'}">
										<c:param name="orderId" value="${orderId}" />
									</c:if>
									<c:param name="refUrl" value="mSelectedStoreListView" />
								</c:url>
								<c:choose>							
									<c:when test="${fromPage == 'ShoppingCart'}">
																	
										<c:set var="invStatus" value="NA" />
										<c:if test="${!empty wcPhysicalStores}">
											<c:set var="storeUniqueId" value="${physicalStores[i].physicalStoreIdentifier.uniqueID}" />	
											<c:set var="k" value="0" />
											<c:forTokens items="${resultPhysicalStoreIds}" delims="," var="resultPhyStoreId">
												<c:if test="${resultPhyStoreId == storeUniqueId}">
													<c:set var="invStatus" value="${resultPhyStoreInvStatusArray[k]}" />
												</c:if>
												<c:set var="k" value="${k+1}" />
											</c:forTokens>
										</c:if>
										<fmt:message var="invMessage" key="INV_STATUS_${invStatus}" bundle="${storeText}" />
										<fmt:message var="availLiClassId" key="status_${invStatus}" bundle="${storeText}" />
	
										<li><div class="radio_container">
										<c:choose>
											<c:when test="${invStatus=='Available' || invStatus=='Backorderable'}">
												<c:choose>
													<c:when test="${!empty pickUpStoreId && pickUpStoreId==physicalStores[i].physicalStoreIdentifier.uniqueID}">
														<input type="radio" name="pickUpAtStoreId" id="store_list_choice_<c:out value="${i}" />" value="<c:out value="${physicalStores[i].physicalStoreIdentifier.uniqueID}" />" checked="checked" />
													</c:when>
													<c:otherwise>
														<input type="radio" name="pickUpAtStoreId" id="store_list_choice_<c:out value="${i}" />" value="<c:out value="${physicalStores[i].physicalStoreIdentifier.uniqueID}" />" />
													</c:otherwise>
												</c:choose>
											</c:when>
											<c:otherwise>
												<input type="radio" name="pickUpAtStoreId" id="store_list_choice_<c:out value="${i}" />" disabled="true" />
											</c:otherwise>
										</c:choose>
										<span class="bold"><label for="store_list_choice_<c:out value="${i}" />"><a href="${fn:escapeXml(mStoreDetailURL)}"><c:out value="${physicalStores[i].description[0].name}" /></a></label></span>
										</div></li>
										<li class="align_with_radio"><p class="<c:out value="${availLiClassId}" />"><img src="${jspStoreImgDir}mobile/images/${invStatus}.gif" width="12" height="12" alt="${invMessage}" /> <c:out value="${invMessage}" /></p></li>
										<li class="align_with_radio"><span class="bullet">&#187; </span><a href="${fn:escapeXml(mRemoveFromStoreList)}"><fmt:message key='MSTLST_REMOVE_STORE' bundle='${storeText}' /></a></li>
									</c:when>
									<c:otherwise>
										<li><span class="bullet">&#187; </span><a href="${fn:escapeXml(mStoreDetailURL)}"><span class="bold"><c:out value="${physicalStores[i].description[0].name}" /></span></a></li>
										<li class="align_with_bullet"><c:out value="${physicalStores[i].locationInfo.address.addressLine[0]}" /></li>
										<li class="align_with_bullet"><c:out value="${physicalStores[i].locationInfo.address.city}" />, <c:out value="${physicalStores[i].locationInfo.address.stateOrProvinceName}" /></li>
										<c:set var="phoneWithCallingFormat" value="${fn:replace(phoneWithNoSpace, '.', '-')}" />
										<li><span class="bullet">&#187; </span><a href="tel:+1-${phoneWithCallingFormat}"><c:out value="${phoneWithNoSpace}" /></a></li>
										<%@ include file="../Snippets/StoreLocator/ViewMap.jspf" %>
										<li><span class="bullet">&#187; </span><a href="${fn:escapeXml(mRemoveFromStoreList)}"><fmt:message key='MSTLST_REMOVE_STORE' bundle='${storeText}' /></a></li>
									</c:otherwise>
								</c:choose>
							</ul>
						</c:forEach>
					</c:when>
					<c:when test="${fromPage == 'ShoppingCart'}">
						<%-- There are stores found in the store list.  Redirect to the store locator. --%>
						<script type="text/javascript">window.location.href="<c:out value="${mStoreLocatorURL}" escapeXml="false"/>"</script>
					</c:when>
				</c:choose>

				<div>
					<fmt:message key="MSTLST_STLOC_ADD" bundle="${storeText}" />
					<p class="paragraph_blurb"><span class="bullet">&#187; </span><a href="${fn:escapeXml(mStoreLocatorURL)}" title="Store Locator"><fmt:message key="MSTLST_STLOC" bundle="${storeText}" /></a></p>
				</div>
				
				<c:choose>				
					<c:when test="${fromPage == 'ShoppingCart'}">
							<input type="hidden" id="storeId_sc" name="storeId" value="${WCParam.storeId}" />
							<input type="hidden" id="langId_sc" name="langId" value="${WCParam.langId}" />
							<input type="hidden" id="catalogId_sc" name="catalogId" value="${WCParam.catalogId}" />
							<input type="hidden" id="fromPage_sc" name="fromPage" value="${fromPage}" />
							<input type="hidden" id="refUrl_sc" name="refUrl" value="mOrderBillingAddressSelection" />
			
							<input type="button" id="continue_checkout" name="continue_checkout" class="input_button_float" onclick="javascript:checkField(this.form);" value="<fmt:message key="MSTLST_CONT_CHECKOUT" bundle="${storeText}" />" />
						</form>
						
						<form name="errorForm" method="get" action="mSelectedStoreListView">
							<input type="hidden" name="orderId" value="${WCParam.orderId}" />
							<input type="hidden" name="storeId" value="${WCParam.storeId}" />
							<input type="hidden" name="langId" value="${WCParam.langId}" />
							<input type="hidden" name="catalogId" value="${WCParam.catalogId}" />
							<input type="hidden" name="fromPage" value="${WCParam.fromPage}" />
							<input type="hidden" name="errorView" value="true" />
						</form>						
					</c:when>
					<c:otherwise>
						<c:choose>
							<c:when test="${fromPage == 'ProductDetails'}">
								<form id="your_store_list_cont_shopping_button" method="post" action="mProductDisplayView">
									<input type="hidden" id="storeId_pd" name="storeId" value="${WCParam.storeId}" />
									<input type="hidden" id="langId_pd" name="langId" value="${WCParam.langId}" />
									<input type="hidden" id="catalogId_pd" name="catalogId" value="${WCParam.catalogId}" />
									<input type="hidden" id="productId_pd" name="productId" value="${WCParam.productId}" />
									
									<c:if test="${!empty WCParam.pgGrp}">
										<input type="hidden" id="pgGrp_pd" name="pgGrp" value="${WCParam.pgGrp}" />
										<c:choose>
											<c:when test="${WCParam.pgGrp == 'catNav'}">
												<input type="hidden" id="categoryId_pd" name="categoryId" value="${WCParam.categoryId}" />
												<input type="hidden" id="parent_category_rn_pd" name="parent_category_rn" value="${WCParam.parent_category_rn}" />
												<input type="hidden" id="top_category_pd" name="top_category" value="${WCParam.top_category}" />
												<input type="hidden" id="sequence_pd" name="sequence" value="${WCParam.sequence}" />
											</c:when>
											<c:when test="${WCParam.pgGrp == 'search'}">
												<input type="hidden" id="resultCatEntryType_pd" name="resultCatEntryType" value="${WCParam.resultCatEntryType}" />
												<input type="hidden" id="pageSize_pd" name="pageSize" value="${WCParam.pageSize}" />
												<input type="hidden" id="searchTerm_pd" name="searchTerm" value="${WCParam.searchTerm}" />
												<input type="hidden" id="sType_pd" name="sType" value="${WCParam.sType}" />
												<input type="hidden" id="beginIndex_pd" name="beginIndex" value="${WCParam.beginIndex}" />
											</c:when>
										</c:choose>
									</c:if>																
									
									<input type="submit" id="continue_shopping" class="input_button_float" value="<fmt:message key='MSTLST_CONT_SHOPPING' bundle='${storeText}' />" />
								</form>
							</c:when>
							<c:otherwise>
								<form id="your_store_list_cont_shopping_button" method="post" action="mIndex">
									<input type="hidden" id="storeId" name="storeId" value="${WCParam.storeId}" />
									<input type="hidden" id="langId" name="langId" value="${WCParam.langId}" />
									<input type="hidden" id="catalogId" name="catalogId" value="${WCParam.catalogId}" />
		
									<input type="submit" id="continue_shopping" class="input_button_float" value="<fmt:message key='MSTLST_CONT_SHOPPING' bundle='${storeText}' />" />
								</form>
							</c:otherwise>
						</c:choose>
					</c:otherwise>
				</c:choose>
			</div>
				
			<%@ include file="../include/FooterDisplay.jspf" %>						
			
		</div>

	<script type="text/javascript">
	//<![CDATA[

		function checkField(form) {
			var storeSelected = false;
			if(form.pickUpAtStoreId != undefined) {
				if (form.pickUpAtStoreId.length == undefined) {
					if (form.pickUpAtStoreId.checked) {
						storeSelected = true;
					}
				}
				else {
					for (i=0; i<form.pickUpAtStoreId.length; i++) {
						if (form.pickUpAtStoreId[i].checked) {
							storeSelected = true;
						}
					}
				}
				
				if (storeSelected) {
					form.submit();
					return;
				}
			}
			document.errorForm.submit();	
		}

	//]]> 
	</script>
		
	</body>
	
</html>

<!-- END SelectedStoreList.jsp -->
