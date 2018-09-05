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

<%-- Retrieve the selected filter option from the context update or URL --%>
<c:set var="filterOption" value="${param.filterOption}"/>

<%-- Indicates whether this is the requisition list pop-up or the requisition list list page --%>
<c:set var="RequisitionListPopup" value="${param.RequisitionListPopup}"/>

<%-- Indicates whether there are requisition lists or not --%>
<c:set var="hideTable" value="false" scope="request"/>

<%-- Give filterOption a default value if it cannot be retrieved --%>
<c:choose>
	<%-- For Pop-up: default the option to show only lists created by user --%>
	<c:when test="${RequisitionListPopup == 'true'}">
		<c:if test="${empty filterOption}">
			<c:set var="filterOption" value="Mylists"/>
		</c:if>
	</c:when>
	<%-- Otherwise, default the option to show all lists --%>
	<c:otherwise>
		<c:if test="${empty filterOption}">
			<c:set var="filterOption" value="All"/>
		</c:if>	
	</c:otherwise>
</c:choose>

<%-- Retrieve the current user information if it does not exist in the URL --%>
<c:if test="${empty person}">
	<wcf:getData type="com.ibm.commerce.member.facade.datatypes.PersonType" var="person" expressionBuilder="findCurrentPerson" scope="request">
		<wcf:param name="accessProfile" value="IBM_All" />
	</wcf:getData>
</c:if>
<c:set var="userId" value="${person.personIdentifier.uniqueID}"/>

<%-- Retrieve all the private requisition lists, no matter what filter option is selected --%>
<wcbase:useBean id="pReqListDB" classname="com.ibm.commerce.order.beans.PRequisitionByMemberIdAndStoreIdListDataBean" scope="page">
	<c:set target="${pReqListDB}" property="dataBeanKeyMemberId" value="${userId}"/>
	<c:set target="${pReqListDB}" property="dataBeanKeyStoreId" value="${WCParam.storeId}"/>
</wcbase:useBean>
<c:set var="privateRequisitionLists" value="${pReqListDB.PRequisitionByMemberIdAndStoreIdList}" />

<%-- Retrieve all shared requisition lists, only if filter option is view all lists --%>
<c:if test="${filterOption == 'All'}">
	<wcbase:useBean id="sReqListDB" classname="com.ibm.commerce.order.beans.SRequisitionByMemberIdAndStoreIdListDataBean" scope="page">
		<c:set target="${sReqListDB}" property="dataBeanKeyMemberId" value="${userId}"/>
		<c:set target="${sReqListDB}" property="dataBeanKeyStoreId" value="${WCParam.storeId}"/>
		<c:set target="${sReqListDB}" property="priorityOwnedLists" value="${true}"/>
	</wcbase:useBean>
	<c:set var="sharedRequisitionLists" value="${sReqListDB.SRequisitionByMemberIdAndStoreIdList}" />	
</c:if>
<%-- Retrieve only the shared requisition lists created by me, only if filter option is Mylists --%>
<c:if test="${filterOption == 'Mylists'}">
	<wcbase:useBean id="sOwnedReqListDB" classname="com.ibm.commerce.order.beans.SRequisitionOwnedByMemberIdAndStoreIdListDataBean" scope="page">
		<c:set target="${sOwnedReqListDB}" property="dataBeanKeyMemberId" value="${userId}"/>
		<c:set target="${sOwnedReqListDB}" property="dataBeanKeyStoreId" value="${WCParam.storeId}"/>
	</wcbase:useBean>
	<c:set var="sharedRequisitionLists" value="${sOwnedReqListDB.SRequisitionOwnedByMemberIdAndStoreIdList}" />
</c:if>

<%-- Check whether there are requisition lists to be displayed or not --%>
<c:if test="${(fn:length(privateRequisitionLists) <= 0) && (fn:length(sharedRequisitionLists) <= 0)}">
	<c:set var="hideTable" value="true"/>
</c:if>	

<%-- Only show a message indicating the table is empty if there are no requisition lists for the selected filter --%>
<c:if test="${hideTable == 'true'}">
	<fmt:message key="REQUISITIONLIST_TABLE_EMPTY" bundle="${storeText}"/>
</c:if>	

<c:set var="requisitionListPerPage" value="${maxOrderItemsPerPage}"/>

<%-- find out how many pages we need in total to display all the requisition lists --%>
<c:set var="totalCount" value="${fn:length(privateRequisitionLists)+fn:length(sharedRequisitionLists)}"/>
<fmt:formatNumber var="totalPages" value="${(totalCount/requisitionListPerPage)+1}"/>
<c:if test="${totalCount%requisitionListPerPage == 0}">
	<fmt:parseNumber var="totalPages" value="${totalCount/requisitionListPerPage}"/>
