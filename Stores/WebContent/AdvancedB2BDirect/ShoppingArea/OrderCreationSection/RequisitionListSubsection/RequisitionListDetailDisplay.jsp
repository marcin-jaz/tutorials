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
  * This JSP page displays the View Requisition List page with the following elements:
  *  - List of items in the requisition list. For each item, the following is displayed:
  *			- SKU, Quantity, Description, Manufacturer and Part Number
  *			- Description is a link to the Catalog Item Display page for the item
  *  - 'Place Order' button
  *  - 'View All Requisition Lists' button
  *****
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf"%>

<c:set var="requisitionListId" value="${WCParam.requisitionListId}" scope="request" />
<wcbase:useBean id="orderDB" classname="com.ibm.commerce.order.beans.OrderDataBean" scope="page">
<c:set target="${orderDB}" property="orderId" value="${requisitionListId}"/>
</wcbase:useBean>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<!-- BEGIN RequisitionListDetailDisplay.jsp -->
<head>
<title><fmt:message key="Viewreq_Title" bundle="${storeText}" /></title>
<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${vfileStylesheet}"/>" type="text/css"/>
</head>
<body class="noMargin">
<flow:ifEnabled feature="customerCare">
<%--
Set header type needed for this JSP for LiveHelp.  This must be set before HeaderDisplay.jsp
--%>
<c:set var="liveHelpPageType" value="personal" scope="request" />
</flow:ifEnabled>
<%@ include file="../../../include/LayoutContainerTop.jspf"%>
        <!-- content start -->
        <table cellpadding="8" cellspacing="0" border="0" width="100%" id="WC_RequisitionListDetailDisplay_Table_2">
          <tbody>
            <tr>
              <td id="WC_RequisitionListDetailDisplay_TableCell_3"> <table id="WC_RequisitionListDetailDisplay_Table_3">
                  <tbody>
                    <tr>
                      <td id="WC_RequisitionListDetailDisplay_TableCell_4"><h1><fmt:message key="Viewreq_Title" bundle="${storeText}" /></h1></td>
                    </tr>
                    <tr>
                      <td id="WC_RequisitionListDetailDisplay_TableCell_5"><strong><fmt:message key="Viewreq_Text1" bundle="${storeText}" /></strong>&nbsp;&nbsp;<c:out value="${orderDB.description}"/></td>
                    </tr>
                    <tr>
                      <td id="WC_RequisitionListDetailDisplay_TableCell_6"><strong><fmt:message key="Viewreq_Text2" bundle="${storeText}" /></strong>&nbsp;&nbsp;<c:out value="${orderDB.numberOfOrderItems}"/></td>
                    </tr>
                    <tr>
                      <td id="WC_RequisitionListDetailDisplay_TableCell_7"><strong><fmt:message key="Viewreq_Text3" bundle="${storeText}" /></strong>&nbsp;&nbsp;
		      	<c:choose>
				<c:when test="${orderDb.status eq 'Y'}">
					<fmt:message key="Viewreq_Drop1" bundle="${storeText}" />
				</c:when>
				<c:otherwise>
				        <fmt:message key="Viewreq_Drop2" bundle="${storeText}" />
				</c:otherwise>
			</c:choose>
                      </td>
                    </tr>
                  </tbody>
                </table>
		                <%--
		                ***
		                * Start: List of Requisition List items
		                ***
		                --%>
                <br /> <table cellpadding="0" cellspacing="0" border="0" width="100%" id="WC_RequisitionListDetailDisplay_Table_4">
                  <tbody>
                    <tr>
                      <td id="WC_RequisitionListDetailDisplay_TableCell_8">
                      <table class="bgColor" width="100%" border="0" cellpadding="2" cellspacing="1" id="WC_RequisitionListDetailDisplay_Table_6">
                                  <tbody>
                                    <tr >
                                              <th valign="top" class="colHeader" id="RequisitionListDetailDisplay_Qty"><fmt:message key="Viewreq_Col2" bundle="${storeText}" /></th>
                                              <th valign="top" class="colHeader" id="RequisitionListDetailDisplay_SKU"><fmt:message key="Viewreq_Col1" bundle="${storeText}" /></th>
                                              <th valign="top" class="colHeader" id="RequisitionListDetailDisplay_Desc"><fmt:message key="Viewreq_Col3" bundle="${storeText}" /></th>
                                              <th valign="top" class="colHeader" id="RequisitionListDetailDisplay_MF"><fmt:message key="Viewreq_Col4" bundle="${storeText}" /></th>
                                              <th valign="top" class="colHeader" id="RequisitionListDetailDisplay_Part"><fmt:message key="Viewreq_Col5" bundle="${storeText}" /></th>
                                    </tr>
								<c:forEach var="orderItem" items="${orderDB.orderItemDataBeans}" varStatus="istat">
                                    <tr>
                                      <td headers="RequisitionListDetailDisplay_Qty" class="<c:out value="cellBG_${((istat.count+1) % 2) + 1}"/>" id="WC_RequisitionListDetailDisplay_TableCell_21_<c:out value="${istat.count}"/>"><c:out value="${orderItem.formattedQuantity}" /></td>
                                      <td headers="RequisitionListDetailDisplay_SKU" class="<c:out value="cellBG_${((istat.count+1) % 2) + 1}"/>" id="WC_RequisitionListDetailDisplay_TableCell_20_<c:out value="${istat.count}"/>"><c:out value="${orderItem.itemDataBean.partNumber}" /></td>
                                      <c:url value="ProductDisplay" var="productDisplay">
                            			<c:param name="catalogId" value="${catalogId}" />
                            			<c:param name="storeId" value="${storeId}" />
                            			<c:param name="langId" value="${langId}" />
                            			<c:param name="productId" value="${orderItem.catalogEntryId}" />
                            		</c:url>
                                      <td headers="RequisitionListDetailDisplay_Desc" class="<c:out value="cellBG_${((istat.count+1) % 2) + 1}"/>" id="WC_RequisitionListDetailDisplay_TableCell_23_<c:out value="${istat.count}"/>"><a href="<c:out value="${productDisplay}"/>" id="WC_RequisitionListDetailDisplay_Link_1_<c:out value="${istat.count}"/>"><c:out value="${orderItem.itemDataBean.description.shortDescription}"/></a></td>
                                      <td headers="RequisitionListDetailDisplay_MF" class="<c:out value="cellBG_${((istat.count+1) % 2) + 1}"/>" id="WC_RequisitionListDetailDisplay_TableCell_24_<c:out value="${istat.count}"/>"><c:out value="${orderItem.itemDataBean.manufacturerName}"/></td>
                                      <td headers="RequisitionListDetailDisplay_Part" class="<c:out value="cellBG_${((istat.count+1) % 2) + 1}"/>" id="WC_RequisitionListDetailDisplay_TableCell_25_<c:out value="${istat.count}"/>"><c:out value="${orderItem.itemDataBean.manufacturerPartNumber}"/></td>
                                    </tr>
								</c:forEach>
                                  </tbody>
                                </table></td>
                            </tr>
                          </tbody>
                        </table>
		                <%--
		                ***
		                * End: List of Requisition List items
		                ***
		                --%>
                        <p> </p>
                        <%--
                        ***
                        * OrderItemAddForm adds this requisition list's items to the current pending order
                        ***
                        --%>
                        <form name="OrderItemAddForm" action="OrderItemAdd" method="post" id="OrderItemAddForm">
                          <input type="hidden" name="storeId" value="<c:out value="${storeId}"/>" id="WC_RequisitionListDetailDisplay_FormInput_storeId_In_OrderItemAddForm_1"/>
                          <input type="hidden" name="orderId" value="." id="WC_RequisitionListDetailDisplay_FormInput_orderId_In_OrderItemAddForm_1"/>
                          <input type="hidden" name="langId" value="<c:out value="${langId}"/>" id="WC_RequisitionListDetailDisplay_FormInput_langId_In_OrderItemAddForm_1"/>
                          <input type="hidden" name="catalogId" value="<c:out value="${catalogId}"/>" id="WC_RequisitionListDetailDisplay_FormInput_catalogId_In_OrderItemAddForm_1"/>
                          <input type="hidden" name="URL" value="SetPendingOrder?URL=OrderCalculate?URL=OrderItemDisplay?orderId=*&amp;orderItemId*=&amp;catEntryId_*=&amp;quantity_*=&updatePrices=1&calculationUsageId=-1" id="WC_RequisitionListDetailDisplay_FormInput_URL_In_OrderItemAddForm_1"/>
                          <input type="hidden" name="allocate" value="*n" id="WC_RequisitionListDetailDisplay_FormInput_allocate_In_OrderItemAddForm_1"/>
                          <input type="hidden" name="reverse" value="*n" id="WC_RequisitionListDetailDisplay_FormInput_reverse_In_OrderItemAddForm_1"/>
                          <input type="hidden" name="backorder" value="*n" id="WC_RequisitionListDetailDisplay_FormInput_backorder_In_OrderItemAddForm_1"/>
                          <input type="hidden" name="errorViewName" value="CatalogItemAddErrorView" id="WC_RequisitionListDetailDisplay_FormInput_errorViewName_In_OrderItemAddForm_1"/>

					<c:forEach var="orderItem" items="${orderDB.orderItemDataBeans}" varStatus="istat">
                          <input type="hidden" name="catEntryId_<c:out value="${istat.count}"/>" value="<c:out value="${orderItem.catalogEntryId }"/>" id="WC_RequisitionListDetailDisplay_FormInput_catEntryId_<c:out value="${istat.count}"/>_In_OrderItemAddForm_1"/>
                          <input type="hidden" name="quantity_<c:out value="${istat.count}"/>" value="<c:out value="${orderItem.formattedQuantity}"/>" id="WC_RequisitionListDetailDisplay_FormInput_quantity_<c:out value="${istat.count}"/>_In_OrderItemAddForm_1"/>
                    </c:forEach>
                        </form>
                        <table cellpadding="0" cellspacing="0" border="0" id="WC_RequisitionListDetailDisplay_Table_12">
                          <tbody>
                            <tr>
  							  	<c:if test="${orderDB.numberOfOrderItems > 0}">
                              <td id="WC_RequisitionListDetailDisplay_TableCell_26"><table cellpadding="8" cellspacing="0" border="0" id="WC_RequisitionListDetailDisplay_Table_13">
                                  <tr>
                                    <td id="WC_RequisitionListDetailDisplay_TableCell_27"><a href="javascript:document.OrderItemAddForm.submit()" class="button" id="WC_RequisitionListDetailDisplay_Link_2">
                                      <fmt:message key="Viewreq_Link" bundle="${storeText}" /> </a></td>
                                  </tr>
                                </table></td>
                              <td id="WC_RequisitionListDetailDisplay_TableCell_28">&nbsp;&nbsp;</td>
                              </c:if>
                              <td id="WC_RequisitionListDetailDisplay_TableCell_29"><table cellpadding="8" cellspacing="0" border="0" id="WC_RequisitionListDetailDisplay_Table_14">
                                  <tr>
                                    <c:url value="RequisitionListView" var="reqListUrl">
                            		  <c:param name="storeId" value="${storeId}"/>
                            		  <c:param name="catalogId" value="${catalogId}"/>
                                    </c:url>
                                    <td id="WC_RequisitionListDetailDisplay_TableCell_30"><a href="<c:out value='${reqListUrl}'/>" class="button" id="WC_RequisitionListDetailDisplay_Link_3">
                                      <fmt:message key="Viewreq_Button" bundle="${storeText}" /> </a></td>
                                  </tr>
                                </table></td>
                            </tr>
                          </tbody>
                        </table></td>
                    </tr>
                  </tbody>
                </table></td>
            </tr>
          </tbody>
        </table>
        <!--content end-->
<%@ include file="../../../include/LayoutContainerBottom.jspf"%>
</body>
<!-- END RequisitionListDetailDisplay.jsp -->
</html>
