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
  * an order.
  *
  * Elements:  
  * - product table
  * - Shipping Charge type
  * - Return payment type
  * - Approval policy
  * - Complete Order button
  *
  * Imports:
  * - RFQCompleteOrderDisplay_EvalResults.jsp
  *
  * Required parameters:
  * - offering_id
  * - response_id
  * - rfqprod_id
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

<%-- Include the EDP environment setup snippet --%>
<%@ include file="../../Snippets/EDP/EDPEnvironmentSetup.jspf"%>

<c:set var="EC_CC_TYPE" value="cardBrand" scope="page" />
<c:set var="EC_OFFERING_ID" value="offering_id" scope="page" />
<c:set var="EC_PAYMENT_TC_ID" value="paymentTCId" scope="page" />
<c:set var="EC_PAYMTHDID" value="payMethodId" scope="page" />
<c:set var="EC_RFQ_PRODUCT_ID" value="rfqprod_id" scope="page" />
<c:set var="EC_RFQ_RESPONSE_ID" value="response_id" scope="page" />
<c:set var="EC_RFQRSPPRODEVAL_ACCEPT" value="1" scope="page" />

<c:set var="rfqId" value="${WCParam[EC_OFFERING_ID]}" scope="request" />
<c:set var="rfqprodId" value="${WCParam[EC_RFQ_PRODUCT_ID]}" scope="request" />
<c:set var="resId" value="${WCParam[EC_RFQ_RESPONSE_ID]}" scope="request" />
<c:set var="catalogId" value="${WCParam.catalogId}" scope="request" />
<c:set var="productId" value="${WCParam.productId}" scope="request" />

<wcbase:useBean id="bnError" classname="com.ibm.commerce.beans.ErrorDataBean" scope="request">
</wcbase:useBean>

<c:if test="${bnError.exceptionType != null}">
	<c:set var="strErrorMessage" value="${bnError.message}" />	
</c:if>	
	
<wcbase:useBean id="res" classname="com.ibm.commerce.rfq.beans.RFQResponseDataBean" scope="request">
	<c:set target="${res}" property="initKey_rfqResponseId" value="${resId}" />
	<c:set target="${res}" property="commandContext" value="${CommandContext}" />
</wcbase:useBean>

<c:set var="respStoreId" value="${res.storeIdInEJBType}" scope="request"/>
<c:set var="policyIndex" value="${WCParam.pIndexName}"/>
<c:set var="billAddress" value="${WCParam.BillingAddress}"/>
<c:set var="poValue" value="${WCParam.PONumber}"/>

<c:if test="${policyIndex==null || policyIndex=='' }">
<c:set var="policyIndex" value="0"/>
</c:if>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="en">

<head>
	<title><fmt:message key="RFQCompleteOrderDisplay_Title" bundle="${storeText}"/></title>
	<link rel="stylesheet"	href="<c:out value="${jspStoreImgDir}${vfileStylesheet}"/>"	type="text/css" />
	<meta name="GENERATOR" content="IBM WebSphere Studio"/>

<c:set var="paymentPolicyinfo" value="${res.paymentPolicyInfos}" />