</c:if>
<fmt:parseNumber var="totalPages" value="${totalPages}" integerOnly="true"/>



<%-- Counts the page number we are drawing in.  --%>
<c:set var="currentPage" value="${WCParam.currentPage}" />
<c:if test="${empty currentPage}">
	<c:set var="currentPage" value="0" />
</c:if>

<c:set var="beginIndex" value="${WCParam.beginIndex}" />
<c:if test="${empty beginIndex}">
	<c:set var="beginIndex" value="0" />
</c:if>

<c:choose>
	<c:when test="${beginIndex == 0}">
		<c:set var="currentPage" value="1" />
	</c:when>
	<c:otherwise>
		<fmt:formatNumber var="currentPage" value="${(beginIndex/requisitionListPerPage)+1}"/>
		<fmt:parseNumber var="currentPage" value="${currentPage}" integerOnly="true"/>
	</c:otherwise>
</c:choose>

<c:choose>
	<c:when test="${beginIndex + requisitionListPerPage >= totalCount}">
		<c:set var="endIndex" value="${totalCount}" />
	</c:when>
	<c:otherwise>
		<c:set var="endIndex" value="${beginIndex + requisitionListPerPage}" />
	</c:otherwise>
</c:choose>


<%-- End:  Calculate amount of entries to be shown --%>



<c:set var="prev" value="${beginIndex - requisitionListPerPage}"/>
<c:set var="next" value="${beginIndex + requisitionListPerPage}"/>

