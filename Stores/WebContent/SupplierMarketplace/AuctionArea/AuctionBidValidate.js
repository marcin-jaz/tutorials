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


var FormSubmitted = 0
            
function CheckResubmitWithPayment() {
	if( !CheckParameters() ) {
		return false;
	}
	if( !policyCheck() ){
		return false;
	} 	

	if ( FormSubmitted == 1 ) {
		var msg = "<fmt:message key="BidSubmit_pleaseWaitMsg" bundle="${storeText}" />";
		alert(msg);
		return false;
	}
	
	FormSubmitted = 1;
	return true;
}

function CheckResubmit() {
	if( !CheckParameters() ) {
		return false;
	}
	
	if ( FormSubmitted == 1 ) {
		var msg = "<fmt:message key="BidSubmit_pleaseWaitMsg" bundle="${storeText}" />";
		alert(msg);
		return false;
	}
	
	FormSubmitted = 1;
	return true;
} 

function CheckParameters() {   
	var form1 = self.document.BidForm;
	var strippedInteger= null;
	var strippedBdPrice = null;
	var strippedMaxPrice =null;
	var bdquantexist = false;
	var bidvalueexist = false;
	var maxbidlimitexist = false;
	var isValid = false;
	
	//alert("begin CheckResubmit()  form1.elements.length:" + form1.elements.length);
	
	for (j=0; j<form1.elements.length; j++) {	
		elem = form1.elements[j];
		
		//if (isBlank(elem.value))       
		//{
		//continue;
		//}
		if (elem.name == "bidval" ) {         
			bidvalueexist = true;

			isValid = isValidCurrency(form1.bidval.value, "<c:out value="${currency}" />", "<c:out value="${langId}" />");
			//alert("isValid:" + isValid);
			if( isValid == true ) {
				strippedBdPrice =  currencyToNumber( form1.bidval.value,"<c:out value="${currency}" />", "<c:out value="${langId}" />");
				//alert("strippedBdPrice:" + strippedBdPrice);
			}
		
			if( isValid == false  || strippedBdPrice <= 0 || isInputStringEmpty( (elem.name).toString()) ) {
				var msg="<fmt:message key="AuctionBidValidate_bidValueMsg1" bundle="${storeText}" />";
				alert(msg);
				form1.bidval.focus()
				return false;
			} else {
				if( checkDigitsNum( strippedBdPrice ) == false ) {
					var msg="<fmt:message key="AuctionBidValidate_bidValueMsg2" bundle="${storeText}" />";
					alert(msg);
					form1.bidval.focus()
					return false;
				} else {
					//form1.bidvalue.value = strippedPrice;
				}
			} 
			//return false;
		} else if (elem.name == "bidquant") {                                                        
			//alert(" bidquant:" + form1.bidquant.value );
			bdquantexist = true;
			isValid  =  isValidInteger( form1.bidquant.value, "<c:out value="${langId}" />" );
			if( isValid == true ) {
				strippedInteger =  strToNumber( form1.bidquant.value, "<c:out value="${langId}" />" );
			}
			//alert("bidquant aInteger:" + aInteger + " strippedInteger:" + strippedInteger); 
			
			if( isValid == false || strippedInteger <= 0 || isInputStringEmpty( (elem.name).toString())) {
				var msg="<fmt:message key="AuctionBidValidate_quantityMsg1" bundle="${storeText}" />";
				alert(msg);
				form1.bidquant.focus()
				return false;
			} else {
            
            	//alert(" inventory_js:" + form1.inventory_js.value );
				if( strippedInteger > form1.inventory_js.value ) {
					var msg="<fmt:message key="AuctionBidValidate_quantityMsg3" bundle="${storeText}" />";							      
					alert(msg);
					form1.bidquant.focus()
					return false;
				} else {
				} 


			}

		} else if (elem.name == "maxbidlimit") {
		
			//alert("maxbidlimit:" + form1.maxbidlimit.value );
			
			maxbidlimitexist = true;
			isValid = isValidCurrency(form1.maxbidlimit.value, "<c:out value="${currency}" />", "<c:out value="${langId}" />");
			if( isValid == true ) {
				strippedMaxPrice =  currencyToNumber( form1.maxbidlimit.value,"<c:out value="${currency}" />", "<c:out value="${langId}" />");
			}
			//alert("maxbidlimit aPrice:" + aPrice + "strippedMaxPrice:" + strippedMaxPrice ); 
			
			if( isValid == false || strippedMaxPrice <= 0 || isInputStringEmpty( (elem.name).toString()) ) {
				var msg="<fmt:message key="AuctionBidValidate_autobidLimit1" bundle="${storeText}" />";
				alert(msg);
				form1.maxbidlimit.focus()
				return false;
			} else {
				if( checkDigitsNum( strippedMaxPrice ) == false ) {
					var msg="<fmt:message key="AuctionBidValidate_autobidLimit2" bundle="${storeText}" />";							      
					alert(msg);
					form1.maxbidlimit.focus()
					return false;
				} else if( bidvalueexist == true && strippedMaxPrice <= strippedBdPrice ) {
					var msg="<fmt:message key="AuctionBidValidate_autobidLimit3" bundle="${storeText}" />";							      
					alert(msg);
					form1.maxbidlimit.focus()
					return false;  
				} else {
					//form1.maxbidlimit.value = strippedPrice;
				}
			}
		}		
	}

	//After we are sure that everything is OK, we set values to be their stripped versions
	if( bdquantexist == true ) {
		form1.bidquant.value = strippedInteger;
	}
	if( bidvalueexist == true ) {
		form1.bidval.value = strippedBdPrice;
	}
	if( maxbidlimitexist == true ) {
		form1.maxbidlimit.value = strippedMaxPrice;
	}
   

	//----------------------------------------------
	// payment param checking for refresh and submit
	//----------------------------------------------
	if(form1.PolicyChange.selectedIndex == "<c:out value="${policyIndex}" />"){
		if(self.document.BidForm.bidauthflg.type == "checkbox"){ 
			if(self.document.BidForm.bidauthflg.checked != true) {
				var msg="<fmt:message key="_ERR_BID_DEPOSIT" bundle="${storeText}" />";
				alert(msg);
				self.document.BidForm.bidauthflg.focus();
				return false;
			}
		}
	} else {
    		if(form1.PolicyChange.selectedIndex==-1 || form1.PolicyChange.selectedIndex==1000) {

			var msg="<fmt:message key="_ERR_BID_PAYMENT_NOT_FOUND" bundle="${storeText}" />";							      
      		alert(msg);
			form1.PolicyChange.focus()
			return false;
   		} 		
	}


	return true;
	//return false;
}

