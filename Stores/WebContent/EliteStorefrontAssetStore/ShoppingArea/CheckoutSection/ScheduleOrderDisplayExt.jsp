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
<%--
  *****
  * This JSP file renders the schedule order section on the shipping and billing page, order summary page and order confirmation page in the checkout flow.
  * This section is only displayed if the 'schedule order' flex flow option is enabled. 
  * Parameters for order scheduling can be edited on the shipping and billing page, but not on the order summary or confirmation page. 
  *****
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../include/JSTLEnvironmentSetup.jspf" %>

<c:set var="orderId" value="${param.orderId}"/>
<c:if test="${WCParam.originalOrderId != null}">
	<c:set var="orderId" value="${WCParam.originalOrderId}"/>
</c:if>

<input type="hidden" id="orderIdToSchedule" name="orderIdToSchedule" value="${param.orderId}"/>

<c:set var="key" value="WC_ScheduleOrder_${orderId}_interval"/>
<c:set var="interval" value="${cookie[key].value}"/>

<c:set var="key" value="WC_ScheduleOrder_${orderId}_strStartDate"/>
<c:set var="strStartDate" value="${cookie[key].value}"/>

<c:set var="strStartDate" value="${fn:replace(strStartDate, '%3A', ':')}"/>

<c:if test="${(interval == null || strStartDate == null) && !empty requestScope.order}">
	<c:set var="order" value="${requestScope.order}"/>
	<c:set var="interval" value="${order.orderScheduleInfo.interval}"/>
	<c:set var="strStartDate" value="${order.orderScheduleInfo.startTime}"/>
</c:if>

<c:catch>
	<fmt:parseDate var="strStartDate" value="${strStartDate}" pattern="yyyy-MM-dd'T'HH:mm:ss.SSS'Z'" timeZone="GMT"/>
</c:catch>
<c:if test="${empty strStartDate}">
	<c:catch>
		<fmt:parseDate var="strStartDate" value="${strStartDate}" pattern="yyyy-MM-dd'T'HH:mm:ss'Z'" timeZone="GMT"/>
	</c:catch>
</c:if>

