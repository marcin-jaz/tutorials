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
  * This JSP page displays fields needed to convert an RFQ response to
  * a contract.
  *
  * Elements:  
  * - category price adjustments table
  * - product price adjustment table
  * - Shipping Charge type
  * - Return payment type
  * - Approval policy
  * - Create Contract button
  *
  * Imports:
  * - RFQCompleteContractDisplay_PriceAdjustment_Row.jsp
  * - RFQCompleteContractDisplay_ProductsTable.jsp
  *
  * Required parameters:
  * - offering_id
  * - response_id
  * - productId
  *
  *****
--%>

<%@ page language="java" %>

<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../include/JSTLEnvironmentSetup.jspf" %>

<c:set var="EC_OFFERING_ID" value="offering_id" scope="page" />
<c:set var="EC_NEGOTIATIONTYPE_PRODFIXPRICE" value="1" scope="page" />
<c:set var="EC_NEGOTIATIONTYPE_PRODPERPRICE" value="2" scope="page" />
<c:set var="EC_NEGOTIATIONTYPE_DKFIXPRICE" value="3" scope="page" />
<c:set var="EC_NEGOTIATIONTYPE_DKPERPRICE" value="4" scope="page" />
<c:set var="EC_RFQ_RESPONSE_ID" value="response_id" scope="page" />
<c:set var="EC_RFQRSPPRODEVAL_ACCEPT" value="1" scope="page" />
<c:set var="EC_RETURN_CHARGE_POLICY" value="returnChargePolicy" scope="page" />
<c:set var="EC_RETURN_APPROVAL_POLICY" value="returnApprovalPolicy" scope="page" />
<c:set var="EC_RETURN_PAYMENT_POLICY" value="returnPaymentPolicy" scope="page" />
<c:set var="EC_SHIPPING_CHARGE" value="ContractShippingChargeModel" scope="page" />
<c:set var="PolicyListDataBean_TYPE_SHIPPING_CHARGE" value="ShippingCharge" scope="page" />
<c:set var="PolicyListDataBean_TYPE_RETURN_APPROVAL" value="ReturnApproval" scope="page" />
<c:set var="PolicyListDataBean_TYPE_RETURN_CHARGE" value="ReturnCharge" scope="page" />
<c:set var="PolicyListDataBean_TYPE_RETURN_PAYMENT" value="ReturnPayment" scope="page" />

<c:set var="productId" value="${WCParam.productId}" />
<c:set var="rfqId" value="${WCParam.offering_id}" />
<c:set var="resId" value="${WCParam.response_id}" />
<c:set var="returnToCatalog" value="" />

<c:url var="returnToCatalogHref" value="${returnToCatalog}" >
	<c:param name="storeId" value="${storeId}" />
	<c:param name="langId" value="${langId}" />
	<c:param name="catalogId" value="${catalogId}" />
</c:url>

<c:choose>
	<c:when test="${productId != null}" >
		<c:set var="returnToCatalog" value="ProductDisplay" />
		<c:url var="returnToCatalogHref" value="${returnToCatalogHref}">
			<c:param name="productId" value="${productId}" />
		</c:url> 
		<fmt:message key="RFQList_Button_CatalogReturn" var="catalogButtonText" bundle="${storeText}"/>
	</c:when>
	<c:otherwise>
		<c:set var="returnToCatalog" value="TopCategoriesDisplay" />
		<c:url var="returnToCatalogHref" value="${returnToCatalogHref}" />
		<fmt:message key="RFQList_Button_Catalog" var="catalogButtonText" bundle="${storeText}"/>
	</c:otherwise>
</c:choose>

<wcbase:useBean id="bnError" classname="com.ibm.commerce.beans.ErrorDataBean" scope="request">
</wcbase:useBean>

<c:if test="${bnError.exceptionType != null and bnError.messageKey eq '_ERR_TOOLS_UTF_MISSING_ACCOUNT'}">
	<fmt:message key="RFQCreateDisplay_Error6" bundle="${storeText}" var="strErrorMessage"/>
