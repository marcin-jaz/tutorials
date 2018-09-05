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
  * This page is displayed if insufficient inventory available for the order items.  It is is only 
  * reached if some order items are available, and some order items are unavailable.  It displays the
  * availability date for each item and the user's available options as well.  Available options are:
  *  - Ship the entire order when all items are available
  *  - Ship the available items now and ship the rest when they become available
  *****
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>

<%@ include file="../../../include/JSTLEnvironmentSetup.jspf" %>

<c:set var="paymentMethod" value="${WCParam.paymentMethod}"/>
<wcbase:useBean id="orderBean" classname="com.ibm.commerce.order.beans.OrderDataBean">
<c:set target="${orderBean}" property="orderId" value="${WCParam.orderId}"/>
</wcbase:useBean>
<%
// *************  CHECK IF SUFFICIENT INVENTORY AVAILABLE ****************
%>
<c:set var="orderItems" value="${orderBean.orderItemDataBeans}"/>
<% out.flush(); %>
<c:choose>
       <c:when test="${empty orderItems[0]}">
              <c:set var="EmptyOrderFile" value="${jspStoreDir}ShoppingArea/CurrentOrderSection/EmptyOrderDisplay.jsp"/>
              <c:import url="${EmptyOrderFile}">
                    </c:import>
       </c:when>
</c:choose>
<% out.flush(); %>
<c:set var="bAllOrderItemsAvailable" value="${orderBean.allItemsBackOrdered}"/>
<c:set var="bAllOrderItemsOnBackorder" value="${orderBean.allItemsAvailable}"/>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<!-- BEGIN ProductAvailabilityDisplay.jsp -->
<head>
<title><fmt:message key="ProdAvail_Title" bundle="${storeText}"/></title>
<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}"/><c:out value="${vfileStylesheet}"/>" type="text/css"/>
</head>
<body class="noMargin">

<%@ include file="../../../include/LayoutContainerTop.jspf"%>

       <img alt="<fmt:message key="Checkout_AccessibilityDescription" bundle="${storeText}" />" src="<c:out value="${jspStoreImgDir}" />images/trans.gif" width="1" height="1" border="0"/>
       <table cellpadding="0" cellspacing="0" border="0" id="WC_Breadcrumb_Table">
              <tr>
                     <td id="WC_Breadcrumb_TableCell_1" class="portlet_content">
                            <fmt:message key="Checkout_Submit" bundle="${storeText}"/>
                     </td>
                     <td id="WC_Breadcrumb_TableCell_1a" class="portlet_content">
                            &nbsp;<strong>::</strong>&nbsp;
                     </td>
                     <td id="WC_Breadcrumb_TableCell_2" class="portlet_content">
                            <img alt="<fmt:message key="Checkout_CurrentStep" bundle="${storeText}" />" src="<c:out value="${jspStoreImgDir}" />images/trans.gif" width="1" height="1" border="0"/><strong><fmt:message key="Checkout_BillingShipping" bundle="${storeText}"/></strong>
                     </td>
                     <td id="WC_Breadcrumb_TableCell_2a" class="portlet_content">
                            &nbsp;<strong>::</strong>&nbsp;
                     </td>
                     <td id="WC_Breadcrumb_TableCell_3" class="portlet_content">       
                            <fmt:message key="Checkout_Summary" bundle="${storeText}"/>
                     </td>
                     <td id="WC_Breadcrumb_TableCell_3a" class="portlet_content">
                            &nbsp;<strong>::</strong>&nbsp;
                     </td>
                     <td id="WC_Breadcrumb_TableCell_4" class="portlet_content">       
                            <fmt:message key="Checkout_Confirmation" bundle="${storeText}"/>
                     </td>
              </tr>
       </table>

