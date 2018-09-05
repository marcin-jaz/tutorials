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
  *    The file path of this snippet is Snippets/EDP/PaymentMethods/StandardCheck.jsp
  * 2. To display this feature in your store's xxx page, cut and paste the code from the
  *    snippet to your xxx page ... (list all the steps)
  * 3. To test this out, copy the Directory /Snippets/ from /WC_installDir/samples/ to 
  *         /WAS_installDir/installedApps/instance_name/WC_instance.ear/Stores.war/Store_Dir/
  * 4. Include this page into the store xxx page. 
  *     For example: add the following code into /ShoppingArea/CatalogSection/CategorySubsection/SubCategoriesDisplay.jsp
  * 		<c:import url="${jspStoreDir}Snippets/EDP/PaymentMethods/StandardCheck.jsp" />    
  * 
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

<c:set var="payInfo" value="${helperBean.payInfoObject}"/>
<table cellpadding="3" cellspacing="0" border="0" id="StandardACH_Table_1">
	<tr>
		<td colspan="4" valign="middle"  id="StandardACH_TableCell_11">
			<label for ="StandardACH_InputText_1"><span class="required">*</span><strong><fmt:message key="EDPPaymentMethods_BANK_ROUTING_NO" bundle="${edpText}"  /></strong></label>
			
		</td>
		<td colspan="4" valign="middle" id="StandardACH_TableCell_12">
			<input type="text" name = "checkRoutingNumber" value ="" value ="<c:out value="${edp_ProtocolData.checkAccountNumber}" />" id="StandardACH_InputText_1" />
		</td>

	</tr>
	<tr>
		<td colspan="4" valign="middle" id="StandardACH_TableCell_21">
			<label for="StandardACH_InputText_2"><span class="required">*</span><strong><fmt:message key="EDPPaymentMethods_BANK_ACCOUNT_NO" bundle="${edpText}"  /></strong></label>
		</td>
		<td colspan="4" valign="middle" id="StandardACH_TableCell_22">
			<input type="text" name = "checkAccountNumber" value ="" id="StandardACH_InputText_2" />
		</td>

	</tr>
	
	
</table>

<script language="javascript">
<%--
*********************** 
1. This function is triggered by the Update button to submit the order
2. It submits the details to the form in which paymentMethods list box is included
***********************
--%>

function checkInputParam(formName)
{
	var ret = false;
	if (formName.checkAccountNumber.value == "") {
        var message = '<fmt:message key="EDPPaymentMethods_NO_ACCOUNT_NUMBER" bundle="${edpText}"/>';
    	alert(message);
    } else if (formName.checkRoutingNumber.value == "") {
        var message = '<fmt:message key="EDPPaymentMethods_NO_ROUTING_NUMBER" bundle="${edpText}"/>';
    	alert(message);
    } else {
    	ret=true;
	}
	return ret;
}
function BuildPolicyString() {
	var ret;
	if(checkInputParam(BidForm)==false)
		return false;
	

	var cAccount = self.document.BidForm.checkAccountNumber.value;

	var cRouting = self.document.BidForm.checkRoutingNumber.value

	
	

	ret = "policyId" + "=" + "<c:out value="${cardId}" />" + ";" + "cardBrand" + "=" + "<c:out value="${cardBrand}" />" + ";" + "checkAccountNumber" + "=" + cAccount + ";" + "checkRoutingNumber" + "=" + cRouting ;		
//alert(ret);
	return ret;
	}
function initPayInfo()
{
	var ctx;
		
	
	
}
initPayInfo();
</script>