</c:if>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" lang="en">

<head>

<title><fmt:message key="RFQCompleteContractDisplay_Title" bundle="${storeText}"/></title>
<link rel="stylesheet"
      href="<c:out value="${jspStoreImgDir}${vfileStylesheet}"/>"
      type="text/css" />
<meta name="GENERATOR" content="IBM WebSphere Studio"/>

	<script language="JavaScript">
	
		function submitContract(form) 
		{
			var error = true;
			for (var i = 0; i < form.returnPaymentPolicy.length; i++)
			{
				if (form.returnPaymentPolicy[i].checked == true)
				{
					error = false;
				}
			}
			if (error == true)
			{
				alert("<fmt:message key="RFQCompleteContractDisplay_Error1" bundle="${storeText}" />");
				return;
			}
			form.submit();
		}	
	
	</script>
</head>

<body class="noMargin">

<%@ include file="../../include/LayoutContainerTop.jspf"%>
	
<!--START MAIN CONTENT-->
  
<wcbase:useBean id="res" classname="com.ibm.commerce.rfq.beans.RFQResponseDataBean" scope="request">
	<c:set target="${res}" property="initKey_rfqResponseId" value="${resId}" />
	<c:set target="${res}" property="rfqId" value="${rfqId}" />
	<c:set target="${res}" property="commandContext" value="${CommandContext}" />
</wcbase:useBean>

			<form name="RFQContractForm" action="RFQToContractCreate" method="get" id="RFQContractForm">

				<input type="hidden" name="offering_id" value="<c:out value="${rfqId}" />" id="WC_RFQCompleteContractDisplay_FormInput_<c:out value="${EC_OFFERING_ID}" />_In_RFQContractForm_1"/>
				<input type="hidden" name="response_id" value="<c:out value="${resId}" />" id="WC_RFQCompleteContractDisplay_FormInput_<c:out value="${EC_RFQ_RESPONSE_ID}" />_In_RFQContractForm_1"/>
				<input type="hidden" name="langId" value="<c:out value="${langId}" />" id="WC_RFQCompleteContractDisplay_FormInput_langId_In_RFQContractForm_1"/>
				<input type="hidden" name="storeId" value="<c:out value="${storeId}" />" id="WC_RFQCompleteContractDisplay_FormInput_storeId_In_RFQContractForm_1"/>
				<input type="hidden" name="catalogId" value="<c:out value="${catalogId}" />" id="WC_RFQCompleteContractDisplay_FormInput_catalogId_In_RFQContractForm_1"/>

				<table cellpadding="2" cellspacing="0" width="580" border="0"  id="WC_RFQCompleteContractDisplay_Table_2">

					<tr>
						<td  valign="top" colspan="3" class="categoryspace" id="WC_RFQCompleteContractDisplay_TableCell_3">
							<h1><fmt:message key="RFQCompleteContractDisplay_Convert" bundle="${storeText}"/></h1>
							<c:if test="${!empty errorMessage}">
								<span class="warning"><c:out value="${strErrorMessage}"/></span>
							</c:if>					
							<fmt:message key="RFQCompleteContractDisplay_ResName" bundle="${storeText}"/>&nbsp;&nbsp;<c:out value="${res.name}" /><p></p>
							<fmt:message key="RFQCompleteOrderDisplay_Remark" bundle="${storeText}"/>&nbsp;&nbsp;<c:out value="${res.remarks}" /><p></p>
						</td>
					</tr>

<!-- Start Adjustment on Categories section -->              
<wcbase:useBean id="catalog" classname="com.ibm.commerce.catalog.beans.CatalogDataBean" scope="page">			
</wcbase:useBean>	
<%--
	get allPriceAdjustmentOnCategory 