<c:if test="${param.isShippingBillingPage || (interval != null && strStartDate != null && strStartDate != '' && (strStartDate.year+1900 != 1970))}">
	
	<c:set var="formattedTimeZone" value="${fn:replace(cookie.WC_timeoffset.value, '%2B', '+')}"/>
	<c:set var="formattedTimeZone" value="${fn:replace(formattedTimeZone, '.75', ':45')}"/>	
	<c:set var="formattedTimeZone" value="${fn:replace(formattedTimeZone, '.5', ':30')}"/>
	<fmt:formatDate value="${strStartDate}" type="date" pattern="yyyy-MM-dd" var="formattedstrStartDate" dateStyle="long" timeZone="${formattedTimeZone}"/>
	
	<div class="main_header" id="WC_ScheduleOrder_div_1">
		<div class="left_corner_straight" id="WC_ScheduleOrder_div_2"></div>
		<div class="left" id="WC_ScheduleOrder_div_3">
			<span class="main_header_text" id="WC_ScheduleOrder_span_1"><fmt:message key="SCHEDULE_ORDER_HEADER" bundle="${storeText}"/></span>
		</div>
		<div class="right_corner_straight" id="WC_ScheduleOrder_div_4"></div>
	</div>
	
	<c:choose>
		<c:when test="${empty order || order.orderScheduleInfo.startTime == null || empty order.orderScheduleInfo.startTime}">
			<div class="content_header" id="WC_ScheduleOrder_div_5">
				<div class="left_corner" id="WC_ScheduleOrder_div_6"></div>
				<div class="left" id="WC_ScheduleOrder_div_7">
					<span class="content_text" id="WC_ScheduleOrder_span_2"><fmt:message key="SCHEDULE_ORDER_HEADER_MESSAGE" bundle="${storeText}"/></span>
				</div>
				<div class="right_corner" id="WC_ScheduleOrder_div_8"></div>
			</div>
		</c:when>
		<c:otherwise>
			<div id="WC_ScheduleOrder_div_15" class="contentline"></div>
		</c:otherwise>
	</c:choose>
	
	<div class="scheduleOrderArea" id="scheduleOrderInputSection">
		<div id="WC_ScheduleOrder_div_9" class="scheduleOrderAreaInterval">
			<div id="WC_ScheduleOrder_div_10" class="title"><label for="ScheduleOrderFrequency"><fmt:message key="SCHEDULE_ORDER_INTERVAL_TITLE" bundle="${storeText}"/></label></div>
			<div id="WC_ScheduleOrder_div_11">
				<c:choose>
					<c:when test="${param.isShippingBillingPage}">
						<select class="drop_down" name="ScheduleOrderFrequency" id="ScheduleOrderFrequency" onchange="JavaScript:this.blur();">
							<option value="undefined" <c:if test="${interval == null}">selected="selected"</c:if>><fmt:message key="SCHEDULE_ORDER_DROP_DOWN_SELECT_FREQUENCY" bundle="${storeText}"/></option>
							<option value="" <c:if test="${interval == ''}">selected="selected"</c:if>><fmt:message key="SCHEDULE_ORDER_INTERVAL_1" bundle="${storeText}"/></option>
							<option value="86400" <c:if test="${interval == 86400}">selected="selected"</c:if>><fmt:message key="SCHEDULE_ORDER_INTERVAL_2" bundle="${storeText}"/></option>
							<option value="604800" <c:if test="${interval == 604800}">selected="selected"</c:if>><fmt:message key="SCHEDULE_ORDER_INTERVAL_3" bundle="${storeText}"/></option>
							<option value="1209600" <c:if test="${interval == 1209600}">selected="selected"</c:if>><fmt:message key="SCHEDULE_ORDER_INTERVAL_4" bundle="${storeText}"/></option>
							<option value="1814400" <c:if test="${interval == 1814400}">selected="selected"</c:if>><fmt:message key="SCHEDULE_ORDER_INTERVAL_5" bundle="${storeText}"/></option>
							<option value="2419200" <c:if test="${interval == 2419200}">selected="selected"</c:if>><fmt:message key="SCHEDULE_ORDER_INTERVAL_6" bundle="${storeText}"/></option>
						</select>
					</c:when>
					<c:otherwise>
						<c:choose>
							<c:when test="${empty (fn:trim(interval)) || interval == 0}">
								<fmt:message key="SCHEDULE_ORDER_INTERVAL_1" bundle="${storeText}"/>
							</c:when>
							<c:when test="${interval == 86400}">
								<fmt:message key="SCHEDULE_ORDER_INTERVAL_2" bundle="${storeText}"/>
							</c:when>
							<c:when test="${interval == 604800}">
								<fmt:message key="SCHEDULE_ORDER_INTERVAL_3" bundle="${storeText}"/>
							</c:when>
							<c:when test="${interval == 1209600}">
								<fmt:message key="SCHEDULE_ORDER_INTERVAL_4" bundle="${storeText}"/>
							</c:when>
							<c:when test="${interval == 1814400}">
								<fmt:message key="SCHEDULE_ORDER_INTERVAL_5" bundle="${storeText}"/>
							</c:when>
							<c:when test="${interval == 2419200}">
								<fmt:message key="SCHEDULE_ORDER_INTERVAL_6" bundle="${storeText}"/>
							</c:when> 
						</c:choose>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
		<div id="WC_ScheduleOrder_div_12" class="scheduleOrderAreaStartDate">
			<div id="WC_ScheduleOrder_div_13" class="title"><label for="ScheduleOrderStartDate"><fmt:message key="SCHEDULE_ORDER_START_DATE_TITLE" bundle="${storeText}"/></label></div>
			<div id="ScheduleOrderStartDate_inputField" class="dijitCalendarWidth">
				<c:choose>
					<c:when test="${param.isShippingBillingPage}">
						<input 
							id="ScheduleOrderStartDate" 
							name="ScheduleOrderStartDate" 
							size="6" 
							onclick="dojo.byId('ScheduleOrderFrequency').focus(); dojo.byId('ScheduleOrderStartDate').focus();"
							onchange="JavaScript:CheckoutHelperJS.validateDate(this, 'ScheduleOrderStartDate');" 
							dojoType="dijit.form.DateTextBox" 
							invalidMessage="<fmt:message key="INVALID_DATE_FORMAT_ERROR" bundle="${storeText}"/>"  
							value="<c:if test="${strStartDate != null}"><c:out value="${formattedstrStartDate}"/></c:if>"
						/>
						<script type="text/javascript">
							dojo.addOnLoad(function() { parseWidget("ScheduleOrderStartDate"); });
						</script>
					</c:when>
					<c:otherwise>
						<c:choose>
							<c:when test="${strStartDate.year+1900 != 1970}">
								<c:out value="${formattedstrStartDate}"/>
							</c:when>
							<c:otherwise>
								<c:out value=""/>
							</c:otherwise>
						</c:choose>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
		<div id="ScheduleOrder_clearFloatDiv" class="clear_float"></div>
	</div>
</c:if>