<table border="0" cellpadding="0" cellspacing="0" width="580" id="WC_ProductAvailabilityDisplay_Table_1">
  <tbody>
    <tr>
      <td valign="top" width="100%" id="WC_ProductAvailabilityDisplay_TableCell_2">
        <!--content start-->
        <table cellpadding="8" cellspacing="0" border="0" width="100%" id="WC_ProductAvailabilityDisplay_Table_2">
          <tbody>
            <tr>
              <td id="WC_ProductAvailabilityDisplay_TableCell_3"><h1><fmt:message key="ProdAvail_Title" bundle="${storeText}"/></h1>
                <table cellpadding="0" cellspacing="0" border="0" width="100%" class="bgColor" id="WC_ProductAvailabilityDisplay_Table_3">
                  <tbody>
                    <tr>
                      <td id="WC_ProductAvailabilityDisplay_TableCell_4"> <table width="100%" border="0" cellpadding="2" cellspacing="1" id="WC_ProductAvailabilityDisplay_Table_4">
                          <tbody>
                            <tr>
                              <td width="12%" class="bgColor" id="WC_ProductAvailabilityDisplay_TableCell_5"> <table id="WC_ProductAvailabilityDisplay_Table_5">
                                  <tbody>
                                    <tr>
                                      <td valign="top" class="colHeader" id="WC_ProductAvailabilityDisplay_TableCell_6"><fmt:message key="ProdAvail_Quantity" bundle="${storeText}"/></td>
                                    </tr>
                                  </tbody>
                                </table></td>
                              <td width="17%" class="bgColor" id="WC_ProductAvailabilityDisplay_TableCell_7"> <table id="WC_ProductAvailabilityDisplay_Table_6">
                                  <tbody>
                                    <tr>
                                      <td valign="top" class="colHeader" id="WC_ProductAvailabilityDisplay_TableCell_8"><fmt:message key="ProdAvail_SKU" bundle="${storeText}"/></td>
                                    </tr>
                                  </tbody>
                                </table></td>
                              <td width="26%" class="bgColor" id="WC_ProductAvailabilityDisplay_TableCell_9"> <table id="WC_ProductAvailabilityDisplay_Table_7">
                                  <tbody>
                                    <tr>
                                      <td valign="top" class="colHeader" id="WC_ProductAvailabilityDisplay_TableCell_10"><fmt:message key="ProdAvail_Name" bundle="${storeText}"/></td>
                                    </tr>
                                  </tbody>
                                </table></td>
                              <td width="22%" class="bgColor" id="WC_ProductAvailabilityDisplay_TableCell_11"> <table id="WC_ProductAvailabilityDisplay_Table_8">
                                  <tbody>
                                    <tr>
                                      <td valign="top" class="colHeader" id="WC_ProductAvailabilityDisplay_TableCell_12"><fmt:message key="ProdAvail_EstShp" bundle="${storeText}"/></td>
                                    </tr>
                                  </tbody>
                                </table></td>
                              <td width="22%" class="bgColor" id="WC_ProductAvailabilityDisplay_TableCell_13"><br /></td>
                            </tr>
