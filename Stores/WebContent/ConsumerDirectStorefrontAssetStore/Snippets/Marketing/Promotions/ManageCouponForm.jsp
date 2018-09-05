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
    *  coupon code (promotion name) to the shopper somehow, somewhere. So when shopper come to the store, they know what coupon code (promotion name)
    *  they should type in in order to issue this coupon. This is one of the implementation to show how the coupon manager does. But not the only one.
    *
    *  This is a sample code to include this snippet:
    *
    *  <c:import url="../../Snippets/Marketing/Promotions/ManageCouponForm.jsp">
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
	***
	* Begin: List all the Coupon issued
	***
--%>
<script type="text/javascript">
function deleteCoupons(couponId, form){
	var ret = couponId;
	// if(ret == ""){
	// 	alert('No Coupons selected to delete');
	// } else {
		form.couponId.value = ret;
		form.taskType.value="D";
		form.submit();
	// }
}
function addCouponsToOrder(couponId, form){	
	var ret = couponId;	
	// if(ret == ""){
	// 	alert('No Coupons selected to be added to the order');
	// } else {	
		form.couponId.value = ret;
		form.taskType.value="A";
		form.submit();
	// }
}
function removeCouponsFromOrder(couponId, form){
	var ret = couponId;
	// if(ret == ""){
	// 	alert('No Coupons selected to be removed from the order');
	// } else {
		form.couponId.value = ret;
		form.taskType.value="R";
		form.submit();
	// }
}
</script>

<wcbase:useBean id="couponBean" classname="com.ibm.commerce.marketing.databeans.CouponListByUserDataBean" scope="page">
	<c:set property="memberId" value="${param.cpf_userId}" target="${couponBean}" />
	<c:set property="state" value="0" target="${couponBean}" />
</wcbase:useBean>  
<wcbase:useBean id="usedCouponBean" classname="com.ibm.commerce.marketing.databeans.CouponListByOrderDataBean" scope="page">
	<c:set property="orderId" value="${param.cpf_orderId}" target="${usedCouponBean}" />
</wcbase:useBean> 

<c:set var="hasCouponsIssued" value="false" />
<c:if test="${!empty couponBean.coupons}">
	<c:set var="hasCouponsIssued" value="true" />
</c:if>
<c:if test="${!empty usedCouponBean.coupons}">
	<c:set var="hasCouponsIssued" value="true" />
</c:if>

