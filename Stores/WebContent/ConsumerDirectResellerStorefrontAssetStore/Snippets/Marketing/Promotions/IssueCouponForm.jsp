<%
//********************************************************************
//*-------------------------------------------------------------------
//* Licensed Materials - Property of IBM
//*
//* WebSphere Commerce
//*
//* (c) Copyright IBM Corp. 2006
//*
//* US Government Users Restricted Rights - Use, duplication or
//* disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
//*
//*-------------------------------------------------------------------
//*
%>
<%--
    *** Include Coupon management ***
    * 
    *  In this JSP snippet, you need to pass in the following parameters in order to get coupon form works:
    *  cpf_storeId : the current store ID this coupon form works in.
    *  cpf_langId  : the current language ID in the store.
    *  cpf_orderId : the current order ID.
    *  cpf_catalogId : the current catalog ID in the store.
    *  cpf_errorViewPage: the jsp page which the page goes to when any error pop ups.
    *  cpf_userId  : the current shopper's user ID system assigned to. (Both registered user or non registered user will have one).
    *  cpf_successURL : the URL which this page goes to if the form being submitted successfully.
    *
    *  This coupon form snippet only used for coupon promotion test on store front. One assumption is, store has published or advertised
    *  coupon code (promotion name) to the shopper somehow, somewhere. So when shoppers come to the store, they know what coupon code (promotion name)
    *  they should type in in order to issue this coupon. This is one of the implementation to show how the coupon manager does. But not the only one.
    *
    *  This is a sample code to include this snippet:
    *
    *  <c:import url="../../Snippets/Marketing/Promotions/IssueCouponForm.jsp">
    *   <c:param name="cpf_storeId" value="${WCParam.storeId}" />
    *	<c:param name="cpf_langId" value="${langId}" />
    *	<c:param name="cpf_orderId" value="${WCParam.orderId}" />
    *	<c:param name="cpf_catalogId" value="${WCParam.catalogId}" />
    *	<c:param name="cpf_errorViewPage" value="OrderItemDisplayViewShiptoAssoc" />
    *	<c:param name="cpf_userId" value="${CommandContext.userId}" />
    *	<c:param name="cpf_successURL" value="OrderCalculate?URL=OrderItemDisplay&orderId=${WCParam.orderId}&updatePrices=1&calculationUsageId=-1" />
    *  </c:import> 
    *
    ***
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ include file="CouponEnvironmentSetup.jspf"%>
<%-- 
    **** start issue coupon form ***
--%>
<table id="WC_CouponForm_Table_1" cellpadding="0" cellspacing="0" border="0" width="100%">
<tr>
	<td class="c_headings" id="WC_CouponForm_TableCell_1">
		<fmt:message key="issueCouponTitle" bundle="${promotionText}" />
	</td>
</tr>
<tr>
	<td id="WC_CouponForm_TableCell_2">
		<table id="WC_CouponForm_Table_2" cellpadding="0" cellspacing="0" border="0" width="100%">
			<form name="CouponsForm" method="post" action="CouponsIssue" id="CouponsForm">
			<input type="hidden" name="storeId" value="<c:out value="${param.cpf_storeId}"/>" id="WC_CouponForm_FormInput_storeId"/>
			<input type="hidden" name="langId" value="<c:out value="${param.cpf_langId}"/>" id="WC_CouponForm_FormInput_langId"/>
			<input type="hidden" name="orderId" value="<c:out value="${param.cpf_orderId}"/>" id="WC_CouponForm_FormInput_orderId"/>
			<input type="hidden" name="catalogId" value="<c:out value="${param.cpf_catalogId}"/>"  id="WC_CouponForm_FormInput_catalogId"/>
			<input type="hidden" name="URL" value="<c:out value="${param.cpf_successURL}"/>" id="WC_CouponForm_FormInput_URL"/>
			<input type="hidden" name="errorViewName" value="${param.cpf_errorViewPage}" id="WC_CouponForm_FormInput_errorViewName" />
			<tr>
				<td id="WC_CouponForm_TableCell_21">
				  <label for= "promotionName">
				    <fmt:message key="couponPromotionName" bundle="${promotionText}" />
					</label>
					<input class="input" size="20" name="promotionName" id="promotionName" value="" title="promotionName"/>
					<label for= "couponCode">
						<fmt:message key="couponCode" bundle="${promotionText}" />
					</label>
					<input class="input" size="20" name="couponCode" id="couponCode" value="" title="couponCode"/>
					<a class="button" href="javascript:document.CouponsForm.submit()" id="WC_CouponForm_FormInput_Link_1"><fmt:message key="submit" bundle="${promotionText}" /></a>
				</td>
			</tr>
			</form>
		</table>
	</td>
</tr>
</table>
<%-- 
    **** end issue coupon form ***
--%>