<c:set value="${orderBean.formattedEstimatedShipDate}" var="latestAvailableDate"/>       
<c:set value="false" var="discontinued"/>       
<c:set value="false" var="avail_unknown"/>       
<c:set value="false" var="backorderable"/>
<c:set var="i" value="0"/>       
<c:forEach items="${orderItems}" var="orderItem">

		<wcbase:useBean id="catalogEntryDB" classname="com.ibm.commerce.catalog.beans.CatalogEntryDataBean">
			<c:set target="${catalogEntryDB}" property="catalogEntryID" value="${orderItem.catalogEntryId}" />		
		</wcbase:useBean>
		
		<c:if test="${catalogEntryDB.type eq 'ItemBean'}">
       		<wcbase:useBean id="item" classname="com.ibm.commerce.catalog.beans.ItemDataBean">
              	<c:set target="${item}" property="itemID" value="${orderItem.catalogEntryId}"/>
       		</wcbase:useBean>
       		<c:set value="${item.attributeValueDataBeans}" var="attrvalues"/>       
        </c:if>
        
       <%
       // Loop through attributes values and only show the value that is relavent to the attribute for this SKU
       // Usage code of 3 is used by stores based on PC catalog
       // Usage code of 1 is used by stores based on Hardware catalog
       // Usage code null also denotes defining attributes.                                                                                                                              
       %>
       
                
       <c:set value="${orderItem.inventoryStatus}" var="invStatus"/>       
       <c:set value="${orderItem.formattedEstimatedShippingTime}" var="availableDate"/>       
       <c:choose>
              <c:when test="${invStatus=='NALC'}">
                     <c:choose>
                            <c:when test="${orderItem.discontinued}">
                                   <c:set value="true" var="discontinued"/>       
                                   <fmt:message key="ProdAvail_Discontinued" bundle="${storeText}" var="availableDate"/>
                            </c:when>
                            <c:otherwise>
                                   <c:set value="true" var="avail_unknown"/>       
                                   <fmt:message key="ProdAvail_Unknown" bundle="${storeText}" var="availableDate"/>
                            </c:otherwise>
                     </c:choose>
              </c:when>
              <c:when test="${invStatus=='BO'}">
                     <c:set value="true" var="backorderable"/>                            
                     <c:choose>
                            <c:when test="${empty availableDate}">
                                   <fmt:message key="ProdAvail_Out" bundle="${storeText}" var="availableDate"/>
                            </c:when>
                     </c:choose>
              </c:when>
              <c:when test="${invStatus=='ALLC'}">
                     <c:set value="${orderItem.formattedEstimatedShippingTime}" var="availableDate"/>       
              </c:when>              
              <c:otherwise>
                     <fmt:message key="ProdAvail_Out" bundle="${storeText}" var="availableDate"/>
              </c:otherwise>
       </c:choose>
                            <tr>
                              <td width="12%"  valign="top" class="cellBG_1" id="WC_ProductAvailabilityDisplay_TableCell_14_<c:out value="${i}"/>"><c:out value="${orderItem.quantityInIntValue}"/></td>
                              <td width="17%" valign="top" class="cellBG_1" id="WC_ProductAvailabilityDisplay_TableCell_15_<c:out value="${i}"/>"><c:out value="${orderItem.partNumber}"/></td>
                              <td width="26%" valign="top" class="cellBG_1" id="WC_ProductAvailabilityDisplay_TableCell_16_<c:out value="${i}"/>"> 
                              
                              <p>
                              
                              <c:if test="${catalogEntryDB.type eq 'ItemBean'}">
                                <a href="ProductDisplay?storeId=<c:out value='${storeId}'/>&catalogId=<c:out value='${WCParam.catalogId}'/>&productId=<c:out value="${orderItem.catalogEntryId}"/>" id="WC_BillingShippingDisplay_Link_2_<c:out value="${i}"/>"><c:out value="${orderItem.catalogEntry.description.shortDescription}" escapeXml="false"/></a><br />
                            	<c:forEach items="${attrvalues}" var="attrvalue">
                                       <c:if test="${empty attrvalue.attributeDataBean.usage || attrvalue.attributeDataBean.usage=='3' || attrvalue.attributeDataBean.usage=='1'}">
                                         <strong><c:out value="${attrvalue.attributeDataBean.description}" escapeXml="false"/> : </strong> <c:out value="${attrvalue.value}" escapeXml="false"/><br />
                                       </c:if>
                           	 	</c:forEach>  
                           	 	</c:if>     	 	 
                            	                            	
                                <c:if test="${catalogEntryDB.type eq 'PackageBean'}">
                                	<a href="PackageDisplay?storeId=<c:out value='${storeId}'/>&catalogId=<c:out value='${WCParam.catalogId}'/>&productId=<c:out value="${orderItem.catalogEntryId}"/>" id="WC_BillingShippingDisplay_Link_2_<c:out value="${i}"/>"><c:out value="${orderItem.catalogEntry.description.shortDescription}" escapeXml="false"/></a> <br />                                                          	               	 	
                           	 	</c:if> 
                           	 	               
                                <c:remove var="catalogEntryDB" />
                           	 	<c:remove var="item" />
                            	<c:remove var="attrvalue" />                	
                                                     
                                                                  
                                  </p></td>
                              <td width="22%" valign="top" class="cellBG_1" id="WC_ProductAvailabilityDisplay_TableCell_17_<c:out value="${i}"/>"> 
                                                   <%// display in red if the product is unavailable%>
                                                   <c:choose>
                                                        <c:when test="${invStatus=='nalc'}">
                                                                <span class="warning"><c:out value="${availableDate}"/></span> 
                                                         </c:when>
                                                         <c:otherwise>
                                                                <%// otherwise display normal%>
                                                                <c:out value="${availableDate}"/> 
                                                        </c:otherwise>
                                                 </c:choose>
                                                        </td>
                            <c:url var="sOrderItemUpdatePath" value="OrderItemUpdate">
                                   <c:param name="orderItemId" value="${orderItem.orderItemId}"/>
                                   <c:param name="quantity" value="0"/>
                                   <c:param name="orderId" value="${WCParam.orderId}"/>
                                   <c:param name="allocate" value="*"/>
                                   <c:param name="backorder" value="*"/>
                                   <c:param name="reverse" value="*n"/>
                                   <c:param name="check" value="*n"/>
                                   <c:param name="status" value="p"/>
                                   <c:param name="paymentMethod" value="${paymentMethod}"/>
                                   <c:param name="URL" value="CheckProductAvail"/>
                                   <c:param name="landId" value="${WCParam.langId}"/>
                                   <c:param name="catalogId" value="${WCParam.catalogId}"/>
                                   <c:param name="storeId" value="${WCParam.storeId}"/>
                              </c:url>
                              <% /* Link to delete the item. Use OrderItemUpdate with Quantity 0 in order to delete and reallocate. */ %>
                              <td width="23%" valign="top" class="cellBG_1" id="WC_ProductAvailabilityDisplay_TableCell_18_<c:out value="${i}"/>"><a href="<c:out value='${sOrderItemUpdatePath}'/>" id="WC_ProductAvailabilityDisplay_Link_2_<c:out value='${i}'/>"><fmt:message key="ProdAvail_Remove" bundle="${storeText}"/></a></td>
                            </tr>