<c:if test="${hasCouponsIssued}">
	<table id="WC_CouponForm_Table_3" cellpadding="0" cellspacing="0" border="0" width="100%">
	<tr>
		<td class="c_headings" id="WC_CouponForm_TableCell_3">
			<fmt:message key="manageIssuedCoupons" bundle="${promotionText}" />
		</td>
	</tr>
	<tr> 
		<td id="WC_CouponForm_TableCell_4">
			<table id="WC_CouponForm_Table_4" cellpadding="0" cellspacing="0" border="0" width="100%"> 
				<form name="manageCoupons" method="post" action="CouponsAddRemove" id="manageCoupons">		         
					<input type="hidden" name="storeId" value="<c:out value="${param.cpf_storeId}"/>" id="WC_ManageCouponForm_FormInput_storeId"/>
				  <input type="hidden" name="langId" value="<c:out value="${param.cpf_langId}"/>" id="WC_ManageCouponForm_FormInput_langId"/>
				  <input type=hidden name="couponId" value="" id="WC_ManageCouponForm_FormInput_couponId"></input>
					<input type=hidden name="taskType" value="" id="WC_ManageCouponForm_FormInput_taskType"></input>
					<input type=hidden name="orderId" value="${param.cpf_orderId}" id="WC_ManageCouponForm_FormInput_orderId"></input>
					<input type=hidden name="catalogId" value="<c:out value="${param.cpf_catalogId}"/>"  id="WC_ManageCouponForm_FormInput_catalogId"/>
					<input type=hidden name="URL" value="<c:out value="${param.cpf_successURL}"/>" id="WC_ManageCouponForm_FormInput_URL"></input>
					<input type=hidden name="VIEW" value="" id="WC_ManageCouponForm_FormInput_VIEW"></input>
					<input type=hidden name="errorViewName" value="${param.cpf_errorViewPage}" id="WC_ManageCouponForm_FormInput_errorViewName"></input>
					<input type=hidden name="userIdentifier" value="" id="WC_ManageCouponForm_FormInput_userIdentifier"></input>
				<tr>
					<th class="colHeader" id="CouponID"><fmt:message key="couponId" bundle="${promotionText}" /></th>
					<th class="colHeader" id="PromoName"><fmt:message key="promotionName" bundle="${promotionText}" /></th>
					<th class="colHeader" id="Status"><fmt:message key="state" bundle="${promotionText}" /></th>
					<th class="colHeader_last" id="Action">&nbsp;</th>
				</tr>
				<%-- list all the issued coupons--%>
				<c:forEach var="issuedCoupon" items="${couponBean.coupons}">	
					<tr>
						<td class="t_td" headers="CouponID"><c:out value="${issuedCoupon.key.numericKey}"/></td>
						<td class="t_td" headers="PromoName"><c:out value="${issuedCoupon.promotion.name}"/></td>
						<td class="t_td" headers="Status">
							<c:choose>
								<c:when test="${issuedCoupon.state == 0}">
									<fmt:message key="active" bundle="${promotionText}" />
								</c:when>
								<c:when test="${issuedCoupon.state == 2}">
									<fmt:message key="inUse" bundle="${promotionText}" />
								</c:when>
								<c:otherwise>
									&nbsp;
								</c:otherwise>
							</c:choose>
						</td>
						<td class="t_td" headers="Action">
							<table id="WC_CouponForm_Table_5" cellpadding="0" cellspacing="0" border="0" width="100%">
								<tr>
									<td>
										<a class="t_button" name="AddToOrder" href="javascript:addCouponsToOrder('<c:out value="${issuedCoupon.key.numericKey}"/>', document.manageCoupons)"><fmt:message key="addToOrder" bundle="${promotionText}" /></a>
									</td>
								</tr>
								<tr>
									<td>
										<a class="t_button" name="Delete" href="javascript:deleteCoupons('<c:out value="${issuedCoupon.key.numericKey}"/>', document.manageCoupons)"><fmt:message key="delete" bundle="${promotionText}" /></a>
									</td>
								</tr>
							</table>
						</td>
					</tr>
				</c:forEach>
				
				<c:forEach var="usedCoupon" items="${usedCouponBean.coupons}">	
					<tr>   
						<td class="t_td" headers="CouponID"><c:out value="${usedCoupon.key.numericKey}"/></td>
						<td class="t_td" headers="PromoName"><c:out value="${usedCoupon.promotion.name}"/></td>
						<td class="t_td" headers="Status">
							<c:choose>
								<c:when test="${usedCoupon.state == 0}">
									<fmt:message key="active" bundle="${promotionText}" />
								</c:when>
								<c:when test="${usedCoupon.state == 2}">
									<fmt:message key="inUse" bundle="${promotionText}" />
								</c:when>
								<c:otherwise>
									&nbsp;
								</c:otherwise>
							</c:choose>
						</td>
						<td class="t_td" headers="Action">
							<a class="t_button" name="RemoveFromOrder" href="javascript:removeCouponsFromOrder('<c:out value="${usedCoupon.key.numericKey}"/>', document.manageCoupons)"><fmt:message key="removeFromOrder" bundle="${promotionText}" /></a>
						</td>
					</tr>
				</c:forEach>
				</form>
			</table>
		</td>
	</tr>
	</table>
</c:if>
<%-- 
	***
	* end: List all the Coupon issued
	***
--%>


<%--
    *** End Coupon management ***
--%>
