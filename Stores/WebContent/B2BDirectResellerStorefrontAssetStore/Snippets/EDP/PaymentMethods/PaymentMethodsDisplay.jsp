<%
//********************************************************************
//*-------------------------------------------------------------------
//* Licensed Materials - Property of IBM
//*
//* WebSphere Commerce 
//*
//* (c) Copyright IBM Corp. 2005, 2009
//*
//* US Government Users Restricted Rights - Use, duplication or
//* disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
//*
//*-------------------------------------------------------------------
//*
//*---------------------------------------------------------------------
//* The sample contained herein is provided to you "AS IS".
//*
//* It is furnished by IBM as a simple example and has not been  
//* thoroughly tested
//* under all conditions.  IBM, therefore, cannot guarantee its 
//* reliability, serviceability or functionality.  
//*
//* This sample may include the names of individuals, companies, brands 
//* and products in order to illustrate concepts as completely as 
//* possible.  All of these names
//* are fictitious and any similarity to the names and addresses used by 
//* actual persons 
//* or business enterprises is entirely coincidental.
//*---------------------------------------------------------------------
//*
%>

<%-- 
  ***
  * (Advanced orders) This JSP snippet is used to display the following information: 
  *	- Available Payment Methods in a pre-populated list box.
  *	- Upon the selection of a particular payment method, it displays the payment properties
  *	   pertaining to that payment method. The VISA payment method is displayed by default.
  *
  * Parameters:
  * 
  * -showPIId
  * This value is used to indicate if the payment instruction ID should be displayed in the page for testing and debug purposes.
  * 
  * -orderId
  *	This value is the order number for which the payment method is created.
  *	If this parameter is not passed, the order number in the input parameters of the HTTP request will be used.
  * 
  * -doNotCollectPaymentForZeroAmount
  * This flag is used to indicate whether to show the payment collection form for an order with a zero total amount.
  * 
  * -showTitleForSection
  * This flag is used to indicate whether to display the title for the payment section. If the parameter is not set, use the default 
  * value of false.
  * 
  * -quickCheckout
  * This flag is used to indicate whether this is a quick checkout flow. If it is a quick checkout flow,
  *  retrieve the payment method and the protocol data from the profile.
  * 
  * -defaultPaymentMethodName
  * The default selected payment method name. The default value for the default selected payment method name is VISA.
  * 
  * -showScheduleOrder
  * This flag is used to indicate whether to show the schedule order section.
  * 
  * -showPONumber
  * This flag indicates whether the input field for the purchase order should be displayed.
  *  If the parameter is not set, check the order data bean to see if a purchase order number is required;
  *  If a purchase order number is required, the field will be displayed; otherwise, the field will not be displayed.
  * 
  * -previousURL
  * The URL for the previous page.
  * 
  * -cmdStoreId (optional)
  * Pass this parameter and its value to any command that will be executed in this page. If this value is set then the
  * storeId will not be passed to the executing command.
  *
  *
  * How to use this snippet?
  * 1. This snippet is available under the following directory: <WC_installdir>/samples/Snippets/web/EDP/PaymentMethods
  *     or  <WCDE_installdir>\samples\Snippets\web\EDP\PaymentMethods.
  * 2. You can use this snippet in your xxx.jsp in either of the following two ways:
  *		A. Copy and paste the entire code into your xxx.jsp.
  *		B. Import the snippet as follows: 
  *		<c:import url="${jspStoreDir}Snippets/EDP/PaymentMethods/PaymentMethodsDisplay.jsp" />
  *			<c:param name="showPIId" value="true"/>   displays the payment instruction ID --- for testing and debug purposes only
  *			<c:param name="orderId" value="<orderId>"/> the order id
  *         <c:param name="previousURL" value"<PreviousURL>"/> previous page
  *			<c:param name="doNotCollectPaymentForZeroAmount" value="true"/> does not show payment collection form when the order
  *			                                                                total amount is 0
  *         <c:param name="quickCheckout" value="true}"/> if true then payment and billing address info are in 
  *                                                       payinfo
  *         <c:param name="defaultPaymentMethodName" value="VISA"/> specifies the default payment method to be
  *                                                                 used. The name should match an POLICY table
  *                                                                 name. If not specified VISA is used.
  *         <c:param name="showScheduleOrder" value="true"/> allows the a scheduled order to be created using the
  *                                                          the checkout information
  *         <c:param name="showPONumber" value="true"/> specifies whether to show PONumber input fields. If the
  *                                                     order requires a purchase order number to specified that will
  *                                                     override this setting.
  *         
  *		</c:import> 
  *****
--%>


<!-- Start - JSP File Name: PaymentMethodsDisplay.jsp -->

