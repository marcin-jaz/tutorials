<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2007, 2009 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>

<%--
  *****
  * This JSP creates an HTML table displaying the promotion code redemption
  * field plus all the applied promotion in an order.
  *
  * How to use this snippet?
  * 1. To display this feature in your store's checkout page, you can cut and
  *    paste the code from the snippet to your checkout page, or simply include it:
  *                     <c:import url="../../Snippets/Marketing/Promotions/PromotionsCodeDisplay.jsp">
  *                            <c:param name="orderId" value="10001"/>
       *                     </c:import>
  *****
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf"%>

<%-- ErrorMessageSetup.jspf is used to retrieve an appropriate error message when there is an error--%>
<%@ include file="../../../include/ErrorMessageSetup.jspf" %>


<script type="text/javascript">
       dojo.addOnLoad(function() {
              <fmt:message key="PROMOTION_CODE_EMPTY" bundle="${storeText}" var="PROMOTION_CODE_EMPTY"/>
              MessageHelper.setMessage("PROMOTION_CODE_EMPTY", <wcf:json object="${PROMOTION_CODE_EMPTY}"/>);
       });
</script>

<c:choose>
       <c:when test="${empty param.orderId}">
              <c:choose>
                     <c:when test="${!empty WCParam.orderId}">
                            <c:set var="orderId" value="${WCParam.noElementToDisplay}" />
                     </c:when>
              </c:choose>
       </c:when>
       <c:otherwise>
              <c:set var="orderId" value="${param.orderId}" />
       </c:otherwise>
</c:choose>

<c:set var="returnView" value=""/>
<c:if test="${!empty param.returnView}">
       <c:set var="returnView" value="${param.returnView}"/>
</c:if>

<wcf:url var="PromotionCodeManage" value="PromotionCodeManage"  type="Ajax">
       <wcf:param name="langId" value="${WCParam.langId}" />
       <wcf:param name="storeId" value="${WCParam.storeId}" />
       <wcf:param name="catalogId" value="${WCParam.catalogId}" />
</wcf:url>



<wcbase:useBean id="promoCodeListBean" classname="com.ibm.commerce.marketing.databeans.PromoCodeListDataBean" scope="page">
       <c:set property="orderId" value="${orderId}" target="${promoCodeListBean}" />
</wcbase:useBean> 

<script type="text/javascript">
       dojo.addOnLoad(initPromotionAssets); 
       
       function initPromotionAssets(){
              <c:if test="${!empty errorMessage}">
                     MessageHelper.displayErrorMessage(<wcf:json object="${errorMessage}"/>); 
              </c:if>       
       }