<%-- Only show the requisition list table if there are existing requisition lists --%>
<c:if test="${hideTable == 'false'}">
	
	<div id="requisition_list_table_paging">
		<span class="text">
				<fmt:message key="REQUISITION_LIST_RESULTS_DISPLAYING" bundle="${storeText}"> 
					<fmt:param><fmt:formatNumber value="${beginIndex + 1}"/></fmt:param>
					<fmt:param><fmt:formatNumber value="${endIndex}"/></fmt:param>
					<fmt:param><fmt:formatNumber value="${totalCount}"/></fmt:param>
				</fmt:message>
				<c:if test="${totalPages > 1}">
					<span class="paging">
						<c:if test="${beginIndex > 0}">
							<a id="requisition_list_table_paging_prev" href="javaScript:setCurrentId('requisition_list_table_paging_prev');RequisitionList.setBeginIndex('<c:out value="${prev}"/>');">
						</c:if>
						<img src="<c:out value="${jspStoreImgDir}${vfileColorBIDI}" />paging_back.png" alt="<fmt:message key="CATEGORY_PAGING_LEFT_IMAGE" bundle="${storeText}"/>" />		
						<c:if test="${beginIndex > 0}">
							</a>
						</c:if> 
					
						<fmt:message key="CATEGORY_RESULTS_PAGES_DISPLAYING" bundle="${storeText}"> 
							<fmt:param><fmt:formatNumber value="${currentPage}"/></fmt:param>
							<fmt:param><fmt:formatNumber value="${totalPages}"/></fmt:param>
						</fmt:message>
						
						<c:if test="${totalCount > endIndex}">
							<a id="requisition_list_table_paging_next" href="javaScript:setCurrentId('requisition_list_table_paging_next');RequisitionList.setBeginIndex('<c:out value="${next}"/>');">
						</c:if>
						
						<img src="<c:out value="${jspStoreImgDir}${vfileColorBIDI}" />paging_next.png" alt="<fmt:message key="CATEGORY_PAGING_RIGHT_IMAGE" bundle="${storeText}"/>" />					
						<c:if test="${totalCount > endIndex}">
							</a>
						</c:if>
				 	</span>
				</c:if>
		</span>
	</div>
	<%-- Display the requisition lists according to the selected filter option --%>
	<div role="grid" id="requisition_list_table" class="requisition_list_table" aria-describedby="requisition_list_table_summary">
		<%-- This is the hidden table summary used for Accessibility --%>
		<div id="requisition_list_table_summary" class="hidden_summary">
			<fmt:message key="REQUISITION_LIST_TABLE_SUMMARY" bundle="${storeText}"/>
		</div>
				 
		<div role="row" class="ul column_heading">
			 <div role="columnheader" class="li name_column" id="RequisitionList_Name"><fmt:message key="REQUISITIONLIST_TABLE_NAME" bundle="${storeText}"/></div>
			 <div role="columnheader" class="li created_by_column" id="RequisitionList_Owner"><fmt:message key="REQUISITIONLIST_TABLE_CREATEDBY" bundle="${storeText}"/></div>
		     <div role="columnheader" class="li last_updated_column" id="RequisitionList_Date"><fmt:message key="REQUISITIONLIST_TABLE_LASTUPDATED" bundle="${storeText}"/></div>
		     <div role="columnheader" class="li type_column" id="RequisitionList_Type"><fmt:message key="REQUISITIONLIST_TABLE_TYPE" bundle="${storeText}"/></div>
		     <div role="columnheader" class="li actions_column" id="RequisitionList_Action"><span class="spanacce"><fmt:message key="REQUISITION_LIST_ACCE_BUTTON_COLUMN" bundle="${storeText}"/></span></div>
		     <div class="li clear_float"></div>
		</div>
		
		<c:set var="currentItemCount" value="0" />
		<%-- Loop through all the private requisition lists and display them in the table --%>	
		<c:forEach var="requisitionListP" items="${privateRequisitionLists}" varStatus="istat">		
			<c:set var="currentItemCount" value="${currentItemCount + 1}" />
			<c:if test="${(beginIndex+1 <= currentItemCount) && (endIndex >= currentItemCount)}">	
					<%-- Display the name of the requisition list creator according to locale --%>
					<c:choose>
						<c:when test="${locale eq 'ja_JP' || locale eq 'ko_KR' || locale eq 'zh_CN' || locale eq 'zh_TW'}">
							<c:set var="createdBy" value="${requisitionListP.userRegistrationDataBean.lastName} ${requisitionListP.userRegistrationDataBean.firstName}"/>
						</c:when>
						<c:otherwise>
							<c:set var="createdBy" value="${requisitionListP.userRegistrationDataBean.firstName} ${requisitionListP.userRegistrationDataBean.lastName}"/>
						</c:otherwise>
					</c:choose>
					
					<div role="row" class="ul row">
					<%-- Display a link with the requisition list name and link to the details page --%>
					<div role="gridcell" class="li name_column" id="WC_RequisitionListTableDisplay_TableCell_1_1_<c:out value="${istat.count}"/>">
						<flow:ifEnabled feature="AjaxMyAccountPage">
							<%-- using c:url here because wcf:url encodes double characters, which causes them to show up incorrectly --%>
							<c:url var="reqListUpdateUrl" value="AjaxRequisitionListCreateView">
								<c:param name="requisitionListId" value="${requisitionListP.orderId}"/>
								<c:param name="storeId" value="${WCParam.storeId}"/>
								<c:param name="catalogId" value="${WCParam.catalogId}"/>
								<c:param name="langId" value="${WCParam.langId}"/>
								<c:param name="editable" value="true"/>
								<c:param name="createdBy" value="${createdBy}"/>
							</c:url>					
							<a class="link" href="javascript: RequisitionList.setCreatedBy('${createdBy}');MyAccountDisplay.loadContentFromURL('WC_RequisitionListTableDisplay_Link_2_<c:out value='${istat.count}'/>', '<c:out value='${reqListUpdateUrl}' />');" id="WC_RequisitionListTableDisplay_Link_2_<c:out value="${istat.count}"/>"><c:out value="${requisitionListP.description}"/></a>
						</flow:ifEnabled>
						<flow:ifDisabled feature="AjaxMyAccountPage">
							<c:url var="reqListUpdateUrl" value="RequisitionListDetailView" >
								<c:param name="requisitionListId" value="${requisitionListP.orderId}"/>
								<c:param name="storeId" value="${WCParam.storeId}"/>
								<c:param name="catalogId" value="${WCParam.catalogId}"/>
								<c:param name="langId" value="${WCParam.langId}"/>
								<c:param name="editable" value="true"/>
								<c:param name="createdBy" value="${createdBy}"/>								
							</c:url>				
							<a class="link" href="<c:out value="${reqListUpdateUrl}"/>" id="WC_RequisitionListTableDisplay_Link_2_<c:out value="${istat.count}"/>"><c:out value="${requisitionListP.description}"/></a>
						</flow:ifDisabled>				
					</div>
					
					<div role="gridcell" class="li created_by_column" id="WC_RequisitionListTableDisplay_TableCell_1_2_<c:out value="${istat.count}"/>"><c:out value="${createdBy}"/></div>					
					<div role="gridcell" class="li last_updated_column" id="WC_RequisitionListTableDisplay_TableCell_1_3_<c:out value="${istat.count}"/>"><c:out value="${requisitionListP.formattedLastUpdate}"/></div>
					<div role="gridcell" class="li type_column" id="WC_RequisitionListTableDisplay_TableCell_1_4_<c:out value="${istat.count}"/>">
						<img title="<fmt:message key="REQUISITIONLIST_TYPE_PRIVATE" bundle="${storeText}"/>" src="<c:out value="${jspStoreImgDir}${vfileColor}"/>private.gif" alt="<fmt:message key="REQUISITIONLIST_TYPE_PRIVATE" bundle="${storeText}"/>"/>
					</div>
					
					<%-- Display the delete link for all requisition lists created by the user  --%>
					<div role="gridcell" class="li actions_column" id="WC_RequisitionListTableDisplay_TableCell_1_5_<c:out value="${istat.count}"/>">
						<flow:ifEnabled feature="AjaxMyAccountPage">
							<a href="javascript:RequisitionList.deleteRequisitionList('<c:out value="${requisitionListP.orderId}"/>','<c:out value="${filterOption}"/>');" id="WC_RequisitionListTableDisplay_Link_3_<c:out value="${istat.count}"/>">
							<img src="<c:out value="${jspStoreImgDir}${vfileColor}"/>delete.gif" alt="<fmt:message key="DELETE" bundle="${storeText}"/>"/>
							<fmt:message key="DELETE" bundle="${storeText}" />
							</a>
						</flow:ifEnabled>				
						<flow:ifDisabled feature="AjaxMyAccountPage">
							<wcf:url var="reqListDelUrl" value="RequisitionListDelete">
								<wcf:param name="URL" value="RequisitionListDisplayView"/>
								<wcf:param name="requisitionListId" value="${requisitionListP.orderId}"/>
								<wcf:param name="storeId" value="${WCParam.storeId}"/>
								<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
								<wcf:param name="langId" value="${WCParam.langId}"/>
								<wcf:param name="filterOption" value="${filterOption}"/>
							</wcf:url>
							<a href="<c:out value="${reqListDelUrl}"/>" id="WC_RequisitionListTableDisplay_Link_3_<c:out value="${istat.count}"/>">
							<img src="<c:out value="${jspStoreImgDir}${vfileColor}"/>delete.gif" alt="<fmt:message key="DELETE" bundle="${storeText}"/>"/>
							<fmt:message key="DELETE" bundle="${storeText}" />
							</a>
						</flow:ifDisabled>
					</div>
					<div class="li clear_float"></div>
				</div>		
			</c:if>						
		</c:forEach>
		
		<%-- Loop through all the shared requisition lists and display them in the table only if the private requisition lists have been shown--%>
		<c:if test="${currentItemCount >= (fn:length(privateRequisitionLists))}">
			<c:forEach var="requisitionListSAll" items="${sharedRequisitionLists}" varStatus="istat">
				<c:set var="currentItemCount" value="${currentItemCount + 1}" />
				<c:if test="${(beginIndex+1 <= currentItemCount) && (endIndex >= currentItemCount)}">
					<%-- Display the name of the requisition list creator according to locale --%>
					<c:choose>
						<c:when test="${locale eq 'ja_JP' || locale eq 'ko_KR' || locale eq 'zh_CN' || locale eq 'zh_TW'}">
							<c:set var="createdBy" value="${requisitionListSAll.userRegistrationDataBean.lastName} ${requisitionListSAll.userRegistrationDataBean.firstName}"/>
						</c:when>
						<c:otherwise>
							<c:set var="createdBy" value="${requisitionListSAll.userRegistrationDataBean.firstName} ${requisitionListSAll.userRegistrationDataBean.lastName}"/>
						</c:otherwise>
					</c:choose>
						
					<div class="ul row">
						<%-- Display a link with the requisition list name and link to the details page --%>
						<div class="li name_column" id="WC_RequisitionListTableDisplay_TableCell_2_1_<c:out value="${istat.count}"/>">
							<flow:ifEnabled feature="AjaxMyAccountPage">
								<c:url var="reqListUpdateUrl" value="AjaxRequisitionListCreateView">
									<c:param name="requisitionListId" value="${requisitionListSAll.orderId}" />
									<c:param name="storeId" value="${WCParam.storeId}"/>
									<c:param name="catalogId" value="${WCParam.catalogId}"/> 
									<c:param name="langId" value="${WCParam.langId}"/> 
									<c:param name="editable" value="${userId eq requisitionListSAll.memberId}"/>
									<c:param name="createdBy" value="${createdBy}"/>
								</c:url>
								<%-- saving the creator's name in Javascript, so it can be retrieved in the requisition list detail page --%>		
								<a class="link" href="javascript:RequisitionList.setCreatedBy('${createdBy}');MyAccountDisplay.loadContentFromURL('WC_RequisitionListTableDisplay_Link_4_<c:out value='${istat.count}'/>', '<c:out value='${reqListUpdateUrl}' />');" id="WC_RequisitionListTableDisplay_Link_4_<c:out value="${istat.count}"/>"><c:out value="${requisitionListSAll.description}"/></a>
							</flow:ifEnabled>
							<flow:ifDisabled feature="AjaxMyAccountPage">
								<c:url var="reqListUpdateUrl" value="RequisitionListDetailView">
									<c:param name="requisitionListId" value="${requisitionListSAll.orderId}" />
									<c:param name="storeId" value="${WCParam.storeId}"/>
									<c:param name="catalogId" value="${WCParam.catalogId}"/> 
									<c:param name="langId" value="${WCParam.langId}"/> 
									<c:param name="editable" value="${userId eq requisitionListSAll.memberId}"/>
									<c:param name="createdBy" value="${createdBy}"/>	
								</c:url>			
								<a class="link" href="<c:out value="${reqListUpdateUrl}"/>" id="WC_RequisitionListTableDisplay_Link_4_<c:out value="${istat.count}"/>"><c:out value="${requisitionListSAll.description}"/></a>
							</flow:ifDisabled>					
						</div>										
																	
						<div class="li created_by_column" id="WC_RequisitionListTableDisplay_TableCell_2_2_<c:out value="${istat.count}"/>"><c:out value="${createdBy}"/></div>						
						<div class="li last_updated_column" id="WC_RequisitionListTableDisplay_TableCell_2_3_<c:out value="${istat.count}"/>"><c:out value="${requisitionListSAll.formattedLastUpdate}"/></div>
						<div class="li type_column" id="WC_RequisitionListTableDisplay_TableCell_2_4_<c:out value="${istat.count}"/>">
							<img title="<fmt:message key="REQUISITIONLIST_TYPE_SHARED" bundle="${storeText}"/>" src="<c:out value="${jspStoreImgDir}${vfileColor}"/>shared.gif" alt="<fmt:message key="REQUISITIONLIST_TYPE_SHARED" bundle="${storeText}"/>"/>
						</div>
						
						<%-- Display the delete link for all requisition lists created by the user --%>		 
						<c:choose>
							<c:when test="${userId eq requisitionListSAll.memberId}" >
								<div class="li actions_column" id="WC_RequisitionListTableDisplay_TableCell_2_5_<c:out value="${istat.count}"/>">
									<flow:ifEnabled feature="AjaxMyAccountPage">
										<a href="javascript:RequisitionList.deleteRequisitionList('<c:out value="${requisitionListSAll.orderId}"/>','<c:out value="${filterOption}"/>');" id="WC_RequisitionListTableDisplay_Link_5_<c:out value="${istat.count}"/>">
											<img src="<c:out value="${jspStoreImgDir}${vfileColor}"/>delete.gif" alt="<fmt:message key="DELETE" bundle="${storeText}"/>"/>
											<fmt:message key="DELETE" bundle="${storeText}" />
										</a>
									</flow:ifEnabled>				
									<flow:ifDisabled feature="AjaxMyAccountPage">
										<wcf:url var="reqListDelUrl" value="RequisitionListDelete">
											<wcf:param name="URL" value="RequisitionListDisplayView"/>
											<wcf:param name="requisitionListId" value="${requisitionListSAll.orderId}" />
											<wcf:param name="storeId" value="${WCParam.storeId}"/>   
											<wcf:param name="catalogId" value="${WCParam.catalogId}"/>                            	
											<wcf:param name="langId" value="${WCParam.langId}"/>
											<wcf:param name="filterOption" value="${filterOption}"/>             	                         	
										</wcf:url>
										<a href="<c:out value="${reqListDelUrl}"/>" id="WC_RequisitionListTableDisplay_Link_5_<c:out value="${istat.count}"/>">
											<img src="<c:out value="${jspStoreImgDir}${vfileColor}"/>delete.gif" alt="<fmt:message key="DELETE" bundle="${storeText}"/>"/>
											<fmt:message key="DELETE" bundle="${storeText}" />
										</a>
									</flow:ifDisabled>					
								</div>
							</c:when>
							<c:otherwise>
								<div class="li" id="WC_RequisitionListTableDisplay_TableCell_2_6_<c:out value="${istat.count}"/>">&nbsp</div>                            
							</c:otherwise>
						</c:choose>
						<div class="li clear_float"></div>
					</div>	
				</c:if>			
			</c:forEach>
		</c:if>
	</div>
</c:if>