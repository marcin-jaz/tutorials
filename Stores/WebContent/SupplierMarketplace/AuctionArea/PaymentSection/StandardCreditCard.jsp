<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2000, 2009 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>

<c:set var="cardId" value="${param.cardId}" />
<c:set var="cardDesc" value="${param.cardDesc}" />
<c:set var="cardName" value="${param.cardName}" />
<c:set var="cardBrand" value="${param.cardBrand}" />
<c:set var="paymentString" value="${param.paymentString}" /> 
<%@ include file="../../include/JSTLEnvironmentSetup.jspf" %>
<fmt:setLocale value="${CommandContext.locale}" />
<fmt:setBundle	basename="com/ibm/commerce/tools/order/properties/paymentBuyPagesNLS" var="paymentText" />

<html lang="en">
<body>
<script>
function BuildPolicyString() {
	var ret;
	var monthIndex = self.document.BidForm.cardExpiryMonth.selectedIndex;
	var yearIndex = self.document.BidForm.cardExpiryYear.selectedIndex;

	var cNumber = self.document.BidForm.cardNumber.value;

	var cMonth = self.document.BidForm.cardExpiryMonth.options[monthIndex].value

	var cYear = self.document.BidForm.cardExpiryYear.options[yearIndex].value;

	ret = "policyId" + "=" + "<c:out value="${cardId}" />" + ";" + "cardBrand" + "=" + "<c:out value="${cardBrand}" />" + ";" + "cardNumber" + "=" + cNumber + ";" + "cardExpiryMonth" + "=" + cMonth + ";" + "cardExpiryYear" + "=" + cYear;		
//alert(ret);
	return ret;
	}
	
function CheckPayInfo(){
	var form1 = self.document.BidForm;	
	var cNumber = form1.cardNumber.value;
	if(cNumber == ""){
		var msg = "<fmt:message key="_ERR_INVALID_DEVICE_NUMBER" bundle="${storeText}" />";
		alert(msg);
		return false;
	}
	
	var monthIndex = form1.cardExpiryMonth.selectedIndex;
	var yearIndex = form1.cardExpiryYear.selectedIndex;
	
	if(monthIndex==0||yearIndex==0){
		var msg = "<fmt:message key="_ERR_INVALID_DEVICE_EXPIRY_DATE" bundle="${storeText}" />";
		alert(msg);
		return false;
	}

	return true;
}
//----------------------------------------------------------------------------------
// To be called in bidform's body init, to enable payment entries in bidform
// which can be modified by customer.
//----------------------------------------------------------------------------------
function policyInit() {
	//alert("policyInit");
	var ctx;
	
	ctx= "<c:out value="${cc_number}" />";
	if(ctx==null || ctx == "null" || ctx.length==0) ctx="";
	self.document.BidForm.cardNumber.value = ctx;		
	self.document.BidForm.cardExpiryMonth.selectedIndex = 0
	for(var i=0; i< self.document.BidForm.cardExpiryMonth.length; i++) {
		if ( "<c:out value="${cc_month}" />"  == self.document.BidForm.cardExpiryMonth.options[i].value) {
			self.document.BidForm.cardExpiryMonth.selectedIndex = i
			break
		}
	} 

	self.document.BidForm.cardExpiryYear.selectedIndex = 0
	for(var i=0; i< self.document.BidForm.cardExpiryYear.length; i++) {
		if ( "<c:out value="${cc_year}" />"  == self.document.BidForm.cardExpiryYear.options[i].value) {
			self.document.BidForm.cardExpiryYear.selectedIndex = i
			break
		}
	}

}
</script>
<table class="list" cellpadding="0" cellspacing="0" border="0" width="550" id="WC_Payment_Table_1">
	<!-- TR><TD  align=RIGHT width=260></TD></TR -->
	<tbody>
		<tr>
			
			<td align="left" id="WC_Payment_TableCell_1">
			<label for="WC_Payment_cardNumber_In_BidForm">
			<fmt:message key="cardNumber" bundle="${paymentText}" />
			</label>
			</td>			
			<td align="left" id="WC_Payment_TableCell_2">
			<label for="WC_Payment_cardExpiryMonth_In_BidForm">
			<fmt:message key="cardExpireMonth"	bundle="${paymentText}" />
			</label>
			</td>			
			<td align="left" id="WC_Payment_TableCell_3">
			<label for="WC_Payment_cardExpiryYear_In_BidForm">
			<fmt:message key="cardExpiryYear"	bundle="${paymentText}" />
			</label>
			</td>
			
		</tr>

		<tr>
			<td align="LEFT" id="WC_Payment_TableCell_4">
			<input type="text" size="30" maxlength="16" name="cardNumber" value="" onchange="" id="WC_Payment_cardNumber_In_BidForm"/>
			</td>

			<!--<TD align=left width=260>-->
			<td align="left" id="WC_Payment_TableCell_5">
			<select name="cardExpiryMonth" size="1" onchange="" id="WC_Payment_cardExpiryMonth_In_BidForm">
				<option selected></option>
				<option value="01"><fmt:message key="january" bundle="${paymentText}" /></option>
				<option value="02"><fmt:message key="february" bundle="${paymentText}" /></option>
				<option value="03"><fmt:message key="march" bundle="${paymentText}" /></option>
				<option value="04"><fmt:message key="april" bundle="${paymentText}" /></option>
				<option value="05"><fmt:message key="may" bundle="${paymentText}" /></option>
				<option value="06"><fmt:message key="june" bundle="${paymentText}" /></option>
				<option value="07"><fmt:message key="july" bundle="${paymentText}" /></option>
				<option value="08"><fmt:message key="august" bundle="${paymentText}" /></option>
				<option value="09"><fmt:message key="august" bundle="${paymentText}" /></option>
				<option value="10"><fmt:message key="october" bundle="${paymentText}" /></option>
				<option value="11"><fmt:message key="november" bundle="${paymentText}" /></option>
				<option value="12"><fmt:message key="december"bundle="${paymentText}" /></option>
			</select>
			</td>

			<!--<TD align=left width=260>-->
			<td align="left" id="WC_Payment_TableCell_6">
			<select name="cardExpiryYear" size="1" onchange="" id="WC_Payment_cardExpiryYear_In_BidForm">
				<option selected></option>
			   <%java.util.Date tempdate = new java.util.Date();
				 int tempyear = tempdate.getYear()+1900;
				 for(int incres = 0; incres < 10; incres++){
			   %>
			   		<option	value="<%=tempyear+incres%>"><%=tempyear+incres%></option>
			   <%
			   	 }
			   %>
			</select>
			</td>
		</tr>
	</tbody>
</table>
</body>
</html>