function isBlank(str)  {
	if ((str != null) && (str != "")) {
		for (var i=0; i < str.length; i++) {
			var ch = str.charAt(i)
			if ((ch != ' ') && (ch != '\r') && (ch != '\n') && (ch != '\t')) {
				return false
			}
		}
	}
	
	return true
}

/**
 * This function will check whether the leftside of a particular number has  < 14 digits,
 * because this is required by db schema in auctions, e.g., BDVALUE in BIDTABLE has a format
 * NUM(15, 2)
 *
 * aNum is expected to be a stripped number which has no thousand-separator, e.g., 12345.67 or 
 * 12345,67
 **/
function checkDigitsNum( aNumber ) {
	//alert("checkDigitsNum( aNumber ) :" + aNumber);
	
	var aNum = new String(aNumber);
	var decimal_pos = -1;
	var leftSide;
	var segments;
	
	decimal_pos = aNum.indexOf(".");
	//alert("decimal_pos :" + decimal_pos);
   
	//Find a "."
	if (decimal_pos != -1 ) {
		segments = aNum.split(".");
		leftSide  = segments[0];
	} else {
		//Did not find ".", then try to find ","
		decimal_pos = aNum.indexOf(",");
		if (decimal_pos != -1 ) {
			segments = aNum.split(",");
			leftSide  = segments[0];
		} else {
			leftSide = aNum;
		}
	}
	//alert("leftSide :" + leftSide + "leftSide.length: "+ leftSide.length);
	//Make sure that the leftside of the number has < 14 digits
	if( leftSide.length > 15 ) {
		return false;
	} else {
		return true;
	} 
}

function ClearBidForm() {
	var form1 = self.document.BidForm;
	
	for (i=0; i<form1.elements.length; i++) {  
		elem = form1.elements[i];                       
		
		if ( (elem.name == "bidval" ) || (elem.name == "bidquant") ||
				(elem.name == "cardNumber") || (elem.name == "maxbidlimit") ) {       
			elem.value="";     
		
		} else if ( (elem.name == "bidquantflg") || (elem.name == "bidauthflg") ) {        
			elem.checked = false;                   
		} else if ( (elem.name == "cardBrand") || (elem.name == "cardExpiryMonth") 
				|| (elem.name == "bidshprfn" ) || (elem.name == "bidbillrfn") 
				|| (elem.name == "bidshpmod") ) {        
			elem.selectedIndex = 0;                   
		} else if (elem.name == "cardExpiryYear") {        
			elem.selectedIndex = 1;                   
		} else
			continue;
	}
	
	return(false);
}  

</script>