<c:set var="i" value="${i+1}"/>             
<c:remove var="item"/>               
</c:forEach>                            

                          </tbody>
                        </table></td>
                    </tr>
                  </tbody>
                </table>
                <script language="javascript">
var busy = false;
       
function GoToOrderSummary(form)
{
       if (!busy)
       {
              busy = true;
              if(form.isAllItemsAvailable.value == 'false')
              {
                     if (form.orderOption[0].checked)                      // Entire option
                     {       
                            submitForm(document.EntireOrderForm);
                     } 
                     else if (form.orderOption[1].checked)               // Split and place both       
                     {
                            document.OrderSplitForm.outOrderName.value = "orderId";
                            submitForm(document.OrderSplitForm);
                     }
                     // ** modify here, to change shipping method option
              } 
              else {
                     submitForm(document.EntireOrderForm);   // all items available
              }
       }
}

function submitForm(form)
{
       form.submit()
}


</script>
                <!-- Submit this Form for option 2 -->
                <form name="OrderSplitForm" method="post" action="OrderItemMove" id="OrderSplitForm">
                  <input type="hidden" name="fromOrderId" value="<c:out value="${WCParam.orderId}"/>" id="WC_ProductAvailabilityDisplay_FormInput_fromOrderId_In_OrderSplitForm_1"/>
                  <input type="hidden" name="fromOrderItemId" value="*ub" id="WC_ProductAvailabilityDisplay_FormInput_fromOrderItemId_In_OrderSplitForm_1"/>
                  <input type="hidden" name="toOrderId" value="**" id="WC_ProductAvailabilityDisplay_FormInput_toOrderId_In_OrderSplitForm_1"/>
                  <input type="hidden" name="inOrderName" value="orderId" id="WC_ProductAvailabilityDisplay_FormInput_inOrderName_In_OrderSplitForm_1"/>
                  <input type="hidden" name="outOrderName" value="" id="WC_ProductAvailabilityDisplay_FormInput_outOrderName_In_OrderSplitForm_1"/>
                  <input type="hidden" name="inAllocate" value="*n" id="WC_ProductAvailabilityDisplay_FormInput_inAllocate_In_OrderSplitForm_1"/>
                  <input type="hidden" name="inBackorder" value="*n" id="WC_ProductAvailabilityDisplay_FormInput_inBackorder_In_OrderSplitForm_1"/>
                  <input type="hidden" name="inRemerge" value="*n" id="WC_ProductAvailabilityDisplay_FormInput_inRemerge_In_OrderSplitForm_1"/>
                  <input type="hidden" name="inMerge" value="*n" id="WC_ProductAvailabilityDisplay_FormInput_inMerge_In_OrderSplitForm_1"/>
                  <input type="hidden" name="inReverse" value="*n" id="WC_ProductAvailabilityDisplay_FormInput_inReverse_In_OrderSplitForm_1"/>
                  <input type="hidden" name="inCheck" value="*n" id="WC_ProductAvailabilityDisplay_FormInput_inCheck_In_OrderSplitForm_1"/>
                  <input type="hidden" name="outAllocate" value="*n" id="WC_ProductAvailabilityDisplay_FormInput_outAllocate_In_OrderSplitForm_1"/>
                  <input type="hidden" name="outBackorder" value="*" id="WC_ProductAvailabilityDisplay_FormInput_outBackorder_In_OrderSplitForm_1"/>
                  <input type="hidden" name="outRemerge" value="*" id="WC_ProductAvailabilityDisplay_FormInput_outRemerge_In_OrderSplitForm_1"/>
                  <input type="hidden" name="outMerge" value="*n" id="WC_ProductAvailabilityDisplay_FormInput_outMerge_In_OrderSplitForm_1"/>
                  <input type="hidden" name="outReverse" value="*n" id="WC_ProductAvailabilityDisplay_FormInput_outReverse_In_OrderSplitForm_1"/>
                  <input type="hidden" name="outCheck" value="*n" id="WC_ProductAvailabilityDisplay_FormInput_outCheck_In_OrderSplitForm_1"/>
                  <input type="hidden" name="URL" value="OrderPrepare?merge=*n&amp;remerge=*&amp;check=*n&amp;allocate=*aig&amp;allocate=*ubg&amp;backorder=*aig&amp;backorder=*ubg&amp;reverse=*n&amp;URL=OrderDisplay" id="WC_ProductAvailabilityDisplay_FormInput_URL_In_OrderSplitForm_1"/>
                  <input type="hidden" name="status" value="P" id="WC_ProductAvailabilityDisplay_FormInput_status_In_OrderSplitForm_1"/>
                  <input type="hidden" name="paymentMethod" value="<c:out value="${paymentMethod}"/>" id="WC_ProductAvailabilityDisplay_FormInput_paymentMethod_In_OrderSplitForm_1"/>
                  <input type="hidden" name="langId" value="<c:out value="${langId}" />" id="WC_ProductAvailabilityDisplay_FormInput_landId_In_OrderSplitForm_1"/>
                   <input type="hidden" name="catalogId" value="<c:out value="${catalogId}" />" id="WC_ProductAvailabilityDisplay_FormInput_catalogId_In_OrderSplitForm_1"/>
                </form>
                <form name="EntireOrderForm" method="post" action="OrderPrepare" id="EntireOrderForm">
                  <input type="hidden" name="URL" value="OrderDisplay?&amp;orderItemId*=&amp;quantity*=" id="WC_ProductAvailabilityDisplay_FormInput_URL_In_EntireOrderForm_1"/>
                  <input type="hidden" name="orderId" value="<c:out value="${WCParam.orderId}"/>" id="WC_ProductAvailabilityDisplay_FormInput_orderId_In_EntireOrderForm_1"/>
                  <input type="hidden" name="paymentMethod" value="<c:out value="${paymentMethod}"/>" id="WC_ProductAvailabilityDisplay_FormInput_paymentMethod_In_EntireOrderForm_1"/>
                  <input type="hidden" name="status" value="P" id="WC_ProductAvailabilityDisplay_FormInput_status_In_EntireOrderForm_1"/>
                  <input type="hidden" name="merge" value="*n" id="WC_ProductAvailabilityDisplay_FormInput_merge_In_EntireOrderForm_1"/>
                  <input type="hidden" name="remerge" value="*" id="WC_ProductAvailabilityDisplay_FormInput_remerge_In_EntireOrderForm_1"/>
                  <input type="hidden" name="check" value="*n" id="WC_ProductAvailabilityDisplay_FormInput_check_In_EntireOrderForm_1"/>
                  <input type="hidden" name="allocate" value="*aig" id="WC_ProductAvailabilityDisplay_FormInput_allocate_In_EntireOrderForm_1"/>
                  <input type="hidden" name="allocate" value="*ubg" id="WC_ProductAvailabilityDisplay_FormInput_allocate_In_EntireOrderForm_2"/>
                  <input type="hidden" name="backorder" value="*aig" id="WC_ProductAvailabilityDisplay_FormInput_backorder_In_EntireOrderForm_1"/>
                  <input type="hidden" name="backorder" value="*ubg" id="WC_ProductAvailabilityDisplay_FormInput_backorder_In_EntireOrderForm_2"/>
                  <input type="hidden" name="reverse" value="*n" id="WC_ProductAvailabilityDisplay_FormInput_reverse_In_EntireOrderForm_1"/>
                  <input type="hidden" name="langId" value="<c:out value="${langId}" />" id="WC_ProductAvailabilityDisplay_FormInput_landId_In_EntireOrderForm_1"/>
                   <input type="hidden" name="catalogId" value="<c:out value="${catalogId}" />" id="WC_ProductAvailabilityDisplay_FormInput_catalogId_In_EntireOrderForm_1"/>
                </form>
                <form name="MainForm" id="MainForm">
                  <table width="100%" border="0" cellspacing="0" cellpadding="0" id="WC_ProductAvailabilityDisplay_Table_9">
                    <%

