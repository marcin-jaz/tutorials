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
  * This JSP page displays detailed information about a Requisition List.
  *
  * Required parameters:
  * - offering_id
  * - catentryid
  * - requisitionListId
  * - catalogId
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

<c:set var="EC_OFFERING_ID" value="offering_id" scope="request" />
<c:set var="EC_OFFERING_CATENTRYID" value="catentryid" scope="request" />

<c:set var="rfqId" value="${param[EC_OFFERING_ID]}" scope="request" />
<c:set var="requisitionListId" value="${param.requisitionListId}" />
<c:set var="Catalogs" value="${sdb.storeCatalogs}" scope="request" />
<c:set var="catalogId" value="${Catalogs[0].catalogId}"  />

<wcbase:useBean id="orderDB" classname="com.ibm.commerce.order.beans.OrderDataBean" scope="request">
	<jsp:setProperty property="*" name="orderDB"/>         
	<c:set property="orderId" value="${requisitionListId}" target="${orderDB}" />                        
</wcbase:useBean>  

<c:set var="orderItemCount" value="${orderDB.numberOfOrderItems}" />

<c:set var="strNewPartNumber" value=""  />
<c:set var="strNewQuantity" value=""  /> 
<c:set var="strQuantity" value=""  />
<c:set var="strErrorCode" value=""  />

<wcbase:useBean id="bnError" classname="com.ibm.commerce.beans.ErrorDataBean" scope="request">
</wcbase:useBean>

<c:if test="${bnError.exceptionType != null}">
	<c:set var="strErrorMessage" value="${bnError.message}" />
	<c:set var="strNewPartNumber" value="${param.partNumber}" />
	<c:set var="strNewQuantity" value="${param.strNewQuantity}" />
</c:if>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="en">
<head>

<title><fmt:message key="RFQRequisitionListDisplay_AddProdFromReq" bundle="${storeText}" /></title>
<link rel="stylesheet"	href="<c:out value="${jspStoreImgDir}${vfileStylesheet}"/>" type="text/css" />
	
<script language="javascript">
	function CA(form)
	{
		if (form.checkAll.checked) {
			if (form.numProd.value > 1) {
				for (var i = 0; i < form.numProd.value; i++) {
					form.catentryid[i].checked = true;
				}
			} else {
				form.catentryid.checked = true;
			}
		} else {
			if (form.numProd.value > 1) {
				for (var i = 0; i < form.numProd.value; i++) {
					form.catentryid[i].checked = false;
				}
			} else {
				form.catentryid.checked = false;
			}
		}
	}
	function submitAdd(form)
	{
		if (form.numProd.value == 1)
		{
			if (form.catentryid.checked != true)
			{
				error("<fmt:message key="RFQModifyAddProductDisplay_Error1" bundle="${storeText}" />");
				return;
			}
			form.submit();
			return;
		}
		else
		{
			for (var i = 0; i < form.numProd.value; i++) {
				if (form.catentryid[i].checked) {
					form.submit();
					return;
				}
			}
			error("<fmt:message key="RFQModifyAddProductDisplay_Error1" bundle="${storeText}" />");
			return;
		}
	}
	function error(errMsg)
	{
		alert(errMsg);
	}	
	function Add2ReqList(form)
	{
  		form.quantity.value = form.strNewQuantity.value;
  		if (form.strNewQuantity.value == "") {
			form.quantity.value = "1";
  		}
  		form.submit();
	}
</script>

</head>

<body class="noMargin">
<%@ include file="../../../include/LayoutContainerTop.jspf"%>

<flow:ifEnabled feature="customerCare">
	<c:set var="liveHelpPageType" value="personal" />
</flow:ifEnabled>

<table border="0" cellpadding="0" cellspacing="0" width="790" height="99%" id="WC_RFQRequisitionListDisplay_Table_1">

