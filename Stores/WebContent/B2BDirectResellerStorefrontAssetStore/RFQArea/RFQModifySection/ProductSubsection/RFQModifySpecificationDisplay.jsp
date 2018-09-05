<%
/*
 *-------------------------------------------------------------------
 * Licensed Materials - Property of IBM
 *
 * WebSphere Commerce
 *
 * (c) Copyright International Business Machines Corporation. 2000, 2004
 *     All rights reserved.
 *
 * US Government Users Restricted Rights - Use, duplication or
 * disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
 *
 *-------------------------------------------------------------------
 */ 
%>
<%--
  *****
  * This JSP page displays a list of RFQ product specifications.
  *
  * Imports:
  * - RFQModifySpecificationDisplay_JS.jsp
  * - RFQModifySpecificationsDisplay_Attributes_Row.jsp
  *
  * Required parameters:
  * - offering_id
  * - catalogId
  * - productId
  * - catentryid
  * - rfqprod_id
  * - storeId
  * - langId
  *
  *****
--%>

<%@ page language="java" %>

<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf" %>



 
<c:set var="catalogId" value="${WCParam.catalogId}" />
<c:set var="productId" value="${WCParam.productId}" />
<c:set var="rfqId" value="${WCParam.offering_id}" scope="request" />
<c:set var="catId" value="${WCParam.catentryid}" scope="request" />
<c:set var="rfqprodId" value="${WCParam.rfqprod_id}" scope="request" />

<c:set var="EC_OFFERING_ID" value="offering_id" scope="request" />
<c:set var="EC_OFFERING_CATENTRYID" value="catentryid" scope="request" />
<c:set var="EC_RFQ_PRODUCT_ID" value="rfqprod_id" scope="request" />  

<wcbase:useBean id="bnError" classname="com.ibm.commerce.beans.ErrorDataBean" scope="request">
</wcbase:useBean>
<c:if test="${bnError.exceptionType != null}">
	<c:set var="strErrorMessage" value="${bnError.message}" />
</c:if>

<c:choose>
<c:when test="${productId != null}">
	<c:set var="returnToCatalog" value="ProductDisplay?storeId=${storeId}&langId=${langId}&catalogId=${catalogId}&productId=${productId}"  />	
	<fmt:message key="RFQList_Button_CatalogReturn" bundle="${storeText}"  var="catalogButtonText" />
</c:when>
<c:otherwise>
	<c:set var="returnToCatalog" value="TopCategoriesDisplay?storeId=${storeId}&langId=${langId}&catalogId=${catalogId}"  />	
	<fmt:message key="RFQList_Button_Catalog" bundle="${storeText}" var="catalogButtonText" />
</c:otherwise>
</c:choose>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" lang="en">

<head> 


<wcbase:useBean id="rfqProduct" classname="com.ibm.commerce.utf.beans.RFQProdDataBean">
	<jsp:setProperty property="*" name="rfqProduct"/>
	<c:set target="${rfqProduct}" property="RFQProdId" value="${rfqprodId}" />	
</wcbase:useBean>
<c:set var="plist" value="${rfqProduct.allAttributesWithValuesForProduct}" scope="request" />
<c:set var="pcomment" value="${rfqProduct.productCommentsForProduct}" scope="request" />


<title><fmt:message key="RFQModifySpecificationDisplay_Title" bundle="${storeText}" /></title>
<link rel="stylesheet"	href="<c:out value="${jspStoreImgDir}${vfileStylesheet}"/>"	type="text/css" />
<meta name="GENERATOR" content="IBM WebSphere Studio"/>

<% out.flush(); %> 
<c:import url="RFQModifySpecificationDisplay_JS.jsp" />
<% out.flush(); %>
</head>

<body class="noMargin">
<%@ include file="../../../include/LayoutContainerTop.jspf"%>


	<table border="0" cellpadding="0" cellspacing="0" width="790" height="99%" id="WC_RFQModifySpecificationDisplay_Table_1">
		<tr>
			<td valign="top" width="630" id="WC_RFQModifySpecificationDisplay_TableCell_2">

				<table cellpadding="2" cellspacing="0" width="630" border="0"  id="WC_RFQModifySpecificationDisplay_Table_2">
					<tr>
                        <td  valign="top" colspan="3" class="categoryspace" id="WC_RFQModifySpecificationDisplay_TableCell_3">
					<h1><fmt:message key="RFQModifySpecificationDisplay_RFQSpec" bundle="${storeText}" /></h1>

