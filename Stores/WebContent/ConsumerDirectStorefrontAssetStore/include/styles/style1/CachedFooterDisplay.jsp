<%
//********************************************************************
//*-------------------------------------------------------------------
//* Licensed Materials - Property of IBM
//*
//* WebSphere Commerce
//*
//* (c) Copyright IBM Corp. 2000, 2003, 2004
//*
//* US Government Users Restricted Rights - Use, duplication or
//* disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
//*
//*-------------------------------------------------------------------
//*
%>

<%--
  *****
  * This is included at the bottom of the page. It contains common links at the bottom 
  * of the page which are similar to the header.
  * This is an example of how this file could be included into a page: 
  *<c:import url="${jspStoreDir}${StyleDir}CachedFooterDisplay.jsp">
  *          <c:param name="storeId" value="${storeId}"/>
  *          <c:param name="catalogId" value="${catalogId}"/>
  *          <c:param name="langId" value="${langId}"/>
  *          <c:param name="userType" value="${userType}"/>
  *      </c:import>
  *****
--%>
<!-- Start - JSP File name:  style1/CachedFooterDisplay.jsp -->

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../JSTLEnvironmentSetup.jspf"%>
<flow:fileRef id="vfileBanner" fileId="vfile.banner"/>
<flow:fileRef id="vfileSelectedBanner" fileId="vfile.selectedBanner"/>

<c:url var="TopCategoriesDisplayURL" value="TopCategoriesDisplay">
	<c:param name="langId" value="${langId}" />
	<c:param name="storeId" value="${WCParam.storeId}" />
	<c:param name="catalogId" value="${WCParam.catalogId}" />
</c:url>				
<c:url var="OrderCalculateURL" value="OrderCalculate">
	<c:param name="URL" value="OrderItemDisplay" />
	<c:param name="langId" value="${langId}" />						
	<c:param name="storeId" value="${WCParam.storeId}" />
	<c:param name="catalogId" value="${WCParam.catalogId}" />
	<c:param name="updatePrices" value="1" />
	<c:param name="calculationUsageId" value="-1" />
	<c:param name="orderId" value="." />
</c:url>								
<c:url var="LogonFormURL" value="LogonForm">
	<c:param name="langId" value="${langId}" />
	<c:param name="storeId" value="${WCParam.storeId}" />
	<c:param name="catalogId" value="${WCParam.catalogId}" />
</c:url>				
<c:url var="ContactViewURL" value="ContactView">
	<c:param name="langId" value="${langId}" />
	<c:param name="storeId" value="${WCParam.storeId}" />
	<c:param name="catalogId" value="${WCParam.catalogId}" />
</c:url>
<c:url var="HelpViewURL" value="HelpView">
	<c:param name="langId" value="${langId}" />
	<c:param name="storeId" value="${WCParam.storeId}" />
	<c:param name="catalogId" value="${WCParam.catalogId}" />
</c:url>
<c:url var="PrivacyViewURL" value="PrivacyView">
	<c:param name="langId" value="${langId}" />
	<c:param name="storeId" value="${WCParam.storeId}" />
	<c:param name="catalogId" value="${WCParam.catalogId}" />
</c:url>
<c:url var="interestItemDisplayURL" value="InterestItemDisplay">
	<c:param name="storeId"   value="${WCParam.storeId}"  />
	<c:param name="catalogId" value="${WCParam.catalogId}"/>
	<c:param name="langId" value="${langId}" />
	<c:param name="listId" value="." />
</c:url>													
<c:url var="requisitionListDisplayURL" value="RequisitionListDisplay">
	<c:param name="storeId"   value="${WCParam.storeId}"  />
	<c:param name="catalogId" value="${WCParam.catalogId}"/>
	<c:param name="langId" value="${langId}" />
	<c:param name="listId" value="." />
</c:url>

