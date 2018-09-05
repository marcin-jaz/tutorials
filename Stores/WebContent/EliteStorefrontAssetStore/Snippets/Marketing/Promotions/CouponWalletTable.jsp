<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2008, 2009 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf"%>


<c:set var="fromPage" value="myAccount"/>
<c:if test="${!empty param.orderId}">
	<c:set var="fromPage" value="checkOut"/>	
</c:if>

<wcbase:useBean id="couponBean" classname="com.ibm.commerce.marketing.databeans.CouponListByUserDataBean" scope="page">
	<c:set property="memberId" value="${CommandContext.userId}" target="${couponBean}" />
	<c:set property="state" value="0" target="${couponBean}" />
</wcbase:useBean>  
<c:if test="${fromPage == 'checkOut'}">
	<wcbase:useBean id="usedCouponBean" classname="com.ibm.commerce.marketing.databeans.CouponListByOrderDataBean" scope="page">
		<c:set property="orderId" value="${param.orderId}" target="${usedCouponBean}" />
	</wcbase:useBean> 
</c:if>

<%-- Find out if there are any valid coupons to display  --%>
<c:set var="hasValidCoupon" value="false"/>

<c:forEach var="couponStatusCheck" items="${couponBean.coupons}">
	<c:if test="${couponStatusCheck.promotion.status == 1}">
		<c:set var="hasValidCoupon" value="true"/>
	</c:if>
</c:forEach>

<%-- Find out if there are any valid used coupons to display  --%>
<c:set var="hasValidUsedCoupon" value="false"/>

<c:forEach var="usedCouponStatusCheck" items="${usedCouponBean.coupons}">
	<c:if test="${usedCouponStatusCheck.promotion.status == 1}">
		<c:set var="hasValidUsedCoupon" value="true"/>
	</c:if>
</c:forEach>

<%-- Display a message on the My Account page if there are no coupons in the customers account. --%>
<c:if test="${((empty couponBean.coupons) && (empty usedCouponBean.coupons) && (empty param.orderId)) || (!hasValidCoupon && !hasValidUsedCoupon && (empty param.orderId))}">
<div class="couponWallet_NoCouponsMessage"><fmt:message key="NO_COUPON_MESSAGE" bundle="${storeText}"/></div>
</c:if>

<c:if test="${((!empty couponBean.coupons) || (!empty usedCouponBean.coupons)) && (hasValidCoupon || hasValidUsedCoupon)}">
<div id="couponWallet">

<c:if test="${fromPage == 'checkOut'}">
	<div id="couponWalletTopBorder">
</c:if>

<%-- Set the returnView parameter which can be used to determine which  --%>
<c:set var="returnView" value=""/>
<c:if test="${!empty param.returnView}">
	<c:set var="returnView" value="${param.returnView}"/>
</c:if>

<%-- Set the orderId parameter which can be used to determine if this page is being used on the checkout or the My Account page. --%>
<c:set var="orderId" value=""/>
<c:if test="${fromPage == 'checkOut'}">
	<c:set var="orderId" value="${param.orderId}"/>
</c:if>




