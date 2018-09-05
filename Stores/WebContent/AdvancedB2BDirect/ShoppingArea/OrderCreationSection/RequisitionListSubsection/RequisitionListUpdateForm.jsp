<%--
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
--%>
<%--
  *****
  * This JSP page displays the Edit Requisition List page with the following elements:
  *	 - 'Requisition list name' field with 'Change Name' button
  *  - 'Type' drop down list with 'Shared' and 'Private' values
  *  - 'SKU' and 'Quantity' fields with 'Add' button
  *  -  List of items in the requisition list. For each item, the following is displayed:
  *			- SKU, Quantity, Description, Manufacturer, Part Number and 'Remove' link
  *			- Description is a link to the Catalog Item Display page for the item
  *  - 'Place Order' button
  *  - 'Update Quantity' button
  *****
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf"%>
<%@ include file="../../../include/ErrorMessageSetup.jspf"%>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>

<c:set var="requisitionListId" value="${WCParam.requisitionListId}" scope="request" />
<wcbase:useBean id="orderDB" classname="com.ibm.commerce.order.beans.OrderDataBean" scope="page">
<c:set target="${orderDB}" property="orderId" value="${requisitionListId}"/>
</wcbase:useBean>


<%-- Page specific error messages --%>
<c:choose>
<c:when test="${'_ERR_PROD_NOT_EXISTING' eq storeError.key}">
	<fmt:message key="Editreq_Error_SKU" var="pageErrorMessage" bundle="${storeText}">
		<fmt:param value="${storeError.messageParameters[0]}"/>
	</fmt:message>
</c:when>
<c:when test="${'_ERR_PROD_NOT_ORDERABLE' eq storeError.key}">
	<fmt:message key="Newreq_SKU_NotOrderable" var="pageErrorMessage" bundle="${storeText}">
		<fmt:param value="${storeError.messageParameters[1]}"/>
	</fmt:message>
</c:when>
<c:when test="${'_ERR_PS_ENTRY_INVALID' eq storeError.key}">
	<fmt:message key="Newreq_Error_SKU" var="pageErrorMessage" bundle="${storeText}">
		<fmt:param value="${storeError.messageParameters[1]}"/>
	</fmt:message>
</c:when>
<c:when test="${'_ERR_INVALID_INPUT' eq storeError.key}">
	<fmt:message key="Editreq_Error_Quantity" var="pageErrorMessage" bundle="${storeText}">
		<fmt:param value="${quantity}"/>
	</fmt:message>
</c:when>
<c:when test="${'_ERR_PROCESSING_BUNDLE' eq storeError.key}">
	<fmt:message key="Editreq_Error_BundleAdd" var="pageErrorMessage" bundle="${storeText}" />
</c:when>
<c:otherwise>
	<c:set var="pageErrorMessage" value="${errorMessage}"/>
</c:otherwise>
</c:choose>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<!-- BEGIN RequisitionListUpdateForm.jsp -->
<head>
<title><fmt:message key="Editreq_Title" bundle="${storeText}"/></title>
<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${vfileStylesheet}"/>" type="text/css"/>
<script language="javascript">

function Add2ReqList(form)
{
 // form.quantity.value = form.strNewQuantity.value;
  //if (form.strNewQuantity.value == "") {
//	form.quantity.value = "1";
 // }
  form.submit();
}

function UpdateReqListName(form)
{

  form.name.value = form.name.value.replace(/^\s+/g, "");
<fmt:message key="Newreq_Error_Name" bundle="${storeText}" var="Newreq_Error_Name"/>
  if (form.name.value == '') {
         alert(<wcf:json object="${Newreq_Error_Name}"/>);
  }
  else {
         form.submit();
  }
}

