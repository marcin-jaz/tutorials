<%
//********************************************************************
//*-------------------------------------------------------------------
//* Licensed Materials - Property of IBM
//*
//* WebSphere Commerce
//*
//* (c) Copyright IBM Corp. 2001, 2002, 2004
//*
//* US Government Users Restricted Rights - Use, duplication or
//* disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
//*
//*-------------------------------------------------------------------
//*
%>

<%-- 
  *****
  * This JSP is present on the page if there are payment policies defined for credit cards for the store.
  * The main content includes:
  * - 'Credit card type' dropdown selection
  * - 'Card number' text input
  * - 'Expiration month' dropdown selection
  * - 'Expiration year' dropdown selection
  *****
--%>


<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf" %>


<!-- JSP File Name:  StandardCreditCard.jsp -->
<c:set var="yearString">
	<fmt:message key="YEAR" bundle="${storeText}"/>
</c:set>
<c:set var="monthString">
	<fmt:message key="MONTH" bundle="${storeText}"/>
</c:set>
<c:set var="cardExpiryYearValue" value="${yearString}"/>
<c:set var="cardExpiryMonthValue" value="${monthString}"/>
<c:set var="cardNumberValue" value="" />
<c:set var="cardBrandValue" value="" />

<jsp:useBean id="now" class="java.util.Date"/>
<fmt:formatDate value="${now}" pattern="yyyy" var="currentYear" />
<c:set var="year1"><c:out value="${currentYear + 1}" /></c:set>
<c:set var="year2"><c:out value="${currentYear + 2}" /></c:set>
<c:set var="year3"><c:out value="${currentYear + 3}" /></c:set>
<c:set var="year4"><c:out value="${currentYear + 4}" /></c:set>
<c:set var="year5"><c:out value="${currentYear + 5}" /></c:set>
<c:set var="year6"><c:out value="${currentYear + 6}" /></c:set>


<c:if test="${!empty WCParam.cardExpiryYear}">
	<c:set var="cardExpiryYearValue" value="${WCParam.cardExpiryYear}"/>
</c:if>
<c:if test="${!empty WCParam.cardExpiryMonth}">
	<c:set var="cardExpiryMonthValue" value="${WCParam.cardExpiryMonth}"/>
</c:if>

<c:if test="${state eq 'QuickCheckout'}">
	<wcbase:useBean id="orderBean" classname="com.ibm.commerce.order.beans.OrderDataBean" scope="page">
		<c:set value="${WCParam.orderId}" target="${orderBean}" property="orderId"/>
	</wcbase:useBean>	
	<c:set var="payInfo" value="${orderBean.paymentInfo}" />
	<c:if test="${!empty payInfo}">
		<c:if test="${!empty payInfo.cardExpiryYear}">
			<c:set var="cardExpiryYearValue" value="${payInfo.cardExpiryYear}"/>
		</c:if>
		<c:if test="${!empty payInfo.cardExpiryMonth}">
			<c:set var="cardExpiryMonthValue" value="${payInfo.cardExpiryMonth}"/>
		</c:if>
		<c:if test="${!empty payInfo.cardNumber}">
			<c:set var="cardNumberValue" value="${payInfo.cardNumber}"/>
		</c:if>
		<c:if test="${!empty payInfo.cardBrand}">
			<c:set var="cardBrandValue" value="${payInfo.cardBrand}"/>
		</c:if>
	</c:if>
</c:if>

<!-- JSP File Name:  StandardCreditCard.jsp -->
<table cellpadding="3" cellspacing="0" border="0" id="WC_StandardCreditCard_Table_1">

<tbody><tr>
<td valign="middle" id="WC_StandardCreditCard_TableCell_1">
	<span class="reqd">*</span><span class="strongtext"><label for="cardBrandLabel"><fmt:message key="CREDIT_CARD_TYPE" bundle="${storeText}"/></label></span>
</td>
<td valign="middle" id="WC_StandardCreditCard_TableCell_2">
	<select name="cardBrand" id="cardBrandLabel">

	<flow:ifEnabled feature="CommercePaymentsSupport">
		<c:forEach items="${offlineCards}" var="cardInfo" varStatus="status">
			<c:if test="${!empty cardInfo.value.brand}">
				<option <c:if test="${cardInfo.value.brand eq cardBrandValue}">selected="selected"</c:if> value="<c:out value="${cardInfo.value.brand}"/>"><c:out value="${cardInfo.value.brand}"/></option>
			</c:if>
		</c:forEach>
	</flow:ifEnabled>
	<flow:ifDisabled feature="CommercePaymentsSupport">
		<c:forEach items="${simplePaymentCreditCardPolicies}" var="cardInfo" varStatus="status">
			<c:if test="${!empty cardInfo.value.longDescription}">
				<option <c:if test="${cardInfo.value.longDescription eq cardBrandValue}">selected="selected"</c:if> value="<c:out value="${cardInfo.value.policyId}"/>"><c:out value="${cardInfo.value.longDescription}"/></option>
			</c:if>
		</c:forEach>
	</flow:ifDisabled>
	</select>