--%>
<c:set var="ppArray" value="${res.allPriceAdjustmentOnCategory}"  scope="request"/>
<c:if test="${!empty ppArray}">
    <tr>
	<td  valign="top" width="400" class="topspace" id="WC_RFQCompleteContractDisplay_TableCell_4">
    	<h2><fmt:message key="RFQModifyDisplay_RFQPercentagePricing" bundle="${storeText}"/></h2>
    				
	<table id="WC_RFQCompleteContractDisplay_Table_3" width="100%" class="bgColor" cellpadding="2" cellspacing="1" border="0" >
	<tbody> 
		<tr>		
		    	<th id="c1"  valign="center"  class="colHeader" > <fmt:message key="RFQModifyDisplay_PPName" bundle="${storeText}"/></th>
            		<th id="c2"  valign="center"  class="colHeader" > <fmt:message key="RFQModifyDisplay_PPPrice_Res" bundle="${storeText}"/></th>
            		<th id="c3"  valign="center"  class="colHeader_last" > <fmt:message key="RFQModifyDisplay_PPCatalogUpdatesSync" bundle="${storeText}"/></th>                 
        	</tr>  
     
	<!--iterate through RFQPriceAdjustmentOnCategory-->
	<c:set var="color" value="cellBG_2" />		
	<c:forEach var="rfqPP" items="${ppArray}" begin="0" varStatus="iter">
		<c:choose>
			<c:when test="${color == 'cellBG_1'}">
				<c:set var="color" value="cellBG_2" />
			</c:when>
			<c:when test="${color == 'cellBG_2'}">
				<c:set var="color" value="cellBG_1" />
			</c:when>
		</c:choose>									
		<tr class="<c:out value="${color}" />">
			<% out.flush(); %>
			<c:import url="RFQCompleteContractDisplay_PriceAdjustment_Row.jsp">
				<c:param name="index" value="${iter.index}" />
			</c:import>
			<% out.flush(); %>					
		</tr> 
	</c:forEach>							
	<!-- end iterate through RFQPriceAdjustmentOnCategory -->
	</tbody>		 			
 	</table> 	 
	</td>
</tr>       
</c:if>
<!-- End Adjustment on Categories section -->

<wcbase:useBean id="RFQResEvalList" classname="com.ibm.commerce.rfq.beans.RFQResponseEvalListBean">
	<c:set target="${RFQResEvalList}" property="rfqResponseId" value="${resId}" />
	<c:set target="${RFQResEvalList}" property="evalResult" value="${EC_RFQRSPPRODEVAL_ACCEPT}" />	
</wcbase:useBean>

<%--
	store rfqResponseEvals in request scope to use on RFQCompleteContractDisplay_ProductsTable.jsp
--%>

<c:set var="rfqResponseEvals" value="${RFQResEvalList.rfqResponseEvals}" scope="request"/>

<wcbase:useBean id="rListNegType1" classname="com.ibm.commerce.rfq.beans.RFQResPrdListBean" scope="request" >
	<jsp:setProperty property="*" name="rListNegType1"/>
	<c:set target="${rListNegType1}" property="rfqResponseId" value="${resId}" />
	<c:set target="${rListNegType1}" property="negotiationType" value="${EC_NEGOTIATIONTYPE_PRODFIXPRICE}"  />	
</wcbase:useBean>
<c:set var="rListNegType1ProdList" value="${rListNegType1.resProducts}" />

<c:forEach items="${rListNegType1ProdList}" var="resProduct">	
		<c:set var="hasNeg1" value="true" />		
</c:forEach>

<wcbase:useBean id="rListNegType2" classname="com.ibm.commerce.rfq.beans.RFQResPrdListBean" scope="request" >
	<jsp:setProperty property="*" name="rListNegType2"/>
	<c:set target="${rListNegType2}" property="rfqResponseId" value="${resId}" />
	<c:set target="${rListNegType2}" property="negotiationType" value="${EC_NEGOTIATIONTYPE_PRODPERPRICE}"  />	
</wcbase:useBean>
<c:set var="rListNegType2ProdList" value="${rListNegType2.resProducts}" />

