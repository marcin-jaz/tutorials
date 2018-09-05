<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2009 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>

<!-- Start - JSP File Name:  PromotionPickYourFreeGift.jsp -->

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf"%>

<wcf:url var="PromotionFreeGiftChoicesURL" value="PromotionFreeGiftChoicesView" type="Ajax">
  <wcf:param name="langId" value="${langId}" />
  <wcf:param name="storeId" value="${WCParam.storeId}" />
  <wcf:param name="catalogId" value="${WCParam.catalogId}" />
</wcf:url>

<script type="text/javascript">
	dojo.addOnLoad(function(){
		CommonControllersDeclarationJS.setControllerURL('PromotionFreeGifts_Controller','<c:out value="${PromotionFreeGiftChoicesURL}"/>');		
	});
</script>	

<c:set var="order" value="${requestScope.order}"/>
<c:if test="${empty order || order==null}"> 
	<wcf:getData type="com.ibm.commerce.order.facade.datatypes.OrderType" scope="request" 
	var="order" expressionBuilder="findCurrentShoppingCartWithPagingOnItem" varShowVerb="ShowVerbCart" maxItems="1" recordSetStartNumber="0" recordSetReferenceId="ostatus">
		<wcf:param name="accessProfile" value="IBM_Details" />	 
		<wcf:param name="sortOrderItemBy" value="orderItemID" />
		<wcf:param name="isSummary" value="false" />
	</wcf:getData>
</c:if>

<%-- Promotion choice of free gifts area --%>
<flow:ifEnabled feature="promotionChoiceOfFreeGift">
	<%-- Display a button for each rewardOption where the rewardSpecification is not null --%>
		<c:forEach var="rewardOptions" items="${order.rewardOption}">
			<c:if test="${rewardOptions.rewardSpecification != null}">
				<div class="free_gift_container"> 
					<c:if test="${rewardOptions.adjustment.description.value != ''}">
						<p>
							<c:out value="${rewardOptions.adjustment.description.value}" escapeXml="false"/>							
						</p>
					</c:if>					
					<span class="secondary_button"> 
						<span class="button_container"> 
                             <span class="button_bg"> 
	                             <span class="button_top"> 
 	                                <span class="button_bottom"> 
										<a href="#" id="PickYourFreeGift" class="button_text" onClick="javascript: wc.render.updateContext('PromotionFreeGifts_Context',{rewardOptionID: ${rewardOptions.rewardOptionIdentifier.uniqueID}});">
										<c:choose>	
											<c:when test="${fn:length(rewardOptions.rewardChoice.giftSet.giftItem) == 1}">
												<fmt:message key="PROMOTION_CHANGE_FREE_GIFT" bundle="${storeText}"/>	
											</c:when>
											<c:when test="${fn:length(rewardOptions.rewardChoice.giftSet.giftItem) > 1}">
												<fmt:message key="PROMOTION_CHANGE_FREE_GIFTS" bundle="${storeText}"/>	
											</c:when>										
											<c:when test="${rewardOptions.rewardSpecification.giftSetSpecification.maximumQuantity.value == 1}">	
												<fmt:message key="PROMOTION_PICK_FREE_GIFT" bundle="${storeText}"/>	
											</c:when>
											<c:when test="${rewardOptions.rewardSpecification.giftSetSpecification.maximumQuantity.value > 1}">	
												<fmt:message key="PROMOTION_PICK_FREE_GIFTS" bundle="${storeText}"/>	
											</c:when>
										</c:choose>	
										<span class="spanacce"><fmt:message key="Checkout_ACCE_promo_free_gifts_pick" bundle="${storeText}"/></span>								
										</a>
									</span>
								</span>
							</span>
						</span>
				   </span>
				</div>							
			</c:if>
		</c:forEach>	
</flow:ifEnabled>