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

function Add2ShopCart(form)
{
       if (!busy) {
              busy = true;
              form.action="OrderItemAdd";
              if(form.forRegistry && form.forRegistry.value){
              	form.externalId.value=form.forRegistry.value;
              }
              form.URL.value='SetPendingOrder?URL=OrderCalculate?URL=OrderItemDisplay?partNumber*=&quantity*=';
              form.submit();
       }

}

function Add2WishList(form)
{
       if (!busy) {
              busy = true;
              form.action="InterestItemAdd";
              form.URL.value='InterestItemDisplay';
              form.submit();
       }
}