<c:if test="${strErrorMessage != null}">
				<span class="warning"><c:out value="${strErrorMessage}"/></span><br /><br />
</c:if>	 


						</td>
					</tr>
					<tr>
						<td id="WC_RFQModifySpecificationDisplay_TableCell_4"><fmt:message key="RFQExtra_ModSpec" bundle="${storeText}" /></td>
					</tr>

					<tr>

						<td  valign="top" width="1000" class="topspace" id="WC_RFQModifySpecificationDisplay_TableCell_5">

						<form name="RFQModifySpecificationForm" action="RFQItemSpecificationUpdate" method="post" id="RFQModifySpecificationForm">
						<input type="hidden" name="<c:out value="${EC_OFFERING_ID}" />" value="<c:out value="${rfqId}" />" id="WC_RFQModifySpecificationDisplay_FormInput_<c:out value="${EC_OFFERING_ID}" />_In_RFQModifySpecificationForm_1"/>
						<input type="hidden" name="<c:out value="${EC_OFFERING_CATENTRYID}" />" value="<c:out value="${catId}" />" id="WC_RFQModifySpecificationDisplay_FormInput_<c:out value="${EC_OFFERING_CATENTRYID}" />_In_RFQModifySpecificationForm_1"/>
						<input type="hidden" name="<c:out value="${EC_RFQ_PRODUCT_ID}" />" value="<c:out value="${rfqprodId}" />" id="WC_RFQModifySpecificationDisplay_FormInput_<c:out value="${EC_RFQ_PRODUCT_ID}" />_In_RFQModifySpecificationForm_1"/>
						<input type="hidden" name="langId" value="<c:out value="${langId}" />" id="WC_RFQModifySpecificationDisplay_FormInput_langId_In_RFQModifySpecificationForm_1"/>
						<input type="hidden" name="storeId" value="<c:out value="${storeId}" />" id="WC_RFQModifySpecificationDisplay_FormInput_storeId_In_RFQModifySpecificationForm_1"/>
						<input type="hidden" name="catalogId" value="<c:out value="${catalogId}" />" id="WC_RFQModifySpecificationDisplay_FormInput_catalogId_In_RFQModifySpecificationForm_1"/>
 
							<table cellpadding="0" cellspacing="0" border="0" width="1000" class="bgColor" id="WC_RFQModifySpecificationDisplay_Table_3">
								<tr>
									<td id="WC_RFQModifySpecificationDisplay_TableCell_6">
										<table width="100%" border="0" cellpadding="2" cellspacing="1" class="bgColor" id="WC_RFQModifySpecificationDisplay_Table_4">
											<tr>
												<th id="a1" valign="center"  class="colHeader"><fmt:message key="RFQModifySpecificationDisplay_Name" bundle="${storeText}" /></th>
												<th id="a2" valign="center"  class="colHeader"><fmt:message key="RFQModifySpecificationDisplay_Op" bundle="${storeText}" /></th>
												<th id="a3" valign="center"  class="colHeader"><fmt:message key="RFQModifySpecificationDisplay_Value" bundle="${storeText}" /></th>
												<th id="a4" valign="center"  class="colHeader"><fmt:message key="RFQModifySpecificationDisplay_Unit" bundle="${storeText}" /></th>
												<th id="a5" valign="center"  class="colHeader"><fmt:message key="RFQModifySpecificationDisplay_Man" bundle="${storeText}" /></th>
												<th id="a6" valign="center"  class="colHeader"><fmt:message key="RFQModifySpecificationDisplay_Change" bundle="${storeText}" /></th>
												<th id="a7" class="colHeader_last">&nbsp;</th>
											</tr>
 
								<%--iterate  through list of AllAttributesWithValuesForProduct--%>
											<c:set var="color" value="cellBG_2" />
											<c:set var="count" value="0" scope="request" />						
											
											<c:forEach items="${plist}" begin="0" varStatus="iter">
												<c:choose>
													<c:when test="${color eq 'cellBG_1'}">
														<c:set var="color" value="cellBG_2" />
													</c:when>  
													<c:when test="${color eq 'cellBG_2'}">
														<c:set var="color" value="cellBG_1" />
													</c:when> 
												</c:choose> 
												<tr class="<c:out value="${color}" />">
													<% out.flush(); %>
													<c:import url="RFQModifySpecificationsDisplay_Attributes_Row.jsp" >														
														<c:param name="index" value="${iter.index}" />											
																											
													</c:import>
													<% out.flush(); %>
												</tr>
											</c:forEach>
								<%--end iterate  through list of AllAttributesWithValuesForProduct--%>
											<c:if test="${empty plist}">
												<tr class="cellBG_1">
													<td  valign="top" colspan="8" class="categoryspace t_td" id="WC_RFQModifySpecificationDisplay_TableCell_34" ><fmt:message key="RFQModifySpecificationDisplay_NoSpec" bundle="${storeText}" /></td>
												</tr>
											</c:if>


										</table>

									</td>
								</tr>
							</table>

					<input type="hidden" name="numSpec" value="<c:out value="${requestScope.numSpec}" />" id="WC_RFQModifySpecificationDisplay_FormInput_numSpec_In_RFQModifySpecificationForm_1"/>
					<input type="hidden" name="URL" value="RFQModifySpecificationDisplay" id="WC_RFQModifySpecificationDisplay_FormInput_URL_In_RFQModifySpecificationForm_1"/>
					</form>

					</td> 

					<td width="10" rowspan="2" id="WC_RFQModifySpecificationDisplay_TableCell_24">&nbsp;</td>
			</tr>

			<tr>
				<td span="7" id="WC_RFQModifySpecificationDisplay_TableCell_25"><fmt:message key="RFQModifyAddSpecificationDisplay_MultiValue" bundle="${storeText}" /></td>
			</tr>

			<tr>
				<td id="WC_RFQModifySpecificationDisplay_TableCell_26">&nbsp;</td>
			</tr>

			<tr>
			<td id="WC_RFQModifySpecificationDisplay_TableCell_27">

			<table id="WC_RFQModifySpecificationDisplay_Table_5">
			<tbody>
			<tr>