<c:forEach items="${rListNegType2ProdList}" var="resProduct">	
		<c:set var="hasNeg2" value="true" />		
</c:forEach>

<wcbase:useBean id="rListNegType3" classname="com.ibm.commerce.rfq.beans.RFQResPrdListBean" scope="request" >
	<jsp:setProperty property="*" name="rListNegType3"/>
	<c:set target="${rListNegType3}" property="rfqResponseId" value="${resId}" />
	<c:set target="${rListNegType3}" property="negotiationType" value="${EC_NEGOTIATIONTYPE_DKFIXPRICE}"  />
</wcbase:useBean>
<c:set var="rListNegType3ProdList" value="${rListNegType3.resProducts}" />

<c:forEach items="${rListNegType3ProdList}" var="resProduct">	
		<c:set var="hasNeg3" value="true" />		
</c:forEach>

<wcbase:useBean id="rListNegType4" classname="com.ibm.commerce.rfq.beans.RFQResPrdListBean" scope="request" >
	<jsp:setProperty property="*" name="rListNegType4"/>
	<c:set target="${rListNegType4}" property="rfqResponseId" value="${resId}" />
	<c:set target="${rListNegType4}" property="negotiationType" value="${EC_NEGOTIATIONTYPE_DKPERPRICE}"  />
</wcbase:useBean>
<c:set var="rListNegType4ProdList" value="${rListNegType4.resProducts}" />

<c:forEach items="${rListNegType4ProdList}" var="resProduct">	
		<c:set var="hasNeg4" value="true" />		
</c:forEach>

<!-- Start Percentage Pricing on Products table -->
<c:if test="${hasNeg2 eq 'true'}">
	<% out.flush(); %>
	<c:import url="RFQCompleteContractDisplay_ProductsTable.jsp" >
		<c:param name="negotiationType" value="${EC_NEGOTIATIONTYPE_PRODPERPRICE}" />
		<c:param name="resId" value="${resId}" />
	</c:import>
	<% out.flush(); %>
</c:if>	
<!-- end Percentage Pricing on Products -->	

<!-- Start Fixed Pricing on Products table -->
<c:if test="${hasNeg1 eq 'true'}">
	<% out.flush(); %>
	<c:import url="RFQCompleteContractDisplay_ProductsTable.jsp" >
		<c:param name="negotiationType" value="${EC_NEGOTIATIONTYPE_PRODFIXPRICE}" />
		<c:param name="resId" value="${resId}" />
	</c:import>	
	<% out.flush(); %>
	</c:if>					
<!-- end Fixed Pricing on Products -->
			
<!-- Start Percentage Pricing on Dynamic kits -->
<c:if test="${hasNeg4 eq 'true'}">
	<% out.flush(); %>
	<c:import url="RFQCompleteContractDisplay_ProductsTable.jsp" >
		<c:param name="negotiationType" value="${EC_NEGOTIATIONTYPE_DKPERPRICE}" />
		<c:param name="resId" value="${resId}" />
	</c:import>
	<% out.flush(); %>	
	</c:if>	
<!-- end Percentage Pricing on Dynamic Kits -->	

<!-- Start Fixed Pricing on Dynamic Kits -->
<c:if test="${hasNeg3 eq 'true'}">
	<% out.flush(); %>
	<c:import url="RFQCompleteContractDisplay_ProductsTable.jsp" >
		<c:param name="negotiationType" value="${EC_NEGOTIATIONTYPE_DKFIXPRICE}" />
		<c:param name="resId" value="${resId}" />
	</c:import>	
	<% out.flush(); %>
	</c:if>	