/* Print out a message if there is an item with an unknown or discontinued availability date.
Users must delete these items before proceeding */
%>
<c:choose>
       <c:when test="${avail_unknown=='true' || discontinued=='true'}">
                    <tr>
                      <td colspan="2"  valign="top" class="warning" id="WC_ProductAvailabilityDisplay_TableCell_19"><fmt:message key="ProdAvail_Not_Backorderable" bundle="${storeText}"/><br /> <br /></td>
                    </tr>
       </c:when>
</c:choose>
<%
//-- *************  INVENTORY AVAILABLE **************** -->
//if all the orderitems are available, set the input parameter appropriately
%>
<c:choose>
       <c:when test="${bAllOrderItemsAvailable==true}">
                    <tr valign="top">
                      <td colspan="2" height="24" id="WC_ProductAvailabilityDisplay_TableCell_20"><fmt:message key="ProdAvail_AllAvail" bundle="${storeText}"/> <p> </p>
                        <input type="hidden" name="isAllItemsAvailable" value="true" id="WC_ProductAvailabilityDisplay_FormInput_isAllItemsAvailable_In_MainForm_1"/></td>
                    </tr>
                    <%
//otherwise there is at least one item that is on backorder %>
       </c:when>
       <c:otherwise>
       <%//if all the orderitems are on back order, set the input parameter appropriately%>
       <c:choose>
              <c:when test="${backorderable=='true' && bAllOrderItemsOnBackorder==true}">
                    <tr valign="top">
                      <td colspan="2" height="24" id="WC_ProductAvailabilityDisplay_TableCell_21"><strong><fmt:message key="ProdAvail_No_Avail_Items" bundle="${storeText}"/> (<c:out value="${latestAvailableDate }"/>).</strong> <p> </p>
                        <input type="hidden" name="isAllItemsAvailable" value="true" id="WC_ProductAvailabilityDisplay_FormInput_isAllItemsAvailable_In_MainForm_2"/></td>
                    </tr>
              </c:when>
               <c:when test="${backorderable=='true' && bAllOrderItemsOnBackorder==false}">
                    <%
       /* if there is at least one backorderable item and one non-backorderable item,
        then display the options*/%>
                    <tr valign="top">
                      <td colspan="2" id="WC_ProductAvailabilityDisplay_TableCell_22"><strong><fmt:message key="ProdAvail_Text1" bundle="${storeText}"/> </strong><br /> <input type="hidden" name="isAllItemsAvailable" value="false" id="WC_ProductAvailabilityDisplay_FormInput_isAllItemsAvailable_In_MainForm_3"/></td>
                    </tr>
                    <tr valign="top">
                      <td colspan="2" height="24" id="WC_ProductAvailabilityDisplay_TableCell_23"><label for="WC_ProductAvailabilityDisplay_FormInput_orderOption_In_MainForm_1"><fmt:message key="ProdAvail_Text2" bundle="${storeText}"/></label> <p> </p></td>
                    </tr>
                    <tr>
                      <td width="31" valign="top" height="25" id="WC_ProductAvailabilityDisplay_TableCell_24"> 
                      <input type="radio" name="orderOption" value="1" checked="checked" id="WC_ProductAvailabilityDisplay_FormInput_orderOption_In_MainForm_1"/>
                      </td>
                      <td width="100%" valign="top" height="25" id="WC_ProductAvailabilityDisplay_TableCell_25"><fmt:message key="ProdAvail_Option1" bundle="${storeText}"/> (<c:out value="${latestAvailableDate}"/>).</td>
                    </tr>
                    <tr>
                      <td width="31" valign="top" id="WC_ProductAvailabilityDisplay_TableCell_26"> 
                      <label for="WC_ProductAvailabilityDisplay_FormInput_orderOption_In_MainForm_2"></label>
                      <input type="radio" name="orderOption" value="2" id="WC_ProductAvailabilityDisplay_FormInput_orderOption_In_MainForm_2"/>
                      </td>
                      <td width="100%" valign="top" id="WC_ProductAvailabilityDisplay_TableCell_27"> <p><fmt:message key="ProdAvail_Option2" bundle="${storeText}"/> (<c:out value="${latestAvailableDate}"/>)</p></td>
                    </tr>
              </c:when>
       </c:choose>
       </c:otherwise>
