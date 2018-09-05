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
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf"%>

<script type="text/javascript">
       dojo.addOnLoad(function() {
	       <fmt:message key="PROMOTION_FREE_GIFTS_POPUP_ERROR_EXCEED_GIFT_QUANTITY" bundle="${storeText}" var="PROMOTION_FREE_GIFTS_POPUP_ERROR_EXCEED_GIFT_QUANTITY"/>
	       <fmt:message key="PROMOTION_FREE_GIFTS_POPUP_NUMBER_OF_SELECTIONS" bundle="${storeText}" var="PROMOTION_FREE_GIFTS_POPUP_NUMBER_OF_SELECTIONS"><fmt:param value="%0"/></fmt:message>
	       <fmt:message key="PROMOTION_FREE_GIFTS_POPUP_NUMBER_OF_SELECTIONS_ONE" bundle="${storeText}" var="PROMOTION_FREE_GIFTS_POPUP_NUMBER_OF_SELECTIONS_ONE"/>
           MessageHelper.setMessage("PROMOTION_FREE_GIFTS_POPUP_ERROR_EXCEED_GIFT_QUANTITY", <wcf:json object="${PROMOTION_FREE_GIFTS_POPUP_ERROR_EXCEED_GIFT_QUANTITY}"/>);
		   MessageHelper.setMessage("PROMOTION_FREE_GIFTS_POPUP_NUMBER_OF_SELECTIONS", <wcf:json object="${PROMOTION_FREE_GIFTS_POPUP_NUMBER_OF_SELECTIONS}"/>);
		   MessageHelper.setMessage("PROMOTION_FREE_GIFTS_POPUP_NUMBER_OF_SELECTIONS_ONE", <wcf:json object="${PROMOTION_FREE_GIFTS_POPUP_NUMBER_OF_SELECTIONS_ONE}"/>);                            
       });
</script>

<c:set var="order" value="${requestScope.order}"/>
<c:if test="${empty order}">
	<c:set var="order" value="${requestScope.orderInCart}"/>
</c:if>
<c:if test="${empty order}"> 
	<wcf:getData type="com.ibm.commerce.order.facade.datatypes.OrderType"
	       var="order" expressionBuilder="findCurrentShoppingCart">
	       <wcf:param name="accessProfile" value="IBM_Details" />
	</wcf:getData>
</c:if> 

<c:set var="rewardOptionID" value="${param.rewardOptionID}"/>
<c:set var="promotionStatus" value="inactive"/>

<c:forEach var="rewardOptions" items="${order.rewardOption}">
	<c:if test="${rewardOptions.rewardOptionIdentifier.uniqueID == rewardOptionID}">
	    <c:set var="promotionStatus" value="active"/>
	    <c:set var="giftSetSpec" value="${rewardOptions.rewardSpecification.giftSetSpecification}"/>
	    <c:set var="noOfFreeGifts" value="${giftSetSpec.maximumQuantity.value}"/>
	    <c:set var="giftSet" value="${rewardOptions.rewardChoice.giftSet}"/>
	</c:if>
</c:forEach>