<!-- end Fixed Pricing on Dynamic Kits -->	


					<tr><td id="WC_RFQDuplicateDisplay_TableCell_13">&nbsp;<br /></td></tr>
					<tr class="cellBG_1">
						<td id="WC_RFQCompleteContractDisplay_TableCell_19">
						<wcbase:useBean id="policyListLB" classname="com.ibm.commerce.tools.contract.beans.PolicyListDataBean">
							<c:set target="${policyListLB}" property="storeId" value="${res.storeIdInEJBType}" />
							<c:set target="${policyListLB}" property="policyType" value="${PolicyListDataBean_TYPE_SHIPPING_CHARGE}" />
							
						</wcbase:useBean>
						
						
						
							<table width="100%" id="WC_RFQCompleteContractDisplay_Table_9">
								<tr>
									<td width="28%" id="WC_RFQCompleteContractDisplay_TableCell_20">   
									 <label for="WC_RFQCompleteContractDisplay_Select_1">
									 <fmt:message key="RFQCompleteContractDisplay_Shipping" bundle="${storeText}"/>
									 </label>
									 </td>
									<td width="72%" id="WC_RFQCompleteContractDisplay_TableCell_21">
									<select class="select" name="<c:out value="${EC_SHIPPING_CHARGE}" />" id="WC_RFQCompleteContractDisplay_Select_1">
										<c:forEach items="${policyListLB.policyList}" var="policy" >
												<option value="<c:out value="${policy.policyName}" />"><c:out value="${policy.shortDescription}" /></option>
										</c:forEach>
									</select>
									
									</td>
								</tr>
							</table>
						</td>
					</tr>

					<tr class="cellBG_1">
						<td id="WC_RFQCompleteContractDisplay_TableCell_22">
							
							<table width="100%" id="WC_RFQCompleteContractDisplay_Table_10">
								<tr>
								
									<wcbase:useBean id="policyListLB2" classname="com.ibm.commerce.tools.contract.beans.PolicyListDataBean">
										<c:set target="${policyListLB2}" property="storeId" value="${res.storeIdInEJBType}" />
										<c:set target="${policyListLB2}" property="policyType" value="${PolicyListDataBean_TYPE_RETURN_CHARGE}" />
										
										<c:set var="policyList" value="${policyList.policyList}" />
									</wcbase:useBean>
									
									<td width="28%" id="WC_RFQCompleteContractDisplay_TableCell_23"><label for="WC_RFQCompleteContractDisplay_Select_2">
									<fmt:message key="RFQCompleteContractDisplay_Return" bundle="${storeText}"/>
									</label>
									</td>
									<td width="72%" id="WC_RFQCompleteContractDisplay_TableCell_24">
										
										<select class="select" name="<c:out value="${EC_RETURN_CHARGE_POLICY}" />" id="WC_RFQCompleteContractDisplay_Select_2">
											<c:forEach items="${policyListLB2.policyList}" var="policy" >
													<option value="<c:out value="${policy.policyName}" />"><c:out value="${policy.shortDescription}" /></option>
											</c:forEach>
										</select>
									
									</td>
								</tr>
								<tr>
								
									<wcbase:useBean id="policyListLB3" classname="com.ibm.commerce.tools.contract.beans.PolicyListDataBean">
										<c:set target="${policyListLB3}" property="storeId" value="${res.storeIdInEJBType}" />
										<c:set target="${policyListLB3}" property="policyType" value="${PolicyListDataBean_TYPE_RETURN_APPROVAL}" />
										
										<c:set var="policyList" value="${policyList.policyList}" />
									</wcbase:useBean>
									<td width="28%" id="WC_RFQCompleteContractDisplay_TableCell_25">    <label for="WC_RFQCompleteContractDisplay_Select_3">
									<fmt:message key="RFQCompleteContractDisplay_Approval" bundle="${storeText}"/></td>
									<td width="72%" id="WC_RFQCompleteContractDisplay_TableCell_26">
									<select class="select" name="<c:out value="${EC_RETURN_APPROVAL_POLICY}" />" id="WC_RFQCompleteContractDisplay_Select_3">
											<c:forEach items="${policyListLB3.policyList}" var="policy" >
													<option value="<c:out value="${policy.policyName}" />"><c:out value="${policy.shortDescription}" /></option>
											</c:forEach>									
		                                                                         </select>
		                                                                          </label>
							</td>
								</tr>
							</table>
						</td>
					</tr>

					<tr class="cellBG_1">
						<td id="WC_RFQCompleteContractDisplay_TableCell_27">
							<table width="100%" id="WC_RFQCompleteContractDisplay_Table_11">
							<wcbase:useBean id="policyListLB4" classname="com.ibm.commerce.tools.contract.beans.PolicyListDataBean">
								<c:set target="${policyListLB4}" property="storeId" value="${res.storeIdInEJBType}" />
								<c:set target="${policyListLB4}" property="policyType" value="${PolicyListDataBean_TYPE_RETURN_PAYMENT}" />
								
							</wcbase:useBean>	
								<c:forEach items="${policyListLB4.policyList}" var="policy" varStatus="iter">
									<tr>
									<c:choose>
										<c:when test="${iter.index eq 0}" >
											<td width="28%" id="WC_RFQCompleteContractDisplay_TableCell_28">
                                                                              <label for="WC_RFQCompleteContractDisplay_FormInput_<c:out value="${EC_RETURN_PAYMENT_POLICY}" />_In_RFQContractForm_1">                                        <label for="WC_RFQCompleteContractDisplay_FormInput_<c:out value="${EC_RETURN_PAYMENT_POLICY}" />_In_RFQContractForm_1">        
                                                                                   <fmt:message key="RFQCompleteContractDisplay_Return" bundle="${storeText}"/> </td>
										</c:when>
										<c:otherwise>
											<td id="WC_RFQCompleteContractDisplay_TableCell_29"></td>
										</c:otherwise>
									</c:choose>
											<td width="72%" id="WC_RFQCompleteContractDisplay_TableCell_30">
												<input type="checkbox" class="checkbox" name="<c:out value="${EC_RETURN_PAYMENT_POLICY}" />" 
													value="<c:out value="${policy.policyName}" />" 
													id="WC_RFQCompleteContractDisplay_FormInput_<c:out value="${EC_RETURN_PAYMENT_POLICY}" />_In_RFQContractForm_1"/>
												<c:out value="${policy.shortDescription}" />
											</td>
									            </label>
                                                                                       </tr>
								</c:forEach>
							</table>
						</td>
					</tr>

					<tr class="cellBG_1">
						<td id="WC_RFQCompleteContractDisplay_TableCell_31">

							<table cellpadding="0" cellspacing="0" id="WC_RFQCompleteContractDisplay_Table_12">
								<tr>