<form id="manageCoupons" method="post" action="CouponsAddRemove">
	<input type="hidden" name="storeId" value="<c:out value="${WCParam.storeId}"/>" id="WC_ManageCouponForm_FormInput_storeId"/>
	<input type="hidden" name="langId" value="<c:out value="${WCParam.langId}"/>" id="WC_ManageCouponForm_FormInput_langId"/>
	<input type=hidden name="couponId" value="" id="WC_ManageCouponForm_FormInput_couponId"></input>
	<input type=hidden name="taskType" value="" id="WC_ManageCouponForm_FormInput_taskType"></input>
	<input type="hidden" name="finalView" value="AjaxOrderItemDisplayView" id="WC_ManageCouponForm_FormInput_finalView"/>
	<c:if test="${fromPage == 'checkOut'}">
		<input type=hidden name="orderId" value="${orderId}" id="WC_ManageCouponForm_FormInput_orderId"></input>
	</c:if>
	<input type=hidden name="catalogId" value="<c:out value="${WCParam.catalogId}"/>"  id="WC_ManageCouponForm_FormInput_catalogId"/>
	<input type=hidden name="URL" value="" id="WC_ManageCouponForm_FormInput_URL"></input>		
	<flow:ifDisabled feature="AjaxCheckout"> 
		<c:if test="${fromPage == 'checkOut'}">
			<input type=hidden name="errorViewName" value="AjaxOrderItemDisplayView" id="WC_ManageCouponForm_FormInput_errorViewNameForCheckout"></input>	
		</c:if>
	</flow:ifDisabled>
	<flow:ifDisabled feature="AjaxMyAccountPage"> 
		<c:if test="${fromPage == 'myAccount'}">
			<input type=hidden name="errorViewName" value="NonAjaxCouponWallet" id="WC_ManageCouponForm_FormInput_errorViewNameForMyAccount"></input>	
		</c:if>
	</flow:ifDisabled>
				
	<table id="couponWalletTable" cellspacing="0" cellpadding="0" border="0" summary="<fmt:message key="COUPON_WALLET_TABLE_SUMMARY" bundle="${storeText}"/>">
			<tbody>
			<tr id="CouponWalletTable_tr_1">
			
			</tr>
				<tr id="CouponWalletTable_tr_2">
					<th id="couponWalletTable_couponName" class="couponWalletTable_couponName" align="center">
						<fmt:message key="COUPON" bundle="${storeText}"/>
					</th>
					<th id="couponWalletTable_expirationDate" class="couponWalletTable_expirationDate">
						<fmt:message key="COUPON_EXPIRATION_DATE" bundle="${storeText}"/>
					</th>
					<th id="couponWalletTable_buttonColumn" class="couponWalletTable_buttonColumn">
					&nbsp;
					</th>
				</tr>
				
				<!-- If this fragment is being used on the shopping cart page then show either an Apply button or a Remove button. -->
				<c:if test="${fromPage == 'checkOut'}">
					<c:forEach var="issuedCoupon" items="${couponBean.coupons}" varStatus="status1">
						<c:if test="${issuedCoupon.promotion.status == 1}">
						<tr id="CouponWalletTable_tr_3_<c:out value='${status1.count}'/>">
							<td id="CouponWalletTable_td_1_<c:out value='${status1.count}'/>" headers="couponWalletTable_couponName" class="couponWalletTable_couponName">
							
								<%-- Find the best description available to use. First try the short description, then the long description, then the admin description. --%>
								<c:set var="promoDesc" value="${issuedCoupon.promotion.description.descriptions[locale][2]}"/>
							
								<c:if test="${empty promoDesc}">
									<c:set var="promoDesc" value="${issuedCoupon.promotion.description.descriptions[locale][1]}"/>
								</c:if>
								<c:if test="${empty promoDesc}">
									<c:set var="promoDesc" value="${issuedCoupon.promotion.description.descriptions[locale][0]}"/>
								</c:if>
							
								<!-- get the short description of the coupon/promotion -->
								<c:out value="${promoDesc}"/>
							</td>
							<td id="CouponWalletTable_td_2_<c:out value='${status1.count}'/>" headers="couponWalletTable_expirationDate" class="couponWalletTable_expirationDate">
								<c:catch>
									<fmt:parseDate var="expirationDate" value="${issuedCoupon.expirationDate}" pattern="yyyy-MM-dd HH:mm:ss.SSS" timeZone="GMT"/>
								</c:catch>
								<c:if test="${empty expirationDate}">
									<c:catch>
										<fmt:parseDate var="expirationDate" value="${issuedCoupon.expirationDate}" pattern="yyyy-MM-dd HH:mm:ss" timeZone="GMT"/>
									</c:catch>
								</c:if>
								<fmt:formatDate value="${expirationDate}"/>
							</td>
							<td id="CouponWalletTable_td_3_<c:out value='${status1.count}'/>" headers="couponWalletTable_buttonColumn" class="couponWalletTable_buttonColumn">
								<span class="secondary_button button_fit" >
									<span class="button_container">
										<span class="button_bg">
											<span class="button_top">
												<span class="button_bottom">   
													<a id="CouponWalletTable_a_1_<c:out value='${status1.count}'/>" href="#" onclick="JavaScript:setCurrentId('CouponWalletTable_a_1_<c:out value='${status1.count}'/>'); CheckoutHelperJS.applyCoupon('manageCoupons','<c:out value='${returnView}'/>',<c:out value='${issuedCoupon.key.numericKey}'/>);return false;" >
														<fmt:message key="APPLY" bundle="${storeText}"/><span class="spanacce"><fmt:message key="Checkout_ACCE_coupon_apply" bundle="${storeText}"/> <c:out value="${issuedCoupon.promotion.description.descriptions[locale][0]}"/> <fmt:message key="COUPON_EXPIRATION_DATE" bundle="${storeText}"/> <fmt:formatDate value="${expirationDate}"/></span>
													</a>
												</span>
											</span>	
										</span>
									</span>
								</span>	
							</td>
						</tr>
						</c:if>
					</c:forEach>
					<c:forEach var="usedCoupon" items="${usedCouponBean.coupons}" varStatus="status2">
						<c:if test="${usedCoupon.promotion.status == 1}">
						<tr id="CouponWalletTable_tr_4_<c:out value='${status1.count}'/>" class="selectedCoupon">
							<td id="CouponWalletTable_td_4_<c:out value='${status2.count}'/>" headers="couponWalletTable_couponName" class="couponWalletTable_couponName">
								
								<%-- Find the best description available to use. First try the short description, then the long description, then the admin description. --%>
								<c:set var="promoDesc" value="${usedCoupon.promotion.description.descriptions[locale][2]}"/>
							
								<c:if test="${empty promoDesc}">
									<c:set var="promoDesc" value="${usedCoupon.promotion.description.descriptions[locale][1]}"/>
								</c:if>
								<c:if test="${empty promoDesc}">
									<c:set var="promoDesc" value="${usedCoupon.promotion.description.descriptions[locale][0]}"/>
								</c:if>
							
								<!-- get the short description of the coupon/promotion -->
								<c:out value="${promoDesc}"/> - <b><fmt:message key="COUPON_APPLIED" bundle="${storeText}"/></b>
							</td>
							<td id="CouponWalletTable_td_5_<c:out value='${status2.count}'/>" headers="couponWalletTable_expirationDate" class="couponWalletTable_expirationDate">
								<c:catch>
									<fmt:parseDate var="expirationDate" value="${usedCoupon.expirationDate}" pattern="yyyy-MM-dd HH:mm:ss.SSS" timeZone="GMT"/>
								</c:catch>
								<c:if test="${empty expirationDate}">
									<c:catch>
										<fmt:parseDate var="expirationDate" value="${usedCoupon.expirationDate}" pattern="yyyy-MM-dd HH:mm:ss" timeZone="GMT"/>
									</c:catch>
								</c:if>
								<fmt:formatDate value="${expirationDate}"/>
							</td>
							<td id="CouponWalletTable_td_6_<c:out value='${status2.count}'/>" headers="couponWalletTable_buttonColumn" class="couponWalletTable_buttonColumn">
								<span class="secondary_button button_fit" >
									<span class="button_container">
										<span class="button_bg">
											<span class="button_top">
												<span class="button_bottom">   
													<a id="CouponWalletTable_a_2_<c:out value='${status2.count}'/>" href="#" onclick="JavaScript:setCurrentId('CouponWalletTable_a_2_<c:out value='${status2.count}'/>'); CheckoutHelperJS.removeCouponFromOrder('manageCoupons','<c:out value='${returnView}'/>', <c:out value='${usedCoupon.key.numericKey}'/>);return false;" >
														<fmt:message key="REMOVE" bundle="${storeText}"/><span class="spanacce"><fmt:message key="Checkout_ACCE_coupon_order_remove" bundle="${storeText}"/><c:out value="${usedCoupon.promotion.description.descriptions[locale][0]}"/> <fmt:message key="COUPON_EXPIRATION_DATE" bundle="${storeText}"/> <fmt:formatDate value="${expirationDate}"/></span>
													</a>
												</span>
											</span>	
										</span>
									</span>
								</span>	
							</td>
						</tr>
						</c:if>
					</c:forEach>
				</c:if>
				
				<!-- If this fragment is being used from the My Account : My Coupons page then only show the unused coupons and show a Remove button beside each one -->
				<c:if test="${fromPage == 'myAccount'}">
					<c:forEach var="issuedCoupon" items="${couponBean.coupons}" varStatus="status3">
						<c:if test="${issuedCoupon.promotion.status == 1}">
						<tr id="CouponWalletTable_tr_5_<c:out value='${status3.count}'/>">
							<td id="CouponWalletTable_td_7_<c:out value='${status3.count}'/>" headers="couponWalletTable_couponName" class="couponWalletTable_couponName">
								<%-- Find the best description available to use. First try the short description, then the long description, then the admin description. --%>
								<c:set var="promoDesc" value="${issuedCoupon.promotion.description.descriptions[locale][2]}"/>
							
								<c:if test="${empty promoDesc}">
									<c:set var="promoDesc" value="${issuedCoupon.promotion.description.descriptions[locale][1]}"/>
								</c:if>
								<c:if test="${empty promoDesc}">
									<c:set var="promoDesc" value="${issuedCoupon.promotion.description.descriptions[locale][0]}"/>
								</c:if>
								
								<c:out value="${promoDesc}"/>
							</td>
							<td id="CouponWalletTable_td_8_<c:out value='${status3.count}'/>" headers="couponWalletTable_expirationDate" class="couponWalletTable_expirationDate">
								<c:catch>
									<fmt:parseDate var="expirationDate" value="${issuedCoupon.expirationDate}" pattern="yyyy-MM-dd HH:mm:ss.SSS" timeZone="GMT"/>
								</c:catch>
								<c:if test="${empty expirationDate}">
									<fmt:parseDate var="expirationDate" value="${issuedCoupon.expirationDate}" pattern="yyyy-MM-dd HH:mm:ss" timeZone="GMT"/>
								</c:if>
								<fmt:formatDate value="${expirationDate}"/>	 
							</td>
							<td id="CouponWalletTable_td_9_<c:out value='${status3.count}'/>" headers="couponWalletTable_buttonColumn" class="couponWalletTable_buttonColumn">
								<span class="secondary_button button_fit" >
									<span class="button_container">
										<span class="button_bg">
											<span class="button_top">
												<span class="button_bottom">   
													<a id="CouponWalletTable_a_3_<c:out value='${status3.count}'/>" href="#" onclick="JavaScript:setCurrentId('CouponWalletTable_a_3_<c:out value='${status3.count}'/>'); MyAccountDisplay.deleteCoupon('manageCoupons','<c:out value='${returnView}'/>', <c:out value='${issuedCoupon.key.numericKey}'/>);return false;" >
														<fmt:message key="REMOVE" bundle="${storeText}"/><span class="spanacce"><fmt:message key="COUPON_WALLET_ACCE_REMOVE" bundle="${storeText}"/> <c:out value="${issuedCoupon.promotion.description.descriptions[locale][0]}"/> <fmt:message key="COUPON_EXPIRATION_DATE" bundle="${storeText}"/> <fmt:formatDate value="${expirationDate}"/></span>
													</a>
												</span>
											</span>	
										</span>
									</span>
								</span>	
							</td>
						</tr>
						</c:if>
					</c:forEach>
				</c:if>
			</tbody>
		</table>
</form>

	<%-- End of top border --%>
	<c:if test="${fromPage == 'checkOut'}">
	</div>
	</c:if>
</div>
</c:if>
	
