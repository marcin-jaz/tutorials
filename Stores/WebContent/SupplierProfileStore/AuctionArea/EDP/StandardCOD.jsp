<%--
/*
 *-------------------------------------------------------------------
 * Licensed Materials - Property of IBM
 *
 * WebSphere Commerce
 *
 * (c) Copyright International Business Machines Corporation.
 *     2006
 *     All rights reserved.
 *
 * US Government Users Restricted Rights - Use, duplication or
 * disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
 *
 *-------------------------------------------------------------------
 */
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


<script>
function BuildPolicyString() {
	var ret;
	ret = "policyId" + "=" + "<c:out value="${cardId}" />" + ";" + "cardBrand" + "=" + "<c:out value="${cardBrand}" />" + ";" ;		
//alert(ret);
	return ret;
	}
</script>

