<%
//********************************************************************
//*-------------------------------------------------------------------
//* Licensed Materials - Property of IBM
//*
//* WebSphere Commerce
//*
//* (c) Copyright IBM Corp. 2003
//*
//* US Government Users Restricted Rights - Use, duplication or
//* disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
//*
//*-------------------------------------------------------------------
//*
//*---------------------------------------------------------------------
//* The sample contained herein is provided to you "AS IS".
//*
//* It is furnished by IBM as a simple example and has not been  
//* thoroughly tested
//* under all conditions.  IBM, therefore, cannot guarantee its 
//* reliability, serviceability or functionality.  
//*
//* This sample may include the names of individuals, companies, brands 
//* and products in order to illustrate concepts as completely as 
//* possible.  All of these names
//* are fictitious and any similarity to the names and addresses used by 
//* actual persons 
//* or business enterprises is entirely coincidental.
//*---------------------------------------------------------------------
//*
%>
<%-- 
  ***
  * This Jsp snippet displays ... (functional description)
  *
  * How to use this snippet?
  * 1. This snippet is available under the /WCS_installDir/samples/ directory
  *    The file path of this snippet is Snippets/Catalog/Category/CategoriesDisplay.jsp
  * 2. To display this feature in your store's xxx page, cut and paste the code from the
  *    snippet to your xxx page ... (list all the steps)
  * 3. To test this out, copy the Directory /Snippets/ from /WC_installDir/samples/ to 
  *         /WAS_installDir/installedApps/instance_name/WC_instance.ear/Stores.war/Store_Dir/
  * 4. Include this page into the store xxx page. 
  *     For example: add the following code into /ShoppingArea/CatalogSection/CategorySubsection/SubCategoriesDisplay.jsp
  * 		<c:import url="${jspStoreDir}Snippets/Catalog/Category/CategoriesDisplay.jsp" />    
  * 5. Before you can see this feature, you must ... (list all the steps)
  ***
--%>


<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>

<%@ include file="../../Snippets/EDP/EDPEnvironmentSetup.jspf"%>



<c:set var="cardId" value="${param.cardId}" />
<c:set var="cardDesc" value="${param.cardDesc}" />
<c:set var="cardName" value="${param.cardName}" />
<c:set var="cardBrand" value="${param.cardBrand}" />
<c:set var="paymentString" value="${param.paymentString}" />
<wcbase:useBean id="helperBean" classname="com.ibm.commerce.negotiation.misc.AuctionUtilityHelper">
	<c:set  property="paymentString" value="${param.paymentString}" target="${helperBean}" />
</wcbase:useBean>
<jsp:useBean id="now" class="java.util.Date"/>
<c:set var="expire_year" value="${now.year + 1900}"/>

<c:set var="payInfo" value="${helperBean.payInfoObject}"/>
<table cellpadding="3" cellspacing="0" border="0" id="StandardMasterCard_Table_1">
	
	<tr>
		<td colspan="4" valign="middle" id="StandardMasterCard_TableCell_11">
			<label for="StandardMasterCard_InputText_1">
				<span class="required">*</span>
				<strong><fmt:message key="EDPPaymentMethods_MAST_CARD_NUMBER" bundle="${edpText}" /></strong>
			
			</label>
		</td>
		<td colspan="4" valign="middle" id="StandardMasterCard_TableCell_12">
			<input type="text" name="account" value=""	id="StandardMasterCard_InputText_1" />
			
		</td>
	</tr>
	<tr>
		<td colspan="4" valign="middle" id="StandardMasterCard_TableCell_21">
			<label for="edp_Master_cardExpiryMonth">
				<span class="required">*</span>
				<strong><fmt:message key="EDPPaymentMethods_MAST_EXPIRATION_MONTH" bundle="${edpText}" /></strong>
			</label>
		</td>
		<c:set var="edp_ProtocolData.cardExpiryMonth" value="12" />
		<td colspan="4" valign="middle" id="StandardMasterCard_TableCell_22">
			<select name="expire_month" size=1 id="edp_Master_cardExpiryMonth">
				<option selected></option>
				<option value="01">01</option>
				<option value="02">02</option>
				<option value="03">03</option>
				<option value="04">04</option>
				<option value="05">05</option>
				<option value="06">06</option>
				<option value="07">07</option>
				<option value="08">08</option>
				<option value="09">09</option>
				<option value="10">10</option>
				<option value="11">11</option>
				<option value="12">12</option>
		</select></td>
	</tr>
	<tr>
		<td colspan="4" valign="middle" id="StandardMasterCard_TableCell_31">
			<label for="edp_Master_cardExpiryYear">
				<span class="required">*</span>
				<strong><fmt:message key="EDPPaymentMethods_MAST_EXPIRATION_YEAR" bundle="${edpText}" /></strong>
			</label>
		</td>
		<td colspan="4" valign="middle" id="StandardMasterCard_TableCell_32">
		<select name="expire_year" size=1 id="edp_Master_cardExpiryYear">
			<c:forEach begin="0" end="10" varStatus="counter">
				<option
				<c:if test="${expire_year == expire_year+counter.index }" > selected="selected" </c:if>
				value="${expire_year+counter.index}">${expire_year+counter.index}</option>
			</c:forEach>
		</select>
		</td>
	</tr>
	
	
	
