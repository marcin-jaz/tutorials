<%--
/* 
 *-------------------------------------------------------------------
 * Licensed Materials - Property of IBM
 *
 * WebSphere Commerce
 *
 * (c) Copyright International Business Machines Corporation. 2004
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
  * This page lists current and pending shopping cart orders.  The following information is shown:
  *  - user instructions
  *  - table with one current order and other pending orders
  *  - "Select as Current Order" button
  *  - Order Description field for new orders
  *  - "Create a New Order" button 
  *****
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../include/JSTLEnvironmentSetup.jspf" %>
<%@ include file="../../include/ErrorMessageSetup.jspf"%>

<c:set var="liveHelpShoppingCartItems" value="0" />

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<!-- BEGIN ListOrdersDisplay.jsp -->
<head>
<title><fmt:message key="ListOrders_Title" bundle="${storeText}"/></title>
<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${vfileStylesheet}"/>" type="text/css"/>
<script language="javascript">
 
 	   function confirmRemove()
		{
			var agree=confirm("<fmt:message key="ListOrders_OrderDeleteConfirm" bundle="${storeText}" />");
			if (agree)
				return true ;
			else
				return false ;
		}
  
       function checkContractId(object) {
              var contraceId;               
              for (var i = 0;i < object.length;i++)
              {
                 if (object.options[i].selected == true) 
                 return(object.options[i].value);
              }
             return "0";
       }
           
       function updateForm(form)
       {                    
          form.URL.value = 'OrderCalculate?URL=OrderItemDisplay?storeId=<c:out value="${storeId}&langId=${langId}&catalogId=${catalogId}"/>&orderId=*&orderItemId*=&quantity*=&contract*=&updatePrices=1&calculationUsageId=-1';
          form.submit();              
       }

       function submitForm(formID)
       {
		   var form = document.getElementById(formID);
	       form.submit();
	   }

</script>

<flow:ifEnabled feature="customerCare"> 
<script language="javascript">
     if (typeof parent.setShoppingCartItems == 'function')
     parent.setShoppingCartItems(<c:out value="${liveHelpShoppingCartItems}"/>);              
</script>
</flow:ifEnabled> 
</head>

<c:set var="multipleActiveOrders" value="true" scope="request"/>
<flow:ifEnabled feature="MultipleActiveOrders">
	<c:set var="multipleActiveOrders" value="true" scope="request"/>	
</flow:ifEnabled>

<%-- Determine if store is a complex order store --%>
<wcbase:useBean id="storeBean" classname="com.ibm.commerce.common.beans.StoreDataBean" scope="page">
	<c:set property="storeId" target="${storeBean}" value="${WCParam.storeId}"/>
</wcbase:useBean>


<c:set var="pageToDisplay" value="${WCParam.OrderListPage}" />
	<c:if test="${empty pageToDisplay}">
		<c:set var="pageToDisplay" value="1" />
	</c:if>
<c:set var="pageSize" value="10"/>

<wcbase:useBean id="orderListBean" classname="com.ibm.commerce.order.beans.OrderListDataBean">
	<c:set target="${orderListBean}" property="currentPage" value="${pageToDisplay}"/>
	<c:set target="${orderListBean}" property="pageSize" value="${pageSize}"/>
	<c:set target="${orderListBean}" property="sortMethodId" value="7"/>     
	<c:set target="${orderListBean}" property="storeId" value="${CommandContext.storeId}"/>	
	<c:set target="${orderListBean}" property="retrievalOrderStatus" value="P"/>	
	<c:set target="${orderListBean}" property="userId" value="${userId}"/>
</wcbase:useBean>

<%-- get pageSize from OrderListDataBean again - if passed in page size is greater than max value, pageSize will set to max value --%>
<c:set var="pageSize" value="${orderListBean.pageSize}"/>


<c:set var="rowStart" value="${(pageToDisplay-1)*pageSize}"/>
<c:set var="rowsTotal" value="${orderListBean.numberOfOrders}"/>
<c:choose>
	<c:when test="${((pageToDisplay)*pageSize) > rowsTotal}">
	 	<c:set var="rowsDisplayed" value="${rowsTotal-rowStart}"/>
	</c:when>
	<c:otherwise>
	  	<c:set var="rowsDisplayed" value="${pageSize}"/>
	</c:otherwise>
</c:choose>
	       
		<c:if test="${rowsDisplayed < rowsTotal}">
	                <c:url var="ReloadWithParametersNextPageURL" value="${TrackOrderStatus}">
						<c:forEach var="parameter" items="${WCParamValues}" >
							<c:if test="${parameter.key != 'OrderListPage'}">
								<c:param name="${parameter.key}">
									<c:forEach var="value" items="${parameter.value}" >
										<c:out value="${value}" />
									</c:forEach>
								</c:param>
							</c:if>
						</c:forEach>
						<c:param name="OrderListPage" value="${pageToDisplay+1}"/>
					</c:url>
					<c:url var="ReloadWithParametersPrevPageURL" value="${TrackOrderStatus}">
						<c:forEach var="parameter" items="${WCParamValues}" >
							<c:if test="${parameter.key != 'OrderListPage'}">
								<c:param name="${parameter.key}">
									<c:forEach var="value" items="${parameter.value}" >
										<c:out value="${value}" />
									</c:forEach>
								</c:param>
							</c:if>
						</c:forEach>
						<c:param name="OrderListPage" value="${pageToDisplay-1}"/>
					</c:url>	       
	       </c:if>
	       
	       
	                  
<%-- get the current pending order --%> 
<c:set var="currentPendingOrderId" value="."  />
<wcbase:useBean id="orderListCurrentPendingOrderBean" classname="com.ibm.commerce.order.beans.OrderListDataBean">
	<c:set target="${orderListCurrentPendingOrderBean}" property="storeId" value="${CommandContext.storeId}"/>
	<c:set target="${orderListCurrentPendingOrderBean}" property="userId" value="${userId}"/>
	<c:set target="${orderListCurrentPendingOrderBean}" property="fetchCurrentPendingOrder" value="true"/>
</wcbase:useBean>
<c:forEach items="${orderListCurrentPendingOrderBean.orderDataBeans}" var="currentPendingOrder">
	<c:set var="currentPendingOrderStatus" value="${currentPendingOrder.status}"/>
	<c:if test="${currentPendingOrderStatus != 'X'}" >		
		<c:set var="currentPendingOrderId" value="${currentPendingOrder.orderId}"  />		
	</c:if>                                                                                                            	   	 	                 				
</c:forEach>  

<%-- Find the first non-current pending order --%> 
<c:set var="firstNonCurrentOrderSet" value="false"/>   
<c:set var="numberOfOrders" value="${orderListBean.numberOfOrders}" />                             
<c:forEach items="${orderListBean.orderDataBeans}" var="ordr">
	<c:set var="orderRn" value="${ordr.orderId}"/>
    <c:if test="${orderRn != currentPendingOrderId && !firstNonCurrentOrderSet }" >    	 
         <c:set var="firstNonCurrentOrder" value="${orderRn}" />
         <c:set var="firstNonCurrentOrderSet" value="true"/>                                                                                                      	
    </c:if>
</c:forEach> 

<%-- if no current pending order has been set, submit the form to create an entry based on the current order --%>
<c:choose>
<c:when test="${(currentPendingOrderId == null or currentPendingOrderId eq '.') and !empty orderListBean.orders}" > 
<body class="noMargin" onload="submitForm('WC_ListOrdersForm');" >  
</c:when> 
<c:otherwise>
<body class="noMargin" >
</c:otherwise>
</c:choose>  
 
           			
<flow:ifEnabled feature="customerCare"> 
<%
// Set header type needed for this JSP for LiveHelp.  This must
// be set before HeaderDisplay.jsp
request.setAttribute("liveHelpPageType", "personal");
%>
</flow:ifEnabled> 
 
<%@ include file="../../include/LayoutContainerTop.jspf"%>
       <img alt="<fmt:message key="Checkout_AccessibilityDescription" bundle="${storeText}" />" src="<c:out value="${jspStoreImgDir}" />images/trans.gif" width="1" height="1" border="0"/>
       <!-- content start -->      
	<table cellpadding="8" cellspacing="0" border="0" id="WC_ListOrdersDisplay_Table_2">
          <tbody>
            <tr>
              <td id="WC_ListOrdersDisplay_TableCell_3"> <p></p>
                <h1><fmt:message key="ListOrders_Title" bundle="${storeText}"/></h1>
                              <c:choose>
                              <c:when test="${'_ERR_RETRIEVE_PRICE.1002' eq storeError.key}">
                              <fmt:bundle basename="${jspStoreDir}storeErrorMessages">
                                                 <fmt:message key="${storeError.key}" var="pageErrorMessage">       
                                                        <fmt:param value="${storeError.messageParameters[4]}"/>
                                                 </fmt:message>
                                          </fmt:bundle>
                                          </c:when>
                                          <c:otherwise> 
                                                 <c:set var="pageErrorMessage" value="${errorMessage}"/>
                                          </c:otherwise>
                              </c:choose>
                              <c:if test="${!empty pageErrorMessage}">
                                           <p><span class="warning"><c:out value="${pageErrorMessage}"/></span><br />
                                              <br />
                                            </p>
                              </c:if>
               <p>
               <fmt:message key="ListOrders_Instructions" bundle="${storeText}"/>              
               </p> 
              <form name="ListOrdersForm" action="SetPendingOrder" method="post" id="WC_ListOrdersForm">
                  <input type="hidden" name="storeId" value="<c:out value="${storeId}"/>" id="WC_ListOrdersDisplay_FormInput_check_In_ShopCartForm_1"/>
                  <input type="hidden" name="catalogId" value="<c:out value="${catalogId}"/>" id="WC_ListOrdersDisplay_FormInput_merge_In_ShopCartForm_1"/>
                  <input type="hidden" name="langId" value="<c:out value="${langId}"/>" id="WC_ListOrdersDisplay_FormInput_remerge_In_ShopCartForm_1"/>
                  <input type="hidden" name="URL" value="ListOrdersDisplay" id="WC_ListOrdersDisplay_FormInput_URL_In_ShopCartForm_1"/>
                  
                 
                  <table cellpadding="0" cellspacing="0" border="0" width="100%" class="bgColor" id="WC_ListOrdersDisplay_Table_3">
                    <tbody>
                      <tr>
                        <td id="WC_ListOrdersDisplay_TableCell_4"> 
                        <table width="100%" border="0" cellpadding="2" cellspacing="1" class="bgColor" id="WC_ListOrdersDisplay_Table_4">                                                                          
                            <tr class="bgColor">
                              
                                      <th valign="top" class="colHeader" id="ListOrdersTH_RadioButton">&nbsp;</th>
                                    
                                      <th valign="top" class="colHeader" id="ListOrdersTH_OrderNumber"><fmt:message key="ListOrders_OrderNumber" bundle="${storeText}"/></th>
                                    
                                      <th valign="top" class="colHeader" id="ListOrdersTH_OrderDate"><fmt:message key="ListOrders_LastUpdate" bundle="${storeText}"/></th>
                                    
                                      <th valign="top" class="colHeader" id="ListOrdersTH_OrderDescription"><fmt:message key="ListOrders_DescriptionHeader" bundle="${storeText}"/></th>
                                    
                                      <th valign="top" class="colHeader_price" id="ListOrdersTH_TotalPrice"><span class="t_hd_rght"><fmt:message key="ListOrders_TotalPrice" bundle="${storeText}"/></span></th>
                                    
                                      <th valign="top" class="colHeader_last" id="ListOrdersTH_Icons">&nbsp;</th>
                                                                        
                            </tr>  
                            
                            <c:set var="sRowColor" value="cellBG_1"/>       
                                          
                   <c:choose>                         
                         <c:when test="${empty orderListBean.orders}">
              					<tr valign="top"  >
              						<td colspan="6" class="<c:out value="${sRowColor}"/> t_td" id="WC_ListOrdersDisplay_TableCell_5" >
              						<fmt:message key="ListOrders_NoPendingOrders" bundle="${storeText}"/>              						
              						</td> 
              					</tr>	
      					 </c:when>
                   		<c:otherwise>
                        
                            <c:set var="counter" value="0"/>
                            <c:set var="i" value="0"/>                             
                           
                                               
                            <c:forEach items="${orderListBean.orderDataBeansForCurrentPage}" var="order" >
                                                                                               
                                   	<c:set var="orderRn" value="${order.orderId}"/>                              	                            	
           	
           						<c:if test="${order.status != 'X' }" >	
                                   	<tr valign="top">
                                      
                                      <c:choose>
                                      <c:when test="${(currentPendingOrderId == null or currentPendingOrderId eq '.') and !empty orderListBean.orders}" > 
                                      	<label for="WC_ListOrdersDisplay_FormInput_1"></label>
                                      	<td class="<c:out value="${sRowColor}"/> t_td" id="WC_ListOrdersDisplay_TableCell_6"><input id="WC_ListOrdersDisplay_FormInput_1" class="radio" type="radio" name="orderId" <c:if test="${orderRn eq firstNonCurrentOrder}" > checked=checked </c:if>  value="<c:out value="${order.orderId}"/>" /></td>
                                      </c:when>
                                      <c:otherwise>
                                        <label for="WC_ListOrdersDisplay_FormInput_2"></label>
                                      	<td class="<c:out value="${sRowColor}"/> t_td" id="WC_ListOrdersDisplay_TableCell_7"><input id="WC_ListOrdersDisplay_FormInput_2" class="radio" type="radio" name="orderId" <c:if test="${orderRn eq currentPendingOrderId}" > checked=checked </c:if>  value="<c:out value="${order.orderId}"/>" /></td>
                                      </c:otherwise>                                               	
                                      </c:choose>                                      
                                      <td class="<c:out value="${sRowColor}"/> t_td" id="WC_ListOrdersDisplay_TableCell_8"><a href="OrderItemDisplay?langId=<c:out value="${langId}"/>&storeId=<c:out value="${storeId}"/>&catalogId=<c:out value="${catalogId}"/>&orderId=<c:out value="${order.orderId}"/>"><c:out value="${order.orderId}"/></a></td>
                                      <td class="<c:out value="${sRowColor}"/> t_td" align="center" width="100" id="WC_ListOrdersDisplay_TableCell_9">
                                      	<fmt:parseDate pattern="yyyy-MM-dd HH:mm:ss" value="${order.lastUpdate}" var="lastUpdate" />
                                      	<fmt:formatDate value="${lastUpdate}" pattern="yyyy-MM-dd" var="orderDate" />
                                      	<c:out value="${orderDate}" />
                                      </td>
                                      <td class="<c:out value="${sRowColor}"/> t_td" id="WC_ListOrdersDisplay_TableCell_10"><c:out value="${order.description}"/></td> 
                                      
                                      <td class="<c:out value="${sRowColor}"/> t_td" align="right" id="WC_ListOrdersDisplay_TableCell_11"> 
                                      	<c:if test="${order.formattedDiscountAdjustedProductTotal != null && order.formattedDiscountAdjustedProductTotal != '0.00'}" >
                                      		<c:set var="formattedTotalPrice" value="${order.formattedTotalProductPrice}"/>
                                    		<c:set var="formattedOrderItemDiscountTotal" value="${order.formattedOrderItemDiscountTotal}" />
                                    		<c:out value="${order.formattedDiscountAdjustedProductTotal}" escapeXml="false" />	
                                      	</c:if>
                                      </td>
                                      <td class="<c:out value="${sRowColor}"/> t_td" align="center" width="50" id="WC_ListOrdersDisplay_TableCell_12">
                                      <%-- Order Copy --%>                                     	  
					<c:url value="OrderCopy" var="OrderCopyUrl">
						<c:param name="fromOrderId_1" value="${orderRn}"/>
						<c:param name="toOrderId" value="**" />						    										    					
						<c:param name="copyOrderItemId_1" value="*"/>
						<c:param name="URL" value="OrderCalculate?URL=ListOrdersDisplay?orderId=${orderRn}&updatePrices=1&calculationUsageId=-1"/>		
						<c:param name="storeId" value="${storeId}"/>
						<c:param name="catalogId" value="${catalogId}"/>
						<c:param name="langId" value="${langId}"/>
						<c:param name="errorViewName" value="ListOrdersDisplay"/>													    					    							    	
		    			</c:url>																			
                                      	<a href="<c:out value='${OrderCopyUrl}'/>" id="WC_ListOrdersDisplay_Link_3_<c:out value="${i}"/>_<c:out value="${j}"/>" class="copy" title="<fmt:message key="ListOrders_Copy" bundle="${storeText}"/>">
						<img src="<c:out value="${jspStoreImgDir}"/>images/copy_icon3.gif" alt="<fmt:message key="ListOrders_Copy" bundle="${storeText}"/>" width="16" height="16" border="0" />
					</a> 
                                      
                                      <%-- Order Cancel --%>                											
										<c:choose>
											<c:when test="${orderRn eq currentPendingOrderId && numberOfOrders > 1}">			  
                                   				 
												<%-- If the order being removed is the current pending order --%>
												<%-- then set the current pending order to the first order on the pending order list --%>
												<c:url var="orderCancelURL" value="OrderCancel">
													<c:param name="storeId" value="${storeId}"/>			
													<c:param name="orderId" value="${orderRn}"/>
													<c:param name="catalogId" value="${catalogId}"/>
													<c:param name="URL" value="SetPendingOrder?orderId=${firstNonCurrentOrder}&storeId=${storeId}&catalogId=${catalogId}&URL=ListOrdersDisplay"/>									
												</c:url> 	
											</c:when>
											<c:otherwise>
												<c:url var="orderCancelURL" value="OrderCancel">
													<c:param name="storeId" value="${storeId}"/>			
													<c:param name="orderId" value="${orderRn}"/>
													<c:param name="catalogId" value="${catalogId}"/>
													<c:param name="URL" value="ListOrdersDisplay"/>									
												</c:url> 	
											</c:otherwise>
										</c:choose>																			
                                      	<a onclick="return confirmRemove()" href="<c:out value="${orderCancelURL}"/>" id="WC_ListOrdersDisplay_Link_3_<c:out value="${i}"/>_<c:out value="${j}"/>" class="garbage" title="<fmt:message key="ListOrders_Remove" bundle="${storeText}"/>">
							      			<img src="<c:out value="${jspStoreImgDir}"/>images/garbage3.gif" alt="<fmt:message key="ListOrders_Remove" bundle="${storeText}"/>" width="16" height="16" border="0" />
							      		</a>                                      
                                      </td> 
                                      </tr>
                                     </c:if>
                      				<c:set var="i" value="${i+1}"/>
                      				
              				</c:forEach>
              
                      </c:otherwise>
                      </c:choose>
                                          
                      </table>
                      </td>
                      </tr>
                      
                      
                    </tbody>
                  </table>
                 </form>
               
    			<%-- Pagination links --%>    			
    			<c:if test="${!empty orderListBean.orders}">
    			<c:if test="${rowsDisplayed < rowsTotal}">
                 <table cellpadding="0" cellspacing="0" border="0" id="WC_ListOrdersDisplay_Table_6">
                  <tbody>
                    <tr>
                      <td align="right" width="580" id="WC_ListOrdersDisplay_TableCell_13">
   				<fmt:message key="HUD_Page_Results" bundle="${storeText}">
						<fmt:param value="${rowStart + 1}"/>
						<fmt:param value="${rowStart + rowsDisplayed}"/>
						<fmt:param value="${rowsTotal}"/>
				</fmt:message>
				<c:if test="${pageToDisplay > 1}">
					&nbsp;
					<a href="<c:out value="${ReloadWithParametersPrevPageURL}" />" id="WC_OrderStatusDisplay_Link_17b">
						<fmt:message key="HUD_Page_Prev" bundle="${storeText}" />
					</a>
				</c:if>
				<c:if test="${rowsTotal > (rowStart + rowsDisplayed)}">
					&nbsp;
					<a href="<c:out value="${ReloadWithParametersNextPageURL}" />" id="WC_OrderStatusDisplay_Link_17c">
						<fmt:message key="HUD_Page_Next" bundle="${storeText}" />
					</a>
				</c:if>
        </td>
                	 </tr>
                	</tbody>
                	</table>  
                	</c:if>
                	</c:if>
                <%-- Select as Current Order --%>
                 <c:if test="${!empty orderListBean.orders}">
                 <table cellpadding="0" cellspacing="0" border="0" id="WC_ListOrdersDisplay_Table_6">
                  <tbody>
                    <tr>
                      <td width="580" id="WC_ListOrdersDisplay_TableCell_13">                        
                		<br />                												
                        <a  href="javascript:submitForm('WC_ListOrdersForm')" id="WC_ListOrdersDisplay_Link_3_<c:out value="${i}"/>_<c:out value="${j}"/>" class="button" >
							<fmt:message key="ListOrders_Select" bundle="${storeText}"/>
						</a>   		                		
                 		<br />
                	  </td>
                	 </tr>
                	</tbody>
                	</table>  
                	</c:if>
                <%-- End Select as Current Order --%>
                <br />
                <%-- Create a new order --%>
                <form name="OrderCreateForm" action="OrderCreate" method="post" id="WC_OrderCreateForm">
                  <input type="hidden" name="storeId" value="<c:out value="${storeId}"/>" id="WC_ListOrdersDisplay_FormInput_storeId_In_ShopCartForm_1"/>
                  <input type="hidden" name="catalogId" value="<c:out value="${catalogId}"/>" id="WC_ListOrdersDisplay_FormInput_catalogId_In_ShopCartForm_1"/>
                  <input type="hidden" name="langId" value="<c:out value="${langId}"/>" id="WC_ListOrdersDisplay_FormInput_langId_In_ShopCartForm_1"/>               
                  <input type="hidden" name="URL" value="ListOrdersDisplay" id="WC_ListOrdersDisplay_FormInput_URL_In_ShopCartForm_1"/>
                      
                 <table cellpadding="0" cellspacing="0" border="0" id="WC_ListOrdersDisplay_Table_7">
                  <tbody>
                     <tr >
                              <td id="WC_ListOrdersDisplay_TableCell_14"> 
                              	<label for="WC_ListOrdersDisplay_FormInput_4"><fmt:message key="ListOrders_Description" bundle="${storeText}"/></label>                                                         
                              </td>
                      </tr>
                      <tr>        
                              <td id="WC_ListOrdersDisplay_TableCell_15">
                              <input class="input" type="text" size="50" name="description" id="WC_ListOrdersDisplay_FormInput_4"/>
                              </td>                                                           
                            </tr> 
                	</tbody>
                	</table>  
                <%-- Create button --%>
                 <table cellpadding="0" cellspacing="0" border="0" id="WC_ListOrdersDisplay_Table_8">
                  <tbody>
                    <tr>
                      <td width="580" id="WC_ListOrdersDisplay_TableCell_16">                       		
						<a href="javascript:submitForm('WC_OrderCreateForm')" class="button" id="WC_ListOrdersDisplay_Link_4">
							<fmt:message key="ListOrders_Create" bundle="${storeText}"/>
						</a>                     
                      	<br />
                	  </td>
                	 </tr>
                	</tbody>
                	</table>  
                <%-- End Create button --%>	                	
                	
                <%-- End Create a new order --%>          
                
                
              </td>
            </tr>
          </tbody>
        </table>
        <!--content end-->

<%-- Hide CIP --%>
<c:set var="HideCIP" value="false"/>

<%@ include file="../../include/LayoutContainerBottom.jspf"%>

</body>
<!-- END ListOrdersDisplay.jsp -->
</html>

	