<c:choose>
       <c:when test="${promotionStatus == 'active'}">
              <c:set var="singleOrMultipleGiftItems"/>
              <c:choose>
                     <c:when test="${noOfFreeGifts == 1}">
                            <c:set var="singleOrMultipleGiftItems" value="single"/>
                     </c:when>
                     <c:when test="${noOfFreeGifts > 1}">
                            <c:set var="singleOrMultipleGiftItems" value="multiple"/>       
                     </c:when>       
              </c:choose>
              
              <div class="title" id="WC_PromotionChoiceOfFreeGiftsPopupContent_div_1">
	              <h2>
		              <c:choose>
		                  <c:when test="${singleOrMultipleGiftItems == 'single'}">
		                         <fmt:message key="PROMOTION_FREE_GIFTS_POPUP_PICK_GIFT" bundle="${storeText}"/>
		                  </c:when>
		                  <c:when test="${singleOrMultipleGiftItems == 'multiple'}">
		                         <fmt:message key="PROMOTION_FREE_GIFTS_POPUP_PICK_GIFTS" bundle="${storeText}"/>
		                  </c:when>
		              </c:choose>
	              </h2>       
              </div>
              
              <div id="radio_choices">
                  <div id="WC_PromotionChoiceOfFreeGiftsPopupContent_div_2">
                         <input type="radio" name="choose_gift_type" id="free_item" checked="checked" onclick="PromotionChoiceOfFreeGiftsJS.rewardChoicesEnabledStatus();"/>              
                         <c:choose>
	                         <c:when test="${singleOrMultipleGiftItems == 'single'}">
	                                <label for="free_item"><fmt:message key="PROMOTION_FREE_GIFTS_POPUP_PICK_ONE_GIFT" bundle="${storeText}"/></label>
	                         </c:when>
	                         <c:when test="${singleOrMultipleGiftItems == 'multiple'}">
	                                <fmt:parseNumber var="maxQuantity" type="number" value="${giftSetSpec.maximumQuantity.value}"/>
	                                <label for="free_item"><fmt:message key="PROMOTION_FREE_GIFTS_POPUP_PICK_MULTIPLE_GIFTS" bundle="${storeText}"><fmt:param><c:out value="${maxQuantity}"/></fmt:param></fmt:message></label>
	                         </c:when>
                         </c:choose>       
                     </div>
                  <div id="WC_PromotionChoiceOfFreeGiftsPopupContent_div_3">
                         <input type="radio" name="choose_gift_type" id="no_gifts" onclick="PromotionChoiceOfFreeGiftsJS.rewardChoicesEnabledStatus();"/> 
                         <c:choose>
                                <c:when test="${singleOrMultipleGiftItems == 'single'}">
                                	<label for="no_gifts"><fmt:message key="PROMOTION_FREE_GIFTS_POPUP_PICK_NO_GIFT" bundle="${storeText}"/></label>
                                </c:when>
                                <c:when test="${singleOrMultipleGiftItems == 'multiple'}">
                                	<label for="no_gifts"><fmt:message key="PROMOTION_FREE_GIFTS_POPUP_PICK_NO_GIFTS" bundle="${storeText}"/></label>
                                </c:when>
                         </c:choose>                        
                  </div>
              </div>
              <flow:ifDisabled feature="AjaxCheckout"> 
                     <form name="updateRewardChoicesForm" action="OrderChangeServiceRewardOptionUpdate" method="post" id="updateRewardChoicesForm">
                            <input type="hidden" name="langId" value="<c:out value="${WCParam.langId}" />" id="WC_PromotionChoiceOfFreeGiftsPopupContent_FormInput_langId"/>
                            <input type="hidden" name="storeId" value="<c:out value="${WCParam.storeId}" />" id="WC_PromotionChoiceOfFreeGiftsPopupContent_FormInput_storeId"/>
                            <input type="hidden" name="catalogId" value="<c:out value="${WCParam.catalogId}" />" id="WC_PromotionChoiceOfFreeGiftsPopupContent_FormInput_catalogId"/>
                            <input type="hidden" name="orderId" value="<c:out value='${order.orderIdentifier.uniqueID}'/>" id="WC_PromotionChoiceOfFreeGiftsPopupContent_FormInput_orderId"/>
                            <input type="hidden" name="rewardOptionId" value="<c:out value='${rewardOptionID}'/>" id="WC_PromotionChoiceOfFreeGiftsPopupContent_FormInput_rewardOptionId"/>
                            <input type="hidden" name="calculationUsage" value="-1,-2,-3,-4,-5,-6,-7" id="WC_PromotionChoiceOfFreeGiftsPopupContent_FormInput_calculationUsage"/>
                            <input type="hidden" name="allocate" value="***" id="WC_PromotionChoiceOfFreeGiftsPopupContent_FormInput_allocate"/>
                            <input type="hidden" name="backorder" value="***" id="WC_PromotionChoiceOfFreeGiftsPopupContent_FormInput_backorder"/>
                            <input type="hidden" name="URL" value="OrderCalculate?updatePrices=1&orderId=.&calculationUsageId=-1&URL=AjaxOrderItemDisplayView" id="URL"/> 
                            <input type="hidden" name="errorViewName" value="AjaxOrderItemDisplayView" id="errorView"/>
                     </form>                                   
              </flow:ifDisabled> 
              <c:set var="totalNumberOfItems" value="0"/>              
              <div id="free_gifts_table">
                     <div class="gifts_wrapper" id="WC_PromotionChoiceOfFreeGiftsPopupContent_div_4">
                            <c:forEach var="giftSetSpecItems" items="${giftSetSpec.giftItem}" varStatus="status">
                                   <wcbase:useBean id="catalogEntryDB" classname="com.ibm.commerce.catalog.beans.CatalogEntryDataBean" scope="page">
                                          <c:set property="catalogEntryID" value="${giftSetSpecItems.catalogEntryIdentifier.uniqueID}" target="${catalogEntryDB}" />
                                   </wcbase:useBean>
                                   
                                   <fmt:parseNumber var="maxItemQuantity" type="number" value="${giftSetSpecItems.quantity.value}"/>                                   
                                   <c:forEach var="i" begin="1" end="${maxItemQuantity}" varStatus="status2">
                                          <c:set var="totalNumberOfItems" value="${totalNumberOfItems + 1}"/>
                                                                      
                                          <c:set var="match" value=""/>                                                        
                                          <c:forEach var="giftSetItems" items="${giftSet.giftItem}">
                                                <c:set var="giftSetItemID" value="${giftSetItems.catalogEntryIdentifier.uniqueID}"/>
                                                <fmt:parseNumber var="giftSetItemQuantity" type="number" value="${giftSetItems.quantity.value}"/>
                                                <c:set var="giftSetSpecItemID" value="${giftSetSpecItems.catalogEntryIdentifier.uniqueID}"/>
                                                <c:if test="${giftSetSpecItemID==giftSetItemID && i<=giftSetItemQuantity}">
                                                       <c:set var="match" value="checked"/>
                                                </c:if>
                                          </c:forEach>
                                   
                                          <div class="gift_item_container" id="WC_PromotionChoiceOfFreeGiftsPopupContent_div_5_${status.count}_${status2.count}">
                                                 <input type="hidden" name="catalogEntryID" value="${giftSetSpecItems.catalogEntryIdentifier.uniqueID}" id="CatalogEntryID_${totalNumberOfItems}" />
                                                 <input type="hidden" name="giftItemQuantity" value="1" id="GiftItemQuantity_${totalNumberOfItems}" />
                                                 <c:choose>
                                                        <c:when test="${singleOrMultipleGiftItems == 'single'}">
                                                               <div class="selection" id="WC_PromotionChoiceOfFreeGiftsPopupContent_div_6_${status.count}_${status2.count}"><input type="radio" id="SelectFreeGift_${totalNumberOfItems}" name="freeGift" <c:out value="${match}"/> onclick="PromotionChoiceOfFreeGiftsJS.checkNumberOfAllowedItems('<c:out value='${noOfFreeGifts}'/>');" /></div>
                                                        </c:when>
                                                        <c:when test="${singleOrMultipleGiftItems == 'multiple'}">
                                                               <div class="selection" id="WC_PromotionChoiceOfFreeGiftsPopupContent_div_6_${status.count}_${status2.count}"><input type="checkbox" id="SelectFreeGift_${totalNumberOfItems}" name="freeGift" <c:out value="${match}"/> onclick="PromotionChoiceOfFreeGiftsJS.checkNumberOfAllowedItems('<c:out value='${noOfFreeGifts}'/>');" /></div>
                                                        </c:when>
                                                 </c:choose>                                   
                                                 <div class="image" id="WC_PromotionChoiceOfFreeGiftsPopupContent_div_7_${status.count}_${status2.count}">
                                                        <c:choose>
	                                                        <c:when test="${!empty catalogEntryDB.description.thumbNail}">
	                                                               <img src="<c:out value="${catalogEntryDB.objectPath}${catalogEntryDB.description.thumbNail}"/>" name="catEntryImage" width="70" height="70" alt="<c:out value="${catalogEntryDB.description.name}"/> <fmt:message key="Checkout_ACCE_for" bundle="${storeText}" /> <c:out value="${offerPrice}"/>" escapeXml="false"/>                                   
	                                                        </c:when>
	                                                        <c:otherwise>
	                                                               <img src="<c:out value="${hostPath}"/><c:out value="${jspStoreImgDir}" />images/NoImageIcon_sm.jpg" name="noImage" alt="" border="0"/>
	                                                        </c:otherwise>
                                                        </c:choose>       
                                                 </div>
                                                 <div class="product_info" id="WC_PromotionChoiceOfFreeGiftsPopupContent_div_8_${status.count}_${status2.count}">        
                                                        <h2><label for="SelectFreeGift_${totalNumberOfItems}"><c:out value="${catalogEntryDB.description.name}"/></label></h2>
                                                        <p><c:out value="${catalogEntryDB.description.shortDescription}"/></p>
                                                 </div>
                                                 <br/>
                                                 <div class="price" id="WC_PromotionChoiceOfFreeGiftsPopupContent_div_9_${status.count}_${status2.count}"><%@ include file="../../../Snippets/ReusableObjects/CatalogEntryPriceDisplay.jspf"%></div>                                                               
                                                 <div class="clear_float" id="WC_PromotionChoiceOfFreeGiftsPopupContent_div_10_${status.count}_${status2.count}"></div>
                                       </div>                                          
                                   </c:forEach>                                                 
                                   <c:remove var="catalogEntryDB"/>
                            </c:forEach>       
                     </div>
              </div>       
              <div id="FreeGiftsMessageArea">
                     <p id="message" tabindex="-1">
                            
                     </p>                               
              </div>
             <div class="strip_bar" id="submit_div_1">
		       <span class="primary_button" id="submit_div_2">  
	              <span class="button_container">  
	                     <span class="button_bg">  
	                            <span class="button_top">  
	                                   <span class="button_bottom">  
	                                       <a href="#" id="submitChoices" onclick="JavaScript:setCurrentId('PickYourFreeGift'); PromotionChoiceOfFreeGiftsJS.updateRewardChoices('updateRewardChoicesForm','<c:out value='${totalNumberOfItems}'/>','<c:out value='${rewardOptionID}'/>');">
	                                            <fmt:message key="APPLY" bundle="${storeText}"/>
	                                            <span class="spanacce"><fmt:message key="Checkout_ACCE_promo_free_gifts_apply" bundle="${storeText}"/></span>
	                                       </a>
	                                   </span>
	                            </span>
	                     </span>
	              </span>
		       </span>              
		       <span class="secondary_button" id="submit_div_3">  
	              <span class="button_container">  
	                     <span class="button_bg">  
	                            <span class="button_top">  
	                                   <span class="button_bottom">
	                                       <a href="#" id="cancel" onclick="JavaScript:PromotionChoiceOfFreeGiftsJS.hideFreeGiftsPopup('free_gifts_popup');" onkeydown="javascript: PromotionChoiceOfFreeGiftsJS.focusfromCancel(event);" onmousedown="javascript:;">
	                                           <fmt:message key="CANCLE" bundle="${storeText}"/>
	                                           <span class="spanacce"><fmt:message key="Checkout_ACCE_promo_free_gifts_cancel" bundle="${storeText}"/></span>
	                                       </a>       
	                                   </span>
	                            </span>
	                     </span>
	              </span>
		       </span>        
		</div>      
       </c:when>
       <c:otherwise>
	       <div class="title" id="WC_PromotionChoiceOfFreeGiftsPopupContent_div_1">
              <h2>
            	  <fmt:message key="PROMOTION_FREE_GIFTS_PROMOTION_UNAVAILABLE" bundle="${storeText}"/>
              </h2>       
	       </div>              
       </c:otherwise>       
</c:choose>
 