</script>

 <form name="PromotionCodeForm" id="PromotionCodeForm" method="post" action="<c:out value="${PromotionCodeManage}"/>" onsubmit="javascript: return false;">
        <%-- the "onsubmit" option in the form tag above is to handle problems when a user apply a promotion code by pressing the Enter key in the promotion code input area:
               1) when in an AJAX checkout flow
               2) when the promotion code is empty in a non-AJAX flow --%>

       <input type="hidden" name="orderId" value="<c:out value="${orderId}"/>" id="WC_PromotionCodeDisplay_FormInput_orderId_In_PromotionCodeForm_1"/>
       <input type="hidden" name="taskType" value="A" id="WC_PromotionCodeDisplay_FormInput_page_In_PromotionCodeForm_1"/>
       <input type="hidden" name="URL" value="" id="WC_PromotionCodeDisplay_FormInput_URL_In_PromotionCodeForm_1"/>
       <input type="hidden" name="storeId" value="${WCParam.storeId}" id="WC_PromotionCodeDisplay_FormInput_storeId_In_PromotionCodeForm_1"/>
       <input type="hidden" name="catalogId" value="${WCParam.catalogId}" id="WC_PromotionCodeDisplay_FormInput_catalogId_In_PromotionCodeForm_1"/>
       <input type="hidden" name="langId" value="${WCParam.langId}" id="WC_PromotionCodeDisplay_FormInput_langId_In_PromotionCodeForm_1"/>
       <input type="hidden" name="finalView" value="AjaxOrderItemDisplayView" id="WC_PromotionCodeDisplay_FormInput_finalView_In_PromotionCodeForm_1"/>
       

       <div class="promotion_code" id="WC_PromotionCodeDisplay_div_1">
              <label for="promoCode"><fmt:message key="PROMOTION_CODE" bundle="${storeText}"/>:</label>
       </div>
          
       <div class="promotion_input" id="WC_PromotionCodeDisplay_div_2">
              <input type="text" class="input" size="6" name="promoCode" id="promoCode" onkeypress="if(event.keyCode==13) JavaScript:CheckoutHelperJS.applyPromotionCode('PromotionCodeForm','<c:out value='${returnView}'/>')"/>
       </div>

       <div class="promotion_button" id="WC_PromotionCodeDisplay_div_3">
              <span class="secondary_button button_fit" id="WC_PromotionCodeDisplay_div_4">
                     <span class="button_container">
                            <span class="button_bg">
                                   <span class="button_top">
                                          <span class="button_bottom">   
                                                 <a href="#" onclick="JavaScript:setCurrentId('WC_PromotionCodeDisplay_links_1'); CheckoutHelperJS.applyPromotionCode('PromotionCodeForm','<c:out value='${returnView}'/>');return false;" class="button_text" id="WC_PromotionCodeDisplay_links_1">
                                                        <fmt:message key="APPLY" bundle="${storeText}"/>
                                                        <span class="spanacce"><fmt:message key="Checkout_ACCE_promo_code_apply" bundle="${storeText}"/></span>
                                                 </a>
                                          </span>
                                   </span>
                            </span>       
                     </span>
              </span>       
                
              <c:set var="promoCodeString" value=""/>
              <br clear="all"/>
       </div>
              <div id="appliedPromotionCodes">                                   
                     <c:forEach var="promotionCode" items="${promoCodeListBean.codes}" varStatus="status">
                            <c:set var="promoCodeString" value="${promoCodeString},${promotionCode.code}"/>
                            <div class="promotion_used">
								<c:set var="aPromotionCode" value='${fn:replace(promotionCode.code, "\'", "&#39;")}'/>
								<p>
									<a class="font1" id="promotion_${status.count}" href="#" onclick='JavaScript:setCurrentId("<c:out value='${status.count}'/>");CheckoutHelperJS.removePromotionCode("PromotionCodeForm",<wcf:json object='${aPromotionCode}'/>,"<c:out value='${returnView}'/>");return false;'>
									<img src="<c:out value='${jspStoreImgDir}${vfileColor}'/>table_x_delete.png" alt="<fmt:message key="PROMOTION_CODE_REMOVE" bundle="${storeText}" />"/>
									<fmt:message key="PROMOTION_CODE_REMOVE" bundle="${storeText}"/> <c:out value="${promotionCode.code}"/></a><br />
								</p>
                            </div>
                            <div id="WC_PromotionCodeDisplay_span_${status.count}" tabindex="0" dojoType="wc.widget.Tooltip" connectId="promotion_${status.count}" style="display:none">
                                   <div id="tooltip_popup">
                                          <div class="header" id="WC_PromotionCodeDisplay_div_6_${status.count}"> 
                                                 <div class="close" id="WC_PromotionCodeDisplay_div_7_${status.count}"><fmt:message key="PROMOTION_DETAILS" bundle="${storeText}"/></div>
                                          </div>
                                          <div class="bodyarea" id="WC_PromotionCodeDisplay_div_8_${status.count}">
                                                 <%-- Calculate the height of the tooltip needed. Start with 10px initially (for the space between end of description and footer). (Set Height = length of promotion String /2) --%>
                                                 <c:set var="descStringLen" value="10"/> 
                                                 <c:forEach var="desc" items="${promotionCode.descArray}">
                                                        <c:set var="descStringLen" value="${fn:length(desc) + descStringLen}"/>
                                                 </c:forEach>
                                                 <div class="bodycontent" style="height:${descStringLen/2}px;overflow:hidden;" id="WC_PromotionCodeDisplay_div_9_${status.count}">
                                                        <c:set var="emptyDesc" value="true"/>
                                                        <c:forEach var="desc" items="${promotionCode.descArray}" varStatus="status2">
                                                               <c:if test = "${!empty desc}">
                                                                      <c:set var="emptyDesc" value="false"/>
                                                                      <div id="WC_PromotionCodeDisplay_div_10_${status.count}_${status2.count}">
                                                                             <div class="required-field" id="WC_PromotionCodeDisplay_div_11_${status.count}_${status2.count}">*</div>&nbsp;
                                                                             <c:out value="${desc}"/><br />
                                                                      </div>
                                                               </c:if>
                                                        </c:forEach>
                                                        <c:if test="${emptyDesc}">
                                                               <div id="WC_PromotionCodeDisplay_div_12_${status.count}">
                                                                      <div class="required-field" id="WC_PromotionCodeDisplay_div_13_${status.count}">*</div>&nbsp;
                                                                      <fmt:message key="PROMO_NO_DESC" bundle="${storeText}"/><br />
                                                               </div>
                                                        </c:if>
                                                 </div>
                                          </div>
                                          <div class="footer" id="WC_PromotionCodeDisplay_div_14_${status.count}"> </div>
                                   </div>
                            </div>
                            <script type="text/javascript">
                                   dojo.addOnLoad(function() { 
                                          parseWidget("WC_PromotionCodeDisplay_span_${status.count}");
                                   });
                            </script>
                     </c:forEach>
                     <!--  <input type="hidden" name="newPromoCode" id="newPromoCode" value="${promoCodeString}"/> -->
              </div>
              

       
       <br clear="left" />

</form>