<script language="javascript">
		function getValueFromSelection(formObject) {
			var selectedIndex = formObject.selectedIndex;
			return formObject.options[selectedIndex].value;
		}

		function submitComplete(form)
		{	
		
		
		<c:forEach items="${paymentPolicyinfo}" var="info" >				  
			if (getValueFromSelection(form.description)=="<c:out value="${info.longDescription}" />") {
		
				<c:set var="paymentAttributes" value="${info.attrPageName}" />
				
				<c:choose>
				<c:when test="${paymentAttributes == null}" >
					form.<c:out value="${EC_CC_TYPE}" />.value = '';
				</c:when>
				<c:otherwise>								
					form.<c:out value="${EC_CC_TYPE}" />.value = '<c:out value="${info.brand}" />';	
				</c:otherwise>
				</c:choose>
				if (form.<c:out value="${EC_CC_TYPE}" />.value == '')
				{
					form.<c:out value="${EC_CC_TYPE}" />.value = 'VISA';
				}
								
				form.<c:out value="${EC_PAYMTHDID}" />.value = '<c:out value="${info.policyName}" />';
			}			
		</c:forEach>
			var now = new Date();
			var lastday = 1;
			var lastmonth = 1;
			if (form.expire_month != null) {
				lastmonth = new Number(form.expire_month.value) + 1;
				if (lastmonth > 13) {
					lastmonth = 1;
				}
			}
			var expiry = 2000;
			if (form.expire_year != null) {
				expiry = new Date(form.expire_year.value,lastmonth - 1,lastday);
			}			
			if (form.account != null && form.account.value == "") {
		        var message = "<fmt:message key="EDPPaymentMethods_NO_ACCOUNT_NUMBER" bundle="${edpText}"/>";
		    	alert(message);
		    // expiry date can be checked for credit cards StandardAmex, StandardMasterCard and StandardVisa
		    } else if (form.expire_month != null && form.expire_year != null && now >= expiry) {
		    	var message = "<fmt:message key="EDPPaymentMethods_INVALID_EXPIRY_DATE" bundle="${edpText}"/>";
		    	alert(message);
		    } else if (form.check_routing_number != null && form.check_routing_number.value == "") {
		        var message = "<fmt:message key="EDPPaymentMethods_NO_ROUTING_NUMBER" bundle="${edpText}"/>";
		    	alert(message);
			}else{	
				form.submit();
			}
		}
		
		function onPaymentPolicyRefresh(){		
	
		var selectedPolicyIndex = self.document.RFQCompleteForm.description.selectedIndex;
	
		var switchere = "";
		var actionTaking = "RFQCompleteOrderDisplay";
//alert(actionTaking);		
		if( selectedPolicyIndex != <c:out value="${policyIndex}" /> ) {	
			var s1 = actionTaking; 
			var s3 = "?";
			var s6 = s1 + s3 + getNVPsForPolicyIndexNoDup(selectedPolicyIndex); 
//alert("s6==>" + s6);
			document.location.replace(s6);
			
		} else {
//alert("no changes!");
		}
		
	    return true;
		}
		
		function getNVPsForPolicyIndexNoDup(index) {
		var aNvp = fetchFormNvps();
		var equalSign = "=";
		var aIndexName = "pIndexName";
		var changed = aIndexName + equalSign + index;
//alert("getNVPsForPolicyIndexNoDup:" + aNvp + "  " + changed);
		return getNVPsNoDup(aNvp, changed);
	}
	function getNVPsNoDup(nvps, nvpChanged) {
		var ret = nvps;
		var andSign = "&";
		var pattern  = /pIndexName/i;
		if(pattern.test(nvps)) {
//alert("getNVPsNoDup:" + pattern);
			var matches0 = "&";
			var matches1 = "pIndexName";
			var j = nvps.length;
			var i = nvps.search(matches1);	
			var s1 = nvps.substr(0, i);  
			var s2 = nvps.substr(i, j);
			var swaping = andSign + nvpChanged + andSign;
			var k = s2.search(matches0);
			var l = s2.length;
			var s3 = s2.substr(k, l);
			ret = s1 + s3 + swaping;
//alert("getNVPsNoDup:" + s1 + "  " + s2 + "  " + s3 + "  " + ret);
		} else {
			ret = nvps + andSign + nvpChanged + andSign;
//alert("getNVPsNoDup-----:" + pattern);
		}
		return ret;
	}
	
	function fetchFormNvps() {
		
		
		var ret = "";
		var form1 = self.document.RFQCompleteForm;
		for (i=0; i<form1.elements.length; i++) {	
			var elem = form1.elements[i];
			ret = ret + "&" + elem.name + "=" + elem.value;
		}
		return ret + "&";
	}
	
</script>
				
</head>

<body class="noMargin">
<%@ include file="../../include/LayoutContainerTop.jspf"%>

	<table border="0" cellpadding="0" cellspacing="0" width="790" height="99%" id="WC_RFQCompleteOrderDisplay_Table_1">
		<tr>
			<td valign="top" width="630" id="WC_RFQCompleteOrderDisplay_TableCell_2">