</script>
</head>
<body class="noMargin">
<flow:ifEnabled feature="customerCare">
<%--
Set header type needed for this JSP for LiveHelp.  This must be set before HeaderDisplay.jsp
--%>
<c:set var="liveHelpPageType" value="personal" scope="request" />
</flow:ifEnabled>
<%@ include file="../../../include/LayoutContainerTop.jspf"%>
      <!--content start-->
    <c:if test="${empty orderDB.organizationId || orderDB.organizationId == CommandContext.activeOrganizationId}">
        <c:if test="${!empty pageErrorMessage}">
			<span class="warning"><c:out value="${pageErrorMessage}"/></span>
		</c:if>
		<table border="0" cellpadding="4" cellspacing="0" width="100%" id="WC_RequisitionListUpdateForm_Table_2">
        <tbody>
          <tr>
            <td id="WC_RequisitionListUpdateForm_TableCell_3">
	          <%--
	          ***
	          * Start: Requisition list name
	          ***
	          --%>
              <form name="RequisitionListNameForm" action="RequisitionListUpdate" method="post" id="RequisitionListNameForm">
                <input type="hidden" name="requisitionListId" value="<c:out value="${requisitionListId}"/>" id="WC_RequisitionListUpdateForm_FormInput_requisitionListId_In_RequisitionListNameForm_1"/>
				<c:url value="RequisitionListUpdateView" var="reqListUpdateViewURL">
				    <c:param name="storeId" value="${storeId}"/>
				    <c:param name="catalogId" value="${catalogId}"/>
           			<c:param name="requisitionListId" value="${requisitionListId}" />
           		</c:url>
                <input type="hidden" name="URL" value="<c:out value="${reqListUpdateViewURL}"/>" id="WC_RequisitionListUpdateForm_FormInput_URL_In_RequisitionListNameForm_1"/>
                <table id="WC_RequisitionListUpdateForm_Table_3">
                  <tbody>
                    <tr>
                      <td id="WC_RequisitionListUpdateForm_TableCell_4"> <h1><fmt:message key="Editreq_Title" bundle="${storeText}"/></h1></td>
                    </tr>
                    <tr>
                      <td id="WC_RequisitionListUpdateForm_TableCell_5"><strong><label for="RequisitionListUpdateForm_Name"><fmt:message key="Editreq_Text1" bundle="${storeText}"/></label></strong>&nbsp;&nbsp;
                        <input class="input" type="text" name="name" value="<c:out value="${orderDB.description}"/>" id="RequisitionListUpdateForm_Name"/></td>
                      <td id="WC_RequisitionListUpdateForm_TableCell_6"><table border="0" cellspacing="0" cellpadding="4" id="WC_RequisitionListUpdateForm_Table_4">
                          <tr>
                            <td id="WC_RequisitionListUpdateForm_TableCell_7"><a class="button" href="javascript:UpdateReqListName(document.RequisitionListNameForm)" id="WC_RequisitionListUpdateForm_Link_1">
                              <fmt:message key="Editreq_Button1" bundle="${storeText}"/> </a></td>
                          </tr>
                        </table></td>
                    </tr>
                    <tr>
                      <td id="WC_RequisitionListUpdateForm_TableCell_8"><strong><fmt:message key="Editreq_Text2" bundle="${storeText}"/></strong>&nbsp;&nbsp;<c:out value="${orderDB.numberOfOrderItems}"/></td>
                    </tr>
                  </tbody>
                </table>
              </form>
              <%--
              ***
              * End: Requisition list name
              ***
              --%>
	          <%--
	          ***
	          * Start: Requisition list type
	          ***
	          --%>
              <br /> <form name="RequisitionListTypeForm" action="RequisitionListUpdate" method="post" id="RequisitionListTypeForm">
                <input type="hidden" name="requisitionListId" value="<c:out value="${requisitionListId}"/>" id="WC_RequisitionListUpdateForm_FormInput_requisitionListId_In_RequisitionListTypeForm_1"/>
                <input type="hidden" name="URL" value="<c:out value='${reqListUpdateViewURL}'/>" id="WC_RequisitionListUpdateForm_FormInput_URL_In_RequisitionListTypeForm_1"/>
                <input type="hidden" name="name" value="<c:out value="${orderDB.description}"/>" id="WC_RequisitionListUpdateForm_FormInput_name_In_RequisitionListTypeForm_1"/>
                <input type="hidden" name="storeId" value="<c:out value='${storeId}'/>"/>
                <input type="hidden" name="catalogId" value="<c:out value='${catalogId}'/>"/>
                <input type="hidden" name="errorViewName" value="RequisitionListUpdateView" id="WC_RequisitionListUpdateForm_FormInput_errorViewName_In_AddRequisitionListItemForm_1"/>
                <table border="0" cellpadding="0" cellspacing="2" id="WC_RequisitionListUpdateForm_Table_5">
                  <tbody>
                    <tr>
                      <td width="150" id="WC_RequisitionListUpdateForm_TableCell_9"><strong><label for="RequisitionListTypeForm_Status"><fmt:message key="ReqList_Type" bundle="${storeText}"/></label></strong>&nbsp;&nbsp; <a name="status" id="WC_RequisitionListUpdateForm_Link_2">
		      	<select class="select" name="status" id="RequisitionListTypeForm_Status" onchange="javascript:document.RequisitionListTypeForm.submit()">
		        	<c:choose>
		                          <c:when test="${orderDB.status eq 'Y'}" >
		                          	<c:set var="selectedY" value="selected=\"selected\""/>
		                          	<c:set var="selectedZ" value=""/>
		                          </c:when>
		                          <c:otherwise>
		                          	<c:set var="selectedY" value=""/>
		                          	<c:set var="selectedZ" value="selected=\"selected\""/>
		                          </c:otherwise>
		                 </c:choose>
		                 <option value="Y" <c:out value="${selectedY}"/>><fmt:message key="Editreq_Drop1" bundle="${storeText}"/></option>
		                 <option value="Z" <c:out value="${selectedZ}"/>><fmt:message key="Editreq_Drop2" bundle="${storeText}"/></option>
		         </select>
                        </a>
                      </td>
                    </tr>
                  </tbody>
                </table>
              </form>
	          <%--
	          ***
	          * End: Requisition list type
	          ***
	          --%>
              <br /> <table cellpadding="0" cellspacing="0" border="0" width="100%" id="WC_RequisitionListUpdateForm_Table_6">
                <tbody>
                  <tr>
                    <td id="WC_RequisitionListUpdateForm_TableCell_10"><fmt:message key="Editreq_Text3" bundle="${storeText}"/></td>
                  </tr>
                </tbody>
              </table>
              <br /> </td>
          </tr>
        </tbody>
      </table>
      <table border="0" cellpadding="4" cellspacing="0" width="100%" id="WC_RequisitionListUpdateForm_Table_7">
        <tbody>
          <tr>
            <td id="WC_RequisitionListUpdateForm_TableCell_11">
	          <%--
	          ***
	          * Start: Add item to requisition list
	          ***
	          --%>
            <form name="AddRequisitionListItemForm" action="RequisitionListItemUpdate" method="post" id="AddRequisitionListItemForm">
                <input type="hidden" name="requisitionListId" value="<c:out value="${requisitionListId}"/>" id="WC_RequisitionListUpdateForm_FormInput_requisitionListId_In_AddRequisitionListItemForm_1"/>
                <input type="hidden" name="URL" value="<c:out value='${reqListUpdateViewURL}'/>" id="WC_RequisitionListUpdateForm_FormInput_URL_In_AddRequisitionListItemForm_1"/>
                <input type="hidden" name="storeId" value="<c:out value='${storeId}'/>"/>
                <input type="hidden" name="catalogId" value="<c:out value='${catalogId}'/>"/>
                <input type="hidden" name="errorViewName" value="RequisitionListUpdateView" id="WC_RequisitionListUpdateForm_FormInput_errorViewName_In_AddRequisitionListItemForm_1"/>
                <table cellpadding="2" cellspacing="0" border="0" id="WC_RequisitionListUpdateForm_Table_8">
                  <tbody>
                    <tr>
                      <td id="WC_RequisitionListUpdateForm_TableCell_12"><strong><label for="RequisitionListUpdateForm_newSKU"><fmt:message key="Editreq_SKU" bundle="${storeText}"/></label></strong></td>
                      <td id="WC_RequisitionListUpdateForm_TableCell_13"><strong><label for="RequisitionListUpdateForm_newQuantity"><fmt:message key="Editreq_Quantity" bundle="${storeText}"/></label></strong></td>
                      <td id="WC_RequisitionListUpdateForm_TableCell_14">&nbsp;</td>
                    </tr>
                    <tr>
                      <td id="WC_RequisitionListUpdateForm_TableCell_15"><input class="input" type="text" name="partNumber" value="<c:out value='${WCParam.partNumber}'/>" id="RequisitionListUpdateForm_newSKU"/></td>
                      <td id="WC_RequisitionListUpdateForm_TableCell_16"><input class="input" type="text" name="quantity" value="<c:out value='${WCParam.quantity}'/>" id="RequisitionListUpdateForm_newQuantity"/></td>
                      <td id="WC_RequisitionListUpdateForm_TableCell_17"><table border="0" cellspacing="0" cellpadding="4" id="WC_RequisitionListUpdateForm_Table_9">
                          <tr>
                            <td id="WC_RequisitionListUpdateForm_TableCell_18"> <a class="button" href="javascript:Add2ReqList(document.AddRequisitionListItemForm)" id="WC_RequisitionListUpdateForm_Link_4"><fmt:message key="Editreq_Button2" bundle="${storeText}"/> </a></td>
                          </tr>
                        </table>
                      </td>
                    </tr>
                  </tbody>
                </table>
              </form>
	          <%--
	          ***
	          * End: Add item to requisition list
	          ***
	          --%>
              <br />
	          <%--
	          ***
	          * Start: Update Requisition List
	          ***
	          --%>
              <form method="post" name="UpdateRequisitionListItemForm" action="RequisitionListItemUpdate" id="UpdateRequisitionListItemForm">
                <input type="hidden" name="URL" value="<c:out value='${reqListUpdateViewURL}&orderItemId*=&amp;quantity_*='/>" id="WC_RequisitionListUpdateForm_FormInput_URL_In_UpdateRequisitionListItemForm_1"/>
                <input type="hidden" name="requisitionListId" value="<c:out value="${requisitionListId}"/>" id="WC_RequisitionListUpdateForm_FormInput_requisitionListId_In_UpdateRequisitionListItemForm_1"/>
                <input type="hidden" name="storeId" value="<c:out value='${storeId}'/>"/>
                <input type="hidden" name="catalogId" value="<c:out value='${catalogId}'/>"/>
                <input type="hidden" name="errorViewName" value="RequisitionListUpdateView" id="WC_RequisitionListUpdateForm_FormInput_errorViewName_In_AddRequisitionListItemForm_1"/>

                <table cellpadding="0" cellspacing="0" border="0" width="100%" class="bgColor" id="WC_RequisitionListUpdateForm_Table_10">
                            <tr>
                                <th valign="top" class="colHeader" id="RequisitionListUpdateForm_Desc"><fmt:message key="Editreq_Col3" bundle="${storeText}"/></th>
                                <th valign="top" class="colHeader" id="RequisitionListUpdateForm_SKU"><fmt:message key="Editreq_Col1" bundle="${storeText}"/></th>
                                <th valign="top" class="colHeader" id="RequisitionListUpdateForm_Quantity"><fmt:message key="Editreq_Col2" bundle="${storeText}"/></th>
                                <th valign="top" class="colHeader" id="RequisitionListUpdateForm_MF"><fmt:message key="Editreq_Col4" bundle="${storeText}"/></th>
                                <th valign="top" class="colHeader" id="RequisitionListUpdateForm_Part"><fmt:message key="Editreq_Col5" bundle="${storeText}"/></th>
                                <th valign="top" class="colHeader_last" id="RequisitionListUpdateForm_Remove"></th>
                            </tr>
			<c:forEach var="orderItem" items="${orderDB.orderItemDataBeans}" varStatus="istat">
                            <tr>
                                <c:url value="ProductDisplay" var="productDisplay">
                            		<c:param name="catalogId" value="${catalogId}" />
                            		<c:param name="storeId" value="${storeId}" />
                            		<c:param name="langId" value="${langId}" />
                            		<c:param name="productId" value="${orderItem.catalogEntryId}" />
                            	</c:url>
                                <td headers="RequisitionListUpdateForm_Desc" class="<c:out value="cellBG_${((istat.count+1) % 2) + 1}"/> t_td" id="WC_RequisitionListUpdateForm_TableCell_37_<c:out value="${istat.count}"/>"><a href="<c:out value="${productDisplay}"/>" id="WC_RequisitionListUpdateForm_Link_5_<c:out value="${istat.count}"/>"><c:out value="${orderItem.catalogEntry.description.shortDescription}" escapeXml="false"/></a></td>
                              	<td headers="RequisitionListUpdateForm_SKU" class="<c:out value="cellBG_${((istat.count+1) % 2) + 1}"/> t_td" id="WC_RequisitionListUpdateForm_TableCell_36_<c:out value="${istat.count}"/>"><c:out value='${orderItem.catalogEntry.partNumber}'/></td>
                              	<td headers="RequisitionListUpdateForm_Quantity" class="<c:out value="cellBG_${((istat.count+1) % 2) + 1}"/> t_td" id="WC_RequisitionListUpdateForm_TableCell_33_<c:out value="${istat.count}"/>">
                                  <input type="hidden" name="orderItemId_<c:out value='${istat.count+1}'/>" value="<c:out value='${orderItem.orderItemId}'/>" id="WC_RequisitionListUpdateForm_FormInput_orderItemId_<c:out value='${istat.count+1}'/>_In_UpdateRequisitionListItemForm_1_<c:out value="${istat.count}"/>"/>
                                  <label for="WC_RequisitionListUpdateForm_FormInput_quantity_<c:out value='${istat.count+1}'/>_In_UpdateRequisitionListItemForm_1_<c:out value="${istat.count}"/>"></label>
                                  <input class="input" type='text' title='<fmt:message key="Editreq_Col2" bundle="${storeText}"/>' size="2" maxlength="256" name="quantity_<c:out value='${istat.count+1}'/>" value="<c:out value='${orderItem.formattedQuantity}'/>" id="WC_RequisitionListUpdateForm_FormInput_quantity_<c:out value='${istat.count+1}'/>_In_UpdateRequisitionListItemForm_1_<c:out value="${istat.count}"/>"/>
                                </td>
                              	<td headers="RequisitionListUpdateForm_MF" class="<c:out value="cellBG_${((istat.count+1) % 2) + 1}"/> t_td" id="WC_RequisitionListUpdateForm_TableCell_38_<c:out value="${istat.count}"/>"><c:out value="${orderItem.catalogEntry.manufacturerName}"/></td>
                              	<td headers="RequisitionListUpdateForm_Part" class="<c:out value="cellBG_${((istat.count+1) % 2) + 1}"/> t_td" id="WC_RequisitionListUpdateForm_TableCell_39_<c:out value="${istat.count}"/>"><c:out value="${orderItem.catalogEntry.manufacturerPartNumber}"/></td>

					<c:url value="RequisitionListItemUpdate" var="reqListItemUpdate">
						<c:param name="orderItemId" value="${orderItem.orderItemId}"/>
                            			<c:param name="quantity" value="0"/>
                            			<c:param name="URL" value="RequisitionListUpdateView?quantity=&requisitionListId=${requisitionListId}&storeId=${storeId}&catalogId=${catalogId}&langId=${langId}"/>
                            			<c:param name="productId" value="${orderItem.catalogEntryId}" />
                            		</c:url>
                                <td class="<c:out value="cellBG_${((istat.count+1) % 2) + 1}"/> t_td" id="WC_RequisitionListUpdateForm_TableCell_40_<c:out value="${istat.count}"/>">
	                                <a class="t_button" href="<c:out value="${reqListItemUpdate}"/>" id="WC_RequisitionListUpdateForm_Link_6_<c:out value="${istat.count}"/>">
	                                	<fmt:message key="Editreq_Remove" bundle="${storeText}"/>
	                                </a>
                                </td>
                            </tr>
                            <c:remove var="catalogEntryDB" />
			</c:forEach>
                </table>
              </form>
	          <%--
	          ***
	          * End: Update Requisition List
	          ***
	          --%>
              <c:if test="${orderDB.numberOfOrderItems > 0}">
              <table border="0" cellpadding="8" cellspacing="0" class="noBorder" id="WC_RequisitionListUpdateForm_Table_19">
                <tbody>
                  <tr>
                    <td id="WC_RequisitionListUpdateForm_TableCell_41"><a class="button" href="javascript:document.UpdateRequisitionListItemForm.submit()" id="WC_RequisitionListUpdateForm_Link_7">
                      <fmt:message key="Editreq_Button3" bundle="${storeText}"/> </a></td>
                    <td id="WC_RequisitionListUpdateForm_TableCell_42"><a class="button" href="javascript:document.OrderItemAddForm.submit()" id="WC_RequisitionListUpdateForm_Link_8">
                      <fmt:message key="Editreq_Button4" bundle="${storeText}"/> </a>
                      <%--
                      ***
                      * Place Order button
                      * This is the form to add the requisition list items to the current order
                      ***
                      --%>
                      <form action="OrderItemAdd" method="post" name="OrderItemAddForm" id="OrderItemAddForm">
                        <input type="hidden" name="storeId" value="<c:out value='${storeId}'/>" id="WC_RequisitionListUpdateForm_FormInput_storeId_In_OrderItemAddForm_1"/>
                        <input type="hidden" name="orderId" value="." id="WC_RequisitionListUpdateForm_FormInput_orderId_In_OrderItemAddForm_1"/>
                        <input type="hidden" name="langId" value="<c:out value='${langId}'/>" id="WC_RequisitionListUpdateForm_FormInput_langId_In_OrderItemAddForm_1"/>
                        <input type="hidden" name="catalogId" value="<c:out value='${catalogId}'/>" id="WC_RequisitionListUpdateForm_FormInput_catalogId_In_OrderItemAddForm_1"/>
                        <input type="hidden" name="URL" value="SetPendingOrder?URL=OrderCalculate?URL=OrderItemDisplay&amp;orderId=.&amp;orderItemId*=&amp;catEntryId_*=&amp;quantity_*=&amp;updatePrices=1&amp;calculationUsageId=-1" id="WC_RequisitionListUpdateForm_FormInput_URL_In_OrderItemAddForm_1"/>
                        <input type="hidden" name="allocate" value="*n" id="WC_RequisitionListUpdateForm_FormInput_allocate_In_OrderItemAddForm_1"/>
                        <input type="hidden" name="reverse" value="*n" id="WC_RequisitionListUpdateForm_FormInput_reverse_In_OrderItemAddForm_1"/>
                        <input type="hidden" name="backorder" value="*n" id="WC_RequisitionListUpdateForm_FormInput_backorder_In_OrderItemAddForm_1"/>
                        <input type="hidden" name="errorViewName" value="RequisitionListUpdateView" id="WC_RequisitionListUpdateForm_FormInput_errorViewName_In_OrderItemAddForm_1"/>
                        <input type="hidden" name="requisitionListId" value="<c:out value="${requisitionListId}"/>" id="WC_RequisitionListUpdateForm_FormInput_requisitionListId_In_OrderItemAddForm_1"/>
                        <c:forEach var="orderItem" items="${orderDB.orderItemDataBeans}" varStatus="istat">
                        <input type="hidden" name="catEntryId_<c:out value="${istat.count}"/>" value="<c:out value="${orderItem.catalogEntryId }"/>" id="WC_RequisitionListUpdateForm_FormInput_catEntryId_<c:out value="${istat.count}"/>_In_OrderItemAddForm_1"/>
                        <input type="hidden" name="quantity_<c:out value="${istat.count}"/>" value="<c:out value="${orderItem.formattedQuantity}"/>" id="WC_RequisitionListUpdateForm_FormInput_quantity_<c:out value="${istat.count}"/>_In_OrderItemAddForm_1"/>
           				</c:forEach>
                      </form></td>
                  </tr>
                </tbody>
              </table>
			</c:if>
			</td>
          </tr>
        </tbody>
      </table>
      <!-- content end -->
</c:if>
<c:if test="${!empty orderDB.organizationId && orderDB.organizationId != CommandContext.activeOrganizationId}">
<fmt:message key="REQUISITIONLIST_NOT_FOR_ACTIVEORG" bundle="${storeText}" />
</c:if>
<%@ include file="../../../include/LayoutContainerBottom.jspf"%>
</body>
<!-- END RequisitionListUpdateForm.jsp -->
</html>