</table>

<script language="javascript">

function checkInputParam(formName)
{
	var ret = false;
	var now = new Date();	
	var lastday = 1;
	var lastmonth = new Number(formName.expire_month.value) + 1;
	if (lastmonth == 13) {
		lastmonth = 1;
	}
	var expiry = new Date(formName.expire_year.value,lastmonth - 1,lastday);
	if (formName.account.value == "") {
        var message = '<fmt:message key="NO_ACCOUNT_NUMBER" bundle="${edpText}"/>';
    	alert(message);
    } else if (now >= expiry) {
    	var message = now + ' > ' + expiry + '<fmt:message key="INVALID_EXPIRY_DATE" bundle="${edpText}"/>';
    	alert(message);
    } else {
    	ret = true;
    }
    return ret;
}
function BuildPolicyString() {
	var ret;
	if(checkInputParam(self.document.BidForm)==false)
		return false;
	var monthIndex = self.document.BidForm.expire_month.selectedIndex;
	var yearIndex = self.document.BidForm.expire_year.selectedIndex;

	var cNumber = self.document.BidForm.account.value;

	var cMonth = self.document.BidForm.expire_month.options[monthIndex].value

	var cYear = self.document.BidForm.expire_year.options[yearIndex].value;
	
	
	

	var billing_address_id_Index=self.document.BidForm.bidbillrfn.selectedIndex;
	var billing_address_id=self.document.BidForm.bidbillrfn[billing_address_id_Index].value;
	//ret = "policyId" + "=" + "<c:out value="${cardId}" />" + ";" + "cardBrand" + "=" + "<c:out value="${cardBrand}" />" + ";" + "account" + "=" + cNumber + ";" + "expire_month" + "=" + cMonth + ";" + "expire_year" + "=" + cYear;
	ret = "policyId" + "=" + "<c:out value="${cardId}" />" + ";" + "cardBrand" + "=" + "<c:out value="${cardBrand}" />"+";"+ "cc_brand" + "=" + "<c:out value="${cardBrand}" />" + ";" + "account" + "=" + cNumber + ";" + "expire_month" + "=" + cMonth + ";" + "expire_year" + "=" + cYear+";"+"billing_address_id"+"="+billing_address_id+";"+"payMethodId="+"VISA";				
	//alert(ret);
	return ret;
	}
function initPayInfo()
{
	var ctx;
		
	ctx= "<c:out value="${payInfo.cardNumber}" />";
	if(ctx==null || ctx == "null" || ctx.length==0) ctx="";
	self.document.BidForm.account.value = ctx;		
	self.document.BidForm.expire_month.selectedIndex = 0
	for(var i=0; i< self.document.BidForm.expire_month.length; i++) {
		if ( "<c:out value="${payInfo.cardExpiryMonth}" />"  == self.document.BidForm.expire_month.options[i].value) {
			self.document.BidForm.expire_month.selectedIndex = i
			break
		}
	} 

	self.document.BidForm.expire_year.selectedIndex = 0
	for(var i=0; i< self.document.BidForm.expire_year.length; i++) {
		if ( "<c:out value="${payInfo.cardExpiryYear}" />"  == self.document.BidForm.expire_year.options[i].value) {
			self.document.BidForm.expire_year.selectedIndex = i
			break
		}
	}
}
initPayInfo();
</script>