<!--START MAIN CONTENT-->

				<form name="RFQCompleteForm" action="RFQToOrderCreate" method="post" id="RFQCompleteForm">
				<input type="hidden" name="langId" value="<c:out value="${langId}" />" id="WC_RFQCompleteOrderDisplay_FormInput_langId_In_RFQCompleteForm_1" />
				<input type="hidden" name="cmdStoreId" value="<c:out value="${respStoreId}" />" id="WC_RFQCompleteOrderDisplay_FormInput_cmdStoreId_In_RFQCompleteForm_1"/>
				<input type="hidden" name="catalogId" value="<c:out value="${catalogId}" />" id="WC_RFQCompleteOrderDisplay_FormInput_catalogId_In_RFQCompleteForm_1"/>
				<input type="hidden" name="<c:out value="${EC_OFFERING_ID}" />" value="<c:out value="${rfqId}" />" id="WC_RFQCompleteOrderDisplay_FormInput_<c:out value="${EC_OFFERING_ID}" />_In_RFQCompleteForm_1"/>
				<input type="hidden" name="<c:out value="${EC_RFQ_RESPONSE_ID}" />" value="<c:out value="${resId}" />" id="WC_RFQCompleteOrderDisplay_FormInput_<c:out value="${EC_RFQ_RESPONSE_ID}" />_In_RFQCompleteForm_1"/>

				<table cellpadding="2" cellspacing="0" width="580" border="0"  id="WC_RFQCompleteOrderDisplay_Table_2">

					<tr>
                        <td  valign="top" colspan="5" class="categoryspace" id="WC_RFQCompleteOrderDisplay_TableCell_3">
							<h1><fmt:message key="RFQCompleteOrderDisplay_Convert" bundle="${storeText}"/></h1>
							
	<c:if test="${strErrorMessage != null}">
		<span class="warning"><c:out value="${strErrorMessage}"/></span><br /><br />
	</c:if>	
	
							<fmt:message key="RFQCompleteOrderDisplay_ResName" bundle="${storeText}"/>&nbsp;&nbsp;<c:out value="${res.name}" /><p></p>
							<fmt:message key="RFQCompleteOrderDisplay_Remark" bundle="${storeText}"/>&nbsp;&nbsp;<c:out value="${res.remarks}" /><p></p>
						</td>
					</tr>

					<tr>
						<td  valign="top" width="100%" class="topspace" id="WC_RFQCompleteOrderDisplay_TableCell_4">
						<h2><fmt:message key="RFQDisplay_Product" bundle="${storeText}"/></h2>
							<table cellpadding="0" cellspacing="0" border="0" width="100%" class="bgColor" id="WC_RFQCompleteOrderDisplay_Table_3">
                            					<tbody>
								<tr>
									<td id="WC_RFQCompleteOrderDisplay_TableCell_5">

										<table width="100%" border="0" cellpadding="2" cellspacing="1" class="bgColor" id="WC_RFQCompleteOrderDisplay_Table_4">
											<tbody>
											<tr>
												<th id="a1" valign="top" class="colHeader" id="WC_RFQCompleteOrderDisplay_TableCell_6"><fmt:message key="RFQCompleteOrderDisplay_ProdName" bundle="${storeText}"/></th>
												<th id="a2" valign="top" class="colHeader" id="WC_RFQCompleteOrderDisplay_TableCell_7"><fmt:message key="RFQCompleteOrderDisplay_SKU" bundle="${storeText}"/></th>
												<th id="a3" valign="top" class="colHeader" id="WC_RFQCompleteOrderDisplay_TableCell_8"><fmt:message key="RFQCompleteOrderDisplay_Quan" bundle="${storeText}"/></th>
												<th id="a4" valign="top" class="colHeader" id="WC_RFQCompleteOrderDisplay_TableCell_9"><fmt:message key="RFQCompleteOrderDisplay_ShipAddr" bundle="${storeText}"/></th>
												<th id="a5" valign="top" class="colHeader_last" id="WC_RFQCompleteOrderDisplay_TableCell_10"><fmt:message key="RFQCompleteOrderDisplay_ShipMethod" bundle="${storeText}"/></th>
											</tr>

									<wcbase:useBean id="RFQResEvalList"
										classname="com.ibm.commerce.rfq.beans.RFQResponseEvalListBean">
										<c:set target="${RFQResEvalList}" property="rfqResponseId" value="${resId}" />
										<c:set target="${RFQResEvalList}" property="evalResult" value="${EC_RFQRSPPRODEVAL_ACCEPT}" />
										
									</wcbase:useBean>
									
									<c:set var="TCShipMode" value="${res.allowableShippingModes}" scope="request"/>
									
									<c:set var="rfqResponseEvals" value="${RFQResEvalList.rfqResponseEvals}" scope="request"/>
									<c:set var="color" value="cellBG_2" />
									<c:forEach items="${rfqResponseEvals}" var="evalResult"	varStatus="iter">
									<c:set var="EC_SHIPADDRESS" value="ShippingAddress_${iter.index+1}"/>
									<c:set var="ShipAds" value="${WCParam[EC_SHIPADDRESS]}"/> 
									<c:set var="EC_SHIPMODE" value="ShippingMode_${iter.index+1}"/>	
									<c:set var="ShipMd" value="${WCParam[EC_SHIPMODE]}"/> 

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
											<c:import url="RFQCompleteOrderDisplay_EvalResults.jsp" >
												<c:param name="index" value="${iter.index}" />
												<c:param name="respStoreId" value="${respStoreId}" />	
											        <c:param name="ShippingAddress" value="${ShipAds}" />												<c:param name="ShippingMode" value="${ShipMd}" />
                                                                                        </c:import>
											<% out.flush(); %>
										</tr>
									</c:forEach>
									<c:if test="${empty rfqResponseEvals}">
										<tr class="cellBG_1">
											<td valign="top" colspan="8" class="categoryspace t_td" id="WC_RFQCompleteOrderDisplay_TableCell_16">
												<fmt:message key="RFQDisplay_No_Product" bundle="${storeText}"/>
											</td>
										</tr>
									</c:if>
										</tbody>
										</table>
									</td>
								</tr>
								</tbody>
							</table>
						</td>
					</tr>
					
					<tr class="cellBG_1">
						<td id="WC_RFQCompleteOrderDisplay_TableCell_17">
							<table width="100%" id="WC_RFQCompleteOrderDisplay_Table_10">
								<tr>
									<td id="WC_RFQCompleteOrderDisplay_TableCell_18">
									<br /><label for="WC_RFQCompleteOrderDisplay_Select_1" ><fmt:message key="RFQCompleteOrderDisplay_SelectBilling" bundle="${storeText}"/></label></td>
								</tr> 
								<tr>
									<td id="WC_RFQCompleteOrderDisplay_TableCell_19">
								<c:set var="addresses" value="${res.billingAddresses}" />						
								<select class="select" name="BillingAddress" id="WC_RFQCompleteOrderDisplay_Select_1">
									<c:forEach items="${addresses}" var="address" varStatus="iter">
								        <c:if test="${billAddress==address.addressId}">
									        <option selected value="<c:out value="${address.addressId}" />"><c:out value="${address.nickName}" /></option>
								        </c:if>
								        <c:if test="${billAddress!=address.addressId}">
										<option value="<c:out value="${address.addressId}" />"><c:out value="${address.nickName}" /></option>
							                </c:if>
									</c:forEach>				
								</select>
								</td>
								</tr>
							</table>
						</td>
					</tr>
					<tr class="cellBG_1">
						<td id="WC_RFQCompleteOrderDisplay_TableCell_20">
							<table width="100%" id="WC_RFQCompleteOrderDisplay_Table_11">								
								
								<tr>
									<td id="WC_RFQCompleteOrderDisplay_TableCell_21"><fmt:message key="RFQCompleteOrderDisplay_SelectPayment" bundle="${storeText}"/></td>
								</tr>
								<tr> 
									<td id="WC_RFQCompleteOrderDisplay_TableCell_22">
										<input type="hidden" name="<c:out value="${EC_PAYMENT_TC_ID}" />" id="WC_RFQCompleteOrderDisplay_FormInput_<c:out value="${EC_PAYMENT_TC_ID}" />_In_RFQCompleteForm_1"/>
										<input type="hidden" name="<c:out value="${EC_CC_TYPE}" />" value="" id="WC_RFQCompleteOrderDisplay_FormInput_<c:out value="${EC_CC_TYPE}" />_In_RFQCompleteForm_1"/>
										<input type="hidden" name="<c:out value="${EC_PAYMTHDID}" />" value="" id="WC_RFQCompleteOrderDisplay_FormInput_<c:out value="${EC_PAYMTHDID}" />_In_RFQCompleteForm_1"/>
										<label for="WC_RFQCompleteOrderDisplay_Select_2" ></label>
										<select class="select" name="description" id="WC_RFQCompleteOrderDisplay_Select_2" onchange="onPaymentPolicyRefresh()">
											<c:forEach items="${paymentPolicyinfo}" var="paymentInfo" varStatus="aStatus">
												<c:choose>
													<c:when test="${paymentInfo.attrPageName== null or paymentInfo.attrPageName== ''}" >
														<%-- do nothing --%>
													</c:when>
													<c:otherwise>
														<c:if test="${policyIndex==aStatus.count-1}">
															<option selected value="<c:out value="${paymentInfo.longDescription}" />"><c:out value="${paymentInfo.longDescription}" /></option>
														    <c:set var="pagename" value="${paymentInfo.attrPageName}"/>
														</c:if>
														<c:if test="${policyIndex!=aStatus.count-1}">
														<option value="<c:out value="${paymentInfo.longDescription}" />"><c:out value="${paymentInfo.longDescription}" /></option>
														</c:if>
													</c:otherwise>
												</c:choose>
											 
											</c:forEach>
											</select>
                                                                                           
									</td>
								</tr>
							</table>
						</td>
					</tr>
						
					<c:import url="../EDP/${pagename}.jsp"/>			
					<%--@ include file="RFQCompleteOrderVisaDisplay.jspf"--%>
					
					<%@ include file="RFQCompleteOrderPODisplay.jspf"%>

					<input type="hidden" name="errorViewName" value="RFQCompleteOrderDisplay" id="WC_RFQCompleteOrderDisplay_FormInput_errorViewName_In_RFQCompleteForm_1"/>
					<input type="hidden" name="URL" value="TrackOrderStatus?cmdStoreId=" id="WC_RFQCompleteOrderDisplay_FormInput_URL_In_RFQCompleteForm_1"/>

					<tr class="cellBG_1">
						<td id="WC_RFQCompleteOrderDisplay_TableCell_23">
							<table cellpadding="0" cellspacing="0" id="WC_RFQCompleteOrderDisplay_Table_12">
								<tr>

									<!-- Start display for button "RFQCompleteOrderDisplay_Create" -->
									<td height="41" id="WC_RFQCompleteOrderDisplay_TableCell_24">
									<a class="button" href="javascript:submitComplete(document.RFQCompleteForm)" id="WC_RFQCompleteOrderDisplay_Link_1"> &nbsp; <fmt:message key="RFQCompleteOrderDisplay_Create" bundle="${storeText}"/> &nbsp;
									</a>
									</td>
									<!-- End display for button ... -->

								</tr>
								<tr>
									<td id="WC_RFQCompleteOrderDisplay_TableCell_25">&nbsp;</td>
									<td id="WC_RFQCompleteOrderDisplay_TableCell_26">&nbsp;</td>
									<td align="center" id="WC_RFQCompleteOrderDisplay_TableCell_27">
								
								<c:choose>
									<c:when test="${locale eq 'ja_JP' or locale eq 'ko_KR' or locale eq 'zh_CN' or locale eq 'zh_TW'}" >
											<span>
									</c:when>
									<c:otherwise>
										<span class="smallText">
									</c:otherwise>
								</c:choose>
									</td>
								</tr>
							</table>

						</td>
					</tr>
</table>

				</form>

<!--FINISH MAIN CONTENT-->

			</td>
		</tr>
	</table>

<%@ include file="../../include/LayoutContainerBottom.jspf"%>
	</body>

</html>