<!--START FOOTER-->
<table cellpadding="0" cellspacing="0" border="0" width="100%" align="center" id="WC_CachedFooterDisplay_Table_1">
	<tbody><tr>
		<td valign="top" id="WC_CachedFooterDisplay_TableCell_1" class="f_back">
			<table align="center" cellpadding="0" cellspacing="0" border="0" class="p_width" id="WC_CachedFooterDisplay_Table_2">
				<tr>
					<td valign="top" id="WC_CachedFooterDisplay_TableCell_2">
						<table cellpadding="0" cellspacing="0" border="0" id="WC_CachedFooterDisplay_Table_3">
							<tr>
								<td class="f_padding">
									<table cellpadding="0" cellspacing="0" border="0" id="WC_CachedFooterDisplay_Table_4">
										<tr>
											<td class="f_title" id="WC_CachedFooterDisplay_TableCell_3">
												<fmt:message key="CUSTOMER_SERVICE" bundle="${storeText}" />
											</td>
										</tr>
										<flow:ifEnabled  feature="wishList">
										<tr>
											<td id="WC_CachedFooterDisplay_TableCell_5">
												<a href="<c:out value="${interestItemDisplayURL}"/>" class="f_link" id="WC_CachedFooterDisplay_Link_2"><fmt:message key="WISH_LIST2" bundle="${storeText}" /></a>
											</td>
										</tr>
										</flow:ifEnabled>
										<flow:ifEnabled  feature="RequisitionList">
										<tr>
											<td id="WC_CachedFooterDisplay_TableCell_5">
												<a href="<c:out value="${requisitionListDisplayURL}"/>" class="f_link" id="WC_CachedFooterDisplay_Link_2"><fmt:message key="REQ_LIST" bundle="${storeText}" /></a>
											</td>
										</tr>
										</flow:ifEnabled>
										<tr>
											<td id="WC_CachedFooterDisplay_TableCell_6">
												<a href="<c:out value="${LogonFormURL}"/>" class="f_link" id="WC_CachedFooterDisplay_Link_3"><fmt:message key="MY_ACCOUNT2" bundle="${storeText}" /></a>
											</td>
										</tr>
									</table>
								</td>
								<td class="f_padding" id="WC_CachedFooterDisplay_Table_7">
									<table cellpadding="0" cellspacing="0" border="0" id="WC_CachedFooterDisplay_Table_5">
										<tr>
											<td class="f_title" id="WC_CachedFooterDisplay_TableCell_8">
												<fmt:message key="CUSTOMER_SUPPORT" bundle="${storeText}" />
											</td>
										</tr>
										<tr>
											<td id="WC_CachedFooterDisplay_TableCell_9">
												<a href="<c:out value="${PrivacyViewURL}"/>" class="f_link" id="WC_CachedFooterDisplay_Link_4"><fmt:message key="PRIVACY_POLICY" bundle="${storeText}" /></a>
											</td>
										</tr>
										<tr>
											<td id="WC_CachedFooterDisplay_TableCell_10">
												<a href="<c:out value="${ContactViewURL}"/>" class="f_link" id="WC_CachedFooterDisplay_Link_5"><fmt:message key="CONTACT_US2" bundle="${storeText}" /></a>
											</td>
										</tr>
										<tr>
											<td id="WC_CachedFooterDisplay_TableCell_11">
												<a href="<c:out value="${HelpViewURL}"/>" class="f_link" id="WC_CachedFooterDisplay_Link_6"><fmt:message key="HELP2" bundle="${storeText}" /></a>
											</td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
					</td>
					<td align="right" id="WC_CachedFooterDisplay_TableCell_12">
					<flow:ifEnabled  feature="CustomBanner">
						<img src="<c:out value="${storeImgDir}${vfileBanner}" />" alt="" width="228" height="80" border="0"/>
					</flow:ifEnabled>
					<flow:ifDisabled  feature="CustomBanner">
						<img src="<c:out value="${jspStoreImgDir}${vfileSelectedBanner}" />" alt="" width="228" height="80" border="0"/>
					</flow:ifDisabled>
					</td>
					<%-- <img src="<c:out value="${jspStoreImgDir}" />images/f_watermark1.gif" alt="" width="228" height="80" border="0"> --%>
				</tr>
			</table>
		</td>
	</tr>
</tbody>
</table>
<!--END FOOTER-->

<!-- End - JSP File name:  style1/CachedFooterDisplay.jsp -->