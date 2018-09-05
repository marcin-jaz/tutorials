<script language="JavaScript">

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
		
		<c:if test="${! empty ccnumber  &&  empty param.paymentPolicyString}">
			<c:set var="cc_number" value="${ccnumber}" />
			<c:set var="cc_year" value="${ccyear}" />
			<c:set var="cc_month" value="${ccmonth}" />
			
		</c:if>
		<c:if test="${!(! empty ccnumber  && empty param.paymentPolicyString)}">
			<c:set var="cc_number" value="${param.cardNumber}" />
			<c:set var="cc_year" value="${param.cardExpiryYear}" />
			<c:set var="cc_month" value="${param.cardExpiryMonth}" />
		</c:if>
	
	
	function getNVPsForPolicyIndexNoDup(index) {
		var aNvp = fetchBidFormNvps();// + "<%= request.getQueryString() %>";
		var equalSign = "=";
		var aIndexName = "pIndexName";
		var changed = aIndexName + equalSign + index;
//alert("getNVPsForPolicyIndexNoDup:" + aNvp + "  " + changed);
		return getNVPsNoDup(aNvp, changed);
	}
	function getNVPsNoDup(nvps, nvpChanged) {
		var ret = nvps;
		var andSign = "&";
		var pattern  = /pIndexName/i;
		if(pattern.test(nvps)) {
//alert("getNVPsNoDup:" + pattern);
			var matches0 = "&";
			var matches1 = "pIndexName";
			var j = nvps.length;
			var i = nvps.search(matches1);	
			var s1 = nvps.substr(0, i);  
			var s2 = nvps.substr(i, j);
			var swaping = andSign + nvpChanged + andSign;
			var k = s2.search(matches0);
			var l = s2.length;
			var s3 = s2.substr(k, l);
			ret = s1 + s3 + swaping;
//alert("getNVPsNoDup:" + s1 + "  " + s2 + "  " + s3 + "  " + ret);
		} else {
			ret = nvps + andSign + nvpChanged + andSign;
//alert("getNVPsNoDup-----:" + pattern);
		}
		return ret;
	}

	//------------------------------------------------------------------------------
	// when payment policy changed, this function is called to refresh the whole bidform page
	// to replace currennt payment input page with a new one.
	//------------------------------------------------------------------------------
	function getPolicy(){

		self.document.BidForm.resubmit.value = true;

		var selectedPolicyIndex = self.document.BidForm.PolicyChange.selectedIndex;
//alert(selectedPolicyIndex);		
		var switchere = "";
		var actionTaking = self.document.BidForm.PaymentPolicyChangeAction.value;
//alert(actionTaking);		
		if( selectedPolicyIndex != <c:out value="${policyIndex}" /> ) {	
			var s1 = actionTaking; //"<%= request.getServletPath().trim().substring(1) %>";
			var s3 = "?";
			var s6 = s1 + s3 + getNVPsForPolicyIndexNoDup(selectedPolicyIndex); 
//alert("s6==>" + s6);
			document.location.replace(s6);
			//document.location.reload();
		} else {
//alert("no changes!");
		}
	}                               

	function fetchBidFormNvps() {
		if(self.document.BidForm.bidquantflg.checked == true) {
			self.document.BidForm.bidquantflg.value = "On";
		} else {
			self.document.BidForm.bidquantflg.value = "Off";
		}
		
		if(self.document.BidForm.bidauthflg.type == "checkbox" && self.document.BidForm.bidauthflg.checked == true) {
			self.document.BidForm.bidauthflg.value = "On";
		} else if(self.document.BidForm.bidauthflg.type == "checkbox") {
			self.document.BidForm.bidauthflg.value = "Off";
		}
		
		var ret = "";
		var form1 = self.document.BidForm;
		for (i=0; i<form1.elements.length; i++) {	
			var elem = form1.elements[i];
			ret = ret + "&" + elem.name + "=" + elem.value;
		}
		return ret + "&";
	}

</script>
