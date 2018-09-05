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

var busy = false;
//
// ***
// * This javascript function is used by the 'Add to Shopcart' button.  Since the HTML form is shared by both 'Add to Shopcart' and 'Add to Wish List' button,
// * appropriate values are set using this javascript before the form is submitted.
// * The variable 'busy' is used to avoid submitting the same forms multiple times when users click the button more than once.
// ***
//

function Add2ShopCart(form)
{
       if (!busy) {
              busy = true;
              form.action="OrderItemAdd";
              if(form.forRegistry && form.forRegistry.value){
              	form.externalId.value=form.forRegistry.value;
              }
              form.URL.value='SetPendingOrder?URL=OrderCalculate?URL=OrderItemDisplay';
              form.submit();
       }
}

// This javascript function is used by the 'Add to Wish List' button to set appropriate values before the form is submitted
function Add2WishList(form)
{
       if (!busy) {
              busy = true;
              form.action="InterestItemAdd"
              form.URL.value='InterestItemDisplay'
              form.submit()
       }
}