<!-- Start display for button "RFQCompleteContractDisplay_Create" -->
<td height="41" id="WC_RFQCompleteContractDisplay_TableCell_32">
<a class="button" href="javascript:submitContract(document.RFQContractForm);" id="WC_RFQCompleteContractDisplay_Link_1">	&nbsp; <fmt:message key="RFQCompleteContractDisplay_Create" bundle="${storeText}"/> &nbsp;
</a>
</td>
<!-- End display for button ... -->

								</tr>
								<tr>
									<td id="WC_RFQCompleteContractDisplay_TableCell_33">&nbsp;</td>
									<td id="WC_RFQCompleteContractDisplay_TableCell_34">&nbsp;</td>
			        				<td align="center" id="WC_RFQCompleteContractDisplay_TableCell_35">
								
									</td>
								</tr>
							</table>
						</td>
					</tr>

				</table>

				<input type="hidden" name="errorViewName" value="RFQCompleteContractDisplay" id="WC_RFQCompleteContractDisplay_FormInput_errorViewName_In_RFQContractForm_1"/>
				<input type="hidden" name="URL" value="RFQListDisplay" id="WC_RFQCompleteContractDisplay_FormInput_URL_In_RFQContractForm_1"/>

				</form>

<!--FINISH MAIN CONTENT-->

<%@ include file="../../include/LayoutContainerBottom.jspf"%>
	</body>
</html>
