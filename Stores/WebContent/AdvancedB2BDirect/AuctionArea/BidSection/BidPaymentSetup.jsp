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
//* IBM Confidential
//* OCO Source Materials
//*
//* The source code for this program is not published or otherwise
//* divested of its trade secrets, irrespective of what has been
//* deposited with the US Copyright Office.
//*--------------------------------------------------------------------------------------
//* The sample contained herein is provided to you "AS IS".
//*
//* It is furnished by IBM as a simple example and has not been thoroughly tested
//* under all conditions.  IBM, therefore, cannot guarantee its reliability, 
//* serviceability or functionality.  
//*
//* This sample may include the names of individuals, companies, brands and products 
//* in order to illustrate concepts as completely as possible.  All of these names
//* are fictitious and any similarity to the names and addresses used by actual persons 
//* or business enterprises is entirely coincidental.
//*--------------------------------------------------------------------------------------
//*-------------------------------------------------------------------
//*Purpose: auction payment information
//*-------------------------------------------------------------------
//*
--%>

<wcbase:useBean id="policyList" classname="com.ibm.commerce.payment.beans.PaymentPolicyListDataBean">
<c:set property="storeId" value="${storeId}"	target="${policyList}" />
</wcbase:useBean>
<c:set var="policyIndex" value="${WCParam.pIndexName}"/>
<c:set var="paymentPolicyString" value="${WCParam.paymentPolicyString}"/>
<c:set var="policyArray" value="${policyList.paymentPolicyInfoUsableWithoutTA}"/>

<c:if test="${! empty policyId and empty paymentPolicyString}">
	<c:forEach var="policy" items="${policyArray}" varStatus="aStatus">		
		<c:if test="${policy.policyId == policyId and policy.brand == brandName}">
			<c:set var="policyIndex" value="${aStatus.count}"/>
		</c:if>
	</c:forEach>
</c:if>  

<c:choose>

<c:when test="${!empty policyIndex and policyIndex ne '1000'}">
	<c:if test="${policyIndex > 0}">
		<c:set var="paymentPolicyDisplayName" value="${policyArray[policyIndex-1].attrPageName}"/>
		<c:set var="paymentCardDesc" value="${policyArray[policyIndex-1].longDescription}"/>
		<c:set var="paymentCardName" value="${policyArray[policyIndex-1].policyName}"/>
		<c:set var="paymentCardBrand" value="${policyArray[policyIndex-1].policyName}"/>
		<c:set var="paymentCardId" value="${policyArray[policyIndex-1].policyId}"/>
	</c:if>
	<c:if test="${policyIndex == 0}">
		<c:set var="paymentPolicyDisplayName" value=""/>
		<c:set var="paymentCardDesc" value=""/>
		<c:set var="paymentCardName" value=""/>
		<c:set var="paymentCardBrand" value=""/>
		<c:set var="paymentCardId" value=""/>
	</c:if>
</c:when>
<c:otherwise>	
	<c:set var="policyIndex" value="1000"/>
</c:otherwise>
</c:choose>
<c:if test="${! empty paymentPolicyDisplayName}">
	<c:set var="paymentPolicyDisplayName" value="${paymentPolicyDisplayName}.jsp"/>
</c:if>
