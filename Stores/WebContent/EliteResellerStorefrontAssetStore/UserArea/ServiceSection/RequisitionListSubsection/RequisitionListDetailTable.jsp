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

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../../include/nocache.jspf" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %> 
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf" %>

<!--  retrieving all the catEntryIds and Quantities from the URL -->
<c:forEach var="parameter" items="${WCParamValues}" >
	<c:if test="${parameter.key == 'catEntryId'}">
		<c:set var="catEntryIDs" value="${parameter.value}"/>
	</c:if>
	<c:if test="${parameter.key == 'quantity'}">
		<c:set var="quantities" value="${parameter.value}"/>
	</c:if>
</c:forEach>
			
<c:set var="requisitionListId" value="${WCParam.requisitionListId}"/>

<%-- Retrieve the orderId from saved orders or current order --%>
<c:set var="orderId" value="${WCParam.orderId}"/>

<c:set var="pageSize" value="${maxOrderItemsPerPage}"/>	
<%-- Index to begin the order item paging with --%>
<c:set var="beginIndex" value="${WCParam.beginIndex}" />
<c:if test="${empty beginIndex}">
	<c:set var="beginIndex" value="0" />
</c:if> 

<c:if test="${not empty requisitionListId}">
	<wcf:getData type="com.ibm.commerce.order.facade.datatypes.OrderType"
	var="order" expressionBuilder="findByOrderIdWithPagingOnItem" varShowVerb="ShowVerbSummary" maxItems="${pageSize}" recordSetStartNumber="${beginIndex}">
		<wcf:param name="orderId" value="${requisitionListId}"/>
		<wcf:param name="accessProfile" value="IBM_Details" />
		<wcf:param name="sortOrderItemBy" value="orderItemID" />
	</wcf:getData>	
</c:if>

<c:if test="${empty requisitionListId && !empty orderId}">
	<wcf:getData type="com.ibm.commerce.order.facade.datatypes.OrderType"
	var="order" expressionBuilder="findByOrderIdWithPagingOnItem" varShowVerb="ShowVerbSummary" maxItems="${pageSize}" recordSetStartNumber="${beginIndex}">
		<wcf:param name="orderId" value="${orderId}"/>
		<wcf:param name="accessProfile" value="IBM_Details" />
		<wcf:param name="sortOrderItemBy" value="orderItemID" />
	</wcf:getData>		
</c:if>	

<c:set var="numEntries" value="${ShowVerbSummary.recordSetTotal}"/>

<wcf:url var="requisitionListDetailTablePaging" value="RequisitionListDetailTableView" type="Ajax">
	<wcf:param name="storeId"   value="${WCParam.storeId}"  />
	<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
	<wcf:param name="langId" value="${WCParam.langId}" />
	<wcf:param name="editable" value="${WCParam.editable}" />
	<c:if test="${!empty requisitionListId}">  
		<wcf:param name="requisitionListId" value="${requisitionListId}" />
	</c:if> 
	<c:if test="${!empty orderId}">  
		<wcf:param name="orderId" value="${orderId}" />
	</c:if> 	
</wcf:url>

<fmt:formatNumber var="totalPages" value="${(numEntries/pageSize)}"/>		
<c:if test="${numEntries%pageSize < (pageSize/2)}">
	<fmt:parseNumber var="totalPages" value="${(numEntries+(pageSize/2)-1)/pageSize}"/>
</c:if>
<fmt:parseNumber var="totalPages" value="${totalPages}" integerOnly="true"/> 
	
<c:choose>
	<c:when test="${beginIndex + pageSize >= numEntries}">
		<c:set var="endIndex" value="${numEntries}" />
	</c:when>
	<c:otherwise>
		<c:set var="endIndex" value="${beginIndex + pageSize}" />
	</c:otherwise>
</c:choose>

<fmt:formatNumber var="currentPage" value="${(beginIndex/pageSize)+1}"/>
<fmt:parseNumber var="currentPage" value="${currentPage}" integerOnly="true"/>