</td>
</tr>
<tr>
<td valign="middle" id="WC_StandardCreditCard_TableCell_3">
	<span class="reqd">*</span><span class="strongtext"><label for="WC_StandardCreditCard_FormInput_cardNumber_1"><fmt:message key="CARD_NUMBER" bundle="${storeText}"/></label></span>
</td>
<td valign="middle" id="WC_StandardCreditCard_TableCell_4">
	<input type="text" size="20" name="cardNumber" id="WC_StandardCreditCard_FormInput_cardNumber_1" value="<c:out value="${cardNumberValue}"/>"/>
</td>
</tr>
<tr>
<td valign="middle" id="WC_StandardCreditCard_TableCell_5">
	<span class="reqd">*</span><span class="strongtext"><label for="cardExpiryMonthLabel"><fmt:message key="EXPIRATION" bundle="${storeText}"/></label></span>
</td>
<td valign="middle" id="WC_StandardCreditCard_TableCell_6">


<select name="cardExpiryMonth" id="cardExpiryMonthLabel" title="<c:out value="${monthString}"/>" size="1">
	<option <c:if test="${cardExpiryMonthValue eq monthString}"> selected="selected" </c:if> value="<c:out value="${monthString}"/>"><c:out value="${monthString}"/></option>
	<option <c:if test="${cardExpiryMonthValue eq '01'}"> selected="selected" </c:if> value="01">01</option>
	<option <c:if test="${cardExpiryMonthValue eq '02'}"> selected="selected" </c:if> value="02">02</option>
	<option <c:if test="${cardExpiryMonthValue eq '03'}"> selected="selected" </c:if> value="03">03</option>
	<option <c:if test="${cardExpiryMonthValue eq '04'}"> selected="selected" </c:if> value="04">04</option>
	<option <c:if test="${cardExpiryMonthValue eq '05'}"> selected="selected" </c:if> value="05">05</option>
	<option <c:if test="${cardExpiryMonthValue eq '06'}"> selected="selected" </c:if> value="06">06</option>
	<option <c:if test="${cardExpiryMonthValue eq '07'}"> selected="selected" </c:if> value="07">07</option>
	<option <c:if test="${cardExpiryMonthValue eq '08'}"> selected="selected" </c:if> value="08">08</option>
	<option <c:if test="${cardExpiryMonthValue eq '09'}"> selected="selected" </c:if> value="09">09</option>
	<option <c:if test="${cardExpiryMonthValue eq '10'}"> selected="selected" </c:if> value="10">10</option>
	<option <c:if test="${cardExpiryMonthValue eq '11'}"> selected="selected" </c:if> value="11">11</option>
	<option <c:if test="${cardExpiryMonthValue eq '12'}"> selected="selected" </c:if> value="12">12</option>
</select>


<label for="cardExpiryYearLabel"></label>
<select name="cardExpiryYear" id="cardExpiryYearLabel" title="<c:out value="${yearString}"/>" size="1">
	<option <c:if test="${cardExpiryYearValue eq yearString}"> selected="selected" </c:if> value="<c:out value="${yearString}"/>"><c:out value="${yearString}"/></option>
	<option <c:if test="${cardExpiryYearValue eq currentYear}"> selected="selected" </c:if> value="<c:out value="${currentYear}"/>"><c:out value="${currentYear}"/></option>
	<option <c:if test="${cardExpiryYearValue eq year1}"> selected="selected" </c:if> value="<c:out value="${year1}"/>"><c:out value="${year1}"/></option>
	<option <c:if test="${cardExpiryYearValue eq year2}"> selected="selected" </c:if> value="<c:out value="${year2}"/>"><c:out value="${year2}"/></option>
	<option <c:if test="${cardExpiryYearValue eq year3}"> selected="selected" </c:if> value="<c:out value="${year3}"/>"><c:out value="${year3}"/></option>
	<option <c:if test="${cardExpiryYearValue eq year4}"> selected="selected" </c:if> value="<c:out value="${year4}"/>"><c:out value="${year4}"/></option>
	<option <c:if test="${cardExpiryYearValue eq year5}"> selected="selected" </c:if> value="<c:out value="${year5}"/>"><c:out value="${year5}"/></option>
	<option <c:if test="${cardExpiryYearValue eq year6}"> selected="selected" </c:if> value="<c:out value="${year6}"/>"><c:out value="${year6}"/></option>
</select>


</td>
</tr>
</tbody>
</table>
<!-- End JSP File Name:  StandardCreditCard.jsp -->