<tr>
	<td valign="top" width="630" id="WC_RFQRequisitionListDisplay_TableCell_2">

	<!--content start-->
	<c:if test="${strErrorMessage != null}">
		<p><span class="warning"><c:out value="${strErrorMessage}"/></span><br /><br /></p>
	</c:if>

	<table border="0" cellpadding="8" cellspacing="0" width="605" id="WC_RFQRequisitionListDisplay_Table_2">
	<tr>
		<td id="WC_RFQRequisitionListDisplay_TableCell_3">
			<table id="WC_RFQRequisitionListDisplay_Table_3">
				<tr>
					<td id="WC_RFQRequisitionListDisplay_TableCell_4">
						<h1><fmt:message key="RFQRequisitionListDisplay_AddProdFromReq" bundle="${storeText}" /></h1>
					</td>
				</tr>
				<tr>
					<td id="WC_RFQRequisitionListDisplay_TableCell_5">
						<strong><fmt:message key="Editreq_Text1" bundle="${storeText}" /></strong>&nbsp;&nbsp;
						<c:out value="${orderDB.description}" />
					</td>
				</tr>
			</table>
		</td>
	</tr>
	</table>

	<table border="0" cellpadding="8" cellspacing="0" width="605" id="WC_RFQRequisitionListDisplay_Table_4">
	<tr>
		<td id="WC_RFQRequisitionListDisplay_TableCell_6">
			<table cellpadding="0" cellspacing="0" border="0" width="605" class="bgColor" id="WC_RFQRequisitionListDisplay_Table_5">
				<tr>
					<td id="WC_RFQRequisitionListDisplay_TableCell_7">
						<table width="100%" border="0" cellpadding="2" cellspacing="1" class="bgColor" id="WC_RFQRequisitionListDisplay_Table_6">

							<form name="addForm" action="RFQItemAdd" method="post" id="addForm">
							<input type="hidden" name="storeId" value="<c:out value="${storeId}" />" id="WC_RFQRequisitionListDisplay_FormInput_storeId_In_addForm_1"/>
							<input type="hidden" name="langId" value="<c:out value="${langId}" />" id="WC_RFQRequisitionListDisplay_FormInput_langId_In_addForm_1"/>
							<input type="hidden" name="catalogId" value="<c:out value="${catalogId}" />" id="WC_RFQRequisitionListDisplay_FormInput_catalogId_In_addForm_1"/>
							<input type="hidden" name="<c:out value="${EC_OFFERING_ID}" />" value="<c:out value="${rfqId}" />" id="WC_RFQRequisitionListDisplay_FormInput_<c:out value="${EC_OFFERING_ID}" />_In_addForm_1"/>

							<c:set var="defaultCurrency" value="${sdb.storeDefaultCurrency}" scope="page" />

							<input type="hidden" name="currency" value="<c:out value="${defaultCurrency}" />" id="WC_RFQRequisitionListDisplay_FormInput_currency_In_addForm_1"/>
							<input type="hidden" name="numProd" value="<c:out value="${orderItemCount}" />" id="WC_RFQRequisitionListDisplay_FormInput_numProd_In_addForm_1"/>
							<input type="hidden" name="URL" value="RFQModifyDisplay?<c:out value="${OFFERING_CATENTRYID}" />=" id="WC_RFQRequisitionListDisplay_FormInput_URL_In_addForm_1"/>

							<tr>
			                                	<th id="a1" valign="top" class="colHeader" id="WC_RFQRequisitionListDisplay_TableCell_8">
			                                		<label for="WC_RFQRequisitionListDisplay_FormInput_checkAll_In_addForm_1"></label>
			                                		<input type="checkbox" class="checkbox" name="checkAll" onclick="javascript:CA(document.addForm);" id="WC_RFQRequisitionListDisplay_FormInput_checkAll_In_addForm_1" />
			                                		
								</th>			
								<th id="a2" valign="top" class="colHeader" id="WC_RFQRequisitionListDisplay_TableCell_10"><fmt:message key="Editreq_Col2" bundle="${storeText}" /></th>
								<th id="a3" valign="top" class="colHeader" id="WC_RFQRequisitionListDisplay_TableCell_11"><fmt:message key="Editreq_Col1" bundle="${storeText}" /></th>
								<th id="a4" valign="top" class="colHeader" id="WC_RFQRequisitionListDisplay_TableCell_12"><fmt:message key="Editreq_Col3" bundle="${storeText}" /></th>
								<th id="a5" class="colHeader" id="WC_RFQRequisitionListDisplay_TableCell_13"><fmt:message key="Editreq_Col4" bundle="${storeText}" /></th>
								<th id="a6" valign="top" class="colHeader_last" id="WC_RFQRequisitionListDisplay_TableCell_14"><fmt:message key="Editreq_Col5" bundle="${storeText}" /></th>
							</tr>
							
						<c:set var="color" value="cellBG_2" />	
						
						<c:forEach var="orderItem" items="${orderDB.orderItemDataBeans}" begin="0" varStatus="iter">	
							<c:set var="index" value="${iter.index}" />
							<c:set var="catid" value="${orderItem.catalogEntryIdInEJBType}" />
							<c:set var="itemdesc" value="${orderItem.itemDataBean.description.shortDescription}"  /> 
							<c:set var="quantity" value="${orderItem.formattedQuantity}"  />
						
							<c:choose> 
								<c:when test="${color == 'cellBG_1'}">
									<c:set var="color" value="cellBG_2" />
								</c:when>  
								<c:when test="${color == 'cellBG_2'}">
									<c:set var="color" value="cellBG_1" />
								</c:when>
							</c:choose>  
	 
							<tr> 	 
								<td headers="a1_<c:out value="${index+1}" />" class="<c:out value="${color}" /> t_td" id="WC_RFQRequisitionListDisplay_TableCell_15_<c:out value="${index+1}" />">
									<label for="WC_RFQRequisitionListDisplay_FormInput_<c:out value="${EC_OFFERING_CATENTRYID}" />_In_addForm_1_<c:out value="${index+1}" />"></label>
									<input type="checkbox" class="checkbox" name="<c:out value="${EC_OFFERING_CATENTRYID}" />" value="<c:out value="${orderItem.catalogEntryId}" />" id="WC_RFQRequisitionListDisplay_FormInput_<c:out value="${EC_OFFERING_CATENTRYID}" />_In_addForm_1_<c:out value="${index+1}" />" />
									
								</td>
								<td headers="a2_<c:out value="${index+1}" />" class="<c:out value="${color}" /> t_td" id="WC_RFQRequisitionListDisplay_TableCell_16_<c:out value="${index+1}" />">
									<c:out value="${quantity}" />
								</td>
								<td headers="a3_<c:out value="${index+1}" />" class="<c:out value="${color}" /> t_td" id="WC_RFQRequisitionListDisplay_TableCell_17_<c:out value="${index+1}" />">
									<c:out value="${orderItem.partNumber}" />
								</td>
								<td headers="a4_<c:out value="${index+1}" />" class="<c:out value="${color}" /> t_td" id="WC_RFQRequisitionListDisplay_TableCell_18_<c:out value="${index+1}" />">
									<a href="ProductDisplay?catalogId=<c:out value="${catalogId}" />&storeId=<c:out value="${storeId}" />&productId=<c:out value="${orderItem.catalogEntryId}" />&langId=<c:out value="${langId}" />" id="WC_RFQRequisitionListDisplay_Link_1_<c:out value="${index+1}" />">
										<c:out value="${itemdesc}" />
									</a>
								</td>
								<td headers="a5_<c:out value="${index+1}" />" class="<c:out value="${color}" /> t_td" id="WC_RFQRequisitionListDisplay_TableCell_19_<c:out value="${index+1}" />">
									<c:out value="${orderItem.itemDataBean.manufacturerName}" />
								</td>
								<td headers="a6_<c:out value="${index+1}" />" class="<c:out value="${color}" /> t_td" id="WC_RFQRequisitionListDisplay_TableCell_20_<c:out value="${index+1}" />">
									<c:out value="${orderItem.itemDataBean.manufacturerPartNumber}" />
								</td>
							</tr>					
						</c:forEach>	
							</form>
						</table>
					</td>
				</tr>
			</table>

		<wcbase:useBean id="rfqBean" classname="com.ibm.commerce.utf.beans.RFQDataBean" scope="request">
			<jsp:setProperty property="*" name="rfqBean"/>         
			<c:set property="rfqId" value="${rfqId}" target="${rfqBean}" />                        
		</wcbase:useBean> 

		<c:if test="${orderItemCount > 0}" >
			<table border="0" cellpadding="0" cellspacing="2" id="WC_RFQRequisitionListDisplay_Table_13">
				<tr>

					<!-- Start display for button "RFQRequisitionListDisplay_Add" -->
					<td height="41" id="WC_RFQRequisitionListDisplay_TableCell_21">
						<a class="button" href="javascript:submitAdd(document.addForm)" id="WC_RFQRequisitionListDisplay_Link_2">
							<fmt:message key="RFQRequisitionListDisplay_Add" bundle="${storeText}" /> <c:out value="${rfqBean.name}" />
						</a>
					</td>
					<!-- End display for button .... -->

					<td id="WC_RFQRequisitionListDisplay_TableCell_22">&nbsp;&nbsp;</td>

				</tr>
			</table>
		</c:if>

		</td>
	</tr>
	</table>

	<!-- content end -->
	</td>
</tr>
</table>

<%@ include file="../../../include/LayoutContainerBottom.jspf"%>
</body>
</html>