<c:choose>
	<c:when test="${!empty order.orderItem}">
		<c:if test="${empty requisitionListId}">
			<div>
				<fmt:message key="REQUISITION_LIST_NEW_ITEMS_TO_ADD" bundle="${storeText}"/>
			</div>
		</c:if>
		<div id="requisition_list_table_paging" class="requisitionListBorder_top">
			<span class="text">
					<fmt:message key="CATEGORY_RESULTS_DISPLAYING" bundle="${storeText}"> 
						<fmt:param><fmt:formatNumber value="${beginIndex + 1}"/></fmt:param>
						<fmt:param><fmt:formatNumber value="${endIndex}"/></fmt:param>
						<fmt:param><fmt:formatNumber value="${numEntries}"/></fmt:param>
					</fmt:message>
					<c:if test="${totalPages > 1}">
						<span class="paging">
							<c:if test="${beginIndex != 0}">
			  					<a id="new_requisition_list_table_paging_prev" href="javaScript:setCurrentId('new_requisition_list_table_paging_prev'); 
			  					RequisitionList.pageItemTable('<c:out value='${requisitionListDetailTablePaging}'/>','<c:out value='${beginIndex - pageSize}'/>');">
			  					
			  					
							</c:if>
							<img src="<c:out value="${jspStoreImgDir}${vfileColorBIDI}" />paging_back.png" alt="<fmt:message key="CATEGORY_PAGING_LEFT_IMAGE" bundle="${storeText}"/>" />
							<c:if test="${beginIndex != 0}">
								</a>
							</c:if>
							<fmt:message key="CATEGORY_RESULTS_PAGES_DISPLAYING" bundle="${storeText}"> 
								<fmt:param><fmt:formatNumber value="${currentPage}"/></fmt:param>
								<fmt:param><fmt:formatNumber value="${totalPages}"/></fmt:param>
							</fmt:message>
							<c:if test="${numEntries > endIndex }">
			 					<a id="new_requisition_list_table_paging_next" href="javaScript:setCurrentId('new_requisition_list_table_paging_next'); 
			 					RequisitionList.pageItemTable('<c:out value='${requisitionListDetailTablePaging}'/>','<c:out value='${beginIndex + pageSize}'/>');">
							</c:if>
							<img src="<c:out value="${jspStoreImgDir}${vfileColorBIDI}" />paging_next.png" alt="<fmt:message key="CATEGORY_PAGING_RIGHT_IMAGE" bundle="${storeText}"/>" />
							<c:if test="${numEntries > endIndex }">
								</a>
							</c:if>
					</c:if>
			</span>
		</div>		
		<div id="WC_RequisitionListDetailTable_div_1" class="requisitionListBorder">
			<div role="grid" class="requisition_list_table" id="new_requisition_list_table" aria-describedby="new_requisition_list_table_summary">
				 <%-- This is the hidden table summary used for Accessibility --%>
				 <div id="new_requisition_list_table_summary" class="hidden_summary">
				  	<fmt:message key="REQUISITION_LIST_DETAIL_TABLE_SUMMARY" bundle="${storeText}"/>
					<c:if test="${WCParam.editable == 'true'}">
						<fmt:message key="REQUISITION_LIST_DETAIL_TABLE_SUMMARY_EDITABLE" bundle="${storeText}"/>
					</c:if>
				 </div>
	             <div role="row" class="ul column_heading">
	                  <div id="RequisitionListDetailTable_Name" role="columnheader" class="li description_column"><fmt:message key='REQUISITIONLIST_TABLE_NAME' bundle='${storeText}'/></div>
	                  <div id="RequisitionListDetailTable_SKU" role="columnheader" class="li sku_column"><fmt:message key='SKU' bundle='${storeText}'/></div>
	                  <div id="RequisitionListDetailTable_Quantity" role="columnheader" class="li quantity_column"><fmt:message key='CurrentOrder_QTY' bundle='${storeText}'/></div>
	                  <div id="RequisitionListDetailTable_Manufacturer" role="columnheader" class="li manufacturer_column"><fmt:message key='REQUISITIONLIST_MANUFACTURER' bundle='${storeText}'/></div>
	                  <div id="RequisitionListDetailTable_PartNumber" role="columnheader" class="li part_number_column"><fmt:message key='REQUISITIONLIST_PARTNUM' bundle='${storeText}'/></div>
	                  <div id="RequisitionListDetailTable_Actions" role="columnheader" class="li actions_column"><span class="spanacce"><fmt:message key="REQUISITION_LIST_ACCE_BUTTON_COLUMN" bundle="${storeText}"/></span></div>
	                  <div class="li clear_float"></div>
	             </div>
	             
	             <c:forEach var="orderItem" items="${order.orderItem}" varStatus="istat"> 
					<wcbase:useBean id="catEntry" classname="com.ibm.commerce.catalog.beans.CatalogEntryDataBean" scope="request">
						<c:set property="catalogEntryID" value="${orderItem.catalogEntryIdentifier.uniqueID}" target="${catEntry}" />
					</wcbase:useBean>
					<%-- The URL that links to the display page --%>
					<wcf:url var="catEntryDisplayUrl" value="Product2">
					    <wcf:param name="catalogId" value="${WCParam.catalogId}"/>
					    <wcf:param name="storeId" value="${WCParam.storeId}"/>
					    <wcf:param name="productId" value="${catEntry.catalogEntryID}"/>
					    <wcf:param name="langId" value="${langId}"/>
					    <wcf:param name="errorViewName" value="ProductDisplayErrorView"/>
						<wcf:param name="categoryId" value="${WCParam.categoryId}" />
					</wcf:url>
				             	            
		             <div role="row" class="ul row">
		                  <div id="name_<c:out value="${istat.count+1}"/>" role="gridcell" class="li link description_column">
		                  		<label class="nodisplay" for="name_<c:out value="${istat.count+1}"/>"><fmt:message key="REQUISITIONLIST_TABLE_NAME" bundle="${storeText}"/></label>
		                  		<a class="link" href="<c:out value="${catEntryDisplayUrl}"/>"><c:out value="${catEntry.description.name}" escapeXml="false"/></a>
		                  </div>
		                  <div role="gridcell" class="li sku_column">
		                  		<input type="hidden" id="partNumber_<c:out value="${istat.count+1}"/>" name="<c:out value="partNumber_${istat.count+1}"/>" value="<c:out value="${catEntry.partNumber}"/>" />
		                  		<c:out value="${catEntry.partNumber}" />
	                  	  </div>
		                  <div role="gridcell" class="li quantity_column">
		                  	<fmt:formatNumber var="formattedQuantity" value="${orderItem.quantity.value}" type="number" maxFractionDigits="0"/>
							<c:choose>
								<c:when test="${WCParam.editable == 'true' && !empty requisitionListId}">
									<div id="tooltip_<c:out value="${istat.count+1}"/>">
										<label class="nodisplay" for="<c:out value="quantity_${istat.count+1}"/>"><fmt:message key='ITEM' bundle='${storeText}'/> <c:out value="${istat.count+1}"/> <fmt:message key='CurrentOrder_QTY' bundle='${storeText}'/></label>
			                  			<input onchange="javascript:RequisitionList.addToOrderItemsIdsArray(<c:out value="${istat.count+1}"/>);" type="text" id="<c:out value="quantity_${istat.count+1}"/>" name="<c:out value="quantity_${istat.count+1}"/>" value="<c:out value="${formattedQuantity}"/>" size="4" maxlength="10"/>
			                  			<input type="hidden" id="orderItemId_<c:out value="${istat.count+1}"/>" name="orderItemId_<c:out value="${istat.count+1}"/>" value="<c:out value="${orderItem.orderItemIdentifier.uniqueID}"/>" />
			                  		</div>
		                  		</c:when>
		                  		<c:otherwise>
		                  			<c:out value="${formattedQuantity}" />
		                  			<input type="hidden" id="quantity_<c:out value="${istat.count+1}"/>" name="quantity_<c:out value="${istat.count+1}"/>" value="<c:out value="${formattedQuantity}"/>"/>
		                  		</c:otherwise>
		                  	</c:choose>
		                  </div>
		                  <div role="gridcell" class="li manufacturer_column"><c:out value="${catEntry.manufacturerName}" /></div>
		                  <div role="gridcell" class="li part_number_column"><c:out value="${catEntry.manufacturerPartNumber}" /></div>
		                  <div role="gridcell" class="li actions_column">
		                  	<c:choose>
			                  	<c:when test="${WCParam.editable == 'true' && !empty requisitionListId}">
									<flow:ifEnabled feature="AjaxMyAccountPage">
										<a href="javascript:RequisitionList.deleteRequisitionListItem('<c:out value="${requisitionListId}"/>','<c:out value="${orderItem.orderItemIdentifier.uniqueID}"/>','<c:out value="${WCParam.editable}"/>');" id="WC_RequisitionListDetailTable_Link_5_<c:out value="${istat.count}"/>">
											<img src="<c:out value="${jspStoreImgDir}${vfileColor}"/>table_x_delete.png" alt="<fmt:message key="REMOVE_ITEM" bundle="${storeText}"/>"/>
											<fmt:message key="REMOVE_ITEM" bundle="${storeText}"/>
										</a>
									</flow:ifEnabled>				
									<flow:ifDisabled feature="AjaxMyAccountPage">
										<wcf:url var="reqListItemDelUrl" value="RequisitionListItemUpdate">
											<wcf:param name="URL" value="RequisitionListDetailView"/>
											<wcf:param name="requisitionListId" value="${requisitionListId}" />
											<wcf:param name="orderItemId" value="${orderItem.orderItemIdentifier.uniqueID}"/>
											<wcf:param name="quantity" value="0"/>
											<wcf:param name="storeId" value="${storeId}"/>   
											<wcf:param name="catalogId" value="${catalogId}"/>                            	
											<wcf:param name="langId" value="${langId}"/>
											<wcf:param name="editable" value="${WCParam.editable}"/>
										</wcf:url>
										<a href="<c:out value="${reqListItemDelUrl}"/>" id="WC_RequisitionListDetailTable_Link_5_<c:out value="${istat.count}"/>">
											<img src="<c:out value="${jspStoreImgDir}${vfileColor}"/>table_x_delete.png" alt="<fmt:message key="REMOVE_ITEM" bundle="${storeText}"/>"/>
											<fmt:message key="REMOVE_ITEM" bundle="${storeText}"/>
										</a>
									</flow:ifDisabled>	
								</c:when>		
								<c:otherwise></c:otherwise>
							</c:choose>
                  		 </div>
                  		 <div class="li clear_float"></div>
		             </div>
		             <c:remove var="catEntry"/>	
	             </c:forEach>
			</div>
		</div>
	</c:when>
	<c:when test="${!empty catEntryIDs}">
		<div>
			<fmt:message key="REQUISITION_LIST_NEW_ITEMS_TO_ADD" bundle="${storeText}"/>
		</div>
		<div role="grid" class="requisition_list_table" id="new_requisition_list_table2" aria-describedby="new_requisition_list_table_summary">
			  <%-- This is the hidden table summary used for Accessibility --%>
			  <div id="new_requisition_list_table_summary2" class="hidden_summary">
			  	<fmt:message key="REQUISITION_LIST_DETAIL_TABLE_SUMMARY" bundle="${storeText}"/>
				<c:if test="${WCParam.editable == 'true'}">
					<fmt:message key="REQUISITION_LIST_DETAIL_TABLE_SUMMARY_EDITABLE" bundle="${storeText}"/>
				</c:if>
			  </div>
				 
		      <div role="row" class="ul column_heading">
	             <div role="columnheader" class="li description_column"><fmt:message key='REQUISITIONLIST_TABLE_NAME' bundle='${storeText}'/></div>
	             <div role="columnheader" class="li sku_column"><fmt:message key='SKU' bundle='${storeText}'/></div>
	             <div role="columnheader" class="li quantity_column"><fmt:message key='CurrentOrder_QTY' bundle='${storeText}'/></div>
	             <div role="columnheader" class="li manufacturer_column"><fmt:message key='REQUISITIONLIST_MANUFACTURER' bundle='${storeText}'/></div>
	             <div role="columnheader" class="li part_number_column"><fmt:message key='REQUISITIONLIST_PARTNUM' bundle='${storeText}'/></div>
	             <div class="li actions_column"></div>
	             <div class="li clear_float"></div>
		      </div>
				
			<c:forEach var="catEntryID" items="${catEntryIDs}" varStatus="counter">
				<%-- Get SKU using a catEntryId --%>
				<wcbase:useBean id="catalog" classname="com.ibm.commerce.catalog.beans.CatalogEntryDataBean">
					<c:set property="catalogEntryID" value="${catEntryID}" target="${catalog}" />				
				</wcbase:useBean>
				
				<%-- Catalog data bean is not empty. User must have come from the product detail page.  Display the product detail --%>
					
		          <div role="row" class="ul row">
		          	<div role="gridcell" class="li link description_column"><c:out value="${catalog.description.name }"/></div>          	
		          	<div role="gridcell" class="li sku_column">
		          		<input type="hidden" id="partNumber_${counter.index}" name="partNumber_${counter.index}" value="<c:out value="${catalog.partNumber }"/>"/>
		          		<c:out value="${catalog.partNumber }"/>
		          	</div>
		          	<div role="gridcell" class="li quantity_column">
		          		<input type="hidden" id="quantity_${counter.index}" name="quantity_${counter.index}" value="<c:out value="${quantities[counter.index]}"/>"/>
		          		<c:out value="${quantities[counter.index]}"/>
		          	</div>
		          	<div role="gridcell" class="li manufacturer_column"><c:out value="${catalog.manufacturerName}"/></div>
		          	<div role="gridcell" class="li part_number_column"><c:out value="${catalog.manufacturerPartNumber}"/></div>
		          	<div class="li clear_float"></div>
			     </div>
				<c:remove var="catalog"/>		    
			</c:forEach>		
		</div>
	</c:when>
	<c:otherwise>
		<div class="requisitionListBorder" id="WC_RequisitionListDetailTable_list_empty"><fmt:message key="ERROR_REQUISITION_LIST_ITEMS_EMPTY" bundle="${storeText}"/></div>
	</c:otherwise>
</c:choose>