<%--==========================================================================
Licensed Materials - Property of IBM

WebSphere Commerce

(c) Copyright IBM Corp.  2006
All Rights Reserved

US Government Users Restricted Rights - Use, duplication or
disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
===========================================================================--%>
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

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "DTD/xhtml1-transitional.dtd">
<html lang="en">
<body>
<script>
function BuildPolicyString() {
	var ret;	

	ret = "policyId" + "=" + "<c:out value="${cardId}" />" + ";" + "cardBrand" + "=" + "<c:out value="${cardBrand}" />"+ ";";		
//	alert("StandardCOD.jsp"); 	
// 	alert(ret);
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
