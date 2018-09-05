<%--
//********************************************************************
//*-------------------------------------------------------------------
//* Licensed Materials - Property of IBM
//*
//* WebSphere Commerce
//*
//* (c) Copyright IBM Corp. 2000, 2002
//*
//* US Government Users Restricted Rights - Use, duplication or
//* disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
//*
//*-------------------------------------------------------------------
//*
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>

<c:set var="cardId" value="${param.cardId}" />
<c:set var="cardDesc" value="${param.cardDesc}" />
<c:set var="cardName" value="${param.cardName}" />
<c:set var="cardBrand" value="${param.cardBrand}" />
<c:set var="paymentString" value="${param.paymentString}" />


<html>
<body>
<script>
function BuildPolicyString() {
	var ret;	

	ret = "policyId" + "=" + "<c:out value="${cardId}" />" + ";" + "cardBrand" + "=" + "<c:out value="${cardBrand}" />";		
//alert(ret);
	return ret;
	}
	
function CheckPayInfo(){
	return true;
}
function policyInit() {
}
</script>
			
	
			
</body>
</html> 