<!-- Start display for button "RFQModifySpecificationDisplay_Add" -->
<td height="41" id="WC_RFQModifySpecificationDisplay_TableCell_28">
<a class="button" href="RFQModifyAddSpecificationDisplay?<c:out value="${EC_OFFERING_ID}" />=<c:out value="${rfqId}" />&<c:out value="${EC_OFFERING_CATENTRYID}" />=<c:out value="${catId}" />&<c:out value="${EC_RFQ_PRODUCT_ID}" />=<c:out value="${rfqprodId}" />&langId=<c:out value="${langId}" />&storeId=<c:out value="${storeId}" />&catalogId=<c:out value="${catalogId}" />" id="WC_RFQModifySpecificationDisplay_Link_3"> &nbsp; <fmt:message key="RFQModifySpecificationDisplay_Add" bundle="${storeText}" /> &nbsp;
</a>
</td>
<!-- End display for button ... -->
<c:set var="numSpec" value="${requestScope.numSpec}" />

<c:if test="${numSpec != 0}" >
<!-- Start display for button "RFQModifySpecificationDisplay_Update" -->
<td height="41" id="WC_RFQModifySpecificationDisplay_TableCell_29">
<a class="button" href="javascript:submitUpdate(document.RFQModifySpecificationForm)" id="WC_RFQModifySpecificationDisplay_Link_4">	&nbsp; <fmt:message key="RFQModifySpecificationDisplay_Update" bundle="${storeText}" /> &nbsp;
</a>
</td>
<!-- End display for button ... -->
</c:if>					

<!-- Start display for button "RFQModifySpecificationDisplay_Return" -->
<td height="41" id="WC_RFQModifySpecificationDisplay_TableCell_30">
<a class="button" href="RFQModifyDisplay?<c:out value="${EC_OFFERING_ID}" />=<c:out value="${rfqId}" />&langId=<c:out value="${langId}" />&storeId=<c:out value="${storeId}" />&catalogId=<c:out value="${catalogId}" />" id="WC_RFQModifySpecificationDisplay_Link_5"> &nbsp; <fmt:message key="RFQModifySpecificationDisplay_Return" bundle="${storeText}" /> &nbsp;
</a>
</td>
<!-- End display for button ... -->
 
			</tr>
			</table>

</td> 
</tr>
<tr><td id="WC_RFQModifySpecificationDisplay_TableCell_31">&nbsp;</td></tr>
				</table>
 
<!--FINISH MAIN CONTENT-->
			</td>
		</tr>
	</table>

<%@ include file="../../../include/LayoutContainerBottom.jspf"%>
	</body>
</html>

