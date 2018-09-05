<%
/*
 *-------------------------------------------------------------------
 * Licensed Materials - Property of IBM
 *
 * WebSphere Commerce
 *
 * (c) Copyright International Business Machines Corporation. 2001, 2004
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
  * This JSP page displays a list of draft RFQs for adding additional
  * products or price adjustment categories.
  *
  * Elements:  
  * - list of draft RFQs
  * - Add button
  *
  * Imports:
  * - AddToExistRFQListDisplay_RFQ_Row.jsp
  *
  * Required parameters:
  * - categoryId
  * - catentryid
  * - productId
  * - orderId
  * - isContract
  *
  *****
--%> 
<%@ page import="java.util.*" %>

<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="flow.tld" prefix="flow" %>

<%@ include file="../../include/JSTLEnvironmentSetup.jspf" %>


<%@ include file="RFQModifyConstants.jspf" %>
                                          
<c:set var="categId" value="${WCParam.categoryId}" />
<c:set var="addCategoryId" value="${WCParam.categoryId}" scope="request" />
<c:set var="catentryid" value="${WCParam.catentryid}" />
<c:set var="productId" value="${WCParam.productId}" />	
<c:set var="isContract" value="${WCParam.isContract}" scope="request" />       
<c:set var="orderId" value="${WCParam.orderId}" scope="request" />     
<c:set var="catid" value="${WCParam.catentryid}" scope="request" /> 
	

	
<c:if test="${empty catid}" >
<c:set var="catid" value="${WCParam.productId}" scope="request" /> 
</c:if>
 
 <c:choose>
	<c:when test="${pageScope.lang <= -7 and pageScope.lang >= -10}">
		<c:set var="wrap" value="nowrap" scope="request" />
	</c:when>
	<c:otherwise>
		<c:set var="wrap" value="" scope="request" />
	</c:otherwise>
</c:choose> 

<wcbase:useBean id="rfq" classname="com.ibm.commerce.utf.beans.RFQListBean" scope="page">
<jsp:setProperty property="*" name="rfq" />
<c:set target="${rfq}" property="storeId" value="${storeId}" />
<c:set target="${rfq}" property="ownerId" value="${userId}" />
<c:set target="${rfq}" property="state" value="${EC_STATE_DRAFT}" />				 
</wcbase:useBean> 
 
<c:set var="rlist" value="${rfq.RFQs}" scope="request" />


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="en">
<head>
<title><fmt:message key="AddToExistRFQList_Title" bundle="${storeText}" /></title>
<link rel="stylesheet"	href="<c:out value="${jspStoreImgDir}${vfileStylesheet}"/>"	type="text/css" />
<meta name="GENERATOR" content="IBM WebSphere Studio"/>
</head>

<body class="noMargin"> 
<%@ include file="../../include/LayoutContainerTop.jspf"%>

<flow:ifEnabled feature="customerCare">
	<c:set var="liveHelpPageType" value="personal" />
</flow:ifEnabled>
                                                              
<table border="0" cellpadding="0" cellspacing="0" width="790" height="99%" id="WC_AddToExistRFQListDisplay_Table_1">
	<tbody>
		<tr>
			<td valign="top" width="630" id="WC_AddToExistRFQListDisplay_TableCell_2">

			<!--content start-->

			<table cellpadding="0" cellspacing="0" border="0" width="620" id="WC_AddToExistRFQListDisplay_Table_2">
				<tbody>
					<tr>
						<td rowspan="3" id="WC_AddToExistRFQListDisplay_TableCell_3">&nbsp;</td>
						<td id="WC_AddToExistRFQListDisplay_TableCell_4">
						<h1><fmt:message key="AddToExistRFQList_Title" bundle="${storeText}" /></h1>
						</td>
					</tr>
					<tr>
						<td id="WC_AddToExistRFQListDisplay_TableCell_5"><fmt:message key="AddToExistRFQList_Instruction" bundle="${storeText}" /><br />
						
						<form name="RFQListForm" action="RFQItemAdd" method="post" id="WC_AddToExistRFQListDisplay_Form_1" >
						 
						<table cellpadding="0" cellspacing="0" border="0" width="100%" class="bgColor" id="WC_AddToExistRFQListDisplay_Table_3">
							<tbody>
								<tr>
									<td id="WC_AddToExistRFQListDisplay_TableCell_6">

									<input type="hidden" name="<c:out value="${EC_OFFERING_CATENTRYID}"/>" value="<c:out value="${catid}"/>" id="WC_AddToExistRFQListDisplay_FormInput_<c:out value="${EC_OFFERING_CATENTRYID}"/>_In_RFQListForm_1"/>
									<input type="hidden" name="langId" value="<c:out value="${langId}" />" id="WC_AddToExistRFQListDisplay_FormInput_langId_In_RFQListForm_1"/>
									<input type="hidden" name="storeId" value="<c:out value="${storeId}" />" id="WC_AddToExistRFQListDisplay_FormInput_storeId_In_RFQListForm_1"/>
									<input type="hidden" name="catalogId" value="<c:out value="${catalogId}" />" id="WC_AddToExistRFQListDisplay_FormInput_catalogId_In_RFQListForm_1"/>
									<table width="100%" border="0" cellpadding="2" cellspacing="1" class="bgColor" id="WC_AddToExistRFQListDisplay_Table_4">

										<input type="hidden" name="<c:out value="${EC_OFFERING_CURRENCY}"/>" value="<c:out value="${sdb.storeDefaultCurrency}"/>" id="WC_AddToExistRFQListDisplay_FormInput_<c:out value="${EC_OFFERING_CURRENCY}"/>_In_RFQListForm_1"/>
										<tbody>
											<tr>
												<th id="a1" valign="top" <c:out value="${wrap}='{wrap}'" /> class="colHeader" id="WC_AddToExistRFQListDisplay_TableCell_7"></th>
												<th id="a2" valign="top" <c:out value="${wrap}='{wrap}'" /> class="colHeader" id="WC_AddToExistRFQListDisplay_TableCell_8"><fmt:message key="AddToExistRFQList_Name" bundle="${storeText}" /></th>
												<th id="a3" valign="top" <c:out value="${wrap}='{wrap}'" /> class="colHeader" id="WC_AddToExistRFQListDisplay_TableCell_9"><fmt:message key="AddToExistRFQList_Desc" bundle="${storeText}" /></th>		
												<th id="a4" valign="top" <c:out value="${wrap}='{wrap}'" /> class="colHeader" id="WC_AddToExistRFQListDisplay_TableCell_10"><fmt:message key="AddToExistRFQList_Creation" bundle="${storeText}" /></th>
												<th id="a5" valign="top" <c:out value="${wrap}='{wrap}'" /> class="colHeader" id="WC_AddToExistRFQListDisplay_TableCell_11"><fmt:message key="AddToExistRFQList_Submission" bundle="${storeText}" /></th>
												<th id="a6" valign="top" <c:out value="${wrap}='{wrap}'" /> class="colHeader" id="WC_AddToExistRFQListDisplay_TableCell_12"><fmt:message key="AddToExistRFQList_Rounds" bundle="${storeText}" /></th>
												<th id="a7" valign="top" <c:out value="${wrap}='{wrap}'" /> class="colHeader_last" id="WC_AddToExistRFQListDisplay_TableCell_13"><fmt:message key="AddToExistRFQList_Attachment" bundle="${storeText}" /></th>	
						<c:if test="${empty addCategoryId }" >
												<label for="a8">
												<th id="a8" valign="top" <c:out value="${wrap}='{wrap}'" /> class="colHeader" id="WC_AddToExistRFQListDisplay_TableCell_14"><fmt:message key="RFQDisplay_Product_Category" bundle="${storeText}" /></th>
												</label>
												<th id="a9" valign="top" <c:out value="${wrap}='{wrap}'" /> class="colHeader_last" id="WC_AddToExistRFQListDisplay_TableCell_15">&nbsp;</th>
											</tr>
						</c:if>
											
<!-- Display RFQs -->   							 				
						<c:set var="color" value="cellBG_2" />
						<c:set var="count" value="0" scope="request" />	
						
						<c:set var="countContract" value="0" scope="request" />
						
						<c:forEach var="rfqL" items="${rlist}" begin="0" varStatus="iter">
						<c:if test="${rfqL.storeIdInEJBType eq storeId}">
							<c:choose>
								<c:when test="${color eq 'cellBG_1'}">
									<c:set var="color" value="cellBG_2" /> 
								</c:when>
								<c:otherwise>
									<c:set var="color" value="cellBG_1" />
								</c:otherwise>
							</c:choose>
							<c:set var="rfqBean" value="${rfqL}" scope="request" />
								<% out.flush(); %>					
								<c:import url="AddToExistRFQListDisplay_RFQ_Row.jsp" > 
									<c:param name="index" value="${iter.index}" /> 
									<c:param name="color" value="${color}" />									
								</c:import>
							  	<% out.flush(); %>
							  	</c:if>
						</c:forEach>
						
						
						<c:set var="count" value="${counter}" />
						
<!-- end Display RFQs -->   
    					<input type="hidden" name="cIdval" value="" >					
											
<c:if test="${!empty rlist}" >		 								
 
			<input type="hidden" name="<c:out value="${EC_OFFERING_ID}" />" value="" id="WC_AddToExistRFQListDisplay_FormInput_<c:out value="${EC_OFFERING_ID}" />_In_RFQListForm_1"/>
</c:if>

<c:choose> 
<c:when test="${!empty addCategoryId}" >
			<input type="hidden" name="categoryId" value="" id="WC_AddToExistRFQListDisplay_FormInput_categoryId_In_RFQListForm_1"/>				
			<input type="hidden" name="addCategoryId" value="<c:out value="${addCategoryId}" />" />				
			<input type="hidden" name="URL" value="RFQModifyDisplay" id="WC_AddToExistRFQListDisplay_FormInput_URL_In_RFQListForm_1"/>											 
</c:when>
<c:otherwise> 
			<input type="hidden" name="<c:out value="${EC_OFFERING_NEGOTIATIONTYPE}" />" value="1" />						 
			<input type="hidden" name="productId" value="<c:out value="${productId}" />" id="WC_AddToExistRFQListDisplay_FormInput_productId_In_RFQListForm_1"/>
			<input type="hidden" name="orderId" value="<c:out value="${requestScope.orderId}" />" id="WC_AddToExistRFQListDisplay_FormInput_orderId_In_RFQListForm_1"/>
			<input type="hidden" name="categoryId" value="" id="WC_AddToExistRFQListDisplay_FormInput_categoryId_In_RFQListForm_1"/>
			<input type="hidden" name="URL" value="RFQModifyDisplay" id="WC_AddToExistRFQListDisplay_FormInput_URL_In_RFQListForm_1"/>
</c:otherwise>
</c:choose>
											                                          
 										</tbody>
									</table>		 							
									
									</td>
								</tr>
							</tbody>
						</table>						
						
						</form>						
						
					</td>
				</tr>
				

<c:choose>		
<c:when test="${empty rlist }" >		
		<tr>		
		<td class="t_td" id="WC_AddToExistRFQListDisplay_TableCell_26"><span class="warning"><fmt:message key="AddToExistRFQList_NoRFQs" bundle="${storeText}" /></span></td>
		</tr>	
</c:when>
<c:when test="${isContract == 'true' and countContract lt '1'}" >
		<tr>		
			<td class="t_td" id="WC_AddToExistRFQListDisplay_TableCell_26">
				<span class="warning">
					<fmt:message key="AddToExistRFQList_NoContractRFQs" bundle="${storeText}" />
				</span>
			</td>
		</tr>
</c:when>
<c:otherwise>
		<tr>
					<td id="WC_AddToExistRFQListDisplay_TableCell_27">
					<table id="WC_AddToExistRFQListDisplay_Table_14">
						<tbody>
							<tr>	
<!-- Start display for button "RFQModifyDisplay_Add_Attach" -->
<td height="41" id="WC_AddToExistRFQListDisplay_TableCell_28">
<a class="button" href="#" onclick="Add2RFQ(document.RFQListForm); return false;" id="WC_AddToExistRFQListDisplay_Link_2"> &nbsp; <fmt:message key="RFQModifyDisplay_Add_Attach" bundle="${storeText}" /> &nbsp; 
</a>
</td>
<!-- End display for button ... -->
							</tr>
						</tbody>
					</table>
					</td>
				</tr>

</c:otherwise>
</c:choose>

		



				<tr>
					<td id="WC_AddToExistRFQListDisplay_TableCell_29">&nbsp;</td>
				</tr>
				</tbody>
			</table>
			<!--content end--></td>
		</tr></tbody>
</table>                       
 

<script language="javascript"> 
	var busy = false;
	function Add2RFQ(form) {
		if (!busy) {			
			n = <c:choose><c:when test="${count eq null or count eq ''}">0</c:when><c:otherwise><c:out value="${count}" /></c:otherwise></c:choose>;
			for (i = 0; i < n; i++) {
				if (document.RFQListForm.offering_id[i].checked) {
					rfqId = document.RFQListForm.offering_id[i].value;									
				}				
			}  			
			form.categoryId.value = document.RFQListForm.cIdval.value;					
			busy = true;
			
			addCategoryId = '<c:out value="${addCategoryId}" />';
			if (addCategoryId != null && addCategoryId != '')
			{	
				form.categoryId.value = addCategoryId;
				form.action = 'RFQPriceAdjustmentOnCategoryAdd';		
			}
			form.submit();	 	
			
		} 
	} 
	function updateRadioButton(i, val, rfqId) {		
		document.RFQListForm.offering_id[i-1].checked = true;
		document.RFQListForm.cIdval.value = val;
		
	}

</script>

<%@ include file="../../include/LayoutContainerBottom.jspf"%>
</body>
</html>