<% try { %>

<!-- Set the taglib -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>

<%-- Include the EDP environment setup snippet --%>
<%@ include file="../EDPEnvironmentSetup.jspf"%>

<%-- ErrorMessageSetup.jspf is used to retrieve an appropriate error message when there is an error--%>
<%@ include file="../../../include/ErrorMessageSetup.jspf" %>
 
<!-- get the value of the parameter showPIId -->
<c:set var="showPIId" value="${param.showPIId}"/>
<!-- get the value of the parameter orderIdRn; if it is empty, get the order number from the request properties  -->
<c:set var="orderIdRn" value="${param.orderId}"/>
<c:if test="${empty orderIdRn}">
	<c:set var="orderIdRn" value="${WCParam.orderId}"/>
</c:if>

<c:set var="targetAction" value="OrderProcess"/>
<flow:ifEnabled feature="GiftRegistry">
	<c:set var="targetAction" value="GiftRegistryOrderProcess"/>
</flow:ifEnabled>

<!-- get the usable payment TC list for the order -->
<wcbase:useBean id="edp_PaymentTCBean" classname="com.ibm.commerce.payment.beans.UsablePaymentTCListDataBean"  scope="request" >
	<c:set property="orderId" value="${orderIdRn}" target="${edp_PaymentTCBean}"  />
</wcbase:useBean>
<!-- get the order databean -->
<wcbase:useBean id="edp_OrderBean" classname="com.ibm.commerce.order.beans.OrderDataBean" >
	<c:set property="orderId" value="${orderIdRn}" target="${edp_OrderBean}"  />
</wcbase:useBean>

<!-- get the flag to indicate whether to display the payment collection form for the order with total amount zero. -->
<c:if test="${param.doNotCollectPaymentForZeroAmount}">
	<c:set var="doNotCollectPaymentForZeroAmount" value="true"/>
</c:if>

<!-- get the flag to indicate whether to display the title for the payment section -->
<c:set var="showTitleForSection" value="false"/>
<c:if test="${param.showTitleForSection}">
	<c:set var="showTitleForSection" value="true"/>
</c:if>

<c:if test="${param.showBanner}">
	<c:set var="showBanner" value="true"/>
</c:if>

<!-- get the current billing address -->
<c:set var="billingAddressId" value="${edp_OrderBean.addressId}"/>
<!-- get the flag to indicate whether this is a quick checkout flow. If it is a quick checkout flow,
     retrieve the payment method and the protocol data from the profile -->
<c:if test="${param.quickCheckout eq true}">
    <!-- it's a quick checkout -->
	<c:set var="quickCheckout" value="true"/>
		
    <!-- get the "profile" order containing the default payment and billing info -->
	<wcbase:useBean id="orderListBean" classname="com.ibm.commerce.order.beans.OrderListDataBean" scope="request"> 
       	<c:set target="${orderListBean}" property="storeId" value="${WCParam.storeId}"/>
       	<c:set target="${orderListBean}" property="userId" value="${CommandContext.userId}"/>   
       	<c:set target="${orderListBean}" property="retrievalOrderStatus" value="Q"/>
    </wcbase:useBean>  
		
	<c:forEach items="${orderListBean.orderDataBeans}" var="prof_orderBean" varStatus="status">
		<c:set var="payInfo" value="${prof_orderBean.paymentInfo}" />
		<c:if test="${!empty payInfo}">
		    <c:set var="edp_ProtocolData" value="${payInfo}"  scope="request"/>
		</c:if>
		<c:set var="billingAddressId" value="${prof_orderBean.addressId}"/>
	</c:forEach>
	
</c:if>

<!-- get the default selected payment method name. The default value for the default selected payment method name is "VISA" -->
<c:set var="defaultPaymentMethodName" value="VISA"/>
<c:if test="${!empty param.defaultPaymentMethodName}">
	<c:set var="defaultPaymentMethodName" value="${param.defaultPaymentMethodName}"/>
</c:if>

<!-- get the flag to indicate whether to show the schedule order section -->
<c:if test="${!empty param.showScheduleOrder}">
	<c:set var="showScheduleOrder" value="${param.showScheduleOrder}"/>
</c:if>

<!-- check if the input field for purchase order number should be displayed.
     If the parameter is not set, check the order databean to see if purchase order number is required;
     If required, the field will be displayed, otherwise the field will not displayed. -->
<c:set var="showPONumber" value="false"/>
<c:set var="requiredPONumber" value="${edp_OrderBean.purchaseOrderNumberRequired}"/>
<c:choose>
<c:when test="${empty param.showPONumber}">
    <c:if test="${requiredPONumber}">
		<c:set var="showPONumber" value="true"/>
	</c:if>
</c:when>
<c:otherwise>
	<c:set var="showPONumber" value="${param.showPONumber}"/>
</c:otherwise>
</c:choose>

<%--
  ***
  *	Determine if shopper is Registered or a Guest Shopper.  If guest shopper, then email will not be sent to shopper after order is placed.
  ***
--%>
<c:set var="emailShopper" value="1" scope="request"/>
<c:if test="${userType eq 'G'}">
	<c:set var="emailShopper" value="0" scope="request" />
</c:if>

<table width="100%" id="EDP_PaymentMethods_Table_1">

    <!-- The debug section: list the snippet parameters and WC request parameter -->
    <c:if test="${EDPPaymentMethodsDebug}">
    
        <tr>
        	<c:out value="payInfo"/>
        </tr>
        <c:forEach var="payInfoParm" items="${payInfo}">
            <tr>
				<c:out value="key = ${payInfoParm.key} value = ${payInfoParm.value}"/>
			</tr>
	    </c:forEach>
	    <hr />
        <tr>
        	<c:out value="paramValues"/>
        </tr>
        <c:forEach var="aParam" items="${paramValues}" varStatus="paramStatus">
	    	    <tr>
	    	        <c:out value="key = ${aParam.key}"/>
					<c:forEach var="aValue" items="${aParam.value}"  varStatus="paramNumStatus">
						<c:out value="value = ${aValue}"/>
					</c:forEach>
				</tr>
		</c:forEach>
		
		<hr />
	    <tr>
 	    	<c:out value="WCParamValues"/>
 	    </tr>	
		<c:forEach var="aParam" items="${WCParamValues}" varStatus="paramStatus">
	    	    <tr>
	    	        <c:out value="key = ${aParam.key}"/>
					<c:forEach var="aValue" items="${aParam.value}"  varStatus="paramNumStatus">
						<c:out value="value = ${aValue}"/>
					</c:forEach>
				</tr>
		</c:forEach>
		
		<hr />
	
    </c:if>
    <!-- check if the available payment methods section should be displayed. 
         If the order total amount is zero and the flag doNotCollectPaymentForZeroAmount is true, the available payment methods
         sestion will not displayed -->
    <c:set var="showAvailablePaymentMethods" value="true"/>
    <c:set var="orderTotal" value="${edp_OrderBean.grandTotal.amount}"/>
    <c:if test="${empty edp_PaymentTCBean.filteredPaymentTCInfo}">
        <c:set var="showAvailablePaymentMethods" value="false"/>
    </c:if>
    <c:if test="${edp_OrderBean.grandTotal.amount == 0.0 && doNotCollectPaymentForZeroAmount}">
    	<c:set var="showAvailablePaymentMethods" value="false"/>
    </c:if>
    
    <!-- Show the title for the section of payment method selection -->
    <c:if test="${showTitleForSection}">
		<tr>
	    	<td>
	    		<table width="605" border="0" cellpadding="0" id="EDP_PaymentMethods_Table_2">
	            	<tbody>
	                	<tr> 
	                    	<td class="bgColor" height="19" width="605" id="EDP_PaymentMethods_TableCell_55"> 
	                        	<table id="EDP_PaymentMethods_Table_3">
	                            	<tbody>
	                              		<tr> 
	                                		<td valign="top" class="colHeader" id="EDP_PaymentMethods_TableCell_56"><fmt:message key="EDPPaymentMethods_PAY_INFO" bundle="${edpText}"/>
	                                		</td>
	                              		</tr>
	                            	</tbody>
	                          	</table>
	                         </td>
	                    </tr>
	                </tbody>
	            </table>
	    	</td>
	    </tr>
    </c:if>
    
    <c:if test="${showPONumber eq true}">
            <!-- The form for the purchase order number -->
            <form name="PONumberInfo"  id="PONumberInfo">
	    <tr>
	    	<td>
			<h2><fmt:message key="EDPPaymentMethods_PURCHASE_ORDER_INFO" bundle="${edpText}" /></h2>
		</td>
	    </tr>
	    <tr>
		<td>				
			<label for="purchaseorder_id1">
				<c:if test="${requiredPONumber}">
					<span class="required">*</span>
				</c:if>
				<fmt:message key="EDPPaymentMethods_PURCHASE_ORDER" bundle="${edpText}" />		
			</label>
		</td>
	    </tr>
	    <tr>
		<td valign="middle" id="PaymentMethodsDisplay_TableCell_46">
			<c:if test="${!empty edp_OrderBean.purchaseOrderNumber}">
			      <input class="input" type="text" name = "purchaseorder_id" id="purchaseorder_id1" value ="<c:out value="${edp_OrderBean.purchaseOrderNumber}" />" id="PaymentMethodsDisplay_InputText_46" />
			</c:if>
			<c:if test="${empty edp_OrderBean.purchaseOrderNumber}">
			      <input class="input" type="text" name = "purchaseorder_id" id="purchaseorder_id1" value ="<c:out value="${WCParam.purchaseorder_id}" />" id="PaymentMethodsDisplay_InputText_46" />
      			</c:if>                                   
		</td>
	    </tr>
	    <tr>
		<td class="c_line" id="PaymentMethodsDisplay_TableCell_47_1">&nbsp;</td>
	    </tr>
	    </form>
    </c:if>
    
	<%--
		*********************
		* This row will contain all the existing payment intructions for the order (in sub-rows)
		*********************
	--%>
	
	<tr>
		<td colspan="4" valign="middle">
		
				<c:forEach items="${edp_OrderBean.paymentInstructions}" var="edp_payInst" varStatus="paymethodCnt">
				    <c:set var ="edp_Inst" value="${edp_payInst.paymentInstruction}"/>
					<c:set var ="edp_PaymentMethod" value="${edp_Inst.paymentMethod}" scope="request"/>
				    <c:set var ="edp_PayMethodId" value="${edp_Inst.id}" scope="request" />
				    
				    <c:set var ="edp_ProtocolData" value="${edp_Inst.protocolData}" scope="request"  />
				    
				    <c:forEach items="${edp_ProtocolData}" var="edp_pdata" >
				    	<c:if test="${edp_pdata.key == 'cardBrand' || edp_pdata.key =='cc_brand'}">
				    		 <c:set var ="edp_cardBrand" value="${edp_pdata.value}" />
				    	</c:if>
				    	<!--  
				        <tr>
				    		<td><c:out value="${edp_pdata.key} = ${edp_pdata.value}" /></td>
				    	</tr>
				    	-->
				    </c:forEach>
				    
				    <c:set var ="edp_PayMethodAmount" value="${edp_payInst.formattedAmount.primaryPrice.value}" scope="request"/>
				    
				    <c:set var ="edp_PIID" value="${edp_Inst.id}" scope="request"/>
				    <c:set var ="edp_Edit_Form" value="PIInfoEdit_${edp_PIID}" scope="request"/>
				    <form name="<c:out value="${edp_Edit_Form}"/>" method="post" action="PIEdit">
						<input type="hidden" name="orderId" value="<c:out value="${orderIdRn}"/>" /> 
						<input type="hidden" name="URL" value="OrderDisplay?allocate=*n&backorder=*n&reverse=*n&remerge*n" />
						<c:choose>
							<c:when test="${empty param.cmdStoreId}">
								<input type="hidden" name="storeId" value="<c:out value="${WCParam.storeId}" />" />
							</c:when>
							<c:otherwise>
								<input type="hidden" name="cmdStoreId" value="<c:out value="${param.cmdStoreId}" />" />
							</c:otherwise>
						</c:choose>
						<input type="hidden" name="langId" value="<c:out  value="${CommandContext.languageId}" />" />
						<input type="hidden" name="catalogId" value="<c:out  value="${WCParam.catalogId}" />" />
			            <input type="hidden" name="errorViewName" value="DoPaymentErrorView"  />
						<input type="hidden" name="payMethodId" value="<c:out  value="${edp_PaymentMethod}" />" />
						<input type="hidden" name="payment_method" value="<c:out  value="${edp_PaymentMethod}" />" />
						
						<input type="hidden" name="piId" value="<c:out  value="${edp_PIID}" />" />
						<input type="hidden" name="policyId" value="<c:out value="${edp_Inst.policyId}"/>" />
						<input type="hidden" name="authToken" value="${authToken}" id="WC_PaymentMethodsDisplay_FormInput_PIEdit_authToken_1"/>
			   			<table>
			   	        <c:set var="edp_edit_shown" value="false"/>
						<c:forEach items="${edp_PaymentTCBean.paymentTCInfo}" var="edp_Info" >
						
							<c:if test="${ !empty edp_Info.attrPageName }" >
								
								<%--
								************************
								* Start : Gets the attribute Page name for the selected Payment method
								************************
								--%>								
								<c:if test="${edp_Info.policyName == edp_PaymentMethod && (edp_Info.brand =='' || edp_Info.brand == edp_cardBrand )&& edp_edit_shown == false}" >
									<c:set var ="edp_AttrPageName" value="${edp_Info.attrPageName}" />
									<c:set var ="edp_PaymentMethodName" value="${edp_Info.shortDescription}" />
									<c:set var="edp_edit_shown" value="true"/>
									
								<%--
								************************
								* End : Gets the attribute Page name for the selected Payment method
								************************
								--%>
									
									
									<%-- 
									***********************
									* optionally show the payment method id 
									* this should not be externalized. It is only for demo purposes or debug
									***********************
									--%>
									<c:if test="${showPIId}" >
										<tr>
											<td align="left" id="EDP_PaymentMethods_TableCell_63">
												<c:out value="PIid = ${edp_PIID}"/>
											</td>
										</tr>
									</c:if>
									<tr>
										<td align="left" colspan="4" valign="top">
									
											<%--
											********************
											* Start:  gets and includes the full path of the attribute page name with the extension as .jsp
											********************
											--%>
											
											<table border="0" cellpadding="2" cellspacing="1" class="bgColor" id="EDP_PaymentMethods_Table_15_<c:out value='${paymethodCnt.count}'/>">
												<tr>
													<td class="cellBG_1">
														<h2><c:out value="${edp_PaymentMethodName}"/></h2>
													</td>
												</tr>
												<tr>
													<td class="cellBG_1">
														<c:if test="${!empty edp_AttrPageName}">
															<c:set var="edp_AttrPageFullPath" value="${snippetJspStoreDir}Snippets/EDP/PaymentMethods/${edp_AttrPageName}.jsp" />
															<c:set var ="edp_PI_Form" value="${edp_Edit_Form}" scope="request"/>
															<c:import url="${edp_AttrPageFullPath}" >
																<c:param name="paramNumStatus" value="${paymethodCnt.count}" />
																<c:param name="PI_EditForm" value="PIInfoEdit_${edp_PIID}" />
																<c:param name="showPONumber" value="${showPONumber}" />
																<c:param name="hideRemainingAmount" value="true" />
															</c:import>
														</c:if>
														<%--
														****************
														*
														****************
														--%>
														<table border="0" cellpadding="2" cellspacing="1" id="EDP_PaymentMethods_Table_16_<c:out value='${paymethodCnt.count}'/>">
															<tr class="cellBG_1">
																<c:url var="EDP_PIRemoveURL" value="PIRemove">
																	<c:param name="orderId" value="${orderIdRn}" />
																	<c:param name="piId" value="${edp_PIID}" />
																	<c:param name="URL" value="OrderDisplay?allocate=*n&backorder=*n&reverse=*n&remerge*n" />
																	<c:choose>
																		<c:when test="${empty param.cmdStoreId}">
																			<c:param name="storeId" value="${WCParam.storeId}" />
																		</c:when>
																		<c:otherwise>
																			<c:param name="cmdStoreId" value="${param.cmdStoreId}" />
																		</c:otherwise>
																	</c:choose>
																	
																	<c:param name="langId" value="${CommandContext.languageId}" />
																	<c:param name="catalogId" value="${WCParam.catalogId}" />
																</c:url>
																<td valign="middle" id="EDPPaymentMethods_TableCell_33_<c:out value='${paymethodCnt.count}'/>">
																	<a href="#"	onclick="EDP_submitPIInfo(document.<c:out value="PIInfoEdit_${edp_PIID}"/>); return false;" class="button" id="EDP_PaymentMethodsDisplay_Link_33_<c:out value='${paymethodCnt.count}'/>" >
																		<fmt:message key="EDPPaymentMethods_EDIT_PAYMENT_METHOD" bundle="${edpText}" />
																	</a>
																</td>
																<td valign="middle" id="EDPPaymentMethods_TableCell_34_<c:out value='${paymethodCnt.count}'/>">
																	<a href="<c:out value="${EDP_PIRemoveURL}"/>" onclick="document.EDP_PaymentMethodsDisplayForm.submit()"  class="button" id="EDP_PaymentMethodsDisplay_Link_34_<c:out value='${paymethodCnt.count}'/>" >
																		<fmt:message key="EDPPaymentMethods_REMOVE_PAYMENT_METHOD" bundle="${edpText}" />
																	</a>
																</td>
															</tr>
														</table>
													</td>
												</tr>
												
													
												
											</table>
											<table class="t_table" id="EDP_PaymentMethods_Table_14_<c:out value='${paymethodCnt.count}'/>">
												<tr>
														<td class="c_line" id="PaymentMethodsDisplay_TableCell_47_2_<c:out value='${paymethodCnt.count}'/>">&nbsp;</td>
												</tr>
											</table>
											<%--
											********************
											* End:  gets and includes the full path of the attribute page name with the extension as .jsp
											********************
											--%>
								    
										</td>
									</tr>
																		
									
								</c:if>
							</c:if>
					    </c:forEach>
						</table>
					</form>
					
				</c:forEach>
					
		</td>
			
	</tr>
	<%--
	*********************
	* This is the end of the existing payment intructions for the order (in sub-rows)
	*********************
	--%>


  <c:if test="${showAvailablePaymentMethods}">
	    
	
	<c:set var="remainingAmt" value="${edp_OrderBean.paymentAmountRemaining.primaryPrice.value}" scope="request"/>
	<%--
	*********************
	* This row will contain payment intructions available for selection and a form for the currently
	* selected payment method that can be added to the order
	*********************
	--%>
	
	<tr>
		<td>
			<table width="100%" cellpadding="0" cellspacing="0" border="0" id="EDP_PaymentMethodsDisplay_Table_10">
				<tr>
					<td colspan="2" id="EDP_PaymentMethodsDisplay_TableCell_13b">
						<table border="0" cellpadding="2" cellspacing="1" class="bgColor" id="EDP_PaymentMethods_Table_11">
							<tr>
								<td class="cellBG_1">
									<h2><fmt:message key="EDPPaymentMethods_ADD_PAYMENT_METHOD_TITLE" bundle="${edpText}"/></h2>
								</td>
							</tr>
							<tr>
								<td class="cellBG_1 t_td2">
									<%--
				                      ***
					                  *	Start: Error handling
					                  * Show an appropriate error message when there is an error processing the payment information.
					                  ***
				                 	--%>
							        <c:set var ="EDPREMOVE" value ='-3' />
		                            <c:set var ="EDPEDIT" value ='-2' />
		                            <c:set var = "EDPADD" value = '-1' />
		                            <%--
		                            *******************
		                            * debug
		                            *******************
		                            --%>
		                            
		                            <wcbase:useBean id="error" classname="com.ibm.commerce.beans.ErrorDataBean" scope="page"/>
		                            <c:if test="${EDPPaymentMethodsDebug}">
			                            <c:out value="errorMessage = ${errorMessage}"/>
			                            <c:out value="errorMessage = ${error.exceptionData}"/>
			                        </c:if>
		                            
			                        <c:if test="${!empty errorMessage}">				 
					                	<c:forEach var="returnKey" items="${error.exceptionData}">
					    	            	<c:if test="${returnKey.key eq 'EDP'}">
						                    	<c:set var="msglist" value="${returnKey.value}"/>
	                                    	</c:if>
	                                        <c:if test="${returnKey.key eq 'EDPPI'}">
						                    	<c:set var="pi" value="${returnKey.value}"/>
	                                        </c:if>    	
					                    </c:forEach>				  
	                                    <c:choose>                 				
			                                <c:when  test="${pi eq  edp_PIID}">
		                                        <c:if test="${!empty msglist}">
							                    	<c:forEach var="msg" items="${msglist}" >
							                        	<span class="error"><br/><c:out value=" ${msg}"/><br/><br/></span>
							                    	</c:forEach>
		                                        </c:if>
		                                    </c:when>                    
		                                    <c:when  test="${pi eq  EDPREMOVE || pi eq  EDPEDIT || pi eq  EDPADD}">
		                                    	<c:if test="${!empty msglist}">
							                   		<c:forEach var="msg" items="${msglist}" >					      			        
							                        	<span class="error"><br/><c:out value=" ${msg}"/><br/><br/></span> 
							                    	</c:forEach>
		                                    	</c:if>
		                                    </c:when>
		                                    <c:otherwise>
		                                    <c:if test="${!empty msglist}">
							                   		<c:forEach var="msg" items="${msglist}" >					      			        
							                        	<span class="error"><br/><c:out value=" ${msg}"/><br/><br/></span> 
							                    	</c:forEach>
		                                    	</c:if>
		                                    </c:otherwise>
	                                    </c:choose>             	
		                            </c:if>	
							        
									<%--
									********************
									* Start:  Displays the avialble Payment methods in a pre-populated list box
									********************
									--%>
									<form id="EDP_PaymentMethodsDisplayForm" action="" name="EDP_PaymentMethodsDisplayForm" method="post" >
		    						<input type="hidden" name="orderId" value="<c:out value="${orderIdRn}"/>" />
									<table border="0" cellpadding="2" cellspacing="1" id="EDP_PaymentMethods_Table_12">
										<tr>
											<td align="left" valign="top"  id="EDP_PaymentMethodsDisplay_TableCell_11">
												<label for="EDP_PaymentMethodsDisplay_FormInput_paymentMethod_In_PaymentMethodsDisplayForm_1"><span class="required">*</span><fmt:message key="EDPPaymentMethods_PAY_METHOD_DISPLAY" bundle="${edpText}"/></label>
											</td>
											<%--
											***************************
											* Start: Determine selected payment in drop down list.
											***************************
											--%>
											
												
											<%--
											***************************
											* Start: Determine selected payment in drop down list.
											* It is either the defaultPaymentMethodName or the first in the list
											***************************
											--%>
												
												
											<c:if test="${!empty edp_PaymentTCBean.paymentTCInfo}">
												<c:forEach items="${edp_PaymentTCBean.paymentTCInfo}" var="edp_Info" varStatus="paymethodCnt">
												    
													<c:choose>
													    <c:when test="${quickCheckout eq true}">
													        <c:if test="${edp_Info.policyName == payInfo.payment_method && edp_SelectedValue != payInfo.payment_method}">
															  	<c:set var="edp_SelectedValue" value="${edp_Info.policyName}" scope="request"/> 
															  	<c:set var="edp_SelectedIndex" value="${paymethodCnt.count}" scope="request"/>  
															</c:if>
														</c:when>
														<c:otherwise>
															<c:choose>
																<c:when test="${paymethodCnt.count == 1}">
														   			<c:set var="edp_SelectedValue" value="${edp_Info.policyName}" scope="request"/>
														   			<c:set var="edp_SelectedIndex" value="${paymethodCnt.count}" scope="request"/>  
																</c:when>
																<c:otherwise>
																	<c:if test="${edp_Info.policyName == defaultPaymentMethodName && edp_SelectedValue != defaultPaymentMethodName}">
															  			<c:set var="edp_SelectedValue" value="${edp_Info.policyName}" scope="request"/> 
															  			<c:set var="edp_SelectedIndex" value="${paymethodCnt.count}" scope="request"/>  
																	</c:if>
																</c:otherwise>
															</c:choose>
														</c:otherwise>	
													</c:choose>
												</c:forEach>
											</c:if>
												
											
										</tr>
										<tr>
											<td align="left" valign="top"  id="EDP_PaymentMethodsDisplay_TableCell_12">
												
											    <%--
												***************************
												* Start: Show the payment drop down list
												* If nothing to show indicate that there are no payment methods
												***************************
												--%>
												<c:choose>
													<c:when test="${!empty edp_PaymentTCBean.filteredPaymentTCInfo}">
														<select class="select" name="paymentMethod" id="EDP_PaymentMethodsDisplay_FormInput_paymentMethod_In_PaymentMethodsDisplayForm_1" onchange="currentPaymentForm = document.forms['PIInfo_' + (this.selectedIndex + 1)]; EDPPaymentMethods_MM_showHideLayer('EDP_PaymentMethodsDisplay_FormInput_paymentMethod_In_PaymentMethodsDisplayForm_1');" >
															<c:forEach items="${edp_PaymentTCBean.filteredPaymentTCInfo}" var="edp_Info" varStatus="paymethodCnt" >
																<%--
																c:if test="${!empty edp_Info.attrPageName}" >
																--%>
																    <%-- policy name is unique --%>
																	<option 
																		<c:if test="${paymethodCnt.count == edp_SelectedIndex}" > 
																			selected="selected" 
																		</c:if> 
																		value="<c:out value="${edp_Info.policyName}" />"> 
																		<c:out value="${edp_Info.paymentMethodDisplayName}" />
																	</option>
																<%--
																</c:if>
																--%>
															</c:forEach>
														</select>
													</c:when>
													<c:otherwise>
													    <select class="select" name="paymentMethod" id="EDP_PaymentMethodsDisplay_FormInput_paymentMethod_In_PaymentMethodsDisplayForm_1" onchange="javascript:document.EDP_PaymentMethodsDisplayForm.submit()" >
													    	<option selected="selected" value="No Payment Methods"/>
													    </select>
														<br/><font color="red"><fmt:message key="EDPPaymentMethods_NO_PAYMENT_METHODS_AVAILABLE" bundle="${edpText}"/></font>
														
													</c:otherwise>
												</c:choose>	
											</td>
										</tr>
									</table>
									</form>
									<%--
									********************
									* End:  Displays the available Payment methods in a pre populated list box
									********************
									--%>
								</td>
							</tr>
							</table>
							<%--
							*********************
							* This row contains the input form for the selected payment method
							* Note: all the payment methods are from the edp_PaymentTCBean are shown but only the selected one is visible
							*********************
							--%>
							<c:set var="edp_add_shown" value="false"/>
							<jsp:useBean id="emptyHash" class="java.util.HashMap"/>
							<c:set var="temp_edp_ProtocolData" value="${edp_ProtocolData}" scope="request"/>
							<c:remove var="edp_ProtocolData" scope="request"/>

							<c:forEach items="${edp_PaymentTCBean.filteredPaymentTCInfo}" var="edp_Info" varStatus="paymethodCnt">
							<%--
								<tr class="cellBG_1" id="EDPPaymentMethodLayer_<c:out value="${paymethodCnt.count}"/>" 
					    				<c:choose>
											<c:when test="${edp_SelectedIndex eq paymethodCnt.count && edp_add_shown eq false}">
								    			style="visibility: visible; display: block;"
								    			<c:set var="edp_add_shown" value="true"/>
											</c:when>
										   	<c:otherwise>
								    			style="visibility: hidden; display: none;"
											</c:otherwise>
										</c:choose> >
										--%>
									
									
										
									    <div id="EDPPaymentMethodLayer_<c:out value="${paymethodCnt.count}"/>" 
						    				<c:choose>
											<c:when test="${edp_SelectedIndex eq paymethodCnt.count && edp_add_shown eq false}">
								    			style="visibility: visible; display: block;"
								    			<c:set var="edp_add_shown" value="true"/>
											</c:when>
										   	<c:otherwise>
								    			style="visibility: hidden; display: none;"
											</c:otherwise>
										</c:choose> >
								<table border="0" cellpadding="2" cellspacing="1" id="EDP_PaymentMethods_Table_12_1_${paymethodCnt.count}">
								<tr>
									<td id="EDP_PaymentMethodsDisplay_TableCell_12_1_${paymethodCnt.count}">
										<%--
										****************************
										* Start:  This form is invoked on the click of Add button after entering the mandatory payment fields
										***************************
										--%>
										<c:set var ="edp_PIInfo_Form" value="PIInfo_${paymethodCnt.count}" scope="request"/>
					    				<form name="<c:out value="${edp_PIInfo_Form}"/>" method="post" action="PIAdd">
											<input type="hidden" name="orderId" value="<c:out value="${orderIdRn}"/>" /> 
											<input type="hidden" name="URL" value="OrderDisplay?allocate=*n&backorder=*n&reverse=*n&remerge*n" />
											<c:choose>
												<c:when test="${empty param.cmdStoreId}">
													<input type="hidden" name="storeId" value="<c:out value="${WCParam.storeId}" />" />
												</c:when>
												<c:otherwise>
													<input type="hidden" name="cmdStoreId" value="<c:out value="${param.cmdStoreId}" />" />
												</c:otherwise>
											</c:choose>
											<input type="hidden" name="langId" value="<c:out  value="${CommandContext.languageId}" />" />
											<input type="hidden" name="catalogId" value="<c:out  value="${WCParam.catalogId}" />" />
											<input type="hidden" name="payMethodId" value="<c:out  value="${edp_Info.policyName}" />" />
											<input type="hidden" name="payment_method" value="<c:out  value="${edp_Info.policyName}" />" />
											<input type="hidden" name="policyId" value="<c:out value="${edp_Info.policyId}"/>" />
										   	<input type="hidden" name="errorViewName" value="DoPaymentErrorView" />
											<input type="hidden" name="valueFromProfileOrder" value="Y" />
											<input type="hidden" name="authToken" value="${authToken}" id="WC_PaymentMethodsDisplay_PIAdd_FormInput_authToken_1"/>
										   	<%--
											********************
											* Start:  gets and includes the full path of the attribute page name with the extension as .jsp
											********************
											--%>
											<%-- If remaining amount is negative amount, just leave it blank --%>
											<c:set var ="edp_PayMethodAmount" value="${remainingAmt}" scope="request"/>
											<c:set var ="edp_OrderTotalAmount" value="${edp_OrderBean.grandTotal.amount}" scope="request"/>
											<c:if test="${edp_PayMethodAmount lt 0}" >
												<c:set var="edp_PayMethodAmount" value="0.00" scope="request"/>
											</c:if>
											
											<c:if test="${!empty edp_Info.attrPageName}">
												<c:set var="edp_AttrPageFullPath" value="${snippetJspStoreDir}Snippets/EDP/PaymentMethods/${edp_Info.attrPageName}.jsp" />
												<c:set var="paymentTCInfo" value="${edp_Info}" scope="request"/>
												
												<c:if test="${edp_Info.policyName eq temp_edp_ProtocolData.payment_method}">
													<c:set var="edp_ProtocolData" value="${temp_edp_ProtocolData}" scope="request"/>
												</c:if>
												
												<c:set var ="edp_PI_Form" value="${edp_PIInfo_Form}" scope="request"/>
												<c:import url="${edp_AttrPageFullPath}" >
													<c:param name="paymentTCId" value="${edp_Info.TCId}" />
													<c:param name="showPONumber" value="${showPONumber}" />
													<c:param name="currentBillingAddress" value="${billingAddressId}"/>
												</c:import>

												<c:if test="${edp_Info.policyName eq edp_ProtocolData.payment_method}">
													<c:remove var="edp_ProtocolData" scope="request"/>
												</c:if>
											</c:if>
										
											<%--
											********************
											* End:  gets and includes the full path of the attribute page name with the extension as .jspd
											********************
											--%>
										
										</form>
		
										<%-- --%>
										<table border="0" cellpadding="2" cellspacing="1" id="EDP_PaymentMethods_Table_13_${paymethodCnt.count}">
											<tr class="cellBG_1">
												<td valign="middle" id="EDP_PaymentMethodsDisplay_TableCell_13_${paymethodCnt.count}">
													<a href="#" onclick="EDP_submitPIInfo(document.<c:out value="${edp_PIInfo_Form}"/>); return false;" class="button" id="EDP_PaymentMethodsDisplay_Link_11_${paymethodCnt.count}" >
														<fmt:message key="EDPPaymentMethods_ADD_PAYMENT_METHOD" bundle="${edpText}" />
													</a>
												</td>
											</tr>
										</table>	
									</td>
								</tr>
								</table>
								</div>
							</c:forEach>
							<%--
							*********************
							* This ends the input form for the selected payment method
							*********************
							--%>
						
					</td>
				</tr>
			</table>
			<table class="t_table" id="EDP_PaymentMethods_Table_14_<c:out value='${paymethodCnt.count}'/>">
				<tr>
					<td class="c_line" id="PaymentMethodsDisplay_TableCell_47_3">&nbsp;</td>
				</tr>
			</table>
		</td>
	</tr>
	</c:if>


	<%--
	****************************
	* Start:  This form is invoked on the click of submit button after entering the mandatory payment fields
	* OrderPrepare must have been done already, OrderProcess is going to be called so submit the order
	* This is a safe assumption, since to display the page at checkout to collect payment information an OrderPrepare
	* operation would need to have been done to calculate the charges correctly.
	***************************
	--%>
	<tr>
	    <td>
			<table cellpadding="0" cellspacing="0" border="0" id="EDP_PaymentMethods_Table_17">
				<tr>
					<td id="EDP_OrderSubmitForm_TableCell_95">
						<form name="AdvCardInfo" method="post" 
							action=<c:out value="${targetAction}"/> id="AdvCardInfo">
							<input type="hidden" name="orderId"	value="<c:out value="${orderIdRn}"/>" id="EDP_OrderSubmitForm_FormInput_orderId_In_CardInfo_1" />
						  <c:choose>
								<c:when test="${empty param.cmdStoreId}">
									<input type="hidden" name="storeId" value="<c:out value="${WCParam.storeId}"/>" id="EDP_OrderSubmitForm_FormInput_storeId_In_CardInfo_1"/>
								</c:when>
								<c:otherwise>
									<input type="hidden" name="cmdStoreId" value="<c:out value="${param.cmdStoreId}"/>" id="EDP_OrderSubmitForm_FormInput_cmdStoreId_In_CardInfo_1"/>
								</c:otherwise>
							</c:choose>
							<input type="hidden" name="langId" value="<c:out value="${CommandContext.languageId}"/>" id="EDP_OrderSubmitForm_FormInput_langId_In_CardInfo_1"/>
							<input type="hidden" name="catalogId" value="<c:out value="${WCParam.catalogId}"/>" id="EDP_OrderSubmitForm_FormInput_catalogId_In_CardInfo_1"/>
							<input type="hidden" name="notifyShopper" value="<c:out value="${emailShopper}"/>" id="EDP_OrderSubmitForm_FormInput_notifyShopper_In_CardInfo_1"/>
							<input type="hidden" name="notifyOrderSubmitted" value="<c:out value="${emailShopper}"/>" id="EDP_OrderSubmitForm_FormInput_notifyOrderSubmitted_In_CardInfo_1"/>
							<input type="hidden" name="amountRemaining" value="<c:out value="${remainingAmt}"/>" id="EDP_OrderSubmitForm_FormInput_amountRemaining_In_CardInfo_1"/>
							<input type="hidden" name="isPIAddNeeded" value="N"  />
							<input type="hidden" name="redirecturl" value="OrderProcessErrorView"  />
							<input type="hidden" name="billtoAddressId" value=""  />
							<input type="hidden" name="valueFromProfileOrder" value="Y" />
							<input type="hidden" name="errorViewName" value="DoPaymentErrorView" />
							<c:if test="${showPONumber eq true}">
								<input type="hidden" name="purchaseorder_id" value=""  />
							</c:if>
							<input type="hidden" name="URL" value=""/>
						</form>
						
						<a class="button" href="#" onclick="EDP_submitPaymentMethods(document.AdvCardInfo,true,false); return false;" id="EDP_OrderSubmitForm_Link_11b">
					    		<fmt:message key="EDPPaymentMethods_ORDER_NOW" bundle="${edpText}"/>
						</a>
						
					   	<c:url var="AddressFormUrl" value="AddressForm">
							<c:param name="catalogId" value="${WCParam.catalogId}"/>
							<c:param name="orderId" value="${orderIdRn}"/>
							<c:param name="page" value="billingaddress"/>
							<c:param name="storeId" value="${WCParam.storeId}"/>
							<c:param name="langId" value="${WCParam.langId}"/>
							<c:param name="returnView" value="OrderDisplay?allocate=*n&amp;backorder=*n&amp;reverse=*n&amp;remerge*n"/>
						</c:url>
						&nbsp;
						<a href="<c:out value="${AddressFormUrl}"/>" class="button" id="WC_MultipleShippingAddressDisplay_Link_3">
							<fmt:message bundle="${edpText}" key="EDPPaymentMethods_CREATE_NEW_ADDRESS"/>
						</a>
					</td>
				</tr>
			</table>
			<table class="t_table" id="EDP_PaymentMethods_Table_18">
				<tr>
					<td class="c_line" id="PaymentMethodsDisplay_TableCell_47_4">&nbsp;</td>
				</tr>
			</table>
		</td>
	</tr>


<c:if test="${showScheduleOrder eq true}">
	<tr><td>
	    <form name="ScheduleCardInfo1" method="post" action="OrderSchedule" id="ScheduleCardInfo1">
            <input type="hidden" name="orderId" value="<c:out value="${orderIdRn}"/>" id="EDP_PaymentMethods_FormInput_orderId_In_CardInfo1_1_<c:out value="${i}"/>"/>
						<c:choose>
							<c:when test="${empty param.cmdStoreId}">
								<input type="hidden" name="storeId" value="<c:out value="${WCParam.storeId}"/>" id="EDP_PaymentMethods_FormInput_storeId_In_CardInfo1_1"/>
							</c:when>
							<c:otherwise>
								<input type="hidden" name="cmdStoreId" value="<c:out value="${param.cmdStoreId}"/>" id="EDP_PaymentMethods_FormInput_cmdStoreId_In_CardInfo1_1"/>
							</c:otherwise>
						</c:choose>
            <input type="hidden" name="notifyShopper" value="1" id="EDP_PaymentMethods_FormInput_notifyShopper_In_CardInfo1_1"/>
            <input type="hidden" name="notifyMerchant" value="1" id="EDP_PaymentMethods_FormInput_notifyMerchant_In_CardInfo1_1"/>
            <input type="hidden" name="notifyOrderSubmitted" value="1" id="EDP_PaymentMethods_FormInput_notifyOrderSubmitted_In_CardInfo_1"/>
            <input type="hidden" name="langId" value="<c:out value="${WCParam.langId}"/>" id="EDP_PaymentMethods_FormInput_langId_In_CardInfo1_1"/>
            <input type="hidden" name="URL" value="OrderDisplay" id="EDP_PaymentMethods_FormInput_URL_In_CardInfo1_1"/>
            <input type="hidden" name="start" value="" id="EDP_PaymentMethods_start_In_CardInfo1_1"/>
            <input type="hidden" name="scheduled" value="Y" id="EDP_PaymentMethods_FormInput_scheduled_In_CardInfo1_1"/>
            <input type="hidden" name="catalogId" value="<c:out value='${WCParam.catalogId}'/>" id="EDP_PaymentMethods_FormInput_catalogId_In_CardInfo1_1"/>
            <input type="hidden" name="billtoAddressId" value="" />
            <input type="hidden" name="sensitiveInfoCopy" value="Y"/>
            <c:if test="${showPONumber eq true}">
		<input type="hidden" name="purchaseorder_id" value=""  />
	    </c:if>
              
            <table border="0" cellpadding="0" cellspacing="0" width="100%" id="EDP_PaymentMethods_Table_19">
                <tr>
			<td id="EDP_PaymentMethods_TableCell_56">
				<h2><fmt:message key="EDPPaymentMethods_Schedule_Recurring_order_title" bundle="${edpText}"/></h2>
			</td>
		</tr>
		<tr>
			<td>
				<table border="0" cellpadding="2" cellspacing="1" class="bgColor" id="EDP_PaymentMethods_Table_20">
                			<tr> 
                    				<td class="cellBG_1 t_td2" id="EDP_PaymentMethods_TableCell_57">
                        				<c:out value="${strPOSchedule}"/>
                          				<label for="EDP_PaymentMethods_FormInput_start1_In_CardInfo1_1"><fmt:message key="EDPPaymentMethods_Schedule_Start" bundle="${edpText}"/></label>
                        			</td>
                        			<td class="cellBG_1 t_td2" id="EDP_PaymentMethods_TableCell_58">
                          				<label for="EDP_PaymentMethods_FormInput_interval_In_CardInfo1_1"><fmt:message key="EDPPaymentMethods_Schedule_Frequency" bundle="${edpText}"/></label>
                        			</td>
                        		</tr>
                			<tr>
                        			<td class="cellBG_1 t_td2">
                          				<input class="input" type="text" name="start1" maxlength="3" id="EDP_PaymentMethods_FormInput_start1_In_CardInfo1_1"/> 
                        			</td>
                        			<td class="cellBG_1 t_td2" id="EDP_PaymentMethods_TableCell_59">
                          				<select class="select" id="EDP_PaymentMethods_FormInput_interval_In_CardInfo1_1" name="interval">
			                            		<option value='' selected="selected"><fmt:message key="EDPPaymentMethods_Schedule_Interval_6" bundle="${edpText}"/></option>
			                            		<option value='86400'><fmt:message key="EDPPaymentMethods_Schedule_Interval_1" bundle="${edpText}"/></option>
			                            		<option value='604800'><fmt:message key="EDPPaymentMethods_Schedule_Interval_2" bundle="${edpText}"/></option>
			                            		<option value='1209600'><fmt:message key="EDPPaymentMethods_Schedule_Interval_3" bundle="${edpText}"/></option>
			                            		<option value='1814400'><fmt:message key="EDPPaymentMethods_Schedule_Interval_4" bundle="${edpText}"/></option>
			                            		<option value='2592000'><fmt:message key="EDPPaymentMethods_Schedule_Interval_5" bundle="${edpText}"/></option>
			                          	</select>
                        			</td>
					</tr>
    					<tr>
    						<td colspan="2" class="cellBG_1 t_td2" id="EDP_PaymentMethods_TableCell_58"> 
        						<a href="#" onclick="EDP_submitPaymentMethods(ScheduleCardInfo1,false,true); return false;" class="button" id="EDP_PaymentMethods_Link_4"><fmt:message key="EDPPaymentMethods_Schedule_ScheduleOrderNow" bundle="${edpText}"/></a>
						</td>
					</tr>
				</table>
			</td>
                </tr>
	    </table>
	</td>
	</tr>
</c:if>

</table>

<jsp:useBean id="now" class="java.util.Date"/>
<c:set var="current_month_index" value="${now.month}"/>
<c:set var="current_year" value="${now.year + 1900}"/>
<c:set var="current_day" value="${now.day}"/>

<%--
********************
* End:  This form is invoked on the click of submit button after entering the mandetory payment fields
********************
--%>

<script type="text/javascript" language="javascript">
<!-- <![CDATA[
var payment_changed = 'false';

var currentPaymentForm = document.forms['PIInfo_<c:out value="${edp_SelectedIndex}"/>'];

//*********************** 
//1. This function is triggered by the OrderNow or ScheduleOrder button to submit the order.
//2. It submits the details to the form in which paymentMethods list box is included.
//***********************
function Reprepare_order(form)
{
			form.action="OrderPrepare";
			form.URL.value = 'OrderDisplay?orderItemId*=&quantity*=&requestedShipDate*=&requestedDateYear*=&requestedDateMonth*=&requestedDateDay*=&isShipdateRequested*=&isExpeditedCB*=&tieShipCode*=&merge=*n&remerge=*&check=*n&allocate=*&backorder=*&reverse=*n';
			form.submit();
}
function EDP_submitPaymentMethods(formName,orderNow,scheduleNow)
{
	var amtRemaining = '<c:out value="${remainingAmt}"/>';
	var validpayment = true;
	
	// AdvCardInfo form
	if (amtRemaining > 0.0 && scheduleNow) {
	      var message = "<fmt:message key="EDPPaymentMethods_CANNOT_RECONCILE_PAYMENT_AMT" bundle="${edpText}"/>";
    	  alert(message.replace("{0}", "<c:out value="${remainingAmt}"/>"));
    	  validpayment = false;
	} else if (amtRemaining > 0.0 && orderNow) {
		formName = currentPaymentForm;
		//check to see if the user has filled in all the required payment inormation
		if (!checkValidPaymentInstructions(formName)) {
			validpayment = false;
			return;
    	  	}
    	  	if (formName.isPIAddNeeded != null) {
    	  		formName.isPIAddNeeded.value = 'Y';
    	  	}
    	  	
		      // Order Now or Schedule Order was clicked from Add Payment Method 
		      // chain the Add Payment Method command to the OrderProcess command by building the URL
		      // to chain to
	        var action = '<c:out value="${targetAction}"/>' + "?orderId=" + '<c:out value="${orderIdRn}"/>' +
	        												<c:choose>
																		<c:when test="${empty param.cmdStoreId}">
																			"&storeId=" + '<c:out value="${WCParam.storeId}"/>' +
																		</c:when>
																		<c:otherwise>
																			"&cmdStoreId=" + '<c:out value="${param.cmdStoreId}"/>' +
																		</c:otherwise>
																	</c:choose>
	        	                      "&langId=" + '<c:out value="${CommandContext.languageId}"/>' +
	        	                      "&catalogId=" + '<c:out value="${WCParam.catalogId}"/>' +
	        	                      "&amountRemaining=" + '<c:out value="${remainingAmt}"/>' +
	        	                      "&notifyShopper=" + '<c:out value="${emailShopper}"/>' +
	        	                      "&notifyOrderSubmitted=" + '<c:out value="${emailShopper}"/>' +
	        	                      "&isPIAddNeeded=Y" +
	        	                      "&redirecturl=OrderProcessErrorView";
	        var url = "";
			
			if (formName.billing_address_id != null && formName.billing_address_id.value != '') {
				action = action + "&billtoAddressId=" + formName.billing_address_id.value;
			}
			
			<c:if test="${showPONumber eq true}">
			if (document.PONumberInfo.purchaseorder_id != null) {
				action = action + "&purchaseorder_id=" + document.PONumberInfo.purchaseorder_id.value;
			}
			</c:if>
			if (action != '') {
				formName.action = action;
			}
			formName.URL.value = url;
		}
	
	if (validpayment) {
		if (amtRemaining <= 0.0) {
		        //payment instruction has been added, therefore it is OK to proceed with order or schedule
			if (formName.name == 'ScheduleCardInfo1') {
				formName.start.value = EDPPaymentMethods_date(formName);
			}
			<c:if test="${showPONumber eq true}" >
				formName.purchaseorder_id.value = document.PONumberInfo.purchaseorder_id.value;
			</c:if>
		}
	
		if (checkParameters(formName,orderNow)) {
			formName.submit();
		}
	}
}

//*********************** 
//1. This function is triggered by the AddPaymentMethod or EditPaymentMethod button.
//2. It submits the details to the form in which paymentMethods list box is included
//***********************
function EDP_submitPIInfo(formName)
{
        if (checkValidPaymentInstructions(formName)) {
		// Add the payment method to the order
		if (checkParameters(formName,false)){
			formName.submit();
		}
        }
}

//*********************** 
//This function checks that the payments instructions trying to add are valid.
//***********************
function checkValidPaymentInstructions(formName)
{
	var now = new Date();
	var lastday = 1;
	var lastmonth = 1;
	
	var poRequired = '<c:out value="${requiredPONumber}"/>';
	
	
	<c:if test="${showPONumber eq true}" >
	if (document.PONumberInfo.purchaseorder_id != null && formName.purchaseorder_id != null) {
		formName.purchaseorder_id.value = document.PONumberInfo.purchaseorder_id.value;
	}
	</c:if>
	
	if (formName.expire_month != null) {
		lastmonth = new Number(formName.expire_month.value) + 1;
		if (lastmonth > 13) {
			lastmonth = 1;
		}
	}else if(formName.cardExpiryMonth != null){
		lastmonth = new Number(formName.cardExpiryMonth.value) + 1;
		if (lastmonth > 13) {
			lastmonth = 1;
		}
	}
	
	
	var expiry = 2000;
	if (formName.expire_year != null) {
		expiry = new Date(formName.expire_year.value,lastmonth - 1,lastday);
	}else if(formName.cardExpiryYear != null){
		expiry = new Date(formName.cardExpiryYear.value,lastmonth - 1,lastday);
	}
	
	
	if (formName.piAmount !=null && parseFloat(formName.piAmount.value) < 0){
        	var message = "<fmt:message key="EDPPaymentMethods_AMOUNT_LT_ZERO" bundle="${edpText}"/>";
    		alert(message);
    		return false;
	// account is checked for StandardAmex, StandardMasterCard, StandardVisa, StandardLOC and StandardCheck
	} else if (formName.account != null && formName.account.value == "") {
        	var message = "<fmt:message key="EDPPaymentMethods_NO_ACCOUNT_NUMBER" bundle="${edpText}"/>";
    		alert(message);
    		return false;
	// expiry date can be checked for credit cards StandardAmex, StandardMasterCard and StandardVisa
	} else if (((formName.expire_month != null && formName.expire_year != null) 
			|| (formName.cardExpiryMonth != null && formName.cardExpiryYear != null))
			&& now >= expiry) {
		var message = "<fmt:message key="EDPPaymentMethods_INVALID_EXPIRY_DATE" bundle="${edpText}"/>";
		alert(message);
		return false;
	} else if (formName.piAmount != null && formName.piAmount.value == "") {
		var message = "<fmt:message key="EDPPaymentMethods_NO_AMOUNT" bundle="${edpText}"/>";
		alert(message);
		return false;
	} else if (formName.check_routing_number != null && formName.check_routing_number.value == "") {
		var message = "<fmt:message key="EDPPaymentMethods_NO_ROUTING_NUMBER" bundle="${edpText}"/>";
		alert(message);
		return false;
	} else if (formName.billing_address_id != null && formName.billing_address_id.value == "") {
		var message = "<fmt:message key="EDPPaymentMethods_NO_BILLING_ADDRESS" bundle="${edpText}"/>";
		alert(message);
		return false;
	<c:if test="${showPONumber eq true}">	
	} else if (poRequired == "true" && formName.purchaseorder_id != null && formName.purchaseorder_id.value == "") {
		var message = "<fmt:message key="EDPPaymentMethods_NO_PURCHASE_ORDER" bundle="${edpText}"/>";
		alert(message);
		return false;
	</c:if>
	} else {
		return true;
	}
}

//check parameters, more parameters should be added here
function checkParameters(formName,orderNow){
  var orderTotal = '<c:out value="${orderTotal}"/>';
  var amtRemaining = '<c:out value="${remainingAmt}"/>';
  if (formName.cc_cvc != null && trim(formName.cc_cvc.value)!= null && trim(formName.cc_cvc.value)!= ""){
        if (!isNumber(formName.cc_cvc.value)) {
           var message = "<fmt:message key="EDPPaymentMethods_CVV_NOT_NUMERIC" bundle="${edpText}"/>";
    	   alert(message);
    	   return false;
        }
  }
  var originalAmt = 0.0;
  if (formName.piAmount != null) {
      if (trim(formName.piAmount.defaultValue) != null) {
          originalAmt = parseFloat(formName.piAmount.defaultValue);
          if (originalAmt == amtRemaining) {
             originalAmt = 0.0;
          }
      }
      if ( trim(formName.piAmount.value)!= null ) {
          var newTotal = parseFloat(formName.piAmount.value) - parseFloat(originalAmt) - parseFloat(amtRemaining);
          
          if (parseFloat(newTotal) > 0.0) {
	      	var message = "<fmt:message key="EDPPaymentMethods_PAYMENT_AMOUNT_LARGER_THAN_ORDER_AMOUNT" bundle="${edpText}"/>";
	      	var answer = confirm(message);
	      	if (answer == false) {
	      		formName.reset();
	      	}
	      	return answer;
	      }else if(parseFloat(newTotal) < 0.0 && orderNow){
	      	var message = "<fmt:message key="EDPPaymentMethods_CANNOT_RECONCILE_PAYMENT_AMT" bundle="${edpText}"/>";
    	    alert(message.replace("{0}", "<c:out value="${remainingAmt}"/>"));
    	  	formName.reset();
    	  	return false;
	      }
	  }
  }else if(amtRemaining<0){
  	var message = "<fmt:message key="EDPPaymentMethods_PAYMENT_AMOUNT_LARGER_THAN_ORDER_AMOUNT" bundle="${edpText}"/>";
	var answer = confirm(message);
	if (answer == false) {
	  formName.reset();
	}
	return answer;
  
  }
  
  return true;
}

function EDPPaymentMethods_MM_findObj(n, d) { //v4.01
	var p,i,x;  
	if(!d) d=document;
	if((p=n.indexOf("?"))>0&&parent.frames.length) {
	   d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);
	}
	if(!(x=d[n])&&d.all) x=d.all[n]; 
	for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
	for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=EDPPaymentMethods_MM_findObj(n,d.layers[i].document);
	if(!x && d.getElementById) x=d.getElementById(n);
	return x;
}


function EDPPaymentMethods_MM_showHideLayer() { //v6.0
	var i,p,v,obj,args=EDPPaymentMethods_MM_showHideLayer.arguments;
	
    i=0;
    if ((v=EDPPaymentMethods_MM_findObj(args[i]))!=null) {
		for(j=0;j<v.options.length;j++) {
		    var divName = 'EDPPaymentMethodLayer_' + (j + 1);
		    if ((obj=EDPPaymentMethods_MM_findObj(divName))!=null) {
				if (obj.style) { 
					obj=obj.style;
					if (j == v.selectedIndex) {
						obj.visibility='visible';
						obj.display='block';
					} else {
						obj.visibility='hidden';
						obj.display='none';
					}
				} else {
					alert("divName = " + divName + " found but has no style");
				}
			} else {
				alert("divName = " + divName + " not found");
			}
		}
	} else {
		alert(args[i] + " not found");
	}
}

function EDPPaymentMethods_date(form)
{

      var d = new Date();    //today's date
      var oneday = 86400000;   
      
      var millsec = d.getTime() + (form.start1.value*oneday);
      var today = new Date(millsec);
          
       var  yy = today.getYear();
       var yy1 = ''+yy;
       if(yy1.length < 4)
       {
         yy = yy+1900;
       }

       var mm = today.getMonth();
       mm++;
       var dd=  today.getDate();
       var hrs = today.getHours();
       var min  = today.getMinutes();
       var ss  = today.getSeconds();
       var format = '';
       
       var fmm, fdd, fhrs, fmin, fss; 
       if (ss<10) {
       		fss = '0'+ss;
       } else {
       	  fss = ss;
       }

       if (min<10) {
       		fmin = '0'+min;
       } else {
       	  fmin = min;
       }

       if (hrs<10) {
       		fhrs = '0'+hrs;
       } else {
       	  fhrs = hrs;
       }

       if (dd<10) {
       		fdd = '0'+dd;
       } else {
       	  fdd = dd;
       }

       if (mm<10) {
       		fmm = '0'+mm;
       } else {
       	  fmm = mm;
       }
              
			 format = yy+":"+fmm+":"+fdd+":"+fhrs+":"+fmin+":"+fss;

       return format;

}

function isNumber(word)
{
   	var numbers="0123456789";
   	var word=trim(word);
	for (var i=0; i < word.length; i++)
	{
		if (numbers.indexOf(word.charAt(i)) == -1) 
		return false;
	}
	return true;
}

function trim(inword)
{
   word = inword.toString();
   var i=0;
   var j=word.length-1;
   while(word.charAt(i) == " ") i++;
   while(word.charAt(j) == " ") j=j-1;
   if (i > j) {
		return word.substring(i,i);
	} else {
		return word.substring(i,j+1);
	}
}

//function accountChanged(formname)
//{
//	alert("Before change: "+formname.valueFromPaymentTC.value);
//	formname.valueFromPaymentTC.value = "false";
//	alert("After change: "+formname.valueFromPaymentTC.value);
//}


<%-- 
***
* This javascript function removes the Payment Information block from FORM
* This method remove the block so that all payment fields will not go into request
***
--%>
function removePaymentInfo(payment_div_name)
{
	var payment_div=document.getElementById(payment_div_name)
	var payment_div_parent=payment_div.parentNode
	payment_div_parent.removeChild(payment_div);
}


<%-- 
***
* This javascript function returns a boolean value indicating whether the payment information was chnaged 
***
--%>
function isPaymentChanged()
{
	return payment_changed;
}


<%-- 
***
* This javascript function is called from Payment method JSP page
* It is used to clear the values of specific fields of FORM
***
--%>
function paymentChanged(form, elementArray, payment_field_name)
{

	if(form.elements["payment_reset"].value == 'false')
	{
		var payment_field_value = form.elements[payment_field_name].value;
		//Reset all payment feilds
		clearElements(elementArray)
		form.elements[payment_field_name].value = payment_field_value;
		form.elements["payment_reset"].value = 'true';
	}
	//Set the payment_reset to "true", To indicate that payment fields have been reseted once
	//No need to reset them while changing other payment fields
	payment_changed = 'true';
}


<%-- 
	  ***
	  * This javascript function is called from function paymentChanged
	  * It is used to clear the values of specific fields of FORM
	  ***
 --%>
function clearElements(elementArray)
{
	var element
	for(element in elementArray){
		if(elementArray[element] != undefined)
		{
			switch (elementArray[element].type)
			{
				case "text":
					elementArray[element].value="";
					break
				case "select-one":
					//Need to set date-time related field to current date-time
					//We have to use indexOf() method instead of directly using field name
					//because the field names are not consistent across all payment method
					
					//if(elementArray[element].name.toLowerCase().indexOf("day")){
					//	elementArray[element].selectedIndex=<c:out value="${current_day}"/>
					//}
					if(elementArray[element].name.toLowerCase().indexOf("month") != -1 && !isNaN('<c:out value="${current_month_index}"/>')){
						elementArray[element].selectedIndex = <c:out value="${current_month_index}"/>
					}
					else if (elementArray[element].name.toLowerCase().indexOf("year") != -1 && !isNaN('<c:out value="${current_year}"/>')){
						var year_options = elementArray[element].options
						elementArray[element].selectedIndex = 0
						for(var option in year_options){
							if(!isNaN(option) 
									&& elementArray[element].options[option].text != undefined 
										&& elementArray[element].options[option].text == '<c:out value="${current_year}"/>'){
								elementArray[element].selectedIndex = option
							}
						}
					}
					else{
						elementArray[element].selectedIndex="0";
					}
					break
				//case "hidden":
					//Do nothing
					//For future use
				//	break
				//case "button":
					//Do nothing
					//For future use
				//	break
				//case "radio":
					//Do nothing
					//For future use
				//	break
				//case "checkbox":
					//Do nothing
					//For future use
				//	break
				//case "select-multiple":
					//Do nothing
					//For future use
				//	break
				default:
					//Do nothing
			}
		}
		element++
	}
}
//[[>-->   
</script>	

<% } catch(Exception e) {
     System.out.println("Exception caught in PaymentMethodsDisplay.jsp");
     System.out.println(e.toString());
     e.printStackTrace();
   } %>		

<!-- End: - JSP File Name: PaymentMethodsDisplay.jsp -->	



