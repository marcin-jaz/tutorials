//
//-------------------------------------------------------------------
// Licensed Materials - Property of IBM
//
// WebSphere Commerce
//
// (c) Copyright IBM Corp. 2006
//
// US Government Users Restricted Rights - Use, duplication or
// disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
//-------------------------------------------------------------------
//

//
// ***
// * This javascript function is used by the 'Add to Shopcart' button.  Since the HTML form is shared by both 'Add to Shopcart' and 'Add to Wish List' button,
// * appropriate values are set using this javascript before the form is submitted.
// * The variable 'busy' is used to avoid submitting the same forms multiple times when users click the button more than once.
// ***
//
var busy = false;
function Add2ShopCart(form, catEntryId, catEntryQuantity)
{
       if (!busy) {
              busy = true;
              form.action="OrderItemAdd";
              form.catEntryId.value = catEntryId;
              form.quantity.value = catEntryQuantity;
              form.errorViewName.value = "CatalogItemAddErrorView";
              form.URL.value='SetPendingOrder?item_quantity*=&contractId*=&URL=OrderCalculate?URL=OrderItemDisplay&updatePrices=1&calculationUsageId=-1&orderId=.';
              form.submit();
       }
}

function Add2RFQ(form) {
	if (form.Type[0].checked) {
		form.action="RFQCreateDisplay?endresult=0";
	} else 	{
		form.action="AddToExistRFQListDisplay?isContract=Y";
	}
	form.submit();		
}