</c:choose>
                  </table>
                  <br />
                  <c:url var="sWebAppPath" value="BillingShippingView">
                     <c:param name="orderId" value="${WCParam.orderId}"/>
                     <c:param name="paymentMethod" value="${WCParam.paymentMethod}"/>
                     <c:param name="landId" value="${WCParam.langId}"/>
                     <c:param name="catalogId" value="${WCParam.catalogId}"/>
                     <c:param name="storeId" value="${WCParam.storeId}"/>
                </c:url>
                  <p><a href="<c:out value="${sWebAppPath}"/>" class="button" id="WC_ProductAvailabilityDisplay_Link_3">
                    <!-- Would like to add these params eventually somehow: check=*n&merge=*n&remerge=*&allocate=*n&backorder=*n&reverse=*& -->
                     <fmt:message key="ProdAvail_Previous" bundle="${storeText}"/> </a>
                    <%// Hide the next button if non-backorderable items remain in the shopcart.%>
                    <c:choose>
                           <c:when test="${avail_unknown=='false' && discontinued=='false'}">
                                  &nbsp;<a href="#" onclick="GoToOrderSummary(document.MainForm); return false;" class="button" id="WC_ProductAvailabilityDisplay_Link_4">
                                  <fmt:message key="ProdAvail_Next" bundle="${storeText}"/></a>
                           </c:when>
                    </c:choose>
                  </p>
                </form></td>
            </tr>
          </tbody>
        </table>
        <!--content end-->
      </td>
    </tr>
  </tbody>
</table>

<%-- Hide CIP --%>
<c:set var="HideCIP" value="true"/>

<%@ include file="../../../include/LayoutContainerBottom.jspf"%>

</body>
<!-- END ProductAvailabilityDisplay.jsp -->

</html>
